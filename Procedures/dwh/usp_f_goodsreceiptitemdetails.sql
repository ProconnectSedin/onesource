-- PROCEDURE: dwh.usp_f_goodsreceiptitemdetails(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_goodsreceiptitemdetails(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_goodsreceiptitemdetails(
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
	p_depsource VARCHAR(100);

BEGIN

	SELECT d.jobname,h.envsourcecode,h.datasourcecode,d.latestbatchid,d.targetprocedurename, h.rawstorageflag,h.depsource
	INTO p_etljobname, p_envsourcecd, p_datasourcecd, p_batchid, p_taskname, p_rawstorageflag,p_depsource
	FROM ods.controldetail d 
	INNER JOIN ods.controlheader h
		ON d.sourceid = h.sourceid
	WHERE 	d.sourceid 		= p_sourceId 
		AND d.dataflowflag 	= p_dataflowflag
		AND d.targetobject 	= p_targetobject;

	IF EXISTS(SELECT 1  FROM ods.controlheader WHERE sourceid = p_depsource AND status = 'Completed' 
					AND CAST(COALESCE(lastupdateddate,createddate) AS DATE) = NOW()::DATE)
	THEN

    SELECT COUNT(1) INTO srccnt
	FROM stg.stg_wms_gr_exec_item_dtl;

	UPDATE dwh.f_goodsreceiptitemdetails t
    SET 
		  gr_dtl_key					= COALESCE(fgrd.gr_dtl_key,-1)
        , gr_itm_dtl_loc_key            = COALESCE(l.loc_key,-1)
		, gr_itm_dtl_itm_hdr_key        = COALESCE(i.itm_hdr_key,-1)	
        , gr_itm_dtl_uom_key            = COALESCE(u.uom_key,-1)
        , gr_itm_dtl_thu_key            = COALESCE(th.thu_key,-1)
        , gr_itm_dtl_stg_mas_key        = COALESCE(ds.stg_mas_key,-1)
		, gr_po_no 						= s.wms_gr_po_no
		, gr_po_sno 					= s.wms_gr_po_sno
		, gr_item 						= s.wms_gr_item
		, gr_item_qty 					= s.wms_gr_item_qty
		, gr_lot_no 					= s.wms_gr_lot_no
		, gr_acpt_qty 					= s.wms_gr_acpt_qty
		, gr_rej_qty 					= s.wms_gr_rej_qty
		, gr_storage_unit 				= s.wms_gr_storage_unit
		, gr_mas_uom 					= s.wms_gr_mas_uom
		, gr_su_qty 					= s.wms_gr_su_qty
		, gr_uid_sno 					= s.wms_gr_uid_sno
		, gr_manu_date 					= s.wms_gr_manu_date
		, gr_exp_date 					= s.wms_gr_exp_date
		, gr_exe_asn_line_no 			= s.wms_gr_exe_asn_line_no
		, gr_exe_wh_bat_no 				= s.wms_gr_exe_wh_bat_no
		, gr_exe_supp_bat_no 			= s.wms_gr_exe_supp_bat_no
		, gr_asn_srl_no 				= s.wms_gr_asn_srl_no
		, gr_asn_uid 					= s.wms_gr_asn_uid
		, gr_asn_cust_sl_no 			= s.wms_gr_asn_cust_sl_no
		, gr_asn_ref_doc_no1 			= s.wms_gr_asn_ref_doc_no1
		, gr_asn_consignee 				= s.wms_gr_asn_consignee
		, gr_asn_outboundorder_qty 		= s.wms_gr_asn_outboundorder_qty
		, gr_asn_bestbeforedate 		= s.wms_gr_asn_bestbeforedate
		, gr_asn_remarks 				= s.wms_gr_asn_remarks
		, gr_plan_no 					= s.wms_gr_plan_no
		, gr_execution_date 			= s.wms_gr_execution_date
		, gr_reasoncode 				= s.wms_gr_reasoncode
		, gr_cross_dock 				= s.wms_gr_cross_dock
		, gr_thu_id 					= s.wms_gr_thu_id
		, gr_thu_sno 					= s.wms_gr_thu_sno
		, gr_stag_id 					= s.wms_gr_stag_id
		, gr_stock_status 				= s.wms_gr_stock_status
		, gr_inv_type 					= s.wms_gr_inv_type
		, gr_product_status 			= s.wms_gr_product_status
		, gr_coo 						= s.wms_gr_coo
		, gr_item_attribute1 			= s.wms_gr_item_attribute1
		, gr_item_attribute2 			= s.wms_gr_item_attribute2
		, gr_item_attribute3 			= s.wms_gr_item_attribute3
		, gr_item_in_stage 				= s.wms_gr_item_in_stage
		, gr_item_to_stage 				= s.wms_gr_item_to_stage
		, gr_pal_status 				= s.wms_gr_pal_status
		, gr_item_hht_save_flag 		= s.wms_gr_item_hht_save_flag
		, gr_updated_from 				= s.wms_gr_updated_from
		, gr_last_updated_by 			= s.wms_gr_last_updated_by
		, gr_item_attribute7 			= s.wms_gr_item_attribute7
		, etlactiveind 					= 1
		, etljobname 					= p_etljobname
		, envsourcecd 					= p_envsourcecd
		, datasourcecd 					= p_datasourcecd
		, etlupdatedatetime 			= NOW()	
    FROM stg.stg_wms_gr_exec_item_dtl s
	INNER JOIN dwh.f_goodsreceiptdetails fgrd		
		ON 	s.wms_gr_loc_code 			= fgrd.gr_loc_code 
		AND s.wms_gr_exec_no			= fgrd.gr_exec_no
        AND s.wms_gr_exec_ou        	= fgrd.gr_exec_ou		
	LEFT JOIN dwh.d_location l		
		ON 	s.wms_gr_loc_code 			= l.loc_code 
        AND s.wms_gr_exec_ou        	= l.loc_ou		
	LEFT JOIN dwh.d_itemheader i		
		ON 	s.wms_gr_item 				= i.itm_code 
        AND s.wms_gr_exec_ou        	= i.itm_ou	
	LEFT JOIN dwh.d_uom u 		
		ON 	s.wms_gr_mas_uom			= u.mas_uomcode 
        AND s.wms_gr_exec_ou        	= u.mas_ouinstance	
	LEFT JOIN dwh.d_thu th 			
		ON 	s.wms_gr_thu_id				= th.thu_id 
        AND s.wms_gr_exec_ou        	= th.thu_ou
	LEFT JOIN dwh.d_stage ds 		
		ON 	s.wms_gr_stag_id			= ds.stg_mas_id
		AND s.wms_gr_loc_code			= ds.stg_mas_loc		
        AND s.wms_gr_exec_ou        	= ds.stg_mas_ou	
    WHERE   t.gr_loc_code 				= s.wms_gr_loc_code
		AND t.gr_exec_no 				= s.wms_gr_exec_no
		AND t.gr_exec_ou 				= s.wms_gr_exec_ou
		AND t.gr_lineno 				= s.wms_gr_lineno;
    
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

	INSERT INTO dwh.f_goodsreceiptitemdetails
	(
		  gr_dtl_key					, gr_itm_dtl_loc_key			, gr_itm_dtl_itm_hdr_key		, gr_itm_dtl_uom_key
		, gr_itm_dtl_thu_key			, gr_itm_dtl_stg_mas_key		, gr_loc_code					, gr_exec_no
		, gr_exec_ou					, gr_lineno						, gr_po_no						, gr_po_sno
		, gr_item						, gr_item_qty					, gr_lot_no						, gr_acpt_qty
		, gr_rej_qty					, gr_storage_unit				, gr_mas_uom					, gr_su_qty
		, gr_uid_sno					, gr_manu_date					, gr_exp_date					, gr_exe_asn_line_no
		, gr_exe_wh_bat_no				, gr_exe_supp_bat_no			, gr_asn_srl_no					, gr_asn_uid
		, gr_asn_cust_sl_no				, gr_asn_ref_doc_no1			, gr_asn_consignee				, gr_asn_outboundorder_qty
		, gr_asn_bestbeforedate			, gr_asn_remarks				, gr_plan_no					, gr_execution_date
		, gr_reasoncode					, gr_cross_dock					, gr_thu_id						, gr_thu_sno
		, gr_stag_id					, gr_stock_status				, gr_inv_type					, gr_product_status
		, gr_coo						, gr_item_attribute1			, gr_item_attribute2			, gr_item_attribute3
		, gr_item_in_stage				, gr_item_to_stage				, gr_pal_status					, gr_item_hht_save_flag
		, gr_updated_from				, gr_last_updated_by			, gr_item_attribute7			, etlactiveind
		, etljobname					, envsourcecd					, datasourcecd					, etlcreatedatetime
	)
	
	SELECT 
		  COALESCE(fgrd.gr_dtl_key,-1)	, COALESCE(l.loc_key,-1)		, COALESCE(i.itm_hdr_key,-1)	, COALESCE(u.uom_key,-1)
		, COALESCE(th.thu_key,-1)		, COALESCE(ds.stg_mas_key,-1)	, s.wms_gr_loc_code				, s.wms_gr_exec_no
		, s.wms_gr_exec_ou				, s.wms_gr_lineno				, s.wms_gr_po_no				, s.wms_gr_po_sno
		, s.wms_gr_item					, s.wms_gr_item_qty				, s.wms_gr_lot_no				, s.wms_gr_acpt_qty
		, s.wms_gr_rej_qty				, s.wms_gr_storage_unit			, s.wms_gr_mas_uom				, s.wms_gr_su_qty
		, s.wms_gr_uid_sno				, s.wms_gr_manu_date			, s.wms_gr_exp_date				, s.wms_gr_exe_asn_line_no
		, s.wms_gr_exe_wh_bat_no		, s.wms_gr_exe_supp_bat_no		, s.wms_gr_asn_srl_no			, s.wms_gr_asn_uid
		, s.wms_gr_asn_cust_sl_no		, s.wms_gr_asn_ref_doc_no1		, s.wms_gr_asn_consignee		, s.wms_gr_asn_outboundorder_qty
		, s.wms_gr_asn_bestbeforedate	, s.wms_gr_asn_remarks			, s.wms_gr_plan_no				, s.wms_gr_execution_date
		, s.wms_gr_reasoncode			, s.wms_gr_cross_dock			, s.wms_gr_thu_id				, s.wms_gr_thu_sno
		, s.wms_gr_stag_id				, s.wms_gr_stock_status			, s.wms_gr_inv_type				, s.wms_gr_product_status
		, s.wms_gr_coo					, s.wms_gr_item_attribute1		, s.wms_gr_item_attribute2		, s.wms_gr_item_attribute3
		, s.wms_gr_item_in_stage		, s.wms_gr_item_to_stage		, s.wms_gr_pal_status			, s.wms_gr_item_hht_save_flag
		, s.wms_gr_updated_from			, s.wms_gr_last_updated_by		, s.wms_gr_item_attribute7		, 1 AS etlactiveind			
		, p_etljobname					, p_envsourcecd					, p_datasourcecd				, NOW()
	FROM stg.stg_wms_gr_exec_item_dtl s
	INNER JOIN dwh.f_goodsreceiptdetails fgrd		
		ON 	s.wms_gr_loc_code 			= fgrd.gr_loc_code 
		AND s.wms_gr_exec_no			= fgrd.gr_exec_no
        AND s.wms_gr_exec_ou        	= fgrd.gr_exec_ou		
	LEFT JOIN dwh.d_location l		
		ON 	s.wms_gr_loc_code 			= l.loc_code 
        AND s.wms_gr_exec_ou        	= l.loc_ou		
	LEFT JOIN dwh.d_itemheader i		
		ON 	s.wms_gr_item 				= i.itm_code 
        AND s.wms_gr_exec_ou        	= i.itm_ou	
	LEFT JOIN dwh.d_uom u 		
		ON 	s.wms_gr_mas_uom			= u.mas_uomcode 
        AND s.wms_gr_exec_ou        	= u.mas_ouinstance	
	LEFT JOIN dwh.d_thu th 			
		ON 	s.wms_gr_thu_id				= th.thu_id 
        AND s.wms_gr_exec_ou        	= th.thu_ou
	LEFT JOIN dwh.d_stage ds 		
		ON 	s.wms_gr_stag_id			= ds.stg_mas_id
		AND s.wms_gr_loc_code			= ds.stg_mas_loc
        AND s.wms_gr_exec_ou        	= ds.stg_mas_ou 
	LEFT JOIN dwh.f_goodsreceiptitemdetails t 	
		ON  t.gr_loc_code 				= s.wms_gr_loc_code
		AND t.gr_exec_no 				= s.wms_gr_exec_no
		AND t.gr_exec_ou 				= s.wms_gr_exec_ou
		AND t.gr_lineno 				= s.wms_gr_lineno
    WHERE   t.gr_loc_code IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN
	
	INSERT INTO raw.raw_wms_gr_exec_item_dtl
	(
		  wms_gr_loc_code				, wms_gr_exec_no				, wms_gr_exec_ou					, wms_gr_lineno
		, wms_gr_po_no					, wms_gr_po_sno					, wms_gr_item						, wms_gr_item_qty
		, wms_gr_lot_no					, wms_gr_acpt_qty				, wms_gr_rej_qty					, wms_gr_storage_unit
		, wms_gr_consuambles			, wms_gr_consum_qty				, wms_gr_mas_uom					, wms_gr_su_qty
		, wms_gr_asn_line_no			, wms_gr_uid_sno				, wms_gr_manu_date					, wms_gr_exp_date
		, wms_gr_exe_asn_line_no		, wms_gr_exe_wh_bat_no			, wms_gr_exe_supp_bat_no			, wms_gr_asn_srl_no
		, wms_gr_asn_uid				, wms_gr_asn_cust_sl_no			, wms_gr_asn_ref_doc_no1			, wms_gr_asn_consignee
		, wms_gr_asn_outboundorder_no	, wms_gr_asn_outboundorder_qty	, wms_gr_asn_outboundorder_lineno	, wms_gr_asn_bestbeforedate
		, wms_gr_asn_remarks			, wms_gr_plan_no				, wms_gr_execution_date				, wms_gr_reasoncode
		, wms_gr_cross_dock				, wms_gr_thu_id					, wms_gr_thu_sno					, wms_gr_stag_id
		, wms_gr_stock_status			, wms_gr_inv_type				, wms_gr_product_status				, wms_gr_coo
		, wms_gr_item_attribute1		, wms_gr_item_attribute2		, wms_gr_item_attribute3			, wms_gr_item_attribute4
		, wms_gr_item_attribute5		, wms_gr_item_thu_type			, wms_gr_item_in_stage				, wms_gr_item_to_stage
		, wms_gr_pal_status				, wms_gr_su2_qty				, wms_gr_uid2_sno					, wms_gr_storage_unit2
		, wms_gr_item_hht_save_flag		, wms_gr_ins_exp_date			, wms_gr_ins_manu_date				, wms_gr_ins_bstbfr_date
		, wms_gr_ins_more_coo			, wms_gr_ins_more_inv_type		, wms_gr_ins_more_itm_attb1			, wms_gr_ins_more_itm_attb2
		, wms_gr_ins_more_itm_attb3		, wms_gr_ins_more_itm_attb4		, wms_gr_ins_more_itm_attb5			, wms_gr_ins_more_prod_stus
		, wms_gr_ins_more_su_img		, wms_gr_uid_serialno2			, wms_gr_uid_su2					, wms_gr_su1_conv_flg
		, wms_gr_su2_conv_flg			, wms_gr_su1_tog				, wms_gr_su2_tog					, wms_gr_updated_from
		, wms_gr_last_updated_by		, wms_gr_last_updated_datetime	, wms_gr_item_attribute6			, wms_gr_item_attribute7
		, wms_gr_item_attribute8		, wms_gr_item_attribute9		, wms_gr_item_attribute10			, wms_gr_qulinfee_bil_status	, etlcreateddatetime
	)
	SELECT 
		  wms_gr_loc_code				, wms_gr_exec_no				, wms_gr_exec_ou					, wms_gr_lineno
		, wms_gr_po_no					, wms_gr_po_sno					, wms_gr_item						, wms_gr_item_qty
		, wms_gr_lot_no					, wms_gr_acpt_qty				, wms_gr_rej_qty					, wms_gr_storage_unit
		, wms_gr_consuambles			, wms_gr_consum_qty				, wms_gr_mas_uom					, wms_gr_su_qty
		, wms_gr_asn_line_no			, wms_gr_uid_sno				, wms_gr_manu_date					, wms_gr_exp_date
		, wms_gr_exe_asn_line_no		, wms_gr_exe_wh_bat_no			, wms_gr_exe_supp_bat_no			, wms_gr_asn_srl_no
		, wms_gr_asn_uid				, wms_gr_asn_cust_sl_no			, wms_gr_asn_ref_doc_no1			, wms_gr_asn_consignee
		, wms_gr_asn_outboundorder_no	, wms_gr_asn_outboundorder_qty	, wms_gr_asn_outboundorder_lineno	, wms_gr_asn_bestbeforedate
		, wms_gr_asn_remarks			, wms_gr_plan_no				, wms_gr_execution_date				, wms_gr_reasoncode
		, wms_gr_cross_dock				, wms_gr_thu_id					, wms_gr_thu_sno					, wms_gr_stag_id
		, wms_gr_stock_status			, wms_gr_inv_type				, wms_gr_product_status				, wms_gr_coo
		, wms_gr_item_attribute1		, wms_gr_item_attribute2		, wms_gr_item_attribute3			, wms_gr_item_attribute4
		, wms_gr_item_attribute5		, wms_gr_item_thu_type			, wms_gr_item_in_stage				, wms_gr_item_to_stage
		, wms_gr_pal_status				, wms_gr_su2_qty				, wms_gr_uid2_sno					, wms_gr_storage_unit2
		, wms_gr_item_hht_save_flag		, wms_gr_ins_exp_date			, wms_gr_ins_manu_date				, wms_gr_ins_bstbfr_date
		, wms_gr_ins_more_coo			, wms_gr_ins_more_inv_type		, wms_gr_ins_more_itm_attb1			, wms_gr_ins_more_itm_attb2
		, wms_gr_ins_more_itm_attb3		, wms_gr_ins_more_itm_attb4		, wms_gr_ins_more_itm_attb5			, wms_gr_ins_more_prod_stus
		, wms_gr_ins_more_su_img		, wms_gr_uid_serialno2			, wms_gr_uid_su2					, wms_gr_su1_conv_flg
		, wms_gr_su2_conv_flg			, wms_gr_su1_tog				, wms_gr_su2_tog					, wms_gr_updated_from
		, wms_gr_last_updated_by		, wms_gr_last_updated_datetime	, wms_gr_item_attribute6			, wms_gr_item_attribute7
		, wms_gr_item_attribute8		, wms_gr_item_attribute9		, wms_gr_item_attribute10			, wms_gr_qulinfee_bil_status	, etlcreateddatetime
	FROM stg.stg_wms_gr_exec_item_dtl;
    END IF;
	ELSE	
		 p_errorid   := 0;
		 select 0 into inscnt;
       	 select 0 into updcnt;
		 select 0 into srccnt;	
		 
		 IF p_depsource IS NULL
		 THEN 
		 p_errordesc := 'The Dependent source cannot be NULL.';
		 ELSE
		 p_errordesc := 'The Dependent source '|| p_depsource || ' is not successfully executed. Please execute the source '|| p_depsource || ' then re-run the source '|| p_sourceid||'.';
		 END IF;
		 CALL ods.usp_etlerrorinsert(p_sourceid,p_targetobject,p_dataflowflag,p_batchid,p_taskname,'sp_ExceptionHandling',p_errorid,p_errordesc,NULL);
	END IF;	
	
	EXCEPTION WHEN others THEN
        get stacked diagnostics
            p_errorid   = returned_sqlstate,
            p_errordesc = message_text;
    CALL ods.usp_etlerrorinsert(p_sourceid, p_targetobject, p_dataflowflag, p_batchid,p_taskname, 'sp_ExceptionHandling', p_errorid, p_errordesc, null);
       select 0 into inscnt;
       select 0 into updcnt;
       
END;
$BODY$;
ALTER PROCEDURE dwh.usp_f_goodsreceiptitemdetails(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
