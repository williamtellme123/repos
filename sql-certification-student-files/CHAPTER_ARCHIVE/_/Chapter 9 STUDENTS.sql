-- =============================================================================
/* 
    Define Subqueries
    Describe the Types of Problems That Subqueries Can Solve
    List the Types of Subqueries
    Write Single-Row and Multiple-Row Subqueries
    Write a Multiple-Column Subquery
    Use Scalar Subqueries in SQL
    Solve Problems with Correlated Subqueries
    Insert, update, and delete Rows Using Correlated Subqueries
    Use the EXISTS and NOT EXISTS Operators
    Use the WITH Clause
   
   SUB QUERIES
        
        OVERVIEW
        Saying Query B is a sub query of Query A means the same as: 
          Query A contains Query B
          Query A is the outer query and Query B is the inner query
          Query A is the parent query and Query B is the child query
        
        Used: perform one operation which requires 2 distinct parts that cannot be run in the same single SQL
        Because the outer query relies on the results of the inner query's result set. Lets review.
        
        1. REVIEW RESULT SETS:
          Where and how used depends on understanging the three types of result sets
            Scalar (one row and one column)
            Multiple row                                                NOTE: Additiional Operators (ANY, SOME, ALL on Pg. 355) 
            Multiple column
        
        2. RELATIONSHIP BETWEEN INNER AND OUTER:
          A subquery is either
            Correlated 
              References one or more columns in outer
            Non-correlated
              Completely independent of outer
        
        3. LOCATIONS:
            A SQL subquery is nested inside one of the following  (always in parenthesis)
              SELECT field1, field2, (subquery) 
                FROM (subquery)
                WHERE field1 >= (subquery)                                NOTE: Additiional Operators (ANY, SOME, ALL on Pg. 355) 
                HAVING aggregateFunction(field2) > (subquery)
            
        4. SQL "WITH" STATEMENT SUBQUERIES

        5. SUBQUERIES 
              INSERT
              UPDATE 
              DELETE
              
 */
