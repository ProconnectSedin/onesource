CREATE OR REPLACE PROCEDURE click.usp_d_vehicle()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_vehicle t
    SET
        veh_key = s.veh_key,
        veh_ou = s.veh_ou,
        veh_id = s.veh_id,
        veh_desc = s.veh_desc,
        veh_status = s.veh_status,
        veh_rsn_code = s.veh_rsn_code,
        veh_vin = s.veh_vin,
        veh_type = s.veh_type,
        veh_own_typ = s.veh_own_typ,
        veh_agency_id = s.veh_agency_id,
        veh_agency_contno = s.veh_agency_contno,
        veh_build_date = s.veh_build_date,
        veh_def_loc = s.veh_def_loc,
        veh_cur_loc = s.veh_cur_loc,
        veh_cur_loc_since = s.veh_cur_loc_since,
        veh_trans_typ = s.veh_trans_typ,
        veh_fuel_used = s.veh_fuel_used,
        veh_steering_type = s.veh_steering_type,
        veh_colour = s.veh_colour,
        veh_wt_uom = s.veh_wt_uom,
        veh_tare = s.veh_tare,
        veh_vehicle_gross = s.veh_vehicle_gross,
        veh_gross_com = s.veh_gross_com,
        veh_dim_uom = s.veh_dim_uom,
        veh_length = s.veh_length,
        veh_width = s.veh_width,
        veh_height = s.veh_height,
        veh_created_by = s.veh_created_by,
        veh_created_date = s.veh_created_date,
        veh_modified_by = s.veh_modified_by,
        veh_modified_date = s.veh_modified_date,
        veh_timestamp = s.veh_timestamp,
        veh_refrigerated = s.veh_refrigerated,
        veh_intransit = s.veh_intransit,
        veh_route = s.veh_route,
        veh_and = s.veh_and,
        veh_between = s.veh_between,
        veh_category = s.veh_category,
        veh_use_of_haz = s.veh_use_of_haz,
        veh_in_dim_uom = s.veh_in_dim_uom,
        veh_in_length = s.veh_in_length,
        veh_in_width = s.veh_in_width,
        veh_in_height = s.veh_in_height,
        veh_vol_uom = s.veh_vol_uom,
        veh_over_vol = s.veh_over_vol,
        veh_internal_vol = s.veh_internal_vol,
        veh_purchase_date = s.veh_purchase_date,
        veh_induct_date = s.veh_induct_date,
        veh_rigid = s.veh_rigid,
        veh_home_geo_type = s.veh_home_geo_type,
        veh_current_geo_type = s.veh_current_geo_type,
        veh_ownrshp_eftfrm = s.veh_ownrshp_eftfrm,
        veh_raise_int_drfbill = s.veh_raise_int_drfbill,
        veh_prev_geo_type = s.veh_prev_geo_type,
        veh_prev_loc = s.veh_prev_loc,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_vehicle s
    WHERE t.veh_ou = s.veh_ou
    AND t.veh_id = s.veh_id;

    INSERT INTO click.d_vehicle(veh_key, veh_ou, veh_id, veh_desc, veh_status, veh_rsn_code, veh_vin, veh_type, veh_own_typ, veh_agency_id, veh_agency_contno, veh_build_date, veh_def_loc, veh_cur_loc, veh_cur_loc_since, veh_trans_typ, veh_fuel_used, veh_steering_type, veh_colour, veh_wt_uom, veh_tare, veh_vehicle_gross, veh_gross_com, veh_dim_uom, veh_length, veh_width, veh_height, veh_created_by, veh_created_date, veh_modified_by, veh_modified_date, veh_timestamp, veh_refrigerated, veh_intransit, veh_route, veh_and, veh_between, veh_category, veh_use_of_haz, veh_in_dim_uom, veh_in_length, veh_in_width, veh_in_height, veh_vol_uom, veh_over_vol, veh_internal_vol, veh_purchase_date, veh_induct_date, veh_rigid, veh_home_geo_type, veh_current_geo_type, veh_ownrshp_eftfrm, veh_raise_int_drfbill, veh_prev_geo_type, veh_prev_loc, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.veh_key, s.veh_ou, s.veh_id, s.veh_desc, s.veh_status, s.veh_rsn_code, s.veh_vin, s.veh_type, s.veh_own_typ, s.veh_agency_id, s.veh_agency_contno, s.veh_build_date, s.veh_def_loc, s.veh_cur_loc, s.veh_cur_loc_since, s.veh_trans_typ, s.veh_fuel_used, s.veh_steering_type, s.veh_colour, s.veh_wt_uom, s.veh_tare, s.veh_vehicle_gross, s.veh_gross_com, s.veh_dim_uom, s.veh_length, s.veh_width, s.veh_height, s.veh_created_by, s.veh_created_date, s.veh_modified_by, s.veh_modified_date, s.veh_timestamp, s.veh_refrigerated, s.veh_intransit, s.veh_route, s.veh_and, s.veh_between, s.veh_category, s.veh_use_of_haz, s.veh_in_dim_uom, s.veh_in_length, s.veh_in_width, s.veh_in_height, s.veh_vol_uom, s.veh_over_vol, s.veh_internal_vol, s.veh_purchase_date, s.veh_induct_date, s.veh_rigid, s.veh_home_geo_type, s.veh_current_geo_type, s.veh_ownrshp_eftfrm, s.veh_raise_int_drfbill, s.veh_prev_geo_type, s.veh_prev_loc, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_vehicle s
    LEFT JOIN click.d_vehicle t
    ON t.veh_ou = s.veh_ou
    AND t.veh_id = s.veh_id
    WHERE t.veh_ou IS NULL;
END;
$$;