--query_16:
-- **Follower**: Trovare gli utenti che hanno 
--scritto almeno il 75% delle review per delle 
--attività tra le 10% più recensite. [`review_count`].

--Schema risultato:
--`user_id`


--EXPLAIN ANALYZE
SELECT r.user_id
FROM review_votes AS r, 
	 (SELECT r.user_id, COUNT(*) AS ctot
	  FROM review_votes AS r
	  GROUP BY r.user_id
	  ORDER BY  ctot DESC) AS tot
WHERE r.user_id = tot.user_id AND 
	  r.business_id IN (
		SELECT DISTINCT business_id
		FROM (SELECT DISTINCT business_id, review_count
			  FROM business_categories
			  ORDER BY review_count DESC
			  LIMIT (SELECT (COUNT(DISTINCT business_id)*0.1) 
			  		 FROM business_categories)
			 ) AS topb
)
GROUP BY r.user_id, r.business_id, tot.ctot
HAVING 75 <= 100*COUNT(*)/tot.ctot;
