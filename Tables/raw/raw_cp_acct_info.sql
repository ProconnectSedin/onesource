-- Table: raw.raw_cp_acct_info

-- DROP TABLE IF EXISTS "raw".raw_cp_acct_info;

CREATE TABLE IF NOT EXISTS "raw".raw_cp_acct_info
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    ou_id integer NOT NULL,
    tran_no character varying(72) COLLATE public.nocase NOT NULL,
    fb_id character varying(80) COLLATE public.nocase NOT NULL,
    acc_code character varying(128) COLLATE public.nocase NOT NULL,
    drcr_flag character varying(24) COLLATE public.nocase NOT NULL,
    tran_type character varying(160) COLLATE public.nocase NOT NULL,
    line_no integer NOT NULL,
    "timestamp" integer NOT NULL,
    tran_date timestamp without time zone,
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
    company_code character varying(40) COLLATE public.nocase,
    component_name character varying(640) COLLATE public.nocase,
    acct_type character varying(60) COLLATE public.nocase,
    bank_cash_code character varying(128) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    sourcecomp character varying(160) COLLATE public.nocase,
    posting_flag character varying(48) COLLATE public.nocase,
    remarks character varying(1024) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT raw_cp_acct_info_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_cp_acct_info
    OWNER to proconnect;