drop table legacy;
create table legacy
(
    did        integer primary key
  , mac_add   varchar2(50)
  , mac_add_short varchar2(20)
  , bldg varchar2(50)
  , floor varchar2(50)
  , room varchar2(20)
);
Insert into legacy  values (1076,'52-BA-26-F1-06-FD','52-BA','Chilling Station No. 3','1','100A');
Insert into legacy  values (1000,'CB-59-84-F9-A5-2F','CB-59','Chilling Station No. 3','1','131C');
Insert into legacy  values (1515,'67-5D-47-80-F0-21','67-5D','Chilling Station No. 3','1','132D');
Insert into legacy  values (1308,'8E-76-EA-1E-9F-9A','8E-76','Main Building','3','300');
Insert into legacy  values (1407,'9C-86-3C-6D-26-A8','9C-86','Main Building','3','300');
Insert into legacy  values (1103,'C2-D5-C6-ED-4E-BD','C2-D5','Main Building','1','101');
Insert into legacy  values (1274,'D6-93-2A-5A-8C-CF','D6-93','Computational Resource Building','1','101');
Insert into legacy  values (1303,'8A-F3-2D-D1-74-1D','8A-F3','Computational Resource Bldg','1','2020');
Insert into legacy  values (1070,'F2-71-90-29-AF-7D','F2-71','Computer Science Building','1','101');
Insert into legacy  values (1585,'E6-A1-D1-9F-6C-54','E6-A1','Computational Resource Building','1','101');
Insert into legacy  values (1060,'AF-1E-2A-79-F7-F1','AF-1E','Computer Lab','2','A-876');
Insert into legacy  values (9568,'FD-72-36-3D-EC-BD','FD-72','Chilling Station No. 3','1','3-100');
Insert into legacy  values (54888,'F2-54-B8-CA-83-0F','F2-54','Chilling Station No. 3','1','3-131');
Insert into legacy  values (22759,'B2-D5-C9-D8-C7-D0','B2-D5','Chilling Station No. 3','1','3-132');
Insert into legacy  values (1231226,'49-CD-84-73-28-10','49-CD','Computational Resource Building','1','101');
Insert into legacy  values (1112495,'43-B2-04-70-83-79','43-B2','Computational Resource Building','1','101');
Insert into legacy  values (936392,'92-E1-F7-91-8F-56','92-E1','Computational Resource Building','1','101');
Insert into legacy  values (1256878,'72-B3-09-28-31-94','72-B3','Computational Resource Building','4','101');
Insert into legacy  values (1124,'60-C4-F4-0F-5C-11','60-C4','Computational Resource Building','5','101');

drop table next_gen;
create table next_gen
(
    device_id integer primary key
  , mac_address   varchar2(50)
  , mac_short varchar2(20)
  , building  varchar2(200)
  , floor  varchar2(20)
  , room varchar2(200)
);
Insert into next_gen values (1050640,'72-B3-09-28-31-94','72-B3','Computational Resource Building','1','101');
Insert into next_gen values (975338,'60-C4-F4-0F-5C-11','60-C4','Computational Resource Building','1','101');
Insert into next_gen values (1363865,'D6-93-2A-5A-8C-CF','D6-93','University Police Building','12','303');
Insert into next_gen values (1115481,'8A-F3-2D-D1-74-1D','8A-F3','University Police Building','12','304');
Insert into next_gen values (1611026,'F2-71-90-29-AF-7D','F2-71','University Police Building','12','305');
Insert into next_gen values (1507261,'E6-A1-D1-9F-6C-54','E6-A1','Main Campus Building','1','420');
Insert into next_gen values (1523218,'AF-1E-2A-79-F7-F1','AF-1E','Main Campus Building','1','400');
Insert into next_gen values (275895,'96-DD-88-73-28-10','96-DD','Engineering-Science Building','5','516');
Insert into next_gen values (2444546,'33-A2-40-07-83-79','33-A2','Engineering-Science Building','2','212');

