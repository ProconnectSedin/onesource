CREATE TABLE dwh.f_internalorderheader (
    in_ord_hdr_key bigint NOT NULL,
    in_ord_hdr_loc_key bigint NOT NULL,
    in_ord_hdr_customer_key bigint NOT NULL,
    in_ord_location character varying(20) COLLATE public.nocase,
    in_ord_no character varying(40) COLLATE public.nocase,
    in_ord_ou integer,
    in_ord_date timestamp without time zone,
    in_ord_ref_doc_typ character varying(20) COLLATE public.nocase,
    in_ord_customer_id character varying(40) COLLATE public.nocase,
    in_ord_pri_ref_doc_typ character varying(80) COLLATE public.nocase,
    in_ord_pri_ref_doc_no character varying(40) COLLATE public.nocase,
    in_ord_pri_ref_doc_date timestamp without time zone,
    in_ord_status character varying(20) COLLATE public.nocase,
    in_ord_amendno integer,
    in_ord_timestamp integer,
    in_ord_userdefined1 character varying(510) COLLATE public.nocase,
    in_ord_userdefined2 character varying(510) COLLATE public.nocase,
    in_ord_userdefined3 character varying(510) COLLATE public.nocase,
    in_createdby character varying(60) COLLATE public.nocase,
    in_created_date timestamp without time zone,
    in_modifiedby character varying(60) COLLATE public.nocase,
    in_modified_date timestamp without time zone,
    in_ord_contract_id character varying(40) COLLATE public.nocase,
    in_ord_contract_amend_no integer,
    in_ord_wf_status character varying(510) COLLATE public.nocase,
    in_ord_reasonforreturn character varying(510) COLLATE public.nocase,
    in_ord_stk_acc_level character varying(80) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_internalorderheader ALTER COLUMN in_ord_hdr_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_internalorderheader_in_ord_hdr_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_internalorderheader
    ADD CONSTRAINT f_internalorderheader_pkey PRIMARY KEY (in_ord_hdr_key);

ALTER TABLE ONLY dwh.f_internalorderheader
    ADD CONSTRAINT f_internalorderheader_ukey UNIQUE (in_ord_location, in_ord_no, in_ord_ou);

ALTER TABLE ONLY dwh.f_internalorderheader
    ADD CONSTRAINT f_internalorderheader_in_ord_hdr_customer_key_fkey FOREIGN KEY (in_ord_hdr_customer_key) REFERENCES dwh.d_customer(customer_key);

ALTER TABLE ONLY dwh.f_internalorderheader
    ADD CONSTRAINT f_internalorderheader_in_ord_hdr_loc_key_fkey FOREIGN KEY (in_ord_hdr_loc_key) REFERENCES dwh.d_location(loc_key);

CREATE INDEX f_internalorderheader_key_idx ON dwh.f_internalorderheader USING btree (in_ord_hdr_customer_key, in_ord_hdr_loc_key);