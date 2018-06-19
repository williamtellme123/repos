-- =============================================================================
--  CHAPTER 6
/*
      Single Row Functions
        Character, Number, and Date
        Conversion
        Time Zones—Datetime Functions

        Instead of running each of these functions using the examples in the book
        we will be learning them through a standard business use case called an ETL.
        
        ETL stands for Extract Transform and Load.
        Our class example begins with a tuition csv file (comma seperated values).
        
        We begin by creating a staging table called TUITION, where each field is varchar2.
        We import the data into that table. Then using the business rules supplied
        by the person who knows the data and sent us the csv we perform an ETL.
        We extract          from the staging table TUITION using a select statement
        We transform        using Chapter 6 functions into the correct business meaning
        We load             the business meaning into our final table called TUITION_ETL
        
        ETL BUSINESS LOGIC
        The owner of the data sends us a CSV file that is somewhat cryptic. It was dumped
        from a computer system from a government agency studying a collection of schools to understand the actual 
        distribution of Federal, State and Local assistance provided to students.
        
        After each chapter 6 topic below there is an ETL BUSINESS LOGIC EXAMPLE using this data 
        
*/
-- -----------------------------------------------------------------------------
-- 0. Review
-- Create Table as Select
        drop table mybooks_etl;
        create table mybooks_etl
        (
           isbn       varchar2(20)
          ,category   varchar2(20)
          ,title      varchar2(100)
          ,profit     varchar2(20)
          );

-- Example of ETL
        -- LOAD
        insert into mybooks_etl
        (
           isbn
          ,category
          ,title
          ,profit
        )
        -- EXTRACT AND TRANSFORM
        select
           isbn
          ,initcap(category)                                -- transforming all caps to initcap
          ,initcap(title)                                   -- transforming all caps to initcap
          ,to_char(retail - cost,'$999,999.99') as profit   -- transforming to new value with formatting
        from books.books;
        
        select * from mybooks_etl;
        -- -----------------------------------------------------------------------------
        -- ETL BUSINESS LOGIC FROM TUITION DATA
        -- Using CHAPTER 6 STUDENTS TABLES.SQL Create following tables in Student Schema
        --        TUITION
        --        STATES
        --        SCHOOOL_TYPE
-- -----------------------------------------------------------------------------
-- 1. CHAPTER 6 RPAD LPAD
-- -------------------------------------------------------
select rpad('Apple',10,'.') from dual;
select lpad('Pie',10,'-') from dual;
select chapter_title, page_number 
from cruises.book_contents;

select rpad(chapter_title || ' ',30,'.') ||
       lpad(' ' || page_number,30,'.') as "Table of Contents"
from cruises.book_contents
order by page_number;          
-- -----------------------------------------------------------------------------
-- 2. CHAPTER 6 SUBSTR : returns a sub string
-- Searching forward
select substr('APPLES ARE FOR BOW AND ARROW TARGETS',4,3) from dual;
-- Searching backwards
select substr('APPLES ARE FOR BOW AND ARROW TARGETS',-4,3) from dual;
-- -----------------------------------------------------------------------------
-- 3. CHAPTER 6 INSTR : returns a location (integer) where the string was found
-- Searching forward
select instr('HONOLULU','LULU',1,1) from dual;
-- Searching backwards
select instr('HONOLULU','O',-1,1) from dual;
-- -----------------------------------------------------------------------------
-- 4. CHAPTER 6 CASE : an if-then-else statement for a column
-- Setup in cruises
    select * from scores;
    select round(dbms_random.value(50, 100)) from dual;
    create sequence scores_seq start with 4;
    insert into scores(score_id, test_score) values (scores_seq.nextval,round(dbms_random.value(50, 100)));
    commit;
-- else is optional
select test_score,
        case
            when test_score >= 90 then 'A'
            when test_score >= 80 then 'B'
            when test_score >= 70 then 'C'
            when test_score >= 60 then 'D'
        end as
from scores;
          -- -----------------------------------------------------------------------------
          -- ETL BUSINESS LOGIC FROM TUITION DATA
          -- A.   Source Field:              tuition_staging.groupid
          --      Target Field No. 1:        tuition_etl.i_grouped  
          --                                  
          --                        if the string begins with '-'
          --                        then load 'Is Grouped' into TUITION_ETL.i_grouped
          --                        else load 'Not Grouped' into TUITION_ETL.i_grouped
          --                                   
          --      Target Field No. 2:        tuition_etl.i_group_id
          --
          --                        Remove the dash and insert this into TUITION_ETL.i_group_id
              select
                  case
                      when instr(groupid,'-',1,1)>0 then 'Is Grouped'
                      when instr(groupid,'-',1,1)=0 then 'Not Grouped'
                  end as I_GROUPED
                  ,case
                      when instr(groupid,'-',1,1)>0 
                              then substr(groupid,2)
                      when instr(groupid,'-',1,1)=0 
                              then groupid
                  end as I_GROUP_ID
              from tuition_staging;

