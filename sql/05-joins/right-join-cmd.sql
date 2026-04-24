/*
================================================================================
  SQL RIGHT JOIN COMPREHENSIVE GUIDE
================================================================================
  File: right-join-cmd.sql
  Description: Complete tutorial on RIGHT JOIN (RIGHT OUTER JOIN) with practical 
               examples using employee, department, project, and project_assignment tables.
  
  AUTHOR: Durgesh Tambe
  CREATED: April 24, 2026
  UPDATED: April 24, 2026
  VERSION: 1.0
  
  WHAT IS RIGHT JOIN?
  ─────────────────────────────────────────────────────────────────────────────
  RIGHT JOIN returns ALL records from the RIGHT table, plus matching records from 
  the LEFT table. If there's no match, NULL values are returned for LEFT table columns.
  
  Syntax:
    SELECT columns
    FROM left_table
    RIGHT JOIN right_table ON left_table.column = right_table.column;
  
  Alternative syntax (same result):
    SELECT columns
    FROM left_table
    RIGHT OUTER JOIN right_table ON left_table.column = right_table.column;
  
  Key Characteristics:
    ✓ Returns ALL records from RIGHT table (guaranteed)
    ✓ Returns matching records from LEFT table
    ✓ Non-matching LEFT records show as NULL
    ✓ Perfect for "right side first" relationships
    ✓ Less common than LEFT JOIN in practice
    ✓ RIGHT OUTER is same as RIGHT (OUTER is optional)
  
  When to use RIGHT JOIN:
    - You want ALL records from the second table
    - You want to OPTIONALLY match with a first table
    - The RIGHT table is the "main" focus
    - Example: Show ALL projects AND their employees (even if none)
    - Example: Show ALL assignments AND employee details
    - Example: Every department must appear, employees optional
  
  RIGHT JOIN can always be rewritten as LEFT JOIN:
    SELECT * FROM A RIGHT JOIN B = SELECT * FROM B LEFT JOIN A
  
  LEFT JOIN vs RIGHT JOIN vs INNER JOIN:
    ┌──────────────┬───────────┬───────────┬───────────┐
    │ Record Type  │ LEFT      │ RIGHT     │ INNER     │
    ├──────────────┼───────────┼───────────┼───────────┤
    │ Match both   │ ✓ Yes     │ ✓ Yes     │ ✓ Yes     │
    │ Left only    │ ✓ Yes     │ ✗ No      │ ✗ No      │
    │ Right only   │ ✗ No      │ ✓ Yes     │ ✗ No      │
    └──────────────┴───────────┴───────────┴───────────┘
  
  TABLE OF CONTENTS:
    1. Basic RIGHT JOIN (2 tables)
    2. RIGHT JOIN with WHERE to find unmatched
    3. RIGHT JOIN with COALESCE (handle NULLs)
    4. RIGHT JOIN with CASE statement
    5. RIGHT JOIN with 3 tables
    6. RIGHT JOIN with 4 tables
    7. RIGHT JOIN with aggregation (GROUP BY)
    8. RIGHT JOIN with COUNT (null detection)
    9. RIGHT JOIN with ORDER BY and LIMIT
    10. RIGHT JOIN as alternative to LEFT JOIN
    
  PREREQUISITES:
    - employee table: employeeId, first_name, last_name, salary, departmentId
    - department table: departmentId, name
    - project table: projectId, project_name, budget, departmentId, status
    - project_assignment: assignment_id, employeeId, projectId, role, allocation_percentage
    
  EXECUTION:
    - Execute each example individually
    - Pay attention to NULL values in results
    - Modify WHERE conditions to experiment
    - Compare with LEFT JOIN examples (often easier to understand)
================================================================================
*/

-- ============================================================================
-- 1. BASIC RIGHT JOIN - Two Tables
-- ============================================================================
-- Show ALL departments and their employees (if assigned)
-- This emphasizes the DEPARTMENT (right table) as primary

SELECT 
    d.departmentId,
    d.name as department_name,
    e.employeeId,
    e.first_name,
    e.last_name,
    e.salary
