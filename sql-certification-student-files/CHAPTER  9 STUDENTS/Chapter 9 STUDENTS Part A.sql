/*
-- =============================================================================
    CHAPTER 9 Part A

    TABLE OF CONTENTS
    0.  LIST OF CHAPTER 9 TERMS
    1.  REFRESHER
    2.  REVIEW RESULT SETS FROM EARLIER CHAPTERS
          Where and how used depends on understanging the three types of result sets
            Scalar (one row and one column)
            Multiple row                                                NOTE: Additiional Operators (ANY, SOME, ALL on Pg. 355) 
   
    3.  RELATIONSHIP BETWEEN PARENT (OUTER) AND CHILD (INNER) SUB QUERIES
          A subquery is either
            Correlated 
              References one or more columns in outer
            Non-correlated
              Completely independent of outer
        
    4. LOCATIONS:
            A SQL subquery is nested inside one of the following  (always in parenthesis)
              SELECT field1, field2, (subquery) 
                FROM (subquery)
                WHERE field1 >= (subquery)                                NOTE: Additiional Operators (ANY, SOME, ALL on Pg. 355) 
                HAVING aggregateFunction(field2) > (subquery)

     5. REVIEW RELATIONAL OPERATORS 
            
     6. SQL "WITH" STATEMENT SUBQUERIES
        Chapter 9 Students Part B.sql  

     7. SUBQUERIES 
        Chapter 9 Students Part B.sql
              INSERT
              UPDATE 
              DELETE
*/
-- =============================================================================
--  0. LIST OF CHAPTER 9 TERMS
-- -----------------------------------------------------------------------------
--    Subqueries
--    Describe the Types of Problems That Subqueries Can Solve
--    List the Types of Subqueries
--    Write Single-Row and Multiple-Row Subqueries
--    Write a Multiple-Column Subquery
--    Use Scalar Subqueries in SQL
--    Solve Problems with Correlated Subqueries
--    Insert, update, and delete Rows Using Correlated Subqueries
--    Use the EXISTS and NOT EXISTS Operators
--    Use the WITH Clause
--    
--    SUB QUERIES
--        
--        OVERVIEW
--        Saying Query B is a sub query of Query A means the same as: 
--          Query A contains Query B
--          Query A is the outer query and Query B is the inner query
--        
--        Used: perform one operation which requires 2 distinct parts that cannot be run in the same single SQL
--        Because the outer query relies on the results of the inner query's result set. Lets review.
-- =============================================================================    
-- 1. REFRESHER
-- -----------------------------------------------------------------------------
--    Insert into 
--    select * from cruise_orders;
    select * from cruises;
    -- insert into cruise_orders values (1,sysdate,sysdate,100,2);
insert into cruises values (13,1,'Eastern Carribean', 1, 3, sysdate, sysdate + 5, 'PENDING');
insert into cruises values (15,2,	'Eastern Carribean',	1,5, sysdate, sysdate + 5, 'DOCK');
insert into cruises values (16,3,	'Western Carribean',	1, 3, sysdate, sysdate + 5, 'SEA');
insert into cruises values (17,2,	'Western Carribean',	2, 5, sysdate, sysdate + 5, 'SEA');
insert into cruises values (18,3,	'Transatlantic',	2, 3, sysdate, sysdate + 5, 'SEA');
-- commit;
alter table cruises modify status varchar2(15); 

--  create clean schema mybooks
    drop user mybooks cascade;
    create user mybooks identified by mybooks;
    grant all privileges to mybooks;

    select distinct table_name from all_tab_columns
    where owner = 'BOOKS';
      
--  CTAS
    create table customers as select * from books.customers;   
    drop table customers;  
      
    select distinct 'create table ' || table_name || ' as select * from books.' || table_name || ' where 1=2 ;'
    from all_tab_columns
    where owner = 'BOOKS';
    
    select distinct 'drop table ' || table_name || ';'
    from all_tab_columns
    where owner = 'BOOKS';
    
    select * from user_constraints; 
     
