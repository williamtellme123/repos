-- =============================================================================
--  CHAPTER 4
/*

    "AHA" means A Look Ahead (terms/phrases as overview of chapter)

     -- -------------------------------------------------------------------------      
    TABLE OF CONTENTS
    0.  LIST OF CHAPTER 4 TERMS
    1.  REVIEW and AHAs
    2.  BASICS OF SELECT CLAUSE
    3.  BASCIS OF WHERE CLAUSE
    4.  NULL IN THE WHERE CLAUSE
    5.  SELECTING Literal values instead of a column name
    6.  BASIC ORDERING (Sorting)
*/ 
-- =============================================================================   
-- -----------------------------------------------------------------------------
--    0. LIST OF CHAPTER 3 TERMS
--                  SELECT                  : Find and return data from tables
--                  PSEUDOCOLUMNS           : Not data (called meta-data)
--                  ORDERE OF OPERATIONS    : PEMDAS
--                  FUNCTIONS               : Input -> F -> Output
--                  PROJECTION              : Which columns returned
--                  SELECTION               : Which rows returned
-- -----------------------------------------------------------------------------
--    1. REVIEW and AHAs
--    AHA  2: Create : tables, constraints using DDL as database objects
--    AHA  3: Manipulating Data: Select, Insert, Update, Delete, Rollback, Commit
--    AHA  4 Lots more about select details 
--               Short Demo : This chapter is so simple no demo required
--    AHA  5: Lots more about WHERE details 
--    AHA  6: Single Row Functions that change result sets : ETL (Extract, Transform, Load) example
--    AHA  7: Aggregate Functions often used in reporting (SUM) all the computer books
--    AHA  8: Finding data using more than 1 table: JOINS
--    AHA  9: An inner (child) query can pass its results to an outer (parent) query
--    AHA 10: Views, Sequences, Indexes, Synonyms
--    AHA 11: Add, Modify, Drop Table Columns, Constraints from Ch. 2, load external data
--    AHA 12: Set Operations on result sets: Instersection, Unions, etc 
--    AHA 13: Data Reporting using ROLLUP and CUBE
--    AHA 14: Finding Meta Data: Data about your data (i.e. find all tables with column called employee_id)
--    AHA 15: Multi-table inserts: insert into >1 table (i.e. add last years invoices to history and archive)
--    AHA 16: Hierarchical Queries: Org Chart (employees, mgrs, executives all employees all in one table)
--    AHA 17: Regular Expressions : A sub language used to find data using patterns (i.e. find ssn, phone numbers)
--    AHA 18: DBA tasks: Adding users and privileges
-- =============================================================================
--    2.  BASICS OF SELECT CLAUSE
-- -----------------------------
--      a. Simple select
-- -----------------------------
            select customer#, firstname, lastname, state
            from customers;
-- -----------------------------
--       b. Modify the result set 
-- -----------------------------
            select title, retail, cost, retail-cost
            from books;
-- -----------------------------
--       c. Changing the result set column titles use an alias
-- -----------------------------
            select title, retail, cost, retail-cost as profit
            from books;
-- -----------------------------
--       d. The word AS is optional
-- -----------------------------
            select customer# as ID, firstname || ' ' || lastname as fullname
            from customers;
-- -----------------------------
--      e. EVERY SQL STATEMENT IN ORACLE NEEDS A TABLE
--          DUAL is an Oracle table you can use to test expressions
-- -----------------------------
            select * from dual;
-- -----------------------------
--      f. TEST MATH EXPRESSION sqrt of 100
-- -----------------------------
            select 100+25
            from dual;
            
            select 100+25, sysdate
            from books;
-- -----------------------------
--      g. TEST MATH ORDER OF OPERATIONS
            select sqrt(100 + 200 / 50 - 4) + 2 * (4 / 12) from dual; 
-- -----------------------------
--      h. Round the output
-- -----------------------------
            select round(sqrt(100 + 200 / 50 - 4) + 2 * (4 / 12),2) from dual; 
-- -----------------------------
--      i. Now you try using dual
--          CALCULATE FLOORING COST
--              The first floor of the house has 1248 sq ft
--              The 2nd floor of the house has 984 sq ft
--      
--              Square yards = (total square feet) / 9
--       
--              Calculate total price both floors
--                  i.  Carpet 4.55/Sq Yard
--                  ii. Wood 6.25/Sq Yard
                   select 
                              (1248 + 984)/9 * 4.55 as CarpetCost,
                              (1248 + 984)/9 * 6.25 as WoodCost                            
                    from dual;
