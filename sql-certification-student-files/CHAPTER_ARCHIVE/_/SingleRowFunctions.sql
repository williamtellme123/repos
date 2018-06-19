-- =============================================================================
--  CHAPTER 6
/*
      Single Row Functions
        Character, Number, and Date
        Conversion
        Time Zones—Datetime Functions
       
*/
-- -----------------------------------------------------------------------------
-- CHARACTER FUNCTIONS
-- -----------------------------------------------------------------------------
--    UPPER	UPPER(s1)
--    LOWER	LOWER(s1)
--    INITCAP	INITCAP(s1)
--    CONCAT, ||	CONCAT(s1,s2), s1 || s2
--    1.      
--        extract names_stg      
--        load names_final  
      insert into names_final (
               first_upper        -- 1   
             , last_upper         -- 2    
             , first_lower        -- 3  
             , last_lower         -- 4  
             , full_name_pipe     -- 5
             , full_name_concat   -- 6
             )
      select  
               upper(firstname)             -- 1   
             , upper(lastname)              -- 2    
             , lower(firstname)             -- 3  
             , lower(lastname)              -- 4  
             , initcap(firstname || ' ' || lastname)        -- 5
             , initcap(concat(firstname, concat(' ',lastname)))  -- 6
      from names_stg;
--    2.      
      select * from names_final;
-- -----------------------------------------------------------------------------      
--    LPAD	LPAD(s1,n,s2)
--    RPAD	RPAD(s1,n,s2)
--    3.
      select 
              rpad(chapter_title || ' ',30,'.') 
              ||
              lpad(' ' || page_number,30,'.') as "Table of contents"
      from cruises.book_contents
      order by page_number;  
-- -----------------------------------------------------------------------------       
--    LTRIM	LTRIM(s1,s2)
--    RTRIM	RTRIM(s1,s2)
--    TRIM	TRIM(trim_info trim_char FROM trim_source)
--    4.
--        extract names_stg2      
--        load names_final2  
      select * from names_stg2;
--    5.      
      insert into names_final2
      (
          rtrim_firstname
        , rtrim_lastname
        , ltrim_firstname
        , ltrim_lastname
        , trim_trailing_firstname
        , trim_trailing_lastname
        , trim_firstname
        , trim_lastname         
      )
      select 
            rtrim(firstname,'*')
          , rtrim(lastname,'*')
          , ltrim(firstname,'*')
          , ltrim(lastname,'*')
          , trim(trailing '*' from firstname)
          , trim(trailing '*' from lastname)
          , trim('*' from firstname)
          , trim('*' from lastname)          
      from names_stg2;
--    5.
      select * from names_stg2;     
-- -----------------------------------------------------------------------------
--    LENGTH
--    6.  
      select length(title) len 
      from length_stg
      order by len desc;
--    7.     
      drop table length_final;
--    8.           
      create table length_final
      (title varchar2(350));
--    9.      
      insert into length_final(
       title
      )
      select 
        title
      from length_stg;  
--    10.
      select *
      from length_final;
-- -----------------------------------------------------------------------------
--    INSTR	INSTR(s1,s2,pos,n)
--    SUBSTR	SUBSTR(s, pos, len)
--    11.
--        extract my_strings_stg      
--        load my_strings_final
--        Load most specific identifier 
--            Parent company id is always there
--            Franchise id is sometiomes there
      insert into my_strings_final
      (
            company_id
          , parent_company_id
          , franchise_id
      )
      select
              company_id
              ,case
                  when instr(company_id,'-',1,1)>0 then
                      substr(company_id,1,instr(company_id,'-',1,1)-1)
                  when instr(company_id,'-',1,1)=0 then
                      company_id
                  end as parent_company_id    
              ,case
                  when instr(company_id,'-',1,1)>0 then
                      substr(company_id,instr(company_id,'-',1,1)+1)
                  end as franchise_id    
      from my_strings_stg;
