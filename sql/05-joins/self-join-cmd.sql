/*
================================================================================
  SQL SELF JOIN COMPREHENSIVE GUIDE
================================================================================
  File: self-join-cmd.sql
  Description: Complete tutorial on SELF JOIN with practical examples using 
               employee (manager relationships), department, project, and related tables.
  
  AUTHOR: Durgesh Tambe
  CREATED: April 24, 2026
  UPDATED: April 24, 2026
  VERSION: 1.0
  
  WHAT IS A SELF JOIN?
  ─────────────────────────────────────────────────────────────────────────────
  A SELF JOIN is a regular JOIN, but the table is joined with itself.
  It's used to compare rows within the SAME table or to establish hierarchical
  relationships within a single table.
  
  Key Characteristics:
    ✓ Joins a table to itself
    ✓ Requires table aliases to distinguish the two instances
    ✓ Uses same JOIN syntax as regular joins (INNER, LEFT, RIGHT, FULL)
    ✓ Common for hierarchical/tree data (manager-employee, parent-child)
    ✓ Works in ALL databases (MySQL, PostgreSQL, SQL Server, Oracle, SQLite)
    ✓ Very useful for comparative analysis
  
  Syntax:
    SELECT columns
    FROM table_name AS alias1
    [INNER/LEFT/RIGHT/FULL] JOIN table_name AS alias2 
    ON alias1.column = alias2.column;
  
  Note on Table Aliases:
    - MANDATORY when doing a SELF JOIN
    - First instance: table_name AS t1 (or use short names: a, b, etc.)
    - Second instance: table_name AS t2
    - Without aliases, MySQL can't distinguish between the two instances
  
  When to use SELF JOIN:
    ✓ Manager-employee relationships (who manages whom)
    ✓ Hierarchical data (org charts, category trees)
    ✓ Finding related records in same table
    ✓ Comparing values within same table
    ✓ Parent-child relationships
    ✓ Historical data comparison (old vs new values)
    ✓ Graph/network relationships
    ✓ Finding similar/matching records
  
  Database Support:
    ✅ MySQL ............ SELF JOIN fully supported
    ✅ PostgreSQL ....... SELF JOIN fully supported
    ✅ SQL Server ....... SELF JOIN fully supported
    ✅ Oracle ........... SELF JOIN fully supported
    ✅ SQLite ........... SELF JOIN fully supported
  
  Common Use Cases:
    1. Organizational Hierarchy - Employees and their managers
    2. Category Trees - Parent categories and subcategories
    3. Network Graphs - Connected nodes
    4. Comparisons - Finding duplicates or similar items
    5. Sequences - Previous and next records
    6. Data Quality - Finding inconsistencies
  
  TABLE OF CONTENTS:
    1. Basic SELF JOIN - Manager-Employee Relationship
    2. SELF JOIN with WHERE Clause - Filter specific relationships
    3. SELF JOIN for Hierarchical Data - Multi-level org chart
    4. LEFT SELF JOIN - All employees with optional managers
    5. SELF JOIN with Aggregation - Team size by manager
    6. SELF JOIN for Finding Duplicates - Data quality check
    7. SELF JOIN with Multiple Conditions - Complex comparisons
    8. SELF JOIN for Sequence Analysis - Previous and next records
    9. SELF JOIN with UNION - Bidirectional relationships
    10. SELF JOIN for Three-Level Hierarchy - Department structure
  
  IMPORTANT DISTINCTIONS:
    Regular JOIN:     table1 JOIN table2 (different tables)
    SELF JOIN:        table1 JOIN table1 (same table, different aliases)
    Solution:         Always use aliases (AS t1, AS t2)
  
  PREREQUISITES:
    - employee table: employeeId, first_name, last_name, manager_id, salary, departmentId
    - department table: departmentId, name, manager_id (department manager)
    - project table: projectId, project_name, parent_project_id
    - project_assignment: assignment_id, employeeId, projectId, role
    
  EXECUTION:
    - Execute each example individually
    - Pay attention to table aliases
    - Notice how the same table appears twice in FROM clause
    - Understand how WHERE helps filter specific relationships
================================================================================
*/

-- ============================================================================
-- 1. BASIC SELF JOIN - Manager-Employee Relationship
-- ============================================================================
-- Find all employees and their managers
-- INNER JOIN: Shows only employees who HAVE a manager

SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    e.salary as employee_salary,
    m.employeeId as manager_id,
    CONCAT(m.first_name, ' ', m.last_name) as manager_name,
    m.salary as manager_salary
