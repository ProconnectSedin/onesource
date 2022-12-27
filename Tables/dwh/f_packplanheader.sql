CREATE TABLE dwh.f_packplanheader (
    pack_pln_hdr_key bigint NOT NULL,
    pack_pln_hdr_loc_key bigint NOT NULL,
    pack_pln_hdr_date_key bigint NOT NULL,
    pack_pln_hdr_emp_hdr_key bigint NOT NULL,
    pack_loc_code character varying(20) COLLATE public.nocase,
    pack_pln_no character varying(40) COLLATE public.nocase,
    pack_pln_ou integer,
    pack_pln_date timestamp without time zone,
    pack_pln_status character varying(20) COLLATE public.nocase,
    pack_employee character varying(40) COLLATE public.nocase,
    pack_packing_bay character varying(40) COLLATE public.nocase,
    pack_source_stage character varying(510) COLLATE public.nocase,
    pack_source_docno character varying(40) COLLATE public.nocase,
    pack_created_by character varying(60) COLLATE public.nocase,
    pack_created_date timestamp without time zone,
    pack_modified_by character varying(60) COLLATE public.nocase,
    pack_modified_date timestamp without time zone,
    pack_timestamp integer,
    pack_userdefined1 character varying(510) COLLATE public.nocase,
    pack_userdefined2 character varying(510) COLLATE public.nocase,
    pack_userdefined3 character varying(510) COLLATE public.nocase,
    pack_pln_urgent integer,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_packplanheader ALTER COLUMN pack_pln_hdr_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_packplanheader_pack_pln_hdr_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_packplanheader
    ADD CONSTRAINT f_packplanheader_pkey PRIMARY KEY (pack_pln_hdr_key);

ALTER TABLE ONLY dwh.f_packplanheader
    ADD CONSTRAINT f_packplanheader_ukey UNIQUE (pack_loc_code, pack_pln_no, pack_pln_ou);

ALTER TABLE ONLY dwh.f_packplanheader
    ADD CONSTRAINT f_packplanheader_pack_pln_hdr_date_key_fkey FOREIGN KEY (pack_pln_hdr_date_key) REFERENCES dwh.d_date(datekey);

ALTER TABLE ONLY dwh.f_packplanheader
    ADD CONSTRAINT f_packplanheader_pack_pln_hdr_emp_hdr_key_fkey FOREIGN KEY (pack_pln_hdr_emp_hdr_key) REFERENCES dwh.d_employeeheader(emp_hdr_key);

ALTER TABLE ONLY dwh.f_packplanheader
    ADD CONSTRAINT f_packplanheader_pack_pln_hdr_loc_key_fkey FOREIGN KEY (pack_pln_hdr_loc_key) REFERENCES dwh.d_location(loc_key);

CREATE INDEX f_packplanheader_key_idx ON dwh.f_packplanheader USING btree (pack_loc_code, pack_pln_no, pack_pln_ou);

CREATE INDEX f_packplanheader_key_idx1 ON dwh.f_packplanheader USING btree (pack_pln_hdr_loc_key, pack_pln_hdr_date_key, pack_pln_hdr_emp_hdr_key);