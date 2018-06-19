select  
      ic_key
    , src_version 
    , src_edcs_doc_num
    , fg_edcs_doc_num
    , fg_edcs_status
    , fg_edcs_status_date
    , fg_edcs_rev
    , fg_title
    , fg_file_name
    , fg_edcs_rev
    , fg_edcs_approved_date
    , fg_edcs_error
    , wf_status
    , wf_status_date
    , last_modified_by
    , last_modified_date
from ic
where 1=1
and ic_key in ('IC-130','IC-4009','IC-4010','IC-4011','IC-4012','IC-4106','IC-4107', 'IC-4108', 'IC-4109', 'IC-4110','IC-4113','IC-4111', 'IC-4112', 'IC-4114', 'IC-4115','IC-4116', 'IC-4117', 'IC-4118', 'IC-4119', 'IC-4120','IC-4121', 'IC-4122', 'IC-4123', 'IC-4124','IC-4125', 'IC-130', 'IC-4135', 'IC-4140', 'IC-4145','IC-4127', 'IC-4132', 'IC-4137', 'IC-4142', 'IC-4147','IC-4126', 'IC-4131', 'IC-4136', 'IC-4141', 'IC-4146','IC-4152','IC-4149','IC-4150','IC-4152')
and fg_edcs_status is not null
and fg_edcs_status_date is null
and  fg_edcs_rev is not null 
and  fg_watch_flag is not null and fg_watch_flag = 'Y'  
and (wf_status is null or wf_status not in ('Ignore', 'Replaced', 'Cancelled'))
;

update ic
set fg_edcs_status_date = null
where 1=1
and ic_key in ('IC-4009','IC-4010','IC-4011','IC-4012','IC-4106','IC-4107', 'IC-4108', 'IC-4109', 'IC-4110','IC-4113','IC-4111', 'IC-4112', 'IC-4114', 'IC-4115','IC-4116', 'IC-4117', 'IC-4118', 'IC-4119', 'IC-4120','IC-4121', 'IC-4122', 'IC-4123', 'IC-4124','IC-4125', 'IC-130', 'IC-4135', 'IC-4140', 'IC-4145','IC-4127', 'IC-4132', 'IC-4137', 'IC-4142', 'IC-4147','IC-4126', 'IC-4131', 'IC-4136', 'IC-4141', 'IC-4146','IC-4152','IC-4149','IC-4150','IC-4152')
and fg_edcs_status is not null
and fg_edcs_status_date is not null;
commit;
rollback;

select  
      ic_key
    , src_version 
    , src_edcs_doc_num
    , fg_edcs_doc_num
    , fg_edcs_status
    , fg_edcs_status_date
    , fg_edcs_rev
    , fg_title
    , fg_file_name
    , fg_edcs_rev
    , fg_edcs_approved_date
    , fg_edcs_error
    , wf_status
    , wf_status_date
    , last_modified_by
    , last_modified_date
from ic
where 1=1
--  and ic_key in ('IC-4009') 
--  and ic_key in ('IC-4010'
--  and ic_key in ('IC-4011')
--  and ic_key in ('IC-4012')
--  and ic_key in ('IC-4106')
--  and ic_key in ('IC-4107', 'IC-4108', 'IC-4109', 'IC-4110')
--  and ic_key in ('IC-4113') 
--  and ic_key in ('IC-4111', 'IC-4112', 'IC-4114', 'IC-4115')
--  and ic_key in ('IC-4116', 'IC-4117', 'IC-4118', 'IC-4119', 'IC-4120','IC-4121', 'IC-4122', 'IC-4123', 'IC-4124')
--  and ic_key in ('IC-4125', 'IC-4130', 'IC-4135', 'IC-4140', 'IC-4145')
--  and ic_key in ('IC-4127', 'IC-4132', 'IC-4137', 'IC-4142', 'IC-4147')
--  and ic_key in ('IC-4126', 'IC-4131', 'IC-4136', 'IC-4141', 'IC-4146')
--  and ic_key in ('IC-4152')
--  and ic_key in ('IC-4149')
--  and ic_key in ('IC-4150') 
--  and ic_key in ('IC-4051') :: fg_watch_flag = 'N' 
--  and ic_key in ('IC-4152')
;

 select  
  i.ic_key   
 , i.src_version   
 , i.fg_edcs_doc_num   
 , i.fg_edcs_rev   
 , i.fg_edcs_status
 , i.fg_edcs_approved_date
 , i.fg_edcs_status_date   
 , i.fg_edcs_error   
 , i.wf_status   
 , i.wf_status_date   
 from  km_regression_1.ic i  
 where fg_edcs_doc_num is not null  
  and  i.fg_edcs_rev is not null 
  and  i.fg_watch_flag is not null and i.fg_watch_flag = 'Y'  
  and (i.wf_status is null or i.wf_status not in ('Ignore', 'Replaced', 'Cancelled'))
  and fg_edcs_status is not null
  and fg_edcs_status_date is null
  order by 3, substr(ic_key, 4, length(ic_key));
  
--update ic set fg_edcs_approved_date = null where 1=1
--and ic_key in ('IC-4009')
--and src_version = 1;    

--commit;


select  
     src_version 
    , ic_key
    , src_edcs_doc_num
    , fg_edcs_doc_num
    , fg_edcs_status
    , fg_edcs_rev
    , fg_title
    , fg_file_name
    , fg_edcs_rev
    , fg_edcs_status_date
    , fg_edcs_approved_date
    , fg_edcs_error
    , fg_watch_flag
    , wf_status
    , wf_status_date
    , last_modified_by
    , last_modified_date
from ic
where 1=1 
and fg_edcs_status is not null
and fg_edcs_status_date is null 
order by 1 desc;












4152
select ic_key, fg_edcs_status, fg_edcs_status_date 
from ic 
where 1=1 
and fg_edcs_status is not null
and fg_edcs_status_date is null 
order by 1 desc;


select fg_edcs_status, FG_EDCS_STATUS_DATE, ic_key, src_version from ic i 
where ic_key = 'IC-99' and
i.fg_edcs_doc_num is not null and 
i.fg_edcs_rev is not null  and 
i.fg_watch_flag is not null and
i.fg_watch_flag = 'Y'  and
(i.wf_status is null or i.wf_status not in ('Ignore', 'Replaced', 'Cancelled')) order by ic_key, src_version;




select  
      ic_key
    , src_version
    , src_edcs_doc_num
    , src_status
    , src_title
    , src_file_name
    , src_status_date
    , src_edcs_error
    , wf_status
    , wf_status_date
    , last_modified_by
    , last_modified_date
from ic 
where 1=1
and src_edcs_doc_num = '764229'


-- -----------------------------------------------------
-- ISSUE 31: Check in Prod 
-- 
select  
      ic_key
    , src_version
    , src_edcs_doc_num
    , src_status
    , src_title
    , src_file_name
    , src_status_date
    , src_edcs_error
    , wf_status
    , wf_status_date
    , last_modified_by
    , last_modified_date
from ic 
where 1=1
--and ic_key in ('IC-4165')
and src_edcs_doc_num = '764229'

-- and last_modified_by like '%EDCS%'
-- and src_status = 'Approved' 
-- and ic_key = 'IC-822' 
-- and src_edcs_doc_num = '807033'
-- and src_version > 12
order by 1 desc;


select ic_key, src_version, src_status, wf_status, fg_edcs_status from ic where ic_key = 'IC-4164';


commit;
select
      pk_key   
    , entered_date
    , entered_by
    , history_action
    , ic_key
    , src_version
    , src_edcs_doc_num
    , src_status
    , src_title
    , src_file_name
    , src_status_date
    , src_edcs_error
    , wf_status
    , wf_status_date
    , last_modified_by
    , last_modified_date
from ic_history 
where 1=1
-- and entered_by like '%EDCS%';
and ic_key in ('IC-4165')
-- and src_status = 'Approved' 
-- and ic_key = 'IC-822' 
-- and src_edcs_doc_num = '807033'
-- and src_version > 12
order by 1 desc;


select * from ic_history where ic_key = 'IC-4164' order by pk_key desc;



-- -----------------------------------------------------
-- ISSUE 31: When new source row inserted the previous row src_approvedis Fg is being updated in some case when no changes are found in EDCS
-- changed the edcswatch code to compare kmTracker status "Approvals in Progress" = EDCS Status = "Approved"
select  
      ic_key
    , src_version
    , src_edcs_doc_num
    , src_status
    , src_title
    , src_file_name
    , src_status_date
    , src_edcs_error
    , wf_status
    , wf_status_date
    , last_modified_by
    , last_modified_date
from ic 
where 1=1
and ic_key in ('IC-4007')
-- and src_status = 'Approved' 
-- and ic_key = 'IC-822' 
-- and src_edcs_doc_num = '807033'
-- and src_version > 12
order by 1 desc;

update ic 
set src_status = 'Approvals in Progress'
where ic_key in ('IC-4007')
and src_version = 3;

commit;


select  
      entered_by
    , entered_date
    , history_action
    , ic_key
    , src_version
    , src_edcs_doc_num
    , src_status
    , src_title
    , src_file_name
    , src_status_date
    , src_edcs_error
    , wf_status
    , wf_status_date
    , last_modified_by
    , last_modified_date
from ic_history 
where 1=1
-- and src_status = 'Approved' 
and ic_key in ('IC-4007')
--, 'IC-181', 'IC-131') 
-- and src_edcs_doc_num = '807033'
-- and src_version > 12
order by 2 desc;


select     entered_by
    , entered_date
    , history_action
    , ic_key
    , src_version
from ic_history
order by 2 desc;    

-- 4007, 181, and 131 








-- -----------------------------------------------------
-- ISSUE 30: Fg is being updated in some case when no changes are found in EDCS
-- changed the edcswatch code to compare kmTracker status "Approvals in Progress" = EDCS Status = "Approved"

select  
      ic_key
    , src_edcs_doc_num
    , fg_edcs_doc_num
    , fg_edcs_status
    , fg_edcs_rev
    , fg_title
    , fg_file_name
    , fg_edcs_rev
    , fg_edcs_status_date
    , fg_edcs_approved_date
    , fg_edcs_error
    , wf_status
    , wf_status_date
    , last_modified_by
    , last_modified_date
from ic 
where 1=1 
and ic_key = 'IC-4011' 
and fg_edcs_doc_num = '759636'
order by 1 desc;

select ic_key from ic where fg_edcs_doc_num = '759636' 
 and ic_key = 'IC-4011';


select  
      entered_by
    , entered_date
    , history_action
    , ic_key
    , fg_edcs_doc_num
    , fg_edcs_status
    , fg_edcs_rev
    , fg_title
    , fg_file_name
    , fg_edcs_rev
    , fg_edcs_status_date
    , fg_edcs_approved_date
    , fg_edcs_error
    , wf_status
    , wf_status_date
    , last_modified_by
    , last_modified_date
from ic_history 
where 1=1 
and ic_key = 'IC-4011' 
and fg_edcs_doc_num = '759636'
order by 2 desc;



-- APPROVALS IN PROGRESS
select
         ic_key
        , src_version 
        , fg_edcs_doc_num
        , fg_edcs_status
        , fg_edcs_rev
        , fg_title
        , fg_file_name
        , fg_edcs_rev
        , fg_edcs_status_date
        , fg_edcs_approved_date
        , fg_edcs_error
        , wf_status
        , wf_status_date
        , last_modified_by
        , last_modified_date
from ic 
where 1=1 
and ic_key = 'IC-4011' 
and fg_edcs_doc_num = '759636';
and last_modified_date =  to_date('11/01/2010 12:34:47', 'DD/MM/YYYY HH24:MI:SS');








select ic_key, fg_edcs_rev, fg_edcs_doc_num, fg_edcs_status, fg_edcs_status_date
from ic
where ic_key in 
        (
            select distinct ic_key from (
                select    fg_edcs_doc_num
                        , fg_edcs_status
                        , fg_edcs_rev
                        , ic_key
                        , wf_status
                        , last_modified_by
                        , last_modified_date
                        , fg_title
                        , fg_file_name
                        , fg_file_type
                        , fg_edcs_rev
                        , fg_edcs_status_date
                        , fg_edcs_approved_date
                        , fg_edcs_error
                from IC where fg_edcs_status like '%Approvals%'
            )
         )   
        ;
and ic_key = 'IC-814';

select count(*) from ic where fg_edcs_doc_num = '759636';




select column_name, table_name from all_tab_cols where table_name = 'IC_HISTORY'
and column_name LIKE 'PROJECTED_RELEASE%';





