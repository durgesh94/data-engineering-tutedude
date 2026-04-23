/*
================================================================================
  SQL LOGICAL OPERATORS - Tutorial
================================================================================
  Description: Master SQL logical operators (AND, OR, NOT) to create complex
               WHERE conditions. Learn how to combine multiple predicates,
               filter data with multiple criteria, and use truth logic in
               queries for advanced filtering and data retrieval
  
  SCHEMA OVERVIEW:
    - department: departmentId (PK), name, manager_email
    - employee: employeeId (PK), first_name, last_name, email, salary, departmentId (FK)
    - project: projectId (PK), project_name, description, start_date, end_date, 
               budget, departmentId (FK), status
    - project_assignment: assignment_id (PK), employeeId (FK), projectId (FK), 
                          role, allocation_percentage, assignment_date
  
  LEARNING OBJECTIVES:
    - Use AND operator to require ALL conditions to be true
    - Use OR operator to require AT LEAST ONE condition to be true
    - Use NOT operator to negate/invert a condition
    - Combine AND, OR, NOT in complex WHERE clauses
    - Understand operator precedence (NOT > AND > OR)
    - Use parentheses to control precedence
    - Create efficient, readable filtering logic
    - Apply logical operators to real-world business scenarios
    - Debug complex WHERE clauses systematically
  
  ⚠️  KEY CONCEPTS ⚠️
    - AND: All conditions MUST be TRUE (returns row if true AND true AND true)
    - OR: At least ONE condition MUST be TRUE (returns row if true OR true OR false)
    - NOT: Inverts condition (NOT true = false, NOT false = true)
    - Default precedence: NOT > AND > OR (evaluate in that order)
    - Use parentheses () to override precedence and improve readability
    - Combinations: AND/OR together, NOT with AND, NOT with OR
    - NULL in logical expressions: NULL compared with anything = UNKNOWN (not rows)
    - Short-circuit evaluation: AND stops at first false, OR stops at first true
================================================================================
*/

-- ===============================================
-- PART 1: AND OPERATOR
-- ===============================================

-- ===============================================
-- 1. AND - Basic usage (2 conditions)
-- ===============================================
-- Get employees in Engineering department with salary > 55000

SELECT employeeId, first_name, last_name, salary, departmentId
FROM employee
WHERE departmentId = 2 AND salary > 55000;

-- Get active projects with budget > 200000
SELECT projectId, project_name, status, budget
FROM project
WHERE status = 'Active' AND budget > 200000;

-- Get employees starting with 'A' in HR department
SELECT employeeId, first_name, last_name, departmentId
FROM employee
WHERE departmentId = 1 AND first_name LIKE 'A%';

-- ===============================================
-- 2. AND - Multiple conditions (3+ conditions)
-- ===============================================
-- Get employees in Engineering with salary > 55000 AND email contains 'eng'

SELECT employeeId, first_name, last_name, salary, email, departmentId
FROM employee
WHERE departmentId = 2 AND salary > 55000 AND email LIKE '%eng%';

-- Get projects that are Active AND not in Finance dept AND budget > 150000
SELECT projectId, project_name, status, budget, departmentId
FROM project
WHERE status = 'Active' AND departmentId != 4 AND budget > 150000;

-- Get assignments from specific employees in specific roles
SELECT assignment_id, employeeId, projectId, role, allocation_percentage
FROM project_assignment
WHERE employeeId = 1 AND role = 'Project Manager' AND allocation_percentage >= 50;

-- ===============================================
-- 3. AND - With date ranges
-- ===============================================
-- Get projects that started after 2025-01-01 AND end before 2025-07-01

SELECT projectId, project_name, start_date, end_date, budget
FROM project
WHERE start_date >= '2025-01-01' AND end_date <= '2025-07-01';

-- Get employees hired after 2025-01-01 AND with salary between 50000 and 60000
SELECT employeeId, first_name, last_name, salary, assignment_date
FROM project_assignment
WHERE assignment_date >= '2025-01-01' AND allocation_percentage > 50;

-- ===============================================
-- PART 2: OR OPERATOR
-- ===============================================

-- ===============================================
-- 4. OR - Basic usage (2 conditions)
-- ===============================================
-- Get employees in HR OR Finance department

