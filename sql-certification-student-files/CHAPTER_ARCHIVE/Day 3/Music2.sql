-- -----------------------------------------------------
-- ORDER OF CREATION/INSERTION
-- Parent/Child rule (aka Referential Integrity Rule)
--   There can never be orphans
--      a. Cannot create a child without a parent
--      b. Cannot delete a parent with a child
--   1 Band may have many artists
--   1 Band may have many songs
--   1 Song may be on many albums
--   1 Album may have many songs 
-- -----------------------------------------------------
-- Therefore
--    1. Create the Parent table first (so child table field can reference the parent field)
--    2. Insert the Parent records first (so the child row can reference the parent row)
-- -----------------------------------------------------
-- BANDS WILL BE 
--     THE PARENT OF ARTISTS, and
--     THE PARENT OF SONGS, and
-- drop table bands cascade constraints;
create table bands 
(	band_id integer primary key, 
  band_name varchar2(128),
  agent varchar2(128));

-- ARTISTS ARE THE CHILDREN OF BANDS
-- drop table artists cascade constraints;
create table artists 
(	artist_id integer primary key, 
	bid integer,
  artist_name varchar2(128 byte), 
	birth_city varchar2(75 byte), 
	residence varchar2(75 byte), 
	birth_year integer);
alter table artists add foreign key(bid) references bands(band_id);

-- SONGS ARE THE CHILDREN OF BANDS, and
-- PARENT OF TRACKS
-- drop table songs cascade constraints;
create table songs 
(	song_id integer primary key, 
  bid integer,
  title varchar2(128),
  composer varchar2(128),
  genre varchar2(128),
  year_released integer);
alter table songs add foreign key(bid) references bands(band_id);

-- ALBUMS ARE PARENT OF TRACKS
-- drop table albums cascade constraints;
create table albums 
(	album_id integer primary key, 
  title varchar2(128),
  year_released integer,
  label varchar2(128));

-- TRACKS ARE CHILDREN OF BOTH SONGS AND ALBUMS
-- drop table tracks cascade constraints;
create table tracks 
(	track_id integer primary key, 
  aid integer,
  sid integer,
  side integer,
  sequence_number integer,
  length_seconds integer);
alter table tracks add foreign key(aid) references albums(album_id);
alter table tracks add foreign key(sid) references songs(song_id);
  