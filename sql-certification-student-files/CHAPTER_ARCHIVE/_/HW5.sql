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
Insert into TUITION_STG values ('-1025','19991018','  LOMAX-HANNON JC',null,'74',' GREENVILLE  ','AL','36037',null,'5685267073',null,null,'33450','1897808','17068','16124160','16124160','9461724','7265232',null,null,null,'9478792','7282300','16124160','7282300',null,'250000',null,'4529459','32959139','35155632');
Insert into TUITION_STG values ('-100663','20041209',' Air Force Communty College   ',' CCAF Montgomery','84','STAMFORD','CT','352940116',null,'3954871873','4924201253',null,'31400','2506282','2440214','17107620','17107620','8994152','6877843','1132421',null,'1132421','11434366','9318057','18240042',' ','472196',null,'472196','4477017','37005390','39985544');
Insert into TUITION_STG values ('1408','19960704','University of Alabama at Birmingham','UA Birmingham','66','Birmingham','AL','6902',null,'6264285610','6135376382','8517627585','48310','5275735',null,'25429592','25429592','11363192','5508845','1916352','2400','1918752','11363192','5508845','27348344','7427597','490198',null,'490198','10061.29004','359450.29','1796802');
Insert into TUITION_STG values ('1755','19960715',' University of Alabama at Birmingham ',' UA Birmingham','66','ATLANTA','GA','    54716 745',null,null,null,'7006589290','35660','2538398','2480973','19295288','19295288','9114062','6419768','1367943',null,'1367943','11595035','8900741','20663232','10268684',null,null,'538832','4683969','39853910','43723596');
Insert into TUITION_STG values ('-1733','20040131','  University of Alabama at Birmingham','  UA Birmingham','66','CHICAGO','IL','  67156 7456',null,'4778392171',null,null,'42830','5461769','2831854',null,'20616852',null,'9852430','1264558',null,'1264558','16252634','12684284','21881410','13948842','819068',null,'819068','5135419','49351072','54899880');
Insert into TUITION_STG values ('-1025','19971105','  ALABAMA STATE COLLEGE OF BARBER STYLING',null,'48',' FORSYTH  ','GA','   6021-6191',null,'8671874153',null,'8607476667','37670','2969939','2582813','19192740','19192740','10168088','7431012','1494454',null,'1494454','12750901','10013825',null,'11508279','673651','25000','673651','4196788','41255063','45543896');
Insert into TUITION_STG values ('-1593','20090718',' NATL COLLEGE ED ',null,'84','  EVANSTON','IL','31021-017',null,'4119111565','6954325264',null,'44290','4382559','3108942','19744360','19744360','13211605','9654227','1225055',null,'1225055','16320547','12763169','20969416','13988224','1138610',null,'1138610','4905869','47146899','53132084');
Insert into TUITION_STG values ('7789895','19981017',' SAINT JOHNS COLLEGE   ',null,'74',' WINFIELD','KS','3031 4591',null,null,'8377247852',null,'47930','6769136','3162155','21909812','21909812','15313054','11759724','774214','3956','778170','18475208',null,'22687980','15700049','1449519',null,'1449519','6814877','55498820','61979400');
Insert into TUITION_STG values ('-1595','20030125','  The University of Alabama','UA Tuscaloosa','48','  CHICAGO','IL',' 60610-3431',null,null,null,'6962526418','41040','2627916','3061494','19628344','19628344','13633430','10085782','1053452',null,null,'16694924','13147276','20681796','14200728','626850',null,'626850','5446271','46086363','51433912');
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

drop table tuition_ETL;
create table tuition_ETL
( group_pk varchar2(2),
  grouped varchar2(11),
  school_id varchar2(8),
  date_joined date,
  institution_name varchar2(43),
  city varchar2(15),
  state varchar2(15),
  region varchar2(11),
  zip5 varchar2(5),
  zip4 varchar(4),
  phone varchar(14),
  avg_local_help_per_student number,
  avg_state_help_per_student number,
  avg_fed_help_per_student number
  );
  
insert into tuition_ETL 
(group_pk
  ,grouped
  ,school_id
  ,date_joined
  ,institution_name
  ,city
  ,state
--  ,region 
  ,zip5
  ,zip4
  ,phone
  ,avg_local_help_per_student
  ,avg_state_help_per_student
  ,avg_fed_help_per_student
  )
 select
 tuition_etl_seq.nextval as group_pk
-----------
,case
    when instr(groupid,'-',1,1)>0 then 'Is Grouped'
    when instr(groupid,'-',1,1)=0 then 'Not Grouped'
end as GROUPED
--------------
,case
    when instr(groupid,'-',1,1)>0 
        then substr(groupid,2)
    when instr(groupid,'-',1,1)=0 
        then groupid
