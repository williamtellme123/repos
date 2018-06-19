call DASHBOARD.km_edcsSPb('');

select * from edcs_test2;

exec dbms_java.grant_permission( 'DASHBOARD', 'SYS:java.net.SocketPermission', '171.70.67.174:80', 'connect,resolve' );