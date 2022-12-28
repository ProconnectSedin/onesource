CREATE TABLE raw.raw_sad_adjv_drdoc_dtl (
    raw_id bigint NOT NULL,
    ou_id integer NOT NULL,
    adj_voucher_no character varying(72) NOT NULL COLLATE public.nocase,
    dr_doc_ou integer NOT NULL,
    dr_doc_type character varying(160) NOT NULL COLLATE public.nocase,
    dr_doc_no character varying(72) NOT NULL COLLATE public.nocase,
    term_no character varying(80) NOT NULL COLLATE public.nocase,
    tran_type character varying(160) COLLATE public.nocase,
    dr_doc_adj_amt numeric,
    au_dr_doc_unadj_amt numeric,
    au_dr_doc_amount numeric,
    au_dr_doc_date timestamp without time zone,
    au_dr_doc_cur character varying(20) COLLATE public.nocase,
    au_fb_id character varying(80) COLLATE public.nocase,
    parent_key character varying(512) COLLATE public.nocase,
    current_key character varying(512) COLLATE public.nocase,
    stimestamp integer,
    au_billing_point integer,
    voucher_tran_type character varying(160) COLLATE public.nocase,
    batch_id character varying(512) COLLATE public.nocase,
    project_ou integer,
    project_code character varying(280) COLLATE public.nocase,
    afe_number character varying(72) COLLATE public.nocase,
    job_number character varying(72) COLLATE public.nocase,
    tax_adj_jvno character varying(16000) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_sad_adjv_drdoc_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_sad_adjv_drdoc_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_sad_adjv_drdoc_dtl
    ADD CONSTRAINT raw_sad_adjv_drdoc_dtl_pkey PRIMARY KEY (raw_id);