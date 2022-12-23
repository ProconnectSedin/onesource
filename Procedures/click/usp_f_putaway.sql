-- PROCEDURE: click.usp_f_putaway()

-- DROP PROCEDURE IF EXISTS click.usp_f_putaway();

CREATE OR REPLACE PROCEDURE click.usp_f_putaway(
	)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE 
    p_errorid integer;
	p_errordesc character varying;
	p_depsource VARCHAR(100);
	v_maxdate date;
BEGIN

		SELECT 	depsource
		INTO 	p_depsource
		FROM 	ods.dwhtoclickcontroldtl
		WHERE 	objectname = 'usp_f_putaway'; 

	IF EXISTS 
		 (
			 SELECT 1 FROM ods.dwhtoclickcontroldtl
			 WHERE	objectname = p_depsource
			 AND	status = 'completed'
			 AND	CAST(COALESCE(loadenddatetime,loadstartdatetime) AS DATE) >= NOW()::DATE
		 )
	THEN

/*
	SELECT (CASE WHEN MAX(COALESCE(modified_date,created_date)) <> NULL 
					THEN MAX(COALESCE(modified_date,created_date))
				ELSE COALESCE(MAX(COALESCE(modified_date,created_date)),'1900-01-01') END)::DATE
	INTO v_maxdate
	FROM click.f_putaway;
		
	UPDATE click.f_putaway pw
	SET
		 pway_pln_dtl_key 						= COALESCE(pd.pway_pln_dtl_key,-1)
		,pway_pln_itm_dtl_key 					= COALESCE(rd.pway_pln_itm_dtl_key,-1)
		,pway_itm_dtl_key 						= COALESCE(pid.pway_itm_dtl_key,-1)
		,pway_exe_dtl_key 						= COALESCE(ped.pway_exe_dtl_key,-1)
		,grn_key 								= COALESCE(gr.grn_key,-1)
		,pway_pln_dtl_loc_key 					= COALESCE(pd.pway_pln_dtl_loc_key,-1)
		,pway_pln_dtl_date_key 					= COALESCE(pd.pway_pln_dtl_date_key,-1)
		,pway_pln_dtl_stg_mas_key 				= COALESCE(pd.pway_pln_dtl_stg_mas_key,-1)
		,pway_pln_dtl_emp_hdr_key 				= COALESCE(pd.pway_pln_dtl_emp_hdr_key,-1)
		,pway_pln_itm_dtl_itm_hdr_key 			= COALESCE(rd.pway_pln_itm_dtl_itm_hdr_key,-1)
		,pway_pln_itm_dtl_zone_key 				= COALESCE(rd.pway_pln_itm_dtl_zone_key,-1)
		,pway_loc_code 							= pd.pway_loc_code
		,pway_pln_no 							= pd.pway_pln_no
		,pway_pln_ou 							= pd.pway_pln_ou
		,pway_pln_date 							= pd.pway_pln_date
		,pway_pln_status 						= pd.pway_pln_status
		,pway_stag_id 							= pd.pway_stag_id
		,pway_mhe_id 							= pd.pway_mhe_id
		,pway_employee_id 						= pd.pway_employee_id
		,pway_lineno							= rd.pway_lineno
		,pway_po_no 							= rd.pway_po_no
		,pway_item 								= rd.pway_item
		,pway_zone 								= rd.pway_zone
		,pway_allocated_qty 					= rd.pway_allocated_qty
		,pway_allocated_bin 					= rd.pway_allocated_bin
		,pway_gr_no 							= rd.pway_gr_no
		,pway_su_type 							= rd.pway_su_type
		,pway_su 								= rd.pway_su
		,pway_from_staging_id 					= rd.pway_from_staging_id
		,pway_cross_dock 						= rd.pway_cross_dock
		,pway_stock_status 						= rd.pway_stock_status
		,pway_exec_no 							= ped.pway_exec_no
		,pway_exec_ou 							= ped.pway_exec_ou
		,pway_exec_status 						= ped.pway_exec_status
		,pway_exec_start_date 					= ped.pway_exec_start_date
		,pway_exec_end_date 					= ped.pway_exec_end_date
		,pway_created_by 						= ped.pway_created_by
		,pway_created_date 						= ped.pway_created_date
		,pway_gen_from 							= ped.pway_gen_from
		,pway_exec_lineno 						= pid.pway_exec_lineno
		,pway_po_sr_no 							= pid.pway_po_sr_no
		,pway_uid 								= pid.pway_uid
		,pway_rqs_conformation 					= pid.pway_rqs_conformation
		,pway_actual_bin 						= pid.pway_actual_bin
		,pway_actual_bin_qty 					= pid.pway_actual_bin_qty
		,pway_reason		 					= pid.pway_reason
		,created_date							= pd.pway_created_date
		,modified_date							= pd.pway_modified_date
		,etlupdatedatetime 						= NOW()	
	FROM dwh.f_putawayplanitemdetail rd	
	LEFT JOIN click.f_grn gr
		ON  gr.gr_loc_code						= rd.pway_loc_code
		AND gr.gr_pln_ou 						= rd.pway_pln_ou
		AND gr.gr_no							= rd.pway_gr_no
		AND gr.gr_lineno						= rd.pway_gr_lineno
	LEFT JOIN dwh.f_putawayplandetail pd
		ON  pd.pway_pln_no 						= rd.pway_pln_no
		AND pd.pway_loc_code 					= rd.pway_loc_code
		AND pd.pway_pln_ou 						= rd.pway_pln_ou
	LEFT JOIN dwh.F_PutawayItemDetail pid	
		ON  pd.pway_loc_code 					= pid.pway_loc_code
		AND rd.pway_gr_no						= pid.pway_gr_no
		AND pd.pway_pln_ou 						= pid.pway_exec_ou
		AND rd.pway_lineno						= pid.pway_exec_lineno		
	LEFT JOIN dwh.f_putawayexecdetail ped	
		ON  pd.pway_pln_no 						= ped.pway_pln_no
		AND pd.pway_loc_code 					= ped.pway_loc_code
		AND pd.pway_pln_ou 						= ped.pway_pln_ou
		AND ped.pway_exec_no 					= pid.pway_exec_no
	WHERE   pw.pway_loc_code					= pd.pway_loc_code
		AND pw.pway_pln_no						= pd.pway_pln_no
		AND pw.pway_pln_ou						= pd.pway_pln_ou
		AND COALESCE(pw.pway_lineno,0)			= COALESCE(rd.pway_lineno,'0')
		AND COALESCE(pw.pway_po_no,'NULL')		= COALESCE(gr.gr_po_no,'NULL')
		AND COALESCE(pw.pway_item,'NULL')		= COALESCE(rd.pway_item,'NULL')
		AND COALESCE(pw.pway_gr_no,'NULL')		= COALESCE(rd.pway_gr_no,'NULL')
		AND COALESCE(pw.pway_exec_no,'NULL')	= COALESCE(pid.pway_exec_no,'NULL')
		AND COALESCE(pd.pway_modified_date,pd.pway_created_date) > v_maxdate; */
		
