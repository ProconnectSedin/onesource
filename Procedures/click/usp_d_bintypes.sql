CREATE OR REPLACE PROCEDURE click.usp_d_bintypes()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_bintypes t
    SET
        bin_typ_key = s.bin_typ_key,
        bin_typ_ou = s.bin_typ_ou,
        bin_typ_code = s.bin_typ_code,
        bin_typ_loc_code = s.bin_typ_loc_code,
        bin_typ_desc = s.bin_typ_desc,
        bin_typ_status = s.bin_typ_status,
        bin_typ_width = s.bin_typ_width,
        bin_typ_height = s.bin_typ_height,
        bin_typ_depth = s.bin_typ_depth,
        bin_typ_dim_uom = s.bin_typ_dim_uom,
        bin_typ_volume = s.bin_typ_volume,
        bin_typ_vol_uom = s.bin_typ_vol_uom,
        bin_typ_max_per_wt = s.bin_typ_max_per_wt,
        bin_typ_max_wt_uom = s.bin_typ_max_wt_uom,
        bin_typ_cap_indicator = s.bin_typ_cap_indicator,
        bin_timestamp = s.bin_timestamp,
        bin_created_by = s.bin_created_by,
        bin_created_dt = s.bin_created_dt,
        bin_modified_by = s.bin_modified_by,
        bin_modified_dt = s.bin_modified_dt,
        bin_one_bin_one_pal = s.bin_one_bin_one_pal,
        bin_typ_one_bin = s.bin_typ_one_bin,
        bin_typ_area = s.bin_typ_area,
        bin_typ_area_uom = s.bin_typ_area_uom,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_bintypes s
    WHERE t.bin_typ_ou = s.bin_typ_ou
    AND t.bin_typ_code = s.bin_typ_code
    AND t.bin_typ_loc_code = s.bin_typ_loc_code;

    INSERT INTO click.d_bintypes(bin_typ_key, bin_typ_ou, bin_typ_code, bin_typ_loc_code, bin_typ_desc, bin_typ_status, bin_typ_width, bin_typ_height, bin_typ_depth, bin_typ_dim_uom, bin_typ_volume, bin_typ_vol_uom, bin_typ_max_per_wt, bin_typ_max_wt_uom, bin_typ_cap_indicator, bin_timestamp, bin_created_by, bin_created_dt, bin_modified_by, bin_modified_dt, bin_one_bin_one_pal, bin_typ_one_bin, bin_typ_area, bin_typ_area_uom, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.bin_typ_key, s.bin_typ_ou, s.bin_typ_code, s.bin_typ_loc_code, s.bin_typ_desc, s.bin_typ_status, s.bin_typ_width, s.bin_typ_height, s.bin_typ_depth, s.bin_typ_dim_uom, s.bin_typ_volume, s.bin_typ_vol_uom, s.bin_typ_max_per_wt, s.bin_typ_max_wt_uom, s.bin_typ_cap_indicator, s.bin_timestamp, s.bin_created_by, s.bin_created_dt, s.bin_modified_by, s.bin_modified_dt, s.bin_one_bin_one_pal, s.bin_typ_one_bin, s.bin_typ_area, s.bin_typ_area_uom, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_bintypes s
    LEFT JOIN click.d_bintypes t
    ON t.bin_typ_ou = s.bin_typ_ou
    AND t.bin_typ_code = s.bin_typ_code
    AND t.bin_typ_loc_code = s.bin_typ_loc_code
    WHERE t.bin_typ_ou IS NULL;
END;
$$;