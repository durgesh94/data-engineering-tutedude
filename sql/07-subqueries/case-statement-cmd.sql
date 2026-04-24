/*
================================================================================
  SQL CASE STATEMENT COMPREHENSIVE GUIDE
================================================================================
  File: case-statement-cmd.sql
  Description: Complete tutorial on SQL CASE statements with practical examples
               using employee, department, project tables.
  
  AUTHOR: Durgesh Tambe
  CREATED: April 24, 2026
  UPDATED: April 24, 2026
  VERSION: 1.0
  
  WHAT IS A CASE STATEMENT?
  ─────────────────────────────────────────────────────────────────────────────
  A CASE statement is a conditional expression that returns different values
  based on specified conditions - like an IF-THEN-ELSE statement in programming.
  
  It's used to add conditional logic directly in SQL queries without needing
  stored procedures or application code.
  
  Think of it as:
    "IF condition1 is true, return value1
     ELSE IF condition2 is true, return value2
     ELSE return default value"
  
  Key Characteristics:
    ✓ Conditional logic within SELECT query
    ✓ Returns different values based on conditions
    ✓ Can be used in SELECT, WHERE, ORDER BY, HAVING clauses
    ✓ Can be nested inside other functions or CASE statements
    ✓ Stops evaluating at first TRUE condition (short-circuit)
    ✓ Must have ELSE clause (optional but recommended)
    ✓ All return values must be compatible data types
    ✓ More efficient than multiple IF statements
  
  Two Types of CASE Statements:
    1. SIMPLE CASE - Compares single expression to multiple values
    2. SEARCHED CASE - Evaluates multiple conditions
  
  Syntax - SIMPLE CASE:
    CASE expression
      WHEN value1 THEN result1
      WHEN value2 THEN result2
      ELSE result_default
    END
  
  Syntax - SEARCHED CASE:
    CASE
      WHEN condition1 THEN result1
      WHEN condition2 THEN result2
      ELSE result_default
    END
  
  When to use CASE STATEMENTS:
    ✓ Categorizing data (Low/Medium/High salary ranges)
    ✓ Creating status labels (Active/Inactive, Pending/Completed)
    ✓ Bonus calculations based on performance
    ✓ Assigning grades or ratings
    ✓ Data transformation and cleaning
    ✓ Creating age groups or segments
    ✓ Priority assignments
    ✓ Department or region mappings
  
  Advantages:
    ✅ Highly readable and understandable
    ✅ All logic in single query (no stored procedures needed)
    ✅ Works with aggregation functions (SUM, COUNT, etc.)
    ✅ Can be nested for complex logic
    ✅ Efficient performance
    ✅ Can be used in WHERE, ORDER BY, GROUP BY clauses
    ✅ Portable across databases
  
  Disadvantages:
    ⚠️ Can become complex with many conditions
    ⚠️ Hard to read with deep nesting
    ⚠️ Not ideal for frequently changing logic
    ⚠️ Limited to query-level logic (not like stored procedures)
  
  Database Support:
    ✅ MySQL ............ Fully supported (all versions)
    ✅ PostgreSQL ....... Fully supported
    ✅ SQL Server ....... Fully supported
    ✅ Oracle ........... Fully supported
    ✅ SQLite ........... Fully supported
  
  TABLE OF CONTENTS:
    1. SIMPLE CASE - Exact value matching
    2. SEARCHED CASE - Multiple conditions
    3. CASE with Aggregation - Conditional sums/counts
    4. CASE in WHERE - Conditional filtering
    5. CASE in ORDER BY - Conditional sorting
    6. CASE with LIKE - Pattern matching
    7. CASE with BETWEEN - Range conditions
    8. CASE with NULL - Null handling
    9. NESTED CASE - Multiple levels
    10. CASE with COALESCE - Default values
    11. CASE for Categorization - Grouping data
    12. CASE with UNION - Multiple result sets
  
  MYSQL SPECIFIC NOTES:
    - Fully supported in all MySQL versions
    - No special syntax required
    - Works with UNION queries
    - Can be used in stored procedures
    - Compatible with GROUP BY and HAVING
  
  PREREQUISITES:
    - Tables: department, employee, project, project_assignment
    - Created in sql/02-manipulation/create-cmd.sql
    - Sample data pre-populated
    
  EXECUTION:
    - Ensure tables from 02-manipulation/create-cmd.sql exist
    - Execute each example individually
    - Understand conditional logic flow
    - Notice how ELSE handles edge cases
    - Try modifying conditions for different results
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
-- 1. SIMPLE CASE - Exact Value Matching
-- ============================================================================
-- Compares single expression against multiple values
-- Returns result when value matches

-- Example 1A: Categorize employees by department
SELECT 
    employeeId,
    CONCAT(first_name, ' ', last_name) as employee_name,
    departmentId,
    salary,
    CASE departmentId
        WHEN 10 THEN 'Sales'
        WHEN 20 THEN 'Engineering'
        WHEN 30 THEN 'Finance'
        WHEN 40 THEN 'HR'
        ELSE 'Unknown'
    END as department_name,
    CASE departmentId
        WHEN 10 THEN 'Revenue Generation'
        WHEN 20 THEN 'Product Development'
        WHEN 30 THEN 'Financial Management'
        WHEN 40 THEN 'Human Resources'
        ELSE 'Other Department'
    END as department_description
FROM employee
ORDER BY departmentId, salary DESC;

-- Explanation:
-- CASE departmentId evaluates departmentId value
-- WHEN 10 THEN 'Sales' - if departmentId = 10, show 'Sales'
-- ELSE 'Unknown' - default value if no match
-- Simple CASE works best for exact value matching

-- ============================================================================
-- 1B. SIMPLE CASE - Project Status Mapping
-- ============================================================================

SELECT 
    projectId,
    project_name,
    departmentId,
    budget,
    status,
    CASE status
        WHEN 'Active' THEN 'Currently In Progress'
        WHEN 'Completed' THEN 'Project Finished'
        WHEN 'On Hold' THEN 'Project Paused'
        WHEN 'Planning' THEN 'Pre-Launch Phase'
        ELSE 'Status Unknown'
    END as status_description
FROM project
ORDER BY projectId;

-- ============================================================================
-- 2. SEARCHED CASE - Multiple Conditions
-- ============================================================================
-- Evaluates multiple complex conditions
-- Returns result when condition is TRUE

-- Example 2A: Salary classification by range
SELECT 
    employeeId,
    CONCAT(first_name, ' ', last_name) as employee_name,
    salary,
    CASE
        WHEN salary >= 100000 THEN 'Senior Level'
        WHEN salary >= 80000 THEN 'Mid Level'
        WHEN salary >= 70000 THEN 'Junior Level'
        ELSE 'Entry Level'
    END as salary_level,
    CASE
        WHEN salary >= 100000 THEN 'Tier A (Top 25%)'
        WHEN salary >= 80000 THEN 'Tier B (50-75%)'
        WHEN salary >= 70000 THEN 'Tier C (25-50%)'
        ELSE 'Tier D (Bottom 25%)'
    END as compensation_tier
FROM employee
ORDER BY salary DESC;

-- Explanation:
-- SEARCHED CASE evaluates conditions in order
-- First TRUE condition is returned
-- Subsequent conditions are skipped (short-circuit)
-- ELSE acts as default/catch-all

-- ============================================================================
-- 2B. SEARCHED CASE - Employee Performance Classification
-- ============================================================================

SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    e.salary,
    d.name as department_name,
    COUNT(pa.assignment_id) as projects_assigned,
    CASE
        WHEN e.salary > 100000 AND COUNT(pa.assignment_id) >= 2 THEN 'High Value Employee'
        WHEN e.salary > 85000 AND COUNT(pa.assignment_id) >= 1 THEN 'Key Contributor'
        WHEN e.salary >= 75000 THEN 'Regular Contributor'
        ELSE 'Entry Level'
    END as employee_category
FROM employee e
LEFT JOIN department d ON e.departmentId = d.departmentId
LEFT JOIN project_assignment pa ON e.employeeId = pa.employeeId
GROUP BY e.employeeId, e.first_name, e.last_name, e.salary, d.name
ORDER BY e.salary DESC;

-- ============================================================================
-- 3. CASE with Aggregation - Conditional Sums and Counts
-- ============================================================================
-- Sum or count only rows matching specific conditions
-- Very useful for business analytics

-- Example 3A: Count employees by salary level
SELECT 
    COUNT(*) as total_employees,
    SUM(CASE WHEN salary >= 100000 THEN 1 ELSE 0 END) as senior_count,
    SUM(CASE WHEN salary >= 80000 AND salary < 100000 THEN 1 ELSE 0 END) as mid_count,
    SUM(CASE WHEN salary >= 70000 AND salary < 80000 THEN 1 ELSE 0 END) as junior_count,
    SUM(CASE WHEN salary < 70000 THEN 1 ELSE 0 END) as entry_count
FROM employee;

-- Explanation:
-- CASE returns 1 if condition true, 0 if false
-- SUM aggregates the 1s (counts matching rows)
-- Useful for pivot-like analysis in single query

-- ============================================================================
-- 3B. CASE with Aggregation - Department Salary Analysis
-- ============================================================================

SELECT 
    d.departmentId,
    d.name as department_name,
    COUNT(*) as employee_count,
    SUM(salary) as total_salary,
    ROUND(AVG(salary), 2) as avg_salary,
    SUM(CASE WHEN salary >= 90000 THEN salary ELSE 0 END) as high_earner_total,
    COUNT(CASE WHEN salary >= 90000 THEN 1 END) as high_earner_count,
    SUM(CASE WHEN salary < 90000 THEN salary ELSE 0 END) as regular_earner_total,
    COUNT(CASE WHEN salary < 90000 THEN 1 END) as regular_earner_count
FROM employee e
RIGHT JOIN department d ON e.departmentId = d.departmentId
GROUP BY d.departmentId, d.name
ORDER BY total_salary DESC;

-- ============================================================================
-- 4. CASE in WHERE - Conditional Filtering
-- ============================================================================
-- Use CASE result to filter rows in WHERE clause
-- Useful for complex conditional logic

-- Example 4: Find high-priority employees and projects
SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    e.salary,
    e.departmentId,
    COUNT(pa.assignment_id) as project_count
FROM employee e
LEFT JOIN project_assignment pa ON e.employeeId = pa.employeeId
GROUP BY e.employeeId, e.first_name, e.last_name, e.salary, e.departmentId
HAVING CASE
    WHEN e.salary > 100000 THEN 1
    WHEN COUNT(pa.assignment_id) >= 2 THEN 1
    ELSE 0
END = 1
ORDER BY e.salary DESC;

-- Explanation:
-- CASE in HAVING returns 1 (TRUE) or 0 (FALSE)
-- HAVING clause filters based on this result
-- Rows where CASE returns 1 are included

-- ============================================================================
-- 5. CASE in ORDER BY - Conditional Sorting
-- ============================================================================
-- Sort results based on conditional values
-- Useful for custom sort orders

-- Example 5A: Order employees by priority
SELECT 
    employeeId,
    CONCAT(first_name, ' ', last_name) as employee_name,
    departmentId,
    salary
FROM employee
ORDER BY 
    CASE
        WHEN departmentId = 20 THEN 1  -- Engineering first
        WHEN departmentId = 10 THEN 2  -- Sales second
        WHEN departmentId = 30 THEN 3  -- Finance third
        ELSE 4                         -- Others last
    END,
    salary DESC;

-- Explanation:
-- CASE assigns numeric values (1,2,3,4)
-- ORDER BY sorts by these numeric values
-- Allows custom sort order without changing data

-- ============================================================================
-- 5B. CASE in ORDER BY - Sort by Salary Tier
-- ============================================================================

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
ORDER BY 
    CASE
        WHEN salary >= 100000 THEN 1
        WHEN salary >= 80000 THEN 2
        ELSE 3
    END,
    salary DESC;

-- ============================================================================
-- 6. CASE with LIKE - Pattern Matching
-- ============================================================================
-- Categorize based on text pattern matching

-- Example 6: Categorize emails by domain
SELECT 
    employeeId,
    CONCAT(first_name, ' ', last_name) as employee_name,
    email,
    CASE
        WHEN email LIKE '%@company.com%' THEN 'Company Domain'
        WHEN email LIKE '%@gmail.com%' THEN 'Gmail'
        WHEN email LIKE '%@yahoo.com%' THEN 'Yahoo'
        WHEN email LIKE '%@hotmail.com%' THEN 'Hotmail'
        ELSE 'Other Domain'
    END as email_provider
FROM employee
ORDER BY email_provider;

-- ============================================================================
-- 7. CASE with BETWEEN - Range Conditions
-- ============================================================================
-- Categorize data into ranges

-- Example 7: Project budget classification
SELECT 
    projectId,
    project_name,
    budget,
    CASE
        WHEN budget BETWEEN 0 AND 50000 THEN 'Small Budget'
        WHEN budget BETWEEN 50000 AND 150000 THEN 'Medium Budget'
        WHEN budget BETWEEN 150000 AND 300000 THEN 'Large Budget'
        ELSE 'Enterprise Budget'
    END as budget_category,
    CASE
        WHEN budget < 100000 THEN 'Low Cost'
        WHEN budget BETWEEN 100000 AND 200000 THEN 'Medium Cost'
        ELSE 'Premium Cost'
    END as cost_level
FROM project
ORDER BY budget DESC;

-- ============================================================================
-- 8. CASE with NULL - Null Handling
-- ============================================================================
-- Explicitly handle NULL values in conditions

-- Example 8: Handle missing project end dates
SELECT 
    projectId,
    project_name,
    start_date,
    end_date,
    budget,
    CASE
        WHEN end_date IS NULL THEN 'Ongoing'
        WHEN end_date > CURDATE() THEN 'In Progress'
        WHEN end_date = CURDATE() THEN 'Ends Today'
        ELSE 'Completed'
    END as project_status
FROM project
ORDER BY projectId;

-- Explanation:
-- CASE handles NULL explicitly with IS NULL
-- Important for avoiding unexpected results

-- ============================================================================
-- 9. NESTED CASE - Multiple Levels
-- ============================================================================
-- CASE statements within CASE statements
-- Useful for complex multi-level categorization

-- Example 9: Complex employee classification
SELECT 
    employeeId,
    CONCAT(first_name, ' ', last_name) as employee_name,
    salary,
    departmentId,
    CASE
        WHEN departmentId = 20 THEN
            CASE
                WHEN salary >= 110000 THEN 'Senior Engineer'
                WHEN salary >= 90000 THEN 'Mid-Level Engineer'
                ELSE 'Junior Engineer'
            END
        WHEN departmentId = 10 THEN
            CASE
                WHEN salary >= 100000 THEN 'Senior Sales'
                WHEN salary >= 80000 THEN 'Sales Manager'
                ELSE 'Sales Associate'
            END
        ELSE
            CASE
                WHEN salary >= 90000 THEN 'Senior Staff'
                WHEN salary >= 75000 THEN 'Regular Staff'
                ELSE 'Junior Staff'
            END
    END as job_title
FROM employee
ORDER BY departmentId, salary DESC;

-- Explanation:
-- Outer CASE checks department
-- Inner CASE based on salary within each department
-- Creates department-specific classifications

-- ============================================================================
-- 10. CASE with COALESCE - Default Values
-- ============================================================================
-- Combine CASE with COALESCE for null handling

-- Example 10: Show employee with project assignments or default
SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    COALESCE(p.project_name, 'No Project') as project_name,
    CASE
        WHEN p.projectId IS NOT NULL THEN
            CASE
                WHEN pa.role IS NOT NULL THEN pa.role
                ELSE 'Unassigned Role'
            END
        ELSE 'Not Assigned'
    END as assignment_status
FROM employee e
LEFT JOIN project_assignment pa ON e.employeeId = pa.employeeId
LEFT JOIN project p ON pa.projectId = p.projectId
ORDER BY e.employeeId;

-- ============================================================================
-- 11. CASE for Categorization - Data Segmentation
-- ============================================================================
-- Create customer/employee segments for analysis

-- Example 11: Employee segmentation for HR analysis
SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    e.salary,
    d.name as department_name,
    COUNT(pa.assignment_id) as projects_count,
    CASE
        WHEN COUNT(pa.assignment_id) = 0 THEN 'Unassigned'
        WHEN COUNT(pa.assignment_id) >= 3 THEN 'Overallocated'
        WHEN COUNT(pa.assignment_id) >= 1 THEN 'Allocated'
        ELSE 'Unassigned'
    END as allocation_status,
    CASE
        WHEN e.salary >= 100000 AND COUNT(pa.assignment_id) >= 2 THEN 'Premium'
        WHEN e.salary >= 80000 THEN 'Standard'
        ELSE 'Economy'
    END as employee_segment
FROM employee e
LEFT JOIN department d ON e.departmentId = d.departmentId
LEFT JOIN project_assignment pa ON e.employeeId = pa.employeeId
GROUP BY e.employeeId, e.first_name, e.last_name, e.salary, d.name
ORDER BY employee_segment, e.salary DESC;

-- ============================================================================
-- 12. CASE with UNION - Multiple Result Sets
-- ============================================================================
-- Use CASE to create unified views from different sources

-- Example 12: Unified employee report with multiple metrics
SELECT 
    'High Earners' as category,
    employeeId,
    CONCAT(first_name, ' ', last_name) as name,
    salary,
    CASE
        WHEN salary >= 100000 THEN 'Executive'
        WHEN salary >= 90000 THEN 'Senior'
        ELSE 'Mid'
    END as level
FROM employee
WHERE salary >= 90000

UNION

SELECT 
    'All Employees' as category,
    employeeId,
    CONCAT(first_name, ' ', last_name) as name,
    salary,
    CASE
        WHEN salary >= 100000 THEN 'Executive'
        WHEN salary >= 80000 THEN 'Senior'
        WHEN salary >= 70000 THEN 'Mid'
        ELSE 'Junior'
    END as level
FROM employee

ORDER BY category, salary DESC;

-- ============================================================================
-- PRACTICE QUESTIONS
-- ============================================================================
-- Answer these using CASE STATEMENTS:
--
-- Q1: Classify employees as "High", "Medium", "Low" earners
-- Q2: Create bonus categories (No Bonus, 5%, 10%, 15%)
-- Q3: Assign project priority based on budget (Critical, High, Medium, Low)
-- Q4: Create tenure categories (New, Regular, Senior)
-- Q5: Classify projects as "On Time", "At Risk", "Delayed"
-- Q6: Create performance tiers based on projects assigned
-- Q7: Categorize departments by average salary
-- Q8: Create allocation status (Underutilized, Optimal, Overallocated)
-- Q9: Flag employees needing raises (>10 years, salary <80000)
-- Q10: Create executive bonus scenarios based on salary and department

-- ============================================================================
-- KEY POINTS ABOUT CASE STATEMENTS
-- ============================================================================
-- ✓ Two types: SIMPLE (exact match) and SEARCHED (conditions)
-- ✓ Evaluates conditions in order (top to bottom)
-- ✓ Stops at FIRST TRUE condition (short-circuit)
-- ✓ ELSE clause provides default (optional but recommended)
-- ✓ Return values must be compatible data types
-- ✓ Can be nested multiple levels
-- ✓ Works with aggregation (SUM, COUNT, AVG, etc.)
-- ✓ Can be used in SELECT, WHERE, ORDER BY, HAVING, GROUP BY
-- ✓ Entire expression in parentheses when complex
-- ✓ NULL-safe (use IS NULL for null checks)

-- ============================================================================
-- COMMON MISTAKES TO AVOID
-- ============================================================================
-- MISTAKE 1: Forgetting ELSE clause
-- WRONG:  CASE WHEN salary > 100000 THEN 'High' END
--         (Returns NULL if condition false)
-- RIGHT:  CASE WHEN salary > 100000 THEN 'High' ELSE 'Low' END

-- MISTAKE 2: Incompatible data types in THEN/ELSE
-- WRONG:  CASE WHEN x > 5 THEN 'High' ELSE 100 END
--         (String vs Number - MySQL may convert)
-- RIGHT:  CASE WHEN x > 5 THEN 'High' ELSE 'Low' END

-- MISTAKE 3: Not considering NULL values
-- WRONG:  CASE WHEN salary = 90000 THEN 'Exact' ELSE 'Other' END
--         (NULL salary evaluates to NULL, not 'Other')
-- RIGHT:  CASE WHEN salary IS NULL THEN 'Unknown' 
--              WHEN salary = 90000 THEN 'Exact' ELSE 'Other' END

-- MISTAKE 4: Wrong operator precedence in complex conditions
-- WRONG:  CASE WHEN a > 5 OR b < 10 AND c = 'test' THEN 'Yes' END
--         (AND evaluated before OR - unexpected results)
-- RIGHT:  CASE WHEN (a > 5) OR (b < 10 AND c = 'test') THEN 'Yes' END

-- MISTAKE 5: CASE evaluated before aggregation
-- WRONG:  SELECT CASE WHEN COUNT(*) > 10 THEN 'Many' ELSE 'Few' END
--         (Error: aggregation in WHEN)
-- RIGHT:  SELECT COUNT(*) as cnt, CASE WHEN COUNT(*) > 10 THEN 'Many' ELSE 'Few' END

-- ============================================================================
-- COMPARISON: CASE vs IF() vs COALESCE
-- ============================================================================
--
-- CASE:
--   When: Multiple conditions, readable, complex logic
--   Pros: Most flexible, handles multiple conditions
--   Cons: More syntax
--
-- IF():
--   When: Simple true/false conditions
--   Pros: Concise for simple cases
--   Cons: Only MySQL, not portable, limited nesting
--
-- COALESCE:
--   When: Null handling only
--   Pros: Specific for NULL values
--   Cons: Not for complex conditions

-- ============================================================================
-- PERFORMANCE CONSIDERATIONS
-- ============================================================================
--
-- CASE Performance:
--   ✅ Very efficient (minimal overhead)
--   ✓ Executes in single pass (no separate queries)
--   ✓ Better than stored procedures for simple logic
--   ✓ Can prevent unnecessary JOINs
--
-- Tips:
--   1. Put most common conditions first (short-circuit)
--   2. Use BETWEEN instead of multiple conditions
--   3. Avoid complex function calls in CASE expressions
--   4. Use WITH clause for reusable CASE logic

-- ============================================================================
-- BEST PRACTICES FOR CASE STATEMENTS
-- ============================================================================
--
-- 1. Always include ELSE clause
--    Handles unexpected values gracefully
--
-- 2. Keep conditions simple and readable
--    Break complex logic into subqueries
--
-- 3. Order conditions by frequency
--    Most common first (performance optimization)
--
-- 4. Use meaningful aliases
--    CASE ... END as salary_category
--
-- 5. Document complex logic
--    Add comments explaining business rules
--
-- 6. Test edge cases
--    NULL values, boundary conditions, etc.
--
-- 7. Consider case sensitivity for strings
--    Use UPPER() or LOWER() for consistent comparison
--
-- 8. Use data types wisely
--    Ensure all THEN/ELSE values are compatible
--
-- 9. Avoid multiple CASE statements for same data
--    Create derived table/CTE instead
--
-- 10. Use CASE instead of complex WHERE
--     Clearer logic, easier to maintain

-- ============================================================================
-- DATABASE COMPATIBILITY
-- ============================================================================
--
-- CASE Statements supported in ALL major databases:
--   ✅ MySQL - All versions
--   ✅ PostgreSQL - All versions
--   ✅ SQL Server - All versions
--   ✅ Oracle - All versions
--   ✅ SQLite - All versions
--
-- All syntax is identical across databases

-- ============================================================================
-- NOTES
-- ============================================================================
-- These queries use existing tables from sql/02-manipulation/create-cmd.sql
-- Do NOT drop these tables as they are referenced by multiple tutorial files
-- 
-- If you want to reset the data, re-run insert-cmd.sql from 02-manipulation folder

/*
================================================================================
  END OF CASE STATEMENT GUIDE
================================================================================
  Summary:
  - CASE: Conditional logic within queries
  - Two types: SIMPLE (exact match) and SEARCHED (conditions)
  - Returns different values based on conditions
  - Essential for data categorization and transformation
  
  Key Insight:
  CASE statements are powerful for adding business logic to queries.
  Master them for complex data analysis without stored procedures!
  
  WHAT YOU LEARNED:
  1. Simple CASE for exact value matching
  2. Searched CASE for complex conditions
  3. CASE with aggregation functions
  4. CASE in WHERE and ORDER BY clauses
  5. CASE with pattern matching (LIKE)
  6. CASE with range conditions (BETWEEN)
  7. NULL handling in CASE statements
  8. Nested CASE for multi-level logic
  9. CASE with COALESCE for defaults
  10. CASE for data segmentation
  11. CASE with UNION for multiple result sets
  12. Performance optimization techniques
  
  KEY REMINDERS:
  1. Include ELSE clause for default values
  2. Order conditions by frequency
  3. Use compatible data types in THEN/ELSE
  4. Handle NULL explicitly
  5. Keep logic readable and simple
  6. Comment complex business rules
  7. Use with aggregation for analytics
  8. Test edge cases and boundaries
  9. Consider performance optimization
  10. Maintain consistent data types
  
  For more information:
  - https://dev.mysql.com/doc/refman/8.0/en/flow-control-functions.html
  - https://www.w3schools.com/sql/sql_case.asp
  - SQL conditional logic patterns
  - Advanced analytics techniques
  
================================================================================
*/
