-- =============================================================================
--  CHAPTER 8
/*
-- -------------------------------------------------------------------------      
    TABLE OF CONTENTS
    0.  LIST OF CHAPTER 8 TERMS    
    1.  CARTESIAN JOIN (aka CROSS JOINS) 
    2.  INNER-EQUI JOIN
    3.  INNER-NON-EQUI JOIN
    4.  LEFT OUTER JOIN
    5.  RIGHT OUTER JOIN
    6.  FULL OUTER JOIN
    8.  SELF JOIN 
    9.  NATURAL JOIN
*/
-- -----------------------------------------------------------------------------
--  0. LIST OF CHAPTER 8 TERMS
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
--            customers     
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
-- -----------------------------------------------------------------------------
--  1.  CARTESIAN JOIN (aka CROSS JOINS) 
-- -----------------------------------------------------------------------------
--     First perform setup
--     Create all tables from books in your own schema



--     A Join used in Teaching
--     For all joins begin with cartesian product in memory
--     1. Number rows returned as rows.table1 * rows.table2
--     2. Number columns returned from table1 and table2
-- --------------------------------------------
    -- Old school
    -- cartesean product aka cross product
      select *
      from cust, ords;

    -- -------------------------------------
    -- New School
      select *
      from cust cross join ords;

    -- -----------------------------------------------------------------------------
    -- LEARNING USE EXCEL TO FOLLOW
    -- INNER old school
    select *
    from cust, ords
    where custid = cid;

    -- INNER new school
    select *
    from cust join ords on custid = cid;

    -- LEFT (outer is optional)
    select * 
    from cust left join ords on custid = cid;
    
    -- RIGHT
    select * 
    from cust right join ords on custid = cid;
    
    -- FULL
    
     select * 
    from cust full join ords on custid = cid;
    
-- -----------------------------------------------------------------------------    
-- 2.  INNER-EQUI JOIN
-- -----------------------------------------------------------------------------
    -- Old school
    -- Return first and last names with order numbers from books schema
    select customers.customer# , firstname, lastname, order#
    from customers, orders
    where customers.customer# = orders.customer#;

    -- -------------------------------------
    -- New School Type No. 1

select customers.customer# , firstname, lastname, order#
    from customers join orders
    on customers.customer# = orders.customer#;

    -- -------------------------------------
    -- New School Type No. 2, for use only when common column names are the same 
