June 6

Table 1: employees
Columns: employee_id    first_name      last_name   department      salary      hire_date       manager_id      bonus

Table 2: products
Columns: product_id     product_name        category        price       stock_quantity      discontinued

Table 3: orders
Columns: order_id       customer_name       product_id      order_date      quantity        delivery_status

ROUND 1

1)                  2)                      3)                              4)                      5)
SELECT COUNT(*)     SELECT AVG(salary)      SELECT SUM(stock_quantity);     SELECT MAX(price)       SELECT MIN(bonus)
FROM employees;     FROM employees;         FROM products;                 FROM products;          FROM employees;

ROUND 2

6) 
SELECT AVG(salary)
FROM employees
WHERE department = 'Finance';

7)
SELECT SUM(stock_quantity)
FROM products
WHERE category = 'Furniture';

8)
SELECT COUNT(*)
FROM employees
WHERE salary > 60000;

9)
SELECT MAX(bonus)
FROM employees
WHERE department = 'Sales';

10) 
SELECT COUNT(*)
FROM orders
WHERE delivery_status = 'Delivered';

Table 1: employees
Columns: employee_id    first_name      last_name   department      salary      hire_date       manager_id      bonus

Table 2: products
Columns: product_id     product_name        category        price       stock_quantity      discontinued

Table 3: orders
Columns: order_id       customer_name       product_id      order_date      quantity        delivery_status

ROUND 3

11)
SELECT AVG(salary) AS avg_salary
FROM employees;

12)
SELECT SUM(bonus) AS total_bonus
FROM employees;

13)
SELECT (price * 1.10) AS price_with_increase
FROM products;

14)
SELECT (price * 0.80) AS discounted_price
FROM products;

15)
SELECT first_name, salary, (salary + COALESCE(bonus, 0)) AS total_compensation
FROM employees;

ROUND 4

16)
SELECT ROUND(AVG(salary))
FROM employees;

17) 
SELECT ROUND(SUM(price), -2)
FROM products;

18)
SELECT AVG(bonus)
FROM employees
WHERE bonus IS NOT NULL;

19)
SELECT SUM(salary + COALESCE(bonus, 0))
FROM employees;

20)
SELECT ROUND(AVG(stock_quantity), 1) 
FROM products
WHERE category IN('Electronics', 'Office');


Capstone (X is initially wrong although I went back and corrected them, good reference for what I trip up on)

people
| id  | first_name | last_name | gender | birthdate | country |

films
| id  | title | release_year | country | duration | genre |

reviews
| id  | reviewer_id | film_id | rating | review_date |

1) The studio wants to check how many films are over 2 hours long. Return the total count.

SELECT COUNT(*)
FROM films
WHERE (duration / 60.0) > 2;

2) The ratings team wants to see how many reviews were written before 2020. Provide the count.

SELECT COUNT(*)
FROM reviews
WHERE review_date < '2020-01-01';

3) Management wants to see which films are extremely short. Find all films with a duration less than 80 minutes.

SELECT title, duration
FROM films
WHERE duration < 80;

X 4) Finance wants to estimate production complexity. Show each film''s title and calculate its estimated "complexity score" as: duration * 3. Alias it as complexity_score.

SELECT title, (duration * 3) AS complexity_score
FROM films;

5) HR suspects there are reviewers without birthdates on file. Return a count of people where birthdate is missing.

SELECT COUNT(*) AS no_birthdate
FROM people
WHERE birthdate IS NULL;

X 6) The team wants to identify reviewers who were born before 1990.

SELECT * 
FROM people
WHERE birthdate < '1990-01-01';

X 7) The executive team is auditing high-value reviews. Return all reviews where the rating is either 4 or 5.

SELECT *
FROM reviews
WHERE rating IN (4,5);

X 8) The marketing team is analyzing foreign films. Find all films that are not from the United States.

SELECT *
FROM films
WHERE country <> 'United States';

9) Leadership is reviewing action movies. List the titles of films where the genre contains the word "Action" (in any position).

SELECT title AS action_movies
FROM films
WHERE genre LIKE '%Action%';

X 10) Quality control wants to check for suspiciously low ratings. Return all reviews where the rating is not between 2 and 5.

SELECT * AS low_ratings
FROM reviews
WHERE rating NOT BETWEEN 2 AND 5;

X 11) Legal wants to analyze reviewer gender demographics. Find all people where gender is neither "Male" nor "Female".

SELECT *
FROM people
WHERE gender NOT IN ('Male','Female');

12) Management wants a list of all films released after 2010 but before 2015.

SELECT * 
FROM films
WHERE release_year BETWEEN 2011 AND 2014;

13) Finance wants to estimate an "adjusted score" for each review by multiplying the rating by 1.2. Return reviewer_id and adjusted score.

SELECT reviewer_id, (rating * 1.2) AS adjusted_score
FROM reviews;

14) HR is doing a safety check for null values. Return all films where genre information is missing.

SELECT *
FROM films
WHERE genre IS NULL;

X 15) The executive team wants to review highly rated long movies. Find all films where duration is over 150 minutes and rating is greater than 4.
(Hint: you’ll need to join two tables here.)

SELECT *
FROM films
JOIN reviews
ON films.id = reviews.film_id
WHERE duration > 150
AND rating > 4;


Mistake Practice (4,6,7,8,10,11,15)

people
| id  | first_name | last_name | gender | birthdate | country |

films
| id  | title | release_year | country | duration | genre |

reviews
| id  | reviewer_id | film_id | rating | review_date |

1) Management wants to review any films released before the year 2005. Return the full film information for these movies.

SELECT *
FROM films
WHERE release_year < 2005;

2) Legal wants to identify reviewers who do not have "Male" or "Female" listed as their gender.

SELECT *
FROM people
WHERE gender NOT IN ('Male','Female');

3) The finance team wants to audit reviews that were submitted either before 2018 or after 2023.

SELECT *
FROM reviews
WHERE review_date NOT BETWEEN '2018-01-01' AND '2023-12-31';

4) Marketing wants a list of all films where genre is not listed or is missing entirely.

SELECT title
FROM films
WHERE genre IS NULL;

5) HR is analyzing the people table and wants to find everyone born before 1985.

SELECT *
FROM people
WHERE birthdate < '1985-01-01';

6) The executive team wants to identify highly rated reviews that are exactly 4 or 5. Show reviewer_id and rating.
Alias the rating column as high_rating.

SELECT reviewer_id, rating AS high_rating
FROM reviews
WHERE rating IN (4,5);

7) Leadership wants a list of all films that are not from either the United States, Canada, or the United Kingdom.

SELECT title
FROM films
WHERE country NOT IN ('United States','Canada','United Kingdom');

8) IT wants to calculate an "engagement score" for each review by multiplying rating by 2.5. Return reviewer_id, film_id,
and the engagement score (aliased as engagement_score).

SELECT reviewer_id, film_id, (rating * 2.5) AS engagement_score
FROM reviews;

9) Management wants to audit reviews where the rating falls outside the 2-to-5 range.

SELECT *
FROM reviews
WHERE rating NOT BETWEEN 2 AND 5;

10) The executive team wants to analyze long, highly-rated films. Show all films with duration over 140 minutes where there
exists at least one review with rating greater than 4. (You’ll need to JOIN two tables here.)

SELECT title
FROM films
JOIN reviews
ON films.id = reviews.film_id
WHERE duration > 140
AND rating > 4;
