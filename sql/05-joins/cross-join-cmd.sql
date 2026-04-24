/*
================================================================================
  SQL CROSS JOIN COMPREHENSIVE GUIDE
================================================================================
  File: cross-join-cmd.sql
  Description: Complete tutorial on CROSS JOIN (Cartesian Product) with practical 
               examples using employee, department, project, and related tables.
  
  AUTHOR: Durgesh Tambe
  CREATED: April 24, 2026
  UPDATED: April 24, 2026
  VERSION: 1.0
  
  WHAT IS A CROSS JOIN?
  ─────────────────────────────────────────────────────────────────────────────
  A CROSS JOIN returns the Cartesian product of two tables.
  It combines every row from TABLE1 with EVERY row from TABLE2.
  
  Key Characteristics:
    ✓ Returns ALL possible combinations of rows
    ✓ No ON condition needed (or ON condition is TRUE)
    ✓ Result rows = (rows in table1) × (rows in table2)
    ✓ No foreign key relationship required
    ✓ Can produce VERY large result sets
    ✓ Useful for generating combinations, permutations, sequences
    ✓ Works in ALL databases (MySQL, PostgreSQL, SQL Server, Oracle, SQLite)
  
  Syntax:
    SELECT columns
    FROM table1
    CROSS JOIN table2;
    
    OR (equivalent):
    SELECT columns
    FROM table1, table2;
  
  Row Count Calculation:
    Result rows = (Table1 rows) × (Table2 rows)
    Example:
      If table1 has 4 rows and table2 has 3 rows
      CROSS JOIN result has 4 × 3 = 12 rows
  
  When to use CROSS JOIN:
    ✓ Generate all possible combinations
    ✓ Create sequences or numbers
    ✓ Build permission matrices
    ✓ Generate time series data
    ✓ Create missing data scenarios
    ✓ Testing and sample data generation
    ✓ Calendar generation
    ✓ Matrix/grid creation
    ✓ Reporting templates
    ✓ Scheduling systems
  
  Database Support:
    ✅ MySQL ............ CROSS JOIN fully supported
    ✅ PostgreSQL ....... CROSS JOIN fully supported
    ✅ SQL Server ....... CROSS JOIN fully supported
    ✅ Oracle ........... CROSS JOIN fully supported
    ✅ SQLite ........... CROSS JOIN fully supported
  
  Normal Use Cases:
    1. Generate all department-employee combinations
    2. Create time-based schedules
    3. Generate all possible product-color combinations
    4. Build permission matrices
    5. Create missing data report templates
    6. Generate number sequences
    7. Testing and load generation
    8. Building report structures
  
  ⚠️  WARNING: CROSS JOIN can produce VERY LARGE result sets!
    - Be careful with large tables
    - Test with LIMIT before running on production
    - Monitor disk space and memory
    - Consider performance implications
  
  TABLE OF CONTENTS:
    1. Basic CROSS JOIN - All Combinations
    2. CROSS JOIN with WHERE - Filter combinations
    3. CROSS JOIN with Three Tables
    4. CROSS JOIN for Generating Sequences
    5. CROSS JOIN for Date Series Generation
    6. CROSS JOIN for Permission Matrix
    7. CROSS JOIN for Report Templates
    8. CROSS JOIN for Testing/Scenarios
    9. CROSS JOIN with Aggregation
    10. CROSS JOIN for Calendar Generation
  
  IMPORTANT DISTINCTIONS:
    INNER/LEFT/RIGHT JOIN:  Need ON condition to match rows
    CROSS JOIN:             NO ON condition (creates all combinations)
    Result:                 Cartesian product
  
  PREREQUISITES:
    - employee table: employeeId, first_name, last_name, departmentId
    - department table: departmentId, name
    - project table: projectId, project_name, status
    - (Can use other tables or even numbers table)
    
  EXECUTION:
    - Execute each example individually
    - Start with LIMIT to see structure
    - Monitor result size before running full query
    - Use WHERE clause to reduce combinations
================================================================================
*/

