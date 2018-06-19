-- =============================================================================
-- Chapter 17 Regular Expression Support
-- setup using the Parks Regex Tutorial.sql file
-- =============================================================================
/* -----------------------------------------------------------------------------
  Using Metacharacters pp 640 - 643
  regexp_substr(s1, pat1, pos1, ocr1, param) pp 646 - 659
    searches target string s1 for pattern pat1 returns the string matching the pattern
    Starts the search at pos1, uses 1 by default
    Looks for the ocr1 occurance
    param is a match parameter
------------------------------------------------------------------------------*/
-- exact match
SELECT regexp_substr('123 Maple Avenue', 'Maple') address FROM dual;
-- [] returns the first occurance of any value within the square bracets #2
SELECT regexp_substr('123 Maple Avenue', '[a-z]') address FROM dual;

-- returns the 3rd occurrence starting from position 1 of any of the
-- characters in the list
-- the fifth parameter of 'i' is for case insensitivity

-- ^ Beginning of line anchor (not in a list) #17
SELECT regexp_substr('mark', '^m') FROM dual;

-- {} match 2 occurrences next to each other #11
SELECT regexp_substr('123 Maple Avenue', '[ev]{2}') address FROM dual;
-- setting two ranges, lower case a-z and upper case A-Z

-- + match one or more occurrences of anything in the brackets (# 10 of table 17-1)
-- at least 3 but not more than 5 (#13 in table 17-1)

-- $ end of line anchor (#18 ub table 17-1)

-- Where is the second occurrence?
-- Does not return apl because the string is consumed

-- p 649
-- sequence starts with s, then any one of eashor and must end with an e

-- () the enclosed expression or literals is treated as a subexpression (#1 in table 17-1)

-- parsing delimited strings
--[^] caret within [] means not (#3 in table 17-1)
SELECT regexp_substr('BMW-Oracle;Trimaran;Feb 2010', '[^;]+', 1, 3) result FROM dual;

/* -----------------------------------------------------------------------------
  [[: :]] Using character classes (#5 in table 17-1)
    Different character classes are listed in table 17-2 on page 642
    Character classes are preferable in multilingual environments
------------------------------------------------------------------------------*/
SELECT regexp_substr('123 On Maple Avenue', '[[:alpha:]]{3}') address FROM dual;
-- This is just a list that includes :alph characters
-- Using two character classes in one list, this is the same as [[:alnum:]]


-- Exercise: search for [[:alpha:]]+re in the seashell example

/* -----------------------------------------------------------------------------
  regexp_instr (s1, pat1, pos1, ocr1, opt, param) - page 643
    searches a target string s1 for pattern pat1 and returns a location
    Starts the search at pos1, uses 1 by default
    Returns the location of ocr1 occurance
    param is a match parameter
------------------------------------------------------------------------------*/
SELECT regexp_substr('She sells sea shells by the seashore', 's[eashor]+') string,
        regexp_instr('She sells sea shells by the seashore', 's[eashor]+') location FROM dual;

-- * returns 0 or more of the preceeding expression or literal (#9 of table 17-1)

-- case sensitivity in regexp_instr is the 6th parameter
-- the regexp_instr 5th parameter is either 0 or 1
-- 0 returns the starting location, 1 returns the location after the end

/* -----------------------------------------------------------------------------
  Pattern searches with table data - pp 648-653
------------------------------------------------------------------------------*/
-- use cruises
SELECT * FROM order_addresses;

-- p 650 uses the logical OR (#16 in table 17-1)
    
-- p651 two separate lists 


-- [[:space:]] includes non printing characters


/* -----------------------------------------------------------------------------
  regexp_like - more powerful (anyplace in column)
    Use regexp_substr to see what regexp_like is hitting on first without regexp_like
------------------------------------------------------------------------------*/


-- third parameter in regexp_like handle case sensitivity
                         
-- What are the addresses in zip codes that begin with 0?


/* -----------------------------------------------------------------------------
  regexp_replace (s1, pat1, rpl1, pos1, ocr1, param) - pp 654-7
    searches a target string s1 for pattern pat1 and replaces it with rpl1
    Starts the search at pos1, uses 1 by default
    Replaces ocr1 occurances
    param is a match parameter
------------------------------------------------------------------------------*/
-- . is a wildcard that matches any character (#7 in table 17-1)
SELECT regexp_replace ('Chapter 1 .............................. I Am Born',
                        '.', '-') FROM dual;
-- . in [] is a literal as are most metacharacters

-- p654
SELECT regexp_replace('And then he said *&% and I replied $@($*@',
                      '[!@#$%^&*()]', '-') as prime_time FROM dual;

-- p 655 removing extra spaces
SELECT regexp_replace ('and      in conclusion,    2/3rds   of our  revenue',
                       '  ', ' ') FROM dual;
-- {n1,} replaces two or more spaces (#12 in table 17-1)
-- replaces one or more spaces

SELECT address2, regexp_replace(address2, '[[:alpha:]]+', 'CITY') AS replaced
  FROM order_addresses;
-- Filter out the city name from address2
SELECT address2, regexp_replace(address2, '^[^,]+, ', '') AS replaced
  FROM order_addresses;
  
/* -----------------------------------------------------------------------------
  Back references pp 657-658
    back reference says match what has already been matched
    by the numbered subexpression
------------------------------------------------------------------------------*/
-- simple example of back reference \1  (#15 in table 17-1)
SELECT regexp_substr('She sells sea shells by the seashore', 
                     'She sells ([[:alpha:]]+) shells by the \1shore') result FROM dual;



/* -----------------------------------------------------------------------------
  regexp_count
-------------------------------------------------------------------------------*/
select regexp_count('The shells she sells are surely seashells', 'el')
  as result from dual;



/* -----------------------------------------------------------------------------
  Phone number search pattern
------------------------------------------------------------------------------*/
-- page 650 bottom
select regexp_substr('Help desk: (212) 555-1212', '([[:digit:]]+)')
  as area_code from dual;
  
-- area code test p 651
-- \ identifies () as literals, (#14 in table 17-1)
 
-- run Parks Regex Tutorial in books
-- switch to books schema
SELECT * FROM park;
-- simpliest pattern is exact duplicate
SELECT * FROM park WHERE park_name = 'Mackinac Island State Park';

-- next level of complexity is like (entire column)
SELECT * FROM park WHERE park_name LIKE '%State Park%';

-- Next with regexp_like
select park_name, regexp_substr(park_name, 'State Park') from park;

select park_name, regexp_substr(park_name, 'State Park')
  from park where regexp_like(park_name, 'State Park');

insert into park (park_name, description) values ('My park', '202.654.4345');
insert into park (park_name, description) values ('My new park', '202 777 0278');
insert into park (park_name, description) values ('My old park', '(202)654-4345');
insert into park (park_name, description) values ('My foreign park', '+51 6.754.12.34');
insert into park (park_name, description) values ('US park', '+1 (512) 852-5837');
insert into park values ('ABC', null, 'US', '234 4567');
commit;

-- lets see if we can find phone numbers
-- '.' is any exacly one character, 3 characters followed by a dash followed by 4 characters
SELECT park_name, regexp_substr(description, '...-....')
  FROM park WHERE regexp_like(description, '...-....');

-- does the same thing using a quantifier
select park_name, regexp_substr(description, '.{3}-.{4}')
  from park where regexp_like(description, '.{3}-.{4}');

-- See false positives zoom in on false positives
SELECT regexp_substr(description, '...-....'), park_name
  FROM park WHERE regexp_like(description, '...-....')
  AND (park_name LIKE '%Mus%' OR park_name LIKE '%bofj%');
  
-- eliminate non digits
SELECT park_name, regexp_substr(description, '[0123456789]{3}-[0123456789]{4}')
  FROM park WHERE REGEXP_LIKE(description, '[0123456789]{3}-[0123456789]{4}');

-- using character class
SELECT park_name, regexp_substr(description, '[[:digit:]]{3}-[[:digit:]]{4}')
FROM park WHERE regexp_like(description, '[[:digit:]]{3}-[[:digit:]]{4}');

select * from park;
-- simpler version using a range of characters
-- replace the - with anything that is not a digit

-- escape character "\" if we want to find a period and not have the period
-- represent any character but instead a period
-- this finds phone numbers that have just a period separating the groups
  
-- this finds phone numbers that have periods, dashes, spaces separating the groups
-- using an OR symbol "|" (single pipe). Have to escape the . because its not in []

-- add area code
  
-- this is the area code with () or dashes or periods

-- international phone numbers often have very different formats beginning with a +
-- and groupings may be 1, 2, 3, or more and of varying sizes
-- subexpresssions show how quantifiers can be used in multiple places
select * from park;

/* -----------------------------------------------------------------------------
  Regular expressions and CHECK constraints - pp 659-661
------------------------------------------------------------------------------*/
-- page 659 bottom

-- =============================================================================
-- Bonus material
-- =============================================================================

select regexp_substr('But, soft! What light through yonder window breaks?', 
                      '[[:punct:]]', 1,1) string,
         regexp_instr('But, soft! What light through yonder window breaks?', 
                      '[[:punct:]]', 1,1) location from dual;

select regexp_substr('But, soft! What light through yonder window breaks?', 
                      '[[:alpha:]][[:blank:]]', 1,1) string,
         regexp_instr('But, soft! What light through yonder window breaks?', 
                      '[[:alpha:]][[:blank:]]', 1,1) location from dual;

select regexp_substr('But, soft! What light through yonder window breaks?', 
                      '[[:alpha:][:blank:]]', 1,1) string,
         regexp_instr('But, soft! What light through yonder window breaks?', 
                      '[[:alpha:][:blank:]]', 1,1) LOCATION FROM dual;

select regexp_substr('But, soft! What light through yonder window breaks?', 
                      '[[:alpha:]][[:space:]]', 1,1) string,
         regexp_instr('But, soft! What light through yonder window breaks?', 
                      '[[:alpha:]][[:space:]]', 1,1) location from dual;

select regexp_substr('But, soft! What light through yonder window breaks?', 
                      '[[:upper:]]', 1,2) string,
         regexp_instr('But, soft! What light through yonder window breaks?', 
                      '[[:upper:]]', 1,2) location from dual;

-- this is greedy
SELECT regexp_substr('she sells sea shells down by the seashore', 's[eashorl ]+e') FROM dual;

-- question 15
SELECT regexp_substr('please submit my order', '([please])$') FROM dual;
SELECT regexp_substr('be careful with that last one', '([please])$') FROM dual;

SELECT email FROM people
  WHERE REGEXP_LIKE(email,'^([[:alnum:]]+)@[[:alnum:]]+.(com|net|org|edu|gov|mil)$');

-- ------------------------------------------------
-- duplicate references
-- the ^ here is the begining of the line
-- not a character at the beginning but <bol>
SELECT park_name,
  regexp_substr(description, '(^|[[:space:][:punct:]]+)([[:alpha:]]+)'
  || '[[:space:][:punct:]]+\2'
  || '($|[[:space:][:punct:]]+)') double_words
FROM park
WHERE regexp_like(description, '(^|[[:space:][:punct:]]+)([[:alpha:]]+)'
  || '[[:space:][:punct:]]+\2'
  || '($|[[:space:][:punct:]]+)');


