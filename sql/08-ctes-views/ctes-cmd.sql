/*
================================================================================
  SQL CTEs (COMMON TABLE EXPRESSIONS) COMPREHENSIVE GUIDE
================================================================================
  File: ctes-cmd.sql
  Description: Complete tutorial on SQL CTEs with practical examples
               using employee, department, project tables.
  
  AUTHOR: Durgesh Tambe
  CREATED: April 25, 2026
  UPDATED: April 25, 2026
  VERSION: 1.0
  
  WHAT ARE CTEs (COMMON TABLE EXPRESSIONS)?
  ─────────────────────────────────────────────────────────────────────────────
  A CTE (Common Table Expression) is a temporary named result set that exists
  only within the scope of a single SELECT, INSERT, UPDATE, or DELETE statement.
  
  Think of it as:
    "A temporary table that you define inline within your query"
    "A way to break down complex queries into readable, named steps"
    "Similar to a function or variable in programming"
  
  CTEs are defined using WITH clause and can be referenced multiple times
  in the main query.
  
  Key Characteristics:
    ✓ Creates temporary named result set
    ✓ Defined with WITH clause before main query
    ✓ Can be referenced multiple times in main query
    ✓ Scoped to single statement (doesn't persist)
    ✓ Can be non-recursive (standard) or recursive
    ✓ Improves query readability dramatically
    ✓ Can simplify complex logic
    ✓ Allows multiple CTEs in single query
    ✓ Excellent for breaking down complex queries
  
  Two Types of CTEs:
    1. NON-RECURSIVE CTE - Standard CTE, executes once
    2. RECURSIVE CTE - Can reference itself, useful for hierarchies
  
  Syntax - Basic CTE:
    WITH cte_name AS (
        SELECT columns FROM table WHERE condition
    )
    SELECT columns FROM cte_name;
  
  Syntax - Multiple CTEs:
    WITH 
    cte1 AS (SELECT ...),
    cte2 AS (SELECT ...),
    cte3 AS (SELECT ...)
    SELECT columns FROM cte1 JOIN cte2 ON ...;
  
  Syntax - Recursive CTE:
    WITH RECURSIVE cte_name AS (
        SELECT ... -- Anchor query (base case)
        UNION ALL
        SELECT ... -- Recursive query (references itself)
        WHERE condition  -- Termination condition
    )
    SELECT columns FROM cte_name;
  
  When to use CTEs:
    ✓ Breaking down complex queries into steps
    ✓ Improving readability of nested subqueries
    ✓ Reusing same logic multiple times
    ✓ Recursive queries (hierarchies, trees)
    ✓ Multi-step data transformations
    ✓ Data validation and reconciliation
    ✓ Creating intermediate result sets
    ✓ Analytical queries with multiple aggregations
  
  Advantages:
    ✅ Highly readable (named, step-by-step)
    ✅ Easy to test (can run CTE independently)
    ✅ Maintainable (changes affect whole query)
    ✅ Reusable within same query
    ✅ Better than nested subqueries
    ✅ Supports recursion for hierarchies
    ✅ No performance penalty vs subqueries
    ✅ Can join CTE with itself
  
  Disadvantages:
    ⚠️ Only exists for single statement
    ⚠️ Not materialized (re-evaluated if used multiple times)
    ⚠️ Limited recursion depth (prevent infinite loops)
    ⚠️ Some databases require specific syntax
    ⚠️ Not for persistent data (use views instead)
  
  Database Support:
    ✅ MySQL ............ Supported (5.7.2+ for standard, 8.0+ for recursive)
    ✅ PostgreSQL ....... Fully supported (including recursive)
    ✅ SQL Server ....... Fully supported (with dialect)
    ✅ Oracle ........... Fully supported (WITH clause)
    ✅ SQLite ........... Supported (3.8.3+)
  
  TABLE OF CONTENTS:
    1. Simple CTE - Basic usage
    2. CTE with Aggregation - Groups and calculations
    3. Multiple CTEs - Chaining CTEs
    4. CTE with JOIN - Combining CTEs
    5. CTE in WHERE - Use CTE for filtering
    6. CTE as Base for Another CTE - Multi-level
    7. CTE with CASE - Conditional logic in CTE
    8. Ranking with CTE - ROW_NUMBER and ranking
    9. Recursive CTE - Hierarchical queries
    10. CTE for Data Validation - Quality checks
    11. CTE with UNION - Combining result sets
    12. Performance Comparison - CTE vs Subquery
  
  MYSQL SPECIFIC NOTES:
    - Non-recursive CTEs: Supported in MySQL 5.7.2+
    - Recursive CTEs: Supported in MySQL 8.0+
    - max_execution_time hint can limit recursion
    - cte_max_recursion_depth session variable controls depth
  
  PREREQUISITES:
    - Tables: department, employee, project, project_assignment
    - Created in sql/02-manipulation/create-cmd.sql
    - Sample data pre-populated
    
  EXECUTION:
    - Ensure tables from 02-manipulation/create-cmd.sql exist
    - Execute each example individually
    - Understand step-by-step logic
    - Notice readability improvement
    - Try modifying CTEs for different results
================================================================================
*/

