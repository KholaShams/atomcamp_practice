use da_schema;



create table students
(
id int primary key, 
first_name varchar(50) not null,
last_name varchar(50),
age int default 1,
city varchar(50)
);

insert into students(id, first_name, last_name, age, city)
values
(1, 'Khola', 'Shams', 22, 'Rawalpindi'),
(2, 'Angela', 'Mansoor', 25, 'Peshawar'),
(3, 'Maaida', 'Kaleem', 25, 'Lahore'),
(4, 'Ahmed', 'Javed', 25, 'Faisalabad'),
(5, 'Zahra', 'Mughis', 25, 'Islamabad');

select *
from students;

select *
from students
where age = 22;

select id as 'student id', first_name, last_name, age as 'student age', city
from students
order by first_name asc;




insert into students(id, first_name, last_name)
values
(6, 'Maham', 'farooq');


