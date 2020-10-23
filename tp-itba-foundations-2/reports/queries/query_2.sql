SELECT name, length_ft
FROM ourairports.airports 
INNER JOIN ourairports.runways ON runways.airport_ident=airports.ident
WHERE length_ft BETWEEN 24 AND 25
ORDER BY length_ft ASC;
