CREATE TABLE raw.raw_rpt_receipt_dtl (
    raw_id bigint NOT NULL,
    ou_id integer NOT NULL,
    receipt_no character varying(72) NOT NULL COLLATE public.nocase,
    dr_doc_no character varying(72) NOT NULL COLLATE public.nocase,
    dr_doc_ou character varying(1024) NOT NULL COLLATE public.nocase,
    term_no character varying(60) NOT NULL COLLATE public.nocase,
    dr_tran_type character varying(160) NOT NULL COLLATE public.nocase,
    dr_doc_type character varying(160) COLLATE public.nocase,
    au_due_date timestamp without time zone,
    au_dr_doc_cur character varying(20) COLLATE public.nocase,
    au_dr_doc_date timestamp without time zone,
    au_dr_doc_amount numeric,
    au_exchange_rate numeric,
    au_outstanding_amt numeric,
    recd_amount numeric,
    batch_id character varying(512) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    billing_point character varying(64) COLLATE public.nocase,
    bookingno character varying(280) COLLATE public.nocase,
    billofladingno character varying(280) COLLATE public.nocase,
    masterbillofladingno character varying(280) COLLATE public.nocase,
    comp_code character varying(80) COLLATE public.nocase,
    scheme_code character varying(160) COLLATE public.nocase,
    reference_code character varying(80) COLLATE public.nocase,
    bill_type character varying(80) COLLATE public.nocase,
    project_ou integer,
    project_code character varying(280) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_rpt_receipt_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_rpt_receipt_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_rpt_receipt_dtl
    ADD CONSTRAINT raw_rpt_receipt_dtl_pkey PRIMARY KEY (raw_id);