create table PUBLISHER as select * from books.PUBLISHER;
create table ORDERITEMS as select * from books.ORDERITEMS;
create table AUTHOR as select * from books.AUTHOR;
create table MOVIES as select * from books.MOVIES;
create table PROMOTION as select * from books.PROMOTION;
create table ACTORS as select * from books.ACTORS;
create table BOOKS as select * from books.BOOKS;
create table ORDERS as select * from books.ORDERS;
create table ROLES as select * from books.ROLES;
create table BOOKAUTHOR as select * from books.BOOKAUTHOR;
create table CUSTOMERS as select * from books.CUSTOMERS;  
  
drop table AUTHOR;
drop table ORDERS;
drop table PROMOTION;
drop table ROLES;
drop table ORDERITEMS;
drop table ACTORS;
drop table BOOKAUTHOR;
drop table BOOKS;
drop table MOVIES;
drop table PUBLISHER;
drop table CUSTOMERS;  

create table MOVIES as select * from books.MOVIES where 1=2 ;
create table ORDERITEMS as select * from books.ORDERITEMS where 1=2 ;
create table PROMOTION as select * from books.PROMOTION where 1=2 ;
create table BOOKAUTHOR as select * from books.BOOKAUTHOR where 1=2 ;
create table ACTORS as select * from books.ACTORS where 1=2 ;
create table ORDERS as select * from books.ORDERS where 1=2 ;
create table AUTHOR as select * from books.AUTHOR where 1=2 ;
create table BOOKS as select * from books.BOOKS where 1=2 ;
create table PUBLISHER as select * from books.PUBLISHER where 1=2 ;
create table CUSTOMERS as select * from books.CUSTOMERS where 1=2 ;
create table ROLES as select * from books.ROLES where 1=2 ;
 
    
    select distinct 'create table ' || table_name || ' as select * from books.' || table_name || ';'
    from all_tab_columns
    where owner = 'BOOKS';

    -- what if column not big enough?
    -- start inserts problem
    -- techonthenet solution
    -- rollback then fix then insert again
    commit;
    Insert into BOOKS  values ('2229831198','10 MINUTES A DAY',to_date('21-JAN-01','DD-MON-RR'),4,18.75,40.25,'FITNESS');
    Insert into BOOKS  values ('3331140733','MICKEY',to_date('14-DEC-01','DD-MON-RR'),1,22.2,34.33,'FAMILY LIFE');
    Insert into BOOKS  values ('4444341710','CAR WITH TOOTHPICKS',to_date('18-MAR-02','DD-MON-RR'),2,17.9,59.95,'CHILDREN');
    Insert into BOOKS  values ('5555172113','IMPLEMENTATION',to_date('04-JUN-99','DD-MON-RR'),3,31.4,355.95,'COMPUTER');
    Insert into BOOKS  values ('6666612490','WITH MUSHROOMS',to_date('28-FEB-00','DD-MON-RR'),4,12.5,445.95,'COOKING');
    Insert into BOOKS  values ('7777136468','OF ORACLE',to_date('31-DEC-01','DD-MON-RR'),3,47.25,25.95,'COMPUTER');
    Insert into BOOKS  values ('AAA5762492','HANDCRANKED',to_date('21-JAN-01','DD-MON-RR'),3,21.8,12.5,'COMPUTER');
    Insert into BOOKS  values ('BBBB789321','THE EASY WAY',to_date('01-MAR-02','DD-MON-RR'),2,37.9,12.5,'COMPUTER');
    Insert into BOOKS  values ('CCCC748320','CHILD-REARING',to_date('17-JUL-00','DD-MON-RR'),5,48,99.95,'FAMILY LIFE');
    Insert into BOOKS  values ('DDDD282519','WAY TO COOK',to_date('11-SEP-00','DD-MON-RR'),4,19,338.75,'COOKING');
    Insert into BOOKS  values ('EEEE949391','BIG BEAR AND LITTLE DOVE',to_date('08-NOV-01','DD-MON-RR'),5,555.32,8.95,'CHILDREN');
    Insert into BOOKS  values ('FFFF149871','FASTER PIZZA',to_date('11-NOV-02','DD-MON-RR'),4,17.85,99.95,'SELF HELP');
    Insert into BOOKS  values ('GGGG381001','THE MANAGER',to_date('09-MAY-99','DD-MON-RR'),1,15.4,22.95,'BUSINESS');
    Insert into BOOKS  values ('HHHH428890','POEMS',to_date('01-MAY-01','DD-MON-RR'),5,21.85,22.95,'LITERATURE');
  
