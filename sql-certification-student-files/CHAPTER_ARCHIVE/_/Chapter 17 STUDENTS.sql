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
-- 1. REVIEW WHERE TRUE FALSE  
--    regular expressions are nothing more than marking something as true or false
--    based on some pattern that can be made up of actual "literal" values 
--    and regex operators 
-- ------------------------------------------------------------------------------------------------------------
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
      select regexp_instr('A B C b D b E B','B',4) as address from dual;
--        n1          for mulktiple occurances possible. Optional. Defaults to 1.
      select regexp_instr('A B C b D b E B','B',1,2) as address from dual;
--        opt1        returned is either 0 or 1. Optional. Defaults to 0.
      select regexp_instr('A B C b D b E B','B',1,1,0) as address from dual;
      select regexp_instr('A B C b D b E B','B',1,1,1) as address from dual;
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
      --   --------------  Line 16  Or operastor
      select regexp_instr('S 10 Main Street Drain No. 101','10|S',2,1) as address1, 
             regexp_substr('S 10 Main Street Drain No. 101','10|S',2,1) as address2
      from dual;
-- -----------------------------------------------------------------------------
-- d. Find location of any of several characters
      select regexp_instr('S 10 Main Street Drain No. 101','N|S|M',1,1) as address1,
              regexp_substr('S 10 Main Street Drain No. 101','N|S|M',1,1) as address2 
      from dual;
      
-- -----------------------------------------------------------------------------      
-- Exercise:
-- Write a select statement that returns the position of the 2nd "lu" in Honolulu
select regexp_instr('Honolulu','lu',1,2) from dual;

-- -----------------------------------------------------------------------------
-- e. Remember the IN clause in Where contained a matching list?
--    Remember Where IN
      select state
          , firstname
          , lastname 
      from customers 
      where regexp_like(state,'FL|TX|NJ');

 -- -----------------------------------------------------------------------------    
-- f. Our first regex operator [] also contains a matching list : Line 2  Table 17-1
      select regexp_instr('S 10 Main Street Drain No. 101','[aNM]',1,1) as address1, 
              regexp_substr('S 10 Main Street Drain No. 101','[aNM]',1,1) as address2
      from dual;
-- -----------------------------------------------------------------------------
-- g. What about the spaces
      select regexp_instr('S 10 Main Street Drain No. 101','[ aNM]',1,1) as address from dual;
-- -----------------------------------------------------------------------------
-- h. What if we wanted to find about the spaces
      select regexp_instr('S 10 Main Street Drain No. 101','[aNM]',1,1) as address from dual;
-- -----------------------------------------------------------------------------
-- i. What if we wanted to find a longer string but forgot the brackets
      select regexp_instr('123 Maple Avenue, Austin, TX 78729 (512) 311-4545','[apple]',1,1) as address from dual;
-- -----------------------------------------------------------------------------
--  j. OK we fixed that by adding brackets. Now lets add {quantity} : Line 11 
      select regexp_instr('123 Maple Avenue, Austin, TX 78729 (512) 311-4545','[apple]{3}',1,1) as address1, 
              regexp_substr('123 Maple Avenue, Austin, TX 78729 (512) 311-4545','[elppa]{3}',1,1) as address2
      from dual;
      
      select regexp_instr('123 Mapleu Avenue, Austin, TX 78729 (512) 311-4545','[eu, ]{3}',1,1) as address1, 
              regexp_substr('123 Mapleu Avenue, Austin, TX 78729 (512) 311-4545','[eu, ]{3}',1,1) as address2
      from dual;      
-- ------------------------------------------------------------------------------------------------------------
-- 3. REGEXP_SUBSTR              :  Returns string found
-- ------------------------------------------------------------------------------------------------------------ 
-- a. Find and return the string where the pattern is found in the string
--    REGEXP_SUBSTR(s1, pattern1, p1, n1, m1)
--        s1              character/string. Required.
--        pattern1        regular expression. Required.
--        p1              StartPosition Optional. Defaults to 1.
      select    regexp_substr('123 Maple Apple','[apple]{4}',1) as address1 
      from dual;
