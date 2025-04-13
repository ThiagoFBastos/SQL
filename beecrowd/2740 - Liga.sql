(
select concat('Podium: ', team)
from league
order by position
limit 3
)

union all

(
select concat('Demoted: ', team)
from league
where position in (select position from league order by position desc limit 2)
order by position
)