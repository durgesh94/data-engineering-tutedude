/*
================================================================================
  SQL SORTING (ORDER BY) & ALIASES (AS) - Tutorial
================================================================================
  Description: Master SQL ORDER BY for sorting and AS for renaming columns
               and tables. Learn how to organize data and create meaningful
               names for better readability and analysis
  
  SCHEMA OVERVIEW:
    - department: departmentId (PK), name, manager_email
    - employee: employeeId (PK), first_name, last_name, email, salary, departmentId (FK)
    - project: projectId (PK), project_name, description, start_date, end_date, 
               budget, departmentId (FK), status
    - project_assignment: assignment_id (PK), employeeId (FK), projectId (FK), 
                          role, allocation_percentage, assignment_date
  
  LEARNING OBJECTIVES:
    - Use ORDER BY for ascending (ASC) and descending (DESC) sorting
    - Sort by multiple columns with different directions
    - Create column aliases with AS keyword
    - Create table aliases for shorter references
    - Combine aliases with calculated fields
    - Improve query readability and performance
  
  ⚠️  KEY CONCEPTS ⚠️
    - ORDER BY MUST come AFTER WHERE clause
    - Default sort is ASCENDING (ASC)
    - Can sort by column name, column number, or alias
    - NULL values sort first (or last, database dependent)
    - Aliases don't affect actual table/column names in database
    - Table aliases improve readability in complex queries
================================================================================
*/

-- ===============================================
-- PART 1: ORDER BY - BASIC SORTING
-- ===============================================

-- ===============================================
-- 1. ORDER BY - ASCENDING (ASC) - Default
-- ===============================================
-- Sort results from smallest to largest (A-Z for text)

-- Sort employees by salary (lowest to highest)
SELECT employeeId, first_name, last_name, salary
FROM employee
ORDER BY salary;

-- Sort employees by last name alphabetically
SELECT employeeId, first_name, last_name, salary
FROM employee
ORDER BY last_name ASC;

-- Sort projects by budget (smallest to largest)
SELECT projectId, project_name, budget
FROM project
ORDER BY budget;

-- ===============================================
-- 2. ORDER BY - DESCENDING (DESC)
-- ===============================================
-- Sort results from largest to smallest (Z-A for text)

-- Sort employees by salary (highest to lowest)
SELECT employeeId, first_name, last_name, salary
FROM employee
ORDER BY salary DESC;

-- Sort projects by budget (largest to smallest)
SELECT projectId, project_name, budget
FROM project
ORDER BY budget DESC;

-- Sort departments by name in reverse order
SELECT departmentId, name
FROM department
ORDER BY name DESC;

-- ===============================================
-- 3. ORDER BY - MULTIPLE COLUMNS (Single Direction)
-- ===============================================
-- Sort by first column, then by second column if first is equal

-- Sort employees by department, then by salary within each department
SELECT employeeId, first_name, last_name, salary, departmentId
FROM employee
ORDER BY departmentId, salary;

-- Sort projects by department, then by status
SELECT projectId, project_name, departmentId, status
FROM project
ORDER BY departmentId, status;

-- ===============================================
-- 4. ORDER BY - MULTIPLE COLUMNS (Mixed Directions)
-- ===============================================
-- Sort ascending on some columns, descending on others

-- Sort by department ASC, then by salary DESC (highest paid first within each dept)
SELECT employeeId, first_name, last_name, salary, departmentId
FROM employee
ORDER BY departmentId ASC, salary DESC;

-- Sort projects by status ASC (alphabetically), then by budget DESC (highest first)
SELECT projectId, project_name, status, budget
FROM project
ORDER BY status ASC, budget DESC;

-- Sort employees by last name DESC, then by first name DESC
SELECT employeeId, first_name, last_name
FROM employee
ORDER BY last_name DESC, first_name DESC;

-- ===============================================
-- 5. ORDER BY - COLUMN POSITION (by number)
-- ===============================================
-- Sort by column position instead of name (less recommended)

-- Sort by 3rd column (salary) ascending
SELECT employeeId, first_name, last_name, salary
FROM employee
ORDER BY 4;

-- Sort by 1st column DESC, then 2nd column ASC
SELECT project_name, budget, status
FROM project
ORDER BY 1 DESC, 2 ASC;

