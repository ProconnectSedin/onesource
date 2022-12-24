CREATE OR REPLACE PROCEDURE dwh.usp_d_gateemployeemapping(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
	FROM stg.stg_wms_gate_emp_equip_map_dtl;

	UPDATE dwh.d_gateemployeemapping t
    SET 
		gate_shift_code         = s.wms_gate_shift_code   ,
		gate_emp_code           = s.wms_gate_emp_code     ,
		gate_area               = s.wms_gate_area         ,
		gate_timestamp          = s.wms_gate_timestamp    ,
		gate_created_by         = s.wms_gate_created_by   ,
		gate_created_date       = s.wms_gate_created_date ,
		gate_modified_by        = s.wms_gate_modified_by  ,
		etlactiveind 			= 1,
		etljobname 				= p_etljobname,
		envsourcecd 			= p_envsourcecd ,
		datasourcecd 			= p_datasourcecd ,
		etlupdatedatetime 		= NOW()	
    FROM stg.stg_wms_gate_emp_equip_map_dtl s
    WHERE t.gate_loc_code  		= s.wms_gate_loc_code
	AND t.gate_ou 			    = s.wms_gate_ou
	AND t.gate_lineno 			= s.wms_gate_lineno;
	
    
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

	INSERT INTO dwh.d_gateemployeemapping
	(
		gate_loc_code,              gate_ou,                gate_lineno,
        gate_shift_code,            gate_emp_code,          gate_area,
        gate_timestamp,             gate_created_by,        gate_created_date,
        gate_modified_by,           etlactiveind,           etljobname, 		
        envsourcecd, 	            datasourcecd, 			etlcreatedatetime
	)
	
    SELECT 
		s.wms_gate_loc_code,              s.wms_gate_ou,                s.wms_gate_lineno,
        s.wms_gate_shift_code,            s.wms_gate_emp_code,          s.wms_gate_area,
        s.wms_gate_timestamp,             s.wms_gate_created_by,        s.wms_gate_created_date,
        s.wms_gate_modified_by,           1,                            p_etljobname,		
        p_envsourcecd,		              p_datasourcecd,			    NOW()
	FROM stg.stg_wms_gate_emp_equip_map_dtl s
    LEFT JOIN dwh.d_gateemployeemapping t
    ON 	t.gate_loc_code  		= s.wms_gate_loc_code
	AND t.gate_ou 			    = s.wms_gate_ou
	AND t.gate_lineno 			= s.wms_gate_lineno 
    WHERE t.gate_loc_code IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
	IF p_rawstorageflag = 1
	THEN

	
	INSERT INTO raw.raw_wms_gate_emp_equip_map_dtl
	(
		wms_gate_loc_code, wms_gate_ou, wms_gate_lineno, wms_gate_shift_code, wms_gate_emp_code,
        wms_gate_euip_code, wms_gate_area, wms_gate_timestamp, wms_gate_created_by, wms_gate_created_date, 
        wms_gate_modified_by, wms_gate_modified_date, etlcreateddatetime

     )
	SELECT 
		wms_gate_loc_code, wms_gate_ou, wms_gate_lineno, wms_gate_shift_code, wms_gate_emp_code,
        wms_gate_euip_code, wms_gate_area, wms_gate_timestamp, wms_gate_created_by, wms_gate_created_date, 
        wms_gate_modified_by, wms_gate_modified_date, etlcreateddatetime
	FROM stg.stg_wms_gate_emp_equip_map_dtl;
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