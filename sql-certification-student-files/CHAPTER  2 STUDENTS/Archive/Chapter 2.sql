-- -----------------------------------------------------------------------------
-- 1. Chapter 1 and a look ahead
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
-- -----------------------------
-- AT WORK TIP NO. 1
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
select CUSTOMER#, firstname,LastName, STAate from 
CUSTOMERS
WHERE 
STATE 'FL';
-- -----------------------------
-- c. What about this?
select CUSTOMER#, firstname,LastName, STAate
from CUSTOMERS
WHERE STATE 'Floria';
-- ----------------------------- 
-- d. What about this?
select CUSTOMER#, firstname,LastName, STAate from CUSTOMERS WHERE STATE 'Fl';
-- -----------------------------
-- e. What about this? It sounds like a quesation in English
select customer#, firstname,lastname, state
from customers
where state = 'FL' or 'TX';
-- -----------------------------------------------------------------------------
-- 6. WHERE CLAUSE a little more. You can ask more than one question in a 
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
select * from ship_cabins;
-- d. How many rows? Hoiw many columns?
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
-- 7. Builing tables
--    We want to create a new schema to practice in.
--    To do that we: 
--       a. use System user
--       b. create a user with a password
--       c. grant the user all privileges
--
--    Click the connection drop down top right, choose System, execute following commands
create user billy identified by billy;
grant all privileges to billy;
--    Now in the left pane of SQL developer add a new connection
--            Connection Name: billy
--                  User Name: billy
--                   Password: billy
--    Now open the connection
-- -----------------------------------------------------------------------------
-- 8. Create our first table
create table movies
( 
  movie_id    number,
  title       varchar2(25),
  length_mins number,
  year        number
);
-- -----------------------------------------------------------------------------
-- 9. Add a primary key after you create your first table
alter table movies add constraint movies_pk primary key (movie_id);
-- Discussion 
--      Parent
--      Child
--      Orphans
--          an order without someone to sned the bill to
--      How to create an Orphan
--      How to protect against creating Orphans
--      Foreign Keys
-- -----------------------------------------------------------------------------
-- 10. Add a primary key at the same time you create a table
--     Can you fix this syntax and run it?
create table character_roles
( 
  role_id       number primary key
  mid           number
  aid           number,):
  
-- -----------------------------------------------------------------------------
-- 11. How to fix a table. There is a whole chapter on how to fix an existing table
--     but for now we will just drop it, change what we need, and re-create it
--     Can you fix this syntax and run it?
drop table character_roles;
-- -----------------------------------------------------------------------------
-- 12. Now lets make some changes to this table before we create it again.
--     We need to make two columns: mid and aid "unique". This is another constraint
--     type. We could create the table and add the constraint later but here
--     we add the constraint at the same time we create the table
--
--     after mid number add the word unique
--     after aid number add the word unique
create table character_roles
( 
  role_id       number primary key,
  mid           number unique,
  aid           number unique);
-- -----------------------------------------------------------------------------
-- 13. Now we are going to You can create a table that contains a foreign key
--     at the time of creation
create table actors
(
  actor_id    number primary key,
  mid         number,
  fname       varchar2(15),
  lname       varchar2(15),
  dob         date,
  constraint actors_fk foreign key (actor_id)
  references character_roles (aid)
);

-- -----------------------------------------------------------------------------
-- 14. Now we insert a few movies
insert into movies values (500, 'Gone with the Wind',240,1939);
insert into movies values (501,'Terminator 2',129,1991);

-- -----------------------------------------------------------------------------
-- 15. Now we insert a few actors
insert into actors values(1000,500, 'Vivian','Leigh', '01/JAN/1914'); 
insert into actors values(1001,500, 'Clark','Gable', '07/Aug/1913'); 
insert into actors values (1002,501,'Arnold','Scwarznegger','12/SEP/1947');
insert into actors values (1003,501,'Linda','Hamilton','17/Feb/1953');
select * from actors;

