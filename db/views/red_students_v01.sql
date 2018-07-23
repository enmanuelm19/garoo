select stu.*
from students stu
left join (
select st.id, count(a.course_id) as number_of_courses
from students st
left join notes_by_students a on a.student_id = st.id
where a.average < 4
group by st.id
order by st.id) b on b.id = stu.id
where b.number_of_courses > 1