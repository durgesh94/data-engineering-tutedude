/*
╔════════════════════════════════════════════════════════════════════════════╗
║                    SQL INDEXES - COMPREHENSIVE GUIDE                      ║
╚════════════════════════════════════════════════════════════════════════════╝

Author: Durgesh Tambe
Date: April 27, 2026
Version: 1.0
Database: MySQL 5.7+

PURPOSE:
Indexes improve query performance by helping the database locate rows faster
without scanning the entire table. They are especially useful for columns used
in WHERE, JOIN, ORDER BY, and GROUP BY clauses. They provide:
- Faster lookups on frequently searched columns
- Better join performance
- Improved sorting and grouping speed
- Enforced uniqueness through unique indexes
- Better performance for composite search conditions

KEY CONCEPTS:
┌──────────────────────┬───────────────────────────────────────────────────┐
│ Component            │ Description                                       │
├──────────────────────┼───────────────────────────────────────────────────┤
│ Index                │ Data structure used to speed up row lookup        │
│ Primary Key Index    │ Automatically created for PRIMARY KEY columns     │
│ Unique Index         │ Prevents duplicate values in indexed columns      │
│ Composite Index      │ Index built on multiple columns together          │
│ Single-Column Index  │ Index created on one column only                  │
│ Selectivity          │ How unique the indexed values are                 │
│ Cardinality          │ Number of distinct values in the index            │
│ EXPLAIN              │ Command to inspect query execution plan           │
└──────────────────────┴───────────────────────────────────────────────────┘

SYNTAX:
	CREATE INDEX index_name ON table_name(column_name);
	CREATE UNIQUE INDEX index_name ON table_name(column_name);
	CREATE INDEX index_name ON table_name(column1, column2);

	SHOW INDEX FROM table_name;
	DROP INDEX index_name ON table_name;

INDEX TYPES:
	1. Primary Key Index   - Created automatically on PRIMARY KEY
	2. Unique Index        - Enforces uniqueness
	3. Single-Column Index - Optimizes one column lookups
	4. Composite Index     - Optimizes multi-column lookups
	5. Foreign Key Support - Commonly added on join columns for faster joins

TABLE OF CONTENTS:
═══════════════════════════════════════════════════════════════════════════════
1.  Show Existing Automatic Indexes
2.  Single-Column Index on Employee Salary
3.  Unique Index on Department Name
4.  Composite Index on Project Department and Status
5.  Composite Index on Project Assignment Lookup
6.  Index for Sorting and Filtering by Project Start Date
7.  Using EXPLAIN to Verify Index Usage
8.  Show and Drop Indexes
9.  Best Practices and Common Mistakes
═══════════════════════════════════════════════════════════════════════════════

ASSUMPTIONS:
All examples use existing tables from '../02-manipulation/' folder:
- employee (employeeId, first_name, last_name, email, salary, departmentId)
- department (departmentId, name)
- project (projectId, project_name, description, start_date, end_date, budget, departmentId, status)
- project_assignment (assignment_id, employeeId, projectId, role, allocation_percentage, assignment_date)
*/

-- ╔════════════════════════════════════════════════════════════════════════════╗
-- ║ 1. SHOW EXISTING AUTOMATIC INDEXES                                         ║
-- ╚════════════════════════════════════════════════════════════════════════════╝

/*
CONCEPT:
	Some indexes are created automatically by constraints such as PRIMARY KEY
	and UNIQUE. Before adding new indexes, inspect what already exists.
	Use Case: Avoid creating duplicate or unnecessary indexes.
*/

SHOW INDEX FROM employee;
SHOW INDEX FROM department;
SHOW INDEX FROM project;
SHOW INDEX FROM project_assignment;

-- Notes:
-- 1. PRIMARY KEY creates an index automatically.
-- 2. UNIQUE columns such as employee.email and project.project_name already
--    have supporting unique indexes.


-- ╔════════════════════════════════════════════════════════════════════════════╗
-- ║ 2. SINGLE-COLUMN INDEX ON EMPLOYEE SALARY                                  ║
-- ╚════════════════════════════════════════════════════════════════════════════╝

/*
CONCEPT:
	A single-column index is useful when one column is frequently used in WHERE,
	ORDER BY, or range filters.
	Use Case: Speed up salary-based filtering and sorting.
*/

CREATE INDEX idx_employee_salary
ON employee(salary);

-- Example query that can benefit from this index:
SELECT
		employeeId,
		first_name,
		last_name,
		salary
FROM employee
WHERE salary >= 50000
ORDER BY salary DESC;


-- ╔════════════════════════════════════════════════════════════════════════════╗
-- ║ 3. UNIQUE INDEX ON DEPARTMENT NAME                                         ║
-- ╚════════════════════════════════════════════════════════════════════════════╝

/*
CONCEPT:
	A unique index ensures that duplicate values cannot be inserted.
	Use Case: Make sure department names remain unique across the table.
*/

CREATE UNIQUE INDEX idx_department_name_unique
ON department(name);

-- Example effect:
-- Duplicate department names such as two rows with 'HR' will not be allowed.


