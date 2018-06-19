-- =============================================================================
-- CHAPTER 17 PARKS TUTORIAL SETUP
-- -----------------------------------------------------------------------------
-- 1. SETUP
--    a. Open the CHAPTER_17_STUDENTS_SETUP.sql
--    b. Open the connection to your schema
--    c. Follow instructions in file

-- =========================================================================
-- --------------------------------------------------------------------------
-- Begins the tutorial
-- this is the simplest way to find a row
-- it uses an exact match of the entire column contents
-- spelling and letter casing
select *
from park
where park_name='Mackinac Island State Park';
-- ------------------------------------------------
-- next level of complexity is like which allows 
-- two simple wildcards (searches the entire column)
select *
from park 
where lower(park_name) like '%park'; 
-- --------------------------------------------------------------------------
-- regexp_substr function is showing us what is being
-- used by the regexp_like function to mark rows as
-- true in the where clause
select park_name, regexp_substr(park_name,'park',1,1,'i') 
from park
where regexp_like (park_name,'park','i');
-- --------------------------------------------------------------------------
SELECT regexp_substr(description, '.{3}-.{4}')
FROM park
WHERE regexp_like(description, '.{3}-.{4}');
-- --------------------------------------------------------------------------
-- --------------------------------------------------------
-- regexp_like more powerful (anyplace in column)
-- Use regexp_substr to see what regexp_like is marking as true
-- --------------------------------------------------------
SELECT park_name,regexp_substr(park_name, 'State Park')
FROM park
WHERE regexp_like(park_name, 'State Park');

-- ------------------------------------------------
-- lets see if we can find phone numbers
SELECT --park_name,
  --description,
  regexp_substr(description, '...-....')
FROM PARK
WHERE regexp_like(description, '...-....');

-- ------------------------------------------------
SELECT 
  regexp_substr(description, '.{3}-.{4}')
FROM park
WHERE regexp_like(description, '.{3}-.{4}');

-- ------------------------------------------------
-- See false positives
SELECT regexp_substr(description, '...-....'),description
FROM park
WHERE regexp_like(description, '...-....')
AND (park_name LIKE '%Mus%'
OR park_name LIKE '%bofj%');
-- ------------------------------------------------
-- zoom in on false positives
SELECT regexp_substr(description, '...-....'),
  park_name
FROM park
WHERE regexp_like(description, '...-....')
AND (park_name LIKE '%Mus%'
OR park_name LIKE '%bofj%');

- ------------------------------------------------
-- a list of characters
SELECT regexp_substr(description,'[0123456789]{3}-[0123456789]{4}')
FROM park
WHERE regexp_like(description,'[0123456789]{3}-[0123456789]{4}');

SELECT 
  regexp_substr(description,'[0-9]{3}-[0-9]{4}')
FROM park
WHERE regexp_like(description,'[0-9]{3}-[0-9]{4}');

SELECT 
  regexp_substr(description,'[[:digit:]]{3}-[[:digit:]]{4}')
FROM park
WHERE regexp_like(description,'[[:digit:]]{3}-[[:digit:]]{4}');
-- ------------------------------------------------
-- a range of characters depicted page 642
SELECT 
  regexp_substr(description, '[0-9]{3}-[0-9]{4}')
FROM park
WHERE regexp_like(description, '[0-9]{3}-[0-9]{4}');



-- ------------------------------------------------
-- a character class page 642
-- ------------------------------------------------
SELECT 
  regexp_substr(description, '[[:digit:]]{3}-[[:digit:]]{4}')
FROM park
WHERE regexp_like(description, '[[:digit:]]{3}-[[:digit:]]{4}');

-- ------------------------------------------------
-- caret ^ is the "NOT" operator
-- so this says anything that is NOT a digit
-- ------------------------------------------------
SELECT park_name,
  regexp_substr(description, '[[:digit:]]{3}[^[:digit:]][[:digit:]]{4}') 
FROM park
WHERE regexp_like(description, '[[:digit:]]{3}[^[:digit:]][[:digit:]]{4}');
-- ------------------------------------------------
-- escape character "\" if we want to find a period and not have the period
-- represent any character but instead a period
-- this finds phone numbers that have either a period separating the groups
SELECT park_name,
  regexp_substr(description, '[[:digit:]]{3}\.[[:digit:]]{4}')
