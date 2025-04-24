with FirstLog as (
    select  distinct on(player_id)
            player_id, 
            event_date as first_log_date, 
            lead(event_date) over(partition by player_id order by event_date) as second_log_date
    from Activity
    order by player_id, first_log_date
)

select round(avg(
        case
            when first_log_date + 1 = second_log_date then 1
            else 0
        end
    ), 2) as fraction
from FirstLog;