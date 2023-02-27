-- Table: stg.stg_adepp_accounting_info_dtl

-- DROP TABLE IF EXISTS stg.stg_adepp_accounting_info_dtl;

CREATE TABLE IF NOT EXISTS stg.stg_adepp_accounting_info_dtl
(
    "timestamp" integer NOT NULL,
    ou_id integer,
    company_code character varying(40) COLLATE public.nocase,
    tran_number character varying(72) COLLATE public.nocase,
    asset_number character varying(72) COLLATE public.nocase,
    tag_number integer,
    tran_type character varying(160) COLLATE public.nocase,
    tran_date timestamp without time zone,
    posting_date timestamp without time zone,
    account_code character varying(128) COLLATE public.nocase,
    drcr_flag character varying(24) COLLATE public.nocase,
    currency character varying(20) COLLATE public.nocase,
    tran_amount numeric,
    fb_id character varying(80) COLLATE public.nocase,
    bu_id character varying(80) COLLATE public.nocase,
    cost_center character varying(40) COLLATE public.nocase,
    analysis_code character varying(20) COLLATE public.nocase,
    sub_analysis_code character varying(20) COLLATE public.nocase,
    bc_erate numeric,
    base_amount numeric,
    pbc_erate numeric,
    pbase_amount numeric,
    account_type character varying(160) COLLATE public.nocase,
    fin_period character varying(40) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    batch_id character varying(512) COLLATE public.nocase,
    depr_book character varying(80) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_adepp_accounting_info_dtl
    OWNER to proconnect;
-- Index: stg_adepp_accounting_info_dtl_key_idx2

-- DROP INDEX IF EXISTS stg.stg_adepp_accounting_info_dtl_key_idx2;

CREATE INDEX IF NOT EXISTS stg_adepp_accounting_info_dtl_key_idx2
    ON stg.stg_adepp_accounting_info_dtl USING btree
    (ou_id ASC NULLS LAST, company_code COLLATE public.nocase ASC NULLS LAST, tran_number COLLATE public.nocase ASC NULLS LAST, asset_number COLLATE public.nocase ASC NULLS LAST, tag_number ASC NULLS LAST, tran_date ASC NULLS LAST, account_code COLLATE public.nocase ASC NULLS LAST, drcr_flag COLLATE public.nocase ASC NULLS LAST, fb_id COLLATE public.nocase ASC NULLS LAST, bu_id COLLATE public.nocase ASC NULLS LAST, fin_period COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;