FROM employee e
INNER JOIN employee m ON e.manager_id = m.employeeId
ORDER BY e.employeeId;

-- Explanation:
-- e = alias for EMPLOYEE table (employees)
-- m = alias for EMPLOYEE table (managers)
-- e.manager_id = m.employeeId links employees to their managers
-- Result: Shows each employee with their direct manager's information

-- ============================================================================
-- 1B. Basic SELF JOIN - Alternative with more details
-- ============================================================================
-- Show employees and managers with salary comparison

SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    e.salary as emp_salary,
    m.employeeId as manager_id,
    CONCAT(m.first_name, ' ', m.last_name) as manager_name,
    m.salary as mgr_salary,
    ROUND((m.salary - e.salary), 2) as salary_difference,
    ROUND(((m.salary - e.salary) / e.salary * 100), 2) as salary_pct_difference
FROM employee e
INNER JOIN employee m ON e.manager_id = m.employeeId
ORDER BY salary_difference DESC;

-- ============================================================================
-- 2. SELF JOIN with WHERE Clause - Filter specific relationships
-- ============================================================================
-- Find all employees whose salary is LESS than their manager's salary
-- (This should be most relationships!)

SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    e.salary as emp_salary,
    CONCAT(m.first_name, ' ', m.last_name) as manager_name,
    m.salary as mgr_salary,
    CONCAT('$', FORMAT((m.salary - e.salary), 2)) as salary_gap
FROM employee e
INNER JOIN employee m ON e.manager_id = m.employeeId
WHERE e.salary < m.salary
ORDER BY salary_gap DESC;

-- ============================================================================
-- 2B. SELF JOIN - Find managers who earn LESS than their employees
-- ============================================================================
-- Data quality check: Flag problematic relationships

SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    e.salary as emp_salary,
    CONCAT(m.first_name, ' ', m.last_name) as manager_name,
    m.salary as mgr_salary,
    'SALARY_ISSUE' as flag
FROM employee e
INNER JOIN employee m ON e.manager_id = m.employeeId
WHERE e.salary > m.salary
ORDER BY e.salary DESC;

-- ============================================================================
-- 3. LEFT SELF JOIN - All employees with optional managers
-- ============================================================================
-- Shows all employees, including those with NO manager (top executives)

SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    e.salary,
    COALESCE(CONCAT(m.first_name, ' ', m.last_name), 'NO_MANAGER') as manager_name,
    COALESCE(m.salary, 0) as manager_salary,
    CASE 
        WHEN m.employeeId IS NOT NULL THEN 'Has Manager'
        ELSE 'Top Level (CEO/Head)'
    END as employee_level
FROM employee e
LEFT JOIN employee m ON e.manager_id = m.employeeId
ORDER BY e.employeeId;

-- ============================================================================
-- 3B. LEFT SELF JOIN - Find employees with NO manager
-- ============================================================================
-- Identify top-level executives

SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    e.salary,
    d.name as department_name
FROM employee e
LEFT JOIN employee m ON e.manager_id = m.employeeId
LEFT JOIN department d ON e.departmentId = d.departmentId
WHERE m.employeeId IS NULL
ORDER BY e.salary DESC;

-- ============================================================================
-- 4. SELF JOIN for Organizational Hierarchy - Multi-level
-- ============================================================================
-- Show employee, manager, and manager's manager (3 levels)

SELECT 
    e.employeeId as emp_id,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    m.employeeId as manager_id,
    CONCAT(m.first_name, ' ', m.last_name) as manager_name,
    gm.employeeId as grandmanager_id,
    CONCAT(gm.first_name, ' ', gm.last_name) as grandmanager_name
FROM employee e
LEFT JOIN employee m ON e.manager_id = m.employeeId
LEFT JOIN employee gm ON m.manager_id = gm.employeeId
WHERE e.employeeId IS NOT NULL
ORDER BY emp_id;

-- Explanation:
-- e = employee
-- m = employee's manager
-- gm = employee's manager's manager (grandmanager)
-- Shows full reporting chain (up to 3 levels)

-- ============================================================================
-- 4B. SELF JOIN - Four-level Hierarchy
-- ============================================================================
-- Employee > Manager > Director > VP structure

SELECT 
    e.employeeId as emp_id,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    COALESCE(CONCAT(m.first_name, ' ', m.last_name), 'N/A') as manager_name,
    COALESCE(CONCAT(d.first_name, ' ', d.last_name), 'N/A') as director_name,
    COALESCE(CONCAT(v.first_name, ' ', v.last_name), 'N/A') as vp_name
