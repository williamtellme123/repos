-- -----------------------------------------------------------------------------
-- 1. CHAPTER 1 and 2 
-- 
--    This is a comment because it starts with two dashes
--    comments are not read by the SQL engine
/* 
      Anther way to writes comments is to use the asterick and backslash
      This is often done when providing a large amount of documentation
      for your work. Some people use this type of content to give the author,
      date, version, and an explanation for what the code does.
*/
-- -----------------------------------------------------------------------------
-- 2. SIMPLEST SQL COMMAND
--    It has 4 pieces
--    keyword "select"
--    the "*" which means list all the columns
--    the "from" which tells the sql engine which table to use
--    finally, at least 1 table
select *
from customers;
-- -----------------------------------------------------------------------------
-- 3. SPACES
--    Notice that spaces do not matter between words
select   

*


from                                               customers;
-- Although less space makes it easier to read.
-- -----------------------------------------------------------------------------
-- 4. What follows is a list of of columns
--    RERMEMBER: 
--    any list in SQL is separated with the comma "," 
select customer#,firstname,lastname
from customers;
-- -----------------------------    
-- a. ANY or ALL columns the table or tables in the from clause may be returned
--    What is the problem here?
select firstname, lastname, state, customer# 
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
-- -----------------------------
-- d. AT WORK TIP
--    Whenever you start a new database job. Often the most difficult job
--    is understanding what tables are present. Here is a command that
--    is often used when starting out. Does it work?
select column_name from all_tab_columns
where table_name = 'CUSTOMERS';
-- -----------------------------------------------------------------------------
-- 5. WHERE CLAUSE. The next key word is "where"
--    It tells the engine which rows to return
--    the clause always ends up either TRUE or FALSE
--    RERMEMBER: when you are comparing a column to 
--    some actual data; IT IS CASE SENSITIVE
select customer#, firstname,lastname, state
from customers
where state = 'FL';
-- -----------------------------
-- a. REMEMBER: SQL istelf is NOT CASE SENSITIVE
SELECT CUSTOMER#, 
FIRSTNAME, LASTNAME, 
STATE FROM CUSTOMERS WHERE 
STATE = 'FL';
-- -----------------------------
-- b. Example: Does this work?
select CUSTOMER#, firstname,LastName, STate from 
CUSTOMERS
WHERE 
STATE ='FL';
-- -----------------------------
-- c. What about this?
select CUSTOMER#, firstname,LastName, STAte
from CUSTOMERS
WHERE STATE = 'FL';
-- ----------------------------- 
-- d. What about this?
select CUSTOMER#, firstname,LastName, STate from CUSTOMERS WHERE STATE ='FL';
-- -----------------------------
-- e. What about this? It sounds like a question in English
select customer#, firstname,lastname, state
from customers
where state = 'FL' or state = 'TX';
-- -----------------------------------------------------------------------------
-- 6. MORE WHERE CLAUSE. When asking questions when you don't know the 
--    character case of the text. Here is a useful function.
select customer#, firstname,lastname, lower(lastname)
from customers
where lower(lastname)  = 'smith';
-- Whole chapter devoted to these single row functions
-- -----------------------------------------------------------------------------
-- 7. WHERE CLAUSE a little more. You can ask more than one question in a 
--    where clause but it has to be asked in a way that there can only
--    be one answer for every row: T or F.
select customer#, firstname,lastname, state
from customers
where state = 'FL' or 
state = 'TX';
-- -----------------------------
-- a. What about this?
select customer#, firstname, lastname, state
from customers
where state = 'FL' or 
state = 'TX';
-- -----------------------------
-- b. What about this?
select customer#, firstname lastname, state
from customers
where state = 'FL' and 
state = 'TX';
-- -----------------------------
-- c. Connection Cruises
select count(*) from ship_cabins;
-- d. How many rows? How many columns?
-- e. Now return just 
select ship_cabin_id, ship_id, room_style, room_type, window from ship_cabins;
-- -----------------------------------------------------------------------------
-- QUESTIONS
-- Q1. What are two kinds of errors we have seen?
--    Answer: __________________________________

-- Q2. What is the special word that describes which rows SQL returns?
--    Answer: __________________________________

