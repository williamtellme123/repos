-- =============================================================================
--  CHAPTER 6
/*
      Single Row Functions
        Character, Number, and Date
        Conversion
        Time Zones—Datetime Functions
       
*/
-- -----------------------------------------------------------------------------
--  DATE TYPE CONVERSION
-- -----------------------------------------------------------------------------
--    TO_NUMBER
--    TO_CHAR (character)
--    TO_CHAR (Number)
--    TO_CHAR (Date)
--    TO_DATE
--    TO_TIMESTAMP
--    TO_DSINTERVAL
--    TO_YMINTERVAL

--    1.      
      select * from some_numbers_stg; 
      select to_number('3456') from dual;
      select to_number(monthly_sales, '$999,999.99') from some_numbers_stg; 
      
      -- ETL
      insert into some_numbers_final
      (
        monthly_sales
      )
      select 
          to_number(monthly_sales, '$999,999.99') 
      from some_numbers_stg; 

--    2. 
      -- transforms nchar, mnchar2 (unicode) into varchar2 
      select to_char(firstname), to_char(lastname) from books.customers;
      select to_char(456877878.88, '$999,999,999.99') from dual;
      select to_char(sysdate, 'dd-MON-yyyy hh:mi:ss') from dual;

--    3.      
      select to_date('4/17/2016 10:31:23 PM', 'mm/dd/yyyy hh:mi:ss PM') from dual;

--    4. converts char, varchar2, nchar, or nvarchar2 datatype to an interval day to second type.
      select emp_name, hiredate 
          ,case
            when hiredate + to_yminterval('10-00') <= sysdate
                then 'Greater than Ten years'   
            when hiredate + to_yminterval('05-00') <= sysdate
                then 'Greater than Five years'   
            when hiredate + to_yminterval('03-00') <= sysdate
                then 'Greater than Three years'      
            when hiredate + to_yminterval('01-06') <= sysdate
                then 'Greater than 18 Months'                
            when hiredate + to_yminterval('01-00') <= sysdate
                then 'Greater than one year'
            when hiredate + to_yminterval('00-06') <= sysdate
                then 'Greater than 6 Months'    
                else 'Less than 6 Months'
            end as tenure
      from some_hiredates_stg
      order by 2;

--    5.  
      select to_timestamp('4/17/2016 13:31:23.55', 'mm/dd/yyyy hh24:mi:ss.ff') from dual;
      
-- -----------------------------------------------------------------------------
--    DATE/TIME data types
-- -----------------------------------------------------------------------------
--    DBTIMEZONE
--    SESSIONTIMEZONE
--    CURRENT_DATE
--    CURRENT_TIMESTAMP
--    LOCALTIMESTAMP
--    SYSTIMESTAMP
--    NEW_TIME

--    6. What are our current timezone settings
      select dbtimezone       -- database tz
           , sessiontimezone  -- client tz
      from dual;

--    7. What are all the timezones
      select * 
      from v$timezone_names;

--    8. What are the American timezones
        select * 
        from v$timezone_names
        where tzname like 'America%';

--    NLS_DATE_FORMAT: default date format to use with the TO_CHAR and TO_DATE functions
--    NLS_TIMESTAMP_FORMAT: default timestamp format used with TO_CHAR and TO_TIMESTAMP functions
--    NLS_TIMESTAMP_TZ_FORMAT: default timestamp with time zone format used with TO_CHAR and TO_TIMESTAMP_TZ functions
--    
--    select * from NLS_DATABASE_PARAMETERS; 	-- Permanent NLS parameters of the database
--    select * from NLS_INSTANCE_PARAMETERS; 	-- NLS parameters of the instance (modified by init.ora)
--    select * from NLS_SESSION_PARAMETERS;	-- NLS parameters of the user session (modified by user)

--    9. DATE TIME SETTINGS
      select *
      from NLS_SESSION_PARAMETERS
      --from NLS_DATABASE_PARAMETERS
      where lower(parameter) like '%time%'
         or lower(parameter) like '%date%';    

--    10. DATE TIME SETTINGS      
      select dbtimezone                 -- database offset
           , sessiontimezone            -- session tz
           , tz_offset(sessiontimezone) -- session offset
      from dual;
        
--    11. 
      select 
                to_char(sysdate, 'dd-MON-yyyy hh:mi:ss') a
              , to_char(current_date, 'dd-MON-yyyy hh:mi:ss') b
              , to_char(current_timestamp, 'dd-MON-yyyy hh:mi:ss.ff') c
              , to_char(localtimestamp, 'dd-MON-yyyy hh:mi:ss.ff') d
              , to_char(systimestamp, 'dd-MON-yyyy hh:mi:ss.ff') e
      from dual;
        
--    12. 
      select 
                to_char(sysdate, 'dd-MON-yyyy hh:mi:ss')
              , to_char(current_date, 'dd-MON-yyyy hh:mi:ss')
      from dual;
        
