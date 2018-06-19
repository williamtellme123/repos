-- Chapter 9
-- the three locations where an inner query can be used
-- 1. In the select statement
--    Sub Q in the select caluse must be scalar
--    scalar means it returns 1 col and 1 row
select title
       ,(select avg(retail) from books b2 where b1.category = b2.category)as avg_cat
       ,(select sysdate from dual) as mydate
       , cost  
       , category
from books b1;


-- 2. In the From statement(page 390)
--    book refers to this as an inline view.
--    Each of these create a result set
--    that the outer query intreprets as a table.
--    Meaning if you need to extract columns from this inner query
--    you need to use the alias for the inner query
select a.ship_id, a.count_cabins, b.count_cruises
from 
      (
         select ship_id, count(ship_cabin_id) count_cabins
         from ship_cabins
         group by ship_id
       ) a
       join 
       (
          select ship_id, count(cruise_order_id) count_cruises
          from cruise_orders
          group by ship_id
        ) b
on a.ship_id = b.ship_id;  



-- 3. In the where clause (page 351)
--    Nuance is that the relational operator
--    expects the same number of values on both sides
select employee_id, last_name, first_name
from employees
where ship_id = (
                   select ship_id
                   from employees
                   where first_name = 'Alice'
                     and last_name = 'Lindon'
                 )
and first_name <> 'Alice'
and last_name <> 'Lindon';


-- lets see an example of two values instead of one
select employee_id, last_name, first_name
from employees
where (first_name,last_name) =any
                                (
                                  select first_name, last_name
                                  from cruise_customers
                                );


select * from employees;
--3	4	Mike	West
--4	3	Alice	Lindon
--5	1	Al	Smith
--6	2	Trish	West

select * from cruise_customers;
insert into cruise_customers values (4,'Mike','West');
insert into cruise_customers values (5,'Al','Smith');
insert into cruise_customers values (6,'Trish','West');
commit;


-- ----------------------------------------------------------
-- non-correlated inner query
-- and a correlatred inner query
-- ----------------------------------------------------------
-- non-correlated
-- 1. The inner query runs once and runs first
-- 2. It passes a value(s) to the main outer query once
-- 3. The outer query uses that inner result
--    for every row of the table in the outer query
-- 4. The inner query does not depend on the outer query
--    in other words you can run the innner query
--    by itself by selecting it and choosing run
select employee_id, last_name, first_name
from employees
where ship_id = (
                select ship_id
                 from employees
                 where first_name = 'Alice'
                   and last_name = 'Lindon'
                 )
and first_name <> 'Alice'
and last_name <> 'Lindon';

-- correlated inner query
-- 1. the outer query begins on row 1
-- 2. it then passes some value into the inner query from row 1
-- 3. the inner query then runs using that passed value
-- 4. the inner query passes that value back to the 
--    waiting outer query which completes for that row (in Step No. 1 above) 
-- 5. repeat steps 1-4 for each row in the outer query
-- 6. the inner canot be run by iteself
-- 7. the inner runs once for every row of the outer query
select title, retail
from books b1
where b1.retail < (
                     select avg(retail)
                     from books b2
                     where b2.category = b1.category
                   );
select * from books;
-- 30.95
-- 1. the outer query begins on row 1
-- 2. it then passes CATEGORY = FITNESS into the inner query from row 1
-- 3. the inner query then runs using FITNESS 
-- 4. the inner query passes 30.95 back to the 
--    waiting outer query which completes for that row (in Step No. 1 above) 
-- 5. repeat steps 1-4 for each row in the outer query
-- 6. the inner canot be run by iteself
-- 7. the inner runs once for every row of the outer query
           
