-- PROCEDURE: dwh.usp_f_triplogeventdetailweekly(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_triplogeventdetailweekly(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_triplogeventdetailweekly(
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
        FROM stg.stg_tms_tled_trip_log_event_details;

        UPDATE dwh.F_TripLogEventDetail t
        SET
        plpth_hdr_key                   = fh.plpth_hdr_key,
		tled_actual_date_key			= COALESCE(d.datekey,-1),
        tled_trip_plan_line_no          = s.tled_trip_plan_line_no,
        tled_bkr_id                     = s.tled_bkr_id,
        tled_leg_no                     = s.tled_leg_no,
        tled_event_id                   = s.tled_event_id,
        tled_actual_date_time           = s.tled_actual_date_time,
        tled_remarks1                   = s.tled_remarks1,
        tled_reason_code                = s.tled_reason_code,
        tled_reason_description         = s.tled_reason_description,
        tled_created_date               = s.tled_created_date,
        tled_created_by                 = s.tled_created_by,
        tled_modified_date              = s.tled_modified_date,
        tled_modified_by                = s.tled_modified_by,
        tled_timestamp                  = s.tled_timestamp,
        tled_planned_datetime           = s.tled_planned_datetime,
        tled_event_nod                  = s.tled_event_nod,
        etlactiveind                    = 1,
        etljobname                      = p_etljobname,
        envsourcecd                     = p_envsourcecd,
        datasourcecd                    = p_datasourcecd,
        etlupdatedatetime               = NOW()
        FROM stg.stg_tms_tled_trip_log_event_details s

    INNER JOIN dwh.f_tripplanningheader fh
	ON   s.tled_ouinstance   = fh.plpth_ouinstance
	AND  s.tled_trip_plan_id = fh.plpth_trip_plan_id
	
	LEFT JOIN dwh.d_date d			
    ON s.tled_actual_date_time::date = d.dateactual

    WHERE t.tled_ouinstance = s.tled_ouinstance
    AND t.tled_trip_plan_id = s.tled_trip_plan_id
    AND t.tled_trip_plan_unique_id = s.tled_trip_plan_unique_id;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_TripLogEventDetail
        (
            plpth_hdr_key,tled_actual_date_key,
			tled_ouinstance, tled_trip_plan_id, tled_trip_plan_line_no, tled_bkr_id, tled_leg_no, tled_event_id, tled_actual_date_time, tled_remarks1, tled_reason_code, tled_reason_description, tled_created_date, tled_created_by, tled_modified_date, tled_modified_by, tled_timestamp, tled_planned_datetime, tled_trip_plan_unique_id, tled_event_nod, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
        )

    SELECT
            fh.plpth_hdr_key,COALESCE(d.datekey,-1),
			s.tled_ouinstance, s.tled_trip_plan_id, s.tled_trip_plan_line_no, s.tled_bkr_id, s.tled_leg_no, s.tled_event_id, s.tled_actual_date_time, s.tled_remarks1, s.tled_reason_code, s.tled_reason_description, s.tled_created_date, s.tled_created_by, s.tled_modified_date, s.tled_modified_by, s.tled_timestamp, s.tled_planned_datetime, s.tled_trip_plan_unique_id, s.tled_event_nod, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_tms_tled_trip_log_event_details s
		
    INNER JOIN dwh.f_tripplanningheader fh
	ON   s.tled_ouinstance   = fh.plpth_ouinstance
	AND  s.tled_trip_plan_id = fh.plpth_trip_plan_id
	
	LEFT JOIN dwh.d_date d 			
	ON s.tled_actual_date_time::date = d.dateactual

    LEFT JOIN dwh.F_TripLogEventDetail t
    ON s.tled_ouinstance = t.tled_ouinstance
    AND s.tled_trip_plan_id = t.tled_trip_plan_id
    AND s.tled_trip_plan_unique_id = t.tled_trip_plan_unique_id
	
    WHERE t.tled_ouinstance IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
    
    UPDATE dwh.F_TripLogEventDetail t1
	set etlactiveind =  0,
	etlupdatedatetime = Now()::timestamp
	from dwh.F_TripLogEventDetail t
	left join stg.stg_tms_tled_trip_log_event_details s
	ON s.tled_ouinstance = t.tled_ouinstance
    AND s.tled_trip_plan_id = t.tled_trip_plan_id
    AND s.tled_trip_plan_unique_id = t.tled_trip_plan_unique_id
	WHERE t.tled_trip_log_dtl_key= t1.tled_trip_log_dtl_key
	AND COALESCE(t.etlupdatedatetime,t.etlcreatedatetime)::date >= NOW()::DATE
	and s.tled_ouinstance is null;
    
    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_tms_tled_trip_log_event_details
        (
            tled_ouinstance, tled_trip_plan_id, tled_trip_plan_line_no, tled_bkr_id, tled_leg_no, tled_event_id, tled_actual_date_time, tled_remarks1, tled_reason_code, tled_reason_description, tled_remarks2, tled_created_date, tled_created_by, tled_modified_date, tled_modified_by, tled_timestamp, tled_planned_datetime, tled_trip_plan_unique_id, tled_event_nod, etlcreateddatetime
        )
    SELECT
            tled_ouinstance, tled_trip_plan_id, tled_trip_plan_line_no, tled_bkr_id, tled_leg_no, tled_event_id, tled_actual_date_time, tled_remarks1, tled_reason_code, tled_reason_description, tled_remarks2, tled_created_date, tled_created_by, tled_modified_date, tled_modified_by, tled_timestamp, tled_planned_datetime, tled_trip_plan_unique_id, tled_event_nod, etlcreateddatetime
        FROM stg.stg_tms_tled_trip_log_event_details;
		
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
ALTER PROCEDURE dwh.usp_f_triplogeventdetailweekly(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
