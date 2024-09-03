use da_schema;

-- Window Functions

-- Exercise: Rank each subscription package from most expensive to least expensive
-- depending on whatever order you gave it, it just assigns the order into ranking value
select * 
from subscription_packages;

-- skipps rank 2 if two rows get 1 1 rank
select *,
rank() over (order by monthly_rate desc) as ranked
from subscription_packages;

-- to solve that, use dense_rank()... it gives 1 2 3 4 5 ranks no skipping of ranking numbers.
select *,
dense_rank() over (order by monthly_rate desc) as ranked
from subscription_packages;

-- Exercise: Rank each subscription package from most expensive to least expensive within each service_type
select *,
dense_rank() over (partition by service_type order by monthly_rate desc) as ranked
from subscription_packages;


-- with cte finding 2nd most highest monthly rate
-- INTERVIEW QUESTION: FIND THE SECOND HIGHEST SALARY FROM EACH DEPARTMENT.
with max_monthy_rate as 
(
select *, dense_rank() over(partition by service_type order by monthly_rate) as ranked
from subscription_packages
order by service_type
)
select * 
from max_monthy_rate
where ranked = 2;

--  Exercise: Rank each customer's avg data_used

select customer_id, avg(data_used),
rank() over(order by avg(data_used) desc)
from customer_usage
group by customer_id;

select customer_id, count(customer_id), round(avg(data_used), 2)
from customer_usage
group by customer_id;


select *, sum(data_used) over (order by data_used) -- gives cummulative sum by first ordering the data_used in asc
from customer_usage;

select *, sum(data_used) over (order by usage_date) -- gives cummulative sum by first ordering the usage_date in asc
from customer_usage;

select *, sum(data_used) over (order by usage_date, data_used) -- gives cummulative sum by first ordering the usage_date and data_used in asc
from customer_usage;

select *, sum(data_used) over (partition by service_type) 
from customer_usage;

select *, sum(data_used) over (partition by service_type order by usage_date) 
from customer_usage;



-- Exercise: Get all the records from the customer_usage table along with the avg data_used and sum data_used of each customer
select *
from customer_usage
order by customer_id;

select customer_id, round(avg(data_used), 2) as avg_data_used, sum(minutes_used) as total_min_used
from customer_usage
group by customer_id
order by customer_id;

select *, 
avg(data_used) over(
partition by customer_id
) as avg_data_used,
sum(minutes_used) over(partition by customer_id) as cummulative_min_used
from customer_usage
order by customer_id;


-- Exercise: Calculate the difference in minutes_used between each customer's own usage_sessions
-- we can use the lead() and the lag() function
select *
from customer_usage;

select customer_id, minutes_used as current_session, usage_date,
lead(minutes_used) over (partition by customer_id order by usage_date) as next_session
from customer_usage;

select customer_id, minutes_used, usage_date, minutes_used - lead(minutes_used) over (partition by customer_id order by usage_date) as difference
from customer_usage;

select customer_id, minutes_used, usage_date, minutes_used - lag(minutes_used) over (partition by customer_id order by usage_date) as difference
from customer_usage;


-- CTEs:

-- Exercise: find out the most recent feedback from each customer.

with customer_feedbackCTE as
(
select customer_id, max(feedback_date) as latest_date
from customer_feedback
group by customer_id
)
select *
from customer_feedbackCTE
order by customer_id;


with customer_feedbackCTE as
(
select customer_id, max(feedback_date) as latest_date
from customer_feedback
group by customer_id
)
select customer_id, feedback_text, feedback_date
from customer_feedback
where (customer_id, feedback_date) in (select * from customer_feedbackCTE)
order by customer_id;


-- can also be done using join
with customer_feedbackCTE as
(
select customer_id, max(feedback_date) as latest_date
from customer_feedback
group by customer_id
)
select b.customer_id, b.feedback_text, b.feedback_date
from customer_feedback b
join customer_feedbackCTE
on (b.customer_id, b.feedback_date) = (customer_feedbackCTE.customer_id, customer_feedbackCTE.latest_date)
order by customer_id;

-- Exercise: Find out the package_name, service_type and monthly rate of the second most expensive package in EACH service_type
with ranked as (
select package_name, service_type, monthly_rate, 
rank() over (partition by service_type order by service_type, monthly_rate) as ranked
from subscription_packages)
select * 
from ranked
where ranked = 2;



-- Exercise: Find customer_id, names, address, phone_number and avg subscription lengths 
-- for all customers that have an avg_subscription length of more than 5 years

select *
from customer_subscriptions;

with avgdiff as (
select customer_id, round(avg(timestampdiff(year, start_date, end_date)), 2) as yr_difference
from customer_subscriptions
group by customer_id
having yr_difference < 5
order by customer_id
)
select a.customer_id, concat(a.first_name, " ", a.last_name) as full_name, a.address,  a.phone_number, b.yr_difference
from customers a
join avgdiff b
where a.customer_id = b.customer_id;


-- Exercise: Find out customers who never gave feedback and also never subscribed to a service
with gave_feedback as
(
select distinct customer_id
from customer_feedback
),
subscribers as
(
select distinct customer_id
from customer_subscriptions
)
select a.customer_id, a.first_name, a.last_name
from customers a
left join gave_feedback b on a.customer_id = b.customer_id
left join subscribers c on a.customer_id = c.customer_id
where c.customer_id is null and b.customer_id is null;



with gave_feedback as
(
select distinct customer_id
from customer_feedback
),
subscribers as
(
select distinct customer_id
from customer_subscriptions
)
select customer_id, first_name, last_name
from customers
where customer_id not in (select * from gave_feedback) 
and 
customer_id not in (select * from subscribers);