-- ============================================================================
-- 1. BASIC CROSS JOIN - All Combinations
-- ============================================================================
-- Generate all possible employee-department combinations
-- (every employee paired with every department)

SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    d.departmentId,
    d.name as department_name
FROM employee e
CROSS JOIN department d
ORDER BY e.employeeId, d.departmentId
LIMIT 20;  -- IMPORTANT: Always LIMIT first to see result structure!

-- Explanation:
-- CROSS JOIN with 50 employees × 5 departments = 250 rows
-- Result shows every employee with EVERY department
-- This is a Cartesian product

-- ============================================================================
-- 1B. Basic CROSS JOIN - Show row count
-- ============================================================================
-- Calculate expected result size before running full query

SELECT 
    COUNT(*) as total_combinations,
    (SELECT COUNT(*) FROM employee) as employee_count,
    (SELECT COUNT(*) FROM department) as department_count,
    (SELECT COUNT(*) FROM employee) * (SELECT COUNT(*) FROM department) as expected_rows
FROM (
    SELECT e.employeeId, d.departmentId
    FROM employee e
    CROSS JOIN department d
) as combinations
LIMIT 1;

-- This shows:
-- Total combinations created
-- Breaks down employee count × department count

-- ============================================================================
-- 2. CROSS JOIN with WHERE - Filter combinations
-- ============================================================================
-- Generate combinations but FILTER to keep only specific ones

SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    e.salary,
    d.departmentId,
    d.name as department_name
FROM employee e
CROSS JOIN department d
WHERE e.departmentId = d.departmentId  -- Filter to actual assignments only
ORDER BY e.employeeId, d.departmentId;

-- This is equivalent to INNER JOIN
-- But demonstrates that CROSS JOIN can be filtered with WHERE

-- ============================================================================
-- 2B. CROSS JOIN with WHERE - Create scenarios
-- ============================================================================
-- Generate hypothetical scenarios (what-if analysis)

SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    e.salary as current_salary,
    d.departmentId,
    d.name as potential_department,
    'SCENARIO: Employee transfer to different department' as note
FROM employee e
CROSS JOIN department d
WHERE e.departmentId != d.departmentId  -- Only show DIFFERENT departments
ORDER BY e.employeeId, d.departmentId
LIMIT 30;

-- Shows potential transfers if employees moved to different departments

-- ============================================================================
-- 3. CROSS JOIN with Three Tables
-- ============================================================================
-- Create all combinations of employees, departments, and projects

SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    d.departmentId,
    d.name as department_name,
    p.projectId,
    p.project_name
FROM employee e
CROSS JOIN department d
CROSS JOIN project p
LIMIT 30;

-- Result count: employees × departments × projects
-- Example: 50 × 5 × 12 = 3,000 rows!
-- This demonstrates why CROSS JOIN can get large quickly

-- ============================================================================
-- 3B. CROSS JOIN - Three tables with filtering
-- ============================================================================
-- Create combinations but only for employees in matching departments

SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    d.name as department_name,
    p.projectId,
    p.project_name,
    p.budget,
    'Available for assignment' as status
FROM employee e
CROSS JOIN department d
CROSS JOIN project p
WHERE e.departmentId = d.departmentId
ORDER BY e.employeeId, p.projectId
LIMIT 50;

-- ============================================================================
-- 4. CROSS JOIN for Generating Sequences
-- ============================================================================
-- Create a number sequence using CROSS JOIN

SELECT 
    d1.departmentId as tens_digit,
    d2.departmentId as ones_digit,
    (d1.departmentId * 10 + d2.departmentId) as number
FROM department d1
CROSS JOIN department d2
ORDER BY number
LIMIT 30;

-- This creates numbers 11-55 by crossing two small tables
-- Useful when you don't have a numbers table

