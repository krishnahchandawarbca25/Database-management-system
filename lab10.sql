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
CREATE TABLE employee_audit_log (
log_id INT AUTO_INCREMENT PRIMARY KEY,
emp_id INT,
action_type VARCHAR(50),
action_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
DELIMITER //
CREATE TRIGGER trg_before_insert_emp
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
IF NEW.salary <= 0 THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Error: Salary must be greater than zero.';
END IF;
END //
DELIMITER ;
DELIMITER //
CREATE TRIGGER trg_after_insert_emp
AFTER INSERT ON employees
FOR EACH ROW
BEGIN
INSERT INTO employee_audit_log (emp_id, action_type)
VALUES (NEW.emp_id, 'EMPLOYEE_INSERTED');
END //
DELIMITER ;
DELIMITER //
CREATE TRIGGER trg_before_update_emp
BEFORE UPDATE ON employees
FOR EACH ROW
BEGIN
IF NEW.salary < OLD.salary THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Error: Salary reduction is not allowed.';
END IF;
END //
DELIMITER ;
DELIMITER //
CREATE TRIGGER trg_after_update_emp
AFTER UPDATE ON employees
FOR EACH ROW
BEGIN
IF OLD.salary <> NEW.salary THEN
INSERT INTO employee_audit_log (emp_id, action_type)
VALUES (NEW.emp_id, CONCAT('SALARY_UPDATED_FROM_', OLD.salary, '_TO_', NEW.salary));
END IF;
END //
DELIMITER ;
DELIMITER //
CREATE TRIGGER trg_before_delete_emp
BEFORE DELETE ON employees
FOR EACH ROW
BEGIN
IF OLD.manager_id IS NULL THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Error: Cannot delete top-level management employees.';
END IF;
END //
DELIMITER ;
DELIMITER //
CREATE TRIGGER trg_after_delete_emp
AFTER DELETE ON employees
FOR EACH ROW
BEGIN
INSERT INTO archived_employees (emp_id, emp_name, salary, exit_date)
VALUES (OLD.emp_id, OLD.emp_name, OLD.salary, CURRENT_DATE);
    
INSERT INTO employee_audit_log (emp_id, action_type)
VALUES (OLD.emp_id, 'EMPLOYEE_DELETED_AND_ARCHIVED');
END //
DELIMITER ;
