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
 
 select * from user_ind