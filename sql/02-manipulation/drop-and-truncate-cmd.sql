/*
================================================================================
  SQL DROP & TRUNCATE COMMANDS - Tutorial
================================================================================
  Description: Remove table structures and data using DROP and TRUNCATE commands
               Comprehensive examples with both commands
  
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
    - DROP and TRUNCATE cannot be undone without backups!
    - DROP removes the entire table structure and data
    - TRUNCATE removes only data, keeps the structure
    - Always have backups before running these commands
    - Use in production environments with extreme caution
================================================================================
*/

-- ===============================================
-- TRUNCATE COMMAND EXAMPLES
-- ===============================================

-- ===============================================
-- 1. TRUNCATE TABLE - REMOVE ALL DATA
-- ===============================================
-- Truncate removes ALL rows but keeps table structure
-- TRUNCATE cannot have WHERE clause
-- TRUNCATE resets identity/auto-increment values
-- TRUNCATE is faster than DELETE for large datasets

-- Truncate employee table (removes all employees)
TRUNCATE TABLE employee;

-- Truncate department table (removes all departments)
TRUNCATE TABLE department;

-- ===============================================
-- 2. TRUNCATE WITH IDENTITY RESET (SQL Server)
-- ===============================================
-- Reset identity seed after truncate (SQL Server specific)
TRUNCATE TABLE employee;
DBCC CHECKIDENT (employee, RESEED, 0);

-- ===============================================
-- 3. TRUNCATE NON-PK TABLE
-- ===============================================
-- Truncate a table that is not referenced by foreign keys
TRUNCATE TABLE employee;

-- ===============================================
-- 4. TRUNCATE TABLE - Check if successful
-- ===============================================
-- After truncate, verify the table is empty
TRUNCATE TABLE employee;

-- Verify truncate worked:
SELECT COUNT(*) as remaining_records FROM employee;

-- ===============================================
-- 5. TRUNCATE WITH TRANSACTION
-- ===============================================
-- Use transaction for safety (though TRUNCATE cannot always be rolled back)
BEGIN;
TRUNCATE TABLE employee;
-- Review, then COMMIT or ROLLBACK
-- COMMIT;
-- ROLLBACK;

-- ===============================================
-- 6. TRUNCATE STAGING/TEMPORARY TABLE
-- ===============================================
-- Truncate interim work tables regularly
TRUNCATE TABLE staging_employee;
TRUNCATE TABLE temp_data;

-- ===============================================
-- DROP COMMAND EXAMPLES
-- ===============================================

-- ===============================================
-- 7. DROP TABLE - REMOVE ENTIRE TABLE
-- ===============================================
-- DROP removes the entire table (structure + data)
-- Cannot be undone without backup!

-- Drop employee table completely
DROP TABLE employee;

-- Drop department table completely
DROP TABLE department;

-- ===============================================
-- 8. DROP TABLE IF EXISTS
-- ===============================================
-- Safe way to drop - doesn't error if table doesn't exist
-- Useful in scripts that may run multiple times

-- Drop employee table if it exists
DROP TABLE IF EXISTS employee;

-- Drop department table if it exists
DROP TABLE IF EXISTS department;

-- ===============================================
-- 9. DROP MULTIPLE TABLES
-- ===============================================
-- Drop multiple tables in one command

-- MySQL/PostgreSQL syntax
DROP TABLE IF EXISTS employee, department, staging_employee;

-- SQL Server syntax
DROP TABLE IF EXISTS employee;
DROP TABLE IF EXISTS department;
DROP TABLE IF EXISTS staging_employee;

-- ===============================================
-- 10. DROP TABLE WITH CONSTRAINTS
-- ===============================================
-- When dropping table with foreign keys, order matters
-- Drop child table first, then parent table

-- Drop employee first (has FK to department)
DROP TABLE IF EXISTS employee;

-- Then drop department
DROP TABLE IF EXISTS department;

-- ===============================================
-- 11. DROP TABLE - CASCADING OPTION (SQL Server)
-- ===============================================
-- Drop table and any dependent foreign keys
-- SQL Server specific syntax

-- This may not work in all databases - check documentation
-- ALTER TABLE employee DROP CONSTRAINT fk_department;
-- DROP TABLE employee;

-- ===============================================
-- 12. DROP TEMPORARY TABLE
-- ===============================================
-- Drop temporary/staging tables after processing

DROP TABLE IF EXISTS employee_backup;
DROP TABLE IF EXISTS temp_employee_data;
DROP TABLE IF EXISTS employee_archive;

-- ===============================================
-- 13. DROP TABLE VERIFICATION
-- ===============================================
-- After dropping, table is completely gone
-- Try to access it and it will error

DROP TABLE IF EXISTS employee;

-- This will error because table no longer exists:
-- SELECT * FROM employee;  -- ERROR!

