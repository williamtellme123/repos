create or replace 
PROCEDURE     SYS.Expdp_Schema_cgb (pvchSchemaName VARCHAR, ID1 Number)
IS
/*
--GEO--C--

*/

--DECLARE
  ind NUMBER;              -- Loop index
  h1 NUMBER;               -- Data Pump job handle
  percent_done NUMBER;     -- Percentage of job complete
  job_state VARCHAR2(30);  -- To keep track of job state
  le ku$_LogEntry;         -- For WIP and error messages
  js ku$_JobStatus;        -- The job status from get_status
  jd ku$_JobDesc;          -- The job description from get_status
  sts ku$_Status;          -- The status object returned by get_status

  spos NUMBER;             -- String starting position
  slen NUMBER;             -- String length for output

--GEO--C-- Local variable
     vchlfilename   VARCHAR(250);
     vchSchemafrom     VARCHAR(250);
     lvchtablespace  varchar(250);
     lvchjobname    varchar(200);
     lrowid      varchar(100);


BEGIN

-- Create a (user-named) Data Pump job to do a schema export.
--GEO--C-- need to check before hand if the schema name is valid user

select rowid ,  VCHSCHEMANAME, vchtablespace  into lrowid, vchSchemafrom, lvchtablespace
From system.SYSUSERS where
--VCHOWNER =user and
VCHSCHEMANAME = upper(pvchSchemaName) ;

/*  IF vchusername IS  NULL  THEN

     GOTO EXIT20;
  END IF ;
  */

  DBMS_OUTPUT.ENABLE(10000000);
  DBMS_OUTPUT.PUT_LINE(' EXP of SCHEMA =' || vchSchemafrom  || ' run from  ' ||sys_context('USERENV', 'TERMINAL') ||' username ' || USER  );
--DBMS_OUTPUT.PUT_LINE(' run from  ' ||sys_context('USERENV', 'TERMINAL'));
--DBMS_OUTPUT.PUT_LINE(' username ' || USER);
--  SELECT   sys_context('USERENV', 'TERMINAL') , sys_context('USERENV', 'CURRENT_USER')  FROM dual

--GEO--C--   Define the Dumpfile anme
   vchlfilename:= 'sch_'|| vchSchemafrom || TO_CHAR(SYSDATE, '_YYYYMMDD_HHMI_')|| ID1||'_'||lvchtablespace;

    lvchjobname:='sch_'|| vchSchemafrom || TO_CHAR(SYSDATE, '_YYYYMMDDHHMISS');

   DBMS_OUTPUT.PUT_LINE(' vchlfilename ' || vchlfilename);

  /*********
    need to insert info into tables


CREATE TABLE system.SYSUSERSEXPInfo
(
  SYSUSERSrowid    varchar(100 byte) not null,
  SUSEI_ID   varchar(50 byte ) not null,
  DT_CREATE            DATE                      DEFAULT sysdate,
  vchPATH      varchar(50) ,
  vchdumpname     varchar(20),
  VCHIP               VARCHAR2(200 BYTE),
  VCHHOST             VARCHAR2(200 BYTE)
)
TABLESPACE users


  ********/

  insert into system.SYSUSERSEXPInfo (SYSUSERSrowid, SUSEI_ID , DT_CREATE, vchPATH,vchdumpname,VCHIP, VCHHOST  )
   select lrowid,
       SYS_GUID() ,
    sysdate,
    (select DIRECTORY_PATH From DBA_directories where DIRECTORY_NAme = 'MY_DMPDIR') as path,
    vchlfilename||'.dmp',

    SYS_CONTEXT('USERENV', 'IP_ADDRESS', 20) ,
    SYS_CONTEXT('USERENV', 'HOST')

   from dual;
commit;


--  h1 := DBMS_DATAPUMP.OPEN('EXPORT','SCHEMA',NULL,vchlfilename,'LATEST');
  h1:=dbms_datapump.OPEN (operation   => 'EXPORT',
                              job_mode    => 'SCHEMA',
         job_name =>   lvchjobname
         );

-- 2nd last parameter is the JObName which should be unique say schemname_YYYYMMDDHHMISS