-- SETUP
--Insert into ship_cabins (SHIP_CABIN_ID,SHIP_ID,ROOM_NUMBER,ROOM_STYLE,ROOM_TYPE,WINDOW,GUESTS,SQ_FT,BALCONY_SQ_FT) values (30,2,'1241','Suite','Standard','Balcony',4,156,144);
--Insert into ship_cabins (SHIP_CABIN_ID,SHIP_ID,ROOM_NUMBER,ROOM_STYLE,ROOM_TYPE,WINDOW,GUESTS,SQ_FT,BALCONY_SQ_FT) values (31,2,'1242','Stateroom','Standard','Ocean',2,280,null);
--Insert into ship_cabins (SHIP_CABIN_ID,SHIP_ID,ROOM_NUMBER,ROOM_STYLE,ROOM_TYPE,WINDOW,GUESTS,SQ_FT,BALCONY_SQ_FT) values (32,2,'1243','Suite','Standard','Balcony',4,1247,425);
--Insert into ship_cabins (SHIP_CABIN_ID,SHIP_ID,ROOM_NUMBER,ROOM_STYLE,ROOM_TYPE,WINDOW,GUESTS,SQ_FT,BALCONY_SQ_FT) values (33,2,'1244','Stateroom','Standard','Ocean',3,1151,null);
--Insert into ship_cabins (SHIP_CABIN_ID,SHIP_ID,ROOM_NUMBER,ROOM_STYLE,ROOM_TYPE,WINDOW,GUESTS,SQ_FT,BALCONY_SQ_FT) values (34,2,'1245','Suite','Standard','Balcony',6,1749,425);
--Insert into ship_cabins (SHIP_CABIN_ID,SHIP_ID,ROOM_NUMBER,ROOM_STYLE,ROOM_TYPE,WINDOW,GUESTS,SQ_FT,BALCONY_SQ_FT) values (35,2,'1246','Suite','Royal','Balcony',5,729,843);
--Insert into ship_cabins (SHIP_CABIN_ID,SHIP_ID,ROOM_NUMBER,ROOM_STYLE,ROOM_TYPE,WINDOW,GUESTS,SQ_FT,BALCONY_SQ_FT) values (36,2,'1247','Stateroom','Large','None',2,333,null);
--Insert into ship_cabins (SHIP_CABIN_ID,SHIP_ID,ROOM_NUMBER,ROOM_STYLE,ROOM_TYPE,WINDOW,GUESTS,SQ_FT,BALCONY_SQ_FT) values (37,2,'1248','Stateroom','Standard','Ocean',2,548,476);
--Insert into ship_cabins (SHIP_CABIN_ID,SHIP_ID,ROOM_NUMBER,ROOM_STYLE,ROOM_TYPE,WINDOW,GUESTS,SQ_FT,BALCONY_SQ_FT) values (38,2,'1249','Stateroom','Large','Ocean',2,337,null);
--Insert into ship_cabins (SHIP_CABIN_ID,SHIP_ID,ROOM_NUMBER,ROOM_STYLE,ROOM_TYPE,WINDOW,GUESTS,SQ_FT,BALCONY_SQ_FT) values (39,2,'1250','Suite','Presidential','Balcony',5,725,476);
--Insert into ship_cabins (SHIP_CABIN_ID,SHIP_ID,ROOM_NUMBER,ROOM_STYLE,ROOM_TYPE,WINDOW,GUESTS,SQ_FT,BALCONY_SQ_FT) values (40,2,'1251','Suite','Presidential','Balcony',5,336,null);
--Insert into ship_cabins (SHIP_CABIN_ID,SHIP_ID,ROOM_NUMBER,ROOM_STYLE,ROOM_TYPE,WINDOW,GUESTS,SQ_FT,BALCONY_SQ_FT) values (41,2,'1252','Suite','Royal','Balcony',5,244,374);
--Insert into ship_cabins (SHIP_CABIN_ID,SHIP_ID,ROOM_NUMBER,ROOM_STYLE,ROOM_TYPE,WINDOW,GUESTS,SQ_FT,BALCONY_SQ_FT) values (42,2,'1253','Suite','Skyloft','Balcony',8,257,410);
--Insert into ship_cabins (SHIP_CABIN_ID,SHIP_ID,ROOM_NUMBER,ROOM_STYLE,ROOM_TYPE,WINDOW,GUESTS,SQ_FT,BALCONY_SQ_FT) values (43,2,'1254','Stateroom','Standard','Ocean',2,130,null);
--Insert into ship_cabins (SHIP_CABIN_ID,SHIP_ID,ROOM_NUMBER,ROOM_STYLE,ROOM_TYPE,WINDOW,GUESTS,SQ_FT,BALCONY_SQ_FT) values (44,2,'1255','Suite','Standard','Balcony',4,170,144);
--Insert into ship_cabins (SHIP_CABIN_ID,SHIP_ID,ROOM_NUMBER,ROOM_STYLE,ROOM_TYPE,WINDOW,GUESTS,SQ_FT,BALCONY_SQ_FT) values (45,2,'1256','Stateroom','Standard','Ocean',3,124,null);
--Insert into ship_cabins (SHIP_CABIN_ID,SHIP_ID,ROOM_NUMBER,ROOM_STYLE,ROOM_TYPE,WINDOW,GUESTS,SQ_FT,BALCONY_SQ_FT) values (46,2,'1257','Suite','Standard','Balcony',6,132,193);
--Insert into ship_cabins (SHIP_CABIN_ID,SHIP_ID,ROOM_NUMBER,ROOM_STYLE,ROOM_TYPE,WINDOW,GUESTS,SQ_FT,BALCONY_SQ_FT) values (47,2,'1258','Stateroom','Large','None',2,153,null);
--Insert into ship_cabins (SHIP_CABIN_ID,SHIP_ID,ROOM_NUMBER,ROOM_STYLE,ROOM_TYPE,WINDOW,GUESTS,SQ_FT,BALCONY_SQ_FT) values (48,2,'1259','Stateroom','Standard','Ocean',2,152,null);
--Insert into ship_cabins (SHIP_CABIN_ID,SHIP_ID,ROOM_NUMBER,ROOM_STYLE,ROOM_TYPE,WINDOW,GUESTS,SQ_FT,BALCONY_SQ_FT) values (49,2,'1260','Suite','Presidential','None',5,1247,325);
--Insert into ship_cabins (SHIP_CABIN_ID,SHIP_ID,ROOM_NUMBER,ROOM_STYLE,ROOM_TYPE,WINDOW,GUESTS,SQ_FT,BALCONY_SQ_FT) values (50,2,'1261','Suite','Presidential','Ocean',5,1247,null);
--Insert into ship_cabins (SHIP_CABIN_ID,SHIP_ID,ROOM_NUMBER,ROOM_STYLE,ROOM_TYPE,WINDOW,GUESTS,SQ_FT,BALCONY_SQ_FT) values (51,2,'1262','Suite','Royal','Ocean',5,1247,null);
--Insert into ship_cabins (SHIP_CABIN_ID,SHIP_ID,ROOM_NUMBER,ROOM_STYLE,ROOM_TYPE,WINDOW,GUESTS,SQ_FT,BALCONY_SQ_FT) values (52,2,'1263','Suite','Skyloft','Ocean',8,1150,225);
--Insert into ship_cabins (SHIP_CABIN_ID,SHIP_ID,ROOM_NUMBER,ROOM_STYLE,ROOM_TYPE,WINDOW,GUESTS,SQ_FT,BALCONY_SQ_FT) values (53,2,'1264','Stateroom','Standard','Ocean',2,185,null);
--Insert into ship_cabins (SHIP_CABIN_ID,SHIP_ID,ROOM_NUMBER,ROOM_STYLE,ROOM_TYPE,WINDOW,GUESTS,SQ_FT,BALCONY_SQ_FT) values (54,2,'1265','Suite','Standard','Ocean',4,622,150);
--Insert into ship_cabins (SHIP_CABIN_ID,SHIP_ID,ROOM_NUMBER,ROOM_STYLE,ROOM_TYPE,WINDOW,GUESTS,SQ_FT,BALCONY_SQ_FT) values (55,2,'1266','Stateroom','Standard','Ocean',3,301,null);
--Insert into ship_cabins (SHIP_CABIN_ID,SHIP_ID,ROOM_NUMBER,ROOM_STYLE,ROOM_TYPE,WINDOW,GUESTS,SQ_FT,BALCONY_SQ_FT) values (56,2,'1267','Suite','Standard','None',6,654,225);
--Insert into ship_cabins (SHIP_CABIN_ID,SHIP_ID,ROOM_NUMBER,ROOM_STYLE,ROOM_TYPE,WINDOW,GUESTS,SQ_FT,BALCONY_SQ_FT) values (57,2,'1268','Stateroom','Large','None',2,250,null);
--Insert into ship_cabins (SHIP_CABIN_ID,SHIP_ID,ROOM_NUMBER,ROOM_STYLE,ROOM_TYPE,WINDOW,GUESTS,SQ_FT,BALCONY_SQ_FT) values (58,2,'1269','Stateroom','Standard','Ocean',2,345,null);
--insert into cruise_customers values (4,'Mike','West');
--insert into cruise_customers values (5,'Al','Smith');
--insert into cruise_customers values (6,'Trish','West');
--insert into cruise_customers values (7,'Sammy','Teo');
--insert into cruise_customers values (8,'Sully','Westcott');
--insert into cruise_customers values (9, 'Tim','Falco');
--Insert into employees values (8,1,'Harvey','Goldstein',2,null,null,null);
--Insert into employees values (9,3,'Sully','Westcott',2,null,null,null);
--Insert into employees values (10,4,'Sammy','Teo',2,null,null,null);
--Insert into employees values (11,3,'Amy','Lee',2,null,null,null);
--Insert into employees values (12,1,'Sully','Westcott',2,null,null,null);
--Insert into employees values (13,2,'Tim','Falco',2,null,null,null);
--Insert into employees values (14,1,'Susan','Thomas',2,null,null,null);
--commit;
--select * from cruises;
insert into cruises values(1,1,'ISLAND',1,5,'01-JAN-2012','01-JAN-2012','DOCK');
insert into cruises values(2,1,'ISLAND',1,5,'01-JAN-2012','01-JAN-2012','DOCK');
insert into cruises values(3,2,'ISLAND',1,5,'01-JAN-2012','01-JAN-2012','DOCK');
insert into cruises values(4,2,'ISLAND',2,5,'01-JAN-2012','01-JAN-2012','DOCK');
insert into cruises values(5,3,'ISLAND',2,5,'01-JAN-2012','01-JAN-2012','DOCK');
insert into cruises values(6,2,'ISLAND',2,5,'01-JAN-2012','01-JAN-2012','DOCK');
insert into cruises values(7,1,'ISLAND',1,5,'01-JAN-2012','01-JAN-2012','DOCK');
insert into cruises values(8,1,'ISLAND',1,5,'01-JAN-2012','01-JAN-2012','DOCK');
insert into cruises values(9,2,'ISLAND',1,5,'01-JAN-2012','01-JAN-2012','DOCK');
insert into cruises values(10,2,'ISLAND',2,5,'01-JAN-2012','01-JAN-2012','DOCK');
insert into cruises values(11,3,'ISLAND',2,5,'01-JAN-2012','01-JAN-2012','DOCK');
insert into cruises values(12,2,'ISLAND',2,5,'01-JAN-2012','01-JAN-2012','DOCK');
--select * from cruise_orders;
--insert into cruise_orders values (1,sysdate,sysdate,1,2);
--insert into cruise_orders values (2,sysdate,sysdate,2,1);
--insert into cruise_orders values (3,sysdate,sysdate,3,2);
--insert into cruise_orders values (4,sysdate,sysdate,4,1);
--insert into cruise_orders values (5,sysdate,sysdate,2,2);
--insert into cruise_orders values (6,sysdate,sysdate,3,1);
--insert into cruise_orders values (7,sysdate,sysdate,3,2);
--commit;

