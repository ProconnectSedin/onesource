CREATE TABLE dwh.f_packstoragedetail (
    pack_storage_dtl_key bigint NOT NULL,
    pack_storage_dtl_loc_key bigint NOT NULL,
    pack_location character varying(510) COLLATE public.nocase,
    pack_ou integer,
    pack_lineno integer,
    pack_storage_zone character varying(20) COLLATE public.nocase,
    pack_pack_zone character varying(20) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_packstoragedetail ALTER COLUMN pack_storage_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_packstoragedetail_pack_storage_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_packstoragedetail
    ADD CONSTRAINT f_packstoragedetail_pkey PRIMARY KEY (pack_storage_dtl_key);

ALTER TABLE ONLY dwh.f_packstoragedetail
    ADD CONSTRAINT f_packstoragedetail_ukey UNIQUE (pack_location, pack_ou, pack_lineno);

ALTER TABLE ONLY dwh.f_packstoragedetail
    ADD CONSTRAINT f_packstoragedetail_pack_storage_dtl_loc_key_fkey FOREIGN KEY (pack_storage_dtl_loc_key) REFERENCES dwh.d_location(loc_key);

CREATE INDEX f_packstoragedetail_key_idx ON dwh.f_packstoragedetail USING btree (pack_location, pack_ou, pack_lineno);

CREATE INDEX f_packstoragedetail_key_idx1 ON dwh.f_packstoragedetail USING btree (pack_storage_dtl_loc_key);