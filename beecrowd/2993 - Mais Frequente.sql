select amount
from value_table
group by amount
order by count(amount) desc
limit 1;