-- PROCEDURE: dwh.usp_f_planningdetail(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_planningdetail(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_planningdetail(
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
    SELECT d.jobname, h.envsourcecode, h.datasourcecode, d.latestbatchid, d.targetprocedurename, h.rawstorageflag,h.depsource
    INTO p_etljobname, p_envsourcecd, p_datasourcecd, p_batchid, p_taskname, p_rawstorageflag ,p_depsource

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
    FROM stg.stg_tms_plpd_planning_details;

    UPDATE dwh.F_PlanningDetail t
    SET

        plph_hdr_key                   = oh.plph_hdr_key,
        plpd_cust_key                  = COALESCE(c.customer_key,-1),
        plpd_doc_id                    = s.plpd_doc_id,
        plpd_doc_type                  = s.plpd_doc_type,
        plpd_from_location             = s.plpd_from_location,
        plpd_to_location               = s.plpd_to_location,
        plpd_leg_no                    = s.plpd_leg_no,
        plpd_leg_behaviour             = s.plpd_leg_behaviour,
        plpd_execution_plan            = s.plpd_execution_plan,
        plpd_planning_cutoftime        = s.plpd_planning_cutoftime,
        plpd_created_by                = s.plpd_created_by,
        plpd_created_date              = s.plpd_created_date,
        plpd_last_modified_by          = s.plpd_last_modified_by,
        plpd_last_modified_date        = s.plpd_last_modified_date,
        plpd_failure_reason            = s.plpd_failure_reason,
        plpd_customercode              = s.plpd_customercode,
        plpd_customer_name             = s.plpd_customer_name,
        plpd_trip_id                   = s.plpd_trip_id,
        plpd_trip_status               = s.plpd_trip_status,
        plpd_thu                       = s.plpd_thu,
        plpd_qty                       = s.plpd_qty,
        plpd_balance_qty               = s.plpd_balance_qty,
        plpd_planned_qty               = s.plpd_planned_qty,
        plpd_ship_from_desc            = s.plpd_ship_from_desc,
        plpd_from_postcode             = s.plpd_from_postcode,
        plpd_from_suburb               = s.plpd_from_suburb,
        plpd_to_desc                   = s.plpd_to_desc,
        plpd_to_postcode               = s.plpd_to_postcode,
        plpd_to_suburb                 = s.plpd_to_suburb,
        plpd_pickup_date               = s.plpd_pickup_date,
        plpd_pickup_timeslot           = s.plpd_pickup_timeslot,
        plpd_delivery_date             = s.plpd_delivery_date,
        plpd_delivery_timeslot         = s.plpd_delivery_timeslot,
        plpd_volume                    = s.plpd_volume,
        plpd_palletspace               = s.plpd_palletspace,
        plpd_grossweight               = s.plpd_grossweight,
        etlactiveind                   = 1,
        etljobname                     = p_etljobname,
        envsourcecd                    = p_envsourcecd,
        datasourcecd                   = p_datasourcecd,
        etlupdatedatetime              = NOW()
    FROM stg.stg_tms_plpd_planning_details s

    INNER JOIN dwh.f_planningheader oh

    ON 
        s.plpd_ouinstance = oh.plph_ouinstance
        AND s.plpd_plan_run_no =oh.plph_plan_run_no

LEFT JOIN dwh.d_customer C      
        ON s.plpd_customercode  = C.customer_id 
        AND s.plpd_ouinstance        = C.customer_ou

    WHERE t.plpd_ouinstance = s.plpd_ouinstance
    AND t.plpd_plan_run_no = s.plpd_plan_run_no
    AND t.plpd_plan_unique_id = s.plpd_plan_unique_id
     AND    t.plph_hdr_key   =  oh.plph_hdr_key;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_PlanningDetail
    (
        plph_hdr_key, plpd_cust_key, plpd_ouinstance, plpd_plan_run_no, plpd_doc_id, plpd_doc_type, plpd_from_location, plpd_to_location, plpd_leg_no, plpd_leg_behaviour, plpd_execution_plan, plpd_planning_cutoftime, plpd_created_by, plpd_created_date, plpd_last_modified_by, plpd_last_modified_date, plpd_failure_reason, plpd_customercode, plpd_customer_name, plpd_trip_id, plpd_trip_status, plpd_thu, plpd_qty, plpd_balance_qty, plpd_planned_qty, plpd_ship_from_desc, plpd_from_postcode, plpd_from_suburb, plpd_to_desc, plpd_to_postcode, plpd_to_suburb, plpd_pickup_date, plpd_pickup_timeslot, plpd_delivery_date, plpd_delivery_timeslot, plpd_volume, plpd_palletspace, plpd_grossweight, plpd_plan_unique_id, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
       oh.plph_hdr_key, COALESCE(c.customer_key,-1), s.plpd_ouinstance, s.plpd_plan_run_no, s.plpd_doc_id, s.plpd_doc_type, s.plpd_from_location, s.plpd_to_location, s.plpd_leg_no, s.plpd_leg_behaviour, s.plpd_execution_plan, s.plpd_planning_cutoftime, s.plpd_created_by, s.plpd_created_date, s.plpd_last_modified_by, s.plpd_last_modified_date, s.plpd_failure_reason, s.plpd_customercode, s.plpd_customer_name, s.plpd_trip_id, s.plpd_trip_status, s.plpd_thu, s.plpd_qty, s.plpd_balance_qty, s.plpd_planned_qty, s.plpd_ship_from_desc, s.plpd_from_postcode, s.plpd_from_suburb, s.plpd_to_desc, s.plpd_to_postcode, s.plpd_to_suburb, s.plpd_pickup_date, s.plpd_pickup_timeslot, s.plpd_delivery_date, s.plpd_delivery_timeslot, s.plpd_volume, s.plpd_palletspace, s.plpd_grossweight, s.plpd_plan_unique_id, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_tms_plpd_planning_details s

      INNER JOIN dwh.f_planningheader oh

    ON 
        s.plpd_ouinstance = oh.plph_ouinstance
        AND s.plpd_plan_run_no =oh.plph_plan_run_no

        
LEFT JOIN dwh.d_customer C      
        ON s.plpd_customercode  = C.customer_id 
        AND s.plpd_ouinstance        = C.customer_ou

    LEFT JOIN dwh.F_PlanningDetail t
    ON s.plpd_ouinstance = t.plpd_ouinstance
    AND s.plpd_plan_run_no = t.plpd_plan_run_no
    AND s.plpd_plan_unique_id = t.plpd_plan_unique_id
    AND    t.plph_hdr_key   =  oh.plph_hdr_key

    WHERE t.plpd_ouinstance IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_tms_plpd_planning_details
    (
        plpd_ouinstance, plpd_plan_run_no, plpd_doc_id, plpd_doc_type, plpd_from_location, plpd_to_location, plpd_leg_no, plpd_leg_behaviour, plpd_execution_plan, plpd_planning_sel_profile, plpd_planning_cutoftime, plpd_created_by, plpd_created_date, plpd_last_modified_by, plpd_last_modified_date, plpd_timestamp, plpd_failure_reason, plpd_customercode, plpd_customer_name, plpd_trip_id, plpd_trip_status, plpd_thu, plpd_qty, plpd_balance_qty, plpd_planned_qty, plpd_ship_from_desc, plpd_from_postcode, plpd_from_suburb, plpd_to_desc, plpd_to_postcode, plpd_to_suburb, plpd_pickup_date, plpd_pickup_timeslot, plpd_delivery_date, plpd_delivery_timeslot, plpd_volume, plpd_palletspace, plpd_grossweight, plpd_special_instruction, plpd_plan_unique_id, etlcreateddatetime
    )
    SELECT
        plpd_ouinstance, plpd_plan_run_no, plpd_doc_id, plpd_doc_type, plpd_from_location, plpd_to_location, plpd_leg_no, plpd_leg_behaviour, plpd_execution_plan, plpd_planning_sel_profile, plpd_planning_cutoftime, plpd_created_by, plpd_created_date, plpd_last_modified_by, plpd_last_modified_date, plpd_timestamp, plpd_failure_reason, plpd_customercode, plpd_customer_name, plpd_trip_id, plpd_trip_status, plpd_thu, plpd_qty, plpd_balance_qty, plpd_planned_qty, plpd_ship_from_desc, plpd_from_postcode, plpd_from_suburb, plpd_to_desc, plpd_to_postcode, plpd_to_suburb, plpd_pickup_date, plpd_pickup_timeslot, plpd_delivery_date, plpd_delivery_timeslot, plpd_volume, plpd_palletspace, plpd_grossweight, plpd_special_instruction, plpd_plan_unique_id, etlcreateddatetime
    FROM stg.stg_tms_plpd_planning_details;
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
ALTER PROCEDURE dwh.usp_f_planningdetail(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
