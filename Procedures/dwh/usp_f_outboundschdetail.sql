-- PROCEDURE: dwh.usp_f_outboundschdetail(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_outboundschdetail(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_outboundschdetail(
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

BEGIN

	SELECT d.jobname,h.envsourcecode,h.datasourcecode,d.latestbatchid,d.targetprocedurename, h.rawstorageflag ,h.depsource
	INTO p_etljobname, p_envsourcecd, p_datasourcecd, p_batchid, p_taskname, p_rawstorageflag ,p_depsource
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
	FROM stg.stg_wms_outbound_sch_dtl;

	UPDATE dwh.f_outboundSchDetail t
    SET  
		obh_hr_key                        =  sb.obh_hr_key,
    	oub_loc_key					        = COALESCE(l.loc_key,-1),
    	oub_itm_key                        = COALESCE(c.itm_hdr_key,-1),
		oub_sch_item_code                   =   s.wms_oub_sch_item_code,
		oub_sch_order_qty                   =   s.wms_oub_sch_order_qty,
		oub_sch_masteruom                   =   s.wms_oub_sch_masteruom,
		oub_sch_deliverydate                =   s.wms_oub_sch_deliverydate,
		oub_sch_serfrom                     =   s.wms_oub_sch_serfrom,
		oub_sch_serto                       =   s.wms_oub_sch_serto,
		oub_sch_plan_gd_iss_dt              =   s.wms_oub_sch_plan_gd_iss_dt,
		oub_sch_plan_gd_iss_time            =   s.wms_oub_sch_plan_gd_iss_time,
		oub_sch_operation_status            =   s.wms_oub_sch_operation_status,
		oub_sch_picked_qty                 	=   s.wms_oub_sch_picked_qty,
		oub_sch_packed_qty                 	=   s.wms_oub_sch_packed_qty,
		oub_sch_masteruomqty_ml            	=   s.wms_oub_sch_masteruomqty_ml,
		oub_sch_orderuom_ml                	=   s.wms_oub_sch_orderuom_ml,
		etlactiveind 					= 1
		, etljobname 					= p_etljobname
		, envsourcecd 					= p_envsourcecd
		, datasourcecd 					= p_datasourcecd
		, etlupdatedatetime 			= NOW()	
    FROM stg.stg_wms_outbound_sch_dtl s
	INNER JOIN dwh.f_outboundheader sb
		ON s.wms_oub_sch_loc_code = sb.oub_loc_code 
		and s.wms_oub_outbound_ord =sb.oub_outbound_ord
		and s.wms_oub_sch_ou = sb.oub_ou
	LEFT JOIN dwh.d_location L 		
		ON s.wms_oub_sch_loc_code 	= L.loc_code 
        AND s.wms_oub_sch_ou        = L.loc_ou
    LEFT JOIN dwh.d_itemheader C 		
		ON s.wms_oub_sch_item_code 	     = C.itm_code 
    	AND s.wms_oub_sch_ou             = C.itm_ou
    WHERE	t.oub_sch_loc_code        =   s.wms_oub_sch_loc_code
		AND	  t.oub_sch_ou            =   s.wms_oub_sch_ou
		AND	  t.oub_outbound_ord      =   s.wms_oub_outbound_ord
		AND	  t.oub_sch_lineno        =   s.wms_oub_sch_lineno
		AND	  t.oub_item_lineno       =   s.wms_oub_item_lineno
		AND	  t.obh_hr_key  =  sb.obh_hr_key;
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;
	

/*
	DELETE from dwh.f_outboundSchDetail FH
	USING stg.stg_wms_outbound_sch_dtl OH
		where FH.oub_sch_loc_code		=  OH.wms_oub_sch_loc_code
		AND	  FH.oub_sch_ou				=  OH.wms_oub_sch_ou
		AND	  FH.oub_outbound_ord		=  OH.wms_oub_outbound_ord
		AND	  FH.oub_sch_lineno			=  OH.wms_oub_sch_lineno
		AND	  FH.oub_item_lineno		=  OH.wms_oub_item_lineno;
-- 		AND	  FH.obh_hr_key				=  sb.obh_hr_key;
-- 	and COALESCE(fh.oub_modified_date,fh.oub_created_date)::DATE >= (CURRENT_DATE - INTERVAL '90 days')::DATE;
*/		
	INSERT INTO dwh.f_outboundSchDetail
	(   obh_hr_key, oub_loc_key,
		oub_itm_key,
		oub_sch_loc_code,        oub_sch_ou,         oub_outbound_ord,  oub_sch_lineno,  oub_sch_item_code,  
	 oub_item_lineno,  oub_sch_order_qty,   oub_sch_masteruom,              oub_sch_deliverydate,  oub_sch_serfrom,  
	 oub_sch_serto,  oub_sch_plan_gd_iss_dt,  oub_sch_plan_gd_iss_time,   oub_sch_operation_status,  oub_sch_picked_qty,  
	 oub_sch_packed_qty,  oub_sch_masteruomqty_ml,  oub_sch_orderuom_ml,
       etlactiveind,			     etljobname
		, envsourcecd,                     datasourcecd,                 etlcreatedatetime
	)
	
	SELECT 

       sb.obh_hr_key, COALESCE(l.loc_key,-1), COALESCE(c.itm_hdr_key,-1),OH.wms_oub_sch_loc_code,  OH.wms_oub_sch_ou,  OH.wms_oub_outbound_ord,  OH.wms_oub_sch_lineno,  OH.wms_oub_sch_item_code,  OH.wms_oub_item_lineno,  OH.wms_oub_sch_order_qty,  OH.wms_oub_sch_masteruom,  OH.wms_oub_sch_deliverydate,  OH.wms_oub_sch_serfrom,  OH.wms_oub_sch_serto,  OH.wms_oub_sch_plan_gd_iss_dt,  OH.wms_oub_sch_plan_gd_iss_time,  OH.wms_oub_sch_operation_status,  OH.wms_oub_sch_picked_qty,  OH.wms_oub_sch_packed_qty,  OH.wms_oub_sch_masteruomqty_ml,  OH.wms_oub_sch_orderuom_ml,       1 AS etlactiveind,				       p_etljobname,
		p_envsourcecd							, p_datasourcecd,                      NOW()
    FROM stg.stg_wms_outbound_sch_dtl OH
	INNER JOIN dwh.f_outboundheader sb
		ON OH.wms_oub_sch_ou		 	= sb.oub_ou 
		and  OH.wms_oub_sch_loc_code	= sb.oub_loc_code
		and OH.wms_oub_outbound_ord 	= sb.oub_outbound_ord
	LEFT JOIN dwh.d_location L 		
		ON OH.wms_oub_sch_loc_code 		= L.loc_code 
    	AND OH.wms_oub_sch_ou       	= L.loc_ou
    LEFT JOIN dwh.d_itemheader C 		
		ON OH.wms_oub_sch_item_code		= C.itm_code 
    	AND OH.wms_oub_sch_ou			= C.itm_ou
	LEFT JOIN dwh.f_outboundSchDetail FH 	
		ON FH.oub_sch_loc_code			=  OH.wms_oub_sch_loc_code
		AND	  FH.oub_sch_ou				=  OH.wms_oub_sch_ou
		AND	  FH.oub_outbound_ord		=  OH.wms_oub_outbound_ord
		AND	  FH.oub_sch_lineno			=  OH.wms_oub_sch_lineno
		AND	  FH.oub_item_lineno		=  OH.wms_oub_item_lineno
		AND	  FH.obh_hr_key				=  sb.obh_hr_key
		WHERE FH.oub_sch_loc_code IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
/*	
    select 0 into updcnt;
	
	
	 UPDATE dwh.f_outboundSchDetail dtl
	 SET 	obh_hr_key          =   fh.obh_hr_key,
	 		etlupdatedatetime 	= 	NOW()	
	 FROM	 dwh.f_outboundheader fh
	 WHERE 	dtl.oub_sch_ou		 	= fh.oub_ou 
	 AND  	dtl.oub_sch_loc_code	= fh.oub_loc_code
	 AND  	dtl.oub_outbound_ord 	= fh.oub_outbound_ord
	 AND    COALESCE(fh.oub_modified_date,fh.oub_created_date)::DATE >= (CURRENT_DATE - INTERVAL '90 days')::DATE;	
*/	 
    IF p_rawstorageflag = 1
    THEN
	
	INSERT INTO raw.raw_wms_outbound_sch_dtl

	(
	     wms_oub_sch_loc_code,  wms_oub_sch_ou,  wms_oub_outbound_ord,  wms_oub_sch_lineno,  wms_oub_sch_item_code,  wms_oub_item_lineno,  wms_oub_sch_order_qty,  wms_oub_sch_masteruom,  wms_oub_sch_deliverydate,  wms_oub_sch_serfrom,  wms_oub_sch_serto,  wms_oub_sch_plan_gd_iss_dt,  wms_oub_sch_plan_gd_iss_time,  wms_oub_sch_operation_status,  wms_oub_sch_picked_qty,  wms_oub_sch_packed_qty,  wms_oub_sch_masteruomqty_ml,  wms_oub_sch_orderuom_ml,	             etlcreateddatetime
	)
	SELECT 
				wms_oub_sch_loc_code,  wms_oub_sch_ou,  wms_oub_outbound_ord,  wms_oub_sch_lineno,  wms_oub_sch_item_code,  wms_oub_item_lineno,  wms_oub_sch_order_qty,  wms_oub_sch_masteruom,  wms_oub_sch_deliverydate,  wms_oub_sch_serfrom,  wms_oub_sch_serto,  wms_oub_sch_plan_gd_iss_dt,  wms_oub_sch_plan_gd_iss_time,  wms_oub_sch_operation_status,  wms_oub_sch_picked_qty,  wms_oub_sch_packed_qty,  wms_oub_sch_masteruomqty_ml,  wms_oub_sch_orderuom_ml,           etlcreateddatetime
	FROM stg.stg_wms_outbound_sch_dtl;
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
ALTER PROCEDURE dwh.usp_f_outboundschdetail(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
