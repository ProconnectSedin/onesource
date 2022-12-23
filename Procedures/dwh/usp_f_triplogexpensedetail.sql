CREATE PROCEDURE dwh.usp_f_triplogexpensedetail(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
    FROM stg.stg_tms_tled_trip_log_expense_details;
	
	UPDATE dwh.F_TripLogExpenseDetail t
    SET
        tled_ouinstance                    = s.tled_ouinstance,
        tled_trip_plan_id                  = s.tled_trip_plan_id,
        tled_trip_plan_line_id             = s.tled_trip_plan_line_id,
        tled_expense_record                = s.tled_expense_record,
        tled_expense_type                  = s.tled_expense_type,
        tled_bill_no                       = s.tled_bill_no,
        tled_bill_date                     = s.tled_bill_date,
        tled_bill_amount                   = s.tled_bill_amount,
        tled_claimed_amount                = s.tled_claimed_amount,
        tled_approved_amount               = s.tled_approved_amount,
        tled_currency                      = s.tled_currency,
        tled_remarks                       = s.tled_remarks,
        tled_created_date                  = s.tled_created_date,
        tled_created_by                    = s.tled_created_by,
        tled_modified_date                 = s.tled_modified_date,
        tled_modified_by                   = s.tled_modified_by,
        tled_timestamp                     = s.tled_timestamp,
        tled_status                        = s.tled_status,
        tled_leq_no                        = s.tled_leq_no,
        tled_previous_status               = s.tled_previous_status,
        tled_workflow_status               = s.tled_workflow_status,
        tled_workflow_error                = s.tled_workflow_error,
        tled_wf_guid                       = s.tled_wf_guid,
        tms_tled_hdr_guid                  = s.tms_tled_hdr_guid,
        tms_tled_guid                      = s.tms_tled_guid,
        tms_tled_exp_requset_no            = s.tms_tled_exp_requset_no,
        tms_tled_exp_resource_id           = s.tms_tled_exp_resource_id,
        tms_tled_adv_amount                = s.tms_tled_adv_amount,
        tms_tled_adv_amt_ref               = s.tms_tled_adv_amt_ref,
        tled_bill_base_amount              = s.tled_bill_base_amount,
        tled_claimed_base_amount           = s.tled_claimed_base_amount,
        tled_approved_base_amount          = s.tled_approved_base_amount,
        tms_tled_adv_base_amount           = s.tms_tled_adv_base_amount,
        tleh_draft_bill_line_status        = s.tleh_draft_bill_line_status,
        tled_via_point                     = s.tled_via_point,
        tled_resource_reimbursement        = s.tled_resource_reimbursement,
        tled_customer_reimbursement        = s.tled_customer_reimbursement,
        tled_transaction_date              = s.tled_transaction_date,
        tled_refdoc_type                   = s.tled_refdoc_type,
        tled_refdoc_no                     = s.tled_refdoc_no,
        tled_tariff_id                     = s.tled_tariff_id,
        tled_amendment_no                  = s.tled_amendment_no,
        tled_rejection_remarks             = s.tled_rejection_remarks,
        tled_attachment                    = s.tled_attachment,
        etlactiveind                       = 1,
        etljobname                         = p_etljobname,
        envsourcecd                        = p_envsourcecd,
        datasourcecd                       = p_datasourcecd,
        etlupdatedatetime                  = NOW()
    FROM stg.stg_tms_tled_trip_log_expense_details s
    WHERE t.tled_ouinstance = s.tled_ouinstance
    AND t.tled_trip_plan_id = s.tled_trip_plan_id
    AND t.tled_trip_plan_line_id = s.tled_trip_plan_line_id
	AND t.tms_tled_guid	=	s.tms_tled_guid;

    GET DIAGNOSTICS updcnt = ROW_COUNT;
	
    INSERT INTO dwh.F_TripLogExpenseDetail
    (

        tled_ouinstance				, tled_trip_plan_id				, tled_trip_plan_line_id	, tled_expense_record			, 
		tled_expense_type			, tled_bill_no					, tled_bill_date			, tled_bill_amount				, 
		tled_claimed_amount			, tled_approved_amount			, tled_currency				, tled_remarks					, 
		tled_created_date			, tled_created_by				, tled_modified_date		, tled_modified_by				, 
		tled_timestamp				, tled_status					, tled_leq_no				, tled_previous_status			,
		tled_workflow_status		, tled_workflow_error			, tled_wf_guid				, tms_tled_hdr_guid				, 
		tms_tled_guid				, tms_tled_exp_requset_no		, tms_tled_exp_resource_id	, tms_tled_adv_amount			, 
		tms_tled_adv_amt_ref		, tled_bill_base_amount			, tled_claimed_base_amount	, tled_approved_base_amount		, 
		tms_tled_adv_base_amount	, tleh_draft_bill_line_status	, tled_via_point			, tled_resource_reimbursement	, 
		tled_customer_reimbursement	, tled_transaction_date			, tled_refdoc_type			, tled_refdoc_no				, 
		tled_tariff_id				, tled_amendment_no				, tled_rejection_remarks	, tled_attachment				, 
		etlactiveind				, etljobname					, envsourcecd				, datasourcecd					,
		etlcreatedatetime
    )

    SELECT

        s.tled_ouinstance				, s.tled_trip_plan_id			, s.tled_trip_plan_line_id	, s.tled_expense_record			, 
		s.tled_expense_type				, s.tled_bill_no				, s.tled_bill_date			, s.tled_bill_amount			, 
		s.tled_claimed_amount			, s.tled_approved_amount		, s.tled_currency			, s.tled_remarks				, 
		s.tled_created_date				, s.tled_created_by				, s.tled_modified_date		, s.tled_modified_by			, 
		s.tled_timestamp				, s.tled_status					, s.tled_leq_no				, s.tled_previous_status		, 
		s.tled_workflow_status			, s.tled_workflow_error			, s.tled_wf_guid			, s.tms_tled_hdr_guid			,
		s.tms_tled_guid					, s.tms_tled_exp_requset_no		, s.tms_tled_exp_resource_id, s.tms_tled_adv_amount			, 
		s.tms_tled_adv_amt_ref			, s.tled_bill_base_amount		, s.tled_claimed_base_amount, s.tled_approved_base_amount	, 
		s.tms_tled_adv_base_amount		, s.tleh_draft_bill_line_status	, s.tled_via_point			, s.tled_resource_reimbursement	, 
		s.tled_customer_reimbursement	, s.tled_transaction_date		, s.tled_refdoc_type		, s.tled_refdoc_no				, 
		s.tled_tariff_id				, s.tled_amendment_no			, s.tled_rejection_remarks	, s.tled_attachment				, 
					1					, p_etljobname					, p_envsourcecd				, p_datasourcecd				, 
		NOW()
    FROM	stg.stg_tms_tled_trip_log_expense_details s
    LEFT JOIN dwh.F_TripLogExpenseDetail t
    ON		s.tled_ouinstance 			= t.tled_ouinstance
    AND		s.tled_trip_plan_id 		= t.tled_trip_plan_id
    AND		s.tled_trip_plan_line_id 	= t.tled_trip_plan_line_id
	AND 	s.tms_tled_guid				= t.tms_tled_guid
    WHERE	t.tled_ouinstance IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_tms_tled_trip_log_expense_details
    (
        tled_ouinstance				, tled_trip_plan_id				, tled_trip_plan_line_id	, tled_expense_record		, 
		tled_expense_type			, tled_bill_no					, tled_bill_date			, tled_bill_amount			, 
		tled_claimed_amount			, tled_approved_amount			, tled_currency				, tled_remarks				, 
		tled_created_date			, tled_created_by				, tled_modified_date		, tled_modified_by			, 
		tled_timestamp				, tled_status					, tled_leq_no				, tled_previous_status		, 
		tled_workflow_status		, tled_workflow_error			, tled_wf_guid				, tms_tled_hdr_guid			, 
		tms_tled_guid				, tms_tled_exp_requset_no		, tms_tled_exp_resource_id	, tms_tled_adv_amount		, 
		tms_tled_adv_amt_ref		, tled_bill_base_amount			, tled_claimed_base_amount	, tled_approved_base_amount	, 
		tms_tled_adv_base_amount	, tleh_draft_bill_line_status	, tled_via_point			, tled_resource_reimbursement, 
		tled_customer_reimbursement	, tled_transaction_date			, tled_refdoc_type			, tled_refdoc_no			, 
		tled_tariff_id				, tled_amendment_no				, tled_rejection_remarks	, tled_attachment			, 
		etlcreateddatetime
    )
    SELECT
        tled_ouinstance				, tled_trip_plan_id				, tled_trip_plan_line_id	, tled_expense_record		, 
		tled_expense_type			, tled_bill_no					, tled_bill_date			, tled_bill_amount			, 
		tled_claimed_amount			, tled_approved_amount			, tled_currency				, tled_remarks				, 
		tled_created_date			, tled_created_by				, tled_modified_date		, tled_modified_by			, 
		tled_timestamp				, tled_status					, tled_leq_no				, tled_previous_status		, 
		tled_workflow_status		, tled_workflow_error			, tled_wf_guid				, tms_tled_hdr_guid			, 
		tms_tled_guid				, tms_tled_exp_requset_no		, tms_tled_exp_resource_id	, tms_tled_adv_amount		, 
		tms_tled_adv_amt_ref		, tled_bill_base_amount			, tled_claimed_base_amount	, tled_approved_base_amount	, 
		tms_tled_adv_base_amount	, tleh_draft_bill_line_status	, tled_via_point			, tled_resource_reimbursement, 
		tled_customer_reimbursement	, tled_transaction_date			, tled_refdoc_type			, tled_refdoc_no			, 
		tled_tariff_id				, tled_amendment_no				, tled_rejection_remarks	, tled_attachment			, 
		etlcreateddatetime
    FROM stg.stg_tms_tled_trip_log_expense_details;
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