-- PROCEDURE: dwh.usp_d_fbpbankcashbal(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_d_fbpbankcashbal(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_d_fbpbankcashbal(
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
    FROM stg.stg_fbp_bankcash_bal;

    UPDATE dwh.D_fbpbankcashbal t
    SET
        ou_id                = s.ou_id,
        bankcash_code        = s.bankcash_code,
        fb_id                = s.fb_id,
        pay_type             = s.pay_type,
        timestamp            = s.timestamp,
        request_bal          = s.request_bal,
        createdby            = s.createdby,
        createddate          = s.createddate,
        modifiedby           = s.modifiedby,
        modifieddate         = s.modifieddate,
        etlactiveind         = 1,
        etljobname           = p_etljobname,
        envsourcecd          = p_envsourcecd,
        datasourcecd         = p_datasourcecd,
        etlupdatedatetime    = NOW()
    FROM stg.stg_fbp_bankcash_bal s
    WHERE t.ou_id = s.ou_id
    AND t.bankcash_code = s.bankcash_code
    AND t.fb_id = s.fb_id
    AND t.pay_type = s.pay_type;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.D_fbpbankcashbal
    (
        ou_id, bankcash_code, fb_id, pay_type, timestamp, request_bal, createdby, createddate, modifiedby, modifieddate, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        s.ou_id, s.bankcash_code, s.fb_id, s.pay_type, s.timestamp, s.request_bal, s.createdby, s.createddate, s.modifiedby, s.modifieddate, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_fbp_bankcash_bal s
    LEFT JOIN dwh.D_fbpbankcashbal t
    ON s.ou_id = t.ou_id
    AND s.bankcash_code = t.bankcash_code
    AND s.fb_id = t.fb_id
    AND s.pay_type = t.pay_type
    WHERE t.ou_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_fbp_bankcash_bal
    (
        ou_id, bankcash_code, fb_id, pay_type, timestamp, request_bal, createdby, createddate, modifiedby, modifieddate, etlcreatedatetime
    )
    SELECT
        ou_id, bankcash_code, fb_id, pay_type, timestamp, request_bal, createdby, createddate, modifiedby, modifieddate, etlcreatedatetime
    FROM stg.stg_fbp_bankcash_bal;
    
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
ALTER PROCEDURE dwh.usp_d_fbpbankcashbal(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
