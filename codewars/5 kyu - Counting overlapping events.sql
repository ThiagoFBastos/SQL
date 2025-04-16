with events as (
  select entry_time as point, 1 as type
  from visits
  union all
  select exit_time as point, -1 as type
  from visits
  order by point, type
), line_sweep as (
  select  sum(type) over(order by point, type) as visits,
          point
  
  from events
)

select  point as when_happened,
        visits as visits_count

from line_sweep

order by visits_count desc, when_happened

limit 1;