-- =============================================================================
--  CHAPTER 3
/*

    "AHA" means A Look Ahead (terms/phrases as overview of chapter)

    NOTES: 
          Each chapter's Student SQL file will:
            Contain a table of contents
            Begin with previous AHAs
            A more detailed AHA of current chapter
            Contain a look ahead: AHAs of upcoming chapters
            Chapter exercises/student code
    -- -------------------------------------------------------------------------      
    TABLE OF CONTENTS
    0.  LIST OF CHAPTER 3 TERMS
    1.  REVIEW and AHAs
    2.  SHORTCUT KEYS/PREFERENCES
    3.  select 1 TABLE (QUESTION THAT REQUIRES 2 TABLES CALLED A JOIN)
    4.  INSERTING: MUST FOLLOW CONSTRAINTS
    5.  DELETING existing rows in a table :: MUST FOLLOW CONSTRAINTS
    6.  UPDATING COMMIT ROLLBACK SAVEPOINT
*/ 
-- =============================================================================   
-- -----------------------------------------------------------------------------
--    0. LIST OF CHAPTER 3 TERMS
--            DDL : Multiple chapters
--                  CREATE        Used to create object tables, views etc :: throughout book
--                  ALTER         Modify objects :: throughout book
--                  DROP          Remove objects :: throughout book
--                  RENAME        Rename objects :: throughout book
--                  TRUNCATE      Removes all of the rows :: cannot be rolled back
--                  GRANT         Give privileges Chapter 18
--                  REVOKE        Removes privileges Chapter 18
--                  FLASHBACK     Recovers from recycle bin 
--                  PURGE         Removes objects from recycle bin
--            DML : Multiple chapters
--                  select     
--                  INSERT
--                  UPDATE
--                  DELETE
--                  MERGE :: Chapter 11
--            TCL : Multiple chapters
--                  COMMIT
--                  ROLLBACK
--                  SAVEPOINT
-- -----------------------------------------------------------------------------
--    1. REVIEW and AHAs
--    AHA 2: Create : tables, constraints using DDL as database objects
--    AHA  3: MANIPULATING DATA
--      Find           select
--      Add            INSERT
--      Change         UPDATE
--      Remove         DELETE  
--      Recovery       ROLLBACK
--      Persist        COMMIT
              -- --------------------------------------
              -- Short Demo
              -- SETUP : as test create a practice table CTAS
              create table mybooks as 
              select * from books.books;
              -- --------------------------------------
              -- select
              select * from mybooks;
              select title, cost, retail from mybooks;
              select title, retail-cost as profit from mybooks;
              -- --------------------------------------
              -- INSERT
              insert into mybooks values(1111111,'SQL Citizens make the best ____', '01-JAN-81',3,29.99, 34.22, 'NON Fiction');
                      -- --------------------------------------
                      -- START Real life scenario sidebar
                      alter table mybooks modify title varchar2(100);
                      -- Google : alter column techonthenet : fix code : execute insert again 
                      -- END Real life scenario sidebar
                      -- --------------------------------------
              -- --------------------------------------
              -- UPDATE
              select * from mybooks where isbn = '1111111';
              update mybooks set retail = 39.99 where isbn = '1111111';
                      -- --------------------------------------
                      -- START Real life scenario sidebar
                      select * from mybooks;
                      -- Google : alter column techonthenet : fix code : execute insert again 
                      -- END Real life scenario sidebar
                      -- --------------------------------------
              -- --------------------------------------
              -- ROLLBACK
              rollback;
              -- --------------------------------------
              -- DELETE
              delete mybooks where isbn = 1111111;
                      -- START Real life scenario sidebar
                      select * from mybooks;
                      -- rollback : add where clause : execute insert again : confirm
                      -- END Real life scenario sidebar
                              -- END Real life scenario sidebar
              -- --------------------------------------
              -- COMMIT
              commit;
