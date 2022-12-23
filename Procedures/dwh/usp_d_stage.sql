CREATE PROCEDURE dwh.usp_d_stage(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
        ON d.sourceid = h.sourceid
    WHERE   d.sourceid      = p_sourceId 
        AND d.dataflowflag  = p_dataflowflag
        AND d.targetobject  = p_targetobject;

    SELECT COUNT(1) INTO srccnt
    FROM stg.stg_wms_stage_mas_hdr;

    UPDATE dwh.d_stage t
    SET 
		stg_mas_desc            = s.wms_stg_mas_desc,
        stg_mas_status          = s.wms_stg_mas_status,
        stg_mas_type            = s.wms_stg_mas_type,
        stg_mas_def_bin         = s.wms_stg_mas_def_bin,
        stg_mas_rsn_code        = s.wms_stg_mas_rsn_code,
        stg_mas_frm_stage       = s.wms_stg_mas_frm_stage,
        stg_mas_frm_doc_typ     = s.wms_stg_mas_frm_doc_typ,
        stg_mas_frm_doc_status  = s.wms_stg_mas_frm_doc_status,
        stg_mas_frm_doc_conf_req= s.wms_stg_mas_frm_doc_conf_req,
        stg_mas_to_stage        = s.wms_stg_mas_to_stage,
        stg_mas_to_doc_typ      = s.wms_stg_mas_to_doc_typ,
        stg_mas_to_doc_status   = s.wms_stg_mas_to_doc_status,
        stg_mas_to_doc_conf_req = s.wms_stg_mas_to_doc_conf_req,
        stg_mas_timestamp       = s.wms_stg_mas_timestamp,
        stg_mas_created_by      = s.wms_stg_mas_created_by,
        stg_mas_created_dt      = s.wms_stg_mas_created_dt,
        stg_mas_modified_by     = s.wms_stg_mas_modified_by,
        stg_mas_modified_dt     = s.wms_stg_mas_modified_dt,
        stg_mas_dock_status     = s.wms_stg_mas_dock_status,
        stg_mas_dock_prevstat   = s.wms_stg_mas_dock_prevstat,
        stg_mas_frm_stage_typ   = s.wms_stg_mas_frm_stage_typ,
        stg_mas_to_stage_typ    = s.wms_stg_mas_to_stage_typ,
        stg_mas_pack_bin        = s.wms_stg_mas_pack_bin,
        etlactiveind            = 1,
        etljobname              = p_etljobname,
        envsourcecd             = p_envsourcecd ,
        datasourcecd            = p_datasourcecd ,
        etlupdatedatetime       = NOW() 
    FROM stg.stg_wms_stage_mas_hdr s
    WHERE t.stg_mas_ou        = s.wms_stg_mas_ou
    AND t.stg_mas_id          = s.wms_stg_mas_id
    AND t.stg_mas_loc         = s.wms_stg_mas_loc;
    
    
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.d_stage
    (
        stg_mas_ou, 			stg_mas_id, 			stg_mas_desc, 				stg_mas_status,    
		stg_mas_loc,			stg_mas_type, 			stg_mas_def_bin, 			stg_mas_rsn_code, 
		stg_mas_frm_stage,		stg_mas_frm_doc_typ, 	stg_mas_frm_doc_status, 	stg_mas_frm_doc_conf_req, 	
		stg_mas_to_stage,		stg_mas_to_doc_typ, 	stg_mas_to_doc_status, 		stg_mas_to_doc_conf_req,
        stg_mas_timestamp, 		stg_mas_created_by, 	stg_mas_created_dt, 		stg_mas_modified_by, 
        stg_mas_modified_dt, 	stg_mas_dock_status, 	stg_mas_dock_prevstat, 		stg_mas_frm_stage_typ, 
        stg_mas_to_stage_typ,   stg_mas_pack_bin, 		etlactiveind, 				etljobname, 		
		envsourcecd, 			datasourcecd, 			etlcreatedatetime

    )
    
    SELECT 
	    s.wms_stg_mas_ou,				s.wms_stg_mas_id,				s.wms_stg_mas_desc,				s.wms_stg_mas_status,			
		s.wms_stg_mas_loc,				s.wms_stg_mas_type,             s.wms_stg_mas_def_bin,			s.wms_stg_mas_rsn_code,			
		s.wms_stg_mas_frm_stage,		s.wms_stg_mas_frm_doc_typ,		s.wms_stg_mas_frm_doc_status,   s.wms_stg_mas_frm_doc_conf_req, 
		s.wms_stg_mas_to_stage,			s.wms_stg_mas_to_doc_typ,		s.wms_stg_mas_to_doc_status,	s.wms_stg_mas_to_doc_conf_req,       
		s.wms_stg_mas_timestamp,		s.wms_stg_mas_created_by,		s.wms_stg_mas_created_dt,       s.wms_stg_mas_modified_by,		
		s.wms_stg_mas_modified_dt,      s.wms_stg_mas_dock_status,	    s.wms_stg_mas_dock_prevstat,	s.wms_stg_mas_frm_stage_typ, 
		s.wms_stg_mas_to_stage_typ,   	s.wms_stg_mas_pack_bin,   	    1,								p_etljobname,       			
		p_envsourcecd,      			p_datasourcecd,         		NOW()
    FROM stg.stg_wms_stage_mas_hdr s
    LEFT JOIN dwh.d_stage t
    ON  s.wms_stg_mas_ou          = t.stg_mas_ou
    AND s.wms_stg_mas_id           = t.stg_mas_id
    AND s.wms_stg_mas_loc           = t.stg_mas_loc
    WHERE t.stg_mas_ou IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
	IF p_rawstorageflag = 1
	THEN

    
    INSERT INTO raw.raw_wms_stage_mas_hdr
    (
        wms_stg_mas_ou,             wms_stg_mas_id,                 wms_stg_mas_desc,               wms_stg_mas_status,             
        wms_stg_mas_loc,            wms_stg_mas_type,               wms_stg_mas_def_bin,            wms_stg_mas_rsn_code,               
        wms_stg_mas_frm_stage,      wms_stg_mas_frm_doc_typ,        wms_stg_mas_frm_doc_status,             
        wms_stg_mas_frm_doc_prefix, wms_stg_mas_frm_doc_conf_req,   wms_stg_mas_to_stage,               
        wms_stg_mas_to_doc_typ,     wms_stg_mas_to_doc_status,      wms_stg_mas_to_doc_prefix,              
        wms_stg_mas_to_doc_conf_req,wms_stg_mas_timestamp,          wms_stg_mas_created_by,             
        wms_stg_mas_created_dt,     wms_stg_mas_modified_by,        wms_stg_mas_modified_dt,                
        wms_stg_mas_user_def1,      wms_stg_mas_user_def2,          wms_stg_mas_user_def3,          wms_stg_mas_height,             
        wms_stg_mas_handl_eqp_capa, wms_stg_mas_unit,               wms_stg_mas_dock_status,                
        wms_stg_mas_dock_prevstat,  wms_stg_mas_frm_stage_typ,      wms_stg_mas_to_stage_typ,               
        wms_stg_mas_pack_bin,       wms_stg_mas_hgt_uom,            wms_stg_uom,                   wms_stg_length,             
        wms_stg_breadth,            wms_stg_height,                 etlcreateddatetime     
    )
    SELECT 

        wms_stg_mas_ou,             wms_stg_mas_id,                 wms_stg_mas_desc,               wms_stg_mas_status,             
        wms_stg_mas_loc,            wms_stg_mas_type,               wms_stg_mas_def_bin,            wms_stg_mas_rsn_code,               
        wms_stg_mas_frm_stage,      wms_stg_mas_frm_doc_typ,        wms_stg_mas_frm_doc_status,             
        wms_stg_mas_frm_doc_prefix, wms_stg_mas_frm_doc_conf_req,   wms_stg_mas_to_stage,               
        wms_stg_mas_to_doc_typ,     wms_stg_mas_to_doc_status,      wms_stg_mas_to_doc_prefix,              
        wms_stg_mas_to_doc_conf_req,wms_stg_mas_timestamp,          wms_stg_mas_created_by,             
        wms_stg_mas_created_dt,     wms_stg_mas_modified_by,        wms_stg_mas_modified_dt,                
        wms_stg_mas_user_def1,      wms_stg_mas_user_def2,          wms_stg_mas_user_def3,          wms_stg_mas_height,             
        wms_stg_mas_handl_eqp_capa, wms_stg_mas_unit,               wms_stg_mas_dock_status,                
        wms_stg_mas_dock_prevstat,  wms_stg_mas_frm_stage_typ,      wms_stg_mas_to_stage_typ,               
        wms_stg_mas_pack_bin,       wms_stg_mas_hgt_uom,            wms_stg_uom,                   wms_stg_length,             
        wms_stg_breadth,            wms_stg_height,                 etlcreateddatetime  

        FROM stg.stg_wms_stage_mas_hdr;
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