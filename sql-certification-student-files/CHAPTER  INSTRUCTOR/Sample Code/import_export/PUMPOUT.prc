CREATE OR REPLACE PROCEDURE PUMPout_PUMPout_BU_KM IS

  ind NUMBER;              -- Loop index
  h1 NUMBER;               -- Data Pump job handle
  percent_done NUMBER;     -- Percentage of job complete
  job_state VARCHAR2(30);  -- To keep track of job state
  le ku$_LogEntry;         -- For WIP and error messages
  js ku$_JobStatus;        -- The job status from get_status
  jd ku$_JobDesc;          -- The job description from get_status
  sts ku$_Status;          -- The status object returned by get_status
  
  filename    varchar2(65 byte);


BEGIN
      --AS SYS CREATE DIRECTORY dmpdir AS '/rdbms/work';
      --AS SYS GRANT READ, WRITE ON DIRECTORY dmpdir TO PROD_SAN;

  DBMS_OUTPUT.PUT_LINE('starting');
  SELECT 'KM_TRACKER_'||TO_CHAR(SYSDATE,'YYYYMMDD')||'.dmp25' 
  into filename
  FROM dual;

 
      -- Create a (user-named) Data Pump job to do a schema export.
      -- =================================================
   h1 := DBMS_DATAPUMP.OPEN('EXPORT','SCHEMA',NULL,'EXAMPLE25','LATEST');
   DBMS_OUTPUT.PUT_LINE('h1 = ' || h1);
      -- =================================================
      --  DBMS_DATAPUMP.OPEN (
      --      operation       IN VARCHAR2,
      --      mode            IN VARCHAR2,
      --      remote_link     IN VARCHAR2 DEFAULT NULL,
      --      job_name        IN VARCHAR2 DEFAULT NULL,
      --      version         IN VARCHAR2 DEFAULT 'COMPATIBLE') 
      -- RETURN NUMBER;
      -- -------------------------------------------------   
      -- OPERATION:
      -- -------------------------------------------------   
      -- EXPORT:      Saves data and metadata to a dump file set or obtains an estimate of the size of the data for an operation.
      -- IMPORT:      Restores data and metadata from a dump file set or across a database link.
      -- SQL_FILE:    Displays the metadata within a dump file set, or from across a network link, as a SQL script. The location of the SQL script is specified through the ADD_FILE procedure.
      -- -------------------------------------------------   
      -- MODE
      -- -------------------------------------------------   
      -- FULL:    Operates on the full database or full dump file set except for the SYS, XDB,ORDSYS, MDSYS, CTXSYS, ORDPLUGINS, and LBACSYS schemas.
      -- SCHEMA:  Operates on a set of selected schemas. Defaults to the schema of the current user. All objects in the selected schemas are processed. Users cannot specify SYS, XDB, ORDSYS, MDSYS, CTXSYS, ORDPLUGINS, or LBACSYS schemas for this mode.
      -- TABLE:   Operates on a set of selected tables. Defaults to all of the tables in the current user's schema. Only tables and their dependent objects are processed.
      -- TABLESPACE: Operates on a set of selected tablespaces. No defaulting is performed. Tables that have storage in the specified tablespaces are processed in the same manner as in Table mode.
      -- TRANSPORTABLE: Operates on metadata for tables (and their dependent objects) within a set of selected tablespaces to perform a transportable tablespace export/import.
      -- -------------------------------------------------   
      -- REMOTE_LINK
      -- -------------------------------------------------   
      -- If the value of this parameter is non-null, it is a database link to remote database that is source of data and metadata for the current job.
      -- -------------------------------------------------   
      -- JOB_NAME
      -- -------------------------------------------------   
      -- Name of the job. Limited to 30 characters; truncated if > 30 characters. It may consist of printable characters and spaces. 
      -- It is implicitly qualified by the schema of the user executing the OPEN procedure and must be unique to that schema (that is, there cannot be other Data Pump jobs using the same name). 
      -- Name used to identify the job both within the API and with other database components such as identifying the job in the DBA_RESUMABLE view if the job becomes suspended 
      -- through lack of resources. If no name supplied, a system generated name will be provided for the job in the following format: "SYS_<OPERATION>_<MODE>_%N". 
      -- The default job name is formed where %N expands to a two-digit incrementing integer starting at '01' (for example, "SYS_IMPORT_FULL_03"). The name supplied for the job will also be used to name the master table and other resources associated with the job.
      -- -------------------------------------------------   
      -- VERSION
      -- -------------------------------------------------   
      --  Version of database objects to be extracted. This option is only valid for Export, network Import, and SQL_FILE operations. 
      --  Database objects or attributes that are incompatible with the version will not be extracted. Legal values for this parameter are as follows:
      --  COMPATIBLE:     (default) the version of the metadata corresponds to the database compatibility level and the compatibility release level for feature (as given in the V$COMPATIBILITY view). Database compatibility must be set to 9.2 or higher. 
      --  LATEST - the version of the metadata corresponds to the database version. 
      --  A specific database version, for example, '10.0.0'. In Oracle Database10g, this value cannot be lower than 10.0.0 
    
      -- Specify a single dump file for the job (using the handle just returned)
      -- and a directory object, which must already be defined and accessible
      -- to the user running this procedure.
      -- =================================================
    DBMS_OUTPUT.PUT_LINE('ADD FILE');
    DBMS_DATAPUMP.ADD_FILE(h1,filename,'DMPDIR3');
    DBMS_OUTPUT.PUT_LINE('ADDED FILE');
      -- =================================================
      --  DBMS_DATAPUMP.ADD_FILE (
      --      handle    IN NUMBER,
      --      filename   IN VARCHAR2,
      --      directory  IN VARCHAR2,
      --      filesize   IN VARCHAR2 DEFAULT NULL,
      --      filetype   IN NUMBER DEFAULT DBMS_DATAPUMP.KU$_FILE_TYPE_DUMP_FILE);
      -- ------------------------------------------------- 
      -- HANDLE:      Handle of a job. The current session must have previously attached to the handle through an OPEN or ATTACH call.
      -- ------------------------------------------------- 
      -- FILENAME:    Name of the file being added. Filename must be simple filename without directory path information. 
      --              For dump files, the filename can include a substitution variable, 
      --              %U, which indicates that multiple files may be generated with the specified filename as a template. 
      --              The %U is expanded in the resulting file names into a two-character, 
      --              fixed-width, incrementing integer starting at 01. 
      --              For example, the dump filename of export%U would cause export01, export02, export03, ... 
      --              to be created depending on how many files are needed to perform the export. 
      --              For filenames containing the % character, the % must be represented as %% to avoid ambiguity. 
      --              Any % in a filename must be followed by either a % or a U.
      -- -------------------------------------------------  
      -- DIRECTORY:   Name of directory object within the database that is used to locate filename. A directory must be specified. 
      --              See the Data Pump Export chapter in Oracle Database Utilities for information about the DIRECTORY command-line parameter.
      -- ------------------------------------------------- 
      -- FILESIZE:    Size of dump file that is being added. It may be specified as the number of bytes, number of kilobytes (if followed by K), 
      --              number of megabytes (if followed by M) or number of gigabytes (if followed by G). 
      --              An Export operation will write no more than the specified number of bytes to the file. 
      --              Once the file is full, it will be closed. If there is insufficient space on the device to write the 
      --              specified number of bytes, the Export operation will fail, but it can be restarted. 
      --              If not specified, filesize will default to an unlimited size. For Import and SQL_FILE operations, 
      --              filesize is ignored. The minimum value for filesize is ten times the default Data Pump block size, 
      --              which is 4 kilobytes. filesize may only be specified for dump files.
      -- -------------------------------------------------  
      -- FILETYPE:    Type of the file to be added. The legal values are as follows and must be preceded by DBMS_DATAPUMP.:
      --              DBMS_DATAPUMP.KU$_FILE_TYPE_DUMP_FILE (dump file for a job) 
      --              DBMS_DATAPUMP.KU$_FILE_TYPE_LOG_FILE (log file for a job) 
      --              DBMS_DATAPUMP.KU$_FILE_TYPE_SQL_FILE (output for SQL_FILE job)
      -- ------------------------------------------------- 
      
      -- A metadata filter is used to specify the schema that will be exported.
      -- =================================================
  DBMS_DATAPUMP.METADATA_FILTER(h1,'SCHEMA_EXPR','IN (''PROD_SAN'')');
      -- =================================================  
      --  DBMS_DATAPUMP.DATA_FILTER(
      --  handle      IN NUMBER,
      --  name        IN VARCHAR2,
      --  value       IN VARCHAR2,
      --  table_name  IN VARCHAR2 DEFAULT NULL,
      --  schema_name IN VARCHAR2 DEFAULT NULL);
      -- ------------------------------------------------- 
      --  handle:         The handle that is returned from the OPEN procedure.
      --  name:           The name of the filter.
      --  value:          The value of the filter.
      --  table_name:     The name of the table on which the data filter is applied. If no table name is supplied, the filter applies to all tables in the job.
      --  schema_name:    The name of the schema that owns the table on which the filter is applied. If no schema name is specified, 
      --                  the filter applies to all schemas in the job. If you supply a schema name you must also supply a table name.
      -- -------------------------------------------------  
      -- to export just a list of tables
      -- dbms_datapump.metadata_filter(h1,'NAME_EXPR','IN (''MY_TABLE1'', ''MY_TABLE2'')');
      -- Start job. An exception is be generated if something is not set up properly. 
      -- =================================================
  DBMS_DATAPUMP.START_JOB(h1);
      -- =================================================
      -- Export job should now be running. In following loop, job is monitored until completion. 
      -- In the meantime, progress is displayed.
 
  percent_done := 0;
  job_state := 'UNDEFINED';
  while (job_state != 'COMPLETED') and (job_state != 'STOPPED') loop
    dbms_datapump.get_status(h1,
           dbms_datapump.ku$_status_job_error +
           dbms_datapump.ku$_status_job_status +
           dbms_datapump.ku$_status_wip,-1,job_state,sts);
    js := sts.job_status;

    -- If the percentage done changed, display the new value.
    if js.percent_done != percent_done
    then
      dbms_output.put_line('*** Job percent done = ' ||
                           to_char(js.percent_done));
      percent_done := js.percent_done;
    end if;

   -- If any work-in-progress (WIP) or error messages received for the job,display them.
   if (bitand(sts.mask,dbms_datapump.ku$_status_wip) != 0)
    then
      le := sts.wip;
    else
      if (bitand(sts.mask,dbms_datapump.ku$_status_job_error) != 0)
      then
        le := sts.error;
      else
        le := null;
      end if;
    end if;
    
   if le is not null
    then
      ind := le.FIRST;
      while ind is not null loop
        dbms_output.put_line('-------------------->' || le(ind).LogText);
        ind := le.NEXT(ind);
      end loop;
   end if;
  end loop;

      -- Indicate that the job finished and detach from it.

  dbms_output.put_line('Job has completed');
  dbms_output.put_line('Final job state = ' || job_state);
  dbms_datapump.detach(h1);
END;
/
