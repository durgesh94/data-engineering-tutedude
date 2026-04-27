/*
╔════════════════════════════════════════════════════════════════════════════╗
║               STORED PROCEDURES - COMPREHENSIVE GUIDE                     ║
╚════════════════════════════════════════════════════════════════════════════╝

Author: Durgesh Tambe
Date: April 27, 2026
Version: 1.0
Database: MySQL 5.7+

PURPOSE:
Stored procedures are reusable blocks of SQL statements stored inside the
database. They help you centralize business logic and execute repeated tasks
through a single callable routine. They provide:
- Reusability: Write once and call many times
- Maintainability: Update logic in one place
- Performance: Reduce repeated client-side SQL parsing and network round trips
- Security: Grant access to procedure execution instead of raw tables
- Consistency: Enforce standard data operations and validations

KEY CONCEPTS:
┌──────────────────────┬───────────────────────────────────────────────────┐
│ Component            │ Description                                       │
├──────────────────────┼───────────────────────────────────────────────────┤
│ Procedure            │ Named SQL program stored in database              │
│ IN Parameter         │ Input value passed into the procedure             │
│ OUT Parameter        │ Output value returned through a variable          │
│ INOUT Parameter      │ Value used for both input and output              │
│ DELIMITER            │ Temporary statement separator during CREATE        │
│ DECLARE              │ Used for local variables, handlers, cursors       │
│ Control Flow         │ IF, CASE, LOOP, WHILE, REPEAT statements          │
│ Transaction Logic    │ START TRANSACTION, COMMIT, ROLLBACK               │
└──────────────────────┴───────────────────────────────────────────────────┘

SYNTAX:
	MySQL:
	DELIMITER $$

	CREATE PROCEDURE procedure_name([parameter_list])
	BEGIN
			-- SQL statements
	END $$

	DELIMITER ;

	CALL procedure_name([arguments]);
	DROP PROCEDURE IF EXISTS procedure_name;

SYNTAX IN MAJOR DATABASES:
═══════════════════════════════════════════════════════════════════════════════
1. MySQL / MariaDB
	DELIMITER $$
	CREATE PROCEDURE procedure_name([IN|OUT|INOUT parameter datatype])
	BEGIN
			-- SQL statements
	END $$
	DELIMITER ;
	CALL procedure_name(...);

2. PostgreSQL
	CREATE OR REPLACE PROCEDURE procedure_name(parameter_name datatype)
	LANGUAGE plpgsql
	AS $$
	BEGIN
			-- SQL statements
	END;
	$$;
	CALL procedure_name(...);

	Note: Older PostgreSQL examples often use functions with
	SELECT function_name(...); instead of procedures.

3. SQL Server
	CREATE PROCEDURE procedure_name
			@parameter_name datatype
	AS
	BEGIN
			-- SQL statements
	END;
	EXEC procedure_name ...;
	DROP PROCEDURE procedure_name;

4. Oracle
	CREATE OR REPLACE PROCEDURE procedure_name(parameter_name IN datatype)
	AS
	BEGIN
			-- SQL statements
	END;
	/
	EXEC procedure_name(...);

5. SQLite
	SQLite does not support stored procedures natively.
	Use:
	- Application code
	- Triggers
	- User-defined functions via host languages
═══════════════════════════════════════════════════════════════════════════════

PARAMETER TYPES:
	1. IN     - Accepts input only
	2. OUT    - Returns output only
	3. INOUT  - Accepts input and returns updated output

TABLE OF CONTENTS:
═══════════════════════════════════════════════════════════════════════════════
1.  Syntax in Major Databases
2.  Basic Procedure - Get All Employees
3.  Procedure with IN Parameter - Employees by Department
4.  Procedure with Multiple IN Parameters - Salary Range Filter
5.  Procedure with OUT Parameter - Employee Count by Department
6.  Procedure with INOUT Parameter - Revised Salary Calculation
7.  Insert Procedure - Add New Department
8.  Update Procedure - Change Project Status
9.  Procedure with Conditional Logic - Salary Band Classification
10. Procedure with Transaction - Assign Employee to Project
11. Best Practices and Common Mistakes
═══════════════════════════════════════════════════════════════════════════════

ASSUMPTIONS:
All examples use existing tables from '../02-manipulation/' folder:
- employee (employeeId, first_name, last_name, email, salary, departmentId)
- department (departmentId, name)
- project (projectId, project_name, description, start_date, end_date, budget, departmentId, status)
- project_assignment (assignment_id, employeeId, projectId, role, allocation_percentage, assignment_date)
*/