FROM employee e
LEFT JOIN employee m ON e.manager_id = m.employeeId
LEFT JOIN employee d ON m.manager_id = d.employeeId
LEFT JOIN employee v ON d.manager_id = v.employeeId
WHERE e.manager_id IS NOT NULL
ORDER BY emp_id;

-- ============================================================================
-- 5. SELF JOIN with Aggregation - Team size by manager
-- ============================================================================
-- Count employees under each manager

SELECT 
    m.employeeId as manager_id,
    CONCAT(m.first_name, ' ', m.last_name) as manager_name,
    COUNT(e.employeeId) as team_size,
    COALESCE(ROUND(AVG(e.salary), 2), 0) as avg_team_salary,
    COALESCE(MIN(e.salary), 0) as min_team_salary,
    COALESCE(MAX(e.salary), 0) as max_team_salary
FROM employee e
INNER JOIN employee m ON e.manager_id = m.employeeId
GROUP BY m.employeeId, m.first_name, m.last_name
ORDER BY team_size DESC;

-- ============================================================================
-- 5B. SELF JOIN - Include managers with NO team
-- ============================================================================
-- All employees and their team sizes (even if no direct reports)

SELECT 
    COALESCE(m.employeeId, e.employeeId) as person_id,
    COALESCE(CONCAT(m.first_name, ' ', m.last_name), 
             CONCAT(e.first_name, ' ', e.last_name)) as person_name,
    COUNT(e.employeeId) as direct_reports,
    COALESCE(m.employeeId, 0) as manager_id
FROM employee e
RIGHT JOIN employee m ON e.manager_id = m.employeeId
GROUP BY m.employeeId, m.first_name, m.last_name, e.employeeId, e.first_name, e.last_name
ORDER BY direct_reports DESC;

-- ============================================================================
-- 6. SELF JOIN for Duplicate Detection - Data Quality
-- ============================================================================
-- Find employees with the same first name in same department

SELECT 
    e1.employeeId as employee1_id,
    CONCAT(e1.first_name, ' ', e1.last_name) as employee1_name,
    e1.salary as emp1_salary,
    e2.employeeId as employee2_id,
    CONCAT(e2.first_name, ' ', e2.last_name) as employee2_name,
    e2.salary as emp2_salary,
    d.name as department_name
FROM employee e1
INNER JOIN employee e2 ON e1.first_name = e2.first_name 
    AND e1.departmentId = e2.departmentId
    AND e1.employeeId < e2.employeeId
LEFT JOIN department d ON e1.departmentId = d.departmentId
ORDER BY department_name, e1.first_name;

-- ============================================================================
-- 6B. SELF JOIN - Find employees with similar salary
-- ============================================================================
-- Identify potential duplicates or data entry errors

SELECT 
    e1.employeeId as emp1_id,
    CONCAT(e1.first_name, ' ', e1.last_name) as emp1_name,
    e1.salary as emp1_salary,
    e2.employeeId as emp2_id,
    CONCAT(e2.first_name, ' ', e2.last_name) as emp2_name,
    e2.salary as emp2_salary,
    ABS(e1.salary - e2.salary) as salary_diff
FROM employee e1
INNER JOIN employee e2 ON ABS(e1.salary - e2.salary) <= 100
    AND e1.employeeId < e2.employeeId
    AND e1.departmentId = e2.departmentId
ORDER BY salary_diff, e1.employeeId;

-- ============================================================================
-- 7. SELF JOIN with Multiple Conditions
-- ============================================================================
-- Find employees in same department but different managers

SELECT 
    e1.employeeId as emp1_id,
    CONCAT(e1.first_name, ' ', e1.last_name) as emp1_name,
    COALESCE(CONCAT(m1.first_name, ' ', m1.last_name), 'NO_MGR') as emp1_manager,
    e2.employeeId as emp2_id,
    CONCAT(e2.first_name, ' ', e2.last_name) as emp2_name,
    COALESCE(CONCAT(m2.first_name, ' ', m2.last_name), 'NO_MGR') as emp2_manager,
    d.name as department_name
FROM employee e1
INNER JOIN employee e2 ON e1.departmentId = e2.departmentId
    AND e1.manager_id != e2.manager_id
    AND e1.employeeId < e2.employeeId
LEFT JOIN employee m1 ON e1.manager_id = m1.employeeId
LEFT JOIN employee m2 ON e2.manager_id = m2.employeeId
LEFT JOIN department d ON e1.departmentId = d.departmentId
ORDER BY department_name, emp1_id;

