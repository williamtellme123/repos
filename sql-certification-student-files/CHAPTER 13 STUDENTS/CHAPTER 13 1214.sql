create table population
(
  pid integer,
  state varchar(2 byte),
  county varchar (15 byte),
  City vARCHAR(25 byte),
  pop integer);
drop table population;
insert into population values (1,'TX','Wiliamson','Round Rock',1000);  
insert into population values (2,'TX','Travis','Austin',2000);
insert into population values (3,'TX','Hays','Buda',500);
insert into population values (4,'TX','Wiliamson','Cedar Park', 1000);
insert into population values (5,'MA','Gaine','Greenfield', 5000);
insert into population values (5,'MA','Gaine','Turners Falls', 4000);
commit;

insert into population values (1,'TX','Wiliamson','Round Rock',1000);  
insert into population values (4,'TX','Wiliamson','Cedar Park', 1000);
insert into population values (5,'MA','Gaine','Greenfield', 5000);
commit;
-- review aggregate functions
select * from population;

select state, sum(pop)
from population
group by state;

select state, county, sum(pop)
from population
group by state, county;

select state, county, city, sum(pop)
from population
group by state, county,city;

-- rollup version of aggregation
select state, sum(pop)
from population
group by rollup (state);

select state, county, sum(pop)
from population
group by rollup(state, county);

select state, county, city, sum(pop)
from population
group by rollup(state, county,city)
order by 2;
