-- =============================================================================
-- Chapter 18
/*

    DIFFERENTIATE SYSTEM FROM OBJECT PRIVILEGES
      SYSTEM PRIVILEGES :: GRANT PRIVILEGES ON OBJECTS <WITH ADMIN OPTION>
            create session          Connect to the database
            create table            Create a table in your user account. Includes ability to ALTER and DROP TABLE 
                                    Also includes ability to CREATE, ALTER, and DROP INDEX objects
            create view             Create a view in your user account. Includes ALTER and DROP
            create sequence         Create a sequence in your user account. Includes ALTER and DROP
            create synonym          Create a synonym in your user account. Includes ALTER and DROP. Does not include PUBLIC synonyms
            create public synonym   Create a synonym in the PUBLIC account. Does not
                                    include DROP, which is separate
            create role             Create a role. Includes ALTER and DROP
            create any ......       
            

      OBJECT PRIVILEGES :: GRANT PRIVILEGES ON TABLES <WITH GRANT OPTION>
            select
            update
            delete
            insert
            references              Create a foreign key
      
      VIEW PRIVILEGES IN THE DATA DICTIONARY
      
      ROLES
          Collection of privileges into a single bucket called a role
          Assign that bucket (role) to a user or another role
          
          Example:  Financial schema with 100 tables
                    1. Team has select privs on 23 base tables :: role = CLERKS_ROLE
                          Create role CLERKS_ROLE 
                          Grant select on 23 base tables to CLERKS_ROLE
                          Grant new users CLERKS_ROLE
                          
                    2. Another smaller admin team can see everything clerks can see    
                       plus they can also select on 4 other financial tables 
                          Create role ADMIN_ROLE 
                          Grant select on 4 additional tables to ADMIN_ROLE
                          Grant CLERKS_ROLE to ADMIN_ROLE
                          Grant ADMIN_ROLE to new senior financial managers
                                                    
                    3. Another smaller team handles adjustments, invoices, payments, collctions 
                          Create RECEIVABLES_ROLE :: insert, updates, deletes
                          Grant CLERKS_ROLE to RECEIVABLES_ROLE
                          Grant RECEIVABLES_ROLE to those handling payments and adjustments
*/
-- =============================================================================
-- REVIEW Chapter 14 Page 547
-- =============================================================================
-- 1. List current privileges 
-- -----------------------------------------------------------------------------
-- a. System privileges granted to the current user
select * from user_sys_privs; 
-- b. Granted privileges on objects for which the user is the owner, grantor, or grantee
select * from user_tab_privs;
-- c. Roles granted to the current user
select * from user_role_privs;
-- d. System privileges granted to users and roles
select * from dba_sys_privs;
-- e. All grants on objects in the database
select * from dba_tab_privs;
-- f. Roles granted to users and roles
select * from dba_role_privs; 
-- g. System privileges granted to roles
select * from role_sys_privs; 
-- h. Table privileges granted to roles
select * from role_tab_privs;
-- i. Session privileges which the user currently has set
select * from session_privs;

-- =============================================================================
-- 2. Test SQL Plus 
-- -----------------------------------------------------------------------------
-- Login as MyBooks
-- a. SELECT
select * from customers;
-- ---------------------------------------
-- b. INSERT 
Insert into customers values (1051,'Rockets','Billy','123 Main','Houston','TX','75678',null);
-- ---------------------------------------
-- c. CONFIRM 
select * from customers where customer# = 1051;
-- ---------------------------------------
-- d. COMMIT
commit;
-- ---------------------------------------
-- e. UPDATE 
update customers set City = 'Riverdale' where customer# = 1051;
-- ---------------------------------------
-- f. CONFIRM 
select * from customers where customer# = 1051;
-- ---------------------------------------
-- g. COMMIT
commit;
-- ---------------------------------------
-- h. DELETE 
delete customers where customer# = 1051;
-- ---------------------------------------
-- i. CONFIRM 
select * from customers where customer# = 1051;
-- ---------------------------------------
-- j. COMMIT
commit;
-- =============================================================================
-- 2. As System Create Users
-- -----------------------------------------------------------------------------
-- a. Create Users
--    andy
--       betty
--          carla
--             dana
-- ---------------------------------------
-- b. Confirm they can they login using SQL Plus



-- ---------------------------------------
-- c. Add basic privileges to all users
grant create session to andy;
grant unlimited tablespace to andy;
grant create table to andy;