--    12.
      select * from my_strings_stg;
--    13.
      select * from my_strings_final;
-- ----------------------------------------------------------------------------- 
--    SOUNDEX	SOUNDEX(s)
--    14.
      select * from my_soundex_stg;
      select lastname
      from my_soundex_stg
      where soundex(lastname) = soundex('SMYTHE');
-- ----------------------------------------------------------------------------- 
--    REPLACE(s1, s2,r) 
--    15.
--        extract my_depo_stg      
--        load my_depo_final  
      insert into my_depo_final (
        question
        ,answer
      )
      select 
          replace (question, 'JB', 'Janice Brookley')
        , replace (answer, 'PD', 'Paula Deen')
      from  my_depo_stg;
--    -----------------------------------------------------
      select * from my_depo_final;
--    -----------------------------------------------------      
--        extract my_depo_stg      
--        load my_depo_final
--            Court Ruling Replace all Name abbreviations to Full Names
--            JB, Janice Brookley
--            PD, Paula Deen
--            DM, Dana Montgomery
      select * from my_depo_stg;
      insert into my_depo_final(
             question,
             answer)
      select
               replace(question,'JB','Janice Brookley')
              , replace(answer,'PD','Paula Deen')
      from my_depo_stg;
      
      
      --    How to do multiplle replaces in same field?
      insert into my_depo_final(
             question,
             answer)
      select
            replace(replace(question,'JB','Janice Brookley'), 'PD', 'Paula Deen')
          , replace(replace(replace(answer,'PD','Paula Deen'), 'DM', 'Dana Montgomery'), 'JB','Janice Brookley')
      from my_depo_stg;
-- -----------------------------------------------------------------------------
-- NUMBER FUNCTIONS
-- -----------------------------------------------------------------------------
--    ROUND-number
--    TRUNC-number
--    REMAINDER
--    MOD
--    17.
      select * from num_functions;
--    18.      
      select
              onevalue
            , round(onevalue, 1)
            , round(onevalue, -1)
            , trunc(onevalue, 1)
            , trunc(onevalue, -1)
      from num_functions;      
--    19.      
      select
                onevalue
              , remainder(onevalue, 4)
              , mod(onevalue, 4)
      from num_functions2;      

-- -----------------------------------------------------------------------------
--  DATE FUNCTIONS
-- -----------------------------------------------------------------------------
--  alter session set nls_date_format = 'DD/MM/YYYY HH:MI PM';
--    SYSDATE
--    ROUND-date
--    TRUNC-date
--    NEXT_DAY
--    LAST_DAY
--    ADD_MONTHS
--    MONTHS_BETWEEN
--    NUMTOYMINTERVAL
--    NUMTODSINTERVAL
--    20.   
      select sysdate from dual;
--    21.
      select * from date_functions;
      
--    22.      
      select  
      --  to_char just to see what is actually in a date field
              to_char(startdate, 'mm/dd/yyyy hh:mi:ss')
            , to_char(enddate, 'mm/dd/yyyy hh:mi:ss')

      --   use to_char see dd round results
            , to_char(round(startdate,'dd'), 'mm/dd/yyyy hh:mi:ss') as rsd_dd
            , to_char(round(enddate,'dd'), 'mm/dd/yyyy hh:mi:ss') as red_dd
      
      --  use to_char see dd trunc date            
            , to_char(trunc(startdate,'dd'), 'mm/dd/yyyy hh:mi:ss') as tsd_dd
            , to_char(trunc(enddate,'dd'), 'mm/dd/yyyy hh:mi:ss') as ted_dd
      from date_functions;           
      
      select
      --  to_char just to see what is actually in a date field
              to_char(startdate, 'mm/dd/yyyy hh:mi:ss')
            , to_char(enddate, 'mm/dd/yyyy hh:mi:ss')
      --  use to_char see mm round results 
            , to_char(round(startdate,'mm'), 'mm/dd/yyyy hh:mi:ss') as rsd_mm
            , to_char(round(enddate,'mm'), 'mm/dd/yyyy hh:mi:ss') as red_mm 
   
      --  use to_char see trunc results             
            , to_char(trunc(startdate,'mm'), 'mm/dd/yyyy hh:mi:ss') as tsd_mm
            , to_char(trunc(enddate,'mm'), 'mm/dd/yyyy hh:mi:ss') as ted_mm
      from date_functions;  
      
      select   
              to_char(round(startdate,'yy'), 'mm/dd/yyyy hh:mi:ss') as rsd_yy
            , to_char(round(enddate,'yy'), 'mm/dd/yyyy hh:mi:ss') as red_yy
            , to_char(trunc(startdate,'yy'), 'mm/dd/yyyy hh:mi:ss') as tsd
            , to_char(trunc(enddate,'yy'), 'mm/dd/yyyy hh:mi:ss') as ted
      from date_functions;  
 
      select   
              next_day(startdate,'Saturday')
            , last_day(startdate)
            , add_months(startdate,3)
            , months_between(startdate, enddate)
      from date_functions;