select * from cruise_orders;
select * from cruises;
--insert into cruise_orders values (1,sysdate,sysdate,100,2);
--1	Eastern Carribean	3
--2	Eastern Carribean	5
--3	Western Carribean	3
--4	Western Carribean	5
--5	Transatlantic	3
-- commit;
 
-- =============================================================================    
-- 1. REVIEW RESULT SETS:
-- SINGLE ROW
    Select * from books where title like '%TOOTH%';
-- SCALAR = SINGLE ROW WITH SINGLE COLUMN 
    select max(retail) from books;
    Select isbn from books where title like '%TOOTH%';
-- MULTIPLE ROW
    select * from customers where state = 'FL';
    select order#, orderdate, shipdate
    from orders where customer# = 1001;
-- MULTIPLE COLUMN
-- Single Row
    select order#, max(orderdate)
    from orders where customer# = 1004
    group by order#;
-- Multiple Row
    select order#, max(orderdate)
    from orders where customer# = 1001
    group by order#;

-- ==============================================================================================
-- 2. RELATIONSHIP BETWEEN INNER AND OUTER:
-- -----------------------------------------------------------------------------------------------
--    NON-CORRELATED SUBQUERY EXAMPLE NO. 1 
      Select title
      from books
      where retail > (select avg(retail)
                      from books);
