CREATE TABLE dwh.f_tripexecutionplandetail (
    plepd_trip_exe_pln_dtl_key bigint NOT NULL,
    br_key bigint NOT NULL,
    plepd_ouinstance integer,
    plepd_execution_plan_id character varying(72) COLLATE public.nocase,
    plepd_line_no character varying(512) COLLATE public.nocase,
    plepd_bk_id character varying(72) COLLATE public.nocase,
    plepd_bk_ref_route_id character varying(160) COLLATE public.nocase,
    plepd_leg_id character varying(160) COLLATE public.nocase,
    plepd_leg_behaviour_id character varying(60) COLLATE public.nocase,
    plepd_leg_seq_no integer,
    plepd_leg_status character varying(160) COLLATE public.nocase,
    plepd_planning_seq_no integer,
    plepd_leg_from character varying(160) COLLATE public.nocase,
    plepd_from_leg_geo_type character varying(160) COLLATE public.nocase,
    plepd_leg_from_postal_code character varying(160) COLLATE public.nocase,
    plepd_leg_from_subzone character varying(160) COLLATE public.nocase,
    plepd_leg_from_city character varying(160) COLLATE public.nocase,
    plepd_leg_from_zone character varying(160) COLLATE public.nocase,
    plepd_leg_from_state character varying(160) COLLATE public.nocase,
    plepd_leg_from_region character varying(160) COLLATE public.nocase,
    plepd_leg_from_country character varying(160) COLLATE public.nocase,
    plepd_leg_to character varying(160) COLLATE public.nocase,
    plepd_to_leg_geo_type character varying(160) COLLATE public.nocase,
    plepd_leg_to_postal_code character varying(160) COLLATE public.nocase,
    plepd_leg_to_subzone character varying(160) COLLATE public.nocase,
    plepd_leg_to_city character varying(160) COLLATE public.nocase,
    plepd_leg_to_zone character varying(160) COLLATE public.nocase,
    plepd_leg_to_state character varying(160) COLLATE public.nocase,
    plepd_leg_to_region character varying(160) COLLATE public.nocase,
    plepd_leg_to_country character varying(160) COLLATE public.nocase,
    plepd_leg_transport_mode character varying(160) COLLATE public.nocase,
    plepd_available_qty numeric,
    plepd_draft_qty numeric,
    plepd_confirmed_qty numeric,
    plepd_initiated_qty numeric,
    plepd_executed_qty numeric,
    plepd_qty_uom character varying(60) COLLATE public.nocase,
    plepd_available_vol numeric,
    plepd_draft_vol numeric,
    plepd_confirmed_vol numeric,
    plepd_vol_uom character varying(60) COLLATE public.nocase,
    plepd_available_weight numeric,
    plepd_draft_weight numeric,
    plepd_confirmed_weight numeric,
    plepd_weight_uom character varying(60) COLLATE public.nocase,
    plepd_created_by character varying(120) COLLATE public.nocase,
    plepd_created_date timestamp without time zone,
    plepd_last_modified_by character varying(120) COLLATE public.nocase,
    plepd_last_modified_date timestamp without time zone,
    plepd_leg_to_suburb character varying(160) COLLATE public.nocase,
    plepd_leg_from_suburb character varying(160) COLLATE public.nocase,
    plepd_updated_by character varying(1020) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_tripexecutionplandetail ALTER COLUMN plepd_trip_exe_pln_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_tripexecutionplandetail_plepd_trip_exe_pln_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_tripexecutionplandetail
    ADD CONSTRAINT f_tripexecutionplandetail_pkey PRIMARY KEY (plepd_trip_exe_pln_dtl_key);

ALTER TABLE ONLY dwh.f_tripexecutionplandetail
    ADD CONSTRAINT f_tripexecutionplandetail_ukey UNIQUE (plepd_ouinstance, plepd_execution_plan_id, plepd_line_no);

ALTER TABLE ONLY dwh.f_tripexecutionplandetail
    ADD CONSTRAINT f_tripexecutionplandetail_br_key_fkey FOREIGN KEY (br_key) REFERENCES dwh.f_bookingrequest(br_key);

CREATE INDEX f_tripexecutionplandetail_key_idx ON dwh.f_tripexecutionplandetail USING btree (br_key);

CREATE INDEX f_tripexecutionplandetail_key_idx1 ON dwh.f_tripexecutionplandetail USING btree (plepd_ouinstance, plepd_execution_plan_id, plepd_line_no);