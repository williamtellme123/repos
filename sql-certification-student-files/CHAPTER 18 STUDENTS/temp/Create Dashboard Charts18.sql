-- st -----------------------------------------------------------------

select folder, count(distinct(sev)) from stcr group by folder;

select folder from stcr;
select distinct(sev) from stcr;
select folder, distinct (sev) from stcr;
group by sev;
select distinct (status) from stcr;
select distinct project, folder from stcr;
select distinct sev from stcr;
-- bz -----------------------------------------------------------------
select distinct(sev) from bzcr;
select distinct(status) from bzcr;
select distinct product, component from bzcr;
select distinct sev from bzcr;
-- oss  -----------------------------------------------------------------
select count(*) from osscr;
select distinct(priority) from osscr;
select * from osscr
where ticket_id = '2126720';
select distinct(status) from osscr;
select distinct category, subcategory from osscr;
-- rem  -----------------------------------------------------------------
select count(*) from rmcr;







SELECT entrdate, resvddate,crnum FROM stcr  where entrdate BETWEEN '2006-12-31' AND '2007-03-31';

-- find defects between two dates
SELECT entrdate, resvddate,crnum FROM stcr  where entrdate BETWEEN '2007-03-22' AND '2007-03-27';

-- find defects last 7 days
SELECT entrdate, resvddate, crnum
FROM stcr  where entrdate BETWEEN date (now() - interval 7 day) AND now();

-- find different folders in a given project
select distinct project, folder from stcr where project = 'Production Support';

-- count different folders in a project
select project, count(distinct(folder)) from stcr group by project;

-- first bar count each sev type
select '2007-03-22', sev, count(sev) as total from stcr where entrdate < '2007-03-22' group by sev;

-- second bar count each sev type
select sev, count(sev) from stcr where entrdate < '2007-03-23' group by sev;

-- this works
DROP TABLE IF EXISTS sevcr;
CREATE TABLE sevcr(
  thissev varchar(5)
  )ENGINE=INNODB;

INSERT INTO sevcr (thissev)
  SELECT stcr.sev
  FROM stcr WHERE entrdate > '2007-01-23';
-- this works

-- this works
DROP TABLE IF EXISTS sevcr;
CREATE TABLE sevcr(
  pkid int NOT NULL AUTO_INCREMENT,PRIMARY KEY(pkid),
  sev varchar(5),
  sevcount int
  )ENGINE=INNODB;
INSERT INTO sevcr (sev, sevcount)

select sev, count(sev) from stcr where entrdate < '2007-03-23' group by sev;
-- this works

-- this works
DROP TABLE IF EXISTS sevcr;

CREATE TABLE sevcr(
  pkid int NOT NULL AUTO_INCREMENT,PRIMARY KEY(pkid),
  edate datetime default NULL,
  sev varchar(5),
  sevcount int
  )ENGINE=INNODB;

INSERT INTO sevcr (edate, sev, sevcount)select  '2007-03-23 01:02:05',sev, count(sev) from stcr where entrdate < '2007-03-23' group by sev;
INSERT INTO sevcr (edate, sev, sevcount)select  '2007-03-24 01:02:05',sev, count(sev) from stcr where entrdate < '2007-03-24' group by sev;
INSERT INTO sevcr (edate, sev, sevcount)select  '2007-03-25 01:02:05',sev, count(sev) from stcr where entrdate < '2007-03-25' group by sev;
INSERT INTO sevcr (edate, sev, sevcount)select  '2007-03-26 01:02:05',sev, count(sev) from stcr where entrdate < '2007-03-26' group by sev;
INSERT INTO sevcr (edate, sev, sevcount)select  '2007-03-27 01:02:05',sev, count(sev) from stcr where entrdate < '2007-03-27' group by sev;
INSERT INTO sevcr (edate, sev, sevcount)select  '2007-03-28 01:02:05',sev, count(sev) from stcr where entrdate < '2007-03-28' group by sev;
-- this works

-- workbench
-- sev2 ia the POC table manually populated for demo
-- it displays last 5 days of sevs for a clustered column chart
-- complete this for the automated run
DROP TABLE IF EXISTS compsev;

