/*
================================================================================
  SQL LIMIT & SELECT WITH EXPRESSIONS - Tutorial
================================================================================
  Description: Master SQL LIMIT clause to restrict result rows and SELECT with
               mathematical expressions, string functions, and calculated
               fields. Learn how to perform calculations, manipulate data in
               queries, and return custom results
  
  SCHEMA OVERVIEW:
    - department: departmentId (PK), name, manager_email
    - employee: employeeId (PK), first_name, last_name, email, salary, departmentId (FK)
    - project: projectId (PK), project_name, description, start_date, end_date, 
               budget, departmentId (FK), status
    - project_assignment: assignment_id (PK), employeeId (FK), projectId (FK), 
                          role, allocation_percentage, assignment_date
  
  LEARNING OBJECTIVES:
    - Use LIMIT to restrict number of rows returned
    - Use OFFSET for pagination (skip rows)
    - Combine LIMIT with ORDER BY for meaningful results
    - Create calculated fields in SELECT
    - Use mathematical expressions (arithmetic operations)
    - Use string functions (CONCAT, UPPER, LOWER, SUBSTRING)
    - Use date functions (DATE_ADD, DATE_SUB, DATEDIFF)
    - Perform conditional expressions (CASE statements)
    - Combine expressions with aliases for clarity
    - Create derived columns that don't exist in table
  
  ⚠️  KEY CONCEPTS ⚠️
    - LIMIT returns only specified number of rows (0 = no limit)
    - OFFSET skips first N rows (used for pagination)
    - LIMIT 10 OFFSET 5 = skip first 5, return next 10
    - SELECT expressions don't modify database, only query output
    - Expressions can use: math operators, functions, CASE statements
    - NULL in expressions: Any operation with NULL results in NULL
    - Aliases make expressions more readable and referenceable
    - LIMIT is always the last clause in SELECT statement
================================================================================
*/

-- ===============================================
-- PART 1: LIMIT - BASIC USAGE
-- ===============================================

-- ===============================================
-- 1. LIMIT - Return specific number of rows
-- ===============================================
-- Get first 3 employees

SELECT employeeId, first_name, last_name, salary
FROM employee
LIMIT 3;

-- Get first 5 projects
SELECT projectId, project_name, budget, status
FROM project
LIMIT 5;

-- Get first 2 departments
SELECT departmentId, name, manager_email
FROM department
LIMIT 2;

-- ===============================================
-- 2. LIMIT - With ORDER BY for meaningful results
-- ===============================================
-- Get top 3 highest paid employees

SELECT employeeId, first_name, last_name, salary
FROM employee
ORDER BY salary DESC
LIMIT 3;

-- Get top 3 projects by budget
SELECT projectId, project_name, budget, status
FROM project
ORDER BY budget DESC
LIMIT 3;

-- Get bottom 2 lowest paid employees
SELECT employeeId, first_name, last_name, salary
FROM employee
ORDER BY salary ASC
LIMIT 2;

-- ===============================================
-- 3. LIMIT - Return all rows (0 means no limit)
-- ===============================================
-- Return all employees (LIMIT 0)

SELECT employeeId, first_name, last_name, salary
FROM employee
LIMIT 0;

-- No limit is same as no LIMIT clause
SELECT employeeId, first_name, last_name, salary
FROM employee;

-- ===============================================
-- 4. LIMIT - OFFSET for pagination
-- ===============================================
-- Skip first 2 rows, get next 3 rows (rows 3-5)

SELECT employeeId, first_name, last_name, salary
FROM employee
LIMIT 3 OFFSET 2;

-- Skip first 3 projects, get next 2
SELECT projectId, project_name, budget
FROM project
LIMIT 2 OFFSET 3;

-- ===============================================
-- 5. LIMIT - Common pagination pattern
-- ===============================================
-- Page 1: show rows 1-3

SELECT employeeId, first_name, last_name, salary
FROM employee
ORDER BY employeeId
LIMIT 3 OFFSET 0;

-- Page 2: show rows 4-6 (skip first 3)
SELECT employeeId, first_name, last_name, salary
FROM employee
ORDER BY employeeId
LIMIT 3 OFFSET 3;

-- Page 3: show rows 7-9 (skip first 6)
SELECT employeeId, first_name, last_name, salary
FROM employee
ORDER BY employeeId
LIMIT 3 OFFSET 6;

-- ===============================================
-- 6. LIMIT - With WHERE clause
-- ===============================================
-- Get first 2 high-salaried employees (>55000)

SELECT employeeId, first_name, last_name, salary
FROM employee
WHERE salary > 55000
LIMIT 2;

