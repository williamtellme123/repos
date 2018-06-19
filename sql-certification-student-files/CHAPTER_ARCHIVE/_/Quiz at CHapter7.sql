-- 1. Fix the following SQL and run it first
create table workers (
  worker_id       integer constraint rest_pk primary key,
  worker_name     varchar2(128),
  street          varchar2(75),
  city            varchar2(75),  
  state           varchar2(75)  
 );

-- 2. Fix the following SQL and run it second
create table restaurants (
  rest_id          number constraint rest_pk2 primary key,
  rest_namees      varchar2(128),
  street           varchar2(75),  
  city             varchar2(75),
  state            char(22)  
 ); 
 
-- 3. Fix the following SQL and run it third
drop table restaurant_shifts;
create table restaurant_shifts
    ( 
        shift_id      integer
        ,wrk_id       integer          
        ,rest_id       number             
        ,kindofjob   varchar2(50)
        ,week_day      date 
        ,start_Shift   timestamp
        ,end_Shift    timestamp
        ,constraint job_chk check (kindofjob in ('Cashier','Cook','Waitress','Bussing'))
        ,constraint wrk_fk foreign key(wrk_id) references workers(worker_id) 
        ,constraint rest_fk foreign key(rest_id) references restaurants(rest_id) 
        );

 

-- 4. Create the following table (it works as it)
-- then use the alter statement to add a primary key
create table mytest
(
  testid    integer,
  testname  char(5));
-- complete the following alter statement

alter table mytest add primary key(testid);

-- 5. Write a SQL query that returns computer books or family life and where retail is 
--    less than 75
select title, category
from books
where category in ('COMPUTER','FAMILY LIFE')
and retail < 75;

-- 6. Can you explain in a sentence how the sort works here?
select state, city, firstname ||' ' || lastname fullname
from books.customers
order by lastname, 1 desc, fullname;

 

 

-- 7. If you do a cartesean join on the three following tables
--    a. What will be the number of columns returned
--    b. What will be the number of rows returned
--    --------------------------------------------------
--    Table 1: RESIDENTS has the following columns
--        id, resident, street, city, state, zip, phone, eamil
--    Table 1 has the following rows
--        Records for 2022 residents
--
--    Table 2: STATES has the following columns
--        stid, state_name, state_bird, state_flower, state_slogan
--    Table 2 has the following columns
--        implied
--
--    Table 3: REGIONS has the following columns
--        rid, regions_name, numberofstates, squaremiles
--    Table 3 has the following rows
--        421 rows
--
select 8 + 5 + 4 from dual;
select 2022 * 50 * 421 from dual;