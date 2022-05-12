--1.How many subjects we have in the CSE course.			

select count(sub_id)from course_subject
where course_id =101;

--2.Find students who were enrolled into ECE							

select s_d,s_name from student
where course_id = 100;

--3.Find students who are from Mysore who who took CSE course					
select *from student;
select * from student
where s_city ='MYSORE'AND course_id = 101;

--4.Find students who paid the fees after due date			

select f.fee_pay_id,f.student_id, f.c_id,(select schedule_id from fee_schedule where schedule_id =25 )as late_fee
from fee_payment f where  fee_paid_date > '15-6-2021'
union
select f.fee_pay_id,f.student_id, f.c_id,(select schedule_id from fee_schedule where schedule_id =26 )as late_fee
from fee_payment f where  fee_paid_date > '15-7-2021';

select f.fee_pay_id,f.student_id, f.c_id,(select schedule_id from fee_schedule where  fee_paid_date > pay_before)as late_fee
from fee_payment f where  fee_paid_date > '15-6-2021' and fee_paid_date  > '15-07-2021';
--5.Find students who did not pay the fees yet against schedule 26				

select*from student where s_d not in (select student_id from fee_payment); 

--6.Show the courses where we have more than 3 students	

select course_id, count(s_d),count(course_id) from student group by course_id having count(course_id)>3;

--7.Display course name, student name, subject name, number of hours which they are associated with.							

'''select c.c_name, s.s_name, ss.sub_name, ss.no_of_hours 
from course c , student s,  subject ss;'''

select c.c_name, s.s_name, ss.sub_name, ss.no_of_hours
from course c , student s,  subject ss
where c.course_id = s.course_id;
'''
select c.c_name, s.s_name, ss.sub_name, ss.no_of_hours ,cs.sub_id
from course c , student s,  subject ss, course_subject cs
where c.course_id = cs.course_id;
'''

--8Display course name, student name, fee_expected, fee_paid for all the computer science course							

select c.c_name, s.s_name, f.fee_expected, fp.fee_pay_id
from course c, student s, fee_schedule f, fee_payment fp
where c.course_id = s.course_id
and s.s_d = fp.student_id
and c.course_id = fp.c_id
and f.schedule_id !=26
and c.course_id = 101;

select c.c_name, s.s_name, f.fee_expected, fp.fee_pay_id
from course c, student s, fee_schedule f, fee_payment fp
where c.course_id = s.course_id
and c.course_id = 101;

--9.What are the common subjects we have between CSE and ECE (solve this using set operators)

select c.course_id, s.sub_id
from course_subject c , course_subject s
where s.sub_id = c.sub_id
intersect
select c.course_id, s.sub_id
from course_subject c , course_subject s
where s.course_id  != c.course_id;
---
select c.course_id, c.sub_id, s.course_id, s.sub_id
from course_subject c , course_subject s
where s.sub_id = c.sub_id
intersect
select c.course_id, c.sub_id, s.course_id, s.sub_id
from course_subject c , course_subject s
where s.course_id != c.course_id;
---
select sub_id ,course_id from course_subject
intersect
select sub_id ,course_id from (select a.course_id,a.sub_id from course_subject a
where a.sub_id = sub_id)where sub_id = 55;
---
select course_id,sub_id from course_subject
intersect
select course_id, sub_id from (select a.course_id,a.sub_id from course_subject a
where a.sub_id = sub_id)where sub_id = 55;
