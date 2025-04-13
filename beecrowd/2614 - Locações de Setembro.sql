select C.name, R.rentals_date
from customers C inner join rentals R on C.id = R.id_customers
where R.rentals_date between '2016-09-01' and '2016-09-30';