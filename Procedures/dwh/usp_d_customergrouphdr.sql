CREATE PROCEDURE dwh.usp_d_customergrouphdr(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
	FROM stg.stg_cust_group_hdr;

	UPDATE dwh.d_CustomerGroupHdr t
    SET 
                   
        cgh_bu                 =     s.cgh_bu ,                         
        cgh_created_at         =     s.cgh_created_at,  
        cgh_cust_group_desc    =     s.cgh_cust_group_desc,
        cgh_reason_code        =     s.cgh_reason_code ,
        cgh_status             =     s.cgh_status ,
        cgh_prev_status        =     s.cgh_prev_status ,
        cgh_created_by         =     s.cgh_created_by ,
        cgh_created_date       =     s.cgh_created_date, 
        cgh_modified_by        =     s.cgh_modified_by ,
        cgh_modified_date      =     s.cgh_modified_date,  
        cgh_timestamp_value    =     s.cgh_timestamp_value,
		etlactiveind 		   =     1,
		etljobname 			   =     p_etljobname,
		envsourcecd 		   =     p_envsourcecd,
		datasourcecd 		   =     p_datasourcecd,
		etlupdatedatetime 	   =     NOW()	
    FROM stg.stg_cust_group_hdr s
    WHERE t.cgh_cust_group_code    = s.cgh_cust_group_code
    AND   t.cgh_group_type_code    = s.cgh_group_type_code
    AND   t.cgh_control_group_flag = s.cgh_control_group_flag
    AND   t.cgh_lo= s.cgh_lo;
    
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

	INSERT INTO dwh.d_CustomerGroupHdr
	(
		cgh_lo ,              cgh_bu ,              cgh_cust_group_code,  cgh_control_group_flag, cgh_group_type_code,  cgh_created_at ,      
        cgh_cust_group_desc,  cgh_cust_group_desc_shd, cgh_reason_code ,     cgh_status,           cgh_prev_status,      cgh_created_by ,      
        cgh_created_date,     cgh_modified_by,     cgh_modified_date,    cgh_timestamp_value,  etlactiveind,
        etljobname, 		envsourcecd, 	datasourcecd, 		etlcreatedatetime
	)
	
    SELECT 
    s.cgh_lo ,             s.cgh_bu ,            s.cgh_cust_group_code, s.cgh_control_group_flag, s.cgh_group_type_code, 
    s.cgh_created_at,      s.cgh_cust_group_desc,  s.cgh_cust_group_desc_shd, s.cgh_reason_code ,     s.cgh_status,      
    s.cgh_prev_status,     s.cgh_created_by ,      s.cgh_created_date,    s.cgh_modified_by,    s.cgh_modified_date,   s.cgh_timestamp_value,
		1,      p_etljobname,		p_envsourcecd,		p_datasourcecd,			now()
	FROM stg.stg_cust_group_hdr s
    LEFT JOIN dwh.d_CustomerGroupHdr t
    ON s.cgh_cust_group_code = t.cgh_cust_group_code
    AND   s.cgh_group_type_code    = t.cgh_group_type_code
    AND   s.cgh_control_group_flag = t.cgh_control_group_flag 
    AND   s.cgh_lo= t.cgh_lo
    WHERE t.cgh_cust_group_code IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
	IF p_rawstorageflag = 1
	THEN

	INSERT INTO raw.raw_cust_group_hdr
	(
	cgh_lo, cgh_bu, cgh_cust_group_code, cgh_control_group_flag, cgh_group_type_code,
    cgh_created_at, cgh_cust_group_desc, cgh_cust_group_desc_shd, cgh_reason_code, cgh_status,
    cgh_prev_status, cgh_created_by, cgh_created_date, cgh_modified_by, cgh_modified_date, 
    cgh_timestamp_value, cgh_addnl1, cgh_addnl2, cgh_addnl3, etlcreateddatetime

	)
	SELECT 
	cgh_lo, cgh_bu, cgh_cust_group_code, cgh_control_group_flag, cgh_group_type_code,
    cgh_created_at, cgh_cust_group_desc, cgh_cust_group_desc_shd, cgh_reason_code, cgh_status,
    cgh_prev_status, cgh_created_by, cgh_created_date, cgh_modified_by, cgh_modified_date, 
    cgh_timestamp_value, cgh_addnl1, cgh_addnl2, cgh_addnl3, etlcreateddatetime	
	FROM stg.stg_cust_group_hdr;
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