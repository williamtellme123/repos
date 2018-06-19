-- inner or sub-query can appear in three different
-- locations:
--  1. select clause
--     the subquery must return 1 row and 1 col only (aka scalar)
--  2. from clause
--     the results of subquery can be considered to be just like a table
--     therefore the subquery result set can have many rows and many columns
--  3. where clause
--     still evalutes to a single true or false for each row in the outer query (table)
--     the operators dictate how many values can be on the left
--     e.g. where sysdate > '01-JAN-2014'  (dates on both sides-- 
--          where number1 < number2 
--     they must match in number and type to the values on the right
--     reference pgs 173 and 355


-- first subquery example
-- return title of books in computer category that
-- are less than the aveerage cost of all computer books
select title, retail
from books
where category = 'COMPUTER'
and retail < 52.85;

-- non-correlated sub-query
select title, retail
from books
where category = 'COMPUTER'
and retail < (
              select avg(retail)
              from books
              where category = 'COMPUTER'
              );
              
-- return computer titles that are less than
-- the store average
-- non-correlated sub query
select title, retail
from books
where category = 'COMPUTER'
and retail < (
              select avg(retail)
              from books
              );

-- here is a correlated sub_query
-- return titles in every category
-- which are less than the average for their category
select title, category, retail
from books b1
where retail <= (
                select avg(retail)
                from books b2
                where b2.category = b1.category
              );
-- ORDER of EXECUTION of a correlated sub-query
-- the outer query starts on the first row and gets to the subquery then pauses
-- at the same time the outer query passes in a value from the first row

-- 1a. sub query in a select clause
-- list of expressions aka columns or math or literals
-- this is a non-correlated sub query that returns one row/one colum
-- non-correlated subquery in the select clause
-- it has to return a scalar value 
select title, 
       retail,
       (select round(avg(retail),2) from book
        ) tot_avg
from books;
-- 1b. similar to the first but is now a correlated sub query
-- the outer query stops at each row and passes the value
-- for category into the inner query that runs using the value in its where clause 
select b1.title, 
       b1.retail,
       b1.category,
       (select round(avg(retail),2) 
        from books b2
        where b1.category = b2.category) category_avg
from books b1;
--  2. from clause can also have subqueries
--      this example is of two non-correlated sub queries in the from clause
select a.ship_id, a.count_cabins, b.count_cruises
  from
        ( select ship_id, count(ship_cabin_id) count_cabins
          from ship_cabins
          group by  ship_id
        ) a
  join
        ( select ship_id, count(cruise_order_id) count_cruises
          from cruise_orders
          group by ship_id
        ) b
   on  a.ship_id = b.ship_id;
--
select ship_id, count_cabins, count_cruises
  from
        ( select ship_id, count(ship_cabin_id) count_cabins
          from ship_cabins
          group by  ship_id
        ) 
  join
        ( select ship_id, count(cruise_order_id) count_cruises
          from cruise_orders
          group by ship_id
        ) 
   using (ship_id);
   
select customer#, firstname, order#
from 
      customer 
join       
      orders 
using (customer#) ;      


select * from cruise_orders;
insert into cruise_orders values(1,'01-JUN-12','05-JUN-12',2,1);
insert into cruise_orders values(2,'01-JUN-12','05-JUN-12',2,1);
insert into cruise_orders values(3,'01-JUN-12','05-JUN-12',2,1);
insert into cruise_orders values(4,'01-JUN-12','05-JUN-12',2,1);
commit;






-- 3a. non-correlated sub query in the where clause
--     the innermost query runs once and it runs first
Select title,
       category,
       retail
from books       
where retail <= (select round(avg(retail),2)
                  from books);
-- 3b. correlated sub query in the where clause 
-- the outer query stops at row 1 and it grabs
-- three values and passes one of those values
-- into the subquery in the where clause
-- the subquery then runs and returns a value
-- to the waiting outer query's where clause
select title,
       category,
       retail
from books b1
where retail <= (select avg(retail)
                 from books b2
                 where b1.category = b2.category);
                 
-- page 351
select employee_id, ship_id, last_name, first_name
from employees
where ship_id = any  (
                      select ship_id
                      from employees
                      where last_name = 'Smith'
                     )
and not (last_name = 'Smith');     
  
select * from employees;  
  
                 
-- similar to page 356
select employee_id, last_name, first_name
from employees
where (last_name,first_name, ship_id) in (
                                           select last_name,first_name, ship_id
                                           from employees
                                           where ship_id = 3
                                          );

select * from employees;


select employee_id, last_name, first_name
from employees
where last_name =some  (
                        select last_name
                        from employees
                        where ship_id = 3
                      );
select * from employees;

select employee_id, last_name, first_name
from employees
where last_name in  ('Smith','Lindon');

select first_name,last_name
from employees
where (lower(first_name),lower(last_name)) =some  (select lower(first_name),lower(last_name)
                                    from cruise_customers
                                    );



-- excellent exam question     
select employee_id, ship_id, abs(start_date-end_date)
from work_history w1
where abs(start_date-end_date) >= 
                                  (
                                  select abs(start_date-end_date)
                                  from work_history
                                  where ship_id = w1.ship_id);

select * from work_history;

select employee_id, ship_id, start_date, end_date, abs(start_date-end_date)
from work_history w1;
--54
-- <= all
--100
--54
--156

select * from work_history;

select employee_id
from work_history where abs(start_date-end_date) < 600;

insert into employees (employee_id, ship_id)
values (seq_employee_id.nextval,
        (select ship_id from ships where ship_name = 'Codd Champion')
       ); 
       
select * from employees;      

update invoices inv
  set terms_of_discount = '10 PCT'
  where total_price = (
                        select max(total_price)
                         from invoices
                         where to_char(invoice_date, 'RRRR-Q')=
                               to_char(inv.invoice_date,'RRRR-Q')
                       );        
commit;

delete from ship_cabins s1
where s1.balcony_sq_ft = (
                            select min(balcony_sq_ft)
                            from ship_cabins s2
                            where s1.room_type = s2.room_type
                            and s1.room_style = s2.room_style);
                            
rollback;

-- page 365
-- this returns ports where at least one ship
-- calls this port its home port
select port_id, port_name
from ports p1
where exists (
                select port_id
                from ships s1
                where p1.port_id = s1.home_port_id
              );
select * from ships;              
select * from ports;              
--1	Baltimore
--2	Charleston
--3	Tampa
--4	Miami
--5	Galveston
--6	San Diego
--7	San Francisco
--8	Los Angeles
--9	Honolulu
--10	St. Thomas
--11	San Juan
--12	Nassau
--13	Grand Cayman             
              
              
-- page 366
-- with clause
with 
    port_bookings as 
    (
       select p.port_id,p.port_name,count(s.ship_id) ct
       from ports p, ships s
       where p.port_id = s.home_port_id
       group by p.port_id,p.port_name
       
        --1	Baltimore	1
        --2	charleston	4
        --3	Tampa	2
    ),
    densest_port as
    (
      select max(ct) max_ct
      from port_bookings
      -- 4
    )
select port_id, port_name, ct
from port_bookings
where ct = (select max_ct from densest_port);

select firstname
from customers;

create table mycust2
as select firstname,lastname,city,state
   from customers;
desc mycust2;   

select * from mycust2;




create table mycust (fname,lname)
as (select firstname,lastname
   from customers
   where state = 'FL');
   
-- question 10
select s1.ship_name, (select port_name
                      from ports
                      where port_id = s1.home_port_id) home_port
from ships s1
where s1.capacity = (select min(capacity)
                      from ships s2
                      where s2.home_port_id = s1.home_port_id);
select * from ships;                      
                    
					
					
-- page 364
UPDATE ports p
SET capacity = (
				SELECT COUNT(*) FROM ships WHERE home_port_id = p.port_id
			  )
WHERE EXISTS
		  ( 
				SELECT * FROM ships WHERE 
				home_port_id = p.port_id
		  );
		  
-- WITH STATEMENT
WITH PORT_BOOKINGS AS
  (SELECT P.PORT_ID,P.PORT_NAME, COUNT(S.SHIP_ID) CT
  FROM PORTS P, SHIPS S
  WHERE P.PORT_ID = S.HOME_PORT_ID
  GROUP BY P.PORT_ID,
    P.PORT_NAME
  ),
  densest_port AS
  ( SELECT MAX(CT) MAX_CT FROM PORT_BOOKINGS
  )
SELECT PORT_NAME
FROM PORT_BOOKINGS
WHERE CT =
  (SELECT MAX_CT FROM DENSEST_PORT
  );
  
-- EXISTS  
-- page 365 bottom
SELECT port_id,
  port_name
FROM ports p1
WHERE EXISTS
  (SELECT * FROM ships s1 WHERE p1.port_id = s1.home_port_id
  );  
  
  
select * from employees; -- first_name last_name
-- Howard	Hoddlestein
-- Joe	Smith
-- Mike	West
-- Alice	Lindon
-- Al	Smith
-- Trish	West
-- Buffy	Worthington

select * from cruise_customers;
insert into cruise_customers values (4, 'Joe', 'Smith');
insert into cruise_customers values (5, 'Al', 'Smith');
insert into cruise_customers values (6, 'Buffy','Worthington');
commit;

select first_name, last_name
from employees
where (first_name, last_name) in (select first_name, last_name
                                from cruise_customers);

