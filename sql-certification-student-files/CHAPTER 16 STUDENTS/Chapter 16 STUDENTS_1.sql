-- =============================================================================
/*
    CHAPTER 16
    Interpret the Concept of a Hierarchical Query
    Use it to answer different questions
    
    1. SELF_JOIN REVISITED
        A business relationship between two columns in one table can 
        be used to self-join
        
        PREVIOUS EXAMPLE
            customer#       Child ID      primary key
            referred        Parent ID     non primary key
      
    2. HIERARCHICAL relationships
        Family Tree
        Folder Structure
        Employees
        Army Chain of Command
        
    3. HIERARCHICAL QUERY is a specific type of self-join
        
        This business relationship is called hierarchal 
        It would populate a standard organiazational chart
            employee_id     Child ID       primary key
            managers_id     Parent ID     non primary key

    4. DIRECTIONS    
          Hierarchical queries have direction
            Top Down
            Bottom UP
          Dictated by where you place the special key word "prior"
    
    5. STARTING LOCATION
          Hierarchical needs a starting point given by a true/false question
          More than one tree can exist in the same table
    
    6. ADDITIONAL TECHNIQUES 
        Exclude a single node from a tree
        Exclude a whole branch from a tree
        
        SYS_CONNECT_BY_PATH
        CONNECT_BY_ROOT
        ORDER BY SIBLINGS VS. ORDER BY
  
Need to know how to 
    Start with one node and go top to bottom
    Start with one node and go bottom up
    Exclude a single node
    Exclude a whole branch
    
*/
-- -----------------------------------------------------------------------------
-- 1. SELF JOIN REVISITED
--    Write the self join that prints out the following 
--
--    Referred_By      Action         Customer_Referred 
--    LEILA	SMITH	    referred => 	   JENNIFER	SMITH
select *
from customers a, customers b;

-- old school technique
select a.firstname, a.lastname, 'referred => ' as Action, b.firstname, b.lastname
from customers a, customers b
where a.customer# = b.referred;

select a.firstname, a.lastname, 'referred => ' as Action, b.firstname, b.lastname
from customers a join customers b 
  on a.customer# = b.referred;
  
select a.firstname || ' ' || a.lastname as "Referred  By", 'referred => ' as Action,
        b.firstname|| ' ' ||b.lastname as Referred
from customers a join customers b 
  on a.customer# = b.referred;  

-- CUSTOMER         ACTION                REFERRED_BY
-- Jennifer Smith   Was referred by =>    Leila Smith
  
select  initcap(b.firstname || ' ' || b.lastname) as customer
      , 'was referred by => ' as Action
      , initcap(a.firstname|| ' ' ||a.lastname) as referred_by
from customers a join customers b 
  on a.customer# = b.referred;  






-- -----------------------------------------------------------------------------
-- 2. HIERARCHICAL RELATIONSHIPS
--  ----------------------------------------------------------------------------
--  Sometimes we think of the ROOT at the bottom (Say a Family Tree)
--
--  LEVEL 3 : GRANDPARENTS    Ted Sanders   Elizabeth Welks     Robert Bullen   Stephanie Roberts
--                                \             /                   \              /
--                                 \           /                     \            /
--  LEVEL 2 : PARENTS              Francis Sanders	                Isabella Bullen
--                                               \                  /
--                                                \                /                         
--  LEVEL 1 : SIBLINGS (Root)                        Sarah Sanders
--                                                   Sonya Sanders
--                                                   Henry Sanders
--
--
--  -----------------------------------------------------------------
--  Sometimes we think of the ROOT at the top (a folder tree on your laptop)
--  
--  LEVEL 1 :             MyDocumentsFolder
--                          /         \
--  LEVEL 2 :           WORK         SCHOOL
--                      /   \        /    \
--  LEVEL 3 :       PRJ1    PRJ2   SQL    PMGT
--
-- -----------------------------------------------------------------------------
-- 
-- IN SQL the ROOT IS ALWAYS THE TOP
-- 
--  LEVEL 1 :                  CEO
--                            /   \
--  LEVEL 2 :              VP1    VP2
--                        /  \       \
--  LEVEL 3 :          DIR1  DIR2     DIR3
--                     / \            / \ 
--  LEVEL 4 :     MGR_A  MGR_B    MGR_C  MGR_D
-- -----------------------------------------------------------------------------
-- Word document : Page

