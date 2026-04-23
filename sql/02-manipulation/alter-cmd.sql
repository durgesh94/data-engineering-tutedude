/*
================================================================================
  SQL ALTER COMMAND - Tutorial
================================================================================
  Description: Modify existing table structures using ALTER command
               Add/remove/modify columns, constraints, and indexes
  
  SCHEMA OVERVIEW:
    - department: departmentId (PK), name
    - employee: employeeId (PK), first_name, last_name, email, salary, departmentId (FK)
    - project: projectId (PK), project_name, description, start_date, end_date, 
               budget, departmentId (FK), status
    - project_assignment: assignment_id (PK), employeeId (FK), projectId (FK), 
                          role, allocation_percentage, assignment_date
  
  ALTER COMMAND FEATURES:
    - ADD: Add new columns or constraints
    - DROP: Remove columns or constraints
    - MODIFY/CHANGE: Modify column properties
    - RENAME: Rename columns or tables
    - ADD INDEX: Create indexes for performance
  
  ⚠️  WARNING ⚠️
    - ALTER TABLE can lock tables and affect performance
    - Always backup before executing ALTER on production
    - Some operations may cause data loss
    - Test on DEV environment first
================================================================================
*/

-- ===============================================
-- 1. ALTER TABLE - ADD COLUMN
-- ===============================================
-- Add a new column to existing table

-- Add phone number column to employee table
ALTER TABLE employee
ADD COLUMN phone_number varchar(15);

-- Add hire date column to employee table
ALTER TABLE employee
ADD COLUMN hire_date DATE;

-- Add manager_email column to department table
ALTER TABLE department
ADD COLUMN manager_email varchar(100);

-- ===============================================
-- 2. ALTER TABLE - ADD MULTIPLE COLUMNS
-- ===============================================
-- Add multiple columns at once

ALTER TABLE employee
ADD COLUMN (
    position varchar(50),
    status varchar(20)
);

-- ===============================================
-- 3. ALTER TABLE - ADD COLUMN WITH DEFAULT VALUE
-- ===============================================
-- Add column with default value

-- Add status column with default 'Active'
ALTER TABLE employee
ADD COLUMN employment_status varchar(20) DEFAULT 'Active';

-- Add created_date with current timestamp
ALTER TABLE project
ADD COLUMN created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

-- Add is_active flag with default true
ALTER TABLE employee
ADD COLUMN is_active BOOLEAN DEFAULT 1;

-- ===============================================
-- 4. ALTER TABLE - ADD COLUMN WITH NOT NULL
-- ===============================================
-- Add required column (must have default for existing rows)

ALTER TABLE employee
ADD COLUMN job_title varchar(100) NOT NULL DEFAULT 'Employee';

-- ===============================================
-- 5. ALTER TABLE - DROP COLUMN
-- ===============================================
-- Remove a column from table

-- Drop phone_number column from employee
ALTER TABLE employee
DROP COLUMN phone_number;

-- Drop description column from project
ALTER TABLE project
DROP COLUMN description;

-- ===============================================
-- 6. ALTER TABLE - DROP MULTIPLE COLUMNS
-- ===============================================
-- Drop multiple columns (database dependent)

-- MySQL/PostgreSQL syntax
ALTER TABLE employee
DROP COLUMN phone_number,
DROP COLUMN position;

-- SQL Server syntax
-- ALTER TABLE employee DROP COLUMN phone_number, position;

-- ===============================================
-- 7. ALTER TABLE - MODIFY COLUMN (MySQL)
-- ===============================================
-- Change column data type or properties

-- Change salary to larger decimal
ALTER TABLE employee
MODIFY COLUMN salary decimal(12, 2);

-- Change first_name to longer varchar
ALTER TABLE employee
MODIFY COLUMN first_name varchar(100);

-- Add NOT NULL constraint to existing column
ALTER TABLE employee
MODIFY COLUMN email varchar(100) NOT NULL;

-- ===============================================
-- 8. ALTER TABLE - CHANGE COLUMN (MySQL)
-- ===============================================
-- Rename and modify column in one command

-- Rename and modify salary column
ALTER TABLE employee
CHANGE COLUMN salary annual_salary decimal(12, 2);

-- Rename and change employment_status column
ALTER TABLE employee
CHANGE COLUMN status emp_status varchar(30) DEFAULT 'Active';

-- ===============================================
-- 9. ALTER TABLE - ALTER COLUMN (SQL Server/PostgreSQL)
-- ===============================================
-- Modify column properties (SQL Server specific)

-- Alter column to allow NULL
-- ALTER TABLE employee ALTER COLUMN phone_number varchar(15);

-- Set default value
ALTER TABLE employee ALTER COLUMN emp_status SET DEFAULT 'Active';

-- ===============================================
-- 10. ALTER TABLE - RENAME COLUMN
-- ===============================================
-- Rename a column (database dependent)

-- MySQL 8.0.14+
ALTER TABLE employee
RENAME COLUMN employment_status TO emp_status;

