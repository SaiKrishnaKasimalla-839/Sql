# 📘 SQL Interview Preparation – Day 2

## Topic: EXISTS, NOT EXISTS, GROUP BY, HAVING & Nested Subqueries

---

# 🎯 Learning Objectives

By the end of today's practice, you should understand:

* EXISTS
* NOT EXISTS
* Correlated Subqueries
* GROUP BY
* HAVING
* Aggregate Functions (SUM, COUNT)
* Nested Subqueries with GROUP BY

---

# Database Used

## Customers

| customer_id | customer_name | city      |
| ----------- | ------------- | --------- |
| 1           | Sai           | Hyderabad |
| 2           | Ravi          | Bangalore |
| 3           | Priya         | Chennai   |
| 4           | Kiran         | Mumbai    |
| 5           | Anu           | Delhi     |
| 6           | Rahul         | Pune      |
| 7           | Deepa         | Hyderabad |

---

## Orders

| order_id | customer_id | order_amount |
| -------- | ----------- | -----------: |
| 101      | 1           |         1500 |
| 102      | 2           |         2500 |
| 103      | 1           |         3000 |
| 104      | 3           |         1800 |
| 105      | 4           |         5000 |
| 106      | 2           |         3500 |
| 107      | 5           |         1200 |
| 108      | 3           |         4000 |
| 109      | 4           |         2800 |
| 110      | 1           |         4500 |

---

# Question 1

## Find customers who have placed at least one order.

### Solution

```sql
SELECT customer_name
FROM Customers c
WHERE EXISTS
(
    SELECT 1
    FROM Orders o
    WHERE o.customer_id = c.customer_id
);
```

### Concept

* EXISTS
* Correlated Subquery

---

# Question 2

## Find customers who have never placed any order.

### Solution

```sql
SELECT customer_name
FROM Customers c
WHERE NOT EXISTS
(
    SELECT 1
    FROM Orders o
    WHERE o.customer_id = c.customer_id
);
```

### Concept

* NOT EXISTS
* Correlated Subquery

---

# Question 3

## Find customers who have placed at least one order greater than 3000.

### Solution

```sql
SELECT customer_name
FROM Customers c
WHERE EXISTS
(
    SELECT 1
    FROM Orders o
    WHERE o.customer_id = c.customer_id
      AND o.order_amount > 3000
);
```

### Concept

* EXISTS
* Correlated Subquery
* Multiple Conditions

---

# Question 4

## Find customers who have placed more than one order.

### Solution

```sql
SELECT customer_name
FROM Customers c
WHERE EXISTS
(
    SELECT 1
    FROM Orders o
    WHERE o.customer_id = c.customer_id
    GROUP BY o.customer_id
    HAVING COUNT(*) > 1
);
```

### Concept

* EXISTS
* GROUP BY
* HAVING
* COUNT(*)

---

# Question 5 (Interview Level)

## Find customers whose total order amount is greater than the average total order amount of all customers.

### Solution

```sql
SELECT customer_id,
       SUM(order_amount) AS total_amount
FROM Orders
GROUP BY customer_id
HAVING SUM(order_amount) >
(
    SELECT AVG(total_amount)
    FROM
    (
        SELECT customer_id,
               SUM(order_amount) AS total_amount
        FROM Orders
        GROUP BY customer_id
    ) AS customer_totals
);
```

### Concept

* GROUP BY
* SUM()
* HAVING
* Nested Subquery
* Derived Table

---

# Important Concepts Learned Today

## EXISTS

Returns TRUE if the subquery returns at least one row.

```sql
WHERE EXISTS
(
    SELECT 1
    FROM Orders
    WHERE ...
);
```

---

## NOT EXISTS

Returns TRUE if the subquery returns no rows.

```sql
WHERE NOT EXISTS
(
    SELECT 1
    FROM Orders
    WHERE ...
);
```

---

## GROUP BY

Groups rows based on a column.

```sql
SELECT customer_id,
       SUM(order_amount)
FROM Orders
GROUP BY customer_id;
```

---

## HAVING

Filters groups after aggregation.

```sql
SELECT customer_id,
       SUM(order_amount)
FROM Orders
GROUP BY customer_id
HAVING SUM(order_amount) > 3000;
```

---

# WHERE vs HAVING

| WHERE                                     | HAVING                      |
| ----------------------------------------- | --------------------------- |
| Filters rows                              | Filters groups              |
| Before GROUP BY                           | After GROUP BY              |
| Cannot use SUM(), COUNT(), AVG() directly | Can use aggregate functions |

---

# EXISTS vs IN

| EXISTS                          | IN                                 |
| ------------------------------- | ---------------------------------- |
| Checks if a matching row exists | Checks if a value exists in a list |
| Returns TRUE/FALSE              | Returns a list of values           |
| Best for correlated subqueries  | Best for simple subqueries         |
| Stops after the first match     | Processes the returned list        |

---

# Common Mistakes

### ❌ Wrong

```sql
FROM Customers
NOT EXISTS (...)
```

### ✅ Correct

```sql
FROM Customers
WHERE NOT EXISTS (...)
```

---

### ❌ Wrong

```sql
GROUP BY customer_id
WHERE order_amount > 3000
```

### ✅ Correct

```sql
WHERE order_amount > 3000
GROUP BY customer_id
```

---

### ❌ Wrong

```sql
WHERE SUM(order_amount) > 3000
```

### ✅ Correct

```sql
HAVING SUM(order_amount) > 3000
```

---

# SQL Execution Order

1. FROM
2. WHERE
3. GROUP BY
4. HAVING
5. SELECT
6. ORDER BY

---

# Interview Tips

✅ Use `EXISTS` when checking whether at least one matching row exists.

✅ Use `GROUP BY` to group related rows.

✅ Use `HAVING` to filter aggregated results.

✅ Use a derived table when an aggregate function (like `AVG`) must operate on grouped results.

---

# LeetCode Practice

### Completed

* ✅ LeetCode #183 – Customers Who Never Order

### Recommended Next

* LeetCode #176 – Second Highest Salary
* LeetCode #184 – Department Highest Salary

---

# Today's Revision Checklist

* [x] EXISTS
* [x] NOT EXISTS
* [x] Correlated Subquery
* [x] GROUP BY
* [x] HAVING
* [x] COUNT()
* [x] SUM()
* [x] Nested Subquery
* [x] Derived Table

---

# Tomorrow's Topics (Day 3)

* Scalar Subqueries vs Correlated Subqueries
* Second Highest Salary
* Nth Highest Salary
* MAX() with Subqueries
* MIN() with Subqueries
* LeetCode #176
* LeetCode #184
