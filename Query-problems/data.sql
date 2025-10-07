-- ============================================================
-- 🧩 SQL PRACTICE DATASET (30 Problems)
-- Works on PostgreSQL / MySQL
-- ============================================================

-- -----------------------------
-- Problem 1 / 2 / 5 / 6 / 9 / 10 / 18 / 25 / 28 / 30
-- Employee / Department Tables
-- -----------------------------
DROP TABLE IF EXISTS Employee, Department;
CREATE TABLE Department (
  id INT PRIMARY KEY,
  name VARCHAR(50)
);

CREATE TABLE Employee (
  id INT PRIMARY KEY,
  name VARCHAR(50),
  salary INT,
  department_id INT,
  manager_id INT NULL,
  FOREIGN KEY (department_id) REFERENCES Department(id)
);

INSERT INTO Department VALUES
(1, 'Engineering'),
(2, 'Finance'),
(3, 'Sales');

INSERT INTO Employee VALUES
(1, 'John', 8000, 1, NULL),
(2, 'Mary', 9000, 1, 1),
(3, 'Steve', 6000, 2, 1),
(4, 'Alex', 7000, 2, 3),
(5, 'Rachel', 8500, 1, 2),
(6, 'Tom', 4000, 3, 4),
(7, 'Harry', 9500, 3, NULL),
(8, 'David', 7500, 1, 2),
(9, 'Nancy', 8800, 2, 3),
(10, 'Oscar', 8700, 1, 5);

-- -----------------------------
-- Problem 3 / 14 / 19 / 24
-- Customers / Orders
-- -----------------------------
DROP TABLE IF EXISTS Customers, Orders;
CREATE TABLE Customers (
  id INT PRIMARY KEY,
  name VARCHAR(50)
);

CREATE TABLE Orders (
  id INT PRIMARY KEY,
  customer_id INT,
  amount DECIMAL(10,2),
  order_date DATE,
  region VARCHAR(30),
  FOREIGN KEY (customer_id) REFERENCES Customers(id)
);

INSERT INTO Customers VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie'),
(4, 'Diana');

INSERT INTO Orders VALUES
(1, 1, 120.00, '2024-01-15', 'East'),
(2, 2, 450.00, '2024-02-12', 'West'),
(3, 1, 300.00, '2024-03-10', 'East'),
(4, 3, 500.00, '2024-03-20', 'South'),
(5, 1, 700.00, '2024-04-22', 'North'),
(6, 2, 200.00, '2024-05-02', 'West');

-- -----------------------------
-- Problem 4 / 16 / 17 / 23 / 24 / 29
-- Products / Sales / OrderDetails / Categories
-- -----------------------------
DROP TABLE IF EXISTS Products, Sales, Categories, OrderDetails;
CREATE TABLE Products (
  id INT PRIMARY KEY,
  name VARCHAR(50),
  category_id INT
);

CREATE TABLE Categories (
  id INT PRIMARY KEY,
  name VARCHAR(50)
);

CREATE TABLE Sales (
  id INT PRIMARY KEY,
  product_id INT,
  quantity INT,
  price DECIMAL(10,2),
  sale_date DATE,
  FOREIGN KEY (product_id) REFERENCES Products(id)
);

CREATE TABLE OrderDetails (
  order_id INT,
  product_id INT,
  quantity INT,
  price DECIMAL(10,2)
);

INSERT INTO Categories VALUES
(1, 'Electronics'),
(2, 'Furniture'),
(3, 'Groceries');

INSERT INTO Products VALUES
(1, 'Laptop', 1),
(2, 'Chair', 2),
(3, 'Desk', 2),
(4, 'Mouse', 1),
(5, 'Apples', 3),
(6, 'Bananas', 3);

INSERT INTO Sales VALUES
(1, 1, 2, 1200.00, '2024-01-10'),
(2, 1, 1, 1300.00, '2024-02-10'),
(3, 2, 4, 150.00, '2024-01-15'),
(4, 3, 3, 250.00, '2024-03-01'),
(5, 4, 5, 25.00, '2024-03-05'),
(6, 5, 10, 10.00, '2024-03-12'),
(7, 6, 12, 9.00, '2024-03-20');

