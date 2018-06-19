


select * from tickets;
select * from dual;
insert into tickets values ('Connecticut', 'Brattelboro', 'Wicksville',1500);

select state, county, city, sum(num_tikets)
from tickets
where city in ('Bourne','Brattelboro')
group by cube (state, county, city);

select 45+8/22 from dual;
select 45+8/22 from books;
select 'APPLE' from books;


-- select cluase can include
-- a. column_name
-- b. the results of a function: Upper(title)
-- c. mathematical expression
-- d. a literal value: 1, 'apple', '---', '&*^%$#' 
select '---', title, category, 45+8/22
from books
where category = 'COMPUTER';

select 1
from books
where category = 'COMPUTER';

(select product from store_inventory
union all
select item_name from furnishings)
intersect
      (
        select item_name from furnishings where item_name = 'Towel'
        union all
       select item_name from furnishings where item_name = 'Towel'
       );
 
 
select count(*)
from onLine_subscribers
where sub_date in 
       (select CASE 
                  WHEN LAST_ORDER LIKE '2009-%'
                    THEN TO_DATE(LAST_ORDER, 'YYYY-MM-DD')
                  WHEN LAST_ORDER LIKE '%-__'
                    THEN TO_DATE(LAST_ORDER, 'DD-MON-YY')
                  ELSE TO_DATE(LAST_ORDER, 'DD-MON-YYYY')
                END   
      from store_inventory
       union
       select added from furnishings)
;
  
desc store_inventory;
select 
      last_order,
      CASE 
        WHEN LAST_ORDER LIKE '2009-%'
          THEN TO_DATE(LAST_ORDER, 'YYYY-MM-DD')
        WHEN LAST_ORDER LIKE '%-__'
          THEN TO_DATE(LAST_ORDER, 'DD-MON-YY')
        ELSE TO_DATE(LAST_ORDER, 'DD-MON-YYYY')
      END  
from store_inventory;
delete from   store_inventory where last_order = '01-JAN-2103';
commit;

desc furnishings;
-- =============================================================================
-- Chapter 13
-- =============================================================================
-- -----------------------------------------------------------------------------
--ROLLUP 1 C O L U M N
-- -----------------------------------------------------------------------------
-- find some rows to deal with
SELECT room_style, room_type, sq_ft
FROM ship_cabins
WHERE ship_cabin_id < 7
AND ship_cabin_id   > 3
ORDER BY 1;

SELECT room_style, room_type, sum(sq_ft)
FROM ship_cabins
WHERE ship_cabin_id < 7
AND ship_cabin_id   > 3
group by room_style, room_type
ORDER BY 1;




SELECT room_style,room_type, count(*), sum(sq_ft)
FROM ship_cabins
WHERE 1=1 
--and ship_cabin_id < 7
--and ship_cabin_id   > 3
group by room_style,room_type
ORDER BY 1;

SELECT room_style,count(*), sum(sq_ft)
FROM ship_cabins
WHERE 1=1 
--and ship_cabin_id < 7
--and ship_cabin_id   > 3
group by room_style
ORDER BY 1;







-- single column rollup
-- types of aggregations = n+1
-- where n is the number of columns in your rollup
SELECT room_style,sum(sq_ft)
FROM ship_cabins
WHERE 1=1
--and ship_cabin_id < 7
--and ship_cabin_id   > 3
group by rollup (room_style)
ORDER BY 1;

-- two column rollup
-- types of aggregations = n(2)+1
-- where n is the number of columns in your rollup
SELECT room_style,room_type,sum(sq_ft)
FROM ship_cabins
WHERE 1=1 
--and ship_cabin_id < 7
--and ship_cabin_id   > 3
group by rollup(room_style,room_type)
ORDER BY 2 desc;

-- three column rollup
-- types of aggregations = n(3)+1=4
-- where n is the number of columns in your rollup
SELECT room_style,room_type,window, sum(sq_ft)
FROM ship_cabins
WHERE 1=1
-- and ship_cabin_id  < 7
-- and ship_cabin_id   > 3
group by rollup(room_style, room_type, window);
ORDER BY 1;

-- one column cube
-- types of aggregations  2^1=2
-- where n is the number of columns in your cube
SELECT room_style, sum(sq_ft)
FROM ship_cabins
WHERE 1=1
-- and ship_cabin_id  < 7
-- and ship_cabin_id   > 3
group by cube(room_style);

-- two column cube
-- types of aggregations 2^2=4
-- where n is the number of columns in your cube
SELECT room_style, room_type, sum(sq_ft)
FROM ship_cabins
WHERE 1=1
-- and ship_cabin_id  < 7
-- and ship_cabin_id   > 3
group by cube(room_style, room_type)
ORDER BY 1;

-- three column cube
-- types of aggregations 2^3=8
-- where n is the number of columns in your cube
SELECT room_style, room_type, window, sum(sq_ft)
FROM ship_cabins
WHERE 1=1
 and ship_cabin_id  < 7
 and ship_cabin_id   > 3
