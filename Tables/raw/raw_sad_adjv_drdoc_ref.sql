CREATE TABLE raw.raw_sad_adjv_drdoc_ref
(
      Raw_ID BIGINT PRIMARY KEY NOT NULL GENERATED ALWAYS AS IDENTITY
    ,      parent_key VARCHAR(512) COLLATE NOCASE NOT NULL
    , ref_dr_doc_no VARCHAR(72) COLLATE NOCASE NOT NULL
    , dr_doc_ou INT NOT NULL
    , dr_doc_type VARCHAR(160) COLLATE NOCASE NOT NULL
    , term_no VARCHAR(80) COLLATE NOCASE NOT NULL
    , dr_doc_adj_amt NUMERIC NULL
    , dr_doc_unadj_amt NUMERIC NULL
    , tran_type VARCHAR(160) COLLATE NOCASE NULL
    , discount NUMERIC NULL
    , guid VARCHAR(512) COLLATE NOCASE NULL
      , etlcreateddatetime TIMESTAMP(3) DEFAULT NOW()
      , CONSTRAINT sad_adjv_drdoc_ref_pkey UNIQUE(Raw_ID)
);
