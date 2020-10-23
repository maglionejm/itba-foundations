SELECT C.name AS country, count(1) AS total
FROM ourairports.airports A, ourairports.countries C
WHERE A.iso_country = C.code
GROUP BY country
ORDER BY total DESC
LIMIT 10;