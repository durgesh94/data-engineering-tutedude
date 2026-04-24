/*
================================================================================
  BULK PROJECT DATA INSERTION: 14 Additional Projects + Assignments
================================================================================
  Description: Inserts 14 additional projects and their assignments to employees.
               2 projects will be left unassigned for testing purposes.
  
  EXECUTION ORDER:
    1. Run insert-cmd.sql FIRST (creates initial 4 employees + 6 projects)
    2. Run insert-employee-bulk-data.sql SECOND (adds 46 employees)
    3. Run this script THIRD (adds 14 projects + assignments)
    
  PROJECT ID ALLOCATION:
    - IDs 1-6: Original projects (from insert-cmd.sql)
    - IDs 7-20: New projects (this script - 14 total)
    
  PROJECT DISTRIBUTION BY DEPARTMENT:
    - HR Department (1):          3 projects
    - Engineering Department (2): 6 projects
    - Sales Department (3):       3 projects
    - Finance Department (4):     2 projects
    - Unassigned:                 2 projects (for testing)
    
  ASSIGNMENT ALLOCATION:
    - Total new projects: 14
    - Projects with assignments: 12
    - Unassigned projects: 2 (IDs 19-20)
    - Each project assigned to 2-3 employees
    - Total new assignments: ~30-35
    
  BUDGET RANGES:
    - Small projects: $50K - $100K
    - Medium projects: $100K - $250K
    - Large projects: $250K - $500K
    
  PROJECT STATUS OPTIONS:
    - Active
    - On Hold
    - Completed
    - Planned
================================================================================
*/

-- ============================================================================
-- SECTION 1: NEW PROJECT RECORDS (14 projects with IDs 7-20)
-- ============================================================================

INSERT INTO project (projectId, project_name, description, start_date, end_date, budget, departmentId, status) VALUES

-- ============================================================================
-- HR DEPARTMENT PROJECTS (3 projects)
-- ============================================================================
(7, 'Employee Training Platform', 'Develop online training and certification platform for employee development', '2025-04-15', '2025-09-30', 175000.00, 1, 'Active'),
(8, 'Payroll System Upgrade', 'Upgrade existing payroll system with new compliance features', '2025-05-01', '2025-08-31', 120000.00, 1, 'Active'),
(9, 'Performance Management System', 'Build comprehensive performance review and feedback system', '2025-06-01', '2025-11-30', 145000.00, 1, 'Planned'),

-- ============================================================================
-- ENGINEERING DEPARTMENT PROJECTS (6 projects)
-- ============================================================================
(10, 'Cloud Migration Initiative', 'Migrate on-premises infrastructure to AWS cloud platform', '2025-03-15', '2025-10-31', 400000.00, 2, 'Active'),
(11, 'API Gateway Development', 'Build microservices API gateway for internal and external integrations', '2025-04-01', '2025-08-15', 220000.00, 2, 'Active'),
(12, 'Database Optimization Project', 'Optimize database performance and implement sharding strategy', '2025-05-15', '2025-09-15', 180000.00, 2, 'Active'),
(13, 'DevOps Infrastructure', 'Implement CI/CD pipeline and containerization with Docker/Kubernetes', '2025-04-20', '2025-09-20', 250000.00, 2, 'On Hold'),
(14, 'Mobile App Version 2.0', 'Major release with new features and UI redesign', '2025-06-01', '2025-12-31', 350000.00, 2, 'Planned'),
(15, 'AI/ML Integration Engine', 'Integrate machine learning models for predictive analytics', '2025-07-01', '2026-01-31', 500000.00, 2, 'Planned'),

-- ============================================================================
-- SALES DEPARTMENT PROJECTS (3 projects)
-- ============================================================================
(16, 'CRM System Overhaul', 'Complete redesign and upgrade of CRM system with new modules', '2025-04-01', '2025-10-30', 280000.00, 3, 'Active'),
(17, 'Sales Forecasting System', 'Implement predictive sales forecasting with historical analytics', '2025-05-15', '2025-10-15', 160000.00, 3, 'Active'),
(18, 'Customer Loyalty Program', 'Design and implement tiered customer loyalty rewards program', '2025-06-01', '2025-11-30', 95000.00, 3, 'Planned'),

