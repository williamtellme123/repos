-- =============================================================================
--  CHAPTER 7
/*

     -- -------------------------------------------------------------------------      
    TABLE OF CONTENTS
    0.  LIST OF CHAPTER 7 TERMS
    1.  REVIEW and AHAs
    2.  AGGREGATE FUNCTIONS
    3.  AGGREGATE FUNCTION GROUP BY
    4.  PRACTICE 1
    5.  NESTING 
    4.  PRACTICE 2
    
*/ 
-- =============================================================================   
-- -----------------------------------------------------------------------------
--    0. LIST OF CHAPTER 3 TERMS
--                  AGGREGATE (GROUP) FUNCTION          : Function executed on multiple rows
--                  DISTINCT and ALL                    : Used with group function
--                  RANK WITHIN GROUP                   : 
--                  FIRST                               : 
--                  GROUP BY                            : How to group rows
--                  WHERE                               : T/F on rows before group function runs
--                  HAVING                              : T/F on results from group function
-- -----------------------------------------------------------------------------
--    1. REVIEW and AHAs
--    AHA  2: Create : tables, constraints using DDL as database objects
--    AHA  3: Manipulating Data: Select, Insert, Update, Delete, Rollback, Commit
--    AHA  4: Lots more about select details 
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
--    2.  AGGREGATE FUNCTIONS
-- -----------------------------
--     a. sum, avg, min, max, median
-- -----------------------------
          select * from books.books;
          select
                  sum(retail)
                , avg(retail)
                , min(retail)
                , max(retail)
                , median(retail)
          from books.books;

-- -----------------------------
--     b. dates and null values
-- -----------------------------
        select count(shipdate), count(*), max(shipdate), median(shipdate)
        from books.orders;
        
        
-- -----------------------------
--     c. distinct and all
-- -----------------------------
       select count(*), count(distinct lastname)
       from books.customers;
       
       select count(shipdate), count(all shipdate), count(distinct shipdate), count(*)
       from books.orders;
   
        
