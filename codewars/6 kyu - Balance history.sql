select  cast(to_char(o1.date, 'yyyy-mm-dd') as date) as "date",
        sum(o2.amount) as "balance"
from operations o1
inner join operations o2 on 
to_char(o1.date, 'yyyy-mm-dd')  >= to_char(o2.date, 'yyyy-mm-dd')
where not exists (
  select 1
  from operations o3
  where to_char(o1.date, 'yyyy-mm-dd') = to_char(o3.date, 'yyyy-mm-dd')
  and o1.date < o3.date
)
group by o1.date
order by o1.date;