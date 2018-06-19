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
Insert into POPULATION values (309,'C','GRAYSON','COUNTY-OTHER',PK     ! t6Z�z  �   [Content_Types].xml �(�                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 �T�N1����^[�`�a�zT�j;�ݶ�o�lAbB\�ٶ��Lg�?\7�XAB|%zeW�u0��+�1}�<�Iy�\�P��no��M,8�c%j��$%��e���dR���\F�j��}�:xOj1Ġ�3�tT��y{���zQ���Z�J��ՊX�\y�f3���l�Ę@��qeL����
y�3���Hw�J��°����?����vq���(�*ћjػ\;���3�Ey��������G��|e^zW����'t����\B�9A��q��N{=�\�fB\����}B�VN�j.�+'a�{��[z�BD�	��Ӣmt'2$��o�Cžg�s�chg�s�[�:�  �� PK     ! �U0#�   L   _rels/.rels �(�                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 ��MO�0��H�����ݐBKwAH�!T~�I����$ݿ'T�G�~����<���!��4��;#�w����qu*&r�Fq���v�����GJy(v��*����K��#F��D��.W	��=��Z�MY�b���BS���7��ϛז��?�9L�ҙ�sbgٮ|�l!��USh9i�b�r:"y_dl��D���|-N��R"4�2�G�%��Z�4�˝y�7	ë��ɂ���  �� PK     ! ���  ?   xl/_rels/workbook.xml.rels �(�                                                                                                                                                                                                                                                                 ���j�0E����Ѿq2}P�qf�R�m�~�p�8Lb[}��kR:���n�1H�����w��$gdI
��veck����#��hKl�%���W�Wj��`�>��b���o��P�!q=�8���c�k٣>bMr����5 ?��R�?�� �����k��j4=;�ё�2���D��&V�['��e�͚��B��X��͖�5��?C�ǩ�8Y��_Fc��6v�9��.r�j(z*����ϳ1o��ȳ��?   �� PK     ! Y�A  �     xl/workbook.xml�T�o�0~�����;�G�IQ�j�V�(��K_c�c3�,����;�l���i{�l������<�8�}e�p%�x1IU��6���3��X""�d	>2�/ҏf{�w�v �Ipem�����9Q��)�����޺�ь�b���<�̭	�x@��{0TYr���5�v �L雊7fD��{�j�wm�PU7 ���c�QM�ۭT�l�}��o�kN�2��' �I����\�JNg%�q����'uw��Hc��[V$��j�~;�ms�r^?��O)��$��9�0�C`tA	E]
˴$�͕������W�=���V�K�5���hKg�%4&�$�B�	������"������]�g���e��������䭢A;�]�.0$9��$#�u-�������ۢ����'��j�xa�^x����me<�DQ�+�~���"ً��Çi��m�/F:�з��#��Q"(�ݙ>0
"��`{gl:<��C�r❇���FN8=�ix8�pd�$[dW����� w<�]��6ׄ��MY��h�� ���vǿ�   �� PK     ! Q��S;  �     xl/sharedStrings.xmlt�[O�0��M�M�Gc��Ʃ��]���A��������@������/��8����Rxxn�qQ�M+�.���=F��ذN
����//\ �tW�����@��%�\��C=Sz9l	��6�p���8�}Kz�
�jy��7�r�灇g�8�w��]���̶�.Q�K~���yR�����1~�Њ+�؝�Q�Μ�!�Ыh��2��a�lh�a��q55d��w=3Nq�L�N�j�O�0.W�<x�y���tG�2c��ߓeHڰ̋*M��$������>�i���AN�*�"��ɉ�x�7   �� PK     ! ;m2K�   B  #   xl/worksheets/_rels/sheet1.xml.rels�����0E��Cx{�օCS7"�U�b��ۗ���{�e���p��6��<�f�,Ժ��ch��{�-�A�8��	-<�a�.��NNJ�ǐX��Q$��~�ٱ�	��>��I�y0���Ь�jm�_�/N��,�}W�:=RY��}<n���H�τI9�`>�H9�E��bA�w��k}�m����	  �� PK     ! ��nX�  �     xl/theme/theme1.xml�Yϋ7��?sw�kfl/�{lg��&!�䨵e����ɻ1!P�c�P��^
��P��%�k�MiSȿ�'��#��n�n -Y�2�����7ߓ4/ݍ�s�SNX�v�*����d�vo���p��1�,�mw��{i���.�-�;�?�[��FB̶�e>�f�/�N�ل�1p�N���ݘ�k�JP�I\'A1��6��v�Ҥ��4ާp�.F4ݗ���CaǇU����9B���8cv<�w��P�<h��疷/��Vމ�}�~����;�kj�tz���|/��+ �~��=@��4�����n�ϱ(����5z�������8w|�3�
������A^4�
��}�O��3�
��5|���y�@%�����p9�d����A��/P���CLX"6�Z��t  	�H�����dq�(9H��K�$�%�Cs�VT��_�<u�<��0�zK^���5I>�d&��`�� /�}������'��<����Ó?f���;(��_|�ٟ_�������㹎���O~��s;&[x����{���W����#���>$1��U|��`1�My�d���c!b�@ض��� ^] j�u��[)�xy~���sA,#_�b�����+r,���y2���u���lc�(1B۟�@Y��da��u���8���!Ɩ��&�������pn����%Cr`$R�i����� �����-�˨m�=|d"�@�B~�����h.Pl39D1���Dd#��HG:��Dz�)s�c̹�ϵ��
��=�{t��T�C��]Ę���0B��ʙ$����B�"�:6�3�yq@��p�"���BptU�T$�|2O-�����>.�a�2 ����$9S�O���NԳ�tZ�;)��Z;��|�?(�=4O�cxg��;�~����^�7���څP���u�v�7.�'��}��x���;��4@��V���j+7��2�(�i�T'e�#"���`�_U�)�MO�3cV��Ym��)�j�0���8۱V�rw��G�h���v�m�4�]�ʼ��N�nyI@��'$��Lu�Ʋ��w$��΅E�¢)�/C����@mX?9��j������
Q<�q��ѕ�9�Hor&�3 �("ݒ\7NO�.K�W��ABK7�����<;����u��AO�b�64�7k)"���&�R��9n�A݇ӱ���	���2�A�p��Et
�g#�f/��(�,墇x�9\�N�18u(�ۮ��*h�4Dq��@�Zr-�����2�L�H�a�Z���[P�L+�OU��˞l�ޏ�����7��ߨJ�	��j��1�͕��w�0岫)����E(�(��gp%�+:�n��.�38t݅SY`�u�=�TK�i�Y�LCUdմ��+�����2�V�^h]k�u���*qF�}���Q+3�I��2,5;o5���@�D��o�a���V~�w:ke�X�+U�O��	vpģ��s*�
%|{H,����L6��+�5"\9��{��5?,U�~��սJ��wꥎ�׫}�Z�uk����(���g��G�E��E��}���GnF,.3������0���0ѹ��z��Z�Π����R+��^6z�^�7[���s��^�zA�Y
�aX򂊤�l�^����f���ϗ10�L>r_�{��   �� PK     ! u��  v     xl/styles.xml�X�n�8}/�� �]�%�k��8��m�@����%�E��ݢ��C]l�q5u��E�Μ93~�pf=UQ)"�]��""�E���K�	�*�E��$B[R��_��Jo�]�-!���.g�S�+�qu!K"`&��c]U8U��*��3�wݱ�1��0��!��ui���X�%eTokY����c!��KP7�����D<�������sd�Ӕ<E9u�H��\
]Y�\�Km4���O$f
lW�a��z�F|��a*�T�f �gF�Yq�(ff(ǜ�m3X�r��Fm.a�ɅVZ�{rZ�5�
`S�vl�10��5M�H�c��m	�0C�Ӭ{au�����*�hfP׵3T��PR�\׈Y�TddC��G����~��u�n�Ӻj>�ϥT�.�|���CFr(Z��W���#����Ì�B
��ݎ�N8�p�#�Wp�X=d��h5Z_c��Z�;ă�7���5(K	c�Ƹ�o�nrK�y��Gp3�<sκ&�e�l8j:����Fv_��Wɵ6�N�Ϣ� ��-\�l;�#�$���h!81��X������~�M�Ja��:�7�5^�27OP|Y�%QI���XN���6�`���d��	�99>���s�����{���9�ܐNǿ�<�5�!����<��I�|��!y�R����`�?��\��\Fpw>����V9T2�V����@��7���&x�6�
(ez�ңjiW�X���/�jg=E�5e��#���6�ګ�}�y��U�N��H��L��&#�o&]s81��Ե��۟L��M)C6�S�*|����v3?]�$�=q�{tI{�v0��/��������/��7-ļ7�U^��5���P����1���>���U�vr�z�h�'�d|�I����h~$A{�:��x^� 7�����0*:_uꏂ����N�	g��A�?   �� PK     ! ]��X�       xl/worksheets/sheet1.xml�X[��F~OU��k�xEk��A�!�T6�gǕ:����ק���w_�?�����i���[u�^Hݔ����^��ȱ��������3��^���6?�#Y���.����ߛ=!��c������A�{R�M���,;ZW9���)hN5ɷ����IP��ї���ەIh�\�#�$59��o���lUq]��ߟO_
Z���<��]��^U̳�#�����-���UYԴ�;��@:z��Y0�iy�-a\v�&���m0����wB��K��X��ȁ�la�|�?J��"�Ma���o\���{�H�wN��k}��$|ڼ`�Y��W0���+<���F`���O����koKv���A_7�|�3pn:q�����4�L�p҂�~����2�o��Zn���^؟���H����������QL�c�8�8f��x4�>�1Tp5Q4��!)���H�+�O�kp��S�W�tW&�������)���O�����d(� Kr�/�j��A�}lN9�(��eD��f��j!]�׾�{+<�,���¶PƔ�.|�^	'琵2=�l���9 3	`�f��̧��߻���AKY9 h)��.Eh�JH(4��km�4#A%d �����)x:���O��Ιmt\p,�!<.���2ڱ"'W
3��21$<��XL�9q,���
W$�D�� �2i�/�D��c �Y'��:a�ce<��Ν^)H+�:1F&{�!ml���i�ej��,� W�,�j��ϱ2�2!�W
�M���dO9�2ic+Jl���C�Gg&l]��p�'7�±Z�d���.�˕��e'#��e��r��0�V
��6
"��p2 /2GG����uL]MA���n��hk��^)���ۉ�01#G"���T�j�f�qI�v�M8���Ν+�f�d��i~�d��L��jdlFVjdbFs�!�ȟ:mŋ��!�=d�r�J��Y�N��3@ǃ� ��\�������y_8�-�����j�dءL'�EhUkc�N�
2�'q����~��/����0h�+mb�´�(6�^a��h�T��m�ݥ����ˊΔ#!�x��L�9�"Xbm�v�j�9jq�$.����5��	�*�/ڛ�1�� �FA�������݂����2k{&EZX���
>�1���H\,h�{���"uRe����[sw� F_|�f��j��5nϓvmEha�����E���}ql$.�ѽ�H}�1UF�/�Kl�������Ud��� �H.�m~@���Zũ1F_�����W�/0UF�/zwm�W�0�i��� �خ�������za�y:Jz\�jL+0
�����]p��y��"�{,����í�P��!��^vQe��?�_���<6ށ�DWd�e۴߃{FO�W*Z��A�S?�sN��[��юR�����=�<Z��m����5������J�'�r�g|�y	��:ۆ��k����  �� PK     ! )�ezS  �   docProps/core.xml �(�                                                                                                                                                                                                                                                                 ��QK�0���C�{���MCہ�=96Q|��Vl��dv����V+}L�_�9$�d|���V9"Q�P\�Rms��^��(��)�*� GG�hV\_e��\x6��J��')Ky���s5���Hf#�P~��F2�f�k�?�p�,�1��-0�":!���T@pHP�b��u`��u�����t��g:���`�A�4MԤ����㪋���*2�)7��6�\+����4X�j�|�6z�ᑨ-�b�-}�����K����?
"��i�<yM��*��L�8	��:Nh<�$}o���o��d�_�4$7��$�)π"����  �� PK     ! Pڞ�   �      xl/calcChain.xml<�A
1�sw�z�${����	$�%Do�xih��L�ԋ������ؗ9�b�q��N��!Ϙ
��	Ln�1����:��Bhm=k->PF�Jܗg�[�uѲV�YQ�I��s�3^U������K��K�  �� PK     ! U��  �  '   xl/printerSettings/printerSettings1.bin�Y�n1�� ���DoHHH)U[zL�DM�����qq+���W^/Jz�x�}�y�2�&�����Z[��|��c�q|(����
GX�PڇC8���L>w��z7�s�����0Ķ�l���PP�P�w�v��\��,��E��g=�y����+C<1r�~ ���~ֹ�l�+7W\���YƵ�7S��jy\���鼁��X[�&��kG�(�;�1!���ҠKp�ՙ7�	̼K؅>��1f�.x&�1J=���Q�]Qp�RT٥#&8@��g*����Bpi,�Di�a�<�����jNK\����m0N|c�~z�q�����m4 �j"�#��Wj� \���{���-B��	M�H��*5?�8^�M�t�D���\�th�������}jRDm"/��N�$�)G��	�t`br�h��B)1�XO�(�S/�"!^W��_w!U@Gp��7��P8�q��Q��P(xĴ!�ėd�k��M*����P�!�::O�戁���5�V{�<V$��F�X͑!��Y�w ��}�'cW�,n��s\��p� ���7e�"6E��������:K�����O�C��d�̰X,�ˀe�2`�X,f �{��oGt��
���8ĥw�E�&ֿlu�Bgx2��t>g�����ܼ��];�z��   �� PK     ! ��g|�      docProps/app.xml �(�                                                                                                                                                                                                                                                                 ��Ao�0����9�:��bH7��b�vgN�c!�d�����O����vڍ�{x�DI��u�_��<zJ���x�}�}1�\�X�����ߩM-F�HY��T���]JI��h�d��*�8�q/CUY����4�Y���'�GF_b9k/�bL\v���e0==�Nm��K�:k��-��51P�8�z4蔜�*�mѼD�'�+9m�ր�U
�8B%�j��/m6�V/;4bF�WZۍ�~a�S���	����P��8�!�FdR2��PN���~ԋ���kc0�$�qg�!}�6�ċ)��0�8۞o<s�7\9��G�*4-��^�C���b��YP��݅{`<o�z��5D,Ӄ\��uZlt}Ȫ�����[��������v���3OfJ�}m�  �� PK-      ! t6Z�z  �                   [Content_Types].xmlPK-      ! �U0#�   L               �  _rels/.relsPK-      ! ���  ?               �  xl/_rels/workbook.xml.relsPK-      ! Y�A  �               	  xl/workbook.xmlPK-      ! Q��S;  �               �  xl/sharedStrings.xmlPK-      ! ;m2K�   B  #             �  xl/worksheets/_rels/sheet1.xml.relsPK-      ! ��nX�  �               �  xl/theme/theme1.xmlPK-      ! u��  v               �  xl/styles.xmlPK-      ! ]��X�                 �  xl/worksheets/sheet1.xmlPK-      ! )�ezS  �               �  docProps/core.xmlPK-      ! Pڞ�   �                L!  xl/calcChain.xmlPK-      ! U��  �  '             "  xl/printerSettings/printerSettings1.binPK-      ! ��g|�                  %  docProps/app.xmlPK      d  �'                                                                                                                                                                                              RINITY',77,103,132,162,195,230);
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
Insert into POPULATION values (626,'D','MORRIS','OMAHA','CYPRESS',627,639,652PK     ! ��e  R   [Content_Types].xml �(�                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 ���j�0E����Ѷ�J�(��ɢ�eh��4vD�BR^�Q�������{���`��*[�Қ����p+��K�3�ȟI"3�)k�$kd4��L�B�jJ2�ѽP�4�u`�RY�Y�W_S��/��>�zO�[��<&2�A��*f�+\nH��I������H��i�TxPaOS���u�0b�+�2���t��$����7�K٘���4vѥ��
����i����$�V�ܜ�B���U�V4�f��#ĵ�p}�Ʒ;bD�- �ΝK�~ߌ�y'H��6Up}�ֺ"♅�ٿ�ccs*;�޺�w�?c�ݑM�v�<�׵�h}�|�n�@6�܈�?   �� PK     ! ���   N   _rels/.rels �(�                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 ���j�0@���ѽQ���N/c���[IL��j���<��]�aG��ӓ�zs�Fu��]��U��	��^�[��x ����1x�p����f��#I)ʃ�Y���������*D��i")��c$���qU���~3��1��jH[{�=E����~
f?��3-���޲]�Tꓸ2�j)�,l0/%��b�
���z���ŉ�,	�	�/�|f\Z���?6�!Y�_�o�]A�  �� PK     ! 3�l  �   word/_rels/document.xml.rels �(�                                                                                                                                                                                                                                                                 ���N�0E�H��5{�@�P�nP�n!|��L��!{
��1����"Yε���Ŭ֟�g��vV@����֮�V	x�67�"I���Y0`�uy}�z�^RZ����%��:"��y�;42fΣM/�FR��^�oR!_����1�3&�6¶�V��vm�k|r�ޠ��w/H�>V�$`f����bN����'�R(fU��Ǳ�a��_�YOiO��S�s:��R%w���7����SB�t'���ǰȼU�����/   �� PK     ! '�ާ  �
     word/document.xml�V�n�6}/���Hrl�+DY�qbHc�}.h��K$Aҷ~}gHI�6h��,����n��&�qc��9I�q�T!d��?�?]�Hd�m��99rK������>+۶\� �����vNgqlY�[j�[����t�L��*K�x�W��GI�xIŸ�`�����kߢ)�%�ʴ���TqK�f�� ]S'֢��ɴ�Q9��uW�Cx%u������pe�e�[�o�%m-�)�Ϣ�a݃��b�6��^���j�0t��G�/¥�	����&�B7>�6{OZ*���Rs��t�s ����,������Yn,����|��̙ךj���eϕT���JA�#lkr��V��:�g�Xŷ�$�d�~���������|�Ln��
����o���+�/G׶{��69ix��V�$'$���{�x�A�je�*�b����:��G���;8B�4��A�9����<��7�4�>N�^緟������Gg�����!'��d2��:;��Y�� P�,9s�A���0Y$2���g�~_�H���$m�"+����hԩ�?vKCu-ؓ�f��΋b�5	���	�ꡦ���V��w(���/�z���F[�v��J��H���b4��z`̸�Tt�J�ja��#TĤ���n�~M�����k8�yc���u�;V�X��7(b�x�����J�� :�;v=F�e����t]�\�
���KDw/��W��	x~^㬞���LaD� ����Gm�[��Q�0ϞsB��Z�9e?��,���-x��O{�-�#UU��)�����k� �FAVF�0o�g�eH��]�NюS�/�e��v�j��S�D�5�7òTʝ-�����S��]�)�A�o�,��,`fWZ%'7�>!^̎��>���  �� PK
       ! %>���5 �5    word/media/image1.png�PNG

   IHDR  ]  u   "��   sRGB ���  ��IDATx^���Ź������e�\D�rD��+�`�rQ�	^�?�B���Q��`0�Ę�#���#*G�UA�]�"�vA�9r'�3��v�l������twU�|�q�Ku�S�����z��
�ܹ3��H�H�H�H�H���@0�dq�Yu     �	� 	� 	� 	� 	� 	d9������$��~�իWWUU	�G�1|��t�`�9�`��,�	� 	� 	��{�/r�5K"O�#��H#��#�H ���תU���#����0�4�%{1�k4z��Qx  �H��"��Y4	x��������VA�y?����� �Ł��߿� d���i��q�-یЃ��^(	� 	� 	X!@�JLC�K@3��b�+D����@�Q�+F�� ��!l�D�1i��8��ˆ5' � >�=�4�L.л�ڟ3��Ӎ�pc0��b�q������9�CEEEyy�\y4@��pn~~N�u~.�H��b#z��k�� 	� 	��U����b:�B�Y$<Eg#�C��F�F�Q��ҏ�%���`n('6Q���}&��:Φ��X( 	� 	� 	X"�D��LD$ ���TF��5��H�y�0�ġ�4�,C�	�5J!- ��b�X1H�"*�$@$@$���*�
*�H@5��H3� �X]�[SMLU��P���J�C�V1<�*
�$@$@$�� �"� �����k����.5#vy�WDg[	� 	� 	x� �"�芒���tg��$ҧ�i�֢��Q�<�nԦ�a2�f:�ItM�5N�S^�H�H��h�H�H 1��T:��w�8}�t߾}/ЏiӦ�Xr:t�C�l̳yVb�!#���5Gi3s  �� �"ۑ2C�}*]t�#���pۏ?��Q��ݻ��)əL�yt�ʢs&�Dΰf�$@$@$��E�pe�$��<����jkkKKK'M�$�͞={���x��K/��;wΘ1C���C��+>	�ҵkW'\O-iU�G��Y�*��݋�r�$@$@YA�vQV���$�	G�s닶m�6`� ���С�E�s֮]kx�֯__]][����yyy�/6�*�K�f�����]�p"R�i���t:�h:�B��:'gf�K�N$@$@$� �"� K�����={�ܴi�>}:���Gx�w�^�#4w��;v�Y�FQ�=b~����)�z�*((hll�<y2�E���˗/�T��9
'3�x6	� 	� 	��%��,ab" �nW� ����O>�.���Ǎ'�E8`�$�՘��4�,aV���;�y�d�w�g)$@$@$��hey`�I�*Z�!f����̚5K,
�����nݺ6���X|��u�v̲^s�5�_�q`e	GSQQ������0�t���@.�J$@$@$`���J�	� 	4# b�!�@(9
=:z��]~�m>�2��'�G����i�&7?7��rrs�����VH�H�H��/�($	(A@�q$%�.G�6J!H�H�H ]���%��H ��SŜ��ջD	ǻ���$@$@$ �.bK �D 6�s�,I�p"�QX9�H�H�,�]d	� 	���F�#.�a�   O�]�i�Qxp�@t��3�>}��sӦMk^�x?~��S��)?�\���p<�H�H�H��E 1		� �E��E���>p� v¶���i�}]g̘q�С4�M���'�"  �N�v�uVLI�K�����?������_��FC�x�G���'O����\{��q$6).&8�`����	[�v��o�
�ehk%�2������ʯ�eÇ��a)$@$@$@��]d/O�F�$�jժ��^���*'�F���;v�N���w����׬YS]]�ѣG��E����a���0�֮]��8`/a�W|\�z���I�&�ر�n�>}:�w�<ҍ|�ޡR�-	� 	� 	���h9�����o��>�QLb�����Ν��۶m;v�y睇�}������{��UPP >����ݻ���XAF��aút��Қ%��!  Ȝ ��2�?�VŢ�:u�X_Գg�M�6���n�z�WI�&>�7N��pL�<ٜ����o������z��zbI�H�H��%@�(]r<���@EEEII��8�Weee0t��0�F����o�Ճ�sb�PCC�c}>b��9�a�!2��r��q<���w�u�C2� ��;T
�%  p�@С)1�
��I�\ ����'
GΆ�;zf����c�`Q[����?|2���ȅ���o���_9�90�9+҅V�"H�H�H [��-�f=I S��(��x4'@8l$@$@$�q��<�@�On�֥	H�[͐� 	� 	��Sh9E������#ڼ:q		� 	� 	x� �"O���{`����4��0'�"K"  g�.r�+s%�НE��W,�����F$@$@YF�vQ�)��%�t	�O���dk֬A�m�B̜9S��6��%�
pd՝� 	� 	��?�.�Yp������/��3gΜ;�ST��/�l]�b�w��	�Gn�Y:	� 	� 	�� �"(�U WhF���<F��uɒ%FU���y�\���Bdñ "�� 	� 	� 	$"@���H�e]"����C=d��%R�c5f�$@$@$�7����Qև���3�<ӵkW����֬,	� 	� 	���hَ�� 	�D qP�����Ry,�H�H�H�����K�-kF'�Ǟß`(9
���L݁��.��za���!�1cD�#G���9�#�ٸq#VI�8��Pc���^�&?7��rrs�Am9V��   P� �"�D�H@��"i ,L��$&!  �	p���p$���A�G*!��*�!  �T	�.J�ӓ@�@�?7̡aO����W�M$@$�#��|�LV��$����`���x�	�ɦǼI�H�H���ܠ�2H�4�HN �vQK�"��A+gH�H��� �,V>�N)�$:�_D�(�aD8)�&&&  �0�j�<$�
��xt����?��6ر@�iTSSSUU%0�1���\:��9��h����:^Њq����� 	� 	�@h����@V���?���_�&xak����/�74De��E?��,P p�l���p���.iG�H�6( 	� 	� 	�C�vQ:�x	d���g�9�Bŗ��o�Ec�/�.Xڵɻ� �u~N^�uU��P  H� �`1)	d�]��;�x�t(�"�H8���G�^��\��h?���H��R3�<??�m��V���<�4����|�&K��X2	� 	� 	X%@��*)�#�l# �p$�DC��p�L(|�1|�C��0����U�V��+**:]q�1�Ba� L_̡�`���V�0����{�Er���I�H�H�"�EA1	d�.���`E��0�0�%�M�I����7vO���vw�lSyp��G����9�4�_��O��$j�E� 	� 	�@Jh����I �Dt�H�B��4�(O$|��"�B;܎P7k�������"���9 �?�5��C��(:�_��8�.�.V�H�H��hyVu�&�Y=A���Fa�B�.ҜE�F�� �n��2z����.zjb�1����(�#�/�FQSą �3�E��.��#�K$@$@�	�.�Ί)I ��F�nivQH�	鋋$N��~��mB�������T��\-�Bn53I� ��v�\�t  �F�v�5NLEYI�I���Ĵ:|3���tnO�C�?���.zv��R5�i.#�A$Gڋ��*��� 	� 	�@�h�J��I ��]F�A�[D�I��4$�E?|��.����R�!�����ݚ9�YGg�TͰp  H���좍�������oL��L�6������l��w�|�ga4?��#�
I5L���`�CA^��ڜ^_A�-$��]r�TBK�l���%!жu���e]ۑ	� 	� 	$ �=��ѥ���NQ�$@��ΕFPtG�s��ܓCݒ4��ija���	��"�+Y��Z��{�Btȭ;K' �H�{v���;��ͅ�ǉ-2��d�O z�6�/B��6��HS�9�Hb��I}�@����mr%��͢�Ȉ8}q�l�Ț=�>�ݶ"��˟?�W�Ԛ5% H��W�">��P�˧��r���5�Dh鶄Y_nD���V�b����I�H {	�do�Ys �	�ǯ�/��xt:<H�H�H�<H�v��F�I�H�H�H�H�l%@��V�̌H�H�H�H�H��hyPi�H�H�H�H�H�V��l���H�H�H�H�H�<H�v��F�I�H�H�H�H�l%@��V�̌H�H�H�H�H��hyPi�H�H�;�:�z�A�u�L	���%Ґ	� 	� 	��]�&A$@$������a��{u�_���4��0kB$@$`�E6�d6$@$@
h�&wd���_�FI)	� 	��Zh��JC$@$�!�Q}ss�q3���5��y:	� 	��/	�.�ZY) �^/h5��]���{���hXs  ��	�.b�  ��q;ĭRK�����	� 	�@���H$���;Q�6�<f.oŖ�XA[�:wL�ss!wk���6�Œ,x`Q��cg/i�?r/ə�H��$��ڹy�	s��;�7t���E$@$�#��E'τ|u��S�	���L���hUk���T��!��" �����0�`eV�H�H�:��ѝ�*��A�C�dp!��fJ �0����FQ����$ ���n�V��^�`�,���x�E$@�'`^MĕE�W7+H$@��]�gb�%-Փ��2l<�H��J�x@$�P�׺�^$@$@���]�*]ӳ}Ka8��ʙ�H��!��>r���W_���^{^�_��+�(��,�H�H ��]0��|-~bp�4T��)���jD�����]�L����`���X�����)R\�q�99�F����]�Em�H0(��+
`!$@$�)���@���ܹu�7��2��R�-&�z܈�x`��=/=O)�)	�@�tgH��uO��:��lɡ��=f����e��4�Ȩ��˾?�, �H3�h٢jfB$@6�]�n��,�aT3��}Bw0�;��O_�%�(� �so�ɠ�6!g6$�
�(�:�����=��z@ɥ��[\���j�6�EE��$��P���_�ݺv���e��y�tht��$X	� 	$ �%��x��k�����˰P�J����om>�@$��HEC��P ��3��E?_T=��ߔ�~�Ow(eMMͪU�D����d1ە����mT��c�aEM#���t	2	� 	8I@����j7i�O�S\(%n�%��b���G����F嚨,�H�.��H��F���0�f6ҍ"�6 ��+�o5��1���	� 	�O 5�Hz0��~����W/߻����׹�g^�.�[*���\��LN�`�$�U4�}�p$b?��A�1�#x�[��măH�H@6����.TR7����\(n�Yf���oΤ	�I���O$���HĠF_��Y��"��ҩ���yt��4��Ҽ� �xi����I�̛H�,Hd)\hw}}�j���B��r���|�a籘B��eh	׃��
G�h���,�hv�Gu�x�vQ|��.��2j��jv�f�]���7U@$@I�h�\ho͊��sv����NA�Ͳ�t8JԔ�R� 	dB@D\S�u���;w^{�_���矿y��:��p����Ç/_�<����L�Ĥ9��.�T1p��e�T�^0��U���`�"�� 	��S�EڣN��BUUUb�jeeeYY�S`����B-qz��6�u�I���N�>�
�Ae* /0�"�_��uu�:l�z6l�/�0x�`Hs��y��<d}o��)#K��rsrs`�eD��Km��� 	��@��*������F��&\���1v��Ɨ�ȕF�_� �	���u;K����O�>0�PL�n݄Q��#�\�ӦM3o�FԌ3���kN��K/�=ѹ:�hZ�
�F\p�4s& ����N��B� ��*�djjNwp�v].j-��|�N�g�$@�	���|?۶m0�y͚5���8z�hqq��ŋů1�/Z��`>|8//oÆ��֮]��p���߸�R������\a�BH�H 9�8�E��H��1�x$$k��1�D��؏BnP�իW���eDT��Ն���(��H�Q"Z��E �={nڴ�\
,��cǞw�y���/��B����gE=z�@��{����s���}�l!}�">^��I�H q�1��u��R'��[_}�K����ѣ��]�Em��'�ü��Δ$�21�� ��W�����"�5�={�M7����.\��`�,� �B]]���/���>x�W`A=��c�ƍ;s挑 �wa�X_��_Xb�E�f�^d$@$ �@\�H{�1��ݨ\H����Q:�}t��ǔ!�n*�:��̙�p�.�4F<�V�Z�X�k�`���O�v^|�E#�����z��{�5�E��ղe�x��4�Yl"�A��".&# �	$��\(�2�CNzp!���Q�����ڭ{`M]�m�����b�&�$����(�P��N�HQ�P, �	$����(>����?pt�r,�5�d��8���X5�{�n��I�,~�=�45tB�M�SF����lF���.]m��s��U;�,�kjj����TݢR"@��:.�E�Y1%	� 	�O�Ũn.��2dR3�zyy��աSUO�a3-	� 	� 	� 	d�$Ѯ\�bC�\HѠ�
FT�6T�b�f2   �*J��Z�n�*6�@8����'�0�����/Z����+�h�-L��Q��4i���ɠ��W͠�ւ�I�H�H�H��%��]ԦM��K�N�0��w���[n6l��{�744�M���'O��aNСC�6�W)i�m3���F2x��� ��^+�$��$@$@$@$@�	(aC�n�v��ϡC�8�<����h
0�֭[;'�{����b/?las"���k���vD}Ym�@�(�Y��1XE�"�0�ѹ�eR���H�"D�Y�x�H����-�#��Ŭb�566�~��Y3��$�E$@�%��]�[�nUL�D.�E�6�k׮�����A:���I1�}bҜc��T:Ġ�q� ,U���M��q���{�վ=�|ĥt�27�x�믿��q��\�M�6�=L�w�y���ĉ����� ��O�빹O~����e>$@$@��]dF2Ѧ�9=���+�d���>��#��T�yJ2�P�I�mbăH�F�V�jh���k/��1g#+,Iݶm�_8p�]waB��.
�B}���I���6mN�PΌ3�=>�"�w�d�,��۷�	�E�UMp�N�ǜI�H�R"@�(%\�&v-�zmmm�>}�|ELb|���&�b02otG�^�aҋ�_�\�A�ݪ#�!?�!���|w�իW�[߂1w������'��հ�0v�E�bZ��CJ���x�����ۇFno����#��K�ݝ
�s>j=�+  ��.RH��BPu��0�,'��m�A���-Z�d0�������}�i�AK�z����~�A�3T2O'�t��������/+**0����G��{�رcŢS��{��իWAA� '�ù��=�),,\�|9��;�N1�8{q���'s# {	�.����s3�IU��|��q�����1��=z�@��{����s�������G�A �Jqq@��ޡJ>�̖-[`�`Z�Ex'v�^���
�~����R�/��d�"%�ơ@JJ�Nee�9W�C�1[  �Tȴ��
~1\�('�����T�ȴ��NS��dF$�S�󊪎t�T6��(//w���;w>q�&��5�����GK{<Ĉ�[�������_y�X����z����O�p�ח������+�v� �L$@$��$v��5�o|���w�Y�Dd!L��tp1�[D��*�jH9@>}�u����[6|(E��NS.gq$�M�S��9�aav��?�"�{�|�y�|4o�`�ǭ��>;C`]�N��>�F�կ~%�P:v8�1ə1	� 	��@�s6G�����u���}��'bab����F0h�L�PH(D�Ƕ8���L8�����Q�zإspl�Y嬸Ӕ�ڡl$@$@$@$@��9�NH|�׾��{x�U�?��ŗF�[:x�9�̚5��o�`!��O�>]��9s���Z���,     �o!��c�>��,ه�G��	�o���򗿼��bE/�w��E��bb 4_��o]�v$@$@$@$@$@�Hb�1�Yȉ��>jԨn�A��Ո	S7De�֢&L8u�~�"���?��%�u��+��"=(�r'�Ea��H�H�H�H�H mI�+�����T�rY��"!�*|>ضܨFL���Ճ�����;�X�>�����'D[�b�>,@J���dP�D���tl���,d�Ӑ 	���p���0l�&>�G��ų   o�9���7��	���X@1����l�2�MB��{o�&B "�,q���9�9��ٳ1�M�[�ژو�`�MǃH��$�`���7� �"����&`�'5e�T$@$@�	ȴ��W�X' _��qΜ9o��&̤3f� �<H�H@)����܁�"�޽��)%*�! P� �"ut��$�lj��E#���W���Ma�_��0�0�:i�$�\�xq���a��!&��#���-�܂��x#\LF�u�c��۷y4�L���G��� N�l6e#=fE^$ �̉}Z1�w�<q���{�.��H�H���\��R�O��>���_�%����uCH9�?�8��;v`^ʮ]��G�������m��͈���KJJ0O`�H�L�}�Y|�[��/��2�3�(�=%�l߉�FQ�	��-����
op�y衇dK�̄H�H�h�O�N�H��G��g�y�(�yD���J�T쪫�B�>��ѣ�Ho[�ӧ�;�c���Ν[__oN�@"F�4���,I@!"�X_d>ľ�<H�H�H .��E�9s&��2��{L�t�f�%��ޒ������ƍ'�E8�}r�F�sf���0s �x�!���y�I��=<H�?��|�(	� 	���<f�(z��G�$)_(G�S���'1A��Q^ �V�k��뿄ۧ��!S�"��;�P�X�dU�)�貝&����f\ۉ��l��� 	�G@̚b0`���(��   ��<f}�駝;w�"��fSFN�:ҹS�h�7�B�s��H�C� "$:a�� $����Q]DQ�ᄥG"�$�R8p ��
"#�:�Eus\u�U F�8��n�[Ύ�퀙!	� 	� 	� 	x����"o�v^z��?��#� �M� 	� 	� 	� 	�D�vۆKu�TC$@$@$@$�S��|�XV�H�H�H�H�H�2��E��0f̘^xA�ݷ\M&$     �	x�.B�#���Q�$@$@$������JWSSCP$@$@$��@����N/��#gC��=���S+�M��G�1V�6,X�n∁SF����WNn� ��T|zb�V��"6�o�����؄�+Kb�Y4	8G �]hdYI�n�j1�w��\_ݼ��G����}�e�>�~`q�V���ܘ�H��� ��.����]����<��3x���s���^"xw����x�te�(/���74��=����>��nc�5f R?F����h�u�Z����=�&���H�T&@�(#�H�j�f4��E��������tee��x2	�J�|jG���5[v���P$	G�ot��58��-�]T�o�$Q$�����	�/)ԣS+�/��L#7����H$@"@�(#eI�j+ka6��1��W�XA�(�ǓI@=�.�Hc(��	��4���}(��,��}����JL���,�=D�$(3�s��<}�u���V�0����{w�^K�>�& �	x,��@)!�5����F�����N�:�	��_	�!��`}��Ѻ�x���Xv���>Wn�<���m��NWq_ Q"��C�hh(�G_�$���=�^$@$�9��Pa����Bj�68��ϗ�BPM�Q*Ȍ@4���G3r`E-"���i����xH�~�@/��n*FQ@���48�H7���b�f��M$@$����.�E���t����Q�҃�6�ˊf͚%��A�lٲ���"<��C��G�ug�$�m�ZP{�hS�P8�@�Xh�O�Ӿ��ى���
pN�o��/K�C$�"�>��[e~���GH�G��0w�)�$͏�=�"��3)pX(	� 	(E��]�Tp�=�'+�i�U�|=�.���	I �.�ɣ[A�]��FB��"ܢ��H��_�k�����3�ZٝT�>�4���G���:��H��v��̙	� 	�J �]�Zp�[V�Q�.bp!�E�[<�"묘�R"`܈�/֑�As�q,=򁜅4�����b��)U���Q_�f�iF�����Z#fF$@>$Т]�lp�U�V	=TTTt��J�:Q!��"��v�uVLI)0����H��4GRS�n�'�.���������)U��Ěy(Bu���"~A��Yd+jfF$@�HwA��B{M��<	h�����<�$ ���1��<��01UL�:�M����ChƉ�/�<�^�m*k� !|p�B#E65@fC$@��k)\H[�"��	0 Ș�n	���Ѩ�"�!��N�K{`�/Y�r�xt����H_xăH�H@-�����І��6T�{A�����������B�#<I����E�Ѻ���[����ң��9�@�$@n�n{�:"�����L�I��  K s�"�n:�ƚk�M�,  �DZ�Ggt�1?���EsH7���`�;v��f��_�(1Zw�h���*F�0�����v�~p���o�E�I$e�ZP�[I��>A��!�-�,"z�d�� 	��7ĉ��߱ş����f�Q������%�Jp��qT�l�ݥ/�KJ�#�O����ٔ��ʒI {	|���D܅�3�o�R`�I�H�,h�.:��j��y}�����=9Q�&}:UU�5��T�ljD�����NSh∁���:_[w�@�U��b�v�$$�=����3JL$@�ķ�toQ�4��"��;�E�6�$p�'��<�xIۼ��$u����ɵ)�Xz������v�R�M����.��Ӕ�pEp\�����%E�ztj�/�k�hɺ��[����_����7z�
�#���g�ӬC�|�׺m뼉�ʺ��zE(?	� 	�I�E�H7���|}������D�x`����^�._��傀 "&��F�a���E�.Rp��}�������������mE��ٔ\,�F�.��?t���	X$���?��Ĺ�d2 �$�$vNt�r�����s������K��lԽ�(C��e�Ex��P�Lc�1��a��'\}nO�eG8��������M創�"�a��Z,A=f��p%�Ȣ=F��E�]��<���}��x�L��V9���ק>��'pS���7�"�>��QB H��%�O��H���L�G��E
=��F2z�B5��(�G�n�C�����]t����f�����D�H�Ӵ��׍"=�bt����0l��ڕ��*v{�*�������_Ǭ!	��l����ЫMq���艆�v�ct�>��MX_�Vҡ�fS����4�ͦ$�HK$@$@$@�#`�.�^��Lb57���r�.��v��fSYv��$@$@$@$�>�E�S�L}[y��~�u�M�*�����i�����x�	��_�7K� �t��9}ݑ�rN�!�ݧB3�$@$@$@$��h��	D��Z-�tNn�`�R^b]^RJ7�A 
-07�F@�`z�@	A)|��X   ��E�צ�2��顨u��iM��"�!� ޸�҂>�/���f�� �X G����ry�)�75V�H�H�H��K�v�t�M���1�N���nŴ:)���( M �ր hp�}�4Gg���`H�H�H�H c��tg\J���������r���C�s��+4�ܭ]��ۤ_�/Δ��4U�MM-�� ��9sS�%�rɚ��ٔ/Z+�`�d��	�չϜ%� 	d��gB���ȩ����S/o�&7۔���6�:v:tߟ���I	�������ҳM�\/��ͦ�>}C�=TߨR��rLPeeQ6 P�.�6����	p��mW�C���e%����.�����ӕ��YE�J@�ΪV�te1�to��&�	:��O$�m<`��o?p�L\�`�ȜI=:^�*�4�`}�#h
��+tMA_
JN�H 1��=T�w�\��Pj�W6qL�W�feH�  wF�% �IO,?�@%朡%�hY��|"(�h��I�/�Q�X�#0Mwd��g}SY�sD�;3�H ��n����w��a�$@�$��ܯ�پ��
�v�b<Z�����q�G+E�I �P�+��"��D�$�*��ML&ӓ 	�@Rް�P��C;6�L��C�T�n&�:���%�vU��)�"�	��!@�����8&�O�E$@	x�.Bo�O��7
6��J��;%�H$�� ݡl!��;��1A��I����g�"(#��Вk"Ԧr�?����T�e#���eÐB��A�1A)�`�$@�'�%�(f�
ʶN�j�� �:*�)
�*�CS%����l�`�H�	� 	�%�%�0b�%��Oe�%���XCȐÈ	�� ݡ~Ѥ��a6�9&�1�Q\ ����Oj]�H$��4�s�0eͺ�n\~��Zܘ��֭[�f~zP�~�\MIᱭ�6i���� ��2oi�A��]�pT�P��s�bE�k1.��՚�GO�=�1�����M��6+G$ �@�}]�:zrׁ#Ӡ����7���>j����M�#'G��˰�
�]�6�ȵ����.#�4%�rg�v0v���v��FrG�����zժUxI***�.�����S  _Hd�O��[��~e�"���pw}}T���@Ց�0QK�l��.���� �$Z\�uDMYl�5eQN&KL@z'u��բ����T�6W�4q�ɯm��"h�@�v����:�����=��z@ɥ��/��qo͊��svQQ�(��"�Q���[���=}thi�4��iԔ�f������4-P������)�FDw��WG�,"�H�EPLF$�	�"TAs�.���꩕��T��^������*1Z\YYYVV&W������mT��c�aEM#���\C5��!��)�mջ�+�I�cL��ڻM+��i��P�4Y��4$@�#�.�ſ+�m���W+b�o8�%�j��[G�NU�Q��ˈ��x�IהE9�,�����}�o��":���n9�dE�i�B�iH�<G�%�H�H8	G4��WU���W<�^_z����� B��:���q� ��T҆!]SI%d���������U;�v��H�E�i���H��E N����bz��3⑐@8A�*'���N�9΍�J�a��T�r2� ����y�'�&S ��M�t����M+�͸qJ��s����!���)��	q�t���A�1��"՛ �,�wؠ��)�hP�4	�}.��`����
ٚ�*'�5P������I�P)iJ G�R%��$@��k�Ì��ct�Q�J���F�n�����%MS;w��ڵ�iӌ:���K:tذaCL�O�>=t��C�9O#y	�4�\6��!�Nj�M���T����#MVAr��*)�#��D��T:��D��ڤ}d�\>�h�w�ޟ|�0x�y睸�۴i�n�:�L.3�[�tM� �k2��jUc�Z%�b:i#MK.'�4���RI�#�x���#�D����{��$r�M�\"	�:�����>��|����u��	�+���C	&ӌ3����#��#��۷���u�	�T�5ȪӥuR�ͪvּ�RF��Ȝ#M^�e&H@�E���<R��S�֯	���i�ݦv�׾��{(�����,��֭ۮ]��=z��a8�<(�_�fMuu���Sqq�E�֮]�z���(�LM�XM_%��Jw���Pʕ�0Ҕ��
���&�@H��$�$���Q��}��}U��It��M}�[�:v��|��_��#$��h����._��P��m�Ǝ{�y��>}�|���z�*((p�EHה���Eq:�t����S	�#M�+��4IV �'���B?�ss�@^^ިQ�n�������ԕ��
!C��={nڴI|ܺu�W\ႄ,��$vR��z��D~)#M�,�\�4�"�rI�� ��]��d�y�ěݻw��	��s���]�t�뮻1}���/***ڿ����a�0}N�/jhh�OI��,�C�tR��P��$@$@$�97�"H��d���T* Z�R3,"Z�l|Dx��g�!�|G�����"�Z�<�K.�ĨO>��q`M�����T$@w(�@&\L *$��{2��% �,!��]��d���L�a��c�8iR�eI�2�	]8�ӝm�Y�	��!�,?���,G�� 	��-\�� ������B�&�x\a��xh�h�3�ߑ��<��*K��PeU�-���� ��������SO��y�o!��$@$�(��"'&��ͳ%^{��5�Es��ݱc��xh����� 	�F��P�P{� ��o�3�7k֬�o�����2a�����K�I�H�^��ENL֏�g@�ƍ�"\�ooKbn$�m��6��Q_��o�`���_���/VTT�
1[&��եQ/�B$@�$��]|NL�o�gKz2�C�r̣�F�����ˉ���߾a�'��<I�H�}���A���7޸dɒ	&�:u*f��O�ca�$@$�&7�"'&�'�sݺu�|D`:D�� #B�M�4IDTSS1�I��b��HyH�H�v���A�Q��}��w�qG̖	x�^efH$@%��.Z�����2���5+jjj���&�ȧ�8_}�|ˆ��4s�5eq��X�kD��ڵkK� �"`�w�o߾�5M#�R�JC~�B$�9��7H2d�1�I�{�9 �>}���c�2�s`)0	� 	8G �]TUU���U�V�+:uxn�>���8��Z�.h��b8�y�������ØI��w�څe]�E<x�X�E���?a^����m)�R��$1�N &�WK���l���亀,�U��`��E#��qzL�s�PCmm��UK G�1AW�#�;7����a��/�Ā�W?`���#��`,0` �#�xÃb�*:��j�v�q��H�{h{hvR��^0�R_ih�+�Q'��=7 ڮ�qB�̓H��]��a�@J�c2�裏JKK��h�ر�_�E���6m�dU��&F?]U�w��-�E�'O��r;1ATHb�ƼoL�lR��f'���&G8g9#����Y	��I�#F�!>���U-@�p�鎦�/ ��1x�`�y�߿���W^
��Sqq1;�Q)M9QA�i8^:v숦���yF(�~a�'B{�	���̢E���Ƙ�u,�";�����89g�~i]Αp\��H�\#��.�r�?�~JՑ.���)//wM��͜9sРA���z0E�A���ұ�_-Q��/ 6���@�ٳg_s�5-�	F�]I��`/��W��e;I�4e{혡]�yt1��3BQV�ǘ�`>��s�11��՜;�NP�`JIIP�|UVVrL��p�hr̓H@ޘG�꫿ax`@��JJJT�HH�%���/f7�+���Q�3g'�	�i��-UG:w*�ى"R�Â"��3�<�҉N$�HӀ7N���;��wBl�I$@I	x�.�7o^��O<q���'�� 	�� :�FN�T���<:�^�""��bv��<y���J�N�]$c��}D�����O?�Nu�f�r��)e���$gb H@�vQL�>���+	�@�p����"�<,
*,,�A��5��	�bڧy7s��s��#*��p���)^S�m�,	�uD�H�<M��v�/�0p�@�(�������Ӻ��$@$@� ���x����1AO�B� 	x��'�"1��#g��Q��H�H����R<���0B Z9�iH�H�R%��H��ޡ���V��% 4��xrO�0!�G`�$@$�cݻw�q�X5 �K�v�.>"s ,E�����	`�;>BS+V��3g�#t����pho"��H�|O@�.����R߫�$�E�v�,:,7%ؘ���������{oJ�01	�I f��75OdB e8EՔ�R���12s��MY P� �"��7^}�ՇzH�JD��!�I<H��`�����EE0q��G�h�(6	� 	� 	��� �"��	`���5fz���/��`��Kbv$ ���={D�d�52d�)X&	� 	� 	���h�4˳��9[�b���;�޽�R��a��N@����b.�qR��uJ�I�H�H� @����60����c7&�a6ݘ1c��cɶ�	�K@��2"��ʕ+Ŗ2x�%F�� 	� 	���h��4ks��9cq0�`=��#fm��_�ѰQ)�moܸq�ȑK�,�_MY#  �*���Jݬ,	�@�� 2��a�\���4   U	�.RU3��H@%fw�y5���,RIQ��H�H��$@�(Mp<�H�H�H�H�H�7h�F��	� 	� 	� 	� 	�@�h�	��� 	� 	� 	� 	� 	����좚�����F��5�?��F$@$@$@$�c�H$S=��	������۞}���e%���I��җ��#X��7�%J������N1p����ܠ���́L�qѨ)몗�)�r2�A n�Z�oJE?R�!���a��u�nD�Q��M���vժU��9RQQQ^^.;��\�,�H�!V좺g_����S�vD�=�좪#�a~�������|ݠ��9y9r�"j*�nei��&���j]��Zg� �WF�JJ�#�Os|�-!S�4���		��j��E���_�<�fˮP8�"�HX����a��ز��/*�7Fҳ!D��LC����ѩ�Ey�i$�_DM�pi)�)�.{O��N�u5��j�U*v�R#M���c�D��	ڢnfB$@�	�h�#�p$��4�gB�3��x�e�}/��׋�80���Wʒ�b�\N0��O�k���*F��Q|��<:j*i����2As��"vR�4�C3���MN�����2�EY>&���y:	� 	�D �]���0��FQvQ�pXE�I�7K������n��s�i��x��\�����/���듍��w��ߒ�Pє��{�\vR-���P�,'MNّ���*��������ղ?!G��g�I�� �.����!���i��>jvѹX�������A�a ����9��#.�It�R��� ����潽�N6^t~���]e�I��(�)I��v��Z�;�A%Mf495G���ˎp8��x���I��P�49�ْ 	(B��(�}�u�ð��]�9���nE;�Y�2�E�a$�E��(j�����fi>�H��O�]���漵�������-'��:�R�j���wR�ή�;t�,�_�	���V�J ��#M�߈�E�}W�]đ&�4vV�H >��"=���E!�o$�/.�$:��#����D�A�����[v�����7o,l����)�x���)���nъwR��n�jIr�G��e�v<����	=���H��,�H�Mq�"�Դ��E�:���Q,*һ,�9�Nh'��\FM�E���l^�CaM�~����g/n���wK�l��,KM�#�Ւ���Նղܢ�);��ϯn��~~sO��9�$>�&p�@Kvѹǃp����h
����.��/�Ӗ>k�Ptf�K΢&�H]M=���C�;��{r���Ma�*�)��d��x'��P�59���{��/�Ŕ����H�<�,�H�y��"���p�v�p �It�5-�˦t	�
"="w4�x��:3e5����o��m�L�:�ٴ�K���n�J
����P%�L�B��q�����*����w��L�|�4�ώg� 	�O�E�(:r�����sZJ�bѩ_9�%@��
�i�`;j��=���f}<v��v�rg}U(�)wۅ�KS��Jw�W�����_����7ZX�	6ڔq�	�B�/m��C'�
��ŉt�vK�'K���&:'
7�ٶu���e]�9]�'�I��:"�Hл�ك�rM�٨�*jZwd�\�*����vѼ[z�Vό2RBS� �N�;4���q\+�6]Z_�Tj�E�Ϟ{�qL0�	H%���\��gߓ8O;�f��$@����i��(jI�����D��QJS35�E���4�UM�kPGB�C������oD�=��<�@4;�ʘ 6X?y&|^���y9)T���&�����ar1�6_�狃��5	��;,�E��R|F@tG���Z�T��P���)��R#Mڀ�I��4e�V�1�D �Pd��+�('	������T��h��|	�4/R��k���]+�$c!���+>qe�  ��]�E�$�{JuR��b�gu^���"`I�H�$@��A�̚H�H�H�H�H�hyBM�H�H�H�H�H�A���ˬI�H�H�H�H�<A�v�'�D!I�H�H�H�H�$@��A�̚H�H�H�H�H���'��I!���'�F��`��IB��_�ް�Q��-�O�=T�:wL�B�����u����Xd���yS���y$@�ElN`��)��W+�2��dh&��c�C��鋳!��U�#?7�`����� -e�H �Z�O�����ҳM>'�X��d$@�x�`�  ��
�����k�\8�o�+�$ψ)& �gd���_i9���O�VySYE��g�$�Mhe��YW �t	$햱��.Z��շ07���9�=~��H��<�jE�/hu���a�d	$@�'@���*dH��!�޶;�3/]�%�����k�E0�	$P+��4�Җ�a�Ee�$@%@�ȣ���$@n`o�m��7n`��g��}E�T���>D�����`I$@>%@�ȧ�e�H� �޶P����b��7C�n�2��V~�U��� 	�� �"?k�u#�� {���t4��F,�E�w'��J��ۧS��0,�H�gh�L��	�����v��}��x�Zr5�W sr�@s��ԡt�A�e�@6�]�ZfI�l#�޶m(���l��Y�<o�J0���97�%�,��� �,P2�H$`+��m��`fF��ġ���Y;@�P+�M,�ā�%	�@����O��Ug�&�b��g��s���b��b�$�*��.l�f�Ql���?]S���U��2)YX$�+Wu��}���c��>�)''ح[7����/Z�\�j��薶m�TP�o4+�� $ �@P��Mn�Y��XTw���K��ϟ��т�y��~ת��^�j�C�����ÇKW�:����u�H�d*J��X�����mV\�q�99�fI6bQa���ڢ���5+X�*�V�>Єϣ���}�!�,!@�(K-����$@�o�������-+)	��r{��J�;��uO��Z��Xq��]Tu�@@�]d0�}t��ǔ�s�w�=`��Y5�
]zN��\���!@�H]x^��_�ް�Q̣�D#̣ӯ�\����q����bT듡��"����Q�u�#o��{zQ���K��_����m�]TT:J�J���^�uz��G����Iӡ��8�.@�4��Z=�Y��,�<C�v�gT����N����gC�V�?/o�-=����U�'%T����fEC�9���m]S�?��~��zje�)���ᚚ1�Q�f+*���労��a��u��*�}L9���i���#5��ZѨ��Y��K'5	�.RS/^��k����p�uѨ��py����
��Pot˪���2���ʲ�2W`�X��>�p)�/�]�n����Z�H�^��.4u����s�/���uQ����4k�^LF�F���٦qg���S[*�����"g%`�>"��ɴ%���z?�)���w���!�(2��pXc�����v-��'��B��նJ��p(��m��R��fSP��4�B����� ��ѵ5M�IȤ��&��ܐ�ex���}2,S�:De�ɚ�W1�N��HH ��FQ��fƺj�ZU5k�TS:�h6�z1=	d�����5miSy�Z��ם��� �d��'
�͢���+^Q_���"Qj6�J�	��Y��b:����G�.��O�����.I�b|E�}2���'ӝ���>�"��n�Ν]�v������:�vF�O�:th&9�Q4XE�"�0��i!�����S�֬��
]xG�7fO�%@�ȳ�SX��.#XJ}:�1��E�N��>*��n��>�X���,:37�tӒ%K�=��G͞=;qcmll�1cF\�M�6�֭�С���][��ϣ�q� ,�ʹ�Y��U��<��L[�'��]�;�*P!XA1;MJg����������2�d�sυ�t���}��<x0J�֭�s�=g�� M�6a���������^�xq��ݟz꩘��_����q���p5�D
���pC�^W�P��4�tcg�$�1��<�0��kv]ӳ=7r��└Ӎ>*��n��>ٹ�I���o۶m���
�h׮]p>|.���]�v����v�UW]5iҤ;v<���1)'Ruu�K/������6l�������J�M]��5�z_�-i��F��I��hyRm�=��b�AN��X.�{��Q¸\듡t�w�����`t�F={�ܴi���`���ɓ�*,,\�|9~�իWA�6w����:#q��'8�p�(�ѣ�#������4��
3�[�u�����ERVj������ޯn�����.���?�]#K��rS#���p�O����[�%}2��u�V���D����'�ׯ/--���cǚ[.R�F�9�t�>AJe�{�
B�f��YmP� �"����,_=Y[��v���d�~�>��Z�jU}}���@UUUm�^Y��r`�w�8�2nh�̀�2��3�.]:a�8��t�r�-�@w�'���߿��Ȏ;⛆��)S� Yee%�5O�Z�^N���*fI@}���' ��Z_��+�U�MŅ��룂��\(a��>���c�0�A��R|f�
��%�X��E��l(�b��g_{je�)��	.,G���[�j�bŊ~������޽�:����8q"~� �ƍ[�p�#�<��_��Vx�s����7H��_��'�x�W�;��{��P�+k,]7q��)#K�s��+SX�V�x������{�W���v&��T����Ye�
���l�-��I {�.����ZP���=��z@ɥ��%/��[��"q�.**��#�.����ڭ{`M]Z����F?41	uP�O�v���ɨ)뗇\MY�S�TM��^���RmZLO��]��jR����]��E�N��[������7�W0w��Y��=��F��>�FQ�4r~4��J�8s��d��Zjl
jJ��v����P0oi6���t�1�C�>&�Z�DTPm�t��#AY���w�}��
F�!6 ��+�o��C-V�ɲ� B</[�L��YY�V�H�H��"@��.��Ѭ"mK�H �R��!M�A�1ƒ��-I�6�A$@$@$@$����f�.ҩ}��H,Q׎trɦs��nEYiN#������$@$@$@$� �"4���|�,J�N���+�+��()2& %	`�"	<t�PK�aϢ�o�]ls����2YN�����x�b��#��x�h������\H�H�D�v�כ������D�8\!D�ڵ��'$A�$�I�4IsH/XE�"�0��i���ˍg��@L/m~����04q/ܗ(X)�B��o|���Q4�ثjӦMx��w�)))�"%���|�eD��YtxD�t�MK�,���}���ٳ��clƌq�'l�nݺ:�� m!�>�N��40�+���!���7jԨ��~[d�z�ꫮ����PJ���J.�RظD�݈�?o�<ĥt�d�������5ӦMC��0���}���1�#��>&���^98_}����O~�����1��k����+B�.��z�mۆgǁ��.</��P(d����{��P������Fq��O�{]hvˆ�.��� 	8G�v�sl]�Y�J��D:l!ߧO�7%bs=��s-u8����������9ݻw�,����_����th��&�CM&�DN�'��6�\4���}�o��'��Ç_�v�S����ѣ�+��1=l�Oּ�f��s�U�q��Q�O�j�*�]&^x�t�E�����.ç�v������bP7�]�v�$@����P.����G1)�����xhE��j������5}�[߂������?y�d�J����M ֬Y��|�~����,;s{�2�2C�{W�V������.�N��L�p?x0#k�ÁG�"��O�4iǎ?�pLJÉ��S�D�
qpSWO\ ���G"��NW���?��={�9r�
��vL��Ks�nc�0GKT0s(��=z|����6����[t�a���|�r|ӫW����f�T�jY+�����/+**0����1B!\I0z�}�]���cǎ��1l�dxcnY�'H� �4�)z�>��aԳgO1��8Z�p�Q"q��{�`���UE�D�hKVD,�����=�Ξ=�Îi�q{i��\Kf��+���X�"ެ_����T��Ї6�a��pw���9�2f�� |�0r�l���Ex�����{�駡>��6?��n�
�7y�LA$@-�]Ħ�<����0��'?�IK$�(t80"A�$�♔\$ �b���(6A�i�數f�c���5��.j,Z�?��?`
�Cp�6�B��e'V�߿���+��I鴴#F�0���}�v���ĉ�8�Q	8��
ŒT�L�����?�{��S[1+3�Vb����V�Y�DP� �"���x�Ch�	&�	ԥK�[n��y�]Ɏ;�GԔ)S�S�������Z5�4Jp�Oh�0r0�ӘD�/1�.n���~/pJJ����kMzW�p^QՑ.����9s&p9נ��-�!,[�L��vѢE���	��_�
�!�S"������!CDz��cR:'������sq��{~�H��k�.��������"4�Z��v0߈�.4~~Z���'��rq�1�A,�u� �A��f���Ѳ�9	�����<<K@��r�Uz6^�~۳��?��ߔ�~R��н����+�󎤈�Е����8b������A����D�s�3RGM�$1m��uu�|�}4쩕��V�H���?�l݄��^_�~�V�.$W�K��]HY�bl닄ɤ��-�*�b����/RP)�H ����gW�y�;�xTq;=ӧOW�(J�<�H@A��T��E2O`�p5(:	� 	� 	� 	�@��]�e
guI�H�H�H�H���]�FA$@$@$@$@$��he{H����=t�PcK���"�����O�:�R�LL$@�X�x����l�W�q���3��[ss���A���B�r�V7���H��h�X��	���֬Yct���o��`���R>��Ñ#Gٔ���P���fy�li��G}J|���C#q/���4�X0	����.�>ׯy��E#���W�vMM���_hƌ�>�B�b4y�d����k��ɓ'{��->
Ǒ��Ǵi��'�#P"��'��u���JW-��>Y�eÇ��l�� v(=l�mc3�l�����=�͛�-�)mRPk̶���`)%=�	H�H�"�EAy ٪U���#��{�%^�v��ի����m޼��o>|�0���<qϞ=���e�]��o�BJщ���~����jXJH���~�� ��o����8�VSUU�m��nِ?F��(�v�<�'P__/Fg��S^W�����f��ڵ+�RJ~2S� 	�@�h�u�I���N�6W]uUEE����y��ի�� o���SWW�w�^�_4w��;v�}�E�k���K�.��VO;�1�"�̘.!��_~#��>خbhf�ƍO<��S�&L�����#�ҥK_x�<>0ya֬Y\b�fC$�9�E�3d�	lݺ6~7n�1�3�bR�7���SO9�R߸�	�F �����ٖ#3r���}��/�%8H qz�!q��e$�,X_�G\9� wfMYC�v�T�f��˪����0�0֊,�/a�Y����w�|��rNf ))	
8�t�A��b��@`Μ9��zk6�ԋu��V�\9p���3g��8ƌ�l�2/ֈ2� <B�	%B�0�ȄH�l'�"ۙ������`(9
����?������n�ቲޭ�vٺ	�N��,?7��rrs`!"%�tӶW����k�O���-]V8�����_�~��tI� +k,]7q��)#K�o�*kJb��T�4�Y�ļ�Y��bJ�6��J�z����V��U[�ZxA�1���`�$@$@$�����KքH�H�H�H�H =����ƳH�H�H�H�H��C�v�tɚ� 	� 	� 	� 	� 	�G�vQz�x	� 	���jkk��Ǽy�ߴ��R>k�Vk���H e�G�22�NP0^�s#6.6�ې#�� f|# ��"�^�
���*��Yr�v\M�,+��ͅ�'.�ݥ/��G7/C�����K������ʊ��:�լjjXoi6Ֆ��$�=hy[ת�a�?�?�A�.]�]$��^r���ng2�W�m���j�*���*//�A�\�r�v3M�=��r���h���!�	{�U錈��e�]4��A��s�r��-@Yͪ�V�+�hV�%@H@Y���U�%���;b�����`�%K�X��3�������sUv������m_ӭ��0k�1�뗇�l�
�C�@$	��軄��^�o~�l�#IS� �`�z0'ؿ�hP�N���Z�f)�����UF�Z���fݿY"	x� �"�h*����E��f͚�=*�5�"��S-]ٱjTdD�=��Y�BM�#�p$��4�gB�3��x�~����J����UUUb����ʢ�C��9�|��tN0��o*�*/�U.�"��^�ݥ�լRj��<��4Z/O!�,!@��ۊV�.2�b��ƍ�ы�t�.�>�b��F}NlYa�ZA��r/��{���`E��0�0�%%�I�W�!�"�f\
�m��n��s�i��x�������rr���]B�j*ң��H�E���h)��$�y�.4hвe�hy���(��c�`��j���NW\�"�آ��U�C�B��4�(O$|��"�4�1�N�j�����(����4sH�E'��K�.ҍ'��5;���]��w%�E^լJ�����Z�[-}x]�W�_�f̘CH|�1H4��6���Gd��bD[�!� ѿԆڵ��~]��ʃ���u���x� �DT_���нA�T\m3M����t��WD{�s����d�+Zw�;$D�#(�P���������:��D$�(okV��F�H@:���� #��eT%�N�<:��:���cը�w���Ƌ�ϛ9��#�O��*c՚�Э���
B��HH_\$w]r�n�0O���m2�r��݌�DT����~u��G��{�����xQ�r��tP� �"���\6�E�5��]d��
)Eo�	Z�d���,mɊ��n���pe�[;�h,,�{��rv�z��V��o��YMq��_��+n���4%�#1�����U�%�Fs�jA[bdr�iF�fip��)���^���ܜ�/�\�[,ë��
�����h��+��.�BI��]d��
)�B�ۛ��7�����Kĥ�X�YY�A�[D�i�����.��/��";k�PԦU�Y$Z������������/@16�E�J���I@]\_��n(	d3�סu��}�J@�4��h��0b���/��_��6���f���hW��FM+�4G�;n�����g�i�ҜW"���M[Q���b��o hX G,	Sv�q�QV��խ�d�(�j6�.�;	$ @����E��G�uV��Tv�|y}�����=9��<\j�UG��E��i���Ţ��I���X��H��/�R�pM���má�oL
���b][���I��@hV�ы�#])�ㅴm�7��CY�v���	>���H�E��G��:+uR��>;K�w��?��H��?Y�����K����$�˾�DQ�U4��!seeQ��:"��h�P���-74�p��+�I2w4;kY}��S� OH�E�	{W�].j���I`RQ� �"�����E555�^���3��=��.���빸6V�R��౳��˗K�V���#�hyKmJw���'j&�Ӛ����f]"�I��{�<>�UN�<��4�)�M�81�� v%n��'��b��Bh)��4D�k�,+�$'F�Q�w��\_�f��8p�M�J�|�����G�2�4�����A�`Pi4	_���XuJ�f�Y���q>�E��B�Ĝ�}O��.b/���6*H�g���RS�E^�T|9��EuϾ��
U�~OC�9���HgE�Z�.�|ݠ��ڊp�7O�H��bQ�Ǫ-�!���m�.Rh�ӫ^���3��	���c�ƭ5�mW������Q"	�v�v�뗇�l�
�CX���Dp��C���[V��E����iQq�HY��r��K���8fk&6�����׀$��8����� /+?k7^ݨ�lӸ���]�����E���~�����P��⽾�|Ӷ�nWs�����:]q��|�<;_b]�<-�3&���ޛS������8����;@���P�ΒWZ=Y)�"o�]��`���E0��FQvvV��������~�����ϻ��o�]��<�Ɨ�BD�>��F�����.������v3K�b����ӯ��~p�v�.n�JQNP� {ɪi�iy�q�	3�T	(�%U�^3��h|P�����}�Ib����LP�fѽ���#���6+K�M����EC$A��E	v#�������C��4^0� ?�߬��?/h�JQT   3�����]\�)s�H(8
�q�O���HM��]Fs�ډ���з���m3-���c�\S�H�$:co7J�0�?������	
���E����9,�'����*L��x���\�E��X���nivQH�	鋋$N�C��͆������w�m�rY�����
7��G��6��0ӨO�H���3-ގ�+��͙�MK��,��E��Ѓ�n?r�1�ؘ�`�����z�j�6.j�C}�G���I��:� �7��k��] Kh��3�B� b�!̀�/��_���f���E"���H7�4�Hߗ��Yo_.H�ghI��
�4�RE.h�E�����ro�!q�F���F�o�N��F�>��"(7گ�Bhk�r�A�5�F0������������S�(4�v�����H���|p�Q�q���kaX�ܐ�e�����{Q�Uyk��T)<@��L����"��T,�����g�i.#m	�؜����K����������f�XS�X G,4�:�7}�+ ������vUG�ea�$�x<M,�����C�X&~P��Ը����.�N���4&�i�~�5����������?RJ7jģ3�h�uGg���p��]F���t�c,�(�"��g���۷��pm)z @���L�v���IA6}:�i�:���Ã$�Hn���/:n�"$�n:j��k!�LJ  +(�7u(�El$���Q�k-�2x�J�q��AY�A�v��0�t��]~-�j�wľE�EDO����51�a'�tW(�F&��Jg��5�Ltj<!�.� �"i�*X�����_���z@:�^�|�Ai��z�(�҈4s�i$��b鵴�/+����Ը?���Z�.�Y�2ضK��莞/߻�מ������J�0F�Y�X]��	�Hg��ܬ>Ը�U��
r_W�*�b?���౳��˟?��ĥ�j����]���J����������%%�qS�@�wY��0�E��.j+v3�%�%��	['s��z�Dj�[��iie��%T�v��~,.�Y{k}�ӯ�V�~��R\�:r�zH����e�S�M�k��Y�H�C�M�z�jx_�#F�>|�Li���=� ]���իV�gHRQQA�Ko�@��_T�_	�.�fݬ�v��w�zk]�Ӌ��\ڿ���N\lo͊��svQQ�(��"�Q���[��.�>��܆�Z|:�\k�,H)7첗c����z�D�~u�*�q:�%�p��ElN�]��l�W����.���꩕��T�����F,+�$���eeerEZY۰`��F��>�\�4L�7�Y$W-J���vD��f���H������xW��S����$�"@��)�Y��p�+�m���W+bA�pX�A��H� �[G�NU�m�}�M��2ʚ�rE=ᆽ�|��
9��OnXOh��wG�13M� ��1y�v~uz��c��+�>��PA��1�
�'�֮���I���z�p$�h������/RMM�.�z}�ח�b�l�m�9i��,�Q�+V���j���r����UV�t��m�,�9�k���(,��˧�^�9(^0�P5�5����[���|SeV�9� '"��t�ψGB�p$�e���<F��v�MW�>?5��;���M�t��@H�����F�wM�����O�\�ld?i���L�.ʄ���vmrG��(1���:��g�c˱N �u��#��|k�KӷU�A�	��zS	)v]aV�8�Q(5������$�xeQ�)4(_h<��2i��>ԍ��[��<-�]wE��X���� mt�֦|O�>=t��C�!?�{����XE�"�����B�K��G�n�Tu�u7,5�mO��LO��m�A�|���k��I�/M`59(��2��T:g�ЦM�u��u��!i����3f��T���Y�%�< �<:|)�� ��k�i��ݰ�x�i�j}��vۀ�����D��a=.p�l��O�ݡ�tf�K/�t�~L�6m�Ν�Ǐ?u�J~��6l�0k֬ŋw�������I	{�o߾�D�ǹ]�v5g������&��n"��)+�aSӦ�ݰNi}�{���Sk�LM��m�Y��w.h^�mWut�`��G��L;�χ1�v�ڣ�ѻw������|���'M��c�?1)�k;,�Ç������֭ۮ]����?����1	��~�a[���m�ݶ��[ft�ZԨoܰ�j0}�{���-�p&�]�6�8��.#XJ}:�1�����ؑ�Ѫ�ݻ��͝;�OK�5O	gE=z��Y�&7y�d��
�/_�ob8W�B��"N�s��or�֒*}�uP�1�#O��}�qK-��h�8N VP�ES��Y�8v�!�q��	6"79۷o7�í��qS���TZZ*�Ecǎ�+�Y� �	��
s?�a]�8�z����������f��5=�s#WG(3�t	?~+��ҙ:u��cذa���bQ�0 �B�~�:v�XTT�o�>$�;�K�.����zҜ���;l�!�Kq������hd��J�ր�@�膵H�7nX4�>��F�[8��	�.b{p� �҉�[�nb�%���LI -���g�	�В%K�xtO>���F�����G��w�E�o�(Ȝ���-[v�y�!��ٳ����bݐ!Cb��J�<�<C�nXϨ�>A�t�X2'�	�.r��k��[�H;ޯ^}�֗{�y�����v�49�Y�k�Y	� 	d�a�M�/���J�w��i�<�Bૣ'w8b^���Z��������ѦU\�q�r�07ZyQa����"�1�u)��E�i�W�N�gC��=���S+�M�觸���a��uG�2�4?7��r��v�����uK�ee]7�����lӸ��2e\��|�0ļ���=��j�Tq��]Tu�@@	���˾?�}E}�KZG*4��2�qn]7���Y�/S�M���ut�����lӸ��2%�"߶}�mﶷ��=��z@ɥ��%/��W���.**%�_����z��=����.-͓�C�p���������2e�xYYG�ˊ�6�[�/S�.�mh��`�|Q�
s�jjj�K���(//�N_<�nUz��rEQӈ���+��8��t�ח)�&���::\V�x�i�z}�2.%�6Q7�;�cR�v���ZO[B3��"C>@
�5V��j#.�ˤ��\l�ѵk�iӦ�C�m��ްaC�
��{�ǟPX+  �5�E>P�f�o�B��'�'(5��Xʏ7�%��F<H��޽{��'���_�+�ucc"r"  �+�E��l��H���o��y���nEYiN#���Ǟa	�׼�i���`��hf�����?����OL�歧O��ԩ�W��V8�y��q���"s�Q�'Ovg����ڍ�� �W�,߲�C��c2�H ��k���ԩS-ɀ�m�СbT��G	��h��޸B���FՄƱ�6��{�G�N��K�v�wug�<(<4���n"����,J�L�0Nƣ�!��ƺ5�B����CAo�����cQb�n�v�څ^>�-\�x㍆��!,�xif͚u��7cX�4�44���88�s�	�಺����|�͘|�ӌ3`��26\Τ,�+���7����C �<K�.ݴi��{III\���ك�0��g��I�v����;;��2�3^����U�(�#����b��'	|�[�:v��|��_���W�A��0�YXX�|�򺺺��������_D���|�KL��-�~(G���}�իםw�):�p�����+�I�޽;����u�/ݰ��@8��֬p���۶m�a��u�]�u���P(unvc'�����`3�j�Bx�̞yGU ��~������QԊgN�HqYO�q�y���4h��yt:.�Y��y�@^^ިQ�n������w�yBr��JKK��h�ر��qP��(�%K&L��`����%�fVe%����ѣ���J�Q�k׮^�z��?�8;v�@���Euu5�Ǹ�p=&|b�}�u�R��w��X�P.Ƙ���  N�N�tj���iqq��V׶m�����������G����!\�X���e]v�X�c�Ev����6�Ρ�t֧4� 2�acVfa�{��$��(sE��|/���r��Um���]�t�`�QO��QL<������W���hذaw�}�w�� ))	
8�Rp?.����	`�mѢEh�p��7,��bp�����<�[���G�i�����tú])��`�嗸Ma��uaÏ�A%1�ԧO|�\A{��5�Es�΅���y	�L�vQ��<�\Oș~��_d�kc8g���bP����p�1+,cR���\�����'K����yP�;���u*�+��】���t�T6ڝ��XD�l�2<����>��%�e���a|�!Luc~z��'��EH��s�����1��S� 2`�M�S8膾��\(�E�@��.��!�8Z��=�1<��߮}�u�RW�ͳe�ؽQ���7ɞ={n��[��0���q�Ɖ�b^�i���	�%@��?C_Z��a�)Ư�	E1��Y�1l��#e�\�����I`de��u�B��"N��R��-X�q��{��IV����-�+���;v������>�=o�����}�r�ΝO�8!�!C��S�/ƒ�Q7��[7ʂ9����2l0R.�e��N�]�U�����,��<e�\�����G�d	�*�# ��w�B�ٳg��*����oV|)�����m̹Nk֗nXh��u�ǻ;���
´I1�)�^t��.����Ҽ1��lR=4>�b�p��|�C�0[�	�.R_GjIh�k#*�F���ۍ�bDܔFeb�ǭ�"*�R �! ��Ә �/���R6]b^=g%؅ӫ��.��\�A3�h+��N�*���kc�_�~���؎M�YXMkx�1��|�]�����1�rgsLx�    e	�k�yx�����0�p�l(�b��g_{je�)�<['�_Y۰`麉#NY���_9�9 ��eq݊S��͗m�:9�m묲<%/+���5�m�^_��K��"6 �J`РA3g���\X��ƗV�g:   U	�.RU3��H@1�}�QC(�_�b��9�g�QLX�C$@$@$��E��bj ��%�駟"쬹�Xq����u׮]Y��'�	�ݰk֬nXf���$ u��It����씊vQvꝵ&Ȉ &���K�˓I �ĸa�̙�q�F�a���ŋg���.��V�ؽ�ud8ީ�hjW�v���QR�ӧOc�!1��`qJ��B�J`Ϟ=����H�Gbܰ%%%K�.E�V�\��l|TQV�0�]���_8�y��
h���ɀ(������d�D��^(1	dF a�����~��t��ǳI�4��ͫ�� �򉫌���)�8[���K���������.��Zx���7�\4���}�o��ԸY1l�:c�8��M���#�W�C|�q��%t%��8�H���U}�%���'˷l��Ѳ��_	`�Ϙ1c^x�4Zv>���������|��U鬗�p�=��C�d���3q�;��n)��!t�Z��ǘI��RH � �"�4	l�Z_ih��/�;Z1�����K/�ٳ'�mEYk׮]�z��~����j��p��P,�o����_�Ի�[�"ͩS��~��ѣG��|饗>�-\7l����
�`$��r��_37�ŋ捹����_��z���0� fUu�ڕ�L\��rq�8^���%Et�̟��%@��#b��
/P�^�


�m�6v����;���ӧ��)���͛�����r8����x�� q�(�ѣG:B�vι��i�F��I�H�11n��\�8��|̩s�Xf,��o�`��0��O�0A�X,�t���2" ��|>�G�6m��Ac�M�6���w^|��N�:�M�ӟ�����pr�����A$@$��7,V�7,��460�+�^�5����&��&}���g�ڙX�*^x�xbFw~���1f���x��h`�E0�0�"]v�e�RL�s�@�%%A���2�, �#   P� �"����lW��#'W�ܩl4f��vr*������ ���ӭ[7L^�'�|R��p�B�+�����c�af�������ٳg�/�; d��� �p�}��9�̙H�H�H�<I�v�'�֒к��C�p|��Y   �� �"[q23 �, �y���3�]���tYE  �C ��\r��T�N ��p�l(�b��g_{je�)�l*�?٬�mX�t����,��ꯜ�8� �>6��m�,+��M���.}���X�6r�4���Woeۖ�0����:��#��6�[�/S�%@�����<����C�z}���Yۮ{���Ԉ����8���`ZK�v�������ˡ�/]�
��#�Wl.'��1��U�V��G����]쵈z�F�ƭ4K�q� �"�	;��ʷ<gk�z��xȥ^o��anۍ��_�<�fˮP8�"�HX{����0H�m~k��.*�7F��(D���~��`���A=:��#4O3���j�wRn�ݰ�,��y�aԄۜ$�<o�aU�8��[!S�N�v���m-PA����A6,A�q f�x#w?
�E�6=�3m;	�#��P�18
�i���P�{ǅh��}����������E��Ȓ�b*hN0��Om���*F��Q|�9�U�`ўr�vQ��ݰ��8�*4�l��v��[�jv�������?�ҥ����}����j�Hq�.�?���o�/�95�°�°�`��'�_������P$''��J$y��*�U��q�}t�HL��L#��{�D��햡|y*�a�o~��/j��ےp���!���.����o�]����]$h>��3�.f�3W�2�"�`]���E��M�0<E0��Q����q{m��7v���E�}���ٝR�#�����9�ң��It�R��T�n�^�Oq7�Xm��M:]q�DҾq�*�q:�%6r� �t�a8K�����p4�ْ����{q	�Gn0��r4OH4��>g��܀�/=�!�#.�k..Zw�;$D�#(���σ�Н�z�@<SmyZԐ�-��u'Z�k���\y���˾��x�Z�1��ư��v�/��΀����������]���!�8oU*�]���,�ȑ#���,^���Ue� `t���̍�C4��XH�����w_ZO2�_��5���@����}}��
a�^'�w*��r�lԇ����fv^�n�`�	����J�Q�Q�(���Ʉ4�/a�n�-Oi�C��E���_�g3�E6evf���+W���qԹ3VU� K��zA^�.#���`k�C�
��.#�_���_��mV���i.#ݷ�40������ɒ���}��a�b�A��yb��UY�}��Ը�w�H��G�T�*XP�)s�f͚1c��8��㏋yt%%%ÆS@F��!�~�>��q��Cl��>}N��F���K��H�A��fZ:}�!�h0}��C��j��UM7,ڳ������,��a�ոt߻_5�����
0�<�v��f�;jf��`?S�s�b+�#=��h����ز����]�<�&����+�/�\��U.���9��^�x,]A�SQ_�N�NW��䴜�o�u���m��n�<t�G����D_��=Ӽua����^�B�K1�rj\�|� �El$@��Φ��>��/���*	���( �a�|!8Z�Mwy��n��d��a�#�P�UwW��;7��W���;����^�h�ǚ%� 	�A@�&�h��Z}����T�˨�D�E�-�t�Q7�4OQ�yJV>F4��&�G4�B,h!��>�����I��_��D�0�h�	��C�kw}��{nX�5�m������x������%�H�M@�D�u�C�.�6�O��;"�f�S�ݗK�ګ��7#�-{m�̗�ܰ�j��aD�'�n����\��BH�2&�w����_Ma�K�MѵE�f�'��Vs�4*xb}憥Ɠ6*�i��w1gj(m�3�ɺ\w���w�:+�Rn�}�Տ�{�"�:~Vă��6_�<$F��y�;�um�!�},jS�ܰ���Eu����]��ɽ�a�����UJ����g���ؽ4���2-�o�(��]����]T[[�j�*��-������\:h�E�U�� �.��?t*��y�j�\��g�롚T�G:����
�Eҩ�Y�zqk#�!��2*?hy�1Ƶ�F��T�&�b�.}��>z�+)	�?M�x�'�,��:q��)#K�[a�+��wU�r�/]����<�Ko^����3��Z�Ǝ+<R!p�Dc(�C��T�eKZ�E٢�z���_��
!�Ba}�Y�|�������EuϾ��
U�~wCCT���@Ց�J,�`M�nP�|-�R>�"ڊ�[� �I�Jo�I��l��K+���^R��k�v���aS�f���~yh͖]�p8���س�h�`Jؤ����vQA�1��E-�*��2�	�/)ԣS��`~��KK�Mm��lԿ�:Y{_�MU�J�vW���n���G���!��S_㴋�ֹ��	�H߭<��4�gBaL�9������J-m��뫪������ʢ�C��a������-�rai���ZU+��#��'u��~̔���Vm���m(=�5�E�&����x۔-7#}������}�����p;��e}��[�[�.�����;]1�}�Q}�FCC��z�qT�j��� 	� 	� 	� 	(B�v�"�H[�hl�膗��뛔�H{io��v�;����i&47mV��q{���Ʉ4�3N�-�'� 	� 	� 	���.���AZ���=��_��1��s.��A�u�\sqѺ����HP.�S�I�o�	� 	� 	� 	�@�h��N���=z������n���:�ո�6��\���h�u ��F�A �β��SH��H�H�H�H@�E���T����C/���2�f��M$<$�`��2r�%L�u��f�i��2��5�����ɋ�gS;`6$@$@$@$@�`<���)p��M���N���7x���}����׏G^�~�xc��yON����F@���z��_��0h`"�U�:���ίNo�y�H�b����ӯ�|��n�]܆(U&@U����Ŵ�G�|T�Tc�t^�r�dc�1G�q��Ը�̥ge����iIo36`�F�]$bwk���^|�����o��m�L��~��u��p�Eg��i�UMK�;��O_ �|�ڟ�7���m���VS�Q��J��#U8���%~�L��W�9՘�lL�X0��vmr%��" ��2WM��R8�
\�2:�N�CD4jS<:�����H)�\��΀���4Ogй�X�����>%N{SYE�p�LEUʤ�v�lj��~��o�{���ŝ�F������2WM㴋�5[K�L�/�#����g4I�˨�D�E�@����<H�ꀙ�J`T�Bl)ˎ���$����0��	P�����l~�pl�F��w�j�{>�D�1�}}\�
j�v��0�t��]~m&��R�[�j�)��x���9��]KBN|i�I�e�xTe�i�z}�6���GJܷ'�_�R]p�O`5��@�"�e���i�����QS�-z�a�����f�H�ѝ���Ѭ���"�)ޏ�70���Z��?�طu�*}�ڌ+ƶ�1B�epM��-��i�1x�����4���i��� 	(J �����w�U��b�@��d�h� �F���C���q�g|Q�6������]��F�z��4L�O�8ƒj��:P��VoF�c���O�{W�u�A���\�jj�v��m��� 	4O�;�HP��*�ב,	�6d��Xn�ۿ%��D	Y��b.se5N��^�37 �	���LL��Tf� ���>ɒm�'��\��e�j�,׆	-0kYY��.��K&"�E��W�8��,�X�uT�uVٖ�m#�4��aE�%�B2~��q����ܟ���~U �%���-�O�	���v���J��3$��0�4O�������c�]tdK�6yݺuK3#[O�h�w����^����*�~ֶu.Uik��43�m��y��K�|���5�><�q9n�n��	�pC��ݢ�kܸ�U�xP:&��d2�x`Q��cg/i�?r/�	O��:zrׁ#�}�dm�������G��*)	��rGN�LG��#WQa����b?,���r�˿ih�^[�Ł��-�B�*mǥN��en�r�f���!�RJ��݀o��jI㴋ܹec)��<�u}�$�����_Y�B*.�]_�3]u�@@�]d0�}t��ǔi�si�W�#�T9��n�]Tu��
2��J�A��6x�ۮ�U�8�SS龹P���X��_d�%%���v3�a݉��0�nL�B󹃻��Ia�J����~�uuO/�Pri���&wGȽ5+̝��Qr�E�u����n݃����e����J����H}U^V>Ɲ&��O��vJ�^��*]A�������t7�ƭ\Aq5N�tLc���3��_ن�	RcZݜI=�se�ɲT�lN��$���.���꩕��T��������J��TVV���ɕ���mX�t�m�JoS��5��J�ZMU�Z�J����������B@Ͷ��ܹƠ��QY��ힸ�[l$ԸPq5��t+�3���o��p5���!i)�J}�I���R#����{������"C}�k����<Fƌe�JVV�B�8T0�<�J�[��m������q��]���B�[�@��(�]�=&NB v�����T0����0�*B�>	����&ΉC)t������-I�6R�*SЄڪL�"֒�mX㤧�E�PT�j�۩�.�ԓ*�4�ѸZ���	��$pa��_]�����D�i�IL���IL ��FQ���4R�eDU��t�Ue�I��m#)��^o�85�*�lKs��.ʶ�x}[rU����E�/�dJ (<4���� �xE}E
9���TeRF(�J����m�**��j��J ���\㴋��8^߸.#|9��K/�dD@wv�ke�f2�-�ɍ���'O�������S�N9Y�Sy�U�(�#��ܩ�Rȗ�L�*���*b!5ۆH�$�o�85��TS{�is��.J�0}r�]F0��;J�#S�H@pzݟ�����ңG�Ι3��7ߴ�~�AϘ1�СCve� m!�>�N��4�t*DUZ���*-V�z2���|�6�qj�"�T�y�is��.J�0}r1.#L��$��1�*�NO��ٳ�/~�0Æ�4i�Ν;�v�
��iӦ�#̛�}����ӧ�F�$�K/��R���Y�f-^��{��O=���8�{��$R�MԼ�T��V�UZ�H*��6,��Q۠ƩqKRM���y�5N�(�����]F����Nc"��m���`-Y��0u�u�k�.��>ܦM���]�v���.����>}:~z����o�~�G�{�^�~}uu5,%����7~�xXY;v�x�ᇝg����J�݋�]�ɜ%AU:�ׁ��6R���en�"ԸEPz2j<Z�����8�����"�����tiXt��Ž����/>�%FL�R�\Q�`tF�����w���3���/_����ի�� o�g�p=����t�޽��h�ܹ0��M���G�.sCoC_U��$:�����$�W�ŊXOƶa��o�5N�[$�j2�?���8�T��t�������W�M{}�}?^�JzaW���^�b^[�W�$�\AX�>�xGV�f�p�=�؆����ˍ��;v���W_}����O����С~7n���@���`ba�}�2�$�J6���md[۠ƳM㨯ϔ�;�xx��zk}�ӯ�V�6�
R\�:r6�TA��G�}L�����}��H����0��s6^�~۳��?��ߔ�~NH�3������?���m۶���w�nժ�СCa=������y睇�E�'���q8y�_������?�<�G"%��0�^{�5�*R:!9�\Y۰`麉#NY���_9�,��*�m����w�Ui�"S�mX��en�"ԸEPԸuP1)��4�{��]�vKP�D}����uuO/�Pri��K�ʷ�f<E�]TT:
���~��k��]4}thi��th�r�4�����z���3x�`Hw�q�/� ���N�T�3MUZW�⪴^�)�6,�b/�:��R�ƞ��g){�CrՔN�(is�j���  ��狪�������7���KD���PJq�6���1�0�������7�l����Y�f̘1�:/��"�*�Z5��+ޙ�*�k\qUZ��ŔlA�.�*������-�Y�^�\5�ǽ�K�O�`&HJ@D��6���w|�|RyDL|B���C����a}�R������J1�bA�8T0��@�G�T�?��D-�6���r�Ը��qH6O(�v�C�w3[�*����B*u�1qNn�HZ(5��XB�7�%��F<H�H�H�H����Z}���E:�or�%�ڑN.�tN8э�(+�iD�Q65 ֕H�H�H���]䏆��c�J�
9V���+�+���1�̘H�H�H�<D�v���WT�١���.��z����F�n�������jy2{ė�~�ذǴi�<Y
݌ b�v��:-**:t�>�?�ԩSqQ� ,;��7��.>��?`3��o��ة,qc�G�Y����y���\���f`�A��Ikm<��t'�"w8;^�"��,:<䰍&�n�y�����Uͬ m!�>�N��4��d͂�������p��,�����'�M7ݴd�����>�={vJunӦͺu���<|@ //oԨQo������ի���*�q�} �[U�}�[�JI�޽{��'b0]�w�y'�P[���i�� TN�M��]�ӟJKK��3gΛo�iWI��f̘�� �p5�D��_��׼�i����}!��Rt�|0�dv�?b\
�D����)sl��x�b����sOҲ�NP[[�q�����[6|�v>�����*�����>}�`�)Ԯ[�n�=�ޜ<y�NCq1Z6spy��[�����s�>|�ڵG}�ѣG�8�^ڸ�ŭ u����f_���q[�1M �|����C̝�hN�Zȉۣ�����Կ�[�6������;����>�j�*��~�z�S�N�Al���E�oK�G3�4��?���#޸8�.��ռ�>Y���J��z�R7幝I��������[D��oh��)R¹���;k�,<��w���SO9OY�˸	7u�����HCC��Ρ���;�գ9��$�q��&a��nuu5Z��Ç1��lLz��z���!��kl����ր����M��+.Ü]�v۶m�����$����4�"C�Ow���g��;�9�cl���g��ٳ�ȑ#��]�v�2G��P���c.mlr�6#nW^ye�} �wr���˶!�R�}�?�O�>�EG�j��0�̊wwt-�#w.���4NG�ģܹ�9�x��d�g��?�qKB��z1����} ߈%���b���#.�E�B�����Y���70`�����f�Ō �K��������AXY;v�x��] [H_U�oͅ���c~T�w�^�x�;w��E�1c|D�@�
��=z�@�c��S�*��nEE��pε/�"W���ɦM�b������z'5�4oW�$�Ư	�#B�ɘDg���5�|�r�:��6[�1��^�z8�ʗmCN���<��Et��Ex������ҵ���%|�[�:v��>_|����ڒ����cǎ�n1����������RĶ\w�}�3�<���f��p��|���϶��?�X��7���uʔ)�X��<cs��n��G?���O?����T�eP�,-.��[���^8��$֚܍z]������S�*0Rw.$��_1�"�{��-ƺNzp��/ۆ"�>�n�����6bV��;�-��y�e�Ph�����DGq����qU��Oƅc�ూ�;i���'��I�Fe<�^}���������Nj�g�L��	&�W�lqq@�������r� B�iժ��#[ט�h�Xɀ��~|[4 %%A���鲴��t��	&@���[b�_s�5f�ʝG�2[�����v��U���ySb,�5��W< ���|ic�]����@�Y��mȪ�1�3M0�Y��1f��������\�j�-e�N��������2��|�~��a�<.�}���{cH��1�Wx�} k�0�����Z��,C �e�W��Px��mϾ����~S*�9Q'�.��}���Xi�y��m�b�8f.��es0��x�W^y*?AL��s���/����y\!"%l-�L���~)��y��mX�t����,��ꯜܜ "�c�!���#�-������4���WȠ}�{｢]9*�5��.[7a���ח)ؖ|�JG�g�\qU�΁m�:R�j<�5�w��(ǋ��Ơw?£��Vy9�[H��K�)� Sb���a�i�J��2dٲe�K����|�V���b$�J�)$��o�D$_���:gQy��o���%{ѵ(�ނ�-iSm���r8Y^�čǗp|Y�o�����=ʽ�4�K��C��4&I� �c�\�^z)&�8=~���<Ç0w�����*� 	� 	��+h��9�
���Ĭ��#�� 	� 	� 	� 	8H�v��p�5	� 	� 	� 	� 	��'�.�($	d)�A�͜9ST^D.��e�r�Z��G�8!8����Nl��56�./�e���+/�j2&T��CVU<+�[=���Oq�+u�.RJ��kU����l�!lɍ��� n��>��Qcf�w�y��W����P<�G�!+a��UUU��q�FD���cKD?	�aŊs���������[�C�����~���fs����G�) �)����|�+�v�R���0ύM�Ѧa��曶��v�֭st;N[�d&n�òs��1%�#�r�J.ZsS�e��kɒ%����A [�̛7�y]x��C�	jGA��ݱ��5eq��{�C�x��Ƈv�jI_��k�ߴrш�{�վ]SS�~F��	iƌ� M�6�a�"�J�}`���C�ڵ��W��s�>p�_�}�6�Z8_}�|ˆS�"ӪE ۆb�I-�(�5������~#-Ti�Z˃��I [�?��C���ܟ�6�
}b�%@�Z�W�4�t�M�f�2ϬV
�"�ԑ�0�V����44D��3�+��Ǐ�0��*:y��k�bߘ�b�������p%a�SD�;w.2��?����G��wS�`� ����[9'0r6�`���p;cGi;�9�澵�e1s	����q��~?	{7+̫����u��ܻڴ.9�J�9�8E�u&�+)@�P�S�KJJR:ׅĴ�\��"�yt��P�^�z�Ͷm�Ǝ+�*�ӧO]]]YY�ܽ{���{�5����5UXX�M`�O�.]��%�1E��i9�����£����3�T� ��=b�yܙΔ�\�% b��;x���-�$�ԩ�1�
O�Ѿ���7,X��Xt��Ĵ��х�%�ٳ�M�D5�n�
{	~�믿�駟�P1�K����_�I$��n���'�t���sf���0s;	�3=f̘^x��c�Q�{���2����ͭ���*E�)�
�G�V#
��R�	�K��`L�ax���*�e�� }bq��I|���
�f���1">��sA��1�E����娨���E��>�S�������Ǜ�!s�7���˘P��K/��������ߏ��G>���wߝjq)������SYYS:���@�#8�xj�)�R�a�i�+��#tjL�_r�u�`}p�yp���e��Z����&���Vpy7z��# J7>���v�w[Z��W��#'W�ܩltyy�C�	׭[�e˖��s8���_L�ÁǞX>�?��3����kA8�p�L:G��Ȁ7N���3 �C��ْ 	� 	� 	��W	�.���ʭ�A��ΐ8x�Wm��!   [	�.�'3#    � �ETE&    �� �"[q23     �]�A�Qd�&555�`#�Ϧ����T��4j_}�6�c陜�tϨ�&A=�� ���I�r�ѷ���`(9
�X����ޟZ�oJE?)!,��3D�bkl]��(�;ȍɸ��a��uG�2�4?7��rrs��BkF���Ȳ��Aݤ�%��w��\_�
1����V���d����[�mKʪ�%�����rԄ��6-���*m�l��en��E��j���t��q�R\��.�PŔ��E#�Cx�M	��#v,�{�ADo����.J܂����g_�@�F?�����sv��ÎUA0�E���:?'/G-[aU�6�EUG���GȠ�*m�p��en����E���!���v����ƽ�q�E�܉\�TY�[_}��ؽ����?ߩS����I�A�Ⱥ]�����Ck��
�áH ����G�?�m�[V��E����E��~0�����`���A=:���1O3���=�oJ�����vQ��ߖu7@k��*m�l��en��E��j�)�t_��q�R"��.� P�$
�E0������N��.���ݸq�Dg�]d�.
G�H�1i΄�g�g�>�H�^ʥ�����V�EWTTt��J)b�b�eN0��O�l���*F��Q|�Lq[�*���U��
�&`۰H�7mCY�CJ�۩q��F&ɼ��Lj�sI�98���΢	&444�(�G��Y����'�q��C�4��������z,�_�����ˤ�Γ��].�\��C�hh(�G75��*�KS%�R�r��m����MB5�㦉���^SpC�_�7���-�55��# ����bc��t�E �}��!܂8�{��{��I-�v�@�$��C+'�P�"�=���FL�ˁ��՗nuh����~�8EB�:���hb�0���xվ�R�U�>S{Q��^��
S�m�2w�I��q�P��n���W��D㴋,�3&�D �� �1f̘���6��o�ˍ,��D�4��4�|#�{D*���9cx��\~�v��r�\sqѺ����HPҞ��+j$�R��\UU���0�����JTm�̝j�j7�`P�!��<vc��DTָ�G@r�3N��f�f2��	
Rq}Qb�h�=h9��
B��HH_\�=��q$h���&��{KO	ś��g&h��t�m2�4��6�P�!�g��9u*��_�k~���LUJh�*�^�N4�5���ۛ��7�����;Q}�yz��n�.�k\�G@�3�Ŗ�h2�E�C�()+�9��N�����|�y}EB��G�B�E�N�<i-�L�y4�ȴ�H3��KYU���0�1�S�J'�j�y+�6x�;� ��8�;��������m�c�-q����̍�B]ēZ�	��(�Xj<j��"��L�d����vQRV�q&� �-"����yH��~��_�]��齓�����F�w-(E4���/R�Y$���*���*�����t��&���y�y������bR�n �y}�����=9����8��w jY��H�q�/r�5�$P��6L7�Ĭ01UL_��S����Ch�Z�_�m��\.�YqAB4����t�E��FU&i��Q��7��d���e5ED'hK��S��=��x�'�8�"�:̐<L@�
��z4�lŦ�����0H����΀��Җ馈JU���zH��7+��lkjjZ�B���'�o���j�) ���]d��1	d�1��#ҟXH�Ƀ$�Hn����DwA7u�M���b�*�6�����Ŷ�mmCA�k���#�:\H೻5�����8�"�7�P#P[[�8�8�͛WSSC(�"ċF[P��ӭE�o�f��)2c�*-4o��BERK¶a���چr�n�M/�p%	5�0f�5�xt� ���wadYI�n��$�w��\_�\��$8r�4�}�O�X\�u∁SF�F7��̈ycj���U�:�O��g"��Kw�UG*J��������fP�i���)�������������^�.��^JU_zL�իW�Z�J0���>|�t>�����.���2��]T��kd��M'�h���!�Wqq��Hg)q̚�v������b	��gI��VWW�{($��=Th���\U�YXUU%j=b����Ėǡ���Ť�@�-D�+ݮ��e�T�L��좯���u��9����^���5�ֻ��H�R��܁@Qa�����[��F�G �"�-͆��vQc8��/�ٲ+��[�h�d�?�c+�����.�7&�(cLZ<e-�(����ѩUn0?O�YK�_��=􍅿5;��M�#{gJ:l���c��J�����#zd�8��]�NQ�J����l�5�t�e+b����Z_��+�%=6c�m6��E�n]��1eb���#�E*���2�H�|3��4�gB�3��x�~/���>_�ao�,���,�=D�F�"�t̡�`���V�0�����T���V\���>Z]�AwB�e��3��:m��J5��6�R��b�U�ZQ�J����f�i��~��;%{�k�`5��yk]�Ӌ��\ڿ��OϽ5+̃˗���+R����n݃g���eb�>�:J�q��#��"�--���o�/�95�°��'���1�2ʴ�T�7��y�4�Ūxu�����4�� ���)�E����������]��*U{����T��h�ѩ�B�_�6�u�"���=�t u��l1�հ�4[�%�E?_T=��ߔ�~�vxlO��U��E����R�+k,]wۨ��ǔ���4���w�?h��0�K,l�_��L�0<E0��Q��ι�Ӝ�\�SH�j�]��.��Q�{�����}9S����.*w5;����R�dwj���E�=U{���T���M�H��ԕncQ�.R��W���.�1,�.��zJ���u�~��Պ�Ev?�3�O<nU:}T��ME����H�G �Lۊ��KZ3�°��]�9�`�v��X�do��hш����Q�q!���K�&=V}�*�C�amA��"!�]�P��"eU��mW��E�&�b�ya�Ů�]��1����FcX�Hk梿��WU�Y��\K&.�ח�z}i.���؁*��?�@pM�>.H�ۣ�{n���D�B��<���d�+Zw�gE�:�Yv)6m�!�4]t{�3p,9�!q8VB��R#��D]��DOxʅZ>AQU*�G�ߠ�*-�<��l!)��Gэ���s��J��N&���M���T�⎎�8m��y���4ۤn} Y��x$$���k��v�)=���B%��	��}Z���k�­r������3�B� b��:��!�a��A�ϝ�Ex��׵���CS����R��Qe����-�"(#��{�Q�N�.%��1{.��(͢dG�ڈ�]��2v�L�~�]�,U�F��Z-�t�!��Hs��k��� h~3-� @����C�C�^
��C�Jߨ�jERL�b��{��N��)�o���*;��r�2z��tp���h��(�K.��h��h�t����F��"�!� �d�s� As���I�ڼX�]due��y	��ӧO��������kO�:e�A�4t��C���*�)|��Je�dE0�UiE�4Ҹ�B<}����Z�a�׋�aQU�Zl�uO;���tm�>�΀�6eO�]��jR,:�N�磗�u��W7��9c�=��/@48�T	}��t1�p���۶m�cǎ�G��.z��7aڴi�nݺ:$h+���3f̐e;�uY�)\Պ%U_�s��x�J��"t�h�v���]n޽҅{�)��'ѡr��ܸ\(C_)�y3u�(���1<H��/���n:jQ*tOQښ�]������;�iӦ���{lÆH�s��Q�Fu��U���f֬Y�/�޽�SO=�/����Sڕ�~���Ti�
)��J�8�i!޺�EO�7&��%_æ������I�+]�b�*����a�r&�"W0�R�0��:�2�oW��Y!:�"J�z>w�[��?��LCC��ɓ׮]�z��(F�=w�\|������p׮]p.>|���G�&M���Մs��޽{S��C�{���t����+�J�j�r�������tI��vq����t��UE.��,5D[�.�����QS�s{o�p�03=����X���[�W�^����m�v�����^s�5��`D._�ܜl�޽��vT}}���3L��=�MUfS����!>��O_�a���T�#?é�;��^��3���g�.R]C����_�����'L� �Rii���;�b�<E"�q��	�����$@����.h[D�c�be]K�+�5���]$>�&��x�/��2&��w$�BEEE�������ҥKee%�6���X�/B�W���VA�3r!Đ9����חw���]ݥ'9���q��Y��ei�v�,�,�,�	:׭[�e˖�w�y8��l�<x0������G̣����O�#���^��Ė$`"k�1�R(B���qb��x��e�D�]d?�^�k�v��
�x$@�#�t�!�_`�?(������JJL�%�.�u˚y� �"�j�r� 	(E��CXK`�����W���3�]�A$@$@$�� �"� i����괴�m-��C��Y������I?��\YX[H*�U�6>��ie[�e}I@	���������;�)!��B8�~�y�A~��~�����w�W+���t����`�6S���3��J��Y��7�9�,l��2	�$ �s��~h���6>���pqg�~ژ�7u�T���W�������{�u��a	c�!}g�*B�l�B|�P��	�#��?�����J
'&l)��:t�s���ؕ�g�9�"��!��fz뭷�:u
x:�ؖ='�㭝��dǚ�G��t���|]X?mD�¡%K��[��6h0h�K���lG�cU��*A�p�u��UD�@$�̋V'�;[H���nl;��/�8r�ѻ�pBrs�������q���//s�EN�|���׼���WF�߽�fEMM��+�J���^��>Y�eÇ0�����F���6�9�JNn��*P��*j.��07�tL\��������?�����/�R w�� [����>��#�/��a#����G�p�����ڃYU鑑u�C�y���F���B���ݻ�=`�dƌ}��Š�-��2y�d_�p�)ӦM3'�G��e�eN�ȡV�l}N�����! ^�V��7Gw���T�4������O��C+�v�`�Q�厁��_�_�޳���
+�~`Q]���3TA��V0��Ѷ�����ې�*��&���	O󹵵�}��ۈ���9s��o��jg׾ѩB_J��>��c�zN6^�v��D>�R���CT�l�ҥ�6m�{����Z�p#�TDqg®ç�Z�3<Jǡ�<F�氥�*~5�bf�(*�� ���ի1h�y��o������)�k�.��#�����9���G���J�K���\�G ��	H@>t��V&Ɠ�[+B�1�8��#�,Z�������o~��ӧ�����w����;������� �K��)_�
J`�*�����sY�m۶a�QhϞ=�{��!�l�F�ʈ=���='!|&-D���i�AYY ֖�~�]w�����|B����_3�e6��ڼw��v�1�ʡ^r�� J�m�����?����s�ń-M,?V�B��v��ꪊ�
��ѣ�����p�_���e��#�v�;����@F�&Ƅ�#��3�ؚ㋟�y�̷KK���>�;lFҤxrnN�NpA��K��'~��"r��g��\��s~+>z�!$��+Z����իWAAA\M�={VV�)���e���w���30n���o!>
���߿���o��<���3'��.[�~�a'#1�Jx#m?�{��m���3��$���#j~�Ϗ>�������]�I3��2W���S��$���#���3���t���[�n��+�{�^�o��\�_~���-�7���K�,���f4�_��ɽ�m��U�h�2�m���W��*�!R�</=zb d��8���.{��ň>���͛7z���:CF�J��^�k='/v��z%,#���/��������1���
�ٻ3�;yذaJ)�W��"q��3Ĺ*��̭���#���O���	��C���V�J�����2W�ेS�e$`�+�����T�rY����r����~F�憆��z�_�~".�}��烈v��ac��Ƞʉ�sq��~���/�k/{l|�E��A�����U)*%B;�Rl|3A?��~����J�X9�B�u���?�} ���K/������	:CF���KAk�9�Bω-$�V7|�p�B[�l��3���{���`��ep����n��� �I+�;|�4Igt�����K���t�.s��1aQ�EQL�5ޠ%`�;N����l����\sB/ &�2dٲebb<~u�C�U�9�"��5�O����q�3�"���Xc���G�+�r7G�Uͷ�w�}]%�
�8E�7���m��'�����6n�뉲`a�z����`ʪ)<Ui�^0�!©������>:U���!g�{Nf&>h!.��;w�|��	L�ý7vL:��Q���y\��Ch�7�a�4V.��V��4��ym�-�ؓ����z���'�g����e��"[�3!�	`z�12�>��q�h�w.��	��wE��R������駟�D�f�(B�EQ�)#˲<�B\���A�-C�#\�!fl�]�3�0��X�jcL8��2�=�j��%��n�Cc�B�Y�̳�����ie{�e���@�i�4���~Τ�]U���<�b���	P��3�wl!�֯�v�:`F F���I�4?{�dIM�t��_�%���$������O��cp�vjIFiR$@U�,뒳�d��1S���.��>?���E����ieK�e=I@A���r#���HTeв����R7fJcF����s�+���˜vQV�XVַfΜ)b��o+�ߊ�`t8cƌA���X6p���+W�{���ߪ�fV	�I�k��<��3����V+�t�G�]�|��u�$�5.pq&��|
�1�Դ�2�ǳI@�'��׋��/���Q�� ��L`@���K-;���M{,X������-{�K�	���	 ����1L&��9s��y�^����]�!eQT�O �j8�7�=t�ȑ�D$�3������J�z� >�/��� �Dxb6:#+?����:��c��Seլ�"5�B�H 57nĴ�1c���8�&O�p�����W�����=U
k� �o�v6���G��x�	��0�	�$6og��xXd�EVE'A ���T<2���C$�3X=��~���%�k�+�|����ڵ{�_�۷�{����r6��3�?�������u�]�&m�E�سg�1}���OMG�a�$@� ���W_D�5n\��"� O.�� Da���E��p����)"�����E�h�� �"p���L��̅�!���q�+�����{�Ӭ���6�-	� �au>�����7���E0:�S�1�ȓ�h�v�;�Y
	8K@<>q̛7�ْ�;	�����&�2G�F�B-����ܹsL���,���z��y���� �"w8�   �J�آ
�����Ee���~� �V92	�B�vQ*���H�H�H��'`̚�� V�y�3.�w?K�R���T�6	� 	� 	� 	� 	��A�v	� 	� 	� 	� 	�@��]��-��'    �]�6@~ PSS�Ht��{?T)+�@=f��S�4[H
���<K�W�,�#����Y.	x��~��O0���W����k�,+��MzE�]�r}}�Z..\ӭ�`P�T�l?��z����,��ꯜ��!Sm��>Ӹ/��זJ)��w����!ZE�qԄ�l�o&�ث��<v��v��'��D*��U���v�Cv��/�TI\�O��7��_�Yٛ���vժU��'RQQQ^^no�i䶲�a��uv�����S���Q;՞v]��?h�rq1�� ��Z��k(R���44�����`��v������������Q�.RE�#��6�EUG�(���R��E\ً]�+ݖ�]M�H��/�1\R9~Z�cKv�G��%�-Wj�){��j>2���]��U���L�|mG���5[v���P$	G�ZgJ�O�Arb�
�����I�H�j;�s��K����
΢<�4R�_��*�o~�l���myW�#�T����.R��(s�k�;{/v��"e�K�����w��P�2�p�<l����.�{U�t/vQ8G"��Hc8p&>�>����������b�L��tŕ�$A��.�����Z��ʅQ�}߫3�NAU*�G'T��C�l��$���x�+e)�K��"����N��M�g�E�6^��?hYlLFѩ5�*�f��&̡�Q�]־ק���f��c����Eb��f�/��'��"�����*�(��El!��E�"5�᪪*��������{�r+b�E��]����.�{U�t/�%��@��4
�S	u{�c"m����̚��!=ₘD�/u�(���w���d��)U��Pl��x�'n#���/�d�<�w�{�ƳE��(+��KRՔ]�� HF���\�G �d����@��.�4
�
hv��,�7�]����(;]F��H3���c�0��".rt�H{�G"�>�m�0Q��/k�T��C�]ċ��V�D��2O���^r2b��������|�� P�@��٫���������ѭ �.
i#!}q'�	]�ss57QnŢ#�7��]DU&}(�"�R��E�]��fQ�.�1�1,���g���>���.��*�����t�	�HL��G��Hq��It����i.���s�"���6/BnNt���dWuԭg�*�(X�B\n!N\�ɪ����K����^��M��<^��?h%k��L�N� �-"͑��[Y{���?-��fEg֥�,r�.:���*�WGT��C�d��$����B��E������W����,�I�gz2�|����]��I�w�&�6�w��cTL���>�r`�
"�6a�.��g�	�u����m�	U��P43aq��8t��tCf/9.�{�Ɋs�w^�n^��?h�qձ��Ε�F�."� �Ţ�YmӪ� �D�i�lG�<J�p��DU&Շ��T���-ĵ��e��
4��#rb��z���e��]���%mL@qD��Q��������NF�*�u��U䘿H��*-�A�T��C�9�wZ�"v�~O����jY�v��-4-���2� چ���� ��H ��67�FQ�v�ۊ��(���lpT���P������-�5_���{��|D�`@�{@�×N@lƠ-"�ފ�,4���2��_]�-՗v����$$��N���+>���"�[U��{F�56���j!�%[��|�K�e�U�y�FN��µ�$$@$@$@YF��d����ɳ��El$@$@$@$@$@�N�vQ�� ֟H�H�H�H�H�v� 	� 	� 	� 	� 	�@��]��-��'    �]�6@$@$@$@$@$��he{`�I�H�H�H�H�h�� 	� 	� 	� 	� 	d;�`$�v�?	dL@�u�z��U�V�zTTT><�:e����=���}��{鎾��0��TP��e�6XTw���K��ϟ��U:Q�Gs��4�/s'�����90*� ��2W�@��7W1+�6�����u�H�����H�*o,�m}}t���8p��;sr�y������vE�"�O]�0��M�T��h�6�(ƽ��<Z�'��<\��S���,"��e��^�MCC>���o�[�&l����.���X�W	�#I����=��jE�Pq��]Tu䲀�6�>���c�4G�v[M�:r�ä�6�T%�g�6�(�\�loq�7G/s��`��$��e-�h��lU颂j2����.R��Q/�n�ZG?�ֺ��U(���%�+���m�]TT:J��4���v��C��.-͓�CK�q�\�IAm��J{���C�|-�yX���u�;w�[��d-/s�bo�
�]tY��
��2W�@�HnKc��#������.���꩕��T��^��������r�"��mX�t�m�JoS�(j��JŹ���TM�hH6jS���7�"�.v7�.s�7C��8� �ڕn�S@�G���_'�����Iaڝ4"q=Q�t0�f6ҍ"C8@
�5V�Ks�B�^�Ԧ������i�-��#%���<R����P�2.5�p��.R�j�`jЬ"��Ñ@H�.���@�1�#x�[��m��Am��嵙B]�%e��IO�}�#8L�0^�)('.s�E)4&�rMKb"�vd9����#�Qe�9��qQ�I��@em�Z����<�"���*�W� /�T��O�E��
�'���|�,J�0�$^Q_�Z�"!>��T��^ЦպXN��aUV6�p�Nm�̭�'.s�EV[ӑ@t}��V&�`�P�h\�(�#mpNq�6�u�6O�>ݷo����k�=u��?:�СCj��/��ڴ������
��a�5��8�H��=� Ȇ˜v�C��3D����X[��ϣ�q)
�Mm�m�vǎG��]��o ۴i�nݺ:$@���8c����'���M����摪lJ���桔
(L�\�̽� Ȇ˜vQ��O�f�۝钶 �j2�q5�Z�6a �΁iڴi����۰aDܹs�Q��v�*�KH3k֬ŋw������B��^z��)�"lI�m�RWs&r����p:�lmNse���v�{�A��9�"w.9���v&U���l}��&P�m��hm\�����a���ihh�<y�ڵkW�^�p�B���G��;w.>��׿���k�.8�>�ҏ~��I�&�!����j¹�	G�޽�)����6m'�r�]~w3̺��.^���/s/?���.r�Jc��&���a�\�x�諊�D'*��6����իWAA�bYYٶm�v�����^s�5��`D._�ܜl�޽��vT}}}rMؑ�ڴ����õ�a��.g����e�,�!n^�~��2�]��%�lI�H e�]��O?��	�S*--���c�"/,1��Hd:n�8�/�?R�%�  %	�A Q-��$�g�$@$K��o|��1��#�***ڿ~~~�.]*++��hذa���b}�5�5���" p� nP�W�"Y�Y.	h\ى"n��V:qL3�z���퉰ўk@1A�u�lٲ��;1��A��/?��3�����`�<�����E8E��"��hd���\�FxD�H�׸̳J�,	(B�Eђ��W��?CvZ	�Ű�$`.s88�Y�yyyt!ڧ:�D$�Ehe��YU�	��W����G����'�X�o3��6)!	�%��e�P�Ǐ^b#���2G��� �E$@$@��m�$p!dgmmmǎ��fX�b ��o�R,�Asy�ГgB;�:-Y,�&�f��]�ݸ������a֬Yc��KJJ�7.|6��3fC���eN�H��Eɲ��!;�#��ٳg����� ژ~#޸p��6~���vs�8�(j3)^�.����-�b�7_�Xe�R��uI5�G�Ę�<G�7�9�"ϵ=
�ulٹ~�zs h좳i�&`EWI�q��`ۑ�o����GN5:]�w� �ia�.�S�b�׸�
�����gϞ�����>��oK-�g���XfK���eN�H�vEIH�E���,//7�Ɣ�P(�Yv�_�`h��a���d���s��GR*ss8�摵�[�%���G�+��S��5-[.sE�F���_�~�=k,�����|p�RlNPe�"`��[�P;�+S�izϑ������9��Wz��u�H�.���?A��φ�+�o{����V��R�Ϯ"|���چK�M1p����� ^���ye�߶�;��s�X~	^�+>�w�i܃����k"��������E���kaon��Q�,�;x��%���O�9�rp�y8W�s��y8q�;]w��iN_�K�q�/���c�?�ֽy�����E��{�+��"�pP��2W�@�:���x���5�o|���w�YQSS�%ѝ�@>}�u����[6|�~�o���^V������N	�k�3f`�l5#��>��c�Jb���Mo��Q� b.�zN�鴀���<l��s�y8ǖ9�I���s1�~��z��@���/^�U>y�d�޽���늏ƃo���D��k�E�ɖ�#�0̪˜�"[�3�
汥����������8�������o3�]ni�@7�p����u�������B���������ʃ6gΜ�&�<�n��իWc�P|��_�
+C0L8h� H)v�̙U�VaW<1v8i�$!V��}�ݏ?��ĉ_�u������j���F�[��/r�y8��\����q��Y���.`�%`~�;q���E��;�{���W_	w�7��g�}v�#�_�� ��w��S�{�9����;k�,<8�����馛��?�}�ز뷍���� ���{ESr��z��!�=�_�t���E����38�p`}H�=�=����|����� b	���6�������ś���4�]੢c�l p�W�T�i|o~�ݻ��!�$�>����hW]u���"��!��2W����Cْ͆ 	D	�9���EH������W_}Á����~<c��j^�k��E�Ǘ&YQ&�v,7C�4���3�ӽB ����z��7�RE�S�S@�8�B}3��q�� �E*�1��=#F���+���ItX�)f��_X�)>3�������%w^۹��m�
3�_!��'~���6A�fmJ�ּЛo�S&�6�@5�G�0K�5!m��Ͼ�cX�\�?�Th�K۳�J��Ǒy3���摉<�2$��enl������6dȐ�@�Xw�H�-=�����W1:�a5�;����z�\_�^#�Y�H���5�0Ţ�e˖�۷oΜ9K�,�$+[�m�&?7��}'��tp����.U�b�9f��LRO5���۫���q!e/v������͛���[o}�嗥_�v5ƣs�a�3e/s�d�e�`�bD��H}QBHN����J��IMѯs�O����&t�� 7�a*�(c��јJ�q�K/��`�¶R�R.&�X���(�ƞ��`�P6+���<M���9�"O�I
����5+V�,V�\)<��IM:�.nsOe�9�z|�!�5RSH���
cZ��N��2P��iDL��������]+4Â�<2��I@}>��i���(!	�H��:c�&�a&���u���mW-�z��n�T���Y!@mZ��a8�`'c�L��0+�Og�p8�#�	��2�]�~�a�$`?���s�{�챿rl�&CMd�,%�6]�ީS'Jq�6'�2OP��.s�EJ�(
C��ȱ�5��E�j��3ψ���M�j��j��$@-�7X\�|������^̛Uv�,UJ$@�"@��[���$��~��X�"� ,<0V�������1KJ|�!����f�0.mL�
1�N�$@�!�۾�K�}�:�"����Y֋H�K��ê0�qG�	�]�z��K5��$@$@{����R�j�詴�U�"�*��q�?�4�ʒ 	�@\�u��a���"Y�Y.	� 	�!�#FTn1��$�" �6���*BPf[��֗v�\�,�H����e˖����Y�f�	� 	�@V��6q�<��N��e�,�H���kFfP��y� 	� 	dn�C�8�F5��|�JV�H���S��a!3"/q�������$@$@�����^�L���X*�2MK�(S�<�H�2'�U���9�`��	FaΜ*s  �0��� ��D��xK`�E���%    �� �"��2G     o�]�-}QZ     �	�.��)s$    ��E���%��jkk��������w	P��՝��y� �E��tx��g:>��TG0��Y�"�Я�	������۞}���e%���I�ԻK_���^�%%����A�R}�����G�2�4?7��rrs �LY���L��tG_�*��6US%�۫M�4�h>l����<��ׂ̭)�����9t�Β?{�aO�Qn�� �.s���R:�"+���4��uϾ��"hF��m��V��C�l��&_7�u~N^��v�*�TS�hKviSz��"������"+-�il$��e�:6�һ�X�ʆ� ��O�:�{hc8��/�ٲ+�"�H8�,'�?���o��~cRv�أ�H�0C7��_R4�G�Vp�i����"����*��6�ih������A���F��c	({�CИ+�m�oK�_�=hIji,փ�=4	�#��P�18
�i���P�{Y�������*1-������Y��\L��	���s��rZ��(�>�G��6�R�ڔ�2�������A��z�dJ[({��v��W�Z%�YQQ��+m�rz���LOOw΢]�g���=o�a�95�°���a�(�O��c��$O�Ve��
��n��s�i��x����Ԧ
�tN���ԋT�b�k�]�z;�P�2G�T��z�g�6�O�]�0`f�#�&�{���Fax�` �f�c"m����̚��!=ₘD�/u�(��Nt���d-�)m&+W���<�������e���=�	�2O�~�/�d%���v�|P���A��L�0l��fi�"|��E��VY.#�$uG��3��E��(j�����"�g����r��Dm&n-�iSn+�X:����������>>�Dڦ��R��,5 ���H�?e�u����ƺ����⻥���](�Bw��?��P8���!]xMJNR��lA&��"G�23���g2�3w&��s�~�sh&s�s����_z�<�^�'��bw�Z0s��\�#��H�>���������Y��E��Q��"o'��b�ɩt���0Q~X�U�'�:�E�f��_LN���7�9V{�	�n��R����� /�b�:6
�V0�s+{�v�"o�ٻ������"��iu�V]Td��s����X�1d�5qNeD�6��I��0ћ��ϑ�L�S]>��H�6�y�V�y��t�os��۝���y���G�_/�"3#2��n�-�	t^d�_�g���H�3�,r2/�4 Ho^.��r�{�/�N���)��t�|n� a����0O�;�?'/�����F�3i�e��D����_ͱ���+��;r'nà~�b���s'L�f���i�!�\�n΅�sG%� a�f������G�P;��\���� ���K��Ӯ�TH���W�Q#�t�;�Z=a�7������vwZ��ᑶ;�:<�`� �i{߮0O�#�W�d��.��H\Gd������ߗ��XiSF]U�uݑ�-����	�i�_l�M��k�a���t�[h�W�0���6����x�J���g��S@�;1�BH�z�?3W4F�2~`���i�7�i�-����a�+���V� an����E�VA�3̿��}x]^@���X��t���z��c�Ã�����u �	s�"ݢ�� �  �  ����En��?@ @ �M��H��> �  �  � y����@ @ t /ҭG� �  � �-@^�8�C @ @ �ȋt��  �  � n��-��@ @ @@7�p<׭N��	xG�������&5����4i��6>�u����*y�ܪ�=o�����a���`K���,����E:�u����ζ;
_�|ʏn��Wk~�$��(+Ϛ�`^�g����Z����$k�<m�����}R@�`�*ҍ/b��z�9a� ��y�T�����-���ݦI�+?w(Iԥ�4�p򋡐gyQ����c�1��1Ξ�ώ8a��0`5tv=#]��;a�����&@^�[�P���$�D?��y��u���]7�t���h�kk��WL�p�H�9�Q���r��`��2F�L���8a�� f4v�"��`'̃e��ȋ��*��<�ɋ~��q^Ո��#<�wkkkCC��򡪪j̘1�Vi뮶��>���c%)J�F�^��	���ؽk�E�v;a�@���#��L},�	i�Ia�	S��뉺�t�ر�=�����yR��� �b���2����B�Eft�3���t�"�]���: �@�ȋz��ց0�"9���CQ�N�e�Z��Q�Ţ���`f�fnĂ�?4v#]��`��AM-@�G�N��)4���XM�3�+�y�b���%��A#��<�*`A�`���U�L�X4 /ҰS���a5�AZ����+d�J�1X���� ح��nU��@@c�"�;��i'`v���$.�q���ϟ///��\&N�x�ܹ�>�q��?~��Zd��J$Efbd��8ϲ86C�=���ב.�B��wl�'pL���1Z
�]u�f��������N���h�ƍI�~��577_{�=Hwvv���x�;b���L.��r�ȣe�����t3/"�]?:�!�-@^d�(�B��]��D:I�$ϑ����'ǋ/^�s�N�����M�6x�`5�$�,Z����vȐ!�>����jժ�G.t��J�&r��]�.�M��+�U��|� .����|/p�ɤn��9sF�g����̙��Դm۶5k�$)�O��l�2y��/<������2�t��	Pz�G����k��5ɶ�,ÇW��Ë���.����p)��p9���bH�J �{�"�w!�D���K�Qrv�ʅ�VXX��jy`����:�e˖	&H�$ITQQѦM�RW���H�I�D\��3K�"&ѹ��.p-�}�FbD�;r R(�'@^�5{B�!�:u�ҥKgϞ-cJj�h�̙�G��HF�Ԯg͚�Ƌd�q$��C� �� ��*e"� I�"rA஻�Z�z�L���#5(T\\|��т��A�UUU��E�Ǐ/--U���\�G���}�t}��� �@�	��Y@�����X.��g�^���Z��|y���s+GX�:X�l�նbC�=�G͝RQ�6_y�ya���9�&3�?�c��C�,�lK�F +��:�]�N�[7gMpH��"�`)@ @ |#@^䛮�� �  �  �� y�C�� ��^���|��X|.@����>� /
D7�Ht�k�6�s�[�x��ӺՍ� ������� �
�9�K� p����|����l:z�\'@ ��{w.MC �ȋr�OiQ�	�?����;w�\o&�0���{YHo*��}���������?|�ԅޗF	�Z@�-���<q���Ħ&�ݭ/v_�T�`
���i5n��8�즃��� �M��t�����¼dɒ�7�Z͌�E�gL� �� y��@-�&вc�[[�N��PGk]kk�;����SY�ϟ/{�q�����CZ��\է��qMM��4�U�ٳg���ܹ:���~)8���ݝo|p��O;��J佣g��)%#���s�~�M7��������������vϞ=*�U����M�5�����ݢ���ɒUQ6.���� ��y�T��mm!����w���o��Fcc�c������R9ڵkׂ䭜W]{�MMM�,�������m۶�[ɋ�W�mmm�ׯ?q�D�>}v���{7��i�����ս{�u�z~9WUJF ��xj��]��
�IH2$��Ej�����z�f�IlR|Ŋ�*�%�����!ue�ɢ�W�ʚ6;���: � y�����m���9s�W^)%�|����퓓�A��񟎎��7�˖-;p���a�
�+��ų,�:ԶjY(H�F��Z�1*J=�8a���*��(��������yi@jؾ��{ɷ���W_��[R���V�D"�%;�ԛ`W#�� 
G ��ȋ8B���L�y��U]���+'L�/���;-Z4k�,���,r1w�Uɕ�j��=���|Y��W8�U��/
,^���Fn%l���/��;5��y��_���/ue5���қ`Wa�G���U�.'@^�q�@6�'O.-�Weeeؙ3wu�u�]7r��)S���9u�L��s�� ѷ��-��;��̩�yt2����O��M#�ݦη�*�����e˛1�h��a=����!`��xj��PbW��9{�l	R	�zH~����nȰRj����7�V]_��L�0!ueG'���*#r�O���FQ ��a���e?�$s�����"�����+_�>�j����1���>��ڵkռ;�����Vlh�g�S*
���+�#g7���;�ΆR��g�@y�\�?�c��C�,w�-�1����a�]G����'��^�!̳�
�B ��
0^�[A�G �#n,��;J�7{���W�3]Ƣ�!�C�݇�F�@ D^�A�@
������+^�Z�~߬��z�#�d)�iY	��Y5(D�g��V �� y�W���@\u߯�^�bޟ�Z2 �4�\ �s��i�#@^�;}IK���~���M�@ S�=S1�G �ȋ�7g� �  �  �� y�^�Am�H@��W�'�|R6��[�dT+#������d������05D |$@^�΢�tX�~�z��֭[�$��So����yGx!�@�	�C]U��C�r�u��P���C|v��m�H$�$iɒ%O=��m�S �  ���E��ô/�v�ء&�� Q��2pt�������t�iX�he��4 /r��pR@�5�F�jkkծV�X��o���R6x#��㏫���tr��7�`� �@�
��h�Ҭ�	�����`�O������\�%�����Z@�y�"���	�=Zͨ��T.$�E�E�c;�`�R yJ	y;�*��9��R$�ݻw�I5rc:�n�%gKA:hk����L�|��Ok@ 'ȋ�ԥl@ @ �� y�z�:"�  �  ����EN�R6 �  � �A����D@ @ @�I�"'u)@ @ � @^�^���hmm�;ѩE~N�:�#��/�t_v�F ����O�J5�X���'��/Fcu-�W��}ʘ���%�,ڲau$�������?�/{X�7�?V۸��ɣ�N�(�����<��T2�-���=Z�`���b���6�u�t9$�
�^�����B/���	5Z��^�Ez���Y�S�J�V���&�|�ᶶKyQ��%��n�����+
���y�T m�]�H��;yQ(�"��3�EθRj.
��*u������Gc�h<��c�`���	���֥�����=]K��!����,+=�2X��H�/�ǘR��6ص�t��N^��q�@ � y�VԩR,����xg,t!���(?G��Z���y����^�ZYYy×o�{�'���¡>����}���KRd�U�g]��ꑀ���U�K����E��.	�q4 `U y�$?�x��C��(&yQL�%ɛ�#�����r��>f^������+?�G�E=2��l�=m����Ei�Y� /rZ��sG@ݤ�/
ɭ��(&#E� �[#/�t������K$��̚3�!�j���̋2���]�7�O�=]����E��� /r��䌀q�6B�H�b�����,�ߘy�4�+
搑9Pd$Fj�HƇ$)��B(�̋�1�x<�k�ȋr&������r"�ɋ��� /��Υi6�S%Iz�,�ȋ�ƿ�yq��w���|c�(?,���̳)�"�L��_�`�bjo��Y1gpT���Q^
�5��]�d�HeGjZ��U��o�9�N�ub,�2�8�2"y��Ë�PƋr-����=]/���E��� /r���@��j��̈�����t�C&�]�U�?�6�F:��Y��`yQp�&O[N`�A  5�IDAT���9�ɋҁ�98.@^�81;�1��ْ����$���G9��L����ȼ#w�6��,fЩ�3^�i/��-{ό�;y�--� �@oȋz�ǶH̕K�}�"9?�t/���|��
ļ���w����x��B^�� @��E�+�ɋ�R�8- O�gA ��̳}�:"c	ō۬%�o�]��2YTj��A�2k#�� �����ÁJ@��"[)$p*%2�#Y8��`��Q�7���D�5 �-t�n�U@@{�"�
j,`�0���uy�>� �{�=�_9���9@ �"�@ @ � yQЏ ڏ  �  � �E �  �  t��@ @ ȋ8@ @ @ ��EA?h? �  � �q �  �  �@���ă)�A�荀�q���X__/M��TVVN�4�7ͱe[�\��g{��<>eՃ�ԍB�Z��`�0�EҖ`��=�X(?/�Ra���Ɇ �+�^�q�><u����P�cK=|����$���(+Ϛ�`^�g���z�B�E�?�_��^�6�9�th�>��U�_�tuO�H�C�: p� 4?����}K�n�f{���ܡH$Qnii���C!��d��>�c����)�숼ȁC�"-	��zF�P�>�ɋ,��� N
�9�Kٹ(`�''�������k��캑�=ohGk][ۥ���b���ER��я���S��ǈ�1�f�e7pD^���
h�E���N^�(��h%@^�UwP�W��H^�u��F̭�y�[[[ԕUUUcƌ�J[w������i��+IQ"5��2�"o{3�{�0�u�t96�
v��G@�g��cAMH+`~lL
3N��^OԽ�cǎ}��7ϓ�d�)3���1dd�"-2+ ������g���:��z'@^�;?����ɹ},�jv�/�ԢO��Rg,���3�4s#�!�i�k�ҟ�?jj� =
ht
EO!��@���j"��h^aϫ��ͤ(ae1d�y�P��O�B�g*�� �� y���B�4��Ң��$_!�Wb�����d��� �n�?v�R�� �i�9TM;s�üV&q��v5ԫBb�H���Ȥ3nq�W-�� �3;,�̼X� /Ҳ[����&�̢;�|yy���2q��s��%m�q��?~\[-�B,s�����T̗���#�p�ݗ8�F �O�q@ ���1�Ƶ�t���?p���S�$/ڸqc�����knn���k{h@gggMM�W���J�&��Hc��v�F��r���
 �@/ȋz	����dR/��%A�<GF��ϟ�/Z�x�Ν;�'<8mڴ����%YgѢE���C�y��ge�U�V%?r���'�uAe�PWW��N������H=�� B ����i�'���\J�Μ9#���3mmms��ijjڶmۚ5k��>}��e���/���������҉'d@�G����s��J�$��G�>\�RN/rfi^U�$:��)�)ׂ�בn$F�S� �"��K�E.A��HήQ�аa�
SK���߿�СC[�l�0a��N�Dmڴ)u�����x��Q�H$�*�!�.@��NJ� �@F�Eq�2:
ȸ�ԩS�.]:{�lS���P�E3gΔ��%F2R��=k�,5^$��#��� �!@�sh � �
�9�K��$p�]w�^�Z&��ؑ*..>z�hAA��A���������Ǘ�����n�̣s����`���gZ� ��J� ��u�%��@4��յ�_���yU#�V���u�Vٺ�mņ�{&��;�� ?l������P�2��4�l���z�<�-Y��v�lv�/��B�y��js���� v
0^d�&e!�  �  ��ȋ��k�@ @ � /�S��@ #���?<��&�� ~ ���k���	���i/Z;u�?��>����<xZ�
Q	pF�`wƕR@�~�"�M)�Ο?_^^�n%7q�D���q�?n��\(P���COվ�������rv����C������OVQ�'���E�jw�}��s�.�����An�����p�I�]�#��!���ȋ8.��@򙏒u{`�?
�{���|�����)���_�M=pT`���o�����CR��������g�Gy�Qss�dSm������� 	�9K�9.���޺n�5�;Z�Z[[�j���Y�#�W�O?�tmm�TF~��o~S~P�2R��/kjjd�)��i'j�k׮���·onzw��5GN�W�%u���؉=R&�	��خ��Ȯ_;�W]u�c�=V__/Mhii���n�A5G"Z��u�Ξ=+�1����pN�����eG�Q%��p��`wB�2@�+�"��ٯ��$&����+�����s�Μ93d�9�ikk���V|%%%���N���u������_�R~��/ȳ\�̩��I>�EΨ�K�n۶m͚5��w���6n���+Խ{�u�z~9Z[
G�g���,!���Iu^{�5)�׿�����ߩ�w��!���wΜ9���L~��7n�(+t�7�xC���!5���/�3�lv��m?�(2 /�T��P����������R��u#'L�,�亱c��߿_Ί�l�RYY��ё��xٲe6lXaa��]�	�N_�a��1*+������w{�R�K_���ӧ_�����w2���"�|�-�$��ޛo�y߾}��n�,�T����G���/@$q���{W�g��g�D� X��v=&g�2TQQ�ƋfΜ)CF�<��ҥKo��&u���Y�����+�^�����p��z:�)�"����_a� N�,� +�L@2�iӦ�y�#G����+U�%��~��O�d�޽�}���K��|]��0�/@r��F�=�<��o��գ(@ #򢌸X����Ɣ��KKC�kau���"�g�!����ѣ��I�&�����3~����Ru}��I�D�S�n8߾�춲�?k�3F-�3��J�<2vǌ��+ ǳ�ty��UT"wРA=�P����M��(u&mjen��h4*�.Q/�~�/���l����s�o��:ԭ� ��3�_(���
�ߌ�?a����hls��r����F�#&W<��k׮M~��Iݶ�FV��<{ҨyS���u�䅵��{�L(N��g�@y�\�^������jS�<i;��/�]��+��"C�O+C��-�&M� 4Ƌ����6s�H����M����}�ۤH�?�3���%GI������+z�+MO��=�k ��Oȋ|�QTk,X�p��u=Xk䍅ߛ=�o+o����]"��[�[��l /����@������YR=��_se����Q�`�c�Qg+@^خ��x) 7��cd��{��Z2��z�opX�`w��@�6�"�()2�{�r�Q�h���v?�uF h�EA�qڛS�g�V��~��'U�jkk��&�Lc@ ��=z4 � �
���Ii�*�~�z��֭[��SMd���Q�y��\�
;C W�����ϕ]�@ X�E��oZ���HD�aÆg�y&W�H�@@��hhh����@�v�"�I)�v�ءf���թ�.Z�H�F�Tv��	\x�'d�ؕ]�@ p�E��r�K�ǏW��,Y"WI�^|�E�I�r���d�Hf̪/>d��K�8$@ {ȋ���4�(++�4�7ސ��I��rF@�ʪo=d� ߽{w�4�� � :�����,����rɁ,���Q�F��G?ʲP6C @ �'@^�>��9$ _�/���$#S�r��4>!�` `� y���  �  � > /�Y�Q]@ @ �]���vR
D @ @ �	���è. �  � �.@^d;)"�  �  ���ȋ|�aT��
�ڵk��<��s���(!�@N
�9٭4
4��qM�B5�\���'��/Fcu-�W��}ʘ���%��|ˆՑH"����S��=�՛��m�{��Qs�T��W^~��I*�q�xqO4���TS�a��up�v�"]	����u�>8}q����s��H�� �� y�V�Ae��ԩҾ�/��I�'_s��-Q���P��%��n�����+
���y�T m�]�H��;yQ(�"��3�EθRj.
��*u������Gc�h<��c�`���	əw6��E�#fd<(cO�����pHf���#ˊG����1R#Ƌ�1���vm"��{go��9\�H#@^�!��Uu���b�xg4�]��.t�.����ﭖe�zG�kihhP�b�������=dP�L�����������/I��V��ytP��G��V�.�cc��yt��[�$@^�р�U�䩒� �E�%����E1ɗ$)�����`I^+��H��d��X.!���̋��9#5��g���ȃ#�]f.�s���N;yQ��)[ ����E6�R\��s�($�^0S���I�$o����mL���ǋ�0|�� I�#��tȼ゚D'�4�o��}���@�`O���;yQ:s>G �ȋ'f9#`�*���1R���B!#/2��7f^$M5Ǌ�2��(2ǌ��"�����<3/2ƌ��LG�ȋ��� �`�ӝv� MF@7�"�z���+�N�$�1� #/��ƣ��E�N��G-u*]~�1L���u��y�>�EM>C�`�rh���EV�Y /r���sM y�*/Rّ�V'o�EE���`N�S}�2���&Ω�H�f��")��\$?��`O�K6;yQ:p>G �ȋ'f�$��-� 23"c ��&���@�Ef���m|�t(1�.��"�\� ��`O�Y�#ۂ��(8�#�����*�.�1�ϣ�@���%4��،icyrˁ���"A	�����(�tV;���[�`O�w�`����<�Z��"�{���P 1W.q�9#���ҽ�|�"۫�@��+Ȩ�q:O3�e�0�.+66�A�`O�hW�3^���@�iƋ���0���눌%7n��x��D�e�,*5R����#�&� ������Q@� yQp����)�R"3;2FC�,:w�2Y̌(�s�-� �n�	vH�� ��i�ETPc�ɼ� �����������?�i �q �  �  �@�ȋ�~�~@ @  /�@ @ @ ������ �  �  @^�1�  �  � A /
�@�@ @ @���c @ @ �.@^�#��#�  �  �@8��� ��<����R����I�&��E����'�>��h,��z�����z#�m�k�iK�?�n��/P�|ΰ�t�"� Y�eMǆA�����c'C�K)?���5?�D�q���g�}0/ϳ���w-�E�?�_��^�6��}<��O
��ZE��ELT���C �ȋ<�*�?����}K�nӤ���;�$�RZj8��Pȳ�(ir��1�#_&�gO�gG�E�f��n��g�ˁ��`'/
`|�dt /ҭG����y�q��ܼo��[ʮY:��Jw�ֵ�]ʋ�+�y8^$����i�a9UZ0}�h#i&ZvG�E�`������[����E��2Z��V�EZu��yE���E?X�8�j����׻�����A]�PUU5f�o��uWۊ�_�Vq����%R�l/C /�7�w�]�H�cî`'/
l��p��~��>������Ƥ0�)���D�k:v���{�qs�<)JVN�b1��xCF�m!�"�:��zF��]���QK@�w�E��c��	Y����⡨f��2qN-��(u�b�X\~03I37bA�����.�I��㠦� У�F�P��t}�&�����z�X�L�VƠCF��
� @�[@��*{�b�� 
�i�)TIs��� -J�O��z%Ɗ,JK�
z	�V��`�*�z �� y�ƝCմ0;�ke�8_���ϗ��_m.'N<w�\r��Ѹq�?�|-�܃X%�"312�[�gY�!�����^���� *E"����En���P7pm]���8p��)ɋ6nܘ�ׯ_ss��^�igggMM�W��q!�9���r,1�������K�3����[ ��v�E�u	�1�Ɠ�t� I�##H���O�-^�x�ΝR��N�6m���j|I�Y�hQmm�!C�}�YYaժUɏ\pV�C])�D.���<v�[�h����� �����^rG�ғI�:�?s�$6�ϴ��͙3���i۶mk֬I�N�>}ٲe���^x�����ep�ĉ2���#�TWWK6�p�Bɚd[�H��Ç�T���|BZTvuu����g
��~���ϽG�@� /�@@ �ft.%F�yt*6lXaaaj��E���?t�Ж-[&L� ��$QEEE�6mJ]���#9^$yT$ɦ�n#g��UEL���յp3صit6!سQc�I��H�ޠ.d% �BS�N]�t��ٳeL���B�͜9SʓK�d�H<k�,5^$��#e�76B @ rP��(;�&P஻�Z�z�L���#5(T\\|��т��A�UUU��E�Ǐ/--U���\�G����tpᮒ������͒�p_���}s��@�n:WRR��+�\y�RD�G���M�n��V��={d8H��<:9C����/o��"�D��>��3��"�@/\���|'r��1��W_}�����z����Y���l� �R��ȗ�F�@ |*��]%�[�U��SO�ޚ2������7�x�\���fe�ɧ�T�.@^d݊5@ �F���J�ZRoM)�IɻV��ZՆ���0��M��� yQ.�*mB�'��G~x�'���d/��]%���RoM9v���]++++UK��կ����Ygٷ�ږ�5'�B /ȋ��g�V�ة��t�џ�n��ӁE��$l����R�r�UW�ޚ2�|�5�ܯ/���;գ��Xv'T)� /rB�2@�3d���^;�T����9q1�s�8TH�򮒻v����e��O��O���rw��[S�>��'�_z�%u��o}�[=���=A��NJ� ਀��j� `Ɗ���������+_�>�j�����~��w�ĉ}��! ROw��"�*���y�ᇟx�	u3���ڻ-��j[����ɣ�N�(�����������:��D�{��W�{{��=�X(?/�RMy����X�*�-UN���
�'�����Ł
���Y�E���4�W�e������|͡��:�v���?]Z��=$EN��z����_
·onzw��F6GN�W�%u����z9���.�M�^�ݺk"������G�P�ԯ�����F"����Ґ�τ�a�**�E�>��ڵk�c���r���I>z�������W2���L��D�'�l%k��jC�����j���8���������X(N/*�"���i��9~��3^��F��H����*�O>�$bI���ǝ�
�E] � �E�k�
$�����m%�9q�D�>}v�ܹcǎ��6�xZ2�ԇ9J%Y�z�����[ZZ�\x�hR��&�ܘ�����Bϯ�پNe�V���@�G���$ER�}8-� C ���=;F��@r]uu�l%�b�E���C��[���-��"?�o�j���P^�"�.��I�#M
��ז5��z�gd�H�!��%#E�\�7ߖ�P8$��`��+�Hs��C5�X@@�G�a��U�ԩ5ol�V__�����ȳA����z��G��V'��d�܅V�\)�@�{yԽL�S����ۧ~��٭��+bu�� �ƛ�m|�xK��e��Y��d[�g=��
v���^1��{UgO ���/�@ �����QS�6��ű3M�T�����t�����v[4�A���Rɋ�푟�7j�H�M'��ij����{�3G��Uzh��]���2/�-�X��`�lke��
dYdҬ�#Sj�[o�w"�=>:�=�*@^d+'�!��@III{{��LH�,�t����w��[o�U�ϭ[�N>=z�����O�0���Yݤ������P�;�9x��f�"�[8����()�B?����|ǡ��_\�b��FrG~���[�J֤U�v���� ��u�"�V�� �yc��f������oo�b{�' �V<x�#G��o��O�2����J�v
UB ��ȋ8B@�m�	7]��z��o/���>n��!�O�ٳgˬ�����<5�4I��:�uC �n�E ���ܷꎑEK�zk� v�.�����e��SO=5z��Ժ�$[͛B�k�AT��E ����z�ˍ<�g�>����_��W~�ӟ����E�V�����5D �"�rA@ͱ�E=��rI y��Q�F��G?��L>��3*����J��Rci �� y�W���䜩��L�ؼ��[���wm+��@@������,�^�r��z+?�QGj� �^����]HH
�����MX@ @ ��Y�bM4���b5�&�hZK��  � h,@^�q�P5,$���\l`��@ @ �� y��#�����Cs�=�@ pK���-i���c;v�P����?�Cr��~(@ �Y��Z�?��G�{��ച�"�  � 6
�وIQ �  �  �K�"_v�F @ @ ȋlĤ(@ @ � y�/��J#�  �  ����E6bR �  � �R��ȗ�F��&����\�"?� 9)@��d��(�D ��5�
�@@s3V�p4��յ�_���)cʪF�x^�-VG"�X.-M����ᰇ�z��c��{�<j������ϓ:I%3����}p������Q�:8��n�.�����c��"����Ev
U�T�S�J�V���&u�|�ᶶKyQ��%��n�����+
���y�T m�]�HY��=�NbU@�n�"�E)/wRO�:c������wۣ�X4���1c0��ϋ���w�Rǋ
G��xPƞ���������G��zC_,�c�F��cL)�h��D���Ή`w�o� ��EXP�J�x(�wF㝱Ѕh�Bg��M��jYv�w佖��zUjee�_���=dP�L�����������/I��V��ytP��G��V�.�c{�{���0ȋ8�*�<U�d�HҡDR��(&���M���]��c��Hr3/R���H����#�~k6����
���e@�9�"�l)9��MJ���z�L�b2R$	��5�K�1���/�i�$@��Ȭ9#2︠&��/ͼ(�/p�/z3��$��u�S��n�|� 8(@^� .E瘀q�6B�H�b�����,�ߘy�4�+
搑9Pd$Fj�HƇ$)��B(�̋�1�x<�k�ȋr,��o��s9���rX��(�;���,�N�$�1� #/��ƣ��EL�Sܩ�k��a������C0Ϧȋl>0)�~�݊��ne��� 8$@^�,��@�.U2^��#5�Nު����7��D�z<1duM�S�����ER(�E�Nz��`O�?�{���9 � y����{��"�"3#2��n�-�t^d�_�g���H�3�,"/ʽ8�E��tݤ.1�9����@ ȋĥ�H�-�y��NYM�K\}����ި�D���aP?g1�N��"���i� ��3��nc�Q �� yQ�b���1<���͹sF����{�!d�qN��4�K�h��j!/ʊ��l ��"��iw�
 ��s��9gKɹ,����̎�vf{ʟ�H&�yUQ�uG�5��(;7��E�`����#�!�-�U@ ��*�r�i���!)ꡛ�\�5���E9}��8�	�:�`���* �� y��]D50O���
𺼀JY� �������� � y�  �  � ]��(�G �G @ @ �"�@ @ � yQЏ ڏ  �  � �E �  �  t��@ @ ȋ8@ @ @ ��EA?h? �  � ���8
 �K��h۶m��������&M�e�z���Ot}bݾN_8�`��a��% �  � � /�@ K�O�m?v2��yʏY���f�Z�H$�Gii�y����l48�]Kqр�����̑ȋ�>0�@ ,
�Y�b5.	��C��-���ݦ�K����E'�
y�%M�>�cB�p�H��ώȋ49̨ � 9,@^�ÝK�0�"�D?��y��u���]7�t�#{ʤ�#�~��WL�p�H*9�Q��Ò-�>F���4-��#�L��E @ �lȋ�Qc� �W��H^�u��F̭�9Hkkk��Ecǎ��J[w������i��+IQ"5���j�!y�����@ ���3m��LsF�,2&��Q<�s|g,$z�k�<)J6Q�b1��xCF�7zq��T@ � yQ���:pFV$���x(�)~����X,��f&i�F, �  ��~�E��	5�U�k�HM�3]k�K�b���%��A#��t��  � � /�@ S��� -J'�D�+b�(-+ �  ��G�E��[_
���2�f�o������˯6��'�;w.�O�hܸqǏw�Y�A�I���t�-γ,��@ @ �ȋ����P7pm]���8p��)ɋ6nܘt�ׯ_ss��^ۃtgggMM�W��q!�9���r,w�<Z�  � �	�9FK��,`L��d"�$H��������E�/޹s������ӦM<x�_�u-ZT[[;dȐg�}VVX�jU�#�Gu�D�@�.@ @ K�,��,�����y��3g$��|���mΜ9MMM۶m[�fM��O��l�2y��/<������2�t��	Pz�G���%�Z�p�dM��|$����U*��b>!�*˧9\E�G @ D���� �l̛ѹ�%�ѩ\hذa�����3f����:�e˖	&H�$ITQQѦM�RW���H�I�D�iy��H.d^U�$��X@ � /rכ�!����M�:u�ҥ�gϖ1���
5^4s�Lٛ\b$#Ej��f�R�E��8�u�H@ @���E��6*�@7���k���2�NƎԠPqq�ѣG

TUU%��?���T]_$wkpe�  � �C���ς �=�ryV��h��e�ʗ�ϫ1�r�������]m+64�3y��)�a󕗟�;���C����'�����Ł
���ц��  � X`��"�!�  �  �@�
��l��0@ @ �(@^d��@�~���x�G��\JD @ 2 /���@�&�m�����~ӁS6�G1 �  �@��E�۱%d'�֡3�g��o�8v�Bv%� �  `� y������=�ϟ///W�Ԗ[l�\��<nܸ�Ǐ۳o'K�?�O.��~���N@ @ ��ȋ2�bm\�';v������{�y乮����H"��Ŏ�p���ߡE�D�;�q��	 �  � y�����-;���e��ku�ֵ����΃���� ����Փ[e��e�j��7���ZA~��s�̑&N�x��9�v����M�E%K������_
·onzw���w�n:���-m����!�  � v	��%I9�hhhhk�W}}��G޵k���_�u��t�Mj,���i۶m2�N~8e.Ç߹sg�^� CL��ν��{�ĉ���={����������\���%���}��I-��^����~��<���׽{B�����ǝ�T�B@ @ �� /��@@S5�N����Ru�Ѱa�
;::��E˖-�D"�TUUI%����^YY)?:T>���T�GEEE�6m��Ȱ�,�%�^>#R;����N_���r��|�^9�Q�  �@�8�t��x_�|����9k�,5^$Kuuu�V���TTT��3g�]�������+�(H���+f�ho�(@ H
�q0 ����ɓKKC�%#3�p8�Rz�Fͣ�A���Ǐ?�xr�������XHF��̂��'5�T\\|��Q۫ڭ�n8ߝ=���7��+.��#��������k���W;]s�G @ ��
���."��4<���d.�',Ӻ.Fcu-�W��}^Ո��#r��Y�n뮶��<j��������3u�~���l(%��g�@ye�6A @ l`��FL�B ��Ɩxzf�w�g٭%���aC@ �Z��(k:6D �ln���'�}iI��i�E2��Ml�  � �-@^d�(�!�������W�W��;��:� �  � �
�9�K� Ѓ�ܪ��� B @ < /��  �  � x,@^�q�{z#�c�u��'�|R�3{�l���7%�- �  (�@u7��5�%K����nݺ������/++��uuu�7�k��= �  ��c�E��R0��_�>u'�����{��F���D��?{@ @ rD��(G:�fY@��M�2���45��� ��v@ @ #򢌸X�d��L�{��Ռ�"�
!�  ����EwUC ����}�ݻw�V+N�<������F��m�� �  � 	�"|, #E2.�n@'7]x������3�/_��Qu@ @�]�"w���
�H���,�I�����F���@ @ �\ /��ޥm �  �  `E��Ȋ� �  �  �@.��r��6@ @ �"@^dE�u@ @ @ �ȋr�wi[pv��%7��Ed������R@ @��p<�� 
A ��X���X�b4Vײ��ۧ�)�]�y۷lX�$b��,<����p��Z�����ƽ�L5wJEA~�|���I����V�Cv�  � �
���7�L7�O�E�V���&��|͡��D]��'o����I^4�k��(��G^�yoP@ �I������yQg,�����n{4��C�X<f&��y���ygsj^T8b�G�2�4?����Ȳ��Co�+�E}�Ԉ�"���!�  ����E���C@ @ �L ��_�B�*Q@ ��w�q( �  ���� |�^��    IEND�B`�PK     ! �R%�#  �     word/theme/theme1.xml�YM�7������c�7�c;i����&%GyF�Q�I�]%9
�i顁�z(m	����mS����xlɖY�l`)Y�Z�����J�4��WN�㘦�z�� �4�i�q�K-p����3Gܹ����ᎈQ���O��8�ӝr���Kt�R�7�,�BVYT<�~R�U*�rq�&����f.��������YC@�A�
N���s�0pIǑ����ȅ��8��w/��FDl����oa�0'5eǢ���u=��]�W "6q��1h,�) 9Ӝ���z�^�[`5P^���7�������7�]/�xʋ�~8�W1�@yѳĤY�]�@y���oV�}�i�(&8�l�+^���]BƔ\��۞;l�������>��Z�S6� �\(p
�|��0�8<b��(�o
S�es�VV���qUIE� �Y�M�h�� 0<�c��� o^����sp����_N?>}����L#����_���S����^?�ʎ�:���>���/�@�_}���^}���?<����t�!N7�1�M91� h����a�n�M#S��X��sH��Cf�2)6���}��A�f[���� �SJz�Y�t=K��,�샳����ml-���T�wls��Ƞy�Ȕ��H���N����؈�>�t,�=z[Cr�G�jZ]É���FP�ۈ��]У�澏�L����\"b��*�	�XÄ��=(bɃ9��s!3!B� D��ln��A���{���<1�L���)Ց}:�c�L��q�؏�D.QnQa%A���e`�5�w12�}�޾#�վ@���m	D��8'c����'8=S��d�{��.��շO�{!�˰uG���6ܺx�����kw��[Hn��t�����to���/�+�V��⪮�$[��cLȁ��Ǖ�s9�p(UE-��,.�3p���`�p*���"�pq0�\����;� �d��yk�Z<�J(V��|)��i$��Fs��t�j�zT.d����6�I�n!�,� �fv.,����V�k��� �~��ܜ�\o��0�Sn_d��3�-��k��3��i����L�2�a�֛�9��UJzY(6i4[�"י��iI�8�{��I7�v����b2��x���Di�	�"��EY���>�qS]��,'r��i �[����xAɵ+/r�KO2�Q �����/wb�}KpV�3I� �����m(�5�Y C��2�!f��^EqM�[���l�E!��pq��b��UyIG��b�>+����(ʒ�֧��FY�&�[��Դ�ǻ;�5V+�7X�ҽ�u�B붝o h�V��2�j�V��9^��Ks�qާ������^�j�&��\�}y]��Ut"���G�\	Tk�.'��8*^��k�_���Aɭ��R���K]ϫW^����ʠ�8�z��C�<C�7/�}��KR\�/4)Su.+c���Z���`��ڰ]o��v�;,��^����R��7�þ��Ç8R`�[��ƠUjT}��6*�V��tk����n��"�r��w^�k�   �� PK     ! A"���  
     word/settings.xml�V[o�6~��`�y�%�r�N�K���סr %R6�@Rv�a�}��9�Wd+�d�|������'�z��b%Wq�#�����,��]��Q�X$0bR�Yt"&z��/!ւ��a2^΢��*L�'�+�� ���#�z7�H?֪_J���eԞ�8�D�9�j-��E��RK#+�L2YU�$�O��o�ۘ�dYs"��8ЄAR�=U&x��������"��c��ܣ����-�9�eI���,$HEx�����W�-ѻ�$�������`�ʁao���h��nxҖ���~'�FVB9=�(�Z~�����"���N�q4p tDV�E� la̓�d�F�
��nQ�[�@� ��a��#�JKt�P	�K)��,�a���K �������)oF,���1�H�>f��oo�3�ѡ����IqM1ٺ~�������W2�cm,�~~ ��%@���	nx{RdM���M?)���5�jC���^``�OF��h@�Y������� ����i{�p�,��q����y�T�vH2�$��%��m&��dys	��ݥm��f���,�q:Z�մ5��m�?u89B�xc�D���6n��F�T� �$�9��E ��01����O�g��"�?�һ�o��/Ja;||��vѿkY�=j���d<n-������<X	XkgP-��}��s�,�����D���-1����)�p��%�����&�N�0<����[l�a��T��@�=t�a��鍂l���A6�di���ld'��Vа�aL���+ɘ<��ÿ5M0{�Ȫ��@/�ڕnz��<�k@0���FQ�ѓ{�g�j3t��}��0��^z�Ȣ0�/�=�_��^���/��I�QKE��b��oKR���-��.�3���bX���=|��_���2YM�~z����y:��G�E��2]�&7����v
ÿ��   �� PK     ! [m��	  �     word/webSettings.xml���J1��;,���Y�-�T���>@�ζ�L&̤���k�H/��I23���;��X�֌��� yZ��j���|pm*).-]��ق����l�7=,���)�*I��Y��ků�)C�ǎ]ђW�n��fW�"�P�v\�Wf��)
u]�pK~��ʮ�2D)�:d���S��x��<��>�=t!�����3	ue���'�Q�>�w'�������@�ܯ�[D�@'�3S̀r	>`N|�����v1R��p�����  �� PK     ! �Ty�h  �   docProps/core.xml �(�                                                                                                                                                                                                                                                                 ��QO�0��M������X2͞\b�Ʒ��mu�m�n�o��$�ɷ{{�{��6��J�X�d��I��T1.�9z[/�{XG$#BI�Q͋ۛ��*/Fi0�����)�9�9�S�-�AI��ҋeJ�|k�X�'[�I�p	�0�nC=8��%���>�0�A@	�YOb|a��^h�_d�]��*ڋ}�| ���T�����c����j�e�Td���;E�/������뎇��� q�.Dݪ�I���Jf�ܨ�K���`�::� ֭��n8�E��а��yE�C�����@�.�^y�>>���H�xFwa��N�4�O���k41,��۱7�?��  �� PK     ! V�Q��  s     word/styles.xml̝[sۺ��;����S����5���$����c9�3DBj�Py��~� %�^��[O�l]���X^��~����'��������$�Y��ݟO��}|�f%�&U��'O��������(�$/"Ȋ�4>�,�ru��W�K���Z�L�Py�J�2��KY�P�^�*]�R̅������ɤ��C(j�1��*�Yi��r.5Qe�R��5�q�Q��*W1/
�ѩ�y)�3=�TĹ*Ԣ|�7��E����/�[�1p�����}�r6�z�uO"���ß��=_�J��y��������Qee=��"�N��!�мOY!&�Ί���å���(��/E"&{���?�ßL�O��\��ޓ,�_�ǳW�gnO���{>a��م	�k6���l���+����¶�%�3kz�o�R��|p�v��2c˪R5�X@�w��#�'��~���S������J���Ķ���~}���~>yk��o�x*>�$���l)�cɳ�O��������XU����tjg�,��b�2s_�1��W ͷ+�m܆�{�6Jt�/93	 �>G��&�p���Y=�v�-TC�/���K5t�R��TC�/�Л�j�b���,�j#�f u��F4�c64��%4�c4��4�3���<Fs<��)U웅�d?���~��}Dw�.!��{�ݝ�ø��{ww:����a���ϭ�Zѵ�YV�v�B�2S%�J�k<�e�e�"����d#	0ufkvģi1��w�k���yi
�H-����r]L��8�~r��ڈ%��s^V�gDB�t�<�Y�)'6�T�QV�s���b�d,�%�÷&�$�̈́���ҘDL�Ź�5����gQ�+�.+)9�+����Ō/,f|e`1�G3�!jhD#�Ј���[=?�ƭ��[C#��6~��D)m�wW���2ǱG�c&�3� �w7�1����>g�ed�Jwc�mƶs����b��!Q�����[-�j���hT������l�o�/z�lh�h�Y5/;MkI�L;c��������3lk��"/�lЍ%��_�r��I����߱-k���g%��5H�^J?Ф�OO+���a4飒R=�8+sU�5��V�A�������Vj!����g��/l5z�n$�n^�LȈn������N�L�i�x��R�d��H��~���i:x����hk/�Yؕ ���$���2Sd�djy�byBC��y}�Iɉ�3���E��t^|���`5dy�d�0ǅ�LuGs��_<�꾪���з����R�F���/Z��K���=��K��-���m�6�J���S��<��]�w|���T���t����H6�JViVPn��n��Qo/ᔱ<�Cr���\$dbX�F%��Qi`a���Bǁ��Lǁ��V��-�<#����q`T��¨晅Q�3��g��#�X�E0�.�AR�9I���J��T��'"����Қv����Ae�E�Hs�Z.�k��?���k�E�/�#�LJ����mw86�}�ڮ0{'��.�H�	�=�����-�y�m7��,�e4[n��������낽����1?Y�����'�J��7S��3�|�;x��hE��m��ܮ�[��#a�oFZ��"������o�lj<��;�E���f�&�&�k
��͢�U��86g�:�<�f<�E~
�N~�`_�}��?�ٳc��mos���v=(s�Y���}��𛺮��)+x��9~⪕e��88����18��2�7������ɏ���t��{\���l�C���d�� ?b�r��@"�F�R�#PF�AF��Q!mT�@.�pF��8����BJ�Q!mT�@"�F��Q!m����7<Ȩ��6*D��
h������x�Qa|�Q!%Ĩ��6*D��
h�Bڨ�6*D��
�
)h�Bڨ�6j}�a�Qa<Ψ0>Ĩ�bTHA"�F��Q!mT�@"PF�AF��Q!mT�@՞,aT�3*�1*��R�F��Q!mT�@"�F��QAx�Q!mT�@"��gs��w����{���SWM�n�[�]��pԺW~��{.�z�:o<<���0��K��!j�iu�k/�@���v���K��Kͽ��)���T����	������F�U�Q_�u#�n�/�Z_�/Jѻ#ܗf��'�/[;�p��r�G�/3;�p���x���<�x�8�l�/����N���i	�Z�ch����	C�����'���b���Qh���0��ͰR��O�J	ARL��,5D�I#VjH�J���� �&\j�
��¤��2�Ԑ���R��!{1�RCT��&5\�a���Ԑ�����p�!*Xj�
�T�h�!+5$`��� �&\j�
�����GQZR�v�q�0'�Cvq��	�����j�!VKP���j��O���0TF?���֏B+�G�I�����7����W-y��UK�R㪥^�qՒ_j\��%5�Z�:<9�	AR㪥^�q�R�Ըj�/5�Z�W-uI������C�b¥�UK�R�%�Ըj�Kj\��%5�Z�W-y��UK�R㪥^�qՒ_j\��%5�Z�W-uI����R㪥^�q�R�Ԟji�� &ö$�_.�V���s�LR�is�~�:�<(���D�#���m���u�66/u[q��I���_A���c�yÞ�J�����͐nO���k����wi����V��1�U�u�m3w�P�g.�v���D�V�=M~��?��R~a�����U�e��t��4���y��o���&
/`�ݙ�e��0�x׿ߜ��NIㆎᶗS�i�Zv��B�u���]
)�f���y�����Ad�_i��_1�^���7��tZ�B��`����oN����{Λ����͋�S�̃�2�������4���O�����<m��"���[�2{k�}p^��q�XK�>Ϟ�ws7$�ˎw�`�V�9��I�nbjg�~yy�����Ż�  �� PK     ! ��?�  �     word/fontTable.xml��ۊ�0��}���e'كYg٦(�^��(�l��`4Jܼ}G�㶄�	�� �f>�~����� =(g+��%�
�S������=%��q��Q}Z��ؗ���[(��hBWf�V3�I���y���&3��w7��UZ�cV0vKG�����Z	�щ��6���K�Dg�U�h�%���]睐 �f����N�|q2Jx�3|��QBay����_��u�bQ~j��|��|� ��F�I_Zn0��Zm�J��[2�؁늲�m���-�<�4����d��l�kn�>�T���T�I?p�bSCT��=lYE_�b����Wt���zR�xWZ���'�EE$ΐ�D�L9xg68p�ī2�ٓ��p��#�E'��Gtf~�#>q�u�x�ݑ5*w����#wd�\��8�j���Ĺ�_�[FC�����}8�#��'d<��'   �� PK     ! �=��  �   docProps/app.xml �(�                                                                                                                                                                                                                                                                 �SAn�0���c�A[��pP��6�$����R$An����R���):����.%��S0D�l%V��(�*�j�W��~�U���`��J1������c ��`+�'�벌j��/[^�\����t]�^;�4���r��R�3�m���Ȏ��״u*���ѳ_-���W�i��A��*G`=`�by"r=Ƥe \hc��er�� ���h��7�V@����V�E�Qq;�-�nY�K$_`��)h:&�9�?��)2�T� ~�mbr�����^w`"��U�7i�[�)߁�T�B��(!bjX%4X�,�)ԍ&���l���2�����O��ߍ����3䨳8�d�3�qݸ��������w�q��Y���\���A�~�A�Ἡ����8��L�����$w�k{lO5�/��t��z�y��o|@'������  �� PK-      ! ��e  R                   [Content_Types].xmlPK-      ! ���   N               �  _rels/.relsPK-      ! 3�l  �               �  word/_rels/document.xml.relsPK-      ! '�ާ  �
               	  word/document.xmlPK- 
       ! %>���5 �5              �  word/media/image1.pngPK-      ! �R%�#  �               �B word/theme/theme1.xmlPK-      ! A"���  
               I word/settings.xmlPK-      ! [m��	  �                M word/webSettings.xmlPK-      ! �Ty�h  �               ;N docProps/core.xmlPK-      ! V�Q��  s               �P word/styles.xmlPK-      ! ��?�  �               �\ word/fontTable.xmlPK-      ! �=��  �               �^ docProps/app.xmlPK        �a                                                                                                                                                                                                                                                                                                 1475,'H','SAN JACINTO','SAN JACINTO SUD','TRINITY',1854,2044,2192,2356,2492,2613);
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
Insert into POPULATION values (1537,'I'PK     ! >RH�q  �   [Content_Types].xml �(�                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 ���j�0E����Ѷ�J�(��ɢ�eh
�*�8�i�����Ĕ�ĥI6y�{5��7F'+Q9��A�g	X�re������YQ�\hg!c[�l<��N�bBj3�@��G� #b�<X�.�ts��s�����"X�a�`��b�1y���:I Y�X7�^�k%R��l�˥�sHIY�ą��ou(+�v�7MP9$�U��kr�;�4�L�cZr��P}I��I��fnt�T�Pv��-�\Ft��h��$8'�i�%*hfxp���'Qs�����#wFX���b)~�;��;3�Ѡ;C m���?�
s̒:��O[%�����Q�{�O��q$����r#吷x�jǎ�  �� PK     ! ���   N   _rels/.rels �(�                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 ���j�0@���ѽQ���N/c���[IL��j���<��]�aG��ӓ�zs�Fu��]��U��	��^�[��x ����1x�p����f��#I)ʃ�Y���������*D��i")��c$���qU���~3��1��jH[{�=E����~
f?��3-���޲]�Tꓸ2�j)�,l0/%��b�
���z���ŉ�,	�	�/�|f\Z���?6�!Y�_�o�]A�  �� PK     ! ߵL�
  �   word/_rels/document.xml.rels �(�                                                                                                                                                                                                                                                                 ��MK�0���!�ݦ]u�t/"�U+xͦ�l���U��+��ťx�q�0������v���)Ȓ:����
ފ��ڕ��H�ί�V/�i�KԴ=�Hq��a��$ӠՔ�]<�|���j�k�k��4]�0f@~��RAؔ� �����}U����Yt|�B2ǛQd�P#+8$Id�����U����y�>���숽}�mG�$9��e�ٔ�rN��x2ُ������w\�m7�8FSwsJ|������y���   �� PK     ! 3��L  ��    word/document.xml�}i��J�����?��J���������/��6���;�0;����r���N/g4���HUfɌ����|2�L���S�T:i���П��''�b;���ԍ���)ˍ�6�8r>~h������������*NN�?�$��J���<O� �|�dd�+��������n`9@�6 �؟%il9Y֖�Qid��N_R�'j�qz2��2�����䏖zb��A޴�A��L��C�F�W��<]^r��R�J�/H���!�2?H>U�G���"��U�<�/�B�Yp�Q�?�~������=E���H�r|��|��dѧ�H4w��# N ��Y�i\$�����8:�hu�����|_��1��������<��85̰�m��V�O�Z�W�q��n���zn=����AA���-�q�"�� ��Y�0�\��x�vOH�phx�L��(^�q��������/o3�F���0���l���m':̝42r�����Z�M֏�V~Z9�"H�V'Z����4y6"ˏ�';��M�͇������nB�z��t��$t�q֧�m�HN���p['�������Dv�Oۼ���::v�'4�����֨ft5[��_h$��N׮��<(��@�����mbH\`�n�󍯧�/���w�L��8�>A��+�q�'XqX��!{�fẙ��#Q�Z)��|�輢���jb�����9a�`�o	o�N�5����q���Xmu�BA�R��:V�iþʝµM�JǠ���ڣU�k��ej�����)h�H}x��Sk�k{��ɭy)v�,!m/������,��.�������HqFn<�?t��[���+/N�*$�罻�W]鵛��ߖ�gct-��7�-1�CH����Z>͍� B��57��$ڧ^
^�Ժ��*�9�:ί����K�l:���~��&�u���ݙN�A��Zc˞�����s�4�+�1�K�;�OY:YGĬ��n�1�<�	}&"�q#��!�5EIA^W�xN�,���ԝ|�����a��,��$���-a�_��Ɇ�S����R�,������.	�?�"q
Zw����D�s';>������芼
��� ɼ6���v�7��Yoъi�|��x�dyw�'2tYbX�Ʒ������=����jKu�k_q���k�Pw�w;ݝ��O��/�`��s/�^�WI�g"i�7��v$�I�w\ZNӮK�΅���&G�PPk����/P��;�y�ļ2tC?�/�l�שS�(�[[q�^�?qr���V�$6� L@�IC 
�P�����6�s�v�oa����W�8���ð}�F~n�^��X6�e����=6I�?,�׷l��lV�������g�B	0�b�c��v���~b��N5���P��g��Ob�D���������7�k��[��Ͼ�Ѿ)����<����o��oو��7���_pk��	�?��_ּ��Լ�8>vS�ֹ�v�>:����1f�8PzI۶�-e��Z��V���s��2�':�^�=��/�$ȟ���[!��Ͼ��L������g��&���1���4X�5]g��h�``On$ҋxcV���M�_l�!��gg���,��6�]Y��6��w��5#dٷ��jaOy�t.���5���M����'_�Ͷrn�V�u����R�m���Cs�m�k�^��D���|�їܪ�-�)���-y}+yH�"��ޟ��E��V�n�3�W����W�{%�(��ÿ�db�c�`���݇���Jv�*�ݣ���i��z.�m�`n���׶���_wi/�.�d/Jv{�����?���ë�ȉ {�?i�P���4�U������v{������7��{�����$
�|���G���+�����J��?U��P�����x_���R/��@��{]k=�.�����0u�_��~��o���u��]f}΂��r��WC����W���+�;��v��o\�_��&��b�/�E�^�&��k@��O�W���~��`��iX�u���j	�m}����;�H;�{Y���������S��� ƻ��n��˺�g�l��ȝ����:n����X��������$�[U'�g��$�+���3�Av/����t�eaCѿNY�G���=T�'C���fǩ�A{�����Dx]}����î��[ۭ:|����0
�x��n�����%X^{����������ҌVa��n������,�ss�^)*��#�����(�`U�X��8��^��Sp��$2�M=���ۈ~y���W�<� Te�GA�~.��_�=A0�t<H�2�B�T7��d*%R��85um����S�]�2Rב��	�p�cÞ�2?�k�N8 �z��p�Ʃ��C���W�<?�X�	T��Fg�pSA�&� �)`s2���æ6���Cii$����⼫�ƥ^$�M�����7w��*k��:G$A�촒)ޞ�3G��^nr�8�����@��d;ǚ���H��ي��J��l,� u�5Q�ƚu�w�$4%��E��'hJ��Q�Յ��bĕ�r��D����&@�L��Ӄ�lh���n
�蒑��TM@��p_��j�p;��E�����s���PX���c�7Y�"֨K�+ۄ1I�t�������L���Xk���aX6�u��B(W8��	�*}��(F�J�(�@&0�bF�9�ExL��rIc(ZY�!T8�ҀrĔ`�l�+����1�P�,���"�UV�{r�	���ff5�<�����{��&��6&�*�CM�iT��]uJ*������q�����Plz�yr�����M�6��hF[i3���pD)P
�E\@�D��х�rd{�٠&�hU��r�{�F�����w��t�saqH��h4�r|v�G@a7��
Qf|>B�_p�ָ�H��Jf�k����~A�n4���}.Ԗ�Њ�r8��&��Q-7����F�=��IyJc��(�ڝC��'�����G&��F���1S�ca[����l`JI�^��PڸۼY���b��fc/�|s�$8м��d�U
�QǨ:�%�k� ��P���/tK3Y=o���,���]����zH�3O+"/5��*��8Y*�9�A�i�xQ�N�N(pj�,��"sN�K��p��Y�1W������#���l{�"�.+�9k�3��0.p�Qrj��qQ��b�锢��ֹDSbtt�U\l�:�-ře�&���p�V&��3px??���t(`h>M�e����*Cg3?�j5)V[u�*4���z5�Ɨ=c�4u e�'X�gd*�}��ͩj���0����8P<����
S�Ɯ�V*Y'd�L�Ixb�O/g��<r���4�`,xH̀ʴ�5�x��#��j��8��vb1��K?ˌ�z��]��f��4n�FN���� -{�P����C;��2و A� iav �z��!$��O5H���'�tC�N��\�M8�TЗ��O��4^5�\��OO��Lq{������g� <�r	4)x�K����� �M3�I*���l
̖͑�!)'4��[���DgnR-�Adh�q�g����3�q�%'��$��km��\��l�{�W8>+c (����%ǛP�L`�-�&MX������4f���v�h���{��g¡'�Y�T�ga+_� ,�l���l]�3=k��"��k�����܅,���l4�aԬHk�b�r1��%J'mQ��,hxnVʁ���Ȍp/h�BV�̃�Z\����������y��p�8=jsZ�tf3�,��Pie#�p,���8��w�f�8�������Լ�g&j�nM�N:ņ*���m���"�NL��sD�x�h1"��9��2�̌�l�"p~z�E%;WRK�S�D3@��V[�'83&d:')¨h�F�)��o7K�aa+'�IwN���tN����R�۶������/����;��1Y$:]������k���g� c�Z�#%?��m����)9���HM���Ŷ����H����tq�in��B+.X����)�@���f�tQZ��)R�,��h�i�'x=?fԆ:7�R%Ů
�$���5����t��������R�yinY��F�V-r~�F
=�u���M���7M�P���XE�lY�6K�
�T���,PKS�l�qS����]4�%C�Z0�s;�]��l!��� !/��	�&L�|�*�_�1%���%B%Xi�
�YS�qt:Tf�T��516/A-�����!-03�R�^^���	�ӣD���J���L\5VCM�.����0�,�d�t7p��괴��/��Z\偕l�"�/<1ɤ�̂b�^��
@Tl"�bd��l��U���K��i�F˵,��D�K�a<)�Z>��j��)Z�~^���RgKg˲;q����B5=7�#T�\m��.��{��֖�&R�c�k��J�f��K9�S�ՙZF��,�!#)�-#��Z�#}�/�	�����`ˊ/���n⣦�w�X?)AV�-������3A\� [�W���Z��tk�Am��-&�QwUx�f�5�8��k�&��0p�0K�^v���ʺ�ٙB����],A���B�Z��Z��Qv��q�)��'8fa�ݍ�Z0��f����:��v_bǁ��۴������vV�]�6�5��^8"�`�oa��I+�t�����Ǐ}�݈9����/���:�a~5��!���?���n�[�&1r���g8<L����S;Cy��CD��u?���u���'/5�������"���!�4Ć�	q]������w�v@<���Wzwpߏ���@�|7]�e��M���������i�C��H���>���*�ȝ:�c?<�q�18WQ� �F��o�_Ԕ�N\":+��~6�X���$lAW烓i{0�u��#ԋ�����"�Ry"p���I��)���,�	�mϾ!U�剘�Q۲���R��4����fK{��X�5�Xe����pw����zp8H�٦�ƙ�ɚo;si;�v�b��Hh�y��P{Ҽ������]v�44��}a;*�݉:`NeI�pYuM̀0��qwO{�j��z5QH}*������8C���R��9��j�B=\\b9�,L�8��JA] ե[g� �bZ��{�Ds����uwq�Z�����q�!�����Ri)'ӍH�ʣDʲN4��:��!Z�>و˙��s��O����<@<" �/lr2'hO����F)��i�0��H��:��rɯ'���0@�(�a���9�"���{�j0���5���=��%�Κ�����t	LN0�(��2���Y��TA�rC�H�����b���I���ܝ3�b�@�nЙLV uQ1��V���hg�m��v����u�o��rC����	�Ʈ.����ZCk	l�C�&3��e���<_��2����z<��$�l�z��!u��M�e�S�\�|r����n��*ߦS�=#�q �4#�!J�:a���>@X/7p�ʫO�ۑ��.NN����|�؂i�Zy �A���i�9��b�3�$��9؎&x𰈦��|���5=��<MC�Z�7�<��4X�N�	u3D]٫���5�;j�+�1�%xʞcW�����j�U��XMv���B<j"'�h��L0MP�
#�$4¸�I~(1�=\N�h� y!�y�������R�"U�����y�y<�/?��{���k�!AZR��}�?��]��J�l������w����~��>u��+�:��Hn�>2��3���^=:�R�9�:$;��n9��=����:&^�s�"y2�E
1[v��U�␲%LsPwx�,?��]/eƏ���.	߶cٝ�_�˻����������M��`��y ��y �;A�����>�Y-�=�aG, .u%qj��@V���;MLpq���-#�E�L	ӅI>6\Eʅ;?��hstEh_mk/���c[�#����RMC��O�-��"�0Y��CЬJ URǉ��٪cs�9�l����3��Ƹ��Ls��q�����ٺ%6I�� X���KN=�#� (b��Ej�v$�nS�gG8�H�o	�����wPV�7V'E}B=���KgZ `'͠�����?���mc��$�kdK�`g�c���������vlA���*�Q���;v����oÂ}��X��V������&Y�Q�!���`�����p�j��yѷV���fڲ;�Y�+"=��.h����bW���.��\��
�/����<����s��Iʔo/w�p
(�'�F���r(��|�[[Ju��58
&S���)E��5�B���E{�"�mĨؔ�E_��谺��l����l5X
�bD)�������!��:��G�#?U�d�G��4�ɸ�7̩���ʧ��rJА6���H\N�@���(Ʋ4�m�2��v��F���3���+;}`�2�$�
`[~3��c f�e�M�?`[�.���b�������� f�K��c�ٯ"��M]ߘڭ+���L�S��<P��<P��P��M9��TӿS���JA�Z�4|1�I�=޿SB6�ֵ$E�w����P�q�j�>���'T�u�L��e�	հH�N�[QͮE5�hln�nQM���4$�#�P(,Y����������wJ��
����3���:���CwT�Æ�c���� ��eH��/�~ԏWJ���/��6wX����>*�l3���H�o��o���~�>�ʌ��K�ْ"[sb~(*#u�e�)*��GevMC��E�����i�]�jL-]3�ߢ2�]T�}De��,��H�����߃b�A1��17=�0��1���^�����]��ٿ]�J��%�]=2��`��a�H��a��I���1F��������ݴ@%_���фc�c�F���m�T\#*Ci�#��l��G]��"٭����$��A�4'���:s�1�Fׇ�9�8�ۨ9K&#�w�U��r
&A٥5G3y��P
-�#�*�G�72� �Ǡw%)Y!��XQ�[�Ǽ�cƑT�������%���1�?�1��E8�c8�c���Y��d�ߎc�E���̀
OwG���3ā��hZ.�c ��N�%H�P%���E������IS��תH�tڠ�4C��9�%���d?�t��1��܄Ì\8$��J�)��L)�*d�`���X%BL�H�a^0o�CA�� �6�D=�*4���L���,5�	�fXcK�ܡ	��9��� �~������Y�H ���jl�ңM�-ܽ��

z�_�_���Ta���(��1����~�޴��Ǭ[%P�^�/�����\2{����P:���GO�ܸ���mz�}{%Ջ~�R�W�Z��(�/P�|m2��gc�2߯M�p�o�Ũ�1����KJ�p��<`��|��I�'���5�������2�O��$, ak37�G�a?l�3CV]8fm�eyBgJ��$6�F�^��*l0�g$��-8��eb��*����f�z>G��ᆝd���t!�ژ_���쳆 '�_)�Q=�I [d�����q�6WG|�g�9�W����ƌ$�k,L/�ш8#�#�	4>E�>3K;����< �cy�]���T��!�b�7V+]e���{f��u���q¯�e<�+雾�7|����7}�{��C3l�/�=��=��}�I}E���n����^b:�y_����&%� �(�M���D@��!G�i+w�4'��3��q��2�&I��e��r��$-�ux��q�$�(�?����4�[�]0aX�}gM����i6w��d�|�9�n���B�Έ��Lk��͗�ht�v$4kxИ����+�r �k����r2щ����DW����@�w����/v��f�|eӿ.I�G��o�w���.����rB��훼�����uk��qw�v�^�����J��al����?8v��������N���зy�_ ���߲[`�ƫ������^�[�}���/Z=�����O/����M�"���E��x���7<�#z$��s,��%�Ε�����	�6S"�����X���Uω��G����sS���`��!R���2_d�aD�f��@�0�|Q�`4/l4]�����q�,��>�������Î��Iq.B�iS^m�f/,p-e����Сx,&���l-��L�����r�����tg�mе��2ƶVrVytei�"�周8RK��A��M�3�G�rE�Qd��M���R֚���[|�p�:������.07�a\>��u.�x�{�����]M�Z��e��G�M�U�U�PD"	Э�(@�$��_Bw�����9�݀`+�5�k�������J��>ݔ��Aߧ�b���%���Z9d{T�s�k]���L]��u�����%�I+b����Sy�#׉M�b����H�r�������8%��2hN"�kvx���:.I��*;:�����#�ؘ��!+n�k�Vk�8(��͎W�l��G��g���&m#[C"�����K���ͻr/����3�)ʊ��!o��5��+N�M@�\K�ŖA�$�T:��=���нřk�Ll�]��i�u-��>sL�ix���,�Q���Z��h�u���H�!4��G�;7ǿ_�پ�� ���H_��%���#��'����e:�lr�����) ���sUR`�� �r?�}�|��v;Z\6´��|Tv�!�<=��|b�v�|�p� |��k)����V號W�z^��jn�z�b�[��(�)rFx��y,��U�e�8Y�����9�rv����-3Ĺ�qG43@�䷠����W}�}N�)?����cuOݯi��no�n�}���⧱���������n���5�LdV��=d��Q����i�i�h�c�v����h��2��o7�"Vx۷�4��ZI8��� �}�����cෟ�ԉ_{�����]��Q��;<����=,Z��sC��e?\��e?\�]6TPұ��w�l�fw�:��X���Y�J��}�W��� ��N�wT��#�M�1��lj��b7"OY�F��`���B�Z��S,<�8b@u�9vY�7�x�Nޡ����Hu�T�FCa��|/`ū�8I^�g�z��I�caPf.޶�je�{vt�+gp��"���RY�D��<weP�r�����<)�NنrΝ�C�ܙ�.�
�UЗ��L�pN�����<�/3�~���һ#��2�^����u��k�M�y�˯�����蛍�^��Ѡ��4���K���������6ߏ��2�S9�r/O���hW�������.����]�g�۷�6������G�U�xD`�+~�q�b;��1,� ע~ɨ��?s�n�|3�!9?Ux-rQx���[gJ��cB��$gў*�@��38`�n=���j���&��*_�/�5;-�G�u�E���t%F�B��������{���]n�՚#�N���q�*�9TK$ċ�ŵE
󛾜��Ҕ�T�.ȕ;CIl�i�r'�Ѫ��fZ��Ђ�*v��2Ș ��qu�ތ���,�=����?�i�������ԛ�.�ʹ������|�i�z��q���0�W9��2h�]��'�G��p�w�p׿�]+�E^�x�x˖���Ӗ�N!�3?f��B���j���4�uu���w��xZ�img��k�\��N�[*4X/֒������]K2�f�J�1 ���$6�0sdyH	��[v��#h_���U)>♇r勘i�P{8��$Cۉ�4Wa��@��̵�	a ���fh����O�em���Ѯ��(eP��h��!3q�w�����V��<���l�r�w�엉��ד�FP��^\6�@������ox��[�����7m�/�;���`��A��y�={�ʦ0V�I���լĺ���^o���}�͠�h����j���p3>Y"��&²��	��_5�h���\�am^�P?��^�� �����"��S �l.2����V�L�Ē���W�lb0�`�E3UB�3@��2� ǈ�8��*C���·�l4��2e�j#C��{�0X�B?��?���_�u� �;u/���;�5����F��W�}Ϩ}M�]|��za��d�c����w�֛����뙨_��
H��z7	�_�gw=�G���~�q{�N0����e?\��e�e箬�� �&�>؞�h�f~��)7M�h���PnB�6����N��AmeC�^�	�"��A��Mt^�P�HVx|Ld��b\`��Ҷ�Z[�b�W�M���^B����r��±V<S֭V�� ��([�����S�Ku�@�"�Sh�o�sb`�7�eP-�B��8Rv��Ds}ʔ���>�=U�;���^�=��E��۞� w����[�^mS9�}�����m����(Q�;���`��.��.�k.[;��M1��|u|��&R�gL�RB]��2���y͜��T�ݩ��D��`���
0�3T]�v�xuHk[��b҆P!�D1 �+=h$�,n�4�5}٣P�4V,�_�
�-}V,M�z��x�\A���0����ji��5�w�@��~����hω%Ȕ�(��k�����&9N����uq�����i�?p.(���� &Ao��=�锆�	X��>>|���G����zO�>>5-|7}|E-k��}��e����忖>N�u���#'`��&��� ����P��>��>��>{�e��a��1��U�G�'`W}��9�v5���z��м�;-78�`1�:����T��p�QS��f�ק0[���	�|�uD�x,%2=��Kv�HQ��xӇ�:eI2�F�fG��赸\�r��0�px�Y �j՝Y%mW�9��,����6<$�T1n�pA��䩍�QC�����)Sa����������}av�wɓj�����0S=�~]ah�u:����c�t>�f�����O�f0>j���a6�����i�|��y���4{�w���Ox�m�:a�ܞfۏ7�}~���r>�NV��S���--��عq��K���:��|���T��������c�0�~8�?~����㵹�_;��g��OH�MԬ����t<?��5^8̕���F�T�:f�/����˄��C#���R{z��p�c3��~���1!ph�ߖ���^���)�bA��s/i��<�~��/UO����[8��<�`|�������d���;�����彷��3�Tſh�4��4C^~������_c�C�������{d�te8~����� �0��=�)Ӟ�zv�$v�#;��|�"}�ORU/��"O�X�z9|�o-���������t��s�O�(��_�>�W�� XX��/C��s�<2��0��OE0
A�p02���}�a��L����*�?��|+O��-��L\��D�-����{i�XNQ��C#1�o���7���i��e�'�P����Hq�zF|q�n��v�$���u�SF��.��L1�25n��7{Wč��|����oN�\:I�i���A�c4n�|QN�>_2�|����� ��l���Ÿ=YsY�Tj6ʉ|���@�/���O��W&��"��!ո��K��}px�S2)7�� 12j�|E��]��J!��/�Bʫ��I��J(�j���v��U��-ޞ{n�ީ����ʳ��P;F��!"�[|'��������}�b﫼����n���'S[�7��N��w}R�C��s�븯���� ��о���|���0F��i�-Gٚ���	��#����7y:k0���x}<�{�w��	�{���/c3^�Z�:D��=:��'�����5�އ|0:9��V�μ5{�������xq�Ce���������3Jq���}��݉s؏j.O���Z��R�����܈^`��é��t�/d�b �/p���w2��ח�����g�?�N>T�_����w'�ۇ�P�2�����~���-�����1��L��۞S��>���HF�*��_��s����^5T2���������/|10��������J�,r��8t�����m(I:��L��X7w�n�8!ї׷�b�Ւ�*͖?/�����`& K� ���	2����\����g���<&P1�q?��%��͍��o�n�]��0�qj�ګ�mQ�\���Xu����ڰ������N�`2!�B��I�iH���0�D��e�Κ��J�Jiu���>nJX�&�B������̶6��[>�-���	�8
�v���<�īr�4B!��v��h~8�Fs#�,&	�8������ǪL��R%��.�� �M�9�A�����]f�xX��Y�^�L�"Χ�S�^w����;��.ʮ�4n�(>@�:]sݏv�
�-����]��G�(,]���p&OoxZ#�P��������<�\��`�'(I0�d�n�`.���>�^�
��B����9�Q��6��g���辒�U�Up���@S���M�CL^LlF�R�S:�>Eh!2+{�xB����	�O���0�� �4`���m�ޙÊ��/����1fe�#��hj�7�P�m��r3@��8A~��ckBr��#�T��e��i����m�P]�5�̓��r��au�%ⲿ�:�8�hk.��%�K���,�^�'.��q[�'�D��EI��(���b���4�ʽ	#-�9� ��������j�V[:H�@�9I��\��E6�i�Q�N!����x�3������G���ʶ On����:��� ��$*%�k����,��*����a���Jvv�q��<���铃��w9�ՄúX̽d�OT2\d�e9z��q1j�����`2d�r�X��~2�_��v}��bA�WO4Qds�H#�t�zݶ�L����������8H��X�0۳v�ٖv�2��D!��L���RB3�8�w��!{�Gi�7��!�z.����V��"W�NI,C_	?�81�1D�B�"�p{8 ��js���!1MX��v��B�SBpr���3nW�8(UJ
4^V�vm�:Nؔ�Q��u����B	V�^�]��$�;����l��!M���<d���o
娭Su�_'����ɦ!4IET���uݞk1�/0��Z����M�d�X�umĤo^N��ب��hwm�N��b�T�f��t4������+����:BJ㬐q��=�i4��AF)v7�S���ˣg��>���u�8f�6ܡ6�f����C8G#���A���t{�aW��4��e��T�+\E�p�k����j��Kμ�7�"D#<�6��b�h�[�&�����_�y'�O��pkCB�#(�0��\y3�t2��%��;��CQ`&�z�S0�Mp�0i!A.��d_��h&�b �<=�A*�g{�̈5��Z^l�e9mc2ǖ./ )�t�)$���9<����7�(o̅�0�����|��FA�<�������5s������홓}}�q�eeX�����9<5ģ��5���,�:�0�^os�1<.����֐��u����ek�>B�+�;0��������2���+��9����<I���:2M�Ԁ��y�4�,`%�~�L�$���y>��"2� 8��+�iF`r(�ߏL��5a�_G�a
�M�4LbÄ���}���gd��4�.A~	����p���1����_{C?��E�wnrFL�����(�	����'�w��X��Ȏ���g�{H%��5��L�����U���ˍd�����b,s?r��������ȏ�����yy�t�s
L��Q|��	)��n���(�a4�Jw�����+��khml9Z�g!f?}r�6�g�`����_��?[&�����/�s��u=��ƺ��b�&��M����E��HU�ђ{t�UۂP���|�)��-�ۤ��탐&:��W׈4��8�����q, t�.T���u��\�v3+O�|�p�.�Z:�Vl�I��;�o��B�v�(e��%�|5=�V�e^n$	C�~�hZ���rj��5'��-2�p|�N� �HIU)0w5J۳����R,#)Cy��ne�LȋŒ?�!�)���_�ل��J!>��ו��8����ڋq�`ĕȒi���v����@CPc�<Y���5�E-���zִ�&�a%*�-�	�a�0{F�3d'�n}~��U�s�d� _ut���Q�Y���5U<�s&��<3 �Ύ�*���j,pu���(�B�-�EA����ǘ/LdMw�ƈe1�o�Eo��mQ'8Uq��ryS_Y?��{[���9^�\X�B�l����m��yV�u�?�kӿ&u�պQ�M5���)����y���M� �V�9Ǘ�S���h-�zs.�a9�/5lP���?}�*�4�M�bOsk��T�-�rE��r����o��=*�d��7����ؘ �f:Tt7�jS
�j �!_v:ElZ§m��Z�����������M��d���h�k��y����zys\�Rg����,]�B�|N�v�r����Zl�Q��;Eǉr9p�3ҮEе	�6_�"���+�3�*�3[PpG7�=� kѓg�i�
q-#	�m�ݺҶ�~jħy|,mT|iYĊ�G�ւ7��Џw+뼆[�d�]�Qd�{�03�v?o_����y���YYg("oWֹ�0��{68�o~��9+�Z^R�Wtp�28$����e�с�]�2ݰ��?��9���a3�2�O��B����=� �t`�����㩗��L��(y�z�S|D�|��8	�,G2�;�b�! ���I�e>�1��p�����>|߃��~|�<yc�A���I���g��~t��o�`��xyCw���{��X����`�4U]qv�卓i���5�N�����^^����A�����s�����(0�&�V�����\�����^�2�ȁϮw�Vp���eAv��a�j�J.�iYF�����$�N-"W�,��f���3
5քk��d갖N��uQ�6�W�SQ�fw+�B����^�(���,����� ��� ��� $���jΚ��e��y�Jڒ��
6d<8K�b��q���M�%��/%�c�u�+*L��Z\T��ew�g}�Y�.�ƞ��dS4�A+���zQ��W+�b���;������'��^���#s��i4/��Ր��N$6�1�
���p���`7Gx�
�.�V[G�Bj�y+��򄉗�a����C� 
K�Q��s�����M ��9ɥ|����ܚI�6�����h��\"�	��(��a�c�5��LY���D(!;�ѻ]_i�I�]��ܦ�mx�wM�m�$Y�n~�����"�˹����.8#�9˦6�x_<��c\��/V��&e a�4�n^^Ig��GNҚ�$tK��Y�"��qd�`J���w�YJ(:��D�nS�^������2��[9h3����0�[5{�8ܓ�����e�bzӜ֞�^�����z�X6�$�+]�������n��yV�!ۀ��Y+����a��/�e $��	�v�T�Jl�%�M��Õ��p�m��R��s��h���MQ:zɪ��%�_�$S�6N��r����K�	%}������:�7��t4��[����W�ܻ��Ͷ�v��铿����q��@�����b��4���ѯR��C��`h`��y�2AQ(�w�2�10�`���-�wC���[�w���wԗ��{������!`�f�&�ޯ.�~7���ݏ��f��0�[������ ��֏�Z	������w�,�(��	x�}^9����
>K�����@��6�6b��N%o�~ndi�n�ԅ�NX_hY�����`�"��:��P%:����\�O�:\�e-
}�q���ɔ^h�&�<���s)RZ�\q��j6�d'jX�FKԂw��^���I��i4�Ɍ�(4^�9m�F
�d�dn�@�@�JmZ����|��'פ�)�b�-��s}Z������7n��Z	خ��A[&�ȅ�Vݫ�������y��o�C���e� qLj��N�:�� q��B���g
�[�<N�/2�@�%�6(��h��g��;��]P�=�n#��=<�6�HI�i�BB��p76��ra=��6+�s|��Q�D]��q�Q`]DH����<�Æ[��\])ǭ���+$1�3[%7��<F��FIK^WDG��k�����T���V> Y�H@�0���C��cQJj��i��G�ʱ�-��?�5[^N���1�-(���,��t�����1��h���$����Be+��Z�.���>{:�S��V/D�9��;c�A>�Ec�#�쮛}im����7�k��vAu8i���G[~h��([�U�Z��J\E 0�~R��鉹�������R�.�8�}Ed��j8J���a�+�V�vض�R�w�֎Sf�A[�9���=x��H	���z����;��f�`�$�[���#?���<�A�{���@��:D���ӧw|:��}��/Z<�zwU�������D=d<�D���� �=�zL�i�S��%�࿏�4X�m��7��z�ҧ���^Z��#Qo��v0�1�z
� 瑨�V�Am�c�jCǩ��zm̈́�"z�8������g=������zk���g=��z�:�ٳQ@�\�rJMucg�P�8�P�6��_��m=U]����֭߷���źPDA���!g� r}��,��6l�l�l;��:4��$�CƟ��hk��#�K~�	=#���K��1̾fr=�-oJ���,7����N���s��i��	�&r�6�F��xa^h�M��jD����w5�M�a��%\��E.�(����'�Q��Q/Ș�G�ie�3��X�zjW��2�+�7�;�-'>��2]�+Q�Jd��n����{�i�T+����j�2�6��N9CL�9}�{ۃ�.l�����`��%A������!�{Ӯ�v�:�&r����~�G�:���nW�����(O�W�7�;A�����y��
����Uۭ��rTU�;�qQm~�&�x&�]-�&3�h��͖�B�;�F���/.�f����B~��ѭ9l�U����n�h�r|-l�~ki������-�cc�[JygT��5Kw�;-4�-��.^*�2�R�D�9G+���e�P\aQpk�7�Ea����ꦶ�p-!�e��:��z�n��1�6yti����:�[��4�mG�:ve�䷪Bn6?�Y�g�n�ΦqX�z|iaK!O�'u�r��5��Ԟ/�n����%�؞4\�۬3�V�.:��K̜W���d��L8����l�.��s"�I =>Sk�����bjU�[շ��U�wU6�
1
@R��bj=뽦�NׄԲ+EuP��b�ެS�
���PT�b*4���������j�Ct?��Gw��=3���KST�z�'��(��P���Wx���s�Ӈ^KCO��}yO_��h0���X�O����O_�?�3K�5�_P������/U��͛}T�\�˜���b��H��4HF�8ms�?m_�����l�&zᡃz�>�l<M[[ҸlP��c_�������^o�Kwű��1��b9:�N�2��-2b8����"��J�A�]0���INW�K4����?�I41F�r#l*H;D6���U����Mj%�v���3��[��9Xt�3����D6�xSl�� �4��,��/m���PW:cMx_��R�/���G�i����UW{?�v[K��{.�I8��}zD�K�)xE��;�A<��s�R�|c�+�[���IF�0�2cq��Kd�z2N����� i!\d ����>#�r�Ii��ú��}^ũ��G�O�Z��Jv�C6c�qa��	*x��	R����#�V!�6���2���}�H=��P�3z���Gp+d�9��04ƚ�w8~��L�?�a�Bx�hK�ˑ� Vʃ���C�?\}$�>��:�����1���Y;۵�n�?x��=�OlU��}�@&��o�;9�Gꙩ�M[7G�C�9��3d�e�H�����1�Hi��u�Y9g�Z:���2Um��E?E�m���C�#������V_�x�wa����R�^tq�d�Ł�v�l<c�Kg�Ō|"F��=��P�m1B�-1pQ6�� dU;�H���X��m�8���h1�r��ۏ��S9����'�0����9%�]V��罱�ݹc�����U��0	�t��6W��8�858�v�������AG���$O��[�yiD���*��+-��P��
�,���K2ZU�����T�w@Y�+i��R�|�I=��+%���kFuIMzX� �֩ƨt����3��S��uԟ��z~�������l#k�V��(q��j���f*O���Vk���K@�ۧ��r��Q����T}��7(5��:&U"c��:�����y�Y�X�eW���rA˞�G���-���@��TU7HV E�u�a�*�L�a��='�VR7����LKЏ����]��8鎼0��3�V��V5j0Pg��ny�n��� �`�<$�����U�-��q͗�iW?[ݵ��
��
�qT� ����y��F뾷=z��UB��x�RL�+�6�Nߤ(�Cp�����F��������z�nϵ��x�ݕş��ߴ�@�f�vxG�n��"��� u�(�Ux�#�3*�-�$F�K���2����V�?|�6_0�(�\~�����Z@>�էQ�eo��{K�Ĕ�~G詊|���w����W���7�lB��6���� ^�����Ϡ�Μa����Wf���{����3������_�1�� �T½'��EB/���P$��Oq!��TU������-��0|�xp��w��~M|A$}I2�Kp���rW`<�� ���r�O@=���%8WA��_������ƃ/�]!� w�$=�gCyՇ���)�M@{��),�[Haa<�B�),����Ia?d$�NYh�¾���x ��C< [�B
�)��"��~�P),�� ���W�),�[Haa<�B��R�Ϥ��C
�,4Ha�tHaa<���!�mU!�����g�$��X�
g�?g�X�^�}�^wvDK�u���������Ǉ#_��m�[$ް݃S�o��|����c���i �ǔk�&r�z浣��M���f@^;ܥ���*ی��Y3LE/5�Vb�k��:�EWe�, ���  �� PK     ! 0�C)  �     word/theme/theme1.xml�YKoG�W�w����Ŏ-��Pq�w��f�	�Up�T�*�z(Ro=Tm�@�~��T-��
���z�c���T�����ߏ��/^�3tD��<iy��U���Mw��;��!�p`���&Dz��?��"�R�	�Dn�)�nU*҇e,��$�7�"�
�"�ߘU���z%�4�P�c`{c8�>A}��۞2�2�J��>��5�(6��CNd�	t�Y�9?�CK-�j>^e�b� bj	m��g>9]N��N�����kl^�-� S��n����
~�},�t)c��Z{ʳʆ��;�f�a�K����v��i�(6����N��P6l.����t�-�e��|���z��P�h2Z@�x�) Cή8� ߘ&�U)eWF��e��;\� `��M���d�}�up<kx���N��˅%-I_�T���S1��x�㋧��ɽ''�~9������+8	�TϿ�������Wn�,����~��Te೯���ѳo>������2�Oc"�ur�x�9��x=�~�i�b'	%N��q��*���'��ѱpmb{��^߱>��XQ�j[�=�Y��MW����I�.�e��G.ٝ��v�)��4-mhD,5���$!
�=>"�Av�R˯{�\�B�)jc�tI��l�]�1�e�R�m�f�js�b�K�l$Tf.��Yn���
�N�q���kXE.%'·.D:$��n@�t��Kݫz�3�{l�H��ȅ��9/#w���8u�L����H� E1��ʩ�+D�!8Y�[�X�~umߤ���,A��X�J�p�'l��a^���1M^ָ�ΝI8����ٷݝ��l�;��r��|�^��o�.��w�]<N�	���9�o���漬�Ͼ%Ϻ�9�OچM���=���	#פ���z�h&��8�sq.،������� �f$�2gJ�r	W���7�������R	h��x�-��/�3ͅv*hM3XU�څ�	�e��Ռj��
����#�&������z=��	��3Ӱ�y�d���H۽hH��m�����65�SH[%Heq�%��;M��fQ�u;W�,�g��j֛�q��p܂a�?�[fa��|����b�7؝���R�-��j�(�2[9Kf�כ퇳1�эV�bm���0�rh�pH|�de6���Xq�h��� ��:U���JxU�\�jv`fW~^���ՁY�'��Z��͸���J��9���S�gdJ9��g��̅�Z��>F:G[*�Ѕ҈�=#�BPZ%��/�ZWr4�[SPpbQ4D�B�S� d_�v��Y-�ye��>S�+��9 G��u��k�=M�I����=ϝ1u���'�,m^�x0�ѯ*���K���ө�ڬc-��7W~զpMA�7>��o�� ����D� �e�K1@�l1��Ye��c�,��9g����]���rqo��|d���GWWK�R�Ș��?Y|pd���h̔4���p)�L�� >�DC��   �� PK     ! ����  �
     word/settings.xml�V[��8~_i���2$!����P�Sm��� '1`�o�Z���$�04[�[�	��������3��V�����`^�������μ�6���
��	k����9&bz &�NX�����d4��3�o��ȭP�T�C꩒�B0��	%�4
}�f�«OZCF
%��������q����J���G
S�Ap�'R;k��Zr�~�āQ'w�+�=
U�h\�U�JXk� F]��w�������m��)P��ty���4�&��z �B��6V$�;.�)t%�3���[h˯B��1�Xp7o�{#��x�*jQ�!A� �i���)T�2�
�Z*�Q�:�R|&��UP�V����5� 1�U�oD	{L*E���U��Cjg./	�_EJ�h����k>#_�/?T��Xw�OD� 0��?��=�$^cd*(�/rV�Ě�!J	u�K��_�l�X���@�%�u��cT���I���6�%\jw�K�D}<��a�������N��0�e�E~��c��t�\�1�8&m/��<�6����] 9�}�2W񲗉�u��L���3�ᴏy7�f鬗�gi��[{[,����r';z�h��加��>#+���%��1�:|�dU���!4C��a79�^X,)��+���t�Ԯ��J�^���[vEb���lأB�)'DQ�I�y ���3��a;�Q/?T]��<���hԫ��#V�b>���#HUf�o����`�Q�ۛ�����A��.l����?Pa3���a�����wX䰨�b��6q��b{����-���#.�w�wPS�G���
�K4@�x��!�����c&I��3ܑN�z+M�IT敬嬰|m�D�U�J�n�X�Zh�����i�i�D�������G�qR�⾴ot�����t��A��h��g����y
�f2�������h��  �� PK     ! t?9z�   (   customXml/_rels/item1.xml.rels �(�                                                                                                                                                                                                                                                                 �ϱ��0�����ho��P��K)t;J�GILc�Xji߾�+t�(���Q���E]1��h��jP>N~��j����.�����G{��J	����D60��o���,W�0��H9X)c�t��l'�_u����ݓ���|P�=�;6��w�#w	�E�v
���d*���yB1��ߪ��	�k���  �� PK     ! �4&"�   U   ( customXml/itemProps1.xml �$ (�                                  ���J�0��¾C�{6�i�vi����^E�k6M�@��$E|wS<�GO�7���3�����]���ep�� )+]�������@!
ۋ�Y��:8�����^D����A��S�p_Ou��{�E�ո���u�q���\T�����(�m:L1.GB���a�e�ppވ�Џ����;�e#ɳ�"rMz�ffh�<���j��E[���媯�v���	�m���7�h   �� PK     ! ~��  s     word/styles.xmlĝ]sۺ��;����U{�Ȳ��x�s�v��s��'r�k��$�$��#�����i	�n�+[���w_K��o��$q��g����`��p�4��H���7�A^�4b�L������?��/�=���k��@��<	/��X��y��	���%O՛3�%�P/��0a�S�<e�d���X�ã���A�ɺP�l&B�I�e����3+�L�X�+�sڳ̢e&C��j����%L�k���f2���ڙ�G��G��$� Np��5 	�����4V��z(���H�����q���CV��_�?72-�������eI���^���w8ˋ�\��7���w¼�6_�H����?��_,���\�lm�Y:_m������k�Tq/,;�\��a�c�_kw���L�K
��\e�VCc����t��{�ǖ���1���;#�N�ߤr�z�Ͼ���G�B�q10m��?�2!3������[E<�>�.D�.x�#��f��7&[��,S���ld� Σ�/!_��W�Lk�U��ӥ�4n�����j%����	 �"L�Q�#�[{��,w��|
����:~��Nު!c��h��z�V���!�F��2"lP�qnDsfCs^BsVAsN@s���8��q�)�S�Е�V����������?$�q����'|?���ݏ�:�����'k<�Zjw�fi��e3)�T<(�KK�TE4<}���N`���>���̼ޟ!Ƥ���Br��31/3UL��8O�X���"�#f�(3ǈ��t�g<�i�)��+� -�)An.ٜ��ӈx�VD�Ia�Ъ~^h���NX���]��l~�"��c�!�Uǜ���&��m`0�K��_L���Ҍj�j�H�4��iD�V�'ո�4�q�iD�V���ۣ(b3�۫�Q�swױ��{�c"�)S������i��26��r���X{���\��5x�8��IT�z�"�j�EZ��-���<"{�yD[��[�^-��햦���ӢѴ��ɴ�Ղ���X�?�6�YNf�f,A��Y-'�̷�e��mX�m�;+�v�F�2���4|���*˞z�nd�g�'E&�\�-d$�d���r�raj�-D�C��
xpϖ�w�!f"����A�DЭ n��r��L=04�+Y2!c�g���O�N��KU��D{{Itz����A�"Ɉ����"$�P����N%�"�Cƫ/���8aɲZtxK͋�j�!X�?Y&�y!*S=���ӆy9��Ou_e@rf�[Y��f�k��p��	[��K��:<��%��-\����Q��u��\8/�z�vwţ����_͓��feL7�+ ���dC(�2Is�=6<�6<��%L�#8%gx��DD&��Q)a`T2�F*@�o�X��_ӱ`���S��� �*�H�DWy,U�U�U�U��?|6S�`�C����9Iw�I�,eƲW"����	Ҋ��ə�A�՗�	��uL�خpT"��S��ie�Έ�8������c"��'���;9zw�!f!_�8�c�ܱ�^�T�e�v�t��i�/b�(��b}��Ɯ�\�[a�l����,Ma�<e��(���t�=�d�V�����Jb+�c$l�t�f��y�1���c���Vd�>��1���g]�9��-����Ͷ%�:�)�ڲh�*�e�P�n�q�w3�;�"7c'7���܈6�}翄>�c&M�����͍�"����g)���[����u�Ni΃Fθ����Y�=���7���Ft��܈N3�35%�)��&7��$�F�g+xD��V07[�x��
R|f�� 7��r��@"�F�Rp#PF�^F��Q!mT�@.�pF��8��x�B��Q!mT�@"�F��Q!mTϵ�3�˨��6*D��
h���b��x�Qa��Q!�Ǩ��6*D��
h�Bڨ�6*D��
½�
)h�Bڨ�6ju���Qa<Ψ0�Ǩ��cTHA"�F��Q!mT�@"PF�^F��Q!mT�@�\,�aT�3*��1*��R�F��Q!mT�@"�F��QA��Q!mT�@"��D����������N}�o�Q��U�ܬ��"\I�4�x86�F7���B�SԎ��6�|%u���u�>6��.��B�k� ~�5�S9nKy;y�m�nG�U�q��kG���qۤk|��R�:��i�
9��fk+q�m�n���@8�m�x��y7���8���_
m�h�܄���Z��ch����	]�s���&��tb�ºQh��(?��ͰR��M�J	^R����-5D�I'F�Ԑ���rv���!�[j��ʰRCVjH�J�����KQ�RC���pq���RCVjH�`���(o�!�OjP%����Ԑ�����!�[j�j�ڜEْ���[�Y�������@�jɊ���,�g��Zi���l�܄��	]etPz:1xa�(��n��Ըj�Ij��	X�qՒSj\��*5�Zj�W-���UKMR㪥&��'g7�Kj\��*5�Zj�W-���UKMR㪥&�q�R��=�N��Ըj�Uj\��W-5I������UKMR�%�Ըj�Uj\��*5�ZrK������UKMR㪥&�qՒSj\��*5�Zj��Q-������d�������n���� �/��E�%�`ݓ�~$U��t��`X�haS�B�ֿ��h����m<�7Pwv�T���fV���ts)����e��~z�[�l$i�J5W?�i����?Ӹzh���.��~`U���U(��5��{V}Z.���������wޟV�����D��;S�������+�Δ�nhn�u��#��ۖ]ֽ��]6���vi��jD�j��5����ŝ@w���?{�\�1Q��������x�z�� ������9����	���9y��0_���a�X�Q}���Wm��n�e�	�\����vshw�۔6���8c���ҭ��k�W���  �� PK     ! ���U  �   docProps/core.xml �(�                                                                                                                                                                                                                                                                 ���N�0��M|���[�!��61\�1aF�]��qk��0x{�"1^6�;_���l���`�
%s�D1
@2Ņ\�轜�(��JN+%!G;�h\��dL����86�&i	�9Z9�	Ɩ���6��Ņ25u�h�XS�M���8���Q�
C��A�Y��kSu�0TP�t'Q�O�S۫]匬��i���=�������A����9{�w��B�Y1@E�a�S��(iו�sU����F��2|��VԺ��~!�?����Ͷ�6�}�b��1;���x��!�Տ���乜�"��a߇ɰLr�H�����$���8*�G�ƣ��&��P�   �� PK     ! ��\��   �    ( customXml/item1.xml �$ (�                                  �I�
�/-JN-VN�IM.IM	.��I�U�qpԋ�QR �%��bJ
�9y�VI�J%%V��������z��y@������ �(]??--39�%?�475�D����L?)3)'3?�(� �jU���ч{Ǝ�   �� PK     ! ��9�  �     word/fontTable.xml���n�0��'���!Y�J�5k���b��qL��?��	���6-�Z6$�c؟��~h��iME�%�0���W�����$���1e���I yX�wߕ�5�o�Լ"��m�����l+k�4�����f�����V��˭TҟҜ�%0�-[ג�O��0���:��h4��3�{��n�:� �Y���L�� -��`k?��+�Q8=���V� �i�|h^~���V�|\I�0��']i��)�u�/��X֎LU��tC�wA��I�0�7́�8�ƸfZ��9�N�B+=o���9K �X8��V��o6$&YE
>��$��lH�cBC�{Nq���=g��L���RH��.�j53W��t�&�#��O2�z�T#���F֘|�-�F�^79��W|E�#�MT��5��D,���O�k"��"�L��f"�B�Zc���k��CB�I��<$��~  �� PK     ! �(aИ  0     word/webSettings.xml�MO�0��H��*w�n�*6�	���_�4u��$��le�z�v_l؉�د㧶޶�ZESp^��v+a��4�>{}�::e��\��>��g�Ã�*� �規�b|�E��C�Y{1�}-*��4��Q��{��#��� s�d�ŝ$�����e)\��h0��("��ci��V��V�+�C��>Z5<ͥYa����¡�2�h��D5���Ii���:+���Ƞ�"h��`l@r�gTe� ��N���q}!�bvY�\Q��s�,��2,�d�>�����8�Po�4Ȱp�(�{�:��9�7,��*$��$`�P��י�h�^���>��z�&��{�&gg�n���_�ќ���6H-?�
��a��5O5{0ow�uƕ������m��_   �� PK     ! 	L��  �   docProps/app.xml �(�                                                                                                                                                                                                                                                                 �S�n�0��?�'���XEŐb�a[�mϬL'BeI�ج��O���v�O���I���Q;�d�t�
�������6�H`k0��1�k����1��X$	�lO��G���4�m�4.�@��wM��8�ܢ%>��.9���Y��8�{Ek���x_}ғ��� �?�I3���QQ9S�eyU��@�ve��@<�PG9��Gb�� �Re��J�_�7Z���Z]C�m������-���(g�����mo��X�] �u70�U`p��/0�5B��t�w���PD�;MwΊG����d,���'6>R��&����q��l���<$|!�6�m����l硷:�3vv��/Օk=أ\�/�D��'ȃ9%r�❯�M^�ז�GK�i����.��ue�6E�N�F4�:=(�����֧�y����W�����uu����*�  �� PK-      ! >RH�q  �                   [Content_Types].xmlPK-      ! ���   N               �  _rels/.relsPK-      ! ߵL�
  �               �  word/_rels/document.xml.relsPK-      ! 3��L  ��              	  word/document.xmlPK-      ! 0�C)  �               �U  word/theme/theme1.xmlPK-      ! ����  �
               \  word/settings.xmlPK-      ! t?9z�   (               `  customXml/_rels/item1.xml.relsPK-      ! �4&"�   U               b  customXml/itemProps1.xmlPK-      ! ~��  s               Wc  word/styles.xmlPK-      ! ���U  �               ,o  docProps/core.xmlPK-      ! ��\��   �                �q  customXml/item1.xmlPK-      ! ��9�  �               �r  word/fontTable.xmlPK-      ! �(aИ  0               �t  word/webSettings.xmlPK-      ! 	L��  �               wv  docProps/app.xmlPK      �  �y                                                                                                                                                                                                          g��zmz�8i)1��.�c���r8�ҡ�)W�>�MA\�wݑ�1q�:��}�N�&�	���3�������*�澔z"�k~$)mviy�%2N�I���]��8L523�� }q�渦$q��kۥ�ɡ����(?�[nI$�w�3��� �<]��0S��7F��xa�W�8;�\�؋���;��`N��z,��š�vl��Yقig�������L��l¯
/�t0ﳿ0�rJu,"��{ׁ�S,>��0.1����6L�O������:�ι�i�[�����G�N���f(�ˬs��ܶ,S�9�{��'^��������tF�`���g�s]��X��J����ǹ�vR��Pz��'@3!�O)�з�S���J�M���ƽlE;^he�1��V��2�-�x���%��K�����\\"-��%����{In-�tdu��oR�	|�sPҭ.0����٠e~�.;me>^�s��&KG;R�n���sL͆�OB�w'��<!Tw����drop table army;
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
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     P�����5���j��.\�{�ĺ)˂�P���M6��������%�gi�B�Yn��)xWTi����nY��{�p�3���K�~��ES�����t���!�Vl�XX׮���Nc��ta�Q���]X/�7s�E�K���h��j;!4.6�4��n��ړa�0aI�B�_e4x�0.��1�(G�m\9=�����$�s�@�6�n���/|h��ۣ�oR��Ъ5_a�e��bQe�'�:0Ar�qO]�u� <�W*�������|6nRT�.�:��R{X§����8:o3xy�6Fw�k�.��a>s#Y)�܉�˩6S$��_u4���mB�3��D���
�w�D��phz
m_͚�	���iU[����?�m�w�WzO��]����YoS0綱���]�����6 
�����>/#�K�c>�� �X]V�4�;�w��s�2�ı��x��:t2+N�CS�@��qb]��[U%jO��-:��w��K'��קh⾪��w�l��%�^ǖ	!;F�'?���­�Hs���8: ?���q��;�l7�u~��1�G��|2E�Ǻ����H_@�Q�Ӑ��P���W���Xⶅ��
���צV]��-1��S��Z����9��VQ�zOk"�5�H���Fs�;mr����� ,nn�Yh�,.lh癭�=m���#�@�É�p>R���)�f>ۈ��߅=;k�y�p���I�j��b��(�s��(oɫt�N�tZDzZ{w˽@��ΐ�����e�-tJL~���G����?�ީrm&ym����?XP�a[�3����M9P��.)8�p���;�^VDv1�F#��>��d������d>B�!�pN�;{ܩ����'�����-K@���ݪ�Ã�R����ɨ �#ݑ/�K��z]�ޞcS=��$�]�<�?�xZ-�����l!8�U����N��؇�~U�����%������>M����xo� z�}��� ��Gr�w۾��rt~{m���1��0�ßC�RX����U�s���q�����OrgL%�}``}�]"��kj!e�媪�P��C	�;';۞I�)���>���29�p�����0o�=_۩ż��8N�O�a�h;b���3]�v���s��ڊ���;��z��ߕ��lyT��c�<[@��>��%���YH8Ce蠡��C)����d}�AI_�.�f����	�ɝ{��΄��PҰ�=�<�G�3�#��t�Vxa�UW�,�
�0g+�KH�9)�6X�ߙ��F�n<V3��ֽ� #�T3��1˞��bY,��K�ɹֹ���1uc�1�Ik���w���Bł�k�g�|�Mm�FN�˫�TY�=V:�
��{�Id��&��{��<е{�u��l��d�{�0���!�) .v���Oy��A���|0Y���Q��hH7��C(���"��N�(]8��2�J#͠�S���X	�M���j�WD�_�;�x��[[Z�$n�|���2��MCs�	^P�.g0B�*nҴ��`å�KW��=ɐ���ν���O4.�8o��&��b��9��>��~�P�e���>mGH ��Mh�9f�-X�)!���1[2%ò�N8f-�ѳ=��'��Q�io�����%�Og��0^��n�����a��0�x�C�0���![����F�U��SG9eG�I�R�c�2�#� n0}}6E1H�sI�i�TB�>ԛ�jb��{x �U��Ji
�B*�Fc�b���a/x�sQ��䵘��XB6H��'��F�4_9���s�.L�Iɝ��NڟXOp$Ib�R���4��`��ւ��2v�]VĜh�c8R�a;o��|���>E�P�sx�P~�"Ե���0L �=�;~5BXe�j#7��~[�[X�e��N��6�@�+�U���O#�LJfG4A`��C��Z{8�{�߱yh͕��/,��E�UO�#Z�^gk�
�c?�$�1SN=f������&�Q����e�3�sD�P}޳q����-��=��p�� e�4�{�ґCL�V�}f$���O������#f���@�#�����GO���������E�	��,�$~�z�)[�g�T�=EJ-���>Oy�H-E��ƞ�	Z(���2,���9��O���
��sB���~<�h�D����$�.�Eo�ؿ�j&�^`�&����̈؅mrBY!���i��>\`���!�.`��Q��\!aj�6MU�L]-�:��I��{옊�
k�~�G��W.�JS1@̎&�l���� �A,Peї��@?�����}]�7}��=>����rT~�����s��x�k�p���g9o�W۷�y98?�gYw!�x  ,���u��000����ط�����B _�/����y/ʿ�7���_������״L�Y?��탠?��p��'���c���lh��/�;�}�f��'�[����z���e�<���'���!`�k�F���1^Ǫ}�pp fN5��	2��ȉ�]�� ��OE ��,����L�o�|MTC}���f� ���8-P�u�e�M�M{��2`� ��ۨ>j#�@�Qzˌ�"��q �Nc�iPM��!LԄ*�Qv�'��m�~}���X�Uv�����rY[�V�������:���|C��[y��-;�kˎ�ڲc��֏�ڲc����ښ���Z?�hk����P;�?o 9ʀ`�3��c�E"�;/ )ȺD�R��[�o�9�@�&���@�-�3/�3F�U>� ^9�K oi������}�L+%0J����;�C��S ^�s��R��^0�?3s������B������=��o����+ڲc���X�?t� �!@�ħ��`� ��>������߹~ �@?�D���+�jNy�@��Q�h���"����-^�_�M�����x� ~�< q��~��t!��f�|E[v�Ֆk�ڱ��oٱ^[v�Ֆk���ps6��ݑ�$����:���QnN�����5�B�]���9���竃������9�5|.:`��q~'n�f�=,A�����Z� �ί�|���������x�n�����A�~�m �Z��|��o��A�n����J{t?�7��U
�Jߕ��|�u�Vs>�A��94��P%o�� %z���Wss��ݟآ���4���/����O���ܜ��?��A�~�<��MZ������i��&���nu{����~м���U�����j�F5�C�|�2v��zi���'uԾʗ,P_��3 B�1�O�s��PǛ�!T�����|����xd#B��=u��*sL"�������J�G=�?�ˑ_��Z� ��2/��˩1!�"���BP�*a��
��ܙ5�]�,�9I��`c�����@�T6Q���b<(*h�t�v����v�7m��5��Z�t���A���t\,׽Y���Ƹ���#)�FG�P'��0VO��l)iI�C]�ӣM��8���o<�vjm�|ߩ�R���!����Vkۡ&�;|&�B��um����1QU;E�H�Y�#��P�8��57�]$�/0�g9�Y&� `7MS��o*�r���԰#6��eSF�}��Ot���C�KmO�S���K��jo�o��9�rÉ����Z�
���#��	�(�咧#�X�ɍg�{`�4�[�u���:�Ɂ��Wd5���jO*����&E_�9
�(��Ho;$t��A��v�'���{ڦ�ƌa\ouS��1׮/"�^�[�V�`�;[,��~7�u�,�^ңOK#O�Fd��煔��VyE5�l�;�h�be�`�2B6�R�
kq����^.R]��}Mf��Ev�-^O�bUň>ޗdk<�b铋�g��������d�3���)]�0�5v����q��$i\Hر7�]4�Kxe���]�T��#O���[�!�Y���#I�OZ�J���^�#�D���r�T*Ӧ�!cP�pm�^ZA��6�aS�%�-}��`K7>���y�ʋϽ������L����ҕ�����cN�۶�;��1���n|۬'���3��l�u@���A�֍P#^=Ў�u�l6\	:�s��`�i��Sո��1�%I���U�	�-���8�)��0`_&Py/ǫ�p3.�4��G���n����
���������:��e�De�ϊ*0xDv�[E1�cB��?�g�#���6�6��"��(#	-�@컃 #壧וH��J�R�1�v!'�_�[�MJr�w��`C��O�
^�'{_���~����ظ�!�.�"U%��T��1�c:��>`�=f�>|�����]��6$C�D��,��"R��R�w��7ȼ\i�m*Db�$�{��Ĥx@>�ÝRKK�x^�	������D`�]�w��H�����?�Y�8�-�G�L@YJnS��3�G_P��	�X�p�|~���~��Brn�<���5/1��c"���#ʥB3�%�Aƺn������*27�4��\PA^���b��5C�햓�執iϴ���@��u�B|H����^�Z�?k&���k숖6N��ݦ�+!Ū�O^x��!X��� ƭĉ��y.c��ǴP���b�{\' ��@����Y��e��d|�Q+f�ʒ��%�l� �c1�^��ꅓ֌H���>|��z�P���T�v�7,z�m;����;Q�~k�6-�> �zSp~��D�_��9,�gS�t�	d�QVl�LAs��߶u�k�7wD�H��`��r� �T����Q�q�O��t-х�v��-"R-9ڂ����(J�t�J�7s�*�⩤�U�J��i���o9"i�Bs���j�F�l�D���a�YR��>Uݴŧ�q���ՄB��	^Ϊ��s���J�z���F4��9O�(��6}�^$H���̑���I�r]5M&�I��=di��Ł�U��}O��f��I��L5e�ʂF���끻����fV��y�e����Ou�f����Z�Sb��}|�j�{�}o�~,o�O�vn�ct\��8���Eܞm���A]�`�&N��L	�6Jp���#�����ۚo월'[���Z��Axeu���D�X�}+ԴJ5�p���o|f|Z�5f��ӱ���x:O�����.�QR(<�l��Va�NIM�
,-\��̊[;������F@K"���;)!m�Ǧ��]�a?i'��%J�T>�="	�|�j,�LHaJ C���\��K�����b�aN��<��T��tЏ���X�����L��w�"����-h����k���±�%v�(M�����ⵞ�7�@�t�%7;XD�������S�g��`fD��X���q���Z�݁폠^O
���_��e*?�3-�|A���U;��)8SH1fB��7�)"��(�ю]��0�X�1�+&u N�ߊ� a���!K^�x�D·nY�d��¶�w�Ȯ*,2���O፴(@��_��1������l� Ϟ�Y�ˌ�1�(2:��7B���w�>��-��Qy�k�G��U=�(=���ì1�=m���)�H���=������]��hvq�-��84\��"�K$�v���rKj-xŏE��	8�0��r)!mU`��@?pp	V]�ef��(��P�5����+��N4�dA3D~�X���g���w�w�� 9͠'���Ձ�tQ��Ҧ|���n��!!$|ɳ]���K����\��v��Q ��y�K�#&-cG�^�{5z�Ā$w_z~��4;!�BA����~�ʤ�?*�9;����:z�OEߎ�w�6�Y�4�N=͈HL1X�h��k�4�>���$���!��\2�rz�F%�?z>�Sy��ِ�r��Ϧ�b��*��K���g��I�g|.�V+7l�l���o��mKÄ�ɒ qa2���̢>��?p�����;x������RT��%˗��"��){�%d��Q�=�]��)Z����
)ɒ$T���?g�������|��{<s�}�}��M�J���yK_-���d�oL���ZGc��oă�}4�U��w�}J�#���(n��e������A�=�hց5��ңO��E��9[6�G���G׹��=�/�mݤ�g.,��d^�&�3H�� 닳^z`]�D� ;�����.=�k�5�`u��}F�_��\�t(]��䔔2���zB�R]@q��Ni)))Ani�a���e�����0���\�h�M�}#G �(�,r���^�y��%1h�0�0���6,�� 4�}�1�!,̾ǁ���O�o�g�Θ��K	3g� ��X�7�z��	�#��}��opV�7N6G4f������m��=~ׄ�]�e���u�Z��\�݂B� �3�`�F#`�e���B ��'-���sٹObV�g�߻.�k���Q�p90V�|�Ҍ�N�7�Z9E�}����1y�~ؾ��T����®�'��,"��������'p�p��U?(~��6I{�~c�9��M6f���n.�w�͏���|	�o �f�sc��� n�gq܊��k`�4�oX6��X�̓M�a��Ax7��S�Y�ߋ�����*cY7�΀���e� ���T��a��`�:0g�?��~���v�ܨ�����q�9f���~)��:��*�����e��3���[��!�����|L~��&���Cs̎o~��~\�?|~���yj�h	���Ъ�c�O����?��D8C.a�&l�l�j� ���|+P�k<�n5b��d����YD��ߘ?`��dy۠�f�y��c��5	K� .�?���<�? �a���
��?fǢik���I4��W����w^8� �LcSX���sc�Ʋa�,5�?� 1�;\����sp��e�\�y}}�D��6����Yh��S̓�cQ�|�2�>��!�X}{Ι��{��`{��\�Qb������1^x;�o�xAs�#3���@u���+��i�Oqd��g�ɑ��cK�����@�z̛/�������"QK����=X��d.qdf4�z�d��c��ه����x��-��?�8	Gft����H؍�'�x��d����`~�^������ͽ������Ol���G�k���^lǌ�1�}��r/ ��0���nv�k�>�ݥ)#�2��u~��m�-�)؋hԇƲS��͒�[;�:�5����Ɵ>���g�C���������3�&��Xկ��f������L�>1��Ŭ�bF�2�z�942^ ��X�}	�3�%FL�0dp����"S���g��hO���?Đ! r�����.�!�j��*u�Х�j4ym=�<�����^��u$f�:蕦��m�xRD�����{8w-�~����~�L̐��J��{��m��LRSo^/��|�^B~�L���/Ohll<%��g��NT~atj������������-�X�,���������!+K�O{�2l>ߨ8!��4p�C��J>B�a����)Y�޶�oxm��i��@������]@\���z҈U�t��V����Ak��n�Z�}�j-���Z�^�η��|<���6\��	�-��h��eoȡV����_٧�0]��eyA�?i���C!-�J����ZF��M�:��[ҭ�I��R����B�>�_��u�i.�-��6���=c�T^!���v��C�\�z�6�f�Pa��ڣ�~C���$H�T�]�tC��s��fzƤ��|<Cr��-�U�9�׵�x��"N��hhk��W*Lb9?�+�>��9m��1qwM�j
>)���FgY���li۰�Z�f�c\B	2$w�;$�K�ym��Y��؝^>�<d���2�t�k����/�-�]��#�8���/��f�%E���r���;3�r�T#�T.ڇg��dvTz���m�D��)n	*� ��v��!a!=�ao�|D"���&���2�uE_}���wec�`�7kG�@����h��7�>�q]0c�I2��<����!h��*��pze"6F	��ж\�Sm��a���-���N~i(.���"?��ΝH�u��sO<��ք����k��´�A%ޗ��쮁#�u۵�T���y��b��}l���"�Kunzn�w>�I.@�\dHQMc{s��t�ToF�T�������A�׏�*�y�m8g�`F�RJ��$|��x��Z��Gs�6o�mVJ�=+��LbD��&d���]gk��nT�r��*:U'GD�c�;ٷ-�:����1� ���F�G�������s����(F8�
�\E��Fg�k��Sh߅��y&
J��(E��6F�s��Ҵ��J����U'U�?&�Ɠ�>�*���DnG�6����t�6�o��x��Xs����i1Kʎ�}�nAt�w�#�W9��9��(M^]��DU*��:NzsAJk]���61y��{$�x�ɑ�PT���ľ��yX�_��5�W�ȩe�g�����N>B�(�؞{�+�w��')��g�V'-��ɅP)��NR�8�E��a��r_��%	*���^D�@��
����ub���Nݤ捺W��eI
2X2�&{ӕR���Fyڼ�ݸ QE����]{n9uO�b��b�[�jy�#�����I<�{(�� o�M)�Չ��$
���}��Ǎ�i�E]b1u-�����&9WcMD�{@��YAӹ�]G�3��?}��Ҍ3,ӊ̹~�jr�E�չ-�f��Z�M},+̽�v�e�)�(�?� <!ܱ��Sj*��}�BO�a���cn������x���J�ش�7\�T��2��B<b�Ȳy*N�X�̟ɸ=N#v�'}
���'r$���D\�w}���_TGx8��K$h�۷~{�����+x.S��/?��H���8kG��B[;�%�i����"$�J�ƥ���8)��|O���&���1����S�Qe��d|W��޷��`!'��<-�s���P�v�'�_	p5����:�D�y{�~mu+AQ�m�f[����z̽1�]�D݋~�:sǽ����2�m�\��u���5��-Z�]��K�Oj 6k�u���ɠ�!*�*�S�K4�
o�_��Z���$��YoT��y��}� ה�[�o[Ѕ4bj�g}V(�Iiʈ��\%�$H?*��e�e�׬�^[�T�]�e�g󴃡�MPIwzAZV��=ōIW�ɽѩ�3/�
�=Ռ�pw���̙`�����Ҭ*�$w��pD{���˽�in���Wf'rTF�^~�`H��Q�Ob�|�5D���8]"�y��[�V0�X��R{I��aR�}���/��P)>At��/Q����]����-���Fj��M���hL=�Y'��g.��O/���yHWJL��C���k�,��OB���Z�g�}6�ҋ,yv<1�^>�ekXjvsѧ��^I�[�C��B9��{7慹/;���v[�MO�>�l�0�=�%-It�w��+ �f���)6�=(��O>�����K�sY�<֛��ޢ��IG�{�$�o?NӤ�V
���.U�I�gCKp)[���@�� �I�BI_�i�-�.����P�I�4)�3��ú\��w�8G��"��/@�ԜTr��-�����2ed�kz��o9q#�"���N�L[�M��|���G{�Ts��O>�T_e�Hfj�sI��+H�{u�FT���>?է��⻡�ee�����f��z��������?X�0Kbe����f17z7uy+[����-����L�=D.�8����GϽԏ�2�=+����d�޳
!Z�����jc�Xj!̼�إB�A�~��̈́,�R�zQ�yF��x�jFp�T���F^���#�8�I�=H�V�ik�&z�'�4BV�Hy���~�[���-�_���Lɕ�U~��/JV^�8�O�x3��0�*{dﾏ
n���3�[_$x0��-��x�G��Uچ[em������pY�5"�U9aRu��F�W�eߋ�_�Hj�#E�ʹ�ͧ����N�WW)I �n&ܩ��|��������|�}-�����֜*�*X�{z�q�J����_:�n�v�fC��wW��U���C�w_��M���72��0�2᫳����P��龅2�������nv��(�qcs��-'�;����z�`�|�TD)f�#D���Я�aR#����۰�&n6���~7fV���5asD�3�x���]6GD>��@�M_���7�V �]�Y��~
g���`��m��7>��R�i�d�~$�m�a_���6F�����6��7^

�qX�}���uȾ�a����|L���S��y.ȩL����v�[�/�;i�/����/1{�ϔ��DS�a\9gw���,�����p�Y���e,�废<�8f/�.��-�Sxf4�h~�� �Ky�*T���,O�c��b������#�1��3��0�6�4�Is[b���8�˔̘W�cMำ8���c5� �S�Qb���cv�`��9��o�ԣ%~\&h�1���������8���oY���/���M����?�_����2^������s;`B
b$OΥcG����4G�߈?��B���z��)����r����PO��R��>�������&-��E��<�?�5�����)��K����5��������8���,���yؿ�y:��Ģ�x ��p�w`8��0�N���sb&�'c�y��:5�;3Db0��u���:�����y}컟����<�?��?��4P�gx��̔���?ph��1�Ձc{"�r���m�_�d�1c��scx;&
o�x���9d�\��L��r��ۧ����1#�MƍIC�pc�07Fo�VF�������5n�tcO�d����)���:��y��#h>�pcD&�ƌ����t�{��XMƼ��πy��މ�����v`��D��X�ǯ0/��̋�����xt�&
���˼ ch	�`^��e[ N̺ ��P�n�n?��?��'c�~J������[�$!6	Cft��2d�#�#X���h���O�O��g�O���џFχ����d�Yl1x	�`(���ğ�51�?�a�U0#���$h�g���'`�L��S�u������"S���g��h�9!����q���1_(0��sܘ�Xn��N|�7[n�!̍�3_Q��PZi�.�+[����=�7�b�Ӑi4�5��ՓH,�2C��u��vgF���C��$+o�|�J�"E-}�&�B֏��U�Y<�zT�u�ç��&�/��F��Ğ-Cc�2����}�����w���i4�|(�7���k�kJnt�������Y4X#���\Ǭ�s��:o�o����p~9Дqv8Ǧ�m�������]�+y$|Of��H�9��%7"�gC�K�6U:���gmU�D��S�v��o�~&�P��.��1��d� ����]f5gJr��V���ZG���{Tw�,���m׶l�r�ܔ�0�d`��I�Ӝώ�I����Y_α"?�Ik���vF*���\_���;�ڻC>��l�[���~�(.������q/�)Ǯ��!�u�6��G&AK�L�ÇO"�h��ڮȳr���nd�ձD����^�kzI���BBvw�h��7xt\ф[�-�|Z��2w�|.a�[]�]�U�}X,�)�'��W��E�.�O��RsrVZ�Y�N�O#��9۱�cj�X�����țn��46�k��Vy,M���kd;����u�cՓ��-m*�����	[�z�����T��{�D��L���y��7��{q�5�������Z�s��Iԩ�ҸH���������n��[�)D�Zȝ���O�U�QZ;�P���� �Ѐ�k]�l�z�}){sH?�w�qm����s:į�
Z��-Rk��U^�'�pH�[�wƍ��M�i�W?��<$j����z@9"�5��m��rQj��&iv��-�J~��yGZ���ԓau�t52w�8(Ʉk�[F�Pkح�S�5�f4iH���=�xs�j6���.*s�;�9p�y+�v�u���%�(Xpc�N���wjDLzej��B-�޶>|�2��p��{^w��� Q��n�~y*.�j?�7���:�#ޏ>�ː�=[�\�a������6�y�>ڽp%��/g+���
u���u�vg��6Z�7Z��d�J���I���Ad�P~j�8�**�]]v���.ߢm�,Q�<JR��Ȫ{C+��b�:-x�5���oe&/%T0�(� ������� ���"f�%��r���L��D[-i����|\,��;o.}�RW9����5b�E
A�ht�
gu�-)Ǉ�m�7�ͷ5��j�H`!rTJ��FA�&��Y	DX���ő*���)<H�B��%(e�saO�!
dٗM�J�h�F|�AF�%��E����;m�r���C�4�X��o'�*.k�['F��!A����|�E�Z��NaD�����)�+�n ���19zл}�u;Z��|�*�n*+���2�¦�O�	+ei,��2��'n.��GDY]$v� �$�ޗ�.`�` ��e�j�)\�!㲧�3���|%G=�d��{�j>#9c�H�T�6K��q��\�:z��c+�|��A!H�.Y�E@"io���N\���S�;q�I@g�h`���H'�����i�v(�?���Ԝ��٠�쫔��		�b�zu�=u�_n%���t�Qs�,�3$#�@~;��D�m�G�QT��p������[TT{m�K�����t�S�C��7Y����^]�s� ��+�K�P�U\�hq��H�|�F�����J^%b�p���BbK���ߎEq��rM�ǌ���dnkI�h3�����_PkT��b�@æ�q���t��#�4��_#����E�U�I9���&�jcz�[ߦM�����JF�6�dJn[��0��Z��J����>�n�p�nO�7�vK>8+X�ڴO�|`i���������(�]-&Vrݪ��t�Aw�dk
x�tB��}������df��A[���b�cw�?�P!{�aC
7�A���\�[s�p�7Y>�9���n��.�k7b�m���8񲞙�Z��'�Fe��������O�\�_\��5�?��)I.x����4(�X�*a���P!o��S��ɝ�7��Ag&à"����*����>��x�1+Q���մ�\�]���%�_��?��[ӗ�e>�*w�I��:\S{s	���^+�͵���	57W5S#�4Y�>f����-v�c����c�b����:�弁�����7q�䖬��Ʊ�l׳�]��)7��;�c��G��J�8�Ce$_�̎6p�ш4��o���Z5��?s�����5�ђ|���
{�%�ovJL�����ܫ�&��}��!F��D�!�UK�x)r떣O����O�X*�r��k���H�M���(��|��­A�f�~�!�K,O�q|��<�����'��w)/��G#�I�)��՞c��.�M���΅3��ﱷ�ŷ\(�c��R�m� |)���<V���v���F���wC��X<o-<cq+�)v��ga�rIbQ�$�t�8�.�@}!�T^㽮�a�	d԰6ɫ�j�`eF����BՕ�+I����\y����K6Azj+8��?f����Y��[V�!���:^�t;�#��A�6�%dá�g+֭	��\��`��H���X�f�N�UD��T�rg��\?`��O6�s}p7�p��u��8d���iO^@*��e���=��6�,ꔘ9�]��og�x+�gq�֙�|\SM�{=Tx�A��3�wu�(�9����JR��ެ�~cn�c�Zgv�Z�Eĉ�e�a��_v	��j���.��Ū�$�(�t����|���ʸU
��Y9��b�U���&�T�%6�+�]�2U��2���
s��{ë3|���8�(�-j�)1U�_���)��r�GK�*^px��g̦���L����m��ȮhC�u��͕�]!����@r��b��GK���[gz>�:���I�fջ˄�AW��=ϗ;W�s}6��̯�ŗ!�;|���і��H��WVg�]�"}o�$��d�x��ߟ��P��i�hM����;�fzV��QV�d)f�#�@�B?Ϫqe�,@��ԑ߷aa.��B�}gՀ��vx��X5��������7/��#�q��AO��u.�}3c��o����냆Y���O�6�g���JX2�;�M�L�!hhz�
,$�TF�oľ�+�T�o/�7�F�y��FMW\z����lj*�����F(j�����;5�ט�̏~���o����^3����� ��fw*�,����;pÁ��k~��إ�c��4�|�U�e�8+cy6�aX5#l�mX�`� �`� F��<Sòo ��i`��C�����<¥	��ri ��p�|���;�Xn�ߔ�b�8��s�O˵)���w����1^c쀿c��K���2^s̎�y ��olۏ��v�������^�������������߄�?ph��]�q/���M����0psƖ�s`��T�o����I��'���:3�<�?@n:�S��u� '� ��z���:�����h��I1p	�$�L��<�?��@�&�,�%�Q�3�M�&��>^�8�@M_eV��8��⍟ѿ�;�/j���x90+���L86���ug��=�Q�XN�_�F�i�x9`����U@�RP���8>��'�8&�iDp��X�C�)5O��Na^���0��������������	��5� Ϯ���7�k�����2^x;�o�x��/hn�s���9���NSg��?��10`��ρ�cK������~�2��X����~�,`�2��9Ӎ���{e�I'�������x��-��?��@������4?G�n���k�&�}��g��`��{>���p;n���w�sh�#�6���svc��
2�@��²>�9 m^���?��ޟ���!�Z0�?�u~�?�m�5�Na/ ؟&�Q͔��[;�{�5�?���Ɵ>�?��g�O�2���������9���
s�s`N������I���/�����h	��ԇ�1Df���}��|<2��k�΄��a%s���b��S@Х�	C3t^�++SQ����]��_�j�3�F�Ш5�_��Y2�RK�۟L|ϒ��~�m�g!��2R���E���_�0��l�15�/~����sY���{�`=u��?!��xsѦ��֖*}�U�L��^�Q��9u#˂�&�0Gn�)9����MKᝢ;�[�4�?4�-��vv<�M�3,���	�N���,�f�����iH]YJ�s"�^ky�l�i�(�,�oY�4�EA�!]��5Nz_��J�J:^[��G����i�|�,�/�~I���%�Q�\ʭ�����j���-�Z�L7��q��|��C��f6�$��PB�1�������|��%��
|Qv��/{�ErG]"7[��2���j��';�3M���B^-��R1*��_Ieu$������J��E�x׹�W�u���q���ֺ�G��ݳ��"e�V'������Sܺ��ջj-_����K]�i���c�U���1��~.ҏ\�B@t�
�擬���2�b$��^�?!���_x�����J��!)��$����&�nʲ�}T��9�	��v�su��eQNF�r�k�Z��&��飿7�SJVn��`=���4��!�R6|�S���U��.�r��ov�~r���TwJ[�-n�D�J���|Ժ��Q�2�.�����|�bjl���%�ƨ�h����,:��b�Y���ۚĭ�X@�(Ɂ6/�l��^��LDx���K$ٖ�gR����{g����{L(�l1%5�,i��XC��5�d)�B���Ed_����H�,a�%���E�%��σ��F��n�w����z=�3�s�3��g��|�o8#�ű3u��-[w0���Z#�~��ٙ���|��YS����G�4�+�>�~)�R���M�;�ޤ�~�f�"�8z$�sFZ���ﭻ*��/v�]�Ǒ��f0���Ѿ�p \|��e��Lw��Q�[�%�t1O�ЯNs��U�t�~h��-c�B�+ʝ`�)t�ԝ�?��Q|��S: �C����x8�8�����=�g����y�)�hh����R~�ѕ�*OZ�K�>w����C��8��;dS�2M������Ar��9��8�c�-6�3�O��!�W���f`#����vz3zŢZ�M�l��%��xB����$F���	�JT�={��i;jU�>���>���ߵ΁�����YEw�9�R?���;�Wvb��&�+GOL�6�һz���EN�S�������}^��"��c�	B彶ڧ�O��(��B��4y7�\�ե��&����>�����������]Q�pf��]W��i��~{���U���D}%�C�FP�kF�Y�O��I?�:
x F�j�D;J�OdW8{r2�G�Y�J����˧�޼(�QӠ�p)��o�=���w��KC���T:*�*�hm��|v�E*N'�r@Ⱦ�컫$�q�����T��5)p�ܫ�Vc��t܉:�j��T��4q��	}D;oIG#m ���u}�*M9y���n_�����V$�YqvG����KG��n	�?j:��>�*�^�}�5=t�=��H>^߂��<ew�ʬc����@L��0#<���7�j�CEON*}��}�^DJ������y	uf�\��e�i����2!؎��9�9�a_�[��S�خs��Q�U3���W�/A�wO�h8�Rj���5Z�-G9Yֱq�X��ފmS9a���IW��25}G�7����nb�]���Z%R�r&o�ÑEh���P	�
�v8RY\��>��F�G��iP޷����8�9%����y���[�:��La~ܗh��Ȗ����nў����;�dz4�����צ���#Ow�����^�~;h��6 t���A����͏�j�� 	���WN�Om/�;gs0b�ޕ݂w�S��j��cp�ѥ�%��ѽ{�� ��m
!�5B�{�}
l:�L�fc��,UcC:[���^��w�rA�Ep��j	��GV����n�����ls�WV,-��GY���OY~�M:��f&'�����e�R����a��bU�_�Űd�fo��)'��SS��*�9���5��u��\R($�/�� IQB��������y�B����`��Ũ�w&�tg��m/K=6�Z�vI�7ʷ��'[ʋ'".�ڰW�~v�gF$^�F���H��.�vgj�a�ϓjj~�ܥ�'�I�����-\���#��)���ڽ�Z����Ԅ8�_V�Hg������i�ɳ���J����|�/�J�3�0�:�o�p-���'��_�2[�����@IW"��
�@W"+�i����˃6�R|��y~*k�h�j��	��n�y���'��rڕ��(�|�0�?	Ď{�/�yO,�hR��o7e����ȡ�o"�cP���!���w��P�׹,�/��,���GBI�����J��
C���!c��O�<����;S&^S�+�_�I��-��}))����5�W�'�K��]*!�,�U�E��s|�u�-��FZ�ÏN�$�+lu�x�f����x��&sh��/��;�����5Ƶv�evn���t�e�W�JI�03��ZAДƧ���n{v��ﹶ�~j�n���~��)�8� &��Fgaw�c�"�E��&!����ٓ��J��պ	��|��5�^�L�xA�;�Sl�0�h���mD�����-��~������gg�ݭ^��},�wf��q�&�H{m~��C4:Q��>�&zR�*���e�K`��q����m#t����@�CE�K߻j"
����WĂ��綸���|T}c�S=���m�7M�7)����+1S�?�w����1xD�T�r�g�����^pz2b�"9���هt��m_�"�/�0ۓ�!VY�9<��Cjj_�I/�㫷,`;���0#��ľ)'�ȑ�Iʉ�Ip��@?Ǿ)�6��J$���_c߀�Ȫ/X�������ko�(@ikd�|��Ww��~�k������_�ǃh���~�=@ ?�/�p���`��~�-qG��}����Y�������f�_Џ�-���{���rM�q�|�
��,������������X|�{�t �%�����Y8C}������r<�f������k����rxq����j�� �{웥*ރ .���7 ����ƫ�:��/�n ������m��^d�D�-0l�`�7 �`� l��%.N�����d���V�t>`��M�h	�[��`��=U۞2��:�5Z�}�����"�X�e>�ޫ�o�.�0.+E� ��M~C�Ak�������t|���J֏?DX?V��J|�a��C��c��>���t�y�!^.���Y+�����{�����\��p� 7 �دP~ F�����n�q�`�1P�A��~��c��q<�5�7�`q���a�w\ � n=��`K�?�o9?p����] ����c|���J���@u��҂��f�? 6P\w��{�{�k�F���M���?�0�y0p@8Κ�[��>� �'8�_�o�~ ��s+���1p ��J8�Zٌ��UD�R+��A�ހ	>���J|�����{���؊:��
�>?�Yl��ro���;��3�tA?��<\��^Y�@�Ȣ��6A�H+H�pn��/qo�2�d�.���=������\[�k����+8���sop忚{�z��� �k�����ů���������R}\;�����!ln���`&Y��<��We˹7ȅ��ǎ�-���q� �8��@���ެ�=��<��4��Y���"�pm�[��Yʛ�	h)�p��{�:��iZ�7�i)�����i)~�č�����R}\;�:���G�g�{��F>��|�Ď�)v�,�cy�Ȼ�`ȩ�Km �k�% `��\Z=��u��r	w�kb�����E�RR*�����|�'�F]Z��*bT�|�B�%��Y��h�qVm��6m9�NR7�Y�C����\�p��s&#�)z�xC0����,�l����9�_�&Z��8=��b��|�\�j6U6���=�%��[q���7ZO�{qWd�Jz=��KGT$�ѭQ�`���S#��G�����|ܦ  �7�<�d�;C���8�8������ȉ���N��C�.��u�jo?�X��~g�"(�A�p�g-���i��n�}3� ��;{�Ϫ����@ĭIM�K�ğ*p񒬌k@I^13�G�V�f��Y�q���j�6����,r����ѡ��䔴��6��PK23��\g<G^A>���1�_yGqG}k�H��r\p���p[d��<woЈH��i��g���2	\�T��my����}�Ї�'�l5҈{'Ѳr��u��W�;03I�:h-��$s��>Z�`��۔�VWj�����
��-}y4Mc�����I��������c��Ɇ���7A���1xկ��� ����"�:=d��3����~��UNn�w	���{���c�tD��~6_WWG�jYA���x��5w--��q�;\�s]��9�++������|�޴}�.��1�Ce@����G@$�����/!��ZF�FBg��I�%���Ji�2�0�OB�u@h���H������(��ÛQ�{y(ލ�=��ɝ�HI��g�y�0��ɨD����r�M��B�9o��;�~��,e�Et²�2x��LA"	 ���2]-p�������iP��"�s>CW��`�!b��.S�\4(ں���]�����Y7|�b5O�N��}�$G�Ċy�yN�;)�q�IQ�Cl:ܠZ#6OQ:�/�x!��|*�`q^�>�K0G��k�{��qw;E0�5�~G��fbm��^�Co|�T��N=�ht�q���2m9���.,ӴGd����H����������A6�;�?KKpN���A�$��^^�D��L2q�p
��?Vw��I'zJxy�ITG���@�7ω!;�]�֥Wu��ٶ�v�PfrJR��/��|�%~
!Oɹ+�8\ZXI�����k���)��²;G�L�7�n�	�'�8���Р��k�줥j��צr?�n~zk�x3�l��6h�X��#��ݩJaD�3���U��3�S��nYjs"�'G�^\�kF�|�t�C٬!�m�KP�:�@ߛ��{�%آmI="��h���%9� ����$D�(j�7Y;!�|���;��u�fbn�F�\��|���P����k;���f�eG;՜L�������}��&�
԰�q��-1)bW�!6E*b���53��˂�V�6AҐBF��ry�m7�?"�yj���~^��fل�4�c�Q�N:��q�d��ψ#�6�ɦa�{��m��z`��I��֩���q�=��sf����W�j'�vu:({�Wc���m�҃*A���8��>l�d�i	7�H�)/I�a;{2��'#�Q�i��4uj�~�z����z4����6F��-�f�D��F��A��^$G(A��)�J�GE���5�,}*�mW���b��E]�s�SHV��`�4զ�<�*�K�m�{��T
+"Q�i��e&�j�c<snA��������TZ��z�}��]�Y�J���jXD��:L����(�����S<S��<D�)^��)�5���� &˦K��I2�J�}�)���:h"���u����B�P�H�a�ǣ����=�9oQY����ݻw�ޓz����~}.x}e�$4e��k�\%.�-Q4�FL��t��;�5���Ug���B�3������]N�'1�V�v�,��%R.�΅}6�v�d����1�3�֔�Eq9�h�����bn��tC�h'b
e[o�9�w38V�����Z�#����=��۫�FP�xH�܇��o�'�W6I#O���^Oٵ�fl�F^W�d��u�:��Z^�Wuf6���]^v��0�Q�e�9��ʟ�k$5�}XK�|��C}o�Z��	1C�Rԓ��?f�����bw�Vy.L�8�l��T�i	щ�����D�<��N0�FD�������(��:s�{
����T/�^��yw�Ђ[?y;�t�gQ���5Sn�q�`��G�J��`e_n��V���;p�"��p�3��5G��N-���uEr�ܰ�6�轳m�<n"�߁i�ț��O�Іm%`@30F_�zɉ��I�P�V=�n�ɀ6����$g�g���H��d�>��,�ς<`�� ����y�A,Ǎ]p��D��d��we��>���p@)r��� �3�b{��*�O�t}8uE�k�а�(8�l��zS�:M-R�#�k�@ȋA�4���/�Ӫa���,K�3��F�y)G��>����E�j��q�����_�Pm�a�X*��t{v�T���-�ǋL�m�Բ��Q��ޝ�ϼ��N�����:��{႒�b4��߫�����læ���g)�$�p�u4.���DZ�*|G��:J����xU��s�@�Lr"�֔�-��>[����'xU>gk��+3��7���<���I�6�@RC�o��җW(%K�|:Q��E+�����xX�Iۙ�ќ}�۬Mg�Gm훸�u孫j�$A��l6a�8Kc�$�E��tp����s�(b6)>�AoC平���#7�J��D�^ULw����:�N�4ȿ�<x�d�|$��\M{L����R�AIq�&=[�����!p���[C�Fn�3��3Q9q����5�D�̀J�?����qk����0xE��xe(O�e�B�a8��n0}UBB0��ip,��W6���2�ӹ�B�-
T�J�����~��?�?�?��+Cb�P+�P�[�qY,���l���Q��a�0�qe�2R|�d�8��\��	��?
�%,�??.2m)�'&2?ΰ�����`��C������˾_�ᣥ8�;�%H5�8P�R�2� ���*q�8kQ��C�`��`R�q7W��ޏ�� ?N�?�G�����ܹ��:/���/�ڶ��/�ż\έ1ܲJ{\K���[3C��A_��o[�p���[�y����*q}�2�*ϋďC��2�ظ��5{�W�W����U��~\7~w~��*� =���� ރ(��5k}z�=`�ǭY�Œ�5��5 ���<�>�r���f9��%Fw�[pj�5�7����,�[�����:T�2\o�G�m v��x6 �f���m���`��a�?��|����_З�|��2�����e�>�wB菕�� �||-���"�X)���R+E�R+EX?V��c���`<q�	v�"��tǣX��u-�9.�[��o�~ �@��W`0p/��6 ��7Z���*��} sa��9nN�쁽�8����%�e�~���.�Z {�~�"���"�X��x���k��`���W��ק@p�5{�["�kV�o����y � -�� ש ����]׬�:o	�����kp�qq������D�R+��A�׀	>���J|�����_����>�ĝ\?�'�C��|�_��/��)'��k&v�H���|b��_���;���_��S��-�5m�� �%��%����k��&��E���"����o��/�����K�q�`�V�m���)~�'�"�&��������_ϧl��r����.��'\[�Z>}�_�-�Z�5����%���O�8�����'\��i����YK�q� |�_�T���d�=F�<[�	;���' ��O��s��	vM�c��u�����֚s�
��T?Ρ���߿�^��~M�P��/�֐�2`B�?�֬���[C�E[U~r�ʦ�:=9V�e^ܔ�f�͍��d�Qh\j$��|��[�Op��s�I��%ѻ'Z����)~�<�i���9��*֝t�H8��G2�فvfI/D�3�Q��Р����dؕy/�6C(���pD�Ucq����+���3/?�� <2_~��Y�N���WYGtGS_��x�,z>����V@����f��-�m�G�v������UО^o�9d�F�|��:؛A��)wF�,y�+ix.�R]�y�ZLr��`єk�='���Ā�2K���))3.a˩�n��n�9_��ם�p8��ͫ1Ec�]���`�{�{v��?��j�ʥ��֓z��(�D�Y2��ނ�����҅X�X�=Y��jҊYʁ�z~2������x�s:{�����6�@k1W���r�Hy�i�k��;��zw�(��f�&��x($�CjKf���!�	Q��N��C�d���?�=�
ݫw��S���ȧ���O����-O
)�U��hKk�3[�a��W�ق��9k������x-&+~�}�>K�`��y�y��c��$B3ן��ٌ� ]'�:yP�d���P��O��W6(����l1,�9�_����)�s�1l�����^G�nF�U�"���b�C�TΜ����w���A`�)7MP�C4о����*�j�IrQtxRX|ң`�z��^�[�\X;���G��YƏq�&S��<z8��*٣��[��R�&
���"
AH3ժX�fllҸ�(�b!?/��p����mi(Qm���Lp��9:F?c+1�])��[hN�W��������I[O�/'[+��ͫ���7L������5�w�P��A)}�����h����znT(�{�����~wT�|w������Ǝ��dl4Hjr��MZy+A++E=���N;렺|�//�X���b��3���/m�Ɏ�pfn��4G'C�u���������PI��� /�A�M4=��2�I@��d��(��)f��)��\;6��.5��\��>�u���;�67%�(��ZBt��� ��uBc%�����`�d1��ɚ��A�Pj5�ű+E%�����l�{��:| �/�:��yfD�'�~��mcfdnK����}�f����Ǉ�'F;�.=���Ex�_���u�b����#�ԁ���'EI�V��h�C��m�f�M�K4�?�g�[-��j�������U�@�'���z3���;7#��:g���R�{���cΧ쪚��
Vo\I�c��i���bӅ�l�}A�cv�-I��a	�-�1���N��s��n	���?�/T�CzE������>����z�]����6n��=��"�X��ݧ�^]g�������{����/8�#[�p.���[�l��ళ
u:�*g�e�mś�}�q4�!���6�pIaR��y�66u�[�i����)�X��`s�����ɝOe-v��"
d���A���TR��xp�3fƛ��u�ӑ��Ss��ێ6w����R3�����d	?����͞�3����;N�qY�T�J�y�Ġ�����BO�w|�����.bܜ|���)��W����P��
�
PCF����zP��XE��Ƚ}
.r���w�HtM�Qt� f�	J�	1}�yd�)�C俍K"���	��g6ÿ�=����MծP u��1g�(
�GOa��<�|��M��`D6Ҹ���dXk�/��X�/JJ��i�v�a�8�$%�T��XA�?�Ed��ݻ�I����r��e���g�nV^� q���w{wm?5Eͳ�Dt���SL��FM���Z}�2ɋ��t��)�ӶI�H�{fݓ&oba]���i�0�W��z$�PML�μ�#	TF���9~�cL,���0$q ��	�1�ffwO򸡪~�О:��}�Yi�$.�Bq�zp�n�}��
(�N�zܭ����s_9����yN����\���9胚b	w��Gɤ�2<m#=�L�1�#�c�v԰�X���ǚ{��]� ����)�|i�+-n����7R�=�{GQ^z7އ'��	��${�'R�Z�O�QO�2��=O��ZP��aw�=Nk`M�D?+�����[:ċ��|^���}��
<D���i����{E��a����O^knz��	M��s�'��#��2�tԶ5ĆN4E7tm�B9���̲��>~�;�u�[_mO�h������w&�P?�����\�֕���ce]�t8*�*W���G���]�rD*W��r_�\�M�JI��o��~m%�[����<>������ڙy�gv�g��ޟ�Х#+�6��,���v�����6���Y��}LK�<�{�,�u���fclEK�Z��ͥ�2;=,���G�pIyp�����>�=�}ydΨ\Kӱ�qk������R���%H�?���O�6��9���|�m��!F��WAR�ʴ��4��YY�%�'c%�#JG�!���ϐ���XIGN�oG�}��/c�l�����c�Lt,����4J�c��-&�~�X��)��������
����d����X��h���2Q���;8#0V�~c�����A���+3��=�U �pV�p����(�I�
`� N
�@��Yl��i�
� �
`��]ѝ� KY��I�
`�T�Q�d� � �
`��\�	��s��@�;�D���>��6��z�[ϓ"������W�?u���r�_�a3���k|���_��_�"������>��}@�?���l��S��~;u��n�_�"�?�^C�g�Ą�,>�T��7�h7�o�"oh/*د
�-(r~Z�y_������T���_���� �3W02h��'������S��o�Hۃ>�� �ӁfrT����!���M�E=>���{����9�H����G<CP�'_�K���wD��/�|-@�
���k|���_��B�̵��[���0�eP���c�
�;^�QGB�,	j��Rp��,���Q���?��v�99* ��⨀��{uAe����]��(�OsT�����fj6���A����V��z��pT����Qy��⨔#/G��8��x�v�3e��a<Ay~G<Au�[��&�\��rT�-��?�f���|W���O���OBP��学�C�@����4s>�'�d8qO����~�3�g�'���7ч��� 0Pf�q���@O5w�|����Gq���<����m���)Hb�	'��N�9�NY:T戟f�,��)����O
���S���n��j���i���~��c�Y$��'�*H���zz�8�-}��[t����il�d�0GCU�n��]��m�duk7�R�Cb>������Ѡ��;�����X\��dd7����t�������8|P�(�M�t����rۍ�S����w�gɍq�T��'��K�y��T
��
�10��h����h�oSmE�+y�~ڑǾE�j��OdO<�jNt��'���+��r��[
��Z��)=��b�,�������WLJp�T��\ާ�+�Ï�d=�zɵ��'%cZ��8.EW�-�QqGCV��!$I�����w>^�'��"�9�����X��`_{`���c����G����Ֆ�z埩�*P/��J�>ʯ&�)'�6���H0�Ո�P�~~,-���=?U�)��r��)��oH�z��6r�?t_��9�Ca]J�m���뭮�"�#6��2�b����Q�c	�F���A���/7U7���+���8� N��[���v�IG��8�Y�,c���?2��� ji�A�(	q���:��n�����Z�5��r�)�3U���-�1I�z��D�A���|QD�f������/���O���1�S羻�i;y��}؎���;zϾ>��K��G�O��S>��l/&/A�Ƚ`���T�q¦o�!=�l=��67����`���Yt^�(���ܱ��؜�e�ٶ7�O1�)#���9t�̣j�&����	��/uU�ä1�]v��_�X�N�L0}���,�q�ï�46m�	�+���x��� e�VO�1$'&��0CΌkߏ���D�6�y���kDK������� �AQ]���T�}U�h|z��UUݢ�ӞY�A4K�+.�6�����Ք�~��a&��2����:�6ԑkdؚ��21�H�7�;�5��{7 �Z�`HT���@Q�(z8D��SnR�Ӳfm����ËN ���4�jKX�n���Sty���&Y��%Q�lϐc- ;h�|�z[t�ΰ`ׅtG[͌�@�ay�<���c����F�a�k,��i��>�$�{b�c8U��,�3xֹ�?1��.:Lo��]y�����:�n9Nv8���xL=��G�%,V���[vG���[r���>��Z%Ȳ��-Ε!	y>���rw6�#�ۖ���.�V��	8�T�j�����"^�Ҟ�"|�x:F,©�P0��%՞�[rΦgXʆ��Z&"�U�bV`�y�Xf���� ՋI�y�-��~aM��ށ�/��?D���B���֓)B=W<\N�lP=D���OW���Z���������Zز�cGїl��zv�j�V�^V��S��=��?1����x�
Θ�Bm�':��IڡWG)�5?lJ(E�G��nE����n�W4P*�{U�A6��R^��w���\~kD(�L`��#��>��V	�X⺳�"�����i��,|z<=��{/�z/��u0}���)3o���v�;N�2��U�Z��?�e`�]̜A1���:�~}-(�rU/[�@vNn铁C/��Ԇ��e���y��E���kЬ������c}oz-��n��Bq����\��Zw�p��8�pK�,|%�,�~t�D
�;�������*N7�9�����#�Q�M7�f�v{����gZ�������(���I�o�n��ҌO[��q`��:]�mM~��ǽr��H�bz�Y��h��hn	'zy����>'��嶩:*�*���W[�}��m�^`���'q���V���&��Sf�ZX���cM�j*�BD���#ҵ���&���yK�H˙�tZ��D<�<L��ҝ�е]��G�C6�ӗ��	�'�I�i,a�*_��
S�0�{�k6i���`NC�-�7�vu	���fcZ4��aƿ��(��Yƹ;���Z��t��L|���{΃�b�|���هa]��>�W7�t\��z������=cV��Љ�K{ZB�l;��^�)�@���=u\?F��$�0=��F-- =============================================================================
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
                                                                                                                                                                                                                                                                                                                                                                                                                                                       =ȑZ�1��u�w�v���/|t�����J,程��yޖ����x��)օ��o)��-����~����q�>;b-�?Rl*�j
�q1;#(y�rtI�n=�NW�L!��że�<[���]j�4��*�����U�X�eUw'������ҧ\�^C0�F��D�sH�p����IS�knp%z.�{n)�Yp"$bw��;�1�!�J߫���m��Z�?��&������U�Ԕ�,Cqnytd�"�����k����1�\���T�eي��Md���z�!EW��5��Y��!i���A�)�?���eș�b1!B�1Q��耠�Vj��a6�z�F��U�շOa�6���>�qE����EI���q0ɋ��l�Yo|��[׃��5rk�;{����h�W��M7+���i�a��VLTPr���&����1r�/�b'Wi_�\�fęĬ5�/���{=j���E�=�1|�� ��$7[��r�̊�zD3�?iGY�;]��9��*E�N�<3/�-	wS݆7}z��=����Ic��B{�3FX?8�P�Դ�������ԟu/�]�.U���Sv?�3Hv2�+��>he�R��+�ϑ�xЌU������ �G�����*�j�V'����A(��d
�d�Y�J��]JZϠ7����b�<���p�2󮪤��ζ��"�ӕ0�[4����;?�ˋ�]d6w�JJ2P��.�����%��_`�H�<�Dn�E�3���gc����1F�mm8h�dp�NғGGE?�'FX\+Ir�Yv�Y��RUq��xj��f��c�v�ǟZ
si��ޜ�w���$#PU���$��u�����`����Æ$] �':�KVЩE��$Cg���_�x-Y^�y=����/0�E�eg��������4�}�'��7{������P�fʗO�~"8N�T����|���E2�g8�n!�-@�//_�_�dd� 0��;��C���!����5H5w(�^$���\������T�3���k�?�.0�-��k���.�>~�����,��� �X@���~����k.^��|Ɲ��`�4���=���:��Si8��y~U��3�������pw �<� ��}��=Q��>�pu�O3� ��~ ���gg�~Vc��s���Կ�B��v��3�t���:�É�B(��"�A����y(ю�E��PD;E��"�A(��"�A�E���W����c-q;�^h�b�t����#��;��t�f�x�����#_����`4�	z �Hp��5��#~|O)��7���0��p�f��X��%~�����	����|�X"�?����z�o�8.�Z��PG�>wp��a���V��x�|�oďQh~�N3�%��Ri ���6e�-�V�J �����o� �#��%?�q0{���|�W�=���"�A(���� 2{�D;��B� �od����o_9�/�ڭ�����s&�T5��ז-KId�B�B��(BH��E��k��^���("{�Y����(�e��:=� =�<����ƙs������e�(f��̞t��g1{t(��%i��� �:���{m?��V���ͺ�(ͯ��@e�geAy��f���WA̞5x#�~�G�n���k���@�7�Y��oy#\_�C�@\���F�=���F�sE!o�G�zd���^�
���7� ވ2��f��k3��.�z �A��>7p���߳���?��� eJ9��?Ai~�?Ae�g�$�:���O�=%_S_��?A��Vf_ӟ���'q(������ʁX_���r����1l��S_�����O`~\˟@9Ga�0�'A�+�7����M2����f����� ���wҬ�g��tn2��zi`?��0������?1{��)+�+�*�������?~��t�:o�+�1=kA�v�+!�W�ƾݻ2�N鋈�>����NFZF\�q�hl�M]��}���;�,�
.j�j��OL��@j<�ԯ�8�xkݦ���V7k&�>��֜�dV�~󲷷7��&�n��D��LY��#'��IB=w��9��"�ٳN;:��b�:�㥱��O�,x�n>��0��[,ϖ�~�K��y���a����b�L�������O�˲)���s�C�N���i��n��������[�Z\���n9�9\�HF�=kl�~���E�OKy_�w����"b�8xs���9lblf� �2�чu�i!E�2B��.�2ED-�4����-��|���v0?v���*q���y��va��^7~-5'/K�@�MrQl��W���ߴ<��w�b��ּ��WS5�����Z���4�j3��x�H����:�X�@�Y���A"bT��B�%��ߩ3���g���c/�$Ȋ�����ǢKG�[��F.��3FE�g�̩�+q{�ƅ�N��$x22���}��}�'�Q[w���a.�@�>4˱���<�d�o9�a�9��"��%���Eh�%�y�]���.Ȑ��|�I�}�p{>ɕ�Iq�A��>��.�Қ���r�"����8L��]��n�o�*e�S�f�m��:�+��,��|jS$��׮��@d�
��ꓤ6����rd���h;�~(����I�|��q��� �I�����)�l���b�.�Mu���$�ߜ=9B!�r@v���#-��B-����y�y}��������9>k��wA�{u�&ѭ�eto����M�f2���i2Z��~2�;{�&~�g�G?k��i�zk{N���wv^��@
�R���=��3�|\�",S��yӜ4�
��e���}�^��W}��S�.�����I�d�@���ک��1efG��}[��b�OZTЊ��mH�>,���~kq_j�ȹ���
�&���,��Ҳ�w�Ro�gZ9S����F��_�D��!h1��Q���T&Q��b�IK5����bH�/�oIp�G��-��R��9��L�L���q��^L��Rxw�W�Fc!CK	���Vx��`{����˜�:�J��(5�]�ɷ�q8X������Zb����;�������ѻO��'%�ͩj�f��)|Ƒ/f�B8���v?���\��Ӗd�h(��Oq�?��a����U������񀾜[/�Y����#V��8L\b��ݔ�q�O�萅��=~A}`��$w�Ij]Kv��F�`�O�if�k��Q�����d��܄�d���b�&�lV?x@ʾ�X���*�e�{�Ys�����������JHQ�v��}v�����!�+7��Kx�c!O,7���g�a����T����-9�$)�\���,QP<�<�����E�X�A`�a*<ކ: �1>���U�̱��15�Q��g	�5
4��֡��W�m���1Gц[�b�a�I'މ�;�!^�H����ݬl��ަsg\���SJ�;e9j����Z�r姳��5���3�VH��a	.W�:��\�3 ��+HV�q�:m���I�o�d������s�B�W���9?A���.��f�Of��h�Io�6t�_������"�X��B]��KV6icؔX�.*z��X���ʉ��u��{'6ҫAQ�t���H��C��J_�*i�45�9*礜����kc��*��ٕ��������L��mycma�ꕛy��[��p_�(3]�7�zC��{/����>�t0�������T2F���mڅ$��"A�Q��rl&ީ�mbH�౅���ʌ٦t�	�gs�b�ޝ�l?bj(AGy;���ym�e��d�� S��	���e�S���K9&W���*#���>��R)JX^	��$�q[��ƥ��$�o`��䩛�t��6\v3Nh�%d��w6�(����{M�5�v	�nzO���q�\(A�^��{�N���i�v��*��qֱ���'	Gp_������*�+h{�<�O�hj$�HwL�O]��<Uc<{rH�����������b�������j���g���gf�}�����3��mB�3�Գ��p�'�:��+>ڇ/�����5V��R9\P��qj+��CN���+F��_��k�������/LW���>�'�f�y+W&[,P��)�ԋƋl�a�,�r��pAK0O �S��p��ȑQ��R�']�}v������ѡ%v��n��u����{��\da�
s5Z`R�����oa�~{~��ۻ�ͫ�G��"[?U�Ъ	e"�"�`j�{*��cz���%}^����K�fQ�w��}����Ȓц��9Ӷz|}U�-���~=�Sd��m�;���cW_ILxC#�4�������w-���z٣+9>��m�Jx*�My�H��
λ�Aq�XI[�šOð`�!ey�9�J�N�P�$��v���������x���NB8��wo��+�G#��
���s�!������zw%�AD8��]�d����_P�ٜA�GB����|��&����:K�f��'+��
ͧz�p�k9��q��}����F�q�����I�F|oO���V$��g�)�O���]C��㇊y��=�՟�/ZS	��>+l��PUGY�m,< ���E��W���C���#g�>L���Ɯk6s�(��9�"=��7�p��	O�ŭ�!X���=jd���4�>>�Q�����Y�^���s4�Q6N�T��i�y����ӟ�*6�዁�H�~ =�CM?Zj� ��h<��vZ8v��s����.�4߸��x���f����>:·3��