FROM park
WHERE regexp_like(description, '[[:digit:]]{3}\.[[:digit:]]{4}');


-- ------------------------------------------------
----- send above to students
-- duplicates references
-- the ^ here is the begining of the line
-- not a character at the beginning but <bol>
SELECT 
  regexp_substr(description, '(^|[[:space:][:punct:]]+)([[:alpha:]]+)'
  || '[[:space:][:punct:]]+\2'
  || '($|[[:space:][:punct:]]+)') hello,
  description
FROM park
WHERE regexp_like(description, '(^|[[:space:][:punct:]]+)([[:alpha:]]+)'
  || '[[:space:][:punct:]]+\2'
  || '($|[[:space:][:punct:]]+)');

SELECT 
  regexp_substr(description, '(^|[[:space:][:punct:]]+)([[:alpha:]]+)'
  || '[[:space:][:punct:]]+\2'
  || '($|[[:space:][:punct:]]+)') double_words,
  description
FROM park
WHERE regexp_like(description, '(^|[[:space:][:punct:]]+)([[:alpha:]]+)'
  || '[[:space:][:punct:]]+\2'
  || '($|[[:space:][:punct:]]+)');


-- ------------------------------------------------
-- subexpresssions show how quantifiers can be used in multiple places
SELECT 
  regexp_substr(description, '\+([0-9]{1,3} ){1,4}([0-9]+) ' ),description
  FROM park
WHERE regexp_like(description, '\+([0-9]{1,3} ){1,4}([0-9]+) ');
--
SELECT 
  regexp_substr('45 67 89', '\+([0-9]{1,3} ){1,4}([0-9]+) ' )
FROM park
WHERE regexp_like('45 67 89', '\+([0-9]{1,3} ){1,4}([0-9]+) ');
--
SELECT 
  regexp_substr('+45 67 89 777 666555555577777 ', '\+([0-9]{1,3} ){1,4}([0-9]+) ' )
FROM dual
WHERE regexp_like('+45 67 89 777 666555555577777 ', '\+([0-9]{1,3} ){1,4}([0-9]+) ');




select regexp_substr('+46 8 698 10 234565', '\+([0-9]{1,3} ){1,4}[0-9]+') from dual;

select regexp_substr('+46 8 698 10 00', '\+([0-9]{1,3} ){1,4}[0-9]+') from dual;


-- ------------------------------------------------
-- alternation using an OR symbol "|" (single pipe)
SELECT 
  regexp_substr(description,'[[:digit:]]{3}-[[:digit:]]{4}|[[:digit:]]{3}\.[[:digit:]]{4}')
FROM park
WHERE regexp_like(description,'[[:digit:]]{3}-[[:digit:]]{4}|[[:digit:]]{3}\.[[:digit:]]{4}');


-- ------------------------------------------------
-- concise alteration
SELECT 
  regexp_substr(description,'[[:digit:]]{3}(-|\.| )[[:digit:]]{4}')
  ,description
FROM park
WHERE regexp_like(description,'[[:digit:]]{3}(-|\.| )[[:digit:]]{4}');
insert into park (description) values ('512 345 4567');commit;
insert into park (description) values ('(512) 345 4567');commit;
desc park;
insert into park values ('APPLE','0','US','222 3456');
commit;





SELECT 
  regexp_substr(description,'([0-9]{3})(-|\.)([0-9]{4})')