-- =============================================================================    
-- 2. REVIEW RESULT SETS FROM EARLIER CHAPTERS: as if they were the inner query
-- -----------------------------------------------------------------------------
--  SINGLE ROW
    select *
    from books
    where title like '%WOK%';


-- SCALAR = SINGLE ROW WITH SINGLE COLUMN 
    select title
    from books
    where title like '%WOK%';

--  MULTIPLE ROW & MULTIPLE COLUMN 
    select * from books where category = 'COMPUTER';


-- MULTIPLE COLUMN (3 columns as example)
-- Single Row
   Select isbn, title, category
   from books
   where title like '%WOK%';
   

-- Multiple Row
   select isbn, title, category
   from books
   where category = 'COMPUTER';



-- ==============================================================================================
-- 3. RELATIONSHIP BETWEEN PARENT (OUTER) AND CHILD (INNER) SUB QUERIES
-- -----------------------------------------------------------------------------------------------
--    NON-CORRELATED SUBQUERY EXAMPLE NO. 1
--    return all of Al Smiths ship mates
      select * 
      from employees
      where first_name = 'Al' and last_name = 'Smith';

select * 
from employees 
where ship_id = 
               (
                  select ship_id 
                  from employees
                  where first_name = 'Al' and last_name = 'Smith'
               )  
  and first_name <> 'Al' and last_name <> 'Smith'                
;

-- -----------------------------------------------------------------------------------------------
--    NON-CORRELATED SUBQUERY EXAMPLE NO. 21
--    a. Inner query runs once and runs first
--    b. When nesting following same rules and parenthesis in math 
--    c. The outer query uses its subquery to answer T/F for every row in outer query
--    d. No dependency


select *
from somewhere
where somecolumn = (
                    select No1
                    from xyz
                    where col2 = 
                                    (
                                        Select No2
                                        from abc
                                        where col3 =
                                                      ( select no3
                                                        from mln
                                                        where col4 = 4
                                                       )
                                    )
                  )
;


-- -----------------------------------------------------------------------------------------------
-- CORRELATED SUBQUERY
      --     1. Outer query where stops on row 1
      --     2. Outer passes some value from Row 1 into subquery
      --     3. Inner query runs using that passed value
      --     4. Inner query passes that value back to outer
      --     5. Outer uses that to complete its work on that row
      --     6. Outer where moves to next row
      --     7. Repeat Step nos. 2-6 for each row in the outer query
      --     NOTES: Inner canot run by iteself
      --            Inner runs once for every row of the outer query
-- -----------------------------------------------------------------------------------------------
-- CORRELATED EXAMPLE No. 1  
    select distinct owner, table_name
    from all_tab_columns where table_name like 'TUITION%';
    
    -- CORRELATED SUBQUERY
    select   state
           , (
               select region
               from states
               where t.state = st
               ) as region
    from tuition t;
    
    select * from states;
    Select * from tuition;
    select st, region from states;
    select type_inst from tuition;
