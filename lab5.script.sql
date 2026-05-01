ALTER TABLE tournaments ADD COLUMN city VARCHAR(100);
ALTER TABLE tournaments ADD COLUMN country VARCHAR(100);
UPDATE tournaments SET city = 'Лондон', country = 'Велика Британія' WHERE tournament_id = 1;
UPDATE tournaments SET city = 'Буча', country = 'Україна' WHERE tournament_id = 2;
UPDATE tournaments SET city = 'Йокогама', country = 'Японія' WHERE tournament_id = 3;
ALTER TABLE tournaments DROP COLUMN location;
SELECT city, country FROM tournaments;
ALTER TABLE matches ADD COLUMN player1_score VARCHAR(100);
ALTER TABLE matches ADD COLUMN player2_score VARCHAR(100);
UPDATE matches SET player1_score = 3, player2_score = 1 WHERE match_id = 1;
UPDATE matches SET player1_score = 2, player2_score = 3 WHERE match_id = 2;
UPDATE matches SET player1_score = 3, player2_score = 0 WHERE match_id = 3;
UPDATE matches SET player1_score = 1, player2_score = 3 WHERE match_id = 4;
UPDATE matches SET player1_score = 0, player2_score = 3 WHERE match_id = 5;
ALTER TABLE matches DROP COLUMN score;
SELECT player1_score, player2_score FROM matches;
CREATE TABLE locations (
location_id SERIAL PRIMARY KEY,
city VARCHAR(100),
country VARCHAR(100)
);
INSERT INTO locations (city, country) VALUES
('Лондон', 'Велика Британія'),
('Буча', 'Україна'),
('Йокогама', 'Японія');
ALTER TABLE tournaments ADD COLUMN location_id INTEGER REFERENCES locations(location_id);
UPDATE tournaments SET location_id = 1 WHERE city = 'Лондон';
UPDATE tournaments SET location_id = 2 WHERE city = 'Буча';
UPDATE tournaments SET location_id = 3 WHERE city = 'Йокогама';
ALTER TABLE tournaments DROP COLUMN city;
ALTER TABLE tournaments DROP COLUMN country;
SELECT * FROM locations;