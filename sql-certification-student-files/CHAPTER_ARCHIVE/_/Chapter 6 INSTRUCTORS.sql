/* 
ETL LOGIC 
Extract Transform Load
      1.  I_GROUPED   and   I_GROUP_ID
          Source: TUITION.GroupID
          Extract Logic: 
          Target No. 1: if the string begins with '-'
                        then load 'Is Grouped' into T_STG.I_Grouped
                        else load 'Not Grouped' into T_STG.I_Grouped
          Target No. 2: load the ID without the dash into T_STG.I_GROUP_ID
          
      2.  I_DATE_JOINED
          Source No. 1: TUITION.Date 
          Extract Logic:  is given in 'YYYYMMD' format
                          transform to date
          Target No. 1: T_STG.I_DATE_JOINED
           
      3.  I_NAME
          Source No.1: TUITION.Insttname
          Source No. 2: TUITION.Tcsname
          Extract Logic:
          Target No. 1: If TCSNAME is null 
                        then load INSTNAME into T_STG.I_NAME
                        else load TCSNAME into T_STG.I_NAME
      4.  I_TYPE
          Source No. 1: TUITION.Type_inst
          Source No. 2: SCHOOL_TYPE.Type_name
          Extract Logic:
          Target No. 1: load matching SCHOOL_TYPE.Type_name into T_STG.I_TYPE
          
      
      5.  I_CITY
          Source No. 1: T_STG.CITY
          Extract Logic: None
          Target No. 1: T_STG.I_CITY
          
      6.  I_STATE   and     I_REGION
          Source No. 1: TUITION.State
          Source No. 2: STATES.Region
          Extract Logic:          
          Target No. 1: load matching STATES.Region into T_STG.I_REGION
          Target No. 2: load T_STG.I_STATE

      7.  I_ZIP5 and I_ZIP4
          Source No. 1: TUITION.Zip9
          Extract Logic:          
          DATA VALIDATION Group says to expect 3 valid zip9 formats
            555554444
            55555-4444
            55555
          Extract Logic:
          Target No. 1: first 5 digitsd into T_STG.I_Zip5
          Target No. 2: last 4 digits into T_STG.I_Zip4

      8.  I_PHONE
          Source No. 1: TUITION.Work_ph
          Source No. 2: TUITION.Cell_ph
          Source No. 3: TUITION.Home_ph
          Extract Logic: Format target as (xxx) xxx-xxxx
          Target No. 1: T_STG.I_PHONE
            If TUITION.Work_ph not null load into T_STG.I_PHONE
            else If TUITION.Cell_ph not null load into T_STG.I_PHONE
            else If TUITION.Home_ph not null load into T_STG.I_PHONE
            else load null into T_STG.I_PHONE
            
      9.  I_AVG_LOCAL_HELP_PER_STUDENT
          Source No. 1: TUITION.Local06
          Source No. 2: TUITION.Ttate_local_grant_contract
          Source No. 3: TUITION.Fte_count
          Extract Logic: Round target to 2 places 
          Target No. 1: Place per student average into T_STG.I_AVG_LOCAL_HELP_PER_STUDENT
      
      10.  I_AVG_STATE_HELP_PER_STUDENT    
          Source No. 1: TUITION.State03
          Source No. 2: TUITION.State06
          Source No. 3: TUITION.State09
          Source No. 4: TUITION.State_local_app
          Source No. 5: TUITION.Fte_count
          Extract Logic: Round target to 2 places 
          Target No. 1: Place per student average into T_STG.I_AVG_STATE_HELP_PER_STUDENT
          
    11.  I_AVG_FED_HELP_PER_STUDENT    
          Source No. 1: TUITION.federal03
          Source No. 2: TUITION.federal07
          Source No. 3: TUITION.federal07_net_pell
          Source No. 4: TUITION.federal10
          Source No. 5: TUITION.federal10_net_pell
          Source No. 6: TUITION.Fte_count
          Extract Logic: Round target to 2 places 
          Target No. 1: Place per student average into T_STG.I_AVG_FED_HELP_PER_STUDENT

BUSINESS RULES 
      1.  CREATE TARGET TABLE
          Study the extraction logic and target field names
          Correct any errors in business rules/ETL logic
          Create table T_STG after determine insert statement
          Try to create all varchar2 fields with minimum space ncessary
*/    
-- =============================================================================
--     1.  I_GROUPED   and   I_GROUP_ID
        select    groupid as
               i_group_id ,
                   instr(groupid,'-',1) istr,substr(groupid,1) sstr,
                      case 
                          when instr(groupid, '-',1) > 0 then substr(groupid, 2) 
                          else groupid
                      end as
              i_grouped
        from tuition;
