drop table cust;
drop table ords;

create table cust as
select customer#, firstname,lastname
from customers;

drop table ords;
create table ords as
select order#,customer#,shipstate
from orders;

select * from cust;
select * from ords;

select *
from cust, ords;
-- INNER JOINS in the city
-- as an intermediate step to all joins
-- we get behind the scenes a cartesian product
-- 1. rows returned as rows.table1 * rows.table2
-- 2. columns returned from table1 and table2
-- --------------------------------------------
-- old school method of an equi-join aka INNER join
select cust.customer#, firstname, lastname, order#
from cust, ords
where cust.customer# = ords.customer#;
-- --------------------------------------------
select c.customer#, firstname, lastname, order#
from cust c, ords o
where c.customer# = o.customer#;
-- ----------------------------------------------
select c.customer#, firstname, lastname, count(order#)
from cust c, ords o
where c.customer# = o.customer#
group by c.customer#, firstname, lastname
having count(order#) > 1;

-- new school number 1 of an equi-join
select c.customer#, firstname, lastname, order#
from cust c INNER join ords o on c.customer# = o.customer#
where lastname = 'GIRARD';

-- new school number 2 of an equi-join aka INNER
-- when "using" then do not give table alias
-- when "using" then both tables must have identical column names
select customer#, firstname, lastname, order#
from cust INNER join ords using(customer#)
where lastname = 'GIRARD';

-- ---------------------------
-- OUTER JOINS in the city
-- Three types
--    LEFT
--    RIGHT
--    FULL
-- Returns two kinds of rows
--    1. the same rows that come from an INNER JOIN
--    2. (Left) it also brings back all of the unmatched rows
--        with null values for the right hand table
-- ---------------------------
-- old school version of a left outer join
select cust.customer#, firstname, lastname, order#
from cust, ords
where cust.customer# = ords.customer#(+)
 and order# is null;
 
-- new school version no 1 of a left outer join
select cust.customer#, firstname, lastname, order#
from cust left join ords on cust.customer# = ords.customer#
where order# is null;

-- new school version no 2 of a left outer join
select customer#, firstname, lastname, order#
from cust left join ords using(customer#)
where order# is null;
-- reverse table order and use opposite outer qualifier
select customer#, firstname, lastname, order#
from ords right join cust using(customer#)
where order# is null;

-- technique of formatting when doing multiple table joins
select distinct firstname, lastname, title
from customers join orders using(customer#)
               join orderitems using(order#)
               join books using (isbn);
              
-- natural join 
select firstname, lastname, order#
from customers natural join orders;

-- non equi-join
select title, gift, retail
from books, promotion
where retail >= minretail
 and retail <= maxretail;

-- self join
select customer#, firstname, lastname, referred
from customers;

select c1.firstname, c1.lastname, 'Referred ->', c2.firstname, c2.lastname
from customers c1, customers c2
where c1.customer# = c2.referred;

-- hierarchical self join query
select * 
from employee_chart;

select level, employee_id, lpad(' ', level *2) || title
from employee_chart
start with employee_id = 1
connect by reports_to = prior employee_id;

