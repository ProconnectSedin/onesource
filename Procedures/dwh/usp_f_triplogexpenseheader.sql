CREATE PROCEDURE dwh.usp_f_triplogexpenseheader(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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

    SELECT COUNT(1) INTO srccnt
    FROM stg.stg_tms_tleh_trip_log_expence_hdr;

    UPDATE dwh.F_TripLogExpenseHeader t
    SET
		
        tleh_expense_for                   = s.tleh_expense_for,
        tleh_trip_leg_no                   = s.tleh_trip_leg_no,
        tleh_resource_id                   = s.tleh_resource_id,
        tleh_resource_name                 = s.tleh_resource_name,
        tleh_advance_amount                = s.tleh_advance_amount,
        tleh_expense_amount                = s.tleh_expense_amount,
        tleh_report_status                 = s.tleh_report_status,
        tleh_guid                          = s.tleh_guid,
        tleh_workflow_status               = s.tleh_workflow_status,
        tleh_reject_reason                 = s.tleh_reject_reason,
        tleh_reject_reason_desc            = s.tleh_reject_reason_desc,
        tleh_cancel_reason                 = s.tleh_cancel_reason,
        tleh_remarks                       = s.tleh_remarks,
        tleh_creation_date                 = s.tleh_creation_date,
        tleh_created_by                    = s.tleh_created_by,
        tleh_last_modified_date            = s.tleh_last_modified_date,
        tleh_last_modified_by              = s.tleh_last_modified_by,
        tleh_timestamp                     = s.tleh_timestamp,
        tleh_draft_bill_status             = s.tleh_draft_bill_status,
        tleh_resource_type                 = s.tleh_resource_type,
        tleh_refdoc_type                   = s.tleh_refdoc_type,
        tleh_refdoc_no                     = s.tleh_refdoc_no,
        tleh_agency_id                     = s.tleh_agency_id,
        tleh_agency_name                   = s.tleh_agency_name,
        tleh_requester_id                  = s.tleh_requester_id,
        tleh_requester_name                = s.tleh_requester_name,
        tleh_estimated_setlmnt_date        = s.tleh_estimated_setlmnt_date,
        tleh_amendment_no                  = s.tleh_amendment_no,
        tleh_amend_reason                  = s.tleh_amend_reason,
        tleh_amend_reason_desc             = s.tleh_amend_reason_desc,
        tleh_rpt_mob_ref_no                = s.tleh_rpt_mob_ref_no,
        etlactiveind                       = 1,
        etljobname                         = p_etljobname,
        envsourcecd                        = p_envsourcecd,
        datasourcecd                       = p_datasourcecd,
        etlupdatedatetime                  = NOW()
    FROM 	stg.stg_tms_tleh_trip_log_expence_hdr s
    WHERE 	t.tleh_ouinstance 		= s.tleh_ouinstance
    AND 	t.tleh_report_no 		= s.tleh_report_no
	AND		t.tleh_report_creation_date = s.tleh_report_creation_date
    AND 	t.tleh_trip_id 			= s.tleh_trip_id;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_TripLogExpenseHeader
    (
		
        tleh_ouinstance			, tleh_report_no		, tleh_report_creation_date		, tleh_trip_id			,
		tleh_expense_for		, tleh_trip_leg_no		, tleh_resource_id				, tleh_resource_name	,
		tleh_advance_amount		, tleh_expense_amount	, tleh_report_status			, tleh_guid				,
		tleh_workflow_status	, tleh_reject_reason	, tleh_reject_reason_desc		, tleh_cancel_reason	,
		tleh_remarks			, tleh_creation_date	, tleh_created_by				, tleh_last_modified_date,
		tleh_last_modified_by	, tleh_timestamp		, tleh_draft_bill_status		, tleh_resource_type	,
		tleh_refdoc_type		, tleh_refdoc_no		, tleh_agency_id				, tleh_agency_name		,
		tleh_requester_id		, tleh_requester_name	, tleh_estimated_setlmnt_date	, tleh_amendment_no		,
		tleh_amend_reason		, tleh_amend_reason_desc, tleh_rpt_mob_ref_no			,
		etlactiveind			, etljobname			, envsourcecd					, datasourcecd			,
		etlcreatedatetime
    )

    SELECT
		
        s.tleh_ouinstance		, s.tleh_report_no			, s.tleh_report_creation_date	, s.tleh_trip_id			,
		s.tleh_expense_for		, s.tleh_trip_leg_no		, s.tleh_resource_id			, s.tleh_resource_name		, 
		s.tleh_advance_amount	, s.tleh_expense_amount		, s.tleh_report_status			, s.tleh_guid				, 
		s.tleh_workflow_status	, s.tleh_reject_reason		, s.tleh_reject_reason_desc		, s.tleh_cancel_reason		,
		s.tleh_remarks			, s.tleh_creation_date		, s.tleh_created_by				, s.tleh_last_modified_date	,
		s.tleh_last_modified_by	, s.tleh_timestamp			, s.tleh_draft_bill_status		, s.tleh_resource_type		, 
		s.tleh_refdoc_type		, s.tleh_refdoc_no			, s.tleh_agency_id				, s.tleh_agency_name		, 
		s.tleh_requester_id		, s.tleh_requester_name		, s.tleh_estimated_setlmnt_date	, s.tleh_amendment_no		, 
		s.tleh_amend_reason		, s.tleh_amend_reason_desc	, s.tleh_rpt_mob_ref_no			, 
					1			, p_etljobname				, p_envsourcecd					, p_datasourcecd			, 
		NOW()
    FROM	stg.stg_tms_tleh_trip_log_expence_hdr s
    LEFT JOIN dwh.F_TripLogExpenseHeader t
    ON		s.tleh_ouinstance		= t.tleh_ouinstance
    AND		s.tleh_report_no		= t.tleh_report_no
    AND		s.tleh_trip_id			= t.tleh_trip_id
	AND		s.tleh_report_creation_date= t.tleh_report_creation_date
    WHERE	t.tleh_ouinstance IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_tms_tleh_trip_log_expence_hdr
    (
        tleh_ouinstance			, tleh_report_no		, tleh_report_creation_date		, tleh_trip_id			, 
		tleh_expense_for		, tleh_trip_leg_no		, tleh_resource_id				, tleh_resource_name	, 
		tleh_advance_amount		, tleh_expense_amount	, tleh_report_status			, tleh_guid				,
		tleh_workflow_status	, tleh_reject_reason	, tleh_reject_reason_desc		, tleh_cancel_reason	, 
		tleh_remarks			, tleh_creation_date	, tleh_created_by				, tleh_last_modified_date,
		tleh_last_modified_by	, tleh_timestamp		, tleh_draft_bill_status		, tleh_resource_type	,
		tleh_refdoc_type		, tleh_refdoc_no		, tleh_agency_id				, tleh_agency_name		, 
		tleh_requester_id		, tleh_requester_name	, tleh_estimated_setlmnt_date	, tleh_amendment_no		, 
		tleh_amend_reason		, tleh_amend_reason_desc, tleh_rpt_mob_ref_no			, etlcreateddatetime
    )
    SELECT
        tleh_ouinstance			, tleh_report_no		, tleh_report_creation_date		, tleh_trip_id			, 
		tleh_expense_for		, tleh_trip_leg_no		, tleh_resource_id				, tleh_resource_name	, 
		tleh_advance_amount		, tleh_expense_amount	, tleh_report_status			, tleh_guid				,
		tleh_workflow_status	, tleh_reject_reason	, tleh_reject_reason_desc		, tleh_cancel_reason	, 
		tleh_remarks			, tleh_creation_date	, tleh_created_by				, tleh_last_modified_date,
		tleh_last_modified_by	, tleh_timestamp		, tleh_draft_bill_status		, tleh_resource_type	,
		tleh_refdoc_type		, tleh_refdoc_no		, tleh_agency_id				, tleh_agency_name		, 
		tleh_requester_id		, tleh_requester_name	, tleh_estimated_setlmnt_date	, tleh_amendment_no		, 
		tleh_amend_reason		, tleh_amend_reason_desc, tleh_rpt_mob_ref_no			, etlcreateddatetime
	FROM stg.stg_tms_tleh_trip_log_expence_hdr;
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