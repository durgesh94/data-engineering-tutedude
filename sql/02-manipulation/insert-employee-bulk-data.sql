/*
================================================================================
  BULK EMPLOYEE DATA INSERTION: 46 Additional Employee Records
================================================================================
  Description: Inserts 46 additional dummy employee records into the employee table.
               These records expand the dataset for testing, reporting, and analysis.
  
  EXECUTION ORDER:
    1. Run insert-cmd.sql FIRST (creates initial 4 employees)
    2. Run this script SECOND (adds 46 more employees)
    
  IMPORTANT: 
    - Departments must exist (insert-cmd.sql creates departments first)
    - Employee IDs continue from 5 onwards (previous script used 1-4)
    - Salary ranges vary by department
    - Distribution: ~12 per department for better testing data
    
  EMPLOYEE ID ALLOCATION:
    - IDs 1-4: Original employees (from insert-cmd.sql)
    - IDs 5-50: New employees (this script - 46 total)
    
  DEPARTMENT DISTRIBUTION:
    - HR (Dept 1):    Employees 5-13 (9 employees)
    - Engineering (Dept 2): Employees 14-28 (15 employees)
    - Sales (Dept 3): Employees 29-40 (12 employees)
    - Finance (Dept 4): Employees 41-50 (10 employees)
    
  SALARY RANGES:
    - HR: 45,000 - 75,000
    - Engineering: 60,000 - 120,000
    - Sales: 40,000 - 90,000 (with commissions)
    - Finance: 55,000 - 100,000
================================================================================
*/

-- ============================================================================
-- SECTION 1: HR DEPARTMENT EMPLOYEES (IDs 5-13) - 9 employees
-- ============================================================================
INSERT INTO employee (employeeId, first_name, last_name, email, salary, departmentId) VALUES

-- HR Specialist / Recruiters
(5, 'Michael', 'Williams', 'michael.williams@example.com', 52000.00, 1),
(6, 'Sarah', 'Jones', 'sarah.jones@example.com', 58000.00, 1),
(7, 'David', 'Miller', 'david.miller@example.com', 55000.00, 1),
(8, 'Lisa', 'Davis', 'lisa.davis@example.com', 60000.00, 1),
(9, 'James', 'Garcia', 'james.garcia@example.com', 54000.00, 1),
(10, 'Jennifer', 'Rodriguez', 'jennifer.rodriguez@example.com', 62000.00, 1),
(11, 'Christopher', 'Martinez', 'christopher.martinez@example.com', 57000.00, 1),
(12, 'Amanda', 'Hernandez', 'amanda.hernandez@example.com', 64000.00, 1),
(13, 'Daniel', 'Lopez', 'daniel.lopez@example.com', 59000.00, 1);

-- ============================================================================
-- SECTION 2: ENGINEERING DEPARTMENT EMPLOYEES (IDs 14-28) - 15 employees
-- ============================================================================
INSERT INTO employee (employeeId, first_name, last_name, email, salary, departmentId) VALUES

-- Senior Engineers / Leads
(14, 'Andrew', 'Gonzalez', 'andrew.gonzalez@example.com', 95000.00, 2),
(15, 'Michelle', 'Wilson', 'michelle.wilson@example.com', 92000.00, 2),
(16, 'Ryan', 'Anderson', 'ryan.anderson@example.com', 88000.00, 2),
(17, 'Christina', 'Thomas', 'christina.thomas@example.com', 90000.00, 2),

-- Mid-level Engineers
(18, 'Brandon', 'Taylor', 'brandon.taylor@example.com', 75000.00, 2),
(19, 'Jessica', 'Moore', 'jessica.moore@example.com', 78000.00, 2),
(20, 'Kevin', 'Jackson', 'kevin.jackson@example.com', 72000.00, 2),
(21, 'Stephanie', 'White', 'stephanie.white@example.com', 76000.00, 2),
(22, 'Justin', 'Harris', 'justin.harris@example.com', 74000.00, 2),

-- Junior Engineers / Developers
(23, 'Lauren', 'Martin', 'lauren.martin@example.com', 65000.00, 2),
(24, 'Eric', 'Thompson', 'eric.thompson@example.com', 63000.00, 2),
(25, 'Megan', 'Garcia', 'megan.garcia@example.com', 66000.00, 2),
(26, 'Nathan', 'Black', 'nathan.black@example.com', 62000.00, 2),
(27, 'Ashley', 'Perez', 'ashley.perez@example.com', 64000.00, 2),
(28, 'Benjamin', 'Green', 'benjamin.green@example.com', 120000.00, 2);

