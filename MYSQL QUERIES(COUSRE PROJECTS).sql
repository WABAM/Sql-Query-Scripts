Use playcenter;
 SELECT * FROM players;
 
SELECT last_name, first_name, city
FROM players;

SELECT EMAIL_ADDRESS COUNTRY, STREET_ADDRESS
FROM PLAYERS;

SELECT PLAYER_ID, AMOUNT_SPENT_USD, AMOUNT_SPENT_USD * 0.8 AS 'AMOUNT_SPENT_EURO'
FROM PLAYERS;

SELECT last_name, first_name, city, PLAYER_ID, AMOUNT_SPENT_USD, INSTALLED_GAMES, AMOUNT_SPENT_USD/INSTALLED_GAMES AS 'AVERAGE_AMOUNT_PAID'
FROM PLAYERS;

SELECT player_id
,CONCAT(first_name,' ', last_name) AS 'FULL_NAME'
FROM players;

SELECT player_id, email_address
,CONCAT(country,' ', city,'',street_address) AS 'fULL_ADDRESS'
,TOTAL_PLAYING_MINUTES/60 AS'TOTAL_PLAYING_HOURS'
FROM PLAYERS;

SELECT DISTINCT preferred_language
FROM players;

SELECT DISTINCT gender
FROM players;
SELECT DISTINCT age_group
FROM players;

USE onlinecampus;
select *
from courses;

Use Umart;
SELECT order_id, shipping_cost, customer_name
FROM orders
WHERE customer_name = 'Skyler Youster';

SELECT customer_segment, customer_id,  customer_name
FROM orders
WHERE customer_segment = 'Corporate';

SELECT order_priority, order_date, customer_region, customer_country
FROM orders
WHERE order_date < '2012/01/01';

SELECT order_priority, discount, customer_name,  customer_region
FROM orders
WHERE customer_region IN ('Central', ' ', 'West' );

SELECT  customer_id, customer_name
FROM orders
WHERE customer_name LIKE  'E%' or customer_name LIKE 'A%';

SELECT order_priority, discount, shipping_cost, ship_mode, discount 
FROM orders
WHERE order_priority = 'High' AND ship_mode = 'Regular Air';

SELECT order_priority, discount, shipping_cost, ship_mode, discount 
FROM orders
WHERE order_priority = 'High' OR ship_mode = 'Regular Air';

SELECT order_id, customer_id, customer_region, customer_country, customer_segment 
FROM orders
WHERE customer_segment IN ('Small Business','Corporate')
AND   customer_region NOT IN ('North', 'South');

SELECT order_id, discount, unit_price, profit, discount 
FROM orders
WHERE profit BETWEEN 100 AND 200 AND discount NOT BETWEEN 0.1 AND 0.5;

USE hr;
SELECT first_name , 
       salary , 
       salary * 1.12 AS 'new_salary', 
       ROUND(salary * 1.12 , 0) AS 'new_salary_round', 
       FLOOR(salary * 1.12)  AS 'new_salary_floor'
FROM employees;

SELECT first_name , 
       salary , 
       salary * 1.12 AS 'new_salary', 
       ROUND(salary * 1.12 , 0) AS 'new_salary_round', 
       FLOOR(salary * 1.12)  AS 'new_salary_floor';
       
SELECT first_name , 
       hire_date , 
       DATE_ADD(hire_date, INTERVAL 10 DAY) AS 'hire_date_plus_10_days', 
       DATE_ADD(hire_date, INTERVAL 1 MONTH) AS 'hire_date_plus_1_month' , 
       TIMESTAMPDIFF(DAY, hire_date, CURDATE()) AS 'day_difference_from_today'
FROM employees ;

SELECT first_name, last_name, birth_date
FROM   employees 
WHERE  DAY(birth_date) =   DAY(CURDATE())
AND    MONTH(birth_date) = MONTH(CURDATE());

SELECT first_name , last_name , salary , 
       CASE WHEN salary BETWEEN 0 AND 5000 THEN 'Grade A'
            WHEN salary BETWEEN 5001 AND 15000 THEN 'Grade B'
            WHEN salary BETWEEN 15001 AND 20000 THEN 'Grade C'
            ELSE 'Grade D'
       END AS 'sal_grades'
FROM employees ;