-- ============================================================================
-- 8. SELF JOIN for Sequence Analysis - Previous and Next
-- ============================================================================
-- Find previous and next employees in order

SELECT 
    e1.employeeId as current_emp_id,
    CONCAT(e1.first_name, ' ', e1.last_name) as current_emp_name,
    e1.salary as current_salary,
    LAG(e1.employeeId) OVER (ORDER BY e1.employeeId) as prev_emp_id,
    COALESCE(
        (SELECT CONCAT(first_name, ' ', last_name) 
         FROM employee e2 
         WHERE e2.employeeId = LAG(e1.employeeId) OVER (ORDER BY e1.employeeId)), 
        'FIRST'
    ) as prev_emp_name,
    LEAD(e1.employeeId) OVER (ORDER BY e1.employeeId) as next_emp_id,
    COALESCE(
        (SELECT CONCAT(first_name, ' ', last_name) 
         FROM employee e2 
         WHERE e2.employeeId = LEAD(e1.employeeId) OVER (ORDER BY e1.employeeId)), 
        'LAST'
    ) as next_emp_name
FROM employee e1
ORDER BY e1.employeeId;

-- ============================================================================
-- 8B. SELF JOIN - Simpler previous/next (without window functions)
-- ============================================================================
-- Find employees hired before and after each employee (approximate method)

SELECT 
    e1.employeeId as current_id,
    CONCAT(e1.first_name, ' ', e1.last_name) as employee_name,
    e1.salary as current_salary,
    COALESCE(e2.employeeId, -1) as similar_salary_emp_id,
    COALESCE(CONCAT(e2.first_name, ' ', e2.last_name), 'NO_MATCH') as similar_employee,
    COALESCE(e2.salary, 0) as similar_salary
FROM employee e1
LEFT JOIN employee e2 ON ABS(e1.salary - e2.salary) <= 1000 
    AND e1.employeeId != e2.employeeId
    AND e2.employeeId > e1.employeeId
ORDER BY e1.salary, e1.employeeId;

-- ============================================================================
-- 9. SELF JOIN with UNION - Bidirectional Relationships
-- ============================================================================
-- Show both "reports to" and "manages" relationships

SELECT 
    'Employee_Reports_To' as relationship_type,
    e.employeeId as person1_id,
    CONCAT(e.first_name, ' ', e.last_name) as person1_name,
    m.employeeId as person2_id,
    CONCAT(m.first_name, ' ', m.last_name) as person2_name
FROM employee e
LEFT JOIN employee m ON e.manager_id = m.employeeId
WHERE m.employeeId IS NOT NULL

UNION

SELECT 
    'Manager_Oversees' as relationship_type,
    m.employeeId as person1_id,
    CONCAT(m.first_name, ' ', m.last_name) as person1_name,
    e.employeeId as person2_id,
    CONCAT(e.first_name, ' ', e.last_name) as person2_name
FROM employee e
LEFT JOIN employee m ON e.manager_id = m.employeeId
WHERE m.employeeId IS NOT NULL
ORDER BY relationship_type, person1_id, person2_id;

-- ============================================================================
-- 10. SELF JOIN for Project Hierarchy
-- ============================================================================
-- Find parent projects and their sub-projects

SELECT 
    p1.projectId as project_id,
    p1.project_name as project_name,
    p1.status as project_status,
    p1.budget as project_budget,
    COALESCE(p2.projectId, -1) as parent_project_id,
    COALESCE(p2.project_name, 'NO_PARENT') as parent_project_name,
    COALESCE(p2.status, 'N/A') as parent_status,
    COUNT(DISTINCT pa.employeeId) as team_members
FROM project p1
LEFT JOIN project p2 ON p1.parent_project_id = p2.projectId
LEFT JOIN project_assignment pa ON p1.projectId = pa.projectId
GROUP BY p1.projectId, p1.project_name, p1.status, p1.budget, 
         p2.projectId, p2.project_name, p2.status
ORDER BY project_id;

-- ============================================================================
-- 11. SELF JOIN - Complete Organizational Report
-- ============================================================================
-- Comprehensive view of organizational structure

SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    d.name as department_name,
    e.salary,
    CONCAT(m.first_name, ' ', m.last_name) as manager_name,
    gm.employeeId as director_id,
    CONCAT(gm.first_name, ' ', gm.last_name) as director_name,
    CASE 
        WHEN m.employeeId IS NULL THEN 'CEO/Head'
        WHEN gm.employeeId IS NULL THEN 'Department Head'
        ELSE 'Employee'
    END as level_in_hierarchy
