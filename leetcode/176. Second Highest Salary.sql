select salary as "SecondHighestSalary"
from (
    select distinct salary
    from Employee
    union all
    select null as salary
)
order by salary desc nulls last
offset 1
limit 1;