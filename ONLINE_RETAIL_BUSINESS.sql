CREATE DATABASE ONLINE_RETAIL_BUSINESS;
USE ONLINE_RETAIL_BUSINESS;

CREATE TABLE Customers (
Customer_ID INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
Name VARCHAR(50),
Email VARCHAR(50),
Phone INT ,
Address VARCHAR(50)
);

CREATE TABLE Orders (
Order_ID INT AUTO_INCREMENT NOT NULL PRIMARY KEY unique,
Customer_ID INT,
Order_Date VARCHAR(10),
Status VARCHAR(20),
foreign key (Customer_ID) REFERENCES Customers(Customer_ID)
);

CREATE TABLE Suppliers (
  Supplier_ID INT AUTO_INCREMENT PRIMARY KEY,
  Name VARCHAR(100) NOT NULL,
  Contact_Info VARCHAR(255)
);

CREATE TABLE Products (
  Product_ID INT AUTO_INCREMENT PRIMARY KEY,
  Name VARCHAR(100) NOT NULL,
  Description TEXT,
  Supplier_ID INT,
  Price DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (Supplier_ID) REFERENCES Suppliers(Supplier_ID)
);

CREATE TABLE Inventory (
  Product_ID INT PRIMARY KEY,
  Quantity_Available INT DEFAULT 0 CHECK (Quantity_Available >= 0),
  FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID)
);
CREATE TABLE Order_Items (
  Order_ID INT,
  Product_ID INT,
  Quantity INT NOT NULL CHECK (Quantity > 0),
  Price DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (Order_ID, Product_ID),
  FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID),
  FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID)
);

CREATE TABLE Payments (
  Payment_ID INT AUTO_INCREMENT PRIMARY KEY,
  Order_ID INT,
  Amount DECIMAL(10,2) NOT NULL CHECK (Amount >= 0),
  Payment_Date DATE NOT NULL,
  Method ENUM('Credit Card', 'Debit Card', 'UPI', 'Net Banking', 'COD') NOT NULL,
  Status ENUM('Success', 'Failed', 'Pending') NOT NULL,
  FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID)
);

SHOW TABLES;

DESCRIBE Customers;
ALTER TABLE Customers MODIFY Phone VARCHAR(15);

INSERT INTO Customers (Name, Email, Phone, Address) VALUES
('Alice Sharma', 'alice@gmail.com', 9876543210, 'Bandra, Mumbai'),
('Rahul Mehta', 'rahul@hotmail.com', 9123456789, 'Sector 17, Chandigarh'),
('Sneha Patel', 'sneha@yahoo.com', 8899776655, 'Koregaon Park, Pune'),
('Amit Verma', 'amit@gmail.com', 9988776655, 'Salt Lake, Kolkata');


INSERT INTO Orders (Customer_ID, Order_Date, Status) VALUES
(1, '2025-07-24', 'Pending'),
(2, '2025-07-25', 'Shipped'),
(1, '2025-07-26', 'Delivered'),
(4, '2025-07-26', 'Pending');

SELECT * FROM ORDERS;

-- Suppliers
INSERT INTO Suppliers (Name, Contact_Info) VALUES
('Global Electronics', 'global@electronics.com, +91-9876543210'),
('Fresh Foods', 'contact@freshfoods.com, +91-9123456789'),
('Home Essentials Ltd.', 'support@homeessentials.com, +91-9988776655');

-- Products
INSERT INTO Products (Name, Description, Supplier_ID, Price) VALUES
('Smartphone', 'Latest model Android smartphone', 1, 24999.99),
('Wireless Headphones', 'Noise cancelling over-ear headphones', 1, 4999.00),
('Organic Apples', '1kg pack of fresh organic apples', 2, 199.50),
('Rice Cooker', 'Electric rice cooker with timer', 3, 2200.00);

-- Inventory
INSERT INTO Inventory (Product_ID, Quantity_Available) VALUES
(1, 100),
(2, 200),
(3, 150),
(4, 80);

-- Order_Items
INSERT INTO Order_Items (Order_ID, Product_ID, Quantity, Price) VALUES
(1, 1, 1, 24999.99),
(1, 2, 2, 4999.00),
(2, 3, 3, 199.50),
(3, 4, 1, 2200.00),
(4, 2, 1, 4999.00);

-- Payments
INSERT INTO Payments (Order_ID, Amount, Payment_Date, Method, Status) VALUES
(1, 34997.99, '2025-07-24', 'Credit Card', 'Success'),
(2, 598.50, '2025-07-25', 'UPI', 'Success'),
(3, 2200.00, '2025-07-26', 'Net Banking', 'Pending'),
(4, 4999.00, '2025-07-26', 'COD', 'Pending');

-- Get all customers from Mumbai
SELECT * FROM Customers WHERE Address LIKE '%Mumbai%';

-- Count total customers
SELECT COUNT(*) AS Total_Customers FROM Customers;
-- Show all orders with customer name
SELECT o.Order_ID, c.Name AS Customer_Name, o.Order_Date, o.Status
FROM Orders o
JOIN Customers c ON o.Customer_ID = c.Customer_ID;

-- Count orders by status
SELECT Status, COUNT(*) AS Count FROM Orders GROUP BY Status;

-- List all suppliers alphabetically
SELECT * FROM Suppliers ORDER BY Name;

-- Count number of products supplied by each supplier
SELECT s.Name, COUNT(p.Product_ID) AS Total_Products
FROM Suppliers s
LEFT JOIN Products p ON s.Supplier_ID = p.Supplier_ID
GROUP BY s.Supplier_ID;

-- Products above ₹5,000
SELECT * FROM Products WHERE Price > 5000;

-- List product name with supplier name
SELECT p.Name AS Product, s.Name AS Supplier
FROM Products p
JOIN Suppliers s ON p.Supplier_ID = s.Supplier_ID;


-- Products that are out of stock
SELECT p.Name, i.Quantity_Available
FROM Inventory i
JOIN Products p ON i.Product_ID = p.Product_ID
WHERE i.Quantity_Available = 0;

-- Total available stock
SELECT SUM(Quantity_Available) AS Total_Stock FROM Inventory;

-- Items in order ID = 1
SELECT oi.Order_ID, p.Name AS Product, oi.Quantity, oi.Price
FROM Order_Items oi
JOIN Products p ON oi.Product_ID = p.Product_ID
WHERE oi.Order_ID = 1;

-- Total items sold per product
SELECT p.Name, SUM(oi.Quantity) AS Total_Sold
FROM Order_Items oi
JOIN Products p ON oi.Product_ID = p.Product_ID
GROUP BY oi.Product_ID;

-- Successful payments
SELECT * FROM Payments WHERE Status = 'Success';

-- Total revenue collected
SELECT SUM(Amount) AS Total_Revenue FROM Payments WHERE Status = 'Success';
