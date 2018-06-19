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
select * from names_stg;
select * from names_final;
desc names_final;
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
             , initcap(firstname || ' ' ||lastname)        -- 5
             , initcap(concat(firstname,concat(' ', lastname)))   -- 6
      from names_stg;
      delete names_final;
--    2.      
      select * from names_final;
-- -----------------------------------------------------------------------------      
--    LPAD	LPAD(s1,n,s2)
--    RPAD	RPAD(s1,n,s2)
--    3.
      select * 
      from cruises.book_contents;
      
      select 
              rpad(chapter_title || ' ',30,'.') 
              ||
              lpad(' ' || page_number,30,'.') as "Table of contents"
      from cruises.book_contents
      order by page_number;  
-- -----------------------------------------------------------------------------       
--    LTRIM	LTRIM(s1,s2)
--    RTRIM	RTRIM(s1,s2)
--    TRIM	  TRIM(trim_info trim_char FROM trim_source)
--    4.
--        extract names_stg2      
--        load names_final2
select * from names_stg2;
select * from names_final2;
  insert into names_final2(
      rtrim_firstname  -- 1
      ,rtrim_lastname  -- 2
      ,ltrim_firstname -- 3
      ,ltrim_lastname  -- 4
      ,trim_trailing_firstname  -- 5
      ,trim_trailing_lastname  -- 6
      ,trim_firstname           -- 7
      ,trim_lastname           -- 8
      )
      select
        rtrim(firstname,'*') as rtfn
      , rtrim(lastname,'*') as rtln
      , ltrim(firstname,'*') as ltfn
      , ltrim(lastname,'*') as ltln
      , trim(trailing '*' from firstname) ttfn
      , trim(trailing '*' from lastname) ttln
      , trim('*' from firstname) tfn
      , trim('*' from lastname) tln
      from names_stg2;
--    5.      
      select * from names_stg2;
      select * from names_final2;
-- -----------------------------------------------------------------------------
--    LENGTH
--    6.  
select * from length_stg;
desc length_stg;
      select length(title) as len 
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
--            Parent company id is always there
--            Franchise id is sometimes there
alter table my_strings_final rename column company_id to company_pk;
alter table my_strings_final add company_id varchar2(25);
desc my_strings_final;

insert into my_strings_final(
          company_pk                  -- 1
        , company_id                  -- 2
        , parent_company_id           -- 3
        , franchise_id                -- 4
      )
select   company_seq.nextval as company_id   -- 1
       , company_id
       , case 
             when instr(company_id, '-', 1, 1) > 0 then
--                'Split up into parent and franchise ids'
                  substr(company_id, 1,
                  instr(company_id, '-', 1, 1)-1
                  )
             when instr(company_id, '-', 1, 1) = 0 then
                      company_id
        end as parent_company_id      -- 2
        , case
            when instr(company_id, '-', 1, 1) > 0 then
                  substr(company_id,instr(company_id, '-',1,1)+1)
            else 'Not Supplied'      
          end as franchise_id 
from my_strings_stg;        
desc my_strings_final;
--    12.
      select * from my_strings_stg;
--    13.
      select * from my_strings_final;
-- ----------------------------------------------------------------------------- 
--    SOUNDEX	SOUNDEX(s)
--    14.
      select * from my_soundex_stg;
      select lastname, soundex(lastname), soundex('SMYTHE'), soundex('Billy'), soundex('William')
      from my_soundex_stg
      where soundex(lastname) = soundex('SMYTHE');
      
      select lastname, soundex('SYMTHE')
      from my_soundex_stg;
      

     select lastname, soundex('SMYTHE') 
      from my_soundex_stg
      where lastname = soundex('SMYTHE') ;
-- ----------------------------------------------------------------------------- 
--    REPLACE(s1, s2,r) 
--    15.
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



--    16.
      select * from my_depo_final;

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
  
      from num_functions;      
--    19.      
      select

      from num_functions2;      

-- -----------------------------------------------------------------------------
--  DATE FUNCTIONS
-- -----------------------------------------------------------------------------
--alter session set nls_date_format = 'DD/MM/YYYY HH:MI PM';


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
    
    
    
      from date_functions;
