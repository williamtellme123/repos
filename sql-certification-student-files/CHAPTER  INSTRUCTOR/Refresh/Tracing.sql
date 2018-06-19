-- login as system
drop role  tkprofer;
create role c##tkprofer;
grant select on v_$datafile   to c##tkprofer;;
grant select on v_$latchname  to c##tkprofer;;
grant select on v_$log        to c##tkprofer;;
grant select on v_$logfile    to c##tkprofer;;
grant select on v_$thread     to c##tkprofer;;
grant select on extent_to_object  to c##tkprofer;;
grant tkprofer to dba with admin option;

C:\app\Billy\diag\rdbms\orcl\orcl\trace>tkprof.exe orcl_ora_5448_billy_trace_id.
trc billt.txt

TKPROF: Release 12.1.0.2.0 - Development on Wed Nov 9 12:42:07 2016

Copyright (c) 1982, 2015, Oracle and/or its affiliates.  All rights reserved.