drop table migration_stg;
create table migration_stg
(
    migration_id integer primary key
  , mac   varchar2(50)
  , mac_short varchar2(20)
  , from_b  varchar2(200)
  , from_flr  varchar2(20)
  , from_rm varchar2(200)
  , to_b  varchar2(200)
  , to_flr  varchar2(20)
  , to_rm varchar2(200)
  , start_date varchar2(200)
  , end_date varchar2(200)
);
Insert into migration_stg  values (252,'D6-93-2A-5A-8C-CF','D6-93','Computational Resource Building','1','101','University Police Building','12','303','25-MAY-2016 05:22:12 pm','26-MAY-2016 10:05:30 am');
Insert into migration_stg  values (253,'8A-F3-2D-D1-74-1D','8A-F3','Computational Resource Bldg','1','2020','University Police Building','12','304','25-MAY-2016 10:00:44 am','26-MAY-2016 10:15:45 pm');
Insert into migration_stg  values (254,'F2-71-90-29-AF-7D','F2-71','Computer Science Building','1','101','University Police Building','12','305','26-MAY-2016 07:05:44 am','26-MAY-2016 01:22:01 pm');
Insert into migration_stg  values (255,'E6-A1-D1-9F-6C-54','E6-A1','Computational Resource Building','1','101','Main Campus Building','1','420','25-MAY-2016 05:22:12 pm','26-MAY-2016 10:05:30 am');
Insert into migration_stg  values (256,'AF-1E-2A-79-F7-F1','AF-1E','Computer Lab','2','A-876','Main Campus Building','1','400','26-MAY-2016 02:32:44 pm','27-MAY-2016 05:55:12 am');
Insert into migration_stg  values (257,'72-B3-09-28-31-94','72-B3','Computational Resource Building','4','101','Computational Resource Building','1','101','27-MAY-2016 03:31:16 am','28-MAY-2016 11:05:22 pm');
Insert into migration_stg  values (258,'60-C4-F4-0F-5C-11','60-C4','Computational Resource Building','5','101','Computational Resource Building','1','101','27-MAY-2016 09:12:52 am','27-MAY-2016 05:30:10 am');
Insert into migration_stg  values (259,'67-5D-47-80-F0-21','67-5D','Chilling Station No. 3','1','132D',null,null,null,'28-MAY-2016 03:01:32 pm',null);
Insert into migration_stg  values (260,'B2-D5-C9-D8-C7-D0','B2-D5','Chilling Station No. 3','1','3-132',null,null,null,'28-MAY-2016 05:22:16 am',null);
Insert into migration_stg  values (261,'43-B2-04-70-83-79','43-B2','Computational Resource Building','1','101',null,null,null,'29-MAY-2016 02:07:49 pm',null);
Insert into migration_stg  values (262,'49-CD-84-73-28-10','49-CD','null','null','null','Engineering-Science Building','5','516','25-MAY-2016 07:22:12 am','25-MAY-2016 10:55:10 am');
Insert into migration_stg  values (263,'33-A2-40-07-83-79','33-A2','null','null','null','Engineering-Science Building','2','212','25-MAY-2016 11:15:59 am','25-MAY-2016 01:01:47 pm');
commit;

drop table migration;
create table migration 
(	migration_id integer primary key
	,mac varchar2(50) 
	,mac_short varchar2(20) 
	,from_b varchar2(200) 
	,from_flr varchar2(20) 
	,from_rm varchar2(200) 
	,to_b varchar2(200) 
	,to_flr varchar2(20) 
  ,to_rm varchar2(200) 
	,start_date date 
	,end_date date
);  

insert into migration
select migration_id
,mac
,mac_short
,from_b
,from_flr
,from_rm
,to_b
,to_flr
,to_rm
,to_date(start_date,'dd-MON-yyyy hh:mi:ss pm')
,to_date(end_date,'dd-MON-yyyy hh:mi:ss pm')
from migration_stg;
commit;

-------- answer 1
select * 
from legacy join next_gen
on mac_add = mac_address
;

-------- answer 2
SELECT  *
FROM legacy LEFT JOIN next_gen
ON      mac_add = mac_address
WHERE   mac_address IS NULL;

--------- answer 3
SELECT  *
FROM next_gen LEFT JOIN legacy
ON      mac_add = mac_address
WHERE   mac_add IS NULL;

--------- answer 4
select 
avg(end_date - start_date)* 
SUM(CASE WHEN end_date IS NULL THEN 1 END)
FROM legacy LEFT JOIN next_gen
;