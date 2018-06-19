/************************************************************
**************Reliability Graph - 180 Day*********************
************************************************************/

--YESTERDAY FORMULA (limited by infrastructure): 100 - ((sum(downtime) + sum(downdeadtime)) / (#total devices * 86400) * 100)  

 
 /********************************************
 ***********ALL PRODUCTS**********************
 *********************************************/ 
  
--TOTAL CALC:
select day, 100 - (((DOWN_TIME + DOWN_DEAD_TIME)/ total_circuits)*100) as NetworkHealth
from
(select day, sum(downtime) down_time, sum(downdeadtime) down_dead_time
  from customer_product_downtime cpd, calendar c
  where cpd.customer_id = :cust
  and day between trunc(sysdate) - 180 and trunc(sysdate)
  and cpd.date_id = c.date_id
  group by day) X,  
(select count(distinct c.circuit_id) * 86400 total_circuits
  from circuit c, interface i
  where i.interface_id = c.to_interface_id
  and i.customer_id = :cust) Y    
  
--COMPONENT: DSum of own and DownDead time
select day, sum(downtime) down_time, sum(downdeadtime) down_dead_time
  from customer_product_downtime cpd, calendar c
  where cpd.customer_id = :cust
  and day between trunc(sysdate) - 180 and trunc(sysdate)
  and cpd.date_id = c.date_id
  group by day
  
  
--COMPONENT: Total Circuits by ALL Products 
select count(distinct c.circuit_id) total_circuits
  from circuit c, interface i
  where i.interface_id = c.to_interface_id
  and i.customer_id = :customer_id
 
 
 
 /********************************************
 ***********BY PRODUCT************************
 *********************************************/

--TOTAL CALC:  BY PRODUCT
select day, 100 - (((DOWN_TIME + DOWN_DEAD_TIME)/ total_circuits)*100) as NetworkHealth
from
(select day, sum(downtime) down_time, sum(downdeadtime) down_dead_time
  from product_mix pm, customer_product_downtime cpd, calendar c
  where pm.product_category_id = :prodID
  and cpd.product_id = pm.product_id		  
  and cpd.customer_id = :cust
  and day between trunc(sysdate) - 180 and trunc(sysdate)
  and cpd.date_id = c.date_id
  group by day) X,   
(select m.product_category_id, count(distinct c.circuit_id) * 86400 total_circuits
  from circuit c, interface i, product_mix m
  where i.interface_id = c.to_interface_id
  and i.product_id = m.product_id
  and m.product_category_id = :prodID
  and i.customer_id = :cust
  group by m.product_category_id) Y  
  
--COMPONENT: Down and DownDead time by Product
select day, sum(downtime) down_time, sum(downdeadtime) down_dead_time
  from product_mix pm, customer_product_downtime cpd, calendar c
  where pm.product_category_id in (1,2,3,4,5)
  and cpd.product_id = pm.product_id		  
  and cpd.customer_id = :cust
  and day between trunc(sysdate) - 180 and trunc(sysdate)
  and cpd.date_id = c.date_id
  group by day  
    
--COMPONENT: Total Circuits by Individual Product 
select c.product_category_id, c.product_category_description, count(distinct c.circuit_id) total_circuits
  from circuit c, interface i, product p, product_mix m, product_category c
  where i.interface_id = c.to_interface_id
  and i.product_id = p.product_id
  and p.product_id = m.product_id
  and m.product_category_id = c.product_category_id
  and c.product_category_id in (1,2,3,4,5)
  and i.customer_id = :customer_id
  group by c.product_category_id, c.product_category_description

  