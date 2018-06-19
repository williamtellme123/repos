-- =============================================================================
--  CHAPTER 2
/*  
    Students are urged to read the next chapter in the book before it is covered in 
    class and bring questions to class

  NEW DEFINITIONS (PAGE 47-48)
        TABLE   
        INDEX
        VIEW
        SEQUENCE
        SYNONYM
        CONSTRAINT
        USERS
        PRIVILEGES
        ROLES

  SQL 
        1. SQL TOOLS (KNOW LOCATION)
        2. BEGINNING SQL COMMANDS 
        3. FILE TYPES
        4. CREATE TABLES WITH NO CONSTRAINTS
        5. ALTER TABLE: ADD SINGLE TABLE CONSTRAINTS
        6. ALTER TABLE: ADD FOREIGN KEY 
        7. CREATE TABLES WITH CONSTRAINTS
        8. CREATE TABLES AS SELECT CTAS
        
        NOTES:
        There several different conexts to be aware of:
        Which connection we are logged in to
        Which SQL tab we are using to issue/edit/save commands
          We will be working from a student file every night
              Notes and some but not all commands will be provided
              We will be moving up and down in the file to run, edit, and or re-run commands

-- =============================================================================
*/
--  1. SQL TOOLS (KNOW LOCATION)
--      Notate the location of the following icons
--      a. Stop Database
--      b. Start Database
--      c. SQL Command Line (aka SQL Plus (pg 24))
--      d. SQL Developer (pg 24)

--    This is a comment (has a double dash in front)
--    comments are not read by the SQL engine
-- -----------------------------------------------------------------------------
--  2. BEGINNING SQL COMMANDS 
--      a. SQL Plus
--          i.  connect books/books
--                If error
--                SQL> connect system/admin
--                SQL> @?/sqlplus/admin/pupbld.sql
--          ii. select * from books;
--
--      b. SQL Developer (pg 24)
--          i.  Right-Click Books conenction icon
--          ii. Select * from books;
-- -----------------------------------------------------------------------------
--  3. FILE TYPES
--          i.    File > New > SQL File
--          ii.   File Location 
--          iii.  *.sql vs *.txt
-- -----------------------------------------------------------------------------
--  4. CREATE TABLES WITH NO CONSTRAINTS
-- -----------------------------------
--      BEFORE WE START WRITING CODE
--          COMMENTS
--                This is a comment
--                comments are not read by the SQL engine
/* 
                  Anoher way to writes comments is to use the asterick and backslash
                  This is often done when providing a large amount of documentation
                  for your work. Some people use this type of content to give the author,
                  date, version, and an explanation for what the code does.
       
*/
--          TABS 
--          PREFERENCES
-- -----------------------------------
--      OK LETS START WRITING CODE
--      a. First lets perform part of the class installation (from instructions)
--          Using test as the user
--          Login as system
            create user test identified by test;
            grant all privileges to test;
-- -----------------------------------
--      b. Create a SQL developer connection 
-- -----------------------------------
--      c. Login as test to create table students
            drop table students;
            create table students
            (
                s_id integer,
                student_name  varchar2(25)
             );
             insert into students values (222,'Happy');
             insert into students values (222,'Sneezy');
             insert into students values (221,'Bashful');
             insert into students values (18778,'Doc');
             -- Now insert yourself
             -- Now insert a friend of yours
             -- Now insert your Brad Pitt
-- -----------------------------------
--      d. Confirm 
              select * from students;
-- -----------------------------------              
--      e. Commit
              commit;
-- -----------------------------------              
--      e. delete all students
              delete students;
              select * from students;
              commit;
-- -----------------------------------              
--      f. create table student_age
            drop table student_age;
            create table student_age
            (
               
             );              
-- -----------------------------------             
--      g. create table ages
            drop table ages;
            create table ages
            (
               
             );
-- -----------------------------------             
--      h. create table pets
            drop table pets;
            create table pets
            (
                1_pet id integer
                2_pet type varchar2(25)
                3_pet name varchar2(25)
             );
