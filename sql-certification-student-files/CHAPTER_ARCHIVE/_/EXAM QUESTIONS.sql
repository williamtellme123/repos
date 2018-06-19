create table exam1 (product_id varchar(20));

insert into exam1 values ('BTS_J_C');
insert into exam1 values ('SJC');
insert into exam1 values ('SKJKC');
insert into exam1 values ('S_J_C');
commit;
select * from exam1;

SELECT PRODUCT_ID FROM exam1
WHERE PRODUCT_ID LIKE '%S_J_C' ;

SELECT PRODUCT_ID FROM exam1
WHERE PRODUCT_ID LIKE '%S\_J\_C'  escape '\';

SELECT PRODUCT_ID FROM exam1
WHERE PRODUCT_ID LIKE '%S*_J*_C'  escape '*';

drop table exam1;
create table exam1 (bd date);
insert into exam1 values (sysdate);
insert into exam1 values ('01-JAN-14');
commit;
select * from exam1;
select to_char(bd, 'dd:mm:yyyy hh:mi:ss') from exam1;

insert into exam1 values (to_date('01/04/13 12:30:45', 'dd/mm/yy hh:mi:ss')); 
commit;
select * from exam1; 

select to_char(bd, 'dd:mm:yyyy hh:mi:ss') from exam1;

select bd "as two words"
from exam1;

SELECT PRODUCT_ID FROM exam1
WHERE PRODUCT_ID LIKE '%S\_J\_C' ESCAPE '\';



