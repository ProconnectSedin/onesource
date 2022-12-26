-- PROCEDURE: dwh.usp_f_packexecthudetailhistory(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_packexecthudetailhistory(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_packexecthudetailhistory(
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
    FROM stg.stg_wms_pack_exec_thu_dtl_hist;

    UPDATE dwh.F_PackExecTHUDetailHistory t
    SET
		pack_exec_hdr_key                 = COALESCE(fh.pack_exe_hdr_key,-1),        
        pack_exec_loc_key                 = COALESCE(l.loc_key,-1),
        pack_exec_thu_key                 = COALESCE(dt.thu_key,-1),
        pack_thu_lineno                   = s.wms_pack_thu_lineno,
        pack_picklist_no                  = s.wms_pack_picklist_no,
        pack_so_no                        = s.wms_pack_so_no,
        pack_so_line_no                   = s.wms_pack_so_line_no,
        pack_so_sch_lineno                = s.wms_pack_so_sch_lineno,
        pack_thu_item_code                = s.wms_pack_thu_item_code,
        pack_thu_item_qty                 = s.wms_pack_thu_item_qty,
        pack_thu_pack_qty                 = s.wms_pack_thu_pack_qty,
        pack_thu_item_batch_no            = s.wms_pack_thu_item_batch_no,
        pack_thu_item_sr_no               = s.wms_pack_thu_item_sr_no,
        pack_lot_no                       = s.wms_pack_lot_no,
        pack_thu_ser_no                   = s.wms_pack_thu_ser_no,
        pack_uid_ser_no                   = s.wms_pack_uid_ser_no,
        pack_allocated_qty                = s.wms_pack_allocated_qty,
        pack_planned_qty                  = s.wms_pack_planned_qty,
        pack_tolerance_qty                = s.wms_pack_tolerance_qty,
        pack_packed_from_uid_serno        = s.wms_pack_packed_from_uid_serno,
        pack_factory_pack                 = s.wms_pack_factory_pack,
        pack_source_thu_ser_no            = s.wms_pack_source_thu_ser_no,
        pack_reason_code                  = s.wms_pack_reason_code,
        pack_created_by                   = s.wms_pack_created_by,
        pack_created_date                 = s.wms_pack_created_date,
        etlactiveind                      = 1,
        etljobname                        = p_etljobname,
        envsourcecd                       = p_envsourcecd,
        datasourcecd                      = p_datasourcecd,
        etlupdatedatetime                 = NOW()
    FROM stg.stg_wms_pack_exec_thu_dtl_hist s

    LEFT JOIN dwh.F_PackExecHeader fh
	ON 		s.wms_pack_exec_ou 				=   fh.pack_exec_ou
	AND   	s.wms_pack_loc_code 			=   fh.pack_loc_code
	AND     s.wms_pack_exec_no 				=   fh.pack_exec_no
	
    LEFT JOIN dwh.d_location L      
            ON s.wms_pack_loc_code           = L.loc_code 
            AND s.wms_pack_exec_ou           = L.loc_ou
    LEFT JOIN dwh.d_thu dt      
            ON s.wms_pack_thu_id             = dt.thu_id 
            AND s.wms_pack_exec_ou           = dt.thu_ou
			
   WHERE    t.pack_exec_ou               = s.wms_pack_exec_ou
	AND		t.pack_loc_code              = s.wms_pack_loc_code
	AND		t.pack_exec_no               = s.wms_pack_exec_no
	AND 	t.pack_thu_id                = s.wms_pack_thu_id
	AND 	t.pack_thu_lineno 			 = s.wms_pack_thu_lineno
	AND 	t.pack_thu_ser_no		 	 = s.wms_pack_thu_ser_no;

    GET DIAGNOSTICS updcnt = ROW_COUNT;
/*
	DELETE FROM dwh.F_PackExecTHUDetailHistory t
	USING stg.stg_wms_pack_exec_thu_dtl_hist s
		WHERE  t.pack_exec_ou               = s.wms_pack_exec_ou
	AND		t.pack_loc_code              = s.wms_pack_loc_code
	AND		t.pack_exec_no               = s.wms_pack_exec_no
	AND 	t.pack_thu_id                = s.wms_pack_thu_id
	AND 	t.pack_thu_lineno 			 = s.wms_pack_thu_lineno
	AND 	t.pack_thu_ser_no		 	 = s.wms_pack_thu_ser_no;

-- 	AND 	COALESCE(fh.oub_modified_date,fh.oub_created_date)::DATE >= (CURRENT_DATE - INTERVAL '90 days')::DATE;	
*/
    INSERT INTO dwh.F_PackExecTHUDetailHistory
    (
      pack_exec_hdr_key,pack_exec_loc_key,pack_exec_thu_key, pack_loc_code, pack_exec_no, pack_exec_ou, pack_thu_id, pack_thu_lineno, pack_picklist_no, pack_so_no, pack_so_line_no, pack_so_sch_lineno, pack_thu_item_code, pack_thu_item_qty, pack_thu_pack_qty, pack_thu_item_batch_no, pack_thu_item_sr_no, pack_lot_no, pack_thu_ser_no, pack_uid_ser_no, pack_allocated_qty, pack_planned_qty, pack_tolerance_qty, pack_packed_from_uid_serno, pack_factory_pack, pack_source_thu_ser_no, pack_reason_code, pack_created_by, pack_created_date, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
       COALESCE(fh.pack_exe_hdr_key,-1),COALESCE(l.loc_key,-1),COALESCE(dt.thu_key,-1),s.wms_pack_loc_code, s.wms_pack_exec_no, s.wms_pack_exec_ou, s.wms_pack_thu_id, s.wms_pack_thu_lineno, s.wms_pack_picklist_no, s.wms_pack_so_no, s.wms_pack_so_line_no, s.wms_pack_so_sch_lineno, s.wms_pack_thu_item_code, s.wms_pack_thu_item_qty, s.wms_pack_thu_pack_qty, s.wms_pack_thu_item_batch_no, s.wms_pack_thu_item_sr_no, s.wms_pack_lot_no, s.wms_pack_thu_ser_no, s.wms_pack_uid_ser_no, s.wms_pack_allocated_qty, s.wms_pack_planned_qty, s.wms_pack_tolerance_qty, s.wms_pack_packed_from_uid_serno, s.wms_pack_factory_pack, s.wms_pack_source_thu_ser_no, s.wms_pack_reason_code, s.wms_pack_created_by, s.wms_pack_created_date, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_wms_pack_exec_thu_dtl_hist s

    Left JOIN dwh.F_PackExecHeader fh
	ON 		s.wms_pack_exec_ou 				=   fh.pack_exec_ou
	AND   	s.wms_pack_loc_code 			=   fh.pack_loc_code
	AND     s.wms_pack_exec_no 				=   fh.pack_exec_no
	
	LEFT JOIN dwh.d_location L      
            ON s.wms_pack_loc_code           = L.loc_code 
            AND s.wms_pack_exec_ou           = L.loc_ou
    LEFT JOIN dwh.d_thu dt      
            ON s.wms_pack_thu_id             = dt.thu_id 
            AND s.wms_pack_exec_ou           = dt.thu_ou
	LEFT JOIN dwh.F_PackExecTHUDetailHistory t
		ON   	t.pack_exec_ou               = s.wms_pack_exec_ou
		AND		t.pack_loc_code              = s.wms_pack_loc_code
		AND		t.pack_exec_no               = s.wms_pack_exec_no
		AND 	t.pack_thu_id                = s.wms_pack_thu_id
		AND 	t.pack_thu_lineno 			 = s.wms_pack_thu_lineno
		AND 	t.pack_thu_ser_no		 	 = s.wms_pack_thu_ser_no
	WHERE 	t.pack_exec_ou IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
/*
    UPDATE	dwh.F_PackExecTHUDetailHistory s
    SET		pack_exec_hdr_key	= fh.pack_exe_hdr_key,
	 		etlupdatedatetime	= NOW()
    FROM	dwh.F_PackExecHeader fh  
    WHERE	s.pack_exec_ou 		=   fh.pack_exec_ou
	AND   	s.pack_loc_code 	=   fh.pack_loc_code
	AND     s.pack_exec_no 		=   fh.pack_exec_no
    AND		COALESCE(s.pack_created_date)::DATE >= (CURRENT_DATE - INTERVAL '90 days')::DATE;

    select 0 into updcnt;
*/	
    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_wms_pack_exec_thu_dtl_hist
    (
        wms_pack_loc_code, wms_pack_exec_no, wms_pack_exec_ou, wms_pack_thu_id, wms_pack_thu_lineno, wms_pack_picklist_no, wms_pack_so_no, wms_pack_so_line_no, wms_pack_so_sch_lineno, wms_pack_thu_item_code, wms_pack_thu_item_qty, wms_pack_thu_pack_qty, wms_pack_thu_item_batch_no, wms_pack_thu_item_sr_no, wms_pack_lot_no, wms_pack_thu_ser_no, wms_pack_uid1_ser_no, wms_pack_uid_ser_no, wms_pack_allocated_qty, wms_pack_planned_qty, wms_pack_tolerance_qty, wms_pack_uid_cons, wms_pack_packed_from_uid_serno, wms_pack_factory_pack, wms_pack_source_thu_ser_no, wms_pack_reason_code, wms_pack_created_by, wms_pack_created_date, etlcreateddatetime
    )
    SELECT
        wms_pack_loc_code, wms_pack_exec_no, wms_pack_exec_ou, wms_pack_thu_id, wms_pack_thu_lineno, wms_pack_picklist_no, wms_pack_so_no, wms_pack_so_line_no, wms_pack_so_sch_lineno, wms_pack_thu_item_code, wms_pack_thu_item_qty, wms_pack_thu_pack_qty, wms_pack_thu_item_batch_no, wms_pack_thu_item_sr_no, wms_pack_lot_no, wms_pack_thu_ser_no, wms_pack_uid1_ser_no, wms_pack_uid_ser_no, wms_pack_allocated_qty, wms_pack_planned_qty, wms_pack_tolerance_qty, wms_pack_uid_cons, wms_pack_packed_from_uid_serno, wms_pack_factory_pack, wms_pack_source_thu_ser_no, wms_pack_reason_code, wms_pack_created_by, wms_pack_created_date, etlcreateddatetime
    FROM stg.stg_wms_pack_exec_thu_dtl_hist;
    
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
ALTER PROCEDURE dwh.usp_f_packexecthudetailhistory(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
