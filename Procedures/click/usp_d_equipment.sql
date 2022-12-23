CREATE PROCEDURE click.usp_d_equipment()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_equipment t
    SET
        eqp_key = s.eqp_key,
        eqp_ou = s.eqp_ou,
        eqp_equipment_id = s.eqp_equipment_id,
        eqp_description = s.eqp_description,
        eqp_status = s.eqp_status,
        eqp_type = s.eqp_type,
        eqp_hazardous_goods = s.eqp_hazardous_goods,
        eqp_owner_type = s.eqp_owner_type,
        eqp_default_location = s.eqp_default_location,
        eqp_current_location = s.eqp_current_location,
        eqp_timestamp = s.eqp_timestamp,
        eqp_created_date = s.eqp_created_date,
        eqp_created_by = s.eqp_created_by,
        eqp_modified_date = s.eqp_modified_date,
        eqp_modified_by = s.eqp_modified_by,
        eqp_intransit = s.eqp_intransit,
        eqp_refrigerated = s.eqp_refrigerated,
        veh_current_geo_type = s.veh_current_geo_type,
        eqp_raise_int_drfbill = s.eqp_raise_int_drfbill,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_equipment s
    WHERE t.eqp_ou = s.eqp_ou
    AND t.eqp_equipment_id = s.eqp_equipment_id;

    INSERT INTO click.d_equipment(eqp_key, eqp_ou, eqp_equipment_id, eqp_description, eqp_status, eqp_type, eqp_hazardous_goods, eqp_owner_type, eqp_default_location, eqp_current_location, eqp_timestamp, eqp_created_date, eqp_created_by, eqp_modified_date, eqp_modified_by, eqp_intransit, eqp_refrigerated, veh_current_geo_type, eqp_raise_int_drfbill, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.eqp_key, s.eqp_ou, s.eqp_equipment_id, s.eqp_description, s.eqp_status, s.eqp_type, s.eqp_hazardous_goods, s.eqp_owner_type, s.eqp_default_location, s.eqp_current_location, s.eqp_timestamp, s.eqp_created_date, s.eqp_created_by, s.eqp_modified_date, s.eqp_modified_by, s.eqp_intransit, s.eqp_refrigerated, s.veh_current_geo_type, s.eqp_raise_int_drfbill, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_equipment s
    LEFT JOIN click.d_equipment t
    ON t.eqp_ou = s.eqp_ou
    AND t.eqp_equipment_id = s.eqp_equipment_id
    WHERE t.eqp_ou IS NULL;
END;
$$;