commit;

-- try a select statement that uses  both tables
select fname,lname,title
from movies,actors
where movie_id = mid;

-- insert into the middle table
delete from roles;
insert into roles values (5000,500,1000);
insert into roles values (5001,500,1001);
insert into roles values(5002,501,1002);
insert into roles values(5003,501,1003);
select * from roles;



-- session 2
drop table testnum;
create table testnum
( one   number(2,3));

insert into testnum values(100000000000000000);
insert into testnum values(99);

insert into testnum values(99.8);
insert into testnum values(123.45);
insert into testnum values(123.45);
insert into testnum values(456.436);
insert into testnum values(999.9996);

insert into testnum values (999);
insert into testnum values(999.99);

insert into testnum values(999.99);
-- ( one   number(2,3));
insert into testnum values (.0123456);
insert into testnum values (.01);

insert into testnum values (.0146);
insert into testnum values (.0994);

select * from testnum;
drop table testnum;
create table testnum
( one   number(5,-2));


insert into testnum values (0.5);
insert into testnum values (1999.5);
select * from testnum;

select *
from orderitems;

select * from cust;

insert into cust (custid, custname)
select pubid, title from books;






create user music1 identified by music1;
grant all privileges to music1;
-- --------------------------------------------------
-- CLEANUP FOLLOWS REVERSE ORDER AS TABLE CREATION
-- ---------------------------------------------------
-- 1. TRACK
-- 2. ALBUM
-- 3. SONG
-- 4. ARTIST
--Drop table track;
--drop table album;
--drop table song;
--drop table artist;
-- --------------------------------------------------
-- TABLE CREATION MUST CREATE PARENT(S) BEFORE CHILDREN
-- 1. ARTIST
-- 2. SONG
-- 3. ALBUM
-- 4. TRACK
-- --------------------------------------------------
-- 1. ARTIST
drop table artist;
create table artist (
  artist_id             number,
  artist_name           varchar2(128),
  lives_in_city         varchar2(75),
  born_in_city          varchar2(75),
  constraint artist_pk primary key (artist_id)
 );
alter table artist add constraint artist_pk primary key (artist_id);

drop table artist;
create table artist (
  artist_id             number constraint artist_pk primary key,
  artist_name           varchar2(128),
  lives_in_city         varchar2(75),
  born_in_city          varchar2(75)  
 );
 alter table artist modify (lives_in_city varchar2(125));
-- Four  ways to create a table with a primary key
-- 1. Create the table first without the PK
--    Then use alter table to add the primary key
-- 2. Create table with out-of-line constraint code
--    This allowed us to add and name constraint at same time
-- 3. Create unamed primary key with in-line syntax
-- 4. Create named in-line primary key

-- --------------------------------------------------
-- 2. SONG
drop table song;
create table song (
  song_id               number primary key,
  artist_id             number,
  song_title            varchar2(75),
  song_writer           varchar2(75),
  song_length_seconds   number,
  constraint song_artist_fk  foreign key (artist_id) 
  references artist (artist_id)
);
-- --------------------------------------------------
-- 3. ALBUM
drop table album;
create table album
(album_id               number primary key,
 album_name             varchar2(35),
 label                  varchar2(25),
 year_released          varchar2(4));
 -- --------------------------------------------------
-- 4. TRACK
drop table track;
create table track
(track_id               number primary key, 
 album_id               number,
 song_id                number,
 song_sequence_on_album number,
 constraint track_song_fk foreign key (song_id) references song (song_id),
 constraint track_album_fk foreign key (album_id) references album (album_id)
 );
