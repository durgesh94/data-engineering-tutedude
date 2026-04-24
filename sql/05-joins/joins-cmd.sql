/*
================================================================================
  SQL JOINS COMPREHENSIVE GUIDE
================================================================================
  File: joins-cmd.sql
  Description: Complete tutorial on all SQL JOIN types with practical examples
               using the employee, department, and project tables.
  
  AUTHOR: Durgesh Tambe
  CREATED: April 24, 2026
  UPDATED: April 24, 2026
  
  TABLE OF CONTENTS:
    1. INNER JOIN - Matching rows only
    2. LEFT JOIN (LEFT OUTER JOIN) - All left + matching right
    3. RIGHT JOIN (RIGHT OUTER JOIN) - All right + matching left
    4. FULL OUTER JOIN - All rows from both tables
    5. CROSS JOIN - Cartesian product
    6. SELF-JOIN - Table joined to itself
    7. MULTIPLE JOINS - 3+ tables
    8. JOIN with WHERE clause
    9. JOIN with Aggregation
    10. JOIN with ORDER BY and LIMIT
    
  PREREQUISITES:
    - employee table with employeeId, first_name, last_name, salary, departmentId
    - department table with departmentId, name
    - project table with projectId, project_name, budget, departmentId
    - project_assignment table with assignment_id, employeeId, projectId, role
    
  USAGE:
    - Execute individual queries to learn each JOIN type
    - Modify WHERE conditions for different filtering
    - Combine examples for complex scenarios
================================================================================
*/

-- ============================================================================
-- 1. INNER JOIN - Returns only matching rows from both tables
-- ============================================================================
-- When you want employees AND their corresponding department info
-- Non-matching employees (with NULL departmentId) won't appear

SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    e.salary,
    d.departmentId,
    d.name as department_name
FROM employee e
INNER JOIN department d 
    ON e.departmentId = d.departmentId
ORDER BY d.name, e.last_name;

-- ============================================================================
-- INNER JOIN VARIANT: Using WHERE instead of ON
-- ============================================================================
-- Same result as above, but filtering in WHERE clause
SELECT 
    e.employeeId,
    e.first_name,
    e.last_name,
    d.name
FROM employee e, department d
WHERE e.departmentId = d.departmentId
ORDER BY d.name;

-- ============================================================================
-- 2. LEFT JOIN - All rows from left table + matching rows from right
-- ============================================================================
-- Shows ALL departments, with employee count (even if 0 employees)
-- Useful for: "Which departments have no employees assigned?"

SELECT 
    d.departmentId,
    d.name as department_name,
    COUNT(e.employeeId) as total_employees,
    ROUND(AVG(e.salary), 2) as avg_salary
FROM department d
LEFT JOIN employee e 
    ON d.departmentId = e.departmentId
GROUP BY d.departmentId, d.name
ORDER BY d.name;

-- ============================================================================
-- LEFT JOIN with NULL CHECK: Find departments with no employees
-- ============================================================================
SELECT 
    d.departmentId,
    d.name as department_name
FROM department d
LEFT JOIN employee e 
    ON d.departmentId = e.departmentId
WHERE e.employeeId IS NULL;  -- No match found

-- ============================================================================
-- 3. RIGHT JOIN - All rows from right table + matching rows from left
-- ============================================================================
-- Shows ALL employees, including those with no department assignment
SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    d.name as department_name
FROM department d
RIGHT JOIN employee e 
    ON d.departmentId = e.departmentId
ORDER BY e.employeeId;

-- ============================================================================
-- RIGHT JOIN ALTERNATIVE: Using LEFT JOIN reversed
-- ============================================================================
-- Same as above - RIGHT JOIN can be rewritten as left-join with tables flipped
SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    d.name as department_name
FROM employee e
LEFT JOIN department d 
    ON e.departmentId = d.departmentId
ORDER BY e.employeeId;

-- ============================================================================
-- 4. FULL OUTER JOIN - All rows from both tables
-- ============================================================================
-- MySQL doesn't support FULL OUTER directly, so use UNION
-- Shows ALL employees AND ALL departments
SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    d.departmentId,
    d.name as department_name
FROM employee e
LEFT JOIN department d 
    ON e.departmentId = d.departmentId
UNION
SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name),
    d.departmentId,
    d.name
FROM employee e
RIGHT JOIN department d 
    ON e.departmentId = d.departmentId;

-- ============================================================================
-- 5. CROSS JOIN - Cartesian Product (All combinations)
-- ============================================================================
-- Creates combination of every employee with every project
-- Be careful: 50 employees × 20 projects = 1000 rows!
SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    p.projectId,
    p.project_name
FROM employee e
CROSS JOIN project p
LIMIT 20;  -- LIMIT to prevent huge result set

-- ============================================================================
-- CROSS JOIN PRACTICAL USE: Generate all possible combinations
-- ============================================================================
-- Useful for: Creating a schedule matrix
SELECT 
    d.name as department,
    YEAR(CURDATE()) as year,
    MONTH(CURDATE()) as month