SELECT employeeId, first_name, last_name, departmentId, salary
FROM employee
WHERE departmentId = 1 OR departmentId = 4;

-- Get projects with status 'Active' OR status 'Completed'
SELECT projectId, project_name, status, budget
FROM project
WHERE status = 'Active' OR status = 'Completed';

-- Get employees with salary < 51000 OR salary > 64000
SELECT employeeId, first_name, last_name, salary
FROM employee
WHERE salary < 51000 OR salary > 64000;

-- ===============================================
-- 5. OR - Multiple conditions (3+ conditions)
-- ===============================================
-- Get employees in HR, Engineering, OR Sales departments

SELECT employeeId, first_name, last_name, departmentId
FROM employee
WHERE departmentId = 1 OR departmentId = 2 OR departmentId = 3;

-- Get projects with status Active, Completed, OR On Hold
SELECT projectId, project_name, status, budget
FROM project
WHERE status = 'Active' OR status = 'Completed' OR status = 'On Hold';

-- Get employees named 'John' OR 'Jane' OR 'Michael'
SELECT employeeId, first_name, last_name, salary
FROM employee
WHERE first_name = 'John' OR first_name = 'Jane' OR first_name = 'Michael';

-- ===============================================
-- 6. OR - With IN clause (shorthand for multiple OR)
-- ===============================================
-- Same as condition 4, but using IN (cleaner syntax)

SELECT employeeId, first_name, last_name, departmentId, salary
FROM employee
WHERE departmentId IN (1, 4);

-- Get projects with multiple statuses (equivalent to condition 5)
SELECT projectId, project_name, status, budget
FROM project
WHERE status IN ('Active', 'Completed', 'On Hold');

-- Get specific employees by ID
SELECT employeeId, first_name, last_name, salary
FROM employee
WHERE employeeId IN (1, 3, 4);

-- ===============================================
-- PART 3: NOT OPERATOR
-- ===============================================

-- ===============================================
-- 7. NOT - Basic usage
-- ===============================================
-- Get employees NOT in Engineering department

SELECT employeeId, first_name, last_name, departmentId, salary
FROM employee
WHERE NOT departmentId = 2;

-- Same query using != (alternative syntax)
SELECT employeeId, first_name, last_name, departmentId, salary
FROM employee
WHERE departmentId != 2;

-- Get projects NOT completed
SELECT projectId, project_name, status, budget
FROM project
WHERE NOT status = 'Completed';

-- Same using !=
SELECT projectId, project_name, status, budget
FROM project
WHERE status != 'Completed';

-- ===============================================
-- 8. NOT - With IN clause
-- ===============================================
-- Get employees NOT in HR, Engineering, OR Finance (only Sales)

SELECT employeeId, first_name, last_name, departmentId
FROM employee
WHERE NOT departmentId IN (1, 2, 4);

-- Equivalent to:
SELECT employeeId, first_name, last_name, departmentId
FROM employee
WHERE departmentId NOT IN (1, 2, 4);

-- Get projects NOT in specific statuses
SELECT projectId, project_name, status
FROM project
WHERE status NOT IN ('Completed', 'On Hold');

-- ===============================================
-- 9. NOT - With LIKE
-- ===============================================
-- Get employees whose first name does NOT start with 'J'

SELECT employeeId, first_name, last_name
FROM employee
WHERE NOT first_name LIKE 'J%';

-- Same using !=
SELECT employeeId, first_name, last_name
FROM employee
WHERE first_name NOT LIKE 'J%';

-- Get projects whose name does NOT contain 'System'
SELECT projectId, project_name
FROM project
WHERE NOT project_name LIKE '%System%';

-- ===============================================
-- 10. NOT - With comparison operators
-- ===============================================
-- Get employees with salary NOT > 55000 (i.e., <= 55000)

SELECT employeeId, first_name, last_name, salary
FROM employee
WHERE NOT salary > 55000;

-- Same using <= directly
SELECT employeeId, first_name, last_name, salary
FROM employee
WHERE salary <= 55000;

-- Get projects with budget NOT >= 200000
SELECT projectId, project_name, budget
FROM project
WHERE NOT budget >= 200000;

-- ===============================================
-- PART 4: COMBINING AND, OR, NOT
-- ===============================================

