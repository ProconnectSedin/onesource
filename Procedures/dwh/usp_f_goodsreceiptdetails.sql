-- PROCEDURE: dwh.usp_f_goodsreceiptdetails(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_goodsreceiptdetails(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_goodsreceiptdetails(
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
	FROM stg.stg_wms_gr_exec_dtl;

	UPDATE dwh.f_goodsreceiptdetails t
    SET 
		  gr_loc_key					= COALESCE(l.loc_key,-1)
        , gr_emp_hdr_key                = COALESCE(e.emp_hdr_key,-1)
		, gr_date_key                   = COALESCE(d.datekey,-1)	
        , gr_stg_mas_key                = COALESCE(ds.stg_mas_key,-1)
		, gr_pln_no 					= s.wms_gr_pln_no
		, gr_pln_ou 					= s.wms_gr_pln_ou
		, gr_pln_date 					= s.wms_gr_pln_date
		, gr_po_no 						= s.wms_gr_po_no
		, gr_no 						= s.wms_gr_no
		, gr_emp 						= s.wms_gr_emp
		, gr_start_date 				= s.wms_gr_start_date
		, gr_end_date 					= s.wms_gr_end_date
		, gr_exec_status 				= s.wms_gr_exec_status
		, gr_created_by 				= s.wms_gr_created_by
		, gr_created_date 				= s.wms_gr_created_date
		, gr_modified_by 				= s.wms_gr_modified_by
		, gr_modified_date 				= s.wms_gr_modified_date
		, gr_timestamp 					= s.wms_gr_timestamp
		, gr_asn_no 					= s.wms_gr_asn_no
		, gr_staging_id 				= s.wms_gr_staging_id
		, gr_exec_date 					= s.wms_gr_exec_date
		, gr_build_complete 			= s.wms_gr_build_complete
		, gr_notype 					= s.wms_gr_notype
		, gr_ref_type 					= s.wms_gr_ref_type
		, gr_gen_from 					= s.wms_gr_gen_from
		, etlactiveind 					= 1
		, etljobname 					= p_etljobname
		, envsourcecd 					= p_envsourcecd
		, datasourcecd 					= p_datasourcecd
		, etlupdatedatetime 			= NOW()	
    FROM stg.stg_wms_gr_exec_dtl s
	LEFT JOIN dwh.d_location l		
		ON 	s.wms_gr_loc_code 			= l.loc_code 
        AND s.wms_gr_pln_ou        		= l.loc_ou	
	LEFT JOIN dwh.d_employeeheader e 		
		ON 	s.wms_gr_emp 				= e.emp_employee_code 
        AND s.wms_gr_pln_ou        		= e.emp_ou	
	LEFT JOIN dwh.d_date d 			
		ON 	s.wms_gr_pln_date::date 	= d.dateactual	
	LEFT JOIN dwh.d_stage ds 		
		ON 	s.wms_gr_staging_id			= ds.stg_mas_id
		AND s.wms_gr_loc_code 			= ds.stg_mas_loc
        AND s.wms_gr_pln_ou        		= ds.stg_mas_ou	
    WHERE 	t.gr_loc_code 				= s.wms_gr_loc_code
		AND	t.gr_exec_no 				= s.wms_gr_exec_no
		AND	t.gr_exec_ou 				= s.wms_gr_exec_ou;
    
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

	INSERT INTO dwh.f_goodsreceiptdetails
	(
		gr_loc_key					, gr_emp_hdr_key, 
		gr_date_key					, gr_stg_mas_key				, gr_loc_code				, gr_exec_no, 
		gr_exec_ou					, gr_pln_no						, gr_pln_ou					, gr_pln_date, 
		gr_po_no					, gr_no, gr_emp					, gr_start_date				, gr_end_date, 
		gr_exec_status				, gr_created_by					, gr_created_date			, gr_modified_by, 
		gr_modified_date			, gr_timestamp					, gr_asn_no					, gr_staging_id, 
		gr_exec_date				, gr_build_complete				, gr_notype					, gr_ref_type, 
		gr_gen_from					, etlactiveind					, etljobname				, envsourcecd, 
		datasourcecd				, etlcreatedatetime
	)
	
	SELECT 
	   	COALESCE(l.loc_key,-1)		, COALESCE(e.emp_hdr_key,-1),
		COALESCE(d.datekey,-1)		, COALESCE(ds.stg_mas_key,-1)	, s.wms_gr_loc_code			, s.wms_gr_exec_no, 
		s.wms_gr_exec_ou			, s.wms_gr_pln_no				, s.wms_gr_pln_ou			, s.wms_gr_pln_date, 
		s.wms_gr_po_no				, s.wms_gr_no, gr_emp			, s.wms_gr_start_date		, s.wms_gr_end_date, 
		s.wms_gr_exec_status		, s.wms_gr_created_by			, s.wms_gr_created_date		, s.wms_gr_modified_by, 
		s.wms_gr_modified_date		, s.wms_gr_timestamp			, s.wms_gr_asn_no			, s.wms_gr_staging_id, 
		s.wms_gr_exec_date			, s.wms_gr_build_complete		, s.wms_gr_notype			, s.wms_gr_ref_type, 
		s.wms_gr_gen_from			, 1 AS etlactiveind				, p_etljobname				, p_envsourcecd, 
		p_datasourcecd				, NOW()
	FROM stg.stg_wms_gr_exec_dtl s
	LEFT JOIN dwh.d_location l		
		ON 	s.wms_gr_loc_code 			= l.loc_code 
        AND s.wms_gr_pln_ou        		= l.loc_ou	
	LEFT JOIN dwh.d_employeeheader e 		
		ON 	s.wms_gr_emp 				= e.emp_employee_code 
        AND s.wms_gr_pln_ou        		= e.emp_ou	
	LEFT JOIN dwh.d_date d 			
		ON 	s.wms_gr_pln_date::date 	= d.dateactual	
	LEFT JOIN dwh.d_stage ds 		
		ON 	s.wms_gr_staging_id			= ds.stg_mas_id
		AND s.wms_gr_loc_code 			= ds.stg_mas_loc
        AND s.wms_gr_pln_ou        		= ds.stg_mas_ou	 
	LEFT JOIN dwh.f_goodsreceiptdetails t 	
		ON  t.gr_loc_code 				= s.wms_gr_loc_code
		AND	t.gr_exec_no 				= s.wms_gr_exec_no
		AND	t.gr_exec_ou 				= s.wms_gr_exec_ou
    WHERE t.gr_loc_code IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN
	
	INSERT INTO raw.raw_wms_gr_exec_dtl
	(
		wms_gr_loc_code				, wms_gr_exec_no				, wms_gr_exec_ou					, wms_gr_pln_no, 
		wms_gr_pln_ou				, wms_gr_pln_date				, wms_gr_po_no						, wms_gr_no, 
		wms_gr_emp					, wms_gr_start_date				, wms_gr_end_date					, wms_gr_exec_status, 
		wms_gr_created_by			, wms_gr_created_date			, wms_gr_modified_by				, wms_gr_modified_date, 
		wms_gr_timestamp			, wms_gr_userdefined1			, wms_gr_userdefined2				, wms_gr_userdefined3, 
		wms_gr_asn_no				, wms_gr_staging_id				, wms_gr_billing_status				, wms_gr_bill_value, 
		wms_gr_exec_date			, wms_gr_build_complete			, wms_gr_notype						, wms_gr_notype_prefix, 
		wms_gr_ref_type				, wms_gr_employeename			, wms_gr_refdocno					, wms_gr_remark, 
		wms_gr_customerserialno		, wms_gr_conschrg_bil_status	, wms_gr_csurcdgr_bil_status		, wms_gr_hdichpvl_bil_status, 
		wms_gr_lbchprhr_bil_status	, wms_gr_lblprcgr_bil_status	, wms_gr_palrestk_bil_status		, wms_gr_hdichwt_bil_status, 
		wms_gr_hdichitm_bil_status	, wms_gr_hdichsu_bil_status		, wms_gr_hdlimuom_bil_status		, wms_gr_gen_from, 
		wms_gr_consbchg_bil_status	, wms_gr_hdlioutc_bil_status	, wms_gr_whibferb_sell_bil_status	, wms_asn_hciqumos_bil_status, 
		wms_gr_cusbsdcg_bil_status	, etlcreateddatetime
	)
	SELECT 
		wms_gr_loc_code				, wms_gr_exec_no				, wms_gr_exec_ou					, wms_gr_pln_no, 
		wms_gr_pln_ou				, wms_gr_pln_date				, wms_gr_po_no						, wms_gr_no, 
		wms_gr_emp					, wms_gr_start_date				, wms_gr_end_date					, wms_gr_exec_status, 
		wms_gr_created_by			, wms_gr_created_date			, wms_gr_modified_by				, wms_gr_modified_date, 
		wms_gr_timestamp			, wms_gr_userdefined1			, wms_gr_userdefined2				, wms_gr_userdefined3, 
		wms_gr_asn_no				, wms_gr_staging_id				, wms_gr_billing_status				, wms_gr_bill_value, 
		wms_gr_exec_date			, wms_gr_build_complete			, wms_gr_notype						, wms_gr_notype_prefix, 
		wms_gr_ref_type				, wms_gr_employeename			, wms_gr_refdocno					, wms_gr_remark, 
		wms_gr_customerserialno		, wms_gr_conschrg_bil_status	, wms_gr_csurcdgr_bil_status		, wms_gr_hdichpvl_bil_status, 
		wms_gr_lbchprhr_bil_status	, wms_gr_lblprcgr_bil_status	, wms_gr_palrestk_bil_status		, wms_gr_hdichwt_bil_status, 
		wms_gr_hdichitm_bil_status	, wms_gr_hdichsu_bil_status		, wms_gr_hdlimuom_bil_status		, wms_gr_gen_from, 
		wms_gr_consbchg_bil_status	, wms_gr_hdlioutc_bil_status	, wms_gr_whibferb_sell_bil_status	, wms_asn_hciqumos_bil_status, 
		wms_gr_cusbsdcg_bil_status	, etlcreateddatetime
	FROM stg.stg_wms_gr_exec_dtl;
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
ALTER PROCEDURE dwh.usp_f_goodsreceiptdetails(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
