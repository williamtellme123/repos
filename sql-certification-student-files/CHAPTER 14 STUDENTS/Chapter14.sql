-- =============================================================================
-- Chapter 14 Managing Objects with Data Dictionary Views
-- =============================================================================
/* -----------------------------------------------------------------------------
  Structure - pp 536-8
    user_ objects OWNED by the current user
    all_  objects visible to the current user
    dba_  all objects in the database
------------------------------------------------------------------------------*/
-- log in as cruises
DESC user_tables;

DESC all_tables;


-- use system

/* -----------------------------------------------------------------------------
  Columns - p 545
------------------------------------------------------------------------------*/
-- log in as system
  
-- log in as cruises


/* -----------------------------------------------------------------------------
  Constraints p 547
------------------------------------------------------------------------------*/
-- log in as cruises


-- To link columns to constraints

/* -----------------------------------------------------------------------------
  Views, Synonyms, Indexes
------------------------------------------------------------------------------*/

-- USER_ data dictionary views:


/* -----------------------------------------------------------------------------
  Data Dictionary Views: How to use the data dictionary - pp 542-9
    1. Start by looking in DICTIONARY
    2. Use the USER_CATALOG and USER_OBJECTS
    3. Use all the USER_ dictionary views already covered
  The underlying tables in the data dictionary are owned by SYS
------------------------------------------------------------------------------*/
DESC DICTIONARY;
SELECT * FROM DICTIONARY ORDER BY table_name;

-- page 543

-- USER_CATALOG
-- All tables, views, synonyms, sequences

-- quick overview of what a user account may own:
  
/* -----------------------------------------------------------------------------
  Dynamic performance views - pp 538-542
  Table prefixes 
    V_$  A View that stores information about local database instance
    V$   A public synonym for the corresponding view 
    GV_$ A global dynamic performance view
    GV$  A public synonym for the corresponding view
------------------------------------------------------------------------------*/
-- log in as system
-- Information about the database itself
-- Instance, host, startup time
-- Current settings for system parameters

-- Current settings for each individual user session

-- Current list of reserved words
  
-- Monitoring the usage of index objects

-- Timezone names and abbreviations

-- Information on the database
SELECT * FROM v$version;
SELECT * FROM product_component_version;

/* -----------------------------------------------------------------------------
  Comments - pp 540-541
------------------------------------------------------------------------------*/
-- use cruises
-- Comments on tables:

-- To remove a comment

-- Comments on columns
  

-- Type in query from p 540 to find information on a system table:

/* -----------------------------------------------------------------------------
  Compiling views - p 546 
------------------------------------------------------------------------------*/
SELECT * FROM user_views;

-- Use a subquery in the CREATE statement

-- Query to test our view
SELECT status, object_type, object_name FROM user_objects
  WHERE object_name LIKE '%PORTS%';


-- from page 391

/* -----------------------------------------------------------------------------
  Checking privileges - p 547
------------------------------------------------------------------------------*/
-- System privileges granted to the current user
-- Object privileges granted to the current user
-- Roles granted to current user
-- Session privileges which the user currently has set

-- log in as system:

-- =============================================================================
-- Bonus material
-- =============================================================================
-- QUESTIONS
--Q 4:
SELECT count(*) FROM dba_sys_privs;

SELECT '*TABLE: ' || table_name, comments
FROM all_tab_comments WHERE owner = 'SYS'
AND table_name = 'USER_SYNONYMS'
UNION
SELECT 'COL: ' || column_name, comments
FROM all_col_comments WHERE owner = 'SYS'
AND table_name = 'USER_SYNONYMS';

-- =============================================================================
-- EXERCISES
-- =============================================================================
