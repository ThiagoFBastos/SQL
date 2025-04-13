select temperature, count(*)
from records
group by temperature, mark
order by mark;