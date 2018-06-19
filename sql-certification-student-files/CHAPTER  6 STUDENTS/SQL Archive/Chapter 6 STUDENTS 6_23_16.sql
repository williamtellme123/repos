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
--            instr
--            substr
--            case when (boolean expression like where clause) then [else] end
select * from tuition;
--      1.  I_GROUPED   and   I_GROUP_ID
--          Source: TUITION.GroupID
--          Extract Logic: 
--          Target No. 1: if the string begins with '-'
--                        then load 'Is Grouped' into T_STG.I_Grouped
--                        else load 'Not Grouped' into T_STG.I_Grouped
--          Target No. 2: load the ID without the dash into T_STG.I_GROUP_ID



select length(groupid) from tuition order by 1 desc;  


select groupid from tuition;
select instr(groupid,'-',1,1) from tuition;
select instr('HONOLULU','O',-1,1) from dual;

select substr('APPLE',1,3) from dual;
select substr('-6767',2) as I_GROUP_ID from dual;

select
        case
            when instr(groupid,'-',1,1)>0 then 'Is Grouped'
            when instr(groupid,'-',1,1)=0 then 'Not Grouped'
        end as
    I_GROUPED,
        case
            when instr(groupid,'-',1,1)>0 
                    then substr(groupid,2)
            when instr(groupid,'-',1,1)=0 
                    then groupid
        end as 
    I_GROUP_ID
from tuition;

-- -----------------------------------------------------------------------------        
--     2.  I_DATE_JOINED
--         to_date

select date_t from tuition;

select to_date(date_t,'YYYYMMDD') as I_DATE_JOINED 
from tuition;

--Source No. 1: TUITION.Date 
--          Extract Logic:  is given in 'YYYYMMD' format
--                          transform to date
--          Target No. 1: T_STG.I_DATE_JOINED



-- -----------------------------------------------------------------------------
--     3.  I_NAME
--         nvl2  
-- 
--          Source No.1: TUITION.Insttname
--          Source No. 2: TUITION.Tcsname
--          Extract Logic:
--          Target No. 1: If TCSNAME is null 
--                        then load INSTNAME into T_STG.I_NAME
--                        else load TCSNAME into T_STG.I_NAME



select length(instname),
        length(tcsname)
from tuition
order by 1 desc, 2 desc;

select * from tuition;
-- NVL2(s1,r1,r2)
-- If s1 has a value of NULL, NVL2 returns a value for r2, otherwise returns r1.
-- If s1 has a value of NULL, NVL2 returns a value for r2, otherwise returns r1.

select nvl2('String','String2',null) from dual;
select nvl2(null,'String','String2') from dual;

select nvl2(TCSNAME,TCSNAME,INSTNAME) as I_NAME
from tuition;

-- -----------------------------------------------------------------------------
--     4.  I_TYPE
--         decode
        -- TYPE 
        --66	'STATE UNIVERSITY'
        --48	'STATE COLLEGE'
        --30	'STATE COMMUNITY COLLEGE'
        --38	'LOCAL COMMUNITY COLLEGE'
        --69	'PRIVATE JR COLLEGE'
        --30	'PRIVATE'




select decode (type_inst,   
                          66,	'STATE UNIVERSITY',
                          48,	'STATE COLLEGE',
                          30,	'STATE COMMUNITY COLLEGE',
                          38,	'LOCAL COMMUNITY COLLEGE',
                          69,	'PRIVATE JR COLLEGE',
                          74,	'PRIVATE') as
       I_TYPE                   
from tuition;
-- -----------------------------------------------------------------------------
select * from tuition;
-- type_inst
select * from school_type;
-- type_id

select type_inst,type_name
from tuition t, 
     school_type s
where t.type_inst = s.type_id; 

select type_inst,
        (select type_name from school_type s where t.type_inst = s.type_id)
from tuition t; 

select * from school_type;        
select * from tuition;

        --      If time permits
        --      select type_inst from tuition;
        --      select type_id from school_type;
-- -----------------------------------------------------------------------------
--     5.  I_CITY
select city as I_CITY
from tuition;


select length(city) from tuition order by 1 desc;
-- -----------------------------------------------------------------------------
--     6.  I_STATE   and     I_REGION
--         case when then end
--         concat or ||
--     
--          Source No. 1: TUITION.State
--          Source No. 2: STATES.Region
--          Extract Logic:          
--          Target No. 1: load matching STATES.Region into T_STG.I_REGION
--          Target No. 2: load T_STG.I_STATE
--




select state from tuition;

select unique '''' || region || '''' from states;
--'Midwest'
--'South'
--'West'
--'North East'

select '''' || st || ''''
from states
where region = 'West';

select
    state as
  I_STATE,
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
  I_REGION
from tuition;

