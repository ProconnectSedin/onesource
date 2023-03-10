CREATE TABLE raw.raw_snp_fbposting_dtl (
    raw_id bigint NOT NULL,
    batch_id character varying(512) NOT NULL COLLATE public.nocase,
    ou_id integer NOT NULL,
    document_no character varying(72) NOT NULL COLLATE public.nocase,
    account_lineno integer NOT NULL,
    account_code character varying(128) NOT NULL COLLATE public.nocase,
    "timestamp" integer NOT NULL,
    company_code character varying(40) COLLATE public.nocase,
    component_name character varying(40) COLLATE public.nocase,
    bu_id character varying(80) COLLATE public.nocase,
    fb_id character varying(80) COLLATE public.nocase,
    tran_ou integer,
    tran_type character varying(160) COLLATE public.nocase,
    tran_date timestamp without time zone,
    posting_date timestamp without time zone,
    drcr_flag character varying(24) COLLATE public.nocase,
    currency_code character varying(20) COLLATE public.nocase,
    tran_amount numeric,
    base_amount numeric,
    exchange_rate numeric,
    par_base_amount numeric,
    par_exchange_rate numeric,
    analysis_code character varying(20) COLLATE public.nocase,
    subanalysis_code character varying(20) COLLATE public.nocase,
    cost_center character varying(40) COLLATE public.nocase,
    mac_post_flag character varying(48) COLLATE public.nocase,
    acct_type character varying(40) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    posting_flag character varying(48) COLLATE public.nocase,
    hdrremarks character varying(1020) COLLATE public.nocase,
    mlremarks character varying(1020) COLLATE public.nocase,
    tranline_no integer,
    reftran_no character varying(72) COLLATE public.nocase,
    reftran_ou integer,
    reftran_type character varying(1020) COLLATE public.nocase,
    reftran_fbid character varying(80) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_snp_fbposting_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_snp_fbposting_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_snp_fbposting_dtl
    ADD CONSTRAINT raw_snp_fbposting_dtl_pkey PRIMARY KEY (raw_id);