create user interview identified by interview;
grant all privileges to interview;

drop table movieinventory;
drop table notFlix;

create table movieinventory
( movie_title varchar(20) primary key,
  replacement_price number(8,2),
  onhand_qty  integer);
begin
  insert into movieinventory values ('Rocky', 24.00, 13);
  insert into movieinventory values ('Ted', 19.99, 11);
  insert into movieinventory values ('Madeline', 29.99, 16);
end;
/
create table notFlix
( subscriber_name varchar(5),
  queue_nbr integer,
  movie_title varchar(20),
  constraint notFlix_pk primary key (subscriber_name,queue_nbr),
  constraint notFlix_fk foreign key (movie_title) references movieinventory (movie_title));

begin
  insert into notFlix values ('Beth', 19,'Madeline');
  insert into notFlix values ('Beth', 20,'Madeline');
  insert into notFlix values ('Sam', 2,'Madeline');
  insert into notFlix values ('Mary',1,'Madeline');
  insert into notFlix values ('Ken',3,'Rocky');
  insert into notFlix values ('Tia',2,'Rocky');
  insert into notFlix values ('Sam', 13,'Madeline');
  insert into notFlix values ('Ken',11,'Rocky');
end;
/
/* Write a query that produces the names of all subscribers 
that have the most expensive queue, based on the 
replacement costs of his or her movies. If a 
subscriber has the same movie more than once in his 
queue, then sum the cost of that movie as many times 
as it appears in the queue. If two or more subscribers 
tie, the output should include the names of all subscribers 
that tied.

Write a SELECT statement that answers the question.  
*/
select a.subscriber_name
from (
        select subscriber_name, count(movie_title) thisCount
        from notFlix
        group by subscriber_name
        having count(movie_title) > 1
      ) a;
      
MOVIE_TITLE REPLACMENT_PRICE    ONHAND_QTY
  Rocky	        24.00           	  13
  Ted	          19.99	              11
  Madeline	    29.99	              16
  
SUBSCRIBER_NAME     QUE_NBR     MOVIE_TITLE
  Sam	                2	          Madeline
  Mary	              1	          Madeline
  Ken	                3	          Rocky
  Tia	                2	          Rocky
  Sam	                13	        Madeline
  Ken	                11	        Rocky 

/* names subscribers with most expensive queue, (replacement costs) 
If same movie > 1 then sum cost 
If two or more subscribers tie show both 
*/


select DISTINCT n.subscriber_name, m.movie_title, thiscount * replacement_price as total 
        from movieinventory m join notFlix n
                              on m.movie_title = n.movie_title
          join ( select subscriber_name, count(movie_title) thisCount
                from notFlix
                group by subscriber_name) iq1
          on n.subscriber_name = iq1.subscriber_name;


select subscriber_name 
from (
        select DISTINCT n.subscriber_name, m.movie_title, rank() over (order by (thiscount * replacement_price) desc) as myrank
        from movieinventory m join notFlix n
                              on m.movie_title = n.movie_title
          join ( select subscriber_name, count(movie_title) thisCount
                from notFlix
                group by subscriber_name) iq1
          on n.subscriber_name = iq1.subscriber_name
        
     ) iq2
where myrank < 2;
  
  
        


  