-- ============================================================================
-- 4B. CROSS JOIN - Generate larger number sequence
-- ============================================================================
-- Generate numbers 1-100 using multiple tables

SELECT 
    (d1.departmentId * 20 + d2.departmentId) as sequence_number
FROM department d1, department d2
WHERE (d1.departmentId * 20 + d2.departmentId) <= 100
ORDER BY sequence_number;

-- Alternative: Can use CROSS JOIN to create any sequence without a numbers table

-- ============================================================================
-- 5. CROSS JOIN for Date Series Generation
-- ============================================================================
-- Generate daily schedule for all employees

SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    DATE_ADD('2026-01-01', INTERVAL (d1.departmentId * 10 + d2.departmentId - 1) DAY) as schedule_date,
    'Working' as status
FROM employee e
CROSS JOIN department d1
CROSS JOIN department d2
WHERE (d1.departmentId * 10 + d2.departmentId - 1) < 365
ORDER BY e.employeeId, schedule_date
LIMIT 30;

-- Creates a daily schedule for each employee throughout the year

-- ============================================================================
-- 5B. CROSS JOIN - Weekly schedule matrix
-- ============================================================================
-- Create weekly work schedule for all employees

SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    CASE d.departmentId
        WHEN 1 THEN 'Monday'
        WHEN 2 THEN 'Tuesday'
        WHEN 3 THEN 'Wednesday'
        WHEN 4 THEN 'Thursday'
        WHEN 5 THEN 'Friday'
    END as day_of_week,
    CASE p.projectId
        WHEN 1 THEN 'Project A'
        WHEN 2 THEN 'Project B'
        WHEN 3 THEN 'Project C'
        WHEN 4 THEN 'Project D'
        WHEN 5 THEN 'Project E'
        WHEN 6 THEN 'Project F'
        ELSE 'Available'
    END as assignment,
    'To be scheduled' as status
FROM employee e
CROSS JOIN department d
CROSS JOIN project p
WHERE d.departmentId <= 5  -- 5 days of week
ORDER BY e.employeeId, d.departmentId, p.projectId
LIMIT 50;

-- ============================================================================
-- 6. CROSS JOIN for Permission Matrix
-- ============================================================================
-- Create all possible user-permission combinations for access control

SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    d.name as department,
    CASE p.projectId
        WHEN 1 THEN 'View Reports'
        WHEN 2 THEN 'Edit Projects'
        WHEN 3 THEN 'Manage Users'
        WHEN 4 THEN 'Delete Records'
        WHEN 5 THEN 'Export Data'
        WHEN 6 THEN 'Configure System'
        WHEN 7 THEN 'Approve Budget'
        WHEN 8 THEN 'View Analytics'
        ELSE 'Unknown'
    END as permission_name,
    CASE 
        WHEN e.departmentId = 1 THEN 'GRANT'  -- HR = all permissions
        WHEN e.departmentId = 2 AND p.projectId IN (1,2,5) THEN 'GRANT'  -- Engineering
        WHEN e.departmentId = 3 AND p.projectId IN (1,4,7) THEN 'GRANT'  -- Finance
        ELSE 'DENY'
    END as access_level
FROM employee e
CROSS JOIN department d
CROSS JOIN project p
ORDER BY e.employeeId, d.departmentId, p.projectId
LIMIT 40;

-- ============================================================================
-- 6B. CROSS JOIN - Role-based access control (RBAC)
-- ============================================================================
-- Create permission matrix for different roles

SELECT 
    'Admin' as role_name,
    p.projectId,
    CASE p.projectId
        WHEN 1 THEN 'View Reports'
        WHEN 2 THEN 'Edit Projects'
        WHEN 3 THEN 'Manage Users'
        WHEN 4 THEN 'Delete Records'
        WHEN 5 THEN 'Export Data'
        ELSE 'Other'
    END as permission,
    'ALLOWED' as permission_level

UNION ALL

