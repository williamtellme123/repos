-- =============================================================================
-- Chapter 2
-- =============================================================================
-- Page 50 (2/1)
    CREATE TABLE work_schedule
    (work_schedule_id NUMBER,
      start_date DATE,
      end_date DATE,
      constraint work_schedule_pk primary key(work_schedule_id));
      drop table work_schedule;
      desc work_schedule;
    
-- Page 59 (2/5)
/* ============================================================================= 
    1. Copy from page 59
    2. Rename to cruises2
    3. Create table
    4. Check with desc
    5. Check in SQL Developer for contraints
    6. Drop table 
    7. Add named constraint
    8. Create table
    9. Look in IDE see named constraint
    10 Drop table cruises2
  -- ---------------------------------------------------------------------------  
*/
    CREATE TABLE cruises2
    ( cruise_id       NUMBER ,
      cruise_type_id  NUMBER,
      cruise_name     VARCHAR2(20),
      captain_id      NUMBER,
      start_date      DATE,
      end_date        DATE,
      status          VARCHAR2(5) ,
      constraint cruises2_cruiseID_pk (cruise_id));
    
    
    select * from user_constraints where table_name = 'CRUISES2';
    
    desc cruises2;
    drop table cruises2;
    

-- Page 62 (2/6)
/* ============================================================================= 
    1. Copy cruises 2 from above
   
    2. Rename to cruises3
   
    3. Delete all except
        cruise_id number(4,2)
        cruise_name varchar2(5)
   
    4. Create table
       
    5. insert into cruises3 values (3333, 'alpha');
       select * from cruises3;
       
    6. insert into cruises3 values (33, 'alpha');
       select * from cruises3;
       
    7. Insert into cruises3 values (33.56, 'alpha');
       select * from cruises3;
       
    8. insert into cruises3 values (33.566, 'alpha');
       select * from cruises3;
       
    9. insert into cruises3 values (33.566, 'alpha1');
       select * from cruises3;
  -- ---------------------------------------------------------------------------    
*/

    CREATE TABLE cruises3
    ( cruise_id       NUMBER (4,2),
      cruise_name     VARCHAR2(5)
    );
    drop table cruises3;
    
    insert into cruises3 values (3333, 'alpha');
    select * from cruises3;
    
    insert into cruises3 values (33, 'alpha');
    select * from cruises3;
    
    Insert into cruises3 values (33.56, 'alpha');
    select * from cruises3;
    
    insert into cruises3 values (33.566, 'alpha');
    select * from cruises3;
    
    insert into cruises3 values (33.566, 'alpha1');
    select * from cruises3;
    
    select * from cruises3;
    drop table cruises3;

-- Page 63 (2/7)
/* ============================================================================= 
  SELECT sys_context('USERENV', 'NLS_DATE_FORMAT') FROM DUAL;
-- ----------------------------------------------------------------------------
*/

-- Page 64 (2/7)
/* ============================================================================= 
    1. Copy cruises 3 from above
   
    2. Rename to cruises4
   
    3. Delete all except
       CREATE TABLE cruises4
          ( date1       date,
            date2       timestamp,
            date3       timestamp with time zone,
            date4       timestamp with local time zone
          );
          
    4. insert into cruises4 values (sysdate,sysdate,sysdate,sysdate);

    5. select * from cruises4;
    
    6. Drop table cruises4;
-- ----------------------------------------------------------------------------
*/
    CREATE TABLE cruises4
    ( date1       date,
      date2       timestamp,
      date3       timestamp with time zone,
      date4       timestamp with local time zone
    );
    drop table cruises4;
    insert into cruises4 values (sysdate,sysdate,sysdate,sysdate);
    select * from cruises4;

