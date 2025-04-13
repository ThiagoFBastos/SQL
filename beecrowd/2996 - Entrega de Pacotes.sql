select P.year, U1.name, U2.name
from packages P
inner join users U1 on P.id_user_sender = U1.id
inner join users U2 on P.id_user_receiver = U2.id
where (P.color = 'blue' or P.year = 2015) and 'Taiwan' not in (U1.address, U2.address)
order by year desc;