-- -----------------------------------------------------------------------------
-- 5. CHAPTER 6 TO_DATE : converts string to date
-- to_date converts a string to a data using a user given format
select to_date('2016-JAN-01', 'YYYY-MON-DD') from dual;
select to_date('20160121', 'YYYYMMDD') from dual;
select to_date('21012016', 'DDMMYYYY') from dual;
-- Lets prove its a date
select   '2016-JAN-21' 
        , to_date('2016-JAN-21', 'YYYY-MON-DD') + 15
from dual;
          -- -----------------------------------------------------------------------------
          -- ETL BUSINESS LOGIC FROM TUITION DATA
          -- B.   Source Field:              tuition_staging.date_t  (date this school joined government program)
          --              date is given in 'YYYYMMD' format
          --      Target Field:              tuition_etl.date_joined
          select to_date(date_t,'YYYYMMDD') as I_DATE_JOINED 
          from tuition_staging;
-- -----------------------------------------------------------------------------
-- 6. CHAPTER 6 NVL, NVL2, NULLIF
-- -------------------------------------------------------
--  NVL(e1,e2)	      If e1 NULL, return e2 else returns e1
--  Substitute a value for null, and the replacement value must be same type as field compared
select shipdate from books.orders;
select orderdate, shipdate, nvl(shipdate, orderdate+45) from books.orders;
-- -------------------------------------------------------
--  NVL2(s1,r1,r2)	  If s1 NULL, return r2 else r1
--  Substitute a value for null, or another value if it is not null
select test_score, updated_test_score, NVL2(updated_test_score, updated_test_score, test_score)  from cruises.scores;
select nvl2('String','String2',null) from dual;
select nvl2(null,'String','String2') from dual;

-- -------------------------------------------------------
--  NULLIF(e1,e2)	    If e1=e2 return NULL else returns e1
--  Compare two values, and determine if they match or not
select nullif(12, 6) as testnullif from dual;
select nullif(6, 12) as testnullif from dual;
select nullif(12, 12) as testnullif from dual;
select nullif(23.000, 23) as testnullif from dual;
          -- -----------------------------------------------------------------------------
          -- ETL BUSINESS LOGIC FROM TUITION DATA
          -- C.  I_NAME
          --  Source Field No. 1 : tuition_staging.insttname              System of schools (University of California) never null
          --  Source Field No. 2:  tuition_staging.tcsname                Individual school name (Berkeley) sometimes null
          --  But will save the individual school name if given otherwise the system name 
          --  Target Field: If tuition_staging.tcsname is null 
          --                then load tuition_staging.instname into tuition_etl.i_name
          --                else load tuition_staging.tcsname into tuition_etl.i_name
          select tcsname School, instname Institution, nvl2(tcsname,tcsname,instname) as i_name
          from tuition_staging;

-- -----------------------------------------------------------------------------
-- 7. CHAPTER 6 DECODE
-- -------------------------------------------------------
select
        lastname
      , state
      , decode (state,
          'FL', 'Mouth East',
          'CA', 'West Coast',
          'ID', 'Mid West',
          'WA', 'West Coast',
          'NY', 'East Coast', 
          'TX', 'South',
          'WY', 'Mid West',
          'GA', 'South',
          'IL', 'Mid West') as Region
from books.customers;
          -- -----------------------------------------------------------------------------
          -- ETL BUSINESS LOGIC FROM TUITION DATA
          -- D.  I_TYPE                                             
          --  Source Field : tuition_staging.i_type              Type of Institution
          --        66	'STATE UNIVERSITY'
          --        48	'STATE COLLEGE'
          --        30	'STATE COMMUNITY COLLEGE'
          --        38	'LOCAL COMMUNITY COLLEGE'
          --        69	'PRIVATE JR COLLEGE'
          --        30	'PRIVATE'
          --  Target Field: If tuition_staging.i_type is 66 
          --                then load tuition_staging.i_type tuition_etl.i_name
          --                else load tuition_staging.tcsname into tuition_etl.i_type

          select type_inst, decode (type_inst,   
                          66,	'STATE UNIVERSITY',
                          48,	'STATE COLLEGE',
                          30,	'STATE COMMUNITY COLLEGE',
                          38,	'LOCAL COMMUNITY COLLEGE',
                          69,	'PRIVATE JR COLLEGE',
                          74,	'PRIVATE') as i_type                   
          from tuition_staging;
          -- -----------------------------------------------------------------------------
          -- More advanced inner query which is also a join : Chapter 9
          select type_inst,
                  (select type_name from school_type s where t.type_inst = s.type_id)
          from tuition_staging t;       
          -- -----------------------------------------------------------------------------
          -- ETL BUSINESS LOGIC FROM TUITION DATA
          -- E.  I_CITY  :  No change needed
