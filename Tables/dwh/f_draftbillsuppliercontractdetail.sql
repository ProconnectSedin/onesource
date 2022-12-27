CREATE TABLE dwh.f_draftbillsuppliercontractdetail (
    draft_bill_key bigint NOT NULL,
    draft_bill_location_key bigint NOT NULL,
    draft_bill_ou integer,
    draft_bill_location character varying(20) COLLATE public.nocase,
    draft_bill_division character varying(20) COLLATE public.nocase,
    draft_bill_tran_type character varying(50) COLLATE public.nocase,
    draft_bill_ref_doc_no character varying(40) COLLATE public.nocase,
    draft_bill_ref_doc_type character varying(20) COLLATE public.nocase,
    draft_bill_contract_id character varying(40) COLLATE public.nocase,
    draft_bill_contract_amend_no integer,
    draft_bill_vendor_id character varying(64) COLLATE public.nocase,
    draft_bill_created_by character varying(60) COLLATE public.nocase,
    draft_bill_created_date timestamp without time zone,
    draft_bill_billing_status character varying(20) COLLATE public.nocase,
    draft_bill_value numeric(13,2),
    draft_bill_booking_location character varying(20) COLLATE public.nocase,
    draft_bill_modified_by character varying(60) COLLATE public.nocase,
    draft_bill_modified_date timestamp without time zone,
    draft_bill_last_depart_date timestamp without time zone,
    draft_bill_resource_type character varying(510) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_draftbillsuppliercontractdetail ALTER COLUMN draft_bill_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_draftbillsuppliercontractdetail_draft_bill_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_draftbillsuppliercontractdetail
    ADD CONSTRAINT f_draftbillsuppliercontractdetail_pkey PRIMARY KEY (draft_bill_key);

ALTER TABLE ONLY dwh.f_draftbillsuppliercontractdetail
    ADD CONSTRAINT f_draftbillsuppliercontractdetail_ukey UNIQUE (draft_bill_ou, draft_bill_location, draft_bill_division, draft_bill_tran_type, draft_bill_ref_doc_no, draft_bill_ref_doc_type, draft_bill_vendor_id, draft_bill_resource_type);

ALTER TABLE ONLY dwh.f_draftbillsuppliercontractdetail
    ADD CONSTRAINT f_draftbillsuppliercontractdetail_draft_bill_location_key_fkey FOREIGN KEY (draft_bill_location_key) REFERENCES dwh.d_location(loc_key);

CREATE INDEX f_draftbillsuppliercontractdetail_key_idx ON dwh.f_draftbillsuppliercontractdetail USING btree (draft_bill_ou, draft_bill_location, draft_bill_division, draft_bill_tran_type, draft_bill_ref_doc_no, draft_bill_ref_doc_type, draft_bill_vendor_id, draft_bill_resource_type);