/*
================================================================================
  TABLE CREATION SCRIPT: Employee, Department & Project Management
================================================================================
  Description: Creates employee, department, and project tables with multiple
               relationship types (one-to-many and many-to-many).
  
  SCHEMA OVERVIEW:
    - department: Master table storing department information
    - employee: Stores employee details with department assignment
    - project: Stores project information with department assignment
    - project_assignment: Junction table for many-to-many (Employee <-> Project)
    
  RELATIONSHIP TYPES:
    1. One-to-Many (Department -> Employees)
    2. One-to-Many (Department -> Projects)
    3. Many-to-Many (Employees <-> Projects via project_assignment)
  
  CONSTRAINTS:
    - Email must be unique per employee
    - Project name must be unique
    - Employee must belong to a valid department
    - Project must belong to a valid department
    - departmentId uses Foreign Key constraint for referential integrity
    - project_assignment links employee and project with composite key
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
    CONSTRAINT fk_employee_department FOREIGN KEY (departmentId) REFERENCES department(departmentId)
);

-- Project table: Stores project information linked to a department
CREATE TABLE project (
    projectId int PRIMARY KEY,              -- Unique project identifier
    project_name varchar(100) NOT NULL UNIQUE, -- Project name (must be unique)
    description varchar(500),               -- Project description
    start_date DATE,                        -- Project start date
    end_date DATE,                          -- Project end date
    budget decimal(12, 2),                  -- Project budget
    departmentId int NOT NULL,              -- FK: Department managing the project
    status varchar(20),                     -- Status: Active, Completed, On Hold
    CONSTRAINT fk_project_department FOREIGN KEY (departmentId) REFERENCES department(departmentId)
);

-- Project Assignment: Junction table for many-to-many relationship
-- Links employees to projects (one employee can work on many projects)
CREATE TABLE project_assignment (
    assignment_id int PRIMARY KEY,          -- Unique assignment identifier
    employeeId int NOT NULL,                -- FK: Reference to employee
    projectId int NOT NULL,                 -- FK: Reference to project
    role varchar(100),                      -- Role in the project (e.g., Developer, Manager)
    allocation_percentage decimal(5, 2),    -- Percentage of time allocated to project
    assignment_date DATE,                   -- Date of assignment
    CONSTRAINT fk_assignment_employee FOREIGN KEY (employeeId) REFERENCES employee(employeeId),
    CONSTRAINT fk_assignment_project FOREIGN KEY (projectId) REFERENCES project(projectId),
    CONSTRAINT unique_assignment UNIQUE (employeeId, projectId) -- Prevent duplicate assignments
);