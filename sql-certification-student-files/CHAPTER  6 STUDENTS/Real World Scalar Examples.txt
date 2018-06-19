select * from meta_reporting.md_elt_metadata
where process_type='FUSING'
and job_body like '%inst%';


INSERT INTO dss_fuse.inst_claims_main_fuse
SELECT
    generate_uuid_fast(),
    CLM_PRCS_RCRD_CD,
    CLM_PRCS_RCRD_CD_IC,
    INTNL_CTL_NO,
    ORIG_CLM_ICN,
    CLM_PRCS_TXCD,
    CDE_CLM_STATUS_IC,
    CASE
        WHEN LENGTH(trim(CYCLE_DATE)) > 0
        AND CYCLE_DATE <> '00000000'
        THEN TO_DATE(CYCLE_DATE,'YYYYMMDD')
    END,
    CYCLE_DATE_IND,
    PROGRAM_INDICATOR,
    CDE_FUND_PAYER,
    SPL_PRCS_FLAG,
    NUM_COMMIT_ERRORS,
    NUM_OI_CARR_CODES,
    NUM_ERRORS,
    NUM_LOCATIONS,
    NUM_SURG,
    NUM_OCCURRENCES,
    NUM_COND_CODES,
    NUM_RETRO_ME,
    NUM_OF_DETAILS,
    RECIP_CUR_PCN,
    RECIP_ORIG_PCN,
    RECIP_LST_NM,
    RECIP_1ST_NM,
    RECIP_TOWN_CD,
    RECIP_DISTRICT_CODE,
    RECIP_DISTRICT_CODE_IC,
    RECIP_ME_CODE,
    RECIP_SXCD,
    RECIP_SXCD_IC,
    RECIP_RACE_CD,
    RECIP_RACE_CD_IC,
    RECIP_AGE,
    CASE
        WHEN LENGTH(trim(RECIP_BIRTHDATE)) > 0
        AND RECIP_BIRTHDATE <> '00000000'
        THEN to_date(RECIP_BIRTHDATE,'YYYYMMDD')
    END,
    RECIP_SSN,
    RECIP_ZPCD_P_NUM,
    RECIP_MONY_PAY_IND,
    RECIP_DAYS_ELIGIBLE,
    CASE
        WHEN LENGTH(trim(ACCIDENT_DATE_YYMMDD)) > 0
        AND ACCIDENT_DATE_YYMMDD <> '00000000'
        THEN to_date(ACCIDENT_DATE_YYMMDD,'YYYYMMDD')
    END,
    ACC_REL_CD,
    JOB_REL_CD,
    RECIP_WAIVER_PGM,
    TPTY_INS_CD,
    TPTY_INS_CD2,
    TPTY_INS_CD3,
    OTHER_INS_CARRIER_CODE1,
    OTHER_INS_CARRIER_CODE2,
    OTHER_INS_CARRIER_CODE3,
    OTHER_INS_EOB,
    MEDICARE_A_INDICATOR,
    MEDICARE_B_INDICATOR,
    MED_B_EOMB_INDICATOR,
    XOVR_RCRD_TY,
    PROV_NO,
    PROV_SPCD,
    PROV_SPCD_IC,
    PROV_TYCD,
    PROV_TYCD_IC,
    PROV_LOCD,
    PROV_LOCD_IC,
    PROV_TOWN_CODE,
    PROV_ZIP_CODE_NUM,
    PROV_NPI,
    PROV_TAXONOMY,
    ATTD_PHYS,
    REFER_PHYS,
    MEDICAL_RECORD_NUMBER,
    HCFA_MONEY,
    HCFA_ELIGIBILITY,
    COS64,
    RECIP_QMB_IND,
    CASE
        WHEN(INSTRB(TOT_CLM_CHG,'-') > 0 )
        THEN '-' || SUBSTRING(TOT_CLM_CHG,1, INSTRB(TOT_CLM_CHG,'-') - 1)
        ELSE TOT_CLM_CHG
    END::NUMBER(11,2),
    CASE
        WHEN(INSTRB(TOT_OTHER_INS,'-') > 0 )
        THEN '-' || SUBSTRING(TOT_OTHER_INS,1, INSTRB(TOT_OTHER_INS,'-') - 1)
        ELSE TOT_OTHER_INS
    END::NUMBER(11,2),
    CASE
        WHEN(INSTRB(TOT_PATIENT_LIAB,'-') > 0 )
        THEN '-' || SUBSTRING(TOT_PATIENT_LIAB,1, INSTRB(TOT_PATIENT_LIAB,'-') - 1)
        ELSE TOT_PATIENT_LIAB
    END::NUMBER(11,2),
    CASE
        WHEN(INSTRB(NET_CLM_CHG,'-') > 0 )
        THEN '-' || SUBSTRING(NET_CLM_CHG,1, INSTRB(NET_CLM_CHG,'-') - 1)
        ELSE NET_CLM_CHG
    END::NUMBER(11,2),
    CASE
        WHEN(INSTRB(TOT_COPAY,'-') > 0 )
        THEN '-' || SUBSTRING(TOT_COPAY,1, INSTRB(TOT_COPAY,'-') - 1)
        ELSE TOT_COPAY
    END::NUMBER(11,2),
    CASE
        WHEN(INSTRB(REMB_AMT_P,'-') > 0 )
        THEN '-' || SUBSTRING(REMB_AMT_P,1, INSTRB(REMB_AMT_P,'-') - 1)
        ELSE REMB_AMT_P
    END::NUMBER(11,2),
    timestampadd('d',substring(ADDT,5)::INTEGER-1, DATE(substring(ADDT,1,4)||'-01-01'))::DATE,
    CASE
        WHEN LENGTH(trim(CLM_PAY_DT_P)) > 0
        AND CLM_PAY_DT_P <> '00000000'
        THEN to_date(CLM_PAY_DT_P, 'YYYYMMDD')
    END,
    STATE_WARRANT_NO,
    CLM_PAY_CHK_NO_P,
    CASE
        WHEN(INSTRB(SAGA_REPRICE_DIFF,'-') > 0 )
        THEN '-' || SUBSTRING(SAGA_REPRICE_DIFF,1, INSTRB(SAGA_REPRICE_DIFF,'-') - 1)
        ELSE SAGA_REPRICE_DIFF
    END::NUMBER(11,2),
    MAJ_CAT_SERV,
    INT_CAT_SERV,
    CASE
        WHEN LENGTH(trim(BFD)) > 0
        AND BFD <> '00000000'
        THEN to_date(BFD,'YYYYMMDD')
    END,
    CASE
        WHEN LENGTH(trim(BTD)) > 0
        AND BTD <> '00000000'
        THEN to_date(BTD,'YYYYMMDD')
    END,
    ADMIN_NECSSRY_DAYS_IND,
    CASE
        WHEN LENGTH(trim(ADM_DT)) > 0
        AND ADM_DT <> '00000000'
        THEN to_date(ADM_DT,'YYYYMMDD')
    END,
    SOURCE_OF_ADM,
    NATR_OF_ADM,
    CASE
        WHEN LENGTH(trim(DT_OF_DSCH)) > 0
        AND DT_OF_DSCH <> '00000000'
        THEN to_date(DT_OF_DSCH,'YYYYMMDD')
    END,
    DSCH_DEST,
    TYPE_OF_BILL,
    OPR_SURG_PROV_NO,
    ADM_HR,
    TOT_DY_BILL::NUMBER(4),
    TOT_NON_COVERED_DAYS::NUMBER(4),
    NURSING_LEVEL_CARE,
    SUBMITTER_TRACE_ID,
    CASE
        WHEN(INSTRB(SAGA_REPRICE_FACTOR,'-') > 0 )
        THEN '-' || SUBSTRING(SAGA_REPRICE_FACTOR,1, INSTRB(SAGA_REPRICE_FACTOR,'-') - 1)
        ELSE SAGA_REPRICE_FACTOR
    END::NUMBER(11,2),
    CASE
        WHEN(INSTRB(CSH_DED,'-') > 0 )
        THEN '-' || SUBSTRING(CSH_DED,1, INSTRB(CSH_DED,'-') - 1)
        WHEN LENGTH(trim(CSH_DED)) = 0
        THEN NULL
        ELSE CSH_DED
    END::NUMBER(11,2),
    CASE
        WHEN(INSTRB(COIN_AMT,'-') > 0 )
        THEN '-' || SUBSTRING(COIN_AMT,1, INSTRB(COIN_AMT,'-') - 1)
        WHEN LENGTH(trim(COIN_AMT)) = 0
        THEN NULL
        ELSE COIN_AMT
    END::NUMBER(11,2),
    CASE
        WHEN(INSTRB(MCARE_COV_CHG,'-') > 0 )
        THEN '-' || SUBSTRING(MCARE_COV_CHG,1, INSTRB(MCARE_COV_CHG,'-') - 1)
        WHEN LENGTH(trim(MCARE_COV_CHG)) = 0
        THEN NULL
        ELSE MCARE_COV_CHG
    END::NUMBER(11,2),
    CASE
        WHEN(INSTRB(MCARE_NCOV_CHG,'-') > 0 )
        THEN '-' || SUBSTRING(MCARE_NCOV_CHG,1, INSTRB(MCARE_NCOV_CHG,'-') - 1)
        WHEN LENGTH(trim(MCARE_NCOV_CHG)) = 0
        THEN NULL
        ELSE MCARE_NCOV_CHG
    END::NUMBER(11,2),
    CASE
        WHEN(INSTRB(MCARE_BILLED,'-') > 0 )
        THEN '-' || SUBSTRING(MCARE_BILLED,1, INSTRB(MCARE_BILLED,'-') - 1)
        WHEN LENGTH(trim(MCARE_BILLED)) = 0
        THEN NULL
        ELSE MCARE_BILLED
    END::NUMBER(11,2),
    CASE
        WHEN(INSTRB(MCARE_PAID,'-') > 0 )
        THEN '-' || SUBSTRING(MCARE_PAID,1, INSTRB(MCARE_PAID,'-') - 1)
        WHEN LENGTH(trim(MCARE_PAID)) = 0
        THEN NULL
        ELSE MCARE_PAID
    END::NUMBER(11,2),
    CASE
        WHEN LENGTH(trim(MEDICARE_PAID_DTE)) > 0
        AND MEDICARE_PAID_DTE <> '00000000'
        AND INSTRB(MEDICARE_PAID_DTE,'.') = 0
        THEN to_date(MEDICARE_PAID_DTE,'YYYYMMDD')
    END,
    CASE
        WHEN(INSTRB(HDR_COINS_AMT_B,'-') > 0 )
        THEN '-' || SUBSTRING(HDR_COINS_AMT_B,1, INSTRB(HDR_COINS_AMT_B,'-') - 1)
        WHEN LENGTH(trim(HDR_COINS_AMT_B)) = 0
        THEN NULL
        ELSE HDR_COINS_AMT_B
    END::NUMBER(11,2),
    CASE
        WHEN(INSTRB(HDR_DEDUCT_AMT_B,'-') > 0 )
        THEN '-' || SUBSTRING(HDR_DEDUCT_AMT_B,1, INSTRB(HDR_DEDUCT_AMT_B,'-') - 1)
        WHEN LENGTH(trim(HDR_DEDUCT_AMT_B)) = 0
        THEN NULL
        ELSE HDR_DEDUCT_AMT_B
    END::NUMBER(11,2),
    CASE
        WHEN LENGTH(trim(FFP_TRLR_DATE_ADDED)) > 0
        AND FFP_TRLR_DATE_ADDED <> '00000000'
        THEN to_date(FFP_TRLR_DATE_ADDED,'YYYYMMDD')
    END,
    FFP_ORIGINAL_ME,
    FFP_NEW_ME_CODE,
    SERVICE_LINE_NO,
    LN_ITM_STATUS,
    LN_ITM_STATUS_IC,
    LN_ITM_PRCS_CD,
    BENEFIT_PLAN,
    ASSIGNMENT_PLAN,
    CDE_FUND_CODE,
    CDE_PROV_PGM,
    L3_PA_INDICATOR,
    PA_BYPASS_INDICATOR,
    PA_APPLICATION,
    CASE
        WHEN LENGTH(trim(FST_PROC_SVDT)) > 0
        AND FST_PROC_SVDT <> '00000000'
        THEN to_date(FST_PROC_SVDT,'YYYYMMDD')
    END,
    CASE
        WHEN LENGTH(trim(LST_PROC_SVDT)) > 0
        AND LST_PROC_SVDT <> '00000000'
        THEN to_date(LST_PROC_SVDT,'YYYYMMDD')
    END,
    CASE
        WHEN(INSTRB(UNT_OF_SERV,'-') > 0 )
        THEN '-' || SUBSTRING(UNT_OF_SERV,1, INSTRB(UNT_OF_SERV,'-') - 1)
        WHEN LENGTH(trim(UNT_OF_SERV)) = 0
        THEN NULL
        ELSE UNT_OF_SERV
    END::NUMBER(12,3),
    CASE
        WHEN(INSTRB(UNITS_BILLED,'-') > 0 )
        THEN '-' || SUBSTRING(UNITS_BILLED,1, INSTRB(UNITS_BILLED,'-') - 1)
        WHEN LENGTH(trim(UNITS_BILLED)) = 0
        THEN NULL
        ELSE UNITS_BILLED
    END::NUMBER(12,3),
    CASE
        WHEN(INSTRB(UNITS_CUTBACK,'-') > 0 )
        THEN '-' || SUBSTRING(UNITS_CUTBACK,1, INSTRB(UNITS_CUTBACK,'-') - 1)
        WHEN LENGTH(trim(UNITS_CUTBACK)) = 0
        THEN NULL
        ELSE UNITS_CUTBACK
    END::NUMBER(12,3),
    PL_OF_SERV,
    DET_MAJ_CAT_OF_SVC,
    DET_INT_CAT_OF_SVC,
    DTL_PERFORM_PHYS,
    HCFA64_COS,
    CASE
        WHEN(INSTRB(SUBM_CHG,'-') > 0 )
        THEN '-' || SUBSTRING(SUBM_CHG,1, INSTRB(SUBM_CHG,'-') - 1)
        WHEN LENGTH(trim(SUBM_CHG)) = 0
        THEN NULL
        ELSE SUBM_CHG
    END::NUMBER(11,2),
    CASE
        WHEN(INSTRB(ALW_CHG,'-') > 0 )
        THEN '-' || SUBSTRING(ALW_CHG,1, INSTRB(ALW_CHG,'-') - 1)
        WHEN LENGTH(trim(ALW_CHG)) = 0
        THEN NULL
        ELSE ALW_CHG
    END::NUMBER(11,2),
    CASE
        WHEN(INSTRB(COPAY,'-') > 0 )
        THEN '-' || SUBSTRING(COPAY,1, INSTRB(COPAY,'-') - 1)
        WHEN LENGTH(trim(COPAY)) = 0
        THEN NULL
        ELSE COPAY
    END::NUMBER(11,2),
    CASE
        WHEN(INSTRB(OTHER_INS_AMT,'-') > 0 )
        THEN '-' || SUBSTRING(OTHER_INS_AMT,1, INSTRB(OTHER_INS_AMT,'-') - 1)
        WHEN LENGTH(trim(OTHER_INS_AMT)) = 0
        THEN NULL
        ELSE OTHER_INS_AMT
    END::NUMBER(11,2),
    CASE
        WHEN(INSTRB(SPEND_DOWN_AMT,'-') > 0 )
        THEN '-' || SUBSTRING(SPEND_DOWN_AMT,1, INSTRB(SPEND_DOWN_AMT,'-') - 1)
        WHEN LENGTH(trim(SPEND_DOWN_AMT)) = 0
        THEN NULL
        ELSE SPEND_DOWN_AMT
    END::NUMBER(11,2),
    CASE
        WHEN(INSTRB(PATIENT_LIAB_AMT,'-') > 0 )
        THEN '-' || SUBSTRING(PATIENT_LIAB_AMT,1, INSTRB(PATIENT_LIAB_AMT,'-') - 1)
        WHEN LENGTH(trim(PATIENT_LIAB_AMT)) = 0
        THEN NULL
        ELSE PATIENT_LIAB_AMT
    END::NUMBER(11,2),
    CASE
        WHEN(INSTRB(OTHER_CUTBACK,'-') > 0 )
        THEN '-' || SUBSTRING(OTHER_CUTBACK,1, INSTRB(OTHER_CUTBACK,'-') - 1)
        WHEN LENGTH(trim(OTHER_CUTBACK)) = 0
        THEN NULL
        ELSE OTHER_CUTBACK
    END::NUMBER(11,2),
    CASE
        WHEN(INSTRB(DETAIL_PAID_AMT,'-') > 0 )
        THEN '-' || SUBSTRING(DETAIL_PAID_AMT,1, INSTRB(DETAIL_PAID_AMT,'-') - 1)
        WHEN LENGTH(trim(DETAIL_PAID_AMT)) = 0
        THEN NULL
        ELSE DETAIL_PAID_AMT
    END::NUMBER(11,2),
    CASE
        WHEN(INSTRB(DETAIL_SAGA_REPRICE_DIFF,'-') > 0 )
        THEN '-' || SUBSTRING(DETAIL_SAGA_REPRICE_DIFF,1, INSTRB(DETAIL_SAGA_REPRICE_DIFF,'-') - 1)
        WHEN LENGTH(trim(DETAIL_SAGA_REPRICE_DIFF)) = 0
        THEN NULL
        ELSE DETAIL_SAGA_REPRICE_DIFF
    END::NUMBER(11,2),
    RCC,
    HCPC_PRCD,
    HCPC_MOD_1,
    HCPC_MOD_2,
    HCPC_MOD_3,
    HCPC_MOD_4,
    CASE
        WHEN(INSTRB(MCARE_ALLWD_AMT,'-') > 0 )
        THEN '-' || SUBSTRING(MCARE_ALLWD_AMT,1, INSTRB(MCARE_ALLWD_AMT,'-') - 1)
        WHEN LENGTH(trim(MCARE_ALLWD_AMT)) = 0
        THEN NULL
        ELSE MCARE_ALLWD_AMT
    END::NUMBER(11,2),
    CASE
        WHEN(INSTRB(MCARE_PAID_AMT,'-') > 0 )
        THEN '-' || SUBSTRING(MCARE_PAID_AMT,1, INSTRB(MCARE_PAID_AMT,'-') - 1)
        WHEN LENGTH(trim(MCARE_PAID_AMT)) = 0
        THEN NULL
        ELSE MCARE_PAID_AMT
    END::NUMBER(11,2),
    CASE
        WHEN(INSTRB(MCARE_COINS_AMT,'-') > 0 )
        THEN '-' || SUBSTRING(MCARE_COINS_AMT,1, INSTRB(MCARE_COINS_AMT,'-') - 1)
        WHEN LENGTH(trim(MCARE_COINS_AMT)) = 0
        THEN NULL
        ELSE MCARE_COINS_AMT
    END::NUMBER(11,2),
    CASE
        WHEN(INSTRB(MCARE_DEDUCT_AMT,'-') > 0 )
        THEN '-' || SUBSTRING(MCARE_DEDUCT_AMT,1, INSTRB(MCARE_DEDUCT_AMT,'-') - 1)
        WHEN LENGTH(trim(MCARE_DEDUCT_AMT)) = 0
        THEN NULL
        ELSE MCARE_DEDUCT_AMT
    END::NUMBER(11,2),
    CASE
        WHEN(INSTRB(DTL_MCAID_COINS_AMT,'-') > 0 )
        THEN '-' || SUBSTRING(DTL_MCAID_COINS_AMT,1, INSTRB(DTL_MCAID_COINS_AMT,'-') - 1)
        WHEN LENGTH(trim(DTL_MCAID_COINS_AMT)) = 0
        THEN NULL
        ELSE DTL_MCAID_COINS_AMT
    END::NUMBER(11,2),
    CASE
        WHEN(INSTRB(DTL_MCAID_DEDUCT_AMT,'-') > 0 )
        THEN '-' || SUBSTRING(DTL_MCAID_DEDUCT_AMT,1, INSTRB(DTL_MCAID_DEDUCT_AMT,'-') - 1)
        WHEN LENGTH(trim(DTL_MCAID_DEDUCT_AMT)) = 0
        THEN NULL
        ELSE DTL_MCAID_DEDUCT_AMT
    END::NUMBER(11,2),
    MCARE_MOD_1,
    MCARE_MOD_2,
    MCARE_MOD_3,
    MCARE_MOD_4,
    ATTD_PHYS_MCAID_DTL,
    OPER_PHYS_MCAID_DTL,
    PA_MODIFIER_DTL,
    PRIOR_AUTH_CTL_NO_DTL,
    BEHAVIOR_HEALTH_IND,
    ADMIT_DIAG,
    ECODE,
    PRIMARY_DIAG,
    OTHER_DIAG_2,
    OTHER_DIAG_3,
    OTHER_DIAG_4,
    PAT_ACCT_NUMBER,
    DISASTER_STATE,
    DISASTER_CODE,
    RETRO_ME_IND,
    HDR_OPER_PROV_NPI,
    HDR_ATTD_PROV_NPI,
    HDR_REFER_PROV_NPI,
    DTL_OPER_PROV_NPI,
    DTL_ATTD_PROV_NPI,
    DTL_PERF_PHYS_NPI,
    SAK_CLAIM,
    PCCM_IND,
    MFP_IND,
    IND_BH_IC,
    CASE
        WHEN(INSTRB(BIRTH_WT,'-') > 0 )
        THEN '-' || SUBSTRING(BIRTH_WT,1, INSTRB(BIRTH_WT,'-') - 1)
        WHEN LENGTH(trim(BIRTH_WT)) = 0
        THEN NULL
        ELSE BIRTH_WT
    END::NUMBER(11,2),
    CASE
        WHEN(INSTRB(HDR_COINS_AMT,'-') > 0 )
        THEN '-' || SUBSTRING(HDR_COINS_AMT,1, INSTRB(HDR_COINS_AMT,'-') - 1)
        WHEN LENGTH(trim(HDR_COINS_AMT)) = 0
        THEN NULL
        ELSE HDR_COINS_AMT
    END::NUMBER(11,2),
    CASE
        WHEN(INSTRB(HDR_DEDUCT_AMT,'-') > 0 )
        THEN '-' || SUBSTRING(HDR_DEDUCT_AMT,1, INSTRB(HDR_DEDUCT_AMT,'-') - 1)
        WHEN LENGTH(trim(HDR_DEDUCT_AMT)) = 0
        THEN NULL
        ELSE HDR_DEDUCT_AMT
    END::NUMBER(11,2),
    ENC_ICN_MCO,
    ENC_CLM_PRCS_TXCD,
    ENC_LN_ITM_STATUS,
    CASE
        WHEN LENGTH(trim(ENC_ADDT)) > 0
        AND ENC_ADDT <> '0000000'
        THEN timestampadd('d',substring(ENC_ADDT,5)::INTEGER-1, DATE(substring(ENC_ADDT,1,4)||
            '-01-01'))
        ELSE NULL
    END::DATE,
    CASE
        WHEN LENGTH(trim(ENC_CLM_PAY_DT_P)) > 0
        AND ENC_CLM_PAY_DT_P <> '00000000'
        THEN to_date(ENC_CLM_PAY_DT_P, 'YYYYMMDD')
    END,
    CASE
        WHEN(INSTRB(ENC_UNT_OF_SERV,'-') > 0 )
        THEN '-' || SUBSTRING(ENC_UNT_OF_SERV,1, INSTRB(ENC_UNT_OF_SERV,'-') - 1)
        WHEN LENGTH(trim(ENC_UNT_OF_SERV)) = 0
        THEN NULL
        ELSE ENC_UNT_OF_SERV
    END::NUMBER(12,3),
    CASE
        WHEN(INSTRB(ENC_REMB_AMT_P,'-') > 0 )
        THEN '-' || SUBSTRING(ENC_REMB_AMT_P,1, INSTRB(ENC_REMB_AMT_P,'-') - 1)
        WHEN LENGTH(trim(ENC_REMB_AMT_P)) = 0
        THEN NULL
        ELSE ENC_REMB_AMT_P
    END::NUMBER(11,2),
    CASE
        WHEN(INSTRB(ENC_DETAIL_PAID_AMT,'-') > 0 )
        THEN '-' || SUBSTRING(ENC_DETAIL_PAID_AMT,1, INSTRB(ENC_DETAIL_PAID_AMT,'-') - 1)
        WHEN LENGTH(trim(ENC_DETAIL_PAID_AMT)) = 0
        THEN NULL
        ELSE ENC_DETAIL_PAID_AMT
    END::NUMBER(11,2),
    CASE
        WHEN(INSTRB(ENC_ALW_CHG,'-') > 0 )
        THEN '-' || SUBSTRING(ENC_ALW_CHG,1, INSTRB(ENC_ALW_CHG,'-') - 1)
        WHEN LENGTH(trim(ENC_ALW_CHG)) = 0
        THEN NULL
        ELSE ENC_ALW_CHG
    END::NUMBER(11,2),
    CASE
        WHEN(INSTRB(ENC_TOT_COPAY,'-') > 0 )
        THEN '-' || SUBSTRING(ENC_TOT_COPAY,1, INSTRB(ENC_TOT_COPAY,'-') - 1)
        WHEN LENGTH(trim(ENC_TOT_COPAY)) = 0
        THEN NULL
        ELSE ENC_TOT_COPAY
    END::NUMBER(11,2),
    CASE
        WHEN(INSTRB(ENC_COPAY,'-') > 0 )
        THEN '-' || SUBSTRING(ENC_COPAY,1, INSTRB(ENC_COPAY,'-') - 1)
        WHEN LENGTH(trim(ENC_COPAY)) = 0
        THEN NULL
        ELSE ENC_COPAY
    END::NUMBER(11,2),
    CASE
        WHEN(INSTRB(ENC_HDR_COINS_AMT_MCO,'-') > 0 )
        THEN '-' || SUBSTRING(ENC_HDR_COINS_AMT_MCO,1, INSTRB(ENC_HDR_COINS_AMT_MCO,'-') - 1)
        WHEN LENGTH(trim(ENC_HDR_COINS_AMT_MCO)) = 0
        THEN NULL
        ELSE ENC_HDR_COINS_AMT_MCO
    END::NUMBER(11,2),
    CASE
        WHEN(INSTRB(ENC_DTL_COINS_AMT_MCO,'-') > 0 )
        THEN '-' || SUBSTRING(ENC_DTL_COINS_AMT_MCO,1, INSTRB(ENC_DTL_COINS_AMT_MCO,'-') - 1)
        WHEN LENGTH(trim(ENC_DTL_COINS_AMT_MCO)) = 0
        THEN NULL
        ELSE ENC_DTL_COINS_AMT_MCO
    END::NUMBER(11,2),
    CASE
        WHEN(INSTRB(ENC_HDR_DEDUCT_AMT_MCO,'-') > 0 )
        THEN '-' || SUBSTRING(ENC_HDR_DEDUCT_AMT_MCO,1, INSTRB(ENC_HDR_DEDUCT_AMT_MCO,'-') - 1)
        WHEN LENGTH(trim(ENC_HDR_DEDUCT_AMT_MCO)) = 0
        THEN NULL
        ELSE ENC_HDR_DEDUCT_AMT_MCO
    END::NUMBER(11,2),
    CASE
        WHEN(INSTRB(ENC_DTL_DEDUCT_AMT_MCO,'-') > 0 )
        THEN '-' || SUBSTRING(ENC_DTL_DEDUCT_AMT_MCO,1, INSTRB(ENC_DTL_DEDUCT_AMT_MCO,'-') - 1)
        WHEN LENGTH(trim(ENC_DTL_DEDUCT_AMT_MCO)) = 0
        THEN NULL
        ELSE ENC_DTL_DEDUCT_AMT_MCO
    END::NUMBER(11,2),
    CURRENT_TIMESTAMP(3),
    data_load_file_uuid_aud
