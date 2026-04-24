/*
================================================================================
  SQL INNER JOIN COMPREHENSIVE GUIDE
================================================================================
  File: inner-join-cmd.sql
  Description: Complete tutorial on INNER JOIN with practical examples
               using employee, department, project, and project_assignment tables.
  
  AUTHOR: Durgesh Tambe
  CREATED: April 24, 2026
  UPDATED: April 24, 2026
  VERSION: 1.0
  
  WHAT IS INNER JOIN?
  ─────────────────────────────────────────────────────────────────────────────
  INNER JOIN returns only the rows where there is a MATCH in BOTH tables.
  
  Syntax:
    SELECT columns
    FROM table1
    INNER JOIN table2 ON table1.column = table2.column;
  
  Key Characteristics:
    ✓ Returns only matching records
    ✓ Non-matching records are excluded
    ✓ Most common type of JOIN
    ✓ Keyword INNER is optional (JOIN defaults to INNER)
    ✓ Performance: Fast (uses indexed FK columns)
  
  When to use INNER JOIN:
    - You want data that exists in BOTH tables
    - You only need matching relationships
    - You want to exclude unmatched records
    - Example: Show employees WITH their department (skip NULL departments)
  
  TABLE OF CONTENTS:
    1. INNER JOIN with 2 tables
    2. INNER JOIN with condition
    3. INNER JOIN with WHERE clause
    4. INNER JOIN with aggregation
    5. INNER JOIN with multiple tables (3 tables)
    6. INNER JOIN with multiple tables (4 tables)
    7. INNER JOIN with ORDER BY and LIMIT
    8. INNER JOIN with CASE statement
    9. INNER JOIN with GROUP BY and HAVING
    10. INNER JOIN with string functions
    
  PREREQUISITES:
    - employee table: employeeId, first_name, last_name, salary, departmentId
    - department table: departmentId, name
    - project table: projectId, project_name, budget, departmentId, status
    - project_assignment: assignment_id, employeeId, projectId, role, allocation_percentage
    
  EXECUTION:
    - Execute each example individually
    - Modify WHERE conditions to experiment
    - Combine examples for complex queries
================================================================================
*/

-- ============================================================================
-- 1. BASIC INNER JOIN - Two Tables
-- ============================================================================
-- Combine employee and department information
-- Shows: All employees WITH their department (excludes NULL departments)

SELECT 
    e.employeeId,
    e.first_name,
    e.last_name,
    e.salary,
    d.departmentId,
    d.name as department_name
FROM employee e
INNER JOIN department d 
    ON e.departmentId = d.departmentId
ORDER BY d.name, e.last_name;

-- ============================================================================
-- 1B. INNER JOIN - Alternative syntax (without INNER keyword)
-- ============================================================================
-- Same as above - INNER is optional, JOIN defaults to INNER JOIN

SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    e.salary,
    d.name as department_name
FROM employee e
JOIN department d ON e.departmentId = d.departmentId
ORDER BY employee_name;

-- ============================================================================
-- 1C. INNER JOIN - Using WHERE clause instead of ON
-- ============================================================================
-- Same result using traditional SQL syntax (comma-separated tables)

SELECT 
    e.employeeId,
    e.first_name,
    e.last_name,
    d.name
FROM employee e, department d
WHERE e.departmentId = d.departmentId
ORDER BY e.employeeId;

-- ============================================================================
-- 2. INNER JOIN with Multiple Conditions
-- ============================================================================
-- Join employees to departments with additional filtering in ON clause

SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    e.salary,
    d.name
FROM employee e
INNER JOIN department d 
    ON e.departmentId = d.departmentId
    AND e.departmentId IS NOT NULL
ORDER BY e.salary DESC;

-- ============================================================================
-- 3. INNER JOIN with WHERE Clause - Filter results
-- ============================================================================
-- Join first, then filter specific department and salary range

SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as full_name,
    e.salary,
    d.name as department_name
