CREATE TABLE dwh.d_tarifftransport (
    tf_tp_key bigint NOT NULL,
    tf_tp_id character varying(40) COLLATE public.nocase,
    tf_tp_ou integer,
    tf_tp_desc character varying(510) COLLATE public.nocase,
    tf_tp_type_code character varying(20) COLLATE public.nocase,
    tf_tp_status character varying(20) COLLATE public.nocase,
    tf_tp_division character varying(40) COLLATE public.nocase,
    tf_tp_location character varying(40) COLLATE public.nocase,
    tf_tp_validity_id character varying(40) COLLATE public.nocase,
    tf_tp_frm_ship_point character varying(40) COLLATE public.nocase,
    tf_tp_to_ship_point character varying(40) COLLATE public.nocase,
    tf_tp_frm_geo_type character varying(20) COLLATE public.nocase,
    tf_tp_frm_geo character varying(80) COLLATE public.nocase,
    tf_tp_to_geo_type character varying(20) COLLATE public.nocase,
    tf_tp_to_geo character varying(80) COLLATE public.nocase,
    tf_tp_dist_check integer,
    tf_tp_dist_min numeric(20,2),
    tf_tp_dist_max numeric(20,2),
    tf_tp_dist_uom character varying(20) COLLATE public.nocase,
    tf_tp_wt integer,
    tf_tp_wt_min numeric(20,2),
    tf_tp_wt_max numeric(20,2),
    tf_tp_wt_uom character varying(20) COLLATE public.nocase,
    tf_tp_vol integer,
    tf_tp_vol_min numeric(20,2),
    tf_tp_vol_max numeric(20,2),
    tf_tp_vol_uom character varying(20) COLLATE public.nocase,
    tf_tp_trip_time integer,
    tf_tp_trip_time_min numeric(20,2),
    tf_tp_trip_time_max numeric(20,2),
    tf_tp_trip_time_uom character varying(20) COLLATE public.nocase,
    tf_tp_vol_conversion numeric(20,2),
    tf_tp_service character varying(80) COLLATE public.nocase,
    tf_tp_sub_service character varying(80) COLLATE public.nocase,
    tf_tp_thu_type character varying(80) COLLATE public.nocase,
    tf_tp_min_no_thu numeric(20,2),
    tf_tp_max_no_thu numeric(20,2),
    tf_tp_class_of_stores character varying(80) COLLATE public.nocase,
    tf_tp_thu_space_frm numeric(20,2),
    tf_tp_thu_space_to numeric(20,2),
    tf_tp_equip_type character varying(80) COLLATE public.nocase,
    tf_tp_veh_type character varying(80) COLLATE public.nocase,
    tf_tp_timestamp integer,
    tf_tp_created_by character varying(60) COLLATE public.nocase,
    tf_tp_created_dt timestamp without time zone,
    tf_tp_modified_by character varying(60) COLLATE public.nocase,
    tf_tp_modified_dt timestamp without time zone,
    tf_tp_multilvl_approval integer,
    tf_tp_min_weight numeric(20,2),
    tf_tp_min_volume numeric(20,2),
    tf_tp_previous_status character varying(20) COLLATE public.nocase,
    tf_tp_factor character varying(510) COLLATE public.nocase,
    tf_tp_leg_behavior character varying(20) COLLATE public.nocase,
    tf_tp_service_id character varying(80) COLLATE public.nocase,
    non_billable_chk integer,
    tf_tp_numeric_round_off character varying(80) COLLATE public.nocase,
    tf_tp_thu_volume_min_lim numeric(20,2),
    tf_tp_thu_weight_min_lim numeric(20,2),
    tf_tp_category character varying(80) COLLATE public.nocase,
    tf_tp_load_type character varying(80) COLLATE public.nocase,
    tf_tp_freight_charges character varying(80) COLLATE public.nocase,
    tf_tp_inco_terms character varying(80) COLLATE public.nocase,
    tf_tp_rate_class character varying(80) COLLATE public.nocase,
    tf_tp_govt_status character varying(80) COLLATE public.nocase,
    tf_tp_uniq_note character varying(80) COLLATE public.nocase,
    tf_tp_type_of_entry character varying(80) COLLATE public.nocase,
    tf_tp_uld_rating_type character varying(80) COLLATE public.nocase,
    tf_tp_uld_charge_code character varying(80) COLLATE public.nocase,
    tf_tp_dis_doc_type character varying(80) COLLATE public.nocase,
    tf_tp_resource_type character varying(80) COLLATE public.nocase,
    tf_tp_no_of_thu_uom character varying(80) COLLATE public.nocase,
    tf_tp_space_uom character varying(80) COLLATE public.nocase,
    tf_tp_cod_cop integer,
    tf_tp_cod_cop_min numeric(20,2),
    tf_tp_cod_cop_max numeric(20,2),
    tf_tp_cod_cop_min_lim numeric(20,2),
    tf_tp_cod_cop_uom character varying(80) COLLATE public.nocase,
    tf_tp_declrd_value integer,
    tf_tp_declrd_value_min numeric(20,2),
    tf_tp_declrd_value_max numeric(20,2),
    tf_tp_declrd_value_min_lim numeric(20,2),
    tf_tp_declrd_value_uom character varying(80) COLLATE public.nocase,
    tf_tp_dutiable_value integer,
    tf_tp_dutiable_value_min numeric(20,2),
    tf_tp_dutiable_value_max numeric(20,2),
    tf_tp_dutiable_value_min_lim numeric(20,2),
    tf_tp_dutiable_value_uom character varying(80) COLLATE public.nocase,
    tf_tp_thu_length integer,
    tf_tp_thu_length_min numeric(20,2),
    tf_tp_thu_length_max numeric(20,2),
    tf_tp_thu_length_min_lim numeric(20,2),
    tf_tp_thu_length_uom character varying(80) COLLATE public.nocase,
    tf_tp_thu_width integer,
    tf_tp_thu_width_min numeric(20,2),
    tf_tp_thu_width_max numeric(20,2),
    tf_tp_thu_width_min_lim numeric(20,2),
    tf_tp_thu_width_uom character varying(80) COLLATE public.nocase,
    tf_tp_thu_height integer,
    tf_tp_thu_height_min numeric(20,2),
    tf_tp_thu_height_max numeric(20,2),
    tf_tp_thu_height_min_lim numeric(20,2),
    tf_tp_thu_height_uom character varying(80) COLLATE public.nocase,
    tf_tp_thu_distance_min_lim numeric(20,2),
    tf_tp_thu_trip_time_min_lim numeric(20,2),
    tf_tp_cost_type character varying(80) COLLATE public.nocase,
    tf_tp_area character varying(80) COLLATE public.nocase,
    tf_tp_origin_via_point character varying(80) COLLATE public.nocase,
    tf_tp_dest_via_point character varying(510) COLLATE public.nocase,
    tf_tp_data_source character varying(510) COLLATE public.nocase,
    tf_tp_directioncode_chk integer,
    tf_tp_proportional_code character varying(20) COLLATE public.nocase,
    tf_tp_uniq_addon_area_code character varying(20) COLLATE public.nocase,
    tf_tp_no_of_thu_min numeric(20,2),
    tf_tp_no_of_thu_max numeric(20,2),
    tf_tp_space_min numeric(20,2),
    tf_tp_space_max numeric(20,2),
    tf_tp_no_of_thu numeric(20,2),
    tf_tp_no_of_thu_min_lim numeric(20,2),
    tf_tp_space integer,
    tf_tp_space_min_lim numeric(20,2),
    tf_acc_flag character varying(20) COLLATE public.nocase,
    tf_tp_reciprocal_yn character varying(10) COLLATE public.nocase,
    tf_tp_doc numeric(20,2),
    tf_tp_min_doc numeric(20,2),
    tf_tp_doc_min numeric(20,2),
    tf_tp_doc_max numeric(20,2),
    tf_tp_doc_uom character varying(510) COLLATE public.nocase,
    tf_tp_doc_min_lim character varying(510) COLLATE public.nocase,
    tf_tp_dec_id character varying(80) COLLATE public.nocase,
    tf_tp_consumables character varying(80) COLLATE public.nocase,
    tf_tp_task character varying(80) COLLATE public.nocase,
    tf_tp_job_type character varying(80) COLLATE public.nocase,
    tf_tp_min_eqp numeric(20,2),
    tf_tp_eqp_min numeric(20,2),
    tf_tp_eqp_max numeric(20,2),
    tf_tp_eqp_uom character varying(80) COLLATE public.nocase,
    tf_tp_min_commodity numeric(20,2),
    tf_tp_commodity_min numeric(20,2),
    tf_tp_commodity_max numeric(20,2),
    tf_tp_commodity_uom character varying(80) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.d_tarifftransport ALTER COLUMN tf_tp_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.d_tarifftransport_tf_tp_key_seq
    START WITH -1
    INCREMENT BY 1
    MINVALUE -1
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.d_tarifftransport
    ADD CONSTRAINT d_tarifftransport_pkey PRIMARY KEY (tf_tp_key);

ALTER TABLE ONLY dwh.d_tarifftransport
    ADD CONSTRAINT d_tarifftransport_ukey UNIQUE (tf_tp_id, tf_tp_ou);

CREATE INDEX d_tarifftransport_idx ON dwh.d_tarifftransport USING btree (tf_tp_id, tf_tp_ou);