with top_team as (
  select *, rank() over(partition by team_id order by score desc, id) as ranking
  from team_members
)

select  rank() over (
          order by sum(tt.score) desc
        ) as team_rank,
        t.name as team_name,
        sum(tt.score) as team_score,
        string_agg(
          concat(tt.name, ' (', tt.score :: text, ')'),
          ', '
          order by tt.ranking
        ) as top_members
        
from top_team tt
inner join teams t on tt.team_id = t.id
where tt.ranking <= 5
group by t.id
order by team_score desc, t.name
limit 10;