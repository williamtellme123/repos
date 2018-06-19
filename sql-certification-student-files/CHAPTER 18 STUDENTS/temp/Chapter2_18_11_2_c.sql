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
-- REM KAPLAN HIERARCHICAL PRODUCTS table EXAMPLE ---------------------------------
-- REM table CREATION & ROW insertIONS
drop table PRODUCTS2;
create table PRODUCTS2
  (
    PRODUCTIDvarchar2(4) primary key ,
    PRODUCTTYPEvarchar2(15) ,
    PRODUCTCOSTNUMBER ,
    PRODUCTBRandID varchar2(4)
  );
delete from PRODUCTS2;
insert into PRODUCTS2 values
  ( 'P001', 'COSMETICS', 100, NULL
  );
insert into PRODUCTS2 values
  ( 'P002', 'COSMETICS', 100, 'P001'
  );
insert into PRODUCTS2 values
  ( 'P003', 'GARMENT', 100, 'P002'
  );
insert into PRODUCTS2 values
  ( 'P004', 'FOOTWEAR', 100, 'P002'
  );
insert into PRODUCTS2 values
  ( 'P005', 'COSMETICS', 100, 'P003'
  );
select * from PRODUCTS2 orDER BY PRODUCTID;
REM -------- THE TEST QUERY ---------
select PRODUCTID,
  PRODUCTTYPE,
  PRODUCTCOST,
  PRODUCTBRandID ,
  SYS_CONNECT_BY_PATH(PRODUCTID,'>') PATH
from PRODUCTS2
  start with PRODUCTID                                                                                = 'P002'
  connect by PRODUCTID                                                                                = PRIor PRODUCTBRandID;
REMTHIS VERSION OF THE QUERY DOES NOT ANSWER THE QUESTION : REMHOW MANY ANCESTorS / SUPERIorS DOES ID = 'P005' HAVE? REMTHE "connect by" CLAUSE POINTS IN THE WRONG DIRECTION. REMA MorE APPROPRIATE VERSION OF THE QUERY SHOULD BE
AS
  FOLLOWS.
  select LEVEL,
    LPAD(' ', 2*(LEVEL-1))
    || PRODUCTID "PRODUCT ID",
    PRODUCTTYPE,
    PRODUCTCOST,
    PRODUCTBRandID ,
    SYS_CONNECT_BY_PATH(PRODUCTID,'>') PATH
  from PRODUCTS2
    start with PRODUCTID      = 'P002'
    connect by PRODUCTBRandID = PRIor PRODUCTID
  orDER SIBLINGS BY PRODUCTID;
  commit;
  REMI BELIVE THAT A CLEARER QUESTION WOULD HAVE USED A COLUMN NAME LIKE 'POINTS_TO_PRODUCTID' REMAS IN "connect by POINTS_TO_PRODUCTID = PRIor PRODUCTID" REMTHEN IT WOULD BE OBVIOUS
WHEN THE connect by CLAUSE
IS
  POINTED IN THE WRONG DIRECTION.
  drop table products2;
  create table products2
    (
      productidvarchar2(4) primary key ,
      producttypevarchar2(15) ,
      productcostNUMBER ,
      productbrandid varchar2(4)
    );
  delete from products2;
BEGIN
  insert into products2 values
    ( 'P001', 'COSMETICS', 100, NULL
    );
  insert into products2 values
    ( 'P002', 'COSMETICS', 100, 'P001'
    );
  insert into products2 values
    ( 'P003', 'GARMENT', 100, 'P002'
    );
  insert into products2 values
    ( 'P004', 'FOOTWEAR', 100, 'P002'
    );
  insert into products2 values
    ( 'P005', 'COSMETICS', 100, 'P003'
    );
  insert into products2 values
    ( 'P006', 'COSMETICS', 100, 'P003'
    );
  insert into products2 values
    ( 'P007', 'COSMETICS', 100, 'P003'
    );
  insert into products2 values
    ( 'P008', 'COSMETICS', 100, 'P004'
    );
  insert into products2 values
    ( 'P009', 'COSMETICS', 100, 'P004'
    );
  commit;
END;
/
-- hierarchical
select productid ,
  producttype ,
  productcost ,
  productbrandid ,
  sys_connect_by_path(productid,'>') path
from products2
  -- where productid != 'P004'
  start with productid      = 'P002'
  connect by productbrandid = prior productid
and productid!              = 'P004';
select room_style,
  room_type,
  SUM(sq_ft)
from ship_cabins
WHERE ship_id = 1
GROUP BY grouping sets (room_style, (room_type, window));
select room_style movie_id,
  room_type location,
  window MONTH,
  SUM(sq_ft)
from ship_cabins
WHERE ship_id = 1
and ship_cabin_id BETWEEN 4 and 7
GROUP BY room_style,
  room_type,
  rollup(window);
select room_style,
  room_type,
  window,
  SUM(sq_ft)
from ship_cabins
WHERE ship_id = 1
GROUP BY room_style,
  room_type,
  window;
-- hierarchical
select productid ,
  producttype ,
  productcost ,
  productbrandid ,
  sys_connect_by_path(productid,'>') path
from products2
  -- where productid != 'P004'
  start with productid = 'P002'
  connect by productid = prior productbrandid
and productid         != 'P004';
select regexp_replace('Heardir Anthony','Sir .','|') from dual;
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
create table work_schedule1
  (
    work_schedule_id NUMBER,
    start_date       DATE,
    end_date         DATE,
    CONSTRAINT work_schedule_pk primary key(work_schedule_id)
  );
drop table work_schedule1;
create table work_schedule2
  (
    work_schedule_id NUMBER,
    start_date       DATE,
    ts               TIMESTAMP,
    tswtz            TIMESTAMP WITH TIME ZONE,
    tswltz           TIMESTAMP WITH LOCAL TIME ZONE,
    CONSTRAINT work_schedule_pk primary key(work_schedule_id)
  );
drop table work_schedule2;
insert into work_schedule2 values
  (1, sysdate, sysdate, sysdate, sysdate
  );
select * from work_schedule2;
create table ports3
  (port_id NUMBER, port_name varchar2(20)
  );
ALTER table ports3 MODIFY port_id CONSTRAINT port_id_pk primary key;
drop table cruises2 CASCADE CONSTRAINTS;
insert
into work_schedule1
  (
    work_schedule_id,
    start_date,
    end_date
  )
  values
  (
    4,
    to_date('05-DEC-11','DD-MM-YY'),
    sysdate
  );
select * from work_schedule1;
create table mytest
  (
    id INTEGER,
    t1 TIMESTAMP(2),
    t2 TIMESTAMP(2) WITH TIME ZONE,
    t3 TIMESTAMP(2) WITH LOCAL TIME ZONE
  );
TRUNCATE table mytest;
insert into mytest
  (id, t1, t2, t3
  ) values
  (1, sysdate, sysdate,sysdate
  );
insert into mytest values
  (1, sysdate, sysdate,sysdate
  );
insert into mytest
  (id, t1
  ) values
  (1, sysdate
  );
select * from MYTEST;
drop table mytest;
select * from mytest;
drop table work_schedule1;
DESC work_schedule1;
-- Page 59 (2/5)
/* =============================================================================
1. Copy from page 59
2. Rename to cruises2
3. create table
4. Check with desc
5. Check in SQL Developer for contraints
6. drop table
7. Add named constraint
8. create table
9. Look in IDE see named constraint
10 drop table cruises2
-- ---------------------------------------------------------------------------
*/
create table CRUISES2
  (
    CRUISE_IDNUMBER,
    cruise_type_id NUMBER,
    CRUISE_NAMEvarchar2(20),
    ship_idNUMBER(7,0),
    captain_id NUMBER NOT NULL,
    start_date DATE,
    end_date   DATE,
    status     varchar2(5 byte) DEFAULT 'DOCK',
    CONSTRAINT pk_cruises2 primary key (cruise_id)
  );
DESC cruises2;
drop table cruises2;
select * from user_constraints WHERE table_name = 'CRUISES2';
DESC cruises2;
drop table cruises2 CASCADE CONSTRAINTS;
-- Page 62 (2/6)
/* =============================================================================
1. Copy cruises 2 from above
2. Rename to cruises3
3. delete all except
cruise_id number(4,2)
cruise_name varchar2(5)
4. create table
5. insert into cruises3 values (3333, 'alpha');
select * from cruises3;
6. insert into cruises3 values (33, 'alpha');
select * from cruises3;
7. insert into cruises3 values (33.56, 'alpha');
select * from cruises3;
8. insert into cruises3 values (33.566, 'alpha');
select * from cruises3;
9. insert into cruises3 values (33.566, 'alpha1');
select * from cruises3;
-- ---------------------------------------------------------------------------
*/
create table cruises3
  (
    cruise_id   NUMBER,
    cruise_name varchar2(20),
    CONSTRAINT pk_cruises3 primary key (cruise_id)
  );
drop table cruises3;
insert into cruises3 values
  (3333, 'alpha'
  );
select * from cruises3;
insert into cruises3 values
  (33, 'alpha'
  );
select * from cruises3;
insert into cruises3 values
  (33.56, 'alpha'
  );
select * from cruises3;
insert into cruises3 values
  (33.566, 'alpha'
  );
select * from cruises3;
insert into cruises3 values
  (33.566, 'alpha1'
  );
insert into cruises3 values
  (33.566, 'alpha'
  );
insert into cruises3
  (cruise_name
  ) values
  ('alpha'
  );
select * from cruises3;
select * from cruises3;
drop table cruises3;
-- date format in oracle
select sys_context('USERENV', 'NLS_DATE_ForMAT') from DUAL;


-- Page 63 (2/7)
/* =============================================================================
select sys_context('USERENV', 'NLS_DATE_ForMAT') from DUAL;
-- ----------------------------------------------------------------------------
*/
-- C2 Page 64 (2/7)
/* =============================================================================
1. Copy cruises 3 from above
2. Rename to cruises4
3. delete all except
create table cruises4
( date1 date,
date2 timestamp,
date3 timestamp with time zone,
date4 timestamp with local time zone
);
4. insert into cruises4 values (sysdate,sysdate,sysdate,sysdate);
5. select * from cruises4;
6. drop table cruises4;
-- ----------------------------------------------------------------------------
*/
create table cruises4
  (
    date1 DATE,
    date2 TIMESTAMP,
    date3 TIMESTAMP WITH TIME ZONE,
    date4 TIMESTAMP WITH LOCAL TIME ZONE
  );
drop table cruises4;
insert into cruises4 values
  (sysdate,sysdate,sysdate,sysdate
  );
select * from cruises4;
-- Page 67 (2/9)
/* =============================================================================
1. Copy cruises 3 from above
create table cruises3
( cruise_id NUMBER (4,2),
cruise_name varchar2(5));
2. drop table cruises3
3. create anonymous primary key in line
create table cruises3
( cruise_id integer primary key,
cruise_name varchar2(5));
4. drop table cruises3;
5. create named primary key in line
create table cruises3
( cruise_id integer constraint cruises3_pk primary key,
cruise_name varchar2(5)
);
6. drop table cruises3;
7. create primary key out of line
create table cruises3
( cruise_id integer ,
cruise_name varchar2(5),
constraint cruises3_pk primary key (cruise_id)
);
8. drop table cruises3;
*/
drop table cruises3;
create table cruises3
  (
    cruise_id   INTEGER primary key,
    cruise_name varchar2(5)
  );
create table cruises3
  (
    cruise_id   INTEGER CONSTRAINT cruises3_pk primary key,
    cruise_name varchar2(5)
  );
create table cruises3
  (
    cruise_id   NUMBER,
    cruise_name varchar2(20),
    CONSTRAINT pk_cruises3 primary key (cruise_id)
  );
create table cruises3
  ( cruise_id INTEGER, cruise_name varchar2(5)
  );
drop table cruises3;
ALTER table cruises3 MODIFY cruise_name NOT NULL;
ALTER table cruises3 MODIFY cruise_name CONSTRAINT cruise_name_nn NOT NULL;
drop table cruises3;
ALTER table cruises3 MODIFY cruise_id primary key;
ALTER table cruises3 MODIFY cruise_id CONSTRAINT cruises3_pk primary key;
drop table cruises3;
create table cruises3
  (
    cruise_id   INTEGER ,
    cruise_name varchar2(5),
    CONSTRAINT cruises3_pk primary key (cruise_id)
  );
-- Page 69 (2/9)
/* =============================================================================
1. Copy cruises 3 from above
create table cruises3
( cruise_id NUMBER (4,2),
cruise_name varchar2(5)
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
ALTER table cruises3 MODIFY cruise_id CONSTRAINT cruises_cruiseid_pk primary key;
create table cruises3
  ( cruise_id NUMBER (4,2), cruise_name varchar2(5)
  );
drop table cruises3;
create table ports2a
  (
    port_id   NUMBER,
    port_name varchar2(20),
    country   varchar2(40),
    capacity  NUMBER,
    CONSTRAINT pk_port2a primary key(port_id)
  );
BEGIN
  insert
  into ports2a
    (
      port_id,
      port_name,
      country,
      capacity
    )
    values
    (
      1,
      'NYC',
      'USA',
      500
    );
  insert
  into ports2a
    (
      port_id,
      port_name,
      country,
      capacity
    )
    values
    (
      2,
      'NC',
      'USA',
      1500
    );
  insert
  into ports2a
    (
      port_id,
      port_name,
      country,
      capacity
    )
    values
    (
      3,
      'FL',
      'USA',
      1600
    );
END;
/
TRUNCATE table ports2a;
select * from ports2a;
drop table ports2;
create table ships2
  (
    ship_id      NUMBER,
    ship_name    varchar2(20),
    home_port_id NUMBER,
    CONSTRAINT fk_ships2_ports ForEIGN KEY (home_port_id) REFERENCES ports2(port_id)
  );
drop table ships2;
insert into ships2 values
  (100,'Badger',10
  );
insert into ships2 values
  (100,'Badger',20
  );
DESC ships2;
DESC ports2a;
insert into ships2 values
  (100,'Badger',2
  );
commit;
select * from ports2;
select * from ships2;
delete from ports2 WHERE port_id = 1;
delete from ships2 WHERE ship_id = 100;
create table vendors2
  (
    vendor_id   NUMBER,
    vendor_name varchar2(20),
    statusNUMBER(1) CHECK (status IN (4,5)),
    categoryvarchar2(5)
  );
insert into VENDorS2 values
  (1,'SMITH', 5, 'ANY'
  );
-- =============================================================================
-- HandS ON ASSIGNMENTS CHAPTER 2
/* -----------------------------------------------------------------------------
HOA C2 1. create table supplier
a.) supplier_id is the primary key can hold 10 digits
b.) supplier_name can hold 50 letters and cannot be null
c.) contact_name can hold 50 letters and can be null
NOTE: all constraints must be named by programmer
*/
create table supplier2
  (
    supplier_id   NUMBER(10),
    supplier_name varchar2(50) CONSTRAINT supplier_name_nn NOT NULL,
    contact_name  varchar2(50),
    CONSTRAINT supplier_supplier_id_pk primary key (supplier_id)
  );
drop table supplier2 CASCADE CONSTRAINTS;
insert into supplier2 values
  (1,'ABC','Fred Dobbs'
  );
insert into supplier2 values
  (2,'ACME','Tom Smith'
  );
drop table supplier2 CASCADE CONSTRAINTS;
/* -----------------------------------------------------------------------------
HOA C2 2. create table products
a.) product_id is the primary key can hold 10 digits
b.) supplier_id number (used for the foreign key)
c.) product_name can hold 50 letters and cannot be null
d.) WAIT: create a FK to Supplier2 after this table is created
NOTE: all constraints must be named by programmer
*/
create table products
  (
    product_id NUMBER(10) primary key,
    supplier_idNUMBER(10) NOT NULL,
    product_name varchar2(50) NOT NULL,
    --CONSTRAINT products_supplier_fk ForEIGN KEY (supplier_id) REFERENCES supplier(supplier_id)
  );
create table products2
  (
    product_id NUMBER(10) primary key,
    supplier_idNUMBER(10),
    product_name varchar2(50) NOT NULL
  );
-- references supplier (supplier_id),
drop table products2 CASCADE CONSTRAINTS;
create table products
  (
    product_id NUMBER(10) primary key,
    supplier_idNUMBER(10) -- CONSTRAINT abc_fk REFERENCES supplier (supplier_id),
    product_name varchar2(50) NOT NULL
  );
drop table products;
ALTER table products2 ADD CONSTRAINT prod_supp_supp3_fk ForEIGN KEY (supplier_id) REFERENCES supplier2(supplier_id);
/* -----------------------------------------------------------------------------
HOA C2 3. create table supplier3
a.) same fields as supplier
b.) supplier_id/supplier_name is composite primary key
NOTE: all constraints must be named by programmer
*/
create table supplier3
  (
    supplier_id   NUMBER(10),
    supplier_name varchar2(50),
    contact_namevarchar2(50),
    CONSTRAINT supplier_pk3 primary key (supplier_id, supplier_name)
  );
drop table supplier3 CASCADE CONSTRAINTS;
ALTER table supplier
drop CONSTRAINT supplier_pk;
select * from user_constraints WHERE upper(constraint_name) LIKE '%SUPP%';
/* -----------------------------------------------------------------------------
HOA C2 4. create table products3
a.) same fields as products
b.) foreign key matches composite primary key in supplier2
NOTE: all constraints must be named by programmer
a.) product_id is primary key and can hold 10 digits
b.) supplier_id is fk to supplier
c.) supplier_name can hold 50 letters and cannot be NULL NOTE: ALL CONSTRAINTS must be NAMED BY programmer
*/
create table products3
  (
    product_idNUMBER(10) CONSTRAINT pid_pk primary key,
    supplier_id   NUMBER(10) NOT NULL,
    supplier_name varchar2(50) NOT NULL,
    CONSTRAINT prod_supp_suppid_supprname_fk ForEIGN KEY (supplier_id, supplier_name) REFERENCES supplier3(supplier_id, supplier_name)
  );
drop table products3 CASCADE CONSTRAINTS;
/* -----------------------------------------------------------------------------
HOA C2 5. create table products4
a.) same fields as products
b.) no foreign key in create table
c.) use alter statement add: products_supplier_supplierid_fk
NOTE: use first supplier table with single field PK
*/
create table products4
  (
    product_idNUMBER(10) CONSTRAINT pid4_pk primary key,
    supplier_id   NUMBER(10) NOT NULL,
    supplier_name varchar2(50) NOT NULL
    --constraint products4_fk foreign key (supplier_id) references supplier2(supplier_id)
  );
drop table products4 CASCADE CONSTRAINTS;
-- "add" foreign key after tables are created
ALTER table products4 ADD CONSTRAINT prod4_fk ForEIGN KEY (supplier_id) REFERENCES supplier2(supplier_id);
/* -----------------------------------------------------------------------------
HOA C2 6. create table products4
a.) same fields as products
b.) no foreign key in create table
c.) use alter statement add composite FK: prod_supp_suppid_suppname_fk
NOTE: use first supplier2 table with composite PK
*/
create table products4
  (
    product_idNUMBER(10),
    supplier_id   NUMBER(10),
    supplier_name varchar2(50)
  );
ALTER table products4 ADD CONSTRAINT prod_supp_suppid_suppname_fk ForEIGN KEY
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
of multiple locations. create three small tables:
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
create table people
  (
    pid        INTEGER CONSTRAINT people_pid_pk primary key,
    start_date DATE DEFAULT sysdate,
    fname      varchar2(15) CONSTRAINT people_fname_nn NOT NULL,
    lname      varchar2(15) CONSTRAINT people_lname_nn NOT NULL,
    email      varchar2(45) CONSTRAINT people_email_uk UNIQUE
  );
drop table people;
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
create table assignments
  (
    pid INTEGER,
    lid INTEGER,
    CONSTRAINT assignments_pk primary key (pid, lid),
    CONSTRAINT assignments_people_pid_fk ForEIGN KEY (pid) REFERENCES people (pid),
    CONSTRAINT assignments_locations_lid_fk ForEIGN KEY (lid) REFERENCES locations (lid)
  );
drop table assignments;
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
create table locations
  (
    lid   INTEGER CONSTRAINT locations_lid_pk primary key,
    name  varchar2(30) CONSTRAINT locations_name_nn NOT NULL,
    city  varchar2(30) CONSTRAINT locations_city_nn NOT NULL,
    state varchar2(2) CONSTRAINT locations_state_nn NOT NULL
  );
drop table locations;
/*
11. drop these three tables people, assignments, locations
*/
-- =============================================================================
-- Chapter 3
-- =============================================================================
create table customers_bak
as select * from customers;

desc  customers;
desc customers_bak;

create table orders_bak
as select * from orders;

alter table
    customers20
rename to
   customers;

select * from orders2;

select * from customers;
select * from orders;
-- 1. all columns are listed
insert into orders (order#,customer#,orderdate, shipdate,
                      shipstreet,shipcity,shipstate, shipzip)
values (5000,1001,sysdate,sysdate,'123 Main','AnyTown','AZ','99999');