-- -----------------------------------------------------------------------------
--    STUDENT EXERCISE
--    Which 'a' is brought back? 
      select    regexp_substr('123 Maple Apple','[apple]',1) as address1,
                regexp_instr('123 Maple Apple','[apple]',1) as address2
      from dual;
-- -----------------------------------------------------------------------------
--    STUDENT EXERCISE
--        n1                Occurence. Optional. Defaults to 1.
      select regexp_substr('123 Maple Apple','[apple]',1,2) as address1,
                  regexp_instr('123 Maple Apple','[apple]',1,2) as address2
      from dual;
-- -----------------------------------------------------------------------------
-- CLASS EXERCISE
--    m1          one or more of the matching parameters Table 17-5. Optional.
--    The "+" sign means quantity os 1 or more matches      :     Line 10 
--    What is the difference between the patterns '[apple]' vs '(apple)'  vs 'apple'
      select 
            regexp_substr('123 Maple Apple','[ apple]+',1,2,'i') as address1 
          , regexp_instr('123 Maple Apple','[ apple]+',1,2,0,'i') as address2 
      from dual;
--  Change [apple] to (apple) Line : 1 
      select 
            regexp_substr('123 Maple Apple','( apple)+',1,1,'i') as address1 
          , regexp_instr('123 Maple Apple','( apple)+',1,1,0,'i') as address2 
      from dual;
--  Change [apple] to apple 
      select 
            regexp_substr('123 Maple Apple',' apple+',1,1,'i') as address1 
          , regexp_instr('123 Maple Apple',' apple+',1,1,0,'i') as address2 
      from dual;
-- ------------------------------------------------------------------------------------------------------------
-- b. Find same pattern using : matching set, or range, or Character Class 
      select regexp_substr('123 Maple Avenue, Austin, TX 78729 (512) 311-4545','[0123456789]{3}',1,2) as address1 
      from dual;
--  Change [0123456789] to [0-9]              : Table 17-3
      select regexp_substr('123 Maple Avenue, Austin, TX 78729 (512) 311-4545','[0-9]{3}',1,2) as address1 
      from dual;
--  Change [0123456789] to [:DIGIT:]          : Table 17-2
      select regexp_substr('123 Maple Avenue, Austin, TX 78729 (512) 311-4545','[[:digit:]]{3}',1,2) as address1 
      from dual;
-- ------------------------------------------------------------------------------------------------------------
-- c. Find using : quantities        : Line 10     {this means contiguous trues)
      select regexp_substr('123 Maple Avenue, Austin, TX 78729 (512) 311-4545','[ a-zA-Z,0-9]+',1,1) as address1 
      from dual;
--    Find using : quantities        : Line 11
      select regexp_substr('123 Maple Avenue, Austin, TX 78729 (512) 311-4545','[a-zA-Z]{3}',1,1) as address1 
      from dual;
--    Find using : quantities        : Line 12      
      select regexp_substr('123 Maple Avenue, Austin, TX 78729 (512) 311-4545','[a-zA-Z]{3,}',1,1) as address1 
      from dual;
--    Find using : quantities        : Line 13      
      select regexp_substr('123 Maple Avenue, Austin, TX 78729 (512) 311-4545','[a-z A-Z]{3,8}',1,1) as address1 
      from dual;
