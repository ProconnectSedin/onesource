-- PROCEDURE: dwh.usp_f_loadingdetail(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_loadingdetail(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_loadingdetail(
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

    SELECT COUNT(1) INTO srccnt
    FROM stg.stg_wms_loading_exec_dtl;

    UPDATE dwh.F_LoadingDetail t
    SET
        loading_hdr_key				   = COALESCE(fh.loading_hdr_key,-1),
		loading_dtl_loc_key			   = COALESCE(l.loc_key,-1),
		loading_dtl_thu_key			   = COALESCE(th.thu_key,-1),
		loading_dtl_stg_mas_key		   = COALESCE(st.stg_mas_key,-1),
		loading_dtl_shp_pt_key	   	   = COALESCE(sp.shp_pt_key,-1),
        loading_thu_id                 = s.wms_loading_thu_id,
        loading_ship_point             = s.wms_loading_ship_point,
        loading_disp_doc_type          = s.wms_loading_disp_doc_type,
        loading_disp_doc_no            = s.wms_loading_disp_doc_no,
        loading_transfer_doc           = s.wms_loading_transfer_doc,
        loading_thu_desc               = s.wms_loading_thu_desc,
        loading_thu_class              = s.wms_loading_thu_class,
        loading_thu_sr_no              = s.wms_loading_thu_sr_no,
        loading_thu_acc                = s.wms_loading_thu_acc,
        loading_disp_doc_date          = s.wms_loading_disp_doc_date,
        loading_pal_qty                = s.wms_loading_pal_qty,
        loading_tran_typ               = s.wms_loading_tran_typ,
        loading_start_date_time        = s.wms_loading_start_date_time,
        loading_end_date_time          = s.wms_loading_end_date_time,
        loading_so_no                  = s.wms_loading_so_no,
        loading_stage                  = s.wms_loading_stage,
        loading_curr_exec              = s.wms_loading_curr_exec,
        etlactiveind                   = 1,
        etljobname                     = p_etljobname,
        envsourcecd                    = p_envsourcecd,
        datasourcecd                   = p_datasourcecd,
        etlupdatedatetime              = NOW()
    FROM stg.stg_wms_loading_exec_dtl s
	INNER JOIN dwh.f_loadingheader fh 
		ON  s.wms_loading_exec_no		= fh.loading_exec_no
		AND s.wms_loading_exec_ou 		= fh.loading_exec_ou
		AND s.wms_loading_loc_code		= fh.loading_loc_code
	LEFT JOIN dwh.d_location l 		
		ON  s.wms_loading_loc_code 		= l.loc_code 
		AND s.wms_loading_exec_ou 		= l.loc_ou 
	LEFT JOIN dwh.d_shippingpoint sp 			
		ON  s.wms_loading_ship_point 	= sp.shp_pt_id
		AND s.wms_loading_exec_ou 		= sp.shp_pt_ou 
	LEFT JOIN dwh.d_thu th 		
		ON  s.wms_loading_thu_id		= th.thu_id 
		AND s.wms_loading_exec_ou 		= th.thu_ou  	
	LEFT JOIN dwh.d_stage st 		
		ON  s.wms_loading_stage  		= st.stg_mas_id 
		AND s.wms_loading_exec_ou 		= st.stg_mas_ou 
		AND s.wms_loading_loc_code		= st.stg_mas_loc
		
    WHERE 	t.loading_loc_code		   = s.wms_loading_loc_code
    AND 	t.loading_exec_no 		   = s.wms_loading_exec_no
    AND 	t.loading_exec_ou 		   = s.wms_loading_exec_ou
    AND 	t.loading_lineno 		   = s.wms_loading_lineno;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_LoadingDetail
    (
		loading_hdr_key, loading_dtl_loc_key, loading_dtl_thu_key, loading_dtl_stg_mas_key, loading_dtl_shp_pt_key,
        loading_loc_code, loading_exec_no, loading_exec_ou, loading_lineno, loading_thu_id, loading_ship_point, loading_disp_doc_type, loading_disp_doc_no, loading_transfer_doc, loading_thu_desc, loading_thu_class, loading_thu_sr_no, loading_thu_acc, loading_disp_doc_date, loading_pal_qty, loading_tran_typ, loading_start_date_time, loading_end_date_time, loading_so_no, loading_stage, loading_curr_exec, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
		COALESCE(fh.loading_hdr_key,-1), COALESCE(l.loc_key,-1), COALESCE(th.thu_key,-1), COALESCE(st.stg_mas_key,-1), COALESCE(sp.shp_pt_key,-1),
        s.wms_loading_loc_code, s.wms_loading_exec_no, s.wms_loading_exec_ou, s.wms_loading_lineno, s.wms_loading_thu_id, s.wms_loading_ship_point, s.wms_loading_disp_doc_type, s.wms_loading_disp_doc_no, s.wms_loading_transfer_doc, s.wms_loading_thu_desc, s.wms_loading_thu_class, s.wms_loading_thu_sr_no, s.wms_loading_thu_acc, s.wms_loading_disp_doc_date, s.wms_loading_pal_qty, s.wms_loading_tran_typ, s.wms_loading_start_date_time, s.wms_loading_end_date_time, s.wms_loading_so_no, s.wms_loading_stage, s.wms_loading_curr_exec, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_wms_loading_exec_dtl s
	INNER JOIN dwh.f_loadingheader fh 
		ON  s.wms_loading_exec_no		= fh.loading_exec_no
		AND s.wms_loading_exec_ou 		= fh.loading_exec_ou 
		AND s.wms_loading_loc_code		= fh.loading_loc_code
	LEFT JOIN dwh.d_location l 		
		ON  s.wms_loading_loc_code 		= l.loc_code 
		AND s.wms_loading_exec_ou 		= l.loc_ou 
	LEFT JOIN dwh.d_shippingpoint sp 			
		ON  s.wms_loading_ship_point 	= sp.shp_pt_id
		AND s.wms_loading_exec_ou 		= sp.shp_pt_ou 
	LEFT JOIN dwh.d_thu th 		
		ON  s.wms_loading_thu_id		= th.thu_id 
		AND s.wms_loading_exec_ou 		= th.thu_ou  	
	LEFT JOIN dwh.d_stage st 		
		ON  s.wms_loading_stage  		= st.stg_mas_id 
		AND s.wms_loading_exec_ou 		= st.stg_mas_ou 		
    LEFT JOIN dwh.F_LoadingDetail t
    ON s.wms_loading_loc_code = t.loading_loc_code
    AND s.wms_loading_exec_no = t.loading_exec_no
    AND s.wms_loading_exec_ou = t.loading_exec_ou
    AND s.wms_loading_lineno = t.loading_lineno
    WHERE t.loading_exec_ou IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_wms_loading_exec_dtl
    (
        wms_loading_loc_code, wms_loading_exec_no, wms_loading_exec_ou, wms_loading_lineno, wms_loading_thu_id, wms_loading_ship_point, wms_loading_disp_doc_type, wms_loading_disp_doc_no, wms_loading_transfer_doc, wms_loading_thu_desc, wms_loading_thu_class, wms_loading_thu_sr_no, wms_loading_thu_acc, wms_loading_disp_doc_date, wms_loading_pal_qty, wms_loading_tran_typ, wms_loading_ven_thuid, wms_loading_start_date_time, wms_loading_end_date_time, wms_loading_so_no, wms_unload_flag, wms_loading_thu_sr_no2, wms_loading_reason_code, wms_loading_userdef1, wms_loading_userdef2, wms_loading_userdef3, wms_loading_userdef4, wms_loading_userdef5, wms_loading_stage, wms_loading_curr_exec, etlcreateddatetime
    )
    SELECT
        wms_loading_loc_code, wms_loading_exec_no, wms_loading_exec_ou, wms_loading_lineno, wms_loading_thu_id, wms_loading_ship_point, wms_loading_disp_doc_type, wms_loading_disp_doc_no, wms_loading_transfer_doc, wms_loading_thu_desc, wms_loading_thu_class, wms_loading_thu_sr_no, wms_loading_thu_acc, wms_loading_disp_doc_date, wms_loading_pal_qty, wms_loading_tran_typ, wms_loading_ven_thuid, wms_loading_start_date_time, wms_loading_end_date_time, wms_loading_so_no, wms_unload_flag, wms_loading_thu_sr_no2, wms_loading_reason_code, wms_loading_userdef1, wms_loading_userdef2, wms_loading_userdef3, wms_loading_userdef4, wms_loading_userdef5, wms_loading_stage, wms_loading_curr_exec, etlcreateddatetime
    FROM stg.stg_wms_loading_exec_dtl;
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
ALTER PROCEDURE dwh.usp_f_loadingdetail(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
