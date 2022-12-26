CREATE OR REPLACE PROCEDURE dwh.usp_f_cdcnarpostingsdtl(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
    FROM stg.stg_cdcn_ar_postings_dtl;

    UPDATE dwh.F_cdcnarpostingsdtl t
    SET
    
        cdcnarpostingsdtl_customer_key= COALESCE(cs.customer_key,-1),
        tran_type                = s.tran_type,
        tran_ou                  = s.tran_ou,
        tran_no                  = s.tran_no,
        posting_line_no          = s.posting_line_no,
        ctimestamp               = s.ctimestamp,
        line_no                  = s.line_no,
        company_code             = s.company_code,
        posting_status           = s.posting_status,
        posting_date             = s.posting_date,
        fb_id                    = s.fb_id,
        tran_date                = s.tran_date,
        account_type             = s.account_type,
        account_code             = s.account_code,
        drcr_id                  = s.drcr_id,
        tran_currency            = s.tran_currency,
        tran_amount              = s.tran_amount,
        exchange_rate            = s.exchange_rate,
        base_amount              = s.base_amount,
        par_exchange_rate        = s.par_exchange_rate,
        par_base_amount          = s.par_base_amount,
        cost_center              = s.cost_center,
        guid                     = s.guid,
        cust_code                = s.cust_code,
        entry_date               = s.entry_date,
        auth_date                = s.auth_date,
        item_code                = s.item_code,
        item_variant             = s.item_variant,
        quantity                 = s.quantity,
        reftran_fbid             = s.reftran_fbid,
        reftran_no               = s.reftran_no,
        reftran_ou               = s.reftran_ou,
        ref_tran_type            = s.ref_tran_type,
        source_comp              = s.source_comp,
        hdrremarks               = s.hdrremarks,
        mlremarks                = s.mlremarks,
        item_tcd_type            = s.item_tcd_type,
        etlactiveind             = 1,
        etljobname               = p_etljobname,
        envsourcecd              = p_envsourcecd,
        datasourcecd             = p_datasourcecd,
        etlupdatedatetime        = NOW()
    FROM stg.stg_cdcn_ar_postings_dtl s
    LEFT JOIN dwh.d_customer cs
		ON  s.cust_code			= cs.customer_id	
		AND s.tran_ou			= cs.customer_ou
    WHERE t.tran_type = s.tran_type
    AND t.tran_ou = s.tran_ou
    AND t.tran_no = s.tran_no
    AND t.posting_line_no = s.posting_line_no
    AND t.ctimestamp = s.ctimestamp;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_cdcnarpostingsdtl
    (
        cdcnarpostingsdtl_customer_key,tran_type, tran_ou, tran_no, posting_line_no, ctimestamp, line_no, company_code, posting_status, posting_date, fb_id, tran_date, account_type, account_code, drcr_id, tran_currency, tran_amount, exchange_rate, base_amount, par_exchange_rate, par_base_amount, cost_center, guid, cust_code, entry_date, auth_date, item_code, item_variant, quantity, reftran_fbid, reftran_no, reftran_ou, ref_tran_type, source_comp, hdrremarks, mlremarks, item_tcd_type, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        COALESCE(cs.customer_key,-1),s.tran_type, s.tran_ou, s.tran_no, s.posting_line_no, s.ctimestamp, s.line_no, s.company_code, s.posting_status, s.posting_date, s.fb_id, s.tran_date, s.account_type, s.account_code, s.drcr_id, s.tran_currency, s.tran_amount, s.exchange_rate, s.base_amount, s.par_exchange_rate, s.par_base_amount, s.cost_center, s.guid, s.cust_code, s.entry_date, s.auth_date, s.item_code, s.item_variant, s.quantity, s.reftran_fbid, s.reftran_no, s.reftran_ou, s.ref_tran_type, s.source_comp, s.hdrremarks, s.mlremarks, s.item_tcd_type, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_cdcn_ar_postings_dtl s
    LEFT JOIN dwh.d_customer cs
		ON  s.cust_code			= cs.customer_id	
		AND s.tran_ou			= cs.customer_ou
    LEFT JOIN dwh.F_cdcnarpostingsdtl t
    ON s.tran_type = t.tran_type
    AND s.tran_ou = t.tran_ou
    AND s.tran_no = t.tran_no
    AND s.posting_line_no = t.posting_line_no
    AND s.ctimestamp = t.ctimestamp
    WHERE t.tran_type IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_cdcn_ar_postings_dtl
    (
        tran_type, tran_ou, tran_no, posting_line_no, ctimestamp, line_no, company_code, posting_status, posting_date, fb_id, tran_date, account_type, account_code, drcr_id, tran_currency, tran_amount, exchange_rate, base_amount, par_exchange_rate, par_base_amount, cost_center, analysis_code, subanalysis_code, guid, createdby, createddate, modifiedby, modifieddate, cust_code, entry_date, auth_date, item_code, item_variant, quantity, reftran_fbid, reftran_no, reftran_ou, ref_tran_type, uom, org_vat_base_amt, vat_line_no, source_comp, hdrremarks, mlremarks, item_tcd_type, address_id, etlcreateddatetime
    )
    SELECT
        tran_type, tran_ou, tran_no, posting_line_no, ctimestamp, line_no, company_code, posting_status, posting_date, fb_id, tran_date, account_type, account_code, drcr_id, tran_currency, tran_amount, exchange_rate, base_amount, par_exchange_rate, par_base_amount, cost_center, analysis_code, subanalysis_code, guid, createdby, createddate, modifiedby, modifieddate, cust_code, entry_date, auth_date, item_code, item_variant, quantity, reftran_fbid, reftran_no, reftran_ou, ref_tran_type, uom, org_vat_base_amt, vat_line_no, source_comp, hdrremarks, mlremarks, item_tcd_type, address_id, etlcreateddatetime
    FROM stg.stg_cdcn_ar_postings_dtl;
    
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