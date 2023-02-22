-- Table: raw.raw_sr_acctinfo_dtl

-- DROP TABLE IF EXISTS "raw".raw_sr_acctinfo_dtl;

CREATE TABLE IF NOT EXISTS "raw".raw_sr_acctinfo_dtl
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    ou_id integer NOT NULL,
    tran_no character varying(72) COLLATE public.nocase NOT NULL,
    tran_type character varying(160) COLLATE public.nocase NOT NULL,
    acct_lineno integer NOT NULL,
    fb_id character varying(80) COLLATE public.nocase NOT NULL,
    acc_code character varying(128) COLLATE public.nocase NOT NULL,
    drcr_flag character varying(24) COLLATE public.nocase NOT NULL,
    "timestamp" integer NOT NULL,
    acct_type character varying(40) COLLATE public.nocase,
    fin_post_date timestamp without time zone,
    currency character varying(20) COLLATE public.nocase,
    cost_center character varying(40) COLLATE public.nocase,
    tran_amt numeric,
    business_unit character varying(80) COLLATE public.nocase,
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
    project_ou integer,
    project_code character varying(280) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT sr_acctinfo_dtl_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_sr_acctinfo_dtl
    OWNER to proconnect;