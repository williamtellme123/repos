-- =============================================================================
-- Chapter 17
/*

  REGULAR EXPRESSIONS are very common
  
  They are comprised of 
    FUNCTIONS: String functions each with a list of parameters
    METACHARACTERS: operators/character functions with specific behavior
    CHARACTER CLASSES: key word used instead of a long list of values

  USING METACHARACTERS
    Think of the "+" sign
        Math Function
        In Regex it means find 1 or more insances of a string
  
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
-- 0. SETUP
--    a. Open the CHAPTER_17_STUDENTS_SETUP.sql
--    b. Open the connection to your schema
--    c. Follow instructions in file
-- ------------------------------------------------------------------------------------------------------------
-- 1. REVIEW
-- ------------------------------------------------------------------------------------------------------------
-- 
-- The where clause
    select 
          firstname
        , lastname 
    from customers 
    where lastname = 'MORALES';

-- The select clause literals
    select 'CustomerName =>'
          , firstname
          , lastname 
    from customers 
    where lastname = 'MORALES';

-- The select clause math
    select (2+3*4)/(2+3+2)
          , firstname
          , lastname 
    from customers 
    where lastname = 'MORALES';

-- The Simple Math, or testing functions can be done with dual;
    select (2+3*4)/(2+3+2)
          , sysdate
          , initcap('hello pumpkin')
          --  Syntax: INSTR(s1, s2, pos(optional) , n(optional))
          , instr('pumpkin bread, pumpkin pie, pumpkin yogart', 'pum',1,2) as ins
          -- Syntax: SUBSTR(s, pos, len)
          , substr('pumpkin bread, pumpkin pie, pumpkin yogart', 5,3) as subs
    from dual;

-- The select clause expressions : case (shows us what where is doing)
    select case when lastname = 'MORALES' then 'T' else 'F' end as SameAsWhereTest
          , firstname
          , lastname 
    from customers 
    where lastname = 'MORALES';

-- The select clause expressions : case
    select case when instr(lastname, 'MORALE') >= 1 then 'Morale Found' else 'Morale Not Found' end as caseTest
          , firstname
          , lastname 
    from customers 
    where instr(lastname, 'MORALE') >= 1;


-- ------------------------------------------------------------------------------------------------------------
-- 2. REGEXP_INSTR                :  Returns a number where found
-- ------------------------------------------------------------------------------------------------------------
-- a. Find location where the pattern is found in the string
--    REGEXP_INSTR (s1, pattern1, p1, n1, opt1, m1)
--        s1          character string. Required.
--        pattern1    regular expression. Required.
      select regexp_instr('A B C b D b E B','B') as address from dual;
--        p1          start position. Optional. Defaults to 1.
      select regexp_instr('A B C b D b E B','B',3) as address from dual;
--        n1          for mulktiple occurances possible. Optional. Defaults to 1.
      select regexp_instr('A B C b D b E B','B',1,2 ) as address from dual;
--        opt1        returned is either 0 or 1. Optional. Defaults to 0.
      select regexp_instr('A B C b D b E B','B',1,2,0) as address from dual;
      select regexp_instr('A B C b D b E B','B',1,2,1) as address from dual;
--        m1          one or more of the matching parameters Table 17-5. Optional.
      select regexp_instr('A B C b D b E B','b',1,2,1,'i') as address from dual;
-- -----------------------------------------------------------------------------
-- b. Find location of string (also called pattern, in this case a single letter) 
     select regexp_instr('S 123 Main Street Drain No. 101','S',1,1) as address from dual;
--   --------------     
     select regexp_instr('S 123 Main Street Drain No. 101','S',3,1) as address from dual; 
-- -----------------------------------------------------------------------------
-- c. Find location of either string '10' or string 'S' at different starting position
      select regexp_instr('S 10 Main Street Drain No. 101','10|S',1,1) as address from dual;
      --   --------------  
      select regexp_instr('S 10 Main Street Drain No. 101','10|S',2,1) as address from dual;
-- -----------------------------------------------------------------------------
-- d. Find location of any of several characters
      select regexp_instr('S 10 Main Street Drain No. 101','N|S|M',4,1) as address from dual;
      
-- -----------------------------------------------------------------------------      
-- Exercise:
-- Write a select statement that returns the position of the 2nd "lu" in Honolulu


-- -----------------------------------------------------------------------------
-- e. Remember the IN clause in Where contained a matching list?
--    Remember Where IN
      select state
          , firstname
          , lastname 
      from customers 
      where state in ('FL', 'TX', 'NJ');
 -- -----------------------------------------------------------------------------    
-- f. Our first regex operator [] also contains a matching list : Line 2  Table 17-1
      select regexp_instr('S 10 Main Street Drain No. 101','[aNM]',1,1) as address from dual;
-- -----------------------------------------------------------------------------
-- g. What about the spaces
      select regexp_instr('S 10 Main Street Drain No. 101','[ aNM]',1,1) as address from dual;
-- -----------------------------------------------------------------------------
-- h. What if we wanted to find about the spaces
      select regexp_instr('S 10 Main Street Drain No. 101','[ aNM]',1,1) as address from dual;
-- -----------------------------------------------------------------------------
-- i. What if we wanted to find a longer string but forgot the brackets
      select regexp_instr('123 Maple Avenue, Austin, TX 78729 (512) 311-4545','apple',1,1) as address from dual;
-- -----------------------------------------------------------------------------
--  j. OK we fixed that by adding brackets. Now lets add {quantity} : Line 11 
      select regexp_instr('123 Maple Avenue, Austin, TX 78729 (512) 311-4545','[apple]{3}',1,1) as address from dual;
      
      select regexp_instr('123 Maple Avenue, Austin, TX 78729 (512) 311-4545','[apple]{3}',1,1) as address from dual;      
-- -----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------------------
-- 3. REGEXP_SUBSTR              :  Returns string found
-- ------------------------------------------------------------------------------------------------------------ 
-- a. Find and return the string where the pattern is found in the string
--    REGEXP_SUBSTR(s1, pattern1, p1, n1, m1)
--        s1              character/string. Required.
--        pattern1        regular expression. Required.
--        p1              StartPosition Optional. Defaults to 1.
      select    regexp_substr('123 Maple Apple','[apple]',1) as address1 
      from dual;
-- -----------------------------------------------------------------------------
--    STUDENT EXERCISE
--    Which 'a' is brought back? 
      select    regexp_substr('123 Maple Apple','[apple]',1) as address1 
      from dual;
-- -----------------------------------------------------------------------------
--    STUDENT EXERCISE
--        n1                Numeric. Optional. Defaults to 1.
      select regexp_substr('123 Maple Apple','[apple]',1,2) as address1
      from dual;
-- -----------------------------------------------------------------------------
--    STUDENT EXERCISE
--        m1          one or more of the matching parameters Table 17-5. Optional.
-- -----------------------------------------------------------------------------
-- CLASS EXERCISE
--    The "+" sign means quantity os 1 or more matches      :     Line 10 
--    What is the difference between the patterns '[apple]' vs '(apple)'  vs 'apple'
      select 
            regexp_substr('123 Maple Apple','[apple]+',1,1,'i') as address1 
          , regexp_instr('123 Maple Apple','[apple]+',1,1,0,'i') as address2 
      from dual;
--  Change [apple] to (apple)  
      select 
            regexp_substr('123 Maple Apple','[apple]+',1,1,'i') as address1 
          , regexp_instr('123 Maple Apple','[apple]+',1,1,0,'i') as address2 
      from dual;
--  Change [apple] to apple 
      select 
            regexp_substr('123 Maple Apple','[apple]+',1,1,'i') as address1 
          , regexp_instr('123 Maple Apple','[apple]+',1,1,0,'i') as address2 
      from dual;
-- ------------------------------------------------------------------------------------------------------------
-- b. Find same pattern using : matching set, or range, or Character Class 
      select regexp_substr('123 Maple Avenue, Austin, TX 78729 (512) 311-4545','[0123456789]{3}',1,2) as address1 
      from dual;
--  Change [0123456789] to [0-9]              : Table 17-3
      select regexp_substr('123 Maple Avenue, Austin, TX 78729 (512) 311-4545','[0123456789]{3}',1,2) as address1 
      from dual;
--  Change [0123456789] to [:DIGIT:]          : Table 17-2
      select regexp_substr('123 Maple Avenue, Austin, TX 78729 (512) 311-4545','[:DIGIT:]{3}',1,2) as address1 
      from dual;
-- ------------------------------------------------------------------------------------------------------------
-- c. Find using : quantities        : Line 10     {this means contiguous trues)
      select regexp_substr('123 Maple Avenue, Austin, TX 78729 (512) 311-4545','[a-zA-Z]+',1,3) as address1 
      from dual;
--    Find using : quantities        : Line 11
      select regexp_substr('123 Maple Avenue, Austin, TX 78729 (512) 311-4545','[a-zA-Z]{3}',1,1) as address1 
      from dual;
--    Find using : quantities        : Line 12      
      select regexp_substr('123 Maple Avenue, Austin, TX 78729 (512) 311-4545','[a-zA-Z]{3,}',1,1) as address1 
      from dual;
--    Find using : quantities        : Line 13      
      select regexp_substr('123 Maple Avenue, Austin, TX 78729 (512) 311-4545','[a-zA-Z]{3,8}',1,1) as address1 
      from dual;
--    Find using : quantities        : Line 13      (Add a space and run again
      select regexp_substr('123 Maple Avenue, Austin, TX 78729 (512) 311-4545','[a-zA-Z]{3,8}',1,1) as address1 
      from dual;
-- ------------------------------------------------------------------------------------------------------------
-- d. Find pattern (one lowercase or one uppercase letter) = true {3 contiguous trues)     
    select regexp_substr('123 Maple Avenue, Austin, TX 78729 (512) 311-4545','[a-zA-Z]{3}',1,3) as address1 
    from dual;
-- ------------------------------------------------------------------------------------------------------------
-- e. Find pattern one(lowercase or uppercase or left or right parentesis) = true
    select regexp_substr('123 Maple Avenue, Austin, TX 78729 (512) 311-4545','[0-9()]',1,7) as address1 
    from dual;
-- ------------------------------------------------------------------------------------------------------------
-- f. Find pattern one(lowercase or uppercase or left or right parentesis) = true at least 4 times in a row
      select regexp_substr('123 Maple Avenue, Austin, TX 78729 (512) 311-4545','[0-9() -]{4,}',1,2) 
      address from dual;
-- ------------------------------------------------------------------------------------------------------------
-- g. Find pattern one(lowercase or uppercase or left or right parentesis) = true at least 4 times in a row and not more than 14 times in a row
select regexp_substr('123 Maple Avenue, Austin, TX 78729 (512) 311-4545','[0-9( )-]{7,}',1,1) as address from dual;

-- ------------------------------------------------------------------------------------------------------------
-- h. Find pattern one(lowercase or uppercase or left or right parentesis) = true at least 4 times in a row and not more than 14 times in a row
select regexp_substr('123 Maple Avenue, Austin, TX 78729 (512) 311-4545','[0-9 ()-]{14}$',1,1) 
address from dual;


-- ------------------------------------------------------------------------------------------------------------
-- 2. SIMPLE Examples to find confirm an email address is valid
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
select regexp_substr('mrs_rockets@literature.com','[a-z]',1,1) from dual;
select regexp_substr('mr.campbell@sunshine.edu','[a-z]',1,1) from dual;
select regexp_substr('noah123@cinema.org','[a-z]',1,1) from dual;
select regexp_substr('mrs_rockets123_44@literature.com','[a-z]',1,1) from dual;
select regexp_substr('mr.campbell_abc.123@sunshine.edu','[a-z]',1,1) from dual;



-- ============================================================================================================
-- 4. Part One Using Ranges: Exercises to find confirm an email address is valid (copy and paste from 2.c above
-- ------------------------------------------------------------------------------------------------------------
-- a. Add something to match Part One as true using ranges
select regexp_substr('noah@cinema.org','[a-zA-Z]+',1,1) from dual;
-- b. Add something to match Part One as true
select regexp_substr('mrs_rockets@literature.com','[a-zA-Z_]+',1,1) from dual;
-- c. Add something to match Part One as true
select regexp_substr('mr.campbell@sunshine.edu','[a-zA-Z_.]+',1,1) from dual;
-- d. Add something to match Part One as true
select regexp_substr('noah123@cinema.org','[a-zA-Z_.0-9]+',1,1) from dual;
-- e. Add something to match Part One as true
select regexp_substr('mrs_rockets123_44@literature.com','[a-zA-Z_.0-9]+',1,1) from dual;
-- f. Add something to match Part One as true
select regexp_substr('mr.campbell_abc.123@sunshine.edu','[a-zA-Z_.0-9]+',1,1) from dual;



-- ============================================================================================================
-- 5. Part One Using Character classes: Exercises to find confirm an email address is valid (copy and paste from 4 above
-- ------------------------------------------------------------------------------------------------------------
-- a. Add something to match Part One as true using character classes
select regexp_substr('noah@cinema.org','[[:alpha:]]+',1,1) from dual;
-- b. Add something to match Part One as true using character classes
select regexp_substr('mrs_rockets@literature.com','[[:alpha:]_]+',1,1) from dual;
-- c. Add something to match Part One as true using character classes
select regexp_substr('mr.campbell@sunshine.edu','[[:alpha:]_.]+',1,1) from dual;
-- d. Add something to match Part One as true using character classes
select regexp_substr('noah123@cinema.org','[[:alnum:]]+',1,1) from dual;
-- e. Add something to match Part One as true using character classes
select regexp_substr('mrs_rockets123_44@literature.com','[[:alnum:]_.]+',1,1) from dual;
-- f. Add something to match Part One as true using character classes
select regexp_substr('mr.campbell_abc.123@sunshine.edu','[[:alnum:]_.]+',1,1) from dual;


-- ============================================================================================================
-- 6. Part One plus @ using Ranges: Exercises to find confirm an email address is valid (copy and paste from 4 above
-- ------------------------------------------------------------------------------------------------------------
-- a. Add something to match Part One as true using ranges
select regexp_substr('noah@cinema.org','[a-zA-Z]+@',1,1) from dual;
-- b. Add something to match Part One as true
select regexp_substr('mrs_rockets@literature.com','[a-zA-Z_]+@',1,1) from dual;
-- c. Add something to match Part One as true
select regexp_substr('mr.campbell@sunshine.edu','[a-zA-Z_.]+@',1,1) from dual;
-- d. Add something to match Part One as true
select regexp_substr('noah123@cinema.org','[a-zA-Z_.0-9]+@',1,1) from dual;
-- e. Add something to match Part One as true
select regexp_substr('mrs_rockets123_44@literature.com','[a-zA-Z_.0-9]+@',1,1) from dual;
-- f. Add something to match Part One as true
select regexp_substr('mr.campbell_abc.123@sunshine.edu','[a-zA-Z_.0-9]+@',1,1) from dual;

-- ============================================================================================================
-- 7. Part two using Ranges: Exercises to find confirm an email address is valid (copy and paste from 4 above
-- ------------------------------------------------------------------------------------------------------------
-- a. Add something to match Part Two as true using ranges
select regexp_substr('noah@cinema.org','[a-zA-Z]+@[a-zA-Z0-9]+',1,1) from dual;
-- b. Add something to match Part One as true
select regexp_substr('mrs_rockets@literature.com','[a-zA-Z_]+@[0-9a-zA-Z]+',1,1) from dual;
-- c. Add something to match Part One as true
select regexp_substr('mr.campbell@sunshine.edu','[a-zA-Z_.]+@[a-zA-Z0-9]+',1,1) from dual;
-- d. Add something to match Part One as true
select regexp_substr('noah123@cinema.org','[a-zA-Z_.0-9]+@[a-zA-Z0-9]+',1,1) from dual;
-- e. Add something to match Part One as true
select regexp_substr('mrs_rockets123_44@literature.com','[a-zA-Z_.0-9]+@[a-zA-Z0-9]+',1,1) from dual;
-- f. Add something to match Part One as true
select regexp_substr('mr.campbell_abc.123@sunshine.edu','[a-zA-Z_.0-9]+@[a-zA-Z0-9]+',1,1) from dual;

-- ============================================================================================================
-- 8. Part Two  using character classes: Exercises to find confirm an email address is valid (copy and paste from 4 above
-- ------------------------------------------------------------------------------------------------------------
-- a. Add something to match Part One as true using character classes
select regexp_substr('noah@cinema.org','[[:alpha:]]+@[[:alnum:]]+',1,1) from dual;
-- b. Add something to match Part One as true using character classes
select regexp_substr('mrs_rockets@literature.com','[[:alpha:]_]+@[[:alnum:]]+',1,1) from dual;
-- c. Add something to match Part One as true using character classes
select regexp_substr('mr.campbell@sunshine.edu','[[:alpha:]_.]+@[[:alnum:]]+',1,1) from dual;
-- d. Add something to match Part One as true using character classes
select regexp_substr('noah123@cinema.org','[[:alnum:]_.]+@[[:alnum:]]+',1,1) from dual;
-- e. Add something to match Part One as true using character classes
select regexp_substr('mrs_rockets123_44@literature.com','[[:alnum:]_.]+@[[:alnum:]]+',1,1) from dual;
-- f. Add something to match Part One as true using character classes
select regexp_substr('mr.campbell_abc.123@sunshine.edu','[[:alnum:]_.]+@[[:alnum:]]+',1,1) from dual;

-- ============================================================================================================
-- 9. Part Three using Ranges: Exercises to find confirm an email address is valid (copy and paste from 4 above
-- ------------------------------------------------------------------------------------------------------------
-- a. Add something to match Part Two as true using ranges
select regexp_substr('noah@cinema.org','[a-zA-Z]+@[a-zA-Z0-9]+.(org|com|net|edu|gov|mil)',1,1) from dual;
-- b. Add something to match Part One as true
select regexp_substr('mrs_rockets@literature.com','[a-zA-Z_]+@[0-9a-zA-Z]+.(org|com|net|edu|gov|mil)',1,1) from dual;
-- c. Add something to match Part One as true
select regexp_substr('mr.campbell@sunshine.edu','[a-zA-Z_.]+@[a-zA-Z0-9]+.(org|com|net|edu|gov|mil)',1,1) from dual;
-- d. Add something to match Part One as true
select regexp_substr('noah123@cinema.org','[a-zA-Z_.0-9]+@[a-zA-Z0-9]+.(org|com|net|edu|gov|mil)',1,1) from dual;
-- e. Add something to match Part One as true
select regexp_substr('mrs_rockets123_44@literature.com','[a-zA-Z_.0-9]+@[a-zA-Z0-9]+.(org|com|net|edu|gov|mil)',1,1) from dual;
-- f. Add something to match Part One as true
select regexp_substr('mr.campbell_abc.123@sunshine.edu','[a-zA-Z_.0-9]+@[a-zA-Z0-9]+.(org|com|net|edu|gov|mil)',1,1) from dual;


-- ============================================================================================================
-- 10. Part Two  using character classes: Exercises to find confirm an email address is valid (copy and paste from 4 above
-- ------------------------------------------------------------------------------------------------------------
-- a. Add something to match Part One as true using character classes
select regexp_substr('noah@cinema.org','[[:alpha:]]+@[[:alnum:]]+.(org|com|net|edu|gov|mil)',1,1) from dual;
-- b. Add something to match Part One as true using character classes
select regexp_substr('mrs_rockets@literature.com','[[:alpha:]_]+@[[:alnum:]]+.(org|com|net|edu|gov|mil)',1,1) from dual;
-- c. Add something to match Part One as true using character classes
select regexp_substr('mr.campbell@sunshine.edu','[[:alpha:]_.]+@[[:alnum:]]+.(org|com|net|edu|gov|mil)',1,1) from dual;
-- d. Add something to match Part One as true using character classes
select regexp_substr('noah123@cinema.org','[[:alnum:]_.]+@[[:alnum:]]+.(org|com|net|edu|gov|mil)',1,1) from dual;
-- e. Add something to match Part One as true using character classes
select regexp_substr('mrs_rockets123_44@literature.com','[[:alnum:]_.]+@[[:alnum:]]+.(org|com|net|edu|gov|mil)',1,1) from dual;
-- f. Add something to match Part One as true using character classes
select regexp_substr('mr.campbell_abc.123@sunshine.edu','[[:alnum:]_.]+@[[:alnum:]]+',1,1) from dual;



-- ============================================================================================================
-- 4. Part One Using Character Classes: Exercises to find confirm an email address is valid (copy from 3)
-- ------------------------------------------------------------------------------------------------------------
-- a. Add something to match Part One as true
select regexp_substr('noah@cinema.org','[[:alpha:]]+(@)',1,1) from dual;
-- ------------------------------------------------------------------------------------------------------------
-- b. Add something to match Part One as true
select regexp_substr('mrs_rockets@literature.com','[[:alpha:]_]+',1,1) from dual;,
-- ------------------------------------------------------------------------------------------------------------
-- c. Add something to match Part One as true
select regexp_substr('mr.campbell@sunshine.edu','[[:alpha:].]+',1,1) from dual;
-- ------------------------------------------------------------------------------------------------------------
-- d. Add something to match Part One as true
select regexp_substr('noah123@cinema.org','[[:alnum:]_]+',1,1) from dual;
-- ------------------------------------------------------------------------------------------------------------
-- e. Add something to match Part One as true
select regexp_substr('mrs_rockets123_44@literature.com','[[:alnum:]_]+',1,1) from dual;
-- ------------------------------------------------------------------------------------------------------------
-- f. Add something to match Part One as true
select regexp_substr('mr.campbell_abc.123@sunshine.edu','[[:alnum:]_]+',1,1) from dual;



-- ============================================================================================================
-- 5. Exercises to find the separator of email is valid (copy from 3)
-- ------------------------------------------------------------------------------------------------------------
-- a. Add something to match separator as true
select regexp_substr('noah@cinema.org','[a-z]+(@)',1,1) from dual;
-- ------------------------------------------------------------------------------------------------------------
-- b. Add something to match separator as true
select regexp_substr('mrs_rockets@literature.com','[a-z_]+@',1,1) from dual;,
-- ------------------------------------------------------------------------------------------------------------
-- c. Add something to match separator as true
select regexp_substr('mr.campbell@sunshine.edu','[a-z_.]+@',1,1) from dual;
-- ------------------------------------------------------------------------------------------------------------
-- d. Add something to match separator as true
select regexp_substr('noah123@cinema.org','[a-z0-9]+@',1,1) from dual;
-- ------------------------------------------------------------------------------------------------------------
-- e. Add something to match separator as true
select regexp_substr('mrs_rockets123_44@literature.com','[a-z0-9_]+@',1,1) from dual;
-- ------------------------------------------------------------------------------------------------------------
-- f. Add something to match separator as true
select regexp_substr('mr.campbell_abc.123@sunshine.edu','[a-z0-9_.]+@',1,1) from dual;



-- ============================================================================================================
-- 6. Exercises to find Part Two is valid using ranges (copy from 3)
-- ------------------------------------------------------------------------------------------------------------
-- a. Add something to match Part Two as true
select regexp_substr('noah@cinema.org','[a-z]+(@)[a-z0-9_.]+',1,1) from dual;
-- ------------------------------------------------------------------------------------------------------------
-- b. Add something to match Part Two as true
select regexp_substr('mrs_rockets@literature.com','[a-z_]+@[a-z0-9]+',1,1) from dual;,
-- ------------------------------------------------------------------------------------------------------------
-- c. Add something to match Part Two as true
select regexp_substr('mr.campbell@sunshine.edu','[a-z_.]+@[a-z0-9]+',1,1) from dual;
-- ------------------------------------------------------------------------------------------------------------
-- d. Add something to match Part Two as true
select regexp_substr('noah123@cinema.org','[a-z0-9]+@[a-z0-9]+',1,1) from dual;
-- ------------------------------------------------------------------------------------------------------------
-- e. Add something to match Part Two as true
select regexp_substr('mrs_rockets123_44@literature.com','[a-z0-9_]+@[a-z0-9]+',1,1) from dual;
-- ------------------------------------------------------------------------------------------------------------
-- f. Add something to match Part Two as true
select regexp_substr('mr.campbell_abc.123@sunshine.edu','[a-z0-9_.]+@[a-z0-9]+',1,1) from dual;



-- ============================================================================================================
-- 7. Exercises to find Part Two is valid using character classes (copy from 4)
-- ------------------------------------------------------------------------------------------------------------
-- a. Add something to match Part One as true
select regexp_substr('noah@cinema.org','[[:alpha:]]+(@)[[:alpha:]]+',1,1) from dual;
-- ------------------------------------------------------------------------------------------------------------
-- b. Add something to match Part One as true
select regexp_substr('mrs_rockets@literature.com','[[:alpha:]_]+@[[:alpha:]]+',1,1) from dual;,
-- ------------------------------------------------------------------------------------------------------------
-- c. Add something to match Part One as true
select regexp_substr('mr.campbell@sunshine.edu','[[:alpha:].]+@[[:alpha:]]+',1,1) from dual;
-- ------------------------------------------------------------------------------------------------------------
-- d. Add something to match Part One as true
select regexp_substr('noah123@cinema.org','[[:alnum:]_]+@[[:alpha:]]+',1,1) from dual;
-- ------------------------------------------------------------------------------------------------------------
-- e. Add something to match Part One as true
select regexp_substr('mrs_rockets123_44@literature.com','[[:alnum:]_.]+@[[:alpha:]]+',1,1) from dual;
-- ------------------------------------------------------------------------------------------------------------
-- f. Add something to match Part One as true
select regexp_substr('mr.campbell_abc.123@sunshine.edu','[[:alnum:]_.]+@[[:alnum:]]+',1,1) from dual;



-- ============================================================================================================
-- 8. Exercises to find Part three is valid using ranges (copy from 6)
-- ------------------------------------------------------------------------------------------------------------
-- a. Add something to match Part Two as true
select regexp_substr('noah@cinema.org','[a-z]+(@)[a-z]+',1,1) from dual;
-- ------------------------------------------------------------------------------------------------------------
-- b. Add something to match Part Two as true
select regexp_substr('mrs_rockets@literature.com','[a-z_]+@[a-z0-9]+',1,1) from dual;,
-- ------------------------------------------------------------------------------------------------------------
-- c. Add something to match Part Two as true
select regexp_substr('mr.campbell@sunshine.edu','[a-z_.]+@[a-z0-9]+',1,1) from dual;
-- ------------------------------------------------------------------------------------------------------------
-- d. Add something to match Part Two as true
select regexp_substr('noah123@cinema.org','[a-z0-9]+@[a-z0-9]+',1,1) from dual;
-- ------------------------------------------------------------------------------------------------------------
-- e. Add something to match Part Two as true
select regexp_substr('mrs_rockets123_44@literature.com','[a-z0-9_]+@[a-z0-9]+',1,1) from dual;
-- ------------------------------------------------------------------------------------------------------------
-- f. Add something to match Part Two as true
select regexp_substr('mr.campbell_abc.123@sunshine.edu','[a-z0-9_.]+@[a-z0-9]+',1,1) from dual;



-- ============================================================================================================
-- 9. Exercises to find Part Three is valid using character classes (copy from 8)
-- ------------------------------------------------------------------------------------------------------------
-- a. Add something to match Part One as true
select regexp_substr('noah@cinema.org','[[:alpha:]]+(@)[[:alpha:]]+.(com|net|org|edu|gov|mil)',1,1) from dual;
-- ------------------------------------------------------------------------------------------------------------
-- b. Add something to match Part One as true
select regexp_substr('mrs_rockets@literature.com','[[:alpha:]_]+@[[:alpha:]]+.(com|net|org|edu|gov|mil)',1,1) from dual;
-- ------------------------------------------------------------------------------------------------------------
-- c. Add something to match Part One as true
select regexp_substr('mr.campbell@sunshine.edu','[[:alpha:].]+@[[:alpha:]]+.(com|net|org|edu|gov|mil)',1,1) from dual;
-- ------------------------------------------------------------------------------------------------------------
-- d. Add something to match Part One as true
select regexp_substr('noah123@cinema.org','[[:alnum:]_]+@[[:alpha:]]+.(com|net|org|edu|gov|mil)',1,1) from dual;
-- ------------------------------------------------------------------------------------------------------------
-- e. Add something to match Part One as true
select regexp_substr('mrs_rockets123_44@literature.com','[[:alnum:]_.]+@[[:alpha:]]+.(com|net|org|edu|gov|mil)',1,1) from dual;
-- ------------------------------------------------------------------------------------------------------------
-- f. Add something to match Part One as true
select regexp_substr('mr.campbell_abc.123@sunshine.edu','[[:alnum:]_.]+@[[:alnum:]]+.(com|net|org|edu|gov|mil)',1,1) from dual;



-- ============================================================================================================
-- 10. Exercises to find Part Three is valid using character classes (copy from 9)
-- ------------------------------------------------------------------------------------------------------------
-- a. Add something to match Part One as true
select regexp_substr('noah@cinema.org','^[[:alpha:]]+(@)[[:alpha:]]+.(com|net|org|edu|gov|mil)',1,1) from dual;
-- ------------------------------------------------------------------------------------------------------------
-- b. Add something to match Part One as true
select regexp_substr('mrs_rockets@literature.com','^[[:alpha:]_]+@[[:alpha:]]+.(com|net|org|edu|gov|mil)',1,1) from dual;
-- ------------------------------------------------------------------------------------------------------------
-- c. Add something to match Part One as true
select regexp_substr('mr.campbell@sunshine.edu','^[[:alpha:].]+@[[:alpha:]]+$.(com|net|org|edu|gov|mil)',1,1) from dual;
-- ------------------------------------------------------------------------------------------------------------
-- d. Add something to match Part One as true
select regexp_substr('noah123@cinema.org','^[[:alnum:]_]+@[[:alpha:]]+$.(com|net|org|edu|gov|mil)',1,1) from dual;
-- ------------------------------------------------------------------------------------------------------------
-- e. Add something to match Part One as true
select regexp_substr('mrs_rockets123_44@literature.com','^[[:alnum:]_.]+@[[:alpha:]]+.(com|net|org|edu|gov|mil)',1,1) from dual;
-- ------------------------------------------------------------------------------------------------------------
-- f. Add something to match Part One as true
select regexp_substr('mr.campbell_abc.123@sunshine.edu','^[[:alnum:]_.]+@[[:alnum:]]+.(com|net|org|edu|gov|mil)$',1,1) from dual;



 

-- ============================================================================================================
-- 11. Some simple examples of escaping a meta character "." the period
-- ------------------------------------------------------------------------------------------------------------
-- a. escaping a metacharacter
select regexp_substr('A.B*c','[.]') from dual;
-- ------------------------------------------------------------------------------------------------------------
select regexp_substr('A.B^c','(.)',1,4) from dual;
select regexp_substr('A.B^c','.',1,4) from dual;
-- ------------------------------------------------------------------------------------------------------------
select regexp_substr('A.B^c','\.') from dual;
-- ------------------------------------------------------------------------------------------------------------
select regexp_substr('A\.B^c','\\') from dual;



-- ============================================================================================================
-- 12. REGEXP_INSTR
-- ------------------------------------------------------------------------------------------------------------
-- a. return the location of "l" + 4 letters
-- ------------------------------------------------
select regexp_instr('But, soft! What light through yonder window breaks?' ,
                    'o[[:alpha:]]{1,2}', 1, 3) AS result1,
       regexp_substr('But, soft! What light through yonder window breaks?' ,
                    'o[[:alpha:]]{1,2}', 1, 3) AS result2
from dual;
-- ------------------------------------------------------------------------------------------------------------
-- b. return the location of the second "soft"
select regexp_instr('But, soft! What light through yonder window softly breaks?' , 's[[:alpha:]]{3}', 1, 2) AS result
from dual;
select regexp_substr('But, soft! What light through yonder window softly breaks?' , 's[[:punct:]]') AS result
from dual;
select regexp_substr('But, soft! What light through yonder window softly breaks?' , '[[:alpha:]]s') AS result
from dual;
select regexp_substr('But, soft! What light through yonder window softly passes?' ,'[[:alpha:]]s{1,2}') AS result
from dual;
select regexp_instr('But, soft! What light through yonder window softly breaks?' ,'o',1,3,1,'i') AS result
from dual;
-- ------------------------------------------------------------------------------------------------------------
-- c. start at position 10 then return location of the second occurance of "o"
select 
regexp_substr ('But, soft! What light through yonder window breaks?' ,'o{1,}', 10, 2) AS result1,
regexp_instr ('But, soft! What light through yonder window breaks?' ,'o', 10, 2) AS result2
from dual;

-- ------------------------------------------------------------------------------------------------------------
-- d. replace the word "light" with "sound"
select regexp_replace('But, soft! What light through' ,'l[[:alpha:]]{4}', 'sound') AS result
from dual;

-- ============================================================================================================
-- 12. The company wants to rename some products
-- DIRECTORIES AND FILES
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

select address2,
        regexp_replace(address2,
        '(^[[:alpha:] ]+), ([[:alpha:]]{2}) ([[:digit:]]{5})',
        '\3 \1, \2')
from order_addresses;   


(^[[:alpha:] ]+)     -- expression 1
,
<space>
([[:alpha:]]{2})     -- expression 2
<space>
([[:digit:]]{5})     -- expression 3




(^[[:alpha:] ]+), ([[:alpha:]]{2}) ([[:digit:]]{5})