SELECT first_name , 
	   last_name , 
       birth_date, 
       TIMESTAMPDIFF(YEAR, birth_date, CURDATE())  AS 'age',
       CASE WHEN TIMESTAMPDIFF(YEAR, birth_date, CURDATE()) BETWEEN 0 AND 20 THEN '0-20'
            WHEN TIMESTAMPDIFF(YEAR, birth_date, CURDATE()) BETWEEN 21 AND 40 THEN '21-40'
            WHEN TIMESTAMPDIFF(YEAR, birth_date, CURDATE()) BETWEEN 41 AND 60 THEN '41-60'
            ELSE '+60'
		END AS 'age_grades'
FROM employees;

USE job_adverts;
SELECT job_id, job_title, salary_estimate_min, salary_estimate_max
FROM jobs
WHERE REPLACE(salary_estimate_max,'K','') < '105,000';

SELECT DISTINCT company_name, company_rank, company_size_min, company_size_max
FROM jobs
WHERE REPLACE(company_size_min, ' Employees', '') > 60 AND 
      REPLACE(company_size_max, ' Employees', '') < 120;
      
SELECT job_id, UPPER(job_title) AS 'upper_jobtitle',
 LOWER(company_name) AS 'lower_companyname'
FROM jobs  ;

SELECT job_id, company_name, headquarters_of_company,
       SUBSTRING(company_name,1,1)             AS 'company_name_first_letter', 
       SUBSTRING(headquarters_of_company, 1,1) AS 'state_of_company_first_letter'
FROM jobs;

 SELECT job_id, company_name, headquarters_of_company,
       CONCAT(SUBSTRING(company_name,1,1), SUBSTRING(headquarters_of_company, 1,1)) 'company_code'
FROM   jobs ; 
 
SELECT job_id, company_name, headquarters_of_company,
       LOWER(CONCAT(SUBSTRING(company_name,1,1), SUBSTRING(headquarters_of_company, 1,1))) 'company_code'
FROM   jobs;

SELECT DISTINCT job_title
FROM jobs
WHERE LENGTH(job_title) > 29;

SELECT job_id, job_title, published_date, removed_date 
FROM jobs
WHERE YEAR(published_date) = 2016;

SELECT job_id, job_title, published_date, removed_date 
FROM jobs
WHERE YEAR(published_date) = 2017 AND MONTH(published_date) = 1;

SELECT job_id, job_title, published_date, removed_date
FROM jobs
WHERE DATEDIFF(removed_date, published_date) = 1;

SELECT job_id, job_title, published_date, removed_date
FROM jobs
WHERE DAY(published_date) = DAY(CURDATE())
AND   MONTH(published_date) = MONTH(CURDATE());

SELECT job_id, job_title, published_date, removed_date
FROM jobs
WHERE published_date > removed_date;

SELECT job_id, job_title, removed_date, company_name, headquarters_of_company
FROM jobs 
WHERE removed_date IS NULL OR 
      company_name IS NULL OR 
      headquarters_of_company IS NULL;
      
SELECT job_id, job_title, 
       IFNULL(removed_date, CURDATE()) AS 'removed_date',
       IFNULL(headquarters_of_company, state_of_company) AS 'headquarters_of_company',
       IFNULL(company_name, 'Not Available') AS 'company_name'
FROM jobs  ;

 SELECT DISTINCT company_name, company_market_value, 
		CASE WHEN company_market_value BETWEEN 0 AND 300 THEN   'low range'
			 WHEN company_market_value BETWEEN 301 AND 600 THEN 'mid range'
             WHEN company_market_value BETWEEN 601 AND 900 THEN 'high range'
			 ELSE 'other range'
		END AS 'company_market_value_rank'
FROM   jobs;
  
  USE AIRBNB;
  select * FROM rooms;
  SELECT AVG(price) AS 'avg_price' 
FROM rooms;

SELECT MAX(number_of_reviews) AS 'highest_num_of_reviews' 
FROM rooms ;

SELECT COUNT(reviews_per_month) AS 'num_of_values' 
FROM rooms;

SELECT DISTINCT neighbourhood_group AS 'distinct_neighbourhood_group' 
FROM rooms;

SELECT AVG(price) AS 'avg_price', neighbourhood_group
FROM rooms 
GROUP BY neighbourhood_group
ORDER BY AVG(price) DESC;

SELECT price_range, 
       COUNT(*) AS 'amount_of_rooms'
FROM rooms
GROUP BY price_range;

SELECT room_type, MAX(reviews_per_month) AS 'highest_reviews_per_month'
FROM rooms 
GROUP BY room_type;
SELECT number_of_reviews_range, AVG(price) AS 'average_price' 
FROM rooms
GROUP BY number_of_reviews_range;

