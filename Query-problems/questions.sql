-- 1. Highest salary in each department (return employees)

    SELECT * FROM 
    (SELECT d.id, d.name, max(e.salary) as max_salary FROM EMPLOYEE e
    JOIN DEPARTMENT d
    ON e.department_id = d.id
    GROUP BY d.id) as temp
    JOIN employee
    ON employee.department_id = temp.id AND employee.salary = temp.max_salary

-- 2. Write a SQL query to find the second highest salary from the Employee table.
    SELECT * FROM Employee
    order by salary DESC
    LIMIT 1 OFFSET 2


-- 2. Customers Who never orderd

    SELECT * FROM CUSTOMERS
    WHERE id NOT IN  
    (SELECT customer_id FROM ORDERS);

    SELECT c.*
    FROM Customers c
    LEFT JOIN Orders o ON c.id = o.customer_id
    WHERE o.id IS NULL;

-- 3. Top 3 products by total sales
    SELECT products.name, s.total_sales FROM products 
    JOIN (SELECT product_id, SUM(quantity * price) as total_sales FROM Sales
    GROUP BY product_id LIMIT 3) s ON s.product_id = products.id

    SELECT p.id, p.name, SUM(s.quantity * s.price) AS total_sales
    FROM Products p
    JOIN Sales s ON p.id = s.product_id
    GROUP BY p.id, p.name
    ORDER BY total_sales DESC
    LIMIT 3;

-- 4. Average salary by department
    SELECT d.id, d.name, ROUND(AVG(e.salary), 2) FROM Employee e
    JOIN Department d
    ON e.department_id = d.id
    GROUP BY d.id


-- 5. Rank employees by salary per department
SELECT *,
RANK() OVER(PARTITION BY department_id ORDER BY salary DESC) as Salary_rank
FROM Employee

-- 6. Find duplicate emails
SELECT email, count(*) FROM Person
GROUP BY email
HAVING COUNT(*) > 1


-- 7. Delete Duplicates
/* 1 - */
WITH duplicates AS (
  SELECT id,
         ROW_NUMBER() OVER (PARTITION BY col1, col2, col3 ORDER BY id) AS rn
  FROM MyTable
)
DELETE FROM MyTable
WHERE id IN /* 2 - */(SELECT id FROM duplicates WHERE rn > 1);

/* 
    1. PARTITION BY col1, col2, col3 → Groups rows having the same values for these columns.
    ORDER BY id → Decides which record in each group is “first”.
    ROW_NUMBER() → Assigns a unique sequential number starting from 1 within each group.
    So, for each group of duplicates:
    The first occurrence (lowest id) gets rn = 1
    The extra duplicates get rn = 2, 3, ...

    2. This subquery fetches all the ids of duplicate rows 
    (i.e., where there’s more than one record for the same (col1, col2, col3)).
 */


-- 8. Employees Earning More Than Their Manager
SELECT e.name,  m.name as m_name, e.salary, m.salary as m_salary FROM Employee e
JOIN Employee m
ON e.manager_id = m.id
WHERE e.salary > m.salary;

-- 9. Department with Highest Average Salary
SELECT Department.name, Department.id, e.max FROM (SELECT AVG(salary) as max, department_id FROM EMPLOYEE
GROUP BY department_id 
ORDER BY max DESC
LIMIT 1 ) e
JOIN Department
ON Department.id = e.department_id

-- 10. -- Monthly Sales Summary
SELECT COUNT(*), MONTH(order_date),  YEAR(order_date), SUM(amount) 
FROM ORDERS
GROUP BY YEAR(order_date), MONTH(order_date)

SELECT DATE_FORMAT(order_date, '%Y-%m') AS month, SUM(amount) AS total_sales
FROM Orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY month;

-- Find Active Users Every Month
SELECT COUNT(user_id), MONTH(login_date) FROM Logins
GROUP BY MONTH(login_date)


-- Find Active Users Every Month
SELECT COUNT(DISTINCT MONTH(login_date)) as lg_count, user_id FROM Logins
GROUP BY user_id
HAVING lg_count = 12


SELECT c.name, a.total FROM (SELECT customer_id, SUM(amount) as total FROM Orders
GROUP BY customer_id) a
JOIN customers c
on c.id = a.customer_id

-- Total spending by each customer
SELECT c.id, c.name, COALESCE(SUM(o.amount),0) AS total_spent
FROM Customers c
LEFT JOIN Orders o ON c.id = o.customer_id
GROUP BY c.id, c.name;

-- Order Details Summary
SELECT od.order_id, SUM(od.quantity) , SUM(od.price)
FROM  OrderDetails od
GROUP BY od.order_id;


-- Products never sold
SELECT * FROM Products p
WHERE p.id NOT IN (SELECT DISTINCT product_id FROM Sales)

SELECT p.id, p.name
FROM Products p
LEFT JOIN Sales s ON p.id = s.product_id
WHERE s.product_id IS NULL;

-- Managers with more than 5 direct reports
SELECT manager_id, COUNT(*) FROM Employee
GROUP BY manager_id
HAVING COUNT(*) > 5

-- Most recent order per customer
SELECT MAX(order_date), customer_id FROM Orders
GROUP BY customer_id

-- Most purchased product category
SELECT c.name, d.total_produxts FROM 
(SELECT p.category_id, SUM(od.total_quan) as total_produxts FROM Products p
JOIN 
(SELECT o.product_id, SUM(o.quantity) as total_quan FROM OrderDetails o
GROUP BY o.product_id) od
ON od.product_id = p.id
GROUP BY p.category_id) d
JOIN categories c
ON c.id = d.category_id
ORDER BY total_produxts DESC
LIMIT 1

SELECT p.category_id, c.name, SUM(od.quantity) AS total_qty
FROM OrderDetails od
JOIN Products p ON od.product_id = p.id
LEFT JOIN Categories c ON p.category_id = c.id
GROUP BY p.category_id, c.name
ORDER BY total_qty DESC
LIMIT 1;

-- SELECT * FROM Subscriptions
SELECT * FROM Subscriptions
WHERE cancel_date < DATE_ADD(start_date, INTERVAL 7 DAY)

-- Find Top 2 Salaries per Department
SELECT * FROM (SELECT id, department_id, salary,
ROW_NUMBER() OVER(PARTITION BY department_id ORDER BY salary DESC ) as rn
FROM Employee) a
WHERE a.rn <= 2