-- ╔════════════════════════════════════════════════════════════════════════════╗
-- ║ 1. BASIC PROCEDURE - Get All Employees                                     ║
-- ╚════════════════════════════════════════════════════════════════════════════╝

/*
CONCEPT:
	A basic stored procedure contains SQL statements without parameters.
	Use Case: Encapsulate frequently used SELECT logic in a reusable routine.
*/

DROP PROCEDURE IF EXISTS sp_get_all_employees;

DELIMITER $$

CREATE PROCEDURE sp_get_all_employees()
BEGIN
		SELECT
				e.employeeId,
				e.first_name,
				e.last_name,
				e.email,
				e.salary,
				d.name AS department_name
		FROM employee e
		LEFT JOIN department d ON e.departmentId = d.departmentId
		ORDER BY e.employeeId;
END $$

DELIMITER ;

-- Usage:
CALL sp_get_all_employees();


-- ╔════════════════════════════════════════════════════════════════════════════╗
-- ║ 2. PROCEDURE WITH IN PARAMETER - Employees by Department                   ║
-- ╚════════════════════════════════════════════════════════════════════════════╝

/*
CONCEPT:
	IN parameters allow callers to pass values into the procedure.
	Use Case: Filter results dynamically without rewriting the query.
*/

DROP PROCEDURE IF EXISTS sp_get_employees_by_department;

DELIMITER $$

CREATE PROCEDURE sp_get_employees_by_department(IN p_department_id INT)
BEGIN
		SELECT
				e.employeeId,
				CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
				e.email,
				e.salary,
				d.name AS department_name
		FROM employee e
		INNER JOIN department d ON e.departmentId = d.departmentId
		WHERE e.departmentId = p_department_id
		ORDER BY e.salary DESC;
END $$

DELIMITER ;

-- Usage:
CALL sp_get_employees_by_department(1);


-- ╔════════════════════════════════════════════════════════════════════════════╗
-- ║ 3. PROCEDURE WITH MULTIPLE IN PARAMETERS - Salary Range Filter             ║
-- ╚════════════════════════════════════════════════════════════════════════════╝

/*
CONCEPT:
	Multiple IN parameters let you build flexible procedures with more than one
	filter condition.
	Use Case: Return employees within a salary band inside a specific department.
*/

DROP PROCEDURE IF EXISTS sp_get_employees_by_salary_range;

DELIMITER $$

CREATE PROCEDURE sp_get_employees_by_salary_range(
		IN p_department_id INT,
		IN p_min_salary DECIMAL(10, 2),
		IN p_max_salary DECIMAL(10, 2)
)
BEGIN
		SELECT
				e.employeeId,
				CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
				e.salary,
				d.name AS department_name
		FROM employee e
		INNER JOIN department d ON e.departmentId = d.departmentId
		WHERE e.departmentId = p_department_id
			AND e.salary BETWEEN p_min_salary AND p_max_salary
		ORDER BY e.salary DESC;
END $$

DELIMITER ;

-- Usage:
CALL sp_get_employees_by_salary_range(1, 40000.00, 80000.00);


-- ╔════════════════════════════════════════════════════════════════════════════╗
-- ║ 4. PROCEDURE WITH OUT PARAMETER - Employee Count by Department             ║
-- ╚════════════════════════════════════════════════════════════════════════════╝