-- ===============================================
-- 11. AND with OR (default precedence)
-- ===============================================
-- Get employees in Engineering with salary > 55000 OR anyone in Finance
-- Precedence: AND evaluated before OR
-- Result: (departmentId = 2 AND salary > 55000) OR departmentId = 4

SELECT employeeId, first_name, last_name, salary, departmentId
FROM employee
WHERE departmentId = 2 AND salary > 55000 OR departmentId = 4;

-- Get high-paid employees (>60000) in Engineering OR any Finance employee
SELECT employeeId, first_name, last_name, salary, departmentId
FROM employee
WHERE departmentId = 2 AND salary > 60000 OR departmentId = 4;

-- Get active projects with budget > 150000 OR all on-hold projects
SELECT projectId, project_name, status, budget
FROM project
WHERE status = 'Active' AND budget > 150000 OR status = 'On Hold';

-- ===============================================
-- 12. Using parentheses to control precedence
-- ===============================================
-- Get employees in Engineering OR Finance with salary > 55000
-- WITH parentheses: (departmentId = 2 OR departmentId = 4) AND salary > 55000

SELECT employeeId, first_name, last_name, salary, departmentId
FROM employee
WHERE (departmentId = 2 OR departmentId = 4) AND salary > 55000;

-- Without parentheses (different result):
SELECT employeeId, first_name, last_name, salary, departmentId
FROM employee
WHERE departmentId = 2 OR departmentId = 4 AND salary > 55000;

-- Get projects in Engineering OR Finance departments with Active status
SELECT projectId, project_name, status, budget, departmentId
FROM project
WHERE (departmentId = 2 OR departmentId = 4) AND status = 'Active';

-- Get any Finance project OR active Engineering projects
SELECT projectId, project_name, status, departmentId
FROM project
WHERE departmentId = 4 OR departmentId = 2 AND status = 'Active';

-- ===============================================
-- 13. NOT with AND
-- ===============================================
-- Get employees NOT (in Engineering AND earning > 55000)

SELECT employeeId, first_name, last_name, salary, departmentId
FROM employee
WHERE NOT (departmentId = 2 AND salary > 55000);

-- Get employees who are either not in Engineering OR not high-paid
SELECT employeeId, first_name, last_name, salary, departmentId
FROM employee
WHERE departmentId != 2 OR salary <= 55000;

-- Get projects that are NOT (Active AND high budget)
SELECT projectId, project_name, status, budget
FROM project
WHERE NOT (status = 'Active' AND budget > 200000);

-- ===============================================
-- 14. NOT with OR
-- ===============================================
-- Get employees NOT from HR, Engineering, OR Finance (only Sales)

SELECT employeeId, first_name, last_name, departmentId
FROM employee
WHERE NOT (departmentId = 1 OR departmentId = 2 OR departmentId = 4);

-- Same using NOT IN (cleaner)
SELECT employeeId, first_name, last_name, departmentId
FROM employee
WHERE departmentId NOT IN (1, 2, 4);

-- Get projects NOT (High budget OR On Hold status)
SELECT projectId, project_name, status, budget
FROM project
WHERE NOT (budget > 200000 OR status = 'On Hold');

-- ===============================================
-- 15. Complex combinations (multiple AND, OR, NOT)
-- ===============================================
-- Get high-paid employees in Engineering or Finance, excluding those with 'john' in name

SELECT employeeId, first_name, last_name, salary, departmentId
FROM employee
WHERE (departmentId IN (2, 4)) AND (salary > 55000) AND (first_name NOT LIKE '%john%');

-- Get active or on-hold projects NOT in Engineering with budget > 150000
SELECT projectId, project_name, status, budget, departmentId
FROM project
WHERE (status = 'Active' OR status = 'On Hold') AND (departmentId != 2) AND (budget > 150000);

-- Get assignments from high-allocation staff (>=50%) in PM or Developer roles, excluding specific employees
SELECT assignment_id, employeeId, projectId, role, allocation_percentage
FROM project_assignment
WHERE (role IN ('Project Manager', 'Developer')) AND (allocation_percentage >= 50) AND (employeeId NOT IN (2, 4));

-- ===============================================
-- PART 5: PRACTICAL BUSINESS QUERIES
-- ===============================================

-- ===============================================
-- 16. Project filtering with multiple criteria
-- ===============================================
-- Find projects that need attention: Active or On Hold, AND not in Finance

