CREATE TABLE dwh.f_spypaybatchdtl (
    paybatch_dtl_key bigint NOT NULL,
    curr_key bigint NOT NULL,
    vendor_key bigint NOT NULL,
    ou_id integer,
    paybatch_no character varying(40) COLLATE public.nocase,
    cr_doc_ou integer,
    cr_doc_no character varying(40) COLLATE public.nocase,
    term_no character varying(40) COLLATE public.nocase,
    tran_type character varying(50) COLLATE public.nocase,
    ptimestamp integer,
    cr_doc_type character varying(80) COLLATE public.nocase,
    pay_currency character varying(10) COLLATE public.nocase,
    parbasecur_erate numeric(20,2),
    tran_amount numeric(20,2),
    discount numeric(20,2),
    penalty numeric(20,2),
    pay_mode character varying(50) COLLATE public.nocase,
    proposed_penalty numeric(20,2),
    proposed_discount numeric(20,2),
    basecur_erate numeric(20,2),
    crosscur_erate numeric(20,2),
    supp_ctrl_acct character varying(80) COLLATE public.nocase,
    batch_id character varying(300) COLLATE public.nocase,
    supplier_code character varying(160) COLLATE public.nocase,
    cr_doc_cur character varying(10) COLLATE public.nocase,
    cr_doc_amount numeric(20,2),
    cr_doc_fb_id character varying(40) COLLATE public.nocase,
    tran_net_amount numeric(20,2),
    pay_amount numeric(20,2),
    pay_to_supp character varying(40) COLLATE public.nocase,
    pay_cur_erate numeric(20,2),
    ctrl_acct_type character varying(30) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_spypaybatchdtl ALTER COLUMN paybatch_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_spypaybatchdtl_paybatch_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_spypaybatchdtl
    ADD CONSTRAINT f_spypaybatchdtl_pkey PRIMARY KEY (paybatch_dtl_key);

ALTER TABLE ONLY dwh.f_spypaybatchdtl
    ADD CONSTRAINT f_spypaybatchdtl_ukey UNIQUE (ou_id, paybatch_no, cr_doc_ou, cr_doc_no, term_no, tran_type, ptimestamp);

ALTER TABLE ONLY dwh.f_spypaybatchdtl
    ADD CONSTRAINT f_spypaybatchdtl_curr_key_fkey FOREIGN KEY (curr_key) REFERENCES dwh.d_currency(curr_key);

ALTER TABLE ONLY dwh.f_spypaybatchdtl
    ADD CONSTRAINT f_spypaybatchdtl_vendor_key_fkey FOREIGN KEY (vendor_key) REFERENCES dwh.d_vendor(vendor_key);

CREATE INDEX f_spypaybatchdtl_key_idx ON dwh.f_spypaybatchdtl USING btree (curr_key, vendor_key);