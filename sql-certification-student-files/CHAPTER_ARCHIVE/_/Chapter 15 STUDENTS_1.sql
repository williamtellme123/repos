-- =============================================================================
-- Chapter 15
/* 
    LARGE DATA SETS
      Manipulate Data Using Subqueries (ETL)
      Describe the Features of Multitable INSERTs
          Unconditional
          Conditional
            First
            All
          Pivot  
      Merge Rows in a Table (aka upsert)
      Track Changes to Data over Time
*/   
-- =============================================================================
-- CLASS SETUP & REVIEW
-- If you do not have invoices_revised
-- -----------------------------------------------------------------------------
-- 1. First login to windows
--    A. physically create the directory c:\temp
--    B. physically move the file called load_invoices.txt into c:\temp
-- -----------------------------------------------------------------------------
-- 2. Then login as system and do:
--    A. CREATE OR REPLACE DIRECTORY BANK_FILES AS 'C:\temp';
CREATE OR REPLACE DIRECTORY INVOICES AS  'C:\temp';
--    B. GRANT READ, WRITE ON DIRECTORY BANK_FILES TO CRUISES;
GRANT READ, WRITE ON DIRECTORY INVOICES TO BILLY;
-- -----------------------------------------------------------------------------
-- 3. Then login as billy and do:
--    A. Create the external table (drop table INVOICES_EXTERNAL;)
drop table invoices_external;
drop table invoices_revised;

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
      directory invoices access 
      parameters (records delimited BY newline skip 2 fields 
      ( invoice_id CHAR(6), invoice_date CHAR(13), 
      invoice_amt CHAR(9), account_number CHAR(11)))
      -- make sure there are no extra lines that might be interpreted as null later when loading into PK
      location ('load_invoices.txt')
);
-- -----------------------------------------------------------------------------
-- 4. Confirm your work
select count(*) from invoices_external; -- 39585

select distinct owner, table_name 
from all_tab_columns 
where table_name like 'INVOICE_%';
-- -----------------------------------------------------------------------------
-- 5. Create a new table with datatypes we want
--    Confirm our setup and remember case
select to_char(
        sum(case when to_char(invoice_date, 'YYYY') = '2009'
             then invoice_amt
        end)
        ,'$999,999,999,999.99')
        as tot2009
        ,
        to_char(
        sum(case when to_char(invoice_date, 'YYYY') = '2010'
             then invoice_amt
        end)
        ,'$999,999,999,999.99')
        as tot2010
         ,
        to_char(
        sum(case when to_char(invoice_date, 'YYYY') = '2011'
             then invoice_amt
        end)
        ,'$999,999,999,999.99')
        as tot2011
        ,
        to_char(
        sum(case when 1=1
             then invoice_amt
        end)
        ,'$999,999,999,999.99')
        as totallyears
from invoices_revised;

select count(*)
from invoices_revised;

--    INVOICE_ID
--    INVOICE_DATE
--    INVOICE_AMT
--    ACCOUNT_NUMBER

CREATE TABLE invoices_revised
(
    invoice_id     INTEGER,
    invoice_date   DATE,
    invoice_amt    NUMBER,
    account_number VARCHAR2(13)
);
-- -----------------------------------------------------------------------------
-- 6. Write and execute the ETL
--    We are going to be using this pattern in this chapter
--
--    Insert into table1 (col1, col2, col3)
--    select cola, colb, colc from table2
--    
insert into invoices_revised
(
     invoice_id
    ,invoice_date
    ,invoice_amt
    ,account_number
)
select
    invoice_id
  , to_date(invoice_date,'mm/dd/yyyy')
  , to_number(invoice_amt)
  , account_number
from invoices_external;
commit;
-- -----------------------------------------------------------------------------
-- 7. Create 4 more tables exactly like invoices_revised
--    invoices_history
-- invoices_2009
-- invoices_2010
-- invoices_2011
-- invoices_history

create table invoices_history as select * from invoices_revised where 1=2;


begin
  delete from invoices_2009;
  delete from invoices_2010;
  delete from invoices_2011;
  delete from invoices_history;
end;
/
select
  (select count(*) from invoices_2009) as t2009,
  (select count(*) from invoices_2010) as t2010,
  (select count(*) from invoices_2011) as t2011,
  (select count(*) from invoices_history) as thist
from dual;  


select count(*) from invoices_2009;