-- 2 some columns are listed and are in same order as table
insert into orders (order#   ,customer#   ,shipzip)
values             (5001     ,1001        ,'99999');

-- 3 some columns listed but not in same order as table
insert into orders (shipzip,customer#,order#)
values ('99999',1001, 5002);

-- 4 no columns are listed but values are required for all cols
insert into orders 
values (5003,1001,sysdate,sysdate,'123 Main','AnyTown','AZ','99999');

select * from orders where customer#=1001;

alter table
    customers
rename to
   customers20;

rollback;

select * from orders where customer#=1001;

update orders set shipcity = 'AnyTown',shipstate='MN',shipzip='33333'
where shipcity = 'Sometown';

-- use a sequence in an insert statement
-- 1.find the maximum order# first
select max(order#)
from orders; 

-- 2. create a sequence that starts with max+1
create sequence seq_orders start with 5004;

-- 3. use the sequence in an insert statement
insert into orders 
values (seq_orders.nextval,1001,sysdate,sysdate,
         '123 Main','AnyTown','AZ','99999');

select * 
from orders
order by order# desc;
         
commit;

select * from customers;

select * 
from customers;
select * 
from customers;


update customers
set lastname='WHITE'
where customer#=1001;

update customers
set zip='99999'
where customer#=1001;

update customers
set lastname='WHITE',zip='99999'
where customer#=1001;

update customers
set lastname='WHITE',zip='99999'
where customer#=1001;

rollback;

drop table customers;

alter table
    customers20
rename to
   customers;

-- test datatype conversion
desc customers;

insert into customers (customer#)
values ('5003');

select * 
from orders;

select * 
from orders
where order# =1015;

update orders
set shipdate='06-APR-03'
where order#=1015;

select * 
from orders
where order#=1015;
commit;

select * 
from books;

select *
from books
Where retail < 50;

update books set retail = retail*.9
Where retail < 50;

update books set saleprice = retail*.9
where retail < 50;

select *
from  books;

alter table books
drop column saleprice;
rollback;

alter table books
add saleprice number;
select * from books;

savepoint test;

rollback to test;
-- test the savepoint features of oracle
commit;

select * 
from ships
where ship_id=5;


update ships set home_port_id =3 where ship_id = 5;
savepoint sp_1;
update ships set home_port_id =13 where ship_id = 5;
select * from ships where ship_id = 5;
rollback to sp_1;
select * from ships where ship_id = 5;



select * from ports;




select * from orders;
rollback;
commit;
select * 
from orders where customer# = 1001;

rollback;
delete from customers
where customer#=1001;


delete from orders
where customer# = 1050;
commit;

alter table orders add constraint order_fk foreign key (customer#)
references customers(customer#);

select *
from cruise_customers;
delete from cruise_customers;
ROLLBACK;
select * from ports;
select * from employees;
select * from cruises;
select * from USER_CONS_COLUMNS WHERE table_NAME = 'CRUISES';
select * from USER_CONS_COLUMNS WHERE table_NAME = 'EMPLOYEES';
select * from USER_CONS_COLUMNS WHERE table_NAME = 'CONTACT_EMAILS';
/*
-- C3 Page 99 (3/1)
1. Copy from page 99
2. Format for readability
3. insert (is there a problem?)
SOLUTION
4. select from cruises
5. select from employees
6. Check constraints
7. Change insert statement to work
*/
drop SEQUENCE SEQ_CRUISE_ID;
create SEQUENCE SEQ_CRUISE_ID;
  insert
  into cruises
    (
      cruise_id,
      cruise_type_id,
      cruise_name,
      captain_id,
      start_date,
      end_date,
      status
    )
    values
    (
      seq_cruise_id.nextval,
      '1',
      'Moon At Sea',
      1,
      '02-JAN-10',
      '09-JAN-10',
      'Sched'
    );
  insert
  into cruises values
    (
      seq_cruise_id.nextval,
      '1',
      'Whales At Sea',
      8,1,
      '02-JAN-10',
      '09-JAN-10',
      'Sched'
    );
  insert into cruises
    (cruise_id
    ) values
    (seq_cruise_id.nextval
    );
  select * from cruises;
  delete from cruises;
  create table cruises4 AS
  select * from cruises;
  select * from cruises;
  select * from ships;
  UPDATE cruises SET ship_id = 8 WHERE cruise_id = 1;
  select * from cruises;
  ROLLBACK;
  commit;
  UPDATE cruises SET ship_id = 8 WHERE cruise_id = 1;
  delete from cruises;
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
    insert
    into cruises
      (
        cruise_id,
        cruise_type_id,
        cruise_name,
        captain_id,
        start_date,
        end_date,
        status
      )
      values
      (
        seq_cruise_id.nextval,
        '1' ,
        'Day At Sea' ,
        1,
        '02-JAN-10',
        '09-JAN-10',
        'Sched'
      );
    insert
    into cruises
      (
        cruise_id,
        cruise_type_id,
        cruise_name,
        captain_id,
        start_date,
        end_date,
        status
      )
      values
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
  select MAX(cruise_id) from cruises;
create sequence seq_cruise_id start with 15;
  ;
  drop sequence seq_cruise_id;
  select * from cruises WHERE cruise_id IN (10,12,14);
  select * from cruises WHERE cruise_id IN (1,3,5,7);
  UPDATE cruises SET cruise_name = 'Bahamas' WHERE cruise_id IN (1,3,5,7);
  select * from cruises WHERE cruise_id IN (2,4,6,8);
  UPDATE cruises SET cruise_name = 'Hawaii' WHERE cruise_id IN (2,4,6,8);
  UPDATE cruises
  SET cruise_name  = 'Mexico',
    status         = 'SCHED'
  WHERE cruise_id IN (10,12,14);
  create table salary_chart
    (
      org_id             NUMBER(7),
      emp_title          varchar2(30),
      emp_income         NUMBER(10,2),
      superior           varchar2(30),
      sup_income         NUMBER(10,2),
      last_modified_by   varchar2(25),
      last_modified_date DATE
    );
  ALTER table salary_chart ADD last_modified_by    DATE;
  ALTER table salary_chart MODIFY last_modified_by varchar2
  (
    25
  )
  ;
  ALTER table salary_chart ADD last_modified_date DATE;
  select * from salary_chart;
  DESC salary_chart;
  insert
  into salary_chart values
    (
      1,
      'Chef',
      48000,
      'Restaurant Chief',
      2025,
      'birogers',
      '14-DEC-11'
    );
  insert
  into salary_chart values
    (
      1,
      'Director',
      75000,
      'Captain',
      2511,
      'birogers',
      '14-DEC-11'
    );
  insert
  into salary_chart values
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
  select * from salary_chart;
  select * from salary_chart WHERE sup_income >= 2500;
  UPDATE salary_chart
  SET sup_income    = sup_income + 1000
  WHERE sup_income >= 2500;
  UPDATE salary_chart SET sup_income = sup_income + 500 WHERE sup_income < 2500;
  select * from salary_chart;
  select * from salary_chart WHERE emp_title LIKE 'Manager';
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
  select * from salary_chart;
  ROLLBACK;
  delete from salary_chart;
  select * from salary_chart;
  ROLLBACK;
  ROLLBACK;
  ALTER table salary_chart ADD (last_modified_by varchar2(12), last_modified_date DATE);
  commit;
  select * from cruises;
  select * from employees;
  DESC cruises;
  select * from ships;
  /*
  -- C3 Page 101 (3/2)
  1. Copy insert from above
  2. Remove column names
  3. insert (same problem)
  4. select from cruises/check constraints
  5. Add value (select from ships)
  6. insert
  7. Change captain_id (select from employees)
  6. insert
  */
  insert
  into CRUISES values
    (
      2,1,
      'Day At Sea',
      101,
      '02-JAN-10',
      '09-JAN-10',
      'Sched'
    );
  select * from cruises;
  select * from employees;
  DESC cruises;
  DESC ships;
  select * from ships;
  /*
  -- Page C3 105 (3/4)
  1. Copy insert from above
  2. select Max from Cruises
  3. create sequence start Max+1
  4. insert statement from page 105 using nextval
  6. insert
  */
create sequence cruise_cruise_id_seq start with 3;
  drop sequence cruise_cruise_id_seq ;
  ;
  select MAX(cruise_id) from cruises;
  insert
  into CRUISES values
    (
      cruise_cruise_id_seq.nextval,
      1,
      'Day At Sea',
      8,8,
      '02-JAN-10',
      '09-JAN-10',
      'Sched'
    );
  select * from cruises;
  select * from employees;
  5
  /*
  -- C3 Page 106 (3/4)
  1. Copy code page 106
  2. select Max from Cruises
  3. create sequence start Max+1
  4. insert statement from page 105
  5. insert
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
  4. select to test
  */
  select *
  from CRUISES;
  UPDATE cruises SET end_date = end_date + 5, start_date = start_date + 5 ;
  select * from projects;
  /*
  -- C3 Page 108 (3/5)
  1. Copy code page 108
  2. Rename Projects2
  3. Modify insert statements Projects2
  4. create table
  5. insert into table
  6. update projects2
  set cost = cost * 1.20;
  7. Update
  */
  create table PROJECTS2
    (
      PROJECT_ID   NUMBER primary key ,
      PROJECT_NAME varchar2(40) ,
      COST         NUMBER ,
      CONSTRAINT CK_COST CHECK (COST < 1000000)
    );
  BEGIN
    insert
    into projects2
      (
        project_id,
        project_name,
        cost
      )
      values
      (
        1,
        'Hull Cleaning',
        340000
      );
    insert
    into projects2
      (
        project_id,
        project_name,
        cost
      )
      values
      (
        2,
        'Deck Resurfacing',
        96400
      );
    insert
    into projects2
      (
        project_id,
        project_name,
        cost
      )
      values
      (
        3,
        'Lifeboat Inspection',
        12000
      );
  END;
  /
  select * from projects;
  UPDATE projects SET project_cost = project_cost * 1.03;
  UPDATE projects
  SET project_cost                        = project_cost * 1.05
  WHERE project_cost              * 1.05 <= 1000000;
  ROLLBACK;
  commit;
  select * from ships;
  UPDATE ships SET home_port_id = 1 WHERE ship_id = 3;
  SAVEPOINT sp_1;
  UPDATE ships SET home_port_id = 3 WHERE ship_id = 3;
  select * from ships;
  ROLLBACK TO sp_1;
  /*
  -- C3 Page 110 (3/5)
  1. Copy update from above
  2. Modify with where clause
  3. Update
  4. select
  */
  UPDATE projects2
  SET cost              = cost * 1.2
  WHERE cost      * 1.2 < 1000000;
  /*
  -- C3 Page 117 (3/7)
  1. commit
  2. select * from projects2;
  3. delete from projects2
  4. select
  5. Rollback
  6. select
  7. delete projects2
  8. select
  9. Rollback
  10. select
  */
  commit;
  select * from projects2;
  delete projects2;
  ROLLBACK;
  SET cost = cost * 1.2 WHERE cost * 1.2 < 1000000;
  /*
  -- C3 Page 120 (3/7)
  1. Copy 199-120
  2. commit
  3. select
  4. 1st update
  5. Ship_id = 3
  6. Home Port 12
  7. Home Port 11
  8. Home Port 10
  9. Rollback to Mark_02
  10. select
  11. Update back to null to reset DB
  12. select
  13. commit
  */
  commit;
  select * from ships WHERE ship_id = 3;
  UPDATE SHIPS SET HOME_PorT_ID = 12 WHERE SHIP_ID = 3;
  SAVEPOINT MARK_01;
  UPDATE SHIPS SET HOME_PorT_ID = 11 WHERE SHIP_ID = 3;
  SAVEPOINT MARK_02;
  UPDATE SHIPS SET HOME_PorT_ID = 10 WHERE SHIP_ID = 3;
  ROLLBACK TO MARK_02;
  commit;
  UPDATE SHIPS SET HOME_PorT_ID = NULL WHERE SHIP_ID = 3;
  select * from ships WHERE ship_id = 3;
  commit;
  -- =============================================================================
  -- HandS ON ASSIGNMENTS CHAPTER 3
  /* -----------------------------------------------------------------------------
  1. C3 copy DDL stements above for tables: people, assignments, locations
  */
  /*
  
  
  2. create table people in cruises
  -- ---------------------------------------------------
  1.) pid is a number which is the primary key
  2.) startdate is the startdate with default sysdate
  3.) fname can hold 15 letters 
  4.) lname can hold 25 letters 
  5.) email can hold 25 letters must be unique
  OPTIONAL: all constraints may be named by programmer
  */
  
create table people
(
  pid         INTEGER CONSTRAINT people_pid_pk primary key,
  start_date  DATE DEFAULT sysdate, 
  fname       varchar2(15) ,
  lname       varchar2(15) ,
  email       varchar2(45) CONSTRAINT people_email_uk UNIQUE
);
  DESC people;
  drop table people;

-- modify a table/Column by enlarging it
alter table people modify fname varchar2(25);

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
  drop table assignments;
create table assignments
(
  pid INTEGER,
  lid INTEGER,
  CONSTRAINT assignments_pk primary key (pid, lid),
  CONSTRAINT assignments_people_pid_fk ForEIGN KEY (pid) 
                        REFERENCES people (pid),
  CONSTRAINT assignments_locations_lid_fk ForEIGN KEY (lid) 
                        REFERENCES locations (lid)
);


  insert into people values (11,sysdate,'Betty','Boop','boop@yahoo.com');
  insert into people values (12,sysdate,'Bullwinkle','Moose','Bull@yahoo.com');
  insert into people values (13,sysdate,'Rita','Hayworth','rita@yahoo.com');
  insert into people values (14,sysdate,'Sammy','TwoCoat','Sammy@yahoo.com');

  insert into locations values (1002,'Java','Houston','TX');
  insert into locations values (1003,'HEB','San Antonio','TX');
  insert into locations values (1004,'VooDoos','Austin','TX');
  insert into locations values (1005,'Jacks','Austin','TX');
  insert into locations values (1006,'LawnCare','Lubbock','TX');

  insert into assignments values (11,1001);
  insert into assignments values (12,1002);
  insert into assignments values (13,1003);
  insert into assignments values (14,1004);
  insert into assignments values (11,1005);
  insert into assignments values (12,1006);


desc locations;

commit;

select firstname,lastname
from customers;

select 'first name',firstname
from customers;

select 1,firstname
from customers;

select  rownum,rowid,firstname ,lastname
from customers
where lastname = 'SMITH';

select rownum,firstname ,lastname
from customers;

select isbn,title,retail
from books
where rownum <= 5
order by retail desc;

select isbn,title,retail
from books
where rownum <= 5
order by retail desc;

select isbn,title,retail
from books
order by retail;

select distinct lastname
from customers;

select distinct lastname, firstname
from customers;

select * from customers;

alter table books add salesprice number;
desc books;

alter table books drop column salesprice;

select distinct catcode
from books;

update books set salesprice=retail*.9;

select retail, salesprice
from books;

select isbn,title,cost, retail,retail-cost profit
from books
order by profit;


-- concatenation
select firstname || ' ' || lastname fullname
from customers;

desc books;

insert into locations values (1000,'Popeyes','Austin','TX');
insert into assignments values(10,1000);

create table one
( 
  col_one   number,
  col_two   number
);
insert into one values (10,100);
insert into one values (20,200);

create table two
(
  col_three varchar2(10),
  col_four  varchar2(10)
);

insert into two values ('Horses','Zebra');
insert into two values ('Rhino','Hippo');
rollback;

select * from one;
select * from two;

desc orders;
select *
from customers,orders;

select *
from one,two;


select * from customers;
select * from orders; 

-- customers 23
-- orders 30
select *
from customers,orders;

select customers.customer#,orders.order#,customers.firstname,customers.lastname 
from customers,orders
where customers.customer# = orders.customer#
order by 1 desc,2 desc;

/*
    this is a comment
    of more than one line
    and you don;t have to put dashes on every line
*/


select c.customer#,order#,firstname,lastname 
from customers c,orders o
where c.customer# = o.customer#
order by 1,2;
-- drop table assignments;
/*
4. create table locations
-- ---------------------------------------------------
1.) lid is integer and the primary key
2.) name can hold 30 letters
4.) city can hold 30 letters
5.) state can hold 2 letters and cannot be null
*/
-- create a table for locations
drop table locations cascade constraints;
create table locations
(
  lid   INTEGER CONSTRAINT locations_lid_pk primary key,
  name  varchar2(30) ,
  city  varchar2(30) ,
  state varchar2(2) CONSTRAINT locations_state_nn NOT NULL
);
 
DESC locations;
-- drop table locations;
/*
5. create a sequence for people and locations
-- ---------------------------------------------------
*/
create sequence people_pid_seq start with 1000;
  -- drop sequence people_pid_seq;
create sequence locations_lid_seq start with 1;
-- drop sequence locations_lid_seq;
/*
6. insert three rows into people (using sequence)
7. insert six rows into assignments (each person works two locations)
8. insert three rows into locations (using sequence)
-- ---------------------------------------------------
*/
BEGIN
  insert into people(pid,start_date,fname,lname,email)
    values(people_pid_seq.nextval,sysdate,'Marshal','Rango','rango@hotmail.com');
  insert into people(pid,start_date,fname,lname,email)
    values(people_pid_seq.nextval,sysdate,'Penelope','Pitstop','ppitstop@gmail.com');
  insert into people(pid,start_date,fname,lname,email)
    values(people_pid_seq.nextval,sysdate,'Ranger','andy','randy@juno.com');
END;
/
select * from people;
BEGIN
  insert into locations(lid,name,city,state)
    values(locations_lid_seq.nextval,'Bar 4 Ranch','Lubbock','TX');
  insert into locations(lid,name,city,state)
    values(locations_lid_seq.nextval,'Bar B Que','Austin','TX');
  insert into locations(lid,name,city,state)
    values(locations_lid_seq.nextval,'Space Out','Houston','TX');
END;
/
BEGIN
  insert into assignments(pid, lid) 
    values(1000,1);
  insert into assignments(pid, lid) 
    values(1000,2);
  insert into assignments(pid, lid) 
    values (1000,3);
END;
/
select * from people;
delete from people WHERE pid = 1000;
delete from locations WHERE lid =2;
select * from locations;
DESC assignments;
insert into assignments
  (pid,lid
  ) values
  (1000,1
  );
insert into assignments
  (pid,lid
  ) values
  (1000,3
  );
insert into assignments
  (pid,lid
  ) values
  (1001,2
  );
insert into assignments
  (pid,lid
  ) values
  (1001,3
  );
insert into assignments
  (pid,lid
  ) values
  (1002,1
  );
insert into assignments
  (pid,lid
  ) values
  (1002,3
  );
select * from assignments;
/*
9. delete from people where pid = 1000;
10. delete from locations where lid = 1
-- ---------------------------------------------------
*/
delete
from people
WHERE pid = 1000;
delete from assignments WHERE pid = 1000;
delete from locations WHERE lid = 2;
delete from assignments WHERE lid = 2;
/*
11. select to check
12. drop tables
13. drop sequences
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
select SHIP_ID,
  SHIP_NAME,
  CAPACITY
from SHIPS
orDER BY capacity DESC;
select SHIP_ID,SHIP_NAME,CAPACITY from SHIPS orDER BY 3 DESC, ship_name;
select 'ping pong',ship_id,ship_name,capacity from ships;
select '?' from ships;
select 'ping pong' from ships;
select '---',ship_name from ships;
select ship_name, rownum from ships;
select *
from
  (select ship_name, rownum from ships orDER BY ship_name
  )
WHERE rownum < 3;
select * from employees;
select DISTINCT last_name from employees;
select UNIQUE last_name from employees;
select employee_id,
  salary,
  (salary*1.05)
from pay_history
WHERE end_date IS NULL
orDER BY employee_id;
select * from pay_history;
select 10+15*3 from dual;
select (11 - 4 + (( 2+3) * .7) / 4) from dual;
select rownum, ship_name from ships;
select * from employees;
create VIEW vw_emp AS
select first_name,last_name from employees;
select * from vw_emp;
select SHIP_ID, SHIP_NAME, capacity from ships orDER BY 1, 2;
select SHIP_ID,
  rowid,
  rownum
from ships
WHERE ship_id BETWEEN 3 and 6
orDER BY 1 DESC;
DESC employees;
select * from employees;
select DISTINCT last_name, first_name from employees;
select * from pay_history;
select employee_id,
  salary,
  salary*1.05,
  end_date
from pay_history
WHERE end_date IS NOT NULL;
select last_name from employees;
select DISTINCT last_name from employees ;
select COUNT(*), last_name from employees GROUP BY last_name;
select * from ship_cabin_grid;
select * from pay_history WHERE end_date IS NULL;
select employee_id,
  salary,
  salary*1.05
from pay_history
WHERE end_date IS NULL
orDER BY employee_id;
select end_date from pay_history;
select COUNT(*) from customers;
select COUNT(*) from orders;
select * from customers c, orders o WHERE c.customer# = o.customer#;
select * from customers c JOIN orders o ON c.customer# = o.customer#;
select * from customers JOIN orders USING (customer#);
select * from books;
select title t, retail r , ROUND(retail * 1.05,2) nr from books;
select lower(title) from books;
select COUNT(*) from customers JOIN orders USING(customer#);
create VIEW vw_customer_orders AS
select * from customers JOIN orders USING (customer#);
select * from vw_customer_orders;
UPDATE vw_customer_orders SET order# = 10001 WHERE order# = 10000;
select COUNT(*) from orders;
select customer#
from customers
WHERE customer# NOT IN
  (select customer# from orders
  );
select * from customers WHERE state IN ('FL','GA');
create VIEW southeast AS
select firstname, lastname from customers WHERE state IN ('FL','GA');
drop VIEW southeast;
commit;
select * from southeast;
DESC southeast;
select COUNT(catcode), catcode from books GROUP BY catcode;
select shipdate from orders;

delete customers;
delete orders;

insert into customers
select * from customers_bak;

insert into orders
select * from orders_bak;

commit;

-- firstname, lastname, order#, title
-- for all customers who have placed orders
  
select firstname,lastname,o.order#, title
-- select *
from customers c,
     orders o,
     orderitems oi,
     books b
where c.customer# = o.customer#
  and o.order# = oi.order#
  and oi.isbn = b.isbn
  and firstname = 'BONITA'
  and lastname = 'MorALES';

-- list order#, title, retail 
-- for all books in order# = 1003
select order#, title, retail
from orderitems oi,
     books b
where oi.isbn = b.isbn
  and order# = '1003';  

-- title author firstname and lastname
-- for all books
select title,fname,lname
from books b,
     bookauthor ba,
     author a
where b.isbn = ba.isbn
  and ba.authorid = a.authorid
  and title like 'BODY%';

-- list title and pub name, contact, phone
select title, name,contact,phone
from books b,
     publisher p
where b.pubid = p.pubid
  and title like 'REVENGE%';

-- return order#,first name, last name
-- and shipstate from all customers whose home state = Florida
select order#,firstname,lastname,shipstate
from customers c,
     orders o
where c.customer# = o.customer#
  and state = 'FL';


select * from pay_history;

select * from orders
order by order# desc;
rollback;

create sequence seq_orders2 start with 1021;

insert into orders (order#,customer#)
values (seq_orders2.nextval,1001);


select 10 * (100 * (1.03 * 5)) / 5
from dual;

select (11 - 4 + ((2+3) * .7) / 4 )
from dual;

-- scalar function called initcap
-- another call concatenation
select initcap(firstname) || ' ' || initcap(lastname)
from customers;




-- C4 Page 141 (4/2)
/* =============================================================================
1. Copy from page 141
2. Run the command in SQL Developer
*/
select 1,
  '--------'
from SHIPS;
-- =============================================================================
-- HandS ON ASSIGNMENTS CHAPTER 4
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
select COUNT(*)
from customers;
-- old school join
select DISTINCT firstname,
  lastname
from customers c,
  orders o
WHERE c.customer# = o.customer#;

-- new school join #1
select firstname,
  lastname,
  order#
from customers c
JOIN orders o
ON c.customer# = o.customer#;

-- new school join #2
select firstname,
  lastname,
  order#
from customers
JOIN orders USING(customer#);

select lastname,firstname,order#
from customers
JOIN orders USING (customer#)
orDER BY 3,
  2,
  1;
/*
select lastname, firstname, order#
from customers LEFT JOIN orders USING (customer#)
orDER BY 3, 2, 1;
*/
select lastname,
  firstname,
  order#
from customers c
JOIN orders o
ON c.customer# = o.customer#
orDER BY 3,2,1;
/*
select lastname,firstname, order#
from customers c
LEFT JOIN orders o
ON c.customer# = o.customer#
orDER BY 3, 2,1;
select lastname, firstname, order#
from customers c ,
orders o
WHERE c.customer# = o.customer#(+)
orDER BY 3,2,1;
*/
-- total number of joined rows
select lastname,firstname,order#
from customers c
LEFT OUTER JOIN orders o
ON c.customer# = o.customer#
orDER BY 3,2,1;

select lastname,firstname,order#
from customers c ,
  orders o
WHERE c.customer# = o.customer#;

select lastname,
  firstname,
  order#
from customers c ,
  orders o
WHERE c.customer# = o.customer#;

-- customers without orders
select c.customer#,
  lastname,
  firstname
from customers c
WHERE NOT EXISTS
  (select customer# from orders o WHERE c.customer# = o.customer#
  );

-- 10
select c.customer#,
  lastname,
  firstname
from customers c
WHERE c.customer# NOT IN
  (select customer# from orders o WHERE c.customer# = o.customer#
  );

-- 14
select c.customer#,
  lastname,
  firstname
from customers c
WHERE c.customer# IN
  (select DISTINCT customer# from orders o WHERE c.customer# = o.customer#
  );

-- 24
select DISTINCT c.customer#, lastname, firstname from customers c;
select COUNT(DISTINCT c.customer#) from customers c;

-- 22
select COUNT(*) from orders;
-- =============================================================================
-- Chapter 5
-- =============================================================================
create view vw_books
as select title, retail
from books;

select * 
from vw_books;

select title, catcode from books;






create table sortme
( junk  varchar2(15));
insert into sortme values ('12');
insert into sortme values ('1');
insert into sortme values ('02');
insert into sortme values ('21');
insert into sortme values ('13');
insert into sortme values ('2');
insert into sortme values ('10');
insert into sortme values ('A');
insert into sortme values ('a');
insert into sortme values ('Z');
insert into sortme values ('z');
insert into sortme values ('Apple');
insert into sortme values ('Apple Pie');
insert into sortme values (null);
insert into sortme values (' 1');
select * from sortme order by junk;
commit;

select junk
from sortme
order by junk;

create table sortme2
(
  junk number
) ; 

begin
  insert into sortme2 values ('12');
  insert into sortme2 values ('1');
  insert into sortme2 values ('02');
  insert into sortme2 values ('21');
  insert into sortme2 values ('13');
  insert into sortme2 values ('2');
  insert into sortme2 values ('10');
end;
/

select title
from books
where title LIKE '%BODY%';

select junk 
from sortme2
order by junk;

select port_name
from ports
where port_name like 'San%';

select port_name
from ports
where port_name like '_o%';

select port_name
from ports
where 'Honolulu' like port_name;

select port_name
from ports
where port_name like '%';

select * from ports;
insert into ports (port_id, port_name) values (30,null);

select 'MONKEY', title
from books
where title like 'BODY%';

select port_name, country
from ports
where country in ('UK','USA','Bahamas');

select port_name, capacity
from ports
where capacity between 3 and 4;

select port_name, capacity
from ports
where capacity  >= 3 
  and capacity <= 4 ;


select port_name, capacity
from ports
where capacity is not null;

select address_id,street_address,city,state,country
from addresses
where country = 'USA'
order by state desc, city;

select firstname || ' ' || lastname fullname
from customers
where firstname || ' ' || lastname = 'BONITA MorALES'
order by fullname;

select * 
from projects
order by project_cost / days;

select city,state, address_id,street_address
from addresses
order by 1, state;

select pay_history_id, salary,start_date,end_date
from pay_history
order by end_date desc, start_date,salary ;

select *
from addresses
order by 5;

order by 4;


select *
from ports
where 1=1
  and port_id = 9
  and  port_name like 'H%';




select title,isbn
from books;

select *
from employees
WHERE ship_id ^= 3;

select firstname, lastname, state 
from customers WHERE state IN ('FL','GA');

select firstname,lastname,state
from customers
WHERE state LIKE 'N_'
   or state LIKE 'W_';

select firstname,lastname,state
from customers
WHERE state = 'NJ'
or state    = 'WY';

select firstname, lastname, state from customers WHERE state IN ('NJ','WY');
select (sysdate +1)-sysdate from dual;
select * from employees WHERE ship_id IN (1,3);
select * from employees WHERE ship_id = 1 or ship_id =3;
select last_name, first_name from employees WHERE last_name LIKE '%in%';
select * from ports;
select * from ports WHERE port_name LIKE 'San_____';

create table test
  (name varchar2(10)
  );
insert into test values('APPLE');
insert into test values('apple');
insert into test values('10');
insert into test values('1');
insert into test values('2');
insert into test values(' ');
insert into test values(NULL);

select name from test orDER BY 1c;
UPDATE test SET name = '02' WHERE name = '2';

select * from work_history;
select employee_id, status from work_history WHERE NOT status = 'Pending';
select port_name from ports WHERE port_name IN ('San%');
select employee_id
from work_history
WHERE ship_id = 3
and status   != 'Pending';


select room_number,room_style,window
from ship_cabins
WHERE ( room_style = 'Suite'
        or room_style    = 'Stateroom'
      )
 and    window       = 'Ocean';

select employee_id, ship_id, status
from work_history
where     ship_id = 4
  and 
      not status ='Pending';
commit;


select * from work_history;


select room_number,room_style,window
from ship_cabins
WHERE window = 'Ocean'
  or Room_style = 'Suite'
  and room_style    = 'Stateroom';      
 
--T   and  T   =  T
--T   and  F   =  F
--F   and  T   =  F
--F   and  F   =  F
--
--T   or  T   =  T
--T   or  F   =  T
--F   or  T   =  T
--F   or  F   =  F
  
select room_number,
  room_style,
  window
from ship_cabins
WHERE NOT room_style = 'Suite'
or room_style        = 'Stateroom'
and window           = 'Ocean';

select room_number,
  room_style,
  window
from ship_cabins
WHERE (room_style = 'Suite'
or room_style     = 'Stateroom')
and window        = 'Ocean';
select port_name, capacity from ports WHERE capacity >= 3 and capacity <= 4;
select port_name, capacity from ports WHERE capacity <= 3 or capacity >= 4;
select port_name, capacity from ports WHERE capacity BETWEEN 3 and 4;
select * from books;
select * from promotion;
select title,
  retail,
  minretail,
  maxretail,
  gift
from books,
  promotion
WHERE retail BETWEEN minretail and maxretail;
select * from customers WHERE state NOT IN ('FL','GA');
select state from customers WHERE NOT state ^= 'FL' or NOT state <> 'GA';
select COUNT(*) from orders;
select * from orders;
select COUNT(shipdate) from orders;
select COUNT(order#) from orders;
select * from orders WHERE shipdate IS NULL;
select DISTINCT purpose,
  project_name,
  project_cost,
  days,
  ROUND(project_cost/days) cpd
from projects
orDER BY cpd;
;
select * from books;
select * from books WHERE pubdate >= '01-JAN-01' and pubdate <= '31-DEC-01';
select * from books WHERE pubdate BETWEEN '01-JAN-01' and '31-DEC-01';
select * from books WHERE pubdate LIKE '%-01';
select category from books;
select DISTINCT category from books;
select COUNT(DISTINCT category) from books;
select COUNT(*) from customers;
select COUNT(referred) from customers;
select * from customers WHERE 1=1;
select table_name from all_tab_columns WHERE column_name LIKE '%DATE_ForMAT%';
select * from orders;
select title from books WHERE title LIKE '_A_N%';
select * from customers WHERE state NOT IN ('FL','GA');
select * from customers WHERE state LIKE 'F%';
select title, category, pubid, cost from books;
select title,
  category,
  pubid,
  cost
from books
WHERE (category = 'FAMILY LIFE'
or pubid        = 4)
and cost       >= 20;
select room_number,
  room_style,
  window
from ship_cabins
WHERE room_style = 'Suite'
or room_style    = 'Stateroom'
and window       = 'Ocean';
select * from books WHERE catcode = 'FAL';
select * from books WHERE pubid = 4;
select * from books WHERE cost > 15;
select room_number,
  room_style,
  window
from ship_cabins
WHERE NOT room_style LIKE 'Suite';
--and window = 'Ocean';
select port_name
from ports
WHERE country IN ('UK','USA','Bahamas');
select port_name from ports WHERE capacity = NULL;
-- =============================================================================
-- HandS ON ASSIGNMENTS CHAPTER 5
/*
1.
Return port_id, port_name, capacity
for ports that start with either "San" or "Grand"
and have a capacity of 4.
*/

select port_id, port_name, capacity
from ports 
where  
        port_name like 'San%' and capacity = 4
      or port_name like 'Grand%' and capacity = 4
; 
select *
from ports;





select port_id,
  port_name,
  capacity
from ports
WHERE (port_name LIKE 'San%'
or port_name LIKE 'Grand%')
and capacity = 4;
/*
2.
Return vendor_id, name, and category
where the category is 'supplier', 
'subcontractor' or ends with 'partner'.
*/

select vendor_id,vendor_name, category
from vendors
where category in ('Supplier','Sub Contractor')
    or category like '%Partner';

select vendor_id,vendor_name, category
from vendors
where category = 'Supplier'
     or category = 'Sub Contractor'
     or category like '%Partner';




select table_name
from all_tab_columns
WHERE column_name LIKE '%VEND%'
and owner = 'CRUISES';
select vendor_id,
  vendor_name,
  category
from vendors
WHERE category IN ('Supplier','Subcontractor')
or category LIKE '%Partner';
/*
3.
Return room_number and style from ship_cabins
where there is no window or the balcony_sq_ft = null;
*/
select room_number, room_style
from ship_cabins
where window = 'None'
  or balcony_sq_ft is null;


select room_number,
  room_style
from ship_cabins
WHERE window      = 'None'
or balcony_sq_ft IS NULL;

/*
4.
Return ship_id, ship_name, capacity, length
from ships where 2052 <= capacity <= 3000
and the length is either 100 or 855
and the ship begins with "Codd"
*/
select * from ships;
select ship_id,ship_name, capacity, length
from ships
WHERE capacity BETWEEN 2052 and 3000
and LENGTH IN (100,855)
and ship_name LIKE 'Codd_%';

select ship_id,ship_name, capacity, length
from ships
WHERE capacity >= 2052 and capacity <= 3000
and LENGTH IN (100,855)
and ship_name LIKE 'Codd_%';








select * from ships;
ALTER table ships ADD lifeboats INTEGER;
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
select ship_id,
  ship_name,
    lifeboats,
    capacity
  from ships
  WHERE (ship_name = 'Codd Elegance'
  or ship_name     = 'Codd Victorious')
    --   and lifeboats >= 80
    --   and lifeboats <= 100
  and lifeboats BETWEEN 80 and 100
  and capacity / lifeboats > 25;
  -- select first name and last name and order number
  -- from the books schema
  -- use the key word using
  -- for customers whpo have placed orders
  select firstname,
    lastname,
    order#
  from customers
  JOIN orders USING (customer#);
  select ship_id
  from ships
  WHERE ((2*lifeboats)+57) - capacity IN (lifeboats *20,Lifeboats+LENGTH);
  select ship_id,
    ship_name,
    lifeboats,
    capacity
  from ships
  WHERE ship_name         IN ('Codd Elegance','Codd Victorious')
  and (lifeboats          >= 80
  and lifeboats           <=100)
  and capacity / lifeboats > 25;
  -- =============================================================================
  -- Chapter 6
  -- =============================================================================
  select *
  from dual;
  select sysdate from dual;
  -- Type in 215
  
  
  select firstname, lastname 
  from customers
  where lower(lastname) = 'morales' ;
  
  select employee_id,
    last_name
  from employees
  WHERE upper(last_name) = 'SMITH';
  
  
  select firstname || ' ' || lastname
  from customers;
  
  select concat('This is the full name ',concat(concat(firstname,' '),lastname))
  from customers;
  
  select lastname, firstname from customers;
  select employee_id,
    last_name
  from employees
  WHERE initcap(last_name) = 'Smith';
  select lastname, firstname from customers;
  select firstname || ' ' || lastname AS fullname from customers;
  select firstname || ' ' || lastname from customers;
  select 'Hello, ' || 'World!' from dual;
  select concat(concat(firstname,' '),lastname) from customers;
  select * from BOOK_CONTENTS;
  -- Type in 216
  select initcap('napoleon'),
    initcap('RED O''BRIEN'),
    initcap('McDonald''s')
  from dual;
  
  -- Type in 218
  select *
  from book_contents;
  
  select lpad('Apple',10,'%') from dual;
  
  select rpad (chapter_title
    || ' ',40,'.')
    || lpad(' '
    || PAGE_NUMBER,40,'.') "table of Contents"
  from book_contents
  orDER BY book_content_id;
  
  
  
  -- page_number;
  select LENGTH(last_name) from employees;
  
  select instr('Mississippi','is',-3,1) from dual;
  select soundex('Rogers') from dual;
   
  select ship_name, LENGTH(ship_name) from ships;
  select rpad (CHAPTER_TITLE
    || ' ',30,'.')
  from book_contents
  orDER BY page_number;
  select chapter_title from book_contents;
  -- Type in 219
  select rtrim ('Seven thousand--------','-') from dual;
  -- Type in 220
  select instr ('Mississippi', 'is',1,2) from dual;
  select * from dual;
  -- Type in 221
  select SUBSTR('Name: MARK KENNEDY',7, 4) from dual;
  select SUBSTR('Name: MARK KENNEDY',7, 4) from cruises;
  
  select soundex('Rogers') from dual;
  
 select round(16.355143,-2) from dual;
  
 select trunc(6366.355143,-2) from dual;
 
 select remainder(9,3),  remainder(10,3),  remainder(11,3) 
 from dual;
 
 select mod(9,3),  mod(10,3),  mod(11,3) from dual;
 
 select floor(2.99) from dual;
 select floor(-2.99)from dual;
 select floor(-2.99)from dual;
 
 
 
 select ceil(2.99)from dual;
 select ceil(-2.99)from dual;
 
 desc employees;
 
 select ROUND(2.50)from dual;
 select ROUND(-2.99)from dual;
 select TRUNC(2.49)from dual;
 select TRUNC(-2.99)from dual;
 select soundex('billy') , soundex('rogers') from dual;
  select * from cruises;
  select ROUND(-2.55,0) from dual;
  select TRUNC(-2.99,0) from dual
  select SUBSTR('Name: MARK KENNEDY',12) from dual;
  select mod(11,3) from dual;
  select remainder(11,3) from dual;
  select remainder(17,4) from dual;
 
 
-- billy to look up 
select systimestamp today,
  ROUND(systimestamp),
  ROUND(systimestamp, 'HH'),
  ROUND(systimestamp, 'HH24')
from dual;
 
select sysdate today,
  ROUND(sysdate, 'DD'),
  ROUND(sysdate, 'MM'),
  ROUND(sysdate, 'RR')
from dual;
 
select sysdate today,
  trunc(sysdate, 'DD'),
  trunc(sysdate, 'MM'),
  trunc(sysdate, 'RR')
from dual;
 
 
  select next_day('27-JUN-12','Saturday') from dual;
  select next_day(sysdate,'Wed') from dual;
  select ROUND(last_day(sysdate)+1,'YY') from dual;
  select add_months(sysdate,2) from dual;
  select months_between('27-MAY-11',sysdate) from dual;
  select (sysdate - to_date('27-JUN-11 20:54:00','dd-MM-YY HH24:MI:SS'))/365
  from dual;
  select numtoyminterval(27,'MONTH') from dual;
  select numtoyminterval(27,'YEAR') from dual;
  select numtoyminterval(sysdate,'YEAR') from dual;
  select numtodsinterval(1440, 'MINUTE') from dual;
  select * from orders;
  select shipdate, orderdate from orders;
  select shipdate, orderdate from orders WHERE shipdate IS NULL;
  select shipdate, NVL(shipdate,sysdate) from orders WHERE shipdate IS NULL;
  select * from scores;
  select updated_test_score,
    DECODE(updated_test_score, 95, 'A', 75, 'C', 83, 'B') AS grade
  from scores;
  select updated_test_score,
    CASE
      WHEN updated_test_score BETWEEN 90 and 100
      THEN 'A'
      WHEN updated_test_score>80
      THEN 'B'
      WHEN updated_test_score>70
      THEN 'C'
        -- else 'Fail'
    END grade
  from scores;
  select shipdate, NVL(shipdate,sysdate) from orders WHERE shipdate IS NULL;
  select * from scores;
  select test_score, updated_test_score from scores;
  -- Type in 222
  select soundex('William'), soundex('Rogers') from dual;
  -- Type in 223
  select ROUND(12.355143, 2), ROUND(259.99,-1) from dual;
  select cost,
    retail,
    retail       -cost,
    ROUND((retail-cost),0),
    TRUNC((retail-cost),0)
  from books;
  select ROUND(-2.49), ROUND(-2.51),TRUNC(-2.49), TRUNC(-2.51) from dual;
  --select cost, retail, retail-cost, TRUNC((retail-cost),0) from books;
  select remainder(28,9)
  from dual;
  select remainder(27,8) from dual;
  select remainder(28,9) from dual;
  select remainder(28,9) from dual;
  select remainder(35,8) from dual;
  select remainder(29,8) from dual;
  select remainder(7,4) from dual;
  select mod(17,4) from dual;
  select mod(45,9) from dual;
  select remainder(11,3) from dual;
  select remainder(7,5) from dual;
  select mod(7,6) from dual;
  -- Type in 224 top
  select TRUNC(12.355143,2), TRUNC(259.99,-2)from dual;
  select ROUND(12.355143,2), ROUND(259.99,-1)from dual;
  -- Type in 224 bottom
  select remainder(9,3),
    remainder(10,3),
    remainder(11,3)
  from dual;
  -- Type in 227
  select sysdate today,
    ROUND(sysdate,'mm') rounded_month,
    ROUND(sysdate,'rr') rounded_year,
    ROUND(sysdate,'dd') rounded_day,
    TRUNC(sysdate,'mm') truncated_month,
    TRUNC(sysdate,'rr') truncated_year,
    TRUNC(sysdate,'dd') truncated_day
  from dual;
  select orderdate,ROUND(orderdate,'mm') from orders;
  select sysdate, next_day(sysdate, 'WEDNESDAY') from dual;
  select last_day('14-FEB-11'),last_day('14-FEB-12') from dual;
  select to_date('16/02/11 ','dd/mm/yy')from dual;
  select ROUND(to_date('16-FEB-11','dd-mm-yy'),'mm') from dual;
  select add_months(sysdate,12) from dual;
  select months_between(sysdate,'01-FEB-12') from dual;
  select to_number('$17,000.23', '$99,999.99') from dual;
  select NUMTOYMINTERVAL(27.5,'YEAR') from dual;
  select NUMTOYMINTERVAL(27,'MONTH') from dual;
  create table mytest
    (one INTERVAL YEAR TO MONTH
    );
  insert into mytest values
    ('27-3'
    );
  select * from mytest;
  select NUMTODSINTERVAL(1440,'SECOND') from dual;
  select NUMTODSINTERVAL(12,'HOUR') from dual;
  select NVL(shipdate,sysdate) from orders;
  select * from scores;

  select test_score,
    updated_test_score,
    NULLIF(test_score, updated_test_score) newscore
  from scores;
  
  
  
  select state from customers;
  select state,
    DECODE (state, 'CA', 'California', 'FL', 'Florida', 'WA', 'Washington' , 'Other')
  from customers;
  -- Type in 228
  select add_months('31-JAN-11',1),
    add_months('01-NOV-11',4)
  from dual;
  -- Type in 229
  select ROUND(months_between('12-JUN-14','03-OCT-13'),2) rnd
  from dual;
  -- Type in 230
  select NUMTODSINTERVAL(36,'HOUR') from DUAL;
  -- Type in 231
  select NVL(NULL,0) FIRST_ANSWER,
    14+NULL-4 SECOND_ANSWER,
    14+NVL(NULL,0)-4 THIRD_ANSWER
  from DUAL;
  -- Type in 233 top
  select SHIP_NAME,
    CAPACITY,
    CASE CAPACITY
      WHEN 2052
      THEN 'MEDIUM'
      WHEN 2974
      THEN'LARGE'
    END AS "SIZE"
  from SHIPS
  WHERE SHIP_ID <= 4;
  
  -- Type in 233 bottom
  -- if a12 and arg2 the same then return null
  -- othwerwise return arg2
  select TEST_SCorE,
    UPDATED_TEST_SCorE,
    NULLIF(UPDATED_TEST_SCorE,TEST_SCorE) REVISION_ONLY,
    NULLIF(UPDATED_TEST_SCorE,null) REVISION_ONLY2,
    'this' || null || 'more' as temp
  from SCorES;
  
 create table dept
 ( DEPTNO number,
   DNAME  varchar2(25),
   LOC    varchar2(25));
---------- -------------- ----------
insert into dept values(10, 'ACCOUNTING','NEW YorK');
insert into dept values(20, 'RESEARCH','DALLAS');
insert into dept values(30, 'SALES'   ,'CHICAGO');
insert into dept values(40, 'OPERATIONS','BOSTON');
 commit; 
 
select * from dept;
insert into (select * from dept where deptno=10)
values (60, 'ESales', 'Austin');

insert into (select * from dept)
values (60, 'ESales', 'Austin'); 
 
  
  -- Type in 236
  create table calls
    ( call_id       NUMBER, 
      call_date_tz  TIMESTAMP WITH TIME ZONE);
  insert into calls(call_id,call_date_tz)
    values(1,to_timestamp_tz('24-MAY-12 10:15:30', 'DD-MON-RR HH24:MI:SS'));
  
  select systimestamp from dual;
  select sysdate, to_timestamp_tz(sysdate, 'DD-MON-RR HH24:MI:SS') from dual;
  select * from calls;
  
  -- Page 237
  -- What are nls_parameters already?
  -- these parameters are set when oracle is installed and canbe changed
  -- by the SQL programmer for adhoc data conversion.
  
  select * from nls_session_parameters;
  
  
  select * from nls_database_parameters;
  -- Notice the NLS_NUMERIC_CHARACTERS in the nls_session_parameters table
  -- they come back as period (dot) and comma (,)
  -- the first one represents what to expect for the D(decimal) 
  -- and the second represents what to expect for the G(grouping--think thousands separator)
  -- so lets say we have a string representing a traditionally formatted number
  
  create table funnynums(one   varchar2(25));
  
  -- NLS_NUMERIC_CHARACTERS	.,
  
  delete from funnynums;
  insert into funnynums values ('17,000.23');
  
  -- then lets use the default values of nls_numeric_characters;
  -- no third parameter in the to_number function
  
  select to_number(one,'999,999.99') from funnynums;
  select to_number(one,'999G999D99') from funnynums;
  
  select to_number(one,'999G999D99')-1000 from funnynums;
  -- prove this is a number not a string by doing some math
  --
  select to_number(one,'999G999D99')-15250 from funnynums;
  --
  -- this says look in the nls_session_parameters table and get 
  -- the first value and use that for the decimal character (in the string)
  -- get the second value and use that as the grouping character (in the string)
  -- ok so we can use the default values if our text looks like a number
  -- like this '17,000.23'
  --
  -- what if you have something unusual for characters in your strings
  -- lets say the hash (#) for the decimal and the * for the grouping characters in your string
  --
  delete from funnynums;
  insert into funnynums values ('17*000#23');
  
  select one from funnynums;
  
  
  --
  -- now we have to use the third parameter to change these numeric characters temporarily
  select to_number(one,'999G999D99', 'nls_numeric_characters=''#*'' ' ) from funnynums;
    
  -- we can prove it is a number now by doing math
  select to_number(one,'999G999D99', 'nls_numeric_characters=''#*'' ' )-16000 from funnynums;
  -- one more example just for fun is 
  
  -- other paramters may impact other strings like setting the language to French
  -- may change the date output
  select TO_CHAR(sysdate, 'DD/MONTH/YYYY', 'nls_date_language = FRENCH') from dual;
  
  select to_number('$17,000.23','$999,999.99') + 35000 from dual;
  select to_number('$17:000,23','$999G999D99', 'nls_numeric_characters='',:''') + 55500
  from dual;
  select LENGTH(TO_CHAR('hello  ')) from dual;
  select TO_CHAR(198000,'$999,999.99') from dual;
  
  select TO_CHAR(sysdate,'DAY, "THE" DD "OF" MON, RRRR') from dual;
  
  -- Type in 237
  select to_number('17.000,23','999G999D99','nls_NUMBER_characters='',.'' ')
  from dual;
  -- Type in 241 middle
  select TO_CHAR(SYSDATE,'Day, "the" Dd "of" Month, RRRR')
  from DUAL;
  -- Type in 241 bottom
  select TO_CHAR(SYSDATE,'FMDay, "The" Ddth "of" Month, RRRR')
  from DUAL;
  
  
  select TO_CHAR(SYSDATE,'RR:MM:DD HH24:MI:SS') from DUAL;
  
  select TO_CHAR(sysdate, 'DD-Month-RRRR HH:MI:SS AM') from dual;
  select order#, shipdate, orderdate from orders WHERE shipdate IS NULL;
  
  
  select to_date('01.31.11','MM.DD.RR')+2 from dual;
  
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
select CURRENT_TIMESTAMP from dual;
 
-- Type in 245 middle
select TO_TIMESTAMP('2020-JAN-01 12:34:00:093423','RRRR-MON-DD HH:MI:SS:FF') + 1 EVENT_TIME
 from DUAL;
  
select TO_TIMESTAMP('2020-JAN-01 12:34:00:093423','RRRR-MON-DD HH:MI:SS:FF') EVENT_TIME
  from DUAL;


  select to_timestamp(sysdate) from dual;
  -- Page 248
  -- drop table timestamp_test;
  create table timestamp_test
    (
      dt               DATE,                          -- date & time (d&t)
      ts               TIMESTAMP,                     -- d&t (fractional seconds)
      ts_with_tz       TIMESTAMP WITH TIME ZONE,      -- d&t with tz
      ts_with_local_tz TIMESTAMP WITH LOCAL TIME ZONE -- d&t utc time (when queried gives local time)*/
    );
  
  select DBTIMEZONE from dual;
insert into timestamp_test values
  (
    sysdate,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
  );
insert into timestamp_test (dt) values
  (to_date('16-OCT-12','DD-MON-RR' ));


select   dt, TO_CHAR(dt,'RR:MM:DD HH:MI:SS') from timestamp_test;
 
  
  
select * from timestamp_test;
-- Type in 249 middle
select dbtimezone,
  sessiontimezone,
  CURRENT_TIMESTAMP
from dual;

ALTER session SET time_zone = 'Europe/London';
ALTER session SET time_zone = 'America/Chicago';

select tzabbrev,
    tzname
from v$timezone_names;
WHERE lower(TZNAME) LIKE '%london%';
  
-- Type in 250 middle
select owner,
    table_name,
    column_name,
    data_type
from all_tab_columns
WHERE data_type LIKE '%TIME%'
and owner = 'CRUISES';

select * from dba_tab_columns;
select * from all_tab_columns;
-- Type in 252 middle
select COUNT(*)
from
  ( select TZABBREV, TZNAME from V$TIMEZONE_NAMES orDER BY TZABBREV, TZNAME
  );
-- Type in 253
select dbtimezone from dual;
-- Type in 254
select sessiontimezone from dual;
select sysdate, CURRENT_DATE,CURRENT_TIMESTAMP, localtimestamp from dual;
-- Type in 255
select SYSTIMESTAMP from DUAL;
-- Type in 257
select from_tz(TIMESTAMP '2012-10-12 07:45:30', '+07:30')
from dual;
  
-- Type in 258
select to_timestamp_tz('17-04-2013 16:45:30','dd-mm-rrrr hh24:mi:ss') "time"
from dual;

select localtimestamp(4) from dual;

select systimestamp from dual;  


select to_timestamp_tz(sysdate,'dd-mm-rrrr hh24:mi:ss') "time" from dual;

select CAST('19-JAN-10 11:35:30' AS TIMESTAMP WITH LOCAL TIME ZONE) converted
from dual;

select sys_extract_utc(TIMESTAMP '2012-07-02 20:20:00 -06:00') HQ from dual;
--  select TIMESTAMP from dual;
select TO_CHAR(sysdate,'HH:MI:SS') from dual;

select sysdate from dual;

select Extract(MINUTE from CURRENT_TIMESTAMP) minute from dual;

-- Type in 260
select sys_extract_utc(CURRENT_TIMESTAMP) "hq" from dual;

select CURRENT_TIMESTAMP dbtime from dual;

select CURRENT_TIMESTAMP at TIME zone dbtimezone dbtime from dual;
select CURRENT_TIMESTAMP at local dbtime from dual;
select to_timestamp('2011-JUL-26 20:20:00', 'RR-MON-DD HH24:MI:SS') at TIME zone dbtimezone
from dual;

select title, name from books b, publisher p WHERE b.pubid = p.pubid;
select title, name from books b JOIN publisher p ON b.pubid = p.pubid;
select title,
  name
from books
JOIN publisher USING (pubid)
WHERE catcode LIKE 'C%';
select customer#,
  oi.order#,
  title,
  retail
from orders o,
  orderitems oi,
  books b
WHERE o.order# = oi.order#
and oi.isbn    = b.isbn ;
select customer#,
  oi.order#,
  SUM(retail)
from orders o,
  orderitems oi,
  books b
WHERE o.order# = oi.order#
and oi.isbn    = b.isbn
GROUP BY customer#,
  oi.order# ;
-- =============================================================================
-- Chapter 7
-- =============================================================================
select * from orders;

-- open books
ALTER table books ADD catcode varchar2(10);
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
                
                
                
                
                


  
  
  
  
  
  
  
  
  
  
  
  select firstname,
    lastname,
    o.order#,
    retail
  from customers c,
    orders o,
    orderitems oi,
    books b
  WHERE c.customer# = o.customer#
  and o.order#      = oi.order#
  and oi.isbn       = b.isbn
  orDER BY 3;
  select firstname,
    lastname,
    order#,
    retail
  from customers
  JOIN orders USING (customer#)
  JOIN orderitems USING (order#)
  JOIN books USING (isbn)
  orDER BY 3;
  select firstname,
    lastname,
    COUNT(*),
    SUM(retail)
  from customers c
  JOIN orders o
  ON c.customer# = o.customer#
  JOIN orderitems oi
  ON o.order# = oi.order#
  JOIN books b
  ON oi.isbn = b.isbn
  GROUP BY firstname,
    lastname;
  select firstname,
    lastname,
    order#
  from customers c
  JOIN orders o
  ON c.customer# = o.customer#
  JOIN orderitems oi
  ON o.order# = oi.order#
  JOIN books b
  ON oi.isbn     = b.isbn
  WHERE lastname = 'GIANA'
  and firstname  = 'TAMMY';
  select firstname,
    lastname,
    COUNT(*)
  from customers
  JOIN orders USING (customer#)
  GROUP BY firstname,
    lastname;
  HAVING lastname = 'GIANA';
  select firstname,
    lastname,
    COUNT(*)
  from customers
  JOIN orders USING (customer#)
  WHERE lastname = 'GIANA'
  GROUP BY firstname,
    lastname;
  select catcode, COUNT(*) from books GROUP BY catcode;
  select catcode,
    MIN(retail),
    AVG(retail),
    MAX(retail),
    COUNT(*)
  from books
  GROUP BY catcode
  orDER BY 1;
  select catcode, AVG(retail) from books GROUP BY catcode orDER BY 1;
  select catcode, COUNT(*) from books GROUP BY catcode;
  -- insert lastname and firstname (yourself) into next available row in customers table
  select *
  from cruises;
  select COUNT(*) from Cruises;
  select * from ship_cabins;
  select DISTINCT room_style from ship_cabins;
  select room_style,
    COUNT(*)
  from ship_cabins
  WHERE ship_id = 1
  GROUP BY room_style;
  
  
  select room_style,
    COUNT(*)
  from ship_cabins
  GROUP BY room_style
  HAVING upper(room_style) = 'SUITE'
  or upper(room_style)     = 'STATEROOM';
  select * from vendors;
  select COUNT(DISTINCT last_name),
    COUNT(ALL last_name),
    COUNT(*)
  from employees;
  select * from vendors;
  select COUNT(ALL status), COUNT(status), COUNT(*) from vendors;
  select COUNT(orderdate), COUNT(shipdate) from orders;
  select COUNT(ALL orderdate),
    COUNT(orderdate),
    COUNT(shipdate),
    COUNT(ALL shipdate)
  from orders;
  select cost from books;
  select catcode, COUNT(*), SUM(cost) from books GROUP BY catcode orDER BY 1;
  select catcode,
    COUNT(*),
    SUM(cost),
    ROUND(AVG(cost),2),
    MIN(cost),
    MAX(cost)
  from books
  GROUP BY catcode
  orDER BY 1;
  select ROUND(AVG(salary),2), median(salary) from pay_history;
  select COUNT (DISTINCT room_style) from ship_cabins;
  
  
  select sq_ft
  from ship_cabins
  order by 1;
  
  select rank(300) within group(order by sq_ft)
  from ship_cabins;
  
  select rank(225) within GROUP (orDER BY sq_ft) from ship_cabins;
  select sq_ft from ship_cabins orDER BY sq_ft;
  
select MIN(sq_ft) keep (dense_rank FIRST orDER BY guests) Smallest,
         MAX(sq_ft) keep (dense_rank FIRST orDER BY guests) Largest,
         AVG(sq_ft) keep (dense_rank FIRST orDER BY guests) avgfirst
from ship_cabins;

select sq_ft, guests
from ship_cabins
order by guests, sq_ft;

select AVg(sq_ft) keep (dense_rank last orDER BY guests) Smallest
from ship_cabins;

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




  select guests, sq_ft from ship_cabins orDER BY guests DESC, sq_ft DESC;
  select sq_ft from ship_cabins orDER BY sq_ft;
  select MAX(customer#) from customers;
  insert
  into customers
    (
      customer#,
      firstname,
      lastname
    )
    values
    (
      1025,
      'Bucky',
      'Rogers'
    );
  select COUNT(*),
    COUNT(lastname),
    COUNT(state) ,
    COUNT (referred)
  from customers;
  select COUNT(*), COUNT(DISTINCT state), COUNT(ALL state) from customers;
  --what could you always count in a row to
  --ensure you get the right count
  select COUNT(*),
    SUM(quantity)
  from orderitems;
  select MIN(retail) from books;
  select MAX(cost) from books;
  select AVG(cost), AVG(retail) from books;
  select median(retail) from books;
  select rank('COM') within GROUP (orDER BY TITLE ) from books;
  select room_type, ROUND(AVG(sq_ft),2) from ship_cabins GROUP BY room_type;
  select room_style ,
    ROUND(AVG(sq_ft),2) "avg sq ft" ,
    MIN (guests) "minimum of guests" ,
    COUNT (ship_cabin_id) "total number of cabins"
  from ship_cabins
  GROUP BY room_style;
  select * from ship_cabins;
  
  select room_type ,
    TO_CHAR(ROUND(AVG(sq_ft),2),'999,999.99') "avg sq ft" ,
    MIN (guests) "minimum of guests" ,
    COUNT (ship_cabin_id) "total number of cabins"
  from ship_cabins
  GROUP BY room_type
  orDER BY MIN(room_style);
    
  select COUNT(room_style),
    MAX(room_type),
    AVG(MAX(sq_ft))
  from ship_cabins
  GROUP BY room_type,
    room_style;
  select room_style,
    room_type,
    TO_CHAR(MIN(sq_ft),'9,999')
  from ship_cabins
  WHERE room_type IN ('Standard','Large')
  GROUP BY room_style,
    room_type
  orDER BY 3;
  select TO_CHAR(order_date, 'Q'),
    COUNT(*)
  from cruise_orders
  WHERE TO_CHAR(order_date, 'YYYY') = '2011'
  GROUP BY TO_CHAR(order_date, 'Q');
  select order_dATE, TO_CHAR(order_date, 'Q') from cruise_orders;
  select COUNT(COUNT(project_cost)) from projects GROUP BY purpose;
  select ship_id,
    MAX(days)
  from projects
  GROUP BY ship_id
  HAVING AVG(project_cost) < 50000;
  select purpose,
    AVG(project_cost)
  from projects
  WHERE days > 3
  GROUP BY purpose;
  select * from cruise_orders;
  select upper (room_type) from ship_cabins orDER BY ship_id;
  select median(cost) from books;
  select rank(20) within GROUP (orDER BY retail) from books;
  select * from books;
  -- cruises
  -- page 284
  select MAX(sq_ft) keep (dense_rank FIRST
  orDER BY guests)
  from ship_cabins;
  select sq_ft, guests from ship_cabins orDER BY guests, sq_ft;
  select * from ship_cabins orDER BY 7, 8;
  select ship_cabin_id,
    room_number,
    room_style,
    room_type,
    window,
    guests,
    sq_ft
  from ship_cabins
  WHERE ship_id = 1;
  select room_style ROUND(AVG(sq_ft), 2) from ship_cabins GROUP BY room_style;
  select * from ship_cabins;
  
  
  -- page 288 top
  select ship_cabin_id,
    room_number,
    room_style,
    room_type,
    window,
    guests,
    sq_ft
  from ship_cabins
  WHERE room_style IN ('Suite','Stateroom')
  orDER BY 3 DESC;
  
  
  -- page 288 bottom
  select room_style ,
    room_type ,
    ROUND(AVG(sq_ft),2) ,
    MIN(guests) ,
    COUNT(ship_cabin_id)
  from ship_cabins
  GROUP BY room_style,
    room_type;
  select room_style, AVG(sq_ft) from ship_cabins GROUP BY room_style;
  -- page 289
  select room_type,
    TO_CHAR(ROUND(AVG(sq_ft),2),'999,999.99'),
    MAX(guests),
    COUNT(ship_cabin_id)
  from ship_cabins
  WHERE ship_id = 1
  GROUP BY room_type
  orDER BY 2 DESC;
  -- page 290
  select TO_CHAR(ROUND(AVG(sq_ft),2),'999,999.99') ,
    MAX(guests) ,
    COUNT(ship_cabin_id)
  from ship_cabins
  WHERE ship_id = 1
  and room_type = 'Royal'
  orDER BY 1 DESC;
  select ROOM_STYLE,
    ROOM_TYPE,
    TO_CHAR(MIN(SQ_FT),'9,999') "Min"
  from SHIP_CABINS
  WHERE SHIP_ID = 1
  GROUP BY ROOM_STYLE,
    ROOM_TYPE
  HAVING ROOM_TYPE IN ('Standard', 'Large')
  or MIN(SQ_FT)     > 1200
  orDER BY 3;
  select ROOM_STYLE,
    ROOM_TYPE,
    TO_CHAR(MIN(SQ_FT),'9,999') "Min"
  from SHIP_CABINS
  WHERE SHIP_ID = 1
  GROUP BY ROOM_STYLE,
    ROOM_TYPE
  HAVING MIN(guests) >5
  or AVG(SQ_FT)      > 1200
  or ROOM_TYPEIN ('Standard', 'Large')
  orDER BY 3;
  select COUNT(*), COUNT(balcony_sq_ft) from ship_cabins;
  select COUNT(*) from ship_cabins;
  select balcony_sq_ft from ship_cabins;
  select * from ship_cabins;
  select COUNT(*) from ship_cabins;
  select * from ship_cabins;
  select SUM(balcony_sq_ft) from ship_cabins;
  select * from ship_cabins orDER BY sq_ft;
  select DISTINCT sq_ft from ship_cabins orDER BY 1;
  select rank(300) within GROUP(orDER BY sq_ft) from ship_cabins;
  select MAX(sq_ft) keep (dense_rank FIRST
  orDER BY guests) largest
  from ship_cabins;
  select MIN(sq_ft) keep (dense_rank FIRST
  orDER BY guests) smallest
  from ship_cabins;
  select MAX(sq_ft) keep (dense_rank last
  orDER BY guests) largest
  from ship_cabins;
  select MIN(sq_ft) keep (dense_rank last
  orDER BY guests) smallest
  from ship_cabins;
  select MAX(sq_ft) from ship_cabins;
  select MIN(sq_ft) from ship_cabins;
  select * from ship_cabins orDER BY 7,8;
  select room_style,
    room_type,
    TO_CHAR(MIN(sq_ft),'9,999') "Min",
    TO_CHAR(MAX(sq_ft),'9,999') "Max",
    TO_CHAR(MIN(sq_ft)-MAX(sq_ft),'9,999') "Diff"
  from ship_cabins
  WHERE ship_id = 1
  GROUP BY room_style,
    room_type
  orDER BY uid;
  select room_style,
    room_type,
    AVG(MAX(sq_ft))
  from ship_cabins
  WHERE ship_id = 1
  GROUP BY room_style,
    room_type
  orDER BY 1 DESC,
    2;
  -- page 294
  select MAX(sq_ft)
  from ship_cabins
  WHERE ship_id = 1
  GROUP BY room_style,
    room_type;
  select AVG(MAX(sq_ft))
  from ship_cabins
  WHERE ship_id = 1
  GROUP BY room_style,
    room_type
  orDER BY MAX(sq_ft);
  select COUNT(COUNT(project_cost)) from projects GROUP BY purpose;
  select purpose,
    AVG(project_cost)
  from projects
  WHERE days > 3
  GROUP BY purpose;
  HAVING days > 3;
  select room_style,
    room_type,
    MAX(sq_ft)
  from ship_cabins
  WHERE ship_id = 1
  GROUP BY room_style,
    room_type
  orDER BY 1,
    3;
  -- page 297
  select room_style,
    room_type,
    MIN(sq_ft)
  from ship_cabins
  WHERE ship_id =1
  GROUP BY room_style,
    room_type
  HAVING room_type IN ('Standard','Large')
    -- or min(sq_ft) > 1200
  orDER BY 3;
  
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
  create table clients
    (
      client# INTEGER primary key,
      lname   varchar2 (20)
    );
  create table orders
    ( order# INTEGER primary key, client# INTEGER
    );
  insert into clients values
    (100, 'SMITH'
    );
  insert into clients values
    (200, 'BELL'
    );
  insert into clients values
    (300, 'JONES'
    );
  insert into orders values
    (9,NULL
    );
  insert into orders values
    (22,200
    );
  select * from clients, orders orDER BY 1, 3;
  select * from clients c FULL JOIN orders o ON c.client# = o.client#;
  -- select all customer first and last name order#
  -- with or without orders showing
  -- orders if they have them.
  select firstname,
    lastname,
    order#
  from customers c
  LEFT JOIN orders o
  ON c.customer# = o.customer#
  WHERE order#  IS NULL;
  select c1.firstname,
    c1.lastname,
    c1.customer#,
    c2.firstname,
    c2.lastname,
    c1.referred
  from customers c1,
    customers c2
  WHERE c1.referred = C2.customer#;
  select * from customers WHERE firstname = 'LEILA';
  select a.position_id,
    a.position,
    b.position AS "boss"
  from positions a
  LEFT JOIN positions b
  ON a.reports_to = b.position_id
  orDER BY "boss";
  select * from employees;
  select * from addresses;
  select employee_id,
    first_name,
    last_name,
    street_address
  from employees NATURAL
  JOIN addresses;
  -- page 317 top
  select ship_id,
    ship_name,
    port_name
  from ships
  INNER JOIN ports
  ON home_port_id = port_id
  orDER BY ship_id;
  select ship_id,
    ship_name,
    port_name
  from ships,
    ports
  WHERE home_port_id = port_id
  orDER BY ship_id;
  select p.port_name,
    s.ship_name,
    sc.room_number
  from ports p
  JOIN ships s
  ON p.port_id = s.home_port_id
  JOIN ship_cabins sc USING (ship_id);
  -- equijoins
  -- old style
  select c.firstname,
    c.lastname,
    b.catcode,
    b.title
  from customers c,
    orders o,
    orderitems oi,
    books b
  WHERE c.customer# = o.customer#
  and o.order#      = oi.order#
  and oi.isbn       = b.isbn
  and catcode       = 'COM';
  -- new style (on)
  select firstname,
    lastname,
    catcode,
    title
  from customers c
  JOIN orders o
  ON c.customer# = o.customer#
  JOIN orderitems oi
  ON o.order# = oi.order#
  JOIN books b
  ON oi.isbn    = b.isbn
  WHERE catcode = 'COM';
  -- new style (using)
  select firstname,
    lastname,
    catcode,
    title
  from customers
  JOIN orders USING(customer#)
  JOIN orderitems USING (order#)
  JOIN books USING(isbn)
  WHERE catcode = 'COM';
  -- new styles combination
  select firstname,
    lastname,
    catcode,
    title
  from customers c NATURAL
  JOIN orders o
  JOIN orderitems oi USING (order#)
  JOIN books b
  ON oi.isbn    = b.isbn
  WHERE catcode = 'COM';
  ;
  -- nonequijoin
  select s.score_id,
    s.test_score,
    g.grade
  from scores s
  JOIN grading g
  ON s.test_score BETWEEN g.score_min and g.score_max;
  select title,
    gift
  from books b,
    promotion p
  WHERE b.retail > p.minretail
  and b.retail   < p.maxRetail;
  select title,
    gift
  from books
  JOIN promotion
  ON b.retail BETWEEN minretail and maxRetail;
  select * from employees;
  select * from addresses;
  select employee_id,
    last_name,
    street_address
  from employees NATURAL
  JOIN addresses;
  -- outer join
  drop table books.employee;
  create table books.employee
    (emp_name varchar2(13), dept_idnumber
    );
  drop table books.department;
  create table books.department
    (dept_idnumber, dept_namevarchar2(13)
    );
  BEGIN
    insert into employee values
      ('Rafferty', 31
      );
    insert into employee values
      ('Jones', 33
      );
    insert into employee values
      ('Steinberg', 33
      );
    insert into employee values
      ('Robinson', 34
      );
    insert into employee values
      ('Smith', 34
      );
    insert into employee values
      ('Johnson', NULL
      );
  END;
  /
  BEGIN
    insert into department values
      ( 31, 'Sales'
      );
    insert into department values
      ( 33, 'Engineering'
      );
    insert into department values
      ( 34, 'Clerical'
      );
    insert into department values
      ( 35, 'Marketing'
      );
  END;
  /
  select * from employee;
  select * from department;
  select * from employee JOIN department USING (dept_id);
  select * from employee LEFT OUTER JOIN department USING (dept_id);
  select * from employee RIGHT OUTER JOIN department USING (dept_id);
  select * from employee FULL OUTER JOIN department USING (dept_id);
  select * from departmentleft OUTER joinemployee USING (dept_id);
  select * from departmentright OUTER JOIN employee USING (dept_id);
  select * from departmentfull OUTER joinemployee USING (dept_id);
  select * from employee e, department d WHERE e.dept_id = d.dept_id(+);
  select * from department RIGHT OUTER JOIN employee USING (dept_id);
  select * from department LEFT OUTER JOIN employee USING (dept_id);
  select * from employee RIGHT OUTER JOIN department USING (dept_id);
  select * from employee FULL OUTER JOIN department USING (dept_id);
  select * from customers;
   
  
  select c2.firstname cfn,c2.lastname cln,c1.firstname rfn, c1.lastname rln
  from customers c1,
       customers c2
  WHERE c1.customer#=c2.referred;
  
  
  select c2.firstname cfn,c2.lastname cln,c1.firstname rfn, c1.lastname rln
    from customers c1 join customers c2
                       on c1.customer#=c2.referred;
   
  select customer#,firstname,lastname,referred
  from customers;
  
   
  
  select *
  from customers natural join orders;
  
  
  select * from customers natural join books;
  
  select * from vendors;
  
  select * from online_subscribers;
  
  select * from vendors cross join online_subscribers;
  
  select * from employee CROSS JOIN department;
  select * from employee,department;
  select * from ports;
  select * from ships;
  select ship_id,
    ship_name,
    port_name
  from ships
  RIGHT JOIN ports
  ON home_port_id = port_id
  orDER BY ship_id;
  -- page 317 bottom
  select ship_id,
    ship_name,
    port_name
  from ships
  JOIN ports
  ON home_port_id = port_id
  WHERE port_name ='Charleston'
  orDER BY ship_id;
  -- page 318 top
  select ship_id,
    ship_name,
    port_name
  from ships,
    ports
  WHERE home_port_id = port_id
  orDER BY ship_id;
  -- page 318 bottom
  select ship_id,
    ship_name,
    port_name
  from ships,
    ports
  WHERE home_port_id = port_id
  and port_name      ='Charleston'
  orDER BY ship_id;
  -- page 319 top
  select ship_id,
    ship_name,
    port_name
  from ships
  FULL OUTER JOIN ports
  ON home_port_id = port_id
  orDER BY ship_id;
  select * from ports;
  -- page 319 bottom
  select ship_id,
    ship_name,
    port_name
  from ships
  JOIN ports
  ON home_port_id = port_id(+)
  orDER BY ship_id;
  -- page 320 bottom
  select ship_id,
    ship_name,
    port_name
  from ships
  FULL JOIN ports
  ON home_port_id = port_id
  orDER BY ship_id;
  -- page 321 bottom
  select employee_id,
    last_name,
    address
  from employees
  INNER JOIN addresses
  ON employee_id = employee_id;
  -- page 323 top
  select e.employee_id,
    last_name,
    street_address
  from employees e
  INNER JOIN addresses a
  ON e.employee_id = a.employee_id;
  -- page 324 bottom
  select employee_id,
    last_name,
    street_address
  from employees
  LEFT JOIN addresses USING (employee_id);
  -- page 325 bottom
  select p.port_name,
    s.ship_name,
    sc.room_number
  from ports p
  JOIN ships s
  ON p.port_id = s.home_port_id
  JOIN ship_cabins sc
  ON s.ship_id = sc.ship_id;
  -- page 325 bottom alternate
  -- no
  select p.port_name,
    s.ship_name,
    sc.room_number
  from ports p
  JOIN ships s
  JOIN ship_cabins sc
  ON p.port_id = s.home_port_id
  ON s.ship_id = sc.ship_id;
  -- page 325 bottom alternate
  -- yes
  select p.port_name,
    s.ship_name,
    sc.room_number
  from ports p
  JOIN ships s
  ON p.port_id = s.home_port_id
  JOIN ship_cabins sc USING (ship_id) ;
  select p.port_name,
    s.ship_name,
    sc.room_number
  from ports p
  JOIN ships s
  ON p.port_id = s.home_port_id
  JOIN ship_cabins sc
  ON sc.ship_id = s.ship_id
  JOIN employees e
  ON e.ship_id = sc.ship_id;
  -- page 327
  select * from scores;
  select * from grading;
  select s.score_id,
    s.test_score,
    g.grade
  from scores s
  JOIN grading g
  ON s.test_score BETWEEN g.score_min and g.score_max;
  -- page 328
  select * from positions;
  select *
  from positions p1
  JOIN positions p2
  ON p1.position_id = p2.reports_to;
  -- page 330
  select p1.position_id,
    p2.position employee,
    p1.position reports_to
  from positions p1
  JOIN positions p2
  ON p1.position_id = p2.reports_to;
  select *
  from positions p1
  JOIN positions p2
  ON p1.position_id = p2.position_id;
  -- page 331
  -- How many columns
  -- How many rows
  select * from vendors;
  -- How many columns
  -- How many rows
  select * from online_subscribers;
  -- How many total columns
  -- How many total rows
  select *
  from vendors,
    online_subscribers;
  -- -----------------------------------------------------------------------------
  -- HandS ON EXERCISES CHAPTER 8
  -- -----------------------------------------------------------------------------
  -- 1. List employee's ID and first and last names, address, city, state,
  -- zip with new join syntax and keyword "ON"
  -- Use table aliases for all returned columns where possible
  -- from the cruises schema
  
  
  
  select e.employee_id, e.first_name, e.last_name
  from employees e;
   
  select a.employee_id,a.street_address, a.city, a.state, a.zip
  from addresses a;
  
  
  select e.employee_id,e.first_name, e.last_name,a.street_address, a.city,a.state, a.zip
  from employees e JOIN addresses a 
                    ON e.employee_id = a.employee_id;
                    
                    
  -- 2. Repeat question 1 with the keyword "USING"
  --Use table aliases for all returned columns where possible
  
  
  
  select employee_id,
    e.first_name,
    e.last_name,
    a.street_address,
    a.city,
    a.state,
    a.zip
  from employees e
  JOIN addresses a USING(employee_id);
  
  
  
  -- 3. List cruise name and captains ID,
  --    captains name address, city, state,zip 
  --    with new join syntax and keyword "ON"
  --    from cruises
  
  select c.cruise_name, e.employee_id,e.first_name,e.last_name, a.street_address, a.city, a.state,a.zip
  from employees e JOIN addresses a
                    ON e.employee_id = a.employee_id
                   JOIN cruises c
                    ON e.employee_id = c.captain_id;
  
select * from employees;
select * from cruises;
  
insert into cruises values(2,1,'Sunset',1,4,'04-OCT-12','04-OCT-12','SEA');
    
                    
-- 4. Repeat question 3 using keyword "USING"
select employee_id, e.first_name, e.last_name, a.street_address, a.city, a.state, a.zip
  from employees e JOIN cruises c
                    ON e.employee_id = c.captain_id
                   JOIN addresses a USING (employee_id);
                   
                   
                   
                   
                   
                   
  select employee_id,
    first_name,
    last_name,
    a.street_address,
    a.city,
    a.state,
    a.zip
  from employees
  JOIN addresses a USING (employee_id)
  JOIN cruises c
  ON c.captain_id = employee_id;
  
  select * from cruises;
    -- 5. insert into table cruises cruise_id = 3, cruise_type_id = 1, cruise_name = Islands
    -- ship_id = 5, captain_id = 3, start_date = 01-NOV-12, end_date = 06-NOV-12, status = SEA;
    insert into cruises values (3,1,'Islands',5,3,'01-NOV-12','06-NOV-12','SEA');
    commit;
  select * from ships;  
    
  
  -- 6. Return Cruise name, cruise ID, the captains employee ID,
  -- and captains first and last names, street, city, state, zip.
  -- use the join on technique;
  select *
  from addresses;
  select * from employees;
  select * from cruises;
  select c.cruise_name,
    c.cruise_id,
    e.employee_id,
    e.first_name,
    e.last_name,
    a.street_address,
    a.city,
    a.state,
    a.zip
  from employees e
  JOIN addresses a
  ON e.employee_id = a.employee_id
  JOIN cruises c
  ON e.employee_id = c.captain_id;
  
  -- 7a return captains name
  select c.cruise_name,
    c.cruise_id,
    e.employee_id,
    e.first_name,
    e.last_name,
    a.street_address,
    a.city,
    a.state,
    a.zip
  from employees e
  JOIN addresses a
  ON e.employee_id = a.employee_id
  JOIN cruises c
  ON e.employee_id = c.captain_id;
  
  -- 7b Return captains name, city, state, and start date, along with ship_name,
  -- cruise_name, and port_name
  select e.last_name,
    e.first_name,
    a.city,
    a.state,
    w.start_date,
    s.ship_name,
    ship_id,
    c.cruise_id,
    c.cruise_name,
    port_name
  from addresses a
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
  select *
  from ports;
  select * from ships;
  select * from projects;
  select port_name ,
    TO_CHAR(SUM(project_cost),'$999,999,999') total ,
    TO_CHAR(AVG(project_cost),'$999,999') AVG ,
    COUNT(port_id) numberprojects,
    SUM(days)*40 manhours
  from ports p
  JOIN ships s
  ON p.port_id = s.home_port_id
  JOIN projects pj
  ON s.ship_id    = pj.ship_id
  WHERE port_name = 'Baltimore'
  GROUP BY port_name,
    project_cost,
    days;
  select port_name,
    TO_CHAR(SUM(project_cost),'$999,999,999') total,
    TO_CHAR(AVG(project_cost),'$999,999') AVG,
    COUNT(   *) NumberProjects,
    SUM(days)*40 ManHours
  from ports p ,
    ships s ,
    projects pj
  WHERE p.port_id = s.home_port_id
  and s.ship_id   = pj.ship_id
  and port_name   = 'Baltimore'
  GROUP BY port_name;
  -- 9 Using just the scores table return the test score and letter grade
  -- using a case statement and these rules
  -- LETTER GRADE SCorE RANGE
  -- ---------------------------------
  --A 87-100
  --B 75-86
  --C 63-74
  --D 51-62
  --F 0-50
  select score_id ,
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
  from scores;
  select
    CASE test_score
      WHEN '95'
      THEN 'A'
      WHEN '83'
      THEN 'B'
      WHEN '55'
      THEN 'D'
    END AS myscore
  from scores;
  select
    CASE
      WHEN test_score BETWEEN 90 and 100
      THEN 'A'
      WHEN test_score BETWEEN 80 and 89
      THEN 'B'
      WHEN test_score BETWEEN 70 and 79
      THEN 'A'
    END AS myscore
  from scores;
  DESC scores;
  
  create table scores2
    (score_id INTEGER, test_score INTEGER
    );
  insert into scores2 values
    (1, 95
    );
  insert into scores2 values
    (2, 85
    );
  insert into scores2 values
    (3, 75
    );
  select
    CASE test_score
      WHEN 95
      THEN 'A'
      WHEN 85
      THEN 'B'
      WHEN 75
      THEN 'D'
    END AS myscore
  from scores2;
  select
    CASE
      WHEN test_score >= 95
      THEN 'A'
      WHEN test_score >= 85
      THEN 'B'
      WHEN test_score >= 75
      THEN 'D'
    END AS myscore
  from scores2;
  DESC scores2;
  select
    CASE
      WHEN test_score BETWEEN 90 and 100
      THEN 'A'
      WHEN test_score BETWEEN 80 and 89
      THEN 'B'
      WHEN test_score BETWEEN 70 and 79
      THEN 'A'
    END AS myscore
  from scores2;
  select * from scores;
  DESC scores;
  -- 10. Disconnect from cruises
  -- Connect to books
  -- Return first and last names of customers with first and last name of who referred them
  -- For those who were self-refered return null.
  select *
  from CUSTOMERS;
  select * from customers c JOIN customers c1 ON c.customer# = c1.referred;
  select C1.CUSTOMER#,
    C2.FIRSTNAME,
    C2.LASTNAME,
    C2.REFERRED REFERRED_BY,
    C1.FIRSTNAME,
    C1.LASTNAME
  from customers c1
  JOIN customers c2
  ON c1.customer# = c2.referred;
  select C2.CUSTOMER#,
    C2.FIRSTNAME,
    C2.LASTNAME,
    C2.REFERRED,
    C1.FIRSTNAME,
    C1.LASTNAME
  from CUSTOMERS C1
  RIGHT JOIN CUSTOMERS C2
  ON C1.CUSTOMER# = C2.REFERRED;
  select C2.CUSTOMER#,
    C2.FIRSTNAME,
    C2.LASTNAME,
    C1.FIRSTNAME,
    C1.LASTNAME
  from CUSTOMERS C1
  RIGHT JOIN CUSTOMERS C2
  ON c1.customer# = c2.referred;
  select C2.CUSTOMER#,
    C2.FIRSTNAME,
    C2.LASTNAME,
    C1.FIRSTNAME,
    C1.LASTNAME
  from CUSTOMERS C1
  RIGHT JOIN customers c2
  ON C1.CUSTOMER# = C2.REFERRED;
  -- =============================================================================
  -- Chapter 9
  -- =============================================================================
  -- page 350 top
  select * from employees;
  
  
  select ship_id
  from employees
  WHERE last_name = 'Lindon'
  and first_name  = 'Alice';
  -- page 350 bottom
  select employee_id,
    last_name,
    first_name
  from employees
  WHERE ship_id      = 3
  and NOT (last_name = 'Lindon'
  and first_name     = 'Alice');

-- page 351 top
select employee_id, last_name, first_name
from employees
  WHERE ship_id =
                ( select ship_id
                   from employees
                   WHERE last_name = 'Lindon'
                     and first_name  = 'Alice'
                )
  and NOT last_name = 'Lindon';
  
select * 
from emp_benefits;

select count(*)
from books;
  
  -- page 351 bottom
select employee_id,last_name,first_name
  from employees
  WHERE ship_id IN
                  ( 
                   select ship_id from employees WHERE last_name = 'Smith'
                  );
                  
  --and NOT last_name = 'Smith';
  
  
  select employee_id,last_name,first_name, ship_id
  from employees
  WHERE ship_id > ANY
                  ( 
                    select ship_id from employees WHERE last_name = 'Smith'
                  )
  and NOT last_name = 'Smith';
  
  select * from employees;
  
  
  
  select * from employees;
  select * from cruise_customers;
  
  select * from cruise_customers;
  
insert into cruise_customers values (4,'Alice','Lindon');
commit;
  
  commit;
  
-- page 353
select employee_id, last_name,first_name, ssn
from employees
WHERE ship_id IN
                ( select ship_id from employees WHERE last_name = 'Smith'
                ) ;
  
  
  
  
  
 -- page 354 (same as page 353 with in operator)
  select ship_id,
    last_name,
    first_name
  from employees
  WHERE ship_id IN ( select ship_id from employees WHERE last_name = 'Smith' );
    
    
    
  select invoice_id
  from invoices
  WHERE (first_name, last_name ) IN ( select first_name, last_name from cruise_customers ) ;
  
  select * from invoices;
  select * from cruise_customers;

  select *
  from employees
  WHERE (first_name, last_name ) IN ( select first_name, last_name from cruise_customers ) ;

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
  select employee_id, first_name, last_name
  from employees
  WHERE (first_name, last_name ) IN
    ( select first_name, last_name from cruise_customers
    )
  and ship_id = 3;
  
  select * from cruise_customers;
  
  insert into criuses_customers values (10, 'Buffy', 'Worthington' );
  select vendor_name,
    (select terms_of_discount from invoices i WHERE invoice_id = 1
    ) discount
  from vendors v;
  
  select * from vendors;
  select * from invoices;
  select room_style, AVG(sq_ft) from ship_cabins GROUP BY room_style;
  
  
  
select *
  from projects
  WHERE project_cost <= ANY
                        ( select project_cost from projects WHERE purpose = 'Maintenance'
                        order by 1 desc
                        )
and purpose = 'Upgrade';
  
select * from projects order by project_cost;
  
  
  
  select project_cost, purpose
  from projects
  WHERE project_cost >= ALL
                    (select project_cost from projects WHERE purpose = 'Upgrade'
                    );
  
select * from projects;

select project_cost, purpose from projects WHERE purpose = 'Upgrade';
  -- page 357
  select * from invoices;
  select * from pay_history;
  UPDATE invoices SET invoice_date = '04-JUN-01',total_price    =37450
  WHERE invoice_id = 7;
  select invoice_id
  from invoices
  WHERE (invoice_date, total_price ) =
    ( select start_date, salary from pay_history WHERE pay_history_id = 4
    ) ; -- empty set
  -- page 358
  select vendor_name,
                      (select terms_of_discount from invoices WHERE invoice_id = 1
                      ) AS discount
  from vendors
  orDER BY vendor_name;



  
  -- page 359
  
  insert into employees (employee_id,ship_id)
    values(seq_employee_id.nextval,
      (select ship_id from ships WHERE ship_name = 'Codd Champion'
      )
    );
    
    
    
  ROLLBACK;
  
  -- page 361 top
  select a.ship_cabin_id,a.room_style,a.room_number,a.sq_ft
  from ship_cabins a
  WHERE a.sq_ft >
                  (select AVG(sq_ft) from ship_cabins WHERE room_style = a.room_style
                  )
  orDER BY 2;
  
  select * from ship_cabins;
  
  
  
  select * from books;
  
  select *
  from books b
  WHERE retail >= 
    (select AVG(retail) from books WHERE catcode = b.catcode    )
  orDER BY isbn;
  
  
  
  
  UPDATE books b SET retail = retail *1.1
  WHERE retail <=
                  (select AVG(retail) from books WHERE catcode = b.catcode
                  );
    
    select * from books;
    
    
    
    
    
  select * from books orDER BY isbn;
  -- page 361 bottom
  select room_style,
    AVG(sq_ft)
  from ship_cabins
  GROUP BY room_style;
 -- page 363
UPDATE invoices inv
SET terms_of_discount = '10 pct'
WHERE total_price =
                    ( select MAX(total_price)
                      from invoices
                      WHERE TO_CHAR(invoice_date, 'RRRR-Q') = TO_CHAR(inv.invoice_date, 'RRRR-Q')
                    );

    
  ROLLBACK;
  
  
  -- page 364
  UPDATE ports p
  SET capacity = (
                    select COUNT(*) from ships WHERE home_port_id = p.port_id
                  )
  WHERE EXISTS
              ( 
                    select * from ships WHERE home_port_id = p.port_id
              );
              
              
  select * from ports;
  select * from ships;
  
  -- page 365 top
  select *
  from ship_cabins s1
  WHERE s1.balcony_sq_ft =
    (select MIN(balcony_sq_ft)
    from ship_cabins s2
    WHERE s1.room_type = s2.room_type
    and s1.room_style  = s2.room_style
    );
  ROLLBACK;
  select *
  from books b1
  WHERE cost <
    (select AVG(cost) from books b2 WHERE b1.catcode = b2.catcode
    );
  select firstname,
    lastname,
    title,
    retail
  from customers c
  JOIN orders USING (customer#)
  JOIN orderitems USING (order#)
  JOIN books USING (isbn)
  WHERE retail =
    (select MIN(retail) from books
    );
    
    
    
    
    
WITH PorT_BOOKINGS AS
  (select P.PorT_ID,P.PorT_NAME, COUNT(S.SHIP_ID) CT
  from PorTS P, SHIPS S
  WHERE P.PorT_ID = S.HOME_PorT_ID
  GROUP BY P.PorT_ID,
    P.PorT_NAME
  ),
  densest_port AS
  ( select MAX(CT) MAX_CT from PorT_BOOKINGS
  )
select PorT_NAME
from PorT_BOOKINGS
WHERE CT =
  (select MAX_CT from DENSEST_PorT
  );
-- page 365 bottom
select port_id,
  port_name
from ports p1
WHERE EXISTS
  (select * from ships s1 WHERE p1.port_id = s1.home_port_id
  );
-- page 366
WITH 
  port_bookings AS
      (
      select p.port_id, p.port_name,COUNT(s.ship_id) ct
        from ports p,ships s
       WHERE p.port_id = s.home_port_id
       GROUP BY p.port_id,p.port_name
      ),
  densest_port AS
     ( 
       select MAX(ct) max_ct from port_bookings
     )
select port_name
from port_bookings
WHERE ct = (select max_ct from densest_port);

select * from port_bookings;


create table mytesttable as
select firstname, lastname from customers;

  
-- -----------------------------------------------------------------------------
-- HandS ON EXERCISES CHAPTER 9
-- ----------------------------------------------------------------------------
--***-- 7-1 Return the title, retail
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
-- shipped to state is the same as order 1014
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
select *
from ports
WHERE capacity >
              ( 
                select AVG(capacity) from ports
              );
-- 2. What is the name of Joe Smith's captain on cruise_id = 1?
-- Return the ship_id, cruise_id, the captains first and last name
select * from cruises;
-- captain_id = 3
select * from employees;
-- mike west (emp_id 3) and al smith (emp_id 5) both have 4 (ship_id)
select e.ship_id, c.cruise_id, c.captain_id, e.first_name, e.last_name
from cruises c JOIN employees e
                ON c.captain_id = e.employee_id
WHERE e.ship_id =
                  (select ship_id
                  from employees
                  WHERE first_name = 'Joe'
                  and last_name    = 'Smith'
                  )
and cruise_id = 1;

select * from cruises;
select * from employees;


-- 3. Return all columns from ship cabins that has bigger than the avg
--size balcony for the same room type and room style
select *
from ship_cabins s
WHERE balcony_sq_ft >
  (select AVG(balcony_sq_ft)
  from ship_cabins
  WHERE s.room_type = room_type
  and s.room_style  = room_style
  );
select room_type,
  room_style,
  AVG(balcony_sq_ft)
from ship_cabins
GROUP BY room_style,
  room_type;
select * from ship_cabins;
select *
from ship_cabins s1
WHERE s1.balcony_sq_ft >=
  (select AVG(balcony_sq_ft)
  from ship_cabins s2
  WHERE s1.room_type = s2.room_type
  and s1.room_style  = s2.room_style
  );
-- 4. Return employee id and ship id from work_history
--for the employee who has the worked the longest on that ship
select *
from work_history;
select employee_id,
  ship_id
from work_history w
WHERE (end_date - start_date) =
  (select MAX(end_date-start_date) from work_history WHERE w.ship_id = ship_id
  ) ;
select employee_id,
  ship_id
from work_history w1
WHERE ABS(start_date         - end_date) =
  (select MAX(ABS(start_date - end_date))
  from work_history
  WHERE ship_id = w1.ship_id
  );
select employee_id,
  ship_id
from work_history w1
WHERE ABS(start_date     - end_date) >= ALL
  (select ABS(start_date - end_date)
  from work_history
  WHERE ship_id = w1.ship_id
  );
--5. Return ship_name and port_name
-- for the ship with the maximum capacity in each home_port
-- ----------------------------------------------------------------------------
select s1.ship_name,
  (select port_name from ports WHERE port_id = s1.home_port_id
  ) home_port
from ships s1
WHERE s1.capacity =
  ( select MAX(capacity) from ships s2 WHERE s2.home_port_id = s1.home_port_id
  );
-- ----------------------------------------------------------------------------
select sh.ship_name,
  pt.port_name,
  sh.capacity
from ships sh
JOIN ports pt
ON sh.home_port_id                    = pt.port_id
WHERE (sh.home_port_id, sh.capacity) IN
  ( select home_port_id, MAX(capacity) from ships GROUP BY home_port_id
  );
-- ----------------------------------------------------------------------------
select s1.ship_name,
  port_name
from ports p
JOIN ships s1
ON p.port_id      = s1.home_port_id
WHERE s1.capacity =
  ( select MAX(capacity) from ships s2 WHERE s2.home_port_id = s1.home_port_id
  );
select * from ships;
select home_port_id, MAX(capacity) from ships s2 GROUP BY home_port_id;
-- -----------------------------------------------------------------------------
-- DO Hand ON EXERCISES Chapter 7 (slides) handouts at home for Saturday
-- -----------------------------------------------------------------------------
-- 7-1
-- Books with retail < average retail for all books
select title,Retail
from Books
WHERE Retail >=
              (
                select AVG(Retail) from Books
              );
select title,Retail
from Books
WHERE Retail >= ALL
  ( select AVG(Retail) from Books GROUP BY category
  );
-- -----------------------------------------------------------------------------
-- 7-2
-- Books that cost < than other books in same category
-- lowest or cheapest retail value in each category
select title,b1.category, b1.retail
from books b1,
    (select category, MIN(retail) myretail from books GROUP BY category
     ) b2
WHERE b1.retail = b2.myretail
and b1.category = b2.category;

select title, category, retail
from books b1
WHERE b1.retail <=
                (
                  select MIN(retail) from books b2 WHERE b1.category = b2.category
                );
select * from invoices;
select port_id,port_name from ports p1
WHERE EXISTS
            ( select * from ships s1 WHERE p1.port_id = s1.home_port_id
            );
create table mytest AS (select * from ships s1);
select * from mytest;
create table mytest2 AS (select ship_name from ships );
select * from mytest2;

select title, b1.catcode,cost,Avgcost
from books b1 ,
  ( select catcode, AVG(Cost) Avgcost from Books GROUP BY catcode
  ) b2
WHERE b1.catcode = b2.catcode
  and b1.cost      < b2.avgcost;
  
select title, cost from books WHERE catcode = 'COM';
-- -----------------------------------------------------------------------------
-- 7-3
-- orders shippd to same state as order 1014
select order#, shipstate
from orders
WHERE shipstate IN
                (
                  select shipstate from orders WHERE order# = 1014
                );

select order#, shipstate
from orders
WHERE (order#, shipstate) IN
                            (
                              select order#, shipstate from orders WHERE order# = 1014
                            );
select order#, shipstate
from orders
WHERE shipstate =
                    ( select shipstate from orders WHERE order# = 1014
                    );
-- -----------------------------------------------------------------------------
-- 7-4
-- orders with total amount > order 1008
select order#, SUM(quantity*retail)
from orderitems oi,
     books b
WHERE oi.isbn = b.isbn
GROUP BY order#
HAVING SUM(quantity *retail) >
              (
                select SUM(quantity*retail)
                from orderitems oi,
                     books b
                 WHERE oi.isbn = b.isbn
                 and order#    = 1008
                GROUP BY order#
              );

select oi.order#, SUM(retail*quantity) total2
from orderitems oi ,
  books b1
WHERE oi.isbn = b1.isbn
GROUP BY oi.order#
HAVING SUM(retail*quantity) >
                (select SUM(retail*quantity) total1
                  from orderitems oi ,
                       books b
                  WHERE oi.isbn = b.isbn
                    and order#    = 1008
                    -- group by order#
                );
select oi.order#, SUM(retail*quantity) total2
from orderitems oi
JOIN books b1 USING (isbn)
GROUP BY oi.order#
HAVING SUM(retail *quantity) >
                  (
                    select SUM(retail*quantity) total1
                    from orderitems oi
                    JOIN books b USING (isbn)
                    WHERE order# = 1008
                  );
-- -----------------------------------------------------------------------------
-- 7-5
-- Which author(s) wrote most frequently purchased book
-- find the title most frequently purchased
-- then bring back the authors
select title,lname,fname,SUM(quantity) myqty
from orderitems JOIN books USING (isbn)
                JOIN bookauthor USING(isbn)
                JOIN author USING (authorid)
GROUP BY title, lname, fname
HAVING SUM(quantity) =
                      (
                        select MAX(SUM(quantity)) qty from orderitems GROUP BY isbn
                      );

select title,isbn,lname,fname,SUM(quantity) qty
from orderitems JOIN books USING (isbn)
                JOIN bookauthor USING (isbn)
                JOIN author USING (authorid)
GROUP BY title,isbn,lname,fname
HAVING SUM(quantity) =
                    ( 
                      select MAX(SUM(quantity)) qty from orderitems GROUP BY isbn
                    );
select title,isbn,lname,fname,SUM(quantity) qty
from orderitems JOIN books USING (isbn)
                JOIN bookauthor USING(isbn)
                JOIN author USING(authorid)
GROUP BY title,isbn,lname,fname
HAVING SUM(quantity) =
                      (
                        select MAX(SUM(quantity)) qty from orderitems GROUP BY isbn
                      );
select title, isbn, lname, fname, SUM(quantity) qty
from orderitems oi  JOIN books b USING (isbn)
                    JOIN bookauthor ba USING (isbn)
                    JOIN author a USING(authorid)
GROUP BY title,isbn,lname,fname
HAVING SUM(quantity) =
                      (
                        select MAX(SUM(quantity)) qty from orderitems GROUP BY isbn
                      );
-- test count
select b.title,b.isbn, SUM(quantity) qty
from orderitems oi ,
  books b
WHERE oi.isbn = b.isbn
GROUP BY b.title,b.isbn;
-- test author
select title,lname,fname
from books b ,
  bookauthor ba ,
  author a
WHERE b.isbn    = ba.isbn
and ba.authorid = a.authorid
and b.isbn LIKE '%490';
-- -----------------------------------------------------------------------------
-- 7-6
-- All titles in same cat customer 1007 purchased. 
-- Do not include titles purchased by customer 1007.
select distinct title, catcode
from books  JOIN orderitems USING(isbn)
            JOIN orders USING (order#)
WHERE catcode IN
                (
                  select distinct catcode
                  from orders JOIN orderitems USING (order#)
                              JOIN books USING (isbn)
                  WHERE customer# = 1007
                )
and customer# <> 1007 ;

select distinct title, catcode
from books  JOIN orderitems USING(isbn)
            JOIN orders USING (order#)
WHERE catcode IN
                (
                  select distinct catcode
                  from orders JOIN orderitems USING (order#)
                              JOIN books USING (isbn)
                  WHERE customer# = 1007
                )
and title not in 
                (select title
                 from orders join orderitems using (order#)
                             join books using (isbn)
                 where customer# = 1007
                 );




select DISTINCT title
from orders JOIN orderitems USING(order#)
            JOIN books USING(isbn)
WHERE CATCODE IN ('FAL', 'COM', 'CHN')
and customer# <> 1007;

select DISTINCT (b.title)
from books b ,
  (
      select title,
        catcode
      from orders o ,
        orderitems oi ,
        books b
      WHERE o.order# = oi.order#
      and oi.isbn    = b.isbn
      and customer#  = 1007
  ) b1
WHERE b.catcode = b1.catcode;
and b.title    <> b1.title;
-- everything purchased by customer 1007
select title, catcode
from orders o ,
  orderitems oi ,
  books b
WHERE o.order# = oi.order#
and oi.isbn    = b.isbn
and customer#  = 1007;
-- -----------------------------------------------------------------------------
-- 7-7
-- Customer# with city and state that had longest shipping delay
select customer#,city,state,shipdate-orderdate
from customers JOIN orders USING (customer#)
WHERE shipdate-orderdate =
                          (
                            select max(shipdate-orderdate) 
                             from orders WHERE shipdate IS NOT NULL
                          );
                          
                          
                          
                          
select customer#, city, state, shipdate, orderdate, shipdate - orderdate delay
from orders
JOIN customers USING (customer#)
WHERE (shipdate - orderdate) =
                              (
                                select MAX(shipdate - orderdate) delay from orders
                              );
select CUSTOMER#,CITY,STATE,SHIPDATE,orDERDATE,SHIPDATE - orDERDATE delay
from orDERS JOIN CUSTOMERS USING (CUSTOMER#)
WHERE (SHIPDATE - orDERDATE) =
                            (
                              select MAX(SHIPDATE - orDERDATE) delay from orDERS
                            );
select MAX(SHIPDATE-orDERDATE) from orders;
select * from CRUISE_orDERS;
DESC CRUISE_orDERS;
ALTER table CRUISE_orDERS
drop column FIST_TIME_CUSTOMER;
DESC CRUISE_orDERS;
ROLLBACK;
-- -----------------------------------------------------------------------------
-- 7-8
-- Who purchased least expensive book(s)
select customer#,firstname,lastname,retail
from customers  JOIN orders USING (customer#)
                JOIN orderitems USING (order#)
                JOIN books USING (isbn)
WHERE retail = 
              ( 
                select MIN(retail) from books
              );
              
              
              
              
select firstname,lastname, title
from customers c  JOIN orders o USING (customer#)
                  JOIN orderitems oi USING (order#)
                  JOIN books b USING (isbn)
WHERE retail =
                (
                  select MIN (retail) from books
                );
select firstname, lastname, title
from customers c ,
  orders o ,
  orderitems oi ,
  books b
WHERE c.customer# = o.customer#
and o.order#      = oi.order#
and oi.isbn       = b.isbn
and retail        =
                    (
                        select MIN (retail) from books
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
    








select COUNT(DISTINCT customer#)
from orders JOIN orderitems USING (order#)
            JOIN books USING (isbn)
WHERE title IN
              (
                select title
                from author
                JOIN bookauthor USING(authorid)
                JOIN books USING(isbn)
                WHERE lname = 'AUSTIN'
                and fname   = 'JAMES'
              );
-- -----------------------------------
select COUNT(DISTINCT customer#)
from orders JOIN
  (
      select title,order#
      from orders JOIN orderitems USING (order#)
                  JOIN books USING(isbn)
                  JOIN bookauthor USING (isbn)
                  JOIN author USING (authorid)
      WHERE lname = 'AUSTIN'
      and fname   = 'JAMES'
  ) USING (order#);
-- ------------------------------------
select COUNT(DISTINCT customer#)
from orders JOIN orderitems USING (order#)
            JOIN books USING (isbn)
            JOIN bookauthor USING (isbn)
            JOIN author USING (authorid)
WHERE lname = 'AUSTIN'
and fname   = 'JAMES';

select COUNT (DISTINCT customer#)
from orders o ,
  orderitems oi
WHERE o.order# = oi.order#
and oi.isbn   IN
                ( 
                  select DISTINCT b.isbn
                  from books b ,
                    bookauthor ba ,
                    author a
                  WHERE ba.isbn   = b.isbn
                  and ba.authorid = a.authorid
                  and lname       = 'AUSTIN'
                  and fname       = 'JAMES'
                );
-- books written by James Austin
select DISTINCT b.isbn
from books b ,
  bookauthor ba ,
  author a
WHERE ba.isbn   = b.isbn
and ba.authorid = a.authorid
and lname       = 'AUSTIN'
and fname       = 'JAMES';
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









select title, name
from books JOIN publisher USING (pubid)
WHERE pubid =
              (
                select pubid
                from publisher
                JOIN books USING (pubid)
                WHERE title LIKE '%WOK%'
              )
and title NOT LIKE '%WOK%';

select title
from books
WHERE pubid =
              (
                select pubid
                from publisher
                JOIN books USING (pubid)
                WHERE title = 'THE WOK WAY TO COOK'
              );

select title
from books
WHERE pubid =
            ( 
              select pubid from books WHERE title = 'THE WOK WAY TO COOK'
            );
            
select title
from books
WHERE pubid =
              (
                select pubid from books WHERE title = 'THE WOK WAY TO COOK'
              );
-- publisher of 'The Wok Way to Cook'
select pubid
from books
WHERE title = 'THE WOK WAY TO COOK';
-- -----------------------------------------------------------------------
-- a case for oracle chapter 7
-- -----------------------------------------------------------------------
-- 1.5% surcharge of all orders = $25.90
select SUM(quantity * retail) * .015
from orderitems JOIN books USING(isbn);

select SUM(thissum) * .04
from
  (select order#,
    SUM(quantity * retail) thissum
  from orderitems
  JOIN books USING(isbn)
  HAVING SUM(quantity * retail) >
    (select AVG(mysum)
    from
      (select SUM(quantity * retail) mysum
      from orderitems
      JOIN books USING(isbn)
      GROUP BY order#
      )
    )
  GROUP BY order#
  );
select SUM(quantity * retail) * .015
from orderitems oi ,
  books b
WHERE oi.isbn = b.isbn;
-- 3. sum orders above average = $58.44
select SUM(ordertot) * .04
from
  (select order#,
    SUM(quantity * retail) ordertot
  from orderitems oi ,
    books b
  WHERE oi.isbn = b.isbn
  GROUP BY order#
  HAVING SUM(quantity * retail) >
    (select AVG(quantity * retail) from orderitems JOIN books USING(isbn)
    )
  );
-- 2. orders above average
select order#,
  SUM(quantity * retail) ordertot
from orderitems oi ,
  books b
WHERE oi.isbn = b.isbn
GROUP BY order#
HAVING SUM(quantity    * retail) >
  (select AVG(quantity * retail)
  from orderitems oi ,
    books b
  WHERE oi.isbn = b.isbn
  );
-- 1. avg order
select AVG(quantity * retail)
from orderitems oi ,
  books b
WHERE oi.isbn = b.isbn;
-- 0. total amount of all orders
select SUM(quantity * retail)
from orderitems oi ,
  books b
WHERE oi.isbn = b.isbn;

-- =============================================================================
-- Chapter 10
-- =============================================================================
-- page 383
create or replace view vw_employees
AS
  select employee_id,last_name,first_name,primary_phone
  from employees
  orDER BY 1;

select * from vw_employees;
  
  DESC vw_employees;
  
  select * from vw_employees orDER BY 1;
  DESC vw_employees;
  drop VIEW vw_employees;
  DESC vw_employees;
  
  
  -- page 384
  select * from vw_employees;
  
  select employee_id, first_name || ' ' || last_name from vw_employees;
  
  
  
-- page 385 top
create or REPLACE VIEW vw_employees (A,B)
AS select employee_id, last_name || ' ' || first_name from employees;


create table mytesttable2
as select employee_id, last_name || ' ' || first_name fullname from employees;
  
  DESC vw_employees;
  -- page 385 bottom
  create VIEW emp_trend AS
  select emp.ship_id,
    MIN(salary) min_salary
  from employees emp
  LEFT JOIN pay_history pay
  ON emp.employee_id = pay.employee_id
  WHERE end_dateIS NULL
  GROUP BY emp.ship_id;
  -- page 387 top
create or REPLACE VIEW emp_phone_book
AS
  select last_name, first_name, primary_phone from employees;
  -- page 387 top
  insert
  into emp_phone_book
    (
      last_name,
      first_name,
      primary_phone
    )
    values
    (
      'Sotogovernor',
      'Sonia',
      '212-555-1212'
    );
  -- page 387 bottom
  UPDATE emp_phone_book
  SET primary_phone = '212-555-1212'
  WHERE last_name   = 'Hoddlestein'
  and first_name    = 'Howard';
  -- page 387 bottom add_on
  delete
  from emp_phone_book
  WHERE last_name = 'Hoddlestein'
  and first_name  = 'Howard';
  -- page 388
create or REPLACE VIEW emp_phone_book
AS
  select employee_id,
    first_name
    || ' '
    || last_name emp_name,
    primary_phone
  from employees;
create or REPLACE VIEW emp_phone_book
AS
  select employee_id,
    first_name,
    last_name emp_name,
    primary_phone
  from employees;
  -- page 390 top
  select a.ship_id,a.count_cabins,b.count_cruises
  from
        (select ship_id,
          COUNT(ship_cabin_id) count_cabins
        from ship_cabins
        GROUP BY ship_id
        ) a
  JOIN
        (select ship_id,
          COUNT(cruise_order_id) count_cruises
        from cruise_orders
        GROUP BY ship_id
    ) b
  ON a.ship_id = b.ship_id;

select * from ship_cabins;
select * from cruise_orders;

insert into cruise_orders values (1,sysdate,sysdate,2,1) ;
insert into cruise_orders values (2,sysdate,sysdate,2,1) ;
insert into cruise_orders values (3,sysdate,sysdate,2,1) ;

  -- page 391 top
  select rownum, invoice_id, account_number
  from
    ( 
      select invoice_id, account_number 
      from invoices 
      orDER BY invoice_date
    )
WHERE rownum <= 3;
  
select invoice_id, account_number 
from invoices
WHERE ROWNUM <=3;
  
  
  -- page 392 do this before leaving views
  -- -----------------------------------------------------------------------------
  -- Key preserved table
  -- view when more than one table
  -- If you can assert that a given row in a table will appear at most
  -- once in the view -- that table is "key preserved" in the view.
  -- key preserved table example
create table shoppers
    (
      pidINTEGER,
      pnamevarchar2(11 BYTE),
      paddress varchar2(11 BYTE),
      CONSTRAINT people_pid_PK primary key (pid)
    );
drop table shoppers;


BEGIN
  insert into shoppers(pid, pname, paddress) 
  values(10,'albert','123 main');
  insert into shoppers(pid, pname, paddress) 
  values(11,'betty','456 main');
  insert into shoppers(pid,pname,paddress)
    values(12,'charley','789 main' );
END;
create table invoices
  (
    iid INTEGER,
    pid INTEGER,
    istorevarchar2(10 byte),
    istorenum INTEGER,
    icity     varchar2(10 byte),
    iamount   NUMBER,
    CONSTRAINT invoices_iid_PK primary key (iid)
  );
drop table invoices;
BEGIN
  insert
  into invoices
    (
      iid,
      pid,
      istore,
      istorenum,
      icity,
      iamount
    )
    values
    (
      20,10,
      'kmart',
      4000,
      'Austin',
      45.55
    );
  insert
  into invoices
    (
      iid,
      pid,
      istore,
      istorenum,
      icity,
      iamount
    )
    values
    (
      30,11,
      'sears',
      5000,
      'Austin',
      12.67
    );
  insert
  into invoices
    (
      iid,
      pid,
      istore,
      istorenum,
      icity,
      iamount
    )
    values
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
ALTER table invoices ADD CONSTRAINT invoices_shoppers_pid ForEIGN KEY
(
  pid
)
REFERENCES shoppers
(
  pid
)
;
select * from invoices;
-- can't do this because duplicate column name
create or REPLACE VIEW vw_shoppers
AS
  select * from shoppers s , invoices i WHERE s.pid = i.pid;
  -- can do this because no duplicate column name
create or REPLACE VIEW vw_shoppers
AS
  select s.pid pid,
    pname,
    paddress,
    iid,
    istore,
    istorenum,
    icity,
    iamount
  from shoppers s ,
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
  create table myseminars
    (
      seminar_id   INTEGER primary key,
      seminar_name varchar2(30) UNIQUE
    );
  -- page 398 bottom
  select table_name,
    index_name
  from user_indexes
  WHERE table_name = 'MYSEMINARS';
  -- page 399 top
  select index_name,
    column_name
  from user_ind_columns
  WHERE table_name = 'MYSEMINARS';
  select index_name,
    column_name
  from user_ind_columns
  WHERE table_name = 'CRUISE_CUSTOMERS';
  -- page 400 middle
  create INDEX ix_invoice_invoice_vendor_id ON invoices
    (
      vendor_id,
      invoice_date
    );
  select index_name,
    column_name
  from user_ind_columns
  WHERE table_name = 'INVOICES';
  drop sequence junk;

create sequence JUNK minvalue 5 maxvalue 10 nocache increment BY 1 start with 6 cycle ;
select junk.currval from dual;
select junk.nextval from dual;
select * from user_indexes WHERE table_name = 'CRUISES';
select * from user_ind_columns WHERE table_name = 'CRUISES';


-- =============================================================================
-- Chapter 11
-- =============================================================================
-- page 424 :: Preparation
  drop table cruise_orders2;
  -- check to see if you have anything in cruise_orders
  select *
  from cruise_orders2;
  -- if yes then delete
  delete from cruise_orders2;
  -- check the description
  -- page 424 Bottom
create table cruise_orders2
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


   

ALTER table cruise_orders2 MODIFY cruise_order_id CONSTRAINT pk_new_constraint primary key;
ALTER table cruise_orders2 ADD CONSTRAINT pk_new_constraint primary key
(
    cruise_order_id
);
DESC cruise_orders2;
DESC cruise_orders2;
  -- page 424 Bottom add a column
  ALTER table cruise_orders2 ADD
  (
    order_date varchar2(20)
  )
  ;
  -- whoops wrong data type
  DESC cruise_orders2;
  -- skip to 427 modify a column to another data type
  ALTER table cruise_orders2 MODIFY order_date DATE;
  ALTER table cruise_orders2 MODIFY
  (
    order_date varchar2(5), sales_rep_id INTEGER
  )
  ;
  ALTER table cruise_orders2 MODIFY
  (
    order_date DATE
  )
  ;
  DESC cruise_orders2;
  -- page 425 Bottom add two columns one is not null
  -- no data yet so OK
  DESC cruise_orders2;
  select * from cruise_orders2;
  -- this works ok because no data
  ALTER table cruise_orders2 ADD ( weather_code NUMBER(2) DEFAULT 0, travel_agency varchar2(27) NOT NULL);
  DESC cruise_orders2;
  -- drop the two columns
  ALTER table cruise_orders2
  drop column weather_code;
  ALTER table cruise_orders2
  drop column travel_agency;
  DESC cruise_orders2;
  -- add some data and then retry adding the rows
BEGIN
  insert into cruise_orders2 
    values(1,22,sysdate);
  insert into cruise_orders2 
    values (2,10,sysdate);
  insert into cruise_orders2 
    values(3,72,sysdate);
  insert into cruise_orders2 
    values(4,31,sysdate );
  insert into cruise_orders2 
    values(5,54,sysdate );
END;
/
commit;
select * from cruise_orders2;
DESC cruise_orders2;
-- try page 425 Bottom again with data
DESC cruise_orders2;
ALTER table cruise_orders2 ADD ( weather_code NUMBER(2) DEFAULT 0, travel_agency varchar2(27) DEFAULT 'abc' NOT NULL);
ALTER table cruise_orders2 MODIFY travel_agency NULL;
ALTER table cruise_orders2 MODIFY travel_agency NOT NULL;
insert
into cruise_orders2 (cruise_order_id,sales_rep_id,order_date,weather_code )
  values(8,4,sysdate,2 );
select * from cruise_orders2;
-- delete the rows
delete from cruise_orders2;
-- then try to add again :: will work
ALTER table cruise_orders2 ADD ( weather_code NUMBER(2) DEFAULT 0, travel_agency varchar2(27) NOT NULL);
DESC cruise_orders2;
-- add the rows back in again
BEGIN
  insert into cruise_orders2 
    values(1, 33, sysdate, 1, 'Yes');
  insert into cruise_orders2 
    values(2, 2, sysdate, 2, 'Yes');
  insert into cruise_orders2 
    values(3, 41, sysdate, 3, 'No');
  insert into cruise_orders2 
    values(4, 55, sysdate, 1, 'Yes');
  insert into cruise_orders2 
    values(5, 83, sysdate, 2, 'No' );
END;
/
commit;
select * from cruise_orders2;
-- page 426 top
-- add a column with not null default value YES to table with data
ALTER table cruise_orders2 ADD first_time_customer varchar2(5) DEFAULT 'YES' NOT NULL;
-- what happens to the default column?
select * from cruise_orders2;
ALTER table cruise_orders2
drop column first_time_customer;
DESC cruise_orders2;
-- page 428 middle
ALTER table cruise_orders2 MODIFY (order_date DATE NOT NULL);
select * from cruise_orders2;
DESC cruise_orders2;
-- page 428 bottom
ALTER table cruise_orders2 MODIFY (order_date DATE NULL);
-- page 429 table 11-1
-- Page 430
ALTER table cruise_orders2 MODIFY order_date DATE DEFAULT sysdate CONSTRAINT nn_o_date NOT NULL;
-- page 430 bootom
ALTER table cruise_orders2 RENAME column order_date2 TO order_date;
ALTER table cruise_orders2 RENAME column sales_rep_id TO sales_agent_id;
DESC cruise_orders2;
select * from cruise_orders;
-- Page 431
DESC cruise_orders2;
ALTER table cruise_orders2
drop column order_date;
DESC cruise_orders2;
ALTER table cruise_orders2 ADD order_date DATE;
DESC cruise_orders2;
ALTER table cruise_orders2
drop (order_date);
DESC cruise_orders2;
ALTER table cruise_orders2 ADD order_date DATE;
-- Page 432
-- cannot drop a column if it is referenced by a FK in anotehr table
-- Page 433
-- unless you add the cascade constraints

-- page 434
desc cruises2;
alter table crsuies2 set unused column status;

select *
from user_unused_col_tabs;

-- Page 435
DESC cruise_orders;

alter table cruises2 drop unused columns;

alter table cruises2 set unused column end_date;
create table cruises3
as select * from cruises;


-- page 436 
desc cruise_orders2;
alter table cruise_orders2 modify cruise_order_id primary key;
delete from cruise_orders2;

select * from dba_cons_columns WHERE table_name = 'CRUISE_orDERS2';
select * from user_constraints WHERE table_name LIke '%orDERS2';
drop table cruise_orders2;

-- page 438
create table junk
  ( id INTEGER, 
    tid INTEGER, 
    mid INTEGER
  );
drop table junk;
create table junkfk
  ( id INTEGER, 
    fkid INTEGER, 
    mid INTEGER
  );
  
-- page 440 
create table junk2
( id INTEGER primary key, 
  tid INTEGER, 
  mid INTEGER
);

create table junk3
( id INTEGER not null, 
  tid INTEGER, 
  mid INTEGER
);

insert into junk3 values (null,3,4);
alter table junk3 modify id null;
  
alter table junk2 drop primary key keep index;  
  
-- drop table junkfk;
-- page 446
select constraint_name, constraint_type
from user_constraints
where table_name = 'JUNKFK';
drop table junk cascade constraints;

select table_name, constraint_name, constraint_type
from user_constraints 
where r_constraint_name in (select constraint_name 
                            from user_constraints
                            where table_name = 'PorTS'
                              and constraint_type = 'P'
                          );
select * 
from user_constraints;


-- page 450
alter table ships drop constraint fk_ships_ports;
alter table ships add constraint fk_ships_ports foreign key (home_port_id)
        references ports (port_id) on delete cascade;

select * from ports;
select * from ships;

select * 
from ports
where port_id =1;

select *
from ships
where home_port_id = 1;

delete from ports
where port_id =1;

-- page 451
alter table ships drop constraint fk_ships_ports;
alter table ships add constraint fk_ships_ports foreign key (home_port_id)
        references ports (port_id) deferrable;
set constraint fk_ships_ports deferred;
set constraint fk_ships_ports immediate;

select constraint_name, deferrable 
from user_constraints
where table_name = 'SHIPS';


alter session set recyclebin = ON;
create table houdini3 (violA varchar2(30));
insert into houdini3 values ('Peter');
commit;
drop table houdini3;
flashback table houdini3 to before drop;
select * from houdini3;

select ora_rowscn, viola
from houdini3;

select *
from user_constraints;

-- -----------------------------------------------------------------------------
-- inline constraints
-- no name for this constraint
ALTER table junk MODIFY id primary key;
select * from user_constraints where table_name = 'JUNK';
-- this names the constraint
ALTER table junk MODIFY id CONSTRAINT pk_new primary key;
select * from dba_cons_columns WHERE table_name = 'JUNK';

select * from user_constraints where table_name = 'JUNK';

ALTER table junk MODIFY id NOT NULL;
select * from user_constraints where table_name = 'JUNK';
ALTER table junk RENAME CONSTRAINT SYS_C007478 TO nn_mynew;

--ALTER table junk MODIFY id NULL;
--ALTER table junk MODIFY id CONSTRAINT nn_mynew NOT NULL;
--ALTER table junkfk MODIFY id primary key;
-- -----------------------------------------------------------------------------
-- out-of-line constraints
ALTER table junk ADD CONSTRAINT pk_new primary key (id);
ALTER table junk ADD CONSTRAINT pk_new primary key (id, tid);

-- check
ALTER table junk ADD CONSTRAINT ck_wrong CHECK (tid < id);

-- null will not work
-- alter table junk add constraint nn_wrong not null (tid);
-- fk
ALTER table junkfk ADD CONSTRAINT fk_junk 
   ForEIGN KEY(fkid) REFERENCES junk(id);
   
select * from user_constraints where table_name = 'JUNK';
desc junkfk;

ALTER table junk ADD CONSTRAINT pk_mypk primary key(id);
ALTER table junkfk
drop CONSTRAINT fk_junk;
ALTER table junk
drop CONSTRAINT pk_mypk;
drop table junk;
select * from USER_CONSTRAINTS WHERE table_NAME = 'JUNK';
ALTER table junk ADD CONSTRAINT pk_mypk primary key(id);
ALTER table junk ADD CONSTRAINT ck_wrong CHECK (tid < id);
ALTER table junk MODIFY id CONSTRAINT nn_mynew NOT NULL;
select * from USER_CONSTRAINTS WHERE table_NAME = 'JUNKFK';
ALTER table junkfk ADD CONSTRAINT my_id primary key(id);
ALTER table junkfk ADD CONSTRAINT fk_junk ForEIGN KEY(fkid) REFERENCES junk(id);
drop table junk CASCADE CONSTRAINTS;
drop table junk;
ALTER table junkfk enable VALIDATE CONSTRAINT fk_junk;
ALTER table junkfk disable CONSTRAINT fk_junk;
-- must have a primary key in other table first
--page 441
drop table junk CASCADE CONSTRAINTS;
drop table junkfk;
ALTER table
drop junk
drop primary key CASCADE;
-- will not work
-- alter table junk drop primary key;
ALTER table junk
drop primary key CASCADE;
-- page 442
ALTER table junk MODIFY id NOT NULL;
ALTER table junk MODIFY id NULL;
--page 443
create table ports3
(
    port_id   NUMBER(7),
    port_name varchar2(20),
    CONSTRAINT pk_ports primary key (port_id)
);

-- drop table ports2 CASCADE CONSTRAINTS;
create table ships3
(
    ship_id      NUMBER(7),
    ship_name    varchar2(20),
    home_port_id NUMBER(7),
    CONSTRAINT pk_ships primary key (ship_id),
    CONSTRAINT fk_sh_po ForEIGN KEY (home_port_id) 
                                      REFERENCES ports3 (port_id)
);
-- drop table ships3;
insert into ports3 values (50, 'Jacksonville' );
insert into ports3 values (51, 'New orleans');
insert into ships3 values (10, 'Codd Royale', 50);
insert into ships3 (ship_id, ship_name, home_port_id) 
                    values (11, 'Codd Ensign',51 );
select * from ports3;
select * from ships3;

-- select * from ships2;
delete from ports3 WHERE port_id = 50;
alter table ships3 disable constraint fk_sh_po;
alter table ships3 enable constraint fk_sh_po;
-- delete from ships3 WHERE home_port_id = 50;
-- delete from ports3 WHERE home_port_id = 51;

-- start here on thursday
-- page 450
select table_name, constraint_name,constraint_type
from user_constraints
WHERE r_constraint_name IN
                          (
                            select constraint_name
                            from user_constraints
                            WHERE table_name    = 'PorTS3'
                            --and constraint_type = 'P'
                          );
select * from user_constraints;

                          
                          
                          
ALTER table ships3 drop CONSTRAINT fk_sh_po;


select * from user_constraints
where table_name = 'SHIPS3';

alter table Ships3 drop constraint fk_sh_po;

ALTER table ships3 ADD CONSTRAINT fk_sh_po ForEIGN KEY (home_port_id) 
  REFERENCES ports3 (port_id) ON delete CASCADE;

select * from ports3;
select * from ships3;

delete from ports3 where port_id = 50;

select * from ports3;
select * from ships3;
delete from ports3 WHERE port_id = 50;

ROLLBACK;

-- page 455
-- in line syntax
drop table invoices4;

create table invoices40
(
    invoice_id NUMBER(11) primary key,
    invoice_date DATE
);

create table invoices4
(
    invoice_id NUMBER(11) primary key 
        USING INDEX (create INDEX ix_invoices4 
                      ON invoices4 (invoice_id)),
    invoice_date DATE
);

-- 
create table invoices5
(
    lastname varchar2(20)
);
create INDEX ix_invoices5_last_name ON invoices5 (lastname); 

-- page 456
-- out-of-line syntax
drop table invoices6;
create table invoices6
(
    invoice_id   NUMBER(11),
    invoice_date DATE,
    CONSTRAINT ck_invs_inv_id primary key (invoice_id) 
      USING INDEX (create INDEX ix_invoices6 ON invoices6
      (invoice_id ))
);

-- page 457 top
create table customers2
(
   customer_id NUMBER(11) primary key,
   last_name   varchar2(30)
);

create INDEX ix_customers_last_name2 ON customers2
  (upper(last_name));

insert into customers2
  select customer#, lastname from customers;

select * from customers2 
  WHERE upper(last_name) = 'SMITH';

select * from customers2 
  WHERE last_name = 'SMITH';

-- page 457 bottom
create table gas_tanks
(
    gas_tank_id   NUMBER(7),
    tank_gallons  NUMBER(9),
    mileage       NUMBER(9)
);

create INDEX ix_gas_tanks_001 ON gas_tanks
  (tank_gallons * mileage);

select * from gas_tanks
  where tank_gallons * mileage > 70;
  
select * from gas_tanks
  where tank_gallons > 70;

-- page 460
-- turn on flashback table to before drop for 11g XE
-- as system
-- select * from V$database;
-- select property_value from database_properties where property_name='DEFAULT_PERMANENT_tableSPACE';
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

create table houdini
( voila varchar2(30) );
insert into houdini(voila) 
  values ('Now you see it.' );
commit;
select * from houdini;
drop table houdini;
flashback table houdini TO before drop;
select * from houdini;
-- page 461
select * from user_recyclebin;
select * from recyclebin;
-- page 463
create table houdini2
  (voila varchar2(30) ) enable row movement;
select * from recyclebin;
select scn_to_timestamp(2282742) from dual;

insert into houdini2 (voila) 
  values ('Now you see it.' );
commit;
EXECUTE dbms_lock.sleep(15);
delete from houdini2;
commit;
EXECUTE dbms_lock.sleep(15);

flashback table houdini2 TO TIMESTAMP systimestamp - interval '0 00:00:20' DAY TO second;

-- doesn't work because flashback is not enabled in APEX
select ora_rowscn, voila from houdini;
select scn_to_timestamp(2285139) from dual;
select ora_rowscn, id from testjunk;
select scn_to_timestamp(2331288) from dual;


select * from all_directories;
create table cruises2 AS
select * from cruises;
DESC cruises2;
-- flashback table does not work in XE
ALTER table cruises2 SET unused column status;
flashback table cruises2 TO TIMESTAMP systimestamp - interval '0 00:05:00' DAY TO second;

drop table cruises2;
-- not enables in XE
flashback table cruises2 TO before  drop;
select * from recyclebin;
purge recyclebin;
-- not enabled in XE
create RESTorE POINT my_restore;
create table houdini3  (voila varchar2(30)) enable row movement;
insert into houdini3 (voila) values('Now you see it');
flashback table houdini3 TO TIMESTAMP systimestamp - interval '0 00:01:30' DAY TO second;
select * from houdini3;

-- -----------------------------------------------------------------------------
-- E X T E R N A L T A B L E
-- -----------------------------------------------------------------------------
-- page 472
-- -----------------------------------------------------------------------------
-- 1. First physically create the directory c:\temp
-- -----------------------------------------------------------------------------
-- 2. Then login as system and do:
-- A. create or REPLACE DIRECTorY BANK_FILES AS 'C:\temp';
create or REPLACE DIRECTorY BANK_FILES
  AS   'C:\temp';
-- B. GRANT READ, WRITE ON DIRECTorY BANK_FILES TO CRUISES;
GRANT READ, WRITE ON DIRECTorY BANK_FILES TO CRUISES;
-- -----------------------------------------------------------------------------
-- 3. create the external table
create table invoices_external
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


    
select COUNT(*) from invoices_external;
drop table invoices_external;
-- -----------------------------------------------------------------------------
-- 4. create the internal table from the external table
drop table invoices_internal;
create table invoices_internal AS
select * from invoices_external;
select * from recyclebin;
select * from invoices_internal WHERE invoice_id IS NULL;
select COUNT(*) from invoices_external;
select COUNT(*) from invoices_internal;
-- -----------------------------------------------------------------------------
-- 5. create a new table with datatypes we want
-- drop table invoices_revised;
create table invoices_revised
(
    invoice_id     INTEGER,
    invoice_date   DATE,
    invoice_amt    NUMBER,
    account_number varchar2(13)
);
-- -----------------------------------------------------------------------------
-- 6. insert into the new table
insert into invoices_revised 
         (invoice_id, invoice_date,invoice_amt,account_number)
  select  invoice_id, to_date(invoice_date,'mm/dd/yyyy'), 
          to_number(invoice_amt), account_number
  from invoices_external;

delete from invoices_revised;  
select count(*) from invoices_revised; 
commit;

--select year, sum(invoice_amt)
--from (
--            select to_char(invoice_date,'yyyy') year, invoice_amt
--            from invoices_revised)
--group by year
--order by year;
select to_char(invoice_date,'yyyy') as total, to_char(sum(invoice_amt),'999,999,999,999')
from invoices_revised
group by to_char(invoice_date,'yyyy')
order by 1;

--2009	   2,034,139,924
--2010	   3,827,487,305
--2011	   2,039,201,394
  
drop table projects2;
create table projects2
as select * from projects;

alter table projects2
modify days constraint ck_days check (days <=90);

alter table projects2
modify days check (days <=90);

alter table projects2 add check (days <=90);

alter table projects2 add constraint ck_days check (days <=90);


-- =============================================================================
-- Chapter 12
-- =============================================================================
select * from contact_emails;
-- ------------------------------
select * from online_subscribers;
-- ------------------------------
select contact_email_id, email_address
from contact_emails
WHERE status = 'Valid'
UNION 
select online_subscriber_id, email 
from online_subscribers;

select email_address
from contact_emails
WHERE status = 'Valid'
UNION 
select email 
from online_subscribers;

select email_address
from contact_emails
WHERE status = 'Valid'
UNION ALL
select email 
from online_subscribers;

select email_address
from contact_emails
WHERE status = 'Valid'
UNION ALL
select email 
from online_subscribers;

select email_address from contact_emails WHERE status = 'Valid'
UNION ALL
select email from online_subscribers;


select email_address from contact_emails WHERE status = 'Valid'
select email from online_subscribers;
-- ------------------------------
select contact_email_id,
  email_address
from contact_emails
UNION
select online_subscriber_id, email from online_subscribers;
-- ------------------------------
select contact_email_id,
  email_address
from contact_emails
UNION ALL
select online_subscriber_id, email from online_subscribers;

-- ------------------------------
select email_address from contact_emails
UNION
select email from online_subscribers;
-- ------------------------------
select email_address 
from contact_emails
INTERSECT
select email 
from online_subscribers;
-- ------------------------------
select email from online_subscribers
INTERSECT
select email_address from contact_emails;
-- ------------------------------
select email_address from contact_emails;
-- ------------------------------
select email from online_subscribers;
-- ------------------------------
select email_address 
from contact_emails
MINUS
select email 
from online_subscribers
orDER BY email_address;


-- ------------------------------
select email from online_subscribers
MINUS
select email_address from contact_emails;
-- ------------------------------
select email from online_subscribers
MINUS
select email_address from contact_emails orDER BY email;
-- ------------------------------
select product 
from store_inventory
UNION ALL
select item_name 
from furnishings;

select product 
from Store_inventory 
WHERE product = 'Towel'
MINUS
select item_name
from furnishings
WHERE item_name = 'Towel';

select num, product 
from store_inventory
MINUS
select cat#, item_name 
from furnishings;

--77	Jacket
--78	Towel
--79	Lava lamp
--1	  Lemons
--2	  Crackers
--3	  Soup
---- -----------------
--1	  Side table
--2	  Desk
--3	  Towel

select product from store_inventory
UNION ALL
select item_name from furnishings
MINUS
  (
    select product from store_inventory WHERE product = 'Towel'
     UNION ALL
    select item_name from furnishings WHERE item_name = 'Towel' 
  );
  
select 'Individual', last_name ||' ' || first_name name 
from cruise_customers
UNION
select category, vendor_name 
from vendors orDER BY 2 DESC;

select email, '----'
from online_subscribers;

select email, '---'
from online_subscribers;

select email,
  (select num from store_inventory WHERE num = 1
  MINUS
  select cat# from furnishings WHERE cat# = 77
  ) abc
from online_subscribers;


select * from ONLINE_SUBSCRIBERS;


select '---' from online_subscribers;
-- question 12
select a.sub_date, count(*)
from online_subscribers a join
        ( select to_date(last_order,'yyyy/mm/dd') last_order, product 
           from store_inventory
            UNION
          select added, item_name from furnishings
         ) b
    on a.sub_date = b.last_order
group by a.sub_date;

select * from online_subscribers;
-- LAST_orDER ITEM_NAME
--09-SEP-09	  Jacket
--12-SEP-09	  Desk
--10-OCT-09	  Towel
--11-NOV-09	  Towel
--21-DEC-09	  Lava lamp
--23-DEC-09	  Side table



desc store_inventory;
desc furnishings;
select * from store_inventory;

delete from store_inventory where num in (1,2,3); 
select last_order from store_inventory;
rollback;

select '-----'
from online_subscribers;

select lastname
from customers
where lastname = '&abc';

select 'Towel'
from online_subscribers;

-- =============================================================================
-- Chapter 13
-- =============================================================================
drop table TICKETS;
create table tickets
(state  varchar2(25),
CITY    varchar2(25),
COUNTY  varchar(25),
NUM_TIKETS INTEGER);

insert into TICKETS values('Massachusetts', 'Barnstable',  'Berkshire',  1345);
insert into TICKETS values('Massachusetts', 'Barnstable', 'Adams', 2134);
insert into TICKETS values('Massachusetts', 'Bourne',  'Alford', 765);
 
Bourne  Alford  Attleborough  Cottage City  
Brewster  Becket  Berkley  Edgartown  



-- -----------------------------------------------------------------------------
--ROLLUP 1 C O L U M N
-- -----------------------------------------------------------------------------
-- find some rows to deal with
select room_style,
       room_type,
       sq_ft
from ship_cabins
WHERE ship_cabin_id < 7
and ship_cabin_id   > 3
orDER BY 1;

select room_style,room_type, count(*), sum(sq_ft)
from ship_cabins
WHERE 1=1 
--and ship_cabin_id < 7
--and ship_cabin_id   > 3
group by room_style,room_type
orDER BY 1;

select room_style,count(*), sum(sq_ft)
from ship_cabins
WHERE 1=1 
--and ship_cabin_id < 7
--and ship_cabin_id   > 3
group by room_style
orDER BY 1;
-- single column rollup
-- types of aggregations = n+1
-- where n is the number of columns in your rollup
select room_style,sum(sq_ft)
from ship_cabins
WHERE 1=1 
--and ship_cabin_id < 7
--and ship_cabin_id   > 3
group by rollup(room_style)
orDER BY 1;

-- two column rollup
-- types of aggregations = n(2)+1
-- where n is the number of columns in your rollup
select room_style,room_type,sum(sq_ft)
from ship_cabins
WHERE 1=1 
--and ship_cabin_id < 7
--and ship_cabin_id   > 3
group by rollup(room_style, room_type)
orDER BY 1;

-- three column rollup
-- types of aggregations = n(3)+1=4
-- where n is the number of columns in your rollup
select room_style,room_type,window, sum(sq_ft)
from ship_cabins
WHERE 1=1
 and ship_cabin_id  < 7
 and ship_cabin_id   > 3
group by rollup(room_style, room_type, window)
orDER BY 1;


-- one column cube
-- types of aggregations  2^1=2
-- where n is the number of columns in your cube
select room_style, sum(sq_ft)
from ship_cabins
WHERE 1=1
 and ship_cabin_id  < 7
 and ship_cabin_id   > 3
group by cube(room_style)
orDER BY 1;

-- two column cube
-- types of aggregations 2^2=4
-- where n is the number of columns in your cube
select room_style, room_type, sum(sq_ft)
from ship_cabins
WHERE 1=1
 and ship_cabin_id  < 7
 and ship_cabin_id   > 3
group by cube(room_style, room_type)
orDER BY 1;

-- three column cube
-- types of aggregations 2^3=8
-- where n is the number of columns in your cube
select room_style, room_type, window, sum(sq_ft)
from ship_cabins
WHERE 1=1
 and ship_cabin_id  < 7
 and ship_cabin_id   > 3
group by cube(room_style, room_type, window)
orDER BY 1;

--
select room_type, window, sum(sq_ft)
from ship_cabins
WHERE 1=1
 and ship_cabin_id  < 16
 and ship_cabin_id   > 12
 group by cube(room_type, window);

--
select room_type, window, grouping(window), sum(sq_ft)
from ship_cabins
WHERE 1=1
 and ship_cabin_id  < 16
 and ship_cabin_id   > 12
 group by cube(room_type, window); 
 
--
select nvl(
            decode(grouping(room_type),
                   1,upper(room_style),
                   initcap(room_style))
                   ,
            'GRand TOTAL') room_style_formatted,      
       room_type, 
       round(sum(sq_ft),2) sum_sq_ft
from ship_cabins
WHERE ship_id=1
 group by rollup(room_style, room_type)
 order by room_style, room_type; 
 
 -- 520
select window, room_style, room_type, sum(sq_ft) 
from ship_cabins2
WHERE ship_id=1
 group by grouping sets((window, room_style),(room_type),null)
 order by window, room_style, room_type; 
 
select window, room_style,sum(sq_ft) 
from ship_cabins
WHERE ship_id=1
 group by window, room_style;
 
select room_type,sum(sq_ft) 
from ship_cabins
WHERE ship_id=1
 group by room_type; 
 
 
create table ship_cabins2
as select * from ship_cabins;
select * 
from ship_cabins2;

insert into ship_cabins2 values(50,1,999,'Suite','Royal',null,5,1000,null);
commit;

 
 
 
 
select room_type, window, sum(sq_ft)
from ship_cabins
WHERE 1=1
 and ship_cabin_id  < 16
 and ship_cabin_id   > 12
 group by rollup(room_type, window); 

select room_style, room_type, sum(sq_ft)
from ship_cabins
WHERE 1=1
 and ship_cabin_id  < 7
 and ship_cabin_id   > 3
 group by cube(room_style, room_type)
 order by 1,2;




select window, room_type, room_style, sum(sq_ft)
from ship_cabins
WHERE 1=1
 and ship_cabin_id  < 7
 and ship_cabin_id   > 3
group by rollup(window, room_type, room_style)
orDER BY 1;





select room_style, room_type, window, sq_ft
from ship_cabins
where ship_cabin_id  < 7
 and ship_cabin_id   > 3;



select room_type, SUM(sq_ft)
from ship_cabins
WHERE ship_cabin_id < 7
and ship_cabin_id   > 3
GROUP BY room_type
orDER BY 1;


-- then revisit the group by and aggregate function SUM
-- page 513 top 1 col ROOM_STYLE
select room_style, SUM(sq_ft) sq_ft
from ship_cabins
WHERE ship_cabin_id < 7
and ship_cabin_id   > 3
GROUP BY room_style
orDER BY 1;

-- now try adding ROLLUP ROOM_STYLE
-- page 513 bottom 1 col
select room_style, SUM(sq_ft) sq_ft
from ship_cabins
WHERE ship_cabin_id < 7
and ship_cabin_id   > 3
GROUP BY rollup (room_style)
orDER BY room_style;
-- ------------------------------------------
-- Try the same steps with ROOM_TYPE
-- ------------------------------------------
-- page 513 top 1 col ROOM_TYPE
-- find some rows to deal with
select room_type,  sq_ft
from ship_cabins
WHERE ship_cabin_id < 7
and ship_cabin_id   > 3
orDER BY 1;


select room_type, SUM(sq_ft) sq_ft
from ship_cabins
WHERE ship_cabin_id < 7
 and ship_cabin_id   > 3
GROUP BY room_type
orDER BY 1;

select room_type,SUM(sq_ft) sq_ft
from ship_cabins
WHERE ship_cabin_id < 7
and ship_cabin_id   > 3
GROUP BY rollup (room_type)
orDER BY room_type;

-- -----------------------------------------------------------------------------
-- ROLLUP 2 C O L U M N S
-- -----------------------------------------------------------------------------
-- find some rows
select room_style, room_type, sq_ft
from ship_cabins
WHERE ship_cabin_id < 7
and ship_cabin_id   > 3;

-- group by ROOM_STYLE, ROOM_TYPE
select room_style, room_type, SUM(sq_ft) sq_ft
from ship_cabins
WHERE ship_cabin_id < 7
and ship_cabin_id   > 3
GROUP BY room_style, room_type;
orDER BY 1, 2;

select room_type, room_style, SUM(sq_ft) sq_ft
from ship_cabins
WHERE ship_cabin_id < 7
and ship_cabin_id   > 3
GROUP BY room_type, room_style;
order by 1,2;

-- rollup by ROOM_STYLE, ROOM_TYPE
select room_style,room_type,SUM(sq_ft) sum_sq_ft
from ship_cabins
WHERE ship_cabin_id < 7
and ship_cabin_id   > 3
GROUP BY rollup (room_style, room_type)
orDER BY 1, 2;
  
 
select room_style, SUM(sq_ft) sum_sq_ft
from ship_cabins
WHERE ship_cabin_id < 7
and ship_cabin_id   > 3
GROUP BY rollup (room_style)
orDER BY room_style;
-- -----------------------------------------------------------------------------
-- ROLLUP 2 C O L U M N S Reverse column order
-- -----------------------------------------------------------------------------
-- find some rows
select room_type, room_style, sq_ft
from ship_cabins
WHERE ship_cabin_id < 7
and ship_cabin_id   > 3;


-- ------------------------------------------------
-- reverse the GROUP BY
select room_type, room_style, SUM(sq_ft)
from ship_cabins
WHERE ship_cabin_id < 7
  and ship_cabin_id   > 3
GROUP BY room_type,room_style;

-- -----------------------------------
-- rollup
select room_type,room_style, SUM(sq_ft) sum_sq_ft
from ship_cabins
WHERE ship_cabin_id < 7
and ship_cabin_id   > 3
GROUP BY rollup(room_type,room_style)
orDER BY 1, 2;
-- -----------------------------------------------------------------------------
-- PAGE 514
select window,room_style,room_type,sq_ft
from ship_cabins
WHERE ship_cabin_id < 9
and ship_cabin_id   > 5;

select window,room_style,room_type,sum(sq_ft)
from ship_cabins
WHERE ship_cabin_id < 9
and ship_cabin_id   > 5
group by window,room_style,room_type;

select window, room_style, room_type, SUM(sq_ft)
from ship_cabins
where ship_id = 1
--WHERE ship_cabin_id < 9
--and ship_cabin_id   > 5
GROUP BY rollup(window, room_style, room_type)
orDER BY 1,2,3;

select room_style, room_type, count(sq_ft),sum(sq_ft)
from ship_cabins
where ship_id = 1
--WHERE ship_cabin_id < 9
--and ship_cabin_id   > 5
GROUP BY rollup(room_style, room_type)
orDER BY 1,2,3;


select * from ship_cabins;

select window, room_style, room_type 
from ship_cabins
WHERE ship_cabin_id < 9
and ship_cabin_id   > 5;

select window,room_style,room_type, SUM(sq_ft)
from ship_cabins
WHERE ship_cabin_id < 9
and ship_cabin_id   > 5
GROUP BY window, room_style, rollup(room_type)
orDER BY 1,2,3;

select room_style, room_type, SUM(sq_ft)
from ship_cabins
WHERE ship_cabin_id < 9
and ship_cabin_id   > 5
GROUP BY room_style, rollup(room_type)
orDER BY 1,2,3;





select window,room_style,room_type, SUM(sq_ft)
from ship_cabins
WHERE ship_cabin_id < 9
and ship_cabin_id   > 5
GROUP BY grouping sets (window, (room_style,room_type)),
  rollup(room_style,room_type)
orDER BY 1,2,3;
-- -----------------------------------------------------------------------------
-- ROLLUP 3 C O L U M N S
-- -----------------------------------------------------------------------------
-- find the same rows
select window, room_type,room_style, sq_ft
from ship_cabins
WHERE ship_cabin_id < 12
and ship_cabin_id   > 6;

select window,room_type,room_style,SUM(sq_ft)
from ship_cabins
WHERE ship_cabin_id < 12
and ship_cabin_id   > 6
GROUP BY window,room_type,room_style;

select window,room_type,room_style,SUM(sq_ft), count(*)
from ship_cabins
WHERE ship_cabin_id < 12
and ship_cabin_id   > 6
GROUP BY rollup(window, room_type, room_style)
orDER BY 1,2,3;

-- -----------------------------------
-- rollup by WINDOW, ROOM_STYLE, ROOM_TYPE
select ship_cabin_id, window,room_type,room_style, sq_ft
from ship_cabins
WHERE ship_cabin_id < 11
and ship_cabin_id   > 6
orDER BY 1, 2, 3;


select window,room_type,room_style,SUM(sq_ft) sum_sq_ft
from ship_cabins
WHERE ship_cabin_id < 11
and ship_cabin_id   > 6
GROUP BY rollup (window,room_type,room_style)
orDER BY 1,2,3;

select * from ship_cabins 
WHERE ship_cabin_id < 12 
and ship_cabin_id > 7;


-- -----------------------------------------------------------------------------
-- CUBE 1 C O L U M N
-- -----------------------------------------------------------------------------
-- find the same rows
select room_style, sq_ft
from ship_cabins
WHERE ship_cabin_id < 7
and ship_cabin_id   > 3;

-- -----------------------------------
-- group by ROOM_STYLE
-- -----------------------------------
select room_style, SUM(sq_ft) sum_sf
from ship_cabins
WHERE ship_cabin_id < 7
and ship_cabin_id   > 3
GROUP BY room_style
orDER BY 1;
-- -----------------------------------
-- rollup by ROOM_STYLE
select room_style, SUM(sq_ft) sum_sq_ft
from ship_cabins
WHERE ship_cabin_id < 7
and ship_cabin_id   > 3
GROUP BY rollup (room_style)
orDER BY 1;

-- -----------------------------------
-- cube by ROOM_STYLE
-- 1 column looks like rollup
select room_style, SUM(sq_ft) sum_sq_ft
from ship_cabins
WHERE ship_cabin_id < 7
and ship_cabin_id   > 3
GROUP BY cube (room_style)
orDER BY 1;
-- -----------------------------------------------------------------------------
-- CUBE 2 C O L U M N
-- -----------------------------------------------------------------------------
-- find the same rows
select room_type, room_style, sq_ft
from ship_cabins
WHERE ship_cabin_id < 7
and ship_cabin_id   > 3 ;
-- -----------------------------------
-- group by ROOM_TYPE, ROOM_STYLE
select room_type, room_style, SUM(sq_ft) sum_sf
from ship_cabins
WHERE ship_cabin_id < 7
and ship_cabin_id   > 3
GROUP BY room_type, room_style
orDER BY 1;
-- -----------------------------------
-- rollup by ROOM_TYPE,ROOM_STYLE
select room_type,
  room_style,
  SUM(sq_ft) sum_sf
from ship_cabins
WHERE ship_cabin_id < 7
and ship_cabin_id   > 3
GROUP BY rollup (room_type,room_style)
orDER BY 1;
-- -----------------------------------
-- cube by ROOM_TYPE,ROOM_STYLE
-- 1 column looks like rollup
select room_type,
  room_style,
  SUM(sq_ft) sum_sq_ft
from ship_cabins
WHERE ship_cabin_id < 7
and ship_cabin_id   > 3
GROUP BY cube (room_type,room_style)
orDER BY 1;
-- -----------------------------------
-- cube by WINDOW, ROOM_TYPE,ROOM_STYLE
select window,  room_type, room_style,
  sq_ft
from ship_cabins
WHERE ship_cabin_id < 7
and ship_cabin_id   > 3;
select window,
  room_type,
  room_style,
  SUM(sq_ft) sum_sq_ft
from ship_cabins
WHERE ship_cabin_id < 7
and ship_cabin_id   > 3
GROUP BY cube (window,room_type,room_style);


select window,room_type,room_style
from ship_cabins
where ship_cabin_id > 4
and ship_cabin_id   < 8;

select window,room_type,room_style, sum(sq_ft)
from ship_cabins
where ship_cabin_id > 4
and ship_cabin_id   < 8
group by cube (window,room_type,room_style);



-- orDER BY 1;
-- -----------------------------------------------------------------------------
-- GROUPING ROLLUP 2 C O L U M N  page 516
-- -----------------------------------------------------------------------------
select room_style, room_type
from ship_cabins
WHERE ship_id = 1
orDER BY 1,2;

select room_style, room_type, SUM(sq_ft) sf
from ship_cabins
WHERE ship_id = 1
GROUP BY cube (room_style, room_type)
orDER BY 1,2;
-- -----------------------------------------------------------------------------
-- GROUPING ROLLUP 2 C O L U M N  page 517
-- -----------------------------------------------------------------------------
select grouping(room_style), 
        room_style, room_type,
        SUM(sq_ft) sum_sq_ft
from ship_cabins
WHERE ship_id = 1
GROUP BY rollup(room_style, room_type)
orDER BY room_style, room_type;

-- how many 1's
select grouping(room_type), 
        room_style, room_type,
        SUM(sq_ft) sum_sq_ft
from ship_cabins
WHERE ship_cabin_id < 7
  and ship_cabin_id > 4
GROUP BY cube(room_style, room_type)
orDER BY room_style, room_type;

select grouping(room_style), 
        room_style, room_type,
        SUM(sq_ft) sum_sq_ft
from ship_cabins
WHERE ship_cabin_id < 7
  and ship_cabin_id > 4
GROUP BY cube(room_type, room_style)
orDER BY room_style, room_type;


select   WINDOW,
        -- grouping(window), 
        room_style, room_type,
        SUM(sq_ft) sum_sq_ft
from ship_cabins
WHERE ship_cabin_id < 7
  and ship_cabin_id > 5
GROUP BY cube(window,room_type, room_style);
orDER BY window, room_style, room_type;

1.  0     0     0
2.  0     X     0
3.  0     0     X     
4.  X     0     0
5.  X     X     0
6.  0     X     X
7.  X     0     X
8.  X     X     X

select ship_cabin_id,window, room_style, room_type
from ship_cabins
WHERE ship_cabin_id < 7
  and ship_cabin_id > 5
orDER BY window,room_style, room_type;  
  
 
select nvl(decode
                  (grouping(room_type),
                              1,    upper(room_style),
                              initcap(room_style)
                   )
       , 'GRand TOTAL') 
       room_style_formatted,
       room_type,
       round(sum(sq_ft),2) sum_sq_ft
from ship_cabins
WHERE ship_cabin_id < 7
  and ship_cabin_id > 4
GROUP BY ROLLUP(ROOM_STYLE, ROOM_TYPE)  
orDER BY room_style, room_type;

0   0
0   X
X   X

select room_style, room_type
from ship_cabins
WHERE ship_cabin_id < 7
  and ship_cabin_id > 4;


select NVL(DECODE (grouping(room_type),1, upper(room_style),initcap(room_style)),
       'GRand TOTAL') room_style, NVL(room_type,'Sub Total') room_type,
        SUM(sq_ft) sum_sq_ft
from ship_cabins
WHERE ship_cabin_id < 7
  and ship_cabin_id > 4
GROUP BY rollup(room_style, room_type);






-- -----------------------------------------------------------------------------
-- GROUPING SETS page 519
-- -----------------------------------------------------------------------------
select window,
  room_style,
  room_type,
  SUM(sq_ft)
from ship_cabins
WHERE ship_id = 1
GROUP BY cube (window, room_style, room_type)
orDER BY 1,2,3;
select window,
  room_style,
  room_type,
  SUM(sq_ft) sum_sq_ft
from ship_cabins
WHERE ship_id_cabin = 1
GROUP BY grouping sets ((window, room_style), room_type, NULL)
orDER BY 1,2,3;
select window,
  room_style,
  room_type,
  sq_ft
from ship_cabins
WHERE ship_cabin_id < 7
and ship_cabin_id   > 3;

select window,room_style,room_type, SUM(sq_ft)
from ship_cabins
WHERE ship_cabin_id < 7
and ship_cabin_id   > 3
GROUP BY cube(window,room_style,room_type)
orDER BY 1,2,3;

select window,room_style,room_type,SUM(sq_ft) sum_sq_ft
from ship_cabins
WHERE ship_cabin_id < 7
and ship_cabin_id   > 3
GROUP BY grouping sets ((window, room_style), room_type, NULL)
orDER BY 1,2,3;

select window,room_style,room_type,SUM(sq_ft) sum_sq_ft
from ship_cabins
WHERE ship_cabin_id < 7
and ship_cabin_id   > 3
GROUP BY grouping sets ((window, room_style), room_type, null)
orDER BY 1,2,3;

select window,room_style,room_type,SUM(sq_ft) sum_sq_ft
from ship_cabins
WHERE ship_cabin_id < 7
and ship_cabin_id   > 3
GROUP BY grouping sets (window, (room_style, room_type), null)
orDER BY 1,2,3;

select window,room_style,room_type
from ship_cabins
WHERE ship_cabin_id < 7
and ship_cabin_id   > 3;

select p.category,
  p.product,
  p.deck_id,
  SUM(p.qty) sum_qty
from provisions p
JOIN decks d
ON p.deck_id = d.deck_id
GROUP BY grouping sets ((p.category,p.product),(p.deck_id))
orDER BY 1,2,3;
-- -----------------------------------
select grouping(window),
  grouping(room_type),
  grouping(room_style),
  SUM(sq_ft) sum_sq_ft
from ship_cabins
WHERE ship_id     = 1
and ship_cabin_id < 7
and ship_cabin_id > 3
GROUP BY window,
  rollup(room_type,room_style)
orDER BY window,
  room_style,
  room_type;
-- -----------------------------------
select window,
  room_type,
  room_style,
  SUM(sq_ft) sum_sq_ft
from ship_cabins
WHERE ship_id     = 1
and ship_cabin_id < 6
GROUP BY window,
  room_type,
  room_style
orDER BY window,
  room_style,
  room_type;
-- -----------------------------------------------------------------------------
-- cube compare
-- -----------------------------------
select room_style,
  room_type
from ship_cabins
WHERE ship_id     = 1
and ship_cabin_id < 6
orDER BY room_style,
  room_type;
select room_style,
  room_type,
  SUM(sq_ft) sum_sq_ft
from ship_cabins
WHERE ship_id     = 1
and ship_cabin_id < 6
GROUP BY cube(room_style,room_type)
orDER BY room_style,
  room_type;
-- -----------------------------------
-- page 513 bottom 3 cols
select window,
  room_style,
  room_type
from ship_cabins
WHERE ship_id     = 1
and ship_cabin_id < 6;
select window,
  room_style,
  room_type,
  SUM(sq_ft) sq_ft
from ship_cabins
WHERE ship_id     = 1
and ship_cabin_id < 6
GROUP BY rollup(window,room_style, room_type)
orDER BY window,
  room_style,
  room_type;
-- -----------------------------------
select window,
  room_style,
  room_type
from ship_cabins
WHERE ship_id     = 1
and ship_cabin_id < 6;
select window,
  room_style,
  room_type,
  SUM(sq_ft) sq_ft,
  grouping(window)     AS wd,
  grouping(room_style) AS rs,
  grouping(room_type)  AS rt
from ship_cabins
WHERE ship_id     = 1
and ship_cabin_id < 6
GROUP BY rollup(window,room_style, room_type)
orDER BY window,
  room_style,
  room_type;
-- -----------------------------------
-- page 514 multple rollups (see bullets)
select room_style,
  room_type,
  SUM(sq_ft) sum_sq_ft
from ship_cabins
WHERE ship_id = 1
GROUP BY rollup(room_type),
  rollup(room_style)
orDER BY room_style,
  room_type;
-- -----------------------------------
select window,
  room_style,
  room_type,
  SUM(sq_ft) sum_sq_ft
from ship_cabins
WHERE ship_id = 1
GROUP BY rollup(window),
  rollup(room_type),
  rollup(room_style);
order by room_style,
room_type;
-- -----------------------------------
-- page 514 group by and rollup
select window,
  room_style,
  room_type,
  SUM(sq_ft) sum_sq_ft
from ship_cabins
WHERE ship_id = 1
GROUP BY window,
  rollup (room_style, room_type)
orDER BY window,
  room_style,
  room_type;
-- -----------------------------------------------------------------------------
--CUBE
-- -----------------------------------------------------------------------------
select *
from ship_cabins
WHERE ship_id     = 1
and ship_cabin_id < 10;

-- page 516 cube 1 col
select room_type,
  SUM(sq_ft) sq_ft
from ship_cabins
WHERE ship_id     = 1
and ship_cabin_id < 10
GROUP BY cube (room_type)
orDER BY room_type;
-- -----------------------------------
select room_style,
  SUM(sq_ft) sq_ft
from ship_cabins
WHERE ship_id = 1
GROUP BY cube (room_style)
orDER BY room_style;
-- -----------------------------------
-- group by cube
-- -----------------------------------
select room_style,
  room_type
from ship_cabins
WHERE ship_id     = 1
and ship_cabin_id < 9
and ship_cabin_id > 5
orDER BY room_style,
  room_type;
-- page 516 cube 2 col
select room_style,
  room_type,
  SUM(sq_ft) sq_ft
from ship_cabins
WHERE ship_id     = 1
and ship_cabin_id < 9
and ship_cabin_id > 5
GROUP BY cube(room_style, room_type)
orDER BY room_style,
  room_type;
-- ------------------------------------------------
select window,
  room_style,
  room_type
from ship_cabins
WHERE ship_id     = 1
and ship_cabin_id < 9
and ship_cabin_id > 5
orDER BY room_style,
  room_type;
select window,
  room_style,
  room_type,
  SUM(sq_ft) sq_ft
from ship_cabins
WHERE ship_id     = 1
and ship_cabin_id < 9
and ship_cabin_id > 5
GROUP BY window,
  cube(room_style, room_type)
orDER BY room_style,
  room_type;
-- ------------------------------------------------
-- double cube
-- page 516 cube 2 col multiple cubes
select room_style,
  room_type,
  SUM(sq_ft) sq_ft
from ship_cabins
WHERE ship_id = 1
GROUP BY cube(room_style),
  cube(room_type)
orDER BY room_style,
  room_type;
-- page 516 cube 3 col
select window,
  room_style,
  room_type,
  SUM(sq_ft) sq_ft
from ship_cabins
WHERE ship_id = 1
GROUP BY cube(window,room_style,room_type)
orDER BY window,
  room_style,
  room_type;
select window,
  room_style,
  room_type,
  SUM(sq_ft) sq_ft
from ship_cabins
WHERE ship_id = 1
GROUP BY window,
  cube (room_style,room_type)
orDER BY window,
  room_style,
  room_type;
-- -----------------------------------------------------------------------------
--GROUPING FUNCTION
-- -----------------------------------------------------------------------------
-- page 517 grouping function 1 cols
select grouping(room_type),
  room_type ,
  SUM(sq_ft) sq_ft
from ship_cabins
WHERE ship_id = 1
GROUP BY rollup (room_type)
orDER BY room_type;
-- page 517 grouping function 2 cols
select grouping(room_style) ,
  grouping(room_type),
  room_style,
  room_type,
  SUM(sq_ft) sq_ft
from ship_cabins
WHERE ship_id = 1
GROUP BY rollup (room_style, room_type)
orDER BY room_style,
  room_type;
-- page 517 grouping function 3 cols
select grouping(window) ,
  grouping(room_style) ,
  grouping(room_type) ,
  window ,
  room_style ,
  room_type ,
  SUM(sq_ft) sq_ft
from ship_cabins
WHERE ship_id = 1
GROUP BY rollup (window,room_style, room_type)
orDER BY window,
  room_style,
  room_type;
-- page 518 rollup
select -- grouping(room_style),
  -- grouping(room_type),
  DECODE(grouping(room_style), 1,'ALL STYLES', room_style) style,
  DECODE(grouping(room_type), 1,'ALL TYPES', room_type) type,
  SUM(sq_ft) sq_ft
from ship_cabins
WHERE ship_cabin_id < 7
and ship_cabin_id   > 3
GROUP BY rollup (room_style, room_type)
orDER BY room_style;
-- page 518 cube
select DECODE(grouping(room_style), 1,'ALL STYLES', room_style) style,
  DECODE(grouping(room_type), 1,'ALL TYPES', room_type) type,
  SUM(sq_ft) sq_ft
from ship_cabins
WHERE ship_id = 1
GROUP BY cube (room_style, room_type)
orDER BY room_style;
-- -----------------------------------------------------------------------------
--GROUPING SETS
-- -----------------------------------------------------------------------------
-- page 520
select NVL(window,' ') ,
  NVL(room_style,' ') ,
  NVL(room_type,' ') ,
  SUM(sq_ft) sq_ft
from ship_cabins
WHERE ship_id = 1
GROUP BY grouping sets ((window,room_style), (room_type), NULL)
orDER BY window,
  room_style,
  room_type;
-- -----------------------------------------------------------------------------
-- HandS ON EXERCISES
-- -----------------------------------------------------------------------------
create table divisions
  (
    division_id CHAR(3) CONSTRAINT divisions_pk primary key,
    namevarchar2(15) NOT NULL
  );
drop table divisions;
drop table jobs;
drop table employees2;
create table jobs
  (
    job_id CHAR(3) CONSTRAINT jobs_pk primary key,
    name   varchar2(20) NOT NULL
  );
create table employees2
  (
    employee_id INTEGER CONSTRAINT employees2_pk primary key ,
    division_id CHAR(3)CONSTRAINT employees2_fk_divisions REFERENCES divisions(division_id) ,
    job_idCHAR(3) REFERENCES jobs(job_id) ,
    first_namevarchar2(10) NOT NULL ,
    last_name varchar2(10) NOT NULL,
    salaryNUMBER(6, 0)
  );
select * from employees2;
select * from jobs;
select * from divisions;
-- 1
-- Group the salary (employees2) by job name (jobs)
select name,
  SUM(salary)
from employees2
JOIN jobs USING (job_id)
GROUP BY name;
select name,
  SUM(salary)
from employees2
JOIN jobs USING (job_id)
GROUP BY rollup(name);
-- with a grand total
select name,
  SUM(salary)
from employees2
JOIN jobs USING (job_id)
GROUP BY rollup (name);
-- 2
-- calculate total number of days and cost by purpose with grand totals
select *
from projects;
select NVL(purpose,'----TOTAL----') ,
  SUM(project_cost),
  SUM(days)
from projects
GROUP BY rollup (purpose);
select purpose,
  SUM(project_cost),
  SUM(days)
from projects
GROUP BY rollup (purpose);
-- 3
-- calculate total number of days and total cost by ship_name with grand totals
select NVL(ship_name,'--TOTALS---'),
  SUM(project_cost),
  SUM(days)
from projects
JOIN ships USING(ship_id)
GROUP BY rollup (ship_name);
select ship_name,
  SUM(project_cost),
  SUM(days)
from projects
JOIN ships USING (ship_id)
GROUP BY rollup (ship_name);
-- 4
-- Get the total salary by division (employees2)
-- how many rows does your SQL return?
select name,
  SUM(salary)
from employees2
JOIN divisions USING (division_id)
GROUP BY rollup (name)
orDER BY 1;
-- 5
-- Get the total salary by job_id (employees2) no grand total
-- how many rows does your SQL return?
select job_id,
  SUM(salary)
from employees2
GROUP BY job_id;
-- 6
-- Get the total salary by division (employees2) with grand total
-- how many rows does your SQL return?
select division_id,
  SUM(salary)
from employees2
GROUP BY rollup(division_id);
-- 7
-- Sum salary by division name and job name with no grand total
select j.name,
  d.name,
  SUM(salary)
from employees2 e
JOIN jobs j
ON e.job_id=j.job_id
JOIN divisions d
ON e.division_id = d.division_id
GROUP BY rollup (j.name, d.name);
select NVL(d.name,' TOTALS ') ,
  NVL(j.name,'SUB TOTALS') ,
  SUM(salary)
from employees2 e
JOIN jobs j
ON e.job_id=j.job_id
JOIN divisions d
ON e.division_id = d.division_id
GROUP BY rollup (d.name, j.name);
select divisions.name div,
  jobs.name job,
  SUM(salary)
from employees2
JOIN jobs USING(job_id)
JOIN divisions USING (division_id)
GROUP BY (divisions.name, jobs.name)
orDER BY 1;
-- 8
-- Sum salary by division name and job name with grand total
-- and superaggregate rows for just divisions
select NVL(d.name,'GRand TOTALS') div ,
  j.name job,
  SUM(salary)
from employees2
JOIN jobs j USING(job_id)
JOIN divisions d USING (division_id)
GROUP BY rollup (d.name, j.name)
orDER BY d.name;
select divisions.name div,
  jobs.name job,
  SUM(salary)
from employees2
JOIN jobs USING(job_id)
JOIN divisions USING (division_id)
GROUP BY rollup (divisions.name, jobs.name)
orDER BY 1;
-- 9 Sum salary by division name and job name with grand total
-- and superaggregate rows for both division and job names.
-- How many rows total does your SQL return
-- What is the value for all operations
-- what is the value for all technologists
select NVL(divisions.name,'GRand TOTALS') div,
  jobs.name job,
  SUM(salary)
from employees2
JOIN jobs USING(job_id)
JOIN divisions USING (division_id)
GROUP BY cube (divisions.name, jobs.name)
orDER BY divisions.name;
-- 10.
-- Show the total salary for all combinations of division and job names
-- and show the values --ALL DIVISIONS--, --ALL JOBS-- in the appropriate
-- places.
-- How many rows show --ALL DIVISIONS--.
-- How many rows show --ALL JOBS--.
select DECODE(grouping(divisions.name), 1, 'ALL DIVISIONS',divisions.name) div ,
  DECODE(grouping(jobs.name), 1, 'ALL JOBS', jobs.name) job ,
  SUM(salary)
from employees2
JOIN jobs USING(job_id)
JOIN divisions USING (division_id)
GROUP BY cube (divisions.name, jobs.name)
orDER BY divisions.name ;
-- =============================================================================
-- Chapter 14
-- =============================================================================
select *
from user_tables;

select table_name, column_name
from user_tab_columns
where column_name like '%EMP%';

select table_name, column_name
from all_tab_columns
where column_name like '%EMP%';

select table_name, column_name
from dba_tab_columns
where column_name like '%EMP%';

select * from all_tables;

select * from dba_tables;
select * from dba_tab_columns WHERE owner LIKE '%CRUISES%';

select * from user_constraints;
select * from user_cons_columns;

select constraint_name, constraint_type, r_constraint_name, status
from user_constraints
WHERE table_name = 'CRUISES';

select * from user_constraints
where table_NAME = 'CRUISES';

select * from user_cons_columns
where table_NAME = 'CRUISES';
;
select uc.table_name, uc.constraint_name, column_name
from  user_constraints uc,
      user_cons_columns cc
where 1=1 
  -- and uc.table_name = cc.table_name
  and uc.constraint_name = cc.constraint_name
and uc.constraint_name = 'FK_CRUISES_CRUISE_TYPES';


select * from user_cons_columns;


select * 
from user_constraints
WHERE owner = 'CRUISES'; 

select * 
from user_cons_columns 
WHERE table_name = 'CRUISES';

select * 
from user_constraints 
WHERE owner = 'CRUISES';

select * from user_tab_privs;
select * from user_tab_privs;
select * from user_sys_privs;

select DISTINCT status 
from user_constraints;

select distinct status 
from user_objects;

select * from v$database;
select * from v$instance;
select * from v$parameter;

select * from v$parameter where lower(name) like '%date%';

select * from v$parameter2;
select * from v$session;
select * from v$reserved_words;

select * from v$timezone_names;
select count(*) from v$timezone_names;

select * from all_tab_comments;
select * from all_col_comments;
select * from user_synonyms;
select * from all_tab_columns WHERE lower(table_name) LIKE '%user_synonyms%';
-- ------------------------------------------------------
-- page 536
select *
from user_tables;
select * from all_tables;
select * from dba_tables;
select column_name from all_tab_columns WHERE table_name = 'CRUISES';
-- ------------------------------------------------------
select column_name,
  data_type,
  data_length
from all_tab_columns
WHERE table_name = 'CRUISES';
-- ------------------------------------------------------
select *
from all_tab_columns
WHERE owner = 'CRUISES';
-- ------------------------------------------------------
select *
from all_tab_columns
WHERE owner    = 'CRUISES'
and table_name = 'ADDRESSES';
-- ------------------------------------------------------
select column_name
from all_tab_columns
WHERE owner    = 'CRUISES'
and table_name = 'ADDRESSES';
-- ------------------------------------------------------
-- address_id,employee_id,street_address,street_address2,city,state,zip,zip_plus,country,contact_email,
select *
from all_cons_columns
WHERE owner = 'CRUISES';
-- ------------------------------------------------------
select *
from all_synonyms;
-- ------------------------------------------------------
-- page 537
select *
from user_constraints;
select * from all_constraints;
-- ------------------------------------------------------
-- page 537
select *
from user_synonyms;
select * from all_synonyms;
-- ------------------------------------------------------
-- page 538 Overlap of views
select *
from user_catalog;
select * from user_tables;
select * from user_tab_columns;
-- ------------------------------------------------------
-- page 538 Dynamic Performance Views
select *
from all_catalog
WHERE table_type = 'VIEW';
select * from v$version;
select * from product_component_version;
-- ------------------------------------------------------
-- page 539
-- Version
select *
from v$version;
select * from product_component_version;
-- ------------------------------------------------------
-- page 539
-- as system
select *
from v$database;
select * from v$instance;
select * from v$timezone_names;
-- ------------------------------------------------------
-- page 540
select *
from all_tab_comments
WHERE table_name = 'PorTS';

select * from all_col_comments;

select '*table: ' || table_name, comments
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
COMMENT ON table ports IS 'Listing of all ports';
select * from user_tab_comments
where table_name = 'PorTS';
-- ------------------------------------------------------
-- page 541
COMMENT ON column ports.capacity IS 'Max num of passengers';
select * from user_col_comments
where table_name = 'PorTS';

-- page 542
DESC dictionary;

select * from dictionary
order by table_name;

select * from dictionary
where table_name = 'PorTS';

select distinct(substr(table_name,1,3)) from dictionary;

-- page 543
select * from dictionary WHERE table_name LIKE '%RESTorE%';
select * from dictionary WHERE upper(comments) LIKE '%INDEX%';
select * from dictionary WHERE upper(comments) LIKE '%RESTorE%';
-- ------------------------------------------------------
-- page 543
select *
from all_col_comments
WHERE owner    = 'CRUISES'
and table_name = 'PorTS';
-- ------------------------------------------------------
-- page 544
select *
from user_catalog;
select table_type, COUNT(*) from user_catalog GROUP BY table_type;
select table_type, COUNT(*) from user_catalog GROUP BY table_type;

select distinct table_name 
from all_tab_columns
where owner = 'CRUISES';
-- ------------------------------------------------------
-- page 545
select *
from user_tab_columns;
-- ------------------------------------------------------
-- page 546 middle
select status,
  object_type,
  object_name
from USER_OBJECTS;
WHERE STATUS = 'INVALID';
-- ------------------------------------------------------
-- page 546 bottom
select *
from user_views;
-- ------------------------------------------------------
-- page 547
select *
from user_constraints
WHERE table_name = 'CRUISES';

select table_name
from user_tables;

select * 
from user_cons_columns;

select *
from  user_constraints uc,
      USER_CONS_COLUMNS ucc
WHERE uc.table_name = ucc.table_name 
 and uc.table_name = 'CRUISES';

-- as system
select * from V$SYSTEM_PARAMETER WHERE upper(name) = 'UNDO$';
select * from PorTS versions BETWEEN TIMESTAMP minvalue and maxvalue;
select *                                 *
from PorTS AS OF TIMESTAMP systimestamp - interval '0 0:01:30' DAY TO SECOND;

-- =============================================================================
-- Chapter 15
-- =============================================================================
-- Go back to chapter 11 approximately line 4296
-- install EXTERNAL table table from c:\tempinvoices.txt
-- convert into invoices_revised with correct data types
DESC invoices_external;

select count(*) from invoices_external;

-- page 561
select COUNT(*)
from invoices_revised;

WHERE invoice_date > (add_months(sysdate,-18));
DESC invoices_revised;

select COUNT(*) as "2009"
from invoices_revised
WHERE invoice_date >=  to_date('01/01/09','mm/dd/yy')
  and invoice_date <= to_date('12/31/09','mm/dd/yy');

select COUNT(*) as other
from invoices_revised
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


select COUNT(*),
  COUNT(
  CASE
    WHEN invoice_date >= to_date('01/01/09','mm/dd/yy')
    and invoice_date   < to_date('01/01/10','mm/dd/yy')
    THEN 1
  END) AS nine,
  COUNT(
  CASE
    WHEN invoice_date >= to_date('01/01/10','mm/dd/yy')
    and invoice_date   < to_date('01/01/11','mm/dd/yy')
    THEN 1
  END) AS ten,
  COUNT(
  CASE
    WHEN invoice_date >= to_date('01/01/11','mm/dd/yy')
    and invoice_date   < to_date('01/01/12','mm/dd/yy')
    THEN 1
  END) AS eleven
from invoices_revised;

select COUNT(*),
  COUNT(CASE WHEN TO_CHAR(invoice_date,'RRRR') < '2010' THEN 1 END) AS Y09
  COUNT(CASE 
        WHEN      TO_CHAR(invoice_date,'RRRR') < '2011'
              and TO_CHAR(invoice_date,'RRRR') >= '2010'
        THEN 1 END) AS Y10,
  COUNT(CASE 
        WHEN      TO_CHAR(invoice_date,'RRRR') < '2012'
              and TO_CHAR(invoice_date,'RRRR') >= '2011'
        THEN 1 END) AS Y11
from invoices_revised;

-- ----------------------------------------------------------------
-- page 562

create table room_summary AS
select a.ship_id,a.ship_name,b.room_number, b.sq_ft + NVL(b.balcony_sq_ft,0) sq_ft
from ships a JOIN ship_cabins b
ON a.ship_id = b.ship_id;

desc room_summary;
desc ships;



select COUNT(*) from room_summary;
-- ----------------------------------------------------------------
-- ----------------------------------------------------------------
-- page 563
select *
from cruise_customers;
select * from employees;
-- ----------------------------------------------------------------
-- page 564 top
select seq_cruise_customer_id.nextval from dual;

select MAX(cruise_customer_id) from cruise_customers;
drop sequence seq_cruise_customer_id;
create sequence seq_cruise_customer_id start with 5;

insert into cruise_customers(cruise_customer_id, first_name, last_name)
    select seq_cruise_customer_id.nextval,emp.first_name,emp.last_name
    from employees emp;

select * from cruise_customers;
-- ----------------------------------------------------------------
select *
from cruise_customers;
-- ----------------------------------------------------------------
-- page 565
select home_port_id, COUNT(ship_id) total,SUM(capacity) capacity
from ships
GROUP BY home_port_id
orDER BY 1;
-- ----------------------------------------------------------------
-- page 566
select * from ports;


UPDATE ports p
    SET(tot_ships_assigned,tot_ships_asgn_cap)
          = (select NVL(COUNT(s.ship_id),0) total,NVL(SUM(s.capacity),0) capacity
              from ships s
              WHERE s.home_port_id = p.port_id
              GROUP BY home_port_id
            );
            
select * from ships;
select home_port_id,NVL(COUNT(s.ship_id),0) total,NVL(SUM(s.capacity),0) capacity
from ships s
GROUP BY home_port_id;
-- ----------------------------------------------------------------
-- page 572
select *
from invoices_revised;
DESC invoices_revised;

create table invoices_revised_archive
  (
    invoice_id     NUMBER,
    invoice_date   DATE,
    invoice_amt    NUMBER,
    account_number varchar2(13)
  );
  
create table invoices_revised_archive2
  (
    invoice_id     NUMBER,
    invoice_date   DATE,
    invoice_amt    NUMBER,
    account_number varchar2(13)
  );
-- ----------------------------------------------------------------
-- insert All
-- page 572
insert ALL
into invoices_revised_archive(invoice_id,invoice_date,invoice_amt,account_number)
  values(invoice_id,invoice_date,invoice_amt,account_number)
into invoices_revised_archive2(invoice_id,invoice_date,invoice_amt,account_number)
  values(invoice_id,invoice_date,invoice_amt,account_number)
select invoice_id,invoice_date,invoice_amt,account_number
from invoices_revised;
-- ----------------------------------------------------------------
-- Unconditional multitable insert
-- page 573
insert ALL
into invoices_revised_archive
  (invoice_id,invoice_date,invoice_amt,account_number)
  values(invoice_id,invoice_date,invoice_amt,account_number)
into invoices_revised_archive2
  (invoice_id,invoice_date,invoice_amt,account_number)
  values(invoice_id,invoice_date + 365,invoice_amt,account_number)
select invoice_id,invoice_date,invoice_amt,account_number
from invoices_revised;
-- ----------------------------------------------------------------
-- TRUNCATE table invoices_revised_archive2;
-- Page 575
create table invoices_archived2
  (
    invoice_id     NUMBER,
    invoice_date   DATE,
    invoice_amt    NUMBER,
    account_number varchar2(13)
  );
create table invoices_new2
  (
    invoice_id     NUMBER,
    invoice_date   DATE,
    invoice_amt    NUMBER,
    account_number varchar2(13)
  );
--TRUNCATE table invoices_revised_archive;
--TRUNCATE table invoices_revised_archive2;
-- ----------------------------------------------------------------
-- Page 575
select invoice_id,invoice_date,invoice_amt,account_number
from invoices_revised
WHERE invoice_date < (add_months(sysdate,-24));
-- ----------------------------------------------------------------
--TRUNCATE table invoices_revised_archive;
--TRUNCATE table invoices_revised_archive2;
-- Conditional multitable insert
truncate table invoices_revised_archive2;



insert 
  WHEN (invoice_date > (add_months(sysdate,-24))) 
  THEN
    into invoices_revised_archive(invoice_id,invoice_date,invoice_amt,account_number)
      values(invoice_id,invoice_date,invoice_amt,account_number)
  ELSE
    into invoices_revised_archive2(invoice_id,invoice_date,invoice_amt,account_number)
      values(invoice_id,invoice_date,invoice_amt,account_number)
select invoice_id,invoice_date,invoice_amt,account_number
from invoices_revised;





select count(*) from invoices_revised_archive;
select count(*) from invoices_revised_archive2;





select COUNT(*) from invoices_revised_archive2;
select COUNT(*) from invoices_revised_archive;
select COUNT(*) from invoices_revised_archive;
select COUNT(*) from invoices_revised_archive2;
select (select COUNT(*) from invoices_archived2) +
       (select COUNT(*) from invoices_new2)
from dual;

-- page 576 & 577
-- create table invoices_2009
create table invoices_2009
  (
    invoice_id     NUMBER,
    invoice_date   DATE,
    invoice_amt    NUMBER,
    account_number varchar2(13)
  );
create table invoices_2010
  (
    invoice_id     NUMBER,
    invoice_date   DATE,
    invoice_amt    NUMBER,
    account_number varchar2(13)
  );
create table invoices_2011
  (
    invoice_id     NUMBER,
    invoice_date   DATE,
    invoice_amt    NUMBER,
    account_number varchar2(13)
  );
create table invoices_all
  (
    invoice_id     NUMBER primary key,
    invoice_date   DATE,
    invoice_amt    NUMBER,
    account_number varchar2(13 byte)
  );
TRUNCATE table invoices_2009;
TRUNCATE table invoices_2010;
TRUNCATE table invoices_2011;
TRUNCATE table invoices_all;



insert FIRST
WHEN (TO_CHAR(invoice_date,'RRRR') <= '2009') THEN
    into invoices_2009(invoice_id,invoice_date,invoice_amt,account_number)
      values(invoice_id,invoice_date,invoice_amt,account_number)
    into invoices_all(invoice_id,invoice_date,invoice_amt,account_number)
      values(invoice_id,invoice_date,invoice_amt,account_number)
WHEN (TO_CHAR(invoice_date,'RRRR') <= '2010') THEN
    into invoices_2010(invoice_id,invoice_date,invoice_amt,account_number)
      values(invoice_id,invoice_date,invoice_amt,account_number)
    into invoices_all(invoice_id,invoice_date,invoice_amt,account_number)
      values(invoice_id,invoice_date,invoice_amt,account_number)
WHEN (TO_CHAR(invoice_date,'RRRR') <= '2011') THEN
    into invoices_2011(invoice_id,invoice_date,invoice_amt,account_number)
      values(invoice_id,invoice_date,invoice_amt,account_number)
    into invoices_all(invoice_id,invoice_date,invoice_amt,account_number)
      values(invoice_id,invoice_date,invoice_amt,account_number)
select invoice_id,invoice_date,invoice_amt,account_number
from invoices_revised;

select COUNT(*) from invoices_all;
-- -----------------------------------------------------------------------------
-- page 579
insert WHEN (boss_salary - employee_salary < 79000) THEN
into salary_chart(emp_title,superior,emp_income,sup_income)
  values(employee,boss,employee_salary,boss_salary )
select a.position employee,b.position boss,a.max_salary employee_salary,b.max_salary boss_salary
from positions a
JOIN positions b
ON a.reports_to    = b.position_id
WHERE a.max_salary > 79000;

select * from salary_chart;
commit;
-- page 580
-- Send this to students
create table ship_cabin_grid
  (
    room_type varchar2(20) ,
    ocean     NUMBER ,
    balcony   NUMBER ,
    no_window NUMBER
  );
BEGIN
  insert into ship_cabin_grid values('ROYAL', 1745,1635, NULL);
  insert into ship_cabin_grid values('SKYLOFT', 722,72235, NULL);
  insert into ship_cabin_grid values('PRESIDENTIAL', 1142,1142, 1142);
  insert into ship_cabin_grid values('LARGE', 225,NULL, 211);
  insert into ship_cabin_grid values('STandARD', 217,554, 586);
END;
/
TRUNCATE table ship_cabin_grid;

insert FIRST
  WHEN ocean IS NOT NULL THEN
into ship_cabin_statistics (room_type,window_type,sq_ft)
  values(room_type,'OCEAN',ocean)
  WHEN balcony IS NOT NULL THEN
into ship_cabin_statistics(room_type,window_type,sq_ft)
  values(room_type,'BALCONY',balcony)
  WHEN no_window IS NOT NULL THEN
into ship_cabin_statistics(room_type,window_type,sq_ft)
  values(room_type,'NO WINDOW',no_window)
select rownum rn, room_type, ocean, balcony, no_window from ship_cabin_grid;

-- ----------------------------------------------------------------------------
insert ALL
  WHEN ocean IS NOT NULL THEN
into ship_cabin_statistics(room_type,window_type,sq_ft)
  values(room_type,'OCEAN',ocean)
  WHEN balcony IS NOT NULL THEN
into ship_cabin_statistics(room_type,window_type,sq_ft)
  values(room_type,'BALCONY',balcony)
  WHEN no_window IS NOT NULL THEN
into ship_cabin_statistics
  (room_type,window_type,sq_ft)
  values
  (room_type,'NO WINDOW',no_window)  
select rownum rn, room_type, ocean, balcony, no_window from ship_cabin_grid;


select room_type,window_type,sq_ft
from ship_cabin_statistics
order by 1,2;
-- ----------------------------------------------------------------------------
-- page 586
merge into wwa_invoices wwa USING ontario_orders ont ON (wwa.cust_po = ont.po_num)
WHEN matched THEN
  UPDATE SET wwa.notes = ont.sales_rep
  delete WHERE wwa.inv_date < to_date('01-SEP-09') 
WHEN NOT matched THEN
  insert(wwa.inv_id,wwa.cust_po,wwa.inv_date,wwa.notes)
    values(seq_inv_id.nextval,ont.po_num,sysdate,ont.sales_rep)
WHERE SUBSTR(ont.po_num,1,3)<> 'NBC';
--
rollback;
select * from wwa_invoices;
select * from ontario_orders;
--desc wwa_invoices;
--desc ontario_orders;


-- ----------------------------------------------------------------------------
-- FLASHBACK QUERIES
-- ----------------------------------------------------------------------------
-- setup the table for testing
-- page 589
commit;
drop table chat;
create table chat
  (
    chat_id   NUMBER(11) primary key,
    chat_user varchar2(9),
    yacking   varchar2(40)
  );
drop sequence seq_chat_id;
  
create sequence seq_chat_id;
  BEGIN
    insert into chat values(seq_chat_id.nextval,'ABC', 'Bye bye.');
    insert into chat values(seq_chat_id.nextval,'DEF','So long.');
    insert into chat values(seq_chat_id.nextval,'GHI','Happy birthday.');
    insert into chat values(seq_chat_id.nextval, 'JKL', 'Man Overbaord.');
    commit;
  END;
  /
  
  
update chat set chat_user = 'ZOOIE' 
where chat_user = 'DEF';
commit;

select chat_id, scn_to_timestamp(versions_startscn), scn_to_timestamp(versions_endscn), versions_operation
from chat
versions between timestamp minvalue and maxvalue
where versions_endscn is not null
order by chat_id, versions_operation desc;


select chat_id, versions_startscn, versions_endscn, versions_operation
from chat
versions between timestamp minvalue and maxvalue
order by chat_id, versions_operation desc;


select room_type, window, sq_ft
from ship_cabins
order by room_type, window;

select * from chat;
-- ----------------------------------------------------------------------------
-- page 589
select chat_id,ora_rowscn,scn_to_timestamp(ora_rowscn)
from chat;



desc flashback_transaction_query;

delete from chat;
commit;
select * from chat;
rollback;

select * 
from chat 
as of timestamp systimestamp - interval '0 0:04:30' day to second; 
commit;


-- ----------------------------------------------------------------------------
-- page 590
-- wait for 2 minutes;
EXECUTE DBMS_LOCK.SLEEP(120);
select * from chat;
delete from chat;
commit;
select * from chat;

select versions_xid
from chat
versions between timestamp minvalue and maxvalue;

-- ----------------------------------------------------------------------------
-- page 590
-- FLASHBACK QUERY
-- See older data
select chat_id,chat_user,yacking from chat AS OF TIMESTAMP systimestamp - interval '0 0:01:30' DAY TO second;
--Keep doing this until it shows up empty (1.5 minutes)
-- page 591
--Maybe have to do as system
select name,value from v$system_parameter
WHERE name LIKE ('undo%');
-- page 595
-- FLASHBACK VERSIONS QUERY
select chat_id,versions_startscn,versions_endscn,versions_operation
from chat versions BETWEEN TIMESTAMP minvalue and maxvalue
orDER BY chat_id,versions_operation DESC;
-- ----------------------------------------------------------------------------
--page 596
-- OTHER PSUEDO COLUMNS
select chat_id,
  versions_startscn,
  versions_endscn,
  versions_operation
from chat versions BETWEEN TIMESTAMP minvalue and maxvalue AS OF TIMESTAMP systimestamp - interval '0 00:1:30' DAY TO second
orDER BY chat_id,versions_operation DESC;
-- ----------------------------------------------------------------------------
-- page 598 middle
-- FLASHBACK TRANSACTION QUERY
select chat_id,versions_operation,rawtohex(versions_xid)
from chat versions BETWEEN TIMESTAMP minvalue and maxvalue
WHERE chat_id BETWEEN 1 and 50
orDER BY versions_operation DESC;
-- ----------------------------------------------------------------------------
select *
from chat;
delete chat;
-- page 598 bottom
select undo_sql
from flashback_transaction_query
WHERE xid IN
  (select versions_xid
  from chat versions BETWEEN TIMESTAMP minvalue and maxvalue
  WHERE chat_id BETWEEN 1 and 50
  and versions_operation = 'D'
  );
  
-- =============================================================================
-- Chapter 16
-- =============================================================================
select *
from employee_chart;
select * from files;


-- page 619
-- -----------------------------------------------------------------------------
-- TOP DOWN
-- connect by "prior Low to high"
-- conect "prior child to parent"
-- Top to bottom
-- ------------------------------------
select employee_id, level, lpad(' ',level*2) || title
from employee_chart
start with employee_id = 1
-- conect "prior child to parent"
-- for top-down tree
connect by  prior employee_id = reports_to 
order siblings by title;

select employee_id,  sys_connect_by_path(title, '/') title
from employee_chart
start with employee_id = 1
-- conect "prior child to parent"
-- for top-down tree
connect by  prior employee_id = reports_to;


select level, employee_id, title, connect_by_root employee_id  as ancestor
from employee_chart
start with employee_id = 1
connect by  prior employee_id = reports_to;

select level, employee_id, title, connect_by_root title as ancestor
from employee_chart
start with employee_id = 7
connect by  reports_to = prior employee_id ;

select level, employee_id, title, connect_by_root title as ancestor
from employee_chart
where level <= 2
start with employee_id = 2
connect by  reports_to = prior employee_id;

select level, employee_id, title, connect_by_root title as ancestor
from employee_chart
where level <= 2
start with employee_id = 5
connect by  prior reports_to = employee_id;









select employee_id, lpad(' ',level*2) || title
from employee_chart
start with employee_id = 1
-- conect "prior child to parent"
-- for top-down tree
connect by reports_to = prior employee_id;
---------------------------------------------------------

select employee_id, lpad(' ',level*2) || title
from employee_chart
start with employee_id = 9
-- conect "prior parent to child"
-- for top-down tree
connect by employee_id = prior reports_to;

select employee_id, lpad(' ',level*2) || title
from employee_chart
start with employee_id = 9
-- conect "prior parent to child"
-- for top-down tree
connect by prior reports_to = employee_id;
-- ------------------------------------------------
select employee_id, lpad(' ',level*2) || title
from employee_chart
start with employee_id = 1
-- conect "prior child to parent"
-- for top-down tree
connect by prior employee_id = reports_to
order by title;

-- -------------------------------------------------
select employee_id, lpad(' ',level*2) || title
from employee_chart
start with employee_id = 1
connect by reports_to = prior employee_id;
-- ------------------------------------------------
select employee_id, lpad(' ',level*2) || title
from employee_chart
start with employee_id = 9
connect by employee_id = prior reports_to;
-- -------------------------------------------------
select employee_id, lpad(' ',level*2) || title
from employee_chart
start with employee_id = 9
connect by prior reports_to = employee_id;
-- ---------------------------------------------
select employee_id, lpad(' ',level*2) || title
from employee_chart
start with title = 'CEO'
connect by prior employee_id = reports_to;
-- --------------------------------------------
select employee_id, lpad(' ',level*2) || title
from employee_chart
start with reports_to is null
connect by prior employee_id = reports_to;









-- top down or bottom up
-- how many rows will be returned
-- does this include Director 3 in results
select employee_id, title
from employee_chart
start with employee_id = 3
connect by reports_to = prior employee_id;


-- top down or bottom up
-- how many rows will be returned
-- does this include Atlanta
select location
from distributors
start with location = 'Salt Lake'
connect by upline = prior id;

create table army
( id   integer primary key,
  rank varchar2(15),
  name varchar2(15),
  reports_to integer);
 
insert into army values (1,	'General',	'Collins',	null);
insert into army values (2,	'Colonel',	'Klink',	1);
insert into army values (3,	'Colonel',	'Blank',	1);
insert into army values (4,	'Major',	'Hoolihan',	3);
insert into army values (5,	'Major',	'Blunt',	4);
insert into army values (6,	'Captain',	'Kurt',	5);
insert into army values (7,	'Lieutenant',	'Larry',	6);
insert into army values (8,	'Lieutenant',	'Linda',	6);
insert into army values (9,	'Sergeant',	'Slaughter',	7);
insert into army values (10,	'Corporal',	'Block',	8);
insert into army values (11,	'Corporal',	'Clinger',	8);
insert into army values (12,	'Corporal',	'Cindy',	9);
insert into army values (13,	'Corporal',	'Mary',	9);
insert into army values (14,	'Private' ,	'Radar',	11);
insert into army values (15,	'Private', 	'Tim',	11);
insert into army values (16,	'Private', 	'Betty',	12);
insert into army values (17,	'Private', 	'Singer',	13);
commit;

select * from army;

-- top down or bottom up
-- how many total rows
-- will this include Lindas subordinates
-- will this include Clinger
select level, name, lpad(' ' ,level*2) || rank
from army
start with Name= 'Linda'
connect by reports_to = prior id;

select * from army;

select * from employee_chart;

select employee_id, lpad(' ',level*2) || title
from employee_chart
-- where employee_id <> 3 
start with employee_id = 1
connect by prior employee_id = reports_to
 and employee_id <> 3;
-- -------------------------------
select employee_id, lpad(' ',level*2) || title, connect_by_root title
from employee_chart
start with employee_id = 1
connect by prior employee_id = reports_to;
-- -------------------------------
select employee_id, lpad(' ',level*2) || title, connect_by_root title ancestor
from employee_chart
start with employee_id = 1
connect by prior employee_id = reports_to;
-- -------------------------------
select employee_id, lpad(' ',level*2) || title, sys_connect_by_path(title,' / ')
from employee_chart
start with employee_id = 1
connect by prior employee_id = reports_to;
-- -------------------------------
select employee_id, lpad(' ',level*2) || title
from employee_chart
start with employee_id = 1
connect by prior employee_id = reports_to
order siblings by title;

select id, lpad(' ' ,level*2) || location
from distributors
-- start with id = 1
-- start with id = 7
start with loc_type = 'REGIONAL'
-- start with loc_type = 'LOCAL'
connect by prior id = upline 
order siblings by location desc;




select rank, lpad(' ',level*2) || name, id, reports_to
from army
start with id = 1
connect by prior id = reports_to
order siblings by rank ;

select * from army;



-- top down
-- rows returned
-- does this include private Betty 
select rank, name
from army
start with id = 10
connect by prior id  = reports_to;

select * from army;


-- -----------------------------------------------------------------------------
-- TOP DOWN
-- connect by "High to Prior Low"
-- connect by prior parent = child
-- Top to bottom
-- ------------------------------------
select level, employee_id, title
from employee_chart
  start with employee_id = 1
  connect by reports_to  = prior employee_id;

select level, employee_id, title
from employee_chart
  start with employee_id = 9
  connect by prior reports_to = employee_id;
  
select level, employee_id, title
from employee_chart
  start with employee_id = 9
  connect by prior reports_to  = employee_id;


 
 
  
-- ------------------------------------
-- BOTTOM UP
-- connect by "Prior High to Low"
-- Bottom to Top
-- ------------------------------------




select level,
  employee_id,
  title
from employee_chart
  start with employee_id      = 5
  connect by prior reports_to = employee_id;
  
select * from employee_chart;  
  
  
  
  
  
  
  
  
  
  
  
-- ------------------------------------
-- BOTTOM UP
-- connect by "Low to Prior High"
-- Bottom to Top
-- ------------------------------------
select level,
  employee_id,
  title
from employee_chart
  start with employee_id = 5
  connect by employee_id = prior reports_to;

-- prior low to high is top to bottom 
  
  
-- --------------------------------------------------
-- WHAT IS THIS TOP TO BOTTOM or BOTTOM TO TOP
-- --------------------------------------------------


select level,
  employee_id,
  title
from employee_chart
  start with employee_id = 1
  -- or 9
  connect by prior reports_to = employee_id;
  
  
-- --------------------------------------------------------------------------
-- PAGE 621
-- TREE STRUCTURED REPorT
-- DOES THIS SHOW REPorTS IN CorRECT LINEAGE
-- --------------------------------------------------------------------------
select level, reports_to, employee_id, LPAD(' ', Level*2) || title title_up
from employee_chart
  start with employee_id = 1
  connect by reports_to  = prior employee_id;



-- PAGE 623 Exam watch
select level,
  prior employee_id,
  employee_id
from employee_chart
  start with employee_id       = 1
  connect by prior employee_id = reports_to;
-- --------------------------------------------------------------------------
-- page 624
-- THIS SHOWS REPorTS IN CorRECT LINEAGE
-- --------------------------------------------------------------------------
select level, reports_to, employee_id, LPAD(' ', Level*2) || title title_up
from employee_chart
  start with employee_id = 1
  connect by reports_to  = prior employee_id
orDER SIBLINGS BY title;
-- --------------------------------------------------
-- page 625 top
-- SYS_CONNECT_BY_PATH Function
-- --------------------------------------------------
select level, employee_id, sys_connect_by_path(title,'/') title
from employee_chart
  start with employee_id = 1
  connect by reports_to  = prior employee_id;
-- --------------------------------------------------
-- page 625 bottom
-- CONNECT_BY_ROOT Operator
-- --------------------------------------------------
select level,employee_id, title, connect_by_root title AS root_ancestor
from employee_chart
  start with employee_id = 1
  connect by reports_to  = prior employee_id;
  
select * from employee_chart;  
  
-- --------------------------------------------------
-- page 626 bottom
-- EXCLUDE BRANCHES
-- Look at query first without exclusion
-- --------------------------------------------------
select level, employee_id,LPAD(' ', Level*2) || title title
from employee_chart
  start with employee_id = 1
  connect by reports_to  = prior employee_id
and employee_id         <> 2;

select * from employee_chart;


-- --------------------------------------------------
select level, employee_id, lpad(' ', level*2) || title title
from employee_chart
WHERE employee_id NOT   IN (2,4)
  start with employee_id = 1
  connect by reports_to  = prior employee_id
and employee_id         <> 3;


select * from employee_chart;
-- page 627 top
select level,employee_id,LPAD(' ', Level*2)||title title
from employee_chart
where title <> 'SVP'
  start with employee_id = 1
  connect by reports_to  = prior employee_id
and title                <> 'Director 2';

select level,employee_id,sys_connect_by_path(title, '/') title
from employee_chart
where title <> 'SVP'
  start with employee_id = 1
  connect by reports_to  = prior employee_id
and title                <> 'Director 2';
select * from employee_chart;


-- page 627 bottom


select level, employee_id, LPAD(' ', Level*2) || title title
from employee_chart
WHERE employee_id IN  (select employee_id from employees2 )
  start with employee_id = 1
  connect by reports_to  = prior employee_id
and title               <> 'SVP';


-- -----------------------------------------------------------------------------
-- HandS ON EXERCISES 16
-- -----------------------------------------------------------------------------
select * from jobs2;
select * from directories;
select * from files;
-- -----------------------------------------------------------------------------
-- 1.
-- What is the root directory for job_id = 104;
-- -----------------------------------------------------------------------------
select *
from jobs2
WHERE job_id = 104;
select * from directories WHERE job_id = 104 and directory_name = 'BMS';
select MIN(directory_id) from directories WHERE job_id = 104;
-- -----------------------------------------------------------------------------
-- 2.
-- create simple hierarchical listing of directories without padding
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



select directory_id,
  parent_id,
  directory_name
from directories
  start with directory_id       = 11631
  connect by prior directory_id = parent_id;
-- -----------------------------------------------------------------------------
select level,
  directory_id,
  directory_name
from directories
  start with directory_id = 11631
  connect by prior parent_id    =  directory_id ;
-- -----------------------------------------------------------------------------
-- 3.
-- Next create hierarchical listing of directories with padding
-- to show the levels of the directories for job 104 with root of 11631
-- -----------------------------------------------------------------------------
select level, directory_id, LPAD(' ', Level*2) || directory_name directory
from directories
  start with directory_id =
  (select MIN(directory_id) from directories WHERE job_id = 104
  )
  connect by parent_id = prior directory_id
orDER SIBLINGS BY directory_name;
-- -----------------------------------------------------------------------------
-- 4.
-- Show the path for each directory using the "/"
-- Add LPAD formatting to show the levels
-- -----------------------------------------------------------------------------
select level,
  directory_id,
  parent_id,
  lpad(' ', level*2)
  || sys_connect_by_path(directory_name,'/') directory
from directories
  start with directory_id =
  (select MIN(directory_id) from directories WHERE job_id = 104
  )
  connect by parent_id = prior directory_id;
select level,
  directory_id,
  parent_id,
  sys_connect_by_path(directory_name,'/') directory
from directories
  start with directory_id =
  (select MIN(directory_id) from directories WHERE job_id = 104
  )
  connect by parent_id = prior directory_id;
select directory_id, f2 AS filename from files;
-- -----------------------------------------------------------------------------
-- 5.
-- List all files under directory 
-- /GPS/PDMT_Configs/Configuration in job 104
-- -----------------------------------------------------------------------------
select level, job_id, directory_id, 
              sys_connect_by_path(directory_name,'/') directory
from directories
  start with directory_id =
  (select MIN(directory_id) from directories WHERE job_id = 104
  )
  connect by parent_id = prior directory_id;
  
select d.directory,
  '  /'
  ||f2
from files f ,
  (select level,
    job_id,
    directory_id,
    sys_connect_by_path(directory_name,'/') directory
  from directories
    start with directory_id =
    (select MIN(directory_id) from directories WHERE job_id = 104
    )
    connect by parent_id = prior directory_id
  ) d
WHERE d.directory  = '/GPS/PDMT_Configs/Configuration'
and d.job_id       = f.job_id
and d.directory_id = f.directory_id;
-- -----------------------------------------------------------------------------
-- 6.
-- Which directory id has the most files in it
-- -----------------------------------------------------------------------------
select d.directory_id,
  d.directory_name,
  COUNT(f.f1)
from files f,
  directories d
WHERE f.job_id     = d.job_id
and f.directory_id = d.directory_id
GROUP BY d.directory_id,
  d.directory_name
orDER BY 3 DESC;



-- directories under this one
select level,
  directory_id,
  LPAD(' ', Level*2)
  || sys_connect_by_path(directory_name,'/') directory
from directories
  start with directory_id = 11719
  connect by parent_id    = prior directory_id;





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










select directory_id
from
  (select level lvl,
    directory_id,
    LPAD(' ', Level*2)
    || sys_connect_by_path(directory_name,'<') directory
  from directories
    start with directory_id    = 11719
    connect by prior parent_id = directory_id
  );
-- Forwards with set placed manually
select level,
  directory_id,
  LPAD(' ', Level*2)
  || sys_connect_by_path(directory_name,'/') directory
from directories
  start with directory_id = 11631
  connect by parent_id    = prior directory_id
and directory_id         IN (11631, 11712, 11719);
-- Forwards with set placed manually where clause level 3
select level,
  directory_id,
  LPAD(' ', Level*2)
  || sys_connect_by_path(directory_name,'/') directory
from directories
WHERE directory_id       IN (11631, 11712, 11719)
and level                 = 3
  start with directory_id = 11631
  connect by parent_id    = prior directory_id;
-- solution
select level,
  directory_id,
  lpad(' ', level*2)
  || sys_connect_by_path(directory_name,'/') directory
from directories
WHERE directory_id IN (11631, 11712, 11719)
and level           =
  (select MAX(lvlv)
  from
    (select level lvlv,
      sys_connect_by_path(directory_name,'/') directory
    from directories
    WHERE directory_id       IN (11631, 11712, 11719)
      start with directory_id = 11631
      connect by parent_id    = prior directory_id
    )
  )
  start with directory_id = 11631
  connect by parent_id    = prior directory_id;
select lvl1,
  directory
from
  (select level lvl1,
    directory_id,
    LPAD(' ', Level*2)
    || sys_connect_by_path(directory_name,'/') directory
  from directories
    start with directory_id = 11631
    connect by parent_id    = prior directory_id
  and directory_id         IN (11631, 11712, 11719)
  ) a,
  (select MAX(lvl2) maxlvl2
  from
    (select level lvl2,
      directory_id,
      LPAD(' ', Level*2)
      || sys_connect_by_path(directory_name,'/') directory
    from directories
      start with directory_id = 11631
      connect by parent_id    = prior directory_id
    and directory_id         IN (11631, 11712, 11719)
    )
  ) b
WHERE a.lvl1 = b.maxlvl2;
-- Forwards with subquery
select level,
  directory_id,
  LPAD(' ', Level*2)
  || sys_connect_by_path(directory_name,'/') directory
from directories
  start with directory_id = 11631
  connect by parent_id    = prior directory_id
and directory_id         IN
  (select directory_id
  from
    (select directory_id
    from directories
      start with directory_id    = 11719
      connect by prior parent_id = directory_id
    )
  ) ;
select lvl,
  directory_id,
  directory
from
  (select level lvl,
    directory_id,
    LPAD(' ', Level*2)
    || sys_connect_by_path(directory_name,'/') directory
  from directories
    start with directory_id = 11631
    connect by parent_id    = prior directory_id
  and directory_id         IN
    (select directory_id
    from
      (select directory_id
      from directories
        start with directory_id    = 11719
        connect by prior parent_id = directory_id
      )
    )
  ) a,
  (select MAX(level_1) max_lvl
  from
    (select level level_1,
      directory_id,
      LPAD(' ', Level*2)
      || sys_connect_by_path(directory_name,'/') directory
    from directories
      start with directory_id = 11631
      connect by parent_id    = prior directory_id
    and directory_id         IN
      (select directory_id
      from
        (select directory_id
        from directories
          start with directory_id    = 11719
          connect by prior parent_id = directory_id
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
select *
from park
WHERE park_name = 'Mackinac Island State Park';

select *
from park 
where lower(park_name) like '%park'; 







select regexp_substr('Mississippi','[a-z]') abc from dual;
select regexp_substr('Mississippi','[a-z]', 4) abc from dual;
select regexp_substr('MiSsIsSiPpI','[a-z]', 4, 2) abc from dual;
select regexp_substr('MiSsIsSiPpI','[a-z]', 4, 2, 'i') abc from dual;

select regexp_substr('Mississippi','[a-z]{3}') from dual;
select regexp_substr('MissiSsippi','[a-z]{3,4}') from dual;
select regexp_substr('MissiSsippi','[a-z]{3,4}',1,2) from dual;
select regexp_substr('Mississippi','[a-z]{3,4}',1,2) from dual;

select regexp_substr('M i s s i s s i p p i','[ a-z]{3,4}',1,2) from dual;
select regexp_substr('abcdefghijklimnp','[a-z]{3,4}',1,2) from dual;

select regexp_replace('Mississippi','[a-z]','*') from dual;
select regexp_count('Mississippi','i') from dual;

-- regexp_substr function is showing us what is being
-- used by the regexp_like function to mark rows as
-- true in the where clause

select park_name, regexp_substr(park_name,'park',1,1,'i') 
from park
where regexp_like(park_name,'park','i');







select regexp_substr(description, '.{3}-.{4}')
from park
WHERE regexp_like(description, '.{3}-.{4}');




select regexp_substr('123 Main St','[A-Za-z]') from dual;
select regexp_substr('123 Main St','[A-Za-z0-9]') from dual;

-- page 645
select regexp_substr('123 Main St','[A-Za-z ]+') from dual;
select regexp_substr('123 Main St','[A-Za-z ]{1,}') from dual;

select regexp_substr('123 Main St','[[:alpha:]]+') from dual;

select regexp_substr('123 Main St','[[:alpha:] ]+') from dual;

select regexp_substr('123 Main St','[[:digit:][:alpha:] ]+') from dual;

select regexp_substr('123 Maple Ave','[:ahpla:]+') from dual;

select regexp_substr('123 Maplea Ave','[:ahplae:]+') from dual;

select regexp_substr('123 Maple Ave','[:alpha:]+') from dual;
select regexp_substr('123 Maple Ave','[[:alpha:]]+',1,1) from dual;


select regexp_substr('she sells sea shells by the seashore'
            ,'s[eashor]+e') from dual;

select regexp_substr('sshoooohhaaassshhssrrrhe sells sea shells by the seashore'
            ,'s[eashor]+e') from dual;

            
select regexp_substr('she sells sea shells by the seashore'
            ,'s(eashor)e') from dual;


select regexp_substr('she sells sea shells by the seashore'
            ,'s(easho)+e') from dual;





-- Begins the tutorial
-- this is the simplest way to find a row
-- it uses an exact match of the entire column contents
-- spelling and letter casing
select *
from park
WHERE park_name='Mackinac Island State Park';

-- ------------------------------------------------
-- next level of complexity is like which allows 
-- two simple wildcards (searches the entire column)
select park_name
from park
WHERE park_name LIKE '%State Park%';

-- --------------------------------------------------------
-- regexp_like more powerful (anyplace in column)
-- Use regexp_substr to see what regexp_like is marking as true
-- --------------------------------------------------------
select park_name,regexp_substr(park_name, 'State Park')
from park
WHERE regexp_like(park_name, 'State Park');

-- ------------------------------------------------
-- lets see if we can find phone numbers
select --park_name,
  --description,
  regexp_substr(description, '...-....')
from PARK
WHERE regexp_like(description, '...-....');

-- ------------------------------------------------
select 
  regexp_substr(description, '.{3}-.{4}')
from park
WHERE regexp_like(description, '.{3}-.{4}');

-- ------------------------------------------------
-- See false positives
select description,
  regexp_substr(description, '...-....')
from park
WHERE regexp_like(description, '...-....')
and (park_name LIKE '%Mus%'
or park_name LIKE '%bofj%');
-- ------------------------------------------------
-- zoom in on false positives
select regexp_substr(description, '...-....'),
  park_name
from park
WHERE regexp_like(description, '...-....')
and (park_name LIKE '%Mus%'
or park_name LIKE '%bofj%');



-- ------------------------------------------------
-- a list of characters
select 
  regexp_substr(description,'[0123456789]{3}-[0123456789]{4}')
from park
WHERE regexp_like(description,'[0123456789]{3}-[0123456789]{4}');

select 
  regexp_substr(description,'[0-9]{3}-[0-9]{4}')
from park
WHERE regexp_like(description,'[0-9]{3}-[0-9]{4}');

select 
  regexp_substr(description,'[[:digit:]]{3}-[[:digit:]]{4}')
from park
WHERE regexp_like(description,'[[:digit:]]{3}-[[:digit:]]{4}');





-- ------------------------------------------------
-- a range of characters depicted page 642
select 
  regexp_substr(description, '[0-9]{3}-[0-9]{4}')
from park
WHERE regexp_like(description, '[0-9]{3}-[0-9]{4}');



-- ------------------------------------------------
-- regexp_count
-- ------------------------------------------------
select regexp_count('The shells she sells are surely seashells', 'el') AS regexp_count
from dual;

select regexp_substr('123456789-2345', '[0-9]{3}-[0-9]{4}') from dual;
select regexp_substr('123456789-2345-5678', '[0-9]{3}-[0-9]{4}') from dual;


-- ------------------------------------------------
-- a character class page 642
-- ------------------------------------------------
select 
  regexp_substr(description, '[[:digit:]]{3}-[[:digit:]]{4}')
from park
WHERE regexp_like(description, '[[:digit:]]{3}-[[:digit:]]{4}');

-- ------------------------------------------------
-- caret ^ is the "NOT" operator
-- so this says anything that is NOT a digit
-- ------------------------------------------------
select park_name,
  regexp_substr(description, '[[:digit:]]{3}[^[:digit:]][[:digit:]]{4}') 
from park
WHERE regexp_like(description, '[[:digit:]]{3}[^[:digit:]][[:digit:]]{4}');
-- ------------------------------------------------
-- escape character "\" if we want to find a period and not have the period
-- represent any character but instead a period
-- this finds phone numbers that have either a period separating the groups
select park_name,
  regexp_substr(description, '[[:digit:]]{3}\.[[:digit:]]{4}')
from park
WHERE regexp_like(description, '[[:digit:]]{3}\.[[:digit:]]{4}');





-- ------------------------------------------------
-- subexpresssions show how quantifiers can be used in multiple places
select 
  regexp_substr(description, '\+([0-9]{1,3} ){1,4}([0-9]+) ' )
from park
WHERE regexp_like(description, '\+([0-9]{1,3} ){1,4}([0-9]+) ');
--
select 
  regexp_substr('45 67 89', '\+([0-9]{1,3} ){1,4}([0-9]+) ' )
from park
WHERE regexp_like('45 67 89', '\+([0-9]{1,3} ){1,4}([0-9]+) ');
--
select 
  regexp_substr('+45 67 89 777 666555555577777 ', '\+([0-9]{1,3} ){1,4}([0-9]+) ' )
from dual
WHERE regexp_like('+45 67 89 777 666555555577777 ', '\+([0-9]{1,3} ){1,4}([0-9]+) ');




select regexp_substr('+46 8 698 10 234565', '\+([0-9]{1,3} ){1,4}[0-9]+') from dual;

select regexp_substr('+46 8 698 10 00', '\+([0-9]{1,3} ){1,4}[0-9]+') from dual;


-- ------------------------------------------------
-- alternation using an or symbol "|" (single pipe)
select 
  regexp_substr(description,'[[:digit:]]{3}-[[:digit:]]{4}|[[:digit:]]{3}\.[[:digit:]]{4}')
from park
WHERE regexp_like(description,'[[:digit:]]{3}-[[:digit:]]{4}|[[:digit:]]{3}\.[[:digit:]]{4}');


-- ------------------------------------------------
-- concise alteration
select park_name,
  regexp_substr(description,'[[:digit:]]{3}(-|\.| )[[:digit:]]{4}')
from park
WHERE regexp_like(description,'[[:digit:]]{3}(-|\.| )[[:digit:]]{4}');

desc park;
insert into park values ('APPLE','0','US','222 3456');
commit;





select 
  regexp_substr(description,'[0-9]{3}(-|\.)[0-9]{4}')
from park
WHERE regexp_like(description,'[0-9]{3}(-|\.)[0-9]{4}');


select 
  regexp_substr(description,'[0-9]{3} [0-9]{4}')
from park
WHERE regexp_like(description,'[0-9]{3} [0-9]{4}');

select * from park;
insert into park values ('ABC',null,'US','234 4567');
commit;


select 
  regexp_substr(description,'[0-9]{3}(-|\.| )[0-9]{4}')
from park
WHERE regexp_like(description,'[0-9]{3}(-|\.| )[0-9]{4}');

select 
  regexp_substr(description,'[0-9]{3}( |-|\.)[0-9]{4}')
from park
WHERE regexp_like(description,'[0-9]{3}( |-|\.)[0-9]{4}');

-- ------------------------------------------------
-- this is area code with () or dashes or periods
select park_name,
  regexp_substr (description, 
  '[[:digit:]]{3}(-|\.| )[[:digit:]]{4}') 
from park
WHERE regexp_like (description, '[[:digit:]]{3}(-|\.| )[[:digit:]]{4}');

select park_name,
  regexp_substr (description, 
  '[[:digit:]]{3}[-|\.| ][[:digit:]]{4}') 
from park
WHERE regexp_like (description, '[[:digit:]]{3}[-|\.| ][[:digit:]]{4}');

select park_name,
  regexp_substr (description, 
  '[[:digit:]]{3}(\.|-| )[[:digit:]]{4}') 
from park
WHERE regexp_like (description, '[[:digit:]]{3}(\.|-| )[[:digit:]]{4}');


select park_name,
  regexp_substr (description, 
  '[[:digit:]]{3}[ .-][[:digit:]]{4}') 
from park
WHERE regexp_like (description, '[[:digit:]]{3}[ .-][[:digit:]]{4}');


select park_name,
  regexp_substr (description, 
  '\([[:digit:]]{3}\)[ .-][[:digit:]]{3}[ .-][[:digit:]]{4}') 
from park
WHERE regexp_like (description, '\([[:digit:]]{3}\)[ .-][[:digit:]]{3}[ .-][[:digit:]]{4}');





select regexp_substr ('289|4567 289.4567 289 4567', '[[:digit:]]{3}[ \.|-][[:digit:]]{4}') a,
       regexp_substr ('289-4567 289.4567 289 4567',  '[[:digit:]]{3}[ \.|-][[:digit:]]{4}') b
from dual;


select regexp_substr ('289|4567 289.4567 289 4567',   '[[:digit:]]{3}[ .|-][[:digit:]]{4}') a,
       regexp_substr ('289.4567 289-4567  289 4567',  '[[:digit:]]{3}[ .|-][[:digit:]]{4}') b,
       regexp_substr ('289-4567 289.4567  289 4567',  '[[:digit:]]{3}[ .|-][[:digit:]]{4}') c,
       regexp_substr ('289 4567 289-4567  289.4567',  '[[:digit:]]{3}[ .|-][[:digit:]]{4}') d
from dual;
-- 289|4567	289.4567	289-4567	289 4567

select regexp_substr (' 289|4567 289.4567 289 4567',   '[[:digit:]]{3}( |\.|-)[[:digit:]]{4}') a,
       regexp_substr (' 289.4567 289-4567  289 4567',  '[[:digit:]]{3}( |\.|-)[[:digit:]]{4}') b,
       regexp_substr (' 289-4567 289.4567  289 4567',  '[[:digit:]]{3}( |\.|-)[[:digit:]]{4}') c,
       regexp_substr (' 289 4567 289-4567  289.4567',  '[[:digit:]]{3}( |\.|-)[[:digit:]]{4}') d
from dual;









select 
  regexp_substr (description, 
  '([[:digit:]]{3}[-|\.| ]|\([[:digit:]]{3}\) )[[:digit:]]{3}[.-.][[:digit:]]{4}') 
from park
WHERE regexp_like (description, 
'([[:digit:]]{3}[-|\.| ]|\([[:digit:]]{3}\) )[[:digit:]]{3}[.-.][[:digit:]]{4}');










select regexp_substr ('906.-.3456','[.-.]') from dual;
 
-- PAGE 657 this is called the back reference operator
-- simple example of back reference \2
-- back reference says match what has already been matched
-- by the numbered subexpression
select regexp_substr('she sells sea shells by the seashore',
          'she sells ([[:alpha:]]+) shells by the \1shore')
from dual;



-- page 657
select address2,regexp_replace(address2,
       '(^[[:alpha:] ]+), ([[:alpha:]]{2}) ([[:digit:]]{5})',
       '\3 \2 \1')
from order_addresses;       

create table email_list
  ( email_id number(7) primary key,
    emaila    varchar2(120),
    CONSTRAINT ck_el_emaila
        check (
              regexp_like (emaila,
                           '^([[:alnum:]]+)@[[:alnum:]]+.(com|net|org|edu|gov|mil)$'
                          )
              )
);
insert into email_list values (1,'1@2.com');
insert into email_list values (2,'joe.smith@getty.com');
insert into email_list values (3,'this is a very long name@2.com');
insert into email_list values (4,'this_is_a_very_long_name@2.com');

select regexp_substr(
        'Dickens, Charles.  "Our Mutual Friend." Riverside Presaa, 1879.',
        '[[:alnum:]]',1,2) answer
from dual;

select regexp_substr('she sells sea shells by the seashore',
                     '(she sells )([[:alpha:]]+) shells by the \2shore')
from dual;


-- ------------------------------------------------
----- send above to students
-- duplicates references
-- the ^ here is the begining of the line
-- not a character at teh beginning but <bol>
select park_name,
  regexp_substr(description, '(^|[[:space:][:punct:]]+)([[:alpha:]]+)'
  || '[[:space:][:punct:]]+\2'
  || '($|[[:space:][:punct:]]+)') hello
from park
WHERE regexp_like(description, '(^|[[:space:][:punct:]]+)([[:alpha:]]+)'
  || '[[:space:][:punct:]]+\2'
  || '($|[[:space:][:punct:]]+)');


select park_name,
  regexp_substr(description, '(^|[[:space:][:punct:]]+)([[:alpha:]]+)'
  || '[[:space:][:punct:]]+\1'
  || '($|[[:space:][:punct:]]+)') double_words
from park
WHERE regexp_like(description, '(^|[[:space:][:punct:]]+)([[:alpha:]]+)'
  || '[[:space:][:punct:]]+\1'
  || '($|[[:space:][:punct:]]+)');


select regexp_substr(',the ,','(^|[[:space:][:punct:]]+)([[:alpha:]]+)'
  || '[[:space:]]\1')
from dual;

select regexp_substr(',the  ','(^|[[:space:][:punct:]]+)([[:alpha:]]+)([[:space:]])\3')
from dual;

select regexp_substr('!the !','(^|[[:space:][:punct:]]+)([[:alpha:]]+)'
  || '[[:space:][:punct:]]+\1')
from dual;


-- START HERE
-- -----------------------------------------------------------------------------
-- REGEX_LIKE
-- find records that have invoice dates between 2010 and 2011
select invoice_id,invoice_date,
  regexp_substr(TO_CHAR(invoice_date,'YYYY'),'^201[0-1]$')
from invoices_revised
where regexp_like (TO_CHAR(INVOICE_DATE,'YYYY'),'^201[0-1]$');



---------------------------
select regexp_substr(TO_CHAR(invoice_date,'YYYY'),'^2[0-9]{2}1$')
    ,to_char(sum(invoice_amt),'$9,999,999,999')
from invoices_revised
where regexp_like (TO_CHAR(INVOICE_DATE,'YYYY'),'^2[0-9]{2}1$')
 group by regexp_substr(TO_CHAR(invoice_date,'YYYY'),'^2[0-9]{2}1$')
;

-- page 648 top
select regexp_substr('123 Maple','[[:alnum:] ]+'),
       regexp_substr('123 Maple','[[:alpha:]]+')
from dual;


-- 648 middle
select address2, regexp_substr(address2,'[[:digit:]]+')
from order_addresses;
--
select address2, regexp_substr(address2,'[[:digit:]]{5}$')
from order_addresses;
--
-- page 649
select regexp_substr('she sells sea shells down by the seashore',
                     's[eashor]+e')
from dual;
-- 
select regexp_substr('she sells sea shells down by the seashore',
                     's(eashor)+e')
from dual;
--
select regexp_substr('she sells sea shells down by the seashore',
                     'seashore')
from dual;
--
select regexp_substr('she sells sea shells down by the seashore',
                     '[[:alpha:]]+(shore)')
from dual;
-- page 650
select address2,regexp_substr(address2,'(TN|MD|OK)')
from order_addresses;


--
select address2,regexp_substr(address2,'[TN|MD|OK]')
from order_addresses;
--
select address2,regexp_substr(address2,'[TNMDOK]',1,2)
from order_addresses;
-- page 651
select regexp_substr('Help Desk: (212) 555-1212',
                      '\([0-9]+\)') area_code
from dual;













--
select regexp_substr('Help Desk: (212) 555-1212',
                      '\([0-9]+\)')
from dual;


-- page 651
select address2,regexp_substr(address2,'[TBH][[:alpha:]]+')
from order_addresses;
--
select regexp_substr('Tvvvv','[TBH] [[:alpha:]]+')
from dual;







--page 652
select regexp_substr('BMW-oracle;Trimaran;February 2010','[^;]+',1,2)
from dual;



--
select regexp_substr('BMW-oracle;Trimaran;February 2010','[^[:alpha:]]+',1,1)abc,
       regexp_instr('BMW-oracle;Trimaran;February 2010','[^[:alpha:]]+',1,1) def
from dual;














-- page 652 middle
select address2
    , regexp_substr(address2,'[378]+$') a
    , regexp_substr(address2,'[378]+') b
    , regexp_substr(address2,'^[BO]+') c
    , regexp_substr(address2,'[^BW]+') d
from order_addresses;










-- page 653 top
select address2,regexp_substr(address2,'87$')
from order_addresses;



--
-- page 653 top
select address2,regexp_substr(address2,'(83|78|1|2)$')
from order_addresses;

select regexp_count('Mississippi','i') from dual;




--
select regexp_substr('A.B*c','[.]') from dual;
--
select regexp_substr('A.B^c','(.)') from dual;
--
select regexp_substr('A.B^c','\.') from dual;

-- page 654
select regexp_replace('Chapter 1 .............. I am Born'
                    ,'[.]+', '-')
from dual;







--
select regexp_replace('Chapter 1 .............. I am Born'
                      ,'[.]', '-')
from dual; 
-- page 654 middle
select regexp_replace('and then he said *&% so I replied with $@($*&@'
                      ,'[!@#$%^&*()]'
                      ,'-')
from dual;                      
-- page 654 alternate
select regexp_replace('and then he said *&% so I replied with $@($*&@'
                      ,'[^&!@#$%*()]'
                      ,'-')
from dual;  
-- page 655 top 
select regexp_replace('and   in        conclusion, 2/3rds   of  our revenue '
                      ,'( ){2,}'
                      ,' ')
from dual;
-- page 656
select address2,regexp_replace(address2,'(^[[:alpha:] ]+)','CITY')
from order_addresses;





select regexp_substr('abc def','[[:alpha:]]+')
from dual;

select count(invoice_id),
  -- invoice_date,
  TO_CHAR(invoice_date,'YYYY'),
  regexp_substr(TO_CHAR(invoice_date,'YYYY'),'^201[0-1]$')
from invoices_revised
where regexp_like (TO_CHAR(INVOICE_DATE,'YYYY'),'^201[0-1]$')
group by TO_CHAR(invoice_date,'YYYY'),
  regexp_substr(TO_CHAR(invoice_date,'YYYY'),'^201[0-1]$');





select invoice_id,
  invoice_date,
  TO_CHAR(invoice_date,'YYYY'),
  regexp_substr (TO_CHAR(INVOICE_DATE,'YYYY'), '^20[0-1]|(09)$')
from invoices_revised
WHERE regexp_like (TO_CHAR(INVOICE_DATE,'YYYY'), '^20[0-1]|(09)$');

select invoice_id,
  invoice_date,
  TO_CHAR(invoice_date,'YYYY'),
  regexp_substr (TO_CHAR(INVOICE_DATE,'YYYY'), '^20([0-1]+|09)$')
from invoices_revised
WHERE regexp_like (TO_CHAR(INVOICE_DATE,'YYYY'), '^20([0-1]+|09)$');




select invoice_id,
  invoice_date,
  TO_CHAR(invoice_date,'YYYY')
from invoices_revised
WHERE regexp_like (TO_CHAR(INVOICE_DATE,'YYYY'), '^20(10)|(11)|(09)$');

select invoice_id,
  invoice_date,
  TO_CHAR(invoice_date,'YYYY')
from invoices_revised
WHERE regexp_like (TO_CHAR(INVOICE_DATE,'YYYY'), '^20(1[0-1])|(09)$');


select invoice_id,
  invoice_date,
  TO_CHAR(invoice_date,'YYYY')
from invoices_revised
WHERE regexp_like (TO_CHAR(invoice_date,'YYYY'), '^20(1[0-1])|(09)$')
and invoice_id = 1120;

UPDATE invoices_revised
SET invoice_date = '08-NOV-09'
WHERE invoice_id = 1120;

commit;
-- ------------------------------------------------
-- find records where first name is J ignore the case
select *
from employees;
-- ------------------------------------------------

select *
from employees
WHERE regexp_like(first_name, '^[^j]','i');

select first_name, regexp_substr(first_name, '[^j]',1,1,'i')
from employees
WHERE regexp_like(first_name, '[^j]','i');



select * from employees WHERE regexp_like(first_name, '^(J|j)');




-- -----------------------------------------------------------------------------
-- REGEX_SUBSTR
-- return records that have tele in f8
select regexp_substr(f8, 'Tele[[:alpha:]]+',1,1,'i')
from files
WHERE regexp_like(f8, 'Tele[[:alpha:]]+');
-- return records that have UCS in f8
select file_id,
  f8,
  regexp_substr(f8, 'UC[[:alpha:]]',1,1,'i')
from files
WHERE regexp_like(f8, 'UCS', 'i');
-- -----------------------------------------------------------------------------
-- REGEX_INSTR
-- return the location of "l" + 4 letters
-- ------------------------------------------------
select regexp_instr('But, soft! What light through yonder window breaks?' ,
                    'o[[:alpha:]]{1,2}', 1, 3) AS result,
       regexp_substr('But, soft! What light through yonder window breaks?' ,
                    'o[[:alpha:]]{1,2}', 1, 3) AS result
from dual;
-- ------------------------------------------------
-- return the location of the second "soft"
select regexp_instr('But, soft! What light through yonder window softly breaks?' , 's[[:alpha:]]{3}', 1, 2) AS result
from dual;
select regexp_instr('But, soft! What light through yonder window softly breaks?' , 's[[:punct:]]') AS result
from dual;
select regexp_instr('But, soft! What light through yonder window softly breaks?' , '[[:alpha:]]s') AS result
from dual;
select regexp_instr('But, soft! What light through yonder window softly breaks?' ,'[[:alpha:]]s{1,2}') AS result
from dual;
select regexp_instr('But, soft! What light through yonder window softly breaks?' ,'o',1,3,1,'i') AS result
from dual;
-- ------------------------------------------------
-- start at position 10 then return location of the second occurance of "o"
select 
regexp_substr ('But, soft! What light through yonder window breaks?' ,'o{1,}', 10, 2),
regexp_instr ('But, soft! What light through yonder window breaks?' ,'o', 10, 2) AS result
from dual;
-- ------------------------------------------------
-- return location of "Tele"
select file_id,
  f8,
  regexp_instr(f8, 'Tele[[:alpha:]]+',1,1,0,'i') place
from files
WHERE upper(f8) LIKE '%TELE%';
-- ------------------------------------------------
-- return location of UCS
select file_id,
  f8,
  regexp_instr(f8, 'UC[[:alpha:]]*',1,1,0,'i')
from files
WHERE upper(f8) LIKE '%UCS%';
-- -----------------------------------------------------------------------------
-- REGEX_REPLACE
select *
from files;
-- ---------------------------------------------------------------------------
-- replace the word "light" with "sound"
select regexp_replace('But, soft! What light through' ,'l[[:alpha:]]{4}', 'sound') AS result
from dual;







-- ------------------------------------------------
-- replace Telepresence with TelePresence
select REGEXP_SUBSTR(F8, 'Tele[[:alpha:]]+',1,1,'i'),
  REGEXP_replace(F8, 'Tele[[:alpha:]]+','TelePresence'),
  f8
from FILES
WHERE UPPER(F8) LIKE '%TELEPR%';
-- Replace "UCS" with "UCS-"
select regexp_substr(f8, 'UC[[:alpha:]]+',1,1,'i'),
  regexp_replace(f8, 'UCS[[:alpha:] ]','UCS-'),
  f8
from files
WHERE upper(f8) LIKE '%UCS%';
-- -----------------------------------------------------------------------------
-- BOOK
-- ------------------------------------------------
-- page 645
select regexp_substr('123 Maple Avenue', '[a-z]') address
from dual;
select regexp_instr('123 Maple Avenue', '[A-Z]') address from dual;
-- ------------------------------------------------
-- page 646 top
select regexp_substr('123 Maple Avenue', '[A-Za-z]', 1, 2) address
from dual;
-- ------------------------------------------------
-- page 646 middle
select regexp_substr('123 Maple Avenue this is a long sentence' , '[ a-zA-Z]+') address
from dual;

-- ------------------------------------------------
-- page 646 bottom
select regexp_substr('123 Maple Avenue', '[ [:alpha:]]+') address
from dual;
-- ------------------------------------------------
-- page 647 top
select regexp_substr('123 Maple Avenue', '[:alpha:]+') address
from dual;
-- ------------------------------------------------
-- page 647 bottom
select regexp_substr('123 Maple Avenue street ', '[[:alpha:]]+',1,2) address
from dual;
-- ------------------------------------------------
-- page 648 top
select regexp_substr('123 Maple Avenue', '[[:alnum:] ]+') address
from dual;



select regexp_substr('123 Maple Avenue Street!', '[[:alnum:] ]+',5,1) address
from dual;



-- ------------------------------------------------
-- page 648 middle
select address2,
  regexp_substr(address2,'[[:digit:]]+') zip_code
from order_addresses;

select address2 from order_addresses;
select street_address, zip from addresses;
select street_address || ' ' || zip from addresses;

-- ---------------------------------------------------------------------------
select street_address, zip,
      regexp_substr(street_address ||  ' ' || zip,'[[:digit:]]{5}$') 
from addresses;
-- ---------------------------------------------------------------------------
-- ------------------------------------------------
-- page 648 bottom
select regexp_substr('123 Maple Avenue', 'Maple') address
from dual;


select regexp_instr('123 Maple Avenue', 'Maple') address from dual;



-- ------------------------------------------------
-- page 649 top
select regexp_substr('she sells sea shells down by the seashore' ,'s[eashor]+e',1,2) ,
       regexp_instr('she sells sea shells down by the seashore' ,'s[eashor]+e',1,2) 
from dual;
-- ------------------------------------------------
-- page 649 middle
select regexp_substr('she sells sea shells down by the seashore' ,'s(eashor)e' ) the_result
from DUAL;
-- ------------------------------------------------
-- page 649 bottom 1
select regexp_substr('she sells sea shells down by the seashore' ,'seashore' ) the_result
from dual;

-- ------------------------------------------------
-- page 649 bottom 2
select regexp_substr('she sells sea shells down by the seashore' ,'[[:alpha:]](shore)' ) the_result
from dual;

select regexp_substr('she sells sea shells down by the seashore' ,'[[:alpha:]]*' ) the_result
from dual;

select regexp_substr('she sells sea shells down by the seashore' ,'sh*e',1,2 ) the_result,
      regexp_instr('she sells sea shells down by the seashore' ,'sh*e',1,2 ) the_result
from dual;
-- ------------------------------------------------
-- page 650 middle
select ADDRESS2,
  REGEXP_SUBSTR(ADDRESS2,'(TN|MD|OK)') RESULT
from order_addresses;

select ADDRESS2,
  REGEXP_SUBSTR(ADDRESS2,' [A-Z]{2} ') RESULT
from order_addresses;

-- ------------------------------------------------
select address2,
  regexp_substr(address2,'[TX|TN|MD|OK]') state
from orDER_ADDRESSES
WHERE regexp_like(address2,'[TX|TN|MD|OK]');
-- ------------------------------------------------


-- page 650 bottom
select regexp_substr('Help desk: (212) 555-1212', '([[:digit:]]+)') area_code
from dual;



select regexp_substr('Help desk: (212) 555-1212', '\([[:digit:]]{3}\)') area_code
from dual;





-- ------------------------------------------------
-- page 651 top
select regexp_substr('Help desk: (212) 555-1212', '\([[:digit:]]+\)') area_code
from dual;
-- ------------------------------------------------
-- page 651 middle
select ADDRESS2,
  regexp_substr(address2,'[TBH][[:alpha:]]+') name
from orDER_ADDRESSES
WHERE regexp_like(address2,'[TBH][[:alpha:]]+') ;



select address2 from order_addresses;
-- ------------------------------------------------
select address2,
  regexp_substr(address2,'[TBH][[:alpha:]]+') name
from order_addresses
WHERE regexp_like(address2,'[TBH][[:alpha:]]+') ;
-- ------------------------------------------------
-- page 652 top
select regexp_substr('BMW-oracle;Trimaran;February 2010', '[^;]+', 1, 2) americas_cup
from dual;
-- ------------------------------------------------
-- page 652 middle
select address2,
  regexp_substr(address2,'[37]+$') something
from order_addresses
WHERE regexp_like(address2,'[37]+$');




select address2,
  regexp_substr(address2,'7$') 
from orDER_ADDRESSES
WHERE regexp_like(address2,'7$');

-- ------------------------------------------------
select address2,
  REGEXP_SUBSTR(ADDRESS2,'[59]+$')
from order_addresses
WHERE regexp_like(address2,'[59]+$') ;
-- ------------------------------------------------
-- page 653 top
select address2,
  regexp_substr(address2,'83$') last_digit
from orDER_ADDRESSES
WHERE regexp_like(address2,'83$') ;
select ADDRESS2,
  regexp_substr(address2,'(83|78|1|2|45)?$') last_digit
from orDER_ADDRESSES
WHERE regexp_like(address2,'(83|78|1|2|45)?$');
select ADDRESS2,
  regexp_substr(address2,'(0)[0-9]{4}$') last_digit
from orDER_ADDRESSES
WHERE regexp_like(address2,'(0)[0-9]{4}?$');
-- ------------------------------------------------
-- page 654 top
select regexp_replace('Chapter 1 ......................... I Am Born','[e]+','-') toc
from dual;

select regexp_replace('Chapter 1 ......................... I Am Born','.+','-') toc
from dual;



select REGEXP_REPLACE('Chapter 1 ......................... I Am Born','[.]','-') TOC
from dual;

select regexp_replace('C','[e]*','-') toc from dual;

select regexp_replace(' ','[e]*','-') toc from dual;
-- ------------------------------------------------
select regexp_replace('Chapter 1 ......................... I Am Born','[.]','-') toc
from dual;
-- ------------------------------------------------
-- page 654 middle
select regexp_replace('and then he said *&% so I replied with $@($*@','[!@#$%^&*()]','-') prime_time
from dual;
-- ------------------------------------------------
-- page 654 bottom
select regexp_replace('and then he said *&% so I replied with $@($*@','[!@#$%^&*()]+','-') prime_time
from dual;
-- ------------------------------------------------
-- page 655 top
select regexp_replace('and  in conclusion, 2/3rds of our  revenue ','( ){2,}', ' ') text_line
from dual;
-- ------------------------------------------------
-- page 655 bottom
select address2,
  regexp_replace(address2, '(^[[:alpha:]]+)', 'CITY') the_string
from order_addresses
WHERE rownum <= 5;
-- ------------------------------------------------
-- page 656 middle
select address2,
  REGEXP_REPLACE(ADDRESS2, '(^[[:alpha:] ]+)', 'CITY') THE_STRING
from order_addresses
WHERE rownum <= 5;
-- ------------------------------------------------
select address2
from order_addresses
WHERE rownum <= 5;
-- page 657
-- ------------------------------------------------
select address2,
  regexp_replace(address2, '(^[[:alpha:] ]+), ([[:alpha:]]{2}) ([[:digit:]]{5})','\3 \2 \1') the_string
from order_addresses
WHERE rownum <= 5;
-- ------------------------------------------------
-- page 658 middle
select address2,
  regexp_replace(address2,'(^[[:alpha:] ,]+) ([[:alpha:]]{2}) ([[:digit:]]{5})','\3 \2 \1') the_string
from order_addresses
WHERE rownum <= 5;
-- ------------------------------------------------
-- page 658 bottom
select address2,
  regexp_replace(address2, '(^[[:alpha:] ]+), ([[:alpha:]]{2}) ([[:digit:]]{5})', '\3 \2-"\1"') the_string
from order_addresses
WHERE rownum <= 5;
-- ------------------------------------------------
-- page 659 bottom
drop table email_list2;
create table email_list2
  (
    email_list_id INTEGER,
    email1        varchar2(120),
    CONSTRAINT ck_el_email12 CHECK ( regexp_like (email1, '^([[:alnum:]]+)@[[:alnum:]]+\.(com|net|org|edu|gov|mil)$') )
  );
insert into email_list2 values
  (1,'1@2.com'
  );
insert into email_list values
  (1,'1@2.ocm'
  );
RENAME email_list TO billsemail;
select * from billsemail;
select email
from people
WHERE regexp_like(email,'^([[:alnum:]]+)@[[:alnum:]]+.(com|net|org|edu|gov|mil)$');

select regexp_substr('this is a (string of .. 567)','\([^)]+\)' ) from dual;
select regexp_substr('S Elton John','Sir +') from dual;

select regexp_substr('mark','^m',1,1,'i') from dual;
select regexp_substr('Mark','^m',1,1,'i') from dual;
select regexp_substr('izziet','^m',1,1,'i') from dual;
select regexp_substr('ivan','^m',1,1,'i') from dual;

select regexp_substr('Charles "Dickens" riverside','[[:alnum:]]+',1,2)
from dual;

select regexp_instr('Charles "Dickens" riverside','[[:alnum:]]+',1,2,1)
from dual;
-- =============================================================================
-- Chapter 18
-- =============================================================================-- -----------------------------------------------------------------------------
-- Tester
-- 1. Login SQLDev\System\admin create user tester\tester
create table two
(test number);
insert into two values(111);
update two set test=344;
delete two;

select *
from books.books;

select *
from cruises.employees;

grant all privileges to tester;

grant create any table to tester;

create table
books.mytester
(test number);

create table
books.mybooks
(test number);

create table
tester.mytester
(test number);

-- OBEJCT PRIVS
-- select
-- delete
-- update
-- insert
-- index
-- references



-- 2. SQLPlus\tester
-- 3. SQLPlus\system\admin
-- 4. Grant create session to tester
-- 5. Disconnect
-- 6. Connect\tester
-- 7. select * from cruises.cruises;
-- 8. Disconnect
-- 9. Connect\system
-- 16. Grant select on cruises.cruises to tester;
-- 17. Disconnect
-- 18. Connect\tester
-- 19. select * from cruises.cruises;
-- 20. Disconnect
create USER tester3 IDENTIFIED BY tester3;
  GRANT
create session TO tester3;
  GRANT
  select ON books.books TO tester3;
-- -----------------------------------------------------------------------------
-- Tester2
-- 21. SQLPlus\system
-- 22. create user tester2 identified by tester2;
-- 23. Disconnect
-- 24. SQLPlus\tester2
-- 25. SQLPlus\system
-- 26. Grant create session to tester2
-- 27. Disconnect
-- 28. SQLPlus\tester2
-- 29. select * from cruises.cruises;
-- 30. SQLPlus\system
-- 31. Grant select on cruises.cruises to tester2;
-- 32. Disconnect
-- 33. SQLPlus\tester2
-- 34. select * from cruises.cruises;
-- 35. Disconnect
-- -----------------------------------------------------------------------------
-- Tester1 & 2 SQLDev
-- 36. SQLDev: create connection\Tester
-- 37. select * from cruises;
-- 38. select * from cruises.cruises;
-- 39. SQL Dev: create connection\Tester2
-- 40. select * from cruises;
-- 41. select * from cruises.cruises;
-- -----------------------------------------------------------------------------
-- Tester3
-- 42. SQL developer\system
-- 43. create user tester3 identified by tester3;
-- 44. SQLDev: create connection\Tester3
-- 45. SQL developer\system
-- 46. grant create session to tester3;
-- 47. SQL developer\tester3
-- 48. select * from cruises;
-- 49. select * from cruises.cruises;
-- 50. SQL developer\system
-- 51. Grant select on cruises.cruises to tester3;
-- 52. SQL developer\tester3
-- 53. select * from cruises;
-- 54. select * from cruises.cruises;
-- -----------------------------------------------------------------------------

create USER tester3 IDENTIFIED BY tester3;
grant create session to tester3;
grant unlimited tablespace to tester3;
grant create table to tester3;

create table three
(id       number primary key,
 name     varchar2(15),
 ssn      varchar2(9),
 zip      varchar2(5)
 );

create index ix_three on three(ssn);

create table tester3.apples
(one  number,
 name  varchar2(15));
 
-- as system
-- create user testindex identified by testindex;
select * 
from all_users
where username LIKE '%TEST%';

drop user tester cascade;
drop user testindex cascade;
-- as system
create user mark identified by mark;
grant create session to mark;
grant unlimited tablespace to mark;
grant create table to mark;

create user molly identified by molly;
grant create session to molly;
grant unlimited tablespace to molly;
grant create any index to molly;

grant references on mark.orders to molly;
grant references on mark.customers to molly;

-- as mark
create table customers
( cid    number primary key,
  name   varchar2(15),
  ssn    varchar2(9),
  zip    varchar2(5)
  );
create table orders
(oid    number,
 custid number,
 odate  date);

alter table orders add foreign key(custid) references customers(cid);
select * from user_cons_columns; 
alter table orders drop constraint sys_c007087 cascade;

alter table mark.orders add foreign key(mark.orders.custid) references mark.customers(mark.orders.cid);

-- as molly
select *
from books.customers;
-- as system
grant select, insert, update, delete on books.customers to molly;
-- as molly
select * from books.customers;
delete from books.customers;
rollback;

create user mike identified by mike;
grant create session to mike;


-- as system
grant select on books.books to mark with grant option;
-- as mark
select * from books.books;
-- as mike
select * from books.books;
-- as molly 
select * from books.books;
-- as mark
grant select on books.books to mike with grant option;
-- as mike
select * from books.books;
-- as molly
select * from books.books;
-- as mike
grant select on books.books to molly;
-- as molly
select * from books.books;
-- as system
revoke select on books.books from mike;
-- as mark
revoke select on books.books from mike;
-- as molly
select * from books.books;
-- as system
grant create any table to mark with admin option;
-- as mark
create table molly.one
(one number);
-- as mike
create table molly.two
(one number);
-- as mark
grant create any table to mike with admin option;
-- as mike
create table molly.three
(one number);
-- as molly
create table four
(one number);
-- as mike
grant create any table to molly;
-- as molly
create table five
(one number);
-- as mark
revoke create any table from mike;
-- as mike
create table six
(one number);
-- as molly
create table seven
(one number);


-- as system
create role cust_service;
grant select on books.customers to cust_service;
grant select on books.orders to cust_service;
grant cust_service to molly;

-- as sytem
create role book_buyer;
grant select on books.books to book_buyer;
grant select on books.publisher to book_buyer;
grant book_buyer to mike;

-- as Molly
select customer#,firstname,lastname,order#
from books.customers join books.orders  using (customer#);
select * from books.customers;
select * from books.orders;

-- as Mike
select title, contact
from books.books join books.publisher using (pubid);

-- as Mike
create public synonym books for books.books;

-- as system
grant create public synonym to molly;
grant create public synonym to mike;

select * from dba_role_privs
where grantee in('MIKE','MOLLY');

select * from dba_sys_privs
where grantee in('MIKE','MOLLY','BOOK_BUYER','CUST_SERVICE');

select * from dba_tab_privs
where grantee in('MIKE','MOLLY','BOOK_BUYER','CUST_SERVICE')
order by 1;

select * from dba_role_privs
where grantee in('MIKE','MOLLY','BOOK_BUYER','CUST_SERVICE');

select distinct role from role_tab_privs;
select * from role_tab_privs;

create table mark.books
(one      number);

-- as molly
create index ix_customers on mark.customers(ssn);

-- as mike 
-- drop public synonym books;
create public synonym books for books.books;

select *  from books;


-- as mark
select * from books.books;
select * from books;


-- as system
create user marsha identified by marsha;
grant create session to marsha;
grant unlimited tablespace to marsha;

-- as marsha
select * from books;

-- as books
create or replace view vw_books as select title from books;

-- as system
grant select on books.vw_books to mike;

-- as mike
select * from books.vw_books;

-- as cruises
create view vw_ship_cabins as select ship_cabin_id from ship_cabins;
-- as system
grant select on cruises.vw_ship_cabins to marsha;
-- as marsha
select * from cruises.vw_ship_cabins;
select * from cruises.ship_cabins;



-- as system
create role abc;
grant select on cruises.employees to abc;
grant abc to mike with admin option;
-- as mike
select * from cruises.employees;
grant abc to mark with admin option;
-- as mark
select * from cruises.employees;
grant abc to molly;
-- as molly
select * from cruises.employees;

-- as system
revoke abc from mark;
select * from cruises.employees;
















































GRANT
create session TO tester3;
  GRANT
  select ON cruises.cruises TO tester2;
  GRANT
  select ON books.books TO tester2;
  GRANT
  select ANY table TO tester2;
create USER tester3 IDENTIFIED BY tester3;
  GRANT
create session TO tester3;
  GRANT
  select ANY table TO tester3;
  ALTER USER tester3 IDENTIFIED BY hawaii;
  drop USER tester3;
  GRANT
create session TO tester3;
  GRANT
  select ON cruises.cruises TO tester2;
  GRANT
  select ON books.books TO tester2;
  GRANT
  select ANY table TO tester2;
create USER harold IDENTIFIED BY lloyd;
  GRANT
create session TO harold;
  GRANT unlimited tableSPACE TO harold;
  GRANT
  create table TO harold;
create USER laurel IDENTIFIED BY poke;
  GRANT
create session TO laurel;
  GRANT unlimited tableSPACE TO laurel;
  GRANT
  create table TO laurel;
create USER hardy IDENTIFIED BY clobber;
  GRANT
create session TO hardy;
  GRANT unlimited tableSPACE TO hardy;
  GRANT
create ANY table TO hardy;
  -- as system
  GRANT ALL PRIVILEGES TO laurel;
  -- as laurel
  create table hardy.test
    (id INTEGER
    );
  select owner,
    table_name
  from all_tab_columns
  WHERE owner IN ('LAUREL', 'HARDY');
create USER sammy IDENTIFIED BY sammy;
  GRANT
create session TO sammy;
create USER sally IDENTIFIED BY sally;
  GRANT
create session TO sally;
  GRANT
  select ON books.books TO sally
WITH GRANT OPTION;
GRANT
select ON books.books TO sammy;
REVOKE
select ON books.books from sally;
create USER mark IDENTIFIED BY mark;
  GRANT
create session TO mark;
create USER mary IDENTIFIED BY mary;

  GRANT
create session TO mary;

  GRANT
  create table TO mark
WITH admin OPTION;
GRANT
create table TO mary;

create table test2
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
  
  
  
  
  
  
  
  
  
  
GRANT unlimited tableSPACE TO mark;
GRANT unlimited tableSPACE TO zooie;
create table test
  (id INTEGER
  );
REVOKE
create table from mark;
GRANT
create ANY table TO PUBLIC;
  REVOKE
create ANY table from PUBLIC;
create SYNONYM t For test;
  GRANT
  select ON t TO mark;
  GRANT
  select ON test TO mark;
  GRANT
  create VIEW TO mary;
  create VIEW vw_test AS
  select * from test;
create SYNONYM vw_t For vw_test;
  GRANT
  select ON vw_t TO mark;
  select * from mary.vw_t;
  select * from mary.vw_test;
create PUBLIC SYNONYM t2 For test2;
  GRANT
create SYNONYM TO mary;
  GRANT
create PUBLIC SYNONYM TO mary;
  GRANT
  select ON test2 TO mark;
  select * from t;
  select * from t2;
  select * from dba_tables WHERE owner = 'CRUISES';
  select DISTINCT owner from dba_tables;
  select * from dba_tables;
  -- wednesday start here
  select * from user_sys_privs;
  select * from dba_sys_privs WHERE grantee IN ('MARY','MARK');
  select * from user_tab_privs WHERE grantee IN ('CRUISES','MARK');
  select * from user_tab_privs WHERE grantee LIKE '%INVOIC%';
  select * from session_roles;
create role books_acct;
  GRANT
  select ON customers TO books_acct;
  GRANT
  select ON orders TO books_acct;
  GRANT
  select ON orderitems TO books_acct;
  GRANT books_acct TO mary;
  GRANT books_acct TO mark;
  select * from books.customers;
  select * from books.orders;
  select * from books.orderitems;
  select * from role_tab_privs;