-- Get first 3 active projects
SELECT projectId, project_name, budget, status
FROM project
WHERE status = 'Active'
LIMIT 3;

-- ===============================================
-- PART 2: SELECT WITH EXPRESSIONS - MATH OPERATIONS
-- ===============================================

-- ===============================================
-- 7. SELECT with EXPRESSION - Basic arithmetic
-- ===============================================
-- Calculate monthly salary and annual bonus

SELECT 
  employeeId,
  first_name,
  last_name,
  salary,
  salary / 12 AS monthly_salary,
  salary * 0.10 AS annual_bonus,
  salary + salary * 0.10 AS total_with_bonus
FROM employee;

-- Calculate project costs: daily budget
SELECT 
  projectId,
  project_name,
  budget,
  DATEDIFF(end_date, start_date) AS days_duration,
  budget / DATEDIFF(end_date, start_date) AS daily_budget_rate
FROM project;

-- ===============================================
-- 8. SELECT with EXPRESSION - Percentage calculations
-- ===============================================
-- Calculate budget percentages and allocations

SELECT 
  projectId,
  project_name,
  budget,
  budget * 0.20 AS twenty_percent_reserve,
  budget * 0.80 AS eighty_percent_available,
  (budget * 0.20) AS contingency_fund
FROM project;

-- Calculate employee allocation percentage of department budget
SELECT 
  e.employeeId,
  e.first_name,
  e.salary,
  d.departmentId,
  d.name,
  (e.salary / 60000) * 100 AS percentage_of_avg_salary
FROM employee e
JOIN department d ON e.departmentId = d.departmentId;

-- ===============================================
-- 9. SELECT with EXPRESSION - Complex calculations
-- ===============================================
-- Calculate employee effectiveness score

SELECT 
  e.employeeId,
  CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
  e.salary,
  COUNT(pa.assignment_id) AS projects_assigned,
  (e.salary / (COUNT(pa.assignment_id) + 1)) * 1000 AS cost_per_project
FROM employee e
LEFT JOIN project_assignment pa ON e.employeeId = pa.employeeId
GROUP BY e.employeeId, e.first_name, e.last_name, e.salary;

-- ===============================================
-- PART 3: SELECT WITH EXPRESSIONS - STRING FUNCTIONS
-- ===============================================

-- ===============================================
-- 10. SELECT with EXPRESSION - CONCAT (combine strings)
-- ===============================================
-- Combine first and last names

SELECT 
  employeeId,
  CONCAT(first_name, ' ', last_name) AS full_name,
  CONCAT(first_name, '.', last_name) AS email_prefix,
  email
FROM employee;

-- Create greeting messages
SELECT 
  employeeId,
  CONCAT('Welcome ', first_name, '!') AS greeting,
  CONCAT('Contact: ', email) AS contact_info
FROM employee;

-- Create project description with status
SELECT 
  projectId,
  CONCAT(project_name, ' (', status, ')') AS project_info,
  CONCAT('Budget: $', budget) AS budget_display
FROM project;

-- ===============================================
-- 11. SELECT with EXPRESSION - UPPER, LOWER
-- ===============================================
-- Change string case

SELECT 
  employeeId,
  first_name,
  last_name,
  UPPER(first_name) AS uppercase_first,
  LOWER(last_name) AS lowercase_last,
  UPPER(CONCAT(first_name, ' ', last_name)) AS uppercase_full_name
FROM employee;

-- Project names in different cases
SELECT 
  projectId,
  project_name,
  UPPER(project_name) AS project_uppercase,
  LOWER(project_name) AS project_lowercase
FROM project;

-- ===============================================
-- 12. SELECT with EXPRESSION - SUBSTRING (extract part of string)
-- ===============================================
-- Extract portions of strings

SELECT 
  employeeId,
  first_name,
  SUBSTRING(first_name, 1, 1) AS first_initial,
  last_name,
  SUBSTRING(last_name, 1, 3) AS last_three,
  email,
  SUBSTRING(email, 1, POSITION('@' IN email) - 1) AS username
FROM employee;

-- Project name abbreviations
SELECT 
  projectId,
  project_name,
  SUBSTRING(project_name, 1, 3) AS abbreviation,
  SUBSTRING(project_name, 1, 10) AS short_name
FROM project;

-- ===============================================
-- 13. SELECT with EXPRESSION - String manipulation combinations
-- ===============================================
-- Combine multiple string functions

