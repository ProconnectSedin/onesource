CREATE PROCEDURE dwh.usp_f_surfbpostingsdtl(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
    FROM stg.stg_sur_fbpostings_dtl;

    UPDATE dwh.F_surfbpostingsdtl t
    SET
        surf_trn_curr_key        = COALESCE(c.curr_key,-1),
        surf_trn_company_key     = COALESCE(g.company_key,-1),
        acct_type                = s.acct_type,
        currency_code            = s.currency_code,
        tran_date                = s.tran_date,
        tran_amount              = s.tran_amount,
        base_amount              = s.base_amount,
        cost_center              = s.cost_center,
        analysis_code            = s.analysis_code,
        subanalysis_code         = s.subanalysis_code,
        bank_code                = s.bank_code,
        ref_doc_no               = s.ref_doc_no,
        origin_ou                = s.origin_ou,
        exchange_rate            = s.exchange_rate,
        par_exchange_rate        = s.par_exchange_rate,
        par_base_amount          = s.par_base_amount,
        ref_tran_type            = s.ref_tran_type,
        ref_fbid                 = s.ref_fbid,
        auth_date                = s.auth_date,
        post_date                = s.post_date,
        bu_id                    = s.bu_id,
        company_code             = s.company_code,
        component_name           = s.component_name,
        flag                     = s.flag,
        batch_id                 = s.batch_id,
        receipt_type             = s.receipt_type,
        createdby                = s.createdby,
        createddate              = s.createddate,
        modifiedby               = s.modifiedby,
        modifieddate             = s.modifieddate,
        source_comp              = s.source_comp,
        narration                = s.narration,
        hdrremarks               = s.hdrremarks,
        mlremarks                = s.mlremarks,
        tran_lineno              = s.tran_lineno,
        etlactiveind             = 1,
        etljobname               = p_etljobname,
        envsourcecd              = p_envsourcecd,
        datasourcecd             = p_datasourcecd,
        etlupdatedatetime        = NOW()
    FROM stg.stg_sur_fbpostings_dtl s

       LEFT JOIN dwh.d_currency c      
    ON  s.currency_code          = c.iso_curr_code  
    
     LEFT JOIN dwh.d_company g      
    ON  s.company_code          = g.company_code 

    WHERE t.ou_id = s.ou_id
    AND t.tran_type = s.tran_type
    AND t.fb_id = s.fb_id
    AND t.tran_no = s.tran_no
    AND t.account_code = s.account_code
    AND t.drcr_flag = s.drcr_flag
    AND t.acct_lineno = s.acct_lineno
    AND t.timestamp = s.timestamp;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_surfbpostingsdtl
    (
       surf_trn_curr_key ,surf_trn_company_key,ou_id, tran_type, fb_id, tran_no, account_code, drcr_flag, acct_lineno, timestamp, acct_type, currency_code, tran_date, tran_amount, base_amount, cost_center, analysis_code, subanalysis_code, bank_code, ref_doc_no, origin_ou, exchange_rate, par_exchange_rate, par_base_amount, ref_tran_type, ref_fbid, auth_date, post_date, bu_id, company_code, component_name, flag, batch_id, receipt_type, createdby, createddate, modifiedby, modifieddate, source_comp, narration, hdrremarks, mlremarks, tran_lineno, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        COALESCE(c.curr_key,-1),COALESCE(g.company_key,-1),s.ou_id, s.tran_type, s.fb_id, s.tran_no, s.account_code, s.drcr_flag, s.acct_lineno, s.timestamp, s.acct_type, s.currency_code, s.tran_date, s.tran_amount, s.base_amount, s.cost_center, s.analysis_code, s.subanalysis_code, s.bank_code, s.ref_doc_no, s.origin_ou, s.exchange_rate, s.par_exchange_rate, s.par_base_amount, s.ref_tran_type, s.ref_fbid, s.auth_date, s.post_date, s.bu_id, s.company_code, s.component_name, s.flag, s.batch_id, s.receipt_type, s.createdby, s.createddate, s.modifiedby, s.modifieddate, s.source_comp, s.narration, s.hdrremarks, s.mlremarks, s.tran_lineno, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_sur_fbpostings_dtl s

     LEFT JOIN dwh.d_currency c      
    ON  s.currency_code          = c.iso_curr_code
    
     LEFT JOIN dwh.d_company g      
    ON  s.company_code          = g.company_code

    LEFT JOIN dwh.F_surfbpostingsdtl t
    ON s.ou_id = t.ou_id
    AND s.tran_type = t.tran_type
    AND s.fb_id = t.fb_id
    AND s.tran_no = t.tran_no
    AND s.account_code = t.account_code
    AND s.drcr_flag = t.drcr_flag
    AND s.acct_lineno = t.acct_lineno
    AND s.timestamp = t.timestamp
    WHERE t.ou_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_sur_fbpostings_dtl
    (
        ou_id, tran_type, fb_id, tran_no, account_code, drcr_flag, acct_lineno, timestamp, acct_type, currency_code, declnyr_code, declnprd_code, tran_date, tran_qty, tran_amount, base_amount, cost_center, analysis_code, subanalysis_code, bank_code, ref_doc_no, vendor_code, origin_ou, item_code, vrnt_code, uom, exchange_rate, par_exchange_rate, par_base_amount, ref_tran_type, ref_fbid, auth_date, post_date, bu_id, company_code, component_name, vat_category, vat_class, vat_code, vat_rate, vat_inclusive, flag, batch_id, receipt_type, createdby, createddate, modifiedby, modifieddate, source_comp, narration, hdrremarks, mlremarks, tran_lineno, etlcreateddatetime
    )
    SELECT
        ou_id, tran_type, fb_id, tran_no, account_code, drcr_flag, acct_lineno, timestamp, acct_type, currency_code, declnyr_code, declnprd_code, tran_date, tran_qty, tran_amount, base_amount, cost_center, analysis_code, subanalysis_code, bank_code, ref_doc_no, vendor_code, origin_ou, item_code, vrnt_code, uom, exchange_rate, par_exchange_rate, par_base_amount, ref_tran_type, ref_fbid, auth_date, post_date, bu_id, company_code, component_name, vat_category, vat_class, vat_code, vat_rate, vat_inclusive, flag, batch_id, receipt_type, createdby, createddate, modifiedby, modifieddate, source_comp, narration, hdrremarks, mlremarks, tran_lineno, etlcreateddatetime
    FROM stg.stg_sur_fbpostings_dtl;
    
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