-- ---------------------------------------
-- d. Confirm in SQL Plus what Andy can do





-- ---------------------------------------
-- e. Create a connection object in SQL Developer for Andy





-- ---------------------------------------
-- f. Confirm in SQL Developer what Andy can do





-- ---------------------------------------
-- e. Create a connection object in SQL Developer for other users





-- =============================================================================
-- 3. As Andy (and sometimes betty)
-- -----------------------------------------------------------------------------
-- a. As Andy Create parent table 
-- drop table my_cust cascade constraints;
create table my_cust
(cust_id        integer primary key,
 c_name         varchar2(25),
 dob            date,
 state          char(2),
 pin            integer
 );
-- ---------------------------------------
-- b. As Andy Insert 
insert into my_cust values (1,'Bucko','01-JAN-81','TX',78750);
insert into my_cust values (2,'Bucko','01-JAN-81','TX', 78729);

-- ---------------------------------------
-- c. As Andy Create child table 
-- drop table my_ords
create table my_ords
( order#        integer primary key,
  cust_id       integer references my_cust(cust_id),
  dt_order      date,
  dt_shipped    date
 );
-- ---------------------------------------
-- d. As Andy Insert
insert into my_ords values (55,1,'15-MAR-15','29-MAR-15');
insert into my_ords values (56,2,'19-MAR-15','01-APR-15');

-- ---------------------------------------
-- e. As Andy Create view
create view vw_cust as 
select cust_id,c_name,dob,state from my_cust;

-- ---------------------------------------
-- f. As Andy grant select on my_cust to betty
grant select on vw_cust to betty;



-- ---------------------------------------
-- g. As Betty confirm privilege



-- ---------------------------------------
-- g. As Andy create public synonym ps_andys_orders
create or replace public synonym andys_orders for my_ords;



-- -----------------------------------------------------------------------------------
-- h. What now?




-- -----------------------------------------------------------------------------------
-- i. As Betty confirm access using public synonym



-- -----------------------------------------------------------------------------------
-- j. Anything else?




-- =============================================================================
-- 3. As system (and other usual suspects)
-- -----------------------------------------------------------------------------
-- a. As system Drop all users 




-- -----------------------------------------------------------------------------------
-- b. As system Create Andy 
--     i.     Drop Andy 
--     ii.    Recreate Andy with 
--              1. privilege to connect 
--              2. use tablespace
--              3. create table
--              4. create public synonym with admin option



-- -----------------------------------------------------------------------------------
-- b. As system Create other three users 
--     i.   To use their schema (tablespace)
--     i.   To create tables



-- -----------------------------------------------------------------------------------
-- c. As Andy 
--     i.     Create tables 
--     ii.    Insert into tables
--     iii.   Create Private synonym vw_private_customers for my_cust
--     iv.    Grant select vw_private_customers to Betty 
--     vi.    Create Public synonym public_orders for my_ords



-- ---------------------------------------
-- d. As Andy Insert


-- ---------------------------------------
-- e. As Andy Create view
create view vw_cust as 
select cust_id,c_name,dob,state from my_cust;

-- ---------------------------------------
-- f. As Andy grant select on my_cust to betty




-- -----------------------------------------------------------------------------------
-- e. As Andy 
--     i.     Create two tables above 
--     ii.    Insert rows
--     iii.   Create public synonym andys_orders for my_ords
--     iv.    Grant Betty public synonym with admin option




-- -----------------------------------------------------------------------------------
-- e. As Betty 
--     i.     Create two tables above 
--     ii.    Insert rows


grant create table to andy with admin option;




-- -----------------------------------------------------------------------------------
-- d. As andy confirm privileges


grant select on books.books to andy with grant option;
grant select on cruises.employees to andy with grant option;
revoke select on books.books from andy;
revoke select on cruises.employees from andy;
-- a role: one system and one object privilege
create role ourgang;
create role ourgangobjects;

grant create table to ourgang with admin option; -- system privilege
grant select on books.books to ourgangobjects;
grant ourgangobjects to ourgang with admin option;

select * 
from dba_role_privs 
where granted_role in ('OURGANG','OURGANGOBJECTS');

select * from all_tab_privs
where grantee = 'ANDY';

select * from dba_sys_privs
where grantee in ('ANDY','BETTY','CHARLY','DANIELLE');

select * from dba_roles;

select * from dba_role_privs where granted_role in ('OURGANG','OURGANGOBJECTS');
grant ourgang to andy with admin option;

