CREATE TABLE dwh.f_contracttransferinvoicedetail (
    cont_dtl_key bigint NOT NULL,
    cont_inv_hdr_key bigint NOT NULL,
    cont_transfer_inv_no character varying(40) COLLATE public.nocase,
    cont_transfer_lineno integer,
    cont_transfer_inv_ou integer,
    cont_transfer_contract_id character varying(40) COLLATE public.nocase,
    cont_transfer_ref_doc_no character varying(40) COLLATE public.nocase,
    cont_transfer_ref_doc_date timestamp without time zone,
    cont_transfer_draft_inv_no character varying(40) COLLATE public.nocase,
    cont_supplier_id character varying(510) COLLATE public.nocase,
    cont_customer_id character varying(80) COLLATE public.nocase,
    cont_transfer_currency character varying(20) COLLATE public.nocase,
    cont_location character varying(510) COLLATE public.nocase,
    cont_fb_id character varying(40) COLLATE public.nocase,
    cont_transfer_billing_address character varying(80) COLLATE public.nocase,
    cont_refdoc_inv_value numeric(132,0),
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_contracttransferinvoicedetail ALTER COLUMN cont_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_contracttransferinvoicedetail_cont_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_contracttransferinvoicedetail
    ADD CONSTRAINT f_contracttransferinvoicedetail_pkey PRIMARY KEY (cont_dtl_key);

ALTER TABLE ONLY dwh.f_contracttransferinvoicedetail
    ADD CONSTRAINT f_contracttransferinvoicedetail_ukey UNIQUE (cont_transfer_inv_no, cont_transfer_lineno, cont_transfer_inv_ou);

ALTER TABLE ONLY dwh.f_contracttransferinvoicedetail
    ADD CONSTRAINT f_contracttransferinvoicedetail_cont_inv_hdr_key_fkey FOREIGN KEY (cont_inv_hdr_key) REFERENCES dwh.f_contracttransferinvoiceheader(cont_hdr_key);

CREATE INDEX f_contracttransferinvoicedetail_key_idx ON dwh.f_contracttransferinvoicedetail USING btree (cont_transfer_inv_no, cont_transfer_lineno, cont_transfer_inv_ou);

CREATE INDEX f_contracttransferinvoicedetail_key_idx1 ON dwh.f_contracttransferinvoicedetail USING btree (cont_inv_hdr_key);