--    Find using : quantities        : Line 13      (Add a space and run again
      select regexp_substr('123 Maple Avenue, Austin, TX 78729 (512) 311-4545','[a-zA-Z]{3,8}',1,1) as address1 
      from dual;
-- ------------------------------------------------------------------------------------------------------------
-- d. Find pattern 
      select regexp_substr('123 Maple Avenue, Austin, TX 78729 (512) 311-4545','[a-zA-Z]{3}',1,3) as address1 
      from dual;
-- ------------------------------------------------------------------------------------------------------------
-- e. Find pattern
      select regexp_substr('123 Maple Avenue, Austin, TX 78729 (512) 311-4545','[0-9()]',1,7) as address1 
      from dual;
-- ------------------------------------------------------------------------------------------------------------
-- f. Find pattern
      select regexp_substr('123 Maple Avenue, Austin, TX 78729 (512) 311-4545','[0-9() -]{4,}',1,2) as address1
      from dual;
-- ------------------------------------------------------------------------------------------------------------
-- g. Find pattern
      select regexp_substr('123 Maple Avenue, Austin, TX 78729 (512) 311-4545','[0-9( )-]{7,}',1,1) as address1
      from dual;
-- ------------------------------------------------------------------------------------------------------------
-- h. Find pattern  Line : 18
      select regexp_substr('123 Maple Avenue, Austin, TX 78729 (512) 311-4545','[0-9 ()-]{5}$',1,1) 
      address from dual;

-- ------------------------------------------------------------------------------------------------------------
-- 3. REGEXP_REPLACE (s1,pattern1,rep1,p1,o1,m1 
-- ------------------------------------------------------------------------------------------------------------ 
-- a. replace the word "light" with "sound"
    select regexp_replace('But, soft! What light through' ,'l[[:alpha:]]{4}', 'sound') as result
    from dual;
-- ------------------------------------------------
-- b. What does this return  Line : 7 
    select regexp_replace('Chapter 1 ......................... I Am Born',
    '[.]','-') as toc
    from dual;
-- ------------------------------------------------
-- c. What does this return
      select regexp_replace('And then he said *&% so I replied with $@($*@',
              '[!@#$%^&*()]','-') BleepedOut
      from dual;
-- ------------------------------------------------
-- d. What does this return
      select regexp_replace('and     in   conclusion,       2/3rds of our revenue ',
      '( ){2,}', ' ') text_line
      from dual;
-- ------------------------------------------------
-- e. What does this return  Line : 17  vs Line 3
      select  address2,
              regexp_replace(address2, '(^[[:alpha:]]+)', 'city') new_address
      from order_addresses;
-- ------------------------------------------------
-- f. What does this return
--    Line 1 taken with Line : 14 (one use of the \) Line : 1
      select  address2,
              regexp_replace(address2,
              '(^[[:alpha:] ]+), ([[:alpha:]]{2}) ([[:digit:]]{5})',
              '\3 \2 \1') the_string
      from cruises.order_addresses;
      
-- ------------------------------------------------------------------------------------------------------------
-- 3. REGEXP_Like') 
  from park
--  Simple phone examples   line : 14    
  select regexp_substr(description,'\([0-9]{3}\)')
  from park
  where regexp_like(description,'\([0-9]{3}\)');
  
  
  select regexp_substr(description,'\([0-9]{3}\) [0-9]{3}[-. ][0-9]{4}') 
  from park
  where regexp_like(description,'\([0-9]{3}\) [0-9]{3}[-. ][0-9]{4}');   
-- 1. ---------------------------------------------------------------------    
    select park_name, regexp_substr(description, '\+([0-9]{1,3} ){1,4}[0-9]+') 
    from park      
    where regexp_like(description, '\+([0-9]{1,3} ){1,4}[0-9]+');
-- 2. ---------------------------------------------------------------------    
    select park_name, regexp_substr(description,'\([0-9]{3}\) [0-9]{3}(\.| |-)[0-9]{4}')
    from park
    where regexp_like(description,'\([0-9]{3}\) [0-9]{3}(\.| |-)[0-9]{4}');      
-- 3. ---------------------------------------------------------------------    
    select 
      park_name, regexp_substr(description,'[0-9]{3}-[0-9]{4}|[0-9]{3}\.[0-9]{4}')
    from park
    where regexp_like(description,'[0-9]{3}-[0-9]{4}|[0-9]{3}\.[0-9]{4}');
-- 4. ---------------------------------------------------------------------
    select park_name,
    regexp_substr(description, 
                '\+([0-9]{1,3} ){1,4}[0-9]+'||
                '|(\()[0-9]{3}(\)) [0-9]{3}(\.| |-)[0-9]{4}'||
                '|[0-9]{3}-[0-9]{4}|[0-9]{3}\.[0-9]{4}') phone_num
    from park
    where regexp_like(description, 
                '\+([0-9]{1,3} ){1,4}[0-9]+'||
                '|(\()[0-9]{3}(\)) [0-9]{3}(\.| |-)[0-9]{4}'||
                '|[0-9]{3}-[0-9]{4}|[0-9]{3}\.[0-9]{4}');

    
-- ------------------------------------------------------------------------------------------------------------
-- 5. Examples from and inspired by the book 
-- ------------------------------------------------
select regexp_count('Honolulu','o') from dual; 
-- a. What does this return
      select regexp_substr('shrororororosasasasae sells sea shells down by the seashore',
                      's[eashor]+e' ) the_result1,
             regexp_instr('shrororororosasasasae sells sea shells down by the seashore',
                      's[eashor]+e' ) the_result2         
      from dual;
-- ------------------------------------------------
-- b. What does this return
      select regexp_substr('she sells sea shells down by the seashore',
                      's(eashor)e' ) the_result1,
             regexp_instr('she sells sea shells down by the seashore',
                      's(eashor)e' ) the_result2         
      from dual;
-- ------------------------------------------------
-- c. What does this return         Logical OR          : Line 16
      select address2, regexp_substr(address2,'(TN|MD|OK)') as state1,
                        regexp_instr(address2,'(TN|MD|OK)') as state2 
      from order_addresses
      where regexp_like(address2,'(TN|MD|OK)');
-- ------------------------------------------------      
-- d. What does this return         End of Line Anchor  : Line 18
      select address2, regexp_substr(address2,'[37]$') last_digit1,
                        regexp_instr(address2,'[37]$') last_digit2
      from order_addresses
      where regexp_like(address2,'[37]$');
-- ------------------------------------------------   
-- e. What if you want to find the '.' period      
--    Inside the braces (literal value : itself)
      select regexp_substr('A.B*c','[.]',1,1) as a,
              regexp_instr('A.B*c','[.]',1,1) as b
      from dual;
     
      -- ------------------------------------------------
      -- Inside the Parenthesis (regex operator status)
      select regexp_substr('A.B^c','(.)',1,3) as a,
             regexp_instr('A.B^c','(.)',1,3) as b
      from dual;
      -- itself (regex operator status)
      select regexp_substr('A.B^c','.',1,4) from dual;
      -- If you want to ensure you find it : escape it  :      Line 14
      select regexp_substr('A.B^c','\.') from dual;
-- ------------------------------------------------
-- f. Now find the '\' character
      select regexp_substr('A\.B^c','\\') from dual;
-- ------------------------------------------------------------------------------------------------------------
-- g. return the location of "l" + 4 letters
-- ------------------------------------------------
      select regexp_instr('But, soft! What light through yonder window breaks?' ,
                          'o[[:alpha:]]{1,2}', 1, 3) AS result1
           , regexp_substr('But, soft! What light through yonder window breaks?' ,
                          'o[[:alpha:]]{1,2}', 1, 3) AS result2
      from dual;
-- ------------------------------------------------------------------------------------------------------------
-- h. return the location of the second "soft"
    select regexp_instr('But, soft! What light through yonder window softly breaks?' 
                        , 's[[:alpha:]]{3}', 1, 2) AS result1,
           regexp_substr('But, soft! What light through yonder window softly breaks?' 
                        , 's[[:alpha:]]{3}', 1, 2) AS result2         
    from dual;
-- ------------------------------------------------------------------------------------------------------------
-- i. What does this return
    select regexp_substr('But, soft! What light through yonder window softly breaks?' ,
                        's[[:punct:]]') AS result1,
          regexp_instr('But, soft! What light through yonder window softly breaks?' ,
                        's[[:punct:]]') AS result2
    from dual;
-- ------------------------------------------------------------------------------------------------------------
-- j. What does this return
    select regexp_substr('But, soft! What light through yonder window softly breaks?' ,
              '[[:alpha:] ]+\?$') AS result1,
          regexp_instr('But, soft! What light through yonder window softly breaks?' ,
              '[[:alpha:] ]+\?$') AS result2
    from dual;
-- ------------------------------------------------------------------------------------------------------------
-- k. What does this return
    select regexp_substr('But, soft! What light through yonder window softly passes?' ,
              '[[:alpha:] ,]+s{1,1}',1,2) AS result1,
          regexp_instr('But, soft! What light through yonder window softly passes?' ,
              '[[:alpha:] ,]+s{1,1}',1,2) AS result2
    from dual;
-- ------------------------------------------------------------------------------------------------------------
-- l. What does this return
    select regexp_instr('But, soft! What light through yonder window softly breaks?' ,
              'ut,',1,1,1,'i') AS result1,
           regexp_instr('But, soft! What light through yonder window softly breaks?' ,
              'ut,',1,1,0,'i') AS result2,   
           regexp_substr('But, soft! What light through yonder window softly breaks?' ,
              'ut,',1,1,'i') AS result3
    from dual;
-- ------------------------------------------------------------------------------------------------------------

-- ------------------------------------------------------------------------------------------------------------
-- SIMPLE EMAIL EXAMPLES
-- ------------------------------------------------------------------------------------------------------------
-- SIMPLIFIED EMAIL HAS 4 PARTS
    -- Part 1:  name
    -- Part 2:  @
    -- Part 3:  company
    -- Part 4:  domain 
-- -----------------------------------------------------------------------------
--  1. SETUP
      drop table my_emails; 
      create table my_emails (email  varchar2(100));
      -- SIMPLIEST just letters
      insert into my_emails values('noah@cinema.org');
      -- Some will have '_'
      insert into my_emails values('mrs_rockets@literature.com');
      -- Some will have '.'
      insert into my_emails values('mr.campbell@sunshine.edu');
      -- Some will have multiple combinations '_'
      insert into my_emails values('mrs_rockets123_44@literature.com');
      -- Some will have multiple combinations '_' and '.'
      insert into my_emails values('mr.campbell_abc.123@sunshine.edu');
      commit;
      
-- -----------------------------------------------------------------------------
-- 2. Find Part One Using Ranges: Exercises to find confirm an email address is valid (copy and paste from 2.c above
      select regexp_substr(email,'[a-zA-Z]+',1,1) 
      from my_emails;
-- -----------------------------------------------------------------------------
-- 3. Part One Using Character classes
      select regexp_substr(email,'[[:alnum:]_.]+',1,1) 
      from my_emails;
-- -----------------------------------------------------------------------------
-- 4. Find Part Two @ 
      select regexp_substr(email,
      '[a-zA-Z_.0-9]+@',1,1) 
      from my_emails;
-- -----------------------------------------------------------------------------
-- 5. Find Part Three  
--    Add to the above parts 1 & 2  using ranges
      select regexp_substr(email
      ,'[a-zA-Z_.0-9]+@[a-zA-Z0-9]+',1,1) 
      from my_emails;
      
--    Add to the above parts 1 & 2  using character classes
      select regexp_substr(email,
      '[[:alnum:]_.]+@[[:alnum:]]+',1,1) 
      from my_emails;
-- -----------------------------------------------------------------------------
-- 5. Find Part four
--    Add to the above parts 1 & 2 & 3  using ranges
      select regexp_substr(email,
                            '[a-zA-Z_.0-9]+@[a-zA-Z0-9]+\.(org|com|net|edu|gov|mil)',1,1) 
      from my_emails;
--    Add to the above parts 1 & 2 & 3  using character classes

      select regexp_substr(email,'[[:alnum:]_.]+@[[:alnum:]]+',1,1) from my_emails;

      
      select regexp_substr(email,'[[:alnum:]_.]+@[[:alnum:]]+\.[[:alpha:]]{2,3}',1,1) from my_emails;


select regexp_instr('when the company (CCLX, 24.11)',
                     '\([^)]+\)') as a,
      regexp_substr('when the company (CCLX, 24.11)',
                     '\([^)]+\)') as b
from dual; 
