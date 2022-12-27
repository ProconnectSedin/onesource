CREATE TABLE dwh.f_tripresourcescheduledetail (
    trsd_trip_sdl_dtl_key bigint NOT NULL,
    trsd_vendor_key bigint NOT NULL,
    trsd_ouinstance integer,
    trsd_trip_plan_id character varying(40) COLLATE public.nocase,
    trsd_trip_beh character varying(80) COLLATE public.nocase,
    trsd_sch_status character varying(80) COLLATE public.nocase,
    trsd_resource_type character varying(80) COLLATE public.nocase,
    trsd_resource_id character varying(80) COLLATE public.nocase,
    trsd_sch_date_from timestamp without time zone,
    trsd_sch_date_to character varying(50) COLLATE public.nocase,
    trsd_sch_loc_from character varying(80) COLLATE public.nocase,
    trsd_sch_loc_to character varying(80) COLLATE public.nocase,
    trsd_created_by character varying(60) COLLATE public.nocase,
    trsd_created_date character varying(50) COLLATE public.nocase,
    trsd_modified_by character varying(60) COLLATE public.nocase,
    trsd_modified_date character varying(50) COLLATE public.nocase,
    trsd_act_date_from character varying(50) COLLATE public.nocase,
    trsd_act_date_to character varying(50) COLLATE public.nocase,
    trsd_ser_type character varying(510) COLLATE public.nocase,
    trsd_sub_ser_type character varying(510) COLLATE public.nocase,
    trsd_timestamp integer,
    trsd_vendor_id character varying(510) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_tripresourcescheduledetail ALTER COLUMN trsd_trip_sdl_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_tripresourcescheduledetail_trsd_trip_sdl_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_tripresourcescheduledetail
    ADD CONSTRAINT f_tripresourcescheduledetail_pkey PRIMARY KEY (trsd_trip_sdl_dtl_key);

ALTER TABLE ONLY dwh.f_tripresourcescheduledetail
    ADD CONSTRAINT f_tripresourcescheduledetail_trsd_vendor_key_fkey FOREIGN KEY (trsd_vendor_key) REFERENCES dwh.d_vendor(vendor_key);

CREATE INDEX f_tripresourcescheduledetail_key_idx ON dwh.f_tripresourcescheduledetail USING btree (trsd_vendor_key);

CREATE INDEX f_tripresourcescheduledetail_key_idx1 ON dwh.f_tripresourcescheduledetail USING btree (trsd_ouinstance, trsd_trip_plan_id, trsd_resource_type, trsd_resource_id);