SELECT 
    'Manager' as role_name,
    p.projectId,
    CASE p.projectId
        WHEN 1 THEN 'View Reports'
        WHEN 2 THEN 'Edit Projects'
        WHEN 3 THEN 'Manage Users'
        ELSE 'DENIED'
    END as permission,
    CASE 
        WHEN p.projectId IN (1,2) THEN 'ALLOWED'
        ELSE 'DENIED'
    END as permission_level

UNION ALL

SELECT 
    'Employee' as role_name,
    p.projectId,
    CASE p.projectId
        WHEN 1 THEN 'View Reports'
        ELSE 'DENIED'
    END as permission,
    CASE WHEN p.projectId = 1 THEN 'ALLOWED' ELSE 'DENIED' END as permission_level
FROM project p;

-- ============================================================================
-- 7. CROSS JOIN for Report Templates
-- ============================================================================
-- Generate report structure with all department combinations

SELECT 
    d1.departmentId as from_department_id,
    d1.name as from_department,
    d2.departmentId as to_department_id,
    d2.name as to_department,
    CONCAT('Cross-Department Report: ', d1.name, ' to ', d2.name) as report_name,
    'PENDING' as report_status
FROM department d1
CROSS JOIN department d2
WHERE d1.departmentId != d2.departmentId
ORDER BY d1.departmentId, d2.departmentId;

-- Creates inter-department report templates for all combinations

-- ============================================================================
-- 7B. CROSS JOIN - Quarterly reporting matrix
-- ============================================================================
-- Create reporting structure for all quarters and departments

SELECT 
    d.departmentId,
    d.name as department_name,
    CASE q.departmentId
        WHEN 1 THEN 'Q1 (Jan-Mar)'
        WHEN 2 THEN 'Q2 (Apr-Jun)'
        WHEN 3 THEN 'Q3 (Jul-Sep)'
        WHEN 4 THEN 'Q4 (Oct-Dec)'
    END as quarter,
    CONCAT('Quarterly Report - ', d.name, ' - Q', q.departmentId) as report_name,
    'Template Ready' as status
FROM department d
CROSS JOIN (
    SELECT 1 as departmentId
    UNION ALL SELECT 2
    UNION ALL SELECT 3
    UNION ALL SELECT 4
) q
ORDER BY d.departmentId, q.departmentId;

-- ============================================================================
-- 8. CROSS JOIN for Testing and Scenarios
-- ============================================================================
-- Generate all possible salary adjustment scenarios

SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    e.salary as current_salary,
    COALESCE(d1.departmentId, 1) as scenario_number,
    CASE d1.departmentId
        WHEN 1 THEN 'Increase 5%'
        WHEN 2 THEN 'Increase 10%'
        WHEN 3 THEN 'Increase 15%'
        WHEN 4 THEN 'Increase 20%'
        WHEN 5 THEN 'No change'
    END as scenario_description,
    ROUND(e.salary * CASE d1.departmentId
        WHEN 1 THEN 1.05
        WHEN 2 THEN 1.10
        WHEN 3 THEN 1.15
        WHEN 4 THEN 1.20
        WHEN 5 THEN 1.00
    END, 2) as new_salary
FROM employee e
CROSS JOIN department d1
ORDER BY e.employeeId, d1.departmentId;

-- Creates all salary scenarios for each employee

-- ============================================================================
-- 8B. CROSS JOIN - Bonus scenarios matrix
-- ============================================================================
-- Test different bonus percentages for all employees

SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    e.salary,
    d.departmentId as bonus_percentage,
    ROUND(e.salary * (d.departmentId / 100.0), 2) as bonus_amount,
    ROUND(e.salary + (e.salary * (d.departmentId / 100.0)), 2) as total_with_bonus,
    CONCAT(d.departmentId, '% Bonus Scenario') as scenario_name
FROM employee e
CROSS JOIN department d
ORDER BY e.employeeId, d.departmentId;

