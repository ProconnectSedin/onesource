CREATE TABLE dwh.f_packexecheader (
    pack_exe_hdr_key bigint NOT NULL,
    pack_loc_key bigint NOT NULL,
    pack_loc_code character varying(20) COLLATE public.nocase,
    pack_exec_no character varying(40) COLLATE public.nocase,
    pack_exec_ou integer,
    pack_exec_date timestamp without time zone,
    pack_exec_status character varying(20) COLLATE public.nocase,
    pack_pln_no character varying(40) COLLATE public.nocase,
    pack_employee character varying(40) COLLATE public.nocase,
    pack_packing_bay character varying(40) COLLATE public.nocase,
    pack_pre_pack_bay character varying(40) COLLATE public.nocase,
    pack_created_by character varying(60) COLLATE public.nocase,
    pack_created_date timestamp without time zone,
    pack_modified_by character varying(60) COLLATE public.nocase,
    pack_modified_date timestamp without time zone,
    pack_timestamp integer,
    pack_exec_start_date timestamp without time zone,
    pack_exec_end_date timestamp without time zone,
    pack_exe_urgent integer,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_packexecheader ALTER COLUMN pack_exe_hdr_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_packexecheader_pack_exe_hdr_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_packexecheader
    ADD CONSTRAINT f_packexecheader_pkey PRIMARY KEY (pack_exe_hdr_key);

ALTER TABLE ONLY dwh.f_packexecheader
    ADD CONSTRAINT f_packexecheader_ukey UNIQUE (pack_loc_code, pack_exec_no, pack_exec_ou);

ALTER TABLE ONLY dwh.f_packexecheader
    ADD CONSTRAINT f_packexecheader_pack_loc_key_fkey FOREIGN KEY (pack_loc_key) REFERENCES dwh.d_location(loc_key);

CREATE INDEX f_packexecheader_key_idx ON dwh.f_packexecheader USING btree (pack_loc_key);

CREATE INDEX f_packexecheader_key_idx1 ON dwh.f_packexecheader USING btree (pack_exec_ou, pack_loc_code, pack_exec_no);