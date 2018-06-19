--    http://yetanotheroracledbablog.blogspot.com/2015/05/installing-apex-v5-into-12c-pluggable.html 

-- If you run apexremov_con.sql after PDBs have been added to the CDB 
-- then Application Express uninstalls from all of the PDBs. 

-- You can clone a pdb
--          alter pluggable database ANDYPDB close immediate;
--          alter pluggable database ANDYPDB open read only;
--          create pluggable database APEXV5 from ANDYPDB file_name_convert=(‘D:\oradata\ANDYPDB\’,’D:\oradata\APEXV5/’);
--          alter pluggable database ANDYPDB close immediate;
--          alter pluggable database ANDYPDB open read write;
--          alter pluggable database APEXV5 open read write;
--
-- Or create one from pdbseed 
--          create pluggable database apexv5
--          admin user apexv5 identified by password
--          roles (dba)
--          default tablespace apexv5
--          datafile 'D:\oradata\apexv5\apexv5_01.dbf' size 100m autoextend on
--          file_name_convert = ('D:\oradata\orcl\pdbseed\','D:\oradata\apexv5\') storage (maxsize 2G) 
--          path_prefix = 'D:\oradata\apexv5\';
-- 
-- Backup database
--          Do a shutdown immediate, then do RMAN to backup to disk
--          rman target /
--          startup mount
--          backup database;
--
-- Confirm pdborcl is open
          select * from dba_pdb_saved_states;
--
-- Check current installations
      select comp_id, version, status 
      from cdb_registry where comp_id='APEX' order by con_id;
      
      select r.comp_name, r.version, c.name, c.con_id 
      from cdb_registry r, v$containers c 
        where r.con_id=c.con_id and r.comp_id='APEX' order by con_id;
      select comp_name, version, status from dba_registry where comp_name ='Oracle Application Express';
--
-- Deinstall Apex from everywhere
--    c:\app\Billy\product\12.1.0\dbhome_2\apex\sqlplus / as sysdba
      SQL>@apxremov.sql;
--
-- Confirm deinstallation
      select r.comp_name, r.version, c.name, c.con_id 
      from cdb_registry r, v$containers c 
        where r.con_id=c.con_id and r.comp_id='APEX' order by con_id;
--
-- Install into pdborcl        
--    c:\app\Billy\product\12.1.0\dbhome_2\apex\sqlplus / as sysdba 
      SQL> alter session set container=pdborcl;
      --      alter session set current_schema = SYS;

      SQL> @apexins sysaux sysaux temp /i/;  -- this takes time
      -- FAILURE no tablespace, must create
--            create smallfile tablespace users datafile 
--            'd:\oradata\apexv5\users_01.dbf' 
--            size 100m autoextend on next 100m 
--            logging default nocompress 
--            online extent management 
--            local autoallocate 
--            segment space management auto;
--
      -- FAILURE
--        ERROR at line 1:
--        ORA-04045: errors during recompilation/revalidation of APEX_050000.WWV_FLOW_AUTHENTICATION_DEV
--        ORA-65047: object SYS.WWV_FLOW_VAL is invalid or compiled with errors in
--        CDB$ROOT
--        ORA-06508: PL/SQL: could not find program unit being called:
--        "APEX_050000.WWV_FLOW_AUTHENTICATION_DEV"
--        ORA-06512: at line 2
--
--        Remove directory uninstall again
c:\app\Billy\product\12.1.0\dbhome_2\apex_5.0.4\apex\sqlplus / as sysdba 
     
-- Check installation
      select comp_id, version, status 
      from cdb_registry where comp_id='APEX' order by con_id;
      
      select r.comp_name, r.version, c.name, c.con_id 
      from cdb_registry r, v$containers c 
        where r.con_id=c.con_id and r.comp_id='APEX' order by con_id;
      select comp_name, version, status from dba_registry where comp_name ='Oracle Application Express';
--
-- Run apxchpwd to set the ADMIN password
-- Make complex, prepare to change as you login to web page

-- Install: OHS, Apex REST, EPG (EPG for speed)
--    c:\app\Billy\product\12.1.0\dbhome_2\apex\sqlplus / as sysdba
      SQL> alter session set container=pdborcl;
      SQL> @apxconf