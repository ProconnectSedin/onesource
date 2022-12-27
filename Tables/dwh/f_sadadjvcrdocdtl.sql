CREATE TABLE dwh.f_sadadjvcrdocdtl (
    sadadjvcrdocdtl_key bigint NOT NULL,
    sadadjvcrdocdtl_curr_key bigint NOT NULL,
    ou_id integer,
    adj_voucher_no character varying(40) COLLATE public.nocase,
    cr_doc_ou integer,
    cr_doc_no character varying(40) COLLATE public.nocase,
    term_no character varying(40) COLLATE public.nocase,
    cr_doc_type character varying(80) COLLATE public.nocase,
    tran_type character varying(80) COLLATE public.nocase,
    cr_doc_adj_amt numeric(25,2),
    discount numeric(25,2),
    proposed_discount numeric(25,2),
    cost_center character varying(20) COLLATE public.nocase,
    analysis_code character varying(10) COLLATE public.nocase,
    subanalysis_code character varying(10) COLLATE public.nocase,
    au_cr_doc_unadj_amt numeric(25,2),
    au_cr_doc_cur character varying(10) COLLATE public.nocase,
    au_crosscur_erate numeric(25,2),
    au_discount_date timestamp without time zone,
    au_cr_doc_date timestamp without time zone,
    au_fb_id character varying(40) COLLATE public.nocase,
    parent_key character varying(300) COLLATE public.nocase,
    current_key character varying(300) COLLATE public.nocase,
    au_disc_available numeric(25,2),
    au_due_date timestamp without time zone,
    au_billing_point integer,
    voucher_tran_type character varying(80) COLLATE public.nocase,
    batch_id character varying(300) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_sadadjvcrdocdtl ALTER COLUMN sadadjvcrdocdtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_sadadjvcrdocdtl_sadadjvcrdocdtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_sadadjvcrdocdtl
    ADD CONSTRAINT f_sadadjvcrdocdtl_pkey PRIMARY KEY (sadadjvcrdocdtl_key);

ALTER TABLE ONLY dwh.f_sadadjvcrdocdtl
    ADD CONSTRAINT f_sadadjvcrdocdtl_ukey UNIQUE (ou_id, adj_voucher_no, cr_doc_ou, cr_doc_no, term_no, cr_doc_type);

ALTER TABLE ONLY dwh.f_sadadjvcrdocdtl
    ADD CONSTRAINT f_sadadjvcrdocdtl_sadadjvcrdocdtl_curr_key_fkey FOREIGN KEY (sadadjvcrdocdtl_curr_key) REFERENCES dwh.d_currency(curr_key);

CREATE INDEX f_sadadjvcrdocdtl_key_idx ON dwh.f_sadadjvcrdocdtl USING btree (ou_id, adj_voucher_no, cr_doc_ou, cr_doc_no, term_no, cr_doc_type);

CREATE INDEX f_sadadjvcrdocdtl_key_idx1 ON dwh.f_sadadjvcrdocdtl USING btree (sadadjvcrdocdtl_curr_key);