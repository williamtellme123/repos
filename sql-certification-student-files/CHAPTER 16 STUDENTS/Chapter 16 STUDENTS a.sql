-- =============================================================================
/*
    CHAPTER 16
    Interpret the Concept of a Hierarchical Query
    
    Relationship of two columns one table that forms hierarchical relationsip
      Parent ID, Child ID
      Top Down
      Bottom UP
    
    What can start with use for a column  
    Where to place keyword "prior"    
    
    
    Exclude single node from tree
    Exclude a whole brach
    
*/
-- -----------------------------------------------------------------------------
-- 1. THE WHERE CLAUSE REVISITED
--    Always just one question that is answered by TRUE or FALSE
--    Can have multiple parts using relational operators
--    Hint:
--    1. On Page 172 Table 5-1 write note "Compare Page 354 Table 9-1"
--    2. On Page 354 Table 9-1 write note "Compare Page 172 Table 5-1"

drop table army;
create table army
(id   integer primary key,
rank varchar2(15),
name varchar2(35),
co  integer);

insert into army(id,rank,name,co) values (12,'General','Roberts',null);
insert into army(id,rank,name,co) values (1,'Colonel','Marks',12);
insert into army(id,rank,name,co) values (14,'Major','Miller',1);
insert into army(id,rank,name,co) values (15,'Captain','Imbens',5);
insert into army(id,rank,name,co) values (18,'Lieutenant','Maven',22);
insert into army(id,rank,name,co) values (19,'Sargent','Mussino',23);
insert into army(id,rank,name,co) values (2,'Private','Duchemin',19);
insert into army(id,rank,name,co) values (21,'Private','Pittman',19);
insert into army(id,rank,name,co) values (23,'Colonel','Worrad',12);
insert into army(id,rank,name,co) values (3,'Major','Miller',23);
insert into army(id,rank,name,co) values (24,'Captain','Wyon',3);
insert into army(id,rank,name,co) values (26,'Lieutenant','Maven',24);
insert into army(id,rank,name,co) values (27,'Sargent','Viano',26);
insert into army(id,rank,name,co) values (4,'Private','Mcbride',27);
insert into army(id,rank,name,co) values (28,'Private','Omartian',27);
insert into army(id,rank,name,co) values (30,'Private','Provasi',27);
insert into army(id,rank,name,co) values (31,'Private','Davis',27);
insert into army(id,rank,name,co) values (5,'Private','Sprecher',27);
insert into army(id,rank,name,co) values (32,'Private','Ruda',27);
insert into army(id,rank,name,co) values (33,'Lieutenant','Wolfe',24);
insert into army(id,rank,name,co) values (6,'Sargent','Esser',33);
insert into army(id,rank,name,co) values (34,'Private','Winters',6);
insert into army(id,rank,name,co) values (35,'Major','Einhorn',23);
insert into army(id,rank,name,co) values (7,'Captain','Viano',35);
insert into army(id,rank,name,co) values (17,'Sargent','Feeney',7);
insert into army(id,rank,name,co) values (36,'Private','Hadi',17);
insert into army(id,rank,name,co) values (37,'Private','Player',17);
insert into army(id,rank,name,co) values (8,'Private','Houng',17);
insert into army(id,rank,name,co) values (38,'Private','Joseph',17);
insert into army(id,rank,name,co) values (9,'Private','Endler',17);
insert into army(id,rank,name,co) values (20,'Private','Breiman',17);
insert into army(id,rank,name,co) values (10,'Lieutenant','Maven',24);
insert into army(id,rank,name,co) values (22,'Sargent','Chelli',10);
insert into army(id,rank,name,co) values (25,'Private','Tringali',22);
insert into army(id,rank,name,co) values (11,'Private','Lietz',22);
insert into army(id,rank,name,co) values (29,'Major','Miller',1);
insert into army(id,rank,name,co) values (13,'Captain','Imbens',29);
insert into army(id,rank,name,co) values (16,'Lieutenant','Maven',13);
insert into army(id,rank,name,co) values (39,'Sargent','Provasi',39);


select lpad(' ',level*2) || rank || ' ' || name soldier
from army
--where name not like 'Lie%'
start with co is null
connect by co = prior id;

commit;

select * from army order by 1;

-- print Sargent Smiths reporting chain
-- -----------------------------------------
-- which value is the child
-- which is the parent
-- which direction is the question asking for
-- are you omitting a branch or a node?
select lpad(' ',2*level) || name
from army
start with name like 'Sargent S%'
connect by prior reports_to = id;

select lpad(' ',level*2) || name soldier
from army
--where name not like 'Lie%'
start with co is null
connect by co = prior id;










