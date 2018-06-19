-- =============================================================================
/* 
   Chapter 10 
        
              VIEWS 
              
              Can are used to Hide Sensistive Data (say financial: salary, bonus, commission) 
              Can also be used to hide complex queries
              REAL WORLD EXAMPLE
              BMC uses views to obfuscate source data so customer dependent on BMC
                            View3
                          /       \  
                     View1         View2   
                    /             /     \              
              T1024          T1407       T2107
        
      1. SIMPLE VIEWS
          One table
          May have more columns than underlying table (see profit below) 
          No aggregations
          
      2. COMPLEX VIEWS (the data the veiw references cannot be modified)
           May have aggregates
           May have more than one table
        
      3. SEQUENCES
      4. INDEXES
      5. SYNONYMS
           Public   :   Meant for everyone to see my schema objects
           Private  :   Meant just for me to make life easy
*/
-- =============================================================================
-- 1. SIMPLE VIEWS 
-- -----------------------------------------------------------------------------
-- A.  SIMPLE VIEW ON ONE ENTIRE TABLE
-- -----------------------------------------------------------------------------
-- HIDING DATA
    -- assume that everything in the customers table
    -- except first and last name and customer# is secret
    select * from customers;
-- -------------------------------
-- CREATE SIMPLE VIEW
    create or replace view vw_customers
    as select customer#, firstname, lastname from customers;
-- -------------------------------
-- USE SIMPLE VIEW
    select * from vw_customers;
-- -------------------------------
-- INSERT INTO SIMPLE VIEW
    insert into vw_customers values (5000,'Becky','TwoGuns');
    select * from vw_customers;
    select * from customers;
-- -------------------------------    
-- CHECK VIEW
    select * from vw_customers;
-- CHECK TABLE
    select * from customers;
-- -------------------------------    
-- UPDATE
    update vw_customers
    set lastname = 'ThreeGuns'
    where customer# = 5000;
-- CHECK VIEW
    select * from vw_customers;
-- CHECK TABLE
    select * from customers;
-- -------------------------------       
-- DELETE
    select * from customers where customer# = 1012;
    delete from vw_customers
    where customer# = 1012;
-- CHECK VIEW
    select * from vw_customers;
-- CHECK TABLE
    select * from customers;
    rollback;
