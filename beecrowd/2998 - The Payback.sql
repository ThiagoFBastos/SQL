select  cli.name as "name",
        cli.investment as "investment",
        min(op.month) as "month_of_payback",
        min(op2.total) as "return"

from clients cli

inner join operations op on cli.id = op.client_id

inner join (
    select  op1.id as "operacao",
            op1.profit + sum(coalesce(op2.profit, 0)) - cli.investment as "total"

    from    clients cli
            inner join operations op1 on cli.id = op1.client_id
            left join operations op2 on cli.id = op2.client_id
            and not (op1.id = op2.id or op2.month > op1.month)

    group by cli.id, "operacao"
) op2

on op.id = op2.operacao

where op2.total >= 0

group by cli.id, "name", "investment"

order by "return" desc;