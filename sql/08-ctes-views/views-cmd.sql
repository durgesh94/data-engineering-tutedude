/*
╔════════════════════════════════════════════════════════════════════════════╗
║                   SQL VIEWS - COMPREHENSIVE GUIDE                          ║
╚════════════════════════════════════════════════════════════════════════════╝

Author: Durgesh Tambe
Date: April 25, 2026
Version: 1.0
Database: MySQL 5.7+

PURPOSE:
Views are virtual tables created from SQL queries. They provide:
- Abstraction: Hide complex queries behind a simple interface
- Security: Restrict access to specific columns/rows
- Reusability: Define once, use many times
- Maintainability: Update underlying query once, all dependent queries benefit
- Encapsulation: Separate business logic from data structure

KEY DIFFERENCES FROM CTEs:
┌──────────────────┬──────────────────────────────────┬──────────────────────────┐
│ Feature          │ View                             │ CTE                      │
├──────────────────┼──────────────────────────────────┼──────────────────────────┤
│ Persistence      │ Stored in database               │ Temporary (query session)│
│ Reusability      │ Across multiple queries          │ Single query only        │
│ Performance      │ Can use indexes                  │ Cannot use indexes       │
│ Updatable        │ Yes (with restrictions)          │ No (read-only)           │
│ Scope            │ Database-wide                    │ Query-specific           │
│ Memory Usage     │ Minimal (no storage)             │ In-memory during query   │
│ Complexity       │ Moderate setup, simple usage     │ Simple setup, reuse hard │
└──────────────────┴──────────────────────────────────┴──────────────────────────┘

SYNTAX:
  CREATE [OR REPLACE] VIEW view_name [(column_list)] AS
  SELECT ... FROM ... WHERE ... GROUP BY ...

  DROP VIEW [IF EXISTS] view_name;
  
  CREATE OR REPLACE VIEW view_name AS ... 
  (Cannot change column list or add GROUP BY if original had neither)

VIEW TYPES:
  1. Simple Views     - Single table, no aggregation
  2. Complex Views    - Joins, aggregations, functions
  3. Updateable Views - Support INSERT/UPDATE/DELETE (with restrictions)
  4. Read-only Views  - Contain aggregates, joins, subqueries

TABLE OF CONTENTS:
═══════════════════════════════════════════════════════════════════════════════
1.  Simple View - Employee List
2.  View with WHERE - Active Employees
3.  View with Aggregation - Department Statistics
4.  View with JOIN - Employee Details
5.  View with Multiple JOINs - Complete Project Information
6.  View with Column Aliases - Simplified Naming
7.  Updateable View - Department Management
8.  View with Nested Function - Email Formatting
9.  View with CASE Statement - Employee Classification
10. View for Security - Salary Hidden View
11. View Modification and Dependencies
12. Best Practices and Common Mistakes
═══════════════════════════════════════════════════════════════════════════════

ASSUMPTION:
All examples use existing tables from '../02-manipulation/' folder:
- employee (employeeId, first_name, last_name, email, salary, departmentId)
- department (departmentId, name)
- project (projectId, project_name, budget, departmentId, status)
- project_assignment (assignment_id, employeeId, projectId, role, allocation_percentage)
*/

-- ╔════════════════════════════════════════════════════════════════════════════╗
-- ║ 1. SIMPLE VIEW - Employee List                                            ║
-- ╚════════════════════════════════════════════════════════════════════════════╝

/*
CONCEPT:
  Simple views select specific columns from a single table without complex logic.
  Use Case: Provide a standardized list of employees to external systems
*/

CREATE OR REPLACE VIEW v_employee_list AS
SELECT 
    employeeId,
    first_name,
    last_name,
    email
FROM employee
ORDER BY employeeId;

-- Usage:
SELECT * FROM v_employee_list;
-- This view presents a clean, simplified version of the employee table


