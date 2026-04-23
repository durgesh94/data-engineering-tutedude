/*
================================================================================
  SQL AGGREGATION FUNCTIONS - Tutorial
================================================================================
  Description: Master SQL aggregation functions to summarize and analyze data.
               Learn COUNT, SUM, AVG, MIN, MAX with GROUP BY and HAVING clauses.
               Create business reports and analytical queries to extract insights
               from raw data through aggregation and grouping
  
  SCHEMA OVERVIEW:
    - department: departmentId (PK), name, manager_email
    - employee: employeeId (PK), first_name, last_name, email, salary, departmentId (FK)
    - project: projectId (PK), project_name, description, start_date, end_date, 
               budget, departmentId (FK), status
    - project_assignment: assignment_id (PK), employeeId (FK), projectId (FK), 
                          role, allocation_percentage, assignment_date
  
  LEARNING OBJECTIVES:
    - Use COUNT() to count rows and distinct values
    - Use SUM() to total numeric values
    - Use AVG() to calculate averages
    - Use MIN() and MAX() to find extremes
    - Use GROUP BY to organize data into groups
    - Use HAVING to filter aggregated results
    - Combine multiple aggregation functions
    - Create business reports and dashboards
    - Apply aggregations with JOINs for complex analysis
    - Use DISTINCT within aggregation functions
    - Optimize aggregation queries for performance
  
  ⚠️  KEY CONCEPTS ⚠️
    - Aggregation functions process multiple rows and return single result
    - COUNT(*) includes NULLs, COUNT(column) excludes NULLs
    - SUM, AVG, MIN, MAX ignore NULL values
    - GROUP BY: Divides rows into groups; requires aggregation or non-grouped columns
    - HAVING: Filters groups AFTER aggregation (WHERE filters BEFORE aggregation)
    - Aggregation without GROUP: Returns single row with total/average/etc for all rows
    - GROUP BY column: All selected non-aggregated columns must be in GROUP BY
    - NULL in GROUP BY: Treated as separate group
    - ORDER BY can use aggregated columns with aliases
    - DISTINCT in aggregation: COUNT(DISTINCT col), SUM(DISTINCT col)
================================================================================
*/

-- ===============================================
-- PART 1: COUNT() - Count rows and values
-- ===============================================

-- ===============================================
-- 1. COUNT(*) - Count all rows
-- ===============================================
-- Count total number of employees

SELECT COUNT(*) AS total_employees
FROM employee;

-- Count all projects
SELECT COUNT(*) AS total_projects
FROM project;

-- Count all departments
SELECT COUNT(*) AS department_count
FROM department;

-- Count all assignments
SELECT COUNT(*) AS total_assignments
FROM project_assignment;

-- ===============================================
-- 2. COUNT(column) - Count non-NULL values
-- ===============================================
-- Count employees (same as COUNT(*) if no nulls)

SELECT COUNT(employeeId) AS employee_count
FROM employee;

-- Count non-null email addresses
SELECT COUNT(email) AS employees_with_email
FROM employee;

-- Count projects with description (may have NULLs)
SELECT COUNT(description) AS projects_with_description
FROM project;

-- ===============================================
-- 3. COUNT(DISTINCT) - Count unique values
-- ===============================================
-- Count unique departments that have employees

SELECT COUNT(DISTINCT departmentId) AS unique_departments
FROM employee;

-- Count unique project statuses
SELECT COUNT(DISTINCT status) AS status_types
FROM project;

-- Count distinct roles in project assignments
SELECT COUNT(DISTINCT role) AS different_roles
FROM project_assignment;

-- Count employees assigned to projects (unique, excluding duplicates)
SELECT COUNT(DISTINCT employeeId) AS employees_on_projects
FROM project_assignment;

-- ===============================================
-- 4. COUNT with WHERE clause
-- ===============================================
-- Count employees in Engineering department

SELECT COUNT(*) AS engineering_staff
FROM employee
WHERE departmentId = 2;

