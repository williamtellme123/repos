-- =============================================================================
--  CHAPTER 6 SETUP
/*
      Single Row Functions
        Character, Number, and Date
        Conversion
        Time Zones—Datetime Functions
*/
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
        empo_id integer primary key,
        emp_name varchar2(25),
        hiredate date
      );
      insert into some_hiredates_stg values (1, 'Adelle',to_date('4-22-16', 'mm-dd-yy'));
      insert into some_hiredates_stg values (2, 'Brianna',to_date('12-22-15', 'mm-dd-yy'));
      insert into some_hiredates_stg values (3, 'Carly', to_date('12-2-14', 'mm-dd-yy'));
      insert into some_hiredates_stg values (4, 'Denise',to_date('5-12-05', 'mm-dd-yy'));
      insert into some_hiredates_stg values (5, 'Elaine',to_date('6-11-99', 'mm-dd-rr'));
      insert into some_hiredates_stg values (6, 'Franny',to_date('2-2-11', 'mm-dd-yy'));
      insert into some_hiredates_stg values (7, 'Gerogia',to_date('1-7-09', 'mm-dd-yy'));
      commit;
 
