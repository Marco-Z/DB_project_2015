--selezionare id delle persone che hanno recensioni nella stessa città
	SELECT r1.user_id AS utente
	FROM review_votes AS r1,review_votes AS r2, business_openhours AS o1, business_openhours AS o2
	WHERE r1.business_id = o1.business_id and r2.business_id = o2.business_id and o1.city = o2.city and r1.user_id = r2.user_id;