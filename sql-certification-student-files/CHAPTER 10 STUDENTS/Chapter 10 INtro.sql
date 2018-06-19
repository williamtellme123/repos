create table myemployee
(  emp_id integer
  ,fname varchar2(50)
  ,lname varchar2(50)
  ,bldg varchar2(50)
  ,floor integer
  ,desk varchar2(20)
  ,email varchar2(50)
  ,phone varchar2(50)
  ,salary integer
  ,performance_value number(4,2)
  ,bonus integer
  ,health_plan varchar2(20)
  );

fred flintsone aust_6 4 22B fred.flinstone@acme.com (512) 340-3000 4000 7.9 2 Kaiser HMO 
wilma flintstone aust_7 2 10 wilma.flinstone@acme.com (512) 340-3000 5000 8.2 3 Kaiser HMO  


create sequence emp_id_seq;
insert into myemployee values 
(
emp_id_seq.nextval
,'wilma','flintsone','aust_6',2,'10',' wilma.flinstone@acme.com',' (512) 340-3000',5000,8.2,3,'Kaiser HMO'); 

select * from myemployee;

create view vw_myemp
as select fname, lname, bldg, floor, desk, email, phone
from myemployee;

create view vw_emp_hr
as select emp_id,fname,lname,salary,performance_value, bonus, health_plan
from myemployee;  

select * from vw_myemp;

select * from vw_emp_hr;

select * from all_views;

select * from all_views where view_name = 'VW_EMP_HR';