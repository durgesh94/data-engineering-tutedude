/*
================================================================================
  SQL LEFT JOIN COMPREHENSIVE GUIDE
================================================================================
  File: left-join-cmd.sql
  Description: Complete tutorial on LEFT JOIN (LEFT OUTER JOIN) with practical 
               examples using employee, department, project, and project_assignment tables.
  
  AUTHOR: Durgesh Tambe
  CREATED: April 24, 2026
  UPDATED: April 24, 2026
  VERSION: 1.0
  
  WHAT IS LEFT JOIN?
  ─────────────────────────────────────────────────────────────────────────────
  LEFT JOIN returns ALL records from the LEFT table, plus matching records from 
  the RIGHT table. If there's no match, NULL values are returned for RIGHT table columns.
  
  Syntax:
    SELECT columns
    FROM left_table
    LEFT JOIN right_table ON left_table.column = right_table.column;
  
  Alternative syntax (same result):
    SELECT columns
    FROM left_table
    LEFT OUTER JOIN right_table ON left_table.column = right_table.column;
  
  Key Characteristics:
    ✓ Returns ALL records from LEFT table (guaranteed)
    ✓ Returns matching records from RIGHT table
    ✓ Non-matching RIGHT records show as NULL
    ✓ Perfect for finding "missing" or "unmatched" data
    ✓ Used to detect data quality issues
    ✓ LEFT OUTER is same as LEFT (OUTER is optional)
  
  When to use LEFT JOIN:
    - You want ALL records from the first table
    - You want to OPTIONALLY match with a second table
    - You need to find records that DON'T have a match
    - Example: Show ALL employees AND their projects (even if none)
    - Example: Find departments with ZERO employees
    - Example: Detect orphaned records
  
  LEFT JOIN vs INNER JOIN:
    ┌──────────────┬──────────────┬──────────────┐
    │ Record Type  │ INNER JOIN   │ LEFT JOIN    │
    ├──────────────┼──────────────┼──────────────┤
    │ Match both   │ ✓ Included   │ ✓ Included   │
    │ Left only    │ ✗ Excluded   │ ✓ Included   │
    │ Right only   │ ✗ Excluded   │ ✗ Excluded   │
    └──────────────┴──────────────┴──────────────┘
  
  TABLE OF CONTENTS:
    1. Basic LEFT JOIN (2 tables)
    2. LEFT JOIN with WHERE to find unmatched
    3. LEFT JOIN with COALESCE (handle NULLs)
    4. LEFT JOIN with CASE statement
    5. LEFT JOIN with 3 tables
    6. LEFT JOIN with 4 tables
    7. LEFT JOIN with aggregation (GROUP BY)
    8. LEFT JOIN with COUNT (null detection)
    9. LEFT JOIN with ORDER BY and LIMIT
    10. LEFT JOIN with string functions
    
  PREREQUISITES:
    - employee table: employeeId, first_name, last_name, salary, departmentId
    - department table: departmentId, name
    - project table: projectId, project_name, budget, departmentId, status
    - project_assignment: assignment_id, employeeId, projectId, role, allocation_percentage
    
  EXECUTION:
    - Execute each example individually
    - Pay attention to NULL values in results
    - Modify WHERE conditions to experiment
    - Use IS NULL to find unmatched records
================================================================================
*/

-- ============================================================================
-- 1. BASIC LEFT JOIN - Two Tables
-- ============================================================================
-- Show ALL employees and their departments (if assigned)
-- Employees with NULL departmentId will have NULL department_name

SELECT 
    e.employeeId,
    e.first_name,
    e.last_name,
    e.salary,
    d.departmentId,
    d.name as department_name
FROM employee e
LEFT JOIN department d 
    ON e.departmentId = d.departmentId
ORDER BY e.employeeId;

-- ============================================================================
-- 1B. LEFT JOIN - Show all departments and employee count
-- ============================================================================
-- Even departments with ZERO employees will appear
SELECT 
    d.departmentId,
    d.name as department_name,
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name
FROM department d
LEFT JOIN employee e ON d.departmentId = e.departmentId
ORDER BY d.departmentId, e.last_name;

-- ============================================================================
-- 1C. LEFT JOIN - Compare with INNER JOIN
-- ============================================================================
-- This shows the DIFFERENCE between LEFT and INNER
-- LEFT JOIN returns more rows (includes unmatched left table records)

SELECT 
    'LEFT JOIN' as join_type,
    COUNT(*) as total_rows
FROM employee e
LEFT JOIN department d ON e.departmentId = d.departmentId
UNION ALL
SELECT 
    'INNER JOIN' as join_type,
    COUNT(*) as total_rows