-- Review SIMPLE VIEW ON ONE ENTIRE TABLE
--    MUST follow any rules (constraints on the table)
--    Simple views can be used to:
--      select (aka READ)       TRUE
--      insert (aka WRITE)      TRUE
--      update (aka WRITE)      TRUE
--      delete (aka WRITE)      TRUE
-- =============================================================================
-- B. SIMPLE VIEW ON A SUBSET OF ONE TABLE
-- -----------------------------------------------------------------------------
    select * from books;
    desc books;
    select * from user_constraints
    where table_name = 'BOOKS';
    -- If you do not see ISBN NOT NULL 
    -- lets add primary key
    -- alter table books add primary key(isbn);
    -- -----------------------------------------------------------------------------           
    --  SIMPLE VIEW No. 1-B1 = subset of existing cols and rows (no primary key)
    -- -----------------------------------------------------------------------------           
        create or replace view vw_books as
        select title, retail, cost, category
        from books
        where category in ('COMPUTER','COOKING');
    -- -------------------------------  
        -- Can you see data (aka read) 
        select * from vw_books;
        select * from books;
    -- -------------------------------  
        -- Can you insert data (aka write)? 
        insert into vw_books values('ACME ANVILS',25.99,19.99,'COOKING');
        select * from vw_books;
        select * from books;
    -- -------------------------------  
        -- Can you update data (aka write)? 
        update vw_books
        set retail = 17.99 where title =  'COOKING WITH MUSHROOMS';
        select * from vw_books;
        select * from books;
    -- -------------------------------      
        -- Can you delete data (aka write)? 
        delete vw_books where title = 'COOKING WITH MUSHROOMS';
        -- Add row with no children using table name 
        -- Use view name to delete
        select * from vw_books;
        select * from books;
              
        select * from all_views
        where owner = 'BOOKS';
        
        insert into books values ('5112121212','JUMP UPSTREAM WITH SQL','21-AUG-01',4,22.75,32.95,'FAMILY LIFE');
        select * from vw_books;
        select * from books;
        delete vw_books where title = 'JUMP UPSTREAM WITH SQL';
        select * from vw_books;
        select * from books;
    -- -------------------------------     
    -- Review SIMPLE VIEW No. 1-B1 = subset of existing cols and rows (no primary key)
    --    MUST follow any rules (constraints on the table)
    --    A simple view can be used to:
    --      select (aka READ)   TRUE
    --      insert (aka READ)   FALSE
    --      update (aka WRITE)  TRUE
    --      delete (aka WRITE)  TRUE
    -- -----------------------------------------------------------------------------
    --  SIMPLE VIEW No. 1-B2 = subset of existing cols and rows (with primary key)
    -- -----------------------------------------------------------------------------           
        create or replace view vw_books as
        select isbn, title, retail, cost, category
        from books
        where category in ('COMPUTER','COOKING');
    -- -------------------------------      
        -- Can you see data (aka read) 
        select * from vw_books;
        select * from books;
    -- -------------------------------  
        -- Can you insert data within view (aka write)? 
        insert into vw_books values('9999898', 'CARROTS',25.99,19.99,'COOKING');
        select * from vw_books;
        select * from books;
    -- -------------------------------  
        -- Can you insert data outside of view (aka write)? 
        insert into vw_books values('90999','BUMBERS 2',99.99,2.99,'COMPUTER');
        select * from vw_books;
        select * from books;
    -- -------------------------------  
        -- Can you update data in view (aka write)? 
        update vw_books
        set retail = 17.99 where title =  'BUMBERS 2';
        
        select * from vw_books where title = 'BUMBERS';
        select * from books where title = 'BUMBERS';
    
    -- -------------------------------  
        -- Can you update data in table outisde of view (aka write)?
        insert into books values (55555, 'All Fives', '01-JAN-2016', 2, 55.55, 123.45, 'CARS');
        select * from vw_books;
        update vw_books
        set retail = 17.99 where category =  'CARS';
        select * from vw_books where category =  'CARS';
        select * from books where category =  'CARS';
    -- -------------------------------      
        -- Can you delete data (aka write)? 
        delete vw_books where title = 'BUMBERS 2';
        select * from vw_books where title = 'BUMBERS';
        select * from books where title = 'BUMBERS';
    -- -------------------------------      
    -- Review SIMPLE VIEW No. 1-B2 = subset of existing cols and rows (with primary key)
    --    MUST follow any rules (constraints on the table)
    --    A simple view can be used to:
    --      select (aka READ)                     TRUE
    --      insert (aka READ) in view             TRUE
    --      insert (aka READ) outside of view     TRUE
    --      update (aka WRITE) in view            TRUE
    --      update (aka WRITE) outside of view    FALSE
    --      delete (aka WRITE)                    FALSE
    -- -----------------------------------------------------------------------------
    --  SIMPLE VIEW No. 1-B3 = subset cols, rows, primary key, and new column
    -- ----------------------------------------------------------------------------- 
        create table junk3  as
        select isbn, title, retail, cost, retail-cost as profit, category
        from books
        where category in ('COMPUTER','COOKING');
        
        select * from junk3;
        
        create or replace view vw_books as
        select isbn, title, retail, cost, retail-cost as profit, category
        from books
        where category in ('COMPUTER','COOKING');
    -- -------------------------------      
        -- Can you see data (aka read) 
        select * from vw_books;
        select * from books;
    -- -------------------------------         
        -- Can you insert data within view (aka write)? 
        insert into vw_books values('99988', 'PRUNES',25.99,19.99,6, 'COOKING');
        -- Is there an error message? 
        -- What does it say?
        select * from vw_books;
        select * from books;
    -- -------------------------------         
        -- Can you insert data using 
        -- columns in view which represent columns (1-to-1) in table (aka write)? 
        insert into vw_books (isbn, title, retail, cost, category) values('223999', 'SPUDS',25.99,19.99,'COOKING');
        select * from vw_books;
        select * from books;
    -- -------------------------------         
        -- Students are encouraged to answer the following questions at home
        -- Can you insert data using view columns (1-to-1) with values outside of view (aka write)? 
        -- Can you update using view (aka write)? 
        -- Can you delete using view (aka write)? 

