select  c.customer_id as "customer_id",
        c.email as "email",
        count(*) as "payments_count",
        cast(sum(p.amount) as float) as "total_amount"

from customer c

natural join payment p

group by "customer_id", "email"

order by "total_amount" desc

limit 10;