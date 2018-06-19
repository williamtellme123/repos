
drop sequence tuition_seq;   
create sequence tuition_seq; 
delete from tuition_etl;
select * from tuition_etl;
insert into tuition_etl
(
        group_pk
      , grouped
      , school_id
      , date_joined
      , school_name
      , school_type
      , city
      , state
      , region
      , zip5
      , zip4
      , phone
      , avg_local_help_per_student
      , avg_state_help_per_student
      , avg_fed_help_per_student
)
select 
       tuition_seq.nextval                                                    --  1 
      , case                                                                  --  2 
          when instr(groupid,'-',1,1)>0 then 'Is Grouped'
          when instr(groupid,'-',1,1)=0 then 'Not Grouped'
        end as grouped
      , case                                                                   --  3
          when instr(groupid,'-',1,1)>0                               
                  then substr(groupid,2)
          when instr(groupid,'-',1,1)=0 
                  then groupid
        end as group_id
      , to_date(date_joined,'yyyymmdd') as date_joined                        -- 4
      , trim(initcap(nvl2(institution_name,institution_name,campus_name)))    --  5
      , decode (type_inst,                                                -- 6
                  66,	'STATE UNIVERSITY',
                  48,	'STATE COLLEGE',
                  30,	'STATE COMMUNITY COLLEGE',
                  38,	'LOCAL COMMUNITY COLLEGE',
                  69,	'PRIVATE JR COLLEGE',
                  74,	'PRIVATE',
                  84,	'MILITARY')
             as school_type 
      , initcap(trim(city)) as city                                           --  7 
      , state                                                                 --  8 
      , case                                                                  --  9 
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
        , case  
                when length(trim(zip)) = 4                                    -- 10     
                      then substr(trim(zip),1,4) || '0'                       
                when length(trim(zip)) = 5 then substr(trim(zip),1,5)         
                when length(trim(zip)) = 9                                    
                          and instr(trim(zip), '-',1,1) = 0                               
                          and instr(trim(zip), ' ', 1, 1)  = 0
                      then substr(trim(zip),1,5)
                when length(trim(zip)) = 10                                   
                          and (instr(trim(zip), '-',1,1) = 6 or  instr(trim(zip), ' ',1,1) = 6)                                                            
                      then substr(trim(zip),1,5)                           
                when length(trim(zip)) = 9                                    
                          and instr(trim(zip), ' ',1,1) = 5                               
                      then substr(trim(zip),1,4)  || '0'       
                when length(trim(zip)) = 9                                    
                          and instr(trim(zip), ' ', 1, 1)  = 6
                      then substr(trim(zip),1,5)
                when length(trim(zip)) = 9                                    
                          and instr(trim(zip), '-',1,1) = 5                               
                      then substr(trim(zip),1,4) || '0'      
                when length(trim(zip)) = 9                                    
                          and instr(trim(zip), '-', 1, 1)  = 6
                      then substr(trim(zip),1,5) 
           end as zip5
        , case                                                               -- 11
                when length(trim(zip)) = 9                                    
                          and instr(trim(zip), '-',1,1) = 0                               
                          and instr(trim(zip), ' ', 1, 1)  = 0
                      then substr(trim(zip),6)
                when length(trim(zip)) = 10                                   
                          and (instr(trim(zip), '-',1,1) = 6 or  instr(trim(zip), ' ',1,1) = 6)                                                            
                      then substr(trim(zip),7)                           
                when length(trim(zip)) = 9                                    
                          and instr(trim(zip), ' ',1,1) = 5                               
                      then substr(trim(zip),6)       
                when length(trim(zip)) = 9                                    
                          and instr(trim(zip), ' ', 1, 1)  = 6
                      then substr(trim(zip),7) || '0'
                when length(trim(zip)) = 9                                    
                          and instr(trim(zip), '-',1,1) = 5                               
                      then substr(trim(zip),6)      
                when length(trim(zip)) = 9                                    
                          and instr(trim(zip), '-', 1, 1)  = 6
                      then substr(trim(zip),7)||'0'
          end as zip4    
          ,  '(' || substr(coalesce(work_ph,cell_ph,home_ph),0,3)|| ') ' ||  --  12 
                  substr(coalesce(work_ph,cell_ph,home_ph),4,3) || 
                  '-' || 
                  substr(coalesce(work_ph,cell_ph,home_ph),7) as phone
          , round ((nvl(to_number(local06),0) +                                --  13
              to_number(nvl(state_local_grant_contract,0)))
              /fte_count,2) as avg_local_help_per_student
           , round(                                                           --  14 
              (
                  nvl(to_number(state03),0) +
                  nvl(to_number(state_local_app),0) + 
                  nvl(to_number(state06),0)  +
                  nvl(to_number(state09),0)
              )
              /fte_count) as avg_state_help_per_student     
             , round((nvl(to_number(federal03),0) +                              --  15 
               nvl(to_number(federal07),0) + 
               nvl(to_number(federal07_net_pell),0) + 
               nvl(to_number(federal10),0) + 
               nvl(to_number(federal10_net_pell),0))/ fte_count) as avg_fed_help_per_student 