-- -----------------------------------------------------------------------------
-- REVIEW SIMPLE VIEWS 
-- 1. Can be used to see (READ) some and/or hide other data
-- 2. Cannot insert unless view holds primary key
-- 3. Any changes (writes: insert, update, delete) must obey all constraints on table
-- 4. If constraints are followed you can insert into the table using the view 
-- =============================================================================

-- =============================================================================
-- 2. COMPLEX VIEWS 
-- -----------------------------------------------------------------------------
    -- A.  COMPLEX VIEW : AGGREGATE
    -- -----------------------------------------------------------------------------
    create or replace view vw_agg_books as 
    select category, avg(retail) avg_retail, avg(cost) avg_cost
    from books
    group by category;
    -- -------------------------------      
    -- Can you see data (aka read) 
    select * from vw_agg_books;
    select * from vw_agg_books where avg_retail > 25;

    -- -------------------------------         
    -- Can you insert data  (aka write)? 
    insert into vw_agg_books values('CARS', 44.99,22.99);
    -- Is there an error message? 
    -- What does it say?

    -- -------------------------------  
    -- Can you update data (aka write)? 
    update vw_agg_books set category = 'MONSTERS'
    where category = 'COMPUTER';
    -- Is there an error message? 
    -- What does it say?

    -- -------------------------------  
    -- Can you delete data (aka write)? 
    delete from vw_agg_books 
    where category = 'COMPUTER';
    -- Is there an error message? 
    -- What does it say?
    -- -------------------------------     
    -- Review COMPLEX VIEW : AGGREGATE
    --    Virtual columns are not a 1-to-1 mapping with table columns 
    --      select (aka READ)   TRUE
    --      insert (aka READ)   FALSE
    --      update (aka WRITE)  FALSE
    --      delete (aka WRITE)  FALSE

    -- -----------------------------------------------------------------------------
    -- A.  COMPLEX VIEW : JOIN
    -- -----------------------------------------------------------------------------
    create or replace view vw_customer_orders as
    select c.customer# c_customer#
          , firstname
          , lastname
          , order#
          , o.customer# o_customer#
    from customers c, orders o
    where c.customer# = o.customer#;

    -- -------------------------------      
    -- Can you see data (aka read) 
    select * from vw_customer_orders;

    -- -------------------------------      
    -- Can you insert data (aka write) 
    select * from vw_customer_orders;
    insert into vw_cust_ords values (9001,'Big','Al',3333, 9001);
    -- key-preserved views

    -- -------------------------------     
    -- Review COMPLEX VIEW : JOINS
    --    columns are 1-to-1 mapping with table columns 
    --      select (aka READ)   TRUE
    --      insert (aka READ)   FALSE
    --      update (aka WRITE)  FALSE
    --      delete (aka WRITE)  FALSE

    -- Even if the view is on a join with PKs from both tables
    -- and the FK from child table this will fail
    -- Why?

-- =============================================================================
--  3. SEQUENCES
-- ----------------------
--  Sequence 1
    drop sequence myseq;
    create sequence myseq;
-- ----------------------
    -- look carefully at the next two lines
    select myseq.currval from dual;
    select myseq.nextval from dual;
    
    -- now try again 
    select myseq.currval from dual;
-- ----------------------
--  Sequence 2
    drop sequence myseq;
    create sequence myseq start with 0 minvalue 0 increment by 15;
    select myseq.nextval from dual;
-- ----------------------
--  Sequence 3
    drop sequence myseq;
    create sequence myseq start with 21 increment by 2;
    select myseq.nextval from dual;
-- ----------------------
--  Sequence 4
    drop sequence myseq;
    create sequence myseq start with 21 increment by 2 maxvalue 33;
    select myseq.nextval from dual;