-- -----------------------------------------------------------------------------------------------
-- CORRELATED EXAMPLE No. 2           
-- Return title, retail, category of books where retail > avg retail 
--  of title category
--  Outer query workbench
    select title, retail, category
    from books;
--  Inner Query Workbench     
    select category, avg(retail)
    from books
    group by category;
    
    
    
--  Final Inner/Outer query
    select title, retail, category
    from books books_outer -- aka books1
    where retail > 
                   (
                    select avg(retail) 
                    from books books_inner -- aka books2
                    where books_inner.category = books_outer.category
                   );
--   1. Outer query where stops on row 1
--   2. Outer passes some value from Row 1 into subquery
--   3. Inner query runs using that passed value
--   4. Inner query passes that result back to outer
--   5. Outer uses that result to complete its work on that row
--   6. Outer where moves to next row
--   7. Repeat Step nos. 2-6 for each row in the outer query

    select avg(retail)
    from books 
    where category = 'COMPUTER';
                   
--PAINLESS CHILD-REARING	89.95	FAMILY LIFE
--IMPLEMENTATION	355.95	COMPUTER
--WITH MUSHROOMS	445.95	COOKING
--CHILD-REARING	99.95	FAMILY LIFE
--WAY TO COOK	338.75	COOKING
--FASTER PIZZA	99.95	SELF HELP
--
    
    select * from books;
   
    select title, retail, category
    from books
    where title = 'HOLY GRAIL OF ORACLE';
    

    
    select title, retail, category
    from books
    where category = 'COMPUTER'
      and retail < 77.29; 

-- ==============================================================================================
-- 4. LOCATIONS:
--    SELECT CLAUSE  
--        NOTE: the subquery must return 1 row and 1 col only (scalar)
--              Remember the select clause brings back one value in each column
--              for each row marked T
-- INST_TYPE in the tuition table that is numeric
-- we want the english description of that numerical value
        select type_inst from tuition;
        select * from school_type;
        
--      LOCATION SELECT
        select type_inst
               , (
                    select type_name
                    from school_type st
                    where st.type_id = t.type_inst
                  ) as TypeOfInstitution            
        from tuition t;
 

-- -----------------------------------------------------------------------------------------------
--    FROM CLAUSE 
--     Subquery result set must be given alias, which is then treated just like a table name  
--     Subquery result set can have many rows and many columns
--     LOCATION EXAMPLE: FROM CLAUSE
--      LOCATION FROM
        select type_inst, type_name
        from tuition,
             (select type_id, type_name
              from school_type)
        where type_id = type_inst;       
        
        
        
        
        
        
        
        select state, region
        from  tuition t
             , (
                 select st, region
                 from states
                ) sts
        where t.state = sts.st;   


 
 
-- -----------------------------------------------------------------------------------------------
--    WHERE CLAUSE (Table 9.1 page 353 and 9.2 page 355)
--      Because the main job of where is to produce T or F
--      We have to make certain we are using the same number and type of expressions
--         on both sides of the relational operators (Table 9.1 page 353)
--      And when we cannot then use the relational operators (Table 9.2 page 355  also Page 173)
--
--      LOCATION WHERE
        select employee_id, last_name, first_name
        from cruises.employees
        where ship_id =
                        (
                          select ship_id
                          from cruises.employees
                          where first_name = 'Al' and last_name = 'Smith'
                         );

-- -----------------------------------------------------------------------------------------------
--    Suqueries used with between (scalar results)
--    someColumn between value1 and value2
--    Value1 and value2 must each scalar (one value)
      select title, retail, category
      from books 
      where retail between
                    ( select min(retail)
                      from books 
                      where category = 'COMPUTER'
                    )
                   and 
                   (select max(retail)
                    from books where category = 'CHILDREN'
                    )
      ;              
-- ------------------------------------------
      -- Having clause 
     select category, avg(retail)
     from books
     group by category
     having avg(retail) > ( 
                               select min(retail)
                               from books
                               where category = 'CHILDREN'
                          );
