Create schema practice;
use practice;
show tables;
drop table if exists employees;
-- CREATE A TABLE
create table employees(
employee_id int,
Job_id varchar(10) not null,
first_name varchar(20),
last_name varchar(20),
age int,
phone_number varchar(20), 
salary int,
hire_date text,

primary key (job_id)
); 

describe employees;

-- INSERT VALUES INTO TABLE EMPLOYEES
insert into employees (employee_id, job_id, first_name, last_name, age, phone_number, salary, hire_date)
values 
(1, "E101", 'John', 'Doe', 28, '555-1234', 45000, '1/15/2020'),
(2, "E102", 'Jane', 'Smith', 34, '555-5678', 52000, '3/22/2019'),
(3, "E103", 'Michael', 'Johnson', 45, '555-8765', 61000, '7/30/2018'),
(4, "E104", 'Emily', 'Davis', 26, '555-4321', 75000, '5/11/2021'),
(5, "E105", 'David', 'Brown', 50, '555-1357', 35000, '2/14/2017'),
(6, "E106", 'Sarah', 'Williams', 31, '555-2468', 85000, '4/4/2022'),
(7, "E107", 'Daniel', 'Jones', 29, '555-7890', 43000, '8/20/2020'),
(8, "E108", 'Sophia', 'Garcia', 38, '555-3141', 80000, '2/17/2019'),
(9, "E109", 'Matthew', 'Martinez', 43, '555-2718', 72000, '9/15/2019'),
(10, "E110", 'Olivia', 'Hernandez', 24, '555-1589', 59000, '11/1/2021'),
(11, "E111", 'James', 'Lopez', 37, '555-4567', 63000, '12/5/2018'),
(12, "E113", 'James', 'Wilson', 29, '555-2710', 90000, '10/10/2017');


select *
from employees;

-- DROP AND ADD CORRECT PK

alter table employees
drop primary key;

alter table employees
add primary key (employee_id);

describe employees;

-- ADD SOME MORE COLUMNS
alter table employees
add column initials varchar(5) first;

select *
from employees;

alter table employees
drop column initials;

alter table employees
modify column initials varchar(20) after last_name;

-- ADD NEW COLUMN
alter table employees
add column bonus_pct float after salary;
-- ADD VALUES INTO THE 2 NEW COLUMNS
update employees
set initials = concat(substr(first_name, 1, 1), substr(last_name, 1, 1));

set SQL_safe_updates = 0;

update employees
set bonus_pct = 0.5;


-- INSERT SOME MORE RECORDS/ROWS
INSERT INTO employees (employee_id, job_id, first_name, last_name, age, phone_number, hire_date)
VALUES
(13, 'E114', 'Mia', 'Anderson', 35, '555-0012', '2021-06-30'),
(14, 'E115', 'Lucas', 'Thomas', 48, '555-0246', '2018-03-31'),
(15, 'E112', 'Isabella', 'Gonzalez', 40, '555-5690', '2023-04-20');

delete from employees
where employee_id between 19 and 21;

ALTER TABLE employees
AUTO_INCREMENT = 12;

select * 
from employees;

-- LETS MAKE MODIFICATIONS

-- ID NEEDS TO AUTO INCREMENT AS IT IS A SIMPLE ITEGER. BUT AUTO INCREMENT DOESNT WORK ON STRINGS OR COMPLEX INTEGER
-- INITIALS ARE CALCULATED FROM FIRST NAME AND LAST NAME
-- BONUS IS 0.5 BY DEFAULT

alter table employees
modify bonus_pct float default 0.5;

alter table employees
modify employee_id int auto_increment;
-- CREATING A GENERATED TABLE SO THAT THE COLUMN'S QUERY CNA BE APPLIED EACH TIME TO NEW ROW.
alter table employees
modify initials varchar(20) 
generated always as (concat(substr(first_name, 1, 1), substr(last_name, 1, 1))) stored;

INSERT INTO employees (job_id, first_name, last_name, age, phone_number, hire_date)
VALUES
("E114", 'Mia', 'Anderson', 35, '555-0012', '2021-6-30'),
("E115", 'Lucas', 'Thomas', 48, '555-0246', '31,3,2018'),
("E112", 'Isabella', 'Gonzalez', 40, '555-5690', '20th Apr 2023');

select * from employees;


-- DATES
select str_to_date("2021-6-30", "%Y-%m-%d");
select str_to_date("1/15/2020", "%m/%d/%Y");
select str_to_date("31,3,2018", "%d,%m,%Y");
select str_to_date("20th Apr 2023", "%D %b %Y");

start transaction;
update employees
set hire_date = 
case 
when employee_id = 15 then  str_to_date(hire_date, "%D %b %Y")
when employee_id = 14 then  str_to_date(hire_date, "%d,%m,%Y")
when employee_id = 13 then  str_to_date(hire_date, "%Y-%m-%d")
else str_to_date(hire_date, "%m/%d/%Y")
end;
rollback;
commit;


start transaction;
update employees
set hire_date = 
case 
when employee_id = 15 then  str_to_date(hire_date, "%D %b %Y")
when employee_id = 14 then  str_to_date(hire_date, "%d,%m,%Y")
else str_to_date(hire_date, "%Y-%m-%d")
end;
rollback;
commit;


select * from employees;
set sql_safe_updates = 0;
start transaction;

update employees
set salary = 13000 where employee_id = 13;

rollback;
commit;

update employees
set salary = 25000 where employee_id = 14;
update employees
set salary = 20000 where employee_id = 15;
