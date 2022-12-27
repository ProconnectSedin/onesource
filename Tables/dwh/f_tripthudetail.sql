CREATE TABLE dwh.f_tripthudetail (
    plttd_trip_thu_key bigint NOT NULL,
    plttd_thu_key bigint NOT NULL,
    plttd_ouinstance integer,
    plttd_trip_plan_id character varying(160) COLLATE public.nocase,
    plttd_trip_plan_line_no character varying(512) COLLATE public.nocase,
    plttd_thu_line_no character varying(512) COLLATE public.nocase,
    plttd_thu_qty numeric,
    plttd_thu_weight numeric,
    plttd_thu_vol numeric,
    plttd_created_by character varying(120) COLLATE public.nocase,
    plttd_created_date character varying(100) COLLATE public.nocase,
    plttd_modified_by character varying(120) COLLATE public.nocase,
    plttd_modified_date character varying(100) COLLATE public.nocase,
    plttd_dispatch_doc_no character varying(1020) COLLATE public.nocase,
    plttd_thu_id character varying(1020) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_tripthudetail ALTER COLUMN plttd_trip_thu_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_tripthudetail_plttd_trip_thu_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_tripthudetail
    ADD CONSTRAINT f_tripthudetail_pkey PRIMARY KEY (plttd_trip_thu_key);

ALTER TABLE ONLY dwh.f_tripthudetail
    ADD CONSTRAINT f_tripthudetail_ukey UNIQUE (plttd_ouinstance, plttd_trip_plan_id, plttd_trip_plan_line_no, plttd_thu_line_no, plttd_dispatch_doc_no);

ALTER TABLE ONLY dwh.f_tripthudetail
    ADD CONSTRAINT f_tripthudetail_plttd_thu_key_fkey FOREIGN KEY (plttd_thu_key) REFERENCES dwh.d_thu(thu_key);

CREATE INDEX f_tripthudetail_key_idx ON dwh.f_tripthudetail USING btree (plttd_thu_key);

CREATE INDEX f_tripthudetail_key_idx1 ON dwh.f_tripthudetail USING btree (plttd_ouinstance, plttd_trip_plan_id, plttd_trip_plan_line_no, plttd_thu_line_no, plttd_dispatch_doc_no);

CREATE INDEX f_tripthudetail_key_idx2 ON dwh.f_tripthudetail USING btree (plttd_thu_id, plttd_ouinstance);