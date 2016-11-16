--query_18:
-- **Local Friend Finder**: Per ogni utente trovare 
--utenti che non sono amici, ma che hanno scritto 
--recensioni per attività nella stessa città.

--Schema risultato:
--`user_id` | `suggested user_id`


--EXPLAIN ANALYZE
WITH uc AS(		--trova le città per cui un utente ha scritto una recensione
	SELECT DISTINCT r.user_id AS user, b.city AS city
	FROM review_votes AS r JOIN business AS b ON r.business_id = b.business_id
)

SELECT uc.user AS user_id, uc2.user AS "suggested user_id"
FROM uc JOIN uc AS uc2 ON uc.city = uc2.city
WHERE uc.user != uc2.user AND
	  (uc.user, uc2.user) NOT IN 
	   (SELECT user_id, friend_id 
	    FROM user_friends);