
/*
================================================================================
  SQL SELECT COMMAND - Tutorial with Employee & Department Tables
================================================================================
  Description: Retrieve and query data from employee and department tables
               using various SELECT techniques and conditions
  
  SCHEMA OVERVIEW:
    - department: departmentId (PK), name
    - employee: employeeId (PK), first_name, last_name, email, salary, departmentId (FK)
  
  RELATIONSHIP TYPE: One-to-Many (Department -> Employees)
  
  SAMPLE DATA:
    Departments (4):
      1. Human Resources
      2. Engineering
      3. Sales
      4. Finance
    
    Employees (4):
      1. John Doe - HR - $50,000
      2. Jane Smith - Engineering - $65,000
      3. Robert Johnson - Sales - $55,000
      4. Emily Brown - Finance - $60,000
================================================================================
*/

-- ===============================================
-- 1. SELECT ALL COLUMNS FROM A TABLE
-- ===============================================
-- Retrieve all data from employee table
SELECT * FROM employee;

-- Retrieve all departments
SELECT * FROM department;

-- ===============================================
-- 2. SELECT SPECIFIC COLUMNS
-- ===============================================
-- Get employee names and salaries only
SELECT employeeId, first_name, last_name, salary FROM employee;

-- Get department IDs and names
SELECT departmentId, name FROM department;

-- ===============================================
-- 3. BASIC JOIN - INNER JOIN (CORRECTED)
-- ===============================================
-- Join employees with their departments
SELECT e.employeeId, e.first_name, e.last_name, e.email, d.name 
FROM employee e 
INNER JOIN department d ON e.departmentId = d.departmentId;

-- ===============================================
-- 4. JOIN WITH WHERE CLAUSE (Traditional Method)
-- ===============================================
-- Alternative: Using WHERE instead of explicit JOIN
SELECT e.employeeId, e.first_name, e.last_name, e.email, d.name 
FROM employee e, department d 
WHERE e.departmentId = d.departmentId;

-- ===============================================
-- 5. SELECT WITH ALIAS
-- ===============================================
-- Give meaningful names to columns
SELECT 
  e.employeeId AS employee_id,
  e.first_name AS first_name,
  e.last_name AS last_name,
  e.email AS email_address,
  e.salary AS annual_salary,
  d.name AS department_name
FROM employee e 
INNER JOIN department d ON e.departmentId = d.departmentId;

-- ===============================================
-- 6. SELECT WITH WHERE CONDITION
-- ===============================================
-- Find all employees in Engineering department
SELECT e.employeeId, e.first_name, e.last_name, e.salary
FROM employee e
INNER JOIN department d ON e.departmentId = d.departmentId
WHERE d.name = 'Engineering';

-- ===============================================
-- 7. SELECT WITH WHERE - Salary Filter
-- ===============================================
-- Find all employees earning more than 55000
SELECT employeeId, first_name, last_name, salary
FROM employee
WHERE salary > 55000.00;

-- ===============================================
-- 8. SELECT WITH ORDER BY
-- ===============================================
-- Sort employees by salary in descending order
SELECT employeeId, first_name, last_name, salary
FROM employee
ORDER BY salary DESC;

-- Sort by department and then by last name
SELECT e.employeeId, e.first_name, e.last_name, e.salary, d.name
FROM employee e
INNER JOIN department d ON e.departmentId = d.departmentId
ORDER BY d.name, e.last_name;

-- ===============================================
-- 9. SELECT WITH LIMIT
-- ===============================================
-- Get top 3 highest paid employees
SELECT employeeId, first_name, last_name, salary
FROM employee
ORDER BY salary DESC
LIMIT 3;

-- Get first 2 employees
SELECT * FROM employee LIMIT 2;

-- ===============================================
-- 10. SELECT WITH DISTINCT
-- ===============================================
-- Get unique department IDs from employee table
SELECT DISTINCT departmentId FROM employee;

-- Get list of all departments that have employees
SELECT DISTINCT d.departmentId, d.name
FROM employee e
INNER JOIN department d ON e.departmentId = d.departmentId;

-- ===============================================
-- 11. SELECT WITH AGGREGATE FUNCTIONS
-- ===============================================
-- Count total employees
SELECT COUNT(*) as total_employees FROM employee;

-- Count employees per department
SELECT d.name, COUNT(*) as employee_count
FROM employee e
INNER JOIN department d ON e.departmentId = d.departmentId
GROUP BY d.departmentId, d.name;

-- ===============================================
-- 12. SELECT WITH SUM, AVG, MAX, MIN
-- ===============================================
-- Calculate total salary expense
SELECT SUM(salary) as total_payroll FROM employee;

-- Calculate average salary by department
SELECT d.name, AVG(e.salary) as average_salary
FROM employee e
INNER JOIN department d ON e.departmentId = d.departmentId
GROUP BY d.departmentId, d.name;

-- Find highest and lowest paid employees
SELECT 
  MAX(salary) as highest_salary,
  MIN(salary) as lowest_salary,
  AVG(salary) as average_salary
FROM employee;

