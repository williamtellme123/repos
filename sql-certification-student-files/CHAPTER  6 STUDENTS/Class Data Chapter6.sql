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

--( st_id integer primary key, 
--  state varchar2(20),
--  st    char(2),
--  region varchar2(15));



select '''' || st || '''' 
from states 
where region = 'South'
order by region;


case 
  when state in ('CT', 'ME', 'MA', 'NH', 'NJ', 'NY', 'PA', 'RI', 'VT') then 'North East'
  when state in ('AK', 'AZ', 'CA', 'CO', 'HI', 'ID', 'MT', 'NV', 'NM', 'OR', 'UT', 'WA', 'WY') then 'West'
  when state in ('IL', 'IN', 'IA', 'KS', 'MI', 'MN', 'MS', 'NE', 'ND', 'OH', 'SD', 'WV') then 'Midwest' 
  when state in ('AL', 'AR', 'DE', 'FL', 'GA', 'KY', 'LA', 'MD', 'MO', 'NC', 'OK', 'SC', 'TN', 'TX', 'VA', 'WI') then 'South'
end as region  

update states
set st = 'VA' where state = 'Virginia';
commit;



create table school_type
( type_id   integer primary key,
  type_name  varchar2(25));
  
delete school_type;
commit;

insert into school_type values (66,	'STATE UNIVERSITY');
insert into school_type values (48,	'STATE COLLEGE');
insert into school_type values (30,	'STATE COMMUNITY COLLEGE');
insert into school_type values (38,	'LOCAL COMMUNITY COLLEGE');
insert into school_type values (69,	'PRIVATE JR COLLEGE');
insert into school_type values (74,	'PRIVATE');
commit;














-- PIVOT EXAMPLE 
-- TECHONTHENET
drop table o;
CREATE TABLE o
( order_id integer primary key,
  customer_ref varchar2(50) NOT NULL,
  product_id integer
);
insert into o values(50001  ,'SMITH', 	  10);
insert into o values(50002  ,'SMITH', 	  20);
insert into o values(50003 	,'ANDERSON', 	30);
insert into o values(50004 	,'ANDERSON', 	40);
insert into o values(50005 	,'JONES', 	  10);
insert into o values(50006 	,'JONES', 	  20);
insert into o values(50007 	,'SMITH', 	  20);
insert into o values(50008 	,'SMITH', 	  10);
insert into o values(50009 	,'SMITH', 	  20);
commit;

SELECT * FROM
(
  SELECT customer_ref, product_id
  FROM o
)
PIVOT
(
  COUNT(product_id)
  FOR product_id IN (10, 20, 30, 40)
)
ORDER BY customer_ref;







-- PIVOT EXAMPLE 
--drop table c;
--create table c
--( cust_id integer primary key,
--  cust_name varchar2(20),
--  state_code varchar2(2),
--  times_purchased number(3));
--create sequence c_seq;
--insert into c values (c_seq.nextval,'STAR','CT',1);
--insert into c values (c_seq.nextval,'HEB','NY',10);
--insert into c values (c_seq.nextval,'BBQ','NJ',2);
--insert into c values (c_seq.nextval,'ARBYS','NY',4);
--insert into c values (c_seq.nextval,'STAR','CT',22);
--insert into c values (c_seq.nextval,'HEB','NY',30);
--insert into c values (c_seq.nextval,'BBQ','NJ',14);
--insert into c values (c_seq.nextval,'ARBYS','NY',12);
--commit;
--
--select * 
--from 
--    (select times_purchased, state_code from c t)
--pivot
--(
--    count(state_code)
--    for state_code in ('NY','CT','NJ')
--)    
--order by times_purchased;
--