SELECT neighbourhood, COUNT(*) AS 'number_of_rooms'
FROM rooms 
GROUP BY neighbourhood
ORDER BY COUNT(*) DESC;

SELECT neighbourhood_group, neighbourhood, COUNT(*) AS 'number_of_rooms'
FROM rooms 
GROUP BY neighbourhood_group, neighbourhood
ORDER BY neighbourhood_group;

SELECT neighbourhood_group, neighbourhood, COUNT(*) AS 'number_of_rooms'
FROM rooms 
WHERE neighbourhood_group IN ('Manhattan', 'Queens')
GROUP BY neighbourhood_group, neighbourhood
ORDER BY neighbourhood_group;

SELECT neighbourhood, AVG(number_of_reviews) AS 'avg_number_of_reviews'
FROM rooms 
WHERE neighbourhood_group = 'Brooklyn'
GROUP BY neighbourhood;

SELECT host_id, host_name, COUNT(*) AS 'num_of_rooms'
FROM rooms 
GROUP BY host_id, host_name
HAVING COUNT(*) > 100;

SELECT neighbourhood, AVG(price) AS 'avg_price'
FROM rooms 
GROUP BY neighbourhood
HAVING AVG(price) > 150;

SELECT neighbourhood, AVG(price) AS 'avg_price'
FROM rooms 
WHERE neighbourhood_group = 'Bronx'
GROUP BY neighbourhood
HAVING AVG(price) > 150;

SELECT neighbourhood_group, room_type, AVG(number_of_reviews) AS 'avg_number_of_reviews'
FROM rooms 
GROUP BY neighbourhood_group, room_type
ORDER BY neighbourhood_group;

SELECT neighbourhood_group, room_type, AVG(number_of_reviews) AS 'avg_number_of_reviews'
FROM rooms 
GROUP BY neighbourhood_group, room_type
HAVING AVG(number_of_reviews) > 20
ORDER BY neighbourhood_group;

SELECT neighbourhood_group, room_type, AVG(number_of_reviews) AS 'avg_number_of_reviews'
FROM rooms 
WHERE room_type = 'Private room'
GROUP BY neighbourhood_group, room_type
HAVING AVG(number_of_reviews) > 20
ORDER BY neighbourhood_group;

USE spotify;
SELECT * FROM tracks;
SELECT artist, COUNT(*) AS 'number_of_tracks'
FROM tracks 
GROUP BY artist
ORDER BY COUNT(*) DESC;

SELECT genre, AVG(duration) AS 'average_duraion'
FROM tracks 
GROUP BY genre
ORDER BY AVG(duration) DESC;

SELECT artist, 
       MIN(danceability) AS 'min_danceability', 
       MAX(danceability) AS 'max_danceability', 
       AVG(danceability) AS 'avg_danceability'
FROM tracks 
WHERE artist IN ('Queen', 'The Beatles')
GROUP BY artist;

SELECT COUNT(DISTINCT genre) 'unique_pop_genres'
FROM tracks
WHERE genre LIKE '%pop%';

SELECT artist, 
       COUNT(*) AS 'number_of_tracks', 
       MAX(popularity) AS 'highest_popularity',
       MIN(popularity) AS 'lowest_popularity'
FROM tracks
WHERE genre LIKE '%rock%'
GROUP BY artist
ORDER BY COUNT(*) DESC;

SELECT genre, COUNT(*) AS 'number_of_tracks'
FROM tracks
WHERE release_year BETWEEN 2005 AND 2010
GROUP BY genre;

SELECT genre, COUNT(*) AS 'number_of_tracks'
FROM tracks
WHERE release_year BETWEEN 2005 AND 2010
GROUP BY genre
HAVING COUNT(*) > 10;

SELECT artist, release_year, COUNT(*) AS 'number_of_tracks'
FROM tracks
WHERE artist = 'Coldplay'
GROUP BY artist, release_year;

USE BOOKREVIEW;
SELECT *
FROM books;

SELECT u.first_name, u.last_name, u.email, u.birthdate, g.gender
FROM   users u JOIN genders g 
ON u.gender_id = g.gender_id;

SELECT u.first_name, u.last_name, u.email, u.birthdate, g.gender
FROM   users u JOIN genders g 
ON u.gender_id = g.gender_id
WHERE YEAR(u.birthdate) = 2002;

SELECT YEAR(u.birthdate) AS 'year_of_birth', COUNT(*) AS 'num_of_users'
FROM   users u JOIN genders g 
ON u.gender_id = g.gender_id
GROUP BY YEAR(u.birthdate)
ORDER BY YEAR(u.birthdate);

