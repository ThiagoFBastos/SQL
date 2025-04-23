select  f."film_id",
        f."title",
        f."length"
        
from film f

where f."length" < (
  select min(f2."length")
  from film f2
  where f2."rating" = 'R'
) or
(
  select percentile_cont(0.5) within group(order by f2."length")
  from film f2
  where f2."rating" = 'PG-13'
) < f."length"

order by f."length", f."title", f."film_id";