-- Count active projects
SELECT COUNT(*) AS active_project_count
FROM project
WHERE status = 'Active';

-- Count high-salaried employees (> 55000)
SELECT COUNT(*) AS high_earners
FROM employee
WHERE salary > 55000;

-- Count assignments with high allocation (>=50%)
SELECT COUNT(*) AS high_allocation_assignments
FROM project_assignment
WHERE allocation_percentage >= 50;

-- ===============================================
-- PART 2: SUM() - Sum numeric values
-- ===============================================

-- ===============================================
-- 5. SUM() - Sum column values
-- ===============================================
-- Total of all employee salaries

SELECT SUM(salary) AS total_payroll
FROM employee;

-- Total budget for all projects
SELECT SUM(budget) AS total_project_budget
FROM project;

-- Total budget for active projects only
SELECT SUM(budget) AS active_project_budget
FROM project
WHERE status = 'Active';

-- ===============================================
-- 6. SUM with GROUP BY
-- ===============================================
-- Total salary by department

SELECT 
  departmentId,
  COUNT(*) AS employee_count,
  SUM(salary) AS department_payroll
FROM employee
GROUP BY departmentId;

-- Total project budget by department
SELECT 
  departmentId,
  COUNT(*) AS project_count,
  SUM(budget) AS total_department_budget
FROM project
GROUP BY departmentId;

-- Total allocation percentage by employee
SELECT 
  employeeId,
  COUNT(*) AS project_assignments,
  SUM(allocation_percentage) AS total_allocation
FROM project_assignment
GROUP BY employeeId;

-- ===============================================
-- 7. SUM(DISTINCT) - Sum distinct values
-- ===============================================
-- Sum distinct salary amounts (unique salary values only)

SELECT SUM(DISTINCT salary) AS sum_unique_salaries
FROM employee;

-- Sum distinct project budgets
SELECT SUM(DISTINCT budget) AS sum_unique_budgets
FROM project;

-- ===============================================
-- PART 3: AVG() - Calculate averages
-- ===============================================

-- ===============================================
-- 8. AVG() - Calculate average values
-- ===============================================
-- Average employee salary

SELECT AVG(salary) AS average_salary
FROM employee;

-- Average salary in each department
SELECT 
  departmentId,
  COUNT(*) AS employee_count,
  AVG(salary) AS average_salary
FROM employee
GROUP BY departmentId;

-- Average project budget
SELECT AVG(budget) AS average_project_budget
FROM project;

-- Average project duration (in days)
SELECT AVG(DATEDIFF(end_date, start_date)) AS avg_project_duration
FROM project;

-- ===============================================
-- 9. AVG with WHERE and GROUP BY
-- ===============================================
-- Average salary for employees earning > 50000

SELECT AVG(salary) AS average_high_salary
FROM employee
WHERE salary > 50000;

-- Average budget for active projects
SELECT AVG(budget) AS average_active_budget
FROM project
WHERE status = 'Active';

-- Average allocation percentage by role
SELECT 
  role,
  COUNT(*) AS role_count,
  AVG(allocation_percentage) AS avg_allocation
FROM project_assignment
GROUP BY role;

-- ===============================================
-- 10. AVG(DISTINCT) - Average distinct values
-- ===============================================
-- Average of distinct salary amounts

SELECT AVG(DISTINCT salary) AS avg_unique_salary
FROM employee;

-- Average of distinct project budgets
SELECT AVG(DISTINCT budget) AS avg_unique_budget
FROM project;

-- ===============================================
-- PART 4: MIN() and MAX() - Find extremes
-- ===============================================

-- ===============================================
-- 11. MIN() and MAX() - Find minimum and maximum
-- ===============================================
-- Lowest and highest salary

SELECT 
  MIN(salary) AS lowest_salary,
  MAX(salary) AS highest_salary,
  MAX(salary) - MIN(salary) AS salary_range
FROM employee;

-- Smallest and largest project budget
SELECT 
  MIN(budget) AS smallest_budget,
  MAX(budget) AS largest_budget