-- PostgreSQL
-- ALTER TABLE employee RENAME COLUMN employment_status TO emp_status;

-- SQL Server
-- EXEC sp_rename 'employee.employment_status', 'emp_status', 'COLUMN';

-- ===============================================
-- 11. ALTER TABLE - RENAME TABLE
-- ===============================================
-- Rename entire table

-- MySQL
ALTER TABLE employee RENAME TO staff_member;

-- PostgreSQL
-- ALTER TABLE employee RENAME TO staff_member;

-- SQL Server
-- EXEC sp_rename 'employee', 'staff_member';

-- Rename back for consistency
ALTER TABLE staff_member RENAME TO employee;

-- ===============================================
-- 12. ALTER TABLE - ADD PRIMARY KEY
-- ===============================================
-- Add or modify primary key (usually on table creation)

-- Add primary key if not already defined
-- ALTER TABLE project_assignment ADD PRIMARY KEY (assignment_id);

-- ===============================================
-- 13. ALTER TABLE - ADD FOREIGN KEY
-- ===============================================
-- Add foreign key constraint to existing column

-- Add FK to link project to department
ALTER TABLE project
ADD CONSTRAINT fk_project_dept FOREIGN KEY (departmentId) REFERENCES department(departmentId);

-- Add FK for employee-department relationship
ALTER TABLE employee
ADD CONSTRAINT fk_emp_dept FOREIGN KEY (departmentId) REFERENCES department(departmentId);

-- ===============================================
-- 14. ALTER TABLE - DROP FOREIGN KEY
-- ===============================================
-- Remove a foreign key constraint

-- MySQL
ALTER TABLE employee
DROP FOREIGN KEY fk_emp_dept;

-- PostgreSQL
-- ALTER TABLE employee DROP CONSTRAINT fk_emp_dept;

-- SQL Server
-- ALTER TABLE employee DROP CONSTRAINT fk_emp_dept;

-- ===============================================
-- 15. ALTER TABLE - ADD UNIQUE CONSTRAINT
-- ===============================================
-- Add unique constraint to column

-- Make employee email unique
ALTER TABLE employee
ADD CONSTRAINT unique_email UNIQUE (email);

-- Make project name unique
ALTER TABLE project
ADD CONSTRAINT unique_project_name UNIQUE (project_name);

-- ===============================================
-- 16. ALTER TABLE - DROP UNIQUE CONSTRAINT
-- ===============================================
-- Remove unique constraint

-- MySQL
ALTER TABLE employee
DROP INDEX unique_email;

-- PostgreSQL/SQL Server
-- ALTER TABLE employee DROP CONSTRAINT unique_email;

-- ===============================================
-- 17. ALTER TABLE - ADD CHECK CONSTRAINT
-- ===============================================
-- Add check constraint for data validation

-- Salary must be positive
ALTER TABLE employee
ADD CONSTRAINT check_positive_salary CHECK (salary > 0);

-- Status must be valid value
ALTER TABLE project
ADD CONSTRAINT check_status CHECK (status IN ('Active', 'Completed', 'On Hold'));

-- Allocation percentage must be between 0 and 100
ALTER TABLE project_assignment
ADD CONSTRAINT check_allocation CHECK (allocation_percentage >= 0 AND allocation_percentage <= 100);

-- ===============================================
-- 18. ALTER TABLE - DROP CHECK CONSTRAINT
-- ===============================================
-- Remove check constraint

-- MySQL
ALTER TABLE employee
DROP CONSTRAINT check_positive_salary;

-- PostgreSQL
-- ALTER TABLE employee DROP CONSTRAINT check_positive_salary;

-- SQL Server
-- ALTER TABLE employee DROP CONSTRAINT check_positive_salary;

-- ===============================================
-- 19. ALTER TABLE - ADD INDEX
-- ===============================================
-- Create index for faster queries

-- Create index on employee last_name
ALTER TABLE employee
ADD INDEX idx_last_name (last_name);

-- Create index on project status
ALTER TABLE project
ADD INDEX idx_status (status);

-- Create composite index on project dates
ALTER TABLE project
ADD INDEX idx_dates (start_date, end_date);

-- ===============================================
-- 20. ALTER TABLE - DROP INDEX
-- ===============================================
-- Remove index

-- MySQL
ALTER TABLE employee
DROP INDEX idx_last_name;

-- PostgreSQL
-- DROP INDEX idx_last_name;

-- SQL Server
-- DROP INDEX idx_last_name ON employee;

-- ===============================================
-- 21. ALTER TABLE - ADD AUTO_INCREMENT
-- ===============================================
-- Add auto-increment to existing column (usually for IDs)

-- MySQL: Set auto-increment starting value
ALTER TABLE employee
MODIFY COLUMN employeeId INT AUTO_INCREMENT;

-- ===============================================
-- 22. ALTER TABLE - ADD COLUMN AFTER SPECIFIC COLUMN
-- ===============================================
-- Add column in specific position (MySQL specific)

-- Add phone_number between email and salary
ALTER TABLE employee
ADD COLUMN phone_number varchar(15) AFTER email;

