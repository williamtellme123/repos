select shipdate, 
        decode (
                  shipdate,
                      null , 'Not Shipped',
                      shipdate 
               )   
from orders;


select owner, table_name from all_tab_columns 
where lower(column_name) like '%internal%'
order by 1;

create table invoices
(id integer,
inv_date date,
inv_amt number (9,2),
acct_no varchar2(25));

delete invoices;
insert into invoices values (701,to_date('03/15/2009','mm/dd/yyyy'),147119,'0CODDA15');
insert into invoices values(702,to_date('06/17/2010','mm/dd/yyyy'),275803,'CODDA12');
insert into invoices values(703,to_date('10/18/2010','mm/dd/yyyy'),248414,'CODDA20');
insert into invoices values(704,to_date('01/19/2009','mm/dd/yyyy'),169206,'CODDA18');
insert into invoices values(705,to_date('09/18/2011','mm/dd/yyyy'),102680,'CODDA12');
insert into invoices values(706,to_date('11/04/2010','mm/dd/yyyy'),179138,'CODDA17');
insert into invoices values(707,to_date('12/13/2011','mm/dd/yyyy'),270723,'CODDA18');
insert into invoices values(708,to_date('09/15/2010','mm/dd/yyyy'),130288,'CODDA13');
insert into invoices values(709,to_date('03/21/2010','mm/dd/yyyy'),255003,'CODDA18');
insert into invoices values(710,to_date('04/13/2009','mm/dd/yyyy'),254837,'CODDA19');
insert into invoices values(711,to_date('06/30/2010','mm/dd/yyyy'),284695,'CODDA19');
insert into invoices values(712,to_date('11/20/2010','mm/dd/yyyy'),297928,'CODDA19');


select  inv_date,
        case 
            when inv_date between '01-JAN-2009' and '31-DEC-2009' then 'Add to 2009' 
            when inv_date between '01-JAN-2010' and '31-DEC-2010' then 'Add to 2010' 
            when inv_date between '01-JAN-2011' and '31-DEC-2011' then 'Add to 2011' 
        end
        
from invoices;



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
