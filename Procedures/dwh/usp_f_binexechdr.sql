-- PROCEDURE: dwh.usp_f_binexechdr(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_binexechdr(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_binexechdr(
	IN p_sourceid character varying,
	IN p_dataflowflag character varying,
	IN p_targetobject character varying,
	OUT srccnt integer,
	OUT inscnt integer,
	OUT updcnt integer,
	OUT dltcount integer,
	INOUT flag1 character varying,
	OUT flag2 character varying)
LANGUAGE 'plpgsql'
AS $BODY$
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

	SELECT d.jobname,h.envsourcecode,h.datasourcecode,d.latestbatchid,d.targetprocedurename, h.rawstorageflag
	INTO p_etljobname, p_envsourcecd, p_datasourcecd, p_batchid, p_taskname, p_rawstorageflag
	FROM ods.controldetail d 
	INNER JOIN ods.controlheader h
		ON d.sourceid = h.sourceid
	WHERE 	d.sourceid 		= p_sourceId 
		AND d.dataflowflag 	= p_dataflowflag
		AND d.targetobject 	= p_targetobject;

    SELECT COUNT(1) INTO srccnt
	FROM stg.stg_wms_bin_exec_hdr;

	UPDATE dwh.f_binexechdr t
    SET 
          bin_loc_key           		= COALESCE(l.loc_key,-1)
        , bin_date_key          		= COALESCE(d.datekey,-1)
        , bin_emp_hdr_key       		= COALESCE(e.emp_hdr_key,-1)
		, bin_exec_status 				= s.wms_bin_exec_status
		, bin_exec_date 				= s.wms_bin_exec_date
		, bin_pln_no 					= s.wms_bin_pln_no
		, bin_mhe_id 					= s.wms_bin_mhe_id
		, bin_employee_id 				= s.wms_bin_employee_id
		, bin_exec_start_date 			= s.wms_bin_exec_start_date
		, bin_exec_end_date 			= s.wms_bin_exec_end_date
		, bin_created_by 				= s.wms_bin_created_by
		, bin_created_date 				= s.wms_bin_created_date
		, bin_modified_by 				= s.wms_bin_modified_by
		, bin_modified_date 			= s.wms_bin_modified_date
		, bin_timestamp 				= s.wms_bin_timestamp
		, bin_refdoc_no 				= s.wms_bin_refdoc_no
		, bin_gen_from 					= s.wms_bin_gen_from
		, bin_fr_insp 					= s.wms_bin_fr_insp
		, etlactiveind 					= 1
		, etljobname 					= p_etljobname
		, envsourcecd 					= p_envsourcecd
		, datasourcecd 					= p_datasourcecd
		, etlupdatedatetime 			= NOW()	
    FROM stg.stg_wms_bin_exec_hdr s
	LEFT JOIN dwh.d_location L 		
		ON  s.wms_bin_loc_code 			= L.loc_code 
        AND s.wms_bin_exec_ou        	= L.loc_ou
	LEFT JOIN dwh.d_date D 			
		ON  s.wms_bin_exec_date::date 	= D.dateactual
	LEFT JOIN dwh.d_employeeheader e		
		ON  s.wms_bin_employee_id  		= e.emp_employee_code 
        AND s.wms_bin_exec_ou        	= e.emp_ou	
    WHERE   t.bin_loc_code 				= s.wms_bin_loc_code
		AND t.bin_exec_no 				= s.wms_bin_exec_no
		AND t.bin_exec_ou 				= s.wms_bin_exec_ou;
    
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

	INSERT INTO dwh.f_binexechdr
	(
		bin_loc_key				, bin_date_key				, bin_emp_hdr_key				, bin_loc_code, 
		bin_exec_no				, bin_exec_ou				, bin_exec_status				, bin_exec_date				, bin_pln_no, 
		bin_mhe_id				, bin_employee_id			, bin_exec_start_date			, bin_exec_end_date			, bin_created_by, 
		bin_created_date		, bin_modified_by			, bin_modified_date				, bin_timestamp				, bin_refdoc_no, 
		bin_gen_from			, bin_fr_insp				, etlactiveind					, etljobname				, envsourcecd, 
		datasourcecd			, etlcreatedatetime
	)
	
	SELECT 
	   	COALESCE(l.loc_key,-1)	, COALESCE(d.datekey,-1)	, COALESCE(e.emp_hdr_key,-1)	, s.wms_bin_loc_code, 
		s.wms_bin_exec_no		, s.wms_bin_exec_ou			, s.wms_bin_exec_status			, s.wms_bin_exec_date		, s.wms_bin_pln_no, 
		s.wms_bin_mhe_id		, s.wms_bin_employee_id		, s.wms_bin_exec_start_date		, s.wms_bin_exec_end_date	, s.wms_bin_created_by, 
		s.wms_bin_created_date	, s.wms_bin_modified_by		, s.wms_bin_modified_date		, s.wms_bin_timestamp		, s.wms_bin_refdoc_no, 
		s.wms_bin_gen_from		, s.wms_bin_fr_insp			, 1 AS etlactiveind				, p_etljobname				, p_envsourcecd, 
		p_datasourcecd			, NOW()
	FROM stg.stg_wms_bin_exec_hdr s
	LEFT JOIN dwh.d_location L 		
		ON  s.wms_bin_loc_code 			= L.loc_code 
        AND s.wms_bin_exec_ou        	= L.loc_ou
	LEFT JOIN dwh.d_date D 			
		ON  s.wms_bin_exec_date::date 	= D.dateactual
	LEFT JOIN dwh.d_employeeheader e		
		ON  s.wms_bin_employee_id  		= e.emp_employee_code 
        AND s.wms_bin_exec_ou        	= e.emp_ou
	LEFT JOIN dwh.f_binexechdr fh 	
		ON  fh.bin_loc_code 			= s.wms_bin_loc_code
		AND fh.bin_exec_no 				= s.wms_bin_exec_no
		AND fh.bin_exec_ou 				= s.wms_bin_exec_ou
    WHERE fh.bin_loc_code IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN
	
	INSERT INTO raw.raw_wms_bin_exec_hdr
	(
		wms_bin_loc_code		, wms_bin_exec_no		, wms_bin_exec_ou				, wms_bin_exec_status			, wms_bin_exec_date, 
		wms_bin_pln_no			, wms_bin_mhe_id		, wms_bin_employee_id			, wms_bin_exec_start_date		, wms_bin_exec_end_date, 
		wms_bin_created_by		, wms_bin_created_date	, wms_bin_modified_by			, wms_bin_modified_date			, wms_bin_timestamp, 
		wms_bin_userdefined1	, wms_bin_userdefined2	, wms_bin_userdefined3			, wms_bin_refdoc_no				, wms_bin_billing_status, 
		wms_bin_bill_value		, wms_bin_gen_from		, wms_bin_inthumov_bil_status	, wms_bin_lbchprhr_bil_status	, wms_bin_fr_insp, 
		wms_bin_source_docno	, wms_bin_source_stage	, etlcreateddatetime
	
	)
	SELECT 
		wms_bin_loc_code		, wms_bin_exec_no		, wms_bin_exec_ou				, wms_bin_exec_status			, wms_bin_exec_date, 
		wms_bin_pln_no			, wms_bin_mhe_id		, wms_bin_employee_id			, wms_bin_exec_start_date		, wms_bin_exec_end_date, 
		wms_bin_created_by		, wms_bin_created_date	, wms_bin_modified_by			, wms_bin_modified_date			, wms_bin_timestamp, 
		wms_bin_userdefined1	, wms_bin_userdefined2	, wms_bin_userdefined3			, wms_bin_refdoc_no				, wms_bin_billing_status, 
		wms_bin_bill_value		, wms_bin_gen_from		, wms_bin_inthumov_bil_status	, wms_bin_lbchprhr_bil_status	, wms_bin_fr_insp, 
		wms_bin_source_docno	, wms_bin_source_stage	, etlcreateddatetime
	FROM stg.stg_wms_bin_exec_hdr;
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
$BODY$;
ALTER PROCEDURE dwh.usp_f_binexechdr(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
