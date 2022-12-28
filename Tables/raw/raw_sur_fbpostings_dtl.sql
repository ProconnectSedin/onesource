CREATE TABLE raw.raw_sur_fbpostings_dtl (
    raw_id bigint NOT NULL,
    ou_id integer NOT NULL,
    tran_type character varying(40) NOT NULL COLLATE public.nocase,
    fb_id character varying(80) NOT NULL COLLATE public.nocase,
    tran_no character varying(72) NOT NULL COLLATE public.nocase,
    account_code character varying(128) NOT NULL COLLATE public.nocase,
    drcr_flag character varying(16) NOT NULL COLLATE public.nocase,
    acct_lineno integer NOT NULL,
    "timestamp" integer NOT NULL,
    acct_type character varying(60) COLLATE public.nocase,
    currency_code character varying(20) COLLATE public.nocase,
    declnyr_code character varying(40) COLLATE public.nocase,
    declnprd_code character varying(60) COLLATE public.nocase,
    tran_date timestamp without time zone,
    tran_qty numeric,
    tran_amount numeric,
    base_amount numeric,
    cost_center character varying(40) COLLATE public.nocase,
    analysis_code character varying(20) COLLATE public.nocase,
    subanalysis_code character varying(20) COLLATE public.nocase,
    bank_code character varying(128) COLLATE public.nocase,
    ref_doc_no character varying(72) COLLATE public.nocase,
    vendor_code character varying(72) COLLATE public.nocase,
    origin_ou integer,
    item_code character varying(128) COLLATE public.nocase,
    vrnt_code character varying(32) COLLATE public.nocase,
    uom character varying(40) COLLATE public.nocase,
    exchange_rate numeric,
    par_exchange_rate numeric,
    par_base_amount numeric,
    ref_tran_type character varying(160) COLLATE public.nocase,
    ref_fbid character varying(80) COLLATE public.nocase,
    auth_date timestamp without time zone,
    post_date timestamp without time zone,
    bu_id character varying(80) COLLATE public.nocase,
    company_code character varying(40) COLLATE public.nocase,
    component_name character varying(64) COLLATE public.nocase,
    vat_category character varying(160) COLLATE public.nocase,
    vat_class character varying(160) COLLATE public.nocase,
    vat_code character varying(160) COLLATE public.nocase,
    vat_rate numeric,
    vat_inclusive character varying(16) COLLATE public.nocase,
    flag character varying(16) COLLATE public.nocase,
    batch_id character varying(512) COLLATE public.nocase,
    receipt_type character varying(16) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    source_comp character varying(120) COLLATE public.nocase,
    narration character varying(1020) COLLATE public.nocase,
    hdrremarks character varying(1020) COLLATE public.nocase,
    mlremarks character varying(1020) COLLATE public.nocase,
    tran_lineno integer,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_sur_fbpostings_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_sur_fbpostings_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_sur_fbpostings_dtl
    ADD CONSTRAINT raw_sur_fbpostings_dtl_pkey PRIMARY KEY (raw_id);