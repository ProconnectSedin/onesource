-- PROCEDURE: dwh.usp_f_tenderrequirementheader(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_tenderrequirementheader(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_tenderrequirementheader(
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
    FROM stg.stg_tms_trh_tender_req_header;

    UPDATE dwh.F_TenderRequirementHeader t
    SET
		trh_date_key                     = COALESCE(d.datekey,-1),
        trh_ouinstance                   = s.trh_ouinstance,
        trh_tender_req_no                = s.trh_tender_req_no,
        trh_numtype                      = s.trh_numtype,
        trh_tender_req_status            = s.trh_tender_req_status,
        trh_tender_req_date              = s.trh_tender_req_date,
        trh_req_type                     = s.trh_req_type,
        trh_req_id                       = s.trh_req_id,
        trh_resp_time_limit              = s.trh_resp_time_limit,
        trh_resp_time_limit_uom          = s.trh_resp_time_limit_uom,
        trh_tender_inst                  = s.trh_tender_inst,
        trh_transport_mode               = s.trh_transport_mode,
        trh_created_by                   = s.trh_created_by,
        trh_created_date                 = s.trh_created_date,
        trh_last_modified_by             = s.trh_last_modified_by,
        trh_lst_modified_date            = s.trh_lst_modified_date,
        trh_timestamp                    = s.trh_timestamp,
        trh_tender_confirm_status        = s.trh_tender_confirm_status,
        trh_resp_before                  = s.trh_resp_before,
        trh_tender_req_status_old        = s.trh_tender_req_status_old,
        trh_tender_req_prevstatus        = s.trh_tender_req_prevstatus,
        trh_workflow_status              = s.trh_workflow_status,
        trh_workflow_error               = s.trh_workflow_error,
        trh_wf_guid                      = s.trh_wf_guid,
        trh_multi_del_ins_flag           = s.trh_multi_del_ins_flag,
        trh_multi_del_ins                = s.trh_multi_del_ins,
        trh_request_cost_currency        = s.trh_request_cost_currency,
        trh_requested_ext_cost           = s.trh_requested_ext_cost,
        trh_reason_rejection_mtr         = s.trh_reason_rejection_mtr,
        trh_workflow_status_mtr          = s.trh_workflow_status_mtr,
        etlactiveind                     = 1,
        etljobname                       = p_etljobname,
        envsourcecd                      = p_envsourcecd,
        datasourcecd                     = p_datasourcecd,
        etlupdatedatetime                = NOW()
    FROM stg.stg_tms_trh_tender_req_header s
	
	LEFT JOIN dwh.d_date D 			
		ON s.trh_tender_req_date::date = D.dateactual
		
    WHERE t.trh_ouinstance = s.trh_ouinstance
    AND t.trh_tender_req_no = s.trh_tender_req_no;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_TenderRequirementHeader
    (
         trh_date_key ,trh_ouinstance, trh_tender_req_no, trh_numtype, trh_tender_req_status, trh_tender_req_date, trh_req_type, trh_req_id, trh_resp_time_limit, trh_resp_time_limit_uom, trh_tender_inst, trh_transport_mode, trh_created_by, trh_created_date, trh_last_modified_by, trh_lst_modified_date, trh_timestamp, trh_tender_confirm_status, trh_resp_before, trh_tender_req_status_old, trh_tender_req_prevstatus, trh_workflow_status, trh_workflow_error, trh_wf_guid, trh_multi_del_ins_flag, trh_multi_del_ins, trh_request_cost_currency, trh_requested_ext_cost, trh_reason_rejection_mtr, trh_workflow_status_mtr, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        COALESCE(d.datekey,-1) ,s.trh_ouinstance, s.trh_tender_req_no, s.trh_numtype, s.trh_tender_req_status, s.trh_tender_req_date, s.trh_req_type, s.trh_req_id, s.trh_resp_time_limit, s.trh_resp_time_limit_uom, s.trh_tender_inst, s.trh_transport_mode, s.trh_created_by, s.trh_created_date, s.trh_last_modified_by, s.trh_lst_modified_date, s.trh_timestamp, s.trh_tender_confirm_status, s.trh_resp_before, s.trh_tender_req_status_old, s.trh_tender_req_prevstatus, s.trh_workflow_status, s.trh_workflow_error, s.trh_wf_guid, s.trh_multi_del_ins_flag, s.trh_multi_del_ins, s.trh_request_cost_currency, s.trh_requested_ext_cost, s.trh_reason_rejection_mtr, s.trh_workflow_status_mtr, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_tms_trh_tender_req_header s
	
	LEFT JOIN dwh.d_date D 			
		ON s.trh_tender_req_date::date = D.dateactual
    LEFT JOIN dwh.F_TenderRequirementHeader t
    ON s.trh_ouinstance = t.trh_ouinstance
    AND s.trh_tender_req_no = t.trh_tender_req_no
    WHERE t.trh_ouinstance IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_tms_trh_tender_req_header
    (
        trh_ouinstance, trh_tender_req_no, trh_numtype, trh_tender_req_status, trh_tender_req_date, trh_req_type, trh_req_id, trh_resp_time_limit, trh_resp_time_limit_uom, trh_tender_inst, trh_transport_mode, trh_created_by, trh_created_date, trh_last_modified_by, trh_lst_modified_date, trh_timestamp, trh_tender_confirm_status, trh_resp_before, trh_tender_req_status_old, trh_tender_req_prevstatus, trh_workflow_status, trh_workflow_error, trh_wf_guid, trh_multi_del_ins_flag, trh_multi_del_ins, trh_request_cost_currency, trh_requested_ext_cost, trh_reason_rejection_mtr, trh_workflow_status_mtr, etlcreateddatetime
    )
    SELECT
        trh_ouinstance, trh_tender_req_no, trh_numtype, trh_tender_req_status, trh_tender_req_date, trh_req_type, trh_req_id, trh_resp_time_limit, trh_resp_time_limit_uom, trh_tender_inst, trh_transport_mode, trh_created_by, trh_created_date, trh_last_modified_by, trh_lst_modified_date, trh_timestamp, trh_tender_confirm_status, trh_resp_before, trh_tender_req_status_old, trh_tender_req_prevstatus, trh_workflow_status, trh_workflow_error, trh_wf_guid, trh_multi_del_ins_flag, trh_multi_del_ins, trh_request_cost_currency, trh_requested_ext_cost, trh_reason_rejection_mtr, trh_workflow_status_mtr, etlcreateddatetime
    FROM stg.stg_tms_trh_tender_req_header;
    
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
ALTER PROCEDURE dwh.usp_f_tenderrequirementheader(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
