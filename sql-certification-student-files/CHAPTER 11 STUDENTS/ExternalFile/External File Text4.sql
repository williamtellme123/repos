-- -----------------------------------------------------------------------------
-- E X T E R N A L T A B L E
-- -----------------------------------------------------------------------------
-- page 472
-- -----------------------------------------------------------------------------
-- 1. First physically create the directory c:\temp
-- -----------------------------------------------------------------------------
-- 2. Then login as system and do:
--    A. CREATE OR REPLACE DIRECTORY BANK_FILES AS 'C:\temp';
CREATE OR REPLACE DIRECTORY BANK_FILES
  AS   'C:\temp';
--    B. GRANT READ, WRITE ON DIRECTORY BANK_FILES TO CRUISES;
GRANT READ, WRITE ON DIRECTORY BANK_FILES TO CRUISES;
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
      directory bank_files access 
      parameters (records delimited BY newline skip 2 fields 
      ( invoice_id CHAR(6), invoice_date CHAR(13), 
      invoice_amt CHAR(9), account_number CHAR(11)))
      -- make sure there are no extra lines that might be interpreted as null later when loading into PK
      location ('load_invoices.txt')
);
--    B. Test external table 
select count(*) from invoices_external;
select * from invoices_external;
select count(*) from invoices_external;