FROM employee e
INNER JOIN department d ON e.departmentId = d.departmentId;

-- ============================================================================
-- 2. LEFT JOIN with WHERE - Find unmatched records (NULL CHECK)
-- ============================================================================
-- Find ALL employees with NO department assigned (departmentId is NULL)
-- These are potentially orphaned or unassigned records

SELECT 
    e.employeeId,
    e.first_name,
    e.last_name,
    e.salary,
    e.departmentId,
    d.name as department_name
FROM employee e
LEFT JOIN department d ON e.departmentId = d.departmentId
WHERE d.departmentId IS NULL  -- No match found
ORDER BY e.employeeId;

-- ============================================================================
-- 2B. LEFT JOIN - Find departments with NO employees
-- ============================================================================
-- This is useful for data quality checks and identifying empty departments
SELECT 
    d.departmentId,
    d.name as department_name
FROM department d
LEFT JOIN employee e ON d.departmentId = e.departmentId
WHERE e.employeeId IS NULL  -- No employees in this department
ORDER BY d.departmentId;

-- ============================================================================
-- 2C. LEFT JOIN - Find projects with NO assignments
-- ============================================================================
-- Detect projects that have been created but not yet staffed
SELECT 
    p.projectId,
    p.project_name,
    p.budget,
    p.status,
    pa.assignment_id
FROM project p
LEFT JOIN project_assignment pa ON p.projectId = pa.projectId
WHERE pa.assignment_id IS NULL  -- No assignments for this project
ORDER BY p.projectId;

-- ============================================================================
-- 3. LEFT JOIN with COALESCE - Handle NULL values
-- ============================================================================
-- COALESCE returns the first non-NULL value
-- Useful for replacing NULL with a default value

SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    e.salary,
    COALESCE(d.name, 'Unassigned') as department_name,
    COALESCE(e.departmentId, 0) as dept_id
FROM employee e
LEFT JOIN department d ON e.departmentId = d.departmentId
ORDER BY e.employeeId;

-- ============================================================================
-- 3B. LEFT JOIN with COALESCE - Project team information
-- ============================================================================
SELECT 
    p.projectId,
    p.project_name,
    COALESCE(e.employeeId, -1) as employee_id,
    COALESCE(CONCAT(e.first_name, ' ', e.last_name), 'No Team Member') as team_member,
    COALESCE(pa.role, 'Not Assigned') as role,
    COALESCE(pa.allocation_percentage, 0) as allocation_pct
FROM project p
LEFT JOIN project_assignment pa ON p.projectId = pa.projectId
LEFT JOIN employee e ON pa.employeeId = e.employeeId
ORDER BY p.projectId, COALESCE(e.employeeId, 999999);

-- ============================================================================
-- 4. LEFT JOIN with CASE Statement
-- ============================================================================
-- Categorize department assignment status

SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    e.salary,
    CASE 
        WHEN d.departmentId IS NULL THEN 'UNASSIGNED'
        WHEN d.name = 'Engineering' THEN 'TECH_TEAM'
        WHEN d.name = 'Sales' THEN 'REVENUE_TEAM'
        WHEN d.name = 'HR' THEN 'SUPPORT_TEAM'
        WHEN d.name = 'Finance' THEN 'OPERATIONS_TEAM'
        ELSE 'OTHER'
    END as department_category,
    d.name as department_name
FROM employee e
LEFT JOIN department d ON e.departmentId = d.departmentId
ORDER BY 
    CASE WHEN d.departmentId IS NULL THEN 0 ELSE 1 END DESC,
    e.last_name;

-- ============================================================================
-- 4B. LEFT JOIN with CASE - Project assignment status
-- ============================================================================
SELECT 
    p.projectId,
    p.project_name,
    p.status,
    CASE 
        WHEN e.employeeId IS NULL THEN 'No_Team'
        WHEN pa.allocation_percentage >= 80 THEN 'Heavily_Staffed'
        WHEN pa.allocation_percentage >= 50 THEN 'Moderately_Staffed'
        WHEN pa.allocation_percentage >= 25 THEN 'Lightly_Staffed'
        ELSE 'Minimal_Effort'
    END as staffing_level,
    CONCAT(COALESCE(e.first_name, ''), ' ', COALESCE(e.last_name, '')) as team_member,
    COALESCE(pa.allocation_percentage, 0) as allocation_pct
FROM project p
LEFT JOIN project_assignment pa ON p.projectId = pa.projectId
LEFT JOIN employee e ON pa.employeeId = e.employeeId
ORDER BY p.projectId, pa.allocation_percentage DESC;

