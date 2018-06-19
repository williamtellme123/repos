insert into cruise_orders values (1,sysdate-600,sysdate-590, 1, 1);
insert into cruise_orders values (2,sysdate-600,sysdate-590, 2, 1);
insert into cruise_orders values (3,sysdate-500,sysdate-490, 1, 2);
insert into cruise_orders values (4,sysdate-500,sysdate-490, 1, 2);


update invoices set invoice_date = '04-JUN-01', total_price = 37450
where invoice_id in (5, 8, 10);