-- ===============================================
-- 6. ORDER BY - With WHERE Clause
-- ===============================================
-- Combine WHERE filtering with ORDER BY sorting

-- Get Engineering employees sorted by salary (highest first)
SELECT employeeId, first_name, last_name, salary, departmentId
FROM employee
WHERE departmentId = 2
ORDER BY salary DESC;

-- Get active projects sorted by budget
SELECT projectId, project_name, budget, status
FROM project
WHERE status = 'Active'
ORDER BY budget DESC;

-- Get employees earning > 60000, sorted by department and name
SELECT employeeId, first_name, last_name, salary, departmentId
FROM employee
WHERE salary > 60000
ORDER BY departmentId, first_name;

-- ===============================================
-- PART 2: ALIASES - Column & Table Renaming
-- ===============================================

-- ===============================================
-- 7. COLUMN ALIAS - Using AS keyword
-- ===============================================
-- Rename a column in output for better readability

-- Rename columns with AS
SELECT 
  employeeId AS emp_id,
  first_name AS fname,
  last_name AS lname,
  salary AS annual_salary
FROM employee;

-- Rename columns for clarity
SELECT 
  projectId AS project_number,
  project_name AS project_title,
  budget AS project_budget,
  status AS project_status
FROM project;

-- Rename with meaningful names
SELECT 
  departmentId AS dept_id,
  name AS department_name
FROM department;

-- ===============================================
-- 8. COLUMN ALIAS - Without AS keyword
-- ===============================================
-- AS is optional in most databases (but recommended)

-- Column alias without AS
SELECT 
  employeeId emp_id,
  first_name fname,
  salary annual_salary
FROM employee;

-- Mix with and without AS
SELECT 
  employeeId AS id,
  first_name first_name_of_employee,
  last_name AS lname
FROM employee;

-- ===============================================
-- 9. COLUMN ALIAS - For Calculated Fields
-- ===============================================
-- Use aliases for derived/calculated columns

-- Calculate and alias salary information
SELECT 
  employeeId,
  CONCAT(first_name, ' ', last_name) AS full_name,
  salary AS annual_salary,
  (salary / 12) AS monthly_salary,
  (salary / 52) AS weekly_salary,
  (salary / 365) AS daily_salary
FROM employee;

-- Calculate project duration with alias
SELECT 
  projectId,
  project_name AS project,
  start_date AS start,
  end_date AS end,
  DATEDIFF(end_date, start_date) AS duration_days
FROM project;

-- Calculate assignment percentages
SELECT 
  assignment_id AS assign_num,
  employeeId AS emp_id,
  projectId AS proj_id,
  role AS employee_role,
  allocation_percentage AS allocated_percent
FROM project_assignment;

-- ===============================================
-- 10. TABLE ALIAS - Using AS for table names
-- ===============================================
-- Shorten table references, useful in complex queries

-- Table alias in SELECT with WHERE
SELECT 
  e.employeeId,
  e.first_name,
  e.last_name,
  e.salary
FROM employee AS e
WHERE e.salary > 60000
ORDER BY e.salary DESC;

-- Multiple table aliases
SELECT 
  d.departmentId,
  d.name,
  e.employeeId,
  e.first_name
FROM department AS d
JOIN employee AS e ON d.departmentId = e.departmentId;

-- Short alias names (single letter)
SELECT 
  p.projectId,
  p.project_name,
  p.budget,
  p.status
FROM project p
WHERE p.status = 'Active';

-- ===============================================
-- 11. TABLE ALIAS - Without AS keyword
-- ===============================================
-- AS is optional for table aliases too

-- Table alias without AS
SELECT 
  e.employeeId,
  e.first_name,
  e.last_name,
  e.departmentId
FROM employee e;

-- Multiple tables without AS
SELECT 
  d.name,
  e.first_name,
  e.salary
FROM department d
JOIN employee e ON d.departmentId = e.departmentId;

-- ===============================================
-- PART 3: COMBINING ORDER BY & ALIASES
-- ===============================================

-- ===============================================
-- 12. Aliases with ORDER BY (by column name)
-- ===============================================
-- Use aliases in ORDER BY clause

-- Sort by aliased column (by name)
SELECT 
  employeeId AS emp_id,
  first_name AS fname,
  last_name AS lname,
  salary AS annual_salary
