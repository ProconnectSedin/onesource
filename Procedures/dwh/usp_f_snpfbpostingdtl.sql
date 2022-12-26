CREATE OR REPLACE PROCEDURE dwh.usp_f_snpfbpostingdtl(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
    FROM stg.stg_snp_fbposting_dtl;

    UPDATE dwh.f_snpfbpostingdtl t
    SET
        company_code            = s.company_code,
        component_name          = s.component_name,
        bu_id                   = s.bu_id,
        fb_id                   = s.fb_id,
        tran_ou                 = s.tran_ou,
        tran_type               = s.tran_type,
        tran_date               = s.tran_date,
        posting_date            = s.posting_date,
        drcr_flag               = s.drcr_flag,
        currency_code           = s.currency_code,
        tran_amount             = s.tran_amount,
        base_amount             = s.base_amount,
        exchange_rate           = s.exchange_rate,
        analysis_code           = s.analysis_code,
        subanalysis_code        = s.subanalysis_code,
        cost_center             = s.cost_center,
        mac_post_flag           = s.mac_post_flag,
        acct_type               = s.acct_type,
        createdby               = s.createdby,
        createddate             = s.createddate,
        modifieddate            = s.modifieddate,
        posting_flag            = s.posting_flag,
        hdrremarks              = s.hdrremarks,
        mlremarks               = s.mlremarks,
        tranline_no             = s.tranline_no,
        reftran_no              = s.reftran_no,
        reftran_ou              = s.reftran_ou,
        reftran_type            = s.reftran_type,
        reftran_fbid            = s.reftran_fbid,
        etlactiveind            = 1,
        etljobname              = p_etljobname,
        envsourcecd             = p_envsourcecd,
        datasourcecd            = p_datasourcecd,
        etlupdatedatetime       = NOW()
    FROM stg.stg_snp_fbposting_dtl s
    WHERE t.batch_id = s.batch_id
    AND t.ou_id = s.ou_id
    AND t.document_no = s.document_no
    AND t.account_lineno = s.account_lineno
    AND t.account_code = s.account_code
    AND t.timestamp = s.timestamp;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.f_snpfbpostingdtl
    (
        batch_id, ou_id, document_no, account_lineno, account_code, timestamp, company_code, component_name, bu_id, fb_id, tran_ou, tran_type, tran_date, posting_date, drcr_flag, currency_code, tran_amount, base_amount, exchange_rate, analysis_code, subanalysis_code, cost_center, mac_post_flag, acct_type, createdby, createddate, modifieddate, posting_flag, hdrremarks, mlremarks, tranline_no, reftran_no, reftran_ou, reftran_type, reftran_fbid, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        s.batch_id, s.ou_id, s.document_no, s.account_lineno, s.account_code, s.timestamp, s.company_code, s.component_name, s.bu_id, s.fb_id, s.tran_ou, s.tran_type, s.tran_date, s.posting_date, s.drcr_flag, s.currency_code, s.tran_amount, s.base_amount, s.exchange_rate, s.analysis_code, s.subanalysis_code, s.cost_center, s.mac_post_flag, s.acct_type, s.createdby, s.createddate, s.modifieddate, s.posting_flag, s.hdrremarks, s.mlremarks, s.tranline_no, s.reftran_no, s.reftran_ou, s.reftran_type, s.reftran_fbid, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_snp_fbposting_dtl s
    LEFT JOIN dwh.f_snpfbpostingdtl t
    ON s.batch_id = t.batch_id
    AND s.ou_id = t.ou_id
    AND s.document_no = t.document_no
    AND s.account_lineno = t.account_lineno
    AND s.account_code = t.account_code
    AND s.timestamp = t.timestamp
    WHERE t.batch_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_snp_fbposting_dtl
    (
        batch_id, ou_id, document_no, account_lineno, account_code, timestamp, company_code, component_name, bu_id, fb_id, tran_ou, tran_type, tran_date, posting_date, drcr_flag, currency_code, tran_amount, base_amount, exchange_rate, par_base_amount, par_exchange_rate, analysis_code, subanalysis_code, cost_center, mac_post_flag, acct_type, createdby, createddate, modifiedby, modifieddate, posting_flag, hdrremarks, mlremarks, tranline_no, reftran_no, reftran_ou, reftran_type, reftran_fbid, etlcreateddatetime
    )
    SELECT
        batch_id, ou_id, document_no, account_lineno, account_code, timestamp, company_code, component_name, bu_id, fb_id, tran_ou, tran_type, tran_date, posting_date, drcr_flag, currency_code, tran_amount, base_amount, exchange_rate, par_base_amount, par_exchange_rate, analysis_code, subanalysis_code, cost_center, mac_post_flag, acct_type, createdby, createddate, modifiedby, modifieddate, posting_flag, hdrremarks, mlremarks, tranline_no, reftran_no, reftran_ou, reftran_type, reftran_fbid, etlcreateddatetime
    FROM stg.stg_snp_fbposting_dtl;
    
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