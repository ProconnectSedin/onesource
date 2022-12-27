CREATE TABLE raw.raw_cbadj_adjv_drdoc_dtl (
    raw_id bigint NOT NULL,
    ou_id integer NOT NULL,
    adj_voucher_no character varying(72) NOT NULL COLLATE public.nocase,
    dr_doc_ou integer NOT NULL,
    dr_doc_type character varying(160) NOT NULL COLLATE public.nocase,
    dr_doc_no character varying(72) NOT NULL COLLATE public.nocase,
    term_no character varying(80) NOT NULL COLLATE public.nocase,
    voucher_tran_type character varying(160) NOT NULL COLLATE public.nocase,
    dr_doc_adj_amt numeric,
    discount numeric,
    proposed_discount numeric,
    charges numeric,
    proposed_charges numeric,
    cost_center character varying(40) COLLATE public.nocase,
    analysis_code character varying(20) COLLATE public.nocase,
    subanalysis_code character varying(20) COLLATE public.nocase,
    au_pur_ord_ref character varying(72) COLLATE public.nocase,
    au_dr_doc_unadj_amt numeric,
    au_dr_doc_cur character varying(20) COLLATE public.nocase,
    au_crosscur_erate numeric,
    au_discount_date timestamp without time zone,
    au_dr_doc_date timestamp without time zone,
    au_fb_id character varying(80) COLLATE public.nocase,
    au_billing_point integer,
    parent_key character varying(512) COLLATE public.nocase,
    current_key character varying(512) COLLATE public.nocase,
    au_sale_ord_ref character varying(72) COLLATE public.nocase,
    au_due_date timestamp without time zone,
    au_disc_available numeric,
    au_cust_code character varying(72) COLLATE public.nocase,
    batch_id character varying(512) COLLATE public.nocase,
    au_base_exrate numeric,
    au_par_base_exrate numeric,
    tcal_status character varying(48) COLLATE public.nocase,
    tcal_exclusive_amt numeric,
    total_tcal_amount numeric,
    res_writeoff_perc numeric,
    writeoff_amount numeric,
    cr_doc_adjusted numeric,
    cr_doc_disc numeric,
    cr_doc_charge numeric,
    bookingno character varying(280) COLLATE public.nocase,
    masterbillofladingno character varying(280) COLLATE public.nocase,
    billofladingno character varying(280) COLLATE public.nocase,
    nontaxable_amt numeric,
    taxable_amt numeric,
    servicetaxamt numeric,
    project_ou integer,
    project_code character varying(280) COLLATE public.nocase,
    afe_number character varying(72) COLLATE public.nocase,
    job_number character varying(72) COLLATE public.nocase,
    refcostcenter_hdr character varying(40) COLLATE public.nocase,
    tax_adj_jvno character varying(1020) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_cbadj_adjv_drdoc_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_cbadj_adjv_drdoc_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_cbadj_adjv_drdoc_dtl
    ADD CONSTRAINT raw_cbadj_adjv_drdoc_dtl_pkey PRIMARY KEY (raw_id);