-- -----------------------------
--      j. Test null in the SELECT CLAUSE
-- -----------------------------
            select 10 + 10 from dual; 
            select 10 + null from dual; 
-- -----------------------------
--      k. DISTINCT UNIQUE
-- -----------------------------
            select distinct category from books;
            select unique category from books;
            
            select distinct firstname, lastname from customers;
-- -----------------------------------------------------------------------------
--    2.  BASICS OF WHERE CLAUSE
-- -----------------------------
--      a. TRUE / FALSE
-- -----------------------------
--            RELATIONAL OPERATORS
-- 
--            'Apples' = 'APPLES'
--            (lastname, firstname) = ('MORALES','BONITA')
--            10 = 12/2
--            lastname = 'MORALES'
--            10 >= 100
--            state <> 'FL'
--            state != 'FL'
--            state ^= 'FL'

-- -----------------------------
--      b. EQUALS OPERATOR all books from category COMPUTER
--         display title, category, retail
-- -----------------------------           
            select title, retail, category
            from books
            where category = 'COMPUTER'; 
-- -----------------------------
--      c. Not equals books from category COMPUTER
-- -----------------------------
            select title, retail, category
            from books
            where category <> 'COMPUTER'; ; 
-- -----------------------------
--      d. Not Equals (another operator does same thing)
-- -----------------------------
          Select category, title, retail, cost
          from books 
          where category != 'COMPUTER'; 
-- -----------------------------
--      e. AND and OR 
-- -----------------------------
          Select category, title, retail, cost
          from books 
          where retail >= 40 and retail <=60
          and category in ('COMPUTER','FAMILY LIFE'); 
-- -----------------------------
--      f. IN is a shortcut for OR
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
--      g. BETWEEN shortcut for AND
-- -----------------------------
          -- The AND technique
          select port_name
          from ports
          where capacity >=3 
            and capacity <=4;
            
            
          -- The BETWEEN technique
          select port_name, capacity
          from ports
          where capacity between 3 and 4;
-- -----------------------------
--      h. LIKE activates wildcards  
--           %     any number of characters
--           _     just one of any kind of character
-- -----------------------------
          select title 
          from books
          where title like '%WOK%';
-- -----------------------------
--      i. Without LIKE it is a very different question
-- -----------------------------
          select title 
          from books
          where title = '%WOK%';
-- -----------------------------
--      j. LIKE on the wrong side? 
-- -----------------------------
          select title 
          from books
          where '%WOK%' like title ;
-- -----------------------------
--      k.  The single underscore
-- -----------------------------
          select port_name
          from ports
          where port_name like 'San_____';
          -- In case you can’t tell, that’s four underscores after San

-- -----------------------------------------------------------------------------
--    3. NULL IN THE WHERE CLAUSE
-- -----------------------------
--       a. Finding null
-- -----------------------------
          select * 
          from books.orders
          where shipdate is null;
-- -----------------------------
--        b. Finding not null
-- -----------------------------
          select * 
          from books.orders
          where shipdate is not null;
-- -----------------------------------------------------------------------------
--    4. PSUDEO COLUMNS
-- -----------------------------
--      a. ROWNUM This numbers the rows in the given rowlilst
--          starting at the top and moving down
-- -----------------------------
          select rownum, lastname 
          from books.customers;
-- -----------------------------
--      b. ROWNUM poses a challenge when used with order by 
--          rownum happenes before order by 
-- -----------------------------
          select rownum, lastname 
          from books.customers
          order by lastname;
          
          select rownum, lastname
          from
                (select lastname 
                from books.customers
                order by lastname)
          where rownum <= 5;
          
-- -----------------------------
--      c. OVERCOME ROWNUM ORDER BY 
--          this is handled extensively in chapter 9
-- -----------------------------
          select rownum, lastname
          from (
                  select lastname 
                  from customers
                  order by lastname
               );
-- -----------------------------
--     d. ROWID
--       Displays the physical address of the row
          select rowid, lastname 
          from customers;
        -- Copy the top row to the clipboard
        -- and paste it here 
        -- AAAE5QAABAAAK+JAAA	MORALES
