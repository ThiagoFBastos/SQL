select C.name, sum(P.amount)
from categories C inner join products P on C.id = P.id_categories
group by C.id;