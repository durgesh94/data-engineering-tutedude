/*
================================================================================
  SQL SET OPERATORS COMPREHENSIVE GUIDE
================================================================================
  File: set-operators-cmd.sql
  Description: Complete tutorial on SQL SET OPERATORS (UNION, UNION ALL, INTERSECT, EXCEPT)
               with practical examples using employee, department, project tables.
  
  AUTHOR: Durgesh Tambe
  CREATED: April 24, 2026
  UPDATED: April 24, 2026
  VERSION: 1.0
  
  WHAT ARE SET OPERATORS?
  ─────────────────────────────────────────────────────────────────────────────
  SET OPERATORS combine results from MULTIPLE SELECT queries into a single result set.
  They work on the result sets (outputs) of queries, not the tables themselves.
  Think of them as set operations: Union, Intersection, Difference.
  
  Key Characteristics:
    ✓ Combine results from 2 or more SELECT statements
    ✓ Operate on result sets (vertical combination)
    ✓ All SELECT queries must have SAME number of columns
    ✓ Column data types must be COMPATIBLE
    ✓ Column names from FIRST query are used in result
    ✓ Works across different tables or same table
    ✓ Can be used instead of complex WHERE conditions
  
  Types of SET OPERATORS:
    1. UNION     - Combines results, removes DUPLICATES
    2. UNION ALL - Combines results, keeps DUPLICATES
    3. INTERSECT - Returns ONLY rows that appear in BOTH queries
    4. EXCEPT    - Returns rows from first query NOT in second query
       (Called MINUS in Oracle)
  
  Comparison with JOINs:
    JOINs:        Combine columns from multiple tables (horizontal)
    SET OPS:      Combine rows from multiple queries (vertical)
  
  Syntax:
    SELECT columns FROM table1
    UNION | UNION ALL | INTERSECT | EXCEPT
    SELECT columns FROM table2;
  
  Important Rules:
    - Both queries must have SAME number of columns
    - Column positions must be COMPATIBLE types
    - Column names from FIRST query are used in result
    - ORDER BY applies to entire result set (at end)
    - LIMIT applies to entire result set (at end)
  
  When to use SET OPERATORS:
    ✓ Combine results from different tables
    ✓ Find common records across queries
    ✓ Find differences between datasets
    ✓ Remove duplicates efficiently
    ✓ Compare two datasets
    ✓ Data quality and reconciliation
    ✓ Multi-condition queries
    ✓ Alternative to complex WHERE conditions
  
  Database Support:
    ✅ MySQL ............ UNION, UNION ALL, INTERSECT (v8.0+), EXCEPT (not supported, use alternative)
    ✅ PostgreSQL ....... UNION, UNION ALL, INTERSECT, EXCEPT (all supported)
    ✅ SQL Server ....... UNION, UNION ALL, INTERSECT, EXCEPT (all supported)
    ✅ Oracle ........... UNION, UNION ALL, INTERSECT, MINUS (uses MINUS instead of EXCEPT)
    ✅ SQLite ........... UNION, UNION ALL, INTERSECT, EXCEPT (all supported)
  
  TABLE OF CONTENTS:
    1. UNION - Combine Results (Remove Duplicates)
    2. UNION ALL - Combine Results (Keep Duplicates)
    3. UNION vs UNION ALL - Comparison
    4. INTERSECT - Find Common Records
    5. EXCEPT/MINUS - Find Differences
    6. Multiple SET OPERATORS - Chaining
    7. SET OPERATORS with WHERE - Filtering
    8. SET OPERATORS with ORDER BY
    9. SET OPERATORS with Aggregation
    10. Data Reconciliation using SET OPERATORS
    11. Performance Comparison
    12. Real-World Scenarios
  
  MYSQL SPECIFIC NOTES:
    - MySQL supports: UNION, UNION ALL, INTERSECT (v8.0+)
    - MySQL does NOT support EXCEPT (use alternative methods)
    - LIMIT must be preceded by parentheses: (SELECT...) LIMIT 10
    - SET OPERATIONS in MySQL are case-insensitive
  
  PREREQUISITES:
    - employee_us table: employeeId, first_name, last_name, email, salary, department
    - employee_uk table: employeeId, first_name, last_name, email, salary, department
    - Sample data with overlapping and unique employees from US and UK
    
  EXECUTION:
    - Execute CREATE TABLE statements first
    - Run INSERT statements to add sample data
    - Execute each example individually
    - Pay attention to duplicate handling
    - Notice column order and naming
    - Understand when to use which operator
================================================================================
*/

-- ============================================================================
-- CREATE TABLES FOR EXAMPLES
-- ============================================================================

-- Create US Employees Table
CREATE TABLE IF NOT EXISTS employee_us (
    employeeId INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    salary DECIMAL(10, 2),
    department VARCHAR(50),
    created_date DATE
);

-- Create UK Employees Table
CREATE TABLE IF NOT EXISTS employee_uk (
    employeeId INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    salary DECIMAL(10, 2),
    department VARCHAR(50),
    created_date DATE
);

