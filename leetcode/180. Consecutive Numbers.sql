select l1.num as "ConsecutiveNums"
from Logs l1
inner join Logs l2 on l1.id + 1 = l2.id
inner join Logs l3 on l2.id + 1 = l3.id
where l1.num = l2.num and l1.num = l3.num
group by l1.num;