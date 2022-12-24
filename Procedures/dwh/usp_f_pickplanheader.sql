CREATE OR REPLACE PROCEDURE dwh.usp_f_pickplanheader(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
    FROM stg.stg_wms_pick_plan_hdr;

    UPDATE dwh.F_PickPlanHeader t
    SET
		pick_pln_loc_key			= COALESCE(l.loc_key,-1),
        pick_pln_date                 = s.wms_pick_pln_date,
        pick_pln_status               = s.wms_pick_pln_status,
        pick_employee                 = s.wms_pick_employee,
        pick_mhe                      = s.wms_pick_mhe,
        pick_staging_id               = s.wms_pick_staging_id,
        pick_created_by               = s.wms_pick_created_by,
        pick_created_date             = s.wms_pick_created_date,
        pick_modified_by              = s.wms_pick_modified_by,
        pick_modified_date            = s.wms_pick_modified_date,
        pick_timestamp                = s.wms_pick_timestamp,
        pick_output_pln               = s.wms_pick_output_pln,
        pick_steps                    = s.wms_pick_steps,
        pick_pln_urgent               = s.wms_pick_pln_urgent,
        pick_second_pln_no            = s.wms_pick_second_pln_no,
        pick_completed_flag           = s.wms_pick_completed_flag,
        pick_pln_type                 = s.wms_pick_pln_type,
        pick_zone_pickby              = s.wms_pick_zone_pickby,
        pick_conso_pln_no             = s.wms_pick_conso_pln_no,
        consolidated_pick_flg         = s.wms_consolidated_pick_flg,
        pick_consol_auto_cmplt        = s.wms_pick_consol_auto_cmplt,
        etlactiveind                  = 1,
        etljobname                    = p_etljobname,
        envsourcecd                   = p_envsourcecd,
        datasourcecd                  = p_datasourcecd,
        etlupdatedatetime             = NOW()
    FROM stg.stg_wms_pick_plan_hdr s	
	LEFT JOIN dwh.d_location l
	ON 	s.wms_pick_loc_code =	l.loc_code
	AND	s.wms_pick_pln_ou  =	l.loc_ou
	WHERE t.pick_loc_code = s.wms_pick_loc_code
    AND t.pick_pln_no = s.wms_pick_pln_no
    AND t.pick_pln_ou = s.wms_pick_pln_ou;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_PickPlanHeader
    (
        pick_pln_loc_key	,pick_loc_code		, pick_pln_no			, pick_pln_ou			,
		pick_pln_date		, pick_pln_status	, pick_employee			, pick_mhe				,
		pick_staging_id		, pick_created_by	, pick_created_date		, pick_modified_by		, 
		pick_modified_date	, pick_timestamp	, pick_output_pln		, pick_steps			, 
		pick_pln_urgent		, pick_second_pln_no, pick_completed_flag	, pick_pln_type			, 
		pick_zone_pickby	, pick_conso_pln_no	, consolidated_pick_flg	, pick_consol_auto_cmplt,
		etlactiveind		, etljobname		, envsourcecd			, datasourcecd			, 
		etlcreatedatetime
    )

    SELECT
         COALESCE(l.loc_key,-1)		, s.wms_pick_loc_code		, s.wms_pick_pln_no				, s.wms_pick_pln_ou		, 
		 s.wms_pick_pln_date		, s.wms_pick_pln_status		, s.wms_pick_employee			, s.wms_pick_mhe		,
		 s.wms_pick_staging_id		, s.wms_pick_created_by		, s.wms_pick_created_date		, s.wms_pick_modified_by,
		 s.wms_pick_modified_date	, s.wms_pick_timestamp		, s.wms_pick_output_pln			, s.wms_pick_steps		, 
		 s.wms_pick_pln_urgent		, s.wms_pick_second_pln_no	, s.wms_pick_completed_flag		, s.wms_pick_pln_type	,
		 s.wms_pick_zone_pickby		, s.wms_pick_conso_pln_no	, s.wms_consolidated_pick_flg	, s.wms_pick_consol_auto_cmplt ,
			 		1				, p_etljobname				, p_envsourcecd					, p_datasourcecd		,
		 		NOW()
    FROM stg.stg_wms_pick_plan_hdr s
	LEFT JOIN dwh.d_location l
	ON 	s.wms_pick_loc_code =	l.loc_code
	AND	s.wms_pick_pln_ou  =	l.loc_ou
    LEFT JOIN dwh.F_PickPlanHeader t
    ON s.wms_pick_loc_code = t.pick_loc_code
    AND s.wms_pick_pln_no = t.pick_pln_no
    AND s.wms_pick_pln_ou = t.pick_pln_ou
    WHERE t.pick_loc_code IS NULL;
	
	

    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_wms_pick_plan_hdr
    (
        wms_pick_loc_code			, wms_pick_pln_no		, wms_pick_pln_ou			, wms_pick_pln_date		,
		wms_pick_pln_status			, wms_pick_employee		, wms_pick_mhe				, wms_pick_staging_id	, 
		wms_pick_source_stage		, wms_pick_source_docno	, wms_pick_created_by		, wms_pick_created_date	,
		wms_pick_modified_by		, wms_pick_modified_date, wms_pick_timestamp		, wms_pick_userdefined1	, 
		wms_pick_userdefined2		, wms_pick_userdefined3	, wms_pick_output_pln		, wms_pick_steps		,
		wms_pick_pln_urgent			, wms_pick_second_pln_no, wms_pick_completed_flag	, wms_pick_pln_type		, 
		wms_pick_zone_pickby		, wms_pick_conso_pln_no	, wms_consolidated_pick_flg	, wms_pick_loose_flg	,
		wms_pick_consol_auto_cmplt	, etlcreateddatetime
    )
    SELECT
        wms_pick_loc_code			, wms_pick_pln_no		, wms_pick_pln_ou			, wms_pick_pln_date		,
		wms_pick_pln_status			, wms_pick_employee		, wms_pick_mhe				, wms_pick_staging_id	, 
		wms_pick_source_stage		, wms_pick_source_docno	, wms_pick_created_by		, wms_pick_created_date	,
		wms_pick_modified_by		, wms_pick_modified_date, wms_pick_timestamp		, wms_pick_userdefined1	, 
		wms_pick_userdefined2		, wms_pick_userdefined3	, wms_pick_output_pln		, wms_pick_steps		,
		wms_pick_pln_urgent			, wms_pick_second_pln_no, wms_pick_completed_flag	, wms_pick_pln_type		, 
		wms_pick_zone_pickby		, wms_pick_conso_pln_no	, wms_consolidated_pick_flg	, wms_pick_loose_flg	,
		wms_pick_consol_auto_cmplt	, etlcreateddatetime
	FROM stg.stg_wms_pick_plan_hdr;
    END IF;

    EXCEPTION
        WHEN others THEN
        get stacked diagnostics
        p_errorid   = returned_sqlstate,
        p_errordesc = message_text;
    CALL ods.usp_etlerrorinsert(p_sourceid, p_targetobject, p_dataflowflag, p_batchid,p_taskname, 'sp_ExceptionHandling', p_errorid, p_errordesc, null);
       select 0 into inscnt;
       select 0 into updcnt;
	   
END;

$$;