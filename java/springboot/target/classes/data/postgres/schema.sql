drop sequence if exists g_seq cascade;
create sequence g_seq start with 1;
drop table if exists greetings;
create table if not exists greetings 
(id  		int4 primary key default nextval('g_seq') not null,
 greet	text
);