-- ============================================================================
-- REFERENCING EXISTING TABLES FROM sql/02-manipulation/create-cmd.sql
-- ============================================================================
-- 
-- These examples use existing tables:
--   - department (departmentId, name)
--   - employee (employeeId, first_name, last_name, email, salary, departmentId)
--   - project (projectId, project_name, budget, departmentId, status)
--   - project_assignment (assignment_id, employeeId, projectId, role, allocation_percentage, assignment_date)
--
-- Ensure you have run create-cmd.sql and insert-cmd.sql from 02-manipulation folder first!
--
-- Verify existing data:
SELECT 'employee' as table_name, COUNT(*) as total_records FROM employee
UNION ALL
SELECT 'department', COUNT(*) FROM department
UNION ALL
SELECT 'project', COUNT(*) FROM project;

-- ============================================================================
-- 1. SIMPLE CTE - Basic Usage
-- ============================================================================
-- Most basic CTE - defines named result set used once

-- Example 1A: Get high earners and display them
WITH high_earners AS (
    SELECT 
        employeeId,
        CONCAT(first_name, ' ', last_name) as employee_name,
        salary,
        departmentId
    FROM employee
    WHERE salary > 85000
)
SELECT 
    *,
    ROUND(salary / (SELECT AVG(salary) FROM employee) * 100, 2) as salary_vs_avg_percent
FROM high_earners
ORDER BY salary DESC;

-- Explanation:
-- WITH high_earners AS (...) defines CTE
-- CTE contains employees earning > 85000
-- Main query references high_earners like a table
-- Result: High earners with salary comparison

-- ============================================================================
-- 1B. SIMPLE CTE - Project Summary
-- ============================================================================

WITH active_projects AS (
    SELECT 
        projectId,
        project_name,
        budget,
        departmentId,
        status
    FROM project
    WHERE status IN ('Active', 'In Progress')
)
SELECT 
    projectId,
    project_name,
    budget,
    ROUND(budget * 0.1, 2) as ten_percent_contingency,
    ROUND(budget * 0.15, 2) as fifteen_percent_contingency
FROM active_projects
ORDER BY budget DESC;

-- ============================================================================
-- 2. CTE with Aggregation - Groups and Calculations
-- ============================================================================
-- CTEs are excellent for calculating aggregates

-- Example 2A: Department salary analysis
WITH dept_salary_analysis AS (
    SELECT 
        d.departmentId,
        d.name as department_name,
        COUNT(e.employeeId) as emp_count,
        SUM(e.salary) as total_salary,
        ROUND(AVG(e.salary), 2) as avg_salary,
        MIN(e.salary) as min_salary,
        MAX(e.salary) as max_salary
    FROM department d
    LEFT JOIN employee e ON d.departmentId = e.departmentId
    GROUP BY d.departmentId, d.name
)
SELECT 
    departmentId,
    department_name,
    emp_count,
    total_salary,
    avg_salary,
    ROUND(max_salary - min_salary, 2) as salary_range,
    ROUND(max_salary / NULLIF(min_salary, 0), 2) as salary_ratio
FROM dept_salary_analysis
ORDER BY total_salary DESC;

