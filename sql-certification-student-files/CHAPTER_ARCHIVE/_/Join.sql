create table cust
(custid  integer primary key,
custname varchar2(20));
create table ords
(oid integer primary key,
cid integer,
ship_state char(2)
);
insert into cust values(5000,	'Fred');
insert into cust values(5001,	'Wilma');
insert into cust values(5002,	'Barney');
select * from cust;
insert into ords values(100,	5000,	'FL');
insert into ords values(101,	5002,	'FL');
insert into ords values(102,	5002,	'FL');
insert into ords values(103,	5000,	'TX');
selecT * FROM ORDS;
commit;



select custname, oid
from cust, ords
where custid = cid
  and custname = 'Barney';

select * from customers;
-- R 20
-- C 8
select * from orders;
-- R 21
-- C 8
select * from orderitems;
-- R 32
-- C 4
select * from books;
-- R 14
-- C 7
select 20*21*32*14 as myrows, (8+8+4+7) as mycolumns
from dual;

select *
from customers,orders,orderitems,books;


