/*
================================================================================
  SQL FULL OUTER JOIN COMPREHENSIVE GUIDE
================================================================================
  File: full-outer-join-cmd.sql
  Description: Complete tutorial on FULL OUTER JOIN (FULL JOIN) with practical 
               examples using employee, department, project, and project_assignment tables.
  
  AUTHOR: Durgesh Tambe
  CREATED: April 24, 2026
  UPDATED: April 24, 2026
  VERSION: 1.0
  
  WHAT IS FULL OUTER JOIN?
  ─────────────────────────────────────────────────────────────────────────────
  FULL OUTER JOIN returns ALL records from BOTH tables. If there's no match,
  NULL values are returned for columns from the table with no match.
  
  ⚠️  IMPORTANT: MySQL DoesNOT support FULL OUTER JOIN syntax directly!
  
  Database Support:
    ✅ PostgreSQL ............ FULL OUTER JOIN OR FULL JOIN supported
    ✅ SQL Server ............ FULL OUTER JOIN OR FULL JOIN supported
    ✅ Oracle ................ FULL OUTER JOIN OR FULL JOIN supported
    ❌ MySQL ................. NOT supported (use UNION workaround)
    ❌ SQLite ................ NOT supported (use UNION workaround)
  
  MySQL Workaround (UNION Method):
    Use the UNION of LEFT JOIN and RIGHT JOIN to achieve FULL OUTER effect:
    
    SELECT columns
    FROM table1
    LEFT JOIN table2 ON table1.column = table2.column
    
    UNION
    
    SELECT columns
    FROM table1
    RIGHT JOIN table2 ON table1.column = table2.column;
  
  How UNION works:
    - UNION combines result sets from both queries vertically
    - UNION automatically removes duplicate rows
    - Matching records appear only once (correct behavior)
    - Unmatched records from both sides appear with NULLs
  
  FULL OUTER = (LEFT JOIN) UNION (RIGHT JOIN):
    This is the MySQL-compatible equivalent
  
  Key Characteristics:
    ✓ Returns ALL records from BOTH tables
    ✓ Matching records appear once with data from both tables
    ✓ Unmatched records appear with NULLs from non-matching table
    ✓ Includes all records that exist in either table
    ✓ NOT supported in MySQL directly (use UNION)
    ✓ Good for data reconciliation and finding ALL differences
  
  When to use FULL OUTER JOIN:
    - You want ALL records from BOTH tables
    - You need to find records that exist in EITHER table
    - You want to reconcile two datasets
    - You need to identify unmatched records on BOTH sides
    - Example: Show all employees AND all departments (even if unmatched)
    - Example: Show all projects AND all assignments (even if unmatched)
    - Example: Data migration validation (comparing old vs new)
  
  FULL OUTER JOIN = LEFT JOIN UNION RIGHT JOIN:
    In MySQL, use UNION to combine LEFT and RIGHT JOIN results
    This gives you the FULL OUTER effect
  
  LEFT JOIN vs RIGHT JOIN vs INNER JOIN vs FULL OUTER JOIN:
    ┌──────────────┬───────────┬───────────┬────────────┬────────────┐
    │ Record Type  │ INNER     │ LEFT      │ RIGHT      │ FULL OUTER │
    ├──────────────┼───────────┼───────────┼────────────┼────────────┤
    │ Match both   │ ✓ Yes     │ ✓ Yes     │ ✓ Yes      │ ✓ Yes      │
    │ Left only    │ ✗ No      │ ✓ Yes     │ ✗ No       │ ✓ Yes      │
    │ Right only   │ ✗ No      │ ✗ No      │ ✓ Yes      │ ✓ Yes      │
    └──────────────┴───────────┴───────────┴────────────┴────────────┘
  
  TABLE OF CONTENTS:
    1. Basic FULL OUTER JOIN (using UNION)
    2. FULL OUTER JOIN - Finding unmatched records
    3. FULL OUTER JOIN with COALESCE (handle NULLs)
    4. FULL OUTER JOIN with CASE statement
    5. FULL OUTER JOIN with 3 tables
    6. FULL OUTER JOIN with 4 tables
    7. FULL OUTER JOIN with aggregation
    8. FULL OUTER JOIN for data reconciliation
    9. FULL OUTER JOIN with DISTINCT
    10. FULL OUTER JOIN - Data quality analysis
    
  PREREQUISITES:
    - employee table: employeeId, first_name, last_name, salary, departmentId
    - department table: departmentId, name
    - project table: projectId, project_name, budget, departmentId, status
    - project_assignment: assignment_id, employeeId, projectId, role, allocation_percentage
    
  MySQL NOTE:
    MySQL does not support FULL OUTER JOIN syntax directly.
    Use: (LEFT JOIN) UNION (RIGHT JOIN) to achieve same result
    
  EXECUTION:
    - Execute each example individually
    - Pay attention to NULL values on both sides
    - Understand UNION syntax (combines vertical results)
    - Compare with LEFT/RIGHT/INNER examples
================================================================================
*/

-- ============================================================================
-- 1. BASIC FULL OUTER JOIN - Two Tables
-- ============================================================================
-- Show ALL employees AND all departments (even if unmatched)
-- MySQL: Use UNION of LEFT JOIN and RIGHT JOIN

-- Method 1: Using LEFT JOIN UNION RIGHT JOIN (MySQL Compatible)
SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    d.departmentId,
    d.name as department_name
FROM employee e
LEFT JOIN department d ON e.departmentId = d.departmentId

UNION

SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    d.departmentId,
    d.name as department_name
FROM employee e
RIGHT JOIN department d ON e.departmentId = d.departmentId
ORDER BY employeeId, departmentId;

-- ============================================================================
-- 1B. FULL OUTER JOIN - Alternative presentation with row type
-- ============================================================================
-- Shows which records are from left only, right only, or matched
SELECT 
    COALESCE(e.employeeId, -1) as employee_id,
    COALESCE(CONCAT(e.first_name, ' ', e.last_name), 'N/A') as employee_name,
    COALESCE(d.departmentId, -1) as dept_id,
    COALESCE(d.name, 'N/A') as department_name,
    CASE 
        WHEN e.employeeId IS NOT NULL AND d.departmentId IS NOT NULL THEN 'MATCHED'
        WHEN e.employeeId IS NOT NULL AND d.departmentId IS NULL THEN 'LEFT_ONLY'
        WHEN e.employeeId IS NULL AND d.departmentId IS NOT NULL THEN 'RIGHT_ONLY'
    END as join_type
FROM employee e
FULL OUTER JOIN department d ON e.departmentId = d.departmentId
ORDER BY join_type, employee_id, dept_id;

-- ============================================================================
-- 2. FULL OUTER JOIN - Finding unmatched records on BOTH sides
-- ============================================================================
-- Find employees with NO department AND departments with NO employees

SELECT 
    e.employeeId,
    CONCAT(COALESCE(e.first_name, ''), ' ', COALESCE(e.last_name, '')) as employee_name,
    d.departmentId,
    d.name as department_name
FROM employee e
FULL OUTER JOIN department d ON e.departmentId = d.departmentId
WHERE e.departmentId IS NULL OR d.departmentId IS NULL
ORDER BY CASE WHEN e.employeeId IS NULL THEN 1 ELSE 0 END, e.employeeId;

-- ============================================================================
-- 2B. FULL OUTER JOIN - Unmatched projects and assignments
-- ============================================================================
-- Show all projects AND all assignments, highlighting unmatched

SELECT 
    COALESCE(p.projectId, -1) as project_id,
    COALESCE(p.project_name, 'UNASSIGNED_ROLE') as project_name,
    COALESCE(pa.assignment_id, -1) as assignment_id,
    COALESCE(pa.role, 'NO_PROJECT') as role
FROM project p
FULL OUTER JOIN project_assignment pa ON p.projectId = pa.projectId
WHERE p.projectId IS NULL OR pa.projectId IS NULL
ORDER BY project_id, assignment_id;

-- ============================================================================
-- 3. FULL OUTER JOIN with COALESCE - Handle NULLs gracefully
-- ============================================================================
-- Replace NULLs with meaningful defaults
SELECT 
    COALESCE(e.employeeId, 0) as employee_id,
    COALESCE(CONCAT(e.first_name, ' ', e.last_name), 'No Employee') as employee_name,
    COALESCE(e.salary, 0) as salary,
    COALESCE(d.departmentId, 0) as dept_id,
    COALESCE(d.name, 'Unassigned Department') as department_name
FROM employee e
FULL OUTER JOIN department d ON e.departmentId = d.departmentId
ORDER BY d.departmentId, e.last_name;

-- ============================================================================
-- 3B. FULL OUTER JOIN - Project and assignment reconciliation
-- ============================================================================
-- Show all projects and assignments with defaults for missing data
SELECT 
    COALESCE(p.projectId, -1) as project_id,
    COALESCE(p.project_name, 'NO_PROJECT_ASSIGNED') as project_name,
    COALESCE(p.budget, 0) as budget,
    COALESCE(pa.assignment_id, -1) as assignment_id,
    COALESCE(e.employeeId, -1) as employee_id,
    COALESCE(CONCAT(e.first_name, ' ', e.last_name), 'No Employee') as employee_name,
    COALESCE(pa.role, 'No Role') as role
