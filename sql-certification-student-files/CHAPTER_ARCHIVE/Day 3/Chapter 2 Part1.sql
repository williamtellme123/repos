-- -----------------------------------------------------------------------------
-- 1. Chapter 2 and a look ahead
-- This is a comment
-- comments are not read by the SQL engine
/* 
    Anther way to writes comments is to use the asterick and backslash
    This is often done when providing a large amount of documentation
    for your work. Some people use this type of content to give the author,
    date, version, and an explanation for what the code does.
       
*/
-- -----------------------------------------------------------------------------
-- 2. Simplest SQL command
-- It has 4 pieces
-- keyword "select"
-- the "*" which means list all the columns
-- the "from" which tells the sql engine which table to use
-- finally, at least 1 table
select *
from customers;
-- -----------------------------------------------------------------------------
-- 3. Spaces: notice that spaces do not matter between words
select   

*


from                                               customers;
-- Although less space makes it easier to read.
-- -----------------------------------------------------------------------------
-- 4. What follows is a list of of columns
--    RERMEMBER:
--    any time you have a list of things use the comma "," to separate
select customer#,firstname,lastname
from customers;
-- -----------------------------    
-- a. ANY or ALL columns the table or tables in the from clause may be returned
--    What is the problem here?
select firstname, lastname, state, customer#, 
from customers
where state = 'FL';
-- -----------------------------
-- b. ANY or ALL columns in any order may be returned
select referred, zip, state, city, address, firstname, lastname, customer#
from customers;
-- -----------------------------
-- c. But when you return all the columns in the asterisk it is in the 
--    order of the table
select * from customers;