/*
CONCEPT:
	OUT parameters return a value through a user-defined variable.
	Use Case: Get aggregate results like counts, sums, or averages.
*/

DROP PROCEDURE IF EXISTS sp_get_employee_count_by_department;

DELIMITER $$

CREATE PROCEDURE sp_get_employee_count_by_department(
		IN p_department_id INT,
		OUT p_employee_count INT
)
BEGIN
		SELECT COUNT(*)
		INTO p_employee_count
		FROM employee
		WHERE departmentId = p_department_id;
END $$

DELIMITER ;

-- Usage:
CALL sp_get_employee_count_by_department(1, @employee_count);
SELECT @employee_count AS employee_count;


-- ╔════════════════════════════════════════════════════════════════════════════╗
-- ║ 5. PROCEDURE WITH INOUT PARAMETER - Revised Salary Calculation             ║
-- ╚════════════════════════════════════════════════════════════════════════════╝

/*
CONCEPT:
	INOUT parameters accept an initial value and return a modified value.
	Use Case: Perform calculations where the input itself is updated.
*/

DROP PROCEDURE IF EXISTS sp_calculate_revised_salary;

DELIMITER $$

CREATE PROCEDURE sp_calculate_revised_salary(
		IN p_increment_percent DECIMAL(5, 2),
		INOUT p_current_salary DECIMAL(10, 2)
)
BEGIN
		SET p_current_salary = p_current_salary + (p_current_salary * p_increment_percent / 100);
END $$

DELIMITER ;

-- Usage:
SET @salary = 50000.00;
CALL sp_calculate_revised_salary(10.00, @salary);
SELECT @salary AS revised_salary;


-- ╔════════════════════════════════════════════════════════════════════════════╗
-- ║ 6. INSERT PROCEDURE - Add New Department                                   ║
-- ╚════════════════════════════════════════════════════════════════════════════╝

/*
CONCEPT:
	Procedures can encapsulate INSERT logic to standardize data creation.
	Use Case: Centralize validation and insertion rules for master tables.
*/

DROP PROCEDURE IF EXISTS sp_add_department;

DELIMITER $$

CREATE PROCEDURE sp_add_department(
		IN p_department_id INT,
		IN p_department_name VARCHAR(100)
)
BEGIN
		INSERT INTO department (departmentId, name)
		VALUES (p_department_id, p_department_name);
END $$

DELIMITER ;

-- Usage:
CALL sp_add_department(5, 'Research');


-- ╔════════════════════════════════════════════════════════════════════════════╗
-- ║ 7. UPDATE PROCEDURE - Change Project Status                                ║
-- ╚════════════════════════════════════════════════════════════════════════════╝

/*
CONCEPT:
	Procedures can bundle update logic for common maintenance tasks.
	Use Case: Update a project status consistently across applications.
*/

DROP PROCEDURE IF EXISTS sp_update_project_status;

DELIMITER $$

CREATE PROCEDURE sp_update_project_status(
		IN p_project_id INT,
		IN p_new_status VARCHAR(20)
)
BEGIN
		UPDATE project
		SET status = p_new_status
		WHERE projectId = p_project_id;
END $$

DELIMITER ;

-- Usage:
CALL sp_update_project_status(101, 'Completed');


-- ╔════════════════════════════════════════════════════════════════════════════╗
-- ║ 8. PROCEDURE WITH CONDITIONAL LOGIC - Salary Band Classification           ║
-- ╚════════════════════════════════════════════════════════════════════════════╝

/*
CONCEPT:
	Stored procedures support IF / ELSE and CASE logic.
	Use Case: Apply business rules and generate interpreted output.
*/

DROP PROCEDURE IF EXISTS sp_get_salary_band;

DELIMITER $$

