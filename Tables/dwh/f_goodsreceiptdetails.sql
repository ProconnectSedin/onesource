CREATE TABLE dwh.f_goodsreceiptdetails (
    gr_dtl_key bigint NOT NULL,
    gr_loc_key bigint NOT NULL,
    gr_emp_hdr_key bigint NOT NULL,
    gr_date_key bigint NOT NULL,
    gr_stg_mas_key bigint NOT NULL,
    gr_loc_code character varying(20) COLLATE public.nocase,
    gr_exec_no character varying(40) COLLATE public.nocase,
    gr_exec_ou integer,
    gr_pln_no character varying(40) COLLATE public.nocase,
    gr_pln_ou integer,
    gr_pln_date timestamp without time zone,
    gr_po_no character varying(40) COLLATE public.nocase,
    gr_no character varying(40) COLLATE public.nocase,
    gr_emp character varying(80) COLLATE public.nocase,
    gr_start_date timestamp without time zone,
    gr_end_date timestamp without time zone,
    gr_exec_status character varying(20) COLLATE public.nocase,
    gr_created_by character varying(60) COLLATE public.nocase,
    gr_created_date timestamp without time zone,
    gr_modified_by character varying(60) COLLATE public.nocase,
    gr_modified_date timestamp without time zone,
    gr_timestamp integer,
    gr_asn_no character varying(40) COLLATE public.nocase,
    gr_staging_id character varying(40) COLLATE public.nocase,
    gr_exec_date timestamp without time zone,
    gr_build_complete character varying(20) COLLATE public.nocase,
    gr_notype character varying(510) COLLATE public.nocase,
    gr_ref_type character varying(510) COLLATE public.nocase,
    gr_gen_from character varying(16) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_goodsreceiptdetails ALTER COLUMN gr_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_goodsreceiptdetails_gr_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_goodsreceiptdetails
    ADD CONSTRAINT f_goodsreceiptdetails_pkey PRIMARY KEY (gr_dtl_key);

ALTER TABLE ONLY dwh.f_goodsreceiptdetails
    ADD CONSTRAINT f_goodsreceiptdetails_ukey UNIQUE (gr_loc_code, gr_exec_no, gr_exec_ou);

ALTER TABLE ONLY dwh.f_goodsreceiptdetails
    ADD CONSTRAINT f_goodsreceiptdetails_gr_date_key_fkey FOREIGN KEY (gr_date_key) REFERENCES dwh.d_date(datekey);

ALTER TABLE ONLY dwh.f_goodsreceiptdetails
    ADD CONSTRAINT f_goodsreceiptdetails_gr_emp_hdr_key_fkey FOREIGN KEY (gr_emp_hdr_key) REFERENCES dwh.d_employeeheader(emp_hdr_key);

ALTER TABLE ONLY dwh.f_goodsreceiptdetails
    ADD CONSTRAINT f_goodsreceiptdetails_gr_loc_key_fkey FOREIGN KEY (gr_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_goodsreceiptdetails
    ADD CONSTRAINT f_goodsreceiptdetails_gr_stg_mas_key_fkey FOREIGN KEY (gr_stg_mas_key) REFERENCES dwh.d_stage(stg_mas_key);

CREATE INDEX f_goodsreceiptdetails_join_idx ON dwh.f_goodsreceiptdetails USING btree (gr_loc_code, gr_pln_no, gr_pln_ou, gr_exec_no, gr_exec_ou, gr_po_no);

CREATE INDEX f_goodsreceiptdetails_key_idx ON dwh.f_goodsreceiptdetails USING btree (gr_loc_key, gr_emp_hdr_key, gr_date_key, gr_stg_mas_key);