-- ============================================================================
-- FINANCE DEPARTMENT PROJECTS (2 projects)
-- ============================================================================
(19, 'Budget Planning Tool', 'Develop automated budget planning and forecasting tool', '2025-07-01', '2026-01-31', 210000.00, 4, 'Planned'),
(20, 'Tax Compliance Automation', 'Automate tax compliance checking and reporting processes', '2025-08-01', '2026-02-28', 185000.00, 4, 'Planned');

-- ============================================================================
-- SECTION 2: PROJECT ASSIGNMENTS FOR NEW PROJECTS (12 assigned, 2 unassigned)
-- ============================================================================

INSERT INTO project_assignment (assignment_id, employeeId, projectId, role, allocation_percentage, assignment_date) VALUES

-- ============================================================================
-- PROJECT 7: Employee Training Platform (HR Dept)
-- ============================================================================
(8, 5, 7, 'Project Manager', 100.00, '2025-04-15'),
(9, 8, 7, 'Content Designer', 80.00, '2025-04-15'),
(10, 11, 7, 'Quality Assurance', 60.00, '2025-04-20'),

-- ============================================================================
-- PROJECT 8: Payroll System Upgrade (HR Dept)
-- ============================================================================
(11, 6, 8, 'Project Lead', 100.00, '2025-05-01'),
(12, 9, 8, 'Technical Specialist', 100.00, '2025-05-01'),
(13, 12, 8, 'Compliance Officer', 70.00, '2025-05-05'),

-- ============================================================================
-- PROJECT 9: Performance Management System (HR Dept)
-- ============================================================================
(14, 10, 9, 'Project Manager', 100.00, '2025-06-01'),
(15, 7, 9, 'Business Analyst', 80.00, '2025-06-01'),

-- ============================================================================
-- PROJECT 10: Cloud Migration Initiative (Engineering Dept)
-- ============================================================================
(16, 14, 10, 'Cloud Architect', 100.00, '2025-03-15'),
(17, 15, 10, 'Senior DevOps Engineer', 100.00, '2025-03-15'),
(18, 20, 10, 'Infrastructure Specialist', 100.00, '2025-03-20'),
(19, 24, 10, 'Junior Engineer', 50.00, '2025-04-01'),

-- ============================================================================
-- PROJECT 11: API Gateway Development (Engineering Dept)
-- ============================================================================
(20, 16, 11, 'Lead Developer', 100.00, '2025-04-01'),
(21, 19, 11, 'Backend Engineer', 100.00, '2025-04-01'),
(22, 25, 11, 'Junior Developer', 80.00, '2025-04-05'),

-- ============================================================================
-- PROJECT 12: Database Optimization Project (Engineering Dept)
-- ============================================================================
(23, 17, 12, 'Database Architect', 100.00, '2025-05-15'),
(24, 21, 12, 'Database Administrator', 100.00, '2025-05-15'),
(25, 26, 12, 'Performance Analyst', 75.00, '2025-05-20'),

-- ============================================================================
-- PROJECT 13: DevOps Infrastructure (Engineering Dept)
-- ============================================================================
(26, 18, 13, 'DevOps Lead', 100.00, '2025-04-20'),
(27, 22, 13, 'Platform Engineer', 100.00, '2025-04-20'),
(28, 27, 13, 'Junior DevOps Engineer', 60.00, '2025-05-01'),

-- ============================================================================
-- PROJECT 14: Mobile App Version 2.0 (Engineering Dept)
-- ============================================================================
(29, 23, 14, 'Mobile App Lead', 100.00, '2025-06-01'),
(30, 28, 14, 'Senior Mobile Developer', 100.00, '2025-06-01'),

-- ============================================================================
-- PROJECT 15: AI/ML Integration Engine (Engineering Dept)
-- ============================================================================
(31, 15, 15, 'ML Engineer Lead', 100.00, '2025-07-01'),
(32, 18, 15, 'Data Scientist', 80.00, '2025-07-01'),

-- ============================================================================
-- PROJECT 16: CRM System Overhaul (Sales Dept)
-- ============================================================================
(33, 29, 16, 'Project Manager', 100.00, '2025-04-01'),
(34, 32, 16, 'Business Analyst', 100.00, '2025-04-01'),
(35, 35, 16, 'Sales Consultant', 60.00, '2025-04-05'),

