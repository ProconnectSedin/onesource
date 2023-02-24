CREATE TABLE raw.raw_acap_asset_tag_dtl
(
      Raw_ID BIGINT PRIMARY KEY NOT NULL GENERATED ALWAYS AS IDENTITY
    ,      ou_id INT NOT NULL
    , asset_number VARCHAR(72) COLLATE NOCASE NOT NULL
    , tag_number INT NOT NULL
    , cap_number VARCHAR(72) COLLATE NOCASE NOT NULL
    , fb_id VARCHAR(80) COLLATE NOCASE NOT NULL
    , timestamp INT NULL
    , asset_desc VARCHAR(160) COLLATE NOCASE NULL
    , tag_desc VARCHAR(160) COLLATE NOCASE NULL
    , asset_location VARCHAR(80) COLLATE NOCASE NULL
    , cost_center VARCHAR(40) COLLATE NOCASE NULL
    , inservice_date TIMESTAMP NULL
    , tag_cost NUMERIC NULL
    , proposal_number VARCHAR(72) COLLATE NOCASE NULL
    , tag_status VARCHAR(100) COLLATE NOCASE NULL
    , depr_category VARCHAR(160) COLLATE NOCASE NULL
    , inv_cycle VARCHAR(60) COLLATE NOCASE NULL
    , salvage_value NUMERIC NULL
    , manufacturer VARCHAR(240) COLLATE NOCASE NULL
    , bar_code VARCHAR(72) COLLATE NOCASE NULL
    , serial_no VARCHAR(72) COLLATE NOCASE NULL
    , warranty_no VARCHAR(72) COLLATE NOCASE NULL
    , model VARCHAR(160) COLLATE NOCASE NULL
    , custodian VARCHAR(308) COLLATE NOCASE NULL
    , business_use NUMERIC NULL
    , reverse_remarks VARCHAR(400) COLLATE NOCASE NULL
    , book_value NUMERIC NULL
    , revalued_cost NUMERIC NULL
    , inv_date TIMESTAMP NULL
    , inv_due_date TIMESTAMP NULL
    , inv_status VARCHAR(100) COLLATE NOCASE NULL
    , softrev_run_no VARCHAR(80) COLLATE NOCASE NULL
    , insurable_value NUMERIC NULL
    , policy_count VARCHAR(16) COLLATE NOCASE NULL
    , dest_fbid VARCHAR(80) COLLATE NOCASE NULL
    , transfer_date TIMESTAMP NULL
    , legacy_asset_no VARCHAR(72) COLLATE NOCASE NULL
    , migration_status VARCHAR(100) COLLATE NOCASE NULL
    , tag_cost_orig NUMERIC NULL
    , tag_cost_diff NUMERIC NULL
    , createdby VARCHAR(120) COLLATE NOCASE NULL
    , createddate TIMESTAMP NULL
    , modifiedby VARCHAR(120) COLLATE NOCASE NULL
    , modifieddate TIMESTAMP NULL
    , amend_status VARCHAR(100) COLLATE NOCASE NULL
    , residualvalue NUMERIC NULL
    , usefullifeinmonths INT NULL
    , Remaining_loy INT NULL
    , Remaining_lom INT NULL
    , Remaining_lod INT NULL
    , CUMDEP NUMERIC NULL
    , assign_date TIMESTAMP NULL
    , loan_mapped VARCHAR(4) COLLATE NOCASE NULL
    , LAccount_code VARCHAR(128) COLLATE NOCASE NULL
    , LAccount_desc VARCHAR(240) COLLATE NOCASE NULL
    , Lcost_center VARCHAR(40) COLLATE NOCASE NULL
    , LAnalysis_code VARCHAR(20) COLLATE NOCASE NULL
    , LSubAnalysis_code VARCHAR(20) COLLATE NOCASE NULL
    , asset_category VARCHAR(1020) COLLATE NOCASE NULL
    , asset_cluster VARCHAR(1020) COLLATE NOCASE NULL
    , asset_capacity NUMERIC NULL
    , asset_capacity_uom VARCHAR(40) COLLATE NOCASE NULL
    , etlcreateddatetime TIMESTAMP(3) DEFAULT NOW()
    , CONSTRAINT acap_asset_tag_dtl_pkey UNIQUE(Raw_ID)
);
