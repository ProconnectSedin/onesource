-- PROCEDURE: dwh.usp_f_packplandetail(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_packplandetail(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_packplandetail(
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
	p_depsource		VARCHAR(100);
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
	
	
    SELECT COUNT(1) INTO srccnt
    FROM stg.stg_wms_pack_plan_dtl;

    UPDATE dwh.F_PackPlanDetail t
    SET
        pack_pln_hdr_key                  = fh.pack_pln_hdr_key,
		pack_pln_dtl_loc_key			  = COALESCE(l.loc_key,-1),
		pack_pln_dtl_itm_hdr_key		  = COALESCE(i.itm_hdr_key,-1),
		pack_pln_dtl_thu_key			  = COALESCE(th.thu_key,-1),
        pack_picklist_no                  = s.wms_pack_picklist_no,
        pack_so_no                        = s.wms_pack_so_no,
        pack_so_line_no                   = s.wms_pack_so_line_no,
        pack_so_sch_lineno                = s.wms_pack_so_sch_lineno,
        pack_item_code                    = s.wms_pack_item_code,
        pack_item_batch_no                = s.wms_pack_item_batch_no,
        pack_item_sr_no                   = s.wms_pack_item_sr_no,
        pack_so_qty                       = s.wms_pack_so_qty,
        pack_uid_sr_no                    = s.wms_pack_uid_sr_no,
        pack_thu_sr_no                    = s.wms_pack_thu_sr_no,
        pack_pre_packing_bay              = s.wms_pack_pre_packing_bay,
        pack_lot_no                       = s.wms_pack_lot_no,
        pack_su                           = s.wms_pack_su,
        pack_su_type                      = s.wms_pack_su_type,
        pack_thu_id                       = s.wms_pack_thu_id,
        pack_plan_qty                     = s.wms_pack_plan_qty,
        pack_allocated_qty                = s.wms_pack_allocated_qty,
        pack_tolerance_qty                = s.wms_pack_tolerance_qty,
        pack_customer_serial_no           = s.wms_pack_customer_serial_no,
        pack_warranty_serial_no           = s.wms_pack_warranty_serial_no,
        pack_packed_from_uid_serno        = s.wms_pack_packed_from_uid_serno,
        pack_source_thu_ser_no            = s.wms_pack_source_thu_ser_no,
        pack_item_attribute1              = s.wms_pack_item_attribute1,
        etlactiveind                      = 1,
        etljobname                        = p_etljobname,
        envsourcecd                       = p_envsourcecd,
        datasourcecd                      = p_datasourcecd,
        etlupdatedatetime                 = NOW()
    FROM stg.stg_wms_pack_plan_dtl s
    INNER JOIN dwh.f_packplanheader fh 		
		ON  s.wms_pack_loc_code 	 = fh.pack_loc_code 
        AND s.wms_pack_pln_no        = fh.pack_pln_no
        AND s.wms_pack_pln_ou        = fh.pack_pln_ou
	LEFT JOIN dwh.d_location l 		
		ON  s.wms_pack_loc_code 	 = l.loc_code 
        AND s.wms_pack_pln_ou        = l.loc_ou
    LEFT JOIN dwh.d_itemheader i 			
		ON  s.wms_pack_item_code	 = i.itm_code
		AND s.wms_pack_pln_ou		 = i.itm_ou
	LEFT JOIN dwh.d_thu th 		
		ON  s.wms_pack_thu_id		 = th.thu_id 
		AND s.wms_pack_pln_ou 		 = th.thu_ou  
    WHERE t.pack_loc_code = s.wms_pack_loc_code
    AND   t.pack_pln_no   = s.wms_pack_pln_no
    AND   t.pack_pln_ou   = s.wms_pack_pln_ou
    AND   t.pack_lineno   = s.wms_pack_lineno;
	
    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_PackPlanDetail
    (
		pack_pln_hdr_key,           pack_pln_dtl_loc_key,		    pack_pln_dtl_itm_hdr_key,	pack_pln_dtl_thu_key,
        pack_loc_code, 				pack_pln_no, 					pack_pln_ou, 				pack_lineno, 				pack_picklist_no, 
		pack_so_no, 				pack_so_line_no, 				pack_so_sch_lineno, 		pack_item_code, 			pack_item_batch_no, 
		pack_item_sr_no, 			pack_so_qty, 					pack_uid_sr_no, 			pack_thu_sr_no, 			pack_pre_packing_bay, 
		pack_lot_no, 				pack_su, 						pack_su_type, 				pack_thu_id, 				pack_plan_qty, 
		pack_allocated_qty, 		pack_tolerance_qty, 			pack_customer_serial_no, 	pack_warranty_serial_no, 	pack_packed_from_uid_serno, 
		pack_source_thu_ser_no, 	pack_item_attribute1, 			etlactiveind, 				etljobname, 				envsourcecd, 
		datasourcecd, 				etlcreatedatetime
    )

    SELECT
		fh.pack_pln_hdr_key,            COALESCE(l.loc_key,-1),			COALESCE(i.itm_hdr_key,-1),		COALESCE(th.thu_key,-1),
        s.wms_pack_loc_code, 			s.wms_pack_pln_no, 				s.wms_pack_pln_ou, 				s.wms_pack_lineno, 				s.wms_pack_picklist_no, 
		s.wms_pack_so_no, 				s.wms_pack_so_line_no, 			s.wms_pack_so_sch_lineno, 		s.wms_pack_item_code, 			s.wms_pack_item_batch_no, 
		s.wms_pack_item_sr_no, 			s.wms_pack_so_qty, 				s.wms_pack_uid_sr_no, 			s.wms_pack_thu_sr_no, 			s.wms_pack_pre_packing_bay, 
		s.wms_pack_lot_no, 				s.wms_pack_su, 					s.wms_pack_su_type, 			s.wms_pack_thu_id, 				s.wms_pack_plan_qty, 
		s.wms_pack_allocated_qty, 		s.wms_pack_tolerance_qty, 		s.wms_pack_customer_serial_no, 	s.wms_pack_warranty_serial_no, 	s.wms_pack_packed_from_uid_serno, 
		s.wms_pack_source_thu_ser_no, 	s.wms_pack_item_attribute1, 	1, 								p_etljobname, 					p_envsourcecd, 
		p_datasourcecd, NOW()
    FROM stg.stg_wms_pack_plan_dtl s
    INNER JOIN dwh.f_packplanheader fh 		
		ON  s.wms_pack_pln_ou        = fh.pack_pln_ou
        AND s.wms_pack_loc_code 	 = fh.pack_loc_code 
        AND s.wms_pack_pln_no        = fh.pack_pln_no
        
	LEFT JOIN dwh.d_location l 		
		ON  s.wms_pack_pln_ou        = l.loc_ou
        AND s.wms_pack_loc_code 	 = l.loc_code 
         
	LEFT JOIN dwh.d_itemheader i 			
		ON  s.wms_pack_pln_ou		 = i.itm_ou
        AND s.wms_pack_item_code	 = i.itm_code
		 
	LEFT JOIN dwh.d_thu th 		
		ON  s.wms_pack_pln_ou 		 = th.thu_ou
        AND s.wms_pack_thu_id		 = th.thu_id 
		  
    LEFT JOIN dwh.F_PackPlanDetail t
    ON  s.wms_pack_pln_ou 	 = t.pack_pln_ou
    AND s.wms_pack_loc_code  = t.pack_loc_code
    AND s.wms_pack_pln_no 	 = t.pack_pln_no
    AND s.wms_pack_lineno 	 = t.pack_lineno
    WHERE t.pack_loc_code IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    	IF p_rawstorageflag = 1
    THEN
	
    INSERT INTO raw.raw_wms_pack_plan_dtl
    (
        wms_pack_loc_code, 			    wms_pack_pln_no, 			wms_pack_pln_ou, 			wms_pack_lineno, 				wms_pack_picklist_no, 
		wms_pack_so_no, 				wms_pack_so_line_no, 		wms_pack_so_sch_lineno, 	wms_pack_item_code, 			wms_pack_item_batch_no, 
		wms_pack_item_sr_no, 			wms_pack_so_qty, 			wms_pack_uid_sr_no, 		wms_pack_thu_sr_no, 			wms_pack_pre_packing_bay, 
		wms_pack_lot_no, 				wms_pack_su, 				wms_pack_su_type, 			wms_pack_thu_id, 				wms_pack_plan_qty, 
		wms_pack_allocated_qty, 		wms_pack_tolerance_qty, 	wms_pack_cons, 				wms_pack_customer_serial_no, 	wms_pack_warranty_serial_no, 
		wms_pack_packed_from_uid_serno, wms_pack_source_thu_ser_no, wms_pack_box_thu_id, 		wms_pack_box_no, 				wms_pack_reason_code, 
		wms_pack_item_attribute1, 		wms_pack_item_attribute2, 	wms_pack_item_attribute3, 	wms_pack_item_attribute4, 		wms_pack_item_attribute5, 
		wms_pack_item_attribute6, 		wms_pack_item_attribute7, 	wms_pack_item_attribute8, 	wms_pack_item_attribute9, 		wms_pack_item_attribute10, 
		etlcreateddatetime
    )
    SELECT
        wms_pack_loc_code, 				wms_pack_pln_no, 			wms_pack_pln_ou, 			wms_pack_lineno, 				wms_pack_picklist_no, 
		wms_pack_so_no, 				wms_pack_so_line_no, 		wms_pack_so_sch_lineno, 	wms_pack_item_code, 			wms_pack_item_batch_no, 
		wms_pack_item_sr_no, 			wms_pack_so_qty, 			wms_pack_uid_sr_no, 		wms_pack_thu_sr_no, 			wms_pack_pre_packing_bay, 
		wms_pack_lot_no, 				wms_pack_su, 				wms_pack_su_type, 			wms_pack_thu_id, 				wms_pack_plan_qty, 
		wms_pack_allocated_qty, 		wms_pack_tolerance_qty, 	wms_pack_cons, 				wms_pack_customer_serial_no, 	wms_pack_warranty_serial_no, 
		wms_pack_packed_from_uid_serno, wms_pack_source_thu_ser_no, wms_pack_box_thu_id, 		wms_pack_box_no, 				wms_pack_reason_code, 
		wms_pack_item_attribute1, 		wms_pack_item_attribute2, 	wms_pack_item_attribute3, 	wms_pack_item_attribute4, 		wms_pack_item_attribute5, 
		wms_pack_item_attribute6, 		wms_pack_item_attribute7, 	wms_pack_item_attribute8, 	wms_pack_item_attribute9, 		wms_pack_item_attribute10, 
		etlcreateddatetime
    FROM stg.stg_wms_pack_plan_dtl;
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
ALTER PROCEDURE dwh.usp_f_packplandetail(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