--    23. 
--    The TO_YMINTERVAL function converts a string representing a 
--    number of years and a number of months into an INTERVAL YEAR 
--    TO MONTH datatype.       
--    Use Case: Use NUMTOYMINTERVAL in a SUM analytic function to calculate, 
--    the total salary for each employees hired in the past one year 
--    from their hire date. 
--    numtoyminterval  uses 'YEAR' 'MONTH'
      create table interval_yr_to_month
      (one interval year(3) to month);
--    24.       
      insert into interval_yr_to_month values (to_yminterval('01-02'));
--    25.             
      select * from interval_yr_to_month;
--    26.
--    The TO_DSINTERVAL function converts a string representing 
--    a number of days, hours, minutes and seconds into an INTERVAL DAY TO SECOND datatype. 
--    to_dsinterval uses 'SECOND' 'DAY'
      create table interval_day_to_second 
      (one interval day(5) to second(3));
      insert into interval_day_to_second values (to_dsinterval('2 10:20:30.456'));
--    27.
      select * from interval_day_to_second;



--    Uses NUMTOYMINTERVAL in a SUM analytic function to calculate, 
--    for each employee, the total salary of employees hired in the past one year 
--    from their hire date. 
--    Refer to "Analytic Functions" for more information on the syntax of the analytic functions.
--    numtoyminterval  'YEAR' 'MONTH'
--    SELECT last_name, hire_date, salary, SUM(salary) 
--    OVER (ORDER BY hire_date 
--    RANGE NUMTOYMINTERVAL(1,'year') PRECEDING) AS t_sal 
--    FROM employees
--    ORDER BY last_name, hire_date;

-- -----------------------------------------------------------------------------
--  LOGIC FUNCTIONS
-- -----------------------------------------------------------------------------
--    NVL  If e1 NULL, return e2 else returns e1
--    NVL2 If s1 NULL, return r2 else r1
--    NULLIF If e1=e2 return NULL else returns e1
--    DECODE
--    CASE
--    COALESCE

--    27.
      select shipdate, nvl(shipdate, sysdate) from books.orders;
--    28.
      select shipdate, nvl2(shipdate, 'Shipped', 'Not Shipped') from books.orders;
--    29.
      select capacity/lifeboats from my_ships;
      select capacity/nullif(lifeboats, 0) lifeboats from my_ships;
