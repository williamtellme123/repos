

drop table runners;
create table runners
( 
  racer_id integer primary key,
  Starttime date,
  endtime   date,
  Duration interval day(9) to second(9)
  -- precision of 9 for the day 
  -- precision of 4 for the fractional seconds 
  -- 3 digits may be stored for num of days 
  -- 4 digits to the right of the decimal point for the fractional seconds
  );
select * from runners;
  
-- Racer 1  Starts exactly at midnight and ends at 12:04:15  
insert into runners values (1, to_date('21-Apr-04 12:00:00AM','dd-Mon-yy HH:mi:ssAM'), to_date('21-Apr-04 12:04:15AM','dd-Mon-yy HH:mi:ssAM'),null); 
-- Racer 1  Duration in minutes
select racer_id, NUMTODSINTERVAL(endtime-starttime, 'DAY') from runners order by 1;
select racer_id, NUMTODSINTERVAL(endtime-starttime, 'HOUR') from runners order by 1;
select racer_id, NUMTODSINTERVAL(endtime-starttime, 'MINUTE') from runners order by 1;
select racer_id, NUMTODSINTERVAL(endtime-starttime, 'SECOND') from runners order by 1;

-- Racer 2  Starts exactly at midnight and ends at 15:04:17
insert into runners values (2, to_date('21-Apr-04 12:00:00AM','dd-Mon-yy HH:mi:ssAM'), to_date('21-Apr-04 15:04:17','dd-Mon-yy HH24:mi:ss'),null); 
-- Racer 2  Duration in minutes
select racer_id, NUMTODSINTERVAL(endtime-starttime, 'DAY') from runners order by 1;

-- Racer 3  Starts exactly at April 22, 2004 at 13:41:22 and ends April 23, 2004 at 04:51:22
insert into runners values (3, to_date('22-Apr-04 13:41:22','dd-Mon-yy HH24:mi:ss'), to_date('23-Apr-04 04:51:22','dd-Mon-yy HH24:mi:ss'),null);   
-- Racer 3  Duration in minutes
select racer_id, NUMTODSINTERVAL(endtime-starttime, 'DAY') from runners order by 1;

-- Racer 4  Starts exactly at April 22, 2004 at 13:41:22 and ends May 30, 2004 at 18:01:34'
insert into runners values (4, to_date('22-Apr-04 13:41:22','dd-Mon-yy HH24:mi:ss'), to_date('30-May-04 18:01:34','dd-Mon-yy HH24:mi:ss'),null);
select racer_id, NUMTODSINTERVAL(endtime-starttime, 'DAY') from runners order by 1;

-- Racer 5  Starts exactly at April 22, 2004 at 13:41:22 and ends May 30, 2004 at 18:01:34'
insert into runners values (5, to_date('22-Apr-01 13:41:22','dd-Mon-yy HH24:mi:ss'), to_date('30-May-16 18:01:34','dd-Mon-yy HH24:mi:ss'),null); 
select racer_id, NUMTODSINTERVAL(endtime-starttime, 'DAY') from runners order by 1;

-- NOW UPDATE
update runners set duration = NUMTODSINTERVAL(endtime-starttime, 'DAY');

select * from runners;




-- Racer 2  Starts exactly at April 22, 2004 at 13:41:22 and ends April 23, 2004 at 04:51:22
insert into davidtest values (2, to_date('22-Apr-04 13:41:22','dd-Mon-yy HH24:mi:ss'), to_date('23-Apr-04 04:51:22','dd-Mon-yy HH24:mi:ss'),0);   
  
  
select * from davidtest;
select racer_id, endtime, starttime, endtime - starttime from davidtest;

SELECT TO_CHAR (TRUNC (SYSDATE) + NUMTODSINTERVAL (120, 'second'),
                'hh24:mi:ss'
              ) hr;
              
SELECT 
   TO_CHAR(TRUNC((MINUTES * 60) / 3600), 'FM9900') || ':' ||
   TO_CHAR(TRUNC(MOD((MINUTES * 60), 3600) / 60), 'FM00') || ':' ||
   TO_CHAR(MOD((MINUTES * 60), 60), 'FM00') AS MIN_TO_HOUR FROM DUAL;

-- In Oracle use:
select sysdate, to_char(sysdate, 'FMdd-Mon-yy HH:Mi:ss') from dual;
SELECT TO_CHAR (TRUNC (SYSDATE) + NUMTODSINTERVAL (120, 'second'),
                'hh24:mi:ss'
              ) hr
FROM DUAL;

-- In SqlServer use:
-- SELECT CONVERT(varchar, DATEADD(s, X, 0), 108);
-- SELECT CONVERT(varchar,endtime-starttime, 108);

-- IN access
SELECT
   86460\3600 & format(86460\60 mod 60,"\:00") & Format(86460 MOD 60, "\:00")
from runners2;

-- SQL SERVER
SELECT CONVERT(time, 
               DATEADD(mcs, 
                           DATEDIFF(mcs, 
                                    '2007-05-07 09:53:00.0273335', 
                                    '2007-05-07 09:53:01.0376635'
                                    )
                      , CAST('1900-01-01 00:00:00.0000000' as datetime2)
                      )
              );
-- First remember simple date subtraction so for example how long has it been since the beginning of this month
select sysdate from dual;
select sysdate - to_date('01-Apr-16 12:00:00AM','dd-Mon-yy HH:mi:ssAM') from dual;
-- What is this value that you get?
-- It is number of days.
-- How would you turn the number of days into the number of hours? How many hours in a day?
select (sysdate - to_date('01-Apr-16 12:00:00AM','dd-Mon-yy HH:mi:ssAM'))*24 from dual;
-- How would you turn the number of days into the number of hours and minutes? How many mins in a day?


-- How would you turn the number of days into the number of hours? How many hours in a day?
-- How would you turn the number of days into the number of hours? How many hours in a day?
SELECT 
   TO_CHAR(TRUNC((MINUTES * 60) / 3600), 'FM9900') || ':' ||
   TO_CHAR(TRUNC(MOD((MINUTES * 60), 3600) / 60), 'FM00') || ':' ||
   TO_CHAR(MOD((MINUTES * 60), 60), 'FM00') AS MIN_TO_HOUR FROM DUAL;
   
-- to_date('21-Apr-04 15:04:17','dd-Mon-yy HH24:mi:ss'),0); 














select OutageDurationInMinutes from davidtest;
-- starts at midnight goes to 3:14pm
select to_char(OutageDurationInMinutes, ''


/*
Here is the result of the above query:-
So, my dilemma is to change the last column's result (OutageDurationMinutes) to TimeStamps of this type HR:MIN:SEC, as in 00:00:00.
I currently have the result of OutageDurationMinutes column as Date and Time ( 21-Apr-04 12:00AM) but I will like to change it to this HR:MIN:SEC, as in 00:00:00.
I have played around with the SQL Statemant/Query above but no success yet. I know something is missing in the SQL query that is preventing the OutageDurationMinutes column to get the result that I want.
But please look through it and any feedback would be appreciated.  Thank you sir.
David

*/

SELECT
           datediff("s",[starttime],[endtime])
            ,format(Clng(86460)/86400,"hh:nn:ss") 
             ,format(3600/86400,"hh:nn:ss") 


                ,  format(
                      Clng(datediff("s",[starttime],[endtime]))/86400
                      ,"hh:nn:ss")

              ,  format(
                      datediff("s",[starttime],[endtime])/86400
                      ,"hh:nn:ss")

  from runners2;