FROM project;

-- Earliest and latest project start dates
SELECT 
  MIN(start_date) AS earliest_start,
  MAX(start_date) AS latest_start,
  MIN(end_date) AS earliest_end,
  MAX(end_date) AS latest_end
FROM project;

-- ===============================================
-- 12. MIN/MAX by group
-- ===============================================
-- Salary range by department

SELECT 
  departmentId,
  MIN(salary) AS lowest_salary,
  MAX(salary) AS highest_salary,
  MAX(salary) - MIN(salary) AS salary_range
FROM employee
GROUP BY departmentId;

-- Budget range by project status
SELECT 
  status,
  MIN(budget) AS min_budget,
  MAX(budget) AS max_budget
FROM project
GROUP BY status;

-- Min and max allocation percentage by employee
SELECT 
  employeeId,
  MIN(allocation_percentage) AS min_allocation,
  MAX(allocation_percentage) AS max_allocation
FROM project_assignment
GROUP BY employeeId;

-- ===============================================
-- 13. MIN/MAX with WHERE clause
-- ===============================================
-- Salary info for Engineering department

SELECT 
  MIN(salary) AS engineer_min_salary,
  MAX(salary) AS engineer_max_salary,
  AVG(salary) AS engineer_avg_salary
FROM employee
WHERE departmentId = 2;

-- Budget info for active projects
SELECT 
  MIN(budget) AS min_active_budget,
  MAX(budget) AS max_active_budget
FROM project
WHERE status = 'Active';

-- ===============================================
-- PART 5: GROUP BY - Organize into groups
-- ===============================================

-- ===============================================
-- 14. GROUP BY - Single column grouping
-- ===============================================
-- Employees and salary count by department

SELECT 
  departmentId,
  COUNT(*) AS num_employees,
  SUM(salary) AS total_salary,
  AVG(salary) AS avg_salary
FROM employee
GROUP BY departmentId;

-- Number of projects by status
SELECT 
  status,
  COUNT(*) AS project_count,
  SUM(budget) AS total_budget,
  AVG(budget) AS avg_budget
FROM project
GROUP BY status;

-- Assignment count by role
SELECT 
  role,
  COUNT(*) AS role_count,
  AVG(allocation_percentage) AS avg_allocation
FROM project_assignment
GROUP BY role;

-- ===============================================
-- 15. GROUP BY - Multiple columns
-- ===============================================
-- Projects by department and status

SELECT 
  departmentId,
  status,
  COUNT(*) AS project_count,
  SUM(budget) AS total_budget
FROM project
GROUP BY departmentId, status;

-- Assignments by employee and role
SELECT 
  employeeId,
  role,
  COUNT(*) AS assignment_count,
  SUM(allocation_percentage) AS total_allocation
FROM project_assignment
GROUP BY employeeId, role;

-- ===============================================
-- 16. GROUP BY with ORDER BY
-- ===============================================
-- Departments sorted by total payroll (highest first)

SELECT 
  departmentId,
  COUNT(*) AS employee_count,
  SUM(salary) AS total_payroll,
  AVG(salary) AS avg_salary
FROM employee
GROUP BY departmentId
ORDER BY total_payroll DESC;

-- Projects sorted by total budget (highest first)
SELECT 
  departmentId,
  COUNT(*) AS project_count,
  SUM(budget) AS total_budget
FROM project
GROUP BY departmentId
ORDER BY total_budget DESC;

-- Roles sorted by average allocation (highest first)
SELECT 
  role,
  COUNT(*) AS assignment_count,
  AVG(allocation_percentage) AS avg_allocation
FROM project_assignment
GROUP BY role
ORDER BY avg_allocation DESC;

-- ===============================================
-- 17. GROUP BY with LIMIT
-- ===============================================
-- Top 3 departments by total payroll

SELECT 
  departmentId,
  COUNT(*) AS employee_count,
  SUM(salary) AS total_payroll
