-- -----------------------------------------------------------------------------
-- E X T E R N A L T A B L E
-- -----------------------------------------------------------------------------
--    1. SETUP
--    
--    SPACE DELIMITED
--    CSV (comma delimited)  
--    REGEXP 
-- -----------------------------------------------------------------------------
-- 1. SETUP 
-- -----------------------------------------------------------------------------
--      A. First physically create the directory c:\billy\externalfile';temp
-- -----------------------------------------------------------------------------
--      B. Login as system and create database object DIRECTORY (just a pointer to the actual directory:
        create or replace directory ext_files as   'c:\billy\externalfile';
-- -----------------------------------------------------------------------------  
--      C. Login as system and grant read, write on directory ext_files to billy;
        grant read, write on directory ext_files to billy;

--SONG_ID  	ARTIST_ID	SONG_TITLE    	SONG_WRITER	LENGTH_SECONDS
--1	1	Believe  	Brian Higgin	241
-- CSV 
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

select 