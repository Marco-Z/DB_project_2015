CREATE TABLE user_profiles (record_type CHAR(4) DEFAULT 'user',
                            user_id CHAR(22) PRIMARY KEY,
                            name VARCHAR(256),
                            review_count INTEGER DEFAULT 0,
                            average_stars VARCHAR(6),
                            registered_on CHAR(7) DEFAULT CURRENT_DATE,
                            fans_count INTEGER DEFAULT 0,
                            elite_years_count SMALLINT DEFAULT 0
                           );

CREATE TABLE user_compliments (record_type CHAR(10) DEFAULT 'compliment',
                               user_id CHAR(22) NOT NULL,
                               name VARCHAR(256),
                               compliment_type VARCHAR(50) NOT NULL,
                               " num_compliments_of_this_type" INTEGER,  --nel csv c'è uno spazio dopo la virgola
                               PRIMARY KEY(user_id, compliment_type)
                              );

CREATE TABLE user_friends (record_type CHAR(6) DEFAULT 'friend',
                           user_id CHAR(22) NOT NULL,
                           name VARCHAR(256),
                           friend_id CHAR(22) NOT NULL,
                           PRIMARY KEY(user_id, friend_id)
                          );

CREATE TABLE user_votes (record_type CHAR(9) DEFAULT 'user_vote',
                         user_id CHAR(22) NOT NULL,
                         name VARCHAR(256),
                         vote_type VARCHAR(20) NOT NULL,
                         count INTEGER,
                         PRIMARY KEY(user_id, vote_type)
                        );

CREATE TABLE business (business_id CHAR(22) NOT NULL,
                       name VARCHAR(256),
                       city VARCHAR(256),
                       full_address VARCHAR(256),
                       state VARCHAR(3)
                      );

CREATE TABLE business_categories (record_type CHAR(8) DEFAULT 'category',
                                  business_id CHAR(22) NOT NULL,
                                  city VARCHAR(256),
                                  stars VARCHAR(6),
                                  review_count INTEGER DEFAULT 0,
                                  open VARCHAR(5),
                                  category VARCHAR(50) NOT NULL,
                                  PRIMARY KEY(business_id, category)
                                 );
                                  
CREATE TABLE business_neighborhoods (record_type CHAR(8) DEFAULT 'location',
                                     business_id CHAR(22) NOT NULL,
                                     city VARCHAR(256),
                                     latitude DOUBLE PRECISION,
                                     longitude DOUBLE PRECISION,
                                     neighborhood VARCHAR(100) NOT NULL,
                                     PRIMARY KEY(business_id, neighborhood)
                                    );

CREATE TABLE business_openhours (record_type CHAR(10) DEFAULT 'open-hours',
                                 business_id CHAR(22) NOT NULL,
                                 city VARCHAR(256),
                                 open VARCHAR(5),
                                 day VARCHAR(10) NOT NULL,
                                 opens CHAR(5),
                                 closes CHAR(5),
                                 PRIMARY KEY(business_id, day)
                                );

CREATE TABLE business_categories_temp (record_type CHAR(8) DEFAULT 'category',
                                  business_id CHAR(22) NOT NULL,
                                  name VARCHAR(256),
                                  full_address VARCHAR(256),
                                  city VARCHAR(256),
                                  state VARCHAR(3),
                                  stars VARCHAR(6),
                                  review_count INTEGER DEFAULT 0,
                                  open VARCHAR(5),
                                  category VARCHAR(50) NOT NULL
                                 );
                                  
CREATE TABLE business_neighborhoods_temp (record_type CHAR(8) DEFAULT 'location',
                                     business_id CHAR(22) NOT NULL,
                                     name VARCHAR(256),
                                     city VARCHAR(256),
                                     state VARCHAR(3),
                                     latitude DOUBLE PRECISION,
                                     longitude DOUBLE PRECISION,
                                     neighborhood VARCHAR(100) NOT NULL
                                    );

CREATE TABLE business_openhours_temp (record_type CHAR(10) DEFAULT 'open-hours',
                                 business_id CHAR(22) NOT NULL,
                                 name VARCHAR(256),
                                 full_address VARCHAR(256),
                                 city VARCHAR(256),
                                 state VARCHAR(3),
                                 open VARCHAR(5),
                                 day VARCHAR(10) NOT NULL,
                                 opens CHAR(5),
                                 closes CHAR(5),
                                 PRIMARY KEY(business_id, day)
                                );

CREATE TABLE review_votes_temp (record_type CHAR(6) DEFAULT 'review',
                       business_id CHAR(22),
                       user_id CHAR(22),
                       stars SMALLINT,
                       text TEXT,
                       date DATE,
                       vote_type VARCHAR(20),
                       count INTEGER
                       );

CREATE TABLE r (id SERIAL, 
                text TEXT);

CREATE TABLE review_votes (record_type CHAR(6) DEFAULT 'review',
                           business_id CHAR(22),
                           user_id CHAR(22),
                           stars SMALLINT,
                           text_id INTEGER,
                           date DATE,
                           vote_type VARCHAR(20),
                           count INTEGER
                           );