FROM employee
ORDER BY annual_salary DESC;

-- Multiple aliases with sorting
SELECT 
  projectId AS project_num,
  project_name AS project,
  budget AS project_budget,
  status
FROM project
ORDER BY project_budget DESC, project ASC;

-- ===============================================
-- 13. Aliases with ORDER BY (by position)
-- ===============================================
-- Sort by column position using aliases

-- Order by 4th column (aliased as annual_salary)
SELECT 
  employeeId AS emp_id,
  first_name,
  last_name,
  salary AS annual_salary
FROM employee
ORDER BY 4 DESC;

-- Order by position 2, then position 1
SELECT 
  employeeId AS id,
  CONCAT(first_name, ' ', last_name) AS full_name,
  salary AS sal
FROM employee
ORDER BY 2 ASC, 1 DESC;

-- ===============================================
-- 14. Complex Query - Aliases + Calculations + Sorting
-- ===============================================
-- Advanced example combining multiple concepts

-- Detailed employee salary report
SELECT 
  e.employeeId AS employee_id,
  CONCAT(e.first_name, ' ', e.last_name) AS full_name,
  e.salary AS annual_salary,
  (e.salary / 12) AS monthly_salary,
  (e.salary * 0.12) AS annual_bonus,
  d.name AS department
FROM employee e
JOIN department d ON e.departmentId = d.departmentId
WHERE e.salary > 50000
ORDER BY e.salary DESC, e.first_name ASC;

-- Project analysis report
SELECT 
  p.projectId AS project_number,
  p.project_name AS project_title,
  p.budget AS total_budget,
  p.status AS project_status,
  DATEDIFF(p.end_date, p.start_date) AS duration_days,
  d.name AS managing_department
FROM project p
JOIN department d ON p.departmentId = d.departmentId
WHERE p.status != 'Completed'
ORDER BY d.name ASC, p.budget DESC;

-- ===============================================
-- PART 4: PRACTICAL BUSINESS QUERIES
-- ===============================================

-- ===============================================
-- 15. Employee Ranking by Department
-- ===============================================
-- List employees sorted by department and salary

SELECT 
  d.name AS department,
  CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
  e.salary AS annual_salary,
  (e.salary / 12) AS monthly_salary
FROM employee e
JOIN department d ON e.departmentId = d.departmentId
ORDER BY d.name ASC, e.salary DESC;

-- ===============================================
-- 16. Project Timeline Report
-- ===============================================
-- Show all projects sorted by start date

SELECT 
  projectId AS proj_id,
  project_name AS project,
  start_date AS start,
  end_date AS end,
  DATEDIFF(end_date, start_date) AS duration,
  budget AS project_budget,
  status
FROM project
ORDER BY start_date ASC;

-- ===============================================
-- 17. High Cost Project Analysis
-- ===============================================
-- List expensive projects sorted by budget

SELECT 
  p.projectId AS project_num,
  p.project_name AS project_title,
  p.budget AS project_cost,
  d.name AS department,
  p.status AS current_status
FROM project p
JOIN department d ON p.departmentId = d.departmentId
WHERE p.budget > 200000
ORDER BY p.budget DESC, p.project_name ASC;

-- ===============================================
-- 18. Employee Assignment Summary
-- ===============================================
-- Show employee assignments sorted by employee name

SELECT 
  CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
  p.project_name AS assigned_project,
  pa.role AS assignment_role,
  pa.allocation_percentage AS time_allocated
FROM project_assignment pa
JOIN employee e ON pa.employeeId = e.employeeId
JOIN project p ON pa.projectId = p.projectId
ORDER BY employee_name ASC, time_allocated DESC;

-- ===============================================
-- PART 5: DISTINCT - Removing Duplicates
-- ===============================================

-- ===============================================
-- 19. DISTINCT - Basic Usage
-- ===============================================
-- Remove duplicate rows from query results
-- Returns only unique/distinct values

-- Get distinct departments that have employees
SELECT DISTINCT departmentId
FROM employee
ORDER BY departmentId;

-- Get distinct project statuses
SELECT DISTINCT status
FROM project
ORDER BY status;

-- Get distinct department names
SELECT DISTINCT name
FROM department;

