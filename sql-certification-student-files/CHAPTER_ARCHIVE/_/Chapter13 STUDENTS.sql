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
    select county, river_basin, subdiv, pop
    from watersheds
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
    group by room_style
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
      select * from cruises.ship_cabins
      where ship_cabin_id < 7 and ship_cabin_id  > 1;
      
      
      select   room_style
             , room_type
             , count(*)
             , sum(sq_ft)
      from cruises.ship_cabins
      where ship_cabin_id < 7 and ship_cabin_id  > 1
      group by rollup(room_style, room_type)
      order by 2, 1;
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
      select * from cruises.ship_cabins
      where ship_cabin_id between 5 and 7;
      select   room_style
             , room_type
             , window
             , count(*)
             , sum(sq_ft)
      from cruises.ship_cabins
      where ship_cabin_id between 5 and 7
      group by rollup(room_style, room_type, window);
    --  NUMBER OF AGGREGATION TYPES?
    
    --  3 COLUMNS
        select * from population;
        select  county
              , wug_name
              , river_basin
              , sum(pop_in_2020)
        from population
        where county = 'REAL'
        group by rollup(county, wug_name, river_basin)
        order by 3,2,1;
    --  NUMBER OF AGGREGATION TYPES? 
    
--        1      2      3
-- T1     X      X      X
-- T2     X      X
-- T3     X 
-- T4       

    
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
      select * from cruises.ship_cabins where ship_cabin_id between 5 and 7;
      select   room_style
             , room_type
             , window
             , sum(sq_ft)
      from cruises.ship_cabins
      where ship_cabin_id between 5 and 7
      group by cube(room_style, room_type, window)
      order by 1, 2, 3;
-- cube formula for number of aggreagte types = 2 ^ n
--        1      2      3
-- T1     X      X      X
-- T2     X      X
-- T3     X             X
-- T4            X      X
-- T5     X
-- T6            X
-- T7                    X
-- T8 

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
group by cube(battalion, company, platoon)
order by 2,3,1;

-- -----------------------------------------------------------------------------
--  5. GROUPING FUNCTION
-- -----------------------------------------------------------------------------
-- 0 Basic Group By (set of columns is all columns)
-- 1 Some any other set of columns (at least 1 is null)
    select    grouping(room_type)
            , room_style
            , room_type
            , sum(sq_ft) sum_sq_ft
    from cruises.ship_cabins
    where ship_id = 1
    group by rollup (room_style, room_type)
    order by room_style, room_type;

    select nvl(
                  decode(grouping(room_type),
                          1,upper(room_style),
                          initcap(room_style)),
          'GRAND TOTAL') as formatted
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



group by window, room_style
union
group by room_style
union
group by the entire table

-- -----------------------------------------------------------------------------
--  THINKING FOR HOME
-- -----------------------------------------------------------------------------
-- Help understanding GROUPING 
-- Type in the code from Page 517
      select  room_style
            , grouping(room_style)
            , room_type
            , grouping(room_type)
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

drop table mycubes;
create table mycubes
(
  fruit varchar2(25), 
  meal  varchar2(25),
  dish varchar2(25),
  price integer);

insert into mycubes values ('Mango', '5-Course','Appetizer', 400);
insert into mycubes values ('Papaya', 'Breakfast','A-la carte', 300);
insert into mycubes values ('Kiwi', 'Breakfast','Yogurt', 200);
insert into mycubes values ('Mango', '5-Course','Dessert', 100);


create table mysort
(one varchar2(25));
INSERT INTO MYSORT VALUES ('5-Course');
INSERT INTO MYSORT VALUES ('Breakfast');
select * FROM MYSORT ORDER by 1;

-- row 3 col 1, 2, 3  and its sum


group by cube (meal,dish,fruit)
order by 2,1,3

X     X     X
X     X     -
X     -     X
-     X     X
X     -     -
-     X     -
-     -     X
-     -     -
            
m     5     app
p     b     alc
k     b     y
m     5     d
m     5
p     b
k     b
      5     app
      b     alc
      b     y
      5     d
m           app
p           alc
k           y
m           d
m
p
k
      5
      b
            app
            alc
            y
            d
-     -     -            
            
      



select * from mycubes;
-- ANSWER THE FOLLOWING QUESTIONS
-- 1.	How many different aggregate types are there        
-- 2.	How many (total) rows are returned
-- 3.	Is there an aggregate for all unique values in the dish. If yes what?             ?
-- 4.	Is there an aggregate for all unique combinations of dish and meal?                   
      -- If yes what?
      -- If no why not?
-- 5.	Is there an aggregate for unique values of fruit. 
--     If yes what?
--     if not why?
-- 6.	What is in Row 4 Column 3 of the result set

select fruit, meal, dish, sum(price)
from mycubes
group by rollup(fruit, meal, dish)
order by 1,2,3;

--F   M   D
-------------------
--A   M   S  ()
--A   M   Y  ()
--A   M   -  ()
--A   N   S  ()
--A   N   -  ()
--A   -   -  ()
--B   N   -  ()
--B   N   T  ()
--B   -   -  ()
---   -   -  ()

-- what value is found in row 4 col 3
-- and what is the sum of that row
select fruit, meal, dish, sum(price)
from mycubes
group by cube(meal,dish, fruit)
order by 2,1,3;