-- Page 67 (2/9)
/* ============================================================================= 
    1. Copy cruises 3 from above

        CREATE TABLE cruises3
        ( cruise_id       NUMBER (4,2),
          cruise_name     VARCHAR2(5)
        );
    
    2. drop table cruises3
    
    3. create anonymous primary key in line
    
      CREATE TABLE cruises3
      ( cruise_id       integer primary key,
        cruise_name     VARCHAR2(5)
       );
    
    4. drop table cruises3;

    5. create named primary key in line

      CREATE TABLE cruises3
      ( cruise_id       integer constraint cruises3_pk primary key,
        cruise_name     VARCHAR2(5)
       );
    
    6. drop table cruises3;

    7. create primary key out of line 
     CREATE TABLE cruises3
      ( cruise_id       integer ,
        cruise_name     VARCHAR2(5),
        constraint cruises3_pk primary key (cruise_id)
      );

    8. drop table cruises3;
*/

    CREATE TABLE cruises3
    ( cruise_id       integer constraint cruises3_pk primary key,
      cruise_name     VARCHAR2(5)
     );
    drop table cruises3;

    CREATE TABLE cruises3
    ( cruise_id       integer ,
      cruise_name     VARCHAR2(5),
      constraint cruises3_pk primary key (cruise_id)
    );

-- Page 69 (2/9)
/* ============================================================================= 
    1. Copy cruises 3 from above

        CREATE TABLE cruises3
        ( cruise_id       NUMBER (4,2),
          cruise_name     VARCHAR2(5)
        );

     2. drop table cruises3;
     
     3. create table

     4. alter table cruises3 modify cruise_id primary key;
        check constraint in sql developer

     5. drop table cruises3;
     
     6. create table

     7. alter table cruises3 modify cruise_id constraint cruises_cruiseid_pk primary key;
        check constraint in sql developer

     8. drop table cruises3;
     
     9. create table

     10. alter table cruises3 add constraint cruises3_cruiseid_pk primary key (cruise_id);
        check constraint in sql developer
        
     11. drop table cruises3;
*/

    alter table cruises3 modify cruise_id constraint cruises_cruiseid_pk primary key;
    CREATE TABLE cruises3
            ( cruise_id       NUMBER (4,2),
              cruise_name     VARCHAR2(5)
            );

     drop table cruises3;
     
     
     
     
     

-- ============================================================================= 
-- HANDS ON ASSIGNMENTS CHAPTER 2
/* ----------------------------------------------------------------------------- 
    1. create table supplier
      a.) supplier_id is the primary key can hold 10 digits
      b.) supplier_name can hold 50 letters and cannot be null 
      c.) contact_name can hold 50 letters and can be null 
    NOTE: all constraints must be named by programmer
*/    
   
      CREATE TABLE supplier 
      ( supplier_id       numeric(10), 
        supplier_name     varchar2(50) constraint supplier_name_nn not null, 
        contact_name      varchar2(50),  
        CONSTRAINT supplier_supplier_id_pk PRIMARY KEY (supplier_id) 
      ); 
      drop table supplier;

/* ----------------------------------------------------------------------------- 
    2. create table products
      a.) product_id is the primary key can hold 10 digits
      b.) supplier_id is FK to supplier 
      c.) supplier_name can hold 50 letters and cannot be null 
    NOTE: all constraints must be named by programmer
*/
     CREATE TABLE products 
      ( product_id        numeric(10) primary key, 
        supplier_id       numeric(10) not null,
        supplier_name varchar2(50) not null, 
        CONSTRAINT products_supplier_fk 
          FOREIGN KEY (supplier_id) 
          REFERENCES supplier(supplier_id) 
      ); 
      
      CREATE TABLE products 
      ( product_id        numeric(10) primary key, 
        supplier_id       numeric(10) references supplier (supplier_id),
        supplier_name varchar2(50) not null 
      ); 
      
      CREATE TABLE products 
      ( product_id        numeric(10) primary key, 
        supplier_id       numeric(10) constraint abc_fk references supplier (supplier_id),
        supplier_name varchar2(50) not null 
      ); 
      
      drop table products;

/* -----------------------------------------------------------------------------
    3. create table supplier2
      a.) same fields as supplier
      b.) supplier_id/supplier_name is composite primary key 
    NOTE: all constraints must be named by programmer
*/
      CREATE TABLE supplier 
      ( supplier_id       
        supplier_name     
        contact_name      
      ); 
      drop table supplier;


      CREATE TABLE supplier2 
      ( supplier_id     numeric(10),  
        supplier_name   varchar2(50), 
        contact_name    varchar2(50),  
        CONSTRAINT supplier_pk PRIMARY KEY (supplier_id, supplier_name) 
      ); 
      drop table supplier;

