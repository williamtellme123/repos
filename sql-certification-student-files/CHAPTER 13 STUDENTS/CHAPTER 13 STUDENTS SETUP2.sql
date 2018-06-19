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
Insert into POPULATION values (309,'C','GRAYSON','COUNTY-OTHER',PK     ! t6Z�z  �   [Content_Types].xml �(�                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 �T�N1����^
y�3���Hw�J��°����?����vq���(�*ћjػ\;���3�Ey��������G��|e^zW����'t����\B�9A��q��N{=�\�fB\����}B�VN�j.�+'a�{��[z�BD�	��Ӣmt'2$��o�Cžg�s�chg�s�[�:�  �� PK     ! �U0#�   L   _rels/.rels �(�                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 ��MO�0��H�����ݐBKwAH�!T~�I����$ݿ'T�G�~����<���!��4��;#�w����qu*&r�Fq���v�����GJy(v��*����K��#F��D��.W	��=��Z�MY�b���BS�����7��ϛז��
��veck����#��hKl�%���W�Wj��`�>��b���o��P�!q=�8���c�k٣>bMr����5 ?��R�?�� �����k��j4=;�ё�2���D��&V�['��e�͚��B��X��͖�5��?C�ǩ�8Y��_Fc��6v�9��.r�j(z*����ϳ1o��ȳ��?   �� PK     ! Y�A  �     xl/workbook.xml�T�o�0~�����;�G�IQ�j�V�(��K_c�c3�,����;�l���i{�l������<�8�}e�p%�x1IU��6���3��X""�d	>2�/ҏf{�w�v �Ipem�����9Q
˴$�͕������W�=���V�K�5���hKg�%4&�$�B�	������"������]�g���e��������䭢A;�]�.0$9��$#�u-�������ۢ����'��j�xa�^x����me<�DQ�+�~���"ً��Çi��m�/F:�з��#��Q"(�ݙ>0
"��`{gl:<��C�r❇���FN8=�ix8�pd�$[dW����� w<�]��6ׄ��MY��h�� ���vǿ�   �� PK     ! Q��S;  �     xl/sharedStrings.xmlt�[O�0��M�M�Gc��Ʃ��]���A��������@������/��8����Rxxn�qQ�M+�.���=F��ذN
����//\ �tW�����@��%�\��C=Sz9l	��6�p���8�}Kz�
�jy��7�r�灇g�8�w��]���̶�.Q�K~���yR�����1~�Њ+�؝�Q�Μ�!�Ыh��2��a�
��P��%�k�MiSȿ�'��#��n�n -Y�2�����7ߓ4/ݍ�s�SNX�v�*����d�vo���p��1�,�mw��{i���.�-�;�?�[��FB̶�e>�f�/�N�ل�1p�N���ݘ�k�JP�I\'A1��6��v�Ҥ��4ާp�.F4ݗ���CaǇU����9B���8cv<�w��P�<h��疷/��Vމ�
������A^4�
��}�O��3�
��5|���y
��=�{t��T�C��]Ę���0B��ʙ$����B�"�:6�3�yq@��p�"���BptU�T$�|2O-�����>.�a�2 ����$9S�O���NԳ�tZ�;)��Z;��|�?(�=4O�cxg��;�~����^�7���څP���u�v�7.�'��}��x���;��4@��V���j+7��2�(�i�T'e�#"���`�_U�)�MO�3cV��Ym��)�j�0���8۱V�rw��G�h���v�m�4�]�ʼ��N�nyI@��'$��Lu�Ʋ��w$��΅E�¢)�/C����@mX?9��j������
Q<�q��ѕ�9�Hor&�3 �("ݒ\7NO�.K�W��ABK7�����<;����u��AO�b�64�7k)"���&�R��9n�A݇ӱ���	���2�A�p��Et
�g#�f/��(�,墇x�9\�N�18u(�ۮ��*h�4Dq��@�Zr-�����2�L�H�a�Z���[P�L+�OU��˞l�ޏ�����7��ߨJ�	��j��1�͕��w�0岫)����E(�(��gp%�+:�n��.�38t݅SY`�u�=�TK�i�Y�LCUdմ��+�����2�V�^h]k�u���*qF�}���Q+3�I��2,5;o5���@�D��o�a���V~�w:ke�X�+U�O��	vpģ��s*�
%|{H,����L6��+�5"\9��{��5?,U�~��սJ��wꥎ�׫}�Z�uk����(���g��G�E��E��}���GnF,.3������0���0ѹ��z��Z�Π����R+��^6z�^�7[���s��^�zA�Y
�aX򂊤�l�^����f���ϗ10�L>r_�{���   �� PK     ! u��  v  
]Y�\�Km4���O$f
lW�a��z�F|��a*�T�f �gF�Yq�(ff(ǜ�m3X�r��Fm.a�ɅVZ�{rZ�5�
`S�vl�10��5M�H�c���m	�0C�Ӭ{au�����*�hfP׵3T��PR�\׈Y�TddC��G����~��u�n�Ӻj>�ϥT�.�|���CFr
��ݎ�N8�p�#�Wp�X=d��h5Z_c��Z�;ă�7���5(K	c�Ƹ�o�nrK�y��Gp3�<sκ&�e�l8j:����Fv_��Wɵ6�N�Ϣ� ��-\�l;�#�$���h!81��X������~�M�Ja��:�7�5^�27OP|Y�%QI���XN���6�`���d��	�99>���s�����{���9�ܐNǿ�<�5�!����<��I�|��!y�R����`�?��\��\Fpw>����V9T2�V����@��7���&x�6�
(ez�ңjiW�X���/�jg=E�5e��#���6�ګ�}�y��U�N��H��L��&#�o&]s81����Ե��۟L��M)C6�S�*|����v3?]�$�=q�{tI{�v0��/��������/��7-ļ7�U^��5���P����1���>���U�vr�z�h�'�d|�I����h~$A{�:��x^� 7�����0*:_uꏂ����N�	g��A�?   �� PK     ! ]��X�       xl/worksheets/sheet1.xml�X[��F~OU��k�xEk��A�!�T6�gǕ:����ק���w_�?�����i���[u�^Hݔ����^��ȱ��������3��^���6?�#Y���.����ߛ=!��c������A�{R�M���,;ZW9���)hN5ɷ����IP��ї���ەIh�\�#�$59��o���lUq]��ߟO_
Z���<��]��^U̳�#�����-���UYԴ�;��@:z��Y0�iy�-a\v�&���m0����wB��K��X��ȁ�la�|�?J��"�Ma���o\���{�H�wN��k}��$|ڼ`�Y��W0���+<���F`���O����koKv���A_7�|�3pn:q�����4�L�p҂�~����2�o��Zn���^؟
3��21$<��XL�9q,���
W$�D�� �2i�/�D��c �Y'��:a�ce<��Ν^)H+�:1F&{�!ml���i�ej��,� W�,�j��ϱ2�2!�W
�M���dO9�2ic+Jl���C�Gg&l]��p�'7�±Z�d���.�˕��e'#��e��r��0�V
��6
"��p2 /2GG����uL]MA���n��hk��^)���ۉ�01#G"���T�j�f�qI�v�M8���Ν+�f�d��i~�d��L��jdlFVjdbFs�!�ȟ:mŋ��!�=d�r�J��Y�N��3@ǃ� ��\�������y_8�-�����j�dءL'�EhUkc�N�
2�'q����~��/����0h�+mb�´�(6�^a��h�T��m�ݥ����ˊΔ#!�x��L�9�"Xbm�v�j�9jq�$.����5��	�*�/ڛ�1�� �FA�������݂����2k{&EZX���
>�1���H\,h�{���"uRe����[sw� F_|�f��j��5nϓvmEha�����E���}ql$.�ѽ�H}�1UF�/�Kl�������Ud��� �H.�m~@���Zũ1F_�����W�/0UF�/zwm�W�0�i��� �خ�������za�y:Jz\�jL+0
�����]p��y��"�{,����í�P��!�
"��i�<yM��*��L�8	��:Nh<�$}o���o��d�_�4$7��$�)π"����  �� PK     ! Pڞ�   �      xl/calcChain.xml<�A
1�sw�z�${����	$�%Do�xih��L�ԋ������ؗ9�b�q��N��!Ϙ
��	Ln�1����:��Bhm=k->PF�Jܗg�[�uѲV�YQ�I��s�3^U������K��K�  �� PK     ! 
GX�PڇC8���L>w��z7�s�����0Ķ�l���PP�P�w�v��\��,��E��g=�y����+C<1r�~ ���~ֹ�l�+7W\���YƵ�7S��jy\���鼁��X[�&��kG�(�;�1!���ҠKp�ՙ7�	̼K؅>��1f�.x&�1J=���Q�]Qp�RT٥#&8@��g*����Bpi,�Di�a�<�����jNK\����m0N|c�~z�q�����m4 �j"�#��Wj� \���{���-B��	M�
�
�8B%�j��/m6�V/;4bF�WZۍ�~a�S���	����P��8�!�FdR2��PN���~ԋ���kc0�$�qg�!}�6�ċ)��0�8۞o<s�7\9��G�*4-��^�C���b��YP��݅{`<o�z��5D,Ӄ\��uZlt}Ȫ�����[��������v���3OfJ�}m�  �� PK-      ! t6Z�z  �                   [Content_Types].xmlPK-      ! �U0#�   L               �  _rels/.relsPK-      ! ���  ?               �  xl/_rels/workbook.xml.relsPK-      ! Y�A  �               	  xl/workbook.xmlPK-      ! Q��S;  �               �  xl/sharedStrings.xmlPK-      ! ;m2K�   B  #             �  xl/worksheets/_rels/sheet1.xml.relsPK-      ! ��nX�  �               �
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
����i����$�V�ܜ�B���U�V4�f��#ĵ�p}�Ʒ;bD�- �ΝK�~ߌ�y'H��6Up}�ֺ"♅�ٿ�ccs*;�޺�w�?c�ݑM�v�<�׵�h}�|�n�@6�܈�?   �� PK     ! ���   N   _rels/.rels �(�                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 ���j�0@���ѽQ���N/c���[IL��j���<��]�aG��ӓ�zs�Fu��]��U
f?��3-���޲]�Tꓸ2�j)�,l0/%��b�
���z���ŉ�,	�	�/�|f\Z���?6�!Y�_�o�]A�  �� PK     ! 3�l  �   word/_rels/document.xml.rels �(�                                                                                                                                                                                                                                                                 ���N�0E�H��5{�@�P�nP�n!|��L��!{
��1����"Yε���Ŭ֟�g��vV@����֮�V	x�67�"I���Y0`�uy}�z�^RZ����%��:"��y�;42fΣM/�FR��^�oR!_����1�3&�6¶�V
     word/document.xml�V�n�6}/���Hrl�+DY�qbHc�}.h��K$Aҷ~}gHI�6h��,
����o���+�/G׶{��69ix��V�$'$���{�x�A�je�*�b����:��G���;8B�4��A�9����<��7�4�>N�^緟������Gg�����!'��d2��:;��Y�� P�,9s�A���0Y$2���g�~_�H���$m�"+����hԩ�?vKCu-ؓ�f��΋b�5	���	�ꡦ���V��w(���/�z���F[�v��J��H���b4��z`̸�Tt�J�ja��#TĤ���n�~M�����k8�yc���u�;V�X��7(b�x�����J�� :�;v=F�e����t]�\�
���KDw/��W��	x~^㬞���LaD� ����Gm�[��Q�0ϞsB��Z�9e?��,���-x��O{�-�#UU��)�����k� �FAVF�0o�g�eH��]�NюS�/�e��v�j��S��D�5�7òTʝ-�����S��]�)�A�o�,��,`fWZ%'7�>!^̎��>���  �� PK
       ! %>���5 �5    word/media/image1.png�PNG

   
�ܹ3��H�H�H�H�H���@0�dq�Yu     �	� 	� 	� 	� 	� 	d9������$��~�իWWUU	�G�1|��t�`�9�`��,�	� 	� 	��{�/r�5K"O�#��H#��#�H ���תU���#����0�4�%{1�k4z��Qx  �H��"��Y4	x�����
*�H@5��H3� �X]�[SMLU��P���J�C�V1<�*
�$@$@$�� �"� �����k����.5#vy�WDg[	� 	� 	x� �"�芒���tg��$ҧ�i�֢��Q�<�nԦ�a2�f:�ItM�5N�S^�H�H��h�H�H 1��T:��w�8}�t߾}/ЏiӦ�Xr:t�C�l̳yVb�!#���5Gi3s  �� �"ۑ2C�}*]t�#���pۏ?��Q��ݻ��
'3�x6	� 	� 	��%��,ab" �nW� ����O>�.���Ǎ'�E8`�$�՘��4�,aV���;�y�d�w�g)$@$@$��hey`�I�*Z�!f����̚5K,
�����nݺ
=:z��]~�m>�2��
�ehk%�2������ʯ�eÇ��a)$@$@$@��]d/O�F�$�jժ��^
�%  p�@С)1�
��I�\ ����'
GΆ�;zf����c�`Q[����?|2���ȅ���o���_9�90�9+҅V�"H�H�H [��-�f=I S��(��x4'@8l$@$@$�q��<�@�On�֥	H�[͐� 	� 	��Sh9E������#ڼ:q		� 	� 	x� �"O���{`����4��0'�"K"  g�.r�+s%�НE��W,�����F$@$@YF�vQ�)��%�t	�O���dk֬A�m�B̜9S��6��%�
pd՝� 	� 	��?�.�Yp������/��3gΜ;�ST��/�l]�b�w��	�Gn�Y:	� 	� 	�� �"(�U WhF���<F��uɒ%FU���y�\���Bdñ "�� 	� 	� 	$"@���H�e]"����C=d��%R�c5f�$@$@$�7����Qև���3�<ӵkW����֬,	� 	� 	���hَ�� 	�D qP�����Ry,�H�H�H�����K�-kF'�Ǟß`(9
���L݁��.��za���!�1cD�#G���9�#�ٸq#VI�8��Pc���^�&?7��rrs�Am9V��   P� �"�D�H@��"i ,L��$&!  �	p���p$���A�G*!��*�!  �T	�.J�ӓ@�@�?7̡aO����W�M$@$�#��|�LV��$����`���x�	�ɦǼI�H�H�
��xt����?��6ر@�iTSSSUU%0�1���\:��9��h����:^Њq����� 	� 	�@h����@V���?���_�&xak����/�74De��E?��,P p�l���p���.iG�H�6( 	� 	� 	�C�vQ:�x	d���g�9�Bŗ��o�Ec�/�.Xڵɻ� �u~N^�uU��P  H� ��`1)	d�]��;�x�t(�"�H8���G�^��\��h?���H��R3�<??�m��V���<�4����|�&K��X2	� 	� 	X%@��*)�#�l# �p$�DC��p�L(|�1|�C��0����U�V��+**:]q�1�Ba� L_̡�`���V�0����{�Er���I�H�H�"�EA1	d�.���`E��0�0�%�M�I����7vO���vw�lSyp��G����9�4�_��O��$j�E� 	� 	�@Jh����I �Dt�H�B��4�(O$|��"�B;܎P7k��
I5L���`�CA^��ڜ^_A�-$��]r�TBK�l���%!жu���e]ۑ	� 	� 	$ �=��ѥ���NQ�$@��ΕFPtG�s��ܓCݒ4��ija���	��"�+Y��Z��{�Btȭ;K' �H�{v���;��ͅ�ǉ-2��d�O z�6�/B��6��HS�9�Hb��I}�@����mr%��͢�Ȉ8}q�l�Ț=�>�ݶ"��˟?�W�Ԛ5% H��W�">��P�˧��r���5�Dh鶄Y_nD���V�b����I�H {	�do�Ys �	�ǯ�/��xt:<H�H�H�<H�v��F�I�H�H�H�H�l%@��V�̌H�H�H�H�H��hyPi�H�H�H�H�H�V��l���H�H�H�H�H�<H�v��F�I�H�H�H�H�l%@��V�̌H�H�H�H�H��hyPi�H�H�;�:�z�A�u�L	���%Ґ	� 	� 	��]�&A$@$������a��{u�_���4��0kB$@$`�E6�d6$@$@
h�&wd���_�FI)	� 	��Zh��JC$@$�!�Q}ss�q3���5��y:	� 	��/	�.�ZY) �^/h5��]���{���hXs  ��	�.b�  ��q;ĭRK�����	� 	�@���H$���;Q�6�<f.oŖ�XA[�:wL�ss!wk���6�Œ,x`Q��cg/i�?r/ə�H��$��ڹy�	s��;�7t���E$@$�#��E'τ|u��S�	���L���hUk���T��!��" �����0�`eV�H�H�:��ѝ�*��A�C�dp!��fJ �0����FQ����$ ���n�V��^�`�,���x�E$@�'`^MĕE�W7+H$@��]�gb�%-Փ��2l<�H��J�x@$�P�׺�^$@$@���]�*]ӳ}Ka8��ʙ�H��!��>r���W_���^{^�_��+�(��,�H�H 
`!$@$�)���@���ܹu�7��2��R�-&�z܈�x`��=/=O)�)	�@�tgH��uO��:��lɡ��=f����e��4�Ȩ���˾?�, �H3�h٢jfB$@6�]�n��,�aT3��}Bw0�;��O_�
�(�:�����=��z@ɥ��[\���j�6�EE��$��P���_�ݺv���e��y�tht��$X	� 	$ �%��x��k�����˰P�J����om>�@$��HEC��P ��3��E?_T=��ߔ�~�Ow(eMMͪU�D����d1ە�
G�h���,�hv�Gu�x�vQ|��.��2j��jv�f�]���7U@$@I�h�\ho͊��sv����NA�Ͳ�t8JԔ�R� 	dB@D\S�u�����;w^{��_���矿y��:��p����Ç/_�<����L�Ĥ9��.�T1p��e�T�^0��U���`�"�� 	��S�EڣN��BUUUb�jeeeYY�S`����B-qz��6�u�I���N�>�
�Ae* /0�"�_��uu�:l�z6l�/�0x�`Hs��y��<d}o��)#K��rsrs`�eD��Km��� 	��@��*������F��&\���1v��Ɨ�ȕF�_� �	���u;K����O�>0�PL�n݄Q��#�\�ӦM3o�FԌ3���kN��K/�=ѹ:�hZ�
�F\p�4s& ����N��B� ��*�djjNwp�v].j-��|�N�g�$@�	���|?۶m0�y͚5���8z�hqq��ŋů1�/Z��`>|8//oÆ
,��cǞw�y���/��B����gE=z�@��{����s���}�l!}�">^��I�H q�1��u��R'��[_}�K����ѣ��]�Em��'�ü��Δ$�21�� �
FT�6T�b�f2   �*J��Z�n�*6�@8����'�0�����/Z����+�h�-L��Q��4i���ɠ��W͠�ւ�I�H�H�H��%��]ԦM��K�N�0��w���[n6l��{�744�M���'O��aNСC�6�W)i�m3���F2x��� ��^+�$��$@$@$@$@�	(aC�n�v��ϡC�8�<����h
0�֭[;'�{����b/?las"���k���vD}Ym�@�(�Y��1XE�"�0�ѹ�eR���H�"D�Y�x�H����-�#��Ŭb�566�~��Y3��$�E$@�%��]�[�nUL�D.�E�6�k׮�����A:���I1�}bҜc��T:Ġ�q� ,U���M��q���{�վ=�|ĥt�27�x�믿��q��\�M�6�=L�w�y���ĉ����� ��O�빹O~����e>$@$@��]dF2Ѧ�9=���+�d���>��#��T�yJ2�P�I�mbăH�F�V�jh���k/��1g#+,Iݶm�_8p�]waB��.
�B}���I���6mN�PΌ3�=>�"�w�d�,��۷�	�E�UMp�N�ǜI�H�R"@�(%\�&v-�zmmm�>}�|ELb|���&�b02otG�^�aҋ�_�\�A�ݪ#�!?�!���|w�իW�[߂1w������'��հ�0v�E�bZ��CJ���x�����ۇFno����#��K�ݝ
�s>j=�+  ��.RH��BPu��0�,'��m�A���-Z�d0�������}�i�AK�z����~�A�3T2O'�t���������/+**0����G��{�رcŢS��{��իWAA� '�ù��=�),,\�|9��;�N1�8{q���'s# {	�.����s3�IU��|��q�����1��=z�@��{����s�������G�A �Jqq@��ޡJ>�̖-[`�`Z�Ex'v�^���
�~����R�/��d�"%�ơ@JJ�Nee�9W�C�1[  �Tȴ��
~1\�('
op�y衇
"#�:�Eus\u�U F�8��n�[Ύ�퀙!	� 	� 	� 	x����"o�v^z�
pN�o��/K�C$�"�>��[e~���GH�G��0w�)�$͏�=�"��3)pX(	� 	(E��]�Tp�=
�#���g�ӬC�|�׺m뼉�ʺ��zE(?	� 	�I�E�H7���|}������D�x`����^�._��傀 "&��F�a���E�.Rp��}�������������mE��ٔ\,�F�.��?t���	X$���?��Ĺ�d2 �$�$vNt�r�����s������K
=��F2z�B5��(�G�n�C�����]t����f�����D�H�Ӵ��׍"=�bt����0l��ڕ��*v{�*�������_Ǭ!	��l����ЫMq���艆�v�ct�>��MX_�Vҡ�fS�
-07�F
��+tMA_
JN�H 1��=T�w�\��Pj�W6qL�W�feH�  wF�% �IO,?�@%朡%�hY��|"(�h��I�/�Q�X�#0Mwd��g}SY�sD�;3�H ��n����w��a�$@�$��ܯ�پ��
�v�b<Z����
6��J��;%�H$�� ݡl!��;��1A��I����g�"(#��Вk"Ԧr�?����T�e#���eÐB��A�1A)�`�$@�'�%�(f�
ʶN�j�� �:*�)
�*�CS%����l�`�H�	� 	�%�%�0b�%��Oe�%���XCȐÈ	�� ݡ~Ѥ��a6�9&�1�Q\ ����Oj]�H$��4�s�0eͺ�n\~��Zܘ��֭[�f~zP�~�\MIᱭ�6i���� ��2oi�A��]�pT�P��s�bE�k1.��՚�GO�=�1�����M��6+G$ �@�}]�:zrׁ#Ӡ����7���>j����M�#'G��˰�
�]�6�ȵ����.#�4%�rg�v0v���v��FrG�����zժUxI***�.�����S  _Hd�O��[��~e�"���pw}}T���@Ց�0QK�l��.���� �$Z\�uDMYl�5eQN&KL@z'u��բ����T�6W�4q�ɯm��"h�@�v����:�����=��z@ɥ��/��qo͊��svQQ�(��"�Q���[���=}thi�4��iԔ�f������4-P������)�FDw��W
ٚ�*'�5P������I�P)iJ G�R%��$@��k�Ì��ct�Q�J���F�n�����%MS;w��ڵ�iӌ:���K:tذaCL�O�>=t��C�9O#y	�4�\6��!�Nj�M���T����#MVAr��*)�#��D��T:��D��ڤ}d�\>�h�w�ޟ|�0x�y睸�۴i�n�:�L.3�[�tM� �k2��jUc�Z%�b:i#MK.'�4���RI�#�x���#�D����{��$r�M�\"	�:�����>��|����u��	�+���C	&ӌ3����#��#��۷���u�	�T�5ȪӥuR�ͪvּ�RF��Ȝ#M^�e&H@�E���<R��S�֯	���i�ݦv��׾��{(������,��֭ۮ]��=z��a8�<(�_�fMuu���Sqq�E�֮]�z���(�LM�XM_%��Jw���Pʕ�0Ҕ��
���&�@H��$�$���Q��}��}U��It��M}�[�:v��|��_��#$��h����._��P��m�Ǝ{�y��>}�|���z�*((p�EHה���Eq:�t����S	�#M�+��4IV �'���B?��ss�@^^ިQ�n�������ԕ��
!C��={nڴI|ܺu�W\ႄ,��$vR��z��D~)#M�,�\�4�"�rI�� ��]��d�y�ěݻw��	��s���]�t�뮻1}���/***ڿ����a�0}N�/jhh�OI��,�C�tR��P��$@$@$�97�"H��d���T* Z�R3,"Z�l|Dx��g�!�|G�����"�Z�<�K.�ĨO>��q`M�����T$@w(�@&\L *$��{2��% �,!��]��d���L�a��c�8iR�eI�2�	]8�ӝm�Y�	��!�,?���,G�� 	��-\�� ������B�&�x\a��xh�h�3�ߑ��<��*K��PeU�-���� ��������SO��y�o!��$@$�(��"'&��ͳ%^{��5�Es��ݱc��xh����� 	�F��P�P{� ��o�3�7k֬�o�����2a�����K�I�H�^��ENL֏�g@�ƍ�"\�ooKbn$�m��6��Q_��o�`���_���/VTT�
1[&��եQ/�B$@�$��]|NL�o�gKz2�C�r̣�F�����ˉ����߾a�'��<I�H�}�
��Sqq1;�Q)M9QA�i8^:v숦���yF(�~a�'B{�	���̢E���Ƙ�u,�";�����89g�~i]Αp\��H�\#��.�r�?�~JՑ.���)//wM��͜9sРA���
*,,�A��5��	�bڧy7s��s��#*��p���)^S�m�,	�uD�H�<M��v�/�0p�@�(�������Ӻ��$@$@� ���x����1AO�B� 	x��'�"1��#g��Q��H�H����R<���0B Z9�iH�H�R%�
�
"="w4�x��:3e5����o��m�L�:�ٴ�K���n�J
����P%�L�B��q�����*����w��L�|�4�ώg� 	�O�E�(:r�����sZJ�bѩ_9�%@��
�i�`;j��=���f}<v��v�rg}U(�)wۅ�KS��Jw�W�����_����7ZX�	6ڔq�	�B�/m��C'�
��ŉt�vK�'K���&:'
7�ٶu���e]�9]�'�I��:"�Hл�ك�rM�٨�*jZwd�\�*����vѼ[z�Vό2RBS� �N�;4���q\+�6]Z_�Tj�E�Ϟ{�qL0�	H%���\��gߓ8O;�f��$@����i��(jI�����D��QJS35�E���4�UM�kPGB�C������oD�=��<�@4;���ʘ 6X?y&|^���y9)T���&�����ar1�6_�狃��5	��;,�E��R|F@tG���Z�T��P���)��R#Mڀ�I��4e�V�1�D �Pd��+�('	������T��h��|	�4/R��k���]+�$c!���+>qe�  ��]�E�$�{JuR��b�gu^���"`I�H�$@��A�̚H�H�H�H�H�hyBM�H�H�H�H�H�A���ˬI�H�H�H�H�<A�v�'�D!I�H�H�H�H�$@��A�̚H�H�H�H�H���'��I!���'�F��`��IB��_�ް�Q��-�O�=T�:wL�B�����u����Xd���yS���y$@�ElN`��)��W+�2��dh&��c�C��鋳!��U�#?7�`����� -e�H �Z�O�����ҳM>'�X��d$@�x�`�  ��
�����k�\8�o�+�$ψ)& �gd���_i9���O�VySYE��g�$�Mhe��YW �t	$햱��.Z��շ07���9�=~��H��<�jE�/hu���a�d	$@�'@���*dH��!�޶;�3/]�%�����k�E0�	$P+��4�Җ�a�Ee�$@%@�ȣ���$@n`o�m��7n`��g��}E�T���>D�����`I$@>%@�ȧ�e�H� �޶P����b��7C�n�2��V~�U��� 	�� �"?k�u#�� {���t4��F,�E�w'��J��ۧS�
]zN��\���!@�H]x^��_�ް�Q
��Pot˪���2���ʲ�2W`�X��>�p)�/�]�n����Z�H�^��.4u����s�/���uQ����4k�^LF�F���٦qg���S[*�����"g%`�>"��ɴ%���z?�)���w���!�(2��pXc�����v-��'��B��նJ��p(��m��R��fSP��4�B����� ���ѵ5M�IȤ��&��ܐ�ex���}2,S�:De�ɚ�W1�N��HH ��FQ��fƺj�ZU5k�TS:�h6�z1=	d�����5miSy�Z��ם��� �d��'
�͢���+^Q_���"Qj6�J�	��Y��b:����G�.��O�������.I�b|E�}2���'ӝ���>�"��n�Ν]�v������:�vF�O�:th&9�Q4XE�"�0��i!�����S�֬��
]xG�7fO�%@�ȳ�SX��.#XJ}:�1��E�N��>*��n��>�X���,:37�tӒ%K�=��G͞=;qcmll�1cF\�M�6�֭�С���][��ϣ�q� ,�ʹ�Y��U��<��L[�'��]�;�*P!XA1;MJg����������2�d�sυ�t���}��<x0J�֭�s�=g�� M�6
���pC�^W�P��4�tcg�$�1��<�0��kv]ӳ=7r��└Ӎ>*��n��>ٹ�I���o۶m���
�h׮]p>|.���]�v����v�UW]5iҤ;v<���1)
3�[�u�����ERVj������ޯn�����.���?�]#K��rS#���p�O����[�%}2��u�V���D����'�ׯ/--���cǚ[.R�F�9�t�>AJe�{�
B�f��YmP� �"����,_=Y[��v���d�~�>��Z�jU}}���@UUUm�^Y��r
��%�X��E��l(�b��g_{je�)��	.,G���[�j�bŊ~������޽�:����8q"~� �ƍ[�p�#�<��_��Vx�s����7H��_��'�x�W�;��{��P�+k,]7q��)#K�s��+SX�V�x������{�W���v&��T����Ye�
���l�-��I {�.����ZP���=��z@ɥ��%/��[��"q�.**��#�.����ڭ{`M]Z����F?41	uP�O�v���ɨ)뗇\MY�S�TM��^���RmZLO��]��jR����]��E�N��[������7�W0w��Y��=��F��>�FQ�4r~4��J�8s��d��Zjl
jJ��v����P0oi6���t�1�C�>&�Z�DTPm�t��#AY���w�}��
F�!6 ��+�o��C-V�ɲ� B</[�L��YY�V�H�H��"@��.��Ѭ"mK�H �R��!M�A�1ƒ��-I�6�A$@$@$@$����f�.ҩ}��H,Q׎trɦs��nEYiN#������$@$@$@$� �"4���|�,J�N���+�+��()2& %	`�"	<t�PK�aϢ�o�]ls����2YN�����x�b��#��x�h������\H�H�D�v�כ������D�8\!D�ڵ��'$A�$�I�4IsH/XE�"�0��i���ˍg��@L/m~����04q/ܗ(X)�B��o|���Q4�ثjӦMx��w�)))�"%���|�eD��YtxD�t�MK�,���}���ٳ��clƌq�'l�nݺ:�� m!�>�N��40�+���!���7jԨ��~[d�z�ꫮ����PJ���J.�RظD�݈�?o�<ĥt�d�������5ӦMC��0���}���1�#��>&���^98_}����O~�����1��k����+B�.��z�mۆgǁ��.</��P(d����{��P������Fq��O�{]hvˆ�.��� 	8G�v�sl]�Y�J��D:l!ߧO�7%bs=��s-u8����������9ݻw�,����_����th��&�CM&�DN�'��6�\4���}�o��'��Ç_�v��S����ѣ�+��1=l�Oּ�f��s�U�q��Q�O�j�*�]&^x�t�E�����.ç�v��
qpSWO\ ���G"��NW���?��={�9r�
��vL��Ks�nc�0GKT0s(��=z|����6���
�7y�LA$@-�]Ħ�<����0��'?�IK$�(t80"A�$�♔\$ �b���(6A�i�數f�c���5��.j,Z�?��?`
�Cp�
ŒT�L�����?�{��S[1+3�Vb����V�Y�DP� �"���x�Ch�	&�	ԥK�[n��y�]Ɏ;�GԔ)S�S�������Z5�4Jp�Oh�0r0�ӘD�/1�.n���~/
�!�S"�
guI�H�H�H�H���]�FA$@$@$@$@$��he{H����=t�PcK���"�����O�:�R�LL$@�X�x����l�W�q���3��[ss���A���B�r�V7���H��h�X��	���֬Yct���o��`���R>��Ñ#Gٔ���P���fy�li��G}J|���
Ǒ��Ǵi��'�#P"��'��u���JW-��>Y�eÇ��l�� v(=l�mc3�l�����=�͛�-�)mRPk̶���`)%=�	H�H�"�EAy ٪U���#
8�t�A��b��@`Μ9��zk6�ԋu��V�\9p���3g��8ƌ�l�2/ֈ2� <B�	%B�0�ȄH�l'�"ۙ������`(9
����?������n�ቲޭ�vٺ	�N��,?7��rrs`!"
���*��Yr�v\M�,+��ͅ�'.�ݥ/��G7/C�����
�C�@$	��軄��^�o~�l�#IS� �`�z0'ؿ�hP�N���Z�f)�����UF�Z���fݿY"	x� �"�h*����E��f͚�=*�5�"��S-]ٱjTdD�=
�m��n��s�i��x�������rr���]B�j*ң��H�E���h)��$�y�.4hвe�hy���(��c�`��j���NW\�"�آ��U�C�B��4�(O$|��"�4�1�N�j�����(����4sH�E'��K�.ҍ'��5;���]��w%�E^լJ�����Z�[-}x]�W�_�f̘CH|�1H4��6���Gd��bD[�!� ѿԆڵ��~]��ʃ���u���x� �DT_���нA�T\m3M����t��WD{�s����
B��HH_\$w]r�n�0O���m2�r��݌�DT����~u��G��{�����xQ�r��tP� �"���\6�E�5��]d��
)Eo�	Z�d���,mɊ��n���pe�[;�h,,�{��rv�z��V��o��YMq��_��+n���4%�#1�����U�%�Fs�jA[bdr�iF�fip��)���^���ܜ�/�\�[,ë��
�����h��+��.�BI��]d��
)�B�ۛ
���b][���I��@hV�ы�#])�ㅴm�7��CY�v���	>���H�E��G��:+uR��>;K�w��?��H��?Y�����K����$�˾�DQ�U4��!seeQ��:"��h�P���-74�p��+�I2w4;kY}��S� OH�E�	{W�].j���I`RQ� �"�����E555�
U�~OC�9���HgE�Z�.�|ݠ��ڊp�7O�H��bQ�Ǫ-�!���m�.Rh�ӫ^���3��	���c�ƭ5�mW������Q"	�v�v�뗇�l�
�CX���Dp��C���[V��E����iQq�HY��r��K���8fk&6�����׀$��8����� /+?k7^ݨ�lӸ���]�����E���~�����P��⽾�|Ӷ�nWs�����:]q��|�<;_b]�<-�3&���ޛS������8����;@���P�ΒWZ=Y)�"o�]��`��
�q�O���HM��]Fs�ډ���з���m3-���c�\S�H�$:co7J�0�?������	
���E����9,�'����*L��x���\�E��X���nivQH�	鋋$N�C��͆������w�m�rY�����
7��G��6��0ӨO�H���3-ގ�+��͙�MK��,��E��Ѓ�n?r�1�ؘ�`�����z�j�6.j�
�4�RE.h�E�����ro�!q�F���F�o�N��F�>��"(7گ�Bhk�r�A�5�F0������������S�(4�v�����H���|p�Q�q���kaX�ܐ�e�����{Q�Uyk��T)<@��L����"��T,�����g�i.#m	�؜����K����������f�XS�
r_W�*�b?���౳��˟?��ĥ�j����]���J����������%%�qS�@�wY��0�E��.j+v3�%�%��	['s��z�Dj�[��iie��%T�v��~,.�Y{k}�ӯ�V�~��R\�:r�zH����e�S�M�k��Y�H�C�M�z�jx_�#F�>|�Li���=� ]���իV�gHRQQA�Ko�@��_T�_	�.�fݬ�v��w�zk]�Ӌ��\ڿ���N\lo͊��svQQ�(��"�Q���[��.�>��܆�Z|:�\k�,H)7첗c����z�D�~u�*�q:�%�p��ElN�]��l�W����.���꩕��T�����F,+�$���eeerEZY۰`��F��>�\�4L�7�Y$W-J���vD��f���H��
9��OnXOh��wG�13M� ���1y�v~uz��c��+�>��PA��1�
�'
V���j���r����UV�t��m�,�9�k���(,��˧�^�9(^0�P5�5����[���|SeV�9� '"��t�ψGB�p$�
�/_�ob8W�B��"N�s��or�֒*}�uP�1�#O��}�qK-��h�
s?�a]�8�z���������
s�jjj�K���(//�N_<�nUz��rEQӈ���+��8��t�ח)�&���::\V�x�i�z}�2.%�6Q7�;�cR�v���ZO[B3��"C>@
�5V��j#.�ˤ��\l�ѵk�iӦ�C�m��ްaC�
��{�ǟPX+  �5�E>P�f�o�B��'�'(5��Xʏ7�%��F<H��޽{��'���_�
�ucc"r"  �+�E��l��H���o��y���nEYiN#���Ǟa	�׼�i���`��hf�����?����OL�歧O��ԩ�W��V8�y��q���"s�Q�'Ovg����ڍ�� �W�,߲�C��c2�H ��k���ԩS-ɀ�m�СbT��G	��h��޸B���FՄƱ�6��{�G�N��K�v�wug�<(<4���n"����,J�L�0Nƣ�!��ƺ5�B�����CAo�����cQb�n�v�څ
8�Rp?.����	`�mѢEh�p��7,��bp�����<�[���G�i�����tú])��`�嗸Ma��uaÏ�A%1�ԧO|�\A{��5�Es�΅���y	�L�vQ��<�\Oș~��_d�kc8g���bP����p�1+,cR���\�����'K����yP�;���u*�+��】���t�T6ڝ��XD�l�2<����>��%�e���a|�!Luc~z��'��EH��s�����1��S� 2`�M�S8膾��\(�E�@��.��!�8Z��=�1<��߮}�u�RW�ͳe�ؽQ���7ɞ={n��[��0���q�Ɖ�b^�i���	�%@��?
���;v������>�=o�����}�r�ΝO�8!�!C��S�/ƒ�Q7��[7ʂ9����2l0R.�e��N�]�U�����,��<e�\�����G�d	�*�# ��w�B�ٳg��*����oV|)�����m̹Nk֗nXh��u�ǻ;���
´I1�)�^t��.����Ҽ1��lR=4>�b�p��|�C�0[�	�.R_GjIh�k#*�F���ۍ�bDܔFeb�ǭ�"*�R �! ��Ә �/���R6]
h���ɀ(������d�D��^(1	dF a�����~��t��ǳI�4��ͫ�� �򉫌���)�8[���K���������.��Zx���7�\4���}�o��ԸY1l�:c�8��M���#�W�C|�q��%t%��8�H���U}�%���'˷l��Ѳ��_	`�Ϙ1c^x�4Zv>���������|��U鬗�p�=��C�d���3q�;��n)��!t�Z��ǘI��RH � �"�4	l�Z_ih��/�;Z1�����K/�ٳ'�mEYk׮]�z��~����j��p��P,�o����_�Ի�[�"ͩS��~��ѣG��|饗>�-\7l����
�`$��r��_37�ŋ捹����_��z���0� fUu�ڕ�L\��rq�8^���%Et�̟��%@��
/P�^�


�m�6v����;���ӧ��)���͛�����r8����x�� q�(�ѣG:B�vι��i�F��I�H�11n��\�8��|̩s�Xf,��o�`��0��O�0A�X,�t���2" ��|>�G�6m��Ac�M�6���w^|��N�:�M�ӟ�����pr�����A$@$��7,V�7,��460�+�^�5����&��&}���g�ڙX�*^x�xbFw~���1f���x��h`�E0�0�"]v�e�RL�s�@�%%A���2�, �#   P� �"����lW��#'W�ܩl4f��vr*������ ���ӭ[7L^�'�|R��p�B�+�����c�af�������ٳg�/�; d��� �p�
��#�Wl.'��1��U�V��G����]쵈z�F�ƭ4K�q� �"�	;��ʷ<gk�z��xȥ^o��anۍ��_�<�fˮP8�"�HX{����0H�m~k��.*�7F��(D���~��`���A=:��#4O3���j�wRn�ݰ�,��y�aԄۜ$�<o�aU�8��[!S�N�v���m-PA����A6,A�q f�x#w?
�E�6=�3m;	�#��P�18
�i���P�{ǅh��}����������E��Ȓ�b*hN0��O
a�^'�w*��r�lԇ����fv^�n�`�	����J�Q�Q�(
��.#�_���_��mV���i.#ݷ�40������ɒ���}��a�
0�<�v��f�;jf��`?S�s�b+�#=��h����ز����]�<�&����+�/�\��U.���9��^�x,]A�SQ_�N�NW��䴜�o�u���m��n�<t�G����D_��=Ӽua����^�B�K1�rj\�|� �El
�Eҩ�Y�zqk#�!��2*?hy�1Ƶ�F��T�&�b�.}��>z�+)	�?M�x�'�,��:q��)#K�[a�+��wU�r�/]����<�Ko^����3��Z�Ǝ+<R!p�Dc(�C��T�eKZ�E٢�z���_��
!�Ba}�Y�|�������EuϾ��
U�~wCCT���@Ց�J,�`M�nP�|-�R>�"ڊ�[� �I�Jo�I��l��K+���^R��k�v���aS�f���~yh͖]�p8���س�h�`Jؤ����vQA�1��E-�*��2�	�/)ԣS��`~��KK�Mm��lԿ�:Y{_�MU�J�vW���n���G���!��S_㴋�ֹ��	�H߭<��4�gBaL�9������J-m��뫪������ʢ�C��a������-�rai���ZU+��#��'u��~̔���Vm���m(=�5�E�&����x۔-7#}������}�����p;��e}��[�[�.�����;]1�}�Q}�FCC��z�qT�j��� 	� 	� 	� 	(B�v�"�H[�hl�膗��뛔�H{io��v�;����i&47mV��q{
\�2:�N�CD4jS<:�����H)�\��΀���4Ogй�X�����>%N{SYE�p�LEUʤ�v�lj��~��o�{���ŝ�F������2WM㴋�5[K�L�/�#����g4I�˨�D�E�@����<H�ꀙ�J`T�Bl)ˎ���$����0��	P�����l~�pl�F��w�j�{>�D�1�}}\�
j�v��0�t��]~m&��R�[�j�)��x���9��]KBN|i�I�e�xTe�i�z}�6���GJܷ'�_�R]p�O`5��@�"�e���i�����QS�-z�a�����f�H�ѝ���Ѭ���"�)ޏ�70���Z��?�طu�*}�ڌ+ƶ�1B�epM��-��i�1x�����4���i��� 	(J �����w�U��b�@��d�h� �F���C���q�g|Q�6������]��F�z��4L�O�8ƒj��:P��VoF�c���O�{W�u�A���\�jj�v��m��� 	4O�;�HP��*�ב,	�6d��Xn�ۿ%��D	Y��b.se5N��^�37 �	���LL��Tf� ���>ɒm�'��\��e�j�,׆	-0kYY��.��K&"�E��W�8��,�X�uT�uVٖ�m#�4��aE�%�B2~��q����ܟ���~U �%���-�O�	���v���J��3$��0�4O�������c�]tdK�6yݺuK3#[O�h�w����^����*�~ֶu.Uik��43�m��y��K�|���5�><�q9n�n��	�pC��ݢ�kܸ�U�xP:&��d2�x`Q��cg/i�?r/�	O��:zrׁ#�}�dm�������G��*)	��rGN�LG��#WQa����b?,���r�˿ih�^[�Ł��-�B�*mǥN��en�r�f���!�RJ��݀o��jI㴋ܹec)��<�u}�$�����_Y�B*.�]_�3]u�@@�]d0�}t��ǔi�si�W�#�T9��n�]Tu��

9���TeRF(�J����m�**��
��iӦ�#̛�}����ӧ�F�$�K/��R���Y�f-^��{��O=���8�{��$R�MԼ�T��V�UZ�H*��6,��Q۠ƩqKRM���y�5N�(�����]F����Nc"��m���`-Y��0u�u�k�.��>ܦM���]�v���.����>}:~z����o�~�G�{�^�~}uu5,%����7~�xXY;v�x�ᇝg����J�݋�]�ɜ%AU:�ׁ��6R���en�"ԸEPz2j<Z�����8������"�����tiXt��Ž����/>�%FL�R�\Q�`tF�����w���3���/_����ի�� o�g�p=����t�޽��h�ܹ0��M���G�.sCoC_U��$:�����$�W�ŊXOƶa��o�5N�[$�j2�?���8��T��t�������W�M{}�}?^�JzaW���^
R\�:r6�TA��G�}L�����}��H����0��s6^�~۳��?��ߔ�~NH�3������?���m۶���w�nժ�СCa=������y睇�E�'���q8y�_������?�<�G"%��0�^{�5�*R:!9�\Y۰`麉#NY���_9�,��*�m����w�Ui�"S�mX��en�"ԸEPԸuP1)��4�{��]�vKP�D}����uuO/�Pri��K�ʷ�f<E�]TT:
���~��k��]4}thi��th�r�4�����z���3x�`Hw�q�/� ���N�T�3MUZW�⪴^�)�6,�b/�:��R�ƞ��g){�CrՔN�(is�j���  ��狪�������7���KD���PJq�6���1�0�������7�l����Y�f̘1�:/��"�*�Z5��+ޙ�*�k\qUZ��ŔlA�.�*������-�Y�^�\5�ǽ�K�O�`&HJ@D��6���w|�|RyDL|B���C����a}�R������J1�bA�8T0��@�G�T�?��D-�6���r�Ը��qH6O(�v�C�w3[�*����B*u�1qNn�HZ(5��XB�7�%��F<H�H�H�H����Z}���E:�or�%�ڑN.�tN8э�(+�iD�Q65 ֕H�H�H���]䏆��c�J�
9V���+�+���1�̘H�H�H�<D�v���WT�١���.��z����F�n�������jy2{ė�~�ذǴi�<Y
݌ b�v��:-**:t�>�?�ԩSqQ�
�D����)sl��x�b����sOҲ�NP[[�q�����[6|�v>�����*�����>}�`�)Ԯ[�n�=�ޜ<y�NCq1Z6spy��[�����s�>|�ڵG}�ѣG�8�^ڸ�ŭ u����f_�
��=z�@�c��S�*��nEE��pε/�"W���ɦM�b������z'5�4oW�$�Ư	�#B�ɘDg���5�|�r�:��6[�1
���Ĭ��#�� 	� 	� 	� 	8H�v��p�5	� 	� 	� 	� 	��'�.�($	d)�A�͜9ST^D.��e�r�Z��G�8!8����Nl��56�./�e���+/�j
}b�%@�Z�W�4�t�M�f�2ϬV
�"�ԑ�0�V����44D��3�+��Ǐ�0��*:y��k�bߘ�b�������p%a�SD�;w.2��?����G��wS�`� ����[9'0r6�`���p;cGi;�9�澵�e1s	��
O�Ѿ���7,X��Xt��Ĵ��х�%�ٳ�M�D5�n�
{	~�믿�駟�P1�K����_�I$��n���'�t���sf���0s;	�3=f̘^x��c�Q�{���2����ͭ���*E�)�
�G�V#
��R�	�K��`L�ax���*�e�� }bq��I|���
�f���1">��sA��1�E����娨���E��>�S�������Ǜ�!s�7���˘P��K/��������ߏ��G>���wߝjq)������SYYS:���@�#8�xj�)�R�a�i�+��#tjL�_r�u�`}p�yp���e��Z����&���Vpy7
�X����ޟZ�oJE?)!,��3D�bkl]��(�;ȍɸ��a��uG�2�4?7��rrs��BkF���Ȳ��Aݤ�%��w��\_�
1����V���d����[�mKʪ�%�����rԄ��6-���*m�l��en��E��j���t�
�áH ����G�?�m�[V��E����E��~0�����`���A=:���1O3���=�oJ�����vQ��ߖu7@k��*m�l��en��E��j�)�t_�
�E0������N��.���ݸq�Dg�]d�.
G�H�1i΄�g�g�>�H�^ʥ�����V�EWTTt��J)b�b�eN0��O�l���*F��Q|�Lq[�*���U��
�&`۰H�7mCY�CJ�۩q��F&ɼ��Lj�sI�98���΢	&444�(�G��Y����'�q��C�4��������z,�_�����ˤ�Γ��].�\��C�hh(�G75��*�KS%�R�r��m����MB5�㦉���^SpC�_�7���-�55��# ����bc��t�E �}��!܂8�{��{��I-�v�@�$��C+'�P�"�=���FL�ˁ��՗nuh����~�8EB�:���hb�0���xվ�R�U�>S{Q��^��
S�m�2w�I��q�P��n���W��D㴋,�3&�D �� �1f̘���6��o�ˍ,��D�4��4�|#�{D*���9cx��\~�v��r�\sqѺ��
Rq}Qb�h�=h9��
B��HH_\�=��q$h���&��{KO	ś��g&h��t�m2�4��6�P�!�g��9u*��_�k~���LUJh�*�
��z4�lŦ�����0H����΀��Җ馈JU���zH��7+��lkjjZ�B���'�o���j�) ���]d��1	d�1��#ҟXH�Ƀ$�Hn����DwA7u�M���b�*�6�����Ŷ�mmCA�k���#�:\H೻5�����8�"�7�P#P[[�8�8�͛WSSC(�"ċF[P��
��C�Jߨ�jERL�b��{��N��)�o���*;��r�2z��tp���h��(�K.��h��h�t����F��"�!� �d�s� As���I�ڼX�]due��y	��ӧO��������kO�:e�A�4t��C���*�)|��Je�dE0�UiE�4Ҹ�B<}����Z�a�׋�aQU�Zl�uO;���tm�>�΀�6eO�]��jR,:�N�磗�u��W7��9c�=��/@48�T	}��t1�p���۶m�cǎ�G��.z��7
)��J�8�i!޺�EO�7&��%_æ������I�+]�b�*����a�r&�"W0�R�0��:�2�oW��Y!:�"J�z>w�[��?��LCC��ɓ׮]�z��(F�=w�\|������p׮]p.>|���G�&M���Մs��޽{S��C�{���t����+�J�j�r��
�x$@�#�t�!�_`�?(������JJL�%�.�u˚y� �"�j�r� 	(E��CXK`�����W���3�]�A$@$@$�� �"� i����괴�m-��C��Y������I?��\YX[H*�U�6>��ie[�e}I@	���������
'&l)��:t�s���ؕ�g�9�"��!��fz뭷�:u
x:�ؖ='�㭝��dǚ�G��t���|]X?mD�¡%K��[��6h0h�K���lG�cU��*A�p�u��UD�@$�̋V'�;[H���nl;��/�8r�ѻ�pBrs�������q���//s�EN�|���׼���WF�߽�fEMM��+�J
+�~`Q]���3TA��V0��Ѷ�����ې�*��&���	O󹵵�}��ۈ���9s��o��jg׾ѩB_J��>��c�zN6^�v��D>�R���CT�l�ҥ�6m�{����Z�p#�TDqg®ç�Z�3<Jǡ�<F�氥�*~5�bf�(*�� ���ի1h�y��o������)�k�.��#�����9���G���J�K���\�G ����	H@>t��V&Ɠ�[+B�1�
J`�*�����sY�m۶a�QhϞ=�{��!�l�F�ʈ=���='!|&-D���i�AYY ֖�~�]w�����|B����_3�e6��ڼw��v�1�ʡ^r�� J�m�����?����s�ń-M,?V�B��v��ꪊ�
��ѣ�����p�_���e��#�v�;����@F�&Ƅ�#
���߿���o��<���3'��.[�~�a'#1�Jx#m?�{��m���3��$���#j~�Ϗ>�������]�I3��2W���S��$���#���3���t���[�n��+�{�^�o��\�_~���-�7���K�,���f4�_��ɽ�m��U�h�2�m���W��*�!R�</=zb d��8���.{��ň>���͛7z���:CF�J��^�k='/v��z%,#���/��
�ٻ3�;yذaJ)�W��"q��3Ĺ*��̭���#���O���	��C���V�J�����2W�ेS�e$`�+�����T�rY����r����~F�憆��z�_�~".�}��烈v��ac��Ƞʉ�sq��~���/�k/{l|�E��A�����U)*%B;�Rl|3A?��~����J�X9�B�u���?�} ���K/������	:CF���KAk�9�Bω-$�V7|�p�B[�l��3���{���
�8E�7���m��'�����6n�뉲`a�z����`ʪ)<Ui�^0�!©������>:U���!g�{Nf&>h!.��;w�|��	L�ý7vL:��Q���y\��Ch�7�a�4V.��V��4��ym�-�ؓ����z���'�g����e��"[�3!�	`z�12�>��q�h�w.��	��wE��R������駟�D�f�(B�EQ�)#˲<�B\���A�-C�#\�!fl�]�3�0��X�jcL8��2�=�j��%��n�Cc�B�Y�̳�����ie{�e���@�i�4���~Τ�]U���<�b���	P��3�wl!�֯�v�:`F F���I�4?{�dIM�t��_�%���$������O��cp�vjIFiR$@U�,뒳�d��1S���.��>?���E����ieK�e=I@A���r#���HTeв����R7fJcF����s�+���˜vQV�XVַfΜ)b��o+�ߊ�`t8cƌA���X6p���+W�{���ߪ�fV	�I�k��<��3����V+�t�G�]�|��u�$�5.pq&��|
�1�Դ�2�ǳI@�'��׋��/���Q�� ��L`@���
k� �o�v6���G��x�	��0�	�$6og��xXd�EVE'A ���T<2���C$�3X=��~���%�k�+�|����ڵ{�_�۷�{����r6��3�?�������u�]�&m�E�سg�1}���OMG�a�$@� ���W_
	8K@<>q̛7�ْ�;	�����&�2G�F�B-��
�����Ee���~� �V92	�B�vQ*���H�H�H��'`̚�� V�y�3.�w?K�R���T�6	� 	� 	� 	� 	��A�v	� 	� 	� 	� 	�@��]��-��'    �]�6@~ PSS�Ht��{?T)+�@=f��S�4[H
���<K�W�,�#����Y.	x��~��O0��
�����I�H�j;�s��K����
΢<�4R�_��*�o~�l���myW�#�T����.R��(s�k�;{/v��"e�K�����w��P�2�p�<l����.�{U�t/vQ8G"��Hc8p&>�>����������b�L��tŕ�$A��.�����Z��ʅQ�}߫3�NAU*�G'T��C�l��$���x�+e)�K��"����N��M�g�E�6^��?hYlLFѩ5�*�f��&̡�Q�]־ק���f��c�����Eb��f�/��'��"�����*�(��El!��E�"5�᪪*��������{�r+b�E��]����.�{U�t/�%��@��4
�S	u{�c"m����̚��!=ₘD�/u�(���w���d��)U��Pl��x�'n#���/�d�<�w�{�ƳE��(+��KRՔ]�� HF���\�G ��d����@��.�4
�
hv��,�7�]����(;]F��H3���c�0��".rt�H{�G"�>�m�0Q��/k�T��C�]ċ��V�D��2O���^r2b��������|�� P�@��٫���������ѭ �.
i#!}q'�	]�ss57QnŢ#�7��]DU&}(�"�R��E�]��fQ�.�1�1,���g���>���.��*�����t�	�HL��G��Hq��It����i.���s�"���6/BnNt���dWuԭg�*�(X�B\n!N\�ɪ����K����^��M��<^��?h%k��L�N� �-"͑��[Y{���?-��fEg֥�,r�.:���*�WGT��C�d��$����B��E������W����,�I�gz2�|����]��I�w�&�6�w��cTL���>�r`�
"�6a�.��g�	�u����m�	U��P43aq��8t��tCf/9.�{�Ɋs�w^�n^��?h�qձ��Ε�F�."� �Ţ�YmӪ� �D�i�lG�<J�p��DU&Շ��T���-ĵ��e��
4��#rb��z���e��]���%mL@qD��Q��������NF�*�u��U䘿H��*-�A�T��C�9
�]tY��
��2W�@�HnKc��#������.���꩕��T��^��������r�"��mX�t�m�JoS�(j��JŹ���TM�hH6jS���7�"�.v7�.s�7C��8� �ڕn�S@�G���_'�����Iaڝ4"q=Q�t0�f6ҍ"C8@
�5V�Ks�B�^�Ԧ������i�-��#%���<R����P�2.5�p��.R�j�`jЬ"��Ñ@H�.���@�1�#x�[��m��Am��嵙B]�%e��IO�}�#8L�0^�)('.s�E)4&�rMKb"�vd9����#�Qe�9��qQ�I��@em�Z����<�"���*�W� /�T��
�'���|�,J�0�$^Q_�Z�"!>��T��^ЦպXN��aUV6�p�Nm�̭�'.s�EV[ӑ@t}��V&�`�P�h\�(�
��a�5��8�H��=� Ȇ˜v�C��3D����X[��ϣ�q)
�Mm�m�vǎG��]��o ۴i�nݺ:$@���8c����'���M����摪lJ���桔
(L�\�̽� Ȇ˜vQ��O�f�۝钶 �j2�q5�Z�6a �΁iڴi����۰aDܹs�Q��v�*�KH3k֬ŋw������B��^z��)�"lI�m�RWs&r����p:�lmNse���v�{�A�
�ulٹ~�zs h좳i�&`EWI�q��`ۑ�o����GN5:]�w� �ia�.�S�b�׸�
�����gϞ�����>��oK-�g���XfK���eN�H�vEIH�E���,//7�Ɣ�P(�Yv�_�`h��a���d���s��GR*ss8�摵�[�%���G�+��S��5-[.sE�F���_�~�=k,�����|p�RlNPe�"`��[�P;�+S�izϑ������9��Wz��u�H�.���?A��φ�+�o{����V��R�Ϯ"|���چK�M1p����� ^���ye�߶�;��s�X~	^�+>�w�i܃����k"��������E���kaon��Q�,�;x��%���O�9�rp�y8W�s��y8q�;]w��iN_�K�q�/���c�?�ֽy�����E��{�+��"�pP��2W�@�:���x���5�o|���w�YQSS�%ѝ�@>}�u����[6|�~�o���^V������N	�k�3f`�l5#��>��c�
汥����������8�������o3�]ni�@7�p����u�������B���������ʃ6gΜ�&�<�n��իWc�P|��_�
+C0L8h� H)v�̙U�VaW<1v8i�$!V��}�ݏ?��ĉ_�u������j���F�[��/r�y8��\����q��Y���.`�%`~�;q���E��;�{���W_	w�7��g�}v�#
3�_!��'~���6A�fmJ�ּЛo�S&�6�@5�G�0K�5!m��Ͼ�cX�\�?�Th�K۳�J��Ǒy3���摉<�2$��enl������6dȐ�@�Xw�H�-=�����W1:�a5�;����z�\_�^#�Y�H���5�0Ţ�e˖�۷oΜ9K�,�$+[�m�&?7��}'��tp����.U�b�9f��LRO5���۫���q!e/v������͛���[o}�嗥_�v5ƣs�a�3e/s�d�e�`�bD��H}QBHN����J��IMѯs�O����&t�� 7�a*�(c��јJ�q�K/��`�¶R�R.&�X���(�ƞ��`�P6+���<M���9�"O�I
����5+V�,V�\)<��IM:�.nsOe�9�z|�!�5RSH���
cZ��N��2P��iDL��������]+4Â�<2��I@}>��i���(!	�H��:c�&�a&���u���mW-�z��n�T���Y!@mZ��a8�`'c�L��0+�Og�p8�#�	��2�]�~�a�$`?���s�{�챿rl�&CMd�,%�6]�ީS'Jq�6'�2OP��.s�EJ�(
C��ȱ�5��E�j��3ψ���M�j��j��$@-�7X\�|������^̛Uv�,UJ$@�"@��[���$�
1�N�$@�!�۾�K�}�:�"����Y֋H�K��ê0�qG�	�]�z��K5��$@$@{����R�j�詴�U�"�*��q�?�4�ʒ 	�@\�u��a���"Y�Y.	� 	�!�#FTn1��$�" �6���*BPf[��֗v�\�,�H����e˖����Y�f�	� 	�@V��6q�<��N��e�,�H���kFfP��y� 	� 	dn�C�8�F5��|�JV�H���S��a!3"/q�������$@$@�����^�L���X*�2MK�(S�<�H�2'�U���9�`��	FaΜ*s  �0��� ��D��xK`�E���%    �� �"��2G     o�]�-}QZ     �	�.��)s$    ��E���%��jkk��������w	P��՝��y� �E��tx��g:>��TG0��Y�"�Я�	������۞}���e%���I�ԻK_���^�%%����A�R}�����G�2�4?7��rrs �LY���L��tG_�*��6US%�۫M�4�h>l����<��ׂ̭)�����9t�Β?{�aO�Qn�� �.s���R:�"+���4��uϾ��"hF��m��V��C�l��&_7�u~N^��v�*�TS�hKviSz��"������"+-�il$��e�:6�һ�X�ʆ� ����O�:�{hc8��/�ٲ+�"�H8�,'�?���o����~cRv�أ�H�0C7��_R4�G�Vp�i����"����*��6�ih������A���F��c	({�CИ+�m�oK�_�=hIji,փ�=4	�#��P�18
�i���P�{Y�������*1-������Y��\L��	���s��rZ��(�>�G��6�R�ڔ�2�������A��z�dJ[({��v��W�Z%�YQQ��+m�rz���LOOw΢]�g���=o�a�95�°���a�(�O��c��$O�Ve��
��n��s�i��x����Ԧ
�tN���ԋT�b�k�]�z;�P�2G�T��z�g�6�O�]�0`f�#�&�{���Fax�` �f�c"m����̚��!=ₘD�/u�(��Nt���d-�)m&+W���<�������e���=�	�2O�~�/�d%���v�|P���A��L�0l��fi�"|��E��VY.#�$uG��3��E��(j�����"�g����r��Dm&n-�iSn+�X:����������>>�Dڦ��R��,5 ���H�?e�u����ƺ����⻥���](�Bw��?��P8���!]xMJNR��lA&��"G�23���g2�3w&��s�~�sh&s�s����_z�<�^�'��bw�Z0s��\�#��H�>���������Y��E��Q��"o'��b�ɩt���0Q~X�U�'�:�E�f��_LN���7�9V{�	�n��R����� /�b�:6
�V0�
_�|ʏn��Wk~�$��(+Ϛ�`^�g����Z����$k�<m�����}R@�`�*ҍ/b��z�9a� ��y�T�����-���ݦI�+?w(Iԥ�4�p򋡐gyQ����c�1��1Ξ�ώ8a��0`5tv=#]��;a�����&@^�[�P���$�D?��y��u���]7�t���h�kk��WL�p�H�9�Q���r��`��2F�L���8a�� f4v�"��`'̃e��ȋ��*��<�ɋ~��q^Ո��#<�wkkkCC��򡪪j̘1�Vi뮶��>���c%)J�F�^��	���ؽk�E�v;a�@���#��L},�	i�Ia�	S��뉺�t�ر�=�����yR��� �b���2����B�Eft�3���t�"�]���: �@�ȋz��ց0�"9���CQ�N�e�Z��Q�Ţ���`f�fnĂ�?4
�]u�f��������N���h�ƍI�~��577_{��=Hwvv���x�;b���L.��r�ȣe�����t3/"�]?:�!�-@^d�(�B��]��D:I�$ϑ����'ǋ/^�s�N�����M�6x�`5�$�,Z����vȐ!�>����jժ�G.t��J�&r��]�.�M��+�U��|� .����|/p�ɤn��9sF�g����̙��Դm۶5k�$)�O��l�2y��/<������2�t��	Pz�G����k��5ɶ�,ÇW��Ë���.����p
D7�Ht�k�6�s�[�x��ӺՍ� ������� �
�9�K� p����|����l:z�\'@ ��{w.MC �ȋr�OiQ�	�?����;w�\o&�0���{YHo*��}���������?|�ԅޗF	�Z@�-���<q���Ħ&�ݭ/v_�T�`
���i5n��8�즃��� �M��t�����¼dɒ�7�Z͌�E�gL� �� y��@-�&вc�[[�N��PGk]kk�;����SY�ϟ/{�q�����CZ��\է��qMM��4�U�ٳg���ܹ:���~)8���ݝo|p��O;��J佣g��)%#���s�~�M7��������������vϞ=*�U����M�5�����ݢ���ɒUQ6.���� ��y�T��
�IH2$��Ej�����z�f�IlR|Ŋ�*�%�����!ue�ɢ�W�ʚ6;���: � y�����m���9s�W^)%�|����퓓�A��񟎎��7�˖-;p���a�
�+��ų,�
G ��ȋ8B���L�y���U]���+'L�/���;-Z4k�,���,r1w�Uɕ�j��=���|Y��W8�U��/
,^���Fn%l���/��;5��y��_���/ue5���қ`Wa�G���U�.'@^�q�@6�'O.-
���+�#g7���;�ΆR��g�@y�\�?�c��C�,w�-�1����a�]G����'��^�!̳�
�B ��
0^�[A�G �#n,��;J�7{���W�3]Ƣ�!�C�݇�F�@ D^�A�@
������+^
��h�Ҭ�	�����`�O������\�%�����Z@�y�"���	�=Zͨ��T.$�E�E�c;�`�R yJ	y;�*��9��R$�ݻw�I5rc:�n�%gKA:hk����L�|��Ok@ 'ȋ�ԥl@ @ �� y�z�:"�  �  ����EN�R6 �  � �A����D@ @ @�I�"'u)@ @ � @^�^���hmm�;ѩE~N�:�#��/�t_v�F ����O�J5�X���'��/Fcu-�W��}ʘ���%�,ڲau$�������?�/{X�7�?V۸��ɣ�N�(�����<��T2�-���=Z�`���b���6�u�t9$�
�^�����B/���	5Z��^�Ez���Y�S�J�V���&�|�ᶶKyQ��%��n�����+
���y�T m�]�H��;yQ(�"��3�EθRj.
��*u������Gc�h<��c�`���	���֥�����=]K��!����,+=�2X��H�/�ǘR��6ص�t��N^��q�@ � y�VԩR,����xg,t!���(?G��Z���y����^�ZYYy×o�{�'���¡>����}���KRd�U�g]��ꑀ���U�K����E��.	�q4 `U y�$?�x��C��(&yQL�%ɛ�#�����r��>f^������+?�G�E=2��l�=m����Ei�Y� /rZ��sG@ݤ�/
ɭ��(&#E� �[#/�t������K$��̚3�!�j���̋2���]�7�O�=]����E��� /r��䌀q�6B�H�b�����,�ߘy�4�+
搑9Pd$Fj�HƇ$)��B(�̋�1�x<�k�ȋr&������r"�ɋ��� /��Υi6�S%Iz�,�ȋ�ƿ�yq��w���|c�(?,���̳)�"�L��_�`�bjo��Y1gpT���Q^
�5��]�d�HeGjZ��U��o�9�N�ub,�2�8�2"y��Ë�PƋr-����=]/���E��� /r���@��j��̈�����t�C&�]�U�?�6�F:��Y��`yQp�&O[N`�A  5�IDAT���9�ɋҁ�98.@^�81;�1��ْ����$���G9��L����ȼ#w�6��,fЩ�3^�i/��-{ό�;y�--� �@oȋz�ǶH̕K�}�"9?�t/���|��
ļ���w����x��B^�� @��E�+�ɋ�R�8- O�gA ��̳}�:"c	ō۬%�o�]��2YTj��A�2k#�� �����ÁJ@��"[)$p*%2�#Y8��`��Q�7���D�5 �-t�n�U@@{�"���
j,`�0���uy�>� �{�=�_9���9
�9�Kٹ(`�''�������k��캑�=ohGk][ۥ���b���ER��я���S��ǈ�1�f�e7pD^���
h�E���N^�(��h%@^�UwP�W��H^�u��F̭�y�[[[ԕUUUcƌ�J[w������i��+IQ"5��2�"o{3�{�0�u�t96�
v��
3N��^OԽ�cǎ}��7ϓ�d�)3���1dd�"-2+ ������g���:��z'@^�;?����ɹ},�jv�/�ԢO��Rg,���3�4s#�!�i�k�ҟ�?jj� =
ht
EO!��@���j"��h^aϫ��ͤ(ae1d�y�P��O�B�g*�� �� y���B�4��Ң��$_!�Wb�����d��� �n�?v�R�� �i�9TM;s�üV&q��v5ԫBb�H���Ȥ3nq�W-�
 �@/ȋz	����dR/��%A�<GF��ϟ�/Z�x�Ν;�'<8mڴ����%YgѢE���C�y��ge�U�V%?r���'�uAe�PWW��N������H=�� B ����i�'���\J�Μ9#���3mmms��ijjڶmۚ5k�
SK���߿�СC[�l�0a��N�Dmڴ)u�����x��Q�H$�*�!�.@��NJ� �@F�Eq�2:
ȸ�ԩS�.]:{�lS���P�E3gΔ��%F2R��=k�,5^$��#��� �!@�sh � �
�9�K��$p�]w�^�Z&��ؑ*..>z�hAA��A���������Ǘ�����n
0^d�&e!�  �  ��ȋ��k�@ @ � /�S��@ #���?<��&�� ~ ���k���	���i/Z;u�?��>����<xZ�
Q	pF�`wƕR@�~�"�M)�Ο?_^^�n%7q�D���q�?n��\(P����COվ�������rv����C������OVQ�'���E�jw�}��s�.�����An�����p�I�]�#��!���ȋ8.��@򙏒u{`�?
�{���|�����)���_�M=pT`���o�����CR��������g�Gy�Qss�dSm������� 	�9K�9.���޺n�5�;Z�Z[[�j���Y�#�W�O?�tmm�TF~��o~S~P�2R��/kjjd�)��i'j�k׮���·onzw��5GN�W�%u���؉=R&�	��خ��Ȯ_;�W]u�c�=V__/Mhii���n�A5G"Z��u�Ξ=+�1����pN�����eG�Q%��p��`wB�2@�+�"��ٯ��$&����+�����s�Μ93d�9�ikk���V|%%%����N���u�������_�R~��/ȳ\�̩��I>�EΨ�K�n۶m͚5��w���6n���+Խ{�u�z~9Z[
G�g���,!���Iu^{�5)�׿�����ߩ�w��!���wΜ9���L~��7n�(+t�7�xC���!5���/�3�lv��m?�(2 /�T��P����������R��u#'L�,�亱c��߿_Ί�l�RYY��ё��xٲe6lXaa��]�	�N_�a��1*+������w{�R�K_���ӧ_�����w2���"�|�-�$��ޛo�y߾}��n�,�T����G���/@$q���{W�g��g�D� X��v=
�ߌ�?a����hls��r����F�#&W<��k׮M~��Iݶ�FV��<{ҨyS���u�䅵��{�L(N��g�@y�\�^������jS�<i;
���Ii�*�~�z��֭[��SMd���Q�y��\�
;C W�����ϕ]�@ X�E��oZ���HD�aÆg�y&W�H�@@��hhh����@�v�"�I)�v�ءf���թ�.Z�H�F�Tv��	\x�'d�ؕ]�@ p�E��r�K�ǏW��,Y"WI�^|�E�I�r���d�Hf̪/>d��K�8$@ {ȋ���4�(++�4�7ސ��I��rF@�ʪo=d� ߽{w�4�� � :�����,����rɁ,���Q�F��G?ʲP6C @ �'@^�>��9$ _�/���$#S�r��4>!�` `� y����  �  � > /�Y�Q]@ @ �]���vR
D @ @ �	���è. �  � �.@^d;)"�  �  ���ȋ|�aT��
�ڵk��<��s���(!�@N
�9٭4
4��qM�B5�\���'��/Fcu-�W��}ʘ���%��|ˆՑH"����S��=�՛��m�{��Qs�T��W^~��I*�q�xqO4���TS�a��up�
���y�T m�]�H��;yQ(�"��3�EθRj.
��*u������Gc�h<��c�`���	əw6��E�#fd<(cO�����pHf���#ˊG����1R#Ƌ�1���
�@�@ @ @���c @ @ �.@^�#��#�  �  �@8��� ��<����R����I�&��E����'�>��h,��z�����z#�m�k�iK�?�n��/P�|ΰ�t�"� Y�eMǆA�����c'C�K)?���5?�D�q���g�}0/ϳ���w-�E�?�_��^�6��}<��O
��ZE��ELT���C �ȋ<�*�?����}K�nӤ���;�$�RZj8��Pȳ�(ir��1�#_&�gO�gG�E�f��n��g�ˁ��`'/
`|�dt /ҭG����y�q��ܼo��[ʮY:��Jw�ֵ�]ʋ�+�y8^$����i�a9UZ0}�h#i&ZvG�E�`������[����E��2Z��V�EZu��yE���E?X�8�j����׻�����A]�PUU5f�o��uWۊ
l��p��~��>������Ƥ0�)���D�k:v���{�qs�<)JVN�b1��xCF�m!�"�:��zF��]���QK@�w�E��c��	Y����⡨f��2qN-��(u�b�X\~03I37bA�����.�I��㠦� У�F�P��t}�&�����z�X�L�VƠCF��
� @�[@��*{�b�� 
�i�)TIs��� -J�O��z%Ɗ,JK�
z	�V��`�*�z �� y�ƝCմ0;�ke�8_���ϗ��_m.'N<w�\r��Ѹq�?�|-�܃X%�"312�[�gY�!�����^���� *E"����En���P7pm]���8p��)ɋ6nܘ�ׯ_ss��^�igggMM�W��q!�9���r
��~���ϽG�@� /�@@ �ft.%F�yt*6lXaaaj��E���?t�Ж-[&L� ��$QEEE�6mJ]���#9^$yT$ɦ�n#g��UEL���յp3صit6!سQc�I��H�ޠ.d% �BS�N]�t��ٳeL���B�͜9SʓK�d�H<k�,5^$��#e�76B @ rP��(;�&P஻�Z�z�L���#5(T\\|��т��A�UUU��E�Ǐ/--U���\�G����tpᮒ������͒�p_���}s��@�n:WRR��+�\y�RD�G���M�n��V��={d8H��<:9C����/o��"�D��>��3��"�@/\���|'r��1��W_}�����z����Y���l� �R��ȗ�F�@ |*��]%�[�U��SO�ޚ2������7�x�\���fe�ɧ�T�.@^d݊5@ �F���J�
�'�����Ł
���Y�E���4��W�e������|͡��:�v���?]Z��=$EN��z����_
·onzw��F6GN�W�%u����z9���.�M�^�ݺk"������G�P�ԯ�����F"����Ґ�τ�a�**�E�>��ڵk�c���r���I>z�������W2���L��D�'�l%k��jC�����j���8
�E] � �E�k�
$�����m%�9q�D�>}v�ܹcǎ��6�xZ2�ԇ9J%Y�z�����[ZZ�\x�hR��&�ܘ�����Bϯ�پNe�V���@�G���$ER�}8-� C ���=;F��@r]uu�l%�b�E���C��[���-��"?�o�j���P^�"�.��I�#M
��ז5��z�gd�H�!��%#E�\�7ߖ�P8$��`��+�Hs��C5�X@@�G�a��U�ԩ5ol�V__�����ȳA����z��G��V'��d�܅V�\)�@�{yԽL�S����ۧ~��٭��+bu�� �ƛ�m|�xK��e��Y��d[�g=��
v���^1��{UgO ���/�@ �����QS�6��ű3M�T�����t�����v[4�A���Rɋ�푟�7j�H�M'��ij����{�3G��Uzh��]���2/�-�X��`�lke��
dYdҬ�#Sj�[o�w"�=>:�=�*@^d+'�!��@III{{��LH�,�t����w��[o�U�ϭ[�N>=z�����O�0���Yݤ������P�;�9x�
UB ��ȋ8B@�m�	7]��z��o/���>n��!�O�ٳgˬ�����<5�4I��:�uC �n�E ���ܷꎑEK�zk� v�.�����e��SO=5z��Ժ�$[͛B�k�AT��E ����z�ˍ<�g�>����_��W~�ӟ����E�V�����5D �"�rA@ͱ�E=��rI y��Q�F��G?��L>��3*����J��Rci �� y�W���䜩��L�ؼ��[���wm+��@@������,�^�r��z+?�QGj� �^����]HH
�����MX@ @ ��Y�bM4���b5�&�hZK��  � h,@^�q�P5,$���\l`��@ @ �� y��#�����Cs�=�@ pK���-i���c;v�P����?�Cr��~(@ �Y��Z�?��G�{��ച�"�  � 6
�وIQ �  �  �K�"_v�F @ @ ȋlĤ(@ @ � y�/��J#�  �  ����E6bR �  � �R��ȗ�F��&����\�"?� 9)@��d��(�D ��5�
�@@s3V�p4��յ�_���)cʪF�x^�-VG"�X.-
U�T�S�J�V���&u�|�ᶶKyQ��%��n�����+
���y�T m�]�HY��=�NbU@�n�"�E)/wRO�:c������wۣ�X4���1c0��ϋ���w�Rǋ
G��xPƞ��������
���e@�9�"�l)9��MJ���z�L�b2R$	��5�K�1���/�
搑9Pd$Fj�HƇ$)��B(�̋�1�x<�k�ȋr,��o��s9���rX��(�;���,�N�$�1� #/��ƣ��EL�Sܩ�k��a������C0Ϧȋl>0)�~�݊��ne��� 8$@^�,��@�.U2^��#5�Nު����7��D�z<1duM�S�����ER(�E�Nz��`O�?�{���9 � y����{��"�"3#2��n�-�t^d�_�g���H�3�,"/ʽ8�E��tݤ.1�9����@ ȋĥ�H�-�y��NYM�K\}����ި�D���aP?g1�N��"���i� ��3��nc�Q �� yQ�b���1<���͹sF����{�!d�qN��4�K�h��j!/ʊ��l ��"��iw�
 ��s��9gKɹ,����̎�vf{ʟ�H&�yUQ�uG�5��(;7��E�`����#�!�-�U@ ��*�r�i���!)ꡛ�\�5���E9}��8�	�:�`���* �� y��]D50O���
𺼀JY� �������� � y�  �  � ]��(�G �G @ @ �"�@ @ � yQЏ ڏ  �  � �E �  �  t��@ @ ȋ8@ @ @ ��EA?h? �  � ���8
 �K��h۶m��������&M�e�z���Ot}bݾN_8�`��a��% �  � � /�@ K�O�m?v2��yʏY���f�Z�H$�Gii�y����l48�]Kqр�����̑ȋ�>0�@ ,
�Y�b5.	��C��-���ݦ�K����E
y�%M�>�cB�p�H��ώȋ49̨ � 9,@^�ÝK�0�"�D?��y��u���]7�t�#{ʤ�#�~��WL�p�H*9�Q��Ò-�>F���4-��#�L��E @ �lȋ�Qc� �W��H^�u��F̭�9Hkkk��Ecǎ��J[w������i��+IQ"5���j�!y�����@ ���3m��LsF�,2&��Q<�s|g,$z�k�<)J6Q�b1��xCF�7zq��T@ � yQ���:pFV$���x(�)~����X,��f&i�F, �  ��~�E��	5�U�k�HM�3]k�K�b���%��A#��t��  � � /�@ S��� -J'�D�+b�(-+ �  ��G�E��[_
���2�f�o������˯6��'�;w.�O�hܸqǏw�Y�A�I���t�-γ,��@ @ �ȋ����P7pm]���8p��)ɋ6nܘt�ׯ_ss��^ۃtgggMM�W��q!�9���r
5^4s�Lٛ\b$#Ej��f�R�E��8�u�H@ @���E��6*�@7���k���2�NƎԠPqq�ѣG


���ц��  � X`��"�!�  �  �@�
��l��0@ @ �(@^d��@�~���x�G��\JD @ 2 /���@�&�m�����~ӁS6�G1 �  �@��E�۱%d'�֡3�g��o�8v�Bv%� �  `� y������=�ϟ///W�Ԗ[l�\��<nܸ�Ǐ۳o'K�?�O.��~���N@ @ ��ȋ2�bm\�';v������{�y乮����H"��Ŏ�p���ߡE�D�;�q��	 �  � y�����-;���e��ku�ֵ����΃���� ����Փ[e��e�j��7���ZA~��s�̑&N�x��9�v����M�E%K������_
·onzw���w�n:���-m����!�  � v	��%I9�hhhhk�W}}��G޵k���_�u��t�Mj,���i۶m2�N~8e.Ç߹sg�^� CL��ν��{�ĉ���={����������\���%���}��I-��^����~��<���׽{B�����ǝ�T�B@ @ �� /��@@S5�N����Ru�Ѱa�
;::��E˖-�D"�TUUI%�����^YY)?:T>���T�GEEE�6m��Ȱ�,�%�^>#R;����N_���r��|�^9�Q�  �@�8�t��x_�|����9k�,5^$Kuuu�V���TTT��3g�]�������+�(H���+f�ho�(
�q0 ����ɓKKC�%#3�p8�Rz�Fͣ�A���Ǐ?�xr�������XHF��̂��'5�T\\|��Q۫ڭ�n8ߝ=���7��+.��#��������k���W;]s�G @ ��
���."��4<���d.�',Ӻ.Fcu-�W��}^Ո��#r��Y�n뮶��<j��������3u�~���l(%��g�@ye�6A @ l`��FL�B ��Ɩxzf�w�g٭%���aC@ �Z��(k:6D �ln���'�}iI��i�E2��Ml�  � �-@^d�(�!�������W�W��;��:� �  � �
�9�K� Ѓ�ܪ��� B @ < /��  �  � x,@^�q�{z#�c�u��'�|R�3{�l���7%�- �  (�@u7��5�%K����nݺ������/++��uuu�7�k��= �  ��c�E��R0��_�>u'�����{��F���D��?{@ @ rD��(G:�fY@��M�2���45��� ��v@ @ #򢌸X�d��L�{��Ռ�"���
!�  ����EwUC ����}�ݻw�V+N�<������F��m�� �  � 	�"|, #E2.�n@'7]x������3�/_��Qu@ @�]�"w���
�H���,�I�����F���@ @ �\ /��ޥm �  �  `E��Ȋ� �  �  �@.��r��6@ @ �"@^dE�u@ @ @ �ȋr�wi[pv��%7��Ed������R@ @��p<�� 
A ��X���X�b4Vײ��ۧ�)�]�y۷lX�$b��,<����p��Z�����ƽ�L5wJEA~�|���I����V�Cv�  � �
���7�L7�O�E�V���&��|͡��D]��
�i顁�z(m	����mS����xlɖY�l`)Y�Z�����J�4��WN�㘦�z�� �4�i�q�K-p����3Gܹ����ᎈQ���O��8�ӝr���Kt�R�7�,�BVYT<�~R�U*�rq�&����f.��������YC@�A�
N���s�0pIǑ����ȅ��8��w/��FDl����oa�0'5eǢ���u=��]�W "6q��1h,�) 9Ӝ���z�^�[`5P^���7�������7�]/�xʋ�~8�W1�@yѳĤY�]�@y���oV�}�i�(&8�l�+^���]BƔ\��۞;l�������>��Z�S6� �\(p
�|��0�8<b��(�o
S�es�VV���qUIE� �Y�M�h�� 0<�c��� o^����sp����_N?>}����L#����_���S����^?�ʎ�:���>���/�@�_}���^}���?<����t�!N7�1�M91� h����a�n�M#S��X��sH��Cf�2)6���}��A�f[���� �SJz�Y�t=K��,�샳���
     word/settings.xml�V[o�6~��`�y�%�r�N�K���סr %R6�@Rv�a�}��9�Wd+�d�|������'�z�
��nQ�[�@� ��a��#�JKt�P	�K)��,�a���K �������)oF,���1�H�>f��oo�3�ѡ����IqM1ٺ~�������W2�cm,�~~ ��%@���	nx{RdM���M?)���5�jC���^``�OF��h@�Y������� ����i{�p�,�
ÿ��   �� PK     ! [m��	  �     word/webSettings.xml���J1��;,���Y�-�T���>@�ζ�L&̤���k�H/��I23���;��
u]�pK~��ʮ�2D)�:d���S��x��<��>�=t!�����3	ue���'�Q�>�w'�������@�ܯ�[D�@'�3S̀r	>`N|�����v1R��p�����  �� PK     ! �Ty�h  �   docProps/core.xml �(�                                                                                                                                                                                                                                                                 ��QO�0��M������X2͞\b�Ʒ��mu�m�n�o��$�ɷ{{�{��6��J�X�d��I��T1.�9z[/�{XG$#BI�Q
�ѩ�y)�3=�TĹ*Ԣ|�7��E����/�[�1p�����}�r6�z�uO"
�H-����r]L��8�~r��ڈ%��s^V�gDB�t�<�Y�)'6�T�QV�s���b�d,�%�÷&�$�̈́���ҘDL�Ź�5����gQ�+�.+)9�+����Ō/
��͢�U��86g�:�<�f<�E~
�N~�`_�}��?�ٳc��mos���v=(s�Y���}��𛺮��)+x��9~⪕e��88����18��2�7������ɏ���t��{\���l�C���d�� ?b�r��@"�F�R�#PF�AF��Q!mT�@.�pF��8����BJ�Q!mT�@"�F��Q!m����7<Ȩ��6*D��
h������x�Qa|�Q!%Ĩ��6*D��
h�Bڨ�6*D��
�
)h�Bڨ�6j}�a�Qa<Ψ0>Ĩ�bTHA"�F��Q!mT�@"PF�AF��Q!mT�@՞,aT�3*�1*��R�F��Q!mT�@"�F��QAx�Q!mT�@"��gs��w����{���SWM�n�[�]��pԺW~��{.�z�:o<<���0��K��!j�iu�k/�@���v���K��Kͽ��)�
��¤��2�Ԑ���R��!{1�RCT��&5\�a���Ԑ�����p�!*Xj�
�T�h�!+5$`��� �&\j�
�����GQZR�v�q�0'�Cvq��	�����j�!VKP���j��O���0TF?���֏B+�G�I�����7����W-y��UK�R㪥^�qՒ_j\��%5�Z�:<9�	AR㪥^�q�R�Ըj�/5�Z�W-uI������C�b¥�UK�R�%�Ըj�Kj\��%5�Z�W-y��UK�R㪥^�qՒ_j\��%5�Z�W-uI����R㪥^�q�R�Ԟji�� &ö$�_.�V���s�LR�is�~�:�<(���D�#���m���u�66/u[q��I���_A���c�yÞ�J�����͐nO���k����wi����V��1�U�u�m3
/`�ݙ�e��0�x׿ߜ��NIㆎᶗS�i�Zv��B�u���]
)�f���y�����Ad�_i��_1�^���7��tZ�B��`����oN����{Λ����͋�S�̃�2�������4���O�����<m��"���[�2{k�}p^��q�XK�>Ϟ�ws7$�ˎw�`�V�9��I�nbjg�~yy�����Ż�  �� PK     ! ��?�  �     word/fontTable.xml��ۊ�0��}���e'كYg٦(�^��(�l��`4Jܼ}G�㶄�	�� �f>�~����� =(g+��%�
�S������=%��q����Q}Z��ؗ���[(��hBWf�V3�I���y���&3��w7��UZ�cV0vKG�����Z	�щ��6���K�Dg�U�h�%���]睐 �f����N�|q2Jx�3|��QBay����_��u�bQ~j��|��|� ��F�I_Zn0��Zm�J��[2�؁늲�m���-�<�4����d��l�kn�>�T���T�I?p�bSCT��=lYE_�b����Wt���zR�xWZ���'�EE$ΐ�D�L9xg68p�ī2�ٓ��p��#�E'��Gtf~�#>q�u�x�ݑ5*w����#wd�\��8�j���Ĺ�_�[FC�����}8�#��'d<��'   �� PK     ! �=��  �   docProps/app.xml �(�                                                                                                                                                                                                                                                                 �SAn�0���c�A[��pP��6�$�
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
�*�8�i�����Ĕ�ĥI6y�{5��7F'+Q9��A�g	X�re������YQ�\hg!c[�l<��N�bBj3�@��G� #b�<X�.�ts��s�����"X�a�`��b�1y���:I Y�X7�^�k%R��l�˥�sHIY�ą��ou(+�
s̒:��O[%�����Q�{�O��q$����r#吷x�jǎ�  �� PK     ! ���   N   _rels/.rels �(�                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 ���j�0@���ѽQ���N/c���[IL��j���<��]�aG��ӓ�zs�Fu��]��U
f?��3-���޲]�Tꓸ2�j)�,l0/%��b�
���z���ŉ�,	�	�/�|f\Z���?6�!Y�_�o�]A�  �� PK     ! ߵL�
  �   word/_rels/document.xml.rels �(�                                                                                                                                                                                                                                                                 ��MK�0���!�ݦ]u�t/"�U+xͦ�l���U��
��ťx�q�0������v���)Ȓ:����
ފ��ڕ��H�ί�V/�i�KԴ=�Hq��a��$ӠՔ�]<�|���j�k�k��4]�0f@~��RAؔ� �����}U����Yt|�B2ǛQd�P#+8$Id�����U����y�>���숽}�mG�$9��e�ٔ�rN��x2ُ������w\�m7�8FSwsJ|������y���   �� PK     ! 3��L  ��    word/document.xml�}i��J�����?��J���������/��6���;�0;����r���N/g4���HUfɌ����|2�L���S�T:i���П��''�b;���ԍ���)ˍ�6�8r>~h������������*NN�?�$��J���<O� �|�dd�+��������n`9@�6 �؟%il9Y֖�Qid��N_R�'j�qz2��2�����䏖zb��A޴�A��L��C�F�W��<]^r��R�J�/H���!�2?H>U�G���"��U�<�/�B�Yp�Q�?�~������=E���H�r|��|��dѧ�H4w��# N ��Y�i\$�����8:�hu�����|_��1��������<��85̰�m��V�O�Z�W�q��n���zn=����AA���-�q�"�� ��Y�0�\��x�vOH�phx�L��(^�q��������/o3�F���0���l���m':̝42r�����Z�M֏�V~Z9�"H�V'Z����4y6"ˏ�';��M�͇������nB�z��t��$t�q֧�m�HN���p['�������Dv�Oۼ���::v�'4�����֨ft5[��_h$��N׮��<(��@�����mbH\`�n�󍯧�/���w�L��8�>A��+�q�'XqX��!{�fẙ��#Q�Z)��|�輢���jb�����9a�`�o	o�N�5����q���Xmu�BA�R��:V�iþʝµM�JǠ���ڣU�k��ej�����)h�H}x��Sk�k{��ɭy)v�,!m/������,��.�������HqFn<�?t��[���+/N�*$�罻�
^�Ժ��*�9�:ί����K�l:���~��&�u���ݙN�A��Zc˞�����s�4�+�1�K�;�OY:YGĬ��n�1�<�	}&"�q#��!�
Zw����D�s';>������芼
��� ɼ6���v�7��Yoъi�|��x�dyw�'2tYbX�Ʒ������=����jKu�k_q���k�Pw�w;ݝ��O��/�`��s/�^�WI�g"i�7��v$�I�w\ZNӮK�΅���&G�
�P�����6�s�v�oa����W�8���ð}�F~n�^��X6�e����=6I�?,�׷l��lV�������g�B	0�b�c��v���~b��N5���P��g��Ob�D���������7�k��[��Ͼ�Ѿ)����<����o��oو��7���_pk��	�?��_ּ��Լ�8>vS�ֹ�v�>:����1f�8PzI۶�-e��Z��V���s��2�':�^�=��/�$ȟ���[!��Ͼ��L������g��&���1���4X�5]g��h�``On$ҋxcV���M�_l�!��gg���,��6�]Y��6��w��5#dٷ��jaOy�t.���5���M����'_�Ͷrn�V�u����R�m���Cs�m�k�^��D���|�їܪ�-�)���-y}+yH�"��ޟ��E��V�n�3�W����W�{%�(��ÿ�db�c�`���݇���Jv�*�ݣ���i��z.��m�`n���׶���_wi/�.��d/Jv{�����?���ë�ȉ {�?i�P���4�U������v{������7��{�����$
�|���G���+�����J��?U��P�����x_���R/��@��{]k=�.�����0u�_��~��o���u��]f}΂��r��WC����W���+�;��v��o\�_��&��b�/�E�^�&����k@��O�W���~��`��iX�u���j	�m}����;�H;�{Y���������S��� ƻ��n��˺�g�l��ȝ����:n����X��������$�[U'�g��$�+���3�Av/����t�eaCѿNY�G���=T�'C���fǩ�A{�����Dx]}����î��[ۭ:|����0
�x��n�����%X^{����������ҌVa��n������,�ss�^)*��#�����(�`U�X��8��^��Sp
�蒑��TM@��p_��j�p;��E�����s���PX���c�7Y�"֨K�+ۄ1I�t�������L���Xk���aX6�u��B(W8��	�*}��(F�J�(�@&0�bF�9�ExL��rIc(ZY�!T8�ҀrĔ`�l�+����1�P�,���"�UV�{r�	���ff5�<�����{��&��6&�*�CM�iT��]uJ*������q�����Plz�yr�����M�6��hF[i3���pD)P
�E\@�D��х�rd{�٠&�hU��r�{�F�����w��t�saqH��h4�r|v�G@a7��
Qf|>B�_p�ָ�H��Jf�k����~A�n4���}.Ԗ�Њ�r8��&��Q-7����F�=��IyJc��(�ڝC��'�����G&��F���1S�ca[����l`JI�^��PڸۼY���b��fc/�|s�$8м��d�U
�QǨ:�%�k� ��P���/tK3Y=o���,���]����zH�3O+"/5��*��8Y*�9�A�i�xQ�N�N(pj�,��"sN�K��p��Y�1W������#���l{�"�.+�9k�3��0.p�Qrj��qQ��b�锢��ֹDSbtt�U\l�:�-ře�&���p�V&��3px??���t(`h>M�e����*Cg3?�j5)V[u�*4���z5�Ɨ=c�4u e�'X�gd*�}��ͩj���0����8P<����
S�Ɯ�V*Y'd�L�Ixb�O/g��<r���4�`,xH̀ʴ�5�x��#��j��8��vb1��K?ˌ�z��]��f��4n�FN���� -{�P����C;��2و A� iav �z
̖͑�!)'4��[���DgnR-�Adh�q�g����3�q�%'��$��km��\��l�{�W8>+c (����%ǛP�L`�-�&MX������4f���v�h
�$���5����t��������R�yinY��F�V-r~�F
=�u���M���7M�P���XE�lY�6K�
�T��
�YS�qt:Tf�T��516/A-�����!-03�R�^^���	�ӣD���J���L\5VCM�.����0�,�d�t7p��괴��/��Z\偕l�"�/<1ɤ�̂b�^��
@Tl"�bd��l��U���K��i�F˵,��D�K�a<)�Z>��j��)Z�~^���RgKg˲;q����B5=7�#T�\m��.��{��֖�&R�c�k��J�f��K9�S�ՙZF��,�!#)�-#��Z�#}�/�	�����`ˊ/���n⣦�w�X?)AV�-������3A\� [�W���Z��tk�Am��-&�QwUx�f�5�8��k�&��0p�0K�^v���ʺ�ٙB����],A���B�Z��Z��Qv��q�)��'8fa�ݍ�Z0��f����:��v_bǁ��۴������vV�]�6�5��^8"�
#�$4¸�I~(1�=\N�h� y!�y������
1[v��U�␲%LsPwx�,?��]/eƏ���.	߶cٝ�_�˻����������M��`��y ��y �;A
�/����<����s��Iʔo/w�p
(�'�F���r(��|�[[Ju��58
&S���)E��5�B�
�bD)�������!��:��G�#?U�d�G��4�ɸ�7̩���ʧ��rJА6���H\N�@���(Ʋ4�m�2��v��F���3��
`[~3��c f�e�M�?`[�.���b�������� f�K��c�ٯ"��M]ߘڭ+���L�S��<P��<P��P��M9��TӿS���JA�Z�4|1�I�=޿SB6�ֵ$E�w����P�q�j�>���'T�u�L��e�	հH�N�[QͮE5�hln�nQM��
����3���:���CwT�Æ�c���� ��eH��/�~ԏWJ���/��6wX����>*�l3���H�o��o���~�>�ʌ��K�ْ"[
&A٥5G3y��P
-�#�*�G�72� �Ǡw%)Y!��XQ�[�Ǽ�cƑT�������%���1�?�1��E8�c8�c���Y��d�ߎc�E���̀
OwG���3ā��hZ.�c ��N�%H�P%���E������IS��תH�tڠ�4C��9�%���d?�t��1��܄Ì\8$��J�)��L)�*d�`���X%BL�H�a^0o�CA�� �6�D=�*4���L���,5�	�fXcK�ܡ	��9��� �~������Y�H ���jl�ңM�-ܽ��

z�_�_���Ta���(��1����~�޴��Ǭ[%P�^�/�����\2{����P:���GO�ܸ���mz�}{%Ջ~�R�W�Z��(�/P�|m2��gc�2߯M�p�o�Ũ�1����KJ�p��<`��|
�UЗ��L�pN�����<�/3�~�
󛾜��Ҕ�T�.ȕ;CIl�i�r'�Ѫ��fZ��Ђ�*v��2Ș ��qu�ތ���,�=����?�i�������ԛ�.�ʹ������|�i�z��q���0�W9��2h�]���'��G��p�w�p׿�]+�E^�x�
H��z7	�_��gw=�G���~��q{�N0����e?\��e�e箬�� �&�>؞�h�f~��)7M�h���PnB�6����N��AmeC�^�	�"��A��Mt^�P�HVx|Ld��b\`��Ҷ�Z[�b�W�M���^B����r��±V<S֭V�� ��([�����S�Ku�@�"�Sh�o�sb`�7�eP-�B��8Rv��Ds}ʔ���>�=U�;���^�=��E��۞� w����[�^mS9�}���
0�3T]�v�xuHk[��b҆P!�D1 �+=h$�,n�4�5}٣P�4V,�_�
�-}V,M�z��x�\A���0����ji��5�w�@��~����hω%Ȕ�(��k�����&9N����uq�����i�?p.(���� &Ao��=�锆�	X��>>|���G����zO�>>5-|7}|E-k��}��e����忖>N�u���#'`��&��� ����P��>��>��>{�e��a��1��U�G�'`W}��9�v5���z��м�;-78�`1�:����T��p�QS��f�ק0[���	�|�uD�x,%2=��Kv�HQ��xӇ�:eI2�F�fG��赸\�r��0�px�Y �j՝Y%mW�9��,����6<$�T1n
A�p02���}�a��L����*�?��|+O��-��L\��D�-����{i�XNQ��C#1�o���7���i��e�'�P����Hq�zF|q�n��v�$���u�SF��.��L1�2
�v���<�īr�4B!��v��h~8�Fs#�,&	�8������ǪL��R%��.�� �M�9�A����
�-����]��G�(,]���p&OoxZ#�P��������<�\��`�'(I0�d�n�`.���>�^�
��B����9�Q��6��g���辒�U�Up���@S���M�C
4^V�vm�:Nؔ�Q��u����B	V�^�]��$�;����l��!M���<d���o
娭Su�_'����ɦ!4IET���uݞk1�/0��Z����M�d�X�umĤo^N��ب�
�M�4LbÄ���}���gd��4�.A~	����p���1����_{C?��E�wnrFL�����(�	����'�w��X��Ȏ���g�{H%��5��L�����U���ˍd�����b,s?r��������ȏ�����yy�t�s
L��Q|��	)��n���(�a4�Jw�����+��khml9Z�g!f?}r�6�g�`����_��?[&�����/�s��u=��ƺ��b�&��M����E��HU�ђ{t�UۂP���|�)��-�ۤ��탐&:��W׈4��8�����q, t�.T���u��\�v3+O�|�p�.�Z:�Vl�I��;�o��B�v�(e��%�|5=�V�e^n$	C�~�hZ���rj��5'��-2�p|�N� �HIU)0w5J۳����R,#)Cy��ne�LȋŒ?�!�)���_�ل��J!>��ו��8����ڋq�`ĕȒi���v����@CPc�<Y���5�E-���zִ�&�a%*�-�	�a�0{F�3d'�n}~��U�s�d� _ut���Q�Y���5U<�s&��<3 �Ύ�*���j,pu���(�B�-�EA����ǘ/LdMw�ƈe1�o�Eo��mQ'8Uq��ryS_Y?��{[���9^�\X��B�l����m��yV�u�?�kӿ&u�պQ�M5���)����y���M� �V�9Ǘ�S���h-�zs.�a9�/5lP���?}�*�4�M�bOsk��T�-�rE��r����o��=*�d��7��
�j �!_v:ElZ§m��Z�����������M��
q-#	�m�ݺҶ�~jħy|,mT|iYĊ�G�ւ7��Џw+뼆[�d�]�Qd�{�03�v?o_����y��
5քk��d갖N��uQ�6�W�SQ�fw+�B����^�(���,����� ��� ��� $���jΚ��e��y�Jڒ��
6d<8K�b��q���M�%��/%�c�u�+*L��Z\T��ew�g}�Y�.�ƞ��dS4�A+���zQ��W+�b���;������'��^���#s��i4/��Ր��N$6�1�
���p���`7Gx�
�.�V[G�Bj�y+��򄉗�a��
K�Q��s�����M ��9ɥ|����ܚI�6�����h��\"�	��(��a�c�5��LY���D(!;�ѻ]_i�I�]��ܦ�mx�wM�m�$Y�n~�����"�˹����.8#�9˦6�x_<��c\��/V��&e a�4�n^^Ig��GNҚ�$tK��Y�"��qd�`J���w�YJ(:��D�nS�^������2��[9h3����0�[5{�8ܓ�����e�bzӜ֞�^�����z�X6�$�+]�������n��yV�!ۀ��Y+����a��/�e $��	�v�T�Jl�%�M��Õ��p�m��R��s��h���MQ:zɪ��%�_�$S�6N��r����K�	%}������:�7��t4��[����W�ܻ��Ͷ�v��铿����q��@�����b��4���ѯR��C��`h`��y�2AQ(�w�2�10�`���-�wC���[�w���wԗ��{������!`�f�&�ޯ.�~7���ݏ��f��0�[������ ��֏�Z	������w�,�(��	x�}^9����
>K�����@��6�6b��N%o�~ndi�n�ԅ�NX_hY�����`�"��:��P%:����\�O�:\�e-
}�q���ɔ^h�&�<���s)RZ�\q��j6�d'jX�FKԂw��^���I��i4�Ɍ�(4^�9m�F
�d�dn�@�@�JmZ����|��'פ�)�b�-��s}Z������7n��Z	خ��A[&�ȅ�Vݫ�������y��o�C���e� qLj��N�:�� q��B���g
�[�<N�/2�@�%�6(��h��g��;��]P�=�n#��=<�6�HI�i�BB��p76��ra=��6+�s|��Q�D]��q�Q`]DH����<�Æ[��\])ǭ���+$1�3[%7��<F��FIK^WDG��k�����T���V> Y�H@�0���C��cQJj��i��G�ʱ�-��?�5[^N���1�-(���,��t�����1��h���$����Be+��Z�.���>{:�S��V/D�9��;c�A>�Ec�#�쮛}im������7�k��vAu8i���G
� 瑨�V�Am�c�jCǩ��zm̈́�"z�8������g=������zk���g=��z�:�ٳQ@�\�rJMucg�P�8�P�6��_��m=U]����֭߷���źPDA���!g� r}��,��6l�l�l;��:4��$�CƟ��h
�����Uۭ��rTU�;�qQm~�&�x&�]-�&3�h��͖�B�;�F���/.�f����B~��ѭ9l�U����n�h�r|-l�~ki������-�cc�[JygT��5Kw�;-4�-��.^*�2�R�D�9G+���e�P\aQpk�7
1
@R��
���PT�b*4���������j�Ct?��Gw��=3���KST�z�'��(��P���Wx���s�Ӈ^KCO��}yO_��h0���X�O����O_�?�3K�5�_P������/U��͛}T�\�˜���b��H��4HF�8ms�?m_�����l�&zᡃz�>�l<M[[ҸlP��c_�������^o�Kwű��1��b9:�N�2��-2b8����"��J�A�]0���INW�K4����?�I41F�r#l*H;D6���U����Mj%�v���3��[��9Xt�3����D6�xSl�� �4��,��/m���PW:cMx_��R�/���G�i����UW{?�v[K��{.�I8��}zD�K�)xE��;�A<��s�R�|c�+�[���IF�0�2cq��Kd�z2N����� i!\d ����>#�r�Ii��ú��}^ũ��G�O�Z��Jv�C6c�qa��	*x��	R����#�V!�6���2���}�H=��P�3z���Gp+d�9��04ƚ�w8~��L
�,���K2ZU�����T�w@Y�+i��R�|�I=��+%���kFuIMzX� �֩ƨt����3��S��uԟ��z~�������l#k�V��(q��j���f*O���Vk���K@�ۧ��r��Q����T}��7(5��:&U"c��:�����y�Y�X�eW���rA˞�G���-���@��TU7HV E�u�a�*�L�a��='�VR7����LKЏ����]��8鎼0��3�V��V5j0Pg��ny�n��� �`�<$�����U�-��q͗�iW?[ݵ��
��
�qT� ����y��F뾷=z��UB��x�RL�+�6�Nߤ(�Cp�����F��������z�nϵ��x�ݕş��ߴ�@�f�vxG�n��"��� u�(�Ux�#�3*�-�$F�K���2����V�?|�6_0�(�\~�
�)��"��~�P),�� ���W�),�[Haa<�B��R�Ϥ��C
�,4Ha�tHaa<���!�mU!�����g�$��X�
g�?g�X�^�}�^wvDK�u���������Ǉ#_��m�[$ް݃S�o��|����c���i �ǔk�&r�z浣��M���f@^;ܥ���*ی��Y3LE/5�Vb�k��:�EWe�, ���  �� PK     ! 0�C)  �     word/theme/theme1.xml�YKoG�W�w����Ŏ
���z�c���T�����ߏ��/^�3tD��<iy��U���Mw��;��!�p`���&Dz��?��"�R�	�Dn�)�nU*҇e,��$�7�"�
�"�ߘU���z%�4�P�c`{c8�>A}��۞2�2�J��>��5�(6��CNd�	t�Y�9?�CK-�j>^e�b� bj	m��g>9]N��N�����kl^�-� S��n����
~�},�t)c��Z{ʳʆ��;�f�a�K����v��i�
�=>"�Av�R˯{�\�B�)jc�tI��l�]�1�e�R�m�f�js�b�K�l$Tf.��Yn���
�N�q���kXE.%'·.D:$��n@�t��Kݫz�3�{l�H��ȅ��9/#w���8u�L����H� E1��ʩ�+D�!8Y�[�X�~umߤ���,A��X�J�p�'l��a^���1M^ָ�ΝI8��
����#�&�
     word/settings.xml�V[��8~_i���2$!����P�S
��	k����9&bz &�NX�����d4��3�o��ȭP�T�C꩒�B0��	%�4
}�f�«OZCF
%��������q����J���G
S�Ap�'R;k��Zr�~�āQ'w�+�=
U�h\�U�JXk� F]��w�������m��)P��ty���4�&��z �B��6
�Z*�Q�:�R|&��UP�V����5� 1�U�oD	
�K4@�x��!�����c&I��3ܑN�z+M�IT敬嬰|m�D�U�J�n�X�Zh�����i�i�D�������G�qR�⾴ot�����t��A��h��g����y
�f2�������h��  �� PK     ! t?9z�   (   customXml/_rels/item1.xml.rels �(�                                                                                                                                                                                                                                                                 �ϱ��0�����ho��P��K)t;J�GILc�Xji߾�+t�(���Q���E]1��h��jP
���d*���yB1��ߪ��	�k���  �� PK     ! �4&"�   U   ( customXml/itemProps1.xml �$ (�                                  ���J�0��¾C�{6�i�vi����^E�k6M�@��$E|wS<�GO�7���3�����]���ep�� )+]�������@!
ۋ�Y��:8�����^D����A��S�p_Ou��{�E�ո���u�q���\T�����
��\e�VCc����t��{�ǖ���1���;#�N�ߤr�z�Ͼ���G�B�q10m��?�2!3������[E<�>�.D�.x�#��f��7&[�
����:~��Nު!c��h��z�V
xpϖ�w�!f"����A�DЭ n��r��L=04�+Y2!c�g���O�N��KU��D{{Itz����A�"Ɉ����"$�P����N%�"�Cƫ/���8aɲZtxK͋�j�!X
R|f�� 7��r��@"�F��Rp#PF�^F��Q!mT�@.�pF��8��x�B��Q!mT�@"�F��Q!mTϵ�3�˨��6*D��
h���b��x�Qa��Q!�Ǩ��6*D��
h�Bڨ�6*D��
½�
)h�Bڨ�6ju���Qa<Ψ0�Ǩ��cTHA"�F��Q!mT�@"PF�^F��Q!mT�@�\,�aT�3*��1*��R�F��Q!mT�@"�F��QA��Q!mT�@"��D����������N}�o�Q��U�ܬ��"\I�4�x86�F7���B�SԎ��6�|%u���u�>6��.��B�k� ~�5�S9nKy;y�m�nG�U�q��kG���qۤk|��R�:��i�
9��fk+q�m�n���@8�m�x��y7���8���_
m�h�܄���Z��ch����	]�s���&��tb�ºQh��(?��ͰR��M�J
%s�D1
@2Ņ\�轜�(��JN+%!G;�h\��dL����86�&i	�9Z9�	Ɩ���6��Ņ25u�h�XS�M���8���Q�
C��A�Y��kSu�0TP�t'Q�O�S۫
�/-JN-VN�IM.IM	.��I�U�qpԋ�QR �%��bJ
�9y�VI�J%%V��������z��y@������ �(]??--39�%?�475�D����L?)3)'3?�(� �jU���ч{Ǝ�   �� PK     ! ��9�  �     word/fontTable.xml���n�0��'���!Y�J�5k���b��qL��?��	���6-�Z6
>��$��lH�cBC�{Nq���=g��L���RH��.�j53W��t�&�#��O2�z�T#���F֘|�-�F�^79��W|E�#�MT��5��D,���O�k"��"�L��f"�B�Zc���k��CB�I��<$��~  �� PK     ! �(aИ  0     word/webSettings.xml�MO�0��H��*w�n�*6�	���_�4u��$��le�z�v_l؉�د㧶޶�ZESp^��v+a��4�>{}�::e��\��>��g�Ã�*� �規�b|�E��C�Y{1�}-*��4��Q��{��#��� s�d�ŝ$�����e)\��h0��("��ci��V��V�+�C��>Z5<ͥYa����¡�2�h��D5���Ii���:+���Ƞ�"h��`l@r�gTe� ��N���q}!�bvY�\Q��s�,��2,�d�>������8�Po�4Ȱp�(�{�:��9�7,��*$��$`�P��י�h�^���>��z�&��{�&gg�n���_�ќ���6H-?�
��a��5O5{0ow�uƕ������m��_   �� PK     ! 	L��  �   docProps/app.xml �(�                                                                                                                                                                                                                                                                 �S�n�0��?�'���XEŐb�a[�mϬL'BeI�ج��O���v�O���I���Q;�d�t�
�������6�H`k0��1�k����1��X$	�lO��G���4�m�4.�@��wM��8�ܢ%>��.9���Y��8�{Ek���x_}ғ��� �?�I3���QQ9S�eyU��@�ve��@<�PG9��Gb�� �Re��J�_�7Z���Z]C�m������-���(g�����mo��X�] �u70�U`p��/0�5B��t�w���PD�;MwΊG����d,���'6>R��&����q��l���<$|!�6�m����l硷:�3vv��/Օk=أ\�/�D�
  �               �  word/_rels/document.xml.relsPK-      ! 3��L  ��              	  word/document.xmlPK-      ! 0�C)  �               �U  word/theme/theme1.xmlPK-      ! ����  �
               \  word/settings.xmlPK-      ! t?9z�   (               `  customXml/_rels/item1.xml.relsPK-      ! �4&"�   U               b  customXml/itemProps1.xmlPK-      ! ~��  s               Wc  word/styles.xmlPK-      ! ���U  �               ,o  docProps/core.xmlPK-      ! ��\��   �                �q  customXml/item1.xmlPK-      ! ��9�  �               �r  word/fontTable.xmlPK-      ! �(aИ  0               �t  word/webSettings.xmlPK-      ! 	L��  �               wv  docProps/app.xmlPK      �  �y                                                                                                                                                                                                          g��zmz�8i)1��.�c���r8�ҡ�)W�>�MA\�wݑ�1q�:��}�N�&�	���3�������*�澔z"�k~$)mviy�%2N�I���]��8L523�� }q�渦$q��kۥ�ɡ����(?�[nI$�w�3��� �<]��0S��7F��xa�W�8;�\�؋���;��`N��z,��š�vl��Yقig�������L��l¯
/�t0ﳿ0�rJu,"��{ׁ�S,>��0.1����6L�O������:�ι�i�[�����G�N���f(�ˬs��ܶ,S�9�{��'^��������tF�`���g�s]��X��J����ǹ�vR��Pz��'@3!�O)�з�S���J�M���ƽlE;^he�1��V��2�-�x���%��K�����\\"-��%����{In-�tdu��
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
�w�D�
m_͚�	���iU[����?�m�w�WzO��]����YoS0綱���]�����6 
�����>/#�K�c>�� �X]V�4�;�w��s�2�ı��x��:t2+N�CS�@��qb]��[U%jO�
���צV]��-1��S��Z����9��VQ�zOk"�5�H���Fs�;mr����� ,nn�Yh�,.lh癭�=m���#�@�É�p>R���)�f>ۈ��߅=;k�y�p���I�j��b��(�s��(oɫt�N�tZDzZ{w˽@��ΐ�����e�-tJL~���G����?�ީrm&ym����?XP�a[�3����M9P��.)8�p���;�^VDv1�F#��>��d������d>B�!�pN�;{ܩ����'�����-K@���ݪ�Ã�R����ɨ �#ݑ/�K��z]�ޞcS=��$�]�<�?�xZ-�����l!8�U�����N��؇�~U�����%������>M��
�0g+�KH�9)�6X�ߙ��F�n<V3��ֽ� #�T3��1˞��bY,��K�ɹֹ���1uc�1�Ik���w���Bł�k�g�|�Mm�FN�˫�TY�=V:�
��{�Id��&��{��<е{�
�B*�Fc�b���a/x�sQ��
�c?�$�1SN=f������&�Q����e�3�sD�P}޳q����-��=��p�� e�4�{�ґCL�V�}f$���O������#f���@�#�����GO���������E�	��,�$~�z�)[�g�T�=EJ-���>Oy�H-E��ƞ�	Z(���
��sB���~<�h�D����$�.�Eo�ؿ�j&�^`�&����̈؅mrBY!���i��>\`���!�.`��Q��\!aj�6MU�L]-�:��I��{옊�
k�~�G��W.�JS1@̎&�l���� �A,Peї��@?�����}]�7}��=>����rT~�����s��x�k�p���g9o�W۷�y98?�gYw!�x  ,���u�
�Jߕ��|�u�Vs>�A��94��P%o�
��ܙ5�]�,�9I��`c�����@�T6Q���b<(*h�t�v����v�7m��5��Z�t���A���t\,׽Y���Ƹ���#)�FG�P'��0VO��l)iI�C]�ӣM��8���o<�vjm�|ߩ�R���!����Vkۡ&�;|&�B��um����1QU;E�H�Y�#��P�8��57�]$�/0�g9�Y&� `7MS��o*�r���԰#6��eSF�}��Ot���C�KmO�S���K��jo�o��9�rÉ����Z�
���#��	�(�咧#�X�ɍg�{`�4�[�u���:�Ɂ��Wd5���jO*����&E_�9
�(��Ho;$t��A��v�'���{ڦ�ƌa\ouS��1׮/"�^�[�V�`�;[,��~7�u�,�^ңOK#O
kq����^.R]��}Mf��Ev�-^O�bUň>ޗdk<�b铋�g��������d�3���)]�0�5v����q��$i\Hر7�]4�Kxe���]�T��#O���[�!�Y���#I�OZ�J���^�#�D���r�T*Ӧ�!cP�pm�^ZA��6�aS�%�-}��`K7>���y�ʋϽ������L����ҕ�����cN�۶�;��1���n|۬'���3��l�u@���A�֍P#^=Ў�u�l6\	:�s�
���������:��e�De�ϊ*0xDv�[E1�cB��?�g�#���6�6��"��(#	-�@컃 #壧וH��J�R�1�v!'�_�[�MJr�w��`C��O�
^�'{_���~����ظ�!�.�"U%��T��1�c:��>`�=f�>|�����]��6$C�D��,��"R��R�w��7ȼ\i�m*Db�$�{��Ĥx@>�ÝRKK�x^�	������D`�]�w��H�����?�Y�8�-�G�L@YJnS��3�G_P��	�X�p�|~���~��Brn�<���5/1��c"���#ʥB3�%�Aƺn������*27�4��\PA^���b��5C�햓�執iϴ���@��u�B|H����^�Z�?k&���k숖6N��ݦ�+!Ū�O^x��!X��� ƭĉ��y.c��ǴP���b�{\' ��@����Y��e��d|�Q+f�ʒ��%�l� �c1�^��ꅓ֌H���>|��z�P���T�v�7,z�m;����;Q�~k�6-�> �zSp~��D�_��9,�gS�t�	d�QVl�LAs��߶u�k�7wD�H��`��r� �T����Q�q�O��t-х�v��-"R-9ڂ����(J�t�J�7s�*�⩤�U�J��i���o9"i�Bs���j�F�l�D���a�YR��>Uݴŧ�q���ՄB��	^Ϊ��s���J�z���F4��9O�(��6}�^$H���̑���I�r]5M&�I��=di��Ł�U��}O��f��I��L5e�ʂF���끻����fV��y�e����Ou�f����Z�Sb��}|�j�{�}o�~,o�O�vn�ct\��8���Eܞm���A]�`�&N��L	�6Jp���#�����ۚo월'[���Z��Axeu���D�X�}+ԴJ5�p���o|f|Z�5f��ӱ���x:O�����.�QR(<�l��Va�NIM�
,-\��̊[;������F@K"���;)!m�Ǧ��]�a?i'��%J�T>�="	�|�j,�LHaJ C���\��K�����b�aN��<��T��tЏ���X�����L��w�"����-h����k���±�%v�(M�����ⵞ�7�@�t�%7;XD�������S�g��`fD��X����q���Z�݁폠^O
���_��e*?�3-�|A���U;��)8SH1fB��7�)"��(�ю]��0�X�1�+&u N�ߊ� a���!K^�x�D·nY�d��¶�w�Ȯ*,2���O፴(@��_��1������l� Ϟ�Y�ˌ�1�(2:��7B���w�>��-��Qy�k�G��U=�(=���ì1�=m���)�H���=������]��hvq�-��84\��"�K$�v���rKj-xŏE��	8�0��r)!mU`��@?pp	V]�ef��(��P�5����+��N4�dA3D~�X���g���w�w
)ɒ$T���?g�������|��{<s�}�}��M�J���yK_-���d�oL���ZGc��oă�}4�U��w�}J�#���(n��e������A�=�hց5��ңO��E��9[6�G���G׹��=�/�mݤ�g.,��d^�&�3H�� 닳^z`]�D� ;�����.=�k�5�`u��}F�_��\�t(]��䔔2���zB�R]@q��Ni)))Ani�a���e�����0���\�h�M�}#G �(�,r���^�y��%1h�0�0���6,�� 4�}�1�!,̾ǁ���O�o�g�Θ��K	3g� ��X�7�z��	�#��}��opV�7N6G4f������m��=~ׄ�]�e���u�Z��\�݂B� �3�`�F#`�e���B ��'-���sٹObV�g�߻.�k���Q�p90V�|�Ҍ�N�7�Z9E�}����1y�~ؾ��T����®�'��,"��������'p�p��U?(~��6I{�~c�9��M6f���n.�w�͏���|	�o �f�sc��� n�gq܊��k`�4�oX6��X�̓M�a��Ax7��S�Y�ߋ�����*cY7�΀���e� ���T��a��`�:0g�?��~���v�ܨ�����q�9f���~)��:��*�����e��3���[��!�����|L~��&���Cs̎o~��~\�?|~���yj�h	���Ъ�c�O����?��D8C.a�&l�l�j� ���|+P�k<�n5b��d����YD��ߘ?`��dy۠�f�y��c��5	K� .�?���<�? �a���
��?fǢik���I4��W����w^8� �LcSX���sc�Ʋ
>)���FgY���li۰�Z�f�c\B	2$w�;$�K�ym��Y��؝^>�<d��
�\E��Fg�k��Sh߅��y&
J��(E��6F�s��Ҵ��J��
����ub���Nݤ捺W��eI
2X2�&{ӕR���Fyڼ�ݸ QE����]{n9uO�b��b�[�jy�#�����I<�{(�� o�M)�Չ��$
���}��Ǎ�i�E]b1u-�����&9WcMD�{@��YAӹ�]G�3��?}��Ҍ3,ӊ̹~�jr�E�չ-�f��Z�M},+̽�v�e�)�(�?� <!ܱ��Sj*��}�BO�a���cn������x���J�ش�7\�T��2��B<b�Ȳy*N�X�̟ɸ=N#v�'}
���'r$���D\�w}���_TGx8��K$h�۷~{�����+x.S��/?��H���8kG��B[;�%�i����"$�J�ƥ���8)��|O���&���1����S�Qe��d|W��޷��`!'��<-�s���P�v�'�_	p5����:�D�y{�~mu+AQ�m�f[����z̽1�]�D݋~�:sǽ����2�m�\��u���5��-Z�]��K�Oj 6k�u���ɠ�!*�*�S�K4�
o�_��Z���$��YoT��y��}� ה�[�o[Ѕ4bj�g}V(�Iiʈ��\%�$H?*��e�e�׬�^[�T�]�e�g󴃡�MPIwzAZV��=ōIW�ɽѩ�3/�
�=Ռ�pw���̙`�����Ҭ*�$w��pD{���˽�in���Wf'rTF�^~�`H��Q�Ob�|�5D���8]"�y��[�V0�X��R{I��aR�}���/��P)>At��/Q����]����-���Fj��M��
���.U�I�gCKp)[���@�� �I�BI_�i�-�.����P�I
!Z�����jc�Xj!̼�إB�A�~��̈́,�R�zQ�yF��x�jFp�T���F^���#�8�I�=H�V�ik�&z�'�4BV�Hy���~�[���-�_���Lɕ�U~��/JV^�8
n���3�[_$x0��-��x�G��Uچ[em������pY�5"�U9aRu��F�W�eߋ�_�Hj�#E�ʹ�ͧ����N�WW)I �n&ܩ��|��������|�}-����
g���`��m��7>��R�i�d�~$�m�a_���6F�����6��7^

�qX�}���uȾ�a����|L���S��y.ȩL����v�[�/�;i�/����/1{�ϔ��DS�a\9gw���,�����p�Y���e,�废<�8f/�.��-�Sxf4�h~�� �Ky�*T���,O�c��b������#�1��3��0�6�4�Is[b���8�˔̘W�cMำ8���c5� �S�Qb���cv�`��9��o�ԣ%~\&h�1���������8���oY���/���M����?�_����2^������s;`B
b$OΥcG����4G�߈?��B���z��)����r����PO��R��>�������&-��E��<�?�5�����)��K����5��������8���,���yؿ�y:��Ģ�
o�x���9d�\��L��r��ۧ����1#�MƍIC�pc�07Fo�VF�������5n�tcO�d����)���:��y��#h>�pcD&�ƌ����t�{��XMƼ��πy��މ�����v`��D��X�ǯ0/��̋�����xt�&
���˼ ch	�`^��e[ N̺ ��P�n�n?��?��'c�~J������[�$!6	Cft��2d�#�#X���h���O�O��g�O���џFχ����d�Yl1x	�`(���ğ�51�?�a�U0#���$h�g���'`�L��S�u������"S���g��h�9!����q���1_(0��sܘ�Xn��N|�7[n�!̍�3_Q��PZi�.�+[����=�7�b�Ӑi4�5��ՓH,�2C��u��vgF���C��$+o�|�J�"E-}�&�B֏��U�Y<�zT�u�ç��&�/��F��Ğ-Cc�2����}�����w���i4�|(�7���k�kJnt�������Y4X#���\Ǭ�s��:o�o����p~9Дqv8Ǧ�m�������]�+y$|Of��H�9��%7"�gC�K�6U:���gmU�D��S�v��o�~&�P��.��1��d� ����]f5gJr��V���ZG���{Tw�,��
Z��-Rk��U^�'�pH�[�wƍ�
u���u�vg��6Z�7Z��d�J���I���Ad�P~j�8�**�]]v���.ߢm�,Q�<JR��Ȫ{C+��b�:-x�5���oe&/%T0�(� ������� ���"f�%��r���L��D[-i����|\,��;o.}�RW9���
A�ht�
gu�-)Ǉ�m�7�ͷ5��j�H`!rTJ��FA�&��Y	DX���ő*���)<H�B��%(e�saO�!
dٗM�J�h�F|�AF�%��E����;m�r���C�4�X��o'�*.k�['F��!A����|�E�Z��NaD�����)�
�n ���19zл}�u;Z��|�*�n*+���2�¦�O�	+ei,��2��'n.��GDY]$v� �$�ޗ�.`�` ��e�j�)\�!㲧�3���|%G=�d��{�j>#9c�H�T�6K��q��\�:z��c+�|��A!H�.Y�E@"io���N\���S�;q�I@g�h`���H'�����i�v(�?���Ԝ��٠�쫔��		�b�zu�=u�_n%���t�Qs�,�3$#�@~
x�tB��}������df��A[���b�cw�?�P!{�aC
7�A���\�[s�p�7Y>�9���n��.�k7b�m���8񲞙�Z��'�Fe�
{�%�ovJL�����ܫ�&��}��!F��D�!�UK�x)r떣O����O�X*�r��k���H�M���(��|��­
��Y9��b�U���&�T�%6�+�]�2U��2���
s��{ë3|���8�(�-j�)1U�_���)��r�GK�*^px��g̦���L����m��ȮhC�u��͕�]!����@r��b��GK���[gz>�:���I�fջ˄�AW��=ϗ;W�s}6��̯�ŗ!�;|���і��H��WVg�]�"}o�$��d�x��ߟ��P��i�hM����;�fzV��QV�d)f�#�@�B?Ϫqe�,@��ԑ߷aa.��B�}gՀ��vx��X5��������7/��#�q��AO��u.�}3c��o����냆Y�
,$�TF�oľ�+�T�o/�7�F�y��FMW
2�@�
s�s`N������I
|Qv��/{�ErG]"7[��2���j��';�3M���B^-��R1*��_Ieu$������J��E�x׹�W�u���q���ֺ�G��ݳ��"e�V'������Sܺ��ջj-_����K]�i���c�U���1��~.ҏ\�B@t�
�擬���2�b
x F�j�D;J�OdW8{r2�G�Y�J����˧�޼(�QӠ
�v8RY\��>��F�G��iP޷����8�9%����y���[�:��La~ܗh��Ȗ����nў����;�dz4�����צ���#Ow�����^�~
!�5B�{�}
l:�L�fc��,UcC:[���^��w�rA�Ep��j	��GV����n�����ls�WV,-��GY���OY~�M:��f&'�����e�R����a��bU�_�Űd�fo��)'��SS��*�9���5��u��\R($
�@W"+�i����˃6�R|��y~*k�h�j��	��n�y���'��rڕ��(�|�0�?	Ď{�/�yO,�hR��o7e����ȡ�o"�cP���!���w��P�׹,�/��,���GBI�����J��
C���!c��O�<����;S&^S�+�_�I��-��}))����5�W�'�K��]*!�,�U�E��s|�u�-��FZ�ÏN�$�+lu�x�f����x��&sh��/��;�����5Ƶv�evn���t�e�W�JI�03��ZAДƧ���n{v��ﹶ�~j�n���~��)�8� &��Fgaw�c�"�E��&!����ٓ��J
����WĂ��綸���|T}c�S=���m�7M�7)����+1S�?�w����1xD�T�r�g�����^pz2b�"9���هt��m_�"�/�0ۓ�!VY�9<��Cjj_�I/�㫷,`;���0#��ľ)'�ȑ�Iʉ�Ip��@?Ǿ)�6��J$���_c߀�Ȫ/X�������ko�(@ikd�|��Ww��~�k������_�ǃh���~�=@ ?�/�p���`��~�-qG��}����Y�������f�_Џ�-���{���rM�q�|�
��,������������X|�{�t �%�����Y8C}������r<�f������k����rxq����j�� �{웥*ރ .
�>?�Yl��ro���;�
��-}y4Mc�����I��������c��Ɇ���7A���1xկ��� ����"�:=d��3����~��UNn�w	���{���c�tD��~6_WWG�jYA���x��5w--��q�;\�s]��9�++������|�޴}�.��1�Ce@����G@$�����/!��ZF�FBg��I�%���Ji�2�0�OB�u@h���H������(��ÛQ�{y(ލ�=��ɝ�HI��g�y�0��ɨD����r�M��B�9o��;�~��,e�Et²�2x��LA"	 ���2]-p��
��?Vw��I'zJxy�ITG���@�7ω!;�]�֥Wu��ٶ�v�PfrJR��/��|�%~
!Oɹ+�8\ZXI�����k���)��²;G�L�7�n�	�'�8���Р��k�줥j��צr?�n~zk�x3�l��6h�X��#��ݩJaD�3���U
԰�q��-1)bW�!6E*b���53��˂�V�6AҐBF��ry�m7�?"�yj���~^��fل�4�c�Q�N:��q�d��ψ#�6�ɦa�{��m�
+"Q�i��e&�
e[o�9�w38V�����Z�#����=��۫�FP�xH�܇��o�'�W6I#O���^Oٵ�fl�F^W�d��u�:��Z^�Wuf6���]^v��0�Q�e�9��ʟ�k$5�}XK�|��C}o��Z��	1C�Rԓ��?f�����bw�Vy.L�8�l��T�i	щ�����D�<��N0�FD�������(��:s�{
����T/�^��yw�Ђ[?y;�t�gQ���5Sn�q�`��G�J��`e_n��V���;p�"��p�3��5G��N-���uEr�ܰ�6�轳m�<n"�߁i�ț��O�Іm%`@30F_�zɉ��I�P�V=�n�ɀ6����$g�g���H��d�>��,�ς<`�� ����y�A,Ǎ]p��D��d��we��>���p@)r��� �3�b{��*�O�t}8uE�k�а�(8�l��zS�:M-R�#�k�@ȋA�4���/�Ӫa���,K�3��F�y)G��>����E�j��q�����_�Pm�a�X*��t{v�T���-�ǋL�m�Բ��Q��ޝ�ϼ��N�����:��{႒�b4��߫�����læ���g)�$�p�u4.���DZ�*|G��:J����xU��s�@�Lr"�֔�-��>[����'xU>gk��+3��7���<���I�6�@RC�o��җW(%K�|:Q��E+�����xX�Iۙ�ќ}�۬Mg�Gm훸�u孫j�$A��l6a�8Kc�$�E��tp����s�(b6)>�AoC平���#7�J��D�^ULw����:�N�4ȿ�<x�d�|$�
T�J�����~��?�?�?��+Cb�P+�P�[�qY,���l���Q
�%,�??.2m)�'&2?ΰ�����`��C������˾_�ᣥ8�;�%H5�8P�R�2� ���*q�8kQ��C�`��`R�q7W��ޏ�� ?N�?�G�����ܹ��:/���/�ڶ��/�ż\έ1ܲJ{\K���[3C��A_��o[�p���[�y����*q}�2�*ϋďC��2�ظ��5{�W�W����U��~\7~w~��*� =���� ރ(��5k}z�=`�ǭY�Œ�5��5 ���<�>�r���f9��%Fw�[pj�5�7����,�[�����:T�2\o�G�m v
��T?Ρ���߿�^��~M�P��/�֐�2`B�?�֬���[C�E[U~r�ʦ�:=9V�e^ܔ�f�͍��d�Qh\j$��|��[�Op��s�I��%ѻ'Z����)~�<�i���9��*֝t�H8��G2�فvfI/D�3�Q��Р����dؕy/�6C(���pD�Ucq����
���3/?�� <2_~��Y�N���W
ݫw��S���ȧ���O����-O
)�U��hKk�3[�a��W�ق��9k������x-&+~�}�>K�`��y�y��c��$B3ן��ٌ� ]'�:yP�d���P��O��W6(����l1,�9�_����)�s�1l�����^G�nF�U�"���b�C�TΜ����w���A`�)7MP�C4о����*�j�IrQtxRX|ң`�z��^�[�\X;���G��YƏq�&S��<z8��*٣��[��R�&
���"
AH3ժX�fllҸ�(�b!?/��p����mi(Qm���Lp��9:F?c+1�])��[hN�W��������I[O�/'[+��ͫ���7L������5�w�P��A)}�����h����znT(�{�����~wT�|w������Ǝ��
Vo\I�c��i���bӅ�l�}A�cv�-I��a	�-�1���N��s��n	���?�/T�CzE������>����z�]�
u:�*g�e�mś�}�q4�!���6�pIaR��y�66u�[�i����)�X��`s�����ɝOe-v��"
d��
�
PCF���
.r
�GOa��<�|��M��`D6Ҹ���dXk�/��X�/JJ��i�v�a�8�$%�T��XA�?�Ed��ݻ�I����r��e���g�nV^� q���w{wm?5Eͳ�Dt���SL��FM���Z}�2ɋ��t��)�ӶI�H�{fݓ&oba]���i�0�W��z$�PML�μ�#	TF���9~�cL,���0$q ��	�1�ffwO򸡪~�О:��}�Yi�$.�Bq�zp�n�}��
(�N�zܭ����s_9����yN����\���9胚b	w��Gɤ�2<m#=�L�1�#�c�v԰�X���ǚ{��]� ����)�|i�+-n����7R�=�{GQ^z7އ'��	��${�'R�Z�O�QO�2��=O��ZP��aw�=Nk`M�D?+�����[:ċ��|^���}��
<D���i����{E��a����O^knz��	M��s�'��#��2�tԶ5ĆN4E7tm�B9���̲��>~�;�u�[_mO�h������w&�P?�����\�֕���ce]�t8*�*W���G���]�rD*W��r_�\�M�JI��o��~m%�[����<>������ڙy�gv�g��ޟ�Х#+�6��,���v�����6���Y��}LK�<
����d����X��h���2Q���;8#0V�~c�����A���+3��=�U �pV�p����(�I�
`� N
�@��Yl��i�
� �
`��]ѝ� KY��I�
`�T�Q�d� � �
`��\�	��s��@�;��D���>��6��z�[ϓ"������W�?u���r�_�a3���k|���_��_�"������>��}@�?���l��S��~;u��n�_�"�?�^C�g�Ą�,>�T��7�h7�o�"oh/*د
�-(r~Z�y_������T���_���� �3W02h��'������S��o�Hۃ>�� �ӁfrT����!���M�E=>���{����9�H����G<CP�'_�K���wD��/�|-@�
���k|���_��B�̵��[���0�eP���c�
�;^�QGB�,	j��Rp��,���Q���?��v�99* ��⨀��{uAe����]��(�OsT�����fj6���A����V��z��pT����Qy��⨔#/G��8��x�v�3e��a<Ay~G<Au�[��&�\��rT�-��?�f���|W���O���OBP��学�C�@����4s>�'�d8qO����~�3�g�'���7ч��� 0Pf�q���@O5w�|����Gq���<����m���)Hb�	'��N�9�NY:T
���S���n��j���i���~��c�Y$��'�*H���zz�8�-}��[t����il�d�0GCU�n��]��m�duk7�R�Cb>������Ѡ��;�����X\��dd7����t�������8|P�(�M�t����rۍ�S����w�gɍq�T��'��K�y��T
�
�10��h����h�oSmE�+y�~ڑǾE�j��OdO<�jNt��'���+��r��[
��Z��)=��b�,�������WLJp�T��\ާ�+�Ï�d=�zɵ��'%cZ��8.EW�-�QqGCV��!$I�����w>^�'��"�9�����X��`_{`���c����G����Ֆ�z埩�*P/��J�>ʯ&�)'�6���H0�Ո�P�~~,-���=?U�)��r��)��oH�z��6r�?t_��9�Ca]J�m���뭮�"�#6��2�b����Q�c	�F���A���/7U7���+���8� N��[���v�IG��8�Y�,c���?2��� ji�A�(	q���:��n�����Z�
Θ�Bm�':��IڡWG)�5?lJ(E�G��nE����n�W4P*�{U�A6��R^��w���\~kD(�L`��#��>��V	�X⺳�"�����i��,|z<=��{/�z/��u0}���)3o���v�;N�2��U�Z��?�e`�]̜A1���:�~}-(�rU/[�@vNn铁C/��Ԇ��e���y��E���kЬ������c}oz-��n��Bq����\��Zw�p��8��pK�,|%�,�~t��D
�;�������*N7�9�����#�Q�M7�f�v{����gZ�������(���I�o�n��ҌO[��q`��:]�mM~��ǽr��H�bz�Y��h��hn	'zy����>'��嶩:*�*���W[�}��m�^`���'q���V���&��Sf�ZX���cM�j*�BD���#ҵ���&���yK�H˙�tZ��D<�<L��ҝ�е]��G�C6�ӗ��	�'�I�i,a�*_��
S�0�{�k6i���`NC�-�7�vu	���fcZ4��aƿ��(��Yƹ;���Z��t��L|
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
�q1;#(y�rtI�n=�NW�L!��że�<[���]j�4��*�����U�X�eUw'������ҧ\�^C0�F��D�sH�p����IS�kn
�d�Y�J��]JZϠ7����b�<���p�2󮪤��ζ��"�ӕ0�[4����;?�ˋ�]d6w�JJ2P��.�����%��_`�H�<�Dn�E�3���gc����1F�mm8h�dp�NғGGE?�'FX\+Ir�Yv�Y��RUq��xj��f��c
si��ޜ�w���$#PU���$��u�����`����Æ$] �':�KVЩE��$Cg���_�x-Y^�y=����/0�E�eg��������4�}�'��7{������P�fʗO�~"8N�T����|���E2�g8�n!�-@�//_�_�dd� 0��;��C���!����5H5w(�^$���\������T�3���k�?�.0�-��k���.�>~�����,��� �X@���~����k.^��|Ɲ��`�4���=���:��Si8��y~U��3�������pw �<� ��}��=Q��>�pu�O3� ��~ ���gg�~Vc��s���Կ�B��v��3�t���:�É�B(��"�A����y(ю�E��PD;E��"�A(��"�A�E���W����c-q;�^h�b�t����#
���7� ވ2��f��k3��.�z �A��>7p���߳���?��� eJ9��?Ai~�?Ae�g�$�:���O�=%_S_��?A��Vf_ӟ���'q(������ʁX_���r����1l��S_�����O`~\˟@9Ga�0�'A�+�7����M2����f����� ��
.j�j��OL��@j<�ԯ�8�xkݦ���V7k&�>��֜�dV�~󲷷7��&�n��D��LY��#'��IB=w��9��"�ٳN;:��b�:�㥱��
��ꓤ6����rd���h;�~(����I�|��q��� �I�����)�l���b�.�Mu���$�ߜ=9B!�r@v���#-��B-����y�y}��������9>k��wA�{u�&ѭ�eto����M�f2���i2Z��~2�;{�&~�g�G?k��i�zk{N���wv^��@
�R���=��3�|\�",S��yӜ4�
��e���}�^
�&���,��Ҳ�w�Ro�gZ9S����F��_�D��!h1��Q���T&Q��b�IK5����bH�/�oIp�G��-��R��9��L�L��
4��֡��W�m���1Gц[�b�a�I'މ�;�!^�H����ݬl��ަsg\���SJ�;e9j����Z�r姳��5���3�VH��a	.W�:��\�3 ��+HV�q�:m���I�o�d������s�B�W���9?A���.��f�Of��h�Io�6t�_������"�X��B]��KV6icؔX�.*z��X���ʉ��u��{'6ҫAQ�t���H��C��J_�*i�45�9*礜����kc��*��ٕ��������L��mycma�ꕛy��[��p_�(3]�7�zC��{/����>�t0�������T2F���mڅ$��"A�Q��rl&ީ�mbH�౅���ʌ٦t�	�gs�b�ޝ�l?bj(AGy;���ym�e��d�� S��	���e�S���K9&W���*#���>��R)JX^	��$�q[�
s5Z`R�����oa�~{~��ۻ�ͫ�G��"[?U�Ъ	e"�"�`j�{*��cz���%}^����K�fQ�w��}����Ȓц��9Ӷz|}U�-���~=�Sd��m�;���cW_ILxC#�4�������w-���z٣+
λ�Aq�XI[�šOð`�!ey
���s�!������zw%�AD8��]�d����_P�ٜA�GB����|��&����:K�f��'+��
ͧz�p�k9��q��}����F�q�����I�F|o