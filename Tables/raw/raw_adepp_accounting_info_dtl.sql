CREATE TABLE raw.raw_adepp_accounting_info_dtl
(
      Raw_ID BIGINT PRIMARY KEY NOT NULL GENERATED ALWAYS AS IDENTITY
    ,      timestamp INT NOT NULL
    , ou_id INT NULL
    , company_code VARCHAR(40) COLLATE NOCASE NULL
    , tran_number VARCHAR(72) COLLATE NOCASE NULL
    , asset_number VARCHAR(72) COLLATE NOCASE NULL
    , tag_number INT NULL
    , tran_type VARCHAR(160) COLLATE NOCASE NULL
    , tran_date TIMESTAMP NULL
    , posting_date TIMESTAMP NULL
    , account_code VARCHAR(128) COLLATE NOCASE NULL
    , drcr_flag VARCHAR(24) COLLATE NOCASE NULL
    , currency VARCHAR(20) COLLATE NOCASE NULL
    , tran_amount NUMERIC NULL
    , fb_id VARCHAR(80) COLLATE NOCASE NULL
    , bu_id VARCHAR(80) COLLATE NOCASE NULL
    , cost_center VARCHAR(40) COLLATE NOCASE NULL
    , analysis_code VARCHAR(20) COLLATE NOCASE NULL
    , sub_analysis_code VARCHAR(20) COLLATE NOCASE NULL
    , bc_erate NUMERIC NULL
    , base_amount NUMERIC NULL
    , pbc_erate NUMERIC NULL
    , pbase_amount NUMERIC NULL
    , account_type VARCHAR(160) COLLATE NOCASE NULL
    , fin_period VARCHAR(40) COLLATE NOCASE NULL
    , createdby VARCHAR(120) COLLATE NOCASE NULL
    , createddate TIMESTAMP NULL
    , modifiedby VARCHAR(120) COLLATE NOCASE NULL
    , modifieddate TIMESTAMP NULL
    , batch_id VARCHAR(512) COLLATE NOCASE NULL
    , depr_book VARCHAR(80) COLLATE NOCASE NULL
    , etlcreateddatetime TIMESTAMP(3) DEFAULT NOW()
     , CONSTRAINT raw_adepp_accounting_info_dtl_pkey UNIQUE(Raw_ID)

);
