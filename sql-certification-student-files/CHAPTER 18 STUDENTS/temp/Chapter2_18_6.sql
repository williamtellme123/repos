REM KAPLAN HIERARCHICAL PRODUCTS TABLE EXAMPLE ---------------------------------

REM TABLE CREATION & ROW INSERTIONS

DROP TABLE PRODUCTS2;

CREATE TABLE PRODUCTS2
    ( PRODUCTID       VARCHAR2(4) PRIMARY KEY
    , PRODUCTTYPE     VARCHAR2(15)
    , PRODUCTCOST     NUMBER
    , PRODUCTBRANDID  VARCHAR2(4));

DELETE FROM PRODUCTS2;    

INSERT INTO PRODUCTS2 VALUES  ( 'P001', 'COSMETICS', 100, NULL);
INSERT INTO PRODUCTS2 VALUES  ( 'P002', 'COSMETICS', 100, 'P001');
INSERT INTO PRODUCTS2 VALUES  ( 'P003', 'GARMENT', 100, 'P002');
INSERT INTO PRODUCTS2 VALUES  ( 'P004', 'FOOTWEAR', 100, 'P002');
INSERT INTO PRODUCTS2 VALUES  ( 'P005', 'COSMETICS', 100, 'P003');

SELECT * FROM PRODUCTS2 ORDER BY PRODUCTID;

REM -------- THE TEST QUERY ---------

SELECT PRODUCTID, PRODUCTTYPE, PRODUCTCOST, PRODUCTBRANDID
     , SYS_CONNECT_BY_PATH(PRODUCTID,'>') PATH
FROM PRODUCTS2
START WITH PRODUCTID = 'P002'
CONNECT BY PRODUCTID = PRIOR PRODUCTBRANDID;

REM  THIS VERSION OF THE QUERY DOES NOT ANSWER THE QUESTION :
REM  HOW MANY ANCESTORS / SUPERIORS DOES ID = 'P005' HAVE?
REM  THE "CONNECT BY" CLAUSE POINTS IN THE WRONG DIRECTION.

REM  A MORE APPROPRIATE VERSION OF THE QUERY SHOULD BE AS FOLLOWS.

SELECT LEVEL, LPAD(' ', 2*(LEVEL-1)) || PRODUCTID "PRODUCT ID", PRODUCTTYPE, PRODUCTCOST, PRODUCTBRANDID
     , SYS_CONNECT_BY_PATH(PRODUCTID,'>') PATH
FROM PRODUCTS2
START WITH PRODUCTID = 'P002'
CONNECT BY PRODUCTBRANDID = PRIOR PRODUCTID
ORDER SIBLINGS BY PRODUCTID;

COMMIT;

REM  I BELIVE THAT A CLEARER QUESTION WOULD HAVE USED A COLUMN NAME LIKE 'POINTS_TO_PRODUCTID'
REM  AS IN "CONNECT BY POINTS_TO_PRODUCTID = PRIOR PRODUCTID"
REM  THEN IT WOULD BE OBVIOUS WHEN THE CONNECT BY CLAUSE IS POINTED IN THE WRONG DIRECTION.





drop table products2;
create table products2
( productid       varchar2(4) primary key
, producttype     varchar2(15)
, productcost     number
, productbrandid  varchar2(4));
delete from products2;    
begin
  insert into products2 values  ( 'P001', 'COSMETICS', 100,  null);
  insert into products2 values  ( 'P002', 'COSMETICS', 100, 'P001');
  insert into products2 values  ( 'P003', 'GARMENT',   100, 'P002');
  insert into products2 values  ( 'P004', 'FOOTWEAR',  100, 'P002');
  insert into products2 values  ( 'P005', 'COSMETICS', 100, 'P003');
  insert into products2 values  ( 'P006', 'COSMETICS', 100, 'P003');
  insert into products2 values  ( 'P007', 'COSMETICS', 100, 'P003');
  insert into products2 values  ( 'P008', 'COSMETICS', 100, 'P004');
  insert into products2 values  ( 'P009', 'COSMETICS', 100, 'P004');
  commit;
end;
/


-- hierarchical
select productid
      , producttype
      , productcost
      , productbrandid
      , sys_connect_by_path(productid,'>') path
from products2
-- where productid != 'P004'
start with productid = 'P002'
connect by   productbrandid = prior productid
  and productid != 'P004';
  
  
  
  
select room_style, room_type, sum(sq_ft)
from ship_cabins
where ship_id = 1
group by grouping sets (room_style, (room_type, window));

select room_style movie_id, room_type location, window month, sum(sq_ft)
from ship_cabins
where ship_id = 1
  and ship_cabin_id between 4 and 7
group by room_style,room_type, rollup(window);






select room_style, room_type, window, sum(sq_ft)
from ship_cabins
where ship_id = 1
group by room_style, room_type, window;





-- hierarchical
select productid
      , producttype
      , productcost
      , productbrandid
      , sys_connect_by_path(productid,'>') path
from products2
 -- where productid != 'P004'
start with productid = 'P002'
connect by productid  =  prior productbrandid
  and productid != 'P004';






select regexp_replace('Heardir   Anthony','Sir .','|') from dual;
select regexp_instr('Maeny','a?') from dual;
select regexp_instr('2009-October-09','\A\d{4}?-\w{3,9}?-\d{2}?') a from dual;
select regexp_instr('-','\A\d?{4}-') a from dual;

select regexp_instr('Dad','^(D|d)[[:alpha:]]{3,}d$') a from dual;

select regexp_substr('12345X','^\d{5}(X|Y|Z)$',1) a from dual;

select regexp_substr('12345XYX','^\d{5}[XYTYZ]+$',1) a from dual;
-- =============================================================================
-- Chapter 2
-- =============================================================================
-- Page 50 (2/1)
CREATE TABLE work_schedule
  (
    work_schedule_id NUMBER,
    start_date DATE,
    end_date DATE,
    CONSTRAINT work_schedule_pk PRIMARY KEY(work_schedule_id)
  );
DROP TABLE work_schedule;
DESC work_schedule;
-- Page 59 (2/5)
/* =============================================================================
1. Copy from page 59
2. Rename to cruises2
3. Create table
4. Check with desc
5. Check in SQL Developer for contraints
6. Drop table
7. Add named constraint
8. Create table
9. Look in IDE see named constraint
10 Drop table cruises2
-- ---------------------------------------------------------------------------
*/
CREATE TABLE cruises2
  (
    cruise_id      NUMBER ,
    cruise_type_id NUMBER,
    cruise_name    VARCHAR2(20),
    captain_id     NUMBER,
    start_date DATE,
    end_date DATE,
    status VARCHAR2(5) ,
    CONSTRAINT cruises2_cruiseID_pk (cruise_id)
  );
SELECT * FROM user_constraints WHERE table_name = 'CRUISES2';
DESC cruises2;
DROP TABLE cruises2;
-- Page 62 (2/6)
/* =============================================================================
1. Copy cruises 2 from above
2. Rename to cruises3
3. Delete all except
cruise_id number(4,2)
cruise_name varchar2(5)
4. Create table
5. insert into cruises3 values (3333, 'alpha');
select * from cruises3;
6. insert into cruises3 values (33, 'alpha');
select * from cruises3;
7. Insert into cruises3 values (33.56, 'alpha');
select * from cruises3;
8. insert into cruises3 values (33.566, 'alpha');
select * from cruises3;
9. insert into cruises3 values (33.566, 'alpha1');
select * from cruises3;
-- ---------------------------------------------------------------------------
*/
CREATE TABLE cruises3
  (
    cruise_id   NUMBER (4,2),
    cruise_name VARCHAR2(5)
  );
DROP TABLE cruises3;
INSERT INTO cruises3 VALUES
  (3333, 'alpha'
  );
SELECT * FROM cruises3;
INSERT INTO cruises3 VALUES
  (33, 'alpha'
  );
SELECT * FROM cruises3;
INSERT INTO cruises3 VALUES
  (33.56, 'alpha'
  );
SELECT * FROM cruises3;
INSERT INTO cruises3 VALUES
  (33.566, 'alpha'
  );
SELECT * FROM cruises3;
INSERT INTO cruises3 VALUES
  (33.566, 'alpha1'
  );
SELECT * FROM cruises3;
SELECT * FROM cruises3;
DROP TABLE cruises3;
-- Page 63 (2/7)
/* =============================================================================
SELECT sys_context('USERENV', 'NLS_DATE_FORMAT') FROM DUAL;
-- ----------------------------------------------------------------------------
*/
-- Page 64 (2/7)
/* =============================================================================
1. Copy cruises 3 from above
2. Rename to cruises4
3. Delete all except
CREATE TABLE cruises4
( date1       date,
date2       timestamp,
date3       timestamp with time zone,
date4       timestamp with local time zone
);
4. insert into cruises4 values (sysdate,sysdate,sysdate,sysdate);
5. select * from cruises4;
6. Drop table cruises4;
-- ----------------------------------------------------------------------------
*/
CREATE TABLE cruises4
  (
    date1 DATE,
    date2 TIMESTAMP,
    date3 TIMESTAMP
WITH TIME zone, date4 TIMESTAMP
WITH local TIME zone
  );
DROP TABLE cruises4;
INSERT INTO cruises4 VALUES
  (sysdate,sysdate,sysdate,sysdate
  );
SELECT * FROM cruises4;
-- Page 67 (2/9)
/* =============================================================================
1. Copy cruises 3 from above
CREATE TABLE cruises3
( cruise_id       NUMBER (4,2),
cruise_name     VARCHAR2(5)
);
2. drop table cruises3
3. create anonymous primary key in line
CREATE TABLE cruises3
( cruise_id       integer primary key,
cruise_name     VARCHAR2(5)
);
4. drop table cruises3;
5. create named primary key in line
CREATE TABLE cruises3
( cruise_id       integer constraint cruises3_pk primary key,
cruise_name     VARCHAR2(5)
);
6. drop table cruises3;
7. create primary key out of line
CREATE TABLE cruises3
( cruise_id       integer ,
cruise_name     VARCHAR2(5),
constraint cruises3_pk primary key (cruise_id)
);
8. drop table cruises3;
*/
CREATE TABLE cruises3
  (
    cruise_id   INTEGER CONSTRAINT cruises3_pk PRIMARY KEY,
    cruise_name VARCHAR2(5)
  );
DROP TABLE cruises3;
CREATE TABLE cruises3
  (
    cruise_id   INTEGER ,
    cruise_name VARCHAR2(5),
    CONSTRAINT cruises3_pk PRIMARY KEY (cruise_id)
  );
-- Page 69 (2/9)
/* =============================================================================
1. Copy cruises 3 from above
CREATE TABLE cruises3
( cruise_id       NUMBER (4,2),
cruise_name     VARCHAR2(5)
);
2. drop table cruises3;
3. create table
4. alter table cruises3 modify cruise_id primary key;
check constraint in sql developer
5. drop table cruises3;
6. create table
7. alter table cruises3 modify cruise_id constraint cruises_cruiseid_pk primary key;
check constraint in sql developer
8. drop table cruises3;
9. create table
10. alter table cruises3 add constraint cruises3_cruiseid_pk primary key (cruise_id);
check constraint in sql developer
11. drop table cruises3;
*/
alter table cruises3 modify cruise_id constraint cruises_cruiseid_pk primary key;

CREATE TABLE cruises3
  ( cruise_id NUMBER (4,2), cruise_name VARCHAR2(5)
  );
DROP TABLE cruises3;
-- =============================================================================
-- HANDS ON ASSIGNMENTS CHAPTER 2
/* -----------------------------------------------------------------------------
1. create table supplier
a.) supplier_id is the primary key can hold 10 digits
b.) supplier_name can hold 50 letters and cannot be null
c.) contact_name can hold 50 letters and can be null
NOTE: all constraints must be named by programmer
*/
CREATE TABLE supplier
  (
    supplier_id   NUMERIC(10),
    supplier_name VARCHAR2(50) CONSTRAINT supplier_name_nn NOT NULL,
    contact_name  VARCHAR2(50),
    CONSTRAINT supplier_supplier_id_pk PRIMARY KEY (supplier_id)
  );
DROP TABLE supplier;
/* -----------------------------------------------------------------------------
2. create table products
a.) product_id is the primary key can hold 10 digits
b.) supplier_id is FK to supplier
c.) supplier_name can hold 50 letters and cannot be null
NOTE: all constraints must be named by programmer
*/
CREATE TABLE products
  (
    product_id    NUMERIC(10) PRIMARY KEY,
    supplier_id   NUMERIC(10) NOT NULL,
    supplier_name VARCHAR2(50) NOT NULL,
    CONSTRAINT products_supplier_fk FOREIGN KEY (supplier_id) REFERENCES supplier(supplier_id)
  );
CREATE TABLE products
  (
    product_id    NUMERIC(10) PRIMARY KEY,
    supplier_id   NUMERIC(10) REFERENCES supplier (supplier_id),
    supplier_name VARCHAR2(50) NOT NULL
  );
CREATE TABLE products
  (
    product_id    NUMERIC(10) PRIMARY KEY,
    supplier_id   NUMERIC(10) CONSTRAINT abc_fk REFERENCES supplier (supplier_id),
    supplier_name VARCHAR2(50) NOT NULL
  );
DROP TABLE products;
/* -----------------------------------------------------------------------------
3. create table supplier2
a.) same fields as supplier
b.) supplier_id/supplier_name is composite primary key
NOTE: all constraints must be named by programmer
*/
CREATE TABLE supplier
  (
    supplier_id supplier_name contact_name
  );
DROP TABLE supplier;
CREATE TABLE supplier
  (
    supplier_id   NUMERIC(10),
    supplier_name VARCHAR2(50),
    contact_name  varchar2(50),
    CONSTRAINT supplier_pk PRIMARY KEY (supplier_id)
  );
drop table supplier cascade constraints;
alter table supplier drop constraint supplier_pk; 
select * from user_constraints where upper(constraint_name) like '%SUPP%';

select * from user_cons

/* -----------------------------------------------------------------------------
4. create table products2
a.) same fields as products
b.) foreign key matches composite primary key in supplier2
NOTE: all constraints must be named by programmer

a.) product_id
IS
  the primary key can hold 10 digits 
b.) supplier_id
IS
  fk to supplier 
c.) supplier_name can hold 50 letters AND cannot be NULL NOTE: ALL CONSTRAINTS must be NAMED BY programmer
*/

CREATE TABLE products3
  (
    product_id    NUMERIC(10) CONSTRAINT pid_pk PRIMARY KEY,
    supplier_id   NUMERIC(10) NOT NULL,
    supplier_name VARCHAR2(50) NOT NULL,
    CONSTRAINT prod_supp_suppid_supprname_fk FOREIGN KEY (supplier_id, supplier_name) REFERENCES supplier2(supplier_id, supplier_name)
  );
DROP TABLE products2;
/* -----------------------------------------------------------------------------
5. create table products3
a.) same fields as products
b.) no foreign key in create table
c.) use alter statement add: products_supplier_supplierid_fk
NOTE: use first supplier table with single field PK
*/
-- "add" foreign key after tables are created
ALTER TABLE products3 ADD CONSTRAINT prod_supp_supp_fk FOREIGN KEY (supplier_id) REFERENCES supplier(supplier_id);



/* -----------------------------------------------------------------------------
6. create table products4
a.) same fields as products
b.) no foreign key in create table
c.) use alter statement add composite FK: prod_supp_suppid_suppname_fk
NOTE: use first supplier2 table with composite PK
*/
CREATE TABLE products4
  (
    product_id    NUMERIC(10),
    supplier_id   NUMERIC(10),
    supplier_name VARCHAR2(50)
  );
ALTER TABLE products4 ADD CONSTRAINT prod_supp_suppId_suppname_fk FOREIGN KEY
(
  supplier_id, supplier_name
)
REFERENCES supplier2
(
  supplier_id, supplier_name
)
;
/* -----------------------------------------------------------------------------
7. You work for a company that has people who work out
of multiple locations. Create three small tables:
People: a table about people
Locations: a table about locations
Assignments: a table about people at locations
*/
/*
8. create table people
-- ---------------------------------------------------
1.) pid is PK
2.) startdate is the startdate with default sysdate
3.) fname can hold 15 letters and cannot be null
4.) lname can hold 25 letters and cannot be null
5.) email can hold 25 letters must be unique
NOTE: all constraints must be named by programmer
*/
CREATE TABLE people
  (
    pid INTEGER CONSTRAINT people_pid_pk PRIMARY KEY,
    start_date DATE DEFAULT sysdate,
    fname VARCHAR2(15) CONSTRAINT people_fname_nn NOT NULL,
    lname VARCHAR2(15) CONSTRAINT people_lname_nn NOT NULL,
    email VARCHAR2(45) CONSTRAINT people_email_uk UNIQUE
  );