--    13.
      select to_char(sysdate, 'dd-MON-yyyy hh:mi:ss'), to_char(new_time(sysdate, 'CDT', 'HST'),'dd-MON-yyyy hh:mi:ss') from dual;  
-- =============================================================================
--  TIMEZONES
--  UTC time, is universal standard time aka Greenwich Mean Time
--  Database time zone, of the server (DBTIMEZONE)
--  Session time zone, of the user (SESSIONTIMEZONE)
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


-- -----------------------------------------------------------------------------
-- SOME EXAMPLES OF TIME IN OTHER COUNTRIES
-- Country 	      Date Format 	Example 	  Time Format 	    Example
-- -----------------------------------------------------------------------------
--  China 	        yyyy-mm-dd 	  2005-02-28 	hh24:mi:ss 	      13:50:23
--  Estonia 	      dd.mm.yyyy 	  28.02.2005 	hh24:mi:ss 	      13:50:23
--  Germany 	      dd.mm.rr 	    28.02.05 	  hh24:mi:ss 	      13:50:23
--  UK 	            dd/mm/yyyy 	  28/02/2005 	hh24:mi:ss 	      13:50:23
--  U.S. 	          mm/dd/yyyy 	  02/28/2005 	hh:mi:ssxff am 	  1:50:23.555 PM
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
*/
-- -----------------------------------------------------------------------------
--   TIMEZONE CONVERSION
-- -----------------------------------------------------------------------------
--    FROM_TZ         converts a TIMESTAMP value (given a TIME ZONE) to a TIMESTAMP WITH TIME ZONE value.
--    TO_TIMESTAMP_TZ
--    CAST
--    EXTRACT
--    SYS_EXTRACT_UTC

    select from_tz( timestamp '2012-10-12 07:45:30', '+07:30')
    from dual;

    select to_timestamp_tz('17-04-2013 16:45:30','dd-mm-rrrr  hh24:mi:ss') "time"
    from dual;

    select to_timestamp_tz('17-04-2013 16:45:30','dd-mm-rrrr hh24:mi:ss') "time"
    from dual;

-- -----------------------------------------------------------------------------
--   TIMEZONE CONVERSION
-- -----------------------------------------------------------------------------
--    FROM_TZ         converts a TIMESTAMP value (given a TIME ZONE) to a TIMESTAMP WITH TIME ZONE value.
--    TO_TIMESTAMP_TZ
--    CAST
--    EXTRACT
--    SYS_EXTRACT_UTC

    select from_tz( timestamp '2012-10-12 07:45:30', '+07:30')
    from dual;

    select to_timestamp_tz('17-04-2013 16:45:30','dd-mm-rrrr  hh24:mi:ss') "time"
    from dual;


--  Extracts value: YEAR, MONTH, DAY, HOUR, MINUTE, SECOND
    select extract(minute from to_timestamp('2009-10-11 12:13:14', 'rrrr-mm-dd hh24:mi:ss')) "minute"
    from dual;

    select extract(hour from to_timestamp('2009-10-11 12:13:14', 'rrrr-mm-dd hh24:mi:ss')) "minute"
    from dual;

    select extract(day from to_timestamp('2009-10-11 12:13:14', 'rrrr-mm-dd hh24:mi:ss')) "minute"
    from dual;
    
--  Extracts the UTC from a datetime value
    select sys_extract_utc(timestamp '2012-03-25 09:55:00 -04:00') "hq" 
    from dual;
    
--   Converts the source data into the local time equivalent
    select from_tz(cast(to_date('1999-12-01 11:00:00','rrrr-mm-dd hh:mi:ss') as timestamp), 'America/Los_Angeles') at local "east coast time"
    from dual; 
    

--    TIMESTAMP WITH TIME ZONE as follows: data stored in the database is normalized to the database time zone, and the time zone offset is not stored as part of the column data. When users retrieve the data, Oracle returns it in the users' local session time zone. The time zone offset is the difference (in hours and minutes) between local time and UTC (Coordinated Universal Time, formerly Greenwich Mean Time).
--    Stored with time zone offset
--    Users retrieve data in time zone entered in insert statement

--    TIMESTAMP WITH LOCAL TIME ZONE
--    data set to db time zone
--    offset not stored
--    Users retrieve data in users local session time zone

     select dbtimezone                 -- database offset
           , sessiontimezone            -- session tz
           , tz_offset(sessiontimezone) -- session offset
      from dual;

-- Question 14
    drop table email_response;
    create table email_response
    ( email_response_id number,
      email_sent timestamp with local time zone,      -- user sees in their session timezone
      email_received timestamp with time zone);       -- user sees in timezone as entered

    alter session set time_zone = 'America/Los_Angeles';
    insert into email_response values (
            1
            , to_timestamp('01-DEC-11 02:00:00.000000000', 'DD-MON-RR HH:MI:SS.FF')
            , to_timestamp('01-DEC-11 02:05:00.000000000', 'DD-MON-RR HH:MI:SS.FF')
    );
    select email_sent, email_received from email_response;
    alter session set time_zone = 'America/Chicago';
    select email_sent, email_received from email_response;