--    30.
      select * from my_coalesce;
      --    1. (790) 330-1219
      --    2. (809) 494-0271
      --    3. (808) 801-3044
      --    4. (209) 702-8693
      --    5. (790) 330-1219
      --    6. (948) 120-2806
      --    7. (621) 878-1010
      select id, coalesce(work_phone,cell_phone,home_phone)
      from my_coalesce;      

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
-- -----------------------------------------------------------------------------
--  TIMEZONE
-- -----------------------------------------------------------------------------
--    DBTIMEZONE
--    SESSIONTIMEZONE
--    CURRENT_DATE
--    CURRENT_TIMESTAMP
--    LOCALTIMESTAMP
--    SYSTIMESTAMP
--    NEW_TIME
-- -----------------------------------------------------------------------------
--  TIMEZONE CONVERSION
-- -----------------------------------------------------------------------------
--    FROM_TZ
--    TO_TIMESTAMP_TZ
--    CAST
--    EXTRACT
--    SYS_EXTRACT_UTC
                                                                                                                                                                                                                                                                                                                                            .  I_STATE  :  Use lookup table to grab Region for new table
          -- Source Field:    states.region
          -- Target Field     tuition_etl.i_state
          select state from tuition;
          select unique '''' || region || '''' from states;
          --'Midwest'
          --'South'
          --'West'
          --'North East'

            select
                state as i_state
                ,case  
                  when state in ('IL','IN','IA','KS','MI','MN','MS','NE','ND','OH','SD','WV') 
                       then 'Midwest'
                  when state in ('AL','AR','DE','FL','GA','KY','LA','MD',
                                 'MO','NC','OK','SC','TN','TX','VA','WI')
                       then 'South'
                  when state in ('AK','AZ','CA','CO','HI','ID','MT','NV','NM','OR','UT','WA','WY')     
                       then 'West'
                  when state in ('CT','ME','MA','NH','NJ','NY','PA','RI','VT')
                       then 'North East'
                end as i_region
            from tuition;
-- 
-- -----------------------------------------------------------------------------
-- 9. CHAPTER 6 NESTING : length instr substr case
-- -------------------------------------------------------
-- LENGTH
select title, length(title) from books.books;
select title, length(title) from books.books order by 2 desc;
-- INSTR
select instr('HONOLULU','O',1,1) from dual;
select instr('HONOLULU','O',1,2) from dual;
select instr('HONOLULU','O',-1,2) from dual;
-- SUBSTR
select substr('HONOLULU',4) from dual;
-- CASE
select case
          when 'APPLE' != 'APPLE' then 'YUM'
          else 'Yech'
       end
from dual;     
-- TEST USING INSTR SUBSTR
-- How many Zip9 values have a dash?
Select instr(zip, '-',1,1) 
from tuition
where instr(zip, '-',1,1) > 0;
-- TEST USING THE CASE (get the first 5)
select case
          when instr(zip, '-',1,1) > 0 then substr(zip,1,5)
       end as i_zip5  
from tuition
where instr(zip, '-',1,1) > 0;
-- TEST USING SUBSTR (get the last 4)
select substr('55555-4444',-4) from dual;
          -- -----------------------------------------------------------------------------
          -- ETL BUSINESS LOGIC FROM TUITION DATA
          -- H.  I_ZIP  :  Convert from variuos zip formats int zip5 and zip4
          -- Source Field : tuition.Zip9
          -- Target Field No. 1 : tuition_etl.i_zip5              First 5 values
          -- Target Field No. 4 : tuition_etl.i_zip4              Last 4 values
          -- Target Field No. 2 : tuition.insttname              System of schools (University of California) never null
          -- data owner says expect 3 valid zip9 formats
          --    555554444
          --    55555-4444
          --    55555
            select 
                zip 
                ,length(zip)
                ,case 
                      when length(zip) >= 9 then substr(zip,0,5)
                      when length(zip) = 5 then zip
                    end as zip5
                ,case 
                  when length(zip) >= 9 then substr(zip,-4)
                end as zip4       
            from tuition;
          -- -----------------------------------------------------------------------------
          -- I. ETL BUSINESS LOGIC FROM TUITION DATA
          -- FIX 4 digit Zip
          select 
                zip 
                ,length(zip)
                ,case 
                      when length(zip) >= 9 then substr(zip,0,5)
                      when length(zip) = 5 then zip
                   end as zip5
                ,case 
                  when length(zip) >= 9 then (case when instr(substr(zip,-4),'-') > 0 then replace(substr(zip,-4), '-',0) end)
                end as zip4
          FROM tuition;