FROM
    dss_stg.post_inst_claims_main_stg;

delete from dss_fuse.inst_claims_main_error_fuse  where data_load_file_uuid_aud='__DATALOAD_ID__';

INSERT /*+ DIRECT */ INTO dss_fuse.inst_claims_main_error_fuse 
  select * from dss_fuse.inst_claims_main_fuse
    where row_id  not in (SELECT   max(row_id)
FROM  dss_fuse.inst_claims_main_fuse
GROUP BY
INTNL_CTL_NO, CLM_PRCS_TXCD, SERVICE_LINE_NO, LN_ITM_STATUS);

delete from dss_fuse.inst_claims_main_fuse 
 where row_id  not in (SELECT   max(row_id)
 FROM  dss_fuse.inst_claims_main_fuse
 GROUP BY
 INTNL_CTL_NO, CLM_PRCS_TXCD, SERVICE_LINE_NO, LN_ITM_STATUS);

commit;

truncate table dss_fuse.inst_claims_location_fuse;
INSERT /*+ DIRECT */ INTO dss_fuse.inst_claims_location_fuse  
     select generate_uuid_fast(),ICN,SERVICE_LINE_NO,LN_ITM_STATUS,LOC_INFO_STATUS,
     CASE WHEN length(trim(LOC_INFO_STATUS_DT)) > 0 AND  LOC_INFO_STATUS_DT <> '00000000' THEN to_date(LOC_INFO_STATUS_DT, 'YYYYMMDD') END,
     CURRENT_TIMESTAMP(3), data_load_file_uuid_aud from dss_stg.post_inst_claims_location_stg;

