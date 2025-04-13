select P.name, C.name
from products P inner join categories C on P.id_categories = C.id
where P.amount > 100 and C.id in (1, 2, 3, 6, 9)
order by C.id;