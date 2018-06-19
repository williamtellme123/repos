select * from population;

select county, sub_div, river_basin,p2020
from population
where county in ('ARMSTRONG','CARSON');
-- ============================================
select county, sum(p2020)
from population
where county in ('ARMSTRONG','CARSON')
group by county;

select county, sum(p2020)
from population
where county in ('ARMSTRONG','CARSON')
group by rollup (county);
-- ============================================
select county, river_basin, sum(p2020)
from population
where county in ('ARMSTRONG','CARSON')
group by county, river_basin;

select county, river_basin, sum(p2020)
from population
where county in ('ARMSTRONG','CARSON')
group by rollup (county, river_basin);
-- ============================================
select county, river_basin, sub_div, sum(p2020)
from population
where county in ('ARMSTRONG','CARSON')
group by county, river_basin, sub_div
order by 1,2,3;

select county, river_basin, sub_div, sum(p2020)
from population
where county in ('ARMSTRONG','CARSON')
group by rollup (county, river_basin,sub_div)
order by 1,2,3;
-- ============================================
create table temp
(rn, cnt, rb, sd,pop) as
select rownum,county, river_basin, sub_div, p2020
from population
where region = 'P';
select * from temp;

update temp set sd = 'EDNA' where rn = 5;
update temp set rb = 'LAVACA' where rn = 3;
update temp set rb = 'LAVACA' where rn = 1;
delete from temp where rn > 12;
commit;

select cnt, rb,sd, sum(pop) 
from temp
group by cnt,rb,sd
order by 1,2,3;

select cnt, rb,sd 
from temp
order by 1,2,3;


select cnt, rb,sd, sum(pop) 
from temp
group by rollup(cnt,rb,sd)
order by 1,2,3;

-- ============================================
select county, p2020 from population where county in ('ARMSTRONG','CARSON');

select county, river_basin,sum(p2020)
from population
where county in ('ARMSTRONG','CARSON')
group by county,river_basin;

select county, river_basin, sum(p2020)
from population
where county in ('ARMSTRONG','CARSON')
group by cube (county,river_basin)
order by 1,2;
-- ============================================
select county, river_basin, sub_div, p2020 from population 
where county in ('ARMSTRONG','CARSON') order by 1,2,3;

select county, river_basin, sub_div, sum(p2020)
from population
where county in ('ARMSTRONG','CARSON')
group by county,river_basin, sub_div;

select county, river_basin, sub_div, sum(p2020)
from population
where county in ('ARMSTRONG')
group by cube (county,river_basin,sub_div)
order by 1,2,3;

-- create a table with four rows and 4 columns
-- county    river_basin      sub_div   pop
-- Grover    RED              A12       200
-- Grover    LAVACA           S-22      300
-- Winston   COLORADO         R-5`      400

select county, river_basin, sub_div, sum(pop)
from mytable
group by rollup (county, river_basin,sub_div)
order by 1,2,3;

select county, river_basin, sub_div, sum(pop)
from mytable
group by cube (county, river_basin,sub_div)
order by 1,2,3;
-- 1. Number of different aggregates
-- 2. Number of rows
-- 3. Aggregate where RED is the only consideration
-- 4. What is Row 2 Col 2
-- 5. Is there an aggregate for river_basin and sub_div







