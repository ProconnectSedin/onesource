CREATE OR REPLACE PROCEDURE click.usp_d_thu()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_thu t
    SET
        thu_key = s.thu_key,
        thu_id = s.thu_id,
        thu_ou = s.thu_ou,
        thu_description = s.thu_description,
        thu_bulk = s.thu_bulk,
        thu_class = s.thu_class,
        thu_status = s.thu_status,
        thu_reason_code = s.thu_reason_code,
        thu_tare = s.thu_tare,
        thu_max_allowable = s.thu_max_allowable,
        thu_weight_uom = s.thu_weight_uom,
        thu_uom = s.thu_uom,
        thu_int_length = s.thu_int_length,
        thu_int_width = s.thu_int_width,
        thu_int_height = s.thu_int_height,
        thu_int_uom = s.thu_int_uom,
        thu_ext_length = s.thu_ext_length,
        thu_ext_width = s.thu_ext_width,
        thu_ext_height = s.thu_ext_height,
        thu_ext_uom = s.thu_ext_uom,
        thu_timestamp = s.thu_timestamp,
        thu_created_by = s.thu_created_by,
        thu_created_date = s.thu_created_date,
        thu_modified_by = s.thu_modified_by,
        thu_modified_date = s.thu_modified_date,
        thu_size = s.thu_size,
        thu_eligible_cubing = s.thu_eligible_cubing,
        thu_area = s.thu_area,
        thu_weight_const = s.thu_weight_const,
        thu_volume_const = s.thu_volume_const,
        thu_unit_pallet_const = s.thu_unit_pallet_const,
        thu_max_unit_permissable = s.thu_max_unit_permissable,
        thu_stage_mapping = s.thu_stage_mapping,
        thu_ser_cont = s.thu_ser_cont,
        thu_is_ethu = s.thu_is_ethu,
        thu_volume_uom = s.thu_volume_uom,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_thu s
    WHERE t.thu_id = s.thu_id
    AND t.thu_ou = s.thu_ou;

    INSERT INTO click.d_thu(thu_key, thu_id, thu_ou, thu_description, thu_bulk, thu_class, thu_status, thu_reason_code, thu_tare, thu_max_allowable, thu_weight_uom, thu_uom, thu_int_length, thu_int_width, thu_int_height, thu_int_uom, thu_ext_length, thu_ext_width, thu_ext_height, thu_ext_uom, thu_timestamp, thu_created_by, thu_created_date, thu_modified_by, thu_modified_date, thu_size, thu_eligible_cubing, thu_area, thu_weight_const, thu_volume_const, thu_unit_pallet_const, thu_max_unit_permissable, thu_stage_mapping, thu_ser_cont, thu_is_ethu, thu_volume_uom, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.thu_key, s.thu_id, s.thu_ou, s.thu_description, s.thu_bulk, s.thu_class, s.thu_status, s.thu_reason_code, s.thu_tare, s.thu_max_allowable, s.thu_weight_uom, s.thu_uom, s.thu_int_length, s.thu_int_width, s.thu_int_height, s.thu_int_uom, s.thu_ext_length, s.thu_ext_width, s.thu_ext_height, s.thu_ext_uom, s.thu_timestamp, s.thu_created_by, s.thu_created_date, s.thu_modified_by, s.thu_modified_date, s.thu_size, s.thu_eligible_cubing, s.thu_area, s.thu_weight_const, s.thu_volume_const, s.thu_unit_pallet_const, s.thu_max_unit_permissable, s.thu_stage_mapping, s.thu_ser_cont, s.thu_is_ethu, s.thu_volume_uom, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_thu s
    LEFT JOIN click.d_thu t
    ON t.thu_id = s.thu_id
    AND t.thu_ou = s.thu_ou
    WHERE t.thu_id IS NULL;
END;
$$;