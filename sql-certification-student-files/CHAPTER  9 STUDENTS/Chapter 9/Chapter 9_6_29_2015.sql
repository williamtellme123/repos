-- Nested aka inner queries
-- terms to know
-- Parent ~ outer query
-- Child ~ inner query
-- 
-- Correlated Query
-- Non-Correlated Query

-- Three places where a nested query can be placed
--    Select clause
--    From clause
--    Where clause

-- Non-correlated Query example
-- 
-- Find all books <= average(retail) of all books
-- 
-- Think of this as two separate queries
--    First get average retail of all books 

select avg(retail)
from books;
-- 40.99
--    Next write the outer with a literal value
select title, retail
from books
where retail <= 40.99;

select title, retail
from books
where retail <= (
                  select avg(retail)
                  from books
                  );
-- Non-correlated query
-- means the inner-most child fires first
-- the next outer parent waits
-- then uses the result from the child to proceed


select distinct firstname, lastname, title, retail
from customers
          join orders using(customer#)
          join orderitems using (order#)
          join books using(isbn)
where retail-cost =
                (
                 select max(retail-cost)
                 from books
                 where retail-cost >= 
                                      ( 
                                        select round(avg(retail-cost)) profit
                                        from books
                                      )  
                )
order by retail desc;
-- Innermost avg profit
-- Next is the max profit
-- Outermost is who bought that book
--
-- CORRELATED INNER QUERIES: means that the outer is row-dependent on the inner 
select title, retail
from books b1
where retail >= (
                   select avg(retail)
                   from books b2
                   where b1.category = b2.category
                );
-- STEPS of Operation
-- 1. Outer query stops on Row #1 Of its table
-- 2. Outer passes a value (category) from current row to inner q
-- 3. Inner query runs
-- 4. Result of Inner query is passed back to waiting parent
-- 5. Outer uses to mark row T/F
-- 6. Outer moves to next row
-- 7. Repeat 2-6

-- select inner join :: must return 1 row 1 col 
select * from states;
select  city
       , state
       , (select region from states s where s.st = t.state)
       , (select Count(*) from books.books)
from tuition t;

-- from inner join :: these inner queries are just like
-- tables so any # rows and any # columns Page 390
select a.ship_id, count_cabins, count_cruises
from 
    (
      select ship_id, count(ship_cabin_id) as count_cabins
      from ship_cabins
      group by ship_id
    ) a
join 
    (
      select ship_id, count(cruise_order_id) as count_cruises
      from cruise_orders
      group by ship_id
    ) b
on a.ship_id = b.ship_id;

insert into cruise_orders values (1,sysdate-600,sysdate-590, 1, 1);
insert into cruise_orders values (2,sysdate-600,sysdate-590, 2, 1);
insert into cruise_orders values (3,sysdate-500,sysdate-490, 1, 2);
insert into cruise_orders values (4,sysdate-500,sysdate-490, 1, 2);

commit;

-- where inner join
-- aware or number of columns and number of rows returned
-- co-workers  'Smith'
select employee_id, last_name, first_name
from employees
where ship_id in (
                  select ship_id
                  from employees
                  where last_name = 'Smith'
                 )
and not (last_name = 'Smith');                   
-- ----------------------------------               
select *
from invoices
where (invoice_date, total_price) =
        (
          select start_date, salary
          from pay_history
          where pay_history_id = 4
        );
update invoices set invoice_date = '04-JUN-01', total_price = 37450
where invoice_id in (5, 8, 10);

select * from invoices;

-- above examples illustrate fetching, reading
-- inner queries can be used to update and delete
--
-- update page 363
update invoices inv set terms_of_discount = '10 PCT'
where total_price = 
                 (select max(total_price)
                  from invoices
                  where to_char(invoice_date, 'RRRR-Q') = 
                        to_char(inv.invoice_date, 'RRRR-Q')
                 );
commit;
-- delete page 365
select * from ship_cabins; -- have 29
-- this should delete 7 rows total remaining 22
delete from ship_cabins s1
where s1.balcony_sq_ft = 
            (select min(balcony_sq_ft)
             from ship_cabins s2
             where s1.room_type = s2.room_type
               and s1.room_style = s2.room_style
            );
rollback;

-- exists page 365
select port_id, port_name
from ports p1
where exists ( -- true if select returns 1 or more
                select *
                from ships s1 
                where p1.port_id = s1.home_port_id
              );

-- with page 366
with 
port_bookings as -- port_bookings is a variable for the rest of this statement
    (
      select p.port_id, p.port_name, count(s.ship_id) ct
      from ports p, ships s
      where p.port_id = s.home_port_id
      group by p.port_id, p.port_name
    ),
densest_port as -- densest_port is a variable for the rest of this statement
    (
      select max(ct) max_ct
      from port_bookings
    )
select port_name 
from port_bookings
where ct = (select max_ct from densest_port);