-- 	DELETE FROM click.f_putaway
-- 	WHERE COALESCE(modified_date,created_date)::DATE >= (CURRENT_DATE - INTERVAL '90 days')::DATE;
	SELECT (CASE WHEN MAX(etlcreatedatetime) <> NULL 
					THEN MAX(etlcreatedatetime)
				ELSE COALESCE(MAX(etlcreatedatetime),'1900-01-01') END)::DATE
	INTO v_maxdate
	FROM click.f_putaway;
	
	IF v_maxdate = '1900-01-01'
	THEN		
	INSERT INTO click.f_putaway
	(
		pway_pln_dtl_key							, pway_pln_itm_dtl_key						, pway_itm_dtl_key								, pway_exe_dtl_key, 
		grn_key										, pway_pln_dtl_loc_key							, pway_pln_dtl_date_key, 
		pway_pln_dtl_stg_mas_key					, pway_pln_dtl_emp_hdr_key					, pway_pln_itm_dtl_itm_hdr_key					, pway_pln_itm_dtl_zone_key, 
		pway_loc_code								, pway_pln_no								, pway_pln_ou									, pway_pln_date, 
		pway_pln_status								, pway_stag_id								, pway_mhe_id									, pway_employee_id, 
		pway_lineno									, pway_po_no								, pway_item										, pway_zone, 
		pway_allocated_qty							, pway_allocated_bin						, pway_gr_no									, pway_su_type, 
		pway_su										, pway_from_staging_id						, pway_cross_dock								, pway_stock_status, 
		pway_exec_no								, pway_exec_ou								, pway_exec_status								, pway_exec_start_date, 
		pway_exec_end_date							, pway_created_by							, pway_created_date								, pway_gen_from, 
		pway_exec_lineno							, pway_po_sr_no								, pway_uid										, pway_rqs_conformation, 
		pway_actual_bin								, pway_actual_bin_qty						, pway_reason									, etlcreatedatetime,
		created_date								, modified_date	,					activeindicator						
	)
	SELECT  
		COALESCE(pd.pway_pln_dtl_key,-1)			, COALESCE(rd.pway_pln_itm_dtl_key,-1)		, COALESCE(pid.pway_itm_dtl_key,-1)				, COALESCE(ped.pway_exe_dtl_key,-1), 
		COALESCE(gr.grn_key,-1)						, COALESCE(pd.pway_pln_dtl_loc_key,-1)		, COALESCE(pd.pway_pln_dtl_date_key,-1), 
		COALESCE(pd.pway_pln_dtl_stg_mas_key,-1)	, COALESCE(pd.pway_pln_dtl_emp_hdr_key,-1)	, COALESCE(rd.pway_pln_itm_dtl_itm_hdr_key,-1)	, COALESCE(rd.pway_pln_itm_dtl_zone_key,-1), 
		pd.pway_loc_code							, pd.pway_pln_no							, pd.pway_pln_ou								, pd.pway_pln_date, 
		pd.pway_pln_status							, pd.pway_stag_id							, pd.pway_mhe_id								, pd.pway_employee_id, 
		rd.pway_lineno								, rd.pway_po_no								, rd.pway_item									, rd.pway_zone, 
		rd.pway_allocated_qty						, rd.pway_allocated_bin						, rd.pway_gr_no									, rd.pway_su_type, 
		rd.pway_su									, rd.pway_from_staging_id					, rd.pway_cross_dock							, rd.pway_stock_status, 
		ped.pway_exec_no							, ped.pway_exec_ou							, ped.pway_exec_status							, ped.pway_exec_start_date, 
		ped.pway_exec_end_date						, ped.pway_created_by						, ped.pway_created_date							, ped.pway_gen_from, 
		pid.pway_exec_lineno						, pid.pway_po_sr_no							, pid.pway_uid									, pid.pway_rqs_conformation, 
		pid.pway_actual_bin							, pid.pway_actual_bin_qty					, pid.pway_reason								, NOW(),
		pd.pway_created_date						, pd.pway_modified_date,					(rd.etlactiveind*gr.activeindicator)
	FROM dwh.f_putawayplanitemdetail rd	
	LEFT JOIN click.f_grn gr
		ON  gr.gr_loc_key						= rd.pway_pln_itm_dtl_loc_key
		AND gr.gr_no							= rd.pway_gr_no
		AND gr.gr_lineno						= rd.pway_gr_lineno
		--AND gr.gr_pln_ou 						= rd.pway_pln_ou
		--AND gr.gr_loc_code					= rd.pway_loc_code
	LEFT JOIN dwh.f_putawayplandetail pd
		ON  pd.pway_pln_dtl_key 				= rd.pway_pln_dtl_key
		--AND pd.pway_loc_code					= rd.pway_loc_code
		--AND pd.pway_pln_no 					= rd.pway_pln_no
		--AND pd.pway_pln_ou 					= rd.pway_pln_ou
	LEFT JOIN dwh.f_putawayexecdetail ped
		ON	pd.pway_pln_dtl_key					= ped.pway_pln_dtl_key
