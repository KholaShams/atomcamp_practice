use practice;

select *
from students;

select *
from scores;
-- we cannot add something in fk thats not in pk
alter table scores
add foreign key (student_id) 
references students(student_id);

set SQL_safe_updates = 0;

delete from scores
where student_id = 4;

insert into scores(student_id, course, score)
values
(3, 'Math', 65);

-- this wont work since 4 is not in pk student_id in students table
insert into scores(student_id, course, score)
values
(4, 'Math', 65);

