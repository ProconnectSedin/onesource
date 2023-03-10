CREATE OR REPLACE PROCEDURE dwh.usp_d_itemsuppliermap(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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

    SELECT COUNT(1) INTO srccnt FROM stg.stg_wms_item_supplier_dtl;

	UPDATE dwh.D_ItemSupplierMap t
    SET 
		itm_supp_code  		=      s.wms_itm_supp_code,
		item_source	   		=      s.wms_item_source,
		etlactiveind 		= 	   1,
		etljobname 			= 	   p_etljobname,
		envsourcecd 		= 	   p_envsourcecd ,
		datasourcecd 		= 	   p_datasourcecd ,
		etlupdatedatetime 	= 	   NOW()
		
    FROM stg.stg_wms_item_supplier_dtl s
    WHERE t.itm_ou  	= 	   s.wms_itm_ou
	and t.itm_code		=	   s.wms_itm_code
	and t.itm_lineno	=	   s.wms_itm_lineno;
    
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

	INSERT INTO dwh.D_ItemSupplierMap
	(
		itm_ou, 			itm_code, 				itm_lineno, 			itm_supp_code, 
		item_source, 		etlactiveind, 			etljobname, 			envsourcecd, 
		datasourcecd, 		etlcreatedatetime
	)
	
    SELECT 
		s.wms_itm_ou, 			s.wms_itm_code, 				s.wms_itm_lineno, 			s.wms_itm_supp_code, 
		s.wms_item_source, 		1, 								p_etljobname, 				p_envsourcecd, 
		p_datasourcecd, 		now()
	FROM stg.stg_wms_item_supplier_dtl s
    LEFT JOIN dwh.D_ItemSupplierMap t
    ON 	s.wms_itm_ou  		= 	t.itm_ou
	and s.wms_itm_code      =   t.itm_code
	and s.wms_itm_lineno	= 	t.itm_lineno
    WHERE t.itm_ou IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
	IF p_rawstorageflag = 1
	THEN

	
	INSERT INTO raw.raw_wms_item_supplier_dtl
	(
		wms_itm_ou, wms_itm_code, wms_itm_lineno, 
        wms_itm_supp_code, wms_item_source, etlcreateddatetime
	)
	SELECT 
		 wms_itm_ou, wms_itm_code, wms_itm_lineno, 
        wms_itm_supp_code, wms_item_source, etlcreateddatetime
	FROM stg.stg_wms_item_supplier_dtl;	
	
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