grant create synonym to danielle;
grant create public synonym to danielle;

grant select on danielle.table_danielle to betty;


-- as andy
create table table_andy4
(one  integer);
-- select
-- update
-- delete
-- insert
-- index

-- as andy
insert into table_andy values (1);
update table_andy set one = 2;
select * from table_andy;

create index ix_name on table_andy(one);
drop index ix_name;
delete from table_andy;
select * from table_andy;
grant create table to betty with admin option;

select * from books.books;
select * from books.customers;
select * from cruises.employees;
select * from cruises.ships;

grant select on books.books to betty with grant option;
grant select on cruises.employees to betty with grant option;
revoke select on books.books from betty;
revoke select on cruises.employees from betty;

grant ourgang to betty with admin option;

-- as betty
create table table_betty2
(one  integer);

insert into table_betty values (1);
update table_betty set one = 2;
select * from table_betty;

create index ix_name on table_betty(one);
drop index ix_name;
delete from table_betty;
select * from table_betty;

grant create table to charly with admin option;
select * from books.books;
select * from cruises.employees;
grant select on books.books to charly with grant option;
grant select on cruises.employees to charly with grant option;

grant ourgang to charly with admin option;

select * from dtable;


-- charly
create table table_charly2
(one integer);

grant create table to danielle;
select * from books.books;
select * from cruises.employees;
grant select on books.books to danielle;
grant select on cruises.employees to danielle;
grant select on books.customers to danielle;

grant ourgang to danielle;
-- danielle
create table table_danielle4
(one integer);
insert into table_danielle values (599);
commit;
select * from books.books;
select * from cruises.employees;

create synonym dbooks for books.books;
create public synonym dtable for danielle.table_danielle;
create public synonym dbooks for danielle.table_danielle;

select * from dbooks;

-- as system
drop user charly cascade;

-- as danielle
create table table_danielle2
(one integer);



select * from dba_role_privs
where granted_role in ('DBA','RESOURCE','CONNECT');

-- overlap of privileges 
-- object privilege given directly
-- same object privilege given through a role
-- what happens 
-- 1. if you revoke the role and keep the priv
-- 2. if you revoke the priv and keep the role
drop user andy cascade;
drop user betty cascade;
drop user charly cascade;
drop user danielle cascade;

create user andy identified by andy;
grant create session to andy;
grant unlimited tablespace to andy;

create user betty identified by betty;
grant create session to betty;
grant unlimited tablespace to betty;

create role testgroup;
grant select on books.customers to testgroup;
grant select on books.orders to testgroup;
grant select on books.orderitems to testgroup;

grant testgroup to andy;
revoke testgroup from andy;

grant select on books.customers to andy with grant option;
grant create table to andy with admin option;

grant select on books.customers to betty with grant option;
grant create table to betty with admin option;

revoke select on books.customers from betty;
revoke create table from betty;


grant select on books.orders to andy;
grant select on books.orderitems to andy;

revoke select on books.customers from andy;
revoke select on books.orders from andy;
revoke select on books.orderitems from andy;

-- as andy
select * from books.customers;
select * from books.orders;
select * from books.orderitems;

-- as andy
select * from books.customers;
create table temp
(one integer);

grant select on books.customers to betty;
grant create table to betty;

-- as betty
select * from books.customers;
create table temp2
(one  integer);






drop user andy cascade;
create user andy identified by andy;
drop user betty cascade;
create user betty identified by betty;
drop user charly cascade;
create user charly identified by charly;
drop user danielle;
create user danielle identified by danielle;
grant create session to andy,betty,charly,danielle;
-- as system
grant create any table to andy with admin option;
grant unlimited tablespace to andy with admin option;
grant select, insert, update, delete on books.books to andy with grant option;
-- as andy
grant create any table to betty with admin option;
grant unlimited tablespace to betty with admin option;
grant select, insert, update, delete on books.books to betty with grant option;
select * from books.books;
create table cust
(cid integer primary key,
 name varchar2(10));
create table ords
(oid  integer primary key,
 cust_id  integer,
 ord_amt  number(5,2));
insert into cust values (1,'Fred');
insert into cust values (2,'Betty');
insert into ords values (500,2,29.95);
insert into ords values (501,1,19.95); 

 
-- as betty
grant create any table to charly with admin option;
grant unlimited tablespace to charly with admin option;
grant select, insert, update, delete on books.books to danielle with grant option;
select * from books.books;
create table cust
(cid integer primary key,
 name varchar2(10));