end as SCHOOL_ID
--------------
,to_date(date_joined,'YYYYMMDD') as DATE_JOINED
--------------
,nvl2(campus_name,campus_name,institution_name) as INSTITUTION_NAME
--------------
,city as CITY
--------------
,state as STATE
--------------
--,s.region 
--from tuition_stg t join states s 
--on t.state = s.state
--AS REGION
--,states.region 
--from states join tuition_stg
--on states.st = tuition_stg.state
--order by states.region
----as region
--------------
,case
    when length(trim(both ' ' from zip)) = 9 
        and instr((trim(both ' ' from zip)),'-',1,1) = 0  
      then substr((trim(both ' ' from zip)),1,5)
    when length(trim(both ' ' from zip)) = 10
        and instr((trim(both ' ' from zip)),'-',1,1) > 0
      then substr((trim(both ' ' from zip)),1,5)
      
    when length(trim(both ' ' from zip)) = 9
        and instr((trim(both ' ' from zip)),'-',6,1) > 0
      then substr((trim(both ' ' from zip)),1,5)
      
    when length(trim(both ' ' from zip)) = 9
        and instr((trim(both ' ' from zip)),'-',5,1) > 0
      then substr((trim(both ' ' from zip)),1,4)  || '0'
      
    when length(trim(both ' ' from zip)) = 10
        and instr((trim(both ' ' from zip)),' ',1,1) > 0
      then substr((trim(both ' ' from zip)),1,5)
    when length(trim(both ' ' from zip)) = 9 
        and instr((trim(both ' ' from zip)),' ',6,1) > 0  
      then substr((trim(both ' ' from zip)),1,5)
    when length(trim(both ' ' from zip)) = 9 
        and instr((trim(both ' ' from zip)),' ',5,1) > 0  
      then substr((trim(both ' ' from zip)),1,4) || '0'  
    when length(trim(both ' ' from zip)) = 5
      then (trim(both ' ' from zip))
    when length(trim(both ' ' from zip)) = 4 
      then (trim(both ' ' from zip)) || '0'
      
  end as ZIP5
----------------
,case
    when length(trim(both ' ' from zip)) = 9 
        and instr((trim(both ' ' from zip)),'-',1,1) = 0  
      then substr((trim(both ' ' from zip)),6,4)
    when length(trim(both ' ' from zip)) = 10
        and instr((trim(both ' ' from zip)),'-',1,1) > 0
      then substr((trim(both ' ' from zip)),7,4)
      
    when length(trim(both ' ' from zip)) = 9
        and instr((trim(both ' ' from zip)),'-',6,1) > 0
      then substr((trim(both ' ' from zip)),7,3)||'0'
      
    when length(trim(both ' ' from zip)) = 9
        and instr((trim(both ' ' from zip)),'-',5,1) > 0
      then substr((trim(both ' ' from zip)),6,4)
      
    when length(trim(both ' ' from zip)) = 10
        and instr((trim(both ' ' from zip)),' ',1,1) > 0
      then substr((trim(both ' ' from zip)),7,4)
    when length(trim(both ' ' from zip)) = 9 
        and instr((trim(both ' ' from zip)),' ',6,1) > 0  
      then substr((trim(both ' ' from zip)),7,3) || '0'
    when length(trim(both ' ' from zip)) = 9 
        and instr((trim(both ' ' from zip)),' ',5,1) > 0  
      then substr((trim(both ' ' from zip)),1,3) || '0'  
    when length(trim(both ' ' from zip)) = 5
      then null
    when length(trim(both ' ' from zip)) = 4 
      then null
      
  end as ZIP4
-------------------
,'(' || substr(coalesce(work_ph,cell_ph,home_ph),0,3)|| ') ' ||  
        substr(coalesce(work_ph,cell_ph,home_ph),4,3) || '-' || 
        substr(coalesce(work_ph,cell_ph,home_ph),7) as PHONE
-------------------
,round
       (
         (
            to_number(nvl(Local06,0)) 
            +
            to_number(nvl(State_local_grant_contract,0))
         )   
          / to_number(Fte_count),2) as AVG_LOCAL_HELP_PER_STUDENT
--------------------
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
              / nvl(to_number(fte_count),0),2) 
              as AVG_STATE_HELP_PER_STUDENT
--------------------
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
        / nvl(to_number(Fte_count),0),2)
        as AVG_FED_HELP_PER_STUDENT
from tuition_stg; 


select * from tuition_ETL;  


select * from TUITION_STG;
select * from states;

drop sequence tuition_etl_seq;
create sequence tuition_etl_seq start with 1 increment by 1;