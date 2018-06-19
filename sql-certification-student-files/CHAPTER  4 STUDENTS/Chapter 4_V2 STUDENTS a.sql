-- =============================================================================
--  CHAPTER 4 version 2
/*
    DML, DDL, TCL :: Page 95
    Execute a Basic SELECT Statement
    Describe How Schema Objects Work
*/
-- -----------------------------------------------------------------------------
-- 1. SELECT BASICS 
-- -----------------------------
-- a. Simple select
-- -----------------------------
select customer#, firstname, lastname, state
from customers;
-- -----------------------------
-- b. Modify the result set 
-- -----------------------------
select title, retail, cost, retail-cost
from books;
-- -----------------------------
-- c. Changing the result set column titles use an alias
-- -----------------------------
select title, retail, cost, retail-cost as profit
from books;
-- -----------------------------
-- d. The word AS is optional
-- -----------------------------
select customer# ID, firstname || ' ' || lastname fullname
from customers;
-- -----------------------------
-- e. EVERY SQL STATEMENT IN ORACLE NEEDS A TABLE
--    DUAL is an Oracle table you can use to test expressions
-- -----------------------------
select * from dual;
-- -----------------------------
-- f. TEST MATH EXPRESSION
-- -----------------------------
select sqrt(100) from dual;
-- -----------------------------
-- g. TEST MATH ORDER OF OPERATIONS
select sqrt(100 + 200 / 50 - 4) + 2 * (4 / 12) from dual; 
-- -----------------------------
-- h. Round the output
-- -----------------------------
select round(sqrt(100 + 200 / 50 - 4) + 2 * (4 / 12),2) from dual; 
-- -----------------------------
-- i. Now you try using dual
-- The 2nd floor of the house has 984 sq ft
-- The first floor of the house has 1248 sq ft
-- Carpeting the house is priced by square yards
-- Square yards are calculated by dividing the sqaure feet by 9
-- Calculate the price to redo both the floors
-- Using carpet 4.55/Sq Yard
-- Using wood 6.25/Sq Yard




;
-- -----------------------------
-- i. Test null in the SELECT CLAUSE
-- -----------------------------
select 10 + 10 from dual; 
select 10 + null from dual; 
-- -----------------------------
-- j. DISTINCT UNIQUE
-- -----------------------------
select distinct category from books;
select unique category from books;
-- -----------------------------------------------------------------------------
-- 2. THE WHERE CLAUSE
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
where category <> 'COMPUTER'; 
-- -----------------------------
-- c. Not Equals 
-- -----------------------------
Select category, title, retail, cost
from books 
where category != 'COMPUTER'; 
-- -----------------------------
-- d. AND and OR 
-- -----------------------------
Select category, title, retail, cost
from books 
where retail >= 40 and retail <=60
and category in 'COMPUTER' 
or category in 'FAMILY LIFE';
-- -----------------------------
-- e. IN is a shortcut for OR
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
-- f. BETWEEN shortcut for AND
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
-- h. Without LIKE it is a very different question
-- -----------------------------
select title 
from books
where title = '%WOK%';
-- -----------------------------
-- i. LIKE on the wrong side? 
-- -----------------------------
select title 
from books
where '%WOK%' like title ;
-- -----------------------------
-- j.  The single underscore
-- -----------------------------
select port_name
from ports
where port_name like 'San____'
-- In case you can’t tell, that’s four underscores after San
-- -----------------------------------------------------------------------------
-- 3. NULL IN THE WHERE CLAUSE
-- -----------------------------
-- a. Finding null
-- -----------------------------
select * 
from books.orders
where shipdate = null;
-- -----------------------------
-- b. Finding not null
-- -----------------------------
select * 
from books.orders
where shipdate != null;
-- -----------------------------------------------------------------------------
-- 4 Dates not what they seem
-- -----------------------------
-- a. Insert a simple date
-- -----------------------------
create table testdate
(mydate  date);
insert into testdate values (sysdate);
-- -----------------------------
-- b. What somes back from a select statement may be different than
--    what is actually held in the table 
-- -----------------------------
select mydate from testdate;
select to_char(mydate, 'DD-MM-YYYY HH:MI:SS')
from testdate;
-- -----------------------------
-- c. How can we control this?
-- First lets look at what the current settings are
-- -----------------------------
select * from nls_database_parameters;
-- -----------------------------
-- d. Now lets alter the session parameters
-- -----------------------------
alter session 
set NLS_DATE_FORMAT = 'DD-MM-YYYY HH:MI:SS'; 
-- -----------------------------
-- e. Lets select our date again
-- -----------------------------
select mydate from testdate;
-- -----------------------------
-- f. Can we split a date apart to find just the year?
-- -----------------------------
select extract (year from mydate)
from testdate; 
-- -----------------------------
-- g. Can we split it apart to find the month?
-- -----------------------------
select extract (month from mydate)
from testdate; 
-- -----------------------------
-- h. Can we split it apart to find the month?
-- -----------------------------
select extract (day from mydate)
from testdate; 
-- -----------------------------------------------------------------------------
-- 5. PSUDEO COLUMNS
-- -----------------------------
-- a. ROWNUM This numbers the rows in the given rowlilst
--    starting at the top and moving down
-- -----------------------------
select rownum, lastname 
from customers;
-- -----------------------------
-- b. ROWNUM poses a challenge when used with order by 
--    rownum happenes before order by 
-- -----------------------------
select rownum, lastname 
from customers
order by lastname;
-- -----------------------------
-- c. OVERCOME ROWNUM ORDER BY 
--    this is handled extensively in chapter 9
-- -----------------------------
select rownum, lastname
from (
        select lastname 
        from customers
        order by lastname
     );
