-- -----------------------------------------------------------------------------
-- BOOK
-- ------------------------------------------------
-- page 220
select regexp_substr('Mississippi','[a-z]') abc from dual;
select regexp_substr('Mississippi','[a-z]', 4) abc from dual;
select regexp_substr('MiSsIsSiPpI','[a-z]', 4, 2) abc from dual;
select regexp_substr('MiSsIsSiPpI','[a-z]', 4, 2, 'i') abc from dual;

select regexp_substr('Mississippi','[a-z]{3}') from dual;
select regexp_substr('MissiSsippi','[a-z]{3,4}') from dual;
select regexp_substr('MissiSsippi','[a-z]{3,4}',1,2) from dual;
select regexp_substr('Mississippi','[a-z]{3,4}',1,2) from dual;

select regexp_substr('M i s s i s s i p p i','[ a-z]{3,4}',1,2) from dual;
select regexp_substr('abcdefghijklimnp','[a-z]{3,4}',1,2) from dual;

select regexp_replace('Mississippi','[a-z]','*') from dual;
select regexp_count('Mississippi','i') from dual;


-- ------------------------------------------------
-- find records where first name is J ignore the case
SELECT *
FROM employees;
-- ------------------------------------------------

SELECT *
FROM employees
WHERE regexp_like(first_name, '^[^j]','i');

SELECT first_name, regexp_substr(first_name, '[^j]',1,1,'i')
FROM employees
WHERE regexp_like(first_name, '[^j]','i');


SELECT regexp_substr(',the ,','(^|[[:space:][:punct:]]+)([[:alpha:]]+)'
  || '[[:space:]]\1')
FROM dual;

SELECT regexp_substr(',the  ','(^|[[:space:][:punct:]]+)([[:alpha:]]+)([[:space:]])\3')
FROM dual;

SELECT regexp_substr('!the !','(^|[[:space:][:punct:]]+)([[:alpha:]]+)'
  || '[[:space:][:punct:]]+\1')
FROM dual;
SELECT * FROM employees WHERE regexp_like(first_name, '^(J|j)');

-- page 645
select regexp_substr('123 Maple Avenue', '[a-z]') address
from dual;
select regexp_instr('123 Maple Avenue', '[A-Z]') address from dual;
-- ------------------------------------------------
-- page 646 top
select regexp_substr('123 Maple Avenue', '[A-Za-z]', 1, 2) address
from dual;
-- ------------------------------------------------
-- page 646 middle
select regexp_substr('123 Maple Avenue this is a long sentence' , '[ a-zA-Z]+') address
from dual;

-- ------------------------------------------------
-- page 646 bottom
select regexp_substr('123 Maple Avenue', '[ [:alpha:]]+') address
from dual;
-- ------------------------------------------------
-- page 647 top
select regexp_substr('123 Maple Avenue', '[:alpha:]+') address
from dual;
-- ------------------------------------------------
-- page 647 bottom
select regexp_substr('123 Maple Avenue street ', '[[:alpha:]]+',1,2) address
from dual;
-- ------------------------------------------------
-- page 648 top
select regexp_substr('123 Maple Avenue', '[[:alnum:] ]+') address
from dual;
select regexp_substr('123 Maple Avenue Street!', '[[:alnum:] ]+',5,1) address
from dual;
-- page 646
select regexp_substr('123 Maple Avenue', '[A-Za-z]+') address from dual;
-- page 646
select regexp_substr('123 Maple Avenue, Austin, TX, 78729', '[[:alpha:]]+', 1, 3) address from dual;
-- page 646
select regexp_substr('123 Maple Avenue', '[:alpha:]+') address from dual;


-- ------------------------------------------------
-- page 648 middle
select address2,
  regexp_substr(address2,'[[:digit:]]+') zip_code
from order_addresses;

select address2 from order_addresses;
select street_address, zip from addresses;
select street_address || ' ' || zip from addresses;

-- ---------------------------------------------------------------------------
select street_address, zip,
      regexp_substr(street_address ||  ' ' || zip,'[[:digit:]]{5}$') 
from addresses;
-- ---------------------------------------------------------------------------
-- ------------------------------------------------
-- page 648 bottom
select regexp_substr('123 Maple Avenue', 'Maple') address
from dual;


select regexp_instr('123 Maple Avenue', 'Maple') address from dual;



-- ------------------------------------------------
-- page 649 top
select regexp_substr('she sells sea shells down by the seashore' ,'s[eashor]+e',1,2) ,
       regexp_instr('she sells sea shells down by the seashore' ,'s[eashor]+e',1,2) 
