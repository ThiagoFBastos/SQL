select  e1.id,
        e1.value,
        sum(
          case
            when e1.value = e2.value then 0
            else 1
          end
        ) over(order by e1.id) as run_id

from entries e1 

left join entries e2 on e1.id = e2.id + 1

order by e1.id;