CREATE TABLE invoices_history
(
    invoice_id     INTEGER,
    invoice_date   DATE,
    invoice_amt    NUMBER,
    account_number VARCHAR2(13)
);
--    invoices_2009
create table invoices_2009 as select * from invoices_revised where 1=2;
--    invoices_2010
create table invoices_2010 as select * from invoices_revised where 1=2;
--    invoices_2011
create table invoices_2011 as select * from invoices_revised where 1=2;
-- -----------------------------------------------------------------------------
-- 8. We want to be able to aggregate totals by year
--    Lets start with 2009
-- -----------------------------------------------------------------------------
--    a. Start by adding all invoices that are in 2009 to get $2,034,139,924    
--       Use between in the where clause
select to_char(sum(invoice_amt),'$999,999,999,999')
from invoices_revised 
where invoice_date between '01-JAN-2009' and '31-DEC-2009'; 
-- -----------------------------------------------------------------------------
--    b. We need to move this to the select statement to get all three years
--       The decode comes to mind but we remember that decode
--            can only be used when you are comparing a column to a single value.
--            Wait. What if we could pull the year out of the date.
--            Then we can use decode. Try again to total for just 2009 using decode 
select to_char(invoice_date,'YYYY') ABC,
       to_char(sum(decode(
                  to_char(invoice_date,'YYYY'),
                      '2009', invoice_amt,
                      '2010', invoice_amt,
                      '2011', invoice_amt,
                      0)),'$999,999,999,999') as
            Totals
from invoices_revised
group by to_char(invoice_date,'YYYY');
-- -----------------------------------------------------------------------------
--    c. Someone said you might want to use CASE statement for this problem
--       because the book uses it in this chapte.
--       So remember how to use the case to count books in two different
--       categories?
select      
       sum(case when category = 'COMPUTER' then 1 end) as 
       count_of_computer_books,
       sum(case when category = 'COOKING' then 1 end) as 
       count_of_cook_books
from books.books;
-- -----------------------------------------------------------------------------
--    d. OK. Instead of categories and instead of counts 
--       Lets use the Case operator in the select clause sum invoice for 2009 
select to_char( 
            sum(
                case 
                    when invoice_date between '01-JAN-2009' and '31-DEC-2009' then invoice_amt
                end),'$99,999,999,999') as 
        T2009
from invoices_revised;
-- -----------------------------------------------------------------------------
--    e. GREAT. Now lets copy that CASE to the clipboard and then paste it 
--       twice into the select clause. Remember each case is one expression
--       in select so remember the commas.
--       Once you copy and paste change the second case to 2010
--       and the third case to 2011
select 
        to_char( 
            sum(
                case 
                    when invoice_date between '01-JAN-2009' and '31-DEC-2009' then invoice_amt
                end),'$999,999,999,999') as 
        T2009,
        to_char( 
            sum(
                case 
                    when invoice_date between '01-JAN-2010' and '31-DEC-2010' then invoice_amt
                end),'$999,999,999,999') as 
        T2010,
        to_char( 
            sum(
                case 
                    when invoice_date between '01-JAN-2011' and '31-DEC-2011' then invoice_amt
                end),'$999,999,999,999') as 
        T2011
from invoices_revised;

-- =============================================================================
-- NON_CONDITIONAL AND CONDITIONAL MULTI-TABLE INSERTS
-- -----------------------------------------------------------------------------
-- 9. Preparation
-- -----------------------------------------------------------------------------
--      Lets start by writing two SQL statements we will use over and over
--      a. FIRST: select the count from INVOICES_2009, INVOICES_2010, INVOICES_2011
--            and INVOICES_HISTORY
select
    (select count(*) from INVOICES_2009) t2009,
    (select count(*) from INVOICES_2010) t2010,
    (select count(*) from INVOICES_2011) t2011,
    (select count(*) from INVOICES_history) thist
from dual;
-- ---------------------------------------------------------------
--      b. NEXT: write delete statements for each of the tables:
--         INVOICES_2009, INVOICES_2010, INVOICES_2011 and INVOICES_HISTORY
begin
  delete from invoices_2009;
  delete from invoices_2010;
  delete from invoices_2011;
  delete from invoices_history;
