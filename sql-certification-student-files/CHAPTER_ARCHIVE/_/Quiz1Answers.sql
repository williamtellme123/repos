create table students
(stud_id integer primary key,
status varchar2(10),
passcode varchar2(10) unique,
constraint chk_status check (status in ('Full Time','Part Time'))
);


insert into students values (199,'FULL TIME',null);
Fails because FULL TIME does not equal Full Time

insert into students (stud_id) values (203);
Passes

insert into students values (200,null,null);
Passes

insert into students (status, passcode, stud_id) values ('Part Time', 'HD*87', 204);
Passes

insert into students values (201,null,'Z@TPF');
Passes

insert into students values (202,Part Time,'YHD0');
Fails Part Time is not inside single ticks



create table painters
(painter_id integer,
rate number(4,2),
tax_id varchar2(10) unique,
constraint p_pk primary key (painter_id)
);

insert into painters (rate, painter_id) values (99.996, 200); 
Fails rate number(4,2) will hold up to 99.99 however 99.996 rounds to 100

insert into painters values (211, 49.99, '777888'); 
Passes
insert into painters (tax_id, rate, painter_id) values ('777889', 99.991, 223); 
Fails Tax_id is not unique

insert into painters values (242, 19.49); 
Fails not enough values

insert into painters (tax_id, rate) values ('888999', 21.75); 
Fails cannot insert null into patiner_id

insert into painters values (444, 50, '989898');
Passes
