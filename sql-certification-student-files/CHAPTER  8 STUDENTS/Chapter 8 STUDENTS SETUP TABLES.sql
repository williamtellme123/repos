-- =============================================================================
-- CHAPTER 8 SETUP
-- =============================================================================
drop table cust;
create table cust
(custid	integer,
custname varchar2(20));
insert into cust values (5000,	'Fred');
insert into cust values (5001,	'Wilma');
insert into cust values (5002,	'Barney');
drop table ords;
create table ords
(oid	integer,
cid	 integer,
ship_state varchar2(5));
insert into ords values (100,	5000,	'FL');
insert into ords values (101,	5002,	'FL');
insert into ords values (102,	5002,	'FL');
insert into ords values (103,	5000,	'TX');
insert into ords values (104,	5004,	'TX');
commit;

drop table legacy;
create table legacy
(
  did	        integer,
  m_address   varchar2(50),
  m_short varchar2(20),
  bldg	 varchar2(50),
  floor	varchar2(20), 
  room varchar2(20)
);
insert into legacy values ('1076', '52-BA-26-F1-06-FD', '52-BA', 'Chilling Station No. 3', '1', '100A');
insert into legacy values ('1000', 'CB-59-84-F9-A5-2F', 'CB-59', 'Chilling Station No. 3', '1', '131C');
insert into legacy values ('1515', '67-5D-47-80-F0-21', '67-5D', 'Chilling Station No. 3', '1', '132D');
insert into legacy values ('1308', '8E-76-EA-1E-9F-9A', '8E-76', 'Main Building', '3', '300');
insert into legacy values ('1407', '9C-86-3C-6D-26-A8', '9C-86', 'Main Building', '3', '300');
insert into legacy values ('1103', 'C2-D5-C6-ED-4E-BD', 'C2-D5', 'Main Building', '1', '101');
insert into legacy values ('1274', 'D6-93-2A-5A-8C-CF', 'D6-93', 'Computational Resource Building', '1', '101');
insert into legacy values ('1303', '8A-F3-2D-D1-74-1D', '8A-F3x87[', 'Computational Resource Bldg', '1', 'jh890p0');
insert into legacy values ('1070', 'F2-71-90-29-AF-7D', 'F2-71', 'Computer Science Building', '1', '101');
insert into legacy values ('1585', 'E6-A1-D1-9F-6C-54', 'E6-A1', 'Computational Resource Building', '1', '101');
insert into legacy values ('1060', 'AF-1E-2A-79-F7-F1', 'AF-1E', 'Computer Lab', '2', 'sd$5gds');
commit;

drop table next_gen;
create table next_gen
(
  device_id	        integer,
  mac_address   varchar2(50),
  mac_short varchar2(20),
  building	 varchar2(50),
  floor	varchar2(20), 
  room varchar2(20)
);

insert into next_gen values ('1659647', '52-BA-26-F1-06-FD', '52-BA', 'Chilling Station No. 3', '4', '3-412');
insert into next_gen values ('1121568', 'CB-59-84-F9-A5-2F', 'CB-59', 'Chilling Station No. 3', '4', '3-413');
insert into next_gen values ('943547', '67-5D-47-80-F0-21', '67-5D', 'Chilling Station No. 3', '4', '3-400');
insert into next_gen values ('1248758', 'FD-72-36-3D-EC-BD', 'FD-72', 'Chilling Station No. 3', '1', '3-100');
insert into next_gen values ('1247425', 'F2-54-B8-CA-83-0F', 'F2-54', 'Chilling Station No. 3', '1', '3-131');
insert into next_gen values ('1160476', 'B2-D5-C9-D8-C7-D0', 'B2-D5', 'Chilling Station No. 3', '1', '3-132');

insert into next_gen values ('1231226', '49-CD-84-73-28-10', '49-CD', 'Computational Resource Building', '1', '101');
insert into next_gen values ('1112495', '43-B2-04-70-83-79', '43-B2', 'Computational Resource Building', '1', '101');
insert into next_gen values ('936392', '92-E1-F7-91-8F-56', '92-E1', 'Computational Resource Building', '1', '101');
insert into next_gen values ('1050640',  '72-B3-09-28-31-94', '72-B3', 'Computational Resource Building', '1', '101');
insert into next_gen values ('975338',  '60-C4-F4-0F-5C-11','60-C4','Computational Resource Building',	1,	101);

insert into next_gen values ('1363865', 'D6-93-2A-5A-8C-CF', 'D6-93', 'University Police Building', '12', '303');
insert into next_gen values ('1115481', '8A-F3-2D-D1-74-1D', '8A-F3', 'University Police Building', '12', '304');
insert into next_gen values ('1611026', 'F2-71-90-29-AF-7D', 'F2-71', 'University Police Building', '12', '305');
insert into next_gen values ('1507261', 'E6-A1-D1-9F-6C-54', 'E6-A1', 'Main Campus Building', '1', '1011');
insert into next_gen values ('1523218', 'AF-1E-2A-79-F7-F1', 'AF-1E', 'Main Campus Building', '1', '1042-C');

insert into next_gen values ('1604773', '49-CD-84-73-28-10', '49-CD', 'Engineering-Science Building', null, null);
insert into next_gen values ('1587260', '43-B2-04-70-83-79', '43-B2', 'Engineering-Science Building', null, null);
commit;


drop table orders;
create table orders as select * from books.orders;
drop table customers;
create table customers as select * from books.customers;
insert into orders values (9151,5005,to_date('31-MAR-03','DD-MON-RR'),to_date('02-APR-03','DD-MON-RR'),'1201 APPLE AVE','BELLEVUE','WA','98114');
insert into orders values (9152,5010,to_date('31-MAR-03','DD-MON-RR'),to_date('01-APR-03','DD-MON-RR'),'114 STONE BLVD','DECATUR','GA','30314');
commit;