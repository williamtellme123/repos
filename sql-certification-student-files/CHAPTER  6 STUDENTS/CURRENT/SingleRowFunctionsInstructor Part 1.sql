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