FROM employee
GROUP BY departmentId
ORDER BY total_payroll DESC
LIMIT 3;

-- Top 2 roles by assignment count
SELECT 
  role,
  COUNT(*) AS assignment_count
FROM project_assignment
GROUP BY role
ORDER BY assignment_count DESC
LIMIT 2;

-- ===============================================
-- PART 6: HAVING - Filter grouped results
-- ===============================================

-- ===============================================
-- 18. HAVING - Filter after grouping
-- ===============================================
-- Departments with average salary > 55000

SELECT 
  departmentId,
  COUNT(*) AS employee_count,
  AVG(salary) AS avg_salary
FROM employee
GROUP BY departmentId
HAVING AVG(salary) > 55000;

-- Departments with more than 1 employee
SELECT 
  departmentId,
  COUNT(*) AS employee_count
FROM employee
GROUP BY departmentId
HAVING COUNT(*) > 1;

-- Statuses with total budget > 300000
SELECT 
  status,
  COUNT(*) AS project_count,
  SUM(budget) AS total_budget
FROM project
GROUP BY status
HAVING SUM(budget) > 300000;

-- ===============================================
-- 19. HAVING with multiple conditions
-- ===============================================
-- Departments with 1+ employees AND average salary > 53000

SELECT 
  departmentId,
  COUNT(*) AS employee_count,
  SUM(salary) AS total_salary,
  AVG(salary) AS avg_salary
FROM employee
GROUP BY departmentId
HAVING COUNT(*) >= 1 AND AVG(salary) > 53000;

-- Roles with 2+ assignments AND average allocation > 40%
SELECT 
  role,
  COUNT(*) AS assignment_count,
  AVG(allocation_percentage) AS avg_allocation
FROM project_assignment
GROUP BY role
HAVING COUNT(*) >= 2 AND AVG(allocation_percentage) > 40;

-- ===============================================
-- 20. HAVING vs WHERE comparison
-- ===============================================
-- WHERE: filters BEFORE grouping

SELECT 
  departmentId,
  COUNT(*) AS high_earner_count,
  SUM(salary) AS total_salary
FROM employee
WHERE salary > 55000
GROUP BY departmentId;

-- HAVING: filters AFTER grouping
SELECT 
  departmentId,
  COUNT(*) AS employee_count,
  SUM(salary) AS total_salary
FROM employee
GROUP BY departmentId
HAVING SUM(salary) > 120000;

-- Combining WHERE and HAVING
SELECT 
  departmentId,
  COUNT(*) AS high_earner_count,
  AVG(salary) AS avg_salary
FROM employee
WHERE salary > 54000
GROUP BY departmentId
HAVING AVG(salary) > 58000;

-- ===============================================
-- PART 7: Multiple aggregations
-- ===============================================

-- ===============================================
-- 21. Multiple aggregation functions together
-- ===============================================
-- Comprehensive department statistics

SELECT 
  departmentId,
  COUNT(*) AS employee_count,
  MIN(salary) AS min_salary,
  MAX(salary) AS max_salary,
  AVG(salary) AS avg_salary,
  SUM(salary) AS total_salary
FROM employee
GROUP BY departmentId;

-- Comprehensive project statistics
SELECT 
  status,
  COUNT(*) AS project_count,
  MIN(budget) AS min_budget,
  MAX(budget) AS max_budget,
  AVG(budget) AS avg_budget,
  SUM(budget) AS total_budget
FROM project
GROUP BY status;

-- ===============================================
-- 22. Aggregations with CASE statements
-- ===============================================
-- Count employees by salary ranges

SELECT 
  COUNT(*) AS total_count,
  SUM(CASE WHEN salary < 52000 THEN 1 ELSE 0 END) AS junior_count,
  SUM(CASE WHEN salary >= 52000 AND salary < 60000 THEN 1 ELSE 0 END) AS mid_count,
  SUM(CASE WHEN salary >= 60000 THEN 1 ELSE 0 END) AS senior_count