-- Explanation:
-- CTE performs all aggregation calculations
-- Main query uses pre-calculated values
-- Much cleaner than nested subqueries

-- ============================================================================
-- 2B. CTE with Aggregation - Project spend by department
-- ============================================================================

WITH project_spend AS (
    SELECT 
        d.departmentId,
        d.name as department_name,
        COUNT(p.projectId) as project_count,
        SUM(p.budget) as total_budget,
        ROUND(AVG(p.budget), 2) as avg_budget,
        MIN(p.budget) as min_budget,
        MAX(p.budget) as max_budget
    FROM department d
    LEFT JOIN project p ON d.departmentId = p.departmentId
    GROUP BY d.departmentId, d.name
)
SELECT 
    *,
    ROUND(total_budget / NULLIF(project_count, 0), 2) as budget_per_project
FROM project_spend
ORDER BY total_budget DESC;

-- ============================================================================
-- 3. MULTIPLE CTEs - Chaining CTEs
-- ============================================================================
-- Use multiple CTEs to break down complex logic

-- Example 3: Compare salary tiers across departments
WITH 
dept_stats AS (
    SELECT 
        d.departmentId,
        d.name as department_name,
        COUNT(e.employeeId) as emp_count,
        ROUND(AVG(e.salary), 2) as avg_salary
    FROM department d
    LEFT JOIN employee e ON d.departmentId = e.departmentId
    GROUP BY d.departmentId, d.name
),
high_earners_by_dept AS (
    SELECT 
        ds.departmentId,
        ds.department_name,
        COUNT(e.employeeId) as high_earner_count,
        ROUND(AVG(e.salary), 2) as high_earner_avg_salary
    FROM dept_stats ds
    JOIN employee e ON ds.departmentId = e.departmentId
    WHERE e.salary > (SELECT AVG(salary) FROM employee)
    GROUP BY ds.departmentId, ds.department_name
)
SELECT 
    d.departmentId,
    d.department_name,
    d.emp_count,
    d.avg_salary,
    COALESCE(h.high_earner_count, 0) as high_earner_count,
    COALESCE(h.high_earner_avg_salary, 0) as high_earner_avg_salary
FROM dept_stats d
LEFT JOIN high_earners_by_dept h ON d.departmentId = h.departmentId
ORDER BY d.avg_salary DESC;

-- Explanation:
-- dept_stats: CTE 1 - Department statistics
-- high_earners_by_dept: CTE 2 - Uses CTE 1 and adds high earner analysis
-- Main query: Combines both CTEs
-- Much more readable than nested subqueries!

-- ============================================================================
-- 4. CTE with JOIN - Combining CTEs
-- ============================================================================
-- Join multiple CTEs together

-- Example 4: Employee and project assignment summary
WITH 
employee_summary AS (
    SELECT 
        e.employeeId,
        CONCAT(e.first_name, ' ', e.last_name) as employee_name,
        e.salary,
        d.name as department_name
    FROM employee e
    JOIN department d ON e.departmentId = d.departmentId
),
project_count AS (
    SELECT 
        pa.employeeId,
        COUNT(DISTINCT pa.projectId) as projects_assigned,
        COUNT(DISTINCT pa.projectId) * pa.allocation_percentage / 100 as utilization_hours
    FROM project_assignment pa
    GROUP BY pa.employeeId, pa.allocation_percentage
)
SELECT 
    es.employeeId,
    es.employee_name,
    es.department_name,
    es.salary,
    COALESCE(pc.projects_assigned, 0) as projects_count
FROM employee_summary es
LEFT JOIN project_count pc ON es.employeeId = pc.employeeId
ORDER BY es.salary DESC;

-- ============================================================================
-- 5. CTE IN WHERE - Use CTE for Filtering
-- ============================================================================
-- Use CTE result in WHERE clause

-- Example 5: Find employees in departments with above-average pay
WITH 
high_salary_depts AS (
    SELECT 
        departmentId,
        ROUND(AVG(salary), 2) as dept_avg_salary
    FROM employee
    GROUP BY departmentId
    HAVING AVG(salary) > (SELECT AVG(salary) FROM employee)
)
SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    e.salary,
    d.name as department_name,
    hsd.dept_avg_salary
