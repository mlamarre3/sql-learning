July 2

DataCamp Problems

SELECT DISTINCT name
FROM languages
-- Add syntax to use bracketed subquery below as a filter
WHERE code IN
    (SELECT code
    FROM countries
    WHERE region = 'Middle East')
ORDER BY name;

SELECT code, name
FROM countries
WHERE continent = 'Oceania'
-- Filter for countries not included in the bracketed subquery
  AND code NOT IN
    (SELECT code
    FROM currencies);

    SELECT *
FROM populations
WHERE year = 2015
-- Filter for only those populations where life expectancy is 1.15 times higher than average
  AND life_expectancy > 1.15 * 
  (SELECT AVG(life_expectancy)
   FROM populations
   WHERE year = 2015);

   -- Select relevant fields from cities table
SELECT name, country_code, urbanarea_pop
FROM cities
-- Filter using a subquery on the countries table
WHERE name IN
    (SELECT capital
    FROM countries)
ORDER BY urbanarea_pop DESC;

-- Find top nine countries with the most cities
SELECT countries.name AS country, COUNT(*) AS cities_num
FROM countries
LEFT JOIN cities
ON countries.code = cities.country_code
GROUP BY countries.name
-- Order by count of cities as cities_num
ORDER BY cities_num DESC
-- Limit the results
LIMIT 9;

SELECT countries.name AS country,
-- Subquery that provides the count of cities   
  (SELECT COUNT(*)
   FROM cities
   WHERE cities.country_code = countries.code) AS cities_num
FROM countries
ORDER BY cities_num DESC, country
LIMIT 9;

-- Select local_name and lang_num from appropriate tables
SELECT countries.local_name, sub.lang_num
FROM countries,
  (SELECT code, COUNT(*) AS lang_num
  FROM languages
  GROUP BY code) AS sub
-- Where codes match
WHERE countries.code = sub.code
ORDER BY lang_num DESC;

-- Select relevant fields
SELECT e.code, e.inflation_rate, e.unemployment_rate
FROM economies AS e
WHERE year = 2015 
  AND code IN
-- Subquery returning country codes filtered on gov_form
	(SELECT code
  FROM countries
  WHERE gov_form LIKE '%Monarchy%' OR gov_form LIKE '%Republic%')
ORDER BY inflation_rate;

-- Select fields from cities
SELECT name, 
    country_code, 
    city_proper_pop, 
    metroarea_pop, 
    city_proper_pop / metroarea_pop * 100 AS city_perc
FROM cities,
-- Use subquery to filter city name
(SELECT capital
FROM countries
WHERE continent = 'Europe'
OR continent LIKE '%America%') AS capitals
WHERE cities.name = capitals.capital
-- Add filter condition such that metroarea_pop does not have null values
AND metroarea_pop IS NOT NULL
-- Sort and limit the result
ORDER BY city_perc DESC
LIMIT 10;

ChatGPT 

countries

code | country_name | continent | region | surface_area | indep_year | gov_form | capital | cap_long | cap_lat |

languages
 
lang_id | code | name | percent | official |

cities 

name | country_code | city_proper_pop | metroarea_pop | urbanarea_pop |

economies

econ_id | code | year | income_group | gdp_percapita | gross_savings | infaltion_rate | total_investment | unemployment_rate | exports | imports |

populations

pop_id | country_code | year | fertility_rate | life_expectancy | size |

🔷 1. Urban Core Leaders
Find the 10 cities where the urban area population makes up the highest percentage of the metro area population.
Only include cities in capital cities of countries located in Africa or Asia. Return city name, country code, urban %, and sort by percentage descending.

SELECT name, 100 * urbanarea_pop / metroarea_pop AS urban_%
FROM cities
WHERE name IN(
    SELECT capital
    FROM countries
    WHERE continent IN ('Africa', 'Asia')
)
ORDER BY urban_% DESC
LIMIT 10;

🔷 2. Language Saturation
Which countries have more than 5 total languages listed in the languages table? Return the country name and number of languages.
Use a subquery inside the SELECT clause.

SELECT country_name, (
    SELECT COUNT(*)
    FROM languages
    WHERE languages.code = countries.code
) AS lang_num
FROM countries
WHERE (
    SELECT COUNT(*) 
    FROM languages
    WHERE languages.code = countries.code) > 5;



🔷 3. Unmatched Inflation
Find all countries that are Constitutional Monarchies but do not have any inflation_rate recorded in the year 2015.
Return the country name and government form.

SELECT country_name, gov_form
FROM countries
WHERE gov_form = 'Constitutional Monarchy'
AND code NOT IN (
    SELECT code 
    FROM economies
    WHERE year = 2015
);


🔷 4. City Concentration in Oceania
Return all countries in Oceania where at least one of its cities accounts for more than 70% of its largest metro area population.
Return country name and city name. Use a subquery to compare city proper to metro area size.

SELECT c.country_name, ci.name
FROM countries AS c
JOIN cities AS ci
ON c.code = ci.country_code
WHERE c.continent = 'Oceania'
AND 1.0 * city_proper_pop / metroarea_pop > 0.7
AND metroarea_pop IS NOT NULL;

🔷 5. Above-Average Survivors
In 2015, which countries had a life expectancy that was greater than the average across all countries that year?
Return country name, life expectancy, and region.

SELECT c.name, p.life_expectancy, c.region
FROM countries AS c
LEFT JOIN populations AS p
ON c.code = p.country_code
WHERE p.year = 2015
AND p.life_expectancy > (
    SELECT AVG(life_expectancy)
    FROM populations
    WHERE year = 2015
);

