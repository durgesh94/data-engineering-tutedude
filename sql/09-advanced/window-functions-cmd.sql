/*
╔════════════════════════════════════════════════════════════════════════════╗
║              WINDOW FUNCTIONS - COMPREHENSIVE GUIDE                        ║
╚════════════════════════════════════════════════════════════════════════════╝

Author: Durgesh Tambe
Date: April 27, 2026
Version: 1.0
Database: MySQL 5.7+

PURPOSE:
Window functions perform calculations across a set of rows related to the 
current row without collapsing the result set (unlike GROUP BY). They enable:
- Ranking and numbering within groups
- Running totals and cumulative calculations
- Comparison of current row with previous/next rows
- Percentile and quantile calculations
- Access to first/last values in partitions
- Moving averages and trend analysis

KEY CONCEPTS:
┌──────────────────────┬───────────────────────────────────────────────────┐
│ Component            │ Description                                       │
├──────────────────────┼───────────────────────────────────────────────────┤
│ PARTITION BY         │ Divides rows into partitions (similar to GROUP BY)│
│ ORDER BY             │ Sorts rows within each partition                  │
│ Frame Clause         │ Specifies range of rows for the calculation       │
│ Ranking Functions    │ ROW_NUMBER, RANK, DENSE_RANK                     │
│ Aggregate Functions  │ SUM, AVG, COUNT, MIN, MAX as window functions    │
│ Analytical Functions │ LAG, LEAD, FIRST_VALUE, LAST_VALUE, NTILE       │
└──────────────────────┴───────────────────────────────────────────────────┘

SYNTAX:
  function_name() OVER (
    [PARTITION BY column1, column2, ...]
    [ORDER BY column1 [ASC|DESC], ...]
    [ROWS|RANGE BETWEEN ... AND ...]
  )

WINDOW FUNCTION CATEGORIES:
  1. Ranking Functions    - ROW_NUMBER, RANK, DENSE_RANK
  2. Aggregate Functions  - SUM, AVG, COUNT, MIN, MAX, GROUP_CONCAT
  3. Offset Functions     - LAG, LEAD, FIRST_VALUE, LAST_VALUE
  4. Distribution Function - NTILE

TABLE OF CONTENTS:
═══════════════════════════════════════════════════════════════════════════════
1.  ROW_NUMBER() - Unique sequential numbering
2.  RANK() - Ranking with tie support (gaps allowed)
3.  DENSE_RANK() - Ranking without gaps
4.  LAG() and LEAD() - Access previous/next row values
5.  FIRST_VALUE() and LAST_VALUE() - Get first/last value in window
6.  SUM(), AVG(), COUNT() - Running totals and moving averages
7.  NTILE() - Divide rows into N equal groups
8.  Frame Clause - ROWS vs RANGE (Advanced)
9.  Real-World Examples - Complex practical scenarios
10. Key Performance Tips & Best Practices
═══════════════════════════════════════════════════════════════════════════════

ASSUMPTIONS:
All examples use existing tables from '../02-manipulation/' folder:
- employee (employeeId, first_name, last_name, email, salary, departmentId)
- department (departmentId, name)
- project (projectId, project_name, budget, departmentId, status, start_date, end_date)
- project_assignment (assignment_id, employeeId, projectId, role, allocation_percentage, assignment_date)
*/


-- ╔════════════════════════════════════════════════════════════════════════════╗
-- ║ 1. ROW_NUMBER() - Assigns unique sequential number to each row              ║
-- ╚════════════════════════════════════════════════════════════════════════════╝

/*
CONCEPT:
  Assigns a unique sequential number to each row within a partition.
  Use Case: Ranking rows within groups, finding top N records
  Syntax: ROW_NUMBER() OVER (PARTITION BY column ORDER BY column)
  Key Point: ROW_NUMBER() always produces unique numbers (1, 2, 3, ...)
*/

-- Example 1: Rank employees by salary within each department
SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    d.name AS department,
    e.salary,
    ROW_NUMBER() OVER (PARTITION BY d.departmentId ORDER BY e.salary DESC) AS salary_rank
FROM employee e
JOIN department d ON e.departmentId = d.departmentId
ORDER BY d.departmentId, salary_rank;

-- Example 2: Get top 3 highest-paid employees in each department
SELECT * FROM (
    SELECT 
        e.employeeId,
        CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
        d.name AS department,
        e.salary,
        ROW_NUMBER() OVER (PARTITION BY d.departmentId ORDER BY e.salary DESC) AS rank_num
    FROM employee e
    JOIN department d ON e.departmentId = d.departmentId
) ranked
WHERE rank_num <= 3
ORDER BY department, rank_num;


