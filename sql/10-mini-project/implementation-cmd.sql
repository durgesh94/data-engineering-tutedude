/*
╔════════════════════════════════════════════════════════════════════════════╗
║       EMPLOYEE PERFORMANCE & PAYROLL ANALYTICS - IMPLEMENTATION             ║
║                         Mini Project SQL File                              ║
╚════════════════════════════════════════════════════════════════════════════╝

Author: Durgesh Tambe
Date: April 28, 2026
Database: emp_performance_payroll_db
Version: 1.0

PROJECT DESCRIPTION:
This mini-project implements an Employee Performance & Payroll Analytics System
that integrates HR, performance tracking, and payroll management. The system
allows organizations to analyze employee performance, calculate salaries based
on ratings, and generate payroll reports.

CONCEPTS COVERED:
  ✅ CREATE: Table design with constraints and relationships
  ✅ INSERT: Bulk data insertion with realistic values
  ✅ JOIN: Multi-table queries (INNER, LEFT, complex joins)
  ✅ GROUP BY: Aggregation and analytical queries
  ✅ CASE: Conditional classification logic
  ✅ SUBQUERIES: Nested queries for complex analysis
  ✅ INDEXES: Performance optimization
  ✅ VIEWS: Simplified data abstraction layers
  ✅ CTEs: Common Table Expressions for readability
  ✅ Stored Procedures: Reusable routines with parameters

TABLE OF CONTENTS:
═══════════════════════════════════════════════════════════════════════════════
1.  Database Creation and Selection
2.  Table Creation (Department, Employee, Performance)
3.  Data Insertion (Sample Data)
4.  Index Creation for Performance
5.  JOIN Queries
6.  GROUP BY & Aggregation Queries
7.  CASE Statement Queries
8.  Subquery Examples
9.  CTE (Common Table Expression) Examples
10. View Creation
11. Stored Procedure Creation
12. Verification & Testing Queries
═══════════════════════════════════════════════════════════════════════════════
*/

-- ╔════════════════════════════════════════════════════════════════════════════╗
-- ║ 1. DATABASE CREATION AND SELECTION                                         ║
-- ╚════════════════════════════════════════════════════════════════════════════╝

CREATE DATABASE IF NOT EXISTS emp_performance_payroll_db;
USE emp_performance_payroll_db;


-- ╔════════════════════════════════════════════════════════════════════════════╗
-- ║ 2. TABLE CREATION WITH CONSTRAINTS AND RELATIONSHIPS                       ║
-- ╚════════════════════════════════════════════════════════════════════════════╝

-- 2.1 Department Table: Master table for all departments
CREATE TABLE IF NOT EXISTS department (
    departmentId INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL UNIQUE,
    location VARCHAR(100),
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) COMMENT='Master table storing department information';

-- 2.2 Employee Table: Employee information with department assignment
CREATE TABLE IF NOT EXISTS employee (
    employeeId INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    base_salary DECIMAL(10, 2) NOT NULL,
    hire_date DATE NOT NULL,
    departmentId INT NOT NULL,
    status VARCHAR(20) DEFAULT 'Active',
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_employee_dept FOREIGN KEY (departmentId) 
        REFERENCES department(departmentId) 
        ON DELETE RESTRICT 
        ON UPDATE CASCADE,
    INDEX idx_department (departmentId),
    INDEX idx_email (email),
    INDEX idx_salary (base_salary)
) COMMENT='Stores employee information and base salary';

-- 2.3 Performance Table: Employee performance ratings and metrics
CREATE TABLE IF NOT EXISTS performance (
    performanceId INT PRIMARY KEY AUTO_INCREMENT,
    employeeId INT NOT NULL,
    review_date DATE NOT NULL,
    review_year INT GENERATED ALWAYS AS (YEAR(review_date)) STORED,
    rating INT NOT NULL,
    bonus_percentage DECIMAL(5, 2) DEFAULT 0,
    review_notes VARCHAR(500),
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_performance_emp FOREIGN KEY (employeeId) 
        REFERENCES employee(employeeId) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    CONSTRAINT chk_rating CHECK (rating BETWEEN 1 AND 5),
    CONSTRAINT chk_bonus CHECK (bonus_percentage >= 0 AND bonus_percentage <= 100),
    INDEX idx_employee_review (employeeId, review_date),
    INDEX idx_performance_rating (rating),
    INDEX idx_performance_date (review_date),
    UNIQUE KEY unique_annual_review (employeeId, review_year)
) COMMENT='Stores employee performance ratings and bonus details';


