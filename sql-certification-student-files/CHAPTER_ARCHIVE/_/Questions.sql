-- CTAS Create table as select 
CREATE TABLE BOOKS2 (
                      isbn PRIMARY KEY,
                      title,
                      pubid NOT NULL) 
                  AS
                      SELECT isbn, title, pubid
                      FROM books; 
create table books3
as select * from books;

delete books3;

create synonym syn_books for books;

create view syn_books as
select * from books;

create public synonym syn_books for books;

select SUBSTR(INITCAP('chicago the windy city'), -7) from dual;

SELECT ORDER#, COUNT(*)
FROM ORDERS
GROUP BY ORDER#
ORDER BY ORDER#
UNION ALL
SELECT ORDER#, COUNT(*)
FROM ORDERs
GROUP BY ORDER#
ORDER BY ORDER#; 

ALTER TABLE BOOKS3 READ ONLY;
select q'$12-SEP-2001$' from dual;

SELECT SUBSTR(catcode,1,2), AVG(retail)
FROM books GROUP BY catcode;

SELECT SUBSTR(category,1,2), AVG(retail)
FROM books GROUP BY category;

SELECT category, COUNT(DISTINCT isbn)
    FROM books GROUP BY category;

SELECT A.CITY, E.LAST_NAME
FROM EMPLOYEES E JOIN ADDRESSES A
USING (employee_ID)
order by a.state;

SELECT A.CITY, E.LAST_NAME, count(ship_id)
FROM EMPLOYEES E JOIN ADDRESSES A
USING (employee_ID)
GROUP BY E.LAST_NAME, A.city
ORDER BY a.city,e.last_name;



select * from employees;

RENAME TABLE BOOKS.CUSTOMERS TO NEW_CUSTOMERS;
RENAME CUSTOMERS TO NEW_CUSTOMERS;

-- 2073
-- 2000-2099
SELECT TO_DATE('30-MAY-33', 'DD-MON-YY'),
       TO_CHAR(TO_DATE('30-MAY-33', 'DD-MON-YY'), 'DD-MON-RRRR'),
       TO_CHAR(TO_DATE('30-MAY-33', 'DD-MON-YY'), 'DD-MON-YYYY')
FROM DUAL;

-- 1973
-- 1950-2049
SELECT TO_DATE('30-MAY-73', 'DD-MON-RR'), 
       TO_CHAR(TO_DATE('30-MAY-73', 'DD-MON-RR'), 'DD-MON-YYYY'),
       TO_CHAR(TO_DATE('30-MAY-73', 'DD-MON-RR'), 'DD-MON-RRRR')
FROM DUAL;

SELECT TRUNC(SALARY) a,
       SUM(TRUNC(SALARY)) b,
       TO_DATE(SUM(TRUNC(SALARY)),'J') c,
       TO_CHAR(TO_DATE(SUM(TRUNC(SALARY)),'J'),'JSP') d
FROM PAY_HISTORY
group by trunc(salary);


WHERE DEPARTMENT_ID = 20;
select * from pay_history;


