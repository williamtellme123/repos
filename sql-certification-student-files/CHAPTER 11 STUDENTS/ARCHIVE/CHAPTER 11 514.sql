desc books;

alter table books 
add (sale_price number);

select * from books;
--
insert into books
values 
( '999-888-777',
  'This is a very very long titiel to a book that probalby doesnt exist',
  '01-JAN-13',
  1,
  23.333,
  44.44,
  'COMPUTER',
  42.44);

select * from books;
delete from books where isbn = '-666';
alter table books modify (isbn varchar(13), title varchar2(100));

alter table books modify (sale_price default 0 not null);

alter table books add rating varchar2(2) default '10' not null;

alter table books modify(rating null);

update books set rating = null where rating = 10;
select * from books;

alter table books modify rating varchar2(2) default '5' not null;

alter table books modify (rating default 5);
alter table books modify (rating not null);


select * from cruise_orders;

update cruise_orders set order_date = null where cruise_order_id = 2;
rollback;


select * from cruise_orders;
drop table cruise_orders2; 
create table cruise_orders2 as select * from cruise_orders;

select * from cruise_orders2;
update cruise_orders2 set posting_date = null where cruise_order_id =3;

alter table cruise_orders2 modify posting_date date default sysdate constraint conn not null;

desc books;
alter table books rename column sale_price to sale;

alter table books2 rename to books;

alter table books drop column rating;
alter table books set unused column sale;

desc books;
insert into books values ('111','abc',sysdate,1,12,15,'COMPUTER');

alter table books drop unused columns;

drop table cust;
create table cust
as select * from customers;

drop table ords;
create table ords
as select * from orders;

desc books;

alter table cust add constraint c_pk primary key (customer#);
alter table ords modify order# primary key;


select * from all_constraints where owner = 'BOOKS';

desc ords;
desc orders;

alter table ords add constraint cust_fk foreign key (customer#)
                 references cust(customer#);
alter table ords drop constraint cust_fk;

alter table ords modify customer# constraint c_fk foreign key
references cust(customer#);
                 
create user samplecode identified as samplecode;
 
-- uploading an external CSV file 
--SONG_ID   ARTIST_ID   SONG_TITLE      SONG_WRITER LENGTH_SECONDS
--1 1   Believe    Brian Higgin    241
drop table song_test;
CREATE TABLE song_test
  (sid      NUMBER,
   aid      number,
   title     VARCHAR2(175),
   wrt     VARCHAR2(175),
   secs NUMBER)
ORGANIZATION EXTERNAL
(
    TYPE ORACLE_LOADER
    DEFAULT DIRECTORY EXT_FILES
    ACCESS PARAMETERS
    (RECORDS DELIMITED BY NEWLINE
    FIELDS TERMINATED BY ","
    OPTIONALLY ENCLOSED BY '"'
    MISSING FIELD VALUES ARE NULL
    REJECT ROWS WITH ALL NULL FIELDS
      ( sid,
        aid,
        title,
        wrt,
        secs
      )
    )
  LOCATION ('songs.csv')
)
REJECT LIMIT UNLIMITED;
select * from song_test;
 
 
--  1         2            3                4                5
--SONG_ID   ARTIST_ID     SONG_TITLE        SONG_WRITER     LENGTH_SECONDS
-- 101           31         Believe          Brian Higgin        241
-- 101
select REGEXP_SUBSTR('101,31,Tom,Harry,230', '[^,]+', 1, 1) from dual;
-- 31
select REGEXP_SUBSTR('101,31,Tom,Harry,230', '[^,]+', 1, 2) from dual;
-- Tom
select REGEXP_SUBSTR('101,31,Tom,Harry,230', '[^,]+', 1, 3) from dual;
-- Harry
select REGEXP_SUBSTR('101,31,Tom,Harry,230', '[^,]+', 1, 4) from dual;
-- 230
select REGEXP_SUBSTR('101,31,Tom,Harry,230', '[^,]+', 1, 5) from dual;
 
 
select REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 1) from dual;
select REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 2) from dual;
select REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 3) from dual;
select REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 4) from dual;
select REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 5) from dual;