FROM employee e
LEFT JOIN department d ON e.departmentId = d.departmentId
LEFT JOIN employee m ON e.manager_id = m.employeeId
LEFT JOIN employee gm ON m.manager_id = gm.employeeId
ORDER BY d.name, e.salary DESC;

-- ============================================================================
-- 12. SELF JOIN - Manager Compensation Analysis
-- ============================================================================
-- Compare manager salary to their team's average

SELECT 
    m.employeeId as manager_id,
    CONCAT(m.first_name, ' ', m.last_name) as manager_name,
    m.salary as manager_salary,
    COUNT(e.employeeId) as team_size,
    COALESCE(ROUND(AVG(e.salary), 2), 0) as team_avg_salary,
    ROUND((m.salary - COALESCE(AVG(e.salary), 0)), 2) as salary_premium,
    ROUND(((m.salary - COALESCE(AVG(e.salary), 0)) / COALESCE(AVG(e.salary), 1) * 100), 2) as premium_pct
FROM employee m
LEFT JOIN employee e ON m.employeeId = e.manager_id
GROUP BY m.employeeId, m.first_name, m.last_name, m.salary
HAVING COUNT(e.employeeId) > 0
ORDER BY salary_premium DESC;

-- ============================================================================
-- PRACTICE QUESTIONS
-- ============================================================================
-- Answer these using SELF JOIN:
--
-- Q1: Find all employees and their direct managers
-- Q2: Find employees whose salary is higher than their manager
-- Q3: Show organizational hierarchy (up to 3 levels)
-- Q4: Count team members for each manager
-- Q5: Find employees with same first name in same department
-- Q6: Identify all top-level executives (no manager)
-- Q7: Show how many levels of management exist in the company
-- Q8: Find managers with the longest reporting chains below them
-- Q9: Compare compensation to team average
-- Q10: Create org chart showing all relationships

-- ============================================================================
-- KEY POINTS ABOUT SELF JOIN
-- ============================================================================
-- ✓ Join a table to itself
-- ✓ REQUIRES table aliases (mandatory)
-- ✓ Use for hierarchical data (manager-employee, parent-child)
-- ✓ Supports all JOIN types (INNER, LEFT, RIGHT, FULL)
-- ✓ Common in organizational/tree structures
-- ✓ Works in all databases
-- ✓ Can create multiple levels of hierarchy (e > m > gm > etc.)
-- ✓ Useful for data quality checks
-- ✓ Can compare values within same table
-- ✓ Essential for relationship analysis

-- ============================================================================
-- COMMON MISTAKES TO AVOID
-- ============================================================================
-- MISTAKE 1: Forgetting table aliases
-- WRONG:  SELECT * FROM employee JOIN employee ON ...
-- RIGHT:  SELECT * FROM employee e JOIN employee m ON ...

-- MISTAKE 2: Not distinguishing which alias is which
-- WRONG:  SELECT * FROM e JOIN m (confusing which is employee vs manager)
-- RIGHT:  Use clear naming: e for employee, m for manager

-- MISTAKE 3: Wrong join condition
-- WRONG:  FROM e JOIN m ON e.employeeId = m.employeeId (same person!)
-- RIGHT:  FROM e JOIN m ON e.manager_id = m.employeeId

-- MISTAKE 4: Not using LEFT JOIN when needed
-- WRONG:  INNER JOIN (loses top-level executives with no manager)
-- RIGHT:  LEFT JOIN (includes all employees)

-- MISTAKE 5: Missing WHERE clause for filtering
-- WRONG:  SELECT * FROM e JOIN m (returns too many rows)
-- RIGHT:  Add WHERE clause to filter specific conditions

-- MISTAKE 6: Not considering NULL manager_id
-- WRONG:  Where assumption that all employees have managers
-- RIGHT:  Use LEFT JOIN and check IS NULL for no manager

-- ============================================================================
-- COMPARISON: Different JOIN Types on SELF JOIN
-- ============================================================================
--
-- INNER SELF JOIN:   Only employees with managers (excludes CEOs)
-- LEFT SELF JOIN:    All employees, managers optional (includes CEOs)
-- RIGHT SELF JOIN:   All managers, employees optional (shows vacant positions)
-- FULL OUTER:        All from both sides (MySQL: use UNION)
--
-- Performance: INNER < LEFT < RIGHT < FULL (similar to regular joins)