group by cube(room_style, room_type, window)
ORDER BY 1;
--Stateroom	Standard	Ocean	   205
--Suite	    Standard	Balcony	 586
--Suite	    Royal	    Balcony	1524


SELECT room_style, room_type, window, sq_ft
FROM ship_cabins
WHERE 1=1
 and ship_cabin_id  < 7
 and ship_cabin_id   > 3;
 

--
SELECT room_type, window, sum(sq_ft)
FROM ship_cabins
WHERE 1=1
 and ship_cabin_id  < 16
 and ship_cabin_id   > 12
 group by cube(room_type, window);

--
SELECT room_type, window, grouping(window), sum(sq_ft)
FROM ship_cabins
WHERE 1=1
 and ship_cabin_id  < 16
 and ship_cabin_id   > 12
 group by cube(room_type, window); 
 
--
SELECT nvl(
            decode(grouping(room_type),
                   1,upper(room_style),
                   initcap(room_style))
                   ,
            'GRAND TOTAL') room_style_formatted,      
       room_type, 
       round(sum(sq_ft),2) sum_sq_ft
FROM ship_cabins
WHERE ship_id=1
 group by rollup(room_style, room_type)
 order by room_style, room_type; 
 
 -- 520
SELECT window, room_style, room_type, sum(sq_ft) 
FROM ship_cabins2
WHERE ship_id=1
 group by grouping sets((window, room_style),(room_type),null)
 order by window, room_style, room_type; 
 
SELECT window, room_style,sum(sq_ft) 
FROM ship_cabins
WHERE ship_id=1
 group by window, room_style;
 
SELECT room_type,sum(sq_ft) 
FROM ship_cabins
WHERE ship_id=1
 group by room_type; 
 
 
create table ship_cabins2
as select * from ship_cabins;
select * 
from ship_cabins2;

insert into ship_cabins2 values(50,1,999,'Suite','Royal',null,5,1000,null);
commit;

 
 
 
 
SELECT room_type, window, sum(sq_ft)
FROM ship_cabins
WHERE 1=1
 and ship_cabin_id  < 16
 and ship_cabin_id   > 12
 group by rollup(room_type, window); 

SELECT room_style, room_type, sum(sq_ft)
FROM ship_cabins
WHERE 1=1
 and ship_cabin_id  < 7
 and ship_cabin_id   > 3
 group by cube(room_style, room_type)
 order by 1,2;




SELECT window, room_type, room_style, sum(sq_ft)
FROM ship_cabins
WHERE 1=1
 and ship_cabin_id  < 7
 and ship_cabin_id   > 3
group by rollup(window, room_type, room_style)
ORDER BY 1;





select room_style, room_type, window, sq_ft
from ship_cabins
where ship_cabin_id  < 7
 and ship_cabin_id   > 3;



SELECT room_type, SUM(sq_ft)
FROM ship_cabins
WHERE ship_cabin_id < 7
AND ship_cabin_id   > 3
GROUP BY room_type
ORDER BY 1;


-- then revisit the group by and aggregate function SUM
-- page 513 top 1 col ROOM_STYLE
SELECT room_style, SUM(sq_ft) sq_ft
FROM ship_cabins
WHERE ship_cabin_id < 7
AND ship_cabin_id   > 3
GROUP BY room_style
ORDER BY 1;

-- now try adding ROLLUP ROOM_STYLE
-- page 513 bottom 1 col
SELECT room_style, SUM(sq_ft) sq_ft
FROM ship_cabins
WHERE ship_cabin_id < 7
AND ship_cabin_id   > 3
GROUP BY rollup (room_style)
ORDER BY room_style;
-- ------------------------------------------
-- Try the same steps with ROOM_TYPE
-- ------------------------------------------
-- page 513 top 1 col ROOM_TYPE
-- find some rows to deal with
SELECT room_type,  sq_ft
FROM ship_cabins
WHERE ship_cabin_id < 7
AND ship_cabin_id   > 3
ORDER BY 1;


SELECT room_type, SUM(sq_ft) sq_ft
FROM ship_cabins
WHERE ship_cabin_id < 7
 AND ship_cabin_id   > 3
GROUP BY room_type
ORDER BY 1;

SELECT room_type,SUM(sq_ft) sq_ft
FROM ship_cabins
WHERE ship_cabin_id < 7
AND ship_cabin_id   > 3
GROUP BY rollup (room_type)
ORDER BY room_type;

-- -----------------------------------------------------------------------------
-- ROLLUP 2 C O L U M N S
-- -----------------------------------------------------------------------------
-- find some rows
SELECT room_style, room_type, sq_ft
FROM ship_cabins
WHERE ship_cabin_id < 7
AND ship_cabin_id   > 3;

-- group by ROOM_STYLE, ROOM_TYPE
SELECT room_style, room_type, SUM(sq_ft) sq_ft
FROM ship_cabins
WHERE ship_cabin_id < 7
AND ship_cabin_id   > 3
GROUP BY room_style, room_type;
ORDER BY 1, 2;