--   AHA  4: Lots more about select details 
--   AHA  5: Lots more about WHERE details 
--   AHA  6: Single Row Functions that change result sets : ETL (Extract, Transform, Load) example
--   AHA  7: Aggregate Functions often used in reporting (SUM) all the computer books
--   AHA  8: Finding data using more than 1 table: JOINS
--   AHA  9: An inner (child) query can pass its results to an outer (parent) query
--   AHA 10: Views, Sequences, Indexes, Synonyms
--   AHA 11: Add, Modify, Drop Table Columns, Constraints from Ch. 2, load external data
--   AHA 12: Set Operations on result sets: Instersection, Unions, etc 
--   AHA 13: Data Reporting using ROLLUP and CUBE
--   AHA 14: Finding Meta Data: Data about your data (i.e. find all tables with column called employee_id)
--   AHA 15: Multi-table inserts: insert into >1 table (i.e. add last years invoices to history and archive)
--   AHA 16: Hierarchical Queries: Org Chart (employees, mgrs, executives all employees all in one table)
--   AHA 17: Regular Expressions : A sub language used to find data using patterns (i.e. find ssn, phone numbers)
--   AHA 18: DBA tasks: Adding users and privileges
-- -----------------------------------------------------------------------------
--    2. SHORTCUT KEYS/PREFERENCES
-- -------------------------------------------------
--        a. Preferences: Line Numbers
--              Tools->Preferences->Code Editor->Line Gutter-> Show Code Folding Margin
-- -------------------------------------------------
--        a. Preferences: Line Numbers
--              Tools->Preferences->Code Editor->Line Gutter-> Show Line Numbers (check)
-- -------------------------------------------------
--        b. Preferences: Change case as you type
--              Tools->Preferences->Code Editor->Completion Insight->Change case as you type
-- -------------------------------------------------
--        c. Preferences: Custom Shortcut Keys
--              Tools->Preferences->Shortcut Keys
--                  Lower Ctrl-where isbn = '1111111'
--                  Upper Ctrl-U
-- -------------------------------------------------
--        d. Shortcut Keys
--                Ctrl + N        New file will be open.
--
--                Alt + V + C       Opens the connections window

--                Ctrl + S        Save see tabe
--
--                Ctrl - /        Comment
--
-- -------------------------------------------------
--        e. Snipping Tool for Homework
--                WindowKey + R
--                Type snippingtool OK
--                New
--                Click and drag mouse
--                Copy and Paste
-- -----------------------------------------------------------------------------
--    3. SELECT 1 TABLE (QUESTION THAT REQUIRES 2 TABLES CALLED A JOIN)
-- -------------------------------------------------
            -- SETUP 1: as test create a practice table
            create table mycustomers as 
            select * from books.customers;
           
            create table myorders as 
            select * from books.orders;
            
            -- SETUP 2: as test (review chapter 2) 
            -- create two tables with the following columns and constraints
            --     TABLE
            --        small_customers
            --            columns
            --               cust_id    integer
            --               custname   varchar2(25)
            --            constraints
            --              primary key on cust_id
            --        small_orders
            --            columns
            --              oid       integer
            --              cid       integer
            --              ship_date char(2)
            --            constraints
            --              primary key on oid
            --              foreign key on cid referencing small_customers(cust_id)

            create table small_customers
            (cust_id integer primary key,
            custname varchar2(50));
            
            create table small_orders
            (oid integer primary key,
             cid integer,
             ship_state char(2),
            constraint cust_fk foreign key (cid) references small_customers(cust_id));
            
            insert into small_customers values (5000,	'Fred');
            insert into small_customers values (5001,	'Wilma');
            insert into small_customers values (5002,	'Barney');
            select * from small_customers;
            insert into small_orders values (100,	5000,	'FL');
            insert into small_orders values (101,	5002,	'FL');
            insert into small_orders values (102,	5002,	'FL');
            insert into small_orders values (103,	5000,	'TX');
            insert into small_orders values (104,	5003,	'TX');
            select * from user_constraints where table_name = 'SMALL_ORDERS';
            alter table small_orders drop constraint cust_fk;
-- --------------------------------------
--      a. 1-Table select : all columns 
            select * 
            from mycustomers;
--
-- -------------------------------------------------
--      b. 1-Table select some columns :             Called Database PROJECTION
--                                                                   WHICH COLUMNS          
            select firstname, lastname, state                       
            from mycustomers;
--
-- -------------------------------------------------
--      c. 1-Table select some columns and some rows
            select firstname, lastname, state
            from mycustomers
            where lastname = 'MORALES'; --           Called Database selection
            -- WHERE CLAUSE                                          WHICH ROWS
            -- TRUE FALSE QUESTION
            -- ON (THE RESULTS IN THE...) FROM CLAUSE
            -- English examples
            
-- -------------------------------------------------
--      d. 2-Table select
--         Have to combine two tables into one (oracle does this for us)
--         See spreadsheet
           select *
           from small_customers, small_orders
           where custname = 'Fred'
           and cust_id = cid;
--


