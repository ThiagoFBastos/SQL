select  r.rental_id,
        c.customer_id,
        r.rental_date :: text,
        (r.rental_date - lag(r.rental_date) over(partition by c.customer_id order by r.rental_date)) :: text as time_since_previous_rental
        
from customer c
inner join rental r on c.customer_id = r.customer_id
where c.customer_id in (1, 2);