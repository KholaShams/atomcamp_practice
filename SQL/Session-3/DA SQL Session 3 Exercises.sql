-- Order of commands while writing query
/* 
SELECT
FROM
WHERE 
GROUP BY
HAVING
ORDER BY
LIMIT
*/

select * from customers;
select * from customer_invoice;
select * from customer_subscriptions;
select * from customer_feedback;
select * from customer_usage;
select * from subscription_packages;

-- select max(late_fee)
-- from customer_invoice;

-- GROUP BY:

-- Exercise: Find the number of packages and the average monthly rate for each service_type in subscription_packages.
-- Order by service type and round off the result of average to two dp.
select *
from subscription_packages;

select service_type , count(package_id) as total_packages, round(avg(monthly_rate), 2) as average_monthly_rate
from subscription_packages
group by service_type
order by service_type;

-- Exercise: Find the most expensive and the least expensive package in each service_type
select service_type,  min(monthly_rate) as least_expensive_monthly_rate, max(monthly_rate) as most_expensive_monthly_rate
from subscription_packages
group by service_type
order by service_type;



-- Exercise: Find the total minutes_used and total data_used for each service_type in customer_usage. Round off your results to two dp
select *
from service_type;

select service_type, round(sum(minutes_used), 2) as total_minutes_used, round(sum(data_used), 2) as total_data_used
from customer_usage
group by service_type;


-- Exercise: Find the total data and total minutes used per customer, per service type.
-- order result by customer_id
select *
from customer_usage;

select  customer_id, count(customer_id) as total_records, service_type, sum(data_used) as total_data, sum(minutes_used) as total_minutes
from customer_usage
group by customer_id, service_type
order by customer_id;

-- find the total min used and total dat used for each service type in customer_usage. round the values off to 2 DP.
select  service_type, round(sum(data_used),2) as total_data, round(sum(minutes_used),2) as total_minutes
from customer_usage
group by  service_type
order by service_type;

-- Exercise: Find the no of customers born in each month
select extract(month from date_of_birth) as months, count(customer_id) as total_customers_in_each_month
from customers
group by months
order by months;

-- can also use to find month in alphabetical form
select monthname(date_of_birth) as birth_month, count(customer_id) as total_customers_born_in_each_month
from customers
group by birth_month
order by  total_customers_born_in_each_month;

-- Exercise: Find the total number of subscriptions for each customer. Order by total number of subscriptions in desc order
select customer_id , count(subscription_id) as total_subscription
from customer_subscriptions
group by customer_id
order by total_subscription desc;


-- Exercise: List the total number of feedback entries for each rating level in customer_feedback
select rating, sum(feedback_id) as total_feedback
from customer_feedback
group by rating;

update customer_feedback
set rating = null
where rating = "";

alter table customer_feedback
modify rating int;

select *
from customer_feedback;

-- GROUP BY WITH HAVING:

-- Exercise: Calculate the total minutes used by all customers for mobile services 
select sum(minutes_used) as total_minutes_used
from customer_usage
group by  service_type
having service_type = 'Mobile';

select sum(minutes_used) as total_minutes_used
from customer_usage
where service_type = "Mobile";

-- Exercise: which customers used all the service_types? Show results ordered by customer_ids
-- best practice ... this is called subqueries
select customer_id
from customer_usage
group by customer_id
having count(distinct(service_type)) = (
		select count(distinct(service_type)) from customer_usage
)
order by customer_id;
-- same as this
select customer_id
from customer_usage
group by customer_id
having count(distinct(service_type)) = 3
order by customer_id asc;


select customer_id, service_type
from customer_usage
where customer_id = 71;

-- tells how many service types were used by each customer and then the distinct service types used by each customer.
select customer_id, count(service_type) as total_service_types_used, count(distinct(service_type)) as distinct_service_types
from customer_usage
group by customer_id
order by customer_id;


-- Exercise: Out of customers who have 4 total subscriptions, show the three with the largest customer_ids
select * from customer_subscriptions limit 5;

SELECT customer_id, COUNT(*) as total_subs
FROM customer_subscriptions
GROUP BY customer_id
HAVING total_subs = 4
ORDER BY customer_id DESC
LIMIT 3;

