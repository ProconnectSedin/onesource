-- PROCEDURE: dwh.usp_f_tripplanningdetail(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_tripplanningdetail(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_tripplanningdetail(
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
    p_errordesc VARCHAR(10000);
    p_errorline integer;
	p_depsource VARCHAR(100);
    p_rawstorageflag integer;

BEGIN
    SELECT d.jobname, h.envsourcecode, h.datasourcecode, d.latestbatchid, d.targetprocedurename, h.rawstorageflag,h.depsource
    INTO p_etljobname, p_envsourcecd, p_datasourcecd, p_batchid, p_taskname, p_rawstorageflag,p_depsource
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
    FROM stg.stg_tms_pltpd_trip_planning_details;

    UPDATE dwh.f_tripPlanningDetail t
    SET 
	    plpth_hdr_key                        = fh.plpth_hdr_key,
        plptd_trip_plan_line_no              = s.plptd_trip_plan_line_no,
        plptd_trip_plan_cutoftime            = s.plptd_trip_plan_cutoftime,
        plptd_bk_leg_no                      = s.plptd_bk_leg_no,
        plptd_leg_behaviour                  = s.plptd_leg_behaviour,
        plptd_thu_covered_qty                = s.plptd_thu_covered_qty,
        plptd_thu_line_no                    = s.plptd_thu_line_no,
        plptd_execution_plan                 = s.plptd_execution_plan,
        plptd_created_by                     = s.plptd_created_by,
        plptd_created_date                   = s.plptd_created_date,
        plptd_last_modified_by               = s.plptd_last_modified_by,
        plptd_last_modified_date             = s.plptd_last_modified_date,
        plptd_line_status                    = s.plptd_line_status,
        plptd_billing_status                 = s.plptd_billing_status,
        plptd_event_id                       = s.plptd_event_id,
        plptd_Distinct_Leg_id                = s.plptd_Distinct_Leg_id,
        plptd_plan_source                    = s.plptd_plan_source,
        plptd_odo_start                      = s.plptd_odo_start,
        plptd_odo_end                        = s.plptd_odo_end,
        plptd_odo_uom                        = s.plptd_odo_uom,
        plpth_start_time                     = s.plpth_start_time,
        plpth_end_time                       = s.plpth_end_time,
        pltpd_manage_flag                    = s.pltpd_manage_flag,
        pltpd_rest_hours                     = s.pltpd_rest_hours,
        plptd_trip_plan_unique_id            = s.plptd_trip_plan_unique_id,
        pltpd_from                           = s.pltpd_from,
        pltpd_from_type                      = s.pltpd_from_type,
        pltpd_to                             = s.pltpd_to,
        pltpd_to_type                        = s.pltpd_to_type,
        plptd_distance                       = s.plptd_distance,
        plptd_supplier_billing_status        = s.plptd_supplier_billing_status,
        plptd_rest_start                     = s.plptd_rest_start,
        plptd_transfer_doc_no                = s.plptd_transfer_doc_no,
        pltpd_pl_bk_qty                      = s.pltpd_pl_bk_qty,
        pltpd_pl_bk_wei                      = s.pltpd_pl_bk_wei,
        pltpd_pl_bk_wei_uom                  = s.pltpd_pl_bk_wei_uom,
        pltpd_act_bk_qty                     = s.pltpd_act_bk_qty,
        pltpd_act_bk_wei                     = s.pltpd_act_bk_wei,
        pltpd_act_bk_wei_uom                 = s.pltpd_act_bk_wei_uom,
        pltpd_cuml_pl_wei                    = s.pltpd_cuml_pl_wei,
        pltpd_cuml_pl_wei_uom                = s.pltpd_cuml_pl_wei_uom,
        pltpd_cuml_act_wei                   = s.pltpd_cuml_act_wei,
        pltpd_cuml_act_wei_uom               = s.pltpd_cuml_act_wei_uom,
        pltpd_bk_wise_seq                    = s.pltpd_bk_wise_seq,
        pltpd_backhaul_flag                  = s.pltpd_backhaul_flag,
        pltpd_timestamp                      = s.pltpd_timestamp,
        plptd_backtohub_type                 = s.plptd_backtohub_type,
        pltpd_loading_time                   = s.pltpd_loading_time,
        plptd_transit_time                   = s.plptd_transit_time,
        etlactiveind                         = 1,
        etljobname                           = p_etljobname,
        envsourcecd                          = p_envsourcecd,
        datasourcecd                         = p_datasourcecd,
        etlupdatedatetime                    = NOW()
    FROM stg.stg_tms_pltpd_trip_planning_details s
	INNER JOIN dwh.f_tripplanningheader fh
	ON   s.plptd_ouinstance   = fh.plpth_ouinstance
	AND  s.plptd_trip_plan_id = fh.plpth_trip_plan_id
    WHERE t.plptd_ouinstance = s.plptd_ouinstance
    AND t.plptd_plan_run_no = s.plptd_plan_run_no
    AND t.plptd_trip_plan_id = s.plptd_trip_plan_id
    AND t.plptd_trip_plan_seq = s.plptd_trip_plan_seq
    AND t.plptd_bk_req_id = s.plptd_bk_req_id
	AND t.plptd_trip_plan_unique_id = s.plptd_trip_plan_unique_id;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.f_tripPlanningDetail
    (
        plpth_hdr_key,plptd_ouinstance, plptd_plan_run_no, plptd_trip_plan_id, plptd_trip_plan_line_no, plptd_trip_plan_seq, plptd_trip_plan_cutoftime, plptd_bk_req_id, plptd_bk_leg_no, plptd_leg_behaviour, plptd_thu_covered_qty, plptd_thu_line_no, plptd_execution_plan, plptd_created_by, plptd_created_date, plptd_last_modified_by, plptd_last_modified_date, plptd_line_status, plptd_billing_status, plptd_event_id, plptd_Distinct_Leg_id, plptd_plan_source, plptd_odo_start, plptd_odo_end, plptd_odo_uom, plpth_start_time, plpth_end_time, pltpd_manage_flag, pltpd_rest_hours, plptd_trip_plan_unique_id, pltpd_from, pltpd_from_type, pltpd_to, pltpd_to_type, plptd_distance, plptd_supplier_billing_status, plptd_rest_start, plptd_transfer_doc_no, pltpd_pl_bk_qty, pltpd_pl_bk_wei, pltpd_pl_bk_wei_uom, pltpd_act_bk_qty, pltpd_act_bk_wei, pltpd_act_bk_wei_uom, pltpd_cuml_pl_wei, pltpd_cuml_pl_wei_uom, pltpd_cuml_act_wei, pltpd_cuml_act_wei_uom, pltpd_bk_wise_seq, pltpd_backhaul_flag, pltpd_timestamp, plptd_backtohub_type, pltpd_loading_time, plptd_transit_time, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        fh.plpth_hdr_key,s.plptd_ouinstance, s.plptd_plan_run_no, s.plptd_trip_plan_id, s.plptd_trip_plan_line_no, s.plptd_trip_plan_seq, s.plptd_trip_plan_cutoftime, s.plptd_bk_req_id, s.plptd_bk_leg_no, s.plptd_leg_behaviour, s.plptd_thu_covered_qty, s.plptd_thu_line_no, s.plptd_execution_plan, s.plptd_created_by, s.plptd_created_date, s.plptd_last_modified_by, s.plptd_last_modified_date, s.plptd_line_status, s.plptd_billing_status, s.plptd_event_id, s.plptd_Distinct_Leg_id, s.plptd_plan_source, s.plptd_odo_start, s.plptd_odo_end, s.plptd_odo_uom, s.plpth_start_time, s.plpth_end_time, s.pltpd_manage_flag, s.pltpd_rest_hours, s.plptd_trip_plan_unique_id, s.pltpd_from, s.pltpd_from_type, s.pltpd_to, s.pltpd_to_type, s.plptd_distance, s.plptd_supplier_billing_status, s.plptd_rest_start, s.plptd_transfer_doc_no, s.pltpd_pl_bk_qty, s.pltpd_pl_bk_wei, s.pltpd_pl_bk_wei_uom, s.pltpd_act_bk_qty, s.pltpd_act_bk_wei, s.pltpd_act_bk_wei_uom, s.pltpd_cuml_pl_wei, s.pltpd_cuml_pl_wei_uom, s.pltpd_cuml_act_wei, s.pltpd_cuml_act_wei_uom, s.pltpd_bk_wise_seq, s.pltpd_backhaul_flag, s.pltpd_timestamp, s.plptd_backtohub_type, s.pltpd_loading_time, s.plptd_transit_time, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_tms_pltpd_trip_planning_details s
	INNER JOIN dwh.f_tripplanningheader fh
	ON   s.plptd_ouinstance   = fh.plpth_ouinstance
	AND  s.plptd_trip_plan_id = fh.plpth_trip_plan_id
    LEFT JOIN dwh.f_tripPlanningDetail t
    ON s.plptd_ouinstance = t.plptd_ouinstance
    AND s.plptd_plan_run_no = t.plptd_plan_run_no
    AND s.plptd_trip_plan_id = t.plptd_trip_plan_id
    AND s.plptd_trip_plan_seq = t.plptd_trip_plan_seq
    AND s.plptd_bk_req_id = t.plptd_bk_req_id
	AND t.plptd_trip_plan_unique_id = s.plptd_trip_plan_unique_id
	WHERE t.plptd_ouinstance IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_tms_pltpd_trip_planning_details
    (
        plptd_ouinstance, plptd_plan_run_no, plptd_trip_plan_id, plptd_trip_plan_line_no, plptd_trip_plan_seq, plptd_trip_plan_cutoftime, plptd_bk_req_id, plptd_bk_leg_no, plptd_leg_behaviour, plptd_thu_covered_qty, plptd_thu_line_no, plptd_execution_plan, plptd_created_by, plptd_created_date, plptd_last_modified_by, plptd_last_modified_date, plptd_line_status, plptd_billing_status, plptd_event_id, plptd_Distinct_Leg_id, plptd_plan_source, plptd_odo_start, plptd_odo_end, plptd_odo_uom, plpth_start_time, plpth_end_time, pltpd_manage_flag, pltpd_rest_hours, plptd_trip_plan_unique_id, pltpd_from, pltpd_from_type, pltpd_to, pltpd_to_type, plptd_distance, plptd_supplier_billing_status, plptd_rest_start, plptd_transfer_doc_no, pltpd_pl_bk_qty, pltpd_pl_bk_wei, pltpd_pl_bk_wei_uom, pltpd_act_bk_qty, pltpd_act_bk_wei, pltpd_act_bk_wei_uom, pltpd_cuml_pl_wei, pltpd_cuml_pl_wei_uom, pltpd_cuml_act_wei, pltpd_cuml_act_wei_uom, pltpd_bk_wise_seq, pltpd_backhaul_flag, pltpd_timestamp, plptd_backtohub_type, pltpd_loading_time, plptd_transit_time, etlcreateddatetime
    )
    SELECT
        plptd_ouinstance, plptd_plan_run_no, plptd_trip_plan_id, plptd_trip_plan_line_no, plptd_trip_plan_seq, plptd_trip_plan_cutoftime, plptd_bk_req_id, plptd_bk_leg_no, plptd_leg_behaviour, plptd_thu_covered_qty, plptd_thu_line_no, plptd_execution_plan, plptd_created_by, plptd_created_date, plptd_last_modified_by, plptd_last_modified_date, plptd_line_status, plptd_billing_status, plptd_event_id, plptd_Distinct_Leg_id, plptd_plan_source, plptd_odo_start, plptd_odo_end, plptd_odo_uom, plpth_start_time, plpth_end_time, pltpd_manage_flag, pltpd_rest_hours, plptd_trip_plan_unique_id, pltpd_from, pltpd_from_type, pltpd_to, pltpd_to_type, plptd_distance, plptd_supplier_billing_status, plptd_rest_start, plptd_transfer_doc_no, pltpd_pl_bk_qty, pltpd_pl_bk_wei, pltpd_pl_bk_wei_uom, pltpd_act_bk_qty, pltpd_act_bk_wei, pltpd_act_bk_wei_uom, pltpd_cuml_pl_wei, pltpd_cuml_pl_wei_uom, pltpd_cuml_act_wei, pltpd_cuml_act_wei_uom, pltpd_bk_wise_seq, pltpd_backhaul_flag, pltpd_timestamp, plptd_backtohub_type, pltpd_loading_time, plptd_transit_time, etlcreateddatetime
    FROM stg.stg_tms_pltpd_trip_planning_details;
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
ALTER PROCEDURE dwh.usp_f_tripplanningdetail(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