-- -----------------------------------------------------------------------------------------------
--    NON-CORRELATED SUBQUERY EXAMPLE NO. 21
--    a. Inner query runs once and runs first
--    b. When nesting following same rules and parenthesis in math 
--    c. The outer query uses its subquery to answer T/F for every row in outer query
--    d. No dependency
      select employee_id, last_name, first_name
      from employees
      where ship_id = (
                      select ship_id
                       from employees
                       where first_name = 'Alice'
                         and last_name = 'Lindon'
                       );
      and first_name <> 'Alice'
      and last_name <> 'Lindon';
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
      select category, title, retail
      from books b1
      where b1.retail < (
                           select avg(retail)
                           from books b2
                           where b2.category = b1.category
                         );
                         
select * from books; 
--Insert into BOOKS (ISBN,TITLE,PUBDATE,PUBID,COST,RETAIL,CATEGORY) values ('2229831198','10 MINUTES A DAY',to_date('21-JAN-01','DD-MON-RR'),4,18.75,40.25,'FITNESS');
--Insert into BOOKS (ISBN,TITLE,PUBDATE,PUBID,COST,RETAIL,CATEGORY) values ('3331140733','MICKEY',to_date('14-DEC-01','DD-MON-RR'),1,22.2,34.33,'FAMILY LIFE');
--Insert into BOOKS (ISBN,TITLE,PUBDATE,PUBID,COST,RETAIL,CATEGORY) values ('4444341710','CAR WITH TOOTHPICKS',to_date('18-MAR-02','DD-MON-RR'),2,17.9,59.95,'CHILDREN');
--Insert into BOOKS (ISBN,TITLE,PUBDATE,PUBID,COST,RETAIL,CATEGORY) values ('5555172113','IMPLEMENTATION',to_date('04-JUN-99','DD-MON-RR'),3,31.4,355.95,'COMPUTER');
--Insert into BOOKS (ISBN,TITLE,PUBDATE,PUBID,COST,RETAIL,CATEGORY) values ('6666612490','WITH MUSHROOMS',to_date('28-FEB-00','DD-MON-RR'),4,12.5,445.95,'COOKING');
--Insert into BOOKS (ISBN,TITLE,PUBDATE,PUBID,COST,RETAIL,CATEGORY) values ('7777136468','OF ORACLE',to_date('31-DEC-01','DD-MON-RR'),3,47.25,25.95,'COMPUTER');
--Insert into BOOKS (ISBN,TITLE,PUBDATE,PUBID,COST,RETAIL,CATEGORY) values ('AAAA5762492','HANDCRANKED',to_date('21-JAN-01','DD-MON-RR'),3,21.8,12.5,'COMPUTER');
--Insert into BOOKS (ISBN,TITLE,PUBDATE,PUBID,COST,RETAIL,CATEGORY) values ('BBBB789321','THE EASY WAY',to_date('01-MAR-02','DD-MON-RR'),2,37.9,12.5,'COMPUTER');
--Insert into BOOKS (ISBN,TITLE,PUBDATE,PUBID,COST,RETAIL,CATEGORY) values ('CCCC748320','CHILD-REARING',to_date('17-JUL-00','DD-MON-RR'),5,48,99.95,'FAMILY LIFE');
--Insert into BOOKS (ISBN,TITLE,PUBDATE,PUBID,COST,RETAIL,CATEGORY) values ('DDDD282519','WAY TO COOK',to_date('11-SEP-00','DD-MON-RR'),4,19,338.75,'COOKING');
--Insert into BOOKS (ISBN,TITLE,PUBDATE,PUBID,COST,RETAIL,CATEGORY) values ('EEEE949391','BIG BEAR AND LITTLE DOVE',to_date('08-NOV-01','DD-MON-RR'),5,555.32,8.95,'CHILDREN');
--Insert into BOOKS (ISBN,TITLE,PUBDATE,PUBID,COST,RETAIL,CATEGORY) values ('FFFF149871','FASTER PIZZA',to_date('11-NOV-02','DD-MON-RR'),4,17.85,99.95,'SELF HELP');
--Insert into BOOKS (ISBN,TITLE,PUBDATE,PUBID,COST,RETAIL,CATEGORY) values ('GGGG381001','THE MANAGER',to_date('09-MAY-99','DD-MON-RR'),1,15.4,22.95,'BUSINESS');
--Insert into BOOKS (ISBN,TITLE,PUBDATE,PUBID,COST,RETAIL,CATEGORY) values ('HHHH428890','POEMS',to_date('01-MAY-01','DD-MON-RR'),5,21.85,22.95,'LITERATURE');
--select * from cruise_orders

