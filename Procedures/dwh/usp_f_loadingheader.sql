CREATE PROCEDURE dwh.usp_f_loadingheader(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
    FROM stg.stg_wms_loading_exec_hdr;

    UPDATE dwh.F_LoadingHeader t
    SET
        loading_hdr_loc_key			  = COALESCE(l.loc_key,-1),
		loading_hdr_emp_hdr_key		  = COALESCE(e.emp_hdr_key,-1),
		loading_hdr_veh_key			  = COALESCE(v.veh_key,-1),
		loading_hdr_eqp_key			  = COALESCE(eq.eqp_key,-1),
        loading_exec_date             = s.wms_loading_exec_date,
        loading_exec_status           = s.wms_loading_exec_status,
        loading_ld_sheet_no           = s.wms_loading_ld_sheet_no,
        loading_dock                  = s.wms_loading_dock,
        loading_mhe                   = s.wms_loading_mhe,
        loading_employee              = s.wms_loading_employee,
        loading_packing_bay           = s.wms_loading_packing_bay,
        loading_veh_type              = s.wms_loading_veh_type,
        loading_veh_no                = s.wms_loading_veh_no,
        loading_equip_type            = s.wms_laoding_equip_type,
        loading_equip_no              = s.wms_laoding_equip_no,
        loading_container_no          = s.wms_loading_container_no,
        loading_person                = s.wms_loading_person,
        loading_lsp                   = s.wms_loading_lsp,
        loading_created_by            = s.wms_loading_created_by,
        loading_created_date          = s.wms_loading_created_date,
        loading_modified_by           = s.wms_loading_modified_by,
        loading_modified_date         = s.wms_loading_modified_date,
        loading_timestamp             = s.wms_loading_timestamp,
        loading_manifest_no           = s.wms_loading_manifest_no,
        loading_exec_startdate        = s.wms_loading_exec_startdate,
        loading_exec_enddate          = s.wms_loading_exec_enddate,
        loading_exe_urgent            = s.wms_loading_exe_urgent,
        loading_exec_seal_no          = s.wms_loading_exec_seal_no,
        loading_booking_req           = s.wms_loading_booking_req,
        loading_gen_from              = s.wms_loading_gen_from,
        loading_rsn_code              = s.wms_loading_rsn_code,
        etlactiveind                  = 1,
        etljobname                    = p_etljobname,
        envsourcecd                   = p_envsourcecd,
        datasourcecd                  = p_datasourcecd,
        etlupdatedatetime             = NOW()
    FROM stg.stg_wms_loading_exec_hdr s
	LEFT JOIN dwh.d_location l 		
		ON  s.wms_loading_loc_code 		= l.loc_code 
		AND s.wms_loading_exec_ou 		= l.loc_ou 
	LEFT JOIN dwh.d_employeeheader e 
		ON  s.wms_loading_employee		= e.emp_employee_code
		AND s.wms_loading_exec_ou 		= e.emp_ou 
	LEFT JOIN dwh.d_vehicle v 
		ON  s.wms_loading_veh_no		= v.veh_id
		AND s.wms_loading_exec_ou 		= v.veh_ou 
	LEFT JOIN dwh.d_equipment eq 
		ON  s.wms_laoding_equip_no		= eq.eqp_equipment_id
		AND s.wms_loading_exec_ou 		= eq.eqp_ou 
    WHERE t.loading_loc_code = s.wms_loading_loc_code
    AND t.loading_exec_no = s.wms_loading_exec_no
    AND t.loading_exec_ou = s.wms_loading_exec_ou;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_LoadingHeader
    (
		loading_hdr_loc_key, loading_hdr_emp_hdr_key, loading_hdr_veh_key, loading_hdr_eqp_key,
        loading_loc_code, loading_exec_no, loading_exec_ou, loading_exec_date, loading_exec_status, loading_ld_sheet_no, loading_dock, loading_mhe, loading_employee, loading_packing_bay, loading_veh_type, loading_veh_no, loading_equip_type, loading_equip_no, loading_container_no, loading_person, loading_lsp, loading_created_by, loading_created_date, loading_modified_by, loading_modified_date, loading_timestamp, loading_manifest_no, loading_exec_startdate, loading_exec_enddate, loading_exe_urgent, loading_exec_seal_no, loading_booking_req, loading_gen_from, loading_rsn_code, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
		COALESCE(l.loc_key,-1), COALESCE(e.emp_hdr_key,-1), COALESCE(v.veh_key,-1), COALESCE(eq.eqp_key,-1),
        s.wms_loading_loc_code, s.wms_loading_exec_no, s.wms_loading_exec_ou, s.wms_loading_exec_date, s.wms_loading_exec_status, s.wms_loading_ld_sheet_no, s.wms_loading_dock, s.wms_loading_mhe, s.wms_loading_employee, s.wms_loading_packing_bay, s.wms_loading_veh_type, s.wms_loading_veh_no, s.wms_laoding_equip_type, s.wms_laoding_equip_no, s.wms_loading_container_no, s.wms_loading_person, s.wms_loading_lsp, s.wms_loading_created_by, s.wms_loading_created_date, s.wms_loading_modified_by, s.wms_loading_modified_date, s.wms_loading_timestamp, s.wms_loading_manifest_no, s.wms_loading_exec_startdate, s.wms_loading_exec_enddate, s.wms_loading_exe_urgent, s.wms_loading_exec_seal_no, s.wms_loading_booking_req, s.wms_loading_gen_from, s.wms_loading_rsn_code, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_wms_loading_exec_hdr s
	LEFT JOIN dwh.d_location l 		
		ON  s.wms_loading_loc_code 		= l.loc_code 
		AND s.wms_loading_exec_ou 		= l.loc_ou 
	LEFT JOIN dwh.d_employeeheader e 
		ON  s.wms_loading_employee		= e.emp_employee_code
		AND s.wms_loading_exec_ou 		= e.emp_ou 
	LEFT JOIN dwh.d_vehicle v 
		ON  s.wms_loading_veh_no		= v.veh_id
		AND s.wms_loading_exec_ou 		= v.veh_ou 
	LEFT JOIN dwh.d_equipment eq 
		ON  s.wms_laoding_equip_no		= eq.eqp_equipment_id
		AND s.wms_loading_exec_ou 		= eq.eqp_ou 
    LEFT JOIN dwh.F_LoadingHeader t
    ON 		s.wms_loading_loc_code 		= t.loading_loc_code
    AND 	s.wms_loading_exec_no 		= t.loading_exec_no
    AND 	s.wms_loading_exec_ou 		= t.loading_exec_ou
    WHERE 	t.loading_exec_ou IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_wms_loading_exec_hdr
    (
        wms_loading_loc_code, wms_loading_exec_no, wms_loading_exec_ou, wms_loading_exec_date, wms_loading_exec_status, wms_loading_ld_sheet_no, wms_loading_dock, wms_loading_mhe, wms_loading_employee, wms_loading_packing_bay, wms_loading_veh_type, wms_loading_veh_no, wms_laoding_equip_type, wms_laoding_equip_no, wms_loading_container_no, wms_loading_person, wms_loading_lsp, wms_loading_created_by, wms_loading_created_date, wms_loading_modified_by, wms_loading_modified_date, wms_loading_timestamp, wms_loading_userdefined1, wms_loading_userdefined2, wms_loading_userdefined3, wms_loading_manifest_no, wms_loading_exec_startdate, wms_loading_exec_enddate, wms_loading_exe_urgent, wms_loading_exec_seal_no, wms_loading_booking_req, wms_loading_manf_flag, wms_loading_gen_from, wms_loading_rsn_code, wms_loading_trip_planid, etlcreateddatetime
    )
    SELECT
        wms_loading_loc_code, wms_loading_exec_no, wms_loading_exec_ou, wms_loading_exec_date, wms_loading_exec_status, wms_loading_ld_sheet_no, wms_loading_dock, wms_loading_mhe, wms_loading_employee, wms_loading_packing_bay, wms_loading_veh_type, wms_loading_veh_no, wms_laoding_equip_type, wms_laoding_equip_no, wms_loading_container_no, wms_loading_person, wms_loading_lsp, wms_loading_created_by, wms_loading_created_date, wms_loading_modified_by, wms_loading_modified_date, wms_loading_timestamp, wms_loading_userdefined1, wms_loading_userdefined2, wms_loading_userdefined3, wms_loading_manifest_no, wms_loading_exec_startdate, wms_loading_exec_enddate, wms_loading_exe_urgent, wms_loading_exec_seal_no, wms_loading_booking_req, wms_loading_manf_flag, wms_loading_gen_from, wms_loading_rsn_code, wms_loading_trip_planid, etlcreateddatetime
    FROM stg.stg_wms_loading_exec_hdr;
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