/* -----------------------------------------------------------------------------
    4. create table products2
      a.) same fields as products
      b.) foreign key matches composite primary key in supplier2
    NOTE: all constraints must be named by programmer
*/

  a.) product_id is the primary key can hold 10 digits
      b.) supplier_id is FK to supplier 
      c.) supplier_name can hold 50 letters and cannot be null 
    NOTE: all constraints must be named by programmer


      CREATE TABLE products2 
      ( product_id numeric(10) constraint pid_pk primary key, 
       supplier_id numeric(10) not null, 
       supplier_name varchar2(50) not null, 
       CONSTRAINT prod_supp_suppid_supprname_fk 
         FOREIGN KEY (supplier_id, supplier_name) 
         REFERENCES supplier2(supplier_id, supplier_name) 
      ); 
      drop table products2;

/* -----------------------------------------------------------------------------
    5. create table products3
      a.) same fields as products
      b.) no foreign key in create table
      c.) use alter statement add: products_supplier_supplierid_fk
      NOTE: use first supplier table with single field PK
*/
      -- "add" foreign key after tables are created
      ALTER TABLE products3
      add CONSTRAINT prod_supp_supp_fk
        FOREIGN KEY (supplier_id)
        REFERENCES supplier(supplier_id);

/* -----------------------------------------------------------------------------
    6. create table products4
      a.) same fields as products
      b.) no foreign key in create table
      c.) use alter statement add composite FK: prod_supp_suppid_suppname_fk
      NOTE: use first supplier2 table with composite PK
*/
 CREATE TABLE products4 
      ( product_id numeric(10), 
       supplier_id numeric(10), 
       supplier_name varchar2(50)); 

      ALTER TABLE products4
      add CONSTRAINT prod_supp_suppId_suppname_fk 
        FOREIGN KEY (supplier_id, supplier_name)
        REFERENCES supplier2(supplier_id, supplier_name);

/* -----------------------------------------------------------------------------
    7. You work for a company that has people who work out
    of multiple locations. Create three small tables:
    People: a table about people
    Locations: a table about locations
    Assignments: a table about people at locations
*/
/*
    8. create table people
    -- ---------------------------------------------------
    1.) pid is PK
    2.) startdate is the startdate with default sysdate
    3.) fname can hold 15 letters and cannot be null 
    4.) lname can hold 25 letters and cannot be null
    5.) email can hold 25 letters must be unique
    NOTE: all constraints must be named by programmer
      
    
    */
       CREATE TABLE people
      ( pid         integer constraint people_pid_pk primary key,
        start_date  date default sysdate,
        fname       varchar2(15) constraint people_fname_nn not null,
        lname       varchar2(15) constraint people_lname_nn not null,
        email       varchar2(45) constraint people_email_uk  unique
      );
      drop table people;
      purge recyclebin;
       
      
    /*
    9. create table assignments
    -- ---------------------------------------------------
    1.) pid (see #3 below)
    2.) lid must have values (see below)
    3.) create pk as (pid, lid)
    4.) create fk to people
    5.) create fk to locations
    */
  
      create table assignments
      ( pid         integer, 
        lid         integer check (lid in (1,2,3,4,5)),
        constraint assignments_pk primary key (pid, lid),
        constraint assignments_people_pid_fk foreign key (pid) references people (pid),
        constraint assignments_locations_lid_fk foreign key (lid) references locations (lid)
        );
      drop table assignments;
      
    /*
    10. create table locations
    -- ---------------------------------------------------
    1.) lid is the primary key 
    2.) store name can hold 30 letters and cannot be null 
    4.) city can hold 30 letters and cannot be null
    5.) state can hold 2 letters and cannot be null
    */
      
      -- create a table for locations
      CREATE TABLE locations
      ( lid         integer constraint locations_lid_pk primary key,
        name        varchar2(30) constraint locations_name_nn not null,
        city        varchar2(30) constraint locations_city_nn not null,
        state       varchar2(2)  constraint locations_state_nn not null
      );
      drop table locations;

    /*
    11. drop these three tables people, assignments, locations
    */
