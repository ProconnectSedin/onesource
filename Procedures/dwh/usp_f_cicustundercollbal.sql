-- PROCEDURE: dwh.usp_f_cicustundercollbal(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_cicustundercollbal(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_cicustundercollbal(
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
    FROM stg.stg_ci_cust_undercoll_bal;

    UPDATE dwh.F_cicustundercollbal t
    SET
		company_key					= COALESCE(co.company_key,-1),
		customer_key				= COALESCE(cu.customer_key,-1),
		curr_key					= COALESCE(curr.curr_key,-1),
        lo_id                       = s.lo_id,
        bu_id                       = s.bu_id,
        ou_id                       = s.ou_id,
        fb_id                       = s.fb_id,
        company_code                = s.company_code,
        cust_code                   = s.cust_code,
        base_currency_code          = s.base_currency_code,
        balance_type                = s.balance_type,
        par_currency_code           = s.par_currency_code,
        timestamp                   = s.timestamp,
        deposit_amount              = s.deposit_amount,
        realized_amount             = s.realized_amount,
        undercoll_amount            = s.undercoll_amount,
        par_deposit_amount          = s.par_deposit_amount,
        par_undercoll_amount        = s.par_undercoll_amount,
        par_realized_amount         = s.par_realized_amount,
        createdby                   = s.createdby,
        createddate                 = s.createddate,
        modifiedby                  = s.modifiedby,
        modifieddate                = s.modifieddate,
        etlactiveind                = 1,
        etljobname                  = p_etljobname,
        envsourcecd                 = p_envsourcecd,
        datasourcecd                = p_datasourcecd,
        etlupdatedatetime           = NOW()
    FROM stg.stg_ci_cust_undercoll_bal s
	LEFT JOIN dwh.d_company co
	ON co.company_code = s.company_code
	LEFT JOIN dwh.d_customer cu
	ON cu.customer_id = s.cust_code
	AND cu.customer_ou = s.ou_id
	LEFT JOIN dwh.d_currency curr
	ON curr.iso_curr_code = s.base_currency_code
    WHERE t.lo_id = s.lo_id
    AND t.bu_id = s.bu_id
    AND t.ou_id = s.ou_id
    AND t.fb_id = s.fb_id
    AND t.company_code = s.company_code
    AND t.cust_code = s.cust_code;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_cicustundercollbal
    (
		company_key, customer_key, curr_key, 
		lo_id, bu_id, ou_id, fb_id, company_code, 
		cust_code, base_currency_code, balance_type, par_currency_code, timestamp, 
		deposit_amount, realized_amount, undercoll_amount, par_deposit_amount, par_undercoll_amount,
		par_realized_amount, createdby, createddate, modifiedby, modifieddate, 
		etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
		COALESCE(co.company_key,-1), COALESCE(cu.customer_key,-1), COALESCE(curr.curr_key,-1), 
		s.lo_id					, s.bu_id				, s.ou_id				, s.fb_id				, s.company_code, 
		s.cust_code				, s.base_currency_code	, s.balance_type		, s.par_currency_code	, s.timestamp, 
		s.deposit_amount		, s.realized_amount		, s.undercoll_amount	, s.par_deposit_amount	, s.par_undercoll_amount,
		s.par_realized_amount	, s.createdby			, s.createddate			, s.modifiedby			, s.modifieddate,
					1			, p_etljobname			, p_envsourcecd			, p_datasourcecd		, NOW()
    FROM stg.stg_ci_cust_undercoll_bal s
	LEFT JOIN dwh.d_company co
	ON co.company_code = s.company_code
	LEFT JOIN dwh.d_customer cu
	ON cu.customer_id = s.cust_code
	AND cu.customer_ou = s.ou_id
	LEFT JOIN dwh.d_currency curr
	ON curr.iso_curr_code = s.base_currency_code
    LEFT JOIN dwh.F_cicustundercollbal t
    ON s.lo_id = t.lo_id
    AND s.bu_id = t.bu_id
    AND s.ou_id = t.ou_id
    AND s.fb_id = t.fb_id
    AND s.company_code = t.company_code
    AND s.cust_code = t.cust_code
    WHERE t.lo_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_ci_cust_undercoll_bal
    (
        lo_id, bu_id, ou_id, fb_id, company_code, cust_code, base_currency_code, balance_type, par_currency_code, timestamp, deposit_amount, realized_amount, undercoll_amount, par_deposit_amount, par_undercoll_amount, par_realized_amount, createdby, createddate, modifiedby, modifieddate, etlcreateddatetime
    )
    SELECT
        lo_id, bu_id, ou_id, fb_id, company_code, cust_code, base_currency_code, balance_type, par_currency_code, timestamp, deposit_amount, realized_amount, undercoll_amount, par_deposit_amount, par_undercoll_amount, par_realized_amount, createdby, createddate, modifiedby, modifieddate, etlcreateddatetime
    FROM stg.stg_ci_cust_undercoll_bal;
    
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
ALTER PROCEDURE dwh.usp_f_cicustundercollbal(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
