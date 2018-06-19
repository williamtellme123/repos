create user samplecode identified as samplecode;

--SONG_ID  	ARTIST_ID	SONG_TITLE    	SONG_WRITER	LENGTH_SECONDS
--1	1	Believe  	Brian Higgin	241

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
drop table song_test;
select * from song_test;


--  1         2            3                4                5
--SONG_ID  	ARTIST_ID	  SONG_TITLE    	SONG_WRITER	    LENGTH_SECONDS
-- 101	         31	        Believe  	      Brian Higgin	      241

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
-- A. CREATE OR REPLACE DIRECTORY BANK_FILES AS 'C:\oracleclass\ExternalFile';
CREATE OR REPLACE DIRECTORY EXT_FILES
  AS   'C:\oracleclass\ExternalFile';
  
-- B. GRANT READ, WRITE ON DIRECTORY BANK_FILES TO CRUISES;
GRANT READ, WRITE ON DIRECTORY EXT_FILES TO billy;
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
      directory bank_files access 
      parameters (records delimited BY newline skip 2 fields 
      ( invoice_id CHAR(6), invoice_date CHAR(13), 
      invoice_amt CHAR(9), account_number CHAR(11)))
      -- make sure there are no extra lines that might be interpreted as null later when loading into PK
      location ('load_invoices.txt')
);

select * from invoices_external;
select count(*) from invoices_external;


drop public DATABASE LINK custard;
  CREATE PUBLIC DATABASE LINK custard
  CONNECT TO "mythink\billy"
  IDENTIFIED BY pop12345
  USING 'JELLY';
  
SELECT *
  FROM dual@custard;  
