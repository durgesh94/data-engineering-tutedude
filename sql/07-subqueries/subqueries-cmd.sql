/*
================================================================================
  SQL SUBQUERIES COMPREHENSIVE GUIDE
================================================================================
  File: subqueries-cmd.sql
  Description: Complete tutorial on SQL Subqueries with practical examples
               using employee, department, project tables.
  
  AUTHOR: Durgesh Tambe
  CREATED: April 24, 2026
  UPDATED: April 24, 2026
  VERSION: 1.0
  
  WHAT ARE SUBQUERIES?
  ─────────────────────────────────────────────────────────────────────────────
  A SUBQUERY (Inner Query / Nested Query) is a SELECT statement inside 
  another SELECT, INSERT, UPDATE, or DELETE statement.
  
  It's like asking a question within a question:
    "Find employees whose salary is higher than the average salary"
    - Inner question: "What is the average salary?"
    - Outer question: "Which employees earn more than that?"
  
  Key Characteristics:
    ✓ Query within another query
    ✓ Returns a result set used by outer query
    ✓ Can return single value, single row, multiple rows, or multiple columns
    ✓ Can be nested multiple levels deep
    ✓ Executes before, after, or with outer query (depends on type)
    ✓ Can be used in SELECT, FROM, WHERE, HAVING, INSERT, UPDATE, DELETE
    ✓ More readable than complex JOINs
    ✓ Can add performance overhead
  
  Types of Subqueries:
    1. SCALAR SUBQUERY         - Returns single value (one row, one column)
    2. ROW SUBQUERY            - Returns single row (one row, multiple columns)
    3. TABLE SUBQUERY          - Returns multiple rows & columns
    4. SCALAR SUBQUERY LIST    - Returns multiple values (one column)
    5. CORRELATED SUBQUERY     - References outer query columns
    6. DERIVED TABLE (Inline View) - Subquery in FROM clause
  
  Comparison with JOINs:
    SUBQUERIES: Vertical thinking (step-by-step approach)
    JOINs:      Horizontal thinking (relationship approach)
  
  Syntax:
    SELECT column1 FROM table1
    WHERE column2 = (SELECT MAX(column2) FROM table2)
                     └─── SUBQUERY ───┘
  
  Important Rules:
    - Subquery in parentheses: (SELECT ...)
    - Subquery executes from innermost to outermost
    - ORDER BY not typically used in subqueries (except with LIMIT)
    - Must follow syntax rules: same column count rules, data types, etc.
  
  When to use SUBQUERIES:
    ✓ Breaking down complex queries into steps
    ✓ Using aggregate results in WHERE clause
    ✓ Checking existence of records (IN, EXISTS)
    ✓ Finding records NOT in a set (NOT IN, NOT EXISTS)
    ✓ Comparing to aggregate values (>, <, =, etc.)
    ✓ Creating temporary result sets
    ✓ More readable than complex multi-table JOINs
    ✓ Testing specific conditions
  
  Advantages:
    ✅ Highly readable and understandable
    ✅ Easy to debug (test each subquery independently)
    ✅ Natural step-by-step logic
    ✅ Flexible for complex conditions
    ✅ Can reference outer query (correlated)
    ✅ Doesn't require table relationships
  
  Disadvantages:
    ⚠️ Can be slower than JOINs
    ⚠️ Executes once for each outer row (correlated)
    ⚠️ Less efficient for large datasets
    ⚠️ Can be nested too deeply (hard to read)
    ⚠️ May create temporary tables (memory usage)
  
  Database Support:
    ✅ MySQL ............ Fully supported (5.7+)
    ✅ PostgreSQL ....... Fully supported
    ✅ SQL Server ....... Fully supported
    ✅ Oracle ........... Fully supported
    ✅ SQLite ........... Fully supported
  
  TABLE OF CONTENTS:
    1. SCALAR SUBQUERIES - Single value return
    2. ROW SUBQUERIES - Single row return
    3. TABLE SUBQUERIES - Multiple rows return
    4. SUBQUERY IN WHERE - Filter by subquery result
    5. SUBQUERY IN SELECT - Use result as column
    6. SUBQUERY IN FROM - Derived tables / inline views
    7. SUBQUERY IN HAVING - Filter aggregates by subquery
    8. IN & NOT IN - Check membership
    9. EXISTS & NOT EXISTS - Check existence
    10. CORRELATED SUBQUERIES - Reference outer query
    11. NESTED SUBQUERIES - Multiple levels
    12. SUBQUERIES vs JOINs - Performance comparison
  
  MYSQL SPECIFIC NOTES:
    - Fully supported in MySQL 5.7+
    - Correlated subqueries can be slower (consider LEFT JOIN)
    - LIMIT requires ORDER BY for consistent results
    - Performance depends on WHERE clause (sargability)
  
  PREREQUISITES:
    - Tables already created in sql/02-manipulation/create-cmd.sql
    - Tables: department, employee, project, project_assignment
    - Sample data pre-populated in those tables
    
  TABLE REFERENCES:
    ✓ department: departmentId, name
    ✓ employee: employeeId, first_name, last_name, email, salary, departmentId
    ✓ project: projectId, project_name, description, start_date, end_date, budget, departmentId, status
    ✓ project_assignment: assignment_id, employeeId, projectId, role, allocation_percentage, assignment_date
    
  EXECUTION:
    - Ensure tables from 02-manipulation/create-cmd.sql are created first
    - Run INSERT scripts from that folder to populate sample data
    - Execute each example individually
    - Understand the step-by-step logic
    - Notice performance implications
    - Compare with JOIN alternatives
  
  HOW TO PREPARE:
    1. Run: sql/02-manipulation/create-cmd.sql (CREATE TABLE statements)
    2. Run: sql/02-manipulation/insert-cmd.sql (INSERT sample data)
    3. Then run examples below using existing tables
================================================================================
*/

