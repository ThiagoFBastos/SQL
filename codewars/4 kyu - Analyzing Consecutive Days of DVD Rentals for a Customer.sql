with rentals as (
  select  distinct date(rental_date) as rental_date,
          first_name || ' ' || last_name as full_name
  from rental r
  inner join customer c on r.customer_id = c.customer_id
  where c.customer_id = 1
), rental_dates as (
  select  *,
          rank() over(order by rental_date) as pos
  from rentals
)

select  r.full_name as "name",
        r.rental_date as date_rental_occurred,
        max(dmax.rental_date) - min(dmin.rental_date) + 1 as consecutive_days
  
from rental_dates r
inner join rental_dates dmin on r.pos - dmin.pos = r.rental_date - dmin.rental_date and r.pos >= dmin.pos
inner join rental_dates dmax on dmax.pos - r.pos = dmax.rental_date - r.rental_date and r.pos <= dmax.pos

group by date_rental_occurred, "name"

order by date_rental_occurred;