select t.course_id, n.student_id, avg(n.note) as average
from notes n
left join tests t on t.id = n.test_id
left join students s on s.id = n.student_id
group by t.course_id, n.student_id
order by t.course_id