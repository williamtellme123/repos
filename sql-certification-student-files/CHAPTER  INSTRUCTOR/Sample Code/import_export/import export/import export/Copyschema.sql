create or replace 
PROCEDURE     SYS.Copyschema
(
   pschemafrom      IN VARCHAR2,
   pschemato        IN VARCHAR2,
   ptablespacefrom1 IN VARCHAR2 DEFAULT NULL,
   ptablespaceto1   IN VARCHAR2 DEFAULT NULL,
   pdumpfilename    IN VARCHAR2,
   pdumpfileDir  IN VARCHAR2
) IS
  hand NUMBER;
  vmessage VARCHAR2(2000);
    ind NUMBER;              -- Loop index

  percent_done NUMBER;     -- Percentage of job complete

    job_state VARCHAR2(30);  -- To keep track of job state
   le ku$_LogEntry;         -- For WIP and error messages
  js ku$_JobStatus;        -- The job status from get_status
  jd ku$_JobDesc;          -- The job description from get_status
  sts ku$_Status;          -- The status object returned by get_status

  spos NUMBER;             -- String starting position
  slen NUMBER;             -- String length for output
  vchjob_name VARCHAR(200):= 'IMPDP_'||UPPER(pschemafrom)||'2'|| UPPER(pschemato) || ' '||sys_context('USERENV', 'TERMINAL') ||' _ ' || USER ;
  vchlogFilename VARCHAR(2000):= 'IMPDP_'||UPPER(pschemafrom)||'2'|| UPPER(pschemato)||'.log';


BEGIN
--      DBMS_OUTPUT.ENABLE(10000000);
	  DBMS_OUTPUT.ENABLE(NULL);

  DBMS_OUTPUT.PUT_LINE( ' setting up'||vchjob_name );
    DBMS_OUTPUT.PUT_LINE( ' pdumpfilename '||pdumpfilename );
   DBMS_OUTPUT.PUT_LINE( ' pdumpfileDir '||pdumpfileDir );

  vchjob_name:='IMDP_'|| TO_CHAR(SYSDATE, 'YYYY_MM_DDHHMISS') ;
  hand := dbms_datapump.OPEN (operation   => 'IMPORT',
                              job_mode    => 'SCHEMA',
         job_name =>   vchjob_name
         );

  dbms_datapump.add_file (handle    => hand,
                          filename  => pdumpfilename,
                          DIRECTORY => pdumpfileDir ); --// 'DATA_PUMP_DIR'


  dbms_datapump.add_file (handle    => hand,
                          filename  => vchlogFilename,
                          DIRECTORY => 'MY_DMPDIR',
                          filetype  => dbms_datapump.ku$_file_type_log_file);


   DBMS_OUTPUT.PUT_LINE( vchlogFilename );

    DBMS_DATAPUMP.METADATA_FILTER(hand,'SCHEMA_EXPR','IN (''' || UPPER(pschemafrom) || ''')' );

  dbms_datapump.set_parameter (handle => hand,
                               NAME   => 'TABLE_EXISTS_ACTION',
                               VALUE  => 'REPLACE');

dbms_datapump.set_parallel(handle => hand, DEGREE => 8);
--DBMS_DATAPUMP.METADATA_FILTER(hand,'EXCLUDE','STATISTICS');
DBMS_DATAPUMP.METADATA_FILTER(hand,'EXCLUDE_PATH_EXPR','=''STATISTICS''');
--2011-06-13 Raghav ---- excluding tables like Temp as catissue is creating temp tables and not dropping. Bug in Catissue production app

  dbms_datapump.metadata_remap (handle    => hand,
                                NAME      => 'REMAP_SCHEMA',
                                old_value => pSchemaFrom,
                                VALUE     => pSchemaTo);

  IF pTablespaceFrom1 IS NOT NULL AND pTablespaceTo1 IS NOT NULL THEN
    dbms_datapump.metadata_remap (handle    => hand,
                                  NAME      => 'REMAP_TABLESPACE',
                                  old_value => pTablespaceFrom1,
                                  VALUE     => pTablespaceTo1);
  END IF;
  DBMS_OUTPUT.PUT_LINE( ' starting :'||vchjob_name );
  dbms_datapump.start_job (hand);


-- The export job should now be running. In the following loop, the job
-- is monitored until it completes. In the meantime, progress information is
-- displayed.

  percent_done := 0;
  job_state := 'UNDEFINED';
  WHILE (job_state != 'COMPLETED') AND (job_state != 'STOPPED') LOOP
    dbms_datapump.get_status(hand,
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
  dbms_datapump.detach(hand);



EXCEPTION
  WHEN OTHERS THEN
    vmessage := SQLERRM;
    DBMS_OUTPUT.PUT_LINE (vmessage || 'george');

   DBMS_OUTPUT.PUT_LINE('Exception in Data Pump job');
      dbms_datapump.get_status(hand,dbms_datapump.ku$_status_job_error,0,
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
END;