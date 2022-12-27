CREATE TABLE dwh.f_tripododetail (
    plpto_trp_odo_dtl_key bigint NOT NULL,
    plpth_hdr_key bigint NOT NULL,
    plpto_ouinstance integer,
    plpto_guid character varying(300) COLLATE public.nocase,
    plpto_plan_run_no character varying(40) COLLATE public.nocase,
    plpto_trip_plan_id character varying(40) COLLATE public.nocase,
    plpto_trip_plan_line_no character varying(300) COLLATE public.nocase,
    plpto_bk_req_id character varying(40) COLLATE public.nocase,
    plpto_bk_leg_no character varying(40) COLLATE public.nocase,
    plpto_odo_state character varying(80) COLLATE public.nocase,
    plpto_odo_reading numeric(20,2),
    plpto_odo_uom character varying(80) COLLATE public.nocase,
    plpto_created_by character varying(60) COLLATE public.nocase,
    plpto_created_date timestamp without time zone,
    plpto_last_modified_by character varying(60) COLLATE public.nocase,
    plpto_last_modified_date timestamp without time zone,
    plpto_timestamp integer,
    plpto_trip_plan_seq integer,
    plpto_flag character varying(30) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_tripododetail ALTER COLUMN plpto_trp_odo_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_tripododetail_plpto_trp_odo_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_tripododetail
    ADD CONSTRAINT f_tripododetail_pkey PRIMARY KEY (plpto_trp_odo_dtl_key);

ALTER TABLE ONLY dwh.f_tripododetail
    ADD CONSTRAINT f_tripododetail_ukey UNIQUE (plpto_ouinstance, plpto_guid);

ALTER TABLE ONLY dwh.f_tripododetail
    ADD CONSTRAINT f_tripododetail_plpth_hdr_key_fkey FOREIGN KEY (plpth_hdr_key) REFERENCES dwh.f_tripplanningheader(plpth_hdr_key);

CREATE INDEX f_tripododetail_key_idx ON dwh.f_tripododetail USING btree (plpth_hdr_key);