-- Table: stg.stg_ci_acct_info_dtl

-- DROP TABLE IF EXISTS stg.stg_ci_acct_info_dtl;

CREATE TABLE IF NOT EXISTS stg.stg_ci_acct_info_dtl
(
    tran_ou integer NOT NULL,
    tran_type character varying(40) COLLATE public.nocase NOT NULL,
    tran_no character varying(72) COLLATE public.nocase NOT NULL,
    component_id character varying(64) COLLATE public.nocase NOT NULL,
    company_code character varying(40) COLLATE public.nocase NOT NULL,
    fb_id character varying(80) COLLATE public.nocase NOT NULL,
    account_code character varying(128) COLLATE public.nocase NOT NULL,
    drcr_flag character varying(24) COLLATE public.nocase NOT NULL,
    line_no integer NOT NULL,
    "timestamp" integer,
    batch_id character varying(512) COLLATE public.nocase,
    lo_id character varying(80) COLLATE public.nocase,
    txnou_id integer,
    bu_id character varying(80) COLLATE public.nocase,
    tran_date timestamp without time zone,
    tran_qty numeric,
    tran_amount_acc_cur numeric,
    ctrl_acct_type character varying(60) COLLATE public.nocase,
    auto_post_acct_type character varying(60) COLLATE public.nocase,
    analysis_code character varying(20) COLLATE public.nocase,
    subanalysis_code character varying(20) COLLATE public.nocase,
    cost_center character varying(40) COLLATE public.nocase,
    bank_code character varying(128) COLLATE public.nocase,
    item_code character varying(128) COLLATE public.nocase,
    item_variant character varying(128) COLLATE public.nocase,
    uom character varying(60) COLLATE public.nocase,
    supcust_code character varying(72) COLLATE public.nocase,
    acct_currency character varying(20) COLLATE public.nocase,
    basecur_erate numeric,
    base_amount numeric,
    par_exchange_rate numeric,
    par_base_amount numeric,
    narration character varying(1020) COLLATE public.nocase,
    auth_date timestamp without time zone,
    ref_doc_ou integer,
    ref_doc_fb_id character varying(80) COLLATE public.nocase,
    ref_doc_type character varying(40) COLLATE public.nocase,
    ref_doc_no character varying(72) COLLATE public.nocase,
    vat_decl_year character varying(60) COLLATE public.nocase,
    vat_decl_period character varying(60) COLLATE public.nocase,
    vat_usage_flag character varying(4) COLLATE public.nocase,
    vat_category character varying(160) COLLATE public.nocase,
    vat_class character varying(160) COLLATE public.nocase,
    vat_code character varying(160) COLLATE public.nocase,
    vat_rate numeric,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    posting_date timestamp without time zone,
    posting_status character varying(4) COLLATE public.nocase,
    base_currency character varying(20) COLLATE public.nocase,
    par_base_currency character varying(20) COLLATE public.nocase,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    vat_posting_flag character varying(4) COLLATE public.nocase,
    vat_posting_date timestamp without time zone,
    account_type character varying(60) COLLATE public.nocase,
    vat_line_no integer,
    vatusage integer,
    ref_doc_lineno integer,
    ibe_flag character varying(48) COLLATE public.nocase,
    fbp_post_flag character varying(48) COLLATE public.nocase,
    fin_year character varying(60) COLLATE public.nocase,
    fin_period character varying(60) COLLATE public.nocase,
    hdrremarks character varying(1024) COLLATE public.nocase,
    mlremarks character varying(1020) COLLATE public.nocase,
    oldguid_regen character varying(512) COLLATE public.nocase,
    oldcomp_regen character varying(64) COLLATE public.nocase,
    pdc_status character varying(100) COLLATE public.nocase,
    instr_no character varying(120) COLLATE public.nocase,
    defermentamount numeric,
    address_id character varying(24) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT ci_acct_info_dtl_pkey PRIMARY KEY (tran_ou, tran_type, tran_no, component_id, company_code, fb_id, account_code, drcr_flag, line_no)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_ci_acct_info_dtl
    OWNER to proconnect;
-- Index: stg_ci_acct_info_dtl_idx

-- DROP INDEX IF EXISTS stg.stg_ci_acct_info_dtl_idx;

CREATE INDEX IF NOT EXISTS stg_ci_acct_info_dtl_idx
    ON stg.stg_ci_acct_info_dtl USING btree
    (tran_ou ASC NULLS LAST, tran_type COLLATE public.nocase ASC NULLS LAST, tran_no COLLATE public.nocase ASC NULLS LAST, component_id COLLATE public.nocase ASC NULLS LAST, company_code COLLATE public.nocase ASC NULLS LAST, fb_id COLLATE public.nocase ASC NULLS LAST, account_code COLLATE public.nocase ASC NULLS LAST, drcr_flag COLLATE public.nocase ASC NULLS LAST, line_no ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: stg_ci_acct_info_dtl_idx1

-- DROP INDEX IF EXISTS stg.stg_ci_acct_info_dtl_idx1;

CREATE INDEX IF NOT EXISTS stg_ci_acct_info_dtl_idx1
    ON stg.stg_ci_acct_info_dtl USING btree
    (tran_ou ASC NULLS LAST, item_code COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;