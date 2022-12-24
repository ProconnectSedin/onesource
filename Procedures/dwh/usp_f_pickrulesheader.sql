CREATE OR REPLACE PROCEDURE dwh.usp_f_pickrulesheader(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
    FROM stg.stg_wms_pick_rules_hdr;

    UPDATE dwh.f_pickRulesHeader t
    SET
        pick_loc_key               = COALESCE(l.loc_key,-1),
        pick_schedule              = s.wms_pick_schedule,
        pick_outputlist            = s.wms_pick_outputlist,
        pick_eqp_assign            = s.wms_pick_eqp_assign,
        pick_emp_assign            = s.wms_pick_emp_assign,
        pick_timestamp             = s.wms_pick_timestamp,
        pick_created_by            = s.wms_pick_created_by,
        pick_created_date          = s.wms_pick_created_date,
        pick_modified_by           = s.wms_pick_modified_by,
        pick_modified_date         = s.wms_pick_modified_date,
        pick_countback_func        = s.wms_pick_countback_func,
        pick_auto_deconsol         = s.wms_pick_auto_deconsol,
        etlactiveind               = 1,
        etljobname                 = p_etljobname,
        envsourcecd                = p_envsourcecd,
        datasourcecd               = p_datasourcecd,
        etlupdatedatetime          = NOW()
    FROM stg.stg_wms_pick_rules_hdr s
	LEFT JOIN dwh.d_location L 		
	ON  s.wms_pick_loc_code	 			= L.loc_code 
    AND s.wms_pick_ou	        		= L.loc_ou
    WHERE t.pick_loc_code = s.wms_pick_loc_code
    AND   t.pick_ou = s.wms_pick_ou;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.f_pickRulesHeader
    (
        pick_loc_key,pick_loc_code, pick_ou, pick_schedule, pick_outputlist, pick_eqp_assign, pick_emp_assign, pick_timestamp, pick_created_by, pick_created_date, pick_modified_by, pick_modified_date, pick_countback_func, pick_auto_deconsol, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        COALESCE(l.loc_key,-1),s.wms_pick_loc_code, s.wms_pick_ou, s.wms_pick_schedule, s.wms_pick_outputlist, s.wms_pick_eqp_assign, s.wms_pick_emp_assign, s.wms_pick_timestamp, s.wms_pick_created_by, s.wms_pick_created_date, s.wms_pick_modified_by, s.wms_pick_modified_date, s.wms_pick_countback_func, s.wms_pick_auto_deconsol, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_wms_pick_rules_hdr s
	LEFT JOIN dwh.d_location L 		
	ON  s.wms_pick_loc_code	 			= L.loc_code 
    AND s.wms_pick_ou	        		= L.loc_ou
    LEFT JOIN dwh.f_pickRulesHeader t
    ON s.wms_pick_loc_code = t.pick_loc_code
    AND s.wms_pick_ou = t.pick_ou
    WHERE t.pick_loc_code IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_wms_pick_rules_hdr
    (
        wms_pick_loc_code, wms_pick_ou, wms_pick_schedule, wms_pick_outputlist, wms_pick_eqp_assign, wms_pick_emp_assign, wms_pick_timestamp, wms_pick_created_by, wms_pick_created_date, wms_pick_modified_by, wms_pick_modified_date, wms_pick_userdefined1, wms_pick_userdefined2, wms_pick_userdefined3, wms_pick_countback_func, wms_pick_auto_deconsol, etlcreateddatetime
    )
    SELECT
        wms_pick_loc_code, wms_pick_ou, wms_pick_schedule, wms_pick_outputlist, wms_pick_eqp_assign, wms_pick_emp_assign, wms_pick_timestamp, wms_pick_created_by, wms_pick_created_date, wms_pick_modified_by, wms_pick_modified_date, wms_pick_userdefined1, wms_pick_userdefined2, wms_pick_userdefined3, wms_pick_countback_func, wms_pick_auto_deconsol, etlcreateddatetime
    FROM stg.stg_wms_pick_rules_hdr;
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