select C.name, O.id
from customers C inner join orders O on C.id = O.id_customers
where O.orders_date between '2016-01-01' and '2016-06-30';