select T.name, 
count(*) as matches,
sum(case 
    when T.id = M.team_1 and M.team_1_goals > M.team_2_goals then 1
    when T.id = M.team_2 and M.team_2_goals > M.team_1_goals then 1
    else 0
    end
) as victories,
sum(case 
    when T.id = M.team_1 and M.team_1_goals < M.team_2_goals then 1
    when T.id = M.team_2 and M.team_2_goals < M.team_1_goals then 1
    else 0
    end
) as defeats,
sum(case 
    when M.team_1_goals = M.team_2_goals then 1
    else 0
    end
) as draws,
sum(case
    when T.id = M.team_1 and M.team_1_goals > M.team_2_goals then 3
    when T.id = M.team_2 and M.team_2_goals > M.team_1_goals then 3
    when M.team_1_goals = M.team_2_goals then 1
    else 0
    end
) as score
from teams T, matches M
where T.id in (M.team_1, M.team_2)
group by T.id
order by score desc, T.name asc;