-- ===============================================
-- 20. DISTINCT - Multiple Columns
-- ===============================================
-- Find unique combinations of columns
-- Returns rows where the combination is unique

-- Get distinct department and status combinations from projects
SELECT DISTINCT departmentId, status
FROM project
ORDER BY departmentId, status;

-- Get distinct employees and their departments
SELECT DISTINCT e.employeeId, e.departmentId
FROM employee e
ORDER BY e.departmentId, e.employeeId;

-- Get distinct roles in project assignments
SELECT DISTINCT role
FROM project_assignment
ORDER BY role;

-- ===============================================
-- 21. DISTINCT - With WHERE Clause
-- ===============================================
-- Get distinct values that meet specific conditions

-- Get distinct statuses for projects in Engineering dept
SELECT DISTINCT status
FROM project
WHERE departmentId = 2
ORDER BY status;

-- Get distinct employee departments that have salary > 60000
SELECT DISTINCT departmentId
FROM employee
WHERE salary > 60000
ORDER BY departmentId;

-- Get distinct project names for active projects
SELECT DISTINCT project_name
FROM project
WHERE status = 'Active'
ORDER BY project_name;

-- ===============================================
-- 22. DISTINCT - With COUNT (Count unique values)
-- ===============================================
-- Count how many distinct values exist

-- Count distinct departments
SELECT COUNT(DISTINCT departmentId) AS number_of_departments
FROM employee;

-- Count distinct project statuses
SELECT COUNT(DISTINCT status) AS status_count
FROM project;

-- Count distinct roles in assignments
SELECT COUNT(DISTINCT role) AS role_types
FROM project_assignment;

-- Count distinct employees working on projects
SELECT COUNT(DISTINCT employeeId) AS employees_assigned
FROM project_assignment;

-- ===============================================
-- 23. DISTINCT - Comparing WITH and WITHOUT
-- ===============================================
-- See the difference between using DISTINCT or not

-- WITHOUT DISTINCT - Shows all department IDs (may have duplicates)
SELECT departmentId
FROM employee
ORDER BY departmentId;

-- WITH DISTINCT - Shows only unique department IDs
SELECT DISTINCT departmentId
FROM employee
ORDER BY departmentId;

-- WITHOUT DISTINCT - All statuses (may repeat)
SELECT status
FROM project;

-- WITH DISTINCT - Unique statuses only
SELECT DISTINCT status
FROM project;

-- ===============================================
-- 24. DISTINCT - With Aliases
-- ===============================================
-- Use aliases with DISTINCT for clarity

-- Get distinct departments with alias
SELECT DISTINCT e.departmentId AS dept_id
FROM employee e
ORDER BY dept_id;

-- Get distinct project status with meaningful name
SELECT DISTINCT 
  status AS project_status
FROM project
ORDER BY project_status;

-- Get distinct role aliases
SELECT DISTINCT 
  role AS assignment_role
FROM project_assignment
ORDER BY assignment_role;

-- ===============================================
-- 25. DISTINCT - With Calculated Fields
-- ===============================================
-- Get distinct values from calculated/derived columns

-- Get distinct salary ranges (all salaries in system)
SELECT DISTINCT 
  salary AS unique_salary_amount
FROM employee
ORDER BY unique_salary_amount DESC;

-- Get distinct budget amounts for projects
SELECT DISTINCT 
  budget AS project_budget
FROM project
ORDER BY project_budget DESC;

-- Get distinct allocation percentages
SELECT DISTINCT 
  allocation_percentage AS unique_allocation
FROM project_assignment
ORDER BY unique_allocation DESC;

-- ===============================================
-- 26. DISTINCT - Finding Unique Value Combinations
-- ===============================================
-- Practical examples of finding unique combinations

-- Find all unique (employee, project) combinations
SELECT DISTINCT 
  employeeId,
  projectId
FROM project_assignment
ORDER BY employeeId, projectId;

-- Find distinct department-project combinations
SELECT DISTINCT 
  d.departmentId,
  d.name AS department,
  p.projectId,
  p.project_name
FROM department d
JOIN project p ON d.departmentId = p.departmentId
ORDER BY d.departmentId, p.projectId;

-- Find distinct department and budget combinations
SELECT DISTINCT 
  departmentId,
  budget
