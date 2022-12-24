CREATE OR REPLACE PROCEDURE dwh.usp_f_packitemserialdetail(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
    SELECT d.jobname, h.envsourcecode, h.datasourcecode, d.latestbatchid, d.targetprocedurename, h.rawstorageflag
    INTO p_etljobname, p_envsourcecd, p_datasourcecd, p_batchid, p_taskname, p_rawstorageflag
    FROM ods.controldetail d
    INNER JOIN ods.controlheader h
        ON d.sourceid = h.sourceid
    WHERE d.sourceid = p_sourceId
        AND d.dataflowflag = p_dataflowflag
        AND d.targetobject = p_targetobject;

    SELECT COUNT(1) INTO srccnt
    FROM stg.stg_wms_pack_item_sr_dtl;

    UPDATE dwh.F_PackItemSerialDetail t
    SET
		pack_itm_sl_dtl_loc_key = COALESCE(l.loc_key,-1),
		pack_itm_sl_dtl_itm_hdr_key = COALESCE(i.itm_hdr_key,-1),
		pack_itm_sl_dtl_thu_key = COALESCE(th.thu_key,-1),
        item_sl_loc_code        = s.wms_item_sl_loc_code,
        item_sl_exec_no         = s.wms_item_sl_exec_no,
        item_sl_ou              = s.wms_item_sl_ou,
        item_sl_line_no         = s.wms_item_sl_line_no,
        item_sl_thuid           = s.wms_item_sl_thuid,
        item_sl_itm             = s.wms_item_sl_itm,
        item_sl_serno           = s.wms_item_sl_serno,
        item_thu_serno          = s.wms_item_thu_serno,
        etlactiveind            = 1,
        etljobname              = p_etljobname,
        envsourcecd             = p_envsourcecd,
        datasourcecd            = p_datasourcecd,
        etlupdatedatetime       = NOW()
    FROM stg.stg_wms_pack_item_sr_dtl s
	LEFT JOIN dwh.d_location l 		
		ON  s.wms_item_sl_loc_code 	 = l.loc_code 
        AND s.wms_item_sl_ou         = l.loc_ou
	LEFT JOIN dwh.d_itemheader i 			
		ON  s.wms_item_sl_itm	 	 = i.itm_code
		AND s.wms_item_sl_ou		 = i.itm_ou
	LEFT JOIN dwh.d_thu th 		
		ON  s.wms_item_sl_thuid		 = th.thu_id 
		AND s.wms_item_sl_ou 		 = th.thu_ou
    WHERE t.item_sl_loc_code        = s.wms_item_sl_loc_code
     AND  t.item_sl_exec_no         = s.wms_item_sl_exec_no
     AND  t.item_sl_ou              = s.wms_item_sl_ou
     AND  t.item_sl_line_no         = s.wms_item_sl_line_no
     AND  t.item_sl_thuid           = s.wms_item_sl_thuid
     AND  COALESCE(t.item_sl_itm,'') = COALESCE(s.wms_item_sl_itm,'')  
     AND  t.item_sl_serno           = s.wms_item_sl_serno
     AND  t.item_thu_serno          = s.wms_item_thu_serno;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_PackItemSerialDetail
    (
		pack_itm_sl_dtl_loc_key,	pack_itm_sl_dtl_itm_hdr_key,	pack_itm_sl_dtl_thu_key,
        item_sl_loc_code, 			item_sl_exec_no, 				item_sl_ou, 				item_sl_line_no, 		item_sl_thuid, 
		item_sl_itm, 				item_sl_serno, 					item_thu_serno, 			etlactiveind, 			etljobname, 
		envsourcecd, 				datasourcecd, 					etlcreatedatetime
    )

    SELECT
		COALESCE(l.loc_key,-1),		COALESCE(i.itm_hdr_key,-1),		COALESCE(th.thu_key,-1),
        s.wms_item_sl_loc_code, 	s.wms_item_sl_exec_no, 			s.wms_item_sl_ou, 			s.wms_item_sl_line_no, 	s.wms_item_sl_thuid, 
		s.wms_item_sl_itm, 			s.wms_item_sl_serno, 			s.wms_item_thu_serno, 		1, 						p_etljobname, 
		p_envsourcecd, 				p_datasourcecd, 				NOW()
    FROM stg.stg_wms_pack_item_sr_dtl s
	LEFT JOIN dwh.d_location l 		
		ON  s.wms_item_sl_loc_code 	 = l.loc_code 
        AND s.wms_item_sl_ou         = l.loc_ou
	LEFT JOIN dwh.d_itemheader i 			
		ON  s.wms_item_sl_itm	 	 = i.itm_code
		AND s.wms_item_sl_ou		 = i.itm_ou
	LEFT JOIN dwh.d_thu th 		
		ON  s.wms_item_sl_thuid		 = th.thu_id 
		AND s.wms_item_sl_ou 		 = th.thu_ou
    LEFT JOIN dwh.F_PackItemSerialDetail t
        ON   s.wms_item_sl_loc_code = t.item_sl_loc_code  
        AND  s.wms_item_sl_exec_no  = t.item_sl_exec_no    
        AND  s.wms_item_sl_ou       = t.item_sl_ou              
        AND  s.wms_item_sl_line_no  = t.item_sl_line_no    
        AND  s.wms_item_sl_thuid    = t.item_sl_thuid        
        AND  COALESCE(s.wms_item_sl_itm,'')      = COALESCE(t.item_sl_itm,'')      
        AND  s.wms_item_sl_serno    = t.item_sl_serno        
        AND  s.wms_item_thu_serno   = t.item_thu_serno      
    WHERE t.item_sl_loc_code IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_wms_pack_item_sr_dtl
    (
        wms_item_sl_loc_code, 	wms_item_sl_exec_no, 		wms_item_sl_ou, 		wms_item_sl_line_no, 	wms_item_sl_thuid, 
		wms_item_sl_itm, 		wms_item_sl_serno, 			wms_item_thu_serno, 	etlcreateddatetime
    )
    SELECT
        wms_item_sl_loc_code, 	wms_item_sl_exec_no, 		wms_item_sl_ou, 		wms_item_sl_line_no, 	wms_item_sl_thuid, 
		wms_item_sl_itm, 		wms_item_sl_serno, 			wms_item_thu_serno, 	etlcreateddatetime
    FROM stg.stg_wms_pack_item_sr_dtl;
    
    END IF;
    EXCEPTION WHEN others THEN
        get stacked diagnostics
            p_errorid   = returned_sqlstate,
            p_errordesc = message_text;
    CALL ods.usp_etlerrorinsert(p_sourceid, p_targetobject, p_dataflowflag, p_batchid,p_taskname, 'sp_ExceptionHandling', p_errorid, p_errordesc, null);
       select 0 into inscnt;
       select 0 into updcnt;
END;
$$;