/*
================================================================================
  SQL DELETE COMMAND - Tutorial
================================================================================
  Description: Remove records from tables using DELETE command
               with various conditions and safety measures
  
  SCHEMA OVERVIEW:
    - department: departmentId (PK), name
    - employee: employeeId (PK), first_name, last_name, email, salary, departmentId (FK)
  
  RELATIONSHIP TYPE: One-to-Many (Department -> Employees)
  
  SAMPLE DATA:
    Departments (4):
      1. Human Resources
      2. Engineering
      3. Sales
      4. Finance
    
    Employees (4):
      1. John Doe - HR - $50,000
      2. Jane Smith - Engineering - $65,000
      3. Robert Johnson - Sales - $55,000
      4. Emily Brown - Finance - $60,000
  
  ⚠️  WARNING ⚠️
    - DELETE cannot be undone without a backup!
    - Always use WHERE clause with DELETE (except when intentional)
    - Test SELECT with same WHERE condition BEFORE running DELETE
    - Use transactions (BEGIN; DELETE...; COMMIT;) for safety
================================================================================
*/

-- ===============================================
-- 1. DELETE WITH WHERE - DELETE SPECIFIC ROW
-- ===============================================
-- Delete employee with employeeId = 1 (John Doe)
DELETE FROM employee
WHERE employeeId = 1;

-- ===============================================
-- 2. DELETE BY COLUMN VALUE
-- ===============================================
-- Delete employee by first and last name
DELETE FROM employee
WHERE first_name = 'Jane' AND last_name = 'Smith';

-- Delete employee by email
DELETE FROM employee
WHERE email = 'robert.johnson@example.com';

-- ===============================================
-- 3. DELETE MULTIPLE ROWS - BY CONDITION
-- ===============================================
-- Delete all employees in a specific department (Sales = 3)
DELETE FROM employee
WHERE departmentId = 3;

-- ===============================================
-- 4. DELETE WITH SIMPLE CONDITION
-- ===============================================
-- Delete all employees with salary less than 50000
DELETE FROM employee
WHERE salary < 50000.00;

-- ===============================================
-- 5. DELETE WITH BETWEEN CONDITION
-- ===============================================
-- Delete employees with salary between 50000 and 60000
DELETE FROM employee
WHERE salary BETWEEN 50000.00 AND 60000.00;

-- ===============================================
-- 6. DELETE WITH IN CLAUSE
-- ===============================================
-- Delete employees from departments 1, 3, and 4
DELETE FROM employee
WHERE departmentId IN (1, 3, 4);

-- ===============================================
-- 7. DELETE WITH LIKE (Pattern Matching)
-- ===============================================
-- Delete employees whose first name starts with 'J'
DELETE FROM employee
WHERE first_name LIKE 'J%';

-- Delete employees with 'smith' in email (case-insensitive)
DELETE FROM employee
WHERE email LIKE '%smith%';

-- ===============================================
-- 8. DELETE WITH SUBQUERY
-- ===============================================
-- Delete all employees from departments starting with 'E' (Engineering)
DELETE FROM employee
WHERE departmentId IN (
  SELECT departmentId FROM department WHERE name LIKE 'E%'
);

-- Delete employees from departments with specific names
DELETE FROM employee
WHERE departmentId IN (
  SELECT departmentId FROM department 
  WHERE name = 'Sales' OR name = 'Marketing'
);

-- ===============================================
-- 9. DELETE WITH JOIN
-- ===============================================
-- Delete all employees in the HR department using JOIN
DELETE e FROM employee e
INNER JOIN department d ON e.departmentId = d.departmentId
WHERE d.name = 'Human Resources';

-- ===============================================
-- 10. DELETE WITH LIMIT (MySQL specific)
-- ===============================================
-- Delete only the first 2 employees from Engineering dept
DELETE FROM employee
WHERE departmentId = 2
LIMIT 2;

-- ===============================================
-- 11. DELETE ALL RECORDS - BE VERY CAREFUL!
-- ===============================================
-- Delete ALL employees from the table (NO WHERE clause!)
-- ⚠️ THIS CANNOT BE UNDONE - USE WITH EXTREME CAUTION ⚠️
-- DELETE FROM employee;

-- ===============================================
-- 12. DELETE DEPARTMENT (Careful with FK!)
-- ===============================================
-- Delete a department (may fail if employees exist due to FK constraint)
DELETE FROM department
WHERE departmentId = 5;

