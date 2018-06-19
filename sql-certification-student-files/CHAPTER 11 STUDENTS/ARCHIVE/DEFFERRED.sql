

 

How to check a deferred constraint explicitly before committing it, 
check constraint isn’t currently being violated. 
It’s a good idea to do this check before 
releasing control to some other part of the program (which may 
not be expecting the deferred constraints) or committing: 

set constraint child_fk_parent immediate;
set constraint child_fk_parent immediate
ERROR at line 1:
ORA-02291: integrity constraint 
(OPS$TKYTE.CHILD_FK_PARENT) violated –
parent key not found
 

--  SET CONSTRAINT fails constraint was violated. 
--  The UPDATE on myparent was not rolled back (that would have 
--  violated the statement-level atomicity); it is still outstanding. 
--  Also note that the transaction is still working with the 
--  CHILD_FK_PARENT constraint deferred because the SET CONSTRAINT 
--  statement failed.

Let’s continue now by cascading the UPDATE to CHILD: 

update mychild set fk = 2;

set constraint 
child_fk_parent immediate;

commit;
Commit complete.
 