from dual;
-- ------------------------------------------------
-- page 649 middle
select regexp_substr('she sells sea shells down by the seashore' ,'s(eashor)e' ) the_result
from DUAL;
-- ------------------------------------------------
-- page 649 bottom 1
select regexp_substr('she sells sea shells down by the seashore' ,'seashore' ) the_result
from dual;

-- ------------------------------------------------
-- page 649 bottom 2
select regexp_substr('she sells sea shells down by the seashore' ,'[[:alpha:]](shore)' ) the_result
from dual;

select regexp_substr('she sells sea shells down by the seashore' ,'[[:alpha:]]*' ) the_result
from dual;

select regexp_substr('she sells sea shells down by the seashore' ,'sh*e',1,2 ) the_result,
      regexp_instr('she sells sea shells down by the seashore' ,'sh*e',1,2 ) the_result
from dual;

-- page 649
select regexp_substr('she sells sea shells by the seashore'
            ,'s[eashor]+e') from dual;
-- page 649
select regexp_substr('sshoooohhaaassshhssrrrhe sells sea shells by the seashore'
            ,'s[eashor]+e') from dual;
-- page 649
select regexp_substr('she sells sea shells by the seashore'
            ,'s(eashor)e') from dual;
-- page 649
select regexp_substr('she sells sea shells by the seashore'
            ,'s(easho)+e') from dual;
            
- ------------------------------------------------
-- regexp_count
-- ------------------------------------------------
SELECT regexp_count('The shells she sells are surely seashells', 'el') AS regexp_count
FROM dual;            
-- ------------------------------------------------
-- page 650 middle

select ADDRESS2,
  REGEXP_SUBSTR(ADDRESS2,'(TN|MD|OK)') RESULT
from order_addresses;

select address2,regexp_substr(address2,')TN|MD|OK)')
from order_addresses;

select address2,regexp_substr(address2,'[TNMDOK]',1,2)
from order_addresses;

select ADDRESS2,
  REGEXP_SUBSTR(ADDRESS2,' [A-Z]{2} ') RESULT
from order_addresses;

-- ------------------------------------------------
select address2,
  regexp_substr(address2,'[TX|TN|MD|OK]') state
from ORDER_ADDRESSES
where regexp_like(address2,'[TX|TN|MD|OK]');
-- ------------------------------------------------

-- page 650 
select regexp_substr('Help desk: (212) 555-1212', '([[:digit:]]+)') area_code
from dual;
select regexp_substr('Help desk: (212) 555-1212', '\([[:digit:]]{3}\)') area_code
from dual;
-- ------------------------------------------------
-- page 651 
select regexp_substr('Help desk: (212) 555-1212', '\([[:digit:]]+\)') area_code
from dual;
-- ------------------------------------------------
-- page 651 middle
select ADDRESS2,
  regexp_substr(address2,'[TBH][[:alpha:]]+') name
from ORDER_ADDRESSES
where regexp_like(address2,'[TBH][[:alpha:]]+') ;

select address2 from order_addresses;
-- ------------------------------------------------
select address2,
  regexp_substr(address2,'[TBH][[:alpha:]]+') name
from order_addresses
where regexp_like(address2,'[TBH][[:alpha:]]+') ;
-- ------------------------------------------------
-- page 652 top
select regexp_substr('BMW-Oracle;Trimaran;February 2010', '[^;]+', 1, 2) americas_cup
from dual;

--page 652
select regexp_substr('BMW-Oracle;Trimaran;February 2010','[^[:alpha:]]+',1,1)abc,
       regexp_instr('BMW-Oracle;Trimaran;February 2010','[^[:alpha:]]+',1,1) def
from dual;

-- ------------------------------------------------
-- page 652
select address2
    , regexp_substr(address2,'[378]+$') a
    , regexp_substr(address2,'[378]+') b
    , regexp_substr(address2,'^[BO]+') c
    , regexp_substr(address2,'[^BW]+') d
from order_addresses;




select address2,
  regexp_substr(address2,'7$') 
from ORDER_ADDRESSES
where regexp_like(address2,'7$');

-- ------------------------------------------------
select address2,
  REGEXP_SUBSTR(ADDRESS2,'[59]+$')
from order_addresses
where regexp_like(address2,'[59]+$') ;
-- ------------------------------------------------
-- page 653 top
select address2,
  regexp_substr(address2,'83$') last_digit
from ORDER_ADDRESSES
where regexp_like(address2,'83$') ;
select ADDRESS2,
  regexp_substr(address2,'(83|78|1|2|45)?$') last_digit
from ORDER_ADDRESSES
where regexp_like(address2,'(83|78|1|2|45)?$');
select ADDRESS2,
  regexp_substr(address2,'(0)[0-9]{4}$') last_digit
