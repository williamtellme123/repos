-- aliases without double quotes
select "cs".firstname "f n"
from customers "cs"
where state = 'FL'
order by "f n";

select customers.firstname, customers.lastname 
from customers 
where state = 'FL';

select title
from books
where isbn =all (select isbn 
              from books
              where title like '%WOK%'
                or title like '%TOOTH%');


select a.fn,a.ln,a.ad
from
(select c.firstname as fn, c.lastname as ln , c.address as ad
from customers c
) A
where c.state = 'FL';







select firstname as fn, lastname
from customers cs
where state = 'FL';





drop table t1;
create table t1
( name varchar2(10),
  name1 varchar2(10));
insert into t1 values ('MARK','MARK ');

select *
from books
where retail between 10 and 50;

select * from employees;
select * from salary_chart;
SELECT * FROM salary_chart
	WHERE superior = 'Captain'
	AND (emp_income < 200 OR emp_income > 100);

SELECT * FROM salary_chart
	WHERE superior = 'Captain'
	AND emp_income < 200000 OR emp_income > 100000;

select * from t1
where name = name1;
select * from ALL_TABLES;
select * from ALL_CONS_COLUMNS;
select * from DBA_VIEWS;
select * from USER_VIEWS;
drop table t;
create table t(
name1 VARCHAR2 (10),
name2 CHAR (10),
name3 VARCHAR2 (5),
name4 CHAR (5));
delete t;
insert into t values (
  'MARK'
, 'MARK'
, 'MARK'
, 'MARK');

select 
  length(name1)
  ,length(name2)
  ,length(name3)
  ,length(name4)
from t;

select "em".name1 "this name"
from t em;

select title, retail 
from books
where title in 
(select title from books
 where category = 'COMPUTER'
-- order by title
 );
 
 
select trunc(sum(retail),-1)
from books;

 select category,
      trunc(sum(retail),-2)
from books
group by category; 

select decode(state,
              'FL', 'South East',
              'TX', 'South',
              'CA', 'West Coast',
              else, 'Other')
from customers;              

select decode(state,
              'FL', 'South East',
              'TX', 'South',
              'CA', 'West Coast',
              'Other')
from customers;        

select decode(state,
              'FL', 'South East'
              'TX', 'South'
              'CA', 'West Coast'
              'Other')
from customers;        

select decode(state,
              'FL', "South East",
              'TX', "South",
              'CA', "West Coast",
              'Other')
from customers;        

drop table emp10;
create table emp10
(eid integer primary key,
salary number(6),
bonus number(6));

insert into emp10 values (1,5000, 500);
insert into emp10 values (2,5000, 500);
insert into emp10 values (3,5000, 500);
insert into emp10 values (4,5000, 500);
insert into emp10 values (5,5000, null);

UPDATE emp10 SET salary = NVL2(bonus, salary * 1.10, (salary+bonus)*1.10) where eid = 4;
select * from emp10  where eid = 4;
UPDATE emp10 SET salary = (salary + nvl(bonus,0)) * 1.10 where eid = 1;
select * from emp10  where eid = 1;
UPDATE emp10 SET salary = salary * 1.10 + NVL(bonus,0) where eid = 2;
select * from emp10  where eid = 2;
UPDATE emp10 SET salary = NVL(salary + bonus) * 1.10 where eid = 3;
select * from emp10  where eid = 3;

UPDATE emp SET salary = NVL2(bonus, salary * 1.10, (salary+bonus)*1.10);
UPDATE emp SET salary = (salary + nvl(bonus,0)) * 1.10;
UPDATE emp SET salary = salary * 1.10 + NVL(bonus,0);
UPDATE emp SET salary = NVL(salary + bonus) * 1.10;



select 550, 5500*1.1
from dual;

drop table orders2;
create table orders2
(orderid     varchar2(50) primary key,
order_date  date default sysdate,
product_id  varchar2(50) not null,
product_amt number(7,2), 
product_name  varchar2(50) unique,
orderseq  integer unique);

create table orders2

SYS_C0012269	ORDERID	
SYS_C0012270  PRODUCT_NAME	
SYS_C0012271  ORDERSEQ	


drop table customers; 
drop table orders;
create table customers as select * from books.customers where 1=2;
create table orders as select * from books.orders where 1=2;
alter table customers add primary key (customer#);


alter table orders add foreign key(customer#) references customers(customer#);
alter table orders add constraint cid_fk foreign key(customer#) references customers(customer#);
alter table orders modify customer# foreign key references customers(customer#);
alter table orders add constraint foreign key(customer#) references customers(customer#);



select 
to_char(sysdate, 'DD MM YYYY') a
,to_char(sysdate, 'Dd MM YYYY') b
,to_char(sysdate, 'Day MM YYYY') c
,to_char(sysdate, 'FMDay MM YYYY')d
,to_char(sysdate, 'Ddth MM YYYY')d
,to_char(sysdate, 'FMddth MM YYYY')d
from dual; 

-- average of all category total sum 
select avg(sum(round(retail,2)))
from books
group by category;


select 'Total' ,sum(retail)
from books
group by category;
