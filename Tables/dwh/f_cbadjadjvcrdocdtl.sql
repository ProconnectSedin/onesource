CREATE TABLE dwh.f_cbadjadjvcrdocdtl (
    adj_docdtl_key bigint NOT NULL,
    ou_id integer,
    adj_voucher_no character varying(40) COLLATE public.nocase,
    cr_doc_ou integer,
    cr_doc_type character varying(80) COLLATE public.nocase,
    cr_doc_no character varying(40) COLLATE public.nocase,
    term_no character varying(40) COLLATE public.nocase,
    voucher_tran_type character varying(80) COLLATE public.nocase,
    cr_doc_adj_amt numeric(20,2),
    au_cr_doc_unadj_amt numeric(20,2),
    au_cr_doc_date timestamp without time zone,
    au_cr_doc_cur character varying(10) COLLATE public.nocase,
    au_fb_id character varying(40) COLLATE public.nocase,
    au_receipt_type character varying(60) COLLATE public.nocase,
    au_billing_point integer,
    parent_key character varying(300) COLLATE public.nocase,
    current_key character varying(300) COLLATE public.nocase,
    tran_type character varying(80) COLLATE public.nocase,
    batch_id character varying(300) COLLATE public.nocase,
    au_base_exrate numeric(20,2),
    au_par_base_exrate numeric(20,2),
    writeoff_amount numeric(20,2),
    res_writeoff_perc numeric(20,2),
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_cbadjadjvcrdocdtl ALTER COLUMN adj_docdtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_cbadjadjvcrdocdtl_adj_docdtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_cbadjadjvcrdocdtl
    ADD CONSTRAINT f_cbadjadjvcrdocdtl_pkey PRIMARY KEY (adj_docdtl_key);

ALTER TABLE ONLY dwh.f_cbadjadjvcrdocdtl
    ADD CONSTRAINT f_cbadjadjvcrdocdtl_ukey UNIQUE (ou_id, adj_voucher_no, cr_doc_ou, cr_doc_type, cr_doc_no, term_no, voucher_tran_type);