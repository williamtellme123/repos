-- =============================================================================
/* 

Manu Kapur
        Floundering when learning: 
        “hidden efficacy”: leads to understanding the deep structure of problems, not 
        simply their correct solutions
        
    WORKPLACE CONCEPTS TO DATE
      ETL
      EXTERNAL FILES
      ER DIAGRAMS
      DEBUGGING
      COMMENTING
      
    YOU MASTER FILE
        all_tab_columns
        Chapter 6 etl example (especially case and decode
        Chapter 7 reporting
        Chapter 8 all joins
        Chapter 9 inner joins
        Chapter 10 views, sequences, indexes, synonyms
        Chapter 11 external files
   


   Chapter 11
      0. DEBUGGING
      1. ADD COLUMNS
      2. MODIFY COLUMNS
      3. DROP COLUMNS
      4. SET COLUMNS UNUSED
      5. ADD CONSTRAINTS
      6. DEFERRED
      6. CREATE INDEXES
          Single
          Composite
          Function
      7. FLASHBACK
      8. EXTERNAL TABLES
*/
-- =============================================================================
-- ------------------------------
-- 0. DEBUGGING YOUR SQL
--        Comments
--          select clause
--          from clause
--          where clause
--    a. Place each select expression on its own row with leading comma
--    b. Put each from clause on its own row line up joins (or equals) 
--    c. Place 1=1 after where
--    d. Place each where boolean expressions on its own line
--    e. Comment out to make simplest possible query get it to run
--    f. Uncomment one line at a time to find error
--    g. First fix the syntax errors (get the sql to execute)
--    h. finish by fixing the business logic
--    i. finally add comments or aliases to help you rmemember later
select 
         firstname
       , lastname
       , title
       , (select count(order#) from orders o where o.customer# = c.customer#) as tot_orders
       , (select sum(quantity) from orderitems oi where oi.order# = o.order#) as tot_books
       , fname || ' ' || lname as book_author 
       , category
from 
      customers c join orders o on c.customer# = o.customer#
                  join orderitems oi on o.order# = oi.order#
                  join books b on oi.isbn = b.isbn
                  join bookauthor ba on oi.isbn = ba.isbn
                  join author a on a.authorid = ba.authorid 
where 1=1
  --   Customers from FL or named Bonita who shipped orders to FL or CA
  --   and had bought in the category COMPUTER or FOOD
  and  (firstname = 'BONITA'
   or  state = 'FL'
  and  o.shipstate in ('FL', 'CA'))
  and  category in ('COMPUTER', 'FOOD')
order by 3;   

select * from customers where firstname = 'LEILA';

-- -----------------------------------------------------------------------------
-- 1. ADD COLUMNS 
-- -----------------------------------------------------------------------------
-- adding a column
      desc books;
      alter table books add (sales_price number(9,2));
-- Lets create a column that store clerks can print out on labels called price_tag

-- ------------------------------
-- Now lets create the price_tag like they do for cars on TV :-)
      update books
      set sale_price = retail * .95,
           price_tag = 'Originally' || to_char(retail * 1.1,'$99.99') || ' Now 10% off at ' || retail;
-- ------------------------------
      desc books;
      select * from books;
-- ------------------------------      
      update books set sales_price = retail * .9;
      select sales_price from books;
-- -----------------------------------------------------------------------------
-- 2. MODIFY COLUMNS
-- -----------------------------------------------------------------------------
-- Size
  -- ------------------------------  
  alter table books modify (sales_price number(10,2));

  -- Most often made bigger rarely to change type
  select * from books;
  insert into books values
  ('56565656','This Book has a really really really reall long title','25-AUG-13',1, 45.99, 31.99, 'COMPUTER', 29.99);

  alter table books modify (title varchar2(100));
  alter table books rename column sales_price to discount;
  
  -- MODIFY THE TABLE NAME
  -- ---------------------------------------------------------------------------
  alter table books rename to products;
  -- ---------------------------------------------------------------------------
  alter table products rename to books;

  -- ---------------------------------------------------------------------------
  -- MODIFY SIZE
  alter table books modify (title varchar2(50));
  desc books;

  -- ---------------------------------------------------------------------------
  -- MODIFY DATATYPE (ONLY IF DATA CONVERSION WORKS)
  alter table books modify (isbn integer);
  -- ---------------------------
  -- EASIEST WAY TO PROCEED
  -- 1. add a column
  -- 2. move the data to the new column
  -- 3. convert the datatype
  -- 4. copy the new column back

    -- ---------------------------
    alter table books modify retail number(3,2);
    -- ---------------------------
    alter table books add (tmp_ret number(5,2));
    update books set tmp_ret = retail;
    -- ---------------------------
    update books set retail = null;
    alter table books modify retail number (4,2);
    -- ---------------------------
    update books set retail = tmp_ret;
    -- ---------------------------
    -- EVEN EASIER WAY TO PROCEED
    -- 1. create a new table 
    -- 2. copy data over
    -- 3. remove old table
    -- 4. rename new table to old.
    -- TABLE PAGE 429



-- -----------------------------------------------------------------------------
-- 3. DROP COLUMNS
-- -----------------------------------------------------------------------------
alter table inventory rename to books;
    -- remove the column we just added
    alter table books drop column discount;

-- -----------------------------------------------------------------------------
-- 4. SET COLUMNS UNUSED
-- -----------------------------------------------------------------------------
    --Set columns unused
    alter table books set unused (cost); 
    desc books;
    alter table books drop unused columns;

-- -----------------------------------------------------------------------------
-- 5. ADD CONSTRAINTS
-- -----------------------------------------------------------------------------
    drop user billybooks cascade;
    create user billybooks identified by billybooks;
    grant all privileges to billybooks;

-- LOGIN AS billybooks
-- *****************************************************************************
-- PLEASE LOGIN AS billybooks BEFORE RUNNGING THE FOLLOWING CODE
--        CTAS
--        create table billybooks.customers as select * from books.customers;
--        create table billybooks.orders as select * from books.orders;
--        create table billybooks.orderitems as select * from books.orderitems;
--        create table billybooks.books as select * from books.books;
--        create table billybooks.bookauthor as select * from books.bookauthor;
--        create table billybooks.author as select * from books.author;
--        create table billybooks.publisher as select * from books.publisher;
--        create table billybooks.promotion as select * from books.promotion;
-- *****************************************************************************
-- PLEASE LOGIN AS billybooks BEFORE RUNNGING THE FOLLOWING CODE
        select * from user_cons_columns where table_name = 'CUSTOMERS';
        select * from user_cons_columns where table_name = 'ORDERS';
        select * from user_cons_columns where table_name = 'ORDERITEMS';
        select * from user_cons_columns where table_name = 'BOOKS';
        select * from user_cons_columns where table_name = 'BOOKAUTHOR';
        select * from user_cons_columns where table_name = 'AUTHOR';
        select * from user_cons_columns where table_name = 'PUBLISHER';
-- -----------------------------------------------------------------------------
--        ADD PRIMARY KEYS      
        alter table customers add primary key (customer#);
        alter table orders add primary key (order#);
        alter table orderitems add primary key (order#,item#);
        alter table books add primary key (isbn);
        alter table bookauthor add primary key (isbn,authorid);
        alter table author add primary key (authorid);
        alter table publisher add primary key (pubid);
-- -----------------------------------------------------------------------------
--        ADD FOREIGN KEYS
--  on orders fk to customers(customer#)
    alter table orders add constraint oc_fk foreign key (customer#) references customers(customer#);    
-- ------------------------------------------    
--  on orderitems fk to orders(order#)
    alter table orderitems add constraint oy_o_fk foreign key (order#) references orders(order#);
-- ------------------------------------------
--  on orderitems fk to books (isbn)
    alter table orderitems add foreign key (isbn) references books(isbn);   
-- ------------------------------------------
-- on bookauthor fk to books(isbn)
    alter table bookauthor add foreign key (isbn) references books(isbn);   
-- ------------------------------------------
-- on bookauthor fk to author(authorid)
    alter table bookauthor add foreign key (authorid) references author(authorid);   
-- ------------------------------------------
-- on books fk to publisher(pubid)
    alter table books add foreign key (pubid) references publisher(pubid);   
-- -----------------------------------------------------------------------------
--        ADD UNIQUE KEY
--        The only time this doesn't work is with existing values which are not unique
    alter table books modify title unique;
-- -----------------------------------------------------------------------------    
    --        ADD CHECK CONSTRAINT
    alter table books modify cost check (cost < 5000 and cost > 0);
    -- ---------------------------------------------
      alter table books add binding varchar2(5) 
       constraint ck_bind check (binding in ('Hard','Soft','eBook'));
-- -----------------------------------------------------------------------------    
--        FIND CONSTRAINTS
    select * from user_cons_columns where table_name in 
    ('CUSTOMERS','ORDERS','ORDERITEMS','BOOKS','BOOKAUTHOR','PUBLISHER')
    order by table_name;
-- -----------------------------------------------------------------------------    
    select  uc.constraint_type
    --      ,uc.owner
            ,uc.constraint_name
            ,ucc1.table_name||'.'||ucc1.column_name "constraint_source"
            ,'References => '
            ,ucc2.table_name||'.'||ucc2.column_name "references_column"
    from user_constraints uc
          ,user_cons_columns ucc1
          ,user_cons_columns ucc2
    where uc.constraint_name = ucc1.constraint_name
      and uc.r_constraint_name = ucc2.constraint_name
      and ucc1.position = ucc2.position -- correction for multiple column primary keys.
      --and uc.constraint_type in ('p','r')
      and ucc1.table_name = 'ORDERITEMS' 
    order by ucc1.table_name,uc.constraint_name;
    
select constraint_name, constraint_type
from user_constraints
where table_name = 'ORDERS';
-- -----------------------------------------------------------------------------    
--        RENAME CONSTRAINTS
    alter table customers rename constraint SYS_C008845 to customer_pk;
-- ------------------------------------------
    alter table orders rename constraint SYS_C008846 to orders_pk;

-- -----------------------------------------------------------------------------
-- 6. DEFFERED
--    Constraints IMMEDIATE by default fashion as interpreted (run)
--    Biggest example is not biggest concern 
--      Change myparent keys and cascade to mychild table
drop table myparent cascade constraints; 
create table myparent
  (parent_id int primary key);
  
drop table mychild;  
create table mychild
 ( child_id integer primary key
  , p_id integer constraint child_fk_parent references myparent(parent_id) deferrable initially immediate);

--  Deferred until commit or set
insert into myparent values (10);
insert into mychild values (25, 10);


update myparent set parent_id = 100;
set constraint child_fk_parent deferred;
update myparent set parent_id = 100;
update mychild set p_id = 100;
commit;
-- check before commit;
set constraint child_fk_parent immediate;
-- -----------------------------------------------------------------------------
-- 7. INDEXES
--
--  SINGLE
  select * from user_indexes;
  select * from all_indexes 
  where owner = 'BILLYBOOKS'
   and table_name = 'INVOICES3';
   
    create index ix_lastname on customers (lastname);
-- ------------------------------------------    
    create index ix_title on books (title);
-- ------------------------------------------
-- COMPOSITE
select * from author;
create index ix_author_fullname on author (lname, fname);
-- ------------------------------------------
-- IN THE CREATE TABLE STATEMENT
 create table invoices3
(invoice_id number(11) primary key
             using index (create index ix_inv3 on invoices3(invoice_id)),
 invoice_date date);
-- ------------------------------------------
-- FUNCTIONAL
drop table gas_tanks;  
create table gas_tanks 
(
    gas_tank_id  integer,
    tank_gallons number(5,2),
    mileage number(5,2)
);
-- ------------------------------------------
create index ix_gas_tanks_001 on gas_tanks (tank_gallons * mileage);
-- ------------------------------------------
  insert into gas_tanks values (1, 16, 22.5);
  insert into gas_tanks values (2, 14.5, 28.2);
  insert into gas_tanks values (3, 22.2, 10.3);
  insert into gas_tanks values (4, 15.8, 15.5);
  insert into gas_tanks values (5, 16.1, 34);
  insert into gas_tanks values (6, 17, 46.1);
  insert into gas_tanks values (7, 20, 22);
  insert into gas_tanks values (8, 18, 24);
  insert into gas_tanks values (9, 25, 18);
  commit;
-- ------------------------------------------
-- MAY USE INDEX 
select * from gas_tanks where mileage > 20.1;
-- ------------------------------------------
select * from gas_tanks where tank_gallons < 16;
-- ------------------------------------------
select * from gas_tanks where tank_gallons = 20;
-- WILL USE INDEX 
select rowid, (tank_gallons * mileage) 
from gas_tanks 
where (tank_gallons * mileage) >200
order by 2;

select * from gas_tanks where (mileage * tank_gallons)= 228.66;

-- ------------------------------------------
-- RENAME INDEX 
select * from user_indexes where table_owner = 'BILLYBOOKS';
alter index SYS_C008845 rename to cust_inx;
alter index SYS_C008846 rename to ord_inx;
select * from user_indexes;


-- -----------------------------------------------------------------------------
--  EXERCISES: SELF JOIN 
--- Show first and last names of customers and those people who referred them

-- -----------------------------------------------------------------------------
-- Inner Query 1: Return the order# of those orders with a total > order 1008.
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
-- -----------------------------------------------------------------------------
-- Inner Query 2: Return the employee with the longest work history for each ship
--select *
--from work_history;
--
--select employee_id,ship_id
--from work_history w
--