FROM park
WHERE regexp_like(description,'([0-9]{3})(-|\.)([0-9]{4}))';


SELECT 
  regexp_substr(description,'[0-9]{3} [0-9]{4}')
FROM park
WHERE regexp_like(description,'[0-9]{3} [0-9]{4}');

select * from park;
insert into park values ('ABC',null,'US','234 4567');
commit;


SELECT 
  regexp_substr(description,'[0-9]{3}(-|\.| )[0-9]{4}')
FROM park
WHERE regexp_like(description,'[0-9]{3}(-|\.| )[0-9]{4}');

SELECT 
  regexp_substr(description,'[0-9]{3}( |-|\.)[0-9]{4}')
FROM park
WHERE regexp_like(description,'[0-9]{3}( |-|\.)[0-9]{4}');

-- ------------------------------------------------
-- this is area code with () or dashes or periods
SELECT regexp_substr (description, 
  '[[:digit:]]{3}(-|\.| )[[:digit:]]{4}'), description
FROM park
WHERE regexp_like (description, '[[:digit:]]{3}(-|\.| )[[:digit:]]{4}');

SELECT park_name,
  regexp_substr (description, 
  '[[:digit:]]{3}[-|\.| ][[:digit:]]{4}') 
FROM park
WHERE regexp_like (description, '[[:digit:]]{3}[-|\.| ][[:digit:]]{4}');

SELECT park_name,
  regexp_substr (description, 
  '[[:digit:]]{3}(\.|-| )[[:digit:]]{4}') 
FROM park
WHERE regexp_like (description, '[[:digit:]]{3}(\.|-| )[[:digit:]]{4}');


SELECT park_name,
  regexp_substr (description, 
  '[[:digit:]]{3}[ .-][[:digit:]]{4}') 
FROM park
WHERE regexp_like (description, '[[:digit:]]{3}[ .-][[:digit:]]{4}');


SELECT park_name,
  regexp_substr (description, 
  '\([[:digit:]]{3}\)[ .-][[:digit:]]{3}[ .-][[:digit:]]{4}') 
FROM park
WHERE regexp_like (description, '\([[:digit:]]{3}\)[ .-][[:digit:]]{3}[ .-][[:digit:]]{4}');

insert into park (description) values ('800ThepARK');
insert into park (description) values ('800 222 6789');
insert into park (description) values ('800.222.6789');
insert into park (description) values ('(800) 222 6789');
insert into park (description) values ('+1 (800) 222 6789');
insert into park (description) values ('27 73 222 6789');

insert into park (description) values ('+46 8 698 10 00');
commit;











-- 1
SELECT regexp_substr (description, '([+]?[1] ?(\(| |)[0-9]{3})(\)| |)')
FROM park
WHERE regexp_like (description, '([+]?[1] ?(\(| |)[0-9]{3})(\)| |)');
-- 2
SELECT regexp_substr (description, '\+([0-9]{1,3} ){1,4}[0-9]+')
FROM park
WHERE regexp_like (description,'\+([0-9]{1,3} ){1,4}[0-9]+');
-- 3
SELECT regexp_substr (description, '((\(| |)[0-9]{3})(\)| |)')
FROM park
WHERE regexp_like(description,'(\(| |)[0-9]{3})(\)| |)');
-- 4 copy from above the patter for (512) 312-8989  (where the separator is - . <space>
SELECT regexp_substr (description, '(\(| |)[0-9]{3}(\)| |\.|)[0-9]{3}(\.| |-)[0-9]{4}') FROM park
WHERE regexp_like(description,'(\(| |)[0-9]{3}(\)| |\.|)[0-9]{3}(\.| |-)[0-9]{4}');

SELECT regexp_substr ('(512) 345-6789', '(\(| |)[0-9]{3}((\) )| |.)[0-9]{3}(\.| |-)[0-9]{4}') FROM dual;

delete park where park_name in ('APPLE','ABC');
commit;
select * from park;

insert into park(description) values ('(800) 222 6789');
SELECT regexp_substr ('(800) 222 6789',  '(\(| |)[0-9]{3}(\)| |) [0-9]{3}(\.| |-)[0-9]{4}')
FROM dual;

insert into park(description) values ('+1 (800) 222 6789');
SELECT regexp_substr ('+1 (800) 222 6789','(\+)?((1)? )(\(| |)[0-9]{3}(\)| |) [0-9]{3}(\.| |-)[0-9]{4}') FROM dual;

insert into park(description) values ('(512) 345 4567');
SELECT regexp_substr ('(512) 345 4567','(\()[0-9]{3}(\)) [0-9]{3}(\.| |-)[0-9]{4}') FROM dual;


insert into park(description) values ('+46 8 698 10 00');
SELECT regexp_substr ('+46 8 698 10 00','(\+)?([0-9]{1,3}( )?){1,5}') FROM dual;
commit;
select * from park where park_name is null;


-- 5
select regexp_substr('+46 8 698 10 00', '\+([0-9]{1,3} ){1,4}[0-9]+') from dual;


--[0-9]{3}[ |.|-][0-9]{4}$
SELECT regexp_substr ('906.-.3456','[.-.]') from dual;

select regexp_substr('123456789-2345', '[0-9]{3}-[0-9]{4}') from dual;
select regexp_substr('123456789-2345-5678', '[0-9]{3}-[0-9]{4}') from dual;

-- what about non area code numbers
-- what about dots
