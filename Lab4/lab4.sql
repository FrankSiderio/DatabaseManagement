--1
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

--2
SELECT pid 
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
 --nice query
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
SELECT pid
FROM products
WHERE pid not in (SELECT pid
              FROM orders
              WHERE aid = 'a07'
              
             )
ORDER BY pid desc;
 -------------

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
--7
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
         -------