select customer# , firstname, lastname, order#
    from customers join orders using(customer#);


    -- -------------------------------------
    -- New School Type No. 3



-- -----------------------------------------------------------------------------
--  3.  INNER-NON-EQUI JOIN
--      Used when exact join is not possible
--      Salary Grade No. 6 has a min_salary = 35000 max_salary = 45000
--      A promotional gift may be given if cost minretail and maxretail 
-- -------------------------------------
--      Old School
      select * from books;
      select * from promotion;

      select title, retail, minretail, maxretail, gift
      from books, promotion
      where retail >= minretail and retail <= maxretail;
-- -------------------------------------
--      New School
      select title, retail, minretail, maxretail, gift
      from books join promotion
      on retail >= minretail and retail <= maxretail;

-- -----------------------------------------------------------------------------  
--  4.  LEFT OUTER JOIN
--    -----------------------------------------------------------------------------
--      Find all matches plus
--      All non-matching rows in left table
--        "List all customers with orders if they have them"
--      CAUTION: 
--        'from'  First (filtered at joining)
--        'where' LastPlace filtered after outer joining complete
--      TWO DIFFERENT ANSWERS
--      -------------------------------------
--      Old school
        select firstname, lastname, order#
        from customers c, orders o
        where c.customer#  = o.customer#(+);
        

--      -------------------------------------
--      New School Type No. 1
        select firstname, lastname, order#
        from customers c left join orders o
        on c.customer#  = o.customer# 
        where order# is null;


        select firstname, lastname, order#
        from customers c left join orders o
        on c.customer#  = o.customer#
        and order# is null;
        
        select * 
        from cust left join ords on custid = cid 
        where oid is null;
--      -------------------------------------
--      New School Type No. 2
        select firstname, lastname, order#
        from customers left join orders using(customer#);

--      -------------------------------------
--      New School Type No. 3 ONLY IF COLUMN NAMES SAME


-- -------------------------------------
--  5. RIGHT OUTER JOIN
---------------
--    Find all matches plus
--    All other rows in right table
--      "List all orders with customers if they have them"
--    CAUTION: 
--      'from'  First (filtered at joining)
--      'where' LastPlace filtered after outer joining complete
--    TWO DIFFERENT ANSWERS
--    -------------------------------------
--    Old school
      select order#
      from customers c, orders o
      where c.customer#(+) = o.customer#;

      select * from orders where order# = 5000;
      
      REM INSERTING into orders
SET DEFINE OFF;
Insert into orders (ORDER#,CUSTOMER#,ORDERDATE,SHIPDATE,SHIPSTREET,SHIPCITY,SHIPSTATE,SHIPZIP) 
values (5000,9000,to_date('31-MAR-03','DD-MON-RR'),to_date('02-APR-03','DD-MON-RR'),'1201 ORANGE AVE','SEATTLE','WA','98114');

      
--    -------------------------------------
--    New School Type No. 1
      select order#, c.customer#, firstname, lastname
      from customers c right join orders o
      on c.customer# = o.customer#;

--    -------------------------------------
--    New School Type No. 2
      select order#, customer#, firstname, lastname
      from customers right join orders 
      using (customer#);

      select count(order#), customer#, firstname, lastname
      from customers right join orders 
      using (customer#)
      group by customer#, firstname, lastname;
      
      select count(order#), customer#, firstname, lastname
      from customers left join orders 
      using (customer#)
      group by customer#, firstname, lastname;
      
      select *
      from customers full join orders 
      using  (customer#);
      
      select * from customers;

--    -------------------------------------
--    New School Type No. 3 ONLY IF COLUMN NAMES SAME


  
-- -------------------------------------
--  6. FULL OUTER JOIN
 --    -------------------------------------
--    Old school
--    select lastname, firstname, order#
--    from customers, orders
--    where customer#(+) = customer#(+)
--    and order# = 1005;
--    -------------------------------------
--    New School Type No. 1


--    -------------------------------------
--    New School Type No. 2


--    -------------------------------------
--    New School Type No. 3 ONLY IF COLUMN NAMES SAME



-- -----------------------------------------------------------------------------  
-- 7. SELF JOINS
--    List the people first and last names who referred other customers along
--    with the firsst and last names of those who were referred

select * from customers;

select c1.customer#, c1.lastname, c2.firstname, c2.lastname
from customers c1, customers c2
where c1.customer# = c2.referred;



-- -----------------------------------------------------------------------------  
-- 8. NATURAL JOINS
-- 
--    Only useful when columns are identical
--    Not very readable
--    Subject to hiding problems when columns are changed
--    Discourage use
      select lastname, firstname, order#
          from customers natural join orders
          where order# = 1005;
          
    select distinct owner, table_name
    from all_tab_columns
    where upper(table_name) = 'CUST';
    
    select * from cust;
    select * from ords;
    
    select *
    from cust right join ords on custid = cid
    where custid is null;
    
    select * 
    from customers c right join orders o on c.customer# = o.customer#
--    where customer# is null
    ;
    
    select count(*)
    from orders;
    
    select * 
    from cust c full join ords o on custid = cid;
    

-- -----------------------------------------------------------------------------  
--  EXERCISES USE BOOKS
-- -----------------------------
--  SE No. 0 Which customers have not purchased anything yet?
select * from customers, orders;

select c.customer#, firstname, lastname, order#
from customers c left join orders o on c.customer# = o.customer#
where order# is null;

--  SE No. 1 What authors does Bonita buy?
select distinct firstname, lastname, fname, lname
from customers join orders using(customer#)
  join orderitems using(order#)
  join bookauthor using(isbn)
  join author using(authorid)
where firstname = 'BONITA';

select distinct firstname, lastname, fname, lname
from customers c join orders o on c.customer# = o.customer#
  join orderitems oi on o.order# = oi.order#
  join bookauthor b on oi.isbn = b.isbn
  join author a on b.authorid = a.authorid
where firstname = 'BONITA';

select distinct firstname, lastname, fname, lname
from customers c, orders o 
  ,orderitems oi 
  ,bookauthor b 
  ,author a 
  where c.customer# = o.customer#
  and o.order# = oi.order#
  and oi.isbn = b.isbn
  and b.authorid = a.authorid
and firstname = 'BONITA';


--  SE No. 2 Who spent the most money?

select -- firstname, lastname, 
    max(sum(quantity * retail))
from customers c join orders o on c.customer# = o.customer#
                join orderitems oi on o.order# = oi. order#
                join books b on oi.isbn = b.isbn
                group by firstname, lastname;

--  SE No. 3 Who wrote the most books in the store?

select authorid, count(distinct isbn)
  from bookauthor
  group by authorid
  order by 2 desc;

--  SE No. 4 Are there any orders without matching customers?

select order#
    from orders o, customers c
    where o.customer# = c.customer#(+)
    and c.customer# is null;






-- -----------------------------
-- List customer first and last names order number invoice totals
-- in descending order of invoice totals







-- -----------------------------
-- List the top selling author(s)






-- -----------------------------
-- List the publishers with the highest profit






