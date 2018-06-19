-- =============================================================================
-- Chapter 18 Controlling User Access
-- =============================================================================
/* -----------------------------------------------------------------------------
  System privilege: perform a particular task in the database
  Object privilege: perform a particular task on an object
  Role: a collection of object and/or system privileges
  
  A user account must have the system privilege to create the object, then
  object privileges can be granted to other users
  
  GRANT  keyword for giving a user a distinct privilege
  REVOKE keyword for removing a distinct privilege
  ANY    keyword for giving a specific privilege anywhere in the database
         (use with caution)
------------------------------------------------------------------------------*/
-- log in as system
-- preparation if using older database
DROP USER laurel CASCADE;
-- This creates a user ccount called luarel with the password 'peek'
-- try to connect as laurel
-- allow the user to connect to the database
-- connect as laurel in Chapter18laurel and rerun

-- allow laurel to see the ships table in schema cruises
-- this is an object privilege
-- retest laurel to see ports and other tables

-- would not work unless you were logged in as cruises

-- allow luarel to do anything with cruises.cruises, but not any other table

-- System privileges applied to all accounts uses the keyword ANY

-- remove that privlege from laurel

-- laurel forgot her password

-- create a role and assign it some privileges
-- assign some object privileges
-- assign a system privilege

-- system privilege for just the user's account
-- but the user won't be able to create the table until we give her some tablespace

/* -----------------------------------------------------------------------------
-- test with grant option
-- page 689
------------------------------------------------------------------------------*/

-- Laurel has requested the ability to grant permissions on object she doesn't own

-- -----------------------------------------------------------------------------
-- test synonyms
-- 
-- -----------------------------------------------------------------------------


-- -----------------------------------------------------------------------------
-- test views
-- 
-- -----------------------------------------------------------------------------
-- This is a system privilege, so we use with admin option

/* -----------------------------------------------------------------------------
  test user privleges - page 692
------------------------------------------------------------------------------*/
SELECT * FROM role_tab_privs;

-- object privileges
SELECT * FROM dba_tab_privs WHERE grantee in ('LAUREL','HARDY');
SELECT * FROM all_tab_privs WHERE grantor = 'SYSTEM'
  ORDER BY grantee;
SELECT * FROM all_tab_privs_recd where grantor = 'SYSTEM';

-- system privileges
SELECT * FROM dba_sys_privs WHERE grantee IN ('LAUREL', 'HARDY');
-- roles assigned to laurel
-- defines how the role is created


/* -----------------------------------------------------------------------------
  drop user
------------------------------------------------------------------------------*/
-- This won't work now because laurel owns an object
-- cascade also drops any objects user laurel created
-- This will drop any object laurel owns and any permissions she granted:
-- =============================================================================
-- Bonus material
-- =============================================================================
SELECT owner, table_name
  FROM all_tab_columns
  WHERE owner IN ('LAUREL', 'HARDY');

grant create table to laurel with admin option;
GRANT SELECT ANY TABLE TO PUBLIC;
REVOKE SELECT ANY TABLE FROM PUBLIC;

-- ============================================================================
-- EXERCISES
-- ============================================================================
/*
1. create users mark and zooie
2. assign login privileges to both
3. grant unlimited tablespace to both
4. create sql-developer connections for both
5. grant create table to mark
6. drop mark and zooie
*/