-- ╔════════════════════════════════════════════════════════════════════════════╗
-- ║ 3. DATA INSERTION - SAMPLE DATA FOR ANALYSIS                               ║
-- ╚════════════════════════════════════════════════════════════════════════════╝

-- 3.0 Create Functions to Generate Unique Email Addresses

-- 3.0.1 Basic Email Generation (without uniqueness check)
DELIMITER $$

DROP FUNCTION IF EXISTS generate_email $$

CREATE FUNCTION generate_email(
    p_first_name VARCHAR(50),
    p_last_name VARCHAR(50)
)
RETURNS VARCHAR(100)
DETERMINISTIC
READS SQL DATA
BEGIN
    RETURN LOWER(CONCAT(p_first_name, '.', p_last_name, '@company.com'));
END $$

DELIMITER ;

-- 3.0.2 Generate Unique Email (checks for existing emails and appends counter if needed)
DELIMITER $$

DROP FUNCTION IF EXISTS generate_unique_email $$

CREATE FUNCTION generate_unique_email(
    p_first_name VARCHAR(50),
    p_last_name VARCHAR(50)
)
RETURNS VARCHAR(100)
NOT DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_base_email VARCHAR(100);
    DECLARE v_new_email VARCHAR(100);
    DECLARE v_counter INT DEFAULT 0;
    DECLARE v_email_exists INT;
    
    -- Generate base email
    SET v_base_email = LOWER(CONCAT(p_first_name, '.', p_last_name, '@company.com'));
    SET v_new_email = v_base_email;
    
    -- Check if email exists and add counter suffix if needed
    LOOP
        SELECT COUNT(*) INTO v_email_exists
        FROM employee
        WHERE email = v_new_email;
        
        IF v_email_exists = 0 THEN
            -- Email doesn't exist, use it
            RETURN v_new_email;
        ELSE
            -- Email exists, append counter and try again
            SET v_counter = v_counter + 1;
            SET v_new_email = LOWER(CONCAT(p_first_name, '.', p_last_name, v_counter, '@company.com'));
        END IF;
        
        -- Safety check to prevent infinite loop (max 100 collision attempts)
        IF v_counter > 100 THEN
            RETURN CONCAT('error_', UUID()); -- Fallback with unique UUID
        END IF;
    END LOOP;
END $$

DELIMITER ;

-- Example usage:
-- SELECT generate_email('John', 'Smith');                    -- Returns: john.smith@company.com
-- SELECT generate_unique_email('John', 'Smith');             -- Returns: john.smith@company.com (if unique)
-- SELECT generate_unique_email('John', 'Smith');             -- Returns: john.smith1@company.com (if collision exists)

-- 3.1 Insert Department Data
INSERT INTO department (name, location) VALUES
('Sales', 'New York'),
('Engineering', 'San Francisco'),
('HR', 'Chicago'),
('Finance', 'Boston'),
('Operations', 'Dallas');

-- 3.2 Insert Employee Data (Using generate_unique_email() function for uniqueness guarantee)
INSERT INTO employee (first_name, last_name, email, base_salary, hire_date, departmentId, status) VALUES
('John', 'Smith', generate_unique_email('John', 'Smith'), 75000.00, '2022-01-15', 2, 'Active'),
('Sarah', 'Johnson', generate_unique_email('Sarah', 'Johnson'), 65000.00, '2021-06-20', 1, 'Active'),
('Michael', 'Williams', generate_unique_email('Michael', 'Williams'), 85000.00, '2020-03-10', 2, 'Active'),
('Emily', 'Brown', generate_unique_email('Emily', 'Brown'), 55000.00, '2023-02-01', 3, 'Active'),
('Robert', 'Davis', generate_unique_email('Robert', 'Davis'), 95000.00, '2019-11-05', 1, 'Active'),
('Jennifer', 'Miller', generate_unique_email('Jennifer', 'Miller'), 70000.00, '2022-05-12', 4, 'Active'),
('David', 'Wilson', generate_unique_email('David', 'Wilson'), 60000.00, '2023-01-20', 5, 'Active');

