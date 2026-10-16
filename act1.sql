CREATE DATABASE HospitalDB;
USE HospitalDB;
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
SELECT 
p.Patient_Name,
d.Doctor_Name,
d.Specialization,
a.Appointment_Date
FROM Appointment a
INNER JOIN Patient p ON a.Patient_ID = p.Patient_ID
INNER JOIN Doctor d ON a.Doctor_ID = d.Doctor_ID;
SELECT 
p.Patient_ID,
p.Patient_Name,
p.Age,
p.City,
a.Appointment_ID,
a.Appointment_Date,
a.Status
FROM Patient p
LEFT JOIN Appointment a ON p.Patient_ID = a.Patient_ID;
SELECT 
d.Doctor_Name,
COUNT(a.Appointment_ID) AS Total_Appointments
FROM Doctor d
LEFT JOIN Appointment a ON d.Doctor_ID = a.Doctor_ID
GROUP BY d.Doctor_ID, d.Doctor_Name;

 