-- ============================================================================
-- INSERT SAMPLE DATA - US EMPLOYEES
-- ============================================================================
INSERT INTO employee_us (employeeId, first_name, last_name, email, salary, department, created_date) VALUES
(1, 'John', 'Smith', 'john.smith@us.company.com', 75000, 'Sales', '2025-01-15'),
(2, 'Sarah', 'Johnson', 'sarah.johnson@us.company.com', 85000, 'Engineering', '2025-02-10'),
(3, 'Michael', 'Brown', 'michael.brown@us.company.com', 95000, 'Sales', '2025-03-05'),
(4, 'Emily', 'Davis', 'emily.davis@us.company.com', 78000, 'HR', '2025-04-12'),
(5, 'Robert', 'Wilson', 'robert.wilson@us.company.com', 88000, 'Engineering', '2025-05-18'),
(6, 'Jennifer', 'Martinez', 'jennifer.martinez@us.company.com', 82000, 'Finance', '2025-06-22'),
(7, 'David', 'Garcia', 'david.garcia@us.company.com', 79000, 'Sales', '2025-07-30'),
(8, 'Lisa', 'Anderson', 'lisa.anderson@us.company.com', 91000, 'Engineering', '2026-01-08'),
(9, 'James', 'Taylor', 'james.taylor@us.company.com', 76000, 'Finance', '2026-01-20'),
(10, 'Patricia', 'Thomas', 'patricia.thomas@us.company.com', 84000, 'HR', '2026-02-14');

-- ============================================================================
-- INSERT SAMPLE DATA - UK EMPLOYEES
-- ============================================================================
INSERT INTO employee_uk (employeeId, first_name, last_name, email, salary, department, created_date) VALUES
(1, 'John', 'Smith', 'john.smith@uk.company.com', 72000, 'Sales', '2025-01-15'),
(2, 'Sarah', 'Johnson', 'sarah.johnson@uk.company.com', 82000, 'Engineering', '2025-02-10'),
(11, 'James', 'Wilson', 'james.wilson@uk.company.com', 85000, 'Sales', '2025-03-20'),
(12, 'Emma', 'White', 'emma.white@uk.company.com', 79000, 'Engineering', '2025-04-25'),
(13, 'Oliver', 'Harris', 'oliver.harris@uk.company.com', 88000, 'Finance', '2025-05-15'),
(14, 'Sophia', 'Clark', 'sophia.clark@uk.company.com', 81000, 'HR', '2025-06-10'),
(15, 'Benjamin', 'Lewis', 'benjamin.lewis@uk.company.com', 86000, 'Sales', '2025-07-22'),
(16, 'Isabella', 'Walker', 'isabella.walker@uk.company.com', 93000, 'Engineering', '2025-08-30'),
(17, 'Lucas', 'Hall', 'lucas.hall@uk.company.com', 77000, 'Finance', '2026-01-12'),
(18, 'Amelia', 'Young', 'amelia.young@uk.company.com', 83000, 'HR', '2026-02-05');

-- Verify data was inserted
SELECT 'US Employees' as data_source, COUNT(*) as total_records FROM employee_us
UNION ALL
SELECT 'UK Employees' as data_source, COUNT(*) as total_records FROM employee_uk;

-- View sample US employees
SELECT * FROM employee_us LIMIT 5;

-- View sample UK employees
SELECT * FROM employee_uk LIMIT 5;

-- Tested on MySQL
SELECT first_name FROM employee_uk
UNION
SELECT first_name FROM employee_us;

SELECT k.employeeId, k.first_name FROM employee_uk k
JOIN employee_us u
ON k.employeeId = u.employeeId;

SELECT employeeId, first_name FROM employee_us
WHERE employeeId NOT IN (SELECT employeeId FROM employee_uk);

-- ============================================================================
-- 1. UNION - Combine Results (Remove Duplicates)
-- ============================================================================
-- Combine employees from US and UK offices (removes duplicate names)
-- Get all high-salary employees from both offices

SELECT 
    'US High Earner' as employee_type,
    employeeId,
    CONCAT(first_name, ' ', last_name) as full_name,
    salary,
    department
FROM employee_us
WHERE salary > 85000

UNION

SELECT 
    'UK High Earner' as employee_type,
    employeeId,
    CONCAT(first_name, ' ', last_name) as full_name,
    salary,
    department
FROM employee_uk
WHERE salary > 85000
ORDER BY salary DESC;

-- ============================================================================
-- 2. UNION ALL - Combine Results (Keep Duplicates)
-- ============================================================================
-- Combine all employee records from both offices including duplicates

SELECT 
    'US Office' as office,
    employeeId,
    CONCAT(first_name, ' ', last_name) as employee_name,
    salary,
    'Current' as status
FROM employee_us

UNION ALL

