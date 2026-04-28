# Employee Performance & Payroll Analytics System

**Mini Project: SQL Database Implementation**

---

## 📋 Project Overview

This mini-project creates a comprehensive database to manage employee performance metrics and payroll information. It integrates HR, performance tracking, and payroll analytics into a unified system that allows organizations to analyze employee performance, calculate salaries based on performance ratings, and generate payroll reports.

### Database Name (Recommended)
```sql
emp_performance_payroll_db
```

**Naming Convention Explanation:**
- `emp_` : Employee/HR prefix for clarity
- `performance_payroll` : Core functionality
- `_db` : Database identifier

---

## 🎯 Learning Objectives

This project covers essential SQL concepts:
- ✅ **CREATE**: Define table structures with relationships
- ✅ **INSERT**: Populate tables with realistic data
- ✅ **JOIN**: Combine data from multiple tables
- ✅ **GROUP BY & CASE**: Aggregate and classify data
- ✅ **SUBQUERIES**: Nested queries for complex analysis
- ✅ **STORED PROCEDURES**: Reusable routines with parameters
- ✅ **INDEXES**: Optimize query performance
- ✅ **VIEWS**: Create simplified data abstractions
- ✅ **CTEs**: Use Common Table Expressions for readability
- ✅ **Nested Queries**: Complex multi-level analysis

---

## 📊 Database Schema

### Tables Overview

| Table | Purpose | Key Columns |
|-------|---------|------------|
| `department` | Master table for departments | `departmentId`, `name`, `location` |
| `employee` | Employee information and basic salary | `employeeId`, `first_name`, `last_name`, `email`, `base_salary`, `hire_date`, `departmentId` |
| `performance` | Employee performance ratings and metrics | `performanceId`, `employeeId`, `review_date`, `rating`, `bonus_percentage`, `review_notes` |

### Table Relationships
```
department (1) ──→ (M) employee
                        ↓ (1)
                       (M) performance
```

---

## 🚀 Step-by-Step Implementation Guide

### STEP 1: Create the Database

```sql
CREATE DATABASE emp_performance_payroll_db;
USE emp_performance_payroll_db;
```

### STEP 2: Create Tables

#### 2.1 Department Table
```sql
CREATE TABLE department (
    departmentId INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL UNIQUE,
    location VARCHAR(100),
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

#### 2.2 Employee Table
```sql
CREATE TABLE employee (
    employeeId INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    base_salary DECIMAL(10, 2) NOT NULL,
    hire_date DATE NOT NULL,
    departmentId INT NOT NULL,
    status VARCHAR(20) DEFAULT 'Active',
    CONSTRAINT fk_employee_dept FOREIGN KEY (departmentId) REFERENCES department(departmentId),
    INDEX idx_department (departmentId),
    INDEX idx_email (email)
);
```

#### 2.3 Performance Table
```sql
CREATE TABLE performance (
    performanceId INT PRIMARY KEY AUTO_INCREMENT,
    employeeId INT NOT NULL,
    review_date DATE NOT NULL,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    bonus_percentage DECIMAL(5, 2) DEFAULT 0,
    review_notes VARCHAR(500),
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_performance_emp FOREIGN KEY (employeeId) REFERENCES employee(employeeId),
    INDEX idx_employee_review (employeeId, review_date),
    UNIQUE KEY unique_annual_review (employeeId, YEAR(review_date))
);
```

### STEP 3: Insert Sample Data

#### 3.1 Insert Department Data
```sql
INSERT INTO department (name, location) VALUES
('Sales', 'New York'),
('Engineering', 'San Francisco'),
('HR', 'Chicago'),
('Finance', 'Boston'),
('Operations', 'Dallas');
```

#### 3.2 Insert Employee Data
```sql
INSERT INTO employee (first_name, last_name, email, base_salary, hire_date, departmentId) VALUES
('John', 'Smith', 'john.smith@company.com', 75000.00, '2022-01-15', 2),
('Sarah', 'Johnson', 'sarah.johnson@company.com', 65000.00, '2021-06-20', 1),
('Michael', 'Williams', 'michael.williams@company.com', 85000.00, '2020-03-10', 2),
('Emily', 'Brown', 'emily.brown@company.com', 55000.00, '2023-02-01', 3),
('Robert', 'Davis', 'robert.davis@company.com', 95000.00, '2019-11-05', 1),
('Jennifer', 'Miller', 'jennifer.miller@company.com', 70000.00, '2022-05-12', 4),
('David', 'Wilson', 'david.wilson@company.com', 60000.00, '2023-01-20', 5);
```

#### 3.3 Insert Performance Data
```sql
INSERT INTO performance (employeeId, review_date, rating, bonus_percentage, review_notes) VALUES
(1, '2025-12-31', 5, 15.00, 'Excellent developer, great team player'),
(2, '2025-12-31', 4, 10.00, 'Good sales performance, needs improvement in client relations'),
(3, '2025-12-31', 5, 15.00, 'Outstanding technical skills and leadership'),
(4, '2025-12-31', 3, 5.00, 'Average performer, room for improvement'),
(5, '2025-12-31', 4, 12.00, 'Consistent high performer in sales'),
(6, '2025-12-31', 3, 5.00, 'Meets expectations'),
(1, '2026-03-15', 4, 12.00, 'Good progress, maintaining excellence'),
(2, '2026-03-15', 3, 8.00, 'Struggling with new product line'),
(3, '2026-03-15', 5, 18.00, 'Promoted to team lead, excellent mentor'),
(5, '2026-03-15', 5, 15.00, 'Best salesman this quarter');
```

### STEP 4: Create Indexes

```sql
-- Index for employee lookups by salary
CREATE INDEX idx_employee_salary_dept ON employee(departmentId, base_salary);