insert into IC
( 
         last_modified_date
        , ic_key
        , src_version
        , src_origin
        , src_title
        , team
        , sme
        , src_technology_type
        , src_pass_through_flag
        , src_status
        , src_status_date
        , src_project_name
        , src_underlying_technology
        , src_components
        , src_edcs_doc_num
        , src_edcs_approved_date
        , src_edcs_error
        , src_remedy_ticket_num
        , src_url
        , src_space_name
        , src_path
        , src_file_name
        , src_file_type
        , src_location
        , src_date_captured
        , src_3rd_party_origin_flag
        , src_3rd_party_company
        , src_referenced_doc
        , src_derived_from
        , src_related_doc
        , src_3rdparty_content_flag
        , src_3rdparty_content_details
        , src_remediation_unique_id
        , src_st_project_name
        , src_st_views
        , src_st_label
        , src_exp_date
        , wf_status
        , wf_status_date
        , wf_owner
        , wf_issue_flag
        , wf_comment
        , fg_title
        , fg_file_name
        , fg_file_type
        , fg_edcs_doc_num
        , fg_edcs_rev
        , fg_edcs_status
        , fg_edcs_status_date
        , fg_edcs_approved_date
        , fg_edcs_error
        , fg_delivered_technology
        , fg_3rd_party_content_flag
        , fg_3rd_party_content_details
        , fg_referenced_docs
        , fg_derived_from
        , fg_related_docs
        , fg_release
        , rts_location
        , rts_file_name
        , comments
        , misc_1
        , misc_2
        , misc_3
        , last_modified_by
        , fg_shipped
        , fg_watch_flag
)
select 
         last_modified_date
        , ic_key
        , src_version
        , src_origin
        , src_title
        , team
        , sme
        , src_technology_type
        , src_pass_through_flag
        , src_status
        , src_status_date
        , src_project_name
        , src_underlying_technology
        , src_components
        , src_edcs_doc_num
        , src_edcs_approved_date
        , src_edcs_error
        , src_remedy_ticket_num
        , src_url
        , src_space_name
        , src_path
        , src_file_name
        , src_file_type
        , src_location
        , src_date_captured
        , src_3rd_party_origin_flag
        , src_3rd_party_company
        , src_referenced_doc
        , src_derived_from
        , src_related_doc
        , src_3rdparty_content_flag
        , src_3rdparty_content_details
        , src_remediation_unique_id
        , src_st_project_name
        , src_st_views
        , src_st_label
        , src_exp_date
        , wf_status
        , wf_status_date
        , wf_owner
        , wf_issue_flag
        , wf_comment
        , fg_title
        , fg_file_name
        , fg_file_type
        , fg_edcs_doc_num
        , fg_edcs_rev
        , fg_edcs_status
        , fg_edcs_status_date
        , fg_edcs_approved_date
        , fg_edcs_error
        , fg_delivered_technology
        , fg_3rd_party_content_flag
        , fg_3rd_party_content_details
        , fg_referenced_docs
        , fg_derived_from
        , fg_related_docs
        , fg_release
        , rts_location
        , rts_file_name
        , comments
        , misc_1
        , misc_2
        , misc_3
        , last_modified_by
        , fg_shipped
        , fg_watch_flag
from ic_history
where 1=1
and ic_key = 'IC-4011' 
and fg_edcs_doc_num = '759636'
and src_version = 3
and pk_key = 1390
order by last_modified_date desc;
and last_modified_date =  to_date('11/01/2010 12:34:47', 'DD/MM/YYYY HH24:MI:SS');



pk 1390

ALTER TABLE IC
DROP COLUMN projected_release;
commit;











select   pk_key 
        , src_origin
        , ic_key
        , src_version
        , entered_date
        , entered_by
        , history_action
        , fg_edcs_doc_num
        , fg_edcs_status
        , ic_key
        , wf_status
        , last_modified_by
        , last_modified_date
        , fg_title
        , fg_file_name
        , fg_file_type
        , fg_edcs_rev
        , fg_edcs_status_date
        , fg_edcs_approved_date
        , fg_edcs_error
from IC_history where fg_edcs_status like '%Approvals%'
and ic_key = 'IC-4011'
order by entered_date desc;

delete from ic_history where pk_key = 1624;
commit;



where ic_Key = 'IC-145';
select FG_EDCS_DOC_NUM,ic_key,wf_status, last_modified_by, last_modified_date,FG_TITLE,FG_FILE_NAME,FG_FILE_TYPE,FG_EDCS_REV,FG_EDCS_STATUS,FG_EDCS_STATUS_DATE,FG_EDCS_APPROVED_DATE,FG_EDCS_ERROR
from ic where 1=1 and ic_key in ('IC-145') order by to_number(substr(ic_key,4,length(ic_key))), src_version ;







select * from IC
where ic_Key = 'IC-145';
select FG_EDCS_DOC_NUM,ic_key,wf_status, last_modified_by, last_modified_date,FG_TITLE,FG_FILE_NAME,FG_FILE_TYPE,FG_EDCS_REV,FG_EDCS_STATUS,FG_EDCS_STATUS_DATE,FG_EDCS_APPROVED_DATE,FG_EDCS_ERROR
from ic where 1=1 and ic_key in ('IC-145') order by to_number(substr(ic_key,4,length(ic_key))), src_version ;

-- --------------------------------------------------------------------------------------------
-- FIRST RUN after adding fg_watch_flag
-- -- FG 
select ic_key, fg_watch_flag, fg_edcs_doc_num,fg_edcs_rev, wf_status
from ic 
where 1=1
and (
        (fg_edcs_doc_num = '759636'  and fg_edcs_rev = 2) OR
        (fg_edcs_doc_num = '824375'  and fg_edcs_rev = 1) OR   
        (fg_edcs_doc_num = '759636'  and fg_edcs_rev = 2) OR
        (fg_edcs_doc_num = '759636'  and fg_edcs_rev = 2) OR
        (fg_edcs_doc_num = '750875'  and fg_edcs_rev = 3)
     )
order by 2,1        
    ;  

 select  
  i.ic_key   
 , i.src_version   
 , i.fg_edcs_doc_num   
 , i.fg_edcs_rev   
 , i.fg_edcs_status   
 , i.fg_edcs_status_date   
 , i.fg_edcs_error   
 , i.wf_status   
 , i.wf_status_date   
 from km_regression_1.ic i  
 where i.fg_edcs_doc_num is not null  
  and  i.fg_edcs_rev is not null 
  and  i.fg_watch_flag is not null 
  and i.fg_watch_flag = 'Y'  
  and (i.wf_status is null or i.wf_status not in ('Ignore', 'Replaced', 'Cancelled')); 

select distinct ic_key from ic 
where 1=1
  and fg_watch_flag = 'Y'
  and fg_edcs_doc_num is not null  
  and fg_edcs_rev is not null 
  and fg_watch_flag is not null 
  and (wf_status is null or wf_status not in ('Ignore', 'Replaced', 'Cancelled'))  ;

-- --------------------------------------------------------------------------------------------
-- Issue 4
--    SOURCE
--            Src rev not found error not logged when rev is too high.
--            IC-4005 rev 2 & 3 Rev 2 exists in EDCS. Rev 3 does not.  No error was logged in src_edcs_error for rev 3 
--    RESULTS
--            update src_version = 2 to match EDCS
--            give an error on src_version = 3  
select ic_key, src_version, src_edcs_doc_num, src_title, src_file_name, src_status, src_edcs_error, src_edcs_doc_num, src_status_date, wf_status, last_modified_by, last_modified_date
from ic where 1=1 and ic_key in ('IC-4005'); 

commit; 

select entered_by,entered_date,history_action, ic_key, src_version, src_edcs_doc_num, src_title, src_file_name, src_status, src_edcs_error, src_edcs_doc_num, src_status_date, wf_status, last_modified_by, last_modified_date
from ic_history where 1=1 and ic_key in ('IC-4005') order by pk_key desc;


update ic set src_status = null, src_status_date = null, src_title = null, src_file_name = null, src_edcs_error=null
where 1=1 and ic_key in ('IC-4005');
commit;
rollback;

update ic set wf_status = 'Ready to Ship' where 1=1 and ic_key in ('IC-4086');
update ic set fg_edcs_status = 'Draft', wf_status = 'Ready to Ship' where 1=1 and ic_key in ('IC-4086'); 
commit;

-- --------------------------------------------------------------------------------------------
-- Issue 14
-- -- SOURCE
--          Src status was set to “Approved”. EDCS watch changed to “Approvals in Progress”
--          IC-4007 v3 Version 1,2 & 3 were defined in tracker

select ic_key, src_version, src_edcs_doc_num, src_title, src_file_name, src_status, src_edcs_error, src_edcs_doc_num, src_status_date, wf_status, last_modified_by, last_modified_date
from ic 
where 1=1 and ic_key in ('IC-4007'); 

commit; 
select entered_by,entered_date,history_action, ic_key, src_version, src_edcs_doc_num, src_title, src_file_name, src_status, src_edcs_error, src_edcs_doc_num, src_status_date, wf_status, last_modified_by, last_modified_date
from ic_history where 1=1 and ic_key in ('IC-4007') order by pk_key desc;

delete from ic_history where entered_by = 'KM_REGRESSION_1'; 
commit;

update ic set src_status = 'Approved', src_status_date = to_date('13/03/2009', 'DD/MM/YYYY')  where 1=1 and ic_key in ('IC-4007') and src_version = 3 ;

update ic set src_status = null, src_status_date = null, src_title = null, src_file_name = null, src_edcs_error=null
where 1=1 and ic_key in ('IC-4005');
commit;
rollback;


--update ic set wf_status = 'Ready to Ship' where 1=1 and ic_key in ('IC-4086');
--update ic set fg_edcs_status = 'Draft', wf_status = 'Ready to Ship' where 1=1 and ic_key in ('IC-4086'); 
--commit;
-- --------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------


-- Issue 16
-- -- SOURCE
--       last_updated_date and last_updated_by not correct after EDCS Watch run
--       IC-4078 v1
--       EDCS# 999988 does not exist in EDCS. 
--       Watch program ran 12/3/09 7 updated the src_edcs_error correctly.
--       But IC row last_modified_date  is 12/2/09 (should be 12/3/09) and last_modified_by is nannrodr (should be EDCS_Watch). Ic-4079 v98 has the same error.

--select ic_key, src_version, src_edcs_doc_num, src_title, src_file_name, src_status, src_edcs_error, src_status_date, wf_status, last_modified_by, last_modified_date
--from ic where 1=1 and ic_key in ('IC-4078') order by to_number(substr(ic_key,4,length(ic_key))), src_version ;

--select ic_key, src_version, src_edcs_doc_num, src_title, src_file_name, src_status, src_edcs_error, src_status_date, wf_status, last_modified_by, last_modified_date
--from ic where 1=1 and ic_key in ('IC-4079') order by to_number(substr(ic_key,4,length(ic_key))), src_version ;

--update ic set src_edcs_error = null where 1=1 and ic_key in ('IC-4078');
--update ic set src_edcs_error = null where 1=1 and ic_key in ('IC-4079');

--commit;

-- --------------------------------------------------------------------------------------------
-- Issue 19
-- -- SOURCE
--            fg_edcs_approved_date set to null by watch program    
--            ic-4081 had 01-DEC-2009. Watch program reset to null
select ic_key,wf_status, last_modified_by, last_modified_date,FG_TITLE,FG_FILE_NAME,FG_FILE_TYPE,FG_EDCS_DOC_NUM,FG_EDCS_REV,FG_EDCS_STATUS,FG_EDCS_STATUS_DATE,FG_EDCS_APPROVED_DATE,FG_EDCS_ERROR
from ic where 1=1 and ic_key in ('IC-4082') order by to_number(substr(ic_key,4,length(ic_key))), src_version ;

select pk_key, ic_key, history_action,wf_status, last_modified_by, last_modified_date ,FG_TITLE,FG_FILE_NAME,FG_FILE_TYPE,FG_EDCS_DOC_NUM,FG_EDCS_REV,FG_EDCS_STATUS,FG_EDCS_STATUS_DATE,FG_EDCS_APPROVED_DATE,FG_EDCS_ERROR
from ic_history where 1=1 and ic_key in ('IC-4082') and pk_key = 731 order by to_number(substr(ic_key,4,length(ic_key))), src_version ;

