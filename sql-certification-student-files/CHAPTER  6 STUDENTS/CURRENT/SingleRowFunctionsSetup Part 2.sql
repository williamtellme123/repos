-- =============================================================================
--  CHAPTER 6 SETUP
/*
      Single Row Functions
        Character, Number, and Date
        Conversion
        Time Zones—Datetime Functions
*/
-- -----------------------------------------------------------------------------
--  CHARACTER FUNCTIONS
-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------
-- NUMBER FUNCTIONS
-- -----------------------------------------------------------------------------
      drop table num_functions;
      drop table some_numbers;
      create table some_numbers
      ( onevalue  number(9,4));
      insert into some_numbers values (89348.355555);
      insert into some_numbers values (465.99675555);
      commit;
      
      drop table some_numbers_for_remainder;
      create table some_numbers_for_remainder
      ( original_value  number(9,2));
      insert into some_numbers_for_remainder values (9);
      insert into some_numbers_for_remainder values (10);
      insert into some_numbers_for_remainder values (11);
   
      drop table some_numbers_for_mod;
      create table some_numbers_for_mod
      ( original_value  number(9,2));
      insert into some_numbers_for_mod values (9);
      insert into some_numbers_for_mod values (10);
      insert into some_numbers_for_mod values (11);
   
      drop table some_numbers_for_even_mod;
      create table some_numbers_for_even_mod
      ( original_value  number(9,2));
      insert into some_numbers_for_even_mod values (15.4);
      insert into some_numbers_for_even_mod values (17);
      insert into some_numbers_for_even_mod values (11);
      insert into some_numbers_for_even_mod values (6);
      commit;
      
-- -----------------------------------------------------------------------------
-- DATE FUNCTIONS
-- -----------------------------------------------------------------------------
      drop table some_dates;
      create table some_dates
      (   startdate date
        , enddate date
      );        
      
      insert into some_dates values 
          ( to_date('4/17/2016 6:31:23 AM', 'mm/dd/yyyy hh:mi:ss AM')
            ,to_date('4/17/2016 11:46:13 PM', 'mm/dd/yyyy HH:MI:SS PM')
            );
      insert into some_dates values 
          ( to_date('6/11/2016 4:22:10 PM', 'mm/dd/yyyy hh:mi:ss PM')
            ,to_date('7/27/2016 10:12:11 PM', 'mm/dd/yyyy HH:MI:SS PM')
            );
      commit;     

-- -----------------------------------------------------------------------------
-- INTERVAL FUNCTIONS
-- -----------------------------------------------------------------------------
--  INTERVAL YEAR(n) TO MONTH Stores a span of time defined in
--  only year and month values, n is digits defining YEAR value. Acceptable values is 0–9; 
--  default is 2. This datatype is useful for storing the difference between two dates.
      drop table some_intervals;
      create table some_intervals
      (   startdate date
        , enddate date
        , span  interval year(3) to month
      );        
     insert into some_intervals values 
          ( to_date('4/17/2016 6:31:23 AM', 'mm/dd/yyyy hh:mi:ss AM')
            ,to_date('4/17/2016 11:46:13 PM', 'mm/dd/yyyy HH:MI:SS PM')
            , null);
      insert into some_intervals values 
          ( to_date('6/11/2016 4:22:10 PM', 'mm/dd/yyyy hh:mi:ss PM')
            ,to_date('7/27/2016 10:12:11 PM', 'mm/dd/yyyy HH:MI:SS PM')
            , null);
      commit;     


     drop table other_intervals;
     create table other_intervals
      (   contractsartdate date
        , contractenddate date
      );        
     insert into other_intervals values 
          ( to_date('4/13/2015', 'mm/dd/yyyy')
            ,to_date('4/13/2016', 'mm/dd/yyyy'));
      commit;     


      drop table runners;
      create table runners
      ( 
        racer_id integer primary key,
        starttime date,
        endtime   date,
        Duration interval day(9) to second(9)
        -- precision of 9 for the day 
        -- precision of 4 for the fractional seconds 
        -- 3 digits may be stored for num of days 
        -- 4 digits to the right of the decimal point for the fractional seconds
        );
      
        
      -- Racer 1  Starts exactly at midnight and ends at 12:04:15  
      insert into runners values (1, to_date('21-Apr-04 12:00:00AM','dd-Mon-yy HH:mi:ssAM'), to_date('21-Apr-04 12:04:15AM','dd-Mon-yy HH:mi:ssAM'),null); 
      -- Racer 2  Starts exactly at midnight and ends at 15:04:17
      insert into runners values (2, to_date('21-Apr-04 12:00:00AM','dd-Mon-yy HH:mi:ssAM'), to_date('21-Apr-04 15:04:17','dd-Mon-yy HH24:mi:ss'),null); 
      -- Racer 3  Starts exactly at April 22, 2004 at 13:41:22 and ends April 23, 2004 at 04:51:22
      insert into runners values (3, to_date('22-Apr-04 13:41:22','dd-Mon-yy HH24:mi:ss'), to_date('23-Apr-04 04:51:22','dd-Mon-yy HH24:mi:ss'),null);   
      -- Racer 4  Starts exactly at April 22, 2004 at 13:41:22 and ends May 30, 2004 at 18:01:34'
      insert into runners values (4, to_date('22-Apr-04 13:41:22','dd-Mon-yy HH24:mi:ss'), to_date('30-May-04 18:01:34','dd-Mon-yy HH24:mi:ss'),null);
      -- Racer 5  Starts exactly at April 22, 2004 at 13:41:22 and ends May 30, 2004 at 18:01:34'
      insert into runners values (5, to_date('22-Apr-01 13:41:22','dd-Mon-yy HH24:mi:ss'), to_date('30-May-16 18:01:34','dd-Mon-yy HH24:mi:ss'),null); 
      commit;
      select * from runners;