-- ============================================================================
-- REFERENCING EXISTING TABLES FROM sql/02-manipulation/create-cmd.sql
-- ============================================================================
-- 
-- These examples use existing tables:
--   - department (with departmentId, name)
--   - employee (with employeeId, first_name, last_name, email, salary, departmentId)
--   - project (with projectId, project_name, budget, departmentId, status)
--   - project_assignment (for many-to-many employee<->project relationships)
--
-- Ensure you have run create-cmd.sql and insert-cmd.sql from 02-manipulation folder first!
--
-- Verify existing data:
SELECT 'department' as table_name, COUNT(*) as total_records FROM department
UNION ALL
SELECT 'employee', COUNT(*) FROM employee
UNION ALL
SELECT 'project', COUNT(*) FROM project
UNION ALL
SELECT 'project_assignment', COUNT(*) FROM project_assignment;

-- ============================================================================
-- 1. SCALAR SUBQUERIES - Single Value Return
-- ============================================================================
-- Returns exactly one row and one column
-- Most common type of subquery

-- Example 1: Find employees earning more than average
SELECT 
    employeeId,
    CONCAT(first_name, ' ', last_name) as employee_name,
    salary,
    (SELECT ROUND(AVG(salary), 2) FROM employee) as avg_salary
FROM employee
WHERE salary > (SELECT AVG(salary) FROM employee)
ORDER BY salary DESC;

-- Explanation:
-- Inner query: SELECT AVG(salary) FROM employee → Returns single value
-- Outer query: Compares each employee's salary to this average
-- Result: Shows only employees above average with comparison

-- ============================================================================
-- 1B. SCALAR SUBQUERY - Find Maximum Salary in Department
-- ============================================================================

SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    e.salary,
    e.departmentId,
    (SELECT MAX(salary) FROM employee e2 WHERE e2.departmentId = e.departmentId) as max_dept_salary
FROM employee e
ORDER BY e.departmentId, e.salary DESC;

-- Explanation:
-- Inner query: Gets MAX salary for THAT department (correlated)
-- Shows: Each employee with their department's maximum salary
-- Useful for: Comparing individual salaries to department max

-- ============================================================================
-- 2. ROW SUBQUERIES - Single Row, Multiple Columns
-- ============================================================================
-- Returns one row with multiple columns
-- Used with comparison operators on multiple values

-- Example 2: Find department info matching specific criteria
SELECT 
    departmentId,
    name
