drop table army;
create table army
(id   integer primary key,
name varchar2(75),
co  integer);
Insert into army values (12,'General Roberts',null);
Insert into army values (1,'Colonel Markinson',12);
Insert into army values (14,'Major Miller',1);
Insert into army values (29,'Colonel Stamper',12);
Insert into army values (26,'Major Mainard',29);
Insert into army values (13,'Captain Imbens',26);
Insert into army values (16,'Lieutenant Brown',13);
Insert into army values (38,'Sargent Provasi',16);
Insert into army values (23,'Colonel Worrad',12);
Insert into army values (34,'Major Einhorn',23);
Insert into army values (7,'Captain Viano',34);
Insert into army values (10,'Lieutenant Mack',7);
Insert into army values (17,'Sargent Feeney',10);
Insert into army values (8,'Private Houng',17);
Insert into army values (35,'Private Hadi',17);
Insert into army values (37,'Private Joseph',17);
Insert into army values (36,'Private Player',17);
Insert into army values (9,'Private Endler',17);
Insert into army values (20,'Private Breiman',17);
Insert into army values (22,'Sargent Chelli',10);
Insert into army values (11,'Private Lietz',22);
Insert into army values (25,'Private Tringali',22);
Insert into army values (3,'Major Marko',23);
Insert into army values (15,'Captain Indard',3);
Insert into army values (24,'Captain Wyon',3);
Insert into army values (18,'Lieutenant Artin',24);
Insert into army values (27,'Sargent Vancer',18);
Insert into army values (30,'Private Davis',27);
Insert into army values (4,'Private Mcbride',27);
Insert into army values (28,'Private Omartian',27);
Insert into army values (31,'Private Ruda',27);
Insert into army values (5,'Private Sprecher',27);
Insert into army values (32,'Lieutenant Wolfe',24);
Insert into army values (6,'Sargent Esser',32);
Insert into army values (33,'Private Winters',6);
Insert into army values (19,'Sargent Mussino',32);
Insert into army values (2,'Private Duchemin',19);
Insert into army values (21,'Private Pittman',19);
commit;

select * from army order by 1;

-- ----------------------------------------- 
-- EXERCISES
-- -----------------------------------------
-- 1. DISPLAY THE ENTIRE ROSTER TOP DOWN
-- -----------------------------------------
      select id, lpad(' ',level*2) || name as soldier, co
      from army
      start with co is null
      connect by co = prior id
      order siblings by name;


-- -----------------------------------------
-- 2. PRINT SARGENT FEEENEY's REPORTING CHAIN
-- -----------------------------------------
--    which value is the child_id field for the root 
--    which is value of the parent_id for the root 
--    which direction is the question asking for
--    are you omitting a branch or a node?
      select id, lpad(' ',level*2) || name as soldier, co
      from army
      start with id = 17
      connect by prior co =  id
      order siblings by name;


-- -----------------------------------------
-- 3. PRINT GENERAL ROBERTS SOLDIERS
--    LEAVE OUT ALL LIEUTENANTS (THEY'RE ON VACATION)
-- -----------------------------------------
--    which value is the child
--    which is the parent
--    which direction is the question asking for
--    are you omitting a branch(s) or a node(s)?
      select id, lpad(' ',level*2) || name as soldier, co
      from army
--      where name not like 'Lie%'
      where name = 'General Roberts' and name not like 'Lie%'
      start with lower(name) like '%roberts%'
      connect by  co =  prior id
      order siblings by name;

      select id, lpad(' ',level*2) || name as soldier, co
      from army
--      where name not like 'Lie%'
      where name not like 'Lie%'
      start with id = 20
      connect by  prior co =  id
      order siblings by name;

-- -----------------------------------------
-- 4. PRINT GENERAL ROBERTS SOLDIERS
--    But exclude Captain Viano and his squad (they are not on base)
-- -----------------------------------------
    select id, lpad(' ',level*2) || name as soldier, co
      from army
      start with id = 12
      connect by co =  prior id    
         and name not like '%Viano%'
      order siblings by name;


