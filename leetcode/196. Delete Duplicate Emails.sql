delete 
from Person P
where exists (
    select 1
    from Person PE
    where PE.email = P.email and P.id > PE.id
);