-- QUERIES

-- SELECT

-- Exercise: Retrieve all columns and rows from the customers table
select *
from customers;

-- Exercise: List the full names and sign up dates of the customers.
Select CONCAT(first_name, " ", last_name) as full_name, signup_date
from customers;

-- Exercise: Fetch all unique first_name from the customers table
select distinct(first_name) 
from customers;

-- Exercise: Count the number of unique first_name in the customers table
select count(distinct(first_name)) as unique_first_name
from customers;

-- Exercise: Display all columns from the customer_invoice table.
SELECT *
FROM customer_invoice;

-- Exercise: Show only the invoice_id and the amount due from the customer_invoice table.
 SELECT invoice_id, amount_due
 from customer_invoice;
 
 
-- WHERE

--  Exercise: Identify customers who live in Alabama

Select *
from customers
where address like "%Alabama";

Select *
from customers
where address like "%south marc%";

--  Exercise: Find invoices in the customer_invoice table with an amount_due greater than 1000.
select *
from customer_invoice
where amount_due > 1000;

--  Show first_name, last_name and address for customer_ids 3, 15, and 34
select first_name, last_name, address
from customers
where customer_id = 3 or customer_id = 15 or customer_id = 34;
 
-- Exercise: Identify customers who live in either Adamschester or New Paris and their phone number starts with 92
Select *
from customers
where (phone_number like "92%") and (address like "%New Paris%" or address like "%Adamschester%");


-- Exercise: Find invoices with amount_dues greater than 1000 but less than 9000 within customer_ids 100 to 300 (inclusive)
select *
from customer_invoice
where (amount_due > 1000 and amount_due < 9000) and (customer_id >= 100 and customer_id<= 300);


select *
from customer_invoice
where (amount_due > 1000 and amount_due < 9000) and (customer_id between 100 and 300);


-- Exercise: Display customers whose phone number does not start with 96
select *
from customers
where phone_number not like "96%";

-- find out customers who have a non-zero bill but haven't paid it yet
select *
from customer_invoice
where amount_due != 0 and payment_date = "";

-- **Exercise: List all customers except those living in Washington, Texas, New Mexico and Indiana


-- ORDER BY

-- Exercise: Display invoices from the customer_invoice table ordered by amount_due in descending order.
select *
from customer_invoice
order by amount_due desc;

-- Exercise: Dispay invoices from customer_invoice table ordered by customer_id
select *
from customer_invoice
order by customer_id;

-- Exercise: Order customers by their first_name in ascending order and last_name in descending order.
Select *
from customers
order by first_name asc, last_name desc;

--  Exercise: Find invoices in the customer_invoice table with an amount_due greater than 2000 and order by amount_due in asc order.
select * 
from customer_invoice
where amount_due > 2000
order by amount_due asc;

-- Exercise: Find amount_dues greater than 1000 in the first 100 customer_ids and order the result by customer_id
select amount_due
from customer_invoice
where amount_due > 1000
order by customer_id asc
limit 100;


-- LIMIT

-- Exercise: Show only the first 10 customer_id from customers.
select customer_id
from customers
order by customer_id
limit 10;

-- Exercise: List the top 5 highest amount_dues from the customer_invoice table.
select amount_due
from customer_invoice
order by amount_due desc
limit 5;

-- Exercise: List the bottom 3 invoices with least amount_due within customer_ids 900 to 1000 (inclusive)
SELECT * 
FROM customer_invoice
WHERE customer_id BETWEEN 900 AND 1000
ORDER BY amount_due ASC;



-- Exercise: **Retrieve the invoices with the 3 latest payments made by customers. 
-- do this after you change the dates
describe customer_invoice;
-- 1. add a temporary column
alter table customer_invoice
Add temp_payment_date date;
-- 2. update customer_invoice
-- was working in safe mode and updating table requires the safe mode to be off
SET SQL_SAFE_UPDATES = 0;

-- replace empty strings with null cuz empty strings cannot be converted to date
update customer_invoice
set payment_date = null
where payment_date = "";