FROM employee e
RIGHT JOIN department d 
    ON e.departmentId = d.departmentId
ORDER BY d.departmentId, e.last_name;

-- ============================================================================
-- 1B. RIGHT JOIN - Alternative: thinking about it as departments first
-- ============================================================================
-- Shows all employees assigned to departments, with department details
-- Departments without employees are NOT shown in this approach

SELECT 
    d.departmentId,
    d.name as department_name,
    COUNT(e.employeeId) as employee_count,
    ROUND(AVG(e.salary), 2) as avg_salary
FROM employee e
RIGHT JOIN department d ON e.departmentId = d.departmentId
GROUP BY d.departmentId, d.name
ORDER BY employee_count DESC;

-- ============================================================================
-- 1C. Comparison: RIGHT JOIN equivalent to LEFT JOIN reversed
-- ============================================================================
-- These two queries return the SAME result
-- RIGHT JOIN is just LEFT JOIN with tables reversed

-- Using RIGHT JOIN:
-- SELECT * FROM A RIGHT JOIN B ON condition;

-- Equivalent using LEFT JOIN:
SELECT 
    d.departmentId,
    d.name as department_name,
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name
FROM department d
LEFT JOIN employee e ON d.departmentId = e.departmentId
ORDER BY d.departmentId, e.last_name;

-- ============================================================================
-- 2. RIGHT JOIN with WHERE - Find unmatched records (NULLs)
-- ============================================================================
-- Find ALL departments that have NO employees
-- Note: NULL check on LEFT table columns

SELECT 
    d.departmentId,
    d.name as department_name
FROM employee e
RIGHT JOIN department d ON e.departmentId = d.departmentId
WHERE e.employeeId IS NULL  -- No employees in this department
ORDER BY d.departmentId;

-- ============================================================================
-- 2B. RIGHT JOIN - Find all projects but highlight unassigned
-- ============================================================================
-- Show every project and whether it has team members
SELECT 
    p.projectId,
    p.project_name,
    p.budget,
    p.status,
    pa.assignment_id,
    e.employeeId
FROM project_assignment pa
RIGHT JOIN project p ON pa.projectId = p.projectId
LEFT JOIN employee e ON pa.employeeId = e.employeeId
WHERE pa.assignment_id IS NULL
ORDER BY p.projectId;

-- ============================================================================
-- 2C. RIGHT JOIN - All assignments with optional employee details
-- ============================================================================
-- Shows every assignment, replacing missing employee info with NULL
SELECT 
    pa.assignment_id,
    pa.projectId,
    pa.role,
    pa.allocation_percentage,
    e.employeeId,
    COALESCE(CONCAT(e.first_name, ' ', e.last_name), 'Unassigned') as employee_name
FROM employee e
RIGHT JOIN project_assignment pa ON e.employeeId = pa.employeeId
ORDER BY pa.projectId, pa.assignment_id;

-- ============================================================================
-- 3. RIGHT JOIN with COALESCE - Handle NULL values
-- ============================================================================
-- COALESCE returns first non-NULL value
-- Useful for replacing NULL with meaningful defaults

SELECT 
    d.departmentId,
    d.name as department_name,
    e.employeeId,
    COALESCE(CONCAT(e.first_name, ' ', e.last_name), 'No Employee') as employee_name,
    COALESCE(e.salary, 0) as salary
FROM employee e
RIGHT JOIN department d ON e.departmentId = d.departmentId
ORDER BY d.departmentId, e.last_name;

-- ============================================================================
-- 3B. RIGHT JOIN with COALESCE - Project focus view
-- ============================================================================
-- Shows all projects at center, with team member details or "No Team"
SELECT 
    p.projectId,
    p.project_name,
    COALESCE(e.employeeId, -1) as employee_id,
    COALESCE(CONCAT(e.first_name, ' ', e.last_name), 'Unassigned') as team_member,
    COALESCE(pa.role, 'No Role') as assignment_role,
    COALESCE(pa.allocation_percentage, 0) as allocation_pct
