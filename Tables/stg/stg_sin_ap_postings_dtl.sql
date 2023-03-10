CREATE TABLE stg.stg_sin_ap_postings_dtl (
    tran_type character varying(40) NOT NULL COLLATE public.nocase,
    tran_ou integer NOT NULL,
    tran_no character varying(72) NOT NULL COLLATE public.nocase,
    posting_line_no integer NOT NULL,
    "timestamp" integer NOT NULL,
    line_no integer,
    company_code character varying(40) COLLATE public.nocase,
    posting_status character varying(12) COLLATE public.nocase,
    posting_date timestamp without time zone,
    fb_id character varying(80) COLLATE public.nocase,
    tran_date timestamp without time zone,
    account_type character varying(60) COLLATE public.nocase,
    account_code character varying(128) COLLATE public.nocase,
    drcr_id character varying(4) COLLATE public.nocase,
    tran_currency character varying(20) COLLATE public.nocase,
    tran_amount numeric,
    exchange_rate numeric,
    base_amount numeric,
    par_exchange_rate numeric,
    par_base_amount numeric,
    cost_center character varying(40) COLLATE public.nocase,
    analysis_code character varying(20) COLLATE public.nocase,
    subanalysis_code character varying(20) COLLATE public.nocase,
    guid character varying(512) COLLATE public.nocase,
    entry_date timestamp without time zone,
    auth_date timestamp without time zone,
    item_code character varying(128) COLLATE public.nocase,
    item_variant character varying(128) COLLATE public.nocase,
    quantity numeric,
    reftran_fbid character varying(80) COLLATE public.nocase,
    reftran_no character varying(72) COLLATE public.nocase,
    reftran_ou integer,
    ref_tran_type character varying(40) COLLATE public.nocase,
    supp_code character varying(64) COLLATE public.nocase,
    uom character varying(60) COLLATE public.nocase,
    org_vat_base_amt numeric,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    vat_line_no integer,
    vatusageid integer,
    source_comp character varying(160) COLLATE public.nocase,
    hdrremarks character varying(1024) COLLATE public.nocase,
    mlremarks character varying(1024) COLLATE public.nocase,
    roundoff_flag character varying(48) COLLATE public.nocase,
    item_tcd_type character varying(48) COLLATE public.nocase,
    rowtype character varying(100) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_sin_ap_postings_dtl
    ADD CONSTRAINT sin_ap_postings_dtl_pkey PRIMARY KEY (tran_type, tran_ou, tran_no, posting_line_no);