-- -----------------------------------------------------------------------------
-- 3. HIERARCHICAL QUERIES
--  ----------------------------------------------------------------------------
--    A. HIERARCHICAL QUERY is a specific type of self-join
--       First examine the data and answer 3 questions
       select * from employee_chart; 
--     a. Which two fields provide the relationship
--     b. Which of thoise two is the child column
--     c. Which of thoise two is the parent column

-- -----------------------------------------------------------------------------
--    B. First Example
--       Key Words
--          "Level"
--          "Start With" (use any condition you would use in the where clause)
--          "Connect by" Field1 =  "Prior" Field2
        select employee_id, title, reports_to, level
        from employee_chart
        start with employee_id = 1
        connect by reports_to = prior employee_id;

        select employee_id, title, reports_to, level
        from employee_chart
        start with employee_id = 9
        connect by prior reports_to =  employee_id;
 
-- -----------------------------------------------------------------------------
--    C. SECOND Example using some functions from Chapter 6
          select employee_id
                , lpad(' ',level*2) || title as title
                , reports_to
                , level
          from employee_chart
          start with employee_id = 1
          connect by prior employee_id = reports_to;

-- -----------------------------------------------------------------------------
-- 4. DIRECTIONS
--  ----------------------------------------------------------------------------
--       TOP DOWN 
--       connect by prior child_id = parent_id 
            select * from employee_chart;
            select    employee_id
                    , lpad(' ',level*2) || title as title
                    , reports_to, level
            from employee_chart
            start with employee_id = 1
            connect by reports_to = prior employee_id;

--  ----------------------------------------------------------------------------
--       BOTTOM UP
            select level, employee_id, lpad(' ',level*2) || title
            from employee_chart
            start with employee_id = 9
            connect by employee_id = prior reports_to;

-- -----------------------------------------------------------------------------
-- 5. STARTING LOCATION
--  ----------------------------------------------------------------------------
--  Hierarchical needs a starting point given by a true/false question
--  More than one tree can exist in the same table    
      select level, lpad(' ',level*2) || title
      from employee_chart
      start with title like '%VP'
      connect by employee_id = prior reports_to;
--  Add the level field above and run it again
select * from billy.army;

-- Return Major Einhorns command structure
-- Major Einhorn has id 34
-- add a lpad function that lpads spaces
select lpad(' ',level*2) || name as grunts
from billy.army
start with id = 34
connect by co = prior id;

-- Captain Wyon wants to transfer to 
-- Lubbock and transfers require everyones signature
-- up to the general grunt
-- list all of the signatures she needs 
-- (excluding her own)
select name
from billy.army
where name not like '%Wyon%'
start with name like '%Wyon%'
connect by id = prior co;

-- who is left on base after einhorn 
-- takes his people off base

select lpad(' ' ,level*2) || name
from billy.army
start with name like 'General%'
connect by prior id = co and id <> 34;


--  ----------------------------------------------------------------------------
--  You can return more than one tree from a table if they exists
      select * from distributors;
      -- How many trees exist if the root is REGIONAL?
      select  level
            , lpad(' ',level*2) || loc_type
            , location as location
      from distributors
      start with location in ('Salt Lake','Wichita')
      connect by prior id =  upline;

select level
     , lpad(' ', level*2) || name
from billy.army
-- start with name in ('Sargent Vancer', 'Captain Viano')
start with id in (27,7)
connect by prior id = co; 

insert into distributors values(9,'London',	'HQ', null);	
insert into distributors values(10,	'Wembly',	'Regional',	9);
insert into distributors values(11,	'Grays',	'Local',	10);
commit;      
      select * from distributors;
