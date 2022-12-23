CREATE PROCEDURE dwh.usp_f_waveheader(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
    FROM stg.stg_wms_wave_hdr;

    UPDATE dwh.f_waveHeader t
    SET
	    wave_loc_key			   = COALESCE(l.loc_key,-1),
        wave_date                  = s.wms_wave_date,
        wave_status                = s.wms_wave_status,
        wave_pln_start_date        = s.wms_wave_pln_start_date,
        wave_pln_end_date          = s.wms_wave_pln_end_date,
        wave_timestamp             = s.wms_wave_timestamp,
        wave_created_by            = s.wms_wave_created_by,
        wave_created_date          = s.wms_wave_created_date,
        wave_modified_by           = s.wms_wave_modified_by,
        wave_modified_date         = s.wms_wave_modified_date,
        wave_alloc_rule            = s.wms_wave_alloc_rule,
        wave_alloc_value           = s.wms_wave_alloc_value,
        wave_alloc_uom             = s.wms_wave_alloc_uom,
        wave_no_of_pickers         = s.wms_wave_no_of_pickers,
        wave_gen_flag              = s.wms_wave_gen_flag,
        wave_staging_id            = s.wms_wave_staging_id,
        wave_replenish_flag        = s.wms_wave_replenish_flag,
        consolidated_flg           = s.wms_consolidated_flg,
        etlactiveind               = 1,
        etljobname                 = p_etljobname,
        envsourcecd                = p_envsourcecd,
        datasourcecd               = p_datasourcecd,
        etlupdatedatetime          = NOW()
    FROM stg.stg_wms_wave_hdr s
	LEFT JOIN dwh.d_location l
	ON 	s.wms_wave_loc_code =	l.loc_code
	AND	s.wms_wave_ou       =	l.loc_ou
    WHERE t.wave_loc_code   =	s.wms_wave_loc_code
    AND t.wave_no			=	s.wms_wave_no
    AND t.wave_ou			=	s.wms_wave_ou;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_WaveHeader
    (
        wave_loc_key,wave_loc_code, wave_no, wave_ou, wave_date, wave_status, wave_pln_start_date, wave_pln_end_date, wave_timestamp, wave_created_by, wave_created_date, wave_modified_by, wave_modified_date, wave_alloc_rule, wave_alloc_value, wave_alloc_uom, wave_no_of_pickers, wave_gen_flag, wave_staging_id, wave_replenish_flag, consolidated_flg, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        COALESCE(l.loc_key,-1),s.wms_wave_loc_code, s.wms_wave_no, s.wms_wave_ou, s.wms_wave_date, s.wms_wave_status, s.wms_wave_pln_start_date, s.wms_wave_pln_end_date, s.wms_wave_timestamp, s.wms_wave_created_by, s.wms_wave_created_date, s.wms_wave_modified_by, s.wms_wave_modified_date, s.wms_wave_alloc_rule, s.wms_wave_alloc_value, s.wms_wave_alloc_uom, s.wms_wave_no_of_pickers, s.wms_wave_gen_flag, s.wms_wave_staging_id, s.wms_wave_replenish_flag, s.wms_consolidated_flg, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_wms_wave_hdr s
    LEFT JOIN dwh.f_waveHeader t
    ON s.wms_wave_loc_code = t.wave_loc_code
    AND s.wms_wave_no = t.wave_no
    AND s.wms_wave_ou = t.wave_ou
	LEFT JOIN dwh.d_location l
	ON 	s.wms_wave_loc_code =	l.loc_code
	AND	s.wms_wave_ou       =	l.loc_ou
    WHERE t.wave_loc_code IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_wms_wave_hdr
    (
        wms_wave_loc_code, wms_wave_no, wms_wave_ou, wms_wave_date, wms_wave_status, wms_wave_pln_start_date, wms_wave_pln_end_date, wms_wave_timestamp, wms_wave_created_by, wms_wave_created_date, wms_wave_modified_by, wms_wave_modified_date, wms_wave_userdefined1, wms_wave_userdefined2, wms_wave_userdefined3, wms_wave_alloc_rule, wms_wave_alloc_value, wms_wave_alloc_uom, wms_wave_no_of_pickers, wms_wave_run_no, wms_wave_gen_flag, wms_wave_staging_id, wms_wave_replenish_flag, wms_consolidated_flg, etlcreateddatetime
    )
    SELECT
        wms_wave_loc_code, wms_wave_no, wms_wave_ou, wms_wave_date, wms_wave_status, wms_wave_pln_start_date, wms_wave_pln_end_date, wms_wave_timestamp, wms_wave_created_by, wms_wave_created_date, wms_wave_modified_by, wms_wave_modified_date, wms_wave_userdefined1, wms_wave_userdefined2, wms_wave_userdefined3, wms_wave_alloc_rule, wms_wave_alloc_value, wms_wave_alloc_uom, wms_wave_no_of_pickers, wms_wave_run_no, wms_wave_gen_flag, wms_wave_staging_id, wms_wave_replenish_flag, wms_consolidated_flg, etlcreateddatetime
    FROM stg.stg_wms_wave_hdr;
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