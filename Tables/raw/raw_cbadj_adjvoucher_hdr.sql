CREATE TABLE raw.raw_cbadj_adjvoucher_hdr (
    raw_id bigint NOT NULL,
    ou_id integer NOT NULL,
    adj_voucher_no character varying(72) NOT NULL COLLATE public.nocase,
    voucher_tran_type character varying(160) NOT NULL COLLATE public.nocase,
    "timestamp" integer,
    voucher_date timestamp without time zone,
    fb_id character varying(80) COLLATE public.nocase,
    voucher_amount numeric,
    status character varying(100) COLLATE public.nocase,
    cust_code character varying(72) COLLATE public.nocase,
    cust_hierarchy character varying(72) COLLATE public.nocase,
    adjust_seq character varying(48) COLLATE public.nocase,
    currency_code character varying(20) COLLATE public.nocase,
    voucher_type character varying(80) COLLATE public.nocase,
    rev_voucher_no character varying(72) COLLATE public.nocase,
    reversal_date timestamp without time zone,
    notype_no character varying(40) COLLATE public.nocase,
    reason_code character varying(40) COLLATE public.nocase,
    remarks character varying(1024) COLLATE public.nocase,
    currentkey character varying(512) COLLATE public.nocase,
    batch_id character varying(512) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    tcal_status character varying(48) COLLATE public.nocase,
    tcal_exclusive_amt numeric,
    total_tcal_amount numeric,
    consistency_stamp character varying(48) COLLATE public.nocase,
    voucher_amount_ovradj numeric,
    ims_flag character varying(48) COLLATE public.nocase,
    scheme_code character varying(80) COLLATE public.nocase,
    crnoteno character varying(72) COLLATE public.nocase,
    drnoteno character varying(72) COLLATE public.nocase,
    crnoteou integer,
    drnoteou integer,
    crnotefb character varying(80) COLLATE public.nocase,
    drnotefb character varying(80) COLLATE public.nocase,
    crvoucno character varying(72) COLLATE public.nocase,
    drvoucno character varying(72) COLLATE public.nocase,
    srdoctype character varying(160) COLLATE public.nocase,
    destibu character varying(80) COLLATE public.nocase,
    revcrnoteno character varying(72) COLLATE public.nocase,
    revdrnoteno character varying(72) COLLATE public.nocase,
    revcrvoucno character varying(72) COLLATE public.nocase,
    revdrvoucno character varying(72) COLLATE public.nocase,
    workflow_status character varying(336) COLLATE public.nocase,
    pdc_flag character varying(48) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_cbadj_adjvoucher_hdr ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_cbadj_adjvoucher_hdr_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_cbadj_adjvoucher_hdr
    ADD CONSTRAINT raw_cbadj_adjvoucher_hdr_pkey PRIMARY KEY (raw_id);