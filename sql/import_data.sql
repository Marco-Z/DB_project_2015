COPY review_votes_temp
FROM '/tmp/dati/review-votes.csv'
DELIMITER ',' 
CSV HEADER;
---------------------------------------------------------------------------------------------

COPY business_categories_temp
FROM '/tmp/dati/business-categories.csv' 
DELIMITER ',' 
CSV HEADER;
---------------------------------------------------------------------------------------------

COPY business_neighborhoods_temp
FROM '/tmp/dati/business-neighborhoods.csv' 
DELIMITER ',' 
CSV HEADER;
---------------------------------------------------------------------------------------------

COPY business_openhours_temp
FROM '/tmp/dati/business-openhours.csv' 
DELIMITER ',' 
CSV HEADER;
---------------------------------------------------------------------------------------------

COPY user_profiles 
FROM '/tmp/dati/user-profiles.csv' 
DELIMITER ',' 
CSV HEADER;
---------------------------------------------------------------------------------------------

COPY user_compliments 
FROM '/tmp/dati/user-compliments.csv' 
DELIMITER ',' 
CSV HEADER;
---------------------------------------------------------------------------------------------

COPY user_friends
FROM '/tmp/dati/user-friends.csv' 
DELIMITER ',' 
CSV HEADER;
---------------------------------------------------------------------------------------------

COPY user_votes
FROM '/tmp/dati/user-votes.csv' 
DELIMITER ',' 
CSV HEADER;
---------------------------------------------------------------------------------------------

INSERT INTO r (text)
SELECT DISTINCT v.text
FROM review_votes_temp AS v;

INSERT INTO review_votes
SELECT t.record_type, t.business_id, t.user_id, t.stars, r.id, t.date, t.vote_type, t.count
FROM review_votes_temp as t, r
WHERE t.text = r.text;

DROP TABLE review_votes_temp;
---------------------------------------------------------------------------------------------

INSERT INTO business
(SELECT DISTINCT c.business_id, c.name, c.city, c.full_address, c.state 
 FROM business_categories_temp AS c
)
UNION
(SELECT DISTINCT o.business_id, o.name, o.city, o.full_address, o.state 
 FROM business_openhours_temp AS o
)
UNION
(SELECT DISTINCT n.business_id, n.name, n.city, NULL, n.state 
 FROM business_neighborhoods_temp AS n
);

DELETE FROM business
WHERE business_id in (
					  (SELECT business_id
					   FROM business
					   WHERE full_address IS NULL
					  )
					  INTERSECT
					  (SELECT business_id
					   FROM business
					   GROUP BY business_id
					   HAVING COUNT(*) > 1
					  )
					 ) AND
	  full_address IS NULL
	  ;

INSERT INTO business_categories
SELECT record_type, business_id, city, stars, review_count, open, category
FROM business_categories_temp;

INSERT INTO business_neighborhoods
SELECT record_type, business_id, city, latitude, longitude, neighborhood
FROM business_neighborhoods_temp;

INSERT INTO business_openhours
SELECT record_type, business_id, city, open, day, opens, closes
FROM business_openhours_temp;

DROP TABLE business_categories_temp;
DROP TABLE business_openhours_temp;
DROP TABLE business_neighborhoods_temp;
