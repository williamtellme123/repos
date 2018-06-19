-- -----------------------------------------------------------------------------
-- E X T E R N A L T A B L E      T X T 
-- -----------------------------------------------------------------------------
-- 1. First physically create the directory c:\temp
-- -----------------------------------------------------------------------------
-- 2. Then login as system and do:
-- A. CREATE OR REPLACE DIRECTORY TMP AS 'C:\temp';
CREATE OR REPLACE DIRECTORY TMP AS   'C:\temp';
-- B. GRANT READ, WRITE ON DIRECTORY TMP TO CRUISES;
GRANT READ, WRITE ON DIRECTORY TMP TO SAMPLECODE;
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
      directory TMP access 
      parameters (records delimited BY newline skip 2 fields 
      ( invoice_id CHAR(6), invoice_date CHAR(13), 
      invoice_amt CHAR(9), account_number CHAR(11)))
      -- make sure there are no extra lines that might be interpreted as null later when loading into PK
      location ('load_invoices.txt')
);
-- -----------------------------------------------------------------------------
-- E X T E R N A L T A B L E      C S V 
-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------
-- 1. First physically create the directory c:\temp
-- -----------------------------------------------------------------------------
-- 2. Then login as system and do:
-- A. CREATE OR REPLACE DIRECTORY TMP AS 'C:\temp';
CREATE OR REPLACE DIRECTORY TMP AS   'C:\temp';
-- B. GRANT READ, WRITE ON DIRECTORY TMP TO CRUISES;
GRANT READ, WRITE ON DIRECTORY TMP TO SAMPLECODE;
-- -----------------------------------------------------------------------------
-- 3. Create the external table
CREATE TABLE song_test
  (sid      NUMBER,
   aid      number,
   title     VARCHAR2(175),
   wrt     VARCHAR2(175),
   secs NUMBER)
ORGANIZATION EXTERNAL
(
    TYPE ORACLE_LOADER
    DEFAULT DIRECTORY TMP
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
drop table song_test;
select * from song_test;

-- as system
connect sys as sysdba/tiger 
grant execute on utl_file to public;
select owner, object_type from all_objects where object_name = 'UTL_FILE' ;
create table song_ext
(song_id    number,
 artist_id  number,
 title      varchar2(100),
 writer     varchar2(100),
 seconds    number);
 
   
DECLARE
  F UTL_FILE.FILE_TYPE;
  V_SID NUMBER;
  V_AID NUMBER;
  V_SONG VARCHAR2(100);
  V_WRT  VARCHAR2(75);
  V_SECS NUMBER;
  V_LINE VARCHAR2(4000);
BEGIN
  F := UTL_FILE.FOPEN ('TMP', 'songs.csv', 'R');
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
      INSERT INTO song_ext VALUES(to_number(V_SID), to_number(V_AID), V_SONG, V_WRT,to_number(V_SECS));
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