Аналіз 1NF
У tournaments поле location містить такі значення, як "Лондон, Велика Британія" або "Буча, Україна", в одному полі зберігається відразу дві різні сутності: місто та країна, щоб це виправити, я розділю це поле на два окремих атрибути city та country. 
У matches score містить рахунок у форматі "3-1" або "2-3", це поле містить результати двох різних гравців, тут я розділю це поле на два окремих: player1_score та player2_score.
Виправлення
ALTER TABLE tournaments ADD COLUMN city VARCHAR(100);
ALTER TABLE tournaments ADD COLUMN country VARCHAR(100);
Спочатку створюємо два нових стовпці для tournaments
 
UPDATE tournaments SET city = 'Лондон', country = 'Велика Британія' WHERE tournament_id = 1;
UPDATE tournaments SET city = 'Буча', country = 'Україна' WHERE tournament_id = 2;
UPDATE tournaments SET city = 'Йокогама', country = 'Японія' WHERE tournament_id = 3;
Тепер ми оновлюємо дані цих стовпців.
 
ALTER TABLE tournaments DROP COLUMN location;
Тепер видаляємо старий стовпець.  Забула зробити скріншот успішного виконання, але на фото видно що старий стовпець вже не існує
 
SELECT city, country FROM tournaments;
Тепер виконуємо перевірку
 
ALTER TABLE matches ADD COLUMN player1_score VARCHAR(100);
ALTER TABLE matches ADD COLUMN player2_score VARCHAR(100);
Переходимо до виправлення у таблиці matches. Як і в tournaments, ми створюємо два нові стовпці
 
 
UPDATE matches SET player1_score = 3, player2_score = 1 WHERE match_id = 1;
UPDATE matches SET player1_score = 2, player2_score = 3 WHERE match_id = 2;
UPDATE matches SET player1_score = 3, player2_score = 0 WHERE match_id = 3;
UPDATE matches SET player1_score = 1, player2_score = 3 WHERE match_id = 4;
UPDATE matches SET player1_score = 0, player2_score = 3 WHERE match_id = 5;
Далі оновлюємо дані цих стовпців.
 
ALTER TABLE matches DROP COLUMN score;
Тепер видаляємо старий стовпець. 
 
SELECT player1_score, player2_score FROM matches;
Тепер виконуємо перевірку
 
 
Аналіз 2NF
Оскільки у всіх таблицях бази використовуються прості одиничні первинні ключі, часткові залежності відсутні повністю. База даних автоматично знаходиться у 2NF. Отже виконувати нормалізацію немає потреби.
Аналіз 3NF
Після оновлення таблиці tournaments, з'явилася нова проблема: країна логічно залежить від міста. Знаючи, що місто Лондон, також відомо, що це Велика Британія, таким чином виходить залежність: tournament_id визначає city, а city визначає country.
Виправлення
CREATE TABLE locations (
location_id SERIAL PRIMARY KEY,
city VARCHAR(100),
country VARCHAR(100)
);
Перше, що треба зробити – створити нову таблицю
 
INSERT INTO locations (city, country) VALUES
('Лондон', 'Велика Британія'),
('Буча', 'Україна'),
('Йокогама', 'Японія'); 
Потім треба заповнити таблицю новими даними
 
ALTER TABLE tournaments ADD COLUMN location_id INTEGER REFERENCES locations(location_id); 
Тепер створюємо зовнішній ключ до таблиці турнірів
 
UPDATE tournaments SET location_id = 1 WHERE city = 'Лондон';
UPDATE tournaments SET location_id = 2 WHERE city = 'Буча';
UPDATE tournaments SET location_id = 3 WHERE city = 'Йокогама'; 
Тепер оновлюємо таблицю турнірів, проставляючи правильні ідентифікатори локацій
 
ALTER TABLE tournaments DROP COLUMN city;
ALTER TABLE tournaments DROP COLUMN country; 
Тепер видаляємо старі стовпці з таблиці
 
SELECT * FROM locations; 
І нарешті перевіряємо як все працює
