with Persons as (
    (
        select requester_id as id
        from RequestAccepted
        group by requester_id
    )
        union
    (
        select accepter_id as id
        from RequestAccepted
        group by accepter_id
    )
)

select P.id, count(*) as num
from Persons P inner join RequestAccepted R on P.id in (R.requester_id, R.accepter_id)
group by P.id
order by num desc
limit 1;