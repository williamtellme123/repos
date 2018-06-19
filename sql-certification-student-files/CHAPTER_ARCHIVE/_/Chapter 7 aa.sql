-- aggregate functions
-- 
-- sum
-- avg
-- min
-- max
-- median

select category 
    , sum(cost)
    , avg(cost)
    , count(*)
    , min(cost)
    , max(cost)     
from books
group by category;

-- if any column is present in select clause
-- and is not in an aggregate function
-- that column must be in the group by clause

select category 
    , sum(cost)
    , avg(cost)
    , count(*)
    , min(cost)
    , max(cost)     
from books
having sum(cost) >= 38
group by category;

-- Having works on the values of
-- the aggregate functions.
-- Having waits and uses the
-- results of the agg functions
-- to decide which rows to bring back

select category 
    , sum(cost)
    , avg(cost)
    , count(*)
    , min(cost)
    , max(cost)     
from books
where cost >= 32
--having sum(cost) >= 38
group by category;

-- where clause happens
-- before the aggregation happens
--
-- having happens after the
-- aggregation happens

select  room_number
       , room_style
       , room_type
       , window
       , guests
       , sq_ft
       , balcony_sq_ft
from ship_cabins;
-- practice aggregation functions
select
         room_style
       , room_type
       , window
       , count(*)
       , sum(guests)
       , sum(sq_ft)
       , sum(balcony_sq_ft)
from ship_cabins
group by room_style
       , room_type
       , window
order by 1,2,3;
       
-- if any column is present in select clause
-- and is not in an aggregate function
-- that column must be in the group by clause
select *
from ship_cabins
where room_style = 'Stateroom'
and room_type in ('Large','Standard');








-- 
create table myagg
( name   varchar2(20),
  one     integer,
  two     integer,
  three   integer);
  
insert into myagg values ('Bunky',4,5,6);
insert into myagg values ('Zappo',3,3,null);
insert into myagg values ('Minty',null,3,null);
insert into myagg values ('Moony',3,null,null);
commit;

select * from myagg;

select
     count(*) z
    ,count(one) a
    ,sum(one) b
    ,round(avg(one) ,2) c
    ,count(two) d
    ,sum(two)
    ,round(avg(two),2) e
    ,count(three) f
    ,sum(three) g
    ,round(avg(three),2) h
from myagg;

--  SOURCE DATA
--  Name  one two three
--  Bunky	4	  5	  6
--  Zappo	3	  3	
--  Minty		  3	
--  Moony	3		

-- all the aggregate functions
-- except count(*)
-- ignore null values

-- NESTING
-- ======================================
-- Chapter 6
-- Scalar functions operate on "EVERY ROW"
-- they can be many nesting layers deep
select 
   concat
     ('On Average each student received: ',     
        to_char
        (
           round
           (
              (
                 nvl(to_number(FEDERAL10),0)
                 +
                 nvl(to_number(FEDERAL10_NET_PELL),0)
              )   
               / nvl(to_number(FTE_COUNT),0)
           ,2
           ) 
        , '$999,999.99'
        )
      )
     as fps
from tuition;
-- NESTING
-- ======================================
-- Chapter 7
-- Aggregate functions operate on collections of rows
-- nesting is limited to 2 deep (page 294)
select room_type, room_style, sq_ft
from ship_cabins;
-- one level (only one aggregate)
select room_type, room_style, max(sq_ft)
from ship_cabins
group by room_type, room_style;

-- 2nd level aggregate 
select room_type, room_style, avg(max(sq_ft))
from ship_cabins
group by room_type, room_style;

-- 2nd level aggregate remove all scalar values from select
select avg(max(sq_ft))
from ship_cabins
group by room_type, room_style;






-- Can you nest aggregates inside of scalars? YES!
select concat 
          (
            'Average of all the largest rooms is: ',
            to_char(
                    round(
                          avg(max
                                (sq_ft)
                              )
                          ,2
                         ),'$999.99'
                   )
          )
from ship_cabins
group by room_type, room_style;














-- RANK page 283
select sq_ft
from ship_cabins
order by 1 desc;
-- which position would you place the value 195
select rank(195) within group (order by sq_ft desc) 
from ship_cabins
order by 1;

-- FIRST, LAST page 284
select sq_ft, guests
from ship_cabins
order by 2,1;

select min(sq_ft) keep (dense_rank first order by guests)
from ship_cabins;

select max(sq_ft) keep (dense_rank last order by guests)
from ship_cabins;

select 
        count(*) -- total # of rows
        ,count(one) -- toal number of rows with one values
        ,sum(one) -- the total sum of one values
from myagg;
select * from myagg;


select to_char(orderdate,'Q') as "quarter", count(*)
from orders
where to_char(orderdate,'YYYY') = 2003
group by to_char(orderdate,'Q');


select ship_id, max(days)
from projects
group by ship_id
having avg(project_cost) < 50000;