SELECT YEAR(u.birthdate) AS 'year_of_birth', COUNT(*) AS 'num_of_users'
FROM   users u JOIN genders g 
ON u.gender_id = g.gender_id
GROUP BY YEAR(u.birthdate)
HAVING COUNT(*) > 54
ORDER BY YEAR(u.birthdate);

SELECT u.first_name, u.last_name, u.email, u.birthdate, l.country, l.city
FROM users u JOIN locations l 
ON u.location_id = l.location_id;

SELECT l.country, l.city, COUNT(*) AS 'number_of_users'
FROM users u INNER JOIN locations l 
ON u.location_id = l.location_id
GROUP BY l.country, l.city
ORDER BY COUNT(*) DESC;

SELECT l.country, l.city, COUNT(*) AS 'number_of_users'
FROM users u JOIN locations l 
ON u.location_id = l.location_id
WHERE YEAR(CURDATE()) - YEAR(birthdate) > 30
GROUP BY l.country, l.city
ORDER BY COUNT(*) DESC;

SELECT u.first_name, u.last_name, u.email, TIMESTAMPDIFF(YEAR, u.birthdate, CURDATE()) AS 'age', o.occupation_name
FROM users u JOIN occupations o 
ON u.occupation_id = o.occupation_id; 

SELECT AVG(TIMESTAMPDIFF(YEAR, u.birthdate, CURDATE())) AS 'avg_age', o.occupation_name
FROM users u JOIN occupations o 
ON u.occupation_id = o.occupation_id 
GROUP BY o.occupation_name;

SELECT AVG(TIMESTAMPDIFF(YEAR, u.birthdate, CURDATE())) AS 'avg_age', o.occupation_name
FROM users u JOIN occupations o 
ON u.occupation_id = o.occupation_id 
GROUP BY o.occupation_name
HAVING AVG(TIMESTAMPDIFF(YEAR, u.birthdate, CURDATE())) > 40;

SELECT authors, AVG(num_pages) AS 'average_num_pages'
FROM books b JOIN authors a 
ON b.author_id = a.author_id
GROUP BY authors
ORDER BY AVG(num_pages) DESC;

SELECT language_name, COUNT(*) AS 'num_of_book'
FROM books b JOIN languages l 
ON   b.language_code = l.language_code
GROUP BY l.language_name
ORDER BY COUNT(*) DESC;

SELECT u.first_name, u.last_name, u.email, u.birthdate, o.occupation_name, l.country, l.city
FROM users u JOIN locations l 
ON u.location_id = l.location_id
			 JOIN occupations o
ON o.occupation_id = u.occupation_id;

SELECT o.occupation_name, l.country, COUNT(*) AS 'num_of_users'
FROM users u JOIN locations l 
ON u.location_id = l.location_id
			 JOIN occupations o
ON o.occupation_id = u.occupation_id
GROUP BY o.occupation_name, l.country;

SELECT r.rating_id, r.rating_date, r.rating,
       b.title, 
       CONCAT(u.first_name, ' ', u.last_name) AS 'full_name'
FROM ratings r JOIN books b 
ON r.book_id = b.book_id 
			    JOIN users u
ON u.user_id = r.user_id;

SELECT r.rating_id, r.rating_date, r.rating,
       b.title, 
       CONCAT(u.first_name, ' ', u.last_name) AS 'full_name'
FROM ratings r JOIN books b 
ON r.book_id = b.book_id 
                JOIN users u
ON  u.user_id = r.user_id
WHERE b.title LIKE '%harry potter%';

SELECT COUNT(DISTINCT u.user_id) AS 'number_of_users'
FROM ratings r JOIN books b 
ON r.book_id = b.book_id 
                JOIN users u
ON  u.user_id = r.user_id
WHERE b.title LIKE '%harry potter%';

SELECT  l.country, COUNT(DISTINCT u.user_id) AS 'number_of_users'
FROM ratings r JOIN books b 
ON r.book_id = b.book_id 
                JOIN users u
ON  u.user_id = r.user_id
				JOIN locations l
ON  u.location_id = l.location_id
WHERE b.title LIKE '%harry potter%'
GROUP BY l.country;

SELECT b.title, num_pages, publisher_name
FROM books b LEFT JOIN publishers p 
ON b.publisher_id = p.publisher_id;

SELECT b.title, num_pages, publisher_name
FROM books b LEFT JOIN publishers p 
ON b.publisher_id = p.publisher_id
WHERE p.publisher_id IS NULL;