FROM department
WHERE departmentId = (SELECT departmentId FROM department WHERE name = 'Engineering')
ORDER BY departmentId;

-- Explanation:
-- Inner query: Returns (20, 'San Francisco')
-- Outer query: Finds departments matching BOTH values
-- Note: Less common pattern, usually use WHERE column = value approach

-- ============================================================================
-- 3. TABLE SUBQUERIES - Multiple Rows & Columns
-- ============================================================================
-- Returns multiple rows and multiple columns
-- Used when you need multiple values from subquery result

-- Example 3: Find all employees in highest-paying departments
SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    e.salary,
    e.departmentId
FROM employee e
WHERE e.departmentId IN (
    SELECT departmentId 
    FROM (
        SELECT departmentId, AVG(salary) as avg_salary 
        FROM employee 
        GROUP BY departmentId
        ORDER BY avg_salary DESC
        LIMIT 2
    ) dept_salaries
)
ORDER BY e.salary DESC;

-- ============================================================================
-- 4. SUBQUERY IN WHERE - Filter by Subquery
-- ============================================================================
-- Most common usage: Filter rows based on subquery result

-- Example 4A: Find employees earning more than department average
SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    e.salary,
    e.departmentId
FROM employee e
WHERE e.salary > (
    SELECT AVG(salary) 
    FROM employee e2 
    WHERE e2.departmentId = e.departmentId
)
ORDER BY e.departmentId, e.salary DESC;

-- Explanation:
-- For each employee, calculate their department's average
-- Include only employees earning above that average
-- This is a CORRELATED SUBQUERY

-- ============================================================================
-- 4B. SUBQUERY IN WHERE - Find Top Earners
-- ============================================================================

SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    e.salary,
    e.departmentId
FROM employee e
WHERE e.salary >= (
    SELECT AVG(salary) FROM employee
)
ORDER BY e.salary DESC;

-- ============================================================================
-- 5. SUBQUERY IN SELECT - Use Result as Column
-- ============================================================================
-- Subquery in SELECT clause returns value for each row

-- Example 5A: Show employee with total department salary
SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    e.salary,
    e.departmentId,
    (SELECT COUNT(*) FROM employee e2 WHERE e2.departmentId = e.departmentId) as dept_employee_count,
    (SELECT SUM(salary) FROM employee e2 WHERE e2.departmentId = e.departmentId) as dept_total_salary,
    (SELECT AVG(salary) FROM employee e2 WHERE e2.departmentId = e.departmentId) as dept_avg_salary
FROM employee e
ORDER BY e.departmentId, e.salary DESC;

-- Explanation:
-- Each subquery executes for EVERY row
-- Shows: Employee salary + aggregates for their department
-- Performance: Can be slow with large datasets (executes once per row)

-- ============================================================================
-- 5B. SUBQUERY IN SELECT - Show Comparison Values
-- ============================================================================

SELECT 
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    e.salary,
    (SELECT AVG(salary) FROM employee) as company_avg,
    e.salary - (SELECT AVG(salary) FROM employee) as salary_difference,
    ROUND(((e.salary - (SELECT AVG(salary) FROM employee)) / (SELECT AVG(salary) FROM employee)) * 100, 2) as percent_difference
FROM employee e
ORDER BY e.salary DESC;

-- ============================================================================
-- 6. SUBQUERY IN FROM - Derived Tables / Inline Views
-- ============================================================================
-- Subquery in FROM clause creates virtual table for outer query
-- Must have alias and specific columns

-- Example 6A: Create salary analysis view
SELECT 
    dept_stats.departmentId,
    dept_stats.avg_salary,
    dept_stats.max_salary,
    dept_stats.min_salary,
    dept_stats.emp_count,
    ROUND(dept_stats.max_salary - dept_stats.min_salary, 2) as salary_range
FROM (
    SELECT 
        departmentId,
        COUNT(*) as emp_count,
        ROUND(AVG(salary), 2) as avg_salary,
        MAX(salary) as max_salary,
        MIN(salary) as min_salary
    FROM employee
    GROUP BY departmentId
) dept_stats
ORDER BY dept_stats.avg_salary DESC;