delete from dss_fuse.inst_claims_location_error_fuse  where data_load_file_uuid_aud='__DATALOAD_ID__';

INSERT /*+ DIRECT */ INTO dss_fuse.inst_claims_location_error_fuse
 select * from dss_fuse.inst_claims_location_fuse
 where row_id  not in (SELECT   max(row_id)
 FROM  dss_fuse.inst_claims_location_fuse 
 GROUP BY 
 ICN,SERVICE_LINE_NO,LN_ITM_STATUS,LOC_INFO_STATUS,LOC_INFO_STATUS_DT);
 
delete from dss_fuse.inst_claims_location_fuse where row_id not in ( SELECT max(row_id) FROM dss_fuse.inst_claims_location_fuse GROUP BY 
 ICN,SERVICE_LINE_NO,LN_ITM_STATUS,LOC_INFO_STATUS,LOC_INFO_STATUS_DT);
commit;
     
truncate table dss_fuse.inst_claims_surgery_fuse;
INSERT /*+ DIRECT */ INTO dss_fuse.inst_claims_surgery_fuse
     select generate_uuid_fast(),ICN,SERVICE_LINE_NO,LN_ITM_STATUS,SURG_TY_SVC,SURG_PRCD_QUAL,SURG_PRCD,
     CASE WHEN length(trim(DT_OF_SURG)) > 0 AND  DT_OF_SURG <> '00000000' THEN to_date(DT_OF_SURG, 'YYYYMMDD') END,
     CURRENT_TIMESTAMP(3), data_load_file_uuid_aud from dss_stg.post_inst_claims_surgery_stg; 