FROM employee e
INNER JOIN department d ON e.departmentId = d.departmentId
WHERE d.name = 'Engineering' 
    AND e.salary >= 70000
ORDER BY e.salary DESC;

-- ============================================================================
-- 3B. INNER JOIN with WHERE - Multiple departments
-- ============================================================================
SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as full_name,
    e.salary,
    d.name as department_name
FROM employee e
INNER JOIN department d ON e.departmentId = d.departmentId
WHERE d.name IN ('Engineering', 'Sales')
    AND e.salary > 60000
ORDER BY d.name, e.salary DESC;

-- ============================================================================
-- 3C. INNER JOIN with WHERE - LIKE pattern matching
-- ============================================================================
SELECT 
    e.employeeId,
    e.first_name,
    e.last_name,
    d.name
FROM employee e
INNER JOIN department d ON e.departmentId = d.departmentId
WHERE e.first_name LIKE 'J%'  -- Names starting with 'J'
    OR e.last_name LIKE '%son'  -- Last names ending with 'son'
ORDER BY e.first_name;

-- ============================================================================
-- 4. INNER JOIN with Aggregation Functions
-- ============================================================================
-- Count employees per department

SELECT 
    d.name as department_name,
    COUNT(e.employeeId) as total_employees,
    ROUND(AVG(e.salary), 2) as avg_salary,
    MIN(e.salary) as min_salary,
    MAX(e.salary) as max_salary
FROM employee e
INNER JOIN department d ON e.departmentId = d.departmentId
GROUP BY d.departmentId, d.name
ORDER BY total_employees DESC;

-- ============================================================================
-- 4B. INNER JOIN with Aggregation - Salary statistics per department
-- ============================================================================
SELECT 
    d.name as department_name,
    COUNT(DISTINCT e.employeeId) as num_employees,
    ROUND(SUM(e.salary), 2) as total_payroll,
    ROUND(AVG(e.salary), 2) as avg_salary,
    ROUND(STDDEV(e.salary), 2) as salary_std_dev,
    ROUND(MAX(e.salary) - MIN(e.salary), 2) as salary_range
FROM employee e
INNER JOIN department d ON e.departmentId = d.departmentId
GROUP BY d.departmentId, d.name
HAVING COUNT(e.employeeId) > 0
ORDER BY total_payroll DESC;

-- ============================================================================
-- 5. INNER JOIN with 3 Tables - Employee-Project relationship
-- ============================================================================
-- Connect employees → assignments → projects

SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    d.name as department_name,
    p.project_name,
    pa.role,
    pa.allocation_percentage
FROM employee e
INNER JOIN department d ON e.departmentId = d.departmentId
INNER JOIN project_assignment pa ON e.employeeId = pa.employeeId
INNER JOIN project p ON pa.projectId = p.projectId
ORDER BY e.employeeId, p.projectId;

-- ============================================================================
-- 5B. INNER JOIN with 3 Tables - Find assigned employees count per project
-- ============================================================================
SELECT 
    p.projectId,
    p.project_name,
    p.budget,
    COUNT(DISTINCT pa.employeeId) as assigned_employees,
    STRING_AGG(DISTINCT e.first_name, ', ') as employee_names
FROM project p
INNER JOIN project_assignment pa ON p.projectId = pa.projectId
INNER JOIN employee e ON pa.employeeId = e.employeeId
GROUP BY p.projectId, p.project_name, p.budget
ORDER BY assigned_employees DESC;

-- Note: STRING_AGG may not work in all MySQL versions, use GROUP_CONCAT instead:
SELECT 
    p.projectId,
    p.project_name,
    p.budget,
    COUNT(DISTINCT pa.employeeId) as assigned_employees,
    GROUP_CONCAT(DISTINCT CONCAT(e.first_name, ' ', e.last_name)) as employee_names
FROM project p
INNER JOIN project_assignment pa ON p.projectId = pa.projectId
INNER JOIN employee e ON pa.employeeId = e.employeeId
GROUP BY p.projectId, p.project_name, p.budget
ORDER BY assigned_employees DESC;

