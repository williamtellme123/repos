-- Run this in cruises
insert into cruise_orders values (1,sysdate-600,sysdate-590, 1, 1);
insert into cruise_orders values (2,sysdate-600,sysdate-590, 2, 1);
insert into cruise_orders values (3,sysdate-500,sysdate-490, 1, 2);
insert into cruise_orders values (4,sysdate-500,sysdate-495, 1, 2);
insert into cruise_orders values (5,sysdate-495,sysdate-480,1,2);
insert into cruise_orders values (6,sysdate-505,sysdate-497,2,1);
insert into cruise_orders values (7,sysdate-490,sysdate-482,3,2);
insert into cruise_orders values (8,sysdate-501,sysdate-490,4,1);

update invoices set invoice_date = '04-JUN-01', total_price = 37450
where invoice_id in (5, 8, 10);

commit;

-- SETUP
Insert into ship_cabins values (30,2,'1241','Suite','Standard','Balcony',4,156,144);
Insert into ship_cabins  values (31,2,'1242','Stateroom','Standard','Ocean',2,280,null);
Insert into ship_cabins  values (32,2,'1243','Suite','Standard','Balcony',4,1247,425);
Insert into ship_cabins  values (33,2,'1244','Stateroom','Standard','Ocean',3,1151,null);
Insert into ship_cabins  values (34,2,'1245','Suite','Standard','Balcony',6,1749,425);
Insert into ship_cabins  values (35,2,'1246','Suite','Royal','Balcony',5,729,843);
Insert into ship_cabins  values (36,2,'1247','Stateroom','Large','None',2,333,null);
Insert into ship_cabins  values (37,2,'1248','Stateroom','Standard','Ocean',2,548,476);
Insert into ship_cabins  values (38,2,'1249','Stateroom','Large','Ocean',2,337,null);
Insert into ship_cabins  values (39,2,'1250','Suite','Presidential','Balcony',5,725,476);
Insert into ship_cabins  values (40,2,'1251','Suite','Presidential','Balcony',5,336,null);
Insert into ship_cabins  values (41,2,'1252','Suite','Royal','Balcony',5,244,374);
Insert into ship_cabins  values (42,2,'1253','Suite','Skyloft','Balcony',8,257,410);
Insert into ship_cabins  values (43,2,'1254','Stateroom','Standard','Ocean',2,130,null);
Insert into ship_cabins  values (44,2,'1255','Suite','Standard','Balcony',4,170,144);
Insert into ship_cabins  values (45,2,'1256','Stateroom','Standard','Ocean',3,124,null);
Insert into ship_cabins  values (46,2,'1257','Suite','Standard','Balcony',6,132,193);
Insert into ship_cabins  values (47,2,'1258','Stateroom','Large','None',2,153,null);
Insert into ship_cabins  values (48,2,'1259','Stateroom','Standard','Ocean',2,152,null);
Insert into ship_cabins  values (49,2,'1260','Suite','Presidential','None',5,1247,325);
Insert into ship_cabins  values (50,2,'1261','Suite','Presidential','Ocean',5,1247,null);
Insert into ship_cabins  values (51,2,'1262','Suite','Royal','Ocean',5,1247,null);
Insert into ship_cabins  values (52,2,'1263','Suite','Skyloft','Ocean',8,1150,225);
Insert into ship_cabins  values (53,2,'1264','Stateroom','Standard','Ocean',2,185,null);
Insert into ship_cabins  values (54,2,'1265','Suite','Standard','Ocean',4,622,150);
Insert into ship_cabins  values (55,2,'1266','Stateroom','Standard','Ocean',3,301,null);
Insert into ship_cabins  values (56,2,'1267','Suite','Standard','None',6,654,225);
Insert into ship_cabins  values (57,2,'1268','Stateroom','Large','None',2,250,null);
Insert into ship_cabins  values (58,2,'1269','Stateroom','Standard','Ocean',2,345,null);



insert into cruise_customers values (4,'Mike','West');
insert into cruise_customers values (5,'Al','Smith');
insert into cruise_customers values (6,'Trish','West');
insert into cruise_customers values (7,'Sammy','Teo');
insert into cruise_customers values (8,'Sully','Westcott');
insert into cruise_customers values (9, 'Tim','Falco');
Insert into employees values (8,1,'Harvey','Goldstein',2,null,null,null);
Insert into employees values (9,3,'Sully','Westcott',2,null,null,null);
Insert into employees values (10,4,'Sammy','Teo',2,null,null,null);
Insert into employees values (11,3,'Amy','Lee',2,null,null,null);
Insert into employees values (12,1,'Sully','Westcott',2,null,null,null);
Insert into employees values (13,2,'Tim','Falco',2,null,null,null);
Insert into employees values (14,1,'Susan','Thomas',2,null,null,null);
--commit;
--select * from cruises;
insert into cruises values(1,1,'ISLAND',1,5,'01-JAN-2012','01-JAN-2012','DOCK');
insert into cruises values(2,1,'ISLAND',1,5,'01-JAN-2012','01-JAN-2012','DOCK');
insert into cruises values(3,2,'ISLAND',1,5,'01-JAN-2012','01-JAN-2012','DOCK');
insert into cruises values(4,2,'ISLAND',2,5,'01-JAN-2012','01-JAN-2012','DOCK');
insert into cruises values(5,3,'ISLAND',2,5,'01-JAN-2012','01-JAN-2012','DOCK');
insert into cruises values(6,2,'ISLAND',2,5,'01-JAN-2012','01-JAN-2012','DOCK');
insert into cruises values(7,1,'ISLAND',1,5,'01-JAN-2012','01-JAN-2012','DOCK');
insert into cruises values(8,1,'ISLAND',1,5,'01-JAN-2012','01-JAN-2012','DOCK');
insert into cruises values(9,2,'ISLAND',1,5,'01-JAN-2012','01-JAN-2012','DOCK');
insert into cruises values(10,2,'ISLAND',2,5,'01-JAN-2012','01-JAN-2012','DOCK');
insert into cruises values(11,3,'ISLAND',2,5,'01-JAN-2012','01-JAN-2012','DOCK');
insert into cruises values(12,2,'ISLAND',2,5,'01-JAN-2012','01-JAN-2012','DOCK');
--select * from cruise_orders;


commit;