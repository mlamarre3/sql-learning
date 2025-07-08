June 30

DataCamp exercises

-- Select all fields from economies2015
SELECT *
FROM economies2015    
-- Set operation
UNION
-- Select all fields from economies2019
SELECT *
FROM economies2019
ORDER BY code, year;

SELECT code, year
FROM economies
-- Set theory clause
UNION ALL
SELECT country_code, year
FROM populations
ORDER BY code, year;

-- Return all cities with the same name as a country
SELECT name
FROM cities
INTERSECT
SELECT name
FROM countries

-- Return all cities that do not have the same name as a country
SELECT name
FROM cities
EXCEPT
SELECT name
FROM countries
ORDER BY name;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

ChatGPT Practice

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

🔹 1. Missing Cities Audit
Some countries dont have cities listed in our cities table, and vice versa — some cities refer 
to countries not in the countries file. Return a list of all country codes that appear in one but not the other.

SELECT code
FROM countries
EXCEPT
SELECT country_code
FROM cities;
UNION
SELECT country_code
FROM cities
EXCEPT 
SELECT code
FROM countries;

🔹 2. Language Identity Crisis
Return all country names where a country name also appears as a language name (case-sensitive match). Then return 
all countries whose names do not appear as any language.

SELECT country_name
FROM countries
INTERSECT
SELECT name
FROM languages;

SELECT country_name
FROM countries
EXCEPT
SELECT name
FROM languages;

🔹 3. Lost in Time
Find all (code, year) combinations that are only in the economies table, not in the populations table. Then return
all combinations that are in both.

SELECT code, year
FROM economies
EXCEPT
SELECT code, year
FROM populations;

SELECT code, year
FROM economies
INTERSECT
SELECT code, year
FROM populations;

🔹 4. Shared City-Country Names with Data
Which cities have the same name as a country, and also have a non-null metroarea_pop value? Return just the city names, alphabetically.

SELECT name
FROM cities
WHERE cities.metroarea_pop IS NOT NULL
INTERSECT
SELECT country_name
FROM countries
ORDER BY name;

🔹 5. One-Year Wonders
Find all countries that have data in economies2015 but not in economies2019. Return the country code and year.

SELECT code, year
FROM economies2015
EXCEPT
SELECT code, year
FROM economies2019;



🔷 6. Silent Giants
Which countries appear in both the populations and economies tables in 2010, but are missing data for gdp_percapita or size?
Only include records where either of those values is null.

SELECT country_name, continent
FROM economies AS e
INNER JOIN populations AS p
ON e.code = p.code AND e.year = 2010
WHERE e.gdp_percapita IS NULL
OR p.size IS NULL

🔷 7. Global Namesakes
Return the list of names that are shared by all three of these: a country, a city, and a language. (Exact match.)

SELECT country_name
FROM countries
INTERSECT
SELECT name
FROM cities
INTERSECT
SELECT name
FROM languages;

🔷 8. Economic Comebacks
Return country codes that were missing from the economies2015 table, but reappeared in economies2019.
This shows countries that went dark and came back.

SELECT code
FROM economies2019
EXCEPT
SELECT code
FROM economies2015;

🔷 9. Exclusive Investors
Which countries had a total_investment recorded in 2010, but no recorded fertility_rate that year?
Return country name, region, and investment.

SELECT c.country_name, c.region, total_investment
FROM economies AS e
INNER JOIN countries AS c
ON e.code = c.code
LEFT JOIN populations AS p
ON e.code = p.code 
AND year = 2010
WHERE p.fertility_rate IS NULL

🔷 10. Language Leak Check
Youve been asked to verify data consistency:
Find any language names that appear in the languages table but dont match any country name in the countries table.
(This might indicate a misclassified language.)

SELECT name
FROM languages
EXCEPT
SELECT country_name
FROM countries;