-- ============================================================================
-- 9. CROSS JOIN with Aggregation
-- ============================================================================
-- Count total possible combinations for planning

SELECT 
    (SELECT COUNT(*) FROM employee) as employee_count,
    (SELECT COUNT(*) FROM department) as department_count,
    (SELECT COUNT(*) FROM project) as project_count,
    (SELECT COUNT(*) FROM employee) * (SELECT COUNT(*) FROM department) as emp_dept_combo,
    (SELECT COUNT(*) FROM employee) * (SELECT COUNT(*) FROM project) as emp_proj_combo,
    (SELECT COUNT(*) FROM department) * (SELECT COUNT(*) FROM project) as dept_proj_combo,
    (SELECT COUNT(*) FROM employee) * (SELECT COUNT(*) FROM department) * (SELECT COUNT(*) FROM project) as all_combo;

-- ============================================================================
-- 9B. CROSS JOIN - Summary matrix
-- ============================================================================
-- Create summary of all potential assignments

SELECT 
    'Employee-Department' as combination_type,
    COUNT(*) as total_combinations
FROM (
    SELECT e.employeeId, d.departmentId
    FROM employee e
    CROSS JOIN department d
) as edcombos

UNION ALL

SELECT 
    'Employee-Project' as combination_type,
    COUNT(*) as total_combinations
FROM (
    SELECT e.employeeId, p.projectId
    FROM employee e
    CROSS JOIN project p
) as epcombos

UNION ALL

SELECT 
    'Department-Project' as combination_type,
    COUNT(*) as total_combinations
FROM (
    SELECT d.departmentId, p.projectId
    FROM department d
    CROSS JOIN project p
) as dpcombos;

-- ============================================================================
-- 10. CROSS JOIN for Calendar Generation
-- ============================================================================
-- Create monthly calendar for project planning

SELECT 
    YEAR(DATE_ADD('2026-01-01', INTERVAL (d1.departmentId - 1) MONTH)) as year,
    MONTH(DATE_ADD('2026-01-01', INTERVAL (d1.departmentId - 1) MONTH)) as month,
    CASE WHEN DAY(DATE_ADD('2026-01-01', INTERVAL (d1.departmentId * 30 + d2.departmentId - 1) DAY)) IS NOT NULL THEN 'Available' END as status
FROM department d1
CROSS JOIN project p
WHERE d1.departmentId <= 12
LIMIT 120;

-- ============================================================================
-- 10B. CROSS JOIN - Project scheduling matrix
-- ============================================================================
-- Create scheduling matrix for all projects and employees

SELECT 
    DATE_ADD('2026-01-01', INTERVAL ((d1.departmentId - 1) * 7 + d2.departmentId - 1) DAY) as week_start,
    DATE_ADD(DATE_ADD('2026-01-01', INTERVAL ((d1.departmentId - 1) * 7 + d2.departmentId - 1) DAY), INTERVAL 6 DAY) as week_end,
    p.projectId,
    p.project_name,
    'Open' as week_status
FROM department d1
CROSS JOIN department d2
CROSS JOIN project p
WHERE d1.departmentId <= 4 AND d2.departmentId <= 7  -- 4 weeks
ORDER BY week_start, p.projectId
LIMIT 50;

-- ============================================================================
-- PRACTICE QUESTIONS
-- ============================================================================
-- Answer these using CROSS JOIN:
--
-- Q1: Generate all employee-department combinations (without LIMIT)
-- Q2: How many possible combinations exist for 3 tables?
-- Q3: Create a permission matrix for 3 roles
-- Q4: Generate salary scenarios for all employees (5%, 10%, 15% increases)
-- Q5: Create weekly schedule matrix for all employees
-- Q6: Generate all possible project assignments
-- Q7: Create a date series for 30 days
-- Q8: Build daily task assignment matrix
-- Q9: Count total possible combinations of employees, departments, and projects
-- Q10: Create quarterly reporting structure matrix

