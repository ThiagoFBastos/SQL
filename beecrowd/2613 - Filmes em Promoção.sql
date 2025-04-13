select M.id, M.name
from movies M inner join prices P on M.id_prices = P.id
where P.value < 2;