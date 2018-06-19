drop user music cascade;
create user music identified by music;

grant all privileges to music;

create table albums
( album_id integer,
  album_title  varchar2(50), 
  production_company varchar2(50),
  year_release  integer);
  
create table artists
( artist integer,
  artist_name  varchar2(50), 
  lives_in_city varchar2(50),
  born_in_city  integer); 

create table songs
( song_id integer,
  artist_id  integer,
  song_title  varchar2(50),
  song _writer varchar2(50),
  length_in_seconds  integer); 

create table tracks
(
  track_id integer,
  album_id integer,
  song_id integer,
  song_sequence_on_album integer);


  