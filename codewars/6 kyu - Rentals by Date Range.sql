with dates as (
  select  '2005-05-24' :: date + s as "date"
  from generate_series(0, 9) as s
)

select  d.date :: text,
        count(distinct r.rental_id) as "rentals"

from rental r

right join dates d on r.rental_date :: date = d.date

group by d.date

order by d.date;