-- -----------------------------------------------------------------------------        
--     2.  I_DATE_JOINED

-- -----------------------------------------------------------------------------
--     3.  I_NAME
           select instname, nvl2(tcsname,tcsname, instname), tcsname
           from tuition;

-- -----------------------------------------------------------------------------
--     4.  I_TYPE
        select * from school_type;
        --TYPE 
        --66	'STATE UNIVERSITY'
        --48	'STATE COLLEGE'
        --30	'STATE COMMUNITY COLLEGE'
        --38	'LOCAL COMMUNITY COLLEGE'
        --69	'PRIVATE JR COLLEGE'
        --30	'PRIVATE'
        select decode (type_inst,
                      '66',	'STATE UNIVERSITY',
                      '48',	'STATE COLLEGE',
                      '30',	'STATE COMMUNITY COLLEGE',
                      '38',	'LOCAL COMMUNITY COLLEGE',
                      '69',	'PRIVATE JR COLLEGE',
                      '30',	'PRIVATE',
                      'UNDECLARED'
                      ) as
                    type_institution
        from tuition;

        --      If time permits
        --      select type_inst from tuition;
        --      select type_id from school_type;
-- -----------------------------------------------------------------------------
--     5.  I_CITY


-- -----------------------------------------------------------------------------
--     6.  I_STATE   and     I_REGION
      select ''''||st||''''
      from states 
      where region ='South';
      select 
          state,
              case
                when state in ('IL', 'IN','IA','KS','MI','MN','MS','NE','ND','OH','SD','WV') then 'Mid West'
                when state in ('CT','ME','MA','NH','NJ','NY','PA','RI','VT') then 'North East'
                when state in ('AK','AZ','CA','CO','HI','ID','MT','NV','NM','OR','UT','WA','WY') then 'West'
                when state in ('AL','AR','DE','FL','GA','KY','LA','MD','MO','NC','OK','SC','TN','TX','VA','WI') then 'South'
              end as
           region   
      from tuition;
      --    If time permits    
      --    select state from tuition;
      --    select st from states;
      
-- -----------------------------------------------------------------------------
--     7.  I_ZIP5 and I_ZIP4
            select substr('55555-4444',-4) from dual;
            select 
                length(zip9),
                    case 
                      when length(zip9) >= 9 then substr(zip9,0,5)
                      when length(zip9) = 5 then zip9
                    end as
                zip5,
                case 
                  when length(zip9) >= 9 then substr(zip9,-4)
                end as zip4       
            from tuition;
            
-- -----------------------------------------------------------------------------
--     8.  I_PHONE
        select 
            '''(' || substr(coalesce(work_ph,cell_ph,home_ph),0,3)|| ') ' ||  
            substr(coalesce(work_ph,cell_ph,home_ph),4,3) || 
            '-' || 
            substr(coalesce(work_ph,cell_ph,home_ph),7) || 
            ''''
        from tuition;
-- -----------------------------------------------------------------------------
--     9.  I_AVG_LOCAL_HELP_PER_STUDENT
  select 
  round((nvl(to_number(local06),0)+to_number(nvl(state_local_grant_contract,0)))/fte_count,2) as AvgLocalHelpPerStudent
  from tuition;