FROM employee e
JOIN department d ON e.departmentId = d.departmentId
JOIN high_salary_depts hsd ON e.departmentId = hsd.departmentId
ORDER BY e.salary DESC;

-- Explanation:
-- CTE identifies departments with above-average pay
-- Main query filters employees to only those departments
-- Clear, readable logic

-- ============================================================================
-- 6. CTE AS BASE FOR ANOTHER CTE - Multi-Level
-- ============================================================================
-- One CTE building on another CTE

-- Example 6: Employee with bonus eligibility tiers
WITH 
salary_tiers AS (
    SELECT 
        employeeId,
        CONCAT(first_name, ' ', last_name) as employee_name,
        salary,
        CASE
            WHEN salary >= 100000 THEN 'Senior'
            WHEN salary >= 80000 THEN 'Mid'
            ELSE 'Junior'
        END as salary_tier
    FROM employee
),
bonus_calculation AS (
    SELECT 
        *,
        CASE
            WHEN salary_tier = 'Senior' THEN ROUND(salary * 0.15, 2)
            WHEN salary_tier = 'Mid' THEN ROUND(salary * 0.10, 2)
            ELSE ROUND(salary * 0.05, 2)
        END as potential_bonus
    FROM salary_tiers
)
SELECT 
    employeeId,
    employee_name,
    salary,
    salary_tier,
    potential_bonus,
    salary + potential_bonus as total_with_bonus
FROM bonus_calculation
ORDER BY salary DESC;

-- Explanation:
-- salary_tiers: CTE 1 - Categorizes employees by salary
-- bonus_calculation: CTE 2 - Uses CTE 1 to calculate bonuses
-- Main query: Shows final results
-- Step-by-step transformation is very clear!

-- ============================================================================
-- 7. CTE WITH CASE - Conditional Logic in CTE
-- ============================================================================
-- Combine CASE statements within CTEs

-- Example 7: Employee classification with project assignment
WITH 
employee_classification AS (
    SELECT 
        e.employeeId,
        CONCAT(e.first_name, ' ', e.last_name) as employee_name,
        e.salary,
        d.name as department_name,
        COUNT(DISTINCT pa.projectId) as projects_count,
        CASE
            WHEN COUNT(DISTINCT pa.projectId) = 0 THEN 'Unassigned'
            WHEN COUNT(DISTINCT pa.projectId) >= 3 THEN 'Overallocated'
            WHEN COUNT(DISTINCT pa.projectId) >= 1 THEN 'Allocated'
            ELSE 'Unassigned'
        END as allocation_status
    FROM employee e
    JOIN department d ON e.departmentId = d.departmentId
    LEFT JOIN project_assignment pa ON e.employeeId = pa.employeeId
    GROUP BY e.employeeId, e.first_name, e.last_name, e.salary, d.name
)
SELECT 
    *,
    CASE
        WHEN salary > 90000 AND allocation_status = 'Allocated' THEN 'Tier A'
        WHEN salary > 75000 THEN 'Tier B'
        ELSE 'Tier C'
    END as employee_tier
FROM employee_classification
ORDER BY salary DESC;

-- ============================================================================
-- 8. RANKING WITH CTE - ROW_NUMBER and Ranking Functions
-- ============================================================================
-- Use window functions within CTEs (MySQL 8.0+)

-- Example 8: Rank employees by salary within each department
WITH 
ranked_employees AS (
    SELECT 
        e.employeeId,
        CONCAT(e.first_name, ' ', e.last_name) as employee_name,
        e.salary,
        d.name as department_name,
        d.departmentId,
        ROW_NUMBER() OVER (PARTITION BY e.departmentId ORDER BY e.salary DESC) as salary_rank_in_dept,
        ROW_NUMBER() OVER (ORDER BY e.salary DESC) as company_salary_rank
    FROM employee e
    JOIN department d ON e.departmentId = d.departmentId
)
SELECT 
    *,
    CASE
        WHEN salary_rank_in_dept = 1 THEN 'Department Top'
        WHEN salary_rank_in_dept <= 3 THEN 'Top 3 in Dept'
        ELSE 'Other'
    END as rank_category