-- Explanation:
-- Subquery creates temporary result set (derived table)
-- Outer query treats it like a regular table
-- Useful for creating meaningful aggregations

-- ============================================================================
-- 6B. SUBQUERY IN FROM - Multiple Joins from Derived Table
-- ============================================================================

SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    e.salary,
    dept_analysis.name as department_name,
    dept_analysis.avg_salary as dept_avg,
    e.salary - dept_analysis.avg_salary as salary_vs_avg
FROM employee e
JOIN (
    SELECT 
        d.departmentId,
        d.name,
        ROUND(AVG(e2.salary), 2) as avg_salary
    FROM department d
    LEFT JOIN employee e2 ON d.departmentId = e2.departmentId
    GROUP BY d.departmentId, d.name
) dept_analysis ON e.departmentId = dept_analysis.departmentId
ORDER BY dept_analysis.name, e.salary DESC;

-- ============================================================================
-- 7. SUBQUERY IN HAVING - Filter Grouped Results
-- ============================================================================
-- HAVING typically filters based on GROUP BY aggregates
-- Subqueries can provide comparison values

-- Example 7: Find departments with average salary above company average
SELECT 
    d.departmentId,
    d.name,
    COUNT(e.employeeId) as total_employees,
    ROUND(AVG(e.salary), 2) as avg_salary
FROM department d
LEFT JOIN employee e ON d.departmentId = e.departmentId
GROUP BY d.departmentId, d.name
HAVING AVG(e.salary) > (SELECT AVG(salary) FROM employee)
ORDER BY avg_salary DESC;

-- Explanation:
-- GROUP BY creates groups (departments)
-- HAVING filters groups based on condition
-- Subquery provides the threshold value

-- ============================================================================
-- 8. IN & NOT IN - Check Membership
-- ============================================================================
-- Check if value exists in subquery result set

-- Example 8A: Find employees in departments with projects
SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    e.salary,
    e.departmentId
FROM employee e
WHERE e.departmentId IN (
    SELECT DISTINCT departmentId FROM project
)
ORDER BY e.departmentId, e.salary DESC;

-- Explanation:
-- Subquery: Get all departments that have projects
-- Outer query: Find employees in those departments
-- Result: Only employees in project-active departments

-- ============================================================================
-- 8B. NOT IN - Find Employees NOT in Any Project Department
-- ============================================================================

SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    e.salary,
    e.departmentId
FROM employee e
WHERE e.departmentId NOT IN (
    SELECT DISTINCT departmentId FROM project
)
ORDER BY e.salary DESC;

-- Explanation:
-- Opposite of IN
-- Result: Employees in departments without projects
-- Warning: NULL values in subquery result can cause issues

-- ============================================================================
-- 9. EXISTS & NOT EXISTS - Check Existence
-- ============================================================================
-- More efficient than IN for checking existence
-- Returns TRUE/FALSE for each row

-- Example 9A: Find departments that have employees
SELECT 
    d.departmentId,
    d.name
FROM department d
WHERE EXISTS (
    SELECT 1 FROM employee e WHERE e.departmentId = d.departmentId
)
ORDER BY d.departmentId;

-- Explanation:
-- EXISTS checks if subquery returns ANY rows
-- Returns departmentId immediately upon finding first employee
-- More efficient than IN for existence checks

-- ============================================================================
-- 9B. NOT EXISTS - Find Departments Without Employees
-- ============================================================================

SELECT 
    d.departmentId,
    d.name
FROM department d
WHERE NOT EXISTS (
    SELECT 1 FROM employee e WHERE e.departmentId = d.departmentId
)
ORDER BY d.departmentId;

-- Explanation:
-- Opposite of EXISTS
-- Result: Departments with no assigned employees
-- SELECT 1 vs SELECT column: Doesn't matter, EXISTS only checks existence

-- ============================================================================
-- 10. CORRELATED SUBQUERIES - Reference Outer Query
-- ============================================================================
-- Subquery references columns from outer query
-- Executes once for each outer row (can be slow!)

-- Example 10A: Find highest-paid employee in each department
SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    e.salary,
    e.departmentId
