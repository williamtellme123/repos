create or replace 
PROCEDURE     SYS.sp_RefreshSchema_CGB
(

   pschemato        IN VARCHAR2 ,
   pdumpfile  in varchar2 default null
) IS
   hand NUMBER;
   vmessage VARCHAR2(2000);
   ind NUMBER;              -- Loop index
   vchSchemafrom       VARCHAR2(200):=null;

   percent_done NUMBER;     -- Percentage of job complete

   job_state VARCHAR2(30);  -- To keep track of job state
   le ku$_LogEntry;         -- For WIP and error messages
   js ku$_JobStatus;        -- The job status from get_status
   jd ku$_JobDesc;          -- The job description from get_status
   sts ku$_Status;          -- The status object returned by get_status

   spos NUMBER;             -- String starting position
   slen NUMBER;             -- String length for output
   vchjob_name VARCHAR(200);--'IMPDP_'||UPPER(pschemafrom)||'2'|| UPPER(pschemato) || ' '||sys_context('USERENV', 'TERMINAL') ||' _ ' || USER ;
   vchlogFilename VARCHAR(2000); --'IMPDP_'||UPPER(pschemafrom)||'2'|| UPPER(pschemato)||'.log';

   vchtablespacefrom1 VARCHAR2(200) ;
   vchtablespaceTo1 VARCHAR2(200) ;
   vchDUMPFilename  varchar(200);
   vchprodSchema  varchar(200);
   err_msg  varchar(200);
   starttime varchar(20);
   ldumpfile varchar(450);
   ldumpdirname varchar(90);
   ldumppathname varchar(250);
   p1 varchar(1000);

BEGIN
--     DBMS_OUTPUT.ENABLE(10000000);
     DBMS_OUTPUT.ENABLE(NULL);
--GEO--C--2010-01-07 find the schema/appname from we need to refresh
  DBMS_OUTPUT.PUT_LINE( 'vchSchemafrom is   -->'||pschemato || ' fff ' || pdumpfile);

  DBMS_OUTPUT.PUT_LINE( 'Permission check for '||pschemato|| ' for '|| user || ' ' ||  TO_CHAR(SYSDATE, 'YYYY/mm/dd HH:MI:SS'));
  select VCHCLONEOF into vchSchemafrom From system.SYSUSERS where VCHOWNER =user and VCHSCHEMANAME = upper(pschemato) ;

  DBMS_OUTPUT.PUT_LINE( 'Cleaning schema -->'||pschemato|| ' started at' ||  TO_CHAR(SYSDATE, 'YYYY/mm/dd HH:MI:SS'));
  CleanSchema(pschemato);
  DBMS_OUTPUT.PUT_LINE( 'Cleaning schema -->'||pschemato|| ' finsihed at' ||  TO_CHAR(SYSDATE, 'YYYY/mm/dd HH:MI:SS'));



     vchjob_name :='IMPDP_'||UPPER(vchSchemafrom)||'2'|| UPPER(pschemato) || ' '||sys_context('USERENV', 'TERMINAL') ||' _ ' || USER ;
     vchlogFilename :='IMPDP_'||UPPER(vchSchemafrom)||'2'|| UPPER(pschemato)||'.log';

   DBMS_OUTPUT.PUT_LINE( vchlogFilename );
--GEO--C--2010-01-07 From  the app name we will find the schema anme and tbs name and dumpfile

  select name, schema into vchDUMPFilename  ,vchprodSchema
  from PRODUCT_MAPP
  where product=vchSchemafrom;

  DBMS_OUTPUT.PUT_LINE( 'dumpfile prod  -->' ||vchDUMPFilename ||' |  prodschema --> '  || vchprodSchema );

--GEO--C--2010-01-07  get the default tbs  name
   select DEFAULT_TABLESPACE into vchtablespacefrom1  from DBA_Users where username = vchprodSchema;

   select DEFAULT_TABLESPACE into vchtablespaceTo1  from DBA_Users where username = user;
--  select vchtablespaceTo1
--GEO--C--2010-01-07 Call coppschema prod

 DBMS_OUTPUT.PUT_LINE( 'from tbsb  -->' || vchtablespacefrom1 ||' |  to TBS -->'  || vchtablespaceTo1 );
 DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------------------------------------------------------');
 DBMS_OUTPUT.PUT_LINE('---------| Starting Refresh  ' || to_char(sysdate, 'YYYY/mm/dd HH:MI:SS') || ' |---------------------' );

--GEC--C--2010-01-28  find the datadirectory objects or create a new DIR object
--'/home/oracle/asd.dmp'





if pdumpfile is not null then
     select reverse( pdumpfile) into ldumpfile from dual ;

 ldumpfile := substr((ldumpfile),  instr(ldumpfile, '/')  +1, length(ldumpfile) -  instr(ldumpfile, '/') );

     select reverse( ldumpfile) into ldumppathname from dual ;

   ldumpdirname := 'IMPDP_'||UPPER(vchprodSchema)||'2'|| UPPER(pschemato);


   if (instr(pdumpfile , '/') >0)  then
 DBMS_OUTPUT.PUT_LINE( 'create directory '||ldumpdirname || ' cccc as '|| chr(39) || ldumppathname || chr(39) );
    EXECUTE IMMEDIATE ('create directory '||ldumpdirname || ' as '|| chr(39) || ldumppathname || chr(39));
    end if ;


