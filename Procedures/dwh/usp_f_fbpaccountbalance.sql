CREATE PROCEDURE dwh.usp_f_fbpaccountbalance(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
    FROM stg.stg_fbp_account_balance;

    UPDATE dwh.F_fbpaccountbalance t
    SET
        fbp_act_curr_key     = COALESCE(c.curr_key,-1),
   
        timestamp            = s.timestamp,
        ob_credit            = s.ob_credit,
        ob_debit             = s.ob_debit,
        period_credit        = s.period_credit,
        period_debit         = s.period_debit,
        cb_credit            = s.cb_credit,
        cb_debit             = s.cb_debit,
        recon_status         = s.recon_status,
        createdby            = s.createdby,
        createddate          = s.createddate,
        modifiedby           = s.modifiedby,
        modifieddate         = s.modifieddate,
        ari_upd_flag         = s.ari_upd_flag,
        etlactiveind         = 1,
        etljobname           = p_etljobname,
        envsourcecd          = p_envsourcecd,
        datasourcecd         = p_datasourcecd,
        etlupdatedatetime    = NOW()
    FROM stg.stg_fbp_account_balance s
       LEFT JOIN dwh.d_currency c      
    ON  s.currency_code          = c.iso_curr_code  
    WHERE t.ou_id = s.ou_id
    AND t.company_code = s.company_code
    AND t.fb_id = s.fb_id
    AND t.fin_year = s.fin_year
    AND t.fin_period = s.fin_period
    AND t.account_code = s.account_code
    AND t.currency_code = s.currency_code;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_fbpaccountbalance
    (
        fbp_act_curr_key,ou_id, company_code, fb_id, fin_year, fin_period, account_code, currency_code, timestamp, ob_credit, ob_debit, period_credit, period_debit, cb_credit, cb_debit, recon_status, createdby, createddate, modifiedby, modifieddate, ari_upd_flag, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        COALESCE(c.curr_key,-1), s.ou_id, s.company_code, s.fb_id, s.fin_year, s.fin_period, s.account_code, s.currency_code, s.timestamp, s.ob_credit, s.ob_debit, s.period_credit, s.period_debit, s.cb_credit, s.cb_debit, s.recon_status, s.createdby, s.createddate, s.modifiedby, s.modifieddate, s.ari_upd_flag, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_fbp_account_balance s
       LEFT JOIN dwh.d_currency c      
    ON  s.currency_code          = c.iso_curr_code  
    LEFT JOIN dwh.F_fbpaccountbalance t
    ON s.ou_id = t.ou_id
    AND s.company_code = t.company_code
    AND s.fb_id = t.fb_id
    AND s.fin_year = t.fin_year
    AND s.fin_period = t.fin_period
    AND s.account_code = t.account_code
    AND s.currency_code = t.currency_code
    WHERE t.ou_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_fbp_account_balance
    (
        ou_id, company_code, fb_id, fin_year, fin_period, account_code, currency_code, timestamp, ob_credit, ob_debit, period_credit, period_debit, cb_credit, cb_debit, recon_status, createdby, createddate, modifiedby, modifieddate, ari_upd_flag, etlcreateddatetime
    )
    SELECT
        ou_id, company_code, fb_id, fin_year, fin_period, account_code, currency_code, timestamp, ob_credit, ob_debit, period_credit, period_debit, cb_credit, cb_debit, recon_status, createdby, createddate, modifiedby, modifieddate, ari_upd_flag, etlcreateddatetime
    FROM stg.stg_fbp_account_balance;
    
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