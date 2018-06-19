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
create table ORDERS