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

--Tools > Preferences > Utilities > Worksheet > Open a Worksheet on connect

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
-- f. LIKE activates wildcards  
--      %     any number of characters
--      _     just one of any kind of character
-- -----------------------------
select title 
from books
where title like '%WOK%';
-- -----------------------------
-- g.  The single underscore
-- -----------------------------
select port_name
from ports
where port_name like 'San____'
-- -----------------------------------------------------------------------------
-- h. NULL IN THE WHERE CLAUSE
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
-- 3. THREE WAYS TO ORDER BY 
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
-- 4. ORDERING MIX and MATCH
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
-- 5. Ordering by an expression 
-- -----------------------------
-- a. Expression is in the where clause
-- -----------------------------
select title, retail, cost
from books
order by round((retail-cost)/cost,2)*100;
-- -----------------------------------------------------------------------------
-- 6. CLASSROOM EXERCISES 
-- -----------------------------------------------------------------------------
-- HANDS ON ASSIGNMENTS CHAPTER 5
-- -----------------------------
/* CE1.  Return port_id, port_name, capacity
    for ports that start with either "San" or "Grand"
    and have a capacity of 4.
*/
select * from ports;
-- ---------------------------------------
-- Technique 1 
select port_id, port_name, capacity
from ports 
where  port_name like 'San%' and capacity = 4
      or port_name like 'Grand%' and capacity = 4; 
-- ---------------------------------------
-- Technique 2 
select port_id, port_name, capacity
from ports
where (
        port_name like 'San%'
        or port_name LIKE 'Grand%'
      )
 and capacity = 4;

-- ---------------------------------------
/* CE2. Return vendor_id, name, and category
      where the category is either 'supplier', 
      or 'subcontractor' or ends with 'partner'.
*/
select * from vendors;
-- ---------------------------------------
-- Technique 1 
select vendor_id,vendor_name, category
from vendors
where category in ('Supplier','Sub Contractor')
    or category like '%Partner';
-- ---------------------------------------
-- Technique 2 
select vendor_id,vendor_name, category
from vendors
where category = 'Supplier'
     or category = 'Sub Contractor'
     or category like '%Partner';

-- -----------------------------
/* CE3. Return room_number and style from ship_cabins
      where there is no window or the balcony_sq_ft = null;
*/
select * from ship_cabins;
-- ---------------------------------------
-- Technique 1 
select room_number, room_style
from ship_cabins
where window = 'None'
  or balcony_sq_ft is null;

-- ---------------------------------------
-- Technique 2 
select room_number,
  room_style
from ship_cabins
where window = 'None'
or balcony_sq_ft is null;

-- -----------------------------
/* CE4. Return ship_id, ship_name, capacity, length
      from ships where 2052 <= capacity <= 3000
      and the length is either 100 or 855
      and the ship begins with "Codd"
*/
select * from ships;
-- ---------------------------------------
-- Technique 1 
select ship_id,ship_name, capacity, length
from ships
where capacity between 2052 and 3000
and length in (100,855)
and ship_name like 'Codd_%';
-- ---------------------------------------
-- Technique 2 
select ship_id,ship_name, capacity, length
from  ships
where capacity >= 2052 and capacity <= 3000
and length in (100,855)
and ship_name like 'Codd_%';

-- -----------------------------
-- SETUP FOR NEXT Question
select * from ships;
alter table ships add lifeboats integer; -- more in Chapter 11
update ships SET lifeboats = 82   where ship_name = 'Codd Crystal';
update ships SET lifeboats = 95   where ship_name = 'Codd Elegance';
update ships SET lifeboats = 75   where ship_name = 'Codd Champion';
update ships SET lifeboats = 115  where ship_name = 'Codd Victorious';
update ships SET lifeboats = 76   where ship_name = 'Codd Grandeur';
update ships SET lifeboats = 88   where ship_name = 'Codd Prince';
update ships SET lifeboats = 80   where ship_name = 'Codd Harmony';
update ships SET lifeboats = 92   where ship_name = 'Codd Voyager';
commit;
-- -----------------------------
/*CE5. Return ship_id, name, lifeboats, capacity
      from ships where the name is either "Codd Elegance","Codd Victorious"
      and 80 <= lifeboats <= 100
      and capacity / lifeboats > 25
*/
select * from ships;
-- ---------------------------------------
-- Technique 1 
select ship_id, ship_name, lifeboats, capacity
from ships
where (ship_name = 'Codd Elegance'
  or ship_name     = 'Codd Victorious')
  and lifeboats between 80 and 100
  and capacity / lifeboats > 25;
