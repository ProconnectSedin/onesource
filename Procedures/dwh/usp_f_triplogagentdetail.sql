-- PROCEDURE: dwh.usp_f_triplogagentdetail(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_triplogagentdetail(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_triplogagentdetail(
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

    IF EXISTS(SELECT 1 FROM ods.controlheader WHERE sourceid = p_depsource AND status >= 'Completed' 
                    AND CAST(COALESCE(lastupdateddate,createddate) AS DATE) >= NOW()::DATE)
    THEN
        SELECT COUNT(1) INTO srccnt
        FROM stg.stg_tms_tlad_trip_log_agent_details;

        UPDATE dwh.F_TripLogAgentDetail t
        SET

        plpth_hdr_key                    = oh.plpth_hdr_key,
        tlad_thu_agent_qty               = s.tlad_thu_agent_qty,
        tlad_thu_agent_weight            = s.tlad_thu_agent_weight,
        tlad_thu_agent_volume            = s.tlad_thu_agent_volume,
        tlad_ag_ref_doc_type             = s.tlad_ag_ref_doc_type,
        tlad_ag_ref_doc_no               = s.tlad_ag_ref_doc_no,
        tlad_ag_ref_doc_date             = s.tlad_ag_ref_doc_date,
        tlad_agent_remarks               = s.tlad_agent_remarks,
        tlad_thu_agent_qty_uom           = s.tlad_thu_agent_qty_uom,
        tlad_thu_agent_weight_uom        = s.tlad_thu_agent_weight_uom,
        tlad_thu_agent_volume_uom        = s.tlad_thu_agent_volume_uom,
        tlad_timestamp                   = s.tlad_timestamp,
        tlad_created_by                  = s.tlad_created_by,
        tlad_creation_date               = s.tlad_creation_date,
        tlad_last_modified_by            = s.tlad_last_modified_by,
        tlad_last_modified_date          = s.tlad_last_modified_date,
            etlactiveind                     = 1,
        etljobname                       = p_etljobname,
        envsourcecd                      = p_envsourcecd,
        datasourcecd                     = p_datasourcecd,
        etlupdatedatetime                = NOW()
        FROM stg.stg_tms_tlad_trip_log_agent_details s

         INNER JOIN dwh.f_tripplanningheader oh  
ON           s.tlad_ouinstance  = oh.plpth_ouinstance
      AND s.tlad_trip_plan_id   = oh.plpth_trip_plan_id
      
        WHERE t.tlad_ouinstance = s.tlad_ouinstance
    AND t.tlad_trip_plan_id = s.tlad_trip_plan_id
    AND t.tlad_dispatch_doc_no = s.tlad_dispatch_doc_no
    AND t.tlad_thu_line_no = s.tlad_thu_line_no
    AND t.plpth_hdr_key  = oh.plpth_hdr_key;

        GET DIAGNOSTICS updcnt = ROW_COUNT;

        INSERT INTO dwh.F_TripLogAgentDetail
        (
            plpth_hdr_key,tlad_ouinstance, tlad_trip_plan_id, tlad_dispatch_doc_no, tlad_thu_line_no, tlad_thu_agent_qty, tlad_thu_agent_weight, tlad_thu_agent_volume, tlad_ag_ref_doc_type, tlad_ag_ref_doc_no, tlad_ag_ref_doc_date, tlad_agent_remarks, tlad_thu_agent_qty_uom, tlad_thu_agent_weight_uom, tlad_thu_agent_volume_uom, tlad_timestamp, tlad_created_by, tlad_creation_date, tlad_last_modified_by, tlad_last_modified_date, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
        )

        SELECT
            oh.plpth_hdr_key,s.tlad_ouinstance, s.tlad_trip_plan_id, s.tlad_dispatch_doc_no, s.tlad_thu_line_no, s.tlad_thu_agent_qty, s.tlad_thu_agent_weight, s.tlad_thu_agent_volume, s.tlad_ag_ref_doc_type, s.tlad_ag_ref_doc_no, s.tlad_ag_ref_doc_date, s.tlad_agent_remarks, s.tlad_thu_agent_qty_uom, s.tlad_thu_agent_weight_uom, s.tlad_thu_agent_volume_uom, s.tlad_timestamp, s.tlad_created_by, s.tlad_creation_date, s.tlad_last_modified_by, s.tlad_last_modified_date, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
        FROM stg.stg_tms_tlad_trip_log_agent_details s

        INNER JOIN dwh.f_tripplanningheader oh  
ON           s.tlad_ouinstance  = oh.plpth_ouinstance
      AND s.tlad_trip_plan_id   = oh.plpth_trip_plan_id
      
        LEFT JOIN dwh.F_TripLogAgentDetail t
        ON s.tlad_ouinstance = t.tlad_ouinstance
    AND s.tlad_trip_plan_id = t.tlad_trip_plan_id
    AND s.tlad_dispatch_doc_no = t.tlad_dispatch_doc_no
    AND s.tlad_thu_line_no = t.tlad_thu_line_no
        AND t.plpth_hdr_key  = oh.plpth_hdr_key

        WHERE t.tlad_ouinstance IS NULL;

        GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN

        INSERT INTO raw.raw_tms_tlad_trip_log_agent_details
        (
            tlad_ouinstance, tlad_trip_plan_id, tlad_dispatch_doc_no, tlad_thu_line_no, tlad_thu_agent_qty, tlad_thu_agent_weight, tlad_thu_agent_volume, tlad_ag_ref_doc_type, tlad_ag_ref_doc_no, tlad_ag_ref_doc_date, tlad_agent_remarks, tlad_thu_agent_qty_uom, tlad_thu_agent_weight_uom, tlad_thu_agent_volume_uom, tlad_timestamp, tlad_created_by, tlad_creation_date, tlad_last_modified_by, tlad_last_modified_date, etlcreateddatetime
        )
        SELECT
            tlad_ouinstance, tlad_trip_plan_id, tlad_dispatch_doc_no, tlad_thu_line_no, tlad_thu_agent_qty, tlad_thu_agent_weight, tlad_thu_agent_volume, tlad_ag_ref_doc_type, tlad_ag_ref_doc_no, tlad_ag_ref_doc_date, tlad_agent_remarks, tlad_thu_agent_qty_uom, tlad_thu_agent_weight_uom, tlad_thu_agent_volume_uom, tlad_timestamp, tlad_created_by, tlad_creation_date, tlad_last_modified_by, tlad_last_modified_date, etlcreateddatetime
        FROM stg.stg_tms_tlad_trip_log_agent_details;
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
ALTER PROCEDURE dwh.usp_f_triplogagentdetail(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
