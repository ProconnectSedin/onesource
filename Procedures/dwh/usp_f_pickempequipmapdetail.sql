CREATE PROCEDURE dwh.usp_f_pickempequipmapdetail(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
    LANGUAGE plpgsql
    AS $$

DECLARE
    p_etljobname VARCHAR(100);
    p_envsourcecd VARCHAR(50);
    p_datasourcecd VARCHAR(50);
    p_batchid integer;
    p_taskname VARCHAR(100);
    p_packagename  VARCHAR(100);
    p_errorid integer;
    p_errordesc character varying;
    p_errorline integer;
    p_rawstorageflag integer;

BEGIN
    SELECT d.jobname, h.envsourcecode, h.datasourcecode, d.latestbatchid, d.targetprocedurename, h.rawstorageflag
    INTO p_etljobname, p_envsourcecd, p_datasourcecd, p_batchid, p_taskname, p_rawstorageflag
    FROM ods.controldetail d
    INNER JOIN ods.controlheader h
        ON d.sourceid = h.sourceid
    WHERE d.sourceid = p_sourceId
        AND d.dataflowflag = p_dataflowflag
        AND d.targetobject = p_targetobject;

	

    SELECT COUNT(1) INTO srccnt
    FROM stg.stg_wms_pick_emp_equip_map_dtl;

    UPDATE dwh.F_PickEmpEquipMapDetail t
    SET
        pick_emp_eqp_dtl_key_loc_key = COALESCE(l.loc_key,-1),
		pick_emp_eqp_dtl_key_emp_hdr_key = COALESCE(e.emp_hdr_key,-1),
		pick_emp_eqp_dtl_key_eqp_key = COALESCE(eq.eqp_key,-1),
		pick_emp_eqp_dtl_key_zone_key = COALESCE(z.zone_key,-1),
        pick_shift_code        = s.wms_pick_shift_code,
        pick_emp_code          = s.wms_pick_emp_code,
        pick_euip_code         = s.wms_pick_euip_code,
        pick_area              = s.wms_pick_area,
        pick_zone              = s.wms_pick_zone,
        pick_bin_level         = s.wms_pick_bin_level,
        etlactiveind           = 1,
        etljobname             = p_etljobname,
        envsourcecd            = p_envsourcecd,
        datasourcecd           = p_datasourcecd,
        etlupdatedatetime      = NOW()
    FROM stg.stg_wms_pick_emp_equip_map_dtl s
	LEFT JOIN dwh.d_location l 		
		ON  s.wms_pick_loc_code   = l.loc_code 
        AND s.wms_pick_ou         = l.loc_ou
	LEFT JOIN dwh.d_employeeheader e 			
		ON  s.wms_pick_emp_code	 = e.emp_employee_code
		AND s.wms_pick_ou		 = e.emp_ou
	LEFT JOIN dwh.d_equipment eq 		
		ON  s.wms_pick_euip_code = eq.eqp_equipment_id
		AND s.wms_pick_ou 		 = eq.eqp_ou
	LEFT JOIN dwh.d_zone z 		
		ON  s.wms_pick_zone		 = z.zone_code 
		AND s.wms_pick_ou 		 = z.zone_ou
    WHERE 	t.pick_loc_code = s.wms_pick_loc_code
    AND 	t.pick_ou       = s.wms_pick_ou
    AND 	t.pick_lineno   = s.wms_pick_lineno;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_PickEmpEquipMapDetail
    (
        pick_emp_eqp_dtl_key_loc_key,pick_emp_eqp_dtl_key_emp_hdr_key,pick_emp_eqp_dtl_key_eqp_key,pick_emp_eqp_dtl_key_zone_key,
        pick_loc_code, pick_ou, pick_lineno, pick_shift_code, pick_emp_code, 
		pick_euip_code, pick_area, pick_zone, pick_bin_level, etlactiveind, 
		etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        COALESCE(l.loc_key,-1),COALESCE(e.emp_hdr_key,-1),COALESCE(eq.eqp_key,-1),COALESCE(z.zone_key,-1),
        s.wms_pick_loc_code, s.wms_pick_ou, s.wms_pick_lineno, s.wms_pick_shift_code, s.wms_pick_emp_code, 
		s.wms_pick_euip_code, s.wms_pick_area, s.wms_pick_zone, s.wms_pick_bin_level, 1
		, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_wms_pick_emp_equip_map_dtl s
	LEFT JOIN dwh.d_location l 		
		ON  s.wms_pick_loc_code   = l.loc_code 
        AND s.wms_pick_ou         = l.loc_ou
	LEFT JOIN dwh.d_employeeheader e 			
		ON  s.wms_pick_emp_code	 = e.emp_employee_code
		AND s.wms_pick_ou		 = e.emp_ou
	LEFT JOIN dwh.d_equipment eq 		
		ON  s.wms_pick_euip_code = eq.eqp_equipment_id
		AND s.wms_pick_ou 		 = eq.eqp_ou
	LEFT JOIN dwh.d_zone z 		
		ON  s.wms_pick_zone		 = z.zone_code 
		AND s.wms_pick_ou 		 = z.zone_ou
    LEFT JOIN dwh.F_PickEmpEquipMapDetail t
    ON   s.wms_pick_loc_code = t.pick_loc_code
    AND  s.wms_pick_ou       = t.pick_ou
    AND  s.wms_pick_lineno   = t.pick_lineno
    WHERE t.pick_loc_code IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_wms_pick_emp_equip_map_dtl
    (
        wms_pick_loc_code, wms_pick_ou, wms_pick_lineno, wms_pick_shift_code, wms_pick_emp_code, 
		wms_pick_euip_code, wms_pick_area, wms_pick_zone, wms_pick_bin_level, etlcreateddatetime
    )
    SELECT
        wms_pick_loc_code, wms_pick_ou, wms_pick_lineno, wms_pick_shift_code, wms_pick_emp_code, 
		wms_pick_euip_code, wms_pick_area, wms_pick_zone, wms_pick_bin_level, etlcreateddatetime
    FROM stg.stg_wms_pick_emp_equip_map_dtl;
    END IF;
	
    EXCEPTION WHEN others THEN
        get stacked diagnostics
            p_errorid   = returned_sqlstate,
            p_errordesc = message_text;
    CALL ods.usp_etlerrorinsert(p_sourceid, p_targetobject, p_dataflowflag, p_batchid,p_taskname, 'sp_ExceptionHandling', p_errorid, p_errordesc, null);
       select 0 into inscnt;
       select 0 into updcnt;
END;
$$;