-- --------------------------------------------------
-- DATA INSERTION FOLLOWS SAME ORDER AS TABLE CREATION
-- 1. ARTIST
-- 2. SONG
-- 3. ALBUM
-- 4. TRACK
-- ---------------------------------------------------
-- 1. ARTIST
--    Parent to song so must be inserted before song so no orphan songs
delete  artist; 
Begin
  insert into artist values(1,'Cher','Los Angeles California','El Centro California');
  insert into artist values(2,'Tom Jones','Los Angeles California','Treforest Wales');
  insert into artist values(3,'Van Morrison','Dalkey Ireland','Belfast United Kingdom');
end;
/
-- ---------------------------------------------------
-- 2. SONG
--    Parent to track so must be inserted before track so no orphan tracks
truncate table song;
delete song;
drop sequence seq_song;
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
-- 3. ALBUM
--    Parent to track so must be inserted before track so no orphan tracks
begin
  insert into album values (1,'Best Of Cher','Warner Brothers','2003');
  insert into album values (2,'Best of Tom Jones','Decca','1998');
  insert into album values (3,'Best of Van Morrison','ARIA','1990');
end;
/
-- ---------------------------------------------------
-- 4. TRACK
--    Child to both SONG and ALBUM so must be inerted after both parent records inserted
--(track_id               number primary key,
-- album_id               number,
-- song_id                number,
-- song_sequence_on_album number,
truncate table track;
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

create table cust
( custid    number,
  custname  varchar2(25)
);
create table ords
(oid    number,
 cid    number,
 sh_st  varchar2(2)
);
delete cust;
delete ords;

-- add a omment
select * from cust;
insert into cust values(5000,'Fred');
insert into cust values (5001,'Mary');
insert into cust values (5002,'Bennie');

insert into ords values (100,5000,'FL');
insert into ords values (101,5002,'FL');
insert into ords values (102,5002,'FL');
select * from cust;
select * from ords;
commit;

select *
from cust,ords
where custid = cid;

-- rows 20 
-- columns 8
select * 
from customers;

select * 
from customers c, orders o
where c.customer# = o.customer#;

-- rows 21 
-- columns 8
select * 
from orders;

-- rows 32
-- columns 4
select * 
from orderitems;

-- rows 14
-- columns 7
select * 
from books;

-- 188160
-- select 20 *21 * 32 * 14 from dual;
select *
from customers, orders, orderitems, books;

select firstname, lastname, title
from customers c, orders o, orderitems oi, books b
where c.customer# = o.customer#
 and o.order# = oi.order#
 and oi.isbn = b.isbn
and firstname = 'BONITA'
  and lastname = 'MORALES';


desc customers;

select *
from orderitems;

select * 
from cust;

delete from cust;
delete cust;

select *
from ords;

delete from ords 
where oid = 100;
rollback;

select * from cust;
select * from ords;

select * from ords;
delete from ords
where oid = 100;

delete from ords;
delete from cust;
commit;

create table cust
( custid    number,
  custname  varchar2(25)
);
-- simplest form of insert has no column names
-- requires the samwe num of values as fields in the table
-- and in the same order as the table definition
insert into cust values (1000,'Fred');
insert into cust values (1000,null);

select * from cust;

insert into cust values (1001,' ');

-- second type is to use the comnplete list of columns
-- must in parenthesis and requires the same order
-- and type of values as the columns listed.
insert into cust (custid,custname) values (1004,'Ted');
insert into cust (custname, custid) values ('Ted',1006);

-- third type of insert is to use a subset of column names
-- but the values must match in number and type and order
-- as the columns listed
insert into cust (custid) values (1005);
select * from cust;

insert into cust (custid) values ('1005');
commit;

select * from cruises;
desc cruises;
insert into cruises vALUES (100,5,'Hawaii', 2,3,'01-JUN-13', '01-JUN-13','Dock');

select max(cruise_id) from cruises;

create sequence seq_cruise_id start with 101;
insert into cruises vALUES (seq_cruise_id.nextval,5,'BAHAMAS', 2,3,'06-JUN-13', '06-JUN-13','Dock');

select * from cruises;























