CREATE TABLE raw.raw_ainv_asset_transfer_out_hdr
(
      Raw_ID BIGINT PRIMARY KEY NOT NULL GENERATED ALWAYS AS IDENTITY
    ,      tran_type VARCHAR(40) COLLATE NOCASE NOT NULL
    , tran_ou INT NOT NULL
    , tran_no VARCHAR(72) COLLATE NOCASE NOT NULL
    , no_type VARCHAR(40) COLLATE NOCASE NULL
    , status VARCHAR(100) COLLATE NOCASE NULL
    , confirm_reqd VARCHAR(48) COLLATE NOCASE NULL
    , tax_amount NUMERIC NULL
    , transfer_date VARCHAR(100) COLLATE NOCASE NULL
    , tcal_status VARCHAR(48) COLLATE NOCASE NULL
    , tcal_exclusive_amt NUMERIC NULL
    , total_tcal_amount NUMERIC NULL
    , transfer_in_no VARCHAR(72) COLLATE NOCASE NULL
    , receipt_date TIMESTAMP NULL
    , transfer_in_status VARCHAR(100) COLLATE NOCASE NULL
    , tcal_status_in VARCHAR(48) COLLATE NOCASE NULL
    , tcal_exclusive_amt_in NUMERIC NULL
    , total_tcal_amount_in NUMERIC NULL
    , timestamp INT NULL
    , no_type_in VARCHAR(40) COLLATE NOCASE NULL
    , createdby VARCHAR(120) COLLATE NOCASE NULL
    , createddate VARCHAR(100) COLLATE NOCASE NULL
    , modifiedby VARCHAR(120) COLLATE NOCASE NULL
    , modifieddate VARCHAR(100) COLLATE NOCASE NULL
    , transfer_in_ou INT NULL
	, etlcreateddatetime TIMESTAMP(3) DEFAULT NOW()
	, CONSTRAINT ainv_asset_transfer_out_hdr_pk UNIQUE (Raw_ID)
);
