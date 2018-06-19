-- =============================================================================
-- CHAPTER 2
/*
  Categorize the Main Database Objects
  Create a Simple Table
  Review the Table Structure
  List the Data Types That Are Available for Columns
  Explain Creating Constraints at and after table creation
      TABLE:    Throughout book
      INDEX:      Chapter 4
      VIEW:       Chapter 10
      SEQUENCE:   Chapter 10
      SYNONYM:    Chapter 10
      CONSTRAINT: Throughout Book
        Primary Key
        Unique
        Check
        Not null
        Check
        Foreign Key We will do foreign key last 
      USERS:      Chapter 18
      ROLES:      Chapter 18
*/


-- -----------------------------------------------------------------------------
-- 1. TABLE Creation No constraints
Create table employees
(employee_id  interger,
 fname        varchar2(20),
 lname        varchar2(20),
 phone        varchar2(20),
 start_date   date,
 ssn          char(10),
 -- -----------------------------------------------------------------------------
-- 2. TABLE Creation With in-line constraints (no names)
Drop table employees;
Create table employees
(employee_id  integer primary key,
 fname        varchar2(20),
 lname        varchar2(20),
 phone        varchar2(20) unique,
 gender       char(1) check (gender in ('M','m','F','f')),
 start_date   date default sysdate,
 ssn          char(10) not null
 );
-- -----------------------------------------------------------------------------
-- 3. TABLE Creation With in-line constraints (no names)
Drop table employees;
Create table employees
(employee_id  integer constraint emp_pk primary key,
 fname        varchar2(20),
 lname        varchar2(20),
 phone        varchar2(20) constraint ph_u unique,
 gender       char(1) check (gender in ('M','m','F','f')), -- cannot name check constraint in line
 start_date   date default sysdate,
 ssn          char(10) constraint ssn_nn not null
 );
-- ----------------------------------------------------------------------------- 
-- 4. TABLE Creation With out-of-line constraints
Drop table employees;
Create table employees
(employee_id  integer,
 fname        varchar2(20),
 lname        varchar2(20),
 phone        varchar2(20), 
 gender       char(1), 
 start_date   date default sysdate,
 ssn          char(10), 
 constraint emp_pk primary key(employee_id),
 constraint ph_unique unique(phone),
 -- constraint ssn_nn not null(ssn) -- cannot create no null out-of-line
 constraint gender_ck check (gender in ('M','m','F','f')) -- cannot name check constraint in line
);
-- -----------------------------------------------------------------------------
-- 5. ALTER TABLE to add single table constraints after Creation
Drop table employees;
Create table employees
(employee_id  integer,
 fname        varchar2(20),
 lname        varchar2(20),
 phone        varchar2(20), 
 gender       char(1), 
 start_date   date,
 ssn          char(10) 
 );
-- ----------------------------
-- PRIMARY KEY
-- a. ALTER TABLE ADD (OUT-OF-LINE) with and without names inline
alter table employees add constraint emp_pk primary key(employee_id);
alter table employees drop primary key;
alter table employees add primary key(employee_id);
-- ----------------------------
-- b. ALTER TABLE MODIFY (IN-LINE) with and without names inline
alter table employees modify employee_id constraint emp_pk primary key;
alter table employees drop primary key;
alter table employees modify employee_id primary key;
-- ----------------------------
-- UNIQUE
-- c. ALTER TABLE ADD (OUT-OF-LINE) with and without names inline
alter table employees add constraint ph_unique unique(phone);
alter table employees drop constraint ph_unique;
alter table employees add unique(phone);
-- ----------------------------
-- d. ALTER TABLE MODIFY (IN-LINE) with and without names inlinee
alter table employees modify phone constraint ph_un unique;
alter table employees drop constraint ph_un;
alter table employees modify phone unique;
-- ----------------------------
-- CHECK
-- e. ALTER TABLE ADD (OUT-OF-LINE) with and without names inline
alter table employees add constraint gender_ck check (gender in ('M','m','F','f'));
alter table employees drop constraint gender_ck;
alter table employees add check (gender in ('M','m','F','f'));
-- ----------------------------
-- f. ALTER TABLE MODIFY (IN-LINE) with and without names inline
alter table employees modify gender constraint gender_ck check (gender in ('M','m','F','f'));
alter table employees drop constraint gender_ck;
alter table employees modify gender check (gender in ('M','m','F','f'));
-- ----------------------------
--  More on CHECK CONTRAINTS
--  A check constraint can NOT be defined on a SQL View. To be discussed in later chapter
--  The check constraint defined on a table must refer to only columns in that table. It can not refer to columns in other tables.
--  A check constraint can NOT include a SQL Subquery.
--  A check constraint can be defined in either a SQL CREATE TABLE statement or a SQL ALTER TABLE statement.
-- ----------------------------
-- NOT NULL ::  Cannot be created Out-Of-Line
-- g. ALTER TABLE ADD (OUT-OF-LINE) with and without names inline
alter table employees add constraint ssn_nn not null (ssn);
-- ----------------------------
-- h. ALTER TABLE MODIFY (IN-LINE) with and without names inline
alter table employees modify ssn constraint ssn_nn not null;
alter table employees drop constraint ssn_nn;
alter table employees modify ssn not null;
-- ----------------------------
-- DEFAULT 
-- i. DEFAULT :: IS NOT CONTRAINT
--    So cannot name
--    Chapter 14 :: ALL_CONSTRAINTS, DBA_CONSTRAINTS, USER_CONSTRAINTS 
--               Query the DATA_DEFAULT column from DBA_TAB_COLUMNS, ALL_TAB_COLUMNS, USER_TAB_COLUMNS depending on privileges
-- Change the status of a default after table creation
alter table employees modify start_date default sysdate;
alter table employees modify start_date default null;
-- -----------------------------------------------------------------------------
-- 6. ALTER TABLE to add foreign keys after Creation
--    FOREIGN KEY
--    Identifies column in child table to match column in parent table
--    Parent must already have PK
--    Prevents oprhans
-- ----------------------------
-- a. TABLE SETUP
create table cust
( 
  custid    number primary key,
  custname  varchar2(25)
);
create table ords
(
  oid       number primary key,
  cid       number,
  ship_st   varchar2(2)
);
-- ----------------------------
-- b. TABLE INSERTS
insert into cust values(5000,'Fred');
insert into cust values (5001,'Wilma');
insert into cust values (5002,'Barney');
select * from cust;
insert into ords values (100,5000,'FL');
insert into ords values (101,5002,'FL');
insert into ords values (102,5002,'FL');
insert into ords values (103,5000,'TX');
select * from ords;
commit;
-- ----------------------------
-- c. JOIN :: ASK A QUESTION OF MORE THAN ONE TABLE
select * 
from cust, ords;
-- -----------------------------------------------------------------------------
-- 7. USING DESC :: 2 uses (depends on context)
-- -- ----------------------------
-- a. Sorting in descending order;
select title
from books.books
order by title;
-- -- ----------------------------
-- b. DESCribing a table;
desc books.books;
-- =============================================================================
--  CHAPTER 3
/*
    DML, DDL, TCL :: Page 95
    
    DDL
      CREATE Used to create object tables, views etc :: throughout book
      ALTER Modify objects :: throughout book
      DROP Remove objects :: throughout book
      RENAME Rename objects :: throughout book
      TRUNCATE Removes all of the rows :: cannot be rolled back
      GRANT :: Give privileges Chapter 18
      REVOKE :: Removes privileges Chapter 18
      FLASHBACK :: 
      PURGE :: Removes objects from recycle bin
      COMMENT :: Chapter 10
    
    DML
      SELECT 
      INSERT
      UPDATE
      DELETE
      MERGE :: Chapter 11
      
    TCL
      COMMIT
      ROLLBACK
      SAVEPOINT
*/
-- -----------------------------------------------------------------------------
-- 1. INSERTING into a table :: MUST FOLLOW CONSTRAINTS   
-- -----------------------------
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
-- b. INSERT No Columns
insert into friends values (1, 'Bill', 'Bailey',5552344444, 'bbailey@hotmail.com');
insert into friends values (2, 'Betty', 'Boop', '2304352222', 'booper@jazz.com'); 
--    Is there a problem?
-- -----------------------------
-- c. Some columns (must follow constraint rules) but do not need to be in same order
insert into friends (friend_id, fname, lname) values (3,'Big', 'Julie');
--    Is there a problem?
-- -----------------------------
-- d. All columns
insert into friends(email, phone, fname, lname, friend_id) values ('hornet@comet.com','1 (512) 560-3456', 'Buzz', 'LightYear',4);
--    Is there a problem?
-- -----------------------------
-- e. Don't forget to commit;
commit;
-- -----------------------------------------------------------------------------
-- 2. SORTING & SEQUENCES
-- -----------------------------
-- a. Sometimes when inserting I can't remember what the next value for ID is. There might be thousands of rows. 
--    So SQL gives us a counting object we can use that keeps track for us.
--    It is called a sequence. There is lots to know about sequences but lets start at the beginning
--    with a very simple example.
--    But before we create one to use with inserting into our friends table 
--    lets see what we want to set the sequence to start with. 
--    What is the biggest friend_id now?
--    A simple select works really well if there are just a few rows.
select friend_id, fname, lname, phone, email  
from friends;
-- -----------------------------
-- b. But if there are hundreds of rows use max Chapter 7
select max(friend_id)
from friends
order by friend_id desc;
-- -----------------------------
-- c. Okay now we know the largest existing number is 2
--    Lets create a sequence that starts with 3
create sequence seq_friends start with 3;
-- -----------------------------
-- d. Now we can use this sequence without having to remember the
--    last id in our table
insert into friends (friend_id, fname, lname, phone, email) values (seq_friends.nextval, 'Bubba','Gump','234-567-8888','bubba@bubbagumpshrimp.com');
-- -----------------------------------------------------------------------------
-- 3. INSERTING :: Using Select from another table
-- -----------------------------
-- a. You can also insert rows into one table from another table, as long as the data is the 
--    same type. You can also use the sequence created for use with the friends table
Insert into friends (friend_id, fname, lname) 
select seq_friends.nextval, firstname, lastname
from books.customers;
-- -----------------------------------------------------------------------------
-- 4. INSERTING WHILE CREATING A NEWTABLE :: CTAS
--     CTAS is Create Table AS SELECT
--     make sure you are in your schema 
--     NOTE: you do not need to use all the columns from the cource table
create table customers
as select customer#,firstname, lastname 
from books.customers
where state = 'FL';
select * from customers;
-- -----------------------------------------------------------------------------
-- 5. Lets do that again: CTAS 
--     But this time from cruises
select * from ship_cabins;
create table ship_cabins
as 
select *
from cruises.ship_cabins;
select * from ship_cabins;
-- -----------------------------------------------------------------------------
-- 6. DELETING existing rows in a table :: BE CAREFUL AND MUST FOLLOW CONSTRAINTS
--    COMMIT, ROLLBACK
-- -----------------------------
-- a. Setup :: First lets make a fresh copy of customers in our own schema
--    Make sure you are in your own schema
--    Drop the one we already created
--
--    CUSTOMERS
drop table customers;
--    Create it again
create table customers
as select * from books.customers;
--    Add Primary Key
alter table customers add primary key(customer#);
-- -----------------------------
--    BOOKS
create table books
as select * from books.books;
--    Add Primary Key
alter table books add primary key(isbn);
-- -----------------------------
-- b. Add some new customers to books 
--    First change to CONNECTION : BOOKS
insert into customers (customer#,lastname,firstname,address,city,state,zip,referred)
    values (1021,'UNDERWOOD','CAREY','1010 Brussel Rd','NASHVILE','TN','54343',1018);
insert into customers (customer#,lastname,firstname,address,city,state,zip,referred) 
    values (1022,'SEACREST','RYAN','2134 Holly Blvd','SANTA MONICA','CA','90504',null);
insert into customers (customer#,lastname,firstname,address,city,state,zip,referred)
    values (1023,'THUMB','TOM','BOX 22 100 Main St ','Boden','TX','32306',null);
-- -----------------------------
-- c. Lets Check
select *
from books.customers
where customer# = 1021 or
      customer# = 1022 or
      customer# = 1023; 
-- -----------------------------
-- d. What happens if we try to insert them a second time
insrt into customers (customer#,lastname,firstname,address,city,state,zip,referred)
    values (1021,'UNDERWOOD','CAREY','1010 Brussel Rd','NASHVILE','TN','54343',1018);
insert into customers (customer#,lastname,firstname,address,city,state,zip,referred) 
    values (1022,'SEACREST','RYAN','2134 Holly Blvd','SANTA MONICA','CA','90504',null);
insert into customers (customer#,lastname,firstname,address,city,state,zip,referred)
    values (1023,'THUMB','TOM','BOX 22 100 Main St ','Boden','TX','32306',null);
-- no good
-- -----------------------------
-- e. We could do a rollback if we have not committed yet
rollback;
-- -----------------------------
-- f. Then we could insert again
insert into customers (customer#,lastname,firstname,address,city,state,zip,referred)
    values (1021,'UNDERWOOD','CAREY','1010 Brussel Rd','NASHVILE','TN','54343',1018);
insert into customers (customer#,lastname,firstname,address,city,state,zip,referred) 
    values (1022,'SEACREST','RYAN','2134 Holly Blvd','SANTA MONICA','CA','90504',null);
insert into customers (customer#,lastname,firstname,address,city,state,zip,referred)
    values (1023,'THUMB','TOM','BOX 22 100 Main St ','Boden','TX','32306',null);
-- -----------------------------
-- g. If we commit we can no longer ROLLBACK
commit;
-- -----------------------------
-- h. Lets test
select *
from books.customers
--where customer# = 1021 or
--      customer# = 1022 or
--      customer# = 1023; 
where customer# in (1021, 1022, 1023);
-- -----------------------------
-- i. Run Rollback
rollback;
-- -----------------------------
-- j. Lets check again :: Still there
select *
from books.customers
--where customer# = 1021 or
--      customer# = 1022 or
--      customer# = 1023; 
-- -----------------------------
-- where customer# in (1021, 1022, 1023);
where customer# between 1021 and 1023;
-- -----------------------------
-- k. Lets Delete
delete from customers;
-- -----------------------------
-- l. Lets check again Uh-Oh 
select *
from customers
where customer# between 1021 and 1023;
-- -----------------------------
-- m. Oops  Lets rollback
rollback;
-- -----------------------------
-- n. Lets check again :: whew
select *
from customers
where customer# between 1021 and 1023;
-- -----------------------------
-- o. ALWAYS RUN A SELECT STATEMENT USING THE WHERE
--    CLAUSE YOU WANT TO USE TO DELETE
select * from 
customers
where customer# between 1021 and 1023;
-- -----------------------------
-- p. ALWAYS RUN A SELECT STATEMENT USING THE WHERE
--    CLAUSE YOU WANT TO USE TO DELETE
--    THEN COMMENT OUT AND ADD DELETE 
--select * from 
delete 
customers
where customer# between 1021 and 1023;
-- -----------------------------
-- q. Now lets rollback again
rollback;
-- -----------------------------
-- rq. Confirm where we are
select * from customers;
-- -----------------------------
-- s. Commit
commit;
-- t. DELETES MUST FOLLOW CONSTRAINTS
-- CUSTOMER# 
-- 1005	      GIRARD	    CINDY
-- HAS ORDERS
    select order#
    from books.orders
    where customer# = 1005;
-- u. Can we delete Cindy while she has orders?    
delete from books.customers
where customer# = 1005;
-- -----------------------------------------------------------------------------
-- 7. UPDATING COMMIT ROLLBACK SAVEPOINT
--    we need to make three sets of updates
--    to keep things clear on what we can and cannot rollback
--    First lets refresh our customers table
-- -----------------------------
-- a. Drop and recreate
--    CUSTOMERS
drop table customers;
--    Create it again
create table customers
as select * from books.customers;
--    Add Primary Key
alter table customers add primary key(customer#);
-- -----------------------------
-- DDL Statements do a double commit so we know this
-- is our last commit before we begin our work
-- -----------------------------
-- b. add the new customers
insert into customers (customer#,lastname,firstname,address,city,state,zip,referred)
    values (1021,'UNDERWOOD','CAREY','1010 Brussel Rd','NASHVILE','TN','54343',1018);
insert into customers (customer#,lastname,firstname,address,city,state,zip,referred) 
    values (1022,'SEACREST','RYAN','2134 Holly Blvd','SANTA MONICA','CA','90504',null);
insert into customers (customer#,lastname,firstname,address,city,state,zip,referred)
    values (1023,'THUMB','TOM','BOX 22 100 Main St ','Boden','TX','32306',null);
-- -----------------------------
-- c. Lets create savepoints after each change
--    we will use a number in the name so we know which order
--    we created them in and use a word that helps remember the change
savepoint add_new_cusomters_sp1;
-- -----------------------------
-- d. SIMILAR TO WHERE :: START EACH UPDATE WITH A SELECT
--    to identify which rows you are changing
Select * from customers where firstname = 'CINDY';
-- -----------------------------
-- e. CINDY GOT MARRIED WANTS TO CHANGE HER NAME TO THOMAS
Select * from customers where firstname = 'CINDY';
-- Found 1 row
update customers set lastname = 'THOMAS' where firstname = 'CINDY';
-- OK 1 row updated
Select * from customers where firstname = 'CINDY';
-- confirmed
-- -----------------------------
-- f. REESE CALLED said her PO Box is 81 not 18
Select * from customers where firstname = 'REESE';
-- Found 1 row
update customers set address = 'P.O. Box 81' where firstname = 'REESE';
-- OK 1 row updated
Select * from customers where firstname = 'REESE';
-- confirmed
-- -----------------------------
-- g. STEVE CALLED and said he had moved to new address:
--    Address : 65-909 Tower
--    City: Pinehill
--    State: GA
--    Zip: 29845
Select * from customers where firstname = 'STEVE';
-- only 1 row to update but four values to update
update customers 
set address = '65-909 TOWER',
set city =  'PINEHILL',
set state = 'GA',
set zip = '29845'
where firstname = 'STEVE';
-- -----------------------------
-- h. Create 2nd saveppoint
savepoint old_customers_update_sp2;
-- -----------------------------
-- i. Lets update the new customers
select *
from customers
where customer# between 1021 and 1023;
-- -----------------------------
-- j. We just got the return postcards and both RYAN and TOM
--    want to thank BONITA for referring them
select *
from customers
where firstname in ('RYAN', 'TOM');
-- -----------------------------
-- k. Wait what is Bonitas customer#
select * from customers where firstname = 'BONITA';
-- -----------------------------
-- l. ok good to go 1001
update customers set referred = 1001
where firstname in ('RYAN', 'TOM');
-- comfirm
select * from customers where firstname in ('RYAN', 'TOM');
-- -----------------------------
-- m. Create 3nd saveppoint
savepoint new_customers_update_sp3;
-- -----------------------------
-- n. Lets mark the price of all the Family Life books
--    down by 10%
select * from books where category = 'FAMILY LIFE';
--    capture the values before we change
--    Mickey     22
--    PAINLESS   89.95
update books set retail = retail * .9 where category = 'FAMILY LIFE';
-- confirm 
select * from books where category = 'FAMILY LIFE';
-- -----------------------------
-- o. REVIEW PLACES WHERE WE COULD RETURN TO
--    1. last commit : original customers
--    2. add_new_cusomters_sp1 : after we added new customers
--    3. old_customers_update_sp2: after updating existing customers
--    4. new_customers_update_sp3: after updating new customers
--
-- rollback; 
--      will take us all the way back to last commit
--      in other words back to before adding new customers
--
-- rollback to add_new_cusomters_sp1;
--      takes us back to before changes to old customers 
-- rollback to old_customers_update_sp2;
--      takes us back to before changes to new customers 
-- roll back to new_customers_update_sp3;
--      takes us back to before changes to the book prices