-- Q3. What is the name of the rows returned after a SQL statement 
-- completes
--    Answer: __________________________________

-- Q4. What is the special word used in SQL that tells the engine 
-- which columns to return?
--    Answer: __________________________________

-- Q5. In the smallest possible SQL what two key words are required
--    Answer: __________________________________

-- Q6. If you get a business error what is the name of the result
--    when all you can see are the columns names and no rows?
--    Answer: __________________________________
-- -----------------------------------------------------------------------------
-- 8. Building tables
--    We want to create a new schema to practice in.
--    To do that we: 
--       a. use System user
--       b. create a user with a password
--       c. grant the user all privileges
--       d. Follow the steps in No. 9
-- -----------------------------------------------------------------------------
-- 9. Click the connection drop down top right, choose System, execute following commands
create user billy identified by billy; 
grant all privileges to billy; 
-- -----------------------------------------------------------------------------
-- 10. SQL Developer connection
--    Now in the left pane of SQL developer add a new connection
--            Connection Name: billy
--                  User Name: billy
--                   Password: billy
--    Now open the connection
-- -----------------------------------------------------------------------------
-- 11. CREATING A TABLE MANUALLY
--     You can define the column to be a primary key
--     When you do so on the same line as the column
--     it is called an IN-Line contraint
create table friends
(friend_id integer primary key,
fname  varchar2(25),
lname  varchar2(25),
phone  varchar2(25),
email  varchar2(25)
);
-- -----------------------------------------------------------------------------
-- 12. INSERTING into a table    
-- -----------------------------
-- a. No Columns
insert into friends values (1, 'Bill', 'Bailey',5552344444, 'bbailey@hotmail.com');
insert into friends values (2, 'Betty', 'Boop', '2304352222', 'booper@jazz.com'); 
--    Is there a problem?
-- -----------------------------
-- b. Some columns (must follow constraint rules) but do not need to be in same order
insert into friends (friend_id, fname, lname) values (3,'Big', 'Julie');
--    Is there a problem?
-- -----------------------------
-- c. All columns
insert into friends(email, phone, fname, lname, friend_id) values ('hornet@comet.com','1 (512) 560-3456', 'Buzz', 'LightYear',4);
--    Is there a problem?
-- -----------------------------------------------------------------------------
-- 13. Don't forget to commit;
commit;
-- -----------------------------------------------------------------------------
-- 14. SORTING & SEQUENCES
-- -----------------------------
-- a. Sometimes when inserting I can't remember what the next value for ID is. There might be thousands of rows. 
--    So SQL gives us a counting object we can use that keeps track for us.
--    It is called a sequence. There is lots to know about sequences but lets start at the beginning
--    with a very simple example.
--    But before we create one to use with inserting into our friends table 
--    lets see what we want to set the sequence to start with. 
--    What is the biggest friend_id now?
--    A simple select works really well if there are just a few rows.
select friend_id, fname, lname, phone, email  
from friends;
-- -----------------------------
-- b. But if there are hundreds of rows we can sort them 
--    Another way is to sort the column. This puts the largest number at the bottom
select friend_id, fname, lname, phone, email
from friends
order by friend_id;
-- -----------------------------
-- c. So lets reverse the sort
select friend_id, fname, lname, phone, email
from friends
order by friend_id desc;
-- -----------------------------
-- d. One more way to find the biggest number
--    A whole chapter is devoted to these functions
select max(friend_id)
from friends
order by friend_id desc;
-- -----------------------------
delete from friends;
-- -----------------------------
-- e. Okay now we know the largest number is 2
--    Lets create a sequence that starts with 3
create sequence seq_friends start with 5;
-- f. Now we can use this sequence without having to remember the
--    last id in our table
insert into friends (friend_id, fname, lname, phone, email) values (seq_friends.nextval, 'Bubba','Gump','234-567-8888','bubba@bubbagumpshrimp.com');
-- -----------------------------------------------------------------------------
-- 15. INSERTING: One More Technique
-- -----------------------------
-- a. You can also insert rows into one table from another table, as long as the data is the 
--    same type. You can also use the sequence created for use with the friends table
Insert into friends (friend_id, fname, lname) 
select seq_friends.nextval, firstname, lastname
from books.customers;
-- -----------------------------------------------------------------------------
-- 16. CREATING A TABLE: ANOTHER WAY CTAS
--     CTAS is Create Table AS SELECT
--     make sure you are in your schema 
--     NOTE: you do not need to use all the columns from the cource table
create table customers
as select customer#,firstname, lastname 
from books.customers
where state = 'FL';
select * from customers;
-- -----------------------------------------------------------------------------
-- 17. Lets do that again: CTAS 
--     But this time from cruises
select * from ship_cabins;
create table ship_cabins
as 
select *
from cruises.ship_cabins;
select * from ship_cabins;
-- -----------------------------------------------------------------------------
-- 18. Commit saves the transactions performed since we started
commit;
-- -----------------------------------------------------------------------------
-- 19. IMPORT is another way to inset rows
--     Instructions given in class
--     If you are absent please ask your SQL buddy form class
-- -----------------------------------------------------------------------------
-- 20. WHERE revisited
select ship_cabin_id, ship_id, room_style, room_type,window
from ship_cabins;
-- -----------------------------------------------------------------------------






