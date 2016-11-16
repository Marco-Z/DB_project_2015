--query_02:
--**Role Models:**  Per ogni esercizio commerciale 
--trovare attività con almeno una categoria in comune 
--ma situate in città diverse [`city`], con maggior 
--numero di review [`review_count`] e con voto medio 
--[`stars`] superiore. Ignorare gli esercizi 
--commerciali di cui non si conosce la categoria.

--Schema risultato:
--`business_id` | `num review` | `stars` | `city` | `business_id role model` | `num review role model` | `stars role model` | `city role model`

--EXPLAIN ANALYZE
SELECT DISTINCT c1.business_id AS business_id, 
			    c1.review_count AS num_review, 
			    c1.stars AS stars, 
			    c1.city AS city,
			    c2.business_id AS "business_id role model",
			    c2.review_count AS "num_review role model",
			    c2.stars AS "stars role model",
			    c2.city AS "city role model"
FROM business_categories AS c1, business_categories AS c2
WHERE c1.city != c2.city AND
	  c2.review_count > c1.review_count AND
	  c2.stars > c1.stars AND
	  c1.category = c2.category AND
	  c1.open != 'False' AND
	  c2.open != 'False';
