CREATE PROCEDURE dwh.usp_f_divisionareadetail(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
    FROM stg.stg_wms_div_prop_hdr;

    UPDATE dwh.F_DivisionAreaDetail t
    SET
        div_key                  = COALESCE(d.div_key,-1),
        div_length               = s.wms_div_length,
        div_breath               = s.wms_div_breath,
        div_height               = s.wms_div_height,
        div_uom                  = s.wms_div_uom,
        div_area_uom             = s.wms_div_area_uom,
        div_tot_area             = s.wms_div_tot_area,
        div_tot_stag_area        = s.wms_div_tot_stag_area,
        div_storg_area           = s.wms_div_storg_area,
        div_tot_docks            = s.wms_div_tot_docks,
        div_other_area           = s.wms_div_other_area,
        div_office_area          = s.wms_div_office_area,
        div_outbound_area        = s.wms_div_outbound_area,
        etlactiveind             = 1,
        etljobname               = p_etljobname,
        envsourcecd              = p_envsourcecd,
        datasourcecd             = p_datasourcecd,
        etlupdatedatetime        = NOW()
    FROM stg.stg_wms_div_prop_hdr s
	LEFT JOIN dwh.d_division d
		ON  s.wms_div_code		= d.div_code
		AND s.wms_div_ou		= d.div_ou 
    WHERE   t.div_code			= s.wms_div_code
		AND t.div_ou			= s.wms_div_ou;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_DivisionAreaDetail
    (
        div_key, div_code, div_ou, div_length, div_breath, div_height, div_uom, div_area_uom, div_tot_area, div_tot_stag_area, div_storg_area, div_tot_docks, div_other_area, div_office_area, div_outbound_area, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        COALESCE(d.div_key,-1), s.wms_div_code, s.wms_div_ou, s.wms_div_length, s.wms_div_breath, s.wms_div_height, s.wms_div_uom, s.wms_div_area_uom, s.wms_div_tot_area, s.wms_div_tot_stag_area, s.wms_div_storg_area, s.wms_div_tot_docks, s.wms_div_other_area, s.wms_div_office_area, s.wms_div_outbound_area, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_wms_div_prop_hdr s
	LEFT JOIN dwh.d_division d
		ON  s.wms_div_code		= d.div_code
		AND s.wms_div_ou		= d.div_ou
    LEFT JOIN dwh.F_DivisionAreaDetail t
		ON  s.wms_div_code		= t.div_code
		AND s.wms_div_ou		= t.div_ou
    WHERE t.div_code IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_wms_div_prop_hdr
    (
        wms_div_code, wms_div_ou, wms_div_length, wms_div_breath, wms_div_height, wms_div_uom, wms_div_area_uom, wms_div_tot_area, wms_div_tot_stag_area, wms_div_storg_area, wms_div_tot_docks, wms_div_other_area, wms_div_office_area, wms_div_outbound_area, etlcreateddatetime
    )
    SELECT
        wms_div_code, wms_div_ou, wms_div_length, wms_div_breath, wms_div_height, wms_div_uom, wms_div_area_uom, wms_div_tot_area, wms_div_tot_stag_area, wms_div_storg_area, wms_div_tot_docks, wms_div_other_area, wms_div_office_area, wms_div_outbound_area, etlcreateddatetime
    FROM stg.stg_wms_div_prop_hdr;
    
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