-- ╔════════════════════════════════════════════════════════════════════════════╗
-- ║ 2. RANK() - Similar to ROW_NUMBER but allows ties to have same rank          ║
-- ╚════════════════════════════════════════════════════════════════════════════╝

/*
CONCEPT:
  Assigns rank to each row with support for ties.
  Use Case: When ties should have the same rank, but next rank is skipped
  Syntax: RANK() OVER (PARTITION BY column ORDER BY column)
  Example: Scores 100, 95, 95, 90 → Rank 1, 2, 2, 4 (rank 3 is skipped)
  Difference from DENSE_RANK: Gaps in ranking after ties
*/

-- Example 1: Rank projects by budget within each department
SELECT 
    p.projectId,
    p.project_name,
    d.name AS department,
    p.budget,
    RANK() OVER (PARTITION BY p.departmentId ORDER BY p.budget DESC) AS budget_rank
FROM project p
JOIN department d ON p.departmentId = d.departmentId
ORDER BY d.name, budget_rank;

-- Example 2: Rank employees by allocation percentage within each project
SELECT 
    pa.assignment_id,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    p.project_name,
    pa.role,
    pa.allocation_percentage,
    RANK() OVER (PARTITION BY pa.projectId ORDER BY pa.allocation_percentage DESC) AS allocation_rank
FROM project_assignment pa
JOIN employee e ON pa.employeeId = e.employeeId
JOIN project p ON pa.projectId = p.projectId
ORDER BY p.project_name, allocation_rank;


-- ╔════════════════════════════════════════════════════════════════════════════╗
-- ║ 3. DENSE_RANK() - Like RANK but no gaps in ranking                          ║
-- ╚════════════════════════════════════════════════════════════════════════════╝

/*
CONCEPT:
  Assigns consecutive rank values without gaps after ties.
  Use Case: When you want consecutive rankings without gaps
  Syntax: DENSE_RANK() OVER (PARTITION BY column ORDER BY column)
  Example: Scores 100, 95, 95, 90 → Rank 1, 2, 2, 3 (consecutive, no gap)
  Difference from RANK: No gaps in ranking after ties
*/

-- Example 1: Dense rank employee salaries (1, 2, 2, 3 instead of 1, 2, 2, 4)
SELECT 
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    e.salary,
    RANK() OVER (ORDER BY e.salary DESC) AS rank_with_gap,
    DENSE_RANK() OVER (ORDER BY e.salary DESC) AS dense_rank_no_gap
FROM employee e
ORDER BY e.salary DESC;

-- Example 2: Project ranking by budget within each department
SELECT 
    p.project_name,
    d.name AS department,
    p.budget,
    DENSE_RANK() OVER (PARTITION BY p.departmentId ORDER BY p.budget DESC) AS budget_rank
FROM project p
JOIN department d ON p.departmentId = d.departmentId
ORDER BY d.name, budget_rank;


-- ╔════════════════════════════════════════════════════════════════════════════╗
-- ║ 4. LAG() and LEAD() - Access previous/next row values                       ║
-- ╚════════════════════════════════════════════════════════════════════════════╝

/*
CONCEPT:
  LAG() retrieves a value from a previous row; LEAD() retrieves from next row.
  Use Case: Compare current row with previous/next row, calculate differences
  Syntax: LAG(column, offset, default) OVER (ORDER BY column)
          LEAD(column, offset, default) OVER (ORDER BY column)
  Parameters: offset = number of rows back/forward (default 1)
              default = value if offset goes beyond result set
  Use: Calculate month-over-month changes, trends, running differences
*/

-- Example 1: Compare employee salaries with previous and next employee (ordered by salary)
SELECT 
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    e.salary,
    LAG(e.salary) OVER (ORDER BY e.salary) AS lower_salary,
    LEAD(e.salary) OVER (ORDER BY e.salary) AS higher_salary,
    e.salary - LAG(e.salary, 1, 0) OVER (ORDER BY e.salary) AS diff_from_lower,
    LEAD(e.salary, 1, 0) OVER (ORDER BY e.salary) - e.salary AS diff_to_higher
FROM employee e
ORDER BY e.salary;

