select can.name, round((2 * sc.math + 3 * sc.specific + 5 * sc.project_plan) / 10, 2) as avg
from candidate can inner join score sc on can.id = sc.candidate_id
order by avg desc;