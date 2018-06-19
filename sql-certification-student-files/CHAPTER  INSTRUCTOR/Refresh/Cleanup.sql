-- -----------------------------------------------------------------------------
-- 1.  ACCESS PDB
-- 2.  CREATE USERS
-- 3.  CREATE TMP TABLESPACE
-- 4.  IMPORT DATA FROM 11G
-- 5.  INSTALL APEX 5.0.4
-- 30. TROUBLESHOOTING
-- -----------------------------------------------------------------------------
-- 1. ACCESS PDB
      
      -- list containers
      select name,open_mode from v$containers;
      select name,open_mode from v$pdbs;
      -- list services
      select name, con_id from v$active_services;
      select * from v$active_services;
      
      -- Set container
      alter session set container = cdb$root;
      alter session set container=pdborcl;

      -- locate datafile
      select file_name from dba_data_files;
      
      -- drop pdborcl
      drop pluggable database pdborcl including datafiles;
            
      -- recreate pdborcl
      create pluggable database pdborcl admin user pdborcl identified by pdborcl
      file_name_convert=('\pdbseed\','\pdborcl\');
 
      -- display pdbs
      select name,open_mode from gv$pdbs where con_id > 2;
 
      -- open 
      alter pluggable database pdborcl open read write;
      
      -- move into pdborcl
      alter session set container=pdborcl;
      
      -- import from 11g (from each user-- not system)
      -- create user
      create user billy identified by billy;
      grant all privileges to billy;
      grant dba to billy;
      -- as billy
      create directory tmp as 'c:\temp';
      --
      create user books identified by books;
      grant all privileges to books;
      grant dba to books;
     
      create user cruises identified by cruises;
      grant all privileges to cruises;
      grant dba to cruises;
     
      create user texas identified by texas;
      grant all privileges to texas;
      grant dba to texas;
      
       create user homework identified by homework;
      grant all privileges to homework;
      grant dba to homework;
      
       create user test identified by test;
      grant all privileges to test;
      grant dba to test;
      
      --      move test to homework
      select distinct 'create table homework.' || lower(table_name) || ' as select * from test.'  || lower(table_name) || ';'
      from all_tab_columns where owner = 'TEST'; 
      
      create table homework.legacy_backup as select * from test.legacy_backup;
      create table homework.next_gen as select * from test.next_gen;
      create table homework.import_job_sqldev_30 as select * from test.import_job_sqldev_30;
      create table homework.legacy as select * from test.legacy;
      create table homework.migration as select * from test.migration;
      create table homework.next_gen_backup as select * from test.next_gen_backup;
      create table homework.migration_stg as select * from test.migration_stg;
      
      drop user test cascade;
            
      -- close
      alter pluggable database pdborcl close immediate;

      -- explore data files
      desc dba_data_files;
      desc cdb_data_files;

      select file_name, tablespace_name, online_status
      from dba_data_files;

      select file_name, tablespace_name, online_status, con_id
      from cdb_data_files;

      select * from all_users;

      alter session set container=pdborcl;
      --log into pdborcl
      sqlplus system/admin@localhost:1521/pdborcl
      sqlplus system/admin@localhost:1521/xe2
      SYSAUX01

      -- Trace
      alter session set sql_trace = true;
      alter session set tracefile_identifier = 'billy_trace_id';
      show user_dump_dest;
      
      -- find trace files
      select lpad(' ', lvl, ' ')||logical_file trace_name
        from x$dbgdirext
        where logical_file like '%.trc'
             and logical_file like '%billy%';
        --C:\APP\BILLY\diag\rdbms\orcl\orcl\trace

SELECT NAME,OPEN_MODE FROM GV$PDBS WHERE CON_ID > 2;
      
--SQL> connect sys/oracle@racnroll-scan:1521/cdb1 as sysdba
--SQL> connect sys/oracle@racnroll-scan:1521/pdb1 as sysdba 

      select * from dba_pdbs;
      
          select * from cdb_properties;
      select * from cdb_container_data;
      select name, open_mode from v$containers;
      
      -- Get database information
      select * from v$instance;
      select * from v$database;
      
      -- display home
      select SYS_CONTEXT ('USERENV','ORACLE_HOME') from dual;

      
      -- Each container had unique ID
      SELECT SYS_CONTEXT ('USERENV', 'CON_NAME')
            , SYS_CONTEXT ('USERENV', 'CON_ID') FROM DUAL;
      
      show con_name;
      show con_id;
      
      
      
      alter system archive log current;
      select name, open_mode from v$pdbs;
      select pdb_name from dba_pdbs;
      --    PDBORCL
      --    PDB$SEED
      -- is pdborcla mounted?
      select name, open_mode from v$pdbs where name='PDBORCL';
      -- yes, then open
      alter pluggable database pdborcl open;
      -- confirm lsnrctl service
      
      select open_mode from v$pdbs where name='PDBORCL';
      --     READ WRITE
      ALTER SESSION SET sql_trace=TRUE;
      alter pluggable database pdborcl open;
      
     
      create user billy identified by billy;
      grant all privileges to billy;
    
      select name, open_mode from v$pdbs;
     
      alter pluggable database pdborcl open read write;
      alter pluggable database pdborcl save state;
      select con_name, instance_name, state from dba_pdb_saved_states;
  
  SELECT DBMS_XDB.gethttpport FROM DUAL;
select comp_name, version, status from dba_registry where comp_name ='Oracle Application Express';    
      
      --    Check ORACLE version
      select * from v$version;
--    Check APEX version
      select comp_id, version, status from cdb_registry where comp_id='APEX' order by con_id;
      select * from apex_release;
--    Check Container
      select r.comp_name, r.version, c.name, c.con_id from cdb_registry r, v$containers c 
      where r.con_id=c.con_id and r.comp_id='APEX' order by con_id;
      
      

select * from groups;
insert into addresses (address_id) values (10);
insert into groups values (1,'abc',10,'zzz');

--      -- Trigger Open pdbs on startup
--      create or replace trigger open_pdbs 
--        after startup on database 
--      begin 
--         execute immediate 'alter pluggable database all open'; 
--      end open_pdbs;
--      /



-- -----------------------------------------------------------------------------
-- 2. CREATE TMP TABLESPACE
      select tablespace_name, file_name 
      from dba_data_files order by tablespace_name;
      -- TABLESPACE_NAME      FILE_NAME
      -- USERS	                C:\APP\BILLY\ORADATA\ORCL\PDBORCL\SAMPLE_SCHEMA_USERS01.DBF

      create smallfile tablespace "tmp" datafile
      'C:\APP\BILLY\ORADATA\ORCL\PDBORCL\TMP.DBF'
      size 100m autoextend on next 100m maxsize 8g
      --      logging default nocompress online
      extent management local autoallocate
      segment space management manual;

--      alter tablespace add tempfile 'C:\APP\BILLY\ORADATA\ORCL\PDBORCL\TMP.DBF';


-- -----------------------------------------------------------------------------
-- 4. Import Data from 11g
      CREATE DIRECTORY tmp AS 'C:\temp';
      grant read, write on directory tmp to system;

--      Unfortunately could not readily find import into pdborcl
--      so instead converted dmp file to sql and ran it as sys
--          C:\Users\Billy>impdp schemas=books,cruises,test,texas,homework,billy directory=T
--          MP dumpfile=allschemas.dmp sqlfile=newbilly.sql
--          Import: Release 12.1.0.2.0 - Production on Sat Nov 5 11:41:30 2016
--          Copyright (c) 1982, 2015, Oracle and/or its affiliates.  All rights reserved.
--          Username: system as sysdba
--          Password:


-- -----------------------------------------------------------------------------
-- 5. INSTALL APEX 5.0.4
--    http://jastraub.blogspot.de/2015/04/upgrading-to-application-express-50-in.html
--    https://blogs.oracle.com/UPGRADE/entry/apex_in_pdb_does_not
--    https://docs.oracle.com/cd/E59726_01/install.50/e39144/epg.htm#HTMIG29344
--    http://yetanotheroracledbablog.blogspot.com/2015/05/installing-apex-v5-into-12c-pluggable.html 
--    


-- Download apex_5.04 to oracle_home_2
--        cd oracle_home_2\apex_5.04\apex
--        sqlplus / as sysdba
--        SQL> alter session set container=PDB1;
--        SQL> @apexins.sql SYSAUX SYSAUX TEMP /i/

--        sqlplus / as sysdba
--        SQL> alter session set container=PDB1;
--        SQL> @apxchpwd.sql
--        alter user apex_public_user account unlock;
--        sql>password apex_public_user;
--        admin
--
-- -----------------------------------------------------------------------------
--  PDBORCL STATUS  &  USERS
--              select name, open_mode from v$pdbs;
--              alter pluggable database pdborcl open;
--              alter session set container = pdborcl;
--              show con_name;
--              select dbms_xdb_config.gethttpsport()from dual;
--              alter user anonymous account unlock;
--              alter user apex_public_user account unlock;
--              alter user flows_files account unlock;
--              alter user apex_050000 account unlock;
--              alter user anonymous account unlock;
--              alter user xdb account unlock;


-- -----------------------------------------------------------------------------
--  @EPGSTAT.SQL
--
--              c:\app\Billy\product\12.1.0\dbhome_2\RDBMS>cd ADMIN
--              c:\app\Billy\product\12.1.0\dbhome_2\RDBMS\ADMIN>sqlplus / as sysdba
--              SQL*Plus: Release 12.1.0.2.0 Production on Sun Nov 6 11:21:24 2016
--              Copyright (c) 1982, 2014, Oracle.  All rights reserved.
--              Connected to:
--              Oracle Database 12c Standard Edition Release 12.1.0.2.0 - 64bit Production
--              SQL> @epgstat.sql
--              +--------------------------------------+
--              | XDB protocol ports:                  |
--              |  XDB is listening for the protocol   |
--              |  when the protocol port is non-zero. |
--              +--------------------------------------+
--              HTTP Port FTP Port
--              --------- --------
--                   7777        0
--              1 row selected.
--              +---------------------------+
--              | DAD virtual-path mappings |
--              +---------------------------+
--              no rows selected
--              +----------------+
--              | DAD attributes |
--              +----------------+
--              no rows selected
--              +---------------------------------------------------+
--              | DAD authorization:                                |
--              |  To use static authentication of a user in a DAD, |
--              |  the DAD must be authorized for the user.         |
--              +---------------------------------------------------+
--              no rows selected
--              +----------------------------+
--              | DAD authentication schemes |
--              +----------------------------+
--              no rows selected
--              +--------------------------------------------------------+
--              | ANONYMOUS user status:                                 |
--              |  To use static or anonymous authentication in any DAD, |
--              |  the ANONYMOUS account must be unlocked.               |
--              +--------------------------------------------------------+
--              Database User   Status
--              --------------- --------------------
--              ANONYMOUS       EXPIRED
--              1 row selected.
--              +-------------------------------------------------------------------+
--              | ANONYMOUS access to XDB repository:                               |
--              |  To allow public access to XDB repository without authentication, |
--              |  ANONYMOUS access to the repository must be allowed.              |
--              +-------------------------------------------------------------------+
--              Allow repository anonymous access?
--              ----------------------------------
--              false
--              1 row selected.
--              SQL>


--    ANONYMOUS
--    Account allows HTTP access Oracle XML DB used in place of APEX_PUBLIC_USER account when 
--    Embedded PL/SQL Gateway (EPG) is installed in the database.
--    Default: EXPIRED LOCKED
--    
--    EPG is a Web server that can be used with Oracle Database. 
--    It provides the necessary infrastructure to create dynamic applications.
show con_id;
show con_name;
alter user xdb account unlock;
select * from dba_users_with_defpwd order by 1;
select * from dba_users order by 1 desc;
alter user anonymous identified by abc;


DECLARE
  ACL_PATH  VARCHAR2(4000);
BEGIN
  -- Look for the ACL currently assigned to '*' and give APEX_050000
  -- the "connect" privilege if APEX_050000 does not have the privilege yet.
 
  SELECT ACL INTO ACL_PATH FROM DBA_NETWORK_ACLS
   WHERE HOST = '*' AND LOWER_PORT IS NULL AND UPPER_PORT IS NULL;
 
  IF DBMS_NETWORK_ACL_ADMIN.CHECK_PRIVILEGE(ACL_PATH, 'APEX_050000',
     'connect') IS NULL THEN
      DBMS_NETWORK_ACL_ADMIN.ADD_PRIVILEGE(ACL_PATH,
     'APEX_050000', TRUE, 'connect');
  END IF;
 
EXCEPTION
  -- When no ACL has been assigned to '*'.
  WHEN NO_DATA_FOUND THEN
  DBMS_NETWORK_ACL_ADMIN.CREATE_ACL('power_users.xml',
    'ACL that lets power users to connect to everywhere',
    'APEX_050000', TRUE, 'connect');
  DBMS_NETWORK_ACL_ADMIN.ASSIGN_ACL('power_users.xml','*');
END;
/
COMMIT;



-- set pw to unlimited
--      SQL> create profile c##apex_pub_profile limit password_life_time unlimited;
--      SQL> alter user apex_public_user profile c##apex_pub_profile;

--    download oracle http server OHS
--    http://www.oracle.com/technetwork/middleware/webtier/downloads/index-jsp-156711.html


--  ----------------------------------------------------------------------------
--  A. Install OHS
--      i.    https://dbaportal.eu/2015/02/13/installing-standalone-oracle-http-server-12c-12-1-0-3-on-windows-2012-r2/
--      ii.   https://docs.oracle.com/middleware/12212/lcm/install-ohs/index.html
              select status from dba_registry where comp_id = 'apex';
--            VALID
--  ---------------------------------------------------------------------------- 
--  B. Configure
--      Create a domain using the CONFIGURATION WIZARD.
--          C:\Oracle\Middleware\Oracle_Home\oracle_common\common\bin\config.cmd
--              Node Manager: nodemanager
--              pw: P)P12e45
--              C:\Oracle\Middleware\Oracle_Home\user_projects\domains\base_domain
--
--          Configuration settings:
--          DomainsFile=C:\Oracle\Middleware\Oracle_Home\user_projects\domains\base_domain\nodemanager\nodemanager.domains
--          LogLimit=0
--          DomainsDirRemoteSharingEnabled=false
--          AuthenticationEnabled=true
--          LogLevel=INFO
--          DomainsFileEnabled=true
--          ListenAddress=localhost
--          NativeVersionEnabled=true
--          ProcessDestroyTimeout=20000
--          ListenPort=5556
--          LogToStderr=true
--          SecureListener=true
--          LogCount=1
--          LogAppend=true
--          StateCheckInterval=500
--          CrashRecoveryEnabled=false
--          LogFile=C:\Oracle\Middleware\Oracle_Home\user_projects\domains\base_domain\nodemanager\nodemanager.log
--          LogFormatter=weblogic.nodemanager.server.LogFormatter
--          ListenBacklog=50
--          NodeManagerHome=C:\Oracle\Middleware\Oracle_Home\user_projects\domains\base_domain\nodemanager
--          weblogic.startup.JavaHome=C:\Oracle\MIDDLE~1\ORACLE~1\ORACLE~1\jdk\jre
--          weblogic.startup.MW_Home=
--          coherence.startup.JavaHome=C:\Oracle\MIDDLE~1\ORACLE~1\ORACLE~1\jdk\jre
--          coherence.startup.MW_Home=
--          
--          Domain name mappings:
--          
--          base_domain -> C:\Oracle\Middleware\Oracle_Home\user_projects\domains\base_domain
--          
--          <Nov 6, 2016 8:24:24 AM CST> <INFO> <Node manager v12.2.1.2.0>
--          <Nov 6, 2016 8:24:25 AM CST> <INFO> <Secure socket listener started on port 5556, host localhost/127.0.0.1>
--  ---------------------------------------------------------------------------- 
--  C. Change admin pw
--  ----------------------------------------------------------------------------
select * from APEX_050000.WWV_FLOW_FND_USER;
where account_locked = 'Y';