SELECT projectId, project_name, status, budget, departmentId
FROM project
WHERE (status = 'Active' OR status = 'On Hold') AND departmentId != 4;

-- Find high-value projects: Either high budget OR long duration AND active
SELECT projectId, project_name, budget, status, DATEDIFF(end_date, start_date) AS duration
FROM project
WHERE (budget > 250000 OR DATEDIFF(end_date, start_date) > 180) AND status = 'Active';

-- ===============================================
-- 17. Employee filtering with multiple criteria
-- ===============================================
-- Find key employees: Engineering or Finance department AND salary > 55000

SELECT employeeId, first_name, last_name, salary, departmentId
FROM employee
WHERE (departmentId = 2 OR departmentId = 4) AND salary > 55000;

-- Find budget-conscious hires: Lower salary categories from multiple departments
SELECT employeeId, first_name, last_name, salary, departmentId
FROM employee
WHERE (departmentId IN (1, 3)) AND (salary < 55000);

-- ===============================================
-- 18. Assignment filtering with multiple criteria
-- ===============================================
-- Find critical resource assignments: High allocation (>=50%) in specific roles NOT from employees 2 or 4

SELECT assignment_id, employeeId, projectId, role, allocation_percentage
FROM project_assignment
WHERE (allocation_percentage >= 50) AND (role IN ('Project Manager', 'Lead Developer')) AND (employeeId NOT IN (2, 4));

-- Find underutilized assignments: Low allocation (<30%) OR in supporting roles
SELECT assignment_id, employeeId, projectId, role, allocation_percentage
FROM project_assignment
WHERE (allocation_percentage < 30) OR (role = 'Consultant');

-- ===============================================
-- 19. Date-based logical filtering
-- ===============================================
-- Find upcoming projects: Starting soon (within 30 days) AND in active status OR high priority

SELECT projectId, project_name, start_date, end_date, status, budget
FROM project
WHERE (start_date >= CURDATE() AND start_date <= DATE_ADD(CURDATE(), INTERVAL 30 DAY)) AND status IN ('Active', 'On Hold');

-- Find projects with timing overlaps: Start before 2025-06-01 AND end after 2025-03-01
SELECT projectId, project_name, start_date, end_date, status
FROM project
WHERE start_date < '2025-06-01' AND end_date > '2025-03-01';

-- ===============================================
-- 20. Combining multiple logical operators with JOINs
-- ===============================================
-- Find high-value project assignments: Active projects, high budget, high-paid employees only

SELECT 
  pa.assignment_id,
  e.employeeId,
  e.first_name,
  e.last_name,
  e.salary,
  p.projectId,
  p.project_name,
  p.budget,
  pa.role
FROM project_assignment pa
JOIN employee e ON pa.employeeId = e.employeeId
JOIN project p ON pa.projectId = p.projectId
WHERE (p.status = 'Active') AND (p.budget > 200000) AND (e.salary > 55000);

-- Find cross-department assignments in specific roles
SELECT 
  pa.assignment_id,
  e.employeeId,
  e.first_name,
  e.departmentId,
  p.projectId,
  p.departmentId AS project_dept,
  pa.role,
  pa.allocation_percentage
FROM project_assignment pa
JOIN employee e ON pa.employeeId = e.employeeId
JOIN project p ON pa.projectId = p.projectId
WHERE (e.departmentId != p.departmentId) AND (pa.role IN ('Project Manager', 'Lead Developer') OR pa.allocation_percentage >= 75);

