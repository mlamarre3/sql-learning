June 5

Table 1: employees
Columns: employee_id    first_name      last_name   department      salary      hire_date       manager_id      bonus

Table 2: products
Columns: product_id     product_name        category        price       stock_quantity      discontinued

Table 3: orders
Columns: order_id       customer_name       product_id      order_date      quantity        delivery_status


1)                                          6)                                                    11)
SELECT *                                    SELECT first_name, department                         SELECT product_id
FROM employees                              FROM employees                                        FROM products
WHERE salary > 70000;                       WHERE department IN('HR','Finance','Sales');          WHERE product_name NOT LIKE('Laptop%');

2)                                          7)                                                    
SELECT employee_id AS Human_Resources       SELECT *
FROM employees                              FROM products
WHERE department = 'HR';                    WHERE product_name LIKE('Laptop%');

3)                                          8)
SELECT employee_id                          SELECT first_name, bonus
FROM employees                              FROM employees
WHERE bonus > 4000                          WHERE bonus BETWEEN 1000 AND 5000
    OR department = 'Sales';                AND bonus IS NOT NULL;

4)                                          9)
SELECT product_id                           SELECT first_name, salary, bonus
FROM products                               FROM employees
WHERE price                                 WHERE salary > 60000
BETWEEN 100 and 700;                        AND (department = 'Finance' OR bonus > 4000);

5)                                          10)
SELECT employee_id AS no_bonus              SELECT employee_id
FROM employees                              FROM employees
WHERE bonus IS NULL;                        WHERE bonus IS NULL OR bonus < 2000;

-----------------------------------------------------------------------------------------------------------------------------------------
Advanced Problems

Table 1: employees
Columns: employee_id    first_name      last_name   department      salary      hire_date       manager_id      bonus

Table 2: products
Columns: product_id     product_name        category        price       stock_quantity      discontinued

Table 3: orders
Columns: order_id       customer_name       product_id      order_date      quantity        delivery_status

12)                                                                             13)
SELECT first_name, department, bonus                                            SELECT customer_name, order_date
FROM employees                                                                  FROM orders
WHERE department IN('HR','Finance')                                             WHERE delivery_status IN('Pending','Cancelled')
AND bonus BETWEEN 3000 AND 6000                                                 AND order_date > '2024-03-01';
AND bonus IS NOT NULL;                                                          

14) 
SELECT product_id, product_name
FROM products
WHERE category <> 'Furniture'
AND category <> 'Electronics';

Can also be written as 
...
WHERE category NOT IN('Furniture', 'Electronics')

15) 
SELECT first_name, salary, department
FROM employees
WHERE salary > 50000
AND (department IN('IT','Finance') OR bonus > 4000)
AND department <> 'Sales';

16) 
SELECT employee_id, bonus
FROM employees
WHERE (bonus IS NULL OR bonus <= 3000)
AND department <> 'Finance';

17) 
SELECT product_name, price, stock_quantity
FROM products
WHERE category IN('Furniture','Office')
AND price BETWEEN 100 AND 600
AND stock_quantity > 5;

18) 
SELECT first_name, department, salary
FROM employees
WHERE department NOT IN('HR','Finance')
AND (salary BETWEEN 45000 AND 80000 OR bonus > 5000);


19)
SELECT product_id, product_name
FROM products
WHERE product_name LIKE('%Desk%')
AND product_name NOT LIKE('%Standing%');

20)
SELECT first_name, bonus
FROM employees
WHERE department IN('IT','Sales')
AND (bonus IS NULL OR bonus > 2000);