SELECT 
  employeeId,
  CONCAT(UPPER(SUBSTRING(first_name, 1, 1)), LOWER(SUBSTRING(first_name, 2))) AS capitalized_first,
  CONCAT(UPPER(SUBSTRING(last_name, 1, 1)), LOWER(SUBSTRING(last_name, 2))) AS capitalized_last,
  CONCAT(UPPER(SUBSTRING(first_name, 1, 1)), LOWER(SUBSTRING(last_name, 1, 4))) AS initials_code
FROM employee;

-- ===============================================
-- PART 4: SELECT WITH EXPRESSIONS - DATE FUNCTIONS
-- ===============================================

-- ===============================================
-- 14. SELECT with EXPRESSION - DATEDIFF
-- ===============================================
-- Calculate date differences

SELECT 
  projectId,
  project_name,
  start_date,
  end_date,
  DATEDIFF(end_date, start_date) AS duration_days,
  DATEDIFF(end_date, start_date) / 7 AS duration_weeks,
  DATEDIFF(end_date, start_date) / 30 AS duration_months
FROM project;

-- Calculate work days since assignment
SELECT 
  assignment_id,
  employeeId,
  projectId,
  assignment_date,
  DATEDIFF(CURDATE(), assignment_date) AS days_assigned,
  DATEDIFF(CURDATE(), assignment_date) / 365 AS years_assigned
FROM project_assignment
ORDER BY assignment_date ASC;

-- ===============================================
-- 15. SELECT with EXPRESSION - DATE_ADD, DATE_SUB
-- ===============================================
-- Calculate future and past dates

SELECT 
  projectId,
  project_name,
  start_date,
  end_date,
  DATE_ADD(end_date, INTERVAL 7 DAY) AS end_plus_one_week,
  DATE_ADD(end_date, INTERVAL 30 DAY) AS deadline_plus_month,
  DATE_SUB(start_date, INTERVAL 5 DAY) AS preparation_day
FROM project;

-- Calculate review dates
SELECT 
  assignment_id,
  employeeId,
  assignment_date,
  DATE_ADD(assignment_date, INTERVAL 30 DAY) AS thirty_day_review,
  DATE_ADD(assignment_date, INTERVAL 90 DAY) AS ninety_day_review,
  DATE_ADD(assignment_date, INTERVAL 1 YEAR) AS one_year_review
FROM project_assignment;

-- ===============================================
-- 16. SELECT with EXPRESSION - Complex date calculations
-- ===============================================
-- Calculate project status timeline

SELECT 
  projectId,
  project_name,
  start_date,
  end_date,
  status,
  DATEDIFF(end_date, start_date) AS total_days,
  DATEDIFF(CURDATE(), start_date) AS days_elapsed,
  DATEDIFF(end_date, CURDATE()) AS days_remaining,
  CASE 
    WHEN CURDATE() < start_date THEN 'Not Started'
    WHEN CURDATE() > end_date THEN 'Overdue'
    ELSE CONCAT(DATEDIFF(end_date, CURDATE()), ' days left')
  END AS status_message
FROM project;

-- ===============================================
-- PART 5: SELECT WITH EXPRESSIONS - CONDITIONAL (CASE)
-- ===============================================

-- ===============================================
-- 17. SELECT with EXPRESSION - CASE statements
-- ===============================================
-- Use CASE for conditional logic

SELECT 
  employeeId,
  first_name,
  last_name,
  salary,
  CASE 
    WHEN salary < 52000 THEN 'Junior'
    WHEN salary < 58000 THEN 'Mid-Level'
    ELSE 'Senior'
  END AS experience_level
FROM employee;

-- Project status categorization
SELECT 
  projectId,
  project_name,
  status,
  budget,
  CASE 
    WHEN status = 'Active' THEN 'In Progress'
    WHEN status = 'Completed' THEN 'Finished'
    WHEN status = 'On Hold' THEN 'Paused'
    ELSE 'Unknown'
  END AS project_status_desc,
  CASE 
    WHEN budget >= 250000 THEN 'High Budget'
    WHEN budget >= 150000 THEN 'Medium Budget'
    ELSE 'Low Budget'
  END AS budget_category
FROM project;

-- ===============================================
-- 18. SELECT with EXPRESSION - Multiple CASE statements
-- ===============================================
-- Complex conditional expressions

SELECT 
  employeeId,
  first_name,
  last_name,
  salary,
  CASE 
    WHEN salary >= 65000 THEN 'A'
    WHEN salary >= 55000 THEN 'B'
    WHEN salary >= 50000 THEN 'C'
    ELSE 'D'
  END AS salary_grade,
  CASE 
    WHEN salary > 60000 THEN salary * 0.15
    WHEN salary > 55000 THEN salary * 0.12
    ELSE salary * 0.10
  END AS bonus_amount
FROM employee;

