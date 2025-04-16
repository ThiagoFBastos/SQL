with film_category_store_rentals as (
  select  store_id, 
          c.name as category,
          count(*) as num_rentals,
          rank() over(partition by store_id order by count(*) desc, c.name) as ranking
  
  from inventory i
  
  inner join rental r on i.inventory_id = r.inventory_id
  
  inner join film_category fc on fc.film_id = i.film_id
  
  inner join category c on c.category_id = fc.category_id
  
  group by store_id, c.category_id
)

select  store_id,
        category,
        num_rentals
        
from film_category_store_rentals

where ranking <= 5

order by store_id, num_rentals desc, ranking