FROM project p
FULL OUTER JOIN project_assignment pa ON p.projectId = pa.projectId
FULL OUTER JOIN employee e ON pa.employeeId = e.employeeId
ORDER BY project_id, assignment_id;

-- ============================================================================
-- 4. FULL OUTER JOIN with CASE Statement
-- ============================================================================
-- Categorize record type and data quality

SELECT 
    COALESCE(e.employeeId, 0) as employee_id,
    COALESCE(CONCAT(e.first_name, ' ', e.last_name), 'N/A') as employee_name,
    COALESCE(d.departmentId, 0) as dept_id,
    COALESCE(d.name, 'N/A') as department_name,
    CASE 
        WHEN e.employeeId IS NOT NULL AND d.departmentId IS NOT NULL THEN 'Valid_Match'
        WHEN e.employeeId IS NOT NULL AND d.departmentId IS NULL THEN 'Orphaned_Employee'
        WHEN e.employeeId IS NULL AND d.departmentId IS NOT NULL THEN 'Empty_Department'
        ELSE 'Unknown'
    END as data_quality_flag,
    CASE 
        WHEN e.employeeId IS NOT NULL AND d.departmentId IS NOT NULL THEN 'Good'
        ELSE 'Attention Required'
    END as status
FROM employee e
FULL OUTER JOIN department d ON e.departmentId = d.departmentId
ORDER BY status, employee_id;

-- ============================================================================
-- 4B. FULL OUTER JOIN - Project completion and team status
-- ============================================================================
SELECT 
    COALESCE(p.projectId, -1) as project_id,
    COALESCE(p.project_name, 'UNASSIGNED') as project_name,
    COALESCE(p.status, 'NO_PROJECT') as project_status,
    COALESCE(pa.assignment_id, -1) as assignment_id,
    COALESCE(pa.role, 'N/A') as role,
    CASE 
        WHEN p.projectId IS NOT NULL AND pa.assignment_id IS NOT NULL THEN 'Assigned'
        WHEN p.projectId IS NOT NULL AND pa.assignment_id IS NULL THEN 'Unassigned'
        WHEN p.projectId IS NULL AND pa.assignment_id IS NOT NULL THEN 'Orphaned_Assignment'
        ELSE 'Error'
    END as assignment_status
FROM project p
FULL OUTER JOIN project_assignment pa ON p.projectId = pa.projectId
ORDER BY project_id, assignment_id;

-- ============================================================================
-- 5. FULL OUTER JOIN with 3 Tables
-- ============================================================================
-- Show all employees, all departments, and their projects

SELECT 
    COALESCE(e.employeeId, -1) as employee_id,
    COALESCE(CONCAT(e.first_name, ' ', e.last_name), 'No Employee') as employee_name,
    COALESCE(d.name, 'No Department') as department_name,
    COALESCE(p.projectId, -1) as project_id,
    COALESCE(p.project_name, 'No Project') as project_name,
    COALESCE(pa.role, 'No Role') as role
FROM employee e
FULL OUTER JOIN department d ON e.departmentId = d.departmentId
FULL OUTER JOIN project_assignment pa ON e.employeeId = pa.employeeId
FULL OUTER JOIN project p ON pa.projectId = p.projectId
ORDER BY employee_id, project_id;

-- ============================================================================
-- 5B. FULL OUTER JOIN - Complete employee-project relationship map
-- ============================================================================
-- Shows all employees with their departments and all projects
SELECT 
    e.employeeId,
    CONCAT(COALESCE(e.first_name, ''), ' ', COALESCE(e.last_name, '')) as employee_name,
    d.name as department_name,
    e.salary,
    p.projectId,
    p.project_name,
    p.budget,
    pa.role,
    pa.allocation_percentage
FROM employee e
FULL OUTER JOIN department d ON e.departmentId = d.departmentId
FULL OUTER JOIN project_assignment pa ON e.employeeId = pa.employeeId
FULL OUTER JOIN project p ON pa.projectId = p.projectId
WHERE e.employeeId IS NOT NULL  -- Focus on actual employees
ORDER BY e.employeeId, p.projectId;

-- ============================================================================
-- 6. FULL OUTER JOIN with 4 Tables
-- ============================================================================
-- Complete view: Employees, Departments, Projects, Assignments

SELECT 
    COALESCE(e.employeeId, 0) as employee_id,
    COALESCE(CONCAT(e.first_name, ' ', e.last_name), 'N/A') as employee_name,
    COALESCE(d.departmentId, 0) as dept_id,
    COALESCE(d.name, 'N/A') as department_name,
    COALESCE(p.projectId, 0) as project_id,
    COALESCE(p.project_name, 'N/A') as project_name,
    COALESCE(pa.assignment_id, 0) as assignment_id,
    COALESCE(pa.role, 'N/A') as role,
    COALESCE(pa.allocation_percentage, 0) as allocation_pct,
    COALESCE(e.salary, 0) as salary
FROM employee e
FULL OUTER JOIN department d ON e.departmentId = d.departmentId
FULL OUTER JOIN project_assignment pa ON e.employeeId = pa.employeeId
FULL OUTER JOIN project p ON pa.projectId = p.projectId
ORDER BY employee_id, project_id, assignment_id;

-- ============================================================================
-- 7. FULL OUTER JOIN with Aggregation
-- ============================================================================
-- Summary statistics showing all departments and their employee counts
-- (even departments with zero employees)

SELECT 
    d.departmentId,
    COALESCE(d.name, 'Unassigned') as department_name,
    COUNT(DISTINCT e.employeeId) as total_employees,
    COALESCE(ROUND(AVG(e.salary), 2), 0) as avg_salary,
    COALESCE(MIN(e.salary), 0) as min_salary,
    COALESCE(MAX(e.salary), 0) as max_salary,
    COUNT(DISTINCT pa.projectId) as project_count
FROM employee e
FULL OUTER JOIN department d ON e.departmentId = d.departmentId
FULL OUTER JOIN project_assignment pa ON e.employeeId = pa.employeeId
GROUP BY d.departmentId, d.name
ORDER BY total_employees DESC, d.name;

-- ============================================================================
-- 7B. FULL OUTER JOIN - Complete project statistics
-- ============================================================================
-- All projects with their team and allocation information
SELECT 
    p.projectId,
    p.project_name,
    p.status,
    p.budget,
    COUNT(DISTINCT pa.assignment_id) as total_assignments,
    COUNT(DISTINCT pa.employeeId) as unique_employees,
    COALESCE(SUM(pa.allocation_percentage), 0) as total_allocation_pct,
    COALESCE(ROUND(AVG(e.salary), 2), 0) as avg_employee_salary,
    COUNT(DISTINCT e.departmentId) as departments_involved
FROM project p
FULL OUTER JOIN project_assignment pa ON p.projectId = pa.projectId
FULL OUTER JOIN employee e ON pa.employeeId = e.employeeId
GROUP BY p.projectId, p.project_name, p.status, p.budget
ORDER BY p.projectId;

-- ============================================================================
-- 8. FULL OUTER JOIN for Data Reconciliation
-- ============================================================================
-- Compare two datasets: employees vs project assignments
-- Identify what's in one but not the other

SELECT 
    'Employees' as data_source,
    COUNT(DISTINCT e.employeeId) as record_count
FROM employee e
LEFT JOIN project_assignment pa ON e.employeeId = pa.employeeId
WHERE pa.assignment_id IS NULL

UNION ALL

SELECT 
    'Project_Assignments' as data_source,
    COUNT(DISTINCT pa.assignment_id) as record_count
FROM project_assignment pa
LEFT JOIN employee e ON pa.employeeId = e.employeeId
WHERE e.employeeId IS NULL;

-- ============================================================================
-- 8B. FULL OUTER JOIN - Data completeness report
-- ============================================================================
-- Classify records by completeness of information
SELECT 
    COALESCE(e.employeeId, pa.employeeId) as employee_ref,
    CASE 
        WHEN e.employeeId IS NOT NULL AND pa.assignment_id IS NOT NULL THEN 'Complete'
        WHEN e.employeeId IS NOT NULL AND pa.assignment_id IS NULL THEN 'Employee_No_Project'
        WHEN e.employeeId IS NULL AND pa.assignment_id IS NOT NULL THEN 'Assignment_No_Employee'
        ELSE 'Unknown'
    END as completeness_status,
    COUNT(*) as count
FROM employee e
FULL OUTER JOIN project_assignment pa ON e.employeeId = pa.employeeId
GROUP BY 
    COALESCE(e.employeeId, pa.employeeId),
    CASE 
        WHEN e.employeeId IS NOT NULL AND pa.assignment_id IS NOT NULL THEN 'Complete'
        WHEN e.employeeId IS NOT NULL AND pa.assignment_id IS NULL THEN 'Employee_No_Project'
        WHEN e.employeeId IS NULL AND pa.assignment_id IS NOT NULL THEN 'Assignment_No_Employee'
        ELSE 'Unknown'
    END
ORDER BY completeness_status;

-- ============================================================================
-- 9. FULL OUTER JOIN with DISTINCT
-- ============================================================================
-- Find all unique combinations of employees and departments

SELECT DISTINCT 
    COALESCE(e.employeeId, -1) as employee_id,
    COALESCE(d.departmentId, -1) as department_id,
    COALESCE(CONCAT(e.first_name, ' ', e.last_name), 'N/A') as employee_name,
    COALESCE(d.name, 'N/A') as department_name