-- ----------------------
--  Sequence 5
    drop sequence myseq;
    create sequence myseq start with 21 cache 6 increment by 2 maxvalue 33 cycle;
    select myseq.nextval from dual;
    -- when it cycles what is the new starting value
-- ----------------------
--  Sequence 6
    drop sequence myseq;
    -- will this work?
    create sequence myseq start with 21 cache 6 increment by 2 maxvalue 3 cycle minvalue 15;
    select myseq.nextval from dual;
    

    -- will this work?
    create sequence myseq start with 21 cache 6 increment by 2 minvalue 3 cycle maxvalue 24;
    select myseq.nextval from dual;
    
-- start here
-- ----------------------
--  Sequence 7
      drop;
      create sequence seq1 start with 150 cache 4 increment by 10 cycle minvalue 150 maxvalue 190;
      create sequence seq2 start with 127 cache 4 increment by 5 cycle maxvalue 147;
      select seq1.nextval from dual;
      select seq2.nextval from dual;
      
      
      drop sequence myseq;
      create sequence myseq start with 5 cache 6 increment by -2 cycle minvalue -6 maxvalue 7;
      select myseq.nextval from dual;
      
      drop sequence myseq;
      create sequence myseq start with -3 cache 4 increment by -2 cycle minvalue -10;
      select myseq.nextval from dual;
      
-- ----------------------
-- Real World Example
-- Often times the parent and child records are ready for insertion at the same
-- time in the business. Like, a new client making a purchase.
-- You need to insert the parent record first then the child with the parents id
      
      -- ------------------------------------
      -- CREATE PARENT
      drop  sequence clients_seq;
      create sequence clients_seq;
      drop table clients cascade constraints;
      -- ------------------------------------
      create table clients
      (cid   integer primary key,
       name  varchar2(10)
       );
      -- ------------------------------------
      -- CREATE CHILD
      drop sequence po_seq;  
      create sequence po_seq;
      drop table purchase_order;
      create table purchase_order
      (
          poid      integer primary key,
          cid       integer,
          podate    date,
          amt       integer,
          constraint c_fk foreign key(cid) references clients(cid)
       );

      -- ------------------------------------
      -- INSERT PARENT
      insert into clients values(clients_seq.nextval, 'Tom');
      select * from clients;
      -- ------------------------------------
      -- INSERT CHILD
      insert into purchase_order values (po_seq.nextval, clients_seq.currval, sysdate, 5000);
      select * from purchase_order;