-- ╔════════════════════════════════════════════════════════════════════════════╗
-- ║ 2. VIEW WITH WHERE - Active Employees Only                                ║
-- ╚════════════════════════════════════════════════════════════════════════════╝

/*
CONCEPT:
  Views can include filtering logic. Users don't see all rows, only relevant ones.
  Use Case: Marketing dept sees only active marketing employees
  Security: Row-level security - restrict what data is visible
*/

CREATE OR REPLACE VIEW v_active_employees AS
SELECT 
    employeeId,
    CONCAT(first_name, ' ', last_name) AS full_name,
    email,
    salary,
    departmentId
FROM employee
WHERE salary > 0  -- Active employees have salary > 0
ORDER BY full_name;

-- Usage:
SELECT * FROM v_active_employees;
-- Automatically applies the WHERE clause

-- Users don't need to know the filtering criteria


-- ╔════════════════════════════════════════════════════════════════════════════╗
-- ║ 3. VIEW WITH AGGREGATION - Department Statistics                          ║
-- ╚════════════════════════════════════════════════════════════════════════════╝

/*
CONCEPT:
  Views can aggregate data using GROUP BY, SUM, AVG, COUNT, etc.
  Use Case: Dashboard showing department summary statistics
  Note: Views with aggregation are READ-ONLY (cannot UPDATE/DELETE)
*/

CREATE OR REPLACE VIEW v_department_statistics AS
SELECT 
    d.departmentId,
    d.name AS department_name,
    COUNT(e.employeeId) AS employee_count,
    ROUND(AVG(e.salary), 2) AS avg_salary,
    MIN(e.salary) AS min_salary,
    MAX(e.salary) AS max_salary,
    ROUND(SUM(e.salary), 2) AS total_salary
FROM department d
LEFT JOIN employee e ON d.departmentId = e.departmentId
GROUP BY d.departmentId, d.name
ORDER BY employee_count DESC;

-- Usage:
SELECT * FROM v_department_statistics;
-- Result shows: Sales dept has 10 employees, avg salary $75,000, total $750,000

-- Try to update (FAILS - aggregation makes view read-only):
-- UPDATE v_department_statistics SET avg_salary = 80000 WHERE departmentId = 1;
-- Error: Can't update view with aggregate functions


-- ╔════════════════════════════════════════════════════════════════════════════╗
-- ║ 4. VIEW WITH JOIN - Employee Details                                      ║
-- ╚════════════════════════════════════════════════════════════════════════════╝

/*
CONCEPT:
  Combine multiple tables into a single, easy-to-use view
  Use Case: Reports showing employee names + department names together
  Benefit: Users don't need to know the JOIN syntax or foreign key relationships
*/

CREATE OR REPLACE VIEW v_employee_details AS
SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) AS full_name,
    e.email,
    e.salary,
    d.name AS department_name
FROM employee e
LEFT JOIN department d ON e.departmentId = d.departmentId
ORDER BY e.employeeId;

-- Usage:
SELECT * FROM v_employee_details;
-- Single query shows: John Smith | john.smith@... | 85000 | Sales

-- Extract specific department employees:
SELECT * FROM v_employee_details WHERE department_name = 'Engineering';

-- Users don't need to know about the JOIN


-- ╔════════════════════════════════════════════════════════════════════════════╗
-- ║ 5. VIEW WITH MULTIPLE JOINs - Complete Project Information                ║
-- ╚════════════════════════════════════════════════════════════════════════════╝

/*
CONCEPT:
  Complex views combining 3+ tables hide the query complexity
  Use Case: Project detail report needing project + department + employee info
  Benefit: Encapsulation - one query instead of repeated complex JOINs
*/

CREATE OR REPLACE VIEW v_project_details AS
SELECT 
    p.projectId,
    p.project_name,
    p.budget,
    p.status,
    d.name AS department_name,
    COALESCE(COUNT(DISTINCT pa.employeeId), 0) AS assigned_employees,
    GROUP_CONCAT(CONCAT(e.first_name, ' ', e.last_name)) AS employee_names
