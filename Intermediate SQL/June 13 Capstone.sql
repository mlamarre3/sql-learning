orders

order_id | customer_id | order_date | total_amount | region |
-------------------------------------------------------------------------
customers

customer_id | first_name | last_name | signup_date | status | country |
-------------------------------------------------------------------------
products

product_id | product_name | category | price | in_stock |
-------------------------------------------------------------------------
order_items 

order_item_id | order_id | product_id | quantity | unit_price |
-------------------------------------------------------------------------
employees

employee_id | first_name | last_name | department | hire_date | salary |
-------------------------------------------------------------------------

1) List all products that cost more than $100 and are currently in stock.

SELECT product_name, price
FROM products
WHERE price > 100 AND in_stock = TRUE;

2) Count the number of customers who signed up in 2023.

SELECT COUNT(*) AS num_of_cust
FROM customers
WHERE signup_date BETWEEN '2023-01-01' AND '2023-12-31';

3) Return all employees who work in the “Sales” or “Marketing” department and earn more than $60,000.

SELECT employee_id, department
FROM employees
WHERE department IN('Sales','Marketing')
AND salary > 60000;

4) Show the number of orders placed per region.

SELECT region, COUNT(*) AS order_count
FROM orders 
GROUP BY region
ORDER BY order_count DESC;

5) Return the average order amount for all orders placed in 2022.

SELECT AVG(total_amount) AS avg_order_size
FROM orders
WHERE order_date BETWEEN '2022-01-01' AND '2022-12-31';

6) List the top 3 most expensive products in the "Electronics" category.

SELECT product_name, price
FROM products
WHERE category = 'Electronics' 
ORDER BY price DESC
LIMIT 3;

7) Which customers have placed more than 5 orders? Show customer ID and the count.

SELECT customer_id, COUNT(orders_id) AS order_count
FROM orders
GROUP BY customer_id
HAVING COUNT(order_id) > 5
ORDER BY order_count DESC;

8) For each product category, return the average unit price and total quantity sold.

SELECT category, AVG(order_items.unit_price) AS avg_unit_price, SUM(order_items.quantity) AS total_sold
FROM products
JOIN order_items
ON products.product_id = order_items.product_id
GROUP BY category
ORDER BY total_sold DESC;

9) Find all employees hired before 2015 whose salary is below the average salary of all employees.

SELECT employee_id, hire_date, salary
FROM employees
WHERE hire_date < '2015-01-01'
AND salary < (
    SELECT AVG(salary)
    FROM employees)
ORDER BY salary;

10) Return the customer ID, total amount spent, and number of orders for each customer — only include customers who spent more than $1,000 total.

SELECT customer_id, SUM(total_amount) AS amt_spent, COUNT(order_id) AS order_count
FROM orders
GROUP BY customer_id
HAVING SUM(total_amount) > 1000
ORDER BY order_count;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

orders

order_id | customer_id | order_date | total_amount | region |
-------------------------------------------------------------------------
customers

customer_id | first_name | last_name | signup_date | status | country |
-------------------------------------------------------------------------
products

product_id | product_name | category | price | in_stock |
-------------------------------------------------------------------------
order_items 

order_item_id | order_id | product_id | quantity | unit_price |
-------------------------------------------------------------------------
employees

employee_id | first_name | last_name | department | hire_date | salary |
-------------------------------------------------------------------------

11) Show each customer’s most recent order date, along with their total number of orders. Only include customers who have placed at least 3 orders.

SELECT customer_id, MAX(order_date) as most_recent_order, COUNT(order_id) AS order_count
FROM orders
GROUP BY customer_id
HAVING COUNT(order_id) >= 3
ORDER BY most_recent_order;

12) Which product categories have sold more than 500 total units and have an average unit price above $50?

SELECT products.category, SUM(order_items.quantity) AS total_sold, AVG(order_items.unit_price) AS avg_unit_price
FROM order_items
JOIN products
ON order_items.product_id = products.product_id
GROUP BY products.category
HAVING SUM(order_items.quantity) > 500
AND AVG(order_items.unit_price) > 50
ORDER BY total_sold DESC;

13) For each employee hired after 2015, calculate how much below or above the average salary they are. Show the employee''s name, department, and salary difference. Sort from most overpaid to most underpaid.

SELECT employee_id, department,
       CONCAT(first_name, ' ', last_name) AS name,
       (salary - (
        SELECT AVG(salary)
        FROM employees))
        AS salary_difference
FROM employees
WHERE hire_date >= '2016-01-01'
ORDER BY salary_difference DESC;

14) List all customers who have never placed an order but are marked as Active.

SELECT customer_id
FROM customers
LEFT JOIN orders 
ON customers.customer_id = orders.customer_id
WHERE orders.order_id IS NULL 
AND customers.status = 'Active';

15) Return each product''s name, how many times it was sold, and its total revenue. Only include products that have generated over $10,000 in total revenue.

SELECT products.product_name, COUNT(order_items.order_item_id) AS total_times_sold, SUM(order_items.price * order_items.quantity) AS total_revenue
FROM products
JOIN order_items
ON products.product_id = order_items.product_id
GROUP BY products.product_name
HAVING SUM(order_items.unit_price * order_items.quantity) > 10000
ORDER BY total_revenue DESC;