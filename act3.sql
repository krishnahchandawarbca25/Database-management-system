DROP DATABASE IF EXISTS CombinedSystemDB;
CREATE DATABASE CombinedSystemDB;
USE CombinedSystemDB;
CREATE TABLE Patient (
Patient_ID INT PRIMARY KEY,
Patient_Name VARCHAR(100) NOT NULL,
Age INT,
City VARCHAR(50)
);
CREATE TABLE Doctor (
Doctor_ID INT PRIMARY KEY,
Doctor_Name VARCHAR(100) NOT NULL,
Specialization VARCHAR(100)
);
CREATE TABLE Appointment (
Appointment_ID INT PRIMARY KEY,
Patient_ID INT,
Doctor_ID INT,
Appointment_Date DATE,
Status VARCHAR(20),
FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID),
FOREIGN KEY (Doctor_ID) REFERENCES Doctor(Doctor_ID)
);
INSERT INTO Patient (Patient_ID, Patient_Name, Age, City) VALUES
(101, 'Alice Smith', 30, 'New York'),
(102, 'Bob Jones', 45, 'Chicago'),
(103, 'Charlie Brown', 25, 'Houston'),
(104, 'Diana Prince', 35, 'Phoenix'); 
INSERT INTO Doctor (Doctor_ID, Doctor_Name, Specialization) VALUES
(201, 'Dr. Sarah Connor', 'Cardiology'),
(202, 'Dr. John Watson', 'General Medicine'),
(203, 'Dr. Gregory House', 'Neurology'); 
INSERT INTO Appointment (Appointment_ID, Patient_ID, Doctor_ID, Appointment_Date, Status) VALUES
(1, 101, 201, '2026-10-20', 'Scheduled'),
(2, 102, 201, '2026-10-21', 'Completed'),
(3, 103, 202, '2026-10-22', 'Scheduled');
CREATE TABLE Product (
Product_ID INT PRIMARY KEY,
Product_Name VARCHAR(100) NOT NULL,
Stock_Quantity INT NOT NULL,
Price DECIMAL(10, 2) NOT NULL
);
CREATE TABLE Sales (
Sale_ID INT PRIMARY KEY,
Sale_Date DATE NOT NULL
);
CREATE TABLE Sale_Details (
Sale_ID INT,
Product_ID INT,
Quantity INT NOT NULL,
PRIMARY KEY (Sale_ID, Product_ID),
FOREIGN KEY (Sale_ID) REFERENCES Sales(Sale_ID),
FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID)
);
INSERT INTO Product (Product_ID, Product_Name, Stock_Quantity, Price) VALUES
(1, 'Laptop', 10, 800.00),
(2, 'Mouse', 5, 25.00);
INSERT INTO Sales (Sale_ID, Sale_Date) VALUES
(101, '2026-10-16'),
(102, '2026-10-16');
DELIMITER //
CREATE TRIGGER trg_CheckStockBeforeInsert
BEFORE INSERT ON Sale_Details
FOR EACH ROW
BEGIN
DECLARE current_stock INT;
IF NEW.Quantity <= 0 THEN
	SIGNAL SQLSTATE '45000'
	 SET MESSAGE_TEXT = 'Error: Sale quantity must be greater than zero.';
    END IF;
    SELECT Stock_Quantity INTO current_stock
    FROM Product
    WHERE Product_ID = NEW.Product_ID;  
    IF NEW.Quantity > current_stock THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Requested quantity exceeds available stock.';
END IF;