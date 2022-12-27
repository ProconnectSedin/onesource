CREATE TABLE dwh.f_sadadjvdrdocdtl (
    sadadjvdrdocdtl_key bigint NOT NULL,
    sadadjvdrdocdtl_curr_key bigint NOT NULL,
    ou_id integer,
    adj_voucher_no character varying(40) COLLATE public.nocase,
    dr_doc_ou integer,
    dr_doc_type character varying(80) COLLATE public.nocase,
    dr_doc_no character varying(40) COLLATE public.nocase,
    term_no character varying(40) COLLATE public.nocase,
    tran_type character varying(80) COLLATE public.nocase,
    dr_doc_adj_amt numeric(25,2),
    au_dr_doc_unadj_amt numeric(25,2),
    au_dr_doc_amount numeric(25,2),
    au_dr_doc_date timestamp without time zone,
    au_dr_doc_cur character varying(10) COLLATE public.nocase,
    au_fb_id character varying(40) COLLATE public.nocase,
    parent_key character varying(300) COLLATE public.nocase,
    current_key character varying(300) COLLATE public.nocase,
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

ALTER TABLE dwh.f_sadadjvdrdocdtl ALTER COLUMN sadadjvdrdocdtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_sadadjvdrdocdtl_sadadjvdrdocdtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_sadadjvdrdocdtl
    ADD CONSTRAINT f_sadadjvdrdocdtl_pkey PRIMARY KEY (sadadjvdrdocdtl_key);

ALTER TABLE ONLY dwh.f_sadadjvdrdocdtl
    ADD CONSTRAINT f_sadadjvdrdocdtl_ukey UNIQUE (ou_id, adj_voucher_no, dr_doc_ou, dr_doc_type, dr_doc_no, term_no);

ALTER TABLE ONLY dwh.f_sadadjvdrdocdtl
    ADD CONSTRAINT f_sadadjvdrdocdtl_sadadjvdrdocdtl_curr_key_fkey FOREIGN KEY (sadadjvdrdocdtl_curr_key) REFERENCES dwh.d_currency(curr_key);

CREATE INDEX f_sadadjvdrdocdtl_key_idx ON dwh.f_sadadjvdrdocdtl USING btree (ou_id, adj_voucher_no, dr_doc_ou, dr_doc_type, dr_doc_no, term_no);

CREATE INDEX f_sadadjvdrdocdtl_key_idx1 ON dwh.f_sadadjvdrdocdtl USING btree (sadadjvdrdocdtl_curr_key);