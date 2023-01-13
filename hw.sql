-- 1. List all customers who live in Texas (use
-- JOINs)

-- 5 customers, including Jennifer Davis, Kim Cruz, Richard Mccrary, Bryan Hardison, and Ian Still

SELECT * 
FROM address
-- WHERE district like 'Texas'
INNER JOIN customer
on address.address_id = customer.address_id
WHERE district LIKE 'Texas'

-- 2. Get all payments above $6.99 with the Customer's Full Name


SELECT amount, first_name, last_name FROM payment
inner join customer
on payment.customer_id = customer.customer_id
where amount > 6.99


-- 3. Show all customers names who have made payments over $175(use subqueries)
-- Peter Menard

SELECT first_name, last_name FROM customer
WHERE customer_id IN(
    SELECT customer_id from payment
    WHERE amount > 175
)

-- 4. List all customers that live in Nepal (use the city table)
-- Kevin Schuler

-- SELECT first_name, last_name
-- FROM customer 
-- INNER JOIN address
-- on customer.address_id = address.address_id
-- WHERE city_id IN(
--     SELECT city_id, country_id from city
--     INNER JOIN country_id
--     on city.country_id = country.country_id
--     WHERE country LIKE 'Nepal'
-- )

SELECT first_name, last_name
FROM customer
JOIN address ON customer.address_id = address.address_id
JOIN city on address.city_id = city.city_id
JOIN country on country.country_id = city.country_id
WHERE country.country = 'Nepal'

-- SELECT address_id, address, city_id
-- FROM address
-- WHERE address_id = 1


-- 5. Which staff member had the most transactions?
-- Jon Stephans had the mose transactions (7304)

SELECT first_name, last_name, count(payment_id)
FROM staff
INNER JOIN payment
on staff.staff_id = payment.staff_id
GROUP BY staff.first_name, staff.last_name


-- 6. How many movies of each rating are there?
--195 R, 209 NC-17, 178 G, 223 PG-13, PG 194

SELECT count(film_id), rating
from film
GROUP BY film.rating

-- 7.Show all customers who have made a single payment above $6.99 (Use Subqueries)

--Christine Roberts, Beverly Brooks, Annie Russell, Megan Palmer, Penny Neal, Bobbie Craig, Scott Shelley, Bobby Bourdreau, Jay Robb, Kirk Stclair, Enrique Forsythe

SELECT first_name, last_name from customer
WHERE customer_id IN(
    SELECT customer_id FROM payment
    WHERE amount > 6.99
    GROUP BY customer_id
    HAVING COUNT(*) = 1
)

-- 8. How many free rentals did our stores give away?
-- 0 free rentals

SELECT count(amount)
FROM payment
WHERE amount = 0