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

select * from cust;
select * from ords;
-- which orders did Fred place
-- display Fred and his order numbers

select *
from cust, ords;

 select *
 from cust inner join ords on custid = cid
 where custname = 'Fred';