select ic_key, audit_action, src_version, src_edcs_doc_num, src_file_name, src_status, src_status_date, src_edcs_error, src_status_date, wf_status, last_modified_by, last_modified_date
,FG_TITLE,FG_FILE_NAME,FG_FILE_TYPE,FG_EDCS_DOC_NUM,FG_EDCS_REV,FG_EDCS_STATUS,FG_EDCS_STATUS_DATE,FG_EDCS_APPROVED_DATE,FG_EDCS_ERROR
from ic_audit_trail where 1=1 and ic_key in ('IC-4081') order by to_number(substr(ic_key,4,length(ic_key))), src_version ;


-- --------------------------------------------------------------------------------------------
-- Issue 20
-- -- FG
--            wf_status not set to Rejected

--            ic-4085 
--            fg_edcs_status = Rejected,
--            wf_status = Approved

--            The fg is rejected in EDCS.
--            Watch program runs
--            Wf_status is still Approved in tracker, should be Rejected.
select ic_key,wf_status, last_modified_by, last_modified_date,FG_TITLE,FG_FILE_NAME,FG_FILE_TYPE,FG_EDCS_DOC_NUM,FG_EDCS_REV,FG_EDCS_STATUS,FG_EDCS_STATUS_DATE,FG_EDCS_APPROVED_DATE,FG_EDCS_ERROR
from ic where 1=1 and ic_key in ('IC-4085') order by to_number(substr(ic_key,4,length(ic_key))), src_version ;

update ic set wf_status = 'Approved', fg_edcs_status = 'Draft' where 1=1 and ic_key in ('IC-4085');
--update ic set fg_edcs_status = 'Draft', wf_status = 'Ready to Ship' where 1=1 and ic_key in ('IC-4086'); 
commit;

select pk_key, ic_key, history_action,wf_status, last_modified_by, last_modified_date ,FG_TITLE,FG_FILE_NAME,FG_FILE_TYPE,FG_EDCS_DOC_NUM,FG_EDCS_REV,FG_EDCS_STATUS,FG_EDCS_STATUS_DATE,FG_EDCS_APPROVED_DATE,FG_EDCS_ERROR
from ic_history where 1=1 and ic_key in ('IC-4085') order by pk_key desc;

select ic_key, audit_action, src_version, src_edcs_doc_num, src_file_name, src_status, src_status_date, src_edcs_error, src_status_date, wf_status, last_modified_by, last_modified_date
,FG_TITLE,FG_FILE_NAME,FG_FILE_TYPE,FG_EDCS_DOC_NUM,FG_EDCS_REV,FG_EDCS_STATUS,FG_EDCS_STATUS_DATE,FG_EDCS_APPROVED_DATE,FG_EDCS_ERROR
from ic_audit_trail where 1=1 and ic_key in ('IC-4085') order by to_number(substr(ic_key,4,length(ic_key))), src_version ;

-- --------------------------------------------------------------------------------------------
-- Issue 21
-- -- FG
--            wf_status = approved then set to Rework when an fg approval found    
--            ic-4084 There should be no change to the wf status.

select ic_key,wf_status, 
-- last_modified_by, last_modified_date,
FG_TITLE,FG_FILE_NAME,FG_FILE_TYPE,FG_EDCS_DOC_NUM,FG_EDCS_REV,FG_EDCS_STATUS,FG_EDCS_STATUS_DATE,FG_EDCS_APPROVED_DATE,FG_EDCS_ERROR
from ic where 1=1 and ic_key in ('IC-4084') order by to_number(substr(ic_key,4,length(ic_key))), src_version ;

update ic set fg_edcs_status = 'Draft' where 1=1 and ic_key in ('IC-4084');
commit;

-- --------------------------------------------------------------------------------------------
-- Issue 22
-- -- FG
--            wf_status=readyto ship not changed to rework when fg Approval NA received from EDCS    
--            ic-4086
select ic_key,wf_status, 
-- last_modified_by, last_modified_date,
FG_TITLE,FG_FILE_NAME,FG_FILE_TYPE,FG_EDCS_DOC_NUM,FG_EDCS_REV,FG_EDCS_STATUS,FG_EDCS_STATUS_DATE,FG_EDCS_APPROVED_DATE,FG_EDCS_ERROR
from ic where 1=1 and ic_key in ('IC-4086') order by to_number(substr(ic_key,4,length(ic_key))), src_version ;

update ic set fg_edcs_status = 'Draft', wf_status = 'Ready to Ship' where 1=1 and ic_key in ('IC-4086'); 
commit;


-- --------------------------------------------------------------------------------------------
-- Issue 24
-- -- FG
--              IC-4009 is approved in EDCS.  
--              The watch program set it's status to approved (should have been approvals in progress) and did not set the date

select ic_key,src_version,src_status, src_status_date, wf_status, 
-- last_modified_by, last_modified_date,
fg_title,fg_file_name,fg_file_type,fg_edcs_doc_num,fg_edcs_rev,fg_edcs_status,fg_edcs_status_date,fg_edcs_approved_date,fg_edcs_error
from ic where 1=1 and ic_key in ('IC-4009') order by to_number(substr(ic_key,4,length(ic_key))), src_version ;

select * from IC_artifact where ic_key in ('IC-4009'); 

commit;

update ic set fg_title = 'bbbbbb', fg_file_name = null, fg_file_type = null
, fg_edcs_status = null, fg_edcs_status_date = null, fg_edcs_approved_date = null
where ic_key in ('IC-4009');  


select entered_by,entered_date,history_action,ic_key,src_status, src_status_date, wf_status, 
-- last_modified_by, last_modified_date,
FG_TITLE,FG_FILE_NAME,FG_FILE_TYPE,FG_EDCS_DOC_NUM,FG_EDCS_REV,FG_EDCS_STATUS,FG_EDCS_STATUS_DATE,FG_EDCS_APPROVED_DATE,FG_EDCS_ERROR
from ic_history where 1=1 and ic_key in ('IC-4009') order by to_number(substr(ic_key,4,length(ic_key))), src_version ;


update ic set fg_edcs_status = 'Draft', wf_status = 'Ready to Ship' where 1=1 and ic_key in ('IC-4086'); 
commit;

-- --------------------------------------------------------------------------------------------
-- Issue 25
-- -- FG
--            4011 v3 wf_status was set to RTS
--            the record returns an approval
--            there should be no change to the wf_status
select ic_key,src_version, src_origin,wf_status, 
-- last_modified_by, last_modified_date,
fg_title,fg_file_name,fg_file_type,fg_edcs_doc_num,fg_edcs_rev,fg_edcs_status,fg_edcs_status_date,fg_edcs_approved_date,fg_edcs_error
from ic where 1=1 and ic_key in ('IC-4011') order by to_number(substr(ic_key,4,length(ic_key))), src_version ;

select src_version, src_status, src_status_date,entered_by,entered_date,history_action,ic_key, wf_status, 
-- last_modified_by, last_modified_date,
FG_TITLE,FG_FILE_NAME,FG_FILE_TYPE,FG_EDCS_DOC_NUM,FG_EDCS_REV,FG_EDCS_STATUS,FG_EDCS_STATUS_DATE,FG_EDCS_APPROVED_DATE,FG_EDCS_ERROR
from ic_history where 1=1 and ic_key in ('IC-4011') order by pk_key desc;

update ic set wf_status = 'Ready to Ship'  where ic_key in ('IC-4011') and src_version = 3;

update ic set fg_title = 'bbbbbb', fg_file_name = null, fg_file_type = null
, fg_edcs_status = null, fg_edcs_status_date = null, fg_edcs_approved_date = null
where ic_key in ('IC-4011') and src_version in (2,3); 
 

commit;

update ic set fg_title = 'bbbbbb', fg_file_name = null, fg_file_type = null
, fg_edcs_status = null, fg_edcs_status_date = null, fg_edcs_approved_date = null
where ic_key in ('IC-4009');  


-- --------------------------------------------------------------------------------------------
-- Issue 26: 4036 doesn't have an fg_edcs_date in it
-- -- FG        4036 doesn't have an fg_edcs_date in it
select ic_key,
-- src_version, src_origin,wf_status, 
-- last_modified_by, last_modified_date,
fg_title,fg_file_name,fg_file_type,fg_edcs_doc_num,fg_edcs_rev,fg_edcs_status,fg_edcs_status_date,fg_edcs_approved_date,fg_edcs_error
from ic where 1=1 and ic_key in ('IC-4036') order by to_number(substr(ic_key,4,length(ic_key))), src_version ;

select entered_by, entered_date, src_version, src_status, src_status_date,entered_by,entered_date,history_action,ic_key, wf_status, 
-- last_modified_by, last_modified_date,
FG_TITLE,FG_FILE_NAME,FG_FILE_TYPE,FG_EDCS_DOC_NUM,FG_EDCS_REV,FG_EDCS_STATUS,FG_EDCS_STATUS_DATE,FG_EDCS_APPROVED_DATE,FG_EDCS_ERROR
from ic_history where 1=1 and ic_key in ('IC-4036') order by pk_key desc;

delete from ic where ic_key in ('IC-4036') and src_version = 3;
commit;

update ic set wf


-- --------------------------------------------------------------------------------------------
-- Issue 27: 4050 set src_approved_date only GUI should do that
-- -- SRC     4050 set src_approved_date only GUI should do that
select ic_key,
src_version, src_edcs_doc_num, src_status, src_status_date, src_edcs_approved_date 
-- src_origin,wf_status, 
-- last_modified_by, last_modified_date,
-- fg_title,fg_file_name,fg_file_type,fg_edcs_doc_num,fg_edcs_rev,fg_edcs_status,fg_edcs_status_date,fg_edcs_approved_date,fg_edcs_error
from ic where 1=1 and ic_key in ('IC-4050') order by to_number(substr(ic_key,4,length(ic_key))), src_version ;

select src_version, src_status, src_status_date,entered_by,entered_date,history_action,ic_key, wf_status, 
-- last_modified_by, last_modified_date,
FG_TITLE,FG_FILE_NAME,FG_FILE_TYPE,FG_EDCS_DOC_NUM,FG_EDCS_REV,FG_EDCS_STATUS,FG_EDCS_STATUS_DATE,FG_EDCS_APPROVED_DATE,FG_EDCS_ERROR
from ic_history where 1=1 and ic_key in ('IC-4050') order by pk_key desc;


select * from ic_artifact where ic_key in ('IC-4050'); 


delete from ic where ic_key in ('IC-4050') and src_version = 3;
update ic set src_edcs_approved_date = null where ic_key in ('IC-4050') and src_version = 3;
commit;



-- --------------------------------------------------------------------------------------------
-- Issue 28: 4065 wf_status was rts (edcs=rejected) wf_status should be Rework
-- -- SRC
--            ic-4065 wf_status was rts
--            edcs returned a fg status of rejected
--            should have set the wf status to rework
--            it set it to rejected
select ic_key
--        ,src_version, src_edcs_doc_num, src_status, src_status_date, src_edcs_approved_date 
-- src_origin
,wf_status 
-- last_modified_by, last_modified_date,
fg_title,fg_file_name,fg_file_type,fg_edcs_doc_num,fg_edcs_rev
,fg_edcs_status,fg_edcs_status_date
,fg_edcs_approved_date,fg_edcs_error
from ic where 1=1 and ic_key in ('IC-4065') order by to_number(substr(ic_key,4,length(ic_key))), src_version ;

select entered_date, entered_by, 
-- src_version, src_status, src_status_date,entered_by,entered_date,history_action,ic_key, wf_status, 
-- last_modified_by, last_modified_date,
wf_status, FG_TITLE,FG_FILE_NAME,FG_FILE_TYPE,FG_EDCS_DOC_NUM,FG_EDCS_REV,FG_EDCS_STATUS,FG_EDCS_STATUS_DATE,FG_EDCS_APPROVED_DATE,FG_EDCS_ERROR
from ic_history where 1=1 and ic_key in ('IC-4065') order by pk_key desc;

update ic set wf_status = 'Ready to Ship', 
FG_TITLE = 'bbbbb',FG_FILE_NAME = null ,FG_FILE_TYPE = null ,FG_EDCS_STATUS = null,FG_EDCS_STATUS_DATE = null
where ic_key in ('IC-4065') and src_version = 1;
commit;

-- --------------------------------------------------------------------------------------------
-- Issue 29: 4101 wf_status was working (edcs=rejected) wf_status should be rejected
-- -- FG

