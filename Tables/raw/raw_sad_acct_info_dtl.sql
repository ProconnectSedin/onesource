-- Table: raw.raw_sad_acct_info_dtl

-- DROP TABLE IF EXISTS "raw".raw_sad_acct_info_dtl;

CREATE TABLE IF NOT EXISTS "raw".raw_sad_acct_info_dtl
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    ou_id integer NOT NULL,
    tran_no character varying(72) COLLATE public.nocase NOT NULL,
    tran_type character varying(160) COLLATE public.nocase NOT NULL,
    account_code character varying(128) COLLATE public.nocase NOT NULL,
    drcr_flag character varying(24) COLLATE public.nocase NOT NULL,
    acct_line_no integer NOT NULL,
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
    fin_post_status character varying(100) COLLATE public.nocase,
    transaction_date timestamp without time zone,
    account_type character varying(60) COLLATE public.nocase,
    guid character varying(512) COLLATE public.nocase,
    company_code character varying(40) COLLATE public.nocase,
    bu_id character varying(80) COLLATE public.nocase,
    ref_doc_no character varying(72) COLLATE public.nocase,
    component_name character varying(64) COLLATE public.nocase,
    ref_doc_ou integer,
    ref_doc_type character varying(160) COLLATE public.nocase,
    ref_doc_term character varying(80) COLLATE public.nocase,
    project_ou integer,
    project_code character varying(280) COLLATE public.nocase,
    afe_number character varying(72) COLLATE public.nocase,
    job_number character varying(72) COLLATE public.nocase,
    source_comp character varying(64) COLLATE public.nocase,
    comments character varying(1020) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT raw_sad_acct_info_dtl_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_sad_acct_info_dtl
    OWNER to proconnect;