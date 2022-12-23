-- PROCEDURE: click.usp_d_excessitem()

-- DROP PROCEDURE IF EXISTS click.usp_d_excessitem();

CREATE OR REPLACE PROCEDURE click.usp_d_excessitem(
	)
LANGUAGE 'plpgsql'
AS $BODY$

Declare p_etllastrundate date;
BEGIN

	SELECT max(COALESCE(etlupdatedatetime,etlcreatedatetime)):: DATE as p_etllastrundate
	INTO p_etllastrundate
	FROM click.d_excessitem;
	
    UPDATE click.d_excessitem t
    SET
        ex_itm_key = s.ex_itm_key,
        ex_itm_ou = s.ex_itm_ou,
        ex_itm_code = s.ex_itm_code,
        ex_itm_loc_code = s.ex_itm_loc_code,
        ex_itm_desc = s.ex_itm_desc,
        ex_itm_cap_profile = s.ex_itm_cap_profile,
        ex_itm_zone_profile = s.ex_itm_zone_profile,
        ex_itm_stage_profile = s.ex_itm_stage_profile,
        ex_itm_effective_frm = s.ex_itm_effective_frm,
        ex_itm_effective_to = s.ex_itm_effective_to,
        ex_itm_pick_per_tol_pos = s.ex_itm_pick_per_tol_pos,
        ex_itm_pick_per_tol_neg = s.ex_itm_pick_per_tol_neg,
        ex_itm_pick_uom_tol_pos = s.ex_itm_pick_uom_tol_pos,
        ex_itm_pick_uom_tol_neg = s.ex_itm_pick_uom_tol_neg,
        ex_itm_mininum_qty = s.ex_itm_mininum_qty,
        ex_itm_maximum_qty = s.ex_itm_maximum_qty,
        ex_itm_replen_qty = s.ex_itm_replen_qty,
        ex_itm_master_uom = s.ex_itm_master_uom,
        ex_itm_timestamp = s.ex_itm_timestamp,
        ex_itm_created_by = s.ex_itm_created_by,
        ex_itm_created_dt = s.ex_itm_created_dt,
        ex_itm_modified_by = s.ex_itm_modified_by,
        ex_itm_modified_dt = s.ex_itm_modified_dt,
        ex_itm_packing_bay = s.ex_itm_packing_bay,
        ex_itm_low_stk_lvl = s.ex_itm_low_stk_lvl,
        ex_itm_std_strg_thu_id = s.ex_itm_std_strg_thu_id,
        ex_itm_wave_repln_req = s.ex_itm_wave_repln_req,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = s.etlupdatedatetime
    FROM dwh.d_excessitem s
    WHERE t.ex_itm_ou = s.ex_itm_ou
    AND t.ex_itm_code = s.ex_itm_code
    AND t.ex_itm_loc_code = s.ex_itm_loc_code
	AND COALESCE(s.etlupdatedatetime,s.etlcreatedatetime)::DATE >= p_etllastrundate;

    INSERT INTO click.d_excessitem(ex_itm_key, ex_itm_ou, ex_itm_code, ex_itm_loc_code, ex_itm_desc, ex_itm_cap_profile, ex_itm_zone_profile, ex_itm_stage_profile, ex_itm_effective_frm, ex_itm_effective_to, ex_itm_pick_per_tol_pos, ex_itm_pick_per_tol_neg, ex_itm_pick_uom_tol_pos, ex_itm_pick_uom_tol_neg, ex_itm_mininum_qty, ex_itm_maximum_qty, ex_itm_replen_qty, ex_itm_master_uom, ex_itm_timestamp, ex_itm_created_by, ex_itm_created_dt, ex_itm_modified_by, ex_itm_modified_dt, ex_itm_packing_bay, ex_itm_low_stk_lvl, ex_itm_std_strg_thu_id, ex_itm_wave_repln_req, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.ex_itm_key, s.ex_itm_ou, s.ex_itm_code, s.ex_itm_loc_code, s.ex_itm_desc, s.ex_itm_cap_profile, s.ex_itm_zone_profile, s.ex_itm_stage_profile, s.ex_itm_effective_frm, s.ex_itm_effective_to, s.ex_itm_pick_per_tol_pos, s.ex_itm_pick_per_tol_neg, s.ex_itm_pick_uom_tol_pos, s.ex_itm_pick_uom_tol_neg, s.ex_itm_mininum_qty, s.ex_itm_maximum_qty, s.ex_itm_replen_qty, s.ex_itm_master_uom, s.ex_itm_timestamp, s.ex_itm_created_by, s.ex_itm_created_dt, s.ex_itm_modified_by, s.ex_itm_modified_dt, s.ex_itm_packing_bay, s.ex_itm_low_stk_lvl, s.ex_itm_std_strg_thu_id, s.ex_itm_wave_repln_req, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, s.etlcreatedatetime
    FROM dwh.d_excessitem s
    LEFT JOIN click.d_excessitem t
    ON t.ex_itm_ou = s.ex_itm_ou
    AND t.ex_itm_code = s.ex_itm_code
    AND t.ex_itm_loc_code = s.ex_itm_loc_code
    WHERE t.ex_itm_ou IS NULL
	AND COALESCE(s.etlupdatedatetime,s.etlcreatedatetime)::DATE >= p_etllastrundate;
END;
$BODY$;
ALTER PROCEDURE click.usp_d_excessitem()
    OWNER TO proconnect;