FROM employee;

-- Budget by project status with conditions
SELECT 
  COUNT(*) AS total_projects,
  SUM(CASE WHEN status = 'Active' THEN budget ELSE 0 END) AS active_budget,
  SUM(CASE WHEN status = 'Completed' THEN budget ELSE 0 END) AS completed_budget,
  SUM(CASE WHEN status = 'On Hold' THEN budget ELSE 0 END) AS on_hold_budget
FROM project;

-- ===============================================
-- 23. Aggregations with JOIN
-- ===============================================
-- Department names with employee statistics

SELECT 
  d.name AS department,
  COUNT(e.employeeId) AS employee_count,
  AVG(e.salary) AS avg_salary,
  SUM(e.salary) AS total_payroll
FROM department d
LEFT JOIN employee e ON d.departmentId = e.departmentId
GROUP BY d.departmentId, d.name;

-- Project names with assignment statistics
SELECT 
  p.project_name,
  COUNT(pa.assignment_id) AS assignment_count,
  SUM(pa.allocation_percentage) AS total_allocation
FROM project p
LEFT JOIN project_assignment pa ON p.projectId = pa.projectId
GROUP BY p.projectId, p.project_name;

-- Employee names with project count
SELECT 
  e.employeeId,
  CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
  COUNT(pa.projectId) AS project_count,
  SUM(pa.allocation_percentage) AS total_allocation
FROM employee e
LEFT JOIN project_assignment pa ON e.employeeId = pa.employeeId
GROUP BY e.employeeId, e.first_name, e.last_name;

-- ===============================================
-- 24. Complex aggregation queries
-- ===============================================
-- Department analysis: employees, payroll, projects

SELECT 
  d.departmentId,
  d.name AS department,
  COUNT(DISTINCT e.employeeId) AS employee_count,
  SUM(e.salary) AS total_salary,
  AVG(e.salary) AS avg_salary,
  COUNT(DISTINCT p.projectId) AS project_count,
  SUM(p.budget) AS total_budget
FROM department d
LEFT JOIN employee e ON d.departmentId = e.departmentId
LEFT JOIN project p ON d.departmentId = p.departmentId
GROUP BY d.departmentId, d.name;

-- Project status report with detailed metrics
SELECT 
  p.status,
  COUNT(DISTINCT p.projectId) AS project_count,
  MIN(p.budget) AS min_budget,
  MAX(p.budget) AS max_budget,
  AVG(p.budget) AS avg_budget,
  SUM(p.budget) AS total_budget,
  COUNT(DISTINCT d.departmentId) AS departments_involved
FROM project p
LEFT JOIN department d ON p.departmentId = d.departmentId
GROUP BY p.status;

-- ===============================================
-- 25. Aggregations with sub-groups
-- ===============================================
-- Department and role combinations

SELECT 
  d.name AS department,
  pa.role,
  COUNT(DISTINCT pa.employeeId) AS employee_count,
  COUNT(pa.assignment_id) AS assignment_count,
  AVG(pa.allocation_percentage) AS avg_allocation
FROM department d
JOIN employee e ON d.departmentId = e.departmentId
JOIN project_assignment pa ON e.employeeId = pa.employeeId
GROUP BY d.departmentId, d.name, pa.role
ORDER BY d.name, pa.role;

-- Department, project status combinations
SELECT 
  d.name AS department,
  p.status,
  COUNT(p.projectId) AS project_count,
  SUM(p.budget) AS total_budget,
  AVG(p.budget) AS avg_budget
FROM department d
LEFT JOIN project p ON d.departmentId = p.departmentId
GROUP BY d.departmentId, d.name, p.status
ORDER BY d.name, p.status;

-- ===============================================
-- PART 8: Advanced aggregation scenarios
-- ===============================================

-- ===============================================
-- 26. Finding data ABOVE average
-- ===============================================
-- Employees earning above average salary

SELECT 
  employeeId,
  first_name,
  last_name,
  salary
