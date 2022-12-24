CREATE OR REPLACE PROCEDURE dwh.usp_f_draftbillheader(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
        FROM stg.stg_wms_draft_bill_hdr;

        UPDATE dwh.F_DraftBillHeader t
        SET

        draft_loc_key                      = COALESCE(l.loc_key,-1),
        draft_cust_key                     = COALESCE(a.customer_key,-1),
        draft_curr_key                     = COALESCE(c.curr_key,-1),
        draft_bill_location                 = s.wms_draft_bill_location,
        draft_bill_division                 = s.wms_draft_bill_division,
        draft_bill_date                     = s.wms_draft_bill_date,
        draft_bill_status                   = s.wms_draft_bill_status,
        draft_bill_contract_id              = s.wms_draft_bill_contract_id,
        draft_bill_cust_cont_ref_no         = s.wms_draft_bill_cust_cont_ref_no,
        draft_bill_customer                 = s.wms_draft_bill_customer,
        draft_bill_supplier                 = s.wms_draft_bill_supplier,
        draft_bill_currency                 = s.wms_draft_bill_currency,
        draft_bill_cost_centre              = s.wms_draft_bill_cost_centre,
        draft_bill_value                    = s.wms_draft_bill_value,
        draft_bill_discount                 = s.wms_draft_bill_discount,
        draft_bill_total_value              = s.wms_draft_bill_total_value,
        draft_bill_inv_no                   = s.wms_draft_bill_inv_no,
        draft_bill_inv_date                 = s.wms_draft_bill_inv_date,
        draft_bill_inv_status               = s.wms_draft_bill_inv_status,
        draft_bill_timestamp                = s.wms_draft_bill_timestamp,
        draft_bill_created_by               = s.wms_draft_bill_created_by,
        draft_bill_created_date             = s.wms_draft_bill_created_date,
        draft_bill_modified_by              = s.wms_draft_bill_modified_by,
        draft_bill_modified_date            = s.wms_draft_bill_modified_date,
        draft_bill_contract_amend_no        = s.wms_draft_bill_contract_amend_no,
        draft_bill_tran_type                = s.wms_draft_bill_tran_type,
        draft_bill_margin                   = s.wms_draft_bill_margin,
        draft_bill_gen_from                 = s.wms_draft_bill_gen_from,
        draft_bill_booking_location         = s.wms_draft_bill_booking_location,
        draft_bill_period_from              = s.wms_draft_bill_period_from,
        draft_bill_period_to                = s.wms_draft_bill_period_to,
        draft_bill_remarks                  = s.wms_draft_bill_remarks,
        draft_bill_workflow_status          = s.wms_draft_bill_workflow_status,
        draft_bill_reason_for_return        = s.wms_draft_bill_reason_for_return,
        draft_bill_grp                      = s.wms_draft_bill_grp,
        draft_bill_type                     = s.wms_draft_bill_type,
        draft_bill_br_remittance_YN         = s.wms_draft_bill_br_remittance_YN,
        etlactiveind                        = 1,
        etljobname                          = p_etljobname,
        envsourcecd                         = p_envsourcecd,
        datasourcecd                        = p_datasourcecd,
        etlupdatedatetime                   = NOW()
        FROM stg.stg_wms_draft_bill_hdr s

        LEFT JOIN dwh.d_location L      
            ON s.wms_draft_bill_location           = L.loc_code 
            AND s.wms_draft_bill_ou                = L.loc_ou


        LEFT JOIN dwh.d_customer A      
        ON s.wms_draft_bill_customer  = A.customer_id 
        AND s.wms_draft_bill_ou        = A.customer_ou

        LEFT JOIN dwh.d_currency c      
        ON  s.wms_draft_bill_currency       = c.iso_curr_code 

        WHERE t.draft_bill_no = s.wms_draft_bill_no
    AND t.draft_bill_ou = s.wms_draft_bill_ou;

        GET DIAGNOSTICS updcnt = ROW_COUNT;

        INSERT INTO dwh.F_DraftBillHeader
        (
           draft_loc_key , draft_cust_key, draft_curr_key , draft_bill_no, draft_bill_ou, draft_bill_location, draft_bill_division, draft_bill_date, draft_bill_status, draft_bill_contract_id, draft_bill_cust_cont_ref_no, draft_bill_customer, draft_bill_supplier, draft_bill_currency, draft_bill_cost_centre, draft_bill_value, draft_bill_discount, draft_bill_total_value, draft_bill_inv_no, draft_bill_inv_date, draft_bill_inv_status, draft_bill_timestamp, draft_bill_created_by, draft_bill_created_date, draft_bill_modified_by, draft_bill_modified_date, draft_bill_contract_amend_no, draft_bill_tran_type, draft_bill_margin, draft_bill_gen_from, draft_bill_booking_location, draft_bill_period_from, draft_bill_period_to, draft_bill_remarks, draft_bill_workflow_status, draft_bill_reason_for_return, draft_bill_grp, draft_bill_type, draft_bill_br_remittance_YN, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
        )

        SELECT
           COALESCE(l.loc_key,-1),COALESCE(a.customer_key,-1),COALESCE(c.curr_key,-1),s.wms_draft_bill_no, s.wms_draft_bill_ou, s.wms_draft_bill_location, s.wms_draft_bill_division, s.wms_draft_bill_date, s.wms_draft_bill_status, s.wms_draft_bill_contract_id, s.wms_draft_bill_cust_cont_ref_no, s.wms_draft_bill_customer, s.wms_draft_bill_supplier, s.wms_draft_bill_currency, s.wms_draft_bill_cost_centre, s.wms_draft_bill_value, s.wms_draft_bill_discount, s.wms_draft_bill_total_value, s.wms_draft_bill_inv_no, s.wms_draft_bill_inv_date, s.wms_draft_bill_inv_status, s.wms_draft_bill_timestamp, s.wms_draft_bill_created_by, s.wms_draft_bill_created_date, s.wms_draft_bill_modified_by, s.wms_draft_bill_modified_date, s.wms_draft_bill_contract_amend_no, s.wms_draft_bill_tran_type, s.wms_draft_bill_margin, s.wms_draft_bill_gen_from, s.wms_draft_bill_booking_location, s.wms_draft_bill_period_from, s.wms_draft_bill_period_to, s.wms_draft_bill_remarks, s.wms_draft_bill_workflow_status, s.wms_draft_bill_reason_for_return, s.wms_draft_bill_grp, s.wms_draft_bill_type, s.wms_draft_bill_br_remittance_YN, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
        FROM stg.stg_wms_draft_bill_hdr s

         LEFT JOIN dwh.d_location L      
         ON s.wms_draft_bill_location           = L.loc_code 
         AND s.wms_draft_bill_ou                = L.loc_ou

      
        LEFT JOIN dwh.d_customer A      
        ON s.wms_draft_bill_customer  = A.customer_id 
        AND s.wms_draft_bill_ou        = A.customer_ou

        LEFT JOIN dwh.d_currency c      
        ON  s.wms_draft_bill_currency       = c.iso_curr_code 

        LEFT JOIN dwh.F_DraftBillHeader t
        ON s.wms_draft_bill_no = t.draft_bill_no
        AND s.wms_draft_bill_ou = t.draft_bill_ou
        WHERE t.draft_bill_no IS NULL;

        GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN

        INSERT INTO raw.raw_wms_draft_bill_hdr
        (
            wms_draft_bill_no, wms_draft_bill_ou, wms_draft_bill_location, wms_draft_bill_division, wms_draft_bill_date, wms_draft_bill_status, wms_draft_bill_contract_id, wms_draft_bill_cust_cont_ref_no, wms_draft_bill_customer, wms_draft_bill_supplier, wms_draft_bill_currency, wms_draft_bill_cost_centre, wms_draft_bill_value, wms_draft_bill_discount, wms_draft_bill_total_value, wms_draft_bill_inv_no, wms_draft_bill_inv_date, wms_draft_bill_inv_status, wms_draft_bill_timestamp, wms_draft_bill_created_by, wms_draft_bill_created_date, wms_draft_bill_modified_by, wms_draft_bill_modified_date, wms_draft_bill_contract_amend_no, wms_draft_bill_tran_type, wms_draft_bill_margin, wms_draft_bill_gen_from, wms_draft_bill_booking_location, wms_draft_bill_period_from, wms_draft_bill_period_to, wms_draft_bill_remarks, wms_draft_bill_workflow_status, wms_draft_bill_reason_for_return, wms_draft_bill_grp, wms_draft_bill_type, wms_draft_bill_br_remittance_YN, etlcreateddatetime
        )
        SELECT
            wms_draft_bill_no, wms_draft_bill_ou, wms_draft_bill_location, wms_draft_bill_division, wms_draft_bill_date, wms_draft_bill_status, wms_draft_bill_contract_id, wms_draft_bill_cust_cont_ref_no, wms_draft_bill_customer, wms_draft_bill_supplier, wms_draft_bill_currency, wms_draft_bill_cost_centre, wms_draft_bill_value, wms_draft_bill_discount, wms_draft_bill_total_value, wms_draft_bill_inv_no, wms_draft_bill_inv_date, wms_draft_bill_inv_status, wms_draft_bill_timestamp, wms_draft_bill_created_by, wms_draft_bill_created_date, wms_draft_bill_modified_by, wms_draft_bill_modified_date, wms_draft_bill_contract_amend_no, wms_draft_bill_tran_type, wms_draft_bill_margin, wms_draft_bill_gen_from, wms_draft_bill_booking_location, wms_draft_bill_period_from, wms_draft_bill_period_to, wms_draft_bill_remarks, wms_draft_bill_workflow_status, wms_draft_bill_reason_for_return, wms_draft_bill_grp, wms_draft_bill_type, wms_draft_bill_br_remittance_YN, etlcreateddatetime
        FROM stg.stg_wms_draft_bill_hdr;
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