-- -----------------------------        
--     d. rank(c1) within group (order by e1
--        windowing functions works on a sliding window of times
-- -----------------------------
        select rank(300) within group (order by sq_ft desc) sq_ft
        from cruises.ship_cabins;

-- -----------------------------        
--     e.  keep (dense_rank first order by e1)      
-- -----------------------------        
        select guests, sq_ft
        from cruises.ship_cabins
        order by 1;
        
        select max(sq_ft) keep (dense_rank first order by guests desc) as largestRoom
        from cruises.ship_cabins;

-- =============================================================================
--    3.  GROUP BY
-- -----------------------------        
--     a.  choosing which rows to aggregate by grouping values in a column
-- -----------------------------        
--    if any column is present in select clause
--    and is not in an aggregate function
--    that column must be in the group by clause
    select 
            category
          , sum(cost) as byCategory
          , avg(cost)
          , count(*)
          , min(cost)
          , max(cost)     
    from books.books
      group by category     
--      having sum(cost) <= 35
    order by 2
;
    select state, count(*) as customer_count
    from books.customers
    group by state
--    order by count(*) desc;
--    order by 2 desc;
    order by customer_count desc;

    select title, retail, cost, retail-cost as profit
    from books.books;
    
    select category, avg(retail-cost) as profit
    from books.books
    group by category
    having avg(retail-cost) <= 17
    order by profit;
    
-- -----------------------------        
--     b.  choosing which rows to aggregate by grouping values in more than 1 columns
-- -----------------------------   
   -- table cruises.ship_cabins
   -- min and max sq_ft gruped by room_type, room_style
   select room_type
         , room_style
         , min(sq_ft)
         , max(sq_ft)
    from cruises.ship_cabins
    group by room_type, room_style;
-- -----------------------------        
--     c.  where and having
-- -----------------------------            
--    Having works on the values of the aggregate functions.
--    Having waits and uses the results of the agg functions
--    to decide which rows to bring back
-- 
--    where clause happens
--    before the aggregation happens
--    
--    having happens after the
--    aggregation happens

      select category 
          , sum(cost)
          , avg(cost)
          , count(*)
          , min(cost)
          , max(cost)     
      from books
      where cost >= 32
      having sum(cost) >= 38
      group by category
      order by 4;
      
      select category 
            , sum(cost)
      from books.books
      where cost >= 32
      group by category
      having sum(cost) >= 38;     

      select  room_number
             , room_style
             , room_type
             , window
             , guests
             , sq_ft
             , balcony_sq_ft
      from ship_cabins;
      
-- =============================================================================
--    4.  PRACTICE 1
-- -----------------------------  
--    practice aggregation functions 1
--    if any column is present in select clause
--    and is not in an aggregate function
--    that column must be in the group by clause
      
      select distinct room_style, room_type, window
      from cruises.ship_cabins;
      
          -- display the sq_ft of largest room by combination of
          -- room_style, room_type, window
      select
             room_style
           , room_type
           , window
           , max(sq_ft)
      from cruises.ship_cabins
      where window = 'Ocean'
      
      group by room_style
             , room_type
             , window
      having  max(sq_ft) > 750     
      
      order by 1,2,3;
      
--      Order
--      group by
--      where
--      from
--      having
--      order by
--      select
       
--    practice aggregation functions 2
      drop table myagg;
      create table myagg
      ( name   varchar2(20),
        nickles     integer,
        dimes     integer,
        quarters   integer);
        
      insert into myagg values ('Bunky',4,      5,    6);
      insert into myagg values ('Zappo',3,      3,    null);
      insert into myagg values ('Minty',null,   3,    null);
      insert into myagg values ('Moony',3,      null, null);
      commit;
      
      -- sum, avg, count by name
   
   
   
 
--  Classroom exercises (books)
--  CE No. 1: Display the state abbreviation and the count
--            of customers from each state
       select  state, count(*) as totCust 
       from books.customers
       group by state
--       order by 2 desc;
--       order by count(*) desc;
        order by totCust desc;

-- CE No. 2: Display the most recent order date in books.orders
       select max(orderdate) 
       from books.orders;
-- CE No. 2a: Display maximum time to ship
      select 
            trunc(max(nvl(shipdate,sysdate)-orderdate)) as maxTimeToShipDays
           , trunc(max(nvl(shipdate,sysdate)-orderdate)/365) as maxTimeToShipYears
           , mod(trunc(max(nvl(shipdate,sysdate)-orderdate)/365,13))
--           , mod(max(nvl(shipdate,sysdate)-orderdate), trunc(max(nvl(shipdate,sysdate)-orderdate)/365))
      from books.orders;
      
      
-- CE No. 3: Display the average profit of each category of books.books
     select category, to_char(avg(retail-cost),'$999.99')  
     from books.books
     group by category; 
   
   
   
-- CE No. 4: Count the number of orders which have not shipped
--    count the number that have shipped
   select 
        count(*) as totalOrders
       ,count(shipdate) totalOrdersShipped
       , count(*)- count(shipdate) as  totalNotShipped
   from books.orders;
   
   
   
-- CE No. 5: Return the longest title
   
select title
from books.books
where length(title) =
                      (
                       select max(length(title))
                       from books.books
                       );
         
select max(title) from books.books;

select title from books.books
order by 1 desc;
   
   
   

-- =============================================================================
--    5.  NESTING
-- -----------------------------  
--    Chapter 6 Scalar functions operate on "EVERY ROW" can be nested many times
      select 
         concat
           ('On Average each student received: ',     
              to_char
              (
                 round
                 (
                    (
                       nvl(to_number(FEDERAL10),0)
                       +
                       nvl(to_number(FEDERAL10_NET_PELL),0)
                    )   
                     / nvl(to_number(FTE_COUNT),0)
                 ,2
                 ) 
              , '$999,999.99'
              )
            )
           as fps
      from tuition;



--    Chapter 7 Aggregate functions can be nested only 2 deep (page 294)
--    When going 2 deep there
--    can be no other values in the select.
      select avg(max(sq_ft))
      from cruises.ship_cabins
      where ship_id = 1
      group by room_style, room_type;

      select category, retail, cost
      from books.books;
    
      select max(avg(retail))
      from books.books
      group by category;
      
      
      drop table vehicles;
      create table vehicles
      ( name   varchar2(25),
        type    varchar2(25),
        cost    number(12),
        price   number(12));
      
      insert into vehicles values('Corolla','Car',22000,25000);
      insert into vehicles values('Tacoma','Truck',2400035000);
      insert into vehicles values('Camry','Car',27000,30000);
      insert into vehicles values('Tundra','Truck',35000,45000);
      insert into vehicles values('RX350','Car',37000,405000);
    
      
      select * from vehicles;
      
      select name,type, price-cost
      from vehicles;
      
      select max(avg(price-cost))
      from vehicles
      group by type;
      
--      group by type;

    

      
--    COMPUTER	52.85
--    COOKING	24.35
--    CHILDREN	34.45
--    LITERATURE	39.95
--    BUSINESS	31.95
--    FITNESS	30.95
--    FAMILY LIFE	55.975
--    SELF HELP	29.95


      select room_type, room_style, sq_ft
      from ship_cabins;
--    one level (only one aggregate)
      select room_type, room_style, max(sq_ft)
      from ship_cabins
      group by room_type, room_style;

--    2nd level aggregate 
      select room_type, room_style, avg(max(sq_ft))
      from ship_cabins
      group by room_type, room_style;

--    2nd level aggregate remove all scalar values from select
      select avg(max(sq_ft))
      from ship_cabins
      group by room_type, room_style;

--    Can you nest aggregates inside of scalars? YES!
      select concat 
                (
                  'Average of all the largest rooms is: ',
                  to_char(
                          round(
                                avg(max
                                      (sq_ft)
                                    )
                                ,2
                               ),'$999.99'
                         )
                )
      from ship_cabins
      group by room_type, room_style;

]
-- =============================================================================
--    6.  PRACTICE 2
-- -----------------------------  
--    count orders by Quarters for 2003 orders table books.orders
      select to_char(orderdate,'YYYY'), to_char(orderdate,'q'), orderdate
      from books.orders;   
    
      select count(*), to_char(orderdate,'YYYY'), to_char(orderdate,'q')
      from books.orders
      where     to_char(orderdate,'YYYY') = '2003'
      group by  to_char(orderdate,'q'),
                to_char(orderdate,'YYYY'); 



      select distinct to_char(orderdate,'YYYY')
      from books.orders;
 
 
 
     
      select * from books.orders;