-- -----------------------------
-- d. ROWID
--    Displays the physical address of the row
select rowid, lastname 
from customers;
-- Copy the top row to the clipboard
-- and paste it here 
-- AAAF98AABAAAOWJAAA	MORALES
-- -----------------------------
-- e. IS ROWID IMPACTED BY ORDER BY
select rowid, lastname 
from customers
where lastname = 'MORALES'
order by lastname;
-- Memory location is on disk and does not change
-- AAAF98AABAAAOWJAAA	MORALES
-- -----------------------------------------------------------------------------
-- 6. SELECTING Literal values instead of a column name
--                           that has its own value for each row                
-- -----------------------------
-- a. What if you put a literal value in the select statement?
--    like 'APPLE'
-- -----------------------------
select 'APPLE', firstname, lastname
from customers;
-- -----------------------------
-- b. What if you left out the comma between them  then the column name
--    is seen as an alias to the literal value
-- -----------------------------
select 'APPLE' firstname, lastname
from customers;
-- -----------------------------
-- c. See any value in using this?
-- -----------------------------
select 'Customer Number:'||customer# || '  Full Name: ' || firstname || ' ' || lastname "Customer Information"
from customers;
-- -----------------------------
-- d. Some more examples
-- -----------------------------
select 'ping pong',ship_id,ship_name,capacity from ships;
select '?' from ships;
select 'ping pong' from ships;
select '---',ship_name from ships;
Select 1 from books;
-- -----------------------------------------------------------------------------
-- 7. BASIC ORDERING (Sorting)
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
-- 8. THREE WAYS TO ORDER BY 
-- -----------------------------
-- a. First is shown above by the column names
-- -----------------------------
select room_style, room_type, window, sq_ft
from ship_cabins
order by room_style, room_type, sq_ft desc;
-- -----------------------------
-- b. Second by column position in the select statement
-- Poisiton   1             2               3           4 
-- select     room_style,   room_type,      window,     sq_ft
-- -----------------------------
-- c. Third is by the alias 
--      <- These 2 are concatenated and alias is room_grade -> 
-- select room_style || ' ' || room_type         room_grade, window, sq_ft
select room_style || ' ' || room_type room_grade, window, sq_ft
from ship_cabins
order by room_grade;
-- -----------------------------------------------------------------------------
-- 9. ORDERING MIX and MATCH all three together is possible
--    but typically not done or seen because it is more readable
--    to keep the same technique for each order by element
--    here we see all three techniques used together
--    sort asc by alias, asc be column name, desc by position
-- -----------------------------
-- a. Not very readable : but possible
-- -----------------------------
select room_style || ' ' || room_type, window, sq_ft
from ship_cabins
order by room_type, window, 3 desc;
-- -----------------------------
-- b. ASC is the default so the word itself is optional
--    but you may see it used again for readability
-- -----------------------------
select room_style, room_type, window, sq_ft
from ship_cabins
order by room_type asc, window asc, 3 desc;
-- -----------------------------------------------------------------------------
-- c. The column used to order the resul set does not have
--    to be in the select statement
-- -----------------------------
-- d. Without seeing the SQL but being given the result set
--    it is not very clear why the result set is the way it is
--    Open Books connection
-- 
-- So this makes sense because we can see that rows in the result set
-- are sorted by category 
-- -----------------------------
select category, title, retail, cost
from books
order by category ;
-- -----------------------------
-- e. Now repeat but without including category in select statement
-- -----------------------------
select title, retail, cost
from books
order by category ;
-- -----------------------------------------------------------------------------
-- 7. Ordering by an expression 
-- -----------------------------
-- a. the expression is in the select clause
-- -----------------------------
select title, retail, cost, round((retail-cost)/cost,2)*100 profit
from books
order by profit;
-- -----------------------------
-- b. the expression is in the where clause
-- -----------------------------
select title, retail, cost
from books
order by round((retail-cost)/cost,2)*100;
-- =============================================================================
--  CHAPTER 5
/*
    RESTRICTING AND SORTING DATA
      Limit the Rows Retrieved vy a Query
      Sort the Rows Retrieved by a Query
      
      table 5.1 page 173
      table 9.2 page 55
*/
-- -----------------------------------------------------------------------------

