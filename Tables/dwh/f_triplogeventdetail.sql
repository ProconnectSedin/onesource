CREATE TABLE dwh.f_triplogeventdetail (
    tled_trip_log_dtl_key bigint NOT NULL,
    plpth_hdr_key bigint NOT NULL,
    tled_ouinstance integer,
    tled_trip_plan_id character varying(40) COLLATE public.nocase,
    tled_trip_plan_line_no character varying(300) COLLATE public.nocase,
    tled_bkr_id character varying(40) COLLATE public.nocase,
    tled_leg_no character varying(40) COLLATE public.nocase,
    tled_event_id character varying(80) COLLATE public.nocase,
    tled_actual_date_time timestamp without time zone,
    tled_remarks1 character varying(300) COLLATE public.nocase,
    tled_reason_code character varying(80) COLLATE public.nocase,
    tled_reason_description character varying(510) COLLATE public.nocase,
    tled_created_date character varying(50) COLLATE public.nocase,
    tled_created_by character varying(60) COLLATE public.nocase,
    tled_modified_date timestamp without time zone,
    tled_modified_by character varying(60) COLLATE public.nocase,
    tled_timestamp integer,
    tled_planned_datetime timestamp without time zone,
    tled_trip_plan_unique_id character varying(300) COLLATE public.nocase,
    tled_event_nod character varying(510) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    tled_actual_date_key bigint
);

ALTER TABLE dwh.f_triplogeventdetail ALTER COLUMN tled_trip_log_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_triplogeventdetail_tled_trip_log_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_triplogeventdetail
    ADD CONSTRAINT f_triplogeventdetail_pkey PRIMARY KEY (tled_trip_log_dtl_key);

ALTER TABLE ONLY dwh.f_triplogeventdetail
    ADD CONSTRAINT f_triplogeventdetail_ukey UNIQUE (tled_ouinstance, tled_trip_plan_id, tled_trip_plan_unique_id);

ALTER TABLE ONLY dwh.f_triplogeventdetail
    ADD CONSTRAINT f_triplogeventdetail_plpth_hdr_key_fkey FOREIGN KEY (plpth_hdr_key) REFERENCES dwh.f_tripplanningheader(plpth_hdr_key);

CREATE INDEX f_triplogeventdetail_key_idx ON dwh.f_triplogeventdetail USING btree (plpth_hdr_key);

CREATE INDEX f_triplogeventdetail_key_idx1 ON dwh.f_triplogeventdetail USING btree (tled_ouinstance, tled_trip_plan_id, tled_trip_plan_unique_id);

CREATE INDEX f_triplogeventdetail_key_idx2 ON dwh.f_triplogeventdetail USING btree (tled_actual_date_time);