CREATE TABLE raw.raw_spy_voucher_dtl (
    raw_id bigint NOT NULL,
    ou_id integer NOT NULL,
    paybatch_no character varying(72) NOT NULL COLLATE public.nocase,
    voucher_no character varying(72) NOT NULL COLLATE public.nocase,
    cr_doc_ou integer NOT NULL,
    cr_doc_no character varying(72) NOT NULL COLLATE public.nocase,
    term_no character varying(80) NOT NULL COLLATE public.nocase,
    tran_type character varying(100) NOT NULL COLLATE public.nocase,
    "timestamp" integer NOT NULL,
    cr_doc_amount numeric,
    cr_doc_type character varying(160) NOT NULL COLLATE public.nocase,
    pay_amount numeric,
    discount numeric,
    penalty numeric,
    batch_id character varying(512) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    variance_amount numeric,
    tcal_exclusive_amt numeric,
    total_tcal_amount numeric,
    tcal_status character varying(48) COLLATE public.nocase,
    cr_doc_line_no integer,
    project_ou integer,
    project_code character varying(280) COLLATE public.nocase,
    afe_number character varying(72) COLLATE public.nocase,
    job_number character varying(72) COLLATE public.nocase,
    refcostcenter_hdr character varying(40) COLLATE public.nocase,
    tax_adj_jvno character varying(16000) COLLATE public.nocase,
    prop_wht_amt numeric,
    app_wht_amt numeric,
    own_tax_region character varying(40) COLLATE public.nocase,
    party_tax_region character varying(40) COLLATE public.nocase,
    decl_tax_region character varying(40) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_spy_voucher_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_spy_voucher_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_spy_voucher_dtl
    ADD CONSTRAINT raw_spy_voucher_dtl_pkey PRIMARY KEY (raw_id);