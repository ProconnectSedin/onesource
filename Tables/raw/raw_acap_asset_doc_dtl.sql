CREATE TABLE raw.raw_acap_asset_doc_dtl
(
      Raw_ID BIGINT PRIMARY KEY NOT NULL GENERATED ALWAYS AS IDENTITY
    ,      ou_id INT NOT NULL
    , cap_number VARCHAR(72) COLLATE NOCASE NOT NULL
    , asset_number VARCHAR(72) COLLATE NOCASE NOT NULL
    , doc_type VARCHAR(160) COLLATE NOCASE NOT NULL
    , doc_number VARCHAR(72) COLLATE NOCASE NOT NULL
    , supplier_name VARCHAR(240) COLLATE NOCASE NULL
    , timestamp INT NULL
    , doc_date TIMESTAMP NULL
    , doc_amount NUMERIC NULL
    , pending_cap_amt NUMERIC NULL
    , proposal_number VARCHAR(72) COLLATE NOCASE NULL
    , gr_date TIMESTAMP NULL
    , currency VARCHAR(20) COLLATE NOCASE NULL
    , exchange_rate NUMERIC NULL
    , cap_amount NUMERIC NULL
    , finance_bookid VARCHAR(80) COLLATE NOCASE NULL
    , doc_status VARCHAR(100) COLLATE NOCASE NULL
    , createdby VARCHAR(120) COLLATE NOCASE NULL
    , createddate TIMESTAMP NULL
    , modifiedby VARCHAR(120) COLLATE NOCASE NULL
    , modifieddate TIMESTAMP NULL
    , tran_ou INT NULL
    , tran_type VARCHAR(40) COLLATE NOCASE NULL
    , cap_flag VARCHAR(48) COLLATE NOCASE NULL
    , etlcreateddatetime TIMESTAMP(3) DEFAULT NOW()
    , CONSTRAINT acap_asset_doc_dtl_pkey UNIQUE(Raw_ID)
);
