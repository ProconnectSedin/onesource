CREATE TABLE raw.raw_acap_asset_doc_line_dtl
(
      Raw_ID BIGINT PRIMARY KEY NOT NULL GENERATED ALWAYS AS IDENTITY
    ,      ou_id INT NOT NULL
    , cap_number VARCHAR(72) COLLATE NOCASE NOT NULL
    , asset_number VARCHAR(72) COLLATE NOCASE NOT NULL
    , doc_type VARCHAR(160) COLLATE NOCASE NOT NULL
    , doc_number VARCHAR(72) COLLATE NOCASE NOT NULL
    , line_no INT NOT NULL
    , timestamp INT NULL
    , proposal_number VARCHAR(72) COLLATE NOCASE NULL
    , doc_amount NUMERIC NULL
    , pending_cap_amt NUMERIC NULL
    , cap_amount NUMERIC NULL
    , tag_group VARCHAR(24) COLLATE NOCASE NULL
    , doc_date TIMESTAMP NULL
    , createdby VARCHAR(120) COLLATE NOCASE NULL
    , createddate TIMESTAMP NULL
    , modifiedby VARCHAR(120) COLLATE NOCASE NULL
    , modifieddate TIMESTAMP NULL
    , etlcreateddatetime TIMESTAMP(3) DEFAULT NOW()
    , CONSTRAINT acap_asset_doc_line_dtl_pkey UNIQUE(Raw_ID)
);