-- Example 2: Track project timeline with previous and next projects by start date
SELECT 
    p.project_name,
    p.start_date,
    p.end_date,
    LAG(p.project_name) OVER (ORDER BY p.start_date) AS previous_project,
    LEAD(p.project_name) OVER (ORDER BY p.start_date) AS next_project,
    DATEDIFF(
        p.start_date,
        LAG(p.start_date) OVER (ORDER BY p.start_date)
    ) AS days_after_previous_project
FROM project p
ORDER BY p.start_date;


-- ╔════════════════════════════════════════════════════════════════════════════╗
-- ║ 5. FIRST_VALUE() and LAST_VALUE() - Get first/last value in window          ║
-- ╚════════════════════════════════════════════════════════════════════════════╝

/*
CONCEPT:
  FIRST_VALUE() returns the first value in the ordered window;
  LAST_VALUE() returns the last value in the ordered window.
  Use Case: Compare values to first/last in partition, baseline comparisons
  Syntax: FIRST_VALUE(column) OVER (ORDER BY column)
          LAST_VALUE(column) OVER (ORDER BY ... RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
  Important: LAST_VALUE needs explicit frame clause to include all rows
  Without frame clause, defaults to RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
*/

-- Example 1: Compare each employee's salary to their department's highest
SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    d.name AS department,
    e.salary,
    FIRST_VALUE(e.salary) OVER (PARTITION BY d.departmentId ORDER BY e.salary DESC) AS highest_salary_in_dept,
    LAST_VALUE(e.salary) OVER (PARTITION BY d.departmentId ORDER BY e.salary DESC 
        RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS lowest_salary_in_dept,
    FIRST_VALUE(e.salary) OVER (PARTITION BY d.departmentId ORDER BY e.salary DESC) - e.salary AS diff_from_highest
FROM employee e
JOIN department d ON e.departmentId = d.departmentId
ORDER BY d.name, e.salary DESC;

-- Example 2: Get first and last project assignment for each employee
SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    pa.assignment_date,
    p.project_name,
    FIRST_VALUE(pa.assignment_date) OVER (PARTITION BY pa.employeeId ORDER BY pa.assignment_date) AS first_assignment_date,
    LAST_VALUE(pa.assignment_date) OVER (PARTITION BY pa.employeeId ORDER BY pa.assignment_date 
        RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_assignment_date
FROM project_assignment pa
JOIN employee e ON pa.employeeId = e.employeeId
JOIN project p ON pa.projectId = p.projectId
ORDER BY e.employeeId, pa.assignment_date;


-- ╔════════════════════════════════════════════════════════════════════════════╗
-- ║ 6. SUM(), AVG(), COUNT() as Window Functions - Running totals & averages     ║
-- ╚════════════════════════════════════════════════════════════════════════════╝

/*
CONCEPT:
  Aggregate functions (SUM, AVG, COUNT, MIN, MAX) can be used as window functions
  to create running totals, cumulative calculations, and moving averages.
  Use Case: Calculate running sum, cumulative totals, moving averages
  Syntax: SUM(column) OVER (ORDER BY column ROWS BETWEEN ... AND ...)
  Key: The frame clause (ROWS BETWEEN...) controls which rows are included
  Combination: Often used with PARTITION BY to calculate per-group aggregates
*/

-- Example 1: Running total of project budgets ordered by start date
SELECT 
    p.project_name,
    p.start_date,
    p.budget,
    SUM(p.budget) OVER (ORDER BY p.start_date) AS cumulative_budget,
    AVG(p.budget) OVER (ORDER BY p.start_date) AS running_avg_budget
FROM project p
ORDER BY p.start_date;

-- Example 2: Running budget total per department with count
SELECT 
    d.name AS department,
    p.project_name,
    p.start_date,
    p.budget,
    SUM(p.budget) OVER (PARTITION BY p.departmentId ORDER BY p.start_date) AS dept_cumulative_budget,
    COUNT(*) OVER (PARTITION BY p.departmentId ORDER BY p.start_date) AS num_projects_in_dept
FROM project p
JOIN department d ON p.departmentId = d.departmentId
ORDER BY d.name, p.start_date;

-- Example 3: Moving average of employee salaries (last 3 employees by salary)
SELECT 
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    e.salary,
    AVG(e.salary) OVER (
        ORDER BY e.salary 
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS moving_avg_salary_3rows
FROM employee e
ORDER BY e.salary DESC;


-- ╔════════════════════════════════════════════════════════════════════════════╗
-- ║ 7. NTILE() - Divide rows into N equal groups (quartiles, percentiles)        ║
-- ╚════════════════════════════════════════════════════════════════════════════╝

/*
CONCEPT:
  NTILE(n) divides rows into n equal-sized buckets and assigns bucket number.
  Use Case: Segment data into equal groups (quartiles, deciles, percentiles)
  Syntax: NTILE(number_of_buckets) OVER (ORDER BY column)
  Example: NTILE(4) creates quartiles (buckets 1, 2, 3, 4)
  Use Cases: Performance tiers, revenue segments, salary ranges, risk buckets
  Note: Rows are divided as equally as possible; larger buckets get extra rows
*/

-- Example 1: Divide employees into quartiles by salary
SELECT 
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    e.salary,
    NTILE(4) OVER (ORDER BY e.salary DESC) AS salary_quartile
FROM employee e
ORDER BY e.salary DESC;

-- Example 2: Segment projects into performance tiers by budget (tertiles)
SELECT 
    p.projectId,
    p.project_name,
    p.budget,
    NTILE(3) OVER (ORDER BY p.budget DESC) AS budget_tier
FROM project p
ORDER BY p.budget DESC;

-- Example 3: Divide employees into allocation tiers within each project
SELECT 
    p.project_name,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    pa.allocation_percentage,
    NTILE(3) OVER (PARTITION BY pa.projectId ORDER BY pa.allocation_percentage DESC) AS workload_tier
FROM project_assignment pa
JOIN employee e ON pa.employeeId = e.employeeId
JOIN project p ON pa.projectId = p.projectId
ORDER BY p.project_name, pa.allocation_percentage DESC;


-- ╔════════════════════════════════════════════════════════════════════════════╗
-- ║ 8. Frame Clause - ROWS vs RANGE (Advanced)                                  ║
-- ╚════════════════════════════════════════════════════════════════════════════╝

/*
CONCEPT:
  Frame clause specifies which rows in the partition are included in calculation.
  Options: UNBOUNDED PRECEDING, CURRENT ROW, N PRECEDING/FOLLOWING, UNBOUNDED FOLLOWING
  Syntax: [ROWS | RANGE] BETWEEN start AND end
  
  ROWS: Physical row count-based frame
    - ROWS BETWEEN 2 PRECEDING AND CURRENT ROW = last 3 rows
    
  RANGE: Logical value-based frame (groups rows with same ORDER BY value)
    - RANGE BETWEEN 1 PRECEDING AND CURRENT ROW = current value ± range
    
  Default (no frame clause): RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
  Use: ROWS for fixed window size, RANGE for value-based grouping
*/

-- Example 1: Different frame definitions for running total of project budgets
SELECT 
    p.project_name,
    p.start_date,
    p.budget,
    -- All projects from start to current
    SUM(p.budget) OVER (ORDER BY p.start_date) AS all_projects_sum,
    -- Current project and 1 project before
    SUM(p.budget) OVER (ORDER BY p.start_date ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS last_2_projects_sum,
    -- Current project and 2 projects before and after
    SUM(p.budget) OVER (ORDER BY p.start_date ROWS BETWEEN 2 PRECEDING AND 2 FOLLOWING) AS window_5_projects_sum
FROM project p
ORDER BY p.start_date;

-- Example 2: RANGE vs ROWS - comparing aggregation methods by allocation percentage
SELECT 
    pa.allocation_percentage,
    COUNT(*) AS num_assignments,
    -- ROWS: exact number of rows
    SUM(COUNT(*)) OVER (ORDER BY pa.allocation_percentage ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS rows_frame_sum,
    -- RANGE: all rows with same value treated together
    SUM(COUNT(*)) OVER (ORDER BY pa.allocation_percentage RANGE BETWEEN 1 PRECEDING AND CURRENT ROW) AS range_frame_sum
FROM project_assignment pa
GROUP BY pa.allocation_percentage
ORDER BY pa.allocation_percentage;


-- ╔════════════════════════════════════════════════════════════════════════════╗
-- ║ 9. REAL-WORLD EXAMPLES - Complex Window Function Scenarios                  ║
-- ╚════════════════════════════════════════════════════════════════════════════╝

/*
CONCEPT:
  Real-world applications combining multiple window functions for:
  - Performance analysis and rankings
  - Resource allocation and workload distribution
  - Trend analysis and participation tracking
  These examples demonstrate how to combine functions for comprehensive insights.
*/

-- Example 1: Employee Salary Analysis
-- For each employee, show their rank and comparison to department average
SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    d.name AS department,
    e.salary,
    RANK() OVER (PARTITION BY d.departmentId ORDER BY e.salary DESC) AS dept_salary_rank,
    SUM(e.salary) OVER (PARTITION BY d.departmentId) AS dept_total_salary,
    ROUND(
        100.0 * e.salary / SUM(e.salary) OVER (PARTITION BY d.departmentId),
        2
    ) AS pct_of_dept_total_salary,
    FIRST_VALUE(e.salary) OVER (PARTITION BY d.departmentId ORDER BY e.salary DESC) AS dept_highest_salary
FROM employee e
JOIN department d ON e.departmentId = d.departmentId
ORDER BY d.name, e.salary DESC;

-- Example 2: Project Resource Allocation Analysis
SELECT 
    p.project_name,
    d.name AS department,
    COUNT(pa.employeeId) AS num_allocated_employees,
    SUM(pa.allocation_percentage) AS total_allocation_pct,
    AVG(pa.allocation_percentage) AS avg_allocation_pct,
    ROW_NUMBER() OVER (PARTITION BY p.departmentId ORDER BY COUNT(pa.employeeId) DESC) AS project_size_rank,
    NTILE(3) OVER (ORDER BY SUM(pa.allocation_percentage) DESC) AS resource_intensity_tier
FROM project p
LEFT JOIN department d ON p.departmentId = d.departmentId
LEFT JOIN project_assignment pa ON p.projectId = pa.projectId
GROUP BY p.projectId, p.project_name, d.name, p.departmentId
ORDER BY d.name, num_allocated_employees DESC;

-- Example 3: Employee Project Participation Trend
SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    pa.assignment_date,
    p.project_name,
    pa.role,
    pa.allocation_percentage,
    COUNT(*) OVER (PARTITION BY pa.employeeId) AS total_projects_assigned,
    AVG(pa.allocation_percentage) OVER (PARTITION BY pa.employeeId) AS avg_allocation_per_employee,
    ROW_NUMBER() OVER (PARTITION BY pa.employeeId ORDER BY pa.assignment_date) AS assignment_sequence,
    LAG(pa.allocation_percentage) OVER (PARTITION BY pa.employeeId ORDER BY pa.assignment_date) AS prev_allocation,
    LEAD(pa.allocation_percentage) OVER (PARTITION BY pa.employeeId ORDER BY pa.assignment_date) AS next_allocation
FROM project_assignment pa
JOIN employee e ON pa.employeeId = e.employeeId
JOIN project p ON pa.projectId = p.projectId
ORDER BY e.employeeId, pa.assignment_date;


-- ╔════════════════════════════════════════════════════════════════════════════╗
-- ║ 10. KEY PERFORMANCE TIPS & BEST PRACTICES                                    ║
-- ╚════════════════════════════════════════════════════════════════════════════╝
-- 1. Indexing: Create indexes on PARTITION BY and ORDER BY columns
--    Examples:
--    CREATE INDEX idx_employee_dept_salary ON employee(departmentId, salary);
--    CREATE INDEX idx_project_dept_start ON project(departmentId, start_date);
--    CREATE INDEX idx_assignment_project_alloc ON project_assignment(projectId, allocation_percentage);
--
-- 2. Performance: Window functions are generally efficient, but avoid:
--    - Overlapping PARTITION BY / ORDER BY columns
--    - Unnecessary calculations in window frame definitions
--
-- 3. Frame Clauses: Use ROWS for fixed row ranges, RANGE for value ranges
--    - ROWS BETWEEN 1 PRECEDING AND CURRENT ROW = last 2 rows
--    - RANGE BETWEEN interval qualifying rows
--
-- 4. NULL Handling: FIRST_VALUE/LAST_VALUE skip nulls by default (most DBs)
--    - Use IGNORE NULLS or RESPECT NULLS keywords if supported
--
-- 5. Ordering: Always use ORDER BY in window functions for consistent results
--
-- 6. Readability: Use clear aliases and CTEs for complex window queries
--    Example:
--    WITH employee_salary_analysis AS (
--        SELECT 
--            employeeId,
--            salary,
--            RANK() OVER (PARTITION BY departmentId ORDER BY salary DESC) AS salary_rank
--        FROM employee
--    )
--    SELECT * FROM employee_salary_analysis WHERE salary_rank <= 3;
-- ============================================================================
