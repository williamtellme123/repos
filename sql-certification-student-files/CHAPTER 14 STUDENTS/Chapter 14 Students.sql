/* This is the bus tour chapter. Simply go through the chapter and select fropm tables with the exception of the all constratins shown below */


select table_name, column_name 
from user_tab_columns
where table_name = 'BOOKS';

select table_name, column_name
from user_tab_columns 
where column_name = 'ISBN'; 

select *
from all_tab_columns;

select owner as schema, count(*)
from all_tab_columns
group by owner;

select *
from dba_tab_columns;

select *
from dictionary;

 select  uc.constraint_type
    --      ,uc.owner as schema_name
            ,uc.constraint_name
            ,ucc1.table_name||'.'||ucc1.column_name "constraint_source"
            ,'References => '
            ,ucc2.table_name||'.'||ucc2.column_name "references_column"
    from user_constraints uc
          ,user_cons_columns ucc1
          ,user_cons_columns ucc2
    where uc.constraint_name = ucc1.constraint_name
      and uc.r_constraint_name = ucc2.constraint_name
      and ucc1.position = ucc2.position -- correction for multiple column primary keys.
--      and uc.constraint_type in ('P','R')
      and ucc1.table_name = 'ORDERITEMS' 
    order by ucc1.table_name,uc.constraint_name;
    
    desc orderitems;

    -- primary keys protect table or row integrity
    -- foreign key protects referential integrity (protecting against orphans) 




select grouping(home_port_id)
from cruises.ships
group by home_port_id;

select * from dictionary;
where table_name = 'BOOKS';

select *
from user_tab_comments
where table_name = 'BOOKS';

comment on table BOOKS is 'A listing of books in the store';

select distinct table_name from user_tab_columns;
select count(distinct table_name) from all_tab_columns;
select count(distinct table_name) from dba_tab_columns;

select * from user_catalog;
select * from user_tab_columns;

select distinct constraint_type
from user_constraints;
where table_name = 'CRUISES';
