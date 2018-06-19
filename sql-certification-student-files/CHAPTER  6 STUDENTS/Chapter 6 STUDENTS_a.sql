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
--     2.  I_DATE_JOINED
--         to_date


-- -----------------------------------------------------------------------------
--     3.  I_NAME
--         nvl2  
-- 
--         If TCSNAME is null 
--         then load INSTNAME into T_STG.I_NAME
--         else load TCSNAME into T_STG.I_NAME
         

-- -----------------------------------------------------------------------------
--     4.  I_TYPE
--         decode
        select * from school_type;
        --TYPE 
        --66	'STATE UNIVERSITY'
        --48	'STATE COLLEGE'
        --30	'STATE COMMUNITY COLLEGE'
        --38	'LOCAL COMMUNITY COLLEGE'
        --69	'PRIVATE JR COLLEGE'
        --30	'PRIVATE'
        -- What is the problem below
        select decode (type_inst,
                      '66'	'STATE UNIVERSITY'
                      '48'	'STATE COLLEGE'
                      '30'	'STATE COMMUNITY COLLEGE'
                      '38'	'LOCAL COMMUNITY COLLEGE'
                      '69'	'PRIVATE JR COLLEGE'
                      '30'	'PRIVATE'
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
--         case when then end
--     
      --    If time permits    
      --    select state from tuition;
      --    select st from states;
--    What is wrong with the statement below extra commas? where?
      select 
          state,
              case
                when state in ('IL', 'IN','IA','KS','MI','MN','MS','NE','ND','OH','SD','WV') then 'Mid West',
                when state in ('CT','ME','MA','NH','NJ','NY','PA','RI','VT') then 'North East',
                when state in ('AK','AZ','CA','CO','HI','ID','MT','NV','NM','OR','UT','WA','WY') then 'West',
                when state in ('AL','AR','DE','FL','GA','KY','LA','MD','MO','NC','OK','SC','TN','TX','VA','WI') then 'South',
              end as
           region   
      from tuition;
      --    If time permits    
      --    select state from tuition;
      --    select st from states;
      
-- -----------------------------------------------------------------------------
--     7.  I_ZIP5 and I_ZIP4
--         length
--         substr

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
--         substr
--         coalesce
--         concatenate strings and dashes ''''
-- 
--          If TUITION.Work_ph not null load into T_STG.I_PHONE
--          else If TUITION.Cell_ph not null load into T_STG.I_PHONE
--          else If TUITION.Home_ph not null load int

      select 
            '''(' || substr(coalesce(work_ph,cell_ph,home_ph),0,3)|| ') ' ||  
            substr(coalesce(work_ph,cell_ph,home_ph),4,3) || 
            '-' || 
            substr(coalesce(work_ph,cell_ph,home_ph),7) || 
            ''''
        from tuition;
select * from tuition;
-- -----------------------------------------------------------------------------
--     9.  I_AVG_LOCAL_HELP_PER_STUDENT
--         round
--         to_number
--         nvl (to prevent null impacting math)
  
  select 
        round((nvl(to_number(local06),0)+to_number(nvl(state_local_grant_contract,0)))/fte_count,2) as AvgLocalHelpPerStudent
  from tuition;

-- -----------------------------------------------------------------------------
--    11.  I_AVG_FED_HELP_PER_STUDENT    
--         round
--         to_number
--         nvl (to prevent null impacting math)
--
        -- Copy pattern from question 9 using these fields
        --    Source No. 1: TUITION.State03
        --    Source No. 2: TUITION.State06
        --    Source No. 3: TUITION.State09
        --    Source No. 4: TUITION.State_local_app
        --    Source No. 5: TUITION.Fte_count
        --    Extract Logic: Round target to 2 places 
        --    Target No. 1: Place per student average into T_STG.I_AVG_STATE_HELP_PER_STUDENT   
  
select * from tuition; 
-- -----------------------------------------------------------------------------
--    11.  I_AVG_FED_HELP_PER_STUDENT    
--         round
--         to_number
--         nvl (to prevent null impacting math)
--
        -- Copy pattern from question 9 using these fields
        --    Source No. 1: TUITION.federal03
        --    Source No. 2: TUITION.federal07
        --    Source No. 3: TUITION.federal07_net_pell
        --    Source No. 4: TUITION.federal10
        --    Source No. 5: TUITION.federal10_net_pell
        --    Source No. 6: TUITION.Fte_count
        --    Extract Logic: Round target to 2 places 
        --    Target No. 1: Place per student average into T_STG.I_AVG_FED_HELP_PER_STUDENT
        
select * from tuition;