-- ============================================================================
-- 5. LEFT JOIN with 3 Tables
-- ============================================================================
-- Show all employees with their departments and projects (if any)
-- Employees with no projects will still appear

SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    d.name as department_name,
    p.project_name,
    pa.role,
    pa.allocation_percentage
FROM employee e
LEFT JOIN department d ON e.departmentId = d.departmentId
LEFT JOIN project_assignment pa ON e.employeeId = pa.employeeId
LEFT JOIN project p ON pa.projectId = p.projectId
ORDER BY e.employeeId, p.projectId;

-- ============================================================================
-- 5B. LEFT JOIN - Count projects per employee (including 0)
-- ============================================================================
-- Shows employees with no projects assigned

SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    d.name as department_name,
    COUNT(DISTINCT pa.projectId) as num_projects,
    COUNT(DISTINCT pa.projectId) = 0 as is_unassigned
FROM employee e
LEFT JOIN department d ON e.departmentId = d.departmentId
LEFT JOIN project_assignment pa ON e.employeeId = pa.employeeId
GROUP BY e.employeeId, e.first_name, e.last_name, d.name
ORDER BY num_projects ASC, e.last_name;

-- ============================================================================
-- 6. LEFT JOIN with 4 Tables
-- ============================================================================
-- Complete view: All employees/departments/projects/assignments
-- Shows what could be missing

SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    d.name as department_name,
    p.projectId,
    p.project_name,
    p.budget,
    pa.role,
    pa.allocation_percentage,
    e.salary
FROM employee e
LEFT JOIN department d ON e.departmentId = d.departmentId
LEFT JOIN project_assignment pa ON e.employeeId = pa.employeeId
LEFT JOIN project p ON pa.projectId = p.projectId
ORDER BY e.employeeId, p.projectId;

-- ============================================================================
-- 6B. LEFT JOIN - Project completion status with team info
-- ============================================================================
SELECT 
    p.projectId,
    p.project_name,
    p.status,
    p.budget,
    d.name as managing_department,
    COALESCE(COUNT(DISTINCT pa.employeeId), 0) as team_size,
    COALESCE(GROUP_CONCAT(DISTINCT CONCAT(e.first_name, ' ', e.last_name)), 'No Team') as team_members
FROM project p
LEFT JOIN department d ON p.departmentId = d.departmentId
LEFT JOIN project_assignment pa ON p.projectId = pa.projectId
LEFT JOIN employee e ON pa.employeeId = e.employeeId
GROUP BY p.projectId, p.project_name, p.status, p.budget, d.name
ORDER BY p.status, p.projectId;

-- ============================================================================
-- 7. LEFT JOIN with Aggregation (GROUP BY)
-- ============================================================================
-- Count employees per department (even if 0)

SELECT 
    d.departmentId,
    d.name as department_name,
    COUNT(e.employeeId) as total_employees,
    COALESCE(ROUND(AVG(e.salary), 2), 0) as avg_salary,
    COALESCE(MIN(e.salary), 0) as min_salary,
    COALESCE(MAX(e.salary), 0) as max_salary,
    COALESCE(SUM(e.salary), 0) as total_payroll
FROM department d
LEFT JOIN employee e ON d.departmentId = e.departmentId
GROUP BY d.departmentId, d.name
ORDER BY total_employees DESC;

-- ============================================================================
-- 7B. LEFT JOIN - Complete project statistics (with empty projects)
-- ============================================================================
SELECT 
    p.projectId,
    p.project_name,
    p.status,
    p.budget,
    COALESCE(COUNT(DISTINCT pa.employeeId), 0) as assigned_employees,
    COALESCE(SUM(pa.allocation_percentage), 0) as total_allocation_pct,
    COALESCE(ROUND(AVG(e.salary), 2), 0) as avg_team_salary,
    CASE 
        WHEN COUNT(DISTINCT pa.employeeId) = 0 THEN 'Not Started'
        WHEN SUM(pa.allocation_percentage) < 100 THEN 'Under Allocated'
        WHEN SUM(pa.allocation_percentage) = 100 THEN 'Fully Allocated'
        ELSE 'Over Allocated'
    END as allocation_status
FROM project p
LEFT JOIN project_assignment pa ON p.projectId = pa.projectId
LEFT JOIN employee e ON pa.employeeId = e.employeeId
GROUP BY p.projectId, p.project_name, p.status, p.budget
ORDER BY p.projectId;

