-- =============================================================================
/* 
   Chapter 11 
      1. ADD COLUMNS
      2. MODIFY COLUMNS
      3. DROP COLUMNS
      4. SET COLUMNS UNUSED
      5. ADD CONSTRAINTS
      6. CREATE INDEXES
          Single
          Composite
          Function
      7. FLASHBACK
      8. EXTERNAL TABLES
*/
-- =============================================================================
-- ------------------------------
-- 1. ADD COLUMNS 
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
    alter table inventory rename to books;
    -- remove the column we just added
    alter table books drop column discount;

-- -----------------------------------------------------------------------------
-- 4. SET COLUMNS UNUSED
    --Set columns unused
    alter table books set unused (cost); 
    desc books;
    alter table books drop unused columns;

-- -----------------------------------------------------------------------------
-- 5. ADD CONSTRAINTS
    create user mybooks identified by mybooks;
    grant all privileges to mybooks;
    
    

-- LOGIN AS MYBOOKS
-- *****************************************************************************
-- PLEASE LOGIN AS MYBOOKS BEFORE RUNNGING THE FOLLOWING CODE
--        CTAS
--        create table mybooks.customers as select * from books.customers;
--        create table mybooks.orders as select * from books.orders;
--        create table mybooks.orderitems as select * from books.orderitems;
--        create table mybooks.books as select * from books.books;
--        create table mybooks.bookauthor as select * from books.bookauthor;
--        create table mybooks.author as select * from books.author;
--        create table mybooks.publisher as select * from books.publisher;
--        create table mybooks.promotion as select * from books.promotion;
-- *****************************************************************************
-- PLEASE LOGIN AS MYBOOKS BEFORE RUNNGING THE FOLLOWING CODE
--        select * from user_cons_columns where table_name = 'CUSTOMERS';
--        select * from user_cons_columns where table_name = 'ORDERS';
--        select * from user_cons_columns where table_name = 'ORDERITEMS';
--        select * from user_cons_columns where table_name = 'BOOKS';
--        select * from user_cons_columns where table_name = 'BOOKAUTHOR';
--        select * from user_cons_columns where table_name = 'AUTHOR';
--        select * from user_cons_columns where table_name = 'PUBLISHER';
-- -----------------------------------------------------------------------------
--        ADD PRIMARY KEYS      
--        alter table customers add primary key (customer#);
--        alter table orders add primary key (order#);
--        alter table orderitems add primary key (order#,item#);
--        alter table books add primary key (isbn);
--        alter table bookauthor add primary key (isbn,authorid);
--        alter table author add primary key (authorid);
--        alter table publisher add primary key (pubid);
-- -----------------------------------------------------------------------------
--        ADD FOREIGN KEYS
--  on orders fk to customers(customer#)
    alter table orders add foreign key (customer#) references customers(customer#);    
-- ------------------------------------------    
--  on orderitems fk to orders(order#)
    alter table orderitems add constraint oi_o_fk foreign key (order#) references orders(order#);
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
-- -----------------------------------------------------------------------------    
--        RENAME CONSTRAINTS
    alter table customer rename constraint SYS_XXXX to customer_pk;
-- ------------------------------------------
    alter table orders rename constraint sys_XXXX to orders_pk;
-- -----------------------------------------------------------------------------
-- 5. INDEXES
--
--  SINGLE
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
select rowid, (tank_gallons * mileage) from gas_tanks order by 2;

select * from gas_tanks where (mileage* tank_gallons)= 228.66;

-- ------------------------------------------
-- RENAME INDEX 
alter index SYS_C007266 rename to cust_inx;
alter index sys_c007267 rename to ord_inx;
select * from user_indexes;


-- Need to finish FLASHBACK AND esxternal table
-- -----------------------------------------------------------------------------
-- 7. FLASHBACK
--   1. to a system change number (scn)
--   2. to a particular point in time expressed as a timestamp
--   3. to a restore point (data objects) [vs a savepoint which is data only]  
-- ------------------------------------------
--  First lets talk about recyclebin and APEX
    alter session set recyclebin = on;
    -- alter session set recyclebin = off;
    -- ------------------------------------------   
    -- "IF" and it is not common in real life that this is turned on
    -- Here is an example that would work
    drop table gas_tanks;
    select * from recyclebin;
    select * from user_recyclebin;
    -- ------------------------------------------
    -- Does not work in APEX
    flashback table gas_tanks to before drop;
    -- ------------------------------------------
    -- Why do you think it would not be turned on in production
    purge user_recyclebin;
    purge table gas_tanks;    
    -- ------------------------------------------
    --   1. FLASHBACK to a system change number (scn)
    select dbms_flashback.get_system_change_number from dual;
    -- ------------------------------------------  
    -- Wwhat is an SCN?  
    -- Every row has one
    select title, ora_rowscn from books;
    -- Lets decode it 
    select title, ora_rowscn, scn_to_timestamp(ora_rowscn) from books;
   
    create table houdini (voila varchar2(30));
    insert into houdini (voila) values ('Now you see it.');
    insert into houdini (voila) values ('Now you dont.');
    insert into houdini (voila) values ('She Loves Me.');
    insert into houdini (voila) values ('I Wonder who ate the cat?');
    delete houdini;
    --  To enable ROW MOVEMENT on a table that’s already been created:
    alter table houdini enable row movement;
    flashback table houdini to before drop;
    commit;
    create restore point gt_01;


--SELECT TIMESTAMP_TO_SCN(SYSTIMESTAMP) NOW,
--02 TIMESTAMP_TO_SCN(TO_TIMESTAMP('01-AUG-09 09:12:23',
--03 'DD-MON-RR HH:MI:SS')) NOT_NOW
--04 FROM DUAL;

    -- -------------------------------------------------------------------------
    flashback table houdini to timestamp
    systimestamp - interval '0 00:00:20' day to second;

delete from gas_tanks;
select * from gas_tanks;

flashback table gas_tanks to restore point gt_01;
rollback to restore point gt_01;
select * from invoices_external;
 



 
-- flashback table houdini to before drop;
-- The Recycle bin is where any object is placed when dropped and until purged
purge gas_tanks from user_recyclebin;
-- purge an obejct
-- purge table houdini;
-- purge recyclebin;

-- SCN encoded timestamp
select dbms_flashback.get_system_change_number from dual;

select * from books_11;

select title, ora_rowscn, scn_to_timestamp(ora_rowscn)
from books_11;







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


        
        
        
