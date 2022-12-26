CREATE OR REPLACE PROCEDURE dwh.usp_f_triplogexpensedocdetail(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
	FROM stg.stg_tms_tledd_trip_log_expense_Document_details;

    UPDATE dwh.F_TripLogExpenseDocDetail t
    SET
        tledd_trip_plan              = s.tledd_trip_plan,
        tledd_trip_leg_seq_id        = s.tledd_trip_leg_seq_id,
        tledd_rec_exp                = s.tledd_rec_exp,
        tledd_exp_type               = s.tledd_exp_type,
        tledd_bill_no                = s.tledd_bill_no,
        tledd_document_id            = s.tledd_document_id,
        tledd_document_date          = s.tledd_document_date,
        tledd_remarks                = s.tledd_remarks,
        tledd_created_by             = s.tledd_created_by,
        tledd_created_date           = s.tledd_created_date,
        tledd_modified_by            = s.tledd_modified_by,
        tledd_modified_date          = s.tledd_modified_date,
        tled_timestamp               = s.tled_timestamp,
        tledd_attachment             = s.tledd_attachment,
        etlactiveind                 = 1,
        etljobname                   = p_etljobname,
        envsourcecd                  = p_envsourcecd,
        datasourcecd                 = p_datasourcecd,
        etlupdatedatetime            = NOW()
    FROM stg.stg_tms_tledd_trip_log_expense_document_details s
    WHERE t.tledd_ouinstance = s.tledd_ouinstance
    AND t.tledd_doc_guid = s.tledd_doc_guid;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_TripLogExpenseDocDetail
    (
        tledd_ouinstance	, tledd_trip_plan		, tledd_trip_leg_seq_id	, tledd_rec_exp		,
		tledd_exp_type		, tledd_bill_no			, tledd_doc_guid		, tledd_document_id	, 
		tledd_document_date	, tledd_remarks			, tledd_created_by		, tledd_created_date, 
		tledd_modified_by	, tledd_modified_date	, tled_timestamp		, tledd_attachment	,
		etlactiveind		, etljobname			, envsourcecd			, datasourcecd		, 
		etlcreatedatetime
    )

    SELECT
        s.tledd_ouinstance		, s.tledd_trip_plan		, s.tledd_trip_leg_seq_id	, s.tledd_rec_exp		,
		s.tledd_exp_type		, s.tledd_bill_no		, s.tledd_doc_guid			, s.tledd_document_id	, 
		s.tledd_document_date	, s.tledd_remarks		, s.tledd_created_by		, s.tledd_created_date	,
		s.tledd_modified_by		, s.tledd_modified_date	, s.tled_timestamp			, s.tledd_attachment	, 
					1			, p_etljobname			, p_envsourcecd				, p_datasourcecd		,
		NOW()
    FROM stg.stg_tms_tledd_trip_log_expense_document_details s
    LEFT JOIN dwh.F_TripLogExpenseDocDetail t
    ON s.tledd_ouinstance = t.tledd_ouinstance
    AND s.tledd_doc_guid = t.tledd_doc_guid
    WHERE t.tledd_ouinstance IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_tms_tledd_trip_log_expense_Document_details
    (
        tledd_ouinstance, tledd_trip_plan, tledd_trip_leg_seq_id, tledd_rec_exp, 
		tledd_exp_type, tledd_bill_no, tledd_doc_guid, tledd_document_id, 
		tledd_document_date, tledd_remarks, tledd_created_by, tledd_created_date, 
		tledd_modified_by, tledd_modified_date, tled_timestamp, tledd_attachment,
		etlcreateddatetime
    )
    SELECT
        tledd_ouinstance, tledd_trip_plan, tledd_trip_leg_seq_id, tledd_rec_exp,
		tledd_exp_type, tledd_bill_no, tledd_doc_guid, tledd_document_id, 
		tledd_document_date, tledd_remarks, tledd_created_by, tledd_created_date, 
		tledd_modified_by, tledd_modified_date, tled_timestamp, tledd_attachment, 
		etlcreateddatetime
    FROM stg.stg_tms_tledd_trip_log_expense_document_details;
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