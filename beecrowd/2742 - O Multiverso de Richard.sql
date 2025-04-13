select LF.name, round(LF.omega * 1.618, 3) as fator
from life_registry LF inner join dimensions D on LF.dimensions_id = D.id
where D.name in ('C875', 'C774') and LF.name like 'Richard%'
order by fator;