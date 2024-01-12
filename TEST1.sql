-- Lekce 5 ukol 1

SELECT cp.category_code 
	,cpc.name 
	,cp.region_code
	,REPLACE(CONCAT(cp.value, ' Kc'), '.',',') AS value
	,RANK() OVER (PARTITION BY cp.category_code ORDER BY cp.value DESC) AS value_rank
FROM czechia_price AS cp
INNER JOIN czechia_price_category cpc
	ON cp.category_code = cpc.code ;
	
-- ukol 2
SELECT * FROM (
SELECT cp.category_code 
	,cpc.name 
	,cp.region_code
	,REPLACE(CONCAT(cp.value, ' Kc'), '.',',') AS fullname
	,cp.value
	,RANK() OVER (PARTITION BY cp.category_code ORDER BY cp.value DESC) AS value_rank
FROM czechia_price AS cp
INNER JOIN czechia_price_category cpc
	ON cp.category_code = cpc.code) sub
WHERE value_rank < 3;

-- ukol 3

SELECT cp.category_code 
	,cpc.name 
	,cp.region_code
	,REPLACE(CONCAT(cp.value, ' Kc'), '.',',') AS value
	,cp.value
	,RANK() OVER (PARTITION BY cp.category_code ORDER BY cp.value DESC) AS value_rank
	,DENSE_RANK() OVER(PARTITION BY cp.category_code ORDER BY cp.value DESC) AS value_dense_rank
	,ROW_NUMBER() OVER(PARTITION BY cp.category_code ORDER BY cp.value DESC) AS rn 
FROM czechia_price AS cp
INNER JOIN czechia_price_category cpc
	ON cp.category_code = cpc.code ;

-- ukol 4

SELECT date
	,country
	,confirmed
	,FIRST_VALUE(confirmed) OVER(ORDER BY confirmed) AS first_value_confirmed
FROM covid19_basic_differences AS cbd
WHERE country = 'Italy' 
AND confirmed IS NOT NULL
ORDER BY `date` 
;

-- ukol 5

SELECT date
	,country
	,confirmed
	,FIRST_VALUE(confirmed) OVER(ORDER BY confirmed) AS first_value_confirmed
FROM covid19_basic_differences AS cbd
WHERE confirmed IS NOT NULL
ORDER BY `date` 
;

-- ukol 6

SELECT FIRST_VALUE(confirmed) OVER(ORDER BY confirmed) AS first_value_confirmed
FROM covid19_basic_differences AS cbd
WHERE confirmed IS NOT NULL
AND confirmed > 100000
ORDER BY confirmed DESC
LIMIT 1
;

-- Ukol 1 - 2 cast

-- Ukol 2

SELECT category_code
	,ROUND(SUM(value) / count(value),2) AS AVERAGE
FROM czechia_price AS cp 
GROUP BY category_code
ORDER BY average desc
;

-- ukol 4

SELECT CONCAT('Hi ',  'ENGETO here');

SELECT SUBSTRING(202401020407, 5,1) AS id; 

-- HAVING

SELECT country 
	,SUM(confirmed) AS total_confirmed
FROM covid19_basic_differences AS cbd 
WHERE country IN ('US', 'India')
GROUP BY country
HAVING SUM(confirmed) > 5000000;

-- UKOL 2

SELECT country
	,`year` 
	,SUM(population) AS overall_population
FROM economies AS e 
GROUP BY country,`year` 
HAVING overall_population > 4000000000
ORDER BY overall_population DESC;