INSERT INTO OrderDetails VALUES
(1, 1, 1, 1200.00),
(1, 4, 2, 25.00),
(2, 2, 1, 150.00),
(3, 3, 1, 250.00),
(3, 5, 5, 10.00),
(4, 6, 10, 9.00),
(5, 1, 1, 1300.00),
(6, 4, 3, 25.00);

-- -----------------------------
-- Problem 7 / 8
-- Person (Duplicate emails)
-- -----------------------------
DROP TABLE IF EXISTS Person;
CREATE TABLE Person (
  id INT PRIMARY KEY,
  email VARCHAR(100)
);

INSERT INTO Person VALUES
(1, 'john@example.com'),
(2, 'mary@example.com'),
(3, 'john@example.com'),
(4, 'alex@example.com'),
(5, 'mary@example.com');

-- -----------------------------
-- Problem 11 / 20
-- Orders already covers order_date and amount
-- reuse same table Orders for monthly sales and running total
-- -----------------------------

-- -----------------------------
-- Problem 12
-- Logins (monthly active users)
-- -----------------------------
DROP TABLE IF EXISTS Logins;
CREATE TABLE Logins (
  user_id INT,
  login_date DATE
);

INSERT INTO Logins VALUES
(1, '2024-01-05'),
(1, '2024-02-10'),
(1, '2024-03-12'),
(1, '2024-04-07'),
(1, '2024-05-09'),
(1, '2024-06-10'),
(1, '2024-07-03'),
(1, '2024-08-15'),
(1, '2024-09-01'),
(1, '2024-10-05'),
(1, '2024-11-01'),
(1, '2024-12-20'),
(2, '2024-01-01'),
(2, '2024-02-15'),
(2, '2024-04-01');

-- -----------------------------
-- Problem 13
-- Attendance (consecutive days)
-- -----------------------------
DROP TABLE IF EXISTS Attendance;
CREATE TABLE Attendance (
  emp_id INT,
  date DATE
);

INSERT INTO Attendance VALUES
(1, '2024-01-01'),
(1, '2024-01-02'),
(1, '2024-01-03'),
(1, '2024-01-05'),
(2, '2024-02-01'),
(2, '2024-02-02'),
(2, '2024-02-05'),
(3, '2024-03-10'),
(3, '2024-03-11'),
(3, '2024-03-12'),
(3, '2024-03-13');

-- -----------------------------
-- Problem 15
-- OrderDetails already created (used for total quantity/price)
-- -----------------------------

-- -----------------------------
-- Problem 21
-- Use Employee table for median salary per department
-- -----------------------------

-- -----------------------------
-- Problem 22
-- Orders table for order ID gaps
-- -----------------------------

-- -----------------------------
-- Problem 26
-- Projects / ProjectAssignments
-- -----------------------------
DROP TABLE IF EXISTS Project, ProjectAssignments;
CREATE TABLE Project (
  id INT PRIMARY KEY,
  name VARCHAR(100)
);

CREATE TABLE ProjectAssignments (
  project_id INT,
  employee_id INT
);

INSERT INTO Project VALUES
(1, 'Website Redesign'),
(2, 'Mobile App'),
(3, 'Data Migration'),
(4, 'Cloud Infra');

INSERT INTO ProjectAssignments VALUES
(1, 1),
(1, 2),
(2, 3),
(3, 4);

-- Project 4 has no employees assigned.

-- -----------------------------
-- Problem 27
-- Subscriptions
-- -----------------------------
DROP TABLE IF EXISTS Subscriptions;
CREATE TABLE Subscriptions (
  user_id INT,
  start_date DATE,
  cancel_date DATE
);

INSERT INTO Subscriptions VALUES
(1, '2024-01-01', '2024-01-05'),
(2, '2024-02-10', '2024-02-25'),
(3, '2024-03-01', NULL),
(4, '2024-04-01', '2024-04-10'),
(5, '2024-05-01', '2024-05-07');

-- -----------------------------
-- Problem 29
-- Monthly Sales (use Sales table with sale_date)
-- -----------------------------

-- -----------------------------
-- Problem 30
-- Manager hierarchy is in Employee table (self-reference)
-- -----------------------------

-- ============================================================
-- ✅ All tables and sample data inserted successfully!
-- You can now run the queries from the solution set.
-- ============================================================