FROM project_assignment pa
RIGHT JOIN project p ON pa.projectId = p.projectId
LEFT JOIN employee e ON pa.employeeId = e.employeeId
ORDER BY p.projectId, COALESCE(e.employeeId, 999999);

-- ============================================================================
-- 4. RIGHT JOIN with CASE Statement
-- ============================================================================
-- Categorize department staffing status

SELECT 
    d.departmentId,
    d.name as department_name,
    COUNT(e.employeeId) as employee_count,
    CASE 
        WHEN COUNT(e.employeeId) = 0 THEN 'Empty'
        WHEN COUNT(e.employeeId) < 5 THEN 'Understaffed'
        WHEN COUNT(e.employeeId) < 10 THEN 'Adequate'
        ELSE 'Overstaffed'
    END as staffing_level,
    ROUND(AVG(e.salary), 2) as avg_salary
FROM employee e
RIGHT JOIN department d ON e.departmentId = d.departmentId
GROUP BY d.departmentId, d.name
ORDER BY staffing_level, employee_count DESC;

-- ============================================================================
-- 4B. RIGHT JOIN with CASE - Project assignment status
-- ============================================================================
SELECT 
    p.projectId,
    p.project_name,
    p.status,
    CASE 
        WHEN COUNT(pa.assignment_id) = 0 THEN 'No_Team'
        WHEN AVG(pa.allocation_percentage) >= 80 THEN 'Heavily_Staffed'
        WHEN AVG(pa.allocation_percentage) >= 50 THEN 'Moderately_Staffed'
        WHEN AVG(pa.allocation_percentage) >= 25 THEN 'Lightly_Staffed'
        ELSE 'Minimal'
    END as staffing_level,
    COUNT(DISTINCT pa.employeeId) as team_size
FROM project_assignment pa
RIGHT JOIN project p ON pa.projectId = p.projectId
GROUP BY p.projectId, p.project_name, p.status
ORDER BY p.projectId;

-- ============================================================================
-- 5. RIGHT JOIN with 3 Tables
-- ============================================================================
-- Show ALL projects with their assignments and employee details
SELECT 
    p.projectId,
    p.project_name,
    pa.assignment_id,
    pa.role,
    pa.allocation_percentage,
    e.employeeId,
    CONCAT(COALESCE(e.first_name, ''), ' ', COALESCE(e.last_name, '')) as employee_name,
    e.salary
FROM employee e
RIGHT JOIN project_assignment pa ON e.employeeId = pa.employeeId
RIGHT JOIN project p ON pa.projectId = p.projectId
ORDER BY p.projectId, pa.assignment_id;

-- ============================================================================
-- 5B. RIGHT JOIN - Focus on projects with their teams
-- ============================================================================
-- Every project appears, with team member details or "No Team"
SELECT 
    p.projectId,
    p.project_name,
    p.budget,
    p.status,
    COUNT(DISTINCT pa.employeeId) as team_size,
    GROUP_CONCAT(DISTINCT CONCAT(e.first_name, ' ', e.last_name)) as team_members,
    ROUND(AVG(e.salary), 2) as avg_team_salary
FROM employee e
RIGHT JOIN project_assignment pa ON e.employeeId = pa.employeeId
RIGHT JOIN project p ON pa.projectId = p.projectId
GROUP BY p.projectId, p.project_name, p.budget, p.status
ORDER BY p.projectId;

-- ============================================================================
-- 6. RIGHT JOIN with 4 Tables
-- ============================================================================
-- Complete view focused on the rightmost table (project as center)

SELECT 
    p.projectId,
    p.project_name,
    p.budget,
    d.name as managing_department,
    pa.assignment_id,
    pa.role,
    pa.allocation_percentage,
    e.employeeId,
    CONCAT(COALESCE(e.first_name, ''), ' ', COALESCE(e.last_name, '')) as employee_name,
    COALESCE(e.salary, 0) as salary
FROM employee e
RIGHT JOIN project_assignment pa ON e.employeeId = pa.employeeId
RIGHT JOIN project p ON pa.projectId = p.projectId
LEFT JOIN department d ON p.departmentId = d.departmentId
ORDER BY p.projectId, pa.assignment_id;

