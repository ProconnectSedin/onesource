-- PROCEDURE: dwh.usp_f_outbounditemdetailweekly(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_outbounditemdetailweekly(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_outbounditemdetailweekly(
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
	 p_depsource VARCHAR(100);
    p_rawstorageflag integer;
	p_interval integer;

BEGIN

	SELECT d.jobname,h.envsourcecode,h.datasourcecode,d.latestbatchid,d.targetprocedurename, h.rawstorageflag ,h.depsource, d.intervaldays

	INTO p_etljobname, p_envsourcecd, p_datasourcecd, p_batchid, p_taskname, p_rawstorageflag,p_depsource,p_interval
	FROM ods.controldetail d 
	INNER JOIN ods.controlheader h
		ON d.sourceid = h.sourceid
	WHERE 	d.sourceid 		= p_sourceId 
		AND d.dataflowflag 	= p_dataflowflag
		AND d.targetobject 	= p_targetobject;
		
  IF EXISTS(SELECT 1 FROM ods.controlheader WHERE sourceid = p_depsource AND status = 'Completed' 
                    AND CAST(COALESCE(lastupdateddate,createddate) AS DATE) >= NOW()::DATE)
    THEN		

    SELECT COUNT(1) INTO srccnt
	FROM stg.stg_wms_outbound_item_detail;

	UPDATE dwh.f_outboundItemDetail t
    SET 
	obh_hr_key               = oh.obh_hr_key,
    obd_itm_key              = COALESCE(l.itm_hdr_key,-1),
    obd_loc_key              = COALESCE(c.loc_key,-1),              
    oub_item_code            =  s.wms_oub_item_code,
    oub_itm_order_qty        =  s.wms_oub_itm_order_qty,
    oub_itm_sch_type         =  s.wms_oub_itm_sch_type,
    oub_itm_balqty           =  s.wms_oub_itm_balqty,
    oub_itm_issueqty         =  s.wms_oub_itm_issueqty,
    oub_itm_processqty       =  s.wms_oub_itm_processqty,
    oub_itm_masteruom        =  s.wms_oub_itm_masteruom,
    oub_itm_deliverydate     =  s.wms_oub_itm_deliverydate,
    oub_itm_plan_gd_iss_dt   =  s.wms_oub_itm_plan_gd_iss_dt,
    oub_itm_sub_rules        =  s.wms_oub_itm_sub_rules,
    oub_itm_pack_remarks     =  s.wms_oub_itm_pack_remarks,
    oub_itm_mas_qty          =  s.wms_oub_itm_mas_qty,
    oub_itm_order_item       =  s.wms_oub_itm_order_item,
    oub_itm_lotsl_batchno    =  s.wms_oub_itm_lotsl_batchno,
    oub_itm_cus_srno         =  s.wms_oub_itm_cus_srno,
    oub_itm_refdocno1        =  s.wms_oub_itm_refdocno1,
    oub_itm_refdocno2        =  s.wms_oub_itm_refdocno2,
    oub_itm_serialno         =  s.wms_oub_itm_serialno,
    oub_itm_thu_id           =  s.wms_oub_itm_thu_id,
    oub_itm_thu_srno         =  s.wms_oub_itm_thu_srno,
    oub_itm_inst             =  s.wms_oub_itm_inst,
    oub_itm_user_def_1       =  s.wms_oub_itm_user_def_1,
    oub_itm_user_def_2       =  s.wms_oub_itm_user_def_2,
    oub_itm_user_def_3       =  s.wms_oub_itm_user_def_3,
    oub_itm_stock_sts        =  s.wms_oub_itm_stock_sts,
    oub_itm_cust             =  s.wms_oub_itm_cust,
    oub_itm_coo_ml           =  s.wms_oub_itm_coo_ml,
    oub_itm_arribute1        =  s.wms_oub_itm_arribute1,
    oub_itm_arribute2        =  s.wms_oub_itm_arribute2,
    oub_itm_cancel           =  s.wms_oub_itm_cancel,
    oub_itm_cancel_code      =  s.wms_oub_itm_cancel_code,
    oub_itm_component        =  s.wms_oub_itm_component,
		etlactiveind 				    	= 1
		, etljobname 				    	= p_etljobname
		, envsourcecd 				  	= p_envsourcecd
		, datasourcecd 				  	= p_datasourcecd
		, etlupdatedatetime 			= NOW()	
    FROM stg.stg_wms_outbound_item_detail s
	INNER JOIN dwh.f_outboundheader oh
		ON s.wms_oub_itm_loc_code = oh.oub_loc_code 
		and s.wms_oub_outbound_ord =oh.oub_outbound_ord
		and s.wms_oub_itm_ou = oh.oub_ou
	LEFT JOIN dwh.d_itemheader L 		
		ON s.wms_oub_item_code 	     = L.itm_code 
        AND s.wms_oub_itm_ou      = L.itm_ou
	LEFT JOIN dwh.d_location C 		
		ON s.wms_oub_itm_loc_code  = C.loc_code 
        AND s.wms_oub_itm_ou        = C.loc_ou
    WHERE  
    t.oub_itm_loc_code          =  s.wms_oub_itm_loc_code
    AND t.oub_outbound_ord		 =  s.wms_oub_outbound_ord
    AND t.oub_itm_ou 			 =  s.wms_oub_itm_ou
    AND t.oub_itm_lineno           =  s.wms_oub_itm_lineno
	AND t.obh_hr_key    =            oh.obh_hr_key;
	
	GET DIAGNOSTICS updcnt = ROW_COUNT;
/*
		DELETE FROM dwh.f_outboundItemDetail FH
		USING stg.stg_wms_outbound_item_detail OD
			WHERE 	FH.oub_itm_ou 		 	=  OD.wms_oub_itm_ou
			AND   	FH.oub_itm_loc_code   	=  OD.wms_oub_itm_loc_code
			AND 	FH.oub_outbound_ord	 	=  OD.wms_oub_outbound_ord
			AND 	FH.oub_itm_lineno    	=  OD.wms_oub_itm_lineno;
-- 		AND COALESCE(oh.oub_modified_date,oh.oub_created_date)::DATE >= (CURRENT_DATE - INTERVAL '90 days')::DATE;
*/
	INSERT INTO dwh.f_outboundItemDetail
	(obh_hr_key				,			obd_itm_key    	,				obd_loc_key  ,
	 oub_itm_volume			, 			oub_itm_weight	,
     oub_itm_loc_code,               oub_itm_ou,         oub_outbound_ord,               oub_itm_lineno,          
     oub_item_code,                  oub_itm_order_qty,          oub_itm_sch_type,               oub_itm_balqty,          
     oub_itm_issueqty,               oub_itm_processqty,       oub_itm_masteruom,              oub_itm_deliverydate,       
     oub_itm_plan_gd_iss_dt,         oub_itm_sub_rules,         oub_itm_pack_remarks,           oub_itm_mas_qty,         
     oub_itm_order_item,             oub_itm_lotsl_batchno,         oub_itm_cus_srno,               oub_itm_refdocno1,          
     oub_itm_refdocno2,              oub_itm_serialno,           oub_itm_thu_id,                 oub_itm_thu_srno,          
     oub_itm_inst,                   oub_itm_user_def_1,          oub_itm_user_def_2,             oub_itm_user_def_3,      
     oub_itm_stock_sts,              oub_itm_cust,          oub_itm_coo_ml,                 oub_itm_arribute1,         
     oub_itm_arribute2,              oub_itm_cancel,         oub_itm_cancel_code,            oub_itm_component,        
     etlactiveind,			         etljobname,
     envsourcecd,                    datasourcecd,     
     etlcreatedatetime
	)
	
	SELECT 

 	   oh.obh_hr_key				, 			COALESCE(L.itm_hdr_key,-1)	,		COALESCE(c.loc_key,-1),
	   (L.itm_length*L.itm_breadth*L.itm_height) ,	L.itm_weight			,
      OD.wms_oub_itm_loc_code,                   OD.wms_oub_itm_ou,       OD.wms_oub_outbound_ord,                   OD.wms_oub_itm_lineno,  
      OD.wms_oub_item_code,                      OD.wms_oub_itm_order_qty,   OD.wms_oub_itm_sch_type,                   OD.wms_oub_itm_balqty,     
      OD.wms_oub_itm_issueqty,                   OD.wms_oub_itm_processqty,  OD.wms_oub_itm_masteruom,                  OD.wms_oub_itm_deliverydate, 
      OD.wms_oub_itm_plan_gd_iss_dt,             OD.wms_oub_itm_sub_rules,  OD.wms_oub_itm_pack_remarks,               OD.wms_oub_itm_mas_qty,     
      OD.wms_oub_itm_order_item,                 OD.wms_oub_itm_lotsl_batchno,   OD.wms_oub_itm_cus_srno,                   OD.wms_oub_itm_refdocno1,       
      OD.wms_oub_itm_refdocno2,                  OD.wms_oub_itm_serialno,        OD.wms_oub_itm_thu_id,                     OD.wms_oub_itm_thu_srno,          
      OD.wms_oub_itm_inst,                       OD.wms_oub_itm_user_def_1,          OD.wms_oub_itm_user_def_2,                 OD.wms_oub_itm_user_def_3,    
      OD.wms_oub_itm_stock_sts,                  OD.wms_oub_itm_cust,         OD.wms_oub_itm_coo_ml,                     OD.wms_oub_itm_arribute1,        
      OD.wms_oub_itm_arribute2,                  OD.wms_oub_itm_cancel,        OD.wms_oub_itm_cancel_code,                OD.wms_oub_itm_component,    
      1 AS etlactiveind,				          p_etljobname,
		p_envsourcecd							, p_datasourcecd,         
        NOW()
	FROM stg.stg_wms_outbound_item_detail OD
	INNER JOIN dwh.f_outboundheader oh
		ON OD.wms_oub_itm_ou = oh.oub_ou 
		and OD.wms_oub_itm_loc_code = oh.oub_loc_code
		and OD.wms_oub_outbound_ord =oh.oub_outbound_ord
    LEFT JOIN dwh.d_itemheader L 		
		ON OD.wms_oub_item_code		= L.itm_code 
        AND OD.wms_oub_itm_ou		= L.itm_ou
	LEFT JOIN dwh.d_location C 		
		ON OD.wms_oub_itm_loc_code  = C.loc_code 
        AND OD.wms_oub_itm_ou        = C.loc_ou
	LEFT JOIN dwh.f_outboundItemDetail FH 	
		ON FH.oub_itm_loc_code   =  OD.wms_oub_itm_loc_code
		AND FH.oub_outbound_ord	 =  OD.wms_oub_outbound_ord
		AND FH.oub_itm_ou 		 =  OD.wms_oub_itm_ou
		AND FH.oub_itm_lineno    =  OD.wms_oub_itm_lineno
		AND FH.obh_hr_key    	=  oh.obh_hr_key
    WHERE FH.oub_itm_loc_code IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
	
-- 	UPDATE dwh.f_outboundItemDetail t1
-- 	set etlactiveind =  0,
-- 	etlupdatedatetime = Now()::timestamp
-- 	from dwh.f_outboundItemDetail t
-- 	left join stg.stg_wms_outbound_item_detail s
-- 	on t.oub_itm_loc_code          =  s.wms_oub_itm_loc_code
--     AND t.oub_outbound_ord		 =  s.wms_oub_outbound_ord
--     AND t.oub_itm_ou 			 =  s.wms_oub_itm_ou
--     AND t.oub_itm_lineno           =  s.wms_oub_itm_lineno
-- 	and t.obh_hr_key			  = t1.obh_hr_key	
-- 	where COALESCE(t.etlupdatedatetime,t.etlcreatedatetime)::date >= NOW()::DATE
-- 	and s.wms_oub_itm_ou is null;
	
	--GET DIAGNOSTICS updcnt = ROW_COUNT;
/*	
	UPDATE dwh.f_outboundItemDetail od 
	SET obh_hr_key = oh.obh_hr_key,
		etlupdatedatetime 	= NOW()
	FROM dwh.f_outboundheader oh 
	WHERE od.oub_itm_ou = oh.oub_ou 
	and od.oub_itm_loc_code = oh.oub_loc_code 
	and od.oub_outbound_ord =oh.oub_outbound_ord 
	AND COALESCE(oh.oub_modified_date,oh.oub_created_date)::DATE >= (CURRENT_DATE - INTERVAL '90 days')::DATE;

	--GET DIAGNOSTICS updcnt = ROW_COUNT;
	select 0 into updcnt;
*/
    IF p_rawstorageflag = 1
    THEN
	
	INSERT INTO raw.raw_wms_outbound_item_detail
	(
		wms_oub_itm_loc_code,     wms_oub_itm_ou,     wms_oub_outbound_ord,     wms_oub_itm_lineno,     wms_oub_item_code,     wms_oub_itm_order_qty,     wms_oub_itm_sch_type,     wms_oub_itm_balqty,     wms_oub_itm_issueqty,     wms_oub_itm_processqty,     wms_oub_itm_masteruom,     wms_oub_itm_deliverydate,     wms_oub_itm_serfrom,     wms_oub_itm_serto,     wms_oub_itm_plan_gd_iss_dt,     wms_oub_itm_plan_dt_iss,     wms_oub_itm_sub_rules,     wms_oub_itm_pack_remarks,     wms_oub_itm_su,     wms_oub_itm_cust_itm_code,     wms_oub_itm_mas_qty,     wms_oub_itm_order_item,     wms_oub_itm_lotsl_batchno,     wms_oub_itm_cus_srno,     wms_oub_itm_refdocno1,     wms_oub_itm_refdocno2,     wms_oub_itm_serialno,     wms_oub_itm_thu_id,     wms_oub_itm_thu_srno,     wms_oub_itm_inst,     wms_oub_itm_uid_serial_no,     wms_oub_itm_tolerance,     wms_oub_itm_user_def_1,     wms_oub_itm_user_def_2,     wms_oub_itm_user_def_3,     wms_oub_itm_shelflife,     wms_oub_itm_stock_sts,     wms_oub_break_attribute,     wms_oub_country_of_origin,     wms_oub_itm_cust,     wms_oub_itm_inv_type,     wms_oub_itm_coo_ml,     wms_oub_itm_arribute1,     wms_oub_itm_arribute2,     wms_oub_itm_arribute3,     wms_oub_itm_arribute4,     wms_oub_itm_arribute5,     wms_oub_itm_prod_status,     wms_oub_itm_cancel,     wms_oub_itm_cancel_code,     wms_oub_opbopitp_bil_status,     wms_oub_gmvchrgs_sell_bil_status,     wms_oub_gmvchrgs_buy_bil_status,     wms_oub_itm_component,     wms_oub_shchdrop_buy_bil_status,     wms_oub_gmvcdrop_buy_bil_status,     wms_oub_gmvcdrop_sell_bil_status,     wms_oub_shchdrop_sell_bil_status,     wms_oub_itm_kit_lineno,     wms_oub_itm_ratio,     wms_oub_txchsdrs_sell_bil_status,     wms_oub_txchsdrb_buy_bil_status,     wms_oub_itm_wave_no,     wms_oub_ccmiorfe_sell_bil_status,     wms_oub_gmvchmus_sell_bil_status,     wms_oub_ccaufbos_sell_bil_status,     wms_oub_ffcgvsml_sell_bil_status,     wms_oub_markmior_sell_bil_status,     wms_oub_markaufe_sell_bil_status,     wms_oub_gmvchmus_buy_bil_status,     wms_oub_txcsemse_buy_bil_status,     wms_oub_itm_arribute6,     wms_oub_itm_arribute7,     wms_oub_itm_arribute8,     wms_oub_itm_arribute9,     wms_oub_itm_arribute10,     wms_oub_cupkslch_sell_bil_status      ,etlcreateddatetime
	)
	SELECT 
		wms_oub_itm_loc_code,     wms_oub_itm_ou,     wms_oub_outbound_ord,     wms_oub_itm_lineno,     wms_oub_item_code,     wms_oub_itm_order_qty,     wms_oub_itm_sch_type,     wms_oub_itm_balqty,     wms_oub_itm_issueqty,     wms_oub_itm_processqty,     wms_oub_itm_masteruom,     wms_oub_itm_deliverydate,     wms_oub_itm_serfrom,     wms_oub_itm_serto,     wms_oub_itm_plan_gd_iss_dt,     wms_oub_itm_plan_dt_iss,     wms_oub_itm_sub_rules,     wms_oub_itm_pack_remarks,     wms_oub_itm_su,     wms_oub_itm_cust_itm_code,     wms_oub_itm_mas_qty,     wms_oub_itm_order_item,     wms_oub_itm_lotsl_batchno,     wms_oub_itm_cus_srno,     wms_oub_itm_refdocno1,     wms_oub_itm_refdocno2,     wms_oub_itm_serialno,     wms_oub_itm_thu_id,     wms_oub_itm_thu_srno,     wms_oub_itm_inst,     wms_oub_itm_uid_serial_no,     wms_oub_itm_tolerance,     wms_oub_itm_user_def_1,     wms_oub_itm_user_def_2,     wms_oub_itm_user_def_3,     wms_oub_itm_shelflife,     wms_oub_itm_stock_sts,     wms_oub_break_attribute,     wms_oub_country_of_origin,     wms_oub_itm_cust,     wms_oub_itm_inv_type,     wms_oub_itm_coo_ml,     wms_oub_itm_arribute1,     wms_oub_itm_arribute2,     wms_oub_itm_arribute3,     wms_oub_itm_arribute4,     wms_oub_itm_arribute5,     wms_oub_itm_prod_status,     wms_oub_itm_cancel,     wms_oub_itm_cancel_code,     wms_oub_opbopitp_bil_status,     wms_oub_gmvchrgs_sell_bil_status,     wms_oub_gmvchrgs_buy_bil_status,     wms_oub_itm_component,     wms_oub_shchdrop_buy_bil_status,     wms_oub_gmvcdrop_buy_bil_status,     wms_oub_gmvcdrop_sell_bil_status,     wms_oub_shchdrop_sell_bil_status,     wms_oub_itm_kit_lineno,     wms_oub_itm_ratio,     wms_oub_txchsdrs_sell_bil_status,     wms_oub_txchsdrb_buy_bil_status,     wms_oub_itm_wave_no,     wms_oub_ccmiorfe_sell_bil_status,     wms_oub_gmvchmus_sell_bil_status,     wms_oub_ccaufbos_sell_bil_status,     wms_oub_ffcgvsml_sell_bil_status,     wms_oub_markmior_sell_bil_status,     wms_oub_markaufe_sell_bil_status,     wms_oub_gmvchmus_buy_bil_status,     wms_oub_txcsemse_buy_bil_status,     wms_oub_itm_arribute6,     wms_oub_itm_arribute7,     wms_oub_itm_arribute8,     wms_oub_itm_arribute9,     wms_oub_itm_arribute10,     wms_oub_cupkslch_sell_bil_status      ,etlcreateddatetime
	FROM stg.stg_wms_outbound_item_detail;
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
ALTER PROCEDURE dwh.usp_f_outbounditemdetailweekly(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
