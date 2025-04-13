select P.id, P.name
from products P inner join categories C on P.id_categories = C.id
where C.name like 'super%';