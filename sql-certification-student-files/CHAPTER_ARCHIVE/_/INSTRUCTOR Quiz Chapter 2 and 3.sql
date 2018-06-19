create table artist
(
    artist_id  integer primary key,
    AName        varchar2(75),
    residence   varchar2(75),
    birthplace varchar2(75)
);
drop table songs;
create table songs
(
    song_id     integer primary key,
    artistid    integer,  
    title       varchar2(100),
    writer      varchar2(75),
    s_length    integer,
    constraint a_fk foreign key(artistid) references artist (artist_id)
);    


-- IF FK THEN RULE IS NOT ORPHANS
-- CHILD RECORD WITHOUT A PARENT
-- Parent is the Artist
-- Child is the song(s)
insert into artist values (100,'Cher','Los Angeles CA','El Centro California');
insert into artist values (101,'Van Morrison','Dalkey Ireland','Belfast UK');

insert into songs values (50, 100,'Gypsies Tramps and Thieves','Bob Stone',158);
insert into songs values (51, 100,'I Got You Babe','Bono',189);
insert into songs values (52, 101,'Brown Eyed Girl','Van Morrison',183);
insert into songs values (53, 101,'Moon Dance','Van Morrison',271);

-- CTAS
drop table quiz2;
create table quiz2
as select * from books.customers;
commit;

--6
update quiz2
set lastnaME = 'SMITH' where firstname = 'BONITA';
select * from quiz2 where firstname = 'BONITA';
--7
delete from quiz2 where firstname = 'RALPH'
and lastname = 'TOMAS';