FROM employee
WHERE salary > (SELECT AVG(salary) FROM employee)
ORDER BY salary DESC;

-- Projects with budget above average
SELECT 
  projectId,
  project_name,
  budget,
  status
FROM project
WHERE budget > (SELECT AVG(budget) FROM project)
ORDER BY budget DESC;

-- ===============================================
-- 27. Ranking and distribution
-- ===============================================
-- Distribution of projects by status

SELECT 
  status,
  COUNT(*) AS project_count,
  ROUND((COUNT(*) * 100.0 / (SELECT COUNT(*) FROM project)), 2) AS percentage
FROM project
GROUP BY status;

-- Distribution of employees by salary range
SELECT 
  CASE 
    WHEN salary < 52000 THEN 'Junior (<52k)'
    WHEN salary < 60000 THEN 'Mid-level (52k-60k)'
    ELSE 'Senior (>60k)'
  END AS salary_range,
  COUNT(*) AS employee_count,
  ROUND((COUNT(*) * 100.0 / (SELECT COUNT(*) FROM employee)), 2) AS percentage
FROM employee
GROUP BY salary_range;

-- ===============================================
-- 28. Aggregation with date functions
-- ===============================================
-- Project statistics by year

SELECT 
  YEAR(start_date) AS project_year,
  COUNT(*) AS project_count,
  SUM(budget) AS total_budget,
  AVG(budget) AS avg_budget
FROM project
GROUP BY YEAR(start_date)
ORDER BY project_year;

-- Assignment count by month
SELECT 
  DATE_FORMAT(assignment_date, '%Y-%m') AS month,
  COUNT(*) AS assignment_count,
  COUNT(DISTINCT employeeId) AS unique_employees
FROM project_assignment
GROUP BY DATE_FORMAT(assignment_date, '%Y-%m')
ORDER BY month;

-- ===============================================
-- 29. Top/Bottom analysis
-- ===============================================
-- Top 3 most expensive departments (by payroll)

SELECT 
  d.name AS department,
  COUNT(e.employeeId) AS employee_count,
  SUM(e.salary) AS total_payroll,
  AVG(e.salary) AS avg_salary
FROM department d
LEFT JOIN employee e ON d.departmentId = e.departmentId
GROUP BY d.departmentId, d.name
ORDER BY total_payroll DESC
LIMIT 3;

-- Bottom 2 roles by assignment frequency
SELECT 
  role,
  COUNT(*) AS assignment_count
FROM project_assignment
GROUP BY role
ORDER BY assignment_count ASC
LIMIT 2;

-- ===============================================
-- 30. Aggregation for business insights
-- ===============================================
-- Employee utilization summary

SELECT 
  e.employeeId,
  CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
  COUNT(DISTINCT pa.projectId) AS projects_assigned,
  SUM(pa.allocation_percentage) AS total_allocation_pct,
  CASE 
    WHEN SUM(pa.allocation_percentage) < 25 THEN 'Underutilized'
    WHEN SUM(pa.allocation_percentage) < 75 THEN 'Optimally Utilized'
    WHEN SUM(pa.allocation_percentage) < 100 THEN 'Fully Utilized'
    ELSE 'Over Allocated'
  END AS utilization_status
FROM employee e
LEFT JOIN project_assignment pa ON e.employeeId = pa.employeeId
GROUP BY e.employeeId, e.first_name, e.last_name
ORDER BY total_allocation_pct DESC;

-- Project portfolio summary
SELECT 
  COUNT(*) AS total_projects,
  SUM(CASE WHEN status = 'Active' THEN 1 ELSE 0 END) AS active_count,
  SUM(CASE WHEN status = 'Completed' THEN 1 ELSE 0 END) AS completed_count,
  SUM(CASE WHEN status = 'On Hold' THEN 1 ELSE 0 END) AS on_hold_count,
  SUM(budget) AS total_budget,
  AVG(budget) AS avg_budget,
  MIN(budget) AS min_budget,
  MAX(budget) AS max_budget
