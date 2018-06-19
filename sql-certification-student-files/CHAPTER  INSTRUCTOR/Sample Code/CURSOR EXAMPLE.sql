CREATE OR REPLACE PROCECURE PACKAGE BODY DASHBOARD.metric_rollups_dtv AS

   PROCEDURE driver_dtv (i_start_date IN DATE DEFAULT SYSDATE )
   IS

      v_dtv_dual_date                  DATE;
      v_dtv_connect_status             VARCHAR2 (15);

      v_msg                            VARCHAR2 (1000);

      v_im_stage_dtv_last_ran_date     DATE;
      v_im_stage_dtv_last_ran_status   VARCHAR2 (15);

      v_im_hist_dtv_last_ran_date      DATE;
      v_im_hist_dtv_last_ran_status    VARCHAR2 (15);
      v_im_stage_status_dtv            VARCHAR2 (15);
      v_im_hist_status_dtv             VARCHAR2 (15);
      v_im_rollup_status_dtv           VARCHAR2 (15);

      v_im_ru_dtv_last_ran_date        DATE;
      v_im_ru_dtv_last_ran_status      VARCHAR2 (15);

      v_pm_pull_last_ran               DATE;
      v_cm_pull_last_ran               DATE;

      v_pm_ru_last_ran                 DATE;
      v_cm_ru_last_ran                 DATE;

      v_im_status                      VARCHAR2 (15);
      v_pm_status                      VARCHAR2 (15);
      v_cm_status                      VARCHAR2 (15);

      -- Get all period types in range of dates for rollups
      CURSOR period_cur (
         i_last_ran_date   IN            DATE
      )
      IS
         SELECT   period_id,
                  period_name,
                  period_type,
                  start_date,
                  end_date
           FROM   rdr_period
          WHERE   end_date >=
                     TO_DATE (
                        TO_CHAR (TRUNC (i_last_ran_date - 1), 'MM/DD/YYYY')
                        || '11:59:59 PM',
                        'MM/DD/YYYY HH:MI:SS AM'
                     )
                  AND end_date <=
                        TO_DATE (
                           TO_CHAR (TRUNC (SYSDATE - 1), 'MM/DD/YYYY')
                           || '11:59:59 PM',
                           'MM/DD/YYYY HH:MI:SS AM'
                        );
   BEGIN
      metric_utilities.log_writer ('ALL',
                                   'DTV METRIC_ROLLUP DRIVER START',
                                   SYSDATE,
                                   NULL);
      -- -----------------------------------------------------------------------------------------
      -- Get last run date get_im_stage_dtv
      metric_utilities.determine_last_ran ('IM - DTV Load Stage',
                                           'M',
                                           v_im_stage_dtv_last_ran_date,
                                           v_im_stage_dtv_last_ran_status);
      v_im_stage_dtv_last_ran_date := v_im_stage_dtv_last_ran_date + 1 / 86400;
      metric_utilities.determine_last_ran ('IM - DTV Load History',
                                           'M',
                                           v_im_hist_dtv_last_ran_date,
                                           v_im_hist_dtv_last_ran_status);
      v_im_hist_dtv_last_ran_date := v_im_hist_dtv_last_ran_date + 1 / 86400;
      metric_utilities.determine_last_ran ('IM - DTV All Period Rollups',
                                           'M',
                                           v_im_ru_dtv_last_ran_date,
                                           v_im_ru_dtv_last_ran_status);
      v_im_ru_dtv_last_ran_date := v_im_ru_dtv_last_ran_date + 1 / 86400;
      -- -----------------------------------------------------------------------------------------
      metric_utilities.determine_last_ran ('PM - DTV Pull',
                                           'M',
                                           v_pm_pull_last_ran,
                                           v_pm_status);
      metric_utilities.determine_last_ran ('PM - DTV Rollup',
                                           'M',
                                           v_pm_ru_last_ran,
                                           v_pm_status);
      metric_utilities.determine_last_ran ('CM - DTV Pull',
                                           'M',
                                           v_cm_pull_last_ran,
                                           v_cm_status);
      v_cm_pull_last_ran := v_cm_pull_last_ran + 1 / 86400;
      metric_utilities.determine_last_ran ('CM - DTV Rollup',
                                           'M',
                                           v_cm_ru_last_ran,
                                           v_cm_status);
      v_cm_ru_last_ran := v_cm_ru_last_ran + 1 / 86400;

      -- -------------------------------------------------------------------------------------------
      -- Check DTV link
      BEGIN
         SELECT   SYSDATE
           INTO   v_dtv_dual_date
           FROM   DUAL@DTVREMP1.CISCO.COM hd;
      EXCEPTION
         WHEN OTHERS
         THEN
            v_dtv_dual_date := NULL;
            v_msg := SQLERRM;
            metric_utilities.log_writer (
               'ALL',
               'DTV METRIC_ROLLUP DRIVER ERROR - dtv link validation',
               SYSDATE,
               v_msg
            );
      END;

      IF v_dtv_dual_date IS NOT NULL
      THEN
         v_dtv_connect_status := 'SUCCESS';
      ELSE
         v_dtv_connect_status := 'FAILED';
      END IF;

      -- -------------------------------------------------------------------------------------------
      -- Log the connection status
      metric_utilities.log_writer (
         'ALL',
         'METRIC_ROLLUP DTV Connection status ' || v_dtv_connect_status,
         SYSDATE,
         NULL
      );

      -- -------------------------------------------------------------------------------------------
      -- LOAD IM_STAGE_DATA
      IF v_dtv_connect_status = 'SUCCESS'
      THEN
         INSERT INTO metric_control (
                                        metric_name,
                                        run_start_date,
                                        run_end_date,
                                        calculation_from_date,
                                        calculation_to_date,
                                        status
                    )
           VALUES   (
                        'IM - DTV Load Stage',
                        SYSDATE,
                        NULL,
                        v_im_stage_dtv_last_ran_date,
                        TO_DATE (
                           TO_CHAR (SYSDATE - 1, 'MM/DD/YYYY')
                           || '11:59:59 PM',
                           'MM/DD/YYYY HH:MI:SS AM'
                        ),
                        'STARTED'
                    );
      ELSE
         INSERT INTO metric_control (
                                        metric_name,
                                        run_start_date,
                                        run_end_date,
                                        calculation_from_date,
                                        calculation_to_date,
                                        status
                    )
           VALUES   (
                        'IM - DTV Load Stage',
                        SYSDATE,
                        NULL,
                        v_im_stage_dtv_last_ran_date,
                        TO_DATE (
                           TO_CHAR (SYSDATE - 1, 'MM/DD/YYYY')
                           || '11:59:59 PM',
                           'MM/DD/YYYY HH:MI:SS AM'
                        ),
                        'No Connection Available'
                    );
      END IF;

      -- -------------------------------------------------------------------------------------------
      -- If connection is good then load im_stage_data_dtv
      IF v_dtv_connect_status = 'SUCCESS'
      THEN
         im_get_data_dtv (
            v_im_stage_dtv_last_ran_date,
            TO_DATE (TO_CHAR (SYSDATE - 1, 'MM/DD/YYYY') || '11:59:59 PM',
                     'MM/DD/YYYY HH:MI:SS AM'),
            v_im_stage_status_dtv
         );
         metric_utilities.log_writer ('ALL',
                                      'IM - DTV Load Stage Complete',
                                      SYSDATE,
                                      NULL);
      ELSE
         metric_utilities.set_current_run_stop ('IM - DTV Load Stage',
                                                v_dtv_connect_status);
      END IF;

      metric_utilities.set_current_run_stop ('IM - DTV Load Stage',
                                             v_im_stage_status_dtv);

      -- -------------------------------------------------------------------------------------------
      -- LOAD IM_HISTORY_DATA
      -- -----------------------------------------------------------------------------------------
      -- If stage table loaded then update im_history_data
      IF v_im_stage_status_dtv = 'SUCCESS'
      THEN
         INSERT INTO metric_control (
                                        metric_name,
                                        run_start_date,
                                        run_end_date,
                                        calculation_from_date,
                                        calculation_to_date,
                                        status
                    )
           VALUES   (
                        'IM - DTV Load History',
                        SYSDATE,
                        NULL,
                        v_im_hist_dtv_last_ran_date,
                        TO_DATE (
                           TO_CHAR (SYSDATE - 1, 'MM/DD/YYYY')
                           || '11:59:59 PM',
                           'MM/DD/YYYY HH:MI:SS AM'
                        ),
                        'STARTED'
                    );
      ELSE
         INSERT INTO metric_control (
                                        metric_name,
                                        run_start_date,
                                        run_end_date,
                                        calculation_from_date,
                                        calculation_to_date,
                                        status
                    )
           VALUES   (
                        'IM - DTV Load History',
                        SYSDATE,
                        NULL,
                        v_im_hist_dtv_last_ran_date,
                        TO_DATE (
                           TO_CHAR (SYSDATE - 1, 'MM/DD/YYYY')
                           || '11:59:59 PM',
                           'MM/DD/YYYY HH:MI:SS AM'
                        ),
                        'Load Stage Failed'
                    );
      END IF;

      IF v_im_stage_status_dtv = 'SUCCESS'
      THEN
         im_update_history_dtv (v_im_hist_status_dtv);
         metric_utilities.log_writer ('ALL',
                                      'IM - DTV Load History Complete',
                                      SYSDATE,
                                      NULL);
      ELSE
         metric_utilities.set_current_run_stop ('IM - DTV Load History',
                                                v_im_hist_status_dtv);
      END IF;

      metric_utilities.set_current_run_stop ('IM - DTV Load History',
                                             v_im_hist_status_dtv);

      -- ----------------------------------------------------------------------------
      -- DTV rollup: loop through and rollup for each period id since last time we ran
      -- this assumes that the rollup has run at least once successfully
      -- therefore the metric_control table has been seeded with one record
      IF v_im_hist_status_dtv = 'SUCCESS'
      THEN
         -- Log the start of All Period Rollups Startting
         metric_utilities.log_writer ('ALL',
                                      'IM - DTV All Period Rollups Starting',
                                      SYSDATE,
                                      NULL);

         -- Enter into metric_control the starting of all Period Rollups
         INSERT INTO metric_control (
                                        metric_name,
                                        run_start_date,
                                        run_end_date,
                                        calculation_from_date,
                                        calculation_to_date,
                                        status
                    )
           VALUES   (
                        'IM - DTV All Period Rollups',
                        SYSDATE,
                        NULL,
                        v_im_ru_dtv_last_ran_date,
                        TO_DATE (
                           TO_CHAR (SYSDATE - 1, 'MM/DD/YYYY')
                           || '11:59:59 PM',
                           'MM/DD/YYYY HH:MI:SS AM'
                        ),
                        'STARTED'
                    );

         -- Then proceed to calculate each individual rollup
         FOR period_rec IN period_cur (v_im_ru_dtv_last_ran_date)
         LOOP
            -- Enter the start of the indivual DTV rollup
            INSERT INTO metric_control (metric_name,
                                        run_start_date,
                                        run_end_date,
                                        calculation_from_date,
                                        calculation_to_date,
                                        status,
                                        period_id)
              VALUES   ('IM - DTV Rollup',
                        SYSDATE,
                        NULL,
                        period_rec.start_date,
                        period_rec.end_date,
                        'STARTED',
                        period_rec.period_id);

            COMMIT;
            -- run the actual indivual DTV rollup
            im_rollup_data_dtv (period_rec.start_date,
                                period_rec.end_date,
                                period_rec.period_id,
                                period_rec.period_type,
                                period_rec.period_name,
                                v_im_rollup_status_dtv);

            -- set the stop with the status returned
            metric_utilities.set_current_run_stop ('IM - DTV Rollup',
                                                   v_im_rollup_status_dtv);

            metric_utilities.log_writer (
               'ALL',
                  'IM_DTV:'
               || period_rec.period_type
               || ' is Complete - Period: '
               || period_rec.period_id,
               SYSDATE,
               NULL
            );
         END LOOP;

         -- Log the end of all DTV Rollups
         metric_utilities.log_writer ('ALL',
                                      'IM - DTV All Period Rollups Complete',
                                      SYSDATE,
                                      NULL);

         -- Set the metric_control entry for all with the status of the last period status
         metric_utilities.set_current_run_stop (
            'IM - DTV All Period Rollups',
            v_im_rollup_status_dtv
         );
      ELSE
         INSERT INTO metric_control (
                                        metric_name,
                                        run_start_date,
                                        run_end_date,
                                        calculation_from_date,
                                        calculation_to_date,
                                        status
                    )
           VALUES   (
                        'IM - DTV All Period Rollups',
                        SYSDATE,
                        NULL,
                        v_im_ru_dtv_last_ran_date,
                        TO_DATE (
                           TO_CHAR (SYSDATE - 1, 'MM/DD/YYYY')
                           || '11:59:59 PM',
                           'MM/DD/YYYY HH:MI:SS AM'
                        ),
                        'FAILED: No Hostory Update Success'
                    );

         -- Log the failure all DTV Rollups
         metric_utilities.log_writer ('ALL',
                                      'METRIC_ROLLUP_DTV IM Failed',
                                      SYSDATE,
                                      NULL);
      END IF;

      -- =========================================================================================
      -- Do PM
      -- =========================================================================================
      metric_utilities.log_writer ('ALL',
                                   'PM - DTV Pull Starting ' || v_pm_status,
                                   SYSDATE,
                                   NULL);

      IF v_pm_status = 'SUCCESS'
      THEN
         INSERT INTO metric_control (
                                        metric_name,
                                        run_start_date,
                                        run_end_date,
                                        calculation_to_date,
                                        calculation_from_date,
                                        status
                    )
           VALUES   (
                        'PM - DTV Pull',
                        SYSDATE,
                        NULL,
                        TO_DATE (
                           TO_CHAR (SYSDATE - 1, 'MM/DD/YYYY')
                           || '11:59:59 PM',
                           'MM/DD/YYYY HH:MI:SS AM'
                        ),
                        v_pm_pull_last_ran,
                        'STARTED'
                    );

         COMMIT;
      -- metric_utilities.set_current_run_start('PM', period_rec.start_date, period_rec.period_type, period_rec.end_date, v_pm_status);
      ELSE
         metric_utilities.set_current_run_stop ('PM - DTV Pull', v_pm_status);
      END IF;

      IF v_pm_status = 'SUCCESS'
      THEN
         pm_get_data_dtv (
            v_pm_pull_last_ran,
            TO_DATE (TO_CHAR (SYSDATE - 1, 'MM/DD/YYYY') || '11:59:59 PM',
                     'MM/DD/YYYY HH:MI:SS AM'),
            v_pm_status
         );
      ELSE
         metric_utilities.set_current_run_stop ('PM - DTV Pull', v_pm_status);
      END IF;

      metric_utilities.log_writer (
         'ALL',
         'PM - DTV Update Starting ' || v_pm_status,
         SYSDATE,
         NULL
      );

      IF v_pm_status = 'SUCCESS'
      THEN
         pm_update_history_dtv (v_pm_status);
      ELSE
         metric_utilities.set_current_run_stop ('PM - DTV Pull', v_pm_status);
      END IF;

      metric_utilities.set_current_run_stop ('PM - DTV Pull', v_pm_status);
      --Check for successful determination of last run date AND THEN proceed
      metric_utilities.log_writer (
         'ALL',
         'PM - DTV Rollup Starting ' || v_pm_status,
         SYSDATE,
         NULL
      );

      IF v_pm_status = 'SUCCESS'
      THEN
         INSERT INTO metric_control (
                                        metric_name,
                                        run_start_date,
                                        run_end_date,
                                        calculation_to_date,
                                        calculation_from_date,
                                        status
                    )
           VALUES   (
                        'PM - DTV Rollup',
                        SYSDATE,
                        NULL,
                        TO_DATE (
                           TO_CHAR (SYSDATE - 1, 'MM/DD/YYYY')
                           || '11:59:59 PM',
                           'MM/DD/YYYY HH:MI:SS AM'
                        ),
                        v_pm_pull_last_ran,
                        'STARTED'
                    );

         COMMIT;


         pm_rollup_data_dtv (v_pm_status);
      ELSE
         metric_utilities.set_current_run_stop ('PM - DTV Rollup',
                                                v_pm_status);
      END IF;

      metric_utilities.set_current_run_stop ('PM - DTV Rollup', v_pm_status);
      ---------------------------------------------------------------------------------
      --Do CM
      --Check for successful determination of last run date AND THEN proceed
      metric_utilities.log_writer (
         'ALL',
         'CM - DTV Get Data Starting ' || v_cm_status,
         SYSDATE,
         NULL
      );

      IF v_cm_status = 'SUCCESS'
      THEN
         INSERT INTO metric_control (
                                        metric_name,
                                        run_start_date,
                                        run_end_date,
                                        calculation_to_date,
                                        calculation_from_date,
                                        status
                    )
           VALUES   (
                        'CM - DTV Pull',
                        SYSDATE,
                        NULL,
                        TO_DATE (
                           TO_CHAR (SYSDATE - 1, 'MM/DD/YYYY')
                           || '11:59:59 PM',
                           'MM/DD/YYYY HH:MI:SS AM'
                        ),
                        v_cm_pull_last_ran,
                        'STARTED'
                    );
      --metric_utilities.set_current_run_start('CM', period_rec.start_date, period_rec.period_type, period_rec.end_date, v_cm_status);
      ELSE
         metric_utilities.set_current_run_stop ('CM - DTV Pull', v_cm_status);
      END IF;

      IF v_cm_status = 'SUCCESS'
      THEN
         cm_get_data_dtv (
            v_cm_pull_last_ran,
            TO_DATE (TO_CHAR (SYSDATE - 1, 'MM/DD/YYYY') || '11:59:59 PM',
                     'MM/DD/YYYY HH:MI:SS AM'),
            v_cm_status
         );
      ELSE
         metric_utilities.set_current_run_stop ('CM - DTV Pull', v_cm_status);
      END IF;

      metric_utilities.log_writer (
         'ALL',
         'CM - DTV Update Starting ' || v_cm_status,
         SYSDATE,
         NULL
      );

      IF v_cm_status = 'SUCCESS'
      THEN
         cm_update_history_dtv (v_cm_status);
      ELSE
         metric_utilities.set_current_run_stop ('CM - DTV Pull', v_cm_status);
      END IF;

      metric_utilities.set_current_run_stop ('CM - DTV Pull', v_cm_status);

      metric_utilities.log_writer (
         'ALL',
         'CM - DTV Rollup Starting ' || v_cm_status,
         SYSDATE,
         NULL
      );

      IF v_cm_status = 'SUCCESS'
      THEN
         INSERT INTO metric_control (
                                        metric_name,
                                        run_start_date,
                                        run_end_date,
                                        calculation_to_date,
                                        calculation_from_date,
                                        status
                    )
           VALUES   (
                        'CM - DTV Rollup',
                        SYSDATE,
                        NULL,
                        TO_DATE (
                           TO_CHAR (SYSDATE - 1, 'MM/DD/YYYY')
                           || '11:59:59 PM',
                           'MM/DD/YYYY HH:MI:SS AM'
                        ),
                        v_cm_pull_last_ran,
                        'STARTED'
                    );

         cm_rollup_data_dtv (v_cm_status);
      ELSE
         metric_utilities.set_current_run_stop ('CM - DTV Rollup',
                                                v_cm_status);
      END IF;

      metric_utilities.set_current_run_stop ('CM - DTV Rollup', v_cm_status);
      metric_utilities.log_writer ('ALL',
                                   'METRIC_ROLLUP DRIVER COMPLETE',
                                   SYSDATE,
                                   NULL);
   EXCEPTION
      WHEN OTHERS
      THEN
         v_msg := SQLERRM;
         metric_utilities.log_writer ('ALL',
                                      'METRIC_ROLLUP DRIVER ERROR',
                                      SYSDATE,
                                      v_msg);
   END driver_dtv;   