from ORDER_ADDRESSES
where regexp_like(address2,'(0)[0-9]{4}?$');
-- ------------------------------------------------
-- page 654 top
select REGEXP_REPLACE('Chapter 1 ......................... I Am Born','[.]','-') TOC
from dual;

select REGEXP_REPLACE('Chapter 1 ......................... I Am Born','[.]+','-') TOC
from dual;

select regexp_replace('Chapter 1 ......................... I Am Born','[e]+','-') toc
from dual;

select regexp_replace('Chapter 1 ......................... I Am Born','.+','-') toc
from dual;

select regexp_replace('C','[e]*','-') toc from dual;

select regexp_replace(' ','[e]*','-') toc from dual;
-- ------------------------------------------------
select regexp_replace('Chapter 1 ......................... I Am Born','[.]','-') toc
from dual;
-- ------------------------------------------------
-- page 654 middle
select regexp_replace('And then he said *&% so I replied with $@($*@','[!@#$%^&*()]','-') prime_time
from dual;
-- ------------------------------------------------
-- page 654 bottom
select regexp_replace('And then he said *&% so I replied with $@($*@','[!@#$%^&*()]+','-') prime_time
from dual;
-- ---------------------------------------------------------
-- page 654 alternate
select regexp_replace('and then he said *&% so I replied with $@($*&@'
                      ,'[^&!@#$%*()]'
                      ,'-')
from dual;
-- ------------------------------------------------
-- page 655 top
select regexp_replace('and  in conclusion, 2/3rds of our  revenue ','( ){2,}', ' ') text_line
from dual;
-- ------------------------------------------------
-- page 655 bottom
select address2,
  regexp_replace(address2, '(^[[:alpha:]]+)', 'CITY') the_string
from order_addresses
where rownum <= 5;
-- ------------------------------------------------
-- page 656 middle
select address2,
  REGEXP_REPLACE(ADDRESS2, '(^[[:alpha:] ]+)', 'CITY') THE_STRING
from order_addresses
where rownum <= 5;
-- ------------------------------------------------
select address2
from order_addresses
where rownum <= 5;

-- ---------------------------------------------------------
 -- PAGE 657 this is called the back reference operator
-- simple example of back reference \2
-- back reference says match what has already been matched
-- by the numbered subexpression
select regexp_substr('she sells sea shells by the seashore',
          'she sells ([[:alpha:]]+) shells by the \1shore')
from dual;

-- ------------------------------------------------
select address2,
  regexp_replace(address2, '(^[[:alpha:] ]+), ([[:alpha:]]{2}) ([[:digit:]]{5})','\3 \2 \1') the_string
from order_addresses
where rownum <= 5;

select regexp_substr('she sells sea shells by the seashore',
                     '(she sells )([[:alpha:]]+) shells by the \2shore')
from dual;
-- ------------------------------------------------
-- page 658 middle
select address2,
  regexp_replace(address2,'(^[[:alpha:] ,]+) ([[:alpha:]]{2}) ([[:digit:]]{5})','\3 \2 \1') the_string
from order_addresses
where rownum <= 5;
-- ------------------------------------------------
-- page 658 bottom
select address2,
  regexp_replace(address2, '(^[[:alpha:] ]+), ([[:alpha:]]{2}) ([[:digit:]]{5})', '\3 \2-"\1"') the_string
from order_addresses
where rownum <= 5;



-- ---------------------------------------------------------
-- page 659
create table email_list
  ( email_id number(7) primary key,
    emaila    varchar2(120),
    CONSTRAINT ck_el_emaila
        check (
              regexp_like (emaila,
                           '^([[:alnum:]]+)@[[:alnum:]]+.(com|net|org|edu|gov|mil)$'
                          )
              )
);
insert into email_list values (1,'1@2.com');
insert into email_list values (2,'joe.smith@getty.com');
insert into email_list values (3,'this.is123 a_very long name@bettyCrocker.com');
insert into email_list values (4,'this_is_a_very_long_name@lastVegas.com');

select regexp_substr('this is a (string of .. 567)','\([^)]+\)' ) from dual;
select regexp_substr('S Elton John','Sir +') from dual;

select regexp_substr('mark','^m',1,1,'i') from dual;
select regexp_substr('Mark','^m',1,1,'i') from dual;
select regexp_substr('izziet','^m',1,1,'i') from dual;
select regexp_substr('ivan','^m',1,1,'i') from dual;

select regexp_substr('Charles "Dickens" riverside','[[:alnum:]]+',1,2)
from dual;

select regexp_instr('Charles "Dickens" riverside','[[:alnum:]]+',1,2,1)
from dual;