FROM employee e
WHERE e.salary = (
    SELECT MAX(e2.salary) 
    FROM employee e2 
    WHERE e2.departmentId = e.departmentId
)
ORDER BY e.departmentId, e.salary DESC;

-- Explanation:
-- Subquery: For EACH employee, find max salary in THEIR department
-- This is CORRELATED (uses e.departmentId from outer query)
-- Executes once for each employee row

-- ============================================================================
-- 10B. CORRELATED - Count Employees Hired After Each Person
-- ============================================================================

SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    (
        SELECT COUNT(*) 
        FROM employee e2 
        WHERE e2.employeeId != e.employeeId
    ) as total_other_employees
FROM employee e
ORDER BY e.employeeId;

-- Explanation:
-- For each employee, count how many other employees exist
-- Shows: Employee count relative to each person

-- ============================================================================
-- 11. NESTED SUBQUERIES - Multiple Levels
-- ============================================================================
-- Subqueries within subqueries (multiple levels deep)
-- Can be complex and hard to read - use with caution!

-- Example 11: Find employees earning more than average in above-average depts
SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    e.salary,
    e.departmentId
FROM employee e
WHERE e.departmentId IN (
    -- Level 2: Get departments with above-average salary
    SELECT departmentId 
    FROM (
        SELECT 
            departmentId,
            AVG(salary) as avg_dept_salary
        FROM employee
        GROUP BY departmentId
        -- Level 3: Compare to company average
        HAVING AVG(salary) > (SELECT AVG(salary) FROM employee)
    ) above_avg_depts
)
AND e.salary > (
    -- Also compare employee to their dept average
    SELECT AVG(salary) 
    FROM employee e2 
    WHERE e2.departmentId = e.departmentId
)
ORDER BY e.salary DESC;

-- Explanation:
-- Multiple levels of nesting
-- Level 1: Outer query selects employees
-- Level 2: Middle subquery finds above-average departments
-- Level 3: Inner subquery compares to company average
-- Hard to read - consider using derived tables or JOINs instead

-- ============================================================================
-- 12. SUBQUERIES vs JOINs - Performance Comparison
-- ============================================================================

-- APPROACH 1: Using SUBQUERY
-- Find highest-paid employee in each department
SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    e.salary,
    e.departmentId
FROM employee e
WHERE e.salary = (
    SELECT MAX(salary) 
    FROM employee e2 
    WHERE e2.departmentId = e.departmentId
)
ORDER BY e.departmentId;

-- APPROACH 2: Using JOIN with derived table
-- Find highest-paid employee in each department
SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    d.name as department_name,
    e.salary,
    max_salaries.max_salary as department_max_salary,
    e.departmentId
FROM employee e
JOIN department d ON e.departmentId = d.departmentId
JOIN (
    SELECT departmentId, MAX(salary) as max_salary
    FROM employee
    GROUP BY departmentId
) max_salaries ON e.departmentId = max_salaries.departmentId
                AND e.salary = max_salaries.max_salary
ORDER BY e.salary DESC;

-- APPROACH 3: Using Window Function (MySQL 8.0+)
-- Find highest-paid employee in each department
SELECT 
    employeeId,
    CONCAT(first_name, ' ', last_name) as employee_name,
    salary,
    departmentId
FROM (
    SELECT 
        employeeId,
        first_name,
        last_name,
        salary,
        departmentId,
        ROW_NUMBER() OVER (PARTITION BY departmentId ORDER BY salary DESC) as rank
    FROM employee
) ranked_employees
WHERE rank = 1
ORDER BY departmentId;

-- ============================================================================
-- PRACTICE QUESTIONS
-- ============================================================================
-- Answer these using SUBQUERIES:
--
-- Q1: Find employees earning more than the company average
-- Q2: Find departments with more than average number of employees
-- Q3: Find employees who work in departments with expensive projects
-- Q4: Find highest-paid employee in each department
-- Q5: Find employees with salary above their department average
-- Q6: Find employees who were hired in years with above-average hires
-- Q7: Find projects assigned to highest-spending departments
-- Q8: Find employees NOT assigned to any project
-- Q9: Find departments with no employees
-- Q10: Create a ranking of employees within each department by salary

