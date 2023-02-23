-- PROCEDURE: dwh.usp_f_sisupplierbalance(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_sisupplierbalance(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_sisupplierbalance(
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
    FROM stg.stg_si_supplier_balance;

    UPDATE dwh.F_sisupplierbalance t
    SET
		account_code_key   		  = COALESCE(acc.opcoa_key, -1),
		comp_code_key   		  =COALESCE(co.company_key,-1),
		currency_key		   	  =COALESCE(cr.curr_key, -1),
		supp_key			      =COALESCE(v.vendor_key,-1),
        ou_id                     = s.ou_id,
        company_code              = s.company_code,
        fb_id                     = s.fb_id,
        fin_year                  = s.fin_year,
        fin_period                = s.fin_period,
        supplier_code             = s.supplier_code,
        account_code              = s.account_code,
        currency_code             = s.currency_code,
        balance_type              = s.balance_type,
        balance_currency          = s.balance_currency,
        account_type              = s.account_type,
        ob_credit                 = s.ob_credit,
        ob_debit                  = s.ob_debit,
        period_credit             = s.period_credit,
        period_debit              = s.period_debit,
        cb_credit                 = s.cb_credit,
        cb_debit                  = s.cb_debit,
        created_by                = s.created_by,
        created_date              = s.created_date,
        last_modified_by          = s.last_modified_by,
        last_modified_date        = s.last_modified_date,
        etlactiveind              = 1,
        etljobname                = p_etljobname,
        envsourcecd               = p_envsourcecd,
        datasourcecd              = p_datasourcecd,
        etlupdatedatetime         = NOW()
    FROM stg.stg_si_supplier_balance s
	LEFT JOIN dwh.d_operationalaccountdetail acc
        ON acc.account_code             = s.account_code
	LEFT JOIN dwh.d_company co     
    	ON    s.company_code                   = co.company_code 
 	LEFT JOIN dwh.d_currency cr
        ON cr.iso_curr_code             = s.currency_code
	LEFT JOIN dwh.d_vendor V                
        ON s.supplier_code  = V.vendor_id 
        AND s.ou_id        = V.vendor_ou
    WHERE t.ou_id = s.ou_id
    AND t.company_code = s.company_code
    AND t.fb_id = s.fb_id
    AND t.fin_year = s.fin_year
    AND t.fin_period = s.fin_period
    AND t.supplier_code = s.supplier_code
    AND t.account_code = s.account_code
    AND t.currency_code = s.currency_code
    AND t.balance_type = s.balance_type
    AND t.balance_currency = s.balance_currency;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_sisupplierbalance
    (
        account_code_key,comp_code_key,currency_key,supp_key,ou_id, company_code, fb_id, fin_year, fin_period, supplier_code, account_code, currency_code, balance_type, balance_currency, account_type, ob_credit, ob_debit, period_credit, period_debit, cb_credit, cb_debit, created_by, created_date, last_modified_by, last_modified_date, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
       COALESCE(acc.opcoa_key, -1),COALESCE(co.company_key,-1),COALESCE(cr.curr_key, -1),COALESCE(v.vendor_key,-1),s.ou_id, s.company_code, s.fb_id, s.fin_year, s.fin_period, s.supplier_code, s.account_code, s.currency_code, s.balance_type, s.balance_currency, s.account_type, s.ob_credit, s.ob_debit, s.period_credit, s.period_debit, s.cb_credit, s.cb_debit, s.created_by, s.created_date, s.last_modified_by, s.last_modified_date, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_si_supplier_balance s
	LEFT JOIN dwh.d_operationalaccountdetail acc
        ON acc.account_code  = s.account_code
	LEFT JOIN dwh.d_company co     
    	ON    s.company_code   = co.company_code 
 	LEFT JOIN dwh.d_currency cr
        ON cr.iso_curr_code  = s.currency_code
	LEFT JOIN dwh.d_vendor V                
        ON s.supplier_code  = V.vendor_id 
        AND s.ou_id        = V.vendor_ou
    LEFT JOIN dwh.F_sisupplierbalance t
    ON s.ou_id = t.ou_id
    AND s.company_code = t.company_code
    AND s.fb_id = t.fb_id
    AND s.fin_year = t.fin_year
    AND s.fin_period = t.fin_period
    AND s.supplier_code = t.supplier_code
    AND s.account_code = t.account_code
    AND s.currency_code = t.currency_code
    AND s.balance_type = t.balance_type
    AND s.balance_currency = t.balance_currency
    WHERE t.ou_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_si_supplier_balance
    (
        ou_id, company_code, fb_id, fin_year, fin_period, supplier_code, account_code, currency_code, balance_type, balance_currency, account_type, ob_credit, ob_debit, period_credit, period_debit, cb_credit, cb_debit, created_by, created_date, last_modified_by, last_modified_date, batch_id, createdby, createddate, modifiedby, modifieddate, etlcreateddatetime
    )
    SELECT
        ou_id, company_code, fb_id, fin_year, fin_period, supplier_code, account_code, currency_code, balance_type, balance_currency, account_type, ob_credit, ob_debit, period_credit, period_debit, cb_credit, cb_debit, created_by, created_date, last_modified_by, last_modified_date, batch_id, createdby, createddate, modifiedby, modifieddate, etlcreateddatetime
    FROM stg.stg_si_supplier_balance;
    
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
ALTER PROCEDURE dwh.usp_f_sisupplierbalance(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