select * from dba_users order by 1;
--  D. Start
--      Start Node Manager and Domain Servers.
--          C:\Oracle\Middleware\Oracle_Home\user_projects\domains\base_domain\bin\startNodemanager.cmd oh1



-- find demo apps


-- 28. Unlock HR        
-- 29. Grant flashback


-- -----------------------------------------------------------------------------
-- 28. Unlock HR
alter user hr identified by hr account unlock;
-- -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- 29. Grant flashback
grant flashback on hr.employees to scott;
grant select any transaction to scott;


-- -----------------------------------------------------------------------------
-- 30. TROUBLESHOOTING
--    http://techiesdigest.com/ora-01033-oracle-initialization-or-shutdown-in-progress/
--    Error Message:
--    ORA-01033: ORACLE initialization or shutdown in progress
--    Resolution:
--    
--    As a DBA, you must know the Shutdown, Shutdown Immediate or Startup 
--    commands that are issued by database administrator with SYSDBA privileges.
--    
--    If your database shutdown is in progress then wait for some 
--    time till the database gets shutdown. 
--    Now first connect your database with system user.
--    
--      C:\>sqlplus system/system
--      SQL*Plus: Release 11.2.0.2.0 Production on Thu Jul 02 12:21:40 2015
--      Copyright (c) 1982, 2010, Oracle.  All rights reserved.
--      ERROR:
--      ORA-01033: ORACLE initialization or shutdown in progress
--      Process ID: 0
--      Session ID: 0 Serial number: 0
--    
--    To check the current status of database and instance, 
--    you must login with SYSDBA privileges.
--    
--      C:\>sqlplus
--      SQL*Plus: Release 11.2.0.2.0 Production on Thu Jul 02 12:23:42 2015
--      Copyright (c) 1982, 2010, Oracle.  All rights reserved.
--      Enter user-name: / as sysdba
--      Connected to:
--      Oracle Database 11g Express Edition Release 11.2.0.2.0 – Production
--    
--      SQL> select status, database_status from v$instance;
--      STATUS       DATABASE_STATUS
--      ------------ -----------------
--      STARTED      ACTIVE
--    
--      SQL> select open_mode from v$database;
--    
--      select open_mode from v$database
--      *
--      ERROR at line 1:
--      ORA-01507: database not mounted
--    
--    Here you can see the instance is started but database is not mounted. 
--    Now its time to mount the database. Issue following command to 
--    mount the database, if this succeeds then there is no problem.
--    
--      SQL> alter database mount;
--      Database altered.
--    
--      SQL> select status, database_status from v$instance;
--      STATUS       DATABASE_STATUS
--      ------------ -----------------
--      MOUNTED      ACTIVE
--    
--      SQL> select open_mode from v$database;
--      OPEN_MODE
--      ----------
--      MOUNTED
--    
--    Database is mounted successfully but when you try to connect, 
--    you still get the same ORA-01033 error. Type exit and reconnect with system user.
--    
--      SQL> exit
--      Disconnected from Oracle Database 11g Express Edition Release 11.2.0.2.0 – Production
--    
--      C:\>sqlplus system/system
--      SQL*Plus: Release 11.2.0.2.0 Production on Thu Jul 02 12:25:26 2015
--      Copyright (c) 1982, 2010, Oracle.  All rights reserved.
--      ERROR:
--      ORA-01033: ORACLE initialization or shutdown in progress
--      Process ID: 0
--      Session ID: 0 Serial number: 0
--    
--    When you open the database, you must ensure that database is opened in 
--    read write mode. Now open your database with SYSDBA privileges.
--    
--      Enter user-name: / as sysdba
--      SQL*Plus: Release 11.2.0.2.0 Production on Thu Jul 02 12:30:30 2015
--      Copyright (c) 1982, 2010, Oracle.  All rights reserved.
--      Connected to:
--      Oracle Database 11g Express Edition Release 11.2.0.2.0 - Production
--    
--      SQL> alter database open;
--      Database altered.
--    
--      SQL> select status, database_status from v$instance;
--      STATUS       DATABASE_STATUS
--      ------------ -----------------
--      OPEN         ACTIVE
--    
--      SQL> select open_mode from v$database;
--      OPEN_MODE
--      ----------
--      READ WRITE
--    
--    Here you can see the database is opened in read write mode and 
--    your database issue is resolved. Now you can login with your 
--    user name and password to access your database.




