DROP TABLE CUSTOMERS CASCADE CONSTRAINTS;
DROP TABLE ORDERS CASCADE CONSTRAINTS;
DROP TABLE PUBLISHER CASCADE CONSTRAINTS;
DROP TABLE AUTHOR CASCADE CONSTRAINTS;
DROP TABLE BOOKS CASCADE CONSTRAINTS;
DROP TABLE ORDERITEMS CASCADE CONSTRAINTS;
DROP TABLE BOOKAUTHOR CASCADE CONSTRAINTS;
DROP TABLE PROMOTION CASCADE CONSTRAINTS;
DROP TABLE ACCTMANAGER CASCADE CONSTRAINTS;
Create table Customers
(Customer#  NUMBER(4) PRIMARY KEY,
LastName VARCHAR2(10),
FirstName VARCHAR2(10),
Address VARCHAR2(20),
City VARCHAR2(12),
State VARCHAR2(2),
Zip VARCHAR2(5),
Referred NUMBER(4));
INSERT INTO CUSTOMERS
VALUES (1001, 'MORALES', 'BONITA', 'P.O. BOX 651', 'EASTPOINT', 'FL', '32328', NULL);
INSERT INTO CUSTOMERS
VALUES (1002, 'THOMPSON', 'RYAN', 'P.O. BOX 9835', 'SANTA MONICA', 'CA', '90404', NULL);
INSERT INTO CUSTOMERS 
VALUES (1003, 'SMITH', 'LEILA', 'P.O. BOX 66', 'TALLAHASSEE', 'FL', '32306', NULL); 
INSERT INTO CUSTOMERS 
VALUES (1004, 'PIERSON', 'THOMAS', '69821 SOUTH AVENUE', 'BOISE', 'ID', '83707', NULL); 
INSERT INTO CUSTOMERS 
VALUES (1005, 'GIRARD', 'CINDY', 'P.O. BOX 851', 'SEATTLE', 'WA', '98115', NULL); 
INSERT INTO CUSTOMERS 
VALUES (1006, 'CRUZ', 'MESHIA', '82 DIRT ROAD', 'ALBANY', 'NY', '12211', NULL); 
INSERT INTO CUSTOMERS 
VALUES (1007, 'GIANA', 'TAMMY', '9153 MAIN STREET', 'AUSTIN', 'TX', '78710', 1003); 
INSERT INTO CUSTOMERS 
VALUES (1008, 'JONES', 'KENNETH', 'P.O. BOX 137', 'CHEYENNE', 'WY', '82003', NULL); 
INSERT INTO CUSTOMERS 
VALUES (1009, 'PEREZ', 'JORGE', 'P.O. BOX 8564', 'BURBANK', 'CA', '91510', 1003); 
INSERT INTO CUSTOMERS 
VALUES (1010, 'LUCAS', 'JAKE', '114 EAST SAVANNAH', 'ATLANTA', 'GA', '30314', NULL); 
INSERT INTO CUSTOMERS 
VALUES (1011, 'MCGOVERN', 'REESE', 'P.O. BOX 18', 'CHICAGO', 'IL', '60606', NULL);  
INSERT INTO CUSTOMERS 
VALUES (1012, 'MCKENZIE', 'WILLIAM', 'P.O. BOX 971', 'BOSTON', 'MA', '02110', NULL); 
INSERT INTO CUSTOMERS 
VALUES (1013, 'NGUYEN', 'NICHOLAS', '357 WHITE EAGLE AVE.', 'CLERMONT', 'FL', '34711', 1006); 
INSERT INTO CUSTOMERS 
VALUES (1014, 'LEE', 'JASMINE', 'P.O. BOX 2947', 'CODY', 'WY', '82414', NULL); 
INSERT INTO CUSTOMERS 
VALUES (1015, 'SCHELL', 'STEVE', 'P.O. BOX 677', 'MIAMI', 'FL', '33111', NULL); 
INSERT INTO CUSTOMERS 
VALUES (1016, 'DAUM', 'MICHELL', '9851231 LONG ROAD', 'BURBANK', 'CA', '91508', 1010); 
INSERT INTO CUSTOMERS 
VALUES (1017, 'NELSON', 'BECCA', 'P.O. BOX 563', 'KALMAZOO', 'MI', '49006', NULL); 
INSERT INTO CUSTOMERS 
VALUES (1018, 'MONTIASA', 'GREG', '1008 GRAND AVENUE', 'MACON', 'GA', '31206', NULL); 
INSERT INTO CUSTOMERS 
VALUES (1019, 'SMITH', 'JENNIFER', 'P.O. BOX 1151', 'MORRISTOWN', 'NJ', '07962', 1003); 
INSERT INTO CUSTOMERS 
VALUES (1020, 'FALAH', 'KENNETH', 'P.O. BOX 335', 'TRENTON', 'NJ', '08607', NULL); 
 
