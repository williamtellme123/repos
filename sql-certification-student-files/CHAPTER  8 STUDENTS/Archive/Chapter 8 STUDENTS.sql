-- =============================================================================
--  CHAPTER 8
/*
-- -------------------------------------------------------------------------      
    TABLE OF CONTENTS
    0.  LIST OF CHAPTER 8 TERMS    
    1.  CARTESIAN JOIN (aka CROSS JOINS) 
    2.  INNER-EQUI JOIN
    3.  INNER-NON-EQUI JOIN
    4.  OUTER LEFT JOIN
    5.  OUTER RIGHT JOIN
    6.  OUTER FULL JOIN
*/
-- -----------------------------------------------------------------------------
--    0. LIST OF CHAPTER 8 TERMS
--     
--     OLD SCHOOL  and  NEW SCHOOL (From the SQL Citizens Almanac)
--    
--    SQL initially developed at IBM by Donald D. Chamberlin and Raymond F. Boyce in the early 1970s.
--    Called SEQUEL (Structured English QUEry Language), meant for IBM's original quasi-relational database management system, System R
--    developed during the 1970s.
--    
--    SEQUEL was later changed to SQL because it was trademark of UK-based Hawker Siddeley aircraft company.
--
--    1970s, Relational Software, (now Oracle Corporation) saw the potential of the concepts described by Codd, 
--    Chamberlin, and Boyce, and developed their own SQL-based RDBMS with aspirations of selling it 
--    to the U.S. Navy, CIA, and other U.S. agencies. In June 1979, Relational Software, Inc. introduced the first 
--    commercially available implementation of SQL, Oracle V2 (Version2) for VAX computers.
--   
--    It wasn't until 2001 that Oracle 9i was launched contaning the keyword: JOIN 
--    
--    In 2003 HP purchased Compaq, Finding Nemo was released, Ohio State Medical students were carrying Palm Pilots
--    and universities began to move towards open source databse systems:   
--          MySql 4.0
--          Redhat database 2.1
--          SAP DB 7.4
--    It would be many years before students learned the JOIN keyword.

--     The ANSI standards team defined the term JOIN in the mid 1990s
--         However it wasn't integrated into most SQL versions until early 2000s
--         
--         I call using the word JOIN in a select statement as new school syntax 
--         and performing a join without using the word join as old school syntax.
--         
--         Although new school syntax is very common now because it is now taught
--         in schools. You will see almost equal amounts of old and new everywhere. 
--
-- -----------------------------------------------------------------------------
--     JOINS ARE USED  TO ANSWER QUESTIONS REQUIRING MORE THAN 1 TABLE
--        
--        CARTESEAN (or cross join) 
--        --------------------------------
--        To Learn about other joins
--            How many rows and columns are returned from a cross join 
--            of customers and orders
--        
--        INNER (or just plain joins)
--        --------------------------------
--            EQUI: Used to find matches:
--                Boyfriend in bookstore: 
--                    "I want to buy a book for my girlfriend. Can you 
--                    tell me which authors she likes?"
--
--            NON-EQUI: Tables related but no exact match:
--                Boyfriend in bookstore: 
--                    "What gift do I get if I purchase SHORTEST POEMS?"
--        OUTER
--        --------------------------------
--        Find descrepencies
--            LEFT
--              Find all matches plus
--              All other rows in left table
--              "How many devices have not been migrated from system Legacy to Next-Gen"
--            RIGHT
--              Find all matches plus
--              All other rows in right table
--              "How many devices have been migrated from system Legacy to Next-Gen"
--            FULL
--              Find all matches plus
--              All other rows in right table plus
--              All other rows in left table
--             "Complete state of migration project"
--        
--        NATURAL
--        --------------------------------
--            Uses columns with same name
--            Not reliable :: Use is discouraged
--        
--        SELF
--        --------------------------------
--            One table 
--              Two columns 
--              Two different meanings
--            
--            Customers     
--              Customer#         Referred_by
--              Find people referred by other people
--            
--            Employees     
--              Employee#         Manager
--              List employee and managers names
--              
--            Product       
--              Product_id        Vendor_id
--              List each product that comes from two different vendors 
--
--            Stores
--              Store_id          Upline_id
--              List all of the stores under the one in Lubbock
--
--            Army     
--              Member#         Commanding_Officer#
--              List the chain of command for Private Ryan

-- =============================================================================
-- -----------------------------------------------------------------------------
--  1.  CARTESIAN JOIN (aka CROSS JOINS) 
-- -----------------------------------------------------------------------------
-- A Join used in Teaching
-- For all joins begin with cartesian product in memory
-- 1. Number rows returned as rows.table1 * rows.table2
-- 2. Number columns returned from table1 and table2
-- --------------------------------------------
select * from cust;
select * from ords;

-- Old school
    select *
    from cust, ords;
-- -------------------------------------
-- New School
    select *
    from cust cross join ords;
    
    
