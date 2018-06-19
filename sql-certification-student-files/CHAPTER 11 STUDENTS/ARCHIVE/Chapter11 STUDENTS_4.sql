--step-wise instead of nested for concatenate

-- =============================================================================
/* 
   Chapter 11 
        
      ADD COLUMNS
      MODIFY COLUMNS
      DROP COLUMNS
      SET COLUMNS UNUSED
      ADD CONSTRAINTS
      CREATE INDEXES
        Single
        Composite
        Function
      FLASHBACK
      EXTERNAL TABLES
*/
-- =============================================================================
-- ------------------------------
-- ADD COLUMNS 
-- adding a column
desc books;
alter table books add (sales_price number(7,2));
desc books;
select * from books;
update books set sales_price = retail * .9;
select sales_price from books;
-- ------------------------------
-- MODIFY COLUMNS
-- Size
-- --------
-- Most often made bigger rarely to change type
select * from books;
insert into books values
('56565656','This Book has a really really really reall long title','25-AUG-13',
 1, 45.99, 31.99, 'COMPUTER', 29.99);
alter table books modify title ();
-- Size
-- --------
alter table books modify (title varchar2(50));
desc books;
-- Modify datatype (only if data conversion works)
-- --------
alter table books modify (isbn integer);
-- ---------------------------
-- easiest way to proceed
-- 1. add a column
-- 2. move the data to the new column
-- 3. convert the datatype
-- 4. copy the new column back
-- ---------------------------
-- even easier way to proceed
-- 1. create a new table 
-- 2. copy data over
-- 3. remove old table
-- 4. rename new table to old.





--Drop columns


--
--Set columns unused
--
--add constraints

create table c as select * from customers;
create table o as select * from orders;
create table oi as select * from orderitems;
create table b as select * from books;
create table ba as select * from bookauthors;
create table a as select * from authors;
create table p as select * from publishers ;
create table pr as select * from promotion; 

drop table customers cascade constraints;
drop table orders cascade constraints;
drop table orderitems  cascade constraints;
drop table books  cascade constraints;
drop table bookauthors  cascade constraints;
drop table authors  cascade constraints;
drop table publishers  cascade constraints;
drop table promotion cascade constraints;

alter table c rename to customers;
alter table o rename to orders;
alter table oi rename to orderitems;
alter table b rename to books;
alter table ba rename to bookauthors;
alter table a rename to authors;
alter table p rename to publishers;
alter table pr rename to promotion;



 
-- modify a column width to be large
alter table books modify title varchar2(100);
desc books;

select * from books;
desc books;

alter table books modify retail number(4,2);

alter table books add (tmp_ret number(5,2));
update books set tmp_ret = retail;

update books set retail = null;
alter table books modify retail number (4,2);

update books set retail = tmp_ret;




desc books;
alter table books drop column sales_price;
alter table books drop column tmp_ret;

desc books;

alter table books add (sales_price number(5,2));
select * from books;

alter table books add (tmp_ret number(5,2) default 1);
select * from books;

update books set sales_price = retail*.9;
select * from books;

select title from books;

alter table books modify title varchar2(100);
desc books;

alter table books modify retail number(5,2);
desc books;

alter table books modify retail number(4,2);

alter table books modify title varchar2(70);

alter table books rename column sales_price to new_retail;

create table tmp_books as select * from books;
-- -----------------------------------------------
-- data types
-- 1. the only time this works is when no data in column or
--    when no rows
-- ----------------------------------------------- 
-- precision and scale
-- 1. when modifying precision and scale for number datatype
--    if there is data you can only increase
-- 2. for varchar2 we can decrease size to maximum value of current data
--    and can increase without problem
-- -----------------------------------------------
-- not null
-- 1. cannot modify if col has nulls
-- 2. cannot be used with a default unless there are no null values (page 430)
select * from tmp_books;
update tmp_books set tmp_ret = null where category = 'COMPUTER';
alter table tmp_books modify tmp_ret number(5,2) default 100;

alter table tmp_books modify tmp_ret number(5,2) default 100 not null;

update tmp_books set tmp_ret = retail * .9 where tmp_ret is null;
select * from tmp_books;

alter table tmp_books modify tmp_ret number(5,2) default 100 not null;

select * from tmp_books;

-- Primary Key
alter table tmp_books modify isbn primary key;

-- Unique Key
-- 1. the only time this doesn't work is with existing values which are not unique
alter table tmp_books modify title unique;

-- FK

-- CHK
alter table tmp_books modify cost check (cost < 5000);
-- DEFAULT
-- see book


-- unused
-- to use this in the productoin environment during use (the day shift)
-- then at night and drop the unused cols
alter table tmp_books set unused column tmp_ret;
desc tmp_books;

alter table tmp_books drop unused columns;
drop table tmp_books;

-- add some contraints
-- primary key
  -- customers
  -- orders
  -- orderitmes
  -- books
  -- bookauthors
  -- authors
  -- publishers