Create Table Orders 
(Order# NUMBER(4) PRIMARY KEY, 
Customer# NUMBER(4), 
OrderDate DATE, 
ShipDate DATE, 
ShipStreet VARCHAR2(18), 
ShipCity VARCHAR2(15), 
ShipState VARCHAR2(2), 
ShipZip VARCHAR2(5)); 
 
INSERT INTO ORDERS 
VALUES (1000,1005,'31-MAR-03','02-APR-03','1201 ORANGE AVE', 'SEATTLE', 'WA', '98114'); 
INSERT INTO ORDERS 
VALUES (1001,1010,'31-MAR-03','01-APR-03', '114 EAST SAVANNAH', 'ATLANTA', 'GA', '30314'); 
INSERT INTO ORDERS 
VALUES (1002,1011,'31-MAR-03','01-APR-03','58 TILA CIRCLE', 'CHICAGO', 'IL', '60605'); 
INSERT INTO ORDERS 
VALUES (1003,1001,'01-APR-03','01-APR-03','958 MAGNOLIA LANE', 'EASTPOINT', 'FL', '32328'); 
INSERT INTO ORDERS 
VALUES (1004,1020,'01-APR-03','05-APR-03','561 ROUNDABOUT WAY', 'TRENTON', 'NJ', '08601'); 
INSERT INTO ORDERS 
VALUES (1005,1018,'01-APR-03','02-APR-03', '1008 GRAND AVENUE', 'MACON', 'GA', '31206'); 
INSERT INTO ORDERS 
VALUES (1006,1003,'01-APR-03','02-APR-03','558A CAPITOL HWY.', 'TALLAHASSEE', 'FL', '32307'); 
INSERT INTO ORDERS 
VALUES (1007,1007,'02-APR-03','04-APR-03', '9153 MAIN STREET', 'AUSTIN', 'TX', '78710'); 
INSERT INTO ORDERS 
VALUES (1008,1004,'02-APR-03','03-APR-03', '69821 SOUTH AVENUE', 'BOISE', 'ID', '83707'); 
INSERT INTO ORDERS 
VALUES (1009,1005,'03-APR-03','05-APR-03','9 LIGHTENING RD.', 'SEATTLE', 'WA', '98110'); 
INSERT INTO ORDERS 
VALUES (1010,1019,'03-APR-03','04-APR-03','384 WRONG WAY HOME', 'MORRISTOWN', 'NJ', '07960'); 
INSERT INTO ORDERS 
VALUES (1011,1010,'03-APR-03','05-APR-03', '102 WEST LAFAYETTE', 'ATLANTA', 'GA', '30311'); 
INSERT INTO ORDERS 
VALUES (1012,1017,'03-APR-03',NULL,'1295 WINDY AVENUE', 'KALMAZOO', 'MI', '49002'); 
INSERT INTO ORDERS 
VALUES (1013,1014,'03-APR-03','04-APR-03','7618 MOUNTAIN RD.', 'CODY', 'WY', '82414'); 
INSERT INTO ORDERS 
VALUES (1014,1007,'04-APR-03','05-APR-03', '9153 MAIN STREET', 'AUSTIN', 'TX', '78710'); 
INSERT INTO ORDERS 
VALUES (1015,1020,'04-APR-03',NULL,'557 GLITTER ST.', 'TRENTON', 'NJ', '08606'); 
INSERT INTO ORDERS 
VALUES (1016,1003,'04-APR-03',NULL,'9901 SEMINOLE WAY', 'TALLAHASSEE', 'FL', '32307'); 
INSERT INTO ORDERS 
VALUES (1017,1015,'04-APR-03','05-APR-03','887 HOT ASPHALT ST', 'MIAMI', 'FL', '33112'); 
INSERT INTO ORDERS 
VALUES (1018,1001,'05-APR-03',NULL,'95812 HIGHWAY 98', 'EASTPOINT', 'FL', '32328'); 
INSERT INTO ORDERS 
VALUES (1019,1018,'05-APR-03',NULL, '1008 GRAND AVENUE', 'MACON', 'GA', '31206'); 
INSERT INTO ORDERS 
VALUES (1020,1008,'05-APR-03',NULL,'195 JAMISON LANE', 'CHEYENNE', 'WY', '82003'); 
 
