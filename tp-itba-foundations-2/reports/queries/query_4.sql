SELECT A.name, A.municipality, A.iso_country
FROM ourairports.airports A
WHERE A.id in (
SELECT R.airport_ref 
FROM ourairports.runways R
WHERE R.surface = 'GRVL' AND R.lighted = 0 AND R.length_ft = 2500
)