-- Index for performance reviews by rating
CREATE INDEX idx_performance_rating ON performance(rating);

-- Index for recent performance reviews
CREATE INDEX idx_performance_date ON performance(review_date DESC);
```

### STEP 5: Join Operations

#### Query 1: Employee with Department and Latest Performance
```sql
SELECT
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    d.name AS department,
    e.base_salary,
    p.review_date,
    p.rating,
    p.bonus_percentage
FROM employee e
INNER JOIN department d ON e.departmentId = d.departmentId
LEFT JOIN performance p ON e.employeeId = p.employeeId
    AND p.review_date = (
        SELECT MAX(review_date) 
        FROM performance 
        WHERE employeeId = e.employeeId
    )
ORDER BY e.departmentId, e.employeeId;
```

### STEP 6: GROUP BY & AGGREGATION

#### Query 1: Average Salary and Latest Rating by Department
```sql
SELECT
    d.departmentId,
    d.name AS department,
    COUNT(e.employeeId) AS total_employees,
    AVG(e.base_salary) AS avg_salary,
    MIN(e.base_salary) AS min_salary,
    MAX(e.base_salary) AS max_salary,
    ROUND(AVG(p.rating), 2) AS avg_rating
FROM department d
LEFT JOIN employee e ON d.departmentId = e.departmentId
LEFT JOIN performance p ON e.employeeId = p.employeeId
    AND p.review_date = (
        SELECT MAX(review_date) 
        FROM performance 
        WHERE employeeId = e.employeeId
    )
GROUP BY d.departmentId, d.name
ORDER BY avg_salary DESC;
```

### STEP 7: CASE Statements for Classification

#### Query: Classify Employees by Performance Band
```sql
SELECT
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    d.name AS department,
    e.base_salary,
    p.rating,
    CASE
        WHEN p.rating = 5 THEN 'Excellent'
        WHEN p.rating = 4 THEN 'Good'
        WHEN p.rating = 3 THEN 'Average'
        WHEN p.rating = 2 THEN 'Below Average'
        WHEN p.rating = 1 THEN 'Needs Improvement'
        ELSE 'Not Rated'
    END AS performance_band,
    CASE
        WHEN p.rating >= 4 THEN 'Eligible for Promotion'
        WHEN p.rating = 3 THEN 'Monitoring'
        ELSE 'Performance Improvement Plan'
    END AS action_required