-- 21. CREATE ANOTHER TABLE :: STOPPED HERE SATURDAY
create table movies
( 
  movie_id    number primary key,
  title       varchar2(25),
  length_mins number,
  year        number
);
-- -----------------------------------------------------------------------------
-- 22. PRIMARY KEY 
--    Add a primary key after you create your first table
--    Constraints are rules on tables.
--    The first one we learn is primary key.
--    When you create the PK in the same line as the column it is
--    called an in-line constraint
alter table movies add constraint movies_pk primary key (movie_id);
-- -----------------------------------------------------------------------------
-- 23. Now we insert a few movies
insert into movies values (500, 'Gone with the Wind',240,1939);
insert into movies values (501,'Terminator 2',129,1991);
select * from movies;
-- -----------------------------------------------------------------------------
-- 24. Don't forget to commit;
commit;
-- -----------------------------------------------------------------------------
-- 25. CREATE ANOTHER TABLE with primary key at the bottom of the
--     create table statement
--     When you create a primary key at the end of the column list
--     it is known as an out-of-line constraint
create table actors 
(	  actor_id  number, 
    fname     varchar2(15 byte), 
    lname     varchar2(15 byte), 
    dob       date, 
primary key (actor_id));
-- -----------------------------------------------------------------------------
-- 26. Lets inset some actors
insert into actors values (1000, 'Vivian','Leigh', '01/JAN/1914'); 
insert into actors values (1001, 'Clark','Gable', '07/Aug/1913'); 
insert into actors values (1002, 'Arnold','Scwarznegger','12/SEP/1947');
insert into actors values (1003, 'Linda','Hamilton','17/Feb/1953');
select * from actors;
-- -----------------------------------------------------------------------------
-- 27. Most actors are in more than one movie
--     Most movies have more than one actor in it
--     So we need a way to hold the relationship of many to many
--     So we need something called a middle many-to-many table
-- -----------------------------------------------------------------------------
-- 28. The middle table will have two foreigh keys
--     1 foreigh key goew to movies
--     Another foreigh keys goes to actors
create table character_roles
( 
  role_id          number primary key,
  role_movie_id    number ,
  role_actor_id   number ,
  type_role        varchar2(40),
  constraint actors_fk foreign key (role_actor_id)
        references actors (actor_id),
  constraint movies_fk foreign key (role_movie_id)
        references movies (movie_id));
-- 29. Lets add the middle table entries
insert into character_roles values (2222,500,1000,'Lead');
insert into character_roles values (2223,500,1001,'Supporting');
insert into character_roles values(2224,501,1002, 'Co-Lead');
insert into character_roles values(2225,501,1003,'Lead');
select * from character_roles;
-- -----------------------------------------------------------------------------
-- 30. Don't forget to commit;
-- CLASS Discussion 
--      Parent
--      Child
--      Orphans
--          an order without someone to sned the bill to
--      How to create an Orphan
--      How to protect against creating Orphans
--      Foreign Keys
-- -----------------------------------------------------------------------------
-- 31. Add a primary key at the same time you create a table
--     Can you fix this syntax and run it?
create table character_roles
( 
  role_id       number primary key
  mid           number
  aid           number,):