create table ords
(oid  integer primary key,
 cust_id  integer,
 ord_amt  number(5,2));
insert into cust values (1,'Fred');
insert into cust values (2,'Betty');
insert into ords values (500,2,29.95);
insert into ords values (501,1,19.95); 

-- as charly
grant create any table to danielle;
grant unlimited tablespace to danielle;

create table cust
(cid integer primary key,
 name varchar2(10));
create table ords
(oid  integer primary key,
 cust_id  integer,
 ord_amt  number(5,2));
insert into cust values (1,'Fred');
insert into cust values (2,'Betty');
insert into ords values (500,2,29.95);
insert into ords values (501,1,19.95); 

-- as danielle
create table cust
(cid integer primary key,
 name varchar2(10));
create table ords
(oid  integer primary key,
 cust_id  integer,
 ord_amt  number(5,2));
insert into cust values (1,'Fred');
insert into cust values (2,'Betty');
insert into ords values (500,2,29.95);
insert into ords values (501,1,19.95); 
-- ----------------
create table cust2
(cid integer primary key,
 name varchar2(10));
create table ords2
(oid  integer primary key,
 cust_id  integer,
 ord_amt  number(5,2));
insert into cust2 values (1,'Fred');
insert into cust2 values (2,'Betty');
insert into ords2 values (500,2,29.95);
insert into ords2 values (501,1,19.95); 
select * from books.books;
--

-- manny
-- nancy
-- opie
-- paul
-- finance_role
-- assign to finance_role (system) create any table
-- assign to finance_role (object) select on books.books

drop user manny;
drop user nancy;
drop user opie;
drop role test_role;
drop role test_books;

















create role test_books;

create role test_role;

grant create session to manny,nancy,opie;

create role test_books;
create role test_role;
grant select on books.books to test_role;
grant test_role to manny with admin option;

-- for test_books
-- grant a system privilege and an object privilege
-- as system grant system priv
grant create any table to test_books with admin option;
grant unlimited tablespace to test_books with admin option;
-- as system grant object priv
grant select on books.books to test_books;;
-- as system grant to manny this role with admin option
grant test_books to manny with admin option;
-- as manny
grant test_books to nancy with admin option;
grant test_role to nancy with admin option;

select * from user_role_privs;
select * from role_sys_privs;
select * from role_tab_privs;

select * from books.books;
create table books.books_manny
(one integer,
 two varchar2(10));

-- as nancy
grant test_books to opie;
select * from books.books;
-- as opie test both the system and object privilege
create table books.books_opie
(one integer,
 two varchar2(10));
 
select * from books.books; 

select * from user_tab_privs;
select * from user_role_privs;

where grantee = 'MANNY';

select * from user_sys_privs;

select * from user_role_privs;
select * from role_tab_privs;
select * from role_sys_privs;




create user manny identified by manny;
create user nancy identified by nancy;
create user opie identified by opie;
grant create session to manny,nancy,opie;

create role apple_pie;
grant create any table to apple_pie;
grant select on books.books to apple_pie;
grant apple_pie to manny with admin option;

grant drop any table to manny with admin option;
grant select on books.customers to manny with grant option;

-- as manny
select * from books.books;
create table books.books_of_manny
(one integer,
 two varchar2(15));
 
grant apple_pie to nancy with admin option; 
revoke apple_pie from nancy;

grant drop any table to nancy with admin option;
grant select on books.customers to nancy with grant option;


revoke drop any table from nancy;
revoke select on books.customers from nancy;

-- as nancy
select * from books.books;
create table books.books_of_nancy
(one integer,
 two varchar2(15));
 
grant apple_pie to opie;
grant drop any table to opie;
grant select on books.customers to opie;


-- as opie
select * from books.books;
select * from books.customers;
create table books.books_of_opie6
(one integer,
 two varchar2(15));

drop table books.books_of_opie5;

-- as system
drop user nancy;
create user nancy identified by nancy;





drop user opie cascade;

--HARDING: andy
--ALBERT: betty
-- as andy(HARDING)
create table teapot
(one integer);



-- as system
grant create role to andy;
grant create public synonym to andy;

-- andy
create role dome;
create public synonym teapot for andy.teapot;
grant dome to betty;
grant select on teapot to dome;

select * from dome.andy.teapot;
select * from andy.dome.teapot;
select * from andy.teapot;

select * from teapot;