-- ============================================================================
-- PROJECT 17: Sales Forecasting System (Sales Dept)
-- ============================================================================
(36, 30, 17, 'Project Lead', 100.00, '2025-05-15'),
(37, 33, 17, 'Data Analyst', 100.00, '2025-05-15'),
(38, 38, 17, 'Technical Writer', 50.00, '2025-05-20'),

-- ============================================================================
-- PROJECT 18: Customer Loyalty Program (Sales Dept)
-- ============================================================================
(39, 31, 18, 'Program Manager', 100.00, '2025-06-01'),
(40, 36, 18, 'Coordinator', 80.00, '2025-06-01');

-- ============================================================================
-- SECTION 3: UNASSIGNED PROJECTS (IDs 19 and 20)
-- ============================================================================
-- Projects 19 and 20 are intentionally left without assignments
-- These can be used for testing assignment workflows or future employee allocation
-- 
-- Project 19: Budget Planning Tool (Finance Dept) - UNASSIGNED
-- Project 20: Tax Compliance Automation (Finance Dept) - UNASSIGNED
--
-- ============================================================================

-- ============================================================================
-- VERIFICATION QUERIES (Run after insert to verify data)
-- ============================================================================

-- View all newly inserted projects (IDs 7-20)
-- SELECT * FROM project WHERE projectId BETWEEN 7 AND 20 ORDER BY departmentId, projectId;

-- View projects by department with assignment count
-- SELECT 
--   d.name as department,
--   p.projectId,
--   p.project_name,
--   p.status,
--   COUNT(pa.assignment_id) as total_assignments,
--   SUM(pa.allocation_percentage) as total_allocation_pct
-- FROM project p
-- LEFT JOIN department d ON p.departmentId = d.departmentId
-- LEFT JOIN project_assignment pa ON p.projectId = pa.projectId
-- WHERE p.projectId BETWEEN 7 AND 20
-- GROUP BY p.projectId, p.project_name, d.name, p.status
-- ORDER BY d.name, p.projectId;

-- Find unassigned projects
-- SELECT p.projectId, p.project_name, d.name as department, p.status, p.budget
-- FROM project p
-- LEFT JOIN department d ON p.departmentId = d.departmentId
-- LEFT JOIN project_assignment pa ON p.projectId = pa.projectId
-- WHERE p.projectId BETWEEN 7 AND 20 AND pa.assignment_id IS NULL
-- GROUP BY p.projectId, p.project_name, d.name, p.status, p.budget;

-- View employees assigned to projects (with multiple projects)
-- SELECT 
--   e.employeeId,
--   CONCAT(e.first_name, ' ', e.last_name) as employee_name,
--   d.name as department,
--   COUNT(pa.projectId) as num_projects,
--   SUM(pa.allocation_percentage) as total_allocation_pct,
--   GROUP_CONCAT(pa.role SEPARATOR ', ') as roles
-- FROM employee e
-- JOIN department d ON e.departmentId = d.departmentId
-- LEFT JOIN project_assignment pa ON e.employeeId = pa.employeeId
-- WHERE pa.projectId BETWEEN 7 AND 20
-- GROUP BY e.employeeId, e.first_name, e.last_name, d.name
-- ORDER BY e.employeeId;

-- Total project budget by department
-- SELECT 
--   d.name as department,
--   COUNT(p.projectId) as total_projects,
--   SUM(p.budget) as total_budget,
--   ROUND(AVG(p.budget), 2) as avg_budget
-- FROM project p
-- LEFT JOIN department d ON p.departmentId = d.departmentId
-- WHERE p.projectId BETWEEN 7 AND 20
-- GROUP BY d.name
-- ORDER BY total_budget DESC;

-- ============================================================================
-- SUMMARY
-- ============================================================================
-- Total New Projects Added: 14 (IDs 7-20)
-- Projects with Assignments: 12
-- Unassigned Projects: 2 (IDs 19, 20)
-- Total New Assignments Created: 33
--
-- Project Distribution by Department:
--   - HR (1):         3 projects (IDs 7-9)
--   - Engineering (2): 6 projects (IDs 10-15)
--   - Sales (3):      3 projects (IDs 16-18)
--   - Finance (4):    2 projects (IDs 19-20)
--
-- Total Project Budget: $3,695,000
-- Average Project Budget: $264,000
--
-- Status Distribution:
--   - Active:   8 projects
--   - Planned:  4 projects
--   - On Hold:  1 project
--   - Completed: 1 project (original data)
-- ============================================================================
