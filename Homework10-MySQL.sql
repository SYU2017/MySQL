use sakila;
SELECT first_name, last_name, concat(first_name, '  ', last_name) AS Actor_Name
FROM actor;

SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name = "Joe" ;  

SELECT first_name, last_name
FROM actor
WHERE last_name LIKE '%GEN%';

SELECT first_name, last_name
FROM actor
WHERE last_name LIKE '%LI%'
ORDER BY first_name asc , last_name asc;

SELECT country_id, country
FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

ALTER TABLE actor
ADD COLUMN middle_name VARCHAR(45) AFTER first_name;

ALTER TABLE actor CHANGE middle_name middle_name BLOB;
ALTER TABLE actor DROP COLUMN middle_name;

SELECT last_name, COUNT(*) as number_of_lastnames FROM actor GROUP BY last_name having count(*) >=1;
SELECT last_name, COUNT(*) as number_of_lastnames FROM actor GROUP BY last_name having count(*) >=2;

UPDATE actor
SET first_name='HARPO'
WHERE first_name='GROUCHO' and last_name='WILLIAMS';

UPDATE actor
   SET first_name =
       CASE WHEN first_name='HARPO' then 'GROUCHO'	
            ELSE 'MUCHO GROUCHO' END 
 WHERE last_name='WILLIAMS' and (first_name='HARPO' or first_name='GROUCHO') ;
 
SHOW CREATE TABLE address; 
select * from address;

select s.first_name, s.last_name, a.address, a.address2
from staff s 
inner join address a on 
s.address_id = a.address_id;

select * from payment;
select s.staff_id, sum(p.amount) AS total_amount_august
from payment p
join staff s using (staff_id)
where p.payment_date LIKE '2005-08-%'
group by p.staff_id;

select film.film_id, film.title, count(film_actor.actor_id) as Number_of_actors From film_actor
inner join film on film.film_id = film_actor.film_id
group by film_id;

select * from inventory;
SELECT title, COUNT(i.inventory_id) AS 'Number of Copies'
FROM film f
join inventory i on f.film_id = i.film_id 
where f.title = 'Hunchback Impossible';

select c.customer_id, c.first_name, c.last_name, sum( p.amount) as total_amount_paid from payment p
join customer c using (customer_id) 
Group by c.customer_id
ORDER BY c.last_name asc;

select title, language_id from film 
where language_id in 
( select language_id
  from language
  where name = 'English'
) and title LIKE 'K%' or title LIKE 'Q%'
;

select first_name, last_name from actor 
where actor_id in
(  select actor_id from film_actor
   where film_id in
   (select film_id from film
     where title = 'Alone Trip')
);

select first_name, last_name, email from customer
join address using (address_id)
join city using (city_id)
join country using (country_id)
where country.country = 'Canada';

select film_id, title from film
join film_category using (film_id)
join category using (category_id)
where category.name = 'Family';

select title, count(rental.rental_id) as most_frequently_rented_movies 
from film
join inventory using (film_id)
join rental using (inventory_id)
group by title
ORDER BY count(rental.rental_id) desc;

select store_id, sum(payment.amount) from store
join customer using (store_id)
join payment using ( customer_id)
group by store_id;

select store_id, city, country from store
join address using (address_id)
join city using (city_id)
join country using (country_id);

CREATE VIEW top_five_genres as
select category_id, name, sum(payment.amount) as genres_total_gross_revenue from category
join film_category using (category_id)
join inventory using (film_id)
join rental using (inventory_id)
join payment using (rental_id)
Group by category.name
order by sum(payment.amount) desc
LIMIT 5;

select * from top_five_genres;
drop view top_five_genres;


