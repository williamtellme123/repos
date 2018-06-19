-- =============================================================================
-- TUITION TABLE

    drop table tuition_stg;
    create table tuition_stg (	
        groupid	varchar2(500),
        date_joined	varchar2(500),
        institution_name	varchar2(500),
        campus_name	varchar2(500),
        type_inst varchar2(500),
        city	varchar2(500),
        state	varchar2(500),
        zip	varchar2(500),
        ziptype	integer,
        work_ph	varchar2(500),
        cell_ph	varchar2(500),
        home_ph	varchar2(500),
        fte_count	varchar2(500),
        net_student_tuition	varchar2(500),
        federal03	varchar2(500),
        state03	varchar2(500),
        state_local_app	varchar2(500),
        federal07	varchar2(500),
        federal07_net_pell	varchar2(500),
        state06	varchar2(500),
        local06	varchar2(500),
        state_local_grant_contract	varchar2(500),
        federal10	varchar2(500),
        federal10_net_pell	varchar2(500),
        state09	varchar2(500),
        fed_state_loc_grants_con	varchar2(500),
        private03	varchar2(500),
        endowment03	varchar2(500),
        priv_invest_endow	varchar2(500),
        auxother_rev	varchar2(500),
        stable_operating_rev	varchar2(500),
        total03_revenue	varchar2(500)
    );	

delete tuition_stg;
commit;


select * from tuition_stg;
 
select groupid, ziptype, trim(zip), length(trim(zip)) from tuition_stg
order by 2;

          

drop table tuition_etl;
create table tuition_etl
( group_pk                integer primary key,    --  1
  grouped                 char(15),               --  2
  school_id                char(6),                --  3
  date_joined             date,                   --  4
  school_name             varchar2(55),           --  5 
  school_type             varchar2(25),           --  6
  city                    varchar2(15),           --  7
  state                   char(2),                --  8
  region                  varchar2(11),           --  9
  zip5                    char(5),                -- 10
  zip4                    char(4),                -- 11
  phone                   char(16),               -- 12
  avg_local_help_per_student     number(12,2),    -- 13
  avg_state_help_per_student     number(12,2),      -- 14
  avg_fed_help_per_student number(12,2)           -- 15
);



-- =============================================================================
-- STATES TABLE
drop table states;
create table states
( st_id integer primary key, 
  state varchar2(20),
  st    char(2),
  region varchar2(15));
insert into states values ('1', 'Alabama', 'AL', 'South');
insert into states values ('2', 'Alaska', 'AK', 'West');
insert into states values ('3', 'Arizona', 'AZ', 'West');
insert into states values ('4', 'Arkansas', 'AR', 'South');
insert into states values ('5', 'California', 'CA', 'West');
insert into states values ('6', 'Colorado', 'CO', 'West');
insert into states values ('7', 'Connecticut', 'CT', 'North East');
insert into states values ('8', 'Delaware', 'DE', 'South');
insert into states values ('9', 'Florida', 'FL', 'South');
insert into states values ('10', 'Georgia', 'GA', 'South');
insert into states values ('11', 'Hawaii', 'HI', 'West');
insert into states values ('12', 'Idaho', 'ID', 'West');
insert into states values ('13', 'Illinois', 'IL', 'Midwest');
insert into states values ('14', 'Indiana', 'IN', 'Midwest');
insert into states values ('15', 'Iowa', 'IA', 'Midwest');
insert into states values ('16', 'Kansas', 'KS', 'Midwest');
insert into states values ('17', 'Kentucky', 'KY', 'South');
insert into states values ('18', 'Louisiana', 'LA', 'South');
insert into states values ('19', 'Maine', 'ME', 'North East');
insert into states values ('20', 'Maryland', 'MD', 'South');
insert into states values ('21', 'Massachusetts', 'MA', 'North East');
insert into states values ('22', 'Michigan', 'MI', 'Midwest');
insert into states values ('23', 'Minnesota', 'MN', 'Midwest');
insert into states values ('24', 'Mississippi', 'MO', 'South');
insert into states values ('25', 'Missouri', 'MS', 'Midwest');
insert into states values ('26', 'Montana', 'MT', 'West');
insert into states values ('27', 'Nebraska', 'NE', 'Midwest');
insert into states values ('28', 'Nevada', 'NV', 'West');
insert into states values ('29', 'New Hampshire', 'NH', 'North East');
insert into states values ('30', 'New Jersey', 'NJ', 'North East');
insert into states values ('31', 'New Mexico', 'NM', 'West');
insert into states values ('32', 'New York', 'NY', 'North East');
insert into states values ('33', 'North Carolina', 'NC', 'South');
insert into states values ('34', 'North Dakota', 'ND', 'Midwest');
insert into states values ('35', 'Ohio', 'OH', 'Midwest');
insert into states values ('36', 'Oklahoma', 'OK', 'South');
insert into states values ('37', 'Oregon', 'OR', 'West');
insert into states values ('38', 'Pennsylvania', 'PA', 'North East');
insert into states values ('39', 'Rhode Island', 'RI', 'North East');
insert into states values ('40', 'South Carolina', 'SC', 'South');
insert into states values ('41', 'South Dakota', 'SD', 'Midwest');
insert into states values ('42', 'Tennessee', 'TN', 'South');
insert into states values ('43', 'Texas', 'TX', 'South');
insert into states values ('44', 'Utah', 'UT', 'West');
insert into states values ('45', 'Vermont', 'VA', 'North East');
insert into states values ('46', 'Virginia', 'VT', 'South');
insert into states values ('47', 'Washington', 'WA', 'West');
insert into states values ('48', 'West Virginia', 'WI', 'South');
insert into states values ('49', 'Wisconsin', 'WV', 'Midwest');
insert into states values ('50', 'Wyoming', 'WY', 'West');
commit;
-- =============================================================================
-- SCHOOL_TYPE TABLE
drop table school_type;
create table school_type
( type_id   integer primary key,
  type_name  varchar2(25));
