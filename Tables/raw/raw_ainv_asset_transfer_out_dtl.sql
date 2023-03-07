CREATE TABLE raw.raw_ainv_asset_transfer_out_dtl
(
      Raw_ID BIGINT PRIMARY KEY NOT NULL GENERATED ALWAYS AS IDENTITY
    ,      tran_type VARCHAR(40) COLLATE NOCASE NOT NULL
    , tran_ou INT NOT NULL
    , tran_no VARCHAR(72) COLLATE NOCASE NOT NULL
    , fb VARCHAR(80) COLLATE NOCASE NULL
    , asset_number VARCHAR(72) COLLATE NOCASE NULL
    , tag_number INT NULL
    , recv_loc_code VARCHAR(80) COLLATE NOCASE NULL
    , recv_cost_center VARCHAR(40) COLLATE NOCASE NULL
    , asset_loc_code VARCHAR(80) COLLATE NOCASE NULL
    , cost_center VARCHAR(40) COLLATE NOCASE NULL
    , confirm_date VARCHAR(100) COLLATE NOCASE NULL
    , confirm_status VARCHAR(100) COLLATE NOCASE NULL
    , dest_ouid INT NULL
    , book_value NUMERIC NULL
    , par_base_book_value NUMERIC NULL
    , exchange_rate NUMERIC NULL
    , par_exchange_rate NUMERIC NULL
    , tran_currency VARCHAR(20) COLLATE NOCASE NULL
    , remarks VARCHAR(1020) COLLATE NOCASE NULL
    , line_no INT NULL
    , transfer_in_no VARCHAR(72) COLLATE NOCASE NULL
    , transfer_in_ou INT NULL
	, etlcreateddatetime TIMESTAMP(3) DEFAULT NOW()
	, CONSTRAINT raw_ainv_asset_transfer_out_dtl_pk UNIQUE (Raw_ID)
);