-- ===============================================
-- QUICK REFERENCE - LOGICAL OPERATORS
-- ===============================================
/*
AND Operator:
  Syntax: condition1 AND condition2 AND condition3
  Returns: Row if ALL conditions are TRUE
  Truth table:
    TRUE AND TRUE = TRUE
    TRUE AND FALSE = FALSE
    FALSE AND FALSE = FALSE
  Example: WHERE salary > 50000 AND departmentId = 2

OR Operator:
  Syntax: condition1 OR condition2 OR condition3
  Returns: Row if AT LEAST ONE condition is TRUE
  Truth table:
    TRUE OR FALSE = TRUE
    TRUE OR TRUE = TRUE
    FALSE OR FALSE = FALSE
  Example: WHERE status = 'Active' OR status = 'Completed'

NOT Operator:
  Syntax: NOT condition
  Returns: Opposite of condition
  Truth table:
    NOT TRUE = FALSE
    NOT FALSE = TRUE
  Example: WHERE NOT status = 'Completed'
  Shorthand: WHERE status != 'Completed'

Operator Precedence (order of evaluation):
  1. NOT (highest priority)
  2. AND
  3. OR (lowest priority)
  
  Example: WHERE a OR b AND c means: a OR (b AND c)
  To change: use () → WHERE (a OR b) AND c

Parentheses:
  Use () to override precedence and improve readability
  Example: WHERE (departmentId = 1 OR departmentId = 2) AND salary > 55000
  Without (): WHERE departmentId = 1 OR departmentId = 2 AND salary > 55000
  These produce different results!

Common Shortcuts:
  X = 1 OR X = 2 OR X = 3 → Use IN: X IN (1, 2, 3)
  NOT (X = 1 OR X = 2) → Use NOT IN: X NOT IN (1, 2)
  X != Y AND X != Z → Use NOT IN: X NOT IN (Y, Z)
  NOT X > 5 → Use <=: X <= 5
*/

-- ===============================================
-- KEY POINTS & BEST PRACTICES
-- ===============================================
/*
1. AND requires ALL conditions TRUE (creates narrower results)
2. OR requires AT LEAST ONE TRUE (creates broader results)
3. NOT inverts the condition (opposite logic)

4. Precedence matters: NOT > AND > OR
5. Always use parentheses to clarify intent, especially with mixed operators
6. Test queries incrementally (add conditions one at a time)

7. IN is cleaner than multiple OR: x IN (1,2,3) vs x=1 OR x=2 OR x=3
8. NOT IN for exclusion: x NOT IN (1,2) instead of x!=1 AND x!=2

9. NULL values: Avoid = NULL, use IS NULL instead
10. NULL in logical: NULL AND x = UNKNOWN (doesn't return rows)

11. De Morgan's Laws (important for complex logic):
    NOT (A AND B) = NOT A OR NOT B
    NOT (A OR B) = NOT A AND NOT B

12. Performance: Put most restrictive condition first in AND
13. Performance: Use indexed columns in WHERE clauses
14. Performance: IN is often faster than multiple OR with many values

15. Readability: Use parentheses even if not needed
16. Readability: Put related conditions near each other
17. Readability: Add comments for complex WHERE clauses

18. Testing: Start with simple WHERE, add complexity gradually
19. Testing: Test edge cases (NULL, empty, boundary values)
20. Debugging: Break complex WHERE into smaller parts to test
*/

-- ===============================================
-- PRACTICE EXAMPLES - Uncomment to use
-- ===============================================

-- Example 1: Basic AND - employees in Engineering earning more than 55000
-- SELECT employeeId, first_name, last_name, salary FROM employee WHERE departmentId = 2 AND salary > 55000;

-- Example 2: Basic OR - projects that are Active or Completed
-- SELECT projectId, project_name, status FROM project WHERE status = 'Active' OR status = 'Completed';

-- Example 3: NOT - projects not on hold
-- SELECT projectId, project_name, status FROM project WHERE status != 'On Hold';

-- Example 4: Complex - high-paid employees (>60000) in Engineering or Finance
-- SELECT employeeId, first_name, last_name, salary, departmentId FROM employee WHERE (departmentId IN (2, 4)) AND salary > 60000;

-- Example 5: Complex with NOT - active projects not in Finance department
-- SELECT projectId, project_name, status, departmentId FROM project WHERE status = 'Active' AND departmentId NOT IN (4);

-- Example 6: Business logic - active or on-hold projects with budget > 150000 not in Finance
-- SELECT projectId, project_name, status, budget, departmentId FROM project WHERE (status IN ('Active', 'On Hold')) AND budget > 150000 AND departmentId != 4;

-- Example 7: Advanced - high-value assignments: active projects + high budget + high salary employees
-- SELECT pa.assignment_id, e.first_name, p.project_name, p.budget FROM project_assignment pa JOIN employee e ON pa.employeeId = e.employeeId JOIN project p ON pa.projectId = p.projectId WHERE p.status = 'Active' AND p.budget > 200000 AND e.salary > 55000;