-- ╔════════════════════════════════════════════════════════════════════════════╗
-- ║ 4. COMPOSITE INDEX ON PROJECT DEPARTMENT AND STATUS                        ║
-- ╚════════════════════════════════════════════════════════════════════════════╝

/*
CONCEPT:
	A composite index stores multiple columns in a defined order.
	Use Case: Optimize queries that filter by department first and then status.
	Important: Column order matters. This index is best for queries starting with
	departmentId, or with departmentId and status together.
*/

CREATE INDEX idx_project_department_status
ON project(departmentId, status);

-- Example query that can benefit from this index:
SELECT
		projectId,
		project_name,
		status,
		budget
FROM project
WHERE departmentId = 2
	AND status = 'Active';


-- ╔════════════════════════════════════════════════════════════════════════════╗
-- ║ 5. COMPOSITE INDEX ON PROJECT ASSIGNMENT LOOKUP                            ║
-- ╚════════════════════════════════════════════════════════════════════════════╝

/*
CONCEPT:
	Join tables often need indexes on lookup columns because they are frequently
	used in joins and filters.
	Use Case: Speed up employee-to-project assignment searches.
*/

CREATE INDEX idx_project_assignment_employee_project
ON project_assignment(employeeId, projectId);

-- Example query that can benefit from this index:
SELECT
		pa.assignment_id,
		pa.role,
		pa.allocation_percentage,
		pa.assignment_date
FROM project_assignment pa
WHERE pa.employeeId = 1
	AND pa.projectId = 101;

-- Note:
-- This table already has a UNIQUE constraint on (employeeId, projectId), which
-- may already create a supporting index in MySQL. Check with SHOW INDEX first.


-- ╔════════════════════════════════════════════════════════════════════════════╗
-- ║ 6. INDEX FOR SORTING AND FILTERING BY PROJECT START DATE                   ║
-- ╚════════════════════════════════════════════════════════════════════════════╝

/*
CONCEPT:
	Indexes can help queries that filter by a date range and sort by the same
	date column.
	Use Case: Faster retrieval of recent projects ordered by start date.
*/

CREATE INDEX idx_project_start_date
ON project(start_date);

-- Example query that can benefit from this index:
SELECT
		projectId,
		project_name,
		start_date,
		end_date,
		status
FROM project
WHERE start_date >= '2026-01-01'
ORDER BY start_date;


-- ╔════════════════════════════════════════════════════════════════════════════╗
-- ║ 7. USING EXPLAIN TO VERIFY INDEX USAGE                                     ║
-- ╚════════════════════════════════════════════════════════════════════════════╝

/*
CONCEPT:
	EXPLAIN shows how MySQL executes a query and whether an index is used.
	Use Case: Confirm that your new index is helping instead of guessing.
*/

EXPLAIN
SELECT
		employeeId,
		first_name,
		last_name,
		salary
FROM employee
WHERE salary >= 50000;

EXPLAIN
SELECT
		projectId,
		project_name,
		status
FROM project
WHERE departmentId = 2
	AND status = 'Active';

-- What to inspect in EXPLAIN output:
-- 1. key   -> Which index MySQL chooses
-- 2. type  -> Access method (ref, range, index, ALL)
-- 3. rows  -> Estimated number of rows scanned
-- 4. Extra -> Additional information such as Using where or Using index


-- ╔════════════════════════════════════════════════════════════════════════════╗
-- ║ 8. SHOW AND DROP INDEXES                                                   ║
-- ╚════════════════════════════════════════════════════════════════════════════╝

/*
CONCEPT:
	Indexes should be reviewed and removed if they are unused or duplicated.
	Use Case: Maintain healthy write performance and avoid storage waste.
*/

-- Show all indexes on a table:
SHOW INDEX FROM project;

-- Drop indexes when no longer needed:
DROP INDEX idx_employee_salary ON employee;
DROP INDEX idx_department_name_unique ON department;
DROP INDEX idx_project_department_status ON project;
DROP INDEX idx_project_start_date ON project;

-- Important:
-- Dropping an index can slow down read queries, so verify before removing it.


-- ╔════════════════════════════════════════════════════════════════════════════╗
-- ║ 9. BEST PRACTICES AND COMMON MISTAKES                                      ║
-- ╚════════════════════════════════════════════════════════════════════════════╝

/*
BEST PRACTICES:
	1. Create indexes on columns used frequently in WHERE, JOIN, ORDER BY, and GROUP BY.
	2. Prefer composite indexes when queries filter on multiple columns together.
	3. Put the most selective and commonly filtered leading column first when designing composite indexes.
	4. Use EXPLAIN before and after index creation to verify improvement.
	5. Review existing indexes first to avoid duplicates.
	6. Index foreign key columns used heavily in joins.

COMMON MISTAKES:
	1. Creating too many indexes, which slows INSERT, UPDATE, and DELETE operations.
	2. Adding an index on columns with very low selectivity unless query patterns justify it.
	3. Ignoring column order in a composite index.
	4. Forgetting that PRIMARY KEY and UNIQUE constraints often already create indexes.
	5. Assuming an index is used without checking EXPLAIN.

RULE OF THUMB:
	Indexes improve read performance but add write overhead.
	Always balance faster SELECT queries against slower INSERT and UPDATE operations.
*/
