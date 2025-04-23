with max_orders as (
  select count(*)
  from products p
  inner join orders o on p.id = o.product_id
  group by p.id
  union
  select 0
  order by 1 desc
  limit 1
)

select p.id as product_id, p.product_name, count(*) as count_orders
from products p
inner join orders o on p.id = o.product_id
group by p.id
having count(*) = (select * from max_orders) 
order by product_id desc;