-- -----------------------------------------------------------------------------
-- E X T E R N A L T A B L E
-- -----------------------------------------------------------------------------
-- page 472
-- -----------------------------------------------------------------------------
-- 1. First login to windows
--    A. physically create the directory c:\temp
--    B. physically move the file called load_invoices.txt into c:\temp
-- -----------------------------------------------------------------------------
-- 2. Then login as system and do:
--    A. CREATE OR REPLACE DIRECTORY BANK_FILES AS 'C:\temp';
CREATE OR REPLACE DIRECTORY INVOICES
  AS   'C:\temp';
--    B. GRANT READ, WRITE ON DIRECTORY BANK_FILES TO CRUISES;
GRANT READ, WRITE ON DIRECTORY INVOICES TO BOOKS;
-- -----------------------------------------------------------------------------
-- 3. Then login as books and do:
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
-- 4. Move the raw data into the table with correct format
INSERT INTO invoices_internal 
         (invoice_id, invoice_date,invoice_amt,account_number)
  SELECT  invoice_id, to_date(invoice_date,'mm/dd/yyyy'), 
          to_number(invoice_amt), account_number
  FROM invoices_external;
-- -----------------------------------------------------------------------------
-- 5. Confirm results 
select count(*) from invoices_internal;
-- -----------------------------------------------------------------------------
-- 6. Commit results 
commit;



