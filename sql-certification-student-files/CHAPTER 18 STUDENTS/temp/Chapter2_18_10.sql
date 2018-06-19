-- -----------------------------------------------------------------------------
-- C2:  200
-- C3:  770
-- C4:  1300
-- C5:  1400
-- C6:  1860 :: 1446  :: 1758
-- C7:  2312
-- C8:  2760
-- C9:  3440
-- C10: 4400
-- C11: 4706
-- C12: 5100
-- C13: 5167
-- C14: 5923
-- C15: 6400
-- C16: 6800
-- C17: 7240
-- C18: n/a
-- -----------------------------------------------------------------------------
-- REM KAPLAN HIERARCHICAL PRODUCTS TABLE EXAMPLE ---------------------------------
-- REM TABLE CREATION & ROW INSERTIONS
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
  START WITH PRODUCTID                                                                                = 'P002'
  CONNECT BY PRODUCTID                                                                                = PRIOR PRODUCTBRANDID;
REMTHIS VERSION OF THE QUERY DOES NOT ANSWER THE QUESTION : REMHOW MANY ANCESTORS / SUPERIORS DOES ID = 'P005' HAVE? REMTHE "CONNECT BY" CLAUSE POINTS IN THE WRONG DIRECTION. REMA MORE APPROPRIATE VERSION OF THE QUERY SHOULD BE
AS
  FOLLOWS.
  SELECT LEVEL,
    LPAD(' ', 2*(LEVEL-1))
    || PRODUCTID "PRODUCT ID",
    PRODUCTTYPE,
    PRODUCTCOST,
    PRODUCTBRANDID ,
    SYS_CONNECT_BY_PATH(PRODUCTID,'>') PATH
  FROM PRODUCTS2
    START WITH PRODUCTID      = 'P002'
    CONNECT BY PRODUCTBRANDID = PRIOR PRODUCTID
  ORDER SIBLINGS BY PRODUCTID;
  COMMIT;
  REMI BELIVE THAT A CLEARER QUESTION WOULD HAVE USED A COLUMN NAME LIKE 'POINTS_TO_PRODUCTID' REMAS IN "CONNECT BY POINTS_TO_PRODUCTID = PRIOR PRODUCTID" REMTHEN IT WOULD BE OBVIOUS
WHEN THE CONNECT BY CLAUSE
IS
  POINTED IN THE WRONG DIRECTION.
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
  START WITH productid      = 'P002'
  CONNECT BY productbrandid = prior productid
AND productid!              = 'P004';
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
AND productid         != 'P004';
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
    start_date       DATE,
    end_date         DATE,
    CONSTRAINT work_schedule_pk PRIMARY KEY(work_schedule_id)
  );
DROP TABLE work_schedule1;
CREATE TABLE work_schedule2
  (
    work_schedule_id NUMBER,
    start_date       DATE,
    ts               TIMESTAMP,
    tswtz            TIMESTAMP WITH TIME ZONE,
    tswltz           TIMESTAMP WITH LOCAL TIME ZONE,
    CONSTRAINT work_schedule_pk PRIMARY KEY(work_schedule_id)
  );
DROP TABLE work_schedule2;
INSERT INTO work_schedule2 VALUES
  (1, sysdate, sysdate, sysdate, sysdate
  );
SELECT * FROM work_schedule2;
CREATE TABLE ports3
  (port_id NUMBER, port_name VARCHAR2(20)
  );
ALTER TABLE ports3 MODIFY port_id CONSTRAINT port_id_pk PRIMARY KEY;
DROP TABLE cruises2 CASCADE CONSTRAINTS;
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
    t2 TIMESTAMP(2) WITH TIME ZONE,
    t3 TIMESTAMP(2) WITH LOCAL TIME ZONE
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
    end_date   DATE,
    status     VARCHAR2(5 byte) DEFAULT 'DOCK',
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
    cruise_id   NUMBER,
    cruise_name VARCHAR2(20),
    CONSTRAINT pk_cruises3 PRIMARY KEY (cruise_id)
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
INSERT INTO cruises3 VALUES
  (33.566, 'alpha'
  );
INSERT INTO cruises3
  (cruise_name
  ) VALUES
  ('alpha'
  );
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
    date3 TIMESTAMP WITH TIME ZONE,
    date4 TIMESTAMP WITH LOCAL TIME ZONE
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
( cruise_id NUMBER (4,2),
cruise_name VARCHAR2(5));
2. drop table cruises3
3. create anonymous primary key in line
CREATE TABLE cruises3
( cruise_id integer primary key,
cruise_name VARCHAR2(5));
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
    cruise_id   INTEGER PRIMARY KEY,
    cruise_name VARCHAR2(5)
  );
CREATE TABLE cruises3
  (
    cruise_id   INTEGER CONSTRAINT cruises3_pk PRIMARY KEY,
    cruise_name VARCHAR2(5)
  );
CREATE TABLE cruises3
  (
    cruise_id   NUMBER,
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
    cruise_id   INTEGER ,
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
CREATE TABLE ports2a
  (
    port_id   NUMBER,
    port_name VARCHAR2(20),
    country   VARCHAR2(40),
    capacity  NUMBER,
    CONSTRAINT pk_port2a PRIMARY KEY(port_id)
  );
BEGIN
  INSERT
  INTO ports2a
    (
      port_id,
      port_name,
      country,
      capacity
    )
    VALUES
    (
      1,
      'NYC',
      'USA',
      500
    );
  INSERT
  INTO ports2a
    (
      port_id,
      port_name,
      country,
      capacity
    )
    VALUES
    (
      2,
      'NC',
      'USA',
      1500
    );
  INSERT
  INTO ports2a
    (
      port_id,
      port_name,
      country,
      capacity
    )
    VALUES
    (
      3,
      'FL',
      'USA',
      1600
    );
END;
/
TRUNCATE TABLE ports2a;
SELECT * FROM ports2a;
DROP TABLE ports2;
CREATE TABLE ships2
  (
    ship_id      NUMBER,
    ship_name    VARCHAR2(20),
    home_port_id NUMBER,
    CONSTRAINT fk_ships2_ports FOREIGN KEY (home_port_id) REFERENCES ports2(port_id)
  );
DROP TABLE ships2;
INSERT INTO ships2 VALUES
  (100,'Badger',10
  );
INSERT INTO ships2 VALUES
  (100,'Badger',20
  );
DESC ships2;
DESC ports2a;
INSERT INTO ships2 VALUES
  (100,'Badger',2
  );
COMMIT;
SELECT * FROM ports2;
SELECT * FROM ships2;
DELETE FROM ports2 WHERE port_id = 1;
DELETE FROM ships2 WHERE ship_id = 100;
CREATE TABLE vendors2
  (
    vendor_id   NUMBER,
    vendor_name VARCHAR2(20),
    statusNUMBER(1) CHECK (status IN (4,5)),
    categoryVARCHAR2(5)
  );
INSERT INTO VENDORS2 VALUES
  (1,'SMITH', 5, 'ANY'
  );
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
    supplier_id   NUMBER(10),
    supplier_name VARCHAR2(50) CONSTRAINT supplier_name_nn NOT NULL,
    contact_name  VARCHAR2(50),
    CONSTRAINT supplier_supplier_id_pk PRIMARY KEY (supplier_id)
  );
DROP TABLE supplier2 CASCADE CONSTRAINTS;
INSERT INTO supplier2 VALUES
  (1,'ABC','Fred Dobbs'
  );
INSERT INTO supplier2 VALUES
  (2,'ACME','Tom Smith'
  );
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
    supplier_id   NUMBER(10),
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
    supplier_id   NUMBER(10) NOT NULL,
    supplier_name VARCHAR2(50) NOT NULL,
    CONSTRAINT prod_supp_suppid_supprname_fk FOREIGN KEY (supplier_id, supplier_name) REFERENCES supplier3(supplier_id, supplier_name)
  );
DROP TABLE products3 CASCADE CONSTRAINTS;
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
    supplier_id   NUMBER(10) NOT NULL,
    supplier_name VARCHAR2(50) NOT NULL
    --constraint products4_fk foreign key (supplier_id) references supplier2(supplier_id)
  );
DROP TABLE products4 CASCADE CONSTRAINTS;
-- "add" foreign key after tables are created
ALTER TABLE products4 ADD CONSTRAINT prod4_fk FOREIGN KEY (supplier_id) REFERENCES supplier2(supplier_id);
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
    supplier_id   NUMBER(10),
    supplier_name VARCHAR2(50)
  );
ALTER TABLE products4 ADD CONSTRAINT prod_supp_suppid_suppname_fk FOREIGN KEY
(
  supplier_id, supplier_name
)
REFERENCES supplier2
(
  supplier_id, supplier_name
)
;
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
    pid        INTEGER CONSTRAINT people_pid_pk PRIMARY KEY,
    start_date DATE DEFAULT sysdate,
    fname      VARCHAR2(15) CONSTRAINT people_fname_nn NOT NULL,
    lname      VARCHAR2(15) CONSTRAINT people_lname_nn NOT NULL,
    email      VARCHAR2(45) CONSTRAINT people_email_uk UNIQUE
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
DROP TABLE assignments;
DESC assignments;
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
SELECT *
FROM cruise_customers;
DELETE FROM cruise_customers;
ROLLBACK;
SELECT * FROM ports;
SELECT * FROM employees;
SELECT * FROM cruises;
SELECT * FROM USER_CONS_COLUMNS WHERE TABLE_NAME = 'CRUISES';
SELECT * FROM USER_CONS_COLUMNS WHERE TABLE_NAME = 'EMPLOYEES';
SELECT * FROM USER_CONS_COLUMNS WHERE TABLE_NAME = 'CONTACT_EMAILS';
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
DROP SEQUENCE SEQ_CRUISE_ID;
CREATE SEQUENCE SEQ_CRUISE_ID;
  INSERT
  INTO cruises
    (
      cruise_id,
      cruise_type_id,
      cruise_name,
      captain_id,
      start_date,
      end_date,
      status
    )
    VALUES
    (
      seq_cruise_id.nextval,
      '1',
      'Moon At Sea',
      1,
      '02-JAN-10',
      '09-JAN-10',
      'Sched'
    );
  INSERT
  INTO cruises VALUES
    (
      seq_cruise_id.nextval,
      '1',
      'Whales At Sea',
      8,1,
      '02-JAN-10',
      '09-JAN-10',
      'Sched'
    );
  INSERT INTO cruises
    (cruise_id
    ) VALUES
    (seq_cruise_id.nextval
    );
  SELECT * FROM cruises;
  DELETE FROM cruises;
  CREATE TABLE cruises4 AS
  SELECT * FROM cruises;
  SELECT * FROM cruises;
  SELECT * FROM ships;
  UPDATE cruises SET ship_id = 8 WHERE cruise_id = 1;
  SELECT * FROM cruises;
  ROLLBACK;
  COMMIT;
  UPDATE cruises SET ship_id = 8 WHERE cruise_id = 1;
  DELETE FROM cruises;
  UPDATE cruises
  SET cruise_type_id = 1,
    cruise_name      ='Sun at Sea',
    ship_id          = 1,
    captain_id       = 1,
    start_date       = '05-JAN-10',
    end_date         = '08-JAN-10',
    status           ='Sched'
  WHERE cruise_id    = 3;
  BEGIN
    INSERT
    INTO cruises
      (
        cruise_id,
        cruise_type_id,
        cruise_name,
        captain_id,
        start_date,
        end_date,
        status
      )
      VALUES
      (
        seq_cruise_id.nextval,
        '1' ,
        'Day At Sea' ,
        1,
        '02-JAN-10',
        '09-JAN-10',
        'Sched'
      );
    INSERT
    INTO cruises
      (
        cruise_id,
        cruise_type_id,
        cruise_name,
        captain_id,
        start_date,
        end_date,
        status
      )
      VALUES
      (
        seq_cruise_id.nextval,
        '1' ,
        'Day At Sea' ,
        1,
        '02-JAN-10',
        '09-JAN-10',
        'Sched'
      );
  END;
  /
  DESC cruises;
  SELECT MAX(cruise_id) FROM cruises;
CREATE sequence seq_cruise_id start with 15;
  ;
  DROP sequence seq_cruise_id;
  SELECT * FROM cruises WHERE cruise_id IN (10,12,14);
  SELECT * FROM cruises WHERE cruise_id IN (1,3,5,7);
  UPDATE cruises SET cruise_name = 'Bahamas' WHERE cruise_id IN (1,3,5,7);
  SELECT * FROM cruises WHERE cruise_id IN (2,4,6,8);
  UPDATE cruises SET cruise_name = 'Hawaii' WHERE cruise_id IN (2,4,6,8);
  UPDATE cruises
  SET cruise_name  = 'Mexico',
    status         = 'SCHED'
  WHERE cruise_id IN (10,12,14);
  CREATE TABLE salary_chart
    (
      org_id             NUMBER(7),
      emp_title          VARCHAR2(30),
      emp_income         NUMBER(10,2),
      superior           VARCHAR2(30),
      sup_income         NUMBER(10,2),
      last_modified_by   VARCHAR2(25),
      last_modified_date DATE
    );
  ALTER TABLE salary_chart ADD last_modified_by    DATE;
  ALTER TABLE salary_chart MODIFY last_modified_by VARCHAR2
  (
    25
  )
  ;
  ALTER TABLE salary_chart ADD last_modified_date DATE;
  SELECT * FROM salary_chart;
  DESC salary_chart;
  INSERT
  INTO salary_chart VALUES
    (
      1,
      'Chef',
      48000,
      'Restaurant Chief',
      2025,
      'birogers',
      '14-DEC-11'
    );
  INSERT
  INTO salary_chart VALUES
    (
      1,
      'Director',
      75000,
      'Captain',
      2511,
      'birogers',
      '14-DEC-11'
    );
  INSERT
  INTO salary_chart VALUES
    (
      1,
      'Manager',
      65000,
      'Director',
      1377,
      'birogers',
      '14-DEC-11'
    );
  UPDATE salary_chart
  SET emp_income  = 66000,
    sup_income    = 1500
  WHERE emp_title = 'Manager';
  SELECT * FROM salary_chart;
  SELECT * FROM salary_chart WHERE sup_income >= 2500;
  UPDATE salary_chart
  SET sup_income    = sup_income + 1000
  WHERE sup_income >= 2500;
  UPDATE salary_chart SET sup_income = sup_income + 500 WHERE sup_income < 2500;
  SELECT * FROM salary_chart;
  SELECT * FROM salary_chart WHERE emp_title LIKE 'Manager';
  UPDATE salary_chart
  SET emp_income       = 49500,
    sup_income         = 2500,
    last_modified_by   = 'brogers',
    last_modified_date = sysdate
  WHERE emp_title LIKE 'Chef';
  UPDATE salary_chart
  SET emp_income       = 75000,
    sup_income         =3100,
    last_modified_by   = 'brogers',
    last_modified_date = sysdate
  WHERE emp_title LIKE 'Director';
  UPDATE salary_chart
  SET emp_income       = 65000,
    last_modified_by   = 'brogers',
    last_modified_date = sysdate
  WHERE emp_title LIKE 'Manager';
  SAVEPOINT salary_adj;
  UPDATE salary_chart
  SET sup_income       = sup_income*.90,
    last_modified_date = sysdate;
  SELECT * FROM salary_chart;
  ROLLBACK;
  DELETE FROM salary_chart;
  SELECT * FROM salary_chart;
  ROLLBACK;
  ROLLBACK;
  ALTER TABLE salary_chart ADD (last_modified_by VARCHAR2(12), last_modified_date DATE);
  COMMIT;
  SELECT * FROM cruises;
  SELECT * FROM employees;
  DESC cruises;
  SELECT * FROM ships;
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
  INSERT
  INTO CRUISES VALUES
    (
      2,1,
      'Day At Sea',
      101,
      '02-JAN-10',
      '09-JAN-10',
      'Sched'
    );
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
  INTO CRUISES VALUES
    (
      cruise_cruise_id_seq.nextval,
      1,
      'Day At Sea',
      8,8,
      '02-JAN-10',
      '09-JAN-10',
      'Sched'
    );
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
    START_DATE    = '01-DEC-11'
  WHERE CRUISE_ID = 1;
  UPDATE CRUISES
  SET CRUISE_NAME = 'Bahamas',
    START_DATE    = '02/DEC/02'
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
  UPDATE cruises SET end_date = end_date + 5, start_date = start_date + 5 ;
  SELECT * FROM projects;
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
      PROJECT_ID   NUMBER PRIMARY KEY ,
      PROJECT_NAME VARCHAR2(40) ,
      COST         NUMBER ,
      CONSTRAINT CK_COST CHECK (COST < 1000000)
    );
  BEGIN
    INSERT
    INTO projects2
      (
        project_id,
        project_name,
        cost
      )
      VALUES
      (
        1,
        'Hull Cleaning',
        340000
      );
    INSERT
    INTO projects2
      (
        project_id,
        project_name,
        cost
      )
      VALUES
      (
        2,
        'Deck Resurfacing',
        96400
      );
    INSERT
    INTO projects2
      (
        project_id,
        project_name,
        cost
      )
      VALUES
      (
        3,
        'Lifeboat Inspection',
        12000
      );
  END;
  /
  SELECT * FROM projects;
  UPDATE projects SET project_cost = project_cost * 1.03;
  UPDATE projects
  SET project_cost                        = project_cost * 1.05
  WHERE project_cost              * 1.05 <= 1000000;
  ROLLBACK;
  COMMIT;
  SELECT * FROM ships;
  UPDATE ships SET home_port_id = 1 WHERE ship_id = 3;
  SAVEPOINT sp_1;
  UPDATE ships SET home_port_id = 3 WHERE ship_id = 3;
  SELECT * FROM ships;
  ROLLBACK TO sp_1;
  /*
  -- C3 Page 110 (3/5)
  1. Copy update from above
  2. Modify with where clause
  3. Update
  4. Select
  */
  UPDATE projects2
  SET cost              = cost * 1.2
  WHERE cost      * 1.2 < 1000000;
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
      pid        INTEGER CONSTRAINT people_pid_pk PRIMARY KEY,
      start_date DATE DEFAULT sysdate fname VARCHAR2(15) CONSTRAINT people_fname_nn NOT NULL,
      lname      VARCHAR2(15) CONSTRAINT people_lname_nn NOT NULL,
      email      VARCHAR2(45) CONSTRAINT people_email_uk UNIQUE
    );
  DESC people;
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
  -- DROP TABLE assignments;
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
  DESC locations;
  -- DROP TABLE locations;
  /*
  5. Create a sequence for people and locations
  -- ---------------------------------------------------
  */
CREATE sequence people_pid_seq start with 1000;
  -- DROP sequence people_pid_seq;
