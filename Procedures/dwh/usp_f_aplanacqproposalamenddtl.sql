-- PROCEDURE: dwh.usp_f_aplanacqproposalamenddtl(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_aplanacqproposalamenddtl(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_aplanacqproposalamenddtl(
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
    FROM stg.Stg_aplan_acq_proposal_amend_dtl;

    UPDATE dwh.F_aplanacqproposalamenddtl t
    SET
		currency_key			= COALESCE(cu.curr_key,-1),
        proposal_number         = s.proposal_number,
        ou_id                   = s.ou_id,
        fb_id                   = s.fb_id,
        financial_year          = s.financial_year,
        asset_class_code        = s.asset_class_code,
        currency_code           = s.currency_code,
        amendment_number        = s.amendment_number,
        asset_desc              = s.asset_desc,
        no_of_units             = s.no_of_units,
        proposal_cost           = s.proposal_cost,
        cost_base_curr          = s.cost_base_curr,
        createdby               = s.createdby,
        createddate             = s.createddate,
        etlactiveind            = 1,
        etljobname              = p_etljobname,
        envsourcecd             = p_envsourcecd,
        datasourcecd            = p_datasourcecd,
        etlupdatedatetime       = NOW()
    FROM stg.Stg_aplan_acq_proposal_amend_dtl s
	LEFT JOIN  dwh.d_currency cu
	ON cu.iso_curr_code = s.currency_code
    WHERE t.ou_id = s.ou_id
    AND t.fb_id = s.fb_id
    AND t.financial_year = s.financial_year
	AND t.proposal_number = s.proposal_number
    AND t.asset_class_code = s.asset_class_code
    AND t.currency_code = s.currency_code
    AND t.amendment_number = s.amendment_number
    AND t.asset_desc = s.asset_desc;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_aplanacqproposalamenddtl
    (
		currency_key,
        proposal_number, ou_id, fb_id, financial_year, asset_class_code, currency_code, amendment_number, asset_desc, no_of_units, proposal_cost, cost_base_curr, createdby, createddate, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
		COALESCE( cu.curr_key,-1),
        s.proposal_number, s.ou_id, s.fb_id, s.financial_year, s.asset_class_code, s.currency_code, s.amendment_number, s.asset_desc, s.no_of_units, s.proposal_cost, s.cost_base_curr, s.createdby, s.createddate, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.Stg_aplan_acq_proposal_amend_dtl s
	LEFT JOIN  dwh.d_currency cu
	ON cu.iso_curr_code = s.currency_code
    LEFT JOIN dwh.F_aplanacqproposalamenddtl t
    ON t.ou_id = s.ou_id
    AND t.fb_id = s.fb_id
    AND t.financial_year = s.financial_year
	AND t.proposal_number = s.proposal_number
    AND t.asset_class_code = s.asset_class_code
    AND t.currency_code = s.currency_code
    AND t.amendment_number = s.amendment_number
    AND t.asset_desc = s.asset_desc
    WHERE t.proposal_number IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_aplan_acq_proposal_amend_dtl
    (
        proposal_number, ou_id, fb_id, financial_year, asset_class_code, currency_code, amendment_number, asset_desc, timestamp, no_of_units, proposal_cost, cost_base_curr, createdby, createddate, modifiedby, modifieddate, etlcreateddatetime
    )
    SELECT
        proposal_number, ou_id, fb_id, financial_year, asset_class_code, currency_code, amendment_number, asset_desc, timestamp, no_of_units, proposal_cost, cost_base_curr, createdby, createddate, modifiedby, modifieddate, etlcreateddatetime
    FROM stg.Stg_aplan_acq_proposal_amend_dtl;
    
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
ALTER PROCEDURE dwh.usp_f_aplanacqproposalamenddtl(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
