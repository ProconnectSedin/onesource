-- Table: raw.raw_stn_credit_note_dtl

-- DROP TABLE IF EXISTS "raw".raw_stn_credit_note_dtl;

CREATE TABLE IF NOT EXISTS "raw".raw_stn_credit_note_dtl
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    ou_id integer NOT NULL,
    trns_credit_note character varying(72) COLLATE public.nocase NOT NULL,
    tran_type character varying(40) COLLATE public.nocase NOT NULL,
    "timestamp" integer NOT NULL,
    transfer_docno character varying(72) COLLATE public.nocase,
    notype_no character varying(40) COLLATE public.nocase,
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
    pbcur_erate character varying(160) COLLATE public.nocase,
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
    CONSTRAINT raw_stn_credit_note_dtl_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_stn_credit_note_dtl
    OWNER to proconnect;