end;
/
-- -----------------------------------------------------------------------------
-- 10. MULTI-Table insert 
--     NON-CONDITIONAL INSERT INTO MULTIPLE TABLES
-- -----------------------------------------------------------------------------
-- a. Do the insert
insert all
      INTO INVOICES_2009 (invoice_id, invoice_date,invoice_amt,account_number)
      values (invoice_id, invoice_date,invoice_amt,account_number)

      INTO INVOICES_2010 (invoice_id, invoice_date,invoice_amt,account_number)
      values (invoice_id, invoice_date,invoice_amt,account_number)
      
      INTO INVOICES_2011 (invoice_id, invoice_date,invoice_amt,account_number)
      values (invoice_id, invoice_date,invoice_amt,account_number)
      
      INTO INVOICES_history (invoice_id, invoice_date,invoice_amt,account_number)
      values (invoice_id, invoice_date,invoice_amt,account_number)
select invoice_id, invoice_date,invoice_amt,account_number
from invoices_revised;
-- -----------------------------------------------------------------------------
-- b. Count
--    Confirm
--    Delete
-- -----------------------------------------------------------------------------
-- 11. CONDITIONAL INSERT INTO MULTIPLE TABLES
--    Copy and paste the insert from above
--    Add a blank line above each "INTO"
--    Now lets copy the case "when a=b then" logic from 8.e above
--    and paste it on the blank line above each "INTO"
-- -----------------------------------------------------------------------------
-- a. Do the insert
--    this technique is page 577
insert 
     when invoice_date between '01-JAN-2009' and '31-DEC-2009' then
        INTO INVOICES_2009 (invoice_id, invoice_date,invoice_amt,account_number)
        values (invoice_id, invoice_date,invoice_amt,account_number)
        INTO INVOICES_history (invoice_id, invoice_date,invoice_amt,account_number)
        values (invoice_id, invoice_date,invoice_amt,account_number)
      
      when invoice_date between '01-JAN-2010' and '31-DEC-2010' then
        INTO INVOICES_2010 (invoice_id, invoice_date,invoice_amt,account_number)
        values (invoice_id, invoice_date,invoice_amt,account_number)
        INTO INVOICES_history (invoice_id, invoice_date,invoice_amt,account_number)
        values (invoice_id, invoice_date,invoice_amt,account_number)
      
      when invoice_date between '01-JAN-2011' and '31-DEC-2011' then
        INTO INVOICES_2011 (invoice_id, invoice_date,invoice_amt,account_number)
        values (invoice_id, invoice_date,invoice_amt,account_number)
        INTO INVOICES_history (invoice_id, invoice_date,invoice_amt,account_number)
        values (invoice_id, invoice_date,invoice_amt,account_number)
select invoice_id, invoice_date,invoice_amt,account_number
from invoices_revised;
-- -----------------------------------------------------------------------------
-- b. Count
--    Confirm
--    Delete
-- -----------------------------------------------------------------------------
insert all
      
      INTO INVOICES_2009 (invoice_id, invoice_date,invoice_amt,account_number)
      values (invoice_id, invoice_date,invoice_amt,account_number)
      
      INTO INVOICES_2010 (invoice_id, invoice_date,invoice_amt,account_number)
      values (invoice_id, invoice_date,invoice_amt,account_number)
      
      INTO INVOICES_2011 (invoice_id, invoice_date,invoice_amt,account_number)
      values (invoice_id, invoice_date,invoice_amt,account_number)
      
      INTO INVOICES_history (invoice_id, invoice_date,invoice_amt,account_number)
      values (invoice_id, invoice_date,invoice_amt,account_number)
select invoice_id, invoice_date,invoice_amt,account_number
from invoices_revised;
-- -----------------------------------------------------------------------------

-- =============================================================================
-- MERGING
-- -----------------------------------------------------------------------------
-- 12. Class setup in our student schema
drop table purchase_orders;
create table purchase_orders
(
  po_id       integer primary key,
  po_num      varchar2(10),
  po_date     date,
  sales_rep   varchar2(20)
);
insert into purchase_orders values (882,	'WWA-001',	'01/JAN/15',	'C. Nelson');
insert into purchase_orders values (883,	'WWA-017',	'21/JAN/15',	'J. Metelsky');
insert into purchase_orders values (884,	'NBC-201',	'27/FEB/15',	'D. Knight');
insert into purchase_orders values (885,	'WWA-027',	'15/FEB/15',	'M. Marhshal');
insert into purchase_orders values (886,	'WWA-301',	'19/FEB/15',	'R. Stackman');
insert into purchase_orders values (887,	'WWA-421',	'26/FEB/15',	'R. Stackman');
select * from purchase_orders;
commit;
drop table invoices;
create table invoices
(
  invoice_id   integer primary key,
  cust_po      varchar2(10),
  inv_date     date,
  notes        varchar2(20)
);