FROM employee e
INNER JOIN department d ON e.departmentId = d.departmentId
LEFT JOIN performance p ON e.employeeId = p.employeeId
    AND p.review_date = (
        SELECT MAX(review_date) 
        FROM performance 
        WHERE employeeId = e.employeeId
    )
ORDER BY p.rating DESC, e.base_salary DESC;
```

### STEP 8: Subqueries & Complex Analysis

#### Query: Employees Earning More Than Department Average
```sql
SELECT
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    d.name AS department,
    e.base_salary,
    (SELECT AVG(base_salary) FROM employee WHERE departmentId = d.departmentId) AS dept_avg_salary,
    e.base_salary - (SELECT AVG(base_salary) FROM employee WHERE departmentId = d.departmentId) AS salary_diff
FROM employee e
INNER JOIN department d ON e.departmentId = d.departmentId
WHERE e.base_salary > (
    SELECT AVG(base_salary) 
    FROM employee 
    WHERE departmentId = d.departmentId
)
ORDER BY d.departmentId, e.base_salary DESC;
```

### STEP 9: CTEs for Readability

#### Query: Top Performers and Their Bonus Calculation
```sql
WITH latest_performance AS (
    SELECT
        employeeId,
        rating,
        bonus_percentage,
        review_date,
        ROW_NUMBER() OVER (PARTITION BY employeeId ORDER BY review_date DESC) AS rn
    FROM performance
),
top_performers AS (
    SELECT
        e.employeeId,
        CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
        d.name AS department,
        e.base_salary,
        lp.rating,
        lp.bonus_percentage,
        ROUND(e.base_salary * lp.bonus_percentage / 100, 2) AS bonus_amount,
        ROUND(e.base_salary + (e.base_salary * lp.bonus_percentage / 100), 2) AS total_payable
    FROM employee e
    INNER JOIN department d ON e.departmentId = d.departmentId
    INNER JOIN latest_performance lp ON e.employeeId = lp.employeeId AND lp.rn = 1
    WHERE lp.rating >= 4
)
SELECT * FROM top_performers
ORDER BY total_payable DESC;
```

### STEP 10: Create Views

#### View 1: Employee Payroll Summary
```sql
CREATE OR REPLACE VIEW v_employee_payroll_summary AS
SELECT
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    d.name AS department,
    e.base_salary,
    p.rating,
    p.bonus_percentage,
    ROUND(e.base_salary * p.bonus_percentage / 100, 2) AS bonus_amount,
    ROUND(e.base_salary + (e.base_salary * p.bonus_percentage / 100), 2) AS total_compensation
FROM employee e
INNER JOIN department d ON e.departmentId = d.departmentId
LEFT JOIN performance p ON e.employeeId = p.employeeId
    AND p.review_date = (
        SELECT MAX(review_date) 
        FROM performance 
        WHERE employeeId = e.employeeId
    );
```

#### View 2: Department Performance Analytics
```sql
CREATE OR REPLACE VIEW v_department_analytics AS
SELECT
    d.departmentId,
    d.name AS department,
    COUNT(e.employeeId) AS total_employees,
    SUM(e.base_salary) AS total_payroll,
    AVG(e.base_salary) AS avg_salary,
    ROUND(AVG(COALESCE(p.rating, 0)), 2) AS avg_performance_rating,
    SUM(ROUND(e.base_salary * COALESCE(p.bonus_percentage, 0) / 100, 2)) AS total_bonus_payout
FROM department d
LEFT JOIN employee e ON d.departmentId = e.departmentId
LEFT JOIN performance p ON e.employeeId = p.employeeId
    AND p.review_date = (
        SELECT MAX(review_date) 
        FROM performance 
        WHERE employeeId = e.employeeId
    )
GROUP BY d.departmentId, d.name;
```

### STEP 11: Create Stored Procedures

#### Procedure 1: Calculate and Update Payroll Based on Performance
```sql
DELIMITER $$

