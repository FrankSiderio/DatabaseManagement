--Frank Siderio Lab5

--#1
select agents.city
From agents, orders, customers
where orders.aid = agents.aid
  and orders.cid = customers.cid
  and customers.cid = 'c002';

--#2
select products.pid
from products, orders, agents, customers
where orders.aid = agents.aid
  and orders.pid = products.pid
  and orders.cid = customers.cid
  and customers.city = 'Dallas';

--#3
select name
from customers
where cid not in (select cid
                  from orders
                 );
 -----------------

 --#4
select name
from customers
where cid not in (select customers.cid
                  from customers right outer JOIN orders ON orders.cid = customers.cid
                 );
-----------------------

--5
select customers.name, agents.name
from customers, orders, agents
where orders.cid = customers.cid
  and orders.aid = agents.aid
  and agents.city = customers.city;

--6
select customers.name, agents.name, customers.city, agents.city 
from customers, agents
where customers.city = agents.city;

--7


                
               