-- ============================================================================
-- KEY POINTS ABOUT SUBQUERIES
-- ============================================================================
-- ✓ Query within another query
-- ✓ Returns results used by outer query
-- ✓ Can be in SELECT, WHERE, FROM, HAVING, INSERT, UPDATE, DELETE
-- ✓ Scalar subqueries return single value
-- ✓ Table subqueries return multiple rows/columns
-- ✓ CORRELATED subqueries reference outer query
-- ✓ Can be nested multiple levels (be careful!)
-- ✓ More readable than complex JOINs
-- ✓ Can have performance implications
-- ✓ Useful for step-by-step logic

-- ============================================================================
-- COMMON MISTAKES TO AVOID
-- ============================================================================
-- MISTAKE 1: Subquery returns multiple values in scalar context
-- WRONG:  SELECT * FROM employees WHERE salary = (SELECT salary FROM employees)
--         (Returns error: subquery returned multiple values)
-- RIGHT:  SELECT * FROM employees WHERE salary = (SELECT MAX(salary) FROM employees)
--         (Returns single value)

-- MISTAKE 2: Using IN without checking for NULLs
-- WRONG:  SELECT * FROM employees WHERE dept_id NOT IN (SELECT id FROM depts)
--         (If subquery returns NULL, result is unexpected)
-- RIGHT:  SELECT * FROM employees WHERE dept_id NOT IN (SELECT id FROM depts WHERE id IS NOT NULL)
--         (Filter out NULLs from subquery)

-- MISTAKE 3: Slow correlated subqueries on large datasets
-- WRONG:  SELECT * FROM employees e
--         WHERE salary > (SELECT AVG(salary) FROM employees e2 WHERE e2.dept = e.dept)
--         (Executes for each employee row - can be very slow)
-- RIGHT:  Use JOIN or window function for better performance

-- MISTAKE 4: Not understanding query execution order
-- WRONG:  Assuming outer query executes before subquery
-- RIGHT:  Subqueries execute from innermost to outermost
--         Inner query result feeds into outer query

-- MISTAKE 5: Ordering in subqueries without LIMIT
-- WRONG:  SELECT * FROM (SELECT * FROM employees ORDER BY salary) t
--         (ORDER BY in subquery is ignored without LIMIT)
-- RIGHT:  SELECT * FROM (SELECT * FROM employees ORDER BY salary LIMIT 10) t
--         (ORDER BY affects LIMIT result)

-- ============================================================================
-- COMPARISON: SUBQUERIES vs JOINs
-- ============================================================================
--
-- SUBQUERIES:
--   When: Logic is step-by-step, hard to express as JOIN
--   Pros: More readable, natural flow, flexible
--   Cons: Can be slower (especially correlated), resource usage
--
-- JOINs:
--   When: Tables have natural relationships
--   Pros: Generally faster, efficient for large datasets
--   Cons: More complex syntax, can be harder to read
--
-- WINDOW FUNCTIONS (MySQL 8.0+):
--   When: Need ranking, running totals, comparisons within groups
--   Pros: Very efficient, clear intent
--   Cons: Only in MySQL 8.0+, requires learning new syntax

-- ============================================================================
-- PERFORMANCE CONSIDERATIONS
-- ============================================================================
--
-- Scalar Subquery Performance:
--   ⚠️  Executes for EVERY row (correlated)
--   ✓ Use indexes on join columns
--   ✓ Consider moving to FROM clause (derived table)
--
-- IN Subquery Performance:
--   ⚠️  Can be slow if subquery returns many rows
--   ✓ Consider JOIN alternative
--   ✓ Optimize WHERE clause in subquery
--
-- EXISTS Subquery Performance:
--   ✅ Generally faster than IN
--   ✓ Stops searching after first match
--   ✓ Preferred for existence checks
--
-- FROM Subquery (Derived Table) Performance:
--   ⚠️  Creates temporary result set in memory
--   ✓ Filter as much as possible in subquery
--   ✓ Use indexes on GROUP BY columns

