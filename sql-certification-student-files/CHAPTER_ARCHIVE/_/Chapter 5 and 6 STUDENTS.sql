-- =============================================================================
--  CHAPTER 5
/*
  Limit the Rows That Are Retrieved by a Query
  Sort the Rows That Are Retrieved by a Query
*/
-- -----------------------------------------------------------------------------
-- 1. THE WHERE CLAUSE REVISITED
--    Always just one question that is answered by TRUE or FALSE
--    Can have multiple parts using relational operators
--    Hint:
--    1. On Page 172 Table 5-1 write note "Compare Page 354 Table 9-1"
--    2. On Page 354 Table 9-1 write note "Compare Page 172 Table 5-1"
-- -----------------------------
-- a. Equals
-- -----------------------------
Select category, title, retail, cost
from books 
where category = 'COMPUTER';
-- -----------------------------
-- b. Not Equals 
-- -----------------------------
Select category, title, retail, cost
from books 
where category != 'COMPUTER'; 
-- -----------------------------
-- c. AND and OR 
-- -----------------------------
Select category, title, retail, cost
from books 
where retail >= 40 and retail <=60
and category in 'COMPUTER' 
or category in 'FAMILY LIFE';
-- -----------------------------
-- d. IN is a shortcut for OR
-- -----------------------------
-- The OR technique
Select firstname, lastname, state
from customers
where state = 'FL'
or state = 'CA'; 
-- The IN technique
Select firstname, lastname, state
from customers
where state in ('FL', 'CA');
-- -----------------------------
-- e. BETWEEN shortcut for AND
-- -----------------------------
-- The AND technique
select port_name
from ports
where capacity >=3 
  and capacity <=4;
-- The BETWEEN technique
select port_name
from ports
where capacity between 3 and 4;
-- -----------------------------
-- g. LIKE activates wildcards  
--      %     any number of characters
--      _     just one of any kind of character
-- -----------------------------
select title 
from books
where title like '%WOK%';
-- -----------------------------
-- h.  The single underscore
-- -----------------------------
select port_name
from ports
where port_name like 'San____'
-- -----------------------------------------------------------------------------
-- i. NULL IN THE WHERE CLAUSE
-- -----------------------------
select * 
from books.orders
where shipdate is null;  -- or is not
-- -----------------------------------------------------------------------------
-- 2. ORDERING (Sorting)
-- -----------------------------
-- a. Default is ASCENDING :: Open the Cruises Connection :: asc is default
-- -----------------------------
select ship_id,  ship_name,  capacity
from ships
order by capacity;
-- -----------------------------
-- b. But you can order by descending :: desc must be added
-- -----------------------------
select ship_id,  ship_name,  capacity
from ships
order by capacity desc;
-- -----------------------------
-- c. You can order by more than one column 
-- -----------------------------
select room_style, room_type, window, sq_ft
from ship_cabins
order by room_style, room_type, sq_ft desc;
-- -----------------------------------------------------------------------------
-- 4. THREE WAYS TO ORDER BY 
-- -----------------------------
-- a.       1. COLUMN NAME
-- -----------------------------
select room_style, room_type, window, sq_ft
from ship_cabins
order by room_style, room_type, sq_ft desc;
-- -----------------------------
-- b.       2. COLUMN POSITION 
-- Poisiton   1             2               3           4 
-- select     room_style,   room_type,      window,     sq_ft
-- -----------------------------
-- c.       3. ALIAS 
select room_style || ' ' || room_type as room_grade, window, sq_ft
from ship_cabins
order by room_grade;
-- -----------------------------------------------------------------------------
-- 5. ORDERING MIX and MATCH
-- -----------------------------
-- a. Not very readable : but possible
-- -----------------------------
select room_style || ' ' || room_type as room grade, window, sq_ft
from ship_cabins
order by room_grade, window, 3 desc;
-- -----------------------------
-- b. ASC is the default so the word itself is optional
--    but you may see it used again for readability
-- -----------------------------
select room_style, room_type, window, sq_ft
from ship_cabins
order by room_type asc, window asc, 3 desc;
-- -----------------------------------------------------------------------------
-- 6. Ordering by an expression 
-- -----------------------------
-- a. Expression is in the where clause
-- -----------------------------
select title, retail, cost
from books
order by round((retail-cost)/cost,2)*100;
-- -----------------------------------------------------------------------------
-- 7. CLASSROOM EXERCISES 
-- =============================================================================
-- HANDS ON ASSIGNMENTS CHAPTER 5
-- -----------------------------
/* 1.  Return port_id, port_name, capacity
    for ports that start with either "San" or "Grand"
    and have a capacity of 4.
*/

-- -----------------------------
/* 2. Return vendor_id, name, and category
      where the category is either 'supplier', 
      or 'subcontractor' or ends with 'partner'.
*/

-- -----------------------------
/* 3. Return room_number and style from ship_cabins
      where there is no window or the balcony_sq_ft = null;
*/

-- -----------------------------
/* 4. Return ship_id, ship_name, capacity, length
      from ships where 2052 <= capacity <= 3000
      and the length is either 100 or 855
      and the ship begins with "Codd"
*/

-- -----------------------------
-- SETUP FOR NEXT Question
SELECT * FROM ships;
ALTER TABLE ships ADD lifeboats INTEGER;
UPDATE ships SET lifeboats = 82   WHERE ship_name = 'Codd Crystal';
UPDATE ships SET lifeboats = 95   WHERE ship_name = 'Codd Elegance';
UPDATE ships SET lifeboats = 75   WHERE ship_name = 'Codd Champion';
UPDATE ships SET lifeboats = 115  WHERE ship_name = 'Codd Victorious';
UPDATE ships SET lifeboats = 76   WHERE ship_name = 'Codd Grandeur';
UPDATE ships SET lifeboats = 88   WHERE ship_name = 'Codd Prince';
UPDATE ships SET lifeboats = 80   WHERE ship_name = 'Codd Harmony';
UPDATE ships SET lifeboats = 92   WHERE ship_name = 'Codd Voyager';
-- -----------------------------
/*5.  Return ship_id, name, lifeboats, capacity
      from ships where the name is either "Codd Elegance","Codd Victorious"
      and 80 <= lifeboats <= 100
      and capacity / lifeboats > 25
*/
