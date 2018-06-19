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
--    GENERAL
      update cruises.book_contents set page_number = 0 where page_number is null;
      commit;

      drop table my_ships; 
      create table my_ships 
      (	
        ship_id number(7,0)  primary key, 
        ship_name varchar2(20), 
        capacity number, 
        length number, 
        home_port_id number,
        lifeboats integer
      );
      
      insert into my_ships values (1,'Codd Crystal',2052,855,1, 82);
      insert into my_ships values (2,'Codd Elegance',2974,952,3,null);
      insert into my_ships values (3,'Codd Champion',2974,952,null,75);
      insert into my_ships values (4,'Codd Victorious',2974,952,3,115);
      insert into my_ships values (5,'Codd Grandeur',2446,916,2,0);
      insert into my_ships values (6,'Codd Prince',395,470,2,88);
      insert into my_ships values (7,'Codd Harmony',940,790,2,80);
      insert into my_ships values (8,'Codd Voyager',3114,1020,2,92);
      commit;
       
--    UPPER	UPPER(s1)
--    LOWER	LOWER(s1)
--    INITCAP	INITCAP(s1)
--    CONCAT, ||	CONCAT(s1,s2), s1 || s2
      drop table names_final;
      create table names_final
      (  first_upper varchar2(25)             -- 1   
        ,last_upper varchar2(25)              -- 2   
        ,first_lower varchar2(25)             -- 3   
        ,last_lower varchar2(25)              -- 4   
        ,full_name_pipe varchar2(25)          -- 5   
        ,full_name_concat varchar2(25));     -- 6   
      drop table names_stg;
      create table names_stg
      (  firstname varchar2(25)
        ,lastname varchar2(25));
      insert into names_stg values ('bUbBa','GUmp');
      insert into names_stg values ('foRESt','WhittIGER');
      commit;
      drop table names_final2;
      create table names_final2
      (
          rtrim_firstname varchar2(200)
        , rtrim_lastname varchar2(200)
        , ltrim_firstname varchar2(200)
        , ltrim_lastname varchar2(200)
        , trim_trailing_firstname varchar2(200)
        , trim_trailing_lastname varchar2(200)
        , trim_firstname varchar2(200)
        , trim_lastname varchar2(200)) ;
        
      drop table names_stg2;
      create table names_stg2
      (
          firstname varchar2(200)
        , lastname varchar2(200)
      );
--    LTRIM	LTRIM(s1,s2)
--    RTRIM	RTRIM(s1,s2)
--    TRIM	TRIM(trim_info trim_char FROM trim_source)
      insert into names_stg2 values ('*****Abe****','****Lincoln****');
      commit;
--    LENGTH
      drop table length_final;
      create table length_final
      (title varchar2(4000));
      drop table length_stg;
      create table length_stg
      (title varchar2(4000));
      insert into length_stg values (initcap('BODYBUILD IN 10 MINUTES A DAY'));
      insert into length_stg values (initcap('REVENGE OF MICKEY'));
      insert into length_stg values (initcap('BUILDING A CAR WITH TOOTHPICKS'));
      insert into length_stg values (initcap('DATABASE IMPLEMENTATION'));
      insert into length_stg values (initcap('COOKING WITH MUSHROOMS'));
      insert into length_stg values (initcap('HOLY GRAIL OF ORACLE'));
      insert into length_stg values (initcap('HANDCRANKED COMPUTERS'));
      insert into length_stg values (initcap('E-BUSINESS THE EASY WAY'));
      insert into length_stg values (initcap('PAINLESS CHILD-REARING'));
      insert into length_stg values (initcap('THE WOK WAY TO COOK'));
      insert into length_stg values (initcap('BIG BEAR AND LITTLE DOVE'));
      insert into length_stg values (initcap('HOW TO GET FASTER PIZZA'));
      insert into length_stg values (initcap('HOW TO MANAGE THE MANAGER'));
      insert into length_stg values (initcap('SHORTEST POEMS'));
      insert into length_stg values ('The history of the wars of New-England with the Eastern Indians; or, a narrative of their continued perfidy and cruelty, from the 10th of August, 1703, to the peace renewed 13th of July, 1713. And from the 25th of July, 1722, to their submission 15th December, 1725, which was ratified August 5th, 1726');
      commit;

--    INSTR	INSTR(s1,s2,pos,n)
--    SUBSTR	SUBSTR(s, pos, len)
      drop table my_strings_final;
      create table my_strings_final
      (
          company_id   varchar(100)
          , parent_company_id   varchar(100)
          , franchise_id   varchar(100)
      );
      drop table my_strings_stg;
      create table my_strings_stg
      (
          company_id   varchar(100)
      );
      insert into my_strings_stg values ('44AB-Norwalk');
      insert into my_strings_stg values ('A45T89YU-NYC42');
      insert into my_strings_stg values ('543SD');

--    SOUNDEX	SOUNDEX(s)
      drop table my_soundex_stg;
      create table my_soundex_stg
      (
          lastname   varchar(100)
      );
      insert into my_soundex_stg values ('smith');
      insert into my_soundex_stg values ('smyth');
      insert into my_soundex_stg values ('smythe');
      insert into my_soundex_stg values ('smydt');
      commit;

--    REPLACE	REPLACE(s1, s2,r) 
      drop table my_depo_final;
      create table my_depo_final
      (
         question     varchar(4000)
        ,answer       varchar(4000)
      );
      
      drop table my_depo_stg;
      create table my_depo_stg
      (
         question     varchar(4000)
        ,answer       varchar(4000)
      );
      insert into my_depo_stg values(
          'JB And do you recall when that occurred?'
        , 'PD Oh, my gosh, it was before I moved to Savannah; and to this day I''m convinced it was not DM''s problem, but his wife''s problem.'
      );
      commit;
-- -----------------------------------------------------------------------------
-- NUMBER FUNCTIONS
-- -----------------------------------------------------------------------------
      drop table num_functions;
      create table num_functions
      ( onevalue  number(9,2));
      insert into num_functions values (89348.3);
      insert into num_functions values (465.99675);
      
      drop table num_functions2;
      create table num_functions2
      ( onevalue  number(9,2));
      insert into num_functions2 values (12.4);
      insert into num_functions2 values (17);
      commit;
      
-- -----------------------------------------------------------------------------
-- DATE FUNCTIONS
-- -----------------------------------------------------------------------------
      drop table date_functions;
      create table date_functions
      (   startdate date
        , enddate date
      );        
      
      insert into date_functions values 
          ( to_date('4/17/2016 6:31:23 AM', 'mm/dd/yyyy hh:mi:ss AM')
            ,to_date('4/17/2016 11:46:13 PM', 'mm/dd/yyyy HH:MI:SS PM')
            );
      insert into date_functions values 
          ( to_date('6/11/2016 4:22:10 PM', 'mm/dd/yyyy hh:mi:ss PM')
            ,to_date('7/27/2016 10:12:11 PM', 'mm/dd/yyyy HH:MI:SS PM')
            );
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
 