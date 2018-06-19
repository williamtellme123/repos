-- =============================================================================
-- Chapter 17
/*

  REGULAR EXPRESSIONS are used throughout the IT industry
  by almost everyone.
  
  They are comprised of 
    FUNCTIONS: String functions each with a list of parameters
    METACHARACTERS: operators/character functions with specific behavior
    CHARACTER CLASSES: key word used instead of a long list of values

  USING METACHARACTERS
  
  REGULAR EXPRESSION FUNCTIONS
      regexp_substr (s1, pattern1, p1, n1, m1)
      regexp_instr (s1, pattern1, p1, n1, opt1, m1)
      regexp_replace (s1, pattern1, rep1, p1, o1, m1)
      regexp_like (s1, pattern1, m1)
      regexp_count(s1,pattern1)
  
  MATCH PARAMETERS (SEE M1 ABOVE)
  
      Value  Description
      ----------------------------------------------------------------------------
      ‘c’     Case-sensitive matching.
      ----------------------------------------------------------------------------
      ‘i’     Case-insensitive matching.
      ----------------------------------------------------------------------------
      ‘n’     Enables ‘.’ (period) character (regexpr operator Table 17.1 Line 7
             to match newline character. Otherwise, ‘.’ matches any character not treating 
             newline character as a character.
      ----------------------------------------------------------------------------
      ‘m’     Treat the source character string as multiple lines. Any
             occurrences of the anchor characters (^ and $) are assumed to be
             the start and end of lines within the string. Without it, the source
             character string is assumed to be one line of text.
      ----------------------------------------------------------------------------
      ‘x’     Ignores whitespace characters.
      ----------------------------------------------------------------------------

  REPLACING PATTERNS
      
  REGULAR EXPRESSIONS AND CHECK CONSTRAINTS
*/
-- =============================================================================
-- CHAPTER 17 STUDENTS SETUP
-- -----------------------------------------------------------------------------
-- 1. SETUP
--    a. Open the CHAPTER_17_STUDENTS_SETUP.sql
--    b. Open the connection to your schema
--    c. Follow instructions in file
-- ------------------------------------------------------------------------------------------------------------
-- 2. SIMPLE Examples to find parts of an address
-- ------------------------------------------------------------------------------------------------------------
-- a. Find pattern (one lowercase letter_ = true
select regexp_substr('123 Maple Avenue, Austin, TX 78729 (512) 311-4545','[a-z]',1,2) address from dual;
-- ------------------------------------------------------------------------------------------------------------
-- b. Find pattern (one digit) = true
select regexp_substr('123 Maple Avenue, Austin, TX 78729 (512) 311-4545','[0-9]',1,1) address from dual;
-- ------------------------------------------------------------------------------------------------------------
-- c. Find pattern (one lowercase or one uppercase letter) = true 
select regexp_substr('123 Maple Avenue, Austin, TX 78729 (512) 311-4545','[a-zA-Z]',1,1) address from dual;
-- ------------------------------------------------------------------------------------------------------------
-- d. Find pattern (one lowercase or one uppercase letter) = true {3 contiguous trues)     
select regexp_substr('123 Maple Avenue, Austin, TX 78729 (512) 311-4545','[a-zA-Z]{3}',1,1) address from dual;
-- ------------------------------------------------------------------------------------------------------------
-- e. Find pattern one(lowercase or uppercase or left or right parentesis) = true
select regexp_substr('123 Maple Avenue, Austin, TX 78729 (512) 311-4545','[0-9()]',1,1) address from dual;
-- ------------------------------------------------------------------------------------------------------------
-- f. Find pattern one(lowercase or uppercase or left or right parentesis) = true at least 4 times in a row
select regexp_substr('123 Maple Avenue, Austin, TX 78729 (512) 311-4545','[0-9()]{4,}',1,1) address from dual;
-- ------------------------------------------------------------------------------------------------------------
-- g. Find pattern one(lowercase or uppercase or left or right parentesis) = true at least 4 times in a row and not more than 14 times in a row
select regexp_substr('123 Maple Avenue, Austin, TX 78729 (512) 311-4545','[0-9()]{4,14}',1,1) address from dual;
-- ------------------------------------------------------------------------------------------------------------
-- h. Find pattern one(lowercase or uppercase or left or right parentesis) = true at least 4 times in a row and not more than 14 times in a row
select regexp_substr('123 Maple Avenue, Austin, TX 78729 (512) 311-4545','[0-9) -]{4,14}',1,1) address from dual;



-- ------------------------------------------------------------------------------------------------------------
-- 3. SIMPLE Examples to find confirm an email address is valid
-- ------------------------------------------------------------------------------------------------------------
-- a. Lets say we have the following rules
--    i. an email must come in three basic parts
--    ii.  Part One may have upper/lower letters, numbers. 
--    iii. Part One may also have but only one at time: periods and underscores 
--    iv.  The separator between Parts One and Two is an at (@) sign
--    v.   Part Two may only upper/lower letters/numbers
--    v.   Part three may only have the following values
--         com, net, org, edu, gov, mil, bib
-- ------------------------------------------------------------------------------------------------------------
-- b. Lets work on Part One
--      noah@cinema.org
--      mrs_rockets@literature.com
--      mr.campbell@sunshine.edu
--      noah123@cinema.org
--      mrs_rockets123_12@literature.com
--      mr.campbell_abc.123@sunshine.edu
-- ------------------------------------------------------------------------------------------------------------
--  c. Part one setup
select regexp_substr('noah@cinema.org','[a-z]',1,1) from dual;
select regexp_substr('mrs_rockets@literature.com','[a-z]',1,1) from dual;,
select regexp_substr('mr.campbell@sunshine.edu','[a-z]',1,1) from dual;
select regexp_substr('noah123@cinema.org','[a-z]',1,1) from dual;
select regexp_substr('mrs_rockets123_44@literature.com','[a-z]',1,1) from dual;
select regexp_substr('mr.campbell_abc.123@sunshine.edu','[a-z]',1,1) from dual;



-- ============================================================================================================
-- 4. Part One Using Ranges: Exercises to find confirm an email address is valid (copy and paste from 2.c above
-- ------------------------------------------------------------------------------------------------------------
-- a. Add something to match Part One as true using ranges
select regexp_substr('noah@cinema.org','',1,1) from dual;
-- ------------------------------------------------------------------------------------------------------------
-- b. Add something to match Part One as true using ranges
select regexp_substr('mrs_rockets@literature.com','',1,1) from dual;,
-- ------------------------------------------------------------------------------------------------------------
-- c. Add something to match Part One as true using ranges
select regexp_substr('mr.campbell@sunshine.edu','',1,1) from dual;
-- ------------------------------------------------------------------------------------------------------------
-- d. Add something to match Part One as true using ranges
select regexp_substr('noah123@cinema.org','',1,1) from dual;
-- ------------------------------------------------------------------------------------------------------------
-- e. Add something to match Part One as true using ranges
select regexp_substr('mrs_rockets123_44@literature.com','',1,1) from dual;
-- ------------------------------------------------------------------------------------------------------------
-- f. Add something to match Part One as true using ranges
select regexp_substr('mr.campbell_abc.123@sunshine.edu','',1,1) from dual;



-- ============================================================================================================
-- 5. Part One Using Character Classes: Exercises to find confirm an email address is valid (copy from 3)
-- ------------------------------------------------------------------------------------------------------------
-- a. Add something to match Part One as true using character classes 
select regexp_substr('noah@cinema.org','',1,1) from dual;
-- ------------------------------------------------------------------------------------------------------------
-- b. Add something to match Part One as true using character classes
select regexp_substr('mrs_rockets@literature.com','',1,1) from dual;,
-- ------------------------------------------------------------------------------------------------------------
-- c. Add something to match Part One as true using character classes
select regexp_substr('mr.campbell@sunshine.edu','',1,1) from dual;
-- ------------------------------------------------------------------------------------------------------------
-- d. Add something to match Part One as true using character classes
select regexp_substr('noah123@cinema.org','',1,1) from dual;
-- ------------------------------------------------------------------------------------------------------------
-- e. Add something to match Part One as true using character classes
select regexp_substr('mrs_rockets123_44@literature.com','',1,1) from dual;
-- ------------------------------------------------------------------------------------------------------------
-- f. Add something to match Part One as true using character classes
select regexp_substr('mr.campbell_abc.123@sunshine.edu','',1,1) from dual;



-- ============================================================================================================
-- 6. Exercises to find the separator of email is valid (copy from 3)
-- ------------------------------------------------------------------------------------------------------------
-- a. Add something to match separator as true
select regexp_substr('noah@cinema.org','',1,1) from dual;
-- ------------------------------------------------------------------------------------------------------------
-- b. Add something to match separator as true
select regexp_substr('mrs_rockets@literature.com','',1,1) from dual;
-- ------------------------------------------------------------------------------------------------------------
-- c. Add something to match separator as true
select regexp_substr('mr.campbell@sunshine.edu','',1,1) from dual;
-- ------------------------------------------------------------------------------------------------------------
-- d. Add something to match separator as true
select regexp_substr('noah123@cinema.org','',1,1) from dual;
-- ------------------------------------------------------------------------------------------------------------
-- e. Add something to match separator as true
select regexp_substr('mrs_rockets123_44@literature.com','',1,1) from dual;
-- ------------------------------------------------------------------------------------------------------------
-- f. Add something to match separator as true
select regexp_substr('mr.campbell_abc.123@sunshine.edu','',1,1) from dual;



-- ============================================================================================================
-- 7. Exercises to find Part Two is valid using ranges (copy from 3)
-- ------------------------------------------------------------------------------------------------------------
-- a. Add something to match Part Two as true using ranges
select regexp_substr('noah@cinema.org','',1,1) from dual;
-- ------------------------------------------------------------------------------------------------------------
-- b. Add something to match Part Two as true using ranges
select regexp_substr('mrs_rockets@literature.com','',1,1) from dual;
-- ------------------------------------------------------------------------------------------------------------
-- c. Add something to match Part Two as true using ranges
select regexp_substr('mr.campbell@sunshine.edu','',1,1) from dual;
-- ------------------------------------------------------------------------------------------------------------
-- d. Add something to match Part Two as true using ranges
select regexp_substr('noah123@cinema.org','',1,1) from dual;
-- ------------------------------------------------------------------------------------------------------------
-- e. Add something to match Part Two as true using ranges
select regexp_substr('mrs_rockets123_44@literature.com','',1,1) from dual;
-- ------------------------------------------------------------------------------------------------------------
-- f. Add something to match Part Two as true using ranges
select regexp_substr('mr.campbell_abc.123@sunshine.edu','',1,1) from dual;



-- ============================================================================================================
-- 8. Exercises to find Part Two is valid using character classes (copy from 4)
-- ------------------------------------------------------------------------------------------------------------
-- a. Add something to match Part Two as true using character classes
select regexp_substr('noah@cinema.org','',1,1) from dual;
-- ------------------------------------------------------------------------------------------------------------
-- b. Add something to match Part Two as true using character classes
select regexp_substr('mrs_rockets@literature.com','',1,1) from dual;
-- ------------------------------------------------------------------------------------------------------------
-- c. Add something to match Part Two as true using character classes
select regexp_substr('mr.campbell@sunshine.edu','',1,1) from dual;
-- ------------------------------------------------------------------------------------------------------------
-- d. Add something to match Part Two as true using character classes
select regexp_substr('noah123@cinema.org','',1,1) from dual;
-- ------------------------------------------------------------------------------------------------------------
-- e. Add something to match Part Two as true using character classes
select regexp_substr('mrs_rockets123_44@literature.com','',1,1) from dual;
-- ------------------------------------------------------------------------------------------------------------
-- f. Add something to match Part Two as true using character classes
select regexp_substr('mr.campbell_abc.123@sunshine.edu','',1,1) from dual;



-- ============================================================================================================
-- 9. Exercises to find Part Three is valid using character classes (copy from 7)
-- ------------------------------------------------------------------------------------------------------------
-- a. Add something to match Part Three as true using character classes
select regexp_substr('noah@cinema.org','',1,1) from dual;
-- ------------------------------------------------------------------------------------------------------------
-- b. Add something to match Part Three as true using character classes
select regexp_substr('mrs_rockets@literature.com','',1,1) from dual;,
-- ------------------------------------------------------------------------------------------------------------
-- c. Add something to match Part Three as true using character classes
select regexp_substr('mr.campbell@sunshine.edu','',1,1) from dual;
-- ------------------------------------------------------------------------------------------------------------
-- d. Add something to match Part Three as true using character classes
select regexp_substr('noah123@cinema.org','',1,1) from dual;
-- ------------------------------------------------------------------------------------------------------------
-- e. Add something to match Part Three as true using character classes
select regexp_substr('mrs_rockets123_44@literature.com','',1,1) from dual;
-- ------------------------------------------------------------------------------------------------------------
-- f. Add something to match Part Three as true using character classes
select regexp_substr('mr.campbell_abc.123@sunshine.edu','',1,1) from dual;


-- ============================================================================================================
-- 10. Some simple examples of escaping a meta character "." the period
-- ------------------------------------------------------------------------------------------------------------
-- a. escaping a metacharacter
select regexp_substr('A.B*c','[.]') from dual;
-- ------------------------------------------------------------------------------------------------------------
select regexp_substr('A.B^c','(.)') from dual;
-- ------------------------------------------------------------------------------------------------------------
select regexp_substr('A.B^c','\.') from dual;
-- ------------------------------------------------------------------------------------------------------------

-- ============================================================================================================
-- 11. REGEX_INSTR
-- ------------------------------------------------------------------------------------------------------------
-- a. return the location of "l" + 4 letters
-- ------------------------------------------------
select regexp_instr('But, soft! What light through yonder window breaks?' ,
                    'o[[:alpha:]]{1,2}', 1, 3) AS result,
       regexp_substr('But, soft! What light through yonder window breaks?' ,
                    'o[[:alpha:]]{1,2}', 1, 3) AS result
from dual;
-- ------------------------------------------------------------------------------------------------------------
-- b. return the location of the second "soft"
select regexp_instr('But, soft! What light through yonder window softly breaks?' , 's[[:alpha:]]{3}', 1, 2) AS result
from dual;
select regexp_instr('But, soft! What light through yonder window softly breaks?' , 's[[:punct:]]') AS result
from dual;
select regexp_instr('But, soft! What light through yonder window softly breaks?' , '[[:alpha:]]s') AS result
from dual;
select regexp_instr('But, soft! What light through yonder window softly breaks?' ,'[[:alpha:]]s{1,2}') AS result
from dual;
select regexp_instr('But, soft! What light through yonder window softly breaks?' ,'o',1,3,1,'i') AS result
from dual;
-- ------------------------------------------------------------------------------------------------------------
-- c. start at position 10 then return location of the second occurance of "o"
select 
regexp_substr ('But, soft! What light through yonder window breaks?' ,'o{1,}', 10, 2),
regexp_instr ('But, soft! What light through yonder window breaks?' ,'o', 10, 2) AS result
from dual;

-- ------------------------------------------------------------------------------------------------------------
-- d. replace the word "light" with "sound"
select regexp_replace('But, soft! What light through' ,'l[[:alpha:]]{4}', 'sound') AS result
from dual;

-- ============================================================================================================
-- 12. The company wants to rename some products in DIRECTORIES AND FILES
-- ------------------------------------------------
-- a. replace Telepresence with TelePresence
--    i. return location of "Tele"
select file_id, f8,
  regexp_instr(f8, 'Tele[[:alpha:]]+',1,1,0,'i') place
from files
where upper(f8) LIKE '%TELE%';
-- ------------------------------------------------------------------------------------------------------------
--    ii. replace
select *
from files;
-- replace Telepresence with TelePresence
select REGEXP_SUBSTR(F8, 'Tele[[:alpha:]]+',1,1,'i'),
  REGEXP_replace(F8, 'Tele[[:alpha:]]+','TelePresencePro'),
  f8
from FILES
where UPPER(F8) LIKE '%TELE%';
-- ------------------------------------------------------------------------------------------------------------
-- b. Replace "UCS" with "UCS-"
--    i. return location of "UCS"
select file_id,
  f8,
  regexp_instr(f8, 'UC[[:alpha:]]*',1,1,0,'i')
from files
where upper(f8) LIKE '%UCS%';
-- ------------------------------------------------------------------------------------------------------------
--    ii. Replace "UCS" with "UCS-"
select regexp_substr(f8, 'UC[[:alpha:]]+',1,1,'i'),
  regexp_replace(f8, 'UCS[[:alpha:] ]','UCS-'),
  f8
from files
where upper(f8) LIKE '%UCS%';-- ------------------------------------------------------------------------------------------------------------

-- ============================================================================================================
-- 13. WORKING WITH DATES
-- ------------------------------------------------------------------------------------------------------------
-- A. Find records that have invoice dates between 2010 and 2011
select invoice_id,invoice_date,  regexp_substr(TO_CHAR(invoice_date,'YYYY'),'^201[0-1]$')
from invoices_revised
where regexp_like (TO_CHAR(INVOICE_DATE,'YYYY'),'^201[0-1]$');
-- ------------------------------------------------------------------------------------------------------------

select regexp_substr(TO_CHAR(invoice_date,'YYYY'),'^2[0-9]{2}1$') ,to_char(sum(invoice_amt),'$9,999,999,999')
from invoices_revised
where regexp_like (TO_CHAR(INVOICE_DATE,'YYYY'),'^2[0-9]{2}1$')
 group by regexp_substr(TO_CHAR(invoice_date,'YYYY'),'^2[0-9]{2}1$');
-- ------------------------------------------------------------------------------------------------------------
select count(invoice_id),
  -- invoice_date,
  TO_CHAR(invoice_date,'YYYY'),
  regexp_substr(TO_CHAR(invoice_date,'YYYY'),'^201[0-1]$')
from invoices_revised
where regexp_like (TO_CHAR(INVOICE_DATE,'YYYY'),'^201[0-1]$')
group by TO_CHAR(invoice_date,'YYYY'),
  regexp_substr(TO_CHAR(invoice_date,'YYYY'),'^201[0-1]$');

-- ------------------------------------------------------------------------------------------------------------
select invoice_id,
  invoice_date,
  TO_CHAR(invoice_date,'YYYY'),
  regexp_substr (TO_CHAR(INVOICE_DATE,'YYYY'), '^20[0-1]|(09)$')
from invoices_revised
where regexp_like (TO_CHAR(INVOICE_DATE,'YYYY'), '^20[0-1]|(09)$');
-- ------------------------------------------------------------------------------------------------------------
select invoice_id,
  invoice_date,
  TO_CHAR(invoice_date,'YYYY'),
  regexp_substr (TO_CHAR(INVOICE_DATE,'YYYY'), '^20([0-1]+|09)$')
from invoices_revised
where regexp_like (TO_CHAR(INVOICE_DATE,'YYYY'), '^20([0-1]+|09)$');
-- ------------------------------------------------------------------------------------------------------------
select invoice_id,
  invoice_date,
  TO_CHAR(invoice_date,'YYYY')
from invoices_revised
where regexp_like (TO_CHAR(INVOICE_DATE,'YYYY'), '^20(10)|(11)|(09)$');
-- ------------------------------------------------------------------------------------------------------------
select invoice_id,
  invoice_date,
  TO_CHAR(invoice_date,'YYYY')
from invoices_revised
where regexp_like (TO_CHAR(INVOICE_DATE,'YYYY'), '^20(1[0-1])|(09)$');
-- ------------------------------------------------------------------------------------------------------------
select invoice_id,
  invoice_date,
  TO_CHAR(invoice_date,'YYYY')
from invoices_revised
where regexp_like (TO_CHAR(invoice_date,'YYYY'), '^20(1[0-1])|(09)$')
AND invoice_id = 1120;
-- ------------------------------------------------------------------------------------------------------------
update invoices_revised
set invoice_date = '08-NOV-09'
where invoice_id = 1120;
commit;