-- Add hire_date before salary
ALTER TABLE employee
ADD COLUMN hire_date DATE AFTER email;

-- ===============================================
-- 23. ALTER TABLE - MODIFY COLUMN DEFAULT VALUE
-- ===============================================
-- Change default value of column

-- Set new default for status
ALTER TABLE project
MODIFY COLUMN status varchar(20) DEFAULT 'Active';

-- Change salary default
ALTER TABLE employee
MODIFY COLUMN salary DECIMAL(10,2) DEFAULT 50000;

-- ===============================================
-- PRACTICAL WORKFLOW EXAMPLES
-- ===============================================

-- Example 1: Add tracking columns to employee table
-- ALTER TABLE employee ADD COLUMN created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
-- ALTER TABLE employee ADD COLUMN last_modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

-- Example 2: Add contact info to department
-- ALTER TABLE department ADD COLUMN phone varchar(15);
-- ALTER TABLE department ADD COLUMN location varchar(100);
-- ALTER TABLE department ADD COLUMN budget DECIMAL(12,2);

-- Example 3: Enhance project table with priorities
-- ALTER TABLE project ADD COLUMN priority INT DEFAULT 1;
-- ALTER TABLE project ADD CHECK (priority BETWEEN 1 AND 5);

-- Example 4: Add performance tracking columns
-- ALTER TABLE employee ADD COLUMN performance_rating INT;
-- ALTER TABLE employee ADD COLUMN last_review_date DATE;
-- ALTER TABLE employee ADD CHECK (performance_rating BETWEEN 1 AND 5);

-- Example 5: Safe column rename (if supported)
-- ALTER TABLE employee RENAME COLUMN first_name TO fname;
-- ALTER TABLE employee RENAME COLUMN last_name TO lname;

-- ===============================================
-- PRACTICE EXAMPLES - Uncomment CAREFULLY!
-- ===============================================

-- Example 1: Add contact columns to employee
-- ALTER TABLE employee
-- ADD COLUMN phone_number varchar(15);
-- ADD COLUMN address varchar(200);
-- ADD COLUMN city varchar(50);

-- Example 2: Make email column NOT NULL
-- ALTER TABLE employee
-- MODIFY COLUMN email varchar(100) NOT NULL;

-- Example 3: Add tracking columns
-- ALTER TABLE employee ADD COLUMN created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
-- ALTER TABLE employee ADD COLUMN updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

-- Example 4: Add index for common queries
-- ALTER TABLE employee ADD INDEX idx_dept (departmentId);
-- ALTER TABLE project ADD INDEX idx_status (status);

-- Example 5: Add default values
-- ALTER TABLE employee MODIFY COLUMN employment_status varchar(20) DEFAULT 'Active';
-- ALTER TABLE project MODIFY COLUMN status varchar(20) DEFAULT 'Active';

-- ===============================================
-- COMMON ALTER TABLE OPERATIONS REFERENCE
-- ===============================================
/*
ADD COLUMN:           Add new column(s) to table
DROP COLUMN:          Remove column(s) from table
MODIFY/CHANGE:        Change column data type or properties
RENAME COLUMN:        Rename a column
RENAME TO:            Rename the table
ADD CONSTRAINT:       Add primary key, foreign key, unique, check
DROP CONSTRAINT:      Remove constraints
ADD INDEX:            Create index for performance
DROP INDEX:           Remove index
ADD DEFAULT:          Set default value for column
ADD NOT NULL:         Make column required
CHANGE:               MySQL - rename and modify in one step
*/

-- ===============================================
-- BACKUP STRATEGY BEFORE ALTER
-- ===============================================
/*
Before running ALTER on important tables:

1. CREATE BACKUP TABLE:
   CREATE TABLE employee_backup AS SELECT * FROM employee;

2. TEST ON DEV FIRST:
   - Run on development database
   - Verify results before production

3. EXECUTE ALTER:
   - During maintenance window
   - Notify users of downtime
   - Monitor performance

4. VERIFY RESULTS:
   - Check table structure: DESCRIBE employee;
   - Check data integrity: SELECT COUNT(*) FROM employee;
   - Verify constraints work

5. RECOVERY PLAN:
   - If something goes wrong
   - Use backup table to restore
   - Have rollback plan ready
*/

-- ===============================================
-- KEY POINTS TO REMEMBER
-- ===============================================
-- 1. ALTER TABLE can lock tables - use during maintenance
-- 2. Always backup tables before running ALTER
-- 3. Test on DEV environment first
-- 4. Some ALTER operations cannot be undone
-- 5. MODIFY changes may cause data loss
-- 6. Adding NOT NULL requires default or existing values
-- 7. Dropping columns removes data permanently
-- 8. Unique constraints prevent duplicate values
-- 9. Foreign keys ensure referential integrity
-- 10. Indexes improve query performance but slow INSERT/UPDATE
-- 11. CHECK constraints validate data on insert/update
-- 12. Database syntax varies (MySQL, PostgreSQL, SQL Server)
-- ===============================================