-- =============================================================================
-- Chapter 3
-- =============================================================================
/*
-- Page 99 (3/1)
    1. Copy from page 99
    2. Format for readability
    3. Insert (is there a problem?)
    SOLUTION
    4. Select from cruises
    5. Select from employees
    6. Check constraints
    7. Change insert statement to work
*/

      INSERT INTO CRUISES
       (  CRUISE_ID
        , CRUISE_TYPE_ID
        , CRUISE_NAME
        , CAPTAIN_ID
        , START_DATE
        , END_DATE
        , STATUS)
       VALUES
        (1
        , 1
        , 'Day At Sea'
        , 101
        , '02-JAN-10'
        , '09-JAN-10'
        , 'Sched');
      select * from cruises;
      select * from employees;

/*
-- Page 101 (3/2)
    1. Copy insert from above 
    2. Remove column names
    3. Insert (same problem)
    4. Select from cruises/check constraints
    5. Add value (select from ships)
    6. Insert
    7. Change captain_id (select from employees)
    6. Insert
*/

      INSERT INTO CRUISES
       VALUES
        (2
        , 1
        , 'Day At Sea'
        , 8
        , 101
        , '02-JAN-10'
        , '09-JAN-10'
        , 'Sched');
      select * from cruises;
      select * from employees;
      desc cruises;

      desc ships;
      select * from ships;

/*
-- Page 105 (3/4)
    1. Copy insert from above 
    2. Select Max from Cruises
    3. Create sequence start Max+1
    4. Insert statement from page 105 using nextval
    6. Insert
*/

      create sequence cruise_cruise_id_seq start with 3;
      drop sequence cruise_cruise_id_seq ;;
      select max(cruise_id) from cruises;
      
      INSERT INTO CRUISES
       VALUES
        (cruise_cruise_id_seq.nextval
        , 1
        , 'Day At Sea'
        , 8
        , 8
        , '02-JAN-10'
        , '09-JAN-10'
        , 'Sched');
      select * from cruises;
      select * from employees;5
/*
-- Page 106 (3/4)
    1. Copy code page 106
    2. Select Max from Cruises
    3. Create sequence start Max+1
    4. Insert statement from page 105
    5. Insert
*/
      UPDATE CRUISES
      SET CRUISE_NAME = 'Bahamas',
      START_DATE = '01-DEC-11'
      WHERE CRUISE_ID = 1;
      
      UPDATE CRUISES
      SET CRUISE_NAME = 'Bahamas',
      START_DATE = '02/DEC/02'
      WHERE CRUISE_ID = 1;

/*
-- Page 108 (3/5)
    1. Copy update code from above 
    2. Modify to below
    3. Update
    4. Select to test
*/

      SELECT * FROM CRUISES;
      UPDATE cruises
      SET end_date = start_date + 5
      WHERE cruise_id = 1;

/*
-- Page 108 (3/5)
    1. Copy code page 108
    2. Rename Projects2 
    3. Modify insert statements Projects2
    4. Create table
    5. Insert into table
    6. update projects2
       set cost = cost * 1.20;
    7. Update
*/
      CREATE TABLE PROJECTS2
      (   PROJECT_ID NUMBER PRIMARY KEY
        , PROJECT_NAME VARCHAR2(40)
        , COST NUMBER
        , CONSTRAINT CK_COST CHECK (COST < 1000000));
        
BEGIN        
      INSERT INTO PROJECTS2 (PROJECT_ID, PROJECT_NAME, COST)
          VALUES (1,'Hull Cleaning', 340000);
      INSERT INTO PROJECTS2 (PROJECT_ID, PROJECT_NAME, COST)
          VALUES (2,'Deck Resurfacing', 964000);
      INSERT INTO PROJECTS2 (PROJECT_ID, PROJECT_NAME, COST)
          VALUES (3,'Lifeboat Inspection', 12000);
END;
/

      update projects2
      set cost = cost * 1.03;
    
/*
-- Page 110 (3/5)    
    1. Copy update from above 
    2. Modify with where clause
    3. Update
    4. Select
*/    
      update projects2
      set cost = cost * 1.2 
      where cost * 1.2 < 1000000;

/*
-- Page 117 (3/7)    
    1. Commit
    2. Select * from projects2;
    3. Delete from projects2
    4. Select
    5. Rollback
    6. Select
    7. Delete projects2
    8. Select
    9. Rollback
    10. Select
*/    
      commit;
      select * from projects2;
      delete projects2;
      rollback;
      set cost = cost * 1.2 
      where cost * 1.2 < 1000000;


