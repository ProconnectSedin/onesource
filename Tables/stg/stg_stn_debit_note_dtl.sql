-- Table: stg.stg_stn_debit_note_dtl

-- DROP TABLE IF EXISTS stg.stg_stn_debit_note_dtl;

CREATE TABLE IF NOT EXISTS stg.stg_stn_debit_note_dtl
(
    ou_id integer NOT NULL,
    trns_debit_note character varying(72) COLLATE public.nocase NOT NULL,
    tran_type character varying(40) COLLATE public.nocase NOT NULL,
    "timestamp" integer NOT NULL,
    notype_no character varying(40) COLLATE public.nocase,
    transfer_docno character varying(72) COLLATE public.nocase,
    tran_date timestamp without time zone,
    supplier_code character varying(64) COLLATE public.nocase,
    currency_code character varying(20) COLLATE public.nocase,
    account_code character varying(128) COLLATE public.nocase,
    fb_id character varying(80) COLLATE public.nocase,
    tran_amount numeric,
    cost_center character varying(40) COLLATE public.nocase,
    analysis_code character varying(20) COLLATE public.nocase,
    subanalysis_code character varying(20) COLLATE public.nocase,
    exchange_rate numeric,
    pbcur_erate numeric,
    transferred_amt numeric,
    reason_code character varying(40) COLLATE public.nocase,
    comments character varying(1024) COLLATE public.nocase,
    ref_doc_no character varying(72) COLLATE public.nocase,
    status character varying(8) COLLATE public.nocase,
    crosscur_erate numeric,
    base_amount numeric,
    par_base_amt numeric,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    batch_id character varying(512) COLLATE public.nocase,
    project_ou integer,
    project_code character varying(280) COLLATE public.nocase,
    rev_doc_ou integer,
    rev_doc_no character varying(72) COLLATE public.nocase,
    rev_doc_date timestamp without time zone,
    rev_reasoncode character varying(40) COLLATE public.nocase,
    rev_remarks character varying(400) COLLATE public.nocase,
    rev_doc_trantype character varying(160) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT stn_debit_note_dtl_pkey PRIMARY KEY (ou_id, trns_debit_note, tran_type)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_stn_debit_note_dtl
    OWNER to proconnect;
-- Index: stg_stn_debit_note_dtl_idx

-- DROP INDEX IF EXISTS stg.stg_stn_debit_note_dtl_idx;

CREATE INDEX IF NOT EXISTS stg_stn_debit_note_dtl_idx
    ON stg.stg_stn_debit_note_dtl USING btree
    (ou_id ASC NULLS LAST, trns_debit_note COLLATE public.nocase ASC NULLS LAST, tran_type COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;