FROM project p
LEFT JOIN department d ON p.departmentId = d.departmentId
LEFT JOIN project_assignment pa ON p.projectId = pa.projectId
LEFT JOIN employee e ON pa.employeeId = e.employeeId
GROUP BY p.projectId, p.project_name, p.budget, p.status, d.name
ORDER BY p.projectId;

-- Usage:
SELECT * FROM v_project_details;
-- Result: ProjectID=101, Name='Mobile App', Budget=$100k, Status='Active', 
--         Dept='Engineering', Assigned=5, Employees='John Smith, Jane Doe, ...'

-- No need for users to understand GROUP BY or GROUP_CONCAT


-- ╔════════════════════════════════════════════════════════════════════════════╗
-- ║ 6. VIEW WITH COLUMN ALIASES - Simplified Naming                           ║
-- ╚════════════════════════════════════════════════════════════════════════════╝

/*
CONCEPT:
  Use meaningful aliases to make underlying data more intuitive
  Use Case: Expose business terminology instead of table jargon
  Benefit: Non-technical users understand column names
*/

CREATE OR REPLACE VIEW v_team_roster AS
SELECT 
    employeeId AS 'Associate ID',
    first_name AS 'First Name',
    last_name AS 'Last Name',
    email AS 'Work Email',
    salary AS 'Annual Salary',
    departmentId AS 'Department ID'
FROM employee
WHERE salary > 0
ORDER BY employeeId;

-- Usage WITHOUT aliases - confusing:
-- SELECT first_name, last_name, salary FROM employee;

-- Usage WITH view - clear:
SELECT * FROM v_team_roster;
-- Columns: Associate ID, First Name, Last Name, Work Email, Annual Salary, Department ID


-- ╔════════════════════════════════════════════════════════════════════════════╗
-- ║ 7. UPDATEABLE VIEW - Department Management                                ║
-- ╚════════════════════════════════════════════════════════════════════════════╝

/*
CONCEPT:
  Simple views (no JOIN, GROUP BY, aggregates) allow INSERT/UPDATE/DELETE
  Use Case: Department table operations through controlled interface
  Restrictions:
    - No aggregates, GROUP BY, HAVING, DISTINCT
    - No subqueries, UNION, derived tables
    - Can only reference ONE table (or easily updatable JOINs)
    - WITH CHECK OPTION prevents breaking view conditions
*/

CREATE OR REPLACE VIEW v_department_management AS
SELECT 
    departmentId,
    name AS department_name
FROM department
WITH CHECK OPTION;  -- Ensures constraint is maintained

-- Usage - INSERT through view:
INSERT INTO v_department_management (departmentId, department_name)
VALUES (10, 'Customer Success');
-- Inserts into underlying department table

-- Usage - UPDATE through view:
UPDATE v_department_management 
SET department_name = 'Customer Support'
WHERE departmentId = 10;

-- Usage - SELECT through view:
SELECT * FROM v_department_management;

-- Verify the updates reached the underlying table:
SELECT * FROM department WHERE departmentId = 10;


-- ╔════════════════════════════════════════════════════════════════════════════╗
-- ║ 8. VIEW WITH NESTED FUNCTION - Email Formatting                           ║
-- ╚════════════════════════════════════════════════════════════════════════════╝

/*
CONCEPT:
  Views can use SQL functions to transform data
  Use Case: Consistent email formatting, phone formatting, date conversion
  Benefit: Single source of truth for data transformation logic
*/

CREATE OR REPLACE VIEW v_employee_contact AS
SELECT 
    employeeId,
    CONCAT(
        UPPER(SUBSTRING(first_name, 1, 1)),
        LOWER(SUBSTRING(first_name, 2))
    ) AS formatted_first_name,
    UPPER(last_name) AS formatted_last_name,
    LOWER(email) AS email_lowercase,
    LENGTH(email) AS email_length,
    CONCAT('<', email, '>') AS email_formatted