-- -----------------------------------------------------------------------------
-- 10. CHAPTER 6 COALESCE : Take the first non null value
-- -------------------------------------------------------
select coalesce(null, 'Hello') from dual;
select coalesce(null, null, 'Hello') from dual;
select coalesce('Hey there', null, null, 'Hello') from dual;
          -- ETL BUSINESS LOGIC FROM TUITION DATA
          -- I.  I_PHONE  :  Take the first non null phone number in this order format target as (xxx) xxx-xxxx
          -- Source Field No. 1: tuition.Work_ph
          -- Source Field No. 2: tuition.Cell_ph
          -- Source Field No. 3: tuition.Home_ph
          select 
            '(' || substr(coalesce(work_ph,cell_ph,home_ph),0,3)|| ') ' ||  
            substr(coalesce(work_ph,cell_ph,home_ph),4,3) || 
            '-' || 
            substr(coalesce(work_ph,cell_ph,home_ph),7)
          from tuition;

-- -----------------------------------------------------------------------------
-- 11. CHAPTER 6 MATH from strings
--     If the string is actually a number just inside single ticks it will auto convert
-- -------------------------------------------------------       
-- Test math on strings
select local06, local06 + 1
from tuition;
-- To accomplish the next three etl business logic steps from tuition data we need to add several columns
-- of tution assistance together. But is there is a null value in on of several the whole addition will be null
-- so first we have to convert nulls to 0's
select nvl(local06,0), nvl(local06,0) + 1
from tuition;
          -- -----------------------------------------------------------------------------
          -- ETL BUSINESS LOGIC FROM TUITION DATA
          -- J.  I_AVG_LOCAL_HELP_PER_STUDENT  :  Avergage (local06, state_local_grant_contract) using fte_count to divide
          -- Source Field No. 1: tuition.local06
          -- Source Field No. 2: tuition.state_local_grant_contract
          -- Target Field tuition_etl.i_loc_pstudent
            select round((nvl(to_number(local06),0) +
                   to_number(nvl(state_local_grant_contract,0)))/fte_count,2) as i_loc_pstudent
            from tuition;
          -- -----------------------------------------------------------------------------
          -- ETL BUSINESS LOGIC FROM TUITION DATA
          -- K.  I_AVG_STATE_HELP_PER_STUDENT  :  Average 
          --  Source Field No. 1: tuition.state03
          --  Source field no. 2: tuition.state06
          --  Source field no. 3: tuition.state09
          --  Source field no. 4: tuition.state_local_app
          --  Target field : tuition_etl.i_st_pstudent
            select round(
                  (
                      nvl(to_number(state03),0) + 
                      nvl(to_number(state_local_app),0) + 
                      nvl(to_number(state06),0) + 
                      nvl(to_number(state09),0)
                  )
                  /fte_count) as i_st_pstudent
            from tuition;
          -- -----------------------------------------------------------------------------
          -- ETL BUSINESS LOGIC FROM TUITION DATA
          -- L.  I_AVG_FED_HELP_PER_STUDENT  :  Avergage (local06, state_local_grant_contract) using fte_count to divide
          --  Source Field No. 1: TUITION.federal03
          --  Source Field No. 2: TUITION.federal07
          --  Source Field No. 3: TUITION.federal07_net_pell
          --  Source Field No. 4: TUITION.federal10
          --  Source Field No. 5: TUITION.federal10_net_pell
          --  Target Field tuition_etl.i_fed_pstudent
          select round((nvl(to_number(federal03),0) + 
                 nvl(to_number(federal07),0) + 
                 nvl(to_number(federal07_net_pell),0) + 
                 nvl(to_number(federal10),0) + 
                 nvl(to_number(federal10_net_pell),0))/ fte_count) as i_fed_pstudent
          from tuition;        
          -- -----------------------------------------------------------------------------
          -- ETL BUSINESS LOGIC FROM TUITION DATA
          -- M.  EXECUTE ETL 
          --      i.   Create the insert statement by copying all the logic down from above
          --      ii.  Next determine what field types and sizes are needed for tuition_etl (target table)
          --      iii. Create target table : tuition_etl
          --      iv.  Run the ETL
