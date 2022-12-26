CREATE OR REPLACE PROCEDURE dwh.usp_f_pickingheader(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
    FROM stg.stg_wms_pick_exec_hdr;

    UPDATE dwh.F_PickingHeader t
    SET
		pick_loc_key				= COALESCE(l.loc_key,-1),
        pick_exec_date              = s.wms_pick_exec_date,
        pick_exec_status            = s.wms_pick_exec_status,
        pick_pln_no                 = s.wms_pick_pln_no,
        pick_employee               = s.wms_pick_employee,
        pick_mhe                    = s.wms_pick_mhe,
        pick_staging_id             = s.wms_pick_staging_id,
        pick_exec_start_date        = s.wms_pick_exec_start_date,
        pick_exec_end_date          = s.wms_pick_exec_end_date,
        pick_created_by             = s.wms_pick_created_by,
        pick_created_date           = s.wms_pick_created_date,
        pick_modified_by            = s.wms_pick_modified_by,
        pick_modified_date          = s.wms_pick_modified_date,
        pick_timestamp              = s.wms_pick_timestamp,
        pick_steps                  = s.wms_pick_steps,
        pk_exe_urgent_cb            = s.wms_pk_exe_urgent_cb,
        pick_gen_from               = s.wms_pick_gen_from,
        pick_pln_type               = s.wms_pick_pln_type,
        pick_zone_pickby            = s.wms_pick_zone_pickby,
        pick_reset_flg              = s.wms_pick_reset_flg,
        pick_system_date            = s.wms_pick_system_date,
        etlactiveind                = 1,
        etljobname                  = p_etljobname,
        envsourcecd                 = p_envsourcecd,
        datasourcecd                = p_datasourcecd,
        etlupdatedatetime           = NOW()
    FROM stg.stg_wms_pick_exec_hdr s
    LEFT JOIN dwh.d_location L      
		ON	s.wms_pick_loc_code		=	L.loc_code 
		AND	s.wms_pick_exec_ou		=	L.loc_ou
    WHERE t.pick_loc_code = s.wms_pick_loc_code
    AND t.pick_exec_no = s.wms_pick_exec_no
    AND t.pick_exec_ou = s.wms_pick_exec_ou;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_PickingHeader
    (
		pick_loc_key		,
        pick_loc_code		, pick_exec_no		, pick_exec_ou		, 
		pick_exec_date		, pick_exec_status	, pick_pln_no		, 
		pick_employee		, pick_mhe			, pick_staging_id	,
		pick_exec_start_date, pick_exec_end_date, pick_created_by	, 
		pick_created_date	, pick_modified_by	, pick_modified_date, 
		pick_timestamp		, pick_steps		, pk_exe_urgent_cb	, 
		pick_gen_from		, pick_pln_type		, pick_zone_pickby	, 
		pick_reset_flg		, pick_system_date	, 
		etlactiveind		, etljobname		, envsourcecd		,
		datasourcecd		, etlcreatedatetime
    )

    SELECT
		COALESCE(l.loc_key,-1),
        s.wms_pick_loc_code			, s.wms_pick_exec_no		, s.wms_pick_exec_ou		,
		s.wms_pick_exec_date		, s.wms_pick_exec_status	, s.wms_pick_pln_no			,
		s.wms_pick_employee			, s.wms_pick_mhe			, s.wms_pick_staging_id		,
		s.wms_pick_exec_start_date	, s.wms_pick_exec_end_date	, s.wms_pick_created_by		, 
		s.wms_pick_created_date		, s.wms_pick_modified_by	, s.wms_pick_modified_date	,
		s.wms_pick_timestamp		, s.wms_pick_steps			, s.wms_pk_exe_urgent_cb	,
		s.wms_pick_gen_from			, s.wms_pick_pln_type		, s.wms_pick_zone_pickby	, 
		s.wms_pick_reset_flg		, s.wms_pick_system_date	,
				1					, p_etljobname				, p_envsourcecd				, 
		p_datasourcecd				, NOW()
    FROM stg.stg_wms_pick_exec_hdr s
    LEFT JOIN dwh.d_location L      
		ON	s.wms_pick_loc_code		=	L.loc_code 
		AND	s.wms_pick_exec_ou		=	L.loc_ou
    LEFT JOIN dwh.F_PickingHeader t
    ON s.wms_pick_loc_code = t.pick_loc_code
    AND s.wms_pick_exec_no = t.pick_exec_no
    AND s.wms_pick_exec_ou = t.pick_exec_ou
    WHERE t.pick_loc_code IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_wms_pick_exec_hdr
    (
        wms_pick_loc_code		, wms_pick_exec_no			, wms_pick_exec_ou		, 
		wms_pick_exec_date		, wms_pick_exec_status		, wms_pick_pln_no		, 
		wms_pick_employee		, wms_pick_mhe				, wms_pick_staging_id	, 
		wms_pick_exec_start_date, wms_pick_exec_end_date	, wms_pick_created_by	, 
		wms_pick_created_date	, wms_pick_modified_by		, wms_pick_modified_date, 
		wms_pick_timestamp		, wms_pick_userdefined1		, wms_pick_userdefined2	, 
		wms_pick_userdefined3	, wms_pick_billing_status	, wms_pick_bill_value	, 
		wms_pick_steps			, wms_pk_exe_urgent_cb		, wms_pick_gen_from		, 
		wms_pick_pln_type		, wms_pick_zone_pickby		, wms_pick_reset_flg	, 
		wms_pick_system_date	, etlcreateddatetime
    )
    SELECT
        wms_pick_loc_code		, wms_pick_exec_no			, wms_pick_exec_ou		, 
		wms_pick_exec_date		, wms_pick_exec_status		, wms_pick_pln_no		, 
		wms_pick_employee		, wms_pick_mhe				, wms_pick_staging_id	, 
		wms_pick_exec_start_date, wms_pick_exec_end_date	, wms_pick_created_by	, 
		wms_pick_created_date	, wms_pick_modified_by		, wms_pick_modified_date, 
		wms_pick_timestamp		, wms_pick_userdefined1		, wms_pick_userdefined2	, 
		wms_pick_userdefined3	, wms_pick_billing_status	, wms_pick_bill_value	, 
		wms_pick_steps			, wms_pk_exe_urgent_cb		, wms_pick_gen_from		, 
		wms_pick_pln_type		, wms_pick_zone_pickby		, wms_pick_reset_flg	, 
		wms_pick_system_date	, etlcreateddatetime
	FROM stg.stg_wms_pick_exec_hdr;
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