-- NOW figure out the dumpfile

     select reverse( pdumpfile) into ldumpfile from dual ;
   ldumpfile := substr((ldumpfile),  0, instr(ldumpfile, '/') -1);
       select reverse( ldumpfile) into ldumpfile from dual ;
  DBMS_OUTPUT.PUT_LINE( 'DUMPFILE name is '||ldumpfile );


-- Now CONSIDER that user has given only the dump file name
   if (instr(pdumpfile , '/') <=0)  then
   ldumpfile := pdumpfile;--ctory object name
   -- get dire
     DBMS_OUTPUT.PUT_LINE( 'DUMPFILE here is '||ldumpfile );
   select DIRECTORY_NAME  into ldumpdirname  From DBA_directories where lower (DIRECTORY_path) in ( select lower(vchPAth) from
      system.SYSUSERSEXPInfo where  upper(vchDUMPname) = upper(ldumpfile)
    );


 end if   ;

 vchDUMPFilename := ldumpfile; --// assign dumpfile
--steps
--1) see if the  we can pull from SYSUSERSEXPInfo table

     select vchtablespace, vchschemaname into vchtablespacefrom1,  vchprodSchema
  from system.sysusers where rowid in (
    select sysusersrowid from system.SYSUSERSEXPInfo a where upper(vchDUMPname) = upper(ldumpfile)
       );




else

 ldumpdirname :='DP_DRIVE_LOCAL'; -- 'DATA_PUMP_DIR'; --2010-07-12


end if ;






starttime := TO_CHAR(SYSDATE, 'YYYY/mm/dd HH:MI:SS') ;
/* DBMS_OUTPUT.PUT_LINE('vchprodSchema = ' || vchprodSchema);
  DBMS_OUTPUT.PUT_LINE('pschemato = ' || pschemato);
    DBMS_OUTPUT.PUT_LINE('vchtablespacefrom1 = ' || vchtablespacefrom1);
     DBMS_OUTPUT.PUT_LINE('vchtablespaceTo1 = ' || vchtablespaceTo1);
       DBMS_OUTPUT.PUT_LINE('vchDUMPFilename = ' || vchDUMPFilename);
           DBMS_OUTPUT.PUT_LINE('ldumpdirname = ' || ldumpdirname);

*/
Copyschema
(
   vchprodSchema  ,   -- CLINPP1
   upper(pschemato )       , -- CLINPD1
   vchtablespacefrom1 ,
   vchtablespaceTo1   ,
   vchDUMPFilename  , ldumpdirname   );

 DBMS_OUTPUT.PUT_LINE('---------|  Refresh started at '|| starttime ||'  Completed @' || to_char(sysdate, 'YYYY/mm/dd HH:MI:SS') || ' |---------------------' );



UTL_RECOMP.recomp_serial(pschemato);
 DBMS_OUTPUT.PUT_LINE('---------| Completed compiling invalid objects ' || to_char(sysdate, 'YYYY/mm/dd HH:MI:SS') || ' |---------------------' );

--GEO--C-- 2010-05-05 Gather statistics


 DBMS_STATS.gather_schema_stats (ownname => pschemato,cascade =>true,estimate_percent=>dbms_stats.auto_sample_size,options =>'GATHER AUTO',granularity=>'ALL',
             degree => 8 ) ;

DBMS_OUTPUT.PUT_LINE('---------| Completed gathering  statistics ' || to_char(sysdate, 'YYYY/mm/dd HH:MI:SS') || ' |---------------------' );


-- EXECUTE IMMEDIATE ('Drop directory '||ldumpdirname || ' as '|| ldumpfile);
 if (instr(pdumpfile , '/') >0)  then
   select DIRECTORY_NAME  into  ldumpdirname  from DBA_directories where DIRECTORY_NAME = ldumpdirname;

   EXECUTE IMMEDIATE ('Drop directory '||ldumpdirname );
 end if;

EXCEPTION
   WHEN NO_DATA_FOUND THEN
--         RAISE_APPLICATION_ERROR(-20001, ' No Tables are there for ' || UPPER(schema1));
begin
  DBMS_OUTPUT.PUT_LINE( 'Sp_refreshscehma: NO_DATA_FOUND: ' || UPPER(pschemato));

  select vchowner into vchSchemafrom From system.SYSUSERS where VCHSCHEMANAME = pschemato ;
     RAISE_APPLICATION_ERROR(-20001, 'You do not have permission to refresh  objects belonging to ' || UPPER(pschemato) || chr(10)||' created by ' || UPPER(vchSchemafrom));
  exception
       WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20001, 'Invalid user id:-> ' || UPPER(pschemato) );
--        DBMS_OUTPUT.PUT_LINE( 'Invalid user or you donot have permission to refresh  objects belonging to ' || UPPER(pschemato));
end;

   WHEN OTHERS THEN
     -- Consider logging the error and then re-raise
    err_msg := SUBSTR(SQLERRM, 1, 500)|| CHR(10)||DBMS_UTILITY.format_error_backtrace();

raise;


END;