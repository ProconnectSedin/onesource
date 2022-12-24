CREATE OR REPLACE PROCEDURE dwh.usp_d_excessitem(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
		ON d.sourceid 		= h.sourceid
	WHERE 	d.sourceid 		= p_sourceId 
		AND d.dataflowflag 	= p_dataflowflag
		AND d.targetobject 	= p_targetobject;

    SELECT COUNT(1) INTO srccnt
	FROM stg.stg_wms_ex_item_hdr;

	UPDATE dwh.d_excessitem t
    SET 
		 ex_itm_hdr_key				= COALESCE(i.itm_hdr_key,-1)
		,ex_itm_desc 				= s.wms_ex_itm_desc
		,ex_itm_cap_profile 		= s.wms_ex_itm_cap_profile
		,ex_itm_zone_profile 		= s.wms_ex_itm_zone_profile
		,ex_itm_stage_profile 		= s.wms_ex_itm_stage_profile
		,ex_itm_effective_frm 		= s.wms_ex_itm_effective_frm
		,ex_itm_effective_to 		= s.wms_ex_itm_effective_to
		,ex_itm_pick_per_tol_pos 	= s.wms_ex_itm_pick_per_tol_pos
		,ex_itm_pick_per_tol_neg 	= s.wms_ex_itm_pick_per_tol_neg
		,ex_itm_pick_uom_tol_pos 	= s.wms_ex_itm_pick_uom_tol_pos
		,ex_itm_pick_uom_tol_neg 	= s.wms_ex_itm_pick_uom_tol_neg
		,ex_itm_mininum_qty 		= s.wms_ex_itm_mininum_qty
		,ex_itm_maximum_qty 		= s.wms_ex_itm_maximum_qty
		,ex_itm_replen_qty 			= s.wms_ex_itm_replen_qty
		,ex_itm_master_uom 			= s.wms_ex_itm_master_uom
		,ex_itm_timestamp 			= s.wms_ex_itm_timestamp
		,ex_itm_created_by 			= s.wms_ex_itm_created_by
		,ex_itm_created_dt 			= s.wms_ex_itm_created_dt
		,ex_itm_modified_by 		= s.wms_ex_itm_modified_by
		,ex_itm_modified_dt 		= s.wms_ex_itm_modified_dt
		,ex_itm_packing_bay 		= s.wms_ex_itm_packing_bay
		,ex_itm_low_stk_lvl 		= s.wms_ex_itm_low_stk_lvl
		,ex_itm_std_strg_thu_id 	= s.wms_ex_itm_std_strg_thu_id
		,ex_itm_wave_repln_req 		= s.wms_ex_itm_wave_repln_req
		,etlactiveind 				= 1
		,etljobname 				= p_etljobname
		,envsourcecd 				= p_envsourcecd 
		,datasourcecd 				= p_datasourcecd
		,etlupdatedatetime 			= NOW()
	FROM stg.stg_wms_ex_item_hdr s
	LEFT JOIN  dwh.d_itemheader i
		ON	i.itm_code				= s.wms_ex_itm_code
		AND	i.itm_ou				= s.wms_ex_itm_ou
    WHERE t.ex_itm_ou 				= s.wms_ex_itm_ou
		AND	t.ex_itm_code 			= s.wms_ex_itm_code
		AND	t.ex_itm_loc_code 		= s.wms_ex_itm_loc_code;
    
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

	INSERT INTO dwh.d_excessitem
	(
		ex_itm_hdr_key
		,ex_itm_ou,					ex_itm_code,				ex_itm_loc_code,		ex_itm_desc,		ex_itm_cap_profile
		,ex_itm_zone_profile,		ex_itm_stage_profile,		ex_itm_effective_frm,	ex_itm_effective_to,ex_itm_pick_per_tol_pos
		,ex_itm_pick_per_tol_neg,	ex_itm_pick_uom_tol_pos,	ex_itm_pick_uom_tol_neg,ex_itm_mininum_qty,	ex_itm_maximum_qty
		,ex_itm_replen_qty,			ex_itm_master_uom,			ex_itm_timestamp,		ex_itm_created_by,	ex_itm_created_dt
		,ex_itm_modified_by,		ex_itm_modified_dt,			ex_itm_packing_bay,		ex_itm_low_stk_lvl,	ex_itm_std_strg_thu_id,	ex_itm_wave_repln_req
		,etlactiveind,				etljobname,					envsourcecd,			datasourcecd,		etlcreatedatetime
	)
	
    SELECT 
		COALESCE(i.itm_hdr_key,-1)
		,s.wms_ex_itm_ou,				s.wms_ex_itm_code,				s.wms_ex_itm_loc_code,			s.wms_ex_itm_desc,			s.wms_ex_itm_cap_profile
		,s.wms_ex_itm_zone_profile,		s.wms_ex_itm_stage_profile,		s.wms_ex_itm_effective_frm,		s.wms_ex_itm_effective_to,	s.wms_ex_itm_pick_per_tol_pos
		,s.wms_ex_itm_pick_per_tol_neg,	s.wms_ex_itm_pick_uom_tol_pos,	s.wms_ex_itm_pick_uom_tol_neg,	s.wms_ex_itm_mininum_qty,	s.wms_ex_itm_maximum_qty
		,s.wms_ex_itm_replen_qty,		s.wms_ex_itm_master_uom,		s.wms_ex_itm_timestamp,			s.wms_ex_itm_created_by,	s.wms_ex_itm_created_dt
		,s.wms_ex_itm_modified_by,		s.wms_ex_itm_modified_dt,		s.wms_ex_itm_packing_bay,		s.wms_ex_itm_low_stk_lvl,	s.wms_ex_itm_std_strg_thu_id,	s.wms_ex_itm_wave_repln_req	
		,1,								p_etljobname,					p_envsourcecd,					p_datasourcecd,				NOW()
	FROM stg.stg_wms_ex_item_hdr s
	LEFT JOIN  dwh.d_itemheader i
		ON	i.itm_code				= s.wms_ex_itm_code
		AND	i.itm_ou				= s.wms_ex_itm_ou
    LEFT JOIN dwh.d_excessitem t
    	ON 	s.wms_ex_itm_loc_code  	= t.ex_itm_loc_code
		AND s.wms_ex_itm_code 		= t.ex_itm_code
		AND s.wms_ex_itm_ou 		= t.ex_itm_ou
    WHERE t.ex_itm_loc_code IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
	IF p_rawstorageflag = 1
	THEN

	
	INSERT INTO raw.raw_wms_ex_item_hdr
	(
		wms_ex_itm_ou, 					wms_ex_itm_code, 				wms_ex_itm_loc_code, 			wms_ex_itm_desc, 			wms_ex_itm_cap_profile, 
		wms_ex_itm_zone_profile, 		wms_ex_itm_stage_profile, 		wms_ex_itm_effective_frm, 		wms_ex_itm_effective_to, 	wms_ex_itm_pick_per_tol_pos, 
		wms_ex_itm_pick_per_tol_neg, 	wms_ex_itm_pick_uom_tol_pos, 	wms_ex_itm_pick_uom_tol_neg, 	wms_ex_itm_put_per_tol_pos, wms_ex_itm_put_per_tol_neg, 
		wms_ex_itm_put_uom_tol_pos, 	wms_ex_itm_put_uom_tol_neg, 	wms_ex_itm_mininum_qty, 		wms_ex_itm_maximum_qty, 	wms_ex_itm_replen_qty, 
		wms_ex_itm_master_uom, 			wms_ex_itm_timestamp, 			wms_ex_itm_created_by, 			wms_ex_itm_created_dt, 		wms_ex_itm_modified_by, 
		wms_ex_itm_modified_dt, 		wms_ex_itm_userdefined1, 		wms_ex_itm_userdefined2, 		wms_ex_itm_userdefined3, 	wms_ex_itm_packing_bay, 
		wms_ex_itm_low_stk_lvl, 		wms_ex_itm_std_strg_thu_id, 	wms_ex_itm_stock_per_thu_id, 	wms_ex_itm_uid_prof, 		wms_ex_itm_dflt_status, 
		wms_ex_itm_wave_repln_req, 		wms_ex_itm_mul_rep_low_stk_lvl, wms_ex_itm_mul_tar_zone, 		etlcreateddatetime
	)
	SELECT 
		wms_ex_itm_ou, 					wms_ex_itm_code, 				wms_ex_itm_loc_code, 			wms_ex_itm_desc, 			wms_ex_itm_cap_profile, 
		wms_ex_itm_zone_profile, 		wms_ex_itm_stage_profile, 		wms_ex_itm_effective_frm, 		wms_ex_itm_effective_to, 	wms_ex_itm_pick_per_tol_pos, 
		wms_ex_itm_pick_per_tol_neg, 	wms_ex_itm_pick_uom_tol_pos, 	wms_ex_itm_pick_uom_tol_neg, 	wms_ex_itm_put_per_tol_pos, wms_ex_itm_put_per_tol_neg, 
		wms_ex_itm_put_uom_tol_pos, 	wms_ex_itm_put_uom_tol_neg, 	wms_ex_itm_mininum_qty, 		wms_ex_itm_maximum_qty, 	wms_ex_itm_replen_qty, 
		wms_ex_itm_master_uom, 			wms_ex_itm_timestamp, 			wms_ex_itm_created_by, 			wms_ex_itm_created_dt, 		wms_ex_itm_modified_by, 
		wms_ex_itm_modified_dt, 		wms_ex_itm_userdefined1, 		wms_ex_itm_userdefined2, 		wms_ex_itm_userdefined3, 	wms_ex_itm_packing_bay, 
		wms_ex_itm_low_stk_lvl, 		wms_ex_itm_std_strg_thu_id, 	wms_ex_itm_stock_per_thu_id, 	wms_ex_itm_uid_prof, 		wms_ex_itm_dflt_status, 
		wms_ex_itm_wave_repln_req, 		wms_ex_itm_mul_rep_low_stk_lvl, wms_ex_itm_mul_tar_zone, 		etlcreateddatetime
	FROM stg.stg_wms_ex_item_hdr;
	
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