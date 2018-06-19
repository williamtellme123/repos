-- CTAS
create table customers1 as select * from customers;
create table orders1 as select * from orders;
create table orderitems1 as select * from orderitems;
create table books1 as select * from books;
create table bookauthor1 as select * from bookauthor;
create table author1 as select * from author;
create table publisher1 as select * from publisher;
create table promotion1 as select * from promotion;

drop table customers cascade constraints;
drop table orders cascade constraints;
drop table orderitems cascade constraints;
drop table books cascade constraints;
drop table bookauthor cascade constraints;
drop table author cascade constraints;
drop table publisher cascade constraints;
drop table promotion cascade constraints;

alter table customers1 rename to customers;;
alter table orders1 rename to orders;
alter table orderitems1 rename to orderitems;
alter table books1 rename to  books;
alter table bookauthor1 rename to bookauthor;
alter table author1 rename to author;
alter table publisher1 rename to publisher;
alter table promotion1 rename to promotion;

alter table customers add primary key (customer#);
alter table orders add primary key (order#);
alter table orderitems add primary key (order#,item#);
alter table books add primary key (isbn);
alter table bookauthor add primary key (isbn,authorid);
alter table author add primary key (authorid);
alter table publisher add primary key (pubid);

alter table orders add foreign key(customer#) references customers(customer#);
alter table orderitems add foreign key(order#) references orders(order#);
alter table orderitems add foreign key(isbn) references books(isbn);
alter table bookauthor add foreign key(isbn) references books(isbn);
alter table bookauthor add foreign key(authorid) references author(authorid);
alter table books add foreign key(pubid) references publisher(pubid);

