-- =============================================================================
-- Chapter 18 Controlling User Access
-- =============================================================================
-- log in as hardy

-- test laurel's granting of privilege to hardy

/* -----------------------------------------------------------------------------
  test with grant option - p 689
------------------------------------------------------------------------------*/
-- test laurel's grant of cruises

-- have laurel check the change

/* -----------------------------------------------------------------------------
  test synonyms
------------------------------------------------------------------------------*/
-- hardy has access to public synoyms, 
-- but also needs access to what it points to

/* -----------------------------------------------------------------------------
  test views
------------------------------------------------------------------------------*/
-- We don't need the privilege for the underlying table because he has the
-- privilege on the view

/* -----------------------------------------------------------------------------
  test user privleges - page 692
------------------------------------------------------------------------------*/
-- object privileges
SELECT * FROM user_tab_privs;
-- system privileges
SELECT * FROM user_sys_privs;
-- roles assigned to laurel
