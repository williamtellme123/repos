

select * from invoices_revised;

select
       sum(case 
            when invoice_date between '01-JAN-09' and '31-DEC-09' 
            then invoice_amt
       end) as tot_2009
        , 
        sum(case 
            when invoice_date between '01-JAN-10' and '31-DEC-10' 
            then invoice_amt
       end) as tot_2010
               , 
        sum(case 
            when invoice_date between '01-JAN-11' and '31-DEC-11' 
            then invoice_amt
       end) as tot_2011
from invoices_revised;       