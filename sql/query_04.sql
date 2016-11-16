--query_04:
--**Best Day for Business:**  Per ogni città e giorno della settimana 
--indicare le categorie per cui meno negozi sono aperti in quel giorno.

--Schema risultato:
--`city` | `day of week` | `category` | `num business open`

--EXPLAIN ANALYZE
WITH open_business AS (
	SELECT o.city AS city,
			o.day AS "day of week",
			c.category AS category,
			COUNT(c.business_id) AS "num business open"
	FROM business_categories AS c, business_openhours AS o
	WHERE c.business_id = o.business_id AND
		  c.open != 'False' AND
		  o.open != 'False'
	GROUP BY o.city, o.day, c.category
)

SELECT * 
FROM open_business AS o

EXCEPT

SELECT b1.city AS city,
	   b1."day of week" AS "day of week",
	   b1.category AS category,
	   b1."num business open" AS "num business open"
FROM open_business AS b1, open_business AS b2
WHERE b1.city = b2.city AND
	  b1."day of week" = b2."day of week" AND
	  b1."num business open" > b2."num business open"
GROUP BY b1.city, b1."day of week", b1.category, b1."num business open"
;