FROM project
ORDER BY departmentId, budget DESC;

-- ===============================================
-- 27. DISTINCT - Practical Business Use Cases
-- ===============================================

-- Find all departments with employees
SELECT DISTINCT 
  d.name AS department
FROM employee e
JOIN department d ON e.departmentId = d.departmentId
ORDER BY department;

-- Find all project roles available in the system
SELECT DISTINCT 
  role AS available_roles
FROM project_assignment
ORDER BY available_roles;

-- Find all unique project statuses in use
SELECT DISTINCT 
  status AS project_statuses
FROM project
WHERE status IS NOT NULL
ORDER BY project_statuses;

-- Find which departments manage projects
SELECT DISTINCT 
  d.name AS department_with_projects
FROM project p
JOIN department d ON p.departmentId = d.departmentId
ORDER BY department_with_projects;

-- Find all employees assigned to projects
SELECT DISTINCT 
  e.employeeId,
  CONCAT(e.first_name, ' ', e.last_name) AS employee_name
FROM project_assignment pa
JOIN employee e ON pa.employeeId = e.employeeId
ORDER BY employee_name;

-- ===============================================
-- PART 5: PRACTICE EXAMPLES - Uncomment to use
-- ===============================================

-- Example 1: Find all departments
-- SELECT DISTINCT departmentId FROM employee ORDER BY departmentId;

-- Example 2: Count unique department assignments
-- SELECT COUNT(DISTINCT departmentId) FROM employee;

-- Example 3: Find distinct project statuses and sort
-- SELECT DISTINCT status FROM project ORDER BY status;

-- Example 4: Find unique salary amounts
-- SELECT DISTINCT salary FROM employee ORDER BY salary DESC;

-- Example 5: Find all roles employees have in projects
-- SELECT DISTINCT role FROM project_assignment ORDER BY role;

-- ===============================================
-- ORDER BY, ALIASES, & DISTINCT - QUICK REFERENCE
-- ===============================================
/*
ORDER BY Syntax:
  SELECT columns FROM table WHERE condition ORDER BY column ASC/DESC;
  
  ASC = Ascending (A-Z, 0-9, oldest dates first) - DEFAULT
  DESC = Descending (Z-A, 9-0, newest dates first)
  
  Multiple columns: ORDER BY col1 ASC, col2 DESC, col3 ASC;
  By position: ORDER BY 1, 2, 3;

Column ALIAS Syntax:
  SELECT column AS alias FROM table;
  OR (AS is optional)
  SELECT column alias FROM table;
  
  Usage: Rename output columns for readability
  Can refer to alias in ORDER BY clause

Table ALIAS Syntax:
  SELECT t.column FROM table_name AS t;
  OR (AS is optional)
  SELECT t.column FROM table_name t;
  
  Usage: Shorten table names, required for self-joins

DISTINCT Syntax:
  SELECT DISTINCT column FROM table;
  SELECT DISTINCT col1, col2 FROM table;
  
  Usage: Remove duplicate rows
  Returns only unique values/combinations
  Works with WHERE, ORDER BY, COUNT
  
  DISTINCT vs GROUP BY:
  - DISTINCT: Removes duplicates, no aggregation
  - GROUP BY: Groups rows, requires aggregation functions

NULL Sorting:
  MySQL: NULL values appear FIRST in ASC, LAST in DESC
  PostgreSQL: NULL values appear LAST in ASC, FIRST in DESC
  SQL Server: NULL values appear FIRST in both
*/

-- ===============================================
-- KEY POINTS TO REMEMBER
-- ===============================================
-- 1. ORDER BY must come AFTER WHERE clause
-- 2. Sort order is ASCENDING by default
-- 3. Can sort by column name, position (1,2,3...), or alias
-- 4. For multiple sorts, list columns separated by commas
-- 5. Use DESC for descending, ASC for ascending (optional)
-- 6. Column aliases improve readability of output
-- 7. Table aliases shorten references and enable self-joins
-- 8. Aliases don't modify the actual database
-- 9. Use AS keyword (best practice) or omit it (both valid)
-- 10. Can reference created aliases in ORDER BY clause
-- 11. NULL handling in ORDER BY varies by database
-- 12. Complex queries with aliases are easier to understand
-- ===============================================
