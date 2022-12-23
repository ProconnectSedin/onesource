CREATE PROCEDURE dwh.usp_f_stockconversiondetail(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
    SELECT d.jobname, h.envsourcecode, h.datasourcecode, d.latestbatchid, d.targetprocedurename, h.rawstorageflag
    INTO p_etljobname, p_envsourcecd, p_datasourcecd, p_batchid, p_taskname, p_rawstorageflag
    FROM ods.controldetail d
    INNER JOIN ods.controlheader h
        ON d.sourceid 					= h.sourceid
    WHERE d.sourceid 					= p_sourceId
        AND d.dataflowflag 				= p_dataflowflag
        AND d.targetobject 				= p_targetobject;

    SELECT COUNT(1) INTO srccnt
    FROM stg.stg_wms_stock_conversion_dtl;

    UPDATE dwh.f_stockconversiondetail t
    SET
        stk_con_hdr_key                  	= COALESCE(sh.stk_con_hdr_key,-1),
        stk_con_dtl_loc_key              	= COALESCE(l.loc_key,-1),
        stk_con_dtl_customer_key         	= COALESCE(c.customer_key,-1),
        stk_con_dtl_itm_hdr_key			 	= COALESCE(i.itm_hdr_key,-1),
        stk_con_dtl_zone_key             	= COALESCE(z.zone_key,-1),
        stk_con_lineno                   	= s.wms_stk_con_lineno,
        stk_con_cust_no                  	= s.wms_stk_con_cust_no,
        stk_con_item_code                	= s.wms_stk_con_item_code,
        stk_con_item_batch_no            	= s.wms_stk_con_item_batch_no,
        stk_con_item_sr_no               	= s.wms_stk_con_item_sr_no,
        stk_con_bin                      	= s.wms_stk_con_bin,
        stk_con_qty                      	= s.wms_stk_con_qty,
        stk_con_from_status              	= s.wms_stk_con_from_status,
        stk_con_to_status                	= s.wms_stk_con_to_status,
        stk_con_from_qty                 	= s.wms_stk_con_from_qty,
        stk_con_to_qty                   	= s.wms_stk_con_to_qty,
        stk_con_status                   	= s.wms_stk_con_status,
        stk_con_remarks                  	= s.wms_stk_con_remarks,
        stk_con_su                       	= s.wms_stk_con_su,
        stk_con_uid_serial_no            	= s.wms_stk_con_uid_serial_no,
        stk_con_zone                     	= s.wms_stk_con_zone,
        stk_con_batchno                  	= s.wms_stk_con_batchno,
        stk_con_source_staging_id        	= s.wms_stk_con_source_staging_id,
        stk_con_tar_bin                  	= s.wms_stk_con_tar_bin,
        stk_gr_line_no                   	= s.wms_stk_gr_line_no,
        stk_gr_exec_no                   	= s.wms_stk_gr_exec_no,
        stk_con_res_code                 	= s.wms_stk_con_res_code,
        stk_wrtoff_qlty                  	= s.wms_stk_wrtoff_qlty,
        stk_con_stksts                   	= s.wms_stk_con_stksts,
        stk_con_from_thu_srno            	= s.wms_stk_con_from_thu_srno,
        stk_con_coo                      	= s.wms_stk_con_coo,
        stk_con_inven_type               	= s.wms_stk_con_inven_type,
        stk_con_item_atrib1              	= s.wms_stk_con_item_atrib1,
        stk_con_item_atrib2              	= s.wms_stk_con_item_atrib2,
        stk_con_item_atrib3              	= s.wms_stk_con_item_atrib3,
        stk_con_prod_status              	= s.wms_stk_con_prod_status,
        stk_con_stk_lineno               	= s.wms_stk_con_stk_lineno,
        stk_con_curr_stock_qty           	= s.wms_stk_con_curr_stock_qty,
        stk_con_item_atrib6              	= s.wms_stk_con_item_atrib6,
        etlactiveind                     	= 1,
        etljobname                       	= p_etljobname,
        envsourcecd                      	= p_envsourcecd,
        datasourcecd                     	= p_datasourcecd,
        etlupdatedatetime                	= NOW()
    FROM stg.stg_wms_stock_conversion_dtl s
	INNER JOIN dwh.f_stockconversionheader sh
		ON  s.wms_stk_con_loc_code 			= sh.stk_con_loc_code
		AND s.wms_stk_con_proposal_no 		= sh.stk_con_proposal_no
		AND s.wms_stk_con_proposal_ou		= sh.stk_con_proposal_ou
	LEFT JOIN dwh.d_location l	
		ON  s.wms_stk_con_loc_code 			= l.loc_code
		AND s.wms_stk_con_proposal_ou		= l.loc_ou
	LEFT JOIN dwh.d_customer c	
		ON  s.wms_stk_con_cust_no 			= c.customer_id
		AND s.wms_stk_con_proposal_ou		= c.customer_ou
	LEFT JOIN dwh.d_itemheader i	
		ON  s.wms_stk_con_item_code 		= i.itm_code
		AND s.wms_stk_con_proposal_ou		= i.itm_ou
	LEFT JOIN dwh.d_zone z	
		ON  s.wms_stk_con_zone				= z.zone_code
		AND s.wms_stk_con_loc_code 			= z.zone_loc_code
		AND s.wms_stk_con_proposal_ou		= z.zone_ou		
    WHERE   t.stk_con_loc_code 				= s.wms_stk_con_loc_code
		AND t.stk_con_proposal_no 			= s.wms_stk_con_proposal_no
		AND t.stk_con_proposal_ou 			= s.wms_stk_con_proposal_ou
		AND t.stk_con_lineno 				= s.wms_stk_con_lineno;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.f_stockconversiondetail
    (
        stk_con_hdr_key					, stk_con_dtl_loc_key				, stk_con_dtl_customer_key		, stk_con_dtl_itm_hdr_key, 
		stk_con_dtl_zone_key			, stk_con_loc_code					, stk_con_proposal_no			, stk_con_proposal_ou, 
		stk_con_lineno					, stk_con_cust_no					, stk_con_item_code				, stk_con_item_batch_no, 
		stk_con_item_sr_no				, stk_con_bin						, stk_con_qty					, stk_con_from_status, 
		stk_con_to_status				, stk_con_from_qty					, stk_con_to_qty				, stk_con_status, 
		stk_con_remarks					, stk_con_su						, stk_con_uid_serial_no			, stk_con_zone, 
		stk_con_batchno					, stk_con_source_staging_id			, stk_con_tar_bin				, stk_gr_line_no, 
		stk_gr_exec_no					, stk_con_res_code					, stk_wrtoff_qlty				, stk_con_stksts, 
		stk_con_from_thu_srno			, stk_con_coo						, stk_con_inven_type			, stk_con_item_atrib1, 
		stk_con_item_atrib2				, stk_con_item_atrib3				, stk_con_prod_status			, stk_con_stk_lineno, 
		stk_con_curr_stock_qty			, stk_con_item_atrib6				, etlactiveind					, etljobname, 
		envsourcecd						, datasourcecd						, etlcreatedatetime
    )

    SELECT
        COALESCE(sh.stk_con_hdr_key,-1)	, COALESCE(l.loc_key,-1)			, COALESCE(c.customer_key,-1)	, COALESCE(i.itm_hdr_key,-1), 
		COALESCE(z.zone_key,-1)			, s.wms_stk_con_loc_code			, s.wms_stk_con_proposal_no		, s.wms_stk_con_proposal_ou, 
		s.wms_stk_con_lineno			, s.wms_stk_con_cust_no				, s.wms_stk_con_item_code		, s.wms_stk_con_item_batch_no, 
		s.wms_stk_con_item_sr_no		, s.wms_stk_con_bin					, s.wms_stk_con_qty				, s.wms_stk_con_from_status, 
		s.wms_stk_con_to_status			, s.wms_stk_con_from_qty			, s.wms_stk_con_to_qty			, s.wms_stk_con_status, 
		s.wms_stk_con_remarks			, s.wms_stk_con_su					, s.wms_stk_con_uid_serial_no	, s.wms_stk_con_zone, 
		s.wms_stk_con_batchno			, s.wms_stk_con_source_staging_id	, s.wms_stk_con_tar_bin			, s.wms_stk_gr_line_no, 
		s.wms_stk_gr_exec_no			, s.wms_stk_con_res_code			, s.wms_stk_wrtoff_qlty			, s.wms_stk_con_stksts, 
		s.wms_stk_con_from_thu_srno		, s.wms_stk_con_coo					, s.wms_stk_con_inven_type		, s.wms_stk_con_item_atrib1, 
		s.wms_stk_con_item_atrib2		, s.wms_stk_con_item_atrib3			, s.wms_stk_con_prod_status		, s.wms_stk_con_stk_lineno, 
		s.wms_stk_con_curr_stock_qty	, s.wms_stk_con_item_atrib6			, 1								, p_etljobname, 
		p_envsourcecd					, p_datasourcecd					, NOW()
    FROM stg.stg_wms_stock_conversion_dtl s
	INNER JOIN dwh.f_stockconversionheader sh
		ON  s.wms_stk_con_loc_code 			= sh.stk_con_loc_code
		AND s.wms_stk_con_proposal_no 		= sh.stk_con_proposal_no
		AND s.wms_stk_con_proposal_ou		= sh.stk_con_proposal_ou
	LEFT JOIN dwh.d_location l	
		ON  s.wms_stk_con_loc_code 			= l.loc_code
		AND s.wms_stk_con_proposal_ou		= l.loc_ou
	LEFT JOIN dwh.d_customer c	
		ON  s.wms_stk_con_cust_no 			= c.customer_id
		AND s.wms_stk_con_proposal_ou		= c.customer_ou
	LEFT JOIN dwh.d_itemheader i	
		ON  s.wms_stk_con_item_code 		= i.itm_code
		AND s.wms_stk_con_proposal_ou		= i.itm_ou
	LEFT JOIN dwh.d_zone z	
		ON  s.wms_stk_con_zone				= z.zone_code
		AND s.wms_stk_con_loc_code 			= z.zone_loc_code
		AND s.wms_stk_con_proposal_ou		= z.zone_ou		
    LEFT JOIN dwh.f_stockconversiondetail t
		ON  s.wms_stk_con_loc_code 			= t.stk_con_loc_code
		AND s.wms_stk_con_proposal_no 		= t.stk_con_proposal_no
		AND s.wms_stk_con_proposal_ou 		= t.stk_con_proposal_ou
		AND s.wms_stk_con_lineno 			= t.stk_con_lineno
    WHERE t.stk_con_loc_code IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_wms_stock_conversion_dtl
    (
        wms_stk_con_loc_code			, wms_stk_con_proposal_no		, wms_stk_con_proposal_ou		, wms_stk_con_lineno, 
		wms_stk_con_cust_no				, wms_stk_con_item_code			, wms_stk_con_item_batch_no		, wms_stk_con_item_sr_no, 
		wms_stk_con_bin					, wms_stk_con_qty				, wms_stk_con_from_status		, wms_stk_con_to_status, 
		wms_stk_con_target_bin			, wms_stk_con_from_qty			, wms_stk_con_to_qty			, wms_stk_con_status, 
		wms_stk_con_remarks				, wms_stk_con_su				, wms_stk_con_uid_serial_no		, wms_stk_con_zone, 
		wms_stk_con_batchno				, wms_stk_con_source_staging_id	, wms_stk_con_tar_bin			, wms_stk_gr_line_no, 
		wms_stk_gr_exec_no				, wms_stk_con_res_code			, wms_stk_wrtoff_qlty_ctrl		, wms_stk_wrtoff_qlty, 
		wms_stk_con_stksts				, wms_stk_con_from_thu_srno		, wms_stk_con_target_thu_srno	, wms_stk_con_coo, 
		wms_stk_con_inven_type			, wms_stk_con_item_atrib1		, wms_stk_con_item_atrib2		, wms_stk_con_item_atrib3, 
		wms_stk_con_item_atrib4			, wms_stk_con_item_atrib5		, wms_stk_con_prod_status		, wms_stk_con_thu_type, 
		wms_stk_con_stk_lineno			, wms_stk_con_curr_stock_qty	, wms_stk_con_su1_qty			, wms_stk_con_su2, 
		wms_stk_con_uid_serial_no2		, wms_stk_con_su2_qty			, wms_stk_con_qty_UOM			, wms_stk_con_profile_type, 
		wms_stk_con_mas_to_qty			, wms_stk_con_item_atrib6		, wms_stk_con_item_atrib7		, wms_stk_con_item_atrib8, 
		wms_stk_con_item_atrib9			, wms_stk_con_item_atrib10		, etlcreateddatetime
    )
    SELECT
        wms_stk_con_loc_code			, wms_stk_con_proposal_no		, wms_stk_con_proposal_ou		, wms_stk_con_lineno, 
		wms_stk_con_cust_no				, wms_stk_con_item_code			, wms_stk_con_item_batch_no		, wms_stk_con_item_sr_no, 
		wms_stk_con_bin					, wms_stk_con_qty				, wms_stk_con_from_status		, wms_stk_con_to_status, 
		wms_stk_con_target_bin			, wms_stk_con_from_qty			, wms_stk_con_to_qty			, wms_stk_con_status, 
		wms_stk_con_remarks				, wms_stk_con_su				, wms_stk_con_uid_serial_no		, wms_stk_con_zone, 
		wms_stk_con_batchno				, wms_stk_con_source_staging_id	, wms_stk_con_tar_bin			, wms_stk_gr_line_no, 
		wms_stk_gr_exec_no				, wms_stk_con_res_code			, wms_stk_wrtoff_qlty_ctrl		, wms_stk_wrtoff_qlty, 
		wms_stk_con_stksts				, wms_stk_con_from_thu_srno		, wms_stk_con_target_thu_srno	, wms_stk_con_coo, 
		wms_stk_con_inven_type			, wms_stk_con_item_atrib1		, wms_stk_con_item_atrib2		, wms_stk_con_item_atrib3, 
		wms_stk_con_item_atrib4			, wms_stk_con_item_atrib5		, wms_stk_con_prod_status		, wms_stk_con_thu_type, 
		wms_stk_con_stk_lineno			, wms_stk_con_curr_stock_qty	, wms_stk_con_su1_qty			, wms_stk_con_su2, 
		wms_stk_con_uid_serial_no2		, wms_stk_con_su2_qty			, wms_stk_con_qty_UOM			, wms_stk_con_profile_type, 
		wms_stk_con_mas_to_qty			, wms_stk_con_item_atrib6		, wms_stk_con_item_atrib7		, wms_stk_con_item_atrib8, 
		wms_stk_con_item_atrib9			, wms_stk_con_item_atrib10		, etlcreateddatetime
	FROM stg.stg_wms_stock_conversion_dtl;
    END IF;

    EXCEPTION WHEN others THEN
    GET stacked DIAGNOSTICS p_errorid   = returned_sqlstate, p_errordesc = message_text;
    CALL ods.usp_etlerrorinsert(p_sourceid, p_targetobject, p_dataflowflag, p_batchid,p_taskname, 'sp_ExceptionHandling', p_errorid, p_errordesc, null);
    SELECT 0 INTO inscnt;
    SELECT 0 INTO updcnt;
END;
$$;