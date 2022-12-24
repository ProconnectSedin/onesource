CREATE OR REPLACE PROCEDURE click.usp_d_stage()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_stage t
    SET
        stg_mas_key = s.stg_mas_key,
        stg_mas_ou = s.stg_mas_ou,
        stg_mas_id = s.stg_mas_id,
        stg_mas_desc = s.stg_mas_desc,
        stg_mas_status = s.stg_mas_status,
        stg_mas_loc = s.stg_mas_loc,
        stg_mas_type = s.stg_mas_type,
        stg_mas_def_bin = s.stg_mas_def_bin,
        stg_mas_rsn_code = s.stg_mas_rsn_code,
        stg_mas_frm_stage = s.stg_mas_frm_stage,
        stg_mas_frm_doc_typ = s.stg_mas_frm_doc_typ,
        stg_mas_frm_doc_status = s.stg_mas_frm_doc_status,
        stg_mas_frm_doc_conf_req = s.stg_mas_frm_doc_conf_req,
        stg_mas_to_stage = s.stg_mas_to_stage,
        stg_mas_to_doc_typ = s.stg_mas_to_doc_typ,
        stg_mas_to_doc_status = s.stg_mas_to_doc_status,
        stg_mas_to_doc_conf_req = s.stg_mas_to_doc_conf_req,
        stg_mas_timestamp = s.stg_mas_timestamp,
        stg_mas_created_by = s.stg_mas_created_by,
        stg_mas_created_dt = s.stg_mas_created_dt,
        stg_mas_modified_by = s.stg_mas_modified_by,
        stg_mas_modified_dt = s.stg_mas_modified_dt,
        stg_mas_dock_status = s.stg_mas_dock_status,
        stg_mas_dock_prevstat = s.stg_mas_dock_prevstat,
        stg_mas_frm_stage_typ = s.stg_mas_frm_stage_typ,
        stg_mas_to_stage_typ = s.stg_mas_to_stage_typ,
        stg_mas_pack_bin = s.stg_mas_pack_bin,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_stage s
    WHERE t.stg_mas_ou = s.stg_mas_ou
    AND t.stg_mas_id = s.stg_mas_id
    AND t.stg_mas_loc = s.stg_mas_loc;

    INSERT INTO click.d_stage(stg_mas_key, stg_mas_ou, stg_mas_id, stg_mas_desc, stg_mas_status, stg_mas_loc, stg_mas_type, stg_mas_def_bin, stg_mas_rsn_code, stg_mas_frm_stage, stg_mas_frm_doc_typ, stg_mas_frm_doc_status, stg_mas_frm_doc_conf_req, stg_mas_to_stage, stg_mas_to_doc_typ, stg_mas_to_doc_status, stg_mas_to_doc_conf_req, stg_mas_timestamp, stg_mas_created_by, stg_mas_created_dt, stg_mas_modified_by, stg_mas_modified_dt, stg_mas_dock_status, stg_mas_dock_prevstat, stg_mas_frm_stage_typ, stg_mas_to_stage_typ, stg_mas_pack_bin, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.stg_mas_key, s.stg_mas_ou, s.stg_mas_id, s.stg_mas_desc, s.stg_mas_status, s.stg_mas_loc, s.stg_mas_type, s.stg_mas_def_bin, s.stg_mas_rsn_code, s.stg_mas_frm_stage, s.stg_mas_frm_doc_typ, s.stg_mas_frm_doc_status, s.stg_mas_frm_doc_conf_req, s.stg_mas_to_stage, s.stg_mas_to_doc_typ, s.stg_mas_to_doc_status, s.stg_mas_to_doc_conf_req, s.stg_mas_timestamp, s.stg_mas_created_by, s.stg_mas_created_dt, s.stg_mas_modified_by, s.stg_mas_modified_dt, s.stg_mas_dock_status, s.stg_mas_dock_prevstat, s.stg_mas_frm_stage_typ, s.stg_mas_to_stage_typ, s.stg_mas_pack_bin, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_stage s
    LEFT JOIN click.d_stage t
    ON t.stg_mas_ou = s.stg_mas_ou
    AND t.stg_mas_id = s.stg_mas_id
    AND t.stg_mas_loc = s.stg_mas_loc
    WHERE t.stg_mas_ou IS NULL;
END;
$$;