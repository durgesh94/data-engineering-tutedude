/*
================================================================================
  SQL SELECT & WHERE CLAUSES - Tutorial
================================================================================
  Description: Retrieve and filter data from tables using SELECT and WHERE
               Learn how to select specific columns, filter rows, and combine
               multiple conditions for powerful data retrieval
  
  SCHEMA OVERVIEW:
    - department: departmentId (PK), name, manager_email
    - employee: employeeId (PK), first_name, last_name, email, salary, departmentId (FK)
    - project: projectId (PK), project_name, description, start_date, end_date, 
               budget, departmentId (FK), status
    - project_assignment: assignment_id (PK), employeeId (FK), projectId (FK), 
                          role, allocation_percentage, assignment_date
  
  LEARNING OBJECTIVES:
    - Master SELECT statement syntax and variations
    - Learn WHERE clause for filtering data
    - Combine multiple conditions (AND, OR, NOT)
    - Use comparison operators (<, >, =, !=, <=, >=)
    - Understand column aliases and calculated fields
    - Filter using patterns (LIKE, IN, BETWEEN)
  
  ⚠️  TIPS FOR SUCCESS ⚠️
    - Always test SELECT before creating complex queries
    - Use LIMIT to preview results safely
    - Index on columns frequently used in WHERE clause
    - Order results for better readability
================================================================================
*/

-- ===============================================
-- SQL CLAUSE SEQUENCE - EXECUTION ORDER
-- ===============================================
/*
IMPORTANT: SQL clauses must be written in this EXACT order!

┌─────────────────────────────────────────────────────────────────────────┐
│ CLAUSE EXECUTION ORDER (What you WRITE vs What database EXECUTES):     │
├──────┬──────────────────┬────────────┬──────────────────────────────────┤
│ Step │ Clause           │ Required?  │ Purpose                          │
├──────┼──────────────────┼────────────┼──────────────────────────────────┤
│ 1    │ SELECT           │ Required   │ Choose which columns to display  │
│ 2    │ FROM             │ Required   │ Specify table(s) to query       │
│ 3    │ JOIN             │ Optional   │ Combine data from multiple tables│
│ 4    │ WHERE            │ Optional   │ Filter rows based on conditions │
│ 5    │ GROUP BY         │ Optional   │ Group rows by column values     │
│ 6    │ HAVING           │ Optional   │ Filter groups (after GROUP BY)  │
│ 7    │ ORDER BY         │ Optional   │ Sort results                    │
│ 8    │ LIMIT            │ Optional   │ Limit number of rows returned   │
└──────┴──────────────────┴────────────┴──────────────────────────────────┘

BASIC SYNTAX:
  SELECT column1, column2, ...
  FROM table_name
  WHERE condition
  ORDER BY column
  LIMIT 10;

EXTENDED SYNTAX (with all clauses):
  SELECT column1, column2, ...
  FROM table1
  JOIN table2 ON table1.id = table2.id
  WHERE condition1 AND condition2
  GROUP BY column1
  HAVING condition3
  ORDER BY column1 DESC, column2 ASC
  LIMIT 100;

EXECUTION ORDER (database processes in this order):
  1. FROM - Get the data source(s)
  2. JOIN - Combine tables
  3. WHERE - Filter rows
  4. GROUP BY - Aggregate rows
  5. HAVING - Filter aggregated data
  6. SELECT - Choose columns to display
  7. ORDER BY - Sort the results
  8. LIMIT - Get top N results

REMEMBER: The order you WRITE clauses must match the order above,
          but the database EXECUTES them in a different order!
*/

-- Example 1: Basic SELECT with WHERE
SELECT employeeId, first_name, last_name, salary
FROM employee
WHERE departmentId = 2;

-- Example 2: SELECT with WHERE and ORDER BY
SELECT employeeId, first_name, last_name, salary
FROM employee
WHERE salary > 55000
ORDER BY salary DESC;

-- Example 3: SELECT with WHERE, ORDER BY, and LIMIT
SELECT employeeId, first_name, last_name, salary
FROM employee
WHERE departmentId = 2 AND salary > 55000
ORDER BY salary DESC
LIMIT 5;

-- Example 4: Complex query with multiple clauses
SELECT 
  project_name,
  budget,
  DATEDIFF(end_date, start_date) AS duration_days
FROM project
WHERE status = 'Active' AND budget > 250000
ORDER BY budget DESC
LIMIT 10;

-- ===============================================
-- PART 1: BASIC SELECT STATEMENTS
-- ===============================================

-- ===============================================
-- 1. SELECT ALL COLUMNS FROM TABLE
-- ===============================================
-- Retrieve every column and every row
SELECT * FROM employee;

-- View all departments
SELECT * FROM department;

