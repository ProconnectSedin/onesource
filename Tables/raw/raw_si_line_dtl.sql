CREATE TABLE raw.raw_si_line_dtl (
    raw_id bigint NOT NULL,
    tran_type character varying(40) NOT NULL COLLATE public.nocase,
    tran_ou integer NOT NULL,
    tran_no character varying(72) NOT NULL COLLATE public.nocase,
    line_no integer NOT NULL,
    row_type character varying(60) NOT NULL COLLATE public.nocase,
    lo_id character varying(80) COLLATE public.nocase,
    ref_doc_type character varying(40) COLLATE public.nocase,
    ref_doc_ou integer,
    ref_doc_no character varying(72) COLLATE public.nocase,
    ref_doc_term_no character varying(80) COLLATE public.nocase,
    item_tcd_code character varying(160) COLLATE public.nocase,
    item_tcd_var character varying(128) COLLATE public.nocase,
    uom character varying(60) COLLATE public.nocase,
    item_qty numeric,
    unit_price numeric,
    rate_per numeric,
    item_amount numeric,
    tax_amount numeric,
    disc_amount numeric,
    line_amount numeric,
    capitalized_amount numeric,
    proposal_no character varying(72) COLLATE public.nocase,
    cap_doc_flag character varying(48) COLLATE public.nocase,
    batch_id character varying(512) COLLATE public.nocase,
    usage_id character varying(80) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    pending_cap_amount numeric,
    account_code character varying(128) COLLATE public.nocase,
    milestone_code character varying(128) COLLATE public.nocase,
    report_flag character varying(20) DEFAULT 'N'::character varying COLLATE public.nocase,
    writeoff_amt numeric,
    writeoff_remarks character varying(400) COLLATE public.nocase,
    writeoff_jvno character varying(72) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_si_line_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_si_line_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_si_line_dtl
    ADD CONSTRAINT raw_si_line_dtl_pkey PRIMARY KEY (raw_id);