-- 3.3 Insert Performance Data
INSERT INTO performance (employeeId, review_date, rating, bonus_percentage, review_notes) VALUES
(1, '2025-12-31', 5, 15.00, 'Excellent developer, great team player'),
(2, '2025-12-31', 4, 10.00, 'Good sales performance, needs improvement in client relations'),
(3, '2025-12-31', 5, 15.00, 'Outstanding technical skills and leadership'),
(4, '2025-12-31', 3, 5.00, 'Average performer, room for improvement'),
(5, '2025-12-31', 4, 12.00, 'Consistent high performer in sales'),
(6, '2025-12-31', 3, 5.00, 'Meets expectations'),
(7, '2025-12-31', 2, 2.00, 'Needs improvement in delivery timelines'),
(1, '2026-03-15', 4, 12.00, 'Good progress, maintaining excellence'),
(2, '2026-03-15', 3, 8.00, 'Struggling with new product line'),
(3, '2026-03-15', 5, 18.00, 'Promoted to team lead, excellent mentor'),
(5, '2026-03-15', 5, 15.00, 'Best salesman this quarter');


-- ╔════════════════════════════════════════════════════════════════════════════╗
-- ║ 4. INDEX CREATION FOR PERFORMANCE OPTIMIZATION                             ║
-- ╚════════════════════════════════════════════════════════════════════════════╝

CREATE INDEX idx_employee_salary_dept ON employee(departmentId, base_salary);
CREATE INDEX idx_performance_rating_date ON performance(rating, review_date);
CREATE INDEX idx_performance_date_desc ON performance(review_date DESC);


-- ╔════════════════════════════════════════════════════════════════════════════╗
-- ║ 5. JOIN QUERIES - COMBINING DATA FROM MULTIPLE TABLES                      ║
-- ╚════════════════════════════════════════════════════════════════════════════╝

-- 5.1 Employee with Department and Latest Performance
SELECT
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    d.name AS department,
    d.location,
    e.base_salary,
    e.hire_date,
    p.review_date,
    p.rating,
    p.bonus_percentage
FROM employee e
INNER JOIN department d ON e.departmentId = d.departmentId
LEFT JOIN performance p ON e.employeeId = p.employeeId
    AND p.review_date = (
        SELECT MAX(review_date) 
        FROM performance 
        WHERE employeeId = e.employeeId
    )
ORDER BY d.name, e.employeeId;

-- 5.2 All Performance Records with Employee Details
SELECT
    p.performanceId,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    d.name AS department,
    p.review_date,
    p.rating,
    p.bonus_percentage,
    p.review_notes
FROM performance p
INNER JOIN employee e ON p.employeeId = e.employeeId
INNER JOIN department d ON e.departmentId = d.departmentId
ORDER BY p.review_date DESC, p.rating DESC;


-- ╔════════════════════════════════════════════════════════════════════════════╗
-- ║ 6. GROUP BY & AGGREGATION QUERIES                                          ║
-- ╚════════════════════════════════════════════════════════════════════════════╝

-- 6.1 Department Statistics
SELECT
    d.departmentId,
    d.name AS department,
    d.location,
    COUNT(e.employeeId) AS total_employees,
    AVG(e.base_salary) AS avg_salary,
    MIN(e.base_salary) AS min_salary,
    MAX(e.base_salary) AS max_salary,
    SUM(e.base_salary) AS total_payroll,
    ROUND(AVG(COALESCE(p.rating, 0)), 2) AS avg_performance_rating
