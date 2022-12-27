CREATE TABLE dwh.f_cbadjadjvdrdocdtl (
    adj_vdr_doc_dtl_key bigint NOT NULL,
    ou_id integer,
    adj_voucher_no character varying(40) COLLATE public.nocase,
    dr_doc_ou integer,
    dr_doc_type character varying(80) COLLATE public.nocase,
    dr_doc_no character varying(40) COLLATE public.nocase,
    term_no character varying(40) COLLATE public.nocase,
    voucher_tran_type character varying(80) COLLATE public.nocase,
    dr_doc_adj_amt numeric(20,2),
    discount numeric(20,2),
    proposed_discount numeric(20,2),
    charges numeric(20,2),
    proposed_charges numeric(20,2),
    au_dr_doc_unadj_amt numeric(20,2),
    au_dr_doc_cur character varying(10) COLLATE public.nocase,
    au_crosscur_erate numeric(20,2),
    au_discount_date timestamp without time zone,
    au_dr_doc_date timestamp without time zone,
    au_fb_id character varying(40) COLLATE public.nocase,
    au_billing_point integer,
    parent_key character varying(300) COLLATE public.nocase,
    current_key character varying(300) COLLATE public.nocase,
    au_due_date timestamp without time zone,
    au_disc_available numeric(20,2),
    au_cust_code character varying(40) COLLATE public.nocase,
    batch_id character varying(300) COLLATE public.nocase,
    au_base_exrate numeric(20,2),
    au_par_base_exrate numeric(20,2),
    res_writeoff_perc numeric(20,2),
    writeoff_amount numeric(20,2),
    cr_doc_adjusted numeric(20,2),
    cr_doc_disc numeric(20,2),
    cr_doc_charge numeric(20,2),
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_cbadjadjvdrdocdtl ALTER COLUMN adj_vdr_doc_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_cbadjadjvdrdocdtl_adj_vdr_doc_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_cbadjadjvdrdocdtl
    ADD CONSTRAINT f_cbadjadjvdrdocdtl_pkey PRIMARY KEY (adj_vdr_doc_dtl_key);

ALTER TABLE ONLY dwh.f_cbadjadjvdrdocdtl
    ADD CONSTRAINT f_cbadjadjvdrdocdtl_ukey UNIQUE (ou_id, adj_voucher_no, dr_doc_ou, dr_doc_type, dr_doc_no, term_no, voucher_tran_type);