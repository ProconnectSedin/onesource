-- PROCEDURE: dwh.usp_d_asmlopaccountdtl(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_d_asmlopaccountdtl(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_d_asmlopaccountdtl(
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
    FROM stg.stg_as_ml_opaccount_dtl;

    UPDATE dwh.D_asmlopaccountdtl t
    SET
        language_id                = s.language_id,
        opcoa_id                   = s.opcoa_id,
        account_code               = s.account_code,
        ml_account_desc            = s.ml_account_desc,
        ml_account_desc_shd        = s.ml_account_desc_shd,
        timestamp                  = s.timestamp,
        currency_code              = s.currency_code,
        createdby                  = s.createdby,
        createddate                = s.createddate,
        modifiedby                 = s.modifiedby,
        modifieddate               = s.modifieddate,
        etlactiveind               = 1,
        etljobname                 = p_etljobname,
        envsourcecd                = p_envsourcecd,
        datasourcecd               = p_datasourcecd,
        etlupdatedatetime          = NOW()
    FROM stg.stg_as_ml_opaccount_dtl s
	
    WHERE t.language_id = s.language_id
    AND t.opcoa_id = s.opcoa_id
    AND t.account_code = s.account_code;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.D_asmlopaccountdtl
    (
        language_id, opcoa_id, account_code, ml_account_desc, ml_account_desc_shd, timestamp, currency_code, createdby, createddate, modifiedby, modifieddate, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        s.language_id, s.opcoa_id, s.account_code, s.ml_account_desc, s.ml_account_desc_shd, s.timestamp, s.currency_code, s.createdby, s.createddate, s.modifiedby, s.modifieddate, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_as_ml_opaccount_dtl s
	
	
    LEFT JOIN dwh.D_asmlopaccountdtl t
    ON s.language_id = t.language_id
    AND s.opcoa_id = t.opcoa_id
    AND s.account_code = t.account_code
    WHERE t.language_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_as_ml_opaccount_dtl
    (
        language_id, opcoa_id, account_code, ml_account_desc, ml_account_desc_shd, timestamp, currency_code, createdby, createddate, modifiedby, modifieddate, etlcreateddatetime
    )
    SELECT
        language_id, opcoa_id, account_code, ml_account_desc, ml_account_desc_shd, timestamp, currency_code, createdby, createddate, modifiedby, modifieddate, etlcreateddatetime
    FROM stg.stg_as_ml_opaccount_dtl;
    
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
ALTER PROCEDURE dwh.usp_d_asmlopaccountdtl(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