SELECT room_type, room_style, SUM(sq_ft) sq_ft
FROM ship_cabins
WHERE ship_cabin_id < 7
AND ship_cabin_id   > 3
GROUP BY room_type, room_style;
order by 1,2;

-- rollup by ROOM_STYLE, ROOM_TYPE
SELECT room_style,room_type,SUM(sq_ft) sum_sq_ft
FROM ship_cabins
WHERE ship_cabin_id < 7
AND ship_cabin_id   > 3
GROUP BY rollup (room_style, room_type)
ORDER BY 1, 2;
  
 
SELECT room_style, SUM(sq_ft) sum_sq_ft
FROM ship_cabins
WHERE ship_cabin_id < 7
AND ship_cabin_id   > 3
GROUP BY rollup (room_style)
ORDER BY room_style;
-- -----------------------------------------------------------------------------
-- ROLLUP 2 C O L U M N S Reverse column order
-- -----------------------------------------------------------------------------
-- find some rows
SELECT room_type, room_style, sq_ft
FROM ship_cabins
WHERE ship_cabin_id < 7
AND ship_cabin_id   > 3;


-- ------------------------------------------------
-- reverse the GROUP BY
SELECT room_type, room_style, SUM(sq_ft)
FROM ship_cabins
WHERE ship_cabin_id < 7
  AND ship_cabin_id   > 3
GROUP BY room_type,room_style;

-- -----------------------------------
-- rollup
SELECT room_type,room_style, SUM(sq_ft) sum_sq_ft
FROM ship_cabins
WHERE ship_cabin_id < 7
AND ship_cabin_id   > 3
GROUP BY rollup(room_type,room_style)
ORDER BY 1, 2;
-- -----------------------------------------------------------------------------
-- PAGE 514
SELECT window,room_style,room_type,sq_ft
FROM ship_cabins
WHERE ship_cabin_id < 9
AND ship_cabin_id   > 5;

SELECT window,room_style,room_type,sum(sq_ft)
FROM ship_cabins
WHERE ship_cabin_id < 9
AND ship_cabin_id   > 5
group by window,room_style,room_type;

SELECT window, room_style, room_type, SUM(sq_ft)
FROM ship_cabins
where ship_id = 1
--WHERE ship_cabin_id < 9
--AND ship_cabin_id   > 5
GROUP BY rollup(window, room_style, room_type)
ORDER BY 1,2,3;

SELECT room_style, room_type, count(sq_ft),sum(sq_ft)
FROM ship_cabins
where ship_id = 1
--WHERE ship_cabin_id < 9
--AND ship_cabin_id   > 5
GROUP BY rollup(room_style, room_type)
ORDER BY 1,2,3;


select * from ship_cabins;

SELECT window, room_style, room_type 
FROM ship_cabins
WHERE ship_cabin_id < 9
AND ship_cabin_id   > 5;

SELECT window,room_style,room_type, SUM(sq_ft)
FROM ship_cabins
WHERE ship_cabin_id < 9
AND ship_cabin_id   > 5
GROUP BY window, room_style, rollup(room_type)
ORDER BY 1,2,3;

SELECT room_style, room_type, SUM(sq_ft)
FROM ship_cabins
WHERE ship_cabin_id < 9
AND ship_cabin_id   > 5
GROUP BY room_style, rollup(room_type)
ORDER BY 1,2,3;





SELECT window,room_style,room_type, SUM(sq_ft)
FROM ship_cabins
WHERE ship_cabin_id < 9
AND ship_cabin_id   > 5
GROUP BY grouping sets (window, (room_style,room_type)),
  rollup(room_style,room_type)
ORDER BY 1,2,3;
-- -----------------------------------------------------------------------------
-- ROLLUP 3 C O L U M N S
-- -----------------------------------------------------------------------------
-- find the same rows
SELECT window, room_type,room_style, sq_ft
FROM ship_cabins
WHERE ship_cabin_id < 12
AND ship_cabin_id   > 6;

SELECT window,room_type,room_style,SUM(sq_ft)
FROM ship_cabins
WHERE ship_cabin_id < 12
AND ship_cabin_id   > 6
GROUP BY window,room_type,room_style;

SELECT room_style, room_type, window, sum(sq_ft)
FROM ship_cabins
WHERE ship_cabin_id < 7
AND ship_cabin_id   > 3
GROUP BY cube(room_style, room_type, window)
ORDER BY 1,2,3;




-- -----------------------------------
-- rollup by WINDOW, ROOM_STYLE, ROOM_TYPE
SELECT ship_cabin_id, window,room_type,room_style, sq_ft
FROM ship_cabins
WHERE ship_cabin_id < 11
AND ship_cabin_id   > 6
ORDER BY 1, 2, 3;