Create Table Publisher 
(PubID NUMBER(2), 
Name VarCHAR2(23), 
Contact VARCHAR2(15), 
Phone VARCHAR2(12)); 
 
INSERT INTO PUBLISHER 
VALUES(1,'PRINTING IS US','TOMMIE SEYMOUR','000-714-8321'); 
INSERT INTO PUBLISHER 
VALUES(2,'PUBLISH OUR WAY','JANE TOMLIN','010-410-0010'); 
INSERT INTO PUBLISHER 
VALUES(3,'AMERICAN PUBLISHING','DAVID DAVIDSON','800-555-1211'); 
INSERT INTO PUBLISHER 
VALUES(4,'READING MATERIALS INC.','RENEE SMITH','800-555-9743'); 
INSERT INTO PUBLISHER 
VALUES(5,'REED-N-RITE','SEBASTIAN JONES','800-555-8284'); 
 
Create Table Author 
(AuthorID Varchar2(4), 
Lname VARCHAR2(10), 
Fname VARCHAR2(10)); 
 
INSERT INTO AUTHOR 
VALUES ('S100','SMITH', 'SAM'); 
INSERT INTO AUTHOR 
VALUES ('J100','JONES','JANICE'); 
INSERT INTO AUTHOR 
VALUES ('A100','AUSTIN','JAMES'); 
INSERT INTO AUTHOR 
VALUES ('M100','MARTINEZ','SHEILA'); 
INSERT INTO AUTHOR 
VALUES ('K100','KZOCHSKY','TAMARA'); 
INSERT INTO AUTHOR 
VALUES ('P100','PORTER','LISA'); 
INSERT INTO AUTHOR 
VALUES ('A105','ADAMS','JUAN'); 
INSERT INTO AUTHOR 
VALUES ('B100','BAKER','JACK');  
INSERT INTO AUTHOR 
VALUES ('P105','PETERSON','TINA'); 
INSERT INTO AUTHOR 
VALUES ('W100','WHITE','WILLIAM'); 
INSERT INTO AUTHOR 
VALUES ('W105','WHITE','LISA'); 
INSERT INTO AUTHOR 
VALUES ('R100','ROBINSON','ROBERT'); 
INSERT INTO AUTHOR 
VALUES ('F100','FIELDS','OSCAR'); 
INSERT INTO AUTHOR 
VALUES ('W110','WILKINSON','ANTHONY'); 
 
 
 
Create table Books 
(ISBN VARCHAR2(10) PRIMARY KEY,
Title VARCHAR2(30), 
PubDate DATE, 
PubID NUMBER (2), 
Cost NUMBER (5,2), 
Retail NUMBER (5,2), 
Category VARCHAR2(12)); 
 