-- Project risk assessment
SELECT 
  projectId,
  project_name,
  budget,
  DATEDIFF(end_date, CURDATE()) AS days_remaining,
  CASE 
    WHEN DATEDIFF(end_date, CURDATE()) < 0 THEN 'Critical - Overdue'
    WHEN DATEDIFF(end_date, CURDATE()) < 7 THEN 'High - Due Soon'
    WHEN DATEDIFF(end_date, CURDATE()) < 30 THEN 'Medium - On Track'
    ELSE 'Low - Plenty of Time'
  END AS timeline_risk,
  CASE 
    WHEN status = 'Completed' THEN 'Complete'
    WHEN status = 'Active' AND DATEDIFF(end_date, CURDATE()) > 0 THEN 'Good Progress'
    WHEN status = 'On Hold' THEN 'Requires Attention'
    ELSE 'Monitor'
  END AS action_required
FROM project;

-- ===============================================
-- PART 6: COMBINING LIMIT WITH EXPRESSIONS
-- ===============================================

-- ===============================================
-- 19. LIMIT with ORDER BY and expressions
-- ===============================================
-- Get top 3 employees by monthly income

SELECT 
  employeeId,
  CONCAT(first_name, ' ', last_name) AS employee_name,
  salary,
  salary / 12 AS monthly_salary,
  salary * 0.10 AS annual_bonus
FROM employee
ORDER BY salary DESC
LIMIT 3;

-- Get first 5 longest projects
SELECT 
  projectId,
  project_name,
  start_date,
  end_date,
  DATEDIFF(end_date, start_date) AS duration_days,
  budget,
  budget / DATEDIFF(end_date, start_date) AS daily_rate
FROM project
ORDER BY DATEDIFF(end_date, start_date) DESC
LIMIT 5;

-- ===============================================
-- 20. LIMIT with OFFSET and expressions
-- ===============================================
-- Paginate results with calculated fields

-- Page 1: first 3 employees with salary analysis
SELECT 
  employeeId,
  first_name,
  last_name,
  salary,
  salary / 12 AS monthly_salary,
  salary * 1.05 AS salary_with_raise
FROM employee
ORDER BY salary DESC
LIMIT 3 OFFSET 0;

-- Page 2: next 3 employees with salary analysis
SELECT 
  employeeId,
  first_name,
  last_name,
  salary,
  salary / 12 AS monthly_salary,
  salary * 1.05 AS salary_with_raise
FROM employee
ORDER BY salary DESC
LIMIT 3 OFFSET 3;

-- ===============================================
-- 21. Complex expressions with LIMIT
-- ===============================================
-- Get top 2 most expensive projects by total calculated cost

SELECT 
  projectId,
  project_name,
  start_date,
  end_date,
  budget,
  DATEDIFF(end_date, start_date) AS days,
  budget / DATEDIFF(end_date, start_date) AS daily_cost,
  CASE 
    WHEN budget >= 250000 THEN 'Premium'
    ELSE 'Standard'
  END AS project_tier
FROM project
ORDER BY budget DESC
LIMIT 2;

-- Get first 3 employees due for review (earliest assignment date)
SELECT 
  pa.assignment_id,
  e.employeeId,
  CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
  pa.role,
  pa.assignment_date,
  DATEDIFF(CURDATE(), pa.assignment_date) AS days_assigned,
  DATE_ADD(pa.assignment_date, INTERVAL 90 DAY) AS review_date,
  CASE 
    WHEN DATEDIFF(CURDATE(), pa.assignment_date) >= 90 THEN 'Review Due'
    ELSE 'Pending'
  END AS review_status
FROM project_assignment pa
JOIN employee e ON pa.employeeId = e.employeeId
ORDER BY pa.assignment_date ASC
LIMIT 3;

-- ===============================================
-- QUICK REFERENCE - LIMIT SYNTAX
-- ===============================================
/*
LIMIT Syntax:
  SELECT columns FROM table LIMIT number_of_rows;
  SELECT columns FROM table LIMIT number_of_rows OFFSET offset_rows;
  SELECT columns FROM table WHERE ... LIMIT num OFFSET offset;

  LIMIT 10 = Return first 10 rows
  LIMIT 10 OFFSET 5 = Skip first 5 rows, return next 10
  Often used as: LIMIT num, offset (MySQL alternative syntax)

Common Uses:
  - Pagination (display results on pages)
  - Top N queries (highest, lowest, first, last)
  - Testing: Run query with LIMIT before processing all rows
  - Performance: Reduce result set for testing

Performance Notes:
  - LIMIT is evaluated LAST (after ORDER BY)
  - Always use ORDER BY with LIMIT for consistent results
  - Pagination: Calculate OFFSET = (page_number - 1) * page_size
*/