-- =============================================================================
--      i.   Create the insert statement by copying all the logic down from above
delete tuition;
create sequence tuition_etl_seq;
insert into tuition_etl
( I_GROUP_PK        -- 1 
  ,I_Grouped        -- 2
  ,I_GROUP_ID       -- 3
  ,I_DATE_JOINED    -- 4
  ,I_NAME           -- 5
--  ,I_TYPE           -- 6
--  ,I_CITY           -- 7
--  ,I_STATE          -- 8
--  ,I_REGION         -- 9
--  ,I_ZIP5           -- 10
--  ,I_ZIP4           -- 11
--  ,I_PHONE          -- 12
--  ,I_LOC_PSTUDENT   -- 13
--  ,I_ST_PSTUDENT    -- 14
--  ,I_FED_PSTUDENT   -- 15
)
select  
      -- 1
      tuition_etl_seq.nextval as I_GROUP_PK                   
      -- 2
      ,case
          when instr(groupid,'-',1,1)>0 then 'Is Grouped'
          when instr(groupid,'-',1,1)=0 then 'Not Grouped'
      end as I_GROUPED
--      -- 3
--      ,case
--          when instr(groupid,'-',1,1)>0 
--                  then substr(groupid,2)
--          when instr(groupid,'-',1,1)=0 
--                  then groupid
--      end as I_GROUP_ID
      -- 4
--      ,to_date(date_t,'YYYYMMDD') as I_DATE_JOINED
      -- 5
--      ,nvl2(TCSNAME,TCSNAME,INSTNAME) as I_NAME
--      -- 6
--      ,decode (type_inst,   
--                        66,	'STATE UNIVERSITY',
--                        48,	'STATE COLLEGE',
--                        30,	'STATE COMMUNITY COLLEGE',
--                        38,	'LOCAL COMMUNITY COLLEGE',
--                        69,	'PRIVATE JR COLLEGE',
--                        74,	'PRIVATE') as  I_TYPE
--      -- 7
--      ,city as I_CITY
--      -- 8
--      ,state as I_STATE
--      -- 9
--      ,case  
--        when state in ('IL','IN','IA','KS','MI','MN','MS','NE','ND','OH','SD','WV') 
--             then 'Midwest'
--        when state in ('AL','AR','DE','FL','GA','KY','LA','MD',
--                       'MO','NC','OK','SC','TN','TX','VA','WI')
--             then 'South'
--        when state in ('AK','AZ','CA','CO','HI','ID','MT','NV','NM','OR','UT','WA','WY')     
--             then 'West'
--        when state in ('CT','ME','MA','NH','NJ','NY','PA','RI','VT')
--             then 'North East'
--      end as I_REGION
--      -- 10
--      ,case
--        when length(zip) = 9 
--              and instr(zip,'-',1,1) = 0  
--          then substr(zip,1,5)
--        when length(zip) = 10
--               and instr(zip,'-',1,1) > 0
--          then substr(zip,1,5)
--        when length(zip) = 5
--          then zip
--      end as I_ZIP5
--      -- 11
--      ,case
--        when length(zip) = 9 
--              and instr(zip,'-',1,1) = 0  
--          then substr(zip,6,4)
--        when length(zip) = 10
--               and instr(zip,'-',1,1) > 0
--          then substr(zip,7,4)
--        when length(zip) = 5
--          then null
--      end as I_ZIP4
--      -- 12
--      , '(' || substr(coalesce(work_ph,cell_ph,home_ph),0,3)|| ') ' ||  
--        substr(coalesce(work_ph,cell_ph,home_ph),4,3) || 
--        '-' || 
--        substr(coalesce(work_ph,cell_ph,home_ph),7) as I_PHONE
--      -- 13
--      ,round
--       (
--         (
--            to_number(nvl(Local06,0)) 
--            +
--            to_number(nvl(State_local_grant_contract,0))
--         )   
--          / to_number(Fte_count)
--        ,2) as I_LOC_PSTUDENT
--       -- 14
--       ,round
--        (
--            (
--              nvl(to_number(State03),0)
--              +
--              nvl(to_number(State06),0)
--              +
--              nvl(to_number(State09),0)
--              +
--              nvl(to_number(State_local_app),0)
--            )
--              / nvl(to_number(fte_count),0)
--        ,2) as I_ST_PSTUDENT
--       -- 15
--        ,round
--      (
--        (
--          nvl(to_number(federal03),0)
--          +
--          nvl(to_number(federal07),0)
--          +
--          nvl(to_number(federal07_net_pell),0)
--          +
--          nvl(to_number(federal10),0)
--          +
--          nvl(to_number(federal10_net_pell),0)
--        )
--        / nvl(to_number(Fte_count),0)
--        ,2)
--        as I_FED_PSTUDENT
from tuition;  