INSERT INTO BOOKS 
VALUES ('1059831198','BODYBUILD IN 10 MINUTES A DAY','21-JAN-01',4,18.75,30.95, 'FITNESS'); 
INSERT INTO BOOKS 
VALUES ('0401140733','REVENGE OF MICKEY','14-DEC-01',1,14.20,22.00, 'FAMILY LIFE'); 
INSERT INTO BOOKS 
VALUES ('4981341710','BUILDING A CAR WITH TOOTHPICKS','18-MAR-02',2,37.80,59.95, 'CHILDREN'); 
INSERT INTO BOOKS 
VALUES ('8843172113','DATABASE IMPLEMENTATION','04-JUN-99',3,31.40,55.95, 'COMPUTER'); 
INSERT INTO BOOKS 
VALUES ('3437212490','COOKING WITH MUSHROOMS','28-FEB-00',4,12.50,19.95, 'COOKING'); 
INSERT INTO BOOKS 
VALUES ('3957136468','HOLY GRAIL OF ORACLE','31-DEC-01',3,47.25,75.95, 'COMPUTER'); 
INSERT INTO BOOKS 
VALUES ('1915762492','HANDCRANKED COMPUTERS','21-JAN-01',3,21.80,25.00, 'COMPUTER'); 
INSERT INTO BOOKS 
VALUES ('9959789321','E-BUSINESS THE EASY WAY','01-MAR-02',2,37.90,54.50, 'COMPUTER'); 
INSERT INTO BOOKS 
VALUES ('2491748320','PAINLESS CHILD-REARING','17-JUL-00',5,48.00,89.95, 'FAMILY LIFE'); 
INSERT INTO BOOKS 
VALUES ('0299282519','THE WOK WAY TO COOK','11-SEP-00',4,19.00,28.75, 'COOKING'); 
INSERT INTO BOOKS 
VALUES ('8117949391','BIG BEAR AND LITTLE DOVE','08-NOV-01',5,5.32,8.95, 'CHILDREN'); 
INSERT INTO BOOKS 
VALUES ('0132149871','HOW TO GET FASTER PIZZA','11-NOV-02',4,17.85,29.95, 'SELF HELP'); 
INSERT INTO BOOKS 
VALUES ('9247381001','HOW TO MANAGE THE MANAGER','09-MAY-99',1,15.40,31.95, 'BUSINESS'); 
INSERT INTO BOOKS 
VALUES ('2147428890','SHORTEST POEMS','01-MAY-01',5,21.85,39.95, 'LITERATURE'); 
 
CREATE TABLE ORDERITEMS 
(ORDER# NUMBER(4), 
ITEM# NUMBER(2), 
ISBN VARCHAR2(10), 
QUANTITY NUMBER(3)); 
 
