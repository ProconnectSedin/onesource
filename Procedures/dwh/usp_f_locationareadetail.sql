CREATE OR REPLACE PROCEDURE dwh.usp_f_locationareadetail(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
    FROM stg.stg_wms_loc_prop_hdr;

    UPDATE dwh.f_locationareadetail t
    SET
        loc_pop_loc_key             = COALESCE(l.loc_key,-1),
        loc_pop_length              = s.wms_loc_pop_length,
        loc_pop_breath              = s.wms_loc_pop_breath,
        loc_pop_uom                 = s.wms_loc_pop_uom,
        loc_pop_area_uom            = s.wms_loc_pop_area_uom,
        loc_pop_tot_area            = s.wms_loc_pop_tot_area,
        loc_pop_tot_stag_area       = s.wms_loc_pop_tot_stag_area,
        loc_pop_storg_area          = s.wms_loc_pop_storg_area,
        loc_pop_no_of_bins          = s.wms_loc_pop_no_of_bins,
        loc_pop_no_of_zones         = s.wms_loc_pop_no_of_zones,
        loc_other_area              = s.wms_loc_other_area,
        loc_office_area             = s.wms_loc_office_area,
        loc_outbound_area           = s.wms_loc_outbound_area,
        created_by                  = s.created_by,
        created_date                = s.created_date,
        modified_by                 = s.modified_by,
        modified_date               = s.modified_date,
        warehouse_loc_radio         = s.warehouse_loc_radio,
        etlactiveind                = 1,
        etljobname                  = p_etljobname,
        envsourcecd                 = p_envsourcecd,
        datasourcecd                = p_datasourcecd,
        etlupdatedatetime           = NOW()
    FROM stg.stg_wms_loc_prop_hdr s
	LEFT JOIN dwh.d_location l
		ON  s.wms_loc_pop_code		= l.loc_code
		AND s.wms_loc_pop_ou		= l.loc_ou
    WHERE   t.loc_pop_code 			= s.wms_loc_pop_code
		AND t.loc_pop_ou 			= s.wms_loc_pop_ou;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.f_locationareadetail
    (
        loc_pop_loc_key, loc_pop_code, loc_pop_ou, loc_pop_length, loc_pop_breath, loc_pop_uom, loc_pop_area_uom, loc_pop_tot_area, loc_pop_tot_stag_area, loc_pop_storg_area, loc_pop_no_of_bins, loc_pop_no_of_zones, loc_other_area, loc_office_area, loc_outbound_area, created_by, created_date, modified_by, modified_date, warehouse_loc_radio, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        COALESCE(l.loc_key,-1), s.wms_loc_pop_code, s.wms_loc_pop_ou, s.wms_loc_pop_length, s.wms_loc_pop_breath, s.wms_loc_pop_uom, s.wms_loc_pop_area_uom, s.wms_loc_pop_tot_area, s.wms_loc_pop_tot_stag_area, s.wms_loc_pop_storg_area, s.wms_loc_pop_no_of_bins, s.wms_loc_pop_no_of_zones, s.wms_loc_other_area, s.wms_loc_office_area, s.wms_loc_outbound_area, s.created_by, s.created_date, s.modified_by, s.modified_date, s.warehouse_loc_radio, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_wms_loc_prop_hdr s
	LEFT JOIN dwh.d_location l
		ON  s.wms_loc_pop_code 		= l.loc_code
		AND s.wms_loc_pop_ou 		= l.loc_ou	
    LEFT JOIN dwh.F_LocationAreaDetail t
		ON  s.wms_loc_pop_code 		= t.loc_pop_code
		AND s.wms_loc_pop_ou 		= t.loc_pop_ou
    WHERE   t.loc_pop_code IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_wms_loc_prop_hdr
    (
        wms_loc_pop_code, wms_loc_pop_ou, wms_loc_pop_length, wms_loc_pop_breath, wms_loc_pop_uom, wms_loc_pop_area_uom, wms_loc_pop_tot_area, wms_loc_pop_tot_stag_area, wms_loc_pop_storg_area, wms_loc_pop_no_of_bins, wms_loc_pop_no_of_zones, wms_loc_other_area, wms_loc_office_area, wms_loc_outbound_area, created_by, created_date, modified_by, modified_date, warehouse_loc_radio, etlcreateddatetime
    )
    SELECT
        wms_loc_pop_code, wms_loc_pop_ou, wms_loc_pop_length, wms_loc_pop_breath, wms_loc_pop_uom, wms_loc_pop_area_uom, wms_loc_pop_tot_area, wms_loc_pop_tot_stag_area, wms_loc_pop_storg_area, wms_loc_pop_no_of_bins, wms_loc_pop_no_of_zones, wms_loc_other_area, wms_loc_office_area, wms_loc_outbound_area, created_by, created_date, modified_by, modified_date, warehouse_loc_radio, etlcreateddatetime
    FROM stg.stg_wms_loc_prop_hdr;
    
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