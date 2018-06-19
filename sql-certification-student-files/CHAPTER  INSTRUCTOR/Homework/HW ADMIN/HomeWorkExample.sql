-- =============================================================================
-- SQL Home Work 2
--
-- Student: Ayn Rand
-- Date: May 18, 2016
--
-- Step No. 3
create table ships
(
  ship_id     number,
  ship_name   varchar2(20),
  capacity    number,
  length      number );

insert into ships (ship_id, ship_name, capacity, length)
values (1,'Codd Crystal', 2052, 855);

select ship_name, capacity, length
from ships;