commit;

                         
      select count(*), avg(retail) from books where category = 'FAMILY LIFE';
      select * from books where category = 'FAMILY LIFE';
      select count(*) from books;
-- -----------------------------------------------------------------------------------------------
-- CORRELATED EXAMPLE No. 2           
      select firstname, lastname, state, order#, shipstate
      from customers c, orders o
      where c.customer# = o.customer#
      and state IN (select shipstate
                        from orders o
                        where o.customer# = c.customer#)
      order by lastname;
-- ==============================================================================================
-- 3. LOCATIONS:
--    SELECT CLAUSE  
--        NOTE: the subquery must return 1 row and 1 col only (scalar)
--              Remember the select clause brings back one value in each column
--              for each row marked T
      select b1.title
                 ,(select avg(retail) from books b2 where b1.category = b2.category)as avg_cat    -- CORRELATED
                 ,(select sysdate from dual) as mydate                                            -- NON-CORRELATED
                 , cost  
                 , category
          from books b1;
-- -----------------------------------------------------------------------------------------------
--    FROM CLAUSE 
--     Subquery result set must be given alias, which is then treated just like a table name  
--     Subquery result set can have many rows and many columns
        select a.ship_id, a.count_cabins, b.count_cruises
        from 
              (
                select ship_id, count(ship_cabin_id) count_cabins
                from ship_cabins
                group by ship_id
              ) a 
          join
              (
                select ship_id, count(cruise_order_id) count_cruises
                from cruise_orders
                group by ship_id
              ) b
          on a.ship_id = b.ship_id
 ;
 
 
-- -----------------------------------------------------------------------------------------------
--    WHERE CLAUSE (Table 9.1 page 353 and 9.2 page 355)
--      Because the main job of where is to produce T or F
--      We have to make certain we are using the same number and type of expressions
--         on both sides of the relational operators (Table 9.1 page 353)
--      And when we cannot then use the relational operators (Table 9.2 page 355  also Page 173)
--
-- -----------------------------------------------------------------------------------------------
--    Suqueries used with between (scalar results)
--    someColumn between value1 and value2
--    Value1 and value2 must each scalar (one value)
      select title
      from books 
      where retail between (select min(retail) from books where category = 'COMPUTER') and
                            (select max(retail) from books where category = 'CHILDREN');
select category, retail from books order by 1,2;                            
-- ------------------------------------------
      -- Having clause 
      select title, avg(retail)
      from books 
      where retail between (select min(retail) from books where category = 'COMPUTER') and
                            (select Max(retail) from books where category = 'CHILDREN')
      group by title
      having avg(retail) > (select min(retail) from books where category = 'COMPUTER');

-- ------------------------------------------
--    REVIEW relational operators need same number and datatype on both sides
      select * 
      from books
      where retail < 25;
-- ------------------------------------------
      select * 
      from books
      where retail = 25;
-- ------------------------------------------
      select *
      from books
      where retail =some (75.95, 25, 54.5);
-- ------------------------------------------
      select *
      from books
      where retail > any (75.95, 25, 54.5);
-- ------------------------------------------
      select *
      from books
      where retail > all (75.95, 25, 54.5);   -- what is this returning
-- ------------------------------------------
      select *
      from books
      where retail < any (75.95, 25, 54.5);  -- what is this returning
-- ------------------------------------------
      select *
      from books
      where retail <=all (select retail from books);
-- ------------------------------------------



     select *
      from books
      where retail >=all (select retail from books);      
-- ------------------------------------------
      select *
      from books
      where retail <= all  (select retail from books);  -- what is this returning   




-- ------------------------------------------
      select *
      from books
      where retail >= all  (select retail from books);  -- what is this returning   
-- ------------------------------------------
--    RELATIONAL OPERATORS USING SUBQUEURY IN WHERE EXAMPLE No. 1     outerQueryValue1 = subqueryValue1  
--    Left side of operator (=) there is only one ship_id on each row
--    Right side can then return only one value
      select employee_id, last_name, first_name
      from employees
      where ship_id = (
                         select ship_id
                         from employees
                         where first_name = 'Alice'
                           and last_name = 'Lindon'
                       )
      and first_name <> 'Alice'
      and last_name <> 'Lindon';
-- -----------------------------------------------------------------------------------------------
--    RELATIONAL OPERATORS USING SUBQUEURY IN WHERE EXAMPLE No. 2     (outerQueryValue1,outerQueryValue2)  = (subqueryValue1, outerQueryValue1)
--    Left side of operator (=) there is exactly one first, and one last
--    So our query must return exactly one first name and one last name
--    If we want to use = we have to have the same number of first_name,last_name on the left as the right side of =
      select employee_id, last_name, first_name
      from employees
      where (first_name,last_name) =some 
                                      (
                                        select first_name, last_name
                                        from cruise_customers
                                      );
-- -----------------------------------------------------------------------------------------------
--    CLASS QUESTION: WHAT DOES THIS BRING BACK
      select employee_id, last_name, first_name
      from employees 
      where ship_id = ( 
                        select ship_id
                        from employees
                        where last_name = 'Smith' and first_name = 'Al'
                       )
      and first_name <> 'Al'
      and last_name <> 'Smith';
-- -----------------------------------------------------------------------------------------------
--    CLASS QUESTION: WHAT DOES THIS BRING BACK
      select title, retail, category
      from books b
      where retail < (select avg(retail)
                      from books
                      where category = b.category);

-- ==============================================================================================
-- 4. SQL "WITH" STATEMENT SUBQUERIES
-- -----------------------------------------------------------------
with 
    port_bookings as
    (
      select p.port_id, p.port_name, count(s.ship_id) as ct
      from ports p, ships s
      where p.port_id = s.home_port_id
      group by p.port_id,p.port_name
    ),
    densest_port as
    (
      select max(ct) as max_ct
      from port_bookings
    )
select *
from port_bookings
where ct = (
              select max_ct
              from densest_port
            );  


-- ==============================================================================================
--   5. SUBQUERIES 
      --    INSERT
      --    UPDATE 
      --    DELETE
-- -----------------------------------------------------------------------------------------------
--   STUDENT SETUP
drop table accounts;
create table accounts (                                                                       
      acct_num integer primary key                                                            -- 1
    , fname varchar2(100)                                                                     -- 2
    , lname varchar2(100)                                                                     -- 3
    , balance number(7,2)                                                                     -- 4
    , last_transfer_date date);                                                               -- 5
-- -----------------------------------------------------------------------------------------------
drop table transfer_history;
create table transfer_history (
      t_id integer primary key                                                                 -- 1
    , t_date date                                                                              -- 2
    , acct# integer                                                                            -- 3
    , transfer_type varchar2(6) check (transfer_type in ('CREDIT', 'DEBIT'))                   -- 4
    , notes varchar2(2000)                                                                     -- 5
    , status varchar2(10) check (status in ('FAILED', 'SUCCEEDED'))                            -- 6   
    , transfer_amt number(7,2));                                                               -- 7
-- -----------------------------------------------------------------------------------------------
drop table pending_transfers;
create table pending_transfers (
      pt_id integer primary key                                                                -- 1
    , status_date date                                                                         -- 2
    , acct_no integer                                                                          -- 3
    , transfer_type varchar2(6) check (transfer_type in ('CREDIT', 'DEBIT'))                   -- 4
    , notes varchar2(2000)                                                                     -- 5
    , transfer_amt number(7,2)                                                                 -- 6
    , transfer_status varchar2(8) check (transfer_status in ('READY', 'HOLD', 'RELEASED')));   -- 7   
-- -----------------------------------------------------------------------------------------------
drop sequence tx_seq; create sequence tx_seq;
drop table pt_queue;
create table pt_queue (
      ptq_id integer primary key                                                               -- 1
    , queue_status varchar2(8) check (queue_status in ('QUEUED', 'DONE')));                    -- 2   
-- -----------------------------------------------------------------------------------------------
-- INSERT
select * from accounts;
select * from transfer_history;
select * from pending_transfers;
select * from pending_transfer_queue;

begin
  delete from accounts;
  delete from transfer_history;
  delete from pending_transfers;
  delete from pending_transfer_queue;
end;
/
-- ================================================================================================
-- TRANSACTION No. 1: Opens Account with $735.00
-- System inserts null to all the first transaction to be recorded using pending_transactions
insert into accounts values (
         4726980                                                                               -- 1
      , 'Holdem'                                                                               -- 2
      , 'Tightly'                                                                              -- 3
      , null                                                                                   -- 4
      , null); commit;                                                                         -- 5
select * from accounts;
-- -------------------------------------------------------------------------------------------------    
--  Bank accepts $735.00 from Holdem Tightly 
--  Entries are made by the system into 
--   1. pending_transfers table
--   2. pending_transfer_queue
insert into pending_transfers values (
       tx_seq.nextval                                                                          -- 1
    , '22-JAN-2016'                                                                            -- 2
    , '4726980'                                                                                -- 3
    , 'CREDIT'                                                                                 -- 4
    , 'Opening Balance'                                                                        -- 5
    , 735                                                                                      -- 6
    ,'READY');                                                                                 -- 7  
select * from pending_transfers;
-- ---------------------------------------    
insert into pt_queue values (
     tx_seq.currval                                                                            -- 1
    , 'QUEUED');                                                                               -- 2
select * from pending_transfer_queue;  
-- ---------------------------------------    
select * from accounts;
select * from transfer_history;
select * from pending_transfers;
select * from pending_transfer_queue;
-- ---------------------------------------
-- ================================================================================================
-- TRANSACTION No. 2: 
--  Move data 
--     from pending_transactions
--     to transaction_history
--  Subqueries
--     Insertion subquery (notice no parenthesis which is exception)
--     Exists (ensure we do not enter transaction without an acct number
-- ------------------------------------------------------------------------------------------------- 
--  Subqueries will then be used to: 
--  Insert data -> transfer_history from pending_transfers using 
--      insertion subquery (notice no parenthesis which is exception)
--      exists subquery
insert into transfer_history 
select
      pt_id                                                                                    -- 1
    , case when notes = 'Opening Balance' then status_date else sysdate end                    -- 2
    , acct_no                                                                                  -- 3
    , transfer_type                                                                            -- 4
    , notes                                                                                    -- 5
    , case when transfer_status = 'READY' then 'SUCCEEDED' else 'FAILED' end                   -- 6
    , transfer_amt                                                                             -- 7
from pending_transfers pt
where exists (select 
              from accounts a
              where pt.acct_no = a.acct_num);
select * from transfer_history; 
-- ================================================================================================
-- TRANSACTION No. 3: 
--  Update accounts table
--  Subqueries
--     the update statement here is considered parent (set two columns)
--     Subquery No. 1 
--         correlated to update table (parent)
--     Subquery No. 2 
--         correlated to transfer_history to ensure correct account# 
update accounts a
  set ( balance
      , last_transfer_date) =
      (select                                       --     Subquery No. 1
              case 
                  when transfer_type = 'CREDIT' then nvl(balance,0) + transfer_amt 
                  when transfer_type = 'DEBIT' then nvl(balance,0) - transfer_amt 
              end 
            , case when notes = 'Opening Balance' then t_date else sysdate end
         from transfer_history t1                   -- correlated
         where a.acct_num = t1.acct#
         and t_date = (select max(t_date)           --     Subquery No. 2
                        from transfer_history t2
                        where t_id = 2
                            and  t1.acct# = t2.acct#)  -- correlated
      ); 
      select * from transfer_history;
select * from accounts;
-- ================================================================================================
-- TRANSACTION No. 4: 
--  Update pending_transfers to show RELEASED
--  Subqueries
--     Subquery No. 1 
--         correlated to parent (to ensure correct transfer identification)
update pending_transfers pt
 set transfer_status = (select case when Status = 'SUCCEEDED' then 'RELEASED' else 'HOLD' end
                        from transfer_history t1
                        where pt.pt_id = t_id);
select * from pending_transfers;
-- ================================================================================================
-- TRANSACTION No. 5: 
--  Delete transfer from queue
--  Subqueries
--     Subquery No. 1 
--         correlated to parent (to ensure correct transfer identification)
delete pt_queue
where ptq_id = ALL (select pt_id
                    from pending_transfers
                    where transfer_status = 'RELEASED');
select * from accounts;
select * from transfer_history;
select * from pending_transfers;
select * from pt_queue;


-- ==============================================================================================
-- STUDENT EXERCISES
-- ==============================================================================================
-- 1.	Write an English statement in 1-3 sentences that describes what the following query does. 
--    Run it to see what it does before you answer or try to answer first up to you
SELECT *
FROM ship_cabins s
WHERE balcony_sq_ft >
                      (
                        SELECT AVG(balcony_sq_ft)
                         FROM ship_cabins
                         WHERE s.room_type = room_type
                           AND s.room_style  = room_style
                      );
--;or balcony_sq_ft is null;
-- -------------------------------------------------------------------------------------------------    
-- 2.	Return first and last name of the customer(s) who purchased the most books.
--    Is this a correlated or non-correlated query?
-- -------------------------------------------------------------------------------------------------    
-- 3.	Write an English statement in 1-3 sentences that describes what the following query does. 
SELECT employee_id,ship_id
FROM work_history w
WHERE abs((end_date - start_date)) =
                                    (
                                      SELECT MAX(end_date - start_date) 
                                      FROM work_history 
                                      WHERE w.ship_id = ship_id
                                     ) ;

-- -------------------------------------------------------------------------------------------------    
-- 4. Return the ships name and it's home port's name for each ship 
--    with the maximum capacity for their home port
select * from ships;
select * from ports;

select ship_name, port_name, port_id, s.capacity
from ships s join ports p on s.home_port_id = p.port_id
where s.capacity = 
                (
                  select max(capacity)
                  from ships
                  where s.home_port_id = home_port_id
                );
-- answer
-- Codd Crystal	Baltimore	1	2052
-- Codd Voyager	Charleston	2	3114
-- Codd Victorious	Tampa	3	2974

--1	Codd Crystal	  2052	855	    1
--2	Codd Elegance	  2974	952	    3
--3	Codd Champion	  2974	952	  null
--4	Codd Victorious	2974	952	    3
--5	Codd Grandeur	  2446	916	    2
--6	Codd Prince	    395	  470	    2
--7	Codd Harmony	  940	  790	    2
--8	Codd Voyager	  3114	1020	  2
--9	Codd_Victory    null  null  null			


-- -------------------------------------------------------------------------------------------------    
-- 5.	Return the title and cost of each book that is the least expensive in each category


-- -------------------------------------------------------------------------------------------------    
-- 6.	Write an English statement in 1-3 sentences that describes what the following query does. 
SELECT e.ship_id, c.cruise_id, c.captain_id, e.first_name, e.last_name
FROM cruises c JOIN employees e
                ON c.captain_id = e.employee_id
WHERE e.ship_id =
                  (SELECT ship_id
                  FROM employees
                  WHERE first_name = 'Joe'
                  AND last_name    = 'Smith'
                  )
AND cruise_id = 1;

-- -------------------------------------------------------------------------------------------------
-- 7.	Write an English statement in 1-3 sentences that describes what the following query does.
select *
from customers c
where exists (
    select *
    from orders o
    where o.customer# = c.customer#
  );

-- -------------------------------------------------------------------------------------------------  
-- 8.	Write an English statement in 1-3 sentences that describes what the following query does.
select * from ship_cabins s1
where s1.balcony_sq_ft =
                          (
                           select min(balcony_sq_ft)
                           from ship_cabins s2
                           where s1.room_style = s2.room_style
                           and s1.room_type = s2.room_type
                          );

-- -------------------------------------------------------------------------------------------------
-- 9.	Write an English statement in 1-3 sentences that describes what the following query does.
select port_id, port_name
from ports p1
where exists (
                select * 
                from ships s1
                where p1.port_id = s1.home_port_id
              );
 
-- -------------------------------------------------------------------------------------------------
-- 10.	Write an English statement in 1-3 sentences that describes what the following query does.
select s1.ship_name, s1.capacity 
       , (select port_name from ports where port_id = s1.home_port_id) home_port
from ships s1
where s1.capacity = 
                    (
                      select min(capacity)
                      from ships s2
                      where s2.home_port_id = s1.home_port_id
                    );
select * from ships;
select * from ports;
                      







select p.country, p.capacity
from ports p
 where p.port_id = ANY (
                    select s.home_port_id
                    from ships s
                    where s.length > 900
                    );










