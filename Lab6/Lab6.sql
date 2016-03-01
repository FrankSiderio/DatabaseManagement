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
order by orders.totalusd desc 

--4 Shows all the customer names (in alphabetical order) and their total ordered

select *
from customers 


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
  