-- View all projects
SELECT * FROM project;

-- ===============================================
-- 2. SELECT SPECIFIC COLUMNS
-- ===============================================
-- Retrieve only the columns you need (best practice)

-- Get employee names and salaries
SELECT employeeId, first_name, last_name, salary 
FROM employee;

-- Get department names only
SELECT name FROM department;

-- Get project names and budgets
SELECT project_name, budget 
FROM project;

-- ===============================================
-- 3. SELECT WITH COLUMN ALIASES (AS)
-- ===============================================
-- Rename columns in output for better readability

SELECT 
  employeeId AS emp_id,
  first_name AS fname,
  last_name AS lname,
  salary AS annual_salary
FROM employee;

-- Alias for readability
SELECT 
  project_name AS project,
  budget AS project_budget,
  start_date AS start,
  end_date AS end
FROM project;

-- ===============================================
-- 4. SELECT WITH CONCATENATION
-- ===============================================
-- Combine columns to create new information

-- Combine first and last name
SELECT 
  employeeId,
  CONCAT(first_name, ' ', last_name) AS full_name,
  email,
  salary
FROM employee;

-- Combine department info
SELECT 
  departmentId,
  CONCAT('Department: ', name) AS dept_info
FROM department;

-- ===============================================
-- 5. SELECT WITH CALCULATED FIELDS
-- ===============================================
-- Create new columns using calculations

-- Calculate monthly salary
SELECT 
  employeeId,
  first_name,
  last_name,
  salary,
  (salary / 12) AS monthly_salary
FROM employee;

-- Calculate project duration
SELECT 
  projectId,
  project_name,
  DATEDIFF(end_date, start_date) AS days_duration
FROM project;

-- ===============================================
-- PART 2: WHERE CLAUSE - BASIC FILTERING
-- ===============================================

-- ===============================================
-- 6. WHERE WITH EQUALITY (=)
-- ===============================================
-- Find rows where a column equals a specific value

-- Find employee with ID 1
SELECT * FROM employee
WHERE employeeId = 1;

-- Find all employees in department 2 (Engineering)
SELECT * FROM employee
WHERE departmentId = 2;

-- Find project with ID 1
SELECT * FROM project
WHERE projectId = 1;

-- ===============================================
-- 7. WHERE WITH NOT EQUAL (!=, <>)
-- ===============================================
-- Find rows where a column does NOT equal a value

-- Find all employees NOT in department 1
SELECT * FROM employee
WHERE departmentId != 1;

-- Alternative syntax (same as !=)
SELECT * FROM employee
WHERE departmentId <> 1;

-- Find projects that are NOT completed
SELECT * FROM project
WHERE status != 'Completed';

-- ===============================================
-- 8. WHERE WITH GREATER THAN (>)
-- ===============================================
-- Find rows where a column value is greater than specified value

-- Find all employees earning more than 60000
SELECT employeeId, first_name, last_name, salary
FROM employee
WHERE salary > 60000;

-- Find projects with budget over 500000
SELECT project_name, budget
FROM project
WHERE budget > 500000;

-- ===============================================
-- 9. WHERE WITH LESS THAN (<)
-- ===============================================
-- Find rows where a column value is less than specified value

-- Find employees earning less than 55000
SELECT employeeId, first_name, last_name, salary
FROM employee
WHERE salary < 55000;

-- Find projects with small budget
SELECT project_name, budget
FROM project
WHERE budget < 200000;

-- ===============================================
-- 10. WHERE WITH GREATER THAN OR EQUAL (>=)
-- ===============================================
-- Find rows greater than OR equal to specified value

SELECT employeeId, first_name, last_name, salary
FROM employee
WHERE salary >= 55000;

-- ===============================================
-- 11. WHERE WITH LESS THAN OR EQUAL (<=)
-- ===============================================
-- Find rows less than OR equal to specified value

SELECT employeeId, first_name, last_name, salary
FROM employee
WHERE salary <= 60000;

-- ===============================================
-- PART 3: WHERE CLAUSE - ADVANCED FILTERING
-- ===============================================

-- ===============================================
-- 12. WHERE WITH AND CONDITION
-- ===============================================
-- Find rows that match MULTIPLE conditions (all must be true)

-- Find employees in Engineering earning > 60000
SELECT employeeId, first_name, last_name, salary, departmentId
FROM employee
WHERE departmentId = 2 AND salary > 60000;

-- Find projects that are Active and have budget > 300000
SELECT project_name, status, budget
FROM project
WHERE status = 'Active' AND budget > 300000;

-- ===============================================
-- 13. WHERE WITH OR CONDITION
-- ===============================================
-- Find rows that match ANY condition (at least one must be true)

