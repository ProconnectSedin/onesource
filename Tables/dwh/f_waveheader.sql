CREATE TABLE dwh.f_waveheader (
    wave_hdr_key bigint NOT NULL,
    wave_loc_key bigint NOT NULL,
    wave_loc_code character varying(20) COLLATE public.nocase,
    wave_no character varying(40) COLLATE public.nocase,
    wave_ou integer,
    wave_date timestamp without time zone,
    wave_status character varying(20) COLLATE public.nocase,
    wave_pln_start_date timestamp without time zone,
    wave_pln_end_date timestamp without time zone,
    wave_timestamp integer,
    wave_created_by character varying(60) COLLATE public.nocase,
    wave_created_date timestamp without time zone,
    wave_modified_by character varying(60) COLLATE public.nocase,
    wave_modified_date timestamp without time zone,
    wave_alloc_rule character varying(20) COLLATE public.nocase,
    wave_alloc_value numeric(13,2),
    wave_alloc_uom character varying(20) COLLATE public.nocase,
    wave_no_of_pickers integer,
    wave_gen_flag character varying(20) COLLATE public.nocase,
    wave_staging_id character varying(40) COLLATE public.nocase,
    wave_replenish_flag character varying(30) COLLATE public.nocase,
    consolidated_flg character varying(20) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_waveheader ALTER COLUMN wave_hdr_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_waveheader_wave_hdr_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_waveheader
    ADD CONSTRAINT f_waveheader_pkey PRIMARY KEY (wave_hdr_key);

ALTER TABLE ONLY dwh.f_waveheader
    ADD CONSTRAINT f_waveheader_ukey UNIQUE (wave_loc_code, wave_no, wave_ou);

ALTER TABLE ONLY dwh.f_waveheader
    ADD CONSTRAINT f_waveheader_wave_loc_key_fkey FOREIGN KEY (wave_loc_key) REFERENCES dwh.d_location(loc_key);

CREATE INDEX f_waveheader_key_idx ON dwh.f_waveheader USING btree (wave_loc_key);

CREATE INDEX f_waveheader_key_idx1 ON dwh.f_waveheader USING btree (wave_loc_code, wave_no, wave_ou);