
call edcsSP('750875');


select * from edcs_test2;

truncate table edcs_test2;
commit;

CREATE OR REPLACE procedure DASHBOARD.edcsSP2 (id IN varchar2) as
language java name 'EDCS_test.main(java.lang.String[])';
/