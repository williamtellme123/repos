-- -----------------------------------------------------------------------------
-- C2:  200
-- C3:  700
-- C4:  1200 
-- C5:  1400
-- C6:  1600
-- C7:  1900
-- C8:  2200 
-- C9:  2800
-- C10: 3600 
-- C11: 4000
-- C12: 4400
-- C13: 4500
-- C14: 5200
-- C15: 5400
-- C16: 6100  
-- C17: 6500
-- C18: n/a
-- -----------------------------------------------------------------------------

REM KAPLAN HIERARCHICAL PRODUCTS TABLE EXAMPLE ---------------------------------
REM TABLE CREATION & ROW INSERTIONS
DROP TABLE PRODUCTS2;
CREATE TABLE PRODUCTS2
(
PRODUCTIDVARCHAR2(4) PRIMARY KEY ,
PRODUCTTYPEVARCHAR2(15) ,
PRODUCTCOSTNUMBER ,
PRODUCTBRANDID VARCHAR2(4)
);
DELETE FROM PRODUCTS2;
INSERT INTO PRODUCTS2 VALUES
( 'P001', 'COSMETICS', 100, NULL
);
INSERT INTO PRODUCTS2 VALUES
( 'P002', 'COSMETICS', 100, 'P001'
);
INSERT INTO PRODUCTS2 VALUES
( 'P003', 'GARMENT', 100, 'P002'
);
INSERT INTO PRODUCTS2 VALUES
( 'P004', 'FOOTWEAR', 100, 'P002'
);
INSERT INTO PRODUCTS2 VALUES
( 'P005', 'COSMETICS', 100, 'P003'
);
SELECT * FROM PRODUCTS2 ORDER BY PRODUCTID;
REM -------- THE TEST QUERY ---------
SELECT PRODUCTID,
PRODUCTTYPE,
PRODUCTCOST,
PRODUCTBRANDID ,
SYS_CONNECT_BY_PATH(PRODUCTID,'>') PATH
FROM PRODUCTS2
START WITH PRODUCTID = 'P002'
CONNECT BY PRODUCTID = PRIOR PRODUCTBRANDID;
REMTHIS VERSION OF THE QUERY DOES NOT ANSWER THE QUESTION :
REMHOW MANY ANCESTORS / SUPERIORS DOES ID = 'P005' HAVE?
REMTHE "CONNECT BY" CLAUSE POINTS IN THE WRONG DIRECTION.
REMA MORE APPROPRIATE VERSION OF THE QUERY SHOULD BE AS FOLLOWS.
SELECT LEVEL,
LPAD(' ', 2*(LEVEL-1))
|| PRODUCTID "PRODUCT ID",
PRODUCTTYPE,
PRODUCTCOST,
PRODUCTBRANDID ,
SYS_CONNECT_BY_PATH(PRODUCTID,'>') PATH
FROM PRODUCTS2
START WITH PRODUCTID= 'P002'
CONNECT BY PRODUCTBRANDID = PRIOR PRODUCTID
ORDER SIBLINGS BY PRODUCTID;
COMMIT;
REMI BELIVE THAT A CLEARER QUESTION WOULD HAVE USED A COLUMN NAME LIKE 'POINTS_TO_PRODUCTID'
REMAS IN "CONNECT BY POINTS_TO_PRODUCTID = PRIOR PRODUCTID"
REMTHEN IT WOULD BE OBVIOUS WHEN THE CONNECT BY CLAUSE IS POINTED IN THE WRONG DIRECTION.
DROP TABLE products2;
CREATE TABLE products2
(
productidVARCHAR2(4) PRIMARY KEY ,
producttypeVARCHAR2(15) ,
productcostNUMBER ,
productbrandid VARCHAR2(4)
);
DELETE FROM products2;
BEGIN
INSERT INTO products2 VALUES
( 'P001', 'COSMETICS', 100, NULL
);
INSERT INTO products2 VALUES
( 'P002', 'COSMETICS', 100, 'P001'
);
INSERT INTO products2 VALUES
( 'P003', 'GARMENT', 100, 'P002'
);
INSERT INTO products2 VALUES
( 'P004', 'FOOTWEAR', 100, 'P002'
);
INSERT INTO products2 VALUES
( 'P005', 'COSMETICS', 100, 'P003'
);
INSERT INTO products2 VALUES
( 'P006', 'COSMETICS', 100, 'P003'
);
INSERT INTO products2 VALUES
( 'P007', 'COSMETICS', 100, 'P003'
);
INSERT INTO products2 VALUES
( 'P008', 'COSMETICS', 100, 'P004'
);
INSERT INTO products2 VALUES
( 'P009', 'COSMETICS', 100, 'P004'
);
COMMIT;
END;
/
-- hierarchical
SELECT productid ,
producttype ,
productcost ,
productbrandid ,
sys_connect_by_path(productid,'>') path
FROM products2
-- where productid != 'P004'
START WITH productid= 'P002'
CONNECT BY productbrandid = prior productid
AND productid!= 'P004';
SELECT room_style,
room_type,
SUM(sq_ft)
FROM ship_cabins
WHERE ship_id = 1
GROUP BY grouping sets (room_style, (room_type, window));
SELECT room_style movie_id,
room_type location,
window MONTH,
SUM(sq_ft)
FROM ship_cabins
WHERE ship_id = 1
AND ship_cabin_id BETWEEN 4 AND 7
GROUP BY room_style,
room_type,
rollup(window);
SELECT room_style,
room_type,
window,
SUM(sq_ft)
FROM ship_cabins
WHERE ship_id = 1
GROUP BY room_style,
room_type,
window;
-- hierarchical
SELECT productid ,
producttype ,
productcost ,
productbrandid ,
sys_connect_by_path(productid,'>') path
FROM products2
-- where productid != 'P004'
START WITH productid = 'P002'
CONNECT BY productid = prior productbrandid
AND productid != 'P004';
SELECT regexp_replace('Heardir Anthony','Sir .','|') FROM dual;
SELECT regexp_instr('Maeny','a?') FROM dual;
SELECT regexp_instr('2009-October-09','\A\d{4}?-\w{3,9}?-\d{2}?') a FROM dual;
SELECT regexp_instr('-','\A\d?{4}-') a FROM dual;
SELECT regexp_instr('Dad','^(D|d)[[:alpha:]]{3,}d$') a FROM dual;
SELECT regexp_substr('12345X','^\d{5}(X|Y|Z)$',1) a FROM dual;
SELECT regexp_substr('12345XYX','^\d{5}[XYTYZ]+$',1) a FROM dual;






























-- =============================================================================
-- Chapter 2
-- =============================================================================
-- Page 50 (2/1)
CREATE TABLE work_schedule1
(
work_schedule_id NUMBER,
start_date DATE,
end_date DATE,
CONSTRAINT work_schedule_pk PRIMARY KEY(work_schedule_id)
);
INSERT
INTO work_schedule1
(
work_schedule_id,
start_date,
end_date
)
VALUES
(
4,
to_date('05-DEC-11','DD-MM-YY'),
sysdate
);
SELECT * FROM work_schedule1;
CREATE TABLE mytest
(
id INTEGER,
t1 TIMESTAMP(2),
t2 TIMESTAMP(2)
WITH TIME zone, t3 TIMESTAMP(2)
WITH local TIME zone
);
TRUNCATE TABLE mytest;
INSERT INTO mytest
(id, t1, t2, t3
) VALUES
(1, sysdate, sysdate,sysdate
);
INSERT INTO mytest VALUES
(1, sysdate, sysdate,sysdate
);
INSERT INTO mytest
(id, t1
) VALUES
(1, sysdate
);
SELECT * FROM MYTEST;
DROP TABLE mytest;
SELECT * FROM mytest;
DROP TABLE work_schedule1;
DESC work_schedule1;
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
CREATE TABLE CRUISES2
(
CRUISE_IDNUMBER,
cruise_type_id NUMBER,
CRUISE_NAMEVARCHAR2(20),
ship_idNUMBER(7,0),
captain_id NUMBER NOT NULL,
start_date DATE,
end_date DATE,
status VARCHAR2(5 byte) DEFAULT 'DOCK',
CONSTRAINT pk_cruises2 PRIMARY KEY (cruise_id)
);
DESC cruises2;
DROP TABLE cruises2;
SELECT * FROM user_constraints WHERE table_name = 'CRUISES2';
DESC cruises2;
DROP TABLE cruises2 CASCADE CONSTRAINTS;
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
cruise_id NUMBER,
cruise_name VARCHAR2(20),
CONSTRAINT pk_cruises3 PRIMARY KEY (cruise_id)
);
DROP TABLE cruises3;
insert into cruises3 values (3333, 'alpha' );
SELECT * FROM cruises3;
INSERT INTO cruises3 VALUES (33, 'alpha' );
SELECT * FROM cruises3;
INSERT INTO cruises3 VALUES (33.56, 'alpha' );
SELECT * FROM cruises3;
insert into cruises3 values (33.566, 'alpha' );
SELECT * FROM cruises3;
INSERT INTO cruises3 VALUES (33.566, 'alpha1' );
insert into cruises3 values (33.566, 'alpha' );
INSERT INTO cruises3 (cruise_name) VALUES ('alpha' );
SELECT * FROM cruises3;
SELECT * FROM cruises3;
DROP TABLE cruises3;
-- Page 63 (2/7)
/* =============================================================================
SELECT sys_context('USERENV', 'NLS_DATE_FORMAT') FROM DUAL;
-- ----------------------------------------------------------------------------
*/
-- C2 Page 64 (2/7)
/* =============================================================================
1. Copy cruises 3 from above
2. Rename to cruises4
3. Delete all except
CREATE TABLE cruises4
( date1 date,
date2 timestamp,
date3 timestamp with time zone,
date4 timestamp with local time zone
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
INSERT INTO cruises4 VALUES (sysdate,sysdate,sysdate,sysdate );
SELECT * FROM cruises4;
-- Page 67 (2/9)
/* =============================================================================
1. Copy cruises 3 from above
CREATE TABLE cruises3
( cruise_id NUMBER (4,2),
cruise_name VARCHAR2(5)
);
2. drop table cruises3
3. create anonymous primary key in line
CREATE TABLE cruises3
( cruise_id integer primary key,
cruise_name VARCHAR2(5)
);
4. drop table cruises3;
5. create named primary key in line
CREATE TABLE cruises3
( cruise_id integer constraint cruises3_pk primary key,
cruise_name VARCHAR2(5)
);
6. drop table cruises3;
7. create primary key out of line
CREATE TABLE cruises3
( cruise_id integer ,
cruise_name VARCHAR2(5),
constraint cruises3_pk primary key (cruise_id)
);
8. drop table cruises3;
*/
DROP TABLE cruises3;
CREATE TABLE cruises3
(
cruise_id INTEGER PRIMARY KEY,
cruise_name VARCHAR2(5)
);
CREATE TABLE cruises3
(
cruise_id INTEGER CONSTRAINT cruises3_pk PRIMARY KEY,
cruise_name VARCHAR2(5)
);
CREATE TABLE cruises3
(
cruise_id NUMBER,
cruise_name VARCHAR2(20),
CONSTRAINT pk_cruises3 PRIMARY KEY (cruise_id)
);
CREATE TABLE cruises3
( cruise_id INTEGER, cruise_name VARCHAR2(5)
);
DROP TABLE cruises3;
ALTER TABLE cruises3 MODIFY cruise_name NOT NULL;
ALTER TABLE cruises3 MODIFY cruise_name CONSTRAINT cruise_name_nn NOT NULL;
DROP TABLE cruises3;
ALTER TABLE cruises3 MODIFY cruise_id PRIMARY KEY;
ALTER TABLE cruises3 MODIFY cruise_id CONSTRAINT cruises3_pk PRIMARY KEY;
DROP TABLE cruises3;
CREATE TABLE cruises3
(
cruise_id INTEGER ,
cruise_name VARCHAR2(5),
CONSTRAINT cruises3_pk PRIMARY KEY (cruise_id)
);
-- Page 69 (2/9)
/* =============================================================================
1. Copy cruises 3 from above
CREATE TABLE cruises3
( cruise_id NUMBER (4,2),
cruise_name VARCHAR2(5)
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
CREATE TABLE ports2
(
port_id NUMBER,
port_name VARCHAR2(20),
country VARCHAR2(40),
capacityNUMBER,
CONSTRAINT pk_port2 PRIMARY KEY(port_id)
);
DROP TABLE ports2;
CREATE TABLE ships2
(
ship_idNUMBER,
ship_nameVARCHAR2(20),
home_port_id NUMBER,
CONSTRAINT fk_ships2_ports FOREIGN KEY (home_port_id) REFERENCES ports2(port_id)
);
DROP TABLE ships2;
INSERT INTO ports2 VALUES (1, 'Pearl','USA',50 );
INSERT INTO ships2 VALUES (100,'Badger',1 );
INSERT INTO ports2 VALUES (2, 'Pearl','USA',50 );
INSERT INTO ships2 VALUES (100,'Badger',2 );
COMMIT;
SELECT * FROM ports2;
SELECT * FROM ships2;
DELETE FROM ports2 WHERE port_id = 1;
DELETE FROM ships2 WHERE ship_id = 100;
CREATE TABLE vendors2
(
vendor_id NUMBER,
vendor_name VARCHAR2(20),
statusNUMBER(1) CHECK (status IN (4,5)),
categoryVARCHAR2(5)
);
INSERT INTO VENDORS2 VALUES (1,'SMITH', 5, 'ANY' );
-- =============================================================================
-- HANDS ON ASSIGNMENTS CHAPTER 2
/* -----------------------------------------------------------------------------
HOA C2 1. create table supplier
a.) supplier_id is the primary key can hold 10 digits
b.) supplier_name can hold 50 letters and cannot be null
c.) contact_name can hold 50 letters and can be null
NOTE: all constraints must be named by programmer
*/
CREATE TABLE supplier2
(
supplier_id NUMBER(10),
supplier_name VARCHAR2(50) CONSTRAINT supplier_name_nn NOT NULL,
contact_nameVARCHAR2(50),
CONSTRAINT supplier_supplier_id_pk PRIMARY KEY (supplier_id)
);
drop table supplier2 cascade constraints;


INSERT INTO supplier2 VALUES(1,'ABC','Fred Dobbs' );
INSERT INTO supplier2 VALUES(2,'ACME','Tom Smith' );
DROP TABLE supplier2 CASCADE CONSTRAINTS;
/* -----------------------------------------------------------------------------
HOA C2 2. create table products
a.) product_id is the primary key can hold 10 digits
b.) supplier_id number (used for the foreign key)
c.) product_name can hold 50 letters and cannot be null
d.) WAIT: create a FK to Supplier2 after this table is created
NOTE: all constraints must be named by programmer
*/
CREATE TABLE products
(
product_id NUMBER(10) PRIMARY KEY,
supplier_idNUMBER(10) NOT NULL,
product_name VARCHAR2(50) NOT NULL,
--CONSTRAINT products_supplier_fk FOREIGN KEY (supplier_id) REFERENCES supplier(supplier_id)
);
CREATE TABLE products2
(
product_id NUMBER(10) PRIMARY KEY,
supplier_idNUMBER(10),
product_name VARCHAR2(50) NOT NULL
);
-- references supplier (supplier_id),
DROP TABLE products2 CASCADE CONSTRAINTS;
CREATE TABLE products
(
product_id NUMBER(10) PRIMARY KEY,
supplier_idNUMBER(10) -- CONSTRAINT abc_fk REFERENCES supplier (supplier_id),
product_name VARCHAR2(50) NOT NULL
);
DROP TABLE products;
ALTER TABLE products2 ADD CONSTRAINT prod_supp_supp3_fk FOREIGN KEY (supplier_id) REFERENCES supplier2(supplier_id);
/* -----------------------------------------------------------------------------
HOA C2 3. create table supplier3
a.) same fields as supplier
b.) supplier_id/supplier_name is composite primary key
NOTE: all constraints must be named by programmer
*/
CREATE TABLE supplier3
(
supplier_id NUMBER(10),
supplier_name VARCHAR2(50),
contact_namevarchar2(50),
CONSTRAINT supplier_pk3 PRIMARY KEY (supplier_id, supplier_name)
);
DROP TABLE supplier3 CASCADE CONSTRAINTS;
ALTER TABLE supplier
DROP CONSTRAINT supplier_pk;
SELECT * FROM user_constraints WHERE upper(constraint_name) LIKE '%SUPP%';

/* -----------------------------------------------------------------------------
HOA C2 4. create table products3
a.) same fields as products
b.) foreign key matches composite primary key in supplier2
NOTE: all constraints must be named by programmer
a.) product_id is primary key and can hold 10 digits
b.) supplier_id is fk to supplier
c.) supplier_name can hold 50 letters AND cannot be NULL NOTE: ALL CONSTRAINTS must be NAMED BY programmer
*/

CREATE TABLE products3
(
product_idNUMBER(10) CONSTRAINT pid_pk PRIMARY KEY,
supplier_id NUMBER(10) NOT NULL,
supplier_name VARCHAR2(50) NOT NULL,
constraint prod_supp_suppid_supprname_fk 
foreign key (supplier_id, supplier_name) 
REFERENCES supplier3(supplier_id, supplier_name)
);
DROP TABLE products3 cascade constraints;
/* -----------------------------------------------------------------------------
HOA C2 5. create table products4
a.) same fields as products
b.) no foreign key in create table
c.) use alter statement add: products_supplier_supplierid_fk
NOTE: use first supplier table with single field PK
*/
CREATE TABLE products4
(
product_idNUMBER(10) CONSTRAINT pid4_pk PRIMARY KEY,
supplier_id number(10) not null,
supplier_name varchar2(50) not null
--constraint products4_fk foreign key (supplier_id) references supplier2(supplier_id)
);
drop table products4 cascade constraints;

-- "add" foreign key after tables are created
alter table products4 add constraint prod4_fk foreign key (supplier_id) 
REFERENCES supplier2(supplier_id);
/* -----------------------------------------------------------------------------
HOA C2 6. create table products4
a.) same fields as products
b.) no foreign key in create table
c.) use alter statement add composite FK: prod_supp_suppid_suppname_fk
NOTE: use first supplier2 table with composite PK
*/
CREATE TABLE products4
(
product_idNUMBER(10),
supplier_id NUMBER(10),
supplier_name VARCHAR2(50)
);
alter table products4 add constraint prod_supp_suppid_suppname_fk foreign key
(supplier_id, supplier_name) REFERENCES supplier2
(supplier_id, supplier_name);
/* -----------------------------------------------------------------------------
HOA C2 7. You work for a company that has people who work out
of multiple locations. Create three small tables:
PEOPLE: a table about people
LOCATIONS: a table about locations
ASSIGNMENTS: a table about people at locations
*/
/*
HOA C2 8. create table people
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
HOA C2 9. create table assignments
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
lid INTEGER,
CONSTRAINT assignments_pk PRIMARY KEY (pid, lid),
CONSTRAINT assignments_people_pid_fk FOREIGN KEY (pid) REFERENCES people (pid),
CONSTRAINT assignments_locations_lid_fk FOREIGN KEY (lid) REFERENCES locations (lid)
);
drop table assignments;
desc assignments;
/*
HOA C2 10. create table locations
-- ---------------------------------------------------
1.) lid is the primary key
2.) store name can hold 30 letters and cannot be null
4.) city can hold 30 letters and cannot be null
5.) state can hold 2 letters and cannot be null
*/
-- create a table for locations
CREATE TABLE locations
(
lid INTEGER CONSTRAINT locations_lid_pk PRIMARY KEY,
nameVARCHAR2(30) CONSTRAINT locations_name_nn NOT NULL,
cityVARCHAR2(30) CONSTRAINT locations_city_nn NOT NULL,
state VARCHAR2(2) CONSTRAINT locations_state_nn NOT NULL
);
DROP TABLE locations;
/*
11. drop these three tables people, assignments, locations
*/






























-- =============================================================================
-- Chapter 3
-- =============================================================================
select * from cruise_customers;
delete from cruise_customers;
rollback;
select * from ports;
select * from employees;
select * from employees;
select * from cruises;
/*
-- C3 Page 99 (3/1)
1. Copy from page 99
2. Format for readability
3. Insert (is there a problem?)
SOLUTION
4. Select from cruises
5. Select from employees
6. Check constraints
7. Change insert statement to work
*/

begin
insert into cruises ( cruise_id, cruise_type_id, cruise_name, captain_id,start_date,end_date,status)
values ( seq_cruise_id.nextval, '1' , 'Day At Sea' , 1, '02-JAN-10', '09-JAN-10','Sched' );
insert into cruises ( cruise_id, cruise_type_id, cruise_name, captain_id,start_date,end_date,status)
values ( seq_cruise_id.nextval, '1' , 'Day At Sea' , 1, '02-JAN-10', '09-JAN-10','Sched' );
insert into cruises ( cruise_id, cruise_type_id, cruise_name, captain_id,start_date,end_date,status)
values ( seq_cruise_id.nextval, '1' , 'Day At Sea' , 1, '02-JAN-10', '09-JAN-10','Sched' );
end;
/
desc cruises;

