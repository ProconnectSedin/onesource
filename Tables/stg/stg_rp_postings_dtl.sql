CREATE TABLE stg.stg_rp_postings_dtl (
    ou_id integer NOT NULL,
    serial_no integer NOT NULL,
    unique_no integer NOT NULL,
    doc_type character varying(160) NOT NULL COLLATE public.nocase,
    tran_ou integer NOT NULL,
    document_no character varying(72) NOT NULL COLLATE public.nocase,
    account_code character varying(128) NOT NULL COLLATE public.nocase,
    tran_type character varying(40) NOT NULL COLLATE public.nocase,
    rtimestamp integer,
    fb_id character varying(80) COLLATE public.nocase,
    bu_id character varying(80) COLLATE public.nocase,
    tran_date timestamp without time zone,
    posting_date timestamp without time zone,
    account_currcode character varying(20) COLLATE public.nocase,
    drcr_flag character varying(16) COLLATE public.nocase,
    currency_code character varying(20) COLLATE public.nocase,
    tran_amount numeric,
    base_amount numeric,
    exchange_rate numeric,
    par_base_amount numeric,
    par_exchange_rate numeric,
    analysis_code character varying(20) COLLATE public.nocase,
    subanalysis_code character varying(20) COLLATE public.nocase,
    cost_center character varying(40) COLLATE public.nocase,
    entry_date timestamp without time zone,
    auth_date timestamp without time zone,
    narration character varying(1020) COLLATE public.nocase,
    bank_code character varying(128) COLLATE public.nocase,
    item_code character varying(128) COLLATE public.nocase,
    item_varinat character varying(32) COLLATE public.nocase,
    quantity numeric,
    mac_post_flag character varying(48) COLLATE public.nocase,
    reftran_fbid character varying(80) COLLATE public.nocase,
    reftran_no character varying(72) COLLATE public.nocase,
    supcust_code character varying(72) COLLATE public.nocase,
    reftran_ou integer,
    ref_tran_type character varying(160) COLLATE public.nocase,
    uom character varying(60) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    ctrlacctype character varying(60) COLLATE public.nocase,
    company_code character varying(40) COLLATE public.nocase,
    batch_id character varying(512) COLLATE public.nocase,
    component_name character varying(64) COLLATE public.nocase,
    hdrremarks character varying(1020) COLLATE public.nocase,
    mlremarks character varying(1020) COLLATE public.nocase,
    pdc_void_flag character varying(48) COLLATE public.nocase,
    project_ou integer,
    project_code character varying(280) COLLATE public.nocase,
    afe_number character varying(72) COLLATE public.nocase,
    job_number character varying(72) COLLATE public.nocase,
    refcostcenter_hdr character varying(40) COLLATE public.nocase,
    check_no character varying(120) COLLATE public.nocase,
    line_no integer,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_rp_postings_dtl
    ADD CONSTRAINT rp_postings_dtl_pkey PRIMARY KEY (ou_id, serial_no, unique_no, doc_type, tran_ou, document_no, account_code, tran_type);

CREATE INDEX stg_rp_postings_dtl_idx ON stg.stg_rp_postings_dtl USING btree (ou_id, serial_no, unique_no, doc_type, tran_ou, document_no, account_code, tran_type);