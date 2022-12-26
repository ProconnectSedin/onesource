-- PROCEDURE: click.usp_f_grn_bkp()

-- DROP PROCEDURE IF EXISTS click.usp_f_grn_bkp();

CREATE OR REPLACE PROCEDURE click.usp_f_grn_bkp(
	)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE 
    p_errorid integer;
	p_errordesc character varying;
	p_depsource VARCHAR(100);
	v_maxdate date;
BEGIN

		SELECT depsource
		into p_depsource
		from ods.dwhtoclickcontroldtl
		where objectname = 'usp_f_grn'; 

	IF EXISTS 
		 (
			 select 1 from ods.dwhtoclickcontroldtl
			 where objectname = p_depsource
			 and status = 'completed'
			 and CAST(COALESCE(loadenddatetime,loadstartdatetime) AS DATE) >= NOW()::date
		 )
	THEN
/*
	SELECT (CASE WHEN MAX(COALESCE(gr_modified_date,gr_created_date)) <> NULL 
					THEN MAX(COALESCE(gr_modified_date,gr_created_date))
				ELSE COALESCE(MAX(COALESCE(gr_modified_date,gr_created_date)),'1900-01-01') END)::DATE
	INTO v_maxdate
	FROM click.f_grn;	

	UPDATE click.f_grn ct
	SET
		  gr_pln_key 				= COALESCE(gd.gr_pln_key,-1)
		, gr_dtl_key 				= COALESCE(rd.gr_dtl_key,-1)
		, gr_itm_dtl_key 			= COALESCE(rid.gr_itm_dtl_key,-1)
		, asn_key 					= COALESCE(fa.asn_key,-1)
		, gr_loc_key 				= COALESCE(gd.gr_loc_key,-1)
		, gr_date_key 				= COALESCE(gd.gr_date_key,-1)
		, gr_emp_hdr_key 			= COALESCE(gd.gr_emp_key,-1)
		, gr_itm_dtl_itm_hdr_key 	= COALESCE(rid.gr_itm_dtl_itm_hdr_key,-1)
		, gr_itm_dtl_uom_key 		= COALESCE(rid.gr_itm_dtl_uom_key,-1)
		, gr_itm_dtl_stg_mas_key 	= COALESCE(rid.gr_itm_dtl_stg_mas_key,-1)
		, gr_pln_date 				= gd.gr_pln_date
		, gr_pln_status 			= gd.gr_pln_status
		, gr_po_no 					= gd.gr_po_no
		, gr_po_date 				= gd.gr_po_date
		, gr_asn_no 				= gd.gr_asn_no
		, gr_asn_date 				= gd.gr_asn_date
		, gr_employee 				= gd.gr_employee
		, gr_staging_id 			= gd.gr_staging_id
		, gr_ref_type 				= gd.gr_ref_type
		, gr_item 					= rid.gr_item
		, gr_item_qty 				= rid.gr_item_qty
		, gr_lot_no 				= rid.gr_lot_no
		, gr_acpt_qty 				= rid.gr_acpt_qty
		, gr_rej_qty 				= rid.gr_rej_qty
		, gr_storage_unit 			= rid.gr_storage_unit
		, gr_mas_uom 				= rid.gr_mas_uom
		, gr_su_qty 				= rid.gr_su_qty
		, gr_execution_date 		= rid.gr_execution_date
		, gr_reasoncode 			= rid.gr_reasoncode
		, gr_cross_dock 			= rid.gr_cross_dock
		, gr_stock_status 			= rid.gr_stock_status
		, gr_exec_no 				= rd.gr_exec_no
		, gr_no 					= rd.gr_no
		, gr_emp 					= rd.gr_emp
		, gr_start_date	 			= rd.gr_start_date
		, gr_end_date 				= rd.gr_end_date
		, gr_exec_status 			= rd.gr_exec_status
		, gr_created_by 			= rd.gr_created_by
		, gr_exec_date 				= rd.gr_exec_date
		, gr_gen_from 				= rd.gr_gen_from
		, gr_created_date			= gd.gr_created_date
		, gr_modified_date			= gd.gr_modified_date
		, etlupdatedatetime 		= NOW()
	FROM click.f_asn fa
	LEFT JOIN dwh.f_grplandetail gd		
		ON  fa.asn_no 						= gd.gr_asn_no
		AND fa.asn_location 				= gd.gr_loc_code
		AND fa.asn_ou 						= gd.gr_pln_ou
	LEFT JOIN dwh.f_goodsreceiptdetails rd
		ON  gd.gr_loc_code 					= rd.gr_loc_code
		AND gd.gr_pln_ou 					= rd.gr_pln_ou
		AND gd.gr_pln_no 					= rd.gr_pln_no
	LEFT JOIN dwh.f_goodsreceiptitemdetails rid
		ON  rd.gr_exec_no 					= rid.gr_exec_no
		AND rd.gr_exec_ou 					= rid.gr_exec_ou
		AND rd.gr_loc_code 					= rid.gr_loc_code
		AND rd.gr_po_no 					= rid.gr_po_no
		AND fa.asn_itm_code 				= rid.gr_item
		AND fa.asn_lineno					= rid.gr_exe_asn_line_no			
	WHERE   gd.gr_loc_code 					= ct.gr_loc_code
		AND gd.gr_pln_ou 					= ct.gr_pln_ou
		AND gd.gr_pln_no 					= ct.gr_pln_no
		AND gd.gr_asn_no 					= ct.gr_asn_no
		AND COALESCE(rd.gr_exec_no,'NULL') 	= COALESCE(ct.gr_exec_no,'NULL')
		AND COALESCE(rid.gr_lineno,0)		= COALESCE(ct.gr_lineno,0)
		AND COALESCE(gd.gr_modified_date,gd.gr_created_date) > v_maxdate;
		
		*/
		
	DELETE FROM click.f_grn
	WHERE COALESCE(gr_modified_date,gr_created_date)::DATE >= (CURRENT_DATE - INTERVAL '90 days')::DATE;

	INSERT INTO click.f_grn
	(
		gr_pln_key								, gr_dtl_key								, gr_itm_dtl_key					, asn_key, 
		gr_loc_key								, gr_date_key								, gr_emp_hdr_key					, gr_itm_dtl_itm_hdr_key, 
		gr_itm_dtl_uom_key						, gr_itm_dtl_stg_mas_key					, gr_loc_code						, gr_pln_no, 
		gr_pln_ou								, gr_pln_date								, gr_pln_status						, gr_po_no, 
		gr_po_date								, gr_asn_no									, gr_asn_date						, gr_employee, 
		gr_staging_id							, gr_ref_type								, gr_item							, gr_item_qty, 
		gr_lot_no								, gr_acpt_qty								, gr_rej_qty						, gr_storage_unit, 
		gr_mas_uom								, gr_su_qty									, gr_itmexecution_date				, gr_reasoncode, 
		gr_cross_dock							, gr_stock_status							, gr_exec_no						, gr_no		, gr_lineno,
		gr_emp									, gr_start_date								, gr_end_date						, gr_exec_status, 
		gr_created_by							, gr_exec_date								, gr_gen_from						, etlcreatedatetime,
		gr_modified_date						, gr_created_date
	)
	SELECT 
		  COALESCE(gd.gr_pln_key,-1)			, COALESCE(rd.gr_dtl_key,-1)				, COALESCE(rid.gr_itm_dtl_key,-1)	, COALESCE(fa.asn_key,-1)
		, COALESCE(gd.gr_loc_key,-1)			, COALESCE(gd.gr_date_key,-1)				, COALESCE(rd.gr_emp_hdr_key,-1)	, COALESCE(rid.gr_itm_dtl_itm_hdr_key,-1)
		, COALESCE(rid.gr_itm_dtl_uom_key,-1)	, COALESCE(rid.gr_itm_dtl_stg_mas_key,-1)	, gd.gr_loc_code					, gd.gr_pln_no
		, gd.gr_pln_ou							, gd.gr_pln_date							, gd.gr_pln_status					, gd.gr_po_no
		, gd.gr_po_date							, gd.gr_asn_no								, gd.gr_asn_date					, gd.gr_employee
		, gd.gr_staging_id						, gd.gr_ref_type							, rid.gr_item						, rid.gr_item_qty
		, rid.gr_lot_no							, rid.gr_acpt_qty							, rid.gr_rej_qty					, rid.gr_storage_unit
		, rid.gr_mas_uom						, rid.gr_su_qty								, rid.gr_execution_date				, rid.gr_reasoncode
		, rid.gr_cross_dock						, rid.gr_stock_status						, rd.gr_exec_no						, rd.gr_no	,rid.gr_lineno
		, rd.gr_emp								, rd.gr_start_date							, rd.gr_end_date					, rd.gr_exec_status
		, rd.gr_created_by						, rd.gr_exec_date							, rd.gr_gen_from					, NOW()
		, gd.gr_modified_date					, gd.gr_created_date
	FROM dwh.f_grplandetail gd	 
	INNER JOIN click.f_asn fa
		ON  fa.asn_loc_key					= gd.gr_loc_key
		AND fa.asn_no 						= gd.gr_asn_no  -- need to bring gr_asn_key in f_grplandetail
