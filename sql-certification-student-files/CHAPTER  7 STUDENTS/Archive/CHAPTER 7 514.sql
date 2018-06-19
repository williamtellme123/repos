-- any column in the select statment that is not
-- in an aggregate function must be included 
-- in the gorup by statement
select category, sum(cost),avg(cost), max(cost), min(cost)
from books
group by category;

-- order by the total invoice amount with the lagest invoice first
select * from orders;

select order#, title, cost, quantity
from orderitems oi, books b
where oi.isbn = b.isbn;

select order#, sum((cost*quantity)) AS tot
from orderitems oi, books b
where oi.isbn = b.isbn
group by order#
order by order#, tot desc;


select order#, count(*), count(orderdate), count(shipdate)
from orders
group by order#;


-- heres an example of a aggregate statement that fails
select category, avg(retail), avg(cost)
from books;
-- Fix No. 1
-- remove the reference to a single row (category)
-- and return the values from the entire table
select avg(retail), avg(cost)
from books;
-- Fix No. 2
-- retain the reference to a single row (category)
-- any col in the select clause not inside an aggregate function
-- must be included in the group by clause
select category, avg(retail), avg(cost)
from books
group by category;
-- nuanace of change see if it works without the single col in the select clause
select avg(retail), avg(cost)
from books
group by category;

select title, substr(title,15), cost
from books;

select category, count(*), avg(cost), max(retail), Min(cost)
from books
group by category;

select count(*)
from books;

select distinct category
from books;


-- page 283
select rank(300) within group (order by sq_ft)
from ship_cabins;

select ship_cabin_id, sq_ft
from ship_cabins
order by sq_ft;

-- page 284
select max(sq_ft) keep (dense_rank first order by guests)
from ship_cabins;

select max(sq_ft) keep (dense_rank last order by guests)
from ship_cabins;

select max(sq_ft) keep (dense_rank first order by guests desc)
from ship_cabins;

select guests, max(sq_ft) 
from ship_cabins
group by guests;

-- page 291
select room_style
       , room_type
       , min(sq_ft)
       , max(sq_ft)
from ship_cabins
group by room_style, room_type;


select category, sum(retail) 
from books
group by category
order by sum(retail);

select category, sum(retail) sum_retail
from books
group by category
order by sum_retail;

select category, sum(retail) 
from books
group by category
order by 2;

-- scalar function nesting
select title, length(substr(lower(substr(title,1,5)),1,3))
from books;

select room_style, avg(max(sq_ft))
from ship_cabins
where ship_id = 1
group by room_style;

-- do not add any column in front of a 2-deep aggregate function
-- rememeber to group by at least one column for the inner aggregate
-- to work
select sum(max(sq_ft))
from ship_cabins
where ship_id = 1
group by room_style;

select firstname,lastname
from customers
order by state;


select ship_cabin_id, sq_ft, guests
from ship_cabins
order by guests desc;

select trunc(round(avg(max(sq_ft)),2),1)
from ship_cabins
where ship_id = 1
group by room_style, room_type;

-- using aggregate functions
-- having
-- where

select category, sum(cost)
from books
having sum(cost) > 35
group by category;

select category, sum(cost)
from books
where cost < 33
group by category
;

--COMPUTER	138.35
--COOKING	  31.5

select category, sum(cost)
from books
where cost < 33
having sum(cost) > 35
group by category;

-- having clause works on the return set from the
-- aggregate function
--
-- where works on every row before the aggregate function
-- is run

create table little
(lid    number,
 amount   number);
insert into little values(1,2); 
insert into little values(2,null); 
insert into little values(3,4); 

select * from little;

select amount, amount + 1, amount *2
from little;
 
select amount
from little;

select count(*), count(amount), sum(amount), avg(amount), median(amount)
from little;


select max(orderdate), median(orderdate), avg(orderdate)
from orders;

select min(lastname), max(lastname), count(lastname)
from customers;


select ship_id, max(days)
from projects



