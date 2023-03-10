CREATE VIEW default.wms_veh_mas_hdr
(
    `wms_veh_ou` Nullable(Int32),
    `wms_veh_id` Nullable(String),
    `wms_veh_desc` Nullable(String),
    `wms_veh_status` Nullable(String),
    `wms_veh_rsn_code` Nullable(String),
    `wms_veh_vin` Nullable(String),
    `wms_veh_type` Nullable(String),
    `wms_veh_own_typ` Nullable(String),
    `wms_veh_agency_id` Nullable(String),
    `wms_veh_agency_contno` Nullable(String),
    `wms_veh_build_date` Nullable(DateTime64(6)),
    `wms_veh_def_loc` Nullable(String),
    `wms_veh_cur_loc` Nullable(String),
    `wms_veh_cur_loc_since` Nullable(DateTime64(6)),
    `wms_veh_trans_typ` Nullable(String),
    `wms_veh_fuel_used` Nullable(String),
    `wms_veh_steering_type` Nullable(String),
    `wms_veh_colour` Nullable(String),
    `wms_veh_wt_uom` Nullable(String),
    `wms_veh_tare` Nullable(Decimal(18, 2)),
    `wms_veh_vehicle_gross` Nullable(Decimal(18, 2)),
    `wms_veh_gross_com` Nullable(Decimal(18, 2)),
    `wms_veh_dim_uom` Nullable(String),
    `wms_veh_length` Nullable(Decimal(18, 2)),
    `wms_veh_width` Nullable(Decimal(18, 2)),
    `wms_veh_height` Nullable(Decimal(18, 2)),
    `wms_veh_created_by` Nullable(String),
    `wms_veh_created_date` Nullable(DateTime64(6)),
    `wms_veh_modified_by` Nullable(String),
    `wms_veh_modified_date` Nullable(DateTime64(6)),
    `wms_veh_timestamp` Nullable(Int32),
    `wms_veh_refrigerated` Nullable(Int32),
    `wms_veh_intransit` Nullable(Int32),
    `wms_veh_route` Nullable(String),
    `wms_veh_and` Nullable(String),
    `wms_veh_between` Nullable(String),
    `wms_veh_category` Nullable(String),
    `wms_veh_use_of_haz` Nullable(Int32),
    `wms_veh_in_dim_uom` Nullable(String),
    `wms_veh_in_length` Nullable(Decimal(18, 2)),
    `wms_veh_in_width` Nullable(Decimal(18, 2)),
    `wms_veh_in_height` Nullable(Decimal(18, 2)),
    `wms_veh_vol_uom` Nullable(String),
    `wms_veh_over_vol` Nullable(Decimal(18, 2)),
    `wms_veh_internal_vol` Nullable(Decimal(18, 2)),
    `wms_veh_purchase_date` Nullable(DateTime64(6)),
    `wms_veh_induct_date` Nullable(DateTime64(6)),
    `wms_veh_rigid` Nullable(Int32),
    `wms_veh_home_geo_type` Nullable(String),
    `wms_veh_current_geo_type` Nullable(String),
    `wms_veh_ownrshp_EftFrm` Nullable(DateTime64(6)),
    `wms_veh_raise_int_drfbill` Nullable(Int32),
    `wms_veh_prev_geo_type` Nullable(String),
    `wms_veh_Prev_loc` Nullable(String),
    `etlactiveind` Nullable(Int32),
    `etljobname` Nullable(String),
    `envsourcecd` Nullable(String),
    `datasourcecd` Nullable(String),
    `etlcreatedatetime` Nullable(DateTime64(6)),
    `etlupdatedatetime` Nullable(DateTime64(6))
) AS
SELECT
    veh_ou AS wms_veh_ou,
    veh_id AS wms_veh_id,
    veh_desc AS wms_veh_desc,
    veh_status AS wms_veh_status,
    veh_rsn_code AS wms_veh_rsn_code,
    veh_vin AS wms_veh_vin,
    veh_type AS wms_veh_type,
    veh_own_typ AS wms_veh_own_typ,
    veh_agency_id AS wms_veh_agency_id,
    veh_agency_contno AS wms_veh_agency_contno,
    veh_build_date AS wms_veh_build_date,
    veh_def_loc AS wms_veh_def_loc,
    veh_cur_loc AS wms_veh_cur_loc,
    veh_cur_loc_since AS wms_veh_cur_loc_since,
    veh_trans_typ AS wms_veh_trans_typ,
    veh_fuel_used AS wms_veh_fuel_used,
    veh_steering_type AS wms_veh_steering_type,
    veh_colour AS wms_veh_colour,
    veh_wt_uom AS wms_veh_wt_uom,
    veh_tare AS wms_veh_tare,
    veh_vehicle_gross AS wms_veh_vehicle_gross,
    veh_gross_com AS wms_veh_gross_com,
    veh_dim_uom AS wms_veh_dim_uom,
    veh_length AS wms_veh_length,
    veh_width AS wms_veh_width,
    veh_height AS wms_veh_height,
    veh_created_by AS wms_veh_created_by,
    veh_created_date AS wms_veh_created_date,
    veh_modified_by AS wms_veh_modified_by,
    veh_modified_date AS wms_veh_modified_date,
    veh_timestamp AS wms_veh_timestamp,
    veh_refrigerated AS wms_veh_refrigerated,
    veh_intransit AS wms_veh_intransit,
    veh_route AS wms_veh_route,
    veh_and AS wms_veh_and,
    veh_between AS wms_veh_between,
    veh_category AS wms_veh_category,
    veh_use_of_haz AS wms_veh_use_of_haz,
    veh_in_dim_uom AS wms_veh_in_dim_uom,
    veh_in_length AS wms_veh_in_length,
    veh_in_width AS wms_veh_in_width,
    veh_in_height AS wms_veh_in_height,
    veh_vol_uom AS wms_veh_vol_uom,
    veh_over_vol AS wms_veh_over_vol,
    veh_internal_vol AS wms_veh_internal_vol,
    veh_purchase_date AS wms_veh_purchase_date,
    veh_induct_date AS wms_veh_induct_date,
    veh_rigid AS wms_veh_rigid,
    veh_home_geo_type AS wms_veh_home_geo_type,
    veh_current_geo_type AS wms_veh_current_geo_type,
    veh_ownrshp_eftfrm AS wms_veh_ownrshp_EftFrm,
    veh_raise_int_drfbill AS wms_veh_raise_int_drfbill,
    veh_prev_geo_type AS wms_veh_prev_geo_type,
    veh_prev_loc AS wms_veh_Prev_loc,
    etlactiveind,
    etljobname,
    envsourcecd,
    datasourcecd,
    etlcreatedatetime,
    etlupdatedatetime
FROM onesource.d_vehicle