-- ===============================================
-- DROP vs TRUNCATE vs DELETE - COMPARISON
-- ===============================================
/*
┌─────────────────────┬──────────────────┬────────────────────┬─────────────────┐
│ Feature             │ DELETE           │ TRUNCATE           │ DROP            │
├─────────────────────┼──────────────────┼────────────────────┼─────────────────┤
│ Removes             │ Rows only        │ Rows only          │ Table & rows    │
│ WHERE clause        │ Yes (required)   │ No (all rows)      │ N/A             │
│ Speed               │ Slow             │ Very fast          │ Very fast       │
│ Logging             │ Full logging     │ Minimal logging    │ Minimal logging │
│ Identity reset      │ No               │ Yes                │ Yes (dropped)   │
│ Space freed         │ No               │ Yes (deallocate)   │ Yes (deallocate)│
│ Triggers            │ Fired            │ Not fired          │ Not fired       │
│ Rollback            │ Yes              │ Yes (with trans)   │ Yes (with trans)│
│ FK constraint       │ Checked          │ Cannot use if FK   │ Dropped first   │
│ Memory usage        │ Row locks        │ Table lock         │ N/A             │
│ DDL/DML             │ DML              │ DDL                │ DDL             │
│ Structure remains   │ Yes              │ Yes                │ No              │
└─────────────────────┴──────────────────┴────────────────────┴─────────────────┘

USE CASES:
- DELETE:   Remove specific/some rows, need WHERE, triggers needed
- TRUNCATE: Remove all data fast, reset table, keep structure
- DROP:     Remove entire table, start fresh, full cleanup
*/

-- ===============================================
-- WHEN TO USE EACH COMMAND
-- ===============================================
/*
DELETE:
  - Need to remove specific rows
  - Must use WHERE clause
  - Triggers should fire
  - Slow on large datasets
  - Example: DELETE FROM employee WHERE departmentId = 3;

TRUNCATE:
  - Remove ALL rows quickly
  - Keep table structure
  - Reset identity/auto-increment
  - Cannot use with FK constraints
  - Example: TRUNCATE TABLE staging_data;

DROP:
  - Remove entire table and structure
  - Permanent deletion
  - Good for cleanup of temp tables
  - Must recreate table to use again
  - Example: DROP TABLE temp_employee; or DROP TABLE IF EXISTS temp_employee;
*/

-- ===============================================
-- PRACTICAL WORKFLOW EXAMPLES
-- ===============================================

-- Example 1: Truncate staging table after import
-- TRUNCATE TABLE staging_employee;

-- Example 2: Drop temporary work tables after processing
-- DROP TABLE IF EXISTS temp_employee_data;
-- DROP TABLE IF EXISTS temp_calculations;

-- Example 3: Remove old archive tables
-- DROP TABLE IF EXISTS employee_archive_2024;
-- DROP TABLE IF EXISTS department_archive_2024;

-- Example 4: Clear and refill employees table
-- TRUNCATE TABLE employee;
-- INSERT INTO employee VALUES (...);

-- Example 5: Safe drop of multiple tables
-- DROP TABLE IF EXISTS employee;
-- DROP TABLE IF EXISTS department;
-- DROP TABLE IF EXISTS employee_staging;

-- ===============================================
-- BACKUP & RECOVERY STRATEGY
-- ===============================================

-- Before DROP or TRUNCATE, backup the table:
-- CREATE TABLE employee_backup AS SELECT * FROM employee;
-- CREATE TABLE department_backup AS SELECT * FROM department;

-- Execute the DROP/TRUNCATE:
-- DROP TABLE employee;

-- If needed, restore from backup:
-- INSERT INTO employee SELECT * FROM employee_backup;

-- ===============================================
-- PRACTICE EXAMPLES - Uncomment CAREFULLY!
-- ===============================================

-- Example 1: Truncate employee table
-- TRUNCATE TABLE employee;

-- Example 2: Verify truncate worked
-- SELECT COUNT(*) FROM employee;  -- Should return 0

-- Example 3: Drop employee table safely
-- DROP TABLE IF EXISTS employee;

-- Example 4: Drop multiple related tables
-- DROP TABLE IF EXISTS employee;
-- DROP TABLE IF EXISTS department;

-- Example 5: Create backup before DROP
-- CREATE TABLE employee_backup AS SELECT * FROM employee;
-- DROP TABLE IF EXISTS employee;

-- ===============================================
-- IMPORTANT: RECOVERY OPTIONS
-- ===============================================
/*
If you accidentally DROP or TRUNCATE:

OPTION 1: Restore from Backup
- Have database backups scheduled
- Point-in-time recovery available
- Fastest recovery method

OPTION 2: Restore from Transaction Log
- SQL Server: Use transaction log backups
- PostgreSQL: Use WAL (Write-Ahead Logging)

OPTION 3: Restore from Application Backups
- Daily/weekly database exports
- CSV/JSON export files
- Manual data files

RECOMMENDED ACTIONS:
- Always maintain regular backups
- Use staging/temporary tables for testing
- Test DROP/TRUNCATE commands on DEV first
- Use DROP TABLE IF EXISTS in scripts
- Document critical table structures

PREVENTION TIPS:
- Use transactions when possible
- Restrict access with permissions
- Monitor database activity logs
- Use read-only replicas for reporting
- Archive old data before cleanup
*/

-- ===============================================
-- KEY POINTS TO REMEMBER
-- ===============================================
-- 1. DELETE removes rows; TRUNCATE & DROP remove structure or all
-- 2. TRUNCATE is much faster than DELETE for large datasets
-- 3. DROP removes entire table - must recreate to use again
-- 4. TRUNCATE resets identity values; DELETE does not
-- 5. TRUNCATE cannot have WHERE clause - removes all rows
-- 6. DROP/TRUNCATE cannot be used with active FK constraints
-- 7. Use DROP TABLE IF EXISTS for safe scripting
-- 8. Always backup before running DROP or TRUNCATE
-- 9. Test on DEV environment first!
-- 10. Use transactions when possible (with caution)
-- 11. Monitor and log all DROP operations
-- 12. Keep detailed documentation of table structures
-- ===============================================