FROM employee e
FULL OUTER JOIN department d ON e.departmentId = d.departmentId
ORDER BY department_id, employee_id;

-- ============================================================================
-- 9B. FULL OUTER JOIN - All unique employee-project combinations
-- ============================================================================
SELECT DISTINCT 
    COALESCE(e.employeeId, 0) as employee_id,
    COALESCE(p.projectId, 0) as project_id,
    COALESCE(CONCAT(e.first_name, ' ', e.last_name), 'No Employee') as employee_name,
    COALESCE(p.project_name, 'No Project') as project_name,
    CASE 
        WHEN e.employeeId IS NOT NULL AND p.projectId IS NOT NULL THEN 'Assigned'
        WHEN e.employeeId IS NOT NULL AND p.projectId IS NULL THEN 'Available'
        WHEN e.employeeId IS NULL AND p.projectId IS NOT NULL THEN 'Understaffed'
    END as status
FROM employee e
FULL OUTER JOIN project_assignment pa ON e.employeeId = pa.employeeId
FULL OUTER JOIN project p ON pa.projectId = p.projectId
ORDER BY employee_id, project_id;

-- ============================================================================
-- 10. FULL OUTER JOIN - Data Quality Analysis Report
-- ============================================================================
-- Generate comprehensive data quality metrics

SELECT 
    'Total Records in Employee Table' as metric,
    COUNT(DISTINCT e.employeeId) as count_value
FROM employee e
LEFT JOIN department d ON e.departmentId = d.departmentId

UNION ALL

SELECT 
    'Total Records in Department Table' as metric,
    COUNT(DISTINCT d.departmentId) as count_value
FROM department d
LEFT JOIN employee e ON d.departmentId = e.departmentId

UNION ALL

SELECT 
    'Employees Matched to Departments' as metric,
    COUNT(DISTINCT e.employeeId) as count_value
FROM employee e
INNER JOIN department d ON e.departmentId = d.departmentId

UNION ALL

SELECT 
    'Employees with NO Department' as metric,
    COUNT(DISTINCT e.employeeId) as count_value
FROM employee e
LEFT JOIN department d ON e.departmentId = d.departmentId
WHERE d.departmentId IS NULL

UNION ALL

SELECT 
    'Departments with NO Employees' as metric,
    COUNT(DISTINCT d.departmentId) as count_value
FROM department d
LEFT JOIN employee e ON d.departmentId = e.departmentId
WHERE e.employeeId IS NULL;

-- ============================================================================
-- 10B. FULL OUTER JOIN - Comprehensive data reconciliation
-- ============================================================================
-- Complete analysis of data consistency across all tables
SELECT 
    'Employees_Total' as metric_type,
    COUNT(*) as count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM employee), 2) as percentage
FROM employee

UNION ALL

SELECT 
    'Departments_Total' as metric_type,
    COUNT(*) as count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM department), 2) as percentage
FROM department

UNION ALL

SELECT 
    'Projects_Total' as metric_type,
    COUNT(*) as count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM project), 2) as percentage
FROM project

UNION ALL

SELECT 
    'Assignments_Total' as metric_type,
    COUNT(*) as count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM project_assignment), 2) as percentage
FROM project_assignment

UNION ALL

SELECT 
    'Employees_Assigned_to_Projects' as metric_type,
    COUNT(DISTINCT pa.employeeId) as count,
    ROUND(COUNT(DISTINCT pa.employeeId) * 100.0 / (SELECT COUNT(*) FROM employee), 2) as percentage
FROM project_assignment pa

UNION ALL

SELECT 
    'Projects_with_Assignments' as metric_type,
    COUNT(DISTINCT pa.projectId) as count,
    ROUND(COUNT(DISTINCT pa.projectId) * 100.0 / (SELECT COUNT(*) FROM project), 2) as percentage
FROM project_assignment pa;

-- ============================================================================
-- MYSQL-SPECIFIC FULL OUTER JOIN QUERIES (UNION Method)
-- ============================================================================
-- All queries in this section are tested and work in MySQL 5.7+ and 8.0+
-- These use the UNION approach to simulate FULL OUTER JOIN

-- ============================================================================
-- MySQL Query 1: Basic FULL OUTER - Employee and Department
-- ============================================================================
SELECT 
    COALESCE(e.employeeId, -1) as employee_id,
    COALESCE(CONCAT(e.first_name, ' ', e.last_name), 'N/A') as employee_name,
    COALESCE(d.departmentId, -1) as dept_id,
    COALESCE(d.name, 'N/A') as department_name
FROM employee e
LEFT JOIN department d ON e.departmentId = d.departmentId

UNION

SELECT 
    COALESCE(e.employeeId, -1) as employee_id,
    COALESCE(CONCAT(e.first_name, ' ', e.last_name), 'N/A') as employee_name,
    COALESCE(d.departmentId, -1) as dept_id,
    COALESCE(d.name, 'N/A') as department_name
FROM employee e
RIGHT JOIN department d ON e.departmentId = d.departmentId
ORDER BY employee_id, dept_id;

-- ============================================================================
-- MySQL Query 2: FULL OUTER with Record Classification
-- ============================================================================
-- Shows join type (Matched, Left Only, Right Only)
SELECT 
    COALESCE(e.employeeId, 0) as employee_id,
    COALESCE(CONCAT(e.first_name, ' ', e.last_name), 'NO_EMPLOYEE') as employee_name,
    COALESCE(d.departmentId, 0) as dept_id,
    COALESCE(d.name, 'NO_DEPARTMENT') as department_name,
    CASE 
        WHEN e.employeeId IS NOT NULL AND d.departmentId IS NOT NULL THEN 'MATCHED'
        WHEN e.employeeId IS NOT NULL AND d.departmentId IS NULL THEN 'LEFT_ONLY'
        WHEN e.employeeId IS NULL AND d.departmentId IS NOT NULL THEN 'RIGHT_ONLY'
    END as record_type
FROM employee e
LEFT JOIN department d ON e.departmentId = d.departmentId

UNION

SELECT 
    COALESCE(e.employeeId, 0) as employee_id,
    COALESCE(CONCAT(e.first_name, ' ', e.last_name), 'NO_EMPLOYEE') as employee_name,
    COALESCE(d.departmentId, 0) as dept_id,
    COALESCE(d.name, 'NO_DEPARTMENT') as department_name,
    CASE 
        WHEN e.employeeId IS NOT NULL AND d.departmentId IS NOT NULL THEN 'MATCHED'
        WHEN e.employeeId IS NOT NULL AND d.departmentId IS NULL THEN 'LEFT_ONLY'
        WHEN e.employeeId IS NULL AND d.departmentId IS NOT NULL THEN 'RIGHT_ONLY'
    END as record_type
FROM employee e
RIGHT JOIN department d ON e.departmentId = d.departmentId
ORDER BY record_type, employee_id;

-- ============================================================================
-- MySQL Query 3: Find Unmatched Records (Both Sides)
-- ============================================================================
-- MySQL compatible: Find employees with NO dept AND depts with NO employees
SELECT 
    COALESCE(e.employeeId, -1) as employee_id,
    COALESCE(CONCAT(e.first_name, ' ', e.last_name), 'N/A') as employee_name,
    COALESCE(d.departmentId, -1) as dept_id,
    COALESCE(d.name, 'N/A') as department_name,
    CASE 
        WHEN e.employeeId IS NULL THEN 'ORPHANED_DEPARTMENT'
        WHEN d.departmentId IS NULL THEN 'UNASSIGNED_EMPLOYEE'
    END as issue_type
FROM employee e
LEFT JOIN department d ON e.departmentId = d.departmentId
WHERE d.departmentId IS NULL

UNION

SELECT 
    COALESCE(e.employeeId, -1) as employee_id,
    COALESCE(CONCAT(e.first_name, ' ', e.last_name), 'N/A') as employee_name,
    COALESCE(d.departmentId, -1) as dept_id,
    COALESCE(d.name, 'N/A') as department_name,
    CASE 
        WHEN e.employeeId IS NULL THEN 'ORPHANED_DEPARTMENT'
        WHEN d.departmentId IS NULL THEN 'UNASSIGNED_EMPLOYEE'
    END as issue_type
FROM employee e
RIGHT JOIN department d ON e.departmentId = d.departmentId
WHERE e.employeeId IS NULL
ORDER BY issue_type, employee_id;

-- ============================================================================
-- MySQL Query 4: Project and Assignment Reconciliation
-- ============================================================================
-- MySQL: Full outer with project assignments
SELECT 
    COALESCE(p.projectId, -1) as project_id,
    COALESCE(p.project_name, 'UNASSIGNED') as project_name,
    COALESCE(pa.assignment_id, -1) as assignment_id,
    COALESCE(pa.role, 'NO_ROLE') as role,
    COALESCE(pa.allocation_percentage, 0) as allocation_pct
FROM project p
LEFT JOIN project_assignment pa ON p.projectId = pa.projectId

UNION

SELECT 
    COALESCE(p.projectId, -1) as project_id,
    COALESCE(p.project_name, 'UNASSIGNED') as project_name,
    COALESCE(pa.assignment_id, -1) as assignment_id,
    COALESCE(pa.role, 'NO_ROLE') as role,
    COALESCE(pa.allocation_percentage, 0) as allocation_pct