-- ============================================================================
-- 6B. RIGHT JOIN - Projects with complete details and optional assignments
-- ============================================================================
SELECT 
    p.projectId,
    p.project_name,
    p.status,
    p.budget,
    d.name as managing_department,
    COUNT(DISTINCT pa.assignment_id) as total_assignments,
    COUNT(DISTINCT pa.employeeId) as unique_employees,
    COALESCE(SUM(pa.allocation_percentage), 0) as total_allocation_pct,
    COALESCE(ROUND(AVG(e.salary), 2), 0) as avg_employee_salary
FROM employee e
RIGHT JOIN project_assignment pa ON e.employeeId = pa.employeeId
RIGHT JOIN project p ON pa.projectId = p.projectId
LEFT JOIN department d ON p.departmentId = d.departmentId
GROUP BY p.projectId, p.project_name, p.status, p.budget, d.name
ORDER BY p.projectId;

-- ============================================================================
-- 7. RIGHT JOIN with Aggregation (GROUP BY)
-- ============================================================================
-- Show EVERY department with its statistics (even empty ones)

SELECT 
    d.departmentId,
    d.name as department_name,
    COUNT(e.employeeId) as total_employees,
    COALESCE(ROUND(AVG(e.salary), 2), 0) as avg_salary,
    COALESCE(MIN(e.salary), 0) as min_salary,
    COALESCE(MAX(e.salary), 0) as max_salary,
    COALESCE(SUM(e.salary), 0) as total_payroll
FROM employee e
RIGHT JOIN department d ON e.departmentId = d.departmentId
GROUP BY d.departmentId, d.name
ORDER BY total_employees DESC, d.name;

-- ============================================================================
-- 7B. RIGHT JOIN - All projects with complete statistics
-- ============================================================================
-- Every project is shown, with its team information

SELECT 
    p.projectId,
    p.project_name,
    p.status,
    p.budget,
    COALESCE(COUNT(DISTINCT pa.assignment_id), 0) as total_assignments,
    COALESCE(COUNT(DISTINCT pa.employeeId), 0) as unique_employees,
    COALESCE(SUM(pa.allocation_percentage), 0) as total_allocation_pct,
    CASE 
        WHEN COUNT(DISTINCT pa.employeeId) = 0 THEN 'No Team'
        WHEN SUM(pa.allocation_percentage) < 100 THEN 'Under Allocated'
        WHEN SUM(pa.allocation_percentage) = 100 THEN 'Fully Allocated'
        ELSE 'Over Allocated'
    END as allocation_status
FROM project_assignment pa
RIGHT JOIN project p ON pa.projectId = p.projectId
LEFT JOIN employee e ON pa.employeeId = e.employeeId
GROUP BY p.projectId, p.project_name, p.status, p.budget
ORDER BY p.projectId;

-- ============================================================================
-- 7C. RIGHT JOIN - Every assignment with its details and optional employee link
-- ============================================================================
SELECT 
    pa.assignment_id,
    pa.projectId,
    pa.role,
    pa.allocation_percentage,
    COALESCE(e.employeeId, -1) as employee_id,
    COALESCE(CONCAT(e.first_name, ' ', e.last_name), 'Unassigned') as employee_name,
    COALESCE(d.name, 'Unknown') as department_name,
    COALESCE(e.salary, 0) as employee_salary
FROM employee e
RIGHT JOIN project_assignment pa ON e.employeeId = pa.employeeId
LEFT JOIN department d ON e.departmentId = d.departmentId
ORDER BY pa.projectId, pa.assignment_id;

-- ============================================================================
-- 8. RIGHT JOIN with COUNT - Identify NULL records
-- ============================================================================
-- Highlight which records have NO match on the left side

SELECT 
    d.departmentId,
    d.name as department_name,
    CASE WHEN e.employeeId IS NULL THEN 'NO_EMPLOYEES' ELSE 'HAS_EMPLOYEES' END as employee_status,
    COUNT(e.employeeId) as count