-- -----------------------------
--    e. IS ROWID IMPACTED BY ORDER BY
          select rowid, lastname 
          from customers
--          where lastname = 'MORALES'
          order by lastname;
          -- Memory location is on disk and does not change
          -- AAAF98AABAAAOWJAAA	MORALES
-- -----------------------------------------------------------------------------
--    5. SELECTING Literal values instead of a column name
--                           that has its own value for each row                
-- -----------------------------
--      a. What if you put a literal value in the select statement?
--        like 'APPLE'
          select 'APPLE', firstname, lastname
          from customers;
-- -----------------------------
--      b. What if you left out the comma between them  then the column name
--        is seen as an alias to the literal value
          select 'APPLE', firstname, lastname
          from customers;
-- -----------------------------
--      c. See any value in using this?
        select 'Customer Number:'||customer# || '  Full Name: ' || firstname || ' ' || lastname "Customer Information"
        from customers;
        
        select 1 title 
        from books;
-- -----------------------------------------------------------------------------
--    6. BASIC ORDERING (Sorting)
-- -----------------------------
--      a. Default is ASCENDING :: Open the Cruises Connection :: asc is default
        select ship_id,  ship_name,  capacity
        from ships
        order by capacity;
        
        select shipdate
        from orders
        order by shipdate;
-- -----------------------------
--      b. But you can order by descending :: desc must be added
        select ship_id,  ship_name,  capacity
        from ships
        order by capacity desc;
-- -----------------------------
--      c. You can order by more than one column 
        select room_style, room_type, window, sq_ft
        from ship_cabins
        order by room_style, room_type, sq_ft desc;
-- -----------------------------------------------------------------------------
-- 7. THREE WAYS TO ORDER BY 
-- -----------------------------
--      a. First: column names
            select room_style, room_type, window, sq_ft
            from ship_cabins
            order by room_style, room_type, sq_ft desc;
-- -----------------------------
--      b. Second: column position
--         display title and category
--         sort by category asc and title desc using numbers for the columns
           select title, category
           from books
           order by 2 asc, 1 desc;

-- -----------------------------
--      c. Third is by the alias
--          column alias can only be referenced in the order by clause
            select title, retail-cost as profit
            from books
            order by profit;
-- -----------------------------
--      d. Mix and Match 
            select room_style || ' ' || room_type as room, window, sq_ft
            from ship_cabins
            order by room_type, room, 3 desc;
-- -----------------------------
--      e. Ordered Column not needed in select clause
            select title, retail, cost
            from books 
            order by category;
-- -----------------------------
--      f. Ordering by an expression 
          select title, retail, cost, round((retail-cost)/cost,2)*100 profit
          from books
--        order by profit;
--         order by round((retail-cost)/cost,2)*100;
          order by 4;
                                                                                                                                                                                                                                                                             -----------------
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

                                                                                                            -Oh 
select *
from customers
where customer# between 1021 and 1023;
-- -----------------------------
-- m. Oops  Lets rollback
rollback;
-- -----------------------------
-- n. Lets check again :: whew
select *
from customers
where customer# between 1021 and 1023;
-- -----------------------------
-- o. ALWAYS RUN A SELECT STATEMENT USING THE WHERE
--    CLAUSE YOU WANT TO USE TO DELETE
select * from 
customers
where customer# between 1021 and 1023;
-- -----------------------------
-- p. ALWAYS RUN A SELECT STATEMENT USING THE WHERE
--    CLAUSE YOU WANT TO USE TO DELETE
--    THEN COMMENT OUT AND ADD DELETE 
--select * from 
delete 
customers
where customer# between 1021 and 1023;
-- -----------------------------
-- q. Now lets rollback again
rollback;
-- -----------------------------
-- rq. Confirm where we are
select * from customers;
-- -----------------------------
-- s. Commit
commit;
-- t. DELETES MUST FOLLOW CONSTRAINTS
-- CUSTOMER# 
-- 1005	      GIRARD	    CINDY
-- HAS ORDERS
    select order#
    from books.orders
    where customer# = 1005;