--          Source Field : tuition_staging.city
--          Target Field : tuition_staging.i_city

--         concat or ||
-- -----------------------------------------------------------------------------
-- 8. CHAPTER 6 CONCAT of ||
-- -------------------------------------------------------
select firstname, lastname,  initcap(firstname) || ' ' || initcap(lastname) as fullname
from books.customers;

select * from books.books;
select * from books.bookauthor;
select * from books.author;

select title, concat('Written by: ',concat(initcap(fname), concat(' ', initcap(lname))))
from books b, bookauthor ba, author a
where b.isbn = ba.isbn
  and ba.authorid = a.authorid;

          -- -----------------------------------------------------------------------------
          -- ETL BUSINESS LOGIC FROM TUITION DATA
          -- F.  I_STATE  :  No change needed
          -- Source Field : tuition_staging.state
          -- Target Field : tuition_staging.i_state
          -- -----------------------------------------------------------------------------
          -- ETL BUSINESS LOGIC FROM TUITION DATA
          -- G.  I_STATE  :  Use lookup table to grab Region for new table
          -- Source Field:    states.region
          -- Target Field     tuition_etl.i_state
          select state from tuition_staging;
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
            from tuition_staging;

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
          -- Source Field : tuition_staging.Zip9
          -- Target Field No. 1 : tuition_etl.i_zip5              First 5 values
          -- Target Field No. 4 : tuition_etl.i_zip4              Last 4 values
          -- Target Field No. 2 : tuition_staging.insttname              System of schools (University of California) never null
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
            from tuition_staging;
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
          FROM tuition_staging;
-- -----------------------------------------------------------------------------
-- 10. CHAPTER 6 COALESCE : Take the first non null value
-- -------------------------------------------------------
select coalesce(null, 'Hello') from dual;
select coalesce(null, null, 'Hello') from dual;
select coalesce('Hey there', null, null, 'Hello') from dual;
          -- ETL BUSINESS LOGIC FROM TUITION DATA
          -- I.  I_PHONE  :  Take the first non null phone number in this order format target as (xxx) xxx-xxxx
          -- Source Field No. 1: tuition_staging.Work_ph
          -- Source Field No. 2: tuition_staging.Cell_ph
          -- Source Field No. 3: tuition_staging.Home_ph
          select 
            '(' || substr(coalesce(work_ph,cell_ph,home_ph),0,3)|| ') ' ||  
            substr(coalesce(work_ph,cell_ph,home_ph),4,3) || 
            '-' || 
            substr(coalesce(work_ph,cell_ph,home_ph),7)
          from tuition_staging;

-- -----------------------------------------------------------------------------
-- 11. CHAPTER 6 MATH from strings
--     If the string is actually a number just inside single ticks it will auto convert
-- -------------------------------------------------------       
-- Test math on strings
select local06, local06 + 1
from tuition_staging;
-- To accomplish the next three etl business logic steps from tuition data we need to add several columns
-- of tution assistance together. But is there is a null value in on of several the whole addition will be null
-- so first we have to convert nulls to 0's
select nvl(local06,0), nvl(local06,0) + 1
from tuition_staging;
          -- -----------------------------------------------------------------------------
          -- ETL BUSINESS LOGIC FROM TUITION DATA
          -- J.  I_AVG_LOCAL_HELP_PER_STUDENT  :  Avergage (local06, state_local_grant_contract) using fte_count to divide
          -- Source Field No. 1: tuition_staging.local06
          -- Source Field No. 2: tuition_staging.state_local_grant_contract
          -- Target Field tuition_etl.i_loc_pstudent
            select round((nvl(to_number(local06),0) +
                   to_number(nvl(state_local_grant_contract,0)))/fte_count,2) as i_loc_pstudent
            from tuition_staging;
          -- -----------------------------------------------------------------------------
          -- ETL BUSINESS LOGIC FROM TUITION DATA
          -- K.  I_AVG_STATE_HELP_PER_STUDENT  :  Average 
          --  Source Field No. 1: tuition_staging.state03
          --  Source field no. 2: tuition_staging.state06
          --  Source field no. 3: tuition_staging.state09
          --  Source field no. 4: tuition_staging.state_local_app
          --  Target field : tuition_etl.i_st_pstudent
            select round(
                  (
                      nvl(to_number(state03),0) + 
                      nvl(to_number(state_local_app),0) + 
                      nvl(to_number(state06),0) + 
                      nvl(to_number(state09),0)
                  )
                  /fte_count) as i_st_pstudent
            from tuition_staging;
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
          from tuition_staging;        
          -- -----------------------------------------------------------------------------
          -- ETL BUSINESS LOGIC FROM TUITION DATA
          -- M.  EXECUTE ETL 
          --      i.   Create the insert statement by copying all the logic down from above
          --      ii.  Next determine what field types and sizes are needed for tuition_etl (target table)
          --      iii. Create target table : tuition_etl
          --      iv.  Run the ETL