-- ============================================================================
-- 7C. LEFT JOIN - Find high-risk employees (on too many projects)
-- ============================================================================
SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    d.name as department_name,
    e.salary,
    COUNT(DISTINCT pa.projectId) as num_projects,
    SUM(pa.allocation_percentage) as total_allocation_pct,
    CASE 
        WHEN SUM(pa.allocation_percentage) > 100 THEN 'OVER_ALLOCATED'
        WHEN SUM(pa.allocation_percentage) >= 100 THEN 'AT_CAPACITY'
        WHEN SUM(pa.allocation_percentage) >= 80 THEN 'NEARLY_FULL'
        ELSE 'HAS_CAPACITY'
    END as workload_status
FROM employee e
LEFT JOIN department d ON e.departmentId = d.departmentId
LEFT JOIN project_assignment pa ON e.employeeId = pa.employeeId
GROUP BY e.employeeId, e.first_name, e.last_name, d.name, e.salary
HAVING SUM(pa.allocation_percentage) > 100 OR SUM(pa.allocation_percentage) IS NULL
ORDER BY total_allocation_pct DESC;

-- ============================================================================
-- 8. LEFT JOIN with COUNT - Identify NULL records
-- ============================================================================
-- This query highlights records that don't have a match

SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    CASE WHEN d.departmentId IS NULL THEN 'NO_DEPT' ELSE 'HAS_DEPT' END as dept_status,
    d.name,
    COUNT(pa.projectId) as project_count
FROM employee e
LEFT JOIN department d ON e.departmentId = d.departmentId
LEFT JOIN project_assignment pa ON e.employeeId = pa.employeeId
GROUP BY e.employeeId, e.first_name, e.last_name, d.departmentId, d.name
ORDER BY 
    CASE WHEN d.departmentId IS NULL THEN 0 ELSE 1 END ASC,
    e.employeeId;

-- ============================================================================
-- 8B. LEFT JOIN - Data quality report (find orphaned records)
-- ============================================================================
SELECT 
    'Employees without department' as issue_type,
    COUNT(*) as count
FROM employee e
LEFT JOIN department d ON e.departmentId = d.departmentId
WHERE d.departmentId IS NULL

UNION ALL

SELECT 
    'Departments with no employees' as issue_type,
    COUNT(*) as count
FROM department d
LEFT JOIN employee e ON d.departmentId = e.departmentId
WHERE e.employeeId IS NULL

UNION ALL

SELECT 
    'Projects with no assignments' as issue_type,
    COUNT(*) as count
FROM project p
LEFT JOIN project_assignment pa ON p.projectId = pa.projectId
WHERE pa.assignment_id IS NULL;

-- ============================================================================
-- 9. LEFT JOIN with ORDER BY and LIMIT
-- ============================================================================
-- Find top 5 departments by employee count (including zero-count departments)

SELECT 
    d.departmentId,
    d.name as department_name,
    COUNT(e.employeeId) as total_employees,
    ROUND(AVG(e.salary), 2) as avg_salary
FROM department d
LEFT JOIN employee e ON d.departmentId = e.departmentId
GROUP BY d.departmentId, d.name
ORDER BY total_employees DESC, d.name
LIMIT 5;

-- ============================================================================
-- 9B. LEFT JOIN - Get employees with least project assignments
-- ============================================================================
SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    d.name as department_name,
    e.salary,
    COUNT(DISTINCT pa.projectId) as num_projects
FROM employee e
LEFT JOIN department d ON e.departmentId = d.departmentId
LEFT JOIN project_assignment pa ON e.employeeId = pa.employeeId
GROUP BY e.employeeId, e.first_name, e.last_name, d.name, e.salary
ORDER BY num_projects ASC, e.salary DESC
LIMIT 10;

-- ============================================================================
-- 10. LEFT JOIN with String Functions
-- ============================================================================
-- Format output with string manipulation

SELECT 
    e.employeeId,
    UPPER(CONCAT(e.first_name, ' ', e.last_name)) as employee_name,
    CASE 
        WHEN d.name IS NULL THEN 'UNASSIGNED'
        ELSE UPPER(LEFT(d.name, 3)) || ' - ' || d.name
    END as department_info,
    CONCAT('$', FORMAT(e.salary, 2)) as formatted_salary,
    GROUP_CONCAT(DISTINCT p.project_name SEPARATOR ', ') as project_list
FROM employee e
LEFT JOIN department d ON e.departmentId = d.departmentId
LEFT JOIN project_assignment pa ON e.employeeId = pa.employeeId
LEFT JOIN project p ON pa.projectId = p.projectId
GROUP BY e.employeeId, e.first_name, e.last_name, d.name, e.salary
ORDER BY e.first_name, e.last_name;

