-- PROCEDURE: dwh.usp_f_fbpibetrndtl(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_fbpibetrndtl(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_fbpibetrndtl(
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
    FROM stg.stg_fbp_ibe_trn_dtl;

    UPDATE dwh.F_fbpibetrndtl t
    SET
		accountcode_key		 = COALESCE(op.opcoa_key, -1),
		currencycode_key	 = COALESCE(cu.curr_key, -1),
		companycode_key		 = COALESCE(cp.company_key, -1),
        ou_id                = s.ou_id,
        fb_id                = s.fb_id,
        fin_year             = s.fin_year,
        fin_period           = s.fin_period,
        account_code         = s.account_code,
        currency_code        = s.currency_code,
        timestamp            = s.timestamp,
        drcr_flag            = s.drcr_flag,
        base_amount          = s.base_amount,
        tran_amount          = s.tran_amount,
        batch_id             = s.batch_id,
        document_no          = s.document_no,
        createdby            = s.createdby,
        createddate          = s.createddate,
        modifieddate         = s.modifieddate,
        company_code         = s.company_code,
        etlactiveind         = 1,
        etljobname           = p_etljobname,
        envsourcecd          = p_envsourcecd,
        datasourcecd         = p_datasourcecd,
        etlupdatedatetime    = NOW()
    FROM stg.stg_fbp_ibe_trn_dtl s
	LEFT JOIN dwh.d_operationalaccountdetail op
	ON op.account_code = s.account_code
	LEFT JOIN dwh.d_currency cu
	ON cu.iso_curr_code = s.currency_code
	AND cu.ctimestamp = s.timestamp
	LEFT JOIN dwh.d_company cp
	ON cp.company_code = s.company_code
	AND cp.ctimestamp = s.timestamp
    WHERE t.ou_id = s.ou_id
    AND t.fb_id = s.fb_id
    AND t.fin_year = s.fin_year
    AND t.fin_period = s.fin_period
    AND t.account_code = s.account_code
    AND t.currency_code = s.currency_code;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_fbpibetrndtl
    (
		accountcode_key, currencycode_key, companycode_key,
        ou_id, fb_id, fin_year, fin_period, account_code, 
		currency_code, timestamp, drcr_flag, base_amount, tran_amount, 
		batch_id, document_no, createdby, createddate, modifieddate, 
		company_code, 
		etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
		COALESCE(op.opcoa_key, -1), COALESCE(cu.curr_key, -1), COALESCE(cp.company_key, -1),
        s.ou_id			, s.fb_id		, s.fin_year	, s.fin_period		, s.account_code, 
		s.currency_code	, s.timestamp	, s.drcr_flag	, s.base_amount		, s.tran_amount, 
		s.batch_id		, s.document_no	, s.createdby	, s.createddate		, s.modifieddate, 
		s.company_code	,
				1		, p_etljobname	, p_envsourcecd	, p_datasourcecd	, NOW()
    FROM stg.stg_fbp_ibe_trn_dtl s
	LEFT JOIN dwh.d_operationalaccountdetail op
	ON op.account_code = s.account_code
	LEFT JOIN dwh.d_currency cu
	ON cu.iso_curr_code = s.currency_code
	AND cu.ctimestamp = s.timestamp
	LEFT JOIN dwh.d_company cp
	ON cp.company_code = s.company_code
	AND cp.ctimestamp = s.timestamp
    LEFT JOIN dwh.F_fbpibetrndtl t
    ON s.ou_id = t.ou_id
    AND s.fb_id = t.fb_id
    AND s.fin_year = t.fin_year
    AND s.fin_period = t.fin_period
    AND s.account_code = t.account_code
    AND s.currency_code = t.currency_code
    WHERE t.ou_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_fbp_ibe_trn_dtl
    (
        ou_id, fb_id, fin_year, fin_period, account_code, currency_code, timestamp, drcr_flag, base_amount, tran_amount, batch_id, document_no, tran_type, tran_ou, createdby, createddate, modifiedby, modifieddate, par_base_amount, company_code, etlcreateddatetime
    )
    SELECT
        ou_id, fb_id, fin_year, fin_period, account_code, currency_code, timestamp, drcr_flag, base_amount, tran_amount, batch_id, document_no, tran_type, tran_ou, createdby, createddate, modifiedby, modifieddate, par_base_amount, company_code, etlcreateddatetime
    FROM stg.stg_fbp_ibe_trn_dtl;
    
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
ALTER PROCEDURE dwh.usp_f_fbpibetrndtl(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
