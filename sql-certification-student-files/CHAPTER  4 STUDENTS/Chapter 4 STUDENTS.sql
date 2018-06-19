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
            select customer# ID, firstname || ' ' || lastname fullname
            from customers;
-- -----------------------------
--      e. EVERY SQL STATEMENT IN ORACLE NEEDS A TABLE
--          DUAL is an Oracle table you can use to test expressions
-- -----------------------------
            select * from dual;
-- -----------------------------
--      f. TEST MATH EXPRESSION
-- -----------------------------
            select sqrt(100) from dual;
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
-- -----------------------------------------------------------------------------
--    2.  BASICS OF WHERE CLAUSE
-- -----------------------------
--      a. TRUE / FALSE
-- -----------------------------
--            RELATIONAL OPERATORS
-- 
--            'Apples' = 'APPLES'
--            10 = 12/2
--            lastname = 'MORALES'
--            10 >= 100
--            state <> 'FL'
-- -----------------------------
--      b. EQUALS OPERATOR
-- -----------------------------           
            select category, title, retail, cost
            from books 
            where category = 'COMPUTER'; 
-- -----------------------------
--      c. Not equals
-- -----------------------------
            Select category, title, retail, cost
            from books 
            where category <> 'COMPUTER'; 
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
          and category in 'COMPUTER' 
          or category in 'FAMILY LIFE';
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
          select port_name
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
          where port_name like 'San____'
          -- In case you can’t tell, that’s four underscores after San

-- -----------------------------------------------------------------------------
--    3. NULL IN THE WHERE CLAUSE
-- -----------------------------
--       a. Finding null
-- -----------------------------
          select * 
          from books.orders
          where shipdate = null;
-- -----------------------------
--        b. Finding not null
-- -----------------------------
          select * 
          from books.orders
          where shipdate != null;
-- -----------------------------------------------------------------------------
--    4. PSUDEO COLUMNS
-- -----------------------------
--      a. ROWNUM This numbers the rows in the given rowlilst
--          starting at the top and moving down
-- -----------------------------
          select rownum, lastname 
          from customers;
-- -----------------------------
--      b. ROWNUM poses a challenge when used with order by 
--          rownum happenes before order by 
-- -----------------------------
          select rownum, lastname 
          from customers
          order by lastname;
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
        -- AAAF98AABAAAOWJAAA	MORALES
-- -----------------------------
--    e. IS ROWID IMPACTED BY ORDER BY
          select rowid, lastname 
          from customers
          where lastname = 'MORALES'
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
          select 'APPLE' firstname, lastname
          from customers;
-- -----------------------------
--      c. See any value in using this?
        select 'Customer Number:'||customer# || '  Full Name: ' || firstname || ' ' || lastname "Customer Information"
        from customers;
-- -----------------------------------------------------------------------------
--    6. BASIC ORDERING (Sorting)
-- -----------------------------
--      a. Default is ASCENDING :: Open the Cruises Connection :: asc is default
        select ship_id,  ship_name,  capacity
        from ships
        order by capacity;
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


-- -----------------------------
--      c. Third is by the alias 
            select title, retail-cost as profit
            from books
            order by profit;
-- -----------------------------
--      d. Mix and Match 
            select room_style || ' ' || room_type, window, sq_ft
            from ship_cabins
            order by room_type, window, 3 desc;
-- -----------------------------
--      e. Ordered Column not needed in select clause
            select title, retail, cost
            from books 
            order by category;
-- -----------------------------
--      f. Ordering by an expression 
          select title, retail, cost, round((retail-cost)/cost,2)*100 profit
          from books
          order by profit;
--          order by round((retail-cost)/cost,2)*100;
--          order by 4;
