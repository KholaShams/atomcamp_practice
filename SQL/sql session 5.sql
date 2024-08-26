use practice;

create table students 
(
student_id int primary key,
student_name varchar(50)
);

create table scores(

student_id int,
course varchar(50),
score int

);

insert into students (student_id, student_name)
values
(1, "Alice"),
(2, "Bob"),
(3, "Charlie");


insert into scores(student_id, course, score)
values
(1, 'Math', 98 ),
(1, 'Science', 98 ),
(2, 'Math',90),
(2, 'URDU',90),
(4, 'Math',89),
(4, 'Science',85);

select *
from students;

select *
from scores;

-- JOIN | INNER JOIN
select a.student_id, a.student_name, b.course, b.score
from students a 
inner join scores b
on a.student_id = b.student_id;

-- LEFT JOIN
select a.student_id, a.student_name, b.course, b.score
from students a 
left join scores b
on a.student_id = b.student_id;

select a.student_id, a.student_name, b.course, b.score
from students a 
left join scores b
on a.student_id = b.student_id
where b.student_id is null;

-- RIGHT JOIN
select a.student_id, a.student_name, b.course, b.score
from students a 
right join scores b
on a.student_id = b.student_id;

select a.student_id, a.student_name, b.course, b.score
from students a 
right join scores b
on a.student_id = b.student_id
where a.student_id is null;

-- FULL OUTER JOIN | FULL JOIN | UNION ALL
select a.student_id, a.student_name, b.course, b.score
from students a 
left join scores b
on a.student_id = b.student_id
UNION ALL
select a.student_id, a.student_name, b.course, b.score
from students a 
right join scores b
on a.student_id = b.student_id
where a.student_id is null;

-- it is repeating the whole first statement before union all and the table values are being represented two times
select a.student_id, a.student_name, b.course, b.score
from students a 
left join scores b
on a.student_id = b.student_id
UNION ALL
select a.student_id, a.student_name, b.course, b.score
from students a 
right join scores b
on a.student_id = b.student_id;
-- where a.student_id is null;


-- SELF JOIN
select *
from students a 
join students b
on a.student_id = b.student_id;


-- CROSS JOIN
select a.*, b.*
from students a
cross join scores b;