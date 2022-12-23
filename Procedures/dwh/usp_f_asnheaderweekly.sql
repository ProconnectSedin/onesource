-- PROCEDURE: dwh.usp_f_asnheaderweekly(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_asnheaderweekly(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_asnheaderweekly(
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
    p_interval integer;

BEGIN

	SELECT d.jobname,h.envsourcecode,h.datasourcecode,d.latestbatchid,d.targetprocedurename, h.rawstorageflag,d.intervaldays
	INTO p_etljobname, p_envsourcecd, p_datasourcecd, p_batchid, p_taskname, p_rawstorageflag,p_interval
	FROM ods.controldetail d 
	INNER JOIN ods.controlheader h
		ON d.sourceid = h.sourceid
	WHERE 	d.sourceid 		= p_sourceId 
		AND d.dataflowflag 	= p_dataflowflag
		AND d.targetobject 	= p_targetobject;

    SELECT COUNT(1) INTO srccnt
	FROM stg.stg_wms_asn_header;

	UPDATE dwh.f_asnheader t
    SET 
          asn_loc_key                   = COALESCE(l.loc_key,-1)
        , asn_date_key                  = COALESCE(d.datekey,-1)
        , asn_cust_key                  = COALESCE(c.customer_key,-1)
        , asn_supp_key                  = COALESCE(v.vendor_key,-1)
		, asn_prefdoc_type 				= s.wms_asn_prefdoc_type
		, asn_prefdoc_no 				= s.wms_asn_prefdoc_no
		, asn_prefdoc_date 				= s.wms_asn_prefdoc_date
		, asn_date 						= s.wms_asn_date
		, asn_status 					= s.wms_asn_status
		, asn_operation_status 			= s.wms_asn_operation_status
		, asn_ib_order 					= s.wms_asn_ib_order
		, asn_ship_frm 					= s.wms_asn_ship_frm
		, asn_ship_date 				= s.wms_asn_ship_date
		, asn_dlv_loc 					= s.wms_asn_dlv_loc
		, asn_dlv_date 					= s.wms_asn_dlv_date
		, asn_sup_asn_no 				= s.wms_asn_sup_asn_no
		, asn_sup_asn_date 				= s.wms_asn_sup_asn_date
		, asn_sent_by 					= s.wms_asn_sent_by
		, asn_rem 						= s.wms_asn_rem
		, asn_shp_ref_typ 				= s.wms_asn_shp_ref_typ
		, asn_shp_ref_no 				= s.wms_asn_shp_ref_no
		, asn_shp_ref_date 				= s.wms_asn_shp_ref_date
		, asn_shp_carrier 				= s.wms_asn_shp_carrier
		, asn_shp_mode 					= s.wms_asn_shp_mode
		, asn_shp_vh_typ 				= s.wms_asn_shp_vh_typ
		, asn_shp_vh_no 				= s.wms_asn_shp_vh_no
		, asn_shp_eqp_typ 				= s.wms_asn_shp_eqp_typ
		, asn_shp_eqp_no 				= s.wms_asn_shp_eqp_no
		, asn_shp_grs_wt 				= s.wms_asn_shp_grs_wt
		, asn_shp_nt_wt 				= s.wms_asn_shp_nt_wt
		, asn_shp_wt_uom 				= s.wms_asn_shp_wt_uom
		, asn_shp_vol 					= s.wms_asn_shp_vol
		, asn_shp_vol_uom 				= s.wms_asn_shp_vol_uom
		, asn_shp_pallt 				= s.wms_asn_shp_pallt
		, asn_shp_rem 					= s.wms_asn_shp_rem
		, asn_cnt_typ 					= s.wms_asn_cnt_typ
		, asn_cnt_no 					= s.wms_asn_cnt_no
		, asn_cnt_qtyp 					= s.wms_asn_cnt_qtyp
		, asn_cnt_qsts 					= s.wms_asn_cnt_qsts
		, asn_timestamp 				= s.wms_asn_timestamp
		, asn_usrdf1 					= s.wms_asn_usrdf1
		, asn_usrdf2 					= s.wms_asn_usrdf2
		, asn_usrdf3 					= s.wms_asn_usrdf3
		, asn_createdby 				= s.wms_asn_createdby
		, asn_created_date 				= s.wms_asn_created_date
		, asn_modifiedby 				= s.wms_asn_modifiedby
		, asn_modified_date 			= s.wms_asn_modified_date
		, asn_gen_frm 					= s.wms_asn_gen_frm
		, asn_release_date 				= s.wms_asn_release_date
		, asn_release_number 			= s.wms_asn_release_number
		, asn_block_stage 				= s.wms_asn_block_stage
		, asn_amendno 					= s.wms_asn_amendno
		, asn_cust_code 				= s.wms_asn_cust_code
		, asn_supp_code 				= s.wms_asn_supp_code
		, asn_quaran_bil_status 		= s.wms_asn_quaran_bil_status
		, dock_no 						= s.wms_dock_no
		, total_value				 	= s.wms_total_value
		, asn_gate_no 					= s.wms_asn_gate_no
		, asn_type 						= s.wms_asn_type
		, asn_wchboinv_bil_status 		= s.wms_asn_wchboinv_bil_status
		, asn_adfepasn_bil_status 		= s.wms_asn_adfepasn_bil_status
		, asn_reason_code 				= s.wms_asn_reason_code
		, asn_whimchpd_sell_bil_status 	= s.wms_asn_whimchpd_sell_bil_status
		, asn_wichbain_sell_bil_status 	= s.wms_asn_wichbain_sell_bil_status
		, asn_STPCGTHU_bil_status 		= s.wms_asn_STPCGTHU_bil_status
		, etlactiveind 					= 1
		, etljobname 					= p_etljobname
		, envsourcecd 					= p_envsourcecd
		, datasourcecd 					= p_datasourcecd
		, etlupdatedatetime 			= NOW()	
    FROM stg.stg_wms_asn_header s
	LEFT JOIN dwh.d_location L 		
		ON s.wms_asn_location 	= L.loc_code 
        AND s.wms_asn_ou        = L.loc_ou
	LEFT JOIN dwh.d_date D 			
		ON s.wms_asn_date::date = D.dateactual
	LEFT JOIN dwh.d_customer C 		
		ON s.wms_asn_cust_code  = C.customer_id 
        AND s.wms_asn_ou        = C.customer_ou
	LEFT JOIN dwh.d_vendor V 		
		ON s.wms_asn_supp_code  = V.vendor_id 
        AND s.wms_asn_ou        = V.vendor_ou	
    WHERE t.asn_ou 						= s.wms_asn_ou
		AND t.asn_location 				= s.wms_asn_location
		AND t.asn_no 					= s.wms_asn_no;
    
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;
	
/*
	
	DELETE FROM dwh.f_asnheader FH
	using stg.stg_wms_asn_header AH
		WHERE  FH.asn_ou 			= AH.wms_asn_ou 
		AND FH.asn_location 		= AH.wms_asn_location 
		AND FH.asn_no 				= AH.wms_asn_no;
-- 	 	AND COALESCE(asn_modified_date,asn_created_date)::DATE >= (CURRENT_DATE - INTERVAL '90 days')::DATE;
*/
	INSERT INTO dwh.f_asnheader
	(
		  asn_loc_key							, asn_date_key							, asn_cust_key					, asn_supp_key 					, asn_ou
		, asn_location							, asn_no								, asn_prefdoc_type				, asn_prefdoc_no				, asn_prefdoc_date
		, asn_date								, asn_status							, asn_operation_status			, asn_ib_order					, asn_ship_frm
		, asn_ship_date							, asn_dlv_loc							, asn_dlv_date					, asn_sup_asn_no				, asn_sup_asn_date
		, asn_sent_by							, asn_rem								, asn_shp_ref_typ				, asn_shp_ref_no				, asn_shp_ref_date
		, asn_shp_carrier						, asn_shp_mode							, asn_shp_vh_typ				, asn_shp_vh_no					, asn_shp_eqp_typ
		, asn_shp_eqp_no						, asn_shp_grs_wt						, asn_shp_nt_wt					, asn_shp_wt_uom				, asn_shp_vol
		, asn_shp_vol_uom						, asn_shp_pallt							, asn_shp_rem					, asn_cnt_typ					, asn_cnt_no
		, asn_cnt_qtyp							, asn_cnt_qsts							, asn_timestamp					, asn_usrdf1					, asn_usrdf2
		, asn_usrdf3							, asn_createdby							, asn_created_date				, asn_modifiedby				, asn_modified_date
		, asn_gen_frm							, asn_release_date						, asn_release_number			, asn_block_stage				, asn_amendno
		, asn_cust_code							, asn_supp_code							, asn_quaran_bil_status			, dock_no						, total_value
		, asn_gate_no							, asn_type								, asn_wchboinv_bil_status		, asn_adfepasn_bil_status		, asn_reason_code
		, asn_whimchpd_sell_bil_status			, asn_wichbain_sell_bil_status			, asn_stpcgthu_bil_status		, etlactiveind					, etljobname
		, envsourcecd							, datasourcecd							, etlcreatedatetime
	)
	
	SELECT 
	   	  COALESCE(L.loc_key,-1)				, D.datekey								, COALESCE(C.customer_key,-1)	, COALESCE(V.vendor_key,-1)		, AH.wms_asn_ou
		, AH.wms_asn_location					, AH.wms_asn_no							, AH.wms_asn_prefdoc_type		, AH.wms_asn_prefdoc_no			, AH.wms_asn_prefdoc_date
		, AH.wms_asn_date						, AH.wms_asn_status						, AH.wms_asn_operation_status	, AH.wms_asn_ib_order			, AH.wms_asn_ship_frm
		, AH.wms_asn_ship_date					, AH.wms_asn_dlv_loc					, AH.wms_asn_dlv_date			, AH.wms_asn_sup_asn_no			, AH.wms_asn_sup_asn_date
		, AH.wms_asn_sent_by					, AH.wms_asn_rem						, AH.wms_asn_shp_ref_typ		, AH.wms_asn_shp_ref_no			, AH.wms_asn_shp_ref_date
		, AH.wms_asn_shp_carrier				, AH.wms_asn_shp_mode					, AH.wms_asn_shp_vh_typ			, AH.wms_asn_shp_vh_no			, AH.wms_asn_shp_eqp_typ
		, AH.wms_asn_shp_eqp_no					, AH.wms_asn_shp_grs_wt					, AH.wms_asn_shp_nt_wt			, AH.wms_asn_shp_wt_uom			, AH.wms_asn_shp_vol
		, AH.wms_asn_shp_vol_uom				, AH.wms_asn_shp_pallt					, AH.wms_asn_shp_rem			, AH.wms_asn_cnt_typ			, AH.wms_asn_cnt_no
		, AH.wms_asn_cnt_qtyp					, AH.wms_asn_cnt_qsts					, AH.wms_asn_timestamp			, AH.wms_asn_usrdf1				, AH.wms_asn_usrdf2
		, AH.wms_asn_usrdf3						, AH.wms_asn_createdby					, AH.wms_asn_created_date		, AH.wms_asn_modifiedby			, AH.wms_asn_modified_date
		, AH.wms_asn_gen_frm					, AH.wms_asn_release_date				, AH.wms_asn_release_number		, AH.wms_asn_block_stage		, AH.wms_asn_amendno
		, AH.wms_asn_cust_code					, AH.wms_asn_supp_code					, AH.wms_asn_quaran_bil_status	, AH.wms_dock_no				, AH.wms_total_value
		, AH.wms_asn_gate_no					, AH.wms_asn_type						, AH.wms_asn_wchboinv_bil_status, AH.wms_asn_adfepasn_bil_status, AH.wms_asn_reason_code
		, AH.wms_asn_whimchpd_sell_bil_status	, AH.wms_asn_wichbain_sell_bil_status	, AH.wms_asn_stpcgthu_bil_status, 1 AS etlactiveind				, p_etljobname
		, p_envsourcecd							, p_datasourcecd						, NOW()
	FROM stg.stg_wms_asn_header AH
	LEFT JOIN dwh.d_location L 		
		ON AH.wms_asn_location 	    = L.loc_code 
        AND AH.wms_asn_ou           = L.loc_ou
	LEFT JOIN dwh.d_date D 			
		ON AH.wms_asn_date::date 	= D.dateactual
	LEFT JOIN dwh.d_customer C 		
		ON AH.wms_asn_cust_code	    = C.customer_id 
        AND AH.wms_asn_ou           = C.customer_ou
	LEFT JOIN dwh.d_vendor V 		
		ON AH.wms_asn_supp_code 	= V.vendor_id 
        AND AH.wms_asn_ou           = V.vendor_ou
	LEFT JOIN dwh.f_asnheader FH 	
		ON  FH.asn_ou 				= AH.wms_asn_ou 
		AND FH.asn_location 		= AH.wms_asn_location 
		AND FH.asn_no 				= AH.wms_asn_no
   WHERE FH.asn_no IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
--	select 0 into updcnt;  
	
	 UPDATE dwh.f_asnheader t1
     SET etlactiveind =  0,
     etlupdatedatetime = Now()::timestamp
     FROM dwh.f_asnheader t
     LEFT join stg.stg_wms_asn_header s
     ON t.asn_ou                        = s.wms_asn_ou
     AND t.asn_location              = s.wms_asn_location
     AND t.asn_no                    = s.wms_asn_no
     WHERE t.asn_hr_key = t1.asn_hr_key
     AND   COALESCE(t.etlupdatedatetime,t.etlcreatedatetime)::date >= NOW()::DATE
     AND  s.wms_asn_no is null;

	
    IF p_rawstorageflag = 1
    THEN
	
	INSERT INTO raw.raw_wms_asn_header
	(
		wms_asn_ou				, wms_asn_location					, wms_asn_no						, wms_asn_prefdoc_type			, wms_asn_prefdoc_no, 
		wms_asn_prefdoc_date	, wms_asn_date						, wms_asn_status					, wms_asn_operation_status		, wms_asn_ib_order, 
		wms_asn_ship_frm		, wms_asn_ship_date					, wms_asn_dlv_loc					, wms_asn_dlv_date				, wms_asn_sup_asn_no, 
		wms_asn_sup_asn_date	, wms_asn_sent_by					, wms_asn_rem						, wms_asn_shp_ref_typ			, wms_asn_shp_ref_no, 
		wms_asn_shp_ref_date	, wms_asn_shp_carrier				, wms_asn_shp_mode					, wms_asn_shp_vh_typ			, wms_asn_shp_vh_no, 
		wms_asn_shp_eqp_typ		, wms_asn_shp_eqp_no				, wms_asn_shp_grs_wt				, wms_asn_shp_nt_wt				, wms_asn_shp_wt_uom, 
		wms_asn_shp_vol			, wms_asn_shp_vol_uom				, wms_asn_shp_pallt					, wms_asn_shp_rem				, wms_asn_cnt_typ, 
		wms_asn_cnt_no			, wms_asn_cnt_qtyp					, wms_asn_cnt_qsts					, wms_asn_timestamp				, wms_asn_usrdf1, 
		wms_asn_usrdf2			, wms_asn_usrdf3					, wms_asn_createdby					, wms_asn_created_date			, wms_asn_modifiedby, 
		wms_asn_modified_date	, wms_asn_gen_frm					, wms_asn_release_date				, wms_asn_release_number		, wms_asn_block_stage, 
		wms_asn_amendno			, wms_asn_cust_code					, wms_asn_supp_code					, wms_asn_quaran_bil_status		, wms_dock_no, 
		wms_total_value			, wms_asn_gate_no					, wms_asn_type						, wms_asn_wchboinv_bil_status	, wms_asn_adfepasn_bil_status, 
		wms_asn_reason_code		, wms_asn_whimchpd_sell_bil_status	, wms_asn_wichbain_sell_bil_status	, wms_asn_stpcgthu_bil_status	, etlcreateddatetime
	
	)
	SELECT 
		wms_asn_ou				, wms_asn_location					, wms_asn_no						, wms_asn_prefdoc_type			, wms_asn_prefdoc_no, 
		wms_asn_prefdoc_date	, wms_asn_date						, wms_asn_status					, wms_asn_operation_status		, wms_asn_ib_order, 
		wms_asn_ship_frm		, wms_asn_ship_date					, wms_asn_dlv_loc					, wms_asn_dlv_date				, wms_asn_sup_asn_no, 
		wms_asn_sup_asn_date	, wms_asn_sent_by					, wms_asn_rem						, wms_asn_shp_ref_typ			, wms_asn_shp_ref_no, 
		wms_asn_shp_ref_date	, wms_asn_shp_carrier				, wms_asn_shp_mode					, wms_asn_shp_vh_typ			, wms_asn_shp_vh_no, 
		wms_asn_shp_eqp_typ		, wms_asn_shp_eqp_no				, wms_asn_shp_grs_wt				, wms_asn_shp_nt_wt				, wms_asn_shp_wt_uom, 
		wms_asn_shp_vol			, wms_asn_shp_vol_uom				, wms_asn_shp_pallt					, wms_asn_shp_rem				, wms_asn_cnt_typ, 
		wms_asn_cnt_no			, wms_asn_cnt_qtyp					, wms_asn_cnt_qsts					, wms_asn_timestamp				, wms_asn_usrdf1, 
		wms_asn_usrdf2			, wms_asn_usrdf3					, wms_asn_createdby					, wms_asn_created_date			, wms_asn_modifiedby, 
		wms_asn_modified_date	, wms_asn_gen_frm					, wms_asn_release_date				, wms_asn_release_number		, wms_asn_block_stage, 
		wms_asn_amendno			, wms_asn_cust_code					, wms_asn_supp_code					, wms_asn_quaran_bil_status		, wms_dock_no, 
		wms_total_value			, wms_asn_gate_no					, wms_asn_type						, wms_asn_wchboinv_bil_status	, wms_asn_adfepasn_bil_status, 
		wms_asn_reason_code		, wms_asn_whimchpd_sell_bil_status	, wms_asn_wichbain_sell_bil_status	, wms_asn_stpcgthu_bil_status	, etlcreateddatetime
	FROM stg.stg_wms_asn_header;
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
ALTER PROCEDURE dwh.usp_f_asnheaderweekly(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