select ic_key
--        ,src_version, src_edcs_doc_num, src_status, src_status_date, src_edcs_approved_date 
-- src_origin
,wf_status 
-- last_modified_by, last_modified_date,
,fg_title,fg_file_name,fg_file_type,fg_edcs_doc_num,fg_edcs_rev
,fg_edcs_status,fg_edcs_status_date
,fg_edcs_approved_date,fg_edcs_error
from ic where 1=1 and ic_key in ('IC-4101') order by to_number(substr(ic_key,4,length(ic_key))), src_version ;

select entered_date, entered_by, 
-- src_version, src_status, src_status_date,entered_by,entered_date,history_action,ic_key, wf_status, 
-- last_modified_by, last_modified_date,
wf_status, FG_TITLE,FG_FILE_NAME,FG_FILE_TYPE,FG_EDCS_DOC_NUM,FG_EDCS_REV,FG_EDCS_STATUS,FG_EDCS_STATUS_DATE,FG_EDCS_APPROVED_DATE,FG_EDCS_ERROR
from ic_history where 1=1 and ic_key in ('IC-4101') order by pk_key desc;

update ic set wf_status = 'Assigned', 
FG_TITLE = 'aaaaa',FG_FILE_NAME = null ,FG_FILE_TYPE = null ,FG_EDCS_STATUS = null,FG_EDCS_STATUS_DATE = null
where ic_key in ('IC-4101') and src_version = 1;
commit;








-- WORKBENCH 
select ic_key, src_version, src_edcs_doc_num, src_status, fg_edcs_doc_num, fg_edcs_status, wf_status, last_modified_by, last_modified_date
from ic where 1=1 and ic_key in ('IC-4086') order by to_number(substr(ic_key,4,length(ic_key))), src_version ;

update ic set wf_status = 'Ready to Ship' where 1=1 and ic_key in ('IC-4086');
update ic set fg_edcs_status = 'Draft', wf_status = 'Ready to Ship' where 1=1 and ic_key in ('IC-4086'); 

commit;

select ic_key, src_version, src_status, last_modified_by lmb, last_modified_date
from ic where 1=1 and ic_key in ('IC-4086') order by to_number(substr(ic_key,4,length(ic_key))), src_version ;

select pk_key, ic_key, src_version, entered_by, entered_date, history_action
src_status, last_modified_by lmb, last_modified_date
from ic_history where 1=1 and ic_key in ('IC-4086') order by pk_key;

select * from ic where fg_edcs_doc_num is not null
order by to_number(substr(ic_key,4,length(ic_key))) desc;



-- -- SOURCE
--        if it's set to ready to ship and edcs get an approval record, there should be no change
--        I'm seeing it change to rework
--        4084
select ic_key, src_version, src_edcs_doc_num, src_status, fg_edcs_doc_num, fg_edcs_rev, fg_edcs_status, fg_edcs_approved_date, wf_status, last_modified_by, last_modified_date
from ic where 1=1 and ic_key in ('IC-4084') order by to_number(substr(ic_key,4,length(ic_key))), src_version ;

commit;

select pk_key, entered_by, entered_date, history_action, ic_key, src_version, src_edcs_doc_num, src_status, fg_edcs_doc_num, fg_edcs_status, wf_status, last_modified_by, last_modified_date
from ic_history where 1=1 and ic_key in ('IC-4084') order by pk_key desc;


select sysdate from dual;

update ic set wf_status = 'Ready to Ship' where 1=1 and ic_key in ('IC-4084');
update ic set fg_edcs_status = 'Draft', wf_status = 'Ready to Ship' where 1=1 and ic_key in ('IC-4084'); 


select ic_key, wf_status, src_version, src_status, src_edcs_approved_date, src_title, src_status_date, src_edcs_error, fg_edcs_error, src_edcs_doc_num
        , src_title, src_file_name, wf_status, wf_status_date, last_modified_by lmb, last_modified_date, src_origin
from ic where 1=1 and ic_key in ('IC-4084') order by to_number(substr(ic_key,4,length(ic_key))), src_version ;

select ic_key, src_version, src_status, last_modified_by lmb, last_modified_date
from ic where 1=1 and ic_key in ('IC-4084') order by to_number(substr(ic_key,4,length(ic_key))), src_version ;


select distinct src_status from IC;

select * from ic where src_status = 'Last Updated'; 

select pk_key, ic_key, src_version, entered_by, entered_date, history_action
src_status, last_modified_by lmb, last_modified_date
from ic_history where 1=1 and ic_key in ('IC-4084') order by pk_key;

select * from ic where fg_edcs_doc_num is not null
order by to_number(substr(ic_key,4,length(ic_key))) desc;


-- -- SOURCE
--        fg_edcs_status_date is incorrect
select ic_key, src_version, src_status, src_edcs_approved_date, src_title, src_status_date, src_edcs_error, fg_edcs_error, src_edcs_doc_num
        , src_title, src_file_name, wf_status wfstat, wf_status_date, last_modified_by lmb, last_modified_date, src_origin
from ic where 1=1 and ic_key in ('IC-4082', 'IC-4083') order by to_number(substr(ic_key,4,length(ic_key))), src_version ;

select ic_key, src_version, src_status, last_modified_by lmb, last_modified_date
from ic where 1=1 and ic_key in ('IC-4082', 'IC-4083') order by to_number(substr(ic_key,4,length(ic_key))), src_version ;

select pk_key, ic_key, src_version, entered_by, entered_date, history_action
src_status, last_modified_by lmb, last_modified_date
from ic_history where 1=1 and ic_key in ('IC-4082','IC-4083') order by pk_key;





-- -- SOURCE
select ic_key, wf_status, src_version, src_status, src_edcs_approved_date, src_title, src_status_date, src_edcs_error, fg_edcs_error, src_edcs_doc_num
        , src_title, src_file_name, wf_status wfstat, wf_status_date, last_modified_by lmb, last_modified_date, src_origin
from ic where 1=1 and ic_key in ('IC-4080') order by to_number(substr(ic_key,4,length(ic_key))), src_version ;

select ic_key, src_version, src_status, last_modified_by lmb, last_modified_date
from ic where 1=1 and ic_key in ('IC-4080') order by to_number(substr(ic_key,4,length(ic_key))), src_version ;

select pk_key, ic_key, src_version, entered_by, entered_date, history_action
src_status, last_modified_by lmb, last_modified_date
from ic_history where 1=1 and ic_key in ('IC-4080') order by pk_key;

select * from ic where fg_edcs_doc_num is not null
order by to_number(substr(ic_key,4,length(ic_key))) desc;













select * from ic where 1=1 and ic_key in ('IC-4078');

select * from ic_history where 1=1 and ic_key in ('IC-4078');



select ic_key, src_status, src_status_date, src_edcs_error, src_edcs_doc_num, src_version
        , src_title, src_file_name, wf_status wfstat, wf_status_date, last_modified_by lmb, last_modified_date, src_origin
from ic_audit_trail where 1=1 and ic_key in ('IC-4033') order by to_number(substr(ic_key,4,length(ic_key))), src_version ;

select history_action, entered_by, entered_date, ic_key, src_status, src_status_date, src_edcs_error, fg_edcs_error, src_edcs_doc_num, src_version
        , src_title, src_file_name, wf_status wfstat, wf_status_date, last_modified_by lmb, last_modified_date, src_origin
from ic_history where 1=1 and ic_key in ('IC-4033') order by to_number(substr(ic_key,4,length(ic_key))), src_version ;

select count(src_edcs_doc_num) from ic;



-- -- SOURCE
select ic_key, src_version, src_status, src_edcs_approved_date, src_status_date, src_edcs_error, fg_edcs_error, src_edcs_doc_num
        , src_title, src_file_name, wf_status wfstat, wf_status_date, last_modified_by lmb, last_modified_date, src_origin
from ic where 1=1 and ic_key in ('IC-4033') order by to_number(substr(ic_key,4,length(ic_key))), src_version ;

select ic_key, src_status, src_status_date, src_edcs_error, src_edcs_doc_num, src_version
        , src_title, src_file_name, wf_status wfstat, wf_status_date, last_modified_by lmb, last_modified_date, src_origin
from ic_audit_trail where 1=1 and ic_key in ('IC-4033') order by to_number(substr(ic_key,4,length(ic_key))), src_version ;

select history_action, entered_by, entered_date, ic_key, src_status, src_status_date, src_edcs_error, fg_edcs_error, src_edcs_doc_num, src_version
        , src_title, src_file_name, wf_status wfstat, wf_status_date, last_modified_by lmb, last_modified_date, src_origin
from ic_history where 1=1 and ic_key in ('IC-4033') order by to_number(substr(ic_key,4,length(ic_key))), src_version ;






-- -- SOURCE
select ic_key, src_version, src_status, src_status_date, srcsrc_edcs_error, fg_edcs_error, src_edcs_doc_num
        , src_title, src_file_name, wf_status wfstat, wf_status_date, last_modified_by lmb, last_modified_date, src_origin
from ic where 1=1 and ic_key in ('IC-4013') order by to_number(substr(ic_key,4,length(ic_key))), src_version ;

select ic_key, src_status, src_status_date, src_edcs_error, src_edcs_doc_num, src_version
        , src_title, src_file_name, wf_status wfstat, wf_status_date, last_modified_by lmb, last_modified_date, src_origin
from ic_audit_trail where 1=1 and ic_key in ('IC-4004') order by to_number(substr(ic_key,4,length(ic_key))), src_version ;

select history_action, entered_by, entered_date, ic_key, src_status, src_status_date, src_edcs_error, fg_edcs_error, src_edcs_doc_num, src_version
        , src_title, src_file_name, wf_status wfstat, wf_status_date, last_modified_by lmb, last_modified_date, src_origin
from ic_history where 1=1 and ic_key in ('IC-4004') order by to_number(substr(ic_key,4,length(ic_key))), src_version ;


-- -- SOURCE
select ic_key, src_status, src_status_date, src_edcs_error, fg_edcs_error, src_edcs_doc_num, src_version
        , src_title, src_file_name, wf_status wfstat, wf_status_date, last_modified_by lmb, last_modified_date, src_origin
from ic where 1=1 and ic_key in ('IC-8989') order by to_number(substr(ic_key,4,length(ic_key))), src_version ;

select ic_key, src_status, src_edcs_doc_num, src_version
from ic where 1=1 and src_edcs_doc_num = '731313' order by to_number(substr(ic_key,4,length(ic_key))), src_version ;


select ic_key, src_status, src_status_date, src_edcs_error, src_edcs_doc_num, src_version
        , src_title, src_file_name, wf_status wfstat, wf_status_date, last_modified_by lmb, last_modified_date, src_origin
from ic_audit_trail where 1=1 and ic_key in ('IC-4002') order by to_number(substr(ic_key,4,length(ic_key))), src_version ;

select history_action, entered_by, entered_date, ic_key, src_status, src_status_date, src_edcs_error, fg_edcs_error, src_edcs_doc_num, src_version
        , src_title, src_file_name, wf_status wfstat, wf_status_date, last_modified_by lmb, last_modified_date, src_origin
from ic_history where 1=1 and ic_key in ('IC-4002') order by to_number(substr(ic_key,4,length(ic_key))), src_version ;

select last_modified_by from ic where UPPER(last_modified_by) like '%EDCS%';

select * from ic where last_modified_by = 'REGRESSION';
delete from ic where last_modified_by = 'REGRESSION';
insert into ic (ic_key,src_version, last_modified_by) values ('IC-8888', 2, 'REGRESSION');
update ic set src_version = 22 where last_modified_by = 'REGRESSION';
delete from ic where last_modified_by = 'REGRESSION';
select * from ic_history where last_modified_by = 'REGRESSION';

delete from ic_history where last_modified_by = 'REGRESSION';
commit;

-- -- SOURCE
select ic_key, src_status, src_status_date, src_edcs_error, fg_edcs_error, src_edcs_doc_num, src_version
        , src_title, src_file_name, wf_status wfstat, wf_status_date, last_modified_by lmb, last_modified_date, src_origin
from ic where 1=1 and ic_key in ('IC-4004') order by to_number(substr(ic_key,4,length(ic_key))), src_version ;

select ic_key, src_status, src_status_date, src_edcs_error, src_edcs_doc_num, src_version
        , src_title, src_file_name, wf_status wfstat, wf_status_date, last_modified_by lmb, last_modified_date, src_origin
from ic_audit_trail where 1=1 and ic_key in ('IC-4004') order by to_number(substr(ic_key,4,length(ic_key))), src_version ;

select history_action, entered_by, entered_date, ic_key, src_status, src_status_date, src_edcs_error, fg_edcs_error, src_edcs_doc_num, src_version
        , src_title, src_file_name, wf_status wfstat, wf_status_date, last_modified_by lmb, last_modified_date, src_origin
