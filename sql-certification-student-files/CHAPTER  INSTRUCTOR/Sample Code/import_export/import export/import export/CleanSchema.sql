create or replace 
procedure         CleanSchema(Username varchar)  is
    err_msg varchar(2000):='';
    current_login varchar(75):=user;
    lVCHOWNER varchar(100):='raghav';
    lcount int:=0;
    user_connected   EXCEPTION;
    lusrename varchar(100):=Username;


begin

--EXECUTE IMMEDIATE ('ALTER SESSION ENABLE PARALLEL DML');


 DBMS_OUTPUT.ENABLE(10000000);
-- select VCHOWNER into lVCHOWNER from system.SYSUSERS where VCHOWNER = user and vchSchemaname = upper(Username);
select nvl(COUNT(*),0) into lcount From v_$session where username = upper(lusrename);


DBMS_OUTPUT.PUT_LINE('vchGRANTED_ROLE ' || lVCHOWNER);

  FOR c IN (SELECT 'DROP TABLE '|| OWNER ||'."' || TABLE_NAME||'" CASCADE CONSTRAINTS purge ' as col1 FROM DBA_TABLES  where owner = upper(Username) and OWNER ||'."' || TABLE_NAME not like '%$%' )LOOP
     DBMS_OUTPUT.PUT_LINE(c.col1);
    EXECUTE IMMEDIATE c.col1;
     END LOOP;

DBMS_OUTPUT.PUT_LINE('FINished dropping table ' || lVCHOWNER);
  FOR c IN (SELECT 'DROP '  || OBJECT_TYPE ||' '|| OWNER ||'."' || OBJECT_NAME||'"  ' as col1 FROM DBA_objects  where owner = upper(Username) AND OBJECT_TYPE !='JOB' )LOOP
     DBMS_OUTPUT.PUT_LINE(c.col1);
   EXECUTE IMMEDIATE c.col1;
   END LOOP;

/*

DBMS_OUTPUT.PUT_LINE('FINished dropping table ' || lVCHOWNER);
  FOR c IN (SELECT 'EXEC DBMS_SCHEDULER.DROP_JOB ( '''  || OWNER ||'.' || OBJECT_NAME||''' ) ' as col1 FROM DBA_objects  where owner = upper(Username) AND OBJECT_TYPE='JOB' )LOOP
     DBMS_OUTPUT.PUT_LINE(c.col1);
   execute IMMEDIATE c.col1;
   END LOOP;

*/
EXCEPTION
   WHEN NO_DATA_FOUND THEN
--         RAISE_APPLICATION_ERROR(-20001, ' No Tables are there for ' || UPPER(schema1));
   DBMS_OUTPUT.PUT_LINE( 'NO_DATA_FOUND ' || UPPER(Username));

begin
  DBMS_OUTPUT.PUT_LINE( ' RAGHAV -->' || UPPER(Username));
--     select VCHOWNER into lVCHOWNER from system.SYSUSERS where vchSchemaname = upper(Username);
  RAISE_APPLICATION_ERROR(-20001, ' Do not have permission to delete objects belonging to ' || UPPER(Username));
  exception
       WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE( 'Invalid user or you donot have permission to delete objects belonging to ' || UPPER(Username));
end;

--GEO--
   when  user_connected then
       DBMS_OUTPUT.PUT_LINE('Cannot drop a user which is already connected ');
     RAISE_APPLICATION_ERROR(-20001, ' Cannot drop a user which is already connected -->'  || UPPER(Username));
  RAISE;

--GEO--

   WHEN OTHERS THEN
     -- Consider logging the error and then re-raise
    err_msg := SUBSTR(SQLERRM, 1, 500)|| CHR(10)||DBMS_UTILITY.format_error_backtrace();
    DBMS_OUTPUT.PUT_LINE(err_msg);
    RAISE_APPLICATION_ERROR(-20001, err_msg  || UPPER(Username));





end ;