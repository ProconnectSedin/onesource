CREATE PROCEDURE dwh.usp_f_tripresourcescheduledetail(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
    FROM stg.stg_tms_resource_schedule_dtl;

    UPDATE dwh.F_TripResourceScheduleDetail t

    SET
        trsd_vendor_key           = COALESCE(v.vendor_key,-1),
        trsd_trip_beh             = s.trsd_trip_beh,
        trsd_sch_status           = s.trsd_sch_status,
        trsd_resource_type        = s.trsd_resource_type,
        trsd_resource_id          = s.trsd_resource_id,
        trsd_sch_date_from        = s.trsd_sch_date_from,
        trsd_sch_date_to          = s.trsd_sch_date_to,
        trsd_sch_loc_from         = s.trsd_sch_loc_from,
        trsd_sch_loc_to           = s.trsd_sch_loc_to,
        trsd_created_by           = s.trsd_created_by,
        trsd_created_date         = s.trsd_created_date,
        trsd_modified_by          = s.trsd_modified_by,
        trsd_modified_date        = s.trsd_modified_date,
        trsd_act_date_from        = s.trsd_act_date_from,
        trsd_act_date_to          = s.trsd_act_date_to,
        trsd_ser_type             = s.trsd_ser_type,
        trsd_sub_ser_type         = s.trsd_sub_ser_type,
        trsd_timestamp            = s.trsd_timestamp,
        trsd_vendor_id            = s.trsd_vendor_id,
        etlactiveind              = 1,
        etljobname                = p_etljobname,
        envsourcecd               = p_envsourcecd,
        datasourcecd              = p_datasourcecd,
        etlupdatedatetime         = NOW()
    FROM stg.stg_tms_resource_schedule_dtl s
    LEFT JOIN dwh.d_vendor v        
        ON  s.trsd_vendor_id           = v.vendor_id 
        AND s.trsd_ouinstance          = v.vendor_ou
    WHERE t.trsd_ouinstance = s.trsd_ouinstance
    AND t.trsd_trip_Plan_id = s.trsd_trip_Plan_id
	AND COALESCE(s.trsd_resource_type,'') = COALESCE(t.trsd_resource_type,'')
	AND s.trsd_resource_id	=	 t.trsd_resource_id;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_TripResourceScheduleDetail
    (
        trsd_vendor_key,trsd_ouinstance, trsd_trip_Plan_id, trsd_trip_beh, trsd_sch_status, trsd_resource_type, trsd_resource_id, trsd_sch_date_from, trsd_sch_date_to, trsd_sch_loc_from, trsd_sch_loc_to, trsd_created_by, trsd_created_date, trsd_modified_by, trsd_modified_date, trsd_act_date_from, trsd_act_date_to, trsd_ser_type, trsd_sub_ser_type, trsd_timestamp, trsd_vendor_id, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
       COALESCE(v.vendor_key,-1), s.trsd_ouinstance, s.trsd_trip_Plan_id, s.trsd_trip_beh, s.trsd_sch_status, s.trsd_resource_type, s.trsd_resource_id, s.trsd_sch_date_from, s.trsd_sch_date_to, s.trsd_sch_loc_from, s.trsd_sch_loc_to, s.trsd_created_by, s.trsd_created_date, s.trsd_modified_by, s.trsd_modified_date, s.trsd_act_date_from, s.trsd_act_date_to, s.trsd_ser_type, s.trsd_sub_ser_type, s.trsd_timestamp, s.trsd_vendor_id, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_tms_resource_schedule_dtl s
    LEFT JOIN dwh.d_vendor v        
        ON  s.trsd_vendor_id           = v.vendor_id 
        AND s.trsd_ouinstance           = v.vendor_ou
    LEFT JOIN dwh.F_TripResourceScheduleDetail t
    ON s.trsd_ouinstance = t.trsd_ouinstance
    AND s.trsd_trip_Plan_id = t.trsd_trip_Plan_id
	AND COALESCE(s.trsd_resource_type,'') = COALESCE(t.trsd_resource_type,'')
	AND s.trsd_resource_id	=	 t.trsd_resource_id
    WHERE t.trsd_ouinstance IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_tms_resource_schedule_dtl
    (
        trsd_ouinstance, trsd_trip_Plan_id, trsd_trip_beh, trsd_sch_status, trsd_resource_type, trsd_resource_id, trsd_sch_date_from, trsd_sch_date_to, trsd_sch_loc_from, trsd_sch_loc_to, trsd_created_by, trsd_created_date, trsd_modified_by, trsd_modified_date, trsd_act_date_from, trsd_act_date_to, trsd_ser_type, trsd_sub_ser_type, trsd_timestamp, trsd_vendor_id, etlcreateddatetime
    )
    SELECT
        trsd_ouinstance, trsd_trip_Plan_id, trsd_trip_beh, trsd_sch_status, trsd_resource_type, trsd_resource_id, trsd_sch_date_from, trsd_sch_date_to, trsd_sch_loc_from, trsd_sch_loc_to, trsd_created_by, trsd_created_date, trsd_modified_by, trsd_modified_date, trsd_act_date_from, trsd_act_date_to, trsd_ser_type, trsd_sub_ser_type, trsd_timestamp, trsd_vendor_id, etlcreateddatetime
    FROM stg.stg_tms_resource_schedule_dtl;
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