SELECT window,room_type,room_style,SUM(sq_ft) sum_sq_ft
FROM ship_cabins
WHERE ship_cabin_id < 11
AND ship_cabin_id   > 6
GROUP BY rollup (window,room_type,room_style)
ORDER BY 1,2,3;

SELECT * FROM ship_cabins 
WHERE ship_cabin_id < 12 
AND ship_cabin_id > 7;


-- -----------------------------------------------------------------------------
-- CUBE 1 C O L U M N
-- -----------------------------------------------------------------------------
-- find the same rows
SELECT room_style, sq_ft
FROM ship_cabins
WHERE ship_cabin_id < 7
AND ship_cabin_id   > 3;

-- -----------------------------------
-- group by ROOM_STYLE
-- -----------------------------------
SELECT room_style, SUM(sq_ft) sum_sf
FROM ship_cabins
WHERE ship_cabin_id < 7
AND ship_cabin_id   > 3
GROUP BY room_style
ORDER BY 1;
-- -----------------------------------
-- rollup by ROOM_STYLE
SELECT room_style, SUM(sq_ft) sum_sq_ft
FROM ship_cabins
WHERE ship_cabin_id < 7
AND ship_cabin_id   > 3
GROUP BY rollup (room_style)
ORDER BY 1;

-- -----------------------------------
-- cube by ROOM_STYLE
-- 1 column looks like rollup
SELECT room_style, SUM(sq_ft) sum_sq_ft
FROM ship_cabins
WHERE ship_cabin_id < 7
AND ship_cabin_id   > 3
GROUP BY cube (room_style)
ORDER BY 1;
-- -----------------------------------------------------------------------------
-- CUBE 2 C O L U M N
-- -----------------------------------------------------------------------------
-- find the same rows
SELECT room_type, room_style, sq_ft
FROM ship_cabins
WHERE ship_cabin_id < 7
AND ship_cabin_id   > 3 ;
-- -----------------------------------
-- group by ROOM_TYPE, ROOM_STYLE
SELECT room_type, room_style, SUM(sq_ft) sum_sf
FROM ship_cabins
WHERE ship_cabin_id < 7
AND ship_cabin_id   > 3
GROUP BY room_type, room_style
ORDER BY 1;
-- -----------------------------------
-- rollup by ROOM_TYPE,ROOM_STYLE
SELECT room_type,
  room_style,
  SUM(sq_ft) sum_sf
FROM ship_cabins
WHERE ship_cabin_id < 7
AND ship_cabin_id   > 3
GROUP BY rollup (room_type,room_style)
ORDER BY 1;
-- -----------------------------------
-- cube by ROOM_TYPE,ROOM_STYLE
-- 1 column looks like rollup
SELECT room_type,
  room_style,
  SUM(sq_ft) sum_sq_ft
FROM ship_cabins
WHERE ship_cabin_id < 7
AND ship_cabin_id   > 3
GROUP BY cube (room_type,room_style)
ORDER BY 1;
-- -----------------------------------
-- cube by WINDOW, ROOM_TYPE,ROOM_STYLE
SELECT window,  room_type, room_style,
  sq_ft
FROM ship_cabins
WHERE ship_cabin_id < 7
AND ship_cabin_id   > 3;
SELECT window,
  room_type,
  room_style,
  SUM(sq_ft) sum_sq_ft
FROM ship_cabins
WHERE ship_cabin_id < 7
AND ship_cabin_id   > 3
GROUP BY cube (window,room_type,room_style);


select window,room_type,room_style
from ship_cabins
where ship_cabin_id > 4
AND ship_cabin_id   < 8;

select window,room_type,room_style, sum(sq_ft)
from ship_cabins
where ship_cabin_id > 4
AND ship_cabin_id   < 8
group by cube (window,room_type,room_style);



-- ORDER BY 1;
-- -----------------------------------------------------------------------------
-- GROUPING ROLLUP 2 C O L U M N  page 516
-- -----------------------------------------------------------------------------
SELECT room_style, room_type
FROM ship_cabins
WHERE ship_id = 1
ORDER BY 1,2;

SELECT room_style, room_type, SUM(sq_ft) sf
FROM ship_cabins
WHERE ship_id = 1
GROUP BY cube (room_style, room_type)
ORDER BY 1,2;
-- -----------------------------------------------------------------------------
-- GROUPING ROLLUP 2 C O L U M N  page 517
-- -----------------------------------------------------------------------------
SELECT grouping(room_style), 
        room_style, room_type,
        SUM(sq_ft) sum_sq_ft
FROM ship_cabins
WHERE ship_id = 1
GROUP BY rollup(room_style, room_type)
ORDER BY room_style, room_type;

-- how many 1's
SELECT grouping(room_type), 
        room_style, room_type,
        SUM(sq_ft) sum_sq_ft
FROM ship_cabins
WHERE ship_cabin_id < 7
  and ship_cabin_id > 4
GROUP BY cube(room_style, room_type)
ORDER BY room_style, room_type;

SELECT grouping(room_style), 
        room_style, room_type,
        SUM(sq_ft) sum_sq_ft
