--query_06:
--**Large Neighborhoods:**  Per ogni città trovare le 
--neighborhood più estese: ovvero quelle con la ditanza 
--euclidea maggiore tra i vertici opposti del rettangolo 
--disegnato con le longitudini e latitudini massime e 
--minime delle attività presenti nel quartiere.

--Schema risultato:
--`city` | `neighborhood ` | `diagonal extension`

--EXPLAIN ANALYZE
WITH neighbors AS(
	SELECT n1.city AS city,
		   n1.neighborhood AS neighborhood,
		   SQRT( 
				POWER(
					(MAX(n1.latitude) - MIN(n1.latitude)),
					2.0) 
				+ 
				POWER(
					(MAX(n1.longitude) - MIN(n1.longitude)),
					2.0) 
			   ) AS diagonal
	FROM business_neighborhoods AS n1
	GROUP BY n1.city, n1.neighborhood
)

SELECT DISTINCT bn.city, bn.neighborhood, bn.diagonal AS "diagonal extension"
FROM neighbors AS bn
WHERE (bn.city, bn.diagonal) IN  (SELECT bn2.city, MAX(bn2.diagonal)
	  										FROM neighbors AS bn2
	  										GROUP BY bn2.city)
;