SELECT b.title, b.num_pages, b.publication_date, a.authors
FROM books b LEFT JOIN authors a 
ON b.author_id = a.author_id;

SELECT b.title, b.num_pages, b.publication_date, a.authors
FROM books b LEFT JOIN authors a 
ON b.author_id = a.author_id
WHERE a.author_id IS NULL;

SELECT COUNT(*)
FROM books b LEFT OUTER JOIN ratings r 
ON   b.book_id = r.book_id 
WHERE r.rating_id IS NULL ;

USE HR;
SELECT emp.last_name AS 'employee', mng.last_name AS 'manager'
FROM employees emp JOIN employees mng  
ON   emp.manager_id = mng.id;

SELECT emp.last_name AS 'employee', mng.last_name AS 'manager'
FROM employees emp LEFT JOIN employees mng  
ON   emp.manager_id = mng.id;

USE CARSONLINE;
SELECT c.car_id, c.price, ct.car_make, ct.car_model, ct.car_year 
FROM cars c JOIN car_types ct 
ON   c.car_type_id = ct.car_type_id;

SELECT c.car_id, c.price, ct.car_make, ct.car_model, ct.car_year 
FROM cars c JOIN car_types ct 
ON   c.car_type_id = ct.car_type_id
WHERE ct.car_make = 'bmw' AND ct.car_year BETWEEN 2015 AND 2019;

SELECT ct.car_model, AVG(c.price) AS 'average_price'
FROM cars c JOIN car_types ct 
ON   c.car_type_id = ct.car_type_id
WHERE ct.car_make = 'bmw' AND ct.car_year = 2019
GROUP BY ct.car_model;

SELECT c.car_id, c.price, ft.fuel_type_name
FROM cars c JOIN fuel_types ft 
ON   c.fuel_type_id = ft.fuel_type_id;

SELECT ft.fuel_type_name, COUNT(*) AS 'number_of_cars'
FROM cars c JOIN fuel_types ft 
ON   c.fuel_type_id = ft.fuel_type_id
GROUP BY ft.fuel_type_name
ORDER BY COUNT(*) DESC;

SELECT c.car_id, c.price, tt.transmission_name
FROM cars c JOIN transmission_types tt 
ON   c.transmission_type_id = tt.transmission_type_id;

SELECT ct.car_make, COUNT(DISTINCT ct.car_model) AS 'number_of_hybrid_cars' 
FROM cars c JOIN fuel_types ft 
ON   c.fuel_type_id = ft.fuel_type_id
			JOIN car_types ct 
ON   c.car_type_id = ct.car_type_id
WHERE ft.fuel_type_name = 'Hybrid'
GROUP BY car_make
ORDER BY COUNT(DISTINCT car_model) DESC;

SELECT ct.car_year, ct.car_make, COUNT(*) AS 'number_of_cars'
FROM cars c JOIN transmission_types tt 
ON   c.transmission_type_id = tt.transmission_type_id
			JOIN car_types ct 
ON   c.car_type_id = ct.car_type_id
WHERE tt.transmission_name = 'Manual'
GROUP BY ct.car_year, ct.car_make
ORDER BY ct.car_year;

SELECT c.customer_id, c.first_name, c.last_name, c.birth_date, g.gender
FROM customers c JOIN genders g
ON   c.gender_code = g.gender_code;

SELECT g.gender, COUNT(*) AS 'number_of_customers'
FROM customers c JOIN genders g
ON   c.gender_code = g.gender_code
GROUP BY g.gender;

SELECT g.gender, 
	   TIMESTAMPDIFF(YEAR, c.birth_date, CURDATE()) AS 'age', 
	   COUNT(*) AS 'number_of_customers'
FROM customers c JOIN genders g
ON   c.gender_code = g.gender_code
GROUP BY g.gender, TIMESTAMPDIFF(YEAR, c.birth_date, CURDATE())
ORDER BY COUNT(*) DESC;

SELECT g.gender, TIMESTAMPDIFF(YEAR, c.birth_date, CURDATE()) AS 'age', COUNT(*) AS 'number_of_customers'
FROM customers c JOIN genders g
ON   c.gender_code = g.gender_code
WHERE TIMESTAMPDIFF(YEAR, c.birth_date, CURDATE()) > 59
GROUP BY g.gender, TIMESTAMPDIFF(YEAR, c.birth_date, CURDATE())
ORDER BY COUNT(*) DESC;

