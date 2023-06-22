-- Homework: 
-- -- List all customers who live in Texas
SELECT c.first_name, c.last_name
FROM customer c
JOIN address a ON c.address_id = a.address_id
WHERE a.district = 'Texas';
-- Answer: Output of 5 people.

-- -- Get all payments above $6.99 with the Customer's Full Name
SELECT cl.name AS customer_name, p.amount
FROM customer_list cl
JOIN payment p ON cl.id = p.customer_id
WHERE p.amount > 6.99;
-- Answer: Output of 1406 people. 

-- or 

-- SELECT CONCAT(c.first_name, ' ', c.last_name) AS customer_name, p.amount
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
WHERE p.amount > 6.99;
-- Answer: Output of 1406 people. 

-- -- Show all customers names who have made payments over $175 (use subqueries)
SELECT cl.name AS customer_name
FROM customer_list cl
WHERE cl.id IN (
  SELECT p.customer_id
  FROM payment p
  GROUP BY p.customer_id
  HAVING SUM(p.amount) > 175
);
-- Answer: 6 people

-- -- List all customers that live in Nepal (use the city table)
-- -- Nepal has a country_id of 66.
SELECT c.*
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
WHERE co.country_id = 66;
-- Answer: 1 person.

-- -- Which staff member had the most transactions?
SELECT staff_id, COUNT(*) AS transaction_count
FROM payment
GROUP BY staff_id
ORDER BY transaction_count DESC
LIMIT 1;
-- Answer: 2

-- How many movies of each rating are there?
SELECT rating, COUNT(*) AS movie_count
FROM film
GROUP BY rating;
-- Answer: "PG-13"	223
-- "NC-17"	210
-- "G"	178
-- "PG"	194
-- "R"	195

-- -- Show all customers who have made a single payment above $6.99 (Use Subqueries)
SELECT
  (SELECT name FROM customer_list WHERE id = p.customer_id) AS full_name,
  p.payment_id,
  p.amount
FROM payment p
WHERE p.amount > 6.99;
-- Answer: 1406
