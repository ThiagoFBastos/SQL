with posts_ranking as (
  select  *, 
          rank() over(partition by category_id order by views desc, id) as ranking
  from posts
)

select  c.id as category_id,
        c.category,
        p.title,
        p.views,
        p.id as post_id
        
from posts_ranking p

right join categories c on p.category_id = c.id

where coalesce(p.ranking, 1) <= 2

order by c.category, p.views desc, p.id;