CREATE TABLE compsev(
  pkid int NOT NULL AUTO_INCREMENT,PRIMARY KEY(pkid),
  edate datetime default NULL,
  sev1 varchar(5),
  sev2 varchar(5),
  sev3 varchar(5),
  sev4 varchar(5),
  new int,
  closeddf int
  )ENGINE=INNODB;
INSERT INTO compsev (edate, sev, sevcount)select  '2007-03-23 01:02:05',sev, count(sev) from stcr where entrdate < '2007-03-23' group by sev;
INSERT INTO compsev (edate, sev, sevcount)select  '2007-03-24 01:02:05',sev, count(sev) from stcr where entrdate < '2007-03-24' group by sev;
INSERT INTO compsev (edate, sev, sevcount)select  '2007-03-25 01:02:05',sev, count(sev) from stcr where entrdate < '2007-03-25' group by sev;
INSERT INTO compsev (edate, sev, sevcount)select  '2007-03-26 01:02:05',sev, count(sev) from stcr where entrdate < '2007-03-26' group by sev;
INSERT INTO compsev (edate, sev, sevcount)select  '2007-03-27 01:02:05',sev, count(sev) from stcr where entrdate < '2007-03-27' group by sev;
INSERT INTO compsev (edate, sev, sevcount)select  '2007-03-28 01:02:05',sev, count(sev) from stcr where entrdate < '2007-03-28' group by sev;

-- manual entry for the demo only
select * from compsev;
INSERT INTO compsev (edate, sev1,sev2,sev3,sev4,new, closeddf)
VALUES ('2007-03-23 01:02:05','105','311','443','87','5','1'),
('2007-03-24 01:02:05','106','312','443','87','3','3'),
('2007-03-25 01:02:05','106','314','444','87','1','4'),
('2007-03-26 01:02:05','106','314','444','87','2','1'),
('2007-03-26 01:02:05','108','314','447','88','1','2');
-- sev2 ia the POC table manually populated for demo
-- workbench

-- workbench
-- compdef component defects holds defects by component
-- manual entry for the demo, update for automated run
DROP TABLE IF EXISTS compdef;
CREATE TABLE compdef(
  pkid int NOT NULL AUTO_INCREMENT,PRIMARY KEY(pkid),
  edate datetime default NULL,
  WebServices varchar(5),
  Netcool varchar(5),
  OSS varchar(5),
  Portal varchar(5),
  PUI varchar(5),
  Provioning varchar(5),
  Proviso varchar(5)
  )ENGINE=INNODB;

-- compdef component defects holds defects by component
INSERT INTO compdef (edate, WebServices,Netcool,OSS,Portal,PUI,Provioning,Proviso)
VALUES
('2007-03-22','8','16','1','2','30','0','21'),
('2007-03-23','8','16','1','2','30','0','21'),
('2007-03-24','8','16','1','2','30','0','21'),
('2007-03-25','8','16','1','2','30','0','21'),
('2007-03-26','8','20','1','2','29','0','21'),
('2007-04-27','8','21','1','2','29','0','21');
-- compdef component defects holds defects by component




