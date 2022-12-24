CREATE TABLE stg.stg_wms_tariff_transport_hdr (
    wms_tf_tp_id character varying(72) NOT NULL COLLATE public.nocase,
    wms_tf_tp_ou integer NOT NULL,
    wms_tf_tp_desc character varying(1020) COLLATE public.nocase,
    wms_tf_tp_type_code character varying(32) COLLATE public.nocase,
    wms_tf_tp_status character varying(32) COLLATE public.nocase,
    wms_tf_tp_division character varying(64) COLLATE public.nocase,
    wms_tf_tp_location character varying(64) COLLATE public.nocase,
    wms_tf_tp_validity_id character varying(72) COLLATE public.nocase,
    wms_tf_tp_frm_ship_point character varying(72) COLLATE public.nocase,
    wms_tf_tp_to_ship_point character varying(72) COLLATE public.nocase,
    wms_tf_tp_frm_geo_type character varying(32) COLLATE public.nocase,
    wms_tf_tp_frm_geo character varying(160) COLLATE public.nocase,
    wms_tf_tp_to_geo_type character varying(32) COLLATE public.nocase,
    wms_tf_tp_to_geo character varying(160) COLLATE public.nocase,
    wms_tf_tp_dist_check integer,
    wms_tf_tp_dist_min numeric,
    wms_tf_tp_dist_max numeric,
    wms_tf_tp_dist_uom character varying(40) COLLATE public.nocase,
    wms_tf_tp_wt integer,
    wms_tf_tp_wt_min numeric,
    wms_tf_tp_wt_max numeric,
    wms_tf_tp_wt_uom character varying(40) COLLATE public.nocase,
    wms_tf_tp_vol integer,
    wms_tf_tp_vol_min numeric,
    wms_tf_tp_vol_max numeric,
    wms_tf_tp_vol_uom character varying(40) COLLATE public.nocase,
    wms_tf_tp_trip_time integer,
    wms_tf_tp_trip_time_min numeric,
    wms_tf_tp_trip_time_max numeric,
    wms_tf_tp_trip_time_uom character varying(40) COLLATE public.nocase,
    wms_tf_tp_vol_conversion numeric,
    wms_tf_tp_service character varying(160) COLLATE public.nocase,
    wms_tf_tp_sub_service character varying(160) COLLATE public.nocase,
    wms_tf_tp_thu_type character varying(160) COLLATE public.nocase,
    wms_tf_tp_min_no_thu numeric,
    wms_tf_tp_max_no_thu numeric,
    wms_tf_tp_class_of_stores character varying(160) COLLATE public.nocase,
    wms_tf_tp_thu_space_frm numeric,
    wms_tf_tp_thu_space_to numeric,
    wms_tf_tp_equip_type character varying(160) COLLATE public.nocase,
    wms_tf_tp_veh_type character varying(160) COLLATE public.nocase,
    wms_tf_tp_timestamp integer,
    wms_tf_tp_created_by character varying(120) COLLATE public.nocase,
    wms_tf_tp_created_dt timestamp without time zone,
    wms_tf_tp_modified_by character varying(120) COLLATE public.nocase,
    wms_tf_tp_modified_dt timestamp without time zone,
    wms_tf_tp_multilvl_approval integer,
    wms_tf_tp_min_weight numeric,
    wms_tf_tp_min_volume numeric,
    wms_tf_tp_previous_status character varying(32) COLLATE public.nocase,
    wms_tf_tp_factor character varying(1020) COLLATE public.nocase,
    wms_tf_tp_leg_behavior character varying(32) COLLATE public.nocase,
    wms_tf_tp_service_id character varying(160) COLLATE public.nocase,
    wms_non_billable_chk integer,
    wms_tf_tp_numeric_round_off character varying(160) COLLATE public.nocase,
    wms_tf_tp_thu_volume_min_lim numeric,
    wms_tf_tp_thu_weight_min_lim numeric,
    wms_tf_tp_category character varying(160) COLLATE public.nocase,
    wms_tf_tp_load_type character varying(160) COLLATE public.nocase,
    wms_tf_tp_freight_charges character varying(160) COLLATE public.nocase,
    wms_tf_tp_inco_terms character varying(160) COLLATE public.nocase,
    wms_tf_tp_rate_class character varying(160) COLLATE public.nocase,
    wms_tf_tp_govt_status character varying(160) COLLATE public.nocase,
    wms_tf_tp_uniq_note character varying(160) COLLATE public.nocase,
    wms_tf_tp_type_of_entry character varying(160) COLLATE public.nocase,
    wms_tf_tp_uld_rating_type character varying(160) COLLATE public.nocase,
    wms_tf_tp_uld_charge_code character varying(160) COLLATE public.nocase,
    wms_tf_tp_dis_doc_type character varying(160) COLLATE public.nocase,
    wms_tf_tp_resource_type character varying(160) COLLATE public.nocase,
    wms_tf_tp_no_of_thu_uom character varying(160) COLLATE public.nocase,
    wms_tf_tp_space_uom character varying(160) COLLATE public.nocase,
    wms_tf_tp_cod_cop integer,
    wms_tf_tp_cod_cop_min numeric,
    wms_tf_tp_cod_cop_max numeric,
    wms_tf_tp_cod_cop_min_lim numeric,
    wms_tf_tp_cod_cop_uom character varying(160) COLLATE public.nocase,
    wms_tf_tp_declrd_value integer,
    wms_tf_tp_declrd_value_min numeric,
    wms_tf_tp_declrd_value_max numeric,
    wms_tf_tp_declrd_value_min_lim numeric,
    wms_tf_tp_declrd_value_uom character varying(160) COLLATE public.nocase,
    wms_tf_tp_dutiable_value integer,
    wms_tf_tp_dutiable_value_min numeric,
    wms_tf_tp_dutiable_value_max numeric,
    wms_tf_tp_dutiable_value_min_lim numeric,
    wms_tf_tp_dutiable_value_uom character varying(160) COLLATE public.nocase,
    wms_tf_tp_thu_length integer,
    wms_tf_tp_thu_length_min numeric,
    wms_tf_tp_thu_length_max numeric,
    wms_tf_tp_thu_length_min_lim numeric,
    wms_tf_tp_thu_length_uom character varying(160) COLLATE public.nocase,
    wms_tf_tp_thu_width integer,
    wms_tf_tp_thu_width_min numeric,
    wms_tf_tp_thu_width_max numeric,
    wms_tf_tp_thu_width_min_lim numeric,
    wms_tf_tp_thu_width_uom character varying(160) COLLATE public.nocase,
    wms_tf_tp_thu_height integer,
    wms_tf_tp_thu_height_min numeric,
    wms_tf_tp_thu_height_max numeric,
    wms_tf_tp_thu_height_min_lim numeric,
    wms_tf_tp_thu_height_uom character varying(160) COLLATE public.nocase,
    wms_tf_tp_thu_distance_min_lim numeric,
    wms_tf_tp_thu_trip_time_min_lim numeric,
    wms_tf_tp_cost_type character varying(160) COLLATE public.nocase,
    wms_tf_tp_area character varying(160) COLLATE public.nocase,
    wms_tf_tp_origin_via_point character varying(160) COLLATE public.nocase,
    wms_tf_tp_dest_via_point character varying(1020) COLLATE public.nocase,
    wms_tf_tp_data_source character varying(1020) COLLATE public.nocase,
    wms_tf_tp_directioncode_chk integer,
    wms_tf_tp_proportional_code character varying(32) COLLATE public.nocase,
    wms_tf_tp_uniq_addon_area_code character varying(32) COLLATE public.nocase,
    wms_tf_tp_no_of_thu_min numeric,
    wms_tf_tp_no_of_thu_max numeric,
    wms_tf_tp_space_min numeric,
    wms_tf_tp_space_max numeric,
    wms_tf_tp_no_of_thu numeric,
    wms_tf_tp_no_of_thu_min_lim numeric,
    wms_tf_tp_space integer,
    wms_tf_tp_space_min_lim numeric,
    wms_tf_acc_flag character varying(32) COLLATE public.nocase,
    wms_tf_tp_reciprocal_yn character(4) COLLATE public.nocase,
    wms_tf_tp_doc numeric,
    wms_tf_tp_min_doc numeric,
    wms_tf_tp_doc_min numeric,
    wms_tf_tp_doc_max numeric,
    wms_tf_tp_doc_uom character varying(1020) COLLATE public.nocase,
    wms_tf_tp_doc_min_lim character varying(1020) COLLATE public.nocase,
    wms_tf_tp_dec_id character varying(160) COLLATE public.nocase,
    wms_tf_tp_consumables character varying(160) COLLATE public.nocase,
    wms_tf_tp_task character varying(160) COLLATE public.nocase,
    wms_tf_tp_job_type character varying(160) COLLATE public.nocase,
    wms_tf_tp_min_eqp numeric,
    wms_tf_tp_eqp_min numeric,
    wms_tf_tp_eqp_max numeric,
    wms_tf_tp_eqp_uom character varying(160) COLLATE public.nocase,
    wms_tf_tp_min_commodity numeric,
    wms_tf_tp_commodity_min numeric,
    wms_tf_tp_commodity_max numeric,
    wms_tf_tp_commodity_uom character varying(160) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);