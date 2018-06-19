-- =============================================================================
--  TOC
--      CONSTRAINT TYPE SINGLE TABLE: constraint is a rule on 1 or more columns
--              PRIMARY KEY: must be unique and not null
--              UNIQUE: must be unique (and can be null)          
--              NOT NULL: cannot be null
--                  What does null mean: unknown
--              CHECK: 
--              DEFAULT:
--      CONSTRAINT TYPE TWO TABLES
--              FOREIGN KEY:See master
-- =============================================================================
-- Chapter 2
-- ON PREVIOUSDLY EXISTING TABLES
create table students
(
    s_id integer,
    student_name  varchar2(25)
 );
 
select * from user_constraints;
-- PRIMARY KEY
-- add constraint after table creation
-- typically an afterthought
alter table students add primary key(s_id);                    -- sys gives name
alter table students add constraint stud_pk primary key(s_id); -- user(me) names it
alter table students modify s_id primary key;                  -- sys gives name
alter table students rename constraint SYS_C007570 to STUD_PK; -- rename a constraint

-- UNIQUE
-- same pattern of techniques used in primary key works for unique contraint

-- NOT NULL
-- Next line does not work as per Oracle (like it did for primary key and unique
-- alter table students add not null(student_name); 
alter table students modify student_name not null; 
alter table students modify student_name constraint stud_name_nn not null;

-- FOREIGN KEY
-- Creates a parent child relationship
-- it connects to the primary key in the parent table
-- and prevents orphans
-- it is created on the child table and points to the PK of the parent
-- primary key on parent must come first
--    Prepare Parent
      alter table students add primary key (s_id);  
--    Alter child table by adding a Foreign Key
      alter table student_age add constraint stud_fk foreign key (s_id) references students(s_id);

-- =============================================================================
-- CONSTRAINTS CREATED AT TIME OF TABLE CREATION
-- Create Inline constraints at time of table creation
 create table cruises
(
    cruise_id number constraint cruise_id_pk primary key,
    cruise_name varchar2(30) not null,
    cruise_number integer unique,
    destination varchar2(50) check
              (
                  destination in ('Hawaii','Bahamas','Bermuda',
                  'Mexico','Day at Sea')
              ),
    start_date date default sysdate,
    end_date date
);
-- Create Out of Line constraints at time of table creation
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

-- =============================================================================
-- Chapter 3
select * from mycustomers;

select firstname, lastname, state                       
from mycustomers;

select firstname, lastname, state
from mycustomers
where lastname = 'MORALES'

-- first look at joins
select *
from small_customers, small_orders
where custname = 'Fred'
and cust_id = cid;

-- INSERT TYPES
insert into friends values (1, 'Bill', 'Bailey',5552344444, 'bbailey@hotmail.com');
insert into friends (friend_id, fname, lname) values (3,'Big', 'Julie');
insert into friends(email,phone, fname, lname, friend_id) 
                    values ('hornet@comet.com','1 (512) 560-3456', 'Buzz' , 'LightYear' ,4);
-- CTAS
create table testcustomers as
      select customer#,firstname, lastname 
      from books.customers
      where state = 'FL';

-- DELETE      
delete mybooks;
delete customers where lastname = 'MORALES';
delete friends where email is null;

select * from friends;
insert into friends(friend_id,fname,lname)values(5,'ABC','XYZ');
insert into friends(friend_id,fname,lname)values(6,'aBcdE$c','hhnam');
insert into friends(friend_id,fname,lname)values(7,'tAMMy','yONKers');
select * from friends where lower(lname) = 'boop';


-- UPDATE
update mycustomers set lastname = 'THOMAS' where firstname = 'CINDY';
update mycustomers 
                set zip = '60600',
                    referred = '1003' 
         where firstname = 'REESE';
         
-- ROLLBACk
-- SAVEPOINT
-- COMMIT;










-- add constraint at time of table creation
-- typical best practice