FROM department d
LEFT JOIN employee e ON d.departmentId = e.departmentId
LEFT JOIN performance p ON e.employeeId = p.employeeId
    AND p.review_date = (
        SELECT MAX(review_date) 
        FROM performance 
        WHERE employeeId = e.employeeId
    )
GROUP BY d.departmentId, d.name, d.location
ORDER BY total_payroll DESC;

-- 6.2 Performance Distribution by Rating
SELECT
    p.rating,
    COUNT(DISTINCT p.employeeId) AS employee_count,
    ROUND(AVG(e.base_salary), 2) AS avg_salary,
    ROUND(AVG(p.bonus_percentage), 2) AS avg_bonus_percentage,
    COUNT(*) AS total_reviews
FROM performance p
INNER JOIN employee e ON p.employeeId = e.employeeId
GROUP BY p.rating
ORDER BY p.rating DESC;


-- ╔════════════════════════════════════════════════════════════════════════════╗
-- ║ 7. CASE STATEMENT QUERIES - CONDITIONAL CLASSIFICATION                     ║
-- ╚════════════════════════════════════════════════════════════════════════════╝

-- 7.1 Performance Band Classification
SELECT
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    d.name AS department,
    e.base_salary,
    COALESCE(p.rating, 0) AS rating,
    CASE
        WHEN p.rating = 5 THEN 'Excellent'
        WHEN p.rating = 4 THEN 'Good'
        WHEN p.rating = 3 THEN 'Average'
        WHEN p.rating = 2 THEN 'Below Average'
        WHEN p.rating = 1 THEN 'Needs Improvement'
        ELSE 'Not Rated'
    END AS performance_band,
    CASE
        WHEN p.rating >= 4 THEN 'Eligible for Promotion'
        WHEN p.rating = 3 THEN 'Monitoring'
        WHEN p.rating IS NULL THEN 'Pending Review'
        ELSE 'Performance Improvement Plan (PIP)'
    END AS action_required,
    COALESCE(p.bonus_percentage, 0) AS bonus_percentage
FROM employee e
INNER JOIN department d ON e.departmentId = d.departmentId
LEFT JOIN performance p ON e.employeeId = p.employeeId
    AND p.review_date = (
        SELECT MAX(review_date) 
        FROM performance 
        WHERE employeeId = e.employeeId
    )
ORDER BY p.rating DESC, e.base_salary DESC;

-- 7.2 Salary Band Classification
SELECT
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    d.name AS department,
    e.base_salary,
    CASE
        WHEN e.base_salary < 60000 THEN 'Entry Level'
        WHEN e.base_salary BETWEEN 60000 AND 80000 THEN 'Mid Level'
        WHEN e.base_salary BETWEEN 80000 AND 100000 THEN 'Senior Level'
        ELSE 'Executive Level'
    END AS salary_band,
    CASE
        WHEN p.rating >= 4 AND e.base_salary < 100000 THEN 'Recommend Raise'
        WHEN p.rating <= 2 THEN 'Review Compensation'
        ELSE 'Current Salary Appropriate'
    END AS compensation_recommendation
FROM employee e
INNER JOIN department d ON e.departmentId = d.departmentId
LEFT JOIN performance p ON e.employeeId = p.employeeId
    AND p.review_date = (
        SELECT MAX(review_date) 
        FROM performance 
        WHERE employeeId = e.employeeId
    )
ORDER BY e.base_salary DESC;


-- ╔════════════════════════════════════════════════════════════════════════════╗
-- ║ 8. SUBQUERY EXAMPLES - NESTED QUERIES FOR COMPLEX ANALYSIS                 ║
-- ╚════════════════════════════════════════════════════════════════════════════╝

-- 8.1 Employees Earning More Than Department Average
SELECT
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    d.name AS department,
    e.base_salary,
    (SELECT ROUND(AVG(base_salary), 2) FROM employee WHERE departmentId = d.departmentId) AS dept_avg_salary,
    ROUND(e.base_salary - (SELECT AVG(base_salary) FROM employee WHERE departmentId = d.departmentId), 2) AS salary_diff
