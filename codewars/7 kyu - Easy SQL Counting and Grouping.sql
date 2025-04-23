select race, count(id) as count
from demographics
group by race
order by count desc;