-- ------------------------------------------
--   5.  REVIEW RELATIONAL OPERATORS 
--       Need same number and datatype on both sides
         Select * 
         from books
         where retail < 25;

-- ------------------------------------------
        select *
        from books
        where retail in (75.95,25,54.5);
-- ------------------------------------------
        select *
        from books
        where retail = ANY (75.95, 25, 54.95);

        select *
        from books
        where retail = SOME (75.95, 25, 54.95);
        
        select *
        from books
        where retail >= ALL (75.95, 25, 54.95);
        
         select *
        from books
        where retail <= ALL (75.95, 25, 54.95);
        
        select * 
        from books
      where retail <= all (
                          select retail
                          from books
                        );  
-- ------------------------------------------
               

-- ------------------------------------------



-- ------------------------------------------



-- ------------------------------------------
--    RELATIONAL OPERATORS USING SUBQUEURY IN WHERE EXAMPLE No. 1     outerQueryValue1 = subqueryValue1  
--    Left side of operator (=) there is only one ship_id on each row
--    Right side can then return only one value
--    
--    The sql for this is above
--    and the3 question it answers is: return all Al Smiths shipmates
--    without listing Al Smith
      
-- -----------------------------------------------------------------------------------------------
--    RELATIONAL OPERATORS USING SUBQUEURY IN WHERE EXAMPLE No. 2     (outerQueryValue1,outerQueryValue2)  = (subqueryValue1, outerQueryValue1)
--    Left side of operator (=) there is exactly one first, and one last
--    So our query must return exactly one first name and one last name
--    If we want to use = we have to have the same number of first_name,last_name on the left as the right side of =
      select employee_id, last_name, first_name
      from employees
      where (first_name, last_name) in
                                      (
                                       select first_name, last_name
                                       from cruise_customers
                                      )
       ;                  
-- -----------------------------------------------------------------------------------------------
--    CLASS QUESTION: WHAT DOES THIS BRING BACK
--
     select title, retail, category
     from books b1
     where retail < 
                    (
                        select avg(retail)
                        from books b2
                        where b2.category = b1.category
                     );
-- 
select p.country, p.port_name, p.capacity
from ports p
where p.port_id = ANY (
                          select home_port_id
                          from ships
                          where length > 900
                    );
                    
select * from ports;
select * from ships;


-- WITH SQL STATEMENTS
with port_bookings as
     (
        select p.port_id, p.port_name, count(s.ship_name) as ship_count
        from ports p join ships s on p.port_id = s.home_port_id
        group by p.port_id, p.port_name      
     ),
     densest_port as
     (
        select max(ship_count) as max_count
        from port_bookings
     )
select * from port_bookings
where ship_count = 
                    (
                      select max_count
                      from densest_port
                    );
-- INSERT, UPDATE, DELETE using Sub Queries
-- Setup
Create table accounts
(acct_number integer primary key 
, fname varchar2(100)
, lname varchar2(100)
, balance number(7,2)
, last_transfer_date date
);
--
create table transfer_history
(t_id  integer primary key
, acct# integer
, transfer_type    varchar2(10) check (transfer_type in ('CREDIT', 'TRANSFER'))
, notes            varchar2(2000)
, status           varchar2(20) check (status in ('FAILED','SUCCEEDED'))
, transfer_amt     number(7,2)
);
create table pending_transfers
( pt_id integer primary key
, status_date date
, acct_no integer
, transfer_type  varchar2(10) check (transfer_type in ('CREDIT', 'DEBIT'))
, notes  varchar2(2000) 
, transfer_amt  number(7,2)
, transfer_status varchar2(20) check (transfer_status in ('READY','HOLD','RELEASED'))
);
create table pt_queue
(ptq_id integer primary key
, queue_status varchar2(6) check (queue_status in ('QUEUED','DONE'))
);

create sequence tx_seq;