-- ============================================================================
-- 6. INNER JOIN with 4 Tables - Complete employee project view
-- ============================================================================
-- Employee → Department → Project (via assignment)

SELECT 
    p.projectId,
    p.project_name,
    d.name as managing_department,
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as team_member,
    pa.role,
    pa.allocation_percentage,
    e.salary
FROM project p
INNER JOIN department d ON p.departmentId = d.departmentId
INNER JOIN project_assignment pa ON p.projectId = pa.projectId
INNER JOIN employee e ON pa.employeeId = e.employeeId
ORDER BY p.projectId, e.employeeId;

-- ============================================================================
-- 6B. INNER JOIN with 4 Tables - Project summary with team details
-- ============================================================================
SELECT 
    p.projectId,
    p.project_name,
    p.budget,
    d.name as managing_dept,
    COUNT(DISTINCT pa.employeeId) as team_size,
    SUM(pa.allocation_percentage) as total_allocation_pct,
    ROUND(AVG(e.salary), 2) as avg_team_salary,
    MAX(e.salary) as highest_salary,
    MIN(e.salary) as lowest_salary
FROM project p
INNER JOIN department d ON p.departmentId = d.departmentId
INNER JOIN project_assignment pa ON p.projectId = pa.projectId
INNER JOIN employee e ON pa.employeeId = e.employeeId
GROUP BY p.projectId, p.project_name, p.budget, d.name
ORDER BY team_size DESC;

-- ============================================================================
-- 7. INNER JOIN with ORDER BY and LIMIT
-- ============================================================================
-- Get top 10 highest-paid employees with their departments

SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    d.name as department_name,
    e.salary
FROM employee e
INNER JOIN department d ON e.departmentId = d.departmentId
ORDER BY e.salary DESC
LIMIT 10;

-- ============================================================================
-- 7B. INNER JOIN - Top 3 employees per department by salary
-- ============================================================================
SELECT 
    d.name as department_name,
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    e.salary,
    ROW_NUMBER() OVER (PARTITION BY d.departmentId ORDER BY e.salary DESC) as rank_in_dept
FROM employee e
INNER JOIN department d ON e.departmentId = d.departmentId
QUALIFY ROW_NUMBER() OVER (PARTITION BY d.departmentId ORDER BY e.salary DESC) <= 3
ORDER BY d.name, e.salary DESC;

-- ============================================================================
-- 8. INNER JOIN with CASE Statement
-- ============================================================================
-- Categorize employees by salary level with their department

SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    d.name as department_name,
    e.salary,
    CASE 
        WHEN e.salary >= 90000 THEN 'Director/Senior Lead'
        WHEN e.salary >= 75000 THEN 'Senior Engineer'
        WHEN e.salary >= 60000 THEN 'Mid-Level'
        WHEN e.salary >= 50000 THEN 'Junior'
        ELSE 'Entry Level'
    END as salary_level
FROM employee e
INNER JOIN department d ON e.departmentId = d.departmentId
ORDER BY e.salary DESC;

-- ============================================================================
-- 8B. INNER JOIN with CASE - Project role categorization
-- ============================================================================
SELECT 
    pa.assignment_id,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    p.project_name,
    pa.role,
    pa.allocation_percentage,
    CASE 
        WHEN pa.allocation_percentage = 100 THEN 'Full-Time'
        WHEN pa.allocation_percentage >= 75 THEN 'Heavy'
        WHEN pa.allocation_percentage >= 50 THEN 'Medium'
        WHEN pa.allocation_percentage >= 25 THEN 'Light'
        ELSE 'Minimal'
    END as workload_level,
    CASE 
        WHEN pa.role IN ('Lead', 'Manager', 'Architect') THEN 'Leadership'
        WHEN pa.role IN ('Developer', 'Engineer', 'Analyst') THEN 'Technical'
        WHEN pa.role IN ('Coordinator', 'Assistant') THEN 'Support'
        ELSE 'Other'
    END as role_category
