CREATE TABLE raw.raw_acap_tag_doc_dtl
(
      Raw_ID BIGINT PRIMARY KEY NOT NULL GENERATED ALWAYS AS IDENTITY
    ,      ou_id INT NOT NULL
    , fb_id VARCHAR(80) COLLATE NOCASE NOT NULL
    , cap_number VARCHAR(72) COLLATE NOCASE NOT NULL
    , asset_number VARCHAR(72) COLLATE NOCASE NOT NULL
    , tag_number INT NOT NULL
    , doc_number VARCHAR(72) COLLATE NOCASE NOT NULL
    , line_no INT NOT NULL
    , account_code VARCHAR(128) COLLATE NOCASE NOT NULL
    , timestamp INT NULL
    , doc_amount NUMERIC NULL
    , doc_type VARCHAR(160) COLLATE NOCASE NOT NULL
    , cap_amount NUMERIC NULL
    , proposal_number VARCHAR(72) COLLATE NOCASE NULL
    , createdby VARCHAR(120) COLLATE NOCASE NULL
    , createddate TIMESTAMP NULL
    , modifiedby VARCHAR(120) COLLATE NOCASE NULL
    , modifieddate TIMESTAMP NULL
    , tran_ou INT NULL
    , tran_type VARCHAR(40) COLLATE NOCASE NULL
    , tag_cost NUMERIC NULL
    , Project_code VARCHAR(280) COLLATE NOCASE NULL
    , Cost_Center VARCHAR(40) COLLATE NOCASE NULL
    , etlcreateddatetime TIMESTAMP(3) DEFAULT NOW()
    , CONSTRAINT acap_tag_doc_dtl_pkey UNIQUE(Raw_ID)
);
