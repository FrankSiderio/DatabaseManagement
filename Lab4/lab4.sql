--1 returns the cities of the agents that are booking an order from cid c002
SELECT city 
FROM agents
WHERE aid in (SELECT aid
              FROM orders
              WHERE cid in (select cid
                           from customers 
                           where cid = 'c002'
                           )
             ); 
---------------

--2 returns the pid of products ordered through an agent from a customer in dallas ordered by pid desc
SELECT distinct pid 
FROM orders
WHERE aid in (SELECT aid
	      FROM orders
	      WHERE cid in (SELECT cid
	                    FROM customers
	                    WHERE city = 'Dallas'
	                   )
	     )
ORDER BY pid DESC;
---------------------------

--3 id and name of customers who did not place an order with agent a01
SELECT cid, name
FROM customers
WHERE cid not in(SELECT cid
		  FROM orders
		  WHERE aid = 'a01'
		 );
  ---------------
--4 nice looking query
SELECT cid
FROM customers
WHERE cid in (SELECT cid
              FROM orders
              WHERE pid = 'p01' and cid in(SELECT cid
                                           FROM orders
                                           WHERE pid = 'p07'
                                          )
                     
             );
   -----------------
--5 returns the pid of products not order by any customer who placed an ordered through a07
SELECT pid
FROM products
WHERE pid not in (SELECT pid
                  FROM orders
                  WHERE aid = 'a07'
                 )
ORDER BY pid desc;
 -------------
--6 another nice looking query 
 SELECT name, discount, city
 FROM customers
 WHERE cid in (SELECT cid
               FROM orders
               WHERE aid in (SELECT aid
                             FROM agents
                             WHERE city = 'London' or city = 'New York'
                            )
              );

   -----------------
--7 all the customers who have the same discount as any customer in Dallas or London
SELECT *
FROM customers
WHERE cid not in (SELECT cid
                  FROM customers
                  WHERE city = 'Dallas' or city = 'London'
                 )
                 AND discount in 
                 (SELECT discount
                  FROM customers
                  WHERE city = 'Dallas' or city = 'London'
                 );
   ----------

--8 Constraints: What are they? What are they good for? Advantage?
-- Contraints are limitations or rules used for data in a table. They are good so that the 
-- user entering in sql commands does not do something really stupid and break the database or
-- deleting everything by accident. They are good for keeping someone from deleting something they arent
-- supposed to delete. The CAP3 database for example, if you try deleting an agent from the 
-- agents table postgres will not let you because agents are used in the orders table therefore
-- you have to delete those (the children) first. Alan says that you can kill the children, not
-- the parents (not actual people). 