FROM project p
RIGHT JOIN project_assignment pa ON p.projectId = pa.projectId
ORDER BY project_id, assignment_id;

-- ============================================================================
-- MySQL Query 5: Three-Table FULL OUTER JOIN
-- ============================================================================
-- MySQL: Employees, Departments, and Projects
SELECT 
    COALESCE(e.employeeId, -1) as employee_id,
    COALESCE(CONCAT(e.first_name, ' ', e.last_name), 'NO_EMP') as employee_name,
    COALESCE(d.departmentId, -1) as dept_id,
    COALESCE(d.name, 'NO_DEPT') as department_name,
    COALESCE(p.projectId, -1) as project_id,
    COALESCE(p.project_name, 'NO_PROJECT') as project_name,
    COALESCE(pa.role, 'NO_ROLE') as role
FROM employee e
LEFT JOIN department d ON e.departmentId = d.departmentId
LEFT JOIN project_assignment pa ON e.employeeId = pa.employeeId
LEFT JOIN project p ON pa.projectId = p.projectId

UNION

SELECT 
    COALESCE(e.employeeId, -1) as employee_id,
    COALESCE(CONCAT(e.first_name, ' ', e.last_name), 'NO_EMP') as employee_name,
    COALESCE(d.departmentId, -1) as dept_id,
    COALESCE(d.name, 'NO_DEPT') as department_name,
    COALESCE(p.projectId, -1) as project_id,
    COALESCE(p.project_name, 'NO_PROJECT') as project_name,
    COALESCE(pa.role, 'NO_ROLE') as role
FROM employee e
RIGHT JOIN department d ON e.departmentId = d.departmentId
LEFT JOIN project_assignment pa ON e.employeeId = pa.employeeId
LEFT JOIN project p ON pa.projectId = p.projectId
WHERE e.employeeId IS NULL

UNION

SELECT 
    COALESCE(e.employeeId, -1) as employee_id,
    COALESCE(CONCAT(e.first_name, ' ', e.last_name), 'NO_EMP') as employee_name,
    COALESCE(d.departmentId, -1) as dept_id,
    COALESCE(d.name, 'NO_DEPT') as department_name,
    COALESCE(p.projectId, -1) as project_id,
    COALESCE(p.project_name, 'NO_PROJECT') as project_name,
    COALESCE(pa.role, 'NO_ROLE') as role
FROM employee e
LEFT JOIN department d ON e.departmentId = d.departmentId
RIGHT JOIN project_assignment pa ON e.employeeId = pa.employeeId
LEFT JOIN project p ON pa.projectId = p.projectId
WHERE pa.assignment_id IS NOT NULL
ORDER BY employee_id, project_id;

-- ============================================================================
-- MySQL Query 6: Aggregation with FULL OUTER JOIN
-- ============================================================================
-- MySQL: Departments with employee stats (including empty depts)
SELECT 
    COALESCE(d.departmentId, -1) as dept_id,
    COALESCE(d.name, 'UNASSIGNED') as department_name,
    COUNT(DISTINCT e.employeeId) as employee_count,
    COALESCE(ROUND(AVG(e.salary), 2), 0) as avg_salary,
    COALESCE(MIN(e.salary), 0) as min_salary,
    COALESCE(MAX(e.salary), 0) as max_salary,
    COUNT(DISTINCT pa.projectId) as project_count
FROM department d
LEFT JOIN employee e ON d.departmentId = e.departmentId
LEFT JOIN project_assignment pa ON e.employeeId = pa.employeeId
GROUP BY d.departmentId, d.name

UNION

SELECT 
    COALESCE(d.departmentId, -1) as dept_id,
    COALESCE(d.name, 'UNASSIGNED') as department_name,
    COUNT(DISTINCT e.employeeId) as employee_count,
    COALESCE(ROUND(AVG(e.salary), 2), 0) as avg_salary,
    COALESCE(MIN(e.salary), 0) as min_salary,
    COALESCE(MAX(e.salary), 0) as max_salary,
    COUNT(DISTINCT pa.projectId) as project_count
FROM department d
RIGHT JOIN employee e ON d.departmentId = e.departmentId
LEFT JOIN project_assignment pa ON e.employeeId = pa.employeeId
WHERE d.departmentId IS NULL
GROUP BY d.departmentId, d.name
ORDER BY dept_id;

-- ============================================================================
-- MySQL Query 7: Data Quality Report with FULL OUTER
-- ============================================================================
-- MySQL: Comprehensive data quality metrics
SELECT 
    'Employees_with_Departments' as data_source,
    COUNT(DISTINCT e.employeeId) as total_count,
    ROUND(COUNT(DISTINCT e.employeeId) * 100.0 / 
        (SELECT COUNT(DISTINCT employeeId) FROM employee), 2) as percentage,
    COALESCE(ROUND(AVG(e.salary), 2), 0) as avg_value
FROM employee e
LEFT JOIN department d ON e.departmentId = d.departmentId
WHERE d.departmentId IS NOT NULL

UNION

SELECT 
    'Employees_without_Departments' as data_source,
    COUNT(DISTINCT e.employeeId) as total_count,
    ROUND(COUNT(DISTINCT e.employeeId) * 100.0 / 
        (SELECT COUNT(DISTINCT employeeId) FROM employee), 2) as percentage,
    COALESCE(ROUND(AVG(e.salary), 2), 0) as avg_value
FROM employee e
LEFT JOIN department d ON e.departmentId = d.departmentId
WHERE d.departmentId IS NULL

UNION

SELECT 
    'Departments_with_Employees' as data_source,
    COUNT(DISTINCT d.departmentId) as total_count,
    ROUND(COUNT(DISTINCT d.departmentId) * 100.0 / 
        (SELECT COUNT(DISTINCT departmentId) FROM department), 2) as percentage,
    0 as avg_value
FROM department d
LEFT JOIN employee e ON d.departmentId = e.departmentId
WHERE e.employeeId IS NOT NULL

UNION

SELECT 
    'Departments_without_Employees' as data_source,
    COUNT(DISTINCT d.departmentId) as total_count,
    ROUND(COUNT(DISTINCT d.departmentId) * 100.0 / 
        (SELECT COUNT(DISTINCT departmentId) FROM department), 2) as percentage,
    0 as avg_value
FROM department d
LEFT JOIN employee e ON d.departmentId = e.departmentId
WHERE e.employeeId IS NULL
ORDER BY data_source;

-- ============================================================================
-- MySQL Query 8: Reconciliation Report (Unmatched Data)
-- ============================================================================
-- MySQL: Find all unmatched records efficiently
SELECT 
    'Unassigned_Employees' as unmatched_type,
    COUNT(DISTINCT e.employeeId) as count_value,
    GROUP_CONCAT(DISTINCT CONCAT(e.first_name, ' ', e.last_name) SEPARATOR ', ') as details
FROM employee e
LEFT JOIN department d ON e.departmentId = d.departmentId
WHERE d.departmentId IS NULL

UNION

SELECT 
    'Empty_Departments' as unmatched_type,
    COUNT(DISTINCT d.departmentId) as count_value,
    GROUP_CONCAT(DISTINCT d.name SEPARATOR ', ') as details
FROM department d
LEFT JOIN employee e ON d.departmentId = e.departmentId
WHERE e.employeeId IS NULL

UNION

SELECT 
    'Unassigned_Projects' as unmatched_type,
    COUNT(DISTINCT p.projectId) as count_value,
    GROUP_CONCAT(DISTINCT p.project_name SEPARATOR ', ') as details
FROM project p
LEFT JOIN project_assignment pa ON p.projectId = pa.projectId
WHERE pa.assignment_id IS NULL

UNION

SELECT 
    'Orphaned_Assignments' as unmatched_type,
    COUNT(DISTINCT pa.assignment_id) as count_value,
    GROUP_CONCAT(DISTINCT pa.role SEPARATOR ', ') as details
FROM project_assignment pa
LEFT JOIN project p ON pa.projectId = p.projectId
WHERE p.projectId IS NULL
ORDER BY unmatched_type;

-- ============================================================================
-- MySQL Query 9: Complete Data Reconciliation
-- ============================================================================
-- MySQL: Show all combinations with status flags
SELECT 
    COALESCE(e.employeeId, 0) as emp_id,
    COALESCE(CONCAT(e.first_name, ' ', e.last_name), 'NO_EMPLOYEE') as emp_name,
    COALESCE(e.salary, 0) as emp_salary,
    COALESCE(d.departmentId, 0) as dept_id,
    COALESCE(d.name, 'NO_DEPARTMENT') as dept_name,
    COALESCE(p.projectId, 0) as proj_id,
    COALESCE(p.project_name, 'NO_PROJECT') as proj_name,
    COALESCE(pa.role, 'NO_ROLE') as role_name,
    CASE 
        WHEN e.employeeId IS NOT NULL AND d.departmentId IS NOT NULL 
             AND p.projectId IS NOT NULL THEN 'DATA_COMPLETE'
        WHEN e.employeeId IS NOT NULL AND d.departmentId IS NULL THEN 'MISSING_DEPARTMENT'
        WHEN e.employeeId IS NOT NULL AND p.projectId IS NULL THEN 'NO_PROJECT_ASSIGNED'
        WHEN d.departmentId IS NOT NULL AND e.employeeId IS NULL THEN 'EMPTY_DEPARTMENT'
        WHEN p.projectId IS NOT NULL AND pa.assignment_id IS NULL THEN 'UNASSIGNED_PROJECT'
        ELSE 'DATA_QUALITY_ISSUE'
    END as data_quality_flag
