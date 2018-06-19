
-- -----------------------------------------------------------------------------
-- E X T E R N A L T A B L E
-- -----------------------------------------------------------------------------
-- page 472
-- -----------------------------------------------------------------------------
-- 1. First login to windows
--    A. physically create the directory c:\temp
--    A. physically move the file called load_invoices.txt into c:\temp
-- -----------------------------------------------------------------------------
-- 2. Then login as system and do:
--    A. CREATE OR REPLACE DIRECTORY BANK_FILES AS 'C:\temp';
CREATE OR REPLACE DIRECTORY INVOICES
  AS   'C:\temp';
--    B. GRANT READ, WRITE ON DIRECTORY BANK_FILES TO CRUISES;
GRANT READ, WRITE ON DIRECTORY INVOICES TO BOOKS;
-- -----------------------------------------------------------------------------
-- 2. Then login as books and do:
--    A. Create the external table (drop table INVOICES_EXTERNAL;)
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
--    B. Confirm your work
select count(*) from invoices_external; -- 39585
-- -----------------------------------------------------------------------------
-- 3. Create a new table with datatypes we want
CREATE TABLE invoices_internal
(
    invoice_id     INTEGER,
    invoice_date   DATE,
    invoice_amt    NUMBER,
    account_number VARCHAR2(13)
);
CREATE TABLE invoices_history
(
    invoice_id     INTEGER,
    invoice_date   DATE,
    invoice_amt    NUMBER,
    account_number VARCHAR2(13)
);




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
from invoices_internal;
-- -----------------------------------------------------------------------------
insert 
      when invoice_date >= '01-JAN-2009' AND invoice_date <= '31-DEC-2009' then
      INTO INVOICES_2009 (invoice_id, invoice_date,invoice_amt,account_number)
      values (invoice_id, invoice_date,invoice_amt,account_number)
      
      when invoice_date >= '01-JAN-2010' AND invoice_date <= '31-DEC-2010' then
      INTO INVOICES_2010 (invoice_id, invoice_date,invoice_amt,account_number)
      values (invoice_id, invoice_date,invoice_amt,account_number)
      
      when invoice_date >= '01-JAN-2011' AND invoice_date <= '31-DEC-2011' then
      INTO INVOICES_2011 (invoice_id, invoice_date,invoice_amt,account_number)
      values (invoice_id, invoice_date,invoice_amt,account_number)
      
      when invoice_date >= '01-JAN-2009' AND invoice_date <= '31-DEC-2011' then
      INTO INVOICES_history (invoice_id, invoice_date,invoice_amt,account_number)
      values (invoice_id, invoice_date,invoice_amt,account_number)
select invoice_id, invoice_date,invoice_amt,account_number
from invoices_internal;
-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------
insert 
      when invoice_date >= '01-JAN-2009' AND invoice_date <= '31-DEC-2009' then
      INTO INVOICES_2009 (invoice_id, invoice_date,invoice_amt,account_number)
      values (invoice_id, invoice_date,invoice_amt,account_number)
      when invoice_date >= '01-JAN-2010' AND invoice_date <= '31-DEC-2010' then
      INTO INVOICES_2010 (invoice_id, invoice_date,invoice_amt,account_number)
      values (invoice_id, invoice_date,invoice_amt,account_number)
      when invoice_date >= '01-JAN-2011' AND invoice_date <= '31-DEC-2011' then
      INTO INVOICES_2011 (invoice_id, invoice_date,invoice_amt,account_number)
      values (invoice_id, invoice_date,invoice_amt,account_number)
      when invoice_date >= '01-JAN-2009' AND invoice_date <= '31-DEC-2011' then
      INTO INVOICES_history (invoice_id, invoice_date,invoice_amt,account_number)
      values (invoice_id, invoice_date,invoice_amt,account_number)
select invoice_id, invoice_date,invoice_amt,account_number
from invoices_internal;
-- -----------------------------------------------------------------------------

select
    (select count(*) from INVOICES_2009) t2009,
    (select count(*) from INVOICES_2010) t2010,
    (select count(*) from INVOICES_2011) t2011,
    (select count(*) from INVOICES_history) thist
from dual;

