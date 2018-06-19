-- -----------------------------------------------------------------------------
-- HANDS ON EXERCISES CHAPTER 9
-- ----------------------------------------------------------------------------
--***-- 7-1 Return the title, retail
-- for all books where retail < avg retail of all books
select title, retail
from books
where retail < ( select avg(retail) from books);

-- 7-2 Determine the books title, retail, catcode
-- that are < avg retail
-- of books in the same category

select title, retail, catcode
from books bo
where retail <
              (
                select avg(retail)
                from books
                where catcode = bo.catcode
              );
              
-- 7-3 Return firstname, lastname, order#
-- of those orders where the
-- shipped to state is the same as Order 1014
select firstname, lastname, order#
from customers join orders using (customer#)
where shipstate =
                  (
                   select shipstate
                   from orders
                   where order# = '1014'
                  );
                  
-- 7.4 return the order# of those orders
-- with a total > order 1008
-- step 1: the inner query
         (
          select sum(quantity*retail)
          from orderitems oi join books b using (isbn)
          where order# = '1008'
         ) ; 
-- step 2 
-- write a sql query that gives a total for each order
-- return the order# and the total order value
select order#, sum(quantity*retail)
from orderitems oi join books b using (isbn)
group by order#;

-- step 3 put them together
select order#, sum(quantity*retail)
from orderitems oi join books b using (isbn)
group by order#
having sum(quantity*retail) > 
                              (
                                select sum(quantity*retail)
                                from orderitems oi join books b using (isbn)
                                where order# = '1008'
                               ) ; 

-- 7.5a return  first and last name of author(s)
-- who wrote the most frequently purchased book
-- step 1 
select max(sum(quantity))
from orderitems
group by isbn;

select fname, lname, isbn, title, sum(quantity)
from orderitems join books using (isbn)
                join bookauthor using (isbn)
                join author using (authorid)
having sum(quantity) = 
                        (
                          select min(sum(quantity))
                          from orderitems
                          group by isbn
                          )
group by fname, lname, isbn, title
order by 5 desc;


-- 7.5b return first last name of customer who purchased
--      the most books

-- 1. return a customer
select firstname, lastname, sum(quantity)
from customers join orders using (customer#)
               join orderitems using (order#)
group by firstname, lastname
having sum(quantity) >= (select sum(quantity)
                         from customers join orders using (customer#)
                                         join orderitems using (order#)
                         group by customer#);                


-- page 353
-- relational operators require the same number of
-- arguments on both sides

select employee_id, last_name, first_name
from employees
where ship_id = (select ship_id
                  from employees
                  where last_name = 'Smith'
                   and first_name = 'Al')
and (last_name, first_name) in (select last_name, first_name
                                 from cruise_customers);
                                 
 
             



select * from cruise_customers;
select * from employees;

select * from cruise_customers;
insert into cruise_customers values(4,'Howard','Hoddlestein');
insert into cruise_customers values(5,'Al','Smith');
insert into cruise_customers values(6,'Alice','Lindon');

commit;
--Howard	Hoddlestein
--Joe	Smith
--Mike	West
--Alice	Lindon
--Al	Smith
--Trish	West
--Buffy	Worthington

-- 2. a list of orders with books counts












select firstname, lastname, sum(quantity)
from customers join orders using (customer#)
               join orderitems using (order#)
having sum(quantity) =
                  (
                    select max(sum(quantity))
                    from orders join orderitems using (order#)
                    group by customer#
                   )
group by firstname, lastname, customer#;

-- 3. Return all columns from ports that has a capacity > avg capacity for all ports
SELECT *
FROM ports
WHERE capacity >
              ( 
                SELECT AVG(capacity) FROM ports
              );
-- 2. What is the name of Joe Smith's captain on cruise_id = 1?
-- Return the ship_id, cruise_id, the captains first and last name
SELECT * FROM cruises;
-- captain_id = 3
SELECT * FROM employees;
-- mike west (emp_id 3) and al smith (emp_id 5) both have 4 (ship_id)
SELECT e.ship_id, c.cruise_id, c.captain_id, e.first_name, e.last_name
FROM cruises c JOIN employees e
                ON c.captain_id = e.employee_id
WHERE e.ship_id =
                  (SELECT ship_id
                  FROM employees
                  WHERE first_name = 'Joe'
                  AND last_name    = 'Smith'
                  )
AND cruise_id = 1;

select * from cruises;
select * from employees;


-- 3. Return all columns from ship cabins that has bigger than the avg
--size balcony for the same room type and room style
SELECT *
FROM ship_cabins s
WHERE balcony_sq_ft >
  (SELECT AVG(balcony_sq_ft)
  FROM ship_cabins
  WHERE s.room_type = room_type
  AND s.room_style  = room_style
  );
SELECT room_type,
  room_style,
  AVG(balcony_sq_ft)
FROM ship_cabins
GROUP BY room_style,
  room_type;
SELECT * FROM ship_cabins;
SELECT *
FROM ship_cabins s1
WHERE s1.balcony_sq_ft >=
  (SELECT AVG(balcony_sq_ft)
  FROM ship_cabins s2
  WHERE s1.room_type = s2.room_type
  AND s1.room_style  = s2.room_style
  );
-- 4. Return employee id and ship id from work_history
--for the employee who has the worked the longest on that ship
SELECT *
FROM work_history;
SELECT employee_id,
  ship_id
FROM work_history w
WHERE (end_date - start_date) =
  (SELECT MAX(end_date-start_date) FROM work_history WHERE w.ship_id = ship_id
  ) ;
SELECT employee_id,
  ship_id
FROM work_history w1
WHERE ABS(start_date         - end_date) =
  (SELECT MAX(ABS(start_date - end_date))
  FROM work_history
  WHERE ship_id = w1.ship_id
  );
SELECT employee_id,
  ship_id
FROM work_history w1
WHERE ABS(start_date     - end_date) >= ALL
  (SELECT ABS(start_date - end_date)
  FROM work_history
  WHERE ship_id = w1.ship_id
  );
--5. Return ship_name and port_name
-- for the ship with the maximum capacity in each home_port
-- ----------------------------------------------------------------------------
SELECT s1.ship_name,
  (SELECT port_name FROM ports WHERE port_id = s1.home_port_id
  ) home_port
FROM ships s1
WHERE s1.capacity =
  ( SELECT MAX(capacity) FROM ships s2 WHERE s2.home_port_id = s1.home_port_id
  );
-- ----------------------------------------------------------------------------
SELECT sh.ship_name,
  pt.port_name,
  sh.capacity
FROM ships sh
JOIN ports pt
ON sh.home_port_id                    = pt.port_id
WHERE (sh.home_port_id, sh.capacity) IN
  ( SELECT home_port_id, MAX(capacity) FROM ships GROUP BY home_port_id
  );
-- ----------------------------------------------------------------------------
SELECT s1.ship_name,
  port_name
FROM ports p
JOIN ships s1
ON p.port_id      = s1.home_port_id
WHERE s1.capacity =
  ( SELECT MAX(capacity) FROM ships s2 WHERE s2.home_port_id = s1.home_port_id
  );
SELECT * FROM ships;
SELECT home_port_id, MAX(capacity) FROM ships s2 GROUP BY home_port_id;
-- -----------------------------------------------------------------------------
-- DO HAND ON EXERCISES Chapter 7 (slides) handouts at home for Saturday
-- -----------------------------------------------------------------------------
-- 7-1
-- Books with retail < average retail for all books
SELECT title,Retail
FROM Books
WHERE Retail >=
              (
                SELECT AVG(Retail) FROM Books
              );
SELECT title,Retail
FROM Books
WHERE Retail >= ALL
  ( SELECT AVG(Retail) FROM Books GROUP BY category
  );
-- -----------------------------------------------------------------------------
-- 7-2
-- Books that cost < than other books in same category
-- lowest or cheapest retail value in each category
SELECT title,b1.category, b1.retail
FROM books b1,
    (SELECT category, MIN(retail) myretail FROM books GROUP BY category
     ) b2
WHERE b1.retail = b2.myretail
AND b1.category = b2.category;

SELECT title, category, retail
FROM books b1
WHERE b1.retail <=
                (
                  SELECT MIN(retail) FROM books b2 WHERE b1.category = b2.category
                );
SELECT * FROM invoices;
SELECT port_id,port_name FROM ports p1
WHERE EXISTS
            ( SELECT * FROM ships s1 WHERE p1.port_id = s1.home_port_id
            );
CREATE TABLE mytest AS (SELECT * FROM ships s1);
SELECT * FROM mytest;
CREATE TABLE mytest2 AS (SELECT ship_name FROM ships );
SELECT * FROM mytest2;

SELECT title, b1.catcode,cost,Avgcost
FROM books b1 ,
  ( SELECT catcode, AVG(Cost) Avgcost FROM Books GROUP BY catcode
  ) b2
WHERE b1.catcode = b2.catcode
  AND b1.cost      < b2.avgcost;
  
SELECT title, cost FROM books WHERE catcode = 'COM';
-- -----------------------------------------------------------------------------
-- 7-3
-- Orders shippd to same state as order 1014
SELECT order#, shipstate
FROM orders
WHERE shipstate IN
                (
                  SELECT shipstate FROM orders WHERE order# = 1014
                );

SELECT order#, shipstate
FROM orders
WHERE (order#, shipstate) IN
                            (
                              SELECT order#, shipstate FROM orders WHERE order# = 1014
                            );
SELECT order#, shipstate
FROM orders
WHERE shipstate =
                    ( SELECT shipstate FROM orders WHERE order# = 1014
                    );
-- -----------------------------------------------------------------------------
-- 7-4
-- Orders with total amount > order 1008
SELECT order#, SUM(quantity*retail)
FROM orderitems oi,
     books b
WHERE oi.isbn = b.isbn
GROUP BY order#
HAVING SUM(quantity *retail) >
              (
                SELECT SUM(quantity*retail)
                FROM orderitems oi,
                     books b
                 WHERE oi.isbn = b.isbn
                 AND order#    = 1008
                GROUP BY order#
              );

SELECT oi.order#, SUM(retail*quantity) total2
FROM orderitems oi ,
  books b1
WHERE oi.isbn = b1.isbn
GROUP BY oi.order#
HAVING SUM(retail*quantity) >
                (SELECT SUM(retail*quantity) total1
                  FROM orderitems oi ,
                       books b
                  WHERE oi.isbn = b.isbn
                    AND order#    = 1008
                    -- group by order#
                );
SELECT oi.order#, SUM(retail*quantity) total2
FROM orderitems oi
JOIN books b1 USING (isbn)
GROUP BY oi.order#
HAVING SUM(retail *quantity) >
                  (
                    SELECT SUM(retail*quantity) total1
                    FROM orderitems oi
                    JOIN books b USING (isbn)
                    WHERE order# = 1008
                  );
-- -----------------------------------------------------------------------------
-- 7-5
-- Which author(s) wrote most frequently purchased book
-- find the title most frequently purchased
-- then bring back the authors
SELECT title,lname,fname,SUM(quantity) myqty
FROM orderitems JOIN books USING (isbn)
                JOIN bookauthor USING(isbn)
                JOIN author USING (authorid)
GROUP BY title, lname, fname
HAVING SUM(quantity) =
                      (
                        SELECT MAX(SUM(quantity)) qty FROM orderitems GROUP BY isbn
                      );

SELECT title,isbn,lname,fname,SUM(quantity) qty
FROM orderitems JOIN books USING (isbn)
                JOIN bookauthor USING (isbn)
                JOIN author USING (authorid)
GROUP BY title,isbn,lname,fname
HAVING SUM(quantity) =
                    ( 
                      SELECT MAX(SUM(quantity)) qty FROM orderitems GROUP BY isbn
                    );
SELECT title,isbn,lname,fname,SUM(quantity) qty
FROM orderitems JOIN books USING (isbn)
                JOIN bookauthor USING(isbn)
                JOIN author USING(authorid)
GROUP BY title,isbn,lname,fname
HAVING SUM(quantity) =
                      (
                        SELECT MAX(SUM(quantity)) qty FROM orderitems GROUP BY isbn
                      );
SELECT title, isbn, lname, fname, SUM(quantity) qty
FROM orderitems oi  JOIN books b USING (isbn)
                    JOIN bookauthor ba USING (isbn)
                    JOIN author a USING(authorid)
GROUP BY title,isbn,lname,fname
HAVING SUM(quantity) =
                      (
                        SELECT MAX(SUM(quantity)) qty FROM orderitems GROUP BY isbn
                      );
-- test count
SELECT b.title,b.isbn, SUM(quantity) qty
FROM orderitems oi ,
  books b
WHERE oi.isbn = b.isbn
GROUP BY b.title,b.isbn;
-- test author
SELECT title,lname,fname
FROM books b ,
  bookauthor ba ,
  author a
WHERE b.isbn    = ba.isbn
AND ba.authorid = a.authorid
AND b.isbn LIKE '%490';
-- -----------------------------------------------------------------------------
-- 7-6
-- All titles in same cat customer 1007 purchased. 
-- Do not include titles purchased by customer 1007.
SELECT distinct title, catcode
FROM books  JOIN orderitems USING(isbn)
            JOIN orders USING (order#)
WHERE catcode IN
                (
                  SELECT distinct catcode
                  FROM orders JOIN orderitems USING (order#)
                              JOIN books USING (isbn)
                  WHERE customer# = 1007
                )
AND customer# <> 1007 ;

SELECT distinct title, catcode
FROM books  JOIN orderitems USING(isbn)
            JOIN orders USING (order#)
WHERE catcode IN
                (
                  SELECT distinct catcode
                  FROM orders JOIN orderitems USING (order#)
                              JOIN books USING (isbn)
                  WHERE customer# = 1007
                )
AND title not in 
                (select title
                 from orders join orderitems using (order#)
                             join books using (isbn)
                 where customer# = 1007
                 );




SELECT DISTINCT title
FROM orders JOIN orderitems USING(order#)
            JOIN books USING(isbn)
WHERE CATCODE IN ('FAL', 'COM', 'CHN')
AND customer# <> 1007;

SELECT DISTINCT (b.title)
FROM books b ,
  (
      SELECT title,
        catcode
      FROM orders o ,
        orderitems oi ,
        books b
      WHERE o.order# = oi.order#
      AND oi.isbn    = b.isbn
      AND customer#  = 1007
  ) b1
WHERE b.catcode = b1.catcode;
AND b.title    <> b1.title;
-- everything purchased by customer 1007
SELECT title, catcode
FROM orders o ,
  orderitems oi ,
  books b
WHERE o.order# = oi.order#
AND oi.isbn    = b.isbn
AND customer#  = 1007;
-- -----------------------------------------------------------------------------
-- 7-7
-- Customer# with city and state that had longest shipping delay
SELECT customer#,city,state,shipdate-orderdate
FROM customers JOIN orders USING (customer#)
WHERE shipdate-orderdate =
                          (
                            SELECT max(shipdate-orderdate) 
                             FROM orders WHERE shipdate IS NOT NULL
                          );
                          
                          
                          
                          
SELECT customer#, city, state, shipdate, orderdate, shipdate - orderdate delay
FROM orders
JOIN customers USING (customer#)
WHERE (shipdate - orderdate) =
                              (
                                SELECT MAX(shipdate - orderdate) delay FROM orders
                              );
SELECT CUSTOMER#,CITY,STATE,SHIPDATE,ORDERDATE,SHIPDATE - ORDERDATE delay
FROM ORDERS JOIN CUSTOMERS USING (CUSTOMER#)
WHERE (SHIPDATE - ORDERDATE) =
                            (
                              SELECT MAX(SHIPDATE - ORDERDATE) delay FROM ORDERS
                            );
SELECT MAX(SHIPDATE-ORDERDATE) FROM orders;
SELECT * FROM CRUISE_ORDERS;
DESC CRUISE_ORDERS;
ALTER TABLE CRUISE_ORDERS
DROP column FIST_TIME_CUSTOMER;
DESC CRUISE_ORDERS;
ROLLBACK;
-- -----------------------------------------------------------------------------
-- 7-8
-- Who purchased least expensive book(s)
SELECT customer#,firstname,lastname,retail
FROM customers  JOIN orders USING (customer#)
                JOIN orderitems USING (order#)
                JOIN books USING (isbn)
WHERE retail = 
              ( 
                SELECT MIN(retail) FROM books
              );
              
              
              
              
SELECT firstname,lastname, title
FROM customers c  JOIN orders o USING (customer#)
                  JOIN orderitems oi USING (order#)
                  JOIN books b USING (isbn)
WHERE retail =
                (
                  SELECT MIN (retail) FROM books
                );
SELECT firstname, lastname, title
FROM customers c ,
  orders o ,
  orderitems oi ,
  books b
WHERE c.customer# = o.customer#
AND o.order#      = oi.order#
AND oi.isbn       = b.isbn
AND retail        =
                    (
                        SELECT MIN (retail) FROM books
                    );
-- -----------------------------------------------------------------------------
-- 7-9
-- How many customers purchased books 
-- written/co-written by James Austin
select count (distinct customer#)
from orders join orderitems using (order#)
            join books using (isbn)
where title in
              (
                select title
                from books join bookauthor using (isbn)
                           join author using (authorid)
                where fname = 'JAMES'
                  and lname = 'AUSTIN'
              );
    








SELECT COUNT(DISTINCT customer#)
FROM orders JOIN orderitems USING (order#)
            JOIN books USING (isbn)
WHERE title IN
              (
                SELECT title
                FROM author
                JOIN bookauthor USING(authorid)
                JOIN books USING(isbn)
                WHERE lname = 'AUSTIN'
                AND fname   = 'JAMES'
              );
-- -----------------------------------
SELECT COUNT(DISTINCT customer#)
FROM orders JOIN
  (
      SELECT title,order#
      FROM orders JOIN orderitems USING (order#)
                  JOIN books USING(isbn)
                  JOIN bookauthor USING (isbn)
                  JOIN author USING (authorid)
      WHERE lname = 'AUSTIN'
      AND fname   = 'JAMES'
  ) USING (order#);
-- ------------------------------------
SELECT COUNT(DISTINCT customer#)
FROM orders JOIN orderitems USING (order#)
            JOIN books USING (isbn)
            JOIN bookauthor USING (isbn)
            JOIN author USING (authorid)
WHERE lname = 'AUSTIN'
AND fname   = 'JAMES';

SELECT COUNT (DISTINCT customer#)
FROM orders o ,
  orderitems oi
WHERE o.order# = oi.order#
AND oi.isbn   IN
                ( 
                  SELECT DISTINCT b.isbn
                  FROM books b ,
                    bookauthor ba ,
                    author a
                  WHERE ba.isbn   = b.isbn
                  AND ba.authorid = a.authorid
                  AND lname       = 'AUSTIN'
                  AND fname       = 'JAMES'
                );
-- books written by James Austin
SELECT DISTINCT b.isbn
FROM books b ,
  bookauthor ba ,
  author a
WHERE ba.isbn   = b.isbn
AND ba.authorid = a.authorid
AND lname       = 'AUSTIN'
AND fname       = 'JAMES';
-- -----------------------------------------------------------------------------
-- 7-10
-- Which books by same publisher as 'The Wok Way to Cook'






















select title, pubid
from books 
where pubid = 
            (select pubid
              from books 
              where title = 'THE WOK WAY TO COOK'
            )
and title <> 'THE WOK WAY TO COOK';









SELECT title, name
FROM books JOIN publisher USING (pubid)
WHERE pubid =
              (
                SELECT pubid
                FROM publisher
                JOIN books USING (pubid)
                WHERE title LIKE '%WOK%'
              )
AND title NOT LIKE '%WOK%';



SELECT title
FROM books
WHERE pubid =
              (
                SELECT pubid
                FROM publisher
                JOIN books USING (pubid)
                WHERE title = 'THE WOK WAY TO COOK'
              );

SELECT title
FROM books
WHERE pubid =
            ( 
              SELECT pubid FROM books WHERE title = 'THE WOK WAY TO COOK'
            );
            
SELECT title
FROM books
WHERE pubid =
              (
                SELECT pubid FROM books WHERE title = 'THE WOK WAY TO COOK'
              );
-- publisher of 'The Wok Way to Cook'
SELECT pubid
FROM books
WHERE title = 'THE WOK WAY TO COOK';
-- -----------------------------------------------------------------------
-- a case for oracle chapter 7
-- -----------------------------------------------------------------------
-- 1.5% surcharge of all orders = $25.90
SELECT SUM(quantity * retail) * .015
FROM orderitems JOIN books USING(isbn);

SELECT SUM(thissum) * .04
FROM
  (SELECT order#,
    SUM(quantity * retail) thissum
  FROM orderitems
  JOIN books USING(isbn)
  HAVING SUM(quantity * retail) >
    (SELECT AVG(mysum)
    FROM
      (SELECT SUM(quantity * retail) mysum
      FROM orderitems
      JOIN books USING(isbn)
      GROUP BY order#
      )
    )
  GROUP BY order#
  );
SELECT SUM(quantity * retail) * .015
FROM orderitems oi ,
  books b
WHERE oi.isbn = b.isbn;
-- 3. sum orders above average = $58.44
SELECT SUM(ordertot) * .04
FROM
  (SELECT order#,
    SUM(quantity * retail) ordertot
  FROM orderitems oi ,
    books b
  WHERE oi.isbn = b.isbn
  GROUP BY order#
  HAVING SUM(quantity * retail) >
    (SELECT AVG(quantity * retail) FROM orderitems JOIN books USING(isbn)
    )
  );
-- 2. orders above average
SELECT order#,
  SUM(quantity * retail) ordertot
FROM orderitems oi ,
  books b
WHERE oi.isbn = b.isbn
GROUP BY order#
HAVING SUM(quantity    * retail) >
  (SELECT AVG(quantity * retail)
  FROM orderitems oi ,
    books b
  WHERE oi.isbn = b.isbn
  );
-- 1. avg order
SELECT AVG(quantity * retail)
FROM orderitems oi ,
  books b
WHERE oi.isbn = b.isbn;
-- 0. total amount of all orders
SELECT SUM(quantity * retail)
FROM orderitems oi ,
  books b
WHERE oi.isbn = b.isbn;