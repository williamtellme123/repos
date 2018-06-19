-- =============================================================================
-- CHAPTER 6 
-- INTERVAL, DATE, TIMESTAMP, TIMEZONE
-- =======================================================================
/*
  INTERVAL refers to a duration of time 
  
  Interval data types store time durations 
  Used primarily with analytic functions 
  Examples 
    Calculate a moving average of stock prices 
    Determine values that correspond to a particular percentile 
    Use to update historical tables
  
  YEAR_TO_MONTH stores time period as interval of years to the nearest month, 
    Uses hyphen (-) between the YEAR and MONTH

  DAY_TO_SECOND stores it as interval of days to the nearest second.
    Uses space between the number of days and the time. 
*/

-- =============================================================================
--  DATE/TIME data types
-- =============================================================================
-- -----------------------------------------------------------------------------
--   DATE 
--   TIMESTAMP
--   TIMESTAMP WITH TIME ZONE
--   TIMESTAMP WITH LOCAL TIME ZONE
-- -----------------------------------------------------------------------------
create table mytemp
(mydate   date,
 mytimestamp timestamp);
insert into mytemp values (sysdate, systimestamp);
-- -----------------------------------------------------------------------------
--   DATE
-- -----------------------------------------------------------------------------
--  Century, year, month, date, hour, minute, and secon
select to_char(mydate,'CC  DD/MM/YY HH:MI:SS AM') from mytemp;  
-- -----------------------------------------------------------------------------
--  TIMESTAMP Data Type 
-- -----------------------------------------------------------------------------

select to_char(mytimestamp,'CC  DD/MM/YY HH:MI:SS:FF AM') from mytemp;  
--   TIMESTAMP WITH TIME ZONE
--   TIMESTAMP WITH LOCAL TIME ZONE

-- =============================================================================
-- TIMEZONES
-- UTC time, is universal standard time aka Greenwich Mean Time
-- Database time zone, of the server (DBTIMEZONE)
-- Session time zone, of the user (SESSIONTIMEZONE)
/* 
    A time zone is an offset from the time in Greenwich, England.
    The time in Greenwich was once known as Greenwich Mean Time (GMT).
    It is now known as Coordinated Universal Time.
    You specify a time zone using either an offset from UTC or the name of the region.
    When you specify an offset, you use HH:MI prefixed with a plus or minus sign:
    
    +|-HH:MI
    
    where
    + or - indicates an increase or decrease for the offset from UTC.
    HH:MI indicates the time zone hour and minute for the offset.

    You may also specify a time zone using the name of a region.
    For example, PST indicates Pacific Standard Time, which is seven hours behind UTC.
    EST indicates Eastern Standard Time, which is four hours behind UTC.

    NOTE: 
    Oracle performs all timestamp arithmetic in UTC time. 
    For TIMESTAMP WITH LOCAL TIME ZONE data, Oracle converts datetime value from the database 
    time zone to UTC then converts it to database time zone after performing arithmetic. 
    For TIMESTAMP WITH TIME ZONE data, the datetime value is always in UTC, 
    so no conversion is necessary.

*/
-- What are our current timezone settings
select dbtimezone
     , sessiontimezone
from dual;

-- What are all the timezones
select * 
from v$timezone_names;

-- What are the American timezones
select * 
from v$timezone_names
where tzabbrev = 'MST';

-- -----------------------------------------------------------------------------
-- SOME EXAMPLES OF TIME IN OTHER COUNTRIES
-- Country 	      Date Format 	Example 	  Time Format 	    Example
-- -----------------------------------------------------------------------------
--  China 	        yyyy-mm-dd 	  2005-02-28 	hh24:mi:ss 	      13:50:23
--  Estonia 	      dd.mm.yyyy 	  28.02.2005 	hh24:mi:ss 	      13:50:23
--  Germany 	      dd.mm.rr 	    28.02.05 	  hh24:mi:ss 	      13:50:23
--  UK 	            dd/mm/yyyy 	  28/02/2005 	hh24:mi:ss 	      13:50:23
--  U.S. 	          mm/dd/yyyy 	  02/28/2005 	hh:mi:ssxff am 	  1:50:23.555 PM


-- -----------------------------------------------------------------------------
-- WHAT ARE THE PARAMETERS THAT IMPACT US
-- 
-- NLS_DATE_FORMAT: default date format to use with the TO_CHAR and TO_DATE functions
-- NLS_TIMESTAMP_FORMAT: default timestamp format used with TO_CHAR and TO_TIMESTAMP functions
-- NLS_TIMESTAMP_TZ_FORMAT: default timestamp with time zone format used with TO_CHAR and TO_TIMESTAMP_TZ functions

