CREATE OR REPLACE PROCEDURE dwh.usp_f_contractrevleakdetail(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
    ON    d.sourceid			= h.sourceid
    WHERE d.sourceid		    = p_sourceId
    AND   d.dataflowflag		= p_dataflowflag
    AND   d.targetobject		= p_targetobject;

    SELECT COUNT(1) INTO srccnt
    FROM stg.stg_wms_contract_rev_leak_dtl;

    UPDATE dwh.f_contractRevLeakDetail t
    SET
        cont_rev_lkge_contid                  = s.wms_cont_rev_lkge_contid,
        cont_rev_lkge_doc_type                = s.wms_cont_rev_lkge_doc_type,
        cont_rev_lkge_doc_no                  = s.wms_cont_rev_lkge_doc_no,
        cont_rev_lkge_cust_id                 = s.wms_cont_rev_lkge_cust_id,
        cont_rev_lkge_revenue                 = s.wms_cont_rev_lkge_revenue,
        cont_rev_lkge_created_by              = s.wms_cont_rev_lkge_created_by,
        cont_rev_lkge_created_date            = s.wms_cont_rev_lkge_created_date,
        cont_rev_lkge_modified_by             = s.wms_cont_rev_lkge_modified_by,
        cont_rev_lkge_modified_date           = s.wms_cont_rev_lkge_modified_date,
        cont_rev_lkge_timestamp               = s.wms_cont_rev_lkge_timestamp,
        cont_rev_lkge_flag                    = s.wms_cont_rev_lkge_flag,
        cont_rev_lkge_triggering_no           = s.wms_cont_rev_lkge_triggering_no,
        cont_rev_lkge_triggering_type         = s.wms_cont_rev_lkge_triggering_type,
        cont_rev_lkge_Tariffid                = s.wms_cont_rev_lkge_Tariffid,
        cont_rev_lkge_triggering_date         = s.wms_cont_rev_lkge_triggering_date,
        cont_rev_lkge_doc_date                = s.wms_cont_rev_lkge_doc_date,
        cont_rev_lkge_location                = s.wms_cont_rev_lkge_location,
        cont_rev_lkge_supplier                = s.wms_cont_rev_lkge_supplier,
        cont_rev_lkge_remarks                 = s.wms_cont_rev_lkge_remarks,
        cont_rev_lkge_revenue_leakage         = s.wms_cont_rev_lkge_revenue_leakage,
        cont_rev_lkge_tariff_type             = s.wms_cont_rev_lkge_tariff_type,
        cont_rev_lkge_booking_location        = s.wms_cont_rev_lkge_booking_location,
        cont_rev_lkge_reason                  = s.wms_cont_rev_lkge_reason,
        cont_rev_lkge_total_amount            = s.wms_cont_rev_lkge_total_amount,
        cont_rev_lkge_group_flag              = s.wms_cont_rev_lkge_group_flag,
        cont_rev_lkge_resource_type           = s.wms_cont_rev_lkge_resource_type,
        cont_rev_lkge_billable                = s.wms_cont_rev_lkge_billable,
        etlactiveind                          = 1,
        etljobname                            = p_etljobname,
        envsourcecd                           = p_envsourcecd,
        datasourcecd                          = p_datasourcecd,
        etlupdatedatetime                     = NOW()
    FROM stg.stg_wms_contract_rev_leak_dtl s
    WHERE t.cont_rev_lkge_ou				= s.wms_cont_rev_lkge_ou
    AND t.cont_rev_lkge_line_no				= s.wms_cont_rev_lkge_line_no;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.f_contractRevLeakDetail
    (
        cont_rev_lkge_contid, cont_rev_lkge_ou, cont_rev_lkge_line_no, cont_rev_lkge_doc_type, cont_rev_lkge_doc_no, cont_rev_lkge_cust_id,
		cont_rev_lkge_revenue, cont_rev_lkge_created_by, cont_rev_lkge_created_date, cont_rev_lkge_modified_by, cont_rev_lkge_modified_date,
		cont_rev_lkge_timestamp, cont_rev_lkge_flag, cont_rev_lkge_triggering_no, cont_rev_lkge_triggering_type, cont_rev_lkge_Tariffid, 
		cont_rev_lkge_triggering_date, cont_rev_lkge_doc_date, cont_rev_lkge_location, cont_rev_lkge_supplier, cont_rev_lkge_remarks, 
		cont_rev_lkge_revenue_leakage, cont_rev_lkge_tariff_type, cont_rev_lkge_booking_location, cont_rev_lkge_reason, 
		cont_rev_lkge_total_amount, cont_rev_lkge_group_flag, cont_rev_lkge_resource_type, cont_rev_lkge_billable, etlactiveind, 
		etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        s.wms_cont_rev_lkge_contid, s.wms_cont_rev_lkge_ou, s.wms_cont_rev_lkge_line_no, s.wms_cont_rev_lkge_doc_type, s.wms_cont_rev_lkge_doc_no, s.wms_cont_rev_lkge_cust_id, 
		s.wms_cont_rev_lkge_revenue, s.wms_cont_rev_lkge_created_by, s.wms_cont_rev_lkge_created_date, s.wms_cont_rev_lkge_modified_by, s.wms_cont_rev_lkge_modified_date,
		s.wms_cont_rev_lkge_timestamp, s.wms_cont_rev_lkge_flag, s.wms_cont_rev_lkge_triggering_no, s.wms_cont_rev_lkge_triggering_type, s.wms_cont_rev_lkge_Tariffid,
		s.wms_cont_rev_lkge_triggering_date, s.wms_cont_rev_lkge_doc_date, s.wms_cont_rev_lkge_location, s.wms_cont_rev_lkge_supplier, s.wms_cont_rev_lkge_remarks, 
		s.wms_cont_rev_lkge_revenue_leakage, s.wms_cont_rev_lkge_tariff_type, s.wms_cont_rev_lkge_booking_location, s.wms_cont_rev_lkge_reason, 
		s.wms_cont_rev_lkge_total_amount, s.wms_cont_rev_lkge_group_flag, s.wms_cont_rev_lkge_resource_type, s.wms_cont_rev_lkge_billable, 1,
		p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_wms_contract_rev_leak_dtl s
    LEFT JOIN dwh.f_contractRevLeakDetail t
    ON		s.wms_cont_rev_lkge_ou		= t.cont_rev_lkge_ou
    AND		s.wms_cont_rev_lkge_line_no = t.cont_rev_lkge_line_no
    WHERE	t.cont_rev_lkge_ou IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_wms_contract_rev_leak_dtl
    (
        wms_cont_rev_lkge_contid, wms_cont_rev_lkge_ou, wms_cont_rev_lkge_line_no, wms_cont_rev_lkge_doc_type, wms_cont_rev_lkge_doc_no, 
		wms_cont_rev_lkge_cust_id, wms_cont_rev_lkge_revenue, wms_cont_rev_lkge_created_by, wms_cont_rev_lkge_created_date, 
		wms_cont_rev_lkge_modified_by, wms_cont_rev_lkge_modified_date, wms_cont_rev_lkge_timestamp, wms_cont_rev_lkge_flag, 
		wms_cont_rev_lkge_triggering_no, wms_cont_rev_lkge_triggering_type, wms_cont_rev_lkge_Tariffid, wms_cont_rev_lkge_triggering_date, 
		wms_cont_rev_lkge_doc_date, wms_cont_rev_lkge_location, wms_cont_rev_lkge_supplier, wms_cont_rev_lkge_remarks, 
		wms_cont_rev_lkge_revenue_leakage, wms_cont_rev_lkge_tariff_type, wms_cont_rev_lkge_booking_location, wms_cont_rev_lkge_reason, 
		wms_cont_rev_lkge_total_amount, wms_cont_rev_lkge_group_flag, wms_cont_rev_lkge_resource_type, wms_cont_rev_lkge_billable, 
		etlcreateddatetime
    )
    SELECT
        wms_cont_rev_lkge_contid, wms_cont_rev_lkge_ou, wms_cont_rev_lkge_line_no, wms_cont_rev_lkge_doc_type, wms_cont_rev_lkge_doc_no,
		wms_cont_rev_lkge_cust_id, wms_cont_rev_lkge_revenue, wms_cont_rev_lkge_created_by, wms_cont_rev_lkge_created_date, 
		wms_cont_rev_lkge_modified_by, wms_cont_rev_lkge_modified_date, wms_cont_rev_lkge_timestamp, wms_cont_rev_lkge_flag, 
		wms_cont_rev_lkge_triggering_no, wms_cont_rev_lkge_triggering_type, wms_cont_rev_lkge_Tariffid, wms_cont_rev_lkge_triggering_date,
		wms_cont_rev_lkge_doc_date, wms_cont_rev_lkge_location, wms_cont_rev_lkge_supplier, wms_cont_rev_lkge_remarks, 
		wms_cont_rev_lkge_revenue_leakage, wms_cont_rev_lkge_tariff_type, wms_cont_rev_lkge_booking_location, wms_cont_rev_lkge_reason, 
		wms_cont_rev_lkge_total_amount, wms_cont_rev_lkge_group_flag, wms_cont_rev_lkge_resource_type, wms_cont_rev_lkge_billable, etlcreateddatetime
    FROM stg.stg_wms_contract_rev_leak_dtl;
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