--    23. 
--    The TO_YMINTERVAL function converts a string representing a 
--    number of years and a number of months into an INTERVAL YEAR 
--    TO MONTH datatype.       
--    Use Case: Use NUMTOYMINTERVAL in a SUM analytic function to calculate, 
--    the total salary for each employees hired in the past one year 
--    from their hire date. 
--    numtoyminterval  uses 'YEAR' 'MONTH'

create table mytable2(
id integer,
duration interval day(3) to second (4)
);
insert into mytable2 values (1, INTERVAL '3' DAY);--Interval of 3 days
insert into mytable2 values (2, 	Interval '2' hour);--: interval of 2 hours
insert into mytable2 values (3, 	interval '25' minute);--: interval of 25 minutes
insert into mytable2 values (4, 	interval '45' second);--: interval of 45 seconds
insert into mytable2 values (5, 	interval '123 2:25:45.12' day(3) to second(2));--: interval of 123 days 2 hours 25 minutes 45.12 seconds; the precision for days is 3 digits and the precision for the fractional seconds is 2 digits
insert into mytable2 values (6, 	interval '-3 2:25:45' day to second);--: negative interval of 3 days 2 hours 25 minutes 45 seconds
insert into mytable2 values (9, 	interval '2' hour);--: interval of 2 hours
insert into mytable2 values (10, 	interval '25' minute);--: interval of 25 minutes
insert into mytable2 values (11, 	interval '45' second);--: interval of 45 seconds
insert into mytable2 values (12, 	interval '3 2:25:45' day to second);--: interval of 3 days 2 hours 25 minutes 45 seconds
insert into mytable2 values (13, 	interval '123 2:25:45.12' day(3) to second(2));--: interval of 123 days 2 hours 25 minutes 45.12 seconds; the precision for days is 3 digits and the precision for the fractional seconds is 2 digits
insert into mytable2 values (14, 	interval '3 2:00:45' day to second);--: interval of 3 days 2 hours 0 minutes 45 seconds
insert into mytable2 values (15, 	interval '-3 2:25:45' day to second);--: negative interval of 3 days 2 hours 25 minutes 45 seconds
insert into mytable2 values (16, 	interval '1234 2:25:45' day(3) to second);--: invalid interval because the number of digits in the days exceeds the specified precision of 3



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


create table mytable (
id          integer,
duration    interval year(3) to month
); 

insert into mytable(id, duration) values(1, interval '1' year); 
insert into mytable(id, duration) values(2, interval '1' month); 
insert into mytable(id, duration) values(3, interval '99' month); 
insert into mytable(id, duration) values(4, interval '1-2' year to month); 
insert into mytable(id, duration) values(5, interval '0-1' year to month); 
insert into mytable(id, duration) values(6, interval '999' year(3)); 

select * from mytable;
--    interval '1' year	interval of 1 year.
--    interval '1' month	interval of 1 months.
--    interval '14' month	interval of 14 months (1 year 2 months).
--    interval '1-2' year to month	interval of 1 year 2 months.
--    interval '0-1' year to month	interval of 0 years 1 months.
--    interval '999' year(3) to month	interval of 999 years with a precision of 3 digits.
--    interval '-1-2' year to month	a negative interval of 1 year 2 months.

-- -----------------------------------------------------------------------------
--  LOGIC FUNCTIONS
-- -----------------------------------------------------------------------------
--    NVL  If e1 NULL, return e2 else returns e1
--    NVL2 If s1 NULL, return r2 else r1
--    NULLIF If e1=e2 return NULL else returns e1
--    DECODE
--    CASE
--    COALESCE

--    28.
      select shipdate, nvl(shipdate, sysdate) from books.orders;
--    29.
      select shipdate, nvl2(shipdate, 'Shipped', 'Not Shipped') from books.orders;
--    30.
      select capacity/lifeboats from my_ships;
      select capacity/nullif(lifeboats, 0) lifeboats from my_ships;
--    31.
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
