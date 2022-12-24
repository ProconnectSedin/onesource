CREATE TABLE raw.raw_wms_veh_mas_hdr (
    raw_id bigint NOT NULL,
    wms_veh_ou integer NOT NULL,
    wms_veh_id character varying(120) NOT NULL COLLATE public.nocase,
    wms_veh_desc character varying(1020) COLLATE public.nocase,
    wms_veh_status character varying(32) COLLATE public.nocase,
    wms_veh_rsn_code character varying(160) COLLATE public.nocase,
    wms_veh_vin character varying(80) COLLATE public.nocase,
    wms_veh_model character varying(280) COLLATE public.nocase,
    wms_veh_type character varying(160) COLLATE public.nocase,
    wms_veh_own_typ character varying(160) COLLATE public.nocase,
    wms_veh_agency_id character varying(72) COLLATE public.nocase,
    wms_veh_agency_contno character varying(72) COLLATE public.nocase,
    wms_veh_build_date timestamp without time zone,
    wms_veh_chassis_num character varying(1020) COLLATE public.nocase,
    wms_veh_ref_num character varying(160) COLLATE public.nocase,
    wms_veh_equip_id character varying(120) COLLATE public.nocase,
    wms_veh_asset_id character varying(72) COLLATE public.nocase,
    wms_veh_asset_tag integer,
    wms_veh_reg_num character varying(600) COLLATE public.nocase,
    wms_veh_address character varying(1020) COLLATE public.nocase,
    wms_veh_tit_hold_name character varying(160) COLLATE public.nocase,
    wms_veh_req_date timestamp without time zone,
    wms_veh_effect_date timestamp without time zone,
    wms_veh_exp_date timestamp without time zone,
    wms_veh_renew_date timestamp without time zone,
    wms_veh_renew_fee numeric,
    wms_veh_renew character varying(1020) COLLATE public.nocase,
    wms_veh_def_loc character varying(72) COLLATE public.nocase,
    wms_veh_cur_loc character varying(72) COLLATE public.nocase,
    wms_veh_cur_loc_since timestamp without time zone,
    wms_veh_gps_ref_num character varying(1020) COLLATE public.nocase,
    wms_veh_engine_num character varying(1020) COLLATE public.nocase,
    wms_veh_engine_cap numeric,
    wms_veh_trans_typ character varying(1020) COLLATE public.nocase,
    wms_veh_trans_typ_uom character varying(1020) COLLATE public.nocase,
    wms_veh_fuel_used character varying(160) COLLATE public.nocase,
    wms_veh_tank_cap numeric,
    wms_veh_tank_cap_uom character varying(1020) COLLATE public.nocase,
    wms_veh_seating_cap numeric,
    wms_veh_steering_type character varying(160) COLLATE public.nocase,
    wms_veh_colour character varying(80) COLLATE public.nocase,
    wms_veh_wt_uom character varying(40) COLLATE public.nocase,
    wms_veh_tare numeric,
    wms_veh_vehicle_gross numeric,
    wms_veh_gross_com numeric,
    wms_veh_dim_uom character varying(40) COLLATE public.nocase,
    wms_veh_length numeric,
    wms_veh_width numeric,
    wms_veh_height numeric,
    wms_veh_mileage_uom character varying(40) COLLATE public.nocase,
    wms_veh_no_load numeric,
    wms_veh_full_load numeric,
    wms_veh_average numeric,
    wms_veh_created_by character varying(120) COLLATE public.nocase,
    wms_veh_created_date timestamp without time zone,
    wms_veh_modified_by character varying(120) COLLATE public.nocase,
    wms_veh_modified_date timestamp without time zone,
    wms_veh_timestamp integer,
    wms_veh_userdefined1 character varying(1020) COLLATE public.nocase,
    wms_veh_userdefined2 character varying(1020) COLLATE public.nocase,
    wms_veh_userdefined3 character varying(1020) COLLATE public.nocase,
    wms_veh_engine_number character varying(1020) COLLATE public.nocase,
    wms_veh_refrigerated integer,
    wms_veh_temp_uom character varying(40) COLLATE public.nocase,
    wms_veh_temp_minimum numeric,
    wms_veh_temp_maximum numeric,
    wms_veh_intransit integer,
    wms_veh_route character varying(72) COLLATE public.nocase,
    wms_veh_and character varying(1020) COLLATE public.nocase,
    wms_veh_between character varying(1020) COLLATE public.nocase,
    wms_veh_category character varying(160) COLLATE public.nocase,
    wms_veh_no_of_axies integer,
    wms_veh_make character varying(160) COLLATE public.nocase,
    wms_veh_gps_dev_typ character varying(160) COLLATE public.nocase,
    wms_veh_use_of_haz integer,
    wms_veh_in_dim_uom character varying(40) COLLATE public.nocase,
    wms_veh_in_length numeric,
    wms_veh_in_width numeric,
    wms_veh_in_height numeric,
    wms_veh_eng_cap_uom character varying(40) COLLATE public.nocase,
    wms_veh_vol_uom character varying(40) COLLATE public.nocase,
    wms_veh_over_vol numeric,
    wms_veh_internal_vol numeric,
    wms_veh_purchase_date timestamp without time zone,
    wms_veh_induct_date timestamp without time zone,
    wms_veh_rigid integer,
    wms_veh_current_loc_desc character varying(1020) COLLATE public.nocase,
    wms_veh_home_loc_desc character varying(1020) COLLATE public.nocase,
    wms_veh_home_geo_type character varying(1020) COLLATE public.nocase,
    wms_veh_current_geo_type character varying(1020) COLLATE public.nocase,
    wms_veh_ownrshp_eftfrm timestamp without time zone,
    wms_veh_pallet_space integer,
    wms_veh_raise_int_drfbill integer,
    wms_veh_prev_geo_type character varying(160) COLLATE public.nocase,
    wms_veh_prev_loc character varying(72) COLLATE public.nocase,
    wms_veh_axle_config character varying(160) COLLATE public.nocase,
    wms_veh_avgspd_uom character varying(40) COLLATE public.nocase,
    wms_veh_avspd_noload numeric,
    wms_veh_avspd_coupled numeric,
    wms_veh_avspd_couple_load numeric,
    wms_veh_last_bill_date timestamp without time zone,
    wms_veh_last_prev_bill_date timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);