-- =============================================================================
--      i.   Create the insert statement by copying all the logic down from above
create sequence tuition_etl_seq;

insert into tuition_etl
( I_GROUP_PK        -- 1 
  ,I_Grouped        -- 2
  ,I_GROUP_ID       -- 3
  ,I_DATE_JOINED    -- 4
  ,I_NAME           -- 5
  ,I_TYPE           -- 6
  ,I_CITY           -- 7
  ,I_STATE          -- 8
  ,I_REGION         -- 9
  ,I_ZIP5           -- 10
  ,I_ZIP4           -- 11
  ,I_PHONE          -- 12
  ,I_LOC_PSTUDENT   -- 13
  ,I_ST_PSTUDENT    -- 14
  ,I_FED_PSTUDENT   -- 15
)
select  
      -- 1
      tuition_etl_seq.nextval as I_GROUP_PK
      -- 2
      ,case
          when instr(groupid,'-',1,1)>0 then 'Is Grouped'
          when instr(groupid,'-',1,1)=0 then 'Not Grouped'
      end as I_GROUPED
      -- 3
      ,case
          when instr(groupid,'-',1,1)>0 
                  then substr(groupid,2)
          when instr(groupid,'-',1,1)=0 
                  then groupid
      end as I_GROUP_ID
      -- 4
      ,to_date(date_t,'YYYYMMDD') as I_DATE_JOINED
      -- 5
      ,nvl2(TCSNAME,TCSNAME,INSTNAME) as I_NAME
      -- 6
      ,decode (type_inst,   
                        66,	'STATE UNIVERSITY',
                        48,	'STATE COLLEGE',
                        30,	'STATE COMMUNITY COLLEGE',
                        38,	'LOCAL COMMUNITY COLLEGE',
                        69,	'PRIVATE JR COLLEGE',
                        74,	'PRIVATE') as  I_TYPE
      -- 7
      ,city as I_CITY
      -- 8
      ,state as I_STATE
      -- 9
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
      end as I_REGION
      -- 10
      ,case
        when length(zip) = 9 
              and instr(zip,'-',1,1) = 0  
          then substr(zip,1,5)
        when length(zip) = 10
               and instr(zip,'-',1,1) > 0
          then substr(zip,1,5)
        when length(zip) = 5
          then zip
      end as I_ZIP5
      -- 11
      ,case
        when length(zip) = 9 
              and instr(zip,'-',1,1) = 0  
          then substr(zip,6,4)
        when length(zip) = 10
               and instr(zip,'-',1,1) > 0
          then substr(zip,7,4)
        when length(zip) = 5
          then null
      end as I_ZIP4
      -- 12
      , '(' || substr(coalesce(work_ph,cell_ph,home_ph),0,3)|| ') ' ||  
        substr(coalesce(work_ph,cell_ph,home_ph),4,3) || 
        '-' || 
        substr(coalesce(work_ph,cell_ph,home_ph),7) as I_PHONE
      -- 13
      ,round
       (
         (
            to_number(nvl(Local06,0)) 
            +
            to_number(nvl(State_local_grant_contract,0))
         )   
          / to_number(Fte_count)
        ,2) as I_LOC_PSTUDENT
       -- 14
       ,round
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
        ,2) as I_ST_PSTUDENT
       -- 15
        ,round
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
        as I_FED_PSTUDENT
from tuition_staging;  



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






