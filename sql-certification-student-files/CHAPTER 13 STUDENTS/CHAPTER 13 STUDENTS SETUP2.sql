-- =============================================================================
/* 
   Chapter 13
      1. EXAMINE DATA
      2. AGGREGATE FUNCTIONS
      3. GROUP BY ROLLUP
      4. GROUP BY CUBE
      5. GROUPING
*/
-- =============================================================================

-- -----------------------------------------------------------------------------
--  1. EXAMINE DATA
-- -----------------------------------------------------------------------------
--  Find a few rows to deal with
--  CRUISES (3 rows)
    select room_style,
           room_type,
           sq_ft
    from cruises.ship_cabins
    where ship_cabin_id < 7
    and ship_cabin_id   > 3
    order by 1;

-- POPULATION (3 rows)
    select * from population;
    select county, wug_name, river_basin, pop_in_2020
    from population
    where county = 'REAL';

-- WATERSHEDS (4 rows)
    select * from watersheds;
    select county, river_basin, subdiv,sum(pop)
    from watersheds
    group by  rollup (county, river_basin, subdiv)
    order by 3;



-- -----------------------------------------------------------------------------
--  2. AGGREGATE FUNCTIONS
-- -----------------------------------------------------------------------------
-- NUMBER OF AGGREGATIONS TYPE  
-- a. 1 COLUMN
    select room_style,
           count(*),
           sum(sq_ft)
    from cruises.ship_cabins
--    where ship_cabin_id < 7 and ship_cabin_id  > 1
    group by room_style, room_type
    order by 1;
-- NUMBER OF AGGREGATION TYPES? 

-- ----------------------------
-- b. 2 COLUMN
    select room_style,
           room_type,
           count(*),
           sum(sq_ft)
    from cruises.ship_cabins
--    where ship_cabin_id < 7 and ship_cabin_id  > 1
    group by room_style, room_type
    order by 1;
-- NUMBER OF AGGREGATION TYPES?

-- ----------------------------
-- c. 3 COLUMN
    select room_style,
           room_type,
           window,
           count(*),
           sum(sq_ft)
    from cruises.ship_cabins
--    where ship_cabin_id < 7 and ship_cabin_id  > 1
    group by room_style, room_type, window
    order by 1;
-- NUMBER OF AGGREGATION TYPES?

-- -----------------------------------------------------------------------------
--  3. GROUP BY ROLLUP
-- -----------------------------------------------------------------------------
-- NUMBER OF AGGREGATIONS TYPE RULE N + 1 (n is the number of columns)
-- ----------------------------
-- A. 
    --  1 COLUMN
        select room_style, count(*), sum(sq_ft)
        from cruises.ship_cabins
        where 1=1 
        --and ship_cabin_id < 7 and ship_cabin_id   > 3
        group by rollup(room_style)
        order by 1;
    --  NUMBER OF AGGREGATION TYPES?
    
    --  1 COLUMN
        select county, count(*), sum(pop_in_2020)
        from population
        where county = 'REAL'
        group by rollup(county);
    --  NUMBER OF AGGREGATION TYPES?
    
    --  1 COLUMN
        select county, sum(pop)
        from watersheds
        group by  rollup (county);
    --  NUMBER OF AGGREGATION TYPES?
-- ----------------------------
-- B. 
  --  2 COLUMNS
      select * from cruises.ship_cabins;
      select   room_style
             , room_type
             , count(*)
             , sum(sq_ft)
      from cruises.ship_cabins
      --    where ship_cabin_id < 7 and ship_cabin_id  > 1
      group by rollup(room_style, room_type);
  --  NUMBER OF AGGREGATION TYPES?      

  --  2 COLUMNS
        select * from population;
        select county
              , wug_name
              , sum(pop_in_2020)
        from population
        where county = 'REAL'
        group by rollup(county, wug_name);
  --  NUMBER OF AGGREGATION TYPES?        
 
  --  2 COLUMNS
        select * from watersheds;
        select county
              , river_basin
              , sum(pop)
        from watersheds
        group by  rollup (county, river_basin);
  --  NUMBER OF AGGREGATION TYPES?
-- ----------------------------
-- C. 
    --  3 COLUMNS
      select * from cruises.ship_cabins;
      select   room_style
             , room_type
             , window
             , count(*)
             , sum(sq_ft)
      from cruises.ship_cabins
      --    where ship_cabin_id < 7 and ship_cabin_id  > 1
      group by rollup(room_style, room_type, window);
    --  NUMBER OF AGGREGATION TYPES?
    
    --  3 COLUMNS
        select * from population;
        select county
              , wug_name
              , river_basin
              , sum(pop_in_2020)
        from population
        where county = 'REAL'
        group by rollup(county, wug_name, river_basin);
    --  NUMBER OF AGGREGATION TYPES?   
    
    --  3 COLUMNS
        select * from watersheds;
        select county
              , river_basin
              , subdiv
              , sum(pop)
        from watersheds
        group by  rollup (county, river_basin, subdiv);
    --  NUMBER OF AGGREGATION TYPES?
-- -----------------------------------------------------------------------------
--  4. GROUP BY CUBE
-- -----------------------------------------------------------------------------
--     NUMBER OF AGGREGATIONS TYPE RULE N ^ 2 (n is the number of columns)
-- ----------------------------
-- A. 
    --  1 COLUMN
        select room_style, count(*), sum(sq_ft)
        from cruises.ship_cabins
        where 1=1 
        --and ship_cabin_id < 7 and ship_cabin_id   > 3
        group by cube(room_style)
        order by 1;
    --  NUMBER OF AGGREGATION TYPES?

    --  1 COLUMN
        select county, count(*), sum(pop_in_2020)
        from population
        where county = 'REAL'
        group by cube(county);
    --  NUMBER OF AGGREGATION TYPES?

    --  1 COLUMN
        select county, sum(pop)
        from watersheds
        group by  cube (county);
    --  NUMBER OF AGGREGATION TYPES?

-- ----------------------------
-- B. 
  --  2 COLUMNS
      select * from cruises.ship_cabins;
      select   room_style
             , room_type
             , count(*)
             , sum(sq_ft)
      from cruises.ship_cabins
      --    where ship_cabin_id < 7 and ship_cabin_id  > 1
      group by cube(room_style, room_type);

  --  2 COLUMNS
        select * from population;
        select county
              , wug_name
              , sum(pop_in_2020)
        from population
        where county = 'REAL'
        group by cube(county, wug_name);
 
  --  2 COLUMNS
        select * from watersheds;
        select county
              , river_basin
              , sum(pop)
        from watersheds
        group by  cube (county, river_basin);

-- ----------------------------
-- C. 
    --  3 COLUMNS
      select * from cruises.ship_cabins;
      select   room_style
             , room_type
             , window
             , count(*)
             , sum(sq_ft)
      from cruises.ship_cabins
      --    where ship_cabin_id < 7 and ship_cabin_id  > 1
      group by cube(room_style, room_type, window);

    --  3 COLUMNS
        select * from population;
        select county
              , wug_name
              , river_basin
              , sum(pop_in_2020)
        from population
        where county = 'REAL'
        group by cube(county, wug_name, river_basin);
    
    --  3 COLUMNS
        select * from watersheds;
        select county
              , river_basin
              , subdiv
              , sum(pop)
        from watersheds
        group by  cube (county, river_basin, subdiv);
        
        
-- Examine the following SQL
Select battalion, company, platoon, sum(troop) 
from reserves
group by cube (battalion, company, platoon) 
order by 2, 3, 1;

-- ANSWER THE FOLLOWING QUESTIONS
-- 1.	How many different aggregate types are there        
--    No.1 : 8
-- 2.	How many (total) rows are returned
--    No.2 : 18
-- 3.	Is there an aggregate for all unique values in the column company. If yes what?
--    No.3 :  Yes 
--            Bravo 600   
--            Charlie 100
-- 4.	Is there an aggregate for all unique combinations of company and platoon. If yes what?
--    No.4 :  Yes 
--            Bravo	Deep Country	400
--            Bravo	Night Train	200
--            Charlie	Night Train	100
-- 5.	Is there an aggregate for all unique values battalion. If yes what?
--    No.1 : 5 Yes 
--           West A			700
-- 6.	What is in Row 7 Column 2 of the result set
--    No.1 : Bravo

select battalion, company, platoon, sum(troop) 
from reserves
group by cube (battalion, company, platoon)
order by 2,3,1;

select battalion, company,platoon
from reserves
where battalion in ('West A', 'Show Horse','');


select battalion, company,platoon, sum(troop)
from reserves
where battalion in ('West A', 'Show Horse','')
group by cube(battalion, company,platoon)
order by 2,3,1;

-- -----------------------------------------------------------------------------
--  5. GROUPING
-- -----------------------------------------------------------------------------
-- 0 Basic Group By (set of columns is all columns)
-- 1 Some any other set of columns (at least 1 is null)
    select    grouping(room_type)
            , room_style
            , room_type
            , round(sum(sq_ft),2) sum_sq_ft
    from cruises.ship_cabins
    where ship_id = 1
    group by rollup (room_style, room_type)
    order by room_style, room_type;

    select nvl(
                  decode(grouping(room_type),
                          1,upper(room_style),
                          initcap(room_style)),
          'GRAND TOTALl') as formatted
          , room_type
          , sum(sq_ft) sum_sq_ft
    from cruises.ship_cabins
    where ship_id = 1
    group by rollup (room_style, room_type)
    order by room_style, room_type;


-- -----------------------------------------------------------------------------
--  5. GROUPING SETS
-- -----------------------------------------------------------------------------
-- Typical cube
      select  window
            , room_style
            , room_type
            , sum(sq_ft) as sum_sq_ft
      from cruises.ship_cabins
      where ship_id = 1
      group by cube(window, room_style, room_type)
      order by window, room_style, room_type;


      select  window
            , room_style
            , room_type
            , sum(sq_ft) as sum_sq_ft
      from cruises.ship_cabins
      where ship_id = 1
      group by grouping sets((window, room_style),(room_type),null)
      order by window, room_style, room_type;


-- -----------------------------------------------------------------------------
--  THINKING FOR HOME
-- -----------------------------------------------------------------------------
-- Help understanding GROUPING 
-- Type in the code from Page 517
      select  room_style
            , grouping(room_style)
            , room_type
            , grouping(room_style)
            , sum(sq_ft)
      from cruises.ship_cabins
      where ship_cabin_id between 5 and 7
      group by rollup (room_style, room_type)
      order by Room_style, room_type;

-- Help understanding GROUPING SETS
-- Type in the code from Page 520
    select window, room_style, room_type, sum(sq_ft) as sq_ft
    from cruises.ship_cabins
    where ship_id = 1
    group by grouping sets((room_type), null,(window, room_style))
    order by window, room_style, room_type;
                opulation;





select county, wug_name, river_basin, sum(pop_in_2020)
from population where county in('WILLIAMSON') and wug_name ='AUSTIN'
group by cube (county, wug_name, river_basin);


--drop user texas cascade;
---- if it fails disconnect form the left and rerun
--
--create user texas identified by texas;
--grant all privileges to texas;


select * from population;

select county, sub_div, river_basin,p2020
from population
where county in ('ARMSTRONG','CARSON');
-- ============================================
select county, sum(p2020)
from population
where county in ('ARMSTRONG','CARSON')
group by county;

select county, sum(p2020)
from population
where county in ('ARMSTRONG','CARSON')
group by rollup (county);
-- ============================================
select county, river_basin, sum(p2020)
from population
where county in ('ARMSTRONG','CARSON')
group by county, river_basin;

select county, river_basin, sum(p2020)
from population
where county in ('ARMSTRONG','CARSON')
group by rollup (county, river_basin);
-- ============================================
select county, river_basin, sub_div, sum(p2020)
from population
where county in ('ARMSTRONG','CARSON')
group by county, river_basin, sub_div
order by 1,2,3;

select county, river_basin, sub_div, sum(p2020)
from population
where county in ('ARMSTRONG','CARSON')
group by rollup (county, river_basin,sub_div)
order by 1,2,3;
-- ============================================
create table temp
(rn, cnt, rb, sd,pop) as
select rownum,county, river_basin, sub_div, p2020
from population
where region = 'P';
select * from temp;

update temp set sd = 'EDNA' where rn = 5;
update temp set rb = 'LAVACA' where rn = 3;
update temp set rb = 'LAVACA' where rn = 1;
delete from temp where rn > 12;
commit;

select cnt, rb,sd, sum(pop) 
from temp
group by cnt,rb,sd
order by 1,2,3;

select cnt, rb,sd 
from temp
order by 1,2,3;


select cnt, rb,sd, sum(pop) 
from temp
group by rollup(cnt,rb,sd)
order by 1,2,3;

-- ============================================
select county, p2020 from population where county in ('ARMSTRONG','CARSON');

select county, river_basin,sum(p2020)
from population
where county in ('ARMSTRONG','CARSON')
group by county,river_basin;

select county, river_basin, sum(p2020)
from population
where county in ('ARMSTRONG','CARSON')
group by cube (county,river_basin)
order by 1,2;
-- ============================================
select county, river_basin, sub_div, p2020 from population 
where county in ('ARMSTRONG','CARSON') order by 1,2,3;

select county, river_basin, sub_div, sum(p2020)
from population
where county in ('ARMSTRONG','CARSON')
group by county,river_basin, sub_div;

select county, river_basin, sub_div, sum(p2020)
from population
where county in ('ARMSTRONG')
group by cube (county,river_basin,sub_div)
order by 1,2,3;

-- create a table with four rows and 4 columns
-- county    river_basin      sub_div   pop
-- Grover    RED              A12       200
-- Grover    LAVACA           S-22      300
-- Winston   COLORADO         R-5`      400

select county, river_basin, sub_div, sum(pop)
from mytable
group by rollup (county, river_basin,sub_div)
order by 1,2,3;

select county, river_basin, sub_div, sum(pop)
from mytable
group by cube (county, river_basin,sub_div)
order by 1,2,3;
-- 1. Number of different aggregates
-- 2. Number of rows
-- 3. Aggregate where RED is the only consideration
-- 4. What is Row 2 Col 2
-- 5. Is there an aggregate for river_basin and sub_div


desc population;
alter table population rename column wug_name
      to sub_div;


select * from population;
-- standard aggregate function from chapter 7
select county, sum(p2020)
from population
where county = 'FANNIN'
group by county;

select county, sum(p2020)
from population
where county = 'FANNIN'
group by rollup(county);

-- ---------------------
select county, sub_div, sum(p2020)
from population
where county in ('FANNIN','AUSTIN')
group by county, sub_div
order by 1,2;

select county, sub_div, sum(p2020)
from population
where county in ('FANNIN','AUSTIN')
group by rollup(county, sub_div);




086,7020,8019,9202,10544);
Insert into POPULATION values (143,'C','COLLIN','PARKER','TRINITY',6000,16000,20000,20000,20000,20000);
Insert into POPULATION values (144,'C','COLLIN','PLANO','TRINITY',260500,270200,282656,284656,284656,284656);
Insert into POPULATION values (145,'C','COLLIN','PRINCETON','TRINITY',9080,11880,15290,36295,57300,78304);
Insert into POPULATION values (146,'C','COLLIN','PROSPER','TRINITY',20004,28022,32637,33848,35058,35058);
Insert into POPULATION values (147,'C','COLLIN','RICHARDSON','TRINITY',31522,31714,32974,34000,34000,34000);
Insert into POPULATION values (148,'C','COLLIN','ROYSE CITY','SABINE',1639,5500,12000,20000,38000,40906);
Insert into POPULATION values (149,'C','COLLIN','SACHSE','TRINITY',7899,7899,7899,7899,7899,7899);
Insert into POPULATION values (150,'C','COLLIN','SEIS LAGOS UD','TRINITY',2130,2130,2130,2130,2130,2130);
Insert into POPULATION values (151,'C','COLLIN','SOUTH GRAYSON WSC','TRINITY',1166,1456,1947,2275,2627,2989);
Insert into POPULATION values (152,'C','COLLIN','ST. PAUL','TRINITY',1965,2255,2453,2559,2666,2666);
Insert into POPULATION values (153,'C','COLLIN','WESTON','TRINITY',3370,7159,32647,79837,127026,127026);
Insert into POPULATION values (154,'C','COLLIN','WYLIE','TRINITY',42126,47666,51294,54120,55946,57599);
Insert into POPULATION values (155,'C','COLLIN','WYLIE NORTHEAST SUD','TRINITY',1889,2390,3000,6000,10000,16000);
Insert into POPULATION values (156,'C','COOKE','BOLIVAR WSC','TRINITY',1631,1751,1842,1934,2010,2076);
Insert into POPULATION values (157,'C','COOKE','COUNTY-OTHER','RED',1824,1928,2029,2272,2806,4600);
Insert into POPULATION values (158,'C','COOKE','COUNTY-OTHER','TRINITY',6676,7072,7695,10728,12194,26400);
Insert into POPULATION values (159,'C','COOKE','GAINESVILLE','RED',26,28,29,31,37,52);
Insert into POPULATION values (160,'C','COOKE','GAINESVILLE','TRINITY',17310,18579,19553,20521,24963,34948);
Insert into POPULATION values (161,'C','COOKE','LAKE KIOWA SUD','TRINITY',2209,2247,2286,2325,2363,2363);
Insert into POPULATION values (162,'C','COOKE','LINDSAY','TRINITY',1102,1183,1245,1307,2500,5000);
Insert into POPULATION values (163,'C','COOKE','MOUNTAIN SPRING WSC','TRINITY',2654,2848,2998,3146,5000,8000);
Insert into POPULATION values (164,'C','COOKE','MUENSTER','TRINITY',1550,1550,1600,1600,1650,1650);
Insert into POPULATION values (165,'C','COOKE','TWO WAY SUD','RED',100,108,113,119,124,128);
Insert into POPULATION values (166,'C','COOKE','VALLEY VIEW','TRINITY',820,880,926,972,1010,1043);
Insert into POPULATION values (167,'C','COOKE','WOODBINE WSC','RED',484,549,613,678,742,806);
Insert into POPULATION values (168,'C','COOKE','WOODBINE WSC','TRINITY',5647,6398,7150,7899,8648,9397);
Insert into POPULATION values (169,'C','DALLAS','ADDISON','TRINITY',14539,17431,20323,23215,26107,29000);
Insert into POPULATION values (170,'C','DALLAS','BALCH SPRINGS','TRINITY',26423,28980,31606,34456,37233,40018);
Insert into POPULATION values (171,'C','DALLAS','CARROLLTON','TRINITY',49822,49822,49822,49822,49822,49822);
Insert into POPULATION values (172,'C','DALLAS','CEDAR HILL','TRINITY',52495,64217,75906,87555,87555,87555);
Insert into POPULATION values (173,'C','DALLAS','COCKRELL HILL','TRINITY',4670,5122,5122,5122,7000,15000);
Insert into POPULATION values (174,'C','DALLAS','COMBINE','TRINITY',809,922,1038,1164,1287,1410);
Insert into POPULATION values (175,'C','DALLAS','COPPELL','TRINITY',40324,41817,41817,41817,41817,41817);
Insert into POPULATION values (176,'C','DALLAS','COUNTY-OTHER','TRINITY',5339,3000,2000,2000,2000,2000);
Insert into POPULATION values (177,'C','DALLAS','DALLAS','TRINITY',1141059,1242191,1420781,1591937,1722709,1785569);
Insert into POPULATION values (178,'C','DALLAS','DESOTO','TRINITY',54617,59903,65330,71222,76963,82718);
Insert into POPULATION values (179,'C','DALLAS','DUNCANVILLE','TRINITY',42927,47106,47106,47106,47106,47106);
Insert into POPULATION values (180,'C','DALLAS','EAST FORK SUD','TRINITY',1934,2646,3377,4170,4943,5718);
Insert into POPULATION values (181,'C','DALLAS','FARMERS BRANCH','TRINITY',30613,32509,34455,36567,38625,40689);
Insert into POPULATION values (182,'C','DALLAS','FERRIS','TRINITY',6,10,14,18,22,26);
Insert into POPULATION values (183,'C','DALLAS','GARLAND','TRINITY',234313,241346,243000,243000,243000,243000);
Insert into POPULATION values (184,'C','DALLAS','GLENN HEIGHTS','TRINITY',13825,18835,23978,29561,35002,46000);
Insert into POPULATION values (185,'C','DALLAS','GRAND PRAIRIE','TRINITY',166241,206822,231537,231537,231537,231537);
Insert into POPULATION values (186,'C','DALLAS','HIGHLAND PARK','TRINITY',9025,9313,9313,9313,9313,9313);
Insert into POPULATION values (187,'C','DALLAS','HUTCHINS','TRINITY',9903,13922,17941,21960,25979,30000);
Insert into POPULATION values (188,'C','DALLAS','IRVING','TRINITY',260752,284500,284500,284500,284500,284500);
Insert into POPULATION values (189,'C','DALLAS','LANCASTER','TRINITY',45184,58895,69717,77649,85582,93514);
Insert into POPULATION values (190,'C','DALLAS','LEWISVILLE','TRINITY',841,841,841,841,841,841);
Insert into POPULATION values (191,'C','DALLAS','MESQUITE','TRINITY',149861,164825,186120,202904,219260,235656);
Insert into POPULATION values (192,'C','DALLAS','OVILLA','TRINITY',476,613,754,907,1056,1829);
Insert into POPULATION values (193,'C','DALLAS','RICHARDSON','TRINITY',73478,76486,79526,82000,82000,82000);
Insert into POPULATION values (194,'C','DALLAS','ROCKETT SUD','TRINITY',1000,2000,3000,4000,5000,6000);
Insert into POPULATION values (195,'C','DALLAS','ROWLETT','TRINITY',56800,62300,62300,62300,62300,62300);
Insert into POPULATION values (196,'C','DALLAS','SACHSE','TRINITY',20600,20600,20600,20600,20600,20600);
Insert into POPULATION values (197,'C','DALLAS','SEAGOVILLE','TRINITY',18824,22836,26846,30855,34932,34919);
Insert into POPULATION values (198,'C','DALLAS','SUNNYVALE','TRINITY',7000,10000,13000,15000,18000,18000);
Insert into POPULATION values (199,'C','DALLAS','UNIVERSITY PARK','TRINITY',25688,25688,25688,25688,25688,25688);
Insert into POPULATION values (200,'C','DALLAS','WILMER','TRINITY',4203,4698,7500,14000,22000,40000);
Insert into POPULATION values (201,'C','DALLAS','WYLIE','TRINITY',2543,2613,2683,2753,2823,2960);
Insert into POPULATION values (202,'C','DENTON','ARGYLE','TRINITY',6000,9000,13000,13000,13000,13000);
Insert into POPULATION values (203,'C','DENTON','ARGYLE WSC','TRINITY',5040,5040,5040,5040,5040,5040);
Insert into POPULATION values (204,'C','DENTON','AUBREY','TRINITY',4726,6284,7349,8713,10459,12693);
Insert into POPULATION values (205,'C','DENTON','BARTONVILLE','TRINITY',4500,5000,5000,5000,5000,5000);
Insert into POPULATION values (206,'C','DENTON','BOLIVAR WSC','TRINITY',9480,11534,13988,16730,19940,23604);
Insert into POPULATION values (207,'C','DENTON','CARROLLTON','TRINITY',76937,79348,79348,79348,79348,79348);
Insert into POPULATION values (208,'C','DENTON','CELINA','TRINITY',680,4800,16020,37500,37500,37500);
Insert into POPULATION values (209,'C','DENTON','COPPELL','TRINITY',1136,1136,1136,1136,1136,1136);
Insert into POPULATION values (210,'C','DENTON','COPPER CANYON','TRINITY',1419,1523,1647,1785,1947,2131);
Insert into POPULATION values (211,'C','DENTON','CORINTH','TRINITY',24911,29499,29499,29499,29499,29499);
Insert into POPULATION values (212,'C','DENTON','COUNTY-OTHER','TRINITY',30207,33609,37232,53174,86087,160675);
Insert into POPULATION values (213,'C','DENTON','CROSS ROADS','TRINITY',2256,3096,3800,3800,3800,3800);
Insert into POPULATION values (214,'C','DENTON','DALLAS','TRINITY',29680,32203,36598,40789,43991,45531);
Insert into POPULATION values (215,'C','DENTON','DENTON','TRINITY',160145,211773,268780,341471,468168,570694);
Insert into POPULATION values (216,'C','DENTON','DENTON COUNTY FWSD #10','TRINITY',7884,16750,16750,16750,16750,16750);
Insert into POPULATION values (217,'C','DENTON','DENTON COUNTY FWSD #1A','TRINITY',14000,25021,30000,30000,30000,30000);
Insert into POPULATION values (218,'C','DENTON','DENTON COUNTY FWSD #7','TRINITY',13500,13500,13500,13500,13500,13500);
Insert into POPULATION values (219,'C','DENTON','DOUBLE OAK','TRINITY',3000,3000,3000,3000,3000,3000);
Insert into POPULATION values (220,'C','DENTON','FLOWER MOUND','TRINITY',75315,92730,92730,92730,92730,92730);
Insert into POPULATION values (221,'C','DENTON','FORT WORTH','TRINITY',36268,55784,80890,114032,146148,178264);
Insert into POPULATION values (222,'C','DENTON','FRISCO','TRINITY',68530,90265,112000,112000,112000,112000);
Insert into POPULATION values (223,'C','DENTON','HACKBERRY','TRINITY',1274,1645,2088,2583,3162,3823);
Insert into POPULATION values (224,'C','DENTON','HICKORY CREEK','TRINITY',4089,5110,6331,7941,7941,7941);
Insert into POPULATION values (225,'C','DENTON','HIGHLAND VILLAGE','TRINITY',17100,18000,18000,18000,18000,18000);
Insert into POPULATION values (226,'C','DENTON','JUSTIN','TRINITY',4650,8325,12000,12000,12000,12000);
Insert into POPULATION values (227,'C','DENTON','KRUGERVILLE','TRINITY',1986,2437,2889,3440,3440,3440);
Insert into POPULATION values (228,'C','DENTON','KRUM','TRINITY',5195,6453,7957,9637,11603,13848);
Insert into POPULATION values (229,'C','DENTON','LAKE DALLAS','TRINITY',7782,8603,9933,9933,9933,9933);
Insert into POPULATION values (230,'C','DENTON','LAKEWOOD VILLAGE','TRINITY',692,870,1082,1319,1597,1914);
Insert into POPULATION values (231,'C','DENTON','LEWISVILLE','TRINITY',106486,121083,138527,158016,176515,176515);
Insert into POPULATION values (232,'C','DENTON','LITTLE ELM','TRINITY',29860,33821,33821,33821,33821,33821);
Insert into POPULATION values (233,'C','DENTON','MOUNTAIN SPRING WSC','TRINITY',55,61,68,75,84,94);
Insert into POPULATION values (234,'C','DENTON','MUSTANG SUD','TRINITY',12500,23946,35392,46838,58284,69730);
Insert into POPULATION values (235,'C','DENTON','NORTHLAKE','TRINITY',4500,17000,31010,43005,55000,55000);
Insert into POPULATION values (236,'C','DENTON','OAK POINT','TRINITY',8305,12586,16868,21149,25430,25430);
Insert into POPULATION values (237,'C','DENTON','PALOMA CREEK','TRINITY',12348,16839,16839,16839,16839,16839);
Insert into POPULATION values (238,'C','DENTON','PILOT POINT','TRINITY',6500,8000,11000,15000,20000,27000);
Insert into POPULATION values (239,'C','DENTON','PLANO','TRINITY',7500,7800,8000,8000,8000,8000);
Insert into POPULATION values (240,'C','DENTON','PONDER','TRINITY',2035,2811,3738,4774,5987,7371);
Insert into POPULATION values (241,'C','DENTON','PROSPER','TRINITY',750,4794,12241,23092,33942,33942);
Insert into POPULATION values (242,'C','DENTON','PROVIDENCE VILLAGE WCID','TRINITY',7235,7235,7235,7235,7235,7235);
Insert into POPULATION values (243,'C','DENTON','ROANOKE','TRINITY',7975,9988,12000,12000,12000,12000);
Insert into POPULATION values (244,'C','DENTON','SANGER','TRINITY',8632,10713,13199,15977,19229,22941);
Insert into POPULATION values (245,'C','DENTON','SHADY SHORES','TRINITY',3441,3936,3936,3936,3936,3936);
Insert into POPULATION values (246,'C','DENTON','SOUTHLAKE','TRINITY',1018,1315,1669,2065,2528,3057);
Insert into POPULATION values (247,'C','DENTON','THE COLONY','TRINITY',51000,58000,62000,67600,67600,67600);
Insert into POPULATION values (248,'C','DENTON','TROPHY CLUB','TRINITY',13098,13098,13098,13098,13098,13098);
Insert into POPULATION values (249,'C','DENTON','WESTLAKE','TRINITY',25,33,43,54,67,82);
Insert into POPULATION values (250,'C','ELLIS','BARDWELL','TRINITY',831,1063,1333,1650,2024,4500);
Insert into POPULATION values (251,'C','ELLIS','BRANDON-IRENE WSC','TRINITY',80,103,129,160,196,238);
Insert into POPULATION values (252,'C','ELLIS','BUENA VISTA - BETHEL SUD','TRINITY',4500,5500,6500,8000,11500,15326);
Insert into POPULATION values (253,'C','ELLIS','CEDAR HILL','TRINITY',705,902,1132,1401,1401,1401);
Insert into POPULATION values (254,'C','ELLIS','COUNTY-OTHER','TRINITY',6100,6500,7177,27642,60016,105596);
Insert into POPULATION values (255,'C','ELLIS','ENNIS','TRINITY',22000,26000,30000,41059,66101,110000);
Insert into POPULATION values (256,'C','ELLIS','FERRIS','TRINITY',2940,3540,4160,4826,8000,15000);
Insert into POPULATION values (257,'C','ELLIS','FILES VALLEY WSC','TRINITY',775,991,1243,1538,1887,2291);
Insert into POPULATION values (258,'C','ELLIS','GARRETT','TRINITY',1032,1320,1656,2049,2514,6000);
Insert into POPULATION values (259,'C','ELLIS','GLENN HEIGHTS','TRINITY',3498,4473,5612,6945,8520,13000);
Insert into POPULATION values (260,'C','ELLIS','GRAND PRAIRIE','TRINITY',57,73,92,114,140,170);
Insert into POPULATION values (261,'C','ELLIS','ITALY','TRINITY',2386,3052,3828,4738,6000,8000);
Insert into POPULATION values (262,'C','ELLIS','JOHNSON COUNTY SUD','TRINITY',211,270,339,419,514,625);
Insert into POPULATION values (263,'C','ELLIS','MANSFIELD','TRINITY',116,138,173,241,299,369);
Insert into POPULATION values (264,'C','ELLIS','MAYPEARL','TRINITY',1128,1359,1500,1500,1500,1500);
Insert into POPULATION values (265,'C','ELLIS','MIDLOTHIAN','TRINITY',18025,23643,31011,37802,43871,48460);
Insert into POPULATION values (266,'C','ELLIS','MILFORD','TRINITY',775,835,905,987,1083,1195);
Insert into POPULATION values (267,'C','ELLIS','MOUNTAIN PEAK SUD','TRINITY',5321,6805,8536,10564,12959,15735);
Insert into POPULATION values (268,'C','ELLIS','OAK LEAF','TRINITY',1350,1500,1750,2500,3700,4500);
Insert into POPULATION values (269,'C','ELLIS','OVILLA','TRINITY',4049,5178,6495,8039,9861,18171);
Insert into POPULATION values (270,'C','ELLIS','PALMER','TRINITY',2562,3276,4109,5086,6500,12000);
Insert into POPULATION values (271,'C','ELLIS','PECAN HILL','TRINITY',801,1025,1286,1592,2000,3000);
Insert into POPULATION values (272,'C','ELLIS','RED OAK','TRINITY',12369,14000,19000,26000,32000,50000);
Insert into POPULATION values (273,'C','ELLIS','RICE WSC','TRINITY',7038,9000,11289,13972,17140,20811);
Insert into POPULATION values (274,'C','ELLIS','ROCKETT SUD','TRINITY',32882,42048,52743,65279,85000,105000);
Insert into POPULATION values (275,'C','ELLIS','SARDIS-LONE ELM WSC','TRINITY',14500,18000,22000,24000,25340,25340);
Insert into POPULATION values (276,'C','ELLIS','VENUS','TRINITY',83,106,133,165,202,246);
Insert into POPULATION values (277,'C','ELLIS','WAXAHACHIE','TRINITY',37700,43300,52800,64400,78500,95500);
Insert into POPULATION values (278,'C','FANNIN','BONHAM','RED',12603,16000,22000,30000,37000,45000);
Insert into POPULATION values (279,'C','FANNIN','COUNTY-OTHER','RED',9866,9624,10093,13842,29823,47557);
Insert into POPULATION values (280,'C','FANNIN','COUNTY-OTHER','SULPHUR',954,1015,1901,3573,7007,11414);
Insert into POPULATION values (281,'C','FANNIN','COUNTY-OTHER','TRINITY',2348,2529,1174,835,3170,6029);
Insert into POPULATION values (282,'C','FANNIN','ECTOR','RED',773,850,909,962,1044,1133);
Insert into POPULATION values (283,'C','FANNIN','HICKORY CREEK SUD','SULPHUR',275,302,323,342,371,402);
Insert into POPULATION values (284,'C','FANNIN','HICKORY CREEK SUD','TRINITY',15,17,18,19,21,23);
Insert into POPULATION values (285,'C','FANNIN','HONEY GROVE','RED',376,398,398,398,398,398);
Insert into POPULATION values (286,'C','FANNIN','HONEY GROVE','SULPHUR',1324,1402,1402,1402,1402,1402);
Insert into POPULATION values (287,'C','FANNIN','LADONIA','SULPHUR',1600,2000,2200,2500,3000,3000);
Insert into POPULATION values (288,'C','FANNIN','LEONARD','RED',18,19,21,22,24,26);
Insert into POPULATION values (289,'C','FANNIN','LEONARD','SULPHUR',42,46,49,52,57,62);
Insert into POPULATION values (290,'C','FANNIN','LEONARD','TRINITY',2153,2369,2532,2683,2910,3157);
Insert into POPULATION values (291,'C','FANNIN','NORTH HUNT SUD','SULPHUR',525,577,617,653,709,769);
Insert into POPULATION values (292,'C','FANNIN','SAVOY','RED',924,1016,1086,1151,1249,1355);
Insert into POPULATION values (293,'C','FANNIN','SOUTHWEST FANNIN COUNTY SUD','RED',3656,4020,4298,4552,5449,6439);
Insert into POPULATION values (294,'C','FANNIN','SOUTHWEST FANNIN COUNTY SUD','TRINITY',180,198,212,224,269,318);
Insert into POPULATION values (295,'C','FANNIN','TRENTON','RED',1,2,7,12,16,20);
Insert into POPULATION values (296,'C','FANNIN','TRENTON','TRINITY',705,998,3493,5988,7984,9980);
Insert into POPULATION values (297,'C','FANNIN','WHITEWRIGHT','RED',8,9,10,11,12,13);
Insert into POPULATION values (298,'C','FREESTONE','COUNTY-OTHER','BRAZOS',1371,1348,852,1428,2815,6623);
Insert into POPULATION values (299,'C','FREESTONE','COUNTY-OTHER','TRINITY',10348,10371,10867,13628,22185,43377);
Insert into POPULATION values (300,'C','FREESTONE','FAIRFIELD','TRINITY',3232,3486,3662,7000,8000,10000);
Insert into POPULATION values (301,'C','FREESTONE','FLO COMMUNITY WSC','TRINITY',521,562,590,611,627,638);
Insert into POPULATION values (302,'C','FREESTONE','OAKWOOD','TRINITY',40,43,45,47,48,49);
Insert into POPULATION values (303,'C','FREESTONE','TEAGUE','BRAZOS',1856,1980,2772,3490,4208,4950);
Insert into POPULATION values (304,'C','FREESTONE','TEAGUE','TRINITY',1894,2020,2828,3560,4292,5050);
Insert into POPULATION values (305,'C','FREESTONE','WORTHAM','TRINITY',1175,1267,1331,1378,2300,2600);
Insert into POPULATION values (306,'C','GRAYSON','BELLS','RED',1648,1943,2234,2568,6000,8000);
Insert into POPULATION values (307,'C','GRAYSON','COLLINSVILLE','TRINITY',2117,2685,3246,3889,5000,6500);
Insert into POPULATION values (308,'C','GRAYSON','COUNTY-OTHER','RED',20620,20601,20582,20387,29097,49118);
Insert into POPULATION values (309,'C','GRAYSON','COUNTY-OTHER',PK     ! t6Z¦z  „   [Content_Types].xml ¢(                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  ¬TÍN1¾›ø›^[ğ`Œaá€zTğj;°İ¶éoïlAbB\¶Ù¶óıLg¦?\7®XAB|%zeWàu0ÖÏ+ñ1}í<ŠIy£\ğP‰ noúÓM,8Úc%j¢ø$%ê…eˆàùdR£ˆÓ\F¥jò¾Û}:xOj1Ä ÿ3µtT¼¬y{«äÓzQŒ¶÷ZªJ¨ÕŠX¨\yó‡¤f3«Á½lºÄ˜@¬¨qeL–ÓˆØ
y3ÃóHw®JÌÂ°¶ïØú?íÉÿ®vqïüÉ(Æ*Ñ›jØ»\;ùÒâ3„EyäÜÔä•²şG÷ş|e^zWÒúËÀ't×Èü½\B†9Aˆ´q€×N{=Å\«fB\½ó«ø}B‡VNj.‘+'a{ŒŸ[zœBD	ÎğÓ¢mt'2$²°oÒCÅ¾gä‘s±chgšs€[æ:ø  ÿÿ PK     ! µU0#ô   L   _rels/.rels ¢(                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  ¬’MOÃ0†ïHü‡È÷ÕİBKwAH»!T~€IÜµ£$İ¿'TƒG½~üÊÛİ<êÈ!öâ4¬‹;#¶w­†—úqu*&r–Fq¬áÄvÕõÕö™GJy(v½*«¸¨¡KÉß#FÓñD±Ï.W	¥†=™ZÆMYŞbø®ÕBSí­†°·7 ê“Ï›×–¦é?ˆ9LìÒ™ÈsbgÙ®|Èl!õùUSh9i°br:"y_dlÀóD›¿ı|-NœÈR"4ø2ÏGÇ% õZ´4ñËyÄ7	Ã«ÈğÉ‚‹¨Ş  ÿÿ PK     ! ’”ì  ?   xl/_rels/workbook.xml.rels ¢(                                                                                                                                                                                                                                                                  ¬’ËjÄ0E÷…şƒÑ¾q2}P†qfÑR˜m›~€p”8Lb[}äïkR:ÉÀn²1HÂ÷‰»Ûw­ø$gdI
‚¬veckïÅËÍ#ˆÀhKl%Øç×W»Wj‘ã§`š>ˆ¨bƒÃÜo¥ÚP‡!q=Ù8©œïcékÙ£>bMr“¦ÒÏ5 ?Ó‡R?”· Š¡Îÿk»ªj4=;ıÑ‘å2ğĞÆD¾&Vğ['‘äeûÍšöÏB“ûXÊñÍ–²5¾œ?CÄÇ©ä8Y„¹_Fc«Ÿ6v‚9µ–.r·j(z*ßØÇÌÏ³1oÿÁÈ³Øç?   ÿÿ PK     ! YÛA  —     xl/workbook.xml¬Tßo›0~Ÿ´ÿÁò;åG¡IQ jªVêº(¡íK_c‚c3Û,‰¦ıï; lİúÒi{álßñùîûî<»8Ô}eÚp%ìŸx1IUÁå6Áùµ3ÅÈX""”d	>2ƒ/Òf{¥w¥v ¤Ipem»®¡«‰9Q“à)•®‰…­Şº¦ÑŒ¦bÌÖÂ<ïÌ­	—x@ˆõ{0TYrÊŠ¶5“v ÑLé›Š7fD«é{àj¢wmãPU7 ±á‚ÛcŠQMãÛ­Tšl”}ğ£–o kNµ2ª´' åI¾©×÷\ßJNg%ìq ‘¦¹'uw‹ÀHc³‚[V$ø¶jÏ~;ĞmsÕr^?»éO)–¬$­°9ˆ0ÂC`tA	E]
Ë´$–Í•´ÀáûÿÊW=¯¨ƒVìKË5ƒ¦èhKgğ%4&³$¶B­	¾Ÿ×ùÃ"»ÏÑüó§å]–gÏó›Ëe­¡ßúùéä­¢A;¡]ı.0$9¬ÿ$#u-ıÈÙŞü¢µÛ¢Ã—…Ú'äøj½ïŸxa«^xşáì†ñme<™DQ÷+è~àŠŞ"Ù‹¿îÃ‡iëìm§/F:æ°Ğ·…ß#Œ¿Q"(ˆİ™>0
"¿`{gl:<óóCïrâ‡—FN8=œix8ópdÑ$[dWÑ÷ÿÛÚ w<¾]–Ñ6×„îàMY±òŠhõ¡ È„³vÇ¿Ò   ÿÿ PK     ! Q²—S;  ·     xl/sharedStrings.xmlt’[Oƒ0†ïMüMïGc€¡Æ©ÂÁ]’†ÕAíäëÌöï­îÆ@½ìóöíÓ/­»8öúâ´RxxnÙqQËM+¶.‹§Ù=F ˜Ø°N
îá¼ğ//\ …tW€‡¥ö„@İğ%÷\èäC=Sz9l	ìÎ6Ğp®ú8¶}KzÖ
ŒjyÊÃ7Úríç‡gà8Øw¡õ]å¯×ÁÌ¶ç.Q¾K~Ğ‡ŠyRŒƒßıó»1~±ĞŠ+İØÆQüÎœ©!²Ğ«h·2œ‰a¥lh a©q55dÊ«w=3NqíL¦N“jO×0.Wã<x£y•ÑÔtGı2c¼Œß“eHÚ°Ì‹*M…Ê$“‚æÿœ>ái™…ÏAN£*É"šıÉ‰şxş7   ÿÿ PK     ! ;m2KÁ   B  #   xl/worksheets/_rels/sheet1.xml.rels„ÁŠÂ0E÷şCx{“Ö…CS7"¸UçbúÚÛ—÷ı{³eÀååpÏå6›û<©f‘,Ôº…äch°ğ{Ú-¿A±8êÜ	-<aÓ.¾šNNJ‰ÇX±…Q$ıÃ~ÄÙ±	©>æÙI‰y0Éù‹Ğ¬ªjmò_´/Nµï,ä}Wƒ:=RYşì}<n£¿ÎHòÏ„I9`>¢H9ÈEíò€bAëwök}¦mÌËóö	  ÿÿ PK     ! ‹‚nX“       xl/theme/theme1.xmlìYÏ‹7¾ú?swükfl/ñ{lgÛì&!ë¤ä¨µe²š‘É»1!P’c¡Pš–^
½õPÚè%ık¶MiSÈ¿Ğ'ÍØ#­ånšn -YÃ2£ùôôé½7ß“4/İ©s„SNXÒv«*®ƒ““dÚvo¥¦ëp’1¢,Ámw¹{iûı÷.¢-á;Ğ?á[¨íFBÌ¶Êe>‚fÄ/°NàÙ„¥1p›NËãƒİ˜–k•JPI\'A1˜½6™v†Ò¤»½4Ş§p›.F4İ—¦±ÑCaÇ‡U‰àÒÔ9B´íÂ8cv<Äw…ëPÄ<h»õç–·/–ÑVŞ‰Š}µ~õ—÷Ë;ŒkjÌtz°Ôó|/è¬ì+ ë¸~£ôƒ•=@£Ì4ã¢Ûô»­nÏÏ±(»´Øî5zõª×ì××8w|ù3ğ
”Ù÷ÖğƒA^4ğ
”á}‹OµĞ3ğ
”áƒ5|£Òéy¯@%Éáºâõp9ÛdÂèŞò½A£–/P«ì’CLX"6åZŒî°t  	¤HÄ‹ dqˆ(9H‰³K¦$Ş%ŒCs¥VTêğ_ş<u¥<‚¶0ÒzK^À„¯5I>¥d&Úî‡`ÕÕ /Ÿ}ÿòÙçå³Ç'<øéäáÃ“?f¶Œ;(™ê_|ûÙŸ_ìüñä›¾°ã¹ÿõ‡O~ùùs;&[xáù—{úøùWŸşşİ#¼“¢>$1æÎU|ìÜ`1ÌMyÁdÒÖc!bô@Ø¶˜î‹È ^] jÃu±é¼[)Œxy~Çàº¥sA,#_‰b¸Çí²Ôê€+r,ÍÃÃy2µÎuÜ„lc‡(1BÛŸÏ@Y‰ÍdaƒæuŠ¦8ÁÂ‘ÏØ!Æ–Ùİ&Äğë¥Œ³‰pn§‹ˆÕ%Cr`$RÑi‡Ä—… „ÚğÍŞ-§Ë¨mÖ=|d"á…@ÔB~ˆ©áÆËh.Pl39D1Õ¾‹Dd#¹¿HG:®ÏDzŠ)súcÌ¹­Ïµæ«ı
ˆ‹=ì{t›ÈTC›Í]Ä˜ì±Ã0BñÌÊ™$‘ı€BŠ"ç:6ø3ßyq@ÉÆpß"Ø÷ÙBptU§T$ˆ|2O-±¼Œ™ù>.èa¥2 û†šÇ$9SÚO‰ºÿNÔ³ªtZÔ;)±¾Z;§¤|î?(à=4O®cxgÖØ;ı~§ßîÿ^¿7½Ëç¯Ú…Pƒ†«uµv7.İ'„Ò}± x—«Õ;‡ò4@£ÚV¨½åj+7‹à2ß(¸iŠT'eâ#"¢ıÍ`‰_UÑ)ÏMO¹3cVşªYm‰ñ)Ûjÿ0÷Ø8Û±V«rwš‰G¢h¯ø«vØmˆ4Š]ØÊ¼Ú×NÕnyI@öı'$´ÁLu‰Æ²¢ğw$ÔÌÎ…EËÂ¢)Í/CµŒâÊ@mX?9°êj»¾—À¦
Q<–qÊ–Ñ•Á9×Hor&Õ3 Ë("İ’\7NOÎ.KµWˆ´ABK7“„–†ã<;õ£“óŒu«©AOºbù64Í7k)"§´&ºRĞÄ9n»Aİ‡Ó±šµİ	ìüá2Aîp¹îEt
Çg#‘f/üë(Ë,å¢‡x”9\‰N¦18u(‰Û®œş*h¢4Dq«Ö@ŞZr-•·İ2LğHèa×Z¤§³[PøL+¬OU÷×ËláŞÆÇÎ§7¤˜ß¨J	‡ jæÍ1Í•ùwª0å²«)ªÊÚE(¯(º˜gp%¢+:ênåí.Ÿ38tİ…SY`ÿuÕ=»TKÏi¢YÔLCUdÕ´‹é›+ò«¢ˆ¬2éVÛ^h]k©u¨Ö*qFÕ}…‚ Q+3¨IÆë2,5;o5©ã‚@óD°Áo«aõÄëV~èw:keX®+Uâ«Oú×	vpÄ£çÀs*¸
%|{H,ú²“äL6à¹+ò5"\9ó”´İ{¿ã…5?,Uš~¿äÕ½J©éwê¥ï×«}¿Zéuk÷¡°ˆ(®úÙg—œGÑEşñEµ¯}€‰—GnF,.3õ¥¬ˆ«0ÕÚæ0Ñ¹Ô­z«”ZõÎ äõºÍR+º¥^6zƒ^è7[ƒû®s¤À^§zA¿Y
ªaXò‚Š¤ßl•^­ÖñfßëÜÏ—10óL>r_€{¯í¿   ÿÿ PK     ! uı»  v     xl/styles.xmlÌXÛnÛ8}/°ÿ ğ]Ñ%–k’Š8€m±@²À¾Ò%áE è¬İ¢ÿ¾C]lÅq5uÜúE¼Îœ93~Øpf=UQ)"ä]¸È""•E„ş¹Kì	²*E†™$B[R¡ñ_ïÂJo¹]¢-!ª­´.gS¥+Âqu!K"`&—Šc]U8U©Î*³‰3Çwİ±Ã1¨‘0ãé!«ûui§’—XÓ%eTokYÈâéìc!¤ÂKP7Ş§ìºóD<§©’•ÌõˆsdÓ”<E9u¦HŠÃ\
]Y©\¡Km4Ìî…üO$f
lWÅaõÕzÀF|äÄa*™T–f ˜gFæ¤Yq¥(ff(Çœ²m3XïrŒÂFm.aÅÉ…VZÑ{rZÉ5ê
`SÆvl10‡à5M”H cµí»m	´0CƒÓ¬{au¡ğÖóƒá*ÉhfP×µ3T±ŒPRÿ\×ˆY¶TddC²Gµôà¡à~ ËuçnğÓºj>€Ï¥TÔ.ş|°¥ŠCFr(Z¬ÌWËÒØ#µ†¨ÃŒâB
Ì·İşN8àp–#¤Wp»X=dÁ¨h5Z_c©¡Z;ÄƒÖ7Æ·­5(K	c·Æ¸óoæˆnrK¬yÂõGp3¤<sÎº&ÄeÛl8j:†»¾´Fv_ìûWÉµ6ùNÁÏ¢ò µ»-\–l;¯#Ä$˜¦Åh!81ÙÊX»®µ’Š~›M‚Ja¨:Ò7ù5^ğ27OP|Yó%QI÷÷XN­ç6€`²Å·d²ô	é99>²ú‘s€Â™Ô{Ç‚9æÜNÇ¿…<¨5ö!õ‡÷<¦ãIà|äÁ!yRÂìÇá`„? òœ¸\‘Ï\Fpw>ºÚŞäV9T2èVëûó×@¼†7Ğø¸&xé6î
(ezõÒ£jiW÷XæÑ¡/æjg=EË5ešŠ#•ÈÌ6ûÚ«®}µyÕUÙN ÎH×Lßí&#´o&]s81íª¿éƒÔµˆíÛŸLùëM)C6úSõ*|­µ¢úv3?]Ü$¾=qç{tI{Ìv0º/ÉÔõİëï½×â/¼ë7-Ä¼7šU^”ª5¶»‹P¯ÓÀ¯1€İÇ>õÇîUà¹vrézöhŒ'öd|ØIàù‹ñh~$A{ğ:ìëx^ó 7àƒ™¦œ0*:_uê‚“ ûŒNç	gÿ‡Aü?   ÿÿ PK     ! ]ïÈXé       xl/worksheets/sheet1.xmlœX[“ªF~OUşÅkêˆxEkõÔAå!©T6—gÇ•:â˜½å×§çÊØw_¦?¾éù¦éiûîë[uğ^Hİ”ô¸ğÃ^ß÷È± Ûòø´ğÿú3ıù^Ãòã6?Ğ#Yøï¤ñ¿.şéî•Öß›=!Ì†c³ğ÷ŒæAĞ{RåMÈ,;ZW9ƒÇú)hN5É·â¥êúıIPååÑ—óúºÛ•Ihñ\‘#“$59äüoöå©ÑlUq]•×ßŸO_
Z€â±<”ì]ú^UÌ³§#­óÇ¬û-å…æôUYÔ´¡;Öº@:z¹æY0€iy·-a\v¯&»…ÿm0ÏÂÈ–wB ¿KòÚX÷ËÈŒlaŸ|ï?J«‡"ç¾MaÓÌão\ğƒä{ôHéwN–Ák}˜¶$|Ú¼`åY‘ W0µ×ü+<á÷àF`ü°ïµO©Ø×ßkoKvùóıA_7¤|Ú3pn:q¹æÛ÷„4ìLİpÒ‚€~½ªäñ2çoâúZnÙîÂ^ØŸ§ÀñH––œĞ÷Šç†Ñê…QL’c 8àª8f½ñx4‰>À1Tp5Q4™†!)¸¶‹HŠ+şOÔkpı´SÅWÍtW&…İÂÃõó)¸¶O§Óáè†ıd(ˆ Kr–/ïjúêA€}lN9Ï(á˜eDõøfº‚j!]ğ×¾Á{+<¿,ı»àÂ¶PÆ”“.|Ø^	'çµ2=‡lè’9 3	`‰fàÌ§ÖÉß»¾”ØAKY9 h)‰Ò.EhJH(4‘ækm´4#A%d ŞúÃ©©)x:²µƒOÌÖÎ™mt\p,Ï!<.°±2Ú±"'W
3ìò21$<ÁñXLí9q,®µÑ
W$‹D´² 2i‡/ÂDóĞc ¹Y'Õ:aŸce<ûÆÎ^)H+ò:1F&{Ê!ml‰‰èi·ejãë,œ WŞ,Çj™°Ï±2Ú2!§W
ÒM†ÃÈdO9Â2ic+Jl‰˜ŠC“Gg&l]Úìp¦'7ëÂ±Zìd¬Œ¶.ÈË•èe'#©áeÌËrŒ•0ÖV
”Ò6
"“Áp2 /2GGúæõ’uL]MA«µÁnÇÊhkƒÜ^)ˆŒ‡Û‰á01#G"•õ°TÚj¥füqIÈvËM8ı…§Î+‡f—d’Ái~³d’LÔÆjdlFVjdbFsÉ!”ÈŸ:mÅ‹çè!Ë=d¹r‰JÕĞY‚N¼µ3@ÇƒÓ âÊ\˜‘û¡¾¾y_8¸-³÷÷‚jádØ¡L'ÂEhUkcîNø
2Õ'qŒ”~¶Ì/¢úÉ»0h¹+mbâÂ´›(6ú^a¤äh’TµäˆmÌİ¥ˆ‚É’ËŠÎ”#!ªx¯¦LÖ9ó"Xbm¾vÒjŒ9jq¸$.–‹–5¨Ô	˜*­/Ú›µ1·Ú ÈFAŒ¾´…™ƒ£İ‚ó÷‘ª2k{&EZX¬Í×
>1úâØH\,h¦{…‘ú"uReÔú¢Ø[swñ£ F_|üfjˆ÷5nÏ“vmEha±à‚ğ¶õE˜•Æ}ql$.¤Ñ½ÂH}‘1UF­/şKlÌİ•‚´ú¢Udò üH.Àm~@‹µùZÅ©1F_‰‹ı‘¾W©/0UF­/zwmÌWê0…işì éØ®çáû¿€í‚zaç‡y:Jz\¶jL+0
ÄÅÒå¼]pÿĞy»â"¤{,šèëÃ­ÙPûù!åö^vQeƒë”?‘_óú©<6ŞìDWd¬eÛ´ßƒ{FO¼W*Z—”AËS?í¡sNàÏ[¿çÑR¦ âç¼„=Ÿ<Z—ĞmÍğ…¢5«ó’ù¼¿ÏJè'§rág|Îy	ıà:Û†¢ÕkšùËÿ  ÿÿ PK     ! )õezS     docProps/core.xml ¢(                                                                                                                                                                                                                                                                  „’QKÃ0…ßÿCÉ{›¦ÅMCÛ“=96Q|ÉİVl’’dvû÷¦íV+}Lî¹_Î9$›d|‚±¥V9"QŒP\‹Rmsô²^„·(°)Á*­ GG°hV\_e¼¦\x6ºãJ°')Ky£s5ÅØòHf#¯P~¸ÑF2çf‹kÆ?ØpÇ,Á1ÁÃ-0¬":!õŞT@pHPÎbü­u`¤ıu¡›Œ”²tÇÚg:Ù³ï‡ƒú`ËAØ4MÔ¤ïŸà·åãª‹–ªíŠ*2Á)7Àœ6Å\+»¯œ¯4Xéjï|Õ6z—á‘¨-´bÖ-}÷›Äıñ½K­¯‹×?
"ğ†iï<yMçë*’˜LÂ8	Éİ:Nh<¥$}o­üØoôòdè_â4$7ë˜Ğ$¥)Ï€"ÃŸ¦ø  ÿÿ PK     ! PÚ•   ©      xl/calcChain.xml<A
1ï‚sw³z‘${Äè†ì¸	$“%Do¼xihªÚLïœÔ‹ªÄÂöÃŠØ—9òbáq¿îN ¤!Ï˜
“…	Ln»1“¿Œ¬:ÅBhm=k->PFÊJÜ—g©[¯uÑ²VÂYQËIÆñ¨s€3^U·®Šı¨ôKíŒşKÜ  ÿÿ PK     ! Uğ­  ä  '   xl/printerSettings/printerSettings1.binìYÍn1ü —äôDoHHH)U[zLÒDMºùÑş”qq+±º±W^/JzâxÎ}œy‰2ö&”‘’ƒ½Z[ã™õ|óÅcËq|(ãóö 
GX×PÚ‡C8€»”L>wÿz7ïsÈÀ—‡¢0Ä¶ılÛÀÔPPøPwõv£Ì\­Û,¾…EÇÊg=·yş¹¼‡+C<1ré™~ ô›–~Ö¹·lº+7W\ï”àíYÆµü7SÍÛjy\üğñ‘é¼Â’¥X[ÿ&äõkGÜ(û;÷1!¼¶ßÒ KpšÕ™7…	Ì¼KØ…>æø1fø.x&Ö1J=”÷ñ›Q]Qp¨RTÙ¥#&8@›ñg*§—çŒÏBpi,ÂDiõa¹<ŒØÁñ´jNK\Ôù˜ğm0N|c¨~z’qÕäÕ×Ğm4 Íj"Ò#ïĞWj€ \¡ˆ¢{¯ÊÆ-BÁ—	MñHÈø*5?¨8^óMİt÷DŒˆëœ\„th¾ÔÁ¤½¸®}jRDm"/ã†Nõ$)G·Ê	“t`brÙh¬ªB)1ÑXO’(¤S/‰"!^W˜_w!U@Gpª£7®¤P8ŠqÑäQ¢¼P(xÄ´!äÄ—dæk ĞM*«Œ§ÔPé!ñ::OôæˆÁ´ª5V{›<V$»‘Fï°XÍ‘!¹ÿY®w ÎÚ}ç'cW»,ns\Û®pá† ¿7e›"6E¶€­Ï»—Ü:KôùÆËÀO˜C£İdìÌ°X,–Ë€eÀ2`°X,f À{Š·oGtËà
Û”­8Ä¥wEó&Ö¿lu÷Bgx2Èít>gş…ˆ¥«Ü¼¾æ];™zÀ¯   ÿÿ PK     ! Òãg|•      docProps/app.xml ¢(                                                                                                                                                                                                                                                                  œ’AoÛ0…ïöİ9İ:¬bH7äĞb’vgN¦c!²dˆ¬›ì×O¶‘ÔÙvÚä{xúDIİ—uÉ_ˆÅ<zJë÷…xÚ}›}1ø\ğXˆ’¸Óïß©M-F¶HYŠğTˆš¹]JI¦ÆhdŸ”*Ä8µq/CUYƒ÷Á¼4èYŞäù'‰GF_b9k/bL\vü¿¡e0==ïNmÖêKÛ:k€Ó-õ£51P¨8ûz4è”œŠ*ÑmÑ¼DË'+9mÕÖ€ÃU
Ö8B%ßjĞ/m6’V/;4bFöWZÛÈ~aSˆ¢Ï	«·ÍP»–8ê!¨FdR2ÆáPN½ÓÚ~Ô‹ÁŠkc0‚$áqgÙ!}¯6ùÄ‹)ñÀ0ò8Ûo<sÊ7\9ôGö*4-ø“^ã«CæÙÌb©äYPÖè©İ…{`<o÷z¨¶5D,Óƒ\¶¨uZlt}Èª¿Çòìù[èÿÂóøáõâvÈÓ3OfJ¾}mı  ÿÿ PK-      ! t6Z¦z  „                   [Content_Types].xmlPK-      ! µU0#ô   L               ³  _rels/.relsPK-      ! ’”ì  ?               Ø  xl/_rels/workbook.xml.relsPK-      ! YÛA  —               	  xl/workbook.xmlPK-      ! Q²—S;  ·               Š  xl/sharedStrings.xmlPK-      ! ;m2KÁ   B  #             ÷  xl/worksheets/_rels/sheet1.xml.relsPK-      ! ‹‚nX“                 ù  xl/theme/theme1.xmlPK-      ! uı»  v               ½  xl/styles.xmlPK-      ! ]ïÈXé                 £  xl/worksheets/sheet1.xmlPK-      ! )õezS                 Â  docProps/core.xmlPK-      ! PÚ•   ©                L!  xl/calcChain.xmlPK-      ! Uğ­  ä  '             "  xl/printerSettings/printerSettings1.binPK-      ! Òãg|•                  %  docProps/app.xmlPK      d  Ì'                                                                                                                                                                                              RINITY',77,103,132,162,195,230);
Insert into POPULATION values (418,'C','ROCKWALL','EAST FORK SUD','TRINITY',461,645,854,1066,1303,1554);
Insert into POPULATION values (419,'C','ROCKWALL','FATE','SABINE',5252,6661,8264,8885,9695,14895);
Insert into POPULATION values (420,'C','ROCKWALL','FATE','TRINITY',4573,7422,10660,14936,19595,30105);
Insert into POPULATION values (421,'C','ROCKWALL','FORNEY LAKE WSC','TRINITY',478,601,741,883,1041,1209);
Insert into POPULATION values (422,'C','ROCKWALL','GARLAND','TRINITY',3,4,4,5,6,7);
Insert into POPULATION values (423,'C','ROCKWALL','HEATH','TRINITY',12107,24300,24300,24300,24300,24300);
Insert into POPULATION values (424,'C','ROCKWALL','HIGH POINT WSC','TRINITY',328,413,509,607,716,831);
Insert into POPULATION values (425,'C','ROCKWALL','LAVON SUD','SABINE',1040,1560,2080,3120,4160,5200);
Insert into POPULATION values (426,'C','ROCKWALL','LAVON SUD','TRINITY',960,1440,1920,2880,3840,4800);
Insert into POPULATION values (427,'C','ROCKWALL','MCLENDON-CHISHOLM','TRINITY',1739,2188,2698,3215,3792,4403);
Insert into POPULATION values (428,'C','ROCKWALL','MOUNT ZION WSC','TRINITY',1985,2497,3080,3669,4327,5025);
Insert into POPULATION values (429,'C','ROCKWALL','ROCKWALL','TRINITY',47474,59732,73669,87768,103514,120202);
Insert into POPULATION values (430,'C','ROCKWALL','ROWLETT','TRINITY',7700,7700,7700,7700,7700,7700);
Insert into POPULATION values (431,'C','ROCKWALL','ROYSE CITY','SABINE',8861,9500,11000,25000,42000,49094);
Insert into POPULATION values (432,'C','ROCKWALL','WYLIE','TRINITY',3815,3919,4023,4127,4231,4441);
Insert into POPULATION values (433,'C','TARRANT','ARLINGTON','TRINITY',387725,412746,421748,426308,428127,428403);
Insert into POPULATION values (434,'C','TARRANT','AZLE','TRINITY',9486,10283,11094,11918,14400,18472);
Insert into POPULATION values (435,'C','TARRANT','BEDFORD','TRINITY',48100,51983,55866,59750,59750,59750);
Insert into POPULATION values (436,'C','TARRANT','BENBROOK','TRINITY',22500,25000,27500,32833,48095,48095);
Insert into POPULATION values (437,'C','TARRANT','BETHESDA WSC','TRINITY',9073,10201,11316,12401,13488,14552);
Insert into POPULATION values (438,'C','TARRANT','BLUE MOUND','TRINITY',2398,2403,2408,2413,2418,2422);
Insert into POPULATION values (439,'C','TARRANT','BURLESON','TRINITY',8634,9000,10000,14000,17000,19000);
Insert into POPULATION values (440,'C','TARRANT','COLLEYVILLE','TRINITY',24000,25500,27000,28000,28000,28000);
Insert into POPULATION values (441,'C','TARRANT','COMMUNITY WSC','TRINITY',3498,3933,4363,4781,5200,5610);
Insert into POPULATION values (442,'C','TARRANT','COUNTY-OTHER','TRINITY',36012,36012,36012,60000,80000,110000);
Insert into POPULATION values (443,'C','TARRANT','CROWLEY','TRINITY',16301,19046,22751,27354,35000,40000);
Insert into POPULATION values (444,'C','TARRANT','DALWORTHINGTON GARDENS','TRINITY',2307,2359,2410,2460,2510,2559);
Insert into POPULATION values (445,'C','TARRANT','EDGECLIFF VILLAGE','TRINITY',2924,2924,2924,2924,2924,2924);
Insert into POPULATION values (446,'C','TARRANT','EULESS','TRINITY',54214,57150,57150,57150,57150,57150);
Insert into POPULATION values (447,'C','TARRANT','EVERMAN','TRINITY',6286,6477,6600,6600,6600,6600);
Insert into POPULATION values (448,'C','TARRANT','FLOWER MOUND','TRINITY',240,270,270,270,270,270);
Insert into POPULATION values (449,'C','TARRANT','FOREST HILL','TRINITY',13000,13788,15000,18000,23000,30000);
Insert into POPULATION values (450,'C','TARRANT','FORT WORTH','TRINITY',842750,1034608,1273035,1385808,1482797,1580787);
Insert into POPULATION values (451,'C','TARRANT','GRAND PRAIRIE','TRINITY',51864,51864,51864,51864,51864,51864);
Insert into POPULATION values (452,'C','TARRANT','GRAPEVINE','TRINITY',52414,58930,60000,60000,60000,60000);
Insert into POPULATION values (453,'C','TARRANT','HALTOM CITY','TRINITY',44000,45000,47000,51000,55000,60000);
Insert into POPULATION values (454,'C','TARRANT','HASLET','TRINITY',1630,2000,2303,5000,7000,8000);
Insert into POPULATION values (455,'C','TARRANT','HURST','TRINITY',40000,41000,41000,41000,41000,41000);
Insert into POPULATION values (456,'C','TARRANT','JOHNSON COUNTY SUD','TRINITY',2082,2341,2597,2846,3095,3339);
Insert into POPULATION values (457,'C','TARRANT','KELLER','TRINITY',47663,51310,51310,51310,51310,51310);
Insert into POPULATION values (458,'C','TARRANT','KENNEDALE','TRINITY',8000,9200,10824,11303,11626,11626);
Insert into POPULATION values (459,'C','TARRANT','LAKE WORTH','TRINITY',5186,5831,6468,7500,8800,12000);
Insert into POPULATION values (460,'C','TARRANT','LAKESIDE','TRINITY',1350,1400,1450,1500,1500,1500);
Insert into POPULATION values (461,'C','TARRANT','MANSFIELD','TRINITY',69254,81090,97865,129090,149065,170503);
Insert into POPULATION values (462,'C','TARRANT','NORTH RICHLAND HILLS','TRINITY',71655,77000,77000,77000,77000,77000);
Insert into POPULATION values (463,'C','TARRANT','PANTEGO','TRINITY',2400,2400,2400,2400,2400,2400);
Insert into POPULATION values (464,'C','TARRANT','PELICAN BAY','TRINITY',1575,1605,1635,1664,1693,1721);
Insert into POPULATION values (465,'C','TARRANT','RENO','TRINITY',15,22,29,36,43,49);
Insert into POPULATION values (466,'C','TARRANT','RICHLAND HILLS','TRINITY',8401,9001,9601,10850,12000,13500);
Insert into POPULATION values (467,'C','TARRANT','RIVER OAKS','TRINITY',7500,7500,7500,7500,7500,7500);
Insert into POPULATION values (468,'C','TARRANT','SAGINAW','TRINITY',23004,26202,29400,31000,31000,31000);
Insert into POPULATION values (469,'C','TARRANT','SANSOM PARK','TRINITY',4800,5100,5723,6064,6406,6740);
Insert into POPULATION values (470,'C','TARRANT','SOUTHLAKE','TRINITY',26800,30000,35000,40000,45000,50000);
Insert into POPULATION values (471,'C','TARRANT','TROPHY CLUB','TRINITY',902,902,902,902,902,902);
Insert into POPULATION values (472,'C','TARRANT','WATAUGA','TRINITY',25000,25000,25000,25000,25000,25000);
Insert into POPULATION values (473,'C','TARRANT','WESTLAKE','TRINITY',1175,1767,2566,3090,3615,4129);
Insert into POPULATION values (474,'C','TARRANT','WESTOVER HILLS','TRINITY',698,715,732,749,766,782);
Insert into POPULATION values (475,'C','TARRANT','WESTWORTH VILLAGE','TRINITY',2700,2945,3187,3422,3658,3889);
Insert into POPULATION values (476,'C','TARRANT','WHITE SETTLEMENT','TRINITY',16957,17858,18750,22000,28000,34000);
Insert into POPULATION values (477,'C','WISE','ALVORD','TRINITY',1625,1957,2297,2800,3200,3600);
Insert into POPULATION values (478,'C','WISE','AURORA','TRINITY',1546,1918,2300,2800,3300,3900);
Insert into POPULATION values (479,'C','WISE','BOLIVAR WSC','TRINITY',1232,1420,1614,1827,2054,2294);
Insert into POPULATION values (480,'C','WISE','BOYD','TRINITY',1303,1413,2000,2500,3500,3800);
Insert into POPULATION values (481,'C','WISE','BRIDGEPORT','TRINITY',7456,9144,10875,15000,20000,25000);
Insert into POPULATION values (482,'C','WISE','CHICO','TRINITY',1051,1107,1165,2200,2800,3500);
Insert into POPULATION values (483,'C','WISE','COUNTY-OTHER','TRINITY',30543,30543,30543,45000,58000,70000);
Insert into POPULATION values (484,'C','WISE','DECATUR','TRINITY',8508,11738,15253,19751,23225,27000);
Insert into POPULATION values (485,'C','WISE','FORT WORTH','TRINITY',12089,17356,22400,28808,35075,41342);
Insert into POPULATION values (486,'C','WISE','NEW FAIRVIEW','TRINITY',1597,1983,2379,2900,3400,4000);
Insert into POPULATION values (487,'C','WISE','NEWARK','TRINITY',1772,2339,3302,4458,6216,8300);
Insert into POPULATION values (488,'C','WISE','RHOME','TRINITY',2384,3368,4377,7000,9400,12000);
Insert into POPULATION values (489,'C','WISE','RUNAWAY BAY','TRINITY',1448,1633,1822,2200,2500,3000);
Insert into POPULATION values (490,'C','WISE','WALNUT CREEK SUD','TRINITY',3869,5235,6636,8182,12131,15683);
Insert into POPULATION values (491,'C','WISE','WEST WISE SUD','TRINITY',3459,3580,3705,3835,3969,4108);
Insert into POPULATION values (492,'D','BOWIE','CENTRAL BOWIE COUNTY WSC','RED',1199,1233,1244,1244,1244,1244);
Insert into POPULATION values (493,'D','BOWIE','CENTRAL BOWIE COUNTY WSC','SULPHUR',6453,6636,6693,6693,6693,6693);
Insert into POPULATION values (494,'D','BOWIE','COUNTY-OTHER','RED',6834,7028,7088,7088,7088,7088);
Insert into POPULATION values (495,'D','BOWIE','COUNTY-OTHER','SULPHUR',13078,13561,13712,13712,13712,13712);
Insert into POPULATION values (496,'D','BOWIE','DE KALB','RED',267,275,277,277,277,277);
Insert into POPULATION values (497,'D','BOWIE','DE KALB','SULPHUR',1490,1532,1545,1545,1545,1545);
Insert into POPULATION values (498,'D','BOWIE','HOOKS','RED',2863,2944,2970,2970,2970,2970);
Insert into POPULATION values (499,'D','BOWIE','MACEDONIA-EYLAU MUD #1','SULPHUR',8397,8530,8572,8572,8572,8572);
Insert into POPULATION values (500,'D','BOWIE','MAUD','SULPHUR',1092,1123,1133,1133,1133,1133);
Insert into POPULATION values (501,'D','BOWIE','NASH','SULPHUR',3061,3148,3175,3175,3175,3175);
Insert into POPULATION values (502,'D','BOWIE','NEW BOSTON','RED',1383,1422,1435,1435,1435,1435);
Insert into POPULATION values (503,'D','BOWIE','NEW BOSTON','SULPHUR',3322,3416,3445,3445,3445,3445);
Insert into POPULATION values (504,'D','BOWIE','RED LICK','RED',568,584,589,589,589,589);
Insert into POPULATION values (505,'D','BOWIE','RED LICK','SULPHUR',475,488,492,492,492,492);
Insert into POPULATION values (506,'D','BOWIE','REDWATER','SULPHUR',1093,1124,1134,1134,1134,1134);
Insert into POPULATION values (507,'D','BOWIE','TEXAMERICAS CENTER','RED',91,93,94,94,94,94);
Insert into POPULATION values (508,'D','BOWIE','TEXAMERICAS CENTER','SULPHUR',442,455,459,459,459,459);
Insert into POPULATION values (509,'D','BOWIE','TEXARKANA','RED',4442,4568,4607,4607,4607,4607);
Insert into POPULATION values (510,'D','BOWIE','TEXARKANA','SULPHUR',33204,34144,34439,34439,34439,34439);
Insert into POPULATION values (511,'D','BOWIE','WAKE VILLAGE','SULPHUR',5949,6109,6160,6160,6160,6160);
Insert into POPULATION values (512,'D','CAMP','BI COUNTY WSC','CYPRESS',6842,8224,9305,10587,11779,12941);
Insert into POPULATION values (513,'D','CAMP','COUNTY-OTHER','CYPRESS',2012,1715,1483,1208,952,702);
Insert into POPULATION values (514,'D','CAMP','PITTSBURG','CYPRESS',4701,4934,5116,5332,5533,5729);
Insert into POPULATION values (515,'D','CASS','ATLANTA','CYPRESS',5772,5812,5812,5812,5812,5812);
Insert into POPULATION values (516,'D','CASS','ATLANTA','SULPHUR',6,6,6,6,6,6);
Insert into POPULATION values (517,'D','CASS','COUNTY-OTHER','CYPRESS',13965,14060,14060,14060,14060,14060);
Insert into POPULATION values (518,'D','CASS','COUNTY-OTHER','SULPHUR',3885,3911,3911,3911,3911,3911);
Insert into POPULATION values (519,'D','CASS','EASTERN CASS WSC','CYPRESS',1925,1939,1939,1939,1939,1939);
Insert into POPULATION values (520,'D','CASS','EASTERN CASS WSC','SULPHUR',149,150,150,150,150,150);
Insert into POPULATION values (521,'D','CASS','HUGHES SPRINGS','CYPRESS',1786,1799,1799,1799,1799,1799);
Insert into POPULATION values (522,'D','CASS','LINDEN','CYPRESS',2025,2038,2038,2038,2038,2038);
Insert into POPULATION values (523,'D','CASS','QUEEN CITY','CYPRESS',939,946,946,946,946,946);
Insert into POPULATION values (524,'D','CASS','QUEEN CITY','SULPHUR',564,568,568,568,568,568);
Insert into POPULATION values (525,'D','DELTA','COOPER','SULPHUR',2003,2024,2024,2024,2024,2024);
Insert into POPULATION values (526,'D','DELTA','COUNTY-OTHER','SULPHUR',3079,3111,3111,3111,3111,3111);
Insert into POPULATION values (527,'D','DELTA','NORTH HUNT SUD','SULPHUR',238,241,241,241,241,241);
Insert into POPULATION values (528,'D','FRANKLIN','COUNTY-OTHER','CYPRESS',368,385,394,404,410,417);
Insert into POPULATION values (529,'D','FRANKLIN','COUNTY-OTHER','SULPHUR',454,475,488,500,509,516);
Insert into POPULATION values (530,'D','FRANKLIN','CYPRESS SPRINGS SUD','CYPRESS',4235,4427,4543,4655,4740,4806);
Insert into POPULATION values (531,'D','FRANKLIN','CYPRESS SPRINGS SUD','SULPHUR',2535,2649,2718,2786,2836,2876);
Insert into POPULATION values (532,'D','FRANKLIN','MOUNT VERNON','SULPHUR',2793,2919,2995,3069,3125,3169);
Insert into POPULATION values (533,'D','FRANKLIN','WINNSBORO','CYPRESS',739,772,792,812,827,838);
Insert into POPULATION values (534,'D','GREGG','CLARKSVILLE CITY','SABINE',948,1038,1141,1258,1389,1537);
Insert into POPULATION values (535,'D','GREGG','COUNTY-OTHER','CYPRESS',860,942,1036,1142,1261,1396);
Insert into POPULATION values (536,'D','GREGG','COUNTY-OTHER','SABINE',4678,5123,5631,6205,6853,7585);
Insert into POPULATION values (537,'D','GREGG','CROSS ROADS SUD','SABINE',364,399,438,483,533,590);
Insert into POPULATION values (538,'D','GREGG','EASTON','SABINE',502,550,605,666,735,814);
Insert into POPULATION values (539,'D','GREGG','ELDERVILLE WSC','SABINE',3441,3769,4143,4566,5041,5579);
Insert into POPULATION values (540,'D','GREGG','GLADEWATER','SABINE',4376,4792,5268,5806,6410,7094);
Insert into POPULATION values (541,'D','GREGG','KILGORE','SABINE',10913,11951,13139,14480,15987,17694);
Insert into POPULATION values (542,'D','GREGG','LAKEPORT','SABINE',1067,1169,1285,1416,1564,1730);
Insert into POPULATION values (543,'D','GREGG','LIBERTY CITY WSC','SABINE',5014,5491,6037,6653,7346,8130);
Insert into POPULATION values (544,'D','GREGG','LONGVIEW','SABINE',86085,94275,103640,114219,126114,139574);
Insert into POPULATION values (545,'D','GREGG','TRYON ROAD SUD','CYPRESS',4167,4563,5016,5528,6104,6755);
Insert into POPULATION values (546,'D','GREGG','TRYON ROAD SUD','SABINE',293,321,353,389,430,476);
Insert into POPULATION values (547,'D','GREGG','WEST GREGG SUD','SABINE',3552,3890,4276,4713,5203,5759);
Insert into POPULATION values (548,'D','GREGG','WHITE OAK','SABINE',7087,7761,8532,9403,10382,11490);
Insert into POPULATION values (549,'D','HARRISON','COUNTY-OTHER','CYPRESS',16655,17885,19160,20949,22900,25196);
Insert into POPULATION values (550,'D','HARRISON','COUNTY-OTHER','SABINE',10447,11221,12019,13143,14365,15809);
Insert into POPULATION values (551,'D','HARRISON','DIANA SUD','CYPRESS',357,384,411,449,491,540);
Insert into POPULATION values (552,'D','HARRISON','GILL WSC','SABINE',1456,1563,1675,1831,2001,2202);
Insert into POPULATION values (553,'D','HARRISON','GUM SPRINGS WSC','CYPRESS',1962,2107,2257,2468,2697,2968);
Insert into POPULATION values (554,'D','HARRISON','GUM SPRINGS WSC','SABINE',5340,5735,6144,6717,7342,8079);
Insert into POPULATION values (555,'D','HARRISON','HALLSVILLE','SABINE',3834,4117,4411,4822,5271,5800);
Insert into POPULATION values (556,'D','HARRISON','LONGVIEW','SABINE',2005,2153,2306,2521,2756,3032);
Insert into POPULATION values (557,'D','HARRISON','MARSHALL','CYPRESS',4437,4765,5105,5581,6100,6713);
Insert into POPULATION values (558,'D','HARRISON','MARSHALL','SABINE',20773,22309,23899,26130,28561,31427);
Insert into POPULATION values (559,'D','HARRISON','TRYON ROAD SUD','CYPRESS',756,812,870,951,1039,1144);
Insert into POPULATION values (560,'D','HARRISON','WASKOM','CYPRESS',2315,2487,2664,2912,3183,3503);
Insert into POPULATION values (561,'D','HOPKINS','BRINKER WSC','SULPHUR',2252,2601,2919,3284,3636,3990);
Insert into POPULATION values (562,'D','HOPKINS','CASH SUD','SABINE',101,109,116,124,132,139);
Insert into POPULATION values (563,'D','HOPKINS','COMO','SABINE',573,628,678,736,791,847);
Insert into POPULATION values (564,'D','HOPKINS','COMO','SULPHUR',201,220,238,258,278,297);
Insert into POPULATION values (565,'D','HOPKINS','COUNTY-OTHER','CYPRESS',442,499,552,613,671,730);
Insert into POPULATION values (566,'D','HOPKINS','COUNTY-OTHER','SABINE',4269,4203,4142,4071,4004,3936);
Insert into POPULATION values (567,'D','HOPKINS','COUNTY-OTHER','SULPHUR',2243,2432,2604,2803,2994,3188);
Insert into POPULATION values (568,'D','HOPKINS','CUMBY','SABINE',838,972,1094,1235,1371,1507);
Insert into POPULATION values (569,'D','HOPKINS','CUMBY','SULPHUR',81,94,106,119,132,145);
Insert into POPULATION values (570,'D','HOPKINS','CYPRESS SPRINGS SUD','CYPRESS',310,310,310,310,310,310);
Insert into POPULATION values (571,'D','HOPKINS','CYPRESS SPRINGS SUD','SULPHUR',602,602,602,602,602,602);
Insert into POPULATION values (572,'D','HOPKINS','JONES WSC','SABINE',140,169,195,225,254,283);
Insert into POPULATION values (573,'D','HOPKINS','MARTIN SPRINGS WSC','SABINE',3195,3737,4233,4801,5349,5900);
Insert into POPULATION values (574,'D','HOPKINS','MARTIN SPRINGS WSC','SULPHUR',584,684,774,878,978,1079);
Insert into POPULATION values (575,'D','HOPKINS','NORTH HOPKINS WSC','SULPHUR',5907,6576,7186,7887,8563,9242);
Insert into POPULATION values (576,'D','HOPKINS','SULPHUR SPRINGS','SABINE',49,51,53,56,58,61);
Insert into POPULATION values (577,'D','HOPKINS','SULPHUR SPRINGS','SULPHUR',16191,17008,17753,18608,19433,20261);
Insert into POPULATION values (578,'D','HUNT','ABLES SPRINGS WSC','SABINE',893,1368,2012,2902,4170,6013);
Insert into POPULATION values (579,'D','HUNT','BLACKLAND WSC','SABINE',32,32,32,32,32,32);
Insert into POPULATION values (580,'D','HUNT','CADDO BASIN SUD','SABINE',6337,8401,11201,15067,20576,28581);
Insert into POPULATION values (581,'D','HUNT','CADDO MILLS','SABINE',1710,2214,2898,3843,5190,7147);
Insert into POPULATION values (582,'D','HUNT','CAMPBELL','SABINE',727,903,1143,1473,1944,2629);
Insert into POPULATION values (583,'D','HUNT','CAMPBELL','SULPHUR',50,62,78,101,133,180);
Insert into POPULATION values (584,'D','HUNT','CASH SUD','SABINE',17740,21288,25545,30654,36784,44140);
Insert into POPULATION values (585,'D','HUNT','CASH SUD','SULPHUR',252,302,363,435,522,627);
Insert into POPULATION values (586,'D','HUNT','CELESTE','SABINE',991,1231,1558,2009,2651,3584);
Insert into POPULATION values (587,'D','HUNT','COMBINED CONSUMERS SUD','SABINE',6063,7535,9531,12288,16216,21923);
Insert into POPULATION values (588,'D','HUNT','COMMERCE','SULPHUR',8883,9975,11456,13502,16416,20651);
Insert into POPULATION values (589,'D','HUNT','COUNTY-OTHER','SABINE',16719,23249,32662,46427,67453,99563);
Insert into POPULATION values (590,'D','HUNT','COUNTY-OTHER','SULPHUR',1350,2091,3174,4559,7020,9959);
Insert into POPULATION values (591,'D','HUNT','COUNTY-OTHER','TRINITY',259,297,277,372,37,206);
Insert into POPULATION values (592,'D','HUNT','GREENVILLE','SABINE',28700,32964,38749,46738,58120,74659);
Insert into POPULATION values (593,'D','HUNT','HICKORY CREEK SUD','SABINE',2045,2989,4269,6038,8558,12219);
Insert into POPULATION values (594,'D','HUNT','HICKORY CREEK SUD','SULPHUR',1419,2076,2966,4195,5944,8488);
Insert into POPULATION values (595,'D','HUNT','HICKORY CREEK SUD','TRINITY',700,1021,1459,2062,2924,4175);
Insert into POPULATION values (596,'D','HUNT','JOSEPHINE','SABINE',131,232,369,559,559,559);
Insert into POPULATION values (597,'D','HUNT','LONE OAK','SABINE',749,954,1232,1617,2165,2962);
Insert into POPULATION values (598,'D','HUNT','MACBEE SUD','SABINE',337,419,530,683,902,1219);
Insert into POPULATION values (599,'D','HUNT','NORTH HUNT SUD','SULPHUR',3483,4551,6000,8001,10851,14993);
Insert into POPULATION values (600,'D','HUNT','QUINLAN','SABINE',1441,1505,1591,1711,1882,2130);
Insert into POPULATION values (601,'D','HUNT','ROYSE CITY','SABINE',364,452,572,737,973,1316);
Insert into POPULATION values (602,'D','HUNT','WEST TAWAKONI','SABINE',1800,2104,2516,3086,3898,5078);
Insert into POPULATION values (603,'D','HUNT','WOLFE CITY','SULPHUR',1719,2136,2703,3484,4598,6217);
Insert into POPULATION values (604,'D','LAMAR','BLOSSOM','SULPHUR',1566,1626,1671,1712,1744,1769);
Insert into POPULATION values (605,'D','LAMAR','COUNTY-OTHER','RED',820,851,875,896,913,926);
Insert into POPULATION values (606,'D','LAMAR','COUNTY-OTHER','SULPHUR',1887,1962,2016,2066,2103,2135);
Insert into POPULATION values (607,'D','LAMAR','DEPORT','SULPHUR',552,573,589,603,614,623);
Insert into POPULATION values (608,'D','LAMAR','LAMAR COUNTY WSD','RED',11919,12381,12722,13031,13272,13467);
Insert into POPULATION values (609,'D','LAMAR','LAMAR COUNTY WSD','SULPHUR',5053,5248,5393,5524,5626,5708);
Insert into POPULATION values (610,'D','LAMAR','PARIS','RED',10487,10893,11193,11465,11677,11848);
Insert into POPULATION values (611,'D','LAMAR','PARIS','SULPHUR',15886,16501,16956,17368,17690,17949);
Insert into POPULATION values (612,'D','LAMAR','RENO','RED',438,455,467,479,488,495);
Insert into POPULATION values (613,'D','LAMAR','RENO','SULPHUR',2880,2991,3074,3148,3206,3253);
Insert into POPULATION values (614,'D','LAMAR','ROXTON','SULPHUR',682,708,727,745,759,770);
Insert into POPULATION values (615,'D','MARION','COUNTY-OTHER','CYPRESS',8100,8100,8100,8100,8100,8100);
Insert into POPULATION values (616,'D','MARION','DIANA SUD','CYPRESS',384,384,384,384,384,384);
Insert into POPULATION values (617,'D','MARION','JEFFERSON','CYPRESS',2117,2117,2117,2117,2117,2117);
Insert into POPULATION values (618,'D','MORRIS','BI COUNTY WSC','CYPRESS',1276,1299,1325,1364,1395,1426);
Insert into POPULATION values (619,'D','MORRIS','COUNTY-OTHER','CYPRESS',2833,2887,2945,3032,3102,3170);
Insert into POPULATION values (620,'D','MORRIS','COUNTY-OTHER','SULPHUR',839,854,871,897,917,938);
Insert into POPULATION values (621,'D','MORRIS','DAINGERFIELD','CYPRESS',2646,2695,2749,2829,2894,2958);
Insert into POPULATION values (622,'D','MORRIS','HUGHES SPRINGS','CYPRESS',7,7,7,7,7,7);
Insert into POPULATION values (623,'D','MORRIS','LONE STAR','CYPRESS',1634,1664,1698,1748,1787,1827);
Insert into POPULATION values (624,'D','MORRIS','NAPLES','CYPRESS',644,656,669,688,704,720);
Insert into POPULATION values (625,'D','MORRIS','NAPLES','SULPHUR',780,795,811,835,854,872);
Insert into POPULATION values (626,'D','MORRIS','OMAHA','CYPRESS',627,639,652PK     ! £ï»e  R   [Content_Types].xml ¢(                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  ´”ËjÃ0E÷…şƒÑ¶ØJº(¥ÄÉ¢ehúŠ4vDõBR^ßQœ˜’òØ¬™{ïÙÒ`´Ò*[€Òš’ô‹ÉÀp+¤©Kò3ùÈŸI"3‚)k $kd4¼¿LÖB†jJ2‹Ñ½Pø4…u`°RY¯YÄW_SÇø/«>özO”[ÁÄ<&2¼AÅæ*fï+\nHœ©IöÚô¥¨’HôiTxPaOÂœS’³ˆuº0b+ß2¨Üô„™tá$¤Êñ€­î7ÓKÙ˜ùøÉ4vÑ¥õ‚
Ëç•Åi›œ¶ª$‡VŸÜœ·BÀ¯¤UÑV4“fÇ”#Äµ‚p}ŠÆ·;bDÁ- ¶ÎK˜~ßŒâŸy'H…¹6Up}ŒÖº"â™…æÙ¿˜ccs*;ÇŞº€w€?cìİ‘Mêvà£<ı×µ‰h}ñ|nâ@6İÜˆÃ?   ÿÿ PK     ! ‘·ï   N   _rels/.rels ¢(                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  ¬’ÁjÃ0@ïƒıƒÑ½QÚÁ£N/cĞÛÙ[ILÛØj×şı<ØØ]éaGËÒÓ“ĞzsœFuà”]ğ–UŠ½	Öù^Ã[û¼x •…¼¥1xÖpâ›æöfıÊ#I)Êƒ‹YŠÏ‘øˆ˜ÍÀå*Döå§i")ÏÔc$³£qU×÷˜~3 ™1ÕÖjH[{ª=E¾†ºÎ~
f?±—3-ÂŞ²]ÄTê“¸2j)õ,l0/%œ‘b¬
ğ¼Ñêz£¿§Å‰…,	¡	‰/û|f\ZşçŠæ?6ï!Y´_áoœ]Aó  ÿÿ PK     ! 3‹l  µ   word/_rels/document.xml.rels ¢(                                                                                                                                                                                                                                                                  ¬“ËNÃ0E÷Hüƒ5{â¤@…PnP¥n!|€›L‹ø!{
äï1­ ©¨"YÎµæÜãÅ¬ÖŸ¦gï¢vV@‘åÀĞÖ®ÑV	x­67À"IÛÈŞY0`„uy}µzÆ^RZŠö‘%Š:"ÿÈy¬;42fÎ£M/­FRƒâ^ÖoR!_äù’‡1Ê3&Û6Â¶¹VÿÃvm«k|rõŞ ¥üw/H”>V…$`f‰ü²ÈbN‘øÇâ'™R(fU ¡Ç±Àaª_ÎYOiOí‡ñS÷s:´ÎR%wıÈã7š’¸›SB›t'ƒ–Ç°È¼UßüìØÊ/   ÿÿ PK     ! 'ÚŞ§  š
     word/document.xml¤VÛnã6}/ĞøHrl¯+DYÄqbHc³}.hŠ’K$AÒ·~}gHIö6hš,Éá™û±n¿Ú&Úqc…’9I¯qÉT!d•“?¿?]ÍHd•m”ä99rK¾ŞıúËí>+Û¶\º ¤Íöšå¤vNgqlYÍ[j¯[ÁŒ²ªt×Lµ±*KÁx¼W¦ˆGIšxIÅ¸µ`ïÊµ¤ƒkß¢)Í%–Ê´ÔÁÒTqKÍf«¯ ]S'Ö¢îØÉ´‡Q9Ù™uWƒCx%u¯ş†ùˆİpeÑeÀ[ŒoÀ%m-ô)ŒÏ¢ÁaİƒìŞb×6½Ş^§ãËj°0t¯àGÜ/Â¥¶	¿˜&¨B7>âÂ6{OZ*äÉğ§Rs–Ütòs £èê²â,Úêš¸íYn,œìŸÀêŠ|š½Ì™×šj˜À–eÏ•T†®ğJAÖ#lkrŒ³VÅß:ÚgÀXÅ·œ$Édœ~¹Úê¶¼¤ÛÆáÉ|–LnıÉ
·îçÉo‹¹Ó+ƒ/G×¶{ƒâ69ixéğ–VÕ$'$¾»{Õx¸A–je”*ƒb·×Íˆ:²’G…°î;8B¼4¤—AÂ˜ˆ9£’ÕÊ<ÀË7‹4>Nº^ç·Ÿ’û‡‡ÇŒGgüàÙ!'³éd2:;æ„Y’ø P«,9sA·ñÆ0Y$2ş¹ÆgĞ~_™H€‰$m¡"+ÁÜÖğhÔ©°?vKCu-Ø“›fÕÙÎ‹bÛ5	ı—„	–ê¡¦²â÷Vƒïw(Èûö/µzµ F[óvàşJ‡ŒH™Üéb4¹ƒz`Ì¸€TtÕJûja–ú#TÄ¤½¹·n„~Mƒá¢™Œ·k8Ğyc„ ™u†;V£X‚ê7(bxÜ®¬ŸšJÓâ :ø;v=F±eßí×øt]ë–\µ
àøàKDw/¶ó¦WéÜ	x~^ã¬çëĞLaDı “‹Ã˜Gmğ[ãÕQã€0ÏsB¦ÿZª9e?ƒî£,ÍÀ-x•úO{õ-ş#UU¯Ã)ü¦“ÙØkÖ FAVFÀ0oÁgšeH¤Ş]ıNÑSğ/şeˆªvÃj­œSí°DŞ5§7Ã²TÊ-«­óËÀS…]«)ãAÇoƒ,À,`fWZ%'7Ó>!^Ì™ï>‚îş  ÿÿ PK
       ! %>û†¬5 ¬5    word/media/image1.png‰PNG

   IHDR  ]  u   "İĞ   sRGB ®Îé  ÿÊIDATx^ìı€Å¹÷ÏìĞÑe»\Dî»rD°+‘`‚rQÌ	^ò¾?ñBæ§çQÏÑ`0æ˜Ä˜ÿ#‘ˆæ•#*G–UA]å"ÆvA®9r'°3óÿv×lÓÎÎÎôÌtwU÷|Ûq™KuÕSŸ§º»zª
îÜ¹3ÀƒH€H€H€H€H€²˜@0‰dqõYu     ä	 	 	 	 	 	d9ú‹²¼°ú$¹~æÕ«WWUU	¹GŒ1|øğtê`÷9Á`Ğî,™	 	 	€{è/r5K"O‡#¡H#ş†#¡H ¯°¤×ªU«êë#â…÷²Ä0Ê4€%{1k4zºQx  H€ş"‰ğY4	xƒ€ŞÑ‡ÿŞVAây?û÷††¨ ÅÅ™ÿß¿¨ dÈÏÉiÀq¤-ÛŒĞƒ¤ˆ^(	 	 	X!@‘JLCÙK@3Š´bš+D³Âá@¨Qò+FÒå ğ¦é!làDÒ1iĞè8ÊŞË†5' ğ >¹=¨4ŠL.Ğ»ûÚŸ3áÓáœpc0ÜèbùqŠª©©Áô9ñCEEEyy¹\y4@ÁÜpn~~N°u~.ŒH’úb#zŒ¤k† 	 	€U´‹¬’b:ÈBÂY$<Eg#§C¹‘F˜FÒQ„á¶Òœ%œŞá`n('6QëÜÜ}&şÂ„:Î¦“ŞX( 	 	 	X" D—Â’¤LD$ €¶TF¦‡5ÂÑH¢y‘0‡Ä¡„4ú,CÀ	…5J!- ƒîbÓX1H"*¢$@$@$„€*½
*ŠH@5º³H3‹ ˜X]¤[SMLUä™P¦‘ˆJ§CÓV1<*
¢$@$@$˜ í"¶ Ä‚Âó™kš„´â.5#vyÔWDg[	 	 	x‡ í"ïèŠ’’€Ûtg‡æ$Ò§ÒiÁÖ¢·Q¾<ÍnÔ¦Òa2f:ŠItMş5N¥S^H€H€°h™H€H 1èT:Ñİwì8}útß¾}/ĞiÓ¦ÙXr:tè¡C‡lÌ³yVb’!#±›®5Gi3s  ° í"Û‘2Cğ}*]tåŒ#µƒé‚pÛ?şøQıèİ»÷†)É™LõytúÊ¢s&İDÎ°f®$@$@$àÚEÎpe®$àÆ<‘ ƒë‹jkkKKK'Mš$°Í={ğàÁxóÒK/¤;wÎ˜1Cø”„CÉü+>	†ÒµkW'\O-iUŸG§…YÁ*ÄÁİ‹ür°$@$@YA€vQV¨™•$	Gˆsë‹¶mÛ6`À ÃÔéĞ¡üE°sÖ®]kxÖ¯__]][èğáÃyyy‹/6ÿ*üKøfõêÕüñ®]»p"R¶iÓÆét:Ûh:ØBú„:'gf¨KN$@$@$ í"¶ KÄú‡úû={öÜ´iä˜>}:ì™ıèGx¿wï^Ã#4wîÜ;vÀY„FQ=b~­¯¯Ç)½zõ*((hllœ<y2üE………Ë—/·T½Ì9
'3Ñx6	 	 	€%´‹,ab" ˆnWê ‹²²²O>ù. ˜¼Ç'üE8`ê$øÕ˜ƒ‡4ğ,aVğ;Öyãdéwäg)$@$@$åhey`õIÀ*ZÀ!f»ÕÔÔÌš5K,
úÏÿüÏnİº6¬¸¸X|ƒ™u°vÌ²^sÍ5æ_Íq`e	GSQQÑşıû­Ö0ƒtÂÉ@.J$@$@$`•€¾J˜	 	4# b«!Œ@(9
=:zª±]~¤m>¶2âñ'ƒGÎä´ÊÍiÛ&7?7¨¿rrs‚ØŠñØVH€H€HÀè/ò„š($	(A@÷q$%¾.G‰6J!H€H€H ]´‹Ò%ÇóH ËèSÅœİÚÕ»D	Ç»º£ä$@$@$ Ğ.bK °D 6‘së‹,I p"ÂQX9H€H€, ]d	‘ 	€€ˆFÍ#.ÂaÃ   O ]äiõQxp@tª˜3>}‰ĞsÓ¦Mk^öx?~ü©S§œ)?Ó\…“©p<ŸH€H€HÀÚE 1		 œEÚşEÚá×>pà vÂ¶­æ Ûi‡}]gÌ˜qèĞ¡4ÎMï§á¤'Ï"  °N€v‘uVLIÙKàãµ¼¸à?şòûùÿ¿_ÍÃFCî€xä‘GÌ¤“'Oöîİß\{íµÂq$6).&8”`Áé„÷Ø	[ÄvïŞo„
Ûehk%¨2€üî¹ù€óÊ¯¾eÃ‡îÀa)$@$@$@ö ]d/OæFş$°jÕªúú^ªª*'¼Fµµµ;vÄN¬÷İwßàÁƒ×¬YS]]ÒÑ£G±ë¢E‹öìÙa½ùæ›0„Ö®]‹8`/a×W|\½zõÂ…üñI“&íØ±ã†n˜>}:Àw„<Ò|ğŞ¡R˜-	 	 	€£h9Š—™“€oœ›>ç„QLbİüùóçÎ‹Û¶m;vìyç‡÷}úôùüóÏ{õêUPP >ÖÕÕíİ»×ğáXAFú°aÃºtéÒÒš%ßè†!  Èœ í¢Ì2ğ?ÇVÅ¢›:uªX_Ô³gÏM›6‰Ÿ·nİzÅWIñ&>7Nø‹pL<Ùœ–Á¡„o„¿£§zÊÿzbI€H€H€Ò%@»(]r<²‰@EEEII°¸8€Weee0t¨ö0ŠFõöÛoÃÕƒésbùPCCÌc}>bšœ9–a!2›rŠÓq<øàƒwİu—C2 ƒŞ;T
³%  p”@Ğ¡)1
ÍÌI€\  ûˆğ'
GÎ†Â;zf÷ÿü½cÛ`Q[§Äâ?|2üåÑÈ…ççµoŸÔ_9¹90Ñ9+Ò…VÀ"H€H€H [°“-šf=I Sº(ˆÿx4'@8l$@$@$àq´‹<®@ŠOnàÖ¥	H[Íå 	 	€Sh9E–ù’€ÿ„#Ú¼:q		 	 	xš í"O«Â“€{`…µõˆ4Œâ0'÷"K"  gĞ.r†+s%ÿĞEôÅW,áø¯Á³F$@$@YF€vQ–)œÕ%t	ÀO¤û‹dkÖ¬AĞmüBÌœ9S„á6¾‘%œ
pdÕå’ 	 	€?Ğ.ò‡Ypœ€Şõ—é/‚ñ3gÎœ;ï¼ST»á/öl]±b¾w¼ş	GnõY:	 	 	ø€ í"(‘U WhFúÿÒ<FØÈuÉ’%FU±ëë¼yó\©¹…BdÃ± "“ 	 	 	$"@»ˆíƒHÀe]"¯¾úêC=d©%Rc5fÆ$@$@$à7´‹ü¦QÖ‡²ŠÀ3Ï<ÓµkW¸’²ªÖ¬,	 	 	€íhÙ”’ 	¸D qPÒı÷ßïRy,†H€H€HÀ¿‚²ãKù-kF' ÇÃŸ`(9
ïùúLİ“İ.Ìíza®”š!îÂ˜1cDÑ#GÄÜ9ã#¾Ù¸q#VI…8şâPcÑ­º^Ü&?7¨¿rrs‚Am9Vÿğ   Pœ í"ÅDñH@Õì"i ,L»È$&!  ¥	pÒê¡p$ ÍïA×G*!¥Ú*…!  T	Ğ.J•Ó“@–@¿?7Ì¡aOÿ„“¥W«M$@$à#´‹|¤LV…œ$€›…¶`†ş¢x	ÇÉ¦Ç¼I€H€HÀ´‹Ü Ì2HÀ4—HN ‡vQKş"ÂñA+gH€H€²˜ í¢,V>«N)À$:Í_DÃ(¾aD8)µ&&&  Õ0j¡<$ 
˜xtİı?ïØ6Ø±@²iTSSSUU%01¢¼¼\:²ÿ9ùòhäÂóó:^ĞŠqº¥«ƒ 	 	@h¥§@Vˆ±‹?»÷ë¿_Ø&xakÉÕÿõ/ç74DeÀ–E?ü,P pâlğàÉpûóò.iG»Hº6( 	 	 	¤C€vQ:Ôx	d»è«gö9«BÅ—ÿŸoØEc¿/ß.XÚµÉ»¸ ¯u~N^÷uU¡¥P  H í¢`1)	d³]Ô;İxôt(‡"H8¼Á®Gî^òÂ\³¿hÂ?–§—HÕ°R3˜<??·mëÜV¹Áü<Í4ÒÂ÷é|¸&K‚X2	 	 	X%@»È*)¦#l# ì¢p$DC‘ÆpàL(|¦1|ïCÑï¥0Ù÷ùúU«V‰¢+**:]q¥1ŒBaş L_Ì¡Ü`«¼œV¹0Š´â{ÚErµÃÒI€H€HÀ"ÚEA1	dÃ.Âø‹`E¢0ì¢0ì%ØMøIÿ×íã±7vOÕìïvw»lSypÁÛG·‹Äô9Í4Â_¼ÇO´‹$j‡E“ 	 	@Jh¥„‹‰I ‹DtÃH÷B°…4Ó(O$|Ôì"‘B;ÜP7kÙ”Ããññí"­ö¨9 Ø?˜5§™Cš×(:‰_Ší8‘.‹.V•H€HÀ³hyVuœ& Y=Aí¡™FaØBÍ.ÒœEøF·‹ €n¹ï2zøõíÂ.zjb‡1´˜½î(Ò#á/‚FQSÄ… ¶3Â—šE‰Ğ.’¥#–K$@$@Ö	Ğ.²ÎŠ)I »»FnivQHû	é‹‹$N¢ƒ~üçmBº¹·ô”«óTºÜ\-ÖBn53I» ›‰v‘\±t  °F€v‘5NLEYIÀI‘°Ä´:|3èô™tnO¢C¹?úÓÂ.zvêåR5õi.#İA$GÚ‹Áè¤*†…“ 	 	@ªh¥JŒéI ‹˜]FÂA¤[DšIÒ¤4$ØE?|é¯Â.úõôŞRõ!–‰ÿ´˜İš9YGg‘TÍ°p  H‘€÷ì¢»¿úñÁãoL±¦Lî6³‘ˆël¬Ìw»|–ga4?Äê#›
I5LêÓ’` CA^ªçÚœ^_A¤-$‚½]rÔTBKèl–€Ù%!Ğ¶uŞÄòe]Û‘	 	 	$ à=»èÑ¥õõ‡NQ©$@îˆÎ•FPtGs±èÜ“Cİ’4³¨ija”’œ	†ê"’+Y—‹Zÿì{ÒBtÈ­;K' °HÀ{vÑ‹ê;‹ÅÍ…ÒÇ‰-2ÎÖd‡O z™6¢/Bóğ6±HSå9ëHb´I}á@›üœ¶mr%ŠñÍ¢›Èˆ8}qlÊÈš=‚>İ¶"—´ËŸ?¹WöÔš5% Hƒ€Wí">äÒP¶Ë§–šr»£Å5¹Dhé¶„Y_nD‹ÈÑV˜bæ¼¥ŒÉI€H {	ädoÕYs 	 Ç¯š/„¯xt:<H€H€H€<H€v‘•F‘I€H€H€H€H€l%@»ÈVœÌŒH€H€H€H€HÀƒhyPi™H€H€H€H€HÀV´‹lÅÉÌH€H€H€H€H€<H€v‘•F‘I€H€H€H€H€l%@»ÈVœÌŒH€H€H€H€HÀƒhyPi™H€H ;¿:ızÍAãuòL	ñ×ü%Ò	 	 	Ä ]Ä&A$@$à…ùùôaø{uÃ_ãüŠ4ş©0kB$@$`ÚE6d6$@$@
h×&wdŸ‹‚_‘FI)	 	€Zh©¥JC$@$!Q}ss‚q3Á÷ø5Ãüy:	 	€/	Ğ.ò¥ZY) È^/h5´¤]Üúã{üš½hXs  –	Ğ.bë  ğq;Ä­RKßû­ş¬	 	@ê‚‘H$õ³Ü;Qƒ6ì<f.oÅ–ÃXA[Ğ:wL¿ss!wk×íâ6î‰Å’,x`QİÁcg/i—?r/É™„H€ì$ğ³ÿÚ¹yÏ	sı;ü7t³³æE$@$à#ªÛE'Ï„|uû‘S	˜ççL½œëhUk–´‹TÓå!¬" £¦‘¹Ê0Š`eV–H€HÀ:ÕçÑß*÷ÆAñ§C•dp!ëúfJ È0ÌóğFQ–¨Õ$ ô¨n¡V£ú^”`™,ƒ¥§xE$@¾'`^MÄ•E¾W7+H$@ğ€]Ëgbù%-Õ“Á…2l<H€üJÀx@$ˆPç×º³^$@$@©ğ€]„*]Ó³}Ka8˜ªÊ™H€Ü!€¸>r÷«W_°õå^{^Å_¼—+Œ(İò,…H€H ªÇ]0ªÔ|-~bp¡4TîÚ)Œ»àjDêøêèÉ]L»ªÆß`Õ‰ßXøÛúú¨)R\¸qê99ÒF“¨¨°]ÑEmH0(‘+
`!$@$à)±‹@õßßÜ¹uß7‚®2¸R-&¨zÜˆêx`—¶=/=O)É)	@ætgHğ­õuO¿²:óÜlÉ¡âÂ=f»¨êÈe€4»È¨Ñí£Ë¾?¦, £H3•hÙ¢jfB$@6ğ’]„n÷¿,ÙaT3ëş}Bw0›;º÷O_œ%š(‚ ƒsoéÉ ê6!g6$ 
Í(Ò:ú‘·ÖÕ=½¨z@É¥ı‹[\êšĞûjß6ÛEE¥£$ú‹Pëúı_¯İºvÑôÑe ¥y‹tht¹Ö$X	 	$ à%»Õxî½İk¶õ¹§²Ë°P»JøãÚıom>œ@$„ĞHEC©ºP ëô…3ÚØE?_T=µ²ß”Š~ÖOw(eMMÍªU«Dæåååd1Û•µ–®»mTéícÊaEM#üËùt	2	 	8I@şŒ‚”j7iğ¥O‡S\(%n®%Óïb¡ ¸Gûóò’îFåš¨,ˆHÀ.º³H›¦F…úø0„f6Ò"ƒ6 …Ã+í…o5ã1ØÕ™	 	¤O 5»Hz0Ÿ¿~²¶ÇîW/ß»˜Á…Ò×¹“g^Ò.Á[*¢ü\…úLN’`Ş$U4«}ûp$b?™æA©1…#x£[’ºmÄƒH€H@6äóè”.TR7å‰“Å\(nëYf¤‹oÎ¤	¼I²¯–O$±²HÄ F_óèYü¾"óèÒ©“çˆyt“¯4íúÒ¼œ î‡xi³é¸ÊÈIìÌ›H€,Hd)\hw}}´jºÊàBÕìr²ùï|¹aç±˜BïÙeh	×ƒ¹¬
Gh²‹à,ŠhvÑGu¿xvQ|ìÂ.º¹2jååjv‘fÁ]Äè7U@$@I´h©\hoÍŠ††svƒ©ÙÀNAÕÍ²•t8ï‰›JÔ”–R‘ 	dB@D\SÂuÑçí¢;w^{íµ_ıõùçŸ¿yóæ:˜«púôéáÃ‡/_¾<æû¤ÕLûÄ¤9‹Â.šT1pêõe˜T—^0ŠôU™Œ¾`‘"“‘ 	€SØEÚ£NÁàBUUUb‰jeeeYY™S`¬åËàB-qzâÿ6üuÿIã×ùN·>
¬Ae* /0ì"İ_ø¯uuÏ:lÁz6lØ/¼0xğ`HsæÌyî¹ç<d}oÄÀ)#Kóó‚­rsrs`ÁeD»ÈKm²’ 	ø•@ü¸*ºï¾ûî×éF‘Ñ&\¨ùå1vÀÅÆ—ØÈ•F‘_ï ¬	˜›‚u;K¥¶¶¶OŸ>0ŠPL·nİ„QôÈ#\ Ó¦M3oşFÔŒ3úöíkNöÒK/Å=Ñ¹:ˆhZ¤
­F\p4s& Ô´NİàB´ Ô*êdjjNwp·v].j-¾Ÿ|å¥NâgŞ$@ò	œ›æ|?Û¶m0×yÍš5ÕÕÕ8zôhqqñâÅ‹Å¯1ß/Z´É`>|8//oÃ†°”Ö®]‹³pôîİß¸‚RŸ©ÑŠóç\aÎBH€H 98ÖE“³Hüé1†x$$k«1‡D°ÒØBnPõÕ«WŸ¿åeDTïµçÕ†ÍÉÆ(™HÀQ"Z£E ó={nÚ´É\
,¥±cÇwŞyø®¤/¾øBüóıçŸgE=zô@‚½{÷ş¢¹sçÖ}®l!}ÿ">^ÍìI€H qÖ1¸u€ªR'¨ú[_}äK¨®«Ñ£¨°]ÑEmµ½'¹Ã¼õ†Î”$Ğ21„Ñ …W¬ßææú"¬5š={öM7İôì³Ï.\¸¢`â,Ÿ îB]]ùû/¼ğƒ>xå•W`A=öØcãÆ;sæŒ‘ çºwa¢X_”Ô_Xb¤EéfÜ^d$@$ @\»H{È1¸İ¨\Hµ êªQ:½}tÙ÷Ç”!ò“n*Ñ:²ÒÌ™†pß.‚4F<ºV­Z­X±k`ıò—¿ÄO°v^|ñE#ùû§zêŞ{ï5ÛEæ‘Õ²eËxà4ÙYl"â‘A»È".&# —	$²‹\(©2ÄCNzp!ƒª«Qª¬ßÿõÚ­{`M]¦m¤ˆ¯¸—bÒ&Î$Œ€»(™PŠşN»HQÅP, Ğ	$¶‹ôÍ(>úâÙ×?ptór,5Ïdª±8ø‡¹X5»{÷nŒŠI˜,~Ï=÷45tBãM¹SF–µÂŒˆ¼lFˆ«.]mê—°sÈÏU;ª,‹kjj”Š¨±Tİ¢î˜ŒR"@»È:.ÚEÖY1%	 	¸O Å¨n.”Š2dR3¨zyy¹‚Õ¡SUO¥a3-	 	 	 	d$Ñ®\ÈbC\HÑ ê
FT‡6Tİb“f2   È*Jì„Z·nİ*6@8 Ÿüä'æ0¬øéòË/Z‰ùşŠ+®h®-L¨›Qà˜4i’¿ÕÉ ê©êWÍ ê©Ö‚éI€H€H€H€ì% „]Ô¦M›¥K—N˜0›wéÒå–[n6löæ{744æMÌ÷“'OÁaNĞ¡C·6é³W)iä¦m3¯½¸F2xğ‰— æÂ^+É$âï$@$@$@$@ò	(aC·nİvíÚÏ¡C‡8ß<ùä“Âçƒh
0œÖ­[;'æ{œ…°ªb/?las"²ºæškŒåÃvD}Ymƒ@Í(¢Y””1XE"İ0ÒÑ¹±eRÁ˜€HÀ"DåY¼x±HŒ÷ˆ¾-Ş#èñ½Å¬b’566Ş~ûíY3 –$E$@¾% Š]ä[ÀnULØD.ØEØ6¤k×®ğãÁòŒ©¦A:´ù÷I1¤}bÒœcÀÂT:Ä ×q¹ ,U™¼M °qÿˆö{öÕ¾=ş|Ä¥t¢27Şxãë¯¿œqßÀ\ƒM›6á=LšwŞy§¤¤Ä‰íÊó¢Àÿ ÎáOÿë¹¹O~²î»²e>$@$@¶ ]dF2Ñ¦Ò9=‘½ì+¿dÉøñ>úè#øèT¨yJ2÷P“I¤mbÄƒHÀF«V­jhˆÔ×k/¼·1g#+,Iİ¶mÆ_8p×]waBŞÃ.
…B}ûö…IÌÁ6mNÁPÎŒ3ğ=>ï‡"ÆwŒdâ,÷ìÛ·Ï	™EUMpÆNÎÇœI€H€R"@»(%\Š&v-¨zmmmŸ>}Ä|ELb|î¹çğ&¦b02otGŒ^’aÒ‹¹_â\™AÕİª#Ë!?€!ôï|w•Õ«Wë[ß‚1w§şıûòÉ'ÕÕÕ°—0vƒEªbZö¸CJ±ÁxÿñÇ‹™Û‡Fno¼ñ²â#¶ÂKÃİ
ës>j=Ü+  …Ğ.RHŠâBPuŒÑ0À,'öämŞA‚˜ï-Z„d0„ĞÉËËÃô}ôiĞAKÈz÷îíæ„~©AÕ3T2O'ĞtïŞıí·ßşòË/+**0­®®®G{ÔØ±cÅ¢Sâà{¼éÕ«WAA 'ŞÃ¹„°=—),,\¾|9’‰;îN1·8{qÓ²—'s# {	Ğ.²—§Ïs3ÇIUé…|ñÅq¿ÿüóÏ1º=zô@š½{÷ş¢¹sçÖ××ûœ«GÙA †Jqq@¼ğŞ¡J>ÆÌ–-[`ä`ZœEx'vÌ^°‚â
°~ıúÒÒRá/‚…dÆ"%ñÆ¡@JJ‚Neeå9W¿Cå1[  TÈ´‹Ä
~1\è('®³î¹çTêÈ´¶àNS¶¡dF$àS‡óŠªtîT6ú(//w¨–;w>qâ&ÎÁ5„Ñø‹ÇGK{<Äˆ[™—Á¼ıû÷_yå•X›„˜z‡’ÙşO°pÕ×—ºáÿ™ùğ +¯v® æL$@$$vÑú5ïo|÷•íwï­YáDd!L Âtp1Ÿ[DÂã*jH9@>}ïuÀùê“å[6|(E—åNS.gq$àM°S´Ã9áaavîÃ?Œ"Ä{±|‡y|4oç`¼Ç­ì³Ï>;C`]§N>ÂFúÕ¯~%–P:v8Ç1É™1	 	øœ@»s6G¼°°Õöu¢çŸş}÷İ'babÂáù„÷F0h±LßPH(DÌÇ¶8³³L8š’®õ·QŸzØ¥splÌYå¬¸Ó”ÊÚ¡l$@$@$@$@é9NH|íµ×¾÷Ş{xƒU³?şñÅ—Fç[:xğ 9 Ìš5ëæ›oÆ`!¦•OŸ>]û9sÆ ùZÿôñ,     o!Êê±cÇ>øà,Ù‡çGà	„oÌ…şò—¿¼øâ‹bE/æ‚wéÒE¸•bb 4_ëïo]²v$@$@$@$@$@éHb1ÂYÈ‰ùâ˜>jÔ¨n¸A¬ Õˆ	S7DeÅÖ¢&L8uê~ş"äğ‡?üÁ%´uëÖ+®¸"=(Ïr'ì’Ea˜ŒH€H€H€H€H mIì¢+‡ıãÀë§TérYùç"!â*|>Ø¶Ü¨FL° æÕƒ›èî»ï¾ã;ŒXÏ>øàŸşô'D[…b“>,@J›‹•dPåDÀ¹¸tl¿ÁŒ,d…Ó 	€ãpÿŸ¡0l§&>ŠGƒãÅ³   o9Î„7„À	ğÁçƒX@1Á‚†²lÙ2áMBâç{oà&B "á,q„ƒ9‘9ÑìÙ³1äMı[–Ú˜Ùˆõ`ÂMÇƒH€Ô$°`Á‚7â¹ Œ"Œ£‰Ç&`ã'5e¦T$@$@Ò	È´‹¤WX' _œØqÎœ9o¾ù&Ì¤3fˆ ë<H€H@)óæÍÃÜæ"íŞ½›æ)%*…! P‡ í"ut‘©$ØljÓÊE#ÚïÙWû¶í›Maù_üâ0„0ò:iÒ$Ä\¼xq÷îİa¡Ÿ!&¨˜#ªãã-·Ü‚©Œx#\LF°uãc¤ØÛ·y4öL‰˜ÎGÜÂ«– Nöl6e#=fE^$ ¦Ì‰}Z1¡wì<qÿı÷{±.”™H€HÀ´‹\€ìRØO©¾>ÒĞÁ_±%”úˆuCH9?ş8¬£;v`^Ê®]»àGŠ‰¨ş·¿ımóæÍˆ¥ïKJJ0OÂˆ`ëHŒL}öY|“[°½/ö2û3Ú(¿=%ôlß‰ËFQ™	€-ˆ»–È
op«yè¡‡dKæÌ„H€HÀhùO§NÕHÌÑG¸‹gyÆ(£yDõÊÊJ±Tìª«®BÈ>¼éÑ£‡Ho[ïÓ§Ï;ï¼cø‹æÎ[__oNà@"F4ŠÀË,I@!"î‚X_d>Ä¾á<H€H€H .ïÙEí›9s&Õé2Ç{L¸tÌf¾%¨Ş’ˆ¢½ªÆ'üE8à}r´F‘sf‘£å0s ùxà!æ÷âyI¿â=<HÏ?ÿ¼|ù(	 	€’<fÁ(zôÑG•$)_(G÷Sú§ú'1AñĞQ^ „V‡kè¿şë¿„Û§¨¨!SÀ"Ÿ;ŠP¹X­dU‡)Æè²&à””Åf\Û‰¸l—™’ 	¤G@Ìšb0`ØÅø(–ñ   æ<f}úé§;w¦"ãÀfSFN®:Ò¹SÙhÛ7›BĞs±HÄC‡ "$:aíŞ $ÃòåËQ]DQ‡á„¥G"¥$ÛR8p ‰Å
"#¨:ÎEus\uÛU FÜ8…ƒnè[Î‘í€™!	 	 	 	x›€Çì"oÃv^zİ‚?øË#– á°M 	 	 	 	´D€vÛ†Ku¹TC$@$@$@$àS´‹|ªXV‹H€H€H€H€HÀ2ÙEˆ»0fÌ˜^xA¬İ·\M&$     	xÌ.BÜ#¬¢™Q±$@$@$ĞÄÀœ¯ˆJWSSCP$@$@$€@°ù—úN/ø…#gCáë·=ûÚûS+ûM©èG”1VÖ6,XºnâˆSF–æçõWNnâ ¢áT|zb“V±©"6o¹îşûï—Ø„¤+KbİY4	8G î]hdYIå nÎj1çw—¾\_İ¼‘úGŸæÆ}¹eá>Ù~`qõV‰‹Ü˜ŒH€²“ í¢Œô.½«­š]„ı»…<óÌ3xóÿğsæÌÁ^"xwûùŒè§x²te¥(/““€74»Õ=ûÚŠˆ>¢ıncÂ5f R?F¬¤Ë»hòuƒZççäå¸=”&½î€H€T&@»(#íHïj«f4›ÛEØö¡‡’¸©¢teeÔÔx2	¨JÀ|jGşúå¡5[v…ÂáP$	GÂotºû58¾ù-³]TĞoŒ$Q$ˆê˜¹Ì	ö/)Ô£S+Ì/ÈÓL#7§¸¯–H$@"@»(#eIïj+ka6ƒ®1­ïW¬XA»(£Ç“I@=â.Â‘Hc(Òœ	…Ï4†Ïâ}(ú½,©÷}¾¾ªªJL¯¬¬,ê=D–$(3¬s‚<}Æu«¼œV¹0Š´â{w¦^K¬>‹& õ	x,î‚ú@)!À5ôüóÏF¨Œ’’’N:‘	€_	À!õÆ`}ªæÑºûxÁ‚÷Xvéşë²>Wnë<±î²ïmïò½NWq_ Q"ª¯CĞhh(€G_ô$¨øµ=°^$@$à9³‹Pa…ÄÁàBj¶68ˆšÏ—ëBPM•Q*ÈŒ@4°øG3r`E-"Ø¹šiÀ„±¼xHÜ~Á@/÷‹n*FQ@‡µ48H7ˆ¢ìbŞf¦M$@$«óè.„E´×ßt«¤ÉâQÚÒƒ©6ËŠfÍš%èÀA´lÙ²Š"<ÄCú¤G‰ugÑ$àm–ZP{”hSéÂ‘P8€@¦Xh¤O¢Ó¾ÔçÙ‰¿É
pN oæü/K¶C$˜"ÿ>¡‡[e~£œ¨GHÿGø‹0w®)â$Í¤=È"¹3)pX(	 	(EÀŠ]¤Tp¡=Ñ'+ƒiıU·|=Ñ.²ŒŠ	I Â.‚É£[Aš]ÒşFBúâ"Ü¢ğ»‹HÔáŸ_İkş™ŸßÜ3…ZÙTØ>Â4ÊÍÕG¹Úä:±èHÿv‘İÌ™	 	¤J ‰]¤Zp¡[V›QÀ.bp!ÚEÖ[<í"ë¬˜’R"`Üˆà/Ö‘†As‰q,=òœ…4÷½ò…ğıbÊå)UÊÖÄQ_f™iF‘‹ûİÙZ#fF$@>$Ğ¢]¤lp¡U«V	=TTTtºâJ‰:Q!¸í"ë€v‘uVLI)0»Œ„ƒH·ˆ4GRSnä'Ç.úßü«°‹şó¶Ş)UÊÖÄšy(Buƒˆ”"~AóÑYd+jfF$@éHwAÍàB{M©ë<	hˆÁ…Ò×<Ï$ ›ˆå1Úş<ú¬01UL: MËËÍÑChÆ‰û/İ<Ó^îm*kŠ !|pÄB#E65@fC$@öˆk)\H[Ó"²§	0 È˜€n	ŸæŒéÑ¨›"°!›ŒNÎK{`è/Yˆrxt—¶¬H_xÄƒH€H@-ø‹šöšĞ†ı°6Tß{AŸ£¿ôéğÊÏ¸ÿBÜ#<Iğ×ı¢E‰Ñºç¡ú±[¹ ¤‡Ò£¯ò9§@ã¦$@nĞn{ú:"ıÑî‡ÑÍL…IÎË  K s¹"î‚n:êÆškÁM±,  DZœGgtïµ1?ôş…EsH7Šòó`é;v»şfşº_´(1Zw€h¦‚Á*F‘0Íú£¶¶v¾~p§©¬oE„I$eÊZP‹[IûÆ>A²õ!ö-Ò,"zŠdë‚å“ 	À7Ä‰» ß±ÅŸ ‚Á…f¿QÿÕñ³·Íì»%ò”©Jp¡¸qTØlêİ¥/‘KJ‚#ÇO“Ş¾Ù”¼æÊ’I {	|ÿÅÏDÜ…ÿ3£oöR`ÍI€H€,hÉ.:·…jÁ…y}û¡ãÚæ=9QÎ&}:UU‚5³‹TÙljDûİÑ¨ÎNShâˆ“¯Ô:_[wæ@ŠUœÍbávÁ$$à=´‹¼§3JL$@’Ä·‹toQÔ4Òí"Ñı;ôE·6—$pà'‹·<ŞxIÛ¼ÿ˜$u“¾¦íÉµ)ÑXz×ÚİíùÌv‘R›Mßü–Ù.’·Ó”ÖpEp\ÌÅú†ş%Eƒztj¥/“kÃhÉº–½[îÆİÇ_ıøàñ¿7z·
Ù#ù¡ãgÅÓ¬CÛ|¯×ºmë¼‰åÊº¶ózE(?	 	¨I E»H7¢½|}ª¸–ƒêÂD’x`óòƒÇÎ^Ò._îæå‚€ "&ÔëF‘aÈÅåEÂ.Rp³©}Ÿ¯¯ªª­¥²²²¨÷‰mE«°Ù”\,İF.­¯?tÊÆ™	X$Ğå¢Ö?ûÄ¹Åd2 ğ$$vNt“r•ÖÑÎüs°‹æİÒKäÂlÔ½Ñ(CîÉeØExÑÙPäLcñ¾1„ÕaÂÅ'\}nOüeG8ŒÍİŞØİí²Må‰µÍ"¶aõ˜Z,A=f®°p%ÊÈ¢=FàEÚ]ÎÆÂ‚<‰}ââ–xòLø¼V9­óí×§>˜Ã'pSàÙ7²"Ï>õ™QB H€%ÿO“H‰ãL½G¢ÙE
=ôåF2zÖB5º¿(€G¦n…Cš„š]tÎÁç¶úf¿µ‹û®D»H¬Ó´£×"=¸bt¾»¢0lİæ“Ú•ÊÔ*v{¨*éÄÿ²°Õù_Ç¬!	€l–ÆÏôĞ«Mq¨›¶è‰†¥vıct‹>×ËMX_›VÒ¡êfSºÓ¥í4ÅÍ¦$µHK$@$@$@Ş#`É.ò^µ²Lb57›Ò÷rÇ.¼ÒvšâfSYv°º$@$@$@$>ÚEé³SáL}[y¢Å~€u¤MÃ*ÌÓ×Ïèi‚ˆ½†­xİ	şº_ô7KÔ ÑtúÜ9}İ‘¶rN•!Ïİ§B3¢$@$@$@$õhù 	DûõZ-ğtNn°`ˆR^b]^RJ7ªA 
-07ìF@‰`zô@	A)|ĞìX   ğÚE×¦î2Òæ¬é¡¨u—‘iMÄĞ"°!Ø Ş¸ÿÒ‚>è/÷‹şf‰´ šX Gµ ±ry³)Ï75V€H€H€H€üK€v‘tM§õó1¡Nëôã¯nÅ´:)¯¨·( M £Ö€ hpô}¦4GgĞùá`H€H€H€H c–âtg\Júìüêô†ÇÌç¯ØrøÄßC­sÇô+4¾Ü­]·‹Û¤_Œ/Î”»Ù4UóMM-ıä …Ã9sSé%àrÉš’¹Ù”/Z+¡`Äd¶÷	°Õ¹Ïœ%’ 	dÕí¢“gB¾ºıÈ©ÆŠÁê‘S/o×&7Û”·¾²6›:v:tßŸ¾À¾I	´Ğş¼¼ŸßÒ³M¾\/¥´Í¦Ø>}C€=Tß¨RåŠÄrLPeeQ6 Pİ.å·6şãÚı	p»ámWùC®Ôe%¨Â÷¯.Õ÷œ—ÏÓ•¥ğYEÀJ@è¸ÎªVáte1ØtoÂÁ&	:­æO$m<`…Â‘‡o?pôL\İ`ÑÈœI=:^Ğ*Û4§`}¡#h
úŠ+tMA_
JN‘H 1¤=Tœwè\ùîPjÒW6qLĞWÊfeH€  wF“% èIO,?·@%æœ¡%íhYâè|"(êh©œIƒ/¥Qä¼X‚#0MwdŸ‹g}SYÙsD©;3•H ö–n›øîw‰ªaÑ$@¾$à»Ü¯éÙ¾¥°
ãvğ¥b<Z©–ÔõëqG+E±I ôPñ+®»"‰áDŒ$*ƒML&Ó“ 	@RŞ°‹P©C;6¯LÿÎC—TÇn&€: ”æ%ŞvUõ¹)Ë"	Ğš!@–›8&˜OE$@	xÆ.Bo»O§Ø7
6îæJ‰«;%§H$˜ İ¡l!îˆ;ØÄ1A÷ÁI€²€gì"(#ÆçĞ’k"Ô¦r›?°ãúúT®e#¸èeÃB ¹AÎ1A)Š`¡$@¾'à%»(f
Ê¶N³j‚Á ç:*«)
–*ºCS%Æô™ˆlâ˜`æH™	 	Ä%à%»0bš%ëOeË%€ÁØXCÈÃˆ	ø… İ¡~Ñ¤Çêa6È9&è1åQ\ ïÈıéOj]ÚH$şÖ4ÖsÈ0eÍºn\~ñ±ÏZÜ˜“ìÖ­[†f~zPÉ~¿\MIá±­Ç6išºğÈ ¢¦2oiÌAç·Ê]ßpTƒP™×s«bEãk1.»°ÕšíGOü=„1Áº¦ˆãM¾Ö6+G$ @ò}]¿:zr×#Ó ¿Äñÿ7ş¶¾>j›•”ÇM¹#'GšËË°‹
Û]Ô6ˆÈµ‘¨©–.#Õ4%írgÁv0všæ¦ÒvàôFrGšÀ¨ººzÕªUxI***†.œÜçôêS  _HdéO‚à[ëë~eµ"•¯¸pw}}T–ââ@Õ‘Ë0QKºl·.ûş˜² ¼$Z\‚uDMYlÒ5eQN&KL@z'uõêÕ¢“ŠƒT¿6W4q¤É¯m›õ"h‰@‹v‘ÖóĞ:ú‘·ÖÕ=½¨z@É¥ı‹/‘ÎqoÍŠ††svQQé(‰ş"ÈQ¿ÿëµ[÷ ·=}thi4š›iÔ”•f©‚¦¬ÈÉ4-P¶“Šš§Ş)ñFDw¨íWGš,"åH“EPLF$à	ì"TAsÁ.úù¢ê©•ı¦Tô“^«šššªª*1Z\YYYVV&W¤•µ–®»mTéícÊaEM#üëâ\C5•¤!¨ )¹mÕ»¥+ÙIİcLè¥ãÚ»M+®äi²¢P4Y¡Ä4$@#ß.üÅ¿+ÖmûùŸW+bo8”%Ğj½í[G•NUQôåËˆš²xÉI×”E9™,†€šÔ}µo›í":®ıÔn9ÒdE›i²B‰iH€<G %»H«H8	G4ÑüWUñ©ÆW<¦^_zëõ¥¹Á BäÁ:‘‚Üq‰ ÔTÒ†!]SI%d‚¸”í¤š×•——ËU;©vñçH“E’i²ŠÉH€¼E NĞıÁ€bz–î3â‘@8Aˆ*'‚•†Nó9ÎšJµaÊÒTªr2½ ĞÔÂõy¢'§&S ¡™M‡t£ÈàM+í¥Í¸qJ†Ês¿ë¿›!çïá)ÑÁ	q¤t–£‰A©1Öâ"Õ› ğ,wØ ¸Ë)öhP‘4	â}.¸ı` ¦¬¶
Ùš²*'Ó5P·“ª ØIÍP)iJ GšR%Æô$@ŠˆkéÃŒúctÜQñJÈ¬¢F‘néè´çÎË%MS;wîìÚµë´iÓŒ:¾ôÒK:tØ°aCL­OŸ>=tèĞC‡9O#y	ò4•\6¦ˆ!ÀNjªM‚ÔT‰µ#MVAr¤É*)¦#ğDùèT:ÔD¢˜Ú¤}dĞ\>¤hªwïŞŸ|ò‰0xßyç¸áÛ´i³nİ:˜L.3‰[œtM© Ák2°“jUcì¤Z%Õb:i#MK.'4ÉáÎRI€#x¦²Ö#áDº¤ğ…{¨É$rÁMÔ\"	š:ÿüóï»ï>±ú|ıúõğuêÔ	ï…+éı€C	&ÓŒ3„ùôÈ#ß#¾ïÛ·¯Ùé”u†	ĞT†5ÈªÓ¥uRéÍªvÖ¼²RFš¼Èœ#M^Ôe&H@ E»èÜ<RúùSšÖ¯	”«»iïŒ‚İ¦víµ×¾÷Ş{(õí·ßşñ,ŠïÖ­Û®]»=zøğa8‹<(¾_³fMuuõğSqqñ¢E‹Ö®]»zõê…º(·LM¹XM_%¥“Jw¨¯ÚPÊ•‘0Ò”²Œ
œÀ‘&”@H€ì$$²ØQÑÎ}šŒ}U‘„It‚¨M}ë[ß:vìØ|ğÅ_Àó#$ƒhòäÉğ._¾ÜPø¶mÛÆ{Şyçá›>}ú|şùç½zõ*((p¹EH×”ËõõEq:©t‡ú¢å¤S	‰#Méˆ+ù4IV ‹'°—€B?í­ss@^^Ş¨Q£n¸á†şıûƒæÔ•––
!CŒ={nÚ´I|ÜºuëW\á‚„,Âë$vRéõzãÉD~)#M™,ë\4É"ÏrI€œ à†]äÄdıyĞÄ›İ»w«Í	ÊÍsøğá]ºt¹ë®»1}±éà/***Ú¿¿ñı°aÃ0}N¬/jhh€OI®ä,İC¤tRéõP¡¨$@$@$97ì"HéÄdı–òT* ZæR3,"Z¶l|DxóÙgŸ!Ü|GøÃşøş"ÄZÀ<ºK.¹Ä¨Â“O>‰ïq`M‘‘ƒš¤T$@w(Û@&\L *$¹ç{2©Ï% ,!à’]äÄdı–òL°ağcˆ8iRâ¡eI«2ª	]8‰ÓmüYß	Ğš!À,?İÍÁ,GÍê“ 	€-\²‹ «“õãæÙB€&üx\aŒŒxh¶hÍ3™ß‘»ç<‡‚*K€îPeUã-ÁÜŒÙ ¡ùÀŸˆˆóÔSO¡yËo!¥´$@$à(÷ì"'&ëÇÍ³%^{÷î5üEsçÎİ±c‡”xhª“™“ 	¸F€îP×P{· ×›o3ğ7kÖ¬›o¾ùá‡Ù2añâÅŞÅKÉI€HÀ^îÙENLÖ›g@ãÆş"\÷ooKbn$mèÍ6§Q_×›o`øûË_şòâ‹/VTT 
1[&ÔÕÕ¥Q/B$@¾$à]|NLÖogKz2ÇCÃrÌ£ó¥F¨”ˆ›Ë‰çúí·ß¾aÃ'ªÀ<I€HÀ}®¶´A‚¨ò7Ş¸dÉ’	&œ:u*fË˜Oîca‰$@$ &7ì"'&ë'Îsİºu°|D`:D‘¡ #B¥Mš4IDTSS1ªIåÄbÕêHyH€HÀvî¶´A‚QŒŞ}÷İwÜqGÌ–	xÚ^efH$@%Ä.Z¿æıï¾2¢ıî½5+jjj­¤ç&ëÈ§ï½8_}²|Ë†…“4s§5eq±ĞXõkDÿëÚµkKÁ Å"`ìw´oß¾¤5M#RšJC~B$à9îš7H2dˆ1ğI{î9 œ>}ºˆ‚cŞ2Ás`)0	 	8G ‰]TUUÕĞ¯U«Vé»+:uxn²>€˜á8ÅÅZ¾.hÊÊb8ây«««èâğáÃ˜I‚ïwíÚ…e]øE<xĞXŒEÀØæ?a^óéÖêm)•Rš²$1¹N &œWKáş‘lüøñ˜Œäº€,ĞU¯ı`ÓÊE#ÚïqzLĞs‚PCmmíÆUK G…1AW›#ğ;7æÑùa¶Ô/¥Ä€ÒW?`õèÑ#Áš`,0` Ò#¥xÃƒbÀ*:©ûjßvÎq™Hû{h{hvR¸^0˜R_ihÀ+€Q'çÆ=7 Ú®ÁqB³Ì“H€ ]Äæa•@Jˆc2ıè£JKK…¿hìØ±æ_EÀ°6mÚdU¦Ë&F?]U¼w¡ê-ÍEÑ'OÄr;1ATHbŞÆ¼oLÌlR‡Äf'Õ°ç&G8g9#¹¹Y	€Iì¢#FÄ!>ƒÁ U-@ÌpäŠé¦¬/ ¡1xğ`±yíß¿ßüë•W^
…ğSqq1;Q)M9QAæi8^:vìˆ¦³£‹yF(¢~aÚ'B{‰	¢Ÿ³Ì¢E‹ÌûÆ˜Ïu,Ö";©¶èÿ™89gÜ~i]Î‘p\ÎâH€\#Ä.ºrØ?¼~JÕ‘.—•)//wM¬æÍœ9sĞ Aæïñz0EA•çâÒ±ı_-Qí¨¦¬/ 6¢ÿ§@¶Ù³g_sÍ5-­	Fç]I¸’`/ıêW¿‚e;I¥4e{í˜¡]Œyt1ºÌ3BQVÌÇ˜İ`>ÿüsó¾11‰íÕœ;©NPÅ`JIIPŒ|UVVrLĞ™pœhrÌ“H@Ş˜Gèê«¿ax`@ñÍJJJT€HH€% ²Ç/f7˜+®¸ÂQÍ3g'Õ	àiêİ-UG:w*ƒÙ‰"RÊÃ‚"ç3Ï<“Ò‰N$ÆHÓ€7Ná ú–;âäwBlæI$@I	xÃ.š7o^ÌîO<qÿı÷'­ 	ø€ :©FNTç×Æ<:„^Ä""‹Übvƒ™<y²ÅíJÆNª]$còÑ}Dø£ÄìñO?ıNu³fÍr¨¾)e«œ”$gb H@ÀvQLà>ÂÎÔ+	@öpº†™Ÿ"”<,
*,,ûAÇÌ5ï	¢bÚ§y7sú˜s˜#*€Óp²§™)^S¬mã,	ÅuDñH€<MÀ“vÑ/¼0pà@Ì(¨¯¯—»ÄÈÓº§ğ$@$@ €©ãxØáÁÇ1AOè‹B’ 	x”€'í"1¦‹#gøëQô›H€H€¬€£R<õ°­0B Z9…iH€H€R%à»H„Ş¡˜º©V˜é% 4…ÃxrO˜0!æG`æ$@$àcİ»w÷qíX5 KÀvâ.>"s ,E•‹¥›	`î;>BS+V¬˜3gŞ#t’ğéápho"ª€H€|O@Œ.áÀ•÷Rß«›$EÀv‘,:,7%Ø˜¬ù”ßÿş÷÷Ş{oJ™01	¨I f¿Ñ75OdB e8EÕ”™Rù†€12sõMY P í"´à7^}õÕ‡zHÔJDÈÀ!¼I<HÀ£`ö‹¾©áEE0qôÑGõh(6	 	 	€™ í"¶›	`î¶Ü5fzˆ®ä‹/¾¸`Á›Kbv$ ƒÀ={D¬dá52dˆ)X&	 	 	€ÍhÙ4Ë³Ãğ9[îb‰°è;îŞ½ÆR–Ãaõ½N@„Á¦Òb.ÑqR“×uJùI€H€HÀ @»ˆÁ60°µ¶c7&Îa6İ˜1cğcÉ¶ò˜	¸K@€Á2"ââÊ•+Å–2xÃ%Fîª‚¥‘ 	 	€ıhÙÏ4ksÄÜ9cq0Ş`=†ñ#fm«ğ_ÅÑ°Q)£moÜ¸qäÈ‘K–,ñ_MY#  È*´‹²Jİ¬,	@šà 2âÑa½\š¹ğ4   U	Ğ.RU3”‹H@%fw¨y5¸è,RIQ”…H€H€Ò$@»(Mp<H€H€H€H€HÀ7hùF•¬	 	 	 	 	@šh¥	§‘ 	 	 	 	 	ø†€Çì¢šš„ÊŞûFş«5å?²F$@$@$@$àcÁH$S=ıü	†Â‘³¡ğŠõÛ}íı‘e%•ƒºIñîÒ—ëë£#Xîõ7İ%JõÉö‹«·N1pÊÈÒüÜ şÊÉÍLÒqÑ¨)ëª—«)ër2¥A nóZÙoJE?RŠ!°²¶aÁÒu²nD¾Q‡ÊM®¶¶vÕªUú³9RQQQ^^.;›œ\ş,HÀ!Vì¢ºg_ûÀ¡âSÍvDû=çì¢ª#a~¤š‰íéÑ™|İ Öù9y9rí"j*‰neiÊö&—²“j]Ëì¤Zg• ¥WFšJJ‚#ÇOs|à-!S4ÙÒä˜		€j’ØEáÈ_¿<´fË®P8Š"áHX°Òÿ“aœØ²Âì/*è7FÒ³!DõƒLCæû—êÑ©œEyši$Å_DMµpi)¡)Õ.{OÈÃNªu5±“jU*v‘R#M»¢²c®D–	Ú¢nfB$@Í	´h…#p$ÒŠ4†gBá3á³x‚e¤}/å¾Ï×‹¹80— ÓWÊ’åbº\N0§OŸk•—Ó*F‘öQ|ïÚ<:j*i®©¤2AsÍì"vR“4ºC3¼ÌMNµ‘¦ã›ß2ÛEY>&˜¡¢y:	 	´D ‘]„‡0‡¢FQvQ½pXEøIÿ7K¸Š°„¶n‰ésši„¿xŸ\¶‹ÔÔÔ/Şıòë“Ÿwßõß’ÕPÑ”¬ê{º\vR-¨îP,'MNÙ‘¦ªª*±¸²²²¨÷ËÕ²?!GšìgÊI€Ô ×.Òî¼ú³!€Ğºi†§>jvÑ¹Xò×öÈÀ¨ñAÍa ÁşÁ¬9ÍÒ#.ˆItøR·‹¼ ô ¬¦æ½½ëN6^t~ŞÌÑ]e¨Iëâ(¢)IÕ÷v±ì¤ZÔ;©A%Mf495GšøËp8“xôÆîIëâP49–Ù’ 	(B »(¨}¯u¸Ã°…š]¤9‹ğnE;œYê2ÒEša$üEè”À(jŠ¸€‡–fi>£HÄéµOš]¤°¦æ¼µóğ‰ÆÂ‚¼‡¾-'’¡:šRäj÷–ŠwRñÎ®¨;t”,³_»	©à¸öV»J ­â#M³ßˆÚE}W–]Ä‘&ß4vV„H >í"=º¤ÙE!ío$¤/.â$:ÒÜ#ÉÍÕÜD¹Aü‹ô¹[v‘²šú·7o,l›÷¯ß)–xı© )‰Õ÷nÑŠwRéõnÓjIrÅGšşeÉv<ñ”ù÷	=¤ÀçH“ì,”HÀMqì"ÍÔ´…üEÂ:“µğQ,*Ò»,Ù9‰Nh'êÒ\FMç„E„îl^•CaMÍ~£ş«ãg/n›ÿØwKÜlÓß,KMÉ#àÕ’ï¤ÒêÕ†Õ²Ü¢É);ÒôÏ¯nóè~~sO‰ğ9Ò$>‹&pš@KvÑ¹Çƒpé‘öĞh
ÒÁ²Ú.Òë/şÓ–>kæPtfKÎ¢&»H]M=òúöCÇ;´Í{r¢œÑMaÁ*¢)§¯dÿå¯x'•îPÿ59ÅÇï{åá/úÅ”ËåÁçH“<ö,™HÀyñí"ıñípëv‘p ‰ItÑ5-ÎË¦t	Æ
"="w4ƒxïÂ:3e5õ“ÅÛo¼¤mŞL’:ºÙ´ÖKº¦”nĞJ
§²ãšîP%›L¦B™­qÕÆÿ÷ÿ*ì¢ÿ¼­w¦õLÿ|4¥Ïg’ 	¨O E»(:r¦÷òõ¹sZJçbÑ©_9ç%@ôø
ğiè`;jŸÜ=¢³Óf}<vö’vùrg}U(¢)wÛ…çKS¹“Jw¨Wš×ÆİÇ_ıøàñ¿7ZXŒ	6Ú”qŒ	êBı/mƒŠC'…
ò¬ÖÅ‰t‚vKÕ'K˜‹ø&:'
7çÙ¶uŞÄòe]Û9]ó'ÈIìœè:"ñHĞ»—ÙƒÆrM…Ù¨¯*jZwdù\Û*¨©™®vÑ¼[zÙVÏŒ2RBSÕ ûN¦;4±ÎÕq\+Û6]Z_èTjâE×Ï{êqL0 	H%‹»\Ôúgß“8O;µfÅÔ$@ê°äÿiòÑ(jI¡úÔ÷ıDÍÄQJS35ÙE“±‹4ÃUM©kPGBºC“ê‚îĞˆĞoDŠ=’’<—@4;í¡§Ê˜ 6X?y&|^«œÖy9)TÄÁ¤&‹Èõ™Øar1î6_¡ç‹ƒ¬™5	€;,ÙEîˆÂR|F@tGøÜò™Z¥T‡îPØé)“‘R#MÚ€ûI¤4e¢V÷1±D ¯PdØÉ+¸('	€ğ‡è‹øT¹×h«ò›|	4/R÷çkË•ğ]+$c!ô†§Çå+>qeò  Ÿ ]äE²$à{JuRõ”bƒgu^ì¤úş"`I€H€$@»ÈA¸ÌšH€H€H€H€HÀhyBM’H€H€H€H€HÀA´‹„Ë¬I€H€H€H€H€<A€v‘'ÔD!I€H€H€H€H€$@»ÈA¸ÌšH€H€H€H€HÀ¸‘'ÔäI!¹¿„'ÕF¡­`ó¶ÆIBª_Ş°ó˜QğŠ-‡Oü=TĞ:wL¿BãËÁİÚu»¸áXdº¬¨yS³éæy$@ÚElN`ÇÑ)²ÌW+İ2öÉdh&¶Ìc§C÷şé‹³!±ÛUœ#?7¸`êåíÚäª -e°H ©Z‘OûóòæŞÒ³M>'ÂX„Êd$@±xû`›  ä
òÿòé¡×kŠ\8oğ+Ò$Ïˆ)& ƒgdŸ‹‚_i9¬û³OªVySYEö£g$Mhe“¶YW t	$í–±·.ZûÏÕ·07ÛîÆ9ğ=~µ¿Hæè<jEá/huİ‰ìaçd	$@'@»Èó*dH€Ü!ÀŞ¶;œ3/]ä¡%íâæƒïñkæE0÷	$P+„™4øÒ–Œa÷Ee‰$@%@»È£Š£Ø$@n`oÛmâ”7n`‡¸g·ô}EñT÷´¤>DÑÖã÷ä`I$@>%@»È§ŠeµH€ ÀŞ¶PÉåşb²Æ7Cçn·2«V~ÛUİå 	ø™ í"?k—u#°— {Ûöòt4·æF,Ew'óæJ„¹Û§S¬ì0,…HÀghùL¡¬	€³ØÛv–¯}¹Çx‡Zr5ØW srƒ@s§ßÔ¡t¹Ae@6 ]”ZfI€l#ÀŞ¶m(ÏÈlÄÒYä<o—J0«òší97Ò%î,†²€ í¢,P2«H$`+ö¶mÅé`fFô¹Ä¡Ì”€Y;@ÀP+ĞM,¿Ä˜%	@–ÈıéOš¥Ugµ&°bËá“gÂ­s¿İÿb‡‹bö$à*Ë.lµfûQlêŠŞö?]S”Œ¿U«2)YX$‘+Wuõê}ÿåâcŸµ>´)''Ø­[7¹ò ô /Z‹\Íj½èè–¶mòTP«o4+ı¡ $ —@PîİMnåYº£XTwğØÙKÚåÏŸÜËÑ‚˜y¶~×ª®®^µj°C’ŠŠŠáÃ‡KW:½í¯ÜuàHÀd*J´ßXøÛúú¨mV\¸qê99ÒfI6bQa»¢‹Ú¢ù¨£5+XÍ*¥Ví>Ğ„Ï£šµ¢}¦!,!@»(K-¡š´‹$@÷o‘êôÉÀØÜ-+)	›r{ÛÂJ„;ä­õuO¿²Z‘–Xqá³]Tuä²@@š]d0¹}tÙ÷Ç”Ás¤w¨=`©¦Y5Õ
]zN³Š\§ƒÔ!@»H]x^’_Ş°ó˜QÌ£ÃD#Ì£Ó¯Ğ\·ÁİÚq™¬ç•íbTë“¡êî®¯"€‚½í¨Q¤uô#o­«{zQõ€’KûË_ø±¯öm³]TT:J¢Jõû¿^»uzÏÓG—–æIÓ¡©ì8Ò.@Å4«šZ=ªYïâ,Š<C€v‘gT¥¾ ÇN‡îıÓgC‰V´?/oî-=ÛäË²UŸ'%T¶·½·fECÃ9»ˆ½m]SÑ?°‹~¾¨zje¿)ı¤·ášš1ãQ³f+*ÊËËåŠ´²¶aÁÒu·*½}L9Œ¢¨i¤öš#5«šZÑ¨¼¨Y¹×K'5	Ğ.RS/^•êk÷¿µùpé¿uÑ¨¾ßpyµª”Û
öÉPotËªªªÄ2§ÊÊÊ²²2W`´Xˆô>™p)à/ş]±nÛÏÿ¼Z»H®^š—.4uë¨Òé£Êsà/Š¾ÔuQ³›ç4k±^LFÙF€ÃöÙ¦qgë›S[*Á»®»â"g%`î>" ÷É´%š‘¸z?–)Ü÷İwßıú!İ(2„¤pXc¥½ğ­ÖÙv-œ¦'”BîêÕ¶Jáp(Á½mëÚRô fSPŒ§4›B½˜”²‡ í¢ìÑµ5M¼IÈ¤Á—&°šÜexŒ€º}2,S‡:DeõÉšÌW1‘N÷ñHH èFQ”•fÆºjÄZU5k•TS:¯h6Õz1=	d…êÙİß5miSyÄZÖã×µ³‘ ûd©Â”İ'
ÏÍ¢¤Šƒ+^Q_‘ºÎ"Qj6©J£	¼¦Y«õb:È´‹²G×.ÕöOÿÎÍ»íª.IÀb|E€}2«ê”×'Óúì½è>«"§ŸnçÎ]»v½à‚ŠŠŠ:”vF§OŸ:th&9¤Q4XE"İ0ÒÑi!ÎÓÈÊáSÜÖ¬§Õ
]xG³7fO%@»È³ªSXğæ.#XJ}:Å1–®E“NÀí>*ìén™ô>™XÖäÂ,:37İtÓ’%K=úÑGÍ=;qcmllœ1cF\ã§M›6ëÖ­ëĞ¡ƒ›Í][ˆ¥Ï£Óq¹ ,ÓÊ¹£Y¯«U·‹<¦ÙL[Ï'ß ]ä;•*P!XA1;MJg‘Šñ¦îôÉÀÆëİ2údšsÏ…‰tµµµ}úô<x0JëÖ­ÛsÏ=g´ğ M›6aõíÛ¯½öÚşç^¼xq÷îİŸzê©˜”Â_ôñÇéqºÓŠp5™D
º‰špC³^W«P©×4ëtcgş$à1´‹<¦0¯ˆkv]Ó³=7rõŠâ””Ó>*îõn™Ü>Ù¹IïçoÛ¶mÀ€æ¶
ëh×®]p>|. ƒ®]»võêÕøvÑUW]5iÒ¤;v<üğÃ1)'RuuõK/½„Óóòò6lØàğ… ïÑJåM]ÁÁ5Íz_­-iÖáFÎìIÀ“hyRmê=´¤bÓAN ›X.Û{õ‰QÂ¸\ë“¡tïwËä÷Éô`tF={öÜ´i“¹Á`¦ÜäÉ“á*,,\¾|9~êÕ«WA6w¥ºº:#qó”â'8—pÀ(êÑ£‡#¶¾ªÈ“è4ëµ
3Ò[šu¡µ³ğÚERVj¢Š€¹²Ş¯nÿùÂË÷.îşåŸ?¯]#KŒ˜rS#ÈÔÊp¡O†ºú [–%}2ìµuëVáÕÁD¸Ÿüä'ë×¯/--ş¢±cÇš[.RÂF‚9„tø>AJeÚ{–
Bµf©âYmP‰ í"•´‘±,_=Y[·¯v›öúdû~¼>•ôZµjU}}¯††@UUUmİ^Y’ˆr`Ùwø8ó2nhşÌ€İ2¯è3å–.]:aÂ8ˆºtérË-·@w˜'ÂÓíß¿Á¬È;â›†††)S¦ Yee%Ö5Oé•Zû^NªÕ÷*fI@}ú¼Ş' ÔßZ_÷ô+«U¨MÅ…»ëë£‚ª\(a„ß>ºìûcÊ0×A„ÎR|f¿
ª”%ƒX¿ŒEØól(¼bı¶g_{je¿)ıœ	.,Gùúë¯[µjµbÅŠ~ıú•——ïŞ½±:ÿñÇŸ8q"~… ãÆ[¸pá#<òË_ş«VxàsÊßüæ7Hù«_ıê‰'xå•WÎ;ï¼Ç{§ˆP¶+k,]7qÄÀ)#Kósƒú+SXõVîx—¢©Ä¡Ç{ï½W·v&ÊÕTª’«¦YeÕ
°ŞÒlª-éI {Ğ.òƒ®õ…ZPã·ÖÕ=½¨z@É¥ı‹%/éÙ[³"qÀ.**•“#Ù.ªßÿõÚ­{`M]ZÚšãİF?41	uP­OÊvËäöÉ¨)ë—‡\MY—S¤TM³Ê^€´‹RmZLOÊ ]¤¬jR¬éé€]ôóEÕN©[‘¬¦¦Óç„7ÓW0wÅÊY¦=’ÛF•Ş>¦FQÔ4r~4İÑJù8sÕúd´‹Zjl
jJÙë‚v‘²ªÉP0oi6ÃÊòtğ1ÉCø>&ëZÕDTPmÛtíÇ#AY¬æİwß}÷ë‡
F‘!6 …Ã+í…oõ½C-VŠÉ²œ B</[¶Lµ©YY®VŸH€H€ì"@»È.’óÑ¬"mKÇH ¤RçÄ!Mó¢A©1Æ’¼Ñ-Iİ6âA$@$@$@$İÔê³f·.Ò©}“³H,Q×trÉ¦sÂáˆnEYiN#ºŒ²©°®$@$@$@$— í"4Œ ğ|Ğ,JªN¸‰Ä+ê+¢³()2& %	`ç"	<tèPKÒaÏ¢Ûo¿]ls”ø°2YNüİˆô¸xñb‘Ş#ÀºxhìÆ÷ö”Ä\H€HÀD€v‘×›ƒîìĞ×ÊDÌ8\!DêÚµ«Ø'$A$©Iû4IsH/XE"İ0ÒÑi±ŒÓËgù’@L/m~üøñØ04q/Ü—(X)BàÆo|ıõ×Q4Ø«jÓ¦MxówŞ)))‘"%È´‹|¢eDÀéYtxDİtÓMK–,Á¾ò}ôÑìÙ³ãÃclÆŒqÍ'lá·nİº:¸¬ m!–>NÇå40—+Çâì!——7jÔ¨·ß~[d·zõê«®ºª°°PJ‹µ§J.æRØ¸DûİˆÔ?oŞ<Ä¥t¡d®¸ÏôíÛã5Ó¦MC‰ğ0ˆ±›}ûöá£1š#éñ>&¥ÓÒ^98_}²ü¹¹O~²î§‹³1ÿõkŞßøî+B³.¨Ñz¶mÛ†gÇîºë.</ğ”P(d¸Œ Ç{î¹ÇP·¡ıæíÁFq³Oß{]hvË†.ù“ 	8G€v‘sl]ÎY›JçôD:l!ß§O±7%bs=÷Üs-u8ğˆÂş˜ÿüÏÿŒ9İ»wÇ,ˆ˜”Â_ôñÇÇthœ¦&ÜCM&İDNó¶'ôÉ6­\4¢ı}µo»Ğ'ƒĞÃ‡_»ví©S§ÄõèÑ£+ü¥1=l£OÖ¼—f‚–sÁU¹qÕÀQ¤O¶jÕ*ì]&^xïtõEşÕÕÕè.Ã§›vÁ‚»Á†¼bP7«]»vá$@ûàÁƒP.ÌİıèG1)–»˜áxhE¨Ëj…š¾óïà©5}ë[ß‚‰ĞÔû÷ï?yòdáJúõ¯M Ö¬YíÃ|‚~‹‹‹Å,;s{°2‘2C½{W­Vœ§“€ÿĞ.òƒNÏíLêp?x0#k©ÃGì"Œ²Oš4iÇ?üpLJÃ‰äòSæD°
qpSWO\ èÕ×G"øëNWÍ±æ?ûì³={ö9r¾
¯˜vLÛKs²ncÓ0GKT0s(Œ¢=z|şùçâ6…âŒ[t¦a»Âé·|ùr|Ó«W¯‚‚ã†f¤T°jY+Ôà³ıòË/+**0­®®®1B!\I0zß}÷]ü„÷cÇÑó1l‡dxcnY'Hƒ í¢4 )zŠ>ôè¬aÔ³gO1ÏÛ8Zêp˜Q"qó”â{÷`°…ôUEœD§hKVD,ôÀĞ“èŒ=‹Î=ÓÃiÀq{i×è\Kf«ê+®¸ÂX"Ş¬_¿¾´´Tø‹Ğ‡6ÔaÜĞpwŠ¹³9¬2fŸœ |¶0r¶lÙ¶œEx¸’àè{úé§¡>ÌÄ6?•¶nİ
‹7yÖLA$@- ]Ä¦‘<œğàÓ0­è'?ùIK$(t80"A×$…â™”\$ ºb˜±É(6AƒiÜï¥©fàc¿¸5í…÷.j,ZÔ?üÃ?`
¼Cpî6ßB•˜e'Víß¿ßéÊ+¯ŒIé´´#FŒ0Ãñ¿Ú}µvîÜùÄ‰˜8‡Q	8ôÀ
Å’T˜LğûıøÇ?Æ{¨ŠS[1+3œVbóü½«V÷Y±DPœ í"Å¤–x¨Ch 	&à	Ô¥K—[n¹¥y‡]É;ŠGÔ”)SSÀ±¾¨¥®‰Z5¤4Jp¿Ohí0r0áÓ˜D‡/1¹.nÛÀæ~/pJJ‚¢·kMzWûp^QÕ‘.—•™9s&p9× ŒØ-ğ!,[¶LøôvÑ¢E‹à‚	ô«_ı
ë!‘S"ñ´‰şô!CDzô³cR:'­Èù‚…€sqéØ{~üHéĞkœ.ÎÆü¯ö¯Ÿ"4ë¨Z™…v0ßˆ÷.4~~ZññÉ'Ÿ„rqˆ1íA,ˆuô A•…fû¾ÚÑ²˜9	€£ôµ<<K@ÄÀrìUz6^±~Û³¯½?µ²ß”Š~Rê×Ğ½÷ŞûÊ+¯ó¤ˆ·Ğ•µ–®›8bà”‘¥ù¹Aı•“›D¤s®3RGM†$1mû­uu¿|ı}4ì©•ı”V®HïÖÔ?»lİ„á§^_æ~ÛVí.$W‰K÷Ö]HYÍblë‹„É¤Èá-Í*b€‚è/RP)‰H –€îÁgWĞy”;áxTq;=Ó§OWÊ(J¯<‹H@A´‹TŠ‡E2O`ğp5(:	 	 	 	@– ]”e
guI€H€H€H€H€š ]ÄFA$@$@$@$@$íhe{H©şˆÍ=tèPcKÖæç"îÂøñãO:•R¶LL$@öX¼x±ˆŠ‰lñWÄqÆñÌ3ÏØ[ss“À Aƒ„B…r©V7µÀ²HÀÇhùX¹¬	€ıÖ¬Yct²ñıoûË`™€R>üğÃ‘#GÙ”””ˆPÎ÷ßfyóli ÖG}J|üñÇC#q/¾ø¢4™X0	€¿Ğ.ò>×¯yÓÊE#ÚïÙWûvMM£ƒ_hÆŒØ>ıBìb4yòd¼¹öÚk±ßÉ“'{÷î->
Ç‘ØïÇ´iÓÌ'â#P"ìÖ'¶‹uèÀ®JW-œ¯>Y¾eÃ‡•Âl³ v(=lèmc3œl¨µ·êˆÍ=çÍ›ç-™)mRPkÌ¶­°`)%=‘	H€HÀ"ÚEAy ÙªU«êë#üÅ{§%^»víêÕ«ÿö·¿mŞ¼ùæ›o>|ø0úˆØ<qÏ=°ÊĞe„]ôæ›oÂBJÑ‰„½´~ıúêêjXJH­ú~ó›ß âªØoÑÑİ÷8˜VSUUÅm»œnÙ?F¯á‘(Ævª<”'P__/FgèßS^WÉüıï¿fĞíÚµ+ÆRJ~2S 	@Ëh±u¤I ²²NØ6W]uUEEŞôèÑyõêÕ«   oúôéSWW·wï^Ã_4wîÜ;vˆ}ÊEúk®¹¦K—.Â•”¦VO;·1"«Ì˜.!—_~#„¤>Ø®bhfãÆO<ñ„úSÂ&L˜ğüóÏ#ÁÒ¥K_xá<>0yaÖ¬Y\bÄfC$9ÚE™3dñ	lİº6~7nœ1ï3îbRÑ7ÜğÔSO9‡Rß¸	ØF «ŒæÔÙ–#3rÀ¾}ûœ/„%8H qzè!qİÁe$,X_„G\9æ wfMYC€v‘T§fôˆŞËª˜±¾“0Ã0ÖŠ,ğ/aY°ßıîwâ§|ğ®»îrNf ))	
8ğtƒAçÊbÎÙ@`Îœ9·Şzk6ÔÔ‹uÁèV®\9pàÀ™3gŠ8ÆŒ³lÙ2/Öˆ2ƒ <B˜	%B•0È„H€l'äœ"Û™º™¡îÁŸ`(9
¿µ®î—¯¿?¥¢ßÔÊşnŠá‰²Ş­©vÙº	ÃN½¾,?7¨¿rrs`!"%åtÓ¶W¬ßöìkïO­ì‡æ-]V8‹ş×ÿú_Ÿ~ú©tI„ +k,]7qÄÀ)#KİoÛ*kJbÈÕTª4¨YëÄ¼¥YëõbJÈ6ôùJãzïè‰£VÂñU[—ZxAÕ1Š¤’`á$@$@$à´‹ü£KÖ„H€H€H€H€H =´‹ÒãÆ³H€H€H€H€H€üC€v‘tÉš 	 	 	 	 	¤G€vQzÜx	 	€êjkkçëÇ¼yó°ß´êâR>k¨Vkœ˜ŠH eŒG—22¥NP0^Âs#6.6”Û# ª f|# ãÉ"Ÿ^¹
¶íô*âÂYrÛv\M,+©ÔÍ…º'.âİ¥/××G7/C¤ş‘ã§ÉKóÉö‹«·ÊŠ˜ª:”Õ¬jjXoi6Õ–Àô$=hy[×ªõa?ş?øA—.]„]$ñ½Ü^rûŞng2¤W­m›Àó°jÕ*ñ¶Æ*//—Aè\™rÛv3MÕ=ûÚr¥h¿»¡!ú	{—UéŒˆÒeƒ]4ùºA­ósòr”Ş-@YÍª©V´+¯hVú%@H@Y´‹”U%ÁÔì;b÷½»û½`Ì%K–Xª•3‰äö©“ŸsUv¬ĞÍÃÕèm_Ó­Ùì…0kª1ùë—‡ÖlÙ
‡C‘@$	ƒŞè»„¹ß^o~Ëlô#IS‘ ª`æz0'Ø¿¤hPN­°…Zf)»‹š²šUF­Zãö¢fİ¿Y"	x… í"¯h*¾œêÛE°‘fÍšé=*—5í"¹üS-]Ù±jTdDû=ÑÙYôBM…#p$ÒŠ4†gBá3á³xŠ~ŸªöíJ¿ïóõUUUbûòÊÊÊ¢ŞCìÊ9|°‰tN0§o*İ*/§U.Œ"í£ø^Áİ¥•Õ¬Rj…æ<§Ù4Z/O!,!@»ÈÛŠVß.2øb¡ÑÆ‹Ñ‹”tĞ.’>Íb•«F}NlYa¬ZA‹Îr/„Ñ{Æø‹`E¢0ì¢0ì%%øIÿWÂ!Œ"¹f\
Øm¶n‰ésši„¿xŸ·‹ÔìÙrrŞØ]B«j*Ò£š•HŒE“€âh)® $âyÈ.4hĞ²eËhy»Á¹(½²cÕ`€ájóú¢NW\é"˜Ø¢¤UÃC÷B°…4Ó(O$|Ôì"Ã4‘1•N¢jšŠÖøÀ(‚û³æ4sHóE'ÑáKİ.Ò'••5;û¨]ôØw%ÚE^Õ¬J­Œ²€Z§[-}x]ÄW€_çfÌ˜CH|‚1H4Š¼6›å×GdõşbD[¢!Ì Ñ¿Ô†ÚµŸİ~]ÖçÊƒ½¦Ôu„¿xï¾ ¢DT_‡ ÑĞ½Aá’T\m3MŠĞô©tÁ„WD{ésÆğÊÏdá+Zwİ;$D€#(—P¥ş¿’‡ªšÕÛ:ÖöD$¶(okVÉæF¡H@:ú‹¤« #ÔôeT%ÇNæ<:ÇĞ:’±ÊcÕ¨ğ¼·wıÏÉÆ‹ÎÏ›9º«#õO©*cÕš¦Ğ­××á
BÚßHH_\$w]rŠn¥0O¸ÊÍm2rÄÒİŒDTô©ªÙ~u›˜G÷ó›{º¥ÃøåxQ³r‰±tP™ í"•µ“\6ÚEÉ5¥ ]d•
)Eoµ	Zèd‡Úì,mÉŠÖùná‘²peÎ[;Ÿh,,È{èÛrvé‰z„šV­ o©YMqŸÑ_¾˜+nô¶4%¬#1­ÅâİÊUÕ%âFsjA[bdrñiF‘fipÔô)«Ùû^ù÷„ÜœÀ/¦\î†[,Ã«š•
…“€ºh©«+’Ñ.²BI¤¡]d•
)÷BüÛ›‡7¶Íû×ïKÄ¥ÈXµYYÂA¤[DšiÛ¤²Ú.Òë/şÓ";kæPÔ¦UÔY$Zµ²šıßü«°‹şó¶Ş/@16ãEÍJ…ÆÂI@]\_¤®n(	d3İ×¡uÌÄ}áJ@ó‡4­Óh•Ä0bŠ¿û/á®Á_÷‹6•ˆ˜fçÖğhWôµFM+²4Gš;ná˜ÒöçÑg…iÊÒœW"®€M[Q“£õb³õo hX G,	SvqçQV³ºÕ­½d·(¯j6›.¬;	$ @‘·›ıEÖõG‘uVŠ¤Tv¬|y}û¡ãÚæ=9±‡<\jUGçÊE£ÏiôªÏÅ¢“‡I’İX…×H· /ÎRüpM³›ömÃ¡ãoL
äĞñ³b][‡¶ùI»’@hVÊÑ‹³#])Ùã…´m7±¼CY×v¯Å÷	>´¼­HÚEÖõG»È:+uR¦‘>;K´w±”?ºúH–¨?Y¼íàñÆKÚæıÇ$™Ë¾DQïU4Ş!seeQÿè:"½ôhïP–†Ô-74Ğp‡ª+©I2w4;kY}ı¡S OH“Eä	{WĞ].jı³ïI`RQ€ í"”ÊÚE555æ^ÊËË3¨¥=§Ò.²‡£ë¹¸6VRÍëà±³—´Ë—KšVÌÑä#âhyKmJwô©ï'j&¾Óš¹¨—f]"¢Iâë{Ÿ<>¯UNë<¥–4½)İM²81¢× v%n¤ó'÷Êb¬ºBh)¤Œ4D‰k,+©$'F–Q…w—¾\_İf¾¸8pıM·Jï|²ıÀâê­Gœ2²4º­Š¾ìAå`Pi4	_âÎXuJèfşYëÀáq>ïEçôB¤Äœ‰}Oàİ.b/Ù÷Š6*Hg®½RSÚE^ÑT|9›ÙEuÏ¾ö
UÑ~OCÃ9»¨êHgE¦ZÃ.š|İ ÖùÚŠpì7O»H…ÖbQ§Çª-Š!’‰mÍ.Rh˜Ó«^ˆ”È3±	°—ìcåÆ­5mW¿¾´‹Ô×Q"	Ív¶vùë—‡ÖlÙ
‡CXƒDpª¶CÂòÏ[V˜ıEıÆÈóiQqµHY°Ìr‚ıKŠõè„8fk&6§¿ÈÛ×€$éù8—Åú™ /+?k7^İ¨ñlÓ¸úõ¥]¤¾’ÛEúŠÚ~—áÀ™P¯Ïâ½¾Ù|Ó¶ŠnWsßçëÍë‹:]q¥Û|³<;_b]«<-¬3&¥ã£øŞ›SıåÍöÒù8ÏöÀú;@€—•P•Î’WZ=Y)í"o«]ø‹`ÿàüE0‡¢FQvvV‘»„ËÈíãï~ùõÉÆÏÏ»ïúo¹]¶©<óÆ—ØBDŸ>§™Fø‹÷ğÑ.’¨¯½ó«Óv3K»bËá´ÎÓ¯Ğø~p·vİ.nã•JQNP {ÉªiÄiy¨q§	3ÿT	(È%Uá™^3Š…h|Pôòõµ}õIbØçÑØLPßfÑ½—¾ñ¥¶#§›…6+KßM²‰†EC$A™ŒE	v#›¯‡äÿåÓC¯×4^0Š ?şß¬Üú?/hå¡JQT   3ú‹¼İŒ]\´)sáH(8
Ãq¤O¢ÓıHMİ÷]FsŞÚ‰œ·úĞ·¥ÇÓm3-âşÌcî\SÄHÚ$:co7Jï0?®İÿÖæÃ	
ùşÕE£úó9,³'Ï Öó*L±ÔxŠÀ˜\ÚE ÛX¤±ë¥nivQHû	é‹‹$N¢CÿíÍ†ÃÇÛæıëwŠm¬rY™§Òåæ
7šæGÒé6“Œ0Ó¨O‘HàÀÑ3-Ş‹+®ğÍ™ÔMK¢„,š¼Eàä™Ğƒ¯n?rª1Ø˜ğ¼`êåíÚäz«j”6.jœC}œG§¾I¨û: ‚7èàkóÄ] Khôõ3úBš b¯!Ì€û/á«Á_÷‹şf‰„è†E"¾¦H7–4“Hß—œİYo_.HËghI»–
š4øRE.hEø‰Àù­roÔ!qFö¹ˆF‘o”NûF•>®í"(7Ú¯×BhkŠràA°5˜F0¢á×ğŞõ—˜Á†¿îS¢(4£v£† „£H‹‹|p¸Q…qã÷ákaXÜ€e€¿Œê{Q‚UykàÜT)<@ûL¡ş«í"ÏëT,ÑöçÑg…i.#m	Øœ¡¨µ­KµØ®¿¢‘ğ÷‹şf‰XSšX G,4â:Ï7}×+ û§ç‚æÅŞvUG×ea$àx<M,¿¤¥šÀCËX&~P³©Ô¸Ïê¿êĞ.òƒN£³é4&Ôi~ü5âÑéö€„—˜¦†?RJ7jÄ£3àh³uGgĞùáp±Í]F°”útŠc,¹(‹"¸¦gû–¢Û·ä¡õpm)z @³¨L€v‘ÊÚIA6}:æƒiÆ:ıúúÃƒ$üHn¿éİ/:n‰"$n:jöšk!ÂLJ  +(¦7u(El$¸Qók-£2x²J¨q•´AY¾A€v‘„0‰të‡]~-j‹wÄ¾EšEDO‘š¾»51a'øtW(–F&×éJg‘‡5šLtj<!ş. í"iè*X·ô ²_ú¶®z@:µ^Â|äAiÀšzí(ÁÒˆ4sçi$•béµ´–/+Ùø³ÒÔ¸?õêıZÑ.ò¾YÈ2Ø¶Kâ›è/ß»¸×ÅÏÏªªªJ¢0FÑYÖX]¿ˆ	êHg‘ßÜ¬>Ô¸ïUìÑ
r_W*Îb?°¨îà±³—´ËŸ?¹—Ä¥ˆjøêèÉ]˜ç‡Jôú½±ğ·õõÑğî%%ÁqSî@èwYüŒ0óE…íŠ.j+v3“%Ë%´	['s—ä´zëDjÜ[úÊiie‰¢%T“v‘è~,.ÌY{k}İÓ¯¬V¤~î®¯ÊR\¨:r‚zH—íöÑeßS¦MïkÚëYºHÀCôMæ±zõjx_…#FŒ>|¸Liô²ı=Ä ]ãÕÕÕ«V­gHRQQAKoğ@»ê¥_Tƒ_	Ğ.ò«fİ¬—vƒÒwèzk]İÓ‹ª”\Ú¿¸ÅİN\loÍŠ††svQQé(‰ş"ÈQ¿ÿëµ[÷À.š>ºìÜ†ÅZ|:\k,H)7ì²—c¾¬Æßz·D¦~uÃ*¥q:Ş%¶pİÚElN ]äÙlÊWÂÖşÀ.úù¢ê©•ı¦Tô“ ¦¦F,+‚$•••eeerEZYÛ°`éºÛF•Ş>¦\ß4LÌ7¤Y$W-J—® vDûİf»¨êHúÆ« ÆéxW¡…S†´‹Ø$œ"@»È)²Y“¯pé¡+ÖmûùŸW+bAápXèA®§HÈ ì¢[G•NU®mÒ}‰Mºè2ÊšÆrE=á†½¬|Œå
9’ĞOnXOhœwGÚ13M‘ í¢1yËv~uzÃÎcÆï+¶>ñ÷PAëÜ1ı
Í'îÖ®¥İÍI—ÌÄz‡p$hş¢ù¯ªâ/RMMÂ.šz}é­×—æbçlâ¬më9i©¦,äQÖ+V›àÀj“òòr¹¬üä†UVãt¼Ëmä,½9ùk…©ß(,ÈÿË§‡^¯9(^0ŠP5ü5¾Á›•[ÿ±†|SeVÄ9ú '"ˆ‰tºÏˆGBáp$†e¥¡Ó<FäÆvóMW–>?5¢;†ĞıM‡t£È@Hğƒ•öÒF¼wM©¬ñûî»Oè\úld?iœ·¼LĞ.Ê„ÏıvmrGö¹(1”›Ê:´Ég«cË±N ¨uŞÄ#‰í¢|kÚKÓ·UæAÍ	èãzS	)v]aVª8ÔQ(5†Ãúˆƒ°$½xeQã)4(_h<…ú2i…î>ÔŒê[˜‹<-ğ]wEÃÉX›è³ú mt¤Ö¦|OŸ>=tèĞC‡!?ó{›²—–XE"½÷¦£ÓBœKˆ«G€nØTuâu7,5mOµ¾LO»ˆmÀA°|†–´k©€Iƒ/M`59(³ö2èT:gªĞ¦M›uëÖuèĞ!iö3fÌÖT†‡Y™%Ñ< ú<:|) ñ Ğkµi¬÷İ°Ôx¶iÜj}™vÛ€³ÆŒßÅD¬…a=.p¶læîOÚİ¡‰tfÑK/½t~L›6mçÎãÇ?uêJ~ì±Ç6lØ0kÖ¬Å‹wïŞı©§ŠI	{©oß¾âD¤Ç¹]»v5g“Àœ•î¡&“ˆn"Ñú)+ºaSÓ¦÷İ°Ni}é{÷¾ÆSkáLM»ˆmÀY°úw.h^ÆmWut¶`æîGçÂL;ÜÏ‡1³víÚ£úÑ»wïõë×Çà|üñÇ'Mš´cÇ?1)±k;,¥Ã‡çååÁ‚êÖ­Û®]»¾?êàÁƒ1	Œ¬~øa[•¦ÇmÅİ¶²õ[ftÃZÔ¨oÜ°j0}ã{÷Æ-¶p&£]Ä6à8æ.#XJ}:Å1–…ø‚€Ø‘ĞÑªìİ»×ğÍ;öOKÅ5O	gE=zôÀY˜&7yòdø‹
—/_ob8WØBúª"N¢s±or¦Ö’*}ä†uPã1¾#OûŞ}¤qK-œ‰h±8N VPÌES‡ÒYä8v!qãÆ	6"79Û·o7ŞÃ­„÷qS¥Ã×TZZ*üEcÇ+²Yñ ÷	Ğ›
s?¸a]Ó8Àzß÷î§ÒÂ™öÂf—Ñ5=Ûs#WG(3Ót	?~+…àÒ™:uªÈcØ°aÅÅÅbQÂ0 ¾B¿~ı:vìXTT´oß>$€;¨K—.•••ØzÒœ²ùŒ;lÄ!†Kqîşıû›Ëhd…¥JéÖ€ç‘@¦è†µHĞ7nX4¤>ğ½ûFã[8“™	Ğ.b{p„ ¢Ò‰ı[€nbù%”ÁLI -˜ÿÙgŸ	¿Ğ’%KŒxtO>ù¤øFÑàÁƒÅG¼çwğE‰o°(Èœ‹–-[vŞyç!ÁìÙ³‘ÒÈçbİ!Cb˜³J«<‰<C€nXÏ¨Ê>A©tûX2'·	Ğ.r›¸kåé[¿H;Ş¯^}ÁÖ—{íyµû—ş¼v49¾Y°kğY	 	dºa³Mã¨/•…J÷w•õi”<üBà«£'w8b^ îìZõ–¹½±ğ·õõÑ¦U\¸qêr·07ZyQa»¢‹Ú"˜1£u)ŞêEÌi„WÃNógCáë·=ûÚûS+ûM©è§¸äî‹·²¶aÁÒuGœ2²4?7¨¿ràªÕv¹°¥»¯uKäee]7ş¸¬¨ñlÓ¸õú2e\´‹|Ò0Ä¼á·Ö×=ıÊjªTqá³]Tuä²@@	çäí£Ë¾?¦}E}ßKZG*4–ø2ğqn]7şèÀY¯/S¦M€—•utş¸¬¨ñlÓ¸õú2%í"ß¶}Ómï¶·ÖÕ=½¨z@É¥ı‹%/éÙWû¶Ù.**%×_İ×ïÿzíÖ=°‹¦.-Í“¦CãpºšçÖõâœõú2eÚxYYGçËŠÏ6[¯/SÒ.òmhºñ`ı|Qµ
sjjj¶K¯¨¨(//—N_<änUzû˜rEQÓˆ³Œ¤+¦ø8·®tà¬×—)Ó&ÀËÊ::\VÔx¶iÜz}™2.%¦6Q7™;ÜcR˜vû‹ÈZO[B3›Œ"C>@
‡5VÚßj#.±Ë¤úó\lÁÑµk×iÓ¦ÕCèmÄïŞ°aCâ
ãÄ{î¹ÇŸPX+  ğ5ÚE>P¯f¡oBìâ'Ó'(5†ÃXÊ7º%©ÛF<H Ş½{òÉ'ˆµ_°+¢ucc"r"  ğ+ÚEŞÖl“³H„îÒo×ÇyéÃáˆnEYiN#ºŒœÇa	ë×¼¿iå¢í÷`İ¦hf˜›ÅÓÏ?ÿüûî»OLÅæ­§OŸîÔ©ŞW’ØV8”yäñqñâÅ"sØQ“'OvgÛÖÚÚÚ«– ÎWŸ,ß²áC‹µc2H Ş×k¯½öÔ©S-É€ËmèĞ¡bT‚‡G	àÆhÜñŞ¸BûÆ÷FÕ„Æ±‰6îœæ{©GëN±½K€v‘wug–<(<4‹’ªn"ñŠúŠè,JŠL0NÆ£¡!‚¿Æº5äB×í½÷ŞCAo¿ıöücQb·nİvíÚ…^>Œ-\ßxã††±!,öxifÍšuóÍ7cX„4à44ªªª88âs‘	Œà²ºüòËß|óÍ˜|ğÓŒ3`áÊ26\Î¤,+‘À7Şøúë¯C Ø<K—.İ´iŞß{III\ÁöìÙƒÄ0î¥ågÑÙI€v‘×õ®;;ôµ2Ñ3^¯ÃòƒUÔ(Ò#âÜáb™½'	|ë[ß:vìØ|ğÅ_ôíÛWÔAø‚0¢YXX¸|ùòººº˜«÷—¿üåÅ_D¸·ê|ÎKL£È-æ~(GŠàà}íÕ«×wŞ):ÍpÀÂÂõï+àIèŞ½;Ş‘ñ«áu½/İ°¯ı@8Ş÷Ö¬pÁñ‰ÇÛ¶mƒaçÜu×]°uñ÷ÏP(unvc'¶ˆ½îºë`3Ãj®Bx–ÌyGU Âñ~øÓÿ¢ãİQÔŠgN»HqYO°qyƒŸ¦4h±ôyt:.YÕÓyˆ@^^Ş¨Q£n¸á†şıûŸwŞyBrôêJKK…¿hìØ±èá‰qPãÀ(é’%K&L˜`šè%¶fVe%ËïëèÑ£¯¼òJÑQóµk×®^½záÂ…?ş8;vì@§ÙĞEuu5úÇ¸Üp=&|b—}é†u¹RĞïw¾óX¶P.Æ˜ŠŠŠ  NÜN±tj…½„iqq±˜V×¶mÛÿşïÿ®¬¬¬¯¯Gœˆ†!\ñXíé´êe]vµXæcÚEv‘”6•Î¡‰tÖ§4³ 2ÇacVfa„{¨É$¢›(sE¹‘|/ÅÅñrÑ£Umøğá]ºtÁ`§QO‚ŠQL<æ÷ïßõÕWã¹³¾hØ°awß}÷wÜá ))	
8èRp?.˜³ˆ´	`”mÑ¢Eh¨p·¢7,¦Åbp¡   ¥<á[À£¨Gi—›ú‰¾tÃº])¸ş`ùå—¸MaÀŞuaÃ„A%1ØÔ§O|ß\A{÷î5üEsçÎ…±”ºy	¤L€vQÊÈ<á\OÈ™~¾Ù_dökc8güøñbPü±ÇÃp1+,cRŠ™Æ\ˆ˜ÅëÍ'K˜³²•yP«;‘¶²u*³+‡ıã€‘“«tîT6Ú°ïXD´lÙ2<¶ñæ³Ï>Ãà%ºeøÃŒa|ƒ!Luc~zòÉ'õEHÿÜsÏÄôéÓ1şíS¾ 2`ÄM€S8è†¾åÃ\(‘E@Úà.À¥!®8ZÅú=ó1<ÒÎß®}é†u¿RW‚Í³eËØ½Q‚öñ7É={nö­[·Â0«¸qãÆ‰¦b^½i—Š™	Ä%@»È?C_ZàŒaÔ)Æ¯	E1øŒY˜1lö€#eÌ\ˆ˜ÅëŒI`deûâuØBúª"N¢óRã×-Xüq¶…{‰ˆIVÂñ¨âäŠ-Å+Ü¢â;vüğÃÍÏŒ>À=oÆ¤ÃñŸÖ}ßrçÎOœ8!æ!C¹¸Sá/Æ’àQ7Üìˆ[7Ê‚9•½ã2l0R.‡eæéN ]äUßæã×Æ,ğ–ªÚ<eÌ\ˆ˜ÅëÈGÒd	ß*‹# ÜwÃB˜Ù³gÃé*¤‚ëô‰…oV|)¼¯ñèÏmÌ¹NkÖ—nXh¼ÿu·Ç»;»±Á
Â´I1¸)Ş^tÃÍ.¾Óõ‡Ò¼1ç¼ÑlR=4>°b‚p¼÷|µC¥0[õ	Ğ.R_GjIhök#*—FÎöíÛ÷bDÜ”Feb¯Ç­¤"*ÔR ¥! ›ĞÓ˜ ¤/áø²R6]b^=g%Ø…Ó«ùĞ.òªæ\A3±h+‚¦N*Š‹ñkc§_¿~˜èØM‰YXMkxÉ1æ×|Æ]ÌâõæÕ1²rgsLx²    e	èkĞyx–€ˆ­†0¡päl(¼bı¶g_{je¿)ı<['§_YÛ°`éº‰#NYšŸÔ_9¹9 ÒÖeqİŠSÜÓÍ—mÛ:9¶më¬²<%/+ëÀ—5m·^_¦ŒK€ş"6 °J`Ğ A3gÎ©±\X„çÆ—VÏg:   U	Ğ.RU3”‹H@1°}ôQC(©_±bÖ9ò™gQLXŠC$@$@$ÚE©ñbj ¬%ğé§Ÿ"ì¬¹úXq‡ØÚu×®]Y‹…'	˜İ°kÖ¬nXfËÓÕ$ uıÃIt¼«©©ì”ŠvQvêµ&Èˆ &ÑçÇKåË“I ËÄ¸açÌ™³qãF¸aï¼óÎÅ‹gŒ¬¨.˜ÄV­Ø½†ud8Ş©ñ¬hjW’v‘ÚúQRºÓ§Oc¯!1ÀÃ`qJªˆB¹J`Ï=®–ÇÂHÀGbÜ°%%%K—.EıV®\‰İl|TQVå0´]ã«ûï¿_8Şy€
h© ïÉ€(ÛøÛßş¶dÉDëö^(1	dF aè‘æüàï‡~ˆ©t™åÇ³I€4óæÍ«ªªÂ Öò‰«Œ‡ÏÀ)ı8[¸š«K›üú¬²¬çĞ.òœÊZxıš÷7­\4¢ı}µo×ÔÔ¸Y1lä:cÆ8‘¦M›öÈ#WŞC|q¼Î%t%ñÆ8ÅHé¨ÀØU}ãª%€óÕ'Ë·løĞÑ²˜¹_	`ÂÏ˜1c^xá4Zv>ÿüóøˆ÷õõõ|œûUé¬—Ëp•=ôĞC˜d…á†3q¾;Åán)æÑ!tZÂ½Ç˜IîÃRH † í"ÿ4	l¥Z_ihˆà/Ş;Z1˜ØÎõÒK/íÙ³'¶mEYk×®]½zõ~ô£êêj¸’pËÃP,¢o¼ñõ×_ÇÔ»­[·"Í©S§Ş~ûíÑ£Gã¤|é¥—>Œ-\7lØà¨À¬
Á`$·ír”¶_37¦Å‹æ¹âé¯©_«Ìz‘€Ë0Ê fUuíÚ•áL\†ïrqØ8^”ˆÑ%EtºÌŸÅÅ%@»ˆ#bè
/P¯^½


¶mÛ6vìØóÎ;ßôéÓ§®®)ñåæÍ›¯»îºòòr8²¾øâx– qÀ(êÑ£G:B¤vÎ¹ı‹i¥F©I€HÀ11nØÇ\Ì8À¢|Ì©s¬Xf,€oë‹`‹á0­ßO˜0AšX,˜t´‹Ø2" ãÇ|>ÜG›6mßÀAc©M›6ßùÎw^|ñÅN:ÁMôÓŸş´ÿşÂpróĞ÷üæA$@$ 7,Vá7,µ¥460ô+ì^ü5¾¡ïİ&ÆÌ&}´‹Òg§Ú™X¤*^xï¨xbFw~ó›ßà1f”…±xÄh`ˆE0‡0•"]vÙeøRL¢sù@é%%A§²²2º, ‹#   P™ í"•µ“šlWûÇ#'WéÜ©l4f¬¥vr*©áúì³ÏÄ ÖÁùÓ­[7L^ 'Ÿ|Rü´páB‘+Œ¥ıû÷c’afİàÁƒñ¥ù”Ù³g‹/; dÀˆ› §pĞ}ËÔ9ÒÌ™H€H€H€<I€v‘'ÕÖ’Ğºè‰Cˆp|ÕÖY   °• í"[q23 , €y¤óõ3ã]‰ŸtYE  C ÈØ\rÀÛTªN ‚¡päl(¼bı¶g_{je¿)ıl*Á?Ù¬¬mX°tİÄ§Œ,ÍÏê¯œÜ8× ‘>6å·m,+©ÔMº¬ï.}Ñğ…X·6rü4¹è“íWoeÛ–Ş0Ô€ë:òÇ#ƒÏ6[¯/SÆ%@»ÈÛƒ·<ëúóÇCÎz}½²YÛ®{öµ©Ôˆö»±–8ÉëÖ`ZK—vÑäëµÎÏÉË¡Í/]Š
 ò#®Wl.'À1ÂÑU²VÔãG†Ê‡ã]ìµˆzÄF¢Æ­4K¦qš í"§	;›¿Ê·<gkzîşxÈ¥^o¯anÛáÈ_¿<´fË®P8Š"áHX{–êÿÉ0Hm~k§É.*è7F’¿(DõƒÚ~Áœ`ÿ’¢A=:µ‚#4O3èõjÓwRn•İ°ï,ù£y¸aÔ„Ûœ$‘<o¸aUÖ8ïÉ[!S¸N€v‘ëÈm-PA»‘¸±A6,Aºq f·x#w?
ÚE¶6=Ç3m;	„#‘ÆP¤18
ŸiŸÅûPô{Ç…h¡€}Ÿ¯ÇÀ¶˜„Œ°ïE½‡È’åb*hN0§Om•—Ó*F‘öQ|Ï9¢U£`ÑrÃvQ ×İ°Ò8ï*4ùl—v‘·[€jvŒ¢ñãÇÿà?èÒ¥‹°‹°}õ­·ŞjØHqÓ.’?¢»oà/‚95ŠÂ°‹Â°—`”à'ı_·û¿õ¡P$''ğ¯ãJ$yŠ´*ÃU„åq°}t»HLŸÓL#üÅ{üD»Èí–¡|y*»ao~Ëì/jÛÿÛ’púÊë!Óñ.©Á³Øo ]äí¡š]$h>óÌ3Â.f¶3W2í"´`]áÑıE„ÑM£0<E0ğQ³‹Îq{mÏì7v„ÃØE}·»õÙRã#óÃşÁ¬9ÍÒ£‰ˆItøR·‹TÄnğ^ÎOq7¬Xm‚«M:]q¥DÒ¾qÃ*®q:Ş%6r— ãt³a8K ¾¾óèp4ÈÙ’˜»ÿè{q	¿Gn0¨½r4OH4œ >g¯üÜ€Ë/=†!•#.—k..Zwİ;$D€#(—à¦ÿÏƒâĞzó@<SmyZÔÖ-êèu'Z‘k¯Ëú\y°çäºË¾‡¿xïZ¹1¡úÆ°‚îvÕ/÷èÎ€¾ ÔÔø¶Î¡ñí]¾×éŠ!Ô8oU* ]¤‚ü,ÃÈ‘#±¬Ş,^¼ØÏUeİ `tïñÈÌúC4—ˆXH“Ÿ‡ú¢w_ZO2Ä_—Ë5­»@„³ˆ¢}}–
a–^'w*şÑràlÔ‡¢¦µöfv^n¿`	Íı¢›J„Q„Q˜(‹†¨É„4´/aúnº-OiCİâE§«_g3ÚE6evfÅÅÅ+W®ßÀqÔ¹3VUò K´¾zA^ë.#­»†`kÂCÒ
şê.#—_ÂàÀ_—ËmVœÁği.#İ·Ö40¬­½’¸üÉ’š™È}ªºaáb´A»ä¥ybıé†UYã²}ïşÔ¸ûw•H»ÈGÊT *XP„)s³fÍš1c†˜8÷øã‹yt%%%Ã†S@FŠà!Ñ~½>ªqÜ¸Cl¦‘>}Nš»F¬ëÁK¢¿H­AĞüfZ:}!h0}ˆÛC£Új–UM7,Ú³˜ı‰¿²®,¿ºa•Õ¸tß»_5îù›”¼
0î‚<öv”¬fÜ;jfŒ»`?SçsÔb+è#=úœhïÑ÷ÚØ²ş…ûÇ]ø<Ö&Øüöö+Ü/İ\¢îU.µèÌ9ã½ø^®x,]AÆSQ_éNğNW¿¬ä´œÙoÔuüìÅmóûn‰<tÑG‹ôØ¿D_Ôô=Ó¼ua©¬ñû^ùBÜK1årj\–| ıEl$@êˆÎ¦Ó×>ë´/Œ…ú*	¯¨·( –aÈ|!8Z¿Mwy¬ï¦nôŸdŠºaá#ŠPÄUwWÆç;7¬ºWÄ÷î;ûï®å^h¹Çš%‘ 	¤A@Ÿ&ÆhµÁZ}ıŒØÌTÚË¨…DÌE‹-ŒtÓQ7Ù4OQ¤yJV>F4“¦&¤G4ÑB,h!°–>î á»ÿŠîIˆ¸_´©D„0„hğ	ÀÑCŞkw}ÄÁ{nX•5®m¸ ¿¨ñ¬¸ûx¡’´‹¼ %ÊHÙM@˜Dºu„C.¿6«OµÅ;"æ²fÑS”İ—KòÚ«é†Õ7#Ö-{m¡Ì—ÿÜ°êj¼ÉaD'¿n™Â´‹\ÁÌBH€2& wšô ²_MaäKòMÑµE“fş'  VsÈ4*xb}æ†¥Æ“6*ŸiÜÿw1gj(má²3ÕÉº\wÁºÊwÁ:+ÕRnÜ}üÕÿ{£"‚:~VÄƒèĞ6_‘<$FÛÖyË;”umç!™},jSğÜ°ÀÌEu½¤]ş¼É½”a®¹©ıäƒUJãÿôâgˆ» Ø½4º¯2-Ğo‚(ş ]äí§¬]T[[»jÕ*ÀÅ-¸¢¢¢¼¼\:hÚEÒU¶ .­¯?t*íÓy¢jº\Ôúgßë¡šT”G:šì¢ù
ÙEÒ©øY€zqk#‚!òÈ2*?hy»1Æµ‹F–•Tê&·bï.}¹¾>z³+)	?MúxÛ'Û,®Ş:qÄÀ)#K£[aê+Œ½wU®rİ/]ô– ¬Â‚<÷Ko^â™ÆğÉ3áóZå´Æ+<R!pøDc(C€ßT°eKZÚEÙ¢é¦zŞóò_œ
!èBa}ïY¡|õ´‹¼İ›ÙEuÏ¾ö
UÑ~wCCTââ@Õ‘ÎJ,—`M¾nPë|-øR>í"ÚŠØ[² ÉI¨JoèI’”l’ÀK+–—†^RÁêkœv‘¤¦aS±f»Îè¿~yhÍ–]¡p8„°—Ø³¥h›`JØ¤ïøæ·ÌvQA¿1òüE-º*­Â2Ë	ö/)Ô£S«Ü`~ˆKK‘MmÑÉlÔ¿“:Y{_åMUúJvW†ÍÃn¢ªçG«®!»åS_ã´‹ìÖ¹»ù	»Hß­<ÒŠ4†gBaLò9‹÷¡è÷îJ-mßçë«ªªÄúÎÊÊÊ¢ŞC¤ˆaª¢ÁÖğµ-üraiÅ÷şZU+—´#¥«'u¤Ú~Ì”ªô£Vm«›‡m(=’5îEÙ&¦úçäxÛ”-7#}Ï±‰æİ}¼àÑ÷„p; ğe}®ü[[ê.ûŞÁ“;]1Ä}ŒQ}‚FCC¡íz©qTäj¥“ 	 	 	 	(B€v‘"ŠH[Œhlƒè†—èúë›”‹H{io¢ûvë;š»÷‚i&47mV–¾q{‹†¨É„4°3NÚ-'’ 	 	 	€Ğ.ò¾›ÜAZ§¾İ=¢Ğ_úœ1¼òs.¿‚Aüu¹\sqÑºç¡ú± HP.áSŠIŞo¬	 	 	 	@Úh¥N¡î=zù¹èı‹ænåçÁ:ÒÕ¸û6şº\®¹¸hİu ¢™F¹A ŠÎ²ÓåSH‘…H€H€H€H@ÚE’ÀÛT¬ÖÁ×C/§‘î2ÒfÍÁM$<$­`á¯î2rù%Lüu¹ÜfÅiï™æ2Ò×5­ÈÒÂõÉ‹•gS;`6$@$@$@$@™`<ºÌø)p¶óM·’N›¸†7x§ı«}©éÖÍ×G^ß~èxc‡¶yON”»±½F@„êÍzŒ†_ĞÂ0h`"šUé:˜ˆÀÎ¯NoØyÌH±bËá´ÎÓ¯Ğ|Úàníº]Ü†(U&@Uª¬¹²Å´GÏ|T‘Tc®t^ærÕdcé1GÎqïíÔ¸Ì¥geå ”ÆiIo36`˜Fº]$bwköø^|áşñ“ÅÛo¼¤mŞLêé~éæu¯šp©EgÎïiÉUMK¥;º÷O_ Ü|ñÚŸ—7÷–mòéôVS‡Q©¨J¥Õ#U8¶©ø%~òLèÁW·9Õ˜ lLîX0õòvmr%ÈÇ" ô2WMãìR8Ğ
\Ï2:›NøCD4jS<:Ì“ò¶şH)İ\¨Î€£¹Ò4OgĞ¹ŞX­ˆ‡âÈ>%N{SYEÖpÊLEUÊ¤¯vÙljëÇ~éÎo•{ã ‰óÅŸF‘ıèåå˜ô2WMã´‹ä5[KÖLÍ/¤#èôëëg4IâË¨ŸDÌEë@„é¨„Ğ<H¶ê€™ÙJ`TßBl)Ë´ºîŠ$†“­â0³ô	P•é³óû™l~×plıFõ½wï–j{>šD¶1ñ}}\æ
jœv‘¤0‰të‡]~m&ŸşRè[ßj×)¤–x¢àÙ9´¤]KBN|i«Iñªe›xTe¶iÜz}Ù6¬³òGJÜ·'–_ÒR]pÏO`5ùƒ@Ö"Áe® Æiù­‰êÖQSê¦-z¢a©İı¨™fÑHİÑ‚¤ˆÑ¬ĞèÚ"¿)Şõ70şŒÄZÖã?ÖØ·u¢*}«ÚŒ+Æ¶‘1BepMÏö-ÅËi©1x¬†·–4« Æi±ı’ 	(J ÏÎşšwÛU•˜bµ@€ªdÓh‰ ÛF¶©CãÜÃq·g|Q¿6†¸—¹š§]ä×FÈz‘€4LÂ´O§8Æ’jëë:P•¾VoF•cÛÈŸO{WĞuàA´êŠÜ\¿jjœv‘ºmˆ’‘ 	4OŠ;ĞHPê *Õ×‘,	Ù6d‘—XnŒÛ¿%·¡D	Y´½b.se5N»È^½37 ›	˜‡”LL·¹Tfç ªÒ¨>É’mÃ'Š´\˜e¢jº,×†	-0kYYÓ.²¤K&"EÀˆW“8‘,ñX®uT¥uVÙ–’m#Û4úaE‡%ÌB2~­²q™«¬ñÜŸşô§~U ë%—ÀŠ-‡O	´Îıvÿ‹åJÂÒ3$‰Ï0›4OÿıêıÿåâcŸ]tdKÛ6yİºuK3#[Oóhœw¹ª¬®^½Ãÿ…*~Ö¶u.Uik“Ì43¹mƒ—y¦úKı|¹‡¼5ë><ºq9n­nÌÉ	ªpCğèİ¢ò¥kÜ¸ÌUÖxP:&‹êd2Ïx`QİÁcg/i—?r/Ï	O¿:zr×#æ}°dm‰õÆÂßÖ×G·Á*)	›rGNLG·±#WQa»¢‹Úb?,Å¥ê¨rÙË¿ihˆ^[ÅÅñ·Ş-÷Bóœ*mÇ¥NÛàen»rãf¨Æ!RJ÷ëİ€oéÊjIã´‹Ü¹ec)´‹<ªu}¬$øÖúº§_Y­B*.Ü]_®3]uä²@@¦]d0¹}tÙ÷Ç”i›si÷W­#ÕT9¢ın³]Tu¤‹
2¨¯JÛA©Ö6x™Û®â˜UÓ8ÄSSé¾¹Pã¯©XÓ_d“%%°ó«Óv3’aİ‰¿‡0nL¿Bó¹ƒ»µãIaÊJ İ´~ä­uuO/ªPriÿâ÷&wGÈ½5+Ìé¢ÒQrıE¨uış¯×nİƒ›éôÑeÚÆÁøJ‡¦”ãH}U^V>Æ&” O¨ÒvJê·^æö*]A£‚ªİÛıt7 Æ­\Aq5N‘tLc‰ÀÉ3¡û_Ù†¿	RcZİœI=óseÍÉ²T‘lN¤¯$ÒşÀ.úù¢ê©•ı¦Tô“¤¦¦¦ªªJŒàTVV–••É•¥¯¬mX°tİm£JoS¦5ğ¯JíZMU®ZµJ¨¯¢¢¢¼¼œª”B@Í¶ÁËÜ¹Æ  ÆQYÕîí¸±[l$Ô¸Pq5®Ät+Ò3úÎo…ßp5—ù–!i)«J}„I›¦İR#ªôñÑ{¾ï¾ûî×Œ"C}€k¬´¾Õ<FÆŒeÉJVV•B8T0Š<¡JÛ[’²mƒ—¹íºª©q¦æ½]å»ÅB[½@¾ù(§]”=&NB v¬£–õéT0¬Ç„¨0Í*Bß>	„”éâ&Î‰C)t Ô‡Â¼Ñ-Iİ6Rå *SĞ„ÚªL¡"Ö’²mXã¤§òEÛPTãjŞÛ©ñ.Ô“*ø4Ñ¸ZıŒÔ	óµ$paó™ï_]¤–¸”ÆD i„IL¤ÓâIL èFQ”•æ4RÃeDU¦Út•UeªIšm#)¢˜^oÔ85*lKsÓ.Ê¶àx}[rUô¾°ËE­/dJ (<4‹’‚Ä “xE}E
9‹„ìTeRF(¯J«±œmÃ**¿´jœ·J ÛÒÅ\ã´‹²­8^ß¸.#|9ùÊK/›dD@wvèke¢f2Ê-ÉÉ“'O¾à‚®½öÚS§N9Y”SyƒUÔ(Ò#âÜ©òRÈ—ªL’*¬ÊÔ*b!5Û†H¦$ŞoÔ85TS{ıisÓ.Jµ0}rÍ]F0Š¬;J#S¸H@pzİŸşô§ÒÒÒ£GÎ™3çÍ7ß´«~¸AÏ˜1ãĞ¡Cve˜ m!–>NÇå4°t*DUZ¤¦¾*-VÄz2¶‹¬|Ó6¨qjÜ"T“yıisÓ.Jµ0}r1.#LŸÃ$ºä§1…*´NO¤ëÙ³ç/~ñ0Ã†›4iÒÎ;»ví
÷iÓ¦á#Ì›¾}ûâıéÓ§ñFü$œK/½ôRó”âÄY³f-^¼¸{÷îO=õ”Ó8…{¨É$RÁMÔ¼ÆT¥¥VàUZªH*‰Ø6,ÑòQÛ Æ©qKRMäõ§yÌ5N»(ÕÀô–˜]F·€ –Nc"ÙÎmÁã°Æ`-Y²Œ0uºuë¶k×.¸>Ü¦M›ƒ®]»võêÕ.¬­­>}:~zî¹çÉ÷oû~ÂG½{÷^¿~}uu5,%œ˜——7~üxXY;vìxøá‡g©ïÿÖJ­İ‹´]•Éœ%AU:Ë×ÜÙ6Rªôen±"Ô¸EPz2j<Z€÷ßĞ8í¢ÔÔï¡Ô"¤˜¬ããµtiXtùŞÅ½ö¼ú·/>–%FL¹RŸ\Qõ`tFúÍ¶ÍİwßıÌ3Ï”—/_ê÷êÕ«   o°g‘p=øàƒØtïŞ½†¿hîÜ¹0àMÂ£¨G.sCoC_U¤â$:‚ª´Ø$ÔW¥ÅŠXOÆ¶a‘•oÚ5N[$j2¯?ÍÍ×8í¢Tµ¯tú¯¬­ÛW»M{}²}?^ŸJzaWûúú^ìb^[·W–$¢\AXö>®xGVéfŸp=öØ†ŒüàöËàö;v¬¹œW_}õñÇÇOû÷ïïĞ¡~7nœğá@ğ†¡`ba}’2§$¨J6‘–°md[Û Æ³Mã¨¯Ï”®;xxŸ€zk}İÓ¯¬V¡6î®¯
R\¨:r6çTA°ÛG—}Læ‰àªÍ}’ˆH¬•Á´0ìÉs6^±~Û³¯½?µ²ß”Š~NHÓ3è¾şúëóÏ?óæÍmÛ¶ÅŞç»wïnÕªÕĞ¡Ca=ñÄ¯¼òÊyç‡õEâ'ˆÙq8yä‘_şò—øˆÄÏ?ÿ<ÜG"%îÎ0™^{í5ü*R:!9ò\YÛ°`éº‰#NYšŸÔ_9˜,ª·*ùmŠª´®wÅUi½"S²mX¥şen±"Ô¸EPÔ¸uP1)½û4{ÿ§]”vKPèD}‘ƒ‹ó­uuO/ªPriÿâKäÊ··f<Eâ€]TT:
›Ë©~ÿ×k·î]4}thi³Äthò»±r¹4•îòãÓz¥…µ3xğ`HwÜqÇ/¼ ÈúéN¤T¼3MUZWºâª´^‹)Ù6,‚b/Ù:¨ôRòÆ·¤g){CrÕ”N»(isòj‚¦Ë  »èç‹ªã·¨¦¦Óç„7²²²KD¬ŸëPJqÜ6ªôö1å0Š¢¦‘£ûÕ7Õl•½™®Y³fÌ˜1¢:/¾ø"Â*¤Z5ÛÓ+Ş™¦*­k\qUZ¯ˆÅ”lAÑ.²*½”¼±§Ç-éYÊ^ã\5¥Ç½ÿKÂOª`&HJ@DÄÒ6–Ôşw|­|RyDL|Bè°ûõC£ÈÂa}ßR±›ƒ¾åÅJ1™bA§8T0Š¤@ğG¡T¥?ôèD-Ø6œ ªrÔ¸ÊÚqH6O(v‘CÚw3[Í*Òö¥ŠB*uñ1qNn²HZ(5†ÃXBƒ7º%©ÛF<H€H€H€H€²›€Z}ÖìÖE:µor‰%óÚ‘N.ÙtN8Ñ¢(+ÍiD—Q65 Ö•H€H€H€â ]ä†¡ícJç
9V¸‰Ä+ê+¢³È1ÔÌ˜H€H€H€<D€v‘‡”WTİÙ¡¯•‰.˜ñz…–¬¢F‘néèÜØÃÔájy2{Ä—Ã~¬Ø°Ç´iÓ<Y
İŒ b¶víÚ:-**:tè>?şÔ©SqQ¡ ,;’‰7ˆÆ.>’«?`3±Ûo¿İØ©,qcğG•Y‹Æ÷yÿµ¡\óãÛf`›Aóæ„Ikm<’¦t'í"w8;^Š"àô,:<ä°&înØy¦¥ãUÍ¬ m!–>NÇå4°ÌdÍ‚³“ãÀ¨°páÂ,¨®ÿ«ˆ'ÜM7İ´dÉèô£>š={vJunÓ¦ÍºuëÄî½<|@ //oÔ¨Qo¿ı¶¨ËêÕ«¯ºê*éqö} Ö[Uà}Ş[úJIÚŞ½{òÉ'b0]ÄwŞy'ÕP[ªİöi¥Ô TN¬M¥Ó]úÓŸJKKÑã™3gÎ›o¾iWI¸–fÌ˜áÎ ±p5™DŒ¸_‡ë×¼¿iå¢í÷ì«}!×íRtÒ|0Ôdv™?b\
Dø—ŒÑ)slöºxñb”÷ÜsOÒ²ÒNP[[»qÕÀùê“å[6|˜v>îœøñÚ„*±¥˜ªœ>}ú`³)Ô®[·nÏ=÷Şœ<yÏNCq1Z6spyàĞ[ª´½Á¸s™>|íÚµG}¦Ñ£GÇ8â^Ú¸œÅ­ uÜû€Óf_¶—ïq[¬1M Ã|ğ¸¥CÌÁhNëZÈ‰Û£¸±şô¿Ô¿±[¿6îòùóç;ñÀÎì>¼jÕ*ˆ´~ızè·S§NâAlÌÀ¶EĞoKªG3À4?ş¸ù#Ş¸8Ô.ŠÿÕ¼§>Y÷ J»ÈzëR7å¹Iîç÷ìÙó¿ø[DÄä–ohÁæ)RÂ¹” ;kÖ,<üºwïşÔSO9OYßË¸	7u÷¸úúHCCÅıÎ¡;â¹Õ£9¡ÿ$âq£&aşˆnuu5ZÑáÃ‡1›lLzÌÚzıõ×!ç¯ıkl™åÀÈÖ€ƒ‹Mºœ+.Ãœ]–vÛ¶mˆ‘¹¡¡$¡¸µ¦4İ"CÍOwíòg˜¡;—9ÌclÛğÙgŸíÙ³çÈ‘#èã›]»vá2G“ÀPñÁƒc.mlr‚6#nW^yeÌ} áwrÚÃìË¶!«RÆ}—?ŞOŸ>šEGáj÷0ÌŠwwt-®#w.‡¯Ù4NG½Ä£Ü¹§9úxï½÷dƒgøÇ?şqKB¶¤z1†£ù} ßˆ%ÅÅÅbÜÓŞ#.ÚEöB–™›ŒÎYÃæú70`„©ÓüñfÜÅŒ ÆKøÛßş– ‹AXY;vìxøá‡] [H_Uä¬oÍ…Šø c~T¿wï^Ãx;w®¸EŠ1c|Dó@
úÖ=zô@İcÒ¢S*ï¾ûnEE…“pÎµ/´"W¥ÅĞÉ¦M›bà›£µúúz'5•4oWá$•Æ¯	à#B‡É˜DgÌÇÆ5»|ùrÔ:æÒ6[×1÷^½z8ÏÊ—mCN¥Œû<ôèEtéÒExÍïãŞÜÒµó­É×%|ë[ß:vìÜ>_|ñ®å–êÚ’êôÍïcÇÓn1¡®®ÎŠ´‹ÜáìŸRÄ¶\wß}÷3Ï<ÓüñfÜÅpÚ|ÔæÏ¶˜À?€X“Œ7ÎØÂuÊ”)æXØÖ<cs‚Ûn»íG?úÑÓO?®¹£T¼eP»,-.ü­[·Š±^8ò“Ÿ$ÖšÜz]†“Á•áíSÑ*0Rw.$Ô¾_1ş"ô{š×-ÆºNzp‚/Û†"•>¢n¸ÓŒ÷˜6bV´Ü;ƒ-ÊÇyŠe„Phÿşı›¯DGqûöí¢úqUÿä“OÆ…c¾à±‚î¥;i¹ÃÙ'¥ˆI¢Fe<Ş^}õÕÇ÷¾ıû÷‹Njâg®L‹ò	&ïW¦lqq@¼ö½œƒ“¾rá B›iÕª•ù#[×˜ôh™XÉ€áç~|[4 %%AöŸŠé²´˜µtéÒ	&@‰¾å–[b˜_sÍ5fµÊGç2[šŸ™¸v™£U ‹ƒySb,Ù5ÃÜW< š×È|icö]âû€@ÌYù²mÈª”13M0ÏYÜä1fŠ›¼ñ«—åŞ\»j±-eëN½ğğÅÿ®»î2ÄÀ|¢~ıúa<.ó}ûöá{cHŒê1ÎWxó} k0•ãÂÑ×Zğğ,C Ëe°WéÙPxÅúmÏ¾öşÔÊ~S*ú9Q'˜.¸¯}ıõ×Xi·yóæ¶mÛbâ8f.áî†es0„xâ‰W^y*?AL‘Âõs¿üå/ñ‰Ÿşy\!"%l-˜L¯½ö~)y®¬mX°tİÄ§Œ,ÍÏê¯œÜœ "cş!şÉò#¦-½µ®î—¯¿†4µ²¿WÈ }Ş{ï½¢]9*ó»5õÏ.[7aøÀ©×—)Ø–| JGÕgÎ\qUÚÎmÃ:R´j<Ë5®w«ñ(Ç‹˜Æ w?Â£İÂVy9¢[H‘õK†)µ Sb½¬ğa«iÅJŒÓ2dÙ²e¢Kúÿñ°|ğVÁ‚Âb$¸JÅ)$†İo¤D$_¬º¿:gQy©Ğo øã%{Ñµ(ÀŞ‚ã-iSm¨¦Ïr8Y^ıÄÇ—p|Y©oÆéş…£=Ê½õ4·K§ò‰…C»È4&I æ‘cŠ\ä—^z)&Õ8=~Ÿº€<Ã‡0w™¦µõÊ*‘ 	 	€+h¹‚9û
áÄáÄ¬Ğì#Ê“ 	 	 	 	8H€v‘ƒp™5	 	 	 	 	€'Ğ.ò„š($	d)AƒÍœ9ST^D.‡ñe–rñZµ¡G¡8!8¢ü‹NlÕç56Ù./®eÑ°+/ó¬j2&TûCVU<+‹[=‹ºOqÕ+uĞ.RJækUÜËÄî®¶lÑ!lÉ™øƒ n>ú¨QcfæwŞyõÕWû£ÙP<¡G¨!+a¡ÊUUUø¸qãFD°Ì¬cKD?	aÅŠsæÌïÅÁËÜ÷Í[ºCïĞõ§Ÿ~êûÊfsñøğÃG) à)ğƒüÀ|Õ+‡v‘Rêğ†0ÏMÇÑ¦a½ùæ›¶ĞvëÖ­st;N[äd&nÀÃ²sçÎ1%¢#µråJ.ZsS–eÅèkÉ’%æÉÓıA [ÖÌ›7¯y]x™ûC¿	jGA÷îİ±Ù÷5eqÿ{™Cûxš«Æ‡v‘jI_õkŞß´rÑˆö{öÕ¾]SS“~F©œ	iÆŒğ M›6ça“"áJ}`±±¶CîÚµ«ùWÃõsèƒ>pÔ_„}å6®Z8_}²|Ë†S©"ÓªE Û†b¨I-™(5¿ÿıïï¿ÿ~#-TiöZËƒ©üI [?ôĞCæ¶ÁËÜŸš6Õ
}bÑ%@ĞZßW–4ÜtÓM³fÍ2Ï¬V
í"¥Ô‘‘0«V­ª¯44Dğï3Ê+áÉÇÇ0˜*:yòäµk×bß˜…bø§ººúÀp%aSDë;w.2Ã×?üáÅŞG‡†wSæ`« °²ØÑ[9'0r6à`Öæğp;cGi;š9î§æ¾µ£e1s	 ëƒqÀ~?	{7+Ì«Á¨™ÙuÀËÜ»Ú´.9¦JŠ9“8EÁu&Ö+Â”)@ÿPèS©KJJR:×…Ä´‹\€ì·"Œyt°…P·^½zàÍ¶mÛÆ+¶*êÓ§O]]]YY¾Ü½{÷»ï¾{Í5×Àˆ‚5UXXˆM`‘OÁ.]ºÎ%‡1EŒüi9ŒÚÁìÑÂ£ÔÁ˜µ3°TŞ £ã=bºyÜ™Î”Ï\Õ% b¨˜;x™««-û$ëÔ©“1‡
OğÑ¾¼™“7,X°ÀXt¤Ä´‹ÔÑ…ç%éÙ³ç¦M›D5¶nİ
{	~¡ë¯¿şé§ŸÆP1œK¥¥¥Â_óI$ş¢n¸áÉ'Ÿt´ş‘sf‘£å0s;	 3=fÌ˜^xÁˆcƒQä{ï½×Î2˜—óĞÍ­¯¯‡*Eà)Ü
 G¡V#
™óR°	ÀK€–`Lªax™«¨*»e‚Ó }bqÀœI|´»æ§
ŒfğÀ1">âÀsAÁÑ1ÚEª´›Ìå¨¨¨ÀE¼ğ>óSÍƒÁ¸µ‰æÇ›˜!sã7¾üòË˜PßÑK/½„ŸŠŠŠöïßŸÄG>øàİwßjq)¥’’ €SYYS:‰¥@Ü#8•xjŠ)šR„a¡i€+ÀĞ#tjL¢_ráuÚ`}p¢ypãêæeîÍZ©úÄâ&À©ÑVpy7zƒÆ# J7>ª€‡v‘w[Z¬äWûÇ#'WéÜ©ltyy¹C‹	×­[·eË–‰¹s8àö­_L±ÃÇX>„?ûì3±šóèkA8‹pÀLÂ„:GãÑÈ€7Ná ú–3 C­ƒÙ’ 	 	 	€W	Ğ.òªæâÊ­»Ağ‡Î8xÇWm•!   [	Ğ.²'3#    ğ ÚETE&    °• í"[q23      ]äA¥QdÈ&555ˆ`#¼Ï¦ªû­®T¥ß4j_}Ø6ìcé™œ¨tÏ¨Ê&A=¡ñ ÷¸´Iİr²Ñ·åÁŸ`(9
¯X¿íÙ×ŞŸZÙoJE?)!,ıŒ3DÑbkl]‚Í(ğ;ÈÉ¸²¶aÁÒuGœ2²4?7¨¿rrs¤«BkFÍÛÒÈ²’ÊAİ¤´%£Ğw—¾\_İ
1º¯¿éVéÚúdûÅÕ[•mKÊªò%Ô÷§Ñ¨rÔ„Ûä6-”®¸*mç£lÛàen»®E†Êj²©¦tÜ¨që—R\Ó.²PÅ”ªÙE#˜CxM	°#v,Á{¼ADo‰›ÏĞ.JÜ‚›µ¥ºg_û@…F?¢ı††sv‚­ÃUA0ØE“¯Ô:?'/G-[aUî6ÛEUGº¨ GÈ ¬*mç£pÛàen»¶ãÚEªÜØ!œš÷v¯ß”½Æ½¢qÚEÜ‰\ËTY»[_}õÕØ½æĞóÏ?ß©S§ñãÇIÖA»Èº]ÔüõËCk¶ì
…Ã¡H „µGı?×m’[V˜ıEıÆÈóE‚¨~0€ùÇÁœ`ÿ’¢A=:µ‚ã1O3Ôñ=šoJ©òøæ·ÌvQÛşß–u7@kö„*mç£lÛàen»®E†Êj²)£t_İ¨q—R"Ó.² Pá$
ÚE0„êëëï¼óN¬ä.¸àüİ¸q£Dg ]dÅ.
GáH¤1iÎ„ÂgÃgñ>ËHû^Ê¥°ïóõ«V­EWTTtºâJ)b…bêeN0§OÅl•—Ó*F‘öQ|¯ÂœLq[ *“¶õU™´
©&`Û°HÌ7mCYCJİÛ©q‹—F&É¼¡ñLjÈsI 98…°²Î¢	&444À(ÂGğ­Y³†ÄÔ'€qô¨C×4¿ˆÖİÇş¼Çz,—_—õ¹²®Ë¤ºÎ“ğï].İ\ª¯CĞhh(€G75« *·KS%şR•rŒ‚mƒ—¹£MB5ã¦‰›ÀÁ^SpCÀ_‰7ÏİØ-¶55®Â# ±ÆÎbc²ÔtîŒE }ûö!Ü‚8³{÷î{öìI-¦v•@Ô$şÁC+'¶PÔ"‚=«™FLËË‡ÄÕ—nuh¶‡Ëå~³8EBÔ:Òàähbá0¹ÒäxÕ¾ÙRÔU¥>S{Q•®^Üç
S·mğ2w¦I¨«qÜPº‡nìˆÒWàDã´‹,¶3&³D áà Â1fÌ˜ùóç6§‰oğË,åÂD²4¹ƒ4ï|#º{D* ¿ô9cxåç\~év‡ör¹\sqÑºç¡ú± HPÒíú+j$ÉRŸ¹\UU©»Ø0·›ª”×JTm¼Ìjªj7Ø`P¿!¥İ<vc·ØDTÖ¸ìG@r3N·Åf¦f2×©	
Rq}QbÕh·=h9Öá
BÚßHH_\¤=»¢q$høÇŞ&¤›{KO	Å›ŠÔg&hşÍtÌm24¯š6ÉPû!‚g¼ä9u*«òŸ_İk~¶ŸßLUJhË*·^æN4•5úşÛ›‡7¶Íû×ï;Q}‹yzâÆn±.Šk\‘G@3î‚Å–¦h2ÚEÖC»()+£9…€N·ôµû|y}EB§ÿGúBØEÏN½<i-œLµy4»È´ĞH3ŠÛKYUŞ÷Ê0¹1ñS¨J'›jËy+Û6x™;Ô ”Õ8ê;ûú¯Ÿ½¸mşcß-q¨ú²õÌİB]Ä“Zü	ªö(‡Xj<jœş"‹íLÍd´‹¬ë…vQRVæq&á Ò-"íöÚ¤yH°‹~øÒ_…]ôëé½“ÖÂÉÚÓFÄw-(E4ü‚æ/RÄY$ª¯¬*ÿ÷ÿ*ì¢ÿ¼ªt²©&²‹Îy†y™Çãä™ËÜbRön ùy}û¡ãÚæ=9±‡Åê8Œw jYªñH¤q®/r¯5°$Pœ€6L7‚Ä¬01UL_¯­SÌËÍÑChZ—_ºm¦½\.·YqAB4øàˆÀtªEšñFU&i¥Q¥í7¶d·¿µe5ED'hK¾·Sãî=ÓÕxš'Ò8í"Û:Ì<L@‚
ŸÍz4ê¦lÅ¦£“ğŠ†0HÀ¨µÎ€£ñÒ–é¦ˆJU™¸­zH•¶7+¶lkjjZ›Bà”'‹oìïêj¼) ²§]d±1	dí1¥¯#ÒŸXHµÉƒ$üHn¿ôî·DwA7u“M‹µ bó *“6¯¨ÒöæÅ¶‘mmCAkö¦#©:\Hà³»5´ÍÄÕ8í"Û7ÌP#P[[‹8İ8æÍ›WSSC(Ş"Ä‹F[P ËÓ­E±o‘f©æ)2c¢*-4o¨ÒBERKÂ¶a—¯Ú†r×n¡M/Êp%	5î0få5Îxt· ‡³wadYIå n—œ$ûw—¾\_İ\¬¤$8rü4é}ÇO¶X\½uâˆSF–F7äÑÌˆycj÷ËU¢:¥Oÿİg"îÂKwôUG*J’ï¿ø™ˆ»ğfP•iğóó)¼Ìı¬İêöÀ¢ºƒÇÎ^Ò.şä^JU_zL²Õ«W¯ZµJ0©¨¨>|¸t>¶ô“ÔĞ.’ŞÒ2 ™]T÷ìkd”£M'h¿»¡!šWqq êHg)qÌš×vÑäëµÎ×b	äÛgI¿‡VWW‹{($ñÓ=ThĞÍ“\UâYXUU%j=bÄ…Ä–Ç¡¨”úÅ¤·@¹-DÁ+İ®âæeTËLà¥ì¢¯Üuàˆ9äªÄÉË^ş¹5şÖ»İÑHÜR¢ƒÜ@Qa»¢‹Úê[ñ¦ÉFıG í"‰-Í†¢ÍvQc8ò×/­Ù²+‡ò[Ğhİdı?×c+ßü–ù’.è7&í«(cLZ<e-Æ(äû—êÑ©Un0?O„YKß_¤Ô=ô…¿5;èÆM¹#{gJ:l¼‡ºc©£J¥…úı#zdş8ô´]¤NQêJ··…¨lÉ5†tØe+b‰­ùŞZ_÷ô+«%=6c‹m6¸ÜEÁn]öı1ebøô¬#ÚE*èÑÏ2»Hß|3ÒŠ4†gBá3á³xŠ~/¥şû>_aoñ,©¬¬,ê=DŠF¡"êtÌ¡Ü`«¼œV¹0Š´âûTÄ¼‡V\¸»¾>Z]İAwBÈeÒ3¿‡:m©¦J5Ÿ…6ªRı‡bÌU£ZQóJ·¥…¨f©iãö~ãÔ;%{Ùk«`5íïyk]İÓ‹ª”\Ú¿øéOÏ½5+ÌƒË—•‘+Rış¯×nİƒgúôÑeb»>İ:JÙq¤ş#€ş"¹--ÓÒ»oà/‚95ŠÂ°‹°'§¾¦1ê2Ê´¬TÏ7ØäyŠ4‘Åªxu›ÏèÓç4Óõ ¡Ú÷)ÙE¸‡•’ûà´ëê¨]¤ *U{‚¿½ªTÿ¡h¾Ñ©ßB¤_é6¶uì"õŒá=Æt u†½l1†Õ°‹4[%ØE?_T=µ²ß”Š~©vxlO€UæõEååå¶‘R†+k,]wÛ¨ÒÛÇ”ë¡ÕÅ4¤”ûwê?h¥Ô0”K,lİ_ÁÒL£0<E0ğQ³‹Î¹ÿÓœª\SHìj¬]»Ú.¥ºQ¤{¢“èô}9S»¸›æ.*w5;èÊÊÊRãdwj»î¡ÛEÊ=U{½ªTÿ¡øM»HÅ¢Ô•ncQÄ.RĞŞWû¶Ù.ò“1,İ.êÖzJ‘ÀŠuÛ~şçÕŠØEv?“3ÍO<nU:}T¹¶MEô•²ËHıG í¢LÛŠÜóKZ3Â°…š]¤9‹`év‘öX×do³íhÑˆú‹à‚QÔq!“£Kú&=V}Á*ßCÃamA¹"!ƒ]÷Pçì"eU©”mW¥úEã&Ébñya×Å®Œ]¤¢1¬”ëÀFcX»Hkæ¢¿ÑüWUñY¼ú\K&.ó©×—Şz}i.šõî“Ø*¥ê?ä¯@pM©>.H·Û£æ{nÔ¢¹DÄBšü<ÄĞÕdß+Zw€gE‡:ôYv)6m¹!–4]t{Ÿ3p,9Ì!q8VBÊƒR#¢€D]—ÂDOxÊ…Z>AQU*¨G½ß ²*-ë<µ„l!)ğòGÑáèüsÄÜJ¡şN&Åª™M‡ôùTæŠâá8m®¾yÕÆ½4Û¤n} YøŒx$$ ¿kÃî‚•¦v¯)=©†êB%••	šĞ}ZãÔökÓÂ­r±Š³Åôõ3úBš b¯Á:Êâ—!ºa‘ˆA§ÏÓExìé×µµáŞCS½•½‡R•¾Qeª±˜-Ä"(#™²{ŠQÔN±.%÷‡1{.º×(Í¢dG¬Úˆ®]×«2vLğ~§]”,U“FûõZ-ğtÜ!¶ÓHs‰ğkÙıÒ h~3-à @¨’òCŞC­^
ÊßC©Jß¨ÒjERLÇb˜ò{òŠĞNÎè›)¼oëÎœ*;¤¨r°2zéĞtpş²h¥Ø(ÔK.–Çhûóh¡t—‘¶„FÄĞ"°!Ø Şdñsç As£àˆI±Ú¼XÍ]due‘®y	÷ĞÓ§O÷íÛ÷ı¸öÚkO:e´Aü4tèĞC‡©×*£)|• JeÕdE0…UiEü4Ò¸İB<}¥ƒ¯Za«×‹ŒaQUÓZl«uO;§¯tm>Î€–6eO¤]¤¬jR,:›Nëç£—¯uúñW7‡´9cº=Õ/@48ÚT	}Åt1ÊpóŠ¢Û¶m»cÇ£GÂ.zóÍ7aÚ´i³nİº:$h+3fÌe;©uY•)\ÕŠ%U_•s³…x÷J×í"t˜h§vùÌÖ]nŞ½Ò…{¨)—'Ñ¡r´‹Ü¸\(C_)£y3u›(¢¯Ÿ1<HÂ”í/±…‘n:jQ*tOQÚšÑ]»‡š¥„;¤iÓ¦ş¢Ç{lÃ†H¶sçÎQ£FuíÚUø—fÖ¬Y‹/îŞ½ûSO=…/½ô’ñSÚ•·~¢î¡ÒTi£
)½ J‡8Éi!ŞºÒEOÉ7&Ã¯%_Ã¦áÑô»ÅIæµ+]bİ*½‘åôa¹r&í"W0»Rˆ0‰š:ë2®oWª™Y!:İ"Jûz>w¢[Œ?ÃöLCCÃäÉ“×®]»zõê…(F=wî\|üõ¯ıÃşp×®]p.>|¥ıèG“&MÂ÷á‡†Õ„sñŞ½{SÊáCé{¨ûªt˜¶£Ù+­J‡jîrñò•ø©…Ğ¶tIùÊvqŒ§¯tÜõUE.ùÖ,5D[Ñ.²§™éÖQSês{o›pñ03=ô›‚ùX‘Ãğ¹[¨W¯^æ±‹ë¶mÛvïŞıî»ï^sÍ5°`D._¾ÜœlïŞ½†¿vT}}½•Ò3L£ş=ÔMUfSîéê«Ò!>®µO_éšaä‹áT®#?Ã©Ô;³´^¿Ò3«½êgÓ.R]C”’€_èúë¯úé§'L˜ ŸRii©ğ;çb‰<E"“qãÆ	ø‘’æÌ$@êà•îš.h[DícØbe]KÆ+İ5ÔÍ¢]$>‹&ÛÜxã/¿ü2&ÔÁw$œBEEEû÷ïÏÏÏïÒ¥Kee%Ö6¬¸¸X¬/B´WæÑÙVAÅ3r!Ä9ü ú¡×—wÅã•î]İ¥'9»ÈéqóúY¼Òeiv‘,ò,—,ˆ	:×­[·eË–wŞy8Ùül<x0¾üì³ÏàÂGÌ£ƒıóä“Oâ#Öáñ^üŠÄ–$`"kÜ1ÔR(B¹á­qbªøx¥³e´D€]d?µ^éŠk“v‘â
¢x$@Ş#àtˆ!Ã_`Ğ?(¼‚Í÷¼òJJLş%À.²uËšy• í"¯jr“ 	(EÀıCXK`ğñÇá…Wğ¹çÃ3á]äA$@$@$˜ í"¶ iíüê´´âm-ØıC‰®Y³æ¿şë¿ÄüI?©Ò\YX[H*UÎ6>¸Ìie[£e}I@	ùãÚı÷şé‹;)!óB8±~ºy€A~ÇÏ~ö³ßıîwÎW+…ªtªŸŠ`ñ“6SªËÉ3şùJ©âY˜Ø7—9í¢,l½¬2	È$ Ñsïí~hñö·6>òíŞpqg¸~Ú˜ª7uêTäõÕWÇÌËËáğŞ{ïuìØa	cÃ!}g³*Bê³lÙB|¦PëÕ	…#¸Ã?øêöìùJ
'&l)öÒ:t¨s÷ç¤òØ•Àg—9í"»ó!§àfzë­·:u
x:àØ–='şã­ÿºdÇšíGñÔtŠ—Œ|]X?mDÄÂ¡%K–¬[·Î6h0h„KŒ«ÉlGâcUÚÎ*A†pëuíÚUDÈ@$ıÌ‹V'€;[HæÚônl;‚‘/Ì8rªÑ»µpBrsØÒÿşïÿ·qã±î¹ç»//sÚEN´|æéë×¼¿ñİWF´ß½·fEMMÿ+œJäÓ÷^œ¯>Y¾eÃ‡0ÖÕ›ıFıœ»6ï9‘JNn¤¥*Pö–*j.µØ07İtL\˜¯ûÛßşüç?§·¥˜¹/ÕR w‡È [¶ôØ>òÈ#‹/çâ½a#ÂäÿøGïºp‡ÇÈ×®ÚƒYUé‘‘u–C—y‚ê£FÑÂÂB´Šîİ»£=`ĞdÆŒ}ûöÅ É-·Ü2yòd_ûpƒ)Ó¦M3'ÃG‡èeÕeN»È¡VÄl}N ªªª¡! ^«V­Ò7GwûÀÓTŒ4‹›ãøñã…Oé±ÇC+æv™`ãQÛåóÄ_ê_¨Ş³«…ø
+¶~`Q]â—íš3TA•V0“ÌÑ¶Ííü‰ÿÛ¡*½è&Œ	Oó¹µµµ}úôÛˆÁ™9sæÛo¿jg×¾Ñ©B_Jô´>şøc×zN6^ìvõD>˜Rûúë¯CT¨léÒ¥›6mÂ{˜¸ï¼óZ…p#ÄTDqgÂ®Ã§ŸZ¾3<JÇ¡Ë<F‰æ°¥ˆ*~5âˆbf(*âå ÜèêÕ«1h²yóæ›o¾¿–””à)¿k×.¦à#î¬®®†9˜GŞØJÒKÆÆË\ıG í¢¤í	H@>t¡°V&Æ“°[+B´1Ü8€û#™,Z´¨¹”æÛåo~ó›éÓ§‹ØÍ÷İwŸ›±›;›€à‰¿‡ ñK†Õ)_é
J`—*ƒÁ ‚µsY¤mÛ¶a˜QhÏ=Å{‹!‘láÂ…F§Êˆ=ˆ‚û='!|&-D©ËÜiïAYY Ö–à~×]w¡ƒ‹÷°|B¡ú¾Â_3¶e6€Ú¼w™‘v²1ËÊ¡^rŒ÷ JÿmõŞÙËê?ßÒå‹ÈsÅÅ„-M,?VŠB‰°v®ºêªŠŠ
¼éÑ£‰ğø”pˆ_İ’ùe®ò#€v‘;­ˆ¥@Fğ&Æ„°#òÂ3ÕØšã‹ŸşyóÌ·KK‹çèƒ>ˆ;lFÒ¤xrnN¢NpAëÜKÚå'~±"r§’g®Ê\ı™s~+>z†!$´…+Z¼±ØêÕ«WAAA\MŸ={VVÏ)“¢Ôeî´†Ğw¾óØ30n¿õ­o!>
üÿêß¿ÿùçŸo¨Õ<¶…†3'š÷.[¿~½a'#1ËJx#m?š{Ö×m©”Ä3Ÿà$œˆ#j~ÓÏ>ú¨´´ÔÜ°]¿I3Ìä2WÿÀ‡SÒÀ$‡Àˆ#Š‹â3ÃıÁtªÄÔ[·n½âŠ+Ä{Ü^·oßŞ\â—_~ãÊÎ-Ä7—çÑK®,¹ ¥f4¦_áüÉ½¿m‚ÒUéhí2ÌmÛÜÎWœ¡*ò!Rë</=zb dˆÔ8ı²Ë.{ñÅÅˆ>ÆøçÍ›7zôèô:CF§Jœ^²k='/v»Àz%,#ÁÌÉ/¿üÓêêêêğ1¦´ä
ˆÙ»3¯;yØ°aJ)æW»ƒ"qÄ3Ä¹*ÜºÌ­¨Àˆ#úôÓO‹€¢	¢°Cœ°¥VÇJş™§±ñ2Wÿà¥‡Sæªe$`+‡ıãÀë§TérYù˜òòr»²µ~FŒæ†††‡z¨_¿~".ó¾}ûšçƒˆv˜†acä«¢È Ê‰€sqéØ~ƒ¯†/è®k/{l|ÉEçÆA­×Ôé”ÒU)*%B;ÆRl|3A?œ®~âü½¥J‡X9ÔBºuëö‡?ü} èıÒK/ı—ù—£û	:CF§ÊèKAkÂ9ìBÏ‰-$íV7|øpØB[¶lß3àçÁ{´Šš`óŞepšÏş¢n¸Á– ‡I+ˆ;|‚4Igt¹¨õøÒK’–ât‡.s³Ø1aQÌEQL…5Ş %`Ò;NÇ±ŞlöìÙ×\sB/ &Õ2dÙ²ebb<~uÈC˜U—9í"§¯5æO™ÀİŞqã3ß"ˆÌXc€ŸÄGÜ+±r7GÜUÍ·Ëwß}]%ù
‹8E„7®…mÛí'ßîÖíâ6n–ë‰²`a’z†´°ˆ`Êª)<Ui—^0º!Â©ã‹°Óè×>:U¢§…!g÷{Nf&>h!.¸‘;wî|âÄ	LœÃ½7vL:ÀßQõÍ°y\§ÀChğ7ÖaÊ4V.ÙÕVÍù4÷Üymç®-ÜØ“ÎøÙ÷zëÑâ„'äg¶ğÁe—í"[š3!Õ	`z†12>·›qÌhúw.ø·	İÿwEç´R™‹òÁõ÷é§ŸšDøfº(BÊEQ•)#Ë²<İB\ğÀÎA¼-C¼#\†!fl£]†3Á0†ÅXŒjcL8‹2ã=Àj“¡%íûnÉCcºBéYÖÌ³½º¾Ìie{óeı³™@ó‘i‰4®éÙ~Î¤·]UÔş¼<‰b°èÌ	P•™3ôwl!şÖ¯¹vı:`F F¾àÿI¼4?{˜dIMıt™Ó_”%–Õ$µà©ùíş…OßÜcp·vjIFiR$@U¦,ë’³…d•Ê1SúÊ.ùÂ>?—ù³Eù¾¹ÌieK“e=I@Aç·Êår#õ’†HTeĞ²ê¶¬R7fJcFÀ‚©—sä+«ôîƒËœvQVµXVÖ·fÎœ)bÍáo+éßŠ‰`t8cÆŒAƒ¡¢X6pàÀ•+Wâ{ìáëßª³fV	 Iˆk­ç<óÌ3â£ô …V+ÀtÙG ]|¥¦u„$×5.pq&îÿ|
¤1³Ô´‹2ãÇ³I@è'Õ××‹µ¶/¼ğ‚Q„Ô î‚—L`@Üã¬K-;¦öôM{,X€úış÷¿-{×K‰	€×	 ö¬¸®1L&Œ¢9sæÜyç^¯—‡ä§]ä!eQTˆO ½j8Ğ7Â=täÈ‘ÄD$à3°ï¿ÿş˜Jázî >«/«†ë îDxb6:#+?Àˆ˜¹:¸ğc¾ñSeÕ¬í"5õB©H 57nÄ´«1cÆğš8¦&OÀpò½÷Ş‘áWÄõ«š=U
k• ¢o×v6³ªÄGÜíŸxâ	«¹0	À$6ogçÁxXdÚEVE'A ÃÆØT<2å„C$à3X=ˆİ~áÒÄ%kŸ+Ğ|¦è˜êìÚµ{õ_îÛ·¯{÷îş®r6×—3†?šû‡³™‰›u§]ä&m–EØ³g1}®¤¤OMGŠa¦$@ò ¾ÂÕW_DÀ5n\òè"ã O.–ì Da“è„ŞE°Îp¸ì¬á)Â‚"Îû¨ÚEá³h°‡ ™"pô–¸Lß¬Ì…”!€Ş®q„+—¹¸ÆÅ{£Ó¬Œ°Ä6˜-	— ìau>Î°®’á7æ¸êE0:„S‚1ÌÈ“îhŒv‘;œY
	8K@<>qÌ›7ÏÙ’˜;	€ëŒ¥&â2GùFÄB-»®·ìÜ¹sL‘˜à¶,Ïâ®zŒ€y¥»¢ í"w8³   °JÀØ¢
¾‚ùóç‹EeâøÁ~À „V92	¤B€vQ*´˜–H€H€H€œ'`ÌšƒÇ Vy—3.Êw?KÈR´‹²Tñ¬6	 	 	 	 	€A€v	 	 	 	 	@¶ ]”í-€õ'     ]Ä6@~ PSSƒHtâÀ{?T)+ë@=f¥ÚS¨4[H
°˜”<K€Wº,Õ#‘ˆ¬²Y.	x‹€~­àO0œ…W¬ßöìkï,+©ÔMzEŞ]úr}}ôZ..\Ó­Á`P¢TŸl?°¸zëÄ§Œ,ÍÏê¯œÜÈ!Smúï>Ó¸/İÑ×–J)«Êw–ü±¡!ZEèqÔ„Ûl©o&™Ø«ÊÕ<vö’vùó'÷ÊD*§ÏU¶…¨v¥CvµÛ/óTI\¥O­ì7¥¢_ªYÙ›¾¶¶vÕªUúã'RQQQ^^noşiä¶²¶aÁÒuvİáÓÀ–S”½ÌQ;Õv]æê?hÙrq1“¬ ĞìZ÷ìk(Róí÷44œ³‹ª`¿™v‘À‚§æäëµÎÏÉËQÜ.RE•#Úï6ÛEUGº(ÒÀìR¥úE\Ù‹]Í+İ–‹]M»H…‘/³1\R9~ZÊcKvßGìê%Û-Wjù){™£j>2¨ÿ ]”ÚUÄÔÙLÀ|mGşúå¡5[v…ÂáP$	GÂZgJÿO†ArbË
³¿¨ ßIÎHÕj;£s‚ıKŠõèÔ
Î¢<Í4RÓ_¤”*o~ËlµíÿmyWœ#ªTÿ¡ØÜ.Rª…(s¥k÷;{/võì"e‡K”ö²Å–w‹şPê2‡pÊ<l¾ÌÕĞ.’{U²t/vQ8G"¡Hc8p&>Ó>‹÷¡è÷²ê³ïóõb¢L´ètÅ•²$A¹˜.—äéÓçZåå´Ê…Q¤}ß«3NAU*¥G'T©şCÑl±…$½Øx±+e)ÕKé"Ëö²ßNÚÀMÀgºE¼6^æê?hYlLFÑ©5è*áfŠ§&Ì¡¨Q†]Ö¾×§ßèÿféñc¬‚í£ÛEbúœfá/Şã'Õì"ª²¥–ê*Õ(ÆØEl!®µEì"5áªª*±¼²²²¨÷¹{Ér+bØE¼Ì]»ÌÕĞ.’{U²t/%ı©@èİ4
ÃS	u{Éc"m²ÔìÌšÓÌ!=â‚˜D‡/u»(åÀ¶w˜¨ÊdÍÃ)UªÿPl²‹x±'n#ö·Û/ód<öw•{ÉÆ³EÒé(+‡†KRÕ”]éù HFÒşË\ıG í¢d­‚¿“@íÔ.Í4
Ã
hv‘æ,Â7º]„”º¯(;]Fº£H3Œ„¿cŠ0Šš".rt»H{¨G"©>Úmï0Q•‰/kçT©şCñœ]Ä‹½åVâD±ı2OõÙÅ^r2bö÷’“•èìï|¸ÿ Pÿ@»ÈÙ«¹û‰€¸‡ÂèÑ­ Í.
i#!}q'Ñ	]›ss57QnÅ¢#½7¥Œ]DU&}(³"íR¥úE³]ÄâfQÂ.¢1ì®1,·‡Àgºşö>ÓÕĞ.²Ò*˜†¢Œtğ	ëHL«ÃG±¨HqÌÎItÑş¤ği.£¦‰sÂ"ÂÇô6/BnNt˜¨ÊdWuÔ­g¯*Õ(XØB\n!N\æÉªğßÙK¶‚ËŞ^²•MÃË<^›ê?h%küLÌNá Ò-"Í‘Ô¤[Y{ˆ‰â?-¾§fEgÖ¥é,rÌ.:çı£*ãµWGT©şCÑd±…$¾ÙÜB¤ÛEúÀ–øäÈWº·¹—,ıIÉgz2Ø|™«ÿ ]”¬Iğwø&ã6ªw¦ÅcTL¢‹®>Êr`Æ
"á6a¢.¤ÔgĞ	˜u˜¨ÊÄmÕ	UªÿP43aq³…8t™§tCf/9.›{ÉÉŠsãw^æn^æê?h¹qÕ±ŸˆÎ•‹FÒ."ô ÏÅ¢óYmÓª ¢Dği¶lGİ<Jçp®ÃDU&Õ‡½ªTÿ¡„-ÄµâÜe´
4†­#rb¸Äzé¥äe¬]õìÌ%mL@qD×éQôŸÓíòû™®NF¬*‚u”¶Uä˜¿H°§*-´AÛT©şC±9¶wZˆ"v‘~OĞïèùjYñvõ’-4-—’ğ2· Ú†ú€ ˜„H –€67ŒFQ’v¡ÛŠš×(å‹ÜlpT¥ÚŞP¥…Š¤“„-Ä5_µ¦{»Ğ|DÛ`@Û{@Ã—N@lÆ -"ÕŞŠİ,4…“ğ2· _]æ-Õ—v‘…–À$$ĞıNªÇà+>èÚ"õ[U™¬{F•56¶¬j!ì%[¸|ØKæeU—yÜFN»ÈÂµÏ$$@$@$@YF€½dö’³¬É³ºÚEl$@$@$@$@$@ÙN€vQ¶· ÖŸH€H€H€H€H€vÛ 	 	 	 	 	@¶ ]”í-€õ'     ]Ä6@$@$@$@$@$íhe{`ıI€H€H€H€H€h± 	 	 	 	 	d;`$Év¬?	dL@úu´zõêU«V‰zTTT><ã:eš¾º=Çôß}†ò{é¾öä˜0¹ÚTP• e—6XTwğØÙKÚåÏŸÜËU:Q›Gsª¶4—/s'Úóô¹—90*ø °å2Wÿ@»È7W1+â6¯ÜuàHÀÔù·ÍH½*o,üm}}tŒ£¸8pãÔ;sr¤yƒ±–¢ÂvEµ"ŞO]è0©£M¥T‰–h¯6Õ(Æ½øØ<Zº'ÙØ<\¸ÌS¿³òŒ," ÎeèË^şMCC>éão½[¢&l¼ÌÕĞ.’ØÒX´W	è#IÁ·Ö×=ıÊjEêPqá³]Tuä²€»6ß>ºìûcÊ4Gv[Mß:r´Ã¤š6ÕT%ôg‹6Õ(Æ\Ñloq™7G/s‹µ`²ì$ Úe-Œh¿ÛlUé¢‚j2¿ÌÕĞ.R¡¥Q/Ğn ZG?òÖºº§U(¹´ñ%Ò+°¯öm³]TT:J¢¿4ê÷½vëÜC§.-Í“¦CKÏqä\‡IAmª¦J{µ©şCÑ|-³yX¹³Ùu±;w™[©Ód-/sèboÍ
³]tYù¹
²ë2Wÿ@»HnKcéŞ# ¯ÈÓşÀ.úù¢ê©•ı¦Tô“^ššóú¢òòr¹"­¬mX°tİm£JoS£(j¥»JÅ¹“‚ÚTM•hH6jSı‡â7í"å.v7ç.s¹7C–®8Ÿ ¦Ú•n×S@ıG€´Š_'âĞ–´IaÚ4"q=Q¬t0„f6Ò"C8@
‡5VÚKsáB^ÔÔ¦šªÔìµµiû-‹Í#%¤ÙÖ<R‚ÃÄÊPó2.5Ùp™Ó.Röj¥`jĞ¬"ôíÃ‘@H¥.¾š°@©1…#x£[’ºm¤ĞAm¦ åµ™B]¬%eó°ÆIO•}Í#8Lª0^æ)('.sÚE)4&ÍrMKb"vd9¤Õ‡#ºQe¥9”qQ›IÕ“@em¦Z—¤éÙ<’"Êææ‘*¦W“ /óTõ’OÚE©¶
¦' ğ|Ğ,JÚ0¶$^Q_‘ZÎ"!>µ™TÑ^Ğ¦ÕºXNÇæaUV6«p˜Nm¼Ì­ê'.sÚEV[Ó‘@t}Œ¾V&º`†PÀh\Ô(Ò#mpNq®6İuå¢6OŸ>İ·oßôãÚk¯=uê”Á?:ôĞ¡Cj‰/…ÚÚ´œÛÍÃö
¸œa–5—é²8‡H¸Ì=ı È†Ëœv‘C³õ3D€³è’êX[ˆ¥Ï£Óq)
ÌMm¶mÛvÇG…]ôæ›o Û´i³nİº:$@ÚØØ8cÆ‰¶“'´™´M¦šÀÍæ‘ªlJ¥ÏÎæ¡”
(LÚ\¾Ì½û È†ËœvQÚ×OÌfšÛé’¶ áj2‰q5—Z6a ÁÎiÚ´i†¿è±ÇÛ°aDÜ¹sç¨Q£ºví*üKH3kÖ¬Å‹wïŞı©§B‚—^zÉø)©"lIàmÚRWs&rš‡íÕp:ÃlmNseşîv™{ëA—9í"w.9–âçv&U¶Ÿ¯l}‡´&Pémêêhm\ÖæñãÇaØÀihh˜<yòÚµkW¯^½páB££G;w.>şú×¿şá¸k×.8—>‡Ò~ô£I“&á!úğÃÃjÂ¹ø	GïŞ½…)åü¡º6m'àró°]~w3Ìºæá.^–æ÷/s/?ü™Ó.rêJc¾ş& ££a”\Éxäè«ŠD'*àš6éÂêÕ«WAAbYYÙ¶mÛvïŞıî»ï^sÍ5°`D._¾ÜœlïŞ½†¿vT}}}rMØ‘ÂÚ´£¢ßÈÃµæa»ä.g˜ÍÃeÈ,Î!n^æ~øş2§]äĞ%ÆlI€H eğ]ıõO?ıô„	àS*--ş¢±cÇ"/,1‚§Hd:nÜ8á/Â?RÊ%ñ  %	ğA Q-´‹$ÂgÑ$@$KàÆo|ùå—1¡¾#á***Ú¿~~~—.]*++±¾hØ°aÅÅÅb}¢5¸5Ê" pƒ nPWí"YäY.	h\Ù‰"n½õV:qL3üzûí·£“í‰°Ñk@1Açºuë¶lÙ²óÎ;1ÿ›AçŒ/?ûì3¸ƒğóè`ÿ<ùä“øˆõE8E¼¿"±çhd•Àî\æFxDéH€×¸Ì³J¬,	(B€EÑ’´‹WÅó?CvZ	íÅ°†$`.s88€Y—yyyt!Ú§:æD$Ehe‘²YUõ	¸²WÌ å‘GóµöíÛ'¼Xêo3ª¾6)!	Ä%àÂePãÇ^b#ø»ù2G‚˜› •E$@$@»ˆm€$p!dgmmmÇÈfXšb ıÆoÀRÂŒ,„AsyÛĞ“gB;¿:-Y,Ş&Ôf®]æİ¸ï¾û®¼òÊaÖ¬Yc¾ÌKJJÌ7.|6›®3fCêğÁeN»HİæEÉ²„€!;Å#²ÙÙ³gÍ ëêê Ú˜~#Ş¸p„Â‘·6~ğÕívs¡8á(j3)^×.óùóç‹-°bÄ7_æXeÔRø¤uI5›GªÄ˜<GÀ7—9í"Ïµ=
œulÙ¹~ızs hì¢³iÓ&`EWI¼qúø`Û‘‡oÿãÚıGN5:]ówš µia».ó©S§b€×¸
õöíÛñ¦gÏæËü£>Š‰oK-šgÂæáXfKêğÓeN»HvEIH Eö†ì,//7€Æ”›P(„Yv˜_‡`hªaóÿºdÇ®ÚsàèGR*ss8²æ‘µÓ[Í%ÎÂÔG‰+Á²S›Î5-[.sE£F‚¸_¿~˜=k,Œ¹ÌÃĞ|p¢RlNPe"`¾ó[ÜP;Ô+SªizÏ‘”Šˆ›Ø—9¶¢WzúÌuÆHÀ.úµ‚?Aø‹Ï†Â+Öo{öµ÷§Vö›RÑÏ®"|“ÏÊÚ†K×M1pÊÈÒüÜ ^ûœyeİß¶î;ˆÁsX~	^‰+>ıwŸiÜƒ—îèk"÷µ‰çÖğáÃEÄíÌkaon‰å±Q›,ª;xìì%íòçOî•9çrp¿y8W§s¶«y8q™;]wæïiN_æ¸KßqÇ/¼ğöcÀ?ìÖ½yóæÄ÷ØE÷Ş{ï+¯¼"¶pPç°ë2Wÿ@‘:­’x‰Àú5ïo|÷•íwï­YQSSã%Ñ—@>}ïuÀùê“å[6|ˆ~ğo«÷Î^Vÿùş“ÎN	îk¿3f`Ãl5#Æù>şøcñJbÿ™˜Mo°—Qó b.ŒzN›é´€„ç¸ß<l¯‚s²y8Ç–9»IÀéËs1~úé‡z¨¥@‘¸ó/^¼U>yòdïŞ½ğëŠÆƒo¹å±DğÚk¯EäÉ–#¶0ÌªËœş"[Ú3É
æ±¥§şı‰úú¨¯µ¸8ğÀáÎà¡ÀÊo3œ]niì@7œpŒ¿¨ uîù­’ĞÀ²B¶Îù‹ü·Ç¢Êƒ6gÎœé„&Í<Şn¸á†Õ«WcìP|ÿ«_ı
+C0L8hĞ H)væÌ™U«VaW<1v8iÒ$!VŒÜ}÷İ?şøÄ‰_ıuüµË·Ööjóğ‰F¸[½å/r§y8Ñä\ÈÓÆæqèøYÛİÂ.`Ş%`~¦;q™›ıE „;ù{ï½÷ÕW_	wè7÷ùgŸ}váÂ…#×_½ñ øîw¿‹S{î9ü„ô˜;kÖ,<8Çóáñ¸é¦›Äó?Å}Ø²ë·—¹ú ú‹¼{ESrğôƒzâï!˜=‰_âtŸÍùE¸‹‚‚38‹p`}H=ğ=¢Š‘Â|°¢¢ÂÍ b	ô•¡6Åé­óøèñÆÅ›ª”™4Ÿ]à©¢cúl pÅWÄTÓi|o~ìİ»×ğ!Î$¶>«¬¬ÄhW]uÆó"îé!Íä2WÿÀ‡“CÍ†Ù’ 	D	À9€üEHø•®¸W_}Ãˆ®¾ÿ~<c¢Êj^™k³ËE­Ç—&YQ&«v,7C™4ì¼Ì3ÎÓ½B  §zêºë®7ÙREàSÂS@˜8§B}3¹Ìq®â ÚE*´1Êà=#FŒÀ„+ñÂ˜¬ItXÇ)f‹©_XÙ)>3•¥óè%w^Û¹ëÅmâ
3¦_!–à'~‰ë6AƒfmJÖ¼Ğ›o¾S&„6ñ@5ÜGˆ0KÉ5!m×æÏ¾×cX\“?ó‚ThæKÛ³ŠJáòÇ‘y3ÉÁÆæ‘‰<—2$àĞenlªşÿğ˜ÿ6dÈ˜@‘Xw„H°-=µ¯¹æãW1:–a5Ó;İÆËÏzÅ\_”^#áYÙHÀéØ5™0Å¢”eË–íÛ·oÎœ9K–,É$+[Îm»&?7çó}'ßÜtpóî“Ù.U°bö9f‡ÇLRO5ŸÌÓÛ«ÍÌåq!e/v¬ÌşğÃçÍ›‹èÖ[o}ùå—¥_ïv5Æ£s¡a³3e/sÕd×e®`ÕbD¢¿H}QBHN ¾¾£JÉÓIMÑ¯sÁO¾İíß&t‡» 7‡a*’(côèÑ˜JqÄK/½`ÕÂ¶R›R.&ìX…°„(æÆ¥È`¥P6+”˜†<MÀ——9í"O·I
ŸíŒÙ5+V¬,V®\)<òøIM:İ.nsOe—9“z|»!ö5RSH¤Âü
cZ¹ŒNÁÌ2P›®iDLš­ªªºÿşû]+4Ã‚Ø<2ÈÓI@}>»Ìi©ßä(!	´HÀè:cú&Øa&á•Áu¼ ÕmW-˜zùàníT–“²Y!@mZ¡”a8ˆ`'cÿLšÍ0+—Ogóp8‹#÷	øæ2§]ä~ãa‰$`?’’s¦{öì±¿rl×&CMdÌ,% 6]€Ş©S'Jq¢6'¨2OPŠ€.sÚEJµ(
C©ÀÈ±˜5‡õE˜jõÌ3ÏˆØèMújìÔjÂÔ$@-€7X\Ú|şùç‘Óêğ^Ì›UvÒ,UJ$@Ş"@»È[ú¢´$ğŸ~ú©X‚"¬ ,<0V¤”çˆ¯1KJ|Ä!‚°óÈfõ0.mL—
1­Nâ$@¾!€Û¾âK…}ƒ:¦"´‹üªYÖ‹HÀKàëÃª0ôqG	ç€]ôz”ÙK5¡¬$@$@{”áæ¯şRáj©è©´‹UÅ"È*ğõqÔ?«4ÎÊ’ 	@\ØuƒÃa²Úí"YäY.	 	Ä!€#FTn1®$’" È6¯¾ú*BPf[­åÖ—v‘\ş,H€ÎÀâ¢eË–‰ÏÆê‘Y³f‘	 	@VÀˆ6qæ<—•N»Èeà,H€â€kFfP˜Íy 	 	dnÇC›8ûF5´‹|£JV„HÀÃÄS‘—a!3"/q™±ôÖÃ£è$@$@©Àıÿ…^ÀLñàèX*ğ2MK»(S‚<ŸH€2'€U¶ÆÄ9„`ÆÜ	FaÎœ*s  Ï0ßÿñ ˆ™Dà¹êxK`ÚEŞÒ¥%    °Ÿ í"û™2G     o ]ä-}QZ     û	Ğ.²Ÿ)s$    ğÚEŞÒ¥%øjkkçë–ï×ÔÔ“w	P•ŞÕ’³y¸ ™E€tx‹g:>ÓİTG0‰¸YË"ïĞ¯ü	†Â‘³¡ğŠõÛ}íı‘e%•ƒºI¯Ô»K_®¯^Ë%%Á‘ã§ƒA‰R}²ıÀâê­Gœ2²4?7¨¿rrs „LY´é¿ûLã¼tG_»*¥¬6US%€Û«M»4èh>lÖñÚÕ<œ¸Ì­×‚)³€²—9tñÎ’?{×aO»Qn“« ».s¹µ°R:í"+”˜†4Íî¡uÏ¾ö"hF´ßm¾‡VéóCºl°‹&_7¨u~N^úv‘*ÚTS•hKviSz³´"€²»›í"+-“il$ ìe:6»Ò»ØXñ´³Ê†§ í¢´›OÌ:æ{hc8ò×/­Ù²+‡"H8Ö,'ı?ÉñÍo™í¢‚~cRvÊØ£ÏHÕ0C7˜ì_R4¨G§Vpåi¦‘²ş"¥´©Œ*µí„6íihç¢ìÅîãæA»ÈáFÍìc	({™CĞ˜+½mÿoKÒ_Ö=hIji,ÖƒÄ=4	„#‘ÆP¤18
ŸiŸÅûPô{YÕÚ÷ùúªª*1-¶²²²¨÷Y’ \L—Ë	òôés­òrZåÂ(Ò>Šï•šG§ 6•R¥Ú”Ø2­­ìÅîãæA»ÈzûdJ[({™£v¸ÒW­Z%ªYQQÑéŠ+m©rz™ØşLOOwÎ¢]äg–âÆ=oàa€95ŠÂ°‹ÂèaÃ(ÁOú¿c­ $O‘Ve¸°
¶n‰ésši„¿xŸ´‹Ô¦
ªtN›®Ô‹Tùb÷kó ]”z;åPù2GÅT¸Òz¦g¤6‡O¦]ä0`fï#â&¥{½ ›FaxŠ` á£fc"mğÔìÌšÓÌ!=â‚˜D‡/u»(åÀNt˜¨Íd-Ä)m&+W‰ßÙ<’©ÁşæáÄe¬ü=«	ğ2O¦~û/ód%Êÿv‘|P¯Ğî¡Aí’ÑL£0l¡€fiÎ"|£ÛEÚVY.#¹$uG‘î3ÒıEğÁ(jŠ¸ÈÑí"Íg‰¤êÑr¢ÃDm&n-ÎiSn+µX:›Çÿ¿½ûª¼>>“DÚ¦¢±R’€,5 ¬¬”HÊ?eñuñË‹îÆºîÿî©ûâ»¥‹íÖ](âBwßÚ?îñ°P8ëÂ!]xMJNR‚ølA&¤ "Gş23ïïŞg2Œ3w&÷Ïsç~¯sh&sïsŸçóÜ_zó<÷^÷'ÂÜbw³Z0s÷Ã\ÿ#¼Hÿ>¢†º¨¿¡’ô˜Y‘EãQóâ"o'ÑébôÉ©tùùÆ0Q~XşU™'Û:åEôfÚÿ_LNŒ´«7õ9V{¨	Án¥›RçØôşğ /²bÎ:6
æV0ís+{ôvò"oıÙ»Ï’·¯‘ñ"•©iuòV]TdËsêÊÄX1dÔ5qNeDò6»‡I¡0Ñ›éÂÏ‘ŞL·S]>çğH×6…yºVğy ótİos˜§Û÷Ÿ“yßÔÀG©_/©"3#2’ºnÒ-­	t^d¶_ıgÜßÓH‡3ë²,r2/º4 Ho^.Õär›{Ó/ñN°§ë)›ò¢tà|n¿ aÎÔæ0O·;ï?'/ò¾¨¿’FÍ3iõe“šD—¸úÈ_Í±½¶É+ˆÌ;r'nÃ ~Îbªs'LôfÏ€½iû!ç\nÎ…¹sG%ç€ aîf˜ëÀéßGÔP;Ä\¹ÄİçŒ ’ÓÇK÷¢Ó®¾TH˜÷WQ#ãt’;ï²Z=a¢7Óö‰½½™vwZ­Àá‘¶;ì:<ó´­`… æi{ß®0O»#ÏWàdÎó. ¾H\Gd˜Èö”ß—­·XiSF]UÔuİ‘Å-»­æô	½i¡_lëMûÒkıaÃáát˜[h«W€0·Ğ÷6„¹…½x¼JÇûg÷øS@¾;1ÇBHŠzè?3W4F2~`‘Ë½iÜ7½i¡-™­ÂáaÁ+¸‡‡Vñ an¡“æäEVAà3Ì¿¤æ}x]^@¥şXèÍt‡±ŸzÓöcÃƒÃÃöƒŠu Ì	sò"İ¢’ú €  €  €€ÛäEn‹³?@ @ ĞM€¼H·¡> €  €  à¶ y‘Ûâì@ @ t /Ò­G¨ €  € ¸-@^ä¶8ûC @ @ İÈ‹tëêƒ  €  € n¹-Îş@ @ @@7p<×­NÔß	xGõõõâ&5©¬¬œ4i’ç†6>ÑuÁÏöÈ*yŞÜªË=o¸€·Á®a¤Ëñ`K°æ,š€äE:ôuğ¥À‡§Î¶;
_ª|Ên·èWk~‰$¾ã(+Ïšû`^g£ÁÉïZŠ‹¾¿$k½<mâ„Éíã‰ı}R@Ÿ`×*Ò/bº zì„9a‡ yŞTÀæÆáÍ-û–®İ¦Ií+?w(IÔ¥´4Ôpò‹¡gyQÒäşéc˜1Æè1Î²Ï8aÒä0`5tv=#]ŒŞ;aÀø¢Éè&@^¤[PİŒó$ãD?¾¹yßÒu·”]7²t ç•îh­kk»”WLóp¼Hê9úQÓŞÃrª´`úÑ2FÒL´ì8aòü f4vİ"İÆ`'Ìƒe´­È‹´ê*ãóŠ<ãÉ‹~°®q^Õˆ¹•#<¯wkkkCCƒºò¡ªªjÌ˜1ŞVië®¶š¿>­âşc%)J¤FÙ^†À	“·½Ø½kìºEºv;aØ@£áè#àıL},¨	iÌïIaÆ	SÜÃë‰º×tìØ±=öØãæâyR”¬œ Åb†•ñ2†ŒŒÛB¤EftĞ3ØõŒtã»"‚]‡£–: €@ïÈ‹zçÇÖ0²"9·ÅCQÍNñeâœZôéQêŒÅ¢±¸ü`f’fnÄ‚€?4v#]ú“`÷ÇAM-@ GN¡è)4èúşXM¤3Í+ìyõb±¸™%¬ŒA#†Œ<ï*`A€`·€ô‰UöLÅX4 /Ò°S¨’æa5òAZ”¶Ÿä+dõJŒ1X”–Œô Ø­öÁnUŠõ@@cò";‡ªi'`v˜×Ê$.˜q¾†çÏŸ///¿Ú\&NœxîÜ¹ä>å£qãÆ?~ÜùZd¹±J$EfbdÒ·8Ï²86CÀ=·ƒİ×‘.İB°»wl²'pL€¼È1Z
Î]u×fÑõïßÿÀ§N’¼hãÆI×~ıú577_{íµ=HwvvÖÔÔx•;b™óèL.×Àr÷È£e®¸ìşt3/"Ø]?:Ù!Ø-@^d·(åBÀ˜]ãÉD:I$Ï‘¤ùóç'Ç‹/^¼sçN©ÑÁƒ§M›6xğ`5¾$ë,Z´¨¶¶vÈ!Ï>û¬¬°jÕªäG.t”êJ‰&rœ]Ø.àM°û+ÒU”ì¶|ˆ .¹Îî|/péÉ¤nçŸ9sFÉgÚÚÚæÌ™ÓÔÔ´mÛ¶5kÖ$)§OŸ¾lÙ2yûÂ/<üğÃííí2¸tâÄ	Pzä‘Gª««åkáÂ…’5É¶ò‘,Ã‡W©”Ã‹ù„´.¨ìêêp)Ïp9ØıébH°J à{ò"ßw!ğDÀ¼K‰QrvÊ…†VXX˜Újy`Ñşıû:´eË–	&Hî$ITQQÑ¦M›RWëèèHI‰D\ “3Kóª"&Ñ¹€Í.p-Ø}éFbD°;r R(¸'@^ä5{BÀ!š:uêÒ¥KgÏ-cJj¼hæÌ™²G¹ÄHFŠÔ®gÍš¥Æ‹d‘q$‡êC± à„ ‘î„*e"€ Iò"rAà®»îZ½zµL¨“±#5(T\\|ôèÑ‚‚‚AƒUUUÉõEãÇ/--U×Éİ\™G—¶´}ˆt}ú‚š €@î	˜‚Y@À‚€º¬X.—‘g•^ŒÆêZö¯|yû¼ªs+GXØ:X«lİÕ¶bCó=“GÍRQ6_yùya¹ù±9İ&3?Ûc¸‡C«,ÏlKÖF +‚İ:›]ÁN˜[7gMpH€ñ"‡`)@ @ |#@^ä›®¢¢ €  €  à y‘C°‹ éÎ^ˆüğ|úõX|.@°û¼©> /
D7ÓHtk´6¿sâ[¿xçÁÓºÕú €€»˜… 
9ÊKá p×÷Ÿ|ªöıÿl:zò\'@ Ã{w.MC ÷È‹r¯OiQ®	œ?ş¾ûî;wî\o&0ºûî»{YHo* ¶}çğÇÿ°şÀÿ­?|ìÔ…Ş—F	øZ@-¦Â<qâÄŞÄ¦&Ñİ­/v_œT`
³ßi5n´Ÿ8ÿì¦ƒÿ²ù ¹MÏştøùÏ®Â¼dÉ’7êZÍŒëE°gLÆ  ‡ y‘ı@-ü&Ğ²cû[[ÖN¾æPGk]kk«;Õúé§ÕSYçÏŸ/{”q¤òòòäCZÕã\Õ§òıqMMú4ùUôÙ³g‡ÜÜ¹:Èî×~)8¾¹éİo|púâO;¾óJä½£gÛ)%#à€sÁ~ÓM7ıë¿şëñãÇå™ËÕÕÕİÂvÏ=*ŠU¼§¸¼Mş5¨­­•·İ¢»ÛÊÉ’UQ6.»˜… yŞTÀ—mm!õª¯¯wáùÈo¼ñFccã±cÇäÛåÒÒR9Úµk×‚ä­œW]{íµMMMò³,’ü´´´ÈÛmÛ¶É[É‹ÔWÑmmmë×¯?qâDŸ>}vîÜéœ{7œï¾i‰œú¬İÕ½{â‰uûz~9WUJF ­€xj°§]ßú
’IH2$ùåEjØş×ı—z»fÍIlR|ÅŠÎ*Ş%¡êİòÇ!ueìÉ¢¬WÏÊš6;™·Î: à¨ y‘£¼€mû÷ïŸ9sæ•W^)%Ş|óÍûöí““ªAƒ©ñŸä7ÄË–-;pàÀ°aÃ
“+ËòÅ³,’:Ô¶jY(HîFÕÃZÿ1*J=¿8a²ÀÌ*¾(–Üæ¯ÿú¯Ÿşyi@jØ¾÷Ş{É·İüÕW_½å–[RœİİVD"©%;ÊÔ›`W#Øí 
G È‹8Bğ‡€L¹yûí·U]÷îİ+'Lòƒ/ºóÎ;-Z4kÖ,õı±,r1w²UÉ•½jçÀ=ìºğŠ|Y¡çW8ìUİÙ/
,^¼ø³Fn%l¿üå/§î;5ÀŸyæ™ä_ƒËÖ/ue5 äÎÒ›`WaG°»ÓUì.'@^Äq@6“'O.-©WeeeØ™3wuÑu×]7räÈ)S¦Èô9u‘L¡‘sä Ñ·¾õ-¹€;ù©Ì©“yt2Ëîúë¯O®œM#³İ¦Î·ï*ûÆÄ¡ßeË›1¢hùœa=¿²­Û!`ƒ€xj°ÛPbWù—9{öl	R	á‡zH~¶©ßnÈ°Rj€÷íÛ7ùV]_”ºL˜0!ueG'ÍÚì*#ræO©FQ Ëa®‹Èe?Ú$s‚‡ü–¹"£±º–ı+_Ş>¯jÄÜÊº1ÈÕ>úèÚµkÕ¼;÷—­»ÚVlh¾gò¨¹S*
òÃæ+ï½#g7¾ıÁ;‡Î†R¾¾gì@yõ\Ã?Ûc¸‡C«,w¿-ì1€»ça›]GÛì¼¸'åç…^ª!Ì³ë
¶B Ş
0^Ô[A¶G ‹#n,üû;J¾7{Èø¡Wç3]Æ¢«!àC‚İ‡F•@ D^ÄA€@
”””¼òÊ+^õZò…~ß¬´¤zè#‹d)õiY	è¶Y5(D°gçÆV à• y‘Wòì@\uß¯ß^¼bŞŸÜZ2 Ğ4\ Øs½‡i¹#@^”;}IKğÀ€~ùò²ïªM…@ S‚=S1ÖG ÷È‹Ü7g €  €   — y‘^ıAmÈH@İäW–'Ÿ|R6”Õ[µdT+#€€şòø×d€Ëıúõ¯05D |$@^ä£Î¢ªtX¿~½zëÖ­[å$é¹çSoëêêäyGx!€@î	ÈC]U˜ËCŠr¯u´ğP€¼ÈC|v€m‘H$õ$iÉ’%O=õ”m¥S €  ëäE¹ŞÃ´/§vìØ¡&ÕÈ Q²¡2ptàÀñãÇçtÓiX´heÚ÷4 /r˜âpR@’5£FˆjkkÕ®V¬XñíoÛÉİR6x#ğøã«—Ùtr­‘7•`¯ €@
åhÇÒ¬€	”••©Ë`ÑOúÓêêê€Ğ\‚%ĞŞŞ¬ÓZ@Àyò"çÙ	Œ=ZÍ¨‘ë‹T.$ƒEòE²c;¤`ğR yJ	y;ò²*ìÈ9ò¢œëR$İ»w«I5rc:Õn¹%gKA:hk°’· L†|°ÚOk@ 'È‹œÔ¥l@ @ ğƒ y‘z‰:"€  €  €€“äENêR6 €  € øA€¼È½D@ @ @ÀIò"'u)@ @ ü @^ä‡^¢¤hmm•;Ñ©E~N·:Ÿ#€€/ˆt_v•F Ÿ„ãñ¸OªJ5ğXÀŒù'Å/Fcu-ûW¾¼}Ê˜²ªÑ%×,Ú²au$’ˆåÒÒĞÔ?¿/{X«7ß?VÛ¸÷É£æN©(È›¯¼ü<©“T2ãª-øÙÃ=Zõ`¹‡b×ÁĞ6Øu‹t9$ì
ö^Ü…òóB/ÕæÁ	5ZŠ€^äEzõµÑYàS§JûV¾üº&|Íá¶¶KyQÃÉ%ığ¼n’ÍùÚè+
òúä‘yŞT mƒ]ÏHÙŞ;yQ(«"€€3äEÎ¸Rj.
¤*uÆâ¿ııñï¶Gc±h<ÅcÆ`’ùŸ	ÉÇïÖ¥˜‘ñ Œ=]KóÃ!™¡Î,+=ô†¾2XÔÇH/²Ç˜RœĞ6Øµ‰tãï½ÁN^äüqÍ@  y‡VÔ©R,ŠÅãÑxg,t!»Ğ»(?G¿·Z–İëy¯¥¾¾^•ZYYyÃ—o³{”'ÓåòÂ¡>æô¹¾}òúæKRd¼U¿g]”¬ê‘€¶Á®U¤KçØìäEìì.	q4 `U yª$?Èx‘¤C‰¤(&yQLò%É›ä#óºÈ÷Çrä>f^¤¦Ï©‘ü+?ËGäE=2üÖl‚=mÙìäEiÍYœ /rZ˜òsG@İ¤Ä/
É­ÌÔ(&#E’ É[#/ºtï¯íñÂİğ‘–K$ùÌš3Ò!ójüÒÌ‹2¾ñ÷]ğ¢7½O‚=]÷ÛìäEéÌù /rœ˜äŒ€qª6BÆHb’…Œ¼È,’ß˜y‘4Õ+
æ‘9Pd$Fj¼HÆ‡$)êºãB(ÏÌ‹Œ1£x<ÓkŸÈ‹r&ˆüÒ‚½çr"ØÉ‹üÔ /ÊáÎ¥i6¨S%IzÌ,ÈÈ‹¢Æ¿ñ¨yq“èwêìšü|c˜(?,ÿªëÌ³)ò"›LŠ³_€`·bjo°“Y1gpT€¼ÈQ^
Ï5ä]ªd¼HeGjZ¼U™Óo‚9‰Nõub,È2êš8§2"y›İÃ‹¤PÆ‹r-üĞ‚=]/ÙìäEéÀù /rœ˜ä’@ê·Èj€ÈÌˆŒ¤®›t›C&Á]ÔUê?ã6¾F:”˜Y—å`yQp&O[N`—A  5IDAT°§ã·9ØÉ‹Òó98.@^ä81;È1äÙ’™©ï”Õ$ºÄÕG9ÖŞL›“¼‚È¼#wâ6êç,fĞ©½3^”i/°¾-{ÏŒö;y‘--… €@oÈ‹z£Ç¶HÌ•KÜ}Î"9?¸t/º€ª|¢Ù
Ä¼¿‚Œw “ÜÑx—ÕB^”Ù @°§E´+ØÉ‹ÒR³8- O¥gA ÌÌ³}ã:"c	ÅÛ¬%o¨]ÊË2YTj¤îA—2k# ƒ ÁöÁ®ÃJ@Àò"[)$p*%2³#Y8å¿ì`²˜Q¦7æÜñDƒ5 Ø-tÁn‰U@@{ò"í»ˆ
j,`0™÷àuy•>² à{‚=İ_9‚İ÷9@ ò"@ @ º yQĞ Ú  €  € äE €  €  tò¢ ´@ @ È‹8@ @ @ èäEA?h? €  € q €  €  €@ĞÂñÄƒ)ƒAûè€çqÔØØX__/MšTVVNš4©7Í±e[Ÿ\´àg{ä•<>eÕƒå¶ÔBÈZÀÛ`×0ÒEÒ–`àÅ=ÑX(?/ôRaõáÉ† Ğ+ò¢^ñ±q><u¶ıØÉPÊcK=|‚é¯Öü$‰«î(+Ïšû`^g£Á‰z„BÅEŠ?ß_’µ^6‘9Ğth»>Á®U¤_ÄtuOïƒ¼H‡C: pò¢€ 4?óãğæ–}K×nËf{¶©üÜ¡H$Qnii¨áäC!Ïò¢dûîŸ>æcŒãì)ûìˆ¼ÈC†"-	èìzFºPö>ØÉ‹,‘¬„ N
9©KÙ¹(`œ''úñÍÍû–®k¼¥ìº‘¥=ohGk][Û¥¼¨¸bš‡ãERÈÑšö–S¥ÓÇˆ–1’f¢e7pD^äùÌ
hìºEºÁN^Ì(£Õh%@^¤UwP˜WäÿH^ôƒuóªFÌ­áy½[[[Ô•UUUcÆŒñ¶J[wµ­ØĞüõi÷Ï+IQ"5Êö2ò"o{3°{×0Øu‹t96ì
vò¢ÀG@ïgÚècAMH+`~lL
3N˜â^OÔ½¦cÇ}ì±Ç7Ï“¢då)3¬Œ—1ddÜ"-2+  ƒ€Á®g¤ßì:µÔz'@^Ô;?¶œ€‘É¹},ŠjvŠ/çÔ¢OŸˆRg,Åå3“4s#ü! i°kéÒŸ»?jj‰ =
ht
EO! ¹@×÷Çj"±h^aÏ«‹ÅÍ¤(ae1däy¯P»¤O¬B°g*Æú  ¡ y‘†B•4«‘Ò¢´ı$_!«Wb¬ˆÁ¢´d¬ — Ánµ?v«R¬‡ iÜ9TM;s°Ã¼V&qÁŒv5Ô«Bb•HŠÌÄÈ¤3nq®W-©— Ø3;,öÌ¼X´ /Ò²[¨”Şê&îÌ¢;ş|yyùÕæ2qâÄsçÎ%mä£qãÆ?~\[-ãB,sÉå˜¶TÌ—®»¯#İp‚İ—8•F Oq@ …€1»Æµ‰tıû÷?pàÀ©S§$/Ú¸qc²ºıúõknn¾öÚk{h@gggMMW¹“êJ‰&ÊâHcÏÜvÿFºŠr‚İóƒ•
 €@/È‹z	Èæ¸ôdR/Îó%A’<GFæÏŸŸ/Z¼xñÎ;¥'<8mÚ´Áƒ«ñ%YgÑ¢EµµµC†yöÙge…U«V%?r¥çÌ'¤uAe÷PWWêÉN¸Œ€‡Áî·H=‚ B ßù¾i€'æÍè\JŒÎœ9#‰ä3mmmsæÌijjÚ¶mÛš5k’Ÿ>}ú²eËäí/¼ğğÃ···ËàÒ‰'d@é‘G©®®–s¬…JÖ$ÛÊG²>\¥RN/rfi^UÄ$:§¥)ß)×‚İ×‘n$F»SÇ å"€€KäE.A³²HÎ®Q¹Ğ°aÃ
SK“¹îß¿ÿĞ¡C[¶l™0a‚äN’DmÚ´)uµäx‘äQ‘H$ë*±!Ø.@¤ÛNJ €@FäEq±2:
È¸ĞÔ©S—.]:{ölSª¨¨PãE3gÎ”êÊ%F2R¤ê=kÖ,5^$‹Œ#éØê„ Ÿ!@¤sh € 
9ÊKá¸$p×]w­^½Z&ÔÉØ‘*..>zôhAAÁ Aƒªªªäú¢ñãÇ—––ªë‹änîÌ£s©ıì`éÁègZ‰ Ş˜J² €€u»%¹@4¿Õµì_ùòöyU#æV°°u°VÙº«mÅ†æ{&š;¥¢ ?l¾òòóÂòPó2„Ì4ülá­z°<³-Y¬vëlvû/î‰ÆBùy¡—jsëü¬‰ v
0^d§&e!€  €  €€È‹üØkÔ@ @ ì /²S“²@ #Óç£?<ŸÑ&¬Œ ~ ØıØkÔ 	­Çi/Z;uá?›>úóßí<xZ‹
Q	pF€`wÆ•R@À~ò"ûM)ÛÎŸ?_^^®n%7qâD¹÷¸qã?nû\(PˆşíµCOÕ¾¿ù£Ü÷Årv¡¯€ÜCğàÁóçÏOVQî'ùéÛEÊjwß}÷¹sç.ÛùûúAnÍÿı÷ëpÃI‚]ß#š!€ÀåÈ‹8.ğ‡@ò™’u{`«?
½{øãÙ|ğÖØñş)¹§Ÿ_ªM=pT`øğáo¾ù¦úšCRšÿşïÿ–»íg´Gy®Qss³dSmåèÊ»£¼ 	9K±9.ğ›¦×ßŞºnò5‡;ZëZ[[½j­ú²Y#ÉWÎO?ıtmm­TF~ÿÍo~S~PÏ2RŸÊ/kjjdÜ)õËi'j¾k×®·ê×Î‡onzwç’5GNçW‘%uíïşØ‰=R&Î	´ìØ®‚ıÈ®_;ìW]uÕc=V__/Mhii‘ÁŸn¸A5G"ZÅïºuëÎ=+”1–£ÔpN©õåÙeGQ%¤şp‚ˆ`wB•2@À+ò"¯äÙ¯¿ä$&‰·µÉ+ÔĞĞàÂsÀÎœ93dÈ9éikk«®®V|%%%ííí§N’™uòñí·ßşË_şR~ÿÂ/È³\åÌ©©©I>•EÎ¨ä”KŞnÛ¶mÍš5êwÃùî«‘Ÿ6nÿŒû+Ô½{â‰uûz~9Z[
G gäñ,!¯²ÛIu^{í5)ö×¿şõßıİß©òwìØ!Á®âwÎœ9‡–¬L~–•7nÜ(+tç7ŞxC­èĞ!5úÔí/€3ëlv†m?®(2 /ÊTŒõP—¦¹Éş’óèR³™u#'L’,Éäº±cÇîß¿_ÎŠ¶lÙRYYÙÑÑ‘ü¶xÙ²e6lXaa¡ó]ø	œN_ìaÿ1*+ôüâéÓÎw{ğRàK_úÒéÓ§_ıõßıîw2¢«ª"±|Ë-·$«•Ş›o¾yß¾}òûná,¿Të÷éÓGıĞí/@$q ‘¶{W˜gøÔgšD‘ Xò¢Àv=ï•€&gê2TQQ¡Æ‹fÎœ)CF<òÈÒ¥Koºé&u±Á¬Y³Ô÷Íê+ç^µÙòÆİpòóz:Ñ)¼"à€‚_a³ N—,÷ +úL@2™iÓ¦İyç#G¼òÊ+Uí%Šß~ûíO·dïŞ½’}ú÷òKµ¾|]’Ü0õ/@rœÙFƒ=ß<¹ªo¾Õ£(@ #ò¢Œ¸X„€ŒÆ”•…KKCò’kauæîú"×g«!¹¢àèÑ£²ÿI“&ÉÀ‘šŠ3~üøÒÒRu}‚¤I’D¹SÁn8ß¾«ì¶²«?k×3F-Ÿ3¬ç—J¬<2vÇŒ½è+ Ç³ŠtyÉÏUT"wĞ A=ôP²üÔøM½¾(u&mjen»í¶h4*Á.Q/Û~ú/€óèlö¢Â©s¿oş–:Ô­‹ ş»3È_(ÔË
˜ßŒÊ?a¹‘ÀÅhlsó¾şrûÜÊóªFê#&W<úè£k×®M~ëìIİ¶´FV¾Ò<{Ò¨ySÇä‡åuää…µÍØ{äL(Nú¹gì@yõ\É^Ü…äëä—jSŒ<i;€/‚]“î°+Øå"C™O+CÇò-‰&M£ 4Æ‹‚Öã´×6sŒHşÑëÛM¹­‚Ü}ÁÛ¤Hˆ?3¸¨ßÂ™%GIÉúÙÖ„€+z»+MO¿‚=½k €€OÈ‹|ÒQTk,X¸p¡µu=Xkä…ß›=äo+o¼şê¾ì]"€€[»[Òìl /²’‚@À¢À„›®YR=ôë·_se‹›°øQ€`÷c¯Qg+@^Ø®§áx) 7©»cdÑÒ{‡ŞZ2ÀËz°opX€`w˜â@À6ò"Û()2{òr¹Q¦h¬€v?öuF häEAëqÚ›S³gÏV·á~òÉ'UÃjkk»ı&§Lc@ ’À=z4 € ö
ÙëIi¸*°~ızõÌÖ­[·ÊSMd©©©Q¿yî¹ç\­
;C Wşùûî»Ï•]±@ XäEÁêoZ›«‘HDæ¸aÃ†gy&WÛH»@@¾ûhhh¨®®†@Àvò"ÛI)÷vìØ¡fÍÕÕÕ©½.Z´HıF¾Tv¯ì	\xâ‰'d”Ø•]±@ päEërœKãÇW³æ–,Y"WIÓ^|ñEõIr©¥´d°HfÌª/>dˆ˜KŒ8$@ {È‹ìõ¤4¼(++“4è7ŞäüIı†rF@æÊªo=d‘ ß½{wÎ4† € :éĞÔ,äãä—ÇrÉ,êëäQ£FıèG?Ê²P6C @ ‚'@^¼>§Å9$ _«/“—$#Sìr¨¡4>!À` `» y‘í¤ˆ  €  € > /òY‡Q]@ @ °]€¼ÈvR
D @ @ Ÿ	ù¬Ã¨. €  € Ø.@^d;)"€  €  €€ÏÈ‹|ÖaTË
ìÚµk¹¹<÷Üs­­­(!€@N
é9Ù­4
4ÇãqMªB5Ğ\ÀŒù'Å/Fcu-ûW¾¼}Ê˜²ªÑ%×|Ë†Õ‘H"–ËÊÂSî‡=¬Õ›ï«mÜ{ÏäQs§Tä‡ÍW^~ÔI*™qÕxqO4ÊÏ½TSîa£Øup´vİ"]	»‚ı‰uû>8}qà€‚ås†çH£¥  • y‘VİAe´øÔ©Ò¾•/¿®I'_s¨­-Q—ÒÒPÃÉ%ığ¼n’ÍùÚè+
òúä‘yŞT mƒ]ÏHÙŞ;yQ(«"€€3äEÎ¸Rj.
¤*uÆâ¿ııñï¶Gc±h<ÅcÆ`’ùŸ	É™w6§æE…#fd<(cO—ÅÃÒüpHfè†óÂ#ËŠG½¡¯õ1R#Æ‹ì1¦ç´vm"İø{go°“9\³H#@^Ä!‚€Uuª‹‡bñxg4Ş]ˆÆ.tÆ.ÊÏÑÄï­–e÷zGŞkihhPÓb«ªªŠ‡Åî=dPL—Ë‡ú˜ÓçúöÉë›/I‘ñVıytP²ªGÚ»V‘.cc°“yt°³[¸$@^ÄÑ€€Uä©’ü ãE’%’¢˜äE1É—$)‘Ìÿõ`I^+èÑH‘ÑdùşX.!’ÜÇÌ‹Ôô9#5’ågùˆ¼Èƒ#ƒ]f. s°ëéN;yQæÇ)[ €€ÍäE6ƒR\¨Ós¼($·^0S£˜ŒI‚$o¼èÒmL¼¿¶Ç‹0|¤å’ Iş#³æŒtÈ¼ã‚šD'¿4ó¢Œo¼À}¼èÍ@ï“`O×ıö;yQ:s>G ÇÈ‹'f9#`œ*…1R£˜äB!#/2‹ä7f^$M5ÇŠ¼2ò–Ú(2ÇŒÌñ"’¤¨ë¡<3/2ÆŒâñLG´È‹¼íÙ î`ï¹Óvò¢ MF@7ò"İz„úè+ N•$é1³ #/ŠÿÆ£æÅEŞN¢ÓG-u*]~¾1L”–ÕuæÙy‘>½EM>C€`·rhØìäEVÌY /r”—ÂsM y—*/RÙ‘šV'oÕEEæô›`N¢S}2†Œº&Î©ŒHŞf÷ğ")”ñ¢\$?´‡`O×K6;yQ:p>G ÇÈ‹'f¹$ú-² 23"c ©ë&İÒÜ@çEfûÕÆm|t(1³.ËÁ"ò¢\Š µ…`O×Yê#Û‚¼(8Ÿ#€€ãò”°* .1Ï£Æ@äîÆ%4ê¾ÆØŒicyrËÀ¾äš"A	ˆ°ºĞ(ëtV;†õ°[€`O÷wŒ`·û˜£<ğZ€ñ"¯{€ıûP 1W.q÷9#ˆäêÒ½è|Ø"Û«¬@Ìû+È¨‘q:O3Şeµ0.+66²A€`O‹hW°3^”–š@ÀiÆ‹œ¦ü0ÏöëˆŒ%7n³–x¾¡Dâe™,*5R÷ ËÁ#&å¼ ÁöÁóQ@ yQpúš–Ú) R"3;2FCì,:wÊ2YÌŒ(Ósç-ñ¿ Án¡	vH¬‚ ÚißETPcó„É¼¯ ¯Ë¨ô‘ßìéşÊì¾?Èi q €  €  €@ĞÈ‹‚~Ğ~@ @  /â@ @ @  ı ı €  €  @^Ä1€  €  € A /
ú@û@ @ @€¼ˆc @ @ ‚.@^ô#€ö#€  €  €@8£€ ½ğ<ëëë¥R“ÊÊÊI“&õ²E½ßÜÆ'º>ğâh,”Ÿz©¦¼÷£z#àm°ké‚iK°?±nß§/P°|Î°ŞtÛ"€ YeMÇ†AøğÔÙöc'CáK)?ºó«5?‰Dßq”•…gÍ}0/Ï³Ñàäw-ÅEŠ?ß_’µ^6‘¹}<±¿O
èìZEºñELTïƒ¼ˆ°C ÏÈ‹<ï*à?óãğæ–}K×nÓ¤ö•Ÿ;‰$êRZj8ùÅPÈ³¼(irÿô1Ì#_&›gOÙgGäEšf¬†nÁ®g¤ËÑû`'/
`|Ñdt /Ò­G¨îÆy’q¢ßÜ¼oéºÆ[Ê®Y:ĞóJw´Öµµ]Ê‹Š+¦y8^$õˆı¨iïa9UZ0}Œh#i&ZvGäE`Á¬€†Á®[¤ÛìäEÁŒ2Z€VäEZu•ñ€yEñäE?X×8¯jÄÜÊ×»µµµ¡¡A]ùPUU5fÌo«´uWÛŠÍ_ŸVqÿŒ±’%R£l/C /ò¶7»wƒ]·H—cÃ®`'/
l Ñpôğ~¦>Ô´æ÷ÇÆ¤0ã„)îáõDİk:vìØÇ{ìqsñ<)JVNb1ÃÊxCFÆm!Ò"³:èìzFºñ]Á®ÃQK@ wäE½ócëÀ	Y‘œÛÇâ¡¨f§ø2qN-úô‰(uÆbÑX\~03I37bAÀš»†‘.ıI°ûã ¦– Ğ£€F§Pôšt}¬&Ò‹æö¼z±XÜLŠVÆ CF÷
° @°[@úÄ*{¦b¬ 
iØ)TIs°ù -JÛOò²z%ÆŠ,JKÆ
z	ìVûƒ`·*Åz  ± y‘ÆCÕ´0;ÌkeÌ8_ÃóçÏ———_m.'N<wî\rŸòÑ¸qã?î|-²ÜƒX%’"312éŒ[œgY›!à€Áî^ãØÁî *E"€€ÛäEn‹³¿P7pm]ÿşı8pêÔ)É‹6nÜ˜ì×¯_ssóµ×^ÛigggMMW¹“q!–9Îär,1š ‹€ËÁ®K³3¯Á¹[ €€väEÚu	òƒ€1»Æ“‰t’ I##HóçÏO-^¼xçÎR£ƒN›6mğàÁj|IÖY´hQmmí!C}öYYaÕªUÉ\pVÃC])ÃD.³Û<vÛ[âh»£¼ î¹ãÌ^rGàÒ“Iİ:Ï?sæŒ$6’Ï´µµÍ™3§©©iÛ¶mkÖ¬IšNŸ>}Ù²eòö…^xøá‡ÛÛÛepéÄ‰2 ôÈ#TWWK6µpáBÉšd[ùH–áÃ‡«TÊáÅ|BZTvuu¸†Àg
¸ì~î‚İÏ½Gİ@À /â@@ óft.%FÉyt*6lXaaaj¥åEû÷ï?tèĞ–-[&L˜ ¹“$QEEE›6mJ]­££#9^$yT$É¦ån#g–æUEL¢ËÕµp3Øµit6!Ø³QcĞI€¼H§Ş .d% ãBS§N]ºtéìÙ³eL©¢¢BÍœ9SÊ“KŒd¤H<kÖ,5^$‹Œ#eµ76B @ rP€¼(;•&Pà®»îZ½zµL¨“±#5(T\\|ôèÑ‚‚‚AƒUUUÉõEãÇ/--U×Éİ\™GÀ® Étpá®’©»°İúßÍ’Ãp_€¼È}söˆ@İn:WRRòÊ+¯\yå•RDêG’óÈMçn½õVùå={d8HŞÊ<:9Cúş÷¿/oåú"ÙDı¬>••3¨«"€@/\¸«¤|'rìØ1‰îW_}õÏşìÏz¾¥•»Yö¢¹lŠ øR€¼È—İF¥@ |*àô]%å[™UûÔSO¥Şš2õ®•ßüæ7Õx‘\”¨feˆÉ§ÚT°.@^dİŠ5@ ÈFÀı»JÊZRoM)£IÉ»VÊÄZÕ†ÖÖÖ0€œM²ä¢ yQ.ö*mBÀ'§ÏG~xŞ'•¥šd/àş]%ËÊÊRoM9vìØä]++++UK¾úÕ¯Êõ‡êYgÙ·ÍÚ–»5'ÖB /È‹¼ÔgßVàØ©ÿÙtôÑŸÿnçÁÓE á$l¼«¤ÜRî³rÕUW¥Şš2µ|™5—Ü¯/ºóÎ;Õ£ŸXv'T)œ /rB•2@à3d€èß^;ôTíû›ß9q1Ês8THôò®’»víºşúëeğçOÿôOåÑÏrwÊÔ[SÊ>’å'Å_zé%uƒÊo}ë[=ôí=A°ÛNJ à¨€ù€j° `ÆŠüÆâ£±º–ı+_Ş>¯jÄÜÊ¶Î~ùöwâÄ‰}ô‘! ROw½ì"*ª©©yøá‡Ÿxâ	u3ºì÷Ú»-·îj[±¡ùÉ£æN©(È›¯¼÷œİøöï:›úDÜ{Æ”WÏ{{àÅ=ÑX(?/ôRMyïêÅÖXğ*Ø-UN³•ì
ö'ÖíûàôÅ
–Ï¦Y©E€ñ¢ ô4í´W eÇö·¶¬|Í¡Ö:¹vÙŞÂ?]Zò¼=$EN×Ázù²ûµ_
Î‡onzwç’F6GNçW‘%uíïşØz9¬‰€.»M¶^‚İºk"€€şŒéßGÔPÔ¯Ÿı§ïF"‰±ÖÒÒŒÏ„Ãa‡**ãE>úèÚµkÕc‹ä­Ür·©©Iî±›>zúé§øÃöíÛW2¨üÇLÉD¹'¯l%kÊõjC¹êÀÑüjùòå©8Ÿ÷Á™‹¡ÉœX(N/*¼"ÿª¾i¾ 9~æ¢à3^äĞF±ŸHöïï™¶¶Ä*ìO>ù$bIƒıÄÇò
ãE] à¡ ãEâ³k¬
$¯¨­­•m%á9qâDŸ>}vîÜ¹cÇ¶¶6¹xZ2¥Ô‡9J%YzëğáÃ[ZZä­\xàhRôé&ÉÜ˜Úùñ£²BÏ¯®Ù¾NeV»õ@ GŞ»$ERö}8-á C Ïøä=;FÀº@r]uuµl%b”E’¢¡C‡Ê[¹ıî-·Ü"?ÈoÔjéèèP^Ë".‘§IÊ#M
­ï×–5óózÊgd¼H¾!îù%#E²\Õ7ß–úP8$ĞË`ôù+î®Hsµ¡C5§X@@˜GÇa€€UÔ©5olßV__¯¶”‡È³A¬–’ùzŸG—œV'óâd‚Ü…V®\)£@ò{yÔ½L¨SóèöíÛ§~¯öÙ­œÌ+bu¹ä çÆ›Çm|ûxKäôeçÑY¹ïd[¥g=›¼
v›ªï^1¶»{UgO €À§/â @ ÛÆÿQSç6œôÅ±3MŠTå’óèäÆtÜıÖ·İv[4•A¡ÒÒRÉ‹’í‘Ÿå7j¼HîM'óè²ijæÛÈèª{ç3GÜúUzhâß]öåâ«2/Œ-ğXÀå`¿lke®¬
dYdÒ¬¬#SjÕ[o¯w"Ø=>:Ù=Ø*@^d+'…!à€@III{{»ºLH®,’t¯¼òŠºÃw¾ó[o½U¦Ï­[·N>=zôè¿ÿû¿O˜0¡¹¹Yİ¤ûûßÿ¾ÚP®;’9xÉ¨fš"õ[8³äïï()ùB?÷÷Îğµ€|Ç¡ùÅ_\±b…¤FrG~õ›­[·JÖ¤Uëv­ºƒÊ €€uò"ëV¬‰ ½ycá÷fùÛÊ¯¿ºooËb{‚' ÷V<xğ‘#G¾ño¨ÖO™2åğáÃJìv
UB È‹8B@Àm	7]³¤zè×o/¾æÊ>nï›ı!àOÙ³gË¬¹†††Ç<5’4Içì:÷uC näE à€Ü·ê‘EKïzkÉ vÏ.ğ›ÀúõëeÖÜSO=5zôèÔºË$[Í›B°kŞAT’äE à™€Üz›Ë<ÓgÇ>¸á†¤Ö_ùÊW~úÓŸªêËõEòVÿ¦ìú÷5D ò"rA@Í±‘E=ø•rI y÷¹Q£FıèG?’ûL>óÌ3*äÿê¯şJŞæRci à• y‘WòìÛäœ©¬¬LæØ¼õÖ[ßıîwm+—‚@@¹™¤ºûœ,ê^ür•‘z+?èQGj ø^€¼È÷]HH
¨¯ÕãMX@ @ ¬Y·bM4ï’åb5©&‰hZKª…  € h,@^¤qçP5,$çØÈ\l`™@ @ „ y‡¹#ğüóÏËCs§=´@ pK€¼È-iöƒ€c;vìP“èşã?şCrâØ~(@ ÈYò¢œíZ¹?•šG·{÷îà´š–"€  € 6
ÙˆIQ €  €  àKò"_v•F @ @ È‹lÄ¤(@ @ ğ¥ y‘/»J#€  €  €€äE6bR €  € øR€¼È—İF¥è&ĞÚÚú\×"?ãƒ 9)@¤çd·Ò(ĞD Ç5©
Õ@@s3VäŸp4¿Õµì_ùòö)cÊªF—x^ó-VG"‰X.-MıóûÂá°‡µzóıcµ{ï™<jî”Š‚ü°ùÊËÏ“:I%3®Úëö}púâÀËçó°Qì:8Ú»n‘.‡„½ÁœcŒ–"€€†äEv
UÒTàS§JûV¾üº&u|Íá¶¶KyQÃÉ%ığ¼n’ÍùÚè+
òúä‘yŞT mƒ]ÏHY»‚=ƒNbU@Ànò"»E)/wRO•:cñßşşøwÛ£±X4ŠÇâ1c0ÉüÏ‹„äãwëRÇ‹
GÌÈxPÆ‹‡¥ùáÌĞç…G–zC_,êc¤FŒÙcL)ÎhìÚDºñ÷Î‰`w¾oÙ ğ™äEXP§J±x(wFã±Ğ…hìBgì¢üMüŞjYv¯wä½–úúzUjeeå_¾Íî=dPL—Ë‡ú˜ÓçúöÉë›/I‘ñVıytP²ªGÚ»V‘.c{°{Ôáì0È‹8°*<U’d¼HÒ¡DR“¼(&ù’äMò‘ù¿]äûc¹„Hr3/RÓçŒÔHş•Ÿå#ò¢€~k6Á¶Ç
ö´ûe@À9ò"çl)9×ÔMJÌñ¢ÜzÁLb2R$	’¼5ò¢K·1ñşÚ/ôi¹$@’ÿÈ¬9#2ï¸ &ÑÉ/Í¼(ã/pß/z3Ğû$ØÓu¿SÁn¿| 8(@^ä .Eç˜€qª6BÆHb’…Œ¼È,’ß˜y‘4Ø+
æ‘9Pd$Fj¼HÆ‡$)êºãB(ÏÌ‹Œ1£x<ÓkŸÈ‹r,”ôoÁŞs9ìúÔrX€¼(‡;—¦Ù, N•$é1³ #/ŠÿÆ£æÅEL¢SÜ©³kòóa¢ü°ü«®C0Ï¦È‹l>0)Î~‚İŠ©Áne¿¬ƒ 8$@^ä,Åæ¦@ò.U2^¤²#5­NŞª‹ŠÌé7ÁœD§z<1duMœS‘¼ÍîáER(ãE¹Nz·Š`O×?{ºò9 à  y‘ƒ¸{©ß"«"3#2’ºnÒ-t^d¶_ıgÜÆ×H‡3ë²,"/Ê½8òE‹ötİ¤.1²9ØÓí”Ï@ È‹Ä¥èœH-™y‘úNYM¢K\}”“­¶Ş¨äDæ¹·aP?g1ƒNí—ñ"ëş¬i£ ÁŞ3¦Ánc÷Q © yQ¦b¬€1<¤ÎòÍ¹sFÉùÁ¥{Ñ!dŞqN±˜4ŞKîh¼Ëj!/ÊŠl ØÓ"ÚìiwÇ
 €€sœÌ9gKÉ¹,¸ÈÌÌvf{ÊŸÓH&ŒyUQ×uGÙ5—¼(;7¶²E€`·À¨¾#²!Ø-ì‹U@ §òœ*˜rÈiùŠÔ!)ê¡›Í\Ñ5ÊøE9}ìĞ8Ÿ	ì:Œ`·€Ä*  ½ y‘ö]D50O˜Ìû
ğº¼€JYğ½ Áî¯Áîûƒœ € yÇ  €  € ]€¼(èG íG @ @ ò"@ @ º yQĞ Ú  €  € äE €  €  tò¢ ´@ @ È‹8@ @ @ èäEA?h? €  € „ãñ8
 ĞKÏãhÛ¶mõõõª•••“&Mêe‹z¿¹Ot}bİ¾N_8 `ùœa½¯% €  € Ÿ /â¨@ KOm?v2¾´yÊY–™õf¿Zó“H$ñGiiè®yßÈËól48ù]KqÑ€âÏ÷…â½Ì‘È‹²>0Ø@ ,
Y„b5.	˜£CáÍ-û–®İ¦‰Kåç§æE'¿
y–%MîŸ>æcBápÈH•²ÏÈ‹49Ì¨ € 9,@^”ÃKÓ0’"ãD?¾¹yßÒu·”]7²t #{Ê¤Ğ#»~šWLóp¼H*9úQÓŞÃ’-˜>F´Œ‘4-»#ò¢LÖE @ lÈ‹²Qc› ˜WäÿH^ôƒuóªFÌ­á9HkkkêõEcÇõ¶J[wµ­ØĞüõi÷Ï+IQ"5’ÿÍj®!y‘·½ÉŞ@ ‚€÷3m‚ LsFÀ,2&…‰Q<«s|g,$z²kñ<)J6Qb1ÃÊxCFò7zqæ T@ è yQïüØ:pFV$çö±x(Ê)~ºŞ¥ÎX,‹Ëf&iæF, €  €€~äEúõ	5ÒU k°HM¤3]kªK½b±¸™%¬ŒA#†Œtéê  € Ÿ /â€@ S°ù -J'ÃDê•+b°(-+ €  €€GäEÁ³[_
˜ƒæµ2‰fœoÅùóçËËË¯6—‰';w.¹OùhÜ¸qÇw¾YîA¬I‘™™tÆ-Î³,Í@ @ ÇÈ‹£¥àÜP7pm]ÿşı8pêÔ)É‹6nÜ˜tí×¯_ssóµ×^ÛƒtgggMMW¹“q!–9Îär,w<Z†  € 	9FKÁ¹,`L¥ód"$H’çÈÒüùó“ãE‹/Ş¹s§ÔèàÁƒÓ¦M<x°_’u-ZT[[;dÈgŸ}VVXµjUò#úGu¥D¹@Î.@ @ Kò¢,áØ,°—ÁãÖyş™3g$±‘|¦­­mÎœ9MMMÛ¶m[³fM²¦OŸ¾lÙ2yûÂ/<üğÃííí2¸tâÄ	Pzä‘Gª««%›Z¸p¡dM²­|$ËğáÃU*åğb>!­*Ë§9\EŠG @ D€¼ˆÃ lÌ›Ñ¹”%çÑ©\hØ°a………©•3fÌşıû:´eË–	&Hî$ITQQÑ¦M›RWëèèHI‰D²iy†ÛH.d^UÄ$ºáX@ Ü /r×›½!à€€ŒM:uéÒ¥³gÏ–1¥ŠŠ
5^4sæLÙ›\b$#Ej·³fÍRãE²È8’u¡H@ @À—äE¾ì6*@7»îºkõêÕ2¡NÆÔ PqqñÑ£G

TUU%×?¾´´T]_$wkpe…  € øCÀœıÏ‚ Ô=äryVéÅh¬®eÿÊ—·Ï«1·r„…­ƒµÊÖ]m+64ß3yÔÜ)ùaó•—Ÿ–;ËüCùŸŒ–'ÖíûàôÅ
–Ï–Ñ†¬Œ  € X`¼È"«!€  €  €@Î
ål×Ò0@ @ °(@^dŠÕ@À~‹ÑxÇG´¿\JD @ 2 /ÊŒÕ@À&m¿ûè¿ü~ÓS6•G1 €  €@öäEÙÛ±%d'ğÖ¡3ÿgıoë8vêBv%° €  `¯ y‘½”†€=çÏŸ///W÷Ô–[l÷\¨¬<nÜ¸ãÇÛ³o'K‰?÷O.ÙÜ~ğÃóNî‡²@ @ ÌÈ‹2óbm\';vìøÃúõë{Îyä¹®ÍÍÍòH"×ê–ÅşpêÂÿß¡E¯DŞ;òq›³	 €  à¨ y‘£¼³-;¶¿µeíäku´Öµ¶¶ºĞÎƒÖÔÔÈ ÒüùóÕ“[e‘Ÿe×j¼è7¿ùZA~ÿñsæÌ‘&NœxîÜ9ÙvğàÁÉM’E%K°·ş²ûµ_
Î‡onzwç§Îw®n:úôú-m§íİ¥!€  € v	Ù%I9Áhhhhk©W}}½ÏGŞµk×õ×_İu×İtÓMj,¨©©iÛ¶m2­N~8e.Ã‡ß¹sg’^­ CLï¼óÎ½÷Ş{âÄ‰²²²={ö”””´··Ëúò\úàƒ%¹’·}úôI-Á–^ì†óíõ~÷‘<÷²…×½{BÛÚóëÄÇ¶TŒB@ @ Ï /âØ@@S5N’™ÒÒRu‰Ñ°aÃ
;::’ãEË–-‹D"ÉTUUI%©Îí·ß^YY)?:T>íììTÃGEEE›6m’ßÈ°’,É%èŒ^>#R;ıøÑN_ìù¥rª‚|ş^9ÚQ  €@ 8Ït÷Óx_Ü|óÍİê9kÖ,5^$KuuuÚV´´´TTT¨ñ¢™3g¦]ßŞôËï¡ÀÂ+ò(Hûôù+fhoÅ(@ H
q0 ÀäÉ“KKCê%#3áp8›RzÜFÍ£“AÿøÇ?şxrİñãÇË’ºXHF‡¬Ì‚“¡'5ÄT\\|ôèQÛ«Ú­Àn8ß=ôşñ7Üğ¹+.»ß#Š–Ï–öõÏÿkèø¡W;]sÊG @ À
„¸."°š4<·âÆd.ù',Óº.Fcu-ûW¾¼}^Õˆ¹•#r»áY´në®¶šï™<jî”Š‚ü°ùÊÛıû3uï~¸·ãl(%‹¼gì@ye±6A @ l`¼ÈFLŠB Æ–xzfÉwşgÙ­%òóìaC@ ÈZ€¼(k:6D lnºîÊ'¦}iIõĞiåE2”Mlƒ  € Ø-@^d·(å!€€ë¯îûÀW‹WÌû;²°:« €  € Î
9ëKé Ğƒ€Üª®äı B @ < /ò¼¨  €  € x,@^äq°{z#°cÇuÃî'Ÿ|R•3{ölõù¨7%³- €  (ò¢@u7Í5%K–¨§»nİºµ­­íùçŸ/++“·uuuó7“k­¥= €  €€cäEÑR0Î¬_¿>u'ííí÷Ş{¯üFı‰Dœß?{@ @ rD€¼(G:’fY@¦ÌM™2¥´´45’£ ›Ğv@ @ #ò¢Œ¸XídúœL™{î¹çºÕŒñ"íºŠ
!€  €€ÆäEwUC €Œİ}÷İ»wïV+N<ù¿ø…ü FÒmÍç €  € 	ò"|, #E2.¤n@'7]xüñÇåòóŒ3–/_îã†Qu@ @À]ò"w½Ù¶
ÈH‘º,’IÙÉßÈåF¶îŠÂ@ @ \ /ÊåŞ¥m €  €  `E€¼ÈŠë €  €  €@.årïÒ6@ @ °"@^dE‰u@ @ @ —È‹r¹wi[pvíÚ%7 “EdÔÚÚœ†ÓR@ @Àp<·¥ 
A çÌX‘ÂÑXüb4V×²åËÛ§Œ)«]âyÛ·lX‰$b¹¬,<åîùápØÃZ½ùş±ÚÆ½÷L5wJEA~Ø|ååçI¤’ŞVÍCv  € ú
éÛ7ÔL7OåEûV¾üº&•œ|Í¡¶¶D]äİ'o”ôÃóºI^4çk£¯(Èë“G^äyoP@ èI€¼ˆã«©yQg,şÛßßñn{4‹ÆCñX<f&™ÿy‘œygsj^T8b†Gƒ2ñ°4?’ºá¼ğÈ²âÑCoè+ƒE}ŒÔˆñ"«‡ë!€  €€ëäE®“³C@ @ ĞL ü‹_üB³*Q@ îwÜq( €  àœÀÿ |õ^ñİ    IEND®B`‚PK     ! ªR%ß#  ‹     word/theme/theme1.xmlìYM‹7¾úÄÜÍøc‰7Øc;i³›„ì&%GyFQ¬IŞ]%9
¥ié¡Şz(m	ô’şšmSÚòªÑxlÉ–YÚl`)YÃZÏûêÑûJ4ËWNã˜¦§z©â ”4ÄiÔqîK-pÓš¢3GÜ¹²ûá—áˆQ‚€´Oùì8±Ór™²òKtŠRÙ7¦,BVYT<–~R®U*rqê€&ÒíÍñf.İÂù€È©àYC@ØAæ
NªÙŸsŸ0pIÇ‘ã„ôøÈ…ìè8õç”w/——FDl±Õì†êoa·0'5eÇ¢ÑÒĞu=·Ñ]úW "6qƒæ 1h,ı) 9Óœ‹õzí^ß[`5P^´øî7ûõª×ü×7ğ]/ûxÊ‹î~8ôW1Ô@yÑ³Ä¤Yó]¯@y±±oVº}·ià(&8l +^£î³]BÆ”\³ÂÛ;lÖğª¬­®Ü>ÛÖZïS6” •\(p
Ä|ŠÆ08<bìá(–o
SÊes¥VVêòöqUIEî ¨YçMßhÊø 0<çcéÕÑ o^şøæåspúèÅé£_N?>}ô³ÅêL#İêõ÷_üıôSğ×óï^?ùÊç:ş÷Ÿ>ûí×/í@¡_}ıìÏ^}óùŸ?<±À»tø!N7Ğ1¸M91Ë hÄşÅa±nÑM#S˜ÙXĞèsH ×Cfï2)6àÕÙ}ƒğAÌf[€×ãÄ îSJz”Yçt=KÂ,ìƒ³™»á‘ml-¿ƒÙT®wlséÇÈ y‹È”Ã¥H€¬N²˜İÃØˆë>åt,À=z[CrˆGÆjZ]Ã‰ÌËÜFPæÛˆÍş]Ğ£Äæ¾L¤ÜØ\"b„ñ*œ	˜XÃ„èÈ=(bÉƒ9Œ€s!3!BÁ DœÛln²¹A÷º”{Ú÷É<1‘Là‰¹)Õ‘}:ñc˜L­œqëØøD.QnQa%AÍ’Õe`º5İw12Ò}öŞ¾#•Õ¾@²³m	DÍı8'cˆ”óòš'8=SÜ×dİ{·².…ôÕ·Oíº{!½Ë°uG­Ëø6Üºxû”…øâkwÎÒ[Hnô½t¿—îÿ½toÛÏç/Ø+V—øâª®Ü$[ïícLÈ˜´Ç•ºs9½p(UE-¦±,.†3pƒªŸ`Äp*‡©ª"¾pq0¥\ªÙê;ë ³dŸ†ykµZ<™J(Víò|)Úåi$òÖFsõ¶t¯j‘zT.d¶ÿ†„6˜I¢n!Ñ,Ï ¡fv.,Ú­ÌıVêk‘¹ÿ Ì~ÔğÜœ‘\o 0ËSn_d÷Ü3½-˜æ´k–éµ3®ç“iƒ„¶ÜLÚ2ŒaˆÖ›Ï9×íUJzY(6i4[ï"×™ˆ¬iIÍ8–{®îI7œvœ±¼Êb2•şx¦›DiÇ	Ä"ĞÿEY¦Œ‹>äqS]ùü,'r­ëi éŠ[µÖÌæxAÉµ+/rêKO2Q ¶´¬ª²/wbí}KpV¡3Iú ÁˆÌØm(å5«Y CÌÅ2š!fÚâ^EqM®[ÑøÅlµE!™Æpq¢èbÃUyIG›‡bº>+³¾˜Ì(Ê’ôÖ§îÙFY‡&š[ìÔ´ëÇ»;ä5V+İ7XåÒ½®uíBë¶o hÔVƒÔ2Æj«V“Ú9^´á–KsÛqŞ§ÁúªÍˆâ^©j¯&èè¾\ù}y]ÁUt"ŸüâGå\	Tk¡.'Ìî8*^×õk_ª´¼AÉ­»•RËëÖK]Ï«W^µÒïÕÊ ˆ8©zùØCù<Cæ‹7/ª}ãíKR\³/4)Su.+cõö¥ZÛşö`™Ú°]o÷¥v½;,¹ı^«Ôö½R¿á7ûÃ¾ïµÚÃ‡8R`·[÷İÆ UjT}¿ä6*ıV»Ôtkµ®Ûì¶n÷á"ÖræÅw^Åk÷   ÿÿ PK     ! A"–”¾  
     word/settings.xml´V[oÛ6~°ÿ`èy%Ûr¡NáK¼¦ˆ×¡r %R6Ş@RvÜaÿ}‡”9©Wd+údê|çÎïúİû'Îz¢•b%WqÔ#¢”˜Šİ,ú²]÷§QÏX$0bRYt"&zûë/ï™!Ö‚šéa2^Î¢½µ*L¹'™+©ˆ °’š#Ÿz7àH?Öª_J®¥eÔÃ8D­9‹j-²ÖEŸÓRK#+ëL2YU´$íO°Ğo‰Û˜¬dYs"¬8Ğ„AR˜=U&xãÿ×€ûàäğ½"œ½c¿¡Ü£ÔøÙâ-é9¥eIŒâ,$HExü£çØW»-Ñ»ó$ö§óÌÓÿæ`øÊao©¤h¡‘nxÒ–ÁËì~'¤FVB9=È(ºZ~•’÷™"º„»NÇq4p tDV¹E– laÌ“¼d‰F“
ÕÌnQ‘[©@ë€ Ëëaë Ü#JKt®P	¶K)¬–,èaù‡´K ¶†¾·æİ)oF,â÷‹1ØHœ>fµ¦oo­3ğÑ¡ú³¯IqM1Ùº~åöÄÈ’ÏéW2øcm,~~ ƒï%@„‹ü	nx{RdM­¡M?)˜¿‰5£jCµ–ú^``ÂOF«Šh@Y Õòèûü ›õãÎi{›pø,¥ªqœ“ëyËT‡vH2$ãé%äßm&óëdys	¹¹İ¥mæ‹øfµ¸„,¦q:ZµÕ´5ğÌmÌ?u89Böxc±D¼Ğõ6n§œF¡T¼ °$È9’×E ûı01¶†‰€Ošg˜µ"•?³Ò»Îo«¡/Ja;||öåvÑ¿kY«=j¤¢•d<n-©°”¹©‹<X	XkgP-ğ§ƒö}êÚsÌ,ÆìòÄóºDô¿ä-1™Î©È)Õp³Ø%³ˆÑİŞ&N¾0<½ş£Ø[lè±aƒùTºÊ@»=t²aé‚lÔÉÆA6îdi¥ld'ÛÃVĞ°aLÂÑÉ+É˜<ü¡Ã¿5M0{¤ÈªÙà@/ÙÚ•nz‡Œ<Ák@0µğFQÌÑ“{†gŞj3t’µ}¡ë0§¬^zÀÈ¢0 /Œ=Å_åâ^–’ó/ºãªIœQKEÁÛb¥ØoKRÿèØ-°ø.ö3©ÈÜbX–÷Ø=|Í_«åİ2YMã~z®úãy:êÏG‹Eÿæ2]Œ&7ëéäïv
Ã¿·Û   ÿÿ PK     ! [mı“	  ñ     word/webSettings.xml”ÑÁJ1à»à;,¹·ÙYº-ˆT¼ˆ >@šÎ¶ÁL&Ì¤®õék­H/õ–I23ü“Ù;ÆêX¥ÖŒ†µ© yZ†´jÍËó|pm*).-]¤­Ù‚˜ÙôülÒ7=, ı)•*Iô­Y—’kÅ¯)CÒÇ]Ñ’W¿nòÀfWÂ"ÄP¶v\×WfÏğ)
u]ğpK~ƒÊ®ß2D)É:dùÑúS´x™™<ˆè>¿=t!˜ÑÅ„Á3	ue¨Ëì'ÚQÚ>ªw'Œ¿Àåÿ€ñ@ßÜ¯±[D@'©3SÍ€r	>`N|ÃÔ°ıºv1Rÿøp§…ıÔô  ÿÿ PK     ! Työh  á   docProps/core.xml ¢(                                                                                                                                                                                                                                                                  œ’QOƒ0…ßMü¤ï¬À’©X2Í\bâŒÆ·ÚŞmu¥mÚnŒoÁ$îÉ·{{¾{¸œ6›ŸJÁX®dâI„T1.·9z[/Ã{XG$#BIÈQÍ‹Û›Œê”*/Fi0ƒ¼“´)Õ9Ú9§SŒ-İAIìÄÒ‹eJâ|k¶Xº'[ÀIÍp	0ânC=8¢³%£ƒ¥>Ñ0ŠA@	ÒYOb|a˜Ò^h•_dÉ]­á*Ú‹}²| «ªšTÓõûÇøcõüÚşjÈe“TdŒ¦;E†/¥¯ìáë¨ë‡Æ×Ô qÊ.DİªıI“õêJfıÜ¨óK×Îß`ç::ğ´ Ö­ü•n8°Eİà¯Ğ°¼yEÒC›ƒí–ø@Ò.¾^yŸ>>­—¨H¢xFwaü°Nâ4¹O£è³Ùk41,ÏüÛ±7è¢?Êâ  ÿÿ PK     ! V˜Q¿Ë  s     word/styles.xmlÌ[sÛºÇß;ÓïÀÑSûØò5ñçŒí$çäâc9Í3DBjPy‰ã~ú %^‚â‚[OŸl]öü—X^Äß~ÿ•Êè'Ï¡²óÉôõş$âY¬‘İŸO¾ß}|õf%Ë&UÆÏ'O¼˜üşî¯ùíñ¬(Ÿ$/"ÈŠ³4>Ÿ,Ëru¶·WÄK²âµZñL¸PyÊJı2¿ßKYşP­^Å*]±RÌ…åÓŞÁşşÉ¤ÁäC(j±1¯â*åYiã÷r.5QeÅR¬Š5íqíQåÉ*W1/
½Ñ©¬y)Ù3= TÄ¹*Ô¢|­7¦é‘Eéğé¾ı/•[À1p°¤ñÙõ}¦r6—zôuO"›¼ÓÃŸ¨ø=_°J–…y™ßäÍËæ•ıóQee=±"âN·¬!©Ğ¼OY!&úÎŠò¢¬óÃ¥ù§ó“¸(·/E"&{¦Åâ?úÃŸLOÖï\™´Ş“,»_¿Ç³WßgnOœ·æš{>aù«Ù…	Ük6¬şëlîêù+ÛğŠÅÂ¶Ã%×3kz²o R˜‰|püvıâ¶2cËªR5X@ıwƒİ#®'œ~³ÚúS¾ø¬âÌJıÁùÄ¶¥ßü~}“•ë™~>ykÛÔoÎx*>‰$á™óÅl)şcÉ³ïO¶ïÿùÑÎÖæXU™şÿğtjg,’¿b¾2s_š1£ÉW Í·+±mÜ†ÿ{›6JtÅ/93	 š>GØî£&¢p¶¶›Y=Ûvû-TC‡/ÕĞÑK5tüR¼TC§/ÕĞ›—jÈbş—‰,á¿j#Âf uÇãF4Çc64Çã%4Çc4Çã4Ç3ÑÑÏ<Fs<ÓÁ)Uì›…Îd?ôÌö~îî}Dw÷.!Œ»{ÆİğÃ¸»ó{ww:ãîÎŞaÜİÉÏ­—ZÑµ¶YVvÙB©2S%Jşk<eše«"Ùéñœd#	0ufkvÄ£i1³¯wÏkÒğıyi
¹H-¢…¸¯r]Lí8Ï~r©ËÚˆ%‰æs^V¹gDBætÎ<çYÌ)'6ÔT‚QV¥s‚¹¹b÷d,%ÄÃ·&’$…Í„ÖõóÒ˜DLê”Å¹ß5ÅÈòÃgQŒ+‰.+)9ë+Í³¬ñµÅŒ/,f|e`1ãG3ª!jhD#ÕĞˆ¬¡[=?©Æ­¡[C#·†6~ÜîD)mŠwWÓáÇî®¤2Ç±G÷c&î3¦ ãw7Í1Óè†åì>g«edJwcİmÆ¶s©’§èbŸ¶!Q­ëí¹Ò[-²jü€¶hTæÚğˆìµálÃo±/z™lhŸhê™Y5/;MkIƒL;c²ª´ãİÆÊñ3lk€"/ÈlĞ%˜Á_ÍrÖÈI‘ù¶½ß±-k¼­g%Òî5H‚^J?Ğ¤áOO+ë²ìa4é£’R=ò„8+sUÏ5×òV’A–ÿ®–¬¶Vj!†ïê×gÀ£/l5zƒn$n^¥LÈˆnñéîËçèN­L™i†x©ÊR¥dÌæHàß~ğùßi:x¡‹àì‰hk/ˆYØ• ØÉÔ$•‘ô2Sd‚djyğ§¹byBC»Éy}ÑIÉ‰ˆ3–®êE·t^|Ôù‡`5dyÿd¹0Ç…¨LuGsÕü_<Ÿê¾ªˆäÈĞ·ª´ÇíR×FÓáÆ/Z¸ñK«¦Ş=˜ùK°±-Üømá¨6öJ²¢ŞS¨Á<ªÍ]ó¨·w|ñ×ğ”Tù¢’t¸’àH6„JViVPn±ån°åQo/á”±<‚Cr–÷\$dbX•F%ƒ…Qi`a¤Œ¿BÇ¿LÇ¿V§†-Õ<#İıåq`TóÌÂ¨æ™…QÍ3£šg‡ï#¾XèE0İ.ÆARÍ9I·£ÉJ®TÎò'"äÉïÁÒšv“«…¹AeõEÜHsŒZ.¶k•È?øœ¬k†EÙ/‚#¢LJ¥ˆ­mw86²}íÚ®0{'Çè.ÜHó¥’	Ï=ÛäÕõò¬¾-ãy÷m7öü,î—e4[nö»˜“ı‘ë‚½¶»Á®1?YßÏÒö…'¢J×…7Sœ¶3º|´;x»’hEŒ„mìÜ®’[‘§#a›oFZŸ¶"ûüğåá´oşlj<Ïä;í›E›àÎfû&Ò&²k
öÍ¢–U¢‹86g :Ã<ãf<ÆE~
ÆN~Ê`_ù}»å?…Ù³c’¦mosõÈûv=(sşY©ú¸}ë„Óğ›º®õÂ)+xÔÉ9~âª•eüã88İøƒó18ùƒ2‘7•’ü”Á¹Éœ¤üt¶‚{\¶‚ñ¸lãC²¤„d«« ?bğrÀ@"ĞF±Rğ#PFáAF…´Q!mTˆ@.ÀpF…ñ8£Âø£BJˆQ!mTˆ@"ĞF…´Q!mÔÀµ½7<È¨‚6*D 
h£Úõâ£ÂxœQa|ˆQ!%Ä¨‚6*D 
h£BÚ¨6*D Œ
ÂƒŒ
)h£BÚ¨6j}«a¸Qa<Î¨0>Ä¨bTHA"ĞF…´Q!mTˆ@"PFáAF…´Q!mTˆ@Õ,aT3*Œ1*¤„RĞF…´Q!mTˆ@"ĞF…”QAxQ!mTˆ@"úægsŠÒw™ıÔÓ{ÅşğSWM§nİ[¹]ÔápÔºW~Öğ{.•zˆ:o<<´õÆ0ˆ˜K¡ì!jÏiu—k/‰@øüvÕ‡Kù£KÍ½öœ)€ÇTú¦¼	Š¼£¾™îF‚UçQ_öu#Ánğ¨/éZ_®/JÑ»#Ü—fœà©'¼/[;ápˆûr´G¸/3;p€ûò±x™äü<úxà8l®/„¾éèNı„¾i	µZ§chŒ¡¢ù	CÕó†Êè' ôôbğÂúQh…ı¨0©¡Í°R‡ÕOÀJ	ARL¸Ô,5D…I#VjHÀJœı„ ©&\jˆ
–¢Â¤†»2¬Ô€•°RÜ!{1áRCT°Ô&5\Üa¥†¬Ô€•‚¤˜p©!*Xjˆ
“TÉh©!+5$`¥†„ ©&\jˆ
–¢ú¤¶GQZR£vÂq‹0'·CvqÉÙ	¨–œèÀjÉ!VKP«µæ¸jÉÍOªŸ0TF?¥§ƒÖB+ìG…I«–º¤7ªŸ€•W-y¥ÆUK½Rãª¥^©qÕ’_j\µÔ%5®Zê’:<9û	ARãª¥^©qÕR¯Ô¸jÉ/5®Zê’W-uI«–º¤¹CöbÂ¥ÆUK½Rãª%¿Ô¸j©Kj\µÔ%5®Zê’W-y¥ÆUK½Rãª¥^©qÕ’_j\µÔ%5®Zê’W-uI«–¼Rãª¥^©qÕR¯Ôjiï±õ &Ã¶$Ó_.ŸVÜü·sÃLRÿisĞ~ñ:Ù<(É›DÍ#©š·m‡›†u‹66/u[qóëI¦š_AİÜÆcõyÃŸJµÙÁúÛÍnO…Ößköìíwi†¼§ÏV’Ş1ªUóuğm3wõP÷g.ë‡vé®³D›VÕ=M~±¥?¿âR~aõ·ÕÊÿUÉeıétßŞ4ÿìóyıûoŞøÜ&
/`¯İ™úeóà0Ïx×¿ßœÁöNIã†á¶—SŒißZv‰«BuÖóş]
)Ÿfö‰€yºÙş´–Ad_i×Ô_1^»å‰ù7şÌtZ†B˜ù`ã÷÷§oN¦ëüè{Î›û”·£Í‹öSŞÌƒÔ2óø“ÍÉõğ4ĞÎèO®˜ó¼õà<m‘ò"úÊ£[•2{kŸ}p^ëëq¿XKæ>Ï­ws7$áËw¯`ÑV’9Óæ›IÑnbjg¯~yyÕûÿáõÅ»ÿ  ÿÿ PK     ! Ë?Ä  í     word/fontTable.xml¼’ÛŠÛ0†ï}¡ûe'ÙƒYgÙ¦(”^”í(Šl‹ê`4JÜ¼}G²ã¶„¥	…Ê äf>~æñé‡Ñä =(g+šÏ%Ò
·S¶©è·×ÍÍ=%¸İqí¬¬èQ}Z½÷Ø—µ³Ö[(¨hBWfˆV3×I‹ÁÚyÃşú&3Üßw7Â™µUZ…cV0vKGŒ¿„âêZ	ùÑ‰½‘6¤úÌKDg¡Uœhı%´Şù]ç øf£áÊN˜|q2Jx®3|ÌØQBayÎÒÉè_€åu€bQ~j¬ó|«Ñ|ì„ Œ®F÷I_Zn0°æZm½J[2ÇØëŠ²‚mØ÷ø-Ø<î4‹‰¢åd„‰lkn”>TèÀèTíI?p¯bSCTƒ=lYE_®b³¡ƒ’WtÂózRŠxWZù¨Ì'…EE$ÎñªDâL9xg68pæÄ«2ÈÙ“¯Îpû†#»E'–èGtf~•#>q¯u¤xùİ‘5*w÷‹ù™#wdà\îÈ8ä³jÚğæ„Ä¹ø_ò[FCşœ‚İ}8ó#½ş'd<Àê'   ÿÿ PK     ! †=ÍÌ  Ö   docProps/app.xml ¢(                                                                                                                                                                                                                                                                  œSAnÛ0¼èŞcÙA[¥ pPäĞ6¬$çµ’‰R$AnŒ¸¯ïRŒ¹Í):Í—Ãá.%¯S0Díl%V‹¥(Ğ*×jÛWâ®ù~ñU‘À¶`œÅJ1Š«úã¹Îc ±`+±'òë²ŒjÄ/[^é\€˜†¾t]§^;õ4 ¥òr¹üRâ3¡m±½ğ“¡Èë½×´u*å‹÷ÍÑ³_-¼ÂúWÚi­£A–“*G`=`½by"r=Æ¤e \hc½”er³‡ Š¸©hÆä7ïV@Ü×ú§VÁE×Qq;†-ÒnYÎK$_`‡ê)h:&ÿ9•?´Í)2àTú ~ÿmbr§Àà†¯^w`"ÊòU7i¬[Ğ)ßÖTäBõì¥(!bjX%4X¹,“)Ô&ÃŞá¼lõ§2ƒóÂ‘ŒŸ§Oˆ·ßŞ»š‡3ä¨³8ód§3şqİ¸Áƒåş–âÿw¾q×éY¼ôğ\œÍüAÓ~çAåá¼©Ë«Øò8§‰L‚¼áüÁ$wŞk{lO5ÿ/¤÷tŸÓzõy±äo|@'ŸÁôÿÔ  ÿÿ PK-      ! £ï»e  R                   [Content_Types].xmlPK-      ! ‘·ï   N                 _rels/.relsPK-      ! 3‹l  µ               ¾  word/_rels/document.xml.relsPK-      ! 'ÚŞ§  š
               	  word/document.xmlPK- 
       ! %>û†¬5 ¬5              Ş  word/media/image1.pngPK-      ! ªR%ß#  ‹               ½B word/theme/theme1.xmlPK-      ! A"–”¾  
               I word/settings.xmlPK-      ! [mı“	  ñ                M word/webSettings.xmlPK-      ! Työh  á               ;N docProps/core.xmlPK-      ! V˜Q¿Ë  s               ÚP word/styles.xmlPK-      ! Ë?Ä  í               Ò\ word/fontTable.xmlPK-      ! †=ÍÌ  Ö               Æ^ docProps/app.xmlPK        Èa                                                                                                                                                                                                                                                                                                 1475,'H','SAN JACINTO','SAN JACINTO SUD','TRINITY',1854,2044,2192,2356,2492,2613);
Insert into POPULATION values (1476,'H','SAN JACINTO','SHEPHERD','TRINITY',2603,2868,3076,3307,3498,3667);
Insert into POPULATION values (1477,'H','TRINITY','COUNTY-OTHER','TRINITY',2974,3216,3241,3149,3295,3447);
Insert into POPULATION values (1478,'H','TRINITY','GROVETON','TRINITY',655,708,713,693,725,759);
Insert into POPULATION values (1479,'H','TRINITY','TRINITY','TRINITY',3051,3300,3325,3231,3380,3537);
Insert into POPULATION values (1480,'H','TRINITY','TRINITY RURAL WSC','TRINITY',4459,4822,4858,4721,4940,5169);
Insert into POPULATION values (1481,'H','WALKER','COUNTY-OTHER','SAN JACINTO',8238,8585,8834,9068,9250,9397);
Insert into POPULATION values (1482,'H','WALKER','COUNTY-OTHER','TRINITY',7174,7112,7068,7024,6990,6963);
Insert into POPULATION values (1483,'H','WALKER','HUNTSVILLE','SAN JACINTO',33854,35479,36650,37748,38602,39294);
Insert into POPULATION values (1484,'H','WALKER','HUNTSVILLE','TRINITY',6934,7267,7507,7732,7907,8048);
Insert into POPULATION values (1485,'H','WALKER','NEW WAVERLY','SAN JACINTO',1085,1132,1166,1198,1223,1243);
Insert into POPULATION values (1486,'H','WALKER','RIVERSIDE','TRINITY',565,613,648,681,707,728);
Insert into POPULATION values (1487,'H','WALKER','RIVERSIDE WSC','TRINITY',5206,5738,6121,6481,6761,6988);
Insert into POPULATION values (1488,'H','WALKER','THE CONSOLIDATED WSC','TRINITY',142,161,175,188,198,206);
Insert into POPULATION values (1489,'H','WALKER','TRINITY RURAL WSC','TRINITY',339,376,403,428,447,463);
Insert into POPULATION values (1490,'H','WALKER','WALKER COUNTY SUD','SAN JACINTO',3372,3585,3739,3883,3995,4086);
Insert into POPULATION values (1491,'H','WALKER','WALKER COUNTY SUD','TRINITY',4500,4785,4990,5183,5333,5454);
Insert into POPULATION values (1492,'H','WALLER','BROOKSHIRE','BRAZOS',5811,7107,8544,10112,11844,13722);
Insert into POPULATION values (1493,'H','WALLER','COUNTY-OTHER','BRAZOS',12019,14798,17882,21246,24963,28994);
Insert into POPULATION values (1494,'H','WALLER','COUNTY-OTHER','SAN JACINTO',12879,15309,18004,20948,24198,27724);
Insert into POPULATION values (1495,'H','WALLER','G and W WSC','BRAZOS',953,1293,1669,2081,2535,3028);
Insert into POPULATION values (1496,'H','WALLER','G and W WSC','SAN JACINTO',2925,3969,5127,6390,7785,9297);
Insert into POPULATION values (1497,'H','WALLER','HEMPSTEAD','BRAZOS',6726,7843,9081,10433,11926,13544);
Insert into POPULATION values (1498,'H','WALLER','KATY','SAN JACINTO',1468,1833,2237,2678,3165,3693);
Insert into POPULATION values (1499,'H','WALLER','PINE ISLAND','BRAZOS',1112,1256,1416,1591,1784,1993);
Insert into POPULATION values (1500,'H','WALLER','PRAIRIE VIEW','BRAZOS',6060,7167,8394,9734,11213,12817);
Insert into POPULATION values (1501,'H','WALLER','PRAIRIE VIEW','SAN JACINTO',549,649,760,881,1015,1160);
Insert into POPULATION values (1502,'H','WALLER','WALLER','SAN JACINTO',2036,2219,2421,2642,2886,3150);
Insert into POPULATION values (1503,'I','ANDERSON','BRUSHY CREEK WSC','NECHES',1751,1808,1829,1829,1829,1829);
Insert into POPULATION values (1504,'I','ANDERSON','BRUSHY CREEK WSC','TRINITY',1028,1062,1074,1074,1074,1074);
Insert into POPULATION values (1505,'I','ANDERSON','COUNTY-OTHER','NECHES',6218,6421,6495,6495,6495,6495);
Insert into POPULATION values (1506,'I','ANDERSON','COUNTY-OTHER','TRINITY',20528,21200,21446,21446,21446,21446);
Insert into POPULATION values (1507,'I','ANDERSON','ELKHART','TRINITY',1431,1478,1496,1496,1496,1496);
Insert into POPULATION values (1508,'I','ANDERSON','FOUR PINES WSC','TRINITY',3595,3713,3756,3756,3756,3756);
Insert into POPULATION values (1509,'I','ANDERSON','FRANKSTON','NECHES',1263,1305,1320,1320,1320,1320);
Insert into POPULATION values (1510,'I','ANDERSON','PALESTINE','NECHES',10022,10351,10471,10471,10471,10471);
Insert into POPULATION values (1511,'I','ANDERSON','PALESTINE','TRINITY',9509,9821,9934,9934,9934,9934);
Insert into POPULATION values (1512,'I','ANDERSON','THE CONSOLIDATED WSC','TRINITY',1669,1724,1744,1744,1744,1744);
Insert into POPULATION values (1513,'I','ANDERSON','WALSTON SPRINGS WSC','NECHES',2860,2954,2988,2988,2988,2988);
Insert into POPULATION values (1514,'I','ANDERSON','WALSTON SPRINGS WSC','TRINITY',1142,1180,1193,1193,1193,1193);
Insert into POPULATION values (1515,'I','ANGELINA','ANGELINA WSC','NECHES',2999,3209,3385,3546,3689,3817);
Insert into POPULATION values (1516,'I','ANGELINA','BURKE','NECHES',793,849,895,938,976,1009);
Insert into POPULATION values (1517,'I','ANGELINA','COUNTY-OTHER','NECHES',17360,18575,19596,20526,21358,22097);
Insert into POPULATION values (1518,'I','ANGELINA','DIBOLL','NECHES',5137,5496,5798,6073,6320,6538);
Insert into POPULATION values (1519,'I','ANGELINA','FOUR WAY SUD','NECHES',5666,6062,6395,6699,6971,7211);
Insert into POPULATION values (1520,'I','ANGELINA','HUDSON','NECHES',5088,5444,5743,6016,6260,6476);
Insert into POPULATION values (1521,'I','ANGELINA','HUDSON WSC','NECHES',6045,6469,6824,7148,7438,7695);
Insert into POPULATION values (1522,'I','ANGELINA','HUNTINGTON','NECHES',2278,2438,2571,2694,2803,2900);
Insert into POPULATION values (1523,'I','ANGELINA','LUFKIN','NECHES',37713,40352,42567,44589,46398,48000);
Insert into POPULATION values (1524,'I','ANGELINA','REDLAND WSC','NECHES',2594,2776,2928,3067,3192,3302);
Insert into POPULATION values (1525,'I','ANGELINA','ZAVALLA','NECHES',767,821,866,907,944,976);
Insert into POPULATION values (1526,'I','CHEROKEE','ALTO','NECHES',1341,1470,1597,1749,1907,2079);
Insert into POPULATION values (1527,'I','CHEROKEE','ALTO RURAL WSC','NECHES',3272,3588,3898,4267,4655,5074);
Insert into POPULATION values (1528,'I','CHEROKEE','BULLARD','NECHES',52,57,62,68,74,80);
Insert into POPULATION values (1529,'I','CHEROKEE','COUNTY-OTHER','NECHES',9739,10678,11603,12703,13859,15104);
Insert into POPULATION values (1530,'I','CHEROKEE','CRAFT-TURNEY WSC','NECHES',5195,5696,6188,6775,7390,8055);
Insert into POPULATION values (1531,'I','CHEROKEE','JACKSONVILLE','NECHES',15914,17451,18959,20756,22640,24677);
Insert into POPULATION values (1532,'I','CHEROKEE','NEW SUMMERFIELD','NECHES',1216,1334,1449,1586,1730,1886);
Insert into POPULATION values (1533,'I','CHEROKEE','NORTH CHEROKEE WSC','NECHES',4901,5375,5839,6392,6973,7600);
Insert into POPULATION values (1534,'I','CHEROKEE','RUSK','NECHES',6074,6661,7236,7922,8641,9419);
Insert into POPULATION values (1535,'I','CHEROKEE','RUSK RURAL WSC','NECHES',3592,3938,4279,4684,5109,5569);
Insert into POPULATION values (1536,'I','CHEROKEE','SOUTHERN UTILITIES COMPANY','NECHES',2805,3076,3341,3658,3990,4349);
Insert into POPULATION values (1537,'I'PK     ! >RHèq  ¤   [Content_Types].xml ¢(                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  ´”ËjÃ0E÷…şƒÑ¶ÄJº(¥ÄÉ¢eh
İ*ò8ÕiòúûíÄ”âÄ¥I6yæ{5ˆ7F'+Q9›±AÚg	Xéreçû˜¾ôîYQØ\hg!c[ˆl<º¾N·bBj3¶@ôœG¹ #bê<Xª.tsî…üsà·ış—Î"XìaÉ`£áb©1yŞĞï:I YòX7–^Şk%R¯lşË¥·sHIYõÄ…òñ†ou(+‡vº7MP9$ğUêâkr;¹4¤LcZrº¢P}IóÁIˆ‘fntÚTŒPvŸ¿-‡\FtæÓh®Ì$8'Çi %*hfxp·âù'Qs»í‘—°#wFXÃìıb)~À;ƒä;3çÑ ;C m¨¿§?È
sÌ’:«·O[%üãÚûµQª{şO¾q$ôÉ÷ƒr#å·xójÇ¾  ÿÿ PK     ! ‘·ï   N   _rels/.rels ¢(                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  ¬’ÁjÃ0@ïƒıƒÑ½QÚÁ£N/cĞÛÙ[ILÛØj×şı<ØØ]éaGËÒÓ“ĞzsœFuà”]ğ–UŠ½	Öù^Ã[û¼x •…¼¥1xÖpâ›æöfıÊ#I)Êƒ‹YŠÏ‘øˆ˜ÍÀå*Döå§i")ÏÔc$³£qU×÷˜~3 ™1ÕÖjH[{ª=E¾†ºÎ~
f?±—3-ÂŞ²]ÄTê“¸2j)õ,l0/%œ‘b¬
ğ¼Ñêz£¿§Å‰…,	¡	‰/û|f\ZşçŠæ?6ï!Y´_áoœ]Aó  ÿÿ PK     ! ßµL¶
  ¿   word/_rels/document.xml.rels ¢(                                                                                                                                                                                                                                                                  ¬“MKÄ0†ï‚ÿ!Ìİ¦]uÙt/"ìU+xÍ¦Ól’’™Uûï+»ÛÅ¥xèqŞ0Ïû’ÕúÛvâµŞ)È’:ãËÖÕ
ŞŠç›ÄÚ•ºóH°Î¯¯V/ØiKÔ´=‰Hq¤ aî¥$Ó Õ”ø]<©|°šãjÙkó¡k”‹4]Ê0f@~Æ›RAØ”· Š¡Çÿ°}UµŸ¼ÙYt|¡B2Ç›QdêP#+8$Id¼¬°˜U‡Çûyª>›³Şìˆ½}mGƒ$9¥²e´Ù”ÍrN»x2Ù¿á¤Ãıœ•w\èm7ò8FSwsJ|áöõÏÛ…yöíò   ÿÿ PK     ! 3„–L  »Ä    word/document.xmlì}i£J³æ÷‘æ?”úJóÅ÷ö­Îí÷Š/ØÆ6ÆøË;Ø0;şõÃâr»º«N/g4êî×HUfÉŒŒŒŒˆ|2ÈLşë¿ëSøT:iÄÑÇĞŸà‡''²b;ˆ¼Ôğùá)ËÈ6Â8r>~hœìÃÿëÿ¯ÿªíØ*NN”?µ$¢ì¹J¬ü<O ³|çdd+³ØÍÿ´â»n`9@§6 ƒØŸ%il9YÖ–ÇQid®äN_R‹'jºqz2òö2õ€“‘‹ä–zbä„AŞ´´Aü…LüñC‘FÏWÜê²<]^r¤ßRî…»J /H°å!2?H>UãG©µı"åßU¢<…/éªBÿYp©Qµ?Ÿ~ûöéœÿ=Eü†éHÜr|¯Ë|áädÑ§‚H4wÂ…°ï# N ñşYãˆi\$Ÿ¨ÿŒÚ8:Şhu–ı´®|_µìŸ1³ö¤µÀ“õ<ö¢85Ì°å¨m²§VêOZøWëqÌØnºßä©zn=–½úøAAäÃË-Îq"Ìï ÿ¦Yæ0¦\úòx™vOHƒphx²L»Ÿ(^¦qìöäıÀóÃö/o3•FØùü0Œ«®làš¡m':Ì42r‡£¼õZıMÖÛV~Z9ç"HV'Zï‹¹ºˆö4y6"ËÓ';ÈòMËÍ‡şŒ¹ÍÚnBğz¹út™§$t–qÖ§ÜméHNÇëÇp['’ Öõ›DvëOÛ¼ÂØ::vŸ'4š¸ÈÇÛÖ¨ft5[´ı_h$ıN×®Û<(‚ñˆ@Ò×äİmbH\`à®nÉó¯§º/¥éşw¢L“8º>Aº±+¤qÛ'XqXœ¢!{›fáº™“ÿ#QÁZ)ßß|¹è¼¢ºıŒjb¤†—‰ÿ9a¥`øo	oûNİ5å“ÕÖÃq¡ÚÚXmuˆBAì¥Rë:VÎiÃ¾ÊÂµMÒJÇ öÌìÚ£UÌkªejŞâ‡áªËô)håH}xŠŒSkê½k{¢®É­y)vÕ,!m/Óö¶ñÜ×,°®.Çø©ïîHqFn<é?t¤ƒ[î÷+/Nú*$ë¤ç½»áW]éµ›ºß–îgct-ğ·â7-1äCH‚ÀïóZ>Í“ B’Ğ57Š‚$Ú§^
^±Ôºïç*ë9Ï:Î¯­ƒ€ÄKûl:¾˜¸~‚‡&ê“u™Ÿòº½İ™NÇA–ÌZcË¢˜õÈsè4+ß1ì¬KÑ;OY:YGÄ¬äØn‹1Š<î	}&"‚q#ß…!‚5EIA^WÔxNÒ,øôÔ|ü¶ªÛa”³,’¾$é«‡-aØ_¤É†éSï…ş¸R•,Œª¤ğ.	°?Ş"q
Zwú­“·DÆs';>²ûóÜÂáèŠ¼
³“ß É¼6ëÎ×v¿7§üYoÑŠi¹|£·xıdyw«'2tYbX­Æ·‰·å÷ÅÏ=¬—¾ÂjKuÒk_qÍÕÿkPw«w;İîñOÅË/Ş`°»s/Ï^æWI·g"iõ7Øv$íIÛw\ZNÓ®KÉÎ…‘¶È&G­PPk‹­·ì/PŒ€;§yÿÄ¼2tC?ä/§lŞ×©S†(¦[[qƒ^ƒ?qr½¸óVı$6 L@½IC 
ÃPïı†ıë6üsövùoa×ğÏÒWƒ8ãèÃ°}ÃF~nÃ^ÿ›X6ò…e€ÿï=6I¶?,û×·lôç¶lVø÷ÀâèÏÒgßB	0ˆbşcÿ¢vİÅø~b»æ‚N5âô­PÀïgİØObİDµŒİì‚öı‹Ú7şkØ÷[ßÏ¾ñŸÑ¾)ŒêŞÀ<ìû—´oêç¶oÙˆÏù7é¾–—_pkÑô	?ºï_Ö¼‰ŸÔ¼Í8>vSéÖ¹‘vÓ>:õ»’ø1fë8PzIÛ¶Ã-eÿàZÇğVğğ÷säÏ2‚':Û^§=œÄ/í$ÈŸ¼Ø÷[!ÄßÏ¾»ÉLƒ¯óÔègÅõ&ûÔÖ1êåğ4XÚ5]gü¼hÜ``On$Ò‹xcV„ÁèM›_l…!¼«gg³ÜÚ,ö÷6›]Y¼ñ6÷w¦ñ5#dÙ·ŒğjaOy“t.©“Ç5Ùæ–åMèå­·ê'_ØÍ¶rnåV§uƒ¼¦îR¹m¡·ŒCsşmÆkú^ıDµïÉ|ËÑ—Üªñ-ó)ˆâô-y}+yHÿ"¡ŞŸ´íE÷şVİn³3ŞW·¾¸¿W·{%Ã(ïæÃ¿§dbèµcÀ`¸ùİ‡’ı®Jv›*ğ¾’İ£˜ïñi÷³z.í¡m­`n¯¯ß×¶û÷Ù_wi/ï.í¡d/Jv{“ú¾’¡?èÒîÃ«íÈ‰ {¾?iŒPˆ¼ø4¨U½‡ºıîêv{µ÷¾ºõÛ7û´{˜ö¦’á$
İ|Şú´GÇù»+ÙíıÒûJ†ÿ?U²öP¯õº½ßx_½ˆïR/ˆ€@²ƒ{]k=õ.»êŠÀø0uğ¡_¿~·…oÀ«•u÷×]f}Î‚‹³rÂÏWCŒÔëWæõ‰+×;÷ÿv¤ïo\¯_¨¼&úùbÈ/ˆEï©^ï¼&»í¯¯k@»óO‹WÛ×~µ«`„¡iXÇu‘ÕÀj	•m}»…ŒÕ;‹H;»{Yêø·šÕİøŸºSÏÿÉ Æ»ÍšníóËºÌgÃlõµÈ¿†úü:nşŒâ‚X’¿ÜËãä‚ş$º[U'©gÅş$Ú+¿¯á3ŒAv/‘íÔÏt‹eaCÑ¿NYüGŸçñ=Tû'CşÏµfÇ©§A{ÑÏ¼ŞéDx]}øŸı²Ã®–[Û­:|ü òÇ0
Íxô˜n±ÂÂŞ%X^{±à™öÿ¦»¯óÒŒVaûçn¥°Úïæö,òss²^)*ÁÉ#üŸÿ¨é¿(ğ`UîX›¨8¡Ğ^ˆëSp²±$2ÇM=íÅÛˆ~yÀ°®WÚ<¾ TeÕGAç~.”ó_Ñ=A0Ãt<H±2§BšT7®òd*%R˜¤85uméĞÔëS¬]ı2R×‘¶Ô	ºpçcÃâ2?‘kŠN8 æz‚‹p“Æ©¿ƒCÂ“µ€Wö<?°XÍ	TÂ›FgÌpSA³& ¥)`s2‚ÙÅÃ¦6»§³Cii$…ô×êâ¼«¢Æ¥^$å“M½È—Ÿ7wâÖ*kÔ±:G$Aûì´’)Ş–3G‹³^nr8”ÁÁ£æ@Óœd;ÇšÁóHãğÙŠŸ€J¦¿l,Ö u5QºÆšu÷wÈ$4%¹œE“°'hJ‹ãQÎÕ…–ıbÄ•úråîD£ªƒÃ&@±L¤ŒÓƒ“lh ŞÀn
Ëè’‘£ÔTM@¡Ğp_ ójàp;†³E«ÏíÎsİé…PX›åŒc”7Yÿ"Ö¨K‰+Û„1IÎtÿ²•ˆ…éìL™ÁşXk‹à¬÷aX6©u¹€B(W8Ìå	©*}Öé™(FÛJû(Á@&0ğbF›9¿ExL¹rIc(ZY£!T8Ò€rÄ”`¶lÂ+‚¥é‹À1Pë,ª€“"‰UVì{rî	¶Âöff5±<•¦½îì£{¸—&—¬6&¸*õCMí’iTØÀ]uJ*‰£ ˜·‘q¶‡ÆáæPlz‚yrÄ…¤’¬Mš6åˆ…hF[i3©ÁÀpD)P
E\@–DÌ»Ñ…àrd{˜Ù &¥hUÚÊr¿{‚FìÎÁ²Ìw‹œtósaqHÕõh4Âr|v†G@a7óÕ
Qf|>B¼_p‚Ö¸ÖH¢Jfšk¼ ~Aè‹n4‘ç¡û}.Ô–·ĞŠ±r8¢Ñ&’¶Q-7¬ŠÚîFç=’ØIyJcµ¼(ó´ÚCŸĞ'¹‚¨•öG&ŒÁFğ¡†1Sä–ca[®’Ál`JIÇ^€ïPÚ¸Û¼YÑÁôb£åfc/´|sÚ$8Ğ¼ø¹döU
ÕQÇ¨:‰%˜kÑ Œ¤PÜÏÃ/tK3Y=o±Õì,íûŒ]§µ’zH3O+"/5–†*¯ê8Y*Ç9ÍA…iÁxQ°NN(pj­,ÓÙ"sN³K‚Ğp¦şYÃ1WƒÎìèîı#œËñ¥™l{‚"Å.+ä9kæ«3½Š0.p«QrjÀ½qQ™İbâé”¢ÆÜÖ¹DSbtt˜U\lÕ:ğ-Å™eò&Ş˜šp†V&ğÁ3px??¨³út(`h>MéeƒÅæÛ*Cg3?ßj5)V[uî*4ÉĞÒz5ãÆ—=c£4u e«'Xûgd*Ï}‡Í©jŠõ¾0¨£çÌ8P< éÙË
S§ÆœÑV*Y'dîLÛIxb¿O/g‘ğ<r›»ç4ë`,xHÌ€Ê´Â‚ƒ5Éx‚À#±Ìj‡ú8‘‡vb1ÕK?ËŒ¬z‡µ]ÆúfŠ4nò›FN¨¢ â -{‚PºÆÈÛC;”İ2Ùˆ A™ iav ¨zòØ!$ÚĞO5H£“'ãtCó„Nîˆ\M8çTĞ—¡O‰­4^5ó\½ÌOOÎLq{§Á“Œ±ög  <›r	4)x±KÆƒœÆ ëM3„I* éÅl
Ì–Í‘’!)'4î°ã[‚§ÍDgnR-·AdhÊqg¹‰ª3´qø%'¶$©Ékmƒ´\ö£lç{ŒW8>+c (–üŒ¬%Ç›P‘L`™-”&MX—Ñõú¢Í4fî°“‰ÕvĞhÅîç{¤©gÂ¡'˜YáT¡ga+_ô ,õlë…ê…Ñl]Ã3=k˜"ˆ¶k°Œ‚ÍÈÜ…,µôl4üaÔ¬Hk˜bÓr1¼µ%J'mQë‘,hxnVÊĞôôÈŒp/hÒBV¢ÌƒÔZ\‰‰ Íà£âíy¤îp‚8=jsZ†tf3Ì,¤·Pie#ùp, õõ8­w‰f‡8²›‰óÀÖáÔ¼Èg&jönM§N:Å†*†úàmŒ•¶"¡NLÅğ¥sDãxÓh1"¹9Ì2€ÌŒ™lâ³"p~zÆE%;WRKÇS¡D3@¦ÌV[ª'83&d:')Â¨háFÛ)ºœo7K›aa+'áIwNµœàtN–«ëµÁRÛÛ¶»ŸàÔü¬/ààœ;¥1Y$:]°¶Çµà¦k­¾ gÃ c¼Z“#%?µµmæëÖä)9ÚÔáHM”æÅ¶Œ†şHÁğî¢‰tqšin–§B+.X¹´–»)Â@¯fÑtQZ©)Rê,Øh¶i¡'x=?fÔ†:7ÄR%Å®
Ü$½ŠÔ5¢ìÑòt™€ŸûéÁç©üRĞyinYæúFˆV-r~°F
=¸uæø¦M÷ù‘7MàP™ùé¶XEÛlYº6K»
‹T•ë˜,PKS©lÒqS¥í÷„]4£%CÛZ0ñ¢s;š]¢çl!«£ !/·ø	µ&L”|Â*µ_˜1%íÇá%B%Xi­
áYSÊqt:TfƒT’„516/A-â²ëÇ€ğ!-03ºRÚ^^§Ùî	ËÓ£DŠî‚ĞJ‹ªöL\5VCMÄ.¬Óîá0ß,­d†t7pèÃê´´·ó±/ÌåZ\å•lé"Ì/<1É¤ÌÌ‚bí^
@Tl"Îbdº’l½‹UºáKæiÌFËµ,±…DK¼a<)ªZ>×ëj¯¸)Zò~^öàîRgKgË²;q¯¯‡¢B5=7û#Tì\mÊı.‘—{ˆšÖ–õ&RÓcãk³JÙf“›K9«S¿Õ™ZF×Ï,Ÿ!#)Ÿ-#‘™Z‚#}ë/Ü	€º¾ïÊ`ËŠ/¯¬nâ£¦ïwüX?)AVª-™›£éøÈ3A\¯ [‡W—¡ZéÒtkéAmè™Á-&³QwUxšfä¾5¾8„œkÑ&¸×0p­0KÜ^vë•ÕÊºâÙ™B«Á»Ö],A ôîBíZ—íZ÷õQv÷ïqµ)Íß'8fa’İÛZ0šÜfäúš¼:Š®v_bÇËÁÛ´”¿ªƒ¯vV½]•6Œ5û^8"”`‰oaóÀI+ÀtæÇâÒôÇ}¢İˆ9ë¶şêÂ/ıèø:Îa~5¦„!ÿ³ÿ?Œœón[›&1r¿ìÿg8<L‡„áğS;Cy§CD×áu?¬‹u”Ï'/5ìÀ‰ò™øØÏ"ŠŸ­!ø4Ä†ú	q]àãåÿ÷¼wùv@<äúWzwpßêûù@×|7]ïeôŞM×û«²ëş†ÏıièC÷ÔHşèÉ>“§ş*ÿÈ:ÿc?<çqò•18WQè™ ÚF¦ãoƒ_Ô”—N\":+ù…~6XâµÎà¹$lAWçƒ“i{0»u››#Ô‹ıÈÈõ"ÙRy"pó¬¢IÁ¢)¿¸,æ”	±mÏ¾!U›å‰˜ÎQÛ²Ñšã¥Ròã4³§µ¿fK{ùX¬5Xe¤“›äpw©Š£zp8H¸Ù¦öÆ™ì¦Éšo;si;“vøb½©Hhşyš”P{Ò¼¬§–¡®]v44÷•}a;*Ïİ‰:`NeI™pYuMÍ€0‰êqwO{¬jüÃz5QH}*–Ó’µËø8C­¦R¡è†9ÁıjíB=\\b9Œ,L©8ŒöJA] Õ¥[g³ ºbZó”ù{ïDs’½ƒ¥uwq¨Z»¢³öqÛ!³²ëë³ğµRi)'ÓH Ê£DÊ²N4æİ:ëÊ!Zü>ÙˆË™Æîs„ÀO²à‹æ¥<@<" Î/lr2'hOğà™ÚF)¦ñi¡0çáH­»:»örÉ¯'¼Œğ¡‡0@¨(¨aë·âã9œ"ãÏÖ{Êj0‰¹µ5ïç=ÁË%ôÎšìØü„¨t	LN0²(©“2³½óY¾ÇTArCíH¿†ÉËúb…ä¾çIñÀÈÜ3bê@ì–nĞ™LV uQ1¨V§ñ½ºâhgä¦m¯vó¾ìä×uÁoõ¾rCÁ¥èØ	˜Æ®.ì¥¾¢ĞZCk	lçC›&3€ñeËÇë<_²Ë2ƒÔâæŠz<Ì×$¶l¬zÖÌ!uÊí¤M¾eÖS›\ø|r‘£åšØnÏÇ*ß¦S©=#ïq È4#Õ!JĞ:a«»ÿ>@X/7pÆÊ«O Û‘°ü.NN¸Ëíó|¬Ø‚i€Zy ‘A—„iû9ˆìbå3¸$š§9Ø&xğ°ˆ¦£ü|ñöû5=–ñ<MCÕZú7²<—ç4XğNŒ	u3D]Ù«†¾Ş5§;j“+Í1ğ%xÊcWÓ²à˜j‡UÎÜXMvë©ÄB<j"'ªh èL0MPİ
#¤$4Â¸ËI~(1Ä=\Nüh† y!Òy½ ùÂßÍR¸"Uæú¤–ã¥yÚy<¶/?ï÷{‚¯ÌkÉ!AZRİê}¿?Øò]çÿJ¯lÈÕíÎç²Ëwúıâó~ÿê>uşŸ+ê:úúHnı>2õ3ìúè^=:ıRÆ9ı:$;¬ó¥n9¡ç=‹½µ¼:&^Ës´"y2ïE
1[víàU¨â²%LsPwxƒ,?õû]/eÆËşÁ.	ß¶cÙ¨_°Ë»¸…üÜÒÍùû«ÑMÌú`à€y ˜€y ˜;î¨²A‹¿£»ÿ>€Y-×=€aG, .u%qj†­@V‰ÈÆ;MLpq¢ƒ-#êE›L	Ó…I>6\EÊ…;?™«hstEh_mk/à©c[‰#µ˜ŠÆRMC¹¯O¼-€‰"æ0Y¶—CĞ¬J URÇ‰îÙªcs½9¼l¦ÌÒä3«°Æ¸×ìLs’™q›õÂåÌÙº%6I†‹ XÚÕÜKN=Á#Œ (b•£Ej‡v$înSÅgG8”Hëo	Œ¦„ƒ—wPVš7V'Â›E}B=ÁÁ’KgZ `'Í Ãü—ø¢?Şõ‹mcò$ kdKù`gÂcòöâïÕÁ¢ÌçvlAï¼Ì*ÍQ”ö‚;v·º³ÏoÃ‚}¿…X­®VÅÀ¼¼¡—&YˆQÇ!÷·º`ÏëãÔñp§jƒ·yÑ·VŒÒÅfÚ²;£Yª+"=Èò.hñ€—ßbWÆïÁ.ÔÅ\ºİ
ß/èË¼<ÀË¼ÜsÇèIÊ”o/wÑp
(ˆ'ÌF““îr(ğ‚|˜[[JuàŠ58
&Sş„›)E©õ5úBÖ²ÏE{±"ÍmÄ¨Ø”½E_¸óè°º‹¾lºè„‹l5X
˜bD)¶ôÑ±¾ë!úÂ:İìGß#?UÓd·G„Û4üÉ¸œ7Ì©˜³şÊ§äàrJĞ6Åñ†¡H\N¶@Ö‘(Æ²4ÌmÍ2£’vËÔF´Œç3Á‹³+;}`®2ü$Ü
`[~3¦ñc f°eèM‚?`[ó.€¡õbâ½¾€ŞëÜÛ fòK˜ßc÷Ù¯"˜»M]ß˜Ú­+úˆL·SëÕ<PÍÕ<PÍ×P¡M9ßúTÓ¿S¢§åJA´Zƒ4|1ÅI¹=Ş¿SB6—Öµ$E„w¨†„ïPqjæ>À‰ú'T³u›L¨Èeö	Õ°H÷Né[QÍ®E5¢hln¨nQMØéÕ4$®#ƒP(,Y’•àˆ¸“îÉëwJãñ
àÉ¤³3 ªù:ªÃÀCwTÓÃ†ßcçíïˆË ĞÅeH¢Ç/ı~ÔWJüòÀ/üò6wXœ™äá—>*»l3‡âÔH·oÌÅoŠÊĞ~±>ÊŒîğK•Ù’"[sb~(*#uøe÷)*“İGevMC¬±EŒŒêğÂi®]ÛjL-]3ß¢2Î]T†}De¾¿,Œ™HüÒ„ßéßƒbàA1ıÖ17=â0óÀ1óÎÜ^Ëÿèí¨] ­Ù¿]šJçÔ%¸]=2°`ÑÅaHĞÇa½âI’é¼Å1F‡¹Œ²¯÷»İ´@%_§ÖÑ„c‹cÜF”mÃT\#*Ci³#ãl¬ïG]™ü"Ù­÷•º§$ÈäA·4'ÙÍ:sØ1›F×‡é†9¶8ÆÛ¨9K&#Êw†Uƒúr
&AÙ¥5G3Âƒy˜”P
-Î#ª*–G72ù ÌÇ w%)Y!âÑXQİ[ÕÇ¼‹cÆ‘TÒéÂïô%•ïÁ1È?Ä1İ÷E8æc8æcŞæÎY©dÉßc†EÌëÇÌ€
OwGÉ×Û3Ä¶ÜhZ.¥c —ÅNç%HP%«E˜ŸË´˜…ISÎØ×ªH‹tÚ ª4C‘ª9%Œ† d?©tœ1ö²Ü„ÃŒ\8$°€J¨)ßL)Ê*d`”ØX%BLçHa^0oÕCA®Ò Á6şD=*4õı¸LåÔ,5î	fXcK·Ü¡	¬¬9ñÀˆ ç~¡³¤®½YÙH •˜éšjl‹Ò£MĞ-Ü½Éô

z‚_óƒ_Œ©ÀTa‹ÛÂ(ÕÙ1¡¯ç~‰Ş´Û×Ç¬[%PÍ^«/³ëÿ† \2{¬Ÿ»P:¦¾ GO•Ü¸éìàmzÅ}{%Õ‹~½R­W«Zğ¼Ö(İ/Pş|m2¥´gc2ß¯MşpÌoôÅ¨ï1èÀ˜şKJpÌÆ<`ÌÆ|ÆáIğ¿'£õá˜5 »‘ĞÓ2öOçÑ$, ak37ŸGÒa?l3CV]8fm»eyBgJ§ò$6¦Fà^ºäš*l0™g$¡°-8ôÊebš‹*‹¦Îôfêz>G•óªá†d¶óÌt!á¦Ú˜_êÉôì³† 'î_)›Q=ÛI [d²øöÔÜqº6WG|³gù9äW»éé’äÆŒ$k,L/§Ñˆ8#°#­	4>Eª>3K;„æçÑ< –cy]€œÁTµ!Ãb£7V+]eøÇÜ{f¿÷uóéqÂ¯ôe<¨+é›¾Œ7|ªçó˜Î7}ï{ÀöC3lº/Æ=ÀĞ=ÀĞ}íI}EÉßõnª‹éï¦^b:ğy_Ôı´Ò&%¥ ğ(ó†Më—ÁD@Ôå!GÔi+wé4'çÇ3…‚q°Œ2›&I†üeóÑr‹³$-ìux±æ—qÕ$€(®?½›ší4¢[¹]0aX¹}gMÜàıÂi6wûÎdù|Û9±nûÎìB©ÎˆìºïLkã×Í—ØhtÈv$4kxĞ˜®ı à¦+‚r °kÍÀµ‰r2Ñ‰è†¾†DWäİÍõ@áwúèßá˜/vıëfÙ|eÓ¿.IüGİoÒwÛşï.­óá©ûrB—Âí›¼ßâ¯ÿ¶Ãuk¿îqwêv´^íòµ”»JÇÏalŸÊîÛ?8vĞæºñÜÑèóîN€÷­Ğ·yá_ ¸®šß²[`¿Æ«ûÚËÆÿ­^ğ[÷}½¿º/Z=×ßãî§O/ŸâøMœ"ìû¬EüxàÇ7<×#z$œµs,éà%‘Î•í­ø²	6S"ÏÄÁœƒX¼Óâ¹UÏ‰ÏÉGÒ¡²ÅsS…¢Å`ÄÌ!R³…‰2_d‘aD‘f›@¨0ò|Q‹`4/l4]íºÙÒûqÀ,‹„>“îøÚØĞÃ¼çIq.BÖiS^mÑf/,p-e½”¤í¨œĞ¡x,&¾°Æl-‰õLÍ÷áŠr¥ú•¹tgÎmĞµà¯2Æ¶VrVyteiÕ"´å‘¨8RKÖîAßèM°3æGºrEÜQd®½M¸æÓRÖšƒ¾š[|ƒpÑ:¼ •·Âğ.07óa\>Ùùu.»xı{˜îÿ²÷]M®ZÛÖe—¿G®MÁU¾U€PD"	Ğ­ï(@ä$à×_BwïÚÉöñ9¾İ€`+Í5Çk¬¾ØÁÁĞJÒá>İ”†ÃAß§Õb¾“Ú%ñà…Z9d{Tƒs­k]­šòL]ùıu³ÚïÁŞ%ÆI+bõ¨ÕÉSyÉ#×‰MËb© Ğ¢HÅr«±–±šßÜ8%œË2hN"´kvxµåÙ:.I„*;:¸â…ûó‰Å#ºØ˜”‘!+nÆk“Vk°8(±¯ÍWëlŠ¦GĞ„gª¬·&m#[C"ä‹Üù‹¢K£¬Í»r/ü¡—3×)ÊŠ†¿!o©5×ê+N’M@½\K¥Å–A¡$ÔT:Ëí=Àğ…Ğ½Å™kÖLlÂ]…õiúu-ÿ÷>sLôix¢¯Ñ,ÔQ¹¶†Zñ¾İhğuïöí¦¾Hß!4—±GŸ;7Ç¿_¯Ù¾‡¿  €ôH_©¸%¾²™#»ô'ƒ›ú´e:Älrå´Ììí®Ì) ¼ŞüsUR`çÌ °r?®}û|êìv;Z\6Â´”“|TvÕ!Ÿ<=¶±|båvˆ|îpÈ |¿Îk)®†±ØVè™ŸWâz^¨ºjn‘zÓbä[ˆÔ(±)rFxš‡y,™‹Uî¬e°8Y—·‹¯Â9–rvÓÃÉÒ-3Ä¹áqG43@œä· Çò¸¦W}»}NÏ)?ô”î·‡·cuOİ¯iÀînoénİ}»íáâ§±ºÑàó€İ÷ÕŞnüå¥û5ñµLdVÕ=d¢›Q›çËüi½iîh»cûv£ÁäóhàÛ2÷¡o7Ô"VxÛ·û4©üZI8¬şÿ È}ÿ“ö¯Ûcà·Ÿ’Ô‰_{ïïõÜğ]ÏıQè÷;<÷°ÛÏ=,ZúÙsCÄÃe?\öÃe?\ö]6TPÒ±ŠÁw¸l½fwÃ:·šX‘ëÂYÔJîû}éW¹ÑàÂ –ŒNÍwT¥š#ôMÇ1èâlj¯Öb7"OY±F“Ì`ı¦¥BÿZÚÜS,<¾8b@u×9vY¶7ëxÛNŞ¡’½ÒíHuÉTèFCa¡”|/`Å«µ8I^ÉgÇz›óIƒcaPf.Ş¶Ëje„{vtÂ+gpè¶Ê"ò…©ØÜRYÈDëà<wePr¢“¨èœ<)ÚNÙ†rÎæCÌÜ™•.Ü
¾UĞ—ÄõLúpNÅæ·ôµ<•/3Ï~Š¾–Ò»#¬«2Ê^‡‡ƒuŠ™k MõyªË¯¤ô¾ŠËè›Å^ ˜Ñ Ş÷4ÌèØKªıºğüĞÁÌá6ß‹2ÀS9Ür/Oø†ğhWûùæ¹Ë¡‚.û£Æí·]ög‰Û·±6ñˆµûá¸ûG·UÅxD`Ã+~ÃqËb;Œ¦1,µ ×¢~É¨½Ö?s§n¸|3½!9?Ux-rQx‰àÂ[gJº§cBÍ±$gÑ*@ç38`n=—ì†jËùé&Âú*_³/œ5;-ÄGóu‰EÑÜÓt%F¢B÷Ë»¶ØÅù¢{¿…¿]nÎÕš#¬N‹øİqå*¸9TK$Ä‹¢ÅµE
ó›¾œïòÒ” Tè.È•;CIlïiˆr'ÀÑªĞÌfZìäĞ‚‹*v”2È˜ ˜öqu±ŞŒŸŒÿ,§=´“Á?Éi¿­Ë‚ÓüõÔ›ú.§Í´¸›™õĞè|ÁişzÊåqÚÃĞ0ıW9íû2hÅ]¿í´'í³Gœıp×wıp×¿Û]+§E^ÿxœxË–İé¤âÓ–İN!3?fÓÅB®Ôæj€šİ4¹uuçÖ¿w¨üxZåimgşkæ\¥ìN‹[*4X/Ö’ØÒç¼Á•É]K2¡fäJã1 âö¢$6Û0sdyH	¹´[v®×#h_àŞâU)>â™‡rå‹˜i¨P{8°â$CÛ‰¶4Wa¾@¼ƒÌµ›	a îô‹fh«—›ÈOàem˜ŒîÑ®ëë(eP‹˜hÂš±ê!3qöwÆÙÌş¨VÀß<ÎÆî¹lì£réw¸ì—‰¦Ù×“ÇFPŠ‚^\6á@ûá¹ûá¹éoxîëµ[Ùü¸âë7m¥/¶;º¥æ`â´Añîy¹={•Ê¦0VÊI»“ÊÕ¬Äº™Š€^o‡ˆú} Í »h…æËåj™õ·p3>Y"†‰&Â²ÌêŒ	¬¾_5Êhğ²‡òÄ\Ìam^ôP?ÚÖ^“š ‰¯õ"°›S «l.2µÅĞÕV×LÉÄ’ò¬«„íWúlb0Û`–E3UB¯3@¨¯2é Çˆ«8¥ò¨*CìÜËÎ‡¼l4°‚2e¶j#C—²{»0î”†XÁB?¤?üÈ¾_÷u— ¼;u/Úğ€;ä5ÃùçòFƒïWÇ}Ï¨}M¦]|°÷zaÜıdğcÁ½ÿ¶w‹Ö›êòë™¨_›„
HıŞz7	õ_í¹gw=÷GÅÎÔ~í¹q{™N0ÃÁöÃe?\öÃeÅeç®¬­á­ Ø&ù>Ø³hÔf~ãÊ)7M¥hŒú¼PnB§6¦ÉŞÔNø«AmeCŸ^µ	Ô"ÚãAíÚMt^áP¢HVx|Ld©ñb\`·ÃÒ¶ÔZ[œbÈW«Mšµ^B©¢»Úr‰™Â±V<SÖ­V¦ û([§³†´ÁSKu©@Â"‹Sh„o­sb`ï‘7èeP-ÜB€»8Rv³†Ds}Ê”»ë¢ı>·=U½;‹Úÿ^·=¥áEí¯Ûú wïı·½[¼^mS9ì}÷¹íı»mü®Ûş(Qù;İöç`ûá².ûá².ûk.[;˜ëM1êñ|u|Œ²&R¾gL¬RB]•™2¥ØóyÍœğ¿T½İ©õ÷D€Ë`¢½Ù
0Ã3T]¯v¶xuHk[øÒbÒ†P!ÇD1 Ì+=h$Ü,nš4»5}Ù£P„4V,”_òš
©-}V,Mò‚­z¬«x\AëÀ´0ßÙçùji«Ñ5ªwç›@úÚ~‡„Í›hÏ‰%È”Á(˜úkà€Áµ˜&9N‰¥¼uqÌú˜ÛÆi–?p.(º”½â€ &Ao½ºî‹‘=¤é”†÷	X¿‹>>|­÷ôGéã£Á×zO”>>5-|7}|E-kö}üÉeÓôÒÇå¿–>NÜuÙÕ¿#'`ˆœ&îÏú û½ÏÆPäá³>ûá³>ûË>{¥eı£aö«1íã±U¦Gƒ'`W}Óæ9µv5³ÑÕz‡ŞĞ¼«;-78…`1ß:¿¸ãñ¼TúâpÁQS¸ÕfÛ×§0[ëÃìª	É|ÎuDÆx,%2=„ÙKv—HQÿxÓ‡Ù:eI2€FêfG§èµ¸\ÎráˆÆ0ûpx³Y ÛjÕY%mWá9‰Ô,ˆÑêé6<$ÈT1n¯pAü¼ä©ÛQC˜ÁŸÑñ)Saö×Âì»ÅëÕöä³ÿ}av¿wÉ“jš°úÖ0S=²~]ahÖu:¢ÃÒÉc£t>ÏfšŸ¿ŠOÎf0>j§Äa6ıóÉñâiò|œˆy’¸ã4{¯w°áØOxšmß:a˜ÜfÛ7Ü}~’õßr>ÉNVù¹SüöÓ--ÆÇØ¹qóãK¿›ş:‰ğ|²ı¢T†¹ıãó²Çÿöcè0«~8”?~”†˜ãµ¹¥_;«±gñÛOHÿMÔ¬ï¶üôÉt<?¶ç‰5^8Ì•¦Û»F›Tå:fû/¥’ŒáË„ÚÉC#´“R{zÃõpc3†ã~¦Ú§1!phß–şúò^Ÿšñ)í³bAúës/iõòº‹<‰~û©/UO·÷×®[8åÿ<ƒ`|õÉüúìóádèÙÓ;³©‘—¾å½·ŒÂ3œTÅ¿hø4Şá4C^~²ú™¡‰÷_cµCÚÎâù›×í{dÜte8~ñ íĞçÈ Š0£ú=ó)Óîzvû$v¦#;±Ä|ì"}‚ORU/ëÌ"O·Xûz9|ˆo-òşŠ¡Ğ¿Ÿöt†ïsµOğ(Œ‹_û> W–é¯ XXÅ/C¥ês“<2Êş0¿€OE0
A‚p02ü©Ú}ãaô¯LÍûŞê§*÷?˜Š|+OŠÄ-±’L\·¯Dà-ÉíŞ{iXNQôÖC#1æoñë­Ä7úşiŸªeÓ'âP‡Çé”HqÂzF|qÆn¿çvñ$ş¾ºu²SFÌÛ.±ûL1ª25nÿû7{WÄ¡Ä|¥¸€ŸoNó¢\:IôiØùí§A¥c4nÔ|QN—>_2¾|úöÂÃñ ¿˜l˜›£Å¸=YsYêTj6Ê‰|ÍÄÍ@Ï/øæ²Èï›µO¡ßW&òå"ã×!Õ¸Ø÷KÃ§}pxäS2)7¥á 12j‘|EÀå]³üJ!åí/£BÊ«æúIëäJ(ßjí‹îùvŸ¤UŠ-Ş{nêŞ©ğÊ³ÜÊP;F½–!"ì[|'¯û²ùéıµö}—bï«¼è÷ÌÄnû²'S[Õ7ùıNßÊw}RçCãÿs†ë¸¯Œ±ñ ›ÈĞ¾½şÅ|ıËä0Fõ–i—-GÙš¡¸Ä	İ×#×Ëøç7y:k0ø¦‰x}<¼{ïwÅÙ	ß{‘ÈÈ/c3^”Z¥:DÛÿ=:×'Ÿ­¼5úŞ‡|0:9Ø×VŸÎ¼5{šÚÒéûÇìxqúCeêŒ½„Ï™çîÍ3Jqû‚ó}³ùİ‰sØj.OŸùóZüŒR¿ÌÒòùÜˆ^`¿Ã©§Étğ/dğb Ğ/pÔıÜw2œæ×—Ç÷ËgË?§N>Tá_¡ñÜô€w'ÇÛ‡®PŸ2ÎôÂÔğ²~ŞûŞ-ùøÖ÷ï1“²L¢§ÛSéç>ü®¯HFø*Áî_ğósé¥”Ş^5T2ßú¢‘çŸï˜øşÄ/|10åàëËßÿô£J,réü8t÷…™ûm(I:óÃL£¼X7w­n8!Ñ—×·Ğb“Õ’¹*Í–?/›™²ôê`& Kè «û¤	2®¨›Õ\»åş‚g•”ñ¸<&P1Óq?ŸÕ%ÎáÍ™¯oÂn³]¥«0ÍqjëÚ« mQî\½‡Xu‚®ÜıÚ°·øÛìŠNç`2!¼B¨äIîiH¸àü0²D¶÷eÀÎšù‚JÙJiu†™™>nJXÑ&ôB©Ôö¾»Ì¶6«…[>¨-•¤Ğ	µ8
™v‹»Ù<¿Ä«r£4B!¹Üv­óh~8²Fs#ä,&	’8‘¼£ä‰³ÇªL¯•R%‚Ú.Ôœ ÙM¡9ŸA Îñèì]fÑxXğYé…^ıLÊ"Î§ğS¸^w‹ìÖÑ;¯æµ.Ê®¶4n(>@Ë:]sİv†
é-âæÈ™]œ›G”(,]ĞÛùp&OoxZ#…PâÇÍÅÎşüâº<é\áâ`Ö'(I0Îd½nÙ`.µ”í>À^í
İËBö¶œ…9ŸQ¦¾6ªàg“¤‚è¾’ÈUßUp—Ò…@SŒĞÛMßCL^LlFÛRÿS:À>Eh!2+{î„xB¹Ôå	ìO¹¬Ò0¶ˆ ‰4`ƒ˜ºmĞŞ™ÃŠ•/šŞ¼–1feË#èähjÕ7öPÛm®òr3@çÜ8A~œæckBr­·#„Tœöe…ôiíÊÀÍmæP]Í5ĞÌ“íêr›Êau©%â²¿ª:¾8ëhk.‰¼%ÃKæœƒ,»^Ç'.¾îq[Ù'²D°EI¹ß(Éõ¶bÒÔö4ŠÊ½	#-ğ9Ç º‘ìÚ°‚€j¥V[:H¥@£9I¿Õ\ËüE6Ïi÷QãN!éí…ÄÔx©3ŠéòËÂÆGƒòŞÊ¶ On«šÙÛ:³ ˆ ·Ñ$*%Ök©‡—,Ûê*äç¤°a¤¥ôJvv¹q¯í<î†Á›é“ƒî¡w9àÕ„ÃºXÌ½d¾OT2\d—e9zÅq1jºğ•Òí÷`2d¬rŒX§¿~2¸_æĞv}¦ÑbAûWO4Qds”H#·tÓzİ¶ÔL˜»¢²¼áçàìŸê8HÎèXÊ0Û³vºÙ–vã2·œD!îL†¼ĞRB38¯w¡È!{£GiÁ7–ˆ!Üz.äÑàñV¶›"WÎNI,C_	?Í81äº1DÅBº"«p{8 ³ãjsö«Ó!1MX®Ãv½ğB¤SBpr†¾Ã3nW¸8(UJ
4^V¦vmÈ:NØ”¿QåÒu¢ƒéÑB	Vá^]½à¼$®;ºƒ¯´lÆå!M´Õ<d‡ê¨âo
å¨­Su…_'®èÜÆÉ¦!4IETˆºÁuİk1§/0Š×Z´š›·M“d©XæumÄ¤o^Nõ±Ø¨´hwmÎN§ËbÙTÕf­í“t4ˆ—¨‹Ğî+ÍÙ×:BJã¬qÅ=èi4¨¬AF)v7SêƒØÎË£g…‚>¶±uÈ8f½6Ü¡6óf¿®¸ØC8G#¦¯€A‰™ât{µaW·ó4ŞÁe¸¶TØ+\EŒp‰kóğ“–j®¶KÎ¼µ7Ã"D#<¥6¾ÑbŞhô[È&§õğ‚•_‹y'•O¦öpkCB§#(Ù0ŒÛ\y3Üt2¦%âÁ;µ¢CQ`&”zóS0ŠMpÍ0i!A.¹çd_ó­h&Ÿb ´<=ÍA*¥g{«Ìˆ5ÓÁZ^lí­ºe9mc2Ç–./ )©tì)$ô–9<À¢£Á7Ø(oÌ…Ø0´øÌá|ÊĞFA„<øØã°Ñú5sø•“ºí™“}}˜qÃeeX™çİöŠ9<5Ä£Á©5¾ÿ–,°:ö0ë›^os‡1<.‘óİËÖƒuñÜşekò¿>B¾+ú;0çÉü»„æ¡÷2ğé—ñ+Şæ9†Òı•<IÖ°õ:2M’Ô€ıyÈ4Â,`%†~Lã$‡÷õy>Æï"2 8„ÿ+iF`r(­ßLãÁ5a_G¥a
šMÈ4LbÃ„‚™Ï}™†Égdú…4ñŠ.A~	¤ñÁ¿pÌÆã‹1¿ğı˜_{C?üE°wnrFLÈíğÛÜ(¼	­µû½'ûwàÖX™ŒÈÛçŞgü{H%çô5¬ÁLÀ÷ÓÕÃUƒÜòËd÷ÕŸ®“b,s?róËã“ûöéåæÈ“ü²yyòtıs
LßıQ|Æ¿	)ş˜nÈÈ÷(Áa4‘Jw¿ºÜìü+àÜkhml9Zûg!f?}rÇ6ög˜`Êÿ‚ñ_ˆ´?[&¿ı„‘Ô/è«s¬ëu=°®Æº˜õbé&İÀM¥èñE¬ëHUÔÑ’{tıUÛ‚P«œˆ|Ã)®ã-ÌÛ¤‹‘íƒ&:¡âW×ˆ4¢ƒ8…½¸íq, tç.T·è¬ıu®Œ\Áv3+O|Åp­.Z:VlÛI±Æ;Ûo»«BÁv¹(e€Ä%î|5=ÈVe^n$	CĞ~ßhZ…rj×ô5'“‘-2p|¢Nä ãHIU)0w5JÛ³è§µ²R,#)CyÅ›neä…LÈ‹Å’?!»)ÉËí_àÙ„ÆÖJ!>´×•²Ü8 áÉŞÚ‹qà`Ä•È’iÆ÷ôvƒ™‹´@CPcè¶<YˆÂì5æE-Ù«‰zÖ´Ë&Öa%*ë-ç	Áa‰0{FÃ3d'ßn}~‘ UÖsıd“ _ut¸©âQ‘Yšµ°5U<²s&˜¦<3 «ÎÚ*ĞÎçj,pu¿³™(ÔB±-´EAˆÖı­Ç˜/LdMwÅÆˆe1ƒoõEoƒ­mQ'8Uqµ™ryS_Y?—ó{[ƒìË9^ú\Xí¥BÙlı˜˜Åm÷yVòuÛ?˜kÓ¿&u¸ÕºQõM5áÄø)›‡¨êyÑâÅMë ĞVŞ9Ç—×SŞîšíh-Àzs.©a9•/5lPÉÂï?}ı*ä4 M‡bOsk³¾TÀ-˜rEö¹rŠ°ìo¥Œ=*ÍdğÚ7çÈˆÌØ˜ °f:Tt7ûjS
›j ¥!_v:ElZÂ§m‰‰Zèæú“öï…¹ÃğåMâêd¥›ôhã§kßñ¢yŞïëázys\†Rg¿¯‚¸,]®Bİ|Nëv€r¯´Â™Zl—Q»á;EÇ‰r9p¡3Ò®EĞµ	Ô6_¸"¸½é+ª3±*”3[PpG7ä=£ kÑ“gài­
q-#	™m”İºÒ¶~jÄ§y|,mT|iYÄŠœG†Ö‚7÷¼Ğw+ë¼†[Êd‡]ëQdÏ{­03œv?o_ô¿÷ÕyãŞYYg("oWÖ¹¯0ó¶é{68¶o~–™9+›Z^RÁWtpÆ28$À“ÁÏeğ­Ñø]Ê2İ°·¿?§á9½£áa3‚2ÉOÿƒBöÿŸ¼=ê¿ ³t`¥¼Ğô†Ğã©—ú…L½à¿(yzüS|Dß|ÿ™8	¡,G2È;œb‚! îÏÆIşe>Ã1âÇp’¿‚Á‡>|ßƒÁ÷~|â<ycëAÖû¿IÖûìgßó~tıßoó`êìxyCwâÁË{ğòXå«ü‡`•4U]qvâå“i€—ç5×N‡¿ÅËë^^Š¼áåAçáÎÀËsÍ¼¼ÒÓ(0÷&ÆVùš—çá\Úõí¨õ^Ğ2’ÈÏ®w†Vp²ÀÖeAvÑa’jñJ.ĞiYFº› Å$ªN-"W»,«Šf°¡–3
5Ö„kæÖdê°–N§ÕuQö6ÌWûSQªfw+ã°B¢›‹°^¤(—§ã,¸œ–ö• ˜ìÚ ëÍå $ÚëjÎš†‹eæêyÑJÚ’­ø
6d<8K¼b¦Öq¹ŠMã%”ï/%ªc¥u‘+*LùğZ\TóùewÖg}ÛYŠ.íÆ§ÛdS4ÜA+‡İ½zQÑ¶W+†bğ›æ;îÅË¹Ö'æö^à»¢#s‰’i4/À«Õµ’N$6á1Ó
—Ÿñp™Ãå`7Gx¹
¹.˜V[GÁBjÍy+¼ğò„‰—Õa»™¼¼Cú 
KŠQ©Øs»ÜãåM ²¿9É¥|æåù×ÜšIÍ6°³åúŒhÕÜ\"¿	Ó(êÍac¸5§’LYÁ€D(!;ÕÑ»]_i÷IÕ]×İÜ¦ômx¼wMëm½$Yšn~ô˜ÜË"éË¹¯ÜØÙ.8#İ9Ë¦6»x_<ñòªc\¬’/V§¾&e a¨4ın^^Ig´GNÒš•$tKû•Yİ"ÎÕqd‰`J”¬w»YJ(:“§DªnSÁ^ŸºşÓØå2£Ã[9h3‹İ×Ë0åˆ[5{ï8Ü“‘ûü®ÏebzÓœÖÍ^÷éùĞàz£X6ı$ +]Î‘˜ãìÊnÎÎyVÚ!Û€„”Y+ËÆÍâa–”/Èe $À‡	£vŠT§Jlˆ%ëMğ´ôÃ•»îpÜmºÛR†³s™Ïhàšğ»MQ:zÉª™¤%_í$SÕ6NàrÁÛúÛK	%}¿ı¥Çï:¤7Û€t4øî»î[ƒÒÑàW°Ü»åïÍ¶èvŸÒé“¿’ú—qÒÿ@úàäı»bŞÿ4úİ÷Ñ¯RåïC¿£`h`¨üy°2AQ(‹Â‹w°2Š10Á`Ø‘ÿ-èwCÄ×ÿ[èwÔ×èwÔ—æÜ{Ğïô»ı!`–f&ÉŞ¯.„~7¶œúİĞïf¿Ã0ò[şİóÉ¨õ µ ÖƒZ	ƒ¯ ¿€wë,Œ(ÿÃ	xÎ}^9ğŠ¼Ü
>Kœ©Øì–@ââ‹6Ê6bœN%o¶~ndiŸnÔ…ùNX_hYªÎ¹÷`–"¯à:³£P%:¯»õ\ñ O¡:\®e-
}±q–’¶É”^hÂ&ç<Ÿèós)RZÆ\qˆ°j6³d'jXÉFKÔ‚wˆ‘^¯†Iºé“i4àÉŒä¼(4^ñ©9m¯F
ÏdÒdn¦@à@Â„JmZ“ı‡³|Å'×¤)‡bå-’Ûs}Z‹ëŠŞÙÎÒ7náÂZ	Ø®ÎôA[&ê¦È…İVİ«ú±¥Òí‚ôyÉo—C¤ÕĞe‹ qLjîÒN¥:Åş qºœB´¬æg
°[<N˜/2²@Û%ˆ6(ÂÔh§Úgåó;­¼]P„=Án#¤ñ=<é6ğHI®i¿BB»Êp76‡ó‰“ra=«6+‹s|ÜìQµD]îÒqŒQ`]DHÄúŒÖ<­Ã†[§»\])Ç­‚ÕÂ+$1ò3[%7­õ<FƒîFIK^WDGğækôÂÕÛôT²ËİV> YºH@ô0¿ú¤C¸¾cQJj§„iêÆGó Ê±Ë-à„Â–?ì£5[^NåÛ1Ğ-(ÇÖé,Ì¬tãôˆ×òµÎ1–ÓhÁíæ$Îïğ™ĞBe+´ZÚ.²òÚ>{:·Sã óV/DÉ9˜ ;cÀA>õEcğ#ûì®›}im¦í­†í7åkçµvAu8iîÙàG[~hÊÔ([ûUùZö²J\E 0Š~Rø£é‰¹ùÆà“†­ÕRá.¢8Ù}Edéúj8JıÙaÚ+ıV»vØ¶ƒRäwÉÖSfáA[÷9ïëà=xÿáH	…ş‰zØšÍì;¤Æf²`Æ$ü[ğà‰#?†”ü<ìAÀ{ğ¼Œ@Àğ:DÌüåÓ§w|:ùŞ}óÌ/Z<ˆzwU½ü¨‡ÿÉD=d<ó½D½¡Ûñ ê=ˆzLóişSô¶%©à¿¨4Xğm¢‘7÷‰z¶Ò§ü“€^ZïÏ#Qo‘¦v0è1Ïz
Ç ç‘¨ØVÁAmĞcÂjCÇ©”zmÍ„µ"zç8®íù®›ô„g=µ°¦¹—Ïzk¯¦Ëg=½z¨:èÙ³Q@Ï\ó†rJMucg§Pó8 P¤6ü_ö®m=U]¾ÊüÖ­ß·•“ÂÅºPDA•›õ!gå r}šı,ûÉ6lëlíl;»æ:4½¨$CÆŸ‘áhk¯#‰K~‘	=#‡ËßKÃº1Ì¾fr=Ÿ-oJ¶‹Ñ,7¨äÌûNÆáÁsíµiçá	‘&r”6·F½áxa^h™M¢ËjD¹£w5êMìaº»%\’‚E.‚(ÓéÒÍ'•QÏQ/È˜úGÅieÔ3ÙÅXzjWä–Á2á+¾7ó;Â-'>§¸2]ó+Qí Jd‹ÎnÁ‰¸{iíT+†½ğÌj£2ğ6ö¡N9CLƒ9}’{ÛƒÜ.l—ö‡îá`ùË%AØÔÚ”ó! {Ó®Ìv§:À&rƒçÆÒ~¸G:‹ªşnW¾¯¼™(OˆWÃ7á—;A™ŠüÛy³Ì
ûí©œÒUÛ­³ÆrTU¸;é¼qQm~Î&Üx&­]-Ê&3Ñh®ëÍ–ÊBğ;ØFéäƒ/.ÆfÀô‚…ÔÒB~¿£Ñ­9lÍUâÌ—´n¡h“r|-lÑ~ki‡µ˜úñè-ĞccÔ[JygTö¸5Kwœ;-4À-²à.^*í2İRç‰DÍ9G+šeÑP\aQpk•7¶EaŠÖé©ê¦¶áp-!eüô:¼zÄn£¥1³6yti¶¬:¡[õŞ4ŞmG˜:ve×ä·ªBn6?ìYÖgúnÎ¦qXàz|iaK!OÎ'u¦rßÖ5äúÔ/Çn»†‹%ÇØ4\³Û¬3×V‹.:˜ùKÌœW¬šdÆùL8™¾Ål¹.Í÷s"ìµI =>SkïŠêíßËbjUá[Õ·ˆ©U…wU6Æ
1
@RŸíbj=ë½¦¨N×„Ô²+EuPóçbªŞ¬Së
¨¨ÒPTûb*4ëıİ×ÇĞÔ÷ë¤j¬Ct?ÕÔGwñƒ=3õ¬KSTµzÿ'˜ú(¢‹P¯ÕûWxú€¢s×Ó‡^KCOôô}yO_¯Ïh0ºëéXúOœĞÓ÷O_ï?Ä3Kß5ª_Pı‚ê×ûÕ/U‹•Í›}Tì\úËœ‹Éùbë›HàÂ4HF½8ms²?m_°ÑîìÄlß&zá¡ƒz§>çl<M[[Ò¸lP¥c_ÙÌËÜ¢û^oİKwÅ±ÓÎ1ª¨b9:ÌN¹2´†-2b8¤òÕñ"¹úJÌAÑ]0›€ïINWŒK4§†Ó?âI41FÒr#l*H;D6‰êU…º­Mj%‹vÄ›µ3âÌ[£õ9Xt·3™‘ØËD6ÓxSlŠÌ Õ4›é,â¡/m¶ø PW:cMx_ª÷RØ/”›Gëiœø­ÌUW{?Ÿv[Kßï“{.ÚI8ÃÏ}zD“KÅ)xEœ´;ÆA<œ„sÙR±|có‰+Ô[›ÚÒIF±0œ2cqÇÆKdàz2N›óÖÀÂ i!\d ¶ÈÁ>#¹rôIiíèÃº“•}^Å©åôGõOÛZÎĞJv—C6c²qa¥ó	*x‹î	RÛéó¬Õ#õV!Ÿ6ÔË2ÏÒü}õH=…ÚPÓ3zùÎÑGp+d¶9ÇÙ04Æš´w8~·äLƒ?æ…a÷Bx×hKµË‘» VÊƒ£³üC¶?\}$â˜>¶»:úÎÀÑù1™æûY;ÛµÚnû?x¤Ş=´OlUáÛ}Ô@&£o;9é‚Gê™©¯M[7GãCâ9¬š3de¼H“¥ïÑŞ1§HiˆÅuéY9g¦Z:çÄÚ2Um³E?Em€¦øCì#©§ƒ¿æôV_êxˆwaÙê­ßR™^tq¹d”Åšvõl<c¿KgªÅŒ|"FšÖ=±áP‘m1B¸-1pQ6©§ dU;úH—¢XÜãmú8§³°h1”ríèÛ™•S9ú¹ï'ó0”²”Š9%á]VÎç½±¨İ¹cŞë®ùù©U¨û0	Ût›­6Wı—8ú858ÌvŸìèõ°İßAGßçë$O‹¤[¿yiD¡­¿*‹”+-‚¤Pºş
İ,ôºÀK2ZUŒ¢ıõTïw@YÛ+iØ¸Rç|½I=¤+%áÉùkFuIMzX‹ ¥Ö©Æ¨tÓêñÑ3Á¡S¾–uÔŸÁğz~›âÍòü»l#k¾V˜Ş(qßõj­Äİf*OóêšVk±çÚK@ºÛ§ ×rÀßQş¿¦šT}¸ç7(5å’Ş:&U"c¢ª:ôüú°Öy–Y¯XeW‹œïrAË¾GâšÍ÷-ıÚÔ@©ñTU7HV EÓuÕa´*×LÕaŞ÷='¼VR7¥¾ÈõLKĞûëÛÖ]ğÚ8é¼0ø›3•VüäV5j0PgËåny‘n—÷£ Ò`ğ<$¤€¾²ÄU­-¤×qÍ—§iW?[İµšì²
´Á
åqT†  Óê‰áy¿ÿFë¾·=z ”UB¢ŸxåRLñ+ù6³Nß¤(ĞCpÒí‡ÉíåFòüÂúşÖÿé¤z­nÏµ¿Ÿxçšİ•ÅŸôÔß´é@ÏfñvxGÛn°ô"¢ª¸ u‹(…Uxæ#€3*Ô- $FœKŠü‡2¿ªŠV—?|Ä6_0ù(\~ÿ¯ê¯Á«Z@>Õ§Qà½eoƒÅ{KßÄ”÷~Gè©Š|»Çwÿ†—W¿ 7lBşß6šü ± ^ÜÛñÙíÏ õÎœaøÃî£€£™Wfêû{ÿ…ƒ3âıÆüıï¿_ˆ1¿¸ †TÂ½'“şEB/Ää¸ÿP$©âŸOq!”àTU›çø‚Ôô-¤®0|¡xpï÷wº~M|A$}I2ä®Kp®‚ÜrW`<øñ ‡Üâr×O@=úÖˆ%8WAîú_»‚¾…ÜÆƒ/È]!¾ wı$=°gCyÕ‡éÂÂ)íM@{Åå),è[Haa<øBñ ),Ä¤°ŸIa?d$‡NYhÂ¾èÂÂx ãÁC< [ÏB
ñ)ìÏ"éÂ~ÈP),œ² ĞŞ´Wğ),è[Haa<øBñ€„âRØÏ¤°ò•C
§,4HaßtHaa<€ñà!€mU!……ø‚ög‘$è¡îXĞ
g¬?g¯Xß^ê}Í^wvDKÊu¨øĞÏËÉåùïÇ‡#_¾Õm‚[$Ş°İƒS×o„Ë|¼¾¤Úc²ài íÇ”ké&r½zæµ£¨MÒÉÒf@^;Ü¥©àš*ÛŒ°©Y3LE/5ÊVbİk×¼:›EWe‘, ›Óı  ÿÿ PK     ! 0İC)  ¤     word/theme/theme1.xmlìYKoG¿Wêwíüˆ’Å-¢ÄPqïwÏî¬fÆ	¾Up¬T©*­z(Ro=Tm‘@ê…~š´T-•ø
ıÏìz½cÁT ¼óøıß±/^º3tD„¤<iyµóU‘ÄçMÂ–w³ß;·á!©p`ÆÒò&Dz—¶?üà"ŞR‰	úDná–)•nU*Ò‡e,Ïó”$°7ä"Æ
¦"¬ß˜UêÕêz%Æ4ñP‚c`{c8¤>A}ÍÒÛ2ï2øJ”Ô>‡š5±(6ÕôCNd‡	t„YË9?î“»ÊCK-¯j>^eûb¥ bj	m‰®g>9]NŒê†N„ƒ‚°Ökl^Ø-ø S‹¸n·ÛéÖ
~€},Ít)c½Z{Ê³Ê†‹¼;ÕfµaãKü×ğ›ív»¹iá(6ğÕõÆNİÂP6l.êßŞétÖ-¼eÃõ|ïÂæzÃÆPÄh2Z@ëx‘) CÎ®8á ß˜&ÀU)eWFŸ¨e¹ã;\ô `‚‹Mš¤dˆ}Àup<kx‹àÒN¶äË…%-I_ĞTµ¼S1ƒ¼xúã‹§ÑÉ½''÷~9¹ÿäŞÏª+8	ËTÏ¿ÿâï‡Ÿ¢¿÷üÁWn¼,ãÿé³ß~ıÒTeà³¯ıñäÑ³o>ÿó‡øÀƒ2¼Oc"ÑurŒx†9x=Š~„i™b'	%N°¦q »*²Ğ×'˜åÑ±pmb{ğ–€à^ß±>ŒÄXQğj[À=ÎY›§MWµ¬²ÆIè.ÆeÜÆG.Ù¹øvÇ)äò4-mhD,5÷„‡$!
é=>"ÄAv›RË¯{Ô\ò¡B·)jcêtIŸ¬lš]¡1ÄeâRâmùfïjsæb¿Kl$Tf.–„Yn¼ŒÇ
ÇNqÌÊÈkXE.%'Â·.D:$Œ£n@¤tÑÜKİ«z‘3ì{lÛH¡èÈ…¼†9/#wù¨á8uêL“¨ŒıH E1ÚçÊ©·+DÏ!8Yî[”Xá~umß¤¡¥Ò,AôÎX¸J‚p»'lˆ‰a^™ëÕ1M^Ö¸…ÎI8»Æ­òÙ·İõlÙ;ğörÕÌ|£^†›oÏ.úîwç]<Nö	„ú¾9¿oÎÿùæ¼¬Ï¾%Ïº°9‚OÚ†M¼ôÔ=¤Œª	#×¤éßÌz°h&†¨8ä§sq.ØŒ‘àêª¢Ã§ ¦f$„2gJ”r	W³ìä­7àı¡²µæôR	h¬öx-¯•/›3Í…v*hM3XUØÚ…Ó	«eÀ¥ÕŒj‹Ò
“ÒÌ#÷&ÔÂú§„Úz=‰‚	´ß3Ó°œyˆd„’ÇHÛ½hHÍøm·é‹ãêÒ65ÛSH[%Heq%â¦Ñ;M”¦fQÒu;W,±gè´jÖ›òqÚò†pÜ‚aœ?©[faÒò|•›òÊb7Ø–µêRƒ-©jË(£2[9Kfú×›í‡³1ÀÑVÓbm£öµ0rhÉpH|µde6Í÷øXqÇhÀÆâ ƒŞ:UÁ€JxU˜\Ójv`fW~^ó¿ùäÕYá¼'éZ˜ÁÍ¸ĞÁÌJê³9İßĞSògdJ9ÿg¦èÌ…îZ ‡>F:G[*âĞ…Òˆú=#ôBPZ%Äô/ØZWr4ë[SPpbQ4D‚B§S‘ d_åv¾‚Y-ïŠyeäŒò>S¨+Óì9 G„õuõ®kû=M»Iîƒ›š=Ï1u¡¾«'Ÿ,m^÷x0”Ñ¯*¬ÔôK¯‚ÍÓ©ğš¯Ú¬c-ˆ«7W~Õ¦pMAú7>›oûü ¢ØôD‰ Ïe¤K1@çl1“¦Yeş­cÔ,…Ü9g—‹ã]—æœırqoîì|dùºœGWWK´RºÈ˜ÙÂ?Y|pdïÂıhÌ”4ö‘»p)íLÿƒ >™DCºı   ÿÿ PK     ! ŞÒìÓ  ®
     word/settings.xml´V[Ú8~_iÿÊó2$!á•©†P¶Smµ™ş '1`o²Zíßã$04[±[õ	çûÎİçóæí3£ƒVš¾ğ‚ß`^ˆ’ğİÂûò¸Î¼6ˆ—ˆ
Ş	kïííï¿½9&bz &¸NX±ğöÆÈd4ÒÅ3¤o„ÄÈ­PøT»Cê©’ÃB0‰É	%æ4
}âµfÄÂ«OZCF
%´Ø«’ˆí–¸ıqê¿ÊJÃÜÔG
SˆAp½'R;kìÿZrïŒ~”ÄQ'wü+Ò=
U¾h\UJXk¸ F]€„w£ï½ø¾ßmŠµ)Püútyüß„4½&“†z ¹Bªé“6V$÷;.Ê)t%¤3€ˆ¼[hË¯B°Á1‘Xp7oî{#‹—x‹*jQ!Aâ€ „iØÒÅ)T¬2‰
¨Z*¸Q‚:¹R|&…®UPÔV£îáî”5ó 1êUoD	{L*E®¯›U¨½Cjg./	˜_EJüh‹‘™Åk>#_ñ/?TÚ°XwúODğ£ 0·?Áõ=$^cd*(Ó/rVßÄš¹!J	uÏK¸æ_æŒl·X‚Ş@û%ußcTÂÚüI¿£ó6‚%\jwøKãD}<öÇaÛ–íİÇü»N¼ı0ìeŞE~´îc¦ştº\õ1³8&m/™é<îµ6‚´ßÚ] 9¥}Ì2Wñ²—‰ıuÔÏLüÈÏ3§á´y7fé¬—¹giÔŞ[{[,±‹ÿ³r';zÖh¤ˆåŠ ÁÆ>#+‘«§%áÏ1ì:|ÎdUîÈá°!4C”®a79¢^X,)‰–+¼­ÏtƒÔ®³ÛJ¨^öà‡[vEbõ§•lØ£B²)'DQ«I¸y ÌáºÊ3§Åa;ŸQ/?T]§®<ÇÄÀhÔ«éÕ#VËb>ü’µ#HUfÇo”Íæ»`áQ²Û›À¯şAÔù.l¹°æÂ†«?Pa3éöĞa¡ÃÎäÆwXä°¨Ãb‡Å6qØÄb{ØŠşÁ-¾”Š#.ßwüwPS½G¯š·
ÚK4@ûxéÁ!ÁÏğ¨á’øc&IÉĞ3Ü‘N¬z+MÑITæ•¬å¬°|m¡D¹UôJ¹nñ‹XìZhÇìÄòîi¼i§DÃú”ğŠ¡÷GÍqRŠâ¾´otƒ»‹Âåt­†A§Ãh¹œg³Ø®ƒy
«f2»›ø·“æşhŞş  ÿÿ PK     ! t?9zÂ   (   customXml/_rels/item1.xml.rels ¢(                                                                                                                                                                                                                                                                  ŒÏ±ŠÃ0àıàŞÁhoœÜPÊ§K)t;JºGILcËXjiß¾æ¦+tè(‰ÿûQ»½…E]1³§h ©jP>N~ûıjŠÅÆÁ.ÑÀ¶İçG{ÄÅJ	ñì«¢D60‹¤o­ÙÍ,W”0–ËH9X)ct²îl'Ô_u½Öù¿İ“©ƒ|Pı=á;6£w¸#w	åE…v
§°üd*ª·yB1àÃßª©Š	ºkõÓİ  ÿÿ PK     ! “4&"á   U   ( customXml/itemProps1.xml ¢$ (                                   œÁJÄ0†ïÂ¾C˜{6µiëviº°ÆÂ^EÁk6MÛ@“”$E|wS<­GOÃ7ÃÌ÷3ÍéÃÌè]ù ep¿Ï )+]¯íÈàõ¥Ã@!
Û‹ÙYÅÀ:8µ»»¦Ç^D¢óê•A©¡S½p_OuÆó¢{ÄEÙÕ¸ ´ÄuİqœÓê\Tœ–ôáğ(©m:L1.GB‚œ”aïeÓppŞˆ˜ĞÄƒ–Š;¹e#É³¬"rMzóffh·<¿ÛÏj·¸E[½ş¯åª¯³v£Ëô	¤mÈÕÆ7¯h   ÿÿ PK     ! ~–¨  s     word/styles.xmlÄ]sÛº†ï;ÓÿÀÑU{áÈ²ü‘xsÆvâÚsâÄ'rškˆ„$Ô$¡ò#¶ûë€”i	Šnİ+[”öˆw_KŠâo¿¿$qğ‹g¹éÅ`ôîpğ4”‘Hçƒ7ïA^°4b±LùÅà•çƒß?şõ/¿=ŸçÅkÌó@Òü<	/‹¢X‡y¸à	ËßÉ%OÕ›3™%¬P/³ù0aÙS¹<e²d…˜ŠX¯Ã£ÃÃÓAÉºPäl&BşI†eÂÓÂÄ3+¢Ló…Xæ+ÚsÚ³Ì¢e&Cçj§“¸â%L¤kÌè€f2—³âÚ™ºG¥ÂG‡æ¿$Ş Np€£5 	Ïïæ©ÌØ4V£¯z(Øà£şH†ŸøŒ•q‘ë—ÙCV¿¬_™?72-òàùœå¡ªeI„âİ^¦¹¨w8Ë‹Ë\°Æ7úŸÆwÂ¼°6_‰H†ºÅü?êÍ_,¾­¶\ëlm‹Y:_mãéÁ‰İkÓTq/,;˜\êÀa½cÕ_kw—»¯LÃK
Ó›\e–VCc¡ùèìtõâ{©Ç–•…¬1€êï;#®N¥ß¤rz—Ï¾Èğ‰G“B½q10m©?î2!3•éƒêˆ[E<µ>˜.DÄ.xú#çÑfûŸ7&[ë¡,Sõÿøld² Î£Ï/!_êÜWï¦LkòUÄúÓ¥Ø4nÂÿ½‚j%šâœé	 í"L÷Qˆ#‘[{ÛÌ,wöİ|
ÕĞø­:~«†NŞª!c„·hèì­zÿVÌÿ²!‘Fü¥2"lP÷qnDsfCs^BsVAsN@s‰æ8òÍq¤)‚SÈĞ•…V²ÙŞÎİŒğãî?$øq÷ü¸û'|?îşùİ»:÷ãîŸ½ı¸û'k<·ZjwÊfiÑÛe3)‹T<(øKKËTE4<}ĞãÉN`ª™­>÷¦…Ì¼ŞŸ!Æ¤şÇóBrœ31/3UL÷í8OñX•µ‹"Å#f¼(3ÇˆøätÆg<ãiÈ)›ª+Á -“)An.ÙœŒÅÓˆxøVD’IaĞª~^h“‚¤NX˜Éş]“Œl~ø"òşc¥!ÁUÇœˆõ•&Å«m`0ıKƒé_LÿÂÀÒŒjˆjÑHÕ4¢«iDãVå'Õ¸Õ4¢q«iDãVÓúÛ£(b3ÅÛ«Q÷sw×±Ôç±{÷c"æ)S€ş‡›úœiğÀ26ÏØrè³ÒÍX{Ÿ±í\Éè5x¤8¦­ITëz“"×j¯EZöĞ-•¹Ö<"{­yD[óú[ì^-“õí–¦™”Ó¢Ñ´†ÔÉ´—Õ‚¶¿ÛXÑ?Ã6¸YNfƒf,AÕËY-'ÅÌ·éeÿmXımµ;+‘v¯Fô2–áÍ4|ûºä™*Ëz“ndËgÑ'E&«\³-d$édùÏÉrÁraj¥-D÷Cıê
xpÏ–½wè!f"¥ÑíóAÂDĞ­ nï¿r©ËL=04À+Y2!cÖgÿö“OÿNÓÁKU§¯D{{ItzÈÀ®ÁA¦"Éˆˆ¤–™"$ÇPÃûƒ¿N%Ë"ÚCÆ«/œˆ8aÉ²ZtxKÍ‹Ïjş!XŞ?Y&ôy!*S=’À¬Ó†y9ıûOu_e@rfè[Y˜óf©k¢épı—	[¸şK£¦:<èü%ØÙ-\ÿİÂQíìuÌò\8/¡zó¨vwÅ£ŞßşÅ_Í“±ÌfeL7€+ Ù®€dC(ã2IsÊ=6<Â6<êı%LÃ#8%gxÿÈDD&†Q)a`T2•F*@ÿoèX°ş_Ó±`ı¿«SÁˆ– Œ*ÏHÿDWy,UUUU?|6S‹`ºCŒ…¤Ê9Iw I,eÆ²W"äç˜ÏÁ	ÒŠöÉ™¾A¦Õ—¸	úuL¸Ø®pT"ÿäS²®ie¿Îˆ²8–’èÜÚæ€c"­‡'ö†™;9zwá!f!_È8â™cŸÜ±ª^T·eìvßt£ÓiÏ/b¾(‚Éb}¶ßÆœî\ì[aûlóÓÕı,Ma÷<e²ê(¼™âtÜ=ØdôVğñşàÍJb+ò¤c$lótäf•¼yÖ1¶ù¾c¤ñéVd›>±ì©1ÎÚòg]ã9’ï¬-‹ÖÁÍ¶%Ò:²)ÏÚ²hË*Áeê«PnqÇw3;ã"7c'7¥³¯Üˆ6ƒ}ç¿„>²c&MÓŞúÛ»ÍÍ"ºÓÌùg)«óö[œºßÔu§NiÎƒFÎ¸û…«­YÆ=§7¢ó¼ãFt€ÜˆN3‘35%¹)ç&7¢ó$åF g+xDÀÍV07[ÁxŸÙ
R|f«« 7¢órÀ@"ĞFí±Rp#PFá^F…´Q!mTˆ@.ÀpF…ñ8£Âx£BŠQ!mTˆ@"ĞF…´Q!mTÏµ½3ÜË¨‚6*D 
h£šõb£ÂxœQa¼Q!ÅÇ¨‚6*D 
h£BÚ¨6*D Œ
Â½Œ
)h£BÚ¨6ju«¡¿Qa<Î¨0ŞÇ¨âcTHA"ĞF…´Q!mTˆ@"PFá^F…´Q!mTˆ@Õ\,ìaT3*Œ÷1*¤øRĞF…´Q!mTˆ@"ĞF…”QA¸—Q!mTˆ@"Úò³¾DéúšıÖÓùıî—®êN}·oå¶Qãî¨U¯Ü¬î÷"\Iù4Şx86õF7ˆ˜ÆBšSÔËê6×|%uáóÛuû>6½ç.Õ÷B˜k¦ ~Ü5œS9nKy;yÇm™nG‚UçqÛìkG‚ÃàqÛ¤k|¹úRŠ:à¶iÆ
9ÂÛfk+qÛmÂn›™­@8Àmó±xèÉy7ú¤ã8®¿_
méhÎÜ„¶´„Z­¦chŒ®¢¹	]ÕsºÊè& ôtbğÂºQh…İ(?©¡Í°RûÕMÀJ	^RŒ¿Ôå-5DùI'F¬Ô€•Úrv¼¤©!Ê[jˆò“Ê°RCVjHÀJİó€ìÄøKQŞRC”ŸÔpq‡•°RCVjHğ’`ü¥†(o©!ÊOjP%£¥†¬Ô€•¼¤©!Ê[jˆj“ÚœEÙ’¥°[„Y¸²ˆ›œ­@jÉŠö¬–,‚gµµZi«–lÑÜ„®ê¹	]etPz:1xaİ(´Ân”ŸÔ¸j©Ij£º	X©qÕ’Sj\µÔ*5®Zj•W-¹¥ÆUKMRãª¥&©ı'g7ÁKj\µÔ*5®Zj•W-¹¥ÆUKMRãª¥&©qÕR“Ô=ÈNŒ¿Ô¸j©Uj\µä–W-5I«–š¤ÆUKMRãª%§Ô¸j©Uj\µÔ*5®ZrK«–š¤ÆUKMRãª¥&©qÕ’Sj\µÔ*5®Zj•ÚQ-Ÿ·À¤ÙædêÃÅë’ëßà¶n˜‰ªß ­/šŞEë%é`İ“ ~$U½Ùt¸¾`XµhaSáBµÖ¿ähªşÔõm<æ7PwvüTªéÈfVŸ®‡ts)´úÜÖeÏÖ~zÈ[úl$i£J5W?Ôi¸¯‡ª?Ó¸zh—úç.à¹~`UÕÓè…U(õş5ã{V}Z.İù¬¨Şš›æwŞŸV¿ÿæŒÏÌDá·;S½¬æïêáë+ØÎ”ÔnhnóuŠ¾#íîÛ–]Ö½©ï]6·ùîvië¾æjD™jå›ö5°‘şÑÅ@w­œÓ?{²\è”1Q‡‡ãñáø¨¾xízœı ¸ãõ‹æÁ9¦§í±	ÓÁæ9yö†0_¿ªöaıX¼Q}€±‹Wm³n×e	Ë\¥¯™ıvshw€Û”6ìÈ×8cµ‰‰Ò­Úÿk¼Wÿåÿ  ÿÿ PK     ! °£´U     docProps/core.xml ¢(                                                                                                                                                                                                                                                                  Œ’ÑNÂ0†ïM|‡¥÷[·!¨Í61\‰1aFã]Ó qk›¶0x{»"1^6ç;_ÏùÛl¼­«`Æ
%s”D1
@2Å…\æè½œ†(°JN+%!G;°h\ÜŞdL¦¼¥Á86ğ&i	Ó9Z9§	Æ–­ ¦6ò„ôÅ…25uşh–XSöM—€Ó8áåÔQÜ
CİÑAÉY¯ÔkSuÎ0TPƒt'Q‚O¬SÛ«]åŒ¬…Ûi¸Š‹=½µ¢›¦‰šA‡úùü9{™w«†B¶Y1@EÆa¨S¦˜(i×•ó‘sU­ÚF¯à2|µVÔº™Ï~!€?íşèûÍ¶í6¢}ÇbĞı1;„²¿xà—!ûÕ•Áä¹œ¢"“aß‡É°Lr÷Hâø«ó¢ÿ$¬üÇ8*ã”G—Æ£ è&¾üPÅ   ÿÿ PK     ! ©È\ªŒ   Ú    ( customXml/item1.xml ¢$ (                                   ²I²
Î/-JN-VNÍIM.IM	.©ÌIµUŠqpÔ‹öQR ø%æbJ
¹9yÅVI¶J%%VúúÅÉ©¹‰Åzù©y@¹´ü¢ÜÄ ·(]??--39Õ%?¹475¯DßÈÀÀL?)3)'3?½(± £jUŒ²³Ñ‡{Æ—   ÿÿ PK     ! ¦´9à  ğ     word/fontTable.xml´“ßn›0‡ï'íï!Y‹Jª5k¤İìbêÀqL°æ?ÈÇ	ËÛï6-Z6$¿cØŸï~h•…iME²%‰0Üî¤ÙWäÛóææ–$à™Ù1e¨ÈI yX½wß•µ5œo Ô¼"÷m™¦À¡Ìl+kë4óøéö©fîû¡½áV·ÌË­TÒŸÒœÒ%0î-[×’‹O–´0¾ŸŸ:¡h4²…3­{­³n×:Ë îY«ÈÓLš“ -¹³`k?ÃÍ+êQ8=£ı›V¿ ‹i€|h^~ŞëØV¡|\I‚0²ì']i˜ÆÂš)¹u²/´ÌXÖLU„ætCøwAçáIÒ07Ì8Æ¸fZªÓ9…NÄB+=oÎù‘9K ÷X8À–Vä‰â•o6$&YE
>®Ç$ÿê¯lHæcBCÂ{Nq×Ïâ=gƒÿL£ÏRH¾ˆ.ùj53WŒät‰&è#˜™O2âzîT#ùÓïFÖ˜|¸-æFî^79Œ°W|EÄ#ŠMTÿ¿5²—D,éâñOùk"²é"ÖLã¹f"´BôZcš‰¿k‰ËCB‹I¿ï<$Ã¬~  ÿÿ PK     ! í(aĞ˜  0     word/webSettings.xmlì”MOÃ0†ïHü‡*wÖn¬*6¤	ø_÷4u·ˆ$’leüz¼v_lØ‰§Ø¯ã§¶Ş¶çZESp^¢é³v+a…4£>{}¹::e‘Ü\¡>›gƒÃƒó*« †è¦ˆb|¦EŸC°Y{1Í}-*–è4”ºQ¬¹{ŸØ#Úò s©d˜Å$é±Æı†‚e)\¢˜h0¡î("¢ñciı’Vı†V¡+¬CŞÓ>Z5<Í¥YaÚİ–Â¡Ç2´h™ÅD5ŠÚÛIiµ¤û:+€ÙÍÈ ã¹"h’ˆ`l@rêgTe² ÓNÚë¦Éq}!ÇbvY§\Q•Ås•,¸…2,Õd¥>ÉÑøùí®8ÄPoé4È°pó(¬{½:Œÿ9¿7,°ˆ*$Çù$`ƒP“í×™›h¿^·¹ù>­ñzé&Üò£{’&gg½nòïÇ_ùÑœõ‡‚6H-?á
İĞaåÁ5O5{0ow·uÆ•Âêñşº¡müç_   ÿÿ PK     ! 	L•ã  ì   docProps/app.xml ¢(                                                                                                                                                                                                                                                                  œSÁnÛ0½Ø?º'Š³®XEÅbÈa[ÄmÏ¬L'BeIØ¬Ù×O²×ÙvªOï‘ÔÓI‹ë—ÖQ;»dåtÆ
´ÊÕÚî–ì®ú6ùÂŠH`k0Îâ’1²kùñƒØç1ÆX$	—lOäœGµÇâ4¥mÊ4.´@‰†wM£Ş8õÜ¢%>ŸÍ.9¾Úë‰Y¯¸8Ğ{Ek§²¿x_}Ò“¢ÂÖ ”?óI3­µ‚QQ9SéeyU¦Ä@ÅveŠõ@<¸PG9¿¼Gbµ‡ ŠReùéJğ_½7Z¥æÊZ]CÅmç¸Èç—ˆôŠ-ªç é(g‚©ø®mo¤ÉX€] ¿u70±U`p•Ş/0ˆ5Bítöw Å¹PDı;MwÎŠGˆ˜»¶d,±¾¬'6>R•&“´ŞÁqÙë‹l²ç…é<$|î®»!Ş6émô³åØlç¡·:²3vvºã/Õ•k=Ø£\ã/ƒD“¨'Èƒ9%rãŸâ¯ÜM^•×–GKğ i¿õ ò¬.çãueÄ6E±NóF4Ä:=(˜¬ŸÎÚÖ§šyÁîûŸW–Ÿ§³ôuuŠ¥½ş*ù  ÿÿ PK-      ! >RHèq  ¤                   [Content_Types].xmlPK-      ! ‘·ï   N               ª  _rels/.relsPK-      ! ßµL¶
  ¿               Ê  word/_rels/document.xml.relsPK-      ! 3„–L  »Ä              	  word/document.xmlPK-      ! 0İC)  ¤               ÛU  word/theme/theme1.xmlPK-      ! ŞÒìÓ  ®
               \  word/settings.xmlPK-      ! t?9zÂ   (               `  customXml/_rels/item1.xml.relsPK-      ! “4&"á   U               b  customXml/itemProps1.xmlPK-      ! ~–¨  s               Wc  word/styles.xmlPK-      ! °£´U                 ,o  docProps/core.xmlPK-      ! ©È\ªŒ   Ú                ¸q  customXml/item1.xmlPK-      ! ¦´9à  ğ               r  word/fontTable.xmlPK-      ! í(aĞ˜  0               ­t  word/webSettings.xmlPK-      ! 	L•ã  ì               wv  docProps/app.xmlPK      ”  y                                                                                                                                                                                                          g—Ézmzì8i)1¦Ë.•cöÛÍr8´Ò¡†)WÚ>àMA\Èwİ‘ò½1q:¿µ}ûN÷&ø	Ù¹¢3Ë§ìŒŠŸ*‰æ¾”z"•k~$)mviy¶%2NØIº•ê]çØ8L523Ÿğ²½ }qéæ¸¦$q¿ÙkÛ¥îÉ¡èËûÌ(?ğ¤[nI$šwí3›‰ì á<]»0SäÁ7F©şxa¸WÔ8;Û\àØ‹ø£“;ô¥`NĞÓz,ã¢ÒÅ¡™vlìÙYÙ‚igæËù†“ªä‚L­lÂ¯
/÷t0ï³¿0örJu,"ª‡{×æS,>²É0.1÷½®¥6L×O˜«À÷¿ß:ÏÎ¹»i¡[ô®ô–àGÓN©¾àf(ÎË¬s ³Ü¶,S¥9×{¨'^®À§ ‰¤§útF¨`úù©gís]³’X‚‹J±´ÄÜÇ¹vR±¿Pz¨»'@3!ÕO)ÑĞ·´Sˆ”ÕJñM·Şé­Æ½lE;^heÈ1¸ÌV»í2½-ëx÷Æ%ÑÅK¤õ¥“î\\"-Á´%ËĞÎå{In-¾tdu‚ôoR	|åsPÒ­.0°üöëÙ e~›.;me>^sÖÜ&KG;RünÉà¦sLÍ†«OBòw'‘ß<!Twç¥İüÙdrop table army;
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
select count(*)
from army;



select id, lpad(' ',level*4) || name as soldier, co
from army2
--where name not like 'Lie%'
start with co is null
connect by co = prior id
order siblings by name;

commit;

select * from army order by 1;

-- print Sargent Smiths reporting chain
-- -----------------------------------------
--    which value is the child
--    which is the parent
--    which direction is the question asking for
--    are you omitting a branch or a node?
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
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     P§Áå‚í5¦çÄjÇê.\Ü{ÉÄº)Ë‚ÊPàÛíM6šğô¤¼÷%„giªBçYnÇÆ)xWTiŒƒ™ınYË•{üpŒ3ê¶K“~‹ç¨ES‹ıØ¼²t•ªÉ!ÊVlİXX×®ù±ªNc–taìQ«¿ò¡‹]X/Í7sïEãK¼½•h•j;!4.6Ä4Êèn‡§Ú“a¿0aIäBÎ_e4xš0.ÙÒ1Â(Gƒm\9=»•±§ë$çsò@Ï6©n‡¦¯/|hÁò¤¨Û£÷oR‚÷Ğª5_aã²e…İbQe½'›:0ArÜqO]ıuå‹ <†W* ®µô ƒ|6nRTã.„:ŞúR{XÂ§êµéõ¶8:o3xyò6FwŸkÎ.¯Äa>s#Y)†Ü‰±Ë©6S$÷‡_u4ÓÀmBø3‰ğDìâš
ŸwÃDèçphz
m_Íš–	áõóiU[õ„Òä›?Òm¬wWzO’É]ûÂŒô¢YoS0ç¶±¨ıô]–ÏÁä6 
ÌŸêÎÍ>/#¿K„c>ÀÉ ÉX]V´4‘;¹wés™2ÊÄ±Çxéâ:t2+NèCSç@Îæ qb]òÊ[U%jO¥Ü-:w®¾K'é×§hâ¾ª…çwìl¯ğ%ò^Ç–	!;F®'?òĞ÷Â­àHsî®¥8: ?ÊÇ³qÏğ¶;“l7ë…u~ìš1éGêî|2E®Çº§ò¼ÆÇH_@ˆQ¿ÓÎÏP¶ŠW¤ÂáXâ¶…†µ
£†ˆ×¦V]¤Ë-1ÁàS” Zåã—¦à9·„VQÂzOk"ğ5õHÌÒå¼FsÛ;mr¾Òñ½œ ,nn¨Yh˜,.lhç™­’=m¢§ˆ#Ç@èÃ‰Ñp>RÉôö)©f>Ûˆ«™ß…=;këyÆp·¡½Iäj—ÚbĞÍ(ÃsäÉ(oÉ«tüNòtZDzZ{wË½@šŒÎ½ñÅáÖe£-tJL~‹üGÂèÜâ?†Ş©rm&ym¯·ô¶?XPåša[¤3‹Áû©M9P…Ã.)8Âpâäã;¦^VDv1ôF#ŠŠ>ÄÔdÆø°òäd>BÌ!®pNŸ;{Ü©À¹²'©òÉè¢å„-K@İëáİªÏÃƒûRÂ“ú“Á¶É¨ ÷#İ‘/çKªˆz]ÍŞcS=§š$Ô]é<´?ñxZ-æ†¨ã¬äl!8ÉU‰Şí¹ûNöìØ‡Ô~UûõäİÆ%¼ıÕÓäá±>M±•î¸¡Âxo· zŞ}¼™¢ ŒGr¦wÛ¾±çrt~{m‹º‡1ÊÙ0„ÃŸCˆRXñûùU½s€öºq™•·ĞåOrgL%‰}``}ã‰]"¬İkj!eÒåªª¿PåİC	;';ÛIÌ)„¾’>²·•29Æpşº…²Ç0oÑ=_Û©Å¼ªú8NªOÖa÷h;b…ú¶3]ùvİ³şs¼æÚŠ¤©×;¥¢zõÈß•¦ìlyT÷”cæ<[@‹¶>Œ%‡¤‡YH8Ceè ¡ÛC)üĞúãd}AI_¦.¹fóÎØÍ	¡É{˜Î„ßÄPÒ°Ü=õ<«G™3±#Ì®tò®VxaíUW‚,©
ø0g+å»KHŸ9)ù6X«ß™¼—FÎn<V3œÛÖ½« #T3¨ø1ËƒébY,Š¨K™É¹Ö¹™ûô1uc»1õIkêÍéwßéÖBÅ‚·kÔg˜|¦MmÈFNçË«ìTY¨=V:ï
ÂØ{œIdƒÅ&âåš{—Ó<Ğµ{âuˆçl¥ğdœ{ˆ0¨Ÿ˜!°) .v‡°ÎOyïA³“Ô|0Y¹±‹Q¸®hH7£¾C(ÃËì"ˆÀNš(]8Ÿ°2J#Í ó¬S€øÅX	˜MÿêùjÂWDÛ_ñ;œx‹·[[Zæ$nÿ|›ƒ¼2•·MCsÎ	^PÜ.g0Bì*nÒ´ë®ü`Ã¥÷KWøğ=ÉÇÔÜÎ½áÈO4.Ã8o¹Û&„êb°–9¼¥>ÍÄ~–PÇeı™Å>mGH ¶»MhÈ9fØ-Xâ)!ªª¥1[2%Ã²ûN8f-ØÑ³=äêª' ˆQÎioÿ§ºôİ%…Og¨½0^ğànë±×úµa‹à0ºxÁC²0Š±Ş![•äÃŞF‘U»¡î›„SG9eGãIßRƒcó2Œ#Å n0}}6E1Hò´sI¹iıTB±>Ô›¨jbåÖ{x å¢UüŞJi
ç¦B*êFc²bÙÙÄa/xÀsQøàäµ˜Ì‘XB6HôŞ'‡÷Fòª4_9ÒÙÎsû.LõIÉõâ˜NÚŸXOp$IbÎRØËÌ4à`éé¤Ö‚ü¨2v]VÄœhÊc8R‚a;oñî|¾>EñPŒsxšP~ÿ"Ôµ—ğ¦Ó0L Ù=Ë;~5BXe×j#7óÁ~[‚[XâeíÄNù¬6ù@÷+ıU–ôÉO#ØLJfG4A`¥ C¡ä’Z{8¶{èß±yhÍ•´/,ËëEéUO÷#ZÉ^gk½
îc?¨$Œ1SN=f¤¥‰Äíñ&©QÇÌ—Ãe»3ğ‘sDëP}Ş³q¶¶…-¾Ó=òápÚ eí4ï{áÒ‘CLªVÁ}f$åûO— ¡¦–#f™ ú@æ#²âèõéGO»”¤–’§†–‘Eó	’Á,í—$~äzı)[ÇgşT¼=EJ-¡¬Ï>OyòH-EÒŞÆŠ	Z(½øè2,éøÚ9ÓÁOü¦¾
‹sBšç¤ö~<ìhïDíô†Çú$˜.øEoØ¿Ÿj&ö^`ƒ&×âø‚ÌˆØ…mrBY!Òùäiûµ>\`¿Úì!‚.`Š¹Q²\!ajî6MU¹L]-Ï:çÂI’˜{ì˜ŠŠ
k°~ÅGåŞW.ıJS1@Ì&æl–—Ó¶ éA,PeÑ—Ïô@?ÇËø©¨}]Ô7}´ü=>£õñrT~–§²—sëçx¸k¿p¶¿õg9oãWÛ·ô‹y98?ÉgYw!÷x  ,×ëóuŒìƒ000 ¶ÏûØ·š—³áıB _ˆ/ßáåà¢y/Ê¿‚7´êÌ_ÃËù¢¿€×´L·Y?¬íƒ ?øÚpü–'äóõc›äålhÂë/ç;ö}ÑfÇû'û[ÏËÙìzºÙõe³<ŸÍö'¸ÌË!`ÿkï FÔÆş1^Çª}àpp fN5À»	2şÌÈ‰Ö]æÕ ¬›OE ûæ,èÓíÏL€oÓ|MTC}™•ƒfç œœ¶8-PİuÍeæMªM{‚æ2`ä ¬œÛ¨>j#Ô@¥QzËŒ"Ô°q ŞNcäiPM”¨!LÔ„*ËQvÔ'ıêmı~}µ¶ìX«Uv ³âşérY[ó²V¿™ëÿ†öŸ:Şâæ|C¿¡[yëà-;ÖkËµÚ²c­¶ÖµÚ²c­¾üãÚš—µÚZ?¾hkıøŠşP;Ğ?o 9Ê€`ë®3®œcÿE"È;/ )ÈºD¼R®Î[²oÑ9Ë@Ô&õ‡®@†-ø3/È3FÈU>Ë ^9ØK oi³Ùıÿõ}·L+%0J«µşø;úCãÀS ^šsÁ°RÏ°^0‚?3s€şşÿå­ÿBıÁñšô=­áŠo ­øã+Ú²c­¶ìX«?tı Ş!@ÜÄ§À»`ç Üô> ÕüœÍèß¹~ „@?ÀDô‡ÆÄ+åjNyû@¼ğQ€h¨÷—"²Åóñ-^Î_ŒMı¡ëÀÍx€ ~ğ< q°~ÆĞt!àÚf´|E[v¬Õ–kõÚ±ÅÍoÙ±^[v¬Õ–kõÙñ»ps6“Çİ‘½$­Âğ:ŸûùQnN”¹èÇÍ5BŸ]Ö÷¸9İàÏç«ƒªÿùè‹9Î5|.:`öÍq~'nÎfæ=,A©‚»®ÎZ¦ ºÎ¯à| ûîèİĞßÁùxünúüßÍÍA”~æm óµZßâ| ëo‚óA‡n·º½ÙJ{t?ÿ7ÕÀU
 Jß•öë|ùuçVs>ÄA¦¨94™€P%o¥° %zíWss¾îİŸØ¢ÁŠî4úºÎ/áæ¬ôõOù‚çÜœ•ó?ÊÍA˜~æ<¡õMZ©·¶ù·ıi¥ş&ü‰İnu{³•öè~Ğ¼­ÿò§UëÉÏø“jÃF5ğC•|¨2v¥ızißò'uÔ¾Ê—,P_º 3 BÔ1àOÀs„æPÇ›õ!T…ı›áå|õÙÿñxd#Bïı=uÖÚ*sL"ëáßÄËÁÂJÃG=Ï?ÆË‘_æåˆZŠ õş2/‡ÍË©1!“"ª¨‘BPá²*a ç
æğÜ™5Ç]î,İ9Iàˆ`cÃä¦Âõ¶@àT6Q’±—b<(*hãtév¾Õëæ™vÖ7mñ²ì5­Zútº©¡A»»Ût\,×½Yµ…£Æ¸¡¡¡#)éFG½P'±†0VOüÙl)iIÎC]­Ó£M“Æ8ÇñÒo<¥vjm|ß©ÀR±ã¦Û!Øª¢æVkÛ¡&ç;|&ÎBş×um¬Œ„1QU;EÏHÏY¿#ÉşP«8“ß57Ñ]$Ä/0¥g9éY&¾ `7MS—½o*r¼€ìÔ°#6±îeSFä}ø¾Ot‘ŒÈCÖKmO¼Sìã°Kíåªjoåo—‹9ÕrÃ‰¨±İÕZ
¬éÅ#´Ï	‘(å’§#ÄXíŒÉgÕ{`”4¿[Êu®“–:­Éü˜Wd5ÓÀ¡jO*ùí×ø&E_İ9
ó(£÷Ho;$t¡µAùãvã'’àÈ{Ú¦²ÆŒa\ouSî¾ó1×®/"‚^¾[Vù`‹;[,ßõ~7âu,î^Ò£OK#OÙFd¥öç…”˜äVyE5šl±;ùhÆbeñ£`½2B6™RÃ
kq¤úÃá^.R]¡Ó}MfŞÃEvù-^O¼bUÅˆ>Ş—dk<ìbé“‹£g™‚‰¾Ä”Æéd˜3œ¢ê)]Ø0î5v¿¡¹üq¡¡$i\HØ±7É]4ŞKxÂŒe´ØÏ]ÿT…#O“˜·[éƒ!…Y¨£‚#IÕOZÿJ–£…^ï#ıD¹Òr…T*Ó¦€!cPpmõ^ZAëá6ÊaSÁ%û-}ùØ`K7>«¶‹y¬Ê‹Ï½Šì¨òÎñ„Lˆ®ğêÒ•³ËÑ÷cNÅÛ¶§;¦¸1¤òÀn|Û¬'÷í3õ¸l¡u@¯€øÂ™AÆÖP#^=Ğ¥uÛl6\	:síå`iÉÅSÕ¸Æå1%IàşÂUó	ü-ïäİ8·)µ0`_&Py/Ç«ép3.4ïãGÌÀ¾n½üóı
öœŒ’’“ºíØ:ÍåeâDeÅÏŠ*0xDvÓ[E1ÃcB¶î˜?”gë#¸ø6ƒ6ä‰Ç"êã(#	-Æ@ì»ƒ #å£§×•H€ÆJŠR–1v!'ê¶_à[¬MJr²wŒú`C™½O¸
^Š'{_êå£Ö~¾ë÷Ø¸Ù!Ç.Ä"U%ºñT¤Á1Êc:„‡>`³=fŞ>|ÕÑÓğÑ]œû6$CÌDâŞ,²¶"RŒ¸R®w‰À7È¼\iëm*DbË$²{‚ƒÄ¤x@>šÃRKKåx^ 	¡»˜‘”â²D`š]—w—©Hú”‘ÀŞ?ºY 8Á-ñŠGñL@YJnSµ3êG_P±á	µXÖp|~¾Øß~ˆšBrn›<èÊ5/1ÿÎc"¬³¬#Ê¥B3Ò%¹AÆºnû–’â*27ò4åò«\PA^†‚âb¢§5Cä¶í–“ÇåŸ·iÏ´­¼«@ğÔu²B|H»ªŸÖ^¹Z‘?k&–ìğškìˆ–6N¼Êİ¦ +!ÅªûO^x¬É!X­á¬È Æ­Ä‰“Æy.c‰Ç´Pôø¬b–{\' ‘@úı¶Y¤“eØd|šQ+f¶Ê’Ê%âlê Äc1â^·ê…“ÖŒHóı™>|±óz¤P£‹ïT†vôŒ£7,z¤m;Á¯ÅË;Q‰~kˆ6-´> åzSp~ˆ˜D_ÃË9,¹gS¶t»	dÀQVlˆLAs’ûß¶u¨k—7wDÏH¿â`°ërª ìT¾ó¹ëQ”qOúöt-Ñ…âvÂá-"R-9Ú‚¶Òï(Já„t®J¢7sá*“â©¤©UéJ’¼iºìÂo9"iÀBsãæéj˜Fˆl¬D»¯ŸaáYRéç>Uİ´Å§±qÛáîÕ„B²õ	^Îª¨és¥¨ŸJòz”©éF4À§9Oñ(ı¼6}â^$HÑàÌ‘‹¬¾IÂr]5M&ÓI÷ş=diå‰ÅÅó¶U±}OÂÏf¼äI»øL5e»Ê‚Fşµàë»œïàğfVÃÓyÊe™‹ÀÍOuğ•f’ºZÜSbì•Ä}|‹j‘{È}o€~,oºOâ©vnct\‘Ï8¬ã¼ÅEÜmäÂîA]`¯&NáìL	Ú6Jp‘¨Ô#ä¼“ìá¼Ûšoì›”'[«û™Z£‘Axeu‚íDšX¶}+Ô´J5˜pÔñ¥ïo|f|Z˜5f‰ÄÓ±ÁÓÒx:Oõ¬®¹í’.åQR(<ÇlÀïVaªNIMÁ
,-\‰ÅÌŠ[;ºì‡ÇàÎF@K"¶û”;)!m¾Ç¦Äî„´Œ]¸a?i'Îî%JŸT>­="	­|œj,‚LHaJ C€ ã½\¹¬K´ØÃù¦bˆaN£Ç<£·TâÓtĞ“¸½Xš¡¤‹éL³æwÜ"²øÒı-hËü‹ŒkÆıÂ±ã%vä(M¦½Òéâµ7ç@Õtç€%7;XD”¸ïå‰ı Sgâî`fD–µX½í±Ûq¬ÑêZİİí ^O
–š°_…e*?Ê3-Ñ|A×¶£U;Õã)8SH1fBÀ¥7õ)"’(ûÑ] ­0äX‚1¨+&u N–ßŠ­ a§ˆæ!K^ĞxÃDÎ‡nYé¬d £Â¶·wıÈ®*,2ÃéñOá´(@™°_‚ƒ1 Œ•úÈÌl‹ ÏÃY ËŒÊ1Ñ(2:ÕÆ7î…šB…áÂw»>½Ş-ãQyÑk¹GÄ©U=©(=œš¤Ã¬1Ç=mÿ¢ÿ)ªHÕÿî=®şù™‡Ë]ó€hvqó-«Ş84\Á™"‡K$vÔ÷´rKj-xÅE«	80˜·r)!mU`‹Æ@?pp	V]ef÷Ö(ò…çPß5ü ˆéŒ+äìN4ïdA3D~¹Xîşëœg¦õŒwƒw‘İ 9Í 'ˆ¨ÃÕŞtQÀ¦Ò¦|µÏn¾!!$|É³]ô°õKøÌñŞ\†ğ«vıŒQ ½yŒKÃ#&-cGú^÷{5z×Ä€$w_z~ÅÅ4;!†BAŒ¸¦¸~ÈÊ¤¢?*ç9;ªíÒİ:z„OEßéwœ6¡Y—4ÛN=ÍˆHL1XŠh„Äk¥4¼>£†ñ$üÎá!Ùë\2—rzÂ›çF%©?z>SyêÍÙır¦ŠÏ¦ŒbÒÇ*Ú‹KµäÏgÙ¨IÜg|.£V+7lŠlÉùè›o‚ÄmKÃ„‰É’ qa2»Ì¢>Á?p¢€óÿØ;x¨¾÷ßûRT²”%Ë—²•"ûÚ){‘%d…„Q‘=”]¤¬)Zˆ”
)É’$Tö„ä?g¸…ÆÖö£ÿ|¼îœ»œ{<sÎ}Î}î˜çMéJİò–”¾yK_-»¯õd»oLõ°ÚZGc×çoÄƒÊ}4ÌU‡µw¹}J±#ºş•(n¸Èe½‚¤ÎõŒAº=ôhÖ5ëÛÒ£OÄ£E¸Ù9[6ÄGˆüG×¹ğÓ=å/šmÂœİ¤Ãg.,´éd^¯&Û3Hşœ ë‹³^z`]ô‰D† ;ç­¶«ß.=¶k•5é`uÉğ²}F_¯¢\åµt(]¢Ñä””2‰öá¥zBÁR]@qòÙNi)))Aniéaµßâe§š±Ÿ0ø³º\‚höM–}#G €(Å,rÎø¹^úyö%1h‚0Û0¥âû6,ìÃ 4}Ó1ú!,Ì¾ÇíğúO±o†gÁÎ˜øƒK	3gÁ ÄÈXá¬7¶zü®	›#š…}öà¶opVı7N6G4f¬˜ş›¾m™»=~×„Í]šeÿuÇZŠÛ\˜İ‚B¡ ğ3™`ûF#`öe¢¾±B ¥×'-£‚ûsÙ¹ObVÛgÛß».Çkö¬•Qëp90V¬|ÇÒŒ¼NĞ7¶Z9E÷}¿ş°ã1y½~Ø¾‘Tßû‹ĞÂ®áª'ÿÓ,"ÜıÚ¹ò¾ÿàÖ'p¾péÙU?(~†ş6I{à~cÊ9»ûM6f¡ÄÛn.ĞwÎÍ÷›»|	Üo ‡f„sc€åÜ nÍgqÜŠ†k`¹4€oX6ÎÊX¶ÍƒMèa˜–Ax7€‡SYŸß‹åİìáç*cY7ÎÎ€•£ŒeÛ àäT„êaêè`¹:0gº?ÿ~›šƒv€Ü¨±ú«Ûøq¯9fø¾ø~)øÎ:Ğß*¿åÜàÇe¼æ 3ı±¿[øï!âŞ¬àÌ|L~şø&üüCsÌo~ü¿~\Æ?|~şÀ¡yjËh	çàæĞªÑcŸO¦Óü?àÌD8C.a¡&lƒlÕjÎ äà‚|+P‚k<Ÿn5bäùd¨†Èã…YDÓéß˜?`–ĞdyÛ ‡f¡yÀÊcçà5	K³ .?¯×<? ãaªíÙ
àĞ?fÇ¢ikàşóI4çWÀüÀŒw^8ş ÛLcSXÿÆüsc€Æ²aâ,5?ÿ 1Ì;\„é°¢sp€eÖ\Şy}}ÀD˜Ì6ñİÃä”YhÏğSÌ“cQğ|˜2³>şÀ!¼X}{Î™“ı{Àÿ`{öø\ãQb…÷—ñÂÛ1^x;ÆoÇxAs‡#3“üæ@u™Şö+ÓÔiçOqdŞßgÂÉ‘÷cKÄÜæÈÈ@ĞzÌ›/Á”ˆ‘œü­"QK¶Š¨Ó=X°µd.qdf4özûdâÛc§ÌÙ‡ëüîÜx -ø ?Â‘Ù8	GftÿŸæÈHØğ'ÀxÕdÜ¸ş¸`~à^ğ·ƒÆÍ½€÷ÿîÅŒOlÂŒÂ”ÛGÇk¢¦ã^lÇŒ¡1–}Âr/ ëÌ0ÿ¬ÿnvîkö>äİ¥)#í‘2¥Áu~‡Ámı-‚)Ø‹hÔ‡Æ²S°íÍ’“[;Â:‚5™Áõ¢ÆŸ>©ÁõgàCàÒùÁ‡®Œ·3§&úĞXÕ¯øf±ÄøÎÌÁL¹>1™íÅ¬ËbFÎ2Âz‘942^ ¯øX‡}	”3õ%FLê0dpûÀÏÇ"Sù¼ögêühOÙòş?Ä! r§ÀÜşò.˜!ój‡²*uÑĞ¥Ój4ym=Ï<µ¤öˆÅ^÷°u$fŠ:è•¦¬ÈmÜxRDÂâßÅÍ{8w-–~êÚÕª~­LÌ¹ÿJ¾Ø{€mŸ„LRSo^/à|¸^B~œLŠó–/Ohll<%•šg£ÅNT~atj‘¡£¶ˆğÆ²·…øô-X®,ºãõø¾»›Åğ!+KİO{Œ2l>ß¨8!Îã4p÷C¥ŞJ>B²aƒ«‡¨)YëŞ¶®oxm¸iÈŞ@¢§ºÀ´ı]@\Äã¡äzÒˆU¶tºVèîç¼Ak°­nûZÛ}¡j-•ù¶Z½^¯Î·›Ş|<·½6\÷ê	®-ÕÒh—éeoÈ¡V¢–«Ü_Ù§„0]ªÑeyAû?iº¯C!-ÆJƒµÜíZFÉâM½:›¶[Ò­ÚI·ƒRÔÁú¼B™>û_ÉÇuçi.Ø-¼ø6‹Äé¨=c°T^!é‘ö³v†¼CÅ\›zÊ6ŞfÑPa¾Ú£È~C´†$HïT¬]¥tCÚås¹ÒfzÆ¤‰Ğ|<Cr÷è-¢UÛ9ì×µ“xí"NªÊhhkËôW*Lb9?œ+ö>ÁÈ9m™ı1qwMºj
>)÷ÂŸ¤FgYì àÌliÛ°äZøfÊc\B	2$w½;$’KÉymàüY¤Ø^>é¯<d“Ùµ2Îtk§¯£ú/½-æ]¤¢#‰8—ÃÉ/×Ãf %EşÂÈrÍúİ;3ëšr•T#ŒT.Ú‡gğódvTz äämãD»–)n	*ñ• ¤§v¥Õ!a!=îao×|D"¤áæ&ƒµ“2êuE_}‘Òwecÿ`«7kGæ@ÇÃæôhÅÌ7Ä>Úq]0cÔI2òì<¾­¦Ù!hƒ£*ûpze"6F	²ÓĞ¶\‘Sm––a”¹ë-ëê®N~i(.¡·¯"?¶—ÎHò¾uã“ÖsO<îñ¤Ö„şªÄÜk¤ÎÂ´ÈA%Ş—¤şì®#‚uÛµÌTÏ½½y¤úbª½}l—»â"¥Kunzníw>êI.@Ù\dHQMc{s¡tToF×TßúÚÖ÷¶ÌA¸×ê*ÄyŠm8g£`F˜RJ‚ú$|Ë³xÒí³Z¤²Gs´6o¬mVJ–=+ïâLbDÂÅ&dè½şİ]gk„ßnTØr§*:U'GDÔc®;Ù·-‡:¿ØûÈ1ê“  öFçG»½ËÔÈºÃsòíÃß(F8†
¬\EøàFgÅk¦ÖShß…†y&
J«•(E†û6FÑsª¸Ò´…ûJ¨”U'U§?&ÁÆ“‚>—*ÁïĞDnG6¼°¶Át6Úo¥¸x‰¹Xs›²¥•i1KÊµ}ånAt¶wÙ#ÔW9ßæ9À(M^]ˆä½DU*‘„:NzsAJk]ÜâÚ61yŞÖ{$xÖÉ‘ûPT±æ¦ÑÄ¾ôÚyXĞ_ª¸5–W×È©eÕg”‡ŸîùN>B®(—Ø{†+öw…«')æ†gÓV'-äÉ…P)º—NR¯8–EÊ­a¶år_ñô%	*€øİ^Dè@ö
ÀëÈub‡âÌNİ¤æºW´¸eI
2X2²&{Ó•R‰ÕîFyÚ¼îİ¸ QEú®¢¢]{n9uO”b’Ëb“[jyå—#„ÑìÌI<é{(†» oåM)¶Õ‰—–$
…š‰}¸ºÇæiŠE]b1u-” é÷‰&9WcMD{@°ùYAÓ¹Û]Gê3íÒ?}ò×ÒŒ3,ÓŠÌ¹~±jr¿E°Õ¹-âfÒZÒM},+Ì½ùv”eô)±(¹? <!Ü±­çSj*‘¶}ïBO¥aö¡¨cnÜûçÌëÓx¤ŞøJÜØ´Ø7\ëT•Â2³ƒB<b›È²y*N½Xñ”¸ÌŸÉ¸=N#vŸ'}
áùØ'r$‚ÎÌD\´w}ô£Œ_TGx8íÌK$h«Û·~{õ…°¡ª+x.Sôª/?°…HÁ¯€8kG²…B[;§%·i±Éò"$šJŞÆ¥ëşô8)ÌÙ|O°ÁÁ&÷Û1±ÏÓôSäŠQeÁ«d|WòëŞ·¾Ä`!'…’<-İsØàÎPìvù'ïš»ı_	p5ĞÆø¦:ÊDÜy{å~mu+AQõm‹f[½Ÿ£zÌ½1Í]ŸDİ‹~¯:sÇ½ÕÚëÉ2–m¦\½ëƒu¸Æ5‡µ-Zå]ÉìKÙOj 6k›u·ÊÒÉ ©!*ù*ÑSšK4¾
o±_µóZÀóĞ$ÑçYoT¨Éy’¤} ×”Ü[¾o[Ğ…4bj¤g}V(÷IiÊˆ“²\%¾$H?*“üeÄeÅ×¬©^[úTî¾]Öe«gó´ƒ¡íMPIwzAZVŸÂ=ÅIWˆÉ½Ñ©ª3/È
÷=ÕŒ”pwÙÚĞÌ™`ñå¿«±Ò¬*â$wÓÆpD{‰„§Ë½ªinµ×¢Wf'rTFÊ^~“`H«–Q°Ob±|5Dª¶·8]"àyÌÔ[±V0ßX³õR{I«ĞaRÙ}±Šµ/Ÿ®P)>At°’/Q“õæ]Ÿ¶ËÜ-‰ñéFj‰¯MÄÃÃhL=®Y'¨²g.î§O/—®ÛyHWJLş”C´ÏåkÉ,•ì²OB‹£ÒZ¡gê}6¹Ò‹,yv<1‹^>êekXjvsÑ§ ˆ^IÑ[øCæ³íB9»Ù{7æ…¹/;›µ½v[µMOÕ>÷lõ0¢=Ş%-ItèwâŒ+ £föÃ)6ô=(öøO>šäà¦şKËsYš<Ö›¶‰Ş¢áöIG¨{Ñ$ºo?NÓ¤ğV
ê×ô.U»IÈgCKp)[²¾ñ@²— ÓIŠBI_ÿiú-§.áú›ÌP÷Iê4)™3»õÃº\ÖÈwä8G±ˆ"—²/@¹ÔœTrøÜ-´óö2edÂŠäkz›İo9q#ë‘"±¯ÍN‚L[õM¯ |÷‘êG{ÈTsŸ»O>ÏT_e±HfjÕsIèÀ+HÀ{uFT¬õá>?Õ§Óşâ»¡Äee¥†Üëøf’²zè‘¬Œº¹¸Ä?Xğ0Kbe¬£¼¢f17z7uy+[‰¨æ»ó-¼‰üå’L«=D.ì8¿Æà¶ÈGÏ½Ôè2é=+¼×ú¶dºŞ³
!Z”¸²±êjcåXj!Ì¼öØ¥BìA÷~…›Í„,ûRzQ½yFšëxèjFpçºTşÀ“F^¡¡Ó#Ò8ıIé=H»V×ikí&zÙ'ü4BVåHy—·ó¾~İ[Ï·è-÷_©¿›LÉ•†U~‘’/JV^ò8ÑOîx3 «0œ*{dï¾
n‡3×[_$x0°Ä-ÜÿxãGÆÃUÚ†[emšö¿ûª¼pY÷5"§U9aRu´œF±WÄeß‹‡_«Hj»#EşÊ¹äÍ§ÈõƒôNñWW)I ¹n&Ü©øÄ|ßõ£µ£Áğé|Ë}-ºéê×ÊÖœ* *XÄ{zËqêJ¥™´Å_:Ènèv¾fCšÜwWŞUûåÍCÅw_÷ÜMëôÉ72¸ì—0´2á«³›ŠÜP•ùé¾…2ü²Ÿ¹ªÈÛnvóÅ(›qcsÏÚ-';ùŸÀz†`†|˜TD)f‘#DÀÏîºĞ¯óaR#ùúˆïÛ°ş&n6ü•ğ~7fVöß5asD—3†x¼ôø]6GD>Ãö@ÿM_ë÷Û7V ã]ÁYïë~
gã›`ÛÃmŸÇ7>ÎÏR¾ißdÊ~$œmÿa_°ú¾6F³ç‡Àæá6óô7^

çqX°}¤ÓğuÈ¾óa¦ìÀï|L´‡Sîßy.È©L„ı—v[°/õÍ¾iŞ/é„œõ¼/1{şÏ”öÍDSğa\9gw¿©À,¬ˆŸãÃpY÷›Še,ßåºŸ<ô8f/–.€˜-€Sxf4ê…h~ãÄ îKy„*T¥½À,OÎc¶Ïb¶ƒµ°Ì˜#˜1€¸3€˜0à6¸4€Is[bÚÃì¯8·Ë”Ì˜W˜cMà¸³8şïÜc5í ÿSıQb…—ñšcv°`ÌÂ9ºûo•Ô£%~\&hÚ1Óÿ¿ı»…ÿÿ—8„·«oY¬øş/üüñMøù‡æ˜?ù_ÄŸğã2^øùã›ğóÍs;`B
b$OÎ¥cGŒäÉÍ4Gïßˆ?àŒB˜ôºz´œ)‡æñüráÀõ²POôÈRÔè>À’™©şù&-ÁúEÒÛ<?À5À‚áÀÜ)°ıKÂÏëã5çÀ•úÂÇ8ôØñ«,Äëó‰yØ¿ y:€¸Ä¢€x €âp¯w`8ñÌ0›NÿÆüsb&ê'cÔyÀ‘:5â;3Db0ÑĞuÀõÈ:³ŠĞş¹y}ì»Ÿ©§ŒÑ<?Àõ?ËÂ4P‚gx¦êÌ”¦ƒ?phÚ1Õc{"ÏrºúÓm‹_ædà¹1cíÀscx;&
oÇxáí¯9dÇ\âÆL—ÓrµˆÛ§ÍÕíà¹1#çMÆICŒpcú07FoùVFæëÀÖõ–Ï5nÌtcO½d¯Ì¢Æ)óôá:¿ƒy·Ş#h>èpcD&áÆŒîÿÓÜtÁ{Œ×XMÆ¼€ëÏ€yíŞ‰ÌËÑóáv`¶ÇDæÅXæÇ¯0/ÀûÌ‹˜ƒ±˜²xt¼&
üğó±Ë¼ ch	Ù`^û…e[ NÌº çÃPşn†n?˜½?íŠŞ'cù~J‚ëü‚Ûú[ş$!6	CftÿÏ2dĞ#œ#X“úÓh½¨ñ§OîO£õgàOà’úÑŸFÏ‡ÛùÓşdŠYl1x	æ`(¦¬™ÄŸÀ51™?©aÖU0#§ƒñ$hÄgÀıö'`ÜLıÇSÁuÜÜ×ıÏÇ"Sù¼ögêühÏ9!™©êÀq—Äì¹1_(0¾øsÜ˜íXnŒ»N|¨7[n…!Ì©3_Q¹´PZi±.¹+[ìÁ½ä=²7›b‚Ói4ÿ5¥”Õ“H,•2C°»uÈİvgF¿¬ÙCº‡$+o»|ìJ±"E-}š&©BÖÂ–„êUéY<ózTúuƒÃ§¾‡&í/ô˜Fõ‚Ä-Ccè2¿½}ÿ»®®úwùÕÕi4Ç|(‰7±º“kÜkJntşÚÑà‘¸Y4X#´ÖÉ\Ç¬ísèƒÎ:ooö¢¶ğ ¤p~9Ğ”qv8Ç¦÷máåÍâò¢Õù]·+y$|Ofäñ‰Hç9¿¿%7"gCäK½6U:±¡¯gmUœD¬ûSûv¼´o~&®P§®.Şı1êdÛ ƒ»‹œ]f5gJr’øVûçZG›¾¦{TwŸ,óí•¨m×¶l»rˆÜ”¥0¿d`«İI©ÓœÏÛI•ºò’ÑY_Î±"?–Ikµ÷ãvF*á”Ê\_Š¥ç;ÑÚ»C>ƒálÔ[äŞÅ~©(.±³ÏşÜëq/•)Ç®ßÓ!ŞuÏ6G&AKáL×Ã‡O"İh†úÚ®È³räøéndñÕ±D…„òÛ^¬kzI°ıòBBvwñh’Ó7xt\Ñ„[Û-Ä|ZôÊ2wú|.aá[]ì]ßUØ}X,Ã)Ì'ş”WóòE¦.¤O·±RsrVZÀYÁNáO#¹¤9Û±ñcj°XµˆçÎØÈ›n Ò46Ğk¦´Vy,M´—îkd;üŞÌu³cÕ“£Ï-m*ƒ­«£´	[Œz¤¼ˆ¿T¦ì{ÜDà’L©ª…y¸æ—7µ¨{qÎ5çÒÚ÷œƒZóµs„úIÔ©œÒ¸Hö¤¿¶’—»Åîn ¿[è)DõZÈ°ª¢OùUçQZ;ÍPíÈú ç¶Ğ€Šk]ÂlîzÕ}){sH?ßw×qmİúËÉs:Ä¯’
Z‡º-Rk…˜U^ç'ºpHœ[ÃwÆ÷ÉMê“iÙW?®´<$jıÌû©z@9"¦5Üøm¯•rQjÁáƒ&iv‡¶-ŠJ~À¥yGZ¨ö…Ô“auãt52w—8(É„kç[FÔPkØ­·SÏ5¶f4iHìòË=ËxsÏj6§Ëæ.*s²;Ü9pÇy+ƒv¿uŒ¯%Â(XpcüNéÊÃwjDLzejãÚB-öŞ¶>|Í2“‰p»Ò{^wƒ«È Qˆ—nå~y*.Éj?â7¹µ•:Ã#Ş>úË­=[Æ\ºaçõû¹æç6ºyÙ>Ú½p%¯ /g+‘‡Ş
u£¶×uÎvg±6ZÑ7Z™òdøJ…óÓI‰óæAd¤P~j¤8ÿ**Ş]]v­ˆà.ß¢mÎ,QË<JR²”Èª{C+äŞb«:-x†5ÓÉ‘oe&/%T0È(§ ÛÁÉù©º¨ ¢"fâ%¼êr¤©ûLÿÖD[-i…¢óä¹|\,ü–;o.}ÄRW9œıŒê5b¶E
AÈht»
gu-)Ç‡“mä7ôÍ·5¾Èj“H`!rTJ·¸FA„&çÕY	DX’º¸Å‘*ì¡å×)<H¡B±˜%(eøsaO!
dÙ—MÏJìh¤F|ÑAFé%åÄEÑıõ;märáÌñC¬4ØXãÚo'ú*.kÇ['FÌø!A ¶Š¶|»EîZ§ìNaD´©Òı÷)¢+µn ·åÆ19zĞ»}õu;Z—ã|ò*ãn*+†äá¶2şÂ¦ÚOÚ	+ei,®¹2ˆê‹'n.‰GDY]$v— ¤$ØŞ—¿.`ğ` ’Âe™jÂ)\Ä!ã²§Â3„Ğÿ|%G=ãd²İ{¶j>#9cöHì“T»6KİqöŠ\Å:z£ˆc+©|ßôA!H».YäE@"ioô–¢N\¾¿¿SáÂœ;q§I@g´h`£üªH'¾ ô»Çi«v(½?’ÑÑÔœÜøÙ ¯ì«”—İ		‰bzuû=uŠ_n%›·†t©Qs»,É3$#ô@~;çÔDÀmÆGÌQTëÓpõú–­¯[TT{mëK³Éé¯ßtÿSçCõê7Y»“ê’õ^]€s® ‰ï+§KˆP¸U\ÅhqÍïHµ|¤FïÀ’ŞèµJ^%bßp¾­½BbKÃÿÜßEq“érMİÇŒÏîdnkIîh3°ø²Şóµ_PkTµºb•@Ã¦İqÁ‘t¾œ#ë4º‰_#¢·°òE°UúI9 Ü&·jcz†[ß¦M¡şôå±üJFÆ6–dJn[¥ş0½ŒZ·ÒJŸœ¡ü>ÙnùpÛnOï7·vK>8+XİÚ´O®|`iï…ÿ” å²÷¤Ö(‹]-&VrİªƒğtºAwòdk
x”tBäé}ŠŞô×ô‘df–æA[ÌìûbÔcw—?¹P!{ºaC
7ï½A²º\º[s‹p†7Y>ğ9«ğŠnëã€.æ²k7bîm’ã·Õ8ñ²™åZşÒ'ÁFeÅƒâÅÖÈŞìOŠ\œ_\¾å5ë?ª)I.xÀçÜĞ4(„X¨*a‘š…P!o—S®ìºÉ’7èÉAg&Ã "õ„ş†*“°‘>¦Çx1+Q®±å‡Õ´í\È]Îç¯%µ_¶Û?øŸ[Ó—öe>á*wI¬:\S{s	¡‹Ú^+‰Íµ¯§æ	57W5S#Î4Y×>fãü´Ç-vÿcÇàŠÂc”b´ÈãĞ:åå¼İû‚»«7q“ä–¬ÓİÆ±Äl×³ê]ÚÇ)7ô‰;´c“ùGÎÃJ«8éŸCe$_üÌ6pºÑˆ4™o Û¹Z5ğ›Æ?sıòĞ×í5±Ñ’|¿²õ
{å%–ovJLˆª«‘ñÜ«è&â©Î}ñİ!F“ÕD¹!ÌUKäx)rë–£O¯®êÑOÂX*Ör“ök²…Hä M½Èæ(‘ª|¤âÂ­AÒf¤~‚!´K,O‡q|Øå–<´™Éïø'³‹w)/î¼ìG#ÓI™)šÖÕc›ï.òMÈ÷œÎ…3»ï±·ĞÅ·\(ÂcëRîm” |)·»<V›úvïóêFú•î¦wC™›X<o-<cq+Ú)v­Òga¢rIbQÚ$”t’8ä.Ú@}!äT^ã½®Ôa³	dÔ°6É«ÄjÍ`eFµ™„—BÕ•–+I’œ¶´\y‚âÖÛK6Azj+8Ïû?füù³¾YéĞ[VŸî–!‡µ‹:^Õt;†#ÛĞAÉ6×%dÃ¡šg+Ö­	¯Ø\¡ã²`¥ŒH½’XfËNãUDõåT¹rg¨ïº\?`¸³O6ás}p7Çpú±u´—8dÄì¨ğiO^@*óÅeõ¡­=úŞ6«,ê”˜9·]·®og…x+gq¤Ö™ç|\SMÙ{=TxÕAá›3òwuí(™9¥éÛîJR÷ŞŞ¬ô~cn‹cíZgvşZ·EÄ‰è¬e™aÁ×_v	°ËjóëÊ.ã²ÙÅªğ$Ñ(ét–¼¬|‹¼ÿÊ¸U
§½Y9•„bÇUÕØı&çT…%6¹+ø]å2Uİ2¼î°à
sîÚ{Ã«3|ÔÌß8ó¦(¤-jÎ)1UŒ_Ìüê)ÄÊrÆGK‰*^pxÉögÌ¦İòLŸ»Èòm”®È®hCŸu¿óÍ•Ö]!ü¥ˆ@r­¯b²±GK¾¬[gz>‹:‹—‡I•fÕ»Ë„âAWÿ=Ï—;Wºs}6—¤Ì¯ÛÅ—!Ø;|­úüÑ–ô‚ÊHßÏWVg¬]Ï"}o–$££dìxŞßßŸÿ£P—¸iòhM‚öáı;¬fzVÍùQVÍd)f‘#Ğ@ÂŸèB?ÏªqeÕ,@°Ô‘ß·aa. ñ¬Bğ¬}gÕ€ãÀvxı§X5¿ª‰ü¾²Öã®7/ñí#qšÍAOØÄu.®}3cÆà¶o¦ã¿ëƒ†Yè§š¬OÑ6£gÈú™JX2‘;¬M½LÓ!hhzş
,$ĞTFûoÄ¾©+ÎTèo/ß7ƒFÇyÚáFMW\z†ı‡ılj*ôß÷ñ˜F(jŠ¯Ãã;5¿×˜ÎÌ~Í°oõ»ĞÉ^3›ÿş‡÷ Âÿfw*Å,Œ˜ÛË;pÃ¾ók~¼ıØ¥œcÖÁ4ó|”UƒeÖ8+cy6€aX5#l™mX`Û ö`Ó FàÓ<SÃ²o ‹°i`–CƒÙïìì<Â¥	ÕÃri ÃğpÊ|´¡á;ÎXnàß”«b¹8€“sßOËµ)¼¼ÿwö±ÂÛ1^cì€¿cû·K¬ğã2^sÌ‰y ôolÛ—ñšƒvÀßİÿÛÂş^ü¸ŒŞ¬æö÷·ÿ‡ÂÏß„Ÿ?phÇ]øq/üüñMøù‡æ©0psÆ–ğs`ˆ‚ToÈòı´Iõÿ'ş€Ù:3Ô<?@n:ÈSŒu— '” ‹›z´œ§:æ÷ü±h´„I1p	ç$ƒLíŸĞ<?àœ@˜&—,£%ÈQë3ÍMş&ü¼>^ó8ş@M_eVÂÇ8ôÙâŸÑ¿€;ì/jÎ€™x90+¾‡ÀL86ìÀèug¢ù=ÀQÖXNè‘_¼Fæiüx9`½ş¾U@âRP‚¨ô8>«ú'æ8&…iDp€ŞXôCí)5OãğNa^ÌÉü0—ÀçÃ™ò•ğñáíÀêÓ	ßã5í Ï®€ğó7ÀkÂŞÛğã2^x;ÆoÇxáí/hnñs¦Ëí9ëûÊNSg¤?ÅÏ10`ÃÉÏ÷cKÄÜçç€ï÷~2æç X¶Š¬~°,`Å2×ø9Óı…{eËI'ÔÏ€ëüŞÜx -ø ?Áû@ãæçÀûÿ4?GÂn„»Æk¬&ã}ÀõgÀû`‡Ï{>ïèùp;nŞ¼ÿwñsh#ü6äÏñsvcÆĞ
2„@æ„Â²>À9 m^‡·ÿ?·ÌŞŸ¶™í•!ŒZ0¥?Áu~‡?Ámı5åNa/ ØŸ&áQÍ”Ÿ“[;Â{‚5™?Áõ¢ÆŸ>©?ÁõgàOà2úÁŸ®Œ·ó§ù9–˜Å
ss`NŠÂ”Â“øğƒÉüIñÈ¬/€ìÇùÙh	öÍÔ‡ä1DfÀĞÁ}íÿ|<2•Ák¦Î„÷¥a%sğ‚ûbè¥S@Ğ¥ÿ	C3t^™++SQ¨‰Ö]Äñ_jç3ŠFåĞ¨5ëŒ_‡—Y2åRK¯ÛŸL|Ï’…ª~m¡g!ò Ä2R×ÏôEı“†_Ú0íälî15ô/~áğ¡—Ïä¡sYéÀó{”`=u¿ì°?!´ÆxsÑ¦¸ñÖ–*}U¹LÊó^½Qé¬î9u#Ë‚»&ó0GnÚ)9·¶³•MKá¢;Ÿ[ò4‹?4Æ-·õvv<ĞMÊ3,˜û	ÕN³×ï,Ñf«º¡¶ÿiH]YJí¦s"ı^kyœl‡iª(ê,²oYš4òºEAû!]±÷5Nz_û‹J•J:^[„²G¯±ï²Óiê|‰,Ì/©~IŞŸ%ÊQÚ\Ê­­¹ô¼åj”ñç-„ZïL7Ÿêq£³|µŒCê­f6ï»$¤ŒPB©1µŞÆó¢ƒ®|ö¯%Ë…
|Qvºı/{ÕErG]"7[îå2°‰ñjŞË';º3MÃìòB^-åĞR1*Ğç_Ieu$é„ÍÓÔÅÄJ½³Eêx×¹ÔWŸuêÛÄqú¡ÜÖº¡G»İ³·¥"eV' ¹Ÿ¯œ£SÜº¢Õ»j-_”±ˆæ¾K]ªiÄş„cUƒñî1ıÎ~.Ò\èB@t„
áæ“¬ı†Ì2ªb$•·^¥?!§£Í_xòèŠ¾’Jİğ!)¶­$‹‰©×&ÕnÊ²é}Tó¥Ì9ò	¿ê–vÃsuÚ™eQNF¢r·kƒZÕ&‡é£¿7õSJVnˆŒ`=­ã4ÈÑ!»R6|õS‰ŠèU…ğ.Ôróİovª~rÔéíTwJ[Ü-nñDÔJ€¹è|Ôº®ò¹Q·2÷.„¤¬ş|şbjlÚÒ%’Æ¨«hşÂ,:§£bûY´ÉÚÛšÄ­ÈX@(É6/—l°ˆ^ĞÓLDx“êíK$Ù–•gRú×÷ş{gåöÿñ{L(£l1%5¶,i±ÕXC–‘5²d)ŠBö­±Ed_ÊÚØÛH¤,a%…¥¬Eö%»úÏƒ¹—FåŞn÷wû¿æóz=æ™3ßsæ3çœï™g†ó–Š|©o8#óÅ±3uÿÌ-[w0½“µZ#»~ÁˆÙ™‘ªÂ|™®YSåó“Õì°G¡4+ø>©~)¾RŠíÈMã;ÓŞ¤Ş~ï¨f½"“8z$sFZ™Ë³ï­»*™Å/v™]’Ç‘ åf0©¡÷Ñ¾Ïp \|¸éeŞLw»ğQÊ[”%§t1OªĞ¯Ns¡‡UŸtÇ~hõ-c˜BŞ+Ê`®)tØÔÌ?ƒ¦Q|äëS: ‚C¿ôÖÄx8÷8ôÎòôŞ=¤g„¡­ê¯yİ)ÛhhçèŞÛR~î¸Ñ•®*OZãK­>w™¡“¨Cİî8ãÑ;dSç2Mœ¤è·Û ùAr½Î9ª°8íc‰-6‡3ÕO“÷!ÜWˆªä›f`#÷û¹†vz3zÅ¢Z™Mál¥”%‰ŒxB‚š¢ğ$FÑ¥²	 JT£={ßäi;jU—>«ìÌ>¢ÍŞßµÎ¾”‡ÒìYEw¹9œR?ãÏ²;í•Wvbÿä&¾+GOLĞ6ŸÒ»zÿŞENìSúÁèî˜û±Ÿ}^¬Ó"¹âc	Bå½¶Ú§O±ã(äËB½ë4y7•\©Õ¥­†&ÒÅó‚À>¹Á£¡äù¯ÚÙõú]QıpfÒö]W¶…iªÜ~{ÌàĞUˆçãD}%ùCùFPêkFŠYÛO§ƒI?ç:
x FŒjŒD;J£OdW8{r2ŞG²Y¥J˜°ùÑË§úŞ¼(ÃQÓ ‡p)¹öoº=İâËwìè–KC¹±¼T:*Ö*Çhm¾­|vïE*N'¿r@È¾¼ì»«$áqêÔØæîTò­•5)pŞÜ«ÎVc¦ÇtÜ‰:í·jœæ£T·é4q‘©	}D;oIG#m £°èu}ê*M9y“÷ón_ªÏÚàÂV$öYqvG‘ææŞKG‡œn	„?j:‚Ü>³*¿^¹}Ï5=tÖ=¥½H>^ß‚öÃ<ew§Ê¬cµçÔ@L•é0#<ê£Ì7ùjïCEON*}ºÅ}‚^DJâ¼ñ…áƒè‹ä¤Ùy	ufç\˜ªei¢î—îŠ2!Øûß9®9Áa_¦[ÕîS÷Ø®sšáQËU3¤÷ëWû/AúwOh8ÅRjÜÜÜ5Z¨-G9YÖ±qòXøûŞŠmS9aµâóIWİã25}G›7öÁ®ênbæ]Ÿ™¹Z%Rñr&oÈÃ‘EhİÃúP	í
Ÿv8RY\Òî¤à>è²ÉF€G˜˜iPŞ·ÛÙö¢8õ9%üíëyêİò[ú:La~Ü—hèÎÈ–»¡îênÑìì–à¸; dz4¿Ìôèë×¦—ëƒË#Ow£›½Õ^§~;hÊî6 t©ïøA¢îéÒÍéjü‹ 	‡ŞîWNäOm/¾;gs0bÌŞ•İ‚wïS…ÖjÉícp«Ñ¥˜%ˆøÑ½{Ôù ŠÚm
!ª5Bİ{¬}
l:ÅLİfcû,UcC:[º¼À^º…w«rAòEp½¨j	ë±ŞGVæíÇÈn³·¼·¹ls†WV,-ƒØGY¨”ÈOY~ä‚M:Ùê­f&'ù˜¢©üeR¦«îaˆäbU„_Å°d³foÊâ‘)'¸SS ˆ*­9Âå¯í5²«uËú\R($ê/Éğª IQB’Òåç°âÕôyğB—ùŒ·`ã‡÷Å¨²w&…tgç›•m/K=6˜Z‰vIµ7Ê·º£'[Ê‹'".Ú°W˜~vÔgF$^ÙFÖüÖH¶.€vgjªa„Ï“jj~ÇÜ¥ç¶'«I´¹Æú±-\ªÌÑ#àÉ)¢ÕôÚ½©Z¶ğ„„Ô„8É_VŒHg±Û·—ÇÎiÿÉ³»£JŸòš³|–/«JÙ30‡:äop-üÀ±'‘¨_œ2[Äù„—è@IW"ö’
É@W"+œiÎşŠÇËƒ6 R|™ıy~*kÚhjÌø	íŸn«y›†„'÷—rÚ•Îù(ı|÷0•?	Ä{Ú/òyO,ÊhR›¸o7e¹¥€ÍÈ¡ôo"µcPÛƒ‰!ñ­ÒÓwåİP±×¹,‘/›´,âè åGBI»Ñûº‹Jƒø
C’¿!cŒÎOƒ<ÙãÔã;S&^SÁ+½_¿IëĞ-­©}))¥Å÷5ïWÔ'÷Kµ€]*!ë,åUÔEùŞs|«uì•-ÌáFZ¦ÃN„$Í+lu·x—f—¥¹Şx€&sh´Ø/’¬;ìöøû5ÆµvÁevnàâøte WäJIå03µ¬ZAĞ”Æ§£Óún{v÷¾ï¹¶~jÅnúèÕ~èÁ)Ç8ƒ &ÓÔFgawƒc‡"ïEö™&!óö·øÙ“½ĞJô¸Õº	•¤|—5Ê^÷LúxAß;öSlğ0ıhÜÚ—mD“Èñú›-ºÈ~¯îøñŞîggÁİ­^},‡wf¸îqŒ&®H{m~À¢C4:Q¢ô>½&zR€*²·Úe´K`ÆìqÀ¤£‚m#t¤¤¶Ï@•CEäKß»j"
ÛÂİÈWÄ‚²ç¶¸©Ú|T}c»S=£Âm7MŠ7)Èëâ«Ä+1S‡?½wˆ›¦­1xD÷TærågÓÏİçÏ^pz2bã"9øğÃÙ‡tŒm_Ç"ú/İ0Û“Ÿ!VY·9<«–Cjj_ÀI/ã«·,`;ş€ß0#ÈÖÄ¾)'“È‘€IÊ‰•IpŸï@?Ç¾)Ç6ÆÂJ$ŞÇé_cß€×Èª/XÀ××ì¿Ÿko¥(@ikd­|ÓßWwöõ~­kÿ°¿ùÀÖ_àÇƒhş¢~²=@ ?€/³pÿö`üø~ÿ-qGîÎ}§ÿ¾ƒYÊòïõŸßüfÑ_Ğü-éı‡{ûôßrM­q¾|×
€ß,¿ÿ–£¾¢ğ£ğó£X|ü{ãt ğ% ïæ‡€¾Y8C}şÉ×ûµür<¾fßÜøÉõàkı¬¿¯rxqıµ÷ jìÁ ş{ì›¥*Şƒ .Àø7 ÷àØÔÆ«ƒ:®«/ğn îÀÀù‚½mÕ^dåDë-0lŞ`Ø7 ß`ç l›æ%.NÉùƒ –dİæğVğt>`ã¾Möh	•[àè´`Ÿ«=UÛ2¨î²:¨5ZÔ}‚ğûñå"øX©e>¾Ş«óoİ.ˆ0.+Eğ± ÂßM~CÿAkı¿éÿ´ÿ·t|¬ÁÇJÖ?DX?VÁÇJ|¬aıøC„õcı¦>–ÿßt€yì!^.ÿÇÃY+Ûä÷ìå{‰¿§µî\¦ßpı 7 ÕØ¯P~ F°¯·‡‹néq `Ÿ1PìAş‘~ïõcëËq<œ5ê7ì`q”ÜŞaÜw\ “ n=¸€`K·?Ôo9?pûÌş] ‹Ÿáúc|¬ÁÇJıÆë@uÁİÒ‚ÿ¼f®? 6P\w¬•{ó{¯k½Fı‹úMûûà?ç0€y0p@8Îšõ[çí·>Ÿ ×'8Î_Ôo¼~ œàs+À›À1p áØJ8ÎZÙŒ„ëUDğ±R+õôAàŞ€	>¾ÁÇJ|¬ÔÈÇ…{³–ıØŠ:Ò
Ã>?ˆYlçïroª««;îÖ3®tA?âŞ<\úÛ^Yì¡@²È¢ ‘6AĞH+H‹pn‚ø/qoÖ2ödÉ.Òû†=¿ËÀÅüœ\[ÀkÚÂÕô+8ˆƒ«sopå¿š{ƒz¸ÈË Æk¹¾ÅéÀÅ¯ÓÁ…«·¼¾ÕR}\;¿šÓ¼®!ln¬Ãö`&YÓ<âWeË¹7È…±³Ç¤-Èûƒq¬ £8€û@ù¯àŞ¬=ŸÊ<œ¥4¿Y™¸˜"Ÿpmı[ù„YÊ›…	h)Ÿpå—{ƒ:»ÄiZÒ7ói)½²ú·ói)~ùÄ«·¼¾ÕR}\;¿:Ÿ±ÇGìgÁ{ìúF>ùğ½|’Ä)vô,±cy´È»æ`È©õKm åkÍ% `òã\Z=şşuÉ÷r	wökbğı¼äûEüRR*ÈğÁ¿¡|õ'ÿF]Zõ¸*bTö|µB—ï’–%‰®Y£·hÂqVmıµ6m9úNR7ĞY—C®¼ò§©\úpŠ¡s&#·)z·xC0§©óû,Íl›ÚşÛ9ú_Š&Z¤‘8=ó»îb‘Ä|Ì\¶j6U6ÙÚÕ=Ã%éÎ[q§›Í7ZOÙ{qWd´Jz=›KGT$·Ñ­Qû`şİ›S#ÏßG«°‰Ÿ|Ü¦  ¢7ç<öd ;CÍö³8ê¹8™³œâûüÈ‰éÛŞNîîC½.¥u™jo?”X–ì~g¦"(¸A›p¼g-‰Ñ×i½önê}3© ßÜ;{ÑÏªğ±ñç@Ä­IM¯KÎÄŸ*pñ’¬Œk@I^13‚GœV¡f½êYåq‡¢Çj°6Ü“•Ô,r²€şÑ¡ôİä”´©×6ŞôPK23êç\g<G^A>™“«1¹_yGqG}k H”‘r\p Àßp[d—º<woĞˆH‰ïi“™g¥€š2	\¼Tí§myŠ£áä}ÑĞ‡¡'êl5Òˆ{'Ñ²ròâ’uŸWá;03IÙ:h-À‰$s¬÷>ZÄ` ›Û”íVWjú‰¥±
÷ì-}y4McŸ»³½ÄI¹’¹äİÛãàcçİÉ†ª‡”7Aøíï1xÕ¯êõ £ª²â"ø:=d»®3À³Á~§¹UNnšw	ğÕâ{ûúcÑtD°°~6_WWGïjYA›àx—ï5w--›öqŞ;\ïs]„Ï9è++§¹„Ûğ”|…Ş´}¥.Œ„1ûCe@¨ÓÜñG@$† °¾§/!‚á•ZFŒFBgÌâ‘Iü%àà—Ji§2å0’OB¤u@h˜œÓH¸½şÔìÆ(ÿöÃ›QÒ{y(Şœ=íÌÉ£HIƒÄgâŒy0©ÄÉ¨D©®›¢rÈMÇáBŞ9oÃò;ó~±×,e³EtÂ²„2xòÅLA"	 ×á¹Ñ2]-pÒıŠîë™îöiP¨š"Ñs>CWİÚ`ü!bññ.S…\4(Úº³¤]‰»´éĞY7|ë‘b5OªN³‚}½$G’ÄŠyĞyNç;)ßqğIQ¾Cl:Ü Z#6OQ:ö/ßx!ÕÃ|*ö`q^æ™>ÏK0G’ºkÉ{Ïõqw;E0©5œ~G°îfbmªë…^Co|é T¨¶N=Íht¼q£œË2m9òİí.,Ó´Gd†œ‚H¹Î¯Şøê¢ç¡ÃA6ª;Ì?KKpN„ßçªA¨$Éü^^òDøÌL2q°p
š?VwŞI'zJxyĞITG§Ñî@É7Ï‰!;Œ]êÖ¥Wu’éÙ¶ŒvˆPfrJRİï/İß|Ø%~
!OÉ¹+á8\ZXI¥½’ÁÈkĞâØ)’ÒÂ²;GàLİ7n	²'Á8™»Ğ ¤÷k’ì¤¥j£Ò×¦r?ùn~zkÍx3¥l¯ö6h¿X³ü#¸’İ©JaDœ3 ı¢Uñİ3ÖS»¢nYjs"«'GÚ^\§kF²|–t¿CÙ¬!±mßKPó:ö@ß›£¶{Ÿ%Ø¢mI="·¾h‘ËÓ%9é ÙÚ‚é$Dò(j7Y;!¯|ÈÙÓ;–Óu¨fbnÖF\¿†|òœşP×ÍĞËk;ÛfôeG;ÕœL°ŠàùÔÔî}Ïê&è
Ô°ìqÆ×-1)bWˆ!6E*b·†Ò53ÑîË‚ÆVì6AÒBF¦­ryîm7Í?"œyj‡òü~^ÅŞfÙ„¹4•cªQâN:ÁĞq‡d¶•Ïˆ#Ó6¨É¦aä¼{ˆóm‡¶z`ÆÂI”˜Ö©«·½q‹=¬»sf”£öÃWÑj'èvu:({ºWc¬‡ÅmÒƒ*Aêì‚ğ8æä¾>læd·i	7âHğ)/I“a;{2ÏÉ'#ÌQÛi¦¯4uj~—zÚëøõz4’”ÈÓ6F¡‰-ïf™DÌà°FµA±¦^$G(A‰¯)ıJíGE£¸ë5è,}*•mW·ıb¤úE] sàSHVñè`Ë4Õ¦ê<*K¥mñ{¸ùT
+"QÒişe&jÜc<snAøÑñ ½ôTZ£ÊzÎ}ëí]©YŠJŒığjXD•û:L²èõÄ(¼¼‰şºS<S½í<D•)^œ«)ìŠ5†¿ÔÚ &Ë¦K›¥I2‰Já}¢)İÀ•:h"ÙûÀu’ªôBôPH›aÇ£Ø”=9oQY§¨õ©İ»w“Ş“zÃäÎÆ~}.x}e—$4eèùkÕ\%.è-Q4ÑFL’“tûÃ;Ì5ŒëïUgˆÕ³BÊ3€ü°¯í¹”ğ‘]Nò'1ÄVÌvÅ,–¾%R.ÛÎ…}6Ãvúdı¹æâ‰1ª3£Ö”½Eq9ˆhíõ½ÊébnºÌtC¢h'b
e[o¤9éˆw38Vÿ¨ı™²Z#¬íöï=‰÷Û«ìFPÖxHºÜ‡«Òoõ'£W6I#O–®æ^OÙµ¯fl¿F^WêdŸùuò:¾ğZ^®Wuf6Ùşé]^võ0íQåe¢9¾ŸÊŸ¸k$5È}XKè|’¶C}oí¿ZàÂ	1CîRÔ“£á?fıÙ„‰‰bwVy.Lî8ÎlºÿTİi	Ñ‰“¾çÁDŠ<”ïN0ìFD¤´¢¹¼ÊÜ(ûâ:s¹{
»éÙÁT/‰^•õyw°Ğ‚[?y;ít…gQØ®¯5Sn‘qƒ`ŞïG¶J•–`e_n·¾Vƒ®®;pì"œìp©3‘»5GÌùN-™‰¶uErÏÜ°Ç6¥è½³mñ£<n"¸ßiÏÈ›±ÕOñĞ†m%`@30F_òzÉ‰„¨I‚PÙV=nÙÉ€6ŠÇİå§$gg‰¦ˆH…ÚdÉ>ÈÑ,½Ï‚<`òì åşø´y¸A,Ç]p™ğ­D§ÛdõweÇæ>ûä×p@)r’©½ ¦3Ÿb{°‘*ÄOët}8uE¹kğĞ°Ò(8¯l’åzS:M-RÂ#Îkò@È‹A»4çÆÆ/´Óªa¾ŸÊ,Kå3‚¢F¤y)GŠ™>öîááE†jº÷q°×ÀâÓ_¼PmÜaşX*’Œt{vıTõûÃ-üÇ‹Lûm¡Ô²Ÿ¡QïëŞïÏ¼ò¶ÖN„Âş‹ş:ù®{á‚’™b4‡Ëß«ôªÌÊlÃ¦÷†»g)‘$ôpÄu4.ë¦ DZÕ*|G‘Á:JÀ‘çèxU©ÑsË@—Lr"ŸÖ”÷-ŸÓ>[š—¹¤'xU>gk¢É+3¼—7±¿ë<ÿºûIã6—@RC²oîÌÒ—W(%K•|:QûE+Û×Åğ²ÅxX€IÛ™íÑœ}ÃÛ¬MgÙGmí›¸÷uå­«j$A•¦l6aš8Kcû$¿E¼tp§¡ŸòsŞ(b6)>AoCå¹³²ù½#7JŸD³^ULwÉî­í’:–N¹4È¿„<xçdÿ|$Æœ\M{Lš’’R„AIq&=[¬ªŞÉö!pù¼Œ[CºFn3‘‰3Q9qîó¹èç¹5ÎD‹Ì€J¢?ïãô¯qkè‡ø…·0xEŸªxe(O·e‡Bãa8ñãn0}UBB0ãÇip,ûŞW6‚÷½2öÓ¹ØBÇ-
T¼JêëçÅê~Š¡?®?³?á‡À+CbãP+‹P°[øqY,øíİlÂó‡àÇQãÇaº0øqe¼2R|èdü8şó¢\ğã	˜Å?
¿%,È??.2m)ô'&2?Î°³è…ÃÖ`§ãCü¸¼²êË¾_’á£¥8¬;¿%H5ü8PÅRÜ2É ñãÚ*qş8kQÀCÕ`ğÊ`Røq7W‰ëŞ×÷ ?Nƒ?óGÿıÁ­‰Ü¹Êó:/æÇò/ Ú¶¯Ò/ Å¼\Î­1Ü²J{\Kùû“[3C§A_´èo[³p†’¡[åyåğ×Ä*q}¼2Ì*Ï‹ÄC±¬2¾Ø¸¯¹5{ØW™Wı¼²UÆã~\7~w~œÿ*ó =Œ‡’– Şƒ(–¸5k}z†=`à¿Ç­YøÅ’ğ¸5ç¹5 ‡àË<‰>úrşüÏf9·¦%Fw[pj¹5ê 7ØóºËú,€[ó¥äà»¦:Tô2\oG°m vÀÂx6 Ëf€mçŠî·`æÔaë?ÁÆ|›ıê÷_Ğ—ÿ|¬Ô2œÿ£ÛÆe¥>´wBè•úú ì||-‚•"øX)Âú±R+Eğ±R+EX?VŠàc¥ş†`<qü	vğ"³¾tÇ£XñÙu-ú9.ƒ[ƒÓo¼~ ì@ÀîW`0p/î˜6 «Ç7Z‹ëÇ*ú} saëÒ9nN»ì½ä8Š°®ü%Æe¥~ãõÇ.úZ {âïˆ°~¬"‚•"øX©ßxıÀñk€õ`ÔàøWÀ‹×§@pò5{ñ["ğkVÑoÚ´àÅy ° -ç× ×© ÃÀ®®]×¬ß:o	üšåÂñkpŸqqü·†À¯ùDğ±R+õôAà×€	>¾ÁÇJ|¬ÔÈÇ‰_ó£ıÔÀ>ñÄ\?Ü'´Cà×|Ÿ_ü/À¯)'Âñk&vÒH¿áà|bç_ó£±¸Î;·ÿ_ÄüSü -à5máê ú%üš%®ÄÂñk–ñ&ÚûEü„ã"÷¯åúo¿Ş/®ŞòúüKõqí`ÄVçmàÊÿ)~'Ñ"¿&‚è÷å×àçÁ_Ï§l®Òrãğïæ.æŸÈ'\[ÿZ>}ƒ_ó-ÔZù5˜·‹¼%œ¾•O¸8ôÊêßÌ'\üòi®ŞòúYKõqí |ƒ_³Tş³ùd…=F°<[‰	;éßÈ' ¾•OÚØsĞ	vM±c˜u ÅÜÁåÖšsˆ
ÛßT?Î¡Õçşß¿ù^áÎ~M¾Pû/âÖ2`Bù?àÖ¬óù“[C§E[U~rïÊ¦:=9Ve^Ü”îf§ÍÌëdœQh\j$‰|ğì[èOp¥ÑsãI±¢%Ñ»'ZúÚ®”)~Ş<âió¹ Éş9ûÚ*Öt‰H8”ÒG2ñÙvfI/DÔ3îQûŞĞ éìì–dØ•y/¨6C(¸µ pDõUcq‘¶ø+ÈÆè3/?†çœ <2_~ùê±YËNµÜÂWYGtGS_íëxİ,z>¾­V@Ç÷½¦fÏÙ-émıGÆv÷ì˜éõéÎUĞ^oğ9d®Fê¼|™¸:Ø›A²¦)wFœ,yœ+ix.¼R]»y ZLr©ï`Ñ”kæ='öÌÚÄ€2K‡¾))3.aË©±nÏñn¡9_°‡×Óp8¿ÖÍ«1Ecï¥]’ïÔ`Ü{è›{v€Œ?ÛŸj¯Ê¥”òÖ“zÎÙ(’D¿Y2ÌŞ‚¼»¶ĞÒ…XöX½=Y”ÓjÒŠYÊôz~2¹ûŸïö¾xªs:{ËÓ½ô»6˜@k1W—”¸rŸHy©i‡k’³;¯îzw«(²ïf›&…×x($ÈCjKf­Âª£!ü	Q–àN­‚CádŸÆ”?¾=È
İ«wâÌS˜¹ûÈ§ñîÔOÑÓ•ã‘-O
)‘UğÔhKk›3[‘aÏWŒÙ‚ªØ9k²“Êóè¿x-&+~é}ş>KŒ`·øy­y™cÍ$B3×Ÿ•–ÙŒ± ]'Í:yP†d„’ÂPÒO¤„W6(Çººïl1,9¬_³‹çö)·s“1lóóïšØ^GÔnFÁUô"»ïµãb‘CÑTÎœà„ø¢w…½ŒA`¹)7MP»C4Ğ¾©ƒßê’*¹jìIrQtxRX|Ò£`êz€^á[ñ\X;©‡G´ÎYÆqÖ&S¸õ<z8Óû*Ù£œœ[÷³RŞ&
ë¾é’"
AH3ÕªXŞfllÒ¸²(£b!?/Šşp§çÅ²mi(QmåÏÃLp«á9:F?c+1å¬])Ä[hN¸W™ï÷¹—åïËI[O²/'[+ÿÈÍ«Çéï7Lìññœ™³šÈ5ĞwõP’A)}‘÷ºî­hªõÍçznT(Ñ{ÀšÒÓõ~wT›|w±·°óáÍÆõò–Šdl4Hjr˜öMZy+A++E=±æÆN;ë º|ë//œX”ŠöbÜÄ3ìÌæ/míÉùpfnæ£Ø4G'Cãu¤ÙæÈşŒ®––PI–²ğ /«A»M4=¬Ÿ2I@õÖd²Â(ØÆ)fƒÑ)º•\;6¢ğ.5³í\œĞ>Ûu—üË;õ67%†(ÍZBtÎñ ´ïuBc%¬§ƒşƒ`íd1ËÉÉšé×AÖPj5«Å±+E%ö¬‡êÏlÛ{¦´:| â/ô:´î™yfDÅ'ñ~ÙömcfdnKÓÄÄö}ÇfİóÛ÷Ç‡Š'F;ì¥.=ŠéèEx—_÷²ïu”béßúÎ#±Ô”‹±'EI²V²¾h¬C’÷m¢fïM¨K4´?âgŞ[-±õjİÔˆİâşU„@Ğ'çŠƒz3µ½ñ;7#…ú:g¶öR±{øÚîcÎ§ìªšá
Vo\I€cµi¸«ÓbÓ…ål¯}AòcvÄ-IæÒa	¶-Ò1’° NóÉs¶ûn	ƒÖ½?é/TĞCzEš¹Æğ×ö>ı¢³ñzë]Ù”ö6n®Ü=ö"çXƒùİ§°^]gî«˜£¬º‚{ƒîØèŸ/8¯#[…p.¡‘[ÈlÓËà°³
u:¢*ge›mÅ›Î}†q4Ñ!½è‘Ş6”pIaR¨¯yÉ66u›[ši³‚™È)ô€XÑà`s¸Æê¬ãÉOe-v¿Ğ"
d‡æÚAˆ¿ÌTR¿xp÷3fÆ›×àu™Ó‘ÁSsèêÛ6w«¶´ÄR3œˆ¦³Ëd	?±¡ôíÍ3ÙÏù÷;N–qY—TñJâyñÄ ûşğÛÔBO¬w|ğƒ™ïÉ.bÜœ| –˜)Öê•WûíùûP‰“
“
PCF—Ê”zPßÙXE—éÈ½}
.róëëw¹HtMò½µQtñ f§	Jç	1}çydŸ)ŠCä¿K"ñ¸Ûó	ÈÃg6Ã¿Ã=œú”ÑMÕ®P u»ğ1gñ(
êGOaˆÎ<Ô|‚ÉMÏÁ`D6Ò¸¦çædXkò/ÏôXâ /JJ²Åiûv»aÚ8ë$%ôƒ™TöØXA´?§Edï¼İ»ƒI…â­™rö¹e²µ¯gànV^ş q¥“Ûw{wm?5EÍ³·Dt¢¿ÑSL‘ÏFMæäÇZ}Á2É‹†Çtµ¸)¶Ó¶I·Hì{fİ“&oba]ÏÂ¸i£0¿WÙŞz$™PML—Î¼õ#	TFŒ„9~×cL,ÛÒô0$q Áù	Ú1ÙffwOò¸¡ª~ğĞ:°Œ}òYiÿ$.½Bq§zpÊn·}İÄ
(˜N›zÜ­ÖõªÛs_9˜„úšyNç±ÇÊê‰\Ùğ¢9èƒšb	wôİGÉ¤£2<m#=ÖLŠ1õ#ªc˜vÔ°ÚXµğíÇš{µ]Ú ½÷„·)ó|iç+-nñÖËé–7Rß=’{GQ^z7Ş‡'‰Ê	üğ${×'RîZğ–O¶QO©2­½=O“€ZP½aw×=Nk`M¢D?+‚“”õĞ[:Ä‹™|^õ‘ë™}¡“
<DıÒîiôø¥æ°{E“Èaƒİ£¶O^knz”Ä	M´üs¦'Æù#•Á2ğtÔ¶5Ä†N4E7tmğB9¦”¥Ì²†‡>~™;ëuå‹[_mOÖh´¥ˆòÿ±w&ğP?ÿßÃ²\•Ö•„’ce]µt8*ä*W„¡ÜGˆ¢œ]¤rD*W‰Šr_©\ÉM®JI’äoğù~m%ê[ßßÿ¾<>»ŸÏìÌôÚ™yÏgv™gãçŞŸ»Ğ¥#+Í6®ï¿,•¿âvş°èõĞ6•£½Yœå}LK¢<û{×,‘u»±öfclEK–Z¼òÍ¥î2;=,•¥é¼G¾pIypÜüüÛö>é=î}ydÎ¨\KÓ±ä¶qkó÷şÖÄÔR’§%HÈ?óÚO¾6îï9‚Û|¡mÖÀ!Fõ«WARåÊ´ªÔ4µYY%š'c%‰#JGæ!‰ˆ Ïú°ÎXIGNíoGı}éÿ/c…læ±ôŸc¬Lt,ôåÆŒ4Jûc…Ğ-&“~ÌX™ñ)ÿ‡Œ²¿ııÆ
ĞÔÉÂd¬ÀæÇXÍhÁ“±2Q›»¯;8#0V€~c¥‡ççîA©ü×+3ÎÁ=°U ÓpVêƒp“Œ•ò(íIÎ
`  N
à¡@ÌÀYl•ŠiÎ
à§ ¾
`¯Ô]Ñä­ KYÀ¾I–
`§TQŸd¬ à¯ Ö
`»Ô\Ü	Ÿ¨sß@ş;íµDğ¯> ¿6„özü[Ï“"ô¾¸¯ÿWï?uı×ßrú_Ğa3œàãk|à‹à_„ù_ø"øÀÁ¾ó¾>ğõ}@Ÿ? ÏÆl³ä›Sÿ©~;uÀnİ_Ô"Ÿ?À^C°gìÄ„ö,>ÄTùı7æh7÷oÒ"oh/*Ø¯
-(r~Z„y_ÿáõÇÏòTëïˆà_øúÌ€ î3W02h¦°'ğæ£ÿæüñS”oµHÛƒ>µæ ûÓfrTÀø€¨!€£­Mæ¥E=>Àªü{­šåµ9´Hçˆ¡G<CPÌ'_æK„õÇwDğ/‚|-@
œàãk|à‹à_ÈÇBâ¨Ìµ¿ì[ÎÛî0ç¾eP£òc
ø;^ÀQGB•,	j¹«Rp€ó,‰…ÆQ™«ï?ââv›99* Ïïâ¨€ºÀ{uAe€ş÷Á]èû(ıOsTÜó§ø ¿fj6î”ÜA¨ÜÌòVÓå¡z°³pT ôßÅQyˆœâ¨”#/GåÛ8øùxòv‘3e¶ÿa<Ay~G<Auı[ññ‡&Ğ\¢ùrTÜ-§¸?f§é|Wğ‹ÏOÓùçOBP¹™å­¦ËCõ@óÆ×ñ4s>ù'ñd8qOğŠ‰ƒ~¢3Úg‰'³Å¨7Ñ‡†½Æ 0Pf¾qƒÈ@O5wÜ|¼ÿúäGqı™<ßú¹Èmö‡Ø)HbŠ	'¿ÄNÙ9ÉNY:TæˆŸf§,Ø)¥ôê¨ãO
ö‡äS¶êÓn×åjà‹ºi´ßóŒœ~‘ğc¤Y$çê¼'ä*HÃî•úzzë8Ö-}¾ç[tş™ºil‘d¡0GCUÕn…«]›Óm¾duk7°RCb>¶ÚëìŞÑ ƒØ;š’¢é·›X\ÿdd7”¼Ïçtìı»‡Éü8|PÇ(ÕMŸtæ÷ÜÙrÛ»SÜÖöw»gÉqóTµ–'©…KĞyÊÙT
ò
·10øäh”˜æĞhËoSmE´+yì~Ú‘Ç¾Eµjı´OdO<–jNtç½·'ÿõ‡+åår¾[
¬ÇZŸú)=¼Ÿbı,³à»éØéäWLJpöTÕÕ\Ş§+¦ÃÛd=“zÉµÉü'%cZŸŒ8.EWš-¿QqGCV›ò!$I«şÖõçw>^·'áØ"›9®éÓÿöX¢—`_{`è«áëc¥±½òG£ıõ®Õ–ÔzåŸ©×*P/òJß>Ê¯&ö)'í6ø©H0ËÕˆÈP~~,-ŞÜØ=?U±)ÒÖrõ)ñıoHîz©6rß?t_×Ë9ŠCa]JºmŒì¹ƒë­®õ"×#6‰Ä2béïìÉQ¼c	ºFñè­A‘øŞ/7U7¨Ô+–ñú8Õ NÔî[¯úÑväIGÁÕ8î‡YÖ,c‰ŞÑ?2ù¾¡ jiœA—(	qáµÒÀ:“ØnšÎúÜíZÈ5”«rÒ)Ÿ3U¤“-é1IÃzš¾DæAÔÒÜ|QDõf„¦†£óÖ/İÂâO÷©÷1œSç¾»úi;y•Ø}Ø±›Í;zÏ¾>ı‘KàG°OÓçS>»¾l/&/A“È½`¬´×TÜqÂ¦o£!=»l=öä67Œ¹àŞ`íÏİYt^Ò(×ø¼Ü±£ŸØœºeâÙ¶7”O1Ä)#š‰9tæÌ£jã&‡‘Ï	§˜/uU‰Ã¤1Ô]v·˜_ìXòNÿL0}æÕÁ,ÉqÊÃ¯ß46m•	+±ÉÄx×ÚŸ eÊVO†1$'&©¯0CÎŒkß°½îDÜ6€y”Şò¤kDKéÀºÆÑáÌ ıAQ]õÅT˜}U¥h|zŸ±UUİ¢ê«ÓY²A4KÙ+.Ç6©ìûù×Õ”é~™ˆa&ÿÃ2ôÙÜÔ:ğ6Ô‘kdØšˆº21™H£7·;ï5†œ{7 ’Z`HTÜïæ@QÈ(z8DßæSnRÙÓ²fm©­ÑËÃ‹N ÷çÚ4¹jKXÃnÊ¥ÚStyŒ¼Û&Y¼•%QÉlÏc- ;hÎ|Áz[t”Î°`×…tG[ÍŒÓ@ıayó<âö—c§ˆĞÙFa‚k,¹°iˆ>Ñ$’{bİc8U’Ø,İ3xÖ¹¯?1˜è.:Lo«°]yˆ«Àˆ:Æn9Nv8÷±·xL=åÖG¸%,V­ˆå[vG°½ƒ[rÀ¨ï>óµZ%È²×Ù-Î•!	y>³úÙrw6¯#ËÛ–á¢óÍ.²VŠã	8¶Tíj©ÇÍ®æ"^…Òó"|Ëx:F,Â©ÉP0‹î%Õ[rÎ¦gXÊ†™‹Z&"ˆU˜bV`ïy©Xf“Úïâ Õ‹IÉyÕ-ÜØ~aM™éŞÕ/½Í?DîÚáB¹÷ÑÖ“)B=W<\N–lP=D—¡’OWßäòZ„Ó£—¹¨–şùZØ²²cGÑ—l—ÜzvÙj•V¦^VÃS™Ì=ÖÚ?1”–”¦xë
Î˜ÇBm‹':ú®IÚ¡WG)›5?lJ(E­GÅênEÓÄúínûW4P*É{UA6´®R^ÌÚwØÙô\~kD(™L`Ï#œ¼>ÜÈV	åXâº³‘"¶¼›ù÷ií×,|z<=°{/êz/ÿu0}¿§ú)3oãÁví;Nä2ù¦U½Z†Í?ıe`åš]ÌœA1²¬‚:é~}-(ùrU/[Å@vNné“C/ÓëÔ†§›eô‘éyü”E“³ØkĞ¬•Ÿ™¬Åc}oz-û²núÚBq¤Èè†Ê\õ‚Zwßp’Ô8í¥pKº,|%ô,½~tí¦D
¹;›´ú½ù¨*N7ß9—ıÄËòœ#˜QáM7¥fÑv{µ„‹ÃgZ­ë¢í‰Õô·ñ(ÀİíIÍo£nŠÜÒŒO[¢¢q`µ®:]•mM~ôÃÇ½rïÌHÏbzŠYî¦å’h¨µhn	'zyóñé>'Áøå¶©:*¾*ºª¨W[­}¨àm¬^`–¬¤'qªéV¡ë«&ãè›Sfûî‹ ZX£·ßcM¿j*ÑBDûÑç#Òµ†ƒß&äù¬yKHË™´tZ¥İD<Â<LÂÉÒ¯Ğµ]†ÈGŸC6ÈÓ—ÃÑ	æ'‚IØi,a›*_õÙ
SÊ0Á{–k6i„¤½`NC®-Ó7Óvu	ñÿœfcZ4”ìaÆ¿ƒÔ(À±YÆ¹;«¿Z×èt¤¹L|›…ä…{ÎƒÕbî¤|ÛÄûÙ‡a]¯Ø>ÊW7àt\„ız­ßÁ¯³¾=cV‰ÜĞ‰åK{ZBÁl;ª“^³)®@‹‡ç=u\?Fú¤$Ã0=¬€F-- =============================================================================
/*
    CHAPTER 16
    Interpret the Concept of a Hierarchical Query
    Use it to answer different questions
    
    1. SELF_JOIN REVISITED
        A business relationship between two columns in one table can 
        be used to self-join
        
        PREVIOUS EXAMPLE
            customer#       Child ID      primary key
            referred        Parent ID     non primary key
      
    2. HIERARCHICAL relationships
        Family Tree
        Folder Structure
        Employees
        Army Chain of Command
        
    3. HIERARCHICAL QUERY is a specific type of self-join
        
        This business relationship is called hierarchal 
        It would populate a standard organiazational chart
            employee_id     Child ID       primary key
            managers_id     Parent ID     non primary key

    4. DIRECTIONS    
          Hierarchical queries have direction
            Top Down
            Bottom UP
          Dictated by where you place the special key word "prior"
    
    5. STARTING LOCATION
          Hierarchical needs a starting point given by a true/false question
          More than one tree can exist in the same table
    
    6. ADDITIONAL TECHNIQUES 
        Exclude a single node from a tree
        Exclude a whole branch from a tree
        
        SYS_CONNECT_BY_PATH
        CONNECT_BY_ROOT
        ORDER BY SIBLINGS VS. ORDER BY
  
Need to know how to 
    Start with one node and go top to bottom
    Start with one node and go bottom up
    Exclude a single node
    Exclude a whole branch
    
*/
-- -----------------------------------------------------------------------------
-- 1. SELF JOIN REVISITED
--    Write the self join that prints out the following 
--
--    Referred_By      Action         Customer_Referred 
--    LEILA	SMITH	    referred => 	   JENNIFER	SMITH
select *
from customers a, customers b;

-- old school technique
select a.firstname, a.lastname, 'referred => ' as Action, b.firstname, b.lastname
from customers a, customers b
where a.customer# = b.referred;

select a.firstname, a.lastname, 'referred => ' as Action, b.firstname, b.lastname
from customers a join customers b 
  on a.customer# = b.referred;
  
select a.firstname || ' ' || a.lastname as "Referred  By", 'referred => ' as Action,
        b.firstname|| ' ' ||b.lastname as Referred
from customers a join customers b 
  on a.customer# = b.referred;  

-- CUSTOMER         ACTION                REFERRED_BY
-- Jennifer Smith   Was referred by =>    Leila Smith
  
select  initcap(b.firstname || ' ' || b.lastname) as customer
      , 'was referred by => ' as Action
      , initcap(a.firstname|| ' ' ||a.lastname) as referred_by
from customers a join customers b 
  on a.customer# = b.referred;  






-- -----------------------------------------------------------------------------
-- 2. HIERARCHICAL RELATIONSHIPS
--  ----------------------------------------------------------------------------
--  Sometimes we think of the ROOT at the bottom (Say a Family Tree)
--
--  LEVEL 3 : GRANDPARENTS    Ted Sanders   Elizabeth Welks     Robert Bullen   Stephanie Roberts
--                                \             /                   \              /
--                                 \           /                     \            /
--  LEVEL 2 : PARENTS              Francis Sanders	                Isabella Bullen
--                                               \                  /
--                                                \                /                         
--  LEVEL 1 : SIBLINGS (Root)                        Sarah Sanders
--                                                   Sonya Sanders
--                                                   Henry Sanders
--
--
--  -----------------------------------------------------------------
--  Sometimes we think of the ROOT at the top (a folder tree on your laptop)
--  
--  LEVEL 1 :             MyDocumentsFolder
--                          /         \
--  LEVEL 2 :           WORK         SCHOOL
--                      /   \        /    \
--  LEVEL 3 :       PRJ1    PRJ2   SQL    PMGT
--
-- -----------------------------------------------------------------------------
-- 
-- IN SQL the ROOT IS ALWAYS THE TOP
-- 
--  LEVEL 1 :                  CEO
--                            /   \
--  LEVEL 2 :              VP1    VP2
--                        /  \       \
--  LEVEL 3 :          DIR1  DIR2     DIR3
--                     / \            / \ 
--  LEVEL 4 :     MGR_A  MGR_B    MGR_C  MGR_D
-- -----------------------------------------------------------------------------
-- Word document : Page

-- -----------------------------------------------------------------------------
-- 3. HIERARCHICAL QUERIES
--  ----------------------------------------------------------------------------
--    A. HIERARCHICAL QUERY is a specific type of self-join
--       First examine the data and answer 3 questions
       select * from employee_chart; 
--     a. Which two fields provide the relationship
--     b. Which of thoise two is the child column
--     c. Which of thoise two is the parent column

-- -----------------------------------------------------------------------------
--    B. First Example
--       Key Words
--          "Level"
--          "Start With" (use any condition you would use in the where clause)
--          "Connect by" Field1 =  "Prior" Field2
        select employee_id, title, reports_to, level
        from employee_chart
        start with employee_id = 1
        connect by reports_to = prior employee_id;

        select employee_id, title, reports_to, level
        from employee_chart
        start with employee_id = 9
        connect by prior reports_to =  employee_id;
 
-- -----------------------------------------------------------------------------
--    C. SECOND Example using some functions from Chapter 6
          select employee_id
                , lpad(' ',level*2) || title as title
                , reports_to
                , level
          from employee_chart
          start with employee_id = 1
          connect by prior employee_id = reports_to;

-- -----------------------------------------------------------------------------
-- 4. DIRECTIONS
--  ----------------------------------------------------------------------------
--       TOP DOWN 
--       connect by prior child_id = parent_id 
            select * from employee_chart;
            select    employee_id
                    , lpad(' ',level*2) || title as title
                    , reports_to, level
            from employee_chart
            start with employee_id = 1
            connect by reports_to = prior employee_id;

--  ----------------------------------------------------------------------------
--       BOTTOM UP
            select level, employee_id, lpad(' ',level*2) || title
            from employee_chart
            start with employee_id = 9
            connect by employee_id = prior reports_to;

-- -----------------------------------------------------------------------------
-- 5. STARTING LOCATION
--  ----------------------------------------------------------------------------
--  Hierarchical needs a starting point given by a true/false question
--  More than one tree can exist in the same table    
      select level, lpad(' ',level*2) || title
      from employee_chart
      start with title like '%VP'
      connect by employee_id = prior reports_to;
--  Add the level field above and run it again
select * from billy.army;

-- Return Major Einhorns command structure
-- Major Einhorn has id 34
-- add a lpad function that lpads spaces
select lpad(' ',level*2) || name as grunts
from billy.army
start with id = 34
connect by co = prior id;

-- Captain Wyon wants to transfer to 
-- Lubbock and transfers require everyones signature
-- up to the general grunt
-- list all of the signatures she needs 
-- (excluding her own)
select name
from billy.army
where name not like '%Wyon%'
start with name like '%Wyon%'
connect by id = prior co;

-- who is left on base after einhorn 
-- takes his people off base

select lpad(' ' ,level*2) || name
from billy.army
start with name like 'General%'
connect by prior id = co and id <> 34;


--  ----------------------------------------------------------------------------
--  You can return more than one tree from a table if they exists
      select * from distributors;
      -- How many trees exist if the root is REGIONAL?
      select  level
            , lpad(' ',level*2) || loc_type
            , location as location
      from distributors
      start with location in ('Salt Lake','Wichita')
      connect by prior id =  upline;

select level
     , lpad(' ', level*2) || name
from billy.army
-- start with name in ('Sargent Vancer', 'Captain Viano')
start with id in (27,7)
connect by prior id = co; 

insert into distributors values(9,'London',	'HQ', null);	
insert into distributors values(10,	'Wembly',	'Regional',	9);
insert into distributors values(11,	'Grays',	'Local',	10);
commit;      
      select * from distributors;
--  Add the level field above and run it again
-- -----------------------------------------------------------------------------
--  6. ADDITIONAL TECHNIQUES
--  ----------------------------------------------------------------------------
--  Exclude a single node from a tree
        select level, lpad(' ' ,level*2) || title as title
        from cruises.employee_chart
        where title <> 'VP'
        start with reports_to is null
        connect by prior employee_id = reports_to
        order by 2;
        
        select lpad(' ',level*2) || title
        from cruises.employee_chart
        start with reports_to is null
        connect by prior employee_id = reports_to
        order siblings by title;
       
--  ----------------------------------------------------------------------------
--  Exclude a whole branch from a tree
        select lpad(' ',level*2) || title as title
        from employee_chart
        start with title = 'CEO'
        connect by prior employee_id = reports_to
          and title <> 'SVP';
--  ----------------------------------------------------------------------------
--  SYS_CONNECT_BY_PATH
--  Shows the path 
      select  lpad(' ' ,level*2) || title as title
            , sys_connect_by_path(title,'\') as hierarchy
      from cruises.employee_chart
      start with reports_to is null
      connect by prior employee_id = reports_to;

--  CONNECT_BY_ROOT
--  Shows the root
      select    lpad(' ' ,level*2) || title as title
              , connect_by_root title as headperson
      from cruises.employee_chart
      start with employee_id = 1
      connect by prior employee_id =  reports_to;

--  BOTH
      select lpad(' ' ,level*2) || title as title
             , sys_connect_by_path(title,'/') as title2
             , connect_by_root title as headhoncho
      from cruises.employee_chart
      start with employee_id = 1
      connect by prior employee_id = reports_to;

--   ORDER BY VS. ORDER SIBLINGS by  
      select lpad(' ',level*2) || title  as  title_formatted
      from cruises.employee_chart
      start with title = 'CEO'
      connect by reports_to = prior employee_id
      order siblings by title;

select name
from billy.army
where level = 1
start with name like 'Major%'
connect by prior id = co;

select name
from billy.army
where name like 'Major%';

-- How many rows will this return
-- Is it Top Down / Bottom Up
select employee_id, lpad(' ',level*2) || title as title
from employee_chart
start with title = 'CEO'
connect by reports_to = prior employee_id;

--1. Return all of the SVP's Department
select level, lpad(' ' ,level*2)||title as title
from employee_chart
start with employee_id = 3
connect by prior employee_id = reports_to;









-- 2. Return all of Director 4's reporting chain except her manager
select level, lpad(' ' ,level*2) || title as title
from employee_chart
where employee_id <> 3
start with employee_id = 8
connect by prior reports_to = employee_id;





-- How many rows will this return
-- Top Down / Bottom Up
-- What will the sort do?
    select level, loc_type,location
    from distributors
    start with loc_type = 'HQ'
    connect by prior id = upline 
    order by location;

-- How many rows will this return
-- Top Down / Bottom Up
-- What will the sort do?
      select level, loc_type,location
      from distributors
      start with loc_type = 'HQ'
      connect by id = prior upline 
      order siblings by location;

-- How many roots (trees will this return)
      select level, lpad(' ',level*2) || location, loc_type
      from distributors
      start with loc_type = 'REGIONAL'
      connect by prior id = upline 
      order siblings by location;


-- Return all sargents and their reports
select * from billy.army;
select lpad(' ' ,level*2) || name
from billy.army
start with name like 'Sargent%'
connect by prior id = co;


-- Major Marko's command
-- without Sargent Vances soldiers
select lpad(' ',level*2) || name
from billy.army
start with name = 'Major Marko'
connect by prior id = co 
   and name <> 'Sargent Vancer';
 




-- return private Lietz chain of command 
-- ending at Captain Viano 

select lpad(' ',level*2) || name
from billy.army
start with name like '%Lietz'
connect by prior co = id 
        and not name like 'Captain Viano';


select level, lpad(' ',level*2) || name
from billy.army
start with name like '%Lietz'
connect by prior co = id 
        and level <= 
                    (select level
                      from billy.army
                      where name like '%Viano'
                      start with name like '%Lietz'
                      connect by prior co = id);
                      
                      
                      
select level, lpad(' ',level*2) || name
from billy.army
start with id = 21
connect by prior id = prior co;                      
                                                                                                                                                                                                                                                                                                                                                                                                                                                       =È‘ZÍ1®ÌuÑw³vçÕ/|tÒ÷ÄÙàJ,ç¨‹ŠÁyŞ–Òû«Üx”Ö)Ö…Éo)Ææ-§¿Õ‹~ƒ…ŞÈqá>;b-Ø?Rl*ãj
çq1;#(y¸rtI£n=¸NWæ­L!ìÎÅ¼eş<[ŠÂÿ]j±4„ù*”©ğ¨”Î™UõX¿eUw'›­ñÚşÖÒ§\‘^C0¨F¶°DÓsHêp€¨—çISóknp%z.„{n)ÃYp"$bw‹;¹1®!ëJß«üœÚmş¬Z?ì¹&†ÜşİÑÊU…Ô”ö,CqnytdÕ"¼õÜŞşk°Ôşˆ1ş\ú–‰TÁeÙŠ‘¤Md‰ª¿zÿ!EW–æ5‘®YÌ®!i¢ÏAì)Ì?²­eÈ™¼b1!Bø1Qäó†µè€ VjÄğa6Öz‡FÆóŠUæµÕ·Oa›6ğ…™>…qEº ’ÖEI¹Óöq0É‹¯ól¨Yo|–ÊÂ–[×ƒ½Œ5rkğ;{øøÁ–hèW“M7+«øi÷a¶­VLTPr¼ã‚õ&‘Ñ€ä1rç¿/Ÿb'Wi_Á\üfÄ™Ä¬5ò¹/ÂÃË{=jèì©İEåˆ=©1|¤¹ ¿Š$7[ã©r’ÌŠãzD3»?iGY‡;]‰‹9ÚĞ*EºNú<3/-	wSİ†7}zú¾=ğİÁúIcÏùB{Œ3FX?8èP Ô´åäÏäÊş ÔŸu/õ]ä.UÿƒËSv?·3Hv2…+¤’>heÂR½ñ‡+¡Ï‘ñ£¤xĞŒUùşôÔÚî§ –GÁ•Á±€*©jØV'ŠÛÆÒA(Ïıd
ÉdÕY¼Jã¯ø]JZÏ 7²¯bŒ<ÃÕpü2ó®ª¤¨ÈÎ¶Òñ"ŸÓ•0©[4ã¦ñä;?¥Ë‹ô]d6wéJJ2P ó.ÖìÜçÊ%³š_`­H¿<ÍDn”E¿3»‚ÉgcúÃô®1Fmm8hğdp³NÒ“GGE?™'FX\+IræYvßY²¾RUqœ³xjõé¬f©Écv†ÇŸZ
si¾íŞœÎw¬Åè$#PU¨·÷$ƒŠu­³§ÕÛ`Éş…ØÃ†$] ¯':‚KVĞ©Eåõ$Cg¸Ÿ _óx-Y^ûy=ˆÿ¯ğ/0„Eßeg´Ğöà¼…ò4ø}—'ôÚ7{˜ûÂ…¶—ƒç‡PáfÊ—O®~"8NóTÁ€—¯|˜éìE2çg8°n!ö-@˜//_³_‹ddÆ 0³®;ıòC‘Ìı!Ø÷¢Â5H5w(ø^$øÌÉ\¼ÀÃÁàTØ3ıò½êkÙ?Ö.0ş-´½käõĞ.ğ>~Âëñšåõ,ô¹ô —X@ş™÷~…×ŞÇk.^àï|ÆÇã`í4 §¹=€©Ø:€ãSi8Íåy~UšÙ3ÃîÙ©Äå«pw ÷<ö Çğ}¦Ù=Qû>»puöO3 £°~ ççîggâ~Vc€äsÁâßÔ¿ÑBı†vÀ¡3ßtş·Ó:ğÃ‰ãB(¢„"ÚA¨ßĞây(ÑïE´ƒPD;EŒ„"ÚA(¢„"ÚA¨Eˆ¼óWù©ˆñc-q;À^hÀbŒt†µß#ôË;‚—tÀfxò÷ìñ—É#_µ„ã˜`4Ø	z ôHpèı5ŠÑ#~|O)Şò7´„û0À®pÀfÁóX¦÷%~£ïóóŠ×	µ„ã|¶X"®?æĞÄüzão‹8.„Z¢ñPGÀ>wpëÀaÁ—V¾xÇ|úoÄQh~™N3£%ÚßRi »Ì°6eœ-ëVÀJ åøºÒÎoñ Ğ#¿¨%?ğq0{€ğÜ|şWÙ=ÄõÇ"ÚA(¢„úí 2{ D;¾ÑBí ÔodÇïÄì™o_9Ø/¿Ú­Şıò ÿ±s&ğT5ÿ¿×–-KIdßB„Bö(BHö¬E²„kßÊ^–¢("{ÈY²¢”­(²eÿ:=ô =õ<ÿú½î§Æ™sÎÌÜï™™ïÌÜeŞ(fÏúÌtø³g1{t(º¨%iô·ƒ â:¿³ç{m?ü´VªÖíÍº¬(Í¯à@egeAy€şfÏ®ÈWAÌ5x#~³GÜn‰ûÚk¹Öâ@é7ÀY¬×oy#\_òCå@\•¿ñF–=ÿÏğFÀsE!oÜG†zd¨şÒ^ß
¼€Â7× Şˆ2ÚĞfük3‡Ñ.²z ·AùÁ>7p¿šß³ºü¸?ºÓ eJ9¸®?Ai~…?Aeıgş$¼:¿ºşOù=%_S_´–?AéâVf_ÓŸ ôğ'q(ßòü÷¾ä‡ÊX_ßúÓrØÏø“1l‰ßS_â÷´¯áO`~\ËŸ@9Gaö0¤'Aü+à7À¨úM2£Á÷ıfõşşÏ× ëùûwÒ¬´gètn2»ôzi`?Áì0ÿÿÀìÁ?1{êÌ)+‰+™*¯Ïøûšì?~£Št”:o¦+ã1=kAœv¬+!†W—Æ¾İ»2¶Né‹ˆ§>ÀÀ¾NFZF\œqÍhláˆM]­•}–ó‡;¸,µ
.j­jŸòOLª©@j<ÜÔ¯š8óxkİ¦ëÎã£V7k&‡>÷µÖœâdV¢~ó²··7üÓ&¸nøğD½ÎLY§Ë#'‡îIB=w‹”9®á"Ù³N;:õô†b¶:Âã¥±·ÍOÜ,xÉn>éì0øÒ[,Ï–Í~™K©üy¾¤ó§aöå©Íb‡L§•åöÂÏÏO×Ë²)ÕÏïsİCÎNÃáüiêÌn§Æô°¶üùÖ[ÂZ\Şèßn9õ9\‚HF„=kló~³ì‘óE§OKy_àw£±ĞÊ"bù8xs˜ç¢ğ9lblfµ ®2®Ñ‡u‰i!Eç2B„õ.ò2ED-Ô4ñù’ø-à|şìîv0?v¿¾ˆ*qòİëyòÎvaûË^7~-5'/K¸@MrQlßÓW™çß´<ããw‡b¸Ö¼ù›WS5«ı‡¼ÓZ•ç©î4j3öÿxÜH›¿¸ç:áXô‰@ÇYÆÇÂA"bT—õBœ%‹Ìß©3‹µãg®»Ôc/¬$ÈŠ¾Éş–ìÇ¢KGÅ[ø‚F.ˆò3FEÓgªÌ©“+q{çŒÆ…N‰„$x22Çæâ}‡‡}ú'·Q[w¹¾Ça.’@ù>4Ë±´´ı<İdïo9×a³9‚Å"ğØ%û¨×Eh¦%æy‡]¸ŠÓ.È‡»|œI˜}ép{>É•ÎIqËAíã>£¯.”Òš§œá¾rè"ÉçÄÄ8L…œ]‰¦n×oË*eÆSÂf’m¹É:¨+›†,öí|jS$ÏÃ×®Šã@dË
½ğ²ê“¤6±ÛÒrdèá²h;Å~(ÅÂËÕIë£|¤qŠ‡‡ îIËå‰ÜÔç)îlÿ³¦bÔ.ıMuä”Õñ$ûßœ=9B!¢r@vàşÃ#-¼—B-ïô§òy¿y}¢³Øéóû…¹9>k½ÖwAò‚{u†&Ñ­‚etoõÓÜM¹f2èõéi2Z±~2‹;{Ú&~œgŠG?kéê›i½zk{N—Şæ°wv^Á‚@
–R²¬À=üÎ3¹|\Œ",SíyÓœ4Å
‚Še…Ÿ}É^£—W}ÇßSı.°ş˜öçIÌdŠ@“ñÚ©­Ã1efGò½}[üÀbºOZTĞŠ¿mHÂ>,‘ºä~kq_jƒÈ¹ÀÔÖ
Ì&©ü,¶ˆÒ²âwRo‹gZ9S“˜ÛFğà_ÌD¯ò!h1‚‡Q’ÀöT&Q÷¿b°IK5¯ë‹±bHİ/šoIpóµGÿ -¡ŒRıî9˜ÄLıLïÄªq‰ó^L§ÕRxwìW£Fc!CK	¬áÏVx¬±`{‘ÃÇùËœû:ËJÈÚ(5Ä]ÑÉ·ğ£q8XëÔéù«Zb·òûŞ;óÔÈûÕ’ñÑ»Oîï'%àÍ©jòf·æ)|Æ‘/fÚB8ıŠÛv?éÄã\ßÄÓ–dûh(”ŸOq¸?ÂÛaİåãÊUäıìî¤µ±»‘ñ€¾œ[/¿Y£®½#VÑ8L\bÁõİ”¤q–OÎè…±Å=~A}`ßÛ$wÂIj]Kv“ÛFï`²O¶ifÉkÎQÇÏçßÄd‘äÜ„¥dÈÉÅbÊ&îlV?x@Ê¾‰X§²ã*‡e€{©Ys ¯áø¾‹ƒõ÷‡¬JHQ²vöÊ}vªôòßÒ!Å+7ÀÇKxÃc!O,7ú¤æ†gÀa±şÒTşø¤¬-9§$)Î\Œ Æ,QP<ö<‘°­”¥EŞXÚA`Ğa*<Ş†: Õ1>ú°ƒU˜Ì±€–15¯Q®Âg	”5
4úúÖ¡äÑWİm¨Íå…1GÑ†[İbËa…I'Ş‰Ù;!^•H™ÓÏµİ¬l¥ûŞ¦sg\‹­ÈSJª;e9j«àÀ‘Z¹rå§³ıÇ5öˆ„3ˆVH§îa	.Wå:ÍÕ\3 ¤+HV×qÈ:m˜¶çI¿o…d«‰£—ÕsœB¸W¡¨õ9?A¡Ùæ.­Œf¦OfŠì”hèIo›6tô_…ó½÷áæ"¹XöùB]ıÓKV6icØ”X.*zè»úXâ°Ê‰Ê÷uæÒ{'6Ò«AQğtËæòHÊàC‚½J_¥*i¥45ã9*ç¤œ¨€“ĞkcíÄ*èÉÙ•úøÔ¦Íä²ïL¶ímycma©ê•›yõÕ[•¬p_Û(3]›7˜zC·Â{/µ½•š>Ÿt0–¯¦íøT2F¨æmÚ…$†â³"AæQ”Írl&Ş©ÇmbHÌà±…äÀîƒÊŒÙ¦tº	ÉgsõbõŞ¿l?bj(AGy;ù¢ymßeÕñd¾Â Sîé³	¾ãeSàÏóK9&Wëù*#ô©>¼›R)JX^	‹‰$ëq[äî­”ÅÆ¥¬‘$‘o`çÌä©›õt ¸6\v3Nh¾%d›äw6ú(ÏÄ©¡{Mü5v	§nzOğÖæqÎ\(Aÿ^³¸{èN–üòiívÁá*ìä•qÖ±†·£'	Gp_½´ÈÙÂ*Ö+h{’<ÎOÊhj$«HwLO]ı¶<Uc<{rHËüù¢ÆÇÙîé¨íb©­Ôü¤Îşjè³ßÑgÒèıgf©}·ôÌÎû3½mB§3¨Ô³ÂápÍ'÷:¾Ì+>Ú‡/ø¯¼’×5VİşR9\Púöqj+÷àCN§µè+F¥İ_·¸kú“œ§Öë±É/LWã·°>®'¡fÍy+W&[,PæÏ)ğÔ‹Æ‹l€a«,©r¡—pAK0O ‚SÏáp±ÃÈ‘Q»ò½RÓ']í}v’“ğÇç»Ñ¡%vÁnŸ¢u±¦–…{à’\da‘
s5Z`RÄÀ®ºoaŞ~{~†ÒÛ»éÍ«ÎG¢é"[?UëĞª	e"°"«`jø{*ÍËcz–òìš%}^¦ïÈßKİfQÇwºÁ}½¾»È’Ñ†Üí9Ó¶z|}U†-°°¶~=¯SdšümÒ;¥ÂÍcW_ILxC#‰4¬£éÁ»ı¹w-êôzÙ£+9>…ÑmÒJx*½MyŠHÕâ
Î»—AqÓXI[ãÅ¡OÃ°`Ú!eyÚ9ÓJÚNØP¦$àïv¤±ÛäàüÁçxÅô½NB8ÿ¶woô«+£G#üÙ
¢Ÿ†s±!ˆ‰Œ’üìzw%íAD8£‘]×d‰·®£_P÷ÙœA›GB°é²×|§£&ºÑŸœ:KÛfÄÇ'+ı±
Í§z“pãk9‚úqêâ}åû©ÚF§qÊü†‰ĞIÂF|oOİØıV$Á‘gÄ)ÇOŠÔ]CÕçã‡Šyƒ¨=¶ÕŸğ/ZS	Ÿ–>+lĞşPUGYém,< à’î³—ªE·ÎWğ½ÍéC¿¡ê#g­>L’ª¾Æœk6sª(º°9…"=ËÂ7ùpÙñ	OÖÅ­²!X¡Úã=jdïøƒ4Ä>>¡Q÷¼ıĞâ¨Y²^ùøÍs4¸Q6NÉT²ÚiÊyµô»ÇÓŸ’*6ºá‹ÉHÕ~ =ìCM?ZjÓ “Ùh<şävZ8vİİs”›±™.å4ß¸ïüx¡¦fİ÷‰Ö>:Â·3ÒÏ