
--  Source table: tuition_stg
--  Target table: tuition_etl
--  After you have transformed each column from tuition_stg
--  Create table tuiotion_etl
--      Determine data type by seeing results of your transformations
--      Determine data type size by seeing results of your transformations
--      size should be calculated 10% larger than largest tuition_stg text found
--  While inserting into target
--      remove any extra spaces while inserting into target
--      convert all names to Initial Capital letters


-- -----------------------------------------------------------------------------
-- ETL BUSINESS LOGIC FROM TUITION DATA
--    A. Source Field:              groupid
--       Target Field No. 1:        
--                          if the string begins with '-'
--                            then load 'Is Grouped' into grouped
--                            else load 'Not Grouped' into grouped
--      Target Field No. 2:  tuition_etl.i_group_id
--                            If dash, remove dash then insert this into school_id
 
delete tuition_etl;
drop sequence tuition_seq;   
create sequence tuition_seq;   
  -- insert -- insert -- insert -- insert -- insert -- insert -- insert -- insert --
  insert into tuition_etl (
       group_pk                                                               --  1 
      ,grouped                                                                --  2
      ,school_id                                                              --  3  
  )   
  select
       tuition_seq.nextval                                                    --  1 
      ,case                                                                   --  2 
          when instr(groupid,'-',1,1)>0 then 'Is Grouped'
          when instr(groupid,'-',1,1)=0 then 'Not Grouped'
       end as grouped
      ,case                                                                   --  3
          when instr(groupid,'-',1,1)>0                               
                  then substr(groupid,2)
          when instr(groupid,'-',1,1)=0 
                  then groupid
       end as group_id
  from tuition_stg;
  
  select * from tuition_etl;

-- -----------------------------------------------------------------------------
-- ETL BUSINESS LOGIC FROM TUITION DATA
-- B.   Source Field:              date_joined 'DDMMYYYY'
--      Target Field:              date_joined
  delete tuition_etl;
  
  drop sequence tuition_seq;   
  create sequence tuition_seq;   
  
  insert into tuition_etl (
        group_pk                                                              --  1 
      ,date_joined                                                            --  4 
  )  
  select 
        tuition_seq.nextval
      ,to_date(date_joined,'yyyymmdd') as date_joined
  from tuition_stg;
  
  select * from tuition_etl;
    select to_date(date_joined,'yyyymmdd'), to_date(date_joined,'yyyymmdd') + (365*10) from tuition_stg;
    
    
-- -----------------------------------------------------------------------------
-- ETL BUSINESS LOGIC FROM TUITION DATA
-- C.   Schnool Name
--      Source Field No. 1 : institution_name is never null
--      Source Field No. 2:  campus_name  sometimes null
--      Target Field:        institution_name
--                            If campus_name is null 
--                              then load institution_name
--                              else load campus_name

  drop sequence tuition_seq;   
  create sequence tuition_seq;   
  delete tuition_etl;
  select * from tuition_etl;
  -- insert -- insert -- insert -- insert -- insert -- insert -- insert -- insert --
  insert into tuition_etl (
        group_pk                                                              --  1 
      ,school_name                                                            --  5 
  )  
  select 
        tuition_seq.nextval
      ,trim(initcap(nvl2(institution_name,institution_name,campus_name)))     --  5 
  from tuition_stg;
  select * from tuition_etl;
  
  
  select * from tuition_etl;       

-- -----------------------------------------------------------------------------
-- ETL BUSINESS LOGIC FROM TUITION DATA
-- D.  school_type                                             
--      Source Field:   type_inst
--      Target Field:        institution_name
--
--      Type of Institution
--        66	'STATE UNIVERSITY'
--        48	'STATE COLLEGE'
--        30	'STATE COMMUNITY COLLEGE'
--        38	'LOCAL COMMUNITY COLLEGE'
--        69	'PRIVATE JR COLLEGE'
--        30	'PRIVATE'

  drop sequence tuition_seq;   
  create sequence tuition_seq;   
  delete tuition_etl;
  select * from tuition_etl;