alter table customers modify customer# primary key;
alter table orders modify order# constraint ord_pk primary key;
alter table orderitems add constraint oi_pk primary key (order#,item#);
alter table books modify isbn primary key;
alter table bookauthor add constraint ba_pk primary key (isbn,authorid);
alter table author modify authorid primary key;
alter table publisher modify pubid primary key;

select * from user_cons_columns where table_name = 'CUSTOMERS';
select * from user_cons_columns where table_name = 'ORDERS';
select * from user_cons_columns where table_name = 'ORDERITEMS';
select * from user_cons_columns where table_name = 'BOOKS';
select * from user_cons_columns where table_name = 'BOOKAUTHOR';
select * from user_cons_columns where table_name = 'AUTHOR';
select * from user_cons_columns where table_name = 'PUBLISHER';

-- foreign keys
    --on orders fk to customers(customer#)
alter table orders add foreign key (customer#) references customers(customer#);    
    --on orderitems fk to orders(order#)
alter table orderitems add constraint oi_o_fk foreign key (order#) references orders(order#);
    --on orderitems fk to books (isbn)
alter table orderitems add foreign key (isbn) references books(isbn);   
    --on bookauthor fk to books(isbn)
alter table bookauthor add foreign key (isbn) references books(isbn);   
    --on bookauthor fk to author(authorid)
alter table bookauthor add foreign key (authorid) references author(authorid);   
    --on books fk to publisher(pubid)
alter table books add foreign key (pubid) references publisher(pubid);   

select * from user_cons_columns where table_name in 
('CUSTOMERS','ORDERS','ORDERITEMS','BOOKS','BOOKAUTHOR','PUBLISHER')
order by table_name;

select *
from customers
where customer# in (select customer#
                    from orders
                    where order# in (select order#
                                     from orderitems
                                     )
                );                  

-- 1 (1010)
select * from customers where customer# = 1010;
-- 2 (1001,1011)
select * from orders where customer# = 1010;
-- 3 
select * from orderitems where order# in (1001,1011);

alter table orderitems add constraint oi_pk primary key(order#,item#);
alter table orderitems add constraint oi_o_fk foreign key (order#)
             references orders(order#) on delete cascade;
alter table orderitems add constraint oi_b_fk foreign key(isbn)
             references books(isbn);
             
delete from customers where customer# = 1010;


-- cruises schema
create table invoices2
(invoice_id number(11) primary key,
 invoice_date date);
 
 select * from user_indexes
 where table_name = 'INVOICES3';
 
create table invoices3
(invoice_id number(11) primary key
             using index (create index ix_inv3 on invoices3(invoice_id)),
 invoice_date date);
 
create table gas_tanks 
(gas_tank_id  number(7),
 tank_gallons number(9),
 mileage number(9));
 
 create index ix_gas_tanks_001 on gas_tanks (tank_gallons * mileage);
 
 insert into gas_tanks values(1, 20, 22);
 insert into gas_tanks values(2, 18, 24);
 insert into gas_tanks values(3, 25, 18);
 
 select * from gas_tanks;
 commit;
 
 select * from employees;
 select rowid, last_name from employees order by last_name;
 
 select rowid, (tank_gallons * mileage)
 from gas_tanks order by 2;
 
 select * from gas_tanks
 where (mileage* tank_gallons)=440;
 
 select dbms_flashback.get_system_change_number from dual;
 
 select ora_rowscn, scn_to_timestamp(ora_rowscn)
 from gas_tanks;
 
 select * from gas_tanks;
 commit;
 create restore point gt_01;
 
 delete from gas_tanks;
 select * from gas_tanks;
 
 flashback table gas_tanks to restore point gt_01;
 rollback to restore point gt_01;
 select * from invoices_external;
 

-- adding and modifying columns on existing tables
select * from books;

desc books;

alter table books add sale_price number(5,2);
alter table books add price_tag varchar2(50);

desc books;

select * from books;

update books
  set sale_price = retail * .95,
       price_tag = 'Originally' || to_char(retail * 1.1,'$99.99') || ' Now 10% off at ' || retail;

select title, retail, sale_price, price_tag from books; 

create or replace synonym my_oi_syn for orderitems_bu;

select * from my_oi_syn;
  
select * from orderitems_bu;
create or replace synonym my_syn for orderitems_bu;
select * from my_syn;


-- Inner Query 1: Orders > Order 1008
-- Return the order# of those orders with a total > order 1008.
-- Is this a correlated or non-correlated query?
--
--
--select order#, sum(quantity*retail)
--from orderitems join books using (isbn)
--group by order#
--having sum(quantity*retail) >
--(
--  select sum(quantity*retail)
--  from orderitems join books using (isbn)
--  where order# = 1008
--  group by order#
--);
--
--
--select *
--from work_history;
--
--select employee_id,ship_id
--from work_history w
--where abs((end_date - start_date)) =
--          (select max(end_date-start_date) 
--          from work_history 
--          where w.ship_id = ship_id);
--          
--select * from work_history; 
--
--
--
--
--
---- Question 10
---- Inner Query 5: Maximum capacity Ship and its home port name
---- Return the ship's name and its home port's name 
---- for each ship with the maximum capacity 
---- for their home port. Is this a correlated or non-correlated query?
--
---- Return the ship name and port_name for its port_name
--select * from ships;
--select * from ports;
--
--select ship_name, port_name, s.capacity
--from ships s join ports p1 on (home_port_id = port_id)
--where s.capacity = 
--                  (select max(s.capacity)
--                   from ships s join ports p2 on (home_port_id = port_id)
--                   where p1.port_id = p2.port_id 
--                  );
--
--select ship_name, port_name, s.capacity
--from ships s join ports p1 on (home_port_id = port_id);
--
--
---- 12.	Inner Query 7
---- Write an English statement in 1-3 sentences 
---- that describes what the following query does. 
---- You can run it to see what it does before you answer. 
---- Is this a correlated or non-correlated query?
--select e.ship_id, c.cruise_id, c.captain_id, e.first_name, e.last_name
--from cruises c join employees e
--on c.captain_id = e.employee_id
--where e.ship_id =
--                  (
--                  select ship_id
--                  from employees
--                  where first_name = 'Joe'
--                  and last_name    = 'Smith'
--                  )
--and cruise_id = 1;
--select * from ships;
--select * from cruises;
--
--select * from ships;

-- adding and modifying columns
desc books;
alter table books modify (title varchar2(150));

select * from books;

alter table books add binding varchar2(5) 
       constraint ck_bind check (binding in ('Hard','Soft','eBook'));

select title, category, binding from books;

update books set binding = 'Soft'
        where category = 'COMPUTER';
        
update books set binding = 'Hard'
where category in ('LITERATURE','COOKING');

update books set Binding = 'eBook'
where binding is null;

select title, category, binding
from books;

commit;


alter table books add binding varchar2(5) 
       constraint ck_bind check (binding in ('Hard','Soft','eBook'));

alter table books add store varchar2(15) default 'Main';




select title, category, binding, store from books;

create table books_11 as
create table books_no_data as select * from books where 1 = 2;

alter table books_11 modify (sale_price varchar2(15));
alter table books_no_data modify (sale_price varchar2(15));

desc books_11;
alter table books_11 modify (retail number(7,2));
alter table books_11 modify (retail number(4,2));
alter table books_no_data modify (retail number(4,2));

update books_11 set sale_price = null;
commit;

alter table books_11 modify (sale_price number(5,2) not null); 
alter table books_11 modify (retail not null); 
select retail from books_11;

select isbn from books_11;
alter table books_11 modify (isbn primary key);

alter table books_11 rename column title to book_title;

-- drop columns and set unused
-- drop columns if lots of data it takes a long time
-- set unused happen immediately but remains in the table
-- as an invisbile column that can later be dropped during
-- off-peak hours

desc books_11;
alter table books_11 drop column store;
desc books_11;
alter table books_11 set unused column binding;
desc books_11;
alter table books_11 drop unused columns;


create table customers_11 as 
select * from customers;

create table orders_11 as
select * from orders;

create table orderitems_11 as
select * from orderitems;

create table books_11 as
select * from books;

alter table customers_11 modify customer# constraint pk_c# primary key;
alter table orders_11 modify order# primary key;
alter table books_11 modify isbn primary key;
alter table orderitems_11 add constraint pk_oi primary key(order#,item#);

alter table orders_11 add constraint fk_c foreign key (customer#)
      references customers_11(customer#);

alter table orders_11 drop constraint fk_c;

alter table orderitems_11 add foreign key(order#) references orders_11(order#); 
alter table orderitems_11 add foreign key(isbn) references books_11(isbn);

alter table books_11 drop primary key cascade;

drop table customers_11 cascade constraints;

select * from user_constraints;

alter table customers rename constraint SYS_C007608 to pk_customers;
-- page 455
create table invoices_11
(invoice_id  number(11) primary key
                        using index (create index ix_invoices
                                     on invoices_11(invoice_id)),
 invoice_date date
);

-- page 457
-- function-based index
-- 
create table gas_tanks
(gas_tank_id number(7),
 tank_gallons number(9),
 mileage  number(9));
 
insert into gas_tanks values (1,20,32);
insert into gas_tanks values (2,24,34);
insert into gas_tanks values (3,40,6);
commit;

create index ix_gas_tanks_001 on gas_tanks(tank_gallons*mileage);

select * from gas_tanks 
where mileage*tank_gallons > 20;

-- psuedo code
-- create table called houdini
-- insert some rows
-- commit the insertions
-- drop table
-- 
-- flashback table houdini to before drop;
-- recycle bin is where any object is placed
-- when dropped and until purged.
-- purge an obejct
-- purge table houdini;
-- purge recyclebin;

-- flashback to
--   1. to a system change number (scn)
--   2. to a particular point in time expressed as a timestamp
--   3. to a restore point (data objects) [vs a savepoint which is data only]

-- SCN encoded timestamp
select dbms_flashback.get_system_change_number from dual;

select * from books_11;

select title, ora_rowscn, scn_to_timestamp(ora_rowscn)
from books_11;




select * from user_constraints;





        
        
        
