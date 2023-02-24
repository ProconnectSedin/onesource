-- PROCEDURE: dwh.usp_f_aplanbudgetdtl(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_aplanbudgetdtl(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_aplanbudgetdtl(
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
    FROM stg.stg_aplan_budget_dtl;

    UPDATE dwh.f_aplanbudgetdtl t
    SET
        timestamp                   = s.timestamp,
        amount_required             = s.amount_required,
        exchange_rate               = s.exchange_rate,
        base_amount                 = s.base_amount,
        allocated_amount            = s.allocated_amount,
        allow_variance              = s.allow_variance,
        variance_per                = s.variance_per,
        variance_amount             = s.variance_amount,
        base_alloc_amount           = s.base_alloc_amount,
        base_variance_amount        = s.base_variance_amount,
        remarks                     = s.remarks,
        utilized_amount             = s.utilized_amount,
        base_utilized_amount        = s.base_utilized_amount,
        balance_amount              = s.balance_amount,
        base_balance_amount         = s.base_balance_amount,
        createdby                   = s.createdby,
        createddate                 = s.createddate,
        modifiedby                  = s.modifiedby,
        modifieddate                = s.modifieddate,
        etlactiveind                = 1,
        etljobname                  = p_etljobname,
        envsourcecd                 = p_envsourcecd,
        datasourcecd                = p_datasourcecd,
        etlupdatedatetime           = NOW()
    FROM stg.stg_aplan_budget_dtl s
    WHERE t.ou_id 					= s.ou_id
    AND   t.fb_id 					= s.fb_id
    AND   t.asset_class_code 		= s.asset_class_code
    AND   t.financial_year 			= s.financial_year
    AND   t.currency_code 			= s.currency_code
    AND   t.budget_number 			= s.budget_number;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.f_aplanbudgetdtl
    (
        ou_id, 					fb_id, 				asset_class_code, 	financial_year, 		currency_code, 
		budget_number, 			timestamp, 			amount_required, 	exchange_rate, 			base_amount, 
		allocated_amount, 		allow_variance, 	variance_per, 		variance_amount, 		base_alloc_amount, 
		base_variance_amount, 	remarks, 			utilized_amount, 	base_utilized_amount, 	balance_amount, 
		base_balance_amount, 	createdby, 			createddate, 		modifiedby, 			modifieddate, 
		etlactiveind, 			etljobname, 		envsourcecd, 		datasourcecd, 			etlcreatedatetime
    )

    SELECT
        s.ou_id, 				s.fb_id, 			s.asset_class_code, 	s.financial_year, 		s.currency_code, 
		s.budget_number, 		s.timestamp, 		s.amount_required, 		s.exchange_rate, 		s.base_amount, 
		s.allocated_amount, 	s.allow_variance, 	s.variance_per, 		s.variance_amount, 		s.base_alloc_amount, 
		s.base_variance_amount, s.remarks, 			s.utilized_amount, 		s.base_utilized_amount, s.balance_amount, 
		s.base_balance_amount, 	s.createdby, 		s.createddate, 			s.modifiedby, 			s.modifieddate, 
		1, 						p_etljobname, 		p_envsourcecd, 			p_datasourcecd, 		NOW()
    FROM stg.stg_aplan_budget_dtl s
    LEFT JOIN dwh.f_aplanbudgetdtl t
    ON  s.ou_id 			= t.ou_id
    AND s.fb_id 			= t.fb_id
    AND s.asset_class_code  = t.asset_class_code
    AND s.financial_year    = t.financial_year
    AND s.currency_code     = t.currency_code
    AND s.budget_number     = t.budget_number
    WHERE t.ou_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_aplan_budget_dtl
    (
        ou_id, 					fb_id, 			asset_class_code, 	financial_year, 		currency_code, 
		budget_number, 			timestamp, 		amount_required, 	exchange_rate, 			base_amount, 
		allocated_amount, 		allow_variance, variance_per, 		variance_amount, 		base_alloc_amount, 
		base_variance_amount, 	remarks, 		utilized_amount, 	base_utilized_amount, 	balance_amount, 
		base_balance_amount, 	createdby, 		createddate, 		modifiedby, 			modifieddate, 
		etlcreateddatetime
    )
    SELECT
        ou_id, 					fb_id, 			asset_class_code, 	financial_year, 		currency_code, 
		budget_number, 			timestamp, 		amount_required, 	exchange_rate, 			base_amount, 
		allocated_amount, 		allow_variance, variance_per, 		variance_amount, 		base_alloc_amount, 
		base_variance_amount, 	remarks, 		utilized_amount, 	base_utilized_amount, 	balance_amount, 
		base_balance_amount, 	createdby, 		createddate, 		modifiedby, 			modifieddate, 
		etlcreateddatetime
    FROM stg.stg_aplan_budget_dtl;
    
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
ALTER PROCEDURE dwh.usp_f_aplanbudgetdtl(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
