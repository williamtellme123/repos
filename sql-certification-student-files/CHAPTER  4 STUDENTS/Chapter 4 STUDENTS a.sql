-- =============================================================================
--  CHAPTER 4
/*
    DML, DDL, TCL :: Page 95
    Execute a Basic SELECT Statement
    Describe How Schema Objects Work

*/
-- -----------------------------------------------------------------------------
-- SELECT BASICS 
-- -----------------------------
-- a. Simple select
select customer#, firstname, lastname, state
from customers;
-- -----------------------------
-- b. Modify the result set 
select title, retail, cost, retail-cost
from books;
-- -----------------------------
-- c. Changing the result set column titles use an alias
select title, retail, cost, retail-cost as profit
from books;
-- -----------------------------
-- d. The word AS is optional
select customer# ID, firstname || ' ' || lastname fullname
from customers;
-- -----------------------------
-- e. EVERY SQL STATEMENT IN ORACLE NEEDS A TABLE
--    DUAL is an Oracle table you can use to test expressions
select * from dual;
-- -----------------------------
-- f. TEST MATH EXPRESSION
select sqrt(100) from dual;
-- -----------------------------
-- g. TEST MATH ORDER OF OPERATIONS
select sqrt(100 + 200 / 50 - 4) + 2 * (4 / 12) from dual; 
-- -----------------------------
-- h. Round the output
select round(sqrt(100 + 200 / 50 - 4) + 2 * (4 / 12),2) from dual; 
-- -----------------------------
-- i. Test null
select 10 + 10 from dual; 
select 10 + null from dual; 
-- -----------------------------
-- j. DISTINCT UNIQUE
select distinct category from books;
select unique category from books;
-- -----------------------------------------------------------------------------
-- 2. SELECT some non-intuitive 
-- -----------------------------
-- a. Finding null
select * 
from books.orders
where shipdate = null;
-- -----------------------------
-- b. Finding not null
select * 
from books.orders
where shipdate != null;
-- -----------------------------
-- c. Inserting an apostrophe into a table then finding it
create table apos
(phrase varchar2(50));
insert into apos values ('Hello Gov''na');
insert into apos values ('Isn''t it nice outside');
select * from apos where phrase = 'Isn''t it nice outside';
-- -----------------------------------------------------------------------------
-- 3. Dates not what they seem
-- -----------------------------
-- a. insert a simple date
create table testdate
(mydate  date);
insert into testdate values (sysdate);
-- -----------------------------
-- b. Lets have a look 
select mydate from testdate;
select to_char(mydate, 'DD-MM-YYYY HH:MI:SS')
from testdate;
-- -----------------------------
-- c. Can we split it apart to find just the year?
select extract (year from mydate)
from testdate; 
-- -----------------------------
-- d. Can we split it apart to find the month?
select extract (month from mydate)
from testdate; 
-- -----------------------------
-- e. Can we split it apart to find the month?
select extract (day from mydate)
from testdate; 
-- -----------------------------------------------------------------------------
-- 4. Psuedo Columns
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
-- d. IS ROWID IMPACTED BY ORDER BY
select rowid, lastname 
from customers
where lastname = 'MORALES'
order by lastname;
-- Memory location is on disk and does not change
-- AAAF98AABAAAOWJAAA	MORALES
-- -----------------------------------------------------------------------------
-- 4. Wierdness
-- -----------------------------
-- a. What if you put a literal value in the select statement?
--    like 'APPLE'
select 'APPLE', firstname, lastname
from customers;
-- -----------------------------
-- b. What if you left out the comma between them
select 'APPLE' firstname, lastname
from customers;
-- -----------------------------
-- c. See any value?
select 'Customer Number:'||customer# || '  Full Name: ' || firstname || ' ' || lastname "Customer Information"
from customers;

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