-- insert -- insert -- insert -- insert -- insert -- insert -- insert -- insert --
  insert into tuition_etl (
        group_pk                                                              --  1 
      ,school_type                                                            --  6 
  )  
  select tuition_seq.nextval                                                  --  1
        , initcap(
            decode (type_inst,                                                --  6
                  66,	'STATE UNIVERSITY',
                  48,	'STATE COLLEGE',
                  30,	'STATE COMMUNITY COLLEGE',
                  38,	'LOCAL COMMUNITY COLLEGE',
                  69,	'PRIVATE JR COLLEGE',
                  74,	'PRIVATE',
                  84,	'MILITARY')
            ) as school_type                   
  from tuition_stg;
  
  delete tuition_etl;
  select * from tuition_etl;
-- -----------------------------------------------------------------------------
-- ETL BUSINESS LOGIC FROM TUITION DATA
-- E.  city  :  No transformation needed
--              Source Field : city
--              Target Field : city
  drop sequence tuition_seq;   
  create sequence tuition_seq;   
  delete tuition_etl;
  select * from tuition_etl;
  
-- insert -- insert -- insert -- insert -- insert -- insert -- insert -- insert --
  insert into tuition_etl (
        group_pk                                                              --  1 
      ,city                                                                   --  7 
  )  
  select tuition_seq.nextval                                                  --  1
        , initcap(trim(city)) as city                                         --  7 
  from tuition_stg;
  
  delete tuition_etl;
  select * from tuition_etl;


-- -----------------------------------------------------------------------------
-- ETL BUSINESS LOGIC FROM TUITION DATA
-- F.  state
--      Source Field: state
--      Target Field No. 1:  state
--      Target Field No. 2:  region use the states table to determine region
  drop sequence tuition_seq;   
  create sequence tuition_seq;   
  delete tuition_etl;
  select * from tuition_etl;
 -- insert -- insert -- insert -- insert -- insert -- insert -- insert -- insert -- 
  insert into tuition_etl (
       group_pk                                                               --  1 
      ,state                                                                  --  8 
      ,region                                                                 --  9 
  )  
  
  select tuition_seq.nextval                                                  --  1
                ,state                                                        --  8 
                ,case                                                         --  9 
                  when state in ('IL','IN','IA','KS','MI','MN','MS','NE','ND','OH','SD','WV') 
                       then 'Midwest'
                  when state in ('AL','AR','DE','FL','GA','KY','LA','MD',
                                 'MO','NC','OK','SC','TN','TX','VA','WI')
                       then 'South'
                  when state in ('AK','AZ','CA','CO','HI','ID','MT','NV','NM','OR','UT','WA','WY')     
                       then 'West'
                  when state in ('CT','ME','MA','NH','NJ','NY','PA','RI','VT')
                       then 'North East'
                end as region
            from tuition_stg;

  delete tuition_etl;
  select * from tuition_etl;


-- -----------------------------------------------------------------------------
-- ETL BUSINESS LOGIC FROM TUITION DATA
-- H.  I_ZIP  :  Convert from variuos zip formats int zip5 and zip4
-- Source Field : zip
-- Target Field No. 1 : zip5              First 5 values
-- Target Field No. 4 : zip4              Last 4 values

desc tuition_stg;
select length(trim(zip)), trim(zip) from tuition_stg order by 1;