delete from dss_fuse.inst_claims_surgery_error_fuse  where data_load_file_uuid_aud='__DATALOAD_ID__';
 
INSERT /*+ DIRECT */ INTO dss_fuse.inst_claims_surgery_error_fuse
  select * from dss_fuse.inst_claims_surgery_fuse
  where row_id  not in (SELECT   max(row_id)
  FROM  dss_fuse.inst_claims_surgery_fuse
  GROUP BY 
  ICN,SERVICE_LINE_NO,LN_ITM_STATUS,SURG_TY_SVC,SURG_PRCD_QUAL,SURG_PRCD,DT_OF_SURG);
 
delete from dss_fuse.inst_claims_surgery_fuse 
  where row_id not in ( SELECT max(row_id) 
  FROM dss_fuse.inst_claims_surgery_fuse 
  GROUP BY 
  ICN,SERVICE_LINE_NO,LN_ITM_STATUS,SURG_TY_SVC,SURG_PRCD_QUAL,SURG_PRCD,DT_OF_SURG);
commit;
     
truncate table dss_fuse.inst_claims_occurance_fuse;
INSERT /*+ DIRECT */ INTO dss_fuse.inst_claims_occurance_fuse
      select generate_uuid_fast(),ICN,SERVICE_LINE_NO,LN_ITM_STATUS,OCCURENCE_CODE,
      CASE WHEN length(trim(OCCURENCE_DT)) > 0 AND  OCCURENCE_DT <> '00000000' THEN to_date(OCCURENCE_DT, 'YYYYMMDD') END,
      CURRENT_TIMESTAMP(3), data_load_file_uuid_aud from dss_stg.post_inst_claims_occurance_stg; 