SELECT 
    'UK Office' as office,
    employeeId,
    CONCAT(first_name, ' ', last_name) as employee_name,
    salary,
    'Current' as status
FROM employee_uk
ORDER BY salary DESC;

-- Explanation:
-- UNION ALL keeps ALL rows, including duplicates
-- John Smith appears twice (once from US, once from UK)
-- Useful when you want to see complete data from both offices
-- Result will have MORE rows than UNION

-- ============================================================================
-- 2B. UNION ALL - Append Sales Department Records
-- ============================================================================
-- Show existing sales employees from both offices

SELECT 
    employeeId,
    CONCAT(first_name, ' ', last_name) as employee_name,
    salary,
    department,
    'Active' as status
FROM employee_us
WHERE department = 'Sales'

UNION ALL

SELECT 
    employeeId,
    CONCAT(first_name, ' ', last_name) as employee_name,
    salary,
    department,
    'Active' as status
FROM employee_uk
WHERE department = 'Sales'
ORDER BY salary DESC;

-- ============================================================================
-- 3. UNION vs UNION ALL - Comparison
-- ============================================================================
-- Show the difference: UNION removes duplicates, UNION ALL keeps them

SELECT 'UNION (No Duplicates)' as operation, COUNT(*) as row_count
FROM (
    SELECT 
        CONCAT(first_name, ' ', last_name) as full_name,
        'Shared Name' as record_type
    FROM employee_us

    UNION

    SELECT 
        CONCAT(first_name, ' ', last_name) as full_name,
        'Shared Name' as record_type
    FROM employee_uk
) AS union_result

UNION ALL

SELECT 'UNION ALL (With Duplicates)' as operation, COUNT(*) as row_count
FROM (
    SELECT 
        CONCAT(first_name, ' ', last_name) as full_name,
        'Shared Name' as record_type
    FROM employee_us

    UNION ALL

    SELECT 
        CONCAT(first_name, ' ', last_name) as full_name,
        'Shared Name' as record_type
    FROM employee_uk
) AS union_all_result;

-- ============================================================================
-- 4. INTERSECT - Find Common Records
-- ============================================================================
-- Find employees who exist in BOTH US and UK offices (by name & department)

SELECT 
    CONCAT(first_name, ' ', last_name) as full_name,
    department,
    salary
FROM employee_us

INTERSECT

SELECT 
    CONCAT(first_name, ' ', last_name) as full_name,
    department,
    salary
FROM employee_uk
ORDER BY salary DESC;

-- Explanation:
-- INTERSECT finds rows that exist in BOTH result sets
-- Returns only matching records (John Smith from both offices)
-- Useful for finding common items across datasets

-- ============================================================================
-- 4B. INTERSECT - Find Common Engineering Staff
-- ============================================================================
-- Find employees who work in Engineering in BOTH offices

SELECT 
    CONCAT(first_name, ' ', last_name) as full_name,
    email,
    department
FROM employee_us
WHERE department = 'Engineering'

INTERSECT

SELECT 
    CONCAT(first_name, ' ', last_name) as full_name,
    email,
    department
FROM employee_uk
WHERE department = 'Engineering'
ORDER BY full_name;

-- ============================================================================
-- 5. EXCEPT - Find Differences (MySQL Alternative)
-- ============================================================================
-- MySQL Note: EXCEPT not directly supported in all versions
-- Find employees in US office who are NOT in UK office

SELECT 
    CONCAT(first_name, ' ', last_name) as full_name,
    email,
    salary,
    department
FROM employee_us

EXCEPT

SELECT 
    CONCAT(first_name, ' ', last_name) as full_name,
    email,
    salary,
    department
FROM employee_uk
ORDER BY salary DESC;

-- Result: Shows US employees not found in UK (Smith, Brown, Davis, etc.)

-- ============================================================================
-- 5B. EXCEPT Alternative - Using LEFT JOIN (MySQL Compatible)
-- ============================================================================
-- Find employees in UK office that are NOT in US office

SELECT 
    u.employeeId,
    CONCAT(u.first_name, ' ', u.last_name) as full_name,
    u.email,
    u.salary,
    u.department
FROM employee_uk u
LEFT JOIN employee_us s ON CONCAT(u.first_name, ' ', u.last_name) = CONCAT(s.first_name, ' ', s.last_name)
WHERE s.employeeId IS NULL
ORDER BY u.salary DESC;

-- Result: Shows UK exclusive employees (Wilson, White, Harris, etc.)

-- ============================================================================
-- 6. Multiple SET OPERATORS - Chaining
-- ============================================================================
-- Combine multiple queries with different set operators

SELECT 
    'US Sales Team' as category,
    employeeId,
    CONCAT(first_name, ' ', last_name) as employee_name,
    salary
FROM employee_us
WHERE department = 'Sales'

UNION

SELECT 
    'UK Sales Team' as category,
    employeeId,
    CONCAT(first_name, ' ', last_name) as employee_name,
    salary
FROM employee_uk
WHERE department = 'Sales'