from tuition_stg;


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
  school_id                char(10),                --  3
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



Insert into TUITION_STG values ('-1025','19991018','  LOMAX-HANNON JC',null,'74',' GREENVILLE  ','AL','36037',null,'5685267073',null,null,'33450','1897808','17068','16124160','16124160','9461724','7265232',null,null,null,'9478792','7282300','16124160','7282300',null,'250000',null,'4529459','32959139','35155632');
Insert into TUITION_STG values ('-100663','20041209',' Air Force Communty College   ',' CCAF Montgomery','84','STAMFORD','CT','352940116',null,'3954871873','4924201253',null,'31400','2506282','2440214','17107620','17107620','8994152','6877843','1132421',null,'1132421','11434366','9318057','18240042',' ','472196',null,'472196','4477017','37005390','39985544');
Insert into TUITION_STG values ('1408','19960704','University of Alabama at Birmingham','UA Birmingham','66','Birmingham','AL','6902',null,'6264285610','6135376382','8517627585','48310','5275735',null,'25429592','25429592','11363192','5508845','1916352','2400','1918752','11363192','5508845','27348344','7427597','490198',null,'490198','10061.29004','359450.29','1796802');
Insert into TUITION_STG values ('1755','19960715',' University of Alabama at Birmingham ',' UA Birmingham','66','ATLANTA','GA','    54716 745',null,null,null,'7006589290','35660','2538398','2480973','19295288','19295288','9114062','6419768','1367943',null,'1367943','11595035','8900741','20663232','10268684',null,null,'538832','4683969','39853910','43723596');
Insert into TUITION_STG values ('-1733','20040131','  University of Alabama at Birmingham','  UA Birmingham','66','CHICAGO','IL','  67156 7456',null,'4778392171',null,null,'42830','5461769','2831854',null,'20616852',null,'9852430','1264558',null,'1264558','16252634','12684284','21881410','13948842','819068',null,'819068','5135419','49351072','54899880');
Insert into TUITION_STG values ('-1025','19971105','  ALABAMA STATE COLLEGE OF BARBER STYLING',null,'48',' FORSYTH  ','GA','   6021-6191',null,'8671874153',null,'8607476667','37670','2969939','2582813','19192740','19192740','10168088','7431012','1494454',null,'1494454','12750901','10013825',null,'11508279','673651','25000','673651','4196788','41255063','45543896');
Insert into TUITION_STG values ('-1593','20090718',' NATL COLLEGE ED ',null,'84','  EVANSTON','IL','31021-017',null,'4119111565','6954325264',null,'44290','4382559','3108942','19744360','19744360','13211605','9654227','1225055',null,'1225055','16320547','12763169','20969416','13988224','1138610',null,'1138610','4905869','47146899','53132084');
Insert into TUITION_STG values ('7789895','19981017',' SAINT JOHNS COLLEGE   ',null,'74',' WINFIELD','KS','3031 4591',null,null,'8377247852',null,'47930','6769136','3162155','21909812','21909812','15313054','11759724','774214','3956','778170','18475208',null,'22687980','15700049','1449519',null,'1449519','6814877','55498820','61979400');
Insert into TUITION_STG values ('-1595','20030125','  The University of Alabama','UA Tuscaloosa','48','  CHICAGO','IL',' 60610-3431',null,null,null,'6962526418','41040','2627916','3061494','19628344','19628344','13633430','10085782','1053452',null,null,'16694924','13147276','20681796','14200728','626850',null,'626850','5446271','46086363','51433912');
