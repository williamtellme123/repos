-- =============================================================================
--  CHAPTER 6
/*
      Single Row Functions
        Character, Number, and Date
        Conversion
        Time Zones—Datetime Functions
       
*/
-- -----------------------------------------------------------------------------
-- NUMBER FUNCTIONS
-- -----------------------------------------------------------------------------
--    ROUND-number
--    TRUNC-number
--    FLOOR
--    CEILING
--    REMAINDER
--    MOD

--    1.
      select * from some_numbers;

--    2.      
      select
              onevalue
            , round(onevalue, 1) as r1
            , round(onevalue, 2) as r2
            , ceil(onevalue)
--            , round(onevalue,-1) as rminus1
--            , round(onevalue, 0)  as rzero
--            , trunc(onevalue, 1) as t1
--            , trunc(onevalue,-1) as tminus1
--            , trunc(onevalue, 0) as tzero
     from some_numbers;    ;  
 
--    3.  Find closest multiple of n2 to n1, return n1 - multiple
      select * from some_numbers_for_remainder;
      select
            'page 224'
          , original_value as ov
          , remainder(original_value,3) as rthree
          -- below is an attempt to unsderstand
          -- how remainder works
          , abs(original_value-3*3) as ovminus3times3
          , abs(original_value-3*4) as ovminus3times4
      from some_numbers_for_remainder;
      
      
--    4.   
            select floor(123.456) from dual;
            select ceil(123.00000001) from dual;

--    5.   
        select 
               'page 224'
              , original_value
              , mod(original_value,3)
              , case 
                    when mod(original_value,2) = 0
                         then 'I am an even number'
                         else 'I am odd'
                    end      
        from some_numbers_for_mod;            
        
--     6. 
--        select 
             -- see #5 above
--        from some_numbers_for_even_mod;            


-- -----------------------------------------------------------------------------
--  DATE FUNCTIONS
-- -----------------------------------------------------------------------------
--    SYSDATE
--    ROUND-date
--    TRUNC-date
--    NEXT_DAY
--    LAST_DAY
--    ADD_MONTHS
--    MONTHS_BETWEEN
--    NUMTOYMINTERVAL
--    NUMTODSINTERVAL

--    7. 
      select sysdate from dual;

--    8.
      select * from some_dates;
      select 
               to_char(startdate,'dd-MON-yy hh:mi:ss')
             , to_char(enddate, 'dd-MON,yy hh:mi:ss') 
      from some_dates;
--    9.      
      select  
      --  to_char just to see what is actually in a date field
              to_char(startdate, 'mm/dd/yyyy hh:mi:ss AM') a
            , to_char(enddate, 'mm/dd/yyyy hh:mi:ss AM') b

      --   use to_char see dd round and trunc results
            , to_char(round(startdate,'dd'),'mm/dd/yyyy hh:mi:ss') c 
            , to_char(round(enddate,'dd'),'mm/dd/yyyy hh:mi:ss') d
            , to_char(trunc(startdate,'dd'),'mm/dd/yyyy hh:mi:ss') e 
            , to_char(trunc(enddate,'dd'),'mm/dd/yyyy hh:mi:ss') f
      from some_dates;           
      
      select
             to_char(startdate, 'mm/dd/yyyy hh:mi:ss AM') a
            , to_char(enddate, 'mm/dd/yyyy hh:mi:ss AM') b
            , to_char(round(startdate,'yy'),'mm/dd/yyyy hh:mi:ss') c 
            , to_char(round(enddate,'yy'),'mm/dd/yyyy hh:mi:ss') d
            , to_char(trunc(startdate,'yy'),'mm/dd/yyyy hh:mi:ss') e 
            , to_char(trunc(enddate,'yy'),'mm/dd/yyyy hh:mi:ss') f
      from some_dates;  
      
      
      select   
              to_char(round(to_date('6-30-15', 'mm-dd-yy'),'yy'),'mm/dd/yy hh:mi:ss') a
            , to_char(round(to_date('7-1-15', 'mm-dd-yy'),'yy'),'mm/dd/yy hh:mi:ss') b
            , to_char(round(to_date('6-30-16', 'mm-dd-yy'),'yy'),'mm/dd/yy hh:mi:ss') c
            , to_char(round(to_date('7-1-16', 'mm-dd-yy'),'yy'),'mm/dd/yy hh:mi:ss') d
      from dual;  
 
      select   
                 startdate
               , enddate
               , next_day(startdate,'Saturday')
               , last_day(startdate)
               , add_months(startdate, 3) 
      from some_dates;
      
      
--    10. 
      select startdate, enddate, enddate - startdate
      from some_intervals;
      
      select * from some_intervals;
      desc some_intervals;

--    Interval of 123 years 0 months
      insert into some_intervals (span) values ( interval '123' year(3)); 	
      select * from some_intervals;
--    Interval of 123 years, 2 months. Must specify precision if greater than default 2
      insert into some_intervals (span) values (interval '123-2' year(3) to month);