-- -----------------------------------------------------------------------------
--  DATE TYPE CONVERSION
-- -----------------------------------------------------------------------------
      drop table some_numbers_stg;
      create table some_numbers_stg
      ( 
        monthly_sales varchar2(25)
      );
      insert into some_numbers_stg values ('$123,456.80');
      insert into some_numbers_stg values ('$675,112.59');
      insert into some_numbers_stg values ('$22,445.19');
      drop table some_numbers_final;
      create table some_numbers_final
      ( 
        monthly_sales number(12, 2)
       );
       
      drop table some_hiredates_stg;
      create table some_hiredates_stg
      ( 
        emp_name varchar2(25),
        hiredate date
      );
      insert into some_hiredates_stg values ('Belle',to_date('4-22-16', 'mm-dd-yy'));
      insert into some_hiredates_stg values ('Belle',to_date('12-22-15', 'mm-dd-yy'));
      insert into some_hiredates_stg values ('Buddy', to_date('12-2-14', 'mm-dd-yy'));
      insert into some_hiredates_stg values ('Sal',to_date('5-12-05', 'mm-dd-yy'));
      insert into some_hiredates_stg values ('Sal',to_date('6-11-99', 'mm-dd-yy'));
      insert into some_hiredates_stg values ('Sal',to_date('2-2-11', 'mm-dd-yy'));
      insert into some_hiredates_stg values ('Sal',to_date('1-7-09', 'mm-dd-yy'));
     commit;
           
-- -----------------------------------------------------------------------------
-- LOGIC FUNCTIONS
-- -----------------------------------------------------------------------------
      drop table my_coalesce;
      create table my_coalesce
      ( 
         id integer primary key 
        , work_phone varchar2(20)
        , cell_phone varchar2(20)
        , home_phone varchar2(20)
      );  
      
      insert into my_coalesce values (1, '(790) 330-1219','(808) 801-3044','(244) 746-9044');
      insert into my_coalesce values (2, null, '(809) 494-0271', '(948) 120-2806');
      insert into my_coalesce values (3, '(808) 801-3044',null,'(244) 746-9044');
      insert into my_coalesce values (4, '(209) 702-8693', '(244) 746-9044', null);
      insert into my_coalesce values (5, null, null, '(790) 330-1219');
      insert into my_coalesce values (6, '(948) 120-2806', null, null);    
      insert into my_coalesce values (7, null,'(621) 878-1010',null);
      commit; 
 
 