CREATE PROCEDURE sp_calculate_payroll(
    IN p_employee_id INT,
    OUT p_base_salary DECIMAL(10, 2),
    OUT p_bonus_amount DECIMAL(10, 2),
    OUT p_total_payable DECIMAL(10, 2)
)
BEGIN
    DECLARE v_bonus_percentage DECIMAL(5, 2) DEFAULT 0;
    
    SELECT base_salary INTO p_base_salary
    FROM employee
    WHERE employeeId = p_employee_id;
    
    SELECT COALESCE(bonus_percentage, 0) INTO v_bonus_percentage
    FROM performance
    WHERE employeeId = p_employee_id
    ORDER BY review_date DESC
    LIMIT 1;
    
    SET p_bonus_amount = ROUND(p_base_salary * v_bonus_percentage / 100, 2);
    SET p_total_payable = p_base_salary + p_bonus_amount;
END $$

DELIMITER ;

-- Usage:
CALL sp_calculate_payroll(1, @base, @bonus, @total);
SELECT @base AS base_salary, @bonus AS bonus, @total AS total_payable;
```

#### Procedure 2: Get Department Performance Report
```sql
DELIMITER $$

CREATE PROCEDURE sp_get_department_report(IN p_department_id INT)
BEGIN
    SELECT
        d.name AS department,
        COUNT(e.employeeId) AS total_employees,
        ROUND(AVG(e.base_salary), 2) AS avg_salary,
        ROUND(AVG(COALESCE(p.rating, 0)), 2) AS avg_rating,
        SUM(e.base_salary) AS total_payroll
    FROM department d
    LEFT JOIN employee e ON d.departmentId = e.departmentId
    LEFT JOIN performance p ON e.employeeId = p.employeeId
        AND p.review_date = (
            SELECT MAX(review_date) 
            FROM performance 
            WHERE employeeId = e.employeeId
        )
    WHERE d.departmentId = p_department_id
    GROUP BY d.departmentId, d.name;
END $$

DELIMITER ;

-- Usage:
CALL sp_get_department_report(2);
```

---

## ✅ Verification Checklist

- [ ] Database created successfully
- [ ] All three tables created with proper constraints
- [ ] Sample data inserted (7 employees, 5 departments, 10 performance records)
- [ ] Indexes created for performance optimization
- [ ] JOIN queries return expected results
- [ ] GROUP BY aggregations working correctly
- [ ] CASE statements classifying data properly
- [ ] Subqueries calculating correctly
- [ ] CTEs executing and producing results
- [ ] Views created and returning data
- [ ] Stored procedures callable with correct parameters
- [ ] EXPLAIN shows index usage

### Quick Verification Queries
```sql
SELECT COUNT(*) FROM employee;           -- Should return 7
SELECT COUNT(*) FROM performance;        -- Should return 10
SELECT * FROM v_employee_payroll_summary; -- View verification
CALL sp_calculate_payroll(1, @b, @bo, @t); -- Procedure verification
```

---

## 📈 Future Enhancements

1. **Add Attendance Table**: Track employee attendance
2. **Add Salary History**: Record salary changes over time
3. **Add Training Table**: Track employee training programs
4. **Add Promotion Table**: Maintain promotion history
5. **Dashboard Queries**: Create complex analytics queries
6. **Schedule Functions**: Use event scheduler for automated tasks
7. **Triggers**: Auto-update last_review_date in employee table
8. **Permissions**: Create roles for different access levels

---

## 🔗 Related SQL Concepts Covered

| Concept | Files |
|---------|-------|
| CREATE & Constraints | `../02-manipulation/create-cmd.sql` |
| JOIN Operations | `../05-joins/` |
| GROUP BY | `../04-aggregations/aggregations-cmd.sql` |
| CASE Statements | `../07-subqueries/case-statement-cmd.sql` |
| Subqueries | `../07-subqueries/subqueries-cmd.sql` |
| CTEs | `../08-ctes-views/ctes-cmd.sql` |
| Views | `../08-ctes-views/views-cmd.sql` |
| Stored Procedures | `../09-advanced/stored-procedure-cmd.sql` |
| Indexes | `../09-advanced/index-cmd.sql` |

---

## 📝 Notes

- All monetary values use `DECIMAL(10, 2)` for accuracy
- Performance ratings are constrained to 1-5
- Latest performance record is tracked per employee
- Bonus percentages are applied to base salary
- Foreign keys ensure referential integrity