FROM department d
CROSS JOIN (SELECT DISTINCT YEAR(CURDATE()) as year, MONTH(CURDATE()) as month) cal
ORDER BY department, year, month;

-- ============================================================================
-- 6. SELF-JOIN - Table joined to itself
-- ============================================================================
-- Find pairs of employees in the same department
SELECT 
    e1.employeeId as employee_1_id,
    CONCAT(e1.first_name, ' ', e1.last_name) as employee_1,
    e2.employeeId as employee_2_id,
    CONCAT(e2.first_name, ' ', e2.last_name) as employee_2,
    e1.departmentId
FROM employee e1
JOIN employee e2 
    ON e1.departmentId = e2.departmentId 
    AND e1.employeeId < e2.employeeId
ORDER BY e1.departmentId, e1.employeeId;

-- ============================================================================
-- SELF-JOIN EXAMPLE 2: Manager-Employee hierarchy (if manager field exists)
-- ============================================================================
-- Hypothetical: Show employee and their manager
-- Note: This assumes manager_id field exists in employee table
-- SELECT 
--     emp.employeeId,
--     CONCAT(emp.first_name, ' ', emp.last_name) as employee_name,
--     mgr.employeeId as manager_id,
--     CONCAT(mgr.first_name, ' ', mgr.last_name) as manager_name
-- FROM employee emp
-- LEFT JOIN employee mgr ON emp.manager_id = mgr.employeeId;

-- ============================================================================
-- 7. MULTIPLE JOINS - Joining 3+ tables
-- ============================================================================
-- Show employees, their departments, and projects they're assigned to
SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    d.name as department_name,
    p.project_name,
    pa.role,
    pa.allocation_percentage
FROM employee e
INNER JOIN department d 
    ON e.departmentId = d.departmentId
INNER JOIN project_assignment pa 
    ON e.employeeId = pa.employeeId
INNER JOIN project p 
    ON pa.projectId = p.projectId
ORDER BY e.employeeId, p.projectId;

-- ============================================================================
-- MULTIPLE JOINS WITH LEFT JOIN: Include employees with no assignments
-- ============================================================================
-- Shows all employees, even if not assigned to any project
SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    d.name as department_name,
    p.project_name,
    pa.role,
    pa.allocation_percentage
FROM employee e
INNER JOIN department d 
    ON e.departmentId = d.departmentId
LEFT JOIN project_assignment pa 
    ON e.employeeId = pa.employeeId
LEFT JOIN project p 
    ON pa.projectId = p.projectId
ORDER BY e.employeeId;

-- ============================================================================
-- MULTIPLE JOINS - Four tables
-- ============================================================================
-- Join: employee → department → project ← project_assignment
-- Shows complete project team with department info
SELECT 
    p.projectId,
    p.project_name,
    d.name as managing_department,
    COUNT(DISTINCT pa.employeeId) as team_size,
    SUM(pa.allocation_percentage) as total_allocation_pct,
    GROUP_CONCAT(DISTINCT CONCAT(e.first_name, ' ', e.last_name)) as team_members
FROM project p
INNER JOIN department d 
    ON p.departmentId = d.departmentId
LEFT JOIN project_assignment pa 
    ON p.projectId = pa.projectId
LEFT JOIN employee e 
    ON pa.employeeId = e.employeeId
GROUP BY p.projectId, p.project_name, d.name
ORDER BY p.projectId;

-- ============================================================================
-- 8. JOIN with WHERE clause - Filter after joining
-- ============================================================================
-- Find employees earning more than $70,000 in Engineering department
SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    e.salary,
    d.name as department_name
FROM employee e
INNER JOIN department d 
    ON e.departmentId = d.departmentId
WHERE e.salary > 70000
    AND d.name = 'Engineering'
ORDER BY e.salary DESC;

-- ============================================================================
-- JOIN with WHERE and LIKE - Pattern matching
-- ============================================================================
-- Find all employees assigned to projects starting with 'Cloud'
SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    p.project_name,
    pa.role
FROM employee e
INNER JOIN project_assignment pa 
    ON e.employeeId = pa.employeeId
INNER JOIN project p 
    ON pa.projectId = p.projectId
WHERE p.project_name LIKE 'Cloud%'
ORDER BY p.project_name, e.last_name;

-- ============================================================================
-- 9. JOIN with Aggregation - GROUP BY after JOIN
-- ============================================================================
-- Count employees per department
SELECT 
    d.name as department_name,
    COUNT(e.employeeId) as total_employees,
    ROUND(AVG(e.salary), 2) as avg_salary,
    MIN(e.salary) as min_salary,
    MAX(e.salary) as max_salary
FROM department d
LEFT JOIN employee e 
    ON d.departmentId = e.departmentId
GROUP BY d.departmentId, d.name
ORDER BY total_employees DESC;

-- ============================================================================
-- JOIN with Aggregation - Project team statistics
-- ============================================================================
-- For each project, show team size and total allocation
SELECT 
    p.projectId,
    p.project_name,
    COUNT(DISTINCT pa.employeeId) as team_size,
    SUM(pa.allocation_percentage) as total_allocation_pct,
    COUNT(DISTINCT pa.role) as unique_roles,
    ROUND(AVG(e.salary), 2) as avg_team_salary