-- print General Roberts soldiers
-- leave out both lieutenants (they're on vacation)
-- -------------------------------------
-- which value is the child
-- which is the parent
-- which direction is the question asking for
-- are you omitting a branch(s) or a node(s)?

select lpad(' ',level*2) || name soldier
from army
where name not like 'Lie%'
start with reports_to is null
connect by reports_to = prior id;










-- print General Roberts soldiers
-- except Captain Tom and his squad
select lpad(' ' ,level*2)||name
from army
start with reports_to is null
connect by prior id = reports_to;
--    and name not like 'Captain T%';





--print both colonel's entire battalions 






select id, lpad(' ',level*2) || name
from army
start with id = 0
connect by reports_to = prior id
order siblings by name;






select * 
from employee_chart; 

select employee_id, title, reports_to, level
from employee_chart
start with employee_id = 1
connect by reports_to = prior employee_id;


select employee_id, lpad(' ',level*2) || title as title, reports_to, level
from employee_chart
start with employee_id = 1
connect by prior employee_id = reports_to;
--       by prior child = parent
--       TOP DOWN
-- =========================================
select employee_id, lpad(' ',level*2) || title as title, reports_to, level
from employee_chart
start with employee_id = 9
connect by employee_id = prior reports_to;
--       by child = prior parent
--       BOTTOM UP
-- =========================================

-- top down query starting with title = SVP
-- and use the lpad to format it

select lpad(' ',level*2) || title
from employee_chart
start with title = 'SVP'
connect by prior employee_id = reports_to;

select lpad(' ',level*2) || title
from employee_chart
start with title like '%VP'
connect by prior employee_id = reports_to;

-- remove a whole branch
-- from the result set
select lpad(' ',level*2) || title as title
from employee_chart
start with title = 'CEO'
connect by prior employee_id = reports_to
  and title <> 'SVP';

-- remove a single node
-- from the result set
-- remove just the VP
-- use the where clause

select lpad(' ' ,level*2) || title as title
from employee_chart
where title <> 'VP'
start with reports_to is null
connect by prior employee_id = reports_to;
-- sys_connect_by_path
select lpad(' ' ,level*2) || title as title, sys_connect_by_path(title,'/') as title2, connect_by_root title as headhoncho
from employee_chart
start with reports_to is null
connect by prior employee_id = reports_to;

-- ordewr by siblings vs. order by
select lpad(' ',level*2) || title 
        title_formatted
from employee_chart
start with title = 'CEO'
connect by reports_to = prior employee_id
order siblings by title;







select employee_id, lpad(' ',level*2) || title as title
from employee_chart
start with title = 'CEO'
connect by reports_to = prior employee_id;



select title, level
from employee_chart
start with title = 'CEO'
connect by reports_to = prior employee_id;



-- ============================================
select * from employee_chart;
-- Top down
select level, lpad (' ',level*2) || title as title
from employee_chart
start with employee_id = 1
connect by reports_to = prior employee_id;
-- Bottom Up
select level, lpad (' ',level*2) || title as title
from employee_chart
start with employee_id = 9
connect by prior reports_to = employee_id;

-- First identify the relationshiop between levels
-- Parent and child
-- Then determine which value in the table is the parent
-- and which is the child on each row
-- Child is represented by the employee_id
-- Parent is represented by the reports_to (id)
select * from employee_chart where employee_id = 5;
-- EMPLOYEE_ID    TITLE       REPORTS_TO
-- -----------    ------      -----------
--    5	          Director1	      2

-- In this example the 5 (employee_id) is the child
-- and the 2 (reports_to) is the parent 
-- TOP DOWN
select level, lpad (' ',level*2) || title as title
from employee_chart
start with employee_id = 1
connect by reports_to = prior employee_id;
-- -----------------------------------------
select level, lpad (' ',level*2) || title as title, 'reports to -->' || prior title
from employee_chart
start with employee_id = 1
connect by reports_to = prior employee_id;

-- top down means "prior" is used with the child column
-- prior is on the same side of the equals sign as the child
select level, lpad (' ',level*2) || title as title
from employee_chart
start with employee_id = 1
connect by prior employee_id = reports_to;
-- ---------------------------------------------
--BOTTOM UP
select level, lpad (' ',level*2) || title as title
from employee_chart
start with employee_id = 6
connect by prior reports_to = employee_id;
--
select level, lpad (' ',level*2) || title as title
from employee_chart
start with employee_id = 6
connect by  employee_id = prior reports_to;
-- 
-- exclude a single node from an entire tree
-- use the where clause
-- top down
select level, lpad (' ',level*2) || title as title
from employee_chart
-- where employee_id <> 3
start with employee_id = 1
connect by reports_to = prior employee_id; 
-- bottom up
select level, lpad (' ',level*2) || title as title
from employee_chart
where employee_id <> 2
start with employee_id = 9
connect by prior reports_to = employee_id; 

-- exclude an entire branch
-- top down
-- done with the and cluase
select level, lpad (' ',level*2) || title as title
from employee_chart
start with employee_id = 1
connect by reports_to = prior employee_id
and title <> 'VP'; 


--1. Return all of the SVP's Department
select level, lpad(' ' ,level*2)||title as title
from employee_chart
start with employee_id = 3
connect by prior employee_id = reports_to;

-- 2. Return all of Director 4's reporting chain except her manager
select level, lpad(' ' ,level*2) || title as title
from employee_chart
where employee_id <> 3
start with employee_id = 1
connect by  reports_to = prior employee_id
and title <> 'VP'
and title <> 'CFO';

-- 

select level, lpad(' ' ,level*2) || title as title
from employee_chart
where employee_id <> 3
start with employee_id = 8
connect by prior reports_to = employee_id;

-- Need to know how to start with one node and go top to bottom
-- Need to know how to start with one node and go bottom up
-- Need to know how to exclude a single node
-- Need to know how to exclude a whole branch

select level, lpad(' ' ,level*2) || title as title
from employee_chart
where title <> 'SVP'
start with employee_id = 8
connect by prior reports_to = employee_id;

-- connect by path
-- connect by root
select level
      ,  lpad(' ',level*2) || title as title
      , sys_connect_by_path(title,'/')
      , connect_by_root title
from employee_chart
start with title = 'CEO'
connect by prior employee_id = reports_to;

-- order siblings by 
select level,  lpad(' ',level*2) || title as title
from employee_chart
start with title = 'CEO'
connect by prior employee_id = reports_to
order by title;

select level,  lpad(' ',level*2) || title as title
from employee_chart
start with title = 'CEO'
connect by prior employee_id = reports_to
order siblings by title;


main(F)
  documents(F)
    region1.doc
    region2.doc
    region1.ppt
  reports(F)
          Q12014.xls
          Q22014.xls
          Q32014.xls
          Q42014.xls
      employees(F)
          west.doc
          east.doc
      stores(F)    
          west.doc
          east.doc
insert into files values (500,2,'region1.doc');
insert into files values (501,2,'region2.doc');
insert into files values (502,2,'region1.ppt');
insert into files values (503,3,'Q12014.xls');
insert into files values (504,3,'Q22014.xls');
insert into files values (505,3,'Q32014.xls');
insert into files values (506,3,'Q42014.xls');
insert into files values (507,4,'west.doc');
insert into files values (508,4,'east.doc');
insert into files values (509,5,'west.doc');
insert into files values (510,5,'east.doc');
commit;
select * from files;
insert into directories values (1,'Main', null);
insert into directories values (2,'documents',1);
insert into directories values (3,'reports',1);
insert into directories values (4,'employees',3);
insert into directories values (5,'stores',3);
commit;
select * from directories;

create table directories
(did   integer,
 directory_name varchar2(10),
 pdid  integer);
 
 create table files
 (fid    integer,
  dir_id  integer,
  file_name  varchar2(15));
 
-- 1. Start with the join
-- 2. do the hierarchical on the directories
-- 3. put these two together
-- ----------------------------------
-- 1.
select directory_name,file_name
from directories join files on did = dir_id;
-- ----------------------------------
-- 2.
select lpad(' ',level*2) || directory_name dir_name
from directories
start with did = 1
connect by pdid = prior did;
-- ----------------------------------
-- 3.
select d.did, d.pdid, d.directory_name, f.file_name
from directories d,
     files f 
where d.did = f.dir_id
start with d.did = 1
connect by d.pdid = prior d.did;


select d.did, d.directory_name, f.file_name
from directories d,
     files f 
where d.did = f.dir_id
start with d.did = 1
connect by d.pdid = prior d.did;


create table distributors
(id  integer,
location varchar2(15),
loc_type  varchar2(15),
upline integer);


select * from distributors;

select level, lpad(' ',level*2) || location as location
from distributors
--start with id = 1
--start with id = 7
start with loc_type = 'REGIONAL'
--start with loc_type = 'LOCAL'
connect by prior id = upline;




select * from distributors;

select level, loc_type,location
from distributors
start with loc_type = 'HQ'
connect by prior id = upline 
order by location;

select level, loc_type,location
from distributors
start with loc_type = 'HQ'
connect by id = prior upline 
order by location;

select * from employee_chart;

select level, lpad(' ',level*2) || location, loc_type
from distributors
start with loc_type = 'REGIONAL'
connect by prior id = upline 
order siblings by location;




------------ Forwarded message ----------
--From: Ayer Edwards <budoist@gmail.com>
--Date: Wed, Jun 18, 2014 at 9:15 PM
--Subject: PSN - Hierarchy (working?)
--To: wrogers <wrogers@austin.rr.com>
--
--
--This is what I did to make it work:

insert into files values(511,1,'test.doc');
select level, lpad(' ',level*2) || directory_name dir_name, file_name, sys_connect_by_path(directory_name,'/')
  from directories left join files on dir_id = did
  start with did = 1
  connect by prior did =  pdid
  order siblings by directory_name desc, file_name desc;





select * from directories;
select * from files;




















