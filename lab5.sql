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
emp_name, 
salary AS monthly_salary,
(salary * 12) AS annual_salary,                    
(salary + 5000) AS salary_with_bonus,               
(salary - 1000) AS salary_after_tax,             
(salary / 30) AS daily_rate,                       
(emp_id % 2) AS team_allocation_id                  
FROM employees;
SELECT * FROM employees WHERE dept_id = 10;
SELECT * FROM employees WHERE dept_id <> 20;
SELECT emp_name, salary 
FROM employees 
WHERE salary > 50000 AND salary <= 85000;
SELECT * FROM employees 
WHERE dept_id = 10 AND salary > 60000;
SELECT * FROM employees 
WHERE dept_id = 10 OR dept_id = 30;
SELECT * FROM employees 
WHERE NOT (dept_id = 20);