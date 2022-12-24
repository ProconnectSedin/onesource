-- PROCEDURE: dwh.usp_f_triplogthudetail(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_triplogthudetail(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_triplogthudetail(
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
        SELECT COUNT(1) INTO srccnt
        FROM stg.stg_tms_tltd_trip_log_thu_details;

        UPDATE dwh.F_TripLogThuDetail t
        SET
        plpth_hdr_key         =   oh.plpth_hdr_key,
        tltd_vendor_key                 = COALESCE(v.vendor_key,-1),
        tltd_thu_line_no                           = s.tltd_thu_line_no,
        tltd_thu_id                                = s.tltd_thu_id,
        tltd_class_of_stores                       = s.tltd_class_of_stores,
        tltd_planned_qty                           = s.tltd_planned_qty,
        tltd_thu_actual_qty                        = s.tltd_thu_actual_qty,
        tltd_damaged_qty                           = s.tltd_damaged_qty,
        tltd_vendor_id                             = s.tltd_vendor_id,
        tltd_vendor_thu_type                       = s.tltd_vendor_thu_type,
        tltd_vendor_thu_id                         = s.tltd_vendor_thu_id,
        tltd_vendor_doc_no                         = s.tltd_vendor_doc_no,
        tltd_vendor_ac_no                          = s.tltd_vendor_ac_no,
        tltd_cha_id                                = s.tltd_cha_id,
        tltd_created_date                          = s.tltd_created_date,
        tltd_created_by                            = s.tltd_created_by,
        tltd_modified_date                         = s.tltd_modified_date,
        tltd_modified_by                           = s.tltd_modified_by,
        tltd_timestamp                             = s.tltd_timestamp,
        tltd_transfer_type                         = s.tltd_transfer_type,
        tltd_remarks                               = s.tltd_remarks,
        tltd_thu_weight                            = s.tltd_thu_weight,
        tltd_rsncode_damage                        = s.tltd_rsncode_damage,
        tltd_thu_weight_uom                        = s.tltd_thu_weight_uom,
        tltd_reasoncode_remarks                    = s.tltd_reasoncode_remarks,
        tltd_damaged_reasoncode                    = s.tltd_damaged_reasoncode,
        tltd_returned_reasoncode                   = s.tltd_returned_reasoncode,
        tltd_actual_planned_mismatch_reason        = s.tltd_actual_planned_mismatch_reason,
        tltd_actual_pallet_space                   = s.tltd_actual_pallet_space,
        tltd_returned_qty                          = s.tltd_returned_qty,
        tltd_planned_palletspace                   = s.tltd_planned_palletspace,
        tltd_actual_palletspace                    = s.tltd_actual_palletspace,
        tltd_volume                                = s.tltd_volume,
        tltd_volume_uom                            = s.tltd_volume_uom,
        etlactiveind                               = 1,
        etljobname                                 = p_etljobname,
        envsourcecd                                = p_envsourcecd,
        datasourcecd                               = p_datasourcecd,
        etlupdatedatetime                          = NOW()
        FROM stg.stg_tms_tltd_trip_log_thu_details s

  INNER JOIN dwh.f_tripplanningheader oh  
ON           s.tltd_ouinstance  = oh.plpth_ouinstance
      AND s.tltd_trip_plan_id   = oh.plpth_trip_plan_id
	  
      LEFT JOIN dwh.d_vendor v       
        ON  s.tltd_vendor_id           = v.vendor_id 
        AND s.tltd_ouinstance           = v.vendor_ou

        WHERE   t.tltd_trip_plan_id =  s.tltd_trip_plan_id
          AND t.tltd_thu_line_no =  s.tltd_thu_line_no  
          AND t.tltd_trip_sequence =  s.tltd_trip_sequence 
          AND t.tltd_dispatch_doc_no =  s.tltd_dispatch_doc_no
          AND t.tltd_ouinstance =  s.tltd_ouinstance  
          AND t.tltd_trip_plan_line_id =  s.tltd_trip_plan_line_id;

        GET DIAGNOSTICS updcnt = ROW_COUNT;

        INSERT INTO dwh.F_TripLogThuDetail
        (
           plpth_hdr_key , tltd_vendor_key , tltd_ouinstance, tltd_trip_plan_id, tltd_trip_plan_line_id, tltd_dispatch_doc_no, tltd_thu_line_no, tltd_thu_id, tltd_class_of_stores, tltd_planned_qty, tltd_thu_actual_qty, tltd_damaged_qty, tltd_vendor_id, tltd_vendor_thu_type, tltd_vendor_thu_id, tltd_vendor_doc_no, tltd_vendor_ac_no, tltd_cha_id, tltd_created_date, tltd_created_by, tltd_modified_date, tltd_modified_by, tltd_timestamp, tltd_transfer_type, tltd_remarks, tltd_trip_sequence, tltd_thu_weight, tltd_rsncode_damage, tltd_thu_weight_uom, tltd_reasoncode_remarks, tltd_damaged_reasoncode, tltd_returned_reasoncode, tltd_actual_planned_mismatch_reason, tltd_actual_pallet_space, tltd_returned_qty, tltd_planned_palletspace, tltd_actual_palletspace, tltd_volume, tltd_volume_uom, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
        )

        SELECT
            oh.plpth_hdr_key,COALESCE(v.vendor_key,-1), s.tltd_ouinstance, s.tltd_trip_plan_id, s.tltd_trip_plan_line_id, s.tltd_dispatch_doc_no, s.tltd_thu_line_no, s.tltd_thu_id, s.tltd_class_of_stores, s.tltd_planned_qty, s.tltd_thu_actual_qty, s.tltd_damaged_qty, s.tltd_vendor_id, s.tltd_vendor_thu_type, s.tltd_vendor_thu_id, s.tltd_vendor_doc_no, s.tltd_vendor_ac_no, s.tltd_cha_id, s.tltd_created_date, s.tltd_created_by, s.tltd_modified_date, s.tltd_modified_by, s.tltd_timestamp, s.tltd_transfer_type, s.tltd_remarks, s.tltd_trip_sequence, s.tltd_thu_weight, s.tltd_rsncode_damage, s.tltd_thu_weight_uom, s.tltd_reasoncode_remarks, s.tltd_damaged_reasoncode, s.tltd_returned_reasoncode, s.tltd_actual_planned_mismatch_reason, s.tltd_actual_pallet_space, s.tltd_returned_qty, s.tltd_planned_palletspace, s.tltd_actual_palletspace, s.tltd_volume, s.tltd_volume_uom, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
        FROM stg.stg_tms_tltd_trip_log_thu_details s

       INNER JOIN dwh.f_tripplanningheader oh  
ON           s.tltd_ouinstance  = oh.plpth_ouinstance
      AND s.tltd_trip_plan_id   = oh.plpth_trip_plan_id

      LEFT JOIN dwh.d_vendor v       
        ON  s.tltd_vendor_id           = v.vendor_id 
        AND s.tltd_ouinstance           = v.vendor_ou

        LEFT JOIN dwh.F_TripLogThuDetail t
        ON  s.tltd_trip_plan_id =  t.tltd_trip_plan_id
          AND s.tltd_thu_line_no =  t.tltd_thu_line_no 
          AND s.tltd_trip_sequence =  t.tltd_trip_sequence  
          AND s.tltd_dispatch_doc_no =  t.tltd_dispatch_doc_no
          AND s.tltd_ouinstance =  t.tltd_ouinstance
          AND s.tltd_trip_plan_line_id =  t.tltd_trip_plan_line_id	
        WHERE t.tltd_ouinstance IS NULL;

        GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN

        INSERT INTO raw.raw_tms_tltd_trip_log_thu_details
        (
            tltd_ouinstance, tltd_trip_plan_id, tltd_trip_plan_line_id, tltd_dispatch_doc_no, tltd_thu_line_no, tltd_thu_id, tltd_class_of_stores, tltd_planned_qty, tltd_thu_actual_qty, tltd_damaged_qty, tltd_vendor_id, tltd_vendor_thu_type, tltd_vendor_thu_id, tltd_vendor_doc_no, tltd_vendor_ac_no, tltd_cha_id, tltd_created_date, tltd_created_by, tltd_modified_date, tltd_modified_by, tltd_timestamp, tltd_transfer_type, tltd_remarks, tltd_trip_sequence, tltd_thu_weight, tltd_rsncode_damage, tltd_thu_weight_uom, tltd_reasoncode_remarks, tltd_damaged_reasoncode, tltd_returned_reasoncode, tltd_actual_planned_mismatch_reason, tltd_actual_pallet_space, tltd_returned_qty, tltd_planned_palletspace, tltd_actual_palletspace, tltd_volume, tltd_volume_uom, etlcreateddatetime
        )
        SELECT
            tltd_ouinstance, tltd_trip_plan_id, tltd_trip_plan_line_id, tltd_dispatch_doc_no, tltd_thu_line_no, tltd_thu_id, tltd_class_of_stores, tltd_planned_qty, tltd_thu_actual_qty, tltd_damaged_qty, tltd_vendor_id, tltd_vendor_thu_type, tltd_vendor_thu_id, tltd_vendor_doc_no, tltd_vendor_ac_no, tltd_cha_id, tltd_created_date, tltd_created_by, tltd_modified_date, tltd_modified_by, tltd_timestamp, tltd_transfer_type, tltd_remarks, tltd_trip_sequence, tltd_thu_weight, tltd_rsncode_damage, tltd_thu_weight_uom, tltd_reasoncode_remarks, tltd_damaged_reasoncode, tltd_returned_reasoncode, tltd_actual_planned_mismatch_reason, tltd_actual_pallet_space, tltd_returned_qty, tltd_planned_palletspace, tltd_actual_palletspace, tltd_volume, tltd_volume_uom, etlcreateddatetime
        FROM stg.stg_tms_tltd_trip_log_thu_details;
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
ALTER PROCEDURE dwh.usp_f_triplogthudetail(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
