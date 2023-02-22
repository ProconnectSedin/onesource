-- Table: stg.stg_ctrn_acct_info

-- DROP TABLE IF EXISTS stg.stg_ctrn_acct_info;

CREATE TABLE IF NOT EXISTS stg.stg_ctrn_acct_info
(
    ou_id integer NOT NULL,
    tran_type character varying(160) COLLATE public.nocase NOT NULL,
    tran_no character varying(72) COLLATE public.nocase NOT NULL,
    transfer_doc_no character varying(72) COLLATE public.nocase NOT NULL,
    acc_code character varying(128) COLLATE public.nocase NOT NULL,
    drcr_flag character varying(24) COLLATE public.nocase NOT NULL,
    acc_type character varying(160) COLLATE public.nocase NOT NULL,
    "timestamp" integer NOT NULL,
    fb_id character varying(80) COLLATE public.nocase,
    fin_post_date timestamp without time zone,
    currency character varying(20) COLLATE public.nocase,
    customer_code character varying(72) COLLATE public.nocase,
    cost_center character varying(40) COLLATE public.nocase,
    tran_amt numeric,
    analysis_code character varying(20) COLLATE public.nocase,
    sub_analysis_code character varying(20) COLLATE public.nocase,
    base_cur_exrate numeric,
    base_amt numeric,
    par_base_cur_exrate numeric,
    par_base_amt numeric,
    status character varying(100) COLLATE public.nocase,
    batch_id character varying(512) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    hdrremarks character varying(1020) COLLATE public.nocase,
    company_code character varying(40) COLLATE public.nocase,
    project_ou integer,
    project_code character varying(280) COLLATE public.nocase,
    address_id character varying(24) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT ctrn_acct_info_pkey UNIQUE (ou_id, tran_type, tran_no, transfer_doc_no, acc_code, drcr_flag, acc_type)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_ctrn_acct_info
    OWNER to proconnect;
-- Index: stg_ctrn_acct_info_key_idx2

-- DROP INDEX IF EXISTS stg.stg_ctrn_acct_info_key_idx2;

CREATE INDEX IF NOT EXISTS stg_ctrn_acct_info_key_idx2
    ON stg.stg_ctrn_acct_info USING btree
    (ou_id ASC NULLS LAST, tran_type COLLATE public.nocase ASC NULLS LAST, tran_no COLLATE public.nocase ASC NULLS LAST, transfer_doc_no COLLATE public.nocase ASC NULLS LAST, acc_code COLLATE public.nocase ASC NULLS LAST, drcr_flag COLLATE public.nocase ASC NULLS LAST, acc_type COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;