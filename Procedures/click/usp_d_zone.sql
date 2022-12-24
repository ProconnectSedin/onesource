CREATE OR REPLACE PROCEDURE click.usp_d_zone()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_zone t
    SET
        zone_key = s.zone_key,
        zone_code = s.zone_code,
        zone_ou = s.zone_ou,
        zone_loc_code = s.zone_loc_code,
        zone_description = s.zone_description,
        zone_status = s.zone_status,
        zone_reason = s.zone_reason,
        zone_type = s.zone_type,
        zone_pick_strategy = s.zone_pick_strategy,
        zone_pick_req_confirm = s.zone_pick_req_confirm,
        zone_block_picking = s.zone_block_picking,
        zone_pick_label = s.zone_pick_label,
        zone_pick_per_picklist = s.zone_pick_per_picklist,
        zone_pick_by = s.zone_pick_by,
        zone_pick_sequence = s.zone_pick_sequence,
        zone_put_strategy = s.zone_put_strategy,
        zone_put_req_confirm = s.zone_put_req_confirm,
        zone_add_existing_stk = s.zone_add_existing_stk,
        zone_block_putaway = s.zone_block_putaway,
        zone_capacity_check = s.zone_capacity_check,
        zone_mixed_storage = s.zone_mixed_storage,
        zone_mixed_stor_strategy = s.zone_mixed_stor_strategy,
        zone_timestamp = s.zone_timestamp,
        zone_created_by = s.zone_created_by,
        zone_created_date = s.zone_created_date,
        zone_modified_by = s.zone_modified_by,
        zone_modified_date = s.zone_modified_date,
        zone_step = s.zone_step,
        zone_pick = s.zone_pick,
        zone_matchpallet_qty = s.zone_matchpallet_qty,
        zone_batch_allowed = s.zone_batch_allowed,
        zone_uid_allowed = s.zone_uid_allowed,
        zone_pick_stage = s.zone_pick_stage,
        zone_putaway_stage = s.zone_putaway_stage,
        zone_cap_chk = s.zone_cap_chk,
        zone_packing = s.zone_packing,
        zone_adv_pick_strategy = s.zone_adv_pick_strategy,
        zone_adv_pwy_strategy = s.zone_adv_pwy_strategy,
        pcs_noofmnth = s.pcs_noofmnth,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_zone s
    WHERE t.zone_code = s.zone_code
    AND t.zone_ou = s.zone_ou
    AND t.zone_loc_code = s.zone_loc_code;

    INSERT INTO click.d_zone(zone_key, zone_code, zone_ou, zone_loc_code, zone_description, zone_status, zone_reason, zone_type, zone_pick_strategy, zone_pick_req_confirm, zone_block_picking, zone_pick_label, zone_pick_per_picklist, zone_pick_by, zone_pick_sequence, zone_put_strategy, zone_put_req_confirm, zone_add_existing_stk, zone_block_putaway, zone_capacity_check, zone_mixed_storage, zone_mixed_stor_strategy, zone_timestamp, zone_created_by, zone_created_date, zone_modified_by, zone_modified_date, zone_step, zone_pick, zone_matchpallet_qty, zone_batch_allowed, zone_uid_allowed, zone_pick_stage, zone_putaway_stage, zone_cap_chk, zone_packing, zone_adv_pick_strategy, zone_adv_pwy_strategy, pcs_noofmnth, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.zone_key, s.zone_code, s.zone_ou, s.zone_loc_code, s.zone_description, s.zone_status, s.zone_reason, s.zone_type, s.zone_pick_strategy, s.zone_pick_req_confirm, s.zone_block_picking, s.zone_pick_label, s.zone_pick_per_picklist, s.zone_pick_by, s.zone_pick_sequence, s.zone_put_strategy, s.zone_put_req_confirm, s.zone_add_existing_stk, s.zone_block_putaway, s.zone_capacity_check, s.zone_mixed_storage, s.zone_mixed_stor_strategy, s.zone_timestamp, s.zone_created_by, s.zone_created_date, s.zone_modified_by, s.zone_modified_date, s.zone_step, s.zone_pick, s.zone_matchpallet_qty, s.zone_batch_allowed, s.zone_uid_allowed, s.zone_pick_stage, s.zone_putaway_stage, s.zone_cap_chk, s.zone_packing, s.zone_adv_pick_strategy, s.zone_adv_pwy_strategy, s.pcs_noofmnth, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_zone s
    LEFT JOIN click.d_zone t
    ON t.zone_code = s.zone_code
    AND t.zone_ou = s.zone_ou
    AND t.zone_loc_code = s.zone_loc_code
    WHERE t.zone_code IS NULL;
END;
$$;