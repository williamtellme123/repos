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
ALTER TABLE cruises3 MODIFY cruise_id CONSTRAINT cruises_cruiseid_pk PRIMARY KEY;
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
CREATE TABLE supplier2
  (
    supplier_id   NUMERIC(10),
    supplier_name VARCHAR2(50),
    contact_name  VARCHAR2(50),
    CONSTRAINT supplier_pk PRIMARY KEY (supplier_id, supplier_name)
  );
DROP TABLE supplier;
/* -----------------------------------------------------------------------------
4. create table products2
a.) same fields as products
b.) foreign key matches composite primary key in supplier2
NOTE: all constraints must be named by programmer
*/
a.) product_id
IS
  the PRIMARY KEY can hold 10 digits b.) supplier_id
IS
  FK TO supplier c.) supplier_name can hold 50 letters AND cannot be NULL NOTE: ALL CONSTRAINTS must be NAMED BY programmer
CREATE TABLE products2
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
from ships  join ports
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
from ships left outer join ports
  on home_port_id = port_id
order by ship_id;

-- page 319 bottom
select ship_id, ship_name, port_name
from ships right join ports
  on home_port_id = port_id
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
from ports p join ships s on p.port_id = s.home_port_id             
            join ship_cabins sc using (ship_id);


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

select * from customers;
select * from customers c join customers c1 on c.customer# = c1.referred;


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
-- 1. List employee's ID and name and address, city, state,zip with new join syntax and keyword "ON"
--    Use table aliases for all returned columns where possible
select e.employee_id, e.first_name, e.last_name from employees e;
select a.employee_id, a.street_address, a.city, a.state, a.zip from addresses a;
select e.employee_id, e.first_name, e.last_name, a.street_address, a.city, a.state, a.zip 
 from employees e join addresses a on e.employee_id = a.employee_id;
 
-- 2. Repeat question 1 with the keyword "USING"
--    Use table aliases for all returned columns where possible
select employee_id, e.first_name, e.last_name, a.street_address, a.city, a.state, a.zip 
 from employees e join addresses a using(employee_id);
 
-- 3. List cruise_name and captains ID, captains name address, city, state,zip with new join syntax and keyword "ON"
select e.employee_id, e.first_name, e.last_name, a.street_address, a.city, a.state, a.zip 
 from employees e join addresses a on e.employee_id = a.employee_id;


-- 4. Repeat question 3 using keyword "USING"
select employee_id, e.first_name, e.last_name, a.street_address, a.city, a.state, a.zip 
 from employees e join addresses a using (employee_id);

-- 5. Update cruises set captain_id = 3;
update cruises set captain_id = 3;
commit;

-- 6. Return Cruise name and ID with captains employee id, first and last names, street, city, state, zip (join on);
select * from addresses;
select * from employees;
select * from cruises;
select c.cruise_name, c.cruise_id, e.employee_id, e.first_name, e.last_name, a.street_address, a.city, a.state, a.zip 
 from employees e join addresses a on e.employee_id = a.employee_id
                  join cruises c on e.employee_id = c.captain_id;


-- 7 return captains name
select c.cruise_name, c.cruise_id, e.employee_id, e.first_name, e.last_name, a.street_address, a.city, a.state, a.zip 
 from employees e join addresses a on e.employee_id = a.employee_id
                  join cruises c on e.employee_id = c.captain_id;

-- 7 Return captains name, city, state, and start date, along with ship_name, cruise_name, and port_name for cruise_id = 2
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
select port_name, to_char(sum(project_cost),'$999,999,999') total,  to_char(avg(project_cost),'$999,999') avg, count(*) numberprojects, sum(days)*40 manhours 
from ports p  join ships s on p.port_id = s.home_port_id
              join projects pj on s.ship_id = pj.ship_id
where port_name = 'Baltimore'
group by port_name;

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

-- Letter grade       Score Range
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