select institution_name from tuition_stg;
update tuition_stg set zip = '  31021-017' where ziptype = 9;       

      
  insert into tuition_etl (
       group_pk                                                               --  1 
      ,zip5                                                                   --  10 
      ,zip4                                                                   --  11 
  )        
    select 
           tuition_seq.nextval                                                --  1
          ,case  
                when length(trim(zip)) = 4                                    -- Field 10     
                      then substr(trim(zip),1,4) || '0'                       -- ZipType 1
                when length(trim(zip)) = 5 then substr(trim(zip),1,5)         -- ZipType   2
                when length(trim(zip)) = 9                                    -- ZipType   3
                          and instr(trim(zip), '-',1,1) = 0                               
                          and instr(trim(zip), ' ', 1, 1)  = 0
                      then substr(trim(zip),1,5)
                when length(trim(zip)) = 10                                   --  ZipType  4 & 7
                          and (
                                instr(trim(zip), '-',1,1) = 6  
                                or  instr(trim(zip), ' ',1,1) = 6
                              )                                                            
                      then substr(trim(zip),1,5)                           
                when length(trim(zip)) = 9                                    -- ZipType   5
                          and instr(trim(zip), ' ',1,1) = 5                               
                      then substr(trim(zip),1,4)  || '0'       
                
                when length(trim(zip)) = 9                                    -- ZipType   6
                          and instr(trim(zip), ' ', 1, 1)  = 6
                      then substr(trim(zip),1,5)
                      
                when length(trim(zip)) = 9                                    -- ZipType   8
                          and instr(trim(zip), '-',1,1) = 5                               
                      then substr(trim(zip),1,4) || '0'      

                when length(trim(zip)) = 9                                    -- ZipType   9
                          and instr(trim(zip), '-', 1, 1)  = 6
                      then substr(trim(zip),1,5) 
          end as zip5
          
          ,case                                                               -- Field 11
                when length(trim(zip)) = 9                                    --   ZipType 3
                          and instr(trim(zip), '-',1,1) = 0                               
                          and instr(trim(zip), ' ', 1, 1)  = 0
                      then substr(trim(zip),6)
                when length(trim(zip)) = 10                                   --   ZipType 4 & 7
                          and (
                                instr(trim(zip), '-',1,1) = 6  
                                or  instr(trim(zip), ' ',1,1) = 6
                              )                                                            
                      then substr(trim(zip),7)                           

                when length(trim(zip)) = 9                                    --   ZipType 5
                          and instr(trim(zip), ' ',1,1) = 5                               
                      then substr(trim(zip),6)       

                
                when length(trim(zip)) = 9                                    --   ZipType 6
                          and instr(trim(zip), ' ', 1, 1)  = 6
                      then substr(trim(zip),7) || '0'

                      
                when length(trim(zip)) = 9                                    --   ZipType 8
                          and instr(trim(zip), '-',1,1) = 5                               
                      then substr(trim(zip),6)      

                when length(trim(zip)) = 9                                    --  ZipType  9
                          and instr(trim(zip), '-', 1, 1)  = 6
                      then substr(trim(zip),7)||'0'

          end as zip4                            
      from tuition_stg;

delete tuition_etl;
select * from tuition_etl;

-- ETL BUSINESS LOGIC FROM TUITION DATA
-- I.  phone  :  Take least private phone number and convert to format (555) 555-5555
-- Source Fields: work_ph, cell_ph, home_ph
-- Target Field No. 1: 
delete tuition_etl;
select * from tuition_etl;

  insert into tuition_etl (
       group_pk                                                               --  1 
      ,phone                                                                  --  12 
  )        
  select 
        tuition_seq.nextval                     
        , '(' || substr(coalesce(work_ph,cell_ph,home_ph),0,3)|| ') ' ||  --  12 
            substr(coalesce(work_ph,cell_ph,home_ph),4,3) || 
            '-' || 
            substr(coalesce(work_ph,cell_ph,home_ph),7)
 from tuition_stg;

select * from tuition_etl;
delete tuition_etl;


-- -----------------------------------------------------------------------------
-- ETL BUSINESS LOGIC FROM TUITION DATA
-- J.  avg_local_help_per_student:  
--      Source Fields local06, state_local_grant_contract, fte_count (full time enrollment)
--      Target Field avg_local_help_per_student
delete tuition_etl;
select * from tuition_etl;            
  insert into tuition_etl (
      group_pk                                                                --  1 
      ,      avg_local_help_per_student                                       --  13 
  )        
  select 
         tuition_seq.nextval
        , round((nvl(to_number(local06),0) +                                  --  13
              to_number(nvl(state_local_grant_contract,0)))
              /fte_count,2) as avg_local_help_per_student
  from tuition_stg;
