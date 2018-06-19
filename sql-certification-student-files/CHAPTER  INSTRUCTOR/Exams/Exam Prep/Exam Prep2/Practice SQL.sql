drop table population;
create table population
(
  pid integer,
  state varchar(2 byte),
  county varchar (15 byte),
  City vARCHAR(25 byte),
  pop integer);

insert into population values (1,'TX','Wiliamson','Round Rock',1000);  
insert into population values (2,'TX','Travis','Austin',2000);
insert into population values (3,'TX','Hays','Buda',500);
insert into population values (4,'TX','Wiliamson','Cedar Park', 1000);
insert into population values (5,'MA','Gaine','Greenfield', 5000);
insert into population values (5,'MA','Gaine','Turners Falls', 4000);
commit;

insert into population values (1,'TX','Wiliamson','Round Rock',1000);  
insert into population values (4,'TX','Wiliamson','Cedar Park', 1000);
insert into population values (5,'MA','Gaine','Greenfield', 5000);
commit;

-- review aggregate functions
select * from population;
-- 1 column aggregate
select state, sum(pop)
from population
group by state;

-- 2 column aggregate
select state, county, sum(pop)
from population
group by state, county;

-- 3 column aggregate
select state, county, city, sum(pop)
from population
group by state, county,city;

-- rollup version of aggregation
-- 1 column 
select state, sum(pop)
from population
group by rollup (state);
-- 2 column 
select state, county, sum(pop)
from population
group by rollup(state, county);
-- 3 column 
select state, county, city, sum(pop)
from population
group by rollup(state, county,city)
order by 2 desc;


--- CUBE
-- 3 column 
select state, county, city, sum(pop)
from population
group by cube(state, county,city)
order by 1, 2 desc;


-- case examples
select
  sum(cASE WHEN CATEGORY = 'COMPUTER' THEN retail end) as COMPU,
  sum(cASE WHEN CATEGORY = 'COOKING' THEN retail end) as CKG,
  sum(cASE WHEN CATEGORY = 'FITNESS' THEN retail end) as fit,
  sum(cASE WHEN CATEGORY = 'FAMILY LIFE' THEN retail end) as fl,
  sum(cASE WHEN CATEGORY = 'CHILDREN' THEN retail end) chl,
  sum(cASE WHEN CATEGORY = 'SELF HELP' THEN retail end) sh,
  sum(cASE WHEN CATEGORY = 'BUSINESS' THEN retail end) bus,
  sum(cASE WHEN CATEGORY = 'LITERATURE' THEN retail end) as lit 
from books;  
  
  
select
  cASE WHEN CATEGORY = 'COMPUTER' THEN retail
       WHEN CATEGORY = 'COOKING' THEN retail 
       WHEN CATEGORY = 'FITNESS' THEN retail 
       else retail 
  END as abc
from books;    



select
  cASE WHEN CATEGORY = 'COMPUTER' THEN retail
       WHEN CATEGORY = 'COOKING' THEN retail 
       WHEN CATEGORY = 'FITNESS' THEN retail 
       else retail 
  END as "abc"
from books;

select
  cASE WHEN CATEGORY = "COMPUTER" THEN retail
       WHEN CATEGORY = "COOKING" THEN retail 
       WHEN CATEGORY = "FITNESS" THEN retail 
       else retail 
  END as 'abc 123'
from books;


select
  cASE WHEN CATEGORY = 'COMPUTER' THEN retail,
       WHEN CATEGORY = 'COOKING' THEN retail,
       WHEN CATEGORY = 'FITNESS' THEN retail, 
       else retail 
  END as abc
from books;

-- Hierarchical Examples
-- Which is child ID and which is parent ID on each row
-- then you know direction
-- employee_id is the child, it is the value that uniquely identifies each row
-- the reports_to is the parent, it is the value that points to the parent row of the chilkd row 
select employee_id, title
from employee_chart
start with employee_id = 3
connect by reports_to = prior employee_id;

-- remove a branch
select employee_id, title
from employee_chart
start with employee_id = 1 
connect by prior employee_id = reports_to
and title <> 'SVP';
-- remove a node
select employee_id, title
from employee_chart
where title <> 'SVP'
start with employee_id = 1 
connect by prior employee_id = reports_to;



SELECT title, COUNT(*)
FROM books
GROUP BY category;



INSERT INTO (SELECT * FROM books WHERE title like '%WOK%')
VALUES (1000000, 'ABC', sysdate, 2,10,12, 'WONKY'); SELECT * FROM books WHERE title like '%WOK%'


select * from books;