-- =============================================================================
drop table tuition_etl;
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
  I_LOC_PSTUDENT  number(12,2),
  I_ST_PSTUDENT   number(12,2),
  I_FED_PSTUDENT  number(12,2)
);



-- =============================================================================
-- Miscellaneous questions about Chapter 6 Functions
-- Question 5 CHapter 6
select abs(-1.7),round(abs(-1.7),2), trunc(round(abs(-1.7),2)) from dual;
select trunc(round(abs(-1.7),2)) from dual;
select trunc(234.999,2), round(234.999,2) from dual;
select trunc(236.999,-1), round(234.999,-1) from dual;
select abs(-1.7)
    ,  round(abs(-1.7),2)
    , trunc(round(abs(-1.7),2))
from dual;

select trunc(126.666, -2) from dual;
select round(166.666, -2) from dual;

select soundex('Billy')
from dual;

select lastname,soundex(lastname)
from books.customers
where soundex(lastname) = soundex('SMITH');

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

select * from nls_database_parameters;
select dbtimezone, sessiontimezone
from dual;


drop table email_response;
create table email_response
( email_response_id number,
  email_sent timestamp with local time zone,
  email_received timestamp with time zone);
alter session set time_zone = 'America/Los_Angeles';
select to_char(sysdate,'Q, DD MONTH YYYY HH:MI:SS') from dual;
insert into email_response values (1,sysdate,sysdate);
insert into email_response values (1,systimestamp,systimestamp);
select * from email_response;
alter session set time_zone = 'America/Chicago';
select * from email_response;
        
        
        
select rtrim('1234aaaaa','a') from dual;       

select to_char(3452345234,'$999,999,999,999.00') from dual;

select to_yminterval('01-03') from dual;

--table mysort
--one col called one
--type varchar2 20 characters
create table mysort(one varchar2(20));
insert into mysort values('apple');
insert into mysort values('Apple');
insert into mysort values('APPLE');
insert into mysort values('123');
insert into mysort values('1');
insert into mysort values('10');
insert into mysort values('#');
insert into mysort values('*');
insert into mysort values(' ');
insert into mysort values(null);
insert into mysort values('23');

select one,substr(one,1,1)
from mysort 
order by substr(one,1,1);


create table hats
(
  hid   integer primary key,
  hatsize  integer,
  name  varchar2(15),
  color  varchar2(15)); 
  select * from hats;
commit;
select * from hats;
delete hats;


drop table mynum;

create table mynum
(one number(5,-2));



insert into mynum values (9999999);
select * from mynum;

insert into mynum values (99.994999999999999999999999999999);
insert into mynum values (99);
insert into mynunm values (99);















