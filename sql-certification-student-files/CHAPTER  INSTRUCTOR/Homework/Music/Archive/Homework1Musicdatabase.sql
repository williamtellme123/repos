-- Log into your own schema
-- --------------------------------------------------
-- TABLE CREATION MUST CREATE PARENT(S) BEFORE CHILDREN
-- 1. ARTIST (parent to Song)
-- 2. SONG (parent to Track)
-- 3. ALBUM (parent to Track)
-- 4. TRACK (child to Song and Album)
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
-- --------------------------------------------------
-- 2. SONG
drop table song;
create table song (
  song_id               number primary key,
  artist_id             number,
  song_title            varchar2(75),
  song_writer           varchar2(75),
  song_length_seconds   number,
  constraint song_artist_fk 
  foreign key (artist_id) 
  references artist (artist_id)
);
-- --------------------------------------------------
-- 3. ALBUM
drop table album;
create table album
(album_id               number primary key,
 album_name                   varchar2(35),
 label                  varchar2(25),
 year_released          varchar(4));
 -- --------------------------------------------------
-- 4. TRACK
drop table track;
create table track
(track_id               number primary key,
 album_id               number,
 song_id                number,
 song_sequence_on_album number,
 constraint track_song_fk
   foreign key (song_id)
   references song(song_id),
 constraint track_album_fk
   foreign key (album_id)
   references album(album_id)
 );
-- --------------------------------------------------
-- DATA INSERTION FOLLOWS SAME ORDER AS TABLE CREATION
-- 1. ARTIST (parent to song)
-- 2. SONG (parent to Track)
-- 3. ALBUM (parent to Track)
-- 4. TRACK (child to Song and Album)
-- ---------------------------------------------------
-- 1. ARTIST
--    Parent to song so must be inserted before song so no orphan songs
delete table artist; 
  insert into artist values(1,'Cher','Los Angeles California','El Centro California');
  insert into artist values(2,'Tom Jones','Los Angeles California','Treforest Wales');
  insert into artist values(3,'Van Morrison','Dalkey Ireland','Belfast United Kingdom');
-- confirm the insertions
select * from artist;

-- ---------------------------------------------------
-- 2. SONG
--    Parent to track so must be inserted before track so no orphan tracks
-- NOTE:
--    a sequuence is a counting object
--    can be named anything but typically named for the table it is used with
--    you create it first:
-- 
--    create sequence my_sequence_name;
-- 
--    then use it instead of a value in the insert statement
--    as you see below use it like this: seq_song.nextval
--    in the first row it will give a "1"
--    in the next row it will give a "2"
--    in the next row will give a "3" and so on
drop sequence seq_song;
create sequence seq_song;

delete from song;
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
-- Confirm the insertions
SELECT * FROM SONG;
-- ---------------------------------------------------
-- 3. ALBUM
--    Parent to track so must be inserted before track so no orphan tracks
  insert into album values (1,'Best Of Cher','Warner Brothers','2003');
  insert into album values (2,'Best of Tom Jones','Decca','1998');
  insert into album values (3,'Best of Van Morrison','ARIA','1990');
-- Confirm the insertions
SELECT * FROM album;
-- ---------------------------------------------------
-- 4. TRACK
--    Child to both SONG and ALBUM so must be inerted after both parent records inserted
delete from track;
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
-- confirm the assertions
select * from track;