begin
  delete from INVOICES_2009;
  delete from INVOICES_2010;
  delete from INVOICES_2011;
  delete from INVOICES_HISTORY;
end;
/

select a.position employee, b.position manager, a.max_salary emp_sal, b.max_salary mgr_salary
from positions a join positions b on a.reports_to = b.position_id;

merge into wwa_invoices wwa
using ontario_orders ont on (wwa.cust_po = ont.po_num)
        when matched then update set
              wwa.notes = ont.sales_rep
              delete where wwa.inv_date < to_date ('01-SEP-09')
        when not matched then insert
        (wwa.inv_id, wwa.cust_po, wwa.inv_date,wwa.notes)
        values (seq_inv_id.nextval,ont.po_num, sysdate,ont.sales_rep)
where substr(ont.po_num,1,3) <> 'NBC';

select * from wwa_invoices;
-- INV_ID   CUST_PO   INV_DATE        NOTES
-- 10	      WWA-200	  17-DEC-09	      (null)
-- 20	      WWA-001	  23-DEC-09	      C.  Nelson
-- 21       WWA-017   30-JAN-14       J.  Metelsky
select * from ontario_orders;
--ORDER_NUM   PO_NUM      SALES_REP
--882	        WWA-001	    C.  Nelson
--883	        WWA-017	    J.  Metelsky
--884	        NBC-201	    D.  Knight


rollback;


-- -----------------------------------------------------------------------------
-- 4. Move the raw data into the table with correct format
INSERT INTO invoices_internal 
         (invoice_id, invoice_date,invoice_amt,account_number)
  SELECT  invoice_id, to_date(invoice_date,'mm/dd/yyyy'), 
          to_number(invoice_amt), account_number
  FROM invoices_external;
-- -----------------------------------------------------------------------------
-- 4. Confirm results 
select count(*) from invoices_internal;
-- -----------------------------------------------------------------------------
-- 4. Commit results 
commit;


select to_char(invoice_date,'YYYY') ABC,
      sum(decode(to_char(invoice_date,'YYYY'),
                  '2009', invoice_amt,
                  '2010', invoice_amt,
                  '2011', invoice_amt,
                  0)) def
from invoices_internal
group by to_char(invoice_date,'YYYY');


select to_char(invoice_date,'YYYY') year,
      decode(to_char(invoice_date,'YYYY'),
                  '2009', sum(invoice_amt),
                  '2010', sum(invoice_amt),
                  '2011', sum(invoice_amt),
                  null) sum_year
from invoices_internal;
group by to_char(invoice_date,'YYYY');

select  decode(to_char(invoice_date,'YYYY'),
                  '2009',to_char(invoice_date,'YYYY')
                  ) year
from invoices_internal;

select count(case
                  when category = 'COMPUTER' then category
                  end) as count_com_bks,
       count(case
                  when category = 'COOKING' then category
                  end) as count_cook_bk
from books;
  
 
 select case
                  when category = 'COMPUTER' then category
                  end as com_bks,
       case
                  when category = 'COOKING' then category
                  end as cook_bk
from books; 

select sum(case
          when invoice_date >= '01-JAN-2009' AND invoice_date <= '31-DEC-2009'
              then invoice_amt
       end) T2009
from invoices_internal;

when invoice_date >= '01-JAN-2009' AND invoice_date <= '31-DEC-2009'

select to_char(sum(case
          when invoice_date >= '01-JAN-2009' AND invoice_date <= '31-DEC-2009'
              then invoice_amt
       end), '$999,999,999,999.99') T2009
from invoices_internal;

select to_char(sum(case
          when invoice_date >= '01-JAN-2009' AND invoice_date <= '31-DEC-2009'
              then invoice_amt
       end), '$999,999,999,999.99') T2009,
       to_char(sum(case
          when invoice_date >= '01-JAN-2010' AND invoice_date <= '31-DEC-2010'
              then invoice_amt
       end), '$999,999,999,999.99') T2010,
              to_char(sum(case
          when invoice_date >= '01-JAN-2011' AND invoice_date <= '31-DEC-2011'
              then invoice_amt
       end), '$999,999,999,999.99') T2011
from invoices_internal;


