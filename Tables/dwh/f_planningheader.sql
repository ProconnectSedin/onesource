CREATE TABLE dwh.f_planningheader (
    plph_hdr_key bigint NOT NULL,
    plph_loc_key bigint NOT NULL,
    plph_ouinstance integer,
    plph_plan_run_no character varying(40) COLLATE public.nocase,
    plph_status character varying(80) COLLATE public.nocase,
    plph_description character varying(1000) COLLATE public.nocase,
    plph_planning_profile_no character varying(80) COLLATE public.nocase,
    plph_plan_location_no character varying(80) COLLATE public.nocase,
    plph_created_by character varying(60) COLLATE public.nocase,
    plph_created_date timestamp without time zone,
    plph_last_modified_by character varying(60) COLLATE public.nocase,
    plph_last_modified_date timestamp without time zone,
    plph_plan_mode character varying(80) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_planningheader ALTER COLUMN plph_hdr_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_planningheader_plph_hdr_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_planningheader
    ADD CONSTRAINT f_planningheader_pkey PRIMARY KEY (plph_hdr_key);

ALTER TABLE ONLY dwh.f_planningheader
    ADD CONSTRAINT f_planningheader_ukey UNIQUE (plph_ouinstance, plph_plan_run_no);

ALTER TABLE ONLY dwh.f_planningheader
    ADD CONSTRAINT f_planningheader_plph_loc_key_fkey FOREIGN KEY (plph_loc_key) REFERENCES dwh.d_location(loc_key);

CREATE INDEX f_planningheader_key_idx ON dwh.f_planningheader USING btree (plph_loc_key);

CREATE INDEX f_planningheader_key_idx1 ON dwh.f_planningheader USING btree (plph_ouinstance, plph_plan_run_no);