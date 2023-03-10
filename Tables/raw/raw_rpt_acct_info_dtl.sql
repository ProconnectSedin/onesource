CREATE TABLE raw.raw_rpt_acct_info_dtl (
    raw_id bigint NOT NULL,
    ou_id integer NOT NULL,
    tran_no character varying(72) NOT NULL COLLATE public.nocase,
    fb_id character varying(80) NOT NULL COLLATE public.nocase,
    account_code character varying(128) NOT NULL COLLATE public.nocase,
    tran_type character varying(160) NOT NULL COLLATE public.nocase,
    drcr_flag character varying(24) NOT NULL COLLATE public.nocase,
    posting_line_no integer NOT NULL,
    fin_post_date timestamp without time zone,
    currency character varying(20) COLLATE public.nocase,
    cost_center character varying(40) COLLATE public.nocase,
    tran_amount numeric,
    analysis_code character varying(20) COLLATE public.nocase,
    subanalysis_code character varying(20) COLLATE public.nocase,
    basecur_erate numeric,
    base_amount numeric,
    pbcur_erate numeric,
    par_base_amt numeric,
    fin_post_status character varying(100) COLLATE public.nocase,
    batch_id character varying(512) COLLATE public.nocase,
    account_type character varying(60) COLLATE public.nocase,
    flag character varying(48) COLLATE public.nocase,
    company_id character varying(40) COLLATE public.nocase,
    component_id character varying(64) COLLATE public.nocase,
    bu_id character varying(80) COLLATE public.nocase,
    tran_date timestamp without time zone,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    source_comp character varying(120) COLLATE public.nocase,
    project_ou integer,
    project_code character varying(280) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_rpt_acct_info_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_rpt_acct_info_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_rpt_acct_info_dtl
    ADD CONSTRAINT raw_rpt_acct_info_dtl_pkey PRIMARY KEY (raw_id);