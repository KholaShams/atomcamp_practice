-- create a customer value column in customers and set it according to the following:
-- if total data > 1000 and total minutes > 10000 then "high value"
-- if total_data > 600 and total minutes > 6000 then "median value"
-- if total_data <600 and total_minutes < 6000 then "low value"
-- else null

select *
from customers
limit 5;

select *
from customer_subscriptions
limit 5;

alter table customers
add column customer_value varchar(100);


with customer_value as (
select customer_id, count(customer_id), round(sum(data_used), 2) as total_data, round(sum(data_used), 2) as total_minutes
from customer_usage
group by customer_id)

select b.*, a.total_data, a.total_minutes
from customer_value a
join customers b
on a.customer_id = b.customer_id;

-- update table
set sql_safe_updates = 0;

start transaction;
with customer_value as (
select customer_id, count(customer_id), round(sum(data_used), 2) as total_data, round(sum(data_used), 2) as total_minutes
from customer_usage
group by customer_id)

update customers a
join customer_value b
on a.customer_id = b.customer_id
set customer_value = 
case
when b.total_data > 1000 or b.total_minutes > 10000 then "High Value"
when (b.total_data between 600 and 1000) or (b.total_minutes between 6000 and 10000) then "Median value"
when (b.total_data between 0 and 600) or (b.total_minutes between 0 and 6000) then "Low Value"
else null
end;

select * 
from customers
where customer_value is null;

commit;

select *
from customers;

-- count how many broadband packages in the subscription packages table
select count(*)
from subscription_packages
where service_type = "broadband";

select count(
case 
when service_type = "broadband" then 1
else null
end) as count
from subscription_packages
where service_type = "broadband";

-- you wish to find out which days is usage the slowest for each service_type
-- find out usage_id, customer_id, service_type and usage_date for all the records where the data_usage is less than the average usage of that SERVICE_TYPE

with t1 as 
(
select usage_id, customer_id, service_type, usage_date, data_used, 
round(avg(data_used) over (partition by service_type), 2) as avg_per_service_type
from customer_usage
)
select usage_id, customer_id, service_type, usage_date
from t1
where data_used < avg_per_service_type;






-- You want to find out which invoice took the company over a certain fiscal goal
-- Find out the customer_id, payment_date, amount_due of the smallest invoice in chronological order that took the company's earnings over 2.5 million
-- Assume that the company earns the money on the day the bill is paid
with t1 as (
select customer_id, amount_due, payment_date,
round(sum(amount_due) over(order by payment_date, amount_due), 2) as running_total
from customer_invoice
where payment_date is not null)
select *
from t1
where running_total > 2500000
limit 1;

-- get all the details from the customers table for this customer_id

with t1 as (
select customer_id, amount_due, payment_date,
round(sum(amount_due) over(order by payment_date, amount_due), 2) as running_total
from customer_invoice
where payment_date is not null)
select *
from customers
where customer_id in
(
select customer_id
from t1
where running_total > 2500000
)
limit 1;


select *
from customers
where customer_id = 102;


