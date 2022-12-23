CREATE PROCEDURE dwh.usp_f_packstoragedetail(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
    FROM stg.stg_wms_pack_storage_dtl;

    UPDATE dwh.F_PackStorageDetail t
    SET
		pack_storage_dtl_loc_key = COALESCE(l.loc_key,-1),
        pack_storage_zone        = s.wms_pack_storage_zone,
        pack_pack_zone           = s.wms_pack_pack_zone,
        etlactiveind             = 1,
        etljobname               = p_etljobname,
        envsourcecd              = p_envsourcecd,
        datasourcecd             = p_datasourcecd,
        etlupdatedatetime        = NOW()
    FROM stg.stg_wms_pack_storage_dtl s
	LEFT JOIN dwh.d_location l 		
		ON  s.wms_pack_location 	 = l.loc_code 
        AND s.wms_pack_ou            = l.loc_ou
    WHERE 	t.pack_location 	= s.wms_pack_location
    AND 	t.pack_ou 			= s.wms_pack_ou
    AND 	t.pack_lineno 		= s.wms_pack_lineno;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_PackStorageDetail
    (
		pack_storage_dtl_loc_key,
        pack_location, 		pack_ou, 		pack_lineno, 	pack_storage_zone, 	pack_pack_zone, 
		etlactiveind, 		etljobname, 	envsourcecd, 	datasourcecd, 		etlcreatedatetime
    )

    SELECT
		COALESCE(l.loc_key,-1),
        s.wms_pack_location, 	s.wms_pack_ou, 		s.wms_pack_lineno, 		s.wms_pack_storage_zone, 	s.wms_pack_pack_zone, 
		1, p_etljobname, 		p_envsourcecd, 		p_datasourcecd, 		NOW()
    FROM stg.stg_wms_pack_storage_dtl s
	LEFT JOIN dwh.d_location l 		
		ON  s.wms_pack_location 	 = l.loc_code 
        AND s.wms_pack_ou            = l.loc_ou
    LEFT JOIN dwh.F_PackStorageDetail t
    ON 	s.wms_pack_location = t.pack_location
    AND s.wms_pack_ou 		= t.pack_ou
    AND s.wms_pack_lineno 	= t.pack_lineno
    WHERE t.pack_location IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_wms_pack_storage_dtl
    (
        wms_pack_location, 		wms_pack_ou, 		 wms_pack_lineno, 		wms_pack_storage_zone, 	wms_pack_pack_zone, 
		wms_pack_service_type, 	wms_pack_order_type, etlcreateddatetime
    )
    SELECT
        wms_pack_location, 		wms_pack_ou, 		 wms_pack_lineno, 	    wms_pack_storage_zone,  wms_pack_pack_zone, 
		wms_pack_service_type, 	wms_pack_order_type, etlcreateddatetime
    FROM stg.stg_wms_pack_storage_dtl;
    
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