FROM employee e
RIGHT JOIN department d ON e.departmentId = d.departmentId
GROUP BY d.departmentId, d.name, CASE WHEN e.employeeId IS NULL THEN 'NO_EMPLOYEES' ELSE 'HAS_EMPLOYEES' END
ORDER BY employee_status DESC, d.departmentId;

-- ============================================================================
-- 8B. RIGHT JOIN - Data quality report (every project checked)
-- ============================================================================
SELECT 
    'Total_Projects' as metric_type,
    COUNT(DISTINCT p.projectId) as count
FROM project p
LEFT JOIN project_assignment pa ON p.projectId = pa.projectId

UNION ALL

SELECT 
    'Projects_With_Assignments' as metric_type,
    COUNT(DISTINCT p.projectId) as count
FROM project p
WHERE EXISTS (SELECT 1 FROM project_assignment WHERE projectId = p.projectId)

UNION ALL

SELECT 
    'Projects_Without_Assignments' as metric_type,
    COUNT(DISTINCT p.projectId) as count
FROM project p
LEFT JOIN project_assignment pa ON p.projectId = pa.projectId
WHERE pa.assignment_id IS NULL

UNION ALL

SELECT 
    'Unassigned_Roles' as metric_type,
    COUNT(DISTINCT pa.assignment_id) as count
FROM project_assignment pa
WHERE pa.employeeId IS NULL;

-- ============================================================================
-- 9. RIGHT JOIN with ORDER BY and LIMIT
-- ============================================================================
-- Get top 5 departments by employee count

SELECT 
    d.departmentId,
    d.name as department_name,
    COUNT(e.employeeId) as total_employees,
    ROUND(AVG(e.salary), 2) as avg_salary
FROM employee e
RIGHT JOIN department d ON e.departmentId = d.departmentId
GROUP BY d.departmentId, d.name
ORDER BY total_employees DESC, d.name
LIMIT 5;

-- ============================================================================
-- 9B. RIGHT JOIN - Show all projects ordered by team size
-- ============================================================================
SELECT 
    p.projectId,
    p.project_name,
    p.status,
    COUNT(DISTINCT pa.employeeId) as team_size,
    COALESCE(SUM(pa.allocation_percentage), 0) as total_allocation
FROM project_assignment pa
RIGHT JOIN project p ON pa.projectId = p.projectId
GROUP BY p.projectId, p.project_name, p.status
ORDER BY team_size DESC, p.projectId
LIMIT 10;

-- ============================================================================
-- 10. RIGHT JOIN as Alternative to LEFT JOIN
-- ============================================================================
-- Demonstrate how RIGHT JOIN can replace LEFT JOIN

-- LEFT JOIN approach (showing all employees):
SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    d.name as department_name
FROM employee e
LEFT JOIN department d ON e.departmentId = d.departmentId
ORDER BY e.employeeId;

-- Equivalent using RIGHT JOIN (all departments reversed):
SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    d.name as department_name
FROM department d
RIGHT JOIN employee e ON e.departmentId = d.departmentId
ORDER BY e.employeeId;

-- ============================================================================
-- 10B. RIGHT JOIN - When to choose right vs rewriting as left
-- ============================================================================
-- Sometimes RIGHT JOIN is clearer to intent
-- Show ALL projects (right), optionally with team members (left)

SELECT 
    p.projectId,
    p.project_name,
    p.budget,
    e.employeeId,
    CONCAT(COALESCE(e.first_name, ''), ' ', COALESCE(e.last_name, '')) as employee_name,
    pa.role,
    pa.allocation_percentage
FROM employee e
RIGHT JOIN project_assignment pa ON e.employeeId = pa.employeeId
RIGHT JOIN project p ON pa.projectId = p.projectId
ORDER BY p.projectId, pa.assignment_id;

-- ============================================================================
-- PRACTICE QUESTIONS
-- ============================================================================
-- Answer these using RIGHT JOIN:
--
-- Q1: Show ALL departments and count of employees (including 0)
-- Q2: Find all projects with their team members (if any)
-- Q3: List every assignment and indicate if it has an employee
-- Q4: Show projects in "Active" status with their full team details
-- Q5: Find all departments sorted by how many projects they manage
-- Q6: Create a data quality report of all projects (with/without teams)
-- Q7: Show all project assignments and highlight those without employees
-- Q8: Compare project allocation status for all projects
-- Q9: List every department with its highest-paid employee
-- Q10: Find projects with unmatched assignments (no employee linked)

