drop table musician cascade constraints;
drop table cd cascade constraints;
drop table hit cascade constraints;
drop table cdtrack cascade constraints;
-- --------------------------------------------------
-- 1. Login to SQL Developer as Books
-- --------------------------------------------------
-- 2. create arttist table this is a parent to cd
create table musician (
  musician_id     number primary key,
  musician_name   varchar2(128),
  city          varchar2(75),
  country       varchar2(75)
);
-- --------------------------------------------------
-- 3. create table cd this is a child to musician
-- and a parent to cdtrack
create table CD (
  cd_id       number primary key,
  artist_id   number,
  title       varchar2(100),
    constraint cdfk foreign key (artist_id) references musician(musician_id)
);  
-- --------------------------------------------------
-- 4. create table hit which is a parent to cdtrack
create table hit (
  song_id       number primary key,
  name         varchar2(128)
 );
-- --------------------------------------------------
-- 5. create table cdtrack
-- this is a child with two parents (1) cd and (2) hit
create table cdtrack (
  cdid          number,
  songid       number,
  sequence#   number,
      constraint cdpk primary key (cdid, songid),
      constraint songfk foreign key (songid) references hit(song_id),
      constraint albumfk foreign key (cdid) references cd(cd_id)
);
-- --------------------------------------------------  
--    Because there is a parent child relationship between musician(parent) and cd(child)
-- 6. You must add the parent(musician) records first
insert into musician values (1,'Kelly Clarkson','Burleson','USA');
insert into musician values (2,'Mariah Carey','Long Island','USA');

-- --------------------------------------------------
--    Because there is a parent child relationship between cd(parent) and cdtrack(child)
-- 7. You must add the parent(cd) records first
insert into cd values (100,1,'Greatest Hits');
insert into cd values (200,2,'Glitter');
-- --------------------------------------------------
--    Because there is also a parent child relationship between hit(parent) and cdtrack(child)
-- 8. then add the parent(hit) rows for that child(cdtrack)
insert into hit values (1,'Since U Been Gone');
insert into hit values (2,'My Life Would Suck Without You');
insert into hit values (3,'Miss Independent');
insert into hit values (4,'Stronger What Doesnt Kill You');
insert into hit values (5,'Behind These Hazel Eyes');
insert into hit values (6,'Because Of You');
insert into hit values (7,'Never Again');
insert into hit values (8,'Already Gone');
insert into hit values (9,'Mr Know It All');
insert into hit values (10,'Breakaway');
insert into hit values (11,'Dont You Wanna Stay');
insert into hit values (12,'Catch My Breath');
-- -------------------------------------------------------
insert into hit values (13,'Loverboy');
insert into hit values (14,'Lead the Way');
insert into hit values (15,'If We');
insert into hit values (16,'I Didnt Mean to Turn You On');
insert into hit values (17,'Dont Stop');
insert into hit values (18,'All My Life');
insert into hit values (19,'Reflections');
insert into hit values (20,'Last Night a DJ Saved My Life');
insert into hit values (21,'Want You');
insert into hit values (22,'Never Too Far');
insert into hit values (23,'Twister');
-- --------------------------------------------------
--    cdtrack is a child with two parents CD(parent) and hit(parent)
--    We already added both these parents 
-- 9. Now we need to add the children 
insert into cdtrack values (100,1,1);
insert into cdtrack values (100,2,2);
insert into cdtrack values (100,3,3);
insert into cdtrack values (100,4,4);
insert into cdtrack values (100,5,5);
insert into cdtrack values (100,6,6);
insert into cdtrack values (100,7,7);
insert into cdtrack values (100,8,8);
insert into cdtrack values (100,9,9);
insert into cdtrack values (100,10,10);
insert into cdtrack values (100,11,11);
insert into cdtrack values (100,12,12);
-- ----------------------------------
insert into cdtrack values (200,13,1);
insert into cdtrack values (200,14,2);
insert into cdtrack values (200,15,3);
insert into cdtrack values (200,16,4);
insert into cdtrack values (200,17,5);
insert into cdtrack values (200,18,6);
insert into cdtrack values (200,19,7);
insert into cdtrack values (200,20,8);
insert into cdtrack values (200,21,9);
insert into cdtrack values (200,22,10);
insert into cdtrack values (200,23,11);
Commit;
-- --------------------------------------------------
-- 10. Last add the track(child) rows last
select m.musician_name as star, c.title as cd, h.name as song, m.musician_id,cdt.cdid, cdt.songid,cdt.sequence#  
from  musician m
    , cd c 
    , cdtrack cdt
    , hit h
where 1=1
 and m.musician_id = c.artist_id
 and c.cd_id = cdt.cdid
 and cdt.songid = h.song_id; 
 
select 
    (select count(*) from musician) musician,
    (select count(*) from hit) hit,
    (select count(*) from cdtrack) cdtrack,
    (select count(*) from cd) cd
from dual;