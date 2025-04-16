with posts_count as (
  select  created_at :: date as "date",
          count(*) as "count"
  from posts
  group by "date"
)


select  *,
        cast(sum("count") over(order by "date") as integer) as total
        
from posts_count

order by "date";