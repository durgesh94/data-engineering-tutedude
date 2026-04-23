/*
================================================================================
  SQL UPDATE COMMAND - Tutorial with Employee & Department Tables
================================================================================
  Purpose: Modify existing records in employee and department tables
  Syntax: UPDATE table_name SET column1 = value1, column2 = value2, ... WHERE condition;
  
  TABLE STRUCTURE:
  - department: departmentId (PK), name
  - employee: employeeId (PK), first_name, last_name, email, salary, departmentId (FK)
  
  SAMPLE DATA:
  - Dept 1: Human Resources
  - Dept 2: Engineering
  - Dept 3: Sales
  - Dept 4: Finance
  - Employees: John Doe (1), Jane Smith (2), Robert Johnson (3), Emily Brown (4)
  
  WARNING: Always use WHERE clause to specify which records to update!
           Forgetting WHERE will update ALL records in the table!
================================================================================
*/

-- ===============================================
-- 1. BASIC UPDATE - Single Column (employeeId)
-- ===============================================
-- Update the salary of John Doe (employeeId = 1)
UPDATE employee
SET salary = 52000.00
WHERE employeeId = 1;

-- ===============================================
-- 2. UPDATE MULTIPLE COLUMNS
-- ===============================================
-- Update multiple fields for John Doe
UPDATE employee
SET first_name = 'Jonathan', email = 'jonathan.doe@example.com'
WHERE employeeId = 1;

-- ===============================================
-- 3. UPDATE WITH CONDITION (WHERE clause)
-- ===============================================
-- Give all Engineering employees (departmentId = 2) a 10% raise
UPDATE employee
SET salary = salary * 1.10
WHERE departmentId = 2;

-- ===============================================
-- 4. UPDATE MULTIPLE ROWS - Sales Department
-- ===============================================
-- Update email format for all Sales employees (departmentId = 3)
UPDATE employee
SET email = CONCAT(first_name, '.', last_name, '@company.com')
WHERE departmentId = 3;

-- ===============================================
-- 5. UPDATE WITH JOIN
-- ===============================================
-- Update employee salary based on department name
UPDATE employee e
INNER JOIN department d ON e.departmentId = d.departmentId
SET e.salary = e.salary * 1.05
WHERE d.name = 'Engineering';

-- ===============================================
-- 6. UPDATE WITH MATHEMATICAL OPERATIONS
-- ===============================================
-- Increase salary for all high-earning employees (>60000)
UPDATE employee
SET salary = salary + 5000.00
WHERE salary > 60000.00;

-- ===============================================
-- 7. UPDATE WITH CONDITIONAL LOGIC (CASE statement)
-- ===============================================
-- Adjust salary based on department - different raise percentages
UPDATE employee
SET salary = CASE
  WHEN departmentId = 1 THEN salary * 1.08   -- HR: 8% raise
  WHEN departmentId = 2 THEN salary * 1.12   -- Engineering: 12% raise
  WHEN departmentId = 3 THEN salary * 1.10   -- Sales: 10% raise
  WHEN departmentId = 4 THEN salary * 1.09   -- Finance: 9% raise
  ELSE salary
END;

-- ===============================================
-- 8. UPDATE DEPARTMENT INFORMATION
-- ===============================================
-- Update Human Resources department name to HR & Administration
UPDATE department
SET name = 'HR & Administration'
WHERE departmentId = 1;

-- ===============================================
-- 9. REVERT DEPARTMENT NAME
-- ===============================================
-- Revert department name back to Human Resources
UPDATE department
SET name = 'Human Resources'
WHERE departmentId = 1;

-- ===============================================
-- 10. UPDATE WITH SUBQUERY
-- ===============================================
-- Update all employees in departments that start with 'E' (Engineering)
UPDATE employee
SET salary = salary * 1.08
WHERE departmentId IN (
  SELECT departmentId FROM department WHERE name LIKE 'E%'
);

-- ===============================================
-- 11. UPDATE EMPLOYEE EMAIL FORMAT
-- ===============================================
-- Update all employee emails to new company domain format
UPDATE employee
SET email = CONCAT(LOWER(first_name), '.', LOWER(last_name), '@company.com')
WHERE employeeId > 0;  -- All employees

-- ===============================================
-- 12. UPDATE WITH OR CONDITION
-- ===============================================
-- Update salary for employees in HR or Finance departments
UPDATE employee
SET salary = salary * 1.06
WHERE departmentId IN (
  SELECT departmentId FROM department 
  WHERE name = 'Human Resources' OR name = 'Finance'
);

-- ===============================================
-- 13. UPDATE WITH BETWEEN CONDITION
-- ===============================================
-- Give raise to employees with salary between 50000 and 60000
UPDATE employee
SET salary = salary + 3000.00
WHERE salary BETWEEN 50000.00 AND 60000.00;

-- ===============================================
-- 14. UPDATE SPECIFIC EMPLOYEE BY NAME
-- ===============================================
-- Update Jane Smith's email and salary
UPDATE employee
SET email = 'jane.smith.senior@example.com', salary = 70000.00
WHERE first_name = 'Jane' AND last_name = 'Smith';