FROM employee
ORDER BY employeeId;

-- Usage:
SELECT * FROM v_employee_contact;
-- Columns: 1, 'John', 'SMITH', 'john.smith@...', 18, '<john.smith@example.com>'

-- Standardized contact format for exports/API


-- ╔════════════════════════════════════════════════════════════════════════════╗
-- ║ 9. VIEW WITH CASE STATEMENT - Employee Classification                     ║
-- ╚════════════════════════════════════════════════════════════════════════════╝

/*
CONCEPT:
  CASE statements in views categorize or classify data
  Use Case: Classify employees as 'Junior', 'Mid-level', 'Senior' based on salary
  Benefit: Business logic centralized in view, not repeated in reports
*/

CREATE OR REPLACE VIEW v_employee_classification AS
SELECT 
    employeeId,
    CONCAT(first_name, ' ', last_name) AS full_name,
    salary,
    CASE 
        WHEN salary < 50000 THEN 'Junior'
        WHEN salary BETWEEN 50000 AND 85000 THEN 'Mid-Level'
        WHEN salary > 85000 THEN 'Senior'
        ELSE 'Unclassified'
    END AS experience_level,
    CASE 
        WHEN salary < 50000 THEN 'Low'
        WHEN salary BETWEEN 50000 AND 75000 THEN 'Medium'
        WHEN salary > 75000 THEN 'High'
    END AS salary_bracket
FROM employee
WHERE salary > 0
ORDER BY salary DESC;

-- Usage:
SELECT * FROM v_employee_classification;
-- Result: John | 85000 | Mid-Level | High
--         Jane | 120000 | Senior | High
--         Bob  | 45000 | Junior | Low

-- Query using classifications:
SELECT 
    experience_level,
    COUNT(*) AS count,
    ROUND(AVG(salary), 2) AS avg_salary
FROM v_employee_classification
GROUP BY experience_level
ORDER BY avg_salary DESC;


-- ╔════════════════════════════════════════════════════════════════════════════╗
-- ║ 10. VIEW FOR SECURITY - Salary Hidden View                                ║
-- ╚════════════════════════════════════════════════════════════════════════════╝

/*
CONCEPT:
  Views restrict access to sensitive columns
  Use Case: HR analysts see salaries; project managers do NOT see salaries
  Benefit: Column-level security without complex database permissions
*/

CREATE OR REPLACE VIEW v_employee_public AS
SELECT 
    employeeId,
    CONCAT(first_name, ' ', last_name) AS full_name,
    email,
    -- Salary HIDDEN for security
    departmentId
FROM employee
ORDER BY employeeId;

-- Usage - Project Manager queries:
SELECT * FROM v_employee_public;
-- Columns: employeeId, full_name, email, departmentId
-- (No salary column visible - secure)

-- Comparison - they CANNOT see salaries via this view:
-- SELECT * FROM v_employee_public WHERE salary > 100000;
-- Error: Unknown column 'salary'

-- If they have access to employee table directly (not recommended):
-- SELECT * FROM employee WHERE salary > 100000;
-- Result: Can see all salaries (why we restrict to view-only access)


-- ╔════════════════════════════════════════════════════════════════════════════╗
-- ║ 11. VIEW MODIFICATION AND DEPENDENCIES                                    ║
-- ╚════════════════════════════════════════════════════════════════════════════╝

/*
CONCEPT:
  ALTER and DROP views; understand cascading effects
  MySQL NOTE: ALTER VIEW has limited scope - cannot change structure significantly
  Recommendation: DROP and recreate if major changes needed

MODIFICATION PATTERNS:
  CREATE OR REPLACE VIEW - Non-destructive modification (only column expansion)
  ALTER VIEW - New query for existing view (MySQL 5.1+)
  DROP VIEW - Remove view (clean slate)
  DROP VIEW IF EXISTS - Safe cleanup
*/

