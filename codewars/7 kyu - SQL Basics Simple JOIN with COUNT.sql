select P.id, P.name, count(T.id) as toy_count
from people P inner join toys T on P.id = T.people_id
group by P.id;