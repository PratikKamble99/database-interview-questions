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


-- 2. Customers Who never ordered

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
SELECT e.name,  m.name as m_name, e.salary, m.salary as m_salary 
FROM Employee e
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

-- Nth Highest Salary --
-- https://leetcode.com/problems/nth-highest-salary/description/

CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  RETURN (
      # Write your MySQL query statement below.
    SELECT salary FROM (
        SELECT salary,
        dense_rank() OVER(ORDER BY salary DESC) as rnk
        FROM Employee
    ) t
    WHERE rnk=N
    LIMIT 1
  );
END

-- Rank Scores -- 

/* 
    Table: Scores

    +-------------+---------+
    | Column Name | Type    |
    +-------------+---------+
    | id          | int     |
    | score       | decimal |
    +-------------+---------+
    id is the primary key (column with unique values) for this table.
    Each row of this table contains the score of a game. Score is a floating point value with two decimal places.
    

    Write a solution to find the rank of the scores. The ranking should be calculated according to the following rules:

    The scores should be ranked from the highest to the lowest.
    If there is a tie between two scores, both should have the same ranking.
    After a tie, the next ranking number should be the next consecutive integer value. In other words, there should be no holes between ranks.
    Return the result table ordered by score in descending order.
 */

SELECT Score ,
dense_rank() OVER( ORDER BY score DESC) as "rank"
FROM Scores


-- Department Top Three Salaries --
/* 
    Table: Employee

    +--------------+---------+
    | Column Name  | Type    |
    +--------------+---------+
    | id           | int     |
    | name         | varchar |
    | salary       | int     |
    | departmentId | int     |
    +--------------+---------+
    id is the primary key (column with unique values) for this table.
    departmentId is a foreign key (reference column) of the ID from the Department table.
    Each row of this table indicates the ID, name, and salary of an employee. It also contains the ID of their department.
    

    Table: Department

    +-------------+---------+
    | Column Name | Type    |
    +-------------+---------+
    | id          | int     |
    | name        | varchar |
    +-------------+---------+
    id is the primary key (column with unique values) for this table.
    Each row of this table indicates the ID of a department and its name.
    

    A company's executives are interested in seeing who earns the most money in each of the company's departments. A high earner in a department is an employee who has a salary in the top three unique salaries for that department.
 */

SELECT d.name as Department, t.name as Employee, t.salary as Salary/* , t.rn */
FROM (SELECT name, salary,
departmentId,
dense_rank() OVER (PARTITION BY departmentId ORDER BY salary DESC) as "rn"
FROM Employee e) t
JOIN Department d
ON t.departmentId = d.id
WHERE t.rn <= 3

-- Consecutive Numbers --
/* 
    Table: Logs

    +-------------+---------+
    | Column Name | Type    |
    +-------------+---------+
    | id          | int     |
    | num         | varchar |
    +-------------+---------+
    In SQL, id is the primary key for this table.
    id is an autoincrement column starting from 1.
    

    Find all numbers that appear at least three times consecutively.
 */

SELECT DISTINCT(num) as ConsecutiveNums 
FROM (SELECT
    num,
    LAG(num, 1) OVER (ORDER BY id) AS prev1,
    LAG(num, 2) OVER (ORDER BY id) AS prev2
FROM Logs) t
WHERE num = prev1 AND num = prev2

-- Rising Temperature --
/* 
    Table: Weather

    +---------------+---------+
    | Column Name   | Type    |
    +---------------+---------+
    | id            | int     |
    | recordDate    | date    |
    | temperature   | int     |
    +---------------+---------+
    id is the column with unique values for this table.
    There are no different rows with the same recordDate.
    This table contains information about the temperature on a certain day.
    
    Write a solution to find all dates' id with higher temperatures compared to its previous dates (yesterday).
 */

SELECT w.id as Id
FROM Weather w
JOIN Weather pw
on w.recordDate = DATE_ADD(pw.recordDate, INTERVAL 1 DAY)
WHERE w.temperature > pw.temperature;

-- Trips and Users: https://leetcode.com/problems/trips-and-users/description/ --
SELECT /* COUNT(id), */ request_at as Day, ROUND(AVG(status != "completed") ,2) as Cancellation_Rate
FROM Trips t
JOIN Users c ON c.users_id = t.client_id AND c.banned = "No"
JOIN Users d ON d.users_id = t.driver_id AND d.banned = "No"
WHERE request_at BETWEEN '2013-10-01' AND '2013-10-03'
GROUP BY request_at 
ORDER BY request_at 

-- Sales Analysis III: https://leetcode.com/problems/sales-analysis-iii --
SELECT p.product_id , p.product_name FROM sales s
JOIN Product p 
ON p.product_id = s.product_id
GROUP BY p.product_id
HAVING
    MIN(s.sale_date) >= '2019-01-01'
    AND MAX(s.sale_date) <= '2019-03-31';