FROM project p
LEFT JOIN project_assignment pa 
    ON p.projectId = pa.projectId
LEFT JOIN employee e 
    ON pa.employeeId = e.employeeId
GROUP BY p.projectId, p.project_name
HAVING team_size > 0
ORDER BY team_size DESC;

-- ============================================================================
-- 10. JOIN with ORDER BY and LIMIT
-- ============================================================================
-- Get top 5 highest-paid employees with their departments
SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    d.name as department_name,
    e.salary
FROM employee e
INNER JOIN department d 
    ON e.departmentId = d.departmentId
ORDER BY e.salary DESC
LIMIT 5;

-- ============================================================================
-- Advanced: JOIN with CASE statement
-- ============================================================================
-- Categorize employees by salary level with department info
SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    d.name as department_name,
    e.salary,
    CASE 
        WHEN e.salary >= 90000 THEN 'Senior'
        WHEN e.salary >= 70000 THEN 'Mid-Level'
        WHEN e.salary >= 50000 THEN 'Junior'
        ELSE 'Entry Level'
    END as salary_level
FROM employee e
INNER JOIN department d 
    ON e.departmentId = d.departmentId
ORDER BY e.salary DESC;

-- ============================================================================
-- Advanced: JOIN with Window Functions
-- ============================================================================
-- Show employee rank within their department by salary
SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    d.name as department_name,
    e.salary,
    ROW_NUMBER() OVER (
        PARTITION BY d.departmentId 
        ORDER BY e.salary DESC
    ) as dept_salary_rank
FROM employee e
INNER JOIN department d 
    ON e.departmentId = d.departmentId
ORDER BY d.name, e.salary DESC;

-- ============================================================================
-- COMMON JOIN MISTAKES TO AVOID
-- ============================================================================

-- MISTAKE 1: Forgetting the JOIN condition (Cartesian product!)
-- WRONG:
-- SELECT * FROM employee e, department d;  -- Returns 50 × 4 = 200 rows

-- CORRECT:
SELECT * FROM employee e, department d WHERE e.departmentId = d.departmentId;

-- ============================================================================

-- MISTAKE 2: Using = in ON clause for multiple conditions without AND
-- WRONG:
-- SELECT * FROM employee e JOIN department d ON e.departmentId = d.departmentId AND e.salary > 50000;

-- CORRECT: Put salary filter in WHERE, not ON
SELECT * FROM employee e 
JOIN department d ON e.departmentId = d.departmentId
WHERE e.salary > 50000;

-- ============================================================================

-- MISTAKE 3: Forgetting to specify table alias in SELECT
-- WRONG:
-- SELECT employeeId, name FROM employee e JOIN department d ON e.departmentId = d.departmentId;
-- -- Error: "name" is ambiguous (both tables might have name column)

-- CORRECT: Specify table prefix
-- SELECT e.employeeId, d.name FROM employee e JOIN department d ON e.departmentId = d.departmentId;

-- ============================================================================
-- PERFORMANCE TIPS FOR JOINS
-- ============================================================================
-- 1. Index the JOIN columns (usually foreign keys)
--    CREATE INDEX idx_fk_dept ON employee(departmentId);
--
-- 2. Use INNER JOIN when possible (more restrictive = faster)
--
-- 3. Put most restrictive conditions first
--
-- 4. Avoid SELECT * - select only needed columns
--
-- 5. Use EXPLAIN to analyze JOIN performance:
--    EXPLAIN SELECT ... FROM table1 JOIN table2 ...;
--
-- 6. Join on PRIMARY keys when possible
--
-- 7. Avoid functions in JOIN condition:
--    WRONG:  ON LOWER(e.email) = LOWER(d.email)
--    RIGHT: Make case-insensitive in WHERE instead

-- ============================================================================
-- SUMMARY OF JOIN TYPES
-- ============================================================================
-- INNER JOIN:      Matching rows only (strict match)
-- LEFT JOIN:       All left + matching right (include all from first table)
-- RIGHT JOIN:      All right + matching left (include all from second table)
-- FULL OUTER JOIN: All from both tables (use UNION in MySQL)
-- CROSS JOIN:      All combinations (careful with large tables!)
-- SELF-JOIN:       Table with itself (comparisons within same table)
-- MULTIPLE JOINS:  3+ tables joined together
--
-- Choice depends on:
--   - Do you need non-matching rows?
--   - Which table's rows should always be included?
--   - How many tables are involved?

/*
================================================================================
  END OF JOINS GUIDE
================================================================================
  For more information:
  - MySQL JOIN Documentation: https://dev.mysql.com/doc/
  - Visual JOIN Guide: https://www.codeproject.com/Articles/33052/Visual-Representation-of-SQL-Joins
  - Interactive Examples: https://www.sql-join.com/
  
  Questions to practice:
  1. Find all employees NOT assigned to any project
  2. Find projects with ZERO team members
  3. Which department has the most expensive average salary?
  4. List employees and count of projects they work on
  5. Find employees working on 3+ projects
================================================================================
*/
