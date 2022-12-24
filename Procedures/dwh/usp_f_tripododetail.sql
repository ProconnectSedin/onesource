-- PROCEDURE: dwh.usp_f_tripododetail(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_tripododetail(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_tripododetail(
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
        FROM stg.stg_tms_pltpo_trip_odo_details;

        UPDATE dwh.F_TripOdoDetail t
        SET

        plpth_hdr_key                   = oh.plpth_hdr_key,
        plpto_plan_run_no               = s.plpto_plan_run_no,
        plpto_trip_plan_id              = s.plpto_trip_plan_id,
        plpto_trip_plan_line_no         = s.plpto_trip_plan_line_no,
        plpto_bk_req_id                 = s.plpto_bk_req_id,
        plpto_bk_leg_no                 = s.plpto_bk_leg_no,
        plpto_odo_state                 = s.plpto_odo_state,
        plpto_odo_reading               = s.plpto_odo_reading,
        plpto_odo_uom                   = s.plpto_odo_uom,
        plpto_created_by                = s.plpto_created_by,
        plpto_created_date              = s.plpto_created_date,
        plpto_last_modified_by          = s.plpto_last_modified_by,
        plpto_last_modified_date        = s.plpto_last_modified_date,
        plpto_timestamp                 = s.plpto_timestamp,
        plpto_trip_plan_seq             = s.plpto_trip_plan_seq,
        plpto_flag                      = s.plpto_flag,
            etlactiveind                    = 1,
        etljobname                      = p_etljobname,
        envsourcecd                     = p_envsourcecd,
        datasourcecd                    = p_datasourcecd,
        etlupdatedatetime               = NOW()
        FROM stg.stg_tms_pltpo_trip_odo_details s

         INNER JOIN dwh.f_tripplanningheader oh  
ON           s.plpto_ouinstance  = oh.plpth_ouinstance
      AND s.plpto_trip_plan_id   = oh.plpth_trip_plan_id
      
        WHERE t.plpto_ouinstance = s.plpto_ouinstance
        AND t.plpto_guid = s.plpto_guid
        AND  t.plpth_hdr_key  = oh.plpth_hdr_key;

        GET DIAGNOSTICS updcnt = ROW_COUNT;

        INSERT INTO dwh.F_TripOdoDetail
        (
            plpth_hdr_key ,plpto_ouinstance, plpto_guid, plpto_plan_run_no, plpto_trip_plan_id, plpto_trip_plan_line_no, plpto_bk_req_id, plpto_bk_leg_no, plpto_odo_state, plpto_odo_reading, plpto_odo_uom, plpto_created_by, plpto_created_date, plpto_last_modified_by, plpto_last_modified_date, plpto_timestamp, plpto_trip_plan_seq, plpto_flag, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
        )

        SELECT
           oh.plpth_hdr_key, s.plpto_ouinstance, s.plpto_guid, s.plpto_plan_run_no, s.plpto_trip_plan_id, s.plpto_trip_plan_line_no, s.plpto_bk_req_id, s.plpto_bk_leg_no, s.plpto_odo_state, s.plpto_odo_reading, s.plpto_odo_uom, s.plpto_created_by, s.plpto_created_date, s.plpto_last_modified_by, s.plpto_last_modified_date, s.plpto_timestamp, s.plpto_trip_plan_seq, s.plpto_flag, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
        FROM stg.stg_tms_pltpo_trip_odo_details s

              INNER JOIN dwh.f_tripplanningheader oh  
ON           s.plpto_ouinstance  = oh.plpth_ouinstance
      AND s.plpto_trip_plan_id   = oh.plpth_trip_plan_id
      
        LEFT JOIN dwh.F_TripOdoDetail t
        ON s.plpto_ouinstance = t.plpto_ouinstance
        AND s.plpto_guid = t.plpto_guid
        AND  t.plpth_hdr_key  = oh.plpth_hdr_key

        WHERE t.plpto_ouinstance IS NULL;

        GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN

        INSERT INTO raw.raw_tms_pltpo_trip_odo_details
        (
            plpto_ouinstance, plpto_guid, plpto_plan_run_no, plpto_trip_plan_id, plpto_trip_plan_line_no, plpto_bk_req_id, plpto_bk_leg_no, plpto_odo_state, plpto_odo_reading, plpto_odo_uom, plpto_created_by, plpto_created_date, plpto_last_modified_by, plpto_last_modified_date, plpto_timestamp, plpto_trip_plan_seq, plpto_flag, etlcreateddatetime
        )
        SELECT
            plpto_ouinstance, plpto_guid, plpto_plan_run_no, plpto_trip_plan_id, plpto_trip_plan_line_no, plpto_bk_req_id, plpto_bk_leg_no, plpto_odo_state, plpto_odo_reading, plpto_odo_uom, plpto_created_by, plpto_created_date, plpto_last_modified_by, plpto_last_modified_date, plpto_timestamp, plpto_trip_plan_seq, plpto_flag, etlcreateddatetime
        FROM stg.stg_tms_pltpo_trip_odo_details;
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
ALTER PROCEDURE dwh.usp_f_tripododetail(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
