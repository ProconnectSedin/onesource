CREATE PROCEDURE dwh.usp_f_vehiclerequirements(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
    FROM stg.stg_tms_trvr_vehicle_requirement;

    UPDATE dwh.F_VehicleRequirements t
    SET
        trvr_ouinstance                = s.trvr_ouinstance,
        trvr_tender_req_no             = s.trvr_tender_req_no,
        trvr_line_no                   = s.trvr_line_no,
        trvr_vehicle_type              = s.trvr_vehicle_type,
        trvr_no_of_vehicles            = s.trvr_no_of_vehicles,
        trvr_required_date_time        = s.trvr_required_date_time,
        trvr_pref_vehicle_model        = s.trvr_pref_vehicle_model,
        trvr_created_by                = s.trvr_created_by,
        trvr_created_date              = s.trvr_created_date,
        trvr_last_modified_by          = s.trvr_last_modified_by,
        trvr_last_modified_date        = s.trvr_last_modified_date,
        trvr_timestamp                 = s.trvr_timestamp,
        trvr_for_period                = s.trvr_for_period,
        trvr_period_uom                = s.trvr_period_uom,
        trvr_ref_doc_no                = s.trvr_ref_doc_no,
        trvr_ref_doc_type              = s.trvr_ref_doc_type,
        trvr_tender_to                 = s.trvr_tender_to,
        etlactiveind                   = 1,
        etljobname                     = p_etljobname,
        envsourcecd                    = p_envsourcecd,
        datasourcecd                   = p_datasourcecd,
        etlupdatedatetime              = NOW()
    FROM stg.stg_tms_trvr_vehicle_requirement s
    WHERE t.trvr_ouinstance = s.trvr_ouinstance
    AND t.trvr_tender_req_no = s.trvr_tender_req_no
    AND t.trvr_line_no = s.trvr_line_no;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_VehicleRequirements
    (
        trvr_ouinstance, trvr_tender_req_no, trvr_line_no, trvr_vehicle_type, trvr_no_of_vehicles, trvr_required_date_time, trvr_pref_vehicle_model, trvr_created_by, trvr_created_date, trvr_last_modified_by, trvr_last_modified_date, trvr_timestamp, trvr_for_period, trvr_period_uom, trvr_ref_doc_no, trvr_ref_doc_type, trvr_tender_to, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        s.trvr_ouinstance, s.trvr_tender_req_no, s.trvr_line_no, s.trvr_vehicle_type, s.trvr_no_of_vehicles, s.trvr_required_date_time, s.trvr_pref_vehicle_model, s.trvr_created_by, s.trvr_created_date, s.trvr_last_modified_by, s.trvr_last_modified_date, s.trvr_timestamp, s.trvr_for_period, s.trvr_period_uom, s.trvr_ref_doc_no, s.trvr_ref_doc_type, s.trvr_tender_to, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_tms_trvr_vehicle_requirement s
    LEFT JOIN dwh.F_VehicleRequirements t
    ON s.trvr_ouinstance = t.trvr_ouinstance
    AND s.trvr_tender_req_no = t.trvr_tender_req_no
    AND s.trvr_line_no = t.trvr_line_no
    WHERE t.trvr_ouinstance IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_tms_trvr_vehicle_requirement
    (
        trvr_ouinstance, trvr_tender_req_no, trvr_line_no, trvr_vehicle_type, trvr_no_of_vehicles, trvr_required_date_time, trvr_pref_vehicle_model, trvr_created_by, trvr_created_date, trvr_last_modified_by, trvr_last_modified_date, trvr_timestamp, trvr_for_period, trvr_period_uom, trvr_ref_doc_no, trvr_ref_doc_type, trvr_tender_to, etlcreateddatetime
    )
    SELECT
        trvr_ouinstance, trvr_tender_req_no, trvr_line_no, trvr_vehicle_type, trvr_no_of_vehicles, trvr_required_date_time, trvr_pref_vehicle_model, trvr_created_by, trvr_created_date, trvr_last_modified_by, trvr_last_modified_date, trvr_timestamp, trvr_for_period, trvr_period_uom, trvr_ref_doc_no, trvr_ref_doc_type, trvr_tender_to, etlcreateddatetime
    FROM stg.stg_tms_trvr_vehicle_requirement;
    
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