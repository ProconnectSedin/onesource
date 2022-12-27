CREATE TABLE dwh.f_tripplanningdetail (
    plptd_dtl_key bigint NOT NULL,
    plpth_hdr_key bigint NOT NULL,
    plptd_ouinstance integer,
    plptd_plan_run_no character varying(40) COLLATE public.nocase,
    plptd_trip_plan_id character varying(40) COLLATE public.nocase,
    plptd_trip_plan_line_no character varying(300) COLLATE public.nocase,
    plptd_trip_plan_seq integer,
    plptd_trip_plan_cutoftime character varying(80) COLLATE public.nocase,
    plptd_bk_req_id character varying(40) COLLATE public.nocase,
    plptd_bk_leg_no character varying(40) COLLATE public.nocase,
    plptd_leg_behaviour character varying(80) COLLATE public.nocase,
    plptd_thu_covered_qty numeric(13,0),
    plptd_thu_line_no character varying(300) COLLATE public.nocase,
    plptd_execution_plan character varying(40) COLLATE public.nocase,
    plptd_created_by character varying(60) COLLATE public.nocase,
    plptd_created_date timestamp without time zone,
    plptd_last_modified_by character varying(60) COLLATE public.nocase,
    plptd_last_modified_date timestamp without time zone,
    plptd_line_status character varying(80) COLLATE public.nocase,
    plptd_billing_status character varying(20) COLLATE public.nocase,
    plptd_event_id character varying(80) COLLATE public.nocase,
    plptd_distinct_leg_id character varying(300) COLLATE public.nocase,
    plptd_plan_source character varying(80) COLLATE public.nocase,
    plptd_odo_start numeric(13,2),
    plptd_odo_end numeric(13,2),
    plptd_odo_uom character varying(80) COLLATE public.nocase,
    plpth_start_time timestamp without time zone,
    plpth_end_time timestamp without time zone,
    pltpd_manage_flag character varying(10) COLLATE public.nocase,
    pltpd_rest_hours numeric(13,2),
    plptd_trip_plan_unique_id character varying(300) COLLATE public.nocase,
    pltpd_from character varying(80) COLLATE public.nocase,
    pltpd_from_type character varying(80) COLLATE public.nocase,
    pltpd_to character varying(80) COLLATE public.nocase,
    pltpd_to_type character varying(80) COLLATE public.nocase,
    plptd_distance numeric(13,2),
    plptd_supplier_billing_status character varying(80) COLLATE public.nocase,
    plptd_rest_start timestamp without time zone,
    plptd_transfer_doc_no character varying(80) COLLATE public.nocase,
    pltpd_pl_bk_qty numeric(13,2),
    pltpd_pl_bk_wei numeric(13,2),
    pltpd_pl_bk_wei_uom character varying(80) COLLATE public.nocase,
    pltpd_act_bk_qty numeric(13,2),
    pltpd_act_bk_wei numeric(13,2),
    pltpd_act_bk_wei_uom character varying(80) COLLATE public.nocase,
    pltpd_cuml_pl_wei numeric(13,2),
    pltpd_cuml_pl_wei_uom character varying(80) COLLATE public.nocase,
    pltpd_cuml_act_wei numeric(13,2),
    pltpd_cuml_act_wei_uom character varying(80) COLLATE public.nocase,
    pltpd_bk_wise_seq integer,
    pltpd_backhaul_flag character varying(10) COLLATE public.nocase,
    pltpd_timestamp integer,
    plptd_backtohub_type character varying(80) COLLATE public.nocase,
    pltpd_loading_time numeric(13,2),
    plptd_transit_time numeric(13,2),
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_tripplanningdetail ALTER COLUMN plptd_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_tripplanningdetail_plptd_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_tripplanningdetail
    ADD CONSTRAINT f_tripplanningdetail_pkey PRIMARY KEY (plptd_dtl_key);

ALTER TABLE ONLY dwh.f_tripplanningdetail
    ADD CONSTRAINT f_tripplanningdetail_ukey UNIQUE (plptd_ouinstance, plptd_plan_run_no, plptd_trip_plan_id, plptd_trip_plan_seq, plptd_bk_req_id, plptd_trip_plan_unique_id);

ALTER TABLE ONLY dwh.f_tripplanningdetail
    ADD CONSTRAINT f_tripplanningdetail_plpth_hdr_key_fkey FOREIGN KEY (plpth_hdr_key) REFERENCES dwh.f_tripplanningheader(plpth_hdr_key);

CREATE INDEX f_tripplanningdetail_key_idx ON dwh.f_tripplanningdetail USING btree (plptd_ouinstance, plptd_plan_run_no, plptd_trip_plan_id, plptd_trip_plan_seq, plptd_bk_req_id, plptd_trip_plan_unique_id);

CREATE INDEX f_tripplanningdetail_key_idx1 ON dwh.f_tripplanningdetail USING btree (plpth_hdr_key);

CREATE INDEX f_tripplanningdetail_key_idx2 ON dwh.f_tripplanningdetail USING btree (plptd_ouinstance, plptd_bk_req_id);

CREATE INDEX f_tripplanningdetail_key_idx3 ON dwh.f_tripplanningdetail USING btree (plptd_ouinstance, plptd_trip_plan_id, plptd_trip_plan_seq);