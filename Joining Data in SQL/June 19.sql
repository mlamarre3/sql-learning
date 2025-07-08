June 19

DataCamp problems

-- Select name fields (with alias) and region 
SELECT cities.name AS city, countries.name AS country, countries.region
FROM cities
INNER JOIN countries
ON cities.country_code = countries.code;

-- Select fields with aliases
SELECT c.code AS country_code, name, year, inflation_rate
FROM countries AS c
-- Join to economies (alias e)
INNER JOIN economies AS e
-- Match on code field using table aliases
ON c.code = e.code

SELECT c.name AS country, l.name AS language, official
FROM countries AS c
INNER JOIN languages AS l
-- Match using the code column
USING(code)

-- Select country and language name (aliased)
SELECT c.name AS country, l.name AS language
-- From countries (aliased)
FROM countries AS c
-- Join to languages (aliased)
INNER JOIN languages AS l
-- Use code as the joining field with the USING keyword
USING(code)
-- Filter for the Bhojpuri language
WHERE l.name = 'Bhojpuri';

SELECT name, e.year, fertility_rate, unemployment_rate
FROM countries AS c
INNER JOIN populations AS p
ON c.code = p.country_code
INNER JOIN economies AS e
ON c.code = e.code
-- Add an additional joining condition such that you are also joining on year
	AND e.year = p.year;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------

Chat GPT practice problems

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

1) Create a list of all official languages spoken in countries from Asia, along with the country name and continent. Sort the result by country name.

SELECT l.name AS language, c.country_name, c.continent
FROM countries AS c
INNER JOIN languages AS l
USING(code)
WHERE c.continent = 'Asia'
ORDER BY c.country_name

2) A manager wants to understand how urban a country is. Return a list of countries that have at least one city with a metropolitan population over 10 million. Include the country name and the city name.

SELECT c.name AS country, city.name AS city
INNER JOIN cities AS city
ON c.code = city.country_code
WHERE city.metroarea_pop > 10000000

3) For countries in Africa in the year 2010, return each country’s name, fertility rate, and total investment. Only include rows where both indicators are present and matched.

SELECT c.country_name AS country, p.fertility_rate, e.total_investment
FROM populations AS p
INNER JOIN economies AS e
ON p.country_code = e.code
AND p.year = e.year
INNER JOIN countries AS c
ON p.country_code = c.code
WHERE p.year = 2010
AND c.continent = 'Africa'

4) Find all countries that experienced inflation above 20% in any year. Return the country name, continent, year, and inflation rate. Sort by highest inflation first.

SELECT c.country_name AS country, c.continent, e.year, e.inflation_rate
FROM countries AS c
INNER JOIN economies AS e 
USING(code)
WHERE e.inflation_rate > 20
ORDER BY e.inflation_rate DESC

5) Which countries in the world do not have any cities listed in the cities dataset? Return only the country name and region.

SELECT c.country_name AS country, c.region, x.name
FROM countries AS c
LEFT JOIN cities AS x
ON c.code = x.country_code
WHERE x.name IS NULL