-- ============================================================================
-- KEY POINTS ABOUT RIGHT JOIN
-- ============================================================================
-- ✓ Returns ALL rows from RIGHT table (guaranteed inclusion)
-- ✓ Rows with no match in LEFT table have NULL values
-- ✓ Less common than LEFT JOIN (can be confusing)
-- ✓ Can be rewritten as LEFT JOIN with tables reversed
-- ✓ Use IS NULL to find unmatched left records
-- ✓ Use COALESCE to replace NULLs with defaults
-- ✓ When to use: RIGHT table is primary, LEFT is optional
-- ✓ Performance: Same as LEFT JOIN (just different table emphasis)

-- ============================================================================
-- COMMON MISTAKES TO AVOID
-- ============================================================================
-- MISTAKE 1: Confusing which table is "the right table"
-- In: SELECT * FROM A RIGHT JOIN B
-- RIGHT table is B, not the table on the right side visually
-- This returns ALL of B, optionally matched with A

-- MISTAKE 2: Using WHERE that negates the RIGHT JOIN benefit
-- WRONG:  RIGHT JOIN department WHERE e.departmentId IS NOT NULL
--         This filters to only matched records (same as INNER)
-- RIGHT:  RIGHT JOIN department WHERE d.departmentId IS NULL
--         This finds departments with no employees

-- MISTAKE 3: Not using RIGHT JOIN when it's clearer
-- Sometimes RIGHT JOIN makes code MORE readable
-- Don't always default to LEFT JOIN reversal
-- Use RIGHT JOIN when right table is logically primary

-- MISTAKE 4: Forgetting NULL checks on left columns
-- WRONG:  WHERE e.salary > 50000  (eliminates unmatched)
-- RIGHT:  WHERE e.salary > 50000 OR e.salary IS NULL

-- MISTAKE 5: Performance confusion between LEFT and RIGHT
-- Both have same performance characteristics
-- Use whichever makes code most readable

-- ============================================================================
-- COMPARISON: LEFT vs RIGHT vs INNER JOIN
-- ============================================================================
-- LEFT:   All left, matched right (keep all from first table)
-- RIGHT:  All right, matched left (keep all from second table)
-- INNER:  Only matches (strict mode, no NULLs)
--
-- RIGHT JOIN to LEFT JOIN conversion:
--   SELECT * FROM A RIGHT JOIN B ON condition
--   Equals:
--   SELECT * FROM B LEFT JOIN A ON condition

-- ============================================================================
-- WHEN TO USE RIGHT JOIN
-- ============================================================================
-- Use RIGHT JOIN when:
--   1. RIGHT table is logically primary to the query
--   2. You want ALL records from RIGHT table guaranteed
--   3. It makes code more readable than LEFT JOIN reversal
--   4. You're following coding standards that prefer it
--
-- In practice:
--   - LEFT JOIN is more common (easier mental model)
--   - RIGHT JOIN useful for "show everything from this table"
--   - Can usually rewrite as LEFT JOIN if confusing

/*
================================================================================
  END OF RIGHT JOIN GUIDE
================================================================================
  Summary:
  - RIGHT JOIN: All from right + matching from left
  - Use: When you need ALL records from second table
  - Equivalent to: LEFT JOIN with tables reversed
  - Performance: Same as LEFT JOIN
  - Readability: Sometimes clearer, often confusing
  
  Pro Tip:
  Most SQL developers prefer LEFT JOIN because it's more intuitive.
  RIGHT JOIN is mostly useful when right table is logically primary.
  
  For more information:
  - https://dev.mysql.com/doc/refman/8.0/en/join.html
  - https://www.w3schools.com/sql/sql_join_right.asp
  - https://mode.com/sql-tutorial/sql-joins/
================================================================================
*/
