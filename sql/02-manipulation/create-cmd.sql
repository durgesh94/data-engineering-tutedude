/*
================================================================================
  TABLE CREATION SCRIPT: Employee and Department Management
================================================================================
  Description: Creates employee and department tables with one-to-many
               relationship (one department can have many employees).
  
  SCHEMA OVERVIEW:
    - department: Master table storing department information
    - employee: Stores employee details with department assignment
    
  RELATIONSHIP TYPE: One-to-Many (Department -> Employees)
  
  CONSTRAINTS:
    - Email must be unique per employee
    - Employee must belong to a valid department
    - departmentId uses Foreign Key constraint for referential integrity
================================================================================
*/

-- Department table: Master table for all departments
CREATE TABLE department (
    departmentId int PRIMARY KEY,           -- Unique department identifier
    name varchar(100) NOT NULL              -- Department name
);

-- Employee table: Stores employee information linked to a department
CREATE TABLE employee (
    employeeId int PRIMARY KEY,             -- Unique employee identifier
    first_name varchar(50) NOT NULL,        -- Employee's first name
    last_name varchar(50) NOT NULL,         -- Employee's last name
    email varchar(100) UNIQUE,              -- Contact email (must be unique)
    salary decimal(10, 2),                  -- Annual salary (8 digits, 2 decimals)
    departmentId int,                       -- FK: Reference to department
    CONSTRAINT fk_department FOREIGN KEY (departmentId) REFERENCES department(departmentId)
);