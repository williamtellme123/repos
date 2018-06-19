create table friends
(fid integer,
 fname varchar2(15),
 mid   varchar2(1),
 lname varchar2(15));
 
create table team
(tid integer,
 f_name varchar2(15),
 mid_i   varchar2(1),
 l_name varchar2(15));
 
 insert into friends values (1,'Valerie','J','Jones');
 insert into team values (1,'Valerie','M','Jones');
 
 select fid
 from friends
 UNION
 select tid
 from team;
 
 
 select contact_email_id
 from contact_emails
 union all
 select online_subscriber_id
 from online_subscribers
 order by 1;
-- --------------------------------








select product 
  from store_inventory
    union all
select item_name 
  from furnishings
intersect  
  select item_name from furnishings 
  where item_name = 'Towel';
  
  
select item_name from furnishings 
  where item_name = 'Towel'
UNION ALL
select item_name from furnishings 
  where item_name = 'Towel';  
  
  
  
  
  
  
--
--intersect
--select item_name from furnishings 
--  where item_name = 'Towel'
--
--select item_name from furnishings 
--  where item_name = 'Towel'
--UNION ALL
--select item_name from furnishings 
--  where item_name = 'Towel'

 
( select product 
  from store_inventory
    union all
  select item_name 
  from furnishings
)
intersect
(
select item_name from furnishings 
  where item_name = 'Towel'
UNION ALL
select item_name from furnishings 
  where item_name = 'Towel'
);