-- -----------------------------------------------------------------------------
--     7.  I_ZIP5 and I_ZIP4
--         length
--         substr
--
--         DATA VALIDATION Group says to expect 3 valid zip9 formats
-- 




  
select zip from tuition;            
--         length
--         substr
--         case

select instr('HONOLULU','O',1,1) from dual;
select instr('HONOLULU','O',1,2) from dual;
select instr('HONOLULU','O',-1,2) from dual;
select substr('HONOLULU',4) from dual;
Select instr(zip, '-',1,1) 
from tuition
where instr(zip, '-',1,1) > 0;

select case
          when instr(zip, '-',1,1) > 0 then substr(zip,1,5)
       end as
     I_ZIP5  
from tuition
where instr(zip, '-',1,1) > 0;

select case
          when 'APPLE' != 'APPLE' then 'YUM'
          else 'Yech'
       end
from dual;       

select zip,
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
   I_ZIP5 
from tuition;

-- start Wednesday with zip4

--         555554444
--         55555-4444
--         55555






commit;      
      
-- -----------------------------------------------------------------------------
--     8.  I_PHONE
--         substr
--         coalesce
--         concatenate strings and dashes ''''
-- 
--          If TUITION.Work_ph not null load into T_STG.I_PHONE
--          else If TUITION.Cell_ph not null load into T_STG.I_PHONE
--          else If TUITION.Home_ph not null load into T_STG.I_PHONE
--          else load null into T_STG.I_PHONE        




select * from tuition;
-- -----------------------------------------------------------------------------
--     9.  I_AVG_LOCAL_HELP_PER_STUDENT
--         round
--         to_number
--         nvl (to prevent null impacting math

--          I_AVG_LOCAL_HELP_PER_STUDENT
--          Source No. 1: TUITION.Local06
--          Source No. 2: TUITION.State_local_grant_contract
--          Source No. 3: TUITION.Fte_count
--          Extract Logic: Round target to 2 places 
--          Target No. 1: Place per student average into T_STG.I_AVG_LOCAL_HELP_PER_STUDENT



select  to_number(nvl(Local06,0))
      ,  to_number(nvl(State_local_grant_contract,0))
      ,  to_number(Fte_count)
      ,  round
         (
           (
              to_number(nvl(Local06,0)) 
              +
              to_number(nvl(State_local_grant_contract,0))
           )   
            / to_number(Fte_count)
          ,2) as LocalSupportPerStudent
-- (Local06 + State_local_grant_contract)  /   fte_count
from tuition;



select * from tuition;
-- -----------------------------------------------------------------------------
--    10.  I_AVG_STATE_HELP_PER_STUDENT
--         round
--         to_number
--         nvl (to prevent null impacting math

        -- Copy pattern from question 9 using these fields
        --    Source No. 1: TUITION.State03
        --    Source No. 2: TUITION.State06
        --    Source No. 3: TUITION.State09
        --    Source No. 4: TUITION.State_local_app
        --    Source No. 5: TUITION.Fte_count
        --    Extract Logic: Round target to 2 places 
        --    Target No. 1: Place per student average into T_STG.I_AVG_STATE_HELP_PER_STUDENT  
 
 select
         State03
        , State06
        , State09
        , State_local_app 
        , fte_count

        , round
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
          ,2) as abc
from tuition;   


 select * from tuition; 
-- -----------------------------------------------------------------------------
--    11.  I_AVG_FED_HELP_PER_STUDENT    
--         round
--         to_number
--         nvl (to prevent null impacting math

        -- Copy pattern from question 9 using these fields
        --    Source No. 1: TUITION.federal03
        --    Source No. 2: TUITION.federal07
        --    Source No. 3: TUITION.federal07_net_pell
        --    Source No. 4: TUITION.federal10
        --    Source No. 5: TUITION.federal10_net_pell
        --    Source No. 6: TUITION.Fte_count
        --    Extract Logic: Round target to 2 places 
        --    Target No. 1: Place per student average into T_STG.I_AVG_FED_HELP_PER_STUDENT
select round
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
          as abc
from tuition;


        
select * from tuition;

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
    
    
select work_ph,cell_ph,home_ph
from tuition;

    
select I_PHONE 
from tuition_etl;


select
'(' || substr(coalesce(work_ph,cell_ph,home_ph),0,3)|| ') ' ||  
          substr(coalesce(work_ph,cell_ph,home_ph),4,3) || 
          '-' || 
          substr(coalesce(work_ph,cell_ph,home_ph),7) as
   I_PHONE
from tuition;   

-- =================================
-- Here is what we are doing
create table temp
(customer#   integer,
 firstname   varchar2(25),
 lastname    varchar2(25));
 
insert into temp
(
  customer#,
  firstname,
  lastname)
select 
  customer#,
  firstname,
  lastname
from books.customers; 

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
        