select max(cruise_id) from cruises;
create sequence seq_cruise_id start with 15;;
drop sequence seq_cruise_id;

select * from cruises
where cruise_id in (10,12,14);

update cruises
set cruise_name = 'Bahamas'
where cruise_id in (1,3,5,7); 

update cruises
set cruise_name = 'Hawaii'
where cruise_id in (2,4,6,8);

update cruises
set cruise_name = 'Mexico', status = 'SCHED'
where cruise_id in (10,12,14);

select * from salary_chart;

select * from salary_chart
where emp_title like 'Manager';

update salary_chart
set emp_income = 48000, sup_income =2500, last_modified_by = 'brogers', last_modified_date = sysdate
where emp_title like 'Chef';

update salary_chart
set emp_income = 75000, sup_income =3100, last_modified_by = 'brogers', last_modified_date = sysdate
where emp_title like 'Director';

update salary_chart
set emp_income = 65000, last_modified_by = 'brogers', last_modified_date = sysdate
where emp_title like 'Manager';

savepoint salary_adj;

update salary_chart
set sup_income = sup_income*.90, last_modified_date = sysdate;

select * from salary_chart;
rollback;

delete from salary_chart;
select * from salary_chart;
rollback;

rollback;

alter table salary_chart
ADD (last_modified_by varchar2(12), last_modified_date date);

commit;

SELECT * FROM cruises;
select * from employees;
desc cruises;
select * from ships;

/*
-- C3 Page 101 (3/2)
1. Copy insert from above
2. Remove column names
3. Insert (same problem)
4. Select from cruises/check constraints
5. Add value (select from ships)
6. Insert
7. Change captain_id (select from employees)
6. Insert
*/
INSERT INTO CRUISES VALUES ( 2 , 1 , 'Day At Sea', 101 ,'02-JAN-10' ,'09-JAN-10' ,'Sched' );
SELECT * FROM cruises;
SELECT * FROM employees;
DESC cruises;
DESC ships;
SELECT * FROM ships;
/*
-- Page C3 105 (3/4)
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
INTO CRUISES VALUES (cruise_cruise_id_seq.nextval,1,'Day At Sea', 8,8,
'02-JAN-10','09-JAN-10' ,'Sched');
SELECT * FROM cruises;
SELECT * FROM employees;
5
/*
-- C3 Page 106 (3/4)
1. Copy code page 106
2. Select Max from Cruises
3. Create sequence start Max+1
4. Insert statement from page 105
5. Insert
*/
UPDATE CRUISES
SET CRUISE_NAME = 'Bahamas',
START_DATE= '01-DEC-11'
WHERE CRUISE_ID = 1;
UPDATE CRUISES
SET CRUISE_NAME = 'Bahamas',
START_DATE= '02/DEC/02'
WHERE CRUISE_ID = 1;
/*
-- C3 Page 108 (3/5)
1. Copy update code from above
2. Modify to below
3. Update
4. Select to test
*/
SELECT *
FROM CRUISES;
UPDATE cruises SET end_date = start_date + 5 WHERE cruise_id = 1;
/*
-- C3 Page 108 (3/5)
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
PROJECT_ID NUMBER PRIMARY KEY ,
PROJECT_NAME VARCHAR2(40) ,
COST NUMBER ,
CONSTRAINT CK_COST CHECK (COST < 1000000)
);
begin
insert into projects2(project_id,project_name,cost)
values (1,'Hull Cleaning ',340000);
insert into projects2(project_id,project_name,cost)
VALUES (2,'Deck Resurfacing ',964000);
insert into projects2(project_id,project_name,cost)
VALUES (3,'Lifeboat Inspection ',12000);
END;
/
UPDATE projects2 SET cost = cost * 1.03;
/*
-- C3 Page 110 (3/5)
1. Copy update from above
2. Modify with where clause
3. Update
4. Select
*/
UPDATE projects2
SET cost= cost * 1.2
WHERE cost* 1.2 < 1000000;
/*
-- C3 Page 117 (3/7)
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
-- C3 Page 120 (3/7)
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
1. C3 copy DDL stements above for tables: people, assignments, locations
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
lid INTEGER CONSTRAINT locations_lid_pk PRIMARY KEY,
nameVARCHAR2(30) CONSTRAINT locations_name_nn NOT NULL,
cityVARCHAR2(30) CONSTRAINT locations_city_nn NOT NULL,
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
insert into people(pid, start_date,fname,lname,email)
values ( people_pid_seq.nextval,sysdate,'Marshal','Rango','rango@hotmail.com');
insert into people(pid, start_date,fname,lname,email)
values ( people_pid_seq.nextval,sysdate,'Peneolpe','Pitstop','ppitstop@gmail.com');
insert into people(pid, start_date,fname,lname,email)
values ( people_pid_seq.nextval,sysdate,'Ranger','Andy','randy@juno.com');

SELECT * FROM people;
insert into locations (lid, name, city,state )
VALUES ( locations_lid_seq.nextval,
'Bar 4 Ranch',
'Lubbock',
'TX'
);
INSERT
INTO locations
(
lid,
name,
city,
state
)
VALUES
(
locations_lid_seq.nextval,
'BarBQue',
'Austin',
'TX'
);
INSERT
INTO locations
(
lid,
name,
city,
state
)
VALUES
(
locations_lid_seq.nextval,
'SpaceOut',
'Houston',
'TX'
);
INSERT INTO assignments
(pid,lid
) VALUES
(1000,1
);
INSERT INTO assignments
(pid,lid
) VALUES
(1000,3
);
INSERT INTO assignments
(pid,lid
) VALUES
(1001,2
);
INSERT INTO assignments
(pid,lid
) VALUES
(1001,3
);
INSERT INTO assignments
(pid,lid
) VALUES
(1002,1
);
INSERT INTO assignments
(pid,lid
) VALUES
(1002,3
);
SELECT * FROM assignments;
/*
9. Delete from people where pid = 1000;
10. Delete from locations where lid = 1
-- ---------------------------------------------------
*/
DELETE
FROM people
WHERE pid = 1000;
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
-- C4 Page 139 (4/1)
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

SELECT SHIP_ID,
SHIP_NAME,
capacity
from ships
ORDER BY 1, 2;

select SHIP_ID,rowid, rownum
from ships
where ship_id between 3 and 6
order by 1 desc;

select distinct lastname 
from customers
;

select count(*), lastname
from customers
group by lastname;