/*
-- Page 120 (3/7)    
    1. Copy 199-120
    2. Commit
    3. Select
    4. 1st update
    5. Ship_id = 3
    6. Home Port 12
    7. Home Port 11
    8. Home Port 10
    9. Rollback to Mark_02
    10. Select
    11. Update back to null to reset DB
    12. Select
    13. Commit
*/    

      COMMIT;
      select * from ships where ship_id = 3;
      UPDATE SHIPS SET HOME_PORT_ID = 12 WHERE SHIP_ID = 3;

      SAVEPOINT MARK_01;
      UPDATE SHIPS SET HOME_PORT_ID = 11 WHERE SHIP_ID = 3;
      
      SAVEPOINT MARK_02;
      UPDATE SHIPS SET HOME_PORT_ID = 10 WHERE SHIP_ID = 3;
      
      ROLLBACK TO MARK_02;
      COMMIT;
      
      UPDATE SHIPS SET HOME_PORT_ID = null WHERE SHIP_ID = 3;
      
      select * from ships where ship_id = 3;
      COMMIT;

-- ============================================================================= 
-- HANDS ON ASSIGNMENTS CHAPTER 3
    /* ----------------------------------------------------------------------------- 
    1. copy DDL stements above for tables: people, assignments, locations
    */
    /*
    2. create table people
    -- ---------------------------------------------------
    1.) pid is PK
    2.) startdate is the startdate with default sysdate
    3.) fname can hold 15 letters and cannot be null 
    4.) lname can hold 25 letters and cannot be null
    5.) email can hold 25 letters must be unique
    NOTE: all constraints must be named by programmer
    */
    
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
      CREATE TABLE people
      ( pid         integer constraint people_pid_pk primary key,
        start_date  date default sysdate,
        fname       varchar2(15) constraint people_fname_nn not null,
        lname       varchar2(15) constraint people_lname_nn not null,
        email       varchar2(45) constraint people_email_uk  unique
      );
      drop table people;
      purge recyclebin;
    /*
    3. create table assignments
    -- ---------------------------------------------------
    1.) pid 
    2.) lid must have values 1,2,3,4, or 5 
    3.) create pk as (pid, lid)
    4.) create fk to people
    5.) create fk to locations
    */
      create table assignments
      ( pid         integer, 
        lid         integer check (lid in (1,2,3,4,5)),
        constraint assignments_pk primary key (pid, lid),
        constraint assignments_people_pid_fk foreign key (pid) references people (pid),
        constraint assignments_locations_lid_fk foreign key (lid) references locations (lid)
        );
      drop table assignments;
    /*
    4. create table locations
    -- ---------------------------------------------------
    1.) lid is the primary key 
    2.) name can hold 30 letters and cannot be null 
    4.) city can hold 30 letters and cannot be null
    5.) state can hold 2 letters and cannot be null
    */
      -- create a table for locations
      CREATE TABLE locations
      ( lid         integer constraint locations_lid_pk primary key,
        name        varchar2(30) constraint locations_name_nn not null,
        city        varchar2(30) constraint locations_city_nn not null,
        state       varchar2(2)  constraint locations_state_nn not null
      );
      drop table locations;
    /* 
    5. Create a sequence for people and locations
    -- ---------------------------------------------------
    */
    create sequence people_pid_seq start with 1000;
    drop sequence people_pid_seq; 
    create sequence locations_lid_seq start with 1;
    drop sequence locations_lid_seq;
    /* 
    6. Insert three rows into people (using sequence)
    7. Insert six rows into assignments (each person works two locations) 
    8. Insert three rows into locations (using sequence)
    -- ---------------------------------------------------
    */
    insert into people (pid, start_date,fname, lname,email)
        values (people_pid_seq.nextval, sysdate, 'Marshal','Rango','rango@hotmail.com');
    insert into people (pid, start_date,fname, lname,email)
        values (people_pid_seq.nextval, sysdate, 'Penelope','Pitstop','ppitstop@gamail.com');
    insert into people (pid, start_date,fname, lname,email)
        values (people_pid_seq.nextval, sysdate, 'Ranger','Andy','randy@juno.com');
    select * from people;
    
    insert into locations (lid,name,city,state)
      values (locations_lid_seq.nextval, 'Bar 4 Ranch','Lubbock','TX');
    insert into locations (lid,name,city,state)
      values (locations_lid_seq.nextval, 'BarBQue','Austin','TX');
    insert into locations (lid,name,city,state)
      values (locations_lid_seq.nextval, 'SpaceOut','Houston','TX');
    select * from locations;
        
    insert into assignments (pid,lid) values (1000,1);
    insert into assignments (pid,lid) values (1000,3);  
    insert into assignments (pid,lid) values (1001,2);
    insert into assignments (pid,lid) values (1001,3);
    insert into assignments (pid,lid) values (1002,1);
    insert into assignments (pid,lid) values (1002,3);
    select * from assignments;  
    /* 
    9. Delete from people where pid = 1000;
    10. Delete from locations where lid = 1
    -- ---------------------------------------------------
    */
    delete from people where pid = 1000;
    delete from assignments where pid = 1000;
    
    delete from locations where lid = 2;
    delete from assignments where lid = 2;
    /* 
    11. Select to check
    12. Drop tables
    13. Drop sequences
    */