-- set temp_payment date values to payment_date values
update customer_invoice
set temp_payment_date = str_to_date(payment_date, '%d/%m/%Y');

-- drop the payment_date column
alter table customer_invoice
drop payment_date;

-- rename Temp_payment_date to payment_date
alter table customer_invoice
Rename column temp_payment_date to payment_date;

select *
from customer_invoice;

describe customer_invoice;

-- answer to question: **Retrieve the invoices with the 3 latest payments made by customers. 
select *
from customer_invoice
order by payment_date desc
limit 3;




-- ALTER AND UPDATE EXERCISES

-- set customer_id as the primary key for customers table
describe customers;

alter table customers
add primary key (customer_id);



-- set invoice_id as the primary key for customer_invoice table
describe customer_invoice;

alter table customer_invoice
add primary key (invoice_id);


-- delete all rows where amount_due is zero from customer_invoice
select *
from customer_invoice
where amount_due = 0;

Delete from customer_invoice
where amount_due = 0;


-- set payment_date to null where empty
update customer_invoice
set payment_date = null
where payment_date = "";


-- set all text dates in both tables to proper date format using str_to_date

-- changing text dates to date datatype for CUSTOMERS tables
alter table customers
add temp_date_of_birth date,
add temp_signup_date date;

describe customers;

update customers
set temp_date_of_birth = str_to_date(date_of_birth, '%m/%d/%Y'),
temp_signup_date = str_to_date(signup_date, '%m/%d/%Y');

alter table customers
drop date_of_birth, 
drop signup_date;

alter table customers
rename column temp_date_of_birth to date_of_birth,
rename column temp_signup_date to signup_date;

select * from customers limit 5;

describe customers;

-- changing text dates to date datatype for CUSTOMER_INVOICE tables
describe customer_invoice;

alter table customer_invoice
add column temp_due_date date;

update customer_invoice
set temp_due_date = str_to_date(due_date, '%d/%m/%Y');

alter table customer_invoice
drop due_date;

alter table customer_invoice
rename column temp_due_date to due_date;

describe customer_invoice;

select * from customer_invoice limit 5;

-- change the column type of all date columns to date

-- **ALREADY DONE DURING CHANGING TEXT DATE TO DATE DATATYPE**


-- change the column type of phone number to text/char/varchar
describe customers;

alter table customers
modify phone_number Varchar(100);






-- make a generated column for late_fee

select * from customer_invoice limit 5;
describe customer_invoice;

alter table customer_invoice
drop column late_fee;


alter table customer_invoice
add column late_fee decimal(10, 2) generated always as (
case
when payment_date > due_date then ((amount_due * late_fee_pct) / 100)
else 0
end
) stored;


select * 
from customer_invoice
where payment_date > due_date;
 


-- split address into three separate varchar columns address, city and state

-- Select TRIM(SUBSTRING_INDEX(address, ',', 1)) AS part1, 
-- TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(address, ',', 2), ',', -1)) AS part2,
-- TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(address, ',', 3), ',', -1)) AS part3,
-- TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(address, ',', 4), ',', -1)) AS part4,
-- (SUBSTRING_INDEX(SUBSTRING_INDEX(address, ',', 5), ',', -1)) AS State
-- from customers;
-- where address = substring(phone_number, 1, 'Alabama%');

select trim(substring_index(address, ',', 3 )) as address,
trim(substring_index(substring_index(address, ',',  4), ',', -1)) as city, 
trim(substring_index(substring_index(address, ',',  5), ',', -1)) as State
from customers;

alter table customers
add column city varchar(50),
add column State varchar(50);

update customers
set City = trim(substring_index(substring_index(address, ',',  4), ',', -1)), 
State = trim(substring_index(substring_index(address, ',',  5), ',', -1));


update customers
set address = trim(substring_index(address, ',', 3 ));

select * from customers limit 5;



-- set the safe updates ON
SET SQL_SAFE_UPDATES = 1;
