
select contact_email_id, status, email_address
from contact_emails;

Select online_subscriber_id, email
from online_subscribers;
-- -------------------------------------------------------------
-- UNION and UNION ALL
select contact_email_id, email_address
from contact_emails
UNION ALL
Select online_subscriber_id, email
from online_subscribers;
-- -------------------------------------------------------------
select contact_email_id, email_address
from contact_emails
UNION
Select online_subscriber_id, email
from online_subscribers;
-- -------------------------------------------------------------
select email_address
from contact_emails
UNION ALL
Select email
from online_subscribers;
-- -------------------------------------------------------------
-- INTERSECT
select email_address
from contact_emails
intersect
Select email
from online_subscribers;
-- -------------------------------------------------------------
-- MINUS
select email_address
from contact_emails
minus
Select email
from online_subscribers;

--bubblegum@tlivecar.com
--nora@astann.com

--MINUS
--pendicott77@kasteelinc.com
--watcher@foursigma.org
--hardingpal@ckofca.com


-- -------------------------------------------------------------
-- ORDER OF OPs
select email_address as apple
from contact_emails
UNION ALL 
Select email as pear
from online_subscribers
--order by 1;
--order by email_address;
order by apple;
-- -------------------------------------------------------------
(select product
from store_inventory
union all
select item_name 
from furnishings)
      intersect
          (select item_name from furnishings where item_name = 'Towel'
          union all
          select item_name from furnishings where item_name = 'Towel');
-- -------------------------------------------------------------
select product
from store_inventory
union all
select item_name 
from furnishings
intersect
select item_name from furnishings where item_name = 'Towel'
union all
select item_name from furnishings where item_name = 'Towel';          
-- -------------------------------------------------------------
(select item_name from furnishings where item_name = 'Towel'
union all
select item_name from furnishings where item_name = 'Towel')
minus 
select item_name from furnishings where item_name = 'Towel';
-- -------------------------------------------------------------
select item_name from furnishings 
minus
(select item_name from furnishings where item_name = 'Towel'
union all
select item_name from furnishings where item_name = 'Towel');
-- -------------------------------------------------------------
-- question 11
select lastname,
      (select product from store_inventory
        intersect
        select item_name from furnishings)
from online_subscribers;  
-- -------------------------------------------------------------
-- question 12
select a.sub_date, count(*)
from online_subscribers 
   a 
   join
            (select 
                  case 
                      when instr(last_order,'-') = 5 then to_date(last_order,'YYYY-MM-DD')
                      when instr(last_order,'-') = 3 then to_date(last_order,'DD-MON-yy')
                   end as last_order
               ,product 
              from store_inventory
            union
              select added, item_name from furnishings) 
    b
on a.sub_date = b.last_order
group by a.sub_date;
-- ----------------------------------
-- insert into furnishings values(4,'Lava Lamp','11-NOV-2009', 'LR');
-- insert into furnishings values(5,'Black Light','21-DEC-2009', 'LR');
-- insert into furnishings values(6,'AREOSMITH','16-FEB-2009', 'LR');
-- update online_subscribers set sub_date = '16-FEB-2009' where online_subscriber_id = 2;
commit;