FROM project;

-- ===============================================
-- QUICK REFERENCE - AGGREGATION FUNCTIONS
-- ===============================================
/*
COUNT Functions:
  COUNT(*) = Count all rows (including NULLs)
  COUNT(column) = Count non-NULL values in column
  COUNT(DISTINCT col) = Count unique non-NULL values
  
  Example: COUNT(*) = 4, COUNT(email) = 3 if one email is NULL

SUM Function:
  SUM(numeric_column) = Sum all values (ignores NULLs)
  SUM(DISTINCT col) = Sum of distinct values only
  
  Example: SUM(salary) = 215000, SUM(DISTINCT salary) = 210000 if duplicates exist

AVG Function:
  AVG(numeric_column) = Average of all values (ignores NULLs)
  AVG(DISTINCT col) = Average of distinct values
  
  Example: AVG(salary) = 53750 for 4 employees

MIN/MAX Functions:
  MIN(column) = Smallest value in column
  MAX(column) = Largest value in column
  Works with numbers, dates, strings
  
  Example: MIN(salary) = 50000, MAX(salary) = 65000

GROUP BY Syntax:
  SELECT column, SUM(amount) FROM table GROUP BY column;
  All non-aggregated SELECT columns must be in GROUP BY
  GROUP BY goes AFTER WHERE, BEFORE HAVING
  Can group by multiple columns

HAVING Syntax:
  SELECT col, COUNT(*) FROM table GROUP BY col HAVING COUNT(*) > 5;
  HAVING filters grouped results (like WHERE for groups)
  Cannot use column aliases in HAVING (use full function)
  
Operator Precedence in Aggregation:
  1. FROM / JOIN
  2. WHERE (filters rows before grouping)
  3. GROUP BY (creates groups)
  4. HAVING (filters groups)
  5. SELECT
  6. ORDER BY
  7. LIMIT
*/

-- ===============================================
-- KEY POINTS & BEST PRACTICES
-- ===============================================
/*
1. NULL Handling:
   - COUNT(*) includes NULLs, COUNT(col) excludes them
   - SUM, AVG, MIN, MAX all IGNORE NULL values
   - Use COUNT(DISTINCT col) to count unique non-NULL values

2. GROUP BY Requirements:
   - All non-aggregated columns in SELECT must be in GROUP BY
   - GROUP BY doesn't require ORDER BY (but often useful)
   - Can GROUP BY column name, number, or expression

3. WHERE vs HAVING:
   - WHERE: filters rows BEFORE grouping (better performance)
   - HAVING: filters groups AFTER aggregation
   - Combine both: WHERE for row filtering, HAVING for group filtering

4. COUNT vs DISTINCT:
   - COUNT(*) → total rows
   - COUNT(DISTINCT col) → unique values
   - DISTINCT applies to all selected columns

5. Aggregation with NULL:
   - NULLs are grouped together in GROUP BY
   - Include IS NULL in WHERE if NULL matters
   - Use COALESCE to replace NULL before aggregating

6. Performance:
   - WHERE clause: Filter before grouping (faster)
   - Indexed columns: Use in GROUP BY columns for speed
   - DISTINCT: Can be expensive on large datasets
   - Subqueries: Consider performance with complex aggregations

7. JOINs with Aggregation:
   - Use LEFT JOIN to preserve non-matching rows
   - GROUP BY all joining table IDs
   - Be careful with INNER JOIN: filters rows before aggregation

8. DATE Aggregations:
   - Use YEAR(), MONTH(), DATE_FORMAT() with GROUP BY
   - Date functions: DATEDIFF, DATE_ADD, DATE_SUB
   - Format output with DATE_FORMAT() for readability

9. Multiple Aggregations:
   - Can use COUNT, SUM, AVG, MIN, MAX in same query
   - Each function processes same grouped data
   - Use CASE for conditional aggregation

10. Debugging Aggregation Queries:
    - Start with raw query (without aggregation)
    - Add GROUP BY incrementally
    - Test HAVING conditions separately
    - Check for NULL values in data

11. CASE with Aggregation:
    - SUM(CASE WHEN condition THEN 1 ELSE 0 END) to count conditions
    - Can distribute amounts across categories
    - Useful for conditional sums and counts

12. Best Practices:
    - Use meaningful aliases for aggregated columns
    - Order results for easier interpretation
    - Include context columns with aggregations
    - Comment complex GROUP BY queries

13. Common Mistakes:
    - Forgetting to include all non-agg columns in GROUP BY
    - Using WHERE instead of HAVING to filter groups
    - Confusing COUNT(*) and COUNT(column)
    - Not considering NULL values in calculations

14. Optimization Tips:
    - Add WHERE before GROUP BY (filter early)
    - Use specific columns in GROUP BY (not subqueries)
    - Use indexes on GROUP BY columns
    - LIMIT after ORDER BY for top-N queries

15. Real-world Uses:
    - Reports and dashboards
    - KPI calculations
    - Data quality checks
    - Trend analysis
    - Resource utilization
    - Financial summaries
*/