Insert into orders (ORDER#,CUSTOMER#,ORDERDATE,SHIPDATE,SHIPSTREET,SHIPCITY,SHIPSTATE,SHIPZIP) 
values (1050,1005,to_date('06-AUG-05','DD-MON-RR'),to_date('02-APR-03','DD-MON-RR'),'1201 ORANGE AVE','SEATTLE','WA','98114');
Insert into orders (ORDER#,CUSTOMER#,ORDERDATE,SHIPDATE,SHIPSTREET,SHIPCITY,SHIPSTATE,SHIPZIP) 
values (1051,1010,to_date('11-JUL-14','DD-MON-RR'),to_date('01-APR-03','DD-MON-RR'),'114 EAST SAVANNAH','ATLANTA','GA','30314');
Insert into orders (ORDER#,CUSTOMER#,ORDERDATE,SHIPDATE,SHIPSTREET,SHIPCITY,SHIPSTATE,SHIPZIP) 
values (1052,1011,to_date('31-DEC-03','DD-MON-RR'),to_date('01-APR-03','DD-MON-RR'),'58 TILA CIRCLE','CHICAGO','IL','60605');






--    Display longest projects for each ship: table cruises.projects
    
    
    
--    Display avg retail for each category where avg > 38 : table books.books
    
    