-- -----------------------------------------------------------------------------
--    10.  I_AVG_STATE_HELP_PER_STUDENT
  select 
  round((nvl(to_number(state03),0) + nvl(to_number(state_local_app),0) + nvl(to_number(state06),0) + nvl(to_number(state09),0))/fte_count,2) as AvgStateHelpHelpPerStudent
  from tuition;

-- -----------------------------------------------------------------------------
--    11.  I_AVG_FED_HELP_PER_STUDENT    
select * from tuition;
round((nvl(to_number(federal03),0) + nvl(to_number(federal07),0) + nvl(to_number(federal07_net_pell),0) + nvl(to_number(federal10),0) + nvl(to_number(federal10_net_pell),0))/ fte_count,2) as AvgFedHelpHelpPerStudent
from tuition; 

-- ==========================================================
-- =============================================================================
create table tuition_etl
( I_GROUP_PK      integer primary key,
  I_Grouped       char(11),
  I_GROUP_ID      char(6),
  I_DATE_JOINED   date,
  I_NAME          varchar2(55),
  I_TYPE          varchar2(25),
  I_CITY          varchar2(15),
  I_STATE         char(2),
  I_REGION        varchar2(11),
  I_ZIP5          char(5),
  I_ZIP4          char(4),
  I_PHONE         char(16),
  I_LOC_PSTUDENT  number(8,2),
  I_ST_PSTUDENT   number(8,2),
  I_FED_PSTUDENT  number(8,2)
);
drop sequence tuition_etl_seq;
create sequence tuition_etl_seq start with 1; 

insert into tuition_etl
( I_GROUP_PK,       -- 1 
  I_Grouped,        -- 2
  I_GROUP_ID,       -- 3
  I_DATE_JOINED,    -- 4
  I_NAME,           -- 5
  I_TYPE,           -- 6
  I_CITY,           -- 7
  I_STATE,          -- 8
  I_REGION,         -- 9
  I_ZIP5,           -- 10
  I_ZIP4,           -- 11
  I_PHONE,          -- 12
  I_LOC_PSTUDENT,   -- 13
  I_ST_PSTUDENT,    -- 14
  I_FED_PSTUDENT)   -- 15
