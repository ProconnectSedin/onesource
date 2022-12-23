CREATE PROCEDURE dwh.usp_f_abbaccountbudgetdtl(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
    SELECT d.jobname, h.envsourcecode, h.datasourcecode, d.latestbatchid, d.targetprocedurename,h.rawstorageflag
    INTO p_etljobname, p_envsourcecd, p_datasourcecd, p_batchid, p_taskname,p_rawstorageflag
    FROM ods.controldetail d
    INNER JOIN ods.controlheader h
        ON d.sourceid = h.sourceid
    WHERE d.sourceid = p_sourceId
        AND d.dataflowflag = p_dataflowflag
        AND d.targetobject = p_targetobject;

    SELECT COUNT(1) INTO srccnt
    FROM stg.stg_abb_account_budget_dtl;

    UPDATE dwh.F_abbaccountbudgetdtl t
    SET
        timestamp               = s.timestamp,
        control_action          = s.control_action,
        budget_amount           = s.budget_amount,
        carry_fwd_budget        = s.carry_fwd_budget,
        app_season_pat          = s.app_season_pat,
        status                  = s.status,
        account_currency        = s.account_currency,
        createdby               = s.createdby,
        createddate             = s.createddate,
        basecur_erate           = s.basecur_erate,
        budamt_base             = s.budamt_base,
        etlactiveind            = 1,
        etljobname              = p_etljobname,
        envsourcecd             = p_envsourcecd,
        datasourcecd            = p_datasourcecd,
        etlupdatedatetime       = NOW()
    FROM stg.stg_abb_account_budget_dtl s
    WHERE t.company_code = s.company_code
    AND t.fb_id = s.fb_id
    AND t.fin_year_code = s.fin_year_code
    AND t.fin_period_code = s.fin_period_code
    AND t.account_code = s.account_code;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_abbaccountbudgetdtl
    (
		company_code	, fb_id				, fin_year_code	, fin_period_code	, account_code, 
		timestamp		, control_action	, budget_amount	, carry_fwd_budget	, app_season_pat, 
		status			, account_currency	, createdby		, createddate		, basecur_erate, 
		budamt_base		, 
		etlactiveind	, etljobname		, envsourcecd	, datasourcecd		, etlcreatedatetime
    )

    SELECT
		s.company_code	, s.fb_id			, s.fin_year_code	, s.fin_period_code	, s.account_code, 
		s.timestamp		, s.control_action	, s.budget_amount	, s.carry_fwd_budget, s.app_season_pat, 
		s.status		, s.account_currency, s.createdby		, s.createddate		, s.basecur_erate, 
		s.budamt_base	, 
				1		, p_etljobname		, p_envsourcecd		, p_datasourcecd	, NOW()
    FROM stg.stg_abb_account_budget_dtl s
    LEFT JOIN dwh.F_abbaccountbudgetdtl t
    ON s.company_code = t.company_code
    AND s.fb_id = t.fb_id
    AND s.fin_year_code = t.fin_year_code
    AND s.fin_period_code = t.fin_period_code
    AND s.account_code = t.account_code
    WHERE t.company_code IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
	IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_abb_account_budget_dtl
    (
        company_code	, fb_id				, fin_year_code		, fin_period_code	, account_code, 
		timestamp		, control_action	, budget_amount		, carry_fwd_budget	, app_season_pat, 
		status			, account_currency	, createdby			, createddate		, modifiedby, 
		modifieddate	, carry_fwd_amount	, basecur_erate		, parbasecur_erate	, budamt_base, 
		budamt_parbase	, ForecastAmt		, ForecastAmt_base	, ForecastAmt_parbase, etlcreateddatetime
    )
    SELECT
        company_code	, fb_id				, fin_year_code		, fin_period_code	, account_code, 
		timestamp		, control_action	, budget_amount		, carry_fwd_budget	, app_season_pat, 
		status			, account_currency	, createdby			, createddate		, modifiedby, 
		modifieddate	, carry_fwd_amount	, basecur_erate		, parbasecur_erate	, budamt_base, 
		budamt_parbase	, ForecastAmt		, ForecastAmt_base	, ForecastAmt_parbase, etlcreateddatetime
	FROM stg.stg_abb_account_budget_dtl;
	
	END IF;

    EXCEPTION WHEN others THEN
        get stacked diagnostics
            p_errorid   = returned_sqlstate,
            p_errordesc = message_text;
    CALL ods.usp_etlerrorinsert(p_sourceid, p_targetobject, p_dataflowflag, 
								p_batchid,p_taskname, 'sp_ExceptionHandling', 
								p_errorid, p_errordesc, null);
       select 0 into inscnt;
       select 0 into updcnt;
	   
END;
$$;