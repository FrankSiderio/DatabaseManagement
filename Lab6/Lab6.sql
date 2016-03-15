--1 Show the name and city of customers who live in any city that makes the most 
--  different kinds of products 

select name, city --outer query 
from customers
where city in (select city -- inner query
               from products
               group by city
               order by count(pid) desc 
               limit 1
              );

--2 Shows the names of products whose priceUSD is above the average priceUSD (reverse order)

select name
from products
where priceusd > (select avg(priceusd)
                  from products
                 )
order by name desc;

--3 Shows the customer name, pid ordered, and the total for all orders, sorted by total (H to L)

select customers.name, orders.pid, orders.totalusd
from customers, orders
where orders.cid = customers.cid
order by orders.totalusd desc;

--4 Shows all the customer names (in alphabetical order) and their total ordered

select customers.name, coalesce(sum(orders.qty), 0) 
from customers
left outer join orders on customers.cid = orders.cid
group by customers.name
order by customers.name asc

--5 Shows the names of all the customers who bought products from agents based in Tokyo along with the
--  names of the products they ordered, and the names of the agents who sold it to them

select customers.name, products.name, agents.name
from customers, orders, products, agents
where orders.cid = customers.cid
  and orders.pid = products.pid
  and orders.aid = agents.aid
  and agents.city = 'Tokyo'; -- nice looking query

--6 checks the accuracy of the dollars column in the orders table. Calculates orders.totalUSD
--  from data in other tables and compares those values to the values in orders.totalUSD
--  Display's the rows in orders where it is incorrect

Select *
from orders, customers, products
where orders.cid = customers.cid
  and orders.pid = products.pid
  and orders.totalusd != (products.priceusd * orders.qty * ((100 - customers.discount) / 100));

--7 Difference between left and right outer joins
-- A left outer join returns all the rows from the left table with the matches from the right table

select customers.cid
from orders
left outer join customers on orders.cid = customers.cid;
--This is a good example because it lists all the cids in the orders table. c005 never made an order so 
--it is not listed. 

-- A right outer join returns all the rows from the right table with matches from the left table 
select customers.cid
from customers
right outer join orders on customers.cid = orders.cid;
--This is similar to the last one but using a right outer join. It returns all the matches from the right
--table(orders) and left table(customers) again c005 is not shown because it never made an order so it is 
--not a match
  

