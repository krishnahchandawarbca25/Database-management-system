CREATE TABLE student_info (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    second_name VARCHAR(50),
    third_name VARCHAR(50),
    age INT,
    email VARCHAR(50),
    course VARCHAR(50)
);

INSERT INTO student_info VALUES (1, 'Rahul', 'Kumar', 'Sharma', 20, 'rahul@email.com', 'Computer Science');
INSERT INTO student_info VALUES (2, 'Priya', 'Ramesh', 'Patel', 19, 'priya@email.com', 'Mathematics');
INSERT INTO student_info VALUES (3, 'Amit', 'Raj', 'Kumar', 21, 'amit@email.com', 'Physics');
INSERT INTO student_info VALUES (4, 'Sneha', 'Anil', 'Gupta', 20, 'sneha@email.com', 'Computer Science');


SELECT * FROM student_info;


SELECT first_name, second_name, course FROM student_info;


UPDATE student_info 
SET age = 22 
WHERE student_id = 3;

DELETE FROM student_info 
WHERE student_id = 4;

SELECT * FROM student_info;