from ic_history where 1=1 and ic_key in ('IC-4004') order by to_number(substr(ic_key,4,length(ic_key))), src_version ;

  

-- -- SOURCE
select ic_key, src_status, src_status_date, src_edcs_error, fg_edcs_error, src_edcs_doc_num, src_version
        , src_title, src_file_name, wf_status wfstat, wf_status_date, last_modified_by lmb, last_modified_date, src_origin
from ic where 1=1 and ic_key in ('IC-4005') order by to_number(substr(ic_key,4,length(ic_key))), src_version ;

select ic_key, src_status, src_status_date, src_edcs_error, src_edcs_doc_num, src_version
        , src_title, src_file_name, wf_status wfstat, wf_status_date, last_modified_by lmb, last_modified_date, src_origin
from ic_audit_trail where 1=1 and ic_key in ('IC-4005') order by to_number(substr(ic_key,4,length(ic_key))), src_version ;

select history_action, entered_by, entered_date, ic_key, src_status, src_status_date, src_edcs_error, fg_edcs_error, src_edcs_doc_num, src_version
        , src_title, src_file_name, wf_status wfstat, wf_status_date, last_modified_by lmb, last_modified_date, src_origin
from ic_history where 1=1 and ic_key in ('IC-4005') order by to_number(substr(ic_key,4,length(ic_key))), src_version ;

-- -- SOURCE
select ic_key, src_status, src_status_date, src_edcs_error, fg_edcs_error, src_edcs_doc_num, src_version
        , src_title, src_file_name, wf_status wfstat, wf_status_date, last_modified_by lmb, last_modified_date, src_origin
from ic where 1=1 and ic_key in ('IC-4006') order by to_number(substr(ic_key,4,length(ic_key))), src_version ;

select ic_key, src_status, src_status_date, src_edcs_error, src_edcs_doc_num, src_version
        , src_title, src_file_name, wf_status wfstat, wf_status_date, last_modified_by lmb, last_modified_date, src_origin
from ic_audit_trail where 1=1 and ic_key in ('IC-4006') order by to_number(substr(ic_key,4,length(ic_key))), src_version ;

select history_action, entered_by, entered_date, ic_key, src_status, src_status_date, src_edcs_error, fg_edcs_error, src_edcs_doc_num, src_version
        , src_title, src_file_name, wf_status wfstat, wf_status_date, last_modified_by lmb, last_modified_date, src_origin
from ic_history where 1=1 and ic_key in ('IC-4006') order by to_number(substr(ic_key,4,length(ic_key))), src_version ;

-- SOURCE
select ic_key, src_status, src_status_date, src_edcs_error, fg_edcs_error, src_edcs_doc_num, src_version
        , src_title, src_file_name, wf_status wfstat, wf_status_date, last_modified_by lmb, last_modified_date, src_origin
from ic where 1=1 and ic_key in ('IC-4045') order by to_number(substr(ic_key,4,length(ic_key))), src_version ;

select ic_key, src_status, src_status_date, src_edcs_error, src_edcs_doc_num, src_version
        , src_title, src_file_name, wf_status wfstat, wf_status_date, last_modified_by lmb, last_modified_date, src_origin
from ic_audit_trail where 1=1 and ic_key in ('IC-4045') order by to_number(substr(ic_key,4,length(ic_key))), src_version ;

select history_action, entered_by, entered_date, ic_key, src_status, src_status_date, src_edcs_error, fg_edcs_error, src_edcs_doc_num, src_version
        , src_title, src_file_name, wf_status wfstat, wf_status_date, last_modified_by lmb, last_modified_date, src_origin
from ic_history where 1=1 and ic_key in ('IC-4045') order by to_number(substr(ic_key,4,length(ic_key))), src_version ;

-- -- SOURCE
select ic_key, src_status, src_status_date, src_edcs_error, fg_edcs_error, src_edcs_doc_num, src_version
        , src_title, src_file_name, wf_status wfstat, wf_status_date, last_modified_by lmb, last_modified_date, src_origin
from ic where 1=1 and ic_key in ('IC-4046') order by to_number(substr(ic_key,4,length(ic_key))), src_version ;

select ic_key, src_status, src_status_date, src_edcs_error, src_edcs_doc_num, src_version
        , src_title, src_file_name, wf_status wfstat, wf_status_date, last_modified_by lmb, last_modified_date, src_origin
from ic_audit_trail where 1=1 and ic_key in ('IC-4046') order by to_number(substr(ic_key,4,length(ic_key))), src_version ;

select history_action, entered_by, entered_date, ic_key, src_status, src_status_date, src_edcs_error, fg_edcs_error, src_edcs_doc_num, src_version
        , src_title, src_file_name, wf_status wfstat, wf_status_date, last_modified_by lmb, last_modified_date, src_origin
from ic_history where 1=1 and ic_key in ('IC-4046') order by to_number(substr(ic_key,4,length(ic_key))), src_version ;





-- FINISHED GOODS
-- FG
select   i.ic_key,  i.src_version ,  src_edcs_doc_num, src_status, src_status_date, i.fg_edcs_doc_num , i.fg_edcs_rev   , i.fg_edcs_status   , i.fg_edcs_status_date   , i.fg_edcs_error  
, i.wf_status   , i.wf_status_date   from ic i  where i.ic_key = 'IC-4002';

update ic set fg_edcs_doc_num = '824372', fg_edcs_rev = 1, fg_edcs_status = null, fg_edcs_status_date = null 
where 1=1 and ic_key in ('IC-5001') and src_version = 3;
-- delete from ic where ic_key = 'IC-5001' and src_version > 2; 
rollback;
824372


select   i.ic_key,  i.src_version ,  src_edcs_doc_num, src_status, src_status_date, i.fg_edcs_doc_num , i.fg_edcs_rev   , i.fg_edcs_status   , i.fg_edcs_status_date   , i.fg_edcs_error  
, i.wf_status   , i.wf_status_date   from ic_audit_trail i  where i.ic_key = 'IC-5001';

delete from ic_audit_trail where ic_key = 'IC-5000'; 


select   i.ic_key,  i.src_version ,  src_edcs_doc_num, src_status, src_status_date, i.fg_edcs_doc_num , i.fg_edcs_rev   , i.fg_edcs_status   , i.fg_edcs_status_date   , i.fg_edcs_error  
, i.wf_status   , i.wf_status_date   
from ic i  
where src_edcs_doc_num = '825652'
order by i.src_version;
and ;


delete from ic where ic_key in ('IC-5035', 'IC-5036','IC-5037'); 
delete from ic_artifact where ic_key in ('IC-5035', 'IC-5036','IC-5037');






select      ic_key, src_edcs_doc_num, src_version, wf_status, fg_edcs_doc_num, fg_edcs_status
        , fg_edcs_status_date, fg_edcs_rev
        , src_edcs_error
 
from IC 
where 1=1
and ic_key = 'IC-4002';

select    ic_key, src_edcs_doc_num, src_version, wf_status, fg_edcs_doc_num, fg_edcs_status
        , fg_edcs_status_date, fg_edcs_rev
        , src_edcs_error
 
from IC_history 
where 1=1
and ic_key = 'IC-4002';


select audit_key, audit_action, audit_action_date, ic_key, src_edcs_doc_num, src_version, wf_status, fg_edcs_doc_num, fg_edcs_status, fg_edcs_status_date, fg_edcs_rev,
last_modified_by, last_modified_date 
from IC_audit_trail  
where 1=1
and ic_key = 'IC-4002';

select ic_key, src_edcs_doc_num, src_version, wf_status, fg_edcs_doc_num, fg_edcs_status, fg_edcs_status_date, fg_edcs_rev 
from IC 
where 1=1
and ic_key = 'IC-4002';


order by to_number(substr(ic_key,4,length(ic_key)))




-- ----------------------------------------------------------------
-- IMPORT 
--drop table ic cascade constraints;
--drop table ic_artifact cascade constraints;
--drop table ic_audit_trail cascade constraints;
--update IC set src_edcs_doc_num = substr(src_edcs_doc_num,6,length(src_edcs_doc_num)) where src_edcs_doc_num like '%EDCS%';
--update IC set fg_edcs_doc_num = substr(fg_edcs_doc_num,6,length(fg_edcs_doc_num)) where fg_edcs_doc_num like '%EDCS%';
--update IC set fg_edcs_rev = 1 where fg_edcs_doc_num is not null and wf_status = 'Ready to Ship';
commit;;

--update IC2 set src_edcs_doc_num = substr(src_edcs_doc_num,6,length(src_edcs_doc_num)) where src_edcs_doc_num like '%EDCS%';
--update IC2 set fg_edcs_doc_num = substr(fg_edcs_doc_num,6,length(fg_edcs_doc_num)) where fg_edcs_doc_num like '%EDCS%';
-- commit;

-- the maximum version that came over from KM_Origin was 5 
-- select source_item_key, max(edcs_version) edcs_version from km_edcs_origin_item o where source_item_key = 130 group by source_item_key;

-- watch this record 
select ic_key, src_edcs_doc_num, src_version, wf_status, fg_edcs_doc_num, fg_edcs_status, fg_edcs_status_date, fg_edcs_rev 
from IC where 1=1  and ic_key = 'IC-130';


select ic_key, src_edcs_doc_num, src_version, wf_status, fg_edcs_doc_num, fg_edcs_status, fg_edcs_status_date, fg_edcs_rev 
from IC where 1=1
and fg_edcs_doc_num is not null
and fg_edcs_status is null
order by to_number(substr(ic_key,4,length(ic_key)))
and ic_key = 'IC-130';

select watch_flag from ic_artifact where ic_key = 'IC-130';


-- 114
select ic_key, src_edcs_doc_num, src_version, wf_status, fg_edcs_doc_num, fg_edcs_status, fg_edcs_status_date, fg_edcs_rev 
from IC where 1=1 and src_edcs_doc_num is not null  
and WF_STATUS = 'Ready to Ship';



-- test the ready to ship again
create table ic_hold as select * from ic where ic_key in ('IC-130','IC-136','IC-140','IC-142','IC-130','IC-143');
commit;

select ic_key, src_edcs_doc_num, src_version, wf_status, fg_edcs_doc_num, fg_edcs_status, fg_edcs_status_date, fg_edcs_rev 
from IC 
where 1=1 
and ic_key in ('IC-130');

update ic set  wf_status = 'Ready to Ship', fg_edcs_doc_num = '824373', fg_edcs_status = null, fg_edcs_status_date = null, fg_edcs_rev = 2
where 1=1 
and ic_key in ('IC-130');

commit;







select ic_key, wf_status, src_status, src_status_date, src_edcs_doc_num, src_version, src_title, src_file_name, wf_status wfstat, wf_status_date, last_modified_by lmb, last_modified_date, src_origin
from IC
where 1=1
and WF_STATUS = 'Ready to Ship'
-- and src_edcs_doc_num is not null
order by to_number(substr(ic_key,4,length(ic_key))), src_version ;

select ic_key, src_edcs_doc_num, src_version, wf_status, fg_edcs_doc_num, fg_edcs_status, fg_edcs_status_date, fg_edcs_rev 
from IC_AUDIT_TRAIL where 1=1  and ic_key = 'IC-130';
-- delete from IC_AUDIT_TRAIL where 1=1  and ic_key = 'IC-130';
commit;
-- update IC set fg_edcs_status = null, fg_edcs_status_date = null where 1=1  and ic_key = 'IC-130' and src_version = 5;
commit;

select * from ic_artifact where ic_key = 'IC-130';
select ic_key, src_edcs_doc_num, src_version, wf_status, fg_edcs_doc_num, fg_edcs_status, fg_edcs_status_date, fg_edcs_rev 
from IC where 1=1  and wf_status <> 'Ready to Ship' and fg_edcs_rev > 1;

select distinct (fg_edcs_rev) from IC where 1=1  and wf_status = 'Ready to Ship';


update IC set fg_edcs_rev = 1 where 1=1  and ic_key = 'IC-130';
commit;

select * from v_$session;
 
 
commit;
select ic_key, src_edcs_doc_num, src_version, wf_status, fg_edcs_doc_num, fg_edcs_status, fg_edcs_status_date, fg_edcs_rev 
from IC 
where 1=1  
-- and ic_key = 'IC-130'
and fg_edcs_rev is not null and fg_edcs_rev = 0;

update IC set fg_edcs_rev = 1 where  1=1 
and fg_edcs_rev is not null and fg_edcs_rev = 0;