-- ===============================================
-- 13. SELECT WITH GROUP BY and HAVING
-- ===============================================
-- Get departments with average salary > 55000
SELECT d.name, AVG(e.salary) as average_salary
FROM employee e
INNER JOIN department d ON e.departmentId = d.departmentId
GROUP BY d.departmentId, d.name
HAVING AVG(e.salary) > 55000;

-- ===============================================
-- 14. SELECT WITH BETWEEN
-- ===============================================
-- Find employees with salary between 50000 and 60000
SELECT employeeId, first_name, last_name, salary
FROM employee
WHERE salary BETWEEN 50000.00 AND 60000.00;

-- ===============================================
-- 15. SELECT WITH IN CLAUSE
-- ===============================================
-- Find employees in specific departments (1, 3, 4)
SELECT e.employeeId, e.first_name, e.last_name, d.name
FROM employee e
INNER JOIN department d ON e.departmentId = d.departmentId
WHERE e.departmentId IN (1, 3, 4);

-- ===============================================
-- 16. SELECT WITH LIKE (String Matching)
-- ===============================================
-- Find employees whose first name starts with 'J'
SELECT employeeId, first_name, last_name, email
FROM employee
WHERE first_name LIKE 'J%';

-- Find employees with 'son' in their last name
SELECT employeeId, first_name, last_name
FROM employee
WHERE last_name LIKE '%son%';

-- ===============================================
-- 17. SELECT WITH LEFT JOIN
-- ===============================================
-- Get all departments even if they have no employees
SELECT d.departmentId, d.name, e.employeeId, e.first_name
FROM department d
LEFT JOIN employee e ON d.departmentId = e.departmentId;

-- ===============================================
-- 18. SELECT WITH RIGHT JOIN
-- ===============================================
-- Get all employees and their departments (right side is employee)
SELECT e.employeeId, e.first_name, e.last_name, d.name
FROM department d
RIGHT JOIN employee e ON d.departmentId = e.departmentId;

-- ===============================================
-- 19. SELECT WITH CONCATENATION
-- ===============================================
-- Combine first and last names into full name
SELECT 
  employeeId,
  CONCAT(first_name, ' ', last_name) as full_name,
  email,
  salary
FROM employee;

-- ===============================================
-- 20. SELECT WITH CASE STATEMENT
-- ===============================================
-- Categorize employees by salary level
SELECT 
  employeeId,
  first_name,
  last_name,
  salary,
  CASE
    WHEN salary >= 60000 THEN 'High'
    WHEN salary >= 55000 THEN 'Medium'
    ELSE 'Low'
  END as salary_category
FROM employee;

-- ===============================================
-- PRACTICE QUERIES - Uncomment to use
-- ===============================================

-- Example 1: Find all HR employees
SELECT e.employeeId, e.first_name, e.last_name, e.salary, d.name
FROM employee e
INNER JOIN department d ON e.departmentId = d.departmentId
WHERE d.name = 'Human Resources';

-- Example 2: Get employees sorted by department and salary (highest first)
SELECT e.employeeId, e.first_name, e.last_name, e.salary, d.name
FROM employee e
INNER JOIN department d ON e.departmentId = d.departmentId
ORDER BY d.name, e.salary DESC;

-- Example 3: Get department with total salary expense
SELECT d.name, COUNT(*) as emp_count, SUM(e.salary) as total_payroll, AVG(e.salary) as avg_salary
FROM employee e
INNER JOIN department d ON e.departmentId = d.departmentId
GROUP BY d.departmentId, d.name;

-- Example 4: Find second highest paid employee
SELECT employeeId, first_name, last_name, salary
FROM employee
ORDER BY salary DESC
LIMIT 1 OFFSET 1;

-- Example 5: Get employee details with calculated bonus (15% of salary)
SELECT 
  employeeId,
  CONCAT(first_name, ' ', last_name) as name,
  salary,
  (salary * 0.15) as bonus_amount
FROM employee
ORDER BY salary DESC;

-- ===============================================
-- KEY SQL CLAUSES & FUNCTIONS REFERENCE
-- ===============================================
-- SELECT: Choose columns to display
-- FROM: Specify table(s)
-- JOIN: Combine data from multiple tables (INNER, LEFT, RIGHT, FULL)
-- WHERE: Filter rows based on conditions
-- GROUP BY: Group rows by column values
-- HAVING: Filter groups after aggregation
-- ORDER BY: Sort results (ASC ascending, DESC descending)
-- LIMIT: Limit number of rows returned
-- OFFSET: Skip rows (used with LIMIT)
-- DISTINCT: Remove duplicates
-- AS: Rename columns/tables (alias)
-- 
-- AGGREGATE FUNCTIONS:
-- COUNT(): Count rows
-- SUM(): Sum values
-- AVG(): Calculate average
-- MAX(): Find maximum
-- MIN(): Find minimum
-- CONCAT(): Combine strings
-- LIKE: Pattern matching (%, _)
-- IN: Check if value is in list
-- BETWEEN: Check range
-- CASE: Conditional logic
-- ===============================================