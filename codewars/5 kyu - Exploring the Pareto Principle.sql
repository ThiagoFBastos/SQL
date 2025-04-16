with customer_rentals as (
  select c.customer_id, count(*) :: integer as rentals
  from customer c inner join rental r on c.customer_id = r.customer_id
  group by c.customer_id
), customer_rentals_ranking as (
  select  rentals,
          rank() over(order by rentals desc, customer_id) as ranking, 
          count(*) over() as total
  from customer_rentals
)

select  sum(case when ranking <= ceil(total * 0.2) then rentals else 0 end) as "top_20%_rentals_count",
        sum(rentals) as total_rentals_count,
        round(cast(100.0 * sum(case when ranking <= ceil(total * 0.2) then rentals else 0 end) / sum(rentals) as numeric), 2) as "percentage_of_top_20%"
from customer_rentals_ranking;