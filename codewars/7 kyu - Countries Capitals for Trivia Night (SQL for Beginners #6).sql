select capital
from countries
where (continent in ('Africa', 'Afrika')) and country like 'E%'
order by capital asc
limit 3