CREATE TABLE dwh.f_tripthuserialdetail (
    plttsd_srl_dtl_key bigint NOT NULL,
    plttd_trip_thu_key bigint NOT NULL,
    plttsd_ouinstance integer,
    plttsd_trip_plan_id character varying(80) COLLATE public.nocase,
    plttsd_plan_line_id character varying(300) COLLATE public.nocase,
    plttsd_thu_line_id character varying(300) COLLATE public.nocase,
    plttsd_serial_line_id character varying(300) COLLATE public.nocase,
    plttsd_serial character varying(80) COLLATE public.nocase,
    plttsd_serial_qty numeric(13,2),
    plttsd_created_by character varying(80) COLLATE public.nocase,
    plttsd_created_date timestamp without time zone,
    plttsd_modified_by character varying(80) COLLATE public.nocase,
    plttsd_modified_date timestamp without time zone,
    plttsd_dispatch character varying(80) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_tripthuserialdetail ALTER COLUMN plttsd_srl_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_tripthuserialdetail_plttsd_srl_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_tripthuserialdetail
    ADD CONSTRAINT f_tripthuserialdetail_pkey PRIMARY KEY (plttsd_srl_dtl_key);

ALTER TABLE ONLY dwh.f_tripthuserialdetail
    ADD CONSTRAINT f_tripthuserialdetail_plttd_trip_thu_key_fkey FOREIGN KEY (plttd_trip_thu_key) REFERENCES dwh.f_tripthudetail(plttd_trip_thu_key);

CREATE INDEX f_tripthuserialdetail_key_idx ON dwh.f_tripthuserialdetail USING btree (plttd_trip_thu_key);

CREATE INDEX f_tripthuserialdetail_key_idx1 ON dwh.f_tripthuserialdetail USING btree (plttsd_ouinstance, plttsd_trip_plan_id, plttsd_thu_line_id, plttsd_dispatch);