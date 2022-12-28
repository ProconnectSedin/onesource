CREATE TABLE dwh.f_contracttransferinvoiceheader (
    cont_hdr_key bigint NOT NULL,
    cont_transfer_inv_no character varying(40) COLLATE public.nocase,
    cont_transfer_inv_ou integer,
    cont_transfer_inv_date timestamp without time zone,
    cont_inv_no character varying(40) COLLATE public.nocase,
    cont_inv_date timestamp without time zone,
    cont_flag character varying(20) COLLATE public.nocase,
    cont_timestamp integer,
    cont_created_by character varying(60) COLLATE public.nocase,
    cont_created_dt timestamp without time zone,
    cont_modified_by character varying(60) COLLATE public.nocase,
    cont_modified_dt timestamp without time zone,
    cont_tran_type character varying(50) COLLATE public.nocase,
    cont_rcti_flag character varying(50) COLLATE public.nocase,
    cont_billing_profile character varying(50) COLLATE public.nocase,
    cont_transfer_received_by character varying(60) COLLATE public.nocase,
    cont_transfer_date_received timestamp without time zone,
    cont_transfer_inv_value numeric(132,0),
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_contracttransferinvoiceheader ALTER COLUMN cont_hdr_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_contracttransferinvoiceheader_cont_hdr_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_contracttransferinvoiceheader
    ADD CONSTRAINT f_contracttransferinvoiceheader_pkey PRIMARY KEY (cont_hdr_key);

ALTER TABLE ONLY dwh.f_contracttransferinvoiceheader
    ADD CONSTRAINT f_contracttransferinvoiceheader_ukey UNIQUE (cont_transfer_inv_no, cont_transfer_inv_ou);

CREATE INDEX f_contracttransferinvoiceheader_key_idx ON dwh.f_contracttransferinvoiceheader USING btree (cont_transfer_inv_no, cont_transfer_inv_ou);