-- create table ic2 as select * from ic where 1=1  and ic_key = 'IC-130';  
commit;
-- select * from ic2;
delete from ic where ic_key = 'IC-130';
insert into ic select * from ic2 where ic_key = 'IC-130';
update ic2 set fg_edcs_rev = 1; 

commit;
select src_edcs_doc_num, fg_edcs_doc_num from ic where 1=1 and fg_edcs_doc_num like '%EDCS%';
--select src_edcs_doc_num, substr(src_edcs_doc_num,6,length(src_edcs_doc_num)),
--fg_edcs_doc_num, substr(fg_edcs_doc_num,6,length(fg_edcs_doc_num)) 
--from IC where 1=1  and ic_key = 'IC-130';

commit;

update ic set src_version = 5 where ic_key = 'IC-130' and src_version = 4;
update ic set fg_edcs_status_date = to_date('03/05/2009', 'DD/MM/YYYY'), fg_edcs_rev = 1 
where ic_key = 'IC-130' and src_version = 5;

commit;


insert into ic_artifact 
    (watch_flag, 
    last_modified_by, 
    last_modified_date) 
values (
    'Y'
    , 'Regression'
    , sysdate)
;
drop sequence ic_artifact_seq;

create sequence ic_artifact_seq start with 5000;


select * from ic_artifact where last_modified_by = 'Regression' 
order by to_number(substr(ic_key,4,length(ic_key)));
commit;
BEGIN
        insert into IC (ic_key, src_edcs_doc_num, src_version, src_title, src_file_name, wf_status, wf_status_date, last_modified_by, last_modified_date, src_origin)
        values ('IC-5000', '825652', 2, 'Test_Document_1A_Title', 'Test_Document_1A_Title.doc', 'New', sysdate, 'Regression', sysdate, 'EDCS');

        insert into IC (ic_key, src_edcs_doc_num, src_version, src_title, src_file_name, wf_status, wf_status_date, last_modified_by, last_modified_date, src_origin)
        values ('IC-5001', '824269', 2, 'Test_Document_2', 'Test_Document_2.doc', 'New', sysdate, 'Regression', sysdate, 'EDCS');

        insert into IC (ic_key, src_edcs_doc_num, src_version, src_title, src_file_name, wf_status, wf_status_date, last_modified_by, last_modified_date, src_origin)
        values  ('IC-5002', '825653', 2, 'Test_Document_2A', 'Test_Document_2A.doc' , 'New', sysdate, 'Regression', sysdate, 'EDCS');


        insert into IC (ic_key, src_edcs_doc_num, src_version, src_title, src_file_name, wf_status, wf_status_date, last_modified_by, last_modified_date, src_origin)
        values  ('IC-5003', '824270', 1, 'Test_Document_3', 'Test_Document_3_doc', 'New', sysdate, 'Regression', sysdate, 'EDCS');


        insert into IC (ic_key, src_edcs_doc_num, src_version, src_title, src_file_name, wf_status, wf_status_date, last_modified_by, last_modified_date, src_origin)
        values  ('IC-5004', '825654', 2, 'Test_Document_3A', 'Test_Document_3A.doc', 'New', sysdate, 'Regression', sysdate, 'EDCS');

        insert into IC (ic_key, src_edcs_doc_num, src_version, src_title, src_file_name, wf_status, wf_status_date, last_modified_by, last_modified_date, src_origin)
        values   ('IC-5005', '824277', 1, 'Test_Document_4', 'Test_Document_4.doc', 'New', sysdate, 'Regression', sysdate, 'EDCS');

        insert into IC (ic_key, src_edcs_doc_num, src_version, src_title, src_file_name, wf_status, wf_status_date, last_modified_by, last_modified_date, src_origin)
        values   ('IC-5006', '824615', 2, 'Test_Document_6.doc', 'Test_Document_6.doc', 'New', sysdate, 'Regression', sysdate, 'EDCS');

        insert into IC (ic_key, src_edcs_doc_num, src_version, src_title, src_file_name, wf_status, wf_status_date, last_modified_by, last_modified_date, src_origin)
        values  ('IC-5007', '812959', 1, 'Test', 'Test.txt', 'New', sysdate, 'Regression', sysdate, 'EDCS');

        insert into IC (ic_key, src_edcs_doc_num, src_version, src_title, src_file_name, wf_status, wf_status_date, last_modified_by, last_modified_date, src_origin)
        values  ('IC-5008', '826049', 1, 'Test2', 'Test2.doc', 'New', sysdate, 'Regression', sysdate, 'EDCS');

        insert into IC (ic_key, src_edcs_doc_num, src_version, src_title, src_file_name, wf_status, wf_status_date, last_modified_by, last_modified_date, src_origin)
        values   ('IC-5009', '826051', 2, 'Test3', 'Test3_src.txt', 'New', sysdate, 'Regression', sysdate, 'EDCS');

        insert into IC (ic_key, src_edcs_doc_num, src_version, src_title, src_file_name, wf_status, wf_status_date, last_modified_by, last_modified_date, src_origin)
        values   ('IC-5010', '826050', 1, 'Test4', 'Test4.txt', 'New', sysdate, 'Regression', sysdate, 'EDCS');

        insert into IC (ic_key, src_edcs_doc_num, src_version, src_title, src_file_name, wf_status, wf_status_date, last_modified_by, last_modified_date, src_origin)
        values   ('IC-5011', '824280', 1, 'Test_Document_7', 'Test_Document_7.doc', 'New', sysdate, 'Regression', sysdate, 'EDCS');

        insert into IC (ic_key, src_edcs_doc_num, src_version, src_title, src_file_name, wf_status, wf_status_date, last_modified_by, last_modified_date, src_origin)
        values   ('IC-5012', '824281', 1, 'Test_Document_8', 'Test_Document_8.doc', 'New', sysdate, 'Regression', sysdate, 'EDCS');

        insert into IC (ic_key, src_edcs_doc_num, src_version, src_title, src_file_name, wf_status, wf_status_date, last_modified_by, last_modified_date, src_origin)
        values   ('IC-5013', '824619', 1, 'Test_Document_9', 'Test_Document_9.doc', 'New', sysdate, 'Regression', sysdate, 'EDCS');

        commit;
END;


-- SOURCE
select ic_key, src_status, src_status_date, src_edcs_doc_num, src_version, src_title, src_file_name, wf_status wfstat, wf_status_date, last_modified_by lmb, last_modified_date, src_origin
from IC
where 1=1
and ic_key in ('IC-5000','IC-5001','IC-5002','IC-5003','IC-5004','IC-5005','IC-5006','IC-5007','IC-5008','IC-5009','IC-5010','IC-5011','IC-5012','IC-5013')
order by to_number(substr(ic_key,4,length(ic_key))), src_version ;

select ic_key, src_status sstat, src_status_date sstatd, src_edcs_doc_num edocnum, src_version svrs, src_title, src_file_name, wf_status wfstat, wf_status_date, last_modified_by lmb, last_modified_date, src_origin
    from IC where 1=1 and ic_key in ('IC-5001') order by to_number(substr(ic_key,4,length(ic_key))), src_version ;
select ic_key, src_status sstat, src_status_date sstatd, src_edcs_doc_num edocnum, src_version svrs, src_title, src_file_name, wf_status wfstat, wf_status_date, last_modified_by lmb, last_modified_date, src_origin
    from IC_AUDIT_TRAIL where 1=1 and ic_key in ('IC-5001') order by to_number(substr(ic_key,4,length(ic_key))), src_version ;

--update IC 
--set src_status = null, src_status_date = null, wf_status = 'Ready to Ship'
--where 1=1 and ic_key in ('IC-5000') and src_version >2; 

--delete from IC where 1=1 and ic_key in ('IC-5000') and src_version >2;
--delete from IC_AUDIT_TRAIL where 1=1 and ic_key in ('IC-5000');
commit;





select 'IC-' || max(to_number(substr(ic_key,4,length(ic_key)))) 
from ic_artifact
where last_modified_by = 'EDCS_Watch_FG';

order by last_modified_date desc;





-- FG
commit;
-- update ic set fg_edcs_doc_num = '824385',  fg_edcs_rev = 1 where 1=1 and ic_key in ('IC-5000') and src_version = 2;

select   i.ic_key,  i.src_version ,  src_edcs_doc_num, src_status, src_status_date, i.fg_edcs_doc_num , i.fg_edcs_rev   , i.fg_edcs_status   , i.fg_edcs_status_date   , i.fg_edcs_error  
, i.wf_status   , i.wf_status_date   from ic i  where i.ic_key = 'IC-5001';

update ic set fg_edcs_doc_num = '824372', fg_edcs_rev = 1, fg_edcs_status = null, fg_edcs_status_date = null 
where 1=1 and ic_key in ('IC-5001') and src_version = 3;
-- delete from ic where ic_key = 'IC-5001' and src_version > 2; 
rollback;
824372


select   i.ic_key,  i.src_version ,  src_edcs_doc_num, src_status, src_status_date, i.fg_edcs_doc_num , i.fg_edcs_rev   , i.fg_edcs_status   , i.fg_edcs_status_date   , i.fg_edcs_error  
, i.wf_status   , i.wf_status_date   from ic_audit_trail i  where i.ic_key = 'IC-5001';

delete from ic_audit_trail where ic_key = 'IC-5000'; 


select   i.ic_key,  i.src_version ,  src_edcs_doc_num, src_status, src_status_date, i.fg_edcs_doc_num , i.fg_edcs_rev   , i.fg_edcs_status   , i.fg_edcs_status_date   , i.fg_edcs_error  
, i.wf_status   , i.wf_status_date   
from ic i  
where src_edcs_doc_num = '825652'
order by i.src_version;
and ;


delete from ic where ic_key in ('IC-5035', 'IC-5036','IC-5037'); 
delete from ic_artifact where ic_key in ('IC-5035', 'IC-5036','IC-5037');



select          ic_key         , src_version         , src_origin         , src_title         , team         , sme         , src_technology_type         , src_pass_through_flag         , src_status         , src_status_date         , src_project_name         , src_underlying_technology         , src_components         , src_edcs_doc_num         , src_edcs_approved_date         , src_edcs_error         , src_remedy_ticket_num         , src_url         , src_space_name         , src_path         , src_file_name         , src_file_type         , src_location         , src_date_captured         , src_3rd_party_origin_flag         , src_3rd_party_company         , src_referenced_doc         , src_derived_from         , src_related_doc         , src_3rdparty_content_flag         , src_3rdparty_content_details         , src_remediation_unique_id         , src_st_project_name         , src_st_views         , src_st_label         , src_exp_date         , wf_status         , wf_status_date         , wf_owner         , wf_issue_flag         , wf_comment         , fg_title         , fg_file_name         , fg_file_type         , fg_edcs_doc_num         , fg_edcs_rev         , fg_edcs_status         , fg_edcs_status_date         , fg_edcs_approved_date         , fg_edcs_error         , fg_delivered_technology         , fg_3rd_party_content_flag         , fg_3rd_party_content_details         , fg_referenced_docs         , fg_derived_from         , fg_related_docs         , fg_release         , rts_location         , rts_file_name         , comments         , misc_1         , misc_2         , misc_3         , last_modified_by         , last_modified_date  from ic  where 1=1   and ic_key = 'IC-5000'  and src_version = 2  and fg_edcs_doc_num = '824385'  and fg_edcs_rev = 1;



select    i.ic_key 
        , wf_status, wf_status_date
        , i.src_status, i.src_status_date, i.src_version 
--        , substr(i.fg_title,0,9) fgTitle, substr(i.fg_file_name,0,9) fgFName
        , fg_title, fg_file_name
        , i.fg_file_type, i.fg_edcs_doc_num, i.fg_edcs_rev, i.fg_edcs_status, i.fg_edcs_status_date, i.fg_edcs_approved_date, i.fg_edcs_error
        , i.wf_status, i.wf_status_date
from IC i 
where 1=1
and IC_key in ('IC-5000');

































-- 385 rows
select o.source_item_key, o.edcs_version
    from    km_edcs_origin_item o
         , (select source_item_key,  max(history_id) maxHID from km_edcs_origin_item group by source_item_key) o2
where o.history_id = o2.maxHID
order by source_item_key; 

-- How many of those brought over
-- 379 rows brought over
select ia.ic_key,ia.src_version, ia.wf_status, ia.wf_status_date, ia.last_modified_by
from IC ia 
        ,(select o.source_item_key, o.edcs_version
            from    km_edcs_origin_item o
                 , (select source_item_key,  max(history_id) maxHID from km_edcs_origin_item group by source_item_key) o2
        where o.history_id = o2.maxHID
        order by source_item_key
        ) o3