--  Add the level field above and run it again
-- -----------------------------------------------------------------------------
--  6. ADDITIONAL TECHNIQUES
--  ----------------------------------------------------------------------------
--  Exclude a single node from a tree
        select level, lpad(' ' ,level*2) || title as title
        from cruises.employee_chart
        where title <> 'VP'
        start with reports_to is null
        connect by prior employee_id = reports_to
        order by 2;
        
        select lpad(' ',level*2) || title
        from cruises.employee_chart
        start with reports_to is null
        connect by prior employee_id = reports_to
        order siblings by title;
       
--  ----------------------------------------------------------------------------
--  Exclude a whole branch from a tree
        select lpad(' ',level*2) || title as title
        from employee_chart
        start with title = 'CEO'
        connect by prior employee_id = reports_to
          and title <> 'SVP';
--  ----------------------------------------------------------------------------
--  SYS_CONNECT_BY_PATH
--  Shows the path 
      select  lpad(' ' ,level*2) || title as title
            , sys_connect_by_path(title,'\') as hierarchy
      from cruises.employee_chart
      start with reports_to is null
      connect by prior employee_id = reports_to;

--  CONNECT_BY_ROOT
--  Shows the root
      select    lpad(' ' ,level*2) || title as title
              , connect_by_root title as headperson
      from cruises.employee_chart
      start with employee_id = 1
      connect by prior employee_id =  reports_to;

--  BOTH
      select lpad(' ' ,level*2) || title as title
             , sys_connect_by_path(title,'/') as title2
             , connect_by_root title as headhoncho
      from cruises.employee_chart
      start with employee_id = 1
      connect by prior employee_id = reports_to;

--   ORDER BY VS. ORDER SIBLINGS by  
      select lpad(' ',level*2) || title  as  title_formatted
      from cruises.employee_chart
      start with title = 'CEO'
      connect by reports_to = prior employee_id
      order siblings by title;

select name
from billy.army
where level = 1
start with name like 'Major%'
connect by prior id = co;

select name
from billy.army
where name like 'Major%';

-- How many rows will this return
-- Is it Top Down / Bottom Up
select employee_id, lpad(' ',level*2) || title as title
from employee_chart
start with title = 'CEO'
connect by reports_to = prior employee_id;

--1. Return all of the SVP's Department
select level, lpad(' ' ,level*2)||title as title
from employee_chart
start with employee_id = 3
connect by prior employee_id = reports_to;









-- 2. Return all of Director 4's reporting chain except her manager
select level, lpad(' ' ,level*2) || title as title
from employee_chart
where employee_id <> 3
start with employee_id = 8
connect by prior reports_to = employee_id;





-- How many rows will this return
-- Top Down / Bottom Up
-- What will the sort do?
    select level, loc_type,location
    from distributors
    start with loc_type = 'HQ'
    connect by prior id = upline 
    order by location;

-- How many rows will this return
-- Top Down / Bottom Up
-- What will the sort do?
      select level, loc_type,location
      from distributors
      start with loc_type = 'HQ'
      connect by id = prior upline 
      order siblings by location;

-- How many roots (trees will this return)
      select level, lpad(' ',level*2) || location, loc_type
      from distributors
      start with loc_type = 'REGIONAL'
      connect by prior id = upline 
      order siblings by location;


-- Return all sargents and their reports
select * from billy.army;
select lpad(' ' ,level*2) || name
from billy.army
start with name like 'Sargent%'
connect by prior id = co;


-- Major Marko's command
-- without Sargent Vances soldiers
select lpad(' ',level*2) || name
from billy.army
start with name = 'Major Marko'
connect by prior id = co 
   and name <> 'Sargent Vancer';
 




-- return private Lietz chain of command 
-- ending at Captain Viano 

select lpad(' ',level*2) || name
from billy.army
start with name like '%Lietz'
connect by prior co = id 
        and not name like 'Captain Viano';


select level, lpad(' ',level*2) || name
from billy.army
start with name like '%Lietz'
connect by prior co = id 
        and level <= 
                    (select level
                      from billy.army
                      where name like '%Viano'
                      start with name like '%Lietz'
                      connect by prior co = id);
                      
                      
                      
select level, lpad(' ',level*2) || name
from billy.army
start with id = 21
connect by prior id = prior co;                      