select * from tuition_etl;
delete tuition_etl;
-- -----------------------------------------------------------------------------
-- ETL BUSINESS LOGIC FROM TUITION DATA
-- K.  avg_state_help_per_student:  Average 
--  Source Fields: state03, state06, state09, state_local_app, fte_count
--  Target field : avg_state_help_per_student

  delete tuition_etl;
  select * from tuition_etl;            
  insert into tuition_etl (
      group_pk                                                                --  1 
      ,  avg_state_help_per_student                                           --  14 
  )     
        select 
              tuition_seq.nextval
            , round(                                                         --  14 
              (
                  nvl(to_number(state03),0) +
                  nvl(to_number(state_local_app),0) + 
                  nvl(to_number(state06),0)  +
                  nvl(to_number(state09),0)
              )
              /fte_count) as avg_state_help_per_student
        from tuition_stg;
        
    select * from tuition_etl;  
    delete tuition_etl;
      
        
-- -----------------------------------------------------------------------------
-- ETL BUSINESS LOGIC FROM TUITION DATA
-- L. avg_fed_help_per_student  :  Avergage (federal03, federal07,federal07_net_pell,federal10,federal10_net_pell,,) using fte_count to divide
--    Target Field avg_fed_help_per_student
  delete tuition_etl;
  select * from tuition_etl;            
  insert into tuition_etl (
      group_pk                                                                --  1 
      ,  avg_fed_help_per_student                                             --  15 
    )     
   select tuition_seq.nextval
         , round((nvl(to_number(federal03),0) +                              --  15 
         nvl(to_number(federal07),0) + 
         nvl(to_number(federal07_net_pell),0) + 
         nvl(to_number(federal10),0) + 
         nvl(to_number(federal10_net_pell),0))/ fte_count) as avg_fed_help_per_student
  from tuition_stg;        
  delete tuition_etl;
  select * from tuition_etl;          
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
      tuition_etl_seq.nextval as I_GROUP_PK                   -- 1
      ,case                                                   -- 2
          when instr(groupid,'-',1,1)>0 then 'Is Grouped'
          when instr(groupid,'-',1,1)=0 then 'Not Grouped'
      end as I_GROUPED
     ,case                                                   -- 3
          when instr(groupid,'-',1,1)>0 
                  then substr(groupid,2)
          when instr(groupid,'-',1,1)=0 
                  then groupid
      end as I_GROUP_ID
      
--      ,to_date(date_joined,'dd-mm-rr') as I_DATE_JOINED           --       4
      ,nvl2(campus_name,campus_name,institution_name) as  I_NAME              --  5
--      ,decode (type_inst,                                     -- 6
--                        66,	'STATE UNIVERSITY',
--                        48,	'STATE COLLEGE',
--                        30,	'STATE COMMUNITY COLLEGE',
--                        38,	'LOCAL COMMUNITY COLLEGE',
--                        69,	'PRIVATE JR COLLEGE',
--                        74,	'PRIVATE') as  I_TYPE
--     
--      ,city as I_CITY                                         -- 7
--      ,state as I_STATE                                       -- 8
      /*
      ,case                                                   -- 9
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
      ,case                                                       -- 10
        when length(zip) = 9 
              and instr(zip,'-',1,1) = 0  
          then substr(zip,1,5)
        when length(zip) = 10
               and instr(zip,'-',1,1) > 0
          then substr(zip,1,5)
        when length(zip) = 5
          then zip
      end as I_ZIP5
      ,case                                                       -- 11
        when length(zip) = 9 
              and instr(zip,'-',1,1) = 0  
          then substr(zip,6,4)
        when length(zip) = 10
               and instr(zip,'-',1,1) > 0
          then substr(zip,7,4)
        when length(zip) = 5
          then null
      end as I_ZIP4
      , '(' || substr(coalesce(work_ph,cell_ph,home_ph),0,3)|| ') ' ||  -- 12
        substr(coalesce(work_ph,cell_ph,home_ph),4,3) || 
        '-' || 
        substr(coalesce(work_ph,cell_ph,home_ph),7) as I_PHONE
      ,round                                                            -- 13
       (
         (
            to_number(nvl(Local06,0)) 
            +
            to_number(nvl(State_local_grant_contract,0))
         )   
          / to_number(Fte_count)
        ,2) as I_LOC_PSTUDENT
        ,round                                                      -- 14
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
      
--        ,round                                                  -- 15
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
*/
from tuition;  

-- =============================================================================
drop table tuition_etl;
create table tuition_etl
( I_GROUP_PK      integer primary key,
  I_Grouped       char(15),
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















