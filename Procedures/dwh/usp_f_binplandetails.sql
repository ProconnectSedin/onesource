-- PROCEDURE: dwh.usp_f_binplandetails(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_binplandetails(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_binplandetails(
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

    SELECT COUNT(1) INTO srccnt
	FROM stg.stg_wms_bin_plan_item_dtl;

	UPDATE dwh.f_binplandetails t
    SET  
	    bin_hdr_key                   				=  bb.bin_hdr_key,
    	bin_loc_dl_key					                = COALESCE(l.loc_key,-1),
        bin_item_batch_no                       		=   s.wms_bin_item_batch_no,
        bin_src_bin                             		=   s.wms_bin_src_bin,
        bin_src_zone                             		=   s.wms_bin_src_zone,
        bin_su                             				=   s.wms_bin_su,
        bin_su_qty                             			=   s.wms_bin_su_qty,
        bin_avial_qty                             		=   s.wms_bin_avial_qty,
        bin_trn_out_qty                             	=   s.wms_bin_trn_out_qty,
        bin_tar_bin                             		=   s.wms_bin_tar_bin,
        bin_tar_zone                             		=   s.wms_bin_tar_zone,
        bin_lot_no                             			=   s.wms_bin_lot_no,
        bin_su_type                             		=   s.wms_bin_su_type,
        bin_su_slno                             		=   s.wms_bin_su_slno,
        bin_thu_typ                             		=   s.wms_bin_thu_typ,
        bin_thu_id                             			=   s.wms_bin_thu_id,
        bin_src_staging_id                             	=   s.wms_bin_src_staging_id,
        bin_trgt_staging_id                             =   s.wms_bin_trgt_staging_id,
        bin_stk_line_no                             	=   s.wms_bin_stk_line_no,
        bin_stk_status                             		=   s.wms_bin_stk_status,
        bin_status                             			=   s.wms_bin_status,
        bin_src_status                             		=   s.wms_bin_src_status,
        bin_from_thu_sl_no                             	=   s.wms_bin_from_thu_sl_no,
        bin_target_thu_sl_no                            =   s.wms_bin_target_thu_sl_no,
        bin_pal_status                             		=   s.wms_bin_pal_status,
        bin_repl_alloc_ln_no                            =   s.wms_bin_repl_alloc_ln_no,
        bin_repl_doc_line_no                            =   s.wms_bin_repl_doc_line_no,
        bin_plan_rsn_code                             	=   s.wms_bin_plan_rsn_code,
        bin_pln_itm_attr1                             	=   s.wms_bin_pln_itm_attr1 ,
		etlactiveind 					                = 1
		, etljobname 					                = p_etljobname
		, envsourcecd 					                = p_envsourcecd
		, datasourcecd 					                = p_datasourcecd
		, etlupdatedatetime 			                = NOW()	
    FROM stg.stg_wms_bin_plan_item_dtl s
	INNER JOIN dwh.f_binplanheader bb
	
     ON  s.wms_bin_loc_code = bb.bin_loc_code 
     and s.wms_bin_pln_no =bb.bin_pln_no 
     and s.wms_bin_pln_ou = bb.bin_pln_ou

	LEFT JOIN dwh.d_location L 		
		ON s.wms_bin_loc_code 	= L.loc_code 
        AND s.wms_bin_pln_ou          = L.loc_ou

    WHERE   
    	       t.bin_loc_code                                	=   s.wms_bin_loc_code
		AND    t.bin_pln_no                                  	=   s.wms_bin_pln_no
		AND    t.bin_pln_lineno                            	  	=   s.wms_bin_pln_lineno
		AND    t.bin_pln_ou                       				=   s.wms_bin_pln_ou
		AND    t.bin_hdr_key                   				=  bb.bin_hdr_key;     

    GET DIAGNOSTICS updcnt = ROW_COUNT;

	INSERT INTO dwh.f_binplandetails
	(   bin_hdr_key, bin_loc_dl_key, bin_loc_code,  bin_pln_no,  bin_pln_lineno,  bin_pln_ou,  bin_item,  bin_item_batch_no,  bin_src_bin,  bin_src_zone,  bin_su,  bin_su_qty,  bin_avial_qty,  bin_trn_out_qty,  bin_tar_bin,  bin_tar_zone,  bin_lot_no,  bin_su_type,  bin_su_slno,  bin_thu_typ,  bin_thu_id,  bin_src_staging_id,  bin_trgt_staging_id,  bin_stk_line_no,  bin_stk_status,  bin_status,  bin_src_status,  bin_from_thu_sl_no,  bin_target_thu_sl_no,  bin_pal_status,  bin_repl_alloc_ln_no,  bin_repl_doc_line_no,  bin_plan_rsn_code,  bin_pln_itm_attr1,   etlactiveind					, etljobname				, envsourcecd, 
		datasourcecd			, etlcreatedatetime
		
	)
	
	SELECT 

      bb.bin_hdr_key, COALESCE(l.loc_key,-1),OH.wms_bin_loc_code,  OH.wms_bin_pln_no,  OH.wms_bin_pln_lineno,  OH.wms_bin_pln_ou,  OH.wms_bin_item,  OH.wms_bin_item_batch_no,  OH.wms_bin_src_bin,  OH.wms_bin_src_zone,  OH.wms_bin_su,  OH.wms_bin_su_qty,  OH.wms_bin_avial_qty,  OH.wms_bin_trn_out_qty,  OH.wms_bin_tar_bin,  OH.wms_bin_tar_zone,  OH.wms_bin_lot_no,  OH.wms_bin_su_type,  OH.wms_bin_su_slno,  OH.wms_bin_thu_typ,  OH.wms_bin_thu_id,  OH.wms_bin_src_staging_id,  OH.wms_bin_trgt_staging_id,  OH.wms_bin_stk_line_no,  OH.wms_bin_stk_status,  OH.wms_bin_status,  OH.wms_bin_src_status,  OH.wms_bin_from_thu_sl_no,  OH.wms_bin_target_thu_sl_no,  OH.wms_bin_pal_status,  OH.wms_bin_repl_alloc_ln_no,  OH.wms_bin_repl_doc_line_no,  OH.wms_bin_plan_rsn_code,  OH.wms_bin_pln_itm_attr1,
           1 AS etlactiveind,				       p_etljobname,
		p_envsourcecd							, p_datasourcecd,                      NOW()
      
	FROM stg.stg_wms_bin_plan_item_dtl OH
	INNER JOIN dwh.f_binplanheader bb
	
     ON  OH.wms_bin_loc_code = bb.bin_loc_code 
     and OH.wms_bin_pln_no =bb.bin_pln_no 
     and OH.wms_bin_pln_ou = bb.bin_pln_ou

	LEFT JOIN dwh.d_location L 		
		ON OH.wms_bin_loc_code 	= L.loc_code 
        AND OH.wms_bin_pln_ou          = L.loc_ou

  

	LEFT JOIN dwh.f_binplandetails FH 	
		ON 
  
    	   	    FH.bin_loc_code      =   OH.wms_bin_loc_code
 			AND	FH.bin_pln_no        =   OH.wms_bin_pln_no
 			AND	FH.bin_pln_lineno    =   OH.wms_bin_pln_lineno
 			AND	FH.bin_pln_ou        =   OH.wms_bin_pln_ou
			AND FH.bin_hdr_key         =  bb.bin_hdr_key
	
    WHERE FH.bin_loc_code IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN
	
	INSERT INTO raw.raw_wms_bin_plan_item_dtl

	(wms_bin_loc_code,  wms_bin_pln_no,  wms_bin_pln_lineno,  wms_bin_pln_ou,  wms_bin_pln_status,  wms_bin_item,  wms_bin_item_batch_no,  wms_bin_item_sr_no,  wms_bin_uid,  wms_bin_src_bin,  wms_bin_src_zone,  wms_bin_su,  wms_bin_su_qty,  wms_bin_avial_qty,  wms_bin_trn_out_qty,  wms_bin_tar_bin,  wms_bin_tar_zone,  wms_bin_trn_in_qty,  wms_bin_lot_no,  wms_bin_su_type,  wms_bin_su_slno,  wms_bin_uid_slno,  wms_bin_thu_typ,  wms_bin_thu_id,  wms_bin_src_staging_id,  wms_bin_trgt_staging_id,  wms_bin_stk_line_no,  wms_bin_stk_status,  wms_bin_consignee,  wms_bin_customer,  wms_bin_gr_date,  wms_bin_status,  wms_bin_trans_date,  wms_bin_trans_number,  wms_bin_trans_type,  wms_bin_src_status,  wms_bin_mul_batch_flg,  wms_bin_from_thu_sl_no,  wms_bin_target_thu_sl_no,  wms_bin_pal_status,  wms_bin_thu2_sl_no,  wms_bin_repl_alloc_ln_no,  wms_bin_repl_doc_line_no,  wms_bin_thu2_id,  wms_bin_su2,  wms_bin_su_slno2,  wms_bin_su_qty2,  wms_bin_prof_type,  wms_bin_trans_uom,  wms_bin_trans_uom_qty,  wms_bin_plan_rsn_code,  wms_bin_pln_itm_attr1,  wms_bin_pln_itm_attr10,  wms_bin_pln_itm_attr2,  wms_bin_pln_itm_attr3,  wms_bin_pln_itm_attr4,  wms_bin_pln_itm_attr5,  wms_bin_pln_itm_attr6,  wms_bin_pln_itm_attr7,  wms_bin_pln_itm_attr8,  wms_bin_pln_itm_attr9,
	 etlcreateddatetime
	)
	SELECT 

	wms_bin_loc_code,  wms_bin_pln_no,  wms_bin_pln_lineno,  wms_bin_pln_ou,  wms_bin_pln_status,  wms_bin_item,  wms_bin_item_batch_no,  wms_bin_item_sr_no,  wms_bin_uid,  wms_bin_src_bin,  wms_bin_src_zone,  wms_bin_su,  wms_bin_su_qty,  wms_bin_avial_qty,  wms_bin_trn_out_qty,  wms_bin_tar_bin,  wms_bin_tar_zone,  wms_bin_trn_in_qty,  wms_bin_lot_no,  wms_bin_su_type,  wms_bin_su_slno,  wms_bin_uid_slno,  wms_bin_thu_typ,  wms_bin_thu_id,  wms_bin_src_staging_id,  wms_bin_trgt_staging_id,  wms_bin_stk_line_no,  wms_bin_stk_status,  wms_bin_consignee,  wms_bin_customer,  wms_bin_gr_date,  wms_bin_status,  wms_bin_trans_date,  wms_bin_trans_number,  wms_bin_trans_type,  wms_bin_src_status,  wms_bin_mul_batch_flg,  wms_bin_from_thu_sl_no,  wms_bin_target_thu_sl_no,  wms_bin_pal_status,  wms_bin_thu2_sl_no,  wms_bin_repl_alloc_ln_no,  wms_bin_repl_doc_line_no,  wms_bin_thu2_id,  wms_bin_su2,  wms_bin_su_slno2,  wms_bin_su_qty2,  wms_bin_prof_type,  wms_bin_trans_uom,  wms_bin_trans_uom_qty,  wms_bin_plan_rsn_code,  wms_bin_pln_itm_attr1,  wms_bin_pln_itm_attr10,  wms_bin_pln_itm_attr2,  wms_bin_pln_itm_attr3,  wms_bin_pln_itm_attr4,  wms_bin_pln_itm_attr5,  wms_bin_pln_itm_attr6,  wms_bin_pln_itm_attr7,  wms_bin_pln_itm_attr8,  wms_bin_pln_itm_attr9,        
 	etlcreateddatetime
	FROM stg.stg_wms_bin_plan_item_dtl;
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
ALTER PROCEDURE dwh.usp_f_binplandetails(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