-- Exercise: List the total number of feedback entries for ratings 4 and 5 within each service_type.
select count(feedback_id)  as total_feedback_entries
from customer_feedback
where rating in (4, 5)
group by service_type;
-- having rating between 4 and 5;

select rating, count(feedback_id) as total_feedback_entries
from customer_feedback
group by service_type, rating
-- having rating in (4,5)
order by rating;

select  service_type, rating, count(feedback_id) as total_feedback_entries
from customer_feedback
group by service_type, rating
having rating in (4,5) and service_type != ''
order by rating;

select service_type, rating, count(feedback_id) as total_feedback_entries
from customer_feedback
where service_type != ''
group by service_type, rating
having rating in (4,5)
order by rating;

-- CASE STATEMENTS:

-- Exercise: Make a payment_status column showing each customer’s billing status
-- show ‘Paid’ if the payment_date is not empty, and ‘Unpaid’ otherwise. order by payment_status
select *, 
case 
when payment_date is not null then "Paid"
else "Unpaid"
end as payment_status
from customer_invoice;

select *, 
if( payment_date is not null,  "Paid", "Unpaid")  as payment_status
from customer_invoice;

-- Exercise: Label each subscription package in a column called package_tier as:
--  basic if it costs less than 1000, 
-- gold if between 1000 and 3000 and 
-- platinum if greater than 3000
-- order by package_tier
select *,
case
when monthly_rate < 1000 then "Basic"
when monthly_rate between 1000 and 3000 then "Gold"
else "Platinum"
end as package_tier
from subscription_packages
order by package_tier;


-- Exercise: label each customer's total data_used as low when < 1000, moderate when >= 1000 and < 2500, else heavy and call this usage_status
-- order by usage_status
select customer_id, round(sum(data_used), 2) as total_data,
case
when sum(data_used) < 1000 then "Low"
when sum(data_used) >= 1000 and sum(data_used) < 2500 then "Moderate"
else "Heavy"
end as usage_status
from customer_usage
group by customer_id
order by usage_status;



-- Exercise: Create a response_urgency column:
-- if the rating is less than 3 and feedback text has words "crash", "issue" or "disappoint" in it, label it "contact_urgently"
-- otherwise null
select *,
case 
when (rating < 3 and (feedback_text like "%crash%" or feedback_text like "%issue%" or feedback_text like "%disappoint%")) then "contact_urgently"
else null
end as response_urgency
from customer_feedback;


-- Exercise: Update payment_date in customer_invoice using case

update customer_invoice
set payment_date = 
case 
when payment_date = "" then  NULL
else str_to_date(payment_date, "%d/%m/%Y")
end;




-- data type correction
describe customers;

describe customer_invoice;

describe customer_subscriptions;

alter table customer_subscriptions
add column temp_start_date date,
add column temp_end_date date;

set SQL_SAFE_UPDATES = 0;

update customer_subscriptions
set temp_start_date = str_to_date(start_date, '%d/%m/%Y');
update customer_subscriptions
set temp_end_date = str_to_date(end_date, '%d/%m/%Y');

alter table customer_subscriptions
drop column start_date,
drop column end_date;

alter table customer_subscriptions
rename column temp_start_date to start_date,
rename column temp_end_date to end_date;

select * from customer_subscriptions limit 5;

describe customer_subscriptions;


describe customer_feedback;

alter table customer_feedback
add column temp_feedback_date date;

update customer_feedback
set temp_feedback_date = str_to_date(feedback_date, '%d/%m/%Y');

alter table customer_feedback
drop column feedback_date;

alter table customer_feedback
rename column temp_feedback_date to feedback_date;


select * from customer_feedback limit 5;
describe customer_feedback;

describe customer_usage;

alter table customer_usage
add column temp_usage_date date;

update customer_usage
set temp_usage_date = str_to_date(usage_date, '%d/%m/%Y');

alter table customer_usage
drop column usage_date;

alter table customer_usage
rename column temp_usage_date to usage_date;

select * from customer_usage limit 5;

describe customer_usage;

describe subscription_packages;