-- ---------------------------------------
-- Technique 2 
select ship_id, ship_name, lifeboats, capacity
from ships
where ship_name         in ('Codd Elegance','Codd Victorious')
  and (lifeboats >= 80
  and lifeboats <=100)
  and capacity / lifeboats > 25;
-- -----------------------------
/*CE6. Create ER DIAGRAM for BOOKS
*/
-- Open the system connection
create user mybooks identified by mybooks;
grant all privileges to mybooks; 
-- Now create the Connection in SQL Developer called mybooks
-- Open the mybooks connection and run this
create table customers as select * from books.customers;
create table orders as select * from books.orders;
create table orderitems as select * from books.orderitems;
create table books as select * from books.books;
create table bookauthor as select * from books.bookauthor;
create table author as select * from books.author;
create table promotion as select * from books.promotion;
create table publisher as select * from books.publisher;

alter table customers add primary key(customer#); 
alter table orders add primary key(order#);
alter table orderitems add primary key(order#, item#);
alter table books add primary key(isbn);
alter table bookauthor add primary key(isbn,authorid);
alter table author add primary key(authorid);
alter table publisher add primary key(pubid);


alter table orders add constraint cust_fk foreign key(customer#) references customers(customer#);
alter table orderitems add constraint ord_fk foreign key (order#) references orders(order#);
alter table orderitems add constraint bk_fk foreign key (isbn) references books(isbn);
alter table bookauthor add constraint book_fk foreign key (isbn) references books(isbn);
alter table bookauthor add constraint auth_fk foreign key (authorid) references author(authorid);
alter table books add constraint pub_fk foreign key (pubid) references publisher(pubid);

-- --------------------------------------------
-- Learning Joins
-- --------------------------------------------
/*
  As it turns out you actually are not required to have a foreign key
  from the child table to the parent table in order to do joins.
  
  However it is a best practice

  We learn much more about foreign key constraints soon.
  But this will get everyone caught up for now.
*/
-- Table Creation
-- Create the parent table 1st.
-- The child's foreign key cannot be created until the
-- parent's primary key is in place.
create table cust 
(
  custid     integer primary key,
  custname   varchar2(25)
);
-- Now you can create the child table and 
-- create the constraint that references the parent's primary key
create table ords
(
  oid         integer primary key,
  cid         integer,
  ship_st     char(2),
  constraint cust_fk foreign key(cid) references cust(custid)
);
-- Table Insertions
-- To prevent orphans the foreign key says we have to add the parent
-- record first.
insert into cust values(5000, 'Fred');
insert into cust values(5001,	'Wilma');
insert into cust values(5002,	'Barney');
-- then the children
insert into ords values (100,	5000,	'FL');
insert into ords values (101,	5002,	'FL');
insert into ords values (102,	5002,	'FL');
insert into ords values (103,	5000,	'TX');
commit;
-- -----------------------------------------------------------------------------
-- The catesean product or cross join
-- in and of itself is rarely useful in business logic.
-- However it is an excellent way to understand all the other joins.
-- If you pull up the spreadsheet and review the steps we went through
-- Here's what we did.
/*

Table No. 1

     CUST	
CUSTID	  CUSTNAME
5000	    Fred
5001	    Wilma
5002	    Barney

Table No. 2

      ORDS		
OID	  CID	  SHIP_STATE
100	  5000	  FL
101	  5002	  FL
102	  5002	  FL
103	  5000	  TX

Every Join begins with the following caretesean product of the tables
which is a complete set of all possible combinations
of each row from Table No.1 with every row of Table No. 2.

Here we walk though this process manually to illustrate 
and hopefully add an intuitive guide.
-- --------------------------------------------------------
1. First copy all headings from the Table No. 1 into the Cartesen Product
   result set.

Cartesean Result Set
  CUSTID	  CUSTNAME

-- --------------------------------------------------------
2. Next all column headings from Table No. 2 into the Cartesean Product
   result set.
   
Cartesean Result Set
  CUSTID	  CUSTNAME      OID	      CID	      SHIP_STATE


NOTE: the number of resulting column headins in cartesean product = 
        Number columns Table No. 1
              +
        Number columns Table No. 2
        ==============================
        2 + 3 = 5
-- --------------------------------------------------------
3. Manually copy the Row No. 1 from the first table 

Cartesean Result Set
CUSTID	  CUSTNAME      OID	      CID	      SHIP_STATE
5000	    Fred

-- --------------------------------------------------------
4. Now create new rows that combine all rows in the second table
   with Row No. 1 from the first table

Cartesean Result Set
CUSTID	  CUSTNAME      OID	      CID	      SHIP_STATE
5000	    Fred          100	      5000	    FL
5000	    Fred          101	      5002	    FL
5000	    Fred          102	      5002	    FL
5000	    Fred          103	      5000	    TX

NOTE: the number of resulting rows for EACH row in Table No. 1 = 
        1 Row Table No. 1
              *
        Number rows in Table No. 2
        ==================================================
        1 * 4 = 4
-- --------------------------------------------------------
5. Repeat this pattern for Row No. 2 in Table No. 1

Cartesean Result Set (spaces bgetween rows added for readability)
CUSTID	  CUSTNAME      OID	      CID	      SHIP_STATE
5000	    Fred          100	      5000	    FL
5000	    Fred          101	      5002	    FL
5000	    Fred          102	      5002	    FL
5000	    Fred          103	      5000	    TX

5001	    Wilma         100	      5000	    FL
5001	    Wilma         101	      5002	    FL
5001	    Wilma         102	      5002	    FL
5001	    Wilma         103	      5000	    TX
   
5002	    Barney        100	      5000	    FL
5002	    Barney        101	      5002	    FL
5002	    Barney        102	      5002	    FL
5002	    Barney        103	      5000	    TX
   
NOTE: Finally note total number of rows in teh cartesean product = 
        Number Rows Table No. 1
              *
        Number rows in Table No. 2
        ==================================================
        3 * 4 = 12
-- --------------------------------------------------------        
That was the manual version of what SQL does        
-- --------------------------------------------------------
*/
-- --------------------------------------------------------
-- 6. Here a cartesean product in SQL
select *
from cust, ords;
-- --------------------------------------------------------
-- 7. Our first business-useful join to learn is called 
--    OLD SCHOOL INNER EQUI-JOIN
-- 
--      "INNER": means rows returned for which WHERE is TRUE 
--        on the intermediate CARTESEAN PRODUCT
--      "EQI": means WHERE uses equality in WHERE 
--    We add a where clause to return all customers
--    with all their orders
select *
from cust, ords
where cust.custid = ords.cid;
-- So it looks like both Fred and Barney each had 2 orders.
-- --------------------------------------------------------
-- 8. If we want to list only Fred's orders we add an AND
--    to the where clause
--    OLD SCHOOL INNER EQUI-JOIN adding Fred
select *
from cust, ords
where cust.custid = ords.cid
  and cust.custname = 'Fred';
-- --------------------------------------------------------
-- 9. NEW SCHOOL INNER EQUI-JOIN
select *
from cust join ords
          on cust.custid = ords.cid
          and cust.custname = 'Fred';
-- --------------------------------------------------------
-- 10.  INNER is default JOIN so the word INNER is optional
--      But may add readability.
select *
from cust INNER join ords
          on cust.custid = ords.cid
          and cust.custname = 'Fred';
-- --------------------------------------------------------
-- 11.  AN INNER NON-EQUI JOIN is rare in business
--      but here is an example for the exam
--      "INNER": rows for which WHERE is TRUE 
--        on the intermediate CARTESEAN PRODUCT
--      "EQI": means WHERE uses equality 
select title, gift
from books, promotion
where books.retail between promotion.minretail and promotion.maxretail;

create table movies 
 ( movie_id integer,
   movie_name varchar2(50),
   constraint movie_pk primary key (movie_id)
   );
   
create table role 
 ( role_id integer,
   aid integer,
   mid integer,
   constraint role_pk primary key (role_id),
   constraint aid_fk foreign key (aid) references actors (actor_id),
   constraint mid_fk foreign key (mid) references movies (movie_id),
   constraint role_type check (category in ('Lead', 'Supporting','Cameo'))
   );   
   
create table actors 
 ( actor_id integer,
   actor_fname varchar2(50),
   actor_lname varchar2(50)
   );