create table employees
(emp_fname        varchar2(25) primary key,
 emp_lname        varchar2(25),
 hp_id            integer,
 constraint hp_fk foreign key(hp_id) references health_plans(hid));

create table health_plans
(hid integer primary key,
hp_plan varchar2(25));
insert into health_plans values (31,'ppo silver');
insert into health_plans values (33,'ppo gold');
insert into health_plans values (34, 'ppo platinnum');
insert into health_plans values (35,'hmo');

insert into employees values ('Alley','Raferty',31);
insert into employees values ('Belina','jones',33);
insert into employees values ('CASSIE','Hesinberg',33);
insert into employees values ('daniela','Robinson',34);
insert into employees values ('elaine','Simth',34);
insert into employees values ('mannie','Wiliams',50);
select * from employees;
-- -----------------------------------------------------------------------------
--    4. INSERTING :: MUST FOLLOW CONSTRAINTS 
        -- Several ways to INSERT
        -- a. SETUP 
        create table friends
        (
            friend_id   integer primary key,
            fname       varchar2(25),
            lname       varchar2(25),
            phone       varchar2(25),
            email       varchar2(25)
        );
        -- -----------------------------
        -- b. INSERT using No Column Names
        insert into friends values (1, 'Bill', 'Bailey',5552344444, 'bbailey@hotmail.com');
        --
        insert into friends values (2, 'Betty', 'Boop', '2304352222', 'booper@jazz.com'); 
        --    Is there a problem?
        -- -----------------------------
        -- c. INSERT using some columns (must follow constraint rules) but do not need to be in same order
        insert into friends (friend_id, fname, lname) values (3,'Big', 'Julie');
        select * from friends;
        --    Is there a problem?
        -- -----------------------------
        -- d. INSERT using all column names (useful if data has columns out of order
        insert into friends(email             ,phone             , fname  , lname       , friend_id) 
                    values ('hornet@comet.com','1 (512) 560-3456', 'Buzz' , 'LightYear' ,4);
        select * from friends;
        --    Is there a problem?
        -- -----------------------------
        -- e. Insert rows from another table
        --      must be same type and same order
        create sequence friends_seq;
        select friends_seq.nextval from dual;
        select * from friends;
        
        
        
        insert into friends ( friend_id           , fname       , lname)
        
        select                friends_seq.nextval , firstname   , lastname
        from books.customers;
        -- -----------------------------
        -- f. Insert rows from another table using a sequence
        -- setup
        create sequence friends_seq;
        insert into friends (friend_id, fname, lname) 
        select seq_friends.nextval, firstname, lastname
        from books.customers;
        -- -----------------------------------------------------------------------------
        -- g. INSERTING WHILE CREATING A NEWTABLE :: CTAS (Create Table AS select)
        --     NOTE: don't need all columns from the source table
        create table testcustomers as
              select customer#,firstname, lastname 
              from books.customers
              where state = 'FL';
        -- confirm
        select * from testcustomers;
-- -----------------------------------------------------------------------------
--    5. DELETING existing rows in a table :: MUST FOLLOW CONSTRAINTS
       select * from friends;
       
        select * from mybooks;
       -- a. need a command here to recover data
       rollback;
       -- b. try again delete those records with no email
       delete friends where email is null;
       select * from friends;
       -- c. If you commit cannot rollback
       commit;
-- -----------------------------------------------------------------------------
--    6. UPDATING COMMIT ROLLBACK SAVEPOINT
--        we need to make three sets of updates
--        to keep things clear on what we can and cannot rollback
--        First lets refresh our customers table
-- -----------------------------
--      a. Drop and recreate
--         CUSTOMERS
            drop table mycustomers;
            --    Create it again
            create table mycustomers
            as select * from books.customers;
            --    Add Primary Key
            alter table mycustomers add primary key(customer#);
-- -----------------------------
--      DATA CHANGE 0
--      DDL Statements do a double commit so we know this
--      is our last commit before we begin our work
-- =============================
--        DO NOT NEED SAVEPOINT HERE BECAUSE ALREADY BUILT IN
-- =============================  
-- -----------------------------
--      DATA CHANGE 1 (INSERT NEW CUSTOMERS)
--
--      b. INSERT new customers
        insert into mycustomers (customer#,lastname,firstname,address,city,state,zip,referred)
            values (1021,'UNDERWOOD','CAREY','1010 Brussel Rd','NASHVILE','TN','54343',1018);
        insert into mycustomers (customer#,lastname,firstname,address,city,state,zip,referred) 
            values (1022,'SEACREST','RYAN','2134 Holly Blvd','SANTA MONICA','CA','90504',null);
        insert into mycustomers (customer#,lastname,firstname,address,city,state,zip,referred)
            values (1023,'THUMB','TOM','BOX 22 100 Main St ','Boden','TX','32306',null);
        select * from mycustomers;    
-- -----------------------------
--    c. Lets create savepoints after each change
--        we will use a number in the name so we know which order
--        we created them in and use a word that helps remember the change
-- =============================
--        SAVEPOINT DATA CHANGE 1 (INSERT NEW CUSTOMERS)
          savepoint add_new_cusomters_sp1;
-- =============================          
-- -----------------------------
--      DATA CHANGE 2 (UPDATE EXISTING CUSTOMERS)      
--
--    d. UPDATE existing customersa (START EACH UPDATE WITH A select)
--        to identify which rows you are changing
        select * from mycustomers where firstname = 'CINDY';
-- -----------------------------
--    e. CINDY GOT MARRIED WANTS TO CHANGE HER NAME TO THOMAS
        select * from mycustomers where firstname = 'CINDY';
        --    Found 1 row
        update mycustomers set lastname = 'THOMAS' where firstname = 'CINDY';
        --    OK 1 row updated
        select * from mycustomers where firstname = 'CINDY';
        --    confirmed
-- -----------------------------
--    f. REESE CALLED said her PO Box is 81 not 18
        select * from mycustomers where firstname = 'REESE';
        -- Found 1 row
        update mycustomers set address = 'P.O. Box 81' where firstname = 'REESE';
        update mycustomers 
                set zip = '60600',
                    referred = '1003' 
         where firstname = 'REESE';
        -- OK 1 row updated
        select * from mycustomers where firstname = 'REESE';
        -- confirmed
-- -----------------------------
--    g. STEVE CALLED and said he had moved to new address:
        --    Address : 65-909 Tower
        --    City: Pinehill
        --    State: GA
        --    Zip: 29845
        select * from mycustomers where firstname = 'STEVE';
        -- only 1 row to update but four values to update
        update mycustomers 
        set address = '65-909 TOWER',
        city =  'PINEHILL',
        state = 'GA',
        zip = '29845'
        where firstname = 'STEVE';
-- -----------------------------
--    h. Create 2nd saveppoint (UPDATE EXISTING CUSTOMERS)
-- =============================
--      SAVEPOINT DATA CHANGE 2
        savepoint old_customers_update_sp2;
-- =============================          
-- -----------------------------
--      DATA CHANGE 3 (UPDATE NEW CUSTOMERS)      
-- -----------------------------
--    i. Lets update the new customers
        select *
        from mycustomers
        where customer# between 1021 and 1023;
-- -----------------------------
--    j. We just got the return postcards and both RYAN and TOM
--    want to thank BONITA for referring them
      select * from mycustomers where firstname = 'BONITA';
      select *
      from customers
      where firstname in ('RYAN', 'TOM');
-- -----------------------------
--    k. Wait what is Bonitas customer#
--     (select customer# 
--      from mycustomers 
--      where firstname = 'BONITA')
-- -----------------------------
--    l. ok good to go 1001
      update mycustomers 
          set referred = 
                          (select customer# 
                            from mycustomers 
                            where firstname = 'BONITA')
          where firstname in ('RYAN', 'TOM');
      -- comfirm
      select * from mycustomers where firstname in ('RYAN', 'TOM');
-- -----------------------------
--    m. Create 3nd saveppoint
-- =============================
--     SAVEPOINT DATA CHANGE 3 (UPDATE NEW CUSTOMERS)
       savepoint new_customers_update_sp3;
-- =============================
-- 
-- -----------------------------
--    o. REVIEW PLACES WHERE WE COULD RETURN TO
--        DATA CHANGE 0. last commit : original customers
--        DATA CHANGE 2. add_new_cusomters_sp1 : after we added new customers
--        DATA CHANGE 3. old_customers_update_sp2: after updating existing customers
--        DATA CHANGE 4. new_customers_update_sp3: after updating new customers
--
-- rollback; 
--      will take us all the way back to last commit
--      in other words back to before adding new customers
--
-- rollback to add_new_cusomters_sp1;
--      takes us back to before changes to old customers 
rollback to old_customers_update_sp2;
select * from mycustomers where firstname in ('TOM','RYAN'); 
--      takes us back to before changes to new customers 
-- roll back to new_customers_update_sp3;
--      takes us back to before changes to the book prices
rollback;