DROP TABLE people;
purge recyclebin;
/*
9. create table assignments
-- ---------------------------------------------------
1.) pid (see #3 below)
2.) lid must have values (see below)
3.) create pk as (pid, lid)
4.) create fk to people
5.) create fk to locations
*/
CREATE TABLE assignments
  (
    pid INTEGER,
    lid INTEGER CHECK (lid IN (1,2,3,4,5)),
    CONSTRAINT assignments_pk PRIMARY KEY (pid, lid),
    CONSTRAINT assignments_people_pid_fk FOREIGN KEY (pid) REFERENCES people (pid),
    CONSTRAINT assignments_locations_lid_fk FOREIGN KEY (lid) REFERENCES locations (lid)
  );
DROP TABLE assignments;
/*
10. create table locations
-- ---------------------------------------------------
1.) lid is the primary key
2.) store name can hold 30 letters and cannot be null
4.) city can hold 30 letters and cannot be null
5.) state can hold 2 letters and cannot be null
*/
-- create a table for locations
CREATE TABLE locations
  (
    lid   INTEGER CONSTRAINT locations_lid_pk PRIMARY KEY,
    name  VARCHAR2(30) CONSTRAINT locations_name_nn NOT NULL,
    city  VARCHAR2(30) CONSTRAINT locations_city_nn NOT NULL,
    state VARCHAR2(2) CONSTRAINT locations_state_nn NOT NULL
  );
DROP TABLE locations;
/*
11. drop these three tables people, assignments, locations
*/
-- =============================================================================
-- Chapter 3
-- =============================================================================
/*
-- Page 99 (3/1)
1. Copy from page 99
2. Format for readability
3. Insert (is there a problem?)
SOLUTION
4. Select from cruises
5. Select from employees
6. Check constraints
7. Change insert statement to work
*/
INSERT INTO CRUISES ( CRUISE_ID, CRUISE_TYPE_ID, CRUISE_NAME , CAPTAIN_ID , START_DATE , END_DATE , STATUS )
  VALUES ( 1 , 1 , 'Day At Sea' , 101 , '02-JAN-10' , '09-JAN-10' , 'Sched' );

SELECT * FROM cruises;
SELECT * FROM employees;
/*
-- Page 101 (3/2)
1. Copy insert from above
2. Remove column names
3. Insert (same problem)
4. Select from cruises/check constraints
5. Add value (select from ships)
6. Insert
7. Change captain_id (select from employees)
6. Insert
*/
INSERT INTO CRUISES 
 VALUES ( 2 , 1 , 'Day At Sea' , 101 , '02-JAN-10' , '09-JAN-10' , 'Sched' );

SELECT * FROM cruises;
SELECT * FROM employees;
DESC cruises;
DESC ships;
SELECT * FROM ships;
/*
-- Page 105 (3/4)
1. Copy insert from above
2. Select Max from Cruises
3. Create sequence start Max+1
4. Insert statement from page 105 using nextval
6. Insert
*/
CREATE sequence cruise_cruise_id_seq start with 3;
  DROP sequence cruise_cruise_id_seq ;
  ;
  SELECT MAX(cruise_id) FROM cruises;
  INSERT
  INTO CRUISES VALUES
    (
      cruise_cruise_id_seq.nextval ,
      1 ,
      'Day At Sea' ,
      8 ,
      8 ,
      '02-JAN-10' ,
      '09-JAN-10' ,
      'Sched'
    );
  SELECT * FROM cruises;
  SELECT * FROM employees;
  5
  /*
  -- Page 106 (3/4)
  1. Copy code page 106
  2. Select Max from Cruises
  3. Create sequence start Max+1
  4. Insert statement from page 105
  5. Insert
  */
  UPDATE CRUISES
  SET CRUISE_NAME = 'Bahamas',
    START_DATE    = '01-DEC-11'
  WHERE CRUISE_ID = 1;
  UPDATE CRUISES
  SET CRUISE_NAME = 'Bahamas',
    START_DATE    = '02/DEC/02'
  WHERE CRUISE_ID = 1;
  /*
  -- Page 108 (3/5)
  1. Copy update code from above
  2. Modify to below
  3. Update
  4. Select to test
  */
  SELECT *
  FROM CRUISES;
  UPDATE cruises SET end_date = start_date + 5 WHERE cruise_id = 1;
  /*
  -- Page 108 (3/5)
  1. Copy code page 108
  2. Rename Projects2
  3. Modify insert statements Projects2
  4. Create table
  5. Insert into table
  6. update projects2
  set cost = cost * 1.20;
  7. Update
  */
  CREATE TABLE PROJECTS2
    (
      PROJECT_ID   NUMBER PRIMARY KEY ,
      PROJECT_NAME VARCHAR2(40) ,
      COST         NUMBER ,
      CONSTRAINT CK_COST CHECK (COST < 1000000)
    );
BEGIN 
  INSERT INTO PROJECTS2  ( PROJECT_ID, PROJECT_NAME,COST )   VALUES ( 1, 'Hull Cleaning ', 340000 );
  INSERT INTO PROJECTS2  ( PROJECT_ID, PROJECT_NAME,COST )   VALUES ( 2, 'Deck Resurfacing ', 964000 );
  INSERT INTO PROJECTS2  ( PROJECT_ID, PROJECT_NAME,COST )   VALUES ( 3, 'Lifeboat Inspection  ', 12000 );
END;
/
UPDATE projects2 SET cost = cost * 1.03;
/*
-- Page 110 (3/5)
1. Copy update from above
2. Modify with where clause
3. Update
4. Select
*/
UPDATE projects2
SET cost = cost * 1.2
WHERE cost * 1.2 < 1000000;
/*
-- Page 117 (3/7)
1. Commit
2. Select * from projects2;
3. Delete from projects2
4. Select
5. Rollback
6. Select
7. Delete projects2
8. Select
9. Rollback
10. Select
*/
COMMIT;
SELECT * FROM projects2;
DELETE projects2;
ROLLBACK;
SET cost = cost * 1.2 WHERE cost * 1.2 < 1000000;
/*
-- Page 120 (3/7)
1. Copy 199-120
2. Commit
3. Select
4. 1st update
5. Ship_id = 3
6. Home Port 12
7. Home Port 11
8. Home Port 10
9. Rollback to Mark_02
10. Select
11. Update back to null to reset DB
12. Select
13. Commit
*/
COMMIT;
SELECT * FROM ships WHERE ship_id = 3;
UPDATE SHIPS SET HOME_PORT_ID = 12 WHERE SHIP_ID = 3;
SAVEPOINT MARK_01;
UPDATE SHIPS SET HOME_PORT_ID = 11 WHERE SHIP_ID = 3;
SAVEPOINT MARK_02;
UPDATE SHIPS SET HOME_PORT_ID = 10 WHERE SHIP_ID = 3;
ROLLBACK TO MARK_02;
COMMIT;
UPDATE SHIPS SET HOME_PORT_ID = NULL WHERE SHIP_ID = 3;
SELECT * FROM ships WHERE ship_id = 3;
COMMIT;
-- =============================================================================
-- HANDS ON ASSIGNMENTS CHAPTER 3
/* -----------------------------------------------------------------------------
1. copy DDL stements above for tables: people, assignments, locations
*/
/*
2. create table people
-- ---------------------------------------------------
1.) pid is PK
2.) startdate is the startdate with default sysdate
3.) fname can hold 15 letters and cannot be null
4.) lname can hold 25 letters and cannot be null
5.) email can hold 25 letters must be unique
NOTE: all constraints must be named by programmer
*/
CREATE TABLE people
  (
    pid INTEGER CONSTRAINT people_pid_pk PRIMARY KEY,
    start_date DATE DEFAULT sysdate,
    fname VARCHAR2(15) CONSTRAINT people_fname_nn NOT NULL,
    lname VARCHAR2(15) CONSTRAINT people_lname_nn NOT NULL,
    email VARCHAR2(45) CONSTRAINT people_email_uk UNIQUE
  );
DROP TABLE people;
purge recyclebin;
/*
3. create table assignments
-- ---------------------------------------------------
1.) pid
2.) lid
3.) create pk as (pid, lid)
4.) create fk to people
5.) create fk to locations
*/
CREATE TABLE assignments
  (
    pid INTEGER,
    lid INTEGER,
    CONSTRAINT assignments_pk PRIMARY KEY (pid, lid),
    CONSTRAINT assignments_people_pid_fk FOREIGN KEY (pid) REFERENCES people (pid),
    CONSTRAINT assignments_locations_lid_fk FOREIGN KEY (lid) REFERENCES locations (lid)
  );
DROP TABLE assignments;
/*
4. create table locations
-- ---------------------------------------------------
1.) lid is the primary key
2.) name can hold 30 letters and cannot be null
4.) city can hold 30 letters and cannot be null
5.) state can hold 2 letters and cannot be null
*/
-- create a table for locations
CREATE TABLE locations
  (
    lid   INTEGER CONSTRAINT locations_lid_pk PRIMARY KEY,
    name  VARCHAR2(30) CONSTRAINT locations_name_nn NOT NULL,
    city  VARCHAR2(30) CONSTRAINT locations_city_nn NOT NULL,
    state VARCHAR2(2) CONSTRAINT locations_state_nn NOT NULL
  );
DROP TABLE locations;
/*
5. Create a sequence for people and locations
-- ---------------------------------------------------
*/
CREATE sequence people_pid_seq start with 1000;
  DROP sequence people_pid_seq;
