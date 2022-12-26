CREATE OR REPLACE PROCEDURE dwh.usp_f_grthuheader(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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

	SELECT d.jobname,h.envsourcecode,h.datasourcecode,d.latestbatchid,d.targetprocedurename, h.rawstorageflag 
	INTO p_etljobname, p_envsourcecd, p_datasourcecd, p_batchid, p_taskname, p_rawstorageflag
    FROM ods.controldetail d 
    INNER JOIN ods.controlheader h
        ON d.sourceid = h.sourceid
    WHERE d.sourceid = p_sourceId 
        AND d.dataflowflag = p_dataflowflag
        AND d.targetobject = p_targetobject;

    SELECT COUNT(*) INTO srccnt
    FROM stg.stg_wms_gr_exec_thu_hdr;

    UPDATE dwh.f_gRTHUheader t
    SET	
	    gr_loc_key  = COALESCE(l.loc_key,-1),
		gr_thu_key  = COALESCE(h.thu_key,-1),
        gr_thu_desc = s.wms_gr_thu_desc,
        gr_thu_sr_status = s.wms_gr_thu_sr_status,
        gr_thu_su = s.wms_gr_thu_su,
        gr_pal_status = s.wms_gr_pal_status,
        etlactiveind = 1,
        etljobname = p_etljobname,
        envsourcecd = p_envsourcecd ,
        datasourcecd = p_datasourcecd ,
        etlupdatedatetime = NOW()    
    FROM stg.stg_wms_gr_exec_thu_hdr s
	LEFT JOIN dwh.d_location l
	ON 	s.wms_gr_loc_code =	l.loc_code
	AND	s.wms_gr_exec_ou  =	l.loc_ou
	LEFT JOIN dwh.d_thu H
	ON  s.wms_gr_thu_id   = h.thu_id
	AND s.wms_gr_exec_ou  = h.thu_ou
    WHERE t.gr_loc_code = s.wms_gr_loc_code
    AND t.gr_exec_no = s.wms_gr_exec_no
    AND t.gr_exec_ou = s.wms_gr_exec_ou
    AND t.gr_thu_id = s.wms_gr_thu_id
    AND t.gr_thu_sno = s.wms_gr_thu_sno
    AND t.gr_thu_su = s.wms_gr_thu_su
    AND t.gr_thu_uid_ser_no = s.wms_gr_thu_uid_ser_no;
    
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_GRTHUheader 
    (
        gr_loc_key,gr_thu_key,gr_loc_code, gr_exec_no, gr_exec_ou, gr_thu_id, gr_thu_sno, gr_thu_desc, gr_thu_sr_status, gr_thu_su, gr_thu_uid_ser_no, gr_pal_status, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )
    
    SELECT
        COALESCE(l.loc_key,-1),COALESCE(h.thu_key,-1),s.wms_gr_loc_code, s.wms_gr_exec_no, s.wms_gr_exec_ou, s.wms_gr_thu_id, s.wms_gr_thu_sno, s.wms_gr_thu_desc, s.wms_gr_thu_sr_status, s.wms_gr_thu_su, s.wms_gr_thu_uid_ser_no, s.wms_gr_pal_status, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_wms_gr_exec_thu_hdr s
	LEFT JOIN dwh.d_location l
	ON 	s.wms_gr_loc_code =	l.loc_code
	AND	s.wms_gr_exec_ou  =	l.loc_ou
	LEFT JOIN dwh.d_thu H
	ON  s.wms_gr_thu_id   = h.thu_id
	AND s.wms_gr_exec_ou  = h.thu_ou
    LEFT JOIN dwh.F_GRTHUheader t
    ON s.wms_gr_loc_code = t.gr_loc_code
    AND s.wms_gr_exec_no = t.gr_exec_no
    AND s.wms_gr_exec_ou = t.gr_exec_ou
    AND s.wms_gr_thu_id = t.gr_thu_id
    AND s.wms_gr_thu_sno = t.gr_thu_sno
    AND s.wms_gr_thu_su = t.gr_thu_su
    AND s.wms_gr_thu_uid_ser_no = t.gr_thu_uid_ser_no
    WHERE t.gr_loc_code IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN
    
    INSERT INTO raw.raw_wms_gr_exec_thu_hdr
    (   
        wms_gr_loc_code, wms_gr_exec_no, wms_gr_exec_ou, wms_gr_thu_id, wms_gr_thu_sno, wms_gr_thu_desc, wms_gr_thu_class, wms_gr_thu_qty, wms_gr_thu_owner, wms_gr_thu_consumables, wms_gr_thu_sr_status, wms_gr_thu_tod, wms_gr_thu_su, wms_gr_thu_uid_ser_no, wms_gr_pal_status, wms_gr_thu_consumables_qty, wms_gr_thu_su2, wms_gr_thu_uid2_ser_no
    )
    SELECT 
        wms_gr_loc_code, wms_gr_exec_no, wms_gr_exec_ou, wms_gr_thu_id, wms_gr_thu_sno, wms_gr_thu_desc, wms_gr_thu_class, wms_gr_thu_qty, wms_gr_thu_owner, wms_gr_thu_consumables, wms_gr_thu_sr_status, wms_gr_thu_tod, wms_gr_thu_su, wms_gr_thu_uid_ser_no, wms_gr_pal_status, wms_gr_thu_consumables_qty, wms_gr_thu_su2, wms_gr_thu_uid2_ser_no
    FROM stg.stg_wms_gr_exec_thu_hdr;
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