-- =============================================================================
-- 4. INDEXES
-- =============================================================================
    -- a. 
    select * from customers;
    create index ix_cust on customers(lastname);
    -- ------------------------------------
    -- Recall from earlier class
    -- Rowid is Oracle's memory location for that row
    -- b. 
    select rowid, rownum, lastname, firstname
    from books.customers
    order by 2;
    -- ------------------------------------
    -- COPY AND PASTE MORALES ROWID
    -- c. AAAHWZAABAAAL/JAAA
    --    AAAHWZAABAAAL/JAAA
    select rowid, lastname
    from customers
    order by 2; 
    -- ------------------------------------
    -- d.
    select rowid, rownum, lastname, firstname
    from customers
    order by 3;
    -- DOES IT STAY THE SAME?
    
    -- ------------------------------------
    -- CONCATENATED INDEX
    -- e.
    create index ix_fullname on customers(lastname,firstname);
    select * from user_indexes where table_name = 'CUSTOMERS';
    -- Using both parts of the index in the where clause
    -- Oracle will use index
    -- ------------------------------------
    -- f.
    select * from books.customers 
    where lastname = 'MORALES'
      and firstname = 'BONITA';
    
    -- ------------------------------------
    -- Using both parts of the index in the where clause
    -- Oracle probalby  use index
    -- g. 
    select * from customers 
    where lastname = 'MORALES';
    -- ------------------------------------
    -- SKIP SKANNING
    -- h.
    select * from states;
    select distinct region from states;
    create index ix_state_region on states(region, st);
    
    -- ------------------------------------
    -- i.
    select * from states 
    where st = 'FL';
    
    -- j. Internally oracle does something like this
    --    stops at first FL
    select * from states where region = 'South' and st = 'FL';
    select * from states where region = 'West' and st = 'FL';
    select * from states where region = 'Midwest' and st = 'FL';
    select * from states where region = 'North East' st = 'FL';

    -- ------------------------------------   
    -- k. DROPPING INDEXES
    drop table junk;
    create table junk as select * from books.books;
    
    create index ix_junk on junk(category, title);
    
    -- ------------------------------------       
    -- l. Display the index
    select * from all_indexes
    where table_owner in ('TEST')
    and table_name = 'JUNK';
    
    -- ------------------------------------   
    -- m. Drop the index
    drop index ix_junk;
    
    -- ------------------------------------       
    -- n. Check the index 
    select * from all_indexes
    where table_owner in ('BILLY')
    and table_name = 'JUNK';

    -- ------------------------------------       
    -- o. Recreate the index 
    create index ix_states on states(region, st);
    
    -- ------------------------------------           
    -- p. Check the index 
    select * from all_indexes
    where table_owner in ('BILLY')
    and table_name = 'JUNK';
    
    -- ------------------------------------           
    -- q. Drop the table
    drop table junk;
    
    -- ------------------------------------           
    -- r. Check the index 
    select * from all_indexes
    where table_owner in ('BILLY')
    and table_name = 'JUNK';
    
    -- ------------------------------------
    -- Unique Index
    -- If you wanted to ensure both an index and a unique value in a column
    -- s.
    create unique index ix_unique_state on states(st);
    
    -- -----------------------------------------------------------------------------
    -- REVIEW INDEXS
    --  For best results, indexed column should be specified in where "=" clause
    --  “Greater than” other relational operators may invoke index
    --  “Not equals” will NOT invoke index
    --  "LIKE" may invoke index if wildcard not in first position
    --  "Function Index" discussed in Chapter 11

-- =============================================================================
-- 5. SYNONYMS
-- -----------------------------------------------------------------------------
-- PRIVATE SYNONYMS
--    designed to used by the user who creates them
--    Private word is the default when creating synonyms so it is optional

-- ------------------------------------             
      -- a. LOGIN AS CRUISES
      create or replace synonym shpcab for cruises.ship_cabins;
      select * from shpcab;

-- ------------------------------------                   
      -- b. LOGIN AS CRUISES            
      create or replace public synonym shpcab for cruises.ports;

-- ------------------------------------                   
      -- c. LOGIN AS CRUISES
      -- List of synonyms we are currently interested in       
      select * from all_synonyms
      where owner in ('CRUISES','BOOKS', 'PUBLIC','BILLY')
      and table_owner in ('CRUISES','BOOKS');
      -- 2 synonyms with same name
      -- See Page 56

-- ------------------------------------                   
      -- d. LOGIN AS CRUISES            
      select * from shpcab;

-- ------------------------------------                   
      -- e. LOGIN AS BOOKS            
      select * from shpcab;
      
-- ------------------------------------             
      -- f. Create a more reasonable (real to life) user
      create user newbie identified by newbie;
      grant create session to newbie;
      grant create table to newbie;
      grant create view to newbie;
      grant create sequence to newbie;

-- ------------------------------------             
      -- g. LOGIN AS NEWBIE            
      select * from shpcab;

-- ------------------------------------                   
      -- h. LOGIN AS CRUISES           
      grant select on ports to newbie;
      grant select on ship_cabins to newbie;
      
-- ------------------------------------             
      -- i. LOGIN AS NEWBIE            
      select * from shpcab;
      


create or replace view ship_cab_proj as
select  ship_id
      , to_char(capacity, '999,999') as applepie
      , project_cost
from ships join projects using (ship_id)
where (project_cost * 2) < 1000000;

select
        (select max(project_id)+1 from projects)
      , (select max(ship_id) from ships)
      , 'Small Project'
      , 500
from dual;     

insert into major_projects
(project_id, ship_id,project_name,project_cost)
values
(
        (select max(project_id)+1 from projects)
      , (select max(ship_id) from ships)
      , 'Small Project'
      , 500
);    

