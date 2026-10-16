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
    emp_id, 
    emp_name, 
    CAST (salary AS VARCHAR(20)) AS salary_string
FROM employees;
SELECT 
    emp_name, 
    TO_CHAR(hire_date, 'DD-Mon-YYYY') AS formatted_hire_date
FROM employees;
SELECT CAST('2024-01-15' AS DATE) AS joined_date;
-- Extract year, month, and day from hire_date
SELECT 
    emp_name, 
    hire_date,
    EXTRACT(YEAR FROM hire_date) AS join_year,
    EXTRACT(MONTH FROM hire_date) AS join_month,
    EXTRACT(DAY FROM hire_date) AS join_day
FROM employees;
SELECT 
    emp_name, 
    hire_date, 
    CURRENT_DATE AS today,
    DATEDIFF(YEAR, hire_date, CURRENT_DATE) AS years_of_service
FROM employees;
SELECT 
    emp_name, 
    hire_date, 
    DATEADD(MONTH, 6, hire_date) AS review_date 
FROM employees;