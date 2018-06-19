-- =============================================================================
-- HOMEWORK SETUP
-- =============================================================================
-- LOGIN INTO YOUR OWN SCHEMA
-- Run the following statements IN YOUR OWN SCHEMA
--
--                IN YOUR OWN SCHEMA
--                drop table biology101;
--                create table biology101
--                (
--                    sid            integer primary key,
--                    STUDENT_ID    integer,
--                    FIRST_NAME    varchar2(25),
--                    LAST_NAME     varchar2(25),
--                    SEMESTERSCORE integer
--                );
--                select * from biology101;
--                Insert into biology101 values (1,101,'Becky','Thomson',75);
--                Insert into biology101 values (2,22,'Sandy','Beech',89);
--                Insert into biology101 values (3,101,'Becky','Thomson',81);
--                Insert into biology101 values (4,33,'Tom','Thumb',95);
--                Insert into biology101 values (5,15,'Tim','Snout',64);
--                Insert into biology101 values (6,22,'Sandy','Beech',99);
--                Insert into biology101 values (7,101,'Becky','Thomson',69);
--                Insert into biology101 values (8,33,'Tom','Thumb',84);
--                Insert into biology101 values (9,22,'Sandy','Beech',85);
--                Insert into biology101 values (10,101,'Becky','Thomson',88);
--                Insert into biology101 values (11,15,'Tim','Snout',79);
--                Insert into biology101 values (12,22,'Sandy','Beech',82);
--                Insert into biology101 values (13,33,'Tom','Thumb',97);
--                Insert into biology101 values (14,15,'Tim','Snout',67);
--                Insert into biology101 values (15,101,'Becky','Thomson',88);
--                Insert into biology101 values (16,22,'Sandy','Beech',91);
--                commit;
-- -----------------------------------------------------------------------------
-- LOGIN IN AS CRUISES
-- Run the following statements IN CRUISES
--
--               IN CRUISES
--
--               1. LOGIN as CRUISES
--               2. Choose File > Open > Create_EFCodd_Version_X_Script_01.sql
--               3. Place your cursor into the script
--               4. Press CTRL-A
--               5. Press CTRL-Enter
--               6. Click the x on the tab to close the file (do not save any changes)
--               7. Choose File > Open > Create_EFCodd_Version_X_Script_02.sql
--               8. Place your cursor into the script
--               9. Press CTRL-A
--               10. Press CTRL-Enter
--               11. Click the x on the tab to close the file (do not save any changes)
--  
-- -----------------------------------------------------------------------------
-- LOGIN IN AS CRUISES
-- Run the following statements IN CRUISES
--
--               IN CRUISES
--
--
alter table cruises modify (status varchar2(15));
alter table cruises modify (cruise_name varchar2(100));
--
Insert into employees values (8,1,'Howard','Hoddlestein',2,null,null,null);
Insert into employees values (9,3,'Jane','Crema',2,null,null,null);
Insert into employees values (10,4,'Leigh','Maddern',2,null,null,null);
Insert into employees values (11,3,'Rosanne','Martin',2,null,null,null);
Insert into employees values (12,1,'Susan','Doyle',2,null,null,null);
Insert into employees values (13,2,'Joey','LaRoach',2,null,null,null);
Insert into employees values (14,1,'Mike','Currie',2,null,null,null);
Insert into employees values (15,1,'Rick','Cadran',2,null,null,null);
Insert into employees values (16,2,'Richard','Green',2,null,null,null);
Insert into employees values (17,4,'Danny','Felton',2,null,null,null);
Insert into employees values (18,3,'Dana','Wonsey',2,null,null,null);
Insert into employees values (19,1,'Steve','Gunn',2,null,null,null);
Insert into employees values (20,2,'Ron','Ponchione',2,null,null,null);
Insert into employees values (21,1,'Truck','Wallace',2,null,null,null);
Insert into cruises values (101,4,'Another World',1,20,to_date('03-JAN-16','DD-MON-RR'),to_date('11-JAN-16','DD-MON-RR'),'DOCKED');
Insert into cruises values (723,1,'Are We There Yet',4,14,to_date('13-JUN-16','DD-MON-RR'),to_date('19-JUN-16','DD-MON-RR'),'MAINTENANCE');
Insert into cruises values (601,3,'Away We Go ',1,5,to_date('02-AUG-16','DD-MON-RR'),to_date('11-AUG-16','DD-MON-RR'),'CANCELLED');
Insert into cruises values (175,5,'Beyond The Sea',2,21,to_date('29-SEP-16','DD-MON-RR'),to_date('09-OCT-16','DD-MON-RR'),'DOCKED');
Insert into cruises values (700,5,'Bon Voyage',3,16,to_date('25-JUN-16','DD-MON-RR'),to_date('29-JUN-16','DD-MON-RR'),'CANCELLED');
Insert into cruises values (235,2,'Distant Shores',1,11,to_date('12-MAR-16','DD-MON-RR'),to_date('22-MAR-16','DD-MON-RR'),'MAINTENANCE');
Insert into cruises values (452,5,'Don?t Let It End',4,4,to_date('10-MAY-16','DD-MON-RR'),to_date('18-MAY-16','DD-MON-RR'),'CANCELLED');
Insert into cruises values (475,1,'Down In The Boondocks',5,12,to_date('13-SEP-16','DD-MON-RR'),to_date('18-SEP-16','DD-MON-RR'),'DOCKED');
Insert into cruises values (125,2,'Enchanted Island',1,5,to_date('05-FEB-16','DD-MON-RR'),to_date('08-FEB-16','DD-MON-RR'),'DOCKED');
Insert into cruises values (128,5,'Escapade',4,18,to_date('08-APR-16','DD-MON-RR'),to_date('14-APR-16','DD-MON-RR'),'CANCELLED');
Insert into cruises values (693,4,'Every Which Way But Loose',4,10,to_date('24-SEP-16','DD-MON-RR'),to_date('30-SEP-16','DD-MON-RR'),'MAINTENANCE');
Insert into cruises values (320,2,'Fantastic Voyage',3,1,to_date('22-JUN-16','DD-MON-RR'),to_date('01-JUL-16','DD-MON-RR'),'UNDERWAY');
Insert into cruises values (596,2,'Free And Easy ',1,12,to_date('26-OCT-16','DD-MON-RR'),to_date('31-OCT-16','DD-MON-RR'),'CANCELLED');
Insert into cruises values (118,4,'Foot Loose and Fancy Free ',3,3,to_date('02-JUN-16','DD-MON-RR'),to_date('11-JUN-16','DD-MON-RR'),'UNDERWAY');
Insert into cruises values (376,2,'From Here To Eternity',3,17,to_date('27-OCT-16','DD-MON-RR'),to_date('31-OCT-16','DD-MON-RR'),'DOCKED');
Insert into cruises values (617,5,'Go Tell It On The Mountain ',3,14,to_date('10-APR-16','DD-MON-RR'),to_date('15-APR-16','DD-MON-RR'),'MAINTENANCE');
Insert into cruises values (569,3,'The Beginning Of The End',5,4,to_date('19-FEB-16','DD-MON-RR'),to_date('26-FEB-16','DD-MON-RR'),'MAINTENANCE');
Insert into cruises values (137,5,'Pack Your Bags And Leave Tonight',5,17,to_date('25-JAN-16','DD-MON-RR'),to_date('01-FEB-16','DD-MON-RR'),'DOCKED');
Insert into cruises values (565,5,'On The Road Again ',1,14,to_date('23-SEP-16','DD-MON-RR'),to_date('26-SEP-16','DD-MON-RR'),'DOCKED');
Insert into cruises values (371,1,'Permanent Vacation',3,17,to_date('07-NOV-16','DD-MON-RR'),to_date('14-NOV-16','DD-MON-RR'),'CANCELLED');
Insert into cruises values (103,4,'Rugged Route ',2,14,to_date('19-JAN-16','DD-MON-RR'),to_date('28-JAN-16','DD-MON-RR'),'UNDERWAY');
Insert into cruises values (658,1,'This Is Paradise',3,9,to_date('07-JAN-16','DD-MON-RR'),to_date('12-JAN-16','DD-MON-RR'),'DOCKED');
Insert into cruises values (274,1,'Way To Go ',3,1,to_date('12-SEP-16','DD-MON-RR'),to_date('21-SEP-16','DD-MON-RR'),'UNDERWAY');
Insert into cruises values (225,2,'Gulliver''s Travels ',3,14,to_date('22-FEB-16','DD-MON-RR'),to_date('25-FEB-16','DD-MON-RR'),'MAINTENANCE');
Insert into cruises values (169,4,'Midnight At The Oasis',2,19,to_date('16-MAY-16','DD-MON-RR'),to_date('25-MAY-16','DD-MON-RR'),'UNDERWAY');
Insert into cruises values (628,1,'No, We Are Not There Yet',1,5,to_date('14-NOV-16','DD-MON-RR'),to_date('23-NOV-16','DD-MON-RR'),'MAINTENANCE');
Insert into cruises values (248,1,'Peaceful Easy Feeling',1,10,to_date('06-SEP-16','DD-MON-RR'),to_date('13-SEP-16','DD-MON-RR'),'MAINTENANCE');
Insert into cruises values (621,3,'Room With A View ',1,17,to_date('22-AUG-16','DD-MON-RR'),to_date('29-AUG-16','DD-MON-RR'),'CANCELLED');
Insert into cruises values (640,1,'The Last Mile Home',4,14,to_date('28-APR-16','DD-MON-RR'),to_date('04-MAY-16','DD-MON-RR'),'MAINTENANCE');
Insert into cruises values (541,4,'This Is Some Vacation',5,8,to_date('20-JUN-16','DD-MON-RR'),to_date('26-JUN-16','DD-MON-RR'),'UNDERWAY');
Insert into cruises values (229,3,'Tourist Trap ',1,2,to_date('25-JAN-16','DD-MON-RR'),to_date('30-JAN-16','DD-MON-RR'),'CANCELLED');
Insert into cruises values (216,2,'We''re Off ',2,17,to_date('02-FEB-16','DD-MON-RR'),to_date('08-FEB-16','DD-MON-RR'),'UNDERWAY');
Insert into cruises values (585,3,'Where In The World Is Carmen Sandiego? ',3,11,to_date('16-APR-16','DD-MON-RR'),to_date('26-APR-16','DD-MON-RR'),'MAINTENANCE');
Insert into cruises values (676,5,'Wish You Were Here ',2,9,to_date('10-SEP-16','DD-MON-RR'),to_date('18-SEP-16','DD-MON-RR'),'UNDERWAY');
Insert into cruises values (444,2,'World Traveler ',4,15,to_date('08-AUG-16','DD-MON-RR'),to_date('13-AUG-16','DD-MON-RR'),'MAINTENANCE');
Insert into cruises values (592,1,'Homeward Bound ',1,19,to_date('19-JAN-16','DD-MON-RR'),to_date('24-JAN-16','DD-MON-RR'),'UNDERWAY');
commit;
-- =============================================================================


-- *****************************************************************************
-- HOMEWORK EXERCISES
-- *****************************************************************************
-- -----------------------------------------------------------------------------
-- 1 GRADING BIOLOGY 101
     select * from biology101;  
--   Now use DECODE or CASE statement to return student names and letter grades 
--          A for 90-100
--          B for 80-89
--          C for 70-79
--          D for 60-69
--          F for 40-59
--          INC below 40 


-- -----------------------------------------------------------------------------
-- 2. NEWEST HIRES to SEND to TRAINING (cruises)
--    Return the newest hired employee(s) and ship name for all ships  





-- -----------------------------------------------------------------------------
-- 3. SHIPPING NEWSLETTER (cruises)
--    Return the ship name, its captain, and the name of its home port 
