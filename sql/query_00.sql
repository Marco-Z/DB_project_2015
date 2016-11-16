--query_00:
--**Sanity Check**: Ricostruire i file `.csv` utilizzati in input ordinandoli 
--su `business_id`, `user_id` o entrambi ( a seconda dei campi contenuti), 
--salvare i file nella cartella `/tmp/output`.

\COPY (SELECT * FROM user_profiles ORDER BY user_id) TO '/tmp/output/user-profiles.csv' WITH CSV HEADER FORCE QUOTE name

\COPY (SELECT * FROM user_votes ORDER BY user_id) TO '/tmp/output/user-votes.csv' WITH CSV HEADER

\COPY (SELECT * FROM user_compliments ORDER BY user_id) TO '/tmp/output/user-compliments.csv'WITH CSV HEADER

\COPY (SELECT * FROM user_friends ORDER BY user_id) TO '/tmp/output/user-friends.csv' WITH CSV HEADER

\COPY (SELECT c.record_type, c.business_id, b.name, b.full_address, c.city, b.state, c.stars, c.review_count, c.open, c.category FROM business_categories AS c, business AS b WHERE b.business_id = c.business_id ORDER BY c.business_id) TO '/tmp/output/business-categories.csv' WITH CSV HEADER  FORCE QUOTE name, full_address, category

\COPY (SELECT n.record_type, n.business_id, b.name, n.city, b.state, n.latitude, n.longitude, n.neighborhood FROM business_neighborhoods AS n, business AS b WHERE b.business_id = n.business_id ORDER BY business_id) TO '/tmp/output/business-neighborhoods.csv' WITH CSV HEADER  FORCE QUOTE name, city, neighborhood

\COPY (SELECT o.record_type, o.business_id, b.name, b.full_address, o.city, b.state, o.open, o.day, o.opens, o.closes FROM business_openhours AS o, business AS b WHERE b.business_id = o.business_id ORDER BY business_id) TO '/tmp/output/business-openhours.csv' WITH CSV HEADER  FORCE QUOTE name, full_address

\COPY (SELECT v.record_type, v.business_id, v.user_id, v.stars, r.text, v.date, v.vote_type, v.count FROM review_votes AS v, r WHERE v.text_id = r.id ORDER BY v.business_id, v.user_id) TO '/tmp/output/review-votes.csv' WITH CSV HEADER FORCE QUOTE text
