select * from user_tables;
select * from user_tab_columns;

select * from all_tables;
select * from all_tab_columns;

select column_name from all_tab_columns
where table_name = 'CUSTOMERS';

select column_name from all_tab_columns
where table_name = 'ORDERS';


select table_name, column_name
from all_tab_columns
where column_name  like '%CUST%'
and owner = 'BOOKS1';

select * from v$parameter;
select * from dictionary;

select * from user_catalog;

select * 
from user_constraints;

select * from all_columns;

