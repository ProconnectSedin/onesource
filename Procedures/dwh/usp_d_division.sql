CREATE OR REPLACE PROCEDURE dwh.usp_d_division(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
BEGIN

    SELECT d.jobname,h.envsourcecode,h.datasourcecode,d.latestbatchid,d.targetprocedurename 
    INTO p_etljobname,p_envsourcecd,p_datasourcecd,p_batchid,p_taskname
    FROM ods.controldetail d 
    INNER JOIN ods.controlheader h
        ON d.sourceid = h.sourceid
    WHERE   d.sourceid      = p_sourceId 
        AND d.dataflowflag  = p_dataflowflag
        AND d.targetobject  = p_targetobject;
        
    SELECT COUNT(1) INTO srccnt
    FROM stg.stg_wms_div_division_hdr;

    UPDATE dwh.d_division t
    SET 
        div_desc   =   s.wms_div_desc, 
        div_status   =   s.wms_div_status, 
        div_type   =   s.wms_div_type, 
        div_reason_code   =   s.wms_div_reason_code, 
        div_user_def1   =   s.wms_div_user_def1, 
        div_user_def2   =   s.wms_div_user_def2, 
        div_user_def3   =   s.wms_div_user_def3, 
        div_timestamp   =   s.wms_div_timestamp, 
        div_created_by   =   s.wms_div_created_by, 
        div_created_dt   =   s.wms_div_created_dt, 
        div_modified_by   =   s.wms_div_modified_by, 
        div_modified_dt   =   s.wms_div_modified_dt, 
        etlactiveind           =     1,
        etljobname             =     p_etljobname,
        envsourcecd            =     p_envsourcecd,
        datasourcecd           =     p_datasourcecd,
        etlupdatedatetime      =     NOW()  
    FROM stg.stg_wms_div_division_hdr s
    WHERE t.div_code   =   s.wms_div_code
    AND  t.div_ou   =   s.wms_div_ou;
        
    
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.d_division
    (div_ou,div_code,div_desc,div_status,div_type,div_reason_code,div_user_def1,div_user_def2,div_user_def3,div_timestamp,div_created_by,div_created_dt,div_modified_by,div_modified_dt, etlactiveind,
        etljobname,         envsourcecd,    datasourcecd,       etlcreatedatetime
    )
    
    SELECT 
       s.wms_div_ou, s.wms_div_code, s.wms_div_desc, s.wms_div_status, s.wms_div_type, s.wms_div_reason_code, s.wms_div_user_def1, s.wms_div_user_def2, s.wms_div_user_def3, s.wms_div_timestamp, s.wms_div_created_by, s.wms_div_created_dt, s.wms_div_modified_by, 
       s.wms_div_modified_dt,
        1,      p_etljobname,       p_envsourcecd,      p_datasourcecd,         now()
    FROM stg.stg_wms_div_division_hdr s
    LEFT JOIN dwh.d_division t
    ON    s.wms_div_code = t.div_code 
    AND      s.wms_div_ou= t.div_ou 
        
    WHERE t.div_code   IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
    INSERT INTO raw.raw_wms_div_division_hdr

    (
     wms_div_ou, wms_div_code, wms_div_desc, wms_div_status, wms_div_type, wms_div_reason_code, 
     wms_div_user_def1, wms_div_user_def2, wms_div_user_def3, wms_div_timestamp, wms_div_created_by, 
     wms_div_created_dt, wms_div_modified_by, wms_div_modified_dt, etlcreateddatetime
    )
    SELECT
     wms_div_ou, wms_div_code, wms_div_desc, wms_div_status, wms_div_type, wms_div_reason_code, 
     wms_div_user_def1, wms_div_user_def2, wms_div_user_def3, wms_div_timestamp, wms_div_created_by, 
     wms_div_created_dt, wms_div_modified_by, wms_div_modified_dt, etlcreateddatetime
    FROM stg.stg_wms_div_division_hdr;
	
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
    
    --SELECT COUNT(*) INTO InsCnt FROM dwh.usp_d_division;
END;
$$;