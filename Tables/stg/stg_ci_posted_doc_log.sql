-- Table: stg.stg_ci_posted_doc_log

-- DROP TABLE IF EXISTS stg.stg_ci_posted_doc_log;

CREATE TABLE IF NOT EXISTS stg.stg_ci_posted_doc_log
(
    tran_ou integer NOT NULL,
    tran_type character varying(40) COLLATE public.nocase NOT NULL,
    tran_no character varying(72) COLLATE public.nocase NOT NULL,
    term_no character varying(80) COLLATE public.nocase NOT NULL,
    amt_type character varying(40) COLLATE public.nocase NOT NULL,
    ref_doc_ou integer NOT NULL,
    ref_doc_type character varying(40) COLLATE public.nocase NOT NULL,
    ref_doc_no character varying(72) COLLATE public.nocase NOT NULL,
    ref_doc_term character varying(80) COLLATE public.nocase NOT NULL,
    adjd_doc_ou integer NOT NULL,
    adjd_doc_type character varying(40) COLLATE public.nocase NOT NULL,
    adjd_doc_no character varying(72) COLLATE public.nocase NOT NULL,
    adjd_doc_term character varying(80) COLLATE public.nocase NOT NULL,
    createddate timestamp without time zone NOT NULL,
    "timestamp" integer NOT NULL,
    lo_id character varying(80) COLLATE public.nocase,
    batch_id character varying(512) COLLATE public.nocase,
    tran_date timestamp without time zone,
    cust_code character varying(72) COLLATE public.nocase,
    tran_currency character varying(20) COLLATE public.nocase,
    tran_amount numeric,
    basecur_erate numeric,
    base_amount numeric,
    par_exchange_rate numeric,
    par_base_amount numeric,
    ref_doc_date timestamp without time zone,
    ref_doc_cur character varying(20) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    posting_status character varying(4) COLLATE public.nocase,
    posting_date timestamp without time zone,
    crosscur_erate numeric,
    adjust_amount_inv_cur numeric,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    account_code character varying(128) COLLATE public.nocase,
    account_type character varying(60) COLLATE public.nocase NOT NULL,
    fb_id character varying(80) COLLATE public.nocase,
    discount_amount numeric,
    penalty_amount numeric,
    writeoff_amount numeric,
    received_amount numeric,
    doc_status character varying(100) COLLATE public.nocase,
    receipt_type character varying(100) COLLATE public.nocase,
    tds_amount numeric,
    base_adjust_amt numeric,
    pbase_adjust_amt numeric,
    base_received_amount numeric,
    pbase_received_amount numeric,
    base_writeoff_amount numeric,
    pbase_writeoff_amount numeric,
    provision_amt numeric,
    bookingno character varying(280) COLLATE public.nocase,
    masterbillofladingno character varying(280) COLLATE public.nocase,
    billofladingno character varying(280) COLLATE public.nocase,
    log_pdc_status character varying(100) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT ci_posted_doc_log_pkey UNIQUE (tran_ou, tran_type, tran_no, term_no, amt_type, ref_doc_ou, ref_doc_type, ref_doc_no, ref_doc_term, adjd_doc_ou, adjd_doc_type, adjd_doc_no, adjd_doc_term, createddate, account_type)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_ci_posted_doc_log
    OWNER to proconnect;
-- Index: stg_ci_posted_doc_log_key_idx2

-- DROP INDEX IF EXISTS stg.stg_ci_posted_doc_log_key_idx2;

CREATE INDEX IF NOT EXISTS stg_ci_posted_doc_log_key_idx2
    ON stg.stg_ci_posted_doc_log USING btree
    (tran_ou ASC NULLS LAST, tran_type COLLATE public.nocase ASC NULLS LAST, tran_no COLLATE public.nocase ASC NULLS LAST, term_no COLLATE public.nocase ASC NULLS LAST, amt_type COLLATE public.nocase ASC NULLS LAST, ref_doc_ou ASC NULLS LAST, ref_doc_type COLLATE public.nocase ASC NULLS LAST, ref_doc_no COLLATE public.nocase ASC NULLS LAST, ref_doc_term COLLATE public.nocase ASC NULLS LAST, adjd_doc_ou ASC NULLS LAST, adjd_doc_type COLLATE public.nocase ASC NULLS LAST, adjd_doc_no COLLATE public.nocase ASC NULLS LAST, adjd_doc_term COLLATE public.nocase ASC NULLS LAST, createddate ASC NULLS LAST, account_type COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;