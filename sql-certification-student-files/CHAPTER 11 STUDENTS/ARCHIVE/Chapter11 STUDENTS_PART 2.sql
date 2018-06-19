-- =============================================================================
/* 
   Chapter 11 
      
    EXTERNAL TABLES
      
      A. SETUP
      
      B. Create External table 
         Read it into a table as all strings
      
      C. Create a new table with correct data types
      
      D. ETL from external table to new table
      
      E. Confirm
*/
-- =============================================================================
--  A  SETUP
-- -----------------------------------------------------------------------------
--      A1. Physically create the directory c:\temp
-- -----------------------------------------------------------------------------
--      A2. Login as system:
--          i.  CREATE OR REPLACE DIRECTORY TMP AS 'C:\temp';
                create or replace directory tmp as   'c:\temp';
--          ii. GRANT READ, WRITE ON DIRECTORY TMP TO CRUISES;
                grant read, write on directory tmp to books;
-- =============================================================================                
-- -----------------------------------------------------------------------------
--  B. CREATE THE EXTERNAL TABLE
--      B1. Login as billy:        
                drop table invoices_external;
                select count(*) from invoices_external;
                create table invoices_external
                (
                    invoice_id     CHAR(6),
                    invoice_date   CHAR(13),
                    invoice_amt    CHAR(9),
                    account_number CHAR(11)
                )
                organization external
                (
                    type oracle_loader default 
                      directory tmp access 
                      parameters (records delimited BY newline skip 2 fields 
                      ( invoice_id char(6), invoice_date char(13), 
                      invoice_amt char(9), account_number char(11)))
                      -- make sure there are no extra lines that might be interpreted as null later when loading into PK
                      location ('load_invoices.txt')
                );
-- -----------------------------------------------------------------------------
--      B1. Confirm
            select count(*) from invoices_external; -- 39585
-- =============================================================================
--   C. CREATE A NEW TABLE WITH CORRECT DATA TYPES
-- -----------------------------------------------------------------------------
--      C1. Login as billy:  
        create table invoices_revised
        (
            invoice_id     integer,
            invoice_date   date,
            invoice_amt    number,
            account_number varchar2(13)
        );
-- =============================================================================
--   D. ETL from external table to new table
          insert into invoices_revised (
                    invoice_id
                  , invoice_date
                  , invoice_amt
                  , account_number)
            select  invoice_id
                  , to_date(invoice_date,'mm/dd/yyyy')
                  , to_number(invoice_amt)
                  , account_number
            from invoices_external;
-- =============================================================================
--   E. Confirm
          select count(*) from invoices_revised;
          commit;
-- =============================================================================
--   F. Commit
          commit;

select
(select count(*) from invoices_revised where to_char(invoice_date, 'YYYY') = 2009) as t2009,
(select to_char(sum(invoice_amt),'$999,999,999,999.99') from invoices_revised where to_char(invoice_date, 'YYYY') = 2009) as sum2009,
(select count(*) from invoices_revised where to_char(invoice_date, 'YYYY') = 2010) as t2010,
(select to_char(sum(invoice_amt),'$999,999,999,999.99') from invoices_revised where to_char(invoice_date, 'YYYY') = 2010) as sum2010,
(select count(*) from invoices_revised where to_char(invoice_date, 'YYYY') = 2011) as t2011,
(select to_char(sum(invoice_amt),'$999,999,999,999.99') from invoices_revised where to_char(invoice_date, 'YYYY') = 2011) as sum2011
from dual;

