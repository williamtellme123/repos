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