-- select * from NLS_DATABASE_PARAMETERS; 	-- Permanent NLS parameters of the database
-- select * from NLS_INSTANCE_PARAMETERS; 	-- NLS parameters of the instance (modified by init.ora)
-- select * from NLS_SESSION_PARAMETERS;	-- NLS parameters of the user session (modified by user)
-- DATE TIME PARAMETERS
select *
from NLS_SESSION_PARAMETERS
--from NLS_DATABASE_PARAMETERS
where lower(parameter) like '%time%'
   or lower(parameter) like '%date%';    

select dbtimezone
     , sessiontimezone
     , tz_offset(sessiontimezone)
from dual;

-- =============================================================================
--   WHICH Data Type should we use?
-- =============================================================================
/*
-- -----------------------------------------------------------------------------
DATE          
    When fractions of seconds or timezones are not required
    Common examples might be Date of birth, date hired, arrival date 
-- -----------------------------------------------------------------------------
TIMESTAMP     
    More precise point in time (includes fractions of seconds but not time zone) 
    Examples: start time of race, incubation end time  
-- -----------------------------------------------------------------------------
--  TIMEZONES IN GENERAL 
    When production and consumption of data spans timezones
    Entered in New York, read in Tokyo
-- -----------------------------------------------------------------------------
TIMESTAMP WITH TIME ZONE
    Extends TIMESTAMP to store timestamp in the local time zone
    When you insert timestamp into a TIMESTAMP WITH LOCAL TIME ZONE column, 
    the value is converted-or normalized-to the time zone set for the database
    Later you retrieve the timestamp, it is normalized to the time zone set for your session
    
    Uses:
    When value represents a future local time 
    A scheduled event/appointment for next week in another city/country 
    The future local time may need to be adjusted if the time zone 
    definition, such as daylight saving rule, changes. Otherwise, 
    the value can become incorrect. This data type is most immune to such impact.
  
    TZ is stored as region name or offset from UTC 
    Available for display or calculations without additional processing 
    Cannot be used as a primary key
    
    Advanced technical reasons suggest not to use this type in real life
    
-- -----------------------------------------------------------------------------              
TIMESTAMP WITH LOCAL TIME ZONE 
    Stores timestamp without time zone information 
    It normalizes value to database TZ every time data is accessed
  
    Use when original TZ not important but relative times are
    Because this data type does not preserve TZ, 
    it does not distinguish values near the adjustment calendar dates 
    whether daylight savings or standard time 
    This confusion between distinct instants can cause an application 
    to behave unexpectedly, especially if the adjustment takes place 
    during the normal working hours of a user

    Note: some regions (Brazil, Israel) update Daylight Saving Transition dates frequently 
    at irregular periods, are particularly susceptible to time zone adjustment issues. 
    If time information from these regions is key to your application, you may want to consider using one of the other datetime types.

-- =============================================================================
           
SUMMARY 
    TIMESTAMP WITH TIME ZONE 
        Stores and displays the explicit time supplied from the INSERT statement
    
    TIMESTAMP WITH LOCAL TIME ZONE 
        stores explicit time supplied BUT displays value relative to current session TZ
-- =============================================================================
*/


select CURRENT_TIMESTAMP, LOCALTIMESTAMP FROM DUAL;
select * from v$timezone_names;


-- USING the timestamp data types
drop table mytz;
create table mytz
(myTSTZ   TIMESTAMP WITH TIME ZONE,
 myTSLTZ  TIMESTAMP WITH LOCAL TIME ZONE);

-- confirm 
select dbtimezone,sessiontimezone, tz_offset(sessiontimezone) from dual;
-- Alter if necessary
-- alter session set time_zone='-3:00'; 
-- alter session set time_zone='America/Chicago'; 
-- alter session set time_zone='Asia/Hong_Kong';

select * from mytz;
commit;

select dbtimezone,sessiontimezone, tz_offset(sessiontimezone) from dual;
--alter session set time_zone='-3:00'; 
--alter session set time_zone='America/Chicago'; 
alter session set time_zone='Asia/Hong_Kong';
select dbtimezone,sessiontimezone, tz_offset(sessiontimezone) from dual;

select current_timestamp,systimestamp, localtimestamp from dual;
SELECT sys_extract_utc(systimestamp) from dual;
select 
       tz_offset('us/michigan')
     , tz_offset('-08:00')
     , tz_offset(sessiontimezone)
     , tz_offset(dbtimezone)
from dual;


select sys_extract_utc(systimestamp), tz_offset('America/Chicago') Chigaco ,tz_offset('Asia/Hong_Kong') HongKong from dual;
--  TIMESTAMP WITH TIME ZONE 
--       Stores and displays the explicit time supplied from the INSERT statement
--  TIMESTAMP WITH LOCAL TIME ZONE 
--      stores explicit time supplied BUT displays value relative to current session TZ
select * from mytz;

select  sys_extract_utc(systimestamp) utc
      , myTSTZ  actual_sub_5
      , myTSLTZ  localInHongKong_add_8
from mytz;
