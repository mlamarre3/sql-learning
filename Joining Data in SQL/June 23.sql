June 20

DataCamp Problems

Outer Joins, Self Joins, Cross Joins

SELECT c.name AS country, local_name, l.name AS language, percent
FROM countries AS c 
LEFT JOIN languages AS l 
USING(code)
ORDER BY country DESC

SELECT 
	c1.name AS city, 
    code, 
    c2.name AS country,
    region, 
    city_proper_pop
FROM cities AS c1
-- Join right table (with alias)
LEFT JOIN countries AS c2
ON c1.country_code = c2.code
ORDER BY code DESC;

SELECT region, AVG(gdp_percapita) AS avg_gdp
FROM countries AS c
LEFT JOIN economies AS e
USING(code)
WHERE year = 2010
GROUP BY region
-- Order by descending avg_gdp
ORDER BY avg_gdp DESC
-- Return only first 10 records
LIMIT 10;

-- Modify this query to use RIGHT JOIN instead of LEFT JOIN
SELECT countries.name AS country, languages.name AS language, percent
FROM languages
RIGHT JOIN countries
USING(code)
ORDER BY language;

SELECT 
	c1.name AS country, 
    region, 
    l.name AS language,
	basic_unit, 
    frac_unit
FROM countries as c1 
-- Full join with languages (alias as l)
FULL JOIN languages AS l 
USING(code)
-- Full join with currencies (alias as c2)
FULL JOIN currencies AS c2
USING(code) 
WHERE region LIKE 'M%esia';

SELECT 
	c.name AS country,
    region,
    life_expectancy AS life_exp
FROM countries AS c
-- Join to populations (alias as p) using an appropriate join
INNER JOIN populations AS p 
ON c.code = p.country_code
-- Filter for only results in the year 2010
WHERE year = 2010
-- Sort by life_exp
ORDER BY life_exp
-- Limit to five records
LIMIT 5;

SELECT 
	p1.country_code, 
    p1.size AS size2010, 
    p2.size AS size2015
FROM populations AS p1
INNER JOIN populations AS p2
ON p1.country_code = p2.country_code
WHERE p1.year = 2010
-- Filter such that p1.year is always five years before p2.year
    AND p2.year = 2015

----------------------------------------------------------------------------------------------------------------------------------------

Chat GPT Problems

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


1) Growth Check
We want to analyze population growth. For every country with both 2010 and 2015 population data, return the country name,
its 2010 population, 2015 population, and the absolute difference. Sort by the biggest population increases first.

SELECT c.name, 
        p1.size AS size2010, 
        p2.size AS size2015, 
        (p2.size - p1.size) AS pop_chg
FROM populations AS p1
JOIN countries AS c
ON p1.country_code = c.code
INNER JOIN populations AS p2
ON p1.country_code = p2.country_code
    AND p1.year = 2010 
    AND p2.year = 2015
ORDER BY pop_chg DESC;

2) Currency Completeness
Some countries don’t have complete currency information in our system. Return a list of all countries and the names of 
both their basic and fractional currency units. Include countries even if no currency data exists.

SELECT c.name, 
        cur.basic_unit,
        cur.frac_unit
FROM countries c
LEFT JOIN currencies as cur
USING(code);


3) Gaps in Economic Data
In 2010, we expected every country to have economic data, but some dont. 
Return a list of countries that are missing gdp_percapita data for 2010. Include their region and surface area.

SELECT c.name, c.region, c.surface_area
FROM countries AS c
LEFT JOIN economies AS e
ON c.code = e.code
AND e.year = 2010
WHERE e.gdp_percapita IS NULL;

4) Double Identity
A team is looking into countries that have multiple official languages. Return the country name, the languages that are marked as 
official, and how many official languages that country has. Only include countries with 2 or more official languages.

SELECT c.name, COUNT(l.name) AS lang_count
FROM countries AS c
INNER JOIN languages AS l
ON c.code = l.code
WHERE l.official = 'T'
GROUP BY c.name
HAVING COUNT(l.name) >= 2;

5) All Possible Trade Partners
Imagine we want to simulate all possible pairs of countries in Europe that could partner up for trade. Return a table that lists all 
unique pairs of European countries (dont repeat the same pair reversed). Include the country names and regions.

SELECT c1.name, c2.name, c1.region, c2.region
FROM countries AS c1 
INNER JOIN countries AS c2 
ON c1.code < c2.code
WHERE c1.name <> c2.name 
    AND c1.continent = 'Europe'
    AND c2.continent = 'Europe';