delete from dss_fuse.inst_claims_occurance_error_fuse  where data_load_file_uuid_aud='__DATALOAD_ID__';
 
INSERT /*+ DIRECT */ INTO dss_fuse.inst_claims_occurance_error_fuse
  select * from dss_fuse.inst_claims_occurance_fuse
  where row_id  not in (SELECT   max(row_id)
  FROM  dss_fuse.inst_claims_occurance_fuse
  GROUP BY 
  ICN,SERVICE_LINE_NO,LN_ITM_STATUS,OCCURENCE_CODE,OCCURENCE_DT);
  
delete from dss_fuse.inst_claims_occurance_fuse 
  where row_id not in ( SELECT max(row_id) 
  FROM dss_fuse.inst_claims_occurance_fuse 
  GROUP BY 
  ICN,SERVICE_LINE_NO,LN_ITM_STATUS,OCCURENCE_CODE,OCCURENCE_DT);
commit;
      
truncate table dss_fuse.inst_claims_commit_err_fuse;
INSERT /*+ DIRECT */ INTO dss_fuse.inst_claims_commit_err_fuse
      select generate_uuid_fast(),ICN,SERVICE_LINE_NO,LN_ITM_STATUS,commit_err_cd,CURRENT_TIMESTAMP(3), data_load_file_uuid_aud from dss_stg.post_inst_claims_commit_err_stg; 

