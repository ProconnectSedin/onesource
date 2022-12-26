-- PROCEDURE: dwh.usp_f_dispatchdetail(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_dispatchdetail(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_dispatchdetail(
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
    SELECT d.jobname, h.envsourcecode, h.datasourcecode, d.latestbatchid, d.targetprocedurename, h.rawstorageflag, h.depsource
    INTO p_etljobname, p_envsourcecd, p_datasourcecd, p_batchid, p_taskname, p_rawstorageflag, p_depsource
    FROM ods.controldetail d
    INNER JOIN ods.controlheader h
        ON d.sourceid = h.sourceid
    WHERE d.sourceid = p_sourceId
        AND d.dataflowflag = p_dataflowflag
        AND d.targetobject = p_targetobject;

    IF EXISTS(SELECT 1 FROM ods.controlheader WHERE sourceid = p_depsource AND status = 'Completed' 
                    AND CAST(COALESCE(lastupdateddate,createddate) AS DATE) >= NOW()::DATE)
    THEN

    SELECT COUNT(1) INTO srccnt FROM stg.stg_wms_dispatch_dtl;

    UPDATE dwh.f_dispatchdetail t
    SET
        dispatch_hdr_key 				= COALESCE(dh.dispatch_hdr_key,-1),
        dispatch_dtl_loc_key 			= COALESCE(l.loc_key,-1),
        dispatch_dtl_thu_key 			= COALESCE(th.thu_key,-1),
        dispatch_dtl_shp_pt_key 		= COALESCE(sp.shp_pt_key,-1),
        dispatch_dtl_customer_key 		= COALESCE(c.customer_key,-1),
        dispatch_so_no 					= s.wms_dispatch_so_no,
        dispatch_thu_id 				= s.wms_dispatch_thu_id,
        dispatch_ship_point 			= s.wms_dispatch_ship_point,
        dispatch_ship_mode 				= s.wms_dispatch_ship_mode,
        dispatch_pack_exec_no 			= s.wms_dispatch_pack_exec_no,
        dispatch_customer 				= s.wms_dispatch_customer,
        dispatch_thu_desc 				= s.wms_dispatch_thu_desc,
        dispatch_thu_class 				= s.wms_dispatch_thu_class,
        dispatch_thu_sr_no 				= s.wms_dispatch_thu_sr_no,
        dispatch_su 					= s.wms_dispatch_su,
        dispatch_exec_stage 			= s.wms_dispatch_exec_stage,
        dispatch_uid_serial_no 			= s.wms_dispatch_uid_serial_no,
        dispatch_thu_weight 			= s.wms_dispatch_thu_weight,
        dispatch_thu_wt_uom 			= s.wms_dispatch_thu_wt_uom,
        dispatch_length_ml 				= s.wms_dispatch_length_ml,
        dispatch_height_ml 				= s.wms_dispatch_height_ml,
        dispatch_breadth_ml 			= s.wms_dispatch_breadth_ml,
        dispatch_thu_sp_ml 				= s.wms_dispatch_thu_sp_ml,
        dispatch_uom_ml 				= s.wms_dispatch_uom_ml,
        dispatch_vol_ml 				= s.wms_dispatch_vol_ml,
        dispatch_vol_uom_ml 			= s.wms_dispatch_vol_uom_ml,
        dispatch_outbound_no 			= s.wms_dispatch_outbound_no,
        dispatch_reasoncode_ml 			= s.wms_dispatch_reasoncode_ml,
        etlactiveind 					= 1,
        etljobname 						= p_etljobname,
        envsourcecd 					= p_envsourcecd ,
        datasourcecd 					= p_datasourcecd ,
        etlupdatedatetime 				= NOW()    
    FROM stg.stg_wms_dispatch_dtl s
	INNER JOIN dwh.F_DispatchHeader dh
		ON  dh.dispatch_loc_code 		= s.wms_dispatch_loc_code
		AND dh.dispatch_ld_sheet_no 	= s.wms_dispatch_ld_sheet_no
		AND dh.dispatch_ld_sheet_ou 	= s.wms_dispatch_ld_sheet_ou	
	LEFT JOIN dwh.d_location l
		ON  s.wms_dispatch_loc_code 	= l.loc_code
		AND s.wms_dispatch_ld_sheet_ou 	= l.loc_ou
	LEFT JOIN dwh.d_thu th
		ON  s.wms_dispatch_thu_id 		= th.thu_id
		AND s.wms_dispatch_ld_sheet_ou 	= th.thu_ou	
	LEFT JOIN dwh.d_shippingpoint sp
		ON  s.wms_dispatch_ship_point 	= sp.shp_pt_id
		AND s.wms_dispatch_ld_sheet_ou 	= sp.shp_pt_ou
	LEFT JOIN dwh.d_customer c
		ON  s.wms_dispatch_customer 	= c.customer_id
		AND s.wms_dispatch_ld_sheet_ou 	= c.customer_ou		
    WHERE   t.dispatch_loc_code 		= s.wms_dispatch_loc_code
		AND t.dispatch_ld_sheet_no 		= s.wms_dispatch_ld_sheet_no
		AND t.dispatch_ld_sheet_ou 		= s.wms_dispatch_ld_sheet_ou
		AND t.dispatch_lineno 			= s.wms_dispatch_lineno;
    
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.f_dispatchdetail 
    (
        dispatch_hdr_key,dispatch_dtl_loc_key,dispatch_dtl_thu_key,dispatch_dtl_shp_pt_key,dispatch_dtl_customer_key,dispatch_loc_code, dispatch_ld_sheet_no, dispatch_ld_sheet_ou, dispatch_lineno, dispatch_so_no, dispatch_thu_id, dispatch_ship_point, dispatch_ship_mode, dispatch_pack_exec_no, dispatch_customer, dispatch_thu_desc, dispatch_thu_class, dispatch_thu_sr_no, dispatch_su, dispatch_exec_stage, dispatch_uid_serial_no, dispatch_thu_weight, dispatch_thu_wt_uom, dispatch_length_ml, dispatch_height_ml, dispatch_breadth_ml, dispatch_thu_sp_ml, dispatch_uom_ml, dispatch_vol_ml, dispatch_vol_uom_ml, dispatch_outbound_no, dispatch_reasoncode_ml, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )
    
    SELECT
		COALESCE(dh.dispatch_hdr_key,-1),COALESCE(l.loc_key,-1),COALESCE(th.thu_key,-1),COALESCE(sp.shp_pt_key,-1),COALESCE(c.customer_key,-1),s.wms_dispatch_loc_code, s.wms_dispatch_ld_sheet_no, s.wms_dispatch_ld_sheet_ou, s.wms_dispatch_lineno, s.wms_dispatch_so_no, s.wms_dispatch_thu_id, s.wms_dispatch_ship_point, s.wms_dispatch_ship_mode, s.wms_dispatch_pack_exec_no, s.wms_dispatch_customer, s.wms_dispatch_thu_desc, s.wms_dispatch_thu_class, s.wms_dispatch_thu_sr_no, s.wms_dispatch_su, s.wms_dispatch_exec_stage, s.wms_dispatch_uid_serial_no, s.wms_dispatch_thu_weight, s.wms_dispatch_thu_wt_uom, s.wms_dispatch_length_ml, s.wms_dispatch_height_ml, s.wms_dispatch_breadth_ml, s.wms_dispatch_thu_sp_ml, s.wms_dispatch_uom_ml, s.wms_dispatch_vol_ml, s.wms_dispatch_vol_uom_ml, s.wms_dispatch_outbound_no, s.wms_dispatch_reasoncode_ml, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_wms_dispatch_dtl s
	INNER JOIN dwh.F_DispatchHeader dh
		ON  dh.dispatch_loc_code 		= s.wms_dispatch_loc_code
		AND dh.dispatch_ld_sheet_no 	= s.wms_dispatch_ld_sheet_no
		AND dh.dispatch_ld_sheet_ou 	= s.wms_dispatch_ld_sheet_ou	
	LEFT JOIN dwh.d_location l
		ON  s.wms_dispatch_loc_code 	= l.loc_code
		AND s.wms_dispatch_ld_sheet_ou 	= l.loc_ou
	LEFT JOIN dwh.d_thu th
		ON  s.wms_dispatch_thu_id 		= th.thu_id
		AND s.wms_dispatch_ld_sheet_ou 	= th.thu_ou	
	LEFT JOIN dwh.d_shippingpoint sp
		ON  s.wms_dispatch_ship_point 	= sp.shp_pt_id
		AND s.wms_dispatch_ld_sheet_ou 	= sp.shp_pt_ou
	LEFT JOIN dwh.d_customer c
		ON  s.wms_dispatch_customer 	= c.customer_id
		AND s.wms_dispatch_ld_sheet_ou 	= c.customer_ou		
    LEFT JOIN dwh.f_dispatchdetail t
		ON  s.wms_dispatch_loc_code 	= t.dispatch_loc_code
		AND s.wms_dispatch_ld_sheet_no 	= t.dispatch_ld_sheet_no
		AND s.wms_dispatch_ld_sheet_ou 	= t.dispatch_ld_sheet_ou
		AND s.wms_dispatch_lineno 		= t.dispatch_lineno
    WHERE t.dispatch_loc_code IS NULL;
	
	GET DIAGNOSTICS inscnt = ROW_COUNT;
	
	
    IF p_rawstorageflag = 1
    THEN
    
    INSERT INTO raw.raw_wms_dispatch_dtl
    (   
        wms_dispatch_loc_code, wms_dispatch_ld_sheet_no, wms_dispatch_ld_sheet_ou, wms_dispatch_lineno, wms_dispatch_so_no, wms_dispatch_thu_id, wms_dispatch_ship_point, wms_dispatch_ship_mode, wms_dispatch_pack_exec_no, wms_dispatch_customer, wms_dispatch_thu_desc, wms_dispatch_thu_class, wms_dispatch_thu_sr_no, wms_dispatch_thu_acc, wms_dispatch_su, wms_dispatch_exec_stage, wms_dispatch_uid_serial_no, wms_dispatch_thu_weight, wms_dispatch_thu_wt_uom, wms_dispatch_cons_qty, wms_dispatch_cons_ml, wms_dispatch_length_ml, wms_dispatch_height_ml, wms_dispatch_breadth_ml, wms_dispatch_thu_sp_ml, wms_dispatch_uom_ml, wms_dispatch_vol_ml, wms_dispatch_vol_uom_ml, wms_dispatch_outbound_no, wms_dispatch_reasoncode_ml, etlcreateddatetime
    )
    SELECT 
        wms_dispatch_loc_code, wms_dispatch_ld_sheet_no, wms_dispatch_ld_sheet_ou, wms_dispatch_lineno, wms_dispatch_so_no, wms_dispatch_thu_id, wms_dispatch_ship_point, wms_dispatch_ship_mode, wms_dispatch_pack_exec_no, wms_dispatch_customer, wms_dispatch_thu_desc, wms_dispatch_thu_class, wms_dispatch_thu_sr_no, wms_dispatch_thu_acc, wms_dispatch_su, wms_dispatch_exec_stage, wms_dispatch_uid_serial_no, wms_dispatch_thu_weight, wms_dispatch_thu_wt_uom, wms_dispatch_cons_qty, wms_dispatch_cons_ml, wms_dispatch_length_ml, wms_dispatch_height_ml, wms_dispatch_breadth_ml, wms_dispatch_thu_sp_ml, wms_dispatch_uom_ml, wms_dispatch_vol_ml, wms_dispatch_vol_uom_ml, wms_dispatch_outbound_no, wms_dispatch_reasoncode_ml, etlcreateddatetime
    FROM stg.stg_wms_dispatch_dtl;
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
ALTER PROCEDURE dwh.usp_f_dispatchdetail(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