-- ============================================================================
-- 10B. LEFT JOIN - Generate status report with formatted text
-- ============================================================================
SELECT 
    CONCAT(
        'Employee: ', e.first_name, ' ', e.last_name, ' | ',
        'Dept: ', COALESCE(d.name, 'Unassigned'), ' | ',
        'Salary: $', FORMAT(e.salary, 0), ' | ',
        'Projects: ', COALESCE(COUNT(DISTINCT pa.projectId), 0)
    ) as employee_summary,
    GROUP_CONCAT(DISTINCT p.project_name ORDER BY p.project_name SEPARATOR ' • ') as assigned_projects
FROM employee e
LEFT JOIN department d ON e.departmentId = d.departmentId
LEFT JOIN project_assignment pa ON e.employeeId = pa.employeeId
LEFT JOIN project p ON pa.projectId = p.projectId
GROUP BY e.employeeId, e.first_name, e.last_name, d.departmentId, d.name, e.salary
ORDER BY e.last_name, e.first_name;

-- ============================================================================
-- PRACTICE QUESTIONS
-- ============================================================================
-- Answer these using LEFT JOIN:
--
-- Q1: Find all employees who are NOT assigned to any project
-- Q2: List all departments and count of employees (including 0)
-- Q3: Show all projects and their team members (if any)
-- Q4: Find departments with average salary below $60,000 or no employees
-- Q5: List employees who are over-allocated (>100% allocation)
-- Q6: Show all employees and indicate if assigned to "Active" projects
-- Q7: Find employees with least project involvement
-- Q8: Display projects with detailed team information (or "No Team" if empty)
-- Q9: Create a status report of all unassigned employees
-- Q10: Find data quality issues (orphaned or unmatched records)

-- ============================================================================
-- KEY POINTS ABOUT LEFT JOIN
-- ============================================================================
-- ✓ Returns ALL rows from LEFT table (guaranteed inclusion)
-- ✓ Rows with no match in RIGHT table have NULL values
-- ✓ Perfect for finding MISSING or UNMATCHED data
-- ✓ Can be chained: A LEFT JOIN B LEFT JOIN C LEFT JOIN D
-- ✓ Use IS NULL to find unmatched records
-- ✓ Use COALESCE to replace NULLs with defaults
-- ✓ Always specify table aliases for clarity
-- ✓ More expensive than INNER JOIN (includes NULL handling)

-- ============================================================================
-- COMMON MISTAKES TO AVOID
-- ============================================================================
-- MISTAKE 1: Adding WHERE condition that negates the LEFT JOIN
-- WRONG:  LEFT JOIN department WHERE d.name = 'Engineering'
--         This filters to only matched records (same as INNER)
-- RIGHT:  LEFT JOIN department WHERE d.name = 'Engineering' OR d.name IS NULL

-- MISTAKE 2: Not checking for NULL in WHERE clause
-- WRONG:  LEFT JOIN department WHERE d.departmentId = 1
-- RIGHT:  LEFT JOIN department WHERE d.departmentId = 1 OR d.departmentId IS NULL

-- MISTAKE 3: Forgetting NULL check when trying to find unmatched
-- WRONG:  LEFT JOIN department WHERE d.name IS NULL
-- RIGHT:  This actually works, but be explicit about intent

-- MISTAKE 4: Using INNER JOIN when you meant LEFT
-- WRONG:  SELECT * FROM dept LEFT JOIN emp WHERE emp.id IS NOT NULL
-- RIGHT:  SELECT * FROM dept LEFT JOIN emp WHERE emp.id IS NULL

-- MISTAKE 5: Performance issue - Using function in ON clause
-- WRONG:  ON LOWER(e.email) = LOWER(d.email)
-- RIGHT:  ON e.departmentId = d.departmentId

-- ============================================================================
-- LEFT JOIN vs INNER JOIN vs RIGHT JOIN
-- ============================================================================
-- LEFT:   All left, matched right (keep all from first table)
-- INNER:  Only matches (strict mode)
-- RIGHT:  All right, matched left (keep all from second table)
--
-- Choice based on:
--   - Which table's records MUST all appear?
--   - Do you want to find unmatched records?
--   - Do you need to detect data quality issues?

/*
================================================================================
  END OF LEFT JOIN GUIDE
================================================================================
  Summary:
  - LEFT JOIN: All from left + matching from right
  - Use: When you need ALL records from first table
  - Use: To find unmatched/missing records
  - Use: For data quality validation
  - Performance: Slower than INNER (handles more data)
  
  For more information:
  - https://dev.mysql.com/doc/refman/8.0/en/join.html
  - https://www.w3schools.com/sql/sql_join_left.asp
  - https://mode.com/sql-tutorial/sql-joins/
================================================================================
*/