FROM employee e
INNER JOIN department d ON e.departmentId = d.departmentId
WHERE e.base_salary > (
    SELECT AVG(base_salary) 
    FROM employee 
    WHERE departmentId = d.departmentId
)
ORDER BY d.departmentId, e.base_salary DESC;

-- 8.2 Employees with Above-Average Performance
SELECT
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    d.name AS department,
    p.rating,
    (SELECT ROUND(AVG(rating), 2) FROM performance) AS overall_avg_rating,
    p.bonus_percentage
FROM employee e
INNER JOIN department d ON e.departmentId = d.departmentId
LEFT JOIN performance p ON e.employeeId = p.employeeId
WHERE p.employeeId IN (
    SELECT DISTINCT employeeId 
    FROM performance 
    WHERE rating > (SELECT AVG(rating) FROM performance)
)
ORDER BY p.rating DESC;


-- ╔════════════════════════════════════════════════════════════════════════════╗
-- ║ 9. CTE (COMMON TABLE EXPRESSION) EXAMPLES                                  ║
-- ╚════════════════════════════════════════════════════════════════════════════╝

-- 9.1 Top Performers with Bonus Calculation
WITH latest_performance AS (
    SELECT
        employeeId,
        rating,
        bonus_percentage,
        review_date,
        ROW_NUMBER() OVER (PARTITION BY employeeId ORDER BY review_date DESC) AS rn
    FROM performance
),
top_performers AS (
    SELECT
        e.employeeId,
        CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
        d.name AS department,
        e.base_salary,
        lp.rating,
        lp.bonus_percentage,
        ROUND(e.base_salary * lp.bonus_percentage / 100, 2) AS bonus_amount,
        ROUND(e.base_salary + (e.base_salary * lp.bonus_percentage / 100), 2) AS total_payable
    FROM employee e
    INNER JOIN department d ON e.departmentId = d.departmentId
    INNER JOIN latest_performance lp ON e.employeeId = lp.employeeId AND lp.rn = 1
    WHERE lp.rating >= 4
)
SELECT * FROM top_performers
ORDER BY total_payable DESC;

-- 9.2 Department Payroll Summary with CTE
WITH dept_payroll AS (
    SELECT
        d.departmentId,
        d.name AS department,
        e.employeeId,
        CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
        e.base_salary,
        COALESCE(p.bonus_percentage, 0) AS bonus_percentage,
        ROUND(e.base_salary * COALESCE(p.bonus_percentage, 0) / 100, 2) AS bonus_amount,
        ROUND(e.base_salary + (e.base_salary * COALESCE(p.bonus_percentage, 0) / 100), 2) AS total_compensation
    FROM department d
    LEFT JOIN employee e ON d.departmentId = e.departmentId
    LEFT JOIN performance p ON e.employeeId = p.employeeId
        AND p.review_date = (
            SELECT MAX(review_date) 
            FROM performance 
            WHERE employeeId = e.employeeId
        )
)
SELECT
    department,
    COUNT(DISTINCT employeeId) AS total_employees,
    SUM(base_salary) AS total_base_salary,
    SUM(bonus_amount) AS total_bonus,
    SUM(total_compensation) AS total_compensation,
    ROUND(AVG(total_compensation), 2) AS avg_compensation
FROM dept_payroll
GROUP BY departmentId, department
ORDER BY total_compensation DESC;


-- ╔════════════════════════════════════════════════════════════════════════════╗
-- ║ 10. VIEW CREATION - SIMPLIFIED DATA ABSTRACTION LAYERS                     ║
-- ╚════════════════════════════════════════════════════════════════════════════╝

-- 10.1 View: Employee Payroll Summary
CREATE OR REPLACE VIEW v_employee_payroll_summary AS
SELECT
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    d.name AS department,
    d.location,
    e.base_salary,
    e.hire_date,
    YEAR(CURDATE()) - YEAR(e.hire_date) AS years_employed,
    COALESCE(p.review_date, 'Not Reviewed') AS last_review_date,
    COALESCE(p.rating, 0) AS performance_rating,
    COALESCE(p.bonus_percentage, 0) AS bonus_percentage,
    ROUND(e.base_salary * COALESCE(p.bonus_percentage, 0) / 100, 2) AS bonus_amount,
    ROUND(e.base_salary + (e.base_salary * COALESCE(p.bonus_percentage, 0) / 100), 2) AS total_compensation