-- Specify a single dump file for the job (using the handle just returned)
-- and a directory object, which must already be defined and accessible
-- to the user running this procedure.

--  DBMS_DATAPUMP.ADD_FILE(h1,'IDP_USER.dmp','DATA_PUMP_DIR');

 DBMS_DATAPUMP.add_file(
    handle    => h1,
    filename  => vchlfilename||'.dmp',
    DIRECTORY => 'MY_DMPDIR'); --- CHNAGE THIS IF WE HAVE TO MOVE THE DUMP LOCATION

  DBMS_DATAPUMP.add_file(
    handle    => h1,
    filename  => vchlfilename||'.log',
    DIRECTORY => 'MY_DMPDIR',
    filetype  => DBMS_DATAPUMP.KU$_FILE_TYPE_LOG_FILE);

-- A metadata filter is used to specify the schema that will be exported.

  DBMS_DATAPUMP.METADATA_FILTER(h1,'SCHEMA_EXPR','IN (''' || UPPER(vchSchemafrom) || ''')' );

  dbms_datapump.set_parallel(handle => h1, degree => 4);

-- Start the job. An exception will be generated if something is not set up
-- properly.

  DBMS_DATAPUMP.START_JOB(h1);

-- The export job should now be running. In the following loop, the job
-- is monitored until it completes. In the meantime, progress information is
-- displayed.

  percent_done := 0;
  job_state := 'UNDEFINED';
  WHILE (job_state != 'COMPLETED') AND (job_state != 'STOPPED') LOOP
    dbms_datapump.get_status(h1,
           dbms_datapump.ku$_status_job_error +
           dbms_datapump.ku$_status_job_status +
           dbms_datapump.ku$_status_wip,-1,job_state,sts);
    js := sts.job_status;

-- If the percentage done changed, display the new value.

    IF js.percent_done != percent_done
    THEN
      DBMS_OUTPUT.PUT_LINE('*** Job percent done = ' ||
                           TO_CHAR(js.percent_done));
      percent_done := js.percent_done;
    END IF;

-- If any work-in-progress (WIP) or error messages were received for the job,
-- display them.

   IF (BITAND(sts.mask,dbms_datapump.ku$_status_wip) != 0)
    THEN
      le := sts.wip;
    ELSE
      IF (BITAND(sts.mask,dbms_datapump.ku$_status_job_error) != 0)
      THEN
        le := sts.error;
      ELSE
        le := NULL;
      END IF;
    END IF;
    IF le IS NOT NULL
    THEN
      ind := le.FIRST;
      WHILE ind IS NOT NULL LOOP
        DBMS_OUTPUT.PUT_LINE(le(ind).LogText);
        ind := le.NEXT(ind);
      END LOOP;
    END IF;
  END LOOP;

-- Indicate that the job finished and detach from it.

  DBMS_OUTPUT.PUT_LINE('Job has completed');
  DBMS_OUTPUT.PUT_LINE('Final job state = ' || job_state);
  dbms_datapump.detach(h1);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
     DBMS_OUTPUT.PUT_LINE('INAVLID SCHEMA/USERNAME = '|| vchSchemafrom);
---GECO--C---
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Exception in Data Pump job');
      dbms_datapump.get_status(h1,dbms_datapump.ku$_status_job_error,0,
                               job_state,sts);
      IF (BITAND(sts.mask,dbms_datapump.ku$_status_job_error) != 0)
      THEN
        le := sts.error;
        IF le IS NOT NULL
        THEN
          ind := le.FIRST;
          WHILE ind IS NOT NULL LOOP
            spos := 1;
            slen := LENGTH(le(ind).LogText);
            IF slen > 255
            THEN
              slen := 255;
            END IF;
            WHILE slen > 0 LOOP
              DBMS_OUTPUT.PUT_LINE(SUBSTR(le(ind).LogText,spos,slen));
              spos := spos + 255;
              slen := LENGTH(le(ind).LogText) + 1 - spos;
            END LOOP;
            ind := le.NEXT(ind);
          END LOOP;
        END IF;
      END IF;
--  DBMS_OUTPUT.DISABLE();
END;