-- Find employees in HR OR Finance departments
SELECT employeeId, first_name, last_name, departmentId
FROM employee
WHERE departmentId = 1 OR departmentId = 4;

-- Find projects that are Active OR On Hold
SELECT project_name, status
FROM project
WHERE status = 'Active' OR status = 'On Hold';

-- ===============================================
-- 14. WHERE WITH AND & OR COMBINED
-- ===============================================
-- Mix AND and OR conditions (use parentheses for clarity)

-- Employees in Engineering earning > 60k OR Finance earning > 55k
SELECT employeeId, first_name, last_name, salary, departmentId
FROM employee
WHERE (departmentId = 2 AND salary > 60000) 
   OR (departmentId = 4 AND salary > 55000);

-- Projects that are Active in Engineering/IT departments with budget > 250k
SELECT project_name, status, budget, departmentId
FROM project
WHERE status = 'Active' 
  AND (departmentId = 2 OR departmentId = 1)
  AND budget > 250000;

-- ===============================================
-- 15. WHERE WITH NOT CONDITION
-- ===============================================
-- Find rows that do NOT match a condition

-- Find employees NOT in department 3
SELECT * FROM employee
WHERE NOT (departmentId = 3);

-- Find projects that are NOT completed
SELECT * FROM project
WHERE NOT (status = 'Completed');

-- ===============================================
-- 16. WHERE WITH IN CLAUSE
-- ===============================================
-- Find rows where column matches ANY value in a list

-- Find employees in specific departments (1, 2, 4)
SELECT employeeId, first_name, last_name, departmentId
FROM employee
WHERE departmentId IN (1, 2, 4);

-- Find projects with specific statuses
SELECT project_name, status
FROM project
WHERE status IN ('Active', 'On Hold');

-- Find employees with ID 1, 3, or 5
SELECT * FROM employee
WHERE employeeId IN (1, 3, 5);

-- ===============================================
-- 17. WHERE WITH NOT IN CLAUSE
-- ===============================================
-- Find rows where column does NOT match any value in list

-- Find employees NOT in departments 2 or 3
SELECT * FROM employee
WHERE departmentId NOT IN (2, 3);

-- Find projects NOT in Active or Completed status
SELECT * FROM project
WHERE status NOT IN ('Active', 'Completed');

-- ===============================================
-- 18. WHERE WITH BETWEEN
-- ===============================================
-- Find rows where column value is within a range (inclusive)

-- Find employees with salary between 50000 and 65000
SELECT employeeId, first_name, last_name, salary
FROM employee
WHERE salary BETWEEN 50000 AND 65000;

-- Find projects with budget between 200000 and 500000
SELECT project_name, budget
FROM project
WHERE budget BETWEEN 200000 AND 500000;

-- Find projects started between 2025 and 2026
SELECT project_name, start_date
FROM project
WHERE start_date BETWEEN '2025-01-01' AND '2026-12-31';

-- ===============================================
-- 19. WHERE WITH NOT BETWEEN
-- ===============================================
-- Find rows where value is OUTSIDE a range

-- Find employees earning NOT between 50k and 60k
SELECT employeeId, first_name, last_name, salary
FROM employee
WHERE salary NOT BETWEEN 50000 AND 60000;

-- ===============================================
-- 20. WHERE WITH LIKE (Pattern Matching)
-- ===============================================
-- Find rows where text matches a pattern
-- % = any number of characters, _ = single character

-- Find employees whose first name starts with 'J'
SELECT employeeId, first_name, last_name
FROM employee
WHERE first_name LIKE 'J%';

-- Find employees whose last name contains 'son'
SELECT employeeId, first_name, last_name
FROM employee
WHERE last_name LIKE '%son%';

-- Find emails containing 'example'
SELECT email FROM employee
WHERE email LIKE '%example%';

-- Find project names starting with 'Data'
SELECT project_name FROM project
WHERE project_name LIKE 'Data%';

-- ===============================================
-- 21. WHERE WITH NOT LIKE
-- ===============================================
-- Find rows where text does NOT match a pattern

-- Find employees whose first name does NOT start with 'J'
SELECT employeeId, first_name, last_name
FROM employee
WHERE first_name NOT LIKE 'J%';

-- ===============================================
-- 22. WHERE WITH NULL CHECK
-- ===============================================
-- Find rows where a column IS NULL or IS NOT NULL

-- Find employees without email assigned
SELECT employeeId, first_name, last_name, email
FROM employee
WHERE email IS NULL;

-- Find employees WITH email assigned
SELECT employeeId, first_name, last_name, email
FROM employee
WHERE email IS NOT NULL;

-- Find projects without description
SELECT projectId, project_name
FROM project
WHERE description IS NULL;

-- ===============================================
-- PART 4: SELECT & WHERE COMBINED - PRACTICAL EXAMPLES
-- ===============================================