FROM employee e
INNER JOIN department d ON e.departmentId = d.departmentId
LEFT JOIN performance p ON e.employeeId = p.employeeId
    AND p.review_date = (
        SELECT MAX(review_date) 
        FROM performance 
        WHERE employeeId = e.employeeId
    );

-- 10.2 View: Department Performance Analytics
CREATE OR REPLACE VIEW v_department_analytics AS
SELECT
    d.departmentId,
    d.name AS department,
    d.location,
    COUNT(e.employeeId) AS total_employees,
    SUM(e.base_salary) AS total_payroll,
    ROUND(AVG(e.base_salary), 2) AS avg_salary,
    MIN(e.base_salary) AS min_salary,
    MAX(e.base_salary) AS max_salary,
    ROUND(AVG(COALESCE(p.rating, 0)), 2) AS avg_performance_rating,
    SUM(ROUND(e.base_salary * COALESCE(p.bonus_percentage, 0) / 100, 2)) AS total_bonus_payout,
    ROUND(SUM(e.base_salary + (e.base_salary * COALESCE(p.bonus_percentage, 0) / 100)), 2) AS total_compensation
FROM department d
LEFT JOIN employee e ON d.departmentId = e.departmentId
LEFT JOIN performance p ON e.employeeId = p.employeeId
    AND p.review_date = (
        SELECT MAX(review_date) 
        FROM performance 
        WHERE employeeId = e.employeeId
    )
GROUP BY d.departmentId, d.name, d.location;

-- 10.3 View: Performance Review Report
CREATE OR REPLACE VIEW v_performance_review_report AS
SELECT
    p.performanceId,
    e.employeeId,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    d.name AS department,
    p.review_date,
    p.rating,
    CASE
        WHEN p.rating = 5 THEN 'Excellent'
        WHEN p.rating = 4 THEN 'Good'
        WHEN p.rating = 3 THEN 'Average'
        WHEN p.rating = 2 THEN 'Below Average'
        WHEN p.rating = 1 THEN 'Needs Improvement'
    END AS performance_band,
    p.bonus_percentage,
    p.review_notes
FROM performance p
INNER JOIN employee e ON p.employeeId = e.employeeId
INNER JOIN department d ON e.departmentId = d.departmentId;


-- ╔════════════════════════════════════════════════════════════════════════════╗
-- ║ 11. STORED PROCEDURE CREATION - REUSABLE ROUTINES                          ║
-- ╚════════════════════════════════════════════════════════════════════════════╝

-- 11.1 Procedure: Calculate Payroll for an Employee
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_calculate_payroll $$

CREATE PROCEDURE sp_calculate_payroll(
    IN p_employee_id INT,
    OUT p_employee_name VARCHAR(120),
    OUT p_base_salary DECIMAL(10, 2),
    OUT p_bonus_percentage DECIMAL(5, 2),
    OUT p_bonus_amount DECIMAL(10, 2),
    OUT p_total_payable DECIMAL(10, 2)
)
BEGIN
    DECLARE v_bonus_percentage DECIMAL(5, 2) DEFAULT 0;
    
    SELECT CONCAT(first_name, ' ', last_name)
    INTO p_employee_name
    FROM employee
    WHERE employeeId = p_employee_id;
    
    SELECT base_salary INTO p_base_salary
    FROM employee
    WHERE employeeId = p_employee_id;
    
    SELECT COALESCE(bonus_percentage, 0) INTO v_bonus_percentage
    FROM performance
    WHERE employeeId = p_employee_id
    ORDER BY review_date DESC
    LIMIT 1;
    
    SET p_bonus_percentage = v_bonus_percentage;
    SET p_bonus_amount = ROUND(p_base_salary * v_bonus_percentage / 100, 2);
    SET p_total_payable = p_base_salary + p_bonus_amount;
