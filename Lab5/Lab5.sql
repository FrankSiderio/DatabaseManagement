--Frank Siderio Lab5

--#1 Shows the cities of agents booking an order for a customer whose id = c002
select agents.city
From agents, orders, customers
where orders.aid = agents.aid
  and orders.cid = customers.cid
  and customers.cid = 'c002';

--#2 Returns the product ids ordered through any agent who makes at least one order 
--   for a customer in Dallas. Sorted by pid high to low
select products.pid
from products, orders, agents, customers
where orders.aid = agents.aid
  and orders.pid = products.pid
  and orders.cid = customers.cid
  and customers.city = 'Dallas'
order by products.pid desc;

--#3 list the names of customers who never place an order using subquery
select name
from customers
where cid not in (select cid
                  from orders
                 );
 -----------------

 --#4 same thing as the last one but with an outer join
select name
from customers
where cid not in (select customers.cid
                  from customers right outer JOIN orders ON orders.cid = customers.cid
                 );
-----------------------

--#5 list the names of customers who placed at least one order through an agent in 
--   their own city, and also those agents names
select customers.name, agents.name
from customers, orders, agents
where orders.cid = customers.cid
  and orders.aid = agents.aid
  and agents.city = customers.city;

--#6 list the names of the customers and agents living in the same city, along with the
--   name of the shared city. does not matter if the customer has ever placed an order
--   with that agent 
select customers.name, agents.name, customers.city, agents.city 
from customers, agents
where customers.city = agents.city;

--#7 list the name and city of the customers who live in the city that makes the fewest
--   different kinds of products
SELECT name, city 
FROM customers
WHERE city in (SELECT city
               FROM products 
               GROUP BY city
               order by COUNT(pid)
               limit 1
              );
 -----------