-- -----------------------------------             
--      i. create table ownership
            drop table ownership;
            create table ownership
            (
                
             );
-- -----------------------------------             
--      j. import data
            select * from students;
            select * from student_age;
            select * from ages;
            select * from pets;
            select * from ownership;
            
            
            
-- -----------------------------------------------------------------------------
--  5. ALTER TABLE: ADD SINGLE TABLE CONSTRAINTS
-- -----------------------------------
--      Constraint Type Single Table: constraint is a rule on 1 or more columns
--              PRIMARY KEY:
--              UNIQUE:           
--              NOT NULL:
--                  What does null mean:
--              CHECK:
--
-- ***********************************
--              PRIMARY KEY
-- -----------------------------------
--      a. Alter table: Tehnique One 
            delete from students;
            delete students;
            truncate table students;
--          Why delete first? Chapter 11 (page 428-429)
            alter table students add primary key(s_id);            
-- -----------------------------------
--      b. Test Primary Key PK
            insert into students values (222,'Happy');
            insert into students values (222,'Sneezy');
            insert into students values (221,'Bashful');
            insert into students values (18778,'Doc');
-- -----------------------------------
--      c. Review constraint
            select * from user_constraints;
--          SQL Developer
-- -----------------------------------
--      d. Rename constraint
            alter table students rename constraint SYS_C007072 to STUD_PK;
-- -----------------------------------
--      e. Drop constraint            
            alter table students drop constraint STUD_PK;
-- -----------------------------------
--      f. Alter again with name
           alter table students add constraint stud_pk primary key(s_id);
-- -----------------------------------
--      g. Alter: remove all to clean up
            select * from user_constraints;
            alter table students drop constraint SYS_C007077;
            alter table students drop constraint STUD_PK;
-- -----------------------------------
--      h. Alter table: Technique Two
           alter table students modify s_id primary key;
-- -----------------------------------
--      i. Clean up to start again
           drop table students;
           create table students
            (
                s_id integer,
                student_name  varchar2(25)
             );
--             
-- -----------------------------------
--      j. Alter table: Technique Three
          alter table students modify s_id constraint stud_pk primary key;
--
-- -----------------------------------
--      k. Clean up for next section
           drop table students;
           create table students
            (
                s_id integer,
                student_name  varchar2(25)
             );
--
-- ***********************************
--              UNIQUE
-- -----------------------------------
--      a. Alter table: Technique One 
            alter table students add unique(student_name);  
-- -----------------------------------
--      b. Confirm Unique constraint 
            select * from user_constraints;
-- -----------------------------------
--      c. Test Unique constraint 
            insert into students values (222,'Happy');
            insert into students values (456,'Happy');
            insert into students values (221,null);
            insert into students values (18778,'Doc');
            insert into students values (461,null);
            select * from students;
-- -----------------------------------
--      d. Remove all to clean up
            drop table students;
            create table students
            (
                s_id integer,
                student_name  varchar2(25)
            );
--     
-- -----------------------------------
--      h. Alter table Unique: Technique Two
           alter table students modify s_id primary key;
-- -----------------------------------
--      i. Clean up to start again
           drop table students;
           create table students
            (
                s_id integer,
                student_name  varchar2(25)
             );
--             
-- -----------------------------------
--      j. Alter table Unique: Technique Three
          alter table students modify s_id constraint stud_pk primary key;
--
-- -----------------------------------
--      k. Clean up for next section
           drop table students;
           create table students
            (
                s_id integer,
                student_name  varchar2(25)
             );
--
-- ***********************************
--              NOT NULL
-- -----------------------------------
--      a. Alter table Not Null: Technique One "not null is not the same" (pg 70)
            alter table students add not null(student_name); 
            -- Above cannot be done 
            -- Two other ways will work
-- -----------------------------------
--      b. Alter table Not Null: Technique Two
            alter table students modify student_name not null; 
            select * from user_constraints;