where 1=1
-- and wf_status is null and wf_status_date is null
and to_number(substr(ia.ic_key,4,length(ia.ic_key))) = o3.source_item_key
and ia.src_version = o3.edcs_version
;  

-- How many of those are blanks 
-- 265 rows blank 
select ia.ic_key,ia.src_version, ia.wf_status, ia.wf_status_date, ia.last_modified_by
from IC ia 
        ,(select o.source_item_key, o.edcs_version
            from    km_edcs_origin_item o
                 , (select source_item_key,  max(history_id) maxHID from km_edcs_origin_item group by source_item_key) o2
        where o.history_id = o2.maxHID
        order by source_item_key
        ) o3
where 1=1
and wf_status is null and wf_status_date is null
and to_number(substr(ia.ic_key,4,length(ia.ic_key))) = o3.source_item_key
and ia.src_version = o3.edcs_version
order by to_number(substr(ia.ic_key,4,length(ia.ic_key))) desc;  

-- how many above the migration are null?
-- ZERO 
select ia.ic_key,ia.src_version, ia.wf_status, ia.wf_status_date, ia.last_modified_by
from IC ia 
        ,(select o.source_item_key, o.edcs_version
            from    km_edcs_origin_item o
                 , (select source_item_key,  max(history_id) maxHID from km_edcs_origin_item group by source_item_key) o2
        where o.history_id = o2.maxHID
        order by source_item_key
        ) o3
where 1=1
and (wf_status is null or wf_status_date is null)
and to_number(substr(ia.ic_key,4,length(ia.ic_key))) = o3.source_item_key
and to_number(substr(ia.ic_key,4,length(ia.ic_key))) > 1012
and ia.src_version = o3.edcs_version
order by to_number(substr(ia.ic_key,4,length(ia.ic_key))) desc;





select * from ic where src_title = 'null';
select ic_key, src_version, src_title 
from ic where ic_key in ('IC-1002', 'IC-1004', 'IC-1006');
rollback;
delete from ic where src_title = 'null';
commit;

select  ic_key, src_edcs_doc_num e_num, src_version, src_title, src_status
from ic 
where 1=1
and src_edcs_doc_num like '825652';

and upper(src_title) like '%TEST%'
and src_origin = 'EDCS';


insert into IC (ic_key, edcs_doc_number, src_version, src_title, src_file_name; 

select ic_key, edcs_doc_number, src_version, src_title, src_file_name from IC;
select * from ic_artifact order by last_modified_by desc;
insert into 
select ic_key, src_edcs_doc_num, src_version, src_title from ic;




-- SOURCE 
select  src_origin, last_modified_date lmd, ic_key , src_edcs_doc_num e_num, src_version  s_ver , src_title  titl, src_status stat, src_status_date stat_d, src_edcs_error e_err
, src_file_name fname, src_file_type ftype, wf_status w_stat  , wf_status_date w_stat_d,fg_edcs_doc_num, fg_edcs_rev    
, last_modified_by, last_modified_date
from IC i 
where 1=1
and IC_key in ('IC-1002');

select  audit_action_by aab, audit_action_date aad, ic_key , src_edcs_doc_num e_num, src_version  s_ver , src_title  titl, src_status stat, src_status_date stat_d, src_edcs_error e_err
, src_file_name fname, src_file_type ftype, wf_status w_stat  , wf_status_date w_stat_d,fg_edcs_doc_num, fg_edcs_rev    
, last_modified_by, last_modified_date
from IC_AUDIT_TRAIL i 
where 1=1
and IC_key in ('IC-1011')
order by 2 desc;

-- FINISHED GOODS 
select    i.last_modified_date lmd 
        , i.ic_key 
        --, wf_status, wf_status_date
        , i.src_status, i.src_status_date, i.src_version 
--        , substr(i.fg_title,0,9) fgTitle, substr(i.fg_file_name,0,9) fgFName
        , fg_title, fg_file_name
        , i.fg_file_type, i.fg_edcs_doc_num, i.fg_edcs_rev, i.fg_edcs_status, i.fg_edcs_status_date, i.fg_edcs_approved_date, i.fg_edcs_error
        , i.wf_status, i.wf_status_date
from IC i 
where 1=1
and IC_key in ('IC-1011');


select ic_key, fg_title, i.fg_edcs_doc_num, i.fg_edcs_rev, i.fg_edcs_status, i.fg_edcs_status_date, i.fg_edcs_approved_date, i.fg_edcs_error from IC i
where i.fg_edcs_doc_num = 758103;

        

commit;
                update IC set fg_edcs_rev = 3 where IC_key in ('IC-49');
                
                update IC set fg_edcs_rev = 1, fg_edcs_status = '', fg_edcs_status_date = null, fg_edcs_error = '',fg_edcs_approved_date = ''    
                    where IC_key in ('IC-2011');
                
                update IC set fg_edcs_rev = null where IC_key in ('IC-2010') and src_version = 2;
                update IC set fg_edcs_doc_num = 824281 where IC_key in ('IC-49');
                -- original fg_edcs_num = 756392
                commit;
                rollback;



select    i.audit_action_date aad , audit_action_by aa, i.ic_key, i.fg_edcs_error fgEDCSerror, i.src_version  s_ver, i.fg_title fgTitle, i.fg_file_name fgFName, i.fg_file_type fgFType
        , i.fg_edcs_doc_num fgEDCSnum, i.fg_edcs_rev fgEDCSrev, i.fg_edcs_status fgEDCSstat, i.fg_edcs_status_date fgEDCSstatD 
        , i.wf_status   wf_stat, i.wf_status_date wf_statD 
from IC_AUDIT_TRAIL i 
where 1=1
and IC_key in ('IC-2016');

select    i.audit_action_date aad , audit_action_by aa, i.ic_key, i.fg_edcs_error fgEDCSerror, i.src_version  s_ver, i.fg_title fgTitle, i.fg_file_name fgFName, i.fg_file_type fgFType
        , i.fg_edcs_doc_num fgEDCSnum, i.fg_edcs_rev fgEDCSrev, i.fg_edcs_status fgEDCSstat, i.fg_edcs_status_date fgEDCSstatD 
        , i.wf_status   wf_stat, i.wf_status_date wf_statD 
from IC_AUDIT_TRAIL i 
where 1=1
and IC_key in ('IC-2015')
and audit_action_date < to_date('09/11/2009 16:00:00', 'DD/MM/YYYY HH24:MI:SS')
and audit_action_date > to_date('08/11/2009 18:00:00', 'DD/MM/YYYY HH24:MI:SS');;



                delete from IC_AUDIT_TRAIL i where IC_key in ('IC-2010') and audit_action_by = 'EDCS_Watch_FG';
                delete from IC_AUDIT_TRAIL i where IC_key in ('IC-2044') and audit_action_date < to_date('08/11/2009 18:00:00', 'DD/MM/YYYY HH24:MI:SS');;

commit;

select audit_action_date; 

delete from IC_AUDIT_TRAIL i where IC_key in ('IC-2044') 
and audit_action_date < to_date('08/11/2009 18:00:00', 'DD/MM/YYYY HH24:MI:SS')
and audit_action_date > to_date('06/11/2009 18:00:00', 'DD/MM/YYYY HH24:MI:SS');

select * from ic where fg_edcs_doc_num = 812959;


-- delete from ic where src_version > 1 and IC_key in ('IC-2010');
-- where ic_key in ('IC-2010') and src_version = 1; 


-- ---------------------------------------------------------
-- FIX 2045
-- ---------------------------------------------------------

select * from IC where ic_key = 'IC-2045' and src_version > 1;
commit;

select src_edcs_error from IC where ic_key = 'IC-2045' and src_version = 1;
update IC set src_edcs_error = null where ic_key = 'IC-2045' and src_version = 1;
update IC set src_status = null, src_status_date = null where ic_key = 'IC-2045' and src_version = 1;
delete from IC where ic_key = 'IC-2045' and src_version > 1;


-- SOURCE
select  last_modified_date lmd, ic_key , src_edcs_doc_num e_num, src_version  s_ver , src_title  titl, src_status stat, src_status_date stat_d, src_edcs_error e_err
, src_file_name fname, src_file_type ftype, wf_status w_stat  , wf_status_date w_stat_d,fg_edcs_doc_num, fg_edcs_rev    
, last_modified_by, last_modified_date
from IC i 
where 1=1
and IC_key in ('IC-2045');

select  audit_action_date aad, ic_key , src_edcs_doc_num e_num, src_version  s_ver , src_title  titl, src_status stat, src_status_date stat_d, src_edcs_error e_err
, src_file_name fname, src_file_type ftype, wf_status w_stat  , wf_status_date w_stat_d,fg_edcs_doc_num, fg_edcs_rev    
, last_modified_by, last_modified_date
from IC_AUDIT_TRAIL i 
where 1=1
and IC_key in ('IC-2045');

delete from IC_AUDIT_TRAIL i where 1=1 and IC_key in ('IC-2045');
commit;

-- FG
select    i.last_modified_date lmd , i.ic_key , wf_status wfst, wf_status_date wfstD, i.src_status sst, i.src_status_date sstd, i.src_version  sver, substr(i.fg_title,0,9) fgTitle, substr(i.fg_file_name,0,9) fgFName, i.fg_file_type fgFType
        , i.fg_edcs_doc_num fgEDCSnum, i.fg_edcs_rev fgEDCSrev, i.fg_edcs_status fgEDCSstat, i.fg_edcs_status_date fgEDCSstatD, i.fg_edcs_error fgEDCSerror
        , i.wf_status   wf_stat, i.wf_status_date wf_statD 
from IC i 
where 1=1
and IC_key in ('IC-2045');

update IC set
          fg_edcs_status = null 
        , fg_edcs_status_date = null  
        , fg_file_name = null 
        , fg_file_type = null 
        , fg_edcs_approved_date = null 
        , fg_edcs_rev = 1
where 1=1
and IC_key in ('IC-2045') and src_version = 2;    

select    i.last_modified_date lmd , i.ic_key , wf_status wfst, wf_status_date wfstD, i.src_status sst, i.src_status_date sstd, i.src_version  sver, substr(i.fg_title,0,9) fgTitle, substr(i.fg_file_name,0,9) fgFName, i.fg_file_type fgFType
        , i.fg_edcs_doc_num fgEDCSnum, i.fg_edcs_rev fgEDCSrev, i.fg_edcs_status fgEDCSstat, i.fg_edcs_status_date fgEDCSstatD, i.fg_edcs_error fgEDCSerror
        , i.wf_status   wf_stat, i.wf_status_date wf_statD 
from IC_AUDIT_TRAIL i 
where 1=1
and IC_key in ('IC-2045');


-- ----------------------------------------------------------
-- FIX 2046
-- ---------------------------------------------------------

select * from IC where ic_key = 'IC-2046' and src_version > 1;
commit;

select src_edcs_error from IC where ic_key = 'IC-2046' and src_version = 1;
update IC set src_edcs_error = null where ic_key = 'IC-2046' and src_version = 1;
update IC set src_status = null, src_status_date = null where ic_key = 'IC-2046' and src_version = 1;
delete from IC where ic_key = 'IC-2046' and src_version > 1;


-- SOURCE
select  last_modified_date lmd, ic_key , src_edcs_doc_num e_num, src_version  s_ver , src_title  titl, src_status stat, src_status_date stat_d, src_edcs_error e_err
, src_file_name fname, src_file_type ftype, wf_status w_stat  , wf_status_date w_stat_d,fg_edcs_doc_num, fg_edcs_rev    
, last_modified_by, last_modified_date
from IC i 
where 1=1
and IC_key in ('IC-2046');

select  audit_action_date aad, ic_key , src_edcs_doc_num e_num, src_version  s_ver , src_title  titl, src_status stat, src_status_date stat_d, src_edcs_error e_err
, src_file_name fname, src_file_type ftype, wf_status w_stat  , wf_status_date w_stat_d,fg_edcs_doc_num, fg_edcs_rev    
, last_modified_by, last_modified_date
from IC_AUDIT_TRAIL i 
where 1=1
and IC_key in ('IC-2046');

delete from IC_AUDIT_TRAIL i where 1=1 and IC_key in ('IC-2046');

commit;



-- FG
select    i.last_modified_date lmd , i.ic_key , wf_status wfst, wf_status_date wfstD, i.src_status sst, i.src_status_date sstd, i.src_version  sver, substr(i.fg_title,0,9) fgTitle, substr(i.fg_file_name,0,9) fgFName, i.fg_file_type fgFType
        , i.fg_edcs_doc_num fgEDCSnum, i.fg_edcs_rev fgEDCSrev, i.fg_edcs_status fgEDCSstat, i.fg_edcs_status_date fgEDCSstatD, i.fg_edcs_error fgEDCSerror
        , i.wf_status   wf_stat, i.wf_status_date wf_statD 
from IC i 
where 1=1
and IC_key in ('IC-2046');


update IC set
          fg_edcs_status = null 
        , fg_edcs_status_date = null  
        , fg_file_name = null 
        , fg_file_type = null 
        , fg_edcs_approved_date = null 
        , fg_edcs_rev = 1
where 1=1
and IC_key in ('IC-2046') and src_version = 2;    




select    i.audit_action_date aad , audit_action_by aab, i.ic_key , wf_status wfst, wf_status_date wfstD, i.src_status sst, i.src_status_date sstd, i.src_version  sver, substr(i.fg_title,0,9) fgTitle, substr(i.fg_file_name,0,9) fgFName, i.fg_file_type fgFType
        , i.fg_edcs_doc_num fgEDCSnum, i.fg_edcs_rev fgEDCSrev, i.fg_edcs_status fgEDCSstat, i.fg_edcs_status_date fgEDCSstatD, i.fg_edcs_error fgEDCSerror
        , i.wf_status   wf_stat, i.wf_status_date wf_statD 
from IC_AUDIT_TRAIL i 
where 1=1
and IC_key in ('IC-2046');

commit;

delete from 
IC_AUDIT_TRAIL i 
where 1=1
and IC_key in ('IC-2046')
and audit_action_by = 'Watch EDCS';

and audit_action_date < to_date('08/11/2009 18:00:00', 'DD/MM/YYYY HH24:MI:SS')
and audit_action_date > to_date('06/11/2009 18:00:00', 'DD/MM/YYYY HH24:MI:SS');










select ic_key, fg_edcs_doc_num
from IC where fg_edcs_doc_num is null;


select distinct wf_status from ic
where 1=1
and wf_status not in ('Ignore', 'On Hold', 'Cancelled');

commit;
rollback;
select  last_modified_date lmd, audit_action aa, audit_action_date aad, ic_key , src_edcs_doc_num e_num, src_version  s_ver , src_title  titl, src_status stat, src_status_date stat_d, src_edcs_error e_err
, src_file_name fname, src_file_type ftype, wf_status w_stat  , wf_status_date w_stat_d,fg_edcs_doc_num, fg_edcs_rev    
, last_modified_by, last_modified_date
from IC_Audit_trail2 i 
where 1=1
and IC_key in ('IC-2010') order by 2;
--and IC_key in ('IC-2050', 'IC-2051', 'IC-2052');


select * from IC_artifact where IC_key in ('IC-2045'); 



--update IC_AUDIT_TRAIL2 set audit_action = 'EDCS_Watch_Src' where last_modified_by = 'EDCS_Watch';
select IC_KEY, audit_action, last_modified_by  from IC_AUDIT_TRAIL2 where last_modified_by = 'EDCS_Watch';
select distinct last_modified_by  from IC_AUDIT_TRAIL2 ;
rollback;
commit;

-- and IC_key in ('IC-2014');
--and IC_key in ('IC-2044', 'IC-2045', 'IC-2046');
rollback;

-- delete from IC2 where 1=1 and IC_key in ('IC-2010') and src_version = 2;
delete from IC_audit_trail2 where 1=1 and IC_key in ('IC-2010') and last_modified_date > to_date('06/11/2009 08:50:00', 'DD/MM/YYYY HH24:MI:SS');
--delete from IC_audit_trail2 where 1=1 and IC_key in ('IC-2051') and audit_action_date > to_date('07/11/2009 09:51:00', 'DD/MM/YYYY HH24:MI:SS');
rollback;
commit;
--select last_modified_date, IC_key 
--from ic_audit_trail2 where IC_key = 'IC-2050' 
--and last_modified_date > to_date('07/11/2009 09:42:00', 'DD/MM/YYYY HH24:MI:SS');

--delete from ic_audit_trail2 where IC_key = 'IC-2050' 
--and last_modified_date > to_date('07/11/2009 09:42:00', 'DD/MM/YYYY HH24:MI:SS');


rollback;  
--update IC2 set src_status = 'Approval.N.A', src_status_date = to_date('07/11/2009', 'DD/MM/YYYY'), src_edcs_error = null
--where ic_key in ('IC-2051'); 
--select * from ic_artifact2
--where IC_key in ('IC-2044', 'IC-2045', 'IC-2046');
commit;
--update ic_artifact2
--set watch_flag = 'Y' 
--where IC_key in ('IC-2044', 'IC-2045', 'IC-2046');
commit;
-- ---------------------------------------------
-- TESTING QUEUE
-- test 2041
-- test 2050, 2051, 2052
-- and IC_key in ('IC-2014');
--and IC_key in ('IC-2051');
-- and IC_key in ('IC-2050', 'IC-2051', 'IC-2052');
-- update ic set src_edcs_error = null where IC_key in ('IC-2050', 'IC-2051', 'IC-2052');
-- ---------------------------------------------
create table ic2 as select * from IC;
create table ic_aduti_trail2 as select * from IC_AUDIT_TRAIL;

select fg_edcs_doc_num, substr(fg_edcs_doc_num, 6, length(fg_edcs_doc_num))
from IC2 i 
where fg_edcs_doc_num like 'EDCS%'
and substr(fg_edcs_doc_num, 6, length(fg_edcs_doc_num)) = '760027';

select fg_edcs_doc_num
from IC2 i 
where fg_edcs_doc_num = '760027';

update IC2 set fg_edcs_doc_num = substr(fg_edcs_doc_num, 6, length(fg_edcs_doc_num))
where fg_edcs_doc_num like 'EDCS%';
-- and substr(fg_edcs_doc_num, 6, length(fg_edcs_doc_num)) = '760027'



select  ic_key , src_edcs_doc_num e_num, src_version  s_ver , src_title  titl, src_status stat, src_status_date stat_d, src_edcs_error e_err, src_file_name fname, src_file_type ftype, wf_status w_stat  , wf_status_date w_stat_d, last_modified_date   
from IC_audit_trail
where ic_key in ('IC-2041');
-- and last_modified_date >  to_date('04/11/2009 15:12:00', 'DD/MM/YYYY HH24:MI:SS');

commit;


-- =============================================================================
--update IC set src_status = 'Draft'
--where 1=1 
--and ic_key in ('IC-2013');
-- =============================================================================
delete from IC_AUDIT_TRAIL i where 1=1 
and ic_key in ('IC-2041');
--and last_modified_date >  to_date('03/11/2009 15:12:00', 'DD/MM/YYYY HH24:MI:SS');
-- =============================================================================

rollback;
commit;



rollback;


select ic_key, last_modified_date from ic_audit_trail where ic_key =  'IC-2010';

select ic_key
       , src_edcs_doc_num
       , src_title
       from ic
       where 1=1
and ic_key in ('IC-2044','IC-2045','IC-2046','IC-2010','IC-2011','IC-2012','IC-2013','IC-2014','IC-2015','IC-2016','IC-2017','IC-2018');



commit;

--update IC 
--set src_title = 'Test_Document_1A'
--    , src_status = ''
--    , src_status_date = null
--    , src_edcs_error = '' 
-- where 1=1 
--and ic_key in ('IC-2044');
--,'IC-2045','IC-2046');