-- -----------------------------------------------------------------------------
-- 1. FIND USERS
    -- Find pdb
    select * from dba_pdbs;
    -- Find users
    alter session set container=pdborcl;
    select * from all_users;
    
    select * from dba_sys_privs
    where username = 'BILLY';
    
    select * from v$pwfile_users;
    
    select * from dba_users;
    select password from dba_users 
    where username = 'BILLY';

    select * from all_users
    where username not like 'APEX%'
      and username not like 'FLOW%'
      and username not in
        ('XS$NULL'
        ,'HR'
        ,'MDSYS'
        ,'ANONYMOUS'
        ,'XDB'
        ,'CTXSYS'
        ,'OUTLN'
        ,'SYSTEM'
        ,'SYS');

    select 'create user ' || lower(username) || '2 identified by '|| lower(username) || '2;'
    from all_users
              where username not like 'APEX%'
              and username not like 'FLOW%'
              and username not in
              ('XS$NULL'
              ,'HR'
              ,'MDSYS'
              ,'ANONYMOUS'
              ,'XDB'
              ,'CTXSYS'
              ,'OUTLN'
              ,'SYSTEM'
              ,'SYS');

    select 'grant all privileges to ' || username || ';'
    from all_users
              where username not like 'APEX%'
              and username not like 'FLOW%'
              and username not in
              ('XS$NULL'
              ,'HR'
              ,'MDSYS'
              ,'ANONYMOUS'
              ,'XDB'
              ,'CTXSYS'
              ,'OUTLN'
              ,'SYSTEM'
              ,'SYS')
              and username like '%2';

    select 'drop user ' || username || ' cascade;'
    from all_users
              where username not like 'APEX%'
              and username not like 'FLOW%'
              and username not in
              ('XS$NULL'
              ,'HR'
              ,'MDSYS'
              ,'ANONYMOUS'
              ,'XDB'
              ,'CTXSYS'
              ,'OUTLN'
              ,'SYSTEM'
              ,'SYS')
               and username like '%2';

    begin;
          create user books identified by books; 
          create user cruises identified by cruises;
          create user test identified by test;
          create user homework identified by homework;
          create user texas identified by texas;
          grant all privileges to billy,books,cruises,test,homework,texas;
    end;
    /