-- 		ON  pd.pway_pln_no 						= ped.pway_pln_no
-- 		AND pd.pway_loc_code 					= ped.pway_loc_code
-- 		AND pd.pway_pln_ou 						= ped.pway_pln_ou
	LEFT JOIN dwh.F_PutawayItemDetail pid	
		ON  ped.pway_exe_dtl_key 				= pid.pway_exe_dtl_key
		AND rd.pway_gr_no						= pid.pway_gr_no
		AND rd.pway_lineno						= pid.pway_exec_lineno
		--AND pd.pway_pln_ou 					= pid.pway_exec_ou
	WHERE 1=1;
	ELSE	
	UPDATE click.f_putaway pw
	SET
		 pway_pln_dtl_key 						= COALESCE(pd.pway_pln_dtl_key,-1)
		,pway_pln_itm_dtl_key 					= COALESCE(rd.pway_pln_itm_dtl_key,-1)
		,pway_itm_dtl_key 						= COALESCE(pid.pway_itm_dtl_key,-1)
		,pway_exe_dtl_key 						= COALESCE(ped.pway_exe_dtl_key,-1)
		,grn_key 								= COALESCE(gr.grn_key,-1)
		,pway_pln_dtl_loc_key 					= COALESCE(pd.pway_pln_dtl_loc_key,-1)
		,pway_pln_dtl_date_key 					= COALESCE(pd.pway_pln_dtl_date_key,-1)
		,pway_pln_dtl_stg_mas_key 				= COALESCE(pd.pway_pln_dtl_stg_mas_key,-1)
		,pway_pln_dtl_emp_hdr_key 				= COALESCE(pd.pway_pln_dtl_emp_hdr_key,-1)
		,pway_pln_itm_dtl_itm_hdr_key 			= COALESCE(rd.pway_pln_itm_dtl_itm_hdr_key,-1)
		,pway_pln_itm_dtl_zone_key 				= COALESCE(rd.pway_pln_itm_dtl_zone_key,-1)
		,pway_loc_code 							= pd.pway_loc_code
		,pway_pln_no 							= pd.pway_pln_no
		,pway_pln_ou 							= pd.pway_pln_ou
		,pway_pln_date 							= pd.pway_pln_date
		,pway_pln_status 						= pd.pway_pln_status
		,pway_stag_id 							= pd.pway_stag_id
		,pway_mhe_id 							= pd.pway_mhe_id
		,pway_employee_id 						= pd.pway_employee_id
		,pway_lineno							= rd.pway_lineno
		,pway_po_no 							= rd.pway_po_no
		,pway_item 								= rd.pway_item
		,pway_zone 								= rd.pway_zone
		,pway_allocated_qty 					= rd.pway_allocated_qty
		,pway_allocated_bin 					= rd.pway_allocated_bin
		,pway_gr_no 							= rd.pway_gr_no
		,pway_su_type 							= rd.pway_su_type
		,pway_su 								= rd.pway_su
		,pway_from_staging_id 					= rd.pway_from_staging_id
		,pway_cross_dock 						= rd.pway_cross_dock
		,pway_stock_status 						= rd.pway_stock_status
		,pway_exec_no 							= ped.pway_exec_no
		,pway_exec_ou 							= ped.pway_exec_ou
		,pway_exec_status 						= ped.pway_exec_status
		,pway_exec_start_date 					= ped.pway_exec_start_date
		,pway_exec_end_date 					= ped.pway_exec_end_date
		,pway_created_by 						= ped.pway_created_by
		,pway_created_date 						= ped.pway_created_date
		,pway_gen_from 							= ped.pway_gen_from
		,pway_exec_lineno 						= pid.pway_exec_lineno
		,pway_po_sr_no 							= pid.pway_po_sr_no
		,pway_uid 								= pid.pway_uid
		,pway_rqs_conformation 					= pid.pway_rqs_conformation
		,pway_actual_bin 						= pid.pway_actual_bin
		,pway_actual_bin_qty 					= pid.pway_actual_bin_qty
		,pway_reason		 					= pid.pway_reason
		,created_date							= pd.pway_created_date
		,modified_date							= pd.pway_modified_date
		,activeindicator						= (rd.etlactiveind*gr.activeindicator)
		,etlupdatedatetime 						= NOW()	
	FROM dwh.f_putawayplanitemdetail rd	
	INNER JOIN click.f_grn gr
		ON  gr.gr_loc_code						= rd.pway_loc_code
		AND gr.gr_pln_ou 						= rd.pway_pln_ou
		AND gr.gr_no							= rd.pway_gr_no
		AND gr.gr_lineno						= rd.pway_gr_lineno
	LEFT JOIN dwh.f_putawayplandetail pd
		ON  pd.pway_pln_no 						= rd.pway_pln_no
		AND pd.pway_loc_code 					= rd.pway_loc_code
		AND pd.pway_pln_ou 						= rd.pway_pln_ou
	LEFT JOIN dwh.F_PutawayItemDetail pid	
		ON  pd.pway_loc_code 					= pid.pway_loc_code
		AND rd.pway_gr_no						= pid.pway_gr_no
		AND pd.pway_pln_ou 						= pid.pway_exec_ou
		AND rd.pway_lineno						= pid.pway_exec_lineno		
	LEFT JOIN dwh.f_putawayexecdetail ped	
		ON  pd.pway_pln_no 						= ped.pway_pln_no
		AND pd.pway_loc_code 					= ped.pway_loc_code
		AND pd.pway_pln_ou 						= ped.pway_pln_ou
		AND ped.pway_exec_no 					= pid.pway_exec_no
	WHERE   pw.pway_loc_code					= pd.pway_loc_code
		AND pw.pway_pln_no						= pd.pway_pln_no
		AND pw.pway_pln_ou						= pd.pway_pln_ou
		AND COALESCE(pw.pway_lineno,0)			= COALESCE(rd.pway_lineno,'0')
		AND COALESCE(pw.pway_po_no,'NULL')		= COALESCE(gr.gr_po_no,'NULL')
		AND COALESCE(pw.pway_item,'NULL')		= COALESCE(rd.pway_item,'NULL')
		AND COALESCE(pw.pway_gr_no,'NULL')		= COALESCE(rd.pway_gr_no,'NULL')
		AND COALESCE(pw.pway_exec_no,'NULL')	= COALESCE(pid.pway_exec_no,'NULL')
		AND COALESCE(pd.etlupdatedatetime,pd.etlcreatedatetime) >= v_maxdate;
		
	INSERT INTO click.f_putaway
	(
		pway_pln_dtl_key							, pway_pln_itm_dtl_key						, pway_itm_dtl_key								, pway_exe_dtl_key, 
		grn_key										, pway_pln_dtl_loc_key							, pway_pln_dtl_date_key, 
		pway_pln_dtl_stg_mas_key					, pway_pln_dtl_emp_hdr_key					, pway_pln_itm_dtl_itm_hdr_key					, pway_pln_itm_dtl_zone_key, 
		pway_loc_code								, pway_pln_no								, pway_pln_ou									, pway_pln_date, 
		pway_pln_status								, pway_stag_id								, pway_mhe_id									, pway_employee_id, 
		pway_lineno									, pway_po_no								, pway_item										, pway_zone, 
		pway_allocated_qty							, pway_allocated_bin						, pway_gr_no									, pway_su_type, 
		pway_su										, pway_from_staging_id						, pway_cross_dock								, pway_stock_status, 
		pway_exec_no								, pway_exec_ou								, pway_exec_status								, pway_exec_start_date, 
		pway_exec_end_date							, pway_created_by							, pway_created_date								, pway_gen_from, 
		pway_exec_lineno							, pway_po_sr_no								, pway_uid										, pway_rqs_conformation, 
		pway_actual_bin								, pway_actual_bin_qty						, pway_reason									, etlcreatedatetime,
		created_date								, modified_date,						activeindicator						
	)
	SELECT  
		COALESCE(pd.pway_pln_dtl_key,-1)			, COALESCE(rd.pway_pln_itm_dtl_key,-1)		, COALESCE(pid.pway_itm_dtl_key,-1)				, COALESCE(ped.pway_exe_dtl_key,-1), 
		COALESCE(gr.grn_key,-1)						, COALESCE(pd.pway_pln_dtl_loc_key,-1)		, COALESCE(pd.pway_pln_dtl_date_key,-1), 
		COALESCE(pd.pway_pln_dtl_stg_mas_key,-1)	, COALESCE(pd.pway_pln_dtl_emp_hdr_key,-1)	, COALESCE(rd.pway_pln_itm_dtl_itm_hdr_key,-1)	, COALESCE(rd.pway_pln_itm_dtl_zone_key,-1), 
		pd.pway_loc_code							, pd.pway_pln_no							, pd.pway_pln_ou								, pd.pway_pln_date, 
		pd.pway_pln_status							, pd.pway_stag_id							, pd.pway_mhe_id								, pd.pway_employee_id, 
		rd.pway_lineno								, rd.pway_po_no								, rd.pway_item									, rd.pway_zone, 
		rd.pway_allocated_qty						, rd.pway_allocated_bin						, rd.pway_gr_no									, rd.pway_su_type, 
		rd.pway_su									, rd.pway_from_staging_id					, rd.pway_cross_dock							, rd.pway_stock_status, 
		ped.pway_exec_no							, ped.pway_exec_ou							, ped.pway_exec_status							, ped.pway_exec_start_date, 
		ped.pway_exec_end_date						, ped.pway_created_by						, ped.pway_created_date							, ped.pway_gen_from, 
		pid.pway_exec_lineno						, pid.pway_po_sr_no							, pid.pway_uid									, pid.pway_rqs_conformation, 
		pid.pway_actual_bin							, pid.pway_actual_bin_qty					, pid.pway_reason								, NOW(),
		pd.pway_created_date						, pd.pway_modified_date,					(rd.etlactiveind*gr.activeindicator)
	FROM dwh.f_putawayplanitemdetail rd	
	INNER JOIN click.f_grn gr
		ON  gr.gr_loc_key						= rd.pway_pln_itm_dtl_loc_key
		AND gr.gr_no							= rd.pway_gr_no
		AND gr.gr_lineno						= rd.pway_gr_lineno
		--AND gr.gr_pln_ou 						= rd.pway_pln_ou
		--AND gr.gr_loc_code					= rd.pway_loc_code
	LEFT JOIN dwh.f_putawayplandetail pd
		ON  pd.pway_pln_dtl_key 				= rd.pway_pln_dtl_key
		--AND pd.pway_loc_code					= rd.pway_loc_code
		--AND pd.pway_pln_no 					= rd.pway_pln_no
		--AND pd.pway_pln_ou 					= rd.pway_pln_ou
	LEFT JOIN dwh.f_putawayexecdetail ped
		ON	pd.pway_pln_dtl_key					= ped.pway_pln_dtl_key
