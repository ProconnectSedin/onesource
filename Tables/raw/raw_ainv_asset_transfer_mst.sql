CREATE TABLE raw.raw_ainv_asset_transfer_mst
(
      Raw_ID BIGINT PRIMARY KEY NOT NULL GENERATED ALWAYS AS IDENTITY
    ,      timestamp INT NULL
    , ou_id INT NULL
    , transfer_date TIMESTAMP NULL
    , asset_number VARCHAR(72) COLLATE NOCASE NULL
    , tag_number INT NULL
    , recv_loc_code VARCHAR(80) COLLATE NOCASE NULL
    , recv_cost_center VARCHAR(40) COLLATE NOCASE NULL
    , remarks VARCHAR(1020) COLLATE NOCASE NULL
    , asset_loc_code VARCHAR(80) COLLATE NOCASE NULL
    , cost_center VARCHAR(40) COLLATE NOCASE NULL
    , asset_class_code VARCHAR(80) COLLATE NOCASE NULL
    , asset_group_code VARCHAR(100) COLLATE NOCASE NULL
    , asset_desc VARCHAR(160) COLLATE NOCASE NULL
    , tag_desc VARCHAR(160) COLLATE NOCASE NULL
    , confirm_reqd VARCHAR(48) COLLATE NOCASE NULL
    , confirm_date TIMESTAMP NULL
    , confirm_status VARCHAR(100) COLLATE NOCASE NULL
    , bu_id VARCHAR(80) COLLATE NOCASE NULL
    , createdby VARCHAR(120) COLLATE NOCASE NULL
    , createddate TIMESTAMP NULL
    , modifiedby VARCHAR(120) COLLATE NOCASE NULL
    , modifieddate TIMESTAMP NULL
    , dest_ouid INT NULL
    , line_no INT NULL
    , tran_out_no VARCHAR(72) COLLATE NOCASE NULL
    , tran_in_no VARCHAR(72) COLLATE NOCASE NULL
	, etlcreateddatetime TIMESTAMP(3) DEFAULT NOW()
	,CONSTRAINT raw_ainv_asset_transfer_mst_pk UNIQUE (Raw_ID)
);
