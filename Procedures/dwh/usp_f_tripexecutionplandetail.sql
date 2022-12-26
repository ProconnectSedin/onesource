-- PROCEDURE: dwh.usp_f_tripexecutionplandetail(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_tripexecutionplandetail(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_tripexecutionplandetail(
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
        FROM stg.stg_tms_plepd_execution_plan_details;

        UPDATE dwh.F_TripExecutionPlanDetail t
        SET
        br_key                            =oh.br_key,
        plepd_bk_id                       = s.plepd_bk_id,
        plepd_bk_ref_route_id             = s.plepd_bk_ref_route_id,
        plepd_leg_id                      = s.plepd_leg_id,
        plepd_leg_behaviour_id            = s.plepd_leg_behaviour_id,
        plepd_leg_seq_no                  = s.plepd_leg_seq_no,
        plepd_leg_status                  = s.plepd_leg_status,
        plepd_planning_seq_no             = s.plepd_planning_seq_no,
        plepd_leg_from                    = s.plepd_leg_from,
        plepd_from_leg_geo_type           = s.plepd_from_leg_geo_type,
        plepd_leg_from_postal_code        = s.plepd_leg_from_postal_code,
        plepd_leg_from_subzone            = s.plepd_leg_from_subzone,
        plepd_leg_from_city               = s.plepd_leg_from_city,
        plepd_leg_from_zone               = s.plepd_leg_from_zone,
        plepd_leg_from_state              = s.plepd_leg_from_state,
        plepd_leg_from_region             = s.plepd_leg_from_region,
        plepd_leg_from_country            = s.plepd_leg_from_country,
        plepd_leg_to                      = s.plepd_leg_to,
        plepd_to_leg_geo_type             = s.plepd_to_leg_geo_type,
        plepd_leg_to_postal_code          = s.plepd_leg_to_postal_code,
        plepd_leg_to_subzone              = s.plepd_leg_to_subzone,
        plepd_leg_to_city                 = s.plepd_leg_to_city,
        plepd_leg_to_zone                 = s.plepd_leg_to_zone,
        plepd_leg_to_state                = s.plepd_leg_to_state,
        plepd_leg_to_region               = s.plepd_leg_to_region,
        plepd_leg_to_country              = s.plepd_leg_to_country,
        plepd_leg_transport_mode          = s.plepd_leg_transport_mode,
        plepd_available_qty               = s.plepd_available_qty,
        plepd_draft_qty                   = s.plepd_draft_qty,
        plepd_confirmed_qty               = s.plepd_confirmed_qty,
        plepd_initiated_qty               = s.plepd_initiated_qty,
        plepd_executed_qty                = s.plepd_executed_qty,
        plepd_qty_uom                     = s.plepd_qty_uom,
        plepd_available_vol               = s.plepd_available_vol,
        plepd_draft_vol                   = s.plepd_draft_vol,
        plepd_confirmed_vol               = s.plepd_confirmed_vol,
        plepd_vol_uom                     = s.plepd_vol_uom,
        plepd_available_weight            = s.plepd_available_weight,
        plepd_draft_weight                = s.plepd_draft_weight,
        plepd_confirmed_weight            = s.plepd_confirmed_weight,
        plepd_weight_uom                  = s.plepd_weight_uom,
        plepd_created_by                  = s.plepd_created_by,
        plepd_created_Date                = s.plepd_created_Date,
        plepd_last_modified_by            = s.plepd_last_modified_by,
        plepd_last_modified_date          = s.plepd_last_modified_date,
        plepd_leg_to_suburb               = s.plepd_leg_to_suburb,
        plepd_leg_from_suburb             = s.plepd_leg_from_suburb,
        plepd_updated_by                  = s.plepd_updated_by,
            etlactiveind                      = 1,
        etljobname                        = p_etljobname,
        envsourcecd                       = p_envsourcecd,
        datasourcecd                      = p_datasourcecd,
        etlupdatedatetime                 = NOW()
        FROM stg.stg_tms_plepd_execution_plan_details s

        INNER JOIN dwh.f_bookingrequest oh
        ON  
          s.plepd_ouinstance  =  oh. br_ouinstance             
    AND   s.plepd_bk_id       = oh. br_request_Id              

        WHERE t.plepd_ouinstance = s.plepd_ouinstance
    AND t.plepd_execution_plan_id = s.plepd_execution_plan_id
    AND t.plepd_line_no = s.plepd_line_no;
     

        GET DIAGNOSTICS updcnt = ROW_COUNT;

        INSERT INTO dwh.F_TripExecutionPlanDetail
        (
           br_key , plepd_ouinstance, plepd_execution_plan_id, plepd_line_no, plepd_bk_id, plepd_bk_ref_route_id, plepd_leg_id, plepd_leg_behaviour_id, plepd_leg_seq_no, plepd_leg_status, plepd_planning_seq_no, plepd_leg_from, plepd_from_leg_geo_type, plepd_leg_from_postal_code, plepd_leg_from_subzone, plepd_leg_from_city, plepd_leg_from_zone, plepd_leg_from_state, plepd_leg_from_region, plepd_leg_from_country, plepd_leg_to, plepd_to_leg_geo_type, plepd_leg_to_postal_code, plepd_leg_to_subzone, plepd_leg_to_city, plepd_leg_to_zone, plepd_leg_to_state, plepd_leg_to_region, plepd_leg_to_country, plepd_leg_transport_mode, plepd_available_qty, plepd_draft_qty, plepd_confirmed_qty, plepd_initiated_qty, plepd_executed_qty, plepd_qty_uom, plepd_available_vol, plepd_draft_vol, plepd_confirmed_vol, plepd_vol_uom, plepd_available_weight, plepd_draft_weight, plepd_confirmed_weight, plepd_weight_uom, plepd_created_by, plepd_created_Date, plepd_last_modified_by, plepd_last_modified_date, plepd_leg_to_suburb, plepd_leg_from_suburb, plepd_updated_by, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
        )

        SELECT
           oh.br_key, s.plepd_ouinstance, s.plepd_execution_plan_id, s.plepd_line_no, s.plepd_bk_id, s.plepd_bk_ref_route_id, s.plepd_leg_id, s.plepd_leg_behaviour_id, s.plepd_leg_seq_no, s.plepd_leg_status, s.plepd_planning_seq_no, s.plepd_leg_from, s.plepd_from_leg_geo_type, s.plepd_leg_from_postal_code, s.plepd_leg_from_subzone, s.plepd_leg_from_city, s.plepd_leg_from_zone, s.plepd_leg_from_state, s.plepd_leg_from_region, s.plepd_leg_from_country, s.plepd_leg_to, s.plepd_to_leg_geo_type, s.plepd_leg_to_postal_code, s.plepd_leg_to_subzone, s.plepd_leg_to_city, s.plepd_leg_to_zone, s.plepd_leg_to_state, s.plepd_leg_to_region, s.plepd_leg_to_country, s.plepd_leg_transport_mode, s.plepd_available_qty, s.plepd_draft_qty, s.plepd_confirmed_qty, s.plepd_initiated_qty, s.plepd_executed_qty, s.plepd_qty_uom, s.plepd_available_vol, s.plepd_draft_vol, s.plepd_confirmed_vol, s.plepd_vol_uom, s.plepd_available_weight, s.plepd_draft_weight, s.plepd_confirmed_weight, s.plepd_weight_uom, s.plepd_created_by, s.plepd_created_Date, s.plepd_last_modified_by, s.plepd_last_modified_date, s.plepd_leg_to_suburb, s.plepd_leg_from_suburb, s.plepd_updated_by, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
        FROM stg.stg_tms_plepd_execution_plan_details s

            INNER JOIN dwh.f_bookingrequest oh
        ON  
          s.plepd_ouinstance  =  oh. br_ouinstance             
    AND   s.plepd_bk_id       = oh. br_request_Id              

        LEFT JOIN dwh.F_TripExecutionPlanDetail t
        ON s.plepd_ouinstance = t.plepd_ouinstance
    AND s.plepd_execution_plan_id = t.plepd_execution_plan_id
    AND s.plepd_line_no = t.plepd_line_no
    
        WHERE t.plepd_ouinstance IS NULL;

        GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN

        INSERT INTO raw.raw_tms_plepd_execution_plan_details
        (
            plepd_ouinstance, plepd_execution_plan_id, plepd_line_no, plepd_bk_id, plepd_bk_ref_route_id, plepd_leg_id, plepd_leg_behaviour_id, plepd_leg_seq_no, plepd_leg_status, plepd_planning_seq_no, plepd_leg_from, plepd_from_leg_geo_type, plepd_leg_from_postal_code, plepd_leg_from_subzone, plepd_leg_from_city, plepd_leg_from_zone, plepd_leg_from_state, plepd_leg_from_region, plepd_leg_from_country, plepd_leg_to, plepd_to_leg_geo_type, plepd_leg_to_postal_code, plepd_leg_to_subzone, plepd_leg_to_city, plepd_leg_to_zone, plepd_leg_to_state, plepd_leg_to_region, plepd_leg_to_country, plepd_leg_transport_mode, plepd_available_qty, plepd_draft_qty, plepd_confirmed_qty, plepd_initiated_qty, plepd_executed_qty, plepd_qty_uom, plepd_available_vol, plepd_draft_vol, plepd_confirmed_vol, plepd_executed_vol, plepd_vol_uom, plepd_available_weight, plepd_draft_weight, plepd_confirmed_weight, plepd_executed_weight, plepd_weight_uom, plepd_created_by, plepd_created_Date, plepd_last_modified_by, plepd_last_modified_date, plepd_timestamp, plepd_leg_to_suburb, plepd_leg_from_suburb, plepd_est_trip_cost, plepd_act_trip_cost, plepd_ofc_col_quantity, plepd_updated_by, etlcreateddatetime
        )
        SELECT
           plepd_ouinstance, plepd_execution_plan_id, plepd_line_no, plepd_bk_id, plepd_bk_ref_route_id, plepd_leg_id, plepd_leg_behaviour_id, plepd_leg_seq_no, plepd_leg_status, plepd_planning_seq_no, plepd_leg_from, plepd_from_leg_geo_type, plepd_leg_from_postal_code, plepd_leg_from_subzone, plepd_leg_from_city, plepd_leg_from_zone, plepd_leg_from_state, plepd_leg_from_region, plepd_leg_from_country, plepd_leg_to, plepd_to_leg_geo_type, plepd_leg_to_postal_code, plepd_leg_to_subzone, plepd_leg_to_city, plepd_leg_to_zone, plepd_leg_to_state, plepd_leg_to_region, plepd_leg_to_country, plepd_leg_transport_mode, plepd_available_qty, plepd_draft_qty, plepd_confirmed_qty, plepd_initiated_qty, plepd_executed_qty, plepd_qty_uom, plepd_available_vol, plepd_draft_vol, plepd_confirmed_vol, plepd_executed_vol, plepd_vol_uom, plepd_available_weight, plepd_draft_weight, plepd_confirmed_weight, plepd_executed_weight, plepd_weight_uom, plepd_created_by, plepd_created_Date, plepd_last_modified_by, plepd_last_modified_date, plepd_timestamp, plepd_leg_to_suburb, plepd_leg_from_suburb, plepd_est_trip_cost, plepd_act_trip_cost, plepd_ofc_col_quantity, plepd_updated_by, etlcreateddatetime
        FROM stg.stg_tms_plepd_execution_plan_details;
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
ALTER PROCEDURE dwh.usp_f_tripexecutionplandetail(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
