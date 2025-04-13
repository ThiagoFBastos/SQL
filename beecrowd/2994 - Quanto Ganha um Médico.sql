select D.name, round(sum(A.hours * 150 * (1 + WS.bonus / 100)), 1) as salary
from attendances A
inner join doctors D on A.id_doctor = D.id
inner join work_shifts WS on A.id_work_shift = WS.id
group by D.id
order by salary desc;