insert into invoices values (10,	'WWA-200',	'27/JAN/15',null);
insert into invoices values (20,	'WWA-017',	'31/JAN/15',null);
insert into invoices values (30,	'WWA-001',	'27/JAN/15',null);
insert into invoices values (40,	'WWA-027',	null,null);
insert into invoices values (50,	'WWA-301',	'01/JAN/00',null);
commit;
select * from invoices;
select * from purchase_orders;

select *
from invoices i 
    join purchase_orders p on i.cust_po = p.po_num;
    




select cust_po, po_num
from invoices join purchase_orders on cust_po = po_num;

select po_num
from purchase_orders
minus
select cust_po
from invoices
;


select * from invoices;
-- -----------------------------------------------------------------------------
-- 13. Business rules for merging
--    A. Every PO must be invoiced except NBC in PO_NUM value
--    B. If the PO is not in the invoices table create a new invoice 
--        a. use correct invoice_number
--        b. place the po_num into cust_po
--        c. make the invoice date 10 days after the PO date
--        d. copy the sales representative's name into the notes field
--    C. If the PO is in the table update the sales rep
--        a. copy the sales representative's name into the notes field
--    D. Delete the row from invoices if 
--        a. invoice_date is less than the po_date
--  select max(invoice_id) from invoices;
drop sequence inv_seq; 
create sequence inv_seq start with 60 increment by 10;

merge into invoices
     using purchase_orders on (cust_po = po_num)
        when matched then update set
              notes = sales_rep
              delete where inv_date < po_date
        when not matched then insert
            (invoice_id,cust_po,inv_date,notes)         
        values
            (inv_seq.nextval,po_num,po_date+10,sales_rep)  
where substr(po_num,1,3) <> 'NBC';

select * from invoices;
-- =============================================================================
-- 14. Insert using subqueries Page 564
select MAX(cruise_customer_id) from cruises.cruise_customers;
drop sequence seq_cruise_customer_id;
create sequence seq_cruise_customer_id start with 11;

-- inserting using a subq query
-- exception to the suquery rule of needing () around the sub query 
insert into cruise_customers(cruise_customer_id, first_name, last_name)
select seq_cruise_customer_id.nextval,emp.first_name,emp.last_name
from employees emp;

select * from cruise_customers;



select * from cruise_customers;
-- ----------------------------------------------------------------
select *
from cruise_customers;
-- ----------------------------------------------------------------
-- 15. Page 566
select p.port_name, s.home_port_id, count(s.ship_id) total, sum(s.capacity) capacity
from ships s, ports p
where s.home_port_id = p.port_id
group by port_name,home_port_id
order by 1;
-- ----------------------------------------------------------------
-- 15. Update using subqueries Page 566
select * from ports;
UPDATE ports p
    SET (tot_ships_assigned,tot_ships_asgn_cap)
          = (select NVL(COUNT(s.ship_id),0) total,NVL(SUM(s.capacity),0) capacity
              from ships s
              WHERE s.home_port_id = p.port_id
              GROUP BY home_port_id
            );
 
select * from ports;
select * from ships;
select home_port_id,NVL(COUNT(s.ship_id),0) total,NVL(SUM(s.capacity),0) capacity
from ships s
GROUP BY home_port_id;
-- ----------------------------------------------------------------
-- 16. Conditional insert example
select * from invoices_revised;
drop table invoices_revised_archive;
drop table invoices_revised_archive2;



create table invoices_revised_archive as select * from wo_inv where 1=2;
create table invoices_revised_archive2 as select * from wo_inv where 1=2;




select * from invoices_revised;
select * from invoices_2009;
select * from invoices_2010;
select * from invoices_2011;
select * from invoices_history;
select * from invoices_revised_archive;

-- In cruises page 575
select * from wo_inv;
select * from invoices_archived;
create table invoices_archived as select * from wo_inv where 1=2;
select * from invoices;

insert first
    when (date_shipped < (add_months (sysdate, -12))) then
      into invoices_archived (inv_no, date_entered, date_shipped,cust_acct)
      values (inv_no, date_entered, date_shipped,cust_acct)
--    else
    when (date_shipped >= (add_months (sysdate, -12))) then
      into invoices (invoice_id, invoice_date, shipping_date,account_number)
      values (inv_no, date_entered, date_shipped,cust_acct)
select inv_no, date_entered, date_shipped,cust_acct 
from wo_inv;       

select * from wo_inv;




select * from wo_inv;

select 

