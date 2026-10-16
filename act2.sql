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
INSERT INTO Sale_Details (Sale_ID, Product_ID, Quantity) VALUES (101, 1, 3);
SELECT * FROM Product WHERE Product_ID = 1;
INSERT INTO Sale_Details (Sale_ID, Product_ID, Quantity) VALUES (101, 2, 8);
INSERT INTO Sale_Details (Sale_ID, Product_ID, Quantity) VALUES (102, 1, 0);