-- Example: Modify existing view to add a new column
ALTER VIEW v_employee_list AS
SELECT 
    employeeId,
    first_name,
    last_name,
    email,
    salary  -- NEW COLUMN ADDED
FROM employee
ORDER BY employeeId;

-- Check modification:
SELECT * FROM v_employee_list;

-- Show all views in database:
SELECT TABLE_SCHEMA, TABLE_NAME 
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_TYPE = 'VIEW'
AND TABLE_SCHEMA = 'YOUR_DATABASE_NAME'
ORDER BY TABLE_NAME;

-- Show view definition (reveal underlying query):
SHOW CREATE VIEW v_employee_list;

-- Delete a view:
DROP VIEW IF EXISTS v_team_roster;

-- Delete multiple views:
DROP VIEW IF EXISTS v_employee_contact, v_employee_classification;

-- Note: If view depends on another view, drop parent first
-- Example: If v_employee_report uses v_employee_details
-- DROP VIEW v_employee_report;  -- Child first
-- DROP VIEW v_employee_details; -- Parent second


-- ╔════════════════════════════════════════════════════════════════════════════╗
-- ║ 12. BEST PRACTICES AND COMMON MISTAKES                                    ║
-- ╚════════════════════════════════════════════════════════════════════════════╝

/*
BEST PRACTICES:
══════════════════════════════════════════════════════════════════════════════

1. NAMING CONVENTION
   ✅ DO: Use prefix 'v_' to clearly identify views
   ✅ DO: Use descriptive names: v_employee_contact, v_department_statistics
   ❌ DON'T: Abbreviate ambiguously: emp_list, dept_stats

2. COLUMN NAMING IN VIEWS
   ✅ DO: Use explicit aliases with business terminology
       CREATE VIEW v_sales AS 
       SELECT employeeId AS sales_rep_id, salary AS annual_compensation ...
   ❌ DON'T: Leave ambiguous names from JOINs
       SELECT e.employeeId, d.departmentId ...  -- which department?

3. DOCUMENT THE PURPOSE
   ✅ DO: Add comments explaining the view's purpose and use case
       -- Used by: Finance Report, Budgeting Dashboard
       -- Last modified: April 2026
   ❌ DON'T: Create undocumented mystery views

4. AVOID PERFORMANCE PITFALLS
   ✅ DO: Filter data in view WHERE clause (early filtering)
       CREATE VIEW v_active_employees AS
       SELECT * FROM employee WHERE status = 'active';
   ❌ DON'T: Force users to filter manually (late filtering)
       CREATE VIEW v_all_employees AS
       SELECT * FROM employee;  -- Users must re-filter every query

5. USE WITH CHECK OPTION FOR SECURITY
   ✅ DO: Ensure views with WHERE clauses use WITH CHECK OPTION
       CREATE VIEW v_sales_dept AS
       SELECT * FROM employee 
       WHERE departmentId = 3
       WITH CHECK OPTION;  -- Prevents inserting wrong dept
   ❌ DON'T: Allow insertions to violate view logic
       CREATE VIEW v_sales_dept AS
       SELECT * FROM employee WHERE departmentId = 3;
       -- Someone could INSERT with departmentId = 5 (bypasses filter)

6. UNDERSTAND UPDATEABILITY RESTRICTIONS
   ✅ DO: Create simple views for updatable operations
       CREATE VIEW v_departments AS
       SELECT departmentId, name FROM department;
       -- Can INSERT/UPDATE/DELETE
   ❌ DON'T: Expect to update views with JOINs or aggregates
       CREATE VIEW v_dept_stats AS
       SELECT d.name, COUNT(e.employeeId) AS emp_count
       FROM department d LEFT JOIN employee e ...
       GROUP BY d.name;
       -- Cannot INSERT/UPDATE/DELETE through view

COMMON MISTAKES:
══════════════════════════════════════════════════════════════════════════════

MISTAKE 1: Creating Views Without Understanding Updateability
   ❌ WRONG:
   CREATE VIEW v_data AS SELECT * FROM table_with_joins;
   INSERT INTO v_data VALUES (...);  -- FAILS!
   
   ✅ RIGHT:
   -- Check if view is updateable (no GROUP BY, no aggregates, single table)
   -- Only then attempt INSERT/UPDATE/DELETE

MISTAKE 2: Views That Become Orphaned
   ❌ WRONG:
   CREATE VIEW v_report AS SELECT * FROM staging_table;
   -- Months later, DROP TABLE staging_table;
   -- Now v_report is broken!
   
   ✅ RIGHT:
   -- Use permanent tables or track dependencies
   -- Check dependent views before dropping tables:
   SELECT * FROM INFORMATION_SCHEMA.VIEWS 
   WHERE TABLE_SCHEMA = 'your_db' 
   AND VIEW_DEFINITION LIKE '%staging_table%';

MISTAKE 3: Overcomplicating Views
   ❌ WRONG:
   CREATE VIEW v_everything AS
   SELECT * FROM (100-line subquery with 8 JOINs and 4 CTEs)
   
   ✅ RIGHT:
   -- Keep views simple and focused
   -- Create layered views if needed:
   CREATE VIEW v_emp_dept AS SELECT * FROM emp JOIN dept ...;
   CREATE VIEW v_emp_projects AS SELECT * FROM v_emp_dept JOIN proj ...;

MISTAKE 4: Forgetting to Document Changes
   ❌ WRONG:
   ALTER VIEW v_report AS ... -- NO comment about what changed
   
   ✅ RIGHT:
   -- MODIFIED April 2026: Added salary_range column for payroll report
   ALTER VIEW v_report AS ...

MISTAKE 5: Using Views as Performance Optimization (Wrong!)
   ❌ WRONG:
   "Let's use a view to cache results and improve performance"
   -- Views don't cache; each query re-executes the view definition
   
   ✅ RIGHT:
   -- For performance, use:
   -- 1. Materialized views (stored result, manual refresh)
   -- 2. Database indexes on underlying tables
   -- 3. Query optimization (WHERE clauses, JOINs)
   -- 4. Summary tables (manually updated)

MISTAKE 6: Circular View Dependencies
   ❌ WRONG:
   CREATE VIEW v_A AS SELECT * FROM v_B;
   CREATE VIEW v_B AS SELECT * FROM v_A;
   
   ✅ RIGHT:
   -- Views can depend on views, but no circular dependencies
   -- v_A depends on v_B depends on base tables (one-way flow)

PERFORMANCE TIPS:
══════════════════════════════════════════════════════════════════════════════

1. Views don't cache results - each query re-runs the view query
2. Indexes on underlying tables WILL be used (if view filters allows)
3. Complex views (many JOINs + GROUP BY) can be slow
4. For frequently-accessed aggregations, consider materialized views
5. EXPLAIN a view query to see execution plan:
   EXPLAIN SELECT * FROM v_employee_details WHERE departmentId = 1;
*/


