CREATE OR REPLACE PROCEDURE click.usp_d_location()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_location t
    SET
        loc_key = s.loc_key,
        loc_ou = s.loc_ou,
        loc_code = s.loc_code,
        loc_desc = s.loc_desc,
        loc_status = s.loc_status,
        loc_type = s.loc_type,
        reason_code = s.reason_code,
        finance_book = s.finance_book,
        costcenter = s.costcenter,
        address1 = s.address1,
        address2 = s.address2,
        country = s.country,
        state = s.state,
        city = s.city,
        zip_code = s.zip_code,
        contperson = s.contperson,
        contact_no = s.contact_no,
        time_zone_id = s.time_zone_id,
        loc_lat = s.loc_lat,
        loc_long = s.loc_long,
        ltimestamp = s.ltimestamp,
        created_by = s.created_by,
        created_dt = s.created_dt,
        modified_by = s.modified_by,
        modified_dt = s.modified_dt,
        def_plan_mode = s.def_plan_mode,
        loc_shp_point = s.loc_shp_point,
        loc_cubing = s.loc_cubing,
        blanket_count_sa = s.blanket_count_sa,
        enable_uid_prof = s.enable_uid_prof,
        loc_linked_hub = s.loc_linked_hub,
        loc_enable_bin_chkbit = s.loc_enable_bin_chkbit,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_location s
    WHERE t.loc_ou = s.loc_ou
    AND t.loc_code = s.loc_code;

    INSERT INTO click.d_location(loc_key, loc_ou, loc_code, loc_desc, loc_status, loc_type, reason_code, finance_book, costcenter, address1, address2, country, state, city, zip_code, contperson, contact_no, time_zone_id, loc_lat, loc_long, ltimestamp, created_by, created_dt, modified_by, modified_dt, def_plan_mode, loc_shp_point, loc_cubing, blanket_count_sa, enable_uid_prof, loc_linked_hub, loc_enable_bin_chkbit, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.loc_key, s.loc_ou, s.loc_code, s.loc_desc, s.loc_status, s.loc_type, s.reason_code, s.finance_book, s.costcenter, s.address1, s.address2, s.country, s.state, s.city, s.zip_code, s.contperson, s.contact_no, s.time_zone_id, s.loc_lat, s.loc_long, s.ltimestamp, s.created_by, s.created_dt, s.modified_by, s.modified_dt, s.def_plan_mode, s.loc_shp_point, s.loc_cubing, s.blanket_count_sa, s.enable_uid_prof, s.loc_linked_hub, s.loc_enable_bin_chkbit, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_location s
    LEFT JOIN click.d_location t
    ON t.loc_ou = s.loc_ou
    AND t.loc_code = s.loc_code
    WHERE t.loc_ou IS NULL;
END;
$$;