-- ============================================================================
-- KEY POINTS ABOUT CROSS JOIN
-- ============================================================================
-- ✓ Creates Cartesian product (all combinations)
-- ✓ No ON condition required (or ON TRUE)
-- ✓ Result size = table1 rows × table2 rows
-- ✓ Can produce VERY large result sets
-- ✓ Works in ALL databases
-- ✓ Use LIMIT before running on large tables
-- ✓ Perfect for generating combinations, sequences, matrices
-- ✓ Filterable with WHERE clause
-- ✓ Can chain multiple CROSS JOINs
-- ✓ Often used for testing, templates, and scenarios

-- ============================================================================
-- COMMON MISTAKES TO AVOID
-- ============================================================================
-- MISTAKE 1: Not using LIMIT with large tables
-- WRONG:  SELECT * FROM employee CROSS JOIN product
--         (if 1000s of rows each, creates millions!)
-- RIGHT:  SELECT * FROM employee CROSS JOIN product LIMIT 100

-- MISTAKE 2: Forgetting this creates CARTESIAN product
-- WRONG:  Expecting filtered results without WHERE clause
-- RIGHT:  Add WHERE clause to filter combinations

-- MISTAKE 3: Using CROSS JOIN when INNER/LEFT would work better
-- WRONG:  CROSS JOIN then filter in WHERE (inefficient)
-- RIGHT:  Use proper JOIN with ON condition

-- MISTAKE 4: Not understanding result size implications
-- WRONG:  Running on large production tables without calculation
-- RIGHT:  Calculate expected rows first: table1_count × table2_count

-- MISTAKE 5: Confusing with INNER JOIN
-- WRONG:  CROSS JOIN returns all combinations (not filtered pairs)
-- RIGHT:  INNER JOIN only returns matching rows

-- MISTAKE 6: Not testing with LIMIT
-- WRONG:  Running full query without preview
-- RIGHT:  Always use LIMIT 10-100 first

-- ============================================================================
-- COMPARISON: CROSS JOIN vs Other JOINs
-- ============================================================================
--
-- INNER JOIN:     Only matching rows (requires ON condition)
-- LEFT JOIN:      All from left + matching from right
-- CROSS JOIN:     ALL combinations (no ON needed)
--
-- Result sizes for table1 (50 rows) and table2 (5 rows):
--   INNER:       0-50 rows (depends on matches)
--   LEFT:        50 rows (guaranteed)
--   CROSS:       250 rows (always 50 × 5)

-- ============================================================================
-- PERFORMANCE CONSIDERATIONS
-- ============================================================================
--
-- CROSS JOIN Performance Impact:
--   ⚠️  Result size: (Table1 rows) × (Table2 rows)
--   ⚠️  Memory usage: Can be significant with large tables
--   ⚠️  Disk I/O: Reading entire tables multiple times
--
-- Optimization Tips:
--   1. Always use LIMIT when testing
--   2. Filter with WHERE clause after CROSS JOIN
--   3. Consider using smaller tables
--   4. Pre-aggregate data before CROSS JOIN
--   5. Use indexes on filter columns
--   6. Monitor query execution time
--   7. Consider splitting large operations

-- ============================================================================
-- WHEN TO USE CROSS JOIN
-- ============================================================================
--
-- Use CROSS JOIN when:
--   1. Generating combinations (all possibilities)
--   2. Creating sequences (without numbers table)
--   3. Building matrices (scheduling, permissions)
--   4. Testing scenarios (what-if analysis)
--   5. Generating templates (report structures)
--   6. Creating calendars (date series)
--   7. RBAC (role-based access control)
--   8. Sample data generation
--   9. Cartesian products needed
--
-- Do NOT use CROSS JOIN when:
--   1. You only need matching rows (use INNER JOIN)
--   2. You need records from one table with optional matches (use LEFT JOIN)
--   3. Dealing with millions of rows (memory issues)
--   4. A simpler JOIN type would work