DROP TABLE IF EXISTS testres;
CREATE TABLE  testres (
  pkid int(11) NOT NULL auto_increment,
  edate datetime default NULL,
  dailyplanned varchar(5) default NULL,
  totalplanned varchar(5) default NULL,
  totaltestcases varchar(5) default NULL,
  totalactual varchar(5) default NULL,
  PRIMARY KEY  (pkid)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

select * from  testres;
desc testres;
INSERT INTO testres (edate, dailyplanned,totalplanned,totaltestcases,totalactual)
('2007-03-20 00:00:00', '0', '0', '180', '0'),
('2007-03-21 00:00:00', '0', '0', '180', '0'),
('2007-03-22 00:00:00', '21', '21', '180', '29'),
('2007-03-23 00:00:00', '15', '36', '180', '43'),
('2007-03-24 00:00:00', '0', '36', '180', ',54'),
('2007-03-25 00:00:00', '0', '36', '180', '67'),
('2007-03-26 00:00:00', '5', '41', '180', '0'),
('2007-03-27 00:00:00', '5', '46', '180', '0'),
('2007-03-28 00:00:00', '5', '51', '180', '0'),
('2007-03-29 00:00:00', '7', '58', '180', '0'),
('2007-03-30 00:00:00', '8', '66', '180', '0'),
('2007-03-31 00:00:00', '0', '66', '180', '0'),
('2007-04-01 00:00:00', '0', '66', '180', '0'),
('2007-04-02 00:00:00', '7', '73', '180', '0'),
('2007-04-03 00:00:00', '7', '80', '180', '0'),
('2007-04-04 00:00:00', '7', '87', '180', '0'),
('2007-04-05 00:00:00', '5', '92', '180', '0'),
('2007-04-06 00:00:00', '8', '100', '180', '0'),
('2007-04-07 00:00:00', '0', '100', '180', '0'),
('2007-04-08 00:00:00', '0', '100', '180', '0'),
('2007-04-09 00:00:00', '6', '106', '180', '0'),
('2007-04-10 00:00:00', '8', '104', '180', '0'),
('2007-04-11 00:00:00', '9', '123', '180', '0'),
('2007-04-12 00:00:00', '8', '131', '180', '0'),
('2007-04-13 00:00:00', '4', '135', '180', '0'),
('2007-04-14 00:00:00', '0', '135', '180', '0'),
('2007-04-15 00:00:00', '0', '135', '180', '0'),
('2007-04-16 00:00:00', '5', '140', '180', '0'),
('2007-04-17 00:00:00', '1', '141', '180', '0'),
('2007-04-18 00:00:00', '1', '142', '180', '0'),
('2007-04-19 00:00:00', '1', '143', '180', '0'),
('2007-04-20 00:00:00', '3', '146', '180', '0'),
('2007-04-21 00:00:00', '0', '146', '180', '0'),
('2007-04-22 00:00:00', '0', '146', '180', '0'),
('2007-04-23 00:00:00', '3', '149', '180', '0'),
('2007-04-24 00:00:00', '4', '153', '180', '0'),
('2007-04-25 00:00:00', '2', '155', '180', '0'),
('2007-04-26 00:00:00', '4', '159', '180', '0'),
('2007-04-27 00:00:00', '4', '163', '180', '0'),
('2007-04-28 00:00:00', '0', '163', '180', '0'),
('2007-04-29 00:00:00', '0', '163', '180', '0'),
('2007-04-30 00:00:00', '5', '168', '180', '0'),
('2007-05-01 00:00:00', '5', '173', '180', '0'),
('2007-05-02 00:00:00', '6', '179', '180', '0'),
('2007-05-03 00:00:00', '1', '180', '180', '0'),
('2007-05-04 00:00:00', '3', '180', '180', '0'),
('2007-05-05 00:00:00', '3', '180', '180', '0'),
('2007-05-06 00:00:00', '2', '180', '180', '0'),
('2007-05-07 00:00:00', '3', '180', '180', '0');



























---------------------------------- W O R K B E N C H  ------------------
-- Date Functions ------------------------------------------------------
- seletct date fields
select entrdate, resvddate,crnum, status from stcr;

-- find the year parts
SELECT entrdate, year(entrdate) as year1, year(resvddate)as year2,(year( resvddate ) - year( entrdate )) as difference FROM stcr;

-- find btw 2 years
SELECT entrdate, resvddate,crnum, status FROM stcr WHERE year( entrdate ) between 2006 and 2007;

-- find btw 2 months
SELECT entrdate, resvddate,crnum, status FROM stcr WHERE month( entrdate ) between '02' and '08';

-- months and years
SELECT entrdate, resvddate,crnum, status FROM stcr WHERE year( entrdate ) between 2006 and 2007 and month( entrdate ) between '02' and '08';

-- between two date
SELECT entrdate, resvddate,crnum FROM stcr  where entrdate BETWEEN '2006-12-31' AND '2007-03-31';


select '-------';
select now();
select date(now() + interval 2 day + interval + 1 month);


select date(now() + interval 2 day + interval + 1 month);


-- add MONTH, YEAR_MONTH, or YEAR and the resulting date has a day that is
-- larger than the maximum day for the new month, the day is adjusted to the
-- maximum days in the new month:

SELECT DATE_ADD('1998-01-30', INTERVAL 1 MONTH);

SELECT DATE_ADD('1998-01-30', INTERVAL 1 YEAR_MONTH);

SELECT DATE_ADD('1998-01-30', INTERVAL 1 YEAR);

select date(now() + interval 9 day + interval + 1 month - interval 1 year);