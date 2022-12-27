CREATE TABLE dwh.f_execthuserialdetail (
    pletsd_exc_srl_thu_dtl_key bigint NOT NULL,
    plepd_trip_exe_pln_dtl_key bigint NOT NULL,
    pletsd_ouinstance integer,
    pletsd_execution_plan_id character varying(80) COLLATE public.nocase,
    pletsd_line_no character varying(300) COLLATE public.nocase,
    pletsd_thu_line_no character varying(300) COLLATE public.nocase,
    pletsd_serial_line_no character varying(300) COLLATE public.nocase,
    pletsd_serial character varying(80) COLLATE public.nocase,
    pletsd_serial_available_qty numeric(25,2),
    pletsd_serial_draft_qty numeric(25,2),
    pletsd_serial_confirmed_qty numeric(25,2),
    pletsd_serail_available_weight numeric(25,2),
    pletsd_serial_draft_weight numeric(25,2),
    pletsd_serial_confirmed_weight numeric(25,2),
    pletsd_serial_available_volume numeric(25,2),
    pletsd_serial_draft_volume numeric(25,2),
    pletsd_serial_confirmed_volume numeric(25,2),
    pletsd_created_by character varying(60) COLLATE public.nocase,
    pletsd_created_date character varying(50) COLLATE public.nocase,
    pletsd_modified_by character varying(60) COLLATE public.nocase,
    pletsd_modified_date character varying(50) COLLATE public.nocase,
    pletsd_timestamp integer,
    pletsd_serial_initiated_qty numeric(25,2),
    pletsd_serial_executed_qty numeric(25,2),
    pletsd_serial_initiated_weight numeric(25,2),
    pletsd_serial_executed_weight numeric(25,2),
    pletsd_serial_initiated_volume numeric(25,2),
    pletsd_serial_executed_volume numeric(25,2),
    pletsd_serial_dropped_off integer,
    pletsd_serial_dispatch character varying(80) COLLATE public.nocase,
    pletsd_updated_by character varying(510) COLLATE public.nocase,
    pletsd_picked_shortclosure integer,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_execthuserialdetail ALTER COLUMN pletsd_exc_srl_thu_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_execthuserialdetail_pletsd_exc_srl_thu_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_execthuserialdetail
    ADD CONSTRAINT f_execthuserialdetail_pkey PRIMARY KEY (pletsd_exc_srl_thu_dtl_key);

ALTER TABLE ONLY dwh.f_execthuserialdetail
    ADD CONSTRAINT f_execthuserialdetail_plepd_trip_exe_pln_dtl_key_fkey FOREIGN KEY (plepd_trip_exe_pln_dtl_key) REFERENCES dwh.f_tripexecutionplandetail(plepd_trip_exe_pln_dtl_key);

CREATE INDEX f_execthuserialdetail_key_idx ON dwh.f_execthuserialdetail USING btree (plepd_trip_exe_pln_dtl_key);

CREATE INDEX f_execthuserialdetail_key_idx1 ON dwh.f_execthuserialdetail USING btree (pletsd_ouinstance, pletsd_execution_plan_id, pletsd_line_no, pletsd_thu_line_no, pletsd_serial_line_no);