CREATE TABLE dwh.f_draftbillheader (
    draft_bill_hdr_key bigint NOT NULL,
    draft_loc_key bigint NOT NULL,
    draft_cust_key bigint NOT NULL,
    draft_curr_key bigint NOT NULL,
    draft_bill_no character varying(40) COLLATE public.nocase,
    draft_bill_ou integer,
    draft_bill_location character varying(20) COLLATE public.nocase,
    draft_bill_division character varying(20) COLLATE public.nocase,
    draft_bill_date timestamp without time zone,
    draft_bill_status character varying(20) COLLATE public.nocase,
    draft_bill_contract_id character varying(40) COLLATE public.nocase,
    draft_bill_cust_cont_ref_no character varying(140) COLLATE public.nocase,
    draft_bill_customer character varying(40) COLLATE public.nocase,
    draft_bill_supplier character varying(40) COLLATE public.nocase,
    draft_bill_currency character varying(20) COLLATE public.nocase,
    draft_bill_cost_centre character varying(20) COLLATE public.nocase,
    draft_bill_value numeric,
    draft_bill_discount numeric,
    draft_bill_total_value numeric,
    draft_bill_inv_no character varying(40) COLLATE public.nocase,
    draft_bill_inv_date timestamp without time zone,
    draft_bill_inv_status character varying(20) COLLATE public.nocase,
    draft_bill_timestamp integer,
    draft_bill_created_by character varying(60) COLLATE public.nocase,
    draft_bill_created_date timestamp without time zone,
    draft_bill_modified_by character varying(60) COLLATE public.nocase,
    draft_bill_modified_date timestamp without time zone,
    draft_bill_contract_amend_no integer,
    draft_bill_tran_type character varying(20) COLLATE public.nocase,
    draft_bill_margin numeric,
    draft_bill_gen_from character varying(50) COLLATE public.nocase,
    draft_bill_booking_location character varying(20) COLLATE public.nocase,
    draft_bill_period_from timestamp without time zone,
    draft_bill_period_to timestamp without time zone,
    draft_bill_remarks character varying(510) COLLATE public.nocase,
    draft_bill_workflow_status character varying(510) COLLATE public.nocase,
    draft_bill_reason_for_return character varying(510) COLLATE public.nocase,
    draft_bill_grp character varying(80) COLLATE public.nocase,
    draft_bill_type character varying(510) COLLATE public.nocase,
    draft_bill_br_remittance_yn character varying(510) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_draftbillheader ALTER COLUMN draft_bill_hdr_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_draftbillheader_draft_bill_hdr_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_draftbillheader
    ADD CONSTRAINT f_draftbillheader_pkey PRIMARY KEY (draft_bill_hdr_key);

ALTER TABLE ONLY dwh.f_draftbillheader
    ADD CONSTRAINT f_draftbillheader_ukey UNIQUE (draft_bill_no, draft_bill_ou);

ALTER TABLE ONLY dwh.f_draftbillheader
    ADD CONSTRAINT f_draftbillheader_draft_curr_key_fkey FOREIGN KEY (draft_curr_key) REFERENCES dwh.d_currency(curr_key);

ALTER TABLE ONLY dwh.f_draftbillheader
    ADD CONSTRAINT f_draftbillheader_draft_cust_key_fkey FOREIGN KEY (draft_cust_key) REFERENCES dwh.d_customer(customer_key);

ALTER TABLE ONLY dwh.f_draftbillheader
    ADD CONSTRAINT f_draftbillheader_draft_loc_key_fkey FOREIGN KEY (draft_loc_key) REFERENCES dwh.d_location(loc_key);

CREATE INDEX f_draftbillheader_key_idx ON dwh.f_draftbillheader USING btree (draft_loc_key, draft_cust_key, draft_curr_key);

CREATE INDEX f_draftbillheader_key_idx1 ON dwh.f_draftbillheader USING btree (draft_bill_no, draft_bill_ou);

CREATE INDEX f_draftbillheader_key_idx2 ON dwh.f_draftbillheader USING btree (draft_bill_ou, draft_bill_contract_id, draft_bill_supplier);