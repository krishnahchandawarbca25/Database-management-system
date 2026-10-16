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
e.emp_id, 
e.emp_name, 
e.salary, 
d.dept_name, 
d.location
FROM employees e
INNER JOIN departments d ON e.dept_id = d.dept_id;
SELECT 
d.dept_name, 
e.emp_name, 
e.salary
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id;
SELECT 
e.emp_name, 
d.dept_name
FROM employees e
RIGHT JOIN departments d ON e.dept_id = d.dept_id;
SELECT 
e.emp_name, 
d.dept_name
FROM employees e
FULL OUTER JOIN departments d ON e.dept_id = d.dept_id;
SELECT emp_name, salary, dept_name, location
FROM employees
NATURAL JOIN departments;