-- ============================================================================
-- WHEN TO USE SUBQUERIES
-- ============================================================================
--
-- Use SUBQUERIES when:
--   1. Logic is naturally sequential
--   2. Need to calculate aggregate then filter
--   3. Checking existence of records (EXISTS)
--   4. Step-by-step approach is clearer
--   5. Tables don't have natural relationships
--   6. Need to reuse query result multiple times
--
-- Use JOINs instead when:
--   1. Tables have natural relationships
--   2. Performance is critical
--   3. Returning columns from multiple tables
--   4. Simple relationship conditions
--
-- Use WINDOW FUNCTIONS when:
--   1. Need ranking within groups (MySQL 8.0+)
--   2. Need running totals or comparisons
--   3. Performance is important
--   4. Available in your database

-- ============================================================================
-- BEST PRACTICES FOR SUBQUERIES
-- ============================================================================
--
-- 1. Keep subqueries simple
--    Don't nest more than 2-3 levels deep
--
-- 2. Use meaningful aliases
--    FROM (SELECT ...) table_alias
--
-- 3. Add comments explaining logic
--    -- Get departments with above-average salary
--
-- 4. Test subqueries independently
--    Run SELECT subquery alone to verify results
--
-- 5. Consider performance implications
--    Correlated subqueries execute once per row
--
-- 6. Use EXISTS for existence checks
--    More efficient than IN
--
-- 7. Filter in subquery, not outer query
--    Move WHERE conditions earlier for efficiency
--
-- 8. Use EXPLAIN to analyze performance
--    Check execution plan: EXPLAIN SELECT ...
--
-- 9. Document complex logic
--    Make it clear what each subquery does
--
-- 10. Consider alternatives
--     JOINs, CTE, Window Functions may be better

-- ============================================================================
-- DATABASE COMPATIBILITY
-- ============================================================================
--
-- All major databases support subqueries:
--   ✅ MySQL 5.7+
--   ✅ PostgreSQL
--   ✅ SQL Server
--   ✅ Oracle
--   ✅ SQLite
--
-- Advanced features (MySQL 8.0+):
--   ✅ Window functions
--   ✅ CTEs (Common Table Expressions)
--   ✅ Better subquery optimization

-- ============================================================================
-- NOTES
-- ============================================================================
-- These queries use existing tables from sql/02-manipulation/create-cmd.sql
-- Do NOT drop these tables as they are referenced by multiple tutorial files
-- 
-- If you want to reset the data, re-run insert-cmd.sql from 02-manipulation folder

/*
================================================================================
  END OF SUBQUERIES GUIDE
================================================================================
  Summary:
  - SUBQUERIES: Query within a query
  - Types: Scalar, Row, Table, Correlated, Derived Tables
  - Used in: SELECT, WHERE, FROM, HAVING, INSERT, UPDATE, DELETE
  - Advantages: Readable, flexible, step-by-step logic
  - Disadvantages: Can be slower, performance overhead
  
  Key Insight:
  Subqueries are powerful for breaking down complex logic.
  Master them for clear, maintainable SQL queries!
  
  WHAT YOU LEARNED:
  1. Created tables with sample data
  2. Used scalar subqueries (single value)
  3. Used table subqueries (multiple rows)
  4. Filtered with subqueries in WHERE
  5. Added subqueries in SELECT clause
  6. Created derived tables in FROM
  7. Used IN and EXISTS operators
  8. Created correlated subqueries
  9. Nested subqueries (multiple levels)
  10. Compared subqueries vs JOINs
  
  KEY REMINDERS:
  1. Subquery in parentheses: (SELECT ...)
  2. Executes innermost to outermost
  3. Scalar subqueries return ONE value
  4. Correlated subqueries execute per row
  5. EXISTS is faster than IN for existence
  6. Consider JOINs for better performance
  7. Use derived tables for complex logic
  8. Test each subquery independently
  9. Don't nest more than 3 levels
  10. Use EXPLAIN for performance analysis
  
  For more information:
  - https://dev.mysql.com/doc/refman/8.0/en/subqueries.html
  - https://www.w3schools.com/sql/sql_subqueries.asp
  - Query optimization techniques
  - Window functions (MySQL 8.0+)
  - Common Table Expressions (CTEs)
================================================================================
*/