select count(*) from invoices_revised_archive;
select count(*) from invoices_revised_archive2;

select COUNT(*) from invoices_all;
-- -----------------------------------------------------------------------------
-- 17. Conditional insert example page 579
select * from positions;
select * from salary_chart;

insert 
    when (boss_salary - employee_salary < 79000) then
    into salary_chart(emp_title,superior,emp_income,sup_income)
      values(employee,boss,employee_salary,boss_salary )
select a.position employee,b.position boss,a.max_salary employee_salary,b.max_salary boss_salary
from positions a join positions b
ON a.reports_to = b.position_id
WHERE a.max_salary > 79000;

select * from positions;

select  a.position employee
      , b.position boss
      , a.max_salary employee_salary
      , b.max_salary boss_salary
from positions a join positions b
on a.reports_to = b.position_id
where a.max_salary > 79000
and b.max_salary - a.max_salary < 79000; 

select * from salary_chart;
commit;
-- -----------------------------------------------------------------------------
-- 18. Conditional insert example page 580
drop table ship_cabin_grid;
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
-- TRUNCATE table ship_cabin_grid;
select * from ship_cabin_grid;
select * from ship_cabin_statistics order by room_type, window_type;
-- -----------------------------------------------------------------------------
-- 19. Conditional insert example
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

select * from ship_cabin_statistics;
-- ----------------------------------------------------------------------------
-- 19. Conditional insert example
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
-- ----------------------------------------------------------------------------
-- 20. FLASHBACK QUERIES
-- ----------------------------------------------------------------------------
-- a. setup the table for testing
--    page 589
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
-- inserted at 8:54
  BEGIN
    insert into chat values(seq_chat_id.nextval,'ABC', 'Bye bye.');
    insert into chat values(seq_chat_id.nextval,'DEF','So long.');
    insert into chat values(seq_chat_id.nextval,'GHI','Happy birthday.');
    insert into chat values(seq_chat_id.nextval, 'JKL', 'Man Overbaord.');
    commit;
  END;
  /
-- ----------------------------------------------------------------------------  
-- b. what is scn
SELECT ora_rowscn, systimestamp - scn_to_timestamp(ora_rowscn) from chat; 
select systimestamp from dual;
-- 14-JUL-16 09.00.40.043000000 PM -05:00
delete from chat;
commit;

select * from chat;

select *
from v$system_parameter
where name like 'undo%';

-- ----------------------------------------------------------------------------
-- c. update
update chat set chat_user = 'ZOOIE' 
where chat_user = 'DEF';
commit;
-- ----------------------------------------------------------------------------
-- c. insert
--  insert into chat 
select *
from chat 
AS OF timestamp systimestamp - interval '0 0:15:30' Day to second;
-- ----------------------------------------------------------------------------
-- d. insert
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
-- 21. Flashback Query page 589
select chat_id,ora_rowscn,scn_to_timestamp(ora_rowscn)
from chat;

desc flashback_transaction_query;
delete from chat;
commit;
select * from chat;
rollback;

select chat_id 
from chat 
as of timestamp systimestamp - interval '0 0:05:30' day to second; 
commit;
-- ----------------------------------------------------------------------------
-- page 590
-- wait for 2 minutes;
select * from chat;
delete from chat;
commit;
select * from chat;

select versions_xid
from chat
versions between timestamp minvalue and maxvalue;

-- ----------------------------------------------------------------------------
-- 22. FLASHBACK QUERY page 590
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
drop table mycustomers cascade constraints;

create table mycustomers
as 
  select firstname || ' ' || lastname as fullname
  from books.customers;

create tABLE MYCUSTOMERS2 (fname, lname)
as select firstname, lastname from books.customers;

desc mycustomers2;
  
desc mycustomers;  


insert 
      when invoice_date between '01-JAN-2009' and '31-DEC-2009' then
        INTO INVOICES_2009 (invoice_id, invoice_date,invoice_amt,account_number)
        values (invoice_id, invoice_date,invoice_amt,account_number)
      
      when invoice_date between '01-JAN-2010' and '31-DEC-2010' then
        INTO INVOICES_2010 (invoice_id, invoice_date,invoice_amt,account_number)
        values (invoice_id, invoice_date,invoice_amt,account_number)
      
      else
        INTO INVOICES_2011 (invoice_id, invoice_date,invoice_amt,account_number)
        values (invoice_id, invoice_date,invoice_amt,account_number)
select invoice_id, invoice_date,invoice_amt,account_number
from invoices_revised;