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

-- Step 3: Insert project records (child table with FK to department)
-- Note: departmentId must reference an existing department
-- Projects are managed by different departments
INSERT INTO project (projectId, project_name, description, start_date, end_date, budget, departmentId, status) VALUES
(1, 'HR Management System', 'Build internal HR management system for employee records and payroll', '2025-01-15', '2025-06-30', 150000.00, 1, 'Active'),
(2, 'Mobile App Development', 'Develop cross-platform mobile application for customer engagement', '2025-02-01', '2025-08-31', 300000.00, 2, 'Active'),
(3, 'Data Analytics Platform', 'Create data analytics platform for business intelligence', '2025-03-10', '2025-09-30', 250000.00, 2, 'Active'),
(4, 'Sales Dashboard', 'Build real-time sales tracking and reporting dashboard', '2025-03-01', '2025-05-31', 100000.00, 3, 'On Hold'),
(5, 'Financial Audit System', 'Implement automated financial audit and compliance checking system', '2025-04-01', '2025-10-31', 200000.00, 4, 'Active'),
(6, 'Customer Portal', 'Develop web portal for customer self-service and order tracking', '2025-05-01', '2025-09-30', 180000.00, 3, 'Completed');

-- Step 4: Insert project assignment records (many-to-many link)
-- Junction table linking employees to projects
-- Each assignment specifies: which employee, on which project, in what role, % allocation
INSERT INTO project_assignment (assignment_id, employeeId, projectId, role, allocation_percentage, assignment_date) VALUES
-- John Doe (HR) - Project 1 (HR Management System)
(1, 1, 1, 'Project Manager', 100.00, '2025-01-15'),

-- Jane Smith (Engineering) - Multiple projects
(2, 2, 2, 'Lead Developer', 100.00, '2025-02-01'),
(3, 2, 3, 'Architect', 50.00, '2025-03-10'),

-- Robert Johnson (Sales) - Multiple projects
(4, 3, 4, 'Business Analyst', 100.00, '2025-03-01'),
(5, 3, 6, 'Project Coordinator', 50.00, '2025-05-01'),

-- Emily Brown (Finance) - Multiple projects
(6, 4, 1, 'Finance Consultant', 30.00, '2025-01-15'),
(7, 4, 5, 'Audit Lead', 100.00, '2025-04-01');
