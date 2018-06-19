-- -----------------------------------------------------------------------------
-- E X T E R N A L T A B L E      C S V 
-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------
-- 1. First physically create the directory c:\temp
-- -----------------------------------------------------------------------------
-- 2. Then login as system and do:
-- A. CREATE OR REPLACE DIRECTORY TMP AS 'C:\temp';
CREATE OR REPLACE DIRECTORY TMP AS   'C:\temp';
-- B. GRANT READ, WRITE ON DIRECTORY TMP TO CRUISES;
GRANT READ, WRITE ON DIRECTORY TMP TO SAMPLECODE;
-- -----------------------------------------------------------------------------
-- 3
drop table artists;
CREATE TABLE artists
  (aid      NUMBER,
   name      VARCHAR2(175),
   birth_city     VARCHAR2(175),
   city_residence     VARCHAR2(175),
   birth_year    NUMBER)
ORGANIZATION EXTERNAL
(
    TYPE ORACLE_LOADER
    DEFAULT DIRECTORY TMP
    ACCESS PARAMETERS
    (RECORDS DELIMITED BY NEWLINE
    FIELDS TERMINATED BY ","
    OPTIONALLY ENCLOSED BY '"'
    MISSING FIELD VALUES ARE NULL
    REJECT ROWS WITH ALL NULL FIELDS
      ( aid,
        name,
        birth_city,
        city_residence,
        birth_year
      )
    )
  LOCATION ('artists.csv')
)
REJECT LIMIT UNLIMITED;
select * from artists;-- 3. Create the external table
-- 4. SONGS
drop table songs;
CREATE TABLE songs
  (song_id      NUMBER,
   artist_id      number,
   title  VARCHAR2(175),
   written_by     VARCHAR2(175),
   Genre     VARCHAR2(175),
   Year_Released NUMBER,
   length_seconds number)
ORGANIZATION EXTERNAL
(
    TYPE ORACLE_LOADER
    DEFAULT DIRECTORY TMP
    ACCESS PARAMETERS
    (RECORDS DELIMITED BY NEWLINE
    FIELDS TERMINATED BY ","
    OPTIONALLY ENCLOSED BY '"'
    MISSING FIELD VALUES ARE NULL
    REJECT ROWS WITH ALL NULL FIELDS
      ( song_id,
       artist_id,
       title,
       written_by,
       Genre,
       Year_Released,
       length_seconds
      )
    )
  LOCATION ('songs.csv')
)
REJECT LIMIT UNLIMITED;
select * from songs;

-- 4. ALBUMS
drop table albums;
CREATE TABLE albums
  (album_id      NUMBER,
   title      VARCHAR2(175),
   year_released  VARCHAR2(175),
   label     VARCHAR2(175)
   )
ORGANIZATION EXTERNAL
(
    TYPE ORACLE_LOADER
    DEFAULT DIRECTORY TMP
    ACCESS PARAMETERS
    (RECORDS DELIMITED BY NEWLINE
    FIELDS TERMINATED BY ","
    OPTIONALLY ENCLOSED BY '"'
    MISSING FIELD VALUES ARE NULL
    REJECT ROWS WITH ALL NULL FIELDS
      ( album_id,
       title,
       year_released,
       label
      )
    )
  LOCATION ('albums.csv')
)
REJECT LIMIT UNLIMITED;
select * from albums;
-- 5. TRACKS
drop table tracks;
CREATE TABLE tracks
  (track_id      NUMBER,
   album_id      number,
   song_id  number,
   sequence_number number)
ORGANIZATION EXTERNAL
(
    TYPE ORACLE_LOADER
    DEFAULT DIRECTORY TMP
    ACCESS PARAMETERS
    (RECORDS DELIMITED BY NEWLINE
    FIELDS TERMINATED BY ","
    OPTIONALLY ENCLOSED BY '"'
    MISSING FIELD VALUES ARE NULL
    REJECT ROWS WITH ALL NULL FIELDS
      ( track_id,
       album_id,
       song_id,
       sequence_number
      )
    )
  LOCATION ('tracks.csv')
)
REJECT LIMIT UNLIMITED;
select * from tracks;