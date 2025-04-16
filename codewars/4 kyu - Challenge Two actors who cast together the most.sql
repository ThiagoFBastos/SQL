with actors_pairs as (
  select  a1.actor_id as first,
          a2.actor_id as second,
          a1.first_name || ' ' || a1.last_name as first_actor,
          a2.first_name || ' ' || a2.last_name as second_actor
  from film f
  inner join film_actor fa1 on f.film_id = fa1.film_id
  inner join film_actor fa2 on f.film_id = fa2.film_id and fa1.actor_id < fa2.actor_id
  inner join actor a1 on a1.actor_id = fa1.actor_id
  inner join actor a2 on a2.actor_id = fa2.actor_id
  group by first, second
  order by count(*) desc
  limit 1
)

select  ap.first_actor,
        ap.second_actor,
        f.title
from actors_pairs ap
inner join film_actor fa1 on fa1.actor_id = ap.first
inner join film_actor fa2 on fa2.actor_id = ap.second and fa1.film_id = fa2.film_id
inner join film f on f.film_id = fa1.film_id
order by f.title;