FROM ship_cabins
WHERE ship_cabin_id < 7
  and ship_cabin_id > 4
GROUP BY cube(room_type, room_style)
ORDER BY room_style, room_type;


SELECT   WINDOW,
        -- grouping(window), 
        room_style, room_type,
        SUM(sq_ft) sum_sq_ft
FROM ship_cabins
WHERE ship_cabin_id < 7
  and ship_cabin_id > 5
GROUP BY cube(window,room_type, room_style);
ORDER BY window, room_style, room_type;

1.  0     0     0
2.  0     X     0
3.  0     0     X     
4.  X     0     0
5.  X     X     0
6.  0     X     X
7.  X     0     X
8.  X     X     X

SELECT ship_cabin_id,window, room_style, room_type
FROM ship_cabins
WHERE ship_cabin_id < 7
  and ship_cabin_id > 5
ORDER BY window,room_style, room_type;  
  
 
select nvl(decode
                  (grouping(room_type),
                              1,    upper(room_style),
                              initcap(room_style)
                   )
       , 'GRAND TOTAL') 
       room_style_formatted,
       room_type,
       round(sum(sq_ft),2) sum_sq_ft
FROM ship_cabins
WHERE ship_cabin_id < 7
  and ship_cabin_id > 4
GROUP BY ROLLUP(ROOM_STYLE, ROOM_TYPE)  
ORDER BY room_style, room_type;

0   0
0   X
X   X

select room_style, room_type
from ship_cabins
WHERE ship_cabin_id < 7
  and ship_cabin_id > 4;


SELECT NVL(DECODE (grouping(room_type),1, upper(room_style),initcap(room_style)),
       'GRAND TOTAL') room_style, NVL(room_type,'Sub Total') room_type,
        SUM(sq_ft) sum_sq_ft
FROM ship_cabins
WHERE ship_cabin_id < 7
  and ship_cabin_id > 4
GROUP BY rollup(room_style, room_type);






-- -----------------------------------------------------------------------------
-- GROUPING SETS page 519
-- -----------------------------------------------------------------------------
SELECT window,
  room_style,
  room_type,
  SUM(sq_ft)
FROM ship_cabins
WHERE ship_id = 1
GROUP BY cube (window, room_style, room_type)
ORDER BY 1,2,3;
SELECT window,
  room_style,
  room_type,
  SUM(sq_ft) sum_sq_ft
FROM ship_cabins
WHERE ship_id_cabin = 1
GROUP BY grouping sets ((window, room_style), room_type, NULL)
ORDER BY 1,2,3;
SELECT window,
  room_style,
  room_type,
  sq_ft
FROM ship_cabins
WHERE ship_cabin_id < 7
AND ship_cabin_id   > 3;

SELECT window,room_style,room_type, SUM(sq_ft)
FROM ship_cabins
WHERE ship_cabin_id < 7
AND ship_cabin_id   > 3
GROUP BY cube(window,room_style,room_type)
ORDER BY 1,2,3;

SELECT window,room_style,room_type,SUM(sq_ft) sum_sq_ft
FROM ship_cabins
WHERE ship_cabin_id < 7
AND ship_cabin_id   > 3
GROUP BY grouping sets ((window, room_style), room_type, NULL)
ORDER BY 1,2,3;

SELECT window,room_style,room_type,SUM(sq_ft) sum_sq_ft
FROM ship_cabins
WHERE ship_cabin_id < 7
AND ship_cabin_id   > 3
GROUP BY grouping sets ((window, room_style), room_type, null)
ORDER BY 1,2,3;

SELECT window,room_style,room_type,SUM(sq_ft) sum_sq_ft
FROM ship_cabins
WHERE ship_cabin_id < 7
AND ship_cabin_id   > 3
GROUP BY grouping sets (window, (room_style, room_type), null)
ORDER BY 1,2,3;

SELECT window,room_style,room_type
FROM ship_cabins
WHERE ship_cabin_id < 7
AND ship_cabin_id   > 3;

SELECT p.category,
  p.product,
  p.deck_id,
  SUM(p.qty) sum_qty
FROM provisions p
JOIN decks d
ON p.deck_id = d.deck_id
GROUP BY grouping sets ((p.category,p.product),(p.deck_id))
ORDER BY 1,2,3;
-- -----------------------------------
SELECT grouping(window),
  grouping(room_type),
  grouping(room_style),
  SUM(sq_ft) sum_sq_ft
FROM ship_cabins
WHERE ship_id     = 1
AND ship_cabin_id < 7
AND ship_cabin_id > 3
GROUP BY window,
  rollup(room_type,room_style)
ORDER BY window,
  room_style,
  room_type;
-- -----------------------------------
SELECT window,
  room_type,
  room_style,
  SUM(sq_ft) sum_sq_ft
FROM ship_cabins
WHERE ship_id     = 1
AND ship_cabin_id < 6
GROUP BY window,
  room_type,
  room_style