-- ===============================================
-- QUICK REFERENCE - SELECT EXPRESSIONS
-- ===============================================
/*
Math Operations:
  salary * 1.10 = 10% increase
  salary / 12 = monthly amount
  budget - expenses = remaining
  price * quantity = total
  column1 + column2 = sum of columns

String Functions:
  CONCAT(col1, col2) = combine strings
  UPPER(column) = convert to uppercase
  LOWER(column) = convert to lowercase
  SUBSTRING(column, start, length) = extract portion
  LENGTH(column) = count characters
  TRIM(column) = remove leading/trailing spaces

Date Functions:
  DATEDIFF(date1, date2) = difference in days
  DATE_ADD(date, INTERVAL n DAY) = add days
  DATE_ADD(date, INTERVAL n MONTH) = add months
  DATE_SUB(date, INTERVAL n DAY) = subtract days
  CURDATE() = today's date
  NOW() = current date and time

Conditional (CASE):
  CASE WHEN condition THEN value WHEN ... ELSE default END
  Used for: categorization, classifications, logic
  Each WHEN is evaluated in order
  Best for: grouping ranges, categorizing values

NULL Handling:
  Any operation with NULL results in NULL
  salary * 1.05 where salary is NULL = NULL
  Use COALESCE(column, default) to handle NULL
*/

-- ===============================================
-- KEY POINTS & BEST PRACTICES
-- ===============================================
/*
1. LIMIT must be the LAST clause in SELECT statement
2. Always combine LIMIT with ORDER BY for meaningful results
3. OFFSET is used for pagination: OFFSET = (page - 1) * page_size
4. Test queries with LIMIT during development (faster)
5. Remove LIMIT when going to production (if full results needed)

6. SELECT expressions don't modify database tables
7. Result of expression can have NULL if any operand is NULL
8. Aliases make expressions readable: use meaningful names
9. Can reference expressions in ORDER BY using alias
10. Can use expressions in WHERE clause if needed

11. CONCAT is preferred over || in MySQL (|| is OR operator)
12. CASE statements: evaluate conditions in order (first match wins)
13. CASE ELSE clause is optional (defaults to NULL if no match)
14. Date functions vary by database (test syntax in your system)
15. Always validate calculations match business logic

16. Performance: Expressions in WHERE are evaluated before SELECT
17. Performance: Use indexes on columns before expressions
18. Pagination: Always include ORDER BY for consistency
19. Expressions in SELECT are evaluated for every row (cost!)
20. Complex expressions: test in smaller queries first
*/

-- ===============================================
-- PRACTICE EXAMPLES - Uncomment to use
-- ===============================================

-- Example 1: Get top 5 highest paid employees
-- SELECT employeeId, CONCAT(first_name, ' ', last_name) AS name, salary, salary / 12 AS monthly FROM employee ORDER BY salary DESC LIMIT 5;

-- Example 2: Get first 3 projects with duration calculation
-- SELECT projectId, project_name, DATEDIFF(end_date, start_date) AS duration_days FROM project LIMIT 3;

-- Example 3: Get employees with salary grades (page 1)
-- SELECT employeeId, first_name, salary, CASE WHEN salary >= 65000 THEN 'A' WHEN salary >= 55000 THEN 'B' ELSE 'C' END AS grade FROM employee ORDER BY salary DESC LIMIT 3 OFFSET 0;

-- Example 4: Paginate projects (page 2, 2 per page)
-- SELECT projectId, project_name, budget, status FROM project ORDER BY projectId LIMIT 2 OFFSET 2;

-- Example 5: Calculate bonus for top 2 employees
-- SELECT employeeId, CONCAT(first_name, ' ', last_name), salary, salary * 0.15 AS bonus_15pct FROM employee ORDER BY salary DESC LIMIT 2;

-- Example 6: Find overdue projects
-- SELECT projectId, project_name, end_date, DATEDIFF(CURDATE(), end_date) AS days_overdue FROM project WHERE end_date < CURDATE() LIMIT 5;

-- Example 7: Complex expression - employee efficiency score
-- SELECT employeeId, CONCAT(first_name, ' ', last_name) AS name, COUNT(pa.assignment_id) AS project_count, CASE WHEN COUNT(pa.assignment_id) >= 3 THEN 'High' WHEN COUNT(pa.assignment_id) >= 1 THEN 'Medium' ELSE 'Low' END AS utilization FROM employee e LEFT JOIN project_assignment pa ON e.employeeId = pa.employeeId GROUP BY e.employeeId ORDER BY project_count DESC LIMIT 3;
