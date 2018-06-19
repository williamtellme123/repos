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
            select                  to read
            update                  to write
            delete                  to write
            insert                  to write
            references              to create a foreign key
      
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
-- 1. As Billy List current privileges 
-- -----------------------------------------------------------------------------
-- a. System privileges granted to billy
select * from user_sys_privs; 
-- b. Granted privileges on objects for which the user is the owner, grantor, or grantee
select * from user_tab_privs;
-- c. Roles granted to to billy
select * from user_role_privs;
-- d. System privileges granted to billy
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
-- Login as BillyBooks
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
-- 3. Test Create Table
-- -----------------------------------------------------------------------------
-- a. Create User Andy
--    And grant privileges
drop user andy cascade;
create user andy identified by andy;
grant create session to andy;
grant unlimited tablespace to andy;
grant create table to andy;
-- =============================================================================
-- 4. As Andy
-- -----------------------------------------------------------------------------
-- a. Test andy in sqlPlpus
create table andy_test
(at_id    integer,
 name     varchar2(100),
 dob      date);
-- -----------------------------
-- a. Test Insert
insert into andy_test values(2,'Firefly','01-JAN-15');  
-- Need Grant? No
-- -----------------------------
-- b. Test update
select * from andy_test;

-- Need Grant? No
-- -----------------------------
-- c. Test delete
delete andy_test where at_id = 2;
-- Need Grant? no
-- -----------------------------
-- d. Test alter table add pk
alter table andy_test add primary key(at_id);
-- Need Grant? no
-- -----------------------------
-- e. Test alter table add index
create index ix_andy on andy_test(name);
-- Need Grant? No
-- -----------------------------
-- f. Test add synonym
create synonym andy_syn for andy_test;
-- Need Grant? Yes
-- -----------------------------
-- g. Test add public synonym
create public synonym andy_syn1 for andy_test;
-- Need Grant? Yes
-- ---------------------------------------
-- h. As system Grant create synonym to Andy
grant create synonym to andy;
grant create public synonym to andy;
-- =============================================================================
-- 5. Privileges between users 
-- -----------------------------------------------------------------------------
-- a. As Andy Create parent table 
drop table my_cust;
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
insert into my_cust values (2,'Ziggy','07-SEP-52','FL', 78729);
insert into my_cust values (3,'Ringo','11-NOV-49','LD', null);
insert into my_cust values (4,'GaGa','01-JAN-91','NY', 01344);
commit;
-- ---------------------------------------
-- c. As Andy Create child table 
drop table my_ords;
create table my_ords
( order#        integer primary key,
  cust_id       integer references my_cust(cust_id),
  dt_order      date,
  dt_shipped    date
 );
-- ---------------------------------------
-- d. As Andy Insert
insert into my_ords values (55,3,'15-MAR-15','29-MAR-15');
insert into my_ords values (56,2,'19-MAR-15','01-APR-15');
insert into my_ords values (57,4,'19-MAR-15','01-APR-15');
insert into my_ords values (58,4,'19-MAR-15','01-APR-15');
commit;


-- ---------------------------------------
-- e. As Andy Alter table my_ords add FK to my_cust See create table
--alter table my_ords add foreign key (cust_id) references my_cust(cust_id);

-- Need Grant? NO
-- ---------------------------------------
-- e. As Andy Create view without pin
create view vw_cust as 
select cust_id,c_name,dob,state from my_cust;
-- Need Grant? Yes
grant create view to andy;
-- ---------------------------------------
-- f. As Andy create public synonym vw_my_cust for vw_cust
create public synonym vw_my_cust for vw_cust;
-- Need Grant? ALready have it
-- ---------------------------------------
-- g. As Andy create (private) synonym vw_my_ords for vw_ords
create synonym vw_my_ords for vw_ords;
-- Need Grant? Yes but done above
-- ---------------------------------------
-- g. As Betty confirm privilege
-- As system 
drop user betty;
create user betty identified by betty;
grant create session to betty; 
-- Need Grant?
select * from vw_my_cust;
grant select on vw_my_cust to betty;
-- ---------------------------------------


-- =============================================================================
-- 6. Cascading system privileges
-- -----------------------------------------------------------------------------
-- a. Drop all users
drop user andy cascade;
drop user betty;
drop user carla;
drop user david;
-- ---------------------------------------
-- b. create all users
create user andy identified by andy;
create user betty identified by betty;
create user carla identified by carla;
create user david identified by david;
-- ---------------------------------------
-- c. grant all users basic privileges
--    create session
--    grant unlimited tablespace
--    create table
grant unlimited tablespace to andy,betty,carla,david;
grant create session to andy,betty,carla,david;
grant create table to andy,betty,carla,david;

-- ---------------------------------------
-- d. Grant Andy system privilege
grant create sequence to andy with admin option;


-- ---------------------------------------
-- e. As Andy test
create sequence seq_test start with 1;


-- ---------------------------------------
-- f. As Andy grant to betty with admin option
grant create sequence to betty with admin option;

-- ---------------------------------------
-- g. As Betty test
create sequence seq_test start with 1;



-- ---------------------------------------
-- h. As Betty grant to carla with admin option
grant create sequence to carla with admin option;


-- ---------------------------------------
-- i. As Carla test
create sequence seq_test start with 1;



-- ---------------------------------------
-- j. As carla grant to david with admin option
-- skipped


-- ---------------------------------------
-- k. As david test
-- deleted

-- ---------------------------------------
-- l. As system Revoke Betty's privilege
revoke create sequence from betty;



-- ---------------------------------------
-- m. As Carla test
create sequence seq_test2 start with 1;



-- -----------------------------------------------------------------------------------
-- n. As david test


-- ---------------------------------------
-- o. As system Drop Betty
drop user betty cascade;



-- ---------------------------------------
-- p. As Carla test
create sequence seq_test3 start with 1;



-- -----------------------------------------------------------------------------------
-- q. As david test




-- =============================================================================
-- 7. Cascading object privileges
-- -----------------------------------------------------------------------------
-- a. Drop all users
drop user andy cascade;;
drop user betty cascade;
drop user carla cascade;
drop user david cascade;
-- ---------------------------------------
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
-- d. As system Grant select to andy with grant option
grant select on books.books to andy with grant option;


-- ---------------------------------------
-- e. As Andy test
select * from books.books;


-- ---------------------------------------
-- f. As Andy grant to betty with grant option
grant select on books.books to betty with grant option;


-- ---------------------------------------
-- g. As Betty test
select * from books.books;



-- ---------------------------------------
-- h. As Betty grant to carla with admin option
grant select on books.books to carla with grant option;


-- ---------------------------------------
-- i. As Carla test
select * from books.books;



-- ---------------------------------------
-- j. As carla grant to david with admin option



-- ---------------------------------------
-- k. As david test
select * from books.books;


-- ---------------------------------------
-- l. As system Revoke Betty's privilege


-- ---------------------------------------
-- m. As Carla test
select * from books.books;

-- -----------------------------------------------------------------------------------
-- n. As david test
select * from books.books;

-- ---------------------------------------
-- o. As system Drop Betty
drop user betty cascade;

-- ---------------------------------------
-- p. As Carla test
select * from books.books;


-- -----------------------------------------------------------------------------------
-- q. As david test
select * from books.books;


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




