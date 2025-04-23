select  e.employee_id as "employee_id",
        e.full_name as "full_name",
        e.team as "team",
        e.birth_date as "birth_date"
        
from employees e

where not exists (
    select 1
    from employees e2
    where e.team = e2.team and e2.birth_date > e.birth_date
)

order by "team";