FROM employee e
LEFT JOIN department d ON e.departmentId = d.departmentId
LEFT JOIN project_assignment pa ON e.employeeId = pa.employeeId
LEFT JOIN project p ON pa.projectId = p.projectId

UNION

SELECT 
    COALESCE(e.employeeId, 0) as emp_id,
    COALESCE(CONCAT(e.first_name, ' ', e.last_name), 'NO_EMPLOYEE') as emp_name,
    COALESCE(e.salary, 0) as emp_salary,
    COALESCE(d.departmentId, 0) as dept_id,
    COALESCE(d.name, 'NO_DEPARTMENT') as dept_name,
    COALESCE(p.projectId, 0) as proj_id,
    COALESCE(p.project_name, 'NO_PROJECT') as proj_name,
    COALESCE(pa.role, 'NO_ROLE') as role_name,
    CASE 
        WHEN e.employeeId IS NOT NULL AND d.departmentId IS NOT NULL 
             AND p.projectId IS NOT NULL THEN 'DATA_COMPLETE'
        WHEN e.employeeId IS NOT NULL AND d.departmentId IS NULL THEN 'MISSING_DEPARTMENT'
        WHEN e.employeeId IS NOT NULL AND p.projectId IS NULL THEN 'NO_PROJECT_ASSIGNED'
        WHEN d.departmentId IS NOT NULL AND e.employeeId IS NULL THEN 'EMPTY_DEPARTMENT'
        WHEN p.projectId IS NOT NULL AND pa.assignment_id IS NULL THEN 'UNASSIGNED_PROJECT'
        ELSE 'DATA_QUALITY_ISSUE'
    END as data_quality_flag
FROM employee e
RIGHT JOIN department d ON e.departmentId = d.departmentId
LEFT JOIN project_assignment pa ON e.employeeId = pa.employeeId
LEFT JOIN project p ON pa.projectId = p.projectId
WHERE e.employeeId IS NULL

UNION

SELECT 
    COALESCE(e.employeeId, 0) as emp_id,
    COALESCE(CONCAT(e.first_name, ' ', e.last_name), 'NO_EMPLOYEE') as emp_name,
    COALESCE(e.salary, 0) as emp_salary,
    COALESCE(d.departmentId, 0) as dept_id,
    COALESCE(d.name, 'NO_DEPARTMENT') as dept_name,
    COALESCE(p.projectId, 0) as proj_id,
    COALESCE(p.project_name, 'NO_PROJECT') as proj_name,
    COALESCE(pa.role, 'NO_ROLE') as role_name,
    CASE 
        WHEN e.employeeId IS NOT NULL AND d.departmentId IS NOT NULL 
             AND p.projectId IS NOT NULL THEN 'DATA_COMPLETE'
        WHEN e.employeeId IS NOT NULL AND d.departmentId IS NULL THEN 'MISSING_DEPARTMENT'
        WHEN e.employeeId IS NOT NULL AND p.projectId IS NULL THEN 'NO_PROJECT_ASSIGNED'
        WHEN d.departmentId IS NOT NULL AND e.employeeId IS NULL THEN 'EMPTY_DEPARTMENT'
        WHEN p.projectId IS NOT NULL AND pa.assignment_id IS NULL THEN 'UNASSIGNED_PROJECT'
        ELSE 'DATA_QUALITY_ISSUE'
    END as data_quality_flag
FROM employee e
LEFT JOIN department d ON e.departmentId = d.departmentId
RIGHT JOIN project_assignment pa ON e.employeeId = pa.employeeId
LEFT JOIN project p ON pa.projectId = p.projectId
WHERE pa.assignment_id IS NOT NULL
ORDER BY data_quality_flag, emp_id, proj_id;

-- ============================================================================
-- MySQL Query 10: Performance Optimized FULL OUTER
-- ============================================================================
-- MySQL: Optimized version with indexed columns
SELECT 
    COALESCE(e.employeeId, -1) as employee_id,
    COALESCE(d.departmentId, -1) as department_id,
    CONCAT_WS(' - ', 
        COALESCE(CONCAT(e.first_name, ' ', e.last_name), 'N/A'),
        COALESCE(d.name, 'N/A')
    ) as full_info
FROM employee e
LEFT JOIN department d ON e.departmentId = d.departmentId AND e.departmentId > 0

UNION

SELECT 
    COALESCE(e.employeeId, -1) as employee_id,
    COALESCE(d.departmentId, -1) as department_id,
    CONCAT_WS(' - ',
        COALESCE(CONCAT(e.first_name, ' ', e.last_name), 'N/A'),
        COALESCE(d.name, 'N/A')
    ) as full_info
FROM employee e
RIGHT JOIN department d ON e.departmentId = d.departmentId AND e.departmentId > 0
ORDER BY employee_id, department_id;

-- ============================================================================
-- END OF MYSQL-SPECIFIC QUERIES
-- ============================================================================
-- These 10 queries demonstrate:
-- ✓ Basic FULL OUTER JOIN using UNION
-- ✓ Record classification and typing
-- ✓ Unmatched data discovery
-- ✓ Multi-table joins
-- ✓ Aggregation with FULL OUTER
-- ✓ Data quality metrics
-- ✓ Reconciliation reporting
-- ✓ Complex business logic
-- ✓ Performance optimization
-- ✓ String concatenation techniques
--
-- All queries work in MySQL 5.7+ and 8.0+
-- Copy and paste directly to your MySQL client



-- Example 1: LEFT OUTER JOIN - Show all employees and their departments
SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    e.salary,
    d.departmentId,
    d.name as department_name
FROM employee e
LEFT OUTER JOIN department d ON e.departmentId = d.departmentId
ORDER BY e.employeeId;

-- Example 2: LEFT OUTER JOIN - Find employees with NO department
SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    d.name as department_name
FROM employee e
LEFT OUTER JOIN department d ON e.departmentId = d.departmentId
WHERE d.departmentId IS NULL
ORDER BY e.employeeId;

-- Example 3: LEFT OUTER JOIN - Projects with their assignments
SELECT 
    p.projectId,
    p.project_name,
    p.budget,
    COUNT(DISTINCT pa.assignment_id) as assignment_count,
    COUNT(DISTINCT pa.employeeId) as employee_count
FROM project p
LEFT OUTER JOIN project_assignment pa ON p.projectId = pa.projectId
GROUP BY p.projectId, p.project_name, p.budget
ORDER BY p.projectId;

-- Example 4: LEFT OUTER JOIN - All departments with employee summary
SELECT 
    d.departmentId,
    d.name as department_name,
    COUNT(e.employeeId) as total_employees,
    COALESCE(ROUND(AVG(e.salary), 2), 0) as avg_salary,
    COALESCE(MIN(e.salary), 0) as min_salary,
    COALESCE(MAX(e.salary), 0) as max_salary
FROM department d
LEFT OUTER JOIN employee e ON d.departmentId = e.departmentId
GROUP BY d.departmentId, d.name
ORDER BY total_employees DESC;

-- Example 5: LEFT OUTER JOIN - Multi-table (Employees, Departments, Projects)
SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    d.name as department_name,
    p.projectId,
    p.project_name,
    pa.role,
    pa.allocation_percentage
FROM employee e
LEFT OUTER JOIN department d ON e.departmentId = d.departmentId
LEFT OUTER JOIN project_assignment pa ON e.employeeId = pa.employeeId
LEFT OUTER JOIN project p ON pa.projectId = p.projectId
WHERE e.employeeId IS NOT NULL
ORDER BY e.employeeId, p.projectId;

-- ============================================================================
-- RIGHT OUTER JOIN EXAMPLES (For Comparison)
-- ============================================================================
-- RIGHT OUTER JOIN returns ALL records from RIGHT table + matching LEFT table
-- Also written as: RIGHT JOIN (OUTER is optional)

-- Example 1: RIGHT OUTER JOIN - Show all departments and their employees
SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    e.salary,
    d.departmentId,
    d.name as department_name
FROM employee e
RIGHT OUTER JOIN department d ON e.departmentId = d.departmentId
ORDER BY d.departmentId, e.employeeId;

-- Example 2: RIGHT OUTER JOIN - Find departments with NO employees
SELECT 
    d.departmentId,
    d.name as department_name,
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name
FROM employee e
RIGHT OUTER JOIN department d ON e.departmentId = d.departmentId
WHERE e.employeeId IS NULL
ORDER BY d.departmentId;

-- Example 3: RIGHT OUTER JOIN - All assignments and their projects
SELECT 
    pa.assignment_id,
    pa.role,
    pa.allocation_percentage,
    p.projectId,
    p.project_name,
    p.status,
    p.budget
FROM project_assignment pa
RIGHT OUTER JOIN project p ON pa.projectId = p.projectId
ORDER BY p.projectId, pa.assignment_id;

