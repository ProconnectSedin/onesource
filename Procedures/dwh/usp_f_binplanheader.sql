CREATE PROCEDURE dwh.usp_f_binplanheader(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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

	SELECT d.jobname,h.envsourcecode,h.datasourcecode,d.latestbatchid,d.targetprocedurename, h.rawstorageflag
	INTO p_etljobname, p_envsourcecd, p_datasourcecd, p_batchid, p_taskname, p_rawstorageflag
	FROM ods.controldetail d 
	INNER JOIN ods.controlheader h
		ON d.sourceid = h.sourceid
	WHERE 	d.sourceid 		= p_sourceId 
		AND d.dataflowflag 	= p_dataflowflag
		AND d.targetobject 	= p_targetobject;

    SELECT COUNT(1) INTO srccnt
	FROM stg.stg_wms_bin_plan_hdr;

	UPDATE dwh.f_binPlanHeader t
    SET  
    	bin_loc_key					    = COALESCE(l.loc_key,-1),
		bin_pln_date       =   s.wms_bin_pln_date,
		bin_pln_status     =   s.wms_bin_pln_status,
		bin_mhe            =   s.wms_bin_mhe,
		bin_employee       =   s.wms_bin_employee,
		bin_created_by     =   s.wms_bin_created_by,
		bin_created_date   =   s.wms_bin_created_date,
		bin_modified_by    =   s.wms_bin_modified_by,
		bin_modified_date  =   s.wms_bin_modified_date,
		bin_timestamp      =   s.wms_bin_timestamp,
		bin_refdoc_no      =   s.wms_bin_refdoc_no,
		bin_gen_from       =   s.wms_bin_gen_from,
		bin_source_docno   =   s.wms_bin_source_docno,
		bin_source_stage   =   s.wms_bin_source_stage,
		bin_fr_insp        =   s.wms_bin_fr_insp,
		etlactiveind 					= 1
		, etljobname 					= p_etljobname
		, envsourcecd 					= p_envsourcecd
		, datasourcecd 					= p_datasourcecd
		, etlupdatedatetime 			= NOW()	
    FROM stg.stg_wms_bin_plan_hdr s
	LEFT JOIN dwh.d_location L 		
		ON s.wms_bin_loc_code 	= L.loc_code 
        AND s.wms_bin_pln_ou          = L.loc_ou

    WHERE   
    	      bin_loc_code =s.wms_bin_loc_code
		AND   bin_pln_no   =s.wms_bin_pln_no  
		AND   bin_pln_ou   =s.wms_bin_pln_ou;  

    GET DIAGNOSTICS updcnt = ROW_COUNT;

	INSERT INTO dwh.f_binPlanHeader
	(   bin_loc_key,  bin_loc_code,  bin_pln_no,  bin_pln_ou,  bin_pln_date,  bin_pln_status,  bin_mhe,  bin_employee,  bin_created_by,  bin_created_date,  bin_modified_by,  bin_modified_date,  bin_timestamp,  bin_refdoc_no,  bin_gen_from,  bin_source_docno,  bin_source_stage,  bin_fr_insp,   etlactiveind					, etljobname				, envsourcecd, 
		datasourcecd			, etlcreatedatetime
		
	)
	
	SELECT 

      COALESCE(l.loc_key,-1),OH.wms_bin_loc_code,  OH.wms_bin_pln_no,  OH.wms_bin_pln_ou,  OH.wms_bin_pln_date,  OH.wms_bin_pln_status,  OH.wms_bin_mhe,  OH.wms_bin_employee,  OH.wms_bin_created_by,  OH.wms_bin_created_date,  OH.wms_bin_modified_by,  OH.wms_bin_modified_date,  OH.wms_bin_timestamp,  OH.wms_bin_refdoc_no,  OH.wms_bin_gen_from,  OH.wms_bin_source_docno,  OH.wms_bin_source_stage,  OH.wms_bin_fr_insp,
           1 AS etlactiveind,				       p_etljobname,
		p_envsourcecd							, p_datasourcecd,                      NOW()
      
	FROM stg.stg_wms_bin_plan_hdr OH
	LEFT JOIN dwh.d_location L 		
		ON OH.wms_bin_loc_code 	= L.loc_code 
        AND OH.wms_bin_pln_ou          = L.loc_ou


  

	LEFT JOIN dwh.f_binPlanHeader FH 	
		ON 
  
    	      FH.bin_loc_code =OH.wms_bin_loc_code
		AND   FH.bin_pln_no   =OH.wms_bin_pln_no  
		AND   FH.bin_pln_ou   =OH.wms_bin_pln_ou 
	
    WHERE FH.bin_loc_code IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN
	
	INSERT INTO raw.raw_wms_bin_plan_hdr

	(wms_bin_loc_code,  wms_bin_pln_no,  wms_bin_pln_ou,  wms_bin_pln_date,  wms_bin_pln_status,  wms_bin_mhe,  wms_bin_employee,  wms_bin_created_by,  wms_bin_created_date,  wms_bin_modified_by,  wms_bin_modified_date,  wms_bin_timestamp,  wms_bin_userdefined1,  wms_bin_userdefined2,  wms_bin_userdefined3,  wms_bin_refdoc_no,  wms_bin_gen_from,  wms_bin_source_docno,  wms_bin_source_stage,  wms_bin_fr_insp,  wms_bin_mul_repl,  wms_bin_first_pln_no,  wms_bin_comp_flag,
	 etlcreateddatetime
	)
	SELECT wms_bin_loc_code,  wms_bin_pln_no,  wms_bin_pln_ou,  wms_bin_pln_date,  wms_bin_pln_status,  wms_bin_mhe,  wms_bin_employee,  wms_bin_created_by,  wms_bin_created_date,  wms_bin_modified_by,  wms_bin_modified_date,  wms_bin_timestamp,  wms_bin_userdefined1,  wms_bin_userdefined2,  wms_bin_userdefined3,  wms_bin_refdoc_no,  wms_bin_gen_from,  wms_bin_source_docno,  wms_bin_source_stage,  wms_bin_fr_insp,  wms_bin_mul_repl,  wms_bin_first_pln_no,  wms_bin_comp_flag,        
 etlcreateddatetime
	FROM stg.stg_wms_bin_plan_hdr;
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