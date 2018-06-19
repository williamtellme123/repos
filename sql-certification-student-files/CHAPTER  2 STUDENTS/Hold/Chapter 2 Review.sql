-- =============================================================================
-- CHAPTER 2 Refresh
-- INLINE CONSTRAINTS AT TIME OF TABLE CREATION
-- Most common: system gives name
      drop table cruises0;
      create table cruises0
      (
          cruise_id number primary key,           -- system given name
          cruise_name varchar2(30) not null,
          cruise_number integer unique,
          destination varchar2(50) check(destination in ('Hawaii','Bahamas','Bermuda','Mexico','Day at Sea')),
          start_date date default sysdate,
          end_date date
      );
-- Common: user gives name
      drop table cruises1;
      create table cruises1
      (
          cruise_id number constraint cid_pk1 primary key,    -- user given name
          cruise_name varchar2(30) constraint cruise_name_nn1 not null,
          cruise_number integer constraint cnum_u1 unique,
          destination varchar2(50) constraint dest_ck1 check(destination in ('Hawaii','Bahamas','Bermuda','Mexico','Day at Sea')),
          start_date date default sysdate,
          end_date date
      );

-- OUT OF LINE AT TIME OF TABLE CREATION
-- Also very popular
    drop table cruises2;
    create table cruises2
    (
          cruise_id number,
          cruise_name varchar2(30) not null,
          cruise_number integer,
          destination varchar2(50),
          start_date date default sysdate,
          end_date date,
          constraint cruise_pk2 primary key (cruise_id),
          -- NOT VALID MUST BE INLINE constraint cruise_name_nn not null (cruise_name),
          constraint cruise_num_u2 unique (cruise_number),
          constraint destination_ck2 check (destination IN  ('Hawaii','Bahamas','Bermuda','Mexico','Day at Sea'))
          -- default must also be inline
    );

-- INLINE CONSTRAINTS AFTER TIME OF TABLE CREATION
-- Not common see Chapter 11, but need to know for exam
      drop table cruises3;
      create table cruises3
      (
          cruise_id number,
          cruise_name varchar2(30),
          cruise_number integer,
          destination varchar2(50),
          start_date date,
          end_date date
      );
    alter table cruises3 add primary key (cruise_id);
    alter table cruises3 modify (cruise_name not null);
    alter table cruises3 modify(start_date default sysdate); 
    alter table cruises3 add unique (cruise_number);
    alter table cruises3 add check(destination in ('Hawaii','Bahamas','Bermuda','Mexico','Day at Sea')); 


-- OUT OF LINE CONSTRAINTS AFTER TIME OF TABLE CREATION
-- Not common see Chapter 11, but know for exam
    drop table cruises4;
    create table cruises4
    (
        cruise_id number,
        cruise_name varchar2(30),
        cruise_number integer,
        destination varchar2(50),
        start_date date,
        end_date date
    );
    alter table cruises4 add constraint cid_pk4 primary key (cruise_id);
    --  NOT VALID FOR NOT NULL
    --  alter table cruises4 add constraint cname_nn not null (cruise_name);
    alter table cruises4 add constraint cnum_u4 unique (cruise_number);
    alter table cruises4 add constraint dest_ck4 check(destination in ('Hawaii','Bahamas','Bermuda','Mexico','Day at Sea')); 


-- FOREIGN KEY AT TIME OF TABLE CREATION
    drop table customers0;
    create table customers0
      (
          cust_id number primary key,
          cust_name varchar2(30));

    drop table orders0;
    create table orders0
      (
          ord_id number primary key,
          cid number,
          order_date date,
          constraint cust_fk foreign key(cid) references customers0( cust_id)
          );

-- FOREIGN KEY AFTER TIME OF TABLE CREATION
    drop table customers1;
    create table customers1
      (
          cust_id number,
          cust_name varchar2(30));
    
    drop table orders1;
    create table orders1
      (
          ord_id number,
          cid number,
          order_date date );
    
    alter table customers1 add primary key (cust_id);
    alter table orders1 add foreign key (cid) references customers1 (cust_id);
                  
                  
-- Inline foreign key
drop table new_customer;
create table new_customer
(cust_id integer primary key,
fname varchar2(24));

drop table new_orders;
create table new_orders
(order_id integer primary key,
order_date date,
customer_id integer references new_customer(cust_id));