-- Example 4: RIGHT OUTER JOIN - Show all employees and their projects
SELECT 
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    e.salary,
    COUNT(DISTINCT pa.projectId) as project_count,
    GROUP_CONCAT(DISTINCT p.project_name SEPARATOR ', ') as project_names
FROM project_assignment pa
RIGHT OUTER JOIN employee e ON pa.employeeId = e.employeeId
LEFT OUTER JOIN project p ON pa.projectId = p.projectId
GROUP BY e.employeeId, e.first_name, e.last_name, e.salary
ORDER BY project_count DESC, e.employeeId;

-- Example 5: RIGHT OUTER JOIN - All projects with their employees
SELECT 
    p.projectId,
    p.project_name,
    p.status,
    COUNT(DISTINCT pa.employeeId) as team_size,
    GROUP_CONCAT(DISTINCT CONCAT(e.first_name, ' ', e.last_name) SEPARATOR ', ') as employee_names,
    COALESCE(SUM(pa.allocation_percentage), 0) as total_allocation
FROM project_assignment pa
RIGHT OUTER JOIN project p ON pa.projectId = p.projectId
LEFT OUTER JOIN employee e ON pa.employeeId = e.employeeId
GROUP BY p.projectId, p.project_name, p.status
ORDER BY p.projectId;

-- ============================================================================
-- COMPARISON: FULL OUTER vs LEFT OUTER vs RIGHT OUTER JOIN
-- ============================================================================
-- Showing same data from different perspectives

-- LEFT OUTER: All employees (whether or not they have departments)
SELECT 
    'LEFT OUTER' as join_type,
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    COALESCE(d.name, 'No Department') as department_name
FROM employee e
LEFT OUTER JOIN department d ON e.departmentId = d.departmentId

UNION ALL

-- RIGHT OUTER: All departments (whether or not they have employees)
SELECT 
    'RIGHT OUTER' as join_type,
    e.employeeId,
    CONCAT(COALESCE(e.first_name, ''), ' ', COALESCE(e.last_name, '')) as employee_name,
    COALESCE(d.name, 'No Department') as department_name
FROM employee e
RIGHT OUTER JOIN department d ON e.departmentId = d.departmentId

UNION ALL

-- FULL OUTER: All records from both tables
SELECT 
    'FULL OUTER' as join_type,
    COALESCE(e.employeeId, 0) as employeeId,
    COALESCE(CONCAT(e.first_name, ' ', e.last_name), 'No Employee') as employee_name,
    COALESCE(d.name, 'No Department') as department_name
FROM employee e
FULL OUTER JOIN department d ON e.departmentId = d.departmentId
ORDER BY join_type, employeeId;

