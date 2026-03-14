# SQL Command Categories - Complete Reference Guide

A comprehensive guide to the 5 main categories of SQL commands: DDL, DML, DQL, DCL, and TCL.

---

## 📋 Table of Contents
1. [DDL - Data Definition Language](#1-ddl---data-definition-language)
2. [DML - Data Manipulation Language](#2-dml---data-manipulation-language)
3. [DQL - Data Query Language](#3-dql---data-query-language)
4. [DCL - Data Control Language](#4-dcl---data-control-language)
5. [TCL - Transaction Control Language](#5-tcl---transaction-control-language)
6. [Quick Comparison Table](#quick-comparison-table)
7. [Real-World Examples](#real-world-examples)
8. [SQL Constraints](#-sql-constraints)
9. [SQL Data Types](#-sql-data-types)

---

## 1. DDL - Data Definition Language

**Purpose:** Define and modify database structure/schema

### Commands
- `CREATE` - Create database objects (tables, indexes, views)
- `ALTER` - Modify existing database objects
- `DROP` - Delete database objects
- `TRUNCATE` - Remove all records from table (structure remains)
- `RENAME` - Rename database objects

### Examples

#### CREATE
```sql
-- Create database
CREATE DATABASE company_db;

-- Create table
CREATE TABLE employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    hire_date DATE,
    salary DECIMAL(10,2),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(dept_id)
);

-- Create index
CREATE INDEX idx_employee_name ON employees(last_name, first_name);

-- Create view
CREATE VIEW employee_details AS
SELECT e.employee_id, e.first_name, e.last_name, d.dept_name
FROM employees e
JOIN departments d ON e.department_id = d.dept_id;
```

#### ALTER
```sql
-- Add column
ALTER TABLE employees 
ADD COLUMN phone_number VARCHAR(15);

-- Modify column
ALTER TABLE employees 
MODIFY COLUMN salary DECIMAL(12,2);

-- Drop column
ALTER TABLE employees 
DROP COLUMN phone_number;

-- Add constraint
ALTER TABLE employees
ADD CONSTRAINT chk_salary CHECK (salary > 0);

-- Rename column (MySQL 8.0+)
ALTER TABLE employees 
RENAME COLUMN first_name TO fname;
```

#### DROP
```sql
-- Drop table
DROP TABLE employees;

-- Drop database
DROP DATABASE company_db;

-- Drop index
DROP INDEX idx_employee_name ON employees;

-- Drop view
DROP VIEW employee_details;

-- Drop with cascade (PostgreSQL)
DROP TABLE employees CASCADE;
```

#### TRUNCATE
```sql
-- Remove all data but keep structure
TRUNCATE TABLE employees;

-- Faster than DELETE, resets auto-increment
TRUNCATE TABLE logs;
```

#### RENAME
```sql
-- Rename table
RENAME TABLE employees TO staff;

-- MySQL specific
ALTER TABLE employees RENAME TO staff;
```

### Characteristics
- ✅ **Auto-commit**: Changes are permanent immediately
- ❌ **Cannot be rolled back**: No UNDO option
- 🔧 **Affects structure**: Modifies database schema
- ⚡ **Fast execution**: Direct structural changes

---

## 2. DML - Data Manipulation Language

**Purpose:** Manipulate data within tables

### Commands
- `INSERT` - Add new records
- `UPDATE` - Modify existing records
- `DELETE` - Remove records
- `MERGE` - Insert or update (upsert operation)

### Examples

#### INSERT
```sql
-- Insert single row
INSERT INTO employees (first_name, last_name, email, hire_date, salary, department_id)
VALUES ('John', 'Doe', 'john.doe@company.com', '2024-01-15', 55000.00, 1);

-- Insert multiple rows
INSERT INTO employees (first_name, last_name, email, hire_date, salary, department_id)
VALUES 
    ('Jane', 'Smith', 'jane.smith@company.com', '2024-02-01', 60000.00, 2),
    ('Bob', 'Johnson', 'bob.j@company.com', '2024-02-15', 58000.00, 1),
    ('Alice', 'Williams', 'alice.w@company.com', '2024-03-01', 62000.00, 3);

-- Insert from SELECT
INSERT INTO archived_employees
SELECT * FROM employees WHERE hire_date < '2020-01-01';

-- Insert with default values
INSERT INTO employees (first_name, last_name) 
VALUES ('New', 'Employee');
```

#### UPDATE
```sql
-- Update single column
UPDATE employees 
SET salary = 60000 
WHERE employee_id = 1;

-- Update multiple columns
UPDATE employees 
SET salary = salary * 1.10, 
    last_updated = CURRENT_TIMESTAMP
WHERE department_id = 2;

-- Update with JOIN (MySQL)
UPDATE employees e
JOIN departments d ON e.department_id = d.dept_id
SET e.salary = e.salary * 1.15
WHERE d.dept_name = 'Engineering';

-- Update all rows (be careful!)
UPDATE employees 
SET active = 1;

-- Conditional update
UPDATE employees
SET bonus = CASE
    WHEN salary > 70000 THEN salary * 0.15
    WHEN salary > 50000 THEN salary * 0.10
    ELSE salary * 0.05
END;
```

#### DELETE
```sql
-- Delete specific rows
DELETE FROM employees 
WHERE employee_id = 5;

-- Delete with condition
DELETE FROM employees 
WHERE hire_date < '2020-01-01' AND active = 0;

-- Delete all rows (can be rolled back unlike TRUNCATE)
DELETE FROM temp_table;

-- Delete with JOIN (MySQL)
DELETE e 
FROM employees e
JOIN departments d ON e.department_id = d.dept_id
WHERE d.dept_name = 'Closed Department';

-- Delete top N rows (SQL Server)
DELETE TOP (10) FROM logs WHERE processed = 1;
```

#### MERGE (Upsert)
```sql
-- MySQL UPSERT using INSERT...ON DUPLICATE KEY UPDATE
INSERT INTO employees (employee_id, first_name, last_name, salary)
VALUES (1, 'John', 'Doe', 60000)
ON DUPLICATE KEY UPDATE 
    first_name = VALUES(first_name),
    last_name = VALUES(last_name),
    salary = VALUES(salary);

-- PostgreSQL UPSERT
INSERT INTO employees (employee_id, first_name, last_name, salary)
VALUES (1, 'John', 'Doe', 60000)
ON CONFLICT (employee_id) 
DO UPDATE SET 
    first_name = EXCLUDED.first_name,
    last_name = EXCLUDED.last_name,
    salary = EXCLUDED.salary;

-- SQL Server MERGE
MERGE INTO employees AS target
USING new_employees AS source
ON target.employee_id = source.employee_id
WHEN MATCHED THEN 
    UPDATE SET 
        target.salary = source.salary,
        target.department_id = source.department_id
WHEN NOT MATCHED THEN
    INSERT (employee_id, first_name, last_name, salary)
    VALUES (source.employee_id, source.first_name, source.last_name, source.salary);
```

### Characteristics
- 🔄 **Can be rolled back**: Within transactions
- 💾 **Affects data**: Not structure
- 📊 **Most frequent**: Used in daily operations
- ⚠️ **Use WHERE carefully**: Avoid accidental mass updates/deletes

---

## 3. DQL - Data Query Language

**Purpose:** Retrieve data from database (Read operations)

### Command
- `SELECT` - Query and retrieve data

### Examples

#### Basic SELECT
```sql
-- Select all columns
SELECT * FROM employees;

-- Select specific columns
SELECT first_name, last_name, salary FROM employees;

-- Select with alias
SELECT first_name AS fname, 
       last_name AS lname,
       salary * 12 AS annual_salary
FROM employees;

-- Select distinct values
SELECT DISTINCT department_id FROM employees;
```

#### WHERE Clause (Filtering)
```sql
-- Basic conditions
SELECT * FROM employees WHERE salary > 60000;

-- Multiple conditions
SELECT * FROM employees 
WHERE salary > 50000 AND department_id = 2;

-- OR condition
SELECT * FROM employees 
WHERE department_id = 1 OR department_id = 3;

-- IN operator
SELECT * FROM employees 
WHERE department_id IN (1, 2, 3);

-- BETWEEN
SELECT * FROM employees 
WHERE salary BETWEEN 50000 AND 70000;

-- LIKE pattern matching
SELECT * FROM employees 
WHERE last_name LIKE 'S%';

-- NULL checking
SELECT * FROM employees 
WHERE manager_id IS NULL;

-- NOT NULL
SELECT * FROM employees 
WHERE email IS NOT NULL;
```

#### Sorting (ORDER BY)
```sql
-- Sort ascending
SELECT * FROM employees ORDER BY salary;

-- Sort descending
SELECT * FROM employees ORDER BY salary DESC;

-- Multiple column sort
SELECT * FROM employees 
ORDER BY department_id ASC, salary DESC;
```

#### LIMIT / TOP
```sql
-- MySQL / PostgreSQL
SELECT * FROM employees ORDER BY salary DESC LIMIT 10;

-- SQL Server
SELECT TOP 10 * FROM employees ORDER BY salary DESC;

-- Skip and limit (pagination)
SELECT * FROM employees ORDER BY employee_id LIMIT 10 OFFSET 20;
```

#### Aggregation Functions
```sql
-- COUNT
SELECT COUNT(*) FROM employees;
SELECT COUNT(DISTINCT department_id) FROM employees;

-- SUM
SELECT SUM(salary) AS total_payroll FROM employees;

-- AVG
SELECT AVG(salary) AS average_salary FROM employees;

-- MIN / MAX
SELECT MIN(salary) AS lowest, MAX(salary) AS highest FROM employees;

-- GROUP BY
SELECT department_id, COUNT(*) AS emp_count, AVG(salary) AS avg_salary
FROM employees
GROUP BY department_id;

-- HAVING (filter aggregated results)
SELECT department_id, AVG(salary) AS avg_salary
FROM employees
GROUP BY department_id
HAVING AVG(salary) > 60000;
```

#### JOINs
```sql
-- INNER JOIN
SELECT e.first_name, e.last_name, d.dept_name
FROM employees e
INNER JOIN departments d ON e.department_id = d.dept_id;

-- LEFT JOIN
SELECT e.first_name, e.last_name, d.dept_name
FROM employees e
LEFT JOIN departments d ON e.department_id = d.dept_id;

-- RIGHT JOIN
SELECT e.first_name, e.last_name, d.dept_name
FROM employees e
RIGHT JOIN departments d ON e.department_id = d.dept_id;

-- FULL OUTER JOIN (PostgreSQL)
SELECT e.first_name, e.last_name, d.dept_name
FROM employees e
FULL OUTER JOIN departments d ON e.department_id = d.dept_id;

-- CROSS JOIN
SELECT e.first_name, p.project_name
FROM employees e
CROSS JOIN projects p;

-- Self JOIN
SELECT e1.first_name AS employee, e2.first_name AS manager
FROM employees e1
LEFT JOIN employees e2 ON e1.manager_id = e2.employee_id;
```

#### Subqueries
```sql
-- Subquery in WHERE
SELECT * FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

-- Subquery in FROM
SELECT dept_id, avg_salary
FROM (
    SELECT department_id AS dept_id, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department_id
) AS dept_stats
WHERE avg_salary > 60000;

-- Correlated subquery
SELECT e1.first_name, e1.salary
FROM employees e1
WHERE salary > (
    SELECT AVG(salary) 
    FROM employees e2 
    WHERE e2.department_id = e1.department_id
);
```

#### Window Functions
```sql
-- ROW_NUMBER
SELECT first_name, last_name, salary,
       ROW_NUMBER() OVER (ORDER BY salary DESC) AS salary_rank
FROM employees;

-- RANK
SELECT first_name, department_id, salary,
       RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS dept_rank
FROM employees;

-- DENSE_RANK
SELECT first_name, salary,
       DENSE_RANK() OVER (ORDER BY salary DESC) AS dense_rank
FROM employees;

-- Running total
SELECT first_name, salary,
       SUM(salary) OVER (ORDER BY employee_id) AS running_total
FROM employees;
```

#### Common Table Expressions (CTEs)
```sql
-- Simple CTE
WITH high_earners AS (
    SELECT * FROM employees WHERE salary > 70000
)
SELECT * FROM high_earners WHERE department_id = 2;

-- Multiple CTEs
WITH 
dept_stats AS (
    SELECT department_id, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department_id
),
high_paying_depts AS (
    SELECT department_id
    FROM dept_stats
    WHERE avg_salary > 60000
)
SELECT e.*
FROM employees e
JOIN high_paying_depts hpd ON e.department_id = hpd.department_id;

-- Recursive CTE (organizational hierarchy)
WITH RECURSIVE employee_hierarchy AS (
    -- Base case
    SELECT employee_id, first_name, manager_id, 1 AS level
    FROM employees
    WHERE manager_id IS NULL
    
    UNION ALL
    
    -- Recursive case
    SELECT e.employee_id, e.first_name, e.manager_id, eh.level + 1
    FROM employees e
    JOIN employee_hierarchy eh ON e.manager_id = eh.employee_id
)
SELECT * FROM employee_hierarchy;
```

### Characteristics
- 📖 **Read-only**: No data modification
- 🔍 **Most common**: Used constantly
- ⚡ **Performance matters**: Optimize with indexes
- 💡 **Flexible**: Combine with various clauses

---

## 4. DCL - Data Control Language

**Purpose:** Control access permissions and security

### Commands
- `GRANT` - Give user access privileges
- `REVOKE` - Remove user access privileges

### Examples

#### GRANT
```sql
-- Grant SELECT permission on specific table
GRANT SELECT ON employees TO 'analyst_user'@'localhost';

-- Grant multiple permissions
GRANT SELECT, INSERT, UPDATE ON employees TO 'data_entry'@'localhost';

-- Grant all privileges on a database
GRANT ALL PRIVILEGES ON company_db.* TO 'admin_user'@'localhost';

-- Grant specific columns
GRANT SELECT (first_name, last_name, email) ON employees TO 'hr_user'@'localhost';

-- Grant with GRANT option (user can grant to others)
GRANT SELECT, INSERT ON employees TO 'power_user'@'localhost' WITH GRANT OPTION;

-- Grant to role (PostgreSQL)
GRANT SELECT, INSERT, UPDATE ON employees TO analyst_role;
GRANT analyst_role TO user1, user2;

-- Grant execute on stored procedure
GRANT EXECUTE ON PROCEDURE calculate_bonus TO 'finance_user'@'localhost';
```

#### REVOKE
```sql
-- Revoke SELECT permission
REVOKE SELECT ON employees FROM 'analyst_user'@'localhost';

-- Revoke multiple permissions
REVOKE INSERT, UPDATE ON employees FROM 'data_entry'@'localhost';

-- Revoke all privileges
REVOKE ALL PRIVILEGES ON company_db.* FROM 'admin_user'@'localhost';

-- Revoke grant option
REVOKE GRANT OPTION ON employees FROM 'power_user'@'localhost';

-- Revoke from role
REVOKE analyst_role FROM user1;
```

#### User Management
```sql
-- Create user
CREATE USER 'new_user'@'localhost' IDENTIFIED BY 'password123';

-- Change password
ALTER USER 'new_user'@'localhost' IDENTIFIED BY 'new_password456';

-- Drop user
DROP USER 'old_user'@'localhost';

-- Show grants
SHOW GRANTS FOR 'analyst_user'@'localhost';

-- Flush privileges (reload grant tables)
FLUSH PRIVILEGES;
```

### Permission Types

| Permission | Description |
|------------|-------------|
| `SELECT` | Read data from tables |
| `INSERT` | Add new rows to tables |
| `UPDATE` | Modify existing rows |
| `DELETE` | Remove rows from tables |
| `CREATE` | Create new tables/databases |
| `DROP` | Delete tables/databases |
| `ALTER` | Modify table structure |
| `INDEX` | Create/drop indexes |
| `EXECUTE` | Run stored procedures |
| `ALL PRIVILEGES` | All permissions |

### Characteristics
- 🔒 **Security focused**: Controls database access
- 👤 **User management**: Admin operations
- 🛡️ **Principle of least privilege**: Grant minimum needed
- ⚠️ **Admin only**: Requires elevated permissions

---

## 5. TCL - Transaction Control Language

**Purpose:** Manage transactions and maintain data integrity

### Commands
- `BEGIN / START TRANSACTION` - Start a transaction
- `COMMIT` - Save transaction changes permanently
- `ROLLBACK` - Undo transaction changes
- `SAVEPOINT` - Create a point to rollback to
- `SET TRANSACTION` - Set transaction properties

### Examples

#### Basic Transaction
```sql
-- Start transaction
START TRANSACTION;
-- or
BEGIN;

-- Perform operations
INSERT INTO accounts (account_id, balance) VALUES (1, 1000);
INSERT INTO accounts (account_id, balance) VALUES (2, 2000);

-- Save changes
COMMIT;
```

#### Rollback Transaction
```sql
START TRANSACTION;

UPDATE accounts SET balance = balance - 500 WHERE account_id = 1;
UPDATE accounts SET balance = balance + 500 WHERE account_id = 2;

-- Something went wrong, undo everything
ROLLBACK;
```

#### Savepoints
```sql
START TRANSACTION;

-- Operation 1
INSERT INTO orders (order_id, customer_id) VALUES (1, 100);
SAVEPOINT after_order;

-- Operation 2
INSERT INTO order_items (order_id, product_id, quantity) VALUES (1, 201, 5);
SAVEPOINT after_items;

-- Operation 3 - error occurred
INSERT INTO payments (order_id, amount) VALUES (1, -100);  -- Invalid

-- Rollback to specific savepoint
ROLLBACK TO SAVEPOINT after_items;

-- Continue with corrected operation
INSERT INTO payments (order_id, amount) VALUES (1, 100);

-- Commit everything
COMMIT;
```

#### Money Transfer Example
```sql
START TRANSACTION;

-- Deduct from sender
UPDATE accounts 
SET balance = balance - 1000 
WHERE account_id = 1 AND balance >= 1000;

-- Check if deduction succeeded
IF (ROW_COUNT() = 0) THEN
    ROLLBACK;
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insufficient funds';
END IF;

-- Add to receiver
UPDATE accounts 
SET balance = balance + 1000 
WHERE account_id = 2;

-- Record transaction
INSERT INTO transactions (from_account, to_account, amount, trans_date)
VALUES (1, 2, 1000, NOW());

-- Everything succeeded
COMMIT;
```

#### Transaction Isolation Levels
```sql
-- Read Uncommitted (lowest isolation)
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

-- Read Committed (default in most databases)
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

-- Repeatable Read (default in MySQL)
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- Serializable (highest isolation)
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

START TRANSACTION;
-- Your queries here
COMMIT;
```

#### Transaction Properties
```sql
-- Set transaction as read-only
SET TRANSACTION READ ONLY;

-- Set transaction as read-write
SET TRANSACTION READ WRITE;

-- Combine isolation level and access mode
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE READ ONLY;
```

### ACID Properties

| Property | Description | How TCL Helps |
|----------|-------------|---------------|
| **Atomicity** | All or nothing | COMMIT/ROLLBACK ensure complete success or failure |
| **Consistency** | Valid state transitions | Constraints enforced within transactions |
| **Isolation** | Concurrent transaction independence | Isolation levels prevent interference |
| **Durability** | Permanent after commit | COMMIT guarantees persistence |

### Common Transaction Patterns

#### Pattern 1: Try-Catch-Rollback
```sql
START TRANSACTION;

-- Try operations
BEGIN
    UPDATE inventory SET quantity = quantity - 10 WHERE product_id = 1;
    INSERT INTO sales (product_id, quantity) VALUES (1, 10);
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
```

#### Pattern 2: Batch Processing
```sql
START TRANSACTION;

-- Process batch of records
UPDATE orders SET status = 'processed' WHERE status = 'pending' LIMIT 1000;

-- Commit in batches to avoid long locks
COMMIT;
```

#### Pattern 3: Multi-Step Operation
```sql
START TRANSACTION;

-- Step 1: Create order
INSERT INTO orders (customer_id, order_date) VALUES (100, NOW());
SET @order_id = LAST_INSERT_ID();

-- Step 2: Add items
INSERT INTO order_items (order_id, product_id, quantity)
VALUES 
    (@order_id, 1, 2),
    (@order_id, 2, 1);

-- Step 3: Update inventory
UPDATE products SET stock = stock - 2 WHERE product_id = 1;
UPDATE products SET stock = stock - 1 WHERE product_id = 2;

-- Step 4: Record payment
INSERT INTO payments (order_id, amount, payment_date)
VALUES (@order_id, 299.99, NOW());

COMMIT;
```

### Characteristics
- 🔄 **Reversible**: Can undo operations
- 🎯 **ACID compliance**: Ensures data integrity
- 🔒 **Locking**: May lock rows/tables
- ⚡ **Performance impact**: Keep transactions short

---

## 📊 Quick Comparison Table

| Category | Purpose | Auto-Commit | Rollback | Common Commands | Use Case |
|----------|---------|-------------|----------|-----------------|----------|
| **DDL** | Define structure | ✅ Yes | ❌ No | CREATE, ALTER, DROP, TRUNCATE | Schema design |
| **DML** | Manipulate data | ❌ No | ✅ Yes | INSERT, UPDATE, DELETE | Daily operations |
| **DQL** | Query data | N/A | N/A | SELECT | Reports, analysis |
| **DCL** | Control access | ✅ Yes | ❌ No | GRANT, REVOKE | Security |
| **TCL** | Manage transactions | ❌ No | ✅ Yes | COMMIT, ROLLBACK | Data integrity |

---

## 🎯 Real-World Examples

### Example 1: E-commerce Order Processing
```sql
-- Complete order processing with transaction
START TRANSACTION;

-- 1. Create order (DML)
INSERT INTO orders (customer_id, order_date, total_amount) 
VALUES (12345, NOW(), 299.99);
SET @order_id = LAST_INSERT_ID();

-- 2. Add order items (DML)
INSERT INTO order_items (order_id, product_id, quantity, price)
VALUES 
    (@order_id, 101, 2, 99.99),
    (@order_id, 205, 1, 100.00);

-- 3. Update inventory (DML)
UPDATE products SET stock_quantity = stock_quantity - 2 WHERE product_id = 101;
UPDATE products SET stock_quantity = stock_quantity - 1 WHERE product_id = 205;

-- 4. Process payment (DML)
INSERT INTO payments (order_id, payment_method, amount, status)
VALUES (@order_id, 'credit_card', 299.99, 'completed');

-- 5. Send to shipping queue (DML)
INSERT INTO shipping_queue (order_id, status, created_at)
VALUES (@order_id, 'pending', NOW());

-- All operations succeeded - commit (TCL)
COMMIT;

-- 6. Query order details (DQL)
SELECT o.order_id, o.order_date, c.customer_name, p.payment_status
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN payments p ON o.order_id = p.order_id
WHERE o.order_id = @order_id;
```

### Example 2: Data Warehouse ETL Pipeline
```sql
-- 1. Create staging table (DDL)
CREATE TABLE staging_sales (
    sale_id INT,
    product_name VARCHAR(100),
    sale_amount DECIMAL(10,2),
    sale_date DATE,
    loaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Load data into staging (DML)
START TRANSACTION;

INSERT INTO staging_sales (sale_id, product_name, sale_amount, sale_date)
SELECT sale_id, product_name, sale_amount, sale_date
FROM external_sales_source
WHERE sale_date = CURRENT_DATE - INTERVAL 1 DAY;

COMMIT;

-- 3. Transform and load to warehouse (DML + DQL)
START TRANSACTION;

INSERT INTO fact_sales (product_key, time_key, customer_key, amount)
SELECT 
    dp.product_key,
    dt.time_key,
    dc.customer_key,
    ss.sale_amount
FROM staging_sales ss
JOIN dim_product dp ON ss.product_name = dp.product_name
JOIN dim_time dt ON ss.sale_date = dt.date
JOIN dim_customer dc ON ss.customer_id = dc.customer_id;

COMMIT;

-- 4. Archive processed data (DDL + DML)
CREATE TABLE archive_sales_2024_03 LIKE staging_sales;

INSERT INTO archive_sales_2024_03 
SELECT * FROM staging_sales 
WHERE sale_date BETWEEN '2024-03-01' AND '2024-03-31';

-- 5. Clean staging (DML)
TRUNCATE TABLE staging_sales;

-- 6. Generate report (DQL)
SELECT 
    DATE_FORMAT(sale_date, '%Y-%m') AS month,
    COUNT(*) AS total_sales,
    SUM(amount) AS total_revenue,
    AVG(amount) AS avg_sale
FROM fact_sales
WHERE sale_date >= DATE_SUB(CURRENT_DATE, INTERVAL 3 MONTH)
GROUP BY DATE_FORMAT(sale_date, '%Y-%m')
ORDER BY month DESC;
```

### Example 3: User Management System
```sql
-- 1. Create user schema (DDL)
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE user_roles (
    user_id INT,
    role_name VARCHAR(50),
    granted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, role_name),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- 2. Create database users and grant permissions (DCL)
CREATE USER 'app_user'@'localhost' IDENTIFIED BY 'secure_password';
GRANT SELECT, INSERT, UPDATE ON company_db.users TO 'app_user'@'localhost';
GRANT SELECT ON company_db.user_roles TO 'app_user'@'localhost';

CREATE USER 'admin_user'@'localhost' IDENTIFIED BY 'admin_password';
GRANT ALL PRIVILEGES ON company_db.* TO 'admin_user'@'localhost';

-- 3. Register new user with roles (DML + TCL)
START TRANSACTION;

INSERT INTO users (username, email) 
VALUES ('john_doe', 'john.doe@example.com');
SET @new_user_id = LAST_INSERT_ID();

INSERT INTO user_roles (user_id, role_name)
VALUES 
    (@new_user_id, 'employee'),
    (@new_user_id, 'reader');

COMMIT;

-- 4. Query user permissions (DQL)
SELECT u.username, u.email, r.role_name, r.granted_at
FROM users u
LEFT JOIN user_roles r ON u.user_id = r.user_id
WHERE u.username = 'john_doe';

-- 5. Update user role (DML + TCL)
START TRANSACTION;

DELETE FROM user_roles WHERE user_id = @new_user_id AND role_name = 'reader';
INSERT INTO user_roles (user_id, role_name) VALUES (@new_user_id, 'admin');

COMMIT;

-- 6. Audit log (DQL)
SELECT * FROM user_roles 
WHERE user_id = @new_user_id 
ORDER BY granted_at DESC;
```

### Example 4: Banking System
```sql
-- 1. Schema setup (DDL)
CREATE TABLE accounts (
    account_id INT PRIMARY KEY,
    account_holder VARCHAR(100),
    balance DECIMAL(15,2) CHECK (balance >= 0),
    account_type VARCHAR(20)
);

CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    from_account INT,
    to_account INT,
    amount DECIMAL(15,2),
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20)
);

-- 2. Initial data (DML)
INSERT INTO accounts VALUES 
    (1001, 'Alice Johnson', 5000.00, 'savings'),
    (1002, 'Bob Smith', 3000.00, 'checking');

-- 3. Money transfer with full transaction control (TCL + DML)
START TRANSACTION;

-- Save initial state
SAVEPOINT before_transfer;

-- Deduct from sender
UPDATE accounts 
SET balance = balance - 1000.00 
WHERE account_id = 1001 AND balance >= 1000.00;

-- Check if sufficient funds
IF (SELECT ROW_COUNT()) = 0 THEN
    ROLLBACK TO SAVEPOINT before_transfer;
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insufficient funds';
END IF;

-- Add to receiver
UPDATE accounts 
SET balance = balance + 1000.00 
WHERE account_id = 1002;

-- Log transaction
INSERT INTO transactions (from_account, to_account, amount, status)
VALUES (1001, 1002, 1000.00, 'completed');

-- Commit if all operations succeeded
COMMIT;

-- 4. Query account statement (DQL)
SELECT 
    t.transaction_date,
    CASE 
        WHEN t.from_account = 1001 THEN 'Debit'
        WHEN t.to_account = 1001 THEN 'Credit'
    END AS type,
    t.amount,
    (SELECT balance FROM accounts WHERE account_id = 1001) AS current_balance
FROM transactions t
WHERE t.from_account = 1001 OR t.to_account = 1001
ORDER BY t.transaction_date DESC
LIMIT 10;

-- 5. Database security (DCL)
CREATE USER 'teller'@'localhost' IDENTIFIED BY 'teller_pass';
GRANT SELECT, INSERT ON bank_db.transactions TO 'teller'@'localhost';
GRANT SELECT, UPDATE ON bank_db.accounts TO 'teller'@'localhost';

CREATE USER 'auditor'@'localhost' IDENTIFIED BY 'auditor_pass';
GRANT SELECT ON bank_db.* TO 'auditor'@'localhost';
```

---

## 💡 Best Practices

### DDL Best Practices
1. ✅ Always backup before schema changes
2. ✅ Use `CREATE TABLE IF NOT EXISTS`
3. ✅ Define constraints during table creation
4. ✅ Document schema changes
5. ✅ Test DDL in development first

### DML Best Practices
1. ✅ Always use WHERE in UPDATE/DELETE
2. ✅ Use transactions for multiple operations
3. ✅ Validate data before INSERT
4. ✅ Use batch operations for bulk data
5. ✅ Test on small datasets first

### DQL Best Practices
1. ✅ Select only needed columns
2. ✅ Use indexes for WHERE/JOIN columns
3. ✅ Avoid SELECT * in production
4. ✅ Use EXPLAIN to analyze queries
5. ✅ Limit large result sets

### DCL Best Practices
1. ✅ Follow principle of least privilege
2. ✅ Regular audit of user permissions
3. ✅ Use roles instead of direct grants
4. ✅ Strong password policies
5. ✅ Revoke unused permissions

### TCL Best Practices
1. ✅ Keep transactions short
2. ✅ Use appropriate isolation levels
3. ✅ Handle errors with ROLLBACK
4. ✅ Always COMMIT or ROLLBACK
5. ✅ Use SAVEPOINT for complex operations

---

## 📚 Learning Path for TuteDude Course

### Modules 4-5: Foundation
- **Focus**: DML basics (INSERT, UPDATE, DELETE)
- **Focus**: DQL basics (SELECT, WHERE, ORDER BY)

### Modules 6-7: Intermediate
- **Focus**: Advanced DQL (Aggregations, GROUP BY)
- **Focus**: Multiple table operations

### Modules 8-10: Advanced
- **Focus**: JOINs, subqueries, CASE statements
- **Focus**: Complex DQL scenarios

### Modules 11-12: Expert
- **Focus**: CTEs, Views (DDL)
- **Focus**: Window functions (DQL)
- **Focus**: Transaction management (TCL)
- **Focus**: Optimization techniques

---

## 🎯 Quick Reference Commands

```sql
-- DDL
CREATE TABLE table_name (...);
ALTER TABLE table_name ADD column_name datatype;
DROP TABLE table_name;
TRUNCATE TABLE table_name;

-- DML
INSERT INTO table_name VALUES (...);
UPDATE table_name SET column = value WHERE condition;
DELETE FROM table_name WHERE condition;

-- DQL
SELECT columns FROM table WHERE condition;
SELECT columns FROM table1 JOIN table2 ON condition;
SELECT columns FROM table GROUP BY column HAVING condition;

-- DCL
GRANT permission ON database.table TO 'user'@'host';
REVOKE permission ON database.table FROM 'user'@'host';

-- TCL
START TRANSACTION;
COMMIT;
ROLLBACK;
SAVEPOINT savepoint_name;
```

---

## � SQL Constraints

**Purpose:** Rules enforced on data columns to ensure data integrity and accuracy.

### Types of Constraints

#### 1. PRIMARY KEY
- Uniquely identifies each record in a table
- Cannot contain NULL values
- Only one PRIMARY KEY per table
- Automatically creates a unique index

```sql
-- Single column primary key
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(50)
);

-- Composite primary key
CREATE TABLE order_items (
    order_id INT,
    product_id INT,
    quantity INT,
    PRIMARY KEY (order_id, product_id)
);

-- Named constraint
CREATE TABLE customers (
    customer_id INT,
    CONSTRAINT pk_customer PRIMARY KEY (customer_id)
);
```

#### 2. FOREIGN KEY
- Links two tables together
- Ensures referential integrity
- Value must exist in referenced table or be NULL

```sql
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- With actions on delete/update
CREATE TABLE order_items (
    item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT
);

-- Named constraint
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    manager_id INT,
    CONSTRAINT fk_manager FOREIGN KEY (manager_id) 
        REFERENCES employees(employee_id)
);
```

**Foreign Key Actions:**
- `CASCADE` - Automatically delete/update child records
- `SET NULL` - Set foreign key to NULL
- `SET DEFAULT` - Set to default value
- `RESTRICT` / `NO ACTION` - Prevent the operation if child records exist

#### 3. UNIQUE
- Ensures all values in a column are different
- Can have multiple UNIQUE constraints per table
- Allows NULL values (depending on database)

```sql
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    email VARCHAR(100) UNIQUE,
    username VARCHAR(50) UNIQUE
);

-- Composite unique constraint
CREATE TABLE student_courses (
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    UNIQUE (student_id, course_id)
);

-- Named constraint
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    sku VARCHAR(50),
    CONSTRAINT uk_sku UNIQUE (sku)
);
```

#### 4. NOT NULL
- Ensures a column cannot have NULL values
- Must provide a value when inserting

```sql
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15)  -- Can be NULL
);

-- Adding NOT NULL to existing column
ALTER TABLE employees 
MODIFY COLUMN department VARCHAR(50) NOT NULL;
```

#### 5. CHECK
- Ensures values meet a specific condition
- Can reference one or more columns

```sql
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    age INT CHECK (age >= 18 AND age <= 65),
    salary DECIMAL(10,2) CHECK (salary > 0),
    email VARCHAR(100) CHECK (email LIKE '%@%.%')
);

-- Named CHECK constraint
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    price DECIMAL(10,2),
    discount_price DECIMAL(10,2),
    CONSTRAINT chk_price CHECK (price > 0),
    CONSTRAINT chk_discount CHECK (discount_price < price)
);

-- Adding CHECK constraint
ALTER TABLE employees
ADD CONSTRAINT chk_salary_range CHECK (salary BETWEEN 30000 AND 200000);
```

#### 6. DEFAULT
- Sets a default value when no value is specified
- Applied during INSERT operations

```sql
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    order_date DATE DEFAULT CURRENT_DATE,
    status VARCHAR(20) DEFAULT 'pending',
    priority INT DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Using DEFAULT in INSERT
INSERT INTO orders (order_id) VALUES (1);
-- order_date, status, priority, created_at will use defaults

-- SQLite syntax for auto-increment
CREATE TABLE employees (
    employee_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(50)
);
```

### Managing Constraints

```sql
-- Drop constraint
ALTER TABLE employees 
DROP CONSTRAINT chk_salary;

-- Temporarily disable constraints (MySQL)
SET FOREIGN_KEY_CHECKS = 0;
-- Perform operations
SET FOREIGN_KEY_CHECKS = 1;

-- View constraints (MySQL)
SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
WHERE TABLE_NAME = 'employees';

-- View constraints (PostgreSQL)
SELECT con.conname, con.contype 
FROM pg_constraint con
JOIN pg_class rel ON rel.oid = con.conrelid
WHERE rel.relname = 'employees';
```

---

## 📊 SQL Data Types

**Purpose:** Define the type of data that can be stored in each column.

### Numeric Data Types

#### Integer Types
```sql
-- Small numbers (-128 to 127 or 0 to 255)
TINYINT          -- 1 byte

-- Medium numbers (-32,768 to 32,767 or 0 to 65,535)
SMALLINT         -- 2 bytes

-- Standard integers (-2,147,483,648 to 2,147,483,647)
INT / INTEGER    -- 4 bytes
MEDIUMINT        -- 3 bytes (MySQL specific)

-- Large numbers (-9,223,372,036,854,775,808 to 9,223,372,036,854,775,807)
BIGINT           -- 8 bytes

-- Example
CREATE TABLE products (
    product_id INT,
    stock_quantity SMALLINT,
    views BIGINT
);
```

#### Decimal/Floating Point Types
```sql
-- Fixed-point (exact values)
DECIMAL(p, s)    -- p = precision (total digits), s = scale (decimal places)
NUMERIC(p, s)    -- Same as DECIMAL

-- Floating-point (approximate values)
FLOAT(p)         -- 4 bytes, single precision
DOUBLE           -- 8 bytes, double precision
REAL             -- Similar to FLOAT

-- Example
CREATE TABLE financial (
    price DECIMAL(10, 2),      -- 99999999.99
    tax_rate DECIMAL(5, 4),    -- 0.0975 (9.75%)
    weight FLOAT,              -- 123.456
    distance DOUBLE            -- 123456.789012
);
```

**💡 Use DECIMAL for money, FLOAT/DOUBLE for scientific calculations**

### String/Text Data Types

```sql
-- Fixed length (padded with spaces)
CHAR(n)          -- 0 to 255 characters

-- Variable length
VARCHAR(n)       -- 0 to 65,535 characters (depends on row size)
TEXT             -- Up to 65,535 characters
MEDIUMTEXT       -- Up to 16,777,215 characters
LONGTEXT         -- Up to 4,294,967,295 characters

-- Example
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    country_code CHAR(2),           -- 'US', 'IN', 'UK'
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    bio TEXT,
    resume LONGTEXT
);
```

**💡 Use CHAR for fixed-length data (codes, flags), VARCHAR for variable-length**

### Date and Time Data Types

```sql
-- Date only
DATE             -- 'YYYY-MM-DD' (1000-01-01 to 9999-12-31)

-- Time only
TIME             -- 'HH:MM:SS' (-838:59:59 to 838:59:59)

-- Date and time
DATETIME         -- 'YYYY-MM-DD HH:MM:SS' (1000-01-01 to 9999-12-31)
TIMESTAMP        -- Unix timestamp (1970-01-01 to 2038-01-19)
YEAR             -- 4-digit year (1901 to 2155)

-- Example
CREATE TABLE events (
    event_id INT PRIMARY KEY,
    event_date DATE,
    event_time TIME,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    event_year YEAR
);

-- SQLite uses TEXT for dates
CREATE TABLE events (
    event_id INTEGER PRIMARY KEY,
    event_date TEXT,              -- Store as 'YYYY-MM-DD'
    created_at TEXT DEFAULT (datetime('now'))
);
```

**Key Differences:**
- `DATETIME` - Stores literal value, doesn't change with timezone
- `TIMESTAMP` - Stores as UTC, converts based on timezone settings

### Boolean Data Type

```sql
-- MySQL/PostgreSQL
BOOLEAN / BOOL   -- TRUE (1) or FALSE (0)

-- SQLite (uses INTEGER)
INTEGER          -- 0 = FALSE, 1 = TRUE

-- Example
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    is_active BOOLEAN DEFAULT TRUE,
    email_verified BOOLEAN DEFAULT FALSE
);

-- Usage
INSERT INTO users (user_id, is_active) VALUES (1, TRUE);
SELECT * FROM users WHERE is_active = TRUE;
```

### Binary Data Types

```sql
-- Fixed length binary
BINARY(n)        -- 0 to 255 bytes

-- Variable length binary
VARBINARY(n)     -- 0 to 65,535 bytes
BLOB             -- Binary Large Object
MEDIUMBLOB       -- Up to 16MB
LONGBLOB         -- Up to 4GB

-- Example
CREATE TABLE files (
    file_id INT PRIMARY KEY,
    file_name VARCHAR(255),
    file_data BLOB,
    thumbnail MEDIUMBLOB
);
```

### Special Data Types

```sql
-- JSON (MySQL 5.7+, PostgreSQL)
JSON             -- Stores JSON documents

-- Enumeration (predefined list of values)
ENUM('value1', 'value2', ...)

-- Set (can store multiple values from list)
SET('value1', 'value2', ...)

-- Example
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    name VARCHAR(100),
    size ENUM('XS', 'S', 'M', 'L', 'XL', 'XXL'),
    features SET('waterproof', 'wireless', 'rechargeable'),
    metadata JSON
);

-- JSON example
INSERT INTO products (product_id, name, metadata) VALUES
(1, 'Widget', '{"color": "red", "weight": 150, "dimensions": {"width": 10, "height": 5}}');

SELECT JSON_EXTRACT(metadata, '$.color') FROM products WHERE product_id = 1;
```

### Data Type Selection Guide

| Use Case | Recommended Type | Example |
|----------|-----------------|---------|
| ID/Primary Key | INT or BIGINT | `employee_id INT` |
| Money/Currency | DECIMAL(10,2) | `price DECIMAL(10,2)` |
| Name/Short Text | VARCHAR(50-100) | `first_name VARCHAR(50)` |
| Email | VARCHAR(100) | `email VARCHAR(100)` |
| URL | VARCHAR(255) | `website VARCHAR(255)` |
| Description | TEXT | `description TEXT` |
| Yes/No | BOOLEAN | `is_active BOOLEAN` |
| Date | DATE | `birth_date DATE` |
| Date+Time | DATETIME/TIMESTAMP | `created_at TIMESTAMP` |
| Phone | VARCHAR(15-20) | `phone VARCHAR(20)` |
| ZIP/Postal Code | VARCHAR(10) | `zip_code VARCHAR(10)` |
| Country Code | CHAR(2) | `country CHAR(2)` |
| Status | ENUM or VARCHAR | `status ENUM('active','inactive')` |
| Percentage | DECIMAL(5,2) | `discount DECIMAL(5,2)` |
| Large Text | TEXT/LONGTEXT | `article_content LONGTEXT` |
| File/Image | BLOB | `profile_pic BLOB` |

### Database-Specific Variations

#### SQLite (used by sql-practice.com)
```sql
-- SQLite has 5 storage classes:
NULL             -- NULL value
INTEGER          -- Signed integer
REAL             -- Floating point
TEXT             -- Text string
BLOB             -- Binary data

-- Example (SQLite)
CREATE TABLE employee (
    employee_id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    salary REAL,
    hire_date TEXT,
    is_active INTEGER DEFAULT 1
);
```

#### MySQL
```sql
-- Auto-increment primary key
CREATE TABLE employee (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(35) NOT NULL,
    last_name VARCHAR(35) NOT NULL
);
```

#### PostgreSQL
```sql
-- Auto-increment using SERIAL or IDENTITY
CREATE TABLE employee (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(35) NOT NULL,
    last_name VARCHAR(35) NOT NULL
);

-- Or using IDENTITY (PostgreSQL 10+)
CREATE TABLE employee (
    employee_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    first_name VARCHAR(35) NOT NULL,
    last_name VARCHAR(35) NOT NULL
);
```

---

## �📖 Additional Resources

- [MySQL Documentation](https://dev.mysql.com/doc/)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [W3Schools SQL Tutorial](https://www.w3schools.com/sql/)
- [SQL Style Guide](https://www.sqlstyle.guide/)

---

**Created**: March 10, 2026  
**Course**: TuteDude Data Engineering Bootcamp  
**Topics**: SQL Fundamentals (Modules 4-12)

---

*This reference guide will be updated as you progress through the course modules.*
