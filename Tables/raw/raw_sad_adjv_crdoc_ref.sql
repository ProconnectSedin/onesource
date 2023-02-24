CREATE TABLE raw.raw_sad_adjv_crdoc_ref
(
      Raw_ID BIGINT PRIMARY KEY NOT NULL GENERATED ALWAYS AS IDENTITY
    ,      parent_key VARCHAR(512) COLLATE NOCASE NOT NULL
    , ref_cr_doc_no VARCHAR(72) COLLATE NOCASE NOT NULL
    , cr_doc_ou INT NOT NULL
    , cr_doc_type VARCHAR(160) COLLATE NOCASE NOT NULL
    , term_no VARCHAR(80) COLLATE NOCASE NOT NULL
    , sale_ord_ref VARCHAR(72) COLLATE NOCASE NULL
    , cr_doc_adj_amt NUMERIC NULL
    , au_cr_doc_unadj_amt NUMERIC NULL
    , tran_type VARCHAR(160) COLLATE NOCASE NULL
    , cross_cur_erate NUMERIC NULL
    , cr_discount NUMERIC NULL
    , guid VARCHAR(512) COLLATE NOCASE NULL
      , etlcreateddatetime TIMESTAMP(3) DEFAULT NOW()
      , CONSTRAINT sad_adjv_crdoc_ref_pkey UNIQUE(Raw_ID)
);