END $$

DELIMITER ;

-- 11.2 Procedure: Get Employee Performance Summary
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_get_employee_summary $$

CREATE PROCEDURE sp_get_employee_summary(IN p_employee_id INT)
BEGIN
    SELECT
        e.employeeId,
        CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
        d.name AS department,
        e.base_salary,
        e.hire_date,
        e.status,
        COUNT(p.performanceId) AS total_reviews,
        ROUND(AVG(p.rating), 2) AS avg_rating,
        MAX(p.review_date) AS latest_review_date
    FROM employee e
    LEFT JOIN department d ON e.departmentId = d.departmentId
    LEFT JOIN performance p ON e.employeeId = p.employeeId
    WHERE e.employeeId = p_employee_id
    GROUP BY e.employeeId, e.first_name, e.last_name, d.name, e.base_salary, e.hire_date, e.status;
END $$

DELIMITER ;

-- 11.3 Procedure: Get Department Payroll Report
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_get_department_report $$

CREATE PROCEDURE sp_get_department_report(IN p_department_id INT)
BEGIN
    SELECT
        d.name AS department,
        COUNT(e.employeeId) AS total_employees,
        ROUND(AVG(e.base_salary), 2) AS avg_salary,
        SUM(e.base_salary) AS total_payroll,
        ROUND(AVG(COALESCE(p.rating, 0)), 2) AS avg_rating,
        SUM(ROUND(e.base_salary * COALESCE(p.bonus_percentage, 0) / 100, 2)) AS total_bonus
    FROM department d
    LEFT JOIN employee e ON d.departmentId = e.departmentId
    LEFT JOIN performance p ON e.employeeId = p.employeeId
        AND p.review_date = (
            SELECT MAX(review_date) 
            FROM performance 
            WHERE employeeId = e.employeeId
        )
    WHERE d.departmentId = p_department_id
    GROUP BY d.departmentId, d.name;
END $$

DELIMITER ;


-- ╔════════════════════════════════════════════════════════════════════════════╗
-- ║ 12. VERIFICATION & TESTING QUERIES                                         ║
-- ╚════════════════════════════════════════════════════════════════════════════╝

-- 12.1 Verify Data Insertion
SELECT COUNT(*) AS total_departments FROM department;
SELECT COUNT(*) AS total_employees FROM employee;
SELECT COUNT(*) AS total_reviews FROM performance;

-- 12.2 Test Views
SELECT 'Employee Payroll Summary:' AS view_name;
SELECT * FROM v_employee_payroll_summary LIMIT 5;

SELECT 'Department Analytics:' AS view_name;
SELECT * FROM v_department_analytics;

SELECT 'Performance Review Report:' AS view_name;
SELECT * FROM v_performance_review_report LIMIT 5;

-- 12.3 Test Stored Procedures
CALL sp_calculate_payroll(1, @name, @base, @bonus_pct, @bonus, @total);
SELECT @name AS employee_name, @base AS base_salary, @bonus_pct AS bonus_percentage, @bonus AS bonus_amount, @total AS total_payable;

CALL sp_get_employee_summary(1);

CALL sp_get_department_report(2);

-- 12.4 Show Indexes
SHOW INDEX FROM employee;
SHOW INDEX FROM performance;

-- ═══════════════════════════════════════════════════════════════════════════════
-- END OF MINI PROJECT IMPLEMENTATION
-- ═══════════════════════════════════════════════════════════════════════════════

/* 
SUGGESTIONS FOR EXTENDING THIS PROJECT:

1. Add more analytical queries using window functions and CTEs
2. Create triggers to automatically update employee status or bonus_percentage
3. Add schedule events for automated payroll calculations
4. Create additional views for HR analytics and reporting
5. Implement role-based access control and permissions
6. Add audit tables to track changes to sensitive data
7. Create data validation and stored procedures for data integrity
8. Build executive dashboard queries for management reporting
9. Add temporal tables for tracking historical salary changes
10. Implement data archival procedures for old performance records
*/