-- ----------------------------------------------------------------------------------------------
-- INCIDENT MANAGEMENT
-- ----------------------------------------------------------------------------------------------
   --Gets stage data FROM Incident Managment bASe tables   
  
   PROCEDURE im_get_data_DTV (i_start_date  IN DATE
                             ,i_stop_date   IN DATE
                             ,o_im_status   OUT VARCHAR ) IS
        --       DTV REMEDY   (Source:  'DTVREMP1.CISCO.COM 
        --           Truncate work tables
        --           Determine which incident numbers to pull
        --           Populate stage data
        --           Set autonotify flag
        --           Set the SLAS met
        --
        --       NOTE: following values use remedy values directly
        --             none of these use the term resolution
        --                    closed_date                := hd.closed_date
        --                    estimated_resolution_date    := hd.estimated_resolution_date
        --                    initial_notification_date    := hd.initial_notification_date
        --                    isolation_date            := hd.isolation_date
        --                    lASt__ASsigned_date        := hd.lASt__ASsigned_date
        --                    lASt_ackowledged_date        := hd.lASt_ackowledged_date
        --                    lASt_modified_date        := hd.lASt_modified_date
        --                    lASt_occurence            := hd.lASt_occurence
        --                    lASt_resolved_date        := hd.lASt_resolved_date
        --                    reported_date                := hd.reported_date
        --                    responded_date            := hd.responded_date
        --                    submit_date                := hd.submit_date
        -- 
        --       NOTE: following values use DTV logic 
        --             all of thse use the term resolution
        --                   WHEN hd.lASt_resolved_date IS NOT NULL AND 
        --                        hd.status in (4,5) then 
        --                     USE lASt_resolved_date in calculation
        --                   WHEN hd.lASt_resolved_date is null AND 
        --                        hd.closed_date IS NOT NULL AND
        --                        hd.status in (4,5) then AND
        --                     USE closed_date in calculation
        --
        --           THESE ARE THE FOUR VALUES CHANGED
        --           alarm_to_resolve_mins
        --           tkt_create_to_resolved_hrs
        --           tkt_isolate_to_resolved_mins
        --           tkt_resolved_to_closed_mins 
        --
        --          Priority is now calculated using reported_network_condition
        --          Reported Network Condition   Priority
        --              0    Network Event           3
        --              1    Degraded Service        2
        --              2    Outage                  1
        --          Company_id now set using:
        --          Company                    Company_ID
        --            'DIRECTV-NGBN'          'CPY000000001337'
        --            'DIRECTV-BROADBAND'     'CPY000000001338'
        --            'DIRECTV-CONUS'         'CPY000000001339'
        --            'DIRECTV'               NULL      
        v_msg  VARCHAR2(1000);     
        v_lASt_updated  DATE;
        -- ---------------------------------------------------------------------------    
        -- autonotify flag
        -- -----------------------------------------------------------------------------
        TYPE ticket_list_an IS TABLE OF VARCHAR2(15) INDEX BY BINARY_INTEGER;
        TYPE tASk_count_list IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;
        my_ticket_list_an ticket_list_an;
        my_tASk_count_list tASk_count_list;

        -- ---------------------------------------------------------------------------    
        -- all others 
        -- -----------------------------------------------------------------------------
        -- 0. ticket_list
        TYPE ticket_list IS TABLE OF VARCHAR2(15) INDEX BY BINARY_INTEGER;
        -- 1. company_id
        TYPE company_list IS TABLE OF VARCHAR2(254) INDEX BY BINARY_INTEGER;
        -- 2. auto_notify_flag
        TYPE auto_notify_list IS TABLE OF VARCHAR2(1) INDEX BY BINARY_INTEGER;
        -- 3. alarm_to_analyze
        TYPE in_progress_date_list IS TABLE OF DATE INDEX BY BINARY_INTEGER;
        TYPE reported_date_list IS TABLE OF DATE INDEX BY BINARY_INTEGER;
        -- 4. inc_mttc
        -- 6. met_mttc sla
        TYPE alarm_to_crt_mins_list IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;
        -- 5. inc_mttn
        -- 7. mttn_sla_met
        TYPE tkt_create_to_notify_mins_list IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;
        TYPE submitter_list IS TABLE OF VARCHAR2(254 BYTE) INDEX BY BINARY_INTEGER;
        -- 8-11. met_Px_SLA                        
        TYPE priority_list IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;
        TYPE reported_network_condition_tbl IS TABLE OF NUMBER INDEX BY BINARY_INTEGER; 
        TYPE tkt_create_to_resolved_hrs IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;
        -- ---------------------------------------------------------------------------
        -- create variables of that type
        -- 0. Ticket_list
        my_ticket_list ticket_list;
        -- 1. company_id
        my_company_list company_list; 
        -- 2. auto_notify_flag
        my_auto_notify_list auto_notify_list;
        -- 3. alarm_to_analyze
        my_in_progress_date_list in_progress_date_list;
        my_reported_date_list reported_date_list;
        -- 4. inc_mttc
        -- 6. met MTTC SLA
        my_alarm_to_crt_mins_list alarm_to_crt_mins_list;
        -- 5. inc_mttn
        -- 7. mttn_sla_met
        my_tkt_create_to_not_mins_list tkt_create_to_notify_mins_list;
        my_submitter_list submitter_list;
        -- 8-11. met_Px_SLA                        
        my_priority_list priority_list;
        my_reptd_network_cond_list reported_network_condition_tbl;
        my_tkt_create_to_res_hrs_list tkt_create_to_resolved_hrs;
                        
        -- Create local variables
        -- 1. company_id
        v_company_id                   VARCHAR2(15);
        -- 2. auto_notify_flag
        v_auto_notify_flag             VARCHAR2(1);
        -- 3. alarm_to_analyze
        v_alarm_to_analyze_mins        NUMBER;
        -- 4. inc_mttc
        v_inc_mttcreate                VARCHAR2(1);
        -- 6. met_mttc_sla
        v_mttcreate_sla_met            VARCHAR2(1);
        -- 5. met_mttn
        v_inc_mttn                     VARCHAR2(1);
        -- 7. met_mttn_sla
        v_mttn_sla_met                 VARCHAR2(1);
        -- 8-11. met_Px_SLA                        
        v_mttr_p1_sla_met              VARCHAR2(1);
        v_mttr_p2_sla_met              VARCHAR2(1);
        v_mttr_p3_sla_met              VARCHAR2(1);
        v_mttr_p4_sla_met              VARCHAR2(1); 
        
        reported_net_cond_is_blank     BOOLEAN;
 BEGIN
      reported_net_cond_is_blank := FALSE;
      v_mttr_p1_sla_met  := 'N';
      v_mttr_p2_sla_met  := 'N';
      v_mttr_p3_sla_met  := 'N';
      
      v_lASt_updated := SYSDATE;
      
      -- Truncate our work tables
      -- May have more than one entry for a ticket number in the work table
      METRIC_UTILITIES.TRUNC_TABLE('dAShboard.im_stage_ids_to_pull_work_dtv');

      -- Get distinct ticket numbers 
      METRIC_UTILITIES.TRUNC_TABLE('dAShboard.im_stage_data_ids_to_pull_dtv');
      
      METRIC_UTILITIES.TRUNC_TABLE('dAShboard.im_stage_data_dtv');
      COMMIT;
     
      -- Determine which incident numbers to pull
      INSERT INTO im_stage_ids_to_pull_work_dtv(incident_number)
           SELECT hd.incident_number
             FROM aradmin.hpd_help_desk@dtvremp1.cisco.com hd
            WHERE metric_utilities.convert_to_date(hd.lASt_modified_date) > i_start_date
            UNION
            SELECT request_id02
             FROM aradmin.hpd_ASsociations@dtvremp1.cisco.com ha
            WHERE metric_utilities.convert_to_date(ha.lASt_modified_date) > i_start_date
            UNION
            SELECT incident_number
             FROM aradmin.hpd_worklog@dtvremp1.cisco.com hw
            WHERE metric_utilities.convert_to_date(hw.lASt_modified_date) > i_start_date;
      COMMIT;
      
      INSERT INTO im_stage_data_ids_to_pull_dtv(incident_number)
         SELECT DISTINCT incident_number FROM im_stage_ids_to_pull_work_dtv;
      COMMIT; 

    --Populate stage data
     INSERT INTO DASHBOARD.IM_STAGE_DATA_DTV (
              incident_number
            , alarm_identifier
            , alarm_type
            , ASsigned_group
            , ASsigned_support_company
            , ASsigned_support_organization
            , ASsignee
            , ASsignee_groups
            , city
            , closure_product_category_tier1
            , closure_product_category_tier2
            , closure_product_category_tier3
            , closure_product_name
            , company
            -- set in the cursor below
            --, companyid
            , correlated_ci
            , correlated_id
            , country
            , country_code
            , created_by
            , effort_time_spent_minutes
            , first_name
            , generic_categorization_tier_1
            , generic_categorization_tier_2
            , generic_categorization_tier_3
            , impact
            , impact_rating
            , lASt_modified_by
            , lASt_name
            , lookupkeyword
            , managed
            , manufacturer
            , mapped_severity
            , mom_identifier
            , mom_type
            , organization
            , owner
            , owner_group
            , owner_group_id
            , owner_support_company
            , owner_support_organization
            , partner
            , priority
            , product_categorization_tier_1
            , product_categorization_tier_2
            , product_categorization_tier_3
            , product_model_version
            , product_name
            , recurrence
            , region
            , related_alarm_code
            , reported_source
            , reportedci
            , resolution_category
            , resolution_category_tier_2
            , resolution_category_tier_3
            , service_type
            , severity
            , short_description
            , site
            , site_group
            , site_id
            , state_province
            , status
            , status_reASon
            , submitter
            , total_escalation_level
            , total_ola_acknowledgeesc_level
            , total_ola_resolution_esc_level
            , total_time_spent
            , total_transfers
            , urgency
            -- Atomic Dates
            , closed_date
            , estimated_resolution_date
            , initial_notification_date
            , isolation_date
            , lASt__ASsigned_date
            , lASt_ackowledged_date
            , lASt_modified_date
            , lASt_occurence
            , lASt_resolved_date
            , reported_date
            , responded_date
            , submit_date
            -- Calculated Dates
            , in_progress_date
            , day_closed
            , day_opened
            , month_closed
            , month_opened
            , week_closed
            , week_opened
            -- Calculated Flags
            -- Set in the cursor below
            -- , auto_notify_flag
            , auto_tkt_flag
            , closed_AS_duplicate_flag
            , closed_AS_ros_infrAStr_flag
            , closed_AS_merged_flag
            , sched_maint_flag
            -- Calculated Counts 
            , num_cust_escalations
            , num_customer_updates
            , num_entitlement_wil
            , num_external_escalations
            , num_internal_escalations
            , num_touches
            -- no off_clock_time_mins possible with DTV Remedy            
            -- , off_clock_time_mins                                                               
            , alarm_to_notify_mins           
            , alarm_to_isolate_mins           
            , alarm_to_resolve_mins           
            , alarm_to_close_mins           
            -- Set in the cursor below
            -- , alarm_to_analyze_mins           
            , alarm_to_create_mins           
            , Tkt_Create_To_Closed_Hrs     
            , Tkt_Create_To_Isolate_Mins     
            , Tkt_Create_To_Notify_Mins     
            , Tkt_Create_To_Resolved_Hrs     
            , Tkt_Isolate_To_Resolved_Mins     
            , Tkt_Resolved_To_Closed_Mins     
            , data_source
            -- Set in the cursor below
            --, inc_mttcreate
            --, inc_mttn
            , description
            , system_created
            , lASt_updated
            , reported_network_condition 
            , notification_required
            )
    SELECT      
            -- atomic data 1 x 1
              hd.incident_number
            , hd.alarm_identifier
            , hd.alarm_type
            , hd.ASsigned_group
            , hd.ASsigned_support_company
            , hd.ASsigned_support_organization
            , hd.ASsignee
            , hd.ASsignee_groups
            , hd.city
            , hd.closure_product_category_tier1
            , hd.closure_product_category_tier2
            , hd.closure_product_category_tier3
            , hd.closure_product_name
            , hd.company
            --, hd.corporate_id
            , hd.correlated_ci
            , hd.correlated_id
            , hd.country
            , hd.country_code
            , hd.created_by
            , hd.effort_time_spent_minutes
            , hd.first_name
            , hd.generic_categorization_tier_1
            , hd.generic_categorization_tier_2
            , hd.generic_categorization_tier_3
            , hd.impact
            , hd.impact_rating
            , hd.lASt_modified_by
            , hd.lASt_name
            , hd.lookupkeyword
            , hd.managed
            , hd.manufacturer
            , hd.mapped_severity
            , hd.mom_identifier
            , hd.mom_type
            , hd.organization
            , hd.owner
            , hd.owner_group
            , hd.owner_group_id
            , hd.owner_support_company
            , hd.owner_support_organization
            , hd.partner
            -- -----------------------------------
            -- Priority
            -- Reported Network Condition   Priority
            -- 0    Network Event           3
            -- 1    Degraded Service        2
            -- 2    Outage                  1
            , CASE
                        WHEN hd.reported_network_condition = 0 THEN
                          3
                        WHEN hd.reported_network_condition = 1 THEN
                          2
                        WHEN hd.reported_network_condition = 2 THEN
                          1
                        WHEN hd.reported_network_condition IS NULL THEN
                          hd.priority
                        END
                        AS
              priority
            , hd.product_categorization_tier_1
            , hd.product_categorization_tier_2
            , hd.product_categorization_tier_3
            , hd.product_model_version
            , hd.product_name
            , hd.recurrence
            , hd.region
            , hd.related_alarm_code
            , hd.reported_source
            , hd.reportedci
            , hd.resolution_category
            , hd.resolution_category_tier_2
            , hd.resolution_category_tier_3
            , hd.service_type
            , hd.severity
            , hd.short_description
            , hd.site
            , hd.site_group
            , hd.site_id
            , hd.state_province
            , DECODE (hd.status,
                            0,    'New',
                            1,    'ASsigned',
                            2,    'In Progress',
                            3,    'Pending',
                            4,    'Resolved',
                            5,    'Closed',
                            6,    'Cancelled') AS
              status
            , hd.status_reASon
            , hd.submitter
            , hd.total_escalation_level
            , hd.total_ola_acknowledgeesc_level
            , hd.total_ola_resolution_esc_level
            , hd.total_time_spent
            , hd.total_transfers
            , hd.urgency
            -- Atomic Dates
            , metric_utilities.convert_to_date(hd.closed_date)
            , metric_utilities.convert_to_date(hd.estimated_resolution_date)
            , metric_utilities.convert_to_date(hd.initial_notification_date)
            , metric_utilities.convert_to_date(hd.isolation_date)
            , metric_utilities.convert_to_date(hd.lASt__ASsigned_date)
            , metric_utilities.convert_to_date(hd.lASt_acknowledged_date)
            , metric_utilities.convert_to_date(hd.lASt_modified_date)
            , metric_utilities.convert_to_date(hd.lASt_occurrence)
            , metric_utilities.convert_to_date(hd.lASt_resolved_date)
            , metric_utilities.convert_to_date(hd.reported_date)
            , metric_utilities.convert_to_date(hd.responded_date)
            , metric_utilities.convert_to_date(hd.submit_date)
            -- Calculated Dates
            -- NOTE: the cisco remedy system uses A_CSC_HPD_HELPDESKSTATUSLOG
                -- which creates a new record every time a ticket changes ststus
                -- this table can be use to determine the earliest date a ticket went into a
                -- particular status and how long it wAS in that status    
                -- DTV REMEDY does not have this table, instead we use the H1074 table
                -- which holds a single record for each incident and just the most recent
                -- time it went into a specific status T2 is the time it enbters "In Progress"
            , (SELECT metric_utilities.convert_to_date(h.t2) 
                 FROM  aradmin.h1074@dtvremp1.cisco.com h
                 WHERE h.entryid = hd.incident_number)
             in_progress_date
            -- this is the original Cisco Remedy code left in for readability
                    --,( SELECT MIN(in_progress_date)+(v_offset/24)
                    --    FROM rdr_ticket rdrt
                    --   WHERE hd.incident_number = rdrt.incident_number
                    --   GROUP BY incident_number) AS 
                    --in_progress_date
            ,TRUNC(metric_utilities.convert_to_date(hd.closed_date),'DD') AS
            day_closed
            ,TRUNC(metric_utilities.convert_to_date(hd.submit_date),'DD') AS
            day_opened                
            ,TRUNC(metric_utilities.convert_to_date(hd.closed_date),'MM') AS
            month_closed
            ,TRUNC(metric_utilities.convert_to_date(hd.submit_date),'MM') AS
            month_opened
            ,TRUNC(metric_utilities.convert_to_date(hd.closed_date),'WW') AS
            week_closed
            ,TRUNC(metric_utilities.convert_to_date(hd.submit_date),'WW') AS
            week_opened
            -- Calculated Flags
            --            , tmp.auto_notify auto_notify_flag                                                                      
            ,           CASE 
                           WHEN hd.submitter = 'WEBSERVICES' THEN 'Y' 
                           ELSE 'N' 
                        END AS
            auto_tkt_flag
            ,           CASE 
                           WHEN hd.status = 5 AND hd.resolution_category_tier_2 = 'Duplicate Ticket' THEN 'Y' 
                           ELSE 'N' 
                        END AS 
            closed_AS_duplicate_flag 
            ,           CASE 
                            WHEN hd.status = 5 AND hd.resolution_category = 'ROS InfrAStructure' THEN 'Y' 
                            ELSE 'N' 
                         END AS  
            closed_AS_ros_infrAStr_flag 
            ,           CASE 
                           WHEN hd.status = 5 AND hd.status_reASon = 1500 THEN 'Y' 
                           ELSE 'N' 
                        END AS          
            closed_AS_merged_flag
            ,           CASE 
                           WHEN hd.resolution_category_tier_2 = 'Scheduled Maint' THEN 'Y' 
                           ELSE 'N' 
                        END AS                                                    
            sched_maint_flag
            -- Calculated Counts 
            ,           NVL(( 
                          SELECT COUNT(hw.work_log_type) num_cust_escalations 
                            FROM aradmin.hpd_worklog@dtvremp1.cisco.com hw
                           WHERE hw.work_log_type in (4201)
                             AND hd.incident_number = hw.incident_number
                           GROUP BY hw.incident_number
                        ),0) AS 
            num_cust_escalations
            ,           NVL ((
                          SELECT COUNT(hw.work_log_type) num_customer_updates
                            FROM aradmin.hpd_worklog@dtvremp1.cisco.com hw
                           WHERE hw.work_log_type in (5105, 6000, 7000, 8000, 9000, 10000, 11000, 11001)
                             AND hd.incident_number = hw.incident_number
                           GROUP BY hw.incident_number     
                        ),0) AS 
           num_customer_updates
           ,            NVL(( 
                          SELECT COUNT(hw.work_log_type) num_entitlement_wil 
                            FROM aradmin.hpd_worklog@dtvremp1.cisco.com hw
                           WHERE hw.work_log_type in (18008)
                             AND hd.incident_number = hw.incident_number
                           GROUP BY hw.incident_number
                        ),0) AS 
           num_entitlement_wil
           ,            NVL(( 
                          SELECT COUNT(hw.work_log_type)                           
                            FROM aradmin.hpd_worklog@dtvremp1.cisco.com hw
                           WHERE hw.work_log_type in (18007)
                             AND hd.incident_number = hw.incident_number
                           GROUP BY hw.incident_number
                        ),0) AS 
           num_external_escalations
          ,             NVL(( 
                          SELECT COUNT(hw.work_log_type) num_internal_escalations 
                            FROM aradmin.hpd_worklog@dtvremp1.cisco.com hw
                           WHERE hw.work_log_type in (18006)
                             AND hd.incident_number = hw.incident_number
                           GROUP BY hw.incident_number
                       ),0) AS                                                         
          num_internal_escalations
                     ,  ( SELECT COUNT(hw.work_log_type) total_touches        
                            FROM aradmin.hpd_worklog@dtvremp1.cisco.com hw      
                           WHERE hw.incident_number = hd.incident_number       
                           GROUP BY hw.incident_number         
                       ) AS                                                                 
          num_touches            
          -- Calculated Times           
          --  NOTE: the cisco remedy system uses A_CSC_HPD_HELPDESKSTATUSLOG
          --        which allows off_clock calulation. DTV does not therefore this is left null
                    --, (SELECT MIN (off_clock_time)/60          
                    --    FROM  rdr_ticket rdr          
                    --   WHERE rdr.incident_number = hd.incident_number       
                    --   GROUP BY rdr.incident_number         
                    --) AS             
                    --off_clock_time_mins 
          -- 
          --  NOTE: the CISCO REMEDY system uses A_CSC_HPD_HELPDESKSTATUSLOG
          --  The following metrics are calculated in RDR_TICKET ETL
          --  for Cisco Remedy, but not for DTV Remedy
          --  the folowing are the requirements found in the document     
          --  "Remedy Reporting ETL Software Design Specification" in StarTeam
          --      
          --    time_to_notify          initial_notification_date - reported_date
          --    time_to_isolate         isolation_date - reported_date
          --    time_to_resolve         lASt_resolved_date - reported_date - off_clock_time
          --    time_to_close           close_date - reported_date
          --    time_to_analyse         in_progress_date - reported_date
          --
          --  The following metrrics are shown with: 
          --    the name of the metric
          --    the new DTV calculation (because they are not found not in RDR_TICKET for DTV)
          --    the original Cisco Remedy (using RDR_TICKET) AS reference 
          --
          -- -----------------------------------------------------------------------
          -- time_to_notify        initial_notification_date - reported_date
          , (metric_utilities.convert_to_date(hd.initial_notification_date) - metric_utilities.convert_to_date(hd.reported_date))*(24*60)
          alarm_to_notify_mins
                --(SELECT MIN (time_to_notify)/60          
                --        FROM rdr_ticket rdr          
                --       WHERE rdr.incident_number = hd.incident_number       
                --       GROUP BY rdr.incident_number         
                -- ) AS             
                --alarm_to_notify_mins
          -- -----------------------------------------------------------------------
          -- time_to_isolate        isolation_date - reported_date
         , (metric_utilities.convert_to_date(hd.isolation_date) - metric_utilities.convert_to_date(hd.reported_date))*(24*60)
          alarm_to_isolate_mins
                -- (SELECT MIN (time_to_isolate)/60          
                --        FROM rdr_ticket rdr          
                --       WHERE rdr.incident_number = hd.incident_number       
                --       GROUP BY rdr.incident_number         
                -- ) AS             
                -- alarm_to_isolate_mins           
          -- -----------------------------------------------------------------------
          -- time_to_resolve lASt_resolved_date - reported_date (no off_clock_time available)
          ,       CASE
                    WHEN hd.lASt_resolved_date IS NOT NULL AND 
                         hd.reported_date IS NOT NULL AND 
                         hd.lASt_resolved_date > hd.reported_date AND 
                         hd.status IN (4,5) THEN 
                    (metric_utilities.convert_to_date(hd.lASt_resolved_date) - metric_utilities.convert_to_date(hd.reported_date))*(24*60)
                    WHEN hd.lASt_resolved_date IS NULL AND 
                         hd.closed_date IS NOT NULL AND 
                         hd.reported_date IS NOT NULL AND 
                         hd.closed_date > hd.reported_date AND 
                         hd.status IN (4,5) THEN
                    (metric_utilities.convert_to_date(hd.closed_date) - metric_utilities.convert_to_date(hd.reported_date))*(24*60)
                    END AS
          alarm_to_resolve_mins
                -- (SELECT MIN (time_to_resolve)/60          
                --    FROM rdr_ticket rdr          
                --   WHERE rdr.incident_number = hd.incident_number       
                --   GROUP BY rdr.incident_number         
                -- ) AS             
                -- alarm_to_resolve_mins           
          -- -----------------------------------------------------------------------
          -- time_to_close        close_date - reported_date
          , (metric_utilities.convert_to_date(hd.closed_date) - metric_utilities.convert_to_date(hd.reported_date))*(24*60) 
          alarm_to_close_mins
                --(SELECT MIN (time_to_close)/60          
                --    FROM rdr_ticket rdr          
                --   WHERE rdr.incident_number = hd.incident_number       
                --   GROUP BY rdr.incident_number         
                --) AS             
                --alarm_to_close_mins           
          -- -----------------------------------------------------------------------
          -- time_to_analyse :=  in_progress_date - reported_date
          -- NOTE since time_to_analyse depends on in_progress_date calculated in this 
          -- same SELECT statement 
          -- time_to_analyse hAS to be set in cursor below
                --(SELECT MIN (time_to_analyse)/60         
                --    FROM rdr_ticket rdr          
                --   WHERE rdr.incident_number = hd.incident_number       
                --   GROUP BY rdr.incident_number         
                --) AS             
                --alarm_to_analyze_mins           
          -- -----------------------------------------------------------------------
          -- time_to_create        submit_date - reported_date
          , (metric_utilities.convert_to_date(hd.submit_date) - metric_utilities.convert_to_date(hd.reported_date))*(24*60) 
          alarm_to_create_mins           
                -- (SELECT MIN (time_to_create)/60          
                --        FROM rdr_ticket rdr          
                --       WHERE rdr.incident_number = hd.incident_number       
                --       GROUP BY rdr.incident_number         
                -- ) AS             
                -- alarm_to_create_mins           
          --  Calculated in get_im_stage_data         
          , (hd.Closed_Date - hd.Submit_Date) / (60 * 60)           AS Tkt_Create_To_Closed_Hrs     
          , (hd.Isolation_Date - hd.Submit_Date) / (60)             AS Tkt_Create_To_Isolate_Mins     
          , (hd.Initial_Notification_Date - hd.Submit_Date) / (60)  AS Tkt_Create_To_Notify_Mins     
          -- tkt_create_to_resolved  
          ,       CASE  WHEN  hd.lASt_resolved_date IS NOT NULL 
                           AND hd.submit_date IS NOT NULL
                           AND hd.lASt_resolved_date > hd.submit_date   
                           AND hd.status in (4,5) THEN 
                               (metric_utilities.convert_to_date(hd.lASt_resolved_date) - metric_utilities.convert_to_date(hd.submit_date))*(24)
                          when hd.lASt_resolved_date IS NULL 
                           AND hd.closed_date IS NOT NULL 
                           AND hd.submit_date IS NOT NULL
                           AND hd.closed_date > hd.submit_date   
                           AND hd.status in (4,5) THEN
                              (metric_utilities.convert_to_date(hd.closed_date) - metric_utilities.convert_to_date(hd.submit_date))*(24)
                  END AS
          tkt_create_to_resolved_hrs
          -- tkt_isolate_to_resolved  
          ,       CASE WHEN   hd.lASt_resolved_date IS NOT NULL
                             AND hd.isolation_date IS NOT NULL
                             AND hd.lASt_resolved_date > hd.isolation_date  
                             AND hd.status in (4,5) then
                               (metric_utilities.convert_to_date(hd.lASt_resolved_date) - metric_utilities.convert_to_date(hd.isolation_date))*(24*60)
                          when hd.lASt_resolved_date is null 
                             AND hd.closed_date IS NOT NULL 
                             AND hd.isolation_date IS NOT NULL
                             AND hd.closed_date > hd.isolation_date   
                             AND hd.status in (4,5) then
                               (metric_utilities.convert_to_date(hd.closed_date) - metric_utilities.convert_to_date(hd.isolation_date))*(24*60)
                  END AS 
          tkt_isolate_to_resolved_mins
          -- tkt_closed_to_resolved  
          ,       CASE WHEN   hd.lASt_resolved_date IS NOT NULL 
                          AND hd.closed_date IS NOT NULL
                          AND hd.closed_date > hd.lASt_resolved_date  
                          AND hd.status in (4,5) 
                       THEN  (metric_utilities.convert_to_date(hd.closed_date) - metric_utilities.convert_to_date(hd.lASt_resolved_date))*(24*60)
                  END AS
          tkt_resolved_to_closed_mins     
          , 'DTVREMP1.CISCO.COM'
          -- Set inc_mttcreate in cursor below
                --, CASE 
                --   WHEN (SELECT MIN (time_to_create)/60          
                --          FROM rdr_ticket rdr          
                --         WHERE rdr.incident_number = hd.incident_number       
                --         GROUP BY rdr.incident_number) < 100   
                --     AND (SELECT MIN (time_to_create)/60          
                --          FROM rdr_ticket rdr          
                --         WHERE rdr.incident_number = hd.incident_number       
                --         GROUP BY rdr.incident_number) > 0
                --     AND  hd.submitter = 'WEBSERVICES' THEN 'Y'
                --   ELSE 'N'
                --   END 
                --AS inc_mttcreate
        , REPLACE(REPLACE(hd.description,chr(10),chr(32)),chr(9),chr(32))
        , DECODE(hd.submitter, 'WEBSERVICES', 'Y', 'N') 
           AS system_created
        , v_lASt_updated
        -- REPORTED_NETWORK_CONDITION        
        --   ENUMID   REMEDY VALUE              PRIORITY 
        --   0        Network Event             3
        --   1        Degraded Service          2
        --   2        Outage                    1
         , reported_network_condition
         , DECODE( notification_required, 0, 'N', 1, 'Y')  AS notification_required                                         
        FROM aradmin.hpd_help_desk@dtvremp1.cisco.com hd
        WHERE company not in  ('ROS-LAB', 'Cisco ROS')
          AND hd.incident_number in (SELECT incident_number FROM im_stage_data_ids_to_pull_dtv)
       ORDER BY hd.incident_number;

       COMMIT;
       
          -- ----------------------------------------------------------------------------------
          -- UPDATE PULL WITH CALCS
          -- ----------------------------------------------------------------------------------
            -- ---------------------------------------------------------------------------    
            -- autonotify flag
            -- -----------------------------------------------------------------------------
            SELECT i.incident_number, NVL(COUNT(cASe WHEN t.tASkname = 'Initial Notification - Manual' THEN 1 END),0) AS cnt
                    BULK COLLECT INTO 
                        my_ticket_list_an,
                        my_tASk_count_list
                    FROM     im_stage_data_dtv i
                           , aradmin.tms_tASk@dtvremp1.cisco.com t
                    WHERE i.incident_number = t.rootrequestid(+)
                      AND submit_date > to_date('11/12/2008', 'dd/mm/yyyy')   
                    GROUP BY i.incident_number;

            FOR i IN my_ticket_list_an.FIRST .. my_ticket_list_an.LAST
                  LOOP
                    IF my_tASk_count_list(i) > 0 THEN
                      UPDATE im_stage_data_dtv
                      SET auto_notify_flag       = 'N'
                      WHERE my_ticket_list_an(i) = incident_number;
                    ELSE
                      UPDATE im_stage_data_dtv
                      SET auto_notify_flag       = 'Y'
                      WHERE my_ticket_list_an(i) = incident_number;
                    END IF;
                  END LOOP;

            -- ---------------------------------------------------------------------------    
            -- all others 
            -- -----------------------------------------------------------------------------
                SELECT
                    -- 0. ticket_list
                    im.incident_number
                    -- 1. company_id
                    ,im.company
                    ,auto_notify_flag
                    -- 2. auto_notify_flag
                    --                , (SELECT NVL(COUNT(cASe WHEN t.tASkname = 'Initial Notification - Manual' THEN 1 END),0)
                    --                    FROM aradmin.tms_tASk t
                    --                    WHERE im.incident_number = t.rootrequestid(+)  
                    --                    group by im.incident_number)
                    --                this_auto_notify_flag
                    -- 3. alarm_to_analyze
                    ,im.in_progress_date
                    ,im.reported_date 
                    -- 4. inc_mttc
                    -- 6. met_mttc sla
                    ,im.alarm_to_create_mins
                    -- 5. inc_mttn
                    -- 7. mttn_sla_met
                    ,im.tkt_create_to_notify_mins
                    ,im.submitter
                     -- 8-11. met_Px_SLA                        
                    ,im.priority
                    ,im.reported_network_condition
                    ,im.tkt_create_to_resolved_hrs
                BULK COLLECT INTO
                    -- 0. ticket_list
                     my_ticket_list
                    -- 1. company_id
                    ,my_company_list
                    -- 2. auto_notify_flag
                    ,my_auto_notify_list
                    -- 3. alarm_to_analyze
                    ,my_in_progress_date_list
                    ,my_reported_date_list
                    -- 4. inc_mttc
                    -- 6. met_mttc sla
                    ,my_alarm_to_crt_mins_list
                    -- 5. inc_mttn
                    -- 7. mttn_sla_met
                    ,my_tkt_create_to_not_mins_list
                    ,my_submitter_list
                     -- 8-11. met_Px_SLA                        
                    ,my_priority_list
                    ,my_reptd_network_cond_list
                    ,my_tkt_create_to_res_hrs_list
                FROM im_stage_data_dtv im
                WHERE 1=1 
                      and submit_date > to_date('11/12/2008', 'dd/mm/yyyy'); 
                      -- and submit_date > to_date('01/06/2008', 'dd/mm/yyyy') 
                      -- and submit_date <= to_date('12/12/2008', 'dd/mm/yyyy'); 
                    
            FOR i IN my_ticket_list.FIRST .. my_ticket_list.LAST LOOP

                    -- 1. company_id
                    v_company_id := null;
                    -- 2. auto_notify_flag
                    v_auto_notify_flag := null; 
                    -- 3. alarm_to_analyze
                    v_alarm_to_analyze_mins := null;
                    -- 4. inc_mttc
                    v_inc_mttcreate := null;
                    -- 6. met_mttc_sla
                    v_mttcreate_sla_met:= null;
                    -- 5. met_mttn
                    v_inc_mttn := null;
                    -- 7. met_mttn_sla
                    v_mttn_sla_met:= null;
                    -- 8-11. met_Px_SLA
                    v_mttr_p1_sla_met := null;
                    v_mttr_p2_sla_met := null;
                    v_mttr_p3_sla_met := null;
                    v_mttr_p4_sla_met := null;

                -- 1. company id
                CASE 
                    WHEN my_company_list(i) = 'DIRECTV-NGBN'
                            THEN v_company_id := 'CPY000000001337';
                    WHEN my_company_list(i) = 'DIRECTV-BROADBAND'
                            THEN v_company_id := 'CPY000000001338';
                    WHEN my_company_list(i) = 'DIRECTV-CONUS'
                            THEN v_company_id := 'CPY000000001339';
                    WHEN my_company_list(i) = 'DIRECTV'
                            THEN v_company_id := '';
                END CASE;

                -- 2. autonotify 
                v_auto_notify_flag :=  my_auto_notify_list(i);
                       
                -- 3. alarm_to_analyse_mins        in_progress_date - reported_date
                v_alarm_to_analyze_mins := (my_in_progress_date_list(i) - my_reported_date_list(i))*24*60; 
                IF v_alarm_to_analyze_mins < 0 THEN
                    v_alarm_to_analyze_mins := null;
                END IF; 
                  
                -- 4. inc_mttcreate 
                IF my_alarm_to_crt_mins_list(i) >= 0 
                   AND my_alarm_to_crt_mins_list(i) < 100
                   AND my_submitter_list(i) = 'WEBSERVICES' 
                THEN v_inc_mttcreate:= 'Y';
                ELSE v_inc_mttcreate:= 'N';
                END IF;
                                 
                -- 5. inc_mttn
                IF  my_alarm_to_crt_mins_list(i) >= 0     AND
                    my_alarm_to_crt_mins_list(i) < 100   AND
                    v_auto_notify_flag = 'N'
                THEN 
                    v_inc_mttn := 'Y';
                ELSE 
                    v_inc_mttn := 'N';
                END IF;
                 
                -- 6. MTTC determine if this record met MTTC SLA 
                IF  my_alarm_to_crt_mins_list(i)  <= 7
                 AND  v_inc_mttcreate  = 'Y' THEN
                  v_mttcreate_sla_met := 'Y';
                ELSE
                  v_mttcreate_sla_met := 'N';
                END IF;

                -- 7. met_mttn_sla 
                IF  my_tkt_create_to_not_mins_list(i)  <= 15 AND
                    v_inc_mttn = 'Y' THEN 
                  v_mttn_sla_met      := 'Y';
                ELSE
                  v_mttn_sla_met      := 'N';
                END IF;
                -- 8 Determine P1 MTTR SLA
                -- use the reported_network_condition if available otherwise use priority
                -- determine if null    
                IF my_reptd_network_cond_list(i) IS NULL
                    then reported_net_cond_is_blank := TRUE;
                END IF;
                -- ---------------------------------------------
                -- P1 met MTTR SLA 
                IF NOT (reported_net_cond_is_blank)
                  AND my_reptd_network_cond_list(i) = 2 
                  AND my_tkt_create_to_res_hrs_list(i) <= 4 THEN
                  v_mttr_p1_sla_met  := 'Y';
                ELSE
                   IF NOT (reported_net_cond_is_blank)
                      AND my_reptd_network_cond_list(i)= 2 THEN
                     v_mttr_p1_sla_met  := 'N';
                   ELSE
                     v_mttr_p1_sla_met  := NULL;
                   END IF;
                END IF;
                -- --------------------------------------------
                IF reported_net_cond_is_blank
                  AND my_priority_list(i) = 1 
                  AND my_tkt_create_to_res_hrs_list(i) <= 4 THEN
                  v_mttr_p1_sla_met  := 'Y';
                ELSE
                   IF reported_net_cond_is_blank
                      AND my_priority_list(i) = 1 THEN
                     v_mttr_p1_sla_met  := 'N';
                   ELSE
                     v_mttr_p1_sla_met  := NULL;
                   END IF;
                END IF;
                -- ------------------------------------------------------------
                -- 9 Determine P2 MTTR SLA
                -- use the reported_network_condition if available otherwise use priority
                -- determine if null    
                -- P2 met MTTR SLA 
                IF NOT (reported_net_cond_is_blank)
                  AND my_reptd_network_cond_list(i) = 1 
                  AND my_tkt_create_to_res_hrs_list(i) <= 4 THEN
                  v_mttr_p2_sla_met  := 'Y';
                ELSE
                   IF NOT (reported_net_cond_is_blank)
                      AND my_reptd_network_cond_list(i)= 1 THEN
                     v_mttr_p2_sla_met  := 'N';
                   ELSE
                     v_mttr_p2_sla_met  := NULL;
                   END IF;
                END IF;
                -- --------------------------------------------
                IF reported_net_cond_is_blank
                  AND my_priority_list(i) = 2 
                  AND my_tkt_create_to_res_hrs_list(i) <= 4 THEN
                  v_mttr_p2_sla_met  := 'Y';
                ELSE
                   IF reported_net_cond_is_blank
                      AND my_priority_list(i) = 2 THEN
                     v_mttr_p2_sla_met  := 'N';
                   ELSE
                     v_mttr_p2_sla_met  := NULL;
                   END IF;
                END IF;
 
                -- 10 Determine P3 MTTR SLA
                -- use the reported_network_condition if available otherwise use priority
                -- determine if null    
                -- P2 met MTTR SLA 
                IF NOT (reported_net_cond_is_blank)
                  AND my_reptd_network_cond_list(i) = 0 
                  AND my_tkt_create_to_res_hrs_list(i) <= 24 THEN
                  v_mttr_p3_sla_met  := 'Y';
                ELSE
                   IF NOT (reported_net_cond_is_blank)
                      AND my_reptd_network_cond_list(i)= 0 THEN
                     v_mttr_p3_sla_met  := 'N';
                   ELSE
                     v_mttr_p3_sla_met  := NULL;
                   END IF;
                END IF;
                -- --------------------------------------------
                IF reported_net_cond_is_blank
                  AND my_priority_list(i) = 3 
                  AND my_tkt_create_to_res_hrs_list(i) <= 24 THEN
                  v_mttr_p3_sla_met  := 'Y';
                ELSE
                   IF reported_net_cond_is_blank
                      AND my_priority_list(i) = 3 THEN
                     v_mttr_p3_sla_met  := 'N';
                   ELSE
                     v_mttr_p3_sla_met  := NULL;
                   END IF;
                END IF;
                        
--                -- 11. P4 determine if this record met MTTR SLA 
--                IF my_tkt_create_to_res_hrs_list(i)  <= 120
--                  AND my_reported_network_condition_list(i)  = 4 THEN
--                  v_mttr_p4_sla_met  := 'Y';
--                ELSE
--                   IF my_priority_list(i)  = 4 THEN
--                     v_mttr_p4_sla_met  := 'N';
--                   ELSE
--                     v_mttr_p4_sla_met  := NULL;
--                   END IF;
--                END IF;
              
              BEGIN  
                
                UPDATE im_stage_data_dtv 
                   SET 
                       -- 1. company_id
                       companyid                =  v_company_id
                       -- 2. auto_notify_flag
                      ,auto_notify_flag         =  v_auto_notify_flag
                       -- 3. alarm_to_analyze
                      ,alarm_to_analyze_mins    =  v_alarm_to_analyze_mins
                       -- 4. inc_mttc
                      ,inc_mttcreate            =  v_inc_mttcreate
                       -- 6. met_mttc_sla
                      ,mttcreate_sla_met        =  v_mttcreate_sla_met
                       -- 5. inc_mttc
                      ,inc_mttn                 =  v_inc_mttn
                       -- 7. met_mttn_sla
                      ,mttn_sla_met             =  v_mttn_sla_met
                       -- 8-11. met_Px_sla
                      ,mttr_p1_sla_met          =  v_mttr_p1_sla_met
                      ,mttr_p2_sla_met          =  v_mttr_p2_sla_met
                      ,mttr_p3_sla_met          =  v_mttr_p3_sla_met
                      ,mttr_p4_sla_met          =  v_mttr_p4_sla_met
                    WHERE incident_number = my_ticket_list(i);
                        
                COMMIT; 
             
                EXCEPTION
                    WHEN others THEN
                       v_msg := SQLERRM;
                       o_im_status := 'FAILURE';     
                       metric_utilities.log_writer('ALL' ,'IM_GET_DATA ERROR - update stage_dtv', SYSDATE, v_msg);    
                END;           
            END LOOP;
     o_im_status := 'SUCCESS';   
       EXCEPTION
          WHEN others THEN
             v_msg := SQLERRM;
             o_im_status := 'FAILURE';     
             metric_utilities.log_writer('ALL' ,'IM_GET_DATA_DTV ERROR', SYSDATE, v_msg);         
       END;                
     
   
   PROCEDURE im_update_history_dtv(o_im_status OUT VARCHAR) IS 
      v_msg VARCHAR2(1000);   
   BEGIN   
      --To prevent duplicate rows we delete any dups that might occur
      DELETE FROM im_history_data_dtv 
       WHERE incident_number IN 
         (SELECT incident_number 
            FROM im_stage_data_dtv);
      COMMIT;
      ---------------------------------------------------------------

      --Update the im_history table
      INSERT INTO im_history_data_dtv
            (
              incident_number
            , alarm_identifier
            , alarm_type
            , ASsigned_group
            , ASsigned_support_company
            , ASsigned_support_organization
            , ASsignee
            , ASsignee_groups
            , city
            , closure_product_category_tier1
            , closure_product_category_tier2
            , closure_product_category_tier3
            , closure_product_name
            , company
            , companyid
            , correlated_ci
            , correlated_id
            , country
            , country_code
            , created_by
            , effort_time_spent_minutes
            , first_name
            , generic_categorization_tier_1
            , generic_categorization_tier_2
            , generic_categorization_tier_3
            , impact
            , impact_rating
            , lASt_modified_by
            , lASt_name
            , lookupkeyword
            , managed
            , manufacturer
            , mapped_severity
            , mom_identifier
            , mom_type
            , organization
            , owner
            , owner_group
            , owner_group_id
            , owner_support_company
            , owner_support_organization
            , partner
            , priority
            , product_categorization_tier_1
            , product_categorization_tier_2
            , product_categorization_tier_3
            , product_model_version
            , product_name
            , recurrence
            , region
            , related_alarm_code
            , reported_source
            , reportedci
            , resolution_category
            , resolution_category_tier_2
            , resolution_category_tier_3
            , service_type
            , severity
            , short_description
            , site
            , site_group
            , site_id
            , state_province
            , status
            , status_reASon
            , submitter
            , total_escalation_level
            , total_ola_acknowledgeesc_level
            , total_ola_resolution_esc_level
            , total_time_spent
            , total_transfers
            , urgency
            -- Atomic Dates
            , closed_date
            , estimated_resolution_date
            , initial_notification_date
            , isolation_date
            , lASt__ASsigned_date
            , lASt_ackowledged_date
            , lASt_modified_date
            , lASt_occurence
            , lASt_resolved_date
            , reported_date
            , responded_date
            , submit_date
            -- Calculated Dates
            , in_progress_date
            , day_closed
            , day_opened
            , month_closed
            , month_opened
            , week_closed
            , week_opened
            -- Calculated Flags
            , auto_notify_flag
            , auto_tkt_flag
            , closed_AS_duplicate_flag
            , closed_AS_ros_infrAStr_flag
            , closed_AS_merged_flag
            , sched_maint_flag
            -- Calculated Counts 
            , num_cust_escalations
            , num_customer_updates
            , num_entitlement_wil
            , num_external_escalations
            , num_internal_escalations
            , num_touches            
            , off_clock_time_mins                                                               
            , alarm_to_notify_mins           
            , alarm_to_isolate_mins           
            , alarm_to_resolve_mins           
            , alarm_to_close_mins           
            , alarm_to_analyze_mins           
            , alarm_to_create_mins           
            , Tkt_Create_To_Closed_Hrs     
            , Tkt_Create_To_Isolate_Mins     
            , Tkt_Create_To_Notify_Mins     
            , Tkt_Create_To_Resolved_Hrs     
            , Tkt_Isolate_To_Resolved_Mins     
            , Tkt_Resolved_To_Closed_Mins     
            , data_source
            , inc_mttcreate
            , inc_mttn
            , description
            , system_created
            , mttcreate_sla_met
            , mttn_sla_met
            , mttr_p1_sla_met
            , mttr_p2_sla_met
            , mttr_p3_sla_met
            , mttr_p4_sla_met
            , lASt_updated
            , reported_network_condition 
            , notification_required
             )
        SELECT 
              incident_number
            , alarm_identifier
            , alarm_type
            , ASsigned_group
            , ASsigned_support_company
            , ASsigned_support_organization
            , ASsignee
            , ASsignee_groups
            , city
            , closure_product_category_tier1
            , closure_product_category_tier2
            , closure_product_category_tier3
            , closure_product_name
            , company
            , companyid
            , correlated_ci
            , correlated_id
            , country
            , country_code
            , created_by
            , effort_time_spent_minutes
            , first_name
            , generic_categorization_tier_1
            , generic_categorization_tier_2
            , generic_categorization_tier_3
            , impact
            , impact_rating
            , lASt_modified_by
            , lASt_name
            , lookupkeyword
            , managed
            , manufacturer
            , mapped_severity
            , mom_identifier
            , mom_type
            , organization
            , owner
            , owner_group
            , owner_group_id
            , owner_support_company
            , owner_support_organization
            , partner
            , priority
            , product_categorization_tier_1
            , product_categorization_tier_2
            , product_categorization_tier_3
            , product_model_version
            , product_name
            , recurrence
            , region
            , related_alarm_code
            , reported_source
            , reportedci
            , resolution_category
            , resolution_category_tier_2
            , resolution_category_tier_3
            , service_type
            , severity
            , short_description
            , site
            , site_group
            , site_id
            , state_province
            , status
            , status_reASon
            , submitter
            , total_escalation_level
            , total_ola_acknowledgeesc_level
            , total_ola_resolution_esc_level
            , total_time_spent
            , total_transfers
            , urgency
            -- Atomic Dates
            , closed_date
            , estimated_resolution_date
            , initial_notification_date
            , isolation_date
            , lASt__ASsigned_date
            , lASt_ackowledged_date
            , lASt_modified_date
            , lASt_occurence
            , lASt_resolved_date
            , reported_date
            , responded_date
            , submit_date
            -- Calculated Dates
            , in_progress_date
            , day_closed
            , day_opened
            , month_closed
            , month_opened
            , week_closed
            , week_opened
            -- Calculated Flags
            , auto_notify_flag
            , auto_tkt_flag
            , closed_AS_duplicate_flag
            , closed_AS_ros_infrAStr_flag
            , closed_AS_merged_flag
            , sched_maint_flag
            -- Calculated Counts 
            , num_cust_escalations
            , num_customer_updates
            , num_entitlement_wil
            , num_external_escalations
            , num_internal_escalations
            , num_touches            
            , off_clock_time_mins                                                               
            , alarm_to_notify_mins           
            , alarm_to_isolate_mins           
            , alarm_to_resolve_mins           
            , alarm_to_close_mins           
            , alarm_to_analyze_mins           
            , alarm_to_create_mins           
            , Tkt_Create_To_Closed_Hrs     
            , Tkt_Create_To_Isolate_Mins     
            , Tkt_Create_To_Notify_Mins     
            , Tkt_Create_To_Resolved_Hrs     
            , Tkt_Isolate_To_Resolved_Mins     
            , Tkt_Resolved_To_Closed_Mins     
            , data_source
            , inc_mttcreate
            , inc_mttn
            , description
            , system_created
            , mttcreate_sla_met
            , mttn_sla_met
            , mttr_p1_sla_met
            , mttr_p2_sla_met
            , mttr_p3_sla_met
            , mttr_p4_sla_met            
            , lASt_updated
            , reported_network_condition 
            , notification_required
        FROM im_stage_data_dtv;
      COMMIT;
        
      o_im_status := 'SUCCESS';
         
   EXCEPTION
      WHEN others THEN
         v_msg := SQLERRM;
         o_im_status := 'FAILURE';    
         metric_utilities.log_writer('ALL' ,'IM_DTV_UPDATE_HISTORY ERROR', SYSDATE, v_msg);    
   
   END im_update_history_dtv;
 
   --Rolls up Incident Managment data for reporting       
   PROCEDURE im_rollup_data_dtv (i_start_date  IN DATE,
                            i_stop_date   IN DATE,
                            i_period_id   IN NUMBER,
                            i_period_type IN VARCHAR,
                            i_period_name IN VARCHAR,
                            o_im_status   OUT VARCHAR) IS


      v_msg    VARCHAR2(1000);  
      v_status VARCHAR2(20); 
   BEGIN
        -- this is an external procedure
        im_kpi_ru_proc_dtv (i_start_date ,i_stop_date,i_period_id ,i_period_type,i_period_name ,o_im_status); 
            
        IF i_period_type = 'DAY' THEN
            -- this is an external procedure
            im_backlog_buckets_proc_dtv (i_start_date,i_stop_date,i_period_id ,i_period_type,i_period_name,o_im_status);
            -- this is an external procedure
            im_mttr_buckets_proc_dtv   (i_start_date,i_stop_date,i_period_id ,i_period_type,i_period_name,o_im_status);
        END IF;

   o_im_status := 'SUCCESS';    
   EXCEPTION
      WHEN others THEN
         v_msg := SQLERRM;
         o_im_status := 'FAILURE';    
         metric_utilities.log_writer('ALL', 'IM_ROLLUP_DATA ERROR', SYSDATE, v_msg);         
   END im_rollup_data_dtv; 

-- ----------------------------------------------------------------------------------------------
-- PROBLEM MANAGEMENT
-- ----------------------------------------------------------------------------------------------
   --Gets stage data FROM Problem Managment bASe tables   
PROCEDURE pm_get_data_dtv (i_start_date  IN DATE
                         ,i_stop_date   IN DATE
                         ,o_pm_status   OUT VARCHAR) IS
   -- ---------------------------------------------------------------
   -- This procedure finds ids of pbi tickets AS well AS work_info and solution 
   -- tickets that have been updated since the lASt pull
      
   v_msg  VARCHAR2(1000);                          
         
   BEGIN
   -- Problem tickets
   -- ---------------------------------------------------------------
   --    4. delete pbi record ids and records FROM lASt pull 
        METRIC_UTILITIES.TRUNC_TABLE('pm_ids_to_pull');
        METRIC_UTILITIES.TRUNC_TABLE('pm_stage_data');
        COMMIT;
   
   -- ---------------------------------------------------------------
   --    5. get pbi ids to pull this time
       INSERT INTO pm_ids_to_pull(pbi_id)
        SELECT ppi.problem_investigation_id
        FROM aradmin.pbm_problem_investigation@DTVREMP1.CISCO.COM ppi
        WHERE metric_utilities.convert_to_date(lASt_modified_date) > i_start_date
        UNION
        SELECT piw.problem_investigation_id
        FROM aradmin.pbm_investigation_worklog@DTVREMP1.CISCO.COM piw
        WHERE metric_utilities.convert_to_date(lASt_modified_date) > i_start_date
        UNION
        SELECT psda.request_id01
        FROM aradmin.pbm_solution_databASe@DTVREMP1.CISCO.COM psd,
             aradmin.pbm_solution_db_ASsociations@DTVREMP1.CISCO.COM psda
        WHERE psd.solution_databASe_id = psda.request_id02
          AND  SUBSTR(psda.request_id01,1,3) = 'PBI'
          AND  metric_utilities.convert_to_date(psd.lASt_modified_date) > i_start_date;
        COMMIT;
   -- ---------------------------------------------------------------
   --    6. insert into pm_stage_data
     INSERT INTO pm_stage_data (
            -- atomic fields (1-1 mapping)
            pbi_id,
            submit_date,
            lASt_modified_date,
            status,
            priority,
            status_reASon,
            company,
            site,
            ASsigned_group,
            ASsignee,
            categorization_tier1,
            categorization_tier2,
            categorization_tier3,
            product_categorization_tier1,
            product_categorization_tier2,
            product_categorization_tier3,
            -- calculated dates
            lASt_touch_date,
            closed_date,
            resolved_date,
            -- calculated times
            ttr_seconds,
            ttc_seconds,
            mtttouch_seconds,
            -- calculated flags
            closed_AS_duplicate_flag,
            pbi_created_by_inc_flag,
            pbi_created_by_crq_flag,
            pbi_created_crq_flag,
            pbi_created_sdb_flag,
            -- calculated counts
            num_touches,
            num_escalations,
            num_crq_ASsociations,
            num_inc_ASsociations,
            num_sdb_ASsociations,
            num_other_ASsociations,
            data_source
            )
       SELECT  
                -- atomic fields (1-1 mapping)
                DISTINCT(ppi.problem_investigation_id),
                metric_utilities.convert_to_date(ppi.submit_date) AS submit_date,
                metric_utilities.convert_to_date(ppi.lASt_modified_date) AS lASt_modified_date,
                DECODE (ppi.investigation_status,
                            0,    'Draft',
                            1,    'Under Review',
                            2,    'Request For Authorization',
                            3,    'ASsigned',
                            4,    'Under Investigation',
                            5,    'Pending',
                            6,    'Completed',
                            7,    'Rejected',
                            8,    'Closed',
                            9,    'Cancelled') AS status,
                ppi.priority,
                DECODE (ppi.invesitgation_status_reASon,
                            1000,    'Known Error',
                            2000,    'Unresolveable',
                            3000,    'Solution DatabASe',
                            4000,    'Enhancement Request',
                            5000,    'Duplicate Investigation',
                            'None' ) AS status_reASon,
                ppi.company,
                ppi.site,
                ppi.ASsigned_group,
                NVL(ppi.ASsignee, 'Not ASsigned'),
                NVL(ppi.categorization_tier_1,'No User Value'),
                NVL(ppi.categorization_tier_2,'No User Value'),
                NVL(ppi.categorization_tier_3,'No User Value'),
                NVL(ppi.product_categorization_tier_1,'No User Value'),
                NVL(ppi.product_categorization_tier_2,'No User Value'),
                NVL(ppi.product_categorization_tier_3,'No User Value'),
                -- calculated dates
                calc_mmttouch.lASt_touch_date,
                calc_ttc.closed_date,
                calc_ttr.resolved_date,
                -- calculated times
                NVL(calc_ttr.ttr_seconds,0),
                NVL(calc_ttc.ttc_seconds,0),
                NVL(calc_mmttouch.mtttouch,0),
                -- calculated flags
                        CASE WHEN ppi.investigation_status = 8 AND 
                                  ppi.invesitgation_status_reASon = 5000 THEN 
                                  'Y' ELSE 
                                  'N' 
                        END AS 
                closed_AS_duplicate_flag,
                'N' pbi_created_by_inc_flag,  
                'N' pbi_created_by_crq_flag,
                'N' pbi_created_crq_flag,
                'N' pbi_created_sdb_flag,
                -- calculated counts
                NVL(count_touches.num_touches,0),
                NVL(count_escalations.num_escalations,0),
                NVL(count_ASsociations.num_CRQ_ASsociations,0),
                NVL(count_ASsociations.num_INC_ASsociations,0), 
                NVL(count_ASsociations.num_SDB_ASsociations,0),
                NVL(count_ASsociations.num_other_ASsociations,0),
                'DTV'
         FROM aradmin.pbm_problem_investigation@DTVREMP1.CISCO.COM ppi,
              aradmin.pbm_investigation_ASsociations@DTVREMP1.CISCO.COM pia,
              -- calc_mmttouch
              (SELECT   piw.problem_investigation_id pbi_id, metric_utilities.convert_to_date(MAX(piw.submit_date)) lASt_touch_date,
                        metric_utilities.time_diff(metric_utilities.convert_to_date(MIN(piw.submit_date)), metric_utilities.convert_to_date(MAX(piw.submit_date))) / (COUNT(work_log_id)-1) mtttouch                 
                 FROM   aradmin.pbm_investigation_worklog@DTVREMP1.CISCO.COM piw
                 HAVING (COUNT(work_log_id)-1) > 0
                 GROUP BY piw.problem_investigation_id) calc_mmttouch,
              -- calc_ttc  
              (SELECT   ppi.problem_investigation_id pbi_id, metric_utilities.convert_to_date(h.t8) closed_date,
                        nvl(metric_utilities.time_diff( metric_utilities.convert_to_date(ppi.submit_date), metric_utilities.convert_to_date(h.t8)),0) ttc_seconds
                 FROM   aradmin.pbm_problem_investigation@DTVREMP1.CISCO.COM ppi,
                        aradmin.h1121@DTVREMP1.CISCO.COM h
                WHERE   ppi.sys_problem_investigation_id = h.entryid) calc_ttc,
                -- calc_ttr
              (SELECT   ppi.problem_investigation_id AS pbi_id, metric_utilities.convert_to_date(h.t6) resolved_date,
                        nvl(metric_utilities.time_diff( metric_utilities.convert_to_date(ppi.submit_date), metric_utilities.convert_to_date(h.t6)),0) ttr_seconds
                 FROM   aradmin.pbm_problem_investigation@DTVREMP1.CISCO.COM ppi,
                        aradmin.h1121@DTVREMP1.CISCO.COM h
                WHERE   ppi.sys_problem_investigation_id = h.entryid) calc_ttr,
               -- count_touches
               (SELECT  ppi.problem_investigation_id AS pbi_id, count(piw.problem_investigation_id) AS num_touches
                FROM    aradmin.pbm_problem_investigation@DTVREMP1.CISCO.COM ppi,
                        aradmin.pbm_investigation_worklog@DTVREMP1.CISCO.COM piw
                WHERE   ppi.problem_investigation_id = piw.problem_investigation_id
               GROUP BY ppi.problem_investigation_id) count_touches,
               -- count_escalations
              (SELECT   ppi.problem_investigation_id pbi_id, COUNT(piw.problem_investigation_id) AS num_escalations
                FROM    aradmin.pbm_problem_investigation@DTVREMP1.CISCO.COM ppi,
                        aradmin.pbm_investigation_worklog@DTVREMP1.CISCO.COM piw
               WHERE    ppi.problem_investigation_id = piw.problem_investigation_id
                 AND    SUBSTR(piw.description,1,17) = 'Formal escalation'
               GROUP BY ppi.problem_investigation_id) count_escalations,
               -- count_ASsociations
              (SELECT   pia.request_id02, 
                        NVL(COUNT(CASE WHEN SUBSTR(pia.request_id01,1,3) = 'CRQ'THEN 1 ELSE NULL END),0) AS num_CRQ_ASsociations,
                        NVL(COUNT(CASE WHEN SUBSTR(pia.request_id01,1,3) = 'INC'THEN 1 ELSE NULL END),0) AS num_INC_ASsociations,
                        NVL(COUNT(CASE WHEN SUBSTR(pia.request_id01,1,3) = 'SDB'THEN 1 ELSE NULL END),0) AS num_SDB_ASsociations,
                        NVL(COUNT(CASE WHEN SUBSTR(pia.request_id01,1,3) NOT IN ('CRQ','INC','SDB') THEN 1 ELSE NULL END),0) AS num_other_ASsociations                                          
                FROM aradmin.pbm_investigation_ASsociations@DTVREMP1.CISCO.COM pia
                group by pia.request_id02) count_ASsociations
        WHERE 1=1
          AND ppi.problem_investigation_id = calc_mmttouch.pbi_id(+) 
          AND ppi.problem_investigation_id = calc_ttc.pbi_id(+)
          AND ppi.problem_investigation_id = calc_ttr.pbi_id(+)
          AND ppi.problem_investigation_id = pia.request_id02(+)
          AND ppi.problem_investigation_id = count_touches.pbi_id(+)
          AND ppi.problem_investigation_id = count_escalations.pbi_id(+)
          AND ppi.problem_investigation_id = count_ASsociations.request_id02(+)
          AND ppi.problem_investigation_id in (SELECT DISTINCT pbi_id FROM pm_ids_to_pull)
        ORDER BY ppi.problem_investigation_id;
    COMMIT; 
   -- ---------------------------------------------------------------
   --    7. update pbi ASsociation flags
      DECLARE
         CURSOR pbi_ticket_cur IS
          SELECT pbi_id
            FROM pm_stage_data
        ORDER BY pbi_id;
       CURSOR pbi_ASsoc_cur(i_pbi_id IN VARCHAR2) IS
          SELECT   form_name01
                 , form_name02
                 , request_id01
                 , request_id02
                 , request_description01
                 , ASsociation_type01
            FROM aradmin.pbm_investigation_ASsociations@DTVREMP1.CISCO.COM pia
           WHERE request_id02 IS NOT NULL
            -- AND substr(request_id02, length(request_id02)-3) = 341;
            and request_id02 = i_pbi_id; 
    BEGIN
       -- for each record      
       FOR pbi_ticket_rec IN pbi_ticket_cur LOOP
       -- grab all the ASsociations      
          FOR pbi_ASsoc_rec IN pbi_ASsoc_cur(pbi_ticket_rec.pbi_id) LOOP
          -- for each ASsociation
            -- if the pbi wAS created by an incident
              IF pbi_ASsoc_rec.ASsociation_type01 = '31000' and SUBSTR(pbi_ASsoc_rec.request_id01,1,3) = 'INC' then
                UPDATE pm_stage_data
                    SET pbi_created_by_inc_flag = 'Y'
                WHERE pm_stage_data.pbi_id = pbi_ASsoc_rec.request_id02;
             END IF; 
              -- if the pbi wAS created by an change 
              IF pbi_ASsoc_rec.ASsociation_type01 = '31000' 
                AND SUBSTR(pbi_ASsoc_rec.request_id01,1,3) = 'CRQ' then
                UPDATE pm_stage_data
                   SET pbi_created_by_crq_flag = 'Y'
                 WHERE pm_stage_data.pbi_id = pbi_ASsoc_rec.request_id02;
             END IF; 
             -- if the pbi created a change request
             IF pbi_ASsoc_rec.ASsociation_type01 = '30000' and SUBSTR(pbi_ASsoc_rec.request_id01,1,3) = 'CRQ' then
                UPDATE pm_stage_data
                   SET pbi_created_crq_flag = 'Y'
                 WHERE pm_stage_data.pbi_id = pbi_ASsoc_rec.request_id02;
             END IF;
             -- if the pbi created a solution
             if pbi_ASsoc_rec.ASsociation_type01 = '30000' and SUBSTR(pbi_ASsoc_rec.request_id01,1,3) = 'SDB' then
                UPDATE pm_stage_data
                    set pbi_created_sdb_flag = 'Y'
                WHERE pm_stage_data.pbi_id = pbi_ASsoc_rec.request_id02;
             end if;
          END LOOP;   
       END LOOP;
    END;
   
   -- Solution tickets
   -- ---------------------------------------------------------------
   --    17. delete sdb record ids and records FROM lASt pull 
        METRIC_UTILITIES.TRUNC_TABLE('pm_sbd_ids_to_pull');
        METRIC_UTILITIES.TRUNC_TABLE('pm_sdb_stage_data');
   -- ---------------------------------------------------------------
   --    18. get sdb ids to pull this time 
        INSERT INTO pm_sbd_ids_to_pull(sdb_id)
        SELECT sdb.solution_databASe_id
            FROM aradmin.pbm_solution_databASe@DTVREMP1.CISCO.COM sdb
        WHERE metric_utilities.convert_to_date(sdb.lASt_modified_date) > i_start_date;
   -- ---------------------------------------------------------------
   --    19. insert into sdb_stage_data
        INSERT INTO pm_sdb_stage_data(
                sdb_id,
                submit_date,
                company,
                site,
                ASsigned_group,
                ASsignee,
                status,
                data_source)
        SELECT  solution_databASe_id sdb_id,
                metric_utilities.convert_to_date(sdb.submit_date) AS submit_date,
                sdb.company,
                sdb.site,
                sdb.ASsigned_group,
                NVL(sdb.ASsignee, 'Not ASsigned'),
                DECODE (sdb.status,
                        0,    'Proposed',
                        1,    'Enabled',
                        2,    'Offline',
                        3,    'Obsolete',
                        4,    'Archive',
                        5,    'Delete') AS status,
                        'DTV'
        FROM aradmin.pbm_solution_databASe@DTVREMP1.CISCO.COM sdb
        WHERE sdb.solution_databASe_id IN (SELECT DISTINCT sdb_id FROM pm_sbd_ids_to_pull); 
           
        o_pm_status := 'SUCCESS';   
   EXCEPTION
      WHEN others THEN
         v_msg := SQLERRM;
         o_pm_status := 'FAILURE';    
         metric_utilities.log_writer('ALL' ,'PM_GET_DATA_DTV ERROR', SYSDATE, v_msg);         
   END pm_get_data_dtv;

PROCEDURE pm_update_history_dtv(o_pm_status OUT VARCHAR) IS 
      v_msg VARCHAR2(1000);
   BEGIN      
      
      DELETE FROM pm_history_data 
       WHERE data_source = 'DTV'
       and pbi_id IN 
         (SELECT pbi_id 
            FROM pm_stage_data);
      COMMIT;
   -- ---------------------------------------------------------------
   --    9. insert into pm_history
        INSERT INTO pm_history_data
            (
            pbi_id,
            submit_date,
            lASt_modified_date,
            status,
            priority,
            status_reASon,
            company,
            site,
            ASsigned_group,
            ASsignee,
            categorization_tier1,
            categorization_tier2,
            categorization_tier3,
            product_categorization_tier1,
            product_categorization_tier2,
            product_categorization_tier3,
            -- calculated dates
            lASt_touch_date,
            closed_date,
            resolved_date,
            -- calculated times
            ttr_seconds,
            ttc_seconds,
            mtttouch_seconds,
            -- calculated flags
            closed_AS_duplicate_flag,
            pbi_created_by_inc_flag,
            pbi_created_by_crq_flag,
            pbi_created_crq_flag,
            pbi_created_sdb_flag,
            -- calculated counts
            num_touches,
            num_escalations,
            num_crq_ASsociations,
            num_inc_ASsociations,
            num_sdb_ASsociations,
            num_other_ASsociations,
            data_source)
        SELECT 
            pbi_id,
            submit_date,
            lASt_modified_date,
            status,
            priority,
            status_reASon,
            company,
            site,
            ASsigned_group,
            ASsignee,
            categorization_tier1,
            categorization_tier2,
            categorization_tier3,
            product_categorization_tier1,
            product_categorization_tier2,
            product_categorization_tier3,
            -- calculated dates
            lASt_touch_date,
            closed_date,
            resolved_date,
            -- calculated times
            ttr_seconds,
            ttc_seconds,
            mtttouch_seconds,
            -- calculated flags
            closed_AS_duplicate_flag,
            pbi_created_by_inc_flag,
            pbi_created_by_crq_flag,
            pbi_created_crq_flag,
            pbi_created_sdb_flag,
            -- calculated counts
            num_touches,
            num_escalations,
            num_crq_ASsociations,
            num_inc_ASsociations,
            num_sdb_ASsociations,
            num_other_ASsociations,
            data_source
        FROM pm_stage_data;
        
   -- ---------------------------------------------------------------
   --    20. delete FROM pm_sdb_history
         DELETE FROM pm_sdb_history_data
         WHERE data_source = 'DTV' and 
         sdb_id IN (SELECT sdb_id FROM pm_sdb_stage_data);
         
   -- ---------------------------------------------------------------
   --    21. insert into sdb_history
         INSERT INTO pm_sdb_history_data
            (
                    sdb_id,
                    submit_date,
                    company,
                    site,
                    ASsigned_group,
                    ASsignee,
                    status,
                    data_source
            )
          SELECT 
                    sdb_id,
                    submit_date,
                    company,
                    site,
                    ASsigned_group,
                    ASsignee,
                    status,
                    data_source
          FROM pm_sdb_stage_data;
        
        
        
        
      COMMIT;
        
      o_pm_status := 'SUCCESS';
         
   EXCEPTION
      WHEN others THEN
         v_msg := SQLERRM;
         o_pm_status := 'FAILURE';    
         metric_utilities.log_writer('ALL' ,'PM_UPDATE_HISTORY ERROR', SYSDATE, v_msg);         
   END pm_update_history_dtv;
      
   -- Rolls up Problem Managment data for reporting       
   PROCEDURE pm_rollup_data_dtv (o_pm_status   OUT VARCHAR) IS
      v_msg  VARCHAR2(1000);
      v_status VARCHAR2(15);         
   BEGIN
        metric_utilities.refresh_view('pm_rollup_company_site_VW','A', v_status ); 
        metric_utilities.refresh_view('pm_rollup_team_ASsignee_VW','A', v_status ); 
        metric_utilities.refresh_view('pm_rollup_tkt_metrics_VW','AF', v_status );
        metric_utilities.refresh_view('pm_rollup_tkt_data_VW','A', v_status ); 
        metric_utilities.refresh_view('pm_sdb_rollup_comp_site_VW','A', v_status ); 
        metric_utilities.refresh_view('pm_sdb_rollup_team_ASsn_VW','A', v_status ); 
        metric_utilities.refresh_view('pm_rollup_sdb_tkt_data_VW','A', v_status ); 
      o_pm_status := 'SUCCESS';   
   EXCEPTION
      WHEN others THEN
         v_msg := SQLERRM;
         o_pm_status := 'FAILURE';    
         metric_utilities.log_writer('ALL' ,'PM_ROLLUP_DATA ERROR', SYSDATE, v_msg);         
   END pm_rollup_data_dtv;    
   
   --Gets stage data FROM Change Managment bASe tables   

  PROCEDURE cm_get_data_dtv (i_start_date  IN DATE
                         ,i_stop_date   IN DATE
                         ,o_cm_status   OUT VARCHAR) IS
      v_msg  VARCHAR2(1000);   
   BEGIN

      metric_utilities.log_writer('CM','cm_dtv_get_stage_data procedure start',SYSDATE,NULL) ;  
       
       METRIC_UTILITIES.TRUNC_TABLE('cm_change_id_list');
       
       --SELECT * FROM cm_change_id_list;
       
       INSERT INTO cm_change_id_list 
      (request_id)
        (SELECT cic.infrAStructure_change_id 
           FROM aradmin.chg_infrAStructure_change@DTVREMP1.CISCO.COM cic
          WHERE metric_utilities.convert_to_date(cic.lASt_modified_date) BETWEEN i_start_date AND i_stop_date
        UNION
         SELECT ca.request_id02 
           FROM aradmin.chg_ASsociations@DTVREMP1.CISCO.COM ca
          WHERE metric_utilities.convert_to_date(ca.modified_date) BETWEEN i_start_date AND i_stop_date  
        UNION
        SELECT cw.infrAStructure_change_id 
          FROM aradmin.chg_worklog@DTVREMP1.CISCO.COM cw 
         WHERE metric_utilities.convert_to_date(cw.lASt_modified_date) BETWEEN i_start_date AND i_stop_date);
       
       METRIC_UTILITIES.TRUNC_TABLE('cm_stage_data');
       COMMIT;
       
       -- Fill CM_STAGE_DATA
        INSERT INTO cm_stage_data (
                -- ATOMIC FIELDS   
                  infrAStructure_change_id
                , ASchg 
                , ASgrp 
                , ASsigned_to 
                , ASsignee_id 
                , ASsignee_id_ASsignee
                , ASsignee_id_manager 
                , business_justification
                , categorization_tier_1 
                , categorization_tier_2 
                , categorization_tier_3 
                , change_request_status 
                , change_revierwer_name 
                , change_subtype
                , chgimp
                , chgimpgrp 
                , customer_area_code
                , customer_company
                , customer_corporate_id 
                , customer_department 
                , customer_extension
                , customer_first_name 
                , customer_lASt_name
                , customer_local_phone
                , customer_organization 
                , customer_phone_number 
                , department
                , first_name
                , impact
                , lASt_modified_by
                , lASt_name 
                , location_company
                , organization
                , owner_group 
                , owner_support_organization
                , phone_number
                , product_cat_tier_1_2_ 
                , product_cat_tier_2__2_
                , product_cat_tier_3__2_
                , product_categorization_tier_1 
                , product_categorization_tier_2 
                , product_categorization_tier_3 
                , product_model_version__2_ 
                , product_name
                , product_name__2_
                , region
                , request_id
                , requester_contacted 
                , site
                , site_group
                , site_id 
                , submitter 
                , support_group_name
                , support_group_name2
                , support_organization
                , support_organization2
                , total_time_spent
                , urgency 
                -- Calculated Values
                , change_timing_value
                , customer_email
                , description
                , priority
                , risk_level
                , status
                , status_reASon
                -- Atomic Dates      
                , acknowledgment_end_date 
                , actual_end_date 
                , actual_start_date 
                , completed_date
                , earliest_start_date 
                , lASt_modified_date
                , next_target_date
                , requested_end_date
                , requested_start_date
                , resolution_end_date 
                , response_target_date
                , rfc_date
                , scheduled_end_date
                , scheduled_start_date
                , submit_date 
                -- Calculated Dates    
                , completed_date_h
                , closed_date_h
                , month_completed_h
                , month_opened
                -- Calculated Flags    
                , crq_created_by_inc
                , chg_type_is_change_flag
                , chg_is_rejected_flag
                , chg_cancelled_rescheduled_flag
                , chg_is_emergency_flag
                , chg_is_backed_out_flag
                , chg_is_successful_flag 
                , chg_is_expedited_flag
                -- Calculated Counts    
                , num_inc_FROM_this_crq 
                -- Calculated Times       
                , time_to_complete_days
                -- Data Source    
                , data_source 
         )
        SELECT
                -- Atomic Fields   
                  cic.infrAStructure_change_id
                , cic.ASchg
                , cic.ASgrp
                , cic.ASsigned_to                  
                , cic.ASsignee_id
                , cic.ASsignee_id_ASsignee
                , cic.ASsignee_id_manager 
                , cic.business_justification
                , cic.categorization_tier_1
                , cic.categorization_tier_2
                , cic.categorization_tier_3
                , cic.change_request_status
                , cic.change_revierwer_name
                , cic.change_subtype
                , cic.chgimp
                , cic.chgimpgrp 
                , cic.customer_area_code
                , cic.customer_company
                , cic.customer_corporate_id
                , cic.customer_department
                , cic.customer_extension
                , cic.customer_first_name
                , cic.customer_lASt_name
                , cic.customer_local_phone
                , cic.customer_organization
                , cic.customer_phone_number
                , cic.department
                , cic.first_name
                , cic.impact
                , cic.lASt_modified_by
                , cic.lASt_name
                , cic.location_company
                , cic.organization
                , cic.owner_group
                , cic.owner_support_organization
                , cic.phone_number
                , cic.product_cat_tier_1_2_
                , cic.product_cat_tier_2__2_
                , cic.product_cat_tier_3__2_
                , cic.product_categorization_tier_1
                , cic.product_categorization_tier_2
                , cic.product_categorization_tier_3
                , cic.product_model_version__2_
                , cic.product_name 
                , cic.product_name__2_
                , cic.region
                , cic.request_id
                , cic.requester_contacted
                , cic.risk_level
                , cic.site
                , cic.site_group
                , cic.site_id
                , cic.submitter
                , cic.support_group_name
                , cic.support_organization
                , cic.support_organization2
                , cic.total_time_spent
                , cic.urgency
                -- Calculated Values
                , metric_utilities.enum_values(1200,1000000568,cic.change_timing) AS change_timing_value
                , REPLACE(REPLACE(cic.customer_internet_e_mail,chr(10),' '),chr(13),' ') AS customer_email
                , REPLACE(REPLACE(cic.description,chr(10),' '),chr(13),' ') AS description
                , metric_utilities.enum_values(1200,1000000164,cic.priority) AS priority 
                , metric_utilities.enum_values(1200,1000000180,cic.risk_level) AS risk_level
                , metric_utilities.enum_values(1200,7,cic.change_request_status) AS status 
                , metric_utilities.enum_values(1200,1000000150,cic.status_reASon) AS status_reASon 
                -- Atomic Dates   
                , metric_utilities.convert_to_date(cic.acknowledgment_end_date)AS acknowledgment_end_date
                , metric_utilities.convert_to_date(cic.actual_end_date)AS actual_end_date
                , metric_utilities.convert_to_date(cic.actual_start_date)AS actual_start_date
                , metric_utilities.convert_to_date(cic.completed_date)AS completed_date
                , metric_utilities.convert_to_date(cic.earliest_start_date)AS earliest_start_date
                , metric_utilities.convert_to_date(cic.lASt_modified_date)AS lASt_modified_date
                , metric_utilities.convert_to_date(cic.next_target_date)AS next_target_date
                , metric_utilities.convert_to_date(cic.requested_end_date)AS requested_end_date
                , metric_utilities.convert_to_date(cic.requested_start_date)AS requested_start_date
                , metric_utilities.convert_to_date(cic.resolution_end_date)AS resolution_end_date
                , metric_utilities.convert_to_date(cic.response_target_date)AS response_target_date
                , metric_utilities.convert_to_date(cic.rfc_date)AS rfc_date
                , metric_utilities.convert_to_date(cic.scheduled_end_date)AS scheduled_end_date
                , metric_utilities.convert_to_date(cic.scheduled_start_date)AS scheduled_start_date
                , metric_utilities.convert_to_date(cic.submit_date)AS submit_date
                -- Calculated Dates 
                ,   (SELECT metric_utilities.convert_to_date(t10)
                      FROM aradmin.H1200@DTVREMP1.CISCO.COM h
                      WHERE h.entryid = cic.request_id )
                      AS 
                completed_date_h   
                ,   (SELECT metric_utilities.convert_to_date(t11)
                      FROM aradmin.H1200@DTVREMP1.CISCO.COM h
                      WHERE h.entryid = cic.request_id
                      )
                      AS 
                closed_date_h   
                ,   to_char((SELECT metric_utilities.convert_to_date(t10) 
                             FROM aradmin.H1200@DTVREMP1.CISCO.COM h
                            WHERE h.entryid = cic.request_id
                            ) ,'MONTH') AS 
                month_completed_h
                ,       to_char(metric_utilities.convert_to_date(cic.submit_date), 'MONTH') AS 
                month_opened
                -- Calculated Flags
                ,           ca_set_flag.flag AS 
                  crq_created_by_INC
                ,           CASE WHEN cic.change_type = 2000 THEN 'Y' ELSE 'N' END AS
                  chg_type_is_change_flag
                ,           CASE WHEN cic.change_type = 2000 AND change_request_status = 9 THEN 'Y' ELSE 'N' END AS
                  chg_is_rejected_flag
                ,           CASE WHEN cic.change_request_status = 12 AND status_reASon = 3000 THEN 'Y' ELSE 'N' END AS
                  chg_cancelled_rescheduled_flag
                ,           CASE WHEN cic.change_timing = 1000 THEN 'Y' ELSE 'N' END AS
                  chg_is_emergency_flag
                ,           CASE WHEN cic.change_request_status = 11 AND status_reASon = 8000 THEN 'Y' ELSE 'N' END AS
                  chg_is_backed_out_flag
                ,           CASE WHEN cic.change_request_status = 11 AND status_reASon = 5000 THEN 'Y' ELSE 'N' END AS
                  chg_is_successful_flag 
                ,           CASE WHEN cic.change_timing = 2000 THEN 'Y' ELSE 'N' END AS
                  chg_is_expedited_flag
                -- Calculated Counts  
                ,           NVL(count_incidents.num_inc_FROM_this_CRQ,0) AS
                  num_inc_FROM_this_CRQ 
                -- Calculated Times    
                ,         (CASE WHEN cic.change_request_status  =  10 
                                  THEN metric_utilities.convert_to_date(cic.completed_date) -  metric_utilities.convert_to_date(cic.submit_date)  
                            END) AS  
                   time_to_complete_days
                , 'DTV'
        FROM    aradmin.chg_infrAStructure_change@DTVREMP1.CISCO.COM cic
                -- count_incidents created by this change
                ,   (   SELECT  cic.infrAStructure_change_id AS infrAStructure_change_id, count(ca.request_id02) AS num_inc_FROM_this_CRQ
                        FROM    aradmin.chg_infrAStructure_change@DTVREMP1.CISCO.COM cic,
                                aradmin.chg_ASsociations@DTVREMP1.CISCO.COM ca
                        WHERE   cic.infrAStructure_change_id = ca.request_id02
                            and ca.ASsociation_type01=30000 
                            and SUBSTR(ca.request_id01,1,3) = 'INC'
                            GROUP BY cic.infrAStructure_change_id) 
                count_incidents
                ,   (   SELECT  cic.infrAStructure_change_id AS infrAStructure_change_id,
                                max(ca_flag.flag) flag 
                        FROM aradmin.chg_infrAStructure_change@DTVREMP1.CISCO.COM cic,
                                (SELECT  ca.request_id02, ca.request_id01, 
                                CASE WHEN ca.ASsociation_type01=31000 AND SUBSTR(ca.request_id01,1,3) = 'INC' THEN 'Y' ELSE 'N' END flag
                                FROM aradmin.chg_ASsociations@DTVREMP1.CISCO.COM ca) ca_flag
                                WHERE cic.infrAStructure_change_id = ca_flag.request_id02
                                group by cic.infrAStructure_change_id) 
                 ca_set_flag
             WHERE cic.infrAStructure_change_id = ca_set_flag.infrAStructure_change_id(+)
              and cic.infrAStructure_change_id = count_incidents.infrAStructure_change_id(+)
              AND cic.infrAStructure_change_id IN 
                    (SELECT DISTINCT(request_id) 
                       FROM cm_change_id_list);
                           
               COMMIT;
           o_cm_status := 'SUCCESS';
              
   EXCEPTION
      WHEN others THEN
         v_msg := SQLERRM;
         o_cm_status := 'FAILURE';    
         metric_utilities.log_writer('ALL' ,'CM_DTV_GET_DATA ERROR', SYSDATE, v_msg);         
   END cm_get_data_DTV;

   

 PROCEDURE cm_update_history_dtv(o_cm_status  OUT VARCHAR) IS
      v_msg  VARCHAR2(1000); 
     
   BEGIN

      metric_utilities.log_writer('CM','cm_dtv_update_history_data procedure start',SYSDATE,NULL);    
   
      DELETE FROM cm_history_data 
       WHERE data_source = 'DTV' 
         and infrAStructure_change_id IN 
         (SELECT infrAStructure_change_id 
            FROM cm_stage_data);
   
      COMMIT;

        INSERT INTO CM_HISTORY_DATA (
                -- ATOMIC FIELDS   
                  INFRASTRUCTURE_CHANGE_ID
                , ASCHG 
                , ASGRP 
                , ASSIGNED_TO 
                , ASSIGNEE_ID 
                , ASSIGNEE_ID_ASSIGNEE
                , ASSIGNEE_ID_MANAGER 
                , BUSINESS_JUSTIFICATION
                , CATEGORIZATION_TIER_1 
                , CATEGORIZATION_TIER_2 
                , CATEGORIZATION_TIER_3 
                , CHANGE_REQUEST_STATUS 
                , CHANGE_REVIERWER_NAME 
                , CHANGE_SUBTYPE
                , CHGIMP
                , CHGIMPGRP 
                , CUSTOMER_AREA_CODE
                , CUSTOMER_COMPANY
                , CUSTOMER_CORPORATE_ID 
                , CUSTOMER_DEPARTMENT 
                , CUSTOMER_EXTENSION
                , CUSTOMER_FIRST_NAME 
                , CUSTOMER_LAST_NAME
                , CUSTOMER_LOCAL_PHONE
                , CUSTOMER_ORGANIZATION 
                , CUSTOMER_PHONE_NUMBER 
                , DEPARTMENT
                , FIRST_NAME
                , IMPACT
                , LAST_MODIFIED_BY
                , LAST_NAME 
                , LOCATION_COMPANY
                , ORGANIZATION
                , OWNER_GROUP 
                , OWNER_SUPPORT_ORGANIZATION
                , PHONE_NUMBER
                , PRODUCT_CAT_TIER_1_2_ 
                , PRODUCT_CAT_TIER_2__2_
                , PRODUCT_CAT_TIER_3__2_
                , PRODUCT_CATEGORIZATION_TIER_1 
                , PRODUCT_CATEGORIZATION_TIER_2 
                , PRODUCT_CATEGORIZATION_TIER_3 
                , PRODUCT_MODEL_VERSION__2_ 
                , PRODUCT_NAME
                , PRODUCT_NAME__2_
                , REGION
                , REQUEST_ID
                , REQUESTER_CONTACTED 
                , SITE
                , SITE_GROUP
                , SITE_ID 
                , SUBMITTER 
                , SUPPORT_GROUP_NAME
                , SUPPORT_GROUP_NAME2
                , SUPPORT_ORGANIZATION
                , SUPPORT_ORGANIZATION2
                , TOTAL_TIME_SPENT
                , URGENCY 
                -- Calculated Values
                , CHANGE_TIMING_VALUE
                , CUSTOMER_EMAIL
                , DESCRIPTION
                , PRIORITY
                , RISK_LEVEL
                , STATUS
                , STATUS_REASON
                -- Atomic Dates      
                , ACKNOWLEDGMENT_END_DATE 
                , ACTUAL_END_DATE 
                , ACTUAL_START_DATE 
                , COMPLETED_DATE
                , EARLIEST_START_DATE 
                , LAST_MODIFIED_DATE
                , NEXT_TARGET_DATE
                , REQUESTED_END_DATE
                , REQUESTED_START_DATE
                , RESOLUTION_END_DATE 
                , RESPONSE_TARGET_DATE
                , RFC_DATE
                , SCHEDULED_END_DATE
                , SCHEDULED_START_DATE
                , SUBMIT_DATE 
                -- Calculated Dates    
                , COMPLETED_DATE_H
                , CLOSED_DATE_H
                , MONTH_COMPLETED_H
                , MONTH_OPENED
                -- Calculated Flags    
                , CRQ_CREATED_BY_INC
                , CHG_TYPE_IS_CHANGE_FLAG
                , CHG_IS_REJECTED_FLAG
                , CHG_CANCELLED_RESCHEDULED_FLAG
                , CHG_IS_EMERGENCY_FLAG
                , CHG_IS_BACKED_OUT_FLAG
                , CHG_IS_SUCCESSFUL_FLAG 
                , CHG_IS_EXPEDITED_FLAG
                -- Calculated Counts    
                , NUM_INC_FROM_THIS_CRQ 
                -- Calculated Times       
                , TIME_TO_COMPLETE_DAYS
                -- Data Source    
                , DATA_SOURCE 
         )
         SELECT 
                -- ATOMIC FIELDS   
                  INFRASTRUCTURE_CHANGE_ID
                , ASCHG 
                , ASGRP 
                , ASSIGNED_TO 
                , ASSIGNEE_ID 
                , ASSIGNEE_ID_ASSIGNEE
                , ASSIGNEE_ID_MANAGER 
                , BUSINESS_JUSTIFICATION
                , CATEGORIZATION_TIER_1 
                , CATEGORIZATION_TIER_2 
                , CATEGORIZATION_TIER_3 
                , CHANGE_REQUEST_STATUS 
                , CHANGE_REVIERWER_NAME 
                , CHANGE_SUBTYPE
                , CHGIMP
                , CHGIMPGRP 
                , CUSTOMER_AREA_CODE
                , CUSTOMER_COMPANY
                , CUSTOMER_CORPORATE_ID 
                , CUSTOMER_DEPARTMENT 
                , CUSTOMER_EXTENSION
                , CUSTOMER_FIRST_NAME 
                , CUSTOMER_LAST_NAME
                , CUSTOMER_LOCAL_PHONE
                , CUSTOMER_ORGANIZATION 
                , CUSTOMER_PHONE_NUMBER 
                , DEPARTMENT
                , FIRST_NAME
                , IMPACT
                , LAST_MODIFIED_BY
                , LAST_NAME 
                , LOCATION_COMPANY
                , ORGANIZATION
                , OWNER_GROUP 
                , OWNER_SUPPORT_ORGANIZATION
                , PHONE_NUMBER
                , PRODUCT_CAT_TIER_1_2_ 
                , PRODUCT_CAT_TIER_2__2_
                , PRODUCT_CAT_TIER_3__2_
                , PRODUCT_CATEGORIZATION_TIER_1 
                , PRODUCT_CATEGORIZATION_TIER_2 
                , PRODUCT_CATEGORIZATION_TIER_3 
                , PRODUCT_MODEL_VERSION__2_ 
                , PRODUCT_NAME
                , PRODUCT_NAME__2_
                , REGION
                , REQUEST_ID
                , REQUESTER_CONTACTED 
                , SITE
                , SITE_GROUP
                , SITE_ID 
                , SUBMITTER 
                , SUPPORT_GROUP_NAME
                , SUPPORT_GROUP_NAME2
                , SUPPORT_ORGANIZATION
                , SUPPORT_ORGANIZATION2
                , TOTAL_TIME_SPENT
                , URGENCY 
                -- Calculated Values
                , CHANGE_TIMING_VALUE
                , CUSTOMER_EMAIL
                , DESCRIPTION
                , PRIORITY
                , RISK_LEVEL
                , STATUS
                , STATUS_REASON
                -- Atomic Dates      
                , ACKNOWLEDGMENT_END_DATE 
                , ACTUAL_END_DATE 
                , ACTUAL_START_DATE 
                , COMPLETED_DATE
                , EARLIEST_START_DATE 
                , LAST_MODIFIED_DATE
                , NEXT_TARGET_DATE
                , REQUESTED_END_DATE
                , REQUESTED_START_DATE
                , RESOLUTION_END_DATE 
                , RESPONSE_TARGET_DATE
                , RFC_DATE
                , SCHEDULED_END_DATE
                , SCHEDULED_START_DATE
                , SUBMIT_DATE 
                -- Calculated Dates    
                , COMPLETED_DATE_H
                , CLOSED_DATE_H
                , MONTH_COMPLETED_H
                , MONTH_OPENED
                -- Calculated Flags    
                , CRQ_CREATED_BY_INC
                , CHG_TYPE_IS_CHANGE_FLAG
                , CHG_IS_REJECTED_FLAG
                , CHG_CANCELLED_RESCHEDULED_FLAG
                , CHG_IS_EMERGENCY_FLAG
                , CHG_IS_BACKED_OUT_FLAG
                , CHG_IS_SUCCESSFUL_FLAG 
                , CHG_IS_EXPEDITED_FLAG
                -- Calculated Counts    
                , NUM_INC_FROM_THIS_CRQ 
                -- Calculated Times       
                , TIME_TO_COMPLETE_DAYS
                -- Data Source    
                , DATA_SOURCE 
        FROM cm_stage_data;


      COMMIT; 
      metric_utilities.log_writer('CM','cm_dtv_update_history_data procedure end',SYSDATE,NULL);  
      o_cm_status := 'SUCCESS';      
   EXCEPTION
      WHEN others THEN
        v_msg := SQLERRM;
        o_cm_status := 'FAILURE';     
        metric_utilities.log_writer('CM','cm_dtv_get_stage_data procedure ERROR',SYSDATE, v_msg);  
   END cm_update_history_dtv;   
   
       
   --Rolls up Change Managment data for reporting       
   PROCEDURE cm_rollup_data_dtv(o_cm_status OUT VARCHAR) IS
      v_msg  VARCHAR2(1000);   
      v_status VARCHAR2(15);
   BEGIN
       metric_utilities.refresh_snapshot( 'CM_ROLLUP_OPENCOUNTSVW', v_status );
       metric_utilities.refresh_snapshot( 'CM_ROLLUP_CLOSEDCOUNTSVW', v_status );     
       metric_utilities.refresh_snapshot( 'CM_ROLLUP_OPENCOUNTSBYEMPVW',v_status );   
       metric_utilities.refresh_snapshot( 'CM_ROLLUP_CLOSEDCOUNTSBYEMPVW', v_status );   
       o_cm_status := 'SUCCESS';
   EXCEPTION
      WHEN others THEN
         v_msg := SQLERRM;
         o_cm_status := 'FAILURE';   
         metric_utilities.log_writer('ALL' ,'CM_ROLLUP_DATA ERROR', SYSDATE, v_msg);         
   END cm_rollup_data_dtv;    
       
END metric_rollups_dtv;
/
