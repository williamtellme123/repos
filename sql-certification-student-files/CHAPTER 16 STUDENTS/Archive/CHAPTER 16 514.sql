

select c2.firstname,c2.lastname, ' referred by-> ', c1.firstname,c1.lastname
from customers c1, customers c2
where c1.customer# = c2.referred;

