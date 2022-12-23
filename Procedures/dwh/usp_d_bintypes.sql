CREATE PROCEDURE dwh.usp_d_bintypes(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
	WHERE 	d.sourceid 		= p_sourceId 
		AND d.dataflowflag 	= p_dataflowflag
		AND d.targetobject 	= p_targetobject;

    SELECT COUNT(1) INTO srccnt
	FROM stg.stg_wms_bin_type_hdr;

	UPDATE dwh.D_BinTypes t
    SET 
		bin_div_key				= COALESCE(d.div_key,-1),
		bin_typ_desc 			= s. wms_bin_typ_desc,
		bin_typ_status 			= s. wms_bin_typ_status,
		bin_typ_Width 			= s. wms_bin_typ_Width,
		bin_typ_Height 			= s. wms_bin_typ_Height,
		bin_typ_Depth 			= s. wms_bin_typ_Depth,
		bin_typ_dim_uom 		= s. wms_bin_typ_dim_uom,
		bin_typ_Volume 			= s. wms_bin_typ_Volume,
		bin_typ_Vol_uom 		= s. wms_bin_typ_Vol_uom,
		bin_typ_max_per_wt 		= s. wms_bin_typ_max_per_wt,
		bin_typ_max_wt_uom 		= s. wms_bin_typ_max_wt_uom,
		bin_typ_cap_indicator 	= s. wms_bin_typ_cap_indicator,
		bin_timestamp 			= s. wms_bin_timestamp,
		bin_created_by 			= s. wms_bin_created_by,
		bin_created_dt 			= s. wms_bin_created_dt,
		bin_modified_by 		= s. wms_bin_modified_by,
		bin_modified_dt 		= s. wms_bin_modified_dt,
		bin_one_bin_one_pal 	= s. wms_bin_one_bin_one_pal,
		bin_typ_one_bin 		= s. wms_bin_typ_one_bin,
		bin_typ_area 			= s. wms_bin_typ_area,
		bin_typ_area_uom 		= s. wms_bin_typ_area_uom,
		bin_typ_vol_actual		= (case when s.wms_bin_typ_vol_uom='CUM' then s.wms_bin_typ_volume*1000000 else s.wms_bin_typ_volume end),
		bin_typ_div_code		= left(s.wms_bin_typ_loc_code,6),
		bin_typ_vol_calc		= ((case when bin_typ_dim_uom='METER' then bin_typ_depth*100 else bin_typ_depth end)*
								   (case when bin_typ_dim_uom='METER' then bin_typ_width*100 else bin_typ_width end)*
								   (case when bin_typ_dim_uom='METER' then bin_typ_height*100 else bin_typ_height end)),
		etlactiveind 			= 1,
		etljobname 				= p_etljobname,
		envsourcecd 			= p_envsourcecd ,
		datasourcecd 			= p_datasourcecd ,
		etlupdatedatetime 		= NOW()
    FROM stg.stg_wms_bin_type_hdr s
	LEFT JOIN dwh.d_division d
	ON	d.div_code			= left(s.wms_bin_typ_loc_code,6)
	AND	d.div_ou			= s.wms_bin_typ_ou
    WHERE t.bin_typ_ou 		= s.wms_bin_typ_ou
	AND t.bin_typ_code 		= s.wms_bin_typ_code
	AND t.bin_typ_loc_code 	= s.wms_bin_typ_loc_code;
    
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

	INSERT INTO dwh.D_BinTypes

	(
		bin_div_key,
		bin_typ_ou,					bin_typ_code,				bin_typ_loc_code,
		bin_typ_desc,				bin_typ_status,				bin_typ_Width,				bin_typ_Height,			bin_typ_Depth,
		bin_typ_dim_uom,			bin_typ_Volume,				bin_typ_Vol_uom,			bin_typ_max_per_wt,		bin_typ_max_wt_uom,
		bin_typ_cap_indicator,		bin_timestamp,				bin_created_by,				bin_created_dt,			bin_modified_by,
		bin_modified_dt,			bin_one_bin_one_pal,		bin_typ_one_bin,			bin_typ_area,			bin_typ_area_uom,
		bin_typ_vol_actual,		
		bin_typ_div_code,
		bin_typ_vol_calc,
		etlactiveind,		        etljobname,			 		envsourcecd, 				datasourcecd, 			etlcreatedatetime
	)
	
    SELECT 
	
		COALESCE(d.div_key,-1),
		s.wms_bin_typ_ou,				s.wms_bin_typ_code,				s.wms_bin_typ_loc_code,	
		s.wms_bin_typ_desc,				s.wms_bin_typ_status,			s.wms_bin_typ_Width,			s.wms_bin_typ_Height,		s.wms_bin_typ_Depth,
		s.wms_bin_typ_dim_uom,			s.wms_bin_typ_Volume,			s.wms_bin_typ_Vol_uom,			s.wms_bin_typ_max_per_wt,	s.wms_bin_typ_max_wt_uom,
		s.wms_bin_typ_cap_indicator,	s.wms_bin_timestamp,			s.wms_bin_created_by,			s.wms_bin_created_dt,		s.wms_bin_modified_by,	
		s.wms_bin_modified_dt, 			s.wms_bin_one_bin_one_pal,		s.wms_bin_typ_one_bin,			s.wms_bin_typ_area,			s.wms_bin_typ_area_uom,	
		(case when s.wms_bin_typ_vol_uom='CUM' then s.wms_bin_typ_volume*1000000 else s.wms_bin_typ_volume end),
		left(s.wms_bin_typ_loc_code,6),
		((case when bin_typ_dim_uom='METER' then bin_typ_depth*100 else bin_typ_depth end)*(case when bin_typ_dim_uom='METER' then bin_typ_width*100 else bin_typ_width end)*(case when bin_typ_dim_uom='METER' then bin_typ_height*100 else bin_typ_height end)),
					1			,		p_etljobname,				p_envsourcecd,					p_datasourcecd,				NOW()

	FROM stg.stg_wms_bin_type_hdr s
	LEFT JOIN dwh.d_division d
	ON	d.div_code			= left(s.wms_bin_typ_loc_code,6)
	AND	d.div_ou			= s.wms_bin_typ_ou
    LEFT JOIN dwh.D_BinTypes t
    ON 	s.wms_bin_typ_ou 		= t.bin_typ_ou
	AND s.wms_bin_typ_code 		= t.bin_typ_code
	AND s.wms_bin_typ_loc_code	= t.bin_typ_loc_code 
    WHERE t.bin_typ_ou IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
	IF p_rawstorageflag = 1
	THEN
  
	
	INSERT INTO raw.raw_wms_bin_type_hdr
	(
	wms_bin_typ_ou, wms_bin_typ_code, wms_bin_typ_loc_code, wms_bin_typ_desc, wms_bin_typ_status,
    wms_bin_typ_width, wms_bin_typ_height, wms_bin_typ_depth, wms_bin_typ_dim_uom, wms_bin_typ_volume,
    wms_bin_typ_vol_uom, wms_bin_typ_max_per_wt, wms_bin_typ_max_wt_uom, wms_bin_typ_cap_indicator, wms_bin_typ_user_def1, 
        wms_bin_typ_user_def2, wms_bin_typ_user_def3, wms_bin_timestamp, wms_bin_created_by, wms_bin_created_dt, 
        wms_bin_modified_by, wms_bin_modified_dt, wms_bin_one_bin_one_pal, wms_bin_typ_permitted_uids, wms_bin_typ_one_bin,
        wms_bin_typ_area, wms_bin_typ_area_uom, wms_bin_typ_qty_capacity, wms_bin_typ_prmtd_no_ethu, etlcreateddatetime

	)
	SELECT 
	wms_bin_typ_ou, wms_bin_typ_code, wms_bin_typ_loc_code, wms_bin_typ_desc, wms_bin_typ_status,
    wms_bin_typ_width, wms_bin_typ_height, wms_bin_typ_depth, wms_bin_typ_dim_uom, wms_bin_typ_volume,
    wms_bin_typ_vol_uom, wms_bin_typ_max_per_wt, wms_bin_typ_max_wt_uom, wms_bin_typ_cap_indicator, wms_bin_typ_user_def1, 
        wms_bin_typ_user_def2, wms_bin_typ_user_def3, wms_bin_timestamp, wms_bin_created_by, wms_bin_created_dt, 
        wms_bin_modified_by, wms_bin_modified_dt, wms_bin_one_bin_one_pal, wms_bin_typ_permitted_uids, wms_bin_typ_one_bin,
        wms_bin_typ_area, wms_bin_typ_area_uom, wms_bin_typ_qty_capacity, wms_bin_typ_prmtd_no_ethu, etlcreateddatetime

	FROM stg.stg_wms_bin_type_hdr;	
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