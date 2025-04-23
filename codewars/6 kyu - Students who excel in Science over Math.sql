select s.id as "student_id",
       s.name as "name",
       sc.score - ma.score as "score_difference"
       
from students s
left join courses sc on s.id = sc.student_id and sc.course_name = 'Science'
left join courses ma on s.id = ma.student_id and ma.course_name = 'Math'

where sc.score > ma.score

order by "score_difference" desc, "student_id";