ORDER BY window,
  room_style,
  room_type;
-- -----------------------------------------------------------------------------
-- cube compare
-- -----------------------------------
SELECT room_style,
  room_type
FROM ship_cabins
WHERE ship_id     = 1
AND ship_cabin_id < 6
ORDER BY room_style,
  room_type;
SELECT room_style,
  room_type,
  SUM(sq_ft) sum_sq_ft
FROM ship_cabins
WHERE ship_id     = 1
AND ship_cabin_id < 6
GROUP BY cube(room_style,room_type)
ORDER BY room_style,
  room_type;
-- -----------------------------------
-- page 513 bottom 3 cols
SELECT window,
  room_style,
  room_type
FROM ship_cabins
WHERE ship_id     = 1
AND ship_cabin_id < 6;
SELECT window,
  room_style,
  room_type,
  SUM(sq_ft) sq_ft
FROM ship_cabins
WHERE ship_id     = 1
AND ship_cabin_id < 6
GROUP BY rollup(window,room_style, room_type)
ORDER BY window,
  room_style,
  room_type;
-- -----------------------------------
SELECT window,
  room_style,
  room_type
FROM ship_cabins
WHERE ship_id     = 1
AND ship_cabin_id < 6;
SELECT window,
  room_style,
  room_type,
  SUM(sq_ft) sq_ft,
  grouping(window)     AS wd,
  grouping(room_style) AS rs,
  grouping(room_type)  AS rt
FROM ship_cabins
WHERE ship_id     = 1
AND ship_cabin_id < 6
GROUP BY rollup(window,room_style, room_type)
ORDER BY window,
  room_style,
  room_type;
-- -----------------------------------
-- page 514 multple rollups (see bullets)
SELECT room_style,
  room_type,
  SUM(sq_ft) sum_sq_ft
FROM ship_cabins
WHERE ship_id = 1
GROUP BY rollup(room_type),
  rollup(room_style)
ORDER BY room_style,
  room_type;
-- -----------------------------------
SELECT window,
  room_style,
  room_type,
  SUM(sq_ft) sum_sq_ft
FROM ship_cabins
WHERE ship_id = 1
GROUP BY rollup(window),
  rollup(room_type),
  rollup(room_style);
order by room_style,
room_type;
-- -----------------------------------
-- page 514 group by and rollup
SELECT window,
  room_style,
  room_type,
  SUM(sq_ft) sum_sq_ft
FROM ship_cabins
WHERE ship_id = 1
GROUP BY window,
  rollup (room_style, room_type)
ORDER BY window,
  room_style,
  room_type;
-- -----------------------------------------------------------------------------
--CUBE
-- -----------------------------------------------------------------------------
SELECT *
FROM ship_cabins
WHERE ship_id     = 1
AND ship_cabin_id < 10;

-- page 516 cube 1 col
SELECT room_type,
  SUM(sq_ft) sq_ft
FROM ship_cabins
WHERE ship_id     = 1
AND ship_cabin_id < 10
GROUP BY cube (room_type)
ORDER BY room_type;
-- -----------------------------------
SELECT room_style,
  SUM(sq_ft) sq_ft
FROM ship_cabins
WHERE ship_id = 1
GROUP BY cube (room_style)
ORDER BY room_style;
-- -----------------------------------
-- group by cube
-- -----------------------------------
SELECT room_style,
  room_type
FROM ship_cabins
WHERE ship_id     = 1
AND ship_cabin_id < 9
AND ship_cabin_id > 5
ORDER BY room_style,
  room_type;
-- page 516 cube 2 col
SELECT room_style,
  room_type,
  SUM(sq_ft) sq_ft
FROM ship_cabins
WHERE ship_id     = 1
AND ship_cabin_id < 9
AND ship_cabin_id > 5
GROUP BY cube(room_style, room_type)
ORDER BY room_style,
  room_type;
-- ------------------------------------------------
SELECT window,
  room_style,
  room_type
FROM ship_cabins
WHERE ship_id     = 1
AND ship_cabin_id < 9
AND ship_cabin_id > 5
ORDER BY room_style,
  room_type;
SELECT window,
  room_style,
  room_type,
  SUM(sq_ft) sq_ft
FROM ship_cabins
WHERE ship_id     = 1
AND ship_cabin_id < 9
AND ship_cabin_id > 5
GROUP BY window,
  cube(room_style, room_type)
ORDER BY room_style,
  room_type;
-- ------------------------------------------------
-- double cube
-- page 516 cube 2 col multiple cubes
SELECT room_style,
  room_type,
  SUM(sq_ft) sq_ft
FROM ship_cabins
WHERE ship_id = 1
GROUP BY cube(room_style),
  cube(room_type)
ORDER BY room_style,
  room_type;
-- page 516 cube 3 col
SELECT window,
  room_style,
  room_type,
  SUM(sq_ft) sq_ft
FROM ship_cabins
WHERE ship_id = 1
GROUP BY cube(window,room_style,room_type)
ORDER BY window,
  room_style,
  room_type;
