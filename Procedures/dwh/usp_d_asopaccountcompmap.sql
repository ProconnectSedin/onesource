-- PROCEDURE: dwh.usp_d_asopaccountcompmap(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_d_asopaccountcompmap(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_d_asopaccountcompmap(
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
    FROM stg.Stg_as_opaccountcomp_map;

    UPDATE dwh.D_asopaccountcompmap t
    SET
        opcoa_id            = s.opcoa_id,
		company_key         = COALESCE(d.company_key,-1),
		acc_key             = COALESCE(o.opcoa_key,-1),
        account_code        = s.account_code,
        company_code        = s.company_code,
        map_status          = s.map_status,
        resou_id            = s.resou_id,
        createdby           = s.createdby,
        createddate         = s.createddate,
        etlactiveind        = 1,
        etljobname          = p_etljobname,
        envsourcecd         = p_envsourcecd,
        datasourcecd        = p_datasourcecd,
        etlupdatedatetime   = NOW()
    FROM stg.Stg_as_opaccountcomp_map s
	LEFT JOIN dwh.d_company d
	ON s.company_code  = d.company_code 
	LEFT JOIN dwh.d_operationalaccountdetail o
	on s.account_code = o.account_code
    WHERE t.opcoa_id = s.opcoa_id
    AND t.account_code = s.account_code
    AND t.company_code = s.company_code;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.D_asopaccountcompmap
    (
        opcoa_id, company_key, acc_key,account_code, company_code, map_status, resou_id, createdby, createddate, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        s.opcoa_id,COALESCE(d.company_key,-1),COALESCE(o.opcoa_key,-1), s.account_code, s.company_code, s.map_status, s.resou_id, s.createdby, s.createddate, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.Stg_as_opaccountcomp_map s
	LEFT JOIN dwh.d_company d
	ON s.company_code  = d.company_code 
	LEFT JOIN dwh.d_operationalaccountdetail o
	on s.account_code = o.account_code
    LEFT JOIN dwh.D_asopaccountcompmap t
    ON s.opcoa_id = t.opcoa_id
    AND s.account_code = t.account_code
    AND s.company_code = t.company_code
    WHERE t.opcoa_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_as_opaccountcomp_map
    (
        opcoa_id, account_code, company_code, timestamp, map_status, resou_id, createdby, createddate, modifiedby, modifieddate, etlcreateddatetime
    )
    SELECT
        opcoa_id, account_code, company_code, timestamp, map_status, resou_id, createdby, createddate, modifiedby, modifieddate, etlcreateddatetime
    FROM stg.Stg_as_opaccountcomp_map;
    
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
ALTER PROCEDURE dwh.usp_d_asopaccountcompmap(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
