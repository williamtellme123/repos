-- =============================================================================
/* 
   JOINS ARE USED
        
        TO ANSWER QUESTIONS REQUIRING DATA FROM MORE THAN 1 TABLE
        
        
        CARTESEAN (or cross product)
        --------------------------------
        To Learn about other joins
            How many rows and columns are returned from a cross join 
            of customers and orders
        
        INNER (or just plain joins)
        --------------------------------
            EQUI: Used to find matches:
                Boyfriend in bookstore: 
                    "I want to buy a book for my girlfriend. Can you 
                    tell me which authors she like?"

            NON-EQUI: Tables related but no exact match:
                Boyfriend in bookstore: 
                    "What gift do I get if I purchase SHORTEST POEMS?"
        OUTER
        --------------------------------
        Find descrepencies
            LEFT
              Find all matches plus
              All other rows in left table
              "How many devices have not been migrated from system Legacy to Next-Gen"
            RIGHT
              Find all matches plus
              All other rows in right table
              "How many devices have been migrated from system Legacy to Next-Gen"
            FULL
              Find all matches plus
              All other rows in right table plus
              All other rows in left table
             "Complete state of migration project"
        
        NATURAL
        --------------------------------
            Uses columns with same name
            Not reliable :: Use is discouraged
        
        SELF
        --------------------------------
            One table 
              Two columns 
              Two different meanings
            
            Customers     
              Customer#         Referred_by
              Find people referred by other people
            
            Employees     
              Employee#         Manager
              List employee and managers names
              
            Product       
              Product_id        Vendor_id
              List each product that comes from two different vendors 

            Stores
              Store_id          Upline_id
              List all of the stores under the one in Lubbock

            Army     
              Member#         Commanding_Officer#
              List the chain of command for Private Ryan
*/
-- =============================================================================
-- CARTESEAN JOIN (aka CARTESEAN PRODUCT; aka CROSS JOIN) 
-- -----------------------------------------------------------------------------
-- A Join used in Teaching
-- For all joins begin with cartesian product in memory
-- 1. Number rows returned as rows.table1 * rows.table2
-- 2. Number columns returned from table1 and table2
-- --------------------------------------------
-- Old school
    select *
    from cust, ords;
-- -------------------------------------
-- New School
    select *
    from cust cross join ords;
-- -----------------------------------------------------------------------------
-- LEARNING USE EXCEL TO FOLLOW
-- =============================================================================
-- INNER
    select *
    from cust inner join ords on custid = cid;
-- LEFT
    select *
    from cust left outer join ords on custid = cid;
-- RIGHT
    select *
    from cust right outer join ords on custid = cid;
-- FULL
    select *
    from cust full outer join ords on custid = cid;
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
    where customer# = customer#
    and firstname = 'BONITA';
-- -------------------------------------
-- New School Type No. 1
    select lastname, firstname, order#
    from customers c join orders o on c.customer# = o.customer#
    where firstname = 'BONITA';
-- -------------------------------------
-- New School Type No. 2
    select lastname, firstname, order#
    from customers c join orders o on c.customer# = o.customer# and firstname = 'BONITA';
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
    from customers, orders
    where customer# = customer#(+)
    and firstname = 'BONITA';
-- -------------------------------------
-- New School Type No. 1
    select lastname, firstname, order#
    -- From First
    from customers c left join orders o on c.customer# = o.customer#
    and firstname = 'BONITA'; 
-- -------------------------------------
-- New School Type No. 2
    select lastname, firstname, order#
    -- Where? LastPlace
    from customers c left join orders o on c.customer# = o.customer#
    and firstname = 'BONITA'; 
-- -------------------------------------
-- New School Type No. 3 ONLY IF COLUMN NAMES SAME
    select lastname, firstname, order#
    from customers left join orders using (customer#) 
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
    from customers, orders
    where customer#(+) = customer#
    and order# = 1005;
-- -------------------------------------
-- New School Type No. 1
    select lastname, firstname, order#
    -- From First
    from customers c right join orders o on c.customer# = o.customer#
    and order# = 1005;
-- -------------------------------------
-- New School Type No. 2
    select lastname, firstname, order#
    -- Where? LastPlace
    from customers c right join orders o on c.customer# = o.customer#
    and order# = 1005;
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
    from customers natural join orders
    where order# = 1005;
-- =============================================================================
-- -----------------------------------------------------------------------------  
-- Exercise SELF JOINS
-- List the people first and last names who referred other customers along
-- with the firsst and last names of those who were referred
select c1.firstname || ' ' || c1.lastname || ' Referred --> ' || c2.firstname|| ' ' || c2.lastname
from customers c1,
     customers c2
where c1.customer# = c2.referred;     
-- =============================================================================
-- EXERCISES USE BOOKS
-- -----------------------------
-- What authors does Bonita buy?







-- -----------------------------
-- List customer first and last names order number invoice totals
-- in descending order of invoice totals







-- -----------------------------
-- List the top selling author(s)






-- -----------------------------
-- List the publishers with the highest profit






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
--    select * from legacy;
--    How many?
-- -------------------------------------
-- 2. List the devices from the next_gen system
--    select * from next_gen;
--    How many?
-- -------------------------------------
-- NOTE:  We need to use the short mac address name
--
-- 3. Fix any problems in LEGACY
--            select * from legacy where m_short = '8A-F3x87[';
--            update legacy set m_short = '8A-F3' where m_short = '8A-F3x87[';
-- -------------------------------------
-- 3. Fix any problems in NEXTGEN
--    select * from next_gen;
--    OK no problems
-- -------------------------------------
-- 4. List the devices that have been migrated
--    select m_short,bldg, mac_short, building
--    from legacy join next_gen on m_short=mac_short;
-- -------------------------------------
-- 5. What percent have been migrated
-- -------------------------------------
-- 7. List all legacy devices along with migrated devices
--    select *
--    from legacy left join next_gen on m_short=mac_short;
-- -------------------------------------
-- 8. List only devices not yet migrated
--    select *
--    from legacy left join next_gen on m_short=mac_short
--    where mac_short is null;
-- -------------------------------------
-- 9. What percent are not yet migrated

-- -------------------------------------
-- 10. How many devices have been disposed

-- -------------------------------------