-- select * from customers;               
select firstname, lastname, state, order#, shipstate
from customers c, orders o
where c.customer# = o.customer#
and state not in (select shipstate
                  from orders o
                  where o.customer# = c.customer#);
               


select * 
from books
where retail < 25;

select * 
from books
where retail = 25;

select *
from books
where retail in (75.95, 25, 54.5);

select *
from books
where retail > any (75.95, 25, 54.5);

select *
from books
where retail > all (75.95, 25, 54.5);

select *
from books
where retail < any (75.95, 25, 54.5);

-- Chapter 8 review
create table emp
(eid      integer,
 fname    varchar2(15),
 lname    varchar2(15));
 
insert into emp values(100,'Bucky','Highcoat');
insert into emp values(101,'Sammy','Sidewalk');
insert into emp values(102,'Betsy','Wilding');
select * from emp;
commit;

drop table stores;
create table stores
(sid     integer,
 emp_id  integer,
 store   varchar2(15),
 city    varchar2(15),
 state varchar2(2));
alter table emp modify column (eid) rename to eid;

insert into stores values(9999,901,'South','Atlanta','GA');
insert into stores values(10000,101,'NeoTunes','Austyn','CT');
insert into stores values(10001,100,'BenJerrys','Waterbury','VT');
insert into stores values(10002,101,'PennyBooks','Houston','FL');
select * from stores;
commit;

-- inner equi-join recap
select fname, lname, store
from emp e join stores s on e.eid = s.emp_id;

-- left outer join recap
select fname, lname, store
from emp e left join stores s 
on e.eid = s.emp_id;

-- right outer join recap
select fname, lname, store
from emp e right join stores s 
on e.eid = s.emp_id
where fname is null or lname is null;

-- full outer join recap
select fname, lname, store
from emp e full join stores s 
on e.eid = s.emp_id
where fname is null and lname is null
  or store is null;

-- revisit the non-correlated
-- want return all the co-workers for Al Smith (without Al)
-- find the ship_id that Al works on
select employee_id, last_name, first_name
from employees 
where ship_id = 1
and first_name <> 'Al'
and last_name <> 'Smith';

select ship_id
from employees
where last_name = 'Smith' and first_name = 'Al';
-- #################################################
select employee_id, last_name, first_name
from employees 
where ship_id = ( 
                  select ship_id
                  from employees
                  where last_name = 'Smith' and first_name = 'Al'
                 )
and first_name <> 'Al'
and last_name <> 'Smith';







create table mybooks
(title  varchar2(10),
 retail number(5,2),
 category varchar2(10));
 
insert into mybooks values('Monkeys',20.00,'Animals');
insert into mybooks values('Gators',22.00,'Animals');
insert into mybooks values('Beef Soup',30.00,'Cooking'); 
insert into mybooks values('Sauces',28.00,'Cooking');
select * from mybooks;
commit;

-- revisit the correlated
-- want return all titles < avg(retail) for 
-- all books in the same category
select title, retail, category
from mybooks
where category = 'Animals';

select avg(retail)
from mybooks
where category = 'Animals';

select avg(retail)
from mybooks
where category = 'Cooking';




select title, retail, category
from mybooks
where retail < (
                select avg(retail)
                from mybooks
                where category = 'Animals'
                )
and category = 'Animals';                
select * from mybooks;
-- Monkeys	  20	Animals
-- Gators	    22	Animals
-- Beef Soup	30	Cooking
-- Sauces	    28	Cooking

select title, retail, category
from mybooks b
where retail < (select avg(retail)
                from mybooks
                where category = b.category);

select title, retail, category
from mybooks;



--1.	Inner Query 2
--Write an English statement in 1-3 sentences that describes what the following query does. You can run it to see what it does before you answer.
SELECT *
FROM ship_cabins s
WHERE balcony_sq_ft >
                      (
                        SELECT AVG(balcony_sq_ft)
                         FROM ship_cabins
                         WHERE s.room_type = room_type
                           AND s.room_style  = room_style
                      );
--;or balcony_sq_ft is null;
                      
                      
--2.	Inner Query 3
--Return first and last name of the customer(s) who purchased the most books.
--Is this a correlated or non-correlated query?

--3.	Inner Query 4
--Write an English statement in 1-3 sentences that describes what the following query does. You can run it to see what it does before you answer.

SELECT * FROM work_history;



SELECT employee_id,ship_id
FROM work_history w
WHERE abs((end_date - start_date)) =
                                    (
                                      SELECT MAX(end_date - start_date) 
                                      FROM work_history 
                                      WHERE w.ship_id = ship_id
                                     ) ;

--4.	Inner Query 5
Return the ships name and it's home port's name for each ship with the maximum capacity for their home port

select * from ships;
select * from ports;

select ship_name, port_name, port_id, s.capacity
from ships s join ports p on s.home_port_id = p.port_id
where s.capacity = 
                (
                  select max(capacity)
                  from ships
                  where s.home_port_id = home_port_id
                );
-- answer
--Codd Crystal	Baltimore	1	2052
--Codd Voyager	Charleston	2	3114
--Codd Victorious	Tampa	3	2974

--1	Codd Crystal	  2052	855	    1
--2	Codd Elegance	  2974	952	    3
--3	Codd Champion	  2974	952	  null
--4	Codd Victorious	2974	952	    3
--5	Codd Grandeur	  2446	916	    2
--6	Codd Prince	    395	  470	    2
--7	Codd Harmony	  940	  790	    2
--8	Codd Voyager	  3114	1020	  2
--9	Codd_Victory    null  null  null			



-- 5.	Inner Query 6
-- Return the title and cost of each book that is the least expensive in each category






--6.	Inner Query 7
--Write an English statement in 1-3 sentences that describes what the following query does. You can run it to see what it does before you answer.

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

--7.	Inner Query 8
--Write an English statement in 1-3 sentences that describes what the following query does. You can run it to see what it does before you answer.

select *
from customers c
where exists (
    select *
    from orders o
    where o.customer# = c.customer#
  );



select * from ship_cabins s1
where s1.balcony_sq_ft =
                          (
                           select min(balcony_sq_ft)
                           from ship_cabins s2
                           where s1.room_style = s2.room_style
                           and s1.room_type = s2.room_type
                          );

rollback;
select * from ship_cabins s1
order by 4,5;

select port_id, port_name
from ports p1
where exists (
                select * 
                from ships s1
                where p1.port_id = s1.home_port_id
              );
 
select * from ports p1;
select * from ships;


with 
    port_bookings as
    (
      select p.port_id, p.port_name, count(s.ship_id) as ct
      from ports p, ships s
      where p.port_id = s.home_port_id
      group by p.port_id,p.port_name
    ),
    densest_port as
    (
      select max(ct) as max_ct
      from port_bookings
    )
select port_name
from port_bookings
where ct = (
              select max_ct
              from densest_port
            );  
 
 
select s1.ship_name 
       , (select port_name from ports where port_id = s1.home_port_id) home_port
from ships s1
where s1.capacity = 
                    (
                      select min(capacity)
                      from ships s2
                      where s2.home_port_id = s1.home_port_id
                    );
   
-- CTAS                   
create table books100
as select * from books;
                    