insert into school_type values (66,	'STATE UNIVERSITY');
insert into school_type values (48,	'STATE COLLEGE');
insert into school_type values (30,	'STATE COMMUNITY COLLEGE');
insert into school_type values (38,	'LOCAL COMMUNITY COLLEGE');
insert into school_type values (69,	'PRIVATE JR COLLEGE');
insert into school_type values (74,	'PRIVATE');
insert into school_type values (84,	'MILITARY');
commit;

-- ETL
-- 1. Create stage table using character fields
-- 2. Load source into this stage table
-- 3. With each source field
--        clarify business transformation logic
--        write test sql to transform source to target data
-- 4. Place all single column tests into 1 big SQL statement
-- 5. Use output from each transformed source column to type target column
-- 6. Create internal table with correct data types
-- 7. Insert into target using select from source with transformations from chapter 6 


select * from tuition;
select * from states;
select * from school_type;

          -- ETL BUSINESS LOGIC FROM TUITION DATA
          -- C.  I_NAME
          --  Source Field No. 1 : tuition.insttname              System of schools (University of California) never null
          --  Source Field No. 2:  tuition.tcsname                Individual school name (Berkeley) sometimes null
          --  But will save the individual school name if given otherwise the system name 
          --  Target Field: If tuition.tcsname is null 
          --                then load tuition.instname into tuition_etl.i_name
          --                else load tuition.tcsname into tuition_etl.i_name
          
            -- -----------------------------------------------------------------------------
          -- ETL BUSINESS LOGIC FROM TUITION DATA
          -- D.  I_TYPE                                             
          --  Source Field : tuition.i_type              Type of Institution
          --        66	'STATE UNIVERSITY'
          --        48	'STATE COLLEGE'
          --        30	'STATE COMMUNITY COLLEGE'
          --        38	'LOCAL COMMUNITY COLLEGE'
          --        69	'PRIVATE JR COLLEGE'
          --        30	'PRIVATE'
          --  Target Field: If tuition.i_type is 66 
          --                then load tuition.i_type tuition_etl.i_name
          --                else load tuition.tcsname into tuition_etl.i_type
            -- -----------------------------------------------------------------------------
          -- ETL BUSINESS LOGIC FROM TUITION DATA
          -- E.  I_CITY  :  No change needed
--          Source Field : tuition.city
--          Target Field : tuition.i_city
 -- -----------------------------------------------------------------------------
          -- ETL BUSINESS LOGIC FROM TUITION DATA
          -- F.  I_STATE  :  No change needed
          -- Source Field : tuition.state
          -- Target Field : tuition.i_state
          -- -----------------------------------------------------------------------------
          -- ETL BUSINESS LOGIC FROM TUITION DATA
          -- G.  I_STATE  :  Use lookup table to grab Region for new table
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
          -- ETL BUSINESS LOGIC FROM TUITION DATA
          -- J.  I_AVG_LOCAL_HELP_PER_STUDENT  :  Avergage (local06, state_local_grant_contract) using fte_count to divide
          -- Source Field No. 1: tuition.local06
          -- Source Field No. 2: tuition.state_local_grant_contract
          -- Target Field tuition_etl.i_loc_pstudent

 -- ETL BUSINESS LOGIC FROM TUITION DATA
          -- K.  I_AVG_STATE_HELP_PER_STUDENT  :  Average 
          --  Source Field No. 1: tuition.state03
          --  Source field no. 2: tuition.state06
          --  Source field no. 3: tuition.state09
          --  Source field no. 4: tuition.state_local_app
          --  Target field : tuition_etl.i_st_pstudent