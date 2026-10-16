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
SELECT 
dept_id, 
COUNT(emp_id) AS total_employees,
AVG(salary) AS average_salary,
SUM(salary) AS total_payroll
FROM employees
GROUP BY dept_id;
SELECT 
dept_id, 
COUNT(emp_id) AS total_employees,
AVG(salary) AS average_salary
FROM employees
GROUP BY dept_id
HAVING COUNT(emp_id) > 1 AND AVG(salary) > 60000;
SELECT emp_name, dept_id, salary
FROM employees
ORDER BY dept_id ASC, salary DESC;
