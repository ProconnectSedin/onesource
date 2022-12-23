CREATE PROCEDURE dwh.usp_f_draftbillsuppliercontractdetail(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
    FROM stg.stg_wms_draft_bill_supplier_contract_dtl;

    UPDATE dwh.F_DraftBillSupplierContractDetail t
    SET
		draft_bill_location_key				= COALESCE(loc.loc_key,-1),
        draft_bill_contract_id              = s.wms_draft_bill_contract_id,
        draft_bill_contract_amend_no        = s.wms_draft_bill_contract_amend_no,
        draft_bill_created_by               = s.wms_draft_bill_created_by,
        draft_bill_created_date             = s.wms_draft_bill_created_date,
        draft_bill_billing_status           = s.wms_draft_bill_billing_status,
        draft_bill_value                    = s.wms_draft_bill_value,
        draft_bill_booking_location         = s.wms_draft_bill_booking_location,
        draft_bill_modified_by              = s.wms_draft_bill_modified_by,
        draft_bill_modified_date            = s.wms_draft_bill_modified_date,
        draft_bill_last_depart_date         = s.wms_draft_bill_last_depart_date,
        etlactiveind                        = 1,
        etljobname                          = p_etljobname,
        envsourcecd                         = p_envsourcecd,
        datasourcecd                        = p_datasourcecd,
        etlupdatedatetime                   = NOW()
    FROM stg.stg_wms_draft_bill_supplier_contract_dtl s
	LEFT join dwh.d_location loc
	ON		loc.loc_code			= s.wms_draft_bill_location
	AND		loc.loc_ou				= s.wms_draft_bill_ou
    WHERE	t.draft_bill_ou				= s.wms_draft_bill_ou
    AND		t.draft_bill_location		= s.wms_draft_bill_location
    AND		t.draft_bill_division		= s.wms_draft_bill_division
    AND		t.draft_bill_tran_type		= s.wms_draft_bill_tran_type
    AND		t.draft_bill_ref_doc_no		= s.wms_draft_bill_ref_doc_no
    AND		t.draft_bill_ref_doc_type	= s.wms_draft_bill_ref_doc_type
    AND		t.draft_bill_vendor_id		= s.wms_draft_bill_vendor_id
    AND		t.draft_bill_resource_type	= s.wms_draft_bill_resource_type;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_DraftBillSupplierContractDetail
    (
        draft_bill_location_key		, draft_bill_ou					, draft_bill_location, 
		draft_bill_division		, draft_bill_tran_type			, draft_bill_ref_doc_no			, draft_bill_ref_doc_type, 
		draft_bill_contract_id	, draft_bill_contract_amend_no	, draft_bill_vendor_id			, draft_bill_created_by, 
		draft_bill_created_date	, draft_bill_billing_status		, draft_bill_value				, draft_bill_booking_location, 
		draft_bill_modified_by	, draft_bill_modified_date		, draft_bill_last_depart_date	, draft_bill_resource_type, 
		etlactiveind			, etljobname					, envsourcecd					, datasourcecd, 
		etlcreatedatetime
    )

    SELECT
        COALESCE(loc.loc_key,-1),		s.wms_draft_bill_ou				, s.wms_draft_bill_location, 
		s.wms_draft_bill_division		, s.wms_draft_bill_tran_type		, s.wms_draft_bill_ref_doc_no		, s.wms_draft_bill_ref_doc_type, 
		s.wms_draft_bill_contract_id	, s.wms_draft_bill_contract_amend_no, s.wms_draft_bill_vendor_id		, s.wms_draft_bill_created_by, 
		s.wms_draft_bill_created_date	, s.wms_draft_bill_billing_status	, s.wms_draft_bill_value			, s.wms_draft_bill_booking_location, 
		s.wms_draft_bill_modified_by	, s.wms_draft_bill_modified_date	, s.wms_draft_bill_last_depart_date	, s.wms_draft_bill_resource_type, 
					1					, p_etljobname						, p_envsourcecd						, p_datasourcecd, 
		NOW()
    FROM stg.stg_wms_draft_bill_supplier_contract_dtl s
	LEFT join dwh.d_location loc
	ON		loc.loc_code			= s.wms_draft_bill_location
	AND		loc.loc_ou				= s.wms_draft_bill_ou
    LEFT JOIN dwh.F_DraftBillSupplierContractDetail t
    ON s.wms_draft_bill_ou = t.draft_bill_ou
    AND s.wms_draft_bill_location = t.draft_bill_location
    AND s.wms_draft_bill_division = t.draft_bill_division
    AND s.wms_draft_bill_tran_type = t.draft_bill_tran_type
    AND s.wms_draft_bill_ref_doc_no = t.draft_bill_ref_doc_no
    AND s.wms_draft_bill_ref_doc_type = t.draft_bill_ref_doc_type
    AND s.wms_draft_bill_vendor_id = t.draft_bill_vendor_id
    AND s.wms_draft_bill_resource_type = t.draft_bill_resource_type
    WHERE t.draft_bill_ou IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_wms_draft_bill_supplier_contract_dtl
    (
        wms_draft_bill_ou, wms_draft_bill_location, wms_draft_bill_division, 
		wms_draft_bill_tran_type, wms_draft_bill_ref_doc_no, wms_draft_bill_ref_doc_type, 
		wms_draft_bill_contract_id, wms_draft_bill_contract_amend_no, wms_draft_bill_vendor_id, 
		wms_draft_bill_created_by, wms_draft_bill_created_date, wms_draft_bill_billing_status, 
		wms_draft_bill_value, wms_draft_bill_booking_location, wms_draft_bill_modified_by, 
		wms_draft_bill_modified_date, wms_draft_bill_last_depart_date, wms_draft_bill_resource_type, 
		etlcreateddatetime
    )
    SELECT
        wms_draft_bill_ou, wms_draft_bill_location, wms_draft_bill_division, 
		wms_draft_bill_tran_type, wms_draft_bill_ref_doc_no, wms_draft_bill_ref_doc_type, 
		wms_draft_bill_contract_id, wms_draft_bill_contract_amend_no, wms_draft_bill_vendor_id, 
		wms_draft_bill_created_by, wms_draft_bill_created_date, wms_draft_bill_billing_status, 
		wms_draft_bill_value, wms_draft_bill_booking_location, wms_draft_bill_modified_by, 
		wms_draft_bill_modified_date, wms_draft_bill_last_depart_date, wms_draft_bill_resource_type, 
		etlcreateddatetime
	FROM stg.stg_wms_draft_bill_supplier_contract_dtl;
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