select  
        -- 1
        tuition_etl_seq.nextval as
    I_GROUP_PK,
        -- 2
        case
            when instr(groupid,'-',1,1)>0 then 'Is Grouped'
            when instr(groupid,'-',1,1)=0 then 'Not Grouped'
        end as
    I_GROUPED,
        -- 3
        case
            when instr(groupid,'-',1,1)>0 
                    then substr(groupid,2)
            when instr(groupid,'-',1,1)=0 
                    then groupid
        end as 
    I_GROUP_ID,
        -- 4
        to_date(date_t,'YYYYMMDD') as 
    I_DATE_JOINED,
        -- 5
        nvl2(TCSNAME,TCSNAME,INSTNAME) as 
    I_NAME,
        -- 6
        decode (type_inst,   
                          66,	'STATE UNIVERSITY',
                          48,	'STATE COLLEGE',
                          30,	'STATE COMMUNITY COLLEGE',
                          38,	'LOCAL COMMUNITY COLLEGE',
                          69,	'PRIVATE JR COLLEGE',
                          74,	'PRIVATE') as
    I_TYPE,
        -- 7
        city as 
    I_CITY,
        -- 8
        state as
    I_STATE,
        -- 9
        case  
          when state in ('IL','IN','IA','KS','MI','MN','MS','NE','ND','OH','SD','WV') 
               then 'Midwest'
          when state in ('AL','AR','DE','FL','GA','KY','LA','MD',
                         'MO','NC','OK','SC','TN','TX','VA','WI')
               then 'South'
          when state in ('AK','AZ','CA','CO','HI','ID','MT','NV','NM','OR','UT','WA','WY')     
               then 'West'
          when state in ('CT','ME','MA','NH','NJ','NY','PA','RI','VT')
               then 'North East'
      end as
    I_REGION,
        -- 10
        case
          when length(zip) = 9 
                and instr(zip,'-',1,1) = 0  
            then substr(zip,1,5)
          when length(zip) = 10
                 and instr(zip,'-',1,1) > 0
            then substr(zip,1,5)
          when length(zip) = 5
            then zip
        end as
   I_ZIP5,
        -- 11
        case
          when length(zip) = 9 
                and instr(zip,'-',1,1) = 0  
            then substr(zip,6,4)
          when length(zip) = 10
                 and instr(zip,'-',1,1) > 0
            then substr(zip,7,4)
          when length(zip) = 5
            then null
        end as
   I_ZIP4,
        -- 12
          '(' || substr(coalesce(work_ph,cell_ph,home_ph),0,3)|| ') ' ||  
          substr(coalesce(work_ph,cell_ph,home_ph),4,3) || 
          '-' || 
          substr(coalesce(work_ph,cell_ph,home_ph),7) as
   I_PHONE,
        -- 13
        round
         (
           (
              to_number(nvl(Local06,0)) 
              +
              to_number(nvl(State_local_grant_contract,0))
           )   
            / to_number(Fte_count)
          ,2) as 
  I_LOC_PSTUDENT,
         -- 14
         round
          (
              (
                nvl(to_number(State03),0)
                +
                nvl(to_number(State06),0)
                +
                nvl(to_number(State09),0)
                +
                nvl(to_number(State_local_app),0)
              )
                / nvl(to_number(fte_count),0)
          ,2) as 
  I_ST_PSTUDENT,
         -- 15
          round
        (
          (
            nvl(to_number(federal03),0)
            +
            nvl(to_number(federal07),0)
            +
            nvl(to_number(federal07_net_pell),0)
            +
            nvl(to_number(federal10),0)
            +
            nvl(to_number(federal10_net_pell),0)
          )
          / nvl(to_number(Fte_count),0)
          ,2)
          as 
  I_FED_PSTUDENT
from tuition;  
-- =======================================================================
-- Miscellaneous questions about Chapter 6 Functions
-- Question 5 CHapter 6
select trunc(round(abs(-1.7),2)) from dual;

select abs(-1.7)
,  round(abs(-1.7),2)
, trunc(round(abs(-1.7),2))
from dual;


select trunc(123.666, -2) from dual;
select round(123.666, -2) from dual;

select soundex('Billy')
from dual;

select *
from books.customers
where soundex(lastname) = soundex('smith');

select *
from books.customers
where lastname = 'B400';


select rpad(chapter_title || ' ',30,'.')
        || 
        lpad(' ' || page_number,30,'.') as TOC
from book_contents
order by page_number;

select length(rpad('Apple',10,'.') || lpad('Pie',10,'...'))
from dual;

select rpad('Apple',8,'.') from dual;
select rpad('Apple',4,'.') from dual;

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
commit;
-- -----------------------------------------------------------------------------
--   DATE data type
-- -----------------------------------------------------------------------------
--  Century, year, month, date, hour, minute, and seconds
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
where tzabbrev in('PST','MST','CST','EST');

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
-- select * from NLS_SESSION_PARAMETERS;	  -- NLS parameters of the user session (modified by user)
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
 insert into mytz values (systimestamp, systimestamp);
 commit;
select * from mytz; 
-- confirm 
select dbtimezone,sessiontimezone, tz_offset(sessiontimezone) from dual;
-- Alter if necessary
-- alter session set time_zone='-3:00'; 
-- alter session set time_zone='America/Chicago'; 
alter session set time_zone='Asia/Hong_Kong';


select tz_offset('Asia/Hong_Kong'),tz_offset('America/Chicago') from dual;

select tz_offset('Asia/Hong_Kong') a
       ,tz_offset('America/Chicago') b
       , myTSTZ
       , myTSLTZ
       from mytz;
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