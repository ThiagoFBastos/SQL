with backend as (
  select  employee_id,
          full_name,
          count(*) over () as team_size,
          rank(*) over (order by birth_date desc) as ranking
  from employees
  where team = 'backend'
)

select  '2023-07-03' :: date + (((ranking + g - 1) / 5) :: integer) * 7 + ((ranking + g - 1) % 5) :: integer as date,
        case
          when (ranking + g - 1) % 5 = 0 then 'Monday   '
          when (ranking + g - 1) % 5 = 1 then 'Tuesday  '
          when (ranking + g - 1) % 5 = 2 then 'Wednesday'
          when (ranking + g - 1) % 5 = 3 then 'Thursday '
          else                                'Friday   '
        end as day_of_week,
        employee_id,
        full_name

from backend inner join generate_series(0, 91, team_size) g 
on '2023-07-03' :: date + (((ranking + g - 1) / 5) :: integer) * 7 + ((ranking + g - 1) % 5) :: integer <= '2023-09-30' :: date

order by date;