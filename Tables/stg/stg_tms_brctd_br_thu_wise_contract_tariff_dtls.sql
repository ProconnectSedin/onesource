CREATE TABLE stg.stg_tms_brctd_br_thu_wise_contract_tariff_dtls (
    brctd_ou integer NOT NULL,
    brctd_br_id character varying(72) NOT NULL COLLATE public.nocase,
    brctd_thu_line_no character varying(512) COLLATE public.nocase,
    brctd_contract_id character varying(72) COLLATE public.nocase,
    brctd_cont_type character varying(32) COLLATE public.nocase,
    brctd_cont_service_type character varying(160) COLLATE public.nocase,
    brctd_cont_valid_from timestamp without time zone,
    brctd_cont_valid_to timestamp without time zone,
    brctd_tariff_id character varying(72) COLLATE public.nocase,
    brctd_tf_tp_type_code character varying(32) COLLATE public.nocase,
    brctd_tf_tp_division character varying(64) COLLATE public.nocase,
    brctd_tf_tp_location character varying(64) COLLATE public.nocase,
    brctd_tf_tp_validity_id character varying(72) COLLATE public.nocase,
    brctd_tf_tp_frm_ship_point character varying(72) COLLATE public.nocase,
    brctd_tf_tp_to_ship_point character varying(72) COLLATE public.nocase,
    brctd_tf_tp_frm_geo_type character varying(32) COLLATE public.nocase,
    brctd_tf_tp_frm_geo character varying(160) COLLATE public.nocase,
    brctd_tf_tp_to_geo_type character varying(32) COLLATE public.nocase,
    brctd_tf_tp_to_geo character varying(160) COLLATE public.nocase,
    brctd_tf_tp_dist_check integer,
    brctd_tf_tp_dist_min numeric,
    brctd_tf_tp_dist_max numeric,
    brctd_tf_tp_dist_uom character varying(40) COLLATE public.nocase,
    brctd_tf_tp_wt integer,
    brctd_tf_tp_wt_min numeric,
    brctd_tf_tp_wt_max numeric,
    brctd_tf_tp_wt_uom character varying(40) COLLATE public.nocase,
    brctd_tf_tp_vol integer,
    brctd_tf_tp_vol_min numeric,
    brctd_tf_tp_vol_max numeric,
    brctd_tf_tp_vol_uom character varying(40) COLLATE public.nocase,
    brctd_tf_tp_trip_time integer,
    brctd_tf_tp_trip_time_min numeric,
    brctd_tf_tp_trip_time_max numeric,
    brctd_tf_tp_trip_time_uom character varying(40) COLLATE public.nocase,
    brctd_tf_tp_vol_conversion numeric,
    brctd_tf_tp_service character varying(160) COLLATE public.nocase,
    brctd_tf_tp_sub_service character varying(160) COLLATE public.nocase,
    brctd_tf_tp_thu_type character varying(160) COLLATE public.nocase,
    brctd_tf_tp_min_no_thu numeric,
    brctd_tf_tp_max_no_thu numeric,
    brctd_tf_tp_class_of_stores character varying(160) COLLATE public.nocase,
    brctd_tf_tp_thu_space_frm numeric,
    brctd_tf_tp_thu_space_to numeric,
    brctd_tf_tp_equip_type character varying(160) COLLATE public.nocase,
    brctd_tf_tp_veh_type character varying(160) COLLATE public.nocase,
    brctd_billable_weight numeric,
    brctd_rate_for_billable_weight numeric,
    brctd_stage_of_tariff_derivation character varying(160) COLLATE public.nocase,
    brctd_staging_ref_document character varying(72) COLLATE public.nocase,
    brctd_created_by character varying(120) COLLATE public.nocase,
    brctd_created_date timestamp without time zone,
    brctd_last_modified_by character varying(120) COLLATE public.nocase,
    brctd_last_modified_date timestamp without time zone,
    brctd_timestamp integer,
    brctd_cont_amend_no integer,
    brctd_billable_quantity numeric,
    brctd_dd_br_volume numeric,
    brctd_no_of_pallet numeric,
    brctd_actual_weight numeric,
    brctd_actual_weight_uom character varying(60) COLLATE public.nocase,
    brctd_actual_volume numeric,
    brctd_actual_volume_uom character varying(60) COLLATE public.nocase,
    brctd_basic_charge numeric,
    brctd_cont_min_charge numeric,
    brctd_leg_behaviour_id character varying(160) COLLATE public.nocase,
    brctd_chargeable_qty numeric,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

CREATE INDEX stg_tms_brctd_br_thu_wise_contract_tariff_dtls_key_idx1 ON stg.stg_tms_brctd_br_thu_wise_contract_tariff_dtls USING btree (brctd_ou, brctd_br_id, brctd_tariff_id);