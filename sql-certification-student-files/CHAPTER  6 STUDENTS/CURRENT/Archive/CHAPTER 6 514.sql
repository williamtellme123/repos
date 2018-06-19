select * from ships;
select * from ship_cabins;

select  ship_id
      , ship_name
      , upper(ship_name) AS uship_name
      , lower(ship_name) AS lship_name
from ships
where upper(ship_name) like 'CODD_%';

select  ship_id
      , ship_name
      , upper(ship_name) AS uship_name
      , lower(ship_name) AS lship_name
from ships
where  upper(ship_name) in  ('CODD_%','Codd Elegance');


select   title
       , upper(title)
       , lower(title)
       , initcap(title)
from books;  


select  initcap('napoleon')
      , initcap('red o''brien')
      , 'McDonald''s'
      , initcap('mcdonald''s')
from dual;



select  initcap(firstname)
      , initcap(lastname)
      , initcap(firstname) || ' ' || initcap(lastname) AS full0
      , concat(firstname,lastname) AS full1
      , concat(firstname,lastname) AS full1
      , concat(firstname,concat(' ', lastname)) AS full2
from customers;

-- CTAS
create table cust3 as
select    initcap(firstname) || ' ' || initcap(lastname) full
        , state
from customers;
desc cust3;
drop table cust3;

select  lpad('Apple',10,'.')
       ,rpad('Pie',10,'.') 
from dual;

select  rpad('Apple',10,'.')
       ,lpad('Pie',10,'.') 
from dual;


select  rpad('Apple',10,'.')|| lpad('Pie',10,'.') AS full
from dual;

select rtrim('Chapter 1 ....... ...','. 1 r')
from dual;

-- starts with ||
-- then rpad
-- then lpad
-- length
select  rpad('Apple',3,'.'), lpad('Apple',3,'.')
from dual;

select rpad(chapter_title || ' ' , 30,'.')  ||  lpad(' ' || Page_number,30,'.')
from book_contents
order by page_number;


select rtrim('Chapter 1..........','.')
from dual;

select trim('-' from '-------- APPLE -----------') abc from dual;
select trim(trailing '-' from '-------- APPLE -----------') abc from dual;
select trim(leading '-' from '-------- APPLE -----------') abc from dual;
select trim(both '-' from '-------- APPLE -----------') abc from dual;

select   instr('Mississippi'   ,'is',1,2)
       , instr('Mississippi'   ,'is',-1,2)
from dual;



select  substr('Name: Mark Kennedy',-3)
from dual;

Select round(55.456,2) from dual;

Select round(45.456,-2) from dual;

select trunc(999.35514,-2)
from dual;
-- returns the remainder of division
select mod(11,3)
from dual;

-- returns the difference of the first value - (the nearest multiple of pararmeter2)
select  remainder(12,3)
      , remainder(11,3)
      , remainder(10,3)
      , remainder(9,3)
from dual;


-- NVL( string1, replace_with )
-- string1 is the string to test for a null value.
-- replace_with is the value returned if string1 is null.
select orderdate, shipdate, nvl(shipdate, orderdate + 3)
from orders
order by shipdate desc;

select orderdate, shipdate, nvl(shipdate, orderdate + 3)
from orders
order by shipdate desc;


-- NVL2( string1, value_if_NOT_null, value_if_null )
select orderdate, shipdate, nvl2(shipdate, shipdate, sysdate),nvl2(shipdate, orderdate, sysdate)
from orders
order by shipdate desc;



-- string1 is the string to test for a null value.
-- value_if_NOT_null is the value returned if string1 is not null.
-- value_if_null is the value returned if string1 is null.





-- NULLIF( expr1, expr2 )
-- If expr1 = expr2 return NULL
-- Otherwise, returns expr1
select   test_score
       , updated_test_score
       , nullif(updated_test_score,test_score) final
from scores;

select * from scores;
commit;
update scores set updated_test_score = null where score_id in (1,3);


select   test_score
       , updated_test_score
       , nvl(nullif(updated_test_score,test_score), test_score) AS final
from scores;

select state,
       decode (state
               , 'CA', 'California'
               , 'IL', 'Illinois'
               , 'Other'
               ) as State
from addresses;


select sysdate, systimestamp
from dual;

select   sysdate,
         round(sysdate,'MM') m,
         round(sysdate,'YY') y,
         round (sysdate-2,'IW') w,
         round(sysdate,'RR') r
from dual;         

