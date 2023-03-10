CREATE TABLE raw.raw_cbadj_adjv_crdoc_dtl (
    raw_id bigint NOT NULL,
    ou_id integer NOT NULL,
    adj_voucher_no character varying(72) NOT NULL COLLATE public.nocase,
    cr_doc_ou integer NOT NULL,
    cr_doc_type character varying(160) NOT NULL COLLATE public.nocase,
    cr_doc_no character varying(72) NOT NULL COLLATE public.nocase,
    term_no character varying(80) NOT NULL COLLATE public.nocase,
    voucher_tran_type character varying(160) NOT NULL COLLATE public.nocase,
    cr_doc_adj_amt numeric,
    au_cr_doc_unadj_amt numeric,
    au_cr_doc_date timestamp without time zone,
    au_cr_doc_cur character varying(20) COLLATE public.nocase,
    au_fb_id character varying(80) COLLATE public.nocase,
    au_receipt_type character varying(120) COLLATE public.nocase,
    au_billing_point integer,
    parent_key character varying(512) COLLATE public.nocase,
    current_key character varying(512) COLLATE public.nocase,
    tran_type character varying(160) COLLATE public.nocase,
    batch_id character varying(512) COLLATE public.nocase,
    au_base_exrate numeric,
    au_par_base_exrate numeric,
    bookingno character varying(280) COLLATE public.nocase,
    masterbillofladingno character varying(280) COLLATE public.nocase,
    billofladingno character varying(280) COLLATE public.nocase,
    writeoff_amount numeric,
    project_ou integer,
    project_code character varying(280) COLLATE public.nocase,
    afe_number character varying(72) COLLATE public.nocase,
    job_number character varying(72) COLLATE public.nocase,
    refcostcenter_hdr character varying(40) COLLATE public.nocase,
    res_writeoff_perc numeric,
    au_crosscur_erate numeric,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_cbadj_adjv_crdoc_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_cbadj_adjv_crdoc_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_cbadj_adjv_crdoc_dtl
    ADD CONSTRAINT raw_cbadj_adjv_crdoc_dtl_pkey PRIMARY KEY (raw_id);