SELECT *
  FROM V$PARAMETER
  WHERE NAME = 'utl_file_dir';
 
 
DECLARE
  F UTL_FILE.FILE_TYPE;
  V_SID NUMBER;
  V_AID NUMBER;
  V_SONG VARCHAR2(100);
  V_WRT  VARCHAR2(75);
  V_SECS NUMBER;
BEGIN
  F := UTL_FILE.FOPEN ('MYCSV', 'songs.csv', 'R');
IF UTL_FILE.IS_OPEN(F) THEN
  LOOP
    BEGIN
      UTL_FILE.GET_LINE(F, V_LINE, 1000);
      IF V_LINE IS NULL THEN
        EXIT;
      END IF;
      V_SID  := REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 1);
      V_AID  := REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 2);
      V_SONG := REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 3);
      V_WRT  := REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 4);
      V_SECS := REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 5);
      INSERT INTO song_ext VALUES(V_SID, V_AID, V_SONG, V_WRT,V_SECS);
      COMMIT;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
      EXIT;
    END;
  END LOOP;
END IF;
UTL_FILE.FCLOSE(F);
END;
/
 
-- -----------------------------------------------------------------------------
-- E X T E R N A L T A B L E
-- -----------------------------------------------------------------------------
-- page 472
-- -----------------------------------------------------------------------------
-- 1. First physically create the directory c:\temp
-- -----------------------------------------------------------------------------
-- 2. Then login as system and do:
-- A. CREATE OR REPLACE DIRECTORY BANK_FILES AS 'C:\temp';
CREATE OR REPLACE DIRECTORY EXT_FILES
  AS   'C:\temp';
   
-- B. GRANT READ, WRITE ON DIRECTORY BANK_FILES TO CRUISES;
GRANT READ, WRITE ON DIRECTORY EXT_FILES TO cruises1;

-- -----------------------------------------------------------------------------
-- 3. Create the external table
drop table INVOICES_EXTERNAL;
select count(*) from invoices_external;
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
      directory ext_files access 
      parameters (records delimited BY newline skip 2 fields 
      ( invoice_id CHAR(6), invoice_date CHAR(13), 
      invoice_amt CHAR(9), account_number CHAR(11)))
      -- make sure there are no extra lines that might be interpreted as null later when loading into PK
      location ('load_invoices.txt')
);

select * from invoices_external;
select count(*) from invoices_external;

create table invoices_internal
(   invoice_id     number,
    invoice_date   date,
    invoice_amt    number,
    account_number varchar2(25));

insert into invoices_internal
select to_number(invoice_id),
       to_date(invoice_date, 'MM/DD/YYYY'),
       to_number (invoice_amt),
       account_number
from invoices_external;       

select to_char(invoice_date, 'YYYY'), to_char(sum(invoice_amt),'$999,999,999,999.00')
from invoices_internal
group by to_char(invoice_date, 'YYYY');

select to_char(sysdate,'YYYY') from dual; 
 
 
 
 
drop public DATABASE LINK custard;
  CREATE PUBLIC DATABASE LINK custard
  CONNECT TO "mythink\billy"
  IDENTIFIED BY pop12345
  USING 'JELLY';
   
SELECT *
  FROM dual@custard;  

-- ----------------------------------------------------------------------------
-- end external file example here
-- ----------------------------------------------------------------------------
create table houdini
( voila varchar2(30));

insert into houdini values ('now you see it');
insert into houdini values ('hi');
insert into houdini values ('bye');
insert into houdini values ('hello');
commit;

drop table houdini;
flashback table houdini to before drop;

ALTER SESSION SET recyclebin = ON;

select * from user_recyclebin;
select * from houdini;

select ora_rowscn, scn_to_timestamp(ora_rowscn), voila
from houdini;
commit;

create restore point abcd;
delete from houdini;
flashback table houdini to restore point abcd;

select * from houdini;
commit;
create restore point abc1;

delete from houdini where voila in ('hi','bye');
flashback table houdini to restore point abc1;




 































.


.




 
 










































































































































































































































































 
 
 

















  










.














        