rollback;
delete from IC i where 1=1 and ic_key in ('IC-2043') and src_file_name like '%100%' and src_version > 1;

select  ic_key 
        , src_edcs_doc_num doc_num                        
        , src_version ver                 
        , src_title titl                    
        , src_status stat                  
        , src_status_date stat_d             
        , src_edcs_error e_err              
        , src_file_name  fname             
        , src_file_type ftype
        , wf_status
        , wf_status_date
from IC_AUDIT_TRAIL i 
where 1=1 
and ic_key in ('IC-2044','IC-2045','IC-2046');
and src_file_name like '%100%';


delete from IC_AUDIT_TRAIL i 
where 1=1 
and ic_key in ('IC-2043')
and src_file_name like '%100%';

commit;



select i.ic_key
    , i.src_edcs_doc_num src_edcs_doc_num   
    ,   i.src_version src_version   
from    
    IC i   
  , IC_Artifact ia   
where i.ic_key = ia.ic_key   
and ia.watch_flag = 'Y'   
and i.src_origin = 'EDCS'   
and i.ic_key in ('IC-2007','IC-2008','IC-2009','IC-2010','IC-2011','IC-2012','IC-2013','IC-2014','IC-2015','IC-2016','IC-2017','IC-2018')
order by to_number (substr(i.ic_key,4,length(i.ic_key))),i.src_version ;



-- order by to_number (substr(i.ic_key,4,length(i.ic_key))),i.src_version ;
from IC i where ic_key in ('IC-2007', 'IC-2008', 'IC-2009', 'IC-2010', 'IC-2011', 'IC-2012', 'IC-2013', 'IC-2014'
                        , 'IC-2015', 'IC-2016', 'IC-2017', 'IC-2018')
order by to_number (substr(i.ic_key,4,length(i.ic_key))),i.src_version ;



select  
         audit_action
        , audit_action_by
        , audit_action_date
        , ic_key                        
        , src_version                  
        , src_origin                   
        , src_title                    
        , src_status                   
        , src_status_date             
        , src_edcs_doc_num            
        , src_edcs_error              
        , src_file_name               
        , src_file_type    
from IC_AUDIT_TRAIL i
where ic_key in ('IC-2043')
and audit_action_by = 'Watch EDCS';

order by to_number (substr(i.ic_key,4,length(i.ic_key))),i.src_version ;

--where ic_key in ('IC-2007', 'IC-2008', 'IC-2009', 'IC-2010', 'IC-2011', 'IC-2012', 'IC-2013', 'IC-2014'
--                        , 'IC-2015', 'IC-2016', 'IC-2017', 'IC-2018')

select  
         audit_action
        , audit_action_by
        , audit_action_date
        , ic_key                        
        , src_version                  
        , src_origin                   
        , src_title                    
        , src_status                   
        , src_status_date             
        , src_edcs_doc_num            
        , src_edcs_error              
        , src_file_name               
        , src_file_type    
from IC_AUDIT_TRAIL i
where 1=1 
and src_title like '%100%';
and ic_key in ('IC-2007')
and audit_action_by = 'Watch EDCS'
order by to_number (substr(i.ic_key,4,length(i.ic_key))),i.src_version ;




select  ic_key                        
        , src_version                  
        , src_origin                   
        , src_title                    
        , team                          
        , sme                           
        , src_technology_type        
        , src_pass_through_flag     
        , src_status                   
        , src_status_date             
        , src_project_name            
        , src_underlying_technology
        , src_components              
        , src_edcs_doc_num            
        , src_edcs_status             
        , src_edcs_status_date       
        , src_edcs_approved_date    
        , src_edcs_error              
        , src_remedy_ticket_num     
        , src_url                       
        , src_space_name              
        , src_path                      
        , src_file_name               
        , src_file_type               
        , src_location                 
        , src_date_captured          
        , src_3rd_party_origin_flag
        , src_3rd_party_company     
        , src_referenced_doc         
        , src_derived_from            
        , src_related_doc             
        , src_3rdparty_content_flag     
        , src_3rdparty_content_details 
        , src_remediation_unique_id     
        , src_st_project_name          
        , src_st_views                
        , src_st_label                
        , wf_status                    
        , wf_status_date              
        , wf_owner                     
        , wf_issue_flag               
        , wf_comment                   
        , fg_title                     
        , fg_file_name                
        , fg_file_type                
        , fg_edcs_doc_num            
        , fg_edcs_rev                 
        , fg_edcs_status              
        , fg_edcs_status_date       
        , fg_edcs_approved_date     
        , fg_edcs_error               
        , fg_delivered_technology  
        , fg_3rd_party_content_flag     
        , fg_3rd_party_content_details 
        , fg_referenced_docs         
        , fg_derived_from             
        , fg_related_docs             
        , fg_release                    
        , src_exp_date                  
        , rts_location                  
        , rts_file_name                
        , comments                      
        , misc_1                        
        , misc_2                        
        , misc_3                        
        , last_modified_by             
        , last_modified_date          
from IC_AUDIT_TRAIL where ic_key = 'IC-2007';


delete from IC_AUDIT_TRAIL where ic_key = 'IC-2007';