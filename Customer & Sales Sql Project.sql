-- 1) What is the total Revenue generated?
select ceil(sum(sales)) as revenue 
from orders;

-- Total Quantity sold
select sum(quantity) 
from orders;

-- What is the profit generated from the revenue?
select ceil(sum(profit)) 
from orders;

-- Which are the highest and the lowest sales and profit making regions? 
select region, ceil(sum(sales)) as revenue, ceil(sum(profit)) as profits 
from locations join orders
on locations.postal_code = orders.postal_code
group by 1
order by 2 desc, 3 desc;

-- Region with product sold.
select region, sum(quantity) as total_product 
from locations join orders
on locations.postal_code = orders.postal_code
group by 1
order by 2 desc;

-- Total Customers
select count(distinct customer_id) as total_customers
from customers;

-- Total Sales per customers
select customer_name, ceil(sum(sales)) as Sales
from customers join orders
on customers.customer_id = orders.customer_id
group by 1
order by 2;

-- Top 10 customers with highest sales
select customer_name, ceil(sum(sales)) as Sales
from customers join orders
on customers.customer_id = orders.customer_id
group by 1
order by 2 desc
limit 10;

-- Top 10 customers with highest profits
select customer_name, ceil(sum(profit)) as profits
from customers join orders
on customers.customer_id = orders.customer_id
group by 1
order by 2 desc
limit 10;

-- Region with their highest sale in each category.
with cte as
(select region, category , ceil(sum(sales)) as total_sales,
 rank() over (partition by region order by sum(sales) desc) as rank
from locations 
join orders on locations.postal_code = orders.postal_code
join products on products.product_id = orders.product_id
group by region, category)
select * from cte
where rank = 1;

-- Region with their highest profit in each category.
with cte as
(select region, category , ceil(sum(profit)) as total_profits,
 rank() over (partition by region order by sum(profit) desc) as rank
from locations 
join orders on locations.postal_code = orders.postal_code
join products on products.product_id = orders.product_id
group by region, category)
select * from cte
where rank = 1;

-- Top 10 highest sales providing from States.
select state, ceil(sum(sales)) as total_sales
from locations join orders
on locations.postal_code = orders.postal_code
group by 1
order by 2 desc
Limit 10;

-- Top 10 highest sales providing from States and cities.
select state,city, ceil(sum(sales)) as total_sales
from locations join orders
on locations.postal_code = orders.postal_code
group by 1,2
order by 3 desc
Limit 10;

-- Which region is getting the highest discount.
select region,state,city, ceil(sum(discount)) as highest_discount
from locations join orders
on locations.postal_code = orders.postal_code
group by 1,2,3
order by 4 desc;

















































































































































