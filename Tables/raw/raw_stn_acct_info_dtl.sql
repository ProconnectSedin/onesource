-- Table: raw.raw_stn_acct_info_dtl

-- DROP TABLE IF EXISTS "raw".raw_stn_acct_info_dtl;

CREATE TABLE IF NOT EXISTS "raw".raw_stn_acct_info_dtl
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    ou_id character varying(60) COLLATE public.nocase NOT NULL,
    company_code character varying(40) COLLATE public.nocase NOT NULL,
    tran_no character varying(72) COLLATE public.nocase NOT NULL,
    tran_type character varying(40) COLLATE public.nocase NOT NULL,
    account_code character varying(128) COLLATE public.nocase NOT NULL,
    drcr_flag character varying(24) COLLATE public.nocase NOT NULL,
    account_type character varying(60) COLLATE public.nocase NOT NULL,
    tran_date timestamp without time zone,
    fin_post_date timestamp without time zone,
    currency_code character varying(20) COLLATE public.nocase,
    cost_center character varying(40) COLLATE public.nocase,
    tran_amount numeric,
    fb_id character varying(80) COLLATE public.nocase,
    analysis_code character varying(20) COLLATE public.nocase,
    subanalysis_code character varying(20) COLLATE public.nocase,
    basecur_erate numeric,
    base_amount numeric,
    pbcur_erate numeric,
    par_base_amt numeric,
    fin_post_status character varying(8) COLLATE public.nocase,
    guid character varying(512) COLLATE public.nocase,
    transfer_docno character varying(72) COLLATE public.nocase,
    acct_line_no integer,
    bu_id character varying(80) COLLATE public.nocase,
    supplier_code character varying(64) COLLATE public.nocase,
    hdrremarks character varying(1020) COLLATE public.nocase,
    project_ou integer,
    project_code character varying(280) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT stn_acct_info_dtl_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_stn_acct_info_dtl
    OWNER to proconnect;