UNION

SELECT 
    'US Engineering Team' as category,
    employeeId,
    CONCAT(first_name, ' ', last_name) as employee_name,
    salary
FROM employee_us
WHERE department = 'Engineering'
ORDER BY category, salary DESC;

-- ============================================================================
-- 6B. Multiple SET OPERATORS - Complex Query
-- ============================================================================
-- Find all high-earning employees from both offices by department

SELECT 
    'US High Earners' as category,
    employeeId,
    CONCAT(first_name, ' ', last_name) as employee_name,
    department,
    salary
FROM employee_us
WHERE salary > 80000

UNION

SELECT 
    'UK High Earners' as category,
    employeeId,
    CONCAT(first_name, ' ', last_name) as employee_name,
    department,
    salary
FROM employee_uk
WHERE salary > 80000

UNION

SELECT 
    'UK Exclusive Employees' as category,
    employeeId,
    CONCAT(first_name, ' ', last_name) as employee_name,
    department,
    salary
FROM employee_uk
WHERE salary > 85000
ORDER BY category, salary DESC;

-- ============================================================================
-- 7. SET OPERATORS with WHERE - Filtering Results
-- ============================================================================
-- Use WHERE clause BEFORE SET OPERATOR

SELECT 
    employeeId,
    CONCAT(first_name, ' ', last_name) as employee_name,
    salary,
    'US' as office
FROM employee_us
WHERE salary > 80000

UNION

SELECT 
    employeeId,
    CONCAT(first_name, ' ', last_name) as employee_name,
    salary,
    'UK' as office
FROM employee_uk
WHERE salary > 80000
ORDER BY salary DESC;

-- ============================================================================
-- 7B. SET OPERATORS - Filter by Office and Department
-- ============================================================================
-- Filter entire result set by office and department

SELECT * FROM (
    SELECT 
        'US' as office,
        employeeId,
        CONCAT(first_name, ' ', last_name) as employee_name,
        salary,
        department
    FROM employee_us

    UNION

    SELECT 
        'UK' as office,
        employeeId,
        CONCAT(first_name, ' ', last_name) as employee_name,
        salary,
        department
    FROM employee_uk
) as combined_data
WHERE salary > 85000 AND department IN ('Engineering', 'Sales')
ORDER BY salary DESC;

-- ============================================================================
-- 8. SET OPERATORS with ORDER BY
-- ============================================================================
-- ORDER BY applies to entire result set (must be at end)

SELECT 
    'US' as office,
    employeeId,
    CONCAT(first_name, ' ', last_name) as full_name,
    department
FROM employee_us

UNION

SELECT 
    'UK' as office,
    employeeId,
    CONCAT(first_name, ' ', last_name) as full_name,
    department
FROM employee_uk
ORDER BY office, full_name;

-- ============================================================================
-- 8B. SET OPERATORS - Multiple ORDER BY Levels
-- ============================================================================
-- Order by multiple columns (office, then salary)

SELECT 
    'US' as office,
    employeeId,
    CONCAT(first_name, ' ', last_name) as full_name,
    salary,
    department
FROM employee_us

UNION

SELECT 
    'UK' as office,
    employeeId,
    CONCAT(first_name, ' ', last_name) as full_name,
    salary,
    department
FROM employee_uk
ORDER BY office, salary DESC, full_name;

-- ============================================================================
-- 9. SET OPERATORS with Aggregation
-- ============================================================================
-- Combine aggregated results from both offices

SELECT 
    'US Employees' as metric,
    COUNT(*) as employee_count,
    ROUND(AVG(salary), 2) as avg_salary,
    ROUND(SUM(salary), 2) as total_salary
FROM employee_us

UNION

SELECT 
    'UK Employees' as metric,
    COUNT(*) as employee_count,
    ROUND(AVG(salary), 2) as avg_salary,
    ROUND(SUM(salary), 2) as total_salary
FROM employee_uk

UNION

SELECT 
    'US by Department - HR' as metric,
    COUNT(*) as employee_count,
    ROUND(AVG(salary), 2) as avg_salary,
    ROUND(SUM(salary), 2) as total_salary
FROM employee_us
WHERE department = 'HR'
ORDER BY metric;

-- ============================================================================
-- 9B. SET OPERATORS - Complex Aggregation
-- ============================================================================
-- Compare salary statistics between offices

SELECT 
    'US Total Salary' as metric_name,
    COUNT(*) as count_value,
    ROUND(SUM(salary), 2) as amount_value
FROM employee_us

UNION

SELECT 
    'UK Total Salary' as metric_name,
    COUNT(*) as count_value,
    ROUND(SUM(salary), 2) as amount_value
FROM employee_uk

UNION

SELECT 
    'US Avg Salary' as metric_name,
    1 as count_value,
    ROUND(AVG(salary), 2) as amount_value
FROM employee_us

UNION

SELECT 
    'UK Avg Salary' as metric_name,
    1 as count_value,
    ROUND(AVG(salary), 2) as amount_value
