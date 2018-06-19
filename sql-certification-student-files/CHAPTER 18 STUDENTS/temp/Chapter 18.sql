-- as system
-- grant some prvis to ace.
create user ace identified by ace;
grant create session to ace; 
grant create table to ace;
grant unlimited tablespace to ace;

create user betty identified by betty;
grant create session to betty;
grant create table to betty;
grant unlimited tablespace to betty;
grant select on books1.vw_customers to betty;

grant select on books1.books to betty;
grant create public synonym to betty;

grant select on books1.books to ace;

select *
from all_synonyms;

alter user betty identified by betty;

--log in as Ace
drop table test;
create table test
(one integer);
insert into test values(1);

select * from bks;

-- log in as betty
create table betty_test
(one integer);
insert into betty_test values (500);
select * from betty_test;
update betty_test set one = 222 where one = 500;
delete from betty_test;

select * from books1.books;

create public synonym bks for books1.books;

select * from bks;

select * from books1.vw_customers;
select * from books1.customers;

-- login as books1
drop view vw_customers;
create view vw_customers
as select customer#,firstname,lastname
from customers;

-- as system lets regrant access to that view to betty and retry bettys access
-- 1. books1 creates view call vw_customers
--    CLEANUP as books1 drop view drop view vw_customers;
create view vw_customers as select customer#, firstname, lastname from customers;
-- 2. system grants select on view to betty
--    CLEANUP as syatem revoke the priv to betty revoke select on books1.vw_customers from betty;
grant select on books1.vw_customers to betty;
-- 3. betty does now have access
select * from books1.vw_customers;
select * from books1.customers;
select * from bks;
-- 4. as books1 drops the view
drop view vw_customers;
-- 5. as betty fail to access
select * from books1.vw_customers;
-- 6. as books1 re-create the view
create view vw_customers as select customer#, firstname, lastname from customers;
-- 7. test if betty has access 
select * from books1.vw_customers;
-- 8. as system regrant select on view to betty 
grant select on books1.vw_customers to betty;
-- 9. test if betty has access 
select * from books1.vw_customers;


-- does this work the same way on tables
-- 1. books create table testabc
create table testabc(one integer);
insert into testabc values(5000);
commit;
-- 2. does betty currently have access to testabc?
select * from books1.testabc;
-- 3. as system grant access to testabc to betty
grant select on books1.testabc to betty;
-- 4. does betty currently have access to testabc?
select * from books1.testabc;
-- 5. books drop table testabc
drop table testabc;
-- 6. does betty currently have access to testabc?
select * from books1.testabc;
-- 7. books create table testabc
create table testabc(one integer);
insert into testabc values(5000);
commit;
-- 8. does betty currently have access to testabc?
select * from books1.testabc;

-- as system create users 
-- MARK > PETE > ZEKE
-- system privileges
-- grant with admin option
-- and determine how revoke interacts
create user mark identified by mark;
grant create session to mark;

create user pete identified by pete;
grant create session to pete;

create user zeke identified by zeke;
grant create session to zeke;

-- as system
grant create table to mark with admin option;
grant unlimited tablespace to mark with admin option;
-- as mark lets prove that
create table abc (one integer);
insert into abc values (553322);
commit;
-- as mark
grant create table to pete with admin option;
grant unlimited tablespace to pete with admin option;
-- as pete
create table peteabc (one integer);
insert into peteabc values (999999);
commit;

grant create table to zeke;
grant unlimited tablespace to zeke;
-- as zeke
create table zekeabc (one integer);
insert into zekeabc values (999999);
commit;

-- as system revoke marks priv create table
revoke create table from mark;
-- as mark
create table abcdef(one integer);
-- as pete
create table two (two integer);
grant create table to mark with admin option;

-- as system
revoke create table from mark;
-- as mark
grant create table to mark;

-- MARK > PETE > ZEKE
-- object privileges
-- grant with grant option
-- and determine how revoke interacts
-- as system
grant select on books1.books to mark with grant option;
-- as mark
select * from bks;
grant select on books1.books to pete with grant option;
-- as pete 
select * from bks;
grant select on books1.books to zeke;
-- as zeke
select * from bks;
-- as pete can we revoke marks select privs
revoke select on books1.books from mark;
-- as system
revoke select on books1.books from mark;
-- as mark this fails
select * from bks;
-- as pete
select * from bks;
-- as zeke
select * from bks;

-- repeat this waterfall test using a role
-- as system
drop role apple;
create role apple;
grant select on books1.author to apple;

grant apple to mark with admin option;
create sequence myseq;
select * from books1.author;

-- as mark
-- grant apple to pete with admin option;
select * from books1.author;
-- as pete 
grant apple to zeke with admin option;


-- as zeke
create sequence myseq;
select * from dba_tab_privs;


-- as system
-- revoke role apple from mark;

-- page 693
select *
-- distinct grantee
from dba_role_privs
where grantee in ('BOOKS1','BETTY','ACE','MARK','PETE','ZEKE');

select * 
from dba_tab_privs
where grantee in ('BOOKS1','BETTY','ACE','MARK','PETE','ZEKE');

select *
from dba_roles order by 1;



