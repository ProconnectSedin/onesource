CREATE TABLE dwh.f_grplandetail (
    gr_pln_key bigint NOT NULL,
    gr_loc_key bigint NOT NULL,
    gr_date_key bigint NOT NULL,
    gr_loc_code character varying(20) COLLATE public.nocase,
    gr_pln_no character varying(40) COLLATE public.nocase,
    gr_pln_ou integer,
    gr_pln_date timestamp without time zone,
    gr_pln_status character varying(20) COLLATE public.nocase,
    gr_po_no character varying(40) COLLATE public.nocase,
    gr_po_date timestamp without time zone,
    gr_asn_no character varying(40) COLLATE public.nocase,
    gr_asn_date timestamp without time zone,
    gr_employee character varying(80) COLLATE public.nocase,
    gr_remarks character varying(510) COLLATE public.nocase,
    gr_timestamp integer,
    gr_source_stage character varying(510) COLLATE public.nocase,
    gr_source_docno character varying(40) COLLATE public.nocase,
    gr_created_by character varying(60) COLLATE public.nocase,
    gr_created_date timestamp without time zone,
    gr_modified_by character varying(60) COLLATE public.nocase,
    gr_modified_date timestamp without time zone,
    gr_staging_id character varying(40) COLLATE public.nocase,
    gr_build_uid integer,
    gr_notype character varying(510) COLLATE public.nocase,
    gr_ref_type character varying(510) COLLATE public.nocase,
    gr_pln_product_status character varying(80) COLLATE public.nocase,
    gr_pln_coo character varying(100) COLLATE public.nocase,
    gr_pln_item_attribute1 character varying(100) COLLATE public.nocase,
    gr_pln_item_attribute2 character varying(100) COLLATE public.nocase,
    gr_pln_item_attribute3 character varying(100) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    gr_emp_key bigint
);

ALTER TABLE dwh.f_grplandetail ALTER COLUMN gr_pln_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_grplandetail_gr_pln_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_grplandetail
    ADD CONSTRAINT f_grplandetail_pkey PRIMARY KEY (gr_pln_key);

ALTER TABLE ONLY dwh.f_grplandetail
    ADD CONSTRAINT f_grplandetail_ukey UNIQUE (gr_loc_code, gr_pln_no, gr_pln_ou);

ALTER TABLE ONLY dwh.f_grplandetail
    ADD CONSTRAINT f_grplandetail_gr_date_key_fkey FOREIGN KEY (gr_date_key) REFERENCES dwh.d_date(datekey);

ALTER TABLE ONLY dwh.f_grplandetail
    ADD CONSTRAINT f_grplandetail_gr_emp_key_fkey FOREIGN KEY (gr_emp_key) REFERENCES dwh.d_employeeheader(emp_hdr_key);

ALTER TABLE ONLY dwh.f_grplandetail
    ADD CONSTRAINT f_grplandetail_gr_loc_key_fkey FOREIGN KEY (gr_loc_key) REFERENCES dwh.d_location(loc_key);

CREATE INDEX f_grplandetail_key_idx ON dwh.f_grplandetail USING btree (gr_loc_key, gr_date_key);

CREATE INDEX f_grplandetail_key_idx1 ON dwh.f_grplandetail USING btree (gr_loc_code, gr_pln_no, gr_pln_ou, gr_po_no, gr_asn_no);