-- -----------------------------------------------------------------------------
-- LEARNING JOINS USING EXCEL
-- INNER



-- LEFT
select * from 
cust full join ords on custid = cid;


-- RIGHT


-- FULL



-- =============================================================================
/* 
    Now you have the basic concepts of all types of joins 
    We are now going to dive into the details
    
    Old School Joins: A SQL historian
    
    SQL initially developed at IBM by Donald D. Chamberlin and Raymond F. Boyce in the early 1970s.
    Called SEQUEL (Structured English QUEry Language), meant for IBM's original quasi-relational database management system, System R
    developed during the 1970s.
    
    SEQUEL was later changed to SQL because it was trademark of UK-based Hawker Siddeley aircraft company.

    1970s, Relational Software, (now Oracle Corporation) saw the potential of the concepts described by Codd, 
    Chamberlin, and Boyce, and developed their own SQL-based RDBMS with aspirations of selling it 
    to the U.S. Navy, CIA, and other U.S. agencies. In June 1979, Relational Software, Inc. introduced the first 
    commercially available implementation of SQL, Oracle V2 (Version2) for VAX computers.
   
    It wasn't until 2001 that Oracle 9i was launched contaning the keyword: JOIN 
    
    In 2003 HP purchased Compaq, Finding Nemo was released, Ohio State Medical students were carrying Palm Pilots
    and universities began to move towards open source databse systems:   
          MySql 4.0
          Redhat database 2.1
          SAP DB 7.4
    It would be many years before students learned the JOIN keyword.
*/
-- =============================================================================
-- -----------------------------------------------------------------------------    
-- INNER JOINS
-- -----------------------------------------------------------------------------
-- EQUI
-- -------------------------------------
-- Old school
    select lastname, firstname, order#
    from customers, orders
    where customers.customer# = orders.customer#
    and firstname = 'BONITA';
    
    select lastname, firstname, order#
    from customers c, orders o
    where c.customer# = o.customer#
    and firstname = 'BONITA';
-- -------------------------------------
-- New School Type No. 1
    select lastname, firstname, order#
    from customers c join orders o 
    on c.customer# = o.customer#
    where firstname = 'BONITA';
-- -------------------------------------
-- New School Type No. 2
    select lastname, firstname, order#
    from customers c join orders o 
    on c.customer# = o.customer# 
    and firstname = 'BONITA';