-- ╔════════════════════════════════════════════════════════════════════════════╗
-- ║ PRACTICE QUESTIONS                                                        ║
-- ╚════════════════════════════════════════════════════════════════════════════╝

/*
1. Create a view v_high_earners showing employees earning > $80,000
   Display: full_name, salary, department_name

2. Create a view v_team_composition showing:
   - department_name, employee_count, avg_salary, total_salary

3. Create a read-only view v_salary_secrets that hides salary information
   Hint: Don't include salary column

4. Create an updateable view v_project_status for project management
   Include: projectId, project_name, status

5. Create a view v_employee_directory with formatted email addresses
   Hint: Use CONCAT, LOWER, email formatting functions

6. Create a view v_department_headcount using aggregation
   Show: department_name, employee_count, avg_salary

7. Create a view v_project_team showing projects with assigned employees
   Hint: Use JOINs with project_assignment and employee tables

8. Modify v_high_earners to also include departmentId

9. Show the definition of v_employee_details view
   Hint: Use SHOW CREATE VIEW command

10. Drop the view v_team_roster (use IF EXISTS for safety)

11. Create a view v_salary_distribution categorizing employees as:
    'Executive' (>$100k), 'Manager' ($75-100k), 'Staff' (<$75k)

12. Create a view v_active_projects showing only 'Active' status projects
    with department and employee assignment count

13. Query v_active_projects to find projects with > 5 assigned employees

14. Create a view v_department_performance showing:
    department_name, employee_count, avg_salary, total_salary
    Then list departments with avg_salary > $70,000

15. Create a view v_employee_with_department and use it to find
    all employees in Sales department
*/