-- ============================================================================
-- BEST PRACTICES FOR CROSS JOIN
-- ============================================================================
--
-- 1. Always calculate expected result size first
--    BEFORE running query
--
-- 2. Use LIMIT during development
--    LIMIT 100 to preview structure
--
-- 3. Add WHERE clause to filter combinations
--    Reduces result size dramatically
--
-- 4. Use with small to medium datasets
--    Avoid on large tables without careful planning
--
-- 5. Consider memory and disk space
--    Millions of rows can impact system performance
--
-- 6. Use DISTINCT if needed
--    Removes duplicate combinations
--
-- 7. Combine with aggregation functions
--    COUNT, SUM, AVG reduce result volume
--
-- 8. Test incrementally
--    Start with LIMIT, expand gradually
--
-- 9. Document why CROSS JOIN is needed
--    Not intuitive for other developers
--
-- 10. Monitor query performance
--     Slow queries = too many combinations

-- ============================================================================
-- DATABASE COMPATIBILITY
-- ============================================================================
--
-- CROSS JOIN is supported in ALL major databases:
--   ✅ MySQL ............ Full support, tested examples work
--   ✅ PostgreSQL ....... Full support
--   ✅ SQL Server ....... Full support
--   ✅ Oracle ........... Full support
--   ✅ SQLite ........... Full support
--
-- Syntax:
--   SELECT * FROM table1 CROSS JOIN table2;
--   SELECT * FROM table1, table2;  (equivalent in most databases)
--
-- All examples in this file are MySQL-compatible (5.7+, 8.0+)
-- Copy-paste queries directly to your MySQL client

-- ============================================================================
-- REAL-WORLD EXAMPLES
-- ============================================================================
--
-- 1. E-COMMERCE: All color-size combinations for clothing
--    CROSS JOIN colors × sizes → all SKUs
--
-- 2. SCHEDULING: Create daily task matrix
--    CROSS JOIN employees × dates × tasks
--
-- 3. REPORTING: Permission matrix for access control
--    CROSS JOIN users × permissions → access grid
--
-- 4. INVENTORY: Generate all warehouse-location combinations
--    CROSS JOIN warehouses × locations
--
-- 5. TESTING: All parameter combinations
--    CROSS JOIN test_values_A × test_values_B
--
-- 6. PLANNING: All resource allocation scenarios
--    CROSS JOIN resources × projects × time_periods
--
-- 7. HEALTHCARE: All doctor-patient-appointment combinations
--    CROSS JOIN doctors × patients × time_slots

/*
================================================================================
  END OF CROSS JOIN GUIDE
================================================================================
  Summary:
  - CROSS JOIN: Creates Cartesian product (all combinations)
  - No ON condition: Returns every row × every row
  - Result rows: table1_rows × table2_rows
  - Warning: Can produce VERY large result sets
  - Use: Combinations, sequences, matrices, scenarios
  - Support: All databases including MySQL
  
  Key Insight:
  CROSS JOIN is powerful but must be used carefully.
  Always calculate result size first and use LIMIT during development.
  Master CROSS JOIN for generating combinations and testing scenarios!
  
  BEST PRACTICES RECAP:
  1. Calculate expected result size first
  2. Always use LIMIT during development
  3. Filter with WHERE to reduce combinations
  4. Use with small to medium sized tables
  5. Monitor memory and disk impact
  6. Document why CROSS JOIN is needed
  7. Test incrementally
  8. Consider performance implications
  9. Use DISTINCT if duplicates problematic
  10. Combine with aggregation when appropriate
  
  For more information:
  - https://dev.mysql.com/doc/refman/8.0/en/join.html
  - https://www.w3schools.com/sql/sql_join_cross.asp
  - Cartesian product and combinatorics
  - Performance optimization for large datasets
================================================================================
*/
