--Keep the model simple (star schema is fine)
--Denormalise tables
--Keep track of changes that occur over time on dimension attributes
--
--Use calendar tables (static, read-only)
--
---- Days (calendar date)
--CREATE TABLE calendar (
---- 
--days since January 1, 4712 BC
--id_day
--INTEGER NOT NULL
--PRIMARY KEY
--,
--sql_date DATE NOT NULL UNIQUE,
--month_day INTEGER NOT NULL,
--month INTEGER NOT NULL,
--year INTEGER NOT NULL,
--week_day_str CHAR(3) NOT NULL,
--month_str CHAR(3) NOT NULL,
--year_day INTEGER NOT NULL,
--year_week INTEGER NOT NULL,
--week_day INTEGER NOT NULL,
--year_quarter INTEGER NOT NULL,
--work_day INTEGER NOT NULL DEFAULT '1'
--...
--);
--
--
---- Days (calendar date)
--create table calendar (
---- days since january 1, 4712 bc
--id_day integer not null primary key,
--sql_date date not null unique,
--month_day integer not null,
--month integer not null,
--year integer not null,
--week_day_str char(3) not null,
--month_str char(3) not null,
--year_day integer not null,
--year_week integer not null,
--week_day integer not null,
--year_quarter integer not null,
--work_day integer not null default '1'
--...
--);
--GENERAL FEATURES
--STORED PROCEDURES
--TABLESPACES


--TABLE PARTITIONING
--SCHEMAS / NAMESPACES
--VIEWS
--WINDOWING FUNCTIONS AND WITH QUERIES




create schema interview;
TABLESPACES
--Can be created or removed at anytime
--Allow to store objects such as tables and indexes on different locations
--Good for scalability
--Good for performances

--Horizonatal table partitioning