-- u. Can we delete Cindy while she has orders?    
delete from books.customers
where customer# = 1005;
-- -----------------------------------------------------------------------------
-- 7. UPDATING COMMIT ROLLBACK SAVEPOINT
--    we need to make three sets of updates
--    to keep things clear on what we can and cannot rollback
--    First lets refresh our customers table
-- -----------------------------
-- a. Drop and recreate
--    CUSTOMERS
drop table customers;
--    Create it again
create table customers
as select * from books.customers;
--    Add Primary Key
alter table customers add primary key(customer#);
-- -----------------------------
-- DDL Statements do a double commit so we know this
-- is our last commit before we begin our work
-- -----------------------------
-- b. add the new customers
insert into customers (customer#,lastname,firstname,address,city,state,zip,referred)
    values (1021,'UNDERWOOD','CAREY','1010 Brussel Rd','NASHVILE','TN','54343',1018);
insert into customers (customer#,lastname,firstname,address,city,state,zip,referred) 
    values (1022,'SEACREST','RYAN','2134 Holly Blvd','SANTA MONICA','CA','90504',null);
insert into customers (customer#,lastname,firstname,address,city,state,zip,referred)
    values (1023,'THUMB','TOM','BOX 22 100 Main St ','Boden','TX','32306',null);
-- -----------------------------
-- c. Lets create savepoints after each change
--    we will use a number in the name so we know which order
--    we created them in and use a word that helps remember the change
savepoint add_new_cusomters_sp1;
-- -----------------------------
-- d. SIMILAR TO WHERE :: START EACH UPDATE WITH A SELECT
--    to identify which rows you are changing
Select * from customers where firstname = 'CINDY';
-- -----------------------------
-- e. CINDY GOT MARRIED WANTS TO CHANGE HER NAME TO THOMAS
Select * from customers where firstname = 'CINDY';
-- Found 1 row
update customers set lastname = 'THOMAS' where firstname = 'CINDY';
-- OK 1 row updated
Select * from customers where firstname = 'CINDY';
-- confirmed
-- -----------------------------
-- f. REESE CALLED said her PO Box is 81 not 18
Select * from customers where firstname = 'REESE';
-- Found 1 row
update customers set address = 'P.O. Box 81' where firstname = 'REESE';
-- OK 1 row updated
Select * from customers where firstname = 'REESE';
-- confirmed
-- -----------------------------
-- g. STEVE CALLED and said he had moved to new address:
--    Address : 65-909 Tower
--    City: Pinehill
--    State: GA
--    Zip: 29845
Select * from customers where firstname = 'STEVE';
-- only 1 row to update but four values to update
update customers 
set address = '65-909 TOWER',
set city =  'PINEHILL',
set state = 'GA',
set zip = '29845'
where firstname = 'STEVE';
-- -----------------------------
-- h. Create 2nd saveppoint
savepoint old_customers_update_sp2;
-- -----------------------------
-- i. Lets update the new customers
select *
from customers
where customer# between 1021 and 1023;
-- -----------------------------
-- j. We just got the return postcards and both RYAN and TOM
--    want to thank BONITA for referring them
select *
from customers
where firstname in ('RYAN', 'TOM');
-- -----------------------------
-- k. Wait what is Bonitas customer#
select * from customers where firstname = 'BONITA';
-- -----------------------------
-- l. ok good to go 1001
update customers set referred = 1001
where firstname in ('RYAN', 'TOM');
-- comfirm
select * from customers where firstname in ('RYAN', 'TOM');
-- -----------------------------
-- m. Create 3nd saveppoint
savepoint new_customers_update_sp3;
-- -----------------------------
-- n. Lets mark the price of all the Family Life books
--    down by 10%
select * from books where category = 'FAMILY LIFE';
--    capture the values before we change
--    Mickey     22
--    PAINLESS   89.95
update books set retail = retail * .9 where category = 'FAMILY LIFE';
-- confirm 
select * from books where category = 'FAMILY LIFE';
-- -----------------------------
-- o. REVIEW PLACES WHERE WE COULD RETURN TO
--    1. last commit : original customers
--    2. add_new_cusomters_sp1 : after we added new customers
--    3. old_customers_update_sp2: after updating existing customers
--    4. new_customers_update_sp3: after updating new customers
--
-- rollback; 
--      will take us all the way back to last commit
--      in other words back to before adding new customers
--
-- rollback to add_new_cusomters_sp1;
--      takes us back to before changes to old customers 
-- rollback to old_customers_update_sp2;
--      takes us back to before changes to new customers 
-- roll back to new_customers_update_sp3;
--      takes us back to before changes to the book prices