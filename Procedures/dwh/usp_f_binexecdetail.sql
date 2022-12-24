-- PROCEDURE: dwh.usp_f_binexecdetail(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_binexecdetail(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_binexecdetail(
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
    p_batchid INTEGER;
	p_taskname VARCHAR(100);
	p_packagename  VARCHAR(100);
    p_errorid INTEGER;
	p_errordesc character varying;
	p_errorline INTEGER;
	p_depsource VARCHAR(100);
    p_rawstorageflag integer;

BEGIN

	SELECT d.jobname,h.envsourcecode,h.datasourcecode,d.latestbatchid,d.targetprocedurename, h.rawstorageflag,h.depsource
	INTO p_etljobname, p_envsourcecd, p_datasourcecd, p_batchid, p_taskname, p_rawstorageflag,p_depsource
	FROM ods.controldetail d 
	INNER JOIN ods.controlheader h
		ON d.sourceid = h.sourceid
	WHERE 	d.sourceid 		= p_sourceId 
		AND d.dataflowflag 	= p_dataflowflag
		AND d.targetobject 	= p_targetobject;
		
	IF EXISTS(SELECT 1 FROM ods.controlheader WHERE sourceid = p_depsource AND status = 'Completed' 
					AND CAST(COALESCE(lastupdateddate,createddate) AS DATE) >= NOW()::DATE)
	THEN

    SELECT COUNT(1) INTO srccnt FROM stg.stg_wms_bin_exec_item_dtl;

	UPDATE dwh.f_binexecdetail t
    SET 
		  bin_exec_hdr_key			= COALESCE(bh.bin_hdr_key,-1)
		, bin_exec_loc_key			= COALESCE(l.loc_key,-1)
		, bin_exec_itm_hdr_key		= COALESCE(i.itm_hdr_key,-1)
		, bin_exec_thu_key			= COALESCE(th.thu_key,-1)
		, bin_pln_no 				= s.wms_bin_pln_no
		, bin_pln_ou 				= s.wms_bin_pln_ou
		, bin_item 					= s.wms_bin_item
		, bin_item_batch_no 		= s.wms_bin_item_batch_no
		, bin_item_sr_no 			= s.wms_bin_item_sr_no
		, bin_uid 					= s.wms_bin_uid
		, bin_src_bin 				= s.wms_bin_src_bin
		, bin_src_zone 				= s.wms_bin_src_zone
		, bin_su 					= s.wms_bin_su
		, bin_su_qty 				= s.wms_bin_su_qty
		, bin_avial_qty 			= s.wms_bin_avial_qty
		, bin_trn_out_qty 			= s.wms_bin_trn_out_qty
		, bin_act_bin 				= s.wms_bin_act_bin
		, bin_act_zone 				= s.wms_bin_act_zone
		, bin_tar_zone 				= s.wms_bin_tar_zone
		, bin_tar_bin 				= s.wms_bin_tar_bin
		, bin_act_qty 				= s.wms_bin_act_qty
		, bin_lot_no 				= s.wms_bin_lot_no
		, bin_su_slno 				= s.wms_bin_su_slno
		, bin_uid_slno 				= s.wms_bin_uid_slno
		, bin_thu_typ 				= s.wms_bin_thu_typ
		, bin_thu_id 				= s.wms_bin_thu_id
		, bin_src_staging_id 		= s.wms_bin_src_staging_id
		, bin_trgt_staging_id 		= s.wms_bin_trgt_staging_id
		, bin_stk_line_no 			= s.wms_bin_stk_line_no
		, bin_stk_status 			= s.wms_bin_stk_status
		, bin_su_type 				= s.wms_bin_su_type
		, bin_status 				= s.wms_bin_status
		, bin_src_status 			= s.wms_bin_src_status
		, bin_from_thu_sl_no 		= s.wms_bin_from_thu_sl_no
		, bin_target_thu_sl_no 		= s.wms_bin_target_thu_sl_no
		, bin_rsn_code			 	= s.wms_bin_rsn_code
		, bin_pal_status 			= s.wms_bin_pal_status
		, bin_repl_alloc_ln_no 		= s.wms_bin_repl_alloc_ln_no
		, bin_repl_doc_line_no 		= s.wms_bin_repl_doc_line_no
		, bin_item_attr1 			= s.wms_bin_item_attr1
		, etlactiveind 				= 1
		, etljobname 				= p_etljobname
		, envsourcecd 				= p_envsourcecd
		, datasourcecd 				= p_datasourcecd
		, etlupdatedatetime 		= NOW()	
    FROM stg.stg_wms_bin_exec_item_dtl s
	INNER JOIN dwh.f_binexechdr bh 
		ON  s.wms_bin_exec_ou		= bh.bin_exec_ou
		AND s.wms_bin_exec_no 		= bh.bin_exec_no 
		AND s.wms_bin_loc_code		= bh.bin_loc_code
	LEFT JOIN dwh.d_location l 		
		ON  s.wms_bin_loc_code 		= l.loc_code 
		AND s.wms_bin_exec_ou 		= l.loc_ou 
	LEFT JOIN dwh.d_itemheader i 	
		ON  s.wms_bin_item 			= i.itm_code 
		AND s.wms_bin_exec_ou 		= i.itm_ou 
	LEFT JOIN dwh.d_thu th 			
		ON  s.wms_bin_thu_id 		= th.thu_id
		AND s.wms_bin_exec_ou		= th.thu_ou
    WHERE   t.bin_loc_code			= s.wms_bin_loc_code
		AND	t.bin_exec_no 			= s.wms_bin_exec_no
		AND	t.bin_pln_lineno 		= s.wms_bin_pln_lineno
		AND	t.bin_exec_ou	 		= s.wms_bin_exec_ou;
    
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

	INSERT INTO dwh.f_binexecdetail
	(
		  bin_exec_hdr_key				, bin_exec_loc_key				, bin_exec_itm_hdr_key			, bin_exec_thu_key							
		, bin_loc_code					, bin_exec_no					, bin_exec_ou					, bin_pln_lineno
		, bin_pln_no					, bin_pln_ou					, bin_item						, bin_item_batch_no
		, bin_item_sr_no				, bin_uid						, bin_src_bin					, bin_src_zone
		, bin_su						, bin_su_qty					, bin_avial_qty					, bin_trn_out_qty
		, bin_act_bin					, bin_act_zone					, bin_tar_zone					, bin_tar_bin
		, bin_act_qty					, bin_lot_no					, bin_su_slno					, bin_uid_slno
		, bin_thu_typ					, bin_thu_id					, bin_src_staging_id			, bin_trgt_staging_id
		, bin_stk_line_no				, bin_stk_status				, bin_su_type					, bin_status
		, bin_src_status				, bin_from_thu_sl_no			, bin_target_thu_sl_no			, bin_rsn_code
		, bin_pal_status				, bin_repl_alloc_ln_no			, bin_repl_doc_line_no			, bin_item_attr1				
		, etlactiveind					, etljobname					, envsourcecd					, datasourcecd					, etlcreatedatetime	
	)	
		
	SELECT DISTINCT 	
		  COALESCE(bh.bin_hdr_key,-1)	, COALESCE(l.loc_key,-1)		, COALESCE(i.itm_hdr_key,-1)	, COALESCE(th.thu_key,-1)			
		, s.wms_bin_loc_code			, s.wms_bin_exec_no				, s.wms_bin_exec_ou				, s.wms_bin_pln_lineno
		, s.wms_bin_pln_no				, s.wms_bin_pln_ou				, s.wms_bin_item				, s.wms_bin_item_batch_no
		, s.wms_bin_item_sr_no			, s.wms_bin_uid					, s.wms_bin_src_bin				, s.wms_bin_src_zone
		, s.wms_bin_su					, s.wms_bin_su_qty				, s.wms_bin_avial_qty			, s.wms_bin_trn_out_qty
		, s.wms_bin_act_bin				, s.wms_bin_act_zone			, s.wms_bin_tar_zone			, s.wms_bin_tar_bin
		, s.wms_bin_act_qty				, s.wms_bin_lot_no				, s.wms_bin_su_slno				, s.wms_bin_uid_slno
		, s.wms_bin_thu_typ				, s.wms_bin_thu_id				, s.wms_bin_src_staging_id		, s.wms_bin_trgt_staging_id
		, s.wms_bin_stk_line_no			, s.wms_bin_stk_status			, s.wms_bin_su_type				, s.wms_bin_status
		, s.wms_bin_src_status			, s.wms_bin_from_thu_sl_no		, s.wms_bin_target_thu_sl_no	, s.wms_bin_rsn_code
		, s.wms_bin_pal_status			, s.wms_bin_repl_alloc_ln_no	, s.wms_bin_repl_doc_line_no	, s.wms_bin_item_attr1			
		, 1 AS etlactiveind				, p_etljobname					, p_envsourcecd					, p_datasourcecd				, NOW()
	FROM stg.stg_wms_bin_exec_item_dtl s
	INNER JOIN dwh.f_binexechdr bh 
		ON  s.wms_bin_exec_ou		= bh.bin_exec_ou
		AND s.wms_bin_exec_no 		= bh.bin_exec_no 
		AND s.wms_bin_loc_code		= bh.bin_loc_code
	LEFT JOIN dwh.d_location l 		
		ON  s.wms_bin_loc_code 		= l.loc_code 
		AND s.wms_bin_exec_ou 		= l.loc_ou 
	LEFT JOIN dwh.d_itemheader i 	
		ON  s.wms_bin_item 			= i.itm_code 
		AND s.wms_bin_exec_ou 		= i.itm_ou 
	LEFT JOIN dwh.d_thu th 			
		ON  s.wms_bin_thu_id 		= th.thu_id
		AND s.wms_bin_exec_ou		= th.thu_ou
	LEFT JOIN dwh.f_binexecdetail t  	
		ON  t.bin_loc_code			= s.wms_bin_loc_code
		AND	t.bin_exec_no 			= s.wms_bin_exec_no
		AND	t.bin_pln_lineno 		= s.wms_bin_pln_lineno
		AND	t.bin_exec_ou	 		= s.wms_bin_exec_ou
    WHERE   t.bin_loc_code IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN
	
	INSERT INTO raw.raw_wms_bin_exec_item_dtl
	(
		  wms_bin_loc_code			, wms_bin_exec_no			, wms_bin_exec_ou			, wms_bin_pln_lineno
		, wms_bin_pln_no			, wms_bin_pln_ou			, wms_bin_item				, wms_bin_item_batch_no
		, wms_bin_item_sr_no		, wms_bin_uid				, wms_bin_src_bin			, wms_bin_src_zone
		, wms_bin_su				, wms_bin_su_qty			, wms_bin_avial_qty			, wms_bin_trn_out_qty
		, wms_bin_act_bin			, wms_bin_act_zone			, wms_bin_trn_in_qty		, wms_bin_tar_zone
		, wms_bin_tar_bin			, wms_bin_act_qty			, wms_bin_lot_no			, wms_bin_su_slno
		, wms_bin_uid_slno			, wms_bin_thu_typ			, wms_bin_thu_id			, wms_bin_src_staging_id
		, wms_bin_trgt_staging_id	, wms_bin_stk_line_no		, wms_bin_stk_status		, wms_bin_su_type
		, wms_bin_consignee			, wms_bin_customer			, wms_bin_gr_date			, wms_bin_status
		, wms_bin_trans_date		, wms_bin_trans_number		, wms_bin_trans_type		, wms_bin_src_status
		, wms_bin_mul_batch_flg		, wms_bin_from_thu_sl_no	, wms_bin_target_thu_sl_no	, wms_bin_rsn_code
		, wms_bin_pal_status		, wms_bin_thu2_id			, wms_bin_thu2_sl_no		, wms_bin_repl_alloc_ln_no
		, wms_bin_repl_doc_line_no	, wms_bin_su2				, wms_bin_su_slno2			, wms_bin_su_qty2
		, wms_bin_prof_type			, wms_bin_pick_scan_flg		, wms_bin_pway_scan_flg		, wms_bin_trans_uom
		, wms_bin_trans_uom_qty		, wms_bin_item_attr1		, wms_bin_item_attr10		, wms_bin_item_attr2
		, wms_bin_item_attr3		, wms_bin_item_attr4		, wms_bin_item_attr5		, wms_bin_item_attr6
		, wms_bin_item_attr7		, wms_bin_item_attr8		, wms_bin_item_attr9		, etlcreateddatetime
	
	)
	SELECT 
		  wms_bin_loc_code			, wms_bin_exec_no			, wms_bin_exec_ou			, wms_bin_pln_lineno
		, wms_bin_pln_no			, wms_bin_pln_ou			, wms_bin_item				, wms_bin_item_batch_no
		, wms_bin_item_sr_no		, wms_bin_uid				, wms_bin_src_bin			, wms_bin_src_zone
		, wms_bin_su				, wms_bin_su_qty			, wms_bin_avial_qty			, wms_bin_trn_out_qty
		, wms_bin_act_bin			, wms_bin_act_zone			, wms_bin_trn_in_qty		, wms_bin_tar_zone
		, wms_bin_tar_bin			, wms_bin_act_qty			, wms_bin_lot_no			, wms_bin_su_slno
		, wms_bin_uid_slno			, wms_bin_thu_typ			, wms_bin_thu_id			, wms_bin_src_staging_id
		, wms_bin_trgt_staging_id	, wms_bin_stk_line_no		, wms_bin_stk_status		, wms_bin_su_type
		, wms_bin_consignee			, wms_bin_customer			, wms_bin_gr_date			, wms_bin_status
		, wms_bin_trans_date		, wms_bin_trans_number		, wms_bin_trans_type		, wms_bin_src_status
		, wms_bin_mul_batch_flg		, wms_bin_from_thu_sl_no	, wms_bin_target_thu_sl_no	, wms_bin_rsn_code
		, wms_bin_pal_status		, wms_bin_thu2_id			, wms_bin_thu2_sl_no		, wms_bin_repl_alloc_ln_no
		, wms_bin_repl_doc_line_no	, wms_bin_su2				, wms_bin_su_slno2			, wms_bin_su_qty2
		, wms_bin_prof_type			, wms_bin_pick_scan_flg		, wms_bin_pway_scan_flg		, wms_bin_trans_uom
		, wms_bin_trans_uom_qty		, wms_bin_item_attr1		, wms_bin_item_attr10		, wms_bin_item_attr2
		, wms_bin_item_attr3		, wms_bin_item_attr4		, wms_bin_item_attr5		, wms_bin_item_attr6
		, wms_bin_item_attr7		, wms_bin_item_attr8		, wms_bin_item_attr9		, etlcreateddatetime
	FROM stg.stg_wms_bin_exec_item_dtl;
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
		   
	GET stacked DIAGNOSTICS p_errorid   = returned_sqlstate,p_errordesc = message_text;
			
	CALL ods.usp_etlerrorinsert(p_sourceid,p_targetobject,p_dataflowflag,p_batchid,p_taskname,'sp_ExceptionHandling',p_errorid,p_errordesc,NULL);
			
	SELECT 0 INTO inscnt;
	SELECT 0 INTO updcnt;	
END;
$BODY$;
ALTER PROCEDURE dwh.usp_f_binexecdetail(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