--    Interval of 300 months
      insert into some_intervals (span) values (interval '300' month);
      select * from some_intervals;
      
--    INTERVAL '4-0' YEAR TO MONTH and indicates 4 years.
insert into some_intervals (span) values (interval '4' year);
select * from some_intervals;
      
--    INTERVAL '4-2' YEAR TO MONTH and indicates 50 months or 4 years 2 months.
      insert into some_intervals (span) values (interval '4-2' year to month);      
--    Returns an error, because the default precision is 2, and '123' has 3 digits.
      insert into some_intervals (span) values (interval '123' year(3));      
--    Interval of 123 years, 2 months. Must specify precision if greater than default 2
      
--    Interval 3 years 11 months  
      
--    Interval 1 year 5 months
      
--    Interval 0 years 1 month   
      
      select contractsartdate, contractenddate from other_intervals;
    
--    Typically do not insert durations typically derive them from dates
      select contractsartdate as csd
           , contractsartdate + to_yminterval('01-05') as ncsd
           , contractenddate as ced
           , contractenddate + to_yminterval('01-05') as nced
      from other_intervals;
      
      
      update other_intervals
      set contractsartdate = contractsartdate + to_yminterval('01-05')
        , contractenddate = contractenddate + to_yminterval('01-05');
      select * from other_intervals;

--    11.
--    Race duration
      select starttime, endtime, endtime-starttime as racer_time 
      from runners;
      
--    Racer 1  Duration in minutes
      select 
            (endtime-starttime) * 24 || ': Hours' as h
            ,(endtime-starttime) * 24 * 60 || ': Minutes' as m
            ,(endtime-starttime) * 24 * 60 * 60 || ': Seconds' as m
      from runners
      where racer_id = 1;

--    12.      
      select endtime-starttime
      from runners
      order by 1;

--    13.      
      select * from nls_session_parameters;
--    alter session set nls_date_format = 'DD/MM/YYYY HH:MI PM';
      alter session set nls_date_format = 'dd/mm/yyyy hh:mi:ss pm';
      select racer_id, starttime, endtime
      from runners;
-- -----------------------------------------------------------------------------
--  LOGIC FUNCTIONS
-- -----------------------------------------------------------------------------
--    NVL  If e1 NULL, return e2 else returns e1
--    NVL2 If s1 NULL, return r2 else r1
--    NULLIF If e1=e2 return NULL else returns e1
--    DECODE
--    CASE
--    COALESCE
select orderdate, nvl(shipdate,orderdate + 30)
from books.orders;

select orderdate, nvl2(shipdate,'Shipped','Not shipped')
from books.orders;

select shipdate, nullif(shipdate,null)
from books.orders;

select  shipdate
        ,decode( shipdate,
                 null, 'Not shipped',
                 shipdate)
from books.orders;
--    12.
select capacity, lifeboats, capacity/nullif(lifeboats,0) as safety
from my_ships;

     
--    13.
     
--    14.
     
--    15.
      select * from my_coalesce;
      --    1. (790) 330-1219
      --    2. (809) 494-0271
      --    3. (808) 801-3044
      --    4. (209) 702-8693
      --    5. (790) 330-1219
      --    6. (948) 120-2806
      --    7. (621) 878-1010
      select id, coalesce(work_phone, cell_phone, home_phone)
      from my_coalesce;s
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

--    14.      
      select * from some_numbers_stg; 
  
      
      insert into some_numbers_final
      select  
      from some_numbers_stg; 
--    15. 
      -- transforms nchar, mnchar2 (unicode) into varchar2 
     

--    16.      
      select to_date() from dual;
      select to_timestamp() from dual;

--    17. converts char, varchar2, nchar, or nvarchar2 datatype to an interval day to second type.
      select emp_name, hiredate 
         
      from some_hiredates_stg;
      
-- =============================================================================
--    DATE/TIME data types
-- =============================================================================
-- -----------------------------------------------------------------------------
--    DATE 
--    TIMESTAMP
--    TIMESTAMP WITH TIME ZONE
--    TIMESTAMP WITH LOCAL TIME ZONE
-- -----------------------------------------------------------------------------
--    16.
      create table mytemp
      (mydate   date,
       mytimestamp timestamp);
      insert into mytemp values (sysdate, systimestamp);
-- -----------------------------------------------------------------------------
--    DATE
-- -----------------------------------------------------------------------------
--    16.
--    Century, year, month, date, hour, minute, and secon
      select to_char(sysdate,'CC  DD/MM/YY HH:MI:SS AM') from dual;  
-- -----------------------------------------------------------------------------
--    TIMESTAMP Data Type 
-- -----------------------------------------------------------------------------
      select to_char(systimestamp,'CC  DD/MM/YY HH:MI:SS:FF AM') from dual;  
--   TIMESTAMP WITH TIME ZONE
--   TIMESTAMP WITH LOCAL TIME ZONE

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
  
    
    select 
    
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


