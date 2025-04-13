select C.id, C.name
from customers C
where C.id not in (
    select L.id_customers
    from locations L
    where L.id_customers = C.id
)
order by C.id;