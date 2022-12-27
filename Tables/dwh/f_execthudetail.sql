CREATE TABLE dwh.f_execthudetail (
    pletd_exe_thu_dtl_key bigint NOT NULL,
    plepd_trip_exe_pln_dtl_key bigint NOT NULL,
    pletd_ouinstance integer,
    pletd_execution_plan_id character varying(80) COLLATE public.nocase,
    pletd_line_no character varying(300) COLLATE public.nocase,
    pletd_thu_line_no character varying(300) COLLATE public.nocase,
    pletd_thu_available_qty numeric(25,2),
    pletd_thu_draft_qty numeric(25,2),
    pletd_thu_confirmed_qty numeric(25,2),
    pletd_thu_available_weight numeric(25,2),
    pletd_thu_draft_weight numeric(25,2),
    pletd_thu_confirmed_weight numeric(25,2),
    pletd_thu_available_volume numeric(25,2),
    pletd_thu_draft_volume numeric(25,2),
    pletd_thu_confirmed_volume numeric(25,2),
    pletd_created_by character varying(60) COLLATE public.nocase,
    pletd_created_date character varying(50) COLLATE public.nocase,
    pletd_modified_by character varying(60) COLLATE public.nocase,
    pletd_modified_date character varying(50) COLLATE public.nocase,
    pletd_updated_by character varying(510) COLLATE public.nocase,
    pletd_timestamp integer,
    pletd_initiated_qty numeric(25,2),
    pletd_executed_qty numeric(25,2),
    pletd_dispatch_docno character varying(510) COLLATE public.nocase,
    pletd_thu_id character varying(510) COLLATE public.nocase,
    pletd_weight numeric(25,2),
    pletd_weight_uom character varying(80) COLLATE public.nocase,
    pletd_volume numeric(25,2),
    pletd_volume_uom character varying(80) COLLATE public.nocase,
    pletd_pallet integer,
    pletd_thu_qty numeric(25,2),
    pletd_pickup_shotclosure_qty numeric(25,2),
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_execthudetail ALTER COLUMN pletd_exe_thu_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_execthudetail_pletd_exe_thu_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_execthudetail
    ADD CONSTRAINT f_execthudetail_pkey PRIMARY KEY (pletd_exe_thu_dtl_key);

ALTER TABLE ONLY dwh.f_execthudetail
    ADD CONSTRAINT f_execthudetail_plepd_trip_exe_pln_dtl_key_fkey FOREIGN KEY (plepd_trip_exe_pln_dtl_key) REFERENCES dwh.f_tripexecutionplandetail(plepd_trip_exe_pln_dtl_key);

CREATE INDEX f_execthudetail_key_idx ON dwh.f_execthudetail USING btree (plepd_trip_exe_pln_dtl_key);

CREATE INDEX f_execthudetail_key_idx1 ON dwh.f_execthudetail USING btree (pletd_ouinstance, pletd_execution_plan_id, pletd_line_no, pletd_dispatch_docno, pletd_thu_line_no);