-- ===============================================
-- 15. UPDATE EMPLOYEE BY LAST NAME
-- ===============================================
-- Update salary for Robert Johnson
UPDATE employee
SET salary = 58000.00
WHERE last_name = 'Johnson';

-- ===============================================
-- 16. UPDATE WITH LIMIT (MySQL specific)
-- ===============================================
-- Update only the first 2 rows matching condition - Engineering employees
UPDATE employee
SET salary = salary * 1.05
WHERE departmentId = 2
LIMIT 2;

-- ===============================================
-- 17. UPDATE SPECIFIC EMPLOYEE
-- ===============================================
-- Update Emily Brown's salary and department reassignment
UPDATE employee
SET salary = 62000.00, departmentId = 4
WHERE employeeId = 4;

-- ===============================================
-- 18. TRANSFER EMPLOYEE TO DIFFERENT DEPARTMENT
-- ===============================================
-- Move Robert Johnson from Sales (3) to Engineering (2)
UPDATE employee
SET departmentId = 2
WHERE employeeId = 3;

-- ===============================================
-- 19. CORRECTION: REVERT EMPLOYEE TRANSFER
-- ===============================================
-- Move Robert Johnson back to Sales (3)
UPDATE employee
SET departmentId = 3
WHERE employeeId = 3;

-- ===============================================
-- 20. UPDATE ALL DEPARTMENT NAMES (WARNING: Bulk Operation)
-- ===============================================
-- Add formatted prefix to all department names
UPDATE department
SET name = CONCAT('DEPT - ', name);

-- ===============================================
-- 21. ROLLBACK: REVERT ALL DEPARTMENT NAMES
-- ===============================================
/* Revert to original department names */
UPDATE department
SET name = CASE
  WHEN departmentId = 1 THEN 'Human Resources'
  WHEN departmentId = 2 THEN 'Engineering'
  WHEN departmentId = 3 THEN 'Sales'
  WHEN departmentId = 4 THEN 'Finance'
  ELSE name
END;

-- ===============================================
-- PRACTICE EXAMPLES - Uncomment to use
-- ===============================================

-- Example 1: Update John Doe's salary to 56000
-- UPDATE employee 
-- SET salary = 56000.00
-- WHERE employeeId = 1;

-- Example 2: Update Robert Johnson's department to Engineering
-- UPDATE employee 
-- SET departmentId = 2
-- WHERE last_name = 'Johnson';

-- Example 3: Standardize first and last names (capitalize)
-- UPDATE employee 
-- SET first_name = CONCAT(UPPER(SUBSTRING(first_name, 1, 1)), LOWER(SUBSTRING(first_name, 2))),
--     last_name = CONCAT(UPPER(SUBSTRING(last_name, 1, 1)), LOWER(SUBSTRING(last_name, 2)))
-- WHERE employeeId > 0;

-- Example 4: Give 15% raise to all Engineering employees
-- UPDATE employee
-- SET salary = salary * 1.15
-- WHERE departmentId = (SELECT departmentId FROM department WHERE name = 'Engineering');

-- Example 5: Update all emails to standard format (lowercase)
-- UPDATE employee 
-- SET email = LOWER(CONCAT(first_name, '.', last_name, '@company.com'))
-- WHERE employeeId IN (1, 2, 3, 4);

-- ===============================================
-- TEST QUERIES - Run BEFORE and AFTER updates
-- ===============================================
-- View all employees with their departments:
-- SELECT e.employeeId, e.first_name, e.last_name, e.salary, d.name as department 
-- FROM employee e 
-- JOIN department d ON e.departmentId = d.departmentId
-- ORDER BY e.employeeId;

-- View salary statistics by department:
-- SELECT d.name as department, COUNT(*) as employee_count, 
--        AVG(e.salary) as avg_salary, MAX(e.salary) as max_salary, MIN(e.salary) as min_salary
-- FROM employee e 
-- JOIN department d ON e.departmentId = d.departmentId
-- GROUP BY d.departmentId, d.name;

-- View all departments:
-- SELECT * FROM department;

-- ===============================================
-- KEY POINTS TO REMEMBER
-- ===============================================
-- 1. ALWAYS use WHERE clause to avoid updating all records
-- 2. Test SELECT query with same WHERE before running UPDATE
-- 3. Use transactions (BEGIN; UPDATE...; COMMIT;) for safety:
--    BEGIN;
--    UPDATE employee SET salary = salary * 1.1 WHERE departmentId = 2;
--    COMMIT;
-- 4. Verify affected rows after UPDATE
-- 5. Make backups before bulk updates
-- 6. Use LIMIT when testing mass updates
-- 7. UPDATE can reference other columns: SET salary = salary * 1.1
-- 8. Use CASE for conditional updates based on different criteria
-- 9. CONCAT() for string operations
-- 10. JOIN tables for cross-table updates
-- ===============================================