-- ===============================================
-- PRACTICE EXAMPLES - Uncomment to use
-- ===============================================

-- Example 1: Basic COUNT - total employees and projects
-- SELECT COUNT(*) AS total_employees FROM employee; SELECT COUNT(*) AS total_projects FROM project;

-- Example 2: GROUP BY department - payroll analysis
-- SELECT departmentId, COUNT(*) AS emp_count, SUM(salary) AS total_salary, AVG(salary) AS avg_salary FROM employee GROUP BY departmentId;

-- Example 3: HAVING - departments with more than 1 employee
-- SELECT departmentId, COUNT(*) AS emp_count FROM employee GROUP BY departmentId HAVING COUNT(*) > 1;

-- Example 4: Multiple aggregations - project statistics by status
-- SELECT status, COUNT(*) AS proj_count, SUM(budget) AS total_budget, AVG(budget) AS avg_budget, MIN(budget) AS min_budget, MAX(budget) AS max_budget FROM project GROUP BY status;

-- Example 5: Complex JOIN with aggregation - department totals with names
-- SELECT d.name, COUNT(e.employeeId) AS emp_count, SUM(e.salary) AS payroll FROM department d LEFT JOIN employee e ON d.departmentId = e.departmentId GROUP BY d.departmentId, d.name;

-- Example 6: COUNT DISTINCT - unique values
-- SELECT COUNT(DISTINCT departmentId) AS unique_depts, COUNT(DISTINCT status) AS unique_statuses FROM project;

-- Example 7: Conditional aggregation - employees by salary range
-- SELECT SUM(CASE WHEN salary < 52000 THEN 1 ELSE 0 END) AS junior, SUM(CASE WHEN salary >= 52000 AND salary < 60000 THEN 1 ELSE 0 END) AS mid, SUM(CASE WHEN salary >= 60000 THEN 1 ELSE 0 END) AS senior FROM employee;

-- Example 8: Multiple GROUP BY levels - department and role analysis
-- SELECT d.name, pa.role, COUNT(DISTINCT pa.employeeId) AS emp_count, AVG(pa.allocation_percentage) AS avg_allocation FROM department d JOIN employee e ON d.departmentId = e.departmentId JOIN project_assignment pa ON e.employeeId = pa.employeeId GROUP BY d.departmentId, d.name, pa.role;

-- Example 9: Top N analysis - top 3 departments by payroll
-- SELECT departmentId, COUNT(*) AS emp_count, SUM(salary) AS total_payroll FROM employee GROUP BY departmentId ORDER BY total_payroll DESC LIMIT 3;

-- Example 10: Distribution percentage - project status distribution
-- SELECT status, COUNT(*) AS proj_count, ROUND((COUNT(*) * 100.0 / (SELECT COUNT(*) FROM project)), 2) AS percentage FROM project GROUP BY status;
