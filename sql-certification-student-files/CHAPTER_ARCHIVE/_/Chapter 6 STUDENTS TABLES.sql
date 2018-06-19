-- =============================================================================
-- BUILD TUITION TABLE
    select * from tuition;
    --drop table tuition;
commit;   
create table tuition (	
    groupid	varchar2(500),
    date_t	varchar2(500),
    instname	varchar2(500),
    tcsname	varchar2(500),
    type_inst	varchar2(500),
    city	varchar2(500),
    state	varchar2(500),
    zip	varchar2(500),
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
    
-- IMPORT DATA : TUITION.CSV

-- =============================================================================
-- STATES TABLE
select * from states;
--drop table states;
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
select * from school_type;
-- drop table school_type;
create table school_type
( type_id   integer primary key,
  type_name  varchar2(25));

insert into school_type values (66,	'STATE UNIVERSITY');
insert into school_type values (48,	'STATE COLLEGE');
insert into school_type values (30,	'STATE COMMUNITY COLLEGE');
insert into school_type values (38,	'LOCAL COMMUNITY COLLEGE');
insert into school_type values (69,	'PRIVATE JR COLLEGE');
insert into school_type values (74,	'PRIVATE');
commit;


