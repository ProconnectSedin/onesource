CREATE PROCEDURE dwh.usp_d_thuitemmap(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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

	SELECT d.jobname,h.envsourcecode,h.datasourcecode,d.latestbatchid,d.targetprocedurename,h.rawstorageflag

	INTO p_etljobname,p_envsourcecd,p_datasourcecd,p_batchid,p_taskname,p_rawstorageflag
  
	FROM ods.controldetail d 
	INNER JOIN ods.controlheader h
		ON d.sourceid = h.sourceid
	WHERE 	d.sourceid 		= p_sourceId 
		AND d.dataflowflag 	= p_dataflowflag
		AND d.targetobject 	= p_targetobject;

    SELECT COUNT(1) INTO srccnt
	FROM stg.stg_wms_thu_item_mapping_dtl;  -- change staging table

	UPDATE dwh.D_ThuItemMap t  --Change variables and table name
    SET -- logical column name = s.column name
		
		thu_qty					= s.wms_thu_qty, 
		thu_created_by			= s.wms_thu_created_by, 
		thu_created_date		= s.wms_thu_created_date, 
		thu_ser_no				= s.wms_thu_ser_no, 	
		etlactiveind 			= 1,
		etljobname 				= p_etljobname,
		envsourcecd 			= p_envsourcecd ,
		datasourcecd 			= p_datasourcecd ,
		etlupdatedatetime 		= NOW()	
    FROM stg.stg_wms_thu_item_mapping_dtl s		--staging table name in sheet
    WHERE t.thu_loc_code			= s.wms_thu_loc_code
	AND t.thu_ou					= s.wms_thu_ou
	AND t.thu_serial_no				= s.wms_thu_serial_no
	AND t.thu_id					= s.wms_thu_id
	AND t.thu_item					= s.wms_thu_item
	AND t.thu_lot_no				= s.wms_thu_lot_no
	AND t.thu_itm_serial_no			= s.wms_thu_itm_serial_no;
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

	INSERT INTO dwh.D_ThuItemMap -- table name
	(-- logical column names except last 5
		thu_loc_code, 		thu_ou, 				thu_serial_no, 		thu_id, 			thu_item, 		
		thu_lot_no, 		thu_itm_serial_no,		thu_qty, 			thu_created_by, 	thu_created_date, 		thu_ser_no, 			
		etlactiveind,   	etljobname, 			envsourcecd,		datasourcecd, 		etlcreatedatetime
	)
	
    SELECT  -- normal column name except last 5
		wms_thu_loc_code, 	wms_thu_ou, 			wms_thu_serial_no,	wms_thu_id, 		wms_thu_item,
		wms_thu_lot_no, 	wms_thu_itm_serial_no, 	wms_thu_qty, 		wms_thu_created_by, wms_thu_created_date, 	wms_thu_ser_no, 		 			
		1,					p_etljobname,			p_envsourcecd,		p_datasourcecd,		NOW()
	FROM stg.stg_wms_thu_item_mapping_dtl s -- staging table name
    LEFT JOIN dwh.D_ThuItemMap t -- table name
    ON 	s.wms_thu_loc_code				= t.thu_loc_code
		AND s.wms_thu_ou				= t.thu_ou							
		AND s.wms_thu_serial_no			= t.thu_serial_no
		AND s.wms_thu_id				= t.thu_id							
		AND s.wms_thu_item				= t.thu_item					
		AND s.wms_thu_lot_no			= t.thu_lot_no			
		AND s.wms_thu_itm_serial_no		= t.thu_itm_seriaL_no
    WHERE t.thu_loc_code IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
	IF p_rawstorageflag = 1
	THEN

	
	INSERT INTO raw.raw_wms_thu_item_mapping_dtl --  staging table name
	(
		wms_thu_loc_code, wms_thu_ou, wms_thu_serial_no, wms_thu_id, wms_thu_item, wms_thu_lot_no, 
        wms_thu_itm_serial_no, wms_thu_qty, wms_thu_created_by, wms_thu_created_date, wms_thu_modified_by, 
        wms_thu_modified_date, wms_thu_ser_no, wms_thu_serial_no2, etlcreateddatetime

	
	)
	SELECT 
		wms_thu_loc_code, wms_thu_ou, wms_thu_serial_no, wms_thu_id, wms_thu_item, wms_thu_lot_no, 
        wms_thu_itm_serial_no, wms_thu_qty, wms_thu_created_by, wms_thu_created_date, wms_thu_modified_by, 
        wms_thu_modified_date, wms_thu_ser_no, wms_thu_serial_no2, etlcreateddatetime

	FROM stg.stg_wms_thu_item_mapping_dtl;
	END IF;
	EXCEPTION  
       WHEN others THEN       
       
      get stacked diagnostics
        p_errorid   = returned_sqlstate,
        p_errordesc = message_text;
        
    CALL ods.usp_etlerrorinsert(p_sourceid,p_targetobject,p_dataflowflag,
                                p_batchid,p_taskname,'sp_ExceptionHandling',
                                p_errorid,p_errordesc,null);
								
		select 0 into inscnt;
       select 0 into updcnt;
END;
$$;