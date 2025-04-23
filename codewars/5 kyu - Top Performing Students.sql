with course_average as (
  select course_name, avg(score) as average
  from courses
  group by course_name
)

select  s.id as student_id,
        s.name,
        string_agg(
          c.course_name || ' (' || round((c.score - ca.average) / ca.average * 100, 2) :: text || '%)',
          ', '
          order by c.course_name
        ) as outperformance
        
from students s

inner join courses c on s.id = c.student_id

inner join course_average ca on c.course_name = ca.course_name

where c.score > ca.average

group by s.id

having count(*) >= 3

order by s.id;