INSERT INTO ORDERITEMS 
VALUES (1000,1,'3437212490',1);  
INSERT INTO ORDERITEMS 
VALUES (1001,1,'9247381001',1);  
INSERT INTO ORDERITEMS 
VALUES (1001,2,'2491748320',1);  
INSERT INTO ORDERITEMS 
VALUES (1002,1,'8843172113',2);  
INSERT INTO ORDERITEMS 
VALUES (1003,1,'8843172113',1);  
INSERT INTO ORDERITEMS 
VALUES (1003,2,'1059831198',1); 
INSERT INTO ORDERITEMS 
VALUES (1003,3,'3437212490',1); 
INSERT INTO ORDERITEMS 
VALUES (1004,1,'2491748320',2); 
INSERT INTO ORDERITEMS 
VALUES (1005,1,'2147428890',1); 
INSERT INTO ORDERITEMS 
VALUES (1006,1,'9959789321',1); 
INSERT INTO ORDERITEMS 
VALUES (1007,1,'3957136468',3); 
INSERT INTO ORDERITEMS 
VALUES (1007,2,'9959789321',1); 
INSERT INTO ORDERITEMS 
VALUES (1007,3,'8117949391',1); 
INSERT INTO ORDERITEMS 
VALUES (1007,4,'8843172113',1); 
INSERT INTO ORDERITEMS 
VALUES (1008,1,'3437212490',2); 
INSERT INTO ORDERITEMS 
VALUES (1009,1,'3437212490',1); 
INSERT INTO ORDERITEMS 
VALUES (1009,2,'0401140733',1); 
INSERT INTO ORDERITEMS 
VALUES (1010,1,'8843172113',1); 
INSERT INTO ORDERITEMS 
VALUES (1011,1,'2491748320',1); 
INSERT INTO ORDERITEMS 
VALUES (1012,1,'8117949391',1); 
INSERT INTO ORDERITEMS 
VALUES (1012,2,'1915762492',2); 
INSERT INTO ORDERITEMS 
VALUES (1012,3,'2491748320',1); 
INSERT INTO ORDERITEMS 
VALUES (1012,4,'0401140733',1); 
INSERT INTO ORDERITEMS 
VALUES (1013,1,'8843172113',1); 
INSERT INTO ORDERITEMS 
VALUES (1014,1,'0401140733',2); 
INSERT INTO ORDERITEMS 
VALUES (1015,1,'3437212490',1); 
INSERT INTO ORDERITEMS 
VALUES (1016,1,'2491748320',1); 
INSERT INTO ORDERITEMS 
VALUES (1017,1,'8117949391',2); 
INSERT INTO ORDERITEMS 
VALUES (1018,1,'3437212490',1); 
INSERT INTO ORDERITEMS 
VALUES (1018,2,'8843172113',1); 
INSERT INTO ORDERITEMS 
VALUES (1019,1,'0401140733',1); 
INSERT INTO ORDERITEMS 
VALUES (1020,1,'3437212490',1); 
 
CREATE TABLE BOOKAUTHOR 
(ISBN VARCHAR2(10), 
AUTHORid VARCHAR2(4)); 
 
INSERT INTO BOOKAUTHOR 
VALUES ('1059831198','S100'); 
INSERT INTO BOOKAUTHOR 
VALUES ('1059831198','P100'); 
INSERT INTO BOOKAUTHOR 
VALUES ('0401140733','J100'); 
INSERT INTO BOOKAUTHOR 
VALUES ('4981341710','K100'); 
INSERT INTO BOOKAUTHOR 
VALUES ('8843172113','P105'); 
INSERT INTO BOOKAUTHOR 
VALUES ('8843172113','A100'); 
INSERT INTO BOOKAUTHOR 
VALUES ('8843172113','A105'); 
INSERT INTO BOOKAUTHOR 
VALUES ('3437212490','B100'); 
INSERT INTO BOOKAUTHOR 
VALUES ('3957136468','A100'); 
INSERT INTO BOOKAUTHOR 
VALUES ('1915762492','W100'); 
INSERT INTO BOOKAUTHOR 
VALUES ('1915762492','W105'); 
INSERT INTO BOOKAUTHOR 
VALUES ('9959789321','J100'); 
INSERT INTO BOOKAUTHOR 
VALUES ('2491748320','R100'); 
INSERT INTO BOOKAUTHOR 
VALUES ('2491748320','F100'); 
INSERT INTO BOOKAUTHOR 
VALUES ('2491748320','B100'); 
INSERT INTO BOOKAUTHOR 
VALUES ('0299282519','S100'); 
INSERT INTO BOOKAUTHOR 
VALUES ('8117949391','R100'); 
INSERT INTO BOOKAUTHOR 
VALUES ('0132149871','S100'); 
INSERT INTO BOOKAUTHOR 
VALUES ('9247381001','W100'); 
INSERT INTO BOOKAUTHOR 
VALUES ('2147428890','W105'); 
 
create table promotion 
(gift  varchar2(15), 
minretail number(5,2), 
maxretail number(5,2)); 
 
insert into promotion 
 values ('BOOKMARKER', 0, 12); 
 
insert into promotion 
 values ('BOOK LABELS', 12.01, 25); 
 
insert into promotion 
values ('BOOK COVER', 25.01, 56); 
 
insert into promotion 
values ('FREE SHIPPING', 56.01, 999.99); 
 
 
Commit; 
 
 