CREATE TABLE dwh.f_pickplanheader (
    pick_pln_hdr_key bigint NOT NULL,
    pick_pln_loc_key bigint NOT NULL,
    pick_loc_code character varying(20) COLLATE public.nocase,
    pick_pln_no character varying(40) COLLATE public.nocase,
    pick_pln_ou integer,
    pick_pln_date timestamp without time zone,
    pick_pln_status character varying(20) COLLATE public.nocase,
    pick_employee character varying(80) COLLATE public.nocase,
    pick_mhe character varying(60) COLLATE public.nocase,
    pick_staging_id character varying(40) COLLATE public.nocase,
    pick_created_by character varying(60) COLLATE public.nocase,
    pick_created_date timestamp without time zone,
    pick_modified_by character varying(60) COLLATE public.nocase,
    pick_modified_date timestamp without time zone,
    pick_timestamp integer,
    pick_output_pln character varying(20) COLLATE public.nocase,
    pick_steps character varying(40) COLLATE public.nocase,
    pick_pln_urgent integer,
    pick_second_pln_no character varying(40) COLLATE public.nocase,
    pick_completed_flag character varying(20) COLLATE public.nocase,
    pick_pln_type character varying(20) COLLATE public.nocase,
    pick_zone_pickby character varying(20) COLLATE public.nocase,
    pick_conso_pln_no character varying(40) COLLATE public.nocase,
    consolidated_pick_flg character varying(20) COLLATE public.nocase,
    pick_consol_auto_cmplt character varying(20) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_pickplanheader ALTER COLUMN pick_pln_hdr_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_pickplanheader_pick_pln_hdr_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_pickplanheader
    ADD CONSTRAINT f_pickplanheader_pkey PRIMARY KEY (pick_pln_hdr_key);

ALTER TABLE ONLY dwh.f_pickplanheader
    ADD CONSTRAINT f_pickplanheader_ukey UNIQUE (pick_loc_code, pick_pln_no, pick_pln_ou);

ALTER TABLE ONLY dwh.f_pickplanheader
    ADD CONSTRAINT f_pickplanheader_pick_pln_loc_key_fkey FOREIGN KEY (pick_pln_loc_key) REFERENCES dwh.d_location(loc_key);

CREATE INDEX f_pickplanheader_key_idx ON dwh.f_pickplanheader USING btree (pick_pln_loc_key);

CREATE INDEX f_pickplanheader_key_idx1 ON dwh.f_pickplanheader USING btree (pick_loc_code, pick_pln_no, pick_pln_ou);