FROM project_assignment pa
INNER JOIN employee e ON pa.employeeId = e.employeeId
INNER JOIN project p ON pa.projectId = p.projectId
ORDER BY p.projectId, pa.allocation_percentage DESC;

-- ============================================================================
-- 9. INNER JOIN with GROUP BY and HAVING
-- ============================================================================
-- Find departments with average salary above $60,000

SELECT 
    d.name as department_name,
    COUNT(e.employeeId) as total_employees,
    ROUND(AVG(e.salary), 2) as avg_salary
FROM employee e
INNER JOIN department d ON e.departmentId = d.departmentId
GROUP BY d.departmentId, d.name
HAVING AVG(e.salary) > 60000
ORDER BY avg_salary DESC;

-- ============================================================================
-- 9B. INNER JOIN - Find projects with large teams (3+ members)
-- ============================================================================
SELECT 
    p.projectId,
    p.project_name,
    p.status,
    COUNT(DISTINCT pa.employeeId) as team_size,
    SUM(pa.allocation_percentage) as total_allocation,
    STRING_AGG(DISTINCT CONCAT(e.first_name, ' ', e.last_name), ', ') as team_members
FROM project p
INNER JOIN project_assignment pa ON p.projectId = pa.projectId
INNER JOIN employee e ON pa.employeeId = e.employeeId
GROUP BY p.projectId, p.project_name, p.status
HAVING COUNT(DISTINCT pa.employeeId) >= 3
ORDER BY team_size DESC;

-- MySQL compatible version using GROUP_CONCAT:
SELECT 
    p.projectId,
    p.project_name,
    p.status,
    COUNT(DISTINCT pa.employeeId) as team_size,
    SUM(pa.allocation_percentage) as total_allocation,
    GROUP_CONCAT(DISTINCT CONCAT(e.first_name, ' ', e.last_name) SEPARATOR ', ') as team_members
FROM project p
INNER JOIN project_assignment pa ON p.projectId = pa.projectId
INNER JOIN employee e ON pa.employeeId = e.employeeId
GROUP BY p.projectId, p.project_name, p.status
HAVING COUNT(DISTINCT pa.employeeId) >= 3
ORDER BY team_size DESC;

-- ============================================================================
-- 9C. INNER JOIN - Employees working on multiple projects
-- ============================================================================
SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    d.name as department_name,
    COUNT(DISTINCT pa.projectId) as num_projects,
    SUM(pa.allocation_percentage) as total_allocation_pct,
    GROUP_CONCAT(DISTINCT p.project_name) as projects
FROM employee e
INNER JOIN department d ON e.departmentId = d.departmentId
INNER JOIN project_assignment pa ON e.employeeId = pa.employeeId
INNER JOIN project p ON pa.projectId = p.projectId
GROUP BY e.employeeId, e.first_name, e.last_name, d.name
HAVING COUNT(DISTINCT pa.projectId) > 1
ORDER BY num_projects DESC, total_allocation_pct DESC;

-- ============================================================================
-- 10. INNER JOIN with String Functions
-- ============================================================================
-- Find employees with specific name patterns and their assignments

SELECT 
    e.employeeId,
    UPPER(CONCAT(e.first_name, ' ', e.last_name)) as full_name_upper,
    LENGTH(CONCAT(e.first_name, ' ', e.last_name)) as name_length,
    d.name as department_name,
    SUBSTRING(d.name, 1, 3) as dept_abbreviation,
    e.salary
FROM employee e
INNER JOIN department d ON e.departmentId = d.departmentId
WHERE LOWER(e.first_name) LIKE '%a%'  -- Names containing 'a'
   OR UPPER(e.last_name) LIKE '%SON'   -- Last names ending in 'SON'
ORDER BY e.last_name, e.first_name;