delete from dss_fuse.inst_claims_commit_err_error_fuse  where data_load_file_uuid_aud='__DATALOAD_ID__';
      
INSERT /*+ DIRECT */ INTO dss_fuse.inst_claims_commit_err_error_fuse
  select * from dss_fuse.inst_claims_commit_err_fuse
  where row_id  not in (SELECT   max(row_id)
  FROM  dss_fuse.inst_claims_commit_err_fuse
  GROUP BY 
  ICN,SERVICE_LINE_NO,LN_ITM_STATUS,commit_err_cd);

delete from dss_fuse.inst_claims_commit_err_fuse 
  where row_id not in ( SELECT max(row_id) 
  FROM dss_fuse.inst_claims_commit_err_fuse 
  GROUP BY 
  ICN,SERVICE_LINE_NO,LN_ITM_STATUS,commit_err_cd);
commit;
      
truncate table  dss_fuse.inst_claims_cond_codes_fuse;
 INSERT /*+ DIRECT */ INTO dss_fuse.inst_claims_cond_codes_fuse
      select generate_uuid_fast(),ICN,SERVICE_LINE_NO,LN_ITM_STATUS,COND_CODE,CURRENT_TIMESTAMP(3), data_load_file_uuid_aud from dss_stg.post_inst_claims_cond_codes_stg; 