-- ===============================================
-- 23. SELECT & WHERE WITH ORDER BY
-- ===============================================
-- Get filtered results sorted in specific order

-- Get high earning employees sorted by salary (highest first)
SELECT employeeId, first_name, last_name, salary
FROM employee
WHERE salary > 55000
ORDER BY salary DESC;

-- Get Engineering projects sorted by budget (lowest first)
SELECT project_name, budget, status
FROM project
WHERE departmentId = 2
ORDER BY budget ASC;

-- ===============================================
-- 24. SELECT & WHERE WITH LIMIT
-- ===============================================
-- Get top N results after filtering

-- Get top 3 highest paid employees
SELECT employeeId, first_name, last_name, salary
FROM employee
WHERE departmentId = 2
ORDER BY salary DESC
LIMIT 3;

-- Get first 5 active projects
SELECT project_name, budget
FROM project
WHERE status = 'Active'
LIMIT 5;

-- ===============================================
-- 25. SELECT & WHERE WITH DISTINCT
-- ===============================================
-- Get unique/distinct values from filtered results

-- Get list of all departments that have employees
SELECT DISTINCT departmentId
FROM employee;

-- Get unique statuses of projects in Engineering
SELECT DISTINCT status
FROM project
WHERE departmentId = 2;

-- ===============================================
-- PART 5: PRACTICAL BUSINESS QUERIES
-- ===============================================

-- ===============================================
-- 26. Company Reporting Queries
-- ===============================================

-- Find all employees in HR department with their salaries
SELECT 
  CONCAT(first_name, ' ', last_name) AS full_name,
  email,
  salary
FROM employee
WHERE departmentId = 1
ORDER BY last_name;

-- Find all active projects with budget over 300k
SELECT 
  project_name,
  budget,
  DATEDIFF(end_date, start_date) AS project_duration_days
FROM project
WHERE status = 'Active' AND budget > 300000
ORDER BY budget DESC;

-- Find expensive employees (>60k) in Engineering
SELECT 
  employeeId,
  CONCAT(first_name, ' ', last_name) AS name,
  salary,
  (salary / 12) AS monthly_pay
FROM employee
WHERE departmentId = 2 AND salary > 60000;

-- Find projects ending soon (within 30 days)
SELECT 
  project_name,
  end_date,
  status
FROM project
WHERE end_date BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 30 DAY)
ORDER BY end_date;

-- ===============================================
-- PRACTICE EXAMPLES - Uncomment to use
-- ===============================================

-- Example 1: Find all Sales employees
-- SELECT * FROM employee WHERE departmentId = 3;

-- Example 2: Find employees with salary between 50k-60k in Engineering
-- SELECT * FROM employee 
-- WHERE departmentId = 2 AND salary BETWEEN 50000 AND 60000;

-- Example 3: Find projects that are Active or On Hold
-- SELECT * FROM project 
-- WHERE status IN ('Active', 'On Hold');

-- Example 4: Find employees whose last name starts with 'J'
-- SELECT * FROM employee WHERE last_name LIKE 'J%';

-- Example 5: Find employees NOT in HR and Finance
-- SELECT * FROM employee WHERE departmentId NOT IN (1, 4);

-- ===============================================
-- SELECT & WHERE - QUICK REFERENCE
-- ===============================================
/*
COMPARISON OPERATORS:
  = Equal to
  != Not equal (or <>)
  > Greater than
  < Less than
  >= Greater than or equal
  <= Less than or equal

LOGICAL OPERATORS:
  AND Both conditions must be true
  OR At least one condition must be true
  NOT Reverses the condition

PATTERN MATCHING:
  LIKE Match pattern (% any chars, _ single char)
  IN Match any value in list
  BETWEEN Match range (inclusive)
  IS NULL/IS NOT NULL Check for null values

MODIFIERS:
  NOT Inverse the condition
  DISTINCT Remove duplicates
  ORDER BY Sort results
  LIMIT Top N results
*/

-- ===============================================
-- KEY POINTS TO REMEMBER
-- ===============================================
-- 1. SELECT * gets all columns; specify columns for better performance
-- 2. WHERE filters rows BEFORE SELECT displays them
-- 3. AND requires ALL conditions; OR requires ANY condition
-- 4. Use parentheses to clarify complex conditions
-- 5. NULL values require IS NULL or IS NOT NULL
-- 6. LIKE is case-insensitive in most databases
-- 7. BETWEEN is inclusive (includes start and end values)
-- 8. IN clause is often faster than multiple OR conditions
-- 9. Indexes on WHERE columns improve query performance
-- 10. Always validate filtered results before use
-- 11. Use LIMIT while testing to prevent overloading results
-- 12. Order results for better readability and analysis
-- ===============================================