select employee_id, salary, salary*1.05
from pay_history
where end_date is null
order by employee_id;


 select count(*) 
 from customers
 join orders using(customer#);
 

 select count(*) 
 from orders;
 
 select customer#
 from customers
 where customer# not in 
(select customer#
 from orders);

 select * 
 from customers
 where state in ('FL','GA');
 
 create view southeast
 as select firstname, lastname 
 from customers
 where state in ('FL','GA');
 
 drop view southeast;
 commit;
 
select * 
 from southeast;
 
desc southeast; 

select count(catcode), catcode
from books
group by catcode;

select shipdate
from orders;

 
 
 

-- C4 Page 141 (4/2)
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
SELECT lastname,firstname, order#
FROM customers
JOIN orders USING (customer#)
ORDER BY 3, 2, 1;
/*
SELECT lastname, firstname, order#
FROM customersLEFT JOIN orders USING (customer#)
ORDER BY 3, 2, 1;
*/
SELECT lastname, firstname, order#
FROM customers c
JOIN orders o
on c.customer# = o.customer#
ORDER BY 3,2,1;
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
ORDER BY 3,2,1;
*/
-- total number of joined rows
SELECT lastname, firstname, order#
FROM customers c
LEFT OUTER JOIN orders o
ON c.customer# = o.customer#
ORDER BY 3, 2, 1;

select lastname, firstname,order#
FROM customers c , orders o
WHERE c.customer# = o.customer#;
SELECT lastname, firstname, order#
FROM customers c , orders o
WHERE c.customer# = o.customer#;

-- customers without orders
select c.customer#, lastname, firstname
 from customers c
where not exists (select customer# from orders o where c.customer# = o.customer#);

-- 10
SELECT c.customer#,
lastname,
firstname
FROM customers c
WHERE c.customer# NOT IN
(SELECT customer# FROM orders o WHERE c.customer# = o.customer#
);
-- 14
SELECT c.customer#,
lastname,
firstname
FROM customers c
WHERE c.customer# IN
(SELECT DISTINCT customer# FROM orders o WHERE c.customer# = o.customer#
);
-- 24
select distinct c.customer#, lastname, firstname from customers c;
select count(distinct c.customer#) from customers c;
-- 22
select count(*) from orders;

 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 -- =============================================================================
 -- Chapter 5
 -- =============================================================================
select *
from customers
where state not in ('FL','GA');
 
select *
from customers
where state not in ('FL','GA');

select *
from customers
where state like 'F%';

select catcode, pubid, cost 
from books
where (catcode = 'FAL'
or pubid = 4)
and cost > 15;

select room_number, room_style, window 
from ship_cabins
where room_style = 'Suite'
or room_style = 'Stateroom'
 and window = 'Ocean';

select * 
from books
where catcode = 'FAL';

select * 
from books
where pubid = 4;

select * 
from books
where cost > 15;


select room_number,
room_style,
window
from ship_cabins
where not room_style like 'Suite';

--and window = 'Ocean';
SELECT port_name
FROM ports
WHERE country IN ('UK','USA','Bahamas');
select port_name from ports where capacity = null;
/*
1.
Return port_id, port_name, capacity
for ports that start with either "San" or "Grande"
and have a capacity of 4.
*/
SELECT port_id,
port_name,
capacity
FROM ports
WHERE (port_name LIKE 'San%'
OR port_name LIKE 'Grande%')
AND capacity = 4;
/*
2.
Return vendor_id, name, and category
where the category is "supplier", "subcontractor" or ends with Partner.
*/
SELECT vendor_id,
vendor_name,
category
FROM vendors
WHERE category IN ('Supplier','Subcontractor')
OR category LIKE '%Partner';
/*
3.
Return room_number and style from ship_cabins
where there is no window or the balcony_sq_ft = null;
*/
SELECT room_number,
room_style
FROM ship_cabins
WHERE window= 'None'
OR balcony_sq_ft IS NULL;
/*
4.
Return ship_id, name, capacity, length
from ships where 2052 <= capacity <= 3000
and the length is either 100 or 855
and the ship begins with "Codd"
*/
SELECT ship_id, ship_name, capacity, LENGTH
FROM ships
WHERE capacity BETWEEN 2052 AND 3000
AND LENGTH IN (100,855)
AND ship_name LIKE 'Codd_%';

ALTER TABLE ships ADD lifeboats INTEGER;
BEGIN
UPDATE ships SET lifeboats = 82 WHERE ship_name = 'Codd Crystal';
UPDATE ships SET lifeboats = 95 WHERE ship_name = 'Codd Elegance';
UPDATE ships SET lifeboats = 75 WHERE ship_name = 'Codd Champion';
UPDATE ships SET lifeboats = 115 WHERE ship_name = 'Codd Victorious';
UPDATE ships SET lifeboats = 76 WHERE ship_name = 'Codd Grandeur';
UPDATE ships SET lifeboats = 88 WHERE ship_name = 'Codd Prince';
UPDATE ships SET lifeboats = 80 WHERE ship_name = 'Codd Harmony';
UPDATE ships SET lifeboats = 92 WHERE ship_name = 'Codd Voyager';
END;
/
/*
5.
Return ship_id, name, lifeboats, capacity
from ships where the name is either "Codd Elegance","Codd Victorious"
and 80 >= lifeboats >= 100
and capacity / lifeboats > 25
*/
SELECT ship_id,
ship_name,
lifeboats,
capacity
FROM ships
WHERE ship_name IN ('Codd Elegance','Codd Victorious')
AND (lifeboats<= 80
OR lifeboats>=100)
AND capacity / lifeboats > 25;











































































 -- =============================================================================
 -- Chapter 6
 -- =============================================================================
SELECT *
from dual;
select sysdate from dual;
 
 -- Type in 215
SELECT employee_id
FROM employees
WHERE upper(last_name) = 'SMITH';
 
 select lastname, firstname
 from customers;
 
 select firstname || ' ' || lastname
 from customers;
 
 select 'Hello, ' || 'World!'
 from dual;
 
 select concat(concat(firstname,' '),lastname)
 from customers;
 
 select * from BOOK_CONTENTS;
 
 -- Type in 216
 SELECT initcap('napoleon'),
initcap('RED O''BRIEN'),
initcap('McDonald''s')
 from dual;

 -- Type in 218
select rpad (chapter_title
|| ' ',40,'.')
|| lpad(' '
|| PAGE_NUMBER,40,'.') "Table of Contents"
FROM book_contents
ORDER BY page_number;

select ship_name, length(ship_name) from ships;

SELECT rpad (CHAPTER_TITLE|| ' ',30,'.')
FROM book_contents
ORDER BY page_number;
 
 select chapter_title
 from book_contents;

 -- Type in 219
 SELECT rtrim ('Seven thousand--------','-') FROM dual;
 -- Type in 220
select instr ('Mississippi', 'is',1,2) from dual;

select * from dual;

-- Type in 221
select substr('Name: MARK KENNEDY',7, 4) from dual;
select substr('Name: MARK KENNEDY',7, 4) from cruises;

select round(-2.55,0) from dual;
select trunc(-2.99,0) from dual
select substr('Name: MARK KENNEDY',12) from dual;

select mod(11,3) from dual;
select remainder(11,3) from dual;
select remainder(17,4) from dual;

select next_day('31-MAY-11','Saturday') from dual;
select next_day(sysdate,'Mon') from dual;

select last_day(sysdate) from dual;

select add_months(sysdate,2) from dual;
select months_between(sysdate,'31-MAY-11') from dual;

select numtoyminterval(27,'MONTH') from dual;
select numtoyminterval(27,'YEAR') from dual;

select numtoyminterval(sysdate,'YEAR') from dual;

select numtodsinterval(1440, 'MINUTE') from dual;

select * from orders;
select shipdate, orderdate from orders;

select shipdate, orderdate from orders where shipdate is null;

select shipdate, nvl(shipdate,sysdate)from orders;

select * from scores;
select test_score, updated_test_score from scores;

-- Type in 222
SELECT soundex('William'), soundex('Rogers') FROM dual;
-- Type in 223
select round(12.355143, 2), round(259.99,-1) from dual;

select cost, retail, retail-cost, round((retail-cost),0) 
from books;

select cost, retail, retail-cost, trunc((retail-cost),0) 
from books;

select remainder(11,3) from dual;
select remainder(7,5) from dual;
select mod(7,6) from dual;

-- Type in 224 top
select trunc(12.355143,2), TRUNC(259.99,-1)FROM dual;

-- Type in 224 bottom
select remainder(9,3),
 remainder(10,3),
 remainder(11,3)
 FROM dual;

 -- Type in 227
 select sysdate today,
 round(sysdate,'mm') rounded_month,
 round(sysdate,'rr') rounded_year,
 TRUNC(sysdate,'mm') truncated_month,
 trunc(sysdate,'rr') truncated_year
 FROM dual;
 
select orderdate,round(orderdate,'mm')
from orders; 

select sysdate, next_day(sysdate, 'SUNDAY') from dual; 

select last_day('14-FEB-11'),last_day('14-FEB-12')
from dual;

select round(to_date('16-FEB-11','dd-mm-yy'),'mm') from dual;

select add_months(sysdate,4) from dual;

select months_between(sysdate,'01-FEB-12') from dual;
select NUMTOYMINTERVAL(27.5,'YEAR') from dual;
select NUMTODSINTERVAL(144,'HOUR') from dual;

select nvl(shipdate,sysdate) from orders;

select state from customers;

select state,
decode (state,
'CA', 'Calfornia',
'FL', 'Florida',
'WA', 'Washington',
'Other')
from customers;

 -- Type in 228
 SELECT add_months('31-JAN-11',1),
 add_months('01-NOV-11',4)
 FROM dual;
 -- Type in 229
 SELECT months_between ('12-JUN-14','03-OCT-13') FROM dual;
 -- Type in 230
 SELECT NUMTODSINTERVAL(36,'HOUR') FROM DUAL;
 -- Type in 231
 SELECT NVL(NULL,0) FIRST_ANSWER,
 14+NULL-4 SECOND_ANSWER,
 14+NVL(NULL,0)-4 THIRD_ANSWER
 FROM DUAL;
 -- Type in 233 top
SELECT SHIP_NAME,
 CAPACITY,
 CASE CAPACITY
 WHEN 2052
 THEN 'MEDIUM'
 WHEN 2974
 THEN'LARGE'
 END AS "SIZE"
 FROM SHIPS
 WHERE SHIP_ID <= 4;
-- Type in 233 bottom
SELECT TEST_SCORE,
UPDATED_TEST_SCORE,
NULLIF(UPDATED_TEST_SCORE,TEST_SCORE) REVISION_ONLY
FROM SCORES;

-- Type in 237
SELECT to_number('17.000,23','999G999D99','nls_NUMBER_characters='',.'' ')
FROM dual;
-- Type in 241 middle
SELECT TO_CHAR(SYSDATE,'FMDay, "the" Ddth "of" Month, RRRR')
FROM DUAL;
-- Type in 241 bottom
SELECT TO_CHAR(SYSDATE,'RR HH:MI:SS AM') FROM DUAL;

 select to_char(sysdate, 'DD-Month-RRRR HH:MM:SS AM') from dual;

 select order#, shipdate, orderdate from orders where shipdate is null;

 select to_date('01.31.11','MM.DD.RR') from dual; 
 
 select current_timestamp from dual;

-- Type in 245 middle
SELECT TO_TIMESTAMP('2020-JAN-01 12:34:00:093423','RRRR-MON-DD HH:MI:SS:FF') EVENT_TIME
FROM DUAL;
 
-- Page 248
drop table timestamp_test;
create table timestamp_test
( dtdate, -- date & time (d&t)
tstimestamp,-- d&t (fractional seconds)
ts_with_tztimestamp with time zone, -- d&t with tz
ts_with_local_tztimestamp with local time zone-- d&t utc time (when queried gives local time)
);
insert into timestamp_test 
values (sysdate,
current_timestamp,
current_timestamp, 
current_timestamp);
select * from timestamp_test;

-- Type in 249 middle
SELECT dbtimezone,
sessiontimezone,
CURRENT_TIMESTAMP
from dual;
 
 select tzabbrev,tzname
 from v$timezone_names
 order by 1, 2;

 -- Type in 250 middle
 SELECT owner,
table_name,
column_name,
data_type
 FROM all_tab_columns
 where data_type like '%TIME%'
and owner = 'CRUISES';

 -- Type in 252 middle
 SELECT COUNT(*)
 FROM
( SELECT TZABBREV, TZNAME FROM V$TIMEZONE_NAMES ORDER BY TZABBREV, TZNAME
);
-- Type in 253
 select dbtimezone from dual;

-- Type in 254
 select sessiontimezone from dual;
 SELECT sysdate, CURRENT_DATE,CURRENT_TIMESTAMP, localtimestamp FROM dual;
-- Type in 255
 SELECT SYSTIMESTAMP FROM DUAL;
-- Type in 257
 SELECT from_tz(TIMESTAMP '2012-10-12 07:45:30', '+07:30')
 FROM dual;
-- Type in 258
 SELECT to_timestamp_tz('17-04-2013 16:45:30','dd-mm-rrrr hh24:mi:ss') "time"
 FROM dual;
 select cast('19-JAN-10 11:35:30' as timestamp with local time zone) converted from dual;

 select Extract(MINUTE from CURRENT_TIMESTAMP) minute from dual;

 -- Type in 260
 SELECT sys_extract_utc(CURRENT_TIMESTAMP) "hq" FROM dual;

 select current_timestamp dbtime from dual;
 select current_timestamp at time zone dbtimezone dbtime from dual;

 select current_timestamp at local dbtime from dual;
 
 SELECT to_timestamp('2011-JUL-26 20:20:00', 'RR-MON-DD HH24:MI:SS') at TIME zone dbtimezone
 FROM dual;





























-- =============================================================================
-- Chapter 7
-- =============================================================================
-- open books
-- insert lastname and firstname (yourself) into next available row in customers table
SELECT *
from cruises;

select count(*) from Cruises;

select * from ship_cabins;

select distinct room_style from ship_cabins;

select room_style,count(*) 
from ship_cabins
where ship_id = 1
group by room_style;

select count(orderdate), count(shipdate) from orders;
select count (distinct room_style) from ship_cabins;

select count(ALL orderdate),
count(orderdate), 
count(shipdate), 
count(ALL shipdate) 
from orders;

select cost from books;

select catcode, count(*), sum(cost) 
from books
group by catcode
order by 1;


select catcode, 
count(*), 
sum(cost), 
round(avg(cost),2),
min(cost),
max(cost) 
from books
group by catcode
order by 1;

select rank(211) within group (order by sq_ft)
from ship_cabins;

select sq_ft from ship_cabins order by sq_ft;
 
SELECT MAX(customer#) FROM customers;
INSERT
INTO customers
(
customer#,
firstname,
lastname
)
VALUES
(
1025,
'Bucky',
'Rogers'
);
SELECT COUNT(*),
COUNT(lastname),
COUNT(state) ,
COUNT (referred)
FROM customers;
SELECT COUNT(*), COUNT(DISTINCT state), COUNT(ALL state) FROM customers;
--what could you always count in a row to
--ensure you get the right count
SELECT COUNT(*),
SUM(quantity)
FROM orderitems;
 SELECT MIN(retail) FROM books;
 SELECT MAX(cost) FROM books;
 SELECT AVG(cost), AVG(retail) FROM books;
 SELECT median(retail) FROM books;
 SELECT rank('COM') within GROUP (ORDER BY TITLE ) FROM books;
 SELECT median(cost) FROM books;
 SELECT rank(20) within GROUP (ORDER BY retail) FROM books;
 SELECT * FROM books;
-- cruises

 -- page 284
 SELECT MAX(sq_ft) keep (dense_rank first ORDER BY guests)
from ship_cabins;

 select sq_ft, guests
from ship_cabins
order by guests, sq_ft;

 SELECT * FROM ship_cabins ORDER BY 7, 8;
 SELECT ship_cabin_id,
room_number,
room_style,
room_type,
window,
guests,
sq_ft
FROM ship_cabins
WHERE ship_id = 1;
 select room_style round(avg(sq_ft), 2) from ship_cabins group by room_style;
 SELECT * FROM ship_cabins;
 
 -- page 288 top
 SELECT ship_cabin_id,
room_number,
room_style,
room_type,
window,
guests,
sq_ft
FROM ship_cabins
WHERE room_style IN ('Suite','Stateroom')
ORDER BY 3 DESC;
-- page 288 bottom
SELECT room_style ,
room_type ,
ROUND(AVG(sq_ft),2) ,
MIN(guests) ,
COUNT(ship_cabin_id)
FROM ship_cabins
GROUP BY room_style,
room_type;
SELECT room_style, AVG(sq_ft) FROM ship_cabins GROUP BY room_style;
-- page 289
SELECT room_type,
TO_CHAR(ROUND(AVG(sq_ft),2),'999,999.99'),
MAX(guests),
COUNT(ship_cabin_id)
FROM ship_cabins
WHERE ship_id = 1
GROUP BY room_type
ORDER BY 2 DESC;
-- page 290
SELECT TO_CHAR(ROUND(AVG(sq_ft),2),'999,999.99') ,
MAX(guests) ,
COUNT(ship_cabin_id)
FROM ship_cabins
WHERE ship_id = 1
AND room_type = 'Royal'
ORDER BY 1 DESC;
SELECT ROOM_STYLE,
ROOM_TYPE,
TO_CHAR(MIN(SQ_FT),'9,999') "Min"
FROM SHIP_CABINS
WHERE SHIP_ID = 1
GROUP BY ROOM_STYLE,
ROOM_TYPE
HAVING ROOM_TYPE IN ('Standard', 'Large')
OR MIN(SQ_FT) > 1200
ORDER BY 3;
SELECT ROOM_STYLE,
ROOM_TYPE,
TO_CHAR(MIN(SQ_FT),'9,999') "Min"
FROM SHIP_CABINS
WHERE SHIP_ID = 1
GROUP BY ROOM_STYLE,
ROOM_TYPE
HAVING MIN(guests) >5
OR AVG(SQ_FT)> 1200
OR ROOM_TYPEIN ('Standard', 'Large')
ORDER BY 3;
SELECT COUNT(*), COUNT(balcony_sq_ft) FROM ship_cabins;
SELECT COUNT(*) FROM ship_cabins;
SELECT balcony_sq_ft FROM ship_cabins;
SELECT * FROM ship_cabins;
SELECT COUNT(*) FROM ship_cabins;
SELECT * FROM ship_cabins;
SELECT SUM(balcony_sq_ft) FROM ship_cabins;
SELECT * FROM ship_cabins ORDER BY sq_ft;
SELECT DISTINCT sq_ft FROM ship_cabins ORDER BY 1;
SELECT rank(300) within GROUP(ORDER BY sq_ft) FROM ship_cabins;
SELECT MAX(sq_ft) keep (dense_rank FIRST
ORDER BY guests) largest
FROM ship_cabins;
SELECT MIN(sq_ft) keep (dense_rank FIRST
ORDER BY guests) smallest
FROM ship_cabins;
SELECT MAX(sq_ft) keep (dense_rank last
ORDER BY guests) largest
FROM ship_cabins;
SELECT MIN(sq_ft) keep (dense_rank last
ORDER BY guests) smallest
FROM ship_cabins;
SELECT MAX(sq_ft) FROM ship_cabins;
SELECT MIN(sq_ft) FROM ship_cabins;
SELECT * FROM ship_cabins ORDER BY 7,8;
SELECT room_style,
room_type,
TO_CHAR(MIN(sq_ft),'9,999') "Min",
TO_CHAR(MAX(sq_ft),'9,999') "Max",
TO_CHAR(MIN(sq_ft)-MAX(sq_ft),'9,999') "Diff"
FROM ship_cabins
WHERE ship_id = 1
GROUP BY room_style,
room_type
ORDER BY uid;
SELECT room_style,
room_type,
AVG(MAX(sq_ft))
FROM ship_cabins
WHERE ship_id = 1
GROUP BY room_style,
room_type
ORDER BY 1 DESC,
2;

-- page 294
SELECT MAX(sq_ft)
FROM ship_cabins
WHERE ship_id = 1
group by room_style,
 room_type;

select avg(max(sq_ft))
FROM ship_cabins
WHERE ship_id = 1
group by room_style,
 room_type
order by max(sq_ft);


select count(count(project_cost))
from projects
group by purpose;

select purpose, avg(project_cost)
from projects
where days > 3
group by purpose;

having days > 3;


SELECT room_style,
room_type,
MAX(sq_ft)
FROM ship_cabins
WHERE ship_id = 1
GROUP BY room_style,
room_type
ORDER BY 1,
3;
 
-- page 297
select room_style,
room_type,
min(sq_ft)
from ship_cabins
where ship_id =1

group by room_style, room_type
having room_type in ('Standard','Large')
-- or min(sq_ft) > 1200
order by 3;

 

 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
-- =============================================================================
-- Chapter 8
-- =============================================================================
 -- page 317 top
select ship_id, ship_name, port_name
 from ships inner join ports
 on home_port_id = port_id
 order by ship_id;

select ship_id, ship_name, port_name
from ships, ports
where home_port_id = port_id
order by ship_id;

select p.port_name, s.ship_name, sc.room_number
from ports p join ships s on p.port_id = s.home_port_id
 join ship_cabins sc using (ship_id);

-- equijoins
-- old style
select c.firstname, c.lastname, b.catcode, b.title
from customers c,
 orders o,
 orderitems oi,
 books b
where c.customer# = o.customer#
and o.order# = oi.order#
and oi.isbn = b.isbn
and catcode = 'COM';

-- new style (on)
select firstname, lastname, catcode, title
from customers c join orders o on c.customer# = o.customer#
 join orderitems oi on o.order# = oi.order# 
 join books b on oi.isbn = b.isbn
where catcode = 'COM';

-- new style (using)
select firstname, lastname, catcode, title
from customers join orders using(customer#)
 join orderitems using (order#)
 join books using(isbn) 
where catcode = 'COM';

-- new styles combination
select firstname, lastname, catcode, title
from customers c natural join orders o 
 join orderitems oi using (order#)
 join books b on oi.isbn = b.isbn
where catcode = 'COM';;

-- nonequijoin
select s.score_id, s.test_score, g.grade
from scores s join grading g
on s.test_score between g.score_min and g.score_max;

select title, gift
from books b, promotion p
where b.retail > p.minretail and b.retail < p.maxRetail;

select title, gift
from books join promotion
 on b.retail between minretail and maxRetail;

select * from employees;
select * from addresses;

select employee_id, last_name, street_address
from employees natural join addresses;

-- outer join
drop table books.employee;
create table books.employee
(emp_name varchar2(13),
 dept_idnumber
 );

drop table books.department;
create table books.department
(dept_idnumber,
 dept_namevarchar2(13)
 );
 
begin 
insert into employee values ('Rafferty',	31);
insert into employee values ('Jones',	33);
insert into employee values ('Steinberg',	33);
insert into employee values ('Robinson',	34);
insert into employee values ('Smith',	34);
insert into employee values ('Johnson', null);
end;
/
begin
insert into department values( 31,	'Sales');
insert into department values( 33,	'Engineering');
insert into department values( 34,	'Clerical');
insert into department values( 35,	'Marketing');
end;
/
select * from employee;
select * from department;

select * from employee join department using (dept_id);

select * from employee left outer join department using (dept_id);
select * from employee right outer join department using (dept_id);
select * from employee full outer join department using (dept_id);

select * from departmentleft outer joinemployee using (dept_id);
select * from departmentright outer join employee using (dept_id);
select * from departmentfull outer joinemployee using (dept_id);

select * 
from employee e, department d 
where e.dept_id = d.dept_id(+);

select * from department right outer join employee using (dept_id);

select * from department left outer join employee using (dept_id);
select * from employee right outer join department using (dept_id);

select * from employee full outer join department using (dept_id);

select * from customers;

select c1.customer#,c1.firstname, c1.lastname, c2.customer#, c2.firstname, c2.lastname 
from customers c1, customers c2
where c1.customer#=c2.referred;;

select * from employee cross join department;

select * from employee,department;

 SELECT *
FROM ports;
SELECT * FROM ships;
SELECT ship_id,
ship_name,
port_name
FROM ships
RIGHT JOIN ports
ON home_port_id = port_id
ORDER BY ship_id;

-- page 317 bottom
SELECT ship_id,
ship_name,
port_name
FROM ships
JOIN ports
ON home_port_id = port_id
WHERE port_name ='Charleston'
ORDER BY ship_id;
-- page 318 top
SELECT ship_id,
ship_name,
port_name
FROM ships,
ports
WHERE home_port_id = port_id
ORDER BY ship_id;
-- page 318 bottom
SELECT ship_id,
ship_name,
port_name
FROM ships,
ports
WHERE home_port_id = port_id
AND port_name='Charleston'
ORDER BY ship_id;
-- page 319 top
SELECT ship_id,
ship_name,
port_name
FROM ships
FULL OUTER JOIN ports
ON home_port_id = port_id
ORDER BY ship_id;
SELECT * FROM ports;
-- page 319 bottom
SELECT ship_id,
ship_name,
port_name
FROM ships
JOIN ports
ON home_port_id = port_id(+)
ORDER BY ship_id;
-- page 320 bottom
SELECT ship_id,
ship_name,
port_name
FROM ships
FULL JOIN ports
ON home_port_id = port_id
ORDER BY ship_id;
-- page 321 bottom
SELECT employee_id,
last_name,
address
FROM employees
INNER JOIN addresses
ON employee_id = employee_id;
-- page 323 top
SELECT e.employee_id,
last_name,
street_address
FROM employees e
INNER JOIN addresses a
ON e.employee_id = a.employee_id;
-- page 324 bottom
SELECT employee_id,
last_name,
street_address
FROM employees
LEFT JOIN addresses USING (employee_id);
-- page 325 bottom
SELECT p.port_name,
s.ship_name,
sc.room_number
FROM ports p
JOIN ships s
ON p.port_id = s.home_port_id
JOIN ship_cabins sc
ON s.ship_id = sc.ship_id;
-- page 325 bottom alternate
-- no
SELECT p.port_name,
s.ship_name,
sc.room_number
FROM ports p
JOIN ships s
JOIN ship_cabins sc
ON p.port_id = s.home_port_id
ON s.ship_id = sc.ship_id;
-- page 325 bottom alternate
-- yes
SELECT p.port_name,
s.ship_name,
sc.room_number
FROM ports p
JOIN ships s
ON p.port_id = s.home_port_id
JOIN ship_cabins sc USING (ship_id) ;
SELECT p.port_name,
s.ship_name,
sc.room_number
FROM ports p
JOIN ships s
ON p.port_id = s.home_port_id
JOIN ship_cabins sc
ON sc.ship_id = s.ship_id
JOIN employees e
ON e.ship_id = sc.ship_id;
-- page 327
SELECT * FROM scores;
SELECT * FROM grading;
SELECT s.score_id,
s.test_score,
g.grade
FROM scores s
JOIN grading g
ON s.test_score BETWEEN g.score_min AND g.score_max;
-- page 328
SELECT * FROM positions;
SELECT *
FROM positions p1
JOIN positions p2
ON p1.position_id = p2.reports_to;
-- page 330
SELECT p1.position_id,
p2.position employee,
p1.position reports_to
FROM positions p1
JOIN positions p2
ON p1.position_id = p2.reports_to;
SELECT *
FROM positions p1
JOIN positions p2
ON p1.position_id = p2.position_id;
-- page 331
-- How many columns
-- How many rows
SELECT * FROM vendors;
-- How many columns
-- How many rows
SELECT * FROM online_subscribers;
-- How many total columns
-- How many total rows
SELECT *
FROM vendors,
online_subscribers;
-- -----------------------------------------------------------------------------
-- HANDS ON EXERCISES CHAPTER 8
-- -----------------------------------------------------------------------------
-- 1. List employee's ID and name and address, city, state,
--zip with new join syntax and keyword "ON"
--Use table aliases for all returned columns where possible
SELECT e.employee_id,
e.first_name,
e.last_name
FROM employees e;
SELECT a.employee_id,
a.street_address,
a.city,
a.state,
a.zip
FROM addresses a;
SELECT e.employee_id,
e.first_name,
e.last_name,
a.street_address,
a.city,
a.state,
a.zip
FROM employees e
JOIN addresses a
ON e.employee_id = a.employee_id;
-- 2. Repeat question 1 with the keyword "USING"
--Use table aliases for all returned columns where possible
SELECT employee_id,
e.first_name,
e.last_name,
a.street_address,
a.city,
a.state,
a.zip
FROM employees e
JOIN addresses a USING(employee_id);
-- 3. List cruise_name and captains ID,
-- captains name address, city, state,zip with new join syntax and keyword "ON"
SELECT e.employee_id,
e.first_name,
e.last_name,
a.street_address,
a.city,
a.state,
a.zip
FROM employees e
JOIN addresses a
ON e.employee_id = a.employee_id
JOIN cruises c
ON e.employee_id = c.captain_id;
-- 4. Repeat question 3 using keyword "USING"
SELECT employee_id,
e.first_name,
e.last_name,
a.street_address,
a.city,
a.state,
a.zip
FROM employees e
JOIN cruises c
ON e.employee_id = c.captain_id
JOIN addresses a USING (employee_id);
SELECT employee_id,
first_name,
last_name,
a.street_address,
a.city,
a.state,
a.zip
FROM employees
JOIN addresses a USING (employee_id)
JOIN cruises c
ON c.captain_id = employee_id;
-- 5. Update cruises set captain_id = 3;
UPDATE cruises SET captain_id = 3;
COMMIT;
-- 6. Return Cruise name and ID with captains employee id,
-- first and last names, street, city, state, zip (join on);
SELECT *
FROM addresses;
SELECT * FROM employees;
SELECT * FROM cruises;
SELECT c.cruise_name,
c.cruise_id,
e.employee_id,
e.first_name,
e.last_name,
a.street_address,
a.city,
a.state,
a.zip
FROM employees e
JOIN addresses a
ON e.employee_id = a.employee_id
JOIN cruises c
ON e.employee_id = c.captain_id;
-- 7a return captains name
SELECT c.cruise_name,
c.cruise_id,
e.employee_id,
e.first_name,
e.last_name,
a.street_address,
a.city,
a.state,
a.zip
FROM employees e
JOIN addresses a
ON e.employee_id = a.employee_id
JOIN cruises c
ON e.employee_id = c.captain_id;
-- 7b Return captains name, city, state, and start date, along with ship_name,
-- cruise_name, and port_name
SELECT e.last_name,
e.first_name,
a.city,
a.state,
w.start_date,
s.ship_name,
ship_id,
c.cruise_id,
c.cruise_name,
port_name
FROM addresses a
JOIN employees e
ON a.employee_id = e.employee_id
JOIN cruises c
ON e.employee_id = c.captain_id
JOIN ships s
ON c.ship_id = s.ship_id
JOIN ports p
ON s.home_port_id = p.port_id
JOIN work_history w
ON e.employee_id = w.employee_id
WHERE cruise_id= 2;
-- 8 For the port of Baltimore return
--Total cost of all projects (shown with dollars and commas)
--Avg cost per project (shown with dollars and commas)
--Toal number of projects
--Total number of man_hours (assume a crew of 5 people 8 hours per day)
SELECT *
FROM ports;
SELECT * FROM ships;
SELECT * FROM projects;
SELECT port_name ,
TO_CHAR(SUM(project_cost),'$999,999,999') total ,
TO_CHAR(AVG(project_cost),'$999,999') AVG ,
COUNT(port_id) numberprojects,
SUM(days)*40 manhours
FROM ports p
JOIN ships s
ON p.port_id = s.home_port_id
JOIN projects pj
ON s.ship_id= pj.ship_id
WHERE port_name = 'Baltimore'
GROUP BY port_name,
project_cost,
days;
SELECT port_name,
TO_CHAR(SUM(project_cost),'$999,999,999') total,
TO_CHAR(AVG(project_cost),'$999,999') AVG,
COUNT( *) NumberProjects,
SUM(days)*40 ManHours
FROM ports p ,
ships s ,
projects pj
WHERE p.port_id = s.home_port_id
AND s.ship_id = pj.ship_id
AND port_name = 'Baltimore'
GROUP BY port_name;
-- 9 Using just the scores table return the test score and letter grade
-- using a case statement and these rules
-- LETTER GRADE SCORE RANGE
-- ---------------------------------
--A 87-100
--B 75-86
--C 63-74
--D 51-62
--F 0-50
SELECT score_id ,
test_score ,
CASE
WHEN test_score > 87
THEN 'A'
WHEN test_score > 75
THEN 'B'
WHEN test_score > 63
THEN 'C'
WHEN test_score > 51
THEN 'D'
WHEN test_score >= 0
THEN 'F'
END AS grade
FROM scores;
SELECT
CASE test_score
WHEN '95'
THEN 'A'
WHEN '83'
THEN 'B'
WHEN '55'
THEN 'D'
END AS myscore
FROM scores;
SELECT
CASE
WHEN test_score BETWEEN 90 AND 100
THEN 'A'
WHEN test_score BETWEEN 80 AND 89
THEN 'B'
WHEN test_score BETWEEN 70 AND 79
THEN 'A'
END AS myscore
FROM scores;
DESC scores;
CREATE TABLE scores2
(score_id INTEGER, test_score INTEGER
);
INSERT INTO scores2 VALUES
(1, 95
);
INSERT INTO scores2 VALUES
(2, 85
);
INSERT INTO scores2 VALUES
(3, 75
);
SELECT
CASE test_score
WHEN 95
THEN 'A'
WHEN 85
THEN 'B'
WHEN 75
THEN 'D'
END AS myscore
FROM scores2;
SELECT
CASE
WHEN test_score >= 95
THEN 'A'
WHEN test_score >= 85
THEN 'B'
WHEN test_score >= 75
THEN 'D'
END AS myscore
FROM scores2;
DESC scores2;
SELECT
CASE
WHEN test_score BETWEEN 90 AND 100
THEN 'A'
WHEN test_score BETWEEN 80 AND 89
THEN 'B'
WHEN test_score BETWEEN 70 AND 79
THEN 'A'
END AS myscore
FROM scores2;
SELECT * FROM scores;
DESC scores;
-- 10. Disconnect from cruises
-- Connect to books
-- Return first and last names of customers with first and last name of who referred them
-- For those who were self-refered return null.
SELECT *
FROM CUSTOMERS;
SELECT * FROM customers c JOIN customers c1 ON c.customer# = c1.referred;
SELECT C1.CUSTOMER#,
C2.FIRSTNAME,
C2.LASTNAME,
C2.REFERRED REFERRED_BY,
C1.FIRSTNAME,
C1.LASTNAME
FROM customers c1
JOIN customers c2
ON c1.customer# = c2.referred;
SELECT C2.CUSTOMER#,
C2.FIRSTNAME,
C2.LASTNAME,
C2.REFERRED,
C1.FIRSTNAME,
C1.LASTNAME
FROM CUSTOMERS C1
RIGHT JOIN CUSTOMERS C2
ON C1.CUSTOMER# = C2.REFERRED;
SELECT C2.CUSTOMER#,
C2.FIRSTNAME,
C2.LASTNAME,
C1.FIRSTNAME,
C1.LASTNAME
FROM CUSTOMERS C1
RIGHT JOIN CUSTOMERS C2
ON c1.customer# = c2.referred;
SELECT C2.CUSTOMER#,
C2.FIRSTNAME,
C2.LASTNAME,
C1.FIRSTNAME,
C1.LASTNAME
FROM CUSTOMERS C1
right join customers c2
ON C1.CUSTOMER# = C2.REFERRED;








-- =============================================================================
-- Chapter 9
-- =============================================================================
-- page 350 top
SELECT ship_id
FROM employees
WHERE last_name = 'Lindon'
AND first_name= 'Alice';
-- page 350 bottom
SELECT employee_id,
last_name,
first_name
FROM employees
WHERE ship_id= 3
AND NOT (last_name = 'Lindon'
AND first_name = 'Alice');


-- page 351 top
SELECT employee_id,
last_name,
first_name
FROM employees
WHERE ship_id =
(SELECT ship_id
FROM employees
WHERE last_name = 'Lindon'
AND first_name= 'Alice'
-- where last_name = 'Smith'
)
AND NOT last_name = 'Lindon';
 
-- page 351 bottom
SELECT employee_id,
last_name,
first_name
FROM employees
WHERE ship_id =
( SELECT ship_id FROM employees WHERE last_name = 'Smith'
)
AND NOT last_name = 'Smith';
-- page 353
SELECT employee_id,
last_name,
first_name,
ssn
FROM employees
WHERE ship_id IN
( SELECT ship_id FROM employees WHERE last_name = 'Smith'
) ;
-- page 354 (same as page 353 with in operator)
SELECT ship_id,
last_name,
first_name
FROM employees
WHERE ship_id IN
( SELECT ship_id FROM employees WHERE last_name = 'Smith'
);

-- page 356
SELECT invoice_id
FROM invoices
WHERE (first_name, last_name ) IN
( SELECT first_name, last_name FROM cruise_customers
) ; -- empty set


select employee_id,first_name, last_name
FROM employees 
WHERE (first_name, last_name ) IN
( select first_name, last_name from cruise_customers
) ; -- empty set

select * from cruise_customers;

insert into criuses_customers values (10, 'Buffy', 'Worthington');

select vendor_name,
 (select terms_of_discount
from invoices_all i 
where i.account_number = v.vendor_id)
from vendors v;

select room_style, avg(sq_ft)
from ship_cabins
group by room_style;

SELECT *
from projects
WHERE project_cost >= ALL
(SELECT project_cost FROM projects WHERE purpose = 'Maintenance'
);




SELECT project_cost,
purpose
FROM projects
WHERE project_cost >= ALL
(SELECT project_cost FROM projects WHERE purpose = 'Upgrade'
);
;
SELECT project_cost, purpose FROM projects WHERE purpose = 'Upgrade';
-- page 357
SELECT * FROM invoices;
SELECT * FROM pay_history;
UPDATE invoices
SET invoice_date = '04-JUN-01',
total_price=37450
WHERE invoice_id = 7;
SELECT invoice_id
FROM invoices
WHERE (invoice_date, total_price ) =
( SELECT start_date, salary FROM pay_history WHERE pay_history_id = 4
) ; -- empty set
-- page 358
SELECT vendor_name,
(SELECT terms_of_discount FROM invoices WHERE invoice_id = 1
) AS discount
FROM vendors
ORDER BY vendor_name;


-- page 359
insert
into employees
(
employee_id,
ship_id
)
values
(
seq_employee_id.nextval,
(select ship_id from ships where ship_name = 'Codd Champion'
)
);
ROLLBACK;




-- page 361 top
select a.ship_cabin_id,
a.room_style,
a.room_number,
a.sq_ft
FROM ship_cabins a
WHERE a.sq_ft >
(select avg(sq_ft) 
 FROM ship_cabins 
 where room_style = a.room_style
)
 ORDER BY 2;

 select * from books;
 

select * 
from books b
where retail >=
 (select avg(retail)
 from books
 where catcode = b.catcode)
order by isbn;

update books b
set retail = retail *1.1
where retail <= (select avg(retail)
 from books
 where catcode = b.catcode);

select * from books
order by isbn;




-- page 361 bottom
SELECT room_style,
AVG(sq_ft)
FROM ship_cabins
GROUP BY room_style;
-- page 363
UPDATE invoices inv
SET terms_of_discount = '10 pct'
WHERE total_price =
(SELECT MAX(total_price)
FROM invoices
WHERE TO_CHAR(invoice_date, 'RRRR-Q') = TO_CHAR(inv.invoice_date, 'RRRR-Q')
);
ROLLBACK;
-- page 364
UPDATE ports p
SET capacity =
(SELECT COUNT(*) FROM ships WHERE home_port_id = p.port_id
)
WHERE EXISTS
( SELECT * FROM ships WHERE home_port_id = p.port_id
);



-- page 365 top


select *
FROM ship_cabins s1
WHERE s1.balcony_sq_ft =
(SELECT MIN(balcony_sq_ft)
FROM ship_cabins s2
WHERE s1.room_type = s2.room_type
AND s1.room_style= s2.room_style
);
ROLLBACK;

select * 
from books b1
where cost < (select avg(cost)
from books b2
where b1.catcode = b2.catcode);



select firstname, lastname, title, retail
from customers c join orders using (customer#)
join orderitems using (order#)
join books using (isbn)
where retail = (select min(retail) from books);





with
PORT_BOOKINGS AS (
SELECT P.PORT_ID, P.PORT_NAME, COUNT(S.SHIP_ID) CT
FROM PORTS P, SHIPS S
 WHERE P.PORT_ID = S.HOME_PORT_ID
 GROUP BY P.PORT_ID, P.PORT_NAME
 ),
 densest_port as (
 SELECT MAX(CT) MAX_CT
 FROM PORT_BOOKINGS
 )
 SELECT PORT_NAME
 FROM PORT_BOOKINGS
 WHERE CT = (SELECT MAX_CT FROM DENSEST_PORT);


 -- page 365 bottom
SELECT port_id,
port_name
FROM ports p1
WHERE EXISTS
(SELECT * FROM ships s1 WHERE p1.port_id = s1.home_port_id
);
-- page 366
WITH port_bookings AS
(SELECT p.port_id,
p.port_name,
COUNT(s.ship_id) ct
FROM ports p,
ships s
WHERE p.port_id = s.home_port_id
GROUP BY p.port_id,
p.port_name
),
densest_port AS
( SELECT MAX(ct) max_ct FROM port_bookings
)
SELECT port_name
FROM port_bookings
WHERE ct =
(SELECT max_ct FROM densest_port
);
-- -----------------------------------------------------------------------------
-- HANDS ON EXERCISES CHAPTER 9
-- ----------------------------------------------------------------------------
-- 3. Return all columns from ports that has a capacity > avg capacity for all ports
SELECT *
FROM ports
WHERE capacity >
( SELECT AVG(capacity) FROM ports
);
-- 2. What is the name of Al Smith's captain on cruise_id = 4?
-- Return the ship_id, cruise_id, the captains first and last name
SELECT *
FROM cruises;
-- captain_id = 3
SELECT * FROM employees;
-- mike west (emp_id 3) and al smith (emp_id 5) both have 4 (ship_id)
SELECT e.ship_id,
c.cruise_id,
c.captain_id,
e.first_name,
e.last_name
FROM cruises c
JOIN employees e
ON c.captain_id = e.employee_id
WHERE e.ship_id =
(SELECT ship_id
FROM employees
WHERE first_name = 'Al'
AND last_name= 'Smith'
)
AND cruise_id = 4;
-- 3. Return all columns from ship cabins that has bigger than the avg
--size balcony for the same room type and room style
SELECT *
FROM ship_cabins s
WHERE balcony_sq_ft >
(SELECT AVG(balcony_sq_ft)
FROM ship_cabins
WHERE s.room_type = room_type
AND s.room_style= room_style
);
SELECT room_type,
room_style,
AVG(balcony_sq_ft)
FROM ship_cabins
GROUP BY room_style,
room_type;
SELECT * FROM ship_cabins;
SELECT *
FROM ship_cabins s1
WHERE s1.balcony_sq_ft >=
(SELECT AVG(balcony_sq_ft)
FROM ship_cabins s2
WHERE s1.room_type = s2.room_type
AND s1.room_style= s2.room_style
);
-- 4. Return employee id and ship id from work_history
--for the employee who has the worked the longest on that ship
SELECT *
FROM work_history;
SELECT employee_id,
ship_id
FROM work_history w
WHERE (end_date - start_date) =
(SELECT MAX(end_date-start_date) FROM work_history WHERE w.ship_id = ship_id
) ;
SELECT employee_id,
ship_id
FROM work_history w1
WHERE ABS(start_date - end_date) =
(SELECT MAX(ABS(start_date - end_date))
FROM work_history
WHERE ship_id = w1.ship_id
);
SELECT employee_id,
ship_id
FROM work_history w1
WHERE ABS(start_date - end_date) >= ALL
(SELECT ABS(start_date - end_date)
FROM work_history
WHERE ship_id = w1.ship_id
);
--5. Return ship_name and port_name
-- for the ship with the maximum capacity in each home_port
-- ----------------------------------------------------------------------------
SELECT s1.ship_name,
(SELECT port_name FROM ports WHERE port_id = s1.home_port_id
) home_port
FROM ships s1
WHERE s1.capacity =
( SELECT MAX(capacity) FROM ships s2 WHERE s2.home_port_id = s1.home_port_id
);
-- ----------------------------------------------------------------------------
SELECT sh.ship_name,
pt.port_name,
sh.capacity
FROM ships sh
JOIN ports pt
ON sh.home_port_id= pt.port_id
WHERE (sh.home_port_id, sh.capacity) IN
( SELECT home_port_id, MAX(capacity) FROM ships GROUP BY home_port_id
);
-- ----------------------------------------------------------------------------
SELECT s1.ship_name,
port_name
FROM ports p
JOIN ships s1
ON p.port_id= s1.home_port_id
WHERE s1.capacity =
( SELECT MAX(capacity) FROM ships s2 WHERE s2.home_port_id = s1.home_port_id
);
SELECT * FROM ships;
SELECT home_port_id, MAX(capacity) FROM ships s2 GROUP BY home_port_id;
-- -----------------------------------------------------------------------------
-- DO HAND ON EXERCISES Chapter 7 (slides) handouts at home for Saturday
-- -----------------------------------------------------------------------------
-- 1
-- Books with retail < average retail for all books
SELECT title,
Retail
FROM Books
WHERE Retail <
(SELECT AVG(Retail) FROM Books
)
ORDER BY 1;
-- 2
-- Books that cost < than other books in same category
SELECT title,
b1.catcode,
cost,
Avgcost
FROM books b1 ,
( SELECT catcode, AVG(Cost) Avgcost FROM Books GROUP BY catcode
) b2
WHERE b1.catcode = b2.catcode
AND b1.cost< b2.avgcost;
SELECT title, cost FROM books WHERE catcode = 'COM';
-- 3
-- Orders shippd to same state as order 1014
SELECT order#,
shipstate
FROM orders
WHERE shipstate =
( SELECT shipstate FROM orders WHERE order# = 1014
);
-- 4
-- Orders with total amount > order 1008
SELECT oi.order# ,
SUM(retail*quantity) total2
FROM orderitems oi ,
books b1
WHERE 1 =1
AND oi.isbn = b1.isbn
GROUP BY oi.order#
HAVING SUM(retail *quantity) >
(SELECT SUM(retail*quantity) total1
FROM orderitems oi ,
books b
WHERE oi.isbn = b.isbn
AND order#= 1008
-- group by order#
);
SELECT oi.order# ,
SUM(retail*quantity) total2
FROM orderitems oi
JOIN books b1 USING (isbn)
GROUP BY oi.order#
HAVING SUM(retail *quantity) >
(SELECT SUM(retail*quantity) total1
FROM orderitems oi
JOIN books b USING (isbn)
WHERE order# = 1008
);
-- 5
-- Which author(s) wrote most frequently purchased book(s)
SELECT oi.isbn,
lname,
fname,
SUM(quantity) qty
FROM orderitems oi ,
books b ,
bookauthor ba ,
author a
WHERE oi.isbn = b.isbn
AND ba.isbn = b.isbn
AND ba.authorid = a.authorid
GROUP BY oi.isbn,
lname,
fname
HAVING SUM(quantity) =
(SELECT MAX(SUM(quantity)) qty FROM orderitems GROUP BY isbn
);
SELECT title,
oi.isbn,
lname,
fname,
SUM(quantity) qty
FROM orderitems oi
JOIN books b
ON oi.isbn = b.isbn
JOIN bookauthor ba
ON ba.isbn = b.isbn
JOIN author a
ON a.authorid = ba.authorid
GROUP BY title,
oi.isbn,
lname,
fname
HAVING SUM(quantity) =
(SELECT MAX(SUM(quantity)) qty FROM orderitems GROUP BY isbn
);
SELECT title,
isbn,
lname,
fname,
SUM(quantity) qty
FROM orderitems oi
JOIN books b USING (isbn)
JOIN bookauthor ba USING (isbn)
JOIN author a USING(authorid)
GROUP BY title,
isbn,
lname,
fname
HAVING SUM(quantity) =
(SELECT MAX(SUM(quantity)) qty FROM orderitems GROUP BY isbn
);
-- test count
SELECT b.title,
b.isbn,
SUM(quantity) qty
FROM orderitems oi ,
books b
WHERE oi.isbn = b.isbn
GROUP BY b.title,
b.isbn;
-- test author
SELECT title,
lname,
fname
FROM books b ,
bookauthor ba ,
author a
WHERE b.isbn= ba.isbn
AND ba.authorid = a.authorid
AND b.isbn LIKE '%490';
-- 6
-- All titles in same cat customer 1007 purchased. Do not include titles purchased by customer 1007.
SELECT DISTINCT title,
catcode
FROM books
JOIN orderitems USING(isbn)
JOIN orders USING (order#)
WHERE catcode IN
(SELECT catcode
FROM orders
JOIN orderitems USING (order#)
JOIN books USING (isbn)
WHERE customer# = 1007
)
AND customer# <> 1007 ;
SELECT DISTINCT title
FROM orders
JOIN orderitems USING(order#)
JOIN books USING(isbn)
WHERE CATCODE IN ('FAL', 'COM', 'CHN')
AND customer# <> 1007;
SELECT DISTINCT (b.title)
FROM books b ,
(SELECT title,
catcode
FROM orders o ,
orderitems oi ,
books b
WHERE o.order# = oi.order#
AND oi.isbn= b.isbn
AND customer#= 1007
) b1
WHERE b.catcode = b1.catcode;
AND b.title<> b1.title;
-- everything purchased by customer 1007
SELECT title,
catcode
FROM orders o ,
orderitems oi ,
books b
WHERE o.order# = oi.order#
AND oi.isbn= b.isbn
AND customer#= 1007;
-- 7
-- Customer(s) with city and state that had longest shipping delay
SELECT c.customer#,
city,
state,
shipdate,
orderdate,
shipdate - orderdate delay
FROM orders o ,
customers c
WHERE o.customer#= c.customer#
AND (shipdate - orderdate) =
(SELECT MAX(shipdate - orderdate) delay FROM orders
);
SELECT CUSTOMER#,
CITY,
STATE,
SHIPDATE,
ORDERDATE,
SHIPDATE - ORDERDATE delay
FROM ORDERS
JOIN CUSTOMERS USING (CUSTOMER#)
WHERE (SHIPDATE - ORDERDATE) =
(SELECT MAX(SHIPDATE - ORDERDATE) delay FROM ORDERS
);
SELECT MAX(SHIPDATE-ORDERDATE) FROM orders;
SELECT * FROM CRUISE_ORDERS;
DESC CRUISE_ORDERS;
ALTER TABLE CRUISE_ORDERS
DROP column FIST_TIME_CUSTOMER;
DESC CRUISE_ORDERS;
ROLLBACK;
-- 8
-- Who purchased least expensive book(s)
SELECT firstname,
lastname,
title
FROM customers c
JOIN orders o USING (customer#)
JOIN orderitems oi USING (order#)
JOIN books b USING (isbn)
WHERE retail =
(SELECT MIN (retail) FROM books
);
SELECT firstname,
lastname,
title
FROM customers c ,
orders o ,
orderitems oi ,
books b
WHERE c.customer# = o.customer#
AND o.order#= oi.order#
AND oi.isbn = b.isbn
AND retail=
(SELECT MIN (retail) FROM books
);
-- 9
-- How many customers purchased books written/co-written by James Austin
SELECT COUNT(DISTINCT customer#)
FROM orders
JOIN orderitems USING (order#)
JOIN books USING (isbn)
WHERE title IN
(SELECT title
FROM author
JOIN bookauthor USING(authorid)
JOIN books USING(isbn)
WHERE lname = 'AUSTIN'
AND fname = 'JAMES'
);
-- ------------------------------------------------------------------
SELECT COUNT(DISTINCT customer#)
FROM orders
JOIN
(SELECT title,
order#
FROM orders
JOIN orderitems USING (order#)
JOIN books USING(isbn)
JOIN bookauthor USING (isbn)
JOIN author USING (authorid)
WHERE lname = 'AUSTIN'
AND fname = 'JAMES'
) USING (order#);
-- --------------------------------------------------------------------------
SELECT COUNT(DISTINCT customer#)
FROM orders
JOIN orderitems USING (order#)
JOIN books USING (isbn)
JOIN bookauthor USING (isbn)
JOIN author USING (authorid)
WHERE lname = 'AUSTIN'
AND fname = 'JAMES';
SELECT COUNT (DISTINCT customer#)
FROM orders o ,
orderitems oi
WHERE o.order# = oi.order#
AND oi.isbn IN
( SELECT DISTINCT b.isbn
FROM books b ,
bookauthor ba ,
author a
WHERE ba.isbn = b.isbn
AND ba.authorid = a.authorid
AND lname = 'AUSTIN'
AND fname = 'JAMES'
);
-- books written by James Austin
SELECT DISTINCT b.isbn
FROM books b ,
bookauthor ba ,
author a
WHERE ba.isbn = b.isbn
AND ba.authorid = a.authorid
AND lname = 'AUSTIN'
AND fname = 'JAMES';
-- 10
-- Which books by same publisher as 'The Wok Way to Cook'
SELECT title
FROM books
WHERE pubid =
(SELECT pubid
FROM publisher
JOIN books USING (pubid)
WHERE title = 'THE WOK WAY TO COOK'
);
SELECT title
FROM books
WHERE pubid =
( SELECT pubid FROM books WHERE title = 'THE WOK WAY TO COOK'
);
SELECT title
FROM books
WHERE pubid =
(SELECT pubid FROM books WHERE title = 'THE WOK WAY TO COOK'
);
-- publisher of 'The Wok Way to Cook'
SELECT pubid
FROM books
WHERE title = 'THE WOK WAY TO COOK';
-- -----------------------------------------------------------------------
-- a case for oracle chapter 7
-- -----------------------------------------------------------------------
-- 1.5% surcharge of all orders = $25.90
SELECT SUM(quantity * retail) * .015
FROM orderitems
JOIN books USING(isbn);
SELECT SUM(thissum) * .04
FROM
(SELECT order#,
SUM(quantity * retail) thissum
FROM orderitems
JOIN books USING(isbn)
HAVING SUM(quantity * retail) >
(SELECT AVG(mysum)
FROM
(SELECT SUM(quantity * retail) mysum
FROM orderitems
JOIN books USING(isbn)
GROUP BY order#
)
)
GROUP BY order#
);
SELECT SUM(quantity * retail) * .015
FROM orderitems oi ,
books b
WHERE oi.isbn = b.isbn;
-- 3. sum orders above average = $58.44
SELECT SUM(ordertot) * .04
FROM
(SELECT order#,
SUM(quantity * retail) ordertot
FROM orderitems oi ,
books b
WHERE oi.isbn = b.isbn
GROUP BY order#
HAVING SUM(quantity * retail) >
(SELECT AVG(quantity * retail) FROM orderitems JOIN books USING(isbn)
)
);
-- 2. orders above average
SELECT order#,
SUM(quantity * retail) ordertot
FROM orderitems oi ,
books b
WHERE oi.isbn = b.isbn
GROUP BY order#
HAVING SUM(quantity* retail) >
(SELECT AVG(quantity * retail)
FROM orderitems oi ,
books b
WHERE oi.isbn = b.isbn
);
-- 1. avg order
SELECT AVG(quantity * retail)
FROM orderitems oi ,
books b
WHERE oi.isbn = b.isbn;
-- 0. total amount of all orders
SELECT SUM(quantity * retail)
FROM orderitems oi ,
books b
WHERE oi.isbn = b.isbn;






























-- =============================================================================
-- Chapter 10
-- =============================================================================
-- page 383
create view vw_employees as
select employee_id, 
 last_name, 
 first_name, 
 primary_phone 
from employees
order by 1;

select * 
from vw_employees
order by 1;

desc vw_employees;




DROP VIEW vw_employees;
DESC vw_employees;
-- page 384
SELECT * FROM vw_employees;
SELECT employee_id, first_name || ' ' || last_name FROM vw_employees;
-- page 385 top
CREATE OR REPLACE VIEW vw_employees
AS
SELECT employee_id,
last_name
|| ' '
|| first_name emp_name,
primary_phone
FROM employees;


-- page 385 bottom
CREATE VIEW emp_trend AS
SELECT emp.ship_id,
MIN(salary) min_salary
FROM employees emp
LEFT JOIN pay_history pay
ON emp.employee_id = pay.employee_id
WHERE end_dateIS NULL
GROUP BY emp.ship_id;
-- page 387 top
CREATE OR REPLACE VIEW emp_phone_book
AS
SELECT last_name, first_name, primary_phone FROM employees;
-- page 387 top
INSERT
INTO emp_phone_book
(
last_name,
first_name,
primary_phone
)
VALUES
(
'Sotogovernor',
'Sonia',
'212-555-1212'
);
-- page 387 bottom
UPDATE emp_phone_book
SET primary_phone = '212-555-1212'
WHERE last_name = 'Hoddlestein'
AND first_name= 'Howard';
-- page 387 bottom add_on
DELETE
FROM emp_phone_book
WHERE last_name = 'Hoddlestein'
AND first_name= 'Howard';
-- page 388
CREATE OR REPLACE VIEW emp_phone_book
AS
SELECT employee_id,
first_name
|| ' '
|| last_name emp_name,
primary_phone
FROM employees;
CREATE OR REPLACE VIEW emp_phone_book
AS
SELECT employee_id,
first_name,
last_name emp_name,
primary_phone
FROM employees;
-- page 390 top
SELECT a.ship_id,
a.count_cabins,
b.count_cruises
FROM
(SELECT ship_id,
COUNT(ship_cabin_id) count_cabins
FROM ship_cabins
GROUP BY ship_id
) a
JOIN
(SELECT ship_id,
COUNT(cruise_order_id) count_cruises
FROM cruise_orders
GROUP BY ship_id
) b
ON a.ship_id = b.ship_id;
-- page 391 top
SELECT rownum,
invoice_id,
account_number
FROM
( SELECT invoice_id, account_number FROM invoices ORDER BY invoice_date
)
WHERE rownum <= 3;
-- page 392 do this before leaving views
-- -----------------------------------------------------------------------------
-- Key preserved table
-- view when more than one table
-- If you can assert that a given row in a table will appear at most
-- once in the view -- that table is "key preserved" in the view.
-- key preserved table example
CREATE TABLE shoppers
(
pidINTEGER,
pnameVARCHAR2(11 BYTE),
paddress VARCHAR2(11 BYTE),
CONSTRAINT people_pid_PK PRIMARY KEY (pid)
);
DROP TABLE shoppers;
BEGIN
INSERT INTO shoppers
(pid, pname, paddress
) VALUES
(10,'albert','123 main'
);
INSERT INTO shoppers
(pid, pname, paddress
) VALUES
(11,'betty','456 main'
);
INSERT
INTO shoppers
(
pid,
pname,
paddress
)
VALUES
(
12,
'charley',
'789 main'
);
END;

CREATE TABLE invoices
(
iid INTEGER,
pid INTEGER,
istoreVARCHAR2(10 byte),
istorenum INTEGER,
icity VARCHAR2(10 byte),
iamount NUMBER,
CONSTRAINT invoices_iid_PK PRIMARY KEY (iid)
);
DROP TABLE invoices;
BEGIN
INSERT
INTO invoices
(
iid,
pid,
istore,
istorenum,
icity,
iamount
)
VALUES
(
20,10,
'kmart',
4000,
'Austin',
45.55
);
INSERT
INTO invoices
(
iid,
pid,
istore,
istorenum,
icity,
iamount
)
VALUES
(
30,11,
'sears',
5000,
'Austin',
12.67
);
INSERT
INTO invoices
(
iid,
pid,
istore,
istorenum,
icity,
iamount
)
VALUES
(
40,12,
'lowes',
6000,
'Austin',
22.99
);
END;
/
-- one to many
ALTER TABLE invoices ADD CONSTRAINT invoices_shoppers_pid FOREIGN KEY
(
pid
)
REFERENCES shoppers
(
pid
)
;
SELECT * FROM invoices;
-- can't do this because duplicate column name
CREATE OR REPLACE VIEW vw_shoppers
AS
SELECT * FROM shoppers s , invoices i WHERE s.pid = i.pid;
-- can do this because no duplicate column name
CREATE OR REPLACE VIEW vw_shoppers
AS
SELECT s.pid pid,
pname,
paddress,
iid,
istore,
istorenum,
icity,
iamount
FROM shoppers s ,
invoices i
WHERE s.pid = i.pid;
-- fails not key preserved
UPDATE vw_shoppers
SET pname = 'Delpha'
WHERE pid = 10;
-- only one possible row where id = 40 in underlying table
UPDATE vw_shoppers
SET istore= 'BnN'
WHERE istorenum = 4000;
UPDATE vw_shoppers SET istorenum = '7777' WHERE iid = 40;
UPDATE vw_shoppers SET icity = 'Houston' WHERE iid = 40;
UPDATE vw_shoppers SET iamount = 99.99 WHERE iid = 40;
-- -----------------------------------------------------------------------------
-- page 398 middle
CREATE TABLE myseminars
(
seminar_id INTEGER PRIMARY KEY,
seminar_name VARCHAR2(30) UNIQUE
);
-- page 398 bottom
SELECT table_name,
index_name
FROM user_indexes
WHERE table_name = 'MYSEMINARS';
-- page 399 top
SELECT index_name,
column_name
FROM user_ind_columns
WHERE table_name = 'MYSEMINARS';
SELECT index_name,
column_name
FROM user_ind_columns
WHERE table_name = 'CRUISE_CUSTOMERS';
-- page 400 middle
CREATE INDEX ix_invoice_invoice_vendor_id ON invoices
(
vendor_id,
invoice_date
);
SELECT index_name,
column_name
FROM user_ind_columns
WHERE table_name = 'INVOICES';

drop sequence junk;

create sequence JUNK 
minvalue 5
maxvalue 10 
nocache
increment by 1 
start with 6
cycle ;

select junk.currval from dual;
select junk.nextval from dual;


select * from user_indexes
where table_name = 'CRUISES';

select * 
from user_ind_columns
where table_name = 'CRUISES';



















































































-- =============================================================================
-- Chapter 11
-- =============================================================================
-- page 426 preparation
SELECT *
from cruise_orders;

create table cruise_orders2 as 
select * from cruise_orders;

alter table cruise_orders2
add constraint pk_new_constraint
primary key (cruise_order_id, cruise_customer_id);

select * from cruise_orders2;
delete from cruise_orders2;


alter table ships drop constraint fk_ships_ports cascade;
create index ix_cc_last_name on cruise_customers (upper(last_name));


BEGIN
INSERT INTO cruise_orders VALUES
(1,sysdate,sysdate, 1, 4
);
INSERT INTO cruise_orders VALUES
(2,sysdate,sysdate, 2, 4
);
INSERT INTO cruise_orders VALUES
(3,sysdate,sysdate, 3, 4
);
INSERT INTO cruise_orders VALUES
(4,sysdate,sysdate, 1, 4
);
INSERT INTO cruise_orders VALUES
(5,sysdate,sysdate, 2, 4
);
END;
/
COMMIT;
-- page 426 top
ALTER TABLE cruise_orders ADD first_time_customer VARCHAR2
(
5
)
DEFAULT 'YES' NOT NULL;
ALTER TABLE cruise_orders MODIFY order_date DEFAULT 'sysdate' NOT NULL;
DESC cruise_orders;
-- page 426 bottom
ALTER TABLE cruise_orders ADD fist_time_customer VARCHAR2
(
5
)
DEFAULT 'YES' NOT NULL ;
DESC cruise_orders;
INSERT INTO cruise_orders
(cruise_order_id
) VALUES
(10
);
SELECT * FROM cruise_orders;
DESC cruise_orders;
ALTER TABLE cruise_orders MODIFY (cruise_customer_id NUMBER(9),ship_id NUMBER(9));
DESC cruise_orders;
ALTER TABLE cruise_orders;
-- page 438
CREATE TABLE junk
( id INTEGER, tid INTEGER, mid INTEGER
);
DROP TABLE junk;
CREATE TABLE junkfk
( id INTEGER, fkid INTEGER, mid INTEGER
);
DROP TABLE junkfk;
-- -----------------------------------------------------------------------------
-- inline constraints
ALTER TABLE junk MODIFY id PRIMARY KEY;
ALTER TABLE junk MODIFY id CONSTRAINT pk_new PRIMARY KEY;
ALTER TABLE junk MODIFY id NOT NULL;
ALTER TABLE junk MODIFY id CONSTRAINT nn_mynew NOT NULL;
ALTER TABLE junkfk MODIFY id PRIMARY KEY;
-- -----------------------------------------------------------------------------
-- out-of-line constraints
ALTER TABLE junk ADD CONSTRAINT pk_new PRIMARY KEY (id);
ALTER TABLE junk ADD CONSTRAINT pk_new PRIMARY KEY (id, id);
-- check
ALTER TABLE junk ADD CONSTRAINT ck_wrong CHECK (tid < id);
-- null will not work
-- alter table junk add constraint nn_wrong not null (tid);
-- fk
ALTER TABLE junkfk ADD CONSTRAINT fk_junk FOREIGN KEY(fkid) REFERENCES junk(id);
-- must have a primary key in other table first
--page 441
DROP TABLE junk CASCADE CONSTRAINTS;
DROP TABLE junkfk;
ALTER TABLE
DROP junk
DROP PRIMARY KEY CASCADE;
-- will not work
-- alter table junk drop primary key;
ALTER TABLE junk
DROP PRIMARY KEY CASCADE;
-- page 442
ALTER TABLE junk MODIFY id NOT NULL;
ALTER TABLE junk MODIFY id NULL;
--page 443
CREATE TABLE ports2
(
port_id NUMBER(7),
port_name VARCHAR2(20),
CONSTRAINT pk_ports PRIMARY KEY (port_id)
);
DROP TABLE ports2 CASCADE CONSTRAINTS;
CREATE TABLE ships2
(
ship_idNUMBER(7),
ship_nameVARCHAR2(20),
home_port_id NUMBER(7),
CONSTRAINT pk_ships PRIMARY KEY (ship_id),
CONSTRAINT fk_sh_po FOREIGN KEY (home_port_id) REFERENCES ports2 (port_id)
);
DROP TABLE ships2;
BEGIN
INSERT INTO ports2 VALUES
(50, 'Jacksonville'
);
INSERT INTO ports2 VALUES
(51, 'New Orleans'
);
INSERT INTO ships2 VALUES
(10, 'Codd Royale', 50
);
INSERT INTO ships2
(ship_id, ship_name
) VALUES
(11, 'Codd Ensign'
);
END;
/
DELETE FROM ports2 WHERE port_id = 50;
DELETE FROM ports2 WHERE port_id = 51;
-- page 450
SELECT table_name,
constraint_name,
constraint_type
FROM user_constraints
WHERE r_constraint_name IN
(SELECT constraint_name
FROM user_constraints
WHERE table_name= 'PORTS2'
AND constraint_type = 'P'
);
ALTER TABLE ships2
DROP CONSTRAINT fk_sh_po;
ALTER TABLE ships2 ADD CONSTRAINT fk_sh_po FOREIGN KEY (home_port_id) REFERENCES ports2 (port_id) ON
DELETE CASCADE;
SELECT * FROM ports2;
SELECT * FROM ships2;
DELETE FROM ports2 WHERE port_id = 50;
ROLLBACK;
-- page 455
-- in-line syntax
CREATE TABLE invoices2
(
invoice_id NUMBER(11) PRIMARY KEY USING INDEX
(CREATE INDEX ix_invoices ON invoices2
(invoice_id
)
),
invoice_date DATE
);
-- page 456
-- out-of-line syntax
CREATE TABLE invoices3
(
invoice_id NUMBER(11),
invoice_date DATE,
CONSTRAINT ck_invs_inv_id PRIMARY KEY (invoice_id) USING INDEX
(CREATE INDEX ix_invoices3 ON invoices3
(invoice_id
)
)
);
-- page 457 top
CREATE TABLE customers2
(
customer_id NUMBER(11) PRIMARY KEY,
last_name VARCHAR2(30)
);
CREATE INDEX ix_customers_last_name ON customers
(upper(last_name)
);
-- page 457 bottom
CREATE TABLE gas_tanks
(
gas_tank_idNUMBER(7),
tank_gallons NUMBER(9),
mileageNUMBER(9)
);
CREATE INDEX ix_gas_tanks_001 ON gas_tanks
(tank_gallons * mileage
);
-- page 460
CREATE TABLE houdini
( voila VARCHAR2(30)
);
INSERT INTO houdini
(voila
) VALUES
('Now you see it.'
);
COMMIT;
SELECT * FROM houdini;
DROP TABLE houdini;
flashback TABLE houdini TO before
DROP;
SELECT * FROM houdini;
-- page 461
SELECT * FROM user_recyclebin;
SELECT * FROM recyclebin;
-- page 463
CREATE TABLE houdini2
(voila VARCHAR2(30)
) enable row movement;
INSERT INTO houdini2
(voila
) VALUES
('Now you see it.'
);
COMMIT;
EXECUTE dbms_lock.sleep(15);
DELETE FROM houdini2;
COMMIT;
EXECUTE dbms_lock.sleep(15);
flashback TABLE houdini2 TO TIMESTAMP systimestamp - interval '0 00:00:20' DAY TO second;
-- doesn't work because flashback is not enabled by default
-- in APEX
SELECT ora_rowscn,
voila
FROM houdini;
SELECT * FROM all_directories;
CREATE TABLE cruises2 AS
SELECT * FROM cruises;
DESC cruises2;
ALTER TABLE cruises2 SET unused column status;
flashback TABLE cruises2 TO TIMESTAMP systimestamp - interval '0 00:05:00' DAY TO second;
DROP TABLE cruises2;
flashback TABLE cruises2 TO before
DROP;
SELECT * FROM recyclebin;
purge recyclebin;
CREATE RESTORE POINT my_restore;
CREATE TABLE houdini3
(voila VARCHAR2(30)
) enable row movement;
INSERT INTO houdini3
(voila
) VALUES
('Now you see it'
);
flashback TABLE houdini3 TO TIMESTAMP systimestamp - interval '0 00:01:30' DAY TO second;
SELECT * FROM houdini3;
-- -----------------------------------------------------------------------------
-- E X T E R N A L T A B L E
-- -----------------------------------------------------------------------------
-- page 472
-- -----------------------------------------------------------------------------
-- 1. First physically create the directory c:\temp
-- -----------------------------------------------------------------------------
-- 2. Then login as system and do:
-- A. CREATE OR REPLACE DIRECTORY BANK_FILES AS 'C:\temp';
CREATE OR REPLACE DIRECTORY BANK_FILES
AS
'C:\temp';
-- B. GRANT READ, WRITE ON DIRECTORY BANK_FILES TO CRUISES;
GRANT READ,
WRITE ON DIRECTORY BANK_FILES TO CRUISES;
-- -----------------------------------------------------------------------------
-- 3. Create the external table
-- drop table INVOICES_EXTERNAL;
CREATE TABLE invoices_external
(
invoice_id CHAR(6),
invoice_date char(13),
invoice_amt CHAR(9),
account_number CHAR(11)
)
organization external
(
type oracle_loader default directory bank_files 
access parameters (records delimited by newline skip 2 fields 
( invoice_id CHAR(6), invoice_date CHAR(13), invoice_amt CHAR(9), account_number CHAR(11)) )
-- make sure there are no extra lines that might be interpreted as null later when loading into PK
location ('load_invoices.txt')
);
DROP TABLE invoices_external;
-- -----------------------------------------------------------------------------
-- 4. Create the internal table from the external table
DROP TABLE invoices_internal;

CREATE TABLE invoices_internal AS
SELECT * FROM invoices_external;

select * from recyclebin;

select * from invoices_internal where invoice_id is null;
select count(*) from invoices_external;
select count(*) from invoices_internal;
-- -----------------------------------------------------------------------------
-- 5. Create a new table with datatypes we want
DROP TABLE invoices_revised;
CREATE TABLE invoices_revised
    (
          invoice_id INTEGER,
          invoice_date date,
          invoice_amt NUMBER,
          account_number VARCHAR(13)
    );
SELECT COUNT(*) FROM invoices_external;
SELECT COUNT(*) FROM invoices_internal;
-- -----------------------------------------------------------------------------
-- 6. Insert into the new table
truncate table invoices_revised;



insert into invoices_revised (invoice_id, invoice_date, invoice_amt, account_number)
  select invoice_id ,to_date(invoice_date,'mm/dd/yyyy'), to_number(invoice_amt), account_number
  from invoices_internal;





-- Done
select * from invoices_internal;
select count(*) from invoices_revised;
commit;
-- -----------------------------------------------------------------------------
select * from ships;
select capacity, home_port_id 
from ships
union
select  '---', port_id
from ports;






















































-- =============================================================================
-- Chapter 12
-- =============================================================================
select * from contact_emails;
-- ------------------------------
select * from online_subscribers;
-- ------------------------------
SELECT contact_email_id,
email_address
FROM contact_emails
WHERE status = 'Valid'
UNION
SELECT online_subscriber_id, email FROM online_subscribers;
-- ------------------------------
SELECT contact_email_id, email_address FROM contact_emails
UNION
SELECT online_subscriber_id, email FROM online_subscribers;
-- ------------------------------
SELECT contact_email_id, email_address FROM contact_emails
UNION ALL
SELECT online_subscriber_id, email FROM online_subscribers;
-- ------------------------------
SELECT email_address FROM contact_emails
union
SELECT email FROM online_subscribers;
-- ------------------------------
SELECT email_address FROM contact_emails
INTERSECT
select email from online_subscribers;
-- ------------------------------
SELECT email FROM online_subscribers
intersect
SELECT email_address FROM contact_emails;
-- ------------------------------
SELECT email_address FROM contact_emails;
-- ------------------------------
SELECT email FROM online_subscribers;
-- ------------------------------
select email_address from contact_emails
MINUS
SELECT email FROM online_subscribers ORDER BY email_address;
-- ------------------------------
SELECT email FROM online_subscribers
minus
SELECT email_address FROM contact_emails;
-- ------------------------------
SELECT email FROM online_subscribers
minus
SELECT email_address
FROM contact_emails
ORDER BY email;
-- ------------------------------
(select product from store_inventory
UNION ALL
SELECT item_name FROM furnishings
)
INTERSECT
( SELECT item_name FROM furnishings WHERE item_name = 'Towel'
UNION ALL
SELECT item_name FROM furnishings WHERE item_name = 'Towel'
);







































-- =============================================================================
-- Chapter 13
-- =============================================================================
-- -----------------------------------------------------------------------------
--ROLLUP 1 C O L U M N
-- -----------------------------------------------------------------------------

-- find some rows to deal with 
select room_style, sq_ft 
from ship_cabins 
where ship_cabin_id < 7 and ship_cabin_id > 3
order by 1;

-- then revisit the group by and aggregate function SUM
-- page 513 top 1 col ROOM_STYLE
select room_style, sum(sq_ft) sq_ft
from ship_cabins
WHERE ship_cabin_id < 7 and ship_cabin_id > 3
GROUP BY room_style
ORDER BY 1;

-- now try adding ROLLUP ROOM_STYLE
-- page 513 bottom 1 col
SELECT room_style, SUM(sq_ft) sq_ft
FROM ship_cabins
WHERE ship_cabin_id < 7 and ship_cabin_id > 3
GROUP BY rollup (room_style)
order by room_style;

-- ------------------------------------------
-- Try the same steps with ROOM_TYPE
-- ------------------------------------------
-- page 513 top 1 col ROOM_TYPE
-- find some rows to deal with 
select room_type, sq_ft 
from ship_cabins
where ship_cabin_id < 7 and ship_cabin_id > 3
order by 1;

SELECT room_type,SUM(sq_ft) sq_ft
FROM ship_cabins
where ship_cabin_id < 7 and ship_cabin_id > 3
GROUP BY room_type
ORDER BY room_type;

SELECT room_type, SUM(sq_ft) sq_ft
from ship_cabins
WHERE ship_cabin_id < 7 and ship_cabin_id > 3
group by rollup (room_type)
ORDER BY room_type;


-- -----------------------------------------------------------------------------
-- ROLLUP 2 C O L U M N S
-- -----------------------------------------------------------------------------
-- find some rows 
SELECT room_style,room_type,sq_ft
FROM ship_cabins
where ship_cabin_id < 7 and ship_cabin_id > 3;

-- group by ROOM_STYLE, ROOM_TYPE
SELECT room_style,room_type,SUM(sq_ft) sq_ft
FROM ship_cabins
WHERE ship_cabin_id < 7 and ship_cabin_id > 3
group by room_style, room_type
ORDER BY room_style,room_type;

-- rollup by ROOM_STYLE, ROOM_TYPE
SELECT room_style, room_type, SUM(sq_ft) sum_sq_ft
from ship_cabins
WHERE ship_cabin_id < 7 and ship_cabin_id > 3
group by rollup(room_style, room_type)
order by room_style, room_type;

-- -----------------------------------------------------------------------------
-- ROLLUP 2 C O L U M N S Reverse column order
-- -----------------------------------------------------------------------------
-- find some rows 
select room_type,room_style,sq_ft
from ship_cabins
WHERE ship_cabin_id < 7 and ship_cabin_id > 3;

-- ------------------------------------------------
-- reverse the GROUP BY
select room_type,room_style,sum(sq_ft)
from ship_cabins
WHERE ship_cabin_id < 7 and ship_cabin_id > 3
group by room_type,room_style;

-- -----------------------------------
-- rollup
SELECT room_type, room_style, SUM(sq_ft) sum_sq_ft
from ship_cabins
WHERE ship_cabin_id < 7 and ship_cabin_id > 3
GROUP BY rollup(room_type,room_style)
order by 1, 2;

-- -----------------------------------------------------------------------------
-- ROLLUP 3 C O L U M N S 
-- -----------------------------------------------------------------------------
-- find the same rows 
select window, room_type,room_style,sq_ft
from ship_cabins
where ship_cabin_id < 12 and ship_cabin_id > 6;

-- -----------------------------------
-- group by WINDOW, ROOM_STYLE, ROOM_TYPE
SELECT window,room_type,room_style,SUM(sq_ft) sum_sq_ft
FROM ship_cabins
WHERE ship_cabin_id < 12 and ship_cabin_id > 6
group by window,room_type,room_style
order by 1, 2, 3;

-- -----------------------------------
-- rollup by WINDOW, ROOM_STYLE, ROOM_TYPE
SELECT window,room_type,room_style,SUM(sq_ft) sum_sq_ft
from ship_cabins
WHERE ship_cabin_id < 12 and ship_cabin_id > 6
group by rollup (window,room_type,room_style)
order by 1, 2, 3;






select * from ship_cabins
where ship_cabin_id < 12 and ship_cabin_id > 7;


-- -----------------------------------------------------------------------------
-- CUBE 1 C O L U M N  
-- -----------------------------------------------------------------------------
-- find the same rows 
select room_style,sq_ft
from ship_cabins
where ship_cabin_id < 7 and ship_cabin_id > 3;
-- -----------------------------------
-- group by ROOM_STYLE
SELECT room_style,SUM(sq_ft) sum_sq_ft
FROM ship_cabins
WHERE ship_cabin_id < 7 and ship_cabin_id > 3
group by room_style
order by 1;

-- -----------------------------------
-- rollup by ROOM_STYLE
SELECT room_style,SUM(sq_ft) sum_sq_ft
from ship_cabins
where ship_cabin_id < 7 and ship_cabin_id > 3
group by rollup (room_style)
order by 1;

-- -----------------------------------
-- cube by ROOM_STYLE 
-- 1 column looks like rollup
SELECT room_style,SUM(sq_ft) sum_sq_ft
from ship_cabins
where ship_cabin_id < 7 and ship_cabin_id > 3
group by cube (room_style)
order by 1;

-- -----------------------------------------------------------------------------
-- CUBE 2 C O L U M N  
-- -----------------------------------------------------------------------------
-- find the same rows 
select room_type, room_style,sq_ft
from ship_cabins
where ship_cabin_id < 7 and ship_cabin_id > 3 ;
-- -----------------------------------
-- group by ROOM_TYPE, ROOM_STYLE
SELECT room_type,room_style,SUM(sq_ft) sum_sq_ft
from ship_cabins
where ship_cabin_id < 7 and ship_cabin_id > 3 
group by room_type,room_style
order by 1;

-- -----------------------------------
-- rollup by ROOM_TYPE,ROOM_STYLE
SELECT room_type,room_style,SUM(sq_ft) sum_sq_ft
from ship_cabins
where ship_cabin_id < 7 and ship_cabin_id > 3 
group by rollup (room_type,room_style)
order by 1;

-- -----------------------------------
-- cube by ROOM_TYPE,ROOM_STYLE 
-- 1 column looks like rollup
SELECT room_type,room_style,SUM(sq_ft) sum_sq_ft
from ship_cabins
where ship_cabin_id < 7 and ship_cabin_id > 3 
group by cube (room_type,room_style)
order by 1;

select window, room_type,room_style
from ship_cabins
where ship_cabin_id < 7 and ship_cabin_id > 3; 

select window, room_type,room_style,sum(sq_ft) sum_sq_ft
from ship_cabins
where ship_cabin_id < 7 and ship_cabin_id > 3 
group by cube (window,room_type,room_style)
order by 1;



-- -----------------------------------------------------------------------------
-- GROUPING ROLLUP 2 C O L U M N  page 517
-- -----------------------------------------------------------------------------
SELECT grouping(room_type), room_style, room_type, sum(sq_ft) sum_sq_ft
FROM ship_cabins
where ship_cabin_id < 7 and ship_cabin_id > 3 
GROUP BY rollup(room_style, room_type)
ORDER BY room_style, room_type;

-- -----------------------------------------------------------------------------
-- GROUPING SETS page 519
-- -----------------------------------------------------------------------------
select window, room_style, room_type, sq_ft
from ship_cabins
where ship_cabin_id < 7 and ship_cabin_id > 3; 

select window, room_style, room_type, sum(sq_ft) sum_sq_ft
from ship_cabins
where ship_cabin_id < 7 and ship_cabin_id > 3 
group by cube(window, room_style, room_type)
order by 1,2,3;

select window, room_style, room_type, sum(sq_ft) sum_sq_ft
from ship_cabins
where ship_cabin_id < 7 and ship_cabin_id > 3 
group by grouping sets ((window, room_style), room_type)
order by 1,2,3;

-- -----------------------------------
SELECT grouping(window),
grouping(room_type),
grouping(room_style),
SUM(sq_ft) sum_sq_ft
FROM ship_cabins
WHERE ship_id = 1
AND ship_cabin_id < 7
AND ship_cabin_id > 3
GROUP BY window,
rollup(room_type,room_style)
ORDER BY window,
room_style,
room_type;
-- -----------------------------------
SELECT window,
room_type,
room_style,
SUM(sq_ft) sum_sq_ft
FROM ship_cabins
WHERE ship_id = 1
AND ship_cabin_id < 6
GROUP BY window,
room_type,
room_style
ORDER BY window,
room_style,
room_type;
-- -----------------------------------------------------------------------------
-- cube compare
-- -----------------------------------
SELECT room_style,
room_type
FROM ship_cabins
WHERE ship_id = 1
AND ship_cabin_id < 6
ORDER BY room_style,
room_type;
SELECT room_style,
room_type,
SUM(sq_ft) sum_sq_ft
FROM ship_cabins
WHERE ship_id = 1
AND ship_cabin_id < 6
GROUP BY cube(room_style,room_type)
ORDER BY room_style,
room_type;
-- -----------------------------------
-- page 513 bottom 3 cols
SELECT window,
room_style,
room_type
FROM ship_cabins
WHERE ship_id = 1
AND ship_cabin_id < 6;
SELECT window,
room_style,
room_type,
SUM(sq_ft) sq_ft
FROM ship_cabins
WHERE ship_id = 1
AND ship_cabin_id < 6
GROUP BY rollup(window,room_style, room_type)
ORDER BY window,
room_style,
room_type;
-- -----------------------------------
SELECT window,
room_style,
room_type
FROM ship_cabins
WHERE ship_id = 1
AND ship_cabin_id < 6;
SELECT window,
room_style,
room_type,
SUM(sq_ft) sq_ft,
grouping(window) AS wd,
grouping(room_style) AS rs,
grouping(room_type)AS rt
FROM ship_cabins
WHERE ship_id = 1
AND ship_cabin_id < 6
GROUP BY rollup(window,room_style, room_type)
ORDER BY window,
room_style,
room_type;
-- -----------------------------------
-- page 514 multple rollups (see bullets)
SELECT room_style,
room_type,
SUM(sq_ft) sum_sq_ft
FROM ship_cabins
WHERE ship_id = 1
GROUP BY rollup(room_type),
rollup(room_style)
ORDER BY room_style,
room_type;
-- -----------------------------------
SELECT window,
room_style,
room_type,
SUM(sq_ft) sum_sq_ft
FROM ship_cabins
WHERE ship_id = 1
GROUP BY rollup(window),
rollup(room_type),
rollup(room_style);
order by room_style,
room_type;
-- -----------------------------------
-- page 514 group by and rollup
SELECT window,
room_style,
room_type,
SUM(sq_ft) sum_sq_ft
FROM ship_cabins
WHERE ship_id = 1
GROUP BY window,
rollup (room_style, room_type)
ORDER BY window,
room_style,
room_type;
-- -----------------------------------------------------------------------------
--CUBE
-- -----------------------------------------------------------------------------
SELECT *
FROM ship_cabins
WHERE ship_id = 1
AND ship_cabin_id < 10;
-- page 516 cube 1 col
SELECT room_type,
SUM(sq_ft) sq_ft
FROM ship_cabins
WHERE ship_id = 1
AND ship_cabin_id < 10
GROUP BY cube (room_type)
ORDER BY room_type;
-- -----------------------------------
SELECT room_style,
SUM(sq_ft) sq_ft
FROM ship_cabins
WHERE ship_id = 1
GROUP BY cube (room_style)
ORDER BY room_style;
-- -----------------------------------
-- group by cube
-- -----------------------------------
SELECT room_style,
room_type
FROM ship_cabins
WHERE ship_id = 1
AND ship_cabin_id < 9
AND ship_cabin_id > 5
ORDER BY room_style,
room_type;
-- page 516 cube 2 col
SELECT room_style,
room_type,
SUM(sq_ft) sq_ft
FROM ship_cabins
WHERE ship_id = 1
AND ship_cabin_id < 9
AND ship_cabin_id > 5
GROUP BY cube(room_style, room_type)
ORDER BY room_style,
room_type;
-- ------------------------------------------------
SELECT window,
room_style,
room_type
FROM ship_cabins
WHERE ship_id = 1
AND ship_cabin_id < 9
AND ship_cabin_id > 5
ORDER BY room_style,
room_type;
SELECT window,
room_style,
room_type,
SUM(sq_ft) sq_ft
FROM ship_cabins
WHERE ship_id = 1
AND ship_cabin_id < 9
AND ship_cabin_id > 5
GROUP BY window,
cube(room_style, room_type)
ORDER BY room_style,
room_type;
-- ------------------------------------------------
-- double cube
-- page 516 cube 2 col multiple cubes
SELECT room_style,
room_type,
SUM(sq_ft) sq_ft
FROM ship_cabins
WHERE ship_id = 1
GROUP BY cube(room_style),
cube(room_type)
ORDER BY room_style,
room_type;

-- page 516 cube 3 col
SELECT window,
room_style,
room_type,
SUM(sq_ft) sq_ft
FROM ship_cabins
WHERE ship_id = 1
GROUP BY cube(window,room_style,room_type)
ORDER BY window,
room_style,
room_type;
SELECT window,
room_style,
room_type,
SUM(sq_ft) sq_ft
FROM ship_cabins
WHERE ship_id = 1
GROUP BY window,
cube (room_style,room_type)
ORDER BY window,
room_style,
room_type;
-- -----------------------------------------------------------------------------
--GROUPING FUNCTION
-- -----------------------------------------------------------------------------
-- page 517 grouping function 1 cols
SELECT grouping(room_type),
room_type ,
SUM(sq_ft) sq_ft
FROM ship_cabins
WHERE ship_id = 1
GROUP BY rollup (room_type)
ORDER BY room_type;
-- page 517 grouping function 2 cols
SELECT grouping(room_style) ,
grouping(room_type) ,
room_style ,
room_type ,
SUM(sq_ft) sq_ft
FROM ship_cabins
WHERE ship_id = 1
GROUP BY rollup (room_style, room_type)
ORDER BY room_style,
room_type;
-- page 517 grouping function 3 cols
SELECT grouping(window) ,
grouping(room_style) ,
grouping(room_type) ,
window ,
room_style ,
room_type ,
SUM(sq_ft) sq_ft
FROM ship_cabins
WHERE ship_id = 1
GROUP BY rollup (window,room_style, room_type)
ORDER BY window,
room_style,
room_type;
-- page 518 rollup
select -- grouping(room_style),
       -- grouping(room_type),
       decode(grouping(room_style), 1,'ALL STYLES', room_style) style,
       decode(grouping(room_type), 1,'ALL TYPES', room_type) type,
       SUM(sq_ft) sq_ft
from ship_cabins
where ship_cabin_id < 7 and ship_cabin_id > 3
GROUP BY rollup (room_style, room_type)
ORDER BY room_style;

-- page 518 cube
SELECT DECODE(grouping(room_style), 1,'ALL STYLES', room_style) style,
DECODE(grouping(room_type), 1,'ALL TYPES', room_type) type,
SUM(sq_ft) sq_ft
FROM ship_cabins
WHERE ship_id = 1
GROUP BY cube (room_style, room_type)
ORDER BY room_style;
-- -----------------------------------------------------------------------------
--GROUPING SETS
-- -----------------------------------------------------------------------------
-- page 520
SELECT NVL(window,' ') ,
NVL(room_style,' ') ,
NVL(room_type,' ') ,
SUM(sq_ft) sq_ft
FROM ship_cabins
WHERE ship_id = 1
GROUP BY grouping sets ((window,room_style), (room_type), NULL)
ORDER BY window,
room_style,
room_type;
-- -----------------------------------------------------------------------------
-- HANDS ON EXERCISES
-- -----------------------------------------------------------------------------
CREATE TABLE divisions
(
division_id CHAR(3) CONSTRAINT divisions_pk PRIMARY KEY,
nameVARCHAR2(15) NOT NULL
);
DROP TABLE divisions;
DROP TABLE jobs;
DROP TABLE employees2;
CREATE TABLE jobs
(
job_id CHAR(3) CONSTRAINT jobs_pk PRIMARY KEY,
name VARCHAR2(20) NOT NULL
);
CREATE TABLE employees2
(
employee_id INTEGER CONSTRAINT employees2_pk PRIMARY KEY ,
division_id CHAR(3)CONSTRAINT employees2_fk_divisions REFERENCES divisions(division_id) ,
job_idCHAR(3) REFERENCES jobs(job_id) ,
first_nameVARCHAR2(10) NOT NULL ,
last_name VARCHAR2(10) NOT NULL,
salaryNUMBER(6, 0)
);
SELECT * FROM employees2;
SELECT * FROM jobs;
SELECT * FROM divisions;
-- 1
-- Group the salary (employees2) by job name (jobs)
SELECT name,
SUM(salary)
FROM employees2
JOIN jobs USING (job_id)
GROUP BY name;
SELECT name,
SUM(salary)
FROM employees2
JOIN jobs USING (job_id)
GROUP BY rollup(name);
-- with a grand total
SELECT name,
SUM(salary)
FROM employees2
JOIN jobs USING (job_id)
GROUP BY rollup (name);
-- 2
-- calculate total number of days and cost by purpose with grand totals
SELECT *
FROM projects;
SELECT NVL(purpose,'----TOTAL----') ,
SUM(project_cost),
SUM(days)
FROM projects
GROUP BY rollup (purpose);
SELECT purpose,
SUM(project_cost),
SUM(days)
FROM projects
GROUP BY rollup (purpose);
-- 3
-- calculate total number of days and total cost by ship_name with grand totals
SELECT NVL(ship_name,'--TOTALS---'),
SUM(project_cost),
SUM(days)
FROM projects
JOIN ships USING(ship_id)
GROUP BY rollup (ship_name);
SELECT ship_name,
SUM(project_cost),
SUM(days)
FROM projects
JOIN ships USING (ship_id)
GROUP BY rollup (ship_name);
-- 4
-- Get the total salary by division (employees2)
-- how many rows does your SQL return?
SELECT name,
SUM(salary)
FROM employees2
JOIN divisions USING (division_id)
GROUP BY rollup (name)
ORDER BY 1;
-- 5
-- Get the total salary by job_id (employees2) no grand total
-- how many rows does your SQL return?
SELECT job_id,
SUM(salary)
FROM employees2
GROUP BY job_id;
-- 6
-- Get the total salary by division (employees2) with grand total
-- how many rows does your SQL return?
SELECT division_id,
SUM(salary)
FROM employees2
GROUP BY rollup(division_id);
-- 7
-- Sum salary by division name and job name with no grand total
SELECT j.name,
d.name,
SUM(salary)
FROM employees2 e
JOIN jobs j
ON e.job_id=j.job_id
JOIN divisions d
ON e.division_id = d.division_id
GROUP BY rollup (j.name, d.name);
SELECT NVL(d.name,' TOTALS ') ,
NVL(j.name,'SUB TOTALS') ,
SUM(salary)
FROM employees2 e
JOIN jobs j
ON e.job_id=j.job_id
JOIN divisions d
ON e.division_id = d.division_id
GROUP BY rollup (d.name, j.name);
SELECT divisions.name div,
jobs.name job,
SUM(salary)
FROM employees2
JOIN jobs USING(job_id)
JOIN divisions USING (division_id)
GROUP BY (divisions.name, jobs.name)
ORDER BY 1;
-- 8
-- Sum salary by division name and job name with grand total
-- and superaggregate rows for just divisions
SELECT NVL(d.name,'GRAND TOTALS') div ,
j.name job,
SUM(salary)
FROM employees2
JOIN jobs j USING(job_id)
JOIN divisions d USING (division_id)
GROUP BY rollup (d.name, j.name)
ORDER BY d.name;
SELECT divisions.name div,
jobs.name job,
SUM(salary)
FROM employees2
JOIN jobs USING(job_id)
JOIN divisions USING (division_id)
GROUP BY rollup (divisions.name, jobs.name)
ORDER BY 1;
-- 9 Sum salary by division name and job name with grand total
-- and superaggregate rows for both division and job names.
-- How many rows total does your SQL return
-- What is the value for all operations
-- what is the value for all technologists
SELECT NVL(divisions.name,'GRAND TOTALS') div,
jobs.name job,
SUM(salary)
FROM employees2
JOIN jobs USING(job_id)
JOIN divisions USING (division_id)
GROUP BY cube (divisions.name, jobs.name)
ORDER BY divisions.name;
-- 10.
-- Show the total salary for all combinations of division and job names
-- and show the values --ALL DIVISIONS--, --ALL JOBS-- in the appropriate
-- places.
-- How many rows show --ALL DIVISIONS--.
-- How many rows show --ALL JOBS--.
SELECT DECODE(grouping(divisions.name), 1, 'ALL DIVISIONS',divisions.name) div ,
DECODE(grouping(jobs.name), 1, 'ALL JOBS', jobs.name) job ,
SUM(salary)
FROM employees2
JOIN jobs USING(job_id)
JOIN divisions USING (division_id)
GROUP BY cube (divisions.name, jobs.name)
ORDER BY divisions.name ;











-- =============================================================================
-- Chapter 14
-- =============================================================================
select * from v$session;
select * from v$reserved_words;
-- ------------------------------------------------------
-- page 536
SELECT *
FROM user_tables;
SELECT * FROM all_tables;
SELECT * FROM dba_tables;
SELECT column_name FROM all_tab_columns WHERE table_name = 'CRUISES';
-- ------------------------------------------------------
SELECT column_name,data_type,data_length
from all_tab_columns
where table_name = 'CRUISES';
-- ------------------------------------------------------
SELECT * FROM all_tab_columns WHERE owner = 'CRUISES';
-- ------------------------------------------------------
SELECT *
from all_tab_columns
WHERE owner= 'CRUISES'
AND table_name = 'ADDRESSES';
-- ------------------------------------------------------
SELECT column_name
FROM all_tab_columns
where owner= 'CRUISES'
AND table_name = 'ADDRESSES';
-- ------------------------------------------------------
-- address_id,employee_id,street_address,street_address2,city,state,zip,zip_plus,country,contact_email,
SELECT *
FROM all_cons_columns
WHERE owner = 'CRUISES';
-- ------------------------------------------------------
select * from all_synonyms;
-- ------------------------------------------------------
-- page 537
select * from user_constraints;
select * from all_constraints;
-- ------------------------------------------------------
-- page 537
SELECT * FROM user_synonyms;
SELECT * FROM all_synonyms;
-- ------------------------------------------------------
-- page 538 Overlap of views
SELECT * FROM user_catalog;
select * from user_tables;
SELECT * FROM user_tab_columns;
-- ------------------------------------------------------
-- page 538 Dynamic Performance Views
SELECT *
FROM all_catalog
WHERE table_type = 'VIEW';
SELECT * FROM v$version;
SELECT * FROM product_component_version;
-- ------------------------------------------------------
-- page 539
-- Version
SELECT * FROM v$version;
SELECT * FROM product_component_version;
-- ------------------------------------------------------
-- page 539
-- as system
SELECT * FROM v$database;
SELECT * FROM v$instance;
SELECT * FROM v$timezone_names;
-- ------------------------------------------------------
-- page 540
SELECT * FROM all_tab_comments WHERE table_name = 'PORTS';
select * from all_col_comments;
-- ------------------------------------------------------
-- page 541
COMMENT ON TABLE ports IS 'Listing of all ports';
SELECT * FROM user_tab_comments;
-- ------------------------------------------------------
-- page 541
comment on column ports.capacity IS 'Max num of passengers';
SELECT * FROM user_col_comments;
-- page 542
DESC dictionary;
SELECT * FROM dictionary;
-- page 543
SELECT * FROM dictionary WHERE table_name LIKE '%RESTORE%';
select * from dictionary where upper(comments) like '%INDEX%';
select * from dictionary where upper(comments) like '%RESTORE%';
-- ------------------------------------------------------
-- page 543
SELECT *
FROM all_col_comments
WHERE owner= 'CRUISES'
AND table_name = 'PORTS';
-- ------------------------------------------------------
-- page 544
SELECT * FROM user_catalog;
SELECT table_type, COUNT(*) FROM user_catalog GROUP BY table_type;
-- ------------------------------------------------------
-- page 545
SELECT * FROM user_tab_columns;
-- ------------------------------------------------------
-- page 546 middle
SELECT * FROM USER_OBJECTS WHERE STATUS = 'INVALID';
-- ------------------------------------------------------
-- page 546 bottom
select text from user_views;
-- ------------------------------------------------------
-- page 547
SELECT * FROM user_constraints WHERE table_name = 'CRUISES';
-- as system
SELECT * FROM V$SYSTEM_PARAMETER WHERE upper(name) = 'UNDO$';
SELECT * FROM PORTS versions BETWEEN TIMESTAMP minvalue AND maxvalue;
SELECT * FROM PORTS AS OF TIMESTAMP systimestamp - interval '0 0:01:30' DAY TO SECOND;
























































































-- =============================================================================
-- Chapter 15
-- =============================================================================
-- Go back to chapter 11 approximately line 4296
-- install EXTERNAL TABLE table from c:\tempinvoices.txt
-- convert into invoices_revised with correct data types
desc invoices_external;
-- page 561
SELECT count(*)
 FROM invoices_revised
 WHERE invoice_date < (add_months(sysdate,-12));
-- ----------------------------------------------------------------
SELECT *
 from invoices_revised
WHERE invoice_date > to_date('05/31/10','mm/dd/yy')
AND invoice_date < to_date('08/01/10','mm/dd/yy') ;
-- ----------------------------------------------------------------
-- page 561
create table invoices_archivecal2010q2 as
SELECT *
FROM invoices_revised
WHERE invoice_date > to_date('05/31/10','mm/dd/yy')
AND invoice_date < to_date('08/01/10','mm/dd/yy') ;
DROP TABLE invoices_archiveCAL2010Q2;
-- ----------------------------------------------------------------
-- page 562
CREATE TABLE room_summary AS
SELECT a.ship_id ,
       a.ship_name ,
       b.room_number ,
       b.sq_ft + nvl(b.balcony_sq_ft,0) sq_ft
FROM ships a
JOIN ship_cabins b
on a.ship_id = b.ship_id;
-- ----------------------------------------------------------------
create table room_summary2(s_id,s_name,r_num,sq_ft) as
SELECT a.ship_id, a.ship_name, b.room_number, b.sq_ft + NVL(b.balcony_sq_ft,0)
FROM ships a
JOIN ship_cabins b
ON a.ship_id = b.ship_id;
-- ----------------------------------------------------------------
-- page 563
SELECT * FROM cruise_customers;
select * from employees;
-- ----------------------------------------------------------------
-- page 564 top
SELECT seq_cruise_customer_id.nextval FROM dual;
DROP sequence seq_cruise_customer_id;
SELECT MAX(cruise_customer_id) FROM cruise_customers;
CREATE sequence seq_cruise_customer_id start with 4;
insert into cruise_customers (cruise_customer_id, first_name, last_name)
  select  seq_cruise_customer_id.nextval ,
          emp.first_name ,
          emp.last_name
  from employees emp;
-- ----------------------------------------------------------------  
select * from cruise_customers;
-- ---------------------------------------------------------------- 
-- page 565
SELECT home_port_id, COUNT(ship_id) total, SUM(capacity) capacity
FROM ships
group by home_port_id
order by 1;
-- ---------------------------------------------------------------- 
-- page 566
select * from ports;

update ports p
set ( tot_ships_assigned,             tot_ships_asgn_cap) =
    (select count(s.ship_id) total,   sum(s.capacity) capacity
     from ships s
     where s.home_port_id = p.port_id
     group by home_port_id
    );
-- ---------------------------------------------------------------- 
-- page 572
SELECT * FROM invoices_revised;
DESC invoices_revised;
CREATE TABLE invoices_revised_archive
  (
    invoice_id NUMBER,
    invoice_date date,
    invoice_amt NUMBER,
    account_number varchar2(13)
  );
CREATE TABLE invoices_revised_archive2
  (
    invoice_id NUMBER,
    invoice_date date,
    invoice_amt NUMBER,
    account_number VARCHAR2(13)
  );
-- ---------------------------------------------------------------- 
-- page 572
insert all
into invoices_revised_archive (invoice_id,invoice_date,invoice_amt,account_number)
      values (invoice_id,invoice_date,invoice_amt,account_number)
into invoices_revised_archive2 (invoice_id,invoice_date,invoice_amt,account_number)
      values (invoice_id,invoice_date,invoice_amt,account_number)
select invoice_id,invoice_date,invoice_amt,account_number
from invoices_revised;

-- ---------------------------------------------------------------- 
-- Unconditional multitable insert
-- page 573
insert all
into invoices_revised_archive(invoice_id, invoice_date,invoice_amt,account_number)
    values (invoice_id,invoice_date,invoice_amt,account_number)
into invoices_revised_archive2(invoice_id,invoice_date,invoice_amt,account_number)
    values (invoice_id,invoice_date + 365,invoice_amt,account_number)
select invoice_id,invoice_date,invoice_amt,account_number
from invoices_revised;
-- ---------------------------------------------------------------- 
truncate table invoices_revised_archive2;
-- Page 575
create table invoices_archived2 (invoice_id number, invoice_date date, invoice_amt number, account_number varchar2(13) );
create table invoices_new2 (invoice_id number, invoice_date date, invoice_amt number, account_number varchar2(13) );
truncate table invoices_revised_archive;
truncate table invoices_revised_archive2;
-- ---------------------------------------------------------------- 
-- Page 575
select invoice_id,invoice_date,invoice_amt,account_number from invoices_revised where invoice_date < (add_months(sysdate,-24));
-- ---------------------------------------------------------------- 
-- Conditional multitable insert
insert
  when (invoice_date < (add_months(sysdate,-12))) then
      into invoices_revised_archive(invoice_id,invoice_date,invoice_amt,account_number)
      values (invoice_id,invoice_date,invoice_amt,account_number)
  else
      into invoices_revised_archive2(invoice_id,invoice_date,invoice_amt,account_number)
      values (invoice_id,invoice_date,invoice_amt,account_number)
select invoice_id,invoice_date,invoice_amt,account_number
from invoices_revised;

SELECT COUNT(*) FROM invoices_revised_archive;
SELECT COUNT(*) FROM invoices_revised_archive2;
SELECT
(SELECT COUNT(*) FROM invoices_archived2
) +
(SELECT COUNT(*) FROM invoices_new2
)
FROM dual;
-- page 576 & 577
-- create table invoices_2009
create table invoices_2009
    (
      invoice_id number primary key,
      invoice_date date,
      invoice_amt number,
      account_number varchar2(13 byte)
    );
create table invoices_2010
    (
      invoice_id number primary key,
      invoice_date date,
      invoice_amt number,
      account_number varchar2(13 byte)
    );
create table invoices_2011
    (
      invoice_id number primary key,
      invoice_date date,
      invoice_amt number,
      account_number varchar2(13 byte)
    );
create table invoices_all
    (
      invoice_id number primary key,
      invoice_date date,
      invoice_amt number,
      account_number varchar2(13 byte)
    );
truncate table invoices_2009;
truncate table invoices_2010;
truncate table invoices_2011;
truncate table invoices_all;

insert first
when (to_char(invoice_date,'RRRR') <= '2009') then
 into invoices_2009 (invoice_id,invoice_date,invoice_amt,account_number)
    values(invoice_id,invoice_date,invoice_amt,account_number)
 into invoices_all(invoice_id,invoice_date,invoice_amt,account_number)
    values(invoice_id,invoice_date,invoice_amt,account_number)
when (to_char(invoice_date,'RRRR') <= '2010') then
 into invoices_2010 (invoice_id,invoice_date,invoice_amt,account_number)
    values(invoice_id,invoice_date,invoice_amt,account_number)
 into invoices_all(invoice_id,invoice_date,invoice_amt,account_number)
    values(invoice_id,invoice_date,invoice_amt,account_number)
when (to_char(invoice_date,'RRRR') <= '2011') then
 into invoices_2011 (invoice_id,invoice_date,invoice_amt,account_number)
    values(invoice_id,invoice_date,invoice_amt,account_number)
 into invoices_all(invoice_id,invoice_date,invoice_amt,account_number)
    values(invoice_id,invoice_date,invoice_amt,account_number)
select invoice_id,invoice_date,invoice_amt,account_number
from invoices_revised;

--when (to_char(date_shipped,'RRRR') <= '2008') then
--into invoices_thru_2008 (invoice_id, invoice_date,
--shipping_date, account_number)
--values (inv_no, date_entered, date_shipped, cust_acct)
--into invoices_closed (invoice_id, invoice_date,
--shipping_date, account_number)
--values (inv_no, date_entered, date_shipped, cust_acct)
--when (to_char(date_shipped,'RRRR') <= '2007') then
--into invoices_thru_2007 (invoice_id, invoice_date,
--shipping_date, account_number)
--values (inv_no, date_entered, date_shipped, cust_acct)
--select inv_no, date_entered, date_shipped, cust_acct
--from wo_inv;
-- -----------------------------------------------------------------------------
-- page 579
insert when (boss_salary-employee_salary < 79000) then
into salary_chart(emp_title,superior,emp_income,sup_income)
values(employee,boss,employee_salary,boss_salary)
-- -----------------------------------------------------------------------------
select  a.position employee,
        b.position boss,
        a.max_salary employee_salary,
        b.max_salary boss_salary
from positions a
join positions b
on a.reports_to= b.position_id
where a.max_salary > 79000;
-- page 580
-- Send this to students
CREATE TABLE ship_cabin_grid
(
    room_type VARCHAR2(20) ,
    ocean NUMBER ,
    balcony NUMBER ,
    no_window NUMBER
);
BEGIN
    insert into ship_cabin_grid values ('ROYAL', 1745,1635, null);
    insert into ship_cabin_grid values('SKYLOFT', 722,72235, null);
    insert into ship_cabin_grid values('PRESIDENTIAL', 1142,1142, 1142);
    insert into ship_cabin_grid values('LARGE', 225,null, 211);
    insert into ship_cabin_grid values('STANDARD', 217,554, 586);
END;
/
TRUNCATE TABLE ship_cabin_grid;

insert all
 when ocean is not null then
    into ship_cabin_statistics(room_type,window_type,sq_ft)
    values(room_type,'OCEAN',ocean)
 when balcony is not null then
  into ship_cabin_statistics (room_type,window_type,sq_ft)
  values (room_type,'BALCONY',balcony)
 when no_window is not null then
  into ship_cabin_statistics(room_type,window_type,sq_ft)
  values(room_type,'NO WINDOW',no_window)
select rownum rn, room_type, ocean, balcony, no_window from ship_cabin_grid;
-- ----------------------------------------------------------------------------
insert all
  when ocean is not null then
    into ship_cabin_statistics(room_type,window_type,sq_ft)
    values(room_type,'OCEAN',ocean)
  when balcony is not null then
    into ship_cabin_statistics(room_type,window_type,sq_ft)
    values(room_type,'BALCONY',balcony)
  when no_window is not null then
    into ship_cabin_statistics(room_type,window_type,sq_ft)
    values(room_type,'NO WINDOW',no_window)
select rownum rn, room_type, ocean, balcony, no_window from ship_cabin_grid;
-- ----------------------------------------------------------------------------
-- page 586
merge 
into wwa_invoices wwa using ontario_orders ont on (wwa.cust_po = ont.po_num)
  when matched then
    update set wwa.notes = ont.sales_rep
    delete where wwa.inv_date < to_date('01-SEP-09') 
  when not matched then
    insert(wwa.inv_id,wwa.cust_po,wwa.inv_date,wwa.notes)
    values(seq_inv_id.nextval,ont.po_num,sysdate,ont.sales_rep)
    where substr(ont.po_num,1,3)<> 'NBC';

-- ----------------------------------------------------------------------------
-- FLASHBACK QUERIES
-- ----------------------------------------------------------------------------
-- setup the table for testing 
-- page 589
commit;
DROP TABLE chat;
create table chat(chat_id number(11) primary key,chat_user varchar2(9),yacking varchar2(40));
DROP sequence seq_chat_id;
create sequence seq_chat_id;
begin
    insert into chat values(seq_chat_id.nextval, user, 'Hi there.');
    insert into chat values(seq_chat_id.nextval,user,'Welcome to our chat room.');
    insert into chat values(seq_chat_id.nextval,user,'Online order form is up.');
    INSERT INTO chat VALUES(seq_chat_id.nextval, USER, 'Over and out.');
    commit;
end;
/
-- ----------------------------------------------------------------------------
-- page 589
SELECT chat_id,ora_rowscn,scn_to_timestamp(ora_rowscn)
FROM chat;
-- ----------------------------------------------------------------------------
-- page 590
-- wait for 2 minutes;
select * from chat;
DELETE FROM chat;
COMMIT;
SELECT * FROM chat;
-- ----------------------------------------------------------------------------
-- page 593
select chat_id,chat_user,yacking
from chat as of timestamp systimestamp - interval '0 0:01:30' day to second;

minus
select chat_id, chat_user, yacking
from chat;
--as system
select name,value 
FROM v$system_parameter
WHERE name LIKE ('undo%');
--undo_management AUTO
--undo_tablespace undo
--undo_retention 900
-- page 595
select  chat_id, versions_startscn, versions_endscn, versions_operation  
from chat versions between timestamp minvalue and maxvalue
order by chat_id,
versions_operation desc;
-- ----------------------------------------------------------------------------
--page 596
SELECT chat_id, versions_startscn, versions_endscn, versions_operation
FROM chat versions BETWEEN TIMESTAMP minvalue AND maxvalue AS OF TIMESTAMP systimestamp - interval '0 00:1:30' DAY TO second
ORDER BY chat_id, versions_operation DESC;
-- ----------------------------------------------------------------------------
-- page 598 middle
select chat_id,versions_operation,rawtohex(versions_xid)
from chat versions between timestamp minvalue and maxvalue
WHERE chat_id = 1
ORDER BY versions_operation DESC;
-- ----------------------------------------------------------------------------
SELECT * FROM chat;
DELETE chat;
-- page 598 bottom
select undo_sql from flashback_transaction_query
WHERE xid = ( SELECT versions_xid
              from chat versions between timestamp minvalue and maxvalue
              where chat_id = 1
              AND versions_operation = 'D'
            );
































































































-- =============================================================================
-- Chapter 16
-- =============================================================================
SELECT *
FROM employee_chart;
-- page 622
-- -----------------------------------------------------------------------------
-- top down
-- ------------------------------------
SELECT level,
       employee_id,
       title
FROM employee_chart
START WITH employee_id = 1
connect by  prior employee_id = reports_to;
-- ------------------------------------
-- bottom up
-- ------------------------------------
SELECT level,
employee_id,
title
FROM employee_chart
START WITH employee_id= 5
CONNECT BY prior reports_to = employee_id;
SELECT level,
reports_to,
employee_id,
title
FROM employee_chart
START WITH employee_id = 1
CONNECT BY reports_to= prior employee_id;
SELECT level,
reports_to,
employee_id,
title
FROM employee_chart
START WITH employee_id= 9
CONNECT BY prior reports_to = employee_id;


SELECT level,
       reports_to,
       employee_id,
       LPAD(' ', Level*2) || title title_up
FROM employee_chart
start with employee_id = 1
CONNECT BY reports_to = prior employee_id
ORDER BY title;


-- page 624
SELECT level,
reports_to,
employee_id,
LPAD(' ', Level*2)
|| title title_up
FROM employee_chart
START WITH employee_id = 1
CONNECT BY reports_to= prior employee_id
ORDER SIBLINGS BY title;
-- --------------------------------------------------
-- page 625 top
SELECT level,
employee_id,
sys_connect_by_path(title,'/') title
FROM employee_chart
START WITH employee_id = 1
CONNECT BY reports_to= prior employee_id;
order siblings by title;
-- --------------------------------------------------
-- page 625 bottom
SELECT    level
        , employee_id
        , title
        , connect_by_root title AS ancestor
FROM employee_chart
start with employee_id = 2
CONNECT BY reports_to= prior employee_id;
-- --------------------------------------------------
-- page 626 bottom
SELECT level,
employee_id,
LPAD(' ', Level*2)
|| title title
FROM employee_chart
START WITH employee_id = 1
CONNECT BY reports_to= prior employee_id
and employee_id <> 3;
-- --------------------------------------------------
SELECT level,
employee_id,
lpad(' ', level*2)
|| title title
FROM employee_chart
WHERE employee_id NOT IN (6)
START WITH employee_id = 1
CONNECT BY reports_to= prior employee_id
AND employee_id <> 3;
-- page 627 top
SELECT level,
employee_id,
LPAD(' ', Level*2)
|| title title
FROM employee_chart
START WITH employee_id = 1
CONNECT BY reports_to= prior employee_id
AND title <> 'SVP';
-- page 627 bottom
SELECT level,
employee_id,
LPAD(' ', Level*2)
|| title title
FROM employee_chart
WHERE employee_id IN
(SELECT employee_id FROM employees2
)
START WITH employee_id = 1
CONNECT BY reports_to= prior employee_id
AND title <> 'SVP';
-- -----------------------------------------------------------------------------
-- HANDS ON EXERCISES 16
-- -----------------------------------------------------------------------------
SELECT *
FROM jobs2;
SELECT * FROM directories;
SELECT * FROM files;
-- 1.
-- What is the root directory for job_id = 104;
SELECT *
FROM jobs2
WHERE job_id = 104;
SELECT * FROM directories WHERE job_id = 104;
SELECT MIN(directory_id) FROM directories WHERE job_id = 104;
-- 2.
-- Using a subquery to determine root of job 104
-- create a simple hierarchical listing of directories without padding
-- or formatting
SELECT level,
directory_id,
directory_name
FROM directories
START WITH directory_id = 11631
CONNECT BY parent_id= prior directory_id ;
SELECT level,
directory_id,
lpad(' ', Level*2)
|| directory_name
FROM directories
START WITH directory_id =
(SELECT MIN(directory_id) FROM directories WHERE job_id = 104
)
CONNECT BY parent_id = prior directory_id;
SELECT level,
directory_id,
parent_id,
lpad(' ', Level*2)
|| directory_name
FROM directories
START WITH directory_id =
(SELECT MIN(directory_id) FROM directories WHERE job_id = 104
)
CONNECT BY parent_id = prior directory_id;
-- 3.
-- Add LPAD formatting to show the levels
SELECT level,
directory_id,
LPAD(' ', Level*2)
|| directory_name directory
FROM directories
START WITH directory_id =
(SELECT MIN(directory_id) FROM directories WHERE job_id = 104
)
CONNECT BY parent_id = prior directory_id
ORDER SIBLINGS BY directory_name;
-- 4.
-- Show the path for each directory using the "/"
-- Add LPAD formatting to show the levels
SELECT level,
directory_id,
parent_id,
lpad(' ', level*2)
|| sys_connect_by_path(directory_name,'/') directory
FROM directories
START WITH directory_id =
(SELECT MIN(directory_id) FROM directories WHERE job_id = 104
)
CONNECT BY parent_id = prior directory_id;
-- 5.
-- List all files under directory /GPS/PDMT_Configs/Configuration in job 104
SELECT level,
job_id,
directory_id,
sys_connect_by_path(directory_name,'/') directory
FROM directories
START WITH directory_id =
(SELECT MIN(directory_id) FROM directories WHERE job_id = 104
)
CONNECT BY parent_id = prior directory_id;
SELECT *
FROM files f ,
(SELECT level,
job_id,
directory_id,
sys_connect_by_path(directory_name,'/') directory
FROM directories
START WITH directory_id =
(SELECT MIN(directory_id) FROM directories WHERE job_id = 104
)
CONNECT BY parent_id = prior directory_id
) d
WHERE d.directory= '/GPS/PDMT_Configs/Configuration'
AND d.job_id = f.job_id
AND d.directory_id = f.directory_id;
-- 6.
-- Which directory id has the most files in it
SELECT d.directory_id,
d.directory_name,
COUNT(f.f1)
FROM files f,
directories d
WHERE f.job_id = d.job_id
AND f.directory_id = d.directory_id
GROUP BY d.directory_id,
d.directory_name
ORDER BY 3 DESC;
-- directories under this one
SELECT level,
directory_id,
LPAD(' ', Level*2)
|| sys_connect_by_path(directory_name,'/') directory
FROM directories
START WITH directory_id = 11719
CONNECT BY parent_id= prior directory_id;
-- just directories over this one
-- Backwards
SELECT directory_id
FROM
(SELECT level lvl,
directory_id,
LPAD(' ', Level*2)
|| sys_connect_by_path(directory_name,'<') directory
FROM directories
START WITH directory_id= 11719
CONNECT BY prior parent_id = directory_id
);
-- Forwards with set placed manually
SELECT level,
directory_id,
LPAD(' ', Level*2)
|| sys_connect_by_path(directory_name,'/') directory
FROM directories
START WITH directory_id = 11631
CONNECT BY parent_id= prior directory_id
AND directory_id IN (11631, 11712, 11719);
-- Forwards with set placed manually where clause level 3
SELECT level,
directory_id,
LPAD(' ', Level*2)
|| sys_connect_by_path(directory_name,'/') directory
FROM directories
WHERE directory_id IN (11631, 11712, 11719)
AND level = 3
START WITH directory_id = 11631
CONNECT BY parent_id= prior directory_id;
-- solution
SELECT level,
directory_id,
lpad(' ', level*2)
|| sys_connect_by_path(directory_name,'/') directory
FROM directories
WHERE directory_id IN (11631, 11712, 11719)
AND level =
(SELECT MAX(lvlv)
FROM
(SELECT level lvlv,
sys_connect_by_path(directory_name,'/') directory
FROM directories
WHERE directory_id IN (11631, 11712, 11719)
START WITH directory_id = 11631
CONNECT BY parent_id= prior directory_id
)
)
START WITH directory_id = 11631
CONNECT BY parent_id= prior directory_id;
SELECT lvl1,
directory
FROM
(SELECT level lvl1,
directory_id,
LPAD(' ', Level*2)
|| sys_connect_by_path(directory_name,'/') directory
FROM directories
START WITH directory_id = 11631
CONNECT BY parent_id= prior directory_id
AND directory_id IN (11631, 11712, 11719)
) a,
(SELECT MAX(lvl2) maxlvl2
FROM
(SELECT level lvl2,
directory_id,
LPAD(' ', Level*2)
|| sys_connect_by_path(directory_name,'/') directory
FROM directories
START WITH directory_id = 11631
CONNECT BY parent_id= prior directory_id
AND directory_id IN (11631, 11712, 11719)
)
) b
WHERE a.lvl1 = b.maxlvl2;
-- Forwards with subquery
SELECT level,
directory_id,
LPAD(' ', Level*2)
|| sys_connect_by_path(directory_name,'/') directory
FROM directories
START WITH directory_id = 11631
CONNECT BY parent_id= prior directory_id
AND directory_id IN
(SELECT directory_id
FROM
(SELECT directory_id
FROM directories
START WITH directory_id= 11719
CONNECT BY prior parent_id = directory_id
)
) ;
SELECT lvl,
directory_id,
directory
FROM
(SELECT level lvl,
directory_id,
LPAD(' ', Level*2)
|| sys_connect_by_path(directory_name,'/') directory
FROM directories
START WITH directory_id = 11631
CONNECT BY parent_id= prior directory_id
AND directory_id IN
(SELECT directory_id
FROM
(SELECT directory_id
FROM directories
START WITH directory_id= 11719
CONNECT BY prior parent_id = directory_id
)
)
) a,
(SELECT MAX(level_1) max_lvl
FROM
(SELECT level level_1,
directory_id,
LPAD(' ', Level*2)
|| sys_connect_by_path(directory_name,'/') directory
FROM directories
START WITH directory_id = 11631
CONNECT BY parent_id= prior directory_id
AND directory_id IN
(SELECT directory_id
FROM
(SELECT directory_id
FROM directories
START WITH directory_id= 11719
CONNECT BY prior parent_id = directory_id
)
)
)
) b
WHERE a.lvl = b.max_lvl;
;






































-- =============================================================================
-- Chapter 17
-- =============================================================================
-- run parksRegex tutorial
-- simpliest pattern is exact duplicate
-- ------------------------------------------------
SELECT *
FROM park
WHERE park_name='Mackinac Island State Park';

-- ------------------------------------------------
-- next level of complexity is like (entire column)
select park_name
FROM park
WHERE park_name LIKE '%State Park%';

-- ------------------------------------------------
-- regexp_like more powerful (anyplace in column)
SELECT park_name, regexp_substr(park_name, 'State Park')
FROM park
WHERE regexp_like(park_name, 'State Park');





-- ------------------------------------------------
-- lets see if we can find phone numbers
SELECT park_name, description,regexp_substr(DESCRIPTION, '...-....')
FROM PARK
where regexp_like(description, '...-....');

-- ------------------------------------------------
SELECT park_name,
regexp_substr(description, '...-....')
from park
WHERE regexp_like(description, '...-....');
-- ------------------------------------------------

SELECT park_name, regexp_substr(description, '.{3}-.{4}')
from park
WHERE regexp_like(description, '.{3}-.{4}');

-- ------------------------------------------------
-- See false positives
SELECT description,
       park_name
from park
WHERE regexp_like(description, '...-....')
  AND (park_name LIKE '%Mus%'
   OR park_name LIKE '%bofj%');
   
-- ------------------------------------------------
-- zoom in on false positives
SELECT regexp_substr(description, '...-....'),
park_name
FROM park
WHERE regexp_like(description, '...-....')
and (park_name like '%Mus%'
OR park_name LIKE '%bofj%');
-- ------------------------------------------------






-- a list of characters
SELECT park_name,
regexp_substr(description,'[0123456789]{3}-[0123456789]{4}')
FROM park
WHERE regexp_like(description,'[0123456789]{3}-[0123456789]{4}');








-- ------------------------------------------------
-- a range of characters
select park_name,
regexp_substr(description, '[0-9]{3}-[0-9]{4}')
FROM park
WHERE regexp_like(description, '[0-9]{3}-[0-9]{4}');





-- ------------------------------------------------
select regexp_count('The shells she sells are surely seashells', 'el') 
as regexp_count
FROM dual;




-- ------------------------------------------------
-- a character class
SELECT park_name,
regexp_substr(description, '[[:digit:]]{3}-[[:digit:]]{4}')
FROM park
where regexp_like(description, '[[:digit:]]{3}-[[:digit:]]{4}');
-- ------------------------------------------------
-- caret ^ is the "NOT" operator
-- so this says anything that is NOT a digit
SELECT park_name,
regexp_substr(description, '[[:digit:]]{3}[^[:digit:]][[:digit:]]{4}')
FROM park
where regexp_like(description, '[[:digit:]]{3}[^[:digit:]][[:digit:]]{4}');
-- ------------------------------------------------




-- escape character "\" if we want to find a period and not have the period
-- represent any character but instead a period
-- this finds phone numbers that have either a period separating the groups
SELECT park_name,description,
regexp_substr(description, '[[:digit:]]{3}\.[[:digit:]]{4}')
FROM park
WHERE regexp_like(description, '[[:digit:]]{3}\.[[:digit:]]{4}');
-- ------------------------------------------------


-- subexpresssions show how quantifiers can be used in multiple places
SELECT park_name,
    regexp_substr(description, '\+([0-9]{1,3}){1,4}([0-9]+)') INTL_PHONE
FROM PARK
WHERE regexp_like(description, '\+([0-9]{1,3}){1,4}([0-9]+)');






-- ------------------------------------------------
-- alternation using an OR symbol "|" (single pipe)
SELECT park_name,
regexp_substr(description,'[[:digit:]]{3}-[[:digit:]]{4}|[[:digit:]]{3}\.[[:digit:]]{4}')
FROM park
WHERE regexp_like(description,'[[:digit:]]{3}-[[:digit:]]{4}|[[:digit:]]{3}\.[[:digit:]]{4}');






-- ------------------------------------------------
-- concise alternation
SELECT park_name,
regexp_substr(description,'[[:digit:]]{3}(-|\.)[[:digit:]]{4}')
from park
where regexp_like(description,'[[:digit:]]{3}(-|\.)[[:digit:]]{4}');






-- ------------------------------------------------
-- this is area code with () or dashes or periods
SELECT park_name,
regexp_substr (description, '([[:digit:]]{3}[-.]|\([[:digit:]]{3}\) )[[:digit:]]{3}[-.][[:digit:]]{4}') park_phone
FROM park
WHERE regexp_like (description, '([[:digit:]]{3}[-.]|\([[:digit:]]{3}\) )[[:digit:]]{3}[-.][[:digit:]]{4}');
-- ------------------------------------------------
-- back references
select park_name,
regexp_substr(description, '(^|[[:space:][:punct:]]+)([[:alpha:]]+)'
                             || '[[:space:][:punct:]]+\2'
                             || '($|[[:space:][:punct:]]+)') doubled_word
FROM park
WHERE regexp_like(description, '(^|[[:space:][:punct:]]+)([[:alpha:]]+)'
|| '[[:space:][:punct:]]+\2'
|| '($|[[:space:][:punct:]]+)');
-- START HERE
--

-- -----------------------------------------------------------------------------
-- REGEX_LIKE
-- find records that have invoice dates between 2010 and 2011
SELECT invoice_id,
invoice_date
FROM invoices_revised
WHERE regexp_like (TO_CHAR(INVOICE_DATE,'YYYY'), '^201[0-1]$');
-- ------------------------------------------------
-- find records were first name is J ignore the case
select * from employees2;
SELECT * FROM employees2 WHERE regexp_like(first_name, '^j', 'i');
-- -----------------------------------------------------------------------------
-- REGEX_SUBSTR
-- return records that have tele in f8
SELECT regexp_substr(f8, 'Tele[[:alpha:]]+',1,1,'i')
FROM files
WHERE regexp_like(f8, 'Tele[[:alpha:]]+');
-- return records that have UCS in f8
SELECT file_id,
f8,
regexp_substr(f8, 'UC[[:alpha:]]',1,1,'i')
FROM files
WHERE regexp_like(f8, 'UCS', 'i');
-- -----------------------------------------------------------------------------
-- REGEX_INSTR
-- return the location of "l" + 4 letters
-- ------------------------------------------------
SELECT regexp_instr('But, soft! What light through yonder window breaks?','l[[:alpha:]]{4}') AS result
FROM dual;
-- ------------------------------------------------
-- return the location of the second "soft"
SELECT regexp_instr('But, soft! What light through yonder window softly breaks?', 's[[:alpha:]]{3}', 1, 2) AS result
FROM dual;
-- ------------------------------------------------
-- start at position 10 then return location of the second occurance of "o"
SELECT regexp_instr ('But, soft! What light through yonder window breaks?','o', 10, 2) AS result
FROM dual;
-- ------------------------------------------------
-- return location of "Tele"
select file_id,
f8,
regexp_instr(f8, 'Tele[[:alpha:]]+',1,1,0,'i')
FROM files
WHERE upper(f8) LIKE '%TELE%';
-- ------------------------------------------------
-- return location of UCS
SELECT file_id,
f8,
regexp_instr(f8, 'UC[[:alpha:]]*',1,1,0,'i')
FROM files
WHERE upper(f8) LIKE '%UCS%';
-- -----------------------------------------------------------------------------
-- REGEX_REPLACE
SELECT *
FROM files;
-- replace the word "light" with "sound"
SELECT regexp_replace('But, soft! What light through yonder window breaks?','l[[:alpha:]]{4}', 'sound') AS result
FROM dual;
-- ------------------------------------------------
-- replace Telepresence with TelePresence
SELECT REGEXP_SUBSTR(F8, 'Tele[[:alpha:]]+',1,1,'i'),
REGEXP_replace(F8, 'Tele[[:alpha:]]+','TelePresence'),
f8
FROM FILES
WHERE UPPER(F8) LIKE '%TELEPR%';
-- Replace "UCS" with "UCS-"
select regexp_substr(f8, 'UC[[:alpha:]]+',1,1,'i'),
regexp_replace(f8, 'UCS[[:alpha:] ]','UCS-'),
f8
FROM files
WHERE upper(f8) LIKE '%UCS%';
-- -----------------------------------------------------------------------------
-- BOOK
-- ------------------------------------------------
-- page 645
select regexp_substr('123 Maple Avenue', '[a-z]') address
FROM dual;
-- ------------------------------------------------
-- page 646 top
SELECT regexp_substr('123 Maple Avenue', '[A-Za-z]') address
FROM dual;
-- ------------------------------------------------
-- page 646 middle
SELECT regexp_substr('123 Maple Avenue this is a long sentence', '[A-Za-z ]+') address
from dual;
-- ------------------------------------------------
-- page 646 bottom
SELECT regexp_substr('123 Maple Avenue', '[[:alpha:] ]+') address
FROM dual;
-- ------------------------------------------------
-- page 647 top
select regexp_substr('123 Maple Avenue', '[:alpha:]+') address
FROM dual;
-- ------------------------------------------------
-- page 647 bottom
SELECT regexp_substr('123 Maple Avenue ', '[[:alpha:]]+', 1, 2) address
FROM dual;
-- ------------------------------------------------
-- page 648 top
select regexp_substr('123 Maple Avenue', '[[:alnum:]]+') address
FROM dual;
-- ------------------------------------------------
-- page 648 middle
SELECT address2,
regexp_substr(address2,'[[:digit:]]+') zip_code
from order_addresses;
-- ------------------------------------------------
-- page 648 bottom
SELECT regexp_substr('123 Maple Avenue', 'Maple') address
from dual;
-- ------------------------------------------------
-- page 649 top
select regexp_substr('she sells sea shells down by the seashore','s[eashor]+e',1,2) the_result
FROM dual;
-- ------------------------------------------------
-- page 649 middle
SELECT regexp_substr('she sells sea shells down by the seashore','s(eashor)e' ) the_result
FROM dual;
-- ------------------------------------------------
-- page 649 bottom 1
SELECT regexp_substr('she sells sea shells down by the seashore','seashore' ) the_result
FROM dual;
-- ------------------------------------------------
-- page 649 bottom 2
SELECT regexp_substr('she sells sea shells down by the seashore','[[:alpha:]]+(shore)' ) the_result
FROM dual;
-- ------------------------------------------------
-- page 650 middle
SELECT address2,
regexp_substr(address2,'(TN|MD|OK)') state
from order_addresses;
-- ------------------------------------------------
SELECT address2,
regexp_substr(address2,'(TN|MD|OK)') state
FROM order_addresses
WHERE regexp_like(address2,'(TN|MD|OK)');
-- ------------------------------------------------
-- page 650 bottom
SELECT regexp_substr('Help desk: (212) 555-1212', '([[:digit:]]+)') area_code
FROM dual;
-- ------------------------------------------------
-- page 651 top
select regexp_substr('Help desk: (212) 555-1212', '\([[:digit:]]+\)') area_code
FROM dual;
-- ------------------------------------------------
-- page 651 middle
SELECT address2,
regexp_substr(address2,'[TBH][[:alpha:]]+') name
FROM order_addresses;
-- ------------------------------------------------
SELECT address2,
regexp_substr(address2,'[TBH][[:alpha:]]+') name
FROM order_addresses
WHERE regexp_like(address2,'[TBH][[:alpha:]]+') ;
-- ------------------------------------------------
-- page 652 top
select regexp_substr('BMW-Oracle;Trimaran;February 2010', '[^;]+', 1, 2) americas_cup
FROM dual;
-- ------------------------------------------------
-- page 652 middle
SELECT address2,
regexp_substr(address2,'[37]+$') last_digit
FROM order_addresses;
where regexp_like(address2,'[37]+$');
-- ------------------------------------------------
SELECT address2,
regexp_substr(address2,'[59]+$') last_digit
FROM order_addresses
where regexp_like(address2,'[59]+$') ;
-- ------------------------------------------------
-- page 653 top
SELECT address2,
regexp_substr(address2,'37$') last_digit
FROM order_addresses;
-- ------------------------------------------------
SELECT address2,
regexp_substr(address2,'(83|78|1|2)$') last_digit
FROM order_addresses
where regexp_like(address2,'(83|78|1|2)$');
-- ------------------------------------------------
-- page 654 top
SELECT regexp_replace('Chapter 1 ......................... I Am Born','[.]+','-') toc
FROM dual;
-- ------------------------------------------------
select regexp_replace('Chapter 1 ......................... I Am Born','[.]','-') toc
from dual;
-- ------------------------------------------------
-- page 654 middle
SELECT regexp_replace('And then he said *&% so I replied with $@($*@','[!@#$%^&*()]','-') prime_time
from dual;
-- ------------------------------------------------
-- page 654 bottom
SELECT regexp_replace('And then he said *&% so I replied with $@($*@','[!@#$%^&*()]+','-') prime_time
FROM dual;
-- ------------------------------------------------
-- page 655 top
SELECT regexp_replace('andin conclusion, 2/3rds of ourrevenue ','( ){2,}', ' ') text_line
FROM dual;
-- ------------------------------------------------
-- page 655 bottom
select address2,
regexp_replace(address2, '(^[[:alpha:]]+)', 'CITY') the_string
FROM order_addresses
WHERE rownum <= 5;
-- ------------------------------------------------
-- page 656 middle
SELECT address2,
regexp_replace(address2, '(^[[:alpha:] ]+)', 'CITY') the_string
FROM order_addresses
WHERE rownum <= 5;
-- ------------------------------------------------
SELECT address2 FROM order_addresses WHERE rownum <= 5;
-- page 657
-- ------------------------------------------------
SELECT address2,
regexp_replace(address2, '(^[[:alpha:] ]+), ([[:alpha:]]{2}) ([[:digit:]]{5})','\3 \2 \1') the_string
from order_addresses
where rownum <= 5;
-- ------------------------------------------------
-- page 658 middle
SELECT address2,
regexp_replace(address2,'(^[[:alpha:] ,]+) ([[:alpha:]]{2}) ([[:digit:]]{5})','\3 \2 \1') the_string
FROM order_addresses
WHERE rownum <= 5;
-- ------------------------------------------------
-- page 658 bottom
SELECT address2,
regexp_replace(address2, '(^[[:alpha:] ]+), ([[:alpha:]]{2}) ([[:digit:]]{5})', '\3 \2-"\1"') the_string
from order_addresses
WHERE rownum <= 5;
SELECT regexp_substr('this is a (string of .. 567)','\([^)]+\)' ) FROM dual;
SELECT regexp_substr('S Elton John','Sir +') FROM dual;



-- =============================================================================
-- Chapter 18
-- =============================================================================
-- -----------------------------------------------------------------------------
-- Tester
-- 1. Login Apex\System\admin create user tester\tester (uncheck everything)
-- 2. SQLPlus\tester 
-- 3. SQLPlus\system\admin
-- 4. Grant create session to tester
-- 5. Disconnect
-- 6. Connect\tester
-- 7. Select * from cruises.cruises;
-- 8. Disconnect
-- 9. Connect\system
-- 16. Grant select on cruises.cruises to tester;
-- 17. Disconnect
-- 18. Connect\tester
-- 19. Select * from cruises.cruises;
-- 20. Disconnect
-- -----------------------------------------------------------------------------
-- Tester2
-- 21. SQLPlus\system
-- 22. Create user tester2 identified by tester2;
-- 23. Disconnect
-- 24. SQLPlus\tester2
-- 25. SQLPlus\system
-- 26. Grant create session to tester2
-- 27. Disconnect
-- 28. SQLPlus\tester2
-- 29. Select * from cruises.cruises;
-- 30. SQLPlus\system
-- 31. Grant select on cruises.cruises to tester2;
-- 32. Disconnect
-- 33. SQLPlus\tester2
-- 34. Select * from cruises.cruises;
-- 35. Disconnect
-- -----------------------------------------------------------------------------
-- Tester1 & 2 SQLDev
-- 36. SQLDev: create connection\Tester
-- 37. Select * from cruises;
-- 38. Select * from cruises.cruises;
-- 39. SQL Dev: create connection\Tester2
-- 40. Select * from cruises;
-- 41. Select * from cruises.cruises;
-- -----------------------------------------------------------------------------
-- Tester3
-- 42. SQL developer\system
-- 43. Create user tester3 identified by tester3;
-- 44. SQLDev: create connection\Tester3
-- 45. SQL developer\system
-- 46. grant create session to tester3;
-- 47. SQL developer\tester3
-- 48. Select * from cruises;
-- 49. Select * from cruises.cruises;
-- 50. SQL developer\system
-- 51. Grant select on cruises.cruises to tester3;
-- 52. SQL developer\tester3
-- 53. Select * from cruises;
-- 54. Select * from cruises.cruises;
-- -----------------------------------------------------------------------------












