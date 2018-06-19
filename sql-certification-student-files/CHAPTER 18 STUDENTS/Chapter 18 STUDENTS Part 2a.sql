-- =============================================================================
-- 8. Cascading Role privileges
-- -----------------------------------------------------------------------------
-- a. Drop all users
drop user andy cascade;;
drop user betty cascade;
drop user carla cascade;
drop user david cascade;
-- --------------------------;-------------
-- b. Create all users
create user andy identified by andy;
create user betty identified by betty;
create user carla identified by carla;
create user david identified by david;
-- ---------------------------------------
-- c. Grant all users basic privileges
--    create session
--    grant unlimited tablespace
--    create table
grant unlimited tablespace to andy,betty,carla,david;
grant create session to andy,betty,carla,david;
grant create table to andy,betty,carla,david;
-- ---------------------------------------
-- d. a role: one system and one object privilege
create role ourgang;
create role ourgangobjects;
-- ---------------------------------------
-- e. a role: one system and one object privilege
grant create table to ourgang with admin option; -- system privilege
grant select on books.books to ourgangobjects;  -- objects privilege
grant ourgangobjects to ourgang with admin option;
-- ---------------------------------------
-- f. a role: one system and one object privilege
select * 
from dba_role_privs 
where granted_role in ('OURGANG','OURGANGOBJECTS');
-- ---------------------------------------
-- g. a role: one system and one object privilege
select * from all_tab_privs
where grantee = 'ANDY';
-- ---------------------------------------
-- h. a role: one system and one object privilege
select * from dba_sys_privs
where grantee in ('ANDY','BETTY','CHARLY','DANIELLE');

-- ---------------------------------------
-- i. As system grant ourgang role top andy
grant ourgang to andy with admin option;



-- ---------------------------------------
-- j. as andy
grant ourgang to betty with admin option;


-- ---------------------------------------
-- k. as Betty
grant ourgang to carla with admin option;

-- ---------------------------------------
-- l. as carla
create table t (one integer);
select * from books.books;

-- ---------------------------------------
-- m. as system
drop user betty cascade;

-- ---------------------------------------
-- m. as carla
select * from books.books;
create table t1 (one integer);

-- NOTE:
-- In general if you get granted a priv through the admin option
-- You keep it even if the grantor leaves
-- If you get granted a privilege through grant option
-- You lose is if the grantor leaves































































select * from dba_roles;

select * from dba_role_privs where granted_role in ('OURGANG','OURGANGOBJECTS');
grant ourgang to andy with admin option;

grant create synonym to danielle;
grant create public synonym to danielle;

grant select on danielle.table_danielle to betty;




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