-- -------------------------------------
-- New School Type No. 3
    select lastname, firstname, order#
    from customers join orders using (customer#) 
    where firstname = 'BONITA';
-- -----------------------------------------------------------------------------
-- NON-EQUI (But still related)
-- Used when exact join is not possible
-- Salary Grade No. 6 has a min_salary = 35000 max_salary = 45000
-- A promotional gift may be given if cost minretail and maxretail 
-- -------------------------------------
-- Old School
    select title, gift 
    from books, promotion
    where cost between minretail and maxretail;
-- -------------------------------------
-- New School Type No. 1
    select title, gift 
    from books join promotion on cost between minretail and maxretail;

-- =============================================================================
-- -----------------------------------------------------------------------------  
-- OUTER JOINS
-- -----------------------------------------------------------------------------
-- LEFT
-- -------------------------------------
--    Find all matches plus
--    All other rows in left table
--      "List all customers with orders if they have them"
--    CAUTION: 
--      'from'  First (filtered at joining)
--      'where' LastPlace filtered after outer joining complete
--    TWO DIFFERENT ANSWERS
-- -------------------------------------
-- Old school
    select lastname, firstname, order#
    from customers c, orders o
    where c.customer# = o.customer#(+)
    and order# is null;
--    and firstname = 'BONITA';
-- -------------------------------------
-- New School Type No. 1
    select lastname, firstname, order#
    -- From First
    from customers c left join orders o on c.customer# = o.customer#
    where order# is null;
    and firstname = 'BONITA'; 
-- -------------------------------------
-- New School Type No. 2
    select lastname, firstname, order#, c.customer#
    -- Where? LastPlace
    from customers c left outer join orders o on c.customer# = o.customer#
    and firstname = 'BONITA'; 
-- -------------------------------------
-- New School Type No. 3 ONLY IF COLUMN NAMES SAME
    select lastname, firstname, order#, customer#
    from customers c left join orders o using (customer#)
    where firstname = 'BONITA';
    
-- -------------------------------------
-- RIGHT
-- -------------------------------------
--    Find all matches plus
--    All other rows in right table
--      "List all orders with customers if they have them"
--    CAUTION: 
--      'from'  First (filtered at joining)
--      'where' LastPlace filtered after outer joining complete
--    TWO DIFFERENT ANSWERS
-- -------------------------------------
-- Old school
    select lastname, firstname, order#
    from customers c, orders o
    where c.customer#(+) = o.customer#
    and c.customer# is null;
    
--    and order# = 1005;
    insert into orders values (5000, 4444,'01-JAN-12','17-JAN-12','123 Main','Metropolis','XX','99999');
    commit;
-- -------------------------------------
-- New School Type No. 1
    select lastname, firstname, order#
    from customers c right join orders o on c.customer# = o.customer# and order# = 1005;
-- -------------------------------------
-- New School Type No. 2
    select lastname, firstname, order#
    from customers c right join orders o on c.customer# = o.customer#
    where order# = 1005;
    
    
    
-- -------------------------------------
-- New School Type No. 3 ONLY IF COLUMN NAMES SAME
    select lastname, firstname, order#
    from customers right join orders using (customer#) 
    where order# = 1005;
    
-- =============================================================================
-- -----------------------------------------------------------------------------  
-- NATURAL JOINS
-- 
-- Only useful when columns are identical
-- Not very readable
-- Subject to hiding problems when columns are changed
-- Discourage use
select lastname, firstname, order#
    from customers natural join orders;
    where order# = 1005;
-- =============================================================================
-- -----------------------------------------------------------------------------  
-- Exercise SELF JOINS
-- List the people first and last names who referred other customers along
-- with the firsst and last names of those who were referred

select c1.firstname, c1.lastname,' referred by ', c2.firstname, c2.lastname
from customers c1 join customers c2
on c2.customer# = c1.referred;



-- =============================================================================
-- EXERCISES USE BOOKS
-- -----------------------------
-- What authors does Bonita buy?
select distinct firstname, lastname, ' Bought books written by ', fname, lname, ' titled ', title
from customers join orders using(customer#)
     join orderitems using(order#)
     join books using(isbn)
     join bookauthor using(isbn)
     join author using(authorid)
where firstname = 'BONITA';

-- -----------------------------
-- List customer first and last names order number invoice totals
-- in descending order of invoice totals
-- A. Order totals
-- 1. What tables?
--    orders has order#
--    but so does orderitems
--    where is the retail column?
--    where is the qty?
select * from orders;
select * from orderitems;
select * from books;

select order#,item#,quantity, retail, (quantity*retail)
from orderitems join books using (isbn);

select order#,sum(quantity*retail)
from orderitems join books using (isbn)
group by order#;

-- 2. What columns?
--      retail
--      order#
--      quantity purchased (qty)
--      first name and last name of customer



-- B. Joins to retrieve columns from No. 1 above
-- 1. What tables?
--    customers
--    orders
--    orderitems
--    books
-- 2. What join criteria?

select firstname, lastname, order#, sum(quantity*retail) as total
from customers join orders using (customer#)
               join orderitems using (order#)
               join books using(isbn)
group by firstname, lastname, order#
order by sum(quantity*retail) desc;               


-- -----------------------------
-- List first and last name of the top selling author(s), and totals ok books sold
-- authors
-- bookauthor
-- orderitems
-- books
select * from author;
select * from bookauthor;
select * from orderitems;

select fname, lname, sum(quantity) as TotalBooksSold
from orderitems join bookauthor using(isbn)
                join author using(authorid)
group by fname, lname 
order by sum(quantity) desc;
-- -----------------------------
-- List the publishers with the highest profit
-- retail
-- cost
-- pubid
-- pub name
-- quantity

select owner,table_name, column_name 
from all_tab_columns
where 1=1
   and lower(table_name) not like '%$%'
   and lower(column_name) like '%pub%'
   and lower(owner) = 'books';

-- concepts
-- joins (new school using)
-- aggregate function
-- nesting an agregate into a scalar function
-- format model
-- use of alias in select and order by
-- math order of operations
select name, to_char(sum((retail-cost)*quantity),'$999,999.99') as totalProfit
from orderitems join books using(isbn)
                join publisher using (pubid)
group by name
order by totalProfit desc; 







-- -----------------------------------------------------------------------------  
-- EXERCISES USE PM Device Manasgement Worksheet to follow along
/*
    You run the Network Operations Center monitoring devices for your university.
    Your development team has just completed the Next Gen project. Your network
    engineers have started moving devices in the ticketing system from Legacy to
    Next Gen.
    
    The Project Manager has sent you the Project Tracking spreadsheet she is using
    to keep track of the project. 
        
*/
-- -------------------------------------
-- 1. List the devices from the legacy system
--    How many?


-- -------------------------------------
-- 2. List the devices from the next_gen system
--    How many?

-- -------------------------------------
-- NOTE:  We need to use the short mac address name
-- 3. Fix any problems in LEGACY

-- -------------------------------------
-- 4. Fix any problems in NEXTGEN

-- -------------------------------------
-- 5. List the devices already migrated


-- -------------------------------------
-- 6. What percent have been migrated


-- -------------------------------------
-- 7. List all legacy devices along with migrated devices


-- -------------------------------------
-- 8. List only devices not yet migrated

-- -------------------------------------
-- 9. What percent are not yet migrated

-- -------------------------------------
-- 10. How many devices have been disposed

-- -------------------------------------