-- -----------------------------------
--      c. Test Not Null: Technique Two
            insert into students values (222,'Happy');
            insert into students values (456,'Happy');
            insert into students values (221,null);
            insert into students values (18778,'Doc');
            insert into students values (461,null);
-- -----------------------------------
--      d. Clean up for next section
           drop table students;
           create table students
            (
                s_id integer,
                student_name  varchar2(25)
             );
-- -----------------------------------
--      e. Alter table Unique: Technique Three
          alter table students modify student_name constraint stud_name_nn not null;
-- -----------------------------------
--      f. Test Not Null: Technique One
            insert into students values (222,'Happy');
            insert into students values (456,'Happy');
            insert into students values (221,null);
            insert into students values (18778,'Doc');
-- -----------------------------------
--      g. Clean up for next section
           drop table students;
           create table students
            (
                s_id integer,
                student_name  varchar2(25)
             );
            drop table student_age;
            create table student_age
            (
                s_id integer,
                age_id integer
             );               
-- -----------------------------------------------------------------------------
--  6.    ALTER TABLE: ADD FOREIGN KEY
--     Foreign key is a constraint on child table pointing to PK of parent table
-- -----------------------------------
--      a. Alter table Foreign Key: Technique One
        alter table student_age add constraint stud_fk foreign key (s_id) references students(s_id);
--      Fails because there is no PK in parent
-- -----------------------------------
--      b. Prepare Parent
        alter table students add primary key (s_id);  
-- -----------------------------------
--      c. Alter table Foreign Key: Technique One
        alter table student_age add constraint stud_fk foreign key (s_id) references students(s_id);
--      This time it works
-- -----------------------------------
--      d. Import Data Two tables Students and Student_ages
--         Which must go first?
--
-- -----------------------------------
--      e. Delete Data Two tables Students and Student_ages
--         Which must go first?
--
-- -----------------------------------------------------------------------------
--    7. CREATE SINGLE TABLE CONSTRAINTS AT CREATE TIME
--        NOTES: It is much easier to create constraints on tables before you start adding data
--               Chapter 11 Page 429 explains this in detail
          drop table cruises;
          create table cruises
          (
                  cruise_id number primary key,
                  cruise_name varchar2(30) not null,
                  cruise_number integer unique,
                  destination varchar2(50) check
                  (destination in ('Hawaii','Bahamas','Bermuda',
                  'Mexico','Day at Sea')),
                  start_date date default sysdate,
                  end_date date
              );
          
          drop table cruises;
          create table cruises
          (
                  cruise_id number,
                  cruise_name varchar2(30) not null,
                  cruise_number integer,
                  destination varchar2(50),
                  start_date date default sysdate,
                  end_date date,
                  constraint cruise_pk primary key (cruise_id),
                  -- NOT VALID MUST BE INLINE constraint cruise_name_nn not null (cruise_name),
                  constraint cruise_num_u unique (cruise_number),
                  constraint destination_ck check (destination IN  ('Hawaii','Bahamas','Bermuda','Mexico','Day at Sea'))
                  -- default must also be inline
                  );
                  
-- -----------------------------------------------------------------------------
--    7. CREATE TWO TABLE CONSTRAINTS (FOREIGN KEY) AT CREATE TIME
              create table customers 
              (	 
                      customer#     integer, 
                      lastname      varchar2(10), 
                      firstname     varchar2(10), 
                      address       varchar2(20), 
                      city          varchar2(12), 
                      state         varchar2(2), 
                      zip           varchar2(5), 
                      referred      integer, 
                      primary key (customer#)
              );
	 
              create table orders 
              (	
                    order# integer, 
                    customer# integer, 
                    orderdate date, 
                    shipdate date, 
                    shipstreet varchar2(18), 
                    shipcity varchar2(15), 
                    shipstate varchar2(2), 
                    shipzip varchar2(5), 
                    primary key (order#),
                    foreign key (customer#) references customers(customer#)
              );

-- -----------------------------------------------------------------------------
--    8. CREATE TABLE AS SELECT (CTAS)
                  create table customers_backup as 
                  select * from customers;