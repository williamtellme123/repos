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
      
    YOUR MASTER FILE
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
      6. DEFERRED (pretty useless)
      6. CREATE INDEXES
          Single
          Composite
          Function
      7. FLASHBACK
      8. EXTERNAL (aka foreign data) TABLES -- csv examples
*/
-- =============================================================================
-- ------------------------------
-- 0. DEBUGGING YOUR SQL
--        Comments
--          select clause -- align these clause in a row to allow commenting out
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
--    i. finally add comments or aliases to help you remember later
select 
         firstname
       , lastname
       , title
       , (select count(order#) from orders o where o.customer# = c.customer#) as tot_orders  -- took out the pound sign
       , (select sum(quantity) from orderitems oi where oi.order# = o.order#) as tot_books -- insserted error
       , firstname || ' ' || lname as book_author 
       , category
from 
      customers c join orders o on c.customer# = o.customer#  -- put all of the JOINs in a pattern, too
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
order by 3
;         -- inserted errors and broke down for debugging 

select * from customers where firstname = 'LEILA';

-- -----------------------------------------------------------------------------
-- 1. ADD COLUMNS 
-- -----------------------------------------------------------------------------
-- adding a column
      desc books;
      alter table books add (sales_price number(9,2));
-- Lets create a column that store clerks can print out on labels called price_tag
      alter table books add (price_tag    varchar2(50));
      
-- ------------------------------
-- Now lets create the price_tag like they do for cars on TV :-)
      update books
      set sales_price = retail * .95,
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
  drop table books cascade constraints;
  create table books as select * from johnb.mybooks;  -- now updated to include only the right number of categories
  
  desc books;
  
  select * from books;
  insert into books values
  ('56565656','This Book has a really really really really long title','25-AUG-13',1, 45.99, 31.99, 'COMPUTER');

  alter table books modify (title varchar2(100));
--  alter table books rename column sales_price to discount;
  
  -- MODIFY THE TABLE NAME  -- rename and then change back
  -- ---------------------------------------------------------------------------
--  alter table books rename to products;
  -- ---------------------------------------------------------------------------
--  alter table products rename to books;

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
alter table books add newisbn integer;

update books set
        newisbn = to_number(isbn);
alter table books drop column isbn;
alter table rename column newisbn to isbn;  -- did not work
desc books;
    -- ---------------------------      -- do these at home  <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
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
    drop user johnb cascade;
    create user johnnybooks identified by johnnybooks;
    grant all privileges to johnnybooks;

-- LOGIN AS billybooks
-- *****************************************************************************
-- PLEASE LOGIN AS billybooks BEFORE RUNNING THE FOLLOWING CODE
--        CTAS
        create table johnnybooks.customers as select * from books.customers;
        create table johnnybooks.orders as select * from books.orders;
        create table johnnybooks.orderitems as select * from books.orderitems;
        create table johnnybooks.books as select * from books.books;
        create table johnnybooks.bookauthor as select * from books.bookauthor;
        create table johnnybooks.author as select * from books.author;
        create table johnnybooks.publisher as select * from books.publisher;
        create table johnnybooks.promotion as select * from books.promotion;
-- *****************************************************************************
-- PLEASE LOGIN AS billybooks BEFORE RUNNING THE FOLLOWING CODE
        select * from user_cons_columns where table_name = 'CUSTOMERS';
        select * from user_cons_columns where table_name = 'ORDERS';
        select * from user_cons_columns where table_name = 'ORDERITEMS';
        select * from user_cons_columns where table_name = 'BOOKS';
        select * from user_cons_columns where table_name = 'BOOKAUTHOR';
        select * from user_cons_columns where table_name = 'AUTHOR';
        select * from user_cons_columns where table_name = 'PUBLISHER';   -- ran this to confirm there are no constraints, no data
-- -----------------------------------------------------------------------------
--        ADD PRIMARY KEYS          --------------------------------------------  Changed to johnnybooks
        alter table customers add primary key (customer#);
        alter table orders add primary key (order#);
        alter table orderitems add primary key (order#,item#);  -- why 2 Primary Keys?  Compound
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
    alter table books modify title unique;      -- describing modifying instead of adding
    select count(*), count(title), count (distinct title) from books;
-- -----------------------------------------------------------------------------    
    --        ADD CHECK CONSTRAINT
    alter table books modify cost check (cost < 5000 and cost > 0);
    select
          (select count(*) from books)
          ,(select count(*) from books where cost between 1 and 4999)     -- results matched so can be done
    from dual;
    -- ---------------------------------------------
      alter table books add binding varchar2(5) 
       constraint ck_bind check (binding in ('Hard','Soft','eBook'));   -- see what the count of hard, soft, ebooks
-- -----------------------------------------------------------------------------    
--        FIND CONSTRAINTS
    select * from user_cons_columns where table_name in       -- user_cons_column is defined as what schema am I open in
    ('CUSTOMERS','ORDERS','ORDERITEMS','BOOKS','BOOKAUTHOR','PUBLISHER')
    order by table_name;                                      -- SYS_C007278 assigned by Oracle
-- -----------------------------------------------------------------------------    
-- EVEN NOT IN THE BOOK, SHOULD KNOW THIS QUERY
    select  uc.constraint_type    -- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>   CRITICAL STATEMENT    -- SAVE IN MASTER FILE     <<<<<<<<<<<<<<<<<<<<
    --      ,uc.owner AS SCHEMA NAME
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
--      and uc.constraint_type in ('P','R')   -- WITHOUT THE P AND R, LOOKING AT ALL CONSTRAINT TYPES
      and ucc1.table_name = 'ORDERITEMS' 
    order by ucc1.table_name,uc.constraint_name;
    
select *  --constraint_name, constraint_type
from user_constraints
where table_name = 'ORDERS';
-- -----------------------------------------------------------------------------    
--        RENAME CONSTRAINTS
    SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'CUSTOMERS';
    alter table customers rename constraint SYS_C007274 to customer_pk;   -- SYS_C007274 is my constraint name
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
  , p_id integer constraint child_fk_parent references myparent(parent_id)
         deferrable initially immediate);
--  IN EFFECT, THIS IS IDENTICAL TO WHAT WE HAVE BEEN DOING ALL SEMESTER

--  Deferred until commit or set
insert into myparent values (10);
insert into mychild values (25, 10);

set constraint child_fk_parent deferred;
update myparent set parent_id = 100;
set constraint child_fk_parent immediate;

--  1. insert a good parent id
--  2. insert a good child_id with a current parent key frpm Step 1
--  3. then set deferrable to deferred
--      wait for later to check for orphans
--  4. change the parent_id (this means CHILD is now orphan)
--  5. set constraint back to IMMEDIATE
--  6. to fix: change the CHILD to contain new parent_id then make IMMEDIATE

-- when deferred, nothing is checked until
    -- a commit happens
    -- or set the constraint back to immediate 

update myparent set parent_id = 100;
update mychild set p_id = 100;
commit;

-- check before commit;
set constraint child_fk_parent immediate;   --  ALSO look at bottom of PAGE 448

select * from user_constraints where Owner = 'JOHNNYBOOKS';
select constraint_name from user_constraints where Owner = 'JOHNNYBOOKS';

select table_name, constraint_name, constraint_type from user_constraints
where Owner = 'JOHNNYBOOKS'
and table_name = 'ORDERITEMS';;
SYS_C007276
OY_O_FK
SYS_C007283

alter table orderitems disable primary key cascade;
alter table orderitems disable constraint OY_O_FK;  -- not a string, it is an OBJECT without hash marks
alter table orderitems disable constraint SYS_C007283;  -- all of the Orphans are gone

alter table orderitems enable primary key;
alter table orderitems enable constraint OY_O_FK; 
alter table orderitems enable constraint SYS_C007283;  

--  Use case
--  let's say parent_ids are integer now
--  but you want to change them to SSN
-- -----------------------------------------------------------------------------
-- 7. INDEXES
--  -----------------------------------------------------------------------------
--  SINGLE
  select * from user_indexes;
  select * from all_indexes 
  where owner = 'JOHNNYBOOKS'
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
create index ix_gas_tanks_001 on gas_tanks (tank_gallons * mileage);  -- the mathematical expression is the Functional
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
where (mileage *  tank_gallons) >200
order by 2;

select * from gas_tanks where (mileage * tank_gallons)= 228.66;

-- ------------------------------------------
-- RENAME INDEX 
select * from user_indexes where table_owner = 'JOHNNYBOOKS';
alter index SYS_C008845 rename to cust_inx;
alter index SYS_C008846 rename to ord_inx;
select * from user_indexes;





-- -----------------------------------------------------------------------------
-- 8. FLASHBACK
-- -----------------------------------------------------------------------------
--   1. to a system change number (scn) -- anytime you insert, update, delete a row, that tranaction is given a system change number at commit;
--   2. to a particular point in time expressed as a timestamp -- date but with fractions of a second
--   3. to a restore point (data objects) [vs a savepoint which is data only]  -- place that saves a snapshot of the current data
-- ------------------------------------------
--  First lets talk about recyclebin and APEX -- usually controlled by the DBA, maybe one backup
    alter session set recyclebin = on;  -- where things you delete go
    -- alter session set recyclebin = off;
    -- ------------------------------------------   
    -- "IF" and it is not common in real life that this is turned on
    -- Here is an example that would work
    drop table gas_tanks;
    select * from recyclebin;  -- this is where everything is dropped off to.  NOT ENABLED for us to use
    select * from user_recyclebin;  -- Billy acknowledged they are NOT ENABLED for us to use
    -- ------------------------------------------
    -- Does not work in APEX -- Oracle Application Express
    flashback table gas_tanks to before drop;
    -- ------------------------------------------
    -- Why do you think it would not be turned on in production
    purge user_recyclebin;    -- concept is just like recycle bin on PC
    purge table gas_tanks;    
    -- ------------------------------------------
    --   1. FLASHBACK to a system change number (scn)
    select dbms_flashback.get_system_change_number from dual;   --  CHANGED TO SYSTEM schema  <<<<<<<<
    -- worked in System schema (result: 1618910) -- this can be converted to a timestamp
    -- ------------------------------------------  
    -- What is an SCN?  
    -- Every row has one
    select title, ora_rowscn from books;  --  CHANGED TO BOOKS schema  <<<<<<<<  ora_rowsch is a VIRTUAL field, like row_num
    --        Result: 1518361 which means they were inserted at the exact same time
    -- Lets decode it 
    select title, ora_rowscn, scn_to_timestamp(ora_rowscn) from books;
    --  returns identical number: 05-JUL-16 06.40.53.000000000 PM.  All zeroes in fractions
drop table houdini;
    create table houdini (voila varchar2(30)); 
    insert into houdini (voila) values ('Now you see it.');
    insert into houdini (voila) values ('Now you dont.');
    insert into houdini (voila) values ('She Loves Me.');
    insert into houdini (voila) values ('I Wonder who ate the cat?');
select * from houdini;
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

-- compare to 590-591

-- -----------------------------------------------------------------------------
-- 9. EXTERNAL TABLES
-- -----------------------------------------------------------------------------
--      a. Confirm or Physically create the directory c:\temp on your laptop
-- -----------------------------------------------------------------------------
--      b. Login as system:
--          i.  CREATE OR REPLACE DIRECTORY TMP AS 'C:\temp';
                create or replace directory tmp as   'c:\temp';
--          ii. GRANT READ, WRITE ON DIRECTORY TMP TO CRUISES;
                grant read, write on directory tmp to johnnybooks;
-- -----------------------------------------------------------------------------
--      c. create the external table (etl aka source table)
--          Login as zooie:        
                drop table invoices_external;
                select count(*) from invoices_external;
                -- external file which is space delimited
                create table invoices_external
                (
                    id         CHAR(6),
                    inv_date   CHAR(13),
                    amount     CHAR(9),
                    acct_no    CHAR(11)
                )
                organization external
                (
                    type oracle_loader default 
                      directory tmp
                      access parameters (records delimited BY newline skip 2 fields 
                      ( 
                          id        char(6)
                        , inv_date  char(13)
                        , amount    char(9)
                        , acct_no   char(11)))
                      -- make sure there are no extra lines that might be interpreted as null later when loading into PK
                      location ('load_invoices.txt')
                );
-- -----------------------------------------------------------------------------
--       d. Confirm
            select count(*) from invoices_external; -- 39585
-- -----------------------------------------------------------------------------
--       e. create target table with correct data types
--          login as zooie:  
        create table invoices_revised
        (
            invoice_id     integer,
            invoice_date   date,
            invoice_amt    number,
            account_number varchar2(13)
        );
-- =============================================================================
--   D. ETL from external table to new table        --  WE WILL BE USING THIS OFTEN!!!!!!!  >>>>    WORKED  !!!!      <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
          insert into invoices_revised (
                    invoice_id
                  , invoice_date
                  , invoice_amt
                  , account_number)
            select  id
                  , to_date(inv_date,'mm/dd/yyyy')
                  , to_number(amount)
                  , acct_no
            from invoices_external;
-- =============================================================================
--   E. Confirm
          select count(*) from invoices_revised;
          commit;
-- =============================================================================
--   F. Commit
          commit;

select                                          --     COMPLETED SUCCESSFULLY
(select count(*) from invoices_revised where to_char(invoice_date, 'YYYY') = 2009) as t2009,
(select to_char(sum(invoice_amt),'$999,999,999,999.99') from invoices_revised where to_char(invoice_date, 'YYYY') = 2009) as sum2009,
(select count(*) from invoices_revised where to_char(invoice_date, 'YYYY') = 2010) as t2010,
(select to_char(sum(invoice_amt),'$999,999,999,999.99') from invoices_revised where to_char(invoice_date, 'YYYY') = 2010) as sum2010,
(select count(*) from invoices_revised where to_char(invoice_date, 'YYYY') = 2011) as t2011,
(select to_char(sum(invoice_amt),'$999,999,999,999.99') from invoices_revised where to_char(invoice_date, 'YYYY') = 2011) as sum2011,
(select count(*) from invoices_revised where to_char(invoice_date, 'YYYY') = 2012) as t2012,
(select to_char(sum(invoice_amt),'$999,999,999,999.99') from invoices_revised where to_char(invoice_date, 'YYYY') = 2012) as sum2012
from dual;

10182	   $2,034,139,924.00	19179	   $3,827,487,305.00	10224	   $2,039,201,394.00
