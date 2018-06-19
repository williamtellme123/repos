-- =============================================================================
--  CHAPTER 7
/*

     -- -------------------------------------------------------------------------      
    TABLE OF CONTENTS
    0.  LIST OF CHAPTER 4 TERMS
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
        select count(retail), sum(retail), min(retail), max(retail), median(retail) from books.books;

-- -----------------------------
--     b. dates and null values
-- -----------------------------
        select count(*), count(shipdate), max(shipdate), min(shipdate) from books.orders;
        
-- -----------------------------
--     c. distinct and all
-- -----------------------------
        select count(all lastname), count(distinct lastname)  from books.customers;
        
-- -----------------------------        
--     d. rank(c1) within group (order by e1)
-- -----------------------------
        select sq_ft from cruises.ship_cabins order by 1;
        select rank(300) within group (order by sq_ft) from cruises.ship_cabins;

-- -----------------------------        
--     e.  keep (dense_rank first order by e1)      
-- -----------------------------        
        select guests, sq_ft
        from cruises.ship_cabins
        order by  1;
        
        select max(sq_ft) keep (dense_rank first order by guests) "largest"
        from cruises.ship_cabins;
        
        select max(sq_ft) keep (dense_rank last order by guests) "largest"
        from cruises.ship_cabins;


-- =============================================================================
--    3.  GROUP BY
-- -----------------------------        
--     a.  choosing which rows to aggregate by grouping values in a column
-- -----------------------------        
    -- if any column is present in select clause
    -- and is not in an aggregate function
    -- that column must be in the group by clause
    select category 
        , cost 
        , sum(cost) as TotalCost
        , avg(cost)
        , count(*)
        , min(cost)
        , max(cost)     
    from books
    group by category, cost
    having sum(cost) <= 150;

    select title, retail, cost, retail-cost as profit
    from books;
    
    select category, avg(retail-cost) as profit
    from books
    group by category;
    
-- -----------------------------        
--     b.  choosing which rows to aggregate by grouping values in more than 1 columns
-- -----------------------------   
    select 
        room_style,
        room_type,
        to_char(min(sq_ft),'9,999') "min",
        to_char(max(sq_ft),'9,999') "max",
        to_char(min(sq_ft)-max(sq_ft),'9,999') "diff"
      from cruises.ship_cabins
      where ship_id = 1
      group by room_style, room_type
      order by 3;
   
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
      select
               room_style
             , room_type
             , window
             , count(*)
             , sum(guests)
             , sum(sq_ft)
             , sum(balcony_sq_ft)
      from ship_cabins
      group by room_style
             , room_type
             , window
      order by 1,2,3;
       
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
      select
           count(*) z
          ,count(nickles) count_one
          ,sum(nickles) sum_one
          ,round(avg(nickles) ,2) avg_one
          ,count(dimes) count_two
          ,sum(dimes) sum_two
          ,round(avg(dimes),2) avg_two
          ,count(quarters) count_three
          ,sum(quarters) sum_three
          ,round(avg(quarters),2) avg_three
      from myagg;
 
--  Classroom exercises (books)
--  CE No. 1: Display the state abbreviation and the count
--            of customers from each state
--
      select state, count(*)
      from customers
      group by state
      order by 2 desc;

-- CE No. 2: Display the most recent order date
      select max(orderdate) from orders;


-- CE No. 3: Display the average profit of each category of books
      select category, to_char(round(avg(retail-cost),2),'$999.99') as profit
      from books
      group by category;

      select to_char(sum(retail*10),'$9,999.99') as "Total Retail Value"
      from books;

-- CE No. 4: Count the number of orders which have not shipped
--    count the number that have shipped
      select count(*)
           , count(shipdate) as Shipped
           , count(*)-count(shipdate) as NotShipped
      from orders;

-- CE No. 5: Return the longest title
      select max(length(title)), max(title)
      from books;

      select title, length(title)
      from books
      order by length(title) desc;


-- =============================================================================
--    5.  NESTING
-- -----------------------------  
--    Aggregate functions can be nested but only
--    2 deep. And when going 2 deep there
--    can be no other values in the select.
      select avg(max(sq_ft))
      from ship_cabins
      where ship_id = 1
      group by room_style, room_type;
  

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
      select to_char(orderdate,'Q') as "quarter", count(*)
      from books.orders
      where to_char(orderdate,'YYYY') = 2003
      group by to_char(orderdate,'Q');

--    Display longest projects for each ship: table cruises.projects
      select ship_id, max(days)
      from projects
      group by ship_id
      having avg(project_cost) < 50000;

--    Display avg retail for each category where avg > 38 : table books.books
      select category, avg(retail)
      from books.books
      group by category
      having avg(retail) > 38
      order by avg(retail);





