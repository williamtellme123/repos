-- 1. Login to SQL Developer as Books

-- 2. Drop each table 
drop table artist cascade constraints;
drop table song cascade constraints;
drop table album cascade constraints;
drop table track cascade constraints;

-- 3. create arttist table
create table artist (
  artist_id     number primary key,
  artist_name   varchar2(128),
  city          varchar2(75),
  country       varchar2(75)
);

-- 4. create table song
create table song (
  song_id       number primary key,
  artist_id     number,
  title         varchar2(128),
  constraint artist_fk foreign key (artist_id) references artist(artist_id)
);

-- 5. create table album
create table album (
  album_id      number primary key,
  title         varchar2(100)
);  

-- 6. create table track
create table track (
  track_id      number primary key,
  album_id      number,
  song_id       number,
  sequence_id   number,
    constraint song_fk foreign key (song_id) references song(song_id),
    constraint album_fk foreign key (album_id) references album(album_id)
);
  
--    Because there is a parent child relationship between artist(parent) and song(child)
-- 7. You must add the parent(artist) records first
insert into artist values (1,'Kelly Clarkson','Burleson','USA');
insert into artist values (2,'Mariah Carey','Long Island','USA');

-- 8. then add the child(song) rows for that parent(artist)
insert into song values (1,1,'Since U Been Gone');
insert into song values (2,1,'My Life Would Suck Without You');
insert into song values (3,1,'Miss Independent');
insert into song values (4,1,'Stronger What Doesnt Kill You');
insert into song values (5,1,'Behind These Hazel Eyes');
insert into song values (6,1,'Because Of You');
insert into song values (7,1,'Never Again');
insert into song values (8,1,'Already Gone');
insert into song values (9,1,'Mr Know It All');
insert into song values (10,1,'Breakaway');
insert into song values (11,1,'Dont You Wanna Stay');
insert into song values (12,1,'Catch My Breath');
-- -------------------------------------------------------
insert into song values (13,2,'Loverboy');
insert into song values (14,2,'Lead the Way');
insert into song values (15,2,'If We');
insert into song values (16,2,'I Didnt Mean to Turn You On');
insert into song values (17,2,'Dont Stop');
insert into song values (18,2,'All My Life');
insert into song values (19,2,'Reflections');
insert into song values (20,2,'Last Night a DJ Saved My Life');
insert into song values (21,2,'Want You');
insert into song values (22,2,'Never Too Far');
insert into song values (23,2,'Twister');

--    Track is a child with two parents song(parent) and album(parent)
--    We already added one of these parents song
-- 9. Now we need to add the second parent album row
insert into album values (1,'Greatest Hits');
insert into album values (2,'Glitter');

-- 10. Last add the track(child) rows. each of these require 
-- two parents (1) album_id and (2) song_id
insert into track values (1,1,1,1);
insert into track values (2,1,2,2);
insert into track values (3,1,3,3);
insert into track values (4,1,4,4);
insert into track values (5,1,5,5);
insert into track values (6,1,6,6);
insert into track values (7,1,7,7);
insert into track values (8,1,8,8);
insert into track values (9,1,9,9);
insert into track values (10,1,10,10);
insert into track values (11,1,11,11);
insert into track values (12,1,12,12);
-- ----------------------------------
insert into track values (13,2,13,1);
insert into track values (14,2,14,2);
insert into track values (15,2,15,3);
insert into track values (16,2,16,4);
insert into track values (17,2,17,5);
insert into track values (18,2,18,6);
insert into track values (19,2,19,7);
insert into track values (20,2,20,8);
insert into track values (21,2,21,9);
insert into track values (22,2,22,10);
insert into track values (23,2,23,11);
Commit;

-- 11. Last add the track(child) rows last
select artist_name as artist, al.title as album, s.title as song, s.artist_id,t.track_id, t.album_id,t.song_id,t.sequence_id
from  artist a
    , song s 
    , track t
    , album al
where 1=1
 and a.artist_id = s.artist_id
 and s.song_id = t.song_id
 and t.album_id = al.album_id;
 
select 
    (select count(*) from artist) artist,
    (select count(*) from song) song,
    (select count(*) from track) track,
    (select count(*) from album) album
from dual;