-- ============================================================================
-- SECTION 3: SALES DEPARTMENT EMPLOYEES (IDs 29-40) - 12 employees
-- ============================================================================
INSERT INTO employee (employeeId, first_name, last_name, email, salary, departmentId) VALUES

-- Sales Managers / Team Leads
(29, 'Mark', 'Adams', 'mark.adams@example.com', 75000.00, 3),
(30, 'Susan', 'Nelson', 'susan.nelson@example.com', 78000.00, 3),
(31, 'Paul', 'Carter', 'paul.carter@example.com', 72000.00, 3),

-- Senior Sales Representatives
(32, 'Karen', 'Roberts', 'karen.roberts@example.com', 65000.00, 3),
(33, 'Brian', 'Phillips', 'brian.phillips@example.com', 68000.00, 3),
(34, 'Nancy', 'Evans', 'nancy.evans@example.com', 62000.00, 3),

-- Sales Representatives
(35, 'Joseph', 'Edwards', 'joseph.edwards@example.com', 55000.00, 3),
(36, 'Susan', 'Collins', 'susan.collins@example.com', 58000.00, 3),
(37, 'Charles', 'Stewart', 'charles.stewart@example.com', 56000.00, 3),
(38, 'Lisa', 'Sanchez', 'lisa.sanchez@example.com', 60000.00, 3),
(39, 'Donald', 'Morris', 'donald.morris@example.com', 90000.00, 3),
(40, 'Angela', 'Rogers', 'angela.rogers@example.com', 85000.00, 3);

-- ============================================================================
-- SECTION 4: FINANCE DEPARTMENT EMPLOYEES (IDs 41-50) - 10 employees
-- ============================================================================
INSERT INTO employee (employeeId, first_name, last_name, email, salary, departmentId) VALUES

-- Finance Managers / Seniors
(41, 'Thomas', 'Reed', 'thomas.reed@example.com', 85000.00, 4),
(42, 'Sandra', 'Cook', 'sandra.cook@example.com', 87000.00, 4),
(43, 'Matthew', 'Morgan', 'matthew.morgan@example.com', 82000.00, 4),

-- Accountants / Analysts
(44, 'Brenda', 'Bell', 'brenda.bell@example.com', 68000.00, 4),
(45, 'Steven', 'Murphy', 'steven.murphy@example.com', 70000.00, 4),
(46, 'Dorothy', 'Bailey', 'dorothy.bailey@example.com', 66000.00, 4),
(47, 'Paul', 'Rivera', 'paul.rivera@example.com', 72000.00, 4),
(48, 'Frances', 'Cooper', 'frances.cooper@example.com', 65000.00, 4),
(49, 'Andrew', 'Richardson', 'andrew.richardson@example.com', 100000.00, 4),
(50, 'Kathryn', 'Cox', 'kathryn.cox@example.com', 95000.00, 4);

-- ============================================================================
-- VERIFICATION QUERIES (Run after insert to verify data)
-- ============================================================================

-- View all newly inserted employees (IDs 5-50)
-- SELECT * FROM employee WHERE employeeId BETWEEN 5 AND 50 ORDER BY departmentId, employeeId;

-- Count employees per department
-- SELECT d.name, COUNT(e.employeeId) as total_employees, AVG(e.salary) as avg_salary
-- FROM employee e
-- RIGHT JOIN department d ON e.departmentId = d.departmentId
-- WHERE e.employeeId BETWEEN 5 AND 50
-- GROUP BY d.departmentId, d.name;

-- Find salary statistics
-- SELECT 
--   departmentId,
--   COUNT(*) as employee_count,
--   MIN(salary) as min_salary,
--   MAX(salary) as max_salary,
--   ROUND(AVG(salary), 2) as avg_salary
-- FROM employee
-- WHERE employeeId BETWEEN 5 AND 50
-- GROUP BY departmentId
-- ORDER BY departmentId;

-- ============================================================================
-- SUMMARY
-- ============================================================================
-- Total New Employees Added: 46
-- Total Employees in System: 50 (4 original + 46 new)
-- Department Distribution:
--   - HR (1):         9 employees
--   - Engineering (2): 15 employees
--   - Sales (3):      12 employees
--   - Finance (4):    10 employees
-- Average Salary Range: $52,000 - $120,000
-- ============================================================================