-- ============================================================================
-- PRACTICE QUESTIONS
-- ============================================================================
-- Answer these using FULL OUTER JOIN, LEFT OUTER JOIN, or RIGHT OUTER JOIN:
--
-- Q1: Find all employees and all departments (both matched and unmatched)
-- Q2: Identify employees with NO department AND departments with NO employees
-- Q3: Create a complete data quality report of employees and assignments
-- Q4: Find all projects and all assignments showing match status
-- Q5: Reconcile employees vs project assignments (who's unassigned)
-- Q6: List all departments with employee count (including 0)
-- Q7: Generate data completeness metrics for all tables
-- Q8: Find all unmatched records on both sides
-- Q9: Create a status report showing all data relationships
-- Q10: Identify data integrity issues using FULL OUTER JOIN

-- ============================================================================
-- DETAILED DIFFERENCES: LEFT OUTER vs RIGHT OUTER vs FULL OUTER JOIN
-- ============================================================================

-- ============================================================================
-- *** CRITICAL: MySQL FULL OUTER JOIN Workaround ***
-- ============================================================================
--
-- MySQL LIMITATION:
-- ───────────────────────────────────────────────────────────────────────────
-- MySQL does NOT natively support the FULL OUTER JOIN syntax.
-- This query will produce an error in MySQL:
--   SELECT * FROM employee e
--   FULL OUTER JOIN department d ON e.departmentId = d.departmentId;
--   ❌ Error: Syntax error near 'FULL'
--
-- DATABASE SUPPORT MATRIX:
-- ───────────────────────────────────────────────────────────────────────────
-- ✅ PostgreSQL ..... FULL OUTER JOIN supported (native)
-- ✅ SQL Server ..... FULL OUTER JOIN supported (native)
-- ✅ Oracle ......... FULL OUTER JOIN supported (native)
-- ❌ MySQL 5.7-8.0 .. NOT supported (use UNION workaround)
-- ❌ SQLite ......... NOT supported (use UNION workaround)
--
-- SOLUTION: Use UNION of LEFT and RIGHT JOIN
-- ───────────────────────────────────────────────────────────────────────────
-- The UNION method simulates FULL OUTER JOIN in MySQL:
--
-- Step 1: Get all records from LEFT table with matches from RIGHT
--         This includes unmatched LEFT records (with NULLs on right)
--   SELECT * FROM A LEFT JOIN B ON A.id = B.id
--
-- Step 2: Get all records from RIGHT table with matches from LEFT
--         This includes unmatched RIGHT records (with NULLs on left)
--   SELECT * FROM A RIGHT JOIN B ON A.id = B.id
--
-- Step 3: UNION combines both results
--         Duplicate matching records are automatically removed
--         Result: ALL rows from both tables
--   (Step 1) UNION (Step 2)
--
-- HOW UNION ELIMINATES DUPLICATES:
-- ───────────────────────────────────────────────────────────────────────────
-- Example: 3 employees in A, 2 departments in B, 2 matches
--
-- LEFT JOIN results:
--   E1 - D1 ✓ (matched)
--   E2 - D1 ✓ (matched)
--   E3 - NULL (unmatched in B)
--
-- RIGHT JOIN results:
--   E1 - D1 ✓ (matched, DUPLICATE)
--   E2 - D1 ✓ (matched, DUPLICATE)
--   NULL - D2 (unmatched in A)
--
-- UNION combines and removes duplicates:
--   E1 - D1 ✓ (kept once)
--   E2 - D1 ✓ (kept once)
--   E3 - NULL (from LEFT only)
--   NULL - D2 (from RIGHT only)
--   Result: 4 rows (all unique combinations)
--
-- SYNTAX COMPARISON:
-- ───────────────────────────────────────────────────────────────────────────
-- PostgreSQL, SQL Server, Oracle (supports native FULL OUTER):
--   SELECT * FROM table1
--   FULL OUTER JOIN table2 ON table1.id = table2.id;
--
-- MySQL, SQLite (use UNION workaround):
--   SELECT * FROM table1
--   LEFT JOIN table2 ON table1.id = table2.id
--   UNION
--   SELECT * FROM table1
--   RIGHT JOIN table2 ON table1.id = table2.id;
--
-- IMPORTANT NOTES:
-- ───────────────────────────────────────────────────────────────────────────
-- 1. Must select the SAME columns in both queries
--    If order differs, first query's order is used in result
--
-- 2. Column aliases should be identical
--    Use COALESCE if handling join keys differently
--
-- 3. Data types must be compatible for UNION to work
--    MySQL will attempt implicit conversion
--
-- 4. UNION removes duplicates automatically
--    If you want duplicates kept, use UNION ALL (slower)
--    But for FULL OUTER simulation, you MUST use UNION (not UNION ALL)
--
-- 5. Performance consideration
--    UNION processes two separate queries (slower than native FULL OUTER)
--    But it's the only option for MySQL
--
-- ============================================================================
-- 1. RESULT SET DIFFERENCES
-- ============================================================================
-- ──────────────────────────────────────────────────────────────────────────
-- 
-- Scenario: Two tables
--   LEFT table (employee):   100 employees
--   RIGHT table (department):   5 departments
--   Matching records:         95 employees have departments
--   LEFT only:                 5 employees have NO department
--   RIGHT only:                0 departments have NO employees
--
-- JOIN Results:
--   INNER JOIN:       95 rows (matching only)
--   LEFT OUTER JOIN: 100 rows (all employees + their departments or NULL)
--   RIGHT OUTER JOIN: 100 rows (all departments + their employees or NULL)
--   FULL OUTER JOIN: 100 rows (all from both, NULLs where no match)
--
-- Example with VISIBLE DIFFERENCES:

-- LEFT OUTER: Returns ALL from left table (employee)
-- Result: ALL 100 employees shown
-- Departments shown for matched rows, NULL for unmatched
SELECT 
    'LEFT OUTER' as join_type,
    COUNT(*) as row_count,
    COUNT(DISTINCT e.employeeId) as employees_found,
    COUNT(DISTINCT d.departmentId) as departments_found,
    COUNT(CASE WHEN d.departmentId IS NULL THEN 1 END) as unmatched_employees
FROM employee e
LEFT OUTER JOIN department d ON e.departmentId = d.departmentId;

-- RIGHT OUTER: Returns ALL from right table (department)
-- Result: ALL 5 departments shown
-- Employees shown for matched departments, NULL for empty departments
SELECT 
    'RIGHT OUTER' as join_type,
    COUNT(*) as row_count,
    COUNT(DISTINCT e.employeeId) as employees_found,
    COUNT(DISTINCT d.departmentId) as departments_found,
    COUNT(CASE WHEN e.employeeId IS NULL THEN 1 END) as empty_departments
FROM employee e
RIGHT OUTER JOIN department d ON e.departmentId = d.departmentId;

-- FULL OUTER: Returns ALL from BOTH tables
-- Result: ALL records from both sides, NULLs on either side where no match
SELECT 
    'FULL OUTER' as join_type,
    COUNT(*) as row_count,
    COUNT(DISTINCT COALESCE(e.employeeId, 0)) as employees_found,
    COUNT(DISTINCT COALESCE(d.departmentId, 0)) as departments_found,
    COUNT(CASE WHEN e.employeeId IS NULL THEN 1 END) as empty_departments,
    COUNT(CASE WHEN d.departmentId IS NULL THEN 1 END) as unmatched_employees
FROM employee e
FULL OUTER JOIN department d ON e.departmentId = d.departmentId;

-- ============================================================================
-- 2. VISUAL REPRESENTATION OF DIFFERENCES
-- ============================================================================
--
-- Table A: Employee (left table)
-- ┌─────────────────────┐
-- │ E1 (Dept = D1)      │
-- │ E2 (Dept = D1)      │
-- │ E3 (Dept = NULL)   │  ← Unmatched in A
-- │ E4 (Dept = D2)      │
-- │ E5 (Dept = NULL)   │  ← Unmatched in A
-- └─────────────────────┘
--
-- Table B: Department (right table)
-- ┌─────────────────────┐
-- │ D1 (has employees)  │
-- │ D2 (has employees)  │
-- │ D3 (NO employees)   │  ← Unmatched in B
-- └─────────────────────┘
--
-- JOIN Results:
--
-- LEFT OUTER JOIN:      RIGHT OUTER JOIN:     FULL OUTER JOIN:
-- ┌─────────────────┐   ┌─────────────────┐   ┌─────────────────┐
-- │ E1 - D1 ✓       │   │ E1 - D1 ✓       │   │ E1 - D1 ✓       │
-- │ E2 - D1 ✓       │   │ E2 - D1 ✓       │   │ E2 - D1 ✓       │
-- │ E3 - NULL ✗➤    │   │ E4 - D2 ✓       │   │ E3 - NULL ✗➤    │
-- │ E4 - D2 ✓       │   │ NULL - D3 ✗➤    │   │ E4 - D2 ✓       │
-- │ E5 - NULL ✗➤    │   │ E1 - D1 ✓       │   │ E5 - NULL ✗➤    │
-- └─────────────────┘   └─────────────────┘   │ NULL - D3 ✗➤    │
-- Total: 5 rows       Total: 4 rows           └─────────────────┘
--                                              Total: 6 rows
--
-- ✓  = Matched record (has data from both tables)
-- ✗➤ = Unmatched record (has NULL from one table)

-- ============================================================================
-- 3. NULL HANDLING DIFFERENCES
-- ============================================================================
--
-- LEFT OUTER JOIN:
--   NULL appears ONLY in RIGHT table columns (when dept not found)
--   LEFT table columns are NEVER NULL (all records from left are included)
--
-- RIGHT OUTER JOIN:
--   NULL appears ONLY in LEFT table columns (when employee not found)
--   RIGHT table columns are NEVER NULL (all records from right are included)
--
-- FULL OUTER JOIN:
--   NULLs can appear in BOTH table columns
--   Need COALESCE to combine NULL values from either side
--
-- Examples:

-- LEFT OUTER: NULLs in department columns only
SELECT 
    'LEFT OUTER' as join_type,
    CASE WHEN e.employeeId IS NULL THEN 'Has NULL' ELSE 'No NULL' END as left_side,
    CASE WHEN d.departmentId IS NULL THEN 'Has NULL' ELSE 'No NULL' END as right_side,
    COUNT(*) as occurrences
FROM employee e
LEFT OUTER JOIN department d ON e.departmentId = d.departmentId
GROUP BY 
    CASE WHEN e.employeeId IS NULL THEN 'Has NULL' ELSE 'No NULL' END,
    CASE WHEN d.departmentId IS NULL THEN 'Has NULL' ELSE 'No NULL' END;

-- RIGHT OUTER: NULLs in employee columns only
SELECT 
    'RIGHT OUTER' as join_type,
    CASE WHEN e.employeeId IS NULL THEN 'Has NULL' ELSE 'No NULL' END as left_side,
    CASE WHEN d.departmentId IS NULL THEN 'Has NULL' ELSE 'No NULL' END as right_side,
    COUNT(*) as occurrences
FROM employee e
RIGHT OUTER JOIN department d ON e.departmentId = d.departmentId
GROUP BY 
    CASE WHEN e.employeeId IS NULL THEN 'Has NULL' ELSE 'No NULL' END,
    CASE WHEN d.departmentId IS NULL THEN 'Has NULL' ELSE 'No NULL' END;

-- FULL OUTER: NULLs can be on both sides
SELECT 
    'FULL OUTER' as join_type,
    CASE WHEN e.employeeId IS NULL THEN 'Has NULL' ELSE 'No NULL' END as left_side,
    CASE WHEN d.departmentId IS NULL THEN 'Has NULL' ELSE 'No NULL' END as right_side,
    COUNT(*) as occurrences
FROM employee e
FULL OUTER JOIN department d ON e.departmentId = d.departmentId
GROUP BY 
    CASE WHEN e.employeeId IS NULL THEN 'Has NULL' ELSE 'No NULL' END,
    CASE WHEN d.departmentId IS NULL THEN 'Has NULL' ELSE 'No NULL' END;

-- ============================================================================
-- 4. SYNTAX AND KEYWORD DIFFERENCES
-- ============================================================================
--
-- LEFT OUTER JOIN:
--   SELECT * FROM A LEFT OUTER JOIN B ON A.id = B.id;
--   SELECT * FROM A LEFT JOIN B ON A.id = B.id;  ← OUTER is optional
--
-- RIGHT OUTER JOIN:
--   SELECT * FROM A RIGHT OUTER JOIN B ON A.id = B.id;
--   SELECT * FROM A RIGHT JOIN B ON A.id = B.id;  ← OUTER is optional
--
-- FULL OUTER JOIN (MySQL):
--   Not directly supported in MySQL
--   Alternative: (LEFT JOIN) UNION (RIGHT JOIN)
--   SELECT * FROM A LEFT JOIN B ON A.id = B.id
--   UNION
--   SELECT * FROM A RIGHT JOIN B ON A.id = B.id;
--
-- In other databases (PostgreSQL, SQL Server, Oracle):
--   SELECT * FROM A FULL OUTER JOIN B ON A.id = B.id;
--   SELECT * FROM A FULL JOIN B ON A.id = B.id;  ← OUTER is optional

-- ============================================================================
-- 5. WHEN TO USE EACH JOIN TYPE
-- ============================================================================
--
-- USE LEFT OUTER JOIN WHEN:
--   ✓ You want ALL records from the left table
--   ✓ Right table data is supplementary (optional)
--   ✓ Examples:
--     - All employees with their departments (departments optional)
--     - All customers with their orders (orders optional)
--     - All projects with their assignments (assignments optional)
--     - Finding records in left table with no match in right
--
-- USE RIGHT OUTER JOIN WHEN:
--   ✓ You want ALL records from the right table
--   ✓ Left table data is supplementary (optional)
--   ✓ Examples:
--     - All departments with their employees (employees optional)
--     - All products with their sales (sales optional)
--     - All projects with their team members (members optional)
--     - Finding records in right table with no match in left
--
-- USE FULL OUTER JOIN WHEN:
--   ✓ You want ALL records from BOTH tables
--   ✓ Need to identify unmatched records on BOTH sides
--   ✓ Purpose is reconciliation and data validation
--   ✓ Examples:
--     - Data migration validation (old vs new systems)
--     - Comparing two datasets for completeness
--     - Finding orphaned records on either side
--     - Complete data quality analysis

-- ============================================================================
-- 6. ROW COUNT COMPARISON
-- ============================================================================
--
-- If Table A has 100 rows and Table B has 50 rows:
--   Matching records: 40
--   A only: 60 (100 - 40)
--   B only: 10 (50 - 40)
--
-- Expected row counts:
--   INNER JOIN: 40 (matching only)
--   LEFT OUTER: 100 (all A + matching B)
--   RIGHT OUTER: 50 (all B + matching A)
--   FULL OUTER: 110 (60 from A + 50 from B)
--
-- Note: FULL OUTER row count = LEFT unique + RIGHT unique
-- Because UNION removes duplicates (matching records counted once)

-- ============================================================================
-- 7. PERFORMANCE DIFFERENCES
-- ============================================================================
--
-- Execution Speed (fastest to slowest):
--   1. INNER JOIN .............. Fastest (smallest result set)
--   2. LEFT OUTER JOIN ......... Medium (includes left unmatched)
--   3. RIGHT OUTER JOIN ........ Medium (includes right unmatched)
--   4. FULL OUTER JOIN ......... Slowest (includes all unmatched)
--
-- Processing Complexity:
--   INNER < LEFT/RIGHT < FULL OUTER
--
-- Best Practices for Performance:
--   ✓ Use INNER JOIN when possible (most restrictive)
--   ✓ Only use OUTER JOINs when necessary
--   ✓ Add indexes on JOIN columns
--   ✓ Filter early with WHERE clause after JOIN
--   ✓ Avoid FULL OUTER in large datasets if possible

-- ============================================================================
-- 8. PRACTICAL DECISION TREE
-- ============================================================================
--
-- Question: What's the PRIMARY table?
--   (The table whose records MUST all appear)
--
--   Primary table = TABLE A
--   └─ Use LEFT OUTER JOIN
--      └─ All records from A, optional data from B
--
--   Primary table = TABLE B
--   └─ Use RIGHT OUTER JOIN
--      └─ All records from B, optional data from A
--
--   Primary table = BOTH EQUALLY
--   └─ Use FULL OUTER JOIN
--      └─ All records from both
--      └─ OR use LEFT JOIN UNION RIGHT JOIN
--
-- Question: What's your goal?
--   Goal: Find data ONLY in A
--   └─ Use LEFT JOIN + WHERE B.id IS NULL
--
--   Goal: Find data ONLY in B
--   └─ Use RIGHT JOIN + WHERE A.id IS NULL
--
--   Goal: Find data in BOTH A and B only
--   └─ Use INNER JOIN
--
--   Goal: Find ALL data (reconciliation)
--   └─ Use FULL OUTER JOIN

-- ============================================================================
-- 9. SIDE-BY-SIDE COMPARISON TABLE
-- ============================================================================
--
-- ┌──────────────────┬──────────────┬──────────────┬──────────────┐
-- │ Characteristic   │ LEFT OUTER   │ RIGHT OUTER  │ FULL OUTER   │
-- ├──────────────────┼──────────────┼──────────────┼──────────────┤
-- │ All from left    │ ✓ Yes        │ ✗ No         │ ✓ Yes        │
-- │ All from right   │ ✗ No         │ ✓ Yes        │ ✓ Yes        │
-- │ Matching only    │ ✗ No         │ ✗ No         │ ✗ No         │
-- │ Can have NULL    │ Right side   │ Left side    │ Both sides   │
-- │ Result size      │ ≥ Inner      │ ≥ Inner      │ ≥ Left/Right │
-- │ Use frequency    │ Very common  │ Less common  │ Uncommon     │
-- │ Primary use      │ Add optional │ Add optional │ Reconcile    │
-- │ MySQL support    │ ✓ Yes        │ ✓ Yes        │ ✗ UNION      │
-- └──────────────────┴──────────────┴──────────────┴──────────────┘

-- ============================================================================
-- 10. REAL-WORLD COMPARISON EXAMPLE
-- ============================================================================
--
-- Scenario: Company database
-- LEFT: All employees must be shown
-- RIGHT: All departments must be shown
-- Many employees have NO department (new hires)
-- Two departments have NO employees (being dissolved)
--
-- Business Questions:
--
-- Q1: "Show all employees with their departments"
--     → Use LEFT OUTER JOIN
--     → Result: All employees, departments shown if assigned
--
-- Q2: "Show all departments with their team sizes"
--     → Use RIGHT OUTER JOIN (or group by from LEFT JOIN)
--     → Result: All departments, employees shown if assigned
--
-- Q3: "I need a complete reconciliation report"
--     → Use FULL OUTER JOIN
--     → Result: All employees AND all departments, identifies mismatches
--     → Shows: New hires with no dept, empty depts with no staff

-- ============================================================================
-- KEY POINTS ABOUT FULL OUTER JOIN
-- ============================================================================
-- ✓ Returns ALL rows from BOTH tables
-- ✓ NULLs appear in columns from non-matching table
-- ✓ Perfect for data reconciliation
-- ✓ Great for identifying data quality issues
-- ✓ MySQL doesn't support FULL OUTER directly
-- ✓ Use UNION of LEFT and RIGHT JOIN to simulate
-- ✓ Performance: Slower than INNER/LEFT/RIGHT (processes more data)
-- ✓ Essential for data validation and completeness checks
--
-- QUICK REFERENCE FOR CHOOSING:
-- ✓ LEFT: I need ALL data from the left table
-- ✓ RIGHT: I need ALL data from the right table
-- ✓ FULL: I need ALL data from BOTH tables
-- ✓ INNER: I need only MATCHING data from both tables

-- ============================================================================
-- COMMON MISTAKES TO AVOID
-- ============================================================================
-- MISTAKE 1: Trying to use FULL OUTER JOIN syntax in MySQL
-- WRONG:  SELECT * FROM A FULL OUTER JOIN B ON ...  ❌ MySQL Error!
-- RIGHT:  SELECT * FROM A LEFT JOIN B ON ...
--         UNION
--         SELECT * FROM A RIGHT JOIN B ON ...       ✓ Works in MySQL

-- MISTAKE 2: Forgetting to use UNION
-- WRONG:  SELECT * FROM A FULL OUTER JOIN B (MySQL doesn't support this)
-- RIGHT:  SELECT * FROM A LEFT JOIN B UNION SELECT * FROM A RIGHT JOIN B

-- MISTAKE 3: Not using COALESCE for the join key
-- When using UNION, need to handle NULL join keys
-- Use: COALESCE(a.id, b.id) for sorting/grouping

-- MISTAKE 4: Forgetting duplicate handling in UNION
-- UNION automatically removes duplicates
-- The matching records appear only once (correct behavior)
-- Don't use UNION ALL (unless you specifically want duplicates for analysis)

-- MISTAKE 5: Not checking for NULLs on both sides
-- WRONG:  WHERE e.employeeId IS NULL (only finds left-only records)
-- RIGHT:  WHERE e.employeeId IS NULL OR d.departmentId IS NULL
--         (finds both left-only and right-only records)

-- MISTAKE 6: Not handling column count/types in UNION
-- WRONG:  SELECT id, name FROM A UNION SELECT id, name, salary FROM B
-- RIGHT:  SELECT id, name FROM A UNION SELECT id, name FROM B
--         Columns must match in count and compatible types

-- MISTAKE 7: Performance issues with large datasets
-- FULL OUTER (via UNION) processes more rows
-- Consider indexing on join columns
-- May want to use UNION ALL if duplicates can't occur (but verify)

-- MISTAKE 8: Forgetting SELECT clauses match in UNION
-- WRONG:  SELECT * FROM A UNION SELECT id FROM B  (different columns)
-- RIGHT:  SELECT id, name FROM A UNION SELECT id, name FROM B

-- ============================================================================
-- COMPARISON: All JOIN Types
-- ============================================================================
-- INNER:      Matched records only
-- LEFT:       All left + matching right
-- RIGHT:      All right + matching left
-- FULL OUTER: All from both sides
--
-- Performance (fastest to slowest):
--   1. INNER (most restrictive)
--   2. LEFT/RIGHT (similar)
--   3. FULL OUTER (processes all data)

-- ============================================================================
-- WHEN TO USE FULL OUTER JOIN
-- ============================================================================
-- Use FULL OUTER JOIN when:
--   1. You need ALL records from both tables
--   2. Focus is on data reconciliation
--   3. You want to find unmatched records on BOTH sides
--   4. Data quality and completeness checks
--   5. Migration validation (comparing old vs new data)
--   6. Identifying orphaned or mismatched records
--
-- In practice:
--   - Less common than INNER/LEFT
--   - Very useful for data validation
--   - Important for ETL and data quality
--   - Remember: MySQL requires UNION approach

/*
================================================================================
  END OF FULL OUTER JOIN GUIDE
================================================================================
  Summary:
  - FULL OUTER JOIN: All from both tables
  - Use: Data reconciliation and validation
  - MySQL method: Use UNION of LEFT and RIGHT JOIN
  - Performance: Slowest of all JOIN types
  - Important for: Data quality checks, migrations, validation
  
  Key Insight:
  FULL OUTER JOIN is essential for data validation and reconciliation.
  It helps identify data integrity issues and orphaned records that
  other JOIN types would miss.
  
  ⚠️  IMPORTANT MYSQL NOTE:
  MySQL does NOT support FULL OUTER JOIN syntax natively.
  Always use the UNION of LEFT JOIN and RIGHT JOIN method:
  
    SELECT * FROM table1
    LEFT JOIN table2 ON condition
    UNION
    SELECT * FROM table1
    RIGHT JOIN table2 ON condition;
  
  This works in MySQL 5.7+, 8.0+, and all versions.
  
  DATABASE COMPATIBILITY:
    ✅ PostgreSQL ........ FULL OUTER JOIN (native)
    ✅ SQL Server ........ FULL OUTER JOIN (native)
    ✅ Oracle ............ FULL OUTER JOIN (native)
    ❌ MySQL ............ UNION workaround required
    ❌ SQLite ............ UNION workaround required
  
  BEST PRACTICES:
  1. Always test queries with actual data
  2. Use COALESCE for meaningful output
  3. Add join_type column to identify unmatched records
  4. Index join columns for better performance
  5. Use UNION (not UNION ALL) for FULL OUTER effect
  6. Document why you need FULL OUTER JOIN
  7. Consider simpler queries first (INNER, LEFT)
  8. Validate results against business requirements
  
  For more information:
  - https://dev.mysql.com/doc/refman/8.0/en/join.html
  - https://www.w3schools.com/sql/sql_join_full.asp
  - https://mode.com/sql-tutorial/sql-joins/
  - Data reconciliation patterns and best practices
  - Data quality and ETL best practices
================================================================================
*/