SELECT window,
  room_style,
  room_type,
  SUM(sq_ft) sq_ft
FROM ship_cabins
WHERE ship_id = 1
GROUP BY window,
  cube (room_style,room_type)
ORDER BY window,
  room_style,
  room_type;
-- -----------------------------------------------------------------------------
--GROUPING FUNCTION
-- -----------------------------------------------------------------------------
-- page 517 grouping function 1 cols
SELECT grouping(room_type),
  room_type ,
  SUM(sq_ft) sq_ft
FROM ship_cabins
WHERE ship_id = 1
GROUP BY rollup (room_type)
ORDER BY room_type;
-- page 517 grouping function 2 cols
SELECT grouping(room_style) ,
  grouping(room_type),
  room_style,
  room_type,
  SUM(sq_ft) sq_ft
FROM ship_cabins
WHERE ship_id = 1
GROUP BY rollup (room_style, room_type)
ORDER BY room_style,
  room_type;
-- page 517 grouping function 3 cols
SELECT grouping(window) ,
  grouping(room_style) ,
  grouping(room_type) ,
  window ,
  room_style ,
  room_type ,
  SUM(sq_ft) sq_ft
FROM ship_cabins
WHERE ship_id = 1
GROUP BY rollup (window,room_style, room_type)
ORDER BY window,
  room_style,
  room_type;
-- page 518 rollup
SELECT -- grouping(room_style),
  -- grouping(room_type),
  DECODE(grouping(room_style), 1,'ALL STYLES', room_style) style,
  DECODE(grouping(room_type), 1,'ALL TYPES', room_type) type,
  SUM(sq_ft) sq_ft
FROM ship_cabins
WHERE ship_cabin_id < 7
AND ship_cabin_id   > 3
GROUP BY rollup (room_style, room_type)
ORDER BY room_style;
-- page 518 cube
SELECT DECODE(grouping(room_style), 1,'ALL STYLES', room_style) style,
  DECODE(grouping(room_type), 1,'ALL TYPES', room_type) type,
  SUM(sq_ft) sq_ft
FROM ship_cabins
WHERE ship_id = 1
GROUP BY cube (room_style, room_type)
ORDER BY room_style;
-- -----------------------------------------------------------------------------
--GROUPING SETS
-- -----------------------------------------------------------------------------
-- page 520
SELECT NVL(window,' ') ,
  NVL(room_style,' ') ,
  NVL(room_type,' ') ,
  SUM(sq_ft) sq_ft
FROM ship_cabins
WHERE ship_id = 1
GROUP BY grouping sets ((window,room_style), (room_type), NULL)
ORDER BY window,
  room_style,
  room_type;
-- -----------------------------------------------------------------------------
-- HANDS ON EXERCISES
-- -----------------------------------------------------------------------------
CREATE TABLE divisions
  (
    division_id CHAR(3) CONSTRAINT divisions_pk PRIMARY KEY,
    nameVARCHAR2(15) NOT NULL
  );
DROP TABLE divisions;
DROP TABLE jobs;
DROP TABLE employees2;
CREATE TABLE jobs
  (
    job_id CHAR(3) CONSTRAINT jobs_pk PRIMARY KEY,
    name   VARCHAR2(20) NOT NULL
  );
CREATE TABLE employees2
  (
    employee_id INTEGER CONSTRAINT employees2_pk PRIMARY KEY ,
    division_id CHAR(3)CONSTRAINT employees2_fk_divisions REFERENCES divisions(division_id) ,
    job_idCHAR(3) REFERENCES jobs(job_id) ,
    first_nameVARCHAR2(10) NOT NULL ,
    last_name VARCHAR2(10) NOT NULL,
    salaryNUMBER(6, 0)
  );
SELECT * FROM employees2;
SELECT * FROM jobs;
SELECT * FROM divisions;
-- 1
-- Group the salary (employees2) by job name (jobs)
SELECT name,
  SUM(salary)
FROM employees2
JOIN jobs USING (job_id)
GROUP BY name;
SELECT name,
  SUM(salary)
FROM employees2
JOIN jobs USING (job_id)
GROUP BY rollup(name);
-- with a grand total
SELECT name,
  SUM(salary)
FROM employees2
JOIN jobs USING (job_id)
GROUP BY rollup (name);
-- 2
-- calculate total number of days and cost by purpose with grand totals
SELECT *
FROM projects;
SELECT NVL(purpose,'----TOTAL----') ,
  SUM(project_cost),
  SUM(days)
FROM projects
GROUP BY rollup (purpose);
SELECT purpose,
  SUM(project_cost),
  SUM(days)
FROM projects
GROUP BY rollup (purpose);
-- 3
-- calculate total number of days and total cost by ship_name with grand totals
SELECT NVL(ship_name,'--TOTALS---'),
  SUM(project_cost),
  SUM(days)
