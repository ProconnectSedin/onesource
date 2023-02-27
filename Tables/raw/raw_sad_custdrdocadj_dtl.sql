CREATE TABLE raw.raw_sad_custdrdocadj_dtl
(
      Raw_ID BIGINT PRIMARY KEY NOT NULL GENERATED ALWAYS AS IDENTITY
    ,      ou_id INT NOT NULL
    , adjustment_no VARCHAR(72) COLLATE NOCASE NOT NULL
    , dr_doc_ou INT NOT NULL
    , dr_doc_type VARCHAR(160) COLLATE NOCASE NOT NULL
    , dr_doc_no VARCHAR(72) COLLATE NOCASE NOT NULL
    , term_no VARCHAR(80) COLLATE NOCASE NOT NULL
    , au_due_date TIMESTAMP NULL
    , au_dr_doc_unadj_amt NUMERIC NULL
    , au_cust_code VARCHAR(72) COLLATE NOCASE NULL
    , au_dr_doc_cur VARCHAR(20) COLLATE NOCASE NULL
    , au_crosscur_erate NUMERIC NULL
    , discount NUMERIC NULL
    , charges NUMERIC NULL
    , writeoff_amount NUMERIC NULL
    , dr_doc_adj_amt NUMERIC NULL
    , proposed_discount NUMERIC NULL
    , proposed_charges NUMERIC NULL
    , au_discount_date TIMESTAMP NULL
    , au_billing_point INT NULL
    , au_dr_doc_date TIMESTAMP NULL
    , au_fb_id VARCHAR(80) COLLATE NOCASE NULL
    , cost_center VARCHAR(40) COLLATE NOCASE NULL
    , analysis_code VARCHAR(20) COLLATE NOCASE NULL
    , subanalysis_code VARCHAR(20) COLLATE NOCASE NULL
    , guid VARCHAR(512) COLLATE NOCASE NULL
    , au_base_exrate NUMERIC NULL
    , au_par_base_exrate NUMERIC NULL
    , au_disc_available NUMERIC NULL
    , adjustment_amt NUMERIC NULL
      , etlcreateddatetime TIMESTAMP(3) DEFAULT NOW()
      , CONSTRAINT PK__sad_cust__3F15CF30366C5A8A UNIQUE(Raw_ID)
);

