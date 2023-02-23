-- Table: raw.raw_spy_acct_info_dtl

-- DROP TABLE IF EXISTS "raw".raw_spy_acct_info_dtl;

CREATE TABLE IF NOT EXISTS "raw".raw_spy_acct_info_dtl
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    ou_id integer NOT NULL,
    posting_line_no integer NOT NULL,
    tran_no character varying(72) COLLATE public.nocase NOT NULL,
    tran_type character varying(160) COLLATE public.nocase NOT NULL,
    account_code character varying(128) COLLATE public.nocase NOT NULL,
    drcr_flag character varying(24) COLLATE public.nocase NOT NULL,
    "timestamp" integer NOT NULL,
    account_type character varying(60) COLLATE public.nocase,
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
    batch_id character varying(512) COLLATE public.nocase,
    paybatch_no character varying(72) COLLATE public.nocase,
    bu_id character varying(80) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    component_name character varying(64) COLLATE public.nocase,
    cr_doc_no character varying(72) COLLATE public.nocase,
    cr_doc_ou integer,
    cr_doc_type character varying(100) COLLATE public.nocase,
    cr_doc_term character varying(80) COLLATE public.nocase,
    posting_flag character varying(48) COLLATE public.nocase,
    fin_post_flag character varying(48) COLLATE public.nocase,
    hdrremarks character varying(1020) COLLATE public.nocase,
    project_ou integer,
    project_code character varying(280) COLLATE public.nocase,
    afe_number character varying(72) COLLATE public.nocase,
    job_number character varying(72) COLLATE public.nocase,
    refcostcenter_hdr character varying(40) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT spy_acct_info_dtl_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_spy_acct_info_dtl
    OWNER to proconnect;