FROM ranked_employees
WHERE salary_rank_in_dept <= 5
ORDER BY departmentId, salary DESC;

-- Explanation:
-- ROW_NUMBER() assigns rank within partition
-- PARTITION BY departmentId - rank within each dept
-- ORDER BY salary DESC - highest salary gets rank 1

-- ============================================================================
-- 9. RECURSIVE CTE - Hierarchical Queries (MySQL 8.0+)
-- ============================================================================
-- CTE that references itself for hierarchical data

-- Example 9A: Simple recursive CTE - Generate numbers 1 to 5
WITH RECURSIVE numbers AS (
    SELECT 1 as num
    UNION ALL
    SELECT num + 1
    FROM numbers
    WHERE num < 5
)
SELECT * FROM numbers;

-- Explanation:
-- Anchor query: SELECT 1 as num (base case)
-- Recursive query: SELECT num + 1 (references itself)
-- WHERE num < 5 (termination condition)
-- Output: 1, 2, 3, 4, 5

-- ============================================================================
-- 9B. RECURSIVE CTE - Generate dates for project timeline
-- ============================================================================

WITH RECURSIVE date_range AS (
    SELECT DATE('2026-01-01') as project_date
    UNION ALL
    SELECT DATE_ADD(project_date, INTERVAL 1 WEEK)
    FROM date_range
    WHERE project_date < DATE('2026-12-31')
)
SELECT 
    project_date,
    WEEK(project_date) as week_number,
    MONTHNAME(project_date) as month_name,
    DAYNAME(project_date) as day_name
FROM date_range
ORDER BY project_date;

-- Explanation:
-- Generates date range for 2026
-- Each week incremented by +7 days
-- Shows year-long project timeline

-- ============================================================================
-- 10. CTE FOR DATA VALIDATION - Quality Checks
-- ============================================================================
-- Use CTEs to identify data quality issues

-- Example 10: Find data anomalies in employee records
WITH 
data_validation AS (
    SELECT 
        employeeId,
        CONCAT(first_name, ' ', last_name) as employee_name,
        salary,
        email,
        departmentId,
        CASE
            WHEN salary IS NULL THEN 'Missing Salary'
            WHEN salary < 30000 THEN 'Below Minimum'
            WHEN salary > 150000 THEN 'Above Expected'
            ELSE 'Valid'
        END as salary_status,
        CASE
            WHEN email IS NULL THEN 'Missing Email'
            WHEN email NOT LIKE '%@%' THEN 'Invalid Email'
            ELSE 'Valid'
        END as email_status,
        CASE
            WHEN departmentId IS NULL THEN 'Unassigned Department'
            ELSE 'Assigned'
        END as dept_status
    FROM employee
)
SELECT 
    *,
    CASE
        WHEN salary_status != 'Valid' OR email_status != 'Valid' OR dept_status != 'Assigned' 
            THEN 'Needs Review'
        ELSE 'Clean'
    END as data_quality
FROM data_validation
WHERE salary_status != 'Valid' OR email_status != 'Valid' OR dept_status != 'Assigned';

-- ============================================================================
-- 11. CTE WITH UNION - Combining Result Sets
-- ============================================================================
-- Use CTE to prepare data before UNION

-- Example 11: Unified view of budget vs actual spend
WITH 
budgeted_items AS (
    SELECT 
        projectId,
        project_name,
        budget as amount,
        'Budgeted' as type,
        departmentId
    FROM project
),
actual_items AS (
    SELECT 
        projectId,
        project_name,
        budget as amount,
        'Actual' as type,
        departmentId
    FROM project
    WHERE status = 'Completed'
)
SELECT 
    projectId,
    project_name,
    amount,
    type,
    departmentId
FROM budgeted_items
UNION ALL
SELECT 
    projectId,
    project_name,
    amount,
    type,
    departmentId
FROM actual_items
ORDER BY projectId, type;

-- ============================================================================
-- 12. PERFORMANCE COMPARISON - CTE vs Subquery
-- ============================================================================

-- APPROACH 1: Using nested Subquery (harder to read)
SELECT 
    employee_name,
    salary,
    company_avg,
    salary - company_avg as diff
