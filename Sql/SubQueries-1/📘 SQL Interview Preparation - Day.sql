📘 SQL Interview Preparation - Day 1
Topic: Subqueries (Basic Level)
Database Setup
Customers Table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50)
);

INSERT INTO Customers VALUES
(1, 'Sai', 'Hyderabad'),
(2, 'Ravi', 'Bangalore'),
(3, 'Priya', 'Chennai'),
(4, 'Kiran', 'Mumbai'),
(5, 'Anu', 'Delhi');
Orders Table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_amount DECIMAL(10,2),
    order_date DATE
);

INSERT INTO Orders VALUES
(101, 1, 1500, '2025-01-10'),
(102, 2, 2500, '2025-01-12'),
(103, 1, 3000, '2025-01-15'),
(104, 3, 1800, '2025-01-18'),
(105, 4, 5000, '2025-01-20'),
(106, 2, 3500, '2025-01-22'),
(107, 5, 1200, '2025-01-25'),
(108, 3, 4000, '2025-01-28'),
(109, 4, 2800, '2025-02-01'),
(110, 1, 4500, '2025-02-05');
Question 1
Find orders whose amount is greater than the average order amount.
Approach
Calculate the average order amount.
Compare each order amount with the average.
Query
SELECT order_id,
       order_amount
FROM Orders
WHERE order_amount >
(
    SELECT AVG(order_amount)
    FROM Orders
);
Concepts Used
Subquery
AVG()
Comparison Operator (>)
Question 2
Find the order having the highest order amount.
Approach
Find the maximum order amount.
Return the order having that amount.
Query
SELECT order_id,
       order_amount
FROM Orders
WHERE order_amount =
(
    SELECT MAX(order_amount)
    FROM Orders
);
Concepts Used
Subquery
MAX()
Comparison Operator (=)
Question 3
Find customers who placed at least one order.
Approach
Get all customer IDs from Orders.
Find matching customers.
Query
SELECT customer_id,
       customer_name
FROM Customers
WHERE customer_id IN
(
    SELECT customer_id
    FROM Orders
);
Concepts Used
IN Operator
Subquery Returning Multiple Values
Question 4
Find orders whose amount is greater than Sai's average order amount.
Approach
Find Sai's customer_id.
Calculate Sai's average order amount.
Compare all orders against that average.
Query
SELECT order_id,
       order_amount
FROM Orders
WHERE order_amount >
(
    SELECT AVG(order_amount)
    FROM Orders
    WHERE customer_id =
    (
        SELECT customer_id
        FROM Customers
        WHERE customer_name = 'Sai'
    )
);
Concepts Used
Nested Subquery
AVG()
Multiple Levels of Subqueries
Question 5
Find customers who have not placed any orders.
Approach
Get customer IDs that placed orders.
Exclude those customers.
Query
SELECT customer_id,
       customer_name
FROM Customers
WHERE customer_id NOT IN
(
    SELECT customer_id
    FROM Orders
);
Concepts Used
NOT IN
Subquery Returning Multiple Values
Today's Learning Summary
Operator	When to Use	Example
=	Single Value	MAX(), MIN()
>	Compare with Single Value	AVG()
<	Compare with Single Value	AVG()
IN	Multiple Values	List of IDs
NOT IN	Excluding Values	Missing IDs
Interview Tips
Rule 1

Use = when the subquery returns exactly one value.

SELECT *
FROM Orders
WHERE order_amount =
(
    SELECT MAX(order_amount)
    FROM Orders
);
Rule 2

Use IN when the subquery returns multiple rows.

SELECT *
FROM Customers
WHERE customer_id IN
(
    SELECT customer_id
    FROM Orders
);
Rule 3

Always compare related columns.

✅ Correct

customer_id IN
(
    SELECT customer_id
    FROM Orders
)

❌ Wrong

customer_id IN
(
    SELECT order_id
    FROM Orders
)

Homework
Q6

Find the order having the minimum order amount.

Q7

Find orders whose amount is less than the average order amount.

Q8

Find customers from Hyderabad who placed at least one order.

Q9

Find orders placed by Ravi.

Q10

Find customers whose total order amount is greater than 5000.