-- -----------------------------------------------------------------------------
-- 32. How to modify an existing table. There is a whole chapter on how to fix an existing table
--     but for now we will just drop it, change what we need, and re-create it
--     Can you fix this syntax and run it?
drop table character_roles;
-- -----------------------------------------------------------------------------
-- 33. Commit saves the transactions performed since we started
commit;
-- -----------------------------------------------------------------------------
-- 34. Now lets test out orphan protection
--     delete a parent from the movie table
--     delete a parent from the actor table 
--     More in class
-- -----------------------------------------------------------------------------
-- 35. DATA TYPES
--     Class Exercises
--     If you are not in class please ask your SQL Class Buddy
-- -----------------------------------------------------------------------------

-- =============================================================================
-- CLASSROOM EXERCISE
-- --------------------------------------------------
-- I. Create 4 tables
-- --------------------------------------------------
-- I-1. ARTIST
--      artist_id, artist_name, lives_in_city, born_in_city
--      create a primary key
-- I-2. SONG
        song_id, artist_id, song_title, song_writer,song_length_seconds
--      create a primary key
-- I-3. TRACK_LIST
        track_list_id, album_id, song_id, song_sequence_on_album
--      create a primary key
-- I-4. ALBUM
        album_id, album_name, label, year_released
--      create a primary key
-- --------------------------------------------------
-- II. CREATE FOREIGN KEYS
--     Use the above examples to create foreinh keys
--     FK from SONG to ARTIST
--     FK from TRACK_LIST to SONG
--     FK from TRACK_LIST to ALBUM
-- ---------------------------------------------------
-- II. DATA INSERTION
-- ---------------------------------------------------
--    II-1 Artis is parent to song so must be inserted before song so no orphan songs
Begin
  insert into artist values(1,'Cher','Los Angeles California','El Centro California');
  insert into artist values(2,'Tom Jones','Los Angeles California','Treforest Wales');
  insert into artist values(3,'Van Morrison','Dalkey Ireland','Belfast United Kingdom');