FROM (
    SELECT 
        CONCAT(e.first_name, ' ', e.last_name) as employee_name,
        e.salary,
        (SELECT AVG(salary) FROM employee) as company_avg
    FROM employee e
    WHERE e.salary > (SELECT AVG(salary) FROM employee)
) nested_results
ORDER BY salary DESC;

-- APPROACH 2: Using CTE (much more readable!)
WITH 
company_average AS (
    SELECT ROUND(AVG(salary), 2) as avg_salary FROM employee
),
high_earners AS (
    SELECT 
        CONCAT(first_name, ' ', last_name) as employee_name,
        salary
    FROM employee
    WHERE salary > (SELECT avg_salary FROM company_average)
)
SELECT 
    he.employee_name,
    he.salary,
    ca.avg_salary,
    he.salary - ca.avg_salary as salary_difference
FROM high_earners he
CROSS JOIN company_average ca
ORDER BY he.salary DESC;

-- The CTE approach is much clearer!

-- ============================================================================
-- PRACTICE QUESTIONS
-- ============================================================================
-- Answer these using CTEs:
--
-- Q1: Create CTE for department with max/min/avg salary
-- Q2: Rank employees by salary within departments
-- Q3: Find employees above department average
-- Q4: Calculate project budget utilization percentage
-- Q5: Generate employee performance tiers
-- Q6: Create hierarchical department reporting
-- Q7: Validate data quality with CTE
-- Q8: Compare budget vs actual spending
-- Q9: Create recursive CTE for number sequence
-- Q10: Generate report with multiple aggregation levels

-- ============================================================================
-- KEY POINTS ABOUT CTEs
-- ============================================================================
-- ✓ Defined with WITH clause before main query
-- ✓ Named result set scoped to single statement
-- ✓ Can be referenced multiple times
-- ✓ Multiple CTEs in single query
-- ✓ CTEs can reference previous CTEs
-- ✓ Supports recursion for hierarchies
-- ✓ More readable than nested subqueries
-- ✓ No performance penalty (similar to subqueries)
-- ✓ Excellent for breaking complex queries
-- ✓ Can be joined with tables and other CTEs

-- ============================================================================
-- COMMON MISTAKES TO AVOID
-- ============================================================================
-- MISTAKE 1: Forgetting comma between multiple CTEs
-- WRONG:  WITH cte1 AS (...) cte2 AS (...)
-- RIGHT:  WITH cte1 AS (...), cte2 AS (...)

-- MISTAKE 2: CTE name not referenced in main query
-- WRONG:  WITH my_cte AS (SELECT ...) SELECT * FROM employee
-- RIGHT:  WITH my_cte AS (SELECT ...) SELECT * FROM my_cte

-- MISTAKE 3: Trying to use CTE outside its scope
-- WRONG:  WITH cte AS (...) SELECT ...; SELECT * FROM cte
--         (CTE expires after first query)
-- RIGHT:  Define CTE again for second query

-- MISTAKE 4: Recursive CTE missing termination condition
-- WRONG:  WITH RECURSIVE nums AS (SELECT 1 UNION ALL SELECT num+1 FROM nums)
--         (Infinite loop!)
-- RIGHT:  WITH RECURSIVE nums AS (SELECT 1 UNION ALL SELECT num+1 FROM nums WHERE num < 100)

-- MISTAKE 5: Using ORDER BY in CTE only (affects nothing)
-- WRONG:  WITH cte AS (SELECT * FROM employee ORDER BY salary DESC)
--         SELECT * FROM cte (order lost!)
-- RIGHT:  ORDER BY in main query after referencing CTE

-- ============================================================================
-- COMPARISON: CTE vs Subquery vs Derived Table vs View
-- ============================================================================
--
-- CTE:
--   Scope: Single statement
--   Reuse: Within same query only
--   Best for: Complex, multi-step queries
--
-- SUBQUERY:
--   Scope: Single statement
--   Reuse: Can nest multiple levels
--   Best for: Quick inline queries
--
-- DERIVED TABLE:
--   Scope: Single query (FROM subquery)
--   Reuse: Only in that query
--   Best for: Temporary aggregation
--
-- VIEW:
--   Scope: Persistent (saved in database)
--   Reuse: Multiple queries, multiple sessions
--   Best for: Frequently used queries

