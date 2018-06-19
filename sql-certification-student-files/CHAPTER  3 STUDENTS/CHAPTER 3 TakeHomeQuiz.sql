-- 1. Fix the following SQL and run it first
create table workers (
  worker_id       integer constraint artist_pk primary key,
  worker_name     char2(128),
  street          char2(75),
  city            char2(75),  
  state           char2(75),  
 );

-- 2. Fix the following SQL and run it second
create table restaurants (
  rest_id          number constraint artist_pk primary key,
  rest_namees      varchar2(128 bytes),
  street           char(2),  
  city             varchar2(75),
  state            varchar2(2)  
 ); 

-- 3. Fix the following SQL and run it third
create table restaurant_shifts
      ( 
        shiftid      integer,
        wrk_id       integer,           
        restid       varchar2(25),             
        kind ofjob   varchar2(50), -- this rule only allows types of roles
        weekday      date, 
        startShift   timestamp,
        end Shift    timestamp,
        constraint check (kind ofRole type in ('Cashier','Cook','Waitress','Bussing')),
        constraint foreign key(wrk_id) references workers(worker_id), -- this references parent actors
        constraint foreign key(restid) references restaurants(rest_id)  -- this references parent movies
        );

-- 4. Create the following table (it works as it)
-- then use the alter statement to add a primary key
create table mytest
(
  testid    integer,
  testname  char(5));
-- complete the following alter statement
alter ........;
-- 5. Write a SQL query that returns computer books or family life and where retail is less than 75


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
















        
       