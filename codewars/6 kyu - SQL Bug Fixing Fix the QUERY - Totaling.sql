select  s.transaction_date :: date as day,
        d.name as department,
        count(*) as sale_count
        
from department d

inner join sale s on d.id = s.department_id

group by department, day

order by day;