CREATE sequence locations_lid_seq start with 1;
  DROP sequence locations_lid_seq;
  /*
  6. Insert three rows into people (using sequence)
  7. Insert six rows into assignments (each person works two locations)
  8. Insert three rows into locations (using sequence)
  -- ---------------------------------------------------
  */
  INSERT INTO people (pid, start_date, fname, lname, email ) VALUES (people_pid_seq.nextval,sysdate,'Marshal','Rango','rango@hotmail.com');
  INSERT INTO people (pid, start_date, fname, lname, email ) VALUES (people_pid_seq.nextval,sysdate,'Peneolpe','Pitstop','ppitstop@gmail.com');
  INSERT INTO people (pid, start_date, fname, lname, email ) VALUES (people_pid_seq.nextval,sysdate,'Ranger','Andy','randy@juno.com');
    
  SELECT * FROM people;
  INSERT INTO locations (lid,name,city,state ) VALUES (locations_lid_seq.nextval,'Bar 4 Ranch','Lubbock','TX');
  INSERT INTO locations (lid,name,city,state ) VALUES (locations_lid_seq.nextval,'BarBQue','Austin','TX');
  INSERT INTO locations (lid,name,city,state ) VALUES (locations_lid_seq.nextval,'SpaceOut','Houston','TX');

  INSERT INTO assignments(pid,lid) VALUES(1000,1);
  INSERT INTO assignments(pid,lid) VALUES(1000,3);
  INSERT INTO assignments(pid,lid) VALUES(1001,2);
  INSERT INTO assignments(pid,lid) VALUES(1001,3);
  INSERT INTO assignments(pid,lid) VALUES(1002,1);
  INSERT INTO assignments(pid,lid) VALUES(1002,3);
  SELECT * FROM assignments;
  /*
  9. Delete from people where pid = 1000;
  10. Delete from locations where lid = 1
  -- ---------------------------------------------------
  */
  DELETE FROM people WHERE pid = 1000;
  DELETE FROM assignments WHERE pid = 1000;
  DELETE FROM locations WHERE lid = 2;
  DELETE FROM assignments WHERE lid = 2;
  
  /*
  11. Select to check
  12. Drop tables
  13. Drop sequences
  */
  -- =============================================================================
  -- Chapter 4
  -- =============================================================================
  -- Page 139 (4/1)
  /* =============================================================================
  1. Copy from page 139
  2. Run the command in SQL Developer
  3. Copy and paste into SLQ Plus
  */
  SELECT SHIP_ID,
    SHIP_NAME,
    CAPACITY
  FROM SHIPS
  ORDER BY SHIP_NAME;
  -- Page 141 (4/2)
  /* =============================================================================
  1. Copy from page 141
  2. Run the command in SQL Developer
  */
  SELECT 1,
    '--------'
  FROM SHIPS;
  -- =============================================================================
  -- HANDS ON ASSIGNMENTS CHAPTER 4
  /* -----------------------------------------------------------------------------
  1. Open connection into Books
  2. Count rows in customers
  3. Count rows in orders
  4. Join customers and orders three ways
   a.) "using (customer#)"
   b.) "on o.customer# = o.customer#"
   c.) "where o.customer# = o.customer#"
  5. How many customers are there
  6. How many orders are there
  7. How many joined rows
  8. How many customers with orders
  9. How many customers without orders
  */
  
  SELECT lastname,firstname,order#
  FROM customers JOIN orders USING (customer#)
  ORDER BY 3, 2, 1;
  /*
  SELECT lastname, firstname, order# 
  FROM customers  LEFT JOIN orders USING (customer#)
  ORDER BY 3, 2, 1;
  */
  SELECT lastname, firstname, order#
  FROM customers c
  JOIN orders o
  ON c.customer# = o.customer#
  ORDER BY 3,2, 1;
  /*
  SELECT lastname,firstname, order#
  FROM customers c 
  LEFT JOIN orders o
  ON c.customer# = o.customer#
  ORDER BY 3, 2,1;
  
  SELECT lastname, firstname, order#
  FROM customers c ,
    orders o
  WHERE c.customer# = o.customer#(+)
  ORDER BY 3,  2,  1;
   */
   
  -- total number of joined rows
  SELECT lastname,   firstname,   order#
  FROM customers c  LEFT OUTER JOIN orders o
  ON c.customer# = o.customer#
  ORDER BY 3, 2, 1;
    
   SELECT lastname,firstname,    order#
  FROM customers c , orders o
  WHERE c.customer# = o.customer#;
  
  SELECT lastname,firstname,order#
  FROM customers c , orders o
  WHERE c.customer# = o.customer#;
  
  -- customers without orders
  SELECT c.customer#, lastname, firstname
  FROM customers c
  WHERE NOT EXISTS
    (SELECT customer# FROM orders o WHERE c.customer# = o.customer# );
    
  -- 10
  SELECT c.customer#,
    lastname,
    firstname
  FROM customers c
  WHERE c.customer# NOT IN
    (SELECT customer# FROM orders o WHERE c.customer# = o.customer# );
  
  -- 14
  SELECT c.customer#,lastname, firstname
  FROM customers c
  WHERE c.customer# IN
    (SELECT DISTINCT customer# FROM orders o WHERE c.customer# = o.customer#
    );
  -- 24
  SELECT DISTINCT c.customer#, lastname, firstname FROM customers c;
  SELECT COUNT(DISTINCT c.customer#) FROM customers c;
  -- 22
  SELECT COUNT(*) FROM orders;

-- =============================================================================
-- Chapter 5
-- =============================================================================
select room_number, room_style, window 
from ship_cabins
where not room_style like 'Suite';
--  and window = 'Ocean';

select port_name from ports
where country in ('UK','USA','Bahamas');

select port_name 
from ports 
where capacity = null;

/*
    1.
    Return port_id, port_name, capacity 
    for ports that start with either "San" or "Grande"
    and have a capacity of 4.
*/
    select port_id, port_name, capacity
    from ports
    where (port_name like 'San%'
      or port_name like 'Grande%')
      and capacity = 4;

/*
    2.
    Return vendor_id, name, and category  
    where the category is "supplier", "subcontractor" or ends with Partner.
*/
    select vendor_id, vendor_name, category
    from vendors where category in
    ('Supplier','Subcontractor')
    or category like '%Partner';

/*
    3.
    Return room_number and style from ship_cabins   
    where there is no window or the balcony_sq_ft = null;
*/
      select room_number, room_style
      from ship_cabins
      where window = 'None' or balcony_sq_ft is null;

/*
    4.
    Return ship_id, name, capacity, length   
    from ships where 2052 <= capacity <= 3000
    and the length is either 100 or 855
    and the ship begins with "Codd"
    
*/
     select ship_id, ship_name, capacity, length
      from ships
      where capacity between 2052 and 3000
      and length in (100,855)
      and ship_name like 'Codd_%';


      alter table ships add lifeboats integer;
      
      begin
      update ships set lifeboats = 82 where ship_name = 'Codd Crystal';
      update ships set lifeboats = 95 where ship_name = 'Codd Elegance';
      update ships set lifeboats = 75 where ship_name = 'Codd Champion';
      update ships set lifeboats = 115 where ship_name = 'Codd Victorious';
      update ships set lifeboats = 76 where ship_name = 'Codd Grandeur';
      update ships set lifeboats = 88 where ship_name = 'Codd Prince';
      update ships set lifeboats = 80 where ship_name = 'Codd Harmony';
      update ships set lifeboats = 92 where ship_name = 'Codd Voyager';
      end;
      /
/*
    5.
    Return ship_id, name, lifeboats, capacity   
    from ships where the name is either "Codd Elegance","Codd Victorious"
    and 80 >= lifeboats >= 100
    and capacity / lifeboats > 25
*/

   select ship_id, ship_name, lifeboats, capacity
    from ships
    where ship_name in ('Codd Elegance','Codd Victorious')
    and (lifeboats <= 80 or lifeboats >=100)
    and capacity / lifeboats > 25;


-- =============================================================================
-- Chapter 6
-- =============================================================================
select * from dual; 

-- Type in 215
select employee_id from employees where upper(last_name) = 'SMITH';

-- Type in 216
select initcap('napoleon'), initcap('RED O''BRIEN'), initcap('McDonald''s') from dual;

-- Type in 218
select rpad (CHAPTER_TITLE || ' ',30,'.') || lpad(' ' || PAGE_NUMBER,30,'.') "Table of Contents"
from book_contents 
order by page_number;

-- Type in 219
select rtrim ('Seven thousand--------','-') from dual;

-- Type in 220
select instr ('Mississippi', 'is',1,2) from dual;


-- Type in 222
select soundex('William'), soundex('Rogers') from dual;

-- Type in 223
select round(12.355143, 2), round(259.99,-1) from dual;

-- Type in 224 top
select trunc(12.355143, 2), trunc(259.99,-1)from dual;

-- Type in 224 bottom 
select remainder(9,3), remainder(10,3), remainder(11,3) from dual;

-- Type in 227
select sysdate today,
trunc(sysdate,'mm') truncated_month,
trunc(sysdate,'rr') truncated_year
from dual;

-- Type in 228
select add_months('31-JAN-11',1), add_months('01-NOV-11',4) from dual;

-- Type in 229
select months_between ('12-JUN-14','03-OCT-13') from dual;

-- Type in 230
SELECT NUMTODSINTERVAL(36,'HOUR') FROM DUAL;

-- Type in 231
SELECT NVL(NULL,0) FIRST_ANSWER,
14+NULL-4 SECOND_ANSWER,
14+NVL(NULL,0)-4 THIRD_ANSWER
FROM DUAL;

-- Type in 233 top
SELECT SHIP_NAME,CAPACITY,
CASE CAPACITY 
    WHEN 2052 THEN 'MEDIUM' 
    WHEN 2974 THEN'LARGE' 
    END AS "SIZE"
FROM SHIPS
WHERE SHIP_ID <= 4;

-- Type in 233 bottom
SELECT TEST_SCORE,UPDATED_TEST_SCORE, NULLIF(UPDATED_TEST_SCORE,TEST_SCORE) REVISION_ONLY
FROM SCORES;

-- Type in 237
select to_number('17.000,23','999G999D99','nls_numeric_characters='',.'' ') from dual;

-- Type in 241 middle 
SELECT TO_CHAR(SYSDATE,'FMDay, "the" Ddth "of" Month, RRRR') FROM DUAL;

-- Type in 241 bottom 
SELECT TO_CHAR(SYSDATE,'HH24:MI:SS AM') FROM DUAL;

-- Type in 245 middle 
SELECT TO_TIMESTAMP('2020-JAN-01 13:34:00:093423','RRRR-MON-DD HH24:MI:SS:FF') EVENT_TIME
FROM DUAL;

-- Type in 249 middle 
select dbtimezone, sessiontimezone, current_timestamp  from dual;

-- Type in 250 middle 
select owner, table_name, column_name, data_type
from dba_tab_columns
where data_type like '%TIME%'; 

-- Type in 252 middle 
select count(*) from (
SELECT TZABBREV, TZNAME
FROM V$TIMEZONE_NAMES
ORDER BY TZABBREV, TZNAME);


-- Type in 253 
SELECT DBTIMEZONE FROM DUAL;

-- Type in 254 
SELECT SESSIONTIMEZONE FROM DUAL;
select sysdate, current_date,current_timestamp from dual;

-- Type in 255
SELECT SYSTIMESTAMP FROM DUAL;


-- Type in 257
select from_tz(timestamp '2012-10-12 07:45:30', '+07:30') from dual;

-- Type in 258
select to_timestamp_tz('17-04-2013 16:45:30','dd-mm-rrrr hh24:mi:ss') "time" from dual;

-- Type in 260
select sys_extract_utc(current_timestamp) "hq" from dual;


select to_timestamp('2011-JUL-26 20:20:00', 'RR-MON-DD HH24:MI:SS') at time zone dbtimezone
from dual;

-- =============================================================================
-- Chapter 7
-- =============================================================================
-- open books
-- insert lastname and firstname (yourself) into next available row in customers table
    select * from customers;
    select max(customer#) from customers;
    
    insert into customers(customer#,firstname,lastname) 
                    values(1025,'Bucky','Rogers');

    select  count(*), count(lastname), count(state)
        , count (referred)  from customers;

select  count(*), count(distinct state), count(all state)  from customers;
--  what could you always count in a row to 
--  ensure you get the right count

select count(*), sum(quantity) from orderitems;

select min(retail) from books;
select max(cost) from books;
select avg(cost), avg(retail) from books;

select median(retail) from books;
select rank('COM') within group (order by TITLE ) from books;
select median(cost) from books;
select rank(20) within group (order by retail) from books;

select * from books;

-- cruises
select min(sq_ft) keep (dense_rank last order by guests) from ship_cabins;

select * from ship_cabins order by 7, 8;

select ship_cabin_id, room_number, room_style, room_type, window, guests,sq_ft
from ship_cabins
where ship_id = 1;

select room_style round(avg(sq_ft), 2)
from ship_cabins
group by room_style;

select * from ship_cabins;

-- page 288 top
select ship_cabin_id, room_number, room_style, room_type, window, guests, sq_ft from ship_cabins
where room_style in ('Suite','Stateroom') order by 3 desc;

-- page 288 bottom
select  room_style
      , room_type
      , round(avg(sq_ft),2)
      , min(guests)
      , count(ship_cabin_id) 
from ship_cabins
group by room_style, room_type;

select room_style, avg(sq_ft)
from ship_cabins
group by room_style;

-- page 289
select room_type, to_char(round(avg(sq_ft),2),'999,999.99'), max(guests), count(ship_cabin_id) from ship_cabins
where ship_id = 1
group by room_type
order by 2 desc;

-- page 290
select  to_char(round(avg(sq_ft),2),'999,999.99')
      , max(guests)
      , count(ship_cabin_id) 
from ship_cabins
where ship_id = 1 
  and room_type = 'Royal'
order by 1 desc;


SELECT  ROOM_STYLE,
        ROOM_TYPE,
        TO_CHAR(MIN(SQ_FT),'9,999') "Min"
FROM SHIP_CABINS
WHERE SHIP_ID = 1
GROUP BY ROOM_STYLE, ROOM_TYPE
HAVING ROOM_TYPE IN ('Standard', 'Large')
OR MIN(SQ_FT) > 1200
ORDER BY 3;

SELECT  ROOM_STYLE,
        ROOM_TYPE,
        TO_CHAR(MIN(SQ_FT),'9,999') "Min"
FROM SHIP_CABINS
WHERE SHIP_ID = 1 
GROUP BY ROOM_STYLE, ROOM_TYPE
HAVING min(guests) >5 or AVG(SQ_FT) > 1200 or ROOM_TYPE IN ('Standard', 'Large')
ORDER BY 3;

select count(*), count(balcony_sq_ft) from ship_cabins;
select count(*) from ship_cabins;
select balcony_sq_ft from ship_cabins;
select * from ship_cabins;
select count(*)  from ship_cabins;
select * from ship_cabins;

select sum(balcony_sq_ft) from ship_cabins;

select * from ship_cabins
order by sq_ft;

select distinct sq_ft from ship_cabins
order by 1;

select rank(300) within group(order by sq_ft)
from ship_cabins;

select max(sq_ft) keep (dense_rank first order by guests) largest from ship_cabins;
select min(sq_ft) keep (dense_rank first order by guests) smallest from ship_cabins;

select max(sq_ft) keep (dense_rank last order by guests) largest from ship_cabins;
select min(sq_ft) keep (dense_rank last order by guests) smallest from ship_cabins;

select max(sq_ft) from ship_cabins;
select min(sq_ft) from ship_cabins;

select * from ship_cabins order by 7,8;

select room_style,room_type,
  to_char(min(sq_ft),'9,999') "Min",
  to_char(max(sq_ft),'9,999') "Max",
  to_char(min(sq_ft)-max(sq_ft),'9,999') "Diff"
from ship_cabins
where ship_id = 1
group by room_style, room_type
order by uid;


select room_style, room_type, avg(max(sq_ft))
from ship_cabins
where ship_id = 1
group by room_style, room_type
order by 1 desc,2;

select avg(max(sq_ft))
from ship_cabins
where ship_id = 1
group by room_style, room_type;

select room_style, room_type, max(sq_ft)
from ship_cabins
where ship_id = 1
group by room_style, room_type
order by 1, 3;

-- =============================================================================
-- Chapter 8
-- =============================================================================

-- page 317 top
select * from ports;
select * from ships;

select ship_id, ship_name, port_name
from ships  right join ports
on home_port_id = port_id
order by ship_id;

-- page 317 bottom
select ship_id, ship_name, port_name
from ships  join ports
on home_port_id = port_id
where port_name ='Charleston'
order by ship_id;

-- page 318 top
select ship_id, ship_name, port_name
from ships, ports
where home_port_id = port_id
order by ship_id;

-- page 318 bottom
select ship_id, ship_name, port_name
from ships, ports
where home_port_id = port_id
  and port_name ='Charleston'
order by ship_id;

-- page 319 top
select ship_id, ship_name, port_name
from ships full outer join ports
  on home_port_id = port_id
order by ship_id;

select * from ports;

-- page 319 bottom
select ship_id, ship_name, port_name
from ships  join ports
  on home_port_id = port_id(+)
order by ship_id;

-- page 320 bottom
select ship_id, ship_name, port_name
from ships full join ports
  on home_port_id = port_id
order by ship_id;

-- page 321 bottom
select employee_id, last_name, address 
from employees inner join addresses 
  on employee_id = employee_id;

-- page 323 top
select e.employee_id, last_name, street_address 
from employees e inner join addresses a
  on e.employee_id = a.employee_id;

-- page 324 bottom
select employee_id, last_name, street_address 
from employees left join addresses 
  using (employee_id);

-- page 325 bottom
select p.port_name, s.ship_name, sc.room_number
from ports p join ships s on p.port_id = s.home_port_id
             join ship_cabins sc on s.ship_id = sc.ship_id;

-- page 325 bottom alternate
-- no 
select p.port_name, s.ship_name, sc.room_number
from ports p join ships s 
             join ship_cabins sc 
on p.port_id = s.home_port_id
on s.ship_id = sc.ship_id;

-- page 325 bottom alternate
-- yes
select p.port_name, s.ship_name, sc.room_number
from ports p join ships s 
      on p.port_id = s.home_port_id             
      join ship_cabins sc using (ship_id)
            ;

select p.port_name, s.ship_name, sc.room_number
from ports p join ships s 
      on p.port_id = s.home_port_id             
      join ship_cabins sc on sc.ship_id = s.ship_id
      join employees e on e.ship_id = sc.ship_id;


-- page 327
select * from scores; 
select * from grading;


select s.score_id, s.test_score, g.grade
from scores s join grading g
  on s.test_score between g.score_min and g.score_max;






-- page 328
select * from positions;

select * from positions p1 join positions p2 on p1.position_id = p2.reports_to;


-- page 330
select p1.position_id, p2.position employee, p1.position reports_to
from positions p1 join positions p2 on p1.position_id = p2.reports_to;

select * from positions p1 join positions p2 on p1.position_id = p2.position_id;

-- page 331
-- How many columns
-- How many rows
select * from vendors;


-- How many columns
-- How many rows
select * from online_subscribers;


-- How many total columns
-- How many total rows
select * from vendors, online_subscribers;

-- -----------------------------------------------------------------------------
-- HANDS ON EXERCISES CHAPTER 8
-- -----------------------------------------------------------------------------
-- 1. List employee's ID and name and address, city, state,
--    zip with new join syntax and keyword "ON"
--    Use table aliases for all returned columns where possible

select e.employee_id, e.first_name, e.last_name from employees e;
select a.employee_id, a.street_address, a.city, a.state, a.zip from addresses a;
select e.employee_id, e.first_name, e.last_name, a.street_address, a.city, a.state, a.zip 
 from employees e join addresses a on e.employee_id = a.employee_id;

-- 2. Repeat question 1 with the keyword "USING"
--    Use table aliases for all returned columns where possible
select employee_id, e.first_name, e.last_name, a.street_address, a.city, a.state, a.zip 
 from employees e join addresses a using(employee_id);
 
-- 3. List cruise_name and captains ID, 
-- captains name address, city, state,zip with new join syntax and keyword "ON"
select e.employee_id, e.first_name, e.last_name, a.street_address, a.city, a.state, a.zip 
 from employees e join addresses a 
      on e.employee_id = a.employee_id
   join cruises c 
      on e.employee_id = c.captain_id;   

-- 4. Repeat question 3 using keyword "USING"
select employee_id, e.first_name, e.last_name, a.street_address, a.city, a.state, a.zip 
 from employees e join cruises c on e.employee_id = c.captain_id
        join addresses a using (employee_id);   
 
select employee_id, first_name,last_name, a.street_address, a.city, a.state, a.zip 
 from employees join addresses a using (employee_id) 
          join cruises c on c.captain_id = employee_id;   

-- 5. Update cruises set captain_id = 3;
update cruises set captain_id = 3;
commit;

-- 6. Return Cruise name and ID with captains employee id, 
--   first and last names, street, city, state, zip (join on);

select * from addresses;
select * from employees;
select * from cruises;

select c.cruise_name, c.cruise_id, e.employee_id, e.first_name, e.last_name, a.street_address, a.city, a.state, a.zip 
 from employees e join addresses a on e.employee_id = a.employee_id
                  join cruises c on e.employee_id = c.captain_id;

-- 7a return captains name
select c.cruise_name, c.cruise_id, e.employee_id, e.first_name, e.last_name, a.street_address, a.city, a.state, a.zip 
 from employees e join addresses a on e.employee_id = a.employee_id
                  join cruises c on e.employee_id = c.captain_id;

-- 7b Return captains name, city, state, and start date, along with ship_name, 
--   cruise_name, and port_name 
select e.last_name, e.first_name, a.city, a.state, w.start_date, s.ship_name, ship_id, c.cruise_id, c.cruise_name, port_name 
 from addresses a join employees e on a.employee_id = e.employee_id
                  join cruises c on e.employee_id = c.captain_id
                  join ships s on c.ship_id = s.ship_id
                  join ports p on s.home_port_id = p.port_id
                  join work_history w on e.employee_id = w.employee_id
where cruise_id = 2;

-- 8 For the port of Baltimore return
--      Total cost of all projects (shown with dollars and commas)
--      Avg cost per project (shown with dollars and commas)
--      Toal number of projects 
--      Total number of man_hours (assume a crew of 5 people 8 hours per day)
select * from ports;
select * from ships;
select * from projects;
select port_name
        , to_char(sum(project_cost),'$999,999,999') total
        , to_char(avg(project_cost),'$999,999') avg
        , count(port_id) numberprojects, sum(days)*40 manhours 
from ports p  join ships s on p.port_id = s.home_port_id
              join projects pj on s.ship_id = pj.ship_id
where port_name = 'Baltimore'
group by port_name, project_cost, days;

select port_name, to_char(sum(project_cost),'$999,999,999') total,  to_char(avg(project_cost),'$999,999') avg, count(*) NumberProjects, sum(days)*40 ManHours 
from ports p
    , ships s
    , projects pj
where p.port_id = s.home_port_id
  and s.ship_id = pj.ship_id
  and port_name = 'Baltimore'
group by port_name;

-- 9 Using just the scores table return the test score and letter grade
-- using a case statement and these rules
-- LETTER GRADE       SCORE RANGE
-- ---------------------------------
--  A                   87-100
--  B                   75-86
--  C                   63-74
--  D                   51-62
--  F                   0-50

select  score_id
      , test_score
      , case when test_score > 87  then 'A'
             when test_score > 75  then 'B'
             when test_score > 63  then 'C'
             when test_score > 51  then 'D'
             when test_score >= 0  then 'F'
       end as grade
from scores;

select  case test_score 
            when '95' then 'A'
            when '83' then 'B'
            when '55' then 'D'
        end as myscore
from scores;

select  case 
            when test_score between 90 and 100 then 'A'
            when test_score between 80 and 89 then 'B'
            when test_score between 70 and 79 then 'A'
        end as myscore
from scores;






desc scores;

create table scores2 
      (score_id integer,
      test_score integer
      );

insert into scores2 values (1, 95);      
insert into scores2 values (2, 85);      
insert into scores2 values (3, 75);      

select  case test_score 
            when 95 then 'A'
            when 85 then 'B'
            when 75 then 'D'
        end as myscore
from scores2;

select  case 
            when test_score >= 95 then 'A'
            when test_score >= 85 then 'B'
            when test_score >= 75 then 'D'
        end as myscore
from scores2;


desc scores2;







      
select  case 
            when test_score between 90 and 100 then 'A'
            when test_score between 80 and 89 then 'B'
            when test_score between 70 and 79 then 'A'
        end as myscore
from scores2;

select * from scores;
desc scores;

-- 10. Disconnect from cruises 
--     Connect to books 
--     Return first and last names of customers with first and last name of who referred them
--     For those who were self-refered return null.
select * from CUSTOMERS;
select * from customers c join customers c1 on c.customer# = c1.referred;

select C1.CUSTOMER#, C2.FIRSTNAME, C2.LASTNAME, C2.REFERRED REFERRED_BY, C1.FIRSTNAME, C1.LASTNAME 
from customers c1 join customers c2 on c1.customer# = c2.referred;

select C2.CUSTOMER#, C2.FIRSTNAME, C2.LASTNAME, C2.REFERRED, C1.FIRSTNAME, C1.LASTNAME 
from CUSTOMERS C1 RIGHT join CUSTOMERS C2 on C1.CUSTOMER# = C2.REFERRED;

select C2.CUSTOMER#, C2.FIRSTNAME, C2.LASTNAME, C1.FIRSTNAME, C1.LASTNAME
from CUSTOMERS C1 right join CUSTOMERS C2 on c1.customer# = c2.referred;

select C2.CUSTOMER#, C2.FIRSTNAME, C2.LASTNAME, C1.FIRSTNAME, C1.LASTNAME
from CUSTOMERS C1 right join CUSTOMERS C2 on C1.CUSTOMER# = C2.REFERRED;


-- =============================================================================
-- Chapter 9
-- =============================================================================
-- page 350 top
select ship_id
from employees 
where last_name = 'Lindon' and first_name = 'Alice';

-- page 350 bottom 
select employee_id, last_name, first_name
from employees
where ship_id = 3
and NOT (last_name = 'Lindon' and first_name = 'Alice');



-- page 351 top
select employee_id, last_name, first_name
from employees
where ship_id = (
                   select ship_id 
                    from employees
                   where last_name = 'Lindon'
                     and first_name = 'Alice'
                   -- where last_name = 'Smith'
                )
and not last_name = 'Lindon';

-- page 351 bottom
select employee_id, last_name, first_name
from employees
where ship_id = (
                   select ship_id 
                    from employees
                   where last_name = 'Smith'
                )
and not last_name = 'Smith';


-- page 353
select employee_id, last_name, first_name, ssn
from employees
where ship_id in (
                   select ship_id 
                    from employees
                   where last_name = 'Smith'
                )
  ;


-- page 354 (same as page 353 with in operator)
select ship_id, last_name, first_name
from employees
where ship_id in (
                  select ship_id 
                    from employees
                   where last_name = 'Smith'
                );

-- page 356 
select invoice_id 
from invoices 
where (first_name, last_name ) in (
                  select first_name, last_name
                    from cruise_customers)
; -- empty set


select * from projects 
where project_cost >= all (select project_cost
                          from projects
                          where purpose = 'Maintenance');

select project_cost, purpose from projects 
where project_cost >= all (select project_cost
                          from projects                          
                          where purpose = 'Upgrade');                          ;

select project_cost, purpose  from projects where purpose = 'Upgrade';









-- page 357 
select * from invoices;
select * from pay_history;
update invoices set invoice_date = '04-JUN-01', total_price =37450 where invoice_id = 7; 
select invoice_id 
from invoices 
where (invoice_date, total_price ) 
                  = (
                      select start_date, salary
                      from pay_history
                      where pay_history_id = 4
                    )
; -- empty set

-- page 358 
select vendor_name,
       (select terms_of_discount from invoices where invoice_id = 1) as discount
from vendors
order by vendor_name;

-- page 359 
insert into employees
    (employee_id, ship_id)
values
(
    seq_employee_id.nextval,
    (select ship_id from ships where ship_name = 'Codd Champion')
);
rollback;



-- page 361 top
select a.ship_cabin_id, a.room_style, a.room_number, a.sq_ft
from ship_cabins a
where a.sq_ft > (select avg(sq_ft)
                 from ship_cabins
                 where room_style = a.room_style)
order by a.room_number;

-- page 361 bottom
select room_style, avg(sq_ft)
from ship_cabins
group by room_style;


-- page 363
update invoices inv
set terms_of_discount = '10 pct'
where total_price = ( select max(total_price)
                      from invoices
                      where to_char(invoice_date, 'RRRR-Q') = 
                            to_char(inv.invoice_date, 'RRRR-Q'));
rollback;

-- page 364
update ports p
set capacity = (select count(*)
                from ships
                where home_port_id = p.port_id)
where exists (  select * 
                from ships
                where home_port_id = p.port_id);

-- page 365 top
delete from ship_cabins s1
where s1.balcony_sq_ft = 
                          (select min(balcony_sq_ft)
                          from ship_cabins s2
                          where s1.room_type = s2.room_type
                          and s1.room_style = s2.room_style);

rollback;


-- page 365 bottom
select port_id, port_name
from ports p1 
where exists (select * 
              from ships s1
              where p1.port_id = s1.home_port_id);


-- page 366
with  port_bookings as (
                  select p.port_id, p.port_name, count(s.ship_id) ct
                  from ports p, ships s
                  where p.port_id = s.home_port_id
                  group by p.port_id, p.port_name
                   ),
      densest_port as (
                  select max(ct) max_ct
                  from port_bookings
                )
select port_name
from port_bookings
where ct = (select max_ct from densest_port);

-- -----------------------------------------------------------------------------
-- HANDS ON EXERCISES CHAPTER 9
-- ----------------------------------------------------------------------------
-- 3. Return all columns from ports that has a capacity > avg capacity for all ports
      select * from ports
      where capacity > 
                        ( select avg(capacity)
                         from ports);


-- 2. What is the name of Al Smith's captain on cruise_id = 4?
-- Return the ship_id, cruise_id, the captains first and last name
select * from cruises;
-- captain_id = 3 

select * from employees;
-- mike west (emp_id 3) and al smith (emp_id 5) both have 4 (ship_id)

      select e.ship_id, c.cruise_id, c.captain_id, e.first_name, e.last_name
       from cruises c join employees e on c.captain_id = e.employee_id
       where e.ship_id = ( select ship_id
                          from employees 
                          where first_name = 'Al' 
                            and last_name = 'Smith'
                        )
       and cruise_id = 4;
 

-- 3. Return all columns from ship cabins that has bigger than the avg
--    size balcony for the same room type and room style
select * 
from ship_cabins s
where balcony_sq_ft >  (select avg(balcony_sq_ft)
                       from ship_cabins
                       where s.room_type = room_type
                        and s.room_style = room_style);

select room_type, room_style, avg(balcony_sq_ft)
 from ship_cabins
 group by room_style, room_type;

select * from ship_cabins;

      select * 
      from ship_cabins s1
      where s1.balcony_sq_ft >=
                              (select avg(balcony_sq_ft)
                              from ship_cabins s2
                              where s1.room_type = s2.room_type
                               and s1.room_style = s2.room_style);

-- 4. Return employee id and ship id from work_history 
--    for the employee who has the worked the longest on that ship



















select * from work_history;
select employee_id, ship_id
from work_history w
where (end_date - start_date) =
                               ( select max(end_date-start_date) 
                                from work_history
                                where w.ship_id = ship_id
                                )
                                 ;

      select employee_id, ship_id 
      from work_history w1
      where abs(start_date - end_date) =
                      (select max(abs(start_date - end_date))
                      from work_history
                      where ship_id = w1.ship_id);
      
      
      select employee_id, ship_id 
      from work_history w1
      where abs(start_date - end_date) >= all
                              (select abs(start_date - end_date)
                              from work_history
                              where ship_id = w1.ship_id);










--  5. Return ship_name and port_name
--     for the ship with the maximum capacity in each home_port
-- ----------------------------------------------------------------------------
select s1.ship_name, (select port_name
                            from ports
                            where port_id = s1.home_port_id) home_port
      from ships s1
      where s1.capacity = ( select max(capacity)
                            from ships s2
                            where s2.home_port_id = s1.home_port_id);
-- ----------------------------------------------------------------------------
select sh.ship_name, pt.port_name, sh.capacity
from ships sh join ports pt 
              on sh.home_port_id = pt.port_id
where (sh.home_port_id, sh.capacity) in 
                                      ( select home_port_id, max(capacity)
                                         from ships group by home_port_id);
-- ----------------------------------------------------------------------------
select s1.ship_name, port_name
from ports p join ships s1 
    on p.port_id = s1.home_port_id
where s1.capacity = ( select max(capacity)
                      from ships s2
                      where s2.home_port_id = s1.home_port_id);

select * from ships;

select home_port_id, max(capacity)
from ships s2
group by home_port_id;



-- -----------------------------------------------------------------------------
-- DO HAND ON EXERCISES Chapter 7 (slides) handouts at home for Saturday
-- -----------------------------------------------------------------------------
-- 1 
-- Books with retail < average retail for all books
Select title, Retail 
From Books
where Retail <
             (Select Avg(Retail)
             From Books)
order by 1;                              
-- 2
-- Books that cost < than other books in same category

select title, b1.catcode, cost, Avgcost
from books b1
     ,( Select catcode, Avg(Cost) Avgcost
          From Books
          Group By catcode
          ) b2
where b1.catcode = b2.catcode
 and b1.cost < b2.avgcost;
 
 select title, cost
 from books where catcode = 'COM';
  
 
-- 3 
-- Orders shippd to same state as order 1014
select order#, shipstate
from orders 
where shipstate = 
           ( select shipstate 
              from orders 
              where order# = 1014
            );


-- 4
-- Orders with total amount > order 1008

select  oi.order#
      , sum(retail*quantity) total2
from  orderitems oi
    , books b1
where 1=1
and oi.isbn = b1.isbn
group by oi.order#
having sum(retail*quantity) > 
                      (select sum(retail*quantity) total1
                            from  orderitems oi
                                , books b
                            where oi.isbn = b.isbn
                             and order# = 1008
                             -- group by order#
                      );

select  oi.order#
      , sum(retail*quantity) total2
from  orderitems oi join books b1
using (isbn) 
group by oi.order#
having sum(retail*quantity) >     
                             ( select sum(retail*quantity) total1
                                  from  orderitems oi join books b
                                  using (isbn) 
                                  where  order# = 1008
                             );







-- 5 
-- Which author(s) wrote most frequently purchased book(s)


select oi.isbn, lname, fname, sum(quantity) qty
from  orderitems oi
     , books b
     , bookauthor ba
     , author a
 where oi.isbn = b.isbn
  and ba.isbn = b.isbn
  and ba.authorid = a.authorid
group by oi.isbn, lname, fname 
having sum(quantity) =  (select max(sum(quantity)) qty
                          from  orderitems
                          group by isbn);


select title, oi.isbn, lname, fname, sum(quantity) qty
from  orderitems oi join books b on oi.isbn = b.isbn
                    join bookauthor ba on ba.isbn = b.isbn
                    join author a on a.authorid = ba.authorid
group by title, oi.isbn, lname, fname 
having sum(quantity) =  (select max(sum(quantity)) qty
                          from  orderitems
                          group by isbn);


select title, isbn, lname, fname, sum(quantity) qty
from  orderitems oi join books b using (isbn)
                    join bookauthor ba using (isbn)
                    join author a using(authorid)
group by title, isbn, lname, fname 
having sum(quantity) =  (select max(sum(quantity)) qty
                          from  orderitems
                          group by isbn);

-- test count
select b.title, b.isbn, sum(quantity) qty
from  orderitems oi
      ,books b
where oi.isbn = b.isbn
group by b.title, b.isbn;

-- test author
select title, lname, fname 
from books b
     , bookauthor ba
     , author a
 where b.isbn = ba.isbn
  and ba.authorid = a.authorid
 and b.isbn like '%490';

-- 6
-- All titles in same cat customer 1007 purchased. Do not include titles purchased by customer 1007.
select distinct title, catcode
from books join orderitems using(isbn)
           join orders using (order#)
where catcode in (
                  select catcode
                  from  orders join orderitems using (order#)
                                   join books using (isbn)
                  where customer# = 1007
                  )
and customer# <> 1007 ;

select distinct title 
from orders join orderitems using(order#)
            join books using(isbn)
where CATCODE in ('FAL', 'COM', 'CHN')
 and customer# <> 1007;


select distinct (b.title) 
from books b
    ,(  select title, catcode
      from orders o
          , orderitems oi
          , books b
      where o.order# = oi.order#
        and oi.isbn = b.isbn
        and customer# = 1007
    ) b1
where b.catcode = b1.catcode;
and b.title <> b1.title;

-- everything purchased by customer 1007
select title, catcode 
from orders o
    , orderitems oi
    , books b
where o.order# = oi.order#
  and oi.isbn = b.isbn
  and customer# = 1007;

-- 7 
-- Customer(s) with city and state that had longest shipping delay

select c.customer#, city, state, shipdate, orderdate, shipdate - orderdate delay
from   orders o
     , customers c
where o.customer# = c.customer#
and (shipdate - orderdate) = (select max(shipdate - orderdate) delay from orders);

select CUSTOMER#, CITY, STATE, SHIPDATE, ORDERDATE, SHIPDATE - ORDERDATE delay
from   ORDERS join CUSTOMERS using (CUSTOMER#)
where (SHIPDATE - ORDERDATE) = (select max(SHIPDATE - ORDERDATE) delay from ORDERS);


select max(SHIPDATE-ORDERDATE)
from orders;


select * from CRUISE_ORDERS;
desc CRUISE_ORDERS;

alter table CRUISE_ORDERS drop column FIST_TIME_CUSTOMER;
desc CRUISE_ORDERS;
rollback;






-- 8
-- Who purchased least expensive book(s)
select firstname, lastname, title
from customers c join orders o using (customer#)
                 join orderitems oi using (order#)
                 join books b using (isbn)
where retail =  (select min (retail) from books);

select firstname, lastname, title
from customers c
    , orders o
    , orderitems oi
    , books b
where c.customer# = o.customer#
  and o.order# = oi.order#
  and oi.isbn = b.isbn
  and retail =  (select min (retail) from books);

-- 9
-- How many customers purchased books written/co-written by James Austin

select count(distinct customer#) 
from orders join orderitems using (order#)
            join books using (isbn)
where title in ( 
                select title 
                from author join bookauthor using(authorid)
                            join books using(isbn)
                where lname = 'AUSTIN' and fname = 'JAMES'
                );
-- ------------------------------------------------------------------            
select count(distinct customer#)
from orders join (select title, order# 
                  from orders join orderitems using (order#)
                              join books using(isbn)
                              join bookauthor using (isbn)
                              join author using (authorid)
                   where lname = 'AUSTIN' and fname = 'JAMES')
                   using (order#);
-- --------------------------------------------------------------------------                   
select  count(distinct customer#)                   
from orders join orderitems using (order#)
            join books using (isbn)                 
            join bookauthor using (isbn)
            join author using (authorid)
where lname = 'AUSTIN' and fname = 'JAMES';         

select count (distinct customer#)
from orders o
    , orderitems oi
where o.order# = oi.order#
and oi.isbn in 
            ( select distinct b.isbn
              from  books b
                  , bookauthor ba
                  , author a
              where ba.isbn = b.isbn
                and ba.authorid = a.authorid 
                and lname = 'AUSTIN'
                and fname = 'JAMES'
              );
-- books written by James Austin
    select distinct b.isbn
    from  books b
        , bookauthor ba
        , author a
    where ba.isbn = b.isbn
      and ba.authorid = a.authorid 
      and lname = 'AUSTIN'
      and fname = 'JAMES';



-- 10
-- Which books by same publisher as 'The Wok Way to Cook'
select title
from books 
where pubid = ( select pubid
                from publisher join books using (pubid)
                where title = 'THE WOK WAY TO COOK');
select title
from books 
where pubid = ( select pubid
                from books 
                where title = 'THE WOK WAY TO COOK');

















select title 
from books 
where pubid = 
            (select pubid 
             from books
            where title = 'THE WOK WAY TO COOK'
            );

-- publisher of 'The Wok Way to Cook'
select pubid 
 from books
where title = 'THE WOK WAY TO COOK';

-- -----------------------------------------------------------------------    
--a case for oracle chapter 7
-- ----------------------------------------------------------------------- 
-- 1.5% surcharge of all orders = $25.90

select sum(quantity * retail) * .015
from orderitems join books using(isbn);


select sum(thissum) * .04 from
      (
        select order#, sum(quantity * retail) thissum 
        from orderitems join books using(isbn)
        having sum(quantity * retail) > 
                               ( select avg(mysum)
                                  from (
                                        select sum(quantity * retail) mysum
                                        from orderitems join books using(isbn)
                                        group by order#
                                      )
                                )      
        group by order#
     );


select sum(quantity * retail) * .015
from orderitems oi
    , books b
where oi.isbn = b.isbn;

-- 3. sum orders above average = $58.44
select sum(ordertot) * .04
from (
    select order#, sum(quantity * retail) ordertot
    from orderitems oi
        , books b
    where oi.isbn = b.isbn
    group by order#
    having sum(quantity * retail) > 
                  (select avg(quantity * retail)
                  from orderitems join books using(isbn)
                  )
    );

-- 2. orders above average
select order#, sum(quantity * retail) ordertot
from orderitems oi
    , books b
where oi.isbn = b.isbn
group by order#
having sum(quantity * retail) > 
              (select avg(quantity * retail)
              from orderitems oi
                  , books b
              where oi.isbn = b.isbn
              );
-- 1. avg order 
select avg(quantity * retail)
from orderitems oi
    , books b
where oi.isbn = b.isbn;
-- 0. total amount of all orders
select sum(quantity * retail)
from orderitems oi
    , books b
where oi.isbn = b.isbn;



-- =============================================================================
-- Chapter 10
-- =============================================================================
-- page 383
create view vw_employees as
select employee_id, last_name, first_name, primary_phone
from employees;
drop view vw_employees;
desc vw_employees;

-- page 384
select * from vw_employees;
select employee_id, first_name || ' ' || last_name from vw_employees;

-- page 385 top
create or replace view vw_employees as
select employee_id, last_name || ' ' || first_name emp_name, primary_phone
from employees;

-- page 385 bottom
create view emp_trend as
  select emp.ship_id, min(salary) min_salary
    from employees emp left join pay_history pay
      on emp.employee_id = pay.employee_id
   where end_date is null
group by emp.ship_id;

-- page 387 top
create or replace view emp_phone_book
as select last_name, first_name, primary_phone
from employees;

-- page 387 top
insert into emp_phone_book (last_name, first_name, primary_phone)
values ('Sotogovernor','Sonia','212-555-1212');

-- page 387 bottom 
update emp_phone_book
set primary_phone = '212-555-1212'
where last_name = 'Hoddlestein'
and first_name = 'Howard';

-- page 387 bottom add_on 
delete from emp_phone_book
where last_name = 'Hoddlestein'
and first_name = 'Howard';

-- page 388 
create or replace view emp_phone_book
as select employee_id, first_name || ' ' || last_name emp_name,primary_phone
from employees;

create or replace view emp_phone_book
as select employee_id, first_name, last_name emp_name,primary_phone
from employees;

-- page 390 top
select a.ship_id, a.count_cabins, b.count_cruises
from (  select ship_id, count(ship_cabin_id) count_cabins
        from ship_cabins
        group by ship_id) a
        join
     (  select ship_id, count(cruise_order_id) count_cruises
        from cruise_orders
        group by ship_id) b
on a.ship_id = b.ship_id;


-- page 391 top
select rownum, invoice_id, account_number
from (  select invoice_id, account_number
        from invoices order by invoice_date
      )
where rownum <= 3;

-- page 392 do this before leaving views
-- -----------------------------------------------------------------------------
-- Key preserved table 
-- view when more than one table 
-- If you can assert that a given row in a table will appear at most 
-- once in the view -- that table is "key preserved" in the view. 
-- key preserved table example
CREATE TABLE shoppers
  (
    pid        integer,
    pname      VARCHAR2(11 BYTE),
    paddress   VARCHAR2(11 BYTE),
    CONSTRAINT people_pid_PK PRIMARY KEY (pid) 
  );

drop table shoppers;

begin
  insert into shoppers (pid, pname, paddress) values (10,'albert','123 main');
  insert into shoppers (pid, pname, paddress) values (11,'betty','456 main');
  insert into shoppers (pid, pname, paddress) values (12,'charley','789 main');
end;
/

CREATE TABLE invoices
  (
    iid        integer,
    pid        integer,
    istore     varchar2(10 byte),
    istorenum  integer,
    icity      varchar2(10 byte),
    iamount    number,
    CONSTRAINT invoices_iid_PK PRIMARY KEY (iid) 
  );
drop table invoices;
begin
  insert into invoices (iid, pid, istore, istorenum, icity, iamount) values (20,10,'kmart',4000,'Austin', 45.55);
  insert into invoices (iid, pid, istore, istorenum, icity, iamount) values (30,11,'sears',5000,'Austin', 12.67);
  insert into invoices (iid, pid, istore, istorenum, icity, iamount) values (40,12,'lowes',6000,'Austin', 22.99);
end;
/
-- one to many
Alter Table invoices Add Constraint invoices_shoppers_pid foreign key (pid) References shoppers (pid);

select * from invoices;

-- can't do this because duplicate column name
create or replace view vw_shoppers as
select * 
from shoppers s
    , invoices i
where s.pid = i.pid;

-- can do this because no duplicate column name
create or replace view vw_shoppers as
select s.pid pid, pname, paddress, iid, istore, istorenum, icity, iamount 
from shoppers s
    , invoices i
where s.pid = i.pid;

-- fails not key preserved
update vw_shoppers set pname = 'Delpha' where pid = 10;

-- only one possible row where id = 40 in underlying table 
update vw_shoppers set istore = 'BnN' where istorenum = 4000;
update vw_shoppers set istorenum = '7777' where iid = 40;
update vw_shoppers set icity = 'Houston' where iid = 40;
update vw_shoppers set iamount = 99.99 where iid = 40;
-- -----------------------------------------------------------------------------

-- page 398 middle
create table myseminars
(seminar_id     integer       primary key,
 seminar_name   varchar2(30)  unique);
 
-- page 398 bottom
select table_name, index_name 
from user_indexes
where table_name = 'MYSEMINARS';

-- page 399 top
select index_name, column_name 
from user_ind_columns
where table_name = 'MYSEMINARS';

select index_name, column_name 
from user_ind_columns
where table_name = 'CRUISE_CUSTOMERS';


-- page 400 middle
create index ix_invoice_invoice_vendor_id on invoices (vendor_id,invoice_date);

select index_name, column_name 
from user_ind_columns
where table_name = 'INVOICES';


-- =============================================================================
-- Chapter 11
-- =============================================================================
-- page 426 preparation
select * from cruise_orders;
begin
  insert into cruise_orders values (1,sysdate,sysdate, 1, 4);
  insert into cruise_orders values (2,sysdate,sysdate, 2, 4);
  insert into cruise_orders values (3,sysdate,sysdate, 3, 4);
  insert into cruise_orders values (4,sysdate,sysdate, 1, 4);
  insert into cruise_orders values (5,sysdate,sysdate, 2, 4);
end;
/
commit;

-- page 426 top
alter table cruise_orders add first_time_customer varchar2(5) default 'YES' not null;

alter table cruise_orders modify order_date default 'sysdate' not null;

desc cruise_orders;
        
-- page 426 bottom 
alter table cruise_orders
        add fist_time_customer varchar2(5) default 'YES' not null ;

desc cruise_orders;
insert into cruise_orders (cruise_order_id) values (10);




select * from cruise_orders;        

desc cruise_orders;

alter table cruise_orders modify (cruise_customer_id number(9),ship_id number(9));


desc cruise_orders;
alter table cruise_orders; 

-- page 438
create table junk
( id      integer,
  tid     integer,
  mid     integer);
drop table junk; 


create table junkfk
( id      integer,
  fkid     integer,
  mid     integer);
drop table junkfk;

-- -----------------------------------------------------------------------------
-- inline constraints
alter table junk modify id primary key; 
alter table junk modify id constraint pk_new primary key; 
alter table junk modify id not null;
alter table junk modify id constraint nn_mynew not null;
alter table junkfk modify id primary key; 

-- -----------------------------------------------------------------------------
-- out-of-line constraints
alter table junk add constraint pk_new primary key (id); 
alter table junk add constraint pk_new primary key (id, id); 
-- check 
alter table junk add constraint ck_wrong check (tid < id); 
-- null will not work
-- alter table junk add constraint nn_wrong not null (tid); 
-- fk 
alter table junkfk add constraint fk_junk foreign key(fkid) references junk(id);
-- must have a primary key in other table first

--page 441
drop table junk cascade constraints;
drop table junkfk;
alter table drop junk drop primary key cascade;
-- will not work
-- alter table junk drop primary key;
alter table junk drop primary key cascade;


-- page 442
alter table junk modify id not null;
alter table junk modify id null;


--page 443
create table ports2
  ( port_id number(7),
    port_name varchar2(20),
    constraint pk_ports primary key (port_id));
drop table ports2 cascade constraints;

create table ships2
  ( ship_id number(7),
    ship_name varchar2(20),
    home_port_id number(7),
    constraint pk_ships primary key (ship_id),
    constraint fk_sh_po foreign key (home_port_id) references ports2 (port_id)
  );
drop table ships2;  

begin
    insert into ports2 values (50, 'Jacksonville');
    insert into ports2 values (51, 'New Orleans');
    insert into ships2 values (10, 'Codd Royale', 50);
    insert into ships2 (ship_id, ship_name) values (11, 'Codd Ensign');
end;
/

delete from ports2 where port_id = 50;
delete from ports2 where port_id = 51;

-- page 450
select table_name, constraint_name, constraint_type 
  from user_constraints
 where r_constraint_name in ( select constraint_name 
                                from user_constraints
                               where table_name = 'PORTS2' 
                                 and constraint_type = 'P'
                             );
alter table ships2 drop constraint fk_sh_po;
alter table ships2 
  add constraint fk_sh_po foreign key (home_port_id)
  references ports2 (port_id) on delete cascade;

select * from ports2;
select * from ships2;
delete from ports2 where port_id = 50;
rollback;

-- page 455
-- in-line syntax
create table invoices2
  ( invoice_id number(11) primary key
        using index (create index ix_invoices on invoices2 (invoice_id)),
    invoice_date date);
    
    

-- page 456
-- out-of-line syntax
create table invoices3
  ( invoice_id number(11),
    invoice_date date,
    constraint ck_invs_inv_id  primary key (invoice_id)
                               using index (create index ix_invoices3
                               on invoices3(invoice_id))
);

-- page 457 top
create table customers2
( customer_id number(11) primary key,
  last_name varchar2(30)
);
      
      create index ix_customers_last_name on customers (upper(last_name));

-- page 457 bottom
create table gas_tanks 
( gas_tank_id number(7), 
  tank_gallons number(9), 
  mileage number(9)
);
      
      create index ix_gas_tanks_001 on gas_tanks (tank_gallons * mileage);

-- page 460
create table houdini ( voila varchar2(30));
insert into houdini (voila) values ('Now you see it.');
commit;
select * from houdini;
drop table houdini;
flashback table houdini to before drop;
select * from houdini;

-- page 461
select * from user_recyclebin;
select * from recyclebin;

-- page 463
create table houdini2 (voila varchar2(30)) enable row movement;

insert into houdini2 (voila) values ('Now you see it.');
commit;
execute dbms_lock.sleep(15);
delete from houdini2;
commit;
execute dbms_lock.sleep(15);
flashback table houdini2 to timestamp
systimestamp - interval '0 00:00:20' day to second;
-- doesn't work because flashback is not enabled by default
-- in APEX
select ora_rowscn, voila
from houdini;

select * from all_directories;

create table cruises2 as select * from cruises;
desc cruises2;
alter table cruises2 set unused column status;
flashback table cruises2 to timestamp systimestamp - interval '0 00:05:00' day to second;

drop table cruises2;
flashback table cruises2 to before drop;

select * from recyclebin;
purge recyclebin;

create RESTORE POINT my_restore;
create table houdini3 (voila varchar2(30)) enable row movement;
insert into houdini3 (voila) values ('Now you see it');
flashback table houdini3 to timestamp systimestamp - interval '0 00:01:30' day to second;
select * from houdini3;

-- -----------------------------------------------------------------------------
-- E X T E R N A L     T A B L E 
-- -----------------------------------------------------------------------------
-- page 472
-- -----------------------------------------------------------------------------
-- 1. First physically create the directory c:\temp
-- -----------------------------------------------------------------------------
-- 2. Then login as system and do:
--              A. CREATE OR REPLACE DIRECTORY BANK_FILES AS 'C:\temp';

CREATE OR REPLACE DIRECTORY BANK_FILES AS 'C:\temp';

--              B. GRANT READ, WRITE ON DIRECTORY BANK_FILES TO CRUISES;
GRANT READ, WRITE ON DIRECTORY BANK_FILES TO CRUISES;
-- -----------------------------------------------------------------------------
-- 3. Create the external table
      -- drop table INVOICES_EXTERNAL;
      create table invoices_external
      (   invoice_id char(6),
          invoice_date char(13),
          invoice_amt char(9),
          account_number char(11)
      )
      organization external
      ( type ORACLE_LOADER
        default directory bank_files
        access parameters
        (records delimited by newline
      skip 2
        fields (  invoice_id char(6),
                  invoice_date char(13),
                  invoice_amt char(9),
                  account_number char(11))
      )
      -- make sure there are no extra lines that might be interpreted as null later when loading into PK
      location ('load_invoices.txt')
      );
          
           
      drop table invoices_external;
-- -----------------------------------------------------------------------------
-- 4. Create the internal table from the external table
      drop table invoices_internal; 
      create table invoices_internal as select * from invoices_external;
      select * from invoices_internal where invoice_id is null;
-- -----------------------------------------------------------------------------
-- 5. Create a new table with datatypes we want 
      drop table invoices_revised;
      create table invoices_revised
      (  invoice_id     integer primary key,
         invoice_date   date,
         invoice_amt    number,
         account_number varchar(13)
      );
      select count(*) from invoices_external;
      select count(*) from invoices_internal;
-- -----------------------------------------------------------------------------
-- 6. Insert into the new table 
      truncate table invoices_revised;
      insert into invoices_revised
            (invoice_id
            , invoice_date
            , invoice_amt
            , account_number) 
      select invoice_id
            , to_date(invoice_date,'mm/dd/yyyy')
            , to_number(invoice_amt)
            , account_number  
      from invoices_internal;
-- Done

select * from invoices_internal;

-- -----------------------------------------------------------------------------

-- =============================================================================
-- Chapter 12
-- =============================================================================

select * from contact_emails;
select * from online_subscribers;

select contact_email_id, email_address from contact_emails
where status = 'Valid'
UNION
select online_subscriber_id, email from online_subscribers;

select contact_email_id, email_address from contact_emails
UNION
select online_subscriber_id, email from online_subscribers;

select contact_email_id, email_address from contact_emails
UNION ALL
select online_subscriber_id, email from online_subscribers;

select email_address from contact_emails
UNION 
select email from online_subscribers;


select email_address from contact_emails
INTERSECT 
select email from online_subscribers;

select email from online_subscribers
intersect 
select email_address from contact_emails;

select email_address from contact_emails;
select email from online_subscribers;

select email_address from contact_emails
minus
select email from online_subscribers
order by email_address;

select email from online_subscribers
minus
select email_address from contact_emails;




select email from online_subscribers
minus
select email_address from contact_emails
order by email;

(select product from store_inventory
union all
select item_name from furnishings
)
intersect
(
select item_name from furnishings where item_name = 'Towel'
union all
select item_name from furnishings where item_name = 'Towel'
);

-- =============================================================================
-- Chapter 13
-- =============================================================================
-- -----------------------------------------------------------------------------
--  ROLLUP  1     C O L U M N  
-- -----------------------------------------------------------------------------
select * from ship_cabins;
-- page 513 top 1 col room_style
select room_style, sum(sq_ft) sq_ft
from ship_cabins
where ship_id = 1
group by room_style
order by room_style;


-- page 513 top 1 col room_type
select room_type, sum(sq_ft) sq_ft
from ship_cabins
where ship_id = 1
group by room_type
order by room_type;

-- page 513 bottom 1 col
select room_style, sum(sq_ft) sq_ft
from ship_cabins
where ship_id = 1
group by rollup (room_style)
order by room_style;


-- page 513 bottom 1 col
select room_type, sum(sq_ft) sq_ft
from ship_cabins
where ship_id = 1
group by rollup(room_type)
order by room_type;

-- -----------------------------------------------------------------------------
--  ROLLUP  2     C O L U M N S 
-- -----------------------------------------------------------------------------
-- group by 
-- ------------------------------------------------
select * from ship_cabins where ship_cabin_id < 10;
-- page 513 top 2 col GROUP BY 
select room_style, room_type, sum(sq_ft) sq_ft
from ship_cabins
where ship_id = 1
 and ship_cabin_id < 10
group by room_style, room_type
order by room_style, room_type;
-- ------------------------------------------------
-- page 513 top 2 col reverse GROUP BY 
select room_type, room_style,  sum(sq_ft) sq_ft
from ship_cabins
where ship_id = 1
 and ship_cabin_id < 10
group by room_type, room_style
order by room_type, room_style;
-- -----------------------------------------------------------------------------
-- rollup 
-- -----------------------------------
select room_style, room_type from ship_cabins where ship_cabin_id < 6;
-- page 513 bottom 2 col ROLLUP 
select room_style, room_type, sum(sq_ft) sum_sq_ft
from ship_cabins
where ship_id = 1
 and ship_cabin_id < 6
group by rollup(room_style, room_type)
order by room_style, room_type;
-- -----------------------------------
-- page 513 bottom 2 col reverse ROLLUP
select room_style,room_type from ship_cabins where ship_id = 1 and ship_cabin_id < 6 order by room_style, room_type;
select room_style,room_type,  sum(sq_ft) sum_sq_ft
from ship_cabins
where ship_id = 1
  and ship_cabin_id < 6
group by rollup(room_style,room_type)
order by room_style, room_type;
-- -----------------------------------
select window,room_type,room_style  
from ship_cabins 
where ship_id = 1 
 and ship_cabin_id < 7 and ship_cabin_id > 3 
 order by window, room_type,room_style;
  
select room_type,room_style,  sum(sq_ft) sum_sq_ft
from ship_cabins
where ship_id = 1
  and ship_cabin_id < 7 and ship_cabin_id > 3
group by rollup(room_type,room_style)
order by room_type, room_style;

select room_type,room_style,  sum(sq_ft) sum_sq_ft
from ship_cabins
where ship_id = 1
  and ship_cabin_id < 7 and ship_cabin_id > 3
group by cube(room_type,room_style);
order by room_type, room_style;

select room_style,room_type,  sum(sq_ft) sum_sq_ft
from ship_cabins
where ship_id = 1
  and ship_cabin_id < 7 and ship_cabin_id > 3
group by rollup(room_style,room_type);

select window, room_type,room_style,  sum(sq_ft) sum_sq_ft
from ship_cabins
where ship_id = 1
  and ship_cabin_id < 7 and ship_cabin_id > 3
group by window, rollup(room_type,room_style)
order by room_type,room_style;


-- -----------------------------------
select room_type,room_style  from ship_cabins where ship_id = 1 and ship_cabin_id < 7 and ship_cabin_id > 3 order by room_style, room_type;
select grouping(room_type),grouping(room_style),  sum(sq_ft) sum_sq_ft
from ship_cabins
where ship_id = 1
  and ship_cabin_id < 7 and ship_cabin_id > 3
group by rollup(room_type,room_style)
order by room_style, room_type;
-- -----------------------------------------------------------------------------
-- group by rollup
-- -----------------------------------
select window , room_type,room_style  from ship_cabins where ship_id = 1 and ship_cabin_id < 7 and ship_cabin_id > 3 order by room_style, room_type;
select window brand, room_type series, room_style type,  sum(sq_ft) sum_sq_ft
from ship_cabins
where ship_id = 1
  and ship_cabin_id < 7 and ship_cabin_id > 3
group by window, room_type,room_style
order by window, room_style, room_type;
-- -----------------------------------
select window brand, room_type series, room_style type,  sum(sq_ft) sum_sq_ft
from ship_cabins
where ship_id = 1
  and ship_cabin_id < 7 and ship_cabin_id > 3
group by window, rollup(room_type,room_style)
order by window, room_style, room_type;
-- -----------------------------------
select grouping(window), grouping(room_type), grouping(room_style),  sum(sq_ft) sum_sq_ft
from ship_cabins
where ship_id = 1
  and ship_cabin_id < 7 and ship_cabin_id > 3
group by window, rollup(room_type,room_style)
order by window, room_style, room_type;
-- -----------------------------------
select window, room_type,room_style,  sum(sq_ft) sum_sq_ft
from ship_cabins
where ship_id = 1
  and ship_cabin_id < 6
group by window, room_type,room_style
order by window, room_style, room_type;

-- -----------------------------------------------------------------------------
-- cube compare
-- -----------------------------------
select room_style,room_type from ship_cabins where ship_id = 1 and ship_cabin_id < 6 order by room_style, room_type;
select room_style,room_type,  sum(sq_ft) sum_sq_ft
from ship_cabins
where ship_id = 1
  and ship_cabin_id < 6
group by cube(room_style,room_type)
order by room_style, room_type;
-- -----------------------------------
-- page 513 bottom 3 cols
select window,room_style, room_type from ship_cabins where ship_id = 1 and ship_cabin_id < 6;
select window,room_style, room_type, sum(sq_ft) sq_ft
from ship_cabins
where ship_id = 1
  and ship_cabin_id < 6
group by rollup(window,room_style, room_type)
order by window,room_style, room_type;
-- -----------------------------------
select window,room_style, room_type from ship_cabins where ship_id = 1 and ship_cabin_id < 6;
select window,room_style, room_type, sum(sq_ft) sq_ft,
 grouping(window) as wd, grouping(room_style) as rs, grouping(room_type) as rt
from ship_cabins
where ship_id = 1
  and ship_cabin_id < 6
group by rollup(window,room_style, room_type)
order by window,room_style, room_type;
-- -----------------------------------
-- page 514 multple rollups (see bullets)
select room_style, room_type, sum(sq_ft) sum_sq_ft
from ship_cabins
where ship_id = 1
group by rollup(room_type),
         rollup(room_style)
order by room_style, room_type;
-- -----------------------------------
select window, room_style, room_type, sum(sq_ft) sum_sq_ft
from ship_cabins
where ship_id = 1
group by rollup(window),
         rollup(room_type),
         rollup(room_style);
order by room_style, room_type;
-- -----------------------------------
-- page 514 group by and rollup
select window, room_style, room_type, sum(sq_ft) sum_sq_ft
from ship_cabins
where ship_id = 1
group by window, rollup (room_style, room_type)
order by window, room_style, room_type;
-- -----------------------------------------------------------------------------
--  CUBE
-- -----------------------------------------------------------------------------
select * from ship_cabins where ship_id = 1 and ship_cabin_id < 10;
-- page 516 cube 1 col
select room_type, sum(sq_ft) sq_ft
from ship_cabins
where ship_id = 1
 and ship_cabin_id < 10
group by cube (room_type)
order by room_type;
-- -----------------------------------
select room_style, sum(sq_ft) sq_ft
from ship_cabins
where ship_id = 1
group by cube (room_style)
order by room_style;
-- -----------------------------------
-- group by cube
-- -----------------------------------
select room_style, room_type from ship_cabins where ship_id = 1 and ship_cabin_id < 9 and ship_cabin_id > 5 order by room_style, room_type;
-- page 516 cube 2 col
select room_style, room_type, sum(sq_ft) sq_ft
from ship_cabins
where ship_id = 1
  and ship_cabin_id < 9 and ship_cabin_id > 5
group by cube(room_style, room_type)
order by room_style, room_type;
-- ------------------------------------------------
select window, room_style, room_type from ship_cabins where ship_id = 1 and ship_cabin_id < 9 and ship_cabin_id > 5 order by room_style, room_type;
select window, room_style, room_type, sum(sq_ft) sq_ft
from ship_cabins
where ship_id = 1
  and ship_cabin_id < 9 and ship_cabin_id > 5
group by window, cube(room_style, room_type)
order by room_style, room_type;
-- ------------------------------------------------
-- double cube
-- page 516 cube 2 col multiple cubes
select room_style, room_type, sum(sq_ft) sq_ft
from ship_cabins
where ship_id = 1
group by cube(room_style),
         cube(room_type)
order by room_style, room_type;

-- page 516 cube 3 col
select window, room_style,room_type, sum(sq_ft) sq_ft
from ship_cabins
where ship_id = 1
group by cube(window,room_style,room_type)
order by window,room_style,room_type;

select window, room_style,room_type, sum(sq_ft) sq_ft
from ship_cabins
where ship_id = 1
group by window, cube (room_style,room_type)
order by window,room_style,room_type;

-- -----------------------------------------------------------------------------
--  GROUPING FUNCTION
-- -----------------------------------------------------------------------------
-- page 517 grouping function 1 cols
select grouping(room_type)
      , room_type
      , sum(sq_ft) sq_ft
from ship_cabins
where ship_id = 1
group by rollup (room_type)
order by room_type;



-- page 517 grouping function 2 cols
select  grouping(room_style) 
      , grouping(room_type) 
      , room_style 
      , room_type 
      , sum(sq_ft) sq_ft
from ship_cabins
where ship_id = 1
group by rollup (room_style, room_type)
order by room_style, room_type;

-- page 517 grouping function 3 cols
select grouping(window)
      , grouping(room_style)
      , grouping(room_type)
      , window
      , room_style
      , room_type
      , sum(sq_ft) sq_ft
from ship_cabins
where ship_id = 1
group by rollup (window,room_style, room_type)
order by window,room_style, room_type;




-- page 518 rollup
select    decode(grouping(room_style),
                  1,'ALL STYLES', room_style) style,
          decode(grouping(room_type),
                  1,'ALL TYPES', room_type) type,
          sum(sq_ft) sq_ft
from ship_cabins
where ship_id = 1
group by rollup (room_style, room_type)
order by room_style;






-- page 518 cube
select    decode(grouping(room_style),
                  1,'ALL STYLES', room_style) style,
          decode(grouping(room_type),
                  1,'ALL TYPES', room_type) type,
          sum(sq_ft) sq_ft
from ship_cabins
where ship_id = 1
group by cube (room_style, room_type)
order by room_style;

-- -----------------------------------------------------------------------------
--  GROUPING SETS
-- -----------------------------------------------------------------------------
-- page 520
select  nvl(window,' ')
      , nvl(room_style,' ')
      , nvl(room_type,' ')  
      , sum(sq_ft) sq_ft
from ship_cabins
where ship_id = 1
group by grouping sets ((window,room_style), (room_type), null)
order by window,room_style, room_type;

-- -----------------------------------------------------------------------------
-- HANDS ON EXERCISES
-- -----------------------------------------------------------------------------

CREATE TABLE divisions (
    division_id CHAR(3) CONSTRAINT divisions_pk PRIMARY KEY,
    name VARCHAR2(15) NOT NULL
);
drop table divisions;
drop table jobs;
drop table employees2;
CREATE TABLE jobs (
  job_id CHAR(3) CONSTRAINT jobs_pk PRIMARY KEY,
  name VARCHAR2(20) NOT NULL
);

CREATE TABLE employees2 (
      employee_id INTEGER CONSTRAINT employees2_pk PRIMARY KEY
    , division_id CHAR(3)CONSTRAINT employees2_fk_divisions REFERENCES divisions(division_id)
    , job_id CHAR(3) REFERENCES jobs(job_id)
    , first_name VARCHAR2(10) NOT NULL
    , last_name VARCHAR2(10) NOT NULL,
      salary NUMBER(6, 0)
);

select * from employees2;
select * from jobs;
select * from divisions;

-- 1 
-- Group the salary (employees2) by job name (jobs) 
select name, sum(salary)
from employees2 join jobs using (job_id)
group by name;

select name, sum(salary)
from employees2 join jobs using (job_id)
group by rollup(name);

-- with a grand total 

select name, sum(salary)
from employees2 join jobs using (job_id)
group by rollup (name);

-- 2 
-- calculate total number of days and cost by purpose with grand totals
select * from projects;

select nvl(purpose,'----TOTAL----')
        , sum(project_cost), sum(days)
from projects
group by rollup (purpose);


select purpose, sum(project_cost), sum(days) from projects
group by rollup (purpose);

-- 3
-- calculate total number of days and total cost by ship_name with grand totals

select nvl(ship_name,'--TOTALS---'), sum(project_cost), sum(days)
from projects join ships using(ship_id)
group by rollup (ship_name);


select ship_name, sum(project_cost), sum(days) 
from projects join ships using (ship_id)
group by rollup (ship_name);

-- 4 
-- Get the total salary by division (employees2)
-- how many rows does your SQL return?
select name, sum(salary)
from employees2 join divisions using (division_id)
group by rollup (name)
order by 1;


-- 5 
-- Get the total salary by job_id (employees2) no grand total
-- how many rows does your SQL return?

SELECT job_id, SUM(salary)
FROM employees2
GROUP BY job_id;


-- 6 
-- Get the total salary by division (employees2) with grand total
-- how many rows does your SQL return?
SELECT division_id, SUM(salary)
FROM employees2
GROUP BY rollup(division_id);


-- 7
-- Sum salary by division name and job name with no grand total

select j.name, d.name, sum(salary)
from employees2 e join jobs j on e.job_id=j.job_id
                 join divisions d on e.division_id = d.division_id
group by rollup (j.name, d.name);

select  nvl(d.name,' TOTALS ')
      , nvl(j.name,'SUB TOTALS')
      , sum(salary)
from employees2 e join jobs j on e.job_id=j.job_id
                 join divisions d on e.division_id = d.division_id
group by rollup (d.name, j.name);

SELECT divisions.name div, jobs.name job, SUM(salary)
FROM employees2 join jobs using(job_id)
                join divisions using (division_id)
GROUP BY (divisions.name, jobs.name)
order by 1;

-- 8
-- Sum salary by division name and job name with grand total
-- and superaggregate rows for just divisions
select nvl(d.name,'GRAND TOTALS') div
      , j.name job, sum(salary)
from employees2 join jobs j using(job_id)
                join divisions  d using (division_id)
group by rollup (d.name, j.name)
order by d.name;

SELECT divisions.name div, jobs.name job, SUM(salary)
FROM employees2 join jobs using(job_id)
                join divisions using (division_id)
GROUP BY rollup (divisions.name, jobs.name)
order by 1;

-- 9 Sum salary by division name and job name with grand total
-- and superaggregate rows for both division and job names.
-- How many rows total does your SQL return
-- What is the value for all operations
-- what is the value for all technologists


SELECT nvl(divisions.name,'GRAND TOTALS') div, jobs.name job, SUM(salary)
FROM employees2 join jobs using(job_id)
                join divisions using (division_id)
group by cube (divisions.name, jobs.name)
order by divisions.name;

-- 10. 
-- Show the total salary for all combinations of division and job names
-- and show the values --ALL DIVISIONS--, --ALL JOBS-- in the appropriate
-- places.
-- How many rows show --ALL DIVISIONS--.
-- How many rows show --ALL JOBS--.



SELECT  decode(grouping(divisions.name), 1, 'ALL DIVISIONS',divisions.name) div
      , decode(grouping(jobs.name), 1, 'ALL JOBS', jobs.name) job
      , SUM(salary)
FROM employees2 join jobs using(job_id)
                join divisions using (division_id)
group by cube (divisions.name, jobs.name)
order by divisions.name ;


-- =============================================================================
-- Chapter 14
-- =============================================================================

-- page 536
select * from user_tables;

select * from all_tables;

select * from dba_tables;

select column_name from all_tab_columns
where table_name = 'CRUISES';
;
select column_name, data_type, data_length
from all_tab_columns
where table_name = 'CRUISES';


select * from all_tab_columns where owner = 'CRUISES';

select * from all_tab_columns where owner = 'CRUISES' and table_name = 'ADDRESSES';
select column_name from all_tab_columns where owner = 'CRUISES' and table_name = 'ADDRESSES';
-- address_id,employee_id,street_address,street_address2,city,state,zip,zip_plus,country,contact_email,


select * from all_cons_columns where owner = 'CRUISES';
select * from all_synonyms;

-- page 537
select * from user_constraints;
select * from all_constraints;

-- page 537
select * from user_synonyms;
select * from all_synonyms;

-- page 538 Overlap of views
select * from user_catalog;
select * from user_tables;
select * from user_tab_columns;

-- page 538 Dynamic Performance Views
select * from all_catalog where table_type = 'VIEW';

select * from v$version;
select * from product_component_version;


-- page 539
-- Version
select * from v$version;
select * from product_component_version;

-- page 539
-- as system
  select * from v$database;
select * from v$instance;
select * from v$timezone_names;

-- page 540
select * from all_tab_comments where table_name = 'PORTS';
select * from all_col_comments;


-- page 541
comment on table ports is 'Listing of all ports';
select * from user_tab_comments;

-- page 541
comment on column ports.capacity is 'Max num of passengers';
select * from user_col_comments;

-- page 542
desc dictionary;
select * from dictionary;

-- page 543
select * from dictionary where table_name like '%RESTORE%';
select * from dictionary where upper(comments) like '%INDEX%';
select * from dictionary where upper(comments) like '%RESTORE%';

-- page 543 
select * 
from all_col_comments
where owner = 'CRUISES'
and table_name = 'PORTS';

-- page 544
select * from user_catalog;
select table_type, count(*) 
from user_catalog
group by table_type;

-- page 545
select * from user_tab_columns;

-- page 546 middle
select * from USER_OBJECTS where STATUS = 'INVALID';

-- page 546 bottom
select text from user_views; 

-- page 547
Select * from user_constraints where table_name = 'CRUISES';

-- as system
select * 
from V$SYSTEM_PARAMETER
where upper(name) = 'UNDO$'; 

select * from PORTS
versions between timestamp minvalue and maxvalue;

select * from PORTS
as of timestamp systimestamp - interval '0 0:01:30' DAY TO SECOND;

-- =============================================================================
-- Chapter 15
-- =============================================================================
-- Go back to chapter 11 approximately line 2540
-- install EXTERNAL TABLE table from c:\temp  invoices.txt

-- page 561
select * 
from invoices_revised
where invoice_date < (add_months(sysdate,-12));

select * 
from invoices_revised
where invoice_date > to_date('05/31/10','mm/dd/yy') 
 and invoice_date < to_date('08/01/10','mm/dd/yy') ;


-- page 561
create table invoices_archiveCAL2010Q2 as
select * 
from invoices_revised
where invoice_date > to_date('05/31/10','mm/dd/yy') 
 and invoice_date < to_date('08/01/10','mm/dd/yy') ;
drop table invoices_archiveCAL2010Q2; 

-- page 562
create table room_summary as
select    a.ship_id
        , a.ship_name
        , b.room_number
        , b.sq_ft + nvl(b.balcony_sq_ft,0) sq_ft
from ships a join ship_cabins b
on a.ship_id = b.ship_id;

create table room_summary2  (s_id,s_name,r_num,sq_ft) as
select    a.ship_id
        , a.ship_name
        , b.room_number
        , b.sq_ft + nvl(b.balcony_sq_ft,0) 
from ships a join ship_cabins b
on a.ship_id = b.ship_id;


-- page 563
select * from cruise_customers;
select * from employees;

-- page 564 top
select seq_cruise_customer_id.nextval from dual;
drop sequence seq_cruise_customer_id;
select max(cruise_customer_id) from cruise_customers;
create sequence seq_cruise_customer_id start with 4;

insert into cruise_customers
(cruise_customer_id, first_name, last_name)
select seq_cruise_customer_id.nextval
      , emp.first_name
      , emp.last_name
from employees emp;

select * from cruise_customers;

-- page 565
select home_port_id
      , count(ship_id) total
      , sum(capacity) capacity
from ships
group by home_port_id
order by 1;


-- page 566
select * from ports;

update ports p
set (tot_ships_assigned, tot_ships_asgn_cap) =
(select  count(s.ship_id) total
      , sum(s.capacity) capacity
from ships s
where s.home_port_id = p.port_id
group by home_port_id);

-- page 572
select * from invoices_revised;
desc invoices_revised;
create table invoices_revised_archive
( invoice_id     number,
  invoice_date    date,
  invoice_amt   number,
  account_number varchar2(13));
      
create table invoices_revised_archive2
( invoice_id     number,
  invoice_date    date,
  invoice_amt   number,
  account_number varchar2(13));

-- page 572
insert all
 into invoices_revised_archive (invoice_id, invoice_date, 
                                invoice_amt,account_number)
  values                       (invoice_id, invoice_date, 
                                invoice_amt,account_number)
 into invoices_revised_archive2 (invoice_id, invoice_date , 
                                invoice_amt,account_number)
  values                       (invoice_id, invoice_date, 
                                invoice_amt,account_number)
 select invoice_id, invoice_date, invoice_amt,account_number
  from invoices_revised;
 
-- page 573
insert all
 into invoices_revised_archive (invoice_id, invoice_date, 
                                invoice_amt,account_number)
  values                       (invoice_id, invoice_date, 
                                invoice_amt,account_number)
 into invoices_revised_archive2 (invoice_id, invoice_date , 
                                invoice_amt,account_number)
  values                       (vinvoice_id, invoice_date + 365, 
                                invoice_amt,account_number)
 select invoice_id, invoice_date, invoice_amt,account_number
  from invoices_revised;


truncate table invoices_revised_archive2; 


-- Page 575
create table invoices_archived2
( invoice_id     number,
  invoice_date    date,
  invoice_amt   number,
  account_number varchar2(13));
      
create table invoices_new2
( invoice_id     number,
  invoice_date    date,
  invoice_amt   number,
  account_number varchar2(13));


truncate table invoices_revised_archive;
truncate table invoices_revised_archive2;
-- Page 575
insert 
    when (invoice_date < (add_months(sysdate,-12))) then
      into invoices_revised_archive (invoice_id, invoice_date,
                                invoice_amt, account_number)
      values                  (invoice_id, invoice_date, 
                                invoice_amt, account_number)
    else
      into invoices_revised_archive2      (invoice_id, invoice_date,
                                invoice_amt, account_number)
      values                  (invoice_id, invoice_date, 
                                invoice_amt, account_number)
select invoice_id, invoice_date, invoice_amt, account_number
from invoices_revised;


select count(*) from invoices_revised_archive;
select count(*) from invoices_revised_archive2;




select (select count(*) from invoices_archived2) +  
        (select count(*) from invoices_new2)
        from dual;


-- page 576 & 577
-- create table invoices_2009
create table invoices_2009
  (
    invoice_id      number primary key,
    invoice_date    date,
    invoice_amt     number,
    account_number  varchar2(13 byte)
  );
create table invoices_2010
  (
    invoice_id      number primary key,
    invoice_date    date,
    invoice_amt     number,
    account_number  varchar2(13 byte)
  );
create table invoices_2011
  (
    invoice_id      number primary key,
    invoice_date    date,
    invoice_amt     number,
    account_number  varchar2(13 byte)
  );

create table invoices_all
  (
    invoice_id      number primary key,
    invoice_date    date,
    invoice_amt     number,
    account_number  varchar2(13 byte)
  );


truncate table invoices_2009;
truncate table invoices_2010;
truncate table invoices_2011;



insert first
    when (to_char(invoice_date,'RRRR') <= '2009') then
      into invoices_2009 (invoice_id, invoice_date,
          invoice_amt, account_number)
      values (invoice_id, invoice_date, invoice_amt, account_number)
      into invoices_all (invoice_id, invoice_date,
          invoice_amt, account_number)
      values (invoice_id, invoice_date, invoice_amt, account_number)
    when (to_char(invoice_date,'RRRR') <= '2010') then
      into invoices_2010 (invoice_id, invoice_date,
          invoice_amt, account_number)
      values (invoice_id, invoice_date, invoice_amt, account_number)
      into invoices_all (invoice_id, invoice_date,
          invoice_amt, account_number)
      values (invoice_id, invoice_date, invoice_amt, account_number)
    when (to_char(invoice_date,'RRRR') <= '2011') then
      into invoices_2011 (invoice_id, invoice_date,
          invoice_amt, account_number)
      values (invoice_id, invoice_date, invoice_amt, account_number)
select invoice_id, invoice_date, invoice_amt, account_number
from invoices_revised;

--    when (to_char(date_shipped,'RRRR') <= '2008') then
--      into invoices_thru_2008 (invoice_id, invoice_date,
--          shipping_date, account_number)
--      values (inv_no, date_entered, date_shipped, cust_acct)
--      into invoices_closed (invoice_id, invoice_date,
--          shipping_date, account_number)
--      values (inv_no, date_entered, date_shipped, cust_acct)
--    when (to_char(date_shipped,'RRRR') <= '2007') then
--      into invoices_thru_2007 (invoice_id, invoice_date,
--        shipping_date, account_number)
--      values (inv_no, date_entered, date_shipped, cust_acct)
--select inv_no, date_entered, date_shipped, cust_acct
--from wo_inv;
-- -----------------------------------------------------------------------------

-- page 579
insert
      when (boss_salary-employee_salary < 79000) then
      into salary_chart (emp_title, superior, emp_income, sup_income)
      values (employee, boss, employee_salary, boss_salary)
select a.position employee,
       b.position boss,
       a.max_salary employee_salary,
       b.max_salary boss_salary
from positions a join positions b
on a.reports_to = b.position_id
where a.max_salary > 79000;


-- page 580
-- Send this to students
create table ship_cabin_grid
( room_type     varchar2(20)
, ocean         number
, balcony       number
, no_window     number);

begin
  insert into ship_cabin_grid values ('ROYAL', 1745,1635, null);
  insert into ship_cabin_grid values ('SKYLOFT', 722,72235, null);
  insert into ship_cabin_grid values ('PRESIDENTIAL', 1142,1142, 1142);
  insert into ship_cabin_grid values ('LARGE', 225,null, 211);
  insert into ship_cabin_grid values ('STANDARD', 217,554, 586);
end;
/
truncate table ship_cabin_grid; 

insert all
    when ocean is not null then
      into ship_cabin_statistics (room_type, window_type, sq_ft)
      values (room_type, 'OCEAN', ocean)
    when balcony is not null then
      into ship_cabin_statistics (room_type, window_type, sq_ft)
      values (room_type, 'BALCONY', balcony)
    when no_window is not null then
      into ship_cabin_statistics (room_type, window_type, sq_ft)
      values (room_type, 'NO WINDOW', no_window)
select rownum rn, room_type, ocean, balcony, no_window
from ship_cabin_grid;

insert all
    when ocean is not null then
      into ship_cabin_statistics (room_type, window_type, sq_ft)
      values (room_type, 'OCEAN', ocean)
    when balcony is not null then
      into ship_cabin_statistics (room_type, window_type, sq_ft)
      values (room_type, 'BALCONY', balcony)
    when no_window is not null then
      into ship_cabin_statistics (room_type, window_type, sq_ft)
      values (room_type, 'NO WINDOW', no_window)
select rownum rn, room_type, ocean, balcony, no_window
from ship_cabin_grid;


-- page 586
merge into wwa_invoices wwa
  using ontario_orders ont
  on (wwa.cust_po = ont.po_num)
    when matched 
    then update set
        wwa.notes = ont.sales_rep
    delete where wwa.inv_date < to_date('01-SEP-09')
  when not matched then insert
    (wwa.inv_id, wwa.cust_po, wwa.inv_date, wwa.notes)
  values
  (seq_inv_id.nextval,ont.po_num, sysdate, ont.sales_rep)
where substr(ont.po_num,1,3) <> 'NBC';








-- page 589
create table chat
  ( chat_id     number(11) primary key,
   chat_user    varchar2(9),
   yacking      varchar2(40));
drop table chat;

drop sequence seq_chat_id;
create sequence seq_chat_id;

begin
    insert into chat values (seq_chat_id.nextval, user, 'Hi there.');
    insert into chat values (seq_chat_id.nextval, user, 'Welcome to our chat room.');
    insert into chat values (seq_chat_id.nextval, user, 'Online order form is up.');
    insert into chat values (seq_chat_id.nextval, user, 'Over and out.');
    commit;
end;
/

-- page 589
select chat_id, ora_rowscn, scn_to_timestamp(ora_rowscn)
from chat;

-- page 590
delete from chat;
commit;

select * from chat;

-- page 593
select chat_id, chat_user, yacking
from chat
as of timestamp systimestamp - interval '0 0:06:30' day to second;
--minus
--select chat_id, chat_user, yacking
--from chat;

--as system
select name, value
from v$system_parameter
where name like ('undo%');
--undo_management	AUTO
--undo_tablespace	undo
--undo_retention	900

-- page 595
select chat_id, versions_startscn, versions_endscn, versions_operation
from chat
versions between timestamp minvalue and maxvalue
order by chat_id, versions_operation desc;

--page 596
select chat_id, versions_startscn, versions_endscn, versions_operation
from chat
versions between timestamp minvalue
and maxvalue
as of timestamp systimestamp - interval '0 00:1:30' day to second
order by chat_id, versions_operation desc;

-- page 598 middle
select chat_id, versions_operation, rawtohex(versions_xid)
from chat
versions between timestamp minvalue and maxvalue
where chat_id = 49
order by versions_operation desc;

select * from chat;
delete chat;

-- page 598 bottom
select undo_sql
from flashback_transaction_query
where xid = (select versions_xid
              from chat
              versions between timestamp minvalue
              and maxvalue
             where chat_id = 49
              and versions_operation = 'D');\
              
-- =============================================================================
-- Chapter 16
-- =============================================================================

select * from employee_chart;

-- page 622
-- -----------------------------------------------------------------------------
-- top down
-- ------------------------------------
select level, employee_id,title
from employee_chart
start with employee_id = 1
connect by reports_to = prior employee_id;
-- ------------------------------------
-- bottom up
-- ------------------------------------
select level, employee_id,title
from employee_chart
start with employee_id = 5
connect by prior reports_to = employee_id;



select level, reports_to, employee_id,title
from employee_chart
start with employee_id = 1
connect by reports_to = prior employee_id;


select level, reports_to, employee_id,title
from employee_chart
start with employee_id = 9
connect by prior reports_to = employee_id;

select level, reports_to, employee_id, LPAD(' ', Level*2) || title title_up
from employee_chart
start with employee_id = 1
connect by reports_to = prior employee_id
order by title;

-- page 624

select level, reports_to, employee_id, LPAD(' ', Level*2) || title title_up
from employee_chart
start with employee_id = 1
connect by reports_to = prior employee_id
order siblings by title;

-- page 625 top
select level, employee_id, sys_connect_by_path(title,'/') title
from employee_chart
start with employee_id = 1
connect by reports_to = prior employee_id;
order siblings by title;

-- page 625 bottom
select level, employee_id, title, connect_by_root title as ancestor
from employee_chart
start with employee_id = 2
connect by reports_to = prioremployee_id;

-- page 626 bottom
select level, employee_id, LPAD(' ', Level*2) || title title
from employee_chart
start with employee_id = 1
connect by reports_to = prior employee_id
  and employee_id <> 3;


select level, employee_id, lpad(' ', level*2) || title title
from employee_chart
where employee_id not in (6)
start with employee_id = 1
connect by reports_to = prior employee_id
  and employee_id <> 3;



-- page 627 top
select level, employee_id, LPAD(' ', Level*2) || title title
from employee_chart
start with employee_id = 1
connect by reports_to = prior employee_id
  and title <> 'SVP';

-- page 627 bottom
select level, employee_id, LPAD(' ', Level*2) || title title
from employee_chart
where employee_id in (select employee_id from employees2)
start with employee_id = 1
connect by reports_to = prior employee_id
  and title <> 'SVP';

-- -----------------------------------------------------------------------------
-- HANDS ON EXERCISES 16
-- -----------------------------------------------------------------------------
select * from jobs2;
select * from directories;
select * from files;

-- 1.
-- What is the root directory for job_id = 104;
select * from jobs2 where job_id = 104;
select * from directories where job_id = 104;

select min(directory_id) from directories where job_id = 104;
-- 2.
-- Using a subquery to determine root of job 104 
-- create a simple hierarchical listing of directories without padding
-- or formatting
select level, directory_id, directory_name
from directories
start with directory_id = 11631
connect by parent_id= prior directory_id ;

select level, directory_id, lpad(' ', Level*2) || directory_name
from directories
start with directory_id = (select min(directory_id) from directories where job_id = 104)
connect by parent_id = prior directory_id;

select level, directory_id, parent_id, lpad(' ', Level*2) || directory_name
from directories
start with directory_id = (select min(directory_id) from directories where job_id = 104)
connect by parent_id = prior directory_id;
-- 3. 
-- Add LPAD formatting to show the levels
select level, directory_id, LPAD(' ', Level*2) || directory_name directory
from directories
start with directory_id = (select min(directory_id) from directories where job_id = 104)
connect by parent_id = prior directory_id
order siblings by directory_name;
-- 4.
-- Show the path for each directory using the "/"
-- Add LPAD formatting to show the levels
select level, directory_id, parent_id,lpad(' ', level*2) || 
       sys_connect_by_path(directory_name,'/') directory
from directories
start with directory_id = (select min(directory_id) from directories where job_id = 104)
connect by parent_id = prior directory_id;
-- 5.
-- List all files under directory /GPS/PDMT_Configs/Configuration in job 104
        select level, job_id, directory_id, sys_connect_by_path(directory_name,'/') directory
        from directories
        start with directory_id = (select min(directory_id) from directories where job_id = 104)
        connect by parent_id = prior directory_id;
select *
from files f
     ,(
        select level, job_id, directory_id, sys_connect_by_path(directory_name,'/') directory
        from directories
        start with directory_id = (select min(directory_id) from directories where job_id = 104)
        connect by parent_id = prior directory_id
       ) d
where d.directory = '/GPS/PDMT_Configs/Configuration'
  and d.job_id = f.job_id
  and d.directory_id = f.directory_id;

-- 6.
-- Which directory id has the most files in it
select d.directory_id, d.directory_name, count(f.f1)
from files f, directories d
where f.job_id = d.job_id
  and f.directory_id = d.directory_id
group by d.directory_id, d.directory_name
order by 3 desc; 

-- directories under this one
select level, directory_id, LPAD(' ', Level*2) || sys_connect_by_path(directory_name,'/') directory
from directories
start with directory_id = 11719
connect by parent_id = prior directory_id;

-- just directories over this one
-- Backwards
select directory_id from
      (
        select level lvl, directory_id, LPAD(' ', Level*2) || sys_connect_by_path(directory_name,'<') directory
        from directories
        start with directory_id = 11719
        connect by prior parent_id = directory_id
      );

-- Forwards with set placed manually
select level, directory_id, LPAD(' ', Level*2) || sys_connect_by_path(directory_name,'/') directory
from directories
start with directory_id = 11631
connect by parent_id = prior directory_id
  and directory_id in (11631, 11712, 11719);

-- Forwards with set placed manually where clause level 3
select level, directory_id, LPAD(' ', Level*2) || sys_connect_by_path(directory_name,'/') directory
from directories
where directory_id in (11631, 11712, 11719)
and level = 3
start with directory_id = 11631
connect by parent_id = prior directory_id;


-- solution
select level, directory_id, lpad(' ', level*2) || sys_connect_by_path(directory_name,'/') directory
from directories
where directory_id in (11631, 11712, 11719)
and level = (
            select max(lvlv) from(
              select level lvlv, sys_connect_by_path(directory_name,'/') directory
              from directories
              where directory_id in (11631, 11712, 11719)
              start with directory_id = 11631
              connect by parent_id = prior directory_id
              )
             ) 
start with directory_id = 11631
connect by parent_id = prior directory_id;


select lvl1, directory from 
            (
            select level lvl1, directory_id, LPAD(' ', Level*2) || sys_connect_by_path(directory_name,'/') directory
            from directories
            start with directory_id = 11631
            connect by parent_id = prior directory_id
              and directory_id in (11631, 11712, 11719)
            ) a,
            (
            select max(lvl2) maxlvl2 from
                (  
                select level lvl2, directory_id, LPAD(' ', Level*2) || sys_connect_by_path(directory_name,'/') directory
                from directories
                start with directory_id = 11631
                connect by parent_id = prior directory_id
                  and directory_id in (11631, 11712, 11719)
                )
            ) b
where a.lvl1 = b.maxlvl2;

-- Forwards with subquery
select level, directory_id, LPAD(' ', Level*2) || sys_connect_by_path(directory_name,'/') directory
from directories
start with directory_id = 11631
connect by parent_id = prior directory_id
  and directory_id in (select directory_id from
                            (
                              select directory_id
                              from directories
                              start with directory_id = 11719
                              connect by prior parent_id = directory_id
                            )
                      )
;

select lvl, directory_id, directory
from
    (
      select level lvl, directory_id, LPAD(' ', Level*2) || sys_connect_by_path(directory_name,'/') directory
      from directories
      start with directory_id = 11631
      connect by parent_id = prior directory_id
        and directory_id in (select directory_id from
                                  (
                                    select directory_id
                                    from directories
                                    start with directory_id = 11719
                                    connect by prior parent_id = directory_id
                                  )
                            )
    ) a,
    (
    select max(level_1) max_lvl
    from
        (  
            select level level_1, directory_id, LPAD(' ', Level*2) || sys_connect_by_path(directory_name,'/') directory
            from directories
            start with directory_id = 11631
            connect by parent_id = prior directory_id
              and directory_id in (select directory_id from
                                        (
                                          select directory_id
                                          from directories
                                          start with directory_id = 11719
                                          connect by prior parent_id = directory_id
                                        )
                                  )
        )
    ) b
where a.lvl = b.max_lvl;
;

-- =============================================================================
-- Chapter 17
-- =============================================================================
-- run parksRegex tutorial
-- simpliest pattern is exact duplicate
select * from park
where park_name='Mackinac Island State Park';














-- next level of complexity is like (entire column)
select park_name
from park
where park_name LIKE '%State Park%';





-- regexp_like more powerful (anyplace in column)
select park_name, regexp_substr(park_name, 'State Park') 
from park
where regexp_like(park_name, 'State Park');









-- lets see if we can find phone numbers
select park_name,regexp_substr(DESCRIPTION, '...-....')
from PARK
where regexp_like(DESCRIPTION, '...-....');






select park_name, regexp_substr(description, '...-....')
from PARK
where regexp_like(description, '...-....');


select park_name, regexp_substr(description, '.{3}-.{4}')
from park
where regexp_like(description, '.{3}-.{4}');




-- See false positives
select description, park_name
from park
where regexp_like(description, '...-....')
and (park_name like '%Mus%' or park_name like '%bofj%');



-- zoom in on false positives
select regexp_substr(description, '...-....'), park_name
from park
where regexp_like(description, '...-....')
and (park_name like '%Mus%' or park_name like '%bofj%');


-- a list of characters
select park_name, regexp_substr(description,'[0123456789]{3}-[0123456789]{4}')
from park
where regexp_like(description,'[0123456789]{3}-[0123456789]{4}');



-- a range of characters
select park_name,regexp_substr(description, '[0-9]{3}-[0-9]{4}') 
from park
where regexp_like(description, '[0-9]{3}-[0-9]{4}');




select regexp_count('The shells she sells are surely seashells', 'el') as regexp_count from dual;







-- a character class
select park_name,regexp_substr(description, '[[:digit:]]{3}-[[:digit:]]{4}')
from park
where regexp_like(description, '[[:digit:]]{3}-[[:digit:]]{4}');





-- caret ^ is the "NOT" operator
-- so this says anything that is NOT a digit
select park_name,regexp_substr(description, '[[:digit:]]{3}[^[:digit:]][[:digit:]]{4}')
from park
where regexp_like(description, '[[:digit:]]{3}[^[:digit:]][[:digit:]]{4}');   


-- escape character "\" if we want to find a period and not have the period
-- represent any character but instead a period
-- this finds phone numbers that have either a period separating the groups

select park_name,regexp_substr(description, '[[:digit:]]{3}\.[[:digit:]]{4}')
from park
where regexp_like(description, '[[:digit:]]{3}\.[[:digit:]]{4}');


-- subexpresssions show how quantifiers can be used in multiple places
select park_name,regexp_substr(description, '\+([0-9]{1,3} ){1,4}([0-9]+)') INTL_PHONE
from PARK
where regexp_like(description, '\+([0-9]{1,3} ){1,4}([0-9]+)');






-- alternation (using an OR like symbol "|" single pipe
select park_name, regexp_substr(description,'[[:digit:]]{3}-[[:digit:]]{4}|[[:digit:]]{3}\.[[:digit:]]{4}')
from park
where regexp_like(description,'[[:digit:]]{3}-[[:digit:]]{4}|[[:digit:]]{3}\.[[:digit:]]{4}');


-- concise alternation
select park_name, regexp_substr(description,'[[:digit:]]{3}(-|\.)[[:digit:]]{4}')
from park
where regexp_like(description,'[[:digit:]]{3}(-|\.)[[:digit:]]{4}');


-- this is area code with () or dashes or periods
select park_name,regexp_substr (description, '([[:digit:]]{3}[-.]|\([[:digit:]]{3}\) )[[:digit:]]{3}[-.][[:digit:]]{4}')
    park_phone
from park
where regexp_like (description, '([[:digit:]]{3}[-.]|\([[:digit:]]{3}\) )[[:digit:]]{3}[-.][[:digit:]]{4}');


-- back references
select park_name, regexp_substr(description,
         '(^|[[:space:][:punct:]]+)([[:alpha:]]+)'
         || '[[:space:][:punct:]]+\2'
         || '($|[[:space:][:punct:]]+)') doubled_word
from park
where regexp_like(description,
         '(^|[[:space:][:punct:]]+)([[:alpha:]]+)'
         || '[[:space:][:punct:]]+\2'
         || '($|[[:space:][:punct:]]+)');



-- -----------------------------------------------------------------------------
-- REGEX_LIKE
-- find records that have invoice dates between 2010 and 2011
select invoice_id, invoice_date
from invoices_revised
where regexp_like (TO_CHAR(INVOICE_DATE,'YYYY'), '^201[0-1]$');





-- find records were first name is J ignore the case
select * from employees2;

select * 
from employees2
where regexp_like(first_name, '^j', 'i');




-- -----------------------------------------------------------------------------
-- REGEX_SUBSTR
-- return records that have tele in f8
select regexp_substr(f8, 'Tele[[:alpha:]]+',1,1,'i')
from files
where regexp_like(f8, 'Tele[[:alpha:]]+');

-- return records that have UCS in f8
select file_id, f8, regexp_substr(f8, 'UC[[:alpha:]]',1,1,'i') 
from files 
where regexp_like(f8, 'UCS', 'i');
-- -----------------------------------------------------------------------------
-- REGEX_INSTR
-- return the locaiton of "l" + 4 letters

select regexp_instr('But, soft! What light through yonder window breaks?','l[[:alpha:]]{4}') as result
from dual;

-- return the location of the second "soft"
select regexp_instr('But, soft! What light through yonder window softly breaks?', 's[[:alpha:]]{3}', 1, 2) as result
from dual;

-- start at position 10 then return location of the second occurance of "o"
select regexp_instr ('But, soft! What light through yonder window breaks?','o', 10, 2) as result from dual;





-- return location of "Tele"
select file_id, f8, regexp_instr(f8, 'Tele[[:alpha:]]+',1,1,0,'i') from files where upper(f8) like '%TELE%';







-- return location of UCS
select file_id, f8, regexp_instr(f8, 'UC[[:alpha:]]*',1,1,0,'i') from files where upper(f8) like '%UCS%';

-- -----------------------------------------------------------------------------
-- REGEX_REPLACE
select * from files;

-- replace the word "light" with "sound"
select regexp_replace('But, soft! What light through yonder window breaks?','l[[:alpha:]]{4}', 'sound') as result
from dual;

-- replace Telepresence with TelePresence
select REGEXP_SUBSTR(F8, 'Tele[[:alpha:]]+',1,1,'i'),REGEXP_replace(F8, 'Tele[[:alpha:]]+','TelePresence'), f8
from FILES where UPPER(F8) like '%TELEPR%';

-- Replace "UCS" with "UCS-"
select regexp_substr(f8, 'UC[[:alpha:]]+',1,1,'i'),regexp_replace(f8, 'UCS[[:alpha:] ]','UCS-'), f8
from files where upper(f8) like '%UCS%';




-- -----------------------------------------------------------------------------
-- BOOK
-- page 645
select regexp_substr('123 Maple Avenue', '[a-z]') address
from dual;


-- page 646 top
select regexp_substr('123 Maple Avenue', '[A-Za-z]') address
from dual;



-- page 646 middle
select regexp_substr('123 Maple Avenue this is a long sentence', '[A-Za-z ]+') address
from dual;



-- page 646 bottom
select regexp_substr('123 Maple Avenue', '[[:alpha:] ]+') address
from dual;




-- page 647 top
select regexp_substr('123 Maple Avenue', '[:alpha:]+') address
from dual;






-- page 647 bottom
select regexp_substr('123 Maple Avenue ', '[[:alpha:]]+', 1, 2) address
from dual;










-- page 648 top
select regexp_substr('123 Maple Avenue', '[[:alnum:]]+') address
from dual;








-- page 648 middle
select address2, regexp_substr(address2,'[[:digit:]]+') zip_code
from order_addresses;




-- page 648 bottom
select regexp_substr('123 Maple Avenue', 'Maple') address
from dual;



-- page 649 top
select regexp_substr('she sells sea shells down by the seashore','s[eashor]+e',1,2) the_result
from dual;

-- page 649 middle
select regexp_substr('she sells sea shells down by the seashore','s(eashor)e' ) the_result
from dual;

-- page 649 bottom 1
select regexp_substr('she sells sea shells down by the seashore','seashore' ) the_result
from dual;

-- page 649 bottom 2
select regexp_substr('she sells sea shells down by the seashore','[[:alpha:]]+(shore)' ) the_result
from dual;


-- page 650 middle
select address2, regexp_substr(address2,'(TN|MD|OK)') state
from order_addresses;

select address2, regexp_substr(address2,'(TN|MD|OK)') state
from order_addresses
where regexp_like(address2,'(TN|MD|OK)');



-- page 650 bottom
select regexp_substr('Help desk: (212) 555-1212', '([[:digit:]]+)') area_code
from dual;


-- page 651 top
select regexp_substr('Help desk: (212) 555-1212', '\([[:digit:]]+\)') area_code
from dual;






-- page 651 middle
select address2, regexp_substr(address2,'[TBH][[:alpha:]]+') name
from order_addresses;

select address2, regexp_substr(address2,'[TBH][[:alpha:]]+') name
from order_addresses
where regexp_like(address2,'[TBH][[:alpha:]]+') ;



-- page 652 top
select regexp_substr('BMW-Oracle;Trimaran;February 2010', '[^;]+', 1, 2) americas_cup
from dual;



-- page 652 middle

select address2, regexp_substr(address2,'[37]+$') last_digit
from order_addresses;



where regexp_like(address2,'[37]+$');

select address2, regexp_substr(address2,'[59]+$') last_digit
from order_addresses
where regexp_like(address2,'[59]+$') ;





-- page 653 top 
select address2, regexp_substr(address2,'37$') last_digit
from order_addresses;

select address2, regexp_substr(address2,'(83|78|1|2)$') last_digit
from order_addresses
where regexp_like(address2,'(83|78|1|2)$');




-- page 654 top
select regexp_replace('Chapter 1 ......................... I Am Born','[.]+','-') toc
from dual;

select regexp_replace('Chapter 1 ......................... I Am Born','[.]','-') toc
from dual;










-- page 654 middle
select regexp_replace('And then he said *&% so I replied with $@($*@','[!@#$%^&*()]','-') prime_time
from dual;

-- page 654 bottom
select regexp_replace('And then he said *&% so I replied with $@($*@','[!@#$%^&*()]+','-') prime_time
from dual;







-- page 655 top
select regexp_replace('and    in     conclusion,       2/3rds of our      revenue ','( ){2,}', ' ') text_line
from dual;






-- page 655 bottom
select address2,regexp_replace(address2, '(^[[:alpha:]]+)', 'CITY') the_string
from order_addresses
where rownum <= 5;






-- page 656 middle
select address2, regexp_replace(address2, '(^[[:alpha:] ]+)', 'CITY') the_string
from order_addresses
where rownum <= 5;


select address2 
from order_addresses
where rownum <= 5;


-- page 657 
select address2, regexp_replace(address2, '(^[[:alpha:] ]+), ([[:alpha:]]{2}) ([[:digit:]]{5})','\3 \2 \1') the_string
from order_addresses
where rownum <= 5;




-- page 658 middle
select address2,regexp_replace(address2,'(^[[:alpha:] ,]+) ([[:alpha:]]{2}) ([[:digit:]]{5})','\3 \2 \1') the_string
from order_addresses
where rownum <= 5;

-- page 658 bottom
select address2, regexp_replace(address2, '(^[[:alpha:] ]+), ([[:alpha:]]{2}) ([[:digit:]]{5})', '\3 \2-"\1"') the_string
from order_addresses
where rownum <= 5;




select regexp_substr('this is a (string of .. 567)','\([^)]+\)' ) from dual;


select regexp_substr('S Elton John','Sir +') from dual;




