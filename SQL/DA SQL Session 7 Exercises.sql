
USE da_schema;

-- INNER JOIN
-- Exercise 1: 
-- Write a query to find all customers names along with their amount_due and payment_date if any
SELECT a.customer_id, a.first_name, a.last_name, b.amount_due, b.payment_date
FROM customers a
JOIN customer_invoice b
ON a.customer_id = b.customer_id
ORDER BY a.customer_id;



-- Exercise 2:
-- Display service packages along with the number of subscriptions each has.
SELECT * FROM subscription_packages;
SELECT * FROM customer_subscriptions ORDER BY package_id;

SELECT a.package_id, COUNT(b.subscription_id) AS total_packages
FROM subscription_packages a
JOIN customer_subscriptions b
ON a.package_id = b.package_id
GROUP BY a.package_id
ORDER BY a.package_id;

-- Exercise 3:
-- find out customer_ids, names, and all package ids for customers who subscribed to a package exactly 1 month after they signed up
SELECT * FROM customers;
SELECT * FROM customer_subscriptions;

SELECT a.customer_id, a.first_name, a.last_name, a.signup_date, b.package_id, b.start_date
FROM customers a 
JOIN customer_subscriptions b
ON a.customer_id = b.customer_id AND b.start_date + INTERVAL 1 MONTH = a.signup_date
ORDER BY a.customer_id;
-- We can join on more than one column. In this case, we can also use WHERE clause.
SELECT a.customer_id, a.first_name, a.last_name, a.signup_date, b.package_id, b.start_date
FROM customers a 
JOIN customer_subscriptions b
ON a.customer_id = b.customer_id 
WHERE b.start_date + INTERVAL 1 MONTH = a.signup_date
ORDER BY a.customer_id;

-- LEFT JOIN
-- Exercise 1:
-- Write a query to list all customers and any feedback they have given, including customers who have not given feedback.
SELECT a.customer_id, CONCAT(a.first_name, " ", a.last_name) AS full_name, a.phone_number, b.feedback_id, b.feedback_text
FROM customers a 
LEFT JOIN customer_feedback b
ON a.customer_id = b.customer_id
ORDER BY a.customer_id;



--  Exercise 2:
-- Now change the query above to only find out which customers have never given feedback 
SELECT a.customer_id, CONCAT(a.first_name, " ", a.last_name) AS full_name, a.phone_number, b.feedback_id, b.feedback_text
FROM customers a 
LEFT JOIN customer_feedback b
ON a.customer_id = b.customer_id
WHERE b.feedback_id IS NULL
ORDER BY a.customer_id;


-- RIGHT JOIN

-- Exercise 1:
-- show all customers with their personal information along with the number of subscriptions each has
select *
from customers;
select *
from customer_subscriptions;

select b.*, count(a.customer_id) as total_subscriptions
from customer_subscriptions a
right join customers b
on a.customer_id = b.customer_id
group by b.customer_id
order by b.customer_id;



-- Multiple JOINs
-- Exercise 1:
-- Write a query to list customer names, records for their data_used and their subscription packages
-- customer names from customers
-- data used from customer_usage
-- package id from customer_subscriptions
-- package_name from subscription_packages (NOT IN QUESTION)

SELECT c.customer_id, CONCAT(c.first_name, " ", c.last_name) AS full_name, cu.data_used, cs.package_id, sp.package_name
FROM customers c
JOIN customer_usage cu
ON c.customer_id = cu.customer_id
JOIN customer_subscriptions cs
ON cu.customer_id = cs.customer_id
JOIN subscription_packages sp
ON cs.package_id = sp.package_id
ORDER BY c.customer_id;


-- Exercise 2:
-- List all customer_ids and names and also show the subscriptions packages and package names of those that have subscribed to a package
-- customer_id, customer_name from customers
-- subscription_id from customer_subscriptions
-- package name from subscription package
select a.customer_id, concat(a.first_name, " ", a.last_name) as full_name, b.subscription_id, c.package_name 
from customers a
join customer_subscriptions b
on a.customer_id = b.customer_id
join subscription_packages c
on b.package_id = c.package_id
order by a.customer_id;


-- SELF JOINS
-- Exercise 1:
-- For each usage_id record, find the difference in data_used between current and next record
-- CAN EASILY BE DONE THROUGH WINDOW FUNCTIONS
select *
from customer_usage;

select *, round((a.data_used - b.data_used), 2) as difference
from customer_usage a
join customer_usage b
on a.usage_id + 1 = b.usage_id;