-- ===============================================
-- 13. USING TRANSACTIONS FOR SAFE DELETION
-- ===============================================
-- Use transaction for safety - can ROLLBACK if needed
BEGIN;

DELETE FROM employee
WHERE departmentId = 3;

-- Review affected rows before committing
-- If satisfied, run COMMIT; If not, run ROLLBACK;
-- COMMIT;  -- Permanent deletion
-- ROLLBACK; -- Undo the deletion

-- ===============================================
-- 14. DELETE AND VERIFY BEFORE COMMITTING
-- ===============================================
-- Step 1: Check what will be deleted
SELECT * FROM employee WHERE salary < 50000.00;

-- Step 2: Delete with transaction
BEGIN;
DELETE FROM employee WHERE salary < 50000.00;

-- Step 3: Verify count
SELECT COUNT(*) FROM employee;

-- Step 4: Commit if correct, else ROLLBACK
-- COMMIT;
-- ROLLBACK;

-- ===============================================
-- 15. DELETE WITH OR CONDITION
-- ===============================================
-- Delete employees from HR or Accounting departments
DELETE FROM employee
WHERE departmentId IN (
  SELECT departmentId FROM department 
  WHERE name = 'Human Resources' OR name = 'Finance'
);

-- ===============================================
-- 16. DELETE SPECIFIC ROWS BY MULTIPLE CONDITIONS
-- ===============================================
-- Delete high-salary employees in specific department
DELETE FROM employee
WHERE salary > 60000.00 AND departmentId = 2;

-- ===============================================
-- 17. DELETE WITH NOT IN (Inverse selection)
-- ===============================================
-- Delete all employees NOT in departments 1 and 2
DELETE FROM employee
WHERE departmentId NOT IN (1, 2);

-- ===============================================
-- 18. DELETE FROM BACKUP/STAGING TABLE
-- ===============================================
-- Delete from a staging/temporary table after processing
-- First, create backup of important data before deletion
-- DELETE FROM staging_employee WHERE processed = 1;

-- ===============================================
-- PRACTICE EXAMPLES - Uncomment to use (CAREFULLY!)
-- ===============================================

-- Example 1: Delete single employee by ID
-- DELETE FROM employee WHERE employeeId = 1;

-- Example 2: Delete employees in a department
-- DELETE FROM employee WHERE departmentId = 3;

-- Example 3: Delete with transaction (safe approach)
-- BEGIN;
-- DELETE FROM employee WHERE salary < 55000;
-- SELECT COUNT(*) FROM employee;  -- Check result
-- COMMIT;  -- or ROLLBACK;

-- Example 4: Delete employees NOT in Engineering (dept 2)
-- DELETE FROM employee WHERE departmentId != 2;

-- Example 5: Review before deletion
-- SELECT * FROM employee WHERE email LIKE '%@company.com';
-- DELETE FROM employee WHERE email LIKE '%@company.com';



-- ===============================================
-- TEST QUERIES - Run BEFORE deletion
-- ===============================================
-- View all employees before deletion:
-- SELECT * FROM employee;

-- View count of employees:
-- SELECT COUNT(*) as total_employees FROM employee;

-- View employees in specific department:
-- SELECT * FROM employee WHERE departmentId = 3;

-- View salary statistics:
-- SELECT MIN(salary), MAX(salary), AVG(salary), COUNT(*) FROM employee;

-- ===============================================
-- BACKUP STRATEGY BEFORE DELETION (RECOMMENDED)
-- ===============================================
-- Create a backup table before any mass deletion
-- CREATE TABLE employee_backup AS SELECT * FROM employee;

-- Create delete log to track what was removed
-- CREATE TABLE employee_deleted_log AS 
-- SELECT *, NOW() as deleted_date FROM employee WHERE [condition];
-- Then perform the deletion

-- ===============================================
-- KEY POINTS TO REMEMBER
-- ===============================================
-- 1. ALWAYS use WHERE clause (except when intentional deletion of all)
-- 2. TEST SELECT with same WHERE BEFORE running DELETE
-- 3. Use transactions for safety:
--    BEGIN; DELETE...; COMMIT; (or ROLLBACK)
-- 4. Check affected row count after deletion
-- 5. Keep regular backups of critical data
-- 6. DELETE respects Foreign Keys (may cause errors)
-- 7. Enable backup/recovery procedures before deleting large datasets
-- 8. DELETED data cannot be recovered without backup!
-- 9. Use DELETE LOG tables for audit trail
-- ===============================================