-- 		AND fa.asn_location 				= gd.gr_loc_code
-- 		AND fa.asn_ou 						= gd.gr_pln_ou
	LEFT JOIN dwh.f_goodsreceiptdetails rd
		ON  gd.gr_loc_key					= rd.gr_loc_key
		AND gd.gr_pln_no 					= rd.gr_pln_no  -- need to bring gr_pln_key in f_goodsreceiptdetails
-- 		AND gd.gr_loc_code 					= rd.gr_loc_code
-- 		AND gd.gr_pln_ou 					= rd.gr_pln_ou		
	LEFT JOIN dwh.f_goodsreceiptitemdetails rid
		ON	rd.gr_dtl_key					= rid.gr_dtl_key
		AND fa.asn_dtl_itm_hdr_key 			= rid.gr_itm_dtl_itm_hdr_key
		AND rd.gr_po_no 					= rid.gr_po_no		
		AND fa.asn_lineno					= rid.gr_exe_asn_line_no
-- 		ON  rd.gr_exec_no 					= rid.gr_exec_no
-- 		AND rd.gr_exec_ou 					= rid.gr_exec_ou
-- 		AND rd.gr_loc_code 					= rid.gr_loc_code
		
	WHERE COALESCE(gd.gr_modified_date,gd.gr_created_date)::DATE >= (CURRENT_DATE - INTERVAL '90 days')::DATE;

    ELSE	
	p_errorid   := 0;
		IF p_depsource IS NULL
			THEN 
			 	p_errordesc := 'The Dependent source cannot be NULL.';
			ELSE
				p_errordesc := 'The Dependent source '|| p_depsource || ' is not successfully executed. Please execute the source '|| p_depsource || ' then re-run the source.';
			END IF;
		CALL ods.usp_etlerrorinsert('DWH','f_grn','DWtoClick',NULL,'De-Normalized','sp_ExceptionHandling',p_errorid,p_errordesc,null);
	END IF;
	
	EXCEPTION WHEN others THEN       
       
    GET stacked DIAGNOSTICS p_errorid = returned_sqlstate, p_errordesc = message_text;
        
    CALL ods.usp_etlerrorinsert('DWH','f_grn','DWtoClick',NULL,'De-Normalized','sp_ExceptionHandling',p_errorid,p_errordesc,null);	
	
END;
$BODY$;
ALTER PROCEDURE click.usp_f_grn_bkp()
    OWNER TO proconnect;