-- =============================================================================
-- Chapter 4 
-- =============================================================================
-- Page 139 (4/1)
/* ============================================================================= 
    1. Copy from page 139
    2. Run the command in SQL Developer
    3. Copy and paste into SLQ Plus
*/    
      SELECT SHIP_ID, SHIP_NAME, CAPACITY
      FROM SHIPS
      ORDER BY SHIP_NAME;  

-- Page 141 (4/2)
/* ============================================================================= 
    1. Copy from page 141
    2. Run the command in SQL Developer
*/   
      SELECT 1, '--------'
      FROM SHIPS;

-- ============================================================================= 
-- HANDS ON ASSIGNMENTS CHAPTER 4
    /* ----------------------------------------------------------------------------- 
    1. Open connection into Books
    2. Count rows in customers
    3. Count rows in orders
    4. Join customers and orders three ways
        a.) "using (customer#)"
        b.) "on o.customer# = o.customer#"
        c.) "where o.customer# = o.customer#"
    5. How many customers are there 
    6. How many orders are there
    7. How many joined rows
    7. How many customers with orders
    8. How many customers without orders 
    */
        
        select lastname, firstname, order#
        from customers join orders using (customer#)
        order by 3, 2, 1;

        select lastname, firstname, order#
        from customers left join orders using (customer#)
        order by 3, 2, 1;

        select lastname, firstname, order#
        from customers c join orders o 
        on c.customer# = o.customer#
        order by 3, 2, 1;
        
        select lastname, firstname, order#
        from customers c left join orders o 
        on c.customer# = o.customer#
        order by 3, 2, 1;
  
        select lastname, firstname, order#
        from  customers c
            , orders o 
        where c.customer# = o.customer#(+)
        order by 3, 2, 1;
        
        -- total number of joined rows        
        select lastname, firstname, order#
        from customers c left outer join orders o on  
        c.customer# = o.customer#
        order by 3, 2, 1;
        
        select lastname, firstname, order#
        from customers c
            , orders o
        where c.customer# = o.customer#;
        
        select lastname, firstname, order#
        from customers c
            , orders o
        where c.customer# = o.customer#;
        
        -- customers without orders
        select c.customer#, lastname, firstname
        from customers c
        where not exists (select customer# 
                          from orders o
                          where c.customer# = o.customer#);
        
        -- 10
        select c.customer#, lastname, firstname
        from customers c
        where c.customer# not in (select customer# 
                                  from orders o
                                  where c.customer# = o.customer#);
        
        -- 14 
        select c.customer#, lastname, firstname
        from customers c
        where c.customer# in (select distinct customer# 
                                  from orders o
                                  where c.customer# = o.customer#);
        
        -- 24
        select distinct  c.customer#, lastname, firstname
        from customers c;

        select count(distinct  c.customer#)
        from customers c;


        -- 22
        select count(*) from orders;





-- =============================================================================
-- Chapter 5
-- =============================================================================