end;
/
-- ---------------------------------------------------
--    II-2. SONG is parent to track_list so must be inserted before track-list so no orphans
create sequence seq_song;
begin
  Insert into song values (seq_song.nextval,1,'Believe','Brian Higgin',241);
  Insert into song values (seq_song.nextval,1,'If I Could Turn Back Time','Diane Warren',243);
  Insert into song values (seq_song.nextval,1,'Heart of Stone','Andy Hill',260);
  Insert into song values (seq_song.nextval,1,'Just Like Jesse James','Desmond Warren',247);
  Insert into song values (seq_song.nextval,1,'Save Up All Your Tears','Warren Child',240);
  Insert into song values (seq_song.nextval,1,'After All','Tom Snow',247);
  Insert into song values (seq_song.nextval,1,'I Found Someone','Michael Bolton',226);
  Insert into song values (seq_song.nextval,1,'One by One','Anthony Griffiths',246);
  Insert into song values (seq_song.nextval,1,'Strong Enough','Mark Taylor',223);
  Insert into song values (seq_song.nextval,1,'All or Nothing','Barry Taylor',240);
  Insert into song values (seq_song.nextval,1,'Song for the Lonely','Barry Taylor',209);
  Insert into song values (seq_song.nextval,1,'Take Me Home','Bob Esty',206);
  Insert into song values (seq_song.nextval,1,'The Shoop Shoop Song','Rudy Clark',173);
  Insert into song values (seq_song.nextval,1,'All I Really Want to Do','Bob Dylan',178);
  Insert into song values (seq_song.nextval,1,'Bang Bang My Baby Shot Me Down','Sonny Bono',234);
  Insert into song values (seq_song.nextval,1,'HalfBreed','Mary Dean',166);
  Insert into song values (seq_song.nextval,1,'Gypsys Tramps and Thieves','Bob Stone',158);
  Insert into song values (seq_song.nextval,1,'Dark Lady','Johnny Durrill',209);
  Insert into song values (seq_song.nextval,1,'The Beat Goes On','Bono',209);
  Insert into song values (seq_song.nextval,1,'I Got You Babe','Bono',189);
  Insert into song values (seq_song.nextval,1,'A Different Kind of Love Song','Johan Aberg',291);
  Insert into song values (seq_song.nextval,2,'Roll Me Away','Bob Seger',276);
  Insert into song values (seq_song.nextval,2,'Night Moves','Bob Seger',325);
  Insert into song values (seq_song.nextval,2,'Turn the Page','Bob Seger',301);
  Insert into song values (seq_song.nextval,2,'Youll Accompny Me','Bob Seger',239);
  Insert into song values (seq_song.nextval,2,'Hollywood Nights','Bob Seger',299);
  Insert into song values (seq_song.nextval,2,'Still the Same','Bob Seger',199);
  Insert into song values (seq_song.nextval,2,'Old Time Rock and Roll','George Jackson',192);
  Insert into song values (seq_song.nextval,2,'Weve Got Tonight','Bob Seger',278);
  Insert into song values (seq_song.nextval,2,'Against the Wind','Bob Seger',332);
  Insert into song values (seq_song.nextval,2,'Mainstreet','Bob Seger',222);
  Insert into song values (seq_song.nextval,2,'The Fire Inside','Bob Seger',353);
  Insert into song values (seq_song.nextval,2,'Like a Rock','Bob Seger',335);
  Insert into song values (seq_song.nextval,2,'Cest la Vie','Chuck Berry',178);
  Insert into song values (seq_song.nextval,2,'In Your Time','Bob Seger',185);
  Insert into song values (seq_song.nextval,3,'Bright Side of the Road','Van Morrison',225);
  Insert into song values (seq_song.nextval,3,'Gloria','Van Morrison',157);
  Insert into song values (seq_song.nextval,3,'Moondance','Van Morrison',271);
  Insert into song values (seq_song.nextval,3,'Baby Please Dont Go','Big Joe Williams',183);
  Insert into song values (seq_song.nextval,3,'Have I Told You Lately','Van Morrison',258);
  Insert into song values (seq_song.nextval,3,'Brown Eyed Girl','Van Morrison',183);
  Insert into song values (seq_song.nextval,3,'Sweet Thing','Van Morrison',262);
  Insert into song values (seq_song.nextval,3,'Warm Love','Van Morrison',201);
  Insert into song values (seq_song.nextval,3,'Wonderful Remark','Van Morrison',238);
  Insert into song values (seq_song.nextval,3,'Jackie Wilson Said','Van Morrison',177);
  Insert into song values (seq_song.nextval,3,'Full Force Gale','Van Morrison',192);
  Insert into song values (seq_song.nextval,3,'And It Stoned Me','Van Morrison',270);
  Insert into song values (seq_song.nextval,3,'Here Comes the Night','Bert Berns',166);
  Insert into song values (seq_song.nextval,3,'Domino','Van Morrison',188);
  Insert into song values (seq_song.nextval,3,'Did Ye Get Healed','Van Morrison',246);
  Insert into song values (seq_song.nextval,3,'Wild Night','Van Morrison',211);
  Insert into song values (seq_song.nextval,3,'Cleaning Windows','Van Morrison',282);
  Insert into song values (seq_song.nextval,3,'Whenever God Shines His Light','Cliff Richard',294);
  Insert into song values (seq_song.nextval,3,'Queen of the Slipstream','Van Morrison',293);
  Insert into song values (seq_song.nextval,3,'Dweller on the Threshold','Hugh Murphy',287);
end;
/
SELECT * FROM SONG;
-- ---------------------------------------------------
-- II-3. ALBUM
--    Parent to track_list so must be inserted before track_list rows so no orphanss
begin
  insert into album values (1,'Best Of Cher','Warner Brothers','2003');
  insert into album values (2,'Best of Tom Jones','Decca','1998');
  insert into album values (3,'Best of Van Morrison','ARIA','1990');
