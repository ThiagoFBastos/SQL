select city, length(city) as len
from station
order by len asc, city asc
limit 1;

select city, length(city) as len
from station
order by len desc, city asc
limit 1;