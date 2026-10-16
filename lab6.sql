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
SELECT emp_name, salary 
FROM employees 
WHERE salary BETWEEN 40000 AND 80000;
SELECT emp_name, dept_id 
FROM employees 
WHERE dept_id IN (10, 30, 50);
SELECT emp_name 
FROM employees 
WHERE emp_name LIKE 'A%';    
SELECT emp_name 
FROM employees 
WHERE emp_name LIKE '_a%';   
SELECT emp_name, manager_id 
FROM employees 
WHERE manager_id IS NULL;     
SELECT emp_id, emp_name, dept_id FROM employees WHERE dept_id = 10
UNION
SELECT emp_id, emp_name, dept_id FROM employees WHERE salary > 75000;
SELECT emp_name, salary FROM active_employees
UNION ALL
SELECT emp_name, salary FROM archived_employees;