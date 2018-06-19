DROP TABLE myorder;
CREATE TABLE myorder (
    OID NUMBER,
    amount NUMBER,
    shipstate VARCHAR2(2),
    cust_id NUMBER
);

INSERT INTO myorder VALUES (1000, 555, 'TX', 10);
INSERT INTO myorder VALUES (1001, 755, 'MA', 20);
INSERT INTO myorder VALUES (1002, 855, 'CA', 10);
INSERT INTO myorder VALUES (1003, 1255, 'VT', 20);
INSERT INTO myorder VALUES (1004, 1855, 'AK', 10);
INSERT INTO myorder VALUES (1005, 925, 'WA', NULL);

CREATE TABLE mycustomer (
    cid NUMBER,
    NAME VARCHAR2(15),
    state varchar2(2)
);

INSERT INTO mycustomer VALUES(10, 'Fred', 'TX');
INSERT INTO mycustomer VALUES(20, 'Stew', 'LA');
INSERT INTO mycustomer VALUES(30, 'Martha', 'MA');

SELECT * FROM mycustomer;
SELECT * FROM myorder;
COMMIT;


--INSERT INTO cruise_customers VALUES (4, 'Buffy', 'Worthington');
--
--DESC cruise_orders;
--INSERT INTO cruise_orders VALUES (1, SYSDATE, SYSDATE, 1, 1);
--INSERT INTO cruise_orders VALUES (2, SYSDATE, SYSDATE, 2, 1);
--INSERT INTO cruise_orders VALUES (3, SYSDATE, SYSDATE, 3, 1);
--INSERT INTO cruise_orders VALUES (4, SYSDATE, SYSDATE, 4, 1);
--
