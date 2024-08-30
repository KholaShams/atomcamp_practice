select *
from customers
group by customer_id;

-- this query allows to extract more columns other than grouped column cuz the query is grouped on PK
-- It means that if the grouping is done on PK, we can extract other columns as well. but this case is not possible
-- if we dont have a PK. 
-- This query wouldn't have worked if the query was grouped on soemthing else let's say state. It would give error in that case.
select a.customer_id, round(avg(b.data_used), 2) as average_data_used, concat(a.first_name, " ", a.last_name)
from customers a
join customer_usage b
on a.customer_id = b.customer_id
group by a.customer_id
order by a.customer_id;




-- SINGLE VALUE SUBQUERY
-- customers who total data_used > avg data_used of whole table
select customer_id, sum(data_used) as total_data_used 
from customer_usage
group by customer_id
having total_data_used > (select round(avg(data_used)) from customer_usage)
order by customer_id;

-- returns total_data_used > avg of the data_used of each customer not the avg of the whole column.
select customer_id, sum(data_used) as total_data_used 
from customer_usage
group by customer_id
having total_data_used > round(avg(data_used)) -- avg for data_used by each customer
order by customer_id;

-- find all the customers and their amount_dues that are higher than the avg amount_due of all 1000 customers 
select round(avg(amount_due), 2) as avg_amount_due
from customer_invoice;

select * 
from customer_invoice
where amount_due > 
(select round(avg(amount_due), 2) as avg_amount_due
from customer_invoice)
order by amount_due;

-- find customers who have used more TOTAL data than the avg of all thousand records 
select customer_id, round(sum(data_used), 2) as total_data_used
from customer_usage 
group by customer_id
having total_data_used > (select round(avg(data_used), 2)
from customer_usage)
order by customer_id;



-- the whole data_used column in customer_usage will have a max. find out the id, name and phone_number of the customer that max belongs to 
select max(data_used)
from customer_usage;

select customer_id
from customer_usage
where data_used = (select max(data_used)
from customer_usage);

select customer_id, first_name, last_name, phone_number
from customers
where customer_id in (
select customer_id
from customer_usage
where data_used = (select max(data_used)
from customer_usage)
);

-- another way to get this information directly. this wont work if there were multiple rows with max data_used
-- since it returns just one max value row
-- this works only because we have only one max row with max data_used
select customer_id, first_name, last_name, phone_number
from customers
where customer_id in 
(SELECT * FROM(select customer_id
from customer_usage
order by data_used desc
limit 1) t); 
-- WONT WORK... WE WILL HAVE TO MAKE A DERIVED TABLE
    
-- DERIVED TABLE JOIN VS CORRELATED SUBQUERY
-- display the customer_id, first_name, last_name, phone number for all customers and the total data_used by each.




-- MULTI ROW SUBQUERY
-- find all the customer_ids, first_names, last_names and phone number of customers who never gave feedback
select customer_id, first_name, last_name, phone_number
from customers
where customer_id not in 
	(select distinct(customer_id)
    from customer_feedback);



-- find the firstnames, lastnames and addresses of all the customers who paid their bill 10 days before the due_date
select customer_id, first_name, last_name, address 
from customers
where customer_id in (
select customer_id
from customer_invoice
where datediff(due_date, payment_date) <= 10
);

select * -- payment_date
from customer_invoice
where datediff(payment_date, due_date) <= 10;

-- MULTI ROW AND MULTI COLUMN SUBQUERY
-- find the latest feedback and latest feedback_date from each customer_id 

select  customer_id, max(feedback_date)
from customer_feedback
group by customer_id
order by customer_id;

SELECT 
    customer_id, feedback_text, feedback_date
FROM
    customer_feedback
WHERE
    (customer_id , feedback_date) IN (SELECT 
            customer_id, MAX(feedback_date)
        FROM
            customer_feedback
        GROUP BY customer_id)
ORDER BY customer_id;
    


-- correlated subquery
-- takes longer than normal cuz it is freshly calculating avg for each row.alter
-- computationally expensive
select first_name, last_name,
(select avg(data_used) 
from customer_usage  b
where a.customer_id = b.customer_id) as avg_data_used
from customers a;

-- B E T T E R  M E T H O D
-- Use a DERIVED TABLE | JOINS
SELECT 
    customer_id, first_name, last_name
FROM
    customers;
    
select  customer_id, round(avg(data_used), 2) as avg_data_used
from customer_usage
group by customer_id;

-- takes much less than correlated subqueries
-- JOINS (left joins to find all customerss with their data used even though they didnt used the data)
SELECT a.customer_id, a.first_name, a.last_name, a.phone_number, t.avg_data_used
FROM customers a
left join (select  customer_id, round(avg(data_used), 2) as avg_data_used
from customer_usage
group by customer_id) as t
on a.customer_id = t.customer_id;






                                        