end;
/
SELECT * FROM ALBUM;
-- ---------------------------------------------------
-- 4. TRACK_LIST
--    Child to both SONG and ALBUM so must be inerted after both parent records inserted
begin
  Insert into track values (500, 1, 1, 1);
  Insert into track values (501, 1, 2, 2);
  Insert into track values (502, 1, 3, 3);
  Insert into track values (503, 1, 4, 4);
  Insert into track values (504, 1, 5, 5);
  Insert into track values (505, 1, 6, 6);
  Insert into track values (506, 1, 7, 7);
  Insert into track values (507, 1, 8, 8);
  Insert into track values (508, 1, 9, 9);
  Insert into track values (509, 1, 10, 10);
  Insert into track values (510, 1, 11, 11);
  Insert into track values (511, 1, 12, 12);
  Insert into track values (512, 1, 13, 13);
  Insert into track values (513, 1, 14, 14);
  Insert into track values (514, 1, 15, 15);
  Insert into track values (515, 1, 16, 16);
  Insert into track values (516, 1, 17, 17);
  Insert into track values (517, 1, 18, 18);
  Insert into track values (518, 1, 19, 19);
  Insert into track values (519, 1, 20, 20);
  Insert into track values (520, 1, 21, 21);
  Insert into track values (521, 2, 22, 1);
  Insert into track values (522, 2, 23, 2);
  Insert into track values (523, 2, 24, 3);
  Insert into track values (524, 2, 25, 4);
  Insert into track values (525, 2, 26, 5);
  Insert into track values (526, 2, 27, 6);
  Insert into track values (527, 2, 28, 7);
  Insert into track values (528, 2, 29, 8);
  Insert into track values (529, 2, 30, 9);
  Insert into track values (530, 2, 31, 10);
  Insert into track values (531, 2, 32, 11);
  Insert into track values (532, 2, 33, 12);
  Insert into track values (533, 2, 34, 13);
  Insert into track values (534, 2, 35, 14);
  Insert into track values (535, 3, 36, 1);
  Insert into track values (536, 3, 37, 2);
  Insert into track values (537, 3, 38, 3);
  Insert into track values (538, 3, 39, 4);
  Insert into track values (539, 3, 40, 5);
  Insert into track values (540, 3, 41, 6);
  Insert into track values (541, 3, 42, 7);
  Insert into track values (542, 3, 43, 8);
  Insert into track values (543, 3, 44, 9);
  Insert into track values (544, 3, 45, 10);
  Insert into track values (545, 3, 46, 11);
  Insert into track values (546, 3, 47, 12);
  Insert into track values (547, 3, 48, 13);
  Insert into track values (548, 3, 49, 14);
  Insert into track values (549, 3, 50, 15);
  Insert into track values (550, 3, 51, 16);
  Insert into track values (551, 3, 52, 17);
  Insert into track values (552, 3, 53, 18);
  Insert into track values (553, 3, 54, 19);
  Insert into track values (554, 3, 55, 20);
end;
/

-- -----------------------------------------------------------------------------
-- 36. TWO TABLE QUERIES
--     Guided Class Exercise
--     If you are not in class please ask your SQL Class Buddy
-- -----------------------------------------------------------------------------
create table cust
( custid    number,
  custname  varchar2(25)
);
create table ords
(oid    number,
 cid    number,
 sh_st  varchar2(2)
);


insert into cust values(5000,'Fred');
insert into cust values (5001,'Mary');
insert into cust values (5002,'Bennie');

insert into ords values (100,5000,'FL');
insert into ords values (101,5002,'FL');
insert into ords values (102,5002,'FL');

select * from cust;
select * from ords;

-- ------------------------------------------
select ship_cabin_id, ship_id, room_style, room_type, window
from ship_cabins;


select ship_cabin_id, room_style, room_type, window
from ship_cabins
where room_style = 'Stateroom'
 or room_type = 'Large'
 and window = 'Ocean';
 
select ship_cabin_id, room_style, room_type, window
from ship_cabins
where (room_style = 'Stateroom'
 or room_type = 'Large')
 and window = 'Ocean';
 
-- -----------------------------------------------
create table T
(abc   char);
insert into T values ('a');
insert into T values(1);
insert into T values ('abc');

create table T2
(abc varchar2(10));
insert into t2 values ('apple pie!');


create table T4
(abc   char(10),
 def   varchar2(10));
 
insert into T4 values ('apple','apple');
select * from t4;

select abc, def, length(abc),length(def)
from t4;

drop table T4;


create table T9
(one   number(5,2));

insert into t9 values (499.999);
insert into t9 values(999.999);
select one from t9;

