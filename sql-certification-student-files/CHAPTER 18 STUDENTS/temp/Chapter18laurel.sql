-- =============================================================================
-- Chapter 18 Controlling User Access
-- =============================================================================
-- log in as laurel
-- test object privilege
SELECT * FROM cruises.ships;
SELECT * FROM cruises.ports;
SELECT * FROM daybooks.books;

-- test all privileges on cruises.cruises

-- test select any table privilege

-- test create table privilege


-- laurel owns temp_ships, so he can do this:

/* -----------------------------------------------------------------------------
  test with grant option - page 689
------------------------------------------------------------------------------*/
-- This doesn't work because its an object laurel doesn't own
-- try again after system grants laurel permissions WITH GRANT OPTION

-- This doesn't work because this is a system privilege


/* -----------------------------------------------------------------------------
  test synonyms
------------------------------------------------------------------------------*/
-- do this after testing whether hardy can use psp

/* -----------------------------------------------------------------------------
  test views
------------------------------------------------------------------------------*/

/* -----------------------------------------------------------------------------
  test user privleges - page 692
------------------------------------------------------------------------------*/
-- object privileges
SELECT * FROM user_tab_privs;
SELECT * FROM all_tab_privs WHERE grantee IN ('LAUREL', 'HARDY');
SELECT * FROM all_tab_privs_recd WHERE grantee IN ('LAUREL', 'HARDY');
-- system privileges
-- roles assigned to laurel
