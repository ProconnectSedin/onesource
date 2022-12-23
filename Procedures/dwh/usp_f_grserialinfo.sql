CREATE PROCEDURE dwh.usp_f_grserialinfo(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
    FROM stg.stg_wms_gr_exec_serial_dtl;

    UPDATE dwh.F_GRSerialinfo t
    SET
		gr_loc_key			= COALESCE(l.loc_key,-1),
        gr_po_no			= s.wms_gr_po_no,
        gr_po_sno			= s.wms_gr_po_sno,
        gr_item				= s.wms_gr_item,
        gr_status			= s.wms_gr_status,
        gr_cust_sno			= s.wms_gr_cust_sno,
        gr_3pl_sno			= s.wms_gr_3pl_sno,
        gr_lot_no			= s.wms_gr_lot_no,
        gr_item_lineno		= s.wms_gr_item_lineno,
        etlactiveind		= 1,
        etljobname			= p_etljobname,
        envsourcecd			= p_envsourcecd ,
        datasourcecd		= p_datasourcecd ,
        etlupdatedatetime	= NOW()    
    FROM stg.stg_wms_gr_exec_serial_dtl s
	LEFT JOIN dwh.d_location	l
	ON	s.wms_gr_loc_code	= l.loc_code
	AND	s.wms_gr_exec_ou	= l.loc_ou
	WHERE t.gr_loc_code		= s.wms_gr_loc_code
    AND t.gr_exec_no		= s.wms_gr_exec_no
    AND t.gr_exec_ou		= s.wms_gr_exec_ou
    AND t.gr_lineno			= s.wms_gr_lineno
    AND t.gr_serial_no		= s.wms_gr_serial_no;
	 
    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_GRSerialinfo 
    (
        gr_loc_key			, gr_loc_code		, gr_exec_no			,
		gr_exec_ou			, gr_lineno			, gr_po_no				,
		gr_po_sno			, gr_item			, gr_serial_no			, 
		gr_status			, gr_cust_sno		, gr_3pl_sno			,
		gr_lot_no			, gr_item_lineno	,
		etlactiveind		, etljobname		, envsourcecd			,
		datasourcecd		, etlcreatedatetime
    )
     
    SELECT
        COALESCE(l.loc_key,-1), s.wms_gr_loc_code	, s.wms_gr_exec_no		,
		s.wms_gr_exec_ou	, s.wms_gr_lineno		, s.wms_gr_po_no		,
		s.wms_gr_po_sno		, s.wms_gr_item			, s.wms_gr_serial_no	,
		s.wms_gr_status		, s.wms_gr_cust_sno		, s.wms_gr_3pl_sno		,
		s.wms_gr_lot_no		, s.wms_gr_item_lineno	,
				1			, 	p_etljobname		, p_envsourcecd			,
		p_datasourcecd		, NOW()
    FROM stg.stg_wms_gr_exec_serial_dtl s
	LEFT JOIN dwh.d_location l
	ON 	s.wms_gr_loc_code	= l.loc_code
	AND	s.wms_gr_exec_ou	= l.loc_ou
    LEFT JOIN dwh.F_GRSerialinfo t
    ON	s.wms_gr_loc_code	= t.gr_loc_code
    AND s.wms_gr_exec_no	= t.gr_exec_no
    AND s.wms_gr_exec_ou	= t.gr_exec_ou
    AND s.wms_gr_lineno		= t.gr_lineno
    AND s.wms_gr_serial_no	= t.gr_serial_no
	WHERE t.gr_loc_code IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN
    
    INSERT INTO raw.raw_wms_gr_exec_serial_dtl
    (   
        wms_gr_loc_code			, wms_gr_exec_no			, wms_gr_exec_ou			,
		wms_gr_lineno			, wms_gr_po_no				, wms_gr_po_sno				,
		wms_gr_item				, wms_gr_serial_no			, wms_gr_status				,
		wms_gr_cust_sno			, wms_gr_3pl_sno			, wms_gr_lot_no				,
		wms_gr_item_lineno		, wms_gr_warranty_sno
    )
    SELECT 
		wms_gr_loc_code			, wms_gr_exec_no			, wms_gr_exec_ou			,
		wms_gr_lineno			, wms_gr_po_no				, wms_gr_po_sno				,
		wms_gr_item				, wms_gr_serial_no			, wms_gr_status				,
		wms_gr_cust_sno			, wms_gr_3pl_sno			, wms_gr_lot_no				,
		wms_gr_item_lineno		, wms_gr_warranty_sno
	FROM stg.stg_wms_gr_exec_serial_dtl;
    END IF;   

    EXCEPTION WHEN others THEN
    GET stacked DIAGNOSTICS p_errorid = returned_sqlstate, p_errordesc = message_text;
    CALL ods.usp_etlerrorinsert(p_sourceid, p_targetobject, p_dataflowflag, p_batchid,p_taskname, 'sp_ExceptionHandling', p_errorid, p_errordesc, null);
    SELECT 0 INTO inscnt;
    SELECT 0 INTO updcnt;	
	
END;
$$;