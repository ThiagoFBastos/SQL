with student as (
  select  s.*, 
          avg(score) as avg,
          case
            when course_date between '2022-10-01' and '2022-12-31' then 'Michaelmas'
            when course_date between '2023-01-01' and '2023-03-31' then 'Lent'
            else 'Summer'
          end as trimester
  from students s inner join courses c on s.id = c.student_id
  where course_date between '2022-10-01' and '2023-06-30'
  group by s.id, trimester
)

select  mi.id as student_id,
        mi.name,
        'Michaelmas (' ||
        round(mi.avg, 2) :: text || 
        '), Lent (' ||
        round(le.avg, 2) :: text ||
        '), Summer (' ||
        round(su.avg, 2) ||
        ')' as trimesters_avg_scores,
        mi.avg < le.avg and le.avg < su.avg as consistent_improvement
from student mi
inner join student le on mi.id = le.id and le.trimester = 'Lent' and mi.trimester = 'Michaelmas'
inner join student su on mi.id = su.id and su.trimester = 'Summer'
order by mi.id desc;