delete from dss_fuse.inst_claims_cond_codes_error_fuse  where data_load_file_uuid_aud='__DATALOAD_ID__';

INSERT /*+ DIRECT */ INTO dss_fuse.inst_claims_cond_codes_error_fuse
  select * from dss_fuse.inst_claims_cond_codes_fuse
  where row_id  not in (SELECT   max(row_id)
  FROM  dss_fuse.inst_claims_cond_codes_fuse
  GROUP BY 
  ICN,SERVICE_LINE_NO,LN_ITM_STATUS,COND_CODE);

delete from dss_fuse.inst_claims_cond_codes_fuse 
  where row_id not in ( SELECT max(row_id) 
  FROM dss_fuse.inst_claims_cond_codes_fuse 
  GROUP BY 
  ICN,SERVICE_LINE_NO,LN_ITM_STATUS,COND_CODE);
commit;
      
truncate table  dss_fuse.inst_claims_current_err_fuse;
 INSERT /*+ DIRECT */ INTO dss_fuse.inst_claims_current_err_fuse
      select generate_uuid_fast(),ICN,SERVICE_LINE_NO,LN_ITM_STATUS,ERR_CD_DISP,ERR_CD_N,ERR_CD_LN_NO,CURRENT_TIMESTAMP(3), data_load_file_uuid_aud from dss_stg.post_inst_claims_current_err_stg; 
      
delete from dss_fuse.inst_claims_current_err_error_fuse  where data_load_file_uuid_aud='__DATALOAD_ID__';      

INSERT /*+ DIRECT */ INTO dss_fuse.inst_claims_current_err_error_fuse
  select * from dss_fuse.inst_claims_current_err_fuse
  where row_id  not in (SELECT   max(row_id)
  FROM  dss_fuse.inst_claims_current_err_fuse
  GROUP BY 
  ICN,SERVICE_LINE_NO,LN_ITM_STATUS,ERR_CD_DISP,ERR_CD_N,ERR_CD_LN_NO);
    
delete from dss_fuse.inst_claims_current_err_fuse 
  where row_id not in ( SELECT max(row_id) 
  FROM dss_fuse.inst_claims_current_err_fuse 
  GROUP BY 
  ICN,SERVICE_LINE_NO,LN_ITM_STATUS,ERR_CD_DISP,ERR_CD_N,ERR_CD_LN_NO);
commit;