CREATE sequence locations_lid_seq start with 1;
  -- DROP sequence locations_lid_seq;
  /*
  6. Insert three rows into people (using sequence)
  7. Insert six rows into assignments (each person works two locations)
  8. Insert three rows into locations (using sequence)
  -- ---------------------------------------------------
  */
  BEGIN
    INSERT INTO people(pid,start_date,fname,lname,email)
      VALUES(people_pid_seq.nextval,sysdate,'Marshal','Rango','rango@hotmail.com');
    INSERT INTO people(pid,start_date,fname,lname,email)
      VALUES(people_pid_seq.nextval,sysdate,'Penelope','Pitstop','ppitstop@gmail.com');
    INSERT INTO people(pid,start_date,fname,lname,email)
      VALUES(people_pid_seq.nextval,sysdate,'Ranger','Andy','randy@juno.com');
  END;
  /
  SELECT * FROM people;
  BEGIN
    INSERT INTO locations(lid,name,city,state)
      VALUES(locations_lid_seq.nextval,'Bar 4 Ranch','Lubbock','TX');
    INSERT INTO locations(lid,name,city,state)
      VALUES(locations_lid_seq.nextval,'Bar B Que','Austin','TX');
    INSERT INTO locations(lid,name,city,state)
      VALUES(locations_lid_seq.nextval,'Space Out','Houston','TX');
  END;
  /
  BEGIN
    INSERT INTO assignments(pid, lid) 
      VALUES(1000,1);
    INSERT INTO assignments(pid, lid) 
      VALUES(1000,2);
    INSERT INTO assignments(pid, lid) 
      VALUES (1000,3);
  END;
  /
  SELECT * FROM people;
  DELETE FROM people WHERE pid = 1000;
  DELETE FROM locations WHERE lid =2;
  SELECT * FROM locations;
  DESC assignments;
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
  ORDER BY capacity DESC;
  SELECT SHIP_ID,SHIP_NAME,CAPACITY FROM SHIPS ORDER BY 3 DESC, ship_name;
  SELECT 'ping pong',ship_id,ship_name,capacity FROM ships;
  SELECT '?' FROM ships;
  SELECT 'ping pong' FROM ships;
  SELECT '---',ship_name FROM ships;
  SELECT ship_name, rownum FROM ships;
  SELECT *
  FROM
    (SELECT ship_name, rownum FROM ships ORDER BY ship_name
    )
  WHERE rownum < 3;
  SELECT * FROM employees;
  SELECT DISTINCT last_name FROM employees;
  SELECT UNIQUE last_name FROM employees;
  SELECT employee_id,
    salary,
    (salary*1.05)
  FROM pay_history
  WHERE end_date IS NULL
  ORDER BY employee_id;
  SELECT * FROM pay_history;
  SELECT 10+15*3 FROM dual;
  SELECT (11 - 4 + (( 2+3) * .7) / 4) FROM dual;
  SELECT rownum, ship_name FROM ships;
  SELECT * FROM employees;
  CREATE VIEW vw_emp AS
  SELECT first_name,last_name FROM employees;
  SELECT * FROM vw_emp;
  SELECT SHIP_ID, SHIP_NAME, capacity FROM ships ORDER BY 1, 2;
  SELECT SHIP_ID,
    rowid,
    rownum
  FROM ships
  WHERE ship_id BETWEEN 3 AND 6
  ORDER BY 1 DESC;
  DESC employees;
  SELECT * FROM employees;
  SELECT DISTINCT last_name, first_name FROM employees;
  SELECT * FROM pay_history;
  SELECT employee_id,
    salary,
    salary*1.05,
    end_date
  FROM pay_history
  WHERE end_date IS NOT NULL;
  SELECT last_name FROM employees;
  SELECT DISTINCT last_name FROM employees ;
  SELECT COUNT(*), last_name FROM employees GROUP BY last_name;
  SELECT * FROM ship_cabin_grid;
  SELECT * FROM pay_history WHERE end_date IS NULL;
  SELECT employee_id,
    salary,
    salary*1.05
  FROM pay_history
  WHERE end_date IS NULL
  ORDER BY employee_id;
  SELECT end_date FROM pay_history;
  SELECT COUNT(*) FROM customers;
  SELECT COUNT(*) FROM orders;
  SELECT * FROM customers c, orders o WHERE c.customer# = o.customer#;
  SELECT * FROM customers c JOIN orders o ON c.customer# = o.customer#;
  SELECT * FROM customers JOIN orders USING (customer#);
  SELECT * FROM books;
  SELECT title t, retail r , ROUND(retail * 1.05,2) nr FROM books;
  SELECT lower(title) FROM books;
  SELECT COUNT(*) FROM customers JOIN orders USING(customer#);
  CREATE VIEW vw_customer_orders AS
  SELECT * FROM customers JOIN orders USING (customer#);
  SELECT * FROM vw_customer_orders;
  UPDATE vw_customer_orders SET order# = 10001 WHERE order# = 10000;
  SELECT COUNT(*) FROM orders;
  SELECT customer#
  FROM customers
  WHERE customer# NOT IN
    (SELECT customer# FROM orders
    );
  SELECT * FROM customers WHERE state IN ('FL','GA');
  CREATE VIEW southeast AS
  SELECT firstname, lastname FROM customers WHERE state IN ('FL','GA');
  DROP VIEW southeast;
  COMMIT;
  SELECT * FROM southeast;
  DESC southeast;
  SELECT COUNT(catcode), catcode FROM books GROUP BY catcode;
  SELECT shipdate FROM orders;
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
  SELECT COUNT(*)
  FROM customers;
  -- old school join
  SELECT DISTINCT firstname,
    lastname
  FROM customers c,
    orders o
  WHERE c.customer# = o.customer#;
  -- new school join #1
  SELECT firstname,
    lastname,
    order#
  FROM customers c
  JOIN orders o
  ON c.customer# = o.customer#;
  -- new school join #2
  SELECT firstname,
    lastname,
    order#
  FROM customers
  JOIN orders USING(customer#);
  SELECT lastname,
    firstname,
    order#
  FROM customers
  JOIN orders USING (customer#)
  ORDER BY 3,
    2,
    1;
  /*
  SELECT lastname, firstname, order#
  FROM customers LEFT JOIN orders USING (customer#)
  ORDER BY 3, 2, 1;
  */
  SELECT lastname,
    firstname,
    order#
  FROM customers c
  JOIN orders o
  ON c.customer# = o.customer#
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
  SELECT lastname,
    firstname,
    order#
  FROM customers c
  LEFT OUTER JOIN orders o
  ON c.customer# = o.customer#
  ORDER BY 3,
    2,
    1;
  SELECT lastname,
    firstname,
    order#
  FROM customers c ,
    orders o
  WHERE c.customer# = o.customer#;
  SELECT lastname,
    firstname,
    order#
  FROM customers c ,
    orders o
  WHERE c.customer# = o.customer#;
  -- customers without orders
  SELECT c.customer#,
    lastname,
    firstname
  FROM customers c
  WHERE NOT EXISTS
    (SELECT customer# FROM orders o WHERE c.customer# = o.customer#
    );
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
  SELECT DISTINCT c.customer#, lastname, firstname FROM customers c;
  SELECT COUNT(DISTINCT c.customer#) FROM customers c;
  -- 22
  SELECT COUNT(*) FROM orders;
  -- =============================================================================
  -- Chapter 5
  -- =============================================================================
  SELECT *
  FROM employees
  WHERE ship_id ^= 3;
  SELECT firstname, lastname, state FROM customers WHERE state IN ('FL','GA');
  SELECT firstname,
    lastname,
    state
  FROM customers
  WHERE state LIKE 'N_'
  OR state LIKE 'W_';
  SELECT firstname,
    lastname,
    state
  FROM customers
  WHERE state = 'NJ'
  OR state    = 'WY';
  SELECT firstname, lastname, state FROM customers WHERE state IN ('NJ','WY');
  SELECT (sysdate +1)-sysdate FROM dual;
  SELECT * FROM employees WHERE ship_id IN (1,3);
  SELECT * FROM employees WHERE ship_id = 1 OR ship_id =3;
  SELECT last_name, first_name FROM employees WHERE last_name LIKE '%in%';
  SELECT * FROM ports;
  SELECT * FROM ports WHERE port_name LIKE 'San_____';
  CREATE TABLE test
    (name VARCHAR2(10)
    );
  INSERT INTO test VALUES('APPLE');
  INSERT INTO test VALUES('apple');
  INSERT INTO test VALUES('10');
  INSERT INTO test VALUES('1');
  INSERT INTO test VALUES('2');
  INSERT INTO test VALUES(' ');
  INSERT INTO test VALUES(NULL);
  
  SELECT name FROM test ORDER BY 1c;
  UPDATE test SET name = '02' WHERE name = '2';
  SELECT * FROM work_history;
  SELECT employee_id, status FROM work_history WHERE NOT status = 'Pending';
  SELECT port_name FROM ports WHERE port_name IN ('San%');
  SELECT employee_id
  FROM work_history
  WHERE ship_id = 3
  AND status   != 'Pending';
  
  
  SELECT room_number,
    room_style,
    window
  FROM ship_cabins
  WHERE room_style = 'Suite'
  OR room_style    = 'Stateroom'
  AND window       = 'Ocean';
  
  
  
  
  
  SELECT room_number,
    room_style,
    window
  FROM ship_cabins
  WHERE NOT room_style = 'Suite'
  OR room_style        = 'Stateroom'
  AND window           = 'Ocean';
  SELECT room_number,
    room_style,
    window
  FROM ship_cabins
  WHERE (room_style = 'Suite'
  OR room_style     = 'Stateroom')
  AND window        = 'Ocean';
  SELECT port_name, capacity FROM ports WHERE capacity >= 3 AND capacity <= 4;
  SELECT port_name, capacity FROM ports WHERE capacity <= 3 OR capacity >= 4;
  SELECT port_name, capacity FROM ports WHERE capacity BETWEEN 3 AND 4;
  SELECT * FROM books;
  SELECT * FROM promotion;
  SELECT title,
    retail,
    minretail,
    maxretail,
    gift
  FROM books,
    promotion
  WHERE retail BETWEEN minretail AND maxretail;
  SELECT * FROM customers WHERE state NOT IN ('FL','GA');
  SELECT state FROM customers WHERE NOT state ^= 'FL' OR NOT state <> 'GA';
  SELECT COUNT(*) FROM orders;
  SELECT * FROM orders;
  SELECT COUNT(shipdate) FROM orders;
  SELECT COUNT(order#) FROM orders;
  SELECT * FROM orders WHERE shipdate IS NULL;
  SELECT DISTINCT purpose,
    project_name,
    project_cost,
    days,
    ROUND(project_cost/days) cpd
  FROM projects
  ORDER BY cpd;
  ;
  SELECT * FROM books;
  SELECT * FROM books WHERE pubdate >= '01-JAN-01' AND pubdate <= '31-DEC-01';
  SELECT * FROM books WHERE pubdate BETWEEN '01-JAN-01' AND '31-DEC-01';
  SELECT * FROM books WHERE pubdate LIKE '%-01';
  SELECT category FROM books;
  SELECT DISTINCT category FROM books;
  SELECT COUNT(DISTINCT category) FROM books;
  SELECT COUNT(*) FROM customers;
  SELECT COUNT(referred) FROM customers;
  SELECT * FROM customers WHERE 1=1;
  SELECT table_name FROM all_tab_columns WHERE column_name LIKE '%DATE_FORMAT%';
  SELECT * FROM orders;
  SELECT title FROM books WHERE title LIKE '_A_N%';
  SELECT * FROM customers WHERE state NOT IN ('FL','GA');
  SELECT * FROM customers WHERE state LIKE 'F%';
  SELECT title, category, pubid, cost FROM books;
  SELECT title,
    category,
    pubid,
    cost
  FROM books
  WHERE (category = 'FAMILY LIFE'
  OR pubid        = 4)
  AND cost       >= 20;
  SELECT room_number,
    room_style,
    window
  FROM ship_cabins
  WHERE room_style = 'Suite'
  OR room_style    = 'Stateroom'
  AND window       = 'Ocean';
  SELECT * FROM books WHERE catcode = 'FAL';
  SELECT * FROM books WHERE pubid = 4;
  SELECT * FROM books WHERE cost > 15;
  SELECT room_number,
    room_style,
    window
  FROM ship_cabins
  WHERE NOT room_style LIKE 'Suite';
  --and window = 'Ocean';
  SELECT port_name
  FROM ports
  WHERE country IN ('UK','USA','Bahamas');
  SELECT port_name FROM ports WHERE capacity = NULL;
  -- =============================================================================
  -- HANDS ON ASSIGNMENTS CHAPTER 5
  /*
  1.
  Return port_id, port_name, capacity
  for ports that start with either "San" or "Grand"
  and have a capacity of 4.
  */
  SELECT port_id,
    port_name,
    capacity
  FROM ports
  WHERE (port_name LIKE 'San%'
  OR port_name LIKE 'Grand%')
  AND capacity = 4;
  /*
  2.
  Return vendor_id, name, and category
  where the category is 'supplier', 'subcontractor' or ends with 'partner'.
  */
  SELECT table_name
  FROM all_tab_columns
  WHERE column_name LIKE '%VEND%'
  AND owner = 'CRUISES';
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
  WHERE window      = 'None'
  OR balcony_sq_ft IS NULL;
  /*
  4.
  Return ship_id, ship_name, capacity, length
  from ships where 2052 <= capacity <= 3000
  and the length is either 100 or 855
  and the ship begins with "Codd"
  */
  SELECT ship_id,
    ship_name,
    capacity,
    LENGTH
  FROM ships
  WHERE capacity BETWEEN 2052 AND 3000
  AND LENGTH IN (100,855)
  AND ship_name LIKE 'Codd_%';
  SELECT * FROM ships;
  ALTER TABLE ships ADD lifeboats INTEGER;
  UPDATE ships SET lifeboats = 82 WHERE ship_name = 'Codd Crystal';
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
  and 80 <= lifeboats <= 100
  and capacity / lifeboats > 25
  */
  SELECT ship_id,
    ship_name,
    lifeboats,
    capacity
  FROM ships
  WHERE (ship_name = 'Codd Elegance'
  OR ship_name     = 'Codd Victorious')
    --   and lifeboats >= 80
    --   and lifeboats <= 100
  AND lifeboats BETWEEN 80 AND 100
  AND capacity / lifeboats > 25;
  -- select first name and last name and order number
  -- from the books schema
  -- use the key word using
  -- for customers whpo have placed orders
  SELECT firstname,
    lastname,
    order#
  FROM customers
  JOIN orders USING (customer#);
  SELECT ship_id
  FROM ships
  WHERE ((2*lifeboats)+57) - capacity IN (lifeboats *20,Lifeboats+LENGTH);
  SELECT ship_id,
    ship_name,
    lifeboats,
    capacity
  FROM ships
  WHERE ship_name         IN ('Codd Elegance','Codd Victorious')
  AND (lifeboats          >= 80
  AND lifeboats           <=100)
  AND capacity / lifeboats > 25;
  -- =============================================================================
  -- Chapter 6
  -- =============================================================================
  SELECT *
  FROM dual;
  SELECT sysdate FROM dual;
  -- Type in 215
  SELECT employee_id,
    last_name
  FROM employees
  WHERE upper(last_name) = 'SMITH';
  SELECT lastname, firstname FROM customers;
  SELECT employee_id,
    last_name
  FROM employees
  WHERE initcap(last_name) = 'Smith';
  SELECT lastname, firstname FROM customers;
  SELECT firstname || ' ' || lastname AS fullname FROM customers;
  SELECT firstname || ' ' || lastname FROM customers;
  SELECT 'Hello, ' || 'World!' FROM dual;
  SELECT concat(concat(firstname,' '),lastname) FROM customers;
  SELECT * FROM BOOK_CONTENTS;
  -- Type in 216
  SELECT initcap('napoleon'),
    initcap('RED O''BRIEN'),
    initcap('McDonald''s')
  FROM dual;
  -- Type in 218
  SELECT rpad (chapter_title
    || ' ',40,'.')
    || lpad(' '
    || PAGE_NUMBER,40,'.') "Table of Contents"
  FROM book_contents
  ORDER BY book_content_id;
  -- page_number;
  SELECT LENGTH(last_name) FROM employees;
  SELECT instr('Mississippi','is',-1) FROM dual;
  SELECT ship_name, LENGTH(ship_name) FROM ships;
  SELECT rpad (CHAPTER_TITLE
    || ' ',30,'.')
  FROM book_contents
  ORDER BY page_number;
  SELECT chapter_title FROM book_contents;
  -- Type in 219
  SELECT rtrim ('Seven thousand--------','-') FROM dual;
  -- Type in 220
  SELECT instr ('Mississippi', 'is',1,2) FROM dual;
  SELECT * FROM dual;
  -- Type in 221
  SELECT SUBSTR('Name: MARK KENNEDY',7, 4) FROM dual;
  SELECT SUBSTR('Name: MARK KENNEDY',7, 4) FROM cruises;
  SELECT floor(2.99)FROM dual;
  SELECT floor(-2.99)FROM dual;
  SELECT ceil(2.99)FROM dual;
  SELECT ceil(-2.99)FROM dual;
  SELECT ROUND(2.50)FROM dual;
  SELECT ROUND(-2.99)FROM dual;
  SELECT TRUNC(2.49)FROM dual;
  SELECT TRUNC(-2.99)FROM dual;
  SELECT soundex('billy') , soundex('rogers') FROM dual;
  SELECT * FROM cruises;
  SELECT ROUND(-2.55,0) FROM dual;
  SELECT TRUNC(-2.99,0) FROM dual
  SELECT SUBSTR('Name: MARK KENNEDY',12) FROM dual;
  SELECT mod(11,3) FROM dual;
  SELECT remainder(11,3) FROM dual;
  SELECT remainder(17,4) FROM dual;
  SELECT sysdate today,
    ROUND(systimestamp, 'HH'),
    ROUND(sysdate, 'DD'),
    ROUND(sysdate, 'MM'),
    ROUND(sysdate,'RR')
  FROM dual;
  SELECT next_day('27-JUN-12','Saturday') FROM dual;
  SELECT next_day(sysdate,'Wed') FROM dual;
  SELECT ROUND(last_day(sysdate)+1,'YY') FROM dual;
  SELECT add_months(sysdate,2) FROM dual;
  SELECT months_between('27-MAY-11',sysdate) FROM dual;
  SELECT (sysdate - to_date('27-JUN-11 20:54:00','dd-MM-YY HH24:MI:SS'))/365
  FROM dual;
  SELECT numtoyminterval(27,'MONTH') FROM dual;
  SELECT numtoyminterval(27,'YEAR') FROM dual;
  SELECT numtoyminterval(sysdate,'YEAR') FROM dual;
  SELECT numtodsinterval(1440, 'MINUTE') FROM dual;
  SELECT * FROM orders;
  SELECT shipdate, orderdate FROM orders;
  SELECT shipdate, orderdate FROM orders WHERE shipdate IS NULL;
  SELECT shipdate, NVL(shipdate,sysdate) FROM orders WHERE shipdate IS NULL;
  SELECT * FROM scores;
  SELECT updated_test_score,
    DECODE(updated_test_score, 95, 'A', 75, 'C', 83, 'B') AS grade
  FROM scores;
  SELECT updated_test_score,
    CASE
      WHEN updated_test_score BETWEEN 90 AND 100
      THEN 'A'
      WHEN updated_test_score>80
      THEN 'B'
      WHEN updated_test_score>70
      THEN 'C'
        -- else 'Fail'
    END grade
  FROM scores;
  SELECT shipdate, NVL(shipdate,sysdate) FROM orders WHERE shipdate IS NULL;
  SELECT * FROM scores;
  SELECT test_score, updated_test_score FROM scores;
  -- Type in 222
  SELECT soundex('William'), soundex('Rogers') FROM dual;
  -- Type in 223
  SELECT ROUND(12.355143, 2), ROUND(259.99,-1) FROM dual;
  SELECT cost,
    retail,
    retail       -cost,
    ROUND((retail-cost),0),
    TRUNC((retail-cost),0)
  FROM books;
  SELECT ROUND(-2.49), ROUND(-2.51),TRUNC(-2.49), TRUNC(-2.51) FROM dual;
  --SELECT cost, retail, retail-cost, TRUNC((retail-cost),0) FROM books;
  SELECT remainder(28,9)
  FROM dual;
  SELECT remainder(27,8) FROM dual;
  SELECT remainder(28,9) FROM dual;
  SELECT remainder(28,9) FROM dual;
  SELECT remainder(35,8) FROM dual;
  SELECT remainder(29,8) FROM dual;
  SELECT remainder(7,4) FROM dual;
  SELECT mod(17,4) FROM dual;
  SELECT mod(45,9) FROM dual;
  SELECT remainder(11,3) FROM dual;
  SELECT remainder(7,5) FROM dual;
  SELECT mod(7,6) FROM dual;
  -- Type in 224 top
  SELECT TRUNC(12.355143,2), TRUNC(259.99,-2)FROM dual;
  SELECT ROUND(12.355143,2), ROUND(259.99,-1)FROM dual;
  -- Type in 224 bottom
  SELECT remainder(9,3),
    remainder(10,3),
    remainder(11,3)
  FROM dual;
  -- Type in 227
  SELECT sysdate today,
    ROUND(sysdate,'mm') rounded_month,
    ROUND(sysdate,'rr') rounded_year,
    ROUND(sysdate,'dd') rounded_day,
    TRUNC(sysdate,'mm') truncated_month,
    TRUNC(sysdate,'rr') truncated_year,
    TRUNC(sysdate,'dd') truncated_day
  FROM dual;
  SELECT orderdate,ROUND(orderdate,'mm') FROM orders;
  SELECT sysdate, next_day(sysdate, 'WEDNESDAY') FROM dual;
  SELECT last_day('14-FEB-11'),last_day('14-FEB-12') FROM dual;
  SELECT to_date('16/02/11 ','dd/mm/yy')FROM dual;
  SELECT ROUND(to_date('16-FEB-11','dd-mm-yy'),'mm') FROM dual;
  SELECT add_months(sysdate,12) FROM dual;
  SELECT months_between(sysdate,'01-FEB-12') FROM dual;
  SELECT to_number('$17,000.23', '$99,999.99') FROM dual;
  SELECT NUMTOYMINTERVAL(27.5,'YEAR') FROM dual;
  SELECT NUMTOYMINTERVAL(27,'MONTH') FROM dual;
  CREATE TABLE mytest
    (one INTERVAL YEAR TO MONTH
    );
  INSERT INTO mytest VALUES
    ('27-3'
    );
  SELECT * FROM mytest;
  SELECT NUMTODSINTERVAL(1440,'SECOND') FROM dual;
  SELECT NUMTODSINTERVAL(12,'HOUR') FROM dual;
  SELECT NVL(shipdate,sysdate) FROM orders;
  SELECT * FROM scores;
  SELECT test_score,
    updated_test_score,
    NULLIF(test_score, updated_test_score) newscore
  FROM scores;
  SELECT state FROM customers;
  SELECT state,
    DECODE (state, 'CA', 'California', 'FL', 'Florida', 'WA', 'Washington' , 'Other')
  FROM customers;
  -- Type in 228
  SELECT add_months('31-JAN-11',1),
    add_months('01-NOV-11',4)
  FROM dual;
  -- Type in 229
  SELECT ROUND(months_between('12-JUN-14','03-OCT-13'),2) rnd
  FROM dual;
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
  -- Type in 236
  INSERT
  INTO calls
    (
      call_id,
      call_date_tz
    )
    VALUES
    (
      1,
      to_timestamp_tz('24-MAY-12 10:15:30', 'DD-MON-RR HH24:MI:SS')
    );
  CREATE TABLE calls
    (call_id NUMBER, call_date_tz TIMESTAMP WITH TIME ZONE
    );
  SELECT systimestamp FROM dual;
  SELECT sysdate, to_timestamp_tz(sysdate, 'DD-MON-RR HH24:MI:SS') FROM dual;
  SELECT * FROM calls;
  SELECT to_number('$17,000.23','$999,999.99') + 35000 FROM dual;
  SELECT to_number('$17:000,23','$999G999D99', 'nls_numeric_characters='',:''') + 55500
  FROM dual;
  SELECT LENGTH(TO_CHAR('hello  ')) FROM dual;
  SELECT TO_CHAR(198000,'$999,999.99') FROM dual;
  
  SELECT TO_CHAR(sysdate,'DAY, "THE" DD "OF" MON, RRRR') from dual;
  
  -- Type in 237
  SELECT to_number('17.000,23','999G999D99','nls_NUMBER_characters='',.'' ')
  FROM dual;
  -- Type in 241 middle
  SELECT TO_CHAR(SYSDATE,'Day, "the" Dd "of" Month, RRRR')
  FROM DUAL;
  -- Type in 241 bottom
  SELECT TO_CHAR(SYSDATE,'FMDay, "The" Ddth "of" Month, RRRR')
  FROM DUAL;
  
  
  SELECT TO_CHAR(SYSDATE,'RR:MM:DD HH24:MI:SS') FROM DUAL;
  
  SELECT TO_CHAR(sysdate, 'DD-Month-RRRR HH:MI:SS AM') FROM dual;
  SELECT order#, shipdate, orderdate FROM orders WHERE shipdate IS NULL;
  
  
  SELECT to_date('01.31.11','MM.DD.RR')+2 FROM dual;
  
  select to_date('12-OCT-16','RR-MON-DD') from dual;
  select to_date('12-OCT-16','RR MON DD') from dual;
  
 select * from orders;
 
 select * from orders
 where orderdate between to_date('01-APR-03','DD-MON-RR') and
                         to_date('02-APR-03','DD-MON-RR');
                         
 select * from orders
 where orderdate >= to_date('01-APR-03','DD-MON-RR') 
   and orderdate <= to_date('02-APR-03','DD-MON-RR');
  
select sysdate from dual;
SELECT CURRENT_TIMESTAMP FROM dual;
 
-- Type in 245 middle
SELECT TO_TIMESTAMP('2020-JAN-01 12:34:00:093423','RRRR-MON-DD HH:MI:SS:FF') + 1 EVENT_TIME
 FROM DUAL;
  
SELECT TO_TIMESTAMP('2020-JAN-01 12:34:00:093423','RRRR-MON-DD HH:MI:SS:FF') EVENT_TIME
  FROM DUAL;


  SELECT to_timestamp(sysdate) FROM dual;
  -- Page 248
  -- DROP TABLE timestamp_test;
  CREATE TABLE timestamp_test
    (
      dt               DATE,                          -- date & time (d&t)
      ts               TIMESTAMP,                     -- d&t (fractional seconds)
      ts_with_tz       TIMESTAMP WITH TIME ZONE,      -- d&t with tz
      ts_with_local_tz TIMESTAMP WITH LOCAL TIME ZONE -- d&t utc time (when queried gives local time)*/
    );
  
  SELECT DBTIMEZONE from dual;
  INSERT INTO timestamp_test VALUES
    (
      sysdate,
      CURRENT_TIMESTAMP,
      CURRENT_TIMESTAMP,
      CURRENT_TIMESTAMP
    );
INSERT INTO timestamp_test (dt) VALUES
    (to_date('16-OCT-12','DD-MON-RR' ));


select   dt, TO_CHAR(dt,'RR:MM:DD HH:MI:SS') from timestamp_test;
   
    
    
  SELECT * FROM timestamp_test;
  -- Type in 249 middle
 SELECT dbtimezone,
    sessiontimezone,
    CURRENT_TIMESTAMP
  FROM dual;
  
ALTER session SET time_zone = 'Europe/London';
ALTER session SET time_zone = 'America/Chicago';

SELECT tzabbrev,
    tzname
FROM v$timezone_names;
WHERE lower(TZNAME) LIKE '%london%';
  
-- Type in 250 middle
SELECT owner,
    table_name,
    column_name,
    data_type
FROM all_tab_columns
WHERE data_type LIKE '%TIME%'
 AND owner = 'CRUISES';
  
  SELECT * FROM dba_tab_columns;
  SELECT * FROM all_tab_columns;
  -- Type in 252 middle
  SELECT COUNT(*)
  FROM
    ( SELECT TZABBREV, TZNAME FROM V$TIMEZONE_NAMES ORDER BY TZABBREV, TZNAME
    );
  -- Type in 253
  SELECT dbtimezone FROM dual;
  -- Type in 254
  SELECT sessiontimezone FROM dual;
  SELECT sysdate, CURRENT_DATE,CURRENT_TIMESTAMP, localtimestamp FROM dual;
  -- Type in 255
  SELECT SYSTIMESTAMP FROM DUAL;
  -- Type in 257
SELECT from_tz(TIMESTAMP '2012-10-12 07:45:30', '+07:30')
FROM dual;
  
  -- Type in 258
SELECT to_timestamp_tz('17-04-2013 16:45:30','dd-mm-rrrr hh24:mi:ss') "time"
  FROM dual;

select localtimestamp(4) from dual;

select systimestamp from dual;  
  
  
SELECT to_timestamp_tz(sysdate,'dd-mm-rrrr hh24:mi:ss') "time" FROM dual;

SELECT CAST('19-JAN-10 11:35:30' AS TIMESTAMP WITH LOCAL TIME ZONE) converted
  FROM dual;
  
  SELECT sys_extract_utc(TIMESTAMP '2012-07-02 20:20:00 -06:00') HQ FROM dual;
--  SELECT TIMESTAMP FROM dual;
  SELECT TO_CHAR(sysdate,'HH:MI:SS') FROM dual;
  
SELECT sysdate FROM dual;

SELECT Extract(MINUTE FROM CURRENT_TIMESTAMP) minute FROM dual;

-- Type in 260
SELECT sys_extract_utc(CURRENT_TIMESTAMP) "hq" FROM dual;

SELECT CURRENT_TIMESTAMP dbtime FROM dual;

SELECT CURRENT_TIMESTAMP at TIME zone dbtimezone dbtime FROM dual;
SELECT CURRENT_TIMESTAMP at local dbtime FROM dual;
SELECT to_timestamp('2011-JUL-26 20:20:00', 'RR-MON-DD HH24:MI:SS') at TIME zone dbtimezone
  FROM dual;

  SELECT title, name FROM books b, publisher p WHERE b.pubid = p.pubid;
  SELECT title, name FROM books b JOIN publisher p ON b.pubid = p.pubid;
  SELECT title,
    name
  FROM books
  JOIN publisher USING (pubid)
  WHERE catcode LIKE 'C%';
  SELECT customer#,
    oi.order#,
    title,
    retail
  FROM orders o,
    orderitems oi,
    books b
  WHERE o.order# = oi.order#
  AND oi.isbn    = b.isbn ;
  SELECT customer#,
    oi.order#,
    SUM(retail)
  FROM orders o,
    orderitems oi,
    books b
  WHERE o.order# = oi.order#
  AND oi.isbn    = b.isbn
  GROUP BY customer#,
    oi.order# ;
  -- =============================================================================
  -- Chapter 7
  -- =============================================================================
 select * from orders;

  -- open books
ALTER TABLE books ADD catcode VARCHAR2(10);
desc books;


UPDATE books SET catcode = 'FAM' WHERE upper(category) = 'FAMILY LIFE';
UPDATE books SET catcode = 'BUS' WHERE upper(category) = 'BUSINESS';
UPDATE books SET catcode = 'FIT' WHERE upper(category) = 'FITNESS';
UPDATE books SET catcode = 'COO' WHERE upper(category) = 'COOKING';
UPDATE books SET catcode = 'COM' WHERE upper(category) = 'COMPUTER';
UPDATE books SET catcode = 'CHI' WHERE upper(category) = 'CHILDREN';
UPDATE books SET catcode = 'SEL' WHERE upper(category) = 'SELF HELP';
UPDATE books SET catcode = 'LIT' WHERE upper(category) = 'LITERATURE';

alter table books drop column category;
commit;
select * from books
 where catcode is null;

select count(*), count(catcode)
from books;

select * from books;

select catcode,count(*)
from books 
group by catcode
order by 1;

select * from books;

select catcode, avg(retail), max(retail), min(retail)
from books
where catcode = 'COM'
group by catcode;

select count(distinct lastname) 
from customers;

select count(all shipdate), count(shipdate), count(*) 
from orders;

select count(distinct lastname), count(lastname), count(all lastname)
from customers;

select c.firstname,c.lastname,o.order#, sum(oi.quantity * b.retail) total
from customers c,
     orders o,
     orderitems oi,
     books b
where c.customer# = o.customer#
  and o.order# = oi.order#
  and oi.isbn = b.isbn
group by c.firstname,c.lastname,o.order#
order by 3;

select c.firstname,c.lastname,o.order#, sum(oi.quantity * b.retail) total
from  customers c join orders o on  c.customer# = o.customer#
                join orderitems oi on o.order# = oi.order#
                  join books b on oi.isbn = b.isbn
group by c.firstname,c.lastname,o.order#
order by 3;

select firstname,lastname,order#, sum(quantity * retail) total
from  customers join orders using (customer#)
                join orderitems using (order#)
                join books using (isbn)
group by firstname,lastname,order#
order by 3;


select catcode, avg(cost)
from books
group by catcode;




select name, round(avg(cost),2)
from books join publisher using (pubid)
group by name;
                
                
                
                
                


  
  
  
  
  
  
  
  
  
  
  
  SELECT firstname,
    lastname,
    o.order#,
    retail
  FROM customers c,
    orders o,
    orderitems oi,
    books b
  WHERE c.customer# = o.customer#
  AND o.order#      = oi.order#
  AND oi.isbn       = b.isbn
  ORDER BY 3;
  SELECT firstname,
    lastname,
    order#,
    retail
  FROM customers
  JOIN orders USING (customer#)
  JOIN orderitems USING (order#)
  JOIN books USING (isbn)
  ORDER BY 3;
  SELECT firstname,
    lastname,
    COUNT(*),
    SUM(retail)
  FROM customers c
  JOIN orders o
  ON c.customer# = o.customer#
  JOIN orderitems oi
  ON o.order# = oi.order#
  JOIN books b
  ON oi.isbn = b.isbn
  GROUP BY firstname,
    lastname;
  SELECT firstname,
    lastname,
    order#
  FROM customers c
  JOIN orders o
  ON c.customer# = o.customer#
  JOIN orderitems oi
  ON o.order# = oi.order#
  JOIN books b
  ON oi.isbn     = b.isbn
  WHERE lastname = 'GIANA'
  AND firstname  = 'TAMMY';
  SELECT firstname,
    lastname,
    COUNT(*)
  FROM customers
  JOIN orders USING (customer#)
  GROUP BY firstname,
    lastname;
  HAVING lastname = 'GIANA';
  SELECT firstname,
    lastname,
    COUNT(*)
  FROM customers
  JOIN orders USING (customer#)
  WHERE lastname = 'GIANA'
  GROUP BY firstname,
    lastname;
  SELECT catcode, COUNT(*) FROM books GROUP BY catcode;
  SELECT catcode,
    MIN(retail),
    AVG(retail),
    MAX(retail),
    COUNT(*)
  FROM books
  GROUP BY catcode
  ORDER BY 1;
  SELECT catcode, AVG(retail) FROM books GROUP BY catcode ORDER BY 1;
  SELECT catcode, COUNT(*) FROM books GROUP BY catcode;
  -- insert lastname and firstname (yourself) into next available row in customers table
  SELECT *
  FROM cruises;
  SELECT COUNT(*) FROM Cruises;
  SELECT * FROM ship_cabins;
  SELECT DISTINCT room_style FROM ship_cabins;
  SELECT room_style,
    COUNT(*)
  FROM ship_cabins
  WHERE ship_id = 1
  GROUP BY room_style;
  
  
  SELECT room_style,
    COUNT(*)
  FROM ship_cabins
  GROUP BY room_style
  HAVING upper(room_style) = 'SUITE'
  OR upper(room_style)     = 'STATEROOM';
  SELECT * FROM vendors;
  SELECT COUNT(DISTINCT last_name),
    COUNT(ALL last_name),
    COUNT(*)
  FROM employees;
  SELECT * FROM vendors;
  SELECT COUNT(ALL status), COUNT(status), COUNT(*) FROM vendors;
  SELECT COUNT(orderdate), COUNT(shipdate) FROM orders;
  SELECT COUNT(ALL orderdate),
    COUNT(orderdate),
    COUNT(shipdate),
    COUNT(ALL shipdate)
  FROM orders;
  SELECT cost FROM books;
  SELECT catcode, COUNT(*), SUM(cost) FROM books GROUP BY catcode ORDER BY 1;
  SELECT catcode,
    COUNT(*),
    SUM(cost),
    ROUND(AVG(cost),2),
    MIN(cost),
    MAX(cost)
  FROM books
  GROUP BY catcode
  ORDER BY 1;
  SELECT ROUND(AVG(salary),2), median(salary) FROM pay_history;
  SELECT COUNT (DISTINCT room_style) FROM ship_cabins;
  
  
  select sq_ft
  from ship_cabins
  order by 1;
  
  select rank(300) within group(order by sq_ft)
  from ship_cabins;
  
  SELECT rank(225) within GROUP (ORDER BY sq_ft) FROM ship_cabins;
  SELECT sq_ft FROM ship_cabins ORDER BY sq_ft;
  
SELECT MIN(sq_ft) keep (dense_rank FIRST ORDER BY guests) Smallest,
         MAX(sq_ft) keep (dense_rank FIRST ORDER BY guests) Largest,
         AVG(sq_ft) keep (dense_rank FIRST ORDER BY guests) avgfirst
FROM ship_cabins;

select sq_ft, guests
from ship_cabins
order by guests, sq_ft;

SELECT AVg(sq_ft) keep (dense_rank last ORDER BY guests) Smallest
FROM ship_cabins;

select * from ships;
select * from ship_cabins;

select ship_name, ship_id, round(avg(sq_ft),2), min(guests), count(ship_cabin_id)
from ships join ship_cabins using (ship_id)
group by ship_name, ship_id;

select ship_id,round(avg(sq_ft),2), min(guests), count(ship_cabin_id)
from ship_cabins
group by ship_id;


-- room_style, avg(sq_ft), min(sq_ft), max(sq_ft), count
-- listed by room_style


select room_style, room_type, round(avg(sq_ft)), min(sq_ft), max(sq_ft), count(*)
from ship_cabins
group by room_style, room_type
order by 1,2;

select room_style, max(sq_ft)
from ship_cabins
group by room_style;

select round(avg(max(sq_ft)))
from ship_cabins
group by room_style;

select room_style, room_type, to_char(min(sq_ft),'9,999') minsqft
from ship_cabins
where ship_id = 1
group by room_style, room_type
having room_type in ('Standard','Large')
   or  min(sq_ft) > 1200
order by 3;




  SELECT guests, sq_ft FROM ship_cabins ORDER BY guests DESC, sq_ft DESC;
  SELECT sq_ft FROM ship_cabins ORDER BY sq_ft;
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
  SELECT room_type, ROUND(AVG(sq_ft),2) FROM ship_cabins GROUP BY room_type;
  SELECT room_style ,
    ROUND(AVG(sq_ft),2) "avg sq ft" ,
    MIN (guests) "minimum of guests" ,
    COUNT (ship_cabin_id) "total number of cabins"
  FROM ship_cabins
  GROUP BY room_style;
  SELECT * FROM ship_cabins;
  SELECT room_type ,
    TO_CHAR(ROUND(AVG(sq_ft),2),'999,999.99') "avg sq ft" ,
    MIN (guests) "minimum of guests" ,
    COUNT (ship_cabin_id) "total number of cabins"
  FROM ship_cabins
  GROUP BY room_type
  ORDER BY MIN(room_style);
  SELECT COUNT(room_style),
    MAX(room_type),
    AVG(MAX(sq_ft))
  FROM ship_cabins
  GROUP BY room_type,
    room_style;
  SELECT room_style,
    room_type,
    TO_CHAR(MIN(sq_ft),'9,999')
  FROM ship_cabins
  WHERE room_type IN ('Standard','Large')
  GROUP BY room_style,
    room_type
  ORDER BY 3;
  SELECT TO_CHAR(order_date, 'Q'),
    COUNT(*)
  FROM cruise_orders
  WHERE TO_CHAR(order_date, 'YYYY') = '2011'
  GROUP BY TO_CHAR(order_date, 'Q');
  SELECT order_dATE, TO_CHAR(order_date, 'Q') FROM cruise_orders;
  SELECT COUNT(COUNT(project_cost)) FROM projects GROUP BY purpose;
  SELECT ship_id,
    MAX(days)
  FROM projects
  GROUP BY ship_id
  HAVING AVG(project_cost) < 50000;
  SELECT purpose,
    AVG(project_cost)
  FROM projects
  WHERE days > 3
  GROUP BY purpose;
  SELECT * FROM cruise_orders;
  SELECT upper (room_type) FROM ship_cabins ORDER BY ship_id;
  SELECT median(cost) FROM books;
  SELECT rank(20) within GROUP (ORDER BY retail) FROM books;
  SELECT * FROM books;
  -- cruises
  -- page 284
  SELECT MAX(sq_ft) keep (dense_rank FIRST
  ORDER BY guests)
  FROM ship_cabins;
  SELECT sq_ft, guests FROM ship_cabins ORDER BY guests, sq_ft;
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
  SELECT room_style ROUND(AVG(sq_ft), 2) FROM ship_cabins GROUP BY room_style;
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
  OR MIN(SQ_FT)     > 1200
  ORDER BY 3;
  SELECT ROOM_STYLE,
    ROOM_TYPE,
    TO_CHAR(MIN(SQ_FT),'9,999') "Min"
  FROM SHIP_CABINS
  WHERE SHIP_ID = 1
  GROUP BY ROOM_STYLE,
    ROOM_TYPE
  HAVING MIN(guests) >5
  OR AVG(SQ_FT)      > 1200
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
  GROUP BY room_style,
    room_type;
  SELECT AVG(MAX(sq_ft))
  FROM ship_cabins
  WHERE ship_id = 1
  GROUP BY room_style,
    room_type
  ORDER BY MAX(sq_ft);
  SELECT COUNT(COUNT(project_cost)) FROM projects GROUP BY purpose;
  SELECT purpose,
    AVG(project_cost)
  FROM projects
  WHERE days > 3
  GROUP BY purpose;
  HAVING days > 3;
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
  SELECT room_style,
    room_type,
    MIN(sq_ft)
  FROM ship_cabins
  WHERE ship_id =1
  GROUP BY room_style,
    room_type
  HAVING room_type IN ('Standard','Large')
    -- or min(sq_ft) > 1200
  ORDER BY 3;
  
  select round(sq_ft),avg(sq_ft)
  from ship_cabins;
  
  select round(avg(sq_ft))
  from ship_cabins;
  
  
  create table test_agg
  (num integer);
  
  insert into test_agg values (2);
  insert into test_agg values (4);
  insert into test_agg values (null);
  
  select median(num) from test_agg;
  
  
  -- =============================================================================
  -- Chapter 8
  -- =============================================================================
  CREATE TABLE clients
    (
      client# INTEGER PRIMARY KEY,
      lname   VARCHAR2 (20)
    );
  CREATE TABLE orders
    ( order# INTEGER PRIMARY KEY, client# INTEGER
    );
  INSERT INTO clients VALUES
    (100, 'SMITH'
    );
  INSERT INTO clients VALUES
    (200, 'BELL'
    );
  INSERT INTO clients VALUES
    (300, 'JONES'
    );
  INSERT INTO orders VALUES
    (9,NULL
    );
  INSERT INTO orders VALUES
    (22,200
    );
  SELECT * FROM clients, orders ORDER BY 1, 3;
  SELECT * FROM clients c FULL JOIN orders o ON c.client# = o.client#;
  -- select all customer first and last name order#
  -- with or without orders showing
  -- orders if they have them.
  SELECT firstname,
    lastname,
    order#
  FROM customers c
  LEFT JOIN orders o
  ON c.customer# = o.customer#
  WHERE order#  IS NULL;
  SELECT c1.firstname,
    c1.lastname,
    c1.customer#,
    c2.firstname,
    c2.lastname,
    c1.referred
  FROM customers c1,
    customers c2
  WHERE c1.referred = C2.customer#;
  SELECT * FROM customers WHERE firstname = 'LEILA';
  SELECT a.position_id,
    a.position,
    b.position AS "boss"
  FROM positions a
  LEFT JOIN positions b
  ON a.reports_to = b.position_id
  ORDER BY "boss";
  SELECT * FROM employees;
  SELECT * FROM addresses;
  SELECT employee_id,
    first_name,
    last_name,
    street_address
  FROM employees NATURAL
  JOIN addresses;
  -- page 317 top
  SELECT ship_id,
    ship_name,
    port_name
  FROM ships
  INNER JOIN ports
  ON home_port_id = port_id
  ORDER BY ship_id;
  SELECT ship_id,
    ship_name,
    port_name
  FROM ships,
    ports
  WHERE home_port_id = port_id
  ORDER BY ship_id;
  SELECT p.port_name,
    s.ship_name,
    sc.room_number
  FROM ports p
  JOIN ships s
  ON p.port_id = s.home_port_id
  JOIN ship_cabins sc USING (ship_id);
  -- equijoins
  -- old style
  SELECT c.firstname,
    c.lastname,
    b.catcode,
    b.title
  FROM customers c,
    orders o,
    orderitems oi,
    books b
  WHERE c.customer# = o.customer#
  AND o.order#      = oi.order#
  AND oi.isbn       = b.isbn
  AND catcode       = 'COM';
  -- new style (on)
  SELECT firstname,
    lastname,
    catcode,
    title
  FROM customers c
  JOIN orders o
  ON c.customer# = o.customer#
  JOIN orderitems oi
  ON o.order# = oi.order#
  JOIN books b
  ON oi.isbn    = b.isbn
  WHERE catcode = 'COM';
  -- new style (using)
  SELECT firstname,
    lastname,
    catcode,
    title
  FROM customers
  JOIN orders USING(customer#)
  JOIN orderitems USING (order#)
  JOIN books USING(isbn)
  WHERE catcode = 'COM';
  -- new styles combination
  SELECT firstname,
    lastname,
    catcode,
    title
  FROM customers c NATURAL
  JOIN orders o
  JOIN orderitems oi USING (order#)
  JOIN books b
  ON oi.isbn    = b.isbn
  WHERE catcode = 'COM';
  ;
  -- nonequijoin
  SELECT s.score_id,
    s.test_score,
    g.grade
  FROM scores s
  JOIN grading g
  ON s.test_score BETWEEN g.score_min AND g.score_max;
  SELECT title,
    gift
  FROM books b,
    promotion p
  WHERE b.retail > p.minretail
  AND b.retail   < p.maxRetail;
  SELECT title,
    gift
  FROM books
  JOIN promotion
  ON b.retail BETWEEN minretail AND maxRetail;
  SELECT * FROM employees;
  SELECT * FROM addresses;
  SELECT employee_id,
    last_name,
    street_address
  FROM employees NATURAL
  JOIN addresses;
  -- outer join
  DROP TABLE books.employee;
  CREATE TABLE books.employee
    (emp_name VARCHAR2(13), dept_idnumber
    );
  DROP TABLE books.department;
  CREATE TABLE books.department
    (dept_idnumber, dept_namevarchar2(13)
    );
  BEGIN
    INSERT INTO employee VALUES
      ('Rafferty', 31
      );
    INSERT INTO employee VALUES
      ('Jones', 33
      );
    INSERT INTO employee VALUES
      ('Steinberg', 33
      );
    INSERT INTO employee VALUES
      ('Robinson', 34
      );
    INSERT INTO employee VALUES
      ('Smith', 34
      );
    INSERT INTO employee VALUES
      ('Johnson', NULL
      );
  END;
  /
  BEGIN
    INSERT INTO department VALUES
      ( 31, 'Sales'
      );
    INSERT INTO department VALUES
      ( 33, 'Engineering'
      );
    INSERT INTO department VALUES
      ( 34, 'Clerical'
      );
    INSERT INTO department VALUES
      ( 35, 'Marketing'
      );
  END;
  /
  SELECT * FROM employee;
  SELECT * FROM department;
  SELECT * FROM employee JOIN department USING (dept_id);
  SELECT * FROM employee LEFT OUTER JOIN department USING (dept_id);
  SELECT * FROM employee RIGHT OUTER JOIN department USING (dept_id);
  SELECT * FROM employee FULL OUTER JOIN department USING (dept_id);
  SELECT * FROM departmentleft OUTER joinemployee USING (dept_id);
  SELECT * FROM departmentright OUTER JOIN employee USING (dept_id);
  SELECT * FROM departmentfull OUTER joinemployee USING (dept_id);
  SELECT * FROM employee e, department d WHERE e.dept_id = d.dept_id(+);
  SELECT * FROM department RIGHT OUTER JOIN employee USING (dept_id);
  SELECT * FROM department LEFT OUTER JOIN employee USING (dept_id);
  SELECT * FROM employee RIGHT OUTER JOIN department USING (dept_id);
  SELECT * FROM employee FULL OUTER JOIN department USING (dept_id);
  SELECT * FROM customers;
   
  
  SELECT c2.firstname cfn,c2.lastname cln,c1.firstname rfn, c1.lastname rln
  FROM customers c1,
       customers c2
  WHERE c1.customer#=c2.referred;
  
  
  SELECT c2.firstname cfn,c2.lastname cln,c1.firstname rfn, c1.lastname rln
    FROM customers c1 join customers c2
                       on c1.customer#=c2.referred;
   
  select customer#,firstname,lastname,referred
  from customers;
  
   
  
  select *
  from customers natural join orders;
  
  
  select * from customers natural join books;
  
  select * from vendors;
  
  select * from online_subscribers;
  
  select * from vendors cross join online_subscribers;
  
  SELECT * FROM employee CROSS JOIN department;
  SELECT * FROM employee,department;
  SELECT * FROM ports;
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
  AND port_name      ='Charleston'
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
  -- 1. List employee's ID and first and last names, address, city, state,
  -- zip with new join syntax and keyword "ON"
  -- Use table aliases for all returned columns where possible
  -- from the cruises schema
  
  
  
  SELECT e.employee_id, e.first_name, e.last_name
  FROM employees e;
   
  SELECT a.employee_id,a.street_address, a.city, a.state, a.zip
  FROM addresses a;
  
  
  SELECT e.employee_id,e.first_name, e.last_name,a.street_address, a.city,a.state, a.zip
  FROM employees e JOIN addresses a 
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
  
  
  
  -- 3. List cruise name and captains ID,
  --    captains name address, city, state,zip 
  --    with new join syntax and keyword "ON"
  --    from cruises
  
  SELECT c.cruise_name, e.employee_id,e.first_name,e.last_name, a.street_address, a.city, a.state,a.zip
  FROM employees e JOIN addresses a
                    ON e.employee_id = a.employee_id
                   JOIN cruises c
                    ON e.employee_id = c.captain_id;
  
select * from employees;
select * from cruises;
  
insert into cruises values(2,1,'Sunset',1,4,'04-OCT-12','04-OCT-12','SEA');
    
                    
-- 4. Repeat question 3 using keyword "USING"
SELECT employee_id, e.first_name, e.last_name, a.street_address, a.city, a.state, a.zip
  FROM employees e JOIN cruises c
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
  WHERE cruise_id  = 2;
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
  ON s.ship_id    = pj.ship_id
  WHERE port_name = 'Baltimore'
  GROUP BY port_name,
    project_cost,
    days;
  SELECT port_name,
    TO_CHAR(SUM(project_cost),'$999,999,999') total,
    TO_CHAR(AVG(project_cost),'$999,999') AVG,
    COUNT(   *) NumberProjects,
    SUM(days)*40 ManHours
  FROM ports p ,
    ships s ,
    projects pj
  WHERE p.port_id = s.home_port_id
  AND s.ship_id   = pj.ship_id
  AND port_name   = 'Baltimore'
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
  RIGHT JOIN customers c2
  ON C1.CUSTOMER# = C2.REFERRED;
  -- =============================================================================
  -- Chapter 9
  -- =============================================================================
  -- page 350 top
  select * from employees;
  
  
  SELECT ship_id
  FROM employees
  WHERE last_name = 'Lindon'
  AND first_name  = 'Alice';
  -- page 350 bottom
  SELECT employee_id,
    last_name,
    first_name
  FROM employees
  WHERE ship_id      = 3
  AND NOT (last_name = 'Lindon'
  AND first_name     = 'Alice');

-- page 351 top
SELECT employee_id, last_name, first_name
FROM employees
  WHERE ship_id =
                ( SELECT ship_id
                   FROM employees
                   WHERE last_name = 'Lindon'
                     AND first_name  = 'Alice'
                )
  AND NOT last_name = 'Lindon';
  
select * 
from emp_benefits;

select count(*)
from books;
  
  -- page 351 bottom
SELECT employee_id,last_name,first_name
  FROM employees
  WHERE ship_id IN
                  ( 
                   SELECT ship_id FROM employees WHERE last_name = 'Smith'
                  );
                  
  --AND NOT last_name = 'Smith';
  
  
  SELECT employee_id,last_name,first_name, ship_id
  FROM employees
  WHERE ship_id > ANY
                  ( 
                    SELECT ship_id FROM employees WHERE last_name = 'Smith'
                  )
  AND NOT last_name = 'Smith';
  
  select * from employees;
  
  
  
  SELECT * FROM employees;
  SELECT * FROM cruise_customers;
  
  select * from cruise_customers;
  
INSERT INTO cruise_customers VALUES (4,'Alice','Lindon');
commit;
  
  COMMIT;
  
-- page 353
SELECT employee_id, last_name,first_name, ssn
FROM employees
WHERE ship_id IN
                ( SELECT ship_id FROM employees WHERE last_name = 'Smith'
                ) ;
  
  
  
  
  
 -- page 354 (same as page 353 with in operator)
  SELECT ship_id,
    last_name,
    first_name
  FROM employees
  WHERE ship_id IN ( SELECT ship_id FROM employees WHERE last_name = 'Smith' );
    
    
    
  SELECT invoice_id
  FROM invoices
  WHERE (first_name, last_name ) IN ( SELECT first_name, last_name FROM cruise_customers ) ;
  
  select * from invoices;
  select * from cruise_customers;

  SELECT *
  FROM employees
  WHERE (first_name, last_name ) IN ( SELECT first_name, last_name FROM cruise_customers ) ;

select * from pay_history;
select * from invoices;


select vendor_name, 
      (select terms_of_discount from invoices where invoice_id = 1) as discount
from vendors
order by vendor_name;





select * from ship_cabins;


select a.ship_cabin_id, a.room_style,a.room_number, a.sq_ft
from ship_cabins a
where a.sq_ft > 
              (
                  select avg(sq_ft)
                  from ship_cabins
                  where room_style = a.room_style
                )
order by a.room_number;



select avg(sq_ft)
from ship_cabins
where room_style = 'Suite';


  
  -- empty set
  -- page 356
  SELECT employee_id, first_name, last_name
  FROM employees
  WHERE (first_name, last_name ) IN
    ( SELECT first_name, last_name FROM cruise_customers
    )
  AND ship_id = 3;
  
  SELECT * FROM cruise_customers;
  
  INSERT INTO criuses_customers VALUES (10, 'Buffy', 'Worthington' );
  SELECT vendor_name,
    (SELECT terms_of_discount FROM invoices i WHERE invoice_id = 1
    ) discount
  FROM vendors v;
  
  SELECT * FROM vendors;
  SELECT * FROM invoices;
  SELECT room_style, AVG(sq_ft) FROM ship_cabins GROUP BY room_style;
  
  
  
SELECT *
  FROM projects
  WHERE project_cost <= ANY
                        ( SELECT project_cost FROM projects WHERE purpose = 'Maintenance'
                        order by 1 desc
                        )
and purpose = 'Upgrade';
  
select * from projects order by project_cost;
  
  
  
  SELECT project_cost, purpose
  FROM projects
  WHERE project_cost >= ALL
                    (SELECT project_cost FROM projects WHERE purpose = 'Upgrade'
                    );
  
select * from projects;

SELECT project_cost, purpose FROM projects WHERE purpose = 'Upgrade';
  -- page 357
  SELECT * FROM invoices;
  SELECT * FROM pay_history;
  UPDATE invoices SET invoice_date = '04-JUN-01',total_price    =37450
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
  
  INSERT INTO employees (employee_id,ship_id)
    VALUES(seq_employee_id.nextval,
      (SELECT ship_id FROM ships WHERE ship_name = 'Codd Champion'
      )
    );
    
    
    
  ROLLBACK;
  
  -- page 361 top
  SELECT a.ship_cabin_id,a.room_style,a.room_number,a.sq_ft
  FROM ship_cabins a
  WHERE a.sq_ft >
                  (SELECT AVG(sq_ft) FROM ship_cabins WHERE room_style = a.room_style
                  )
  ORDER BY 2;
  
  select * from ship_cabins;
  
  
  
  SELECT * FROM books;
  
  SELECT *
  FROM books b
  WHERE retail >= 
    (SELECT AVG(retail) FROM books WHERE catcode = b.catcode    )
  ORDER BY isbn;
  
  
  
  
  UPDATE books b SET retail = retail *1.1
  WHERE retail <=
                  (SELECT AVG(retail) FROM books WHERE catcode = b.catcode
                  );
    
    select * from books;
    
    
    
    
    
  SELECT * FROM books ORDER BY isbn;
  -- page 361 bottom
  SELECT room_style,
    AVG(sq_ft)
  FROM ship_cabins
  GROUP BY room_style;
 -- page 363
UPDATE invoices inv
SET terms_of_discount = '10 pct'
WHERE total_price =
                    ( SELECT MAX(total_price)
                      FROM invoices
                      WHERE TO_CHAR(invoice_date, 'RRRR-Q') = TO_CHAR(inv.invoice_date, 'RRRR-Q')
                    );

    
  ROLLBACK;
  
  
  -- page 364
  UPDATE ports p
  SET capacity = (
                    SELECT COUNT(*) FROM ships WHERE home_port_id = p.port_id
                  )
  WHERE EXISTS
              ( 
                    SELECT * FROM ships WHERE home_port_id = p.port_id
              );
              
              
  select * from ports;
  select * from ships;
  
  -- page 365 top
  SELECT *
  FROM ship_cabins s1
  WHERE s1.balcony_sq_ft =
    (SELECT MIN(balcony_sq_ft)
    FROM ship_cabins s2
    WHERE s1.room_type = s2.room_type
    AND s1.room_style  = s2.room_style
    );
  ROLLBACK;
  SELECT *
  FROM books b1
  WHERE cost <
    (SELECT AVG(cost) FROM books b2 WHERE b1.catcode = b2.catcode
    );
  SELECT firstname,
    lastname,
    title,
    retail
  FROM customers c
  JOIN orders USING (customer#)
  JOIN orderitems USING (order#)
  JOIN books USING (isbn)
  WHERE retail =
    (SELECT MIN(retail) FROM books
    );
    
    
    
    
    
WITH PORT_BOOKINGS AS
  (SELECT P.PORT_ID,P.PORT_NAME, COUNT(S.SHIP_ID) CT
  FROM PORTS P, SHIPS S
  WHERE P.PORT_ID = S.HOME_PORT_ID
  GROUP BY P.PORT_ID,
    P.PORT_NAME
  ),
  densest_port AS
  ( SELECT MAX(CT) MAX_CT FROM PORT_BOOKINGS
  )
SELECT PORT_NAME
FROM PORT_BOOKINGS
WHERE CT =
  (SELECT MAX_CT FROM DENSEST_PORT
  );
-- page 365 bottom
SELECT port_id,
  port_name
FROM ports p1
WHERE EXISTS
  (SELECT * FROM ships s1 WHERE p1.port_id = s1.home_port_id
  );
-- page 366
WITH 
  port_bookings AS
      (
      SELECT p.port_id, p.port_name,COUNT(s.ship_id) ct
        FROM ports p,ships s
       WHERE p.port_id = s.home_port_id
       GROUP BY p.port_id,p.port_name
      ),
  densest_port AS
     ( 
       SELECT MAX(ct) max_ct FROM port_bookings
     )
SELECT port_name
FROM port_bookings
WHERE ct = (SELECT max_ct FROM densest_port);

select * from port_bookings;


create table mytesttable as
select firstname, lastname from customers;

  
-- -----------------------------------------------------------------------------
-- HANDS ON EXERCISES CHAPTER 9
-- ----------------------------------------------------------------------------
-- 7-1 Return the title, retail
-- for all books where retail < avg retail of all books
select title, retail
from books
where retail < ( select avg(retail) from books);

-- 7-2 Determine the books title, retail, catcode
-- that are < avg retail
-- of books in the same category

select title, retail, catcode
from books bo
where retail <
              (
                select avg(retail)
                from books
                where catcode = bo.catcode
              );
              
-- 7-3 Return firstname, lastname, order#
-- of those orders where the
-- shipped to state is the same as Order 1014
select firstname, lastname, order#
from customers join orders using (customer#)
where shipstate =
                  (
                   select shipstate
                   from orders
                   where order# = '1014'
                  );
                  
-- 7.4 return the order# of those orders
-- with a total > order 1008
-- step 1: the inner query
         (
          select sum(quantity*retail)
          from orderitems oi join books b using (isbn)
          where order# = '1008'
         ) ; 
-- step 2 
-- write a sql query that gives a total for each order
-- return the order# and the total order value
select order#, sum(quantity*retail)
from orderitems oi join books b using (isbn)
group by order#;

-- step 3 put them together
select order#, sum(quantity*retail)
from orderitems oi join books b using (isbn)
group by order#
having sum(quantity*retail) > 
                              (
                                select sum(quantity*retail)
                                from orderitems oi join books b using (isbn)
                                where order# = '1008'
                               ) ; 

-- 7.5a return  first and last name of author(s)
-- who wrote the most frequently purchased book
-- step 1 
select max(sum(quantity))
from orderitems
group by isbn;

select fname, lname, isbn, title, sum(quantity)
from orderitems join books using (isbn)
                join bookauthor using (isbn)
                join author using (authorid)
having sum(quantity) = 
                        (
                          select min(sum(quantity))
                          from orderitems
                          group by isbn
                          )
group by fname, lname, isbn, title
order by 5 desc;


-- 7.5b return first last name of customer who purchased
--      the most books
select firstname, lastname, sum(quantity)
from customers join orders using (customer#)
               join orderitems using (order#)
having sum(quantity) =
                  (
                    select max(sum(quantity))
                    from orders join orderitems using (order#)
                    group by customer#
                   )
group by firstname, lastname, customer#;

-- 3. Return all columns from ports that has a capacity > avg capacity for all ports
SELECT *
FROM ports
WHERE capacity >
              ( 
                SELECT AVG(capacity) FROM ports
              );
-- 2. What is the name of Joe Smith's captain on cruise_id = 1?
-- Return the ship_id, cruise_id, the captains first and last name
SELECT * FROM cruises;
-- captain_id = 3
SELECT * FROM employees;
-- mike west (emp_id 3) and al smith (emp_id 5) both have 4 (ship_id)
SELECT e.ship_id, c.cruise_id, c.captain_id, e.first_name, e.last_name
FROM cruises c JOIN employees e
                ON c.captain_id = e.employee_id
WHERE e.ship_id =
                  (SELECT ship_id
                  FROM employees
                  WHERE first_name = 'Joe'
                  AND last_name    = 'Smith'
                  )
AND cruise_id = 1;

select * from cruises;
select * from employees;


-- 3. Return all columns from ship cabins that has bigger than the avg
--size balcony for the same room type and room style
SELECT *
FROM ship_cabins s
WHERE balcony_sq_ft >
  (SELECT AVG(balcony_sq_ft)
  FROM ship_cabins
  WHERE s.room_type = room_type
  AND s.room_style  = room_style
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
  AND s1.room_style  = s2.room_style
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
WHERE ABS(start_date         - end_date) =
  (SELECT MAX(ABS(start_date - end_date))
  FROM work_history
  WHERE ship_id = w1.ship_id
  );
SELECT employee_id,
  ship_id
FROM work_history w1
WHERE ABS(start_date     - end_date) >= ALL
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
ON sh.home_port_id                    = pt.port_id
WHERE (sh.home_port_id, sh.capacity) IN
  ( SELECT home_port_id, MAX(capacity) FROM ships GROUP BY home_port_id
  );
-- ----------------------------------------------------------------------------
SELECT s1.ship_name,
  port_name
FROM ports p
JOIN ships s1
ON p.port_id      = s1.home_port_id
WHERE s1.capacity =
  ( SELECT MAX(capacity) FROM ships s2 WHERE s2.home_port_id = s1.home_port_id
  );
SELECT * FROM ships;
SELECT home_port_id, MAX(capacity) FROM ships s2 GROUP BY home_port_id;
-- -----------------------------------------------------------------------------
-- DO HAND ON EXERCISES Chapter 7 (slides) handouts at home for Saturday
-- -----------------------------------------------------------------------------
-- 7-1
-- Books with retail < average retail for all books
SELECT title,Retail
FROM Books
WHERE Retail >=
              (
                SELECT AVG(Retail) FROM Books
              );
SELECT title,Retail
FROM Books
WHERE Retail >= ALL
  ( SELECT AVG(Retail) FROM Books GROUP BY category
  );
-- -----------------------------------------------------------------------------
-- 7-2
-- Books that cost < than other books in same category
-- lowest or cheapest retail value in each category
SELECT title,b1.category, b1.retail
FROM books b1,
    (SELECT category, MIN(retail) myretail FROM books GROUP BY category
     ) b2
WHERE b1.retail = b2.myretail
AND b1.category = b2.category;

SELECT title, category, retail
FROM books b1
WHERE b1.retail <=
                (
                  SELECT MIN(retail) FROM books b2 WHERE b1.category = b2.category
                );
SELECT * FROM invoices;
SELECT port_id,port_name FROM ports p1
WHERE EXISTS
            ( SELECT * FROM ships s1 WHERE p1.port_id = s1.home_port_id
            );
CREATE TABLE mytest AS (SELECT * FROM ships s1);
SELECT * FROM mytest;
CREATE TABLE mytest2 AS (SELECT ship_name FROM ships );
SELECT * FROM mytest2;

SELECT title, b1.catcode,cost,Avgcost
FROM books b1 ,
  ( SELECT catcode, AVG(Cost) Avgcost FROM Books GROUP BY catcode
  ) b2
WHERE b1.catcode = b2.catcode
  AND b1.cost      < b2.avgcost;
  
SELECT title, cost FROM books WHERE catcode = 'COM';
-- -----------------------------------------------------------------------------
-- 7-3
-- Orders shippd to same state as order 1014
SELECT order#, shipstate
FROM orders
WHERE shipstate IN
                (
                  SELECT shipstate FROM orders WHERE order# = 1014
                );

SELECT order#, shipstate
FROM orders
WHERE (order#, shipstate) IN
                            (
                              SELECT order#, shipstate FROM orders WHERE order# = 1014
                            );
SELECT order#, shipstate
FROM orders
WHERE shipstate =
                    ( SELECT shipstate FROM orders WHERE order# = 1014
                    );
-- -----------------------------------------------------------------------------
-- 7-4
-- Orders with total amount > order 1008
SELECT order#, SUM(quantity*retail)
FROM orderitems oi,
     books b
WHERE oi.isbn = b.isbn
GROUP BY order#
HAVING SUM(quantity *retail) >
              (
                SELECT SUM(quantity*retail)
                FROM orderitems oi,
                     books b
                 WHERE oi.isbn = b.isbn
                 AND order#    = 1008
                GROUP BY order#
              );

SELECT oi.order#, SUM(retail*quantity) total2
FROM orderitems oi ,
  books b1
WHERE oi.isbn = b1.isbn
GROUP BY oi.order#
HAVING SUM(retail*quantity) >
                (SELECT SUM(retail*quantity) total1
                  FROM orderitems oi ,
                       books b
                  WHERE oi.isbn = b.isbn
                    AND order#    = 1008
                    -- group by order#
                );
SELECT oi.order#, SUM(retail*quantity) total2
FROM orderitems oi
JOIN books b1 USING (isbn)
GROUP BY oi.order#
HAVING SUM(retail *quantity) >
                  (
                    SELECT SUM(retail*quantity) total1
                    FROM orderitems oi
                    JOIN books b USING (isbn)
                    WHERE order# = 1008
                  );
-- -----------------------------------------------------------------------------
-- 7-5
-- Which author(s) wrote most frequently purchased book
-- find the title most frequently purchased
-- then bring back the authors
SELECT title,lname,fname,SUM(quantity) myqty
FROM orderitems JOIN books USING (isbn)
                JOIN bookauthor USING(isbn)
                JOIN author USING (authorid)
GROUP BY title, lname, fname
HAVING SUM(quantity) =
                      (
                        SELECT MAX(SUM(quantity)) qty FROM orderitems GROUP BY isbn
                      );

SELECT title,isbn,lname,fname,SUM(quantity) qty
FROM orderitems JOIN books USING (isbn)
                JOIN bookauthor USING (isbn)
                JOIN author USING (authorid)
GROUP BY title,isbn,lname,fname
HAVING SUM(quantity) =
                    ( 
                      SELECT MAX(SUM(quantity)) qty FROM orderitems GROUP BY isbn
                    );
SELECT title,isbn,lname,fname,SUM(quantity) qty
FROM orderitems JOIN books USING (isbn)
                JOIN bookauthor USING(isbn)
                JOIN author USING(authorid)
GROUP BY title,isbn,lname,fname
HAVING SUM(quantity) =
                      (
                        SELECT MAX(SUM(quantity)) qty FROM orderitems GROUP BY isbn
                      );
SELECT title, isbn, lname, fname, SUM(quantity) qty
FROM orderitems oi  JOIN books b USING (isbn)
                    JOIN bookauthor ba USING (isbn)
                    JOIN author a USING(authorid)
GROUP BY title,isbn,lname,fname
HAVING SUM(quantity) =
                      (
                        SELECT MAX(SUM(quantity)) qty FROM orderitems GROUP BY isbn
                      );
-- test count
SELECT b.title,b.isbn, SUM(quantity) qty
FROM orderitems oi ,
  books b
WHERE oi.isbn = b.isbn
GROUP BY b.title,b.isbn;
-- test author
SELECT title,lname,fname
FROM books b ,
  bookauthor ba ,
  author a
WHERE b.isbn    = ba.isbn
AND ba.authorid = a.authorid
AND b.isbn LIKE '%490';
-- -----------------------------------------------------------------------------
-- 7-6
-- All titles in same cat customer 1007 purchased. 
-- Do not include titles purchased by customer 1007.
SELECT distinct title, catcode
FROM books  JOIN orderitems USING(isbn)
            JOIN orders USING (order#)
WHERE catcode IN
                (
                  SELECT distinct catcode
                  FROM orders JOIN orderitems USING (order#)
                              JOIN books USING (isbn)
                  WHERE customer# = 1007
                )
AND customer# <> 1007 ;

SELECT distinct title, catcode
FROM books  JOIN orderitems USING(isbn)
            JOIN orders USING (order#)
WHERE catcode IN
                (
                  SELECT distinct catcode
                  FROM orders JOIN orderitems USING (order#)
                              JOIN books USING (isbn)
                  WHERE customer# = 1007
                )
AND title not in 
                (select title
                 from orders join orderitems using (order#)
                             join books using (isbn)
                 where customer# = 1007
                 );




SELECT DISTINCT title
FROM orders JOIN orderitems USING(order#)
            JOIN books USING(isbn)
WHERE CATCODE IN ('FAL', 'COM', 'CHN')
AND customer# <> 1007;

SELECT DISTINCT (b.title)
FROM books b ,
  (
      SELECT title,
        catcode
      FROM orders o ,
        orderitems oi ,
        books b
      WHERE o.order# = oi.order#
      AND oi.isbn    = b.isbn
      AND customer#  = 1007
  ) b1
WHERE b.catcode = b1.catcode;
AND b.title    <> b1.title;
-- everything purchased by customer 1007
SELECT title, catcode
FROM orders o ,
  orderitems oi ,
  books b
WHERE o.order# = oi.order#
AND oi.isbn    = b.isbn
AND customer#  = 1007;
-- -----------------------------------------------------------------------------
-- 7-7
-- Customer# with city and state that had longest shipping delay
SELECT customer#,city,state,shipdate-orderdate
FROM customers JOIN orders USING (customer#)
WHERE shipdate-orderdate =
                          (
                            SELECT max(shipdate-orderdate) 
                             FROM orders WHERE shipdate IS NOT NULL
                          );
                          
                          
                          
                          
SELECT customer#, city, state, shipdate, orderdate, shipdate - orderdate delay
FROM orders
JOIN customers USING (customer#)
WHERE (shipdate - orderdate) =
                              (
                                SELECT MAX(shipdate - orderdate) delay FROM orders
                              );
SELECT CUSTOMER#,CITY,STATE,SHIPDATE,ORDERDATE,SHIPDATE - ORDERDATE delay
FROM ORDERS JOIN CUSTOMERS USING (CUSTOMER#)
WHERE (SHIPDATE - ORDERDATE) =
                            (
                              SELECT MAX(SHIPDATE - ORDERDATE) delay FROM ORDERS
                            );
SELECT MAX(SHIPDATE-ORDERDATE) FROM orders;
SELECT * FROM CRUISE_ORDERS;
DESC CRUISE_ORDERS;
ALTER TABLE CRUISE_ORDERS
DROP column FIST_TIME_CUSTOMER;
DESC CRUISE_ORDERS;
ROLLBACK;
-- -----------------------------------------------------------------------------
-- 7-8
-- Who purchased least expensive book(s)
SELECT customer#,firstname,lastname,retail
FROM customers  JOIN orders USING (customer#)
                JOIN orderitems USING (order#)
                JOIN books USING (isbn)
WHERE retail = 
              ( 
                SELECT MIN(retail) FROM books
              );
              
              
              
              
SELECT firstname,lastname, title
FROM customers c  JOIN orders o USING (customer#)
                  JOIN orderitems oi USING (order#)
                  JOIN books b USING (isbn)
WHERE retail =
                (
                  SELECT MIN (retail) FROM books
                );
SELECT firstname, lastname, title
FROM customers c ,
  orders o ,
  orderitems oi ,
  books b
WHERE c.customer# = o.customer#
AND o.order#      = oi.order#
AND oi.isbn       = b.isbn
AND retail        =
                    (
                        SELECT MIN (retail) FROM books
                    );
-- -----------------------------------------------------------------------------
-- 7-9
-- How many customers purchased books 
-- written/co-written by James Austin
select count (distinct customer#)
from orders join orderitems using (order#)
            join books using (isbn)
where title in
              (
                select title
                from books join bookauthor using (isbn)
                           join author using (authorid)
                where fname = 'JAMES'
                  and lname = 'AUSTIN'
              );
    








SELECT COUNT(DISTINCT customer#)
FROM orders JOIN orderitems USING (order#)
            JOIN books USING (isbn)
WHERE title IN
              (
                SELECT title
                FROM author
                JOIN bookauthor USING(authorid)
                JOIN books USING(isbn)
                WHERE lname = 'AUSTIN'
                AND fname   = 'JAMES'
              );
-- -----------------------------------
SELECT COUNT(DISTINCT customer#)
FROM orders JOIN
  (
      SELECT title,order#
      FROM orders JOIN orderitems USING (order#)
                  JOIN books USING(isbn)
                  JOIN bookauthor USING (isbn)
                  JOIN author USING (authorid)
      WHERE lname = 'AUSTIN'
      AND fname   = 'JAMES'
  ) USING (order#);
-- ------------------------------------
SELECT COUNT(DISTINCT customer#)
FROM orders JOIN orderitems USING (order#)
            JOIN books USING (isbn)
            JOIN bookauthor USING (isbn)
            JOIN author USING (authorid)
WHERE lname = 'AUSTIN'
AND fname   = 'JAMES';

SELECT COUNT (DISTINCT customer#)
FROM orders o ,
  orderitems oi
WHERE o.order# = oi.order#
AND oi.isbn   IN
                ( 
                  SELECT DISTINCT b.isbn
                  FROM books b ,
                    bookauthor ba ,
                    author a
                  WHERE ba.isbn   = b.isbn
                  AND ba.authorid = a.authorid
                  AND lname       = 'AUSTIN'
                  AND fname       = 'JAMES'
                );
-- books written by James Austin
SELECT DISTINCT b.isbn
FROM books b ,
  bookauthor ba ,
  author a
WHERE ba.isbn   = b.isbn
AND ba.authorid = a.authorid
AND lname       = 'AUSTIN'
AND fname       = 'JAMES';
-- -----------------------------------------------------------------------------
-- 7-10
-- Which books by same publisher as 'The Wok Way to Cook'
select title, pubid
from books 
where pubid =
            (select pubid
              from books 
              where title = 'THE WOK WAY TO COOK'
            )
and title <> 'THE WOK WAY TO COOK';









SELECT title, name
FROM books JOIN publisher USING (pubid)
WHERE pubid =
              (
                SELECT pubid
                FROM publisher
                JOIN books USING (pubid)
                WHERE title LIKE '%WOK%'
              )
AND title NOT LIKE '%WOK%';

SELECT title
FROM books
WHERE pubid =
              (
                SELECT pubid
                FROM publisher
                JOIN books USING (pubid)
                WHERE title = 'THE WOK WAY TO COOK'
              );

SELECT title
FROM books
WHERE pubid =
            ( 
              SELECT pubid FROM books WHERE title = 'THE WOK WAY TO COOK'
            );
            
SELECT title
FROM books
WHERE pubid =
              (
                SELECT pubid FROM books WHERE title = 'THE WOK WAY TO COOK'
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
FROM orderitems JOIN books USING(isbn);

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
HAVING SUM(quantity    * retail) >
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
CREATE or replace view vw_employees
AS
  SELECT employee_id,last_name,first_name,primary_phone
  FROM employees
  ORDER BY 1;

select * from vw_employees;
  
  DESC vw_employees;
  
  SELECT * FROM vw_employees ORDER BY 1;
  DESC vw_employees;
  DROP VIEW vw_employees;
  DESC vw_employees;
  
  
  -- page 384
  SELECT * FROM vw_employees;
  
  SELECT employee_id, first_name || ' ' || last_name FROM vw_employees;
  
  
  
-- page 385 top
CREATE OR REPLACE VIEW vw_employees (A,B)
AS SELECT employee_id, last_name || ' ' || first_name FROM employees;


create table mytesttable2
as select employee_id, last_name || ' ' || first_name fullname FROM employees;
  
  DESC vw_employees;
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
  WHERE last_name   = 'Hoddlestein'
  AND first_name    = 'Howard';
  -- page 387 bottom add_on
  DELETE
  FROM emp_phone_book
  WHERE last_name = 'Hoddlestein'
  AND first_name  = 'Howard';
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
  SELECT a.ship_id,a.count_cabins,b.count_cruises
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

select * from ship_cabins;
select * from cruise_orders;

insert into cruise_orders values (1,sysdate,sysdate,2,1) ;
insert into cruise_orders values (2,sysdate,sysdate,2,1) ;
insert into cruise_orders values (3,sysdate,sysdate,2,1) ;

  -- page 391 top
  SELECT rownum, invoice_id, account_number
  FROM
    ( 
      SELECT invoice_id, account_number 
      FROM invoices 
      ORDER BY invoice_date
    )
WHERE rownum <= 3;
  
SELECT invoice_id, account_number 
FROM invoices
WHERE ROWNUM <=3;
  
  
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
  INSERT INTO shoppers(pid, pname, paddress) 
  VALUES(10,'albert','123 main');
  INSERT INTO shoppers(pid, pname, paddress) 
  VALUES(11,'betty','456 main');
  INSERT INTO shoppers(pid,pname,paddress)
    VALUES(12,'charley','789 main' );
END;
CREATE TABLE invoices
  (
    iid INTEGER,
    pid INTEGER,
    istoreVARCHAR2(10 byte),
    istorenum INTEGER,
    icity     VARCHAR2(10 byte),
    iamount   NUMBER,
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
  SET istore      = 'BnN'
  WHERE istorenum = 4000;
  UPDATE vw_shoppers SET istorenum = '7777' WHERE iid = 40;
  UPDATE vw_shoppers SET icity = 'Houston' WHERE iid = 40;
  UPDATE vw_shoppers SET iamount = 99.99 WHERE iid = 40;
  -- -----------------------------------------------------------------------------
  -- page 398 middle
  CREATE TABLE myseminars
    (
      seminar_id   INTEGER PRIMARY KEY,
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
  DROP sequence junk;

CREATE sequence JUNK minvalue 5 maxvalue 10 nocache increment BY 1 start with 6 cycle ;
SELECT junk.currval FROM dual;
SELECT junk.nextval FROM dual;
SELECT * FROM user_indexes WHERE table_name = 'CRUISES';
SELECT * FROM user_ind_columns WHERE table_name = 'CRUISES';


-- =============================================================================
-- Chapter 11
-- =============================================================================
-- page 424 :: Preparation
  DROP TABLE cruise_orders2;
  -- check to see if you have anything in cruise_orders
  SELECT *
  FROM cruise_orders2;
  -- if yes then delete
  DELETE FROM cruise_orders2;
  -- check the description
  -- page 424 Bottom
CREATE TABLE cruise_orders2
(
      cruise_order_id NUMBER,
      sales_rep_id    NUMBER
);
desc cruise_orders2;    
drop table cruise_orders2;
flashback table cruise_orders2 to before drop;
select * from v$option where value='FALSE';
alter session set flashback = ON;


alter table cruise_orders2 add (weather_code number default 0);
alter table cruise_orders2 drop column weather_code;

alter table cruise_orders2 
      add ( weather_code number default 0,
            travel varchar2(27) not null);

alter table cruise_orders2
      add first_time_customer varchar2(5)
      default 'YES' not null;
      
alter table cruise_orders2 add order_date varchar2(20);
alter table cruise_orders2 modify order_date date;

desc cruise_orders2;      

insert into cruise_orders2 (weather_code, travel, order_date)
 values ('3000','Freddy','12-OCT-12');
 
 select * from cruise_orders2;

insert into cruise_orders2 (weather_code, travel)
 values (1212,'Stewy');
 
alter table cruise_orders2 rename column travel to travel_agent_name; 
select * from cruise_orders2;

alter table cruise_orders2 drop column order_date;


   

ALTER TABLE cruise_orders2 MODIFY cruise_order_id CONSTRAINT pk_new_constraint PRIMARY KEY;
ALTER TABLE cruise_orders2 ADD CONSTRAINT pk_new_constraint PRIMARY KEY
(
    cruise_order_id
);
DESC cruise_orders2;
DESC cruise_orders2;
  -- page 424 Bottom add a column
  ALTER TABLE cruise_orders2 ADD
  (
    order_date VARCHAR2(20)
  )
  ;
  -- whoops wrong data type
  DESC cruise_orders2;
  -- skip to 427 modify a column to another data type
  ALTER TABLE cruise_orders2 MODIFY order_date DATE;
  ALTER TABLE cruise_orders2 MODIFY
  (
    order_date VARCHAR2(5), sales_rep_id INTEGER
  )
  ;
  ALTER TABLE cruise_orders2 MODIFY
  (
    order_date DATE
  )
  ;
  DESC cruise_orders2;
  -- page 425 Bottom add two columns one is not null
  -- no data yet so OK
  DESC cruise_orders2;
  SELECT * FROM cruise_orders2;
  -- this works ok because no data
  ALTER TABLE cruise_orders2 ADD ( weather_code NUMBER(2) DEFAULT 0, travel_agency VARCHAR2(27) NOT NULL);
  DESC cruise_orders2;
  -- drop the two columns
  ALTER TABLE cruise_orders2
  DROP column weather_code;
  ALTER TABLE cruise_orders2
  DROP column travel_agency;
  DESC cruise_orders2;
  -- add some data and then retry adding the rows
BEGIN
  INSERT INTO cruise_orders2 
    VALUES(1,22,sysdate);
  INSERT INTO cruise_orders2 
    VALUES (2,10,sysdate);
  INSERT INTO cruise_orders2 
    VALUES(3,72,sysdate);
  INSERT INTO cruise_orders2 
    VALUES(4,31,sysdate );
  INSERT INTO cruise_orders2 
    VALUES(5,54,sysdate );
END;
/
COMMIT;
SELECT * FROM cruise_orders2;
DESC cruise_orders2;
-- try page 425 Bottom again with data
DESC cruise_orders2;
ALTER TABLE cruise_orders2 ADD ( weather_code NUMBER(2) DEFAULT 0, travel_agency VARCHAR2(27) DEFAULT 'abc' NOT NULL);
ALTER TABLE cruise_orders2 MODIFY travel_agency NULL;
ALTER TABLE cruise_orders2 MODIFY travel_agency NOT NULL;
INSERT
INTO cruise_orders2 (cruise_order_id,sales_rep_id,order_date,weather_code )
  VALUES(8,4,sysdate,2 );
SELECT * FROM cruise_orders2;
-- delete the rows
DELETE FROM cruise_orders2;
-- then try to add again :: will work
ALTER TABLE cruise_orders2 ADD ( weather_code NUMBER(2) DEFAULT 0, travel_agency VARCHAR2(27) NOT NULL);
DESC cruise_orders2;
-- add the rows back in again
BEGIN
  INSERT INTO cruise_orders2 
    VALUES(1, 33, sysdate, 1, 'Yes');
  INSERT INTO cruise_orders2 
    VALUES(2, 2, sysdate, 2, 'Yes');
  INSERT INTO cruise_orders2 
    VALUES(3, 41, sysdate, 3, 'No');
  INSERT INTO cruise_orders2 
    VALUES(4, 55, sysdate, 1, 'Yes');
  INSERT INTO cruise_orders2 
    VALUES(5, 83, sysdate, 2, 'No' );
END;
/
COMMIT;
SELECT * FROM cruise_orders2;
-- page 426 top
-- add a column with not null default value YES to table with data
ALTER TABLE cruise_orders2 ADD first_time_customer VARCHAR2(5) DEFAULT 'YES' NOT NULL;
-- what happens to the default column?
SELECT * FROM cruise_orders2;
ALTER TABLE cruise_orders2
DROP column first_time_customer;
DESC cruise_orders2;
-- page 428 middle
ALTER TABLE cruise_orders2 MODIFY (order_date DATE NOT NULL);
SELECT * FROM cruise_orders2;
DESC cruise_orders2;
-- page 428 bottom
ALTER TABLE cruise_orders2 MODIFY (order_date DATE NULL);
-- page 429 Table 11-1
-- Page 430
ALTER TABLE cruise_orders2 MODIFY order_date DATE DEFAULT sysdate CONSTRAINT nn_o_date NOT NULL;
-- page 430 bootom
ALTER TABLE cruise_orders2 RENAME column order_date2 TO order_date;
ALTER TABLE cruise_orders2 RENAME column sales_rep_id TO sales_agent_id;
DESC cruise_orders2;
SELECT * FROM cruise_orders;
-- Page 431
DESC cruise_orders2;
ALTER TABLE cruise_orders2
DROP column order_date;
DESC cruise_orders2;
ALTER TABLE cruise_orders2 ADD order_date DATE;
DESC cruise_orders2;
ALTER TABLE cruise_orders2
DROP (order_date);
DESC cruise_orders2;
ALTER TABLE cruise_orders2 ADD order_date DATE;
-- Page 432
-- cannot drop a column if it is referenced by a FK in anotehr table
-- Page 433
-- unless you add the cascade constraints
-- Page 435
DESC cruise_orders;
-- page 436
desc cruise_orders2;
alter table cruise_orders2 modify cruise_order_id primary key;
delete from cruise_orders2;

SELECT * FROM dba_cons_columns WHERE table_name = 'CRUISE_ORDERS2';
SELECT * FROM user_constraints WHERE table_name LIke '%ORDERS2';
drop table cruise_orders2;

-- page 438
CREATE TABLE junk
  ( id INTEGER, 
    tid INTEGER, 
    mid INTEGER
  );
DROP TABLE junk;
CREATE TABLE junkfk
  ( id INTEGER, 
    fkid INTEGER, 
    mid INTEGER
  );
-- DROP TABLE junkfk;
-- -----------------------------------------------------------------------------
-- inline constraints
-- no name for this constraint
ALTER TABLE junk MODIFY id PRIMARY KEY;
select * from user_constraints where table_name = 'JUNK';
-- this names the constraint
ALTER TABLE junk MODIFY id CONSTRAINT pk_new PRIMARY KEY;
SELECT * FROM dba_cons_columns WHERE table_name = 'JUNK';

select * from user_constraints where table_name = 'JUNK';

ALTER TABLE junk MODIFY id NOT NULL;
select * from user_constraints where table_name = 'JUNK';
ALTER TABLE junk RENAME CONSTRAINT SYS_C007478 TO nn_mynew;

--ALTER TABLE junk MODIFY id NULL;
--ALTER TABLE junk MODIFY id CONSTRAINT nn_mynew NOT NULL;
--ALTER TABLE junkfk MODIFY id PRIMARY KEY;
-- -----------------------------------------------------------------------------
-- out-of-line constraints
ALTER TABLE junk ADD CONSTRAINT pk_new PRIMARY KEY (id);
ALTER TABLE junk ADD CONSTRAINT pk_new PRIMARY KEY (id, tid);

-- check
ALTER TABLE junk ADD CONSTRAINT ck_wrong CHECK (tid < id);

-- null will not work
-- alter table junk add constraint nn_wrong not null (tid);
-- fk
ALTER TABLE junkfk ADD CONSTRAINT fk_junk 
   FOREIGN KEY(fkid) REFERENCES junk(id);
   
select * from user_constraints where table_name = 'JUNK';
desc junkfk;

ALTER TABLE junk ADD CONSTRAINT pk_mypk PRIMARY KEY(id);
ALTER TABLE junkfk
DROP CONSTRAINT fk_junk;
ALTER TABLE junk
DROP CONSTRAINT pk_mypk;
DROP TABLE junk;
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'JUNK';
ALTER TABLE junk ADD CONSTRAINT pk_mypk PRIMARY KEY(id);
ALTER TABLE junk ADD CONSTRAINT ck_wrong CHECK (tid < id);
ALTER TABLE junk MODIFY id CONSTRAINT nn_mynew NOT NULL;
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'JUNKFK';
ALTER TABLE junkfk ADD CONSTRAINT my_id PRIMARY KEY(id);
ALTER TABLE junkfk ADD CONSTRAINT fk_junk FOREIGN KEY(fkid) REFERENCES junk(id);
DROP TABLE junk CASCADE CONSTRAINTS;
DROP TABLE junk;
ALTER TABLE junkfk enable VALIDATE CONSTRAINT fk_junk;
ALTER TABLE junkfk disable CONSTRAINT fk_junk;
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
CREATE TABLE ports3
(
    port_id   NUMBER(7),
    port_name VARCHAR2(20),
    CONSTRAINT pk_ports PRIMARY KEY (port_id)
);

-- DROP TABLE ports2 CASCADE CONSTRAINTS;
CREATE TABLE ships3
(
    ship_id      NUMBER(7),
    ship_name    VARCHAR2(20),
    home_port_id NUMBER(7),
    CONSTRAINT pk_ships PRIMARY KEY (ship_id),
    CONSTRAINT fk_sh_po FOREIGN KEY (home_port_id) 
                                      REFERENCES ports3 (port_id)
);
-- DROP TABLE ships3;
INSERT INTO ports3 VALUES (50, 'Jacksonville' );
INSERT INTO ports3 VALUES (51, 'New Orleans');
INSERT INTO ships3 VALUES (10, 'Codd Royale', 50);
INSERT INTO ships3 (ship_id, ship_name, home_port_id) 
                    VALUES (11, 'Codd Ensign',51 );
select * from ports3;
select * from ships3;

-- SELECT * FROM ships2;
DELETE FROM ports3 WHERE port_id = 50;
alter table ships3 disable constraint fk_sh_po;
alter table ships3 enable constraint fk_sh_po;
-- DELETE FROM ships3 WHERE home_port_id = 50;
-- DELETE FROM ports3 WHERE home_port_id = 51;

-- start here on thursday
-- page 450
SELECT table_name, constraint_name,constraint_type
FROM user_constraints
WHERE r_constraint_name IN
                          (
                            SELECT constraint_name
                            FROM user_constraints
                            WHERE table_name    = 'PORTS3'
                            --AND constraint_type = 'P'
                          );
select * from user_constraints;

                          
                          
                          
ALTER TABLE ships3 DROP CONSTRAINT fk_sh_po;


select * from user_constraints
where table_name = 'SHIPS3';

alter table Ships3 drop constraint fk_sh_po;

ALTER TABLE ships3 ADD CONSTRAINT fk_sh_po FOREIGN KEY (home_port_id) 
  REFERENCES ports3 (port_id) ON DELETE CASCADE;

select * from ports3;
select * from ships3;

delete from ports3 where port_id = 50;

SELECT * FROM ports3;
SELECT * FROM ships3;
DELETE FROM ports3 WHERE port_id = 50;

ROLLBACK;

-- page 455
-- in line syntax
drop table invoices4;

CREATE TABLE invoices40
(
    invoice_id NUMBER(11) PRIMARY KEY,
    invoice_date DATE
);

CREATE TABLE invoices4
(
    invoice_id NUMBER(11) PRIMARY KEY 
        USING INDEX (CREATE INDEX ix_invoices4 
                      ON invoices4 (invoice_id)),
    invoice_date DATE
);

-- 
CREATE TABLE invoices5
(
    lastname varchar2(20)
);
CREATE INDEX ix_invoices5_last_name ON invoices5 (lastname); 

-- page 456
-- out-of-line syntax
drop table invoices6;
CREATE TABLE invoices6
(
    invoice_id   NUMBER(11),
    invoice_date DATE,
    CONSTRAINT ck_invs_inv_id PRIMARY KEY (invoice_id) 
      USING INDEX (CREATE INDEX ix_invoices6 ON invoices6
      (invoice_id ))
);

-- page 457 top
CREATE TABLE customers2
(
   customer_id NUMBER(11) PRIMARY KEY,
   last_name   VARCHAR2(30)
);

CREATE INDEX ix_customers_last_name2 ON customers2
  (upper(last_name));

insert into customers2
  select customer#, lastname from customers;

SELECT * FROM customers2 
  WHERE upper(last_name) = 'SMITH';

SELECT * FROM customers2 
  WHERE last_name = 'SMITH';

-- page 457 bottom
CREATE TABLE gas_tanks
(
    gas_tank_id   NUMBER(7),
    tank_gallons  NUMBER(9),
    mileage       NUMBER(9)
);

CREATE INDEX ix_gas_tanks_001 ON gas_tanks
  (tank_gallons * mileage);

select * from gas_tanks
  where tank_gallons * mileage > 70;
  
select * from gas_tanks
  where tank_gallons > 70;

-- page 460
-- turn on flashback table to before drop for 11g XE
-- as system
-- select * from V$database;
-- select property_value from database_properties where property_name='DEFAULT_PERMANENT_TABLESPACE';
select user, default_tablespace from dba_users where username='CRUISES';
alter user cruises default tablespace users;

select user, default_tablespace from dba_users where username='BOOKS';
alter user books default tablespace users;

-- as cruises
drop table testjunk;
create table testjunk(id integer);

insert into testjunk values (1);
insert into testjunk values (2);
insert into testjunk values (3);
commit;
purge recyclebin;
purge table testjunk;
select * from testjunk;
-- select * from user_tables where table_name = 'TESTJUNK';
drop table testjunk;
select * from recyclebin;
flashback table testjunk to before drop;

CREATE TABLE houdini
( voila VARCHAR2(30) );
INSERT INTO houdini(voila) 
  VALUES ('Now you see it.' );
COMMIT;
SELECT * FROM houdini;
DROP TABLE houdini;
flashback TABLE houdini TO before DROP;
SELECT * FROM houdini;
-- page 461
SELECT * FROM user_recyclebin;
SELECT * FROM recyclebin;
-- page 463
CREATE TABLE houdini2
  (voila VARCHAR2(30) ) enable row movement;
SELECT * FROM recyclebin;
SELECT scn_to_timestamp(2282742) FROM dual;

INSERT INTO houdini2 (voila) 
  VALUES ('Now you see it.' );
COMMIT;
EXECUTE dbms_lock.sleep(15);
DELETE FROM houdini2;
COMMIT;
EXECUTE dbms_lock.sleep(15);

flashback TABLE houdini2 TO TIMESTAMP systimestamp - interval '0 00:00:20' DAY TO second;

-- doesn't work because flashback is not enabled in APEX
SELECT ora_rowscn, voila FROM houdini;
SELECT scn_to_timestamp(2285139) FROM dual;
select ora_rowscn, id from testjunk;
SELECT scn_to_timestamp(2331288) FROM dual;


SELECT * FROM all_directories;
CREATE TABLE cruises2 AS
SELECT * FROM cruises;
DESC cruises2;
-- flashback table does not work in XE
ALTER TABLE cruises2 SET unused column status;
flashback TABLE cruises2 TO TIMESTAMP systimestamp - interval '0 00:05:00' DAY TO second;

DROP TABLE cruises2;
-- not enables in XE
flashback TABLE cruises2 TO before  DROP;
SELECT * FROM recyclebin;
purge recyclebin;
-- not enabled in XE
CREATE RESTORE POINT my_restore;
CREATE TABLE houdini3  (voila VARCHAR2(30)) enable row movement;
INSERT INTO houdini3 (voila) VALUES('Now you see it');
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
  AS   'C:\temp';
-- B. GRANT READ, WRITE ON DIRECTORY BANK_FILES TO CRUISES;
GRANT READ,WRITE ON DIRECTORY BANK_FILES TO CRUISES;
-- -----------------------------------------------------------------------------
-- 3. Create the external table
drop table INVOICES_EXTERNAL;
CREATE TABLE invoices_external
(
    invoice_id     CHAR(6),
    invoice_date   CHAR(13),
    invoice_amt    CHAR(9),
    account_number CHAR(11)
)
organization external
(
    type oracle_loader DEFAULT 
      directory bank_files access 
      parameters (records delimited BY newline skip 2 fields 
      ( invoice_id CHAR(6), invoice_date CHAR(13), 
      invoice_amt CHAR(9), account_number CHAR(11)))
      -- make sure there are no extra lines that might be interpreted as null later when loading into PK
      location ('load_invoices.txt')
);
select * from invoices_external;
select count(*) from invoices_external;


    
SELECT COUNT(*) FROM invoices_external;
DROP TABLE invoices_external;
-- -----------------------------------------------------------------------------
-- 4. Create the internal table from the external table
DROP TABLE invoices_internal;
CREATE TABLE invoices_internal AS
SELECT * FROM invoices_external;
SELECT * FROM recyclebin;
SELECT * FROM invoices_internal WHERE invoice_id IS NULL;
SELECT COUNT(*) FROM invoices_external;
SELECT COUNT(*) FROM invoices_internal;
-- -----------------------------------------------------------------------------
-- 5. Create a new table with datatypes we want
-- DROP TABLE invoices_revised;
CREATE TABLE invoices_revised
(
    invoice_id     INTEGER,
    invoice_date   DATE,
    invoice_amt    NUMBER,
    account_number VARCHAR2(13)
);

select count(*) from invoices_revised;

DESC invoices_external;
DESC invoices_revised;
SELECT COUNT(*) FROM invoices_external;
SELECT COUNT(*) FROM invoices_internal;
-- -----------------------------------------------------------------------------
-- 6. Insert into the new table
INSERT INTO invoices_revised (invoice_id,invoice_date,invoice_amt,account_number)
  SELECT  invoice_id, to_date(invoice_date,'mm/dd/yyyy'), 
          to_number(invoice_amt), account_number
  FROM invoices_external;
  
  
  
  
  
commit;
select count(*) from invoices_revised;





-- Done
SELECT COUNT(*) FROM invoices_revised;
SELECT COUNT(*) FROM invoices_revised;
COMMIT;
-- =============================================================================
-- Chapter 12
-- =============================================================================
SELECT * FROM contact_emails;
-- ------------------------------
SELECT * FROM online_subscribers;
-- ------------------------------
SELECT contact_email_id, email_address
FROM contact_emails
WHERE status = 'Valid'
UNION 
SELECT online_subscriber_id, email 
FROM online_subscribers;

SELECT email_address
FROM contact_emails
WHERE status = 'Valid'
UNION ALL
SELECT email 
FROM online_subscribers;

SELECT email_address FROM contact_emails WHERE status = 'Valid'
UNION ALL
SELECT email FROM online_subscribers;


SELECT email_address FROM contact_emails WHERE status = 'Valid'
SELECT email FROM online_subscribers;
-- ------------------------------
SELECT contact_email_id,
  email_address
FROM contact_emails
UNION
SELECT online_subscriber_id, email FROM online_subscribers;
-- ------------------------------
SELECT contact_email_id,
  email_address
FROM contact_emails
UNION ALL
SELECT online_subscriber_id, email FROM online_subscribers;
-- ------------------------------
SELECT email_address FROM contact_emails
UNION
SELECT email FROM online_subscribers;
-- ------------------------------
SELECT email_address 
FROM contact_emails
INTERSECT
SELECT email 
FROM online_subscribers;
-- ------------------------------
SELECT email FROM online_subscribers
INTERSECT
SELECT email_address FROM contact_emails;
-- ------------------------------
SELECT email_address FROM contact_emails;
-- ------------------------------
SELECT email FROM online_subscribers;
-- ------------------------------
SELECT email_address 
FROM contact_emails
MINUS
SELECT email 
FROM online_subscribers
ORDER BY email_address;


-- ------------------------------
SELECT email FROM online_subscribers
MINUS
SELECT email_address FROM contact_emails;
-- ------------------------------
SELECT email FROM online_subscribers
MINUS
SELECT email_address FROM contact_emails ORDER BY email;
-- ------------------------------
SELECT product 
FROM store_inventory
UNION ALL
SELECT item_name 
FROM furnishings;

SELECT product 
FROM Store_inventory 
WHERE product = 'Towel'
MINUS
SELECT item_name
FROM furnishings
WHERE item_name = 'Towel';



SELECT product FROM store_inventory
UNION ALL
SELECT item_name FROM furnishings
MINUS
  ( SELECT product FROM store_inventory WHERE product = 'Towel'
  UNION ALL
  SELECT item_name FROM furnishings WHERE item_name = 'Towel'
  );
  
  
  
  
  
SELECT 'Individual', last_name ||' ' || first_name name FROM cruise_customers
UNION
SELECT category, vendor_name FROM vendors ORDER BY name DESC;



SELECT email,
  (SELECT num FROM store_inventory WHERE num = 1
  MINUS
  SELECT cat# FROM furnishings WHERE cat# = 77
  )
FROM online_subscribers;



SELECT '---' FROM online_subscribers;
-- question 12
select a.sub_date, count(*)
from online_subscribers a join
        (select to_date(last_order,'yyyy/mm/dd') last_order, product from store_inventory
         UNION
        select added, item_name from furnishings) b
    on a.sub_date = b.last_order
group by a.sub_date;

select last_order from store_inventory;
-- =============================================================================
-- Chapter 13
-- =============================================================================
-- -----------------------------------------------------------------------------
--ROLLUP 1 C O L U M N
-- -----------------------------------------------------------------------------
-- find some rows to deal with
SELECT room_style,
       room_type,
       sq_ft
FROM ship_cabins
WHERE ship_cabin_id < 7
AND ship_cabin_id   > 3
ORDER BY 1;

SELECT room_type, SUM(sq_ft)
FROM ship_cabins
WHERE ship_cabin_id < 7
AND ship_cabin_id   > 3
GROUP BY room_type
ORDER BY 1;


-- then revisit the group by and aggregate function SUM
-- page 513 top 1 col ROOM_STYLE
SELECT room_style, SUM(sq_ft) sq_ft
FROM ship_cabins
WHERE ship_cabin_id < 7
AND ship_cabin_id   > 3
GROUP BY room_style
ORDER BY 1;

-- now try adding ROLLUP ROOM_STYLE
-- page 513 bottom 1 col
SELECT room_style, SUM(sq_ft) sq_ft
FROM ship_cabins
WHERE ship_cabin_id < 7
AND ship_cabin_id   > 3
GROUP BY rollup (room_style)
ORDER BY room_style;
-- ------------------------------------------
-- Try the same steps with ROOM_TYPE
-- ------------------------------------------
-- page 513 top 1 col ROOM_TYPE
-- find some rows to deal with
SELECT room_type,  sq_ft
FROM ship_cabins
WHERE ship_cabin_id < 7
AND ship_cabin_id   > 3
ORDER BY 1;


SELECT room_type, SUM(sq_ft) sq_ft
FROM ship_cabins
WHERE ship_cabin_id < 7
 AND ship_cabin_id   > 3
GROUP BY room_type
ORDER BY 1;

SELECT room_type,SUM(sq_ft) sq_ft
FROM ship_cabins
WHERE ship_cabin_id < 7
AND ship_cabin_id   > 3
GROUP BY rollup (room_type)
ORDER BY room_type;

-- -----------------------------------------------------------------------------
-- ROLLUP 2 C O L U M N S
-- -----------------------------------------------------------------------------
-- find some rows
SELECT room_style, room_type, sq_ft
FROM ship_cabins
WHERE ship_cabin_id < 7
AND ship_cabin_id   > 3;

-- group by ROOM_STYLE, ROOM_TYPE
SELECT room_style, room_type, SUM(sq_ft) sq_ft
FROM ship_cabins
WHERE ship_cabin_id < 7
AND ship_cabin_id   > 3
GROUP BY room_style, room_type;
ORDER BY 1, 2;

SELECT room_type, room_style, SUM(sq_ft) sq_ft
FROM ship_cabins
WHERE ship_cabin_id < 7
AND ship_cabin_id   > 3
GROUP BY room_type, room_style;
order by 1,2;

-- rollup by ROOM_STYLE, ROOM_TYPE
SELECT room_style,room_type,SUM(sq_ft) sum_sq_ft
FROM ship_cabins
WHERE ship_cabin_id < 7
AND ship_cabin_id   > 3
GROUP BY rollup (room_style, room_type)
ORDER BY 1, 2;
  
 
SELECT room_style, SUM(sq_ft) sum_sq_ft
FROM ship_cabins
WHERE ship_cabin_id < 7
AND ship_cabin_id   > 3
GROUP BY rollup (room_style)
ORDER BY room_style;
-- -----------------------------------------------------------------------------
-- ROLLUP 2 C O L U M N S Reverse column order
-- -----------------------------------------------------------------------------
-- find some rows
SELECT room_type, room_style, sq_ft
FROM ship_cabins
WHERE ship_cabin_id < 7
AND ship_cabin_id   > 3;


-- ------------------------------------------------
-- reverse the GROUP BY
SELECT room_type, room_style, SUM(sq_ft)
FROM ship_cabins
WHERE ship_cabin_id < 7
  AND ship_cabin_id   > 3
GROUP BY room_type,room_style;

-- -----------------------------------
-- rollup
SELECT room_type,room_style, SUM(sq_ft) sum_sq_ft
FROM ship_cabins
WHERE ship_cabin_id < 7
AND ship_cabin_id   > 3
GROUP BY rollup(room_type,room_style)
ORDER BY 1, 2;
-- -----------------------------------------------------------------------------
-- PAGE 514
SELECT window,room_style,room_type,sq_ft
FROM ship_cabins
WHERE ship_cabin_id < 9
AND ship_cabin_id   > 5;

SELECT window,room_style,room_type,sum(sq_ft)
FROM ship_cabins
WHERE ship_cabin_id < 9
AND ship_cabin_id   > 5
group by window,room_style,room_type;

SELECT window, room_style, room_type, SUM(sq_ft)
FROM ship_cabins
where ship_id = 1
--WHERE ship_cabin_id < 9
--AND ship_cabin_id   > 5
GROUP BY rollup(window, room_style, room_type)
ORDER BY 1,2,3;

SELECT room_style, room_type, count(sq_ft),sum(sq_ft)
FROM ship_cabins
where ship_id = 1
--WHERE ship_cabin_id < 9
--AND ship_cabin_id   > 5
GROUP BY rollup(room_style, room_type)
ORDER BY 1,2,3;


select * from ship_cabins;

SELECT window, room_style, room_type 
FROM ship_cabins
WHERE ship_cabin_id < 9
AND ship_cabin_id   > 5;

SELECT window,room_style,room_type, SUM(sq_ft)
FROM ship_cabins
WHERE ship_cabin_id < 9
AND ship_cabin_id   > 5
GROUP BY window, room_style, rollup(room_type)
ORDER BY 1,2,3;

SELECT room_style, room_type, SUM(sq_ft)
FROM ship_cabins
WHERE ship_cabin_id < 9
AND ship_cabin_id   > 5
GROUP BY room_style, rollup(room_type)
ORDER BY 1,2,3;





SELECT window,room_style,room_type, SUM(sq_ft)
FROM ship_cabins
WHERE ship_cabin_id < 9
AND ship_cabin_id   > 5
GROUP BY grouping sets (window, (room_style,room_type)),
  rollup(room_style,room_type)
ORDER BY 1,2,3;
-- -----------------------------------------------------------------------------
-- ROLLUP 3 C O L U M N S
-- -----------------------------------------------------------------------------
-- find the same rows
SELECT window, room_type,room_style, sq_ft
FROM ship_cabins
WHERE ship_cabin_id < 12
AND ship_cabin_id   > 6;

SELECT window,room_type,room_style,SUM(sq_ft)
FROM ship_cabins
WHERE ship_cabin_id < 12
AND ship_cabin_id   > 6
GROUP BY window,room_type,room_style;

SELECT window,room_type,room_style,SUM(sq_ft), count(*)
FROM ship_cabins
WHERE ship_cabin_id < 12
AND ship_cabin_id   > 6
GROUP BY rollup(window, room_type, room_style)
ORDER BY 1,2,3;

-- -----------------------------------
-- rollup by WINDOW, ROOM_STYLE, ROOM_TYPE
SELECT ship_cabin_id, window,room_type,room_style, sq_ft
FROM ship_cabins
WHERE ship_cabin_id < 11
AND ship_cabin_id   > 6
ORDER BY 1, 2, 3;


SELECT window,room_type,room_style,SUM(sq_ft) sum_sq_ft
FROM ship_cabins
WHERE ship_cabin_id < 11
AND ship_cabin_id   > 6
GROUP BY rollup (window,room_type,room_style)
ORDER BY 1,2,3;

SELECT * FROM ship_cabins 
WHERE ship_cabin_id < 12 
AND ship_cabin_id > 7;


-- -----------------------------------------------------------------------------
-- CUBE 1 C O L U M N
-- -----------------------------------------------------------------------------
-- find the same rows
SELECT room_style, sq_ft
FROM ship_cabins
WHERE ship_cabin_id < 7
AND ship_cabin_id   > 3;

-- -----------------------------------
-- group by ROOM_STYLE
-- -----------------------------------
SELECT room_style, SUM(sq_ft) sum_sf
FROM ship_cabins
WHERE ship_cabin_id < 7
AND ship_cabin_id   > 3
GROUP BY room_style
ORDER BY 1;
-- -----------------------------------
-- rollup by ROOM_STYLE
SELECT room_style, SUM(sq_ft) sum_sq_ft
FROM ship_cabins
WHERE ship_cabin_id < 7
AND ship_cabin_id   > 3
GROUP BY rollup (room_style)
ORDER BY 1;

-- -----------------------------------
-- cube by ROOM_STYLE
-- 1 column looks like rollup
SELECT room_style, SUM(sq_ft) sum_sq_ft
FROM ship_cabins
WHERE ship_cabin_id < 7
AND ship_cabin_id   > 3
GROUP BY cube (room_style)
ORDER BY 1;
-- -----------------------------------------------------------------------------
-- CUBE 2 C O L U M N
-- -----------------------------------------------------------------------------
-- find the same rows
SELECT room_type, room_style, sq_ft
FROM ship_cabins
WHERE ship_cabin_id < 7
AND ship_cabin_id   > 3 ;
-- -----------------------------------
-- group by ROOM_TYPE, ROOM_STYLE
SELECT room_type, room_style, SUM(sq_ft) sum_sf
FROM ship_cabins
WHERE ship_cabin_id < 7
AND ship_cabin_id   > 3
GROUP BY room_type, room_style
ORDER BY 1;
-- -----------------------------------
-- rollup by ROOM_TYPE,ROOM_STYLE
SELECT room_type,
  room_style,
  SUM(sq_ft) sum_sf
FROM ship_cabins
WHERE ship_cabin_id < 7
AND ship_cabin_id   > 3
GROUP BY rollup (room_type,room_style)
ORDER BY 1;
-- -----------------------------------
-- cube by ROOM_TYPE,ROOM_STYLE
-- 1 column looks like rollup
SELECT room_type,
  room_style,
  SUM(sq_ft) sum_sq_ft
FROM ship_cabins
WHERE ship_cabin_id < 7
AND ship_cabin_id   > 3
GROUP BY cube (room_type,room_style)
ORDER BY 1;
-- -----------------------------------
-- cube by WINDOW, ROOM_TYPE,ROOM_STYLE
SELECT window,  room_type, room_style,
  sq_ft
FROM ship_cabins
WHERE ship_cabin_id < 7
AND ship_cabin_id   > 3;
SELECT window,
  room_type,
  room_style,
  SUM(sq_ft) sum_sq_ft
FROM ship_cabins
WHERE ship_cabin_id < 7
AND ship_cabin_id   > 3
GROUP BY cube (window,room_type,room_style);


select window,room_type,room_style
from ship_cabins
where ship_cabin_id > 4
AND ship_cabin_id   < 8;

select window,room_type,room_style, sum(sq_ft)
from ship_cabins
where ship_cabin_id > 4
AND ship_cabin_id   < 8
group by cube (window,room_type,room_style);



-- ORDER BY 1;
-- -----------------------------------------------------------------------------
-- GROUPING ROLLUP 2 C O L U M N  page 516
-- -----------------------------------------------------------------------------
SELECT room_style, room_type
FROM ship_cabins
WHERE ship_id = 1
ORDER BY 1,2;

SELECT room_style, room_type, SUM(sq_ft) sf
FROM ship_cabins
WHERE ship_id = 1
GROUP BY cube (room_style, room_type)
ORDER BY 1,2;
-- -----------------------------------------------------------------------------
-- GROUPING ROLLUP 2 C O L U M N  page 517
-- -----------------------------------------------------------------------------
SELECT grouping(room_style), 
        room_style, room_type,
        SUM(sq_ft) sum_sq_ft
FROM ship_cabins
WHERE ship_id = 1
GROUP BY rollup(room_style, room_type)
ORDER BY room_style, room_type;

-- how many 1's
SELECT grouping(room_type), 
        room_style, room_type,
        SUM(sq_ft) sum_sq_ft
FROM ship_cabins
WHERE ship_cabin_id < 7
  and ship_cabin_id > 4
GROUP BY cube(room_style, room_type)
ORDER BY room_style, room_type;

SELECT grouping(room_style), 
        room_style, room_type,
        SUM(sq_ft) sum_sq_ft
FROM ship_cabins
WHERE ship_cabin_id < 7
  and ship_cabin_id > 4
GROUP BY cube(room_type, room_style)
ORDER BY room_style, room_type;


SELECT   WINDOW,
        -- grouping(window), 
        room_style, room_type,
        SUM(sq_ft) sum_sq_ft
FROM ship_cabins
WHERE ship_cabin_id < 7
  and ship_cabin_id > 5
GROUP BY cube(window,room_type, room_style);
ORDER BY window, room_style, room_type;

1.  0     0     0
2.  0     X     0
3.  0     0     X     
4.  X     0     0
5.  X     X     0
6.  0     X     X
7.  X     0     X
8.  X     X     X

SELECT ship_cabin_id,window, room_style, room_type
FROM ship_cabins
WHERE ship_cabin_id < 7
  and ship_cabin_id > 5
ORDER BY window,room_style, room_type;  
  
 
select nvl(decode
                  (grouping(room_type),
                              1,    upper(room_style),
                              initcap(room_style)
                   )
       , 'GRAND TOTAL') 
       room_style_formatted,
       room_type,
       round(sum(sq_ft),2) sum_sq_ft
FROM ship_cabins
WHERE ship_cabin_id < 7
  and ship_cabin_id > 4
GROUP BY ROLLUP(ROOM_STYLE, ROOM_TYPE)  
ORDER BY room_style, room_type;

0   0
0   X
X   X

select room_style, room_type
from ship_cabins
WHERE ship_cabin_id < 7
  and ship_cabin_id > 4;


SELECT NVL(DECODE (grouping(room_type),1, upper(room_style),initcap(room_style)),
       'GRAND TOTAL') room_style, NVL(room_type,'Sub Total') room_type,
        SUM(sq_ft) sum_sq_ft
FROM ship_cabins
WHERE ship_cabin_id < 7
  and ship_cabin_id > 4
GROUP BY rollup(room_style, room_type);






-- -----------------------------------------------------------------------------
-- GROUPING SETS page 519
-- -----------------------------------------------------------------------------
SELECT window,
  room_style,
  room_type,
  SUM(sq_ft)
FROM ship_cabins
WHERE ship_id = 1
GROUP BY cube (window, room_style, room_type)
ORDER BY 1,2,3;
SELECT window,
  room_style,
  room_type,
  SUM(sq_ft) sum_sq_ft
FROM ship_cabins
WHERE ship_id_cabin = 1
GROUP BY grouping sets ((window, room_style), room_type, NULL)
ORDER BY 1,2,3;
SELECT window,
  room_style,
  room_type,
  sq_ft
FROM ship_cabins
WHERE ship_cabin_id < 7
AND ship_cabin_id   > 3;

SELECT window,room_style,room_type, SUM(sq_ft)
FROM ship_cabins
WHERE ship_cabin_id < 7
AND ship_cabin_id   > 3
GROUP BY cube(window,room_style,room_type)
ORDER BY 1,2,3;

SELECT window,room_style,room_type,SUM(sq_ft) sum_sq_ft
FROM ship_cabins
WHERE ship_cabin_id < 7
AND ship_cabin_id   > 3
GROUP BY grouping sets ((window, room_style), room_type, NULL)
ORDER BY 1,2,3;

SELECT window,room_style,room_type,SUM(sq_ft) sum_sq_ft
FROM ship_cabins
WHERE ship_cabin_id < 7
AND ship_cabin_id   > 3
GROUP BY grouping sets ((window, room_style), room_type, null)
ORDER BY 1,2,3;

SELECT window,room_style,room_type,SUM(sq_ft) sum_sq_ft
FROM ship_cabins
WHERE ship_cabin_id < 7
AND ship_cabin_id   > 3
GROUP BY grouping sets (window, (room_style, room_type), null)
ORDER BY 1,2,3;

SELECT window,room_style,room_type
FROM ship_cabins
WHERE ship_cabin_id < 7
AND ship_cabin_id   > 3;

SELECT p.category,
  p.product,
  p.deck_id,
  SUM(p.qty) sum_qty
FROM provisions p
JOIN decks d
ON p.deck_id = d.deck_id
GROUP BY grouping sets ((p.category,p.product),(p.deck_id))
ORDER BY 1,2,3;
-- -----------------------------------
SELECT grouping(window),
  grouping(room_type),
  grouping(room_style),
  SUM(sq_ft) sum_sq_ft
FROM ship_cabins
WHERE ship_id     = 1
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
WHERE ship_id     = 1
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
WHERE ship_id     = 1
AND ship_cabin_id < 6
ORDER BY room_style,
  room_type;
SELECT room_style,
  room_type,
  SUM(sq_ft) sum_sq_ft
FROM ship_cabins
WHERE ship_id     = 1
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
WHERE ship_id     = 1
AND ship_cabin_id < 6;
SELECT window,
  room_style,
  room_type,
  SUM(sq_ft) sq_ft
FROM ship_cabins
WHERE ship_id     = 1
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
WHERE ship_id     = 1
AND ship_cabin_id < 6;
SELECT window,
  room_style,
  room_type,
  SUM(sq_ft) sq_ft,
  grouping(window)     AS wd,
  grouping(room_style) AS rs,
  grouping(room_type)  AS rt
FROM ship_cabins
WHERE ship_id     = 1
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
WHERE ship_id     = 1
AND ship_cabin_id < 10;

-- page 516 cube 1 col
SELECT room_type,
  SUM(sq_ft) sq_ft
FROM ship_cabins
WHERE ship_id     = 1
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
WHERE ship_id     = 1
AND ship_cabin_id < 9
AND ship_cabin_id > 5
ORDER BY room_style,
  room_type;
-- page 516 cube 2 col
SELECT room_style,
  room_type,
  SUM(sq_ft) sq_ft
FROM ship_cabins
WHERE ship_id     = 1
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
WHERE ship_id     = 1
AND ship_cabin_id < 9
AND ship_cabin_id > 5
ORDER BY room_style,
  room_type;
SELECT window,
  room_style,
  room_type,
  SUM(sq_ft) sq_ft
FROM ship_cabins
WHERE ship_id     = 1
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
  grouping(room_type),
  room_style,
  room_type,
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
SELECT -- grouping(room_style),
  -- grouping(room_type),
  DECODE(grouping(room_style), 1,'ALL STYLES', room_style) style,
  DECODE(grouping(room_type), 1,'ALL TYPES', room_type) type,
  SUM(sq_ft) sq_ft
FROM ship_cabins
WHERE ship_cabin_id < 7
AND ship_cabin_id   > 3
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
    name   VARCHAR2(20) NOT NULL
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
SELECT *
FROM user_tables;

select table_name, column_name
from user_tab_columns
where column_name like '%EMP%';

select table_name, column_name
from all_tab_columns
where column_name like '%EMP%';

select table_name, column_name
from dba_tab_columns
where column_name like '%EMP%';

SELECT * FROM all_tables;

SELECT * FROM dba_tables;
SELECT * FROM dba_tab_columns WHERE owner LIKE '%CRUISES%';

SELECT * FROM user_constraints;
SELECT * FROM user_cons_columns;

SELECT constraint_name, constraint_type, r_constraint_name, status
FROM user_constraints
WHERE table_name = 'CRUISES';

SELECT * FROM user_constraints
where table_NAME = 'CRUISES';

SELECT * FROM user_cons_columns
where table_NAME = 'CRUISES';
;
SELECT uc.table_name, uc.constraint_name, column_name
FROM  user_constraints uc,
      user_cons_columns cc
where 1=1 
  -- and uc.table_name = cc.table_name
  and uc.constraint_name = cc.constraint_name
and uc.constraint_name = 'FK_CRUISES_CRUISE_TYPES';


SELECT * FROM user_cons_columns;


select * 
from user_constraints
WHERE owner = 'CRUISES'; 

SELECT * 
FROM user_cons_columns 
WHERE table_name = 'CRUISES';

SELECT * 
FROM user_constraints 
WHERE owner = 'CRUISES';

SELECT * FROM user_tab_privs;
SELECT * FROM user_tab_privs;
SELECT * FROM user_sys_privs;

SELECT DISTINCT status 
FROM user_constraints;

select distinct status 
from user_objects;

SELECT * FROM v$database;
SELECT * FROM v$instance;
SELECT * FROM v$parameter;

SELECT * FROM v$parameter where lower(name) like '%date%';

SELECT * FROM v$parameter2;
SELECT * FROM v$session;
SELECT * FROM v$reserved_words;

SELECT * FROM v$timezone_names;
SELECT count(*) FROM v$timezone_names;

SELECT * FROM all_tab_comments;
SELECT * FROM all_col_comments;
SELECT * FROM user_synonyms;
SELECT * FROM all_tab_columns WHERE lower(table_name) LIKE '%user_synonyms%';
-- ------------------------------------------------------
-- page 536
SELECT *
FROM user_tables;
SELECT * FROM all_tables;
SELECT * FROM dba_tables;
SELECT column_name FROM all_tab_columns WHERE table_name = 'CRUISES';
-- ------------------------------------------------------
SELECT column_name,
  data_type,
  data_length
FROM all_tab_columns
WHERE table_name = 'CRUISES';
-- ------------------------------------------------------
SELECT *
FROM all_tab_columns
WHERE owner = 'CRUISES';
-- ------------------------------------------------------
SELECT *
FROM all_tab_columns
WHERE owner    = 'CRUISES'
AND table_name = 'ADDRESSES';
-- ------------------------------------------------------
SELECT column_name
FROM all_tab_columns
WHERE owner    = 'CRUISES'
AND table_name = 'ADDRESSES';
-- ------------------------------------------------------
-- address_id,employee_id,street_address,street_address2,city,state,zip,zip_plus,country,contact_email,
SELECT *
FROM all_cons_columns
WHERE owner = 'CRUISES';
-- ------------------------------------------------------
SELECT *
FROM all_synonyms;
-- ------------------------------------------------------
-- page 537
SELECT *
FROM user_constraints;
SELECT * FROM all_constraints;
-- ------------------------------------------------------
-- page 537
SELECT *
FROM user_synonyms;
SELECT * FROM all_synonyms;
-- ------------------------------------------------------
-- page 538 Overlap of views
SELECT *
FROM user_catalog;
SELECT * FROM user_tables;
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
SELECT *
FROM v$version;
SELECT * FROM product_component_version;
-- ------------------------------------------------------
-- page 539
-- as system
SELECT *
FROM v$database;
SELECT * FROM v$instance;
SELECT * FROM v$timezone_names;
-- ------------------------------------------------------
-- page 540
SELECT *
FROM all_tab_comments
WHERE table_name = 'PORTS';

SELECT * FROM all_col_comments;

select '*TABLE: ' || table_name, comments
from all_tab_comments
where owner = 'SYS'
and table_name = 'USER_SYNONYMS'
UNION
select 'COL: ' || column_name, comments
from all_col_comments
where owner = 'SYS'
and table_name = 'USER_SYNONYMS';

select * from all_tab_comments
where comments is not null;

select * 
from all_col_comments
where owner = 'CRUISES'
and comments is not null;



-- ------------------------------------------------------
-- page 541
COMMENT ON TABLE ports IS 'Listing of all ports';
SELECT * FROM user_tab_comments
where table_name = 'PORTS';
-- ------------------------------------------------------
-- page 541
COMMENT ON column ports.capacity IS 'Max num of passengers';
SELECT * FROM user_col_comments
where table_name = 'PORTS';

-- page 542
DESC dictionary;

SELECT * FROM dictionary
order by table_name;

SELECT * FROM dictionary
where table_name = 'PORTS';

SELECT distinct(substr(table_name,1,3)) FROM dictionary;

-- page 543
SELECT * FROM dictionary WHERE table_name LIKE '%RESTORE%';
SELECT * FROM dictionary WHERE upper(comments) LIKE '%INDEX%';
SELECT * FROM dictionary WHERE upper(comments) LIKE '%RESTORE%';
-- ------------------------------------------------------
-- page 543
SELECT *
FROM all_col_comments
WHERE owner    = 'CRUISES'
AND table_name = 'PORTS';
-- ------------------------------------------------------
-- page 544
SELECT *
FROM user_catalog;
SELECT table_type, COUNT(*) FROM user_catalog GROUP BY table_type;
SELECT table_type, COUNT(*) FROM user_catalog GROUP BY table_type;

select distinct table_name 
from all_tab_columns
where owner = 'CRUISES';
-- ------------------------------------------------------
-- page 545
SELECT *
FROM user_tab_columns;
-- ------------------------------------------------------
-- page 546 middle
SELECT status,
  object_type,
  object_name
FROM USER_OBJECTS;
WHERE STATUS = 'INVALID';
-- ------------------------------------------------------
-- page 546 bottom
SELECT *
FROM user_views;
-- ------------------------------------------------------
-- page 547
SELECT *
FROM user_constraints
WHERE table_name = 'CRUISES';

select table_name
from user_tables;

select * 
from user_cons_columns;

SELECT *
FROM  user_constraints uc,
      USER_CONS_COLUMNS ucc
WHERE uc.table_name = ucc.table_name 
 and uc.table_name = 'CRUISES';

-- as system
SELECT * FROM V$SYSTEM_PARAMETER WHERE upper(name) = 'UNDO$';
SELECT * FROM PORTS versions BETWEEN TIMESTAMP minvalue AND maxvalue;
SELECT *                                 *
FROM PORTS AS OF TIMESTAMP systimestamp - interval '0 0:01:30' DAY TO SECOND;

-- =============================================================================
-- Chapter 15
-- =============================================================================
-- Go back to chapter 11 approximately line 4296
-- install EXTERNAL TABLE table from c:\tempinvoices.txt
-- convert into invoices_revised with correct data types
DESC invoices_external;

select count(*) from invoices_external;

-- page 561
SELECT COUNT(*)
FROM invoices_revised;

WHERE invoice_date > (add_months(sysdate,-18));
DESC invoices_revised;

SELECT COUNT(*) as "2009"
FROM invoices_revised
WHERE invoice_date >=  to_date('01/01/09','mm/dd/yy')
  AND invoice_date <= to_date('12/31/09','mm/dd/yy');








SELECT COUNT(*) as other
FROM invoices_revised
WHERE invoice_date <  to_date('01/01/09','mm/dd/yy')
  or invoice_date > to_date('12/31/11','mm/dd/yy');
  
  


select
      count(case 
          when invoice_date >=  to_date('01/01/09','mm/dd/yy') and
              invoice_date <= to_date('12/31/09','mm/dd/yy') then 1
          end) as "2009",
      count(case 
          when invoice_date >=  to_date('01/01/10','mm/dd/yy') and
              invoice_date <= to_date('12/31/10','mm/dd/yy') then 1
          end) as "2010",
      count(case 
          when invoice_date >=  to_date('01/01/11','mm/dd/yy') and
              invoice_date <= to_date('12/31/11','mm/dd/yy') then 1
          end) as "2011"
from invoices_revised;


SELECT COUNT(*),
  COUNT(
  CASE
    WHEN invoice_date >= to_date('01/01/09','mm/dd/yy')
    AND invoice_date   < to_date('01/01/10','mm/dd/yy')
    THEN 1
  END) AS nine,
  COUNT(
  CASE
    WHEN invoice_date >= to_date('01/01/10','mm/dd/yy')
    AND invoice_date   < to_date('01/01/11','mm/dd/yy')
    THEN 1
  END) AS ten,
  COUNT(
  CASE
    WHEN invoice_date >= to_date('01/01/11','mm/dd/yy')
    AND invoice_date   < to_date('01/01/12','mm/dd/yy')
    THEN 1
  END) AS eleven
FROM invoices_revised;

SELECT COUNT(*),
  COUNT(CASE WHEN TO_CHAR(invoice_date,'RRRR') < '2010' THEN 1 END) AS Y09
  COUNT(CASE 
        WHEN      TO_CHAR(invoice_date,'RRRR') < '2011'
              AND TO_CHAR(invoice_date,'RRRR') >= '2010'
        THEN 1 END) AS Y10,
  COUNT(CASE 
        WHEN      TO_CHAR(invoice_date,'RRRR') < '2012'
              AND TO_CHAR(invoice_date,'RRRR') >= '2011'
        THEN 1 END) AS Y11
FROM invoices_revised;

-- ----------------------------------------------------------------
-- page 562

CREATE TABLE room_summary AS
SELECT a.ship_id,a.ship_name,b.room_number, b.sq_ft + NVL(b.balcony_sq_ft,0) sq_ft
FROM ships a JOIN ship_cabins b
ON a.ship_id = b.ship_id;

desc room_summary;
desc ships;



SELECT COUNT(*) FROM room_summary;
-- ----------------------------------------------------------------
-- ----------------------------------------------------------------
-- page 563
SELECT *
FROM cruise_customers;
SELECT * FROM employees;
-- ----------------------------------------------------------------
-- page 564 top
SELECT seq_cruise_customer_id.nextval FROM dual;

SELECT MAX(cruise_customer_id) FROM cruise_customers;
DROP sequence seq_cruise_customer_id;
CREATE sequence seq_cruise_customer_id start with 5;

INSERT INTO cruise_customers(cruise_customer_id, first_name, last_name)
    SELECT seq_cruise_customer_id.nextval,emp.first_name,emp.last_name
    FROM employees emp;

SELECT * FROM cruise_customers;
-- ----------------------------------------------------------------
SELECT *
FROM cruise_customers;
-- ----------------------------------------------------------------
-- page 565
SELECT home_port_id, COUNT(ship_id) total,SUM(capacity) capacity
FROM ships
GROUP BY home_port_id
ORDER BY 1;
-- ----------------------------------------------------------------
-- page 566
SELECT * FROM ports;


UPDATE ports p
    SET(tot_ships_assigned,tot_ships_asgn_cap)
          = (SELECT NVL(COUNT(s.ship_id),0) total,NVL(SUM(s.capacity),0) capacity
              FROM ships s
              WHERE s.home_port_id = p.port_id
              GROUP BY home_port_id
            );
            
select * from ships;
SELECT home_port_id,NVL(COUNT(s.ship_id),0) total,NVL(SUM(s.capacity),0) capacity
FROM ships s
GROUP BY home_port_id;
-- ----------------------------------------------------------------
-- page 572
SELECT *
FROM invoices_revised;
DESC invoices_revised;

CREATE TABLE invoices_revised_archive
  (
    invoice_id     NUMBER,
    invoice_date   DATE,
    invoice_amt    NUMBER,
    account_number VARCHAR2(13)
  );
  
CREATE TABLE invoices_revised_archive2
  (
    invoice_id     NUMBER,
    invoice_date   DATE,
    invoice_amt    NUMBER,
    account_number VARCHAR2(13)
  );
-- ----------------------------------------------------------------
-- Insert All
-- page 572
INSERT ALL
INTO invoices_revised_archive(invoice_id,invoice_date,invoice_amt,account_number)
  VALUES(invoice_id,invoice_date,invoice_amt,account_number)
INTO invoices_revised_archive2(invoice_id,invoice_date,invoice_amt,account_number)
  VALUES(invoice_id,invoice_date,invoice_amt,account_number)
SELECT invoice_id,invoice_date,invoice_amt,account_number
FROM invoices_revised;
-- ----------------------------------------------------------------
-- Unconditional multitable insert
-- page 573
INSERT ALL
INTO invoices_revised_archive
  (invoice_id,invoice_date,invoice_amt,account_number)
  VALUES(invoice_id,invoice_date,invoice_amt,account_number)
INTO invoices_revised_archive2
  (invoice_id,invoice_date,invoice_amt,account_number)
  VALUES(invoice_id,invoice_date + 365,invoice_amt,account_number)
SELECT invoice_id,invoice_date,invoice_amt,account_number
FROM invoices_revised;
-- ----------------------------------------------------------------
-- TRUNCATE TABLE invoices_revised_archive2;
-- Page 575
CREATE TABLE invoices_archived2
  (
    invoice_id     NUMBER,
    invoice_date   DATE,
    invoice_amt    NUMBER,
    account_number VARCHAR2(13)
  );
CREATE TABLE invoices_new2
  (
    invoice_id     NUMBER,
    invoice_date   DATE,
    invoice_amt    NUMBER,
    account_number VARCHAR2(13)
  );
--TRUNCATE TABLE invoices_revised_archive;
--TRUNCATE TABLE invoices_revised_archive2;
-- ----------------------------------------------------------------
-- Page 575
SELECT invoice_id,invoice_date,invoice_amt,account_number
FROM invoices_revised
WHERE invoice_date < (add_months(sysdate,-24));
-- ----------------------------------------------------------------
--TRUNCATE TABLE invoices_revised_archive;
--TRUNCATE TABLE invoices_revised_archive2;
-- Conditional multitable insert
truncate table invoices_revised_archive2;



INSERT 
  WHEN (invoice_date > (add_months(sysdate,-24))) 
  THEN
    INTO invoices_revised_archive(invoice_id,invoice_date,invoice_amt,account_number)
      VALUES(invoice_id,invoice_date,invoice_amt,account_number)
  ELSE
    INTO invoices_revised_archive2(invoice_id,invoice_date,invoice_amt,account_number)
      VALUES(invoice_id,invoice_date,invoice_amt,account_number)
SELECT invoice_id,invoice_date,invoice_amt,account_number
FROM invoices_revised;





select count(*) from invoices_revised_archive;
select count(*) from invoices_revised_archive2;





SELECT COUNT(*) FROM invoices_revised_archive2;
SELECT COUNT(*) FROM invoices_revised_archive;
SELECT COUNT(*) FROM invoices_revised_archive;
SELECT COUNT(*) FROM invoices_revised_archive2;
SELECT (SELECT COUNT(*) FROM invoices_archived2) +
       (SELECT COUNT(*) FROM invoices_new2)
FROM dual;

-- page 576 & 577
-- create table invoices_2009
CREATE TABLE invoices_2009
  (
    invoice_id     NUMBER,
    invoice_date   DATE,
    invoice_amt    NUMBER,
    account_number VARCHAR2(13)
  );
CREATE TABLE invoices_2010
  (
    invoice_id     NUMBER,
    invoice_date   DATE,
    invoice_amt    NUMBER,
    account_number VARCHAR2(13)
  );
CREATE TABLE invoices_2011
  (
    invoice_id     NUMBER,
    invoice_date   DATE,
    invoice_amt    NUMBER,
    account_number VARCHAR2(13)
  );
CREATE TABLE invoices_all
  (
    invoice_id     NUMBER PRIMARY KEY,
    invoice_date   DATE,
    invoice_amt    NUMBER,
    account_number VARCHAR2(13 byte)
  );
TRUNCATE TABLE invoices_2009;
TRUNCATE TABLE invoices_2010;
TRUNCATE TABLE invoices_2011;
TRUNCATE TABLE invoices_all;



INSERT FIRST
WHEN (TO_CHAR(invoice_date,'RRRR') <= '2009') THEN
    INTO invoices_2009(invoice_id,invoice_date,invoice_amt,account_number)
      VALUES(invoice_id,invoice_date,invoice_amt,account_number)
    INTO invoices_all(invoice_id,invoice_date,invoice_amt,account_number)
      VALUES(invoice_id,invoice_date,invoice_amt,account_number)
WHEN (TO_CHAR(invoice_date,'RRRR') <= '2010') THEN
    INTO invoices_2010(invoice_id,invoice_date,invoice_amt,account_number)
      VALUES(invoice_id,invoice_date,invoice_amt,account_number)
    INTO invoices_all(invoice_id,invoice_date,invoice_amt,account_number)
      VALUES(invoice_id,invoice_date,invoice_amt,account_number)
WHEN (TO_CHAR(invoice_date,'RRRR') <= '2011') THEN
    INTO invoices_2011(invoice_id,invoice_date,invoice_amt,account_number)
      VALUES(invoice_id,invoice_date,invoice_amt,account_number)
    INTO invoices_all(invoice_id,invoice_date,invoice_amt,account_number)
      VALUES(invoice_id,invoice_date,invoice_amt,account_number)
SELECT invoice_id,invoice_date,invoice_amt,account_number
FROM invoices_revised;

SELECT COUNT(*) FROM invoices_all;
-- -----------------------------------------------------------------------------
-- page 579
INSERT WHEN (boss_salary - employee_salary < 79000) THEN
INTO salary_chart(emp_title,superior,emp_income,sup_income)
  VALUES(employee,boss,employee_salary,boss_salary )
SELECT a.position employee,b.position boss,a.max_salary employee_salary,b.max_salary boss_salary
FROM positions a
JOIN positions b
ON a.reports_to    = b.position_id
WHERE a.max_salary > 79000;

SELECT * FROM salary_chart;
COMMIT;
-- page 580
-- Send this to students
CREATE TABLE ship_cabin_grid
  (
    room_type VARCHAR2(20) ,
    ocean     NUMBER ,
    balcony   NUMBER ,
    no_window NUMBER
  );
BEGIN
  INSERT INTO ship_cabin_grid VALUES('ROYAL', 1745,1635, NULL);
  INSERT INTO ship_cabin_grid VALUES('SKYLOFT', 722,72235, NULL);
  INSERT INTO ship_cabin_grid VALUES('PRESIDENTIAL', 1142,1142, 1142);
  INSERT INTO ship_cabin_grid VALUES('LARGE', 225,NULL, 211);
  INSERT INTO ship_cabin_grid VALUES('STANDARD', 217,554, 586);
END;
/
TRUNCATE TABLE ship_cabin_grid;

INSERT FIRST
  WHEN ocean IS NOT NULL THEN
INTO ship_cabin_statistics (room_type,window_type,sq_ft)
  VALUES(room_type,'OCEAN',ocean)
  WHEN balcony IS NOT NULL THEN
INTO ship_cabin_statistics(room_type,window_type,sq_ft)
  VALUES(room_type,'BALCONY',balcony)
  WHEN no_window IS NOT NULL THEN
INTO ship_cabin_statistics(room_type,window_type,sq_ft)
  VALUES(room_type,'NO WINDOW',no_window)
SELECT rownum rn, room_type, ocean, balcony, no_window FROM ship_cabin_grid;

-- ----------------------------------------------------------------------------
INSERT ALL
  WHEN ocean IS NOT NULL THEN
INTO ship_cabin_statistics(room_type,window_type,sq_ft)
  VALUES(room_type,'OCEAN',ocean)
  WHEN balcony IS NOT NULL THEN
INTO ship_cabin_statistics(room_type,window_type,sq_ft)
  VALUES(room_type,'BALCONY',balcony)
  WHEN no_window IS NOT NULL THEN
INTO ship_cabin_statistics
  (room_type,window_type,sq_ft)
  VALUES
  (room_type,'NO WINDOW',no_window)
SELECT rownum rn, room_type, ocean, balcony, no_window FROM ship_cabin_grid;
-- ----------------------------------------------------------------------------
-- page 586
merge INTO wwa_invoices wwa USING ontario_orders ont ON (wwa.cust_po = ont.po_num)
WHEN matched THEN
  UPDATE SET wwa.notes = ont.sales_rep
  DELETE WHERE wwa.inv_date < to_date('01-SEP-09') 
WHEN NOT matched THEN
  INSERT(wwa.inv_id,wwa.cust_po,wwa.inv_date,wwa.notes)
    VALUES(seq_inv_id.nextval,ont.po_num,sysdate,ont.sales_rep)
WHERE SUBSTR(ont.po_num,1,3)<> 'NBC';

rollback;
select * from wwa_invoices;
select * from ontario_orders;
desc wwa_invoices;
desc ontario_orders;


-- ----------------------------------------------------------------------------
-- FLASHBACK QUERIES
-- ----------------------------------------------------------------------------
-- setup the table for testing
-- page 589
COMMIT;
DROP TABLE chat;
CREATE TABLE chat
  (
    chat_id   NUMBER(11) PRIMARY KEY,
    chat_user VARCHAR2(9),
    yacking   VARCHAR2(40)
  );
DROP sequence seq_chat_id;
  
CREATE sequence seq_chat_id;
  BEGIN
    INSERT INTO chat VALUES(seq_chat_id.nextval,USER, 'Hi there.');
    INSERT INTO chat VALUES(seq_chat_id.nextval,USER,'Welcome to our chat room.');
    INSERT INTO chat VALUES(seq_chat_id.nextval,USER,'Online order form is up.');
    INSERT INTO chat VALUES(seq_chat_id.nextval, USER, 'Over and out.');
    COMMIT;
  END;
  /
SELECT * FROM chat;
-- ----------------------------------------------------------------------------
-- page 589
SELECT chat_id,ora_rowscn,scn_to_timestamp(ora_rowscn)
FROM chat;
desc flashback_transaction_query;



-- ----------------------------------------------------------------------------
-- page 590
-- wait for 2 minutes;
EXECUTE DBMS_LOCK.SLEEP(120);
SELECT * FROM chat;
DELETE FROM chat;
COMMIT;
SELECT * FROM chat;

select versions_xid
from chat
versions between timestamp minvalue and maxvalue;

-- ----------------------------------------------------------------------------
-- page 590
-- FLASHBACK QUERY
-- See older data
SELECT chat_id,chat_user,yacking FROM chat AS OF TIMESTAMP systimestamp - interval '0 0:01:30' DAY TO second;
--Keep doing this until it shows up empty (1.5 minutes)
-- page 591
--Maybe have to do as system
SELECT name,value FROM v$system_parameter
WHERE name LIKE ('undo%');
-- page 595
-- FLASHBACK VERSIONS QUERY
SELECT chat_id,versions_startscn,versions_endscn,versions_operation
FROM chat versions BETWEEN TIMESTAMP minvalue AND maxvalue
ORDER BY chat_id,versions_operation DESC;
-- ----------------------------------------------------------------------------
--page 596
-- OTHER PSUEDO COLUMNS
SELECT chat_id,
  versions_startscn,
  versions_endscn,
  versions_operation
FROM chat versions BETWEEN TIMESTAMP minvalue AND maxvalue AS OF TIMESTAMP systimestamp - interval '0 00:1:30' DAY TO second
ORDER BY chat_id,versions_operation DESC;
-- ----------------------------------------------------------------------------
-- page 598 middle
-- FLASHBACK TRANSACTION QUERY
SELECT chat_id,versions_operation,rawtohex(versions_xid)
FROM chat versions BETWEEN TIMESTAMP minvalue AND maxvalue
WHERE chat_id BETWEEN 1 AND 50
ORDER BY versions_operation DESC;
-- ----------------------------------------------------------------------------
SELECT *
FROM chat;
DELETE chat;
-- page 598 bottom
SELECT undo_sql
FROM flashback_transaction_query
WHERE xid IN
  (SELECT versions_xid
  FROM chat versions BETWEEN TIMESTAMP minvalue AND maxvalue
  WHERE chat_id BETWEEN 1 AND 50
  AND versions_operation = 'D'
  );
  
-- =============================================================================
-- Chapter 16
-- =============================================================================
SELECT *
FROM employee_chart;
select * from files;


-- page 622
-- -----------------------------------------------------------------------------
-- TOP DOWN
-- Connect by "Prior Low to High"
-- Top to bottom
-- ------------------------------------
SELECT level, employee_id,title
FROM employee_chart
START WITH employee_id       = 1
CONNECT BY prior employee_id = reports_to;
-- -----------------------------------------------------------------------------
-- TOP DOWN
-- Connect by "High to Prior Low"
-- Top to bottom
-- ------------------------------------
SELECT level, employee_id, title
FROM employee_chart
  START WITH employee_id = 1
  CONNECT BY reports_to  = prior employee_id;
select * from employee_chart;
  
SELECT level, employee_id, title
FROM employee_chart
  START WITH employee_id = 9
  CONNECT BY prior reports_to  = employee_id;


 
 
  
-- ------------------------------------
-- BOTTOM UP
-- Connect by "Prior High to Low"
-- Bottom to Top
-- ------------------------------------
SELECT level,
  employee_id,
  title
FROM employee_chart
  START WITH employee_id      = 5
  CONNECT BY prior reports_to = employee_id;
  
select * from employee_chart;  
  
  
  
  
  
  
  
  
  
  
  
-- ------------------------------------
-- BOTTOM UP
-- Connect by "Low to Prior High"
-- Bottom to Top
-- ------------------------------------
SELECT level,
  employee_id,
  title
FROM employee_chart
  START WITH employee_id = 5
  CONNECT BY employee_id = prior reports_to;

-- prior low to high is top to bottom 
  
  
-- --------------------------------------------------
-- WHAT IS THIS TOP TO BOTTOM or BOTTOM TO TOP
-- --------------------------------------------------


SELECT level,
  employee_id,
  title
FROM employee_chart
  START WITH employee_id = 1
  -- or 9
  CONNECT BY prior reports_to = employee_id;
  
  
-- --------------------------------------------------------------------------
-- PAGE 621
-- TREE STRUCTURED REPORT
-- DOES THIS SHOW REPORTS IN CORRECT LINEAGE
-- --------------------------------------------------------------------------
SELECT level, reports_to, employee_id, LPAD(' ', Level*2) || title title_up
FROM employee_chart
  START WITH employee_id = 1
  CONNECT BY reports_to  = prior employee_id;



-- PAGE 623 Exam watch
SELECT level,
  prior employee_id,
  employee_id
FROM employee_chart
  START WITH employee_id       = 1
  CONNECT BY prior employee_id = reports_to;
-- --------------------------------------------------------------------------
-- page 624
-- THIS SHOWS REPORTS IN CORRECT LINEAGE
-- --------------------------------------------------------------------------
SELECT level, reports_to, employee_id, LPAD(' ', Level*2) || title title_up
FROM employee_chart
  START WITH employee_id = 1
  CONNECT BY reports_to  = prior employee_id
ORDER SIBLINGS BY title;
-- --------------------------------------------------
-- page 625 top
-- SYS_CONNECT_BY_PATH Function
-- --------------------------------------------------
SELECT level, employee_id, sys_connect_by_path(title,'/') title
FROM employee_chart
  START WITH employee_id = 1
  CONNECT BY reports_to  = prior employee_id;
-- --------------------------------------------------
-- page 625 bottom
-- CONNECT_BY_ROOT Operator
-- --------------------------------------------------
SELECT level,employee_id, title, connect_by_root title AS root_ancestor
FROM employee_chart
  START WITH employee_id = 1
  CONNECT BY reports_to  = prior employee_id;
  
select * FROM employee_chart;  
  
-- --------------------------------------------------
-- page 626 bottom
-- EXCLUDE BRANCHES
-- Look at query first without exclusion
-- --------------------------------------------------
SELECT level, employee_id,LPAD(' ', Level*2) || title title
FROM employee_chart
  START WITH employee_id = 1
  CONNECT BY reports_to  = prior employee_id
AND employee_id         <> 2;

select * from employee_chart;


-- --------------------------------------------------
SELECT level, employee_id, lpad(' ', level*2) || title title
FROM employee_chart
WHERE employee_id NOT   IN (2,4)
  START WITH employee_id = 1
  CONNECT BY reports_to  = prior employee_id
AND employee_id         <> 3;


select * from employee_chart;
-- page 627 top
SELECT level,employee_id,LPAD(' ', Level*2)||title title
FROM employee_chart
where title <> 'SVP'
  START WITH employee_id = 1
  CONNECT BY reports_to  = prior employee_id
AND title                <> 'Director 2';

SELECT level,employee_id,sys_connect_by_path(title, '/') title
FROM employee_chart
where title <> 'SVP'
  START WITH employee_id = 1
  CONNECT BY reports_to  = prior employee_id
AND title                <> 'Director 2';
select * FROM employee_chart;


-- page 627 bottom


SELECT level, employee_id, LPAD(' ', Level*2) || title title
FROM employee_chart
WHERE employee_id IN  (SELECT employee_id FROM employees2 )
  START WITH employee_id = 1
  CONNECT BY reports_to  = prior employee_id
AND title               <> 'SVP';


-- -----------------------------------------------------------------------------
-- HANDS ON EXERCISES 16
-- -----------------------------------------------------------------------------
SELECT * FROM jobs2;
SELECT * FROM directories;
SELECT * FROM files;
-- -----------------------------------------------------------------------------
-- 1.
-- What is the root directory for job_id = 104;
-- -----------------------------------------------------------------------------
SELECT *
FROM jobs2
WHERE job_id = 104;
SELECT * FROM directories WHERE job_id = 104 AND directory_name = 'BMS';
SELECT MIN(directory_id) FROM directories WHERE job_id = 104;
-- -----------------------------------------------------------------------------
-- 2.
-- Create simple hierarchical listing of directories without padding
-- or formatting for job 104 with root of 11631
select * from jobs2 where job_id = 104;

select directory_id, directory_name, parent_id
from directories
start with directory_id = 11631
connect by parent_id = prior directory_id;

select directory_id, directory_name, parent_id
from directories
start with directory_id = 11631
connect by prior directory_id = parent_id;

select * from directories
where directory_id >= 11631 and directory_id <= 11637 order by 3;

select directory_id, directory_name, parent_id
from directories
start with directory_id = 11632
connect by  parent_id = prior directory_id;


select directory_id, directory_name, parent_id 
from directories where directory_id = 11632
UNION
select directory_id, directory_name, parent_id 
from directories where parent_id = 11632;



SELECT directory_id,
  parent_id,
  directory_name
FROM directories
  START WITH directory_id       = 11631
  CONNECT BY prior directory_id = parent_id;
-- -----------------------------------------------------------------------------
SELECT level,
  directory_id,
  directory_name
FROM directories
  START WITH directory_id = 11631
  CONNECT BY prior parent_id    =  directory_id ;
-- -----------------------------------------------------------------------------
-- 3.
-- Next create hierarchical listing of directories with padding
-- to show the levels of the directories for job 104 with root of 11631
-- -----------------------------------------------------------------------------
SELECT level, directory_id, LPAD(' ', Level*2) || directory_name directory
FROM directories
  START WITH directory_id =
  (SELECT MIN(directory_id) FROM directories WHERE job_id = 104
  )
  CONNECT BY parent_id = prior directory_id
ORDER SIBLINGS BY directory_name;
-- -----------------------------------------------------------------------------
-- 4.
-- Show the path for each directory using the "/"
-- Add LPAD formatting to show the levels
-- -----------------------------------------------------------------------------
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
SELECT level,
  directory_id,
  parent_id,
  sys_connect_by_path(directory_name,'/') directory
FROM directories
  START WITH directory_id =
  (SELECT MIN(directory_id) FROM directories WHERE job_id = 104
  )
  CONNECT BY parent_id = prior directory_id;
SELECT directory_id, f2 AS filename FROM files;
-- -----------------------------------------------------------------------------
-- 5.
-- List all files under directory 
-- /GPS/PDMT_Configs/Configuration in job 104
-- -----------------------------------------------------------------------------
SELECT level, job_id, directory_id, 
              sys_connect_by_path(directory_name,'/') directory
FROM directories
  START WITH directory_id =
  (SELECT MIN(directory_id) FROM directories WHERE job_id = 104
  )
  CONNECT BY parent_id = prior directory_id;
  
  
  
  
  
  
SELECT d.directory,
  '  /'
  ||f2
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
WHERE d.directory  = '/GPS/PDMT_Configs/Configuration'
AND d.job_id       = f.job_id
AND d.directory_id = f.directory_id;
-- -----------------------------------------------------------------------------
-- 6.
-- Which directory id has the most files in it
-- -----------------------------------------------------------------------------
SELECT d.directory_id,
  d.directory_name,
  COUNT(f.f1)
FROM files f,
  directories d
WHERE f.job_id     = d.job_id
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
  CONNECT BY parent_id    = prior directory_id;





-- just directories over this one
-- Backwards 11719 job_id = 104

select job_id from directories where directory_id = 11719;

select parent_id, directory_id, directory_name
-- sys_connect_by_path(directory_name,'/')  
from directories
start with directory_id = 11719
connect by directory_id  = prior parent_id;


; 

-- just directories over this one
-- Backwards 11719 job_id = 104










SELECT directory_id
FROM
  (SELECT level lvl,
    directory_id,
    LPAD(' ', Level*2)
    || sys_connect_by_path(directory_name,'<') directory
  FROM directories
    START WITH directory_id    = 11719
    CONNECT BY prior parent_id = directory_id
  );
-- Forwards with set placed manually
SELECT level,
  directory_id,
  LPAD(' ', Level*2)
  || sys_connect_by_path(directory_name,'/') directory
FROM directories
  START WITH directory_id = 11631
  CONNECT BY parent_id    = prior directory_id
AND directory_id         IN (11631, 11712, 11719);
-- Forwards with set placed manually where clause level 3
SELECT level,
  directory_id,
  LPAD(' ', Level*2)
  || sys_connect_by_path(directory_name,'/') directory
FROM directories
WHERE directory_id       IN (11631, 11712, 11719)
AND level                 = 3
  START WITH directory_id = 11631
  CONNECT BY parent_id    = prior directory_id;
-- solution
SELECT level,
  directory_id,
  lpad(' ', level*2)
  || sys_connect_by_path(directory_name,'/') directory
FROM directories
WHERE directory_id IN (11631, 11712, 11719)
AND level           =
  (SELECT MAX(lvlv)
  FROM
    (SELECT level lvlv,
      sys_connect_by_path(directory_name,'/') directory
    FROM directories
    WHERE directory_id       IN (11631, 11712, 11719)
      START WITH directory_id = 11631
      CONNECT BY parent_id    = prior directory_id
    )
  )
  START WITH directory_id = 11631
  CONNECT BY parent_id    = prior directory_id;
SELECT lvl1,
  directory
FROM
  (SELECT level lvl1,
    directory_id,
    LPAD(' ', Level*2)
    || sys_connect_by_path(directory_name,'/') directory
  FROM directories
    START WITH directory_id = 11631
    CONNECT BY parent_id    = prior directory_id
  AND directory_id         IN (11631, 11712, 11719)
  ) a,
  (SELECT MAX(lvl2) maxlvl2
  FROM
    (SELECT level lvl2,
      directory_id,
      LPAD(' ', Level*2)
      || sys_connect_by_path(directory_name,'/') directory
    FROM directories
      START WITH directory_id = 11631
      CONNECT BY parent_id    = prior directory_id
    AND directory_id         IN (11631, 11712, 11719)
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
  CONNECT BY parent_id    = prior directory_id
AND directory_id         IN
  (SELECT directory_id
  FROM
    (SELECT directory_id
    FROM directories
      START WITH directory_id    = 11719
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
    CONNECT BY parent_id    = prior directory_id
  AND directory_id         IN
    (SELECT directory_id
    FROM
      (SELECT directory_id
      FROM directories
        START WITH directory_id    = 11719
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
      CONNECT BY parent_id    = prior directory_id
    AND directory_id         IN
      (SELECT directory_id
      FROM
        (SELECT directory_id
        FROM directories
          START WITH directory_id    = 11719
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
SELECT park_name
FROM park
WHERE park_name LIKE '%State Park%';

-- --------------------------------------------------------
-- regexp_like more powerful (anyplace in column)
-- Use regexp_substr to see what regexp_like is hitting on
-- first without regexp_like
-- --------------------------------------------------------
SELECT park_name, regexp_substr(park_name, 'State Park')
FROM park;
-- --------------------------------------------------------
-- Next with regexp_like
-- --------------------------------------------------------
SELECT park_name,regexp_substr(park_name, 'State Park')
FROM park
WHERE regexp_like(park_name, 'State Park');
-- ------------------------------------------------
-- lets see if we can find phone numbers
SELECT park_name,
  description,
  regexp_substr(description, '...-....')
FROM PARK
WHERE regexp_like(description, '...-....');
-- ------------------------------------------------
SELECT park_name,
  regexp_substr(description, '.{3}-.{4}')
FROM park
WHERE regexp_like(description, '.{3}-.{4}');
-- ------------------------------------------------
-- See false positives
SELECT description,
  regexp_substr(description, '...-....')
FROM park
WHERE regexp_like(description, '...-....')
AND (park_name LIKE '%Mus%'
OR park_name LIKE '%bofj%');
-- ------------------------------------------------
-- zoom in on false positives
SELECT regexp_substr(description, '...-....'),
  park_name
FROM park
WHERE regexp_like(description, '...-....')
AND (park_name LIKE '%Mus%'
OR park_name LIKE '%bofj%');
-- ------------------------------------------------
-- a list of characters
SELECT park_name,
  regexp_substr(description,'[0123456789]{3}-[0123456789]{4}')
FROM park
WHERE regexp_like(description,'[0123456789]{3}-[0123456789]{4}');


-- ------------------------------------------------
-- a range of characters
SELECT park_name,
  regexp_substr(description, '[0-9]{3}-[0-9]{4}')
FROM park
WHERE regexp_like(description, '[0-9]{3}-[0-9]{4}');



-- ------------------------------------------------
-- regexp_count
-- ------------------------------------------------
SELECT regexp_count('The shells she sells are surely seashells', 'el') AS regexp_count
FROM dual;

select regexp_substr('123456789-2345', '[0-9]{3}-[0-9]{4}') from dual;
select regexp_substr('123456789-2345-5678', '[0-9]{3}-[0-9]{4}') from dual;


-- ------------------------------------------------
-- a character class
-- ------------------------------------------------
SELECT park_name,
  regexp_substr(description, '[[:digit:]]{3}-[[:digit:]]{4}')
FROM park
WHERE regexp_like(description, '[[:digit:]]{3}-[[:digit:]]{4}');
-- ------------------------------------------------
-- caret ^ is the "NOT" operator
-- so this says anything that is NOT a digit
-- ------------------------------------------------
SELECT park_name,
  regexp_substr(description, '[[:digit:]]{3}[^[:digit:]][[:digit:]]{4}') as myName
FROM park
WHERE regexp_like(description, '[[:digit:]]{3}[^[:digit:]][[:digit:]]{4}');
-- ------------------------------------------------
-- escape character "\" if we want to find a period and not have the period
-- represent any character but instead a period
-- this finds phone numbers that have either a period separating the groups
SELECT park_name,
  regexp_substr(description, '[[:digit:]]{3}\.[[:digit:]]{4}')
FROM park
WHERE regexp_like(description, '[[:digit:]]{3}\.[[:digit:]]{4}');
-- ------------------------------------------------
-- subexpresssions show how quantifiers can be used in multiple places
SELECT park_name,
  regexp_substr(description, '\+([0-9]{1,3} ){1,4}([0-9]+) ' ) INTL_PHONE
FROM park
WHERE regexp_like(description, '\+([0-9]{1,3} ){1,4}([0-9]+) ');


select regexp_substr('+46 8 698 10 234565', '\+([0-9]{1,3} ){1,4}[0-9]+') from dual;

select regexp_substr('+46 8 698 10 00', '\+([0-9]{1,3} ){1,4}[0-9]+') from dual;

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
FROM park
WHERE regexp_like(description,'[[:digit:]]{3}(-|\.)[[:digit:]]{4}');




SELECT park_name,
  regexp_substr(description,'[0-9]{3}(-|\.)[0-9]{4}')
FROM park
WHERE regexp_like(description,'[0-9]{3}(-|\.)[0-9]{4}');

SELECT park_name,
  regexp_substr(description,'[0-9]{3} [0-9]{4}')
FROM park
WHERE regexp_like(description,'[0-9]{3} [0-9]{4}');

select * from park;
insert into park values ('ABC',null,'US','234 4567');
commit;


SELECT park_name,
  regexp_substr(description,'[0-9]{3}(-|\.|\ )[0-9]{4}')
FROM park
WHERE regexp_like(description,'[0-9]{3}(-|\.|\ )[0-9]{4}');

SELECT park_name,
  regexp_substr(description,'[0-9]{3}( |-|\.)[0-9]{4}')
FROM park
WHERE regexp_like(description,'[0-9]{3}( |-|\.)[0-9]{4}');






-- ------------------------------------------------
-- this is area code with () or dashes or periods
SELECT park_name,
  regexp_substr (description, 
  '([[:digit:]]{3}[-. ]|\([[:digit:]]{3}\) )[[:digit:]]{3}[.-.][[:digit:]]{4}') park_phone
FROM park
WHERE regexp_like (description, 
'([[:digit:]]{3}[-. ]|\([[:digit:]]{3}\) )[[:digit:]]{3}[.-.][[:digit:]]{4}');

SELECT regexp_substr ('906.-.3456','[.-.]') from dual;
 
-- simple example of back reference \2
-- back reference says match what has already been matched
-- by the numbered subexpression
select regexp_substr('she sells sea shells by the seashore',
          'she sells ([[:alpha:]]+) shells by the \1shore')
from dual;

select regexp_substr('she sells sea shells by the seashore',
                     '(she sells )([[:alpha:]]+) shells by the \2shore')
from dual;


-- ------------------------------------------------
----- send above to students
-- duplicates references
-- the ^ here is the begining of the line
-- not a character at teh beginning but <bol>
SELECT park_name,
  regexp_substr(description, '(^|[[:space:][:punct:]]+)([[:alpha:]]+)'
  || '[[:space:][:punct:]]+\2'
  || '($|[[:space:][:punct:]]+)') hello
FROM park
WHERE regexp_like(description, '(^|[[:space:][:punct:]]+)([[:alpha:]]+)'
  || '[[:space:][:punct:]]+\2'
  || '($|[[:space:][:punct:]]+)');


SELECT park_name,
  regexp_substr(description, '(^|[[:space:][:punct:]]+)([[:alpha:]]+)'
  || '[[:space:][:punct:]]+\1'
  || '($|[[:space:][:punct:]]+)') double_words
FROM park
WHERE regexp_like(description, '(^|[[:space:][:punct:]]+)([[:alpha:]]+)'
  || '[[:space:][:punct:]]+\1'
  || '($|[[:space:][:punct:]]+)');


SELECT regexp_substr(',the ,','(^|[[:space:][:punct:]]+)([[:alpha:]]+)'
  || '[[:space:]]\1')
FROM dual;

SELECT regexp_substr(',the  ','(^|[[:space:][:punct:]]+)([[:alpha:]]+)([[:space:]])\3')
FROM dual;

SELECT regexp_substr('!the !','(^|[[:space:][:punct:]]+)([[:alpha:]]+)'
  || '[[:space:][:punct:]]+\1')
FROM dual;


-- START HERE
-- -----------------------------------------------------------------------------
-- REGEX_LIKE
-- find records that have invoice dates between 2010 and 2011
SELECT invoice_id,
  invoice_date,
  TO_CHAR(invoice_date,'YYYY'),
  regexp_substr(TO_CHAR(invoice_date,'YYYY'),'^201[0-1]$')
FROM invoices_revised
WHERE regexp_like (TO_CHAR(INVOICE_DATE,'YYYY'),'^201[0-1]$');






SELECT invoice_id,
  invoice_date,
  TO_CHAR(invoice_date,'YYYY'),
  regexp_substr (TO_CHAR(INVOICE_DATE,'YYYY'), '^20[0-1]|(09)$')
FROM invoices_revised
WHERE regexp_like (TO_CHAR(INVOICE_DATE,'YYYY'), '^20[0-1]|(09)$');

SELECT invoice_id,
  invoice_date,
  TO_CHAR(invoice_date,'YYYY'),
  regexp_substr (TO_CHAR(INVOICE_DATE,'YYYY'), '^20([0-1]+|09)$')
FROM invoices_revised
WHERE regexp_like (TO_CHAR(INVOICE_DATE,'YYYY'), '^20([0-1]+|09)$');




SELECT invoice_id,
  invoice_date,
  TO_CHAR(invoice_date,'YYYY')
FROM invoices_revised
WHERE regexp_like (TO_CHAR(INVOICE_DATE,'YYYY'), '^20(10)|(11)|(09)$');

SELECT invoice_id,
  invoice_date,
  TO_CHAR(invoice_date,'YYYY')
FROM invoices_revised
WHERE regexp_like (TO_CHAR(INVOICE_DATE,'YYYY'), '^20(1[0-1])|(09)$');


SELECT invoice_id,
  invoice_date,
  TO_CHAR(invoice_date,'YYYY')
FROM invoices_revised
WHERE regexp_like (TO_CHAR(invoice_date,'YYYY'), '^20(1[0-1])|(09)$')
AND invoice_id = 1120;

UPDATE invoices_revised
SET invoice_date = '08-NOV-09'
WHERE invoice_id = 1120;

COMMIT;
-- ------------------------------------------------
-- find records where first name is J ignore the case
SELECT *
FROM employees;
-- ------------------------------------------------

SELECT *
FROM employees
WHERE regexp_like(first_name, '^j','i');

SELECT * FROM employees WHERE regexp_like(first_name, '^(J|j)');




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
SELECT regexp_instr('But, soft! What light through yonder window breaks?' ,
                    'o[[:alpha:]]{1,2}', 1, 3) AS result,
       regexp_substr('But, soft! What light through yonder window breaks?' ,
                    'o[[:alpha:]]{1,2}', 1, 3) AS result
FROM dual;
-- ------------------------------------------------
-- return the location of the second "soft"
SELECT regexp_instr('But, soft! What light through yonder window softly breaks?' , 's[[:alpha:]]{3}', 1, 2) AS result
FROM dual;
SELECT regexp_instr('But, soft! What light through yonder window softly breaks?' , 's[[:punct:]]') AS result
FROM dual;
SELECT regexp_instr('But, soft! What light through yonder window softly breaks?' , '[[:alpha:]]s') AS result
FROM dual;
SELECT regexp_instr('But, soft! What light through yonder window softly breaks?' ,'[[:alpha:]]s{1,2}') AS result
FROM dual;
SELECT regexp_instr('But, soft! What light through yonder window softly breaks?' ,'o',1,3,1,'i') AS result
FROM dual;
-- ------------------------------------------------
-- start at position 10 then return location of the second occurance of "o"
SELECT 
regexp_substr ('But, soft! What light through yonder window breaks?' ,'o{1,}', 10, 2),
regexp_instr ('But, soft! What light through yonder window breaks?' ,'o', 10, 2) AS result
FROM dual;
-- ------------------------------------------------
-- return location of "Tele"
SELECT file_id,
  f8,
  regexp_instr(f8, 'Tele[[:alpha:]]+',1,1,0,'i') place
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
-- ---------------------------------------------------------------------------
-- replace the word "light" with "sound"
SELECT regexp_replace('But, soft! What light through yonder window breaks?' ,'l[[:alpha:]]{4}', 'sound') AS result
FROM dual;
-- ------------------------------------------------
-- replace Telepresence with TelePresence
SELECT REGEXP_SUBSTR(F8, 'Tele[[:alpha:]]+',1,1,'i'),
  REGEXP_replace(F8, 'Tele[[:alpha:]]+','TelePresence'),
  f8
FROM FILES
WHERE UPPER(F8) LIKE '%TELEPR%';
-- Replace "UCS" with "UCS-"
SELECT regexp_substr(f8, 'UC[[:alpha:]]+',1,1,'i'),
  regexp_replace(f8, 'UCS[[:alpha:] ]','UCS-'),
  f8
FROM files
WHERE upper(f8) LIKE '%UCS%';
-- -----------------------------------------------------------------------------
-- BOOK
-- ------------------------------------------------
-- page 645
SELECT regexp_substr('123 Maple Avenue', '[a-z]') address
FROM dual;
SELECT regexp_instr('123 Maple Avenue', '[A-Z]') address FROM dual;
-- ------------------------------------------------
-- page 646 top
SELECT regexp_substr('123 Maple Avenue', '[A-Za-z]', 1, 2) address
FROM dual;
-- ------------------------------------------------
-- page 646 middle
SELECT regexp_substr('123 Maple Avenue this is a long sentence' , '[ a-zA-Z]+') address
FROM dual;

-- ------------------------------------------------
-- page 646 bottom
SELECT regexp_substr('123 Maple Avenue', '[ [:alpha:]]+') address
FROM dual;
-- ------------------------------------------------
-- page 647 top
SELECT regexp_substr('123 Maple Avenue', '[:alpha:]+') address
FROM dual;
-- ------------------------------------------------
-- page 647 bottom
SELECT regexp_substr('123 Maple Avenue street ', '[[:alpha:]]+',1,2) address
FROM dual;
-- ------------------------------------------------
-- page 648 top
SELECT regexp_substr('123 Maple Avenue', '[[:alnum:] ]+') address
FROM dual;



SELECT regexp_substr('123 Maple Avenue Street!', '[[:alnum:] ]+',5,1) address
FROM dual;



-- ------------------------------------------------
-- page 648 middle
SELECT address2,
  regexp_substr(address2,'[[:digit:]]+') zip_code
FROM order_addresses;

select address2 from order_addresses;
select street_address, zip from addresses;
SELECT street_address || ' ' || zip FROM addresses;

-- ---------------------------------------------------------------------------
SELECT street_address, zip,
      regexp_substr(street_address ||  ' ' || zip,'[[:digit:]]{5}$') 
FROM addresses;
-- ---------------------------------------------------------------------------
-- ------------------------------------------------
-- page 648 bottom
SELECT regexp_substr('123 Maple Avenue', 'Maple') address
FROM dual;


SELECT regexp_instr('123 Maple Avenue', 'Maple') address FROM dual;



-- ------------------------------------------------
-- page 649 top
SELECT regexp_substr('she sells sea shells down by the seashore' ,'s[eashor]+e',1,2) ,
       regexp_instr('she sells sea shells down by the seashore' ,'s[eashor]+e',1,2) 
FROM dual;
-- ------------------------------------------------
-- page 649 middle
SELECT regexp_substr('she sells sea shells down by the seashore' ,'s(eashor)e' ) the_result
FROM DUAL;
-- ------------------------------------------------
-- page 649 bottom 1
SELECT regexp_substr('she sells sea shells down by the seashore' ,'seashore' ) the_result
FROM dual;

-- ------------------------------------------------
-- page 649 bottom 2
SELECT regexp_substr('she sells sea shells down by the seashore' ,'[[:alpha:]](shore)' ) the_result
FROM dual;

SELECT regexp_substr('she sells sea shells down by the seashore' ,'[[:alpha:]]*' ) the_result
FROM dual;

SELECT regexp_substr('she sells sea shells down by the seashore' ,'sh*e',1,2 ) the_result,
      regexp_instr('she sells sea shells down by the seashore' ,'sh*e',1,2 ) the_result
FROM dual;
-- ------------------------------------------------
-- page 650 middle
SELECT ADDRESS2,
  REGEXP_SUBSTR(ADDRESS2,'(TN|MD|OK)') RESULT
FROM order_addresses;

SELECT ADDRESS2,
  REGEXP_SUBSTR(ADDRESS2,' [A-Z]{2} ') RESULT
FROM order_addresses;

-- ------------------------------------------------
SELECT address2,
  regexp_substr(address2,'[TX|TN|MD|OK]') state
FROM ORDER_ADDRESSES
WHERE regexp_like(address2,'[TX|TN|MD|OK]');
-- ------------------------------------------------


-- page 650 bottom
SELECT regexp_substr('Help desk: (212) 555-1212', '([[:digit:]]+)') area_code
FROM dual;



SELECT regexp_substr('Help desk: (212) 555-1212', '\([[:digit:]]{3}\)') area_code
FROM dual;





-- ------------------------------------------------
-- page 651 top
SELECT regexp_substr('Help desk: (212) 555-1212', '\([[:digit:]]+\)') area_code
FROM dual;
-- ------------------------------------------------
-- page 651 middle
SELECT ADDRESS2,
  regexp_substr(address2,'[TBH][[:alpha:]]+') name
FROM ORDER_ADDRESSES
WHERE regexp_like(address2,'[TBH][[:alpha:]]+') ;



SELECT address2 FROM order_addresses;
-- ------------------------------------------------
SELECT address2,
  regexp_substr(address2,'[TBH][[:alpha:]]+') name
FROM order_addresses
WHERE regexp_like(address2,'[TBH][[:alpha:]]+') ;
-- ------------------------------------------------
-- page 652 top
SELECT regexp_substr('BMW-Oracle;Trimaran;February 2010', '[^;]+', 1, 2) americas_cup
FROM dual;
-- ------------------------------------------------
-- page 652 middle
SELECT address2,
  regexp_substr(address2,'[37]+$') something
FROM order_addresses
WHERE regexp_like(address2,'[37]+$');




SELECT address2,
  regexp_substr(address2,'7$') 
FROM ORDER_ADDRESSES
WHERE regexp_like(address2,'7$');

-- ------------------------------------------------
SELECT address2,
  REGEXP_SUBSTR(ADDRESS2,'[59]+$')
FROM order_addresses
WHERE regexp_like(address2,'[59]+$') ;
-- ------------------------------------------------
-- page 653 top
SELECT address2,
  regexp_substr(address2,'83$') last_digit
FROM ORDER_ADDRESSES
WHERE regexp_like(address2,'83$') ;
SELECT ADDRESS2,
  regexp_substr(address2,'(83|78|1|2|45)?$') last_digit
FROM ORDER_ADDRESSES
WHERE regexp_like(address2,'(83|78|1|2|45)?$');
SELECT ADDRESS2,
  regexp_substr(address2,'(0)[0-9]{4}$') last_digit
FROM ORDER_ADDRESSES
WHERE regexp_like(address2,'(0)[0-9]{4}?$');
-- ------------------------------------------------
-- page 654 top
SELECT regexp_replace('Chapter 1 ......................... I Am Born','[e]+','-') toc
FROM dual;

SELECT regexp_replace('Chapter 1 ......................... I Am Born','.+','-') toc
FROM dual;



SELECT REGEXP_REPLACE('Chapter 1 ......................... I Am Born','[.]','-') TOC
FROM dual;

SELECT regexp_replace('C','[e]*','-') toc FROM dual;

SELECT regexp_replace(' ','[e]*','-') toc FROM dual;
-- ------------------------------------------------
SELECT regexp_replace('Chapter 1 ......................... I Am Born','[.]','-') toc
FROM dual;
-- ------------------------------------------------
-- page 654 middle
SELECT regexp_replace('And then he said *&% so I replied with $@($*@','[!@#$%^&*()]','-') prime_time
FROM dual;
-- ------------------------------------------------
-- page 654 bottom
SELECT regexp_replace('And then he said *&% so I replied with $@($*@','[!@#$%^&*()]+','-') prime_time
FROM dual;
-- ------------------------------------------------
-- page 655 top
SELECT regexp_replace('and  in conclusion, 2/3rds of our  revenue ','( ){2,}', ' ') text_line
FROM dual;
-- ------------------------------------------------
-- page 655 bottom
SELECT address2,
  regexp_replace(address2, '(^[[:alpha:]]+)', 'CITY') the_string
FROM order_addresses
WHERE rownum <= 5;
-- ------------------------------------------------
-- page 656 middle
SELECT address2,
  REGEXP_REPLACE(ADDRESS2, '(^[[:alpha:] ]+)', 'CITY') THE_STRING
FROM order_addresses
WHERE rownum <= 5;
-- ------------------------------------------------
SELECT address2
FROM order_addresses
WHERE rownum <= 5;
-- page 657
-- ------------------------------------------------
SELECT address2,
  regexp_replace(address2, '(^[[:alpha:] ]+), ([[:alpha:]]{2}) ([[:digit:]]{5})','\3 \2 \1') the_string
FROM order_addresses
WHERE rownum <= 5;
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
FROM order_addresses
WHERE rownum <= 5;
-- ------------------------------------------------
-- page 659 bottom
drop table email_list2;
CREATE TABLE email_list2
  (
    email_list_id INTEGER,
    email1        VARCHAR2(120),
    CONSTRAINT ck_el_email12 CHECK ( regexp_like (email1, '^([[:alnum:]]+)@[[:alnum:]]+\.(com|net|org|edu|gov|mil)$') )
  );
INSERT INTO email_list2 VALUES
  (1,'1@2.com'
  );
INSERT INTO email_list VALUES
  (1,'1@2.ocm'
  );
RENAME email_list TO billsemail;
SELECT * FROM billsemail;
SELECT email
FROM people
WHERE regexp_like(email,'^([[:alnum:]]+)@[[:alnum:]]+.(com|net|org|edu|gov|mil)$');

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
CREATE USER tester3 IDENTIFIED BY tester3;
  GRANT
CREATE session TO tester3;
  GRANT
  SELECT ON books.books TO tester3;
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
CREATE USER tester3 IDENTIFIED BY tester3;
  GRANT
CREATE session TO tester3;
  GRANT
  SELECT ON cruises.cruises TO tester2;
  GRANT
  SELECT ON books.books TO tester2;
  GRANT
  SELECT ANY TABLE TO tester2;
CREATE USER tester3 IDENTIFIED BY tester3;
  GRANT
CREATE session TO tester3;
  GRANT
  SELECT ANY TABLE TO tester3;
  ALTER USER tester3 IDENTIFIED BY hawaii;
  DROP USER tester3;
  GRANT
CREATE session TO tester3;
  GRANT
  SELECT ON cruises.cruises TO tester2;
  GRANT
  SELECT ON books.books TO tester2;
  GRANT
  SELECT ANY TABLE TO tester2;
CREATE USER harold IDENTIFIED BY lloyd;
  GRANT
CREATE session TO harold;
  GRANT unlimited TABLESPACE TO harold;
  GRANT
  CREATE TABLE TO harold;
CREATE USER laurel IDENTIFIED BY poke;
  GRANT
CREATE session TO laurel;
  GRANT unlimited TABLESPACE TO laurel;
  GRANT
  CREATE TABLE TO laurel;
CREATE USER hardy IDENTIFIED BY clobber;
  GRANT
CREATE session TO hardy;
  GRANT unlimited TABLESPACE TO hardy;
  GRANT
CREATE ANY TABLE TO hardy;
  -- as system
  GRANT ALL PRIVILEGES TO laurel;
  -- as laurel
  CREATE TABLE hardy.test
    (id INTEGER
    );
  SELECT owner,
    table_name
  FROM all_tab_columns
  WHERE owner IN ('LAUREL', 'HARDY');
CREATE USER sammy IDENTIFIED BY sammy;
  GRANT
CREATE session TO sammy;
CREATE USER sally IDENTIFIED BY sally;
  GRANT
CREATE session TO sally;
  GRANT
  SELECT ON books.books TO sally
WITH GRANT OPTION;
GRANT
SELECT ON books.books TO sammy;
REVOKE
SELECT ON books.books FROM sally;
CREATE USER mark IDENTIFIED BY mark;
  GRANT
CREATE session TO mark;
CREATE USER mary IDENTIFIED BY mary;

  GRANT
CREATE session TO mary;

  GRANT
  CREATE TABLE TO mark
WITH admin OPTION;
GRANT
CREATE TABLE TO mary;

CREATE TABLE test2
  (id INTEGER
  );
  
  
  
-- create users mark and zooie
-- assign login privileges to both
-- grant unlimited tablespace to both
-- create sql-developer connections for both

create user mark identified by mark;
grant create session to mark;
grant unlimited tablespace to mark;

create user zooie identified by zooie;
grant create session to zooie;
grant unlimited tablespace to zooie;

create user peter identified by peter;
grant create session to peter;
grant unlimited tablespace to peter;

grant create table to mark with admin option;
create table test (id integer);

grant create table to zooie;
grant create table to peter;

revoke create table from mark;
-- grant create table mark to zooie;
create table t (id integer);

grant select on zooie.t to mark;
insert into t values(3);
commit;
grant create synonym to mark;
grant create public synonym to mark;
drop synonym t;
create synonym t for zooie.t;
create public synonym t for zooie.t;

grant create table to mark;
create table t (id integer);
create table p (id integer);
create table q (id integer);
grant create role to zooie;
drop role acct;
create role acct;
grant select on t to acct;
grant select, insert, update, delete on p to acct;
grant select, insert on q to acct;

grant acct to peter;
set role acct;
insert into zooie.p values (1);
commit;

grant insert on zooie.p to peter;
revoke acct from peter; 


select * from zooie.p;


alter user peter default role acct;
select * from zooie.p;
select * from zooie.t;

select * from role_tab_privs;


insert into t values(6);









select * from t;
  
  
  
  
  
  
  
  
  
  
GRANT unlimited TABLESPACE TO mark;
GRANT unlimited TABLESPACE TO zooie;
CREATE TABLE test
  (id INTEGER
  );
REVOKE
CREATE TABLE FROM mark;
GRANT
CREATE ANY TABLE TO PUBLIC;
  REVOKE
CREATE ANY TABLE FROM PUBLIC;
CREATE SYNONYM t FOR test;
  GRANT
  SELECT ON t TO mark;
  GRANT
  SELECT ON test TO mark;
  GRANT
  CREATE VIEW TO mary;
  CREATE VIEW vw_test AS
  SELECT * FROM test;
CREATE SYNONYM vw_t FOR vw_test;
  GRANT
  SELECT ON vw_t TO mark;
  SELECT * FROM mary.vw_t;
  SELECT * FROM mary.vw_test;
CREATE PUBLIC SYNONYM t2 FOR test2;
  GRANT
CREATE SYNONYM TO mary;
  GRANT
CREATE PUBLIC SYNONYM TO mary;
  GRANT
  SELECT ON test2 TO mark;
  SELECT * FROM t;
  SELECT * FROM t2;
  SELECT * FROM dba_tables WHERE owner = 'CRUISES';
  SELECT DISTINCT owner FROM dba_tables;
  SELECT * FROM dba_tables;
  -- wednesday start here
  SELECT * FROM user_sys_privs;
  SELECT * FROM dba_sys_privs WHERE grantee IN ('MARY','MARK');
  SELECT * FROM user_tab_privs WHERE grantee IN ('CRUISES','MARK');
  SELECT * FROM user_tab_privs WHERE grantee LIKE '%INVOIC%';
  SELECT * FROM session_roles;
CREATE role books_acct;
  GRANT
  SELECT ON customers TO books_acct;
  GRANT
  SELECT ON orders TO books_acct;
  GRANT
  SELECT ON orderitems TO books_acct;
  GRANT books_acct TO mary;
  GRANT books_acct TO mark;
  SELECT * FROM books.customers;
  SELECT * FROM books.orders;
  SELECT * FROM books.orderitems;
  SELECT * FROM role_tab_privs;