-- ╔════════════════════════════════════════════════════════════════════════════╗
-- ║ WHAT YOU LEARNED                                                          ║
-- ╚════════════════════════════════════════════════════════════════════════════╝

/*
IN THIS GUIDE, YOU LEARNED:

✓ VIEW FUNDAMENTALS
  - Views are virtual tables created from SQL queries
  - Stored in database (unlike CTEs which are temporary)
  - Reusable across multiple queries
  - Provide abstraction and encapsulation

✓ TYPES OF VIEWS CREATED
  - Simple views: Single table, no aggregation
  - Complex views: JOINs, aggregations, functions
  - Updateable views: Support INSERT/UPDATE/DELETE
  - Read-only views: With aggregates, JOINs, or CASE statements

✓ PRACTICAL EXAMPLES (10 real-world scenarios)
  1. Simple employee list view
  2. Filtered active employees
  3. Department statistics with aggregation
  4. Employee details with department JOIN
  5. Project information with multiple JOINs
  6. Column alias standardization
  7. Updateable view for back-office operations
  8. Data transformation with functions
  9. Business logic with CASE statements
  10. Security through column restriction

✓ VIEW OPERATIONS
  - CREATE OR REPLACE VIEW: Non-destructive modifications
  - ALTER VIEW: Change underlying query
  - DROP VIEW: Remove view (requires dropping dependents first)
  - SHOW CREATE VIEW: Display view definition

✓ BEST PRACTICES
  - Use 'v_' prefix for clear identification
  - Provide explicit column aliases
  - Add documentation comments
  - Filter data in view WHERE clause, not in queries
  - Use WITH CHECK OPTION for enforced constraints
  - Understand updateability restrictions
  - Track dependencies to avoid orphaned views

✓ COMMON MISTAKES TO AVOID
  - Expecting updateability from complex views
  - Creating orphaned views (depending on dropped objects)
  - Over-complicating view logic
  - Forgetting documentation
  - Assuming views cache results (they don't!)
  - Creating circular dependencies

✓ PERFORMANCE INSIGHTS
  - Views re-execute their query each time (no caching)
  - Indexes on underlying tables are used effectively
  - Indexes in WHERE clause conditions help performance
  - Complex views (many JOINs + GROUP BY) can be slow
  - EXPLAIN shows execution plan for view queries

✓ SECURITY APPLICATIONS
  - Row-level security: Hide rows with WHERE
  - Column-level security: Exclude sensitive columns
  - Business logic protection: Encapsulate complex queries
  - WITH CHECK OPTION: Prevent constraint violations

KEY DIFFERENCE: VIEWS vs CTEs
  Views           → Permanent, reusable, can be indexed, support 3 operations
  CTEs            → Temporary, single query, fast, complex scenarios
  Use together    → CTE within view definition for layered complexity

NEXT STEPS:
  1. Create views for your real data
  2. Test updateability on simple views
  3. Build layered views (view depending on view)
  4. Set up column-level security using views
  5. Use SHOW CREATE VIEW to understand existing database views
  6. Combine views with CTEs for advanced reporting
*/

