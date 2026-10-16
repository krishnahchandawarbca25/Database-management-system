CREATE DATABASE EmployeeDB;
USE EmployeeDB;
CREATE TABLE departments (
dept_id INT PRIMARY KEY,
dept_name VARCHAR(50) NOT NULL,
location VARCHAR(50) NOT NULL
);
CREATE TABLE employees (
emp_id INT PRIMARY KEY,
emp_name VARCHAR(50) NOT NULL,
email VARCHAR(100) UNIQUE,
salary DECIMAL(10, 2) NOT NULL,
hire_date DATE NOT NULL,
dept_id INT,
manager_id INT,
FOREIGN KEY (dept_id) REFERENCES departments(dept_id),
FOREIGN KEY (manager_id) REFERENCES employees(emp_id)
);
CREATE TABLE archived_employees (
emp_id INT PRIMARY KEY,
emp_name VARCHAR(50) NOT NULL,
salary DECIMAL(10, 2) NOT NULL,
exit_date DATE NOT NULL
);
DELIMITER //
CREATE PROCEDURE GetEmployeesByDept(IN p_dept_id INT)
BEGIN
    SELECT emp_id, emp_name, salary, hire_date 
    FROM employees 
    WHERE dept_id = p_dept_id;
END //
DELIMITER ;
CALL GetEmployeesByDept(10);
DELIMITER //
CREATE PROCEDURE InsertEmployee(
IN p_emp_id INT,
IN p_emp_name VARCHAR(50),
IN p_email VARCHAR(100),
IN p_salary DECIMAL(10,2),
IN p_hire_date DATE,
IN p_dept_id INT,
IN p_manager_id INT
)
BEGIN
INSERT INTO employees (emp_id, emp_name, email, salary, hire_date, dept_id, manager_id)
VALUES (p_emp_id, p_emp_name, p_email, p_salary, p_hire_date, p_dept_id, p_manager_id);
END //
DELIMITER ;
CALL InsertEmployee(107, 'Grace Hopper', 'grace@company.com', 88000.00, '2024-02-01', 10, 101);
DELIMITER //
CREATE PROCEDURE UpdateEmployeeSalary(
IN p_emp_id INT,
IN p_new_salary DECIMAL(10,2)
)
BEGIN
UPDATE employees 
SET salary = p_new_salary 
WHERE emp_id = p_emp_id;
END //
DELIMITER ;
CALL UpdateEmployeeSalary(107, 92000.00);
DELIMITER //
CREATE PROCEDURE DeleteEmployee(IN p_emp_id INT)
BEGIN
DELETE FROM employees WHERE emp_id = p_emp_id;
END //
DELIMITER ;
CALL DeleteEmployee(107);