CREATE PROCEDURE sp_get_salary_band(IN p_employee_id INT)
BEGIN
		DECLARE v_employee_name VARCHAR(120);
		DECLARE v_salary DECIMAL(10, 2);
		DECLARE v_salary_band VARCHAR(20);

		SELECT
				CONCAT(first_name, ' ', last_name),
				salary
		INTO v_employee_name, v_salary
		FROM employee
		WHERE employeeId = p_employee_id;

		IF v_salary IS NULL THEN
				SET v_salary_band = 'Not Found';
		ELSEIF v_salary < 30000 THEN
				SET v_salary_band = 'Entry Level';
		ELSEIF v_salary < 70000 THEN
				SET v_salary_band = 'Mid Level';
		ELSE
				SET v_salary_band = 'Senior Level';
		END IF;

		SELECT
				p_employee_id AS employeeId,
				v_employee_name AS employee_name,
				v_salary AS salary,
				v_salary_band AS salary_band;
END $$

DELIMITER ;

-- Usage:
CALL sp_get_salary_band(1);


-- ╔════════════════════════════════════════════════════════════════════════════╗
-- ║ 9. PROCEDURE WITH TRANSACTION - Assign Employee to Project                 ║
-- ╚════════════════════════════════════════════════════════════════════════════╝

/*
CONCEPT:
	Procedures can combine validation and transaction handling.
	Use Case: Insert assignment records safely and roll back on errors.
*/

DROP PROCEDURE IF EXISTS sp_assign_employee_to_project;

DELIMITER $$

CREATE PROCEDURE sp_assign_employee_to_project(
		IN p_assignment_id INT,
		IN p_employee_id INT,
		IN p_project_id INT,
		IN p_role VARCHAR(100),
		IN p_allocation_percentage DECIMAL(5, 2),
		IN p_assignment_date DATE
)
BEGIN
		DECLARE v_existing_assignment INT DEFAULT 0;

		DECLARE EXIT HANDLER FOR SQLEXCEPTION
		BEGIN
				ROLLBACK;
		END;

		START TRANSACTION;

		SELECT COUNT(*)
		INTO v_existing_assignment
		FROM project_assignment
		WHERE employeeId = p_employee_id
			AND projectId = p_project_id;

		IF v_existing_assignment = 0 THEN
				INSERT INTO project_assignment (
						assignment_id,
						employeeId,
						projectId,
						role,
						allocation_percentage,
						assignment_date
				)
				VALUES (
						p_assignment_id,
						p_employee_id,
						p_project_id,
						p_role,
						p_allocation_percentage,
						p_assignment_date
				);

				COMMIT;

				SELECT 'Assignment created successfully' AS message;
		ELSE
				ROLLBACK;
				SELECT 'Assignment already exists for this employee and project' AS message;
		END IF;
END $$

DELIMITER ;

-- Usage:
CALL sp_assign_employee_to_project(1001, 1, 101, 'Developer', 50.00, '2026-04-27');


-- ╔════════════════════════════════════════════════════════════════════════════╗
-- ║ 10. BEST PRACTICES AND COMMON MISTAKES                                     ║
-- ╚════════════════════════════════════════════════════════════════════════════╝

/*
BEST PRACTICES:
	1. Use clear prefixes such as sp_ for procedure names.
	2. Drop existing procedure definitions before recreating them during practice.
	3. Keep business rules inside procedures only when database-level reuse matters.
	4. Validate parameter values before INSERT or UPDATE operations.
	5. Use transactions for multi-step writes that must succeed together.
	6. Use OUT or INOUT only when returning scalar values is necessary.
	7. Document expected input and output behavior with comments.

COMMON MISTAKES:
	1. Forgetting to change DELIMITER before CREATE PROCEDURE.
	2. Mixing procedure parameter names with column names without prefixes.
	3. Omitting transaction handling for multi-step data changes.
	4. Returning multiple unrelated responsibilities from one procedure.
	5. Writing large procedures that are difficult to debug and maintain.

DEBUGGING TIP:
	Use SELECT statements inside procedures during learning to inspect variable
	values and verify control flow.
*/