FROM employee_uk
ORDER BY metric_name;

-- ============================================================================
-- 10. Data Reconciliation using SET OPERATORS
-- ============================================================================
-- Compare current US employees with UK employees

SELECT 
    CONCAT(first_name, ' ', last_name) as employee_name,
    email,
    salary,
    'US Office' as office_source
FROM employee_us

UNION ALL

SELECT 
    CONCAT(first_name, ' ', last_name) as employee_name,
    email,
    salary,
    'UK Office' as office_source
FROM employee_uk
ORDER BY employee_name, office_source;

-- ============================================================================
-- 10B. Data Quality - Find Employees Only in One Office
-- ============================================================================
-- Find employees unique to US office (not in UK)

SELECT 
    u.employeeId,
    CONCAT(u.first_name, ' ', u.last_name) as employee_name,
    'US ONLY' as status,
    u.department,
    u.salary
FROM employee_us u
LEFT JOIN employee_uk k ON CONCAT(u.first_name, ' ', u.last_name) = CONCAT(k.first_name, ' ', k.last_name)
WHERE k.employeeId IS NULL

UNION

-- Find employees unique to UK office (not in US)
SELECT 
    k.employeeId,
    CONCAT(k.first_name, ' ', k.last_name) as employee_name,
    'UK ONLY' as status,
    k.department,
    k.salary
FROM employee_uk k
LEFT JOIN employee_us u ON CONCAT(k.first_name, ' ', k.last_name) = CONCAT(u.first_name, ' ', u.last_name)
WHERE u.employeeId IS NULL
ORDER BY status, employee_name;

-- ============================================================================
-- 11. Performance Comparison
-- ============================================================================
-- Monitor UNION performance with US/UK data

SELECT 
    employeeId,
    CONCAT(first_name, ' ', last_name) as employee_name,
    'US' as office
FROM employee_us
WHERE department = 'Engineering'

UNION

SELECT 
    employeeId,
    CONCAT(first_name, ' ', last_name) as employee_name,
    'UK' as office
FROM employee_uk
WHERE department = 'Engineering';

-- Note: Using UNION removes duplicates (if any)
-- Alternative: Could use UNION ALL if duplicates are acceptable
-- Performance: Filter in WHERE clause before UNION is faster

-- ============================================================================
-- 12. Real-World Scenario - Global Employee Report
-- ============================================================================
-- Create comprehensive global employee roster with office information

SELECT 
    'US' as region,
    employeeId,
    CONCAT(first_name, ' ', last_name) as full_name,
    email,
    department,
    salary,
    YEAR(created_date) as join_year

UNION

SELECT 
    'UK' as region,
    employeeId,
    CONCAT(first_name, ' ', last_name) as full_name,
    email,
    department,
    salary,
    YEAR(created_date) as join_year

FROM employee_uk
ORDER BY region, salary DESC, full_name;

-- ============================================================================
-- PRACTICE QUESTIONS
-- ============================================================================
-- Answer these using SET OPERATORS with employee_us and employee_uk:
--
-- Q1: Combine all employees from US and UK using UNION
-- Q2: Find the difference between UNION and UNION ALL
-- Q3: Find employees who exist in BOTH offices (INTERSECT)
-- Q4: Get all employees with salary > $85K from both offices
-- Q5: Find employees only in US office (not in UK)
-- Q6: Identify employees in both offices with same department
-- Q7: Combine employees by department from both offices
-- Q8: Get average salary stats from both offices
-- Q9: Find employees who are in UK but NOT in US
-- Q10: Create a report showing employee counts by department for each office

-- ============================================================================
-- KEY POINTS ABOUT SET OPERATORS
-- ============================================================================
-- ✓ Combine result sets vertically (not like JOINs)
-- ✓ All queries must have same column count
-- ✓ Column types must be compatible
-- ✓ UNION removes duplicates (slower due to sorting)
-- ✓ UNION ALL keeps duplicates (faster, no sorting)
-- ✓ INTERSECT finds common rows
-- ✓ EXCEPT finds rows in first set but not second
-- ✓ Column names from first query are used
-- ✓ ORDER BY and LIMIT apply to entire result
-- ✓ Works across different tables

-- ============================================================================
-- MYSQL SPECIFIC NOTES
-- ============================================================================
-- ✓ UNION fully supported
-- ✓ UNION ALL fully supported
-- ✓ INTERSECT supported in MySQL 8.0+
-- ✗ EXCEPT NOT natively supported (use LEFT JOIN alternative)
-- ✓ Case-insensitive
-- ✓ Parentheses required for LIMIT: (SELECT...) LIMIT 10
-- ✓ ORDER BY and LIMIT must be at end

-- ============================================================================
-- COMMON MISTAKES TO AVOID
-- ============================================================================
-- MISTAKE 1: Different number of columns
-- WRONG:  SELECT a, b FROM t1 UNION SELECT x, y, z FROM t2
-- RIGHT:  SELECT a, b FROM t1 UNION SELECT x, y FROM t2

