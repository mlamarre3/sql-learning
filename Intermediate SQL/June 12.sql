June 12

films

id | title | release_year | country | duration | genre |

people

id | first_name | last_name | gender | birthdate | country | 

reviews

id | reviewer_id | film_id | rating | review_date |

1) The studio wants a list of genres and the average duration of films in each. Show the genre and average duration.

SELECT genre, AVG(duration) AS avg_duration
FROM films
GROUP BY genre
ORDER BY avg_duration;

2) List all film countries that have released more than 5 films.

SELECT country, COUNT(DISTINCT(*)) AS film_count
FROM films
GROUP BY country
HAVING COUNT(DISTINCT(title)) > 5;


3) Management wants to see the number of reviews per reviewer. Include reviewer ID and review count.

SELECT reviewer_id, COUNT(DISTINCT(*)) AS review_count
FROM reviews
GROUP BY review_id
ORDER BY review_count DESC;

4) Marketing wants to identify genres with an average film duration above 110 minutes.

SELECT genre, AVG(duration)
FROM films
GROUP BY genre
HAVING AVG(duration) > 110;

5) List all reviewers who have written more than 3 reviews with an average rating below 3.5.

SELECT reviewer_id, COUNT(DISTINCT(*)) AS review_count, AVG(rating) as avg_rating
FROM reviews
GROUP BY reviewer_id
HAVING COUNT(DISTINCT(id)) > 3 AND AVG(rating) < 3.5;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

films

id | title | release_year | country | duration | genre |

people

id | first_name | last_name | gender | birthdate | country | 

reviews

id | reviewer_id | film_id | rating | review_date |

6) Which genres have films over 2 hours long on average and also have more than 3 films?

SELECT genre, AVG(duration) AS avg_duration, COUNT(*) AS film_count
FROM films
GROUP BY genre
HAVING AVG(duration) > 120 AND COUNT(*) > 3;

7) The team wants to know the most common film duration. Find the duration and how many films have that exact length. Return only the top result.

SELECT duration, COUNT(*) as film_count
FROM films
GROUP BY duration
ORDER BY film_count DESC
LIMIT 1;

8) Provide a list of years with the average film rating. Only include years where the average rating is at least 4 and at least 5 reviews were submitted that year.

SELECT release_year, AVG(rating) AS avg_rating
FROM films
LEFT JOIN reviews
ON films.id = reviews.film_id
GROUP BY release_year
HAVING AVG(rating) >= 4 AND COUNT(*) >= 5
ORDER BY avg_rating DESC;

9) The studio wants to know which countries are consistently producing highly rated films. Find the average rating for films grouped by country, only include 
    those where average rating > 4 and number of reviewed films is at least 3.

SELECT country, AVG(rating) as avg_rating, COUNT(DISTINCT films.id) AS film_count
FROM films
JOIN reviews
ON films.id = reviews.film_id
GROUP BY country
HAVING AVG(rating) > 4 AND COUNT(DISTINCT films.id) >= 3
ORDER BY film_count DESC;

10) Find all reviewers who gave a perfect 5-star review to more than one film. Return reviewer ID and how many perfect scores they gave.

SELECT reviewer_id, COUNT(DISTINCT film_id) AS film_count
FROM reviews
WHERE rating = 5
GROUP BY reviewer_id
HAVING COUNT(DISTINCT film_id) > 1
ORDER BY film_count DESC;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

films

id | title | release_year | country | duration | genre |

people

id | first_name | last_name | gender | birthdate | country | 

reviews

id | reviewer_id | film_id | rating | review_date |

11) Show each genre and its average film duration, average rating, and total number of reviews — only include genres with more than 5 reviews total.

SELECT genre, AVG(films.duration) AS avg_duration, AVG(reviews.rating) AS avg_rating, COUNT(DISTINCT reviews.id) AS review_count
FROM films
JOIN reviews
ON films.id = reviews.film_id
GROUP BY genre
HAVING COUNT(DISTINCT reviews.id) > 5
ORDER BY avg_rating DESC;

12) Return the top 3 countries by average rating of their films (only if the country has at least 5 films and those films have been reviewed).

SELECT country, AVG(rating) as avg_rating
FROM films
JOIN reviews
ON films.id = reviews.film_id
GROUP BY country
HAVING COUNT(DISTINCT films.id) > 5
ORDER BY avg_rating DESC
LIMIT 3;

13) Which release year had the most reviews, and what was the average rating in that year?

SELECT release_year, COUNT(reviews.id) AS review_count, AVG(rating) AS avg_rating
FROM films
JOIN reviews
ON films.id = reviews.film_id
GROUP BY release_year
ORDER BY review_count DESC
LIMIT 1;

14) Which reviewer has reviewed films in the greatest number of distinct genres?

SELECT reviewer_id, COUNT(DISTINCT films.genre) AS genre_count
FROM reviews
LEFT JOIN films
ON reviews.film_id = films.id
GROUP BY reviewer_id
ORDER BY genre_count DESC
LIMIT 1;

15) The studio wants to reward loyal reviewers. Find the top 5 reviewers by number of reviews submitted. Break ties using average rating (higher comes first).

SELECT reviewer_id, AVG(rating) AS avg_rating, COUNT(DISTINCT id) as review_count
FROM reviews
GROUP BY reviewer_id
ORDER BY review_count DESC, avg_rating DESC
LIMIT 5;