-- ============================================================================
-- 10B. INNER JOIN - Project and employee information with formatted output
-- ============================================================================
SELECT 
    p.projectId,
    p.project_name as project_formatted,
    CONCAT(
        'Project: ', p.project_name, 
        ' | Team: ', GROUP_CONCAT(DISTINCT e.first_name)
    ) as project_description,
    CONCAT(e.first_name, ' ', SUBSTRING(e.last_name, 1, 1), '.') as employee_short,
    TRIM(pa.role) as role,
    ROUND(pa.allocation_percentage, 0) as allocation
FROM project p
INNER JOIN project_assignment pa ON p.projectId = pa.projectId
INNER JOIN employee e ON pa.employeeId = e.employeeId
ORDER BY p.projectId, e.first_name;

-- ============================================================================
-- PRACTICE QUESTIONS
-- ============================================================================
-- Answer these using INNER JOIN:
--
-- Q1: Show all Engineering employees and their current projects
-- Q2: Find employees earning more than average of their department
-- Q3: Count how many employees work on each project status type
-- Q4: List employees who work on "Active" projects only
-- Q5: Find departments with total payroll above $500,000
-- Q6: Show projects with all team members' names
-- Q7: Find employees with allocation >= 80% on any project
-- Q8: List employees working on "Cloud Migration Initiative" project
-- Q9: Show salary statistics for each role type
-- Q10: Find projects where total team allocation exceeds 100%

-- ============================================================================
-- KEY POINTS ABOUT INNER JOIN
-- ============================================================================
-- ✓ Returns only MATCHING records from both tables
-- ✓ Non-matching records are EXCLUDED
-- ✓ Use when you need data that exists in BOTH tables
-- ✓ Most efficient for performance (uses indexes on FK)
-- ✓ Can chain multiple INNER JOINs (e.g., A JOIN B JOIN C JOIN D)
-- ✓ INNER keyword is optional - JOIN alone defaults to INNER JOIN
-- ✓ Always specify table aliases (e1, d1) for clarity
-- ✓ Put the main filtering condition first in the ON clause

-- ============================================================================
-- COMMON MISTAKES TO AVOID
-- ============================================================================
-- MISTAKE 1: Forgetting the JOIN condition
-- WRONG:  SELECT * FROM employee INNER JOIN department;
-- RESULT: Cartesian product (50 × 4 = 200 rows of nonsense)
-- RIGHT:  SELECT * FROM employee INNER JOIN department ON e.departmentId = d.departmentId;

-- MISTAKE 2: Wrong join condition (comparing unrelated columns)
-- WRONG:  ON e.employeeId = d.departmentId;
-- RIGHT:  ON e.departmentId = d.departmentId;

-- MISTAKE 3: Ambiguous column names (not specifying table)
-- WRONG:  SELECT employeeId, name FROM employee INNER JOIN department ...;
-- ERROR:  'name' is ambiguous (could be from employee or department)
-- RIGHT:  SELECT e.employeeId, d.name FROM employee e INNER JOIN department d ...;

-- MISTAKE 4: Using non-indexed columns for joining (performance issue)
-- WRONG:  ON e.name = d.name;
-- RIGHT:  ON e.departmentId = d.departmentId; (indexed FK)

-- MISTAKE 5: Putting filter conditions in ON instead of WHERE
-- This works but is confusing:
--   ON e.departmentId = d.departmentId AND e.salary > 60000
-- Better:
--   ON e.departmentId = d.departmentId
--   WHERE e.salary > 60000

/*
================================================================================
  END OF INNER JOIN GUIDE
================================================================================
  Summary:
  - INNER JOIN: Connected records only (strict matching)
  - Use: When you need data from both sides of relationship
  - Performance: Excellent (uses indexes)
  - Most common join type in real-world queries
  
  For more information:
  - https://dev.mysql.com/doc/refman/8.0/en/join.html
  - https://www.w3schools.com/sql/sql_join_inner.asp
  - https://mode.com/sql-tutorial/sql-joins/
================================================================================
*/