-- MISTAKE 2: Incompatible data types
-- WRONG:  SELECT emp_id FROM employee UNION SELECT dept_name FROM department
-- RIGHT:  SELECT emp_id FROM employee UNION SELECT dept_id FROM department

-- MISTAKE 3: Expecting specific column names in result
-- WRONG:  SELECT id AS emp_id FROM emp UNION SELECT id AS dept_id FROM dept
--         (Result uses first query's column name: emp_id)
-- RIGHT:  Understand that column names from first query are used

-- MISTAKE 4: Using UNION when UNION ALL is needed
-- WRONG:  SELECT * FROM t1 UNION SELECT * FROM t1 (removes duplicates)
-- RIGHT:  Use UNION ALL if duplicates intended

-- MISTAKE 5: Not using ORDER BY correctly
-- WRONG:  SELECT a FROM t1 ORDER BY a UNION SELECT b FROM t2
-- RIGHT:  SELECT a FROM t1 UNION SELECT b FROM t2 ORDER BY a

-- MISTAKE 6: Forgetting column count matches
-- WRONG:  SELECT a, b, c FROM t1 UNION SELECT x FROM t2
-- RIGHT:  SELECT a, b, c FROM t1 UNION SELECT x, y, z FROM t2

-- MISTAKE 7: Expecting UNION to remove "duplicates" with SELECT *
-- WRONG:  SELECT * FROM emp_us UNION SELECT * FROM emp_uk
--         (Shows 20 rows because emails/salaries differ - not truly duplicate)
-- RIGHT:  SELECT name, dept FROM emp_us UNION SELECT name, dept FROM emp_uk
--         (Shows 18 rows - removes duplicate names by same department)
-- 
-- KEY: UNION compares ALL selected columns!
--      Different email = different row, even if name is same
--      Only select columns that define what a "duplicate" means

-- ============================================================================
-- COMPARISON: SET OPERATORS
-- ============================================================================
--
-- UNION:     Combines, removes duplicates
--            Result = (A + B) - (A ∩ B)
--            Slower (requires sorting/comparison)
--
-- UNION ALL: Combines, keeps duplicates
--            Result = A + B
--            Faster (no sorting)
--
-- INTERSECT: Returns common rows only
--            Result = A ∩ B
--            Rows in BOTH sets
--
-- EXCEPT:    Rows in first but not second
--            Result = A - B
--            MySQL: Use LEFT JOIN alternative

-- ============================================================================
-- ⚠️  COMMON GOTCHA: Why UNION Isn't Removing "Duplicates"
-- ============================================================================
-- 
-- PROBLEM: Users often think "SELECT * FROM table1 UNION SELECT * FROM table2"
--          will remove duplicate rows, but it returns ALL rows!
-- 
-- REASON: UNION compares ALL selected columns, not just keys/names!
--
-- EXAMPLE WITH YOUR DATA:
-- John Smith appears in BOTH tables, but:
--
--   employee_us John Smith:
--     - Email: john.smith@us.company.com
--     - Salary: 75000
--     - Department: Sales
--
--   employee_uk John Smith:
--     - Email: john.smith@uk.company.com  ← DIFFERENT!
--     - Salary: 72000                    ← DIFFERENT!
--     - Department: Sales
--
-- Since ENTIRE ROWS are different (email + salary differ), 
-- UNION considers them DIFFERENT and keeps BOTH!
--
-- Result: 20 rows (10 US + 10 UK) instead of 18 unique names
--
-- ============================================================================
-- SOLUTION: Select only the columns you want to compare
-- ============================================================================
--
-- If you want to find duplicate NAMES only:
--
-- SELECT 
--     CONCAT(first_name, ' ', last_name) as full_name,
--     department,
--     salary
-- FROM employee_uk
-- 
-- UNION
-- 
-- SELECT 
--     CONCAT(first_name, ' ', last_name) as full_name,
--     department,
--     salary
-- FROM employee_us;
--
-- Result: 18 rows (duplicates removed)
-- Why: Now John Smith and Sarah Johnson have same name+dept+salary in both
--
-- ============================================================================
-- DETAILED BREAKDOWN
-- ============================================================================
--
-- SELECT * → Includes ALL columns → No duplicates removed (20 rows)
--   - Different emails = different rows
--   - Different salaries = different rows
--   - UNION keeps both
--
-- SELECT name, dept, salary → Includes only these columns → Duplicates removed (18 rows)
--   - Same name + dept + salary in both tables
--   - UNION recognizes these as duplicates
--   - UNION removes the duplicate
--
-- ============================================================================
-- MORE EXAMPLES OF THIS GOTCHA
-- ============================================================================
--
-- EXAMPLE 1: Products from 2 warehouses
-- SELECT product_id, product_name FROM warehouse_us UNION SELECT product_id, product_name FROM warehouse_uk
-- → May show duplicate product_ids if prices/locations differ
-- 
-- EXAMPLE 2: Employees from 2 companies
-- SELECT emp_id, emp_name FROM company_a UNION SELECT emp_id, emp_name FROM company_b
-- → Duplicate emp_ids removed (same columns compared)
--
-- EXAMPLE 3: Full row comparison
-- SELECT * FROM table1 UNION SELECT * FROM table2
-- → Almost NEVER removes rows (requires ALL columns to match)
-- → Usually use UNION ALL instead when you want to see ALL data
--
-- ============================================================================
-- HOW TO FIX THIS: 3 APPROACHES
-- ============================================================================
--
-- APPROACH 1: Select matching columns only
-- ───────────────────────────────────────────
-- Only select columns that define "duplicates":
-- 
-- SELECT CONCAT(first_name, ' ', last_name) as full_name, department
-- FROM employee_us
-- UNION
-- SELECT CONCAT(first_name, ' ', last_name) as full_name, department
-- FROM employee_uk;
-- Results: 18 rows (John Smith + Sarah Johnson removed)
--
-- APPROACH 2: Use UNION ALL to see everything
-- ────────────────────────────────────────────
-- When you want to see ALL rows (including "duplicates"):
-- 
-- SELECT CONCAT(first_name, ' ', last_name) as full_name, email, salary
-- FROM employee_us
-- UNION ALL
-- SELECT CONCAT(first_name, ' ', last_name) as full_name, email, salary
-- FROM employee_uk;
-- Results: 20 rows (all employees, including duplicate names)
--
-- APPROACH 3: Use DISTINCT if comparing full rows
-- ────────────────────────────────────────────────
-- If you must use SELECT * but want unique rows based on specific columns:
--
-- SELECT DISTINCT 
--     CONCAT(first_name, ' ', last_name) as full_name,
--     department
-- FROM (
--     SELECT * FROM employee_us
--     UNION ALL
--     SELECT * FROM employee_uk
-- ) combined
-- ORDER BY full_name;
-- Results: 18 rows (DISTINCT removes duplicate name+dept combinations)
--
-- ============================================================================
-- KEY INSIGHT: UNION Duplicate Logic
-- ============================================================================
--
-- UNION removes a row when:
-- ✓ ALL selected columns match exactly with another row
-- ✗ If ANY column differs → considered different rows
--
-- Examples:
-- ✓ (1, 'John', 'Sales') matches (1, 'John', 'Sales') → REMOVED
-- ✗ (1, 'John', 'Sales', 75000) vs (1, 'John', 'Sales', 72000) → BOTH KEPT
--    (salary differs, so they're different rows)
-- ✗ (1, 'John', 'john@us.com') vs (1, 'John', 'john@uk.com') → BOTH KEPT
--    (email differs, so they're different rows)
--
-- ============================================================================
-- PERFORMANCE CONSIDERATIONS
-- ============================================================================
--
-- UNION Performance:
--   ⚠️  Slower than UNION ALL (requires sort/dedup)
--   ✓ Use when duplicates must be removed
--   ✓ Index columns used in queries
--
-- UNION ALL Performance:
--   ✓ Faster than UNION (no sorting)
--   ✓ Keeps duplicates
--   ✓ Use for large result sets if duplicates OK
--
-- INTERSECT Performance:
--   ⚠️  Can be slow with large datasets
--   ⚠️  Consider INNER JOIN alternative
--
-- Tips:
--   1. Filter as much as possible BEFORE union
--   2. Use WHERE clause in each SELECT
--   3. Limit result set before combining
--   4. Consider indexes on key columns

-- ============================================================================
-- WHEN TO USE SET OPERATORS
-- ============================================================================
--
-- Use SET OPERATORS when:
--   1. Combining results from multiple queries
--   2. Need to eliminate or show duplicates
--   3. Finding common records (INTERSECT)
--   4. Finding differences (EXCEPT/LEFT JOIN)
--   5. Appending data from multiple sources
--   6. Data reconciliation and comparison
--   7. Complex OR conditions (use UNION)
--   8. Non-sequential result combining
--
-- Use JOINs instead when:
--   1. Combining columns from related tables
--   2. Need filtered rows from specific columns
--   3. Performance critical on large tables
--   4. Simple relationship between tables

-- ============================================================================
-- BEST PRACTICES FOR SET OPERATORS
-- ============================================================================
--
-- 1. Use meaningful column aliases
--    SELECT id AS entity_id, name AS entity_name
--
-- 2. Apply filters BEFORE union
--    Faster than filtering after
--
-- 3. Use UNION ALL if suitable
--    Faster when duplicates acceptable
--
-- 4. Include a type indicator
--    Helps identify which query each row came from
--
-- 5. Order results for clarity
--    Makes result set easier to read
--
-- 6. Test queries individually
--    Ensure each SELECT works alone
--
-- 7. Consider performance
--    Avoid on very large datasets without filtering
--
-- 8. Document column compatibility
--    Others need to understand mappings
--
-- 9. Use parentheses for clarity
--    (SELECT...) UNION (SELECT...)
--
-- 10. Add comments explaining purpose
--     Why this specific union is needed

-- ============================================================================
-- DATABASE COMPATIBILITY MATRIX
-- ============================================================================
--
-- ┌─────────────┬─────────┬────────────┬────────┬────────┬┬────────┐
-- │ Database    │ UNION   │ UNION ALL  │ INTER  │ EXCEPT │ Notes  │
-- ├─────────────┼─────────┼────────────┼────────┼────────┼┬────────┤
-- │ MySQL       │ ✅ Yes  │ ✅ Yes     │ 8.0+   │ ❌ No  │ See alt│
-- │ PostgreSQL  │ ✅ Yes  │ ✅ Yes     │ ✅ Yes │ ✅ Yes │ All OK │
-- │ SQL Server  │ ✅ Yes  │ ✅ Yes     │ ✅ Yes │ ✅ Yes │ All OK │
-- │ Oracle      │ ✅ Yes  │ ✅ Yes     │ ✅ Yes │ MINUS  │ MINUS  │
-- │ SQLite      │ ✅ Yes  │ ✅ Yes     │ ✅ Yes │ ✅ Yes │ All OK │
-- └─────────────┴─────────┴────────────┴────────┴────────┼┴────────┘
--
-- MySQL EXCEPT Alternative: Use LEFT JOIN with IS NULL

/*
================================================================================
  END OF SET OPERATORS GUIDE
================================================================================
  Summary:
  - SET OPERATORS: Combine result sets vertically
  - Types: UNION, UNION ALL, INTERSECT, EXCEPT
  - UNION: Combines, removes duplicates
  - UNION ALL: Combines, keeps duplicates
  - INTERSECT: Finds common rows
  - EXCEPT: Finds unique rows (MySQL: use LEFT JOIN)
  - Support: All databases (MySQL has UNION/UNION ALL/INTERSECT)
  
  Key Insight:
  SET OPERATORS are powerful for combining data and reconciliation.
  Master them for complex queries without excessive JOINs!
  
  KEY REMINDERS:
  1. Same column count required
  2. Compatible data types required
  3. Column names from first query used
  4. ORDER BY goes AFTER all queries
  5. Use UNION ALL for speed when safe
  6. Filter before union for performance
  7. Document your unions clearly
  8. Test each SELECT individually
  9. Consider alternatives for performance
  10. MySQL: EXCEPT requires LEFT JOIN workaround
  
-- ============================================================================
-- CLEANUP (Optional - Run if you want to remove test tables)
-- ============================================================================
-- DROP TABLE IF EXISTS employee_us;
-- DROP TABLE IF EXISTS employee_uk;

/*
================================================================================
  END OF SET OPERATORS GUIDE
================================================================================
  Summary:
  - SET OPERATORS: Combine result sets vertically
  - Types: UNION, UNION ALL, INTERSECT, EXCEPT
  - UNION: Combines, removes duplicates
  - UNION ALL: Combines, keeps duplicates
  - INTERSECT: Finds common rows
  - EXCEPT: Finds unique rows (MySQL: use LEFT JOIN)
  - Support: All databases (MySQL has UNION/UNION ALL/INTERSECT)
  
  Key Insight:
  SET OPERATORS are powerful for combining data and reconciliation.
  Master them for complex queries without excessive JOINs!
  
  WHAT YOU LEARNED:
  1. Created employee_us and employee_uk sample tables
  2. Added 10 employees to each table with overlapping records
  3. Demonstrated UNION to combine and remove duplicates
  4. Showed UNION ALL to keep all records
  5. Used INTERSECT to find common employees
  6. Used EXCEPT alternative (LEFT JOIN) to find unique records
  7. Chained multiple SET OPERATORS
  8. Applied WHERE and ORDER BY with SET OPERATORS
  9. Used aggregation functions with SET OPERATORS
  10. Performed data reconciliation between offices
  
  SAMPLE DATA STRUCTURE:
  - employee_us: 10 employees (US offices)
  - employee_uk: 10 employees (UK offices)
  - Overlapping: John Smith, Sarah Johnson (ID 1-2)
  - US Exclusive: Others with ID 3-10
  - UK Exclusive: Others with ID 11-18
  
  KEY REMINDERS:
  1. Same column count required
  2. Compatible data types required
  3. Column names from first query used
  4. ORDER BY goes AFTER all queries
  5. Use UNION ALL for speed when safe
  6. Filter before union for performance
  7. Document your unions clearly
  8. Test each SELECT individually
  9. Consider alternatives for performance
  10. MySQL: EXCEPT requires LEFT JOIN workaround
  
  For more information:
  - https://dev.mysql.com/doc/refman/8.0/en/union.html
  - https://www.w3schools.com/sql/sql_union.asp
  - Set theory and operations
  - Query optimization techniques
================================================================================
*/
