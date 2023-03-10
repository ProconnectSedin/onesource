CREATE TABLE dwh.f_tripplanningheader (
    plpth_hdr_key bigint NOT NULL,
    plpth_ouinstance integer,
    plpth_plan_run_no character varying(80) COLLATE public.nocase,
    plpth_plan_run_status character varying(80) COLLATE public.nocase,
    plpth_trip_plan_id character varying(40) COLLATE public.nocase,
    plpth_trip_plan_planning_profile_id character varying(80) COLLATE public.nocase,
    plpth_trip_plan_status character varying(80) COLLATE public.nocase,
    plpth_trip_plan_date timestamp without time zone,
    plpth_trip_plan_end_date timestamp without time zone,
    plpth_trip_plan_from character varying(80) COLLATE public.nocase,
    plpth_trip_plan_to character varying(80) COLLATE public.nocase,
    plpth_vehicle_profile character varying(80) COLLATE public.nocase,
    plpth_vehicle_type character varying(80) COLLATE public.nocase,
    plpth_vehicle_id character varying(80) COLLATE public.nocase,
    plpth_vehicle_resource character varying(80) COLLATE public.nocase,
    plpth_vehicle_cov_weight numeric,
    plpth_vehicle_bal_weight numeric,
    plpth_vehicle_bal_weight_uom character varying(80) COLLATE public.nocase,
    plpth_vehicle_bal_volume integer,
    plpth_vehicle_bal_volume_uom character varying(80) COLLATE public.nocase,
    plpth_equipment_profile character varying(80) COLLATE public.nocase,
    plpth_equipment_type character varying(80) COLLATE public.nocase,
    plpth_equipment_id character varying(80) COLLATE public.nocase,
    plpth_equipment_resource character varying(80) COLLATE public.nocase,
    plpth_equip_cov_weight numeric,
    plpth_equip_bal_weight numeric,
    plpth_equip_bal_weight_uom character varying(80) COLLATE public.nocase,
    plpth_equip_bal_volume integer,
    plpth_equip_bal_volume_uom character varying(80) COLLATE public.nocase,
    plpth_driver_profile character varying(80) COLLATE public.nocase,
    plpth_driver_grade character varying(80) COLLATE public.nocase,
    plpth_driver_id character varying(80) COLLATE public.nocase,
    plpth_driver_resource character varying(80) COLLATE public.nocase,
    plpth_handler_profile character varying(80) COLLATE public.nocase,
    plpth_handler_grade character varying(80) COLLATE public.nocase,
    plpth_handler_id character varying(80) COLLATE public.nocase,
    plpth_handler_resource character varying(80) COLLATE public.nocase,
    plpth_agent_profile character varying(80) COLLATE public.nocase,
    plpth_agent_service character varying(80) COLLATE public.nocase,
    plpth_agent_id character varying(80) COLLATE public.nocase,
    plpth_agent_resource character varying(80) COLLATE public.nocase,
    plpth_rec_trip_id character varying(80) COLLATE public.nocase,
    plpth_schedule_id character varying(80) COLLATE public.nocase,
    plpth_created_by character varying(60) COLLATE public.nocase,
    plpth_created_date timestamp without time zone,
    plpth_last_modified_by character varying(60) COLLATE public.nocase,
    plpth_last_modified_date timestamp without time zone,
    plpth_timestamp integer,
    plpth_location character varying(80) COLLATE public.nocase,
    plpth_actual_end_time character varying(50) COLLATE public.nocase,
    agent_status character varying(80) COLLATE public.nocase,
    plpth_plan_run_type character varying(80) COLLATE public.nocase,
    plpth_vehicle_cov_volume integer,
    plpth_driver2_profile character varying(80) COLLATE public.nocase,
    plpth_driver2_grade character varying(80) COLLATE public.nocase,
    plpth_driver2_id character varying(80) COLLATE public.nocase,
    plpth_driver2_resource character varying(80) COLLATE public.nocase,
    plpth_handler2_profile character varying(80) COLLATE public.nocase,
    plpth_handler2_grade character varying(80) COLLATE public.nocase,
    plpth_handler2_id character varying(80) COLLATE public.nocase,
    plpth_handler2_resource character varying(80) COLLATE public.nocase,
    plpth_plan_mode character varying(80) COLLATE public.nocase,
    plpth_amend_status character varying(10) COLLATE public.nocase,
    plpth_trip_plan_rsncd character varying(80) COLLATE public.nocase,
    plpth_trip_plan_remarks character varying(510) COLLATE public.nocase,
    plpth_vehicle_weight numeric,
    plpth_vehicle_volume numeric,
    pltph_booking_request_weight numeric,
    pltph_booking_request_volume numeric,
    pltph_expected_revenue numeric,
    pltph_expected_cost numeric,
    pltph_covered_qty numeric,
    pltph_booking_request character varying(80) COLLATE public.nocase,
    pltph_equipment_status_2 character varying(80) COLLATE public.nocase,
    pltph_trip_thu_utilization numeric,
    pltph_execution_plan character varying(80) COLLATE public.nocase,
    pltph_trip_pallet_space integer,
    plpth_trip_plan_from_type character varying(80) COLLATE public.nocase,
    plpth_trip_plan_to_type character varying(80) COLLATE public.nocase,
    pltph_confirmation_date timestamp without time zone,
    pltph_release_date timestamp without time zone,
    pltph_unique_guid character varying(300) COLLATE public.nocase,
    pltph_error_id integer,
    pltph_error_desc character varying(8000) COLLATE public.nocase,
    pltph_desktop_mobile_flag character varying(10) COLLATE public.nocase,
    pltph_trip_sht_cls_date timestamp without time zone,
    plpth_prime_mover_chkflg character varying(80) COLLATE public.nocase,
    pltph_recurring_flag character varying(10) COLLATE public.nocase,
    pltph_trip_calculated_chargeable_weight numeric,
    plpth_plan_accrual_jv_date timestamp without time zone,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    plpth_trip_plan_datekey bigint,
    plpth_vehicle_key bigint
);

ALTER TABLE dwh.f_tripplanningheader ALTER COLUMN plpth_hdr_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_tripplanningheader_plpth_hdr_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_tripplanningheader
    ADD CONSTRAINT f_tripplanningheader_pkey PRIMARY KEY (plpth_hdr_key);

ALTER TABLE ONLY dwh.f_tripplanningheader
    ADD CONSTRAINT f_tripplanningheader_ukey UNIQUE (plpth_ouinstance, plpth_trip_plan_id);

ALTER TABLE ONLY dwh.f_tripplanningheader
    ADD CONSTRAINT f_tripplanningheader_plpth_vehicle_key_fkey FOREIGN KEY (plpth_vehicle_key) REFERENCES dwh.d_vehicle(veh_key);

CREATE INDEX f_tripplanningheader_key_idx ON dwh.f_tripplanningheader USING btree (plpth_ouinstance, plpth_trip_plan_id);

CREATE INDEX f_tripplanningheader_key_idx2 ON dwh.f_tripplanningheader USING btree (plpth_trip_plan_date);

CREATE INDEX f_tripplanningheader_key_idx3 ON dwh.f_tripplanningheader USING btree (plpth_trip_plan_datekey);

CREATE INDEX f_tripplanningheader_key_idx4 ON dwh.f_tripplanningheader USING btree (plpth_vehicle_key);