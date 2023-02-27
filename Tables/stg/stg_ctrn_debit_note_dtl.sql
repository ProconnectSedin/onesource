-- Table: stg.stg_ctrn_debit_note_dtl

-- DROP TABLE IF EXISTS stg.stg_ctrn_debit_note_dtl;

CREATE TABLE IF NOT EXISTS stg.stg_ctrn_debit_note_dtl
(
    ou_id integer NOT NULL,
    tdn_no character varying(72) COLLATE public.nocase NOT NULL,
    "timestamp" integer NOT NULL,
    transfer_doc_no character varying(72) COLLATE public.nocase,
    tran_date timestamp without time zone,
    customer_code character varying(72) COLLATE public.nocase,
    currency_code character varying(20) COLLATE public.nocase,
    account_code character varying(128) COLLATE public.nocase,
    bu_id character varying(80) COLLATE public.nocase,
    tran_amount numeric,
    cost_center character varying(40) COLLATE public.nocase,
    analysis_code character varying(20) COLLATE public.nocase,
    par_exchange_rate numeric,
    subanalysis_code character varying(20) COLLATE public.nocase,
    exchange_rate numeric,
    transferee_amt numeric,
    reason_code character varying(40) COLLATE public.nocase,
    comments character varying(1024) COLLATE public.nocase,
    ref_doc_no character varying(72) COLLATE public.nocase,
    status character varying(100) COLLATE public.nocase,
    batch_id character varying(512) COLLATE public.nocase,
    tran_type character varying(160) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    account_type character varying(60) COLLATE public.nocase,
    reference_code character varying(80) COLLATE public.nocase,
    scheme_code character varying(80) COLLATE public.nocase,
    purpose character varying(72) COLLATE public.nocase,
    project_ou integer,
    project_code character varying(280) COLLATE public.nocase,
    rev_doc_ou integer,
    rev_doc_no character varying(72) COLLATE public.nocase,
    rev_doc_date timestamp without time zone,
    rev_reasoncode character varying(40) COLLATE public.nocase,
    rev_remarks character varying(400) COLLATE public.nocase,
    rev_doc_trantype character varying(160) COLLATE public.nocase,
    address_id character varying(24) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_ctrn_debit_note_dtl
    OWNER to proconnect;
	
CREATE INDEX IF NOT EXISTS stg_ctrn_debit_note_dtl_idx
    ON stg.stg_ctrn_debit_note_dtl USING btree
(customer_code, ou_id);

CREATE INDEX IF NOT EXISTS stg_ctrn_debit_note_dtl_idx1
    ON stg.stg_ctrn_debit_note_dtl USING btree
(currency_code);

CREATE INDEX IF NOT EXISTS stg_ctrn_debit_note_dtl_idx2
    ON stg.stg_ctrn_debit_note_dtl USING btree
(account_code, ou_id, tdn_no);