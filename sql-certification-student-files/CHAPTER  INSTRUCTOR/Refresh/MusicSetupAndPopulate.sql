drop table albums cascade constraints;
create table albums
(   album_id  integer primary key
,   album_title varchar2(100)
,   production_company varchar2(100)
,   year_released char(4)
,   cover blob); 
select * from albums;


drop table artists cascade constraints;
create table artists
(   artist_id   integer primary key
,   artist_name varchar2(100)
,   lives_in_city varchar2(100)
,   born_in_city varchar2(100)
,   photo blob);

drop table songs cascade constraints;
create table songs
(
    song_id  integer primary key
,   artist_id integer references artists(artist_id)
,   song_title    varchar2(100)
,   song_writer varchar2(100)
,   length_seconds number(5)
);
drop table tracks cascade constraints;
create table tracks
(
    track_id integer primary key
,   album_id integer references albums(album_id)
,   song_id integer references songs(song_id)
,   song_sequence_on_album integer);


create or replace directory PHOTO_DIR as 'c:\photos';

execute load_file(1,'bestofcher.jpg');
execute load_file(2,'bestoftomjones.jpg');
execute load_file(3,'bestofvanmorrison.jpg');
execute load_file(4,'clone.jpg');



create or replace procedure load_album_photo (
    p_id number,
    p_photo_name in varchar2
    ) IS
        src_file bfile;
        dst_file blob;
        lgh_file binary_integer;
begin
      src_file := bfilename('PHOTO_DIR', p_photo_name);

      -- insert a NULL record to lock
      insert into temp_photo (id, photo_name, photo)
      values (p_id , p_photo_name ,empty_blob())
      returning photo into dst_file;

      -- lock record
      select photo 
      into dst_file
      from temp_photo
      where id = p_id
      and photo_name = p_photo_name
      for update;

      -- open the file
      dbms_lob.fileopen(src_file, dbms_lob.file_readonly);

      -- determine length
      lgh_file := dbms_lob.getlength(src_file);

      -- read the file
      dbms_lob.loadfromfile(dst_file, src_file, lgh_file);

      -- update the blob field
      update albums 
      set photo = dst_file
      where id = p_id;
      -- and photo_name = p_photo_name;
      -- close file
      dbms_lob.fileclose(src_file); 
end load_file;