FROM projects
JOIN ships USING(ship_id)
GROUP BY rollup (ship_name);
SELECT ship_name,
  SUM(project_cost),
  SUM(days)
FROM projects
JOIN ships USING (ship_id)
GROUP BY rollup (ship_name);
-- 4
-- Get the total salary by division (employees2)
-- how many rows does your SQL return?
SELECT name,
  SUM(salary)
FROM employees2
JOIN divisions USING (division_id)
GROUP BY rollup (name)
ORDER BY 1;
-- 5
-- Get the total salary by job_id (employees2) no grand total
-- how many rows does your SQL return?
SELECT job_id,
  SUM(salary)
FROM employees2
GROUP BY job_id;
-- 6
-- Get the total salary by division (employees2) with grand total
-- how many rows does your SQL return?
SELECT division_id,
  SUM(salary)
FROM employees2
GROUP BY rollup(division_id);
-- 7
-- Sum salary by division name and job name with no grand total
SELECT j.name,
  d.name,
  SUM(salary)
FROM employees2 e
JOIN jobs j
ON e.job_id=j.job_id
JOIN divisions d
ON e.division_id = d.division_id
GROUP BY rollup (j.name, d.name);
SELECT NVL(d.name,' TOTALS ') ,
  NVL(j.name,'SUB TOTALS') ,
  SUM(salary)
FROM employees2 e
JOIN jobs j
ON e.job_id=j.job_id
JOIN divisions d
ON e.division_id = d.division_id
GROUP BY rollup (d.name, j.name);
SELECT divisions.name div,
  jobs.name job,
  SUM(salary)
FROM employees2
JOIN jobs USING(job_id)
JOIN divisions USING (division_id)
GROUP BY (divisions.name, jobs.name)
ORDER BY 1;
-- 8
-- Sum salary by division name and job name with grand total
-- and superaggregate rows for just divisions
SELECT NVL(d.name,'GRAND TOTALS') div ,
  j.name job,
  SUM(salary)
FROM employees2
JOIN jobs j USING(job_id)
JOIN divisions d USING (division_id)
GROUP BY rollup (d.name, j.name)
ORDER BY d.name;
SELECT divisions.name div,
  jobs.name job,
  SUM(salary)
FROM employees2
JOIN jobs USING(job_id)
JOIN divisions USING (division_id)
GROUP BY rollup (divisions.name, jobs.name)
ORDER BY 1;
-- 9 Sum salary by division name and job name with grand total
-- and superaggregate rows for both division and job names.
-- How many rows total does your SQL return
-- What is the value for all operations
-- what is the value for all technologists
SELECT NVL(divisions.name,'GRAND TOTALS') div,
  jobs.name job,
  SUM(salary)
FROM employees2
JOIN jobs USING(job_id)
JOIN divisions USING (division_id)
GROUP BY cube (divisions.name, jobs.name)
ORDER BY divisions.name;
-- 10.
-- Show the total salary for all combinations of division and job names
-- and show the values --ALL DIVISIONS--, --ALL JOBS-- in the appropriate
-- places.
-- How many rows show --ALL DIVISIONS--.
-- How many rows show --ALL JOBS--.
SELECT DECODE(grouping(divisions.name), 1, 'ALL DIVISIONS',divisions.name) div ,
  DECODE(grouping(jobs.name), 1, 'ALL JOBS', jobs.name) job ,
  SUM(salary)
FROM employees2
JOIN jobs USING(job_id)
JOIN divisions USING (division_id)
GROUP BY cube (divisions.name, jobs.name)
ORDER BY divisions.name ;
       
  
select  grouping(room_style), room_style, room_type, sum(sq_ft) 
from ship_cabins
group by rollup (room_style, room_type);    
 
 
select  grouping(room_style), room_style, grouping(room_type),room_type,  sum(sq_ft) 
from ship_cabins
group by rollup (room_style, room_type);        
-- page 518
select nvl (
              decode(grouping(room_type),1, upper(room_style),
                   lower(room_style)),
              'GRAND TOTAL') room_style_formatted,
      room_type,
      round(sum(sq_ft),2) sum_sq_ft
from ship_cabins
group by rollup (room_style, room_type)
order by room_style, room_type;
                   


select window, room_style, room_type
from ship_cabins
group by cube (window, room_style, room_type)
order by 1,2,3;


select window, room_style, room_type, sum(sq_ft)
from ship_cabins
group by cube (window, room_style, room_type)
order by 1,2,3;

select window, room_style, room_type, sum(sq_ft)
from ship_cabins
where ship_cabin_id > 3
and ship_cabin_id < 7 
group by grouping sets (null,(window, room_style), (room_type))
order by 1,2,3;

select window, room_style, sum(sq_ft)
from ship_cabins
where ship_cabin_id > 3
and ship_cabin_id < 7 
group by window, room_style
order by 1,2;

select room_type, sum(sq_ft)
from ship_cabins
where ship_cabin_id > 3
and ship_cabin_id < 7 
group by room_type
order by 1;