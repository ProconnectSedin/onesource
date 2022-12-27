CREATE TABLE dwh.f_grthuheader (
    gr_thu_hdr_key bigint NOT NULL,
    gr_loc_key bigint NOT NULL,
    gr_thu_key bigint NOT NULL,
    gr_loc_code character varying(20) COLLATE public.nocase,
    gr_exec_no character varying(40) COLLATE public.nocase,
    gr_exec_ou integer,
    gr_thu_id character varying(80) COLLATE public.nocase,
    gr_thu_sno character varying(60) COLLATE public.nocase,
    gr_thu_desc character varying(510) COLLATE public.nocase,
    gr_thu_sr_status character varying(20) COLLATE public.nocase,
    gr_thu_su character varying(20) COLLATE public.nocase,
    gr_thu_uid_ser_no character varying(80) COLLATE public.nocase,
    gr_pal_status character varying(80) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_grthuheader ALTER COLUMN gr_thu_hdr_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_grthuheader_gr_thu_hdr_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_grthuheader
    ADD CONSTRAINT f_grthuheader_pkey PRIMARY KEY (gr_thu_hdr_key);

ALTER TABLE ONLY dwh.f_grthuheader
    ADD CONSTRAINT f_grthuheader_ukey UNIQUE (gr_loc_code, gr_exec_no, gr_exec_ou, gr_thu_id, gr_thu_sno, gr_thu_su, gr_thu_uid_ser_no);

ALTER TABLE ONLY dwh.f_grthuheader
    ADD CONSTRAINT f_grthuheader_gr_loc_key_fkey FOREIGN KEY (gr_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_grthuheader
    ADD CONSTRAINT f_grthuheader_gr_thu_key_fkey FOREIGN KEY (gr_thu_key) REFERENCES dwh.d_thu(thu_key);

CREATE INDEX f_grthuheader_key_idx ON dwh.f_grthuheader USING btree (gr_loc_key, gr_thu_key);

CREATE INDEX f_grthuheader_key_idx1 ON dwh.f_grthuheader USING btree (gr_loc_code, gr_exec_no, gr_exec_ou, gr_thu_id, gr_thu_sno, gr_thu_su, gr_thu_uid_ser_no);