insert into T values (.11);
insert into T values (11);
insert into T values (.96);
select * from T;
insert into T values (.99);

create table T2
(one   number(4,2));
insert into T2 values (11.99);
select * from t2;
insert into T2 values (111.99); -- does not work
insert into T2 values (9.999);
select * from T2;
insert into T2 values (99.996);
create table t3
(one number(6,2));
insert into T3 values (111.99);
select * from T3;
insert into T3 values(321.86);

insert into T3 values (3211.86);
insert into T3 values (9999.993);

create table T4
(one number(2));
insert into t4 values (4.56);
select * from T4;


CREATE TABLE test
(name VARCHAR2(10)
);
  
delete from test;  


  
INSERT INTO test VALUES('APPLE'); -- 1
INSERT INTO test VALUES('apple'); -- 2
INSERT INTO test VALUES('10');    -- 3
INSERT INTO test VALUES('1');     -- 4
INSERT INTO test VALUES('2');     -- 5
INSERT INTO test VALUES('.02');   -- 6
INSERT INTO test VALUES('Smyth'); -- 7
INSERT INTO test VALUES(' ');     -- 8
INSERT INTO test VALUES('Smith'); -- 9
INSERT INTO test values(null);   -- 10

select name
from test
order by name desc;


commit;

select count(*)
from test;

INSERT INTO test VALUES(NULL);

-- drop table
drop table cust;

-- Create tables
create table cust
(
 cust_id    integer primary key,
 fname      varchar2(25) not null,
 lname      varchar2(25) not null,
 gender     char(1) check (gender in ('M','F','m','f')),
 ssn        char(10) unique
);

-- drop table
drop table cust2;

-- Create tables
create table cust2
(
 cust_id    integer constraint cust2_pk primary key,
 fname      varchar2(25) constraint fn_nn not null,
 lname      varchar2(25) constraint ln_nn not null,
 gender     char(1) constraint gen_ck check (gender in ('M','F','m','f')),
 ssn        char(10) constraint ssn_u unique,
 status     varchar2(10) default 'Living',
 dateofenroll date default sysdate
);
select * from cust2;
insert into cust2(cust_id,fname,lname) values (111,'Billy','Buckets');

-- drop table
drop table cust3;

-- Create tables
create table cust3
(
 cust_id    integer,
 fname      varchar2(25) constraint fn_nn3 not null,
 lname      varchar2(25) constraint ln_nn3 not null,
 gender     char(1),
 ssn        char(10),
 status     varchar2(10) default 'Living',
 dateofenroll date default sysdate,
       constraint cust3_pk primary key(cust_id),
       constraint gen_ck3 check (gender in ('M','F','m','f')),
       constraint ssn_u3 unique(ssn)
);

drop table cust4;
create table cust4
(
 cust_id    integer,
 fname      varchar2(25),
 lname      varchar2(25),
 gender     char(1),
 ssn        char(10),
 status     varchar2(10),
 dateofenroll date
);

alter table cust4 add primary key(cust_id);
alter table cust4 add constraint c_pk4 primary key(cust_id);

alter table cust4 modify fname not null;
alter table cust4 modify lname constraint ln_nn4 not null;

-- ----------------------------------------------------------
create table cust
(cid  integer primary key,
 name varchar2(10),
 state char(2)
);

insert into cust values (10, 'Betty', 'TX');
insert into cust values (11, 'Barney','MA');

create table ords
(
  oid integer primary key,
  cid integer,
  amt integer
);

-- Ask a question that requires 2 tables
-- Need a foreign key to protect "referential integrity"
-- Referential integrity: prevent orphans
--     Orphan is a child record without a parent record
--     Ex: Prevent an order that does not have a customer to be billed
-- Cust is the parent
-- Ords is the child
delete ords;
alter table ords add foreign key (cid)
       references cust(cid);
-- Now cannot add ords unless it has an existing
-- parent record in cust
insert into ords values (512,10,12);
insert into ords values (513,11,99);
insert into ords values (514,10,150);
select * from cust;
select * from ords;
commit;

-- list all of Barney's orders
select cust.cid, name, oid, amt
from cust, ords
where name = 'Betty'
  and cust.cid = ords.cid;