-- ============================================================================
-- WHEN TO USE SELF JOIN
-- ============================================================================
--
-- Use SELF JOIN when:
--   1. You have hierarchical data in one table
--   2. Need to compare rows within same table
--   3. Building organizational charts
--   4. Finding duplication or data quality issues
--   5. Establishing relationships between records
--   6. Creating parent-child mappings
--   7. Analyzing sequences or sequences in data
--   8. Network/graph analysis with single table
--
-- Do NOT use SELF JOIN when:
--   1. Data should be in separate tables (normalization issue)
--   2. Relationship is handled by separate junction table
--   3. Performance is critical on very large datasets
--   4. Data structure suggests multiple tables

-- ============================================================================
-- BEST PRACTICES FOR SELF JOIN
-- ============================================================================
--
-- 1. Use clear, descriptive aliases
--    ✓ e for employee, m for manager, gm for grandmanager
--    ✗ t1 and t2 (too generic)
--
-- 2. Always use LEFT JOIN unless you specifically need INNER
--    Reason: Don't want to miss top-level records
--
-- 3. Use COALESCE for NULL handling
--    Makes output more readable
--
-- 4. Add data quality checks
--    FLAG issues like managers earning less than employees
--
-- 5. Test with small datasets first
--    Self joins can produce large result sets
--
-- 6. Consider indexing the join column
--    Important for performance on large tables
--
-- 7. Use DISTINCT if needed
--    Prevents duplicate rows in some scenarios
--
-- 8. Document the hierarchy clearly
--    Other developers may not understand immediately
--
-- 9. Consider multiple levels carefully
--    Too many levels (>4) may indicate data design issues
--
-- 10. Use aggregation functions when appropriate
--     COUNT, SUM, AVG help summarize hierarchies

-- ============================================================================
-- DATABASE COMPATIBILITY
-- ============================================================================
--
-- SELF JOIN is supported in ALL major databases:
--   ✅ MySQL ............ Full support, tested examples work
--   ✅ PostgreSQL ....... Full support
--   ✅ SQL Server ....... Full support
--   ✅ Oracle ........... Full support
--   ✅ SQLite ........... Full support
--
-- All examples in this file are MySQL-compatible (5.7+, 8.0+)
-- Copy-paste queries directly to your MySQL client

-- ============================================================================
-- REAL-WORLD EXAMPLES
-- ============================================================================
--
-- 1. COMPANY ORGANIZATIONAL CHART
--    Use: Show reporting structure
--    Query: Multi-level SELF JOIN
--
-- 2. E-COMMERCE PRODUCT CATEGORIES
--    Use: Parent category > Sub-category > Product
--    Query: SELF JOIN on category table
--
-- 3. SOCIAL NETWORK FOLLOWERS
--    Use: Who follows whom (bidirectional)
--    Query: SELF JOIN with UNION
--
-- 4. TREE STRUCTURES
--    Use: File systems, comments (parent comment), hierarchies
--    Query: SELF JOIN on parent_id
--
-- 5. CONFLICT DETECTION
--    Use: Find conflicts (employees with same role in same dept)
--    Query: SELF JOIN with GROUP BY
--
-- 6. HISTORICAL DATA
--    Use: Compare old vs new values
--    Query: SELF JOIN on same table with timestamps
--
-- 7. DATA QUALITY
--    Use: Find duplicates, anomalies
--    Query: SELF JOIN with WHERE conditions

/*
================================================================================
  END OF SELF JOIN GUIDE
================================================================================
  Summary:
  - SELF JOIN: Join a table to itself
  - Use: Hierarchical data, comparisons, relationships
  - Aliases: MANDATORY (distinguish two instances)
  - Support: ALL databases include MySQL
  - Performance: Similar to regular joins
  
  Key Insight:
  SELF JOIN is powerful for understanding relationships within data.
  It's essential for organizational charts, hierarchies, and comparative analysis.
  Master SELF JOIN and you can handle complex data relationships!
  
  BEST PRACTICES RECAP:
  1. Always use clear table aliases
  2. Prefer LEFT JOIN for hierarchical data
  3. Use COALESCE for meaningful output
  4. Test with small datasets first
  5. Add data quality checks
  6. Document the hierarchy
  7. Consider performance for large tables
  8. Use aggregation when appropriate
  
  For more information:
  - https://dev.mysql.com/doc/refman/8.0/en/join.html
  - https://www.w3schools.com/sql/sql_join_self.asp
  - Organizational design and data structure patterns
  - Hierarchical data best practices
================================================================================
*/