-- 		ON  pd.pway_pln_no 						= ped.pway_pln_no
-- 		AND pd.pway_loc_code 					= ped.pway_loc_code
-- 		AND pd.pway_pln_ou 						= ped.pway_pln_ou
	LEFT JOIN dwh.F_PutawayItemDetail pid	
		ON  ped.pway_exe_dtl_key 				= pid.pway_exe_dtl_key
		AND rd.pway_gr_no						= pid.pway_gr_no
		AND rd.pway_lineno						= pid.pway_exec_lineno
	WHERE COALESCE(pd.etlupdatedatetime,pd.etlcreatedatetime) >= v_maxdate;
	END IF;
	
    ELSE	
	p_errorid   := 0;
		IF p_depsource IS NULL
			THEN 
			 	p_errordesc := 'The Dependent source cannot be NULL.';
			ELSE
				p_errordesc := 'The Dependent source '|| p_depsource || ' is not successfully executed. Please execute the source '|| p_depsource || ' then re-run the source.';
			END IF;
		CALL ods.usp_etlerrorinsert('DWH','f_putaway','DWtoClick',NULL,'De-Normalized','sp_ExceptionHandling',p_errorid,p_errordesc,null);
	END IF;

		
	EXCEPTION WHEN others THEN       
       
    GET stacked DIAGNOSTICS p_errorid = returned_sqlstate, p_errordesc = message_text;
        
    CALL ods.usp_etlerrorinsert('DWH','f_putaway','DWtoClick',NULL,'De-Normalized','sp_ExceptionHandling',p_errorid,p_errordesc,null);
	
END;
$BODY$;
ALTER PROCEDURE click.usp_f_putaway()
    OWNER TO proconnect;
