select M.id, M.name
from movies M inner join genres G on M.id_genres = G.id
where G.description = 'Action';