select   sysdate-2,
         trunc(sysdate,'MM') m,
         trunc(sysdate,'YY') y,
         trunc (sysdate-2,'IW') w,
         trunc(sysdate,'RR') r
from dual;


select  to_char(to_date('10-12-13','DD-MM-YYYY'), 'DD-MM-RRRR')
from dual;

select sysdate, to_char(sysdate, 'DD-MON-YYYY HH:MI:SSam')
from dual;

select to_char(sysdate-9,'FMDay, "the" Ddth "of" Month, RRRR')
from dual;

select add_months('15-JAN-11', 1),
       add_months('01-NOV-11', 4)
from dual;

select months_between('01-MAR-12','15-JAN-12')
from dual;

select abs(months_between('15-JAN-12','01-MAR-12'))
from dual;

select to_char(to_date('10-DEC-13','DD-MON-RR'),'MONTH DD, YYYY')
from dual;
 
 
 select greatest (1,5,667,2)
 from dual;
 
 select next_day(sysdate,'MONDAY')
 from dual;
 
 
 select * 
 from books;
 
 select to_char(sum(cost),'$999.99')
 from books;
 
 select to_char(4444.67,'$9999.99')
 from dual;
 
 
 
  
create table testscores
( tid     number primary key,
  fname   varchar2(15),
  score   number);
  
insert into testscores values (1,'Bucky', 59);  
insert into testscores values (2,'Cathy', 92); 
insert into testscores values (3,'Danny', 85); 
insert into testscores values (4,'Elaine', 72); 
insert into testscores values (5,'Frank', 66); 
insert into testscores values (6,'George', 90); 
insert into testscores values (7,'Hank', 71); 
insert into testscores values (8,'Ida', 88); 
insert into testscores values (9,'Jake', 85); 
insert into testscores values (10,'Kate', 87); 
commit;

select fname, score,
       -- case when then (else is optional) end
       -- this can be a complex expresssion
       case
            when score between 90 and 100 then 'A'
            when score between 80 and 89 then 'B'
            when score between 70 and 79 then 'C'
            when score between 60 and 69 then 'D'
            -- when score < 60 then 'Sorry Pal'
            else 'Sorry Pal'
      end AS grade
from testscores;

select fname, score,
       case
            when score between 90 and 100 then "A",
            when score between 80 and 89 then 'B',
            when score between 70 and 79 then 'C',
            when score between 60 and 69 then 'D',
            -- when score < 60 then 'Sorry Pal'
            else 'Sorry Pal'
      end AS grade
      -- case when then (else) end
from testscores;







-- use to_cahr top fix this issue
select orderdate, shipdate, nvl(shipdate, 'HAS NOT SHIPPED')
from orders
order by shipdate desc;




create table tickets
(ticket     number,
 priority   number,
 submitted  date,
 closed     date);

delete from tickets;
select * from tickets;

insert into tickets 
values( 10
        ,1
        , to_date('12-DEC-13 11:23:45','DD-MM-YY HH:MI:SS')
        , to_date('12-DEC-13 13:25:45','DD-MM-YY HH24:MI:SS')
       );
       
insert into tickets 
values( 11
        ,1
        , to_date('12-DEC-13 14:11:45','DD-MM-YY HH24:MI:SS')
        , to_date('12-DEC-13 19:25:45','DD-MM-YY HH24:MI:SS')
       );

insert into tickets 
values( 12
        ,1
        , to_date('12-DEC-13 16:05:45','DD-MM-YY HH24:MI:SS')
        , to_date('12-DEC-13 17:25:45','DD-MM-YY HH24:MI:SS')
       );
       

select * from tickets;
       
select priority
      , round((closed-submitted) * 24,2) hours
      , round((closed-submitted) * 24 * 60,2) minutes
from tickets;

-- case when then end
select priority
      , case 
          when round((closed-submitted) * 24,2) <= 4.00
               and priority = 1 then 1
        end SLA_Met
      , case 
          when round((closed-submitted) * 24,2) > 4.00
               and priority = 1 then 1
        end SLA_NOT_Met
from tickets;

-- created the time difference
-- transformed that into hours
-- then we used case statment that asked
--    1. is the TTC <= 4
--    2. and the priority = 1
--    3. then return the value 1
--    4. nested that whole thing into a sum function
select priority
      , sum(
        case 
          when round((closed-submitted) * 24,2) <= 4.00
               and priority = 1 then 1
        end) SLA_Met_Dec
      , SUM(case 
          when round((closed-submitted) * 24,2) > 4.00
               and priority = 1 then 1
        end) SLA_NOT_Met_Dec
from tickets
group by priority;