-- ============================================================================
-- PERFORMANCE CONSIDERATIONS
-- ============================================================================
--
-- CTE Performance:
--   ✅ Similar to subqueries (not slower)
--   ✓ Not materialized by default (re-evaluated if used multiple times)
--   ✓ Some databases optimize CTE materialization
--   ✓ Recursion has depth limits
--
-- Tips:
--   1. Put most complex logic in earlier CTEs
--   2. Filter as early as possible
--   3. Use indexes on join columns
--   4. Avoid using same CTE multiple times (re-evaluated)
--   5. Consider materialization hints if available
--   6. Test execution plans: EXPLAIN

-- ============================================================================
-- BEST PRACTICES FOR CTEs
-- ============================================================================
--
-- 1. Use meaningful names
--    WITH employee_stats AS (...)
--
-- 2. Break complex queries into steps
--    Multiple simple CTEs better than one complex
--
-- 3. Order CTEs logically
--    Build from foundational to complex
--
-- 4. Add comments explaining each CTE
--    /* CTE 1: Get department statistics */
--
-- 5. Put ORDER BY in main query only
--    ORDER BY in CTE is usually ignored
--
-- 6. Use aliases for clarity
--    FROM employees e JOIN departments d ON ...
--
-- 7. Test CTEs independently
--    Run SELECT * FROM cte to verify results
--
-- 8. Handle NULL explicitly
--    Use CASE or COALESCE for NULL values
--
-- 9. Use descriptive column aliases
--    SELECT salary as employee_salary (not just s)
--
-- 10. Keep recursion simple
--     Add clear termination conditions

-- ============================================================================
-- DATABASE COMPATIBILITY
-- ============================================================================
--
-- CTEs supported in ALL major databases:
--   ✅ MySQL - Non-recursive (5.7.2+), Recursive (8.0+)
--   ✅ PostgreSQL - Fully supported
--   ✅ SQL Server - Fully supported
--   ✅ Oracle - Supported (WITH clause)
--   ✅ SQLite - Supported (3.8.3+)
--
-- Syntax is largely identical across databases

-- ============================================================================
-- NOTES
-- ============================================================================
-- These queries use existing tables from sql/02-manipulation/create-cmd.sql
-- Do NOT drop these tables as they are referenced by multiple tutorial files
-- 
-- If you want to reset the data, re-run insert-cmd.sql from 02-manipulation folder

/*
================================================================================
  END OF CTEs GUIDE
================================================================================
  Summary:
  - CTE: Named temporary result set within single statement
  - Types: Non-recursive (standard) and Recursive (hierarchies)
  - Defined with WITH clause before main query
  - Essential for readable, maintainable complex queries
  
  Key Insight:
  CTEs transform complex nested queries into readable, step-by-step logic.
  Master them for clean, professional SQL!
  
  WHAT YOU LEARNED:
  1. Simple CTEs for basic usage
  2. CTEs with aggregation (SUM, COUNT, AVG, etc.)
  3. Multiple CTEs chained together
  4. Joining CTEs with tables
  5. Using CTEs in WHERE clauses
  6. Building CTEs on other CTEs
  7. Combining CTEs with CASE statements
  8. Ranking and window functions in CTEs
  9. Recursive CTEs for hierarchies
  10. Data validation with CTEs
  11. Combining CTEs with UNION
  12. Performance comparison with alternatives
  
  KEY REMINDERS:
  1. Define CTEs with WITH clause
  2. Separate multiple CTEs with commas
  3. Reference CTE name in main query
  4. ORDER BY typically in main query only
  5. CTEs scoped to single statement
  6. Can be joined with tables/other CTEs
  7. Support recursion for hierarchies
  8. Better readability than nested subqueries
  9. Test CTEs independently
  10. Use meaningful naming conventions
  
  For more information:
  - https://dev.mysql.com/doc/refman/8.0/en/with.html
  - https://www.postgresql.org/docs/current/queries-with.html
  - Common Table Expression patterns
  - Advanced query optimization techniques
  
================================================================================
*/