SELECT COUNT(*) AS 'number_of_customers'
FROM customers c JOIN locations l 
ON   c.location_code = l.location_code
WHERE l.country = 'Australia';

SELECT COUNT(phone_number) AS 'number_of_customers'
FROM customers c JOIN locations l 
ON   c.location_code = l.location_code
WHERE l.country = 'Australia';

SELECT city, COUNT(*) AS 'number_of_customers'
FROM customers c JOIN locations l 
ON   c.location_code = l.location_code
WHERE l.country = 'Australia' AND phone_number IS NULL
GROUP BY city
ORDER BY COUNT(*) DESC;

SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS 'full_name', COUNT(*) AS 'number_of_cars'
FROM sales s JOIN customers c 
ON s.customer_id = c.customer_id
GROUP BY c.customer_id, CONCAT(c.first_name, ' ', c.last_name)
HAVING COUNT(*) > 5;

SELECT COUNT(s.customer_id) / COUNT(*) * 100 AS 'percent_of_sold_cars'
FROM sales s RIGHT OUTER JOIN cars c 
ON s.car_id = c.car_id;

SELECT AVG(cr.price) AS 'average_price'
FROM sales s JOIN cars cr 
ON s.car_id = cr.car_id
			  JOIN car_types ct
ON  ct.car_type_id = cr.car_type_id
WHERE YEAR(s.purchase_date) = 2019 AND ct.car_make = 'Audi';

USE STUDENT_SURVEY;
SELECT student_id, full_name,university_id
FROM   survey 
WHERE  university_id = (SELECT university_id FROM survey WHERE student_id = 6043);

SELECT survey_id, survey_date 
FROM survey
WHERE survey_date = (SELECT survey_date FROM survey WHERE survey_id = 532);

SELECT student_id, full_name, height_cm
FROM   survey 
WHERE  height_cm > (SELECT height_cm FROM survey WHERE full_name = 'Josephina Athow');

SELECT student_id, full_name, age
FROM   survey 
WHERE  age <  (SELECT age FROM survey WHERE survey_id = 10);

SELECT student_id, full_name, father_job
FROM   survey 
WHERE  father_job = (SELECT father_job FROM survey WHERE full_name = 'Christina Rediers');

SELECT student_id, full_name, father_job, mother_job
FROM   survey 
WHERE  father_job = (SELECT father_job FROM survey WHERE full_name = 'Christina Rediers')
AND    mother_job = (SELECT mother_job FROM survey WHERE full_name = 'Christina Rediers');

SELECT student_id, full_name, age
FROM   survey 
WHERE  age >  (SELECT AVG(age) FROM survey);

SELECT student_id, full_name, age, height_cm
FROM   survey 
WHERE  age >  (SELECT AVG(age) FROM survey)
AND    height_cm > (SELECT AVG(height_cm) FROM survey);

SELECT student_id, full_name, age, academic_major 
FROM survey 
WHERE academic_major IN (SELECT DISTINCT academic_major FROM survey WHERE age = 40);

SELECT student_id, full_name, age, academic_major 
FROM survey 
WHERE academic_major = 'Philosophy'
AND age IN (SELECT DISTINCT age FROM survey WHERE academic_major = 'Medical physics');

USE APPSTORE;
SELECT app_id, app_name, category, reviews 
FROM apps 
WHERE reviews > (SELECT reviews FROM apps WHERE app_id = 64);

SELECT app_name, category, size_in_mb, rating
FROM apps 
WHERE category = (SELECT category FROM apps WHERE app_name = 'Redhold');

SELECT app_id, app_name, category, app_version, last_updated
FROM apps
WHERE last_updated < (SELECT last_updated FROM apps WHERE app_id = 29);

SELECT app_name, category, app_version, rating
FROM apps 
WHERE rating > (SELECT AVG(rating) FROM apps);

SELECT DISTINCT category
FROM apps 
WHERE size_in_mb IN (SELECT size_in_mb FROM apps WHERE category = 'Education');

SELECT MIN(rating) FROM apps WHERE category = 'Education';

SELECT MAX(rating) FROM apps WHERE category = 'Education';

SELECT app_name, rating 
FROM apps 
WHERE rating BETWEEN (SELECT MIN(rating) FROM apps WHERE category = 'Education')
	     AND     (SELECT MAX(rating) FROM apps WHERE category = 'Education');
         
SELECT app_id, app_name, rating and reviews 
FROM apps
WHERE rating > (SELECT rating FROM apps WHERE app_id = 131)
AND   reviews > (SELECT reviews FROM apps WHERE app_id = 28);



