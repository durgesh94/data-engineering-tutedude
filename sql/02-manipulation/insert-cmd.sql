/*
================================================================================
  DATA INSERTION SCRIPT: Employee and Department Sample Data
================================================================================
  Description: Inserts sample data into department and employee tables.
  
  EXECUTION ORDER: IMPORTANT!
    1. Department table first (parent table)
    2. Employee table second (child table with FK constraints)
    
  IMPORTANT: Maintain referential integrity - departments must exist
             before employees can be assigned to them.
             
  SAMPLE DATA: 
    - 1 Department: Human Resources
    - 1 Employee: John Doe assigned to HR department
================================================================================
*/

-- Step 1: Insert department records first (parent table)
-- Departments should be created before employees to maintain FK integrity
INSERT INTO department (departmentId, name) VALUES
(1, 'Human Resources'),
(2, 'Engineering'),
(3, 'Sales'),
(4, 'Finance');

-- Step 2: Insert employee records (child table with FK to department)
-- Note: departmentId must reference an existing department
INSERT INTO employee (employeeId, first_name, last_name, email, salary, departmentId) VALUES
(1, 'John', 'Doe', 'john.doe@example.com', 50000.00, 1),
(2, 'Jane', 'Smith', 'jane.smith@example.com', 65000.00, 2),
(3, 'Robert', 'Johnson', 'robert.johnson@example.com', 55000.00, 3),
(4, 'Emily', 'Brown', 'emily.brown@example.com', 60000.00, 4);