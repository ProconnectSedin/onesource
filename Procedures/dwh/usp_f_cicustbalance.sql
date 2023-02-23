-- PROCEDURE: dwh.usp_f_cicustbalance(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_cicustbalance(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_cicustbalance(
	IN p_sourceid character varying,
	IN p_dataflowflag character varying,
	IN p_targetobject character varying,
	OUT srccnt integer,
	OUT inscnt integer,
	OUT updcnt integer,
	OUT dltcount integer,
	INOUT flag1 character varying,
	OUT flag2 character varying)
LANGUAGE 'plpgsql'
AS $BODY$

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
    FROM stg.stg_ci_cust_balance;

    UPDATE dwh.f_cicustbalance t
    SET
		cicustbalance_company_key	= COALESCE(co.company_key,-1),
		cicustbalance_customer_key	= COALESCE(c.customer_key,-1),
		cicustbalance_opcoa_key		= COALESCE(ac.opcoa_key,-1),
		cicustbalance_curr_key		= COALESCE(cu.curr_key,-1),
        timestamp               = s.timestamp,
        ob_credit               = s.ob_credit,
        ob_debit                = s.ob_debit,
        period_credit           = s.period_credit,
        period_debit            = s.period_debit,
        cb_credit               = s.cb_credit,
        cb_debit                = s.cb_debit,
        createdby               = s.createdby,
        createddate             = s.createddate,
        modifiedby              = s.modifiedby,
        modifieddate            = s.modifieddate,
        account_type            = s.account_type,
        etlactiveind            = 1,
        etljobname              = p_etljobname,
        envsourcecd             = p_envsourcecd,
        datasourcecd            = p_datasourcecd,
        etlupdatedatetime       = NOW()
    FROM stg.stg_ci_cust_balance s
	LEFT JOIN dwh.d_company co     
    ON 	  s.company_code  		= co.company_code 
	LEFT JOIN dwh.d_operationalaccountdetail ac     
    ON 	  s.account_code  		= ac.account_code
	LEFT JOIN dwh.d_customer c     
    ON 	  s.ou_id 		   	    = c.customer_ou
	AND   s.cust_code			= c.customer_id
	LEFT JOIN dwh.d_currency cu     
    ON 	  s.currency_code  		= cu.iso_curr_code
    WHERE t.ou_id 				= s.ou_id
    AND   t.company_code 		= s.company_code
    AND   t.fb_id 				= s.fb_id
    AND   t.fin_year 			= s.fin_year
    AND   t.fin_period 			= s.fin_period
    AND   t.cust_code 			= s.cust_code
    AND   t.account_code 		= s.account_code
    AND   t.currency_code 		= s.currency_code
    AND   t.balance_type 		= s.balance_type
    AND   t.balance_currency 	= s.balance_currency;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.f_cicustbalance
    (
		cicustbalance_company_key,	cicustbalance_customer_key,	cicustbalance_opcoa_key,	cicustbalance_curr_key,
        ou_id, 						company_code, 				fb_id, 						fin_year, 					fin_period, 
		cust_code, 					account_code, 				currency_code, 				balance_type, 				balance_currency, 
		timestamp, 					ob_credit, 					ob_debit, 					period_credit, 				period_debit, 
		cb_credit, 					cb_debit, 					createdby, 					createddate, 				modifiedby, 
		modifieddate, 				account_type, 				etlactiveind, 				etljobname, 				envsourcecd, 
		datasourcecd, 				etlcreatedatetime
    )

    SELECT
		COALESCE(co.company_key,-1),	COALESCE(c.customer_key,-1),	COALESCE(ac.opcoa_key,-1),	COALESCE(cu.curr_key,-1),
        s.ou_id, 						s.company_code, 				s.fb_id, 					s.fin_year, 				s.fin_period, 
		s.cust_code, 					s.account_code, 				s.currency_code, 			s.balance_type, 			s.balance_currency, 
		s.timestamp, 					s.ob_credit, 					s.ob_debit, 				s.period_credit, 			s.period_debit, 
		s.cb_credit, 					s.cb_debit, 					s.createdby, 				s.createddate, 				s.modifiedby, 
		s.modifieddate, 				s.account_type, 				1, 							p_etljobname, 				p_envsourcecd, 
		p_datasourcecd, 				NOW()
    FROM stg.stg_ci_cust_balance s
	LEFT JOIN dwh.d_company co     
    ON 	  s.company_code  		= co.company_code 
	LEFT JOIN dwh.d_operationalaccountdetail ac     
    ON 	  s.account_code  		= ac.account_code
	LEFT JOIN dwh.d_customer c     
    ON 	  s.ou_id  		   	    = c.customer_ou
	AND   s.cust_code			= c.customer_id
	LEFT JOIN dwh.d_currency cu     
    ON 	  s.currency_code  		= cu.iso_curr_code
    LEFT JOIN dwh.f_cicustbalance t
    ON    t.ou_id               = s.ou_id
    AND   t.company_code 		= s.company_code
    AND   t.fb_id 				= s.fb_id
    AND   t.fin_year 			= s.fin_year
    AND   t.fin_period 			= s.fin_period
    AND   t.cust_code 			= s.cust_code
    AND   t.account_code 		= s.account_code
    AND   t.currency_code 		= s.currency_code
    AND   t.balance_type 		= s.balance_type
    AND   t.balance_currency 	= s.balance_currency
    WHERE t.ou_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_ci_cust_balance
    (
        ou_id, 				company_code, 		fb_id, 				fin_year, 			fin_period, 
		cust_code, 			account_code, 		currency_code, 		balance_type, 		balance_currency, 
		timestamp, 			ob_credit, 			ob_debit, 			period_credit, 		period_debit, 
		cb_credit, 			cb_debit, 			createdby, 			createddate, 		modifiedby, 
		modifieddate, 		batch_id, 			account_type, 		etlcreateddatetime
    )
    SELECT
        ou_id, 				company_code, 		fb_id, 				fin_year, 			fin_period, 
		cust_code, 			account_code, 		currency_code, 		balance_type, 		balance_currency, 
		timestamp, 			ob_credit, 			ob_debit, 			period_credit, 		period_debit, 
		cb_credit, 			cb_debit, 			createdby, 			createddate, 		modifiedby, 
		modifieddate, 		batch_id, 			account_type, 		etlcreateddatetime
    FROM stg.stg_ci_cust_balance;
    
    END IF;
    EXCEPTION WHEN others THEN
        get stacked diagnostics
            p_errorid   = returned_sqlstate,
            p_errordesc = message_text;
    CALL ods.usp_etlerrorinsert(p_sourceid, p_targetobject, p_dataflowflag, p_batchid,p_taskname, 'sp_ExceptionHandling', p_errorid, p_errordesc, null);
       select 0 into inscnt;
       select 0 into updcnt;
END;
$BODY$;
ALTER PROCEDURE dwh.usp_f_cicustbalance(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
