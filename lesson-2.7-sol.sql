USE sakila;
SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

-- 1. How many films are there for each of the categories in the category table. Use appropriate join to write this query.
SELECT * FROM film_category;

SELECT c.category_id, name as category_name, COUNT(film_id) as number_of_films
FROM category c
INNER JOIN film_category f
ON c.category_id = f.category_id
GROUP BY category_id;

-- 2. Display the total amount rung up by each staff member in August of 2005.
SELECT * from payment;

SELECT DISTINCT s.staff_id, first_name, last_name , SUM(amount) AS total_amount
FROM staff s
JOIN payment p
ON s.staff_id = p.staff_id
WHERE left(payment_date,4) = '2005' and substr(payment_date, 6,2) = '08'
GROUP BY s.staff_id;

-- 3. Which actor has appeared in the most films?
Select * from film_actor;

Select * from actor;

SELECT f.actor_id, first_name, last_name, COUNT(f.actor_id) as number_of_films
FROM actor a
JOIN film_actor f
ON a.actor_id = f.actor_id
GROUP BY f.actor_id
ORDER BY number_of_films DESC
LIMIT 1;

-- 4. Most active customer (the customer that has rented the most number of films)
SELECT * from rental;

SELECT first_name, last_name, COUNT(r.rental_id) as num_films_rented
FROM customer c
JOIN rental r USING(customer_id)
GROUP BY c.customer_id
ORDER BY num_films_rented DESC
LIMIT 1;

-- 5. Display the first and last names, as well as the address, of each staff member.
select * from staff;
select * from address;

SELECT first_name, last_name, address
FROM staff s
JOIN address r
ON s.address_id = r.address_id;

-- 6. List each film and the number of actors who are listed for that film.
SELECT * FROM film;
SELECT * FROM film_actor;

SELECT f.film_id, title, COUNT(DISTINCT actor_id)
FROM film f
INNER JOIN film_actor fa
ON f.film_id = fa.film_id
GROUP BY film_id;

-- 7. Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name.
SELECT * FROM customer;
SELECT * FROM payment;

SELECT first_name, last_name, SUM(amount)
FROM customer c
INNER JOIN payment p
ON c.customer_id = p.customer_id
GROUP BY p.customer_id
ORDER BY last_name ASC;

-- 8. List the titles of films per category.
SELECT * FROM category;
SELECT * FROM film_category;

SELECT fa.category_id, name, title
FROM film f
INNER JOIN film_category fa
ON f.film_id = fa.film_id
INNER JOIN category c
ON fa.category_id = c.category_id
GROUP BY f.film_id;