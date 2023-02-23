-- PROCEDURE: dwh.usp_d_cpstaxparamsys(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_d_cpstaxparamsys(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_d_cpstaxparamsys(
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
    FROM stg.stg_cps_taxparam_sys;

    UPDATE dwh.D_cpstaxparamsys t
    SET
        company_code                   = s.company_code,
        ou_id                          = s.ou_id,
        tax_type                       = s.tax_type,
        tax_community                  = s.tax_community,
        taxclosure_decl_ou             = s.taxclosure_decl_ou,
        default_calculation            = s.default_calculation,
        registration_no                = s.registration_no,
        default_taxtype                = s.default_taxtype,
        createdby                      = s.createdby,
        createddate                    = s.createddate,
        modifiedby                     = s.modifiedby,
        modifieddate                   = s.modifieddate,
        effective_from                 = s.effective_from,
        ret1_applicability_date        = s.ret1_applicability_date,
        etlactiveind                   = 1,
        etljobname                     = p_etljobname,
        envsourcecd                    = p_envsourcecd,
        datasourcecd                   = p_datasourcecd,
        etlupdatedatetime              = NOW()
    FROM stg.stg_cps_taxparam_sys s
    WHERE t.company_code = s.company_code
    AND t.ou_id = s.ou_id
    AND t.tax_type = s.tax_type
    AND t.tax_community = s.tax_community;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.D_cpstaxparamsys
    (
        company_code		, ou_id						, tax_type			, tax_community				, taxclosure_decl_ou, 
		default_calculation	, registration_no			, default_taxtype	, createdby					, createddate,
		modifiedby			, modifieddate				, effective_from	, ret1_applicability_date	,
		etlactiveind		, etljobname				, envsourcecd		, datasourcecd				, etlcreatedatetime
    )

    SELECT
        s.company_code			, s.ou_id			, s.tax_type		, s.tax_community			, s.taxclosure_decl_ou,
		s.default_calculation	, s.registration_no	, s.default_taxtype	, s.createdby				, s.createddate,
		s.modifiedby			, s.modifieddate	, s.effective_from	, s.ret1_applicability_date	,
					1			, p_etljobname		, p_envsourcecd		, p_datasourcecd			, NOW()
    FROM stg.stg_cps_taxparam_sys s
    LEFT JOIN dwh.D_cpstaxparamsys t
    ON s.company_code = t.company_code
    AND s.ou_id = t.ou_id
    AND s.tax_type = t.tax_type
    AND s.tax_community = t.tax_community
    WHERE t.company_code IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_cps_taxparam_sys
    (
        company_code, ou_id, tax_type, tax_community, taxclosure_decl_ou, default_calculation, registration_no, default_taxtype, createdby, createddate, modifiedby, modifieddate, effective_from, effective_to, ret1_applicability_date, etlcreateddatetime
    )
    SELECT
        company_code, ou_id, tax_type, tax_community, taxclosure_decl_ou, default_calculation, registration_no, default_taxtype, createdby, createddate, modifiedby, modifieddate, effective_from, effective_to, ret1_applicability_date, etlcreateddatetime
    FROM stg.stg_cps_taxparam_sys;
    
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
ALTER PROCEDURE dwh.usp_d_cpstaxparamsys(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
