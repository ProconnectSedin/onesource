-- PROCEDURE: dwh.usp_d_bnkdefcashmst(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_d_bnkdefcashmst(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_d_bnkdefcashmst(
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
    FROM stg.stg_bnkdef_cash_mst;

    UPDATE dwh.D_bnkdefcashmst t
    SET
        company_code           = s.company_code,
        cash_code              = s.cash_code,
        serial_no              = s.serial_no,
        timestamp              = s.timestamp,
        cash_desc              = s.cash_desc,
        currency_code          = s.currency_code,
        status                 = s.status,
        fb_id                  = s.fb_id,
        effective_from         = s.effective_from,
        effective_to           = s.effective_to,
        creation_ou            = s.creation_ou,
        modification_ou        = s.modification_ou,
        createdby              = s.createdby,
        createddate            = s.createddate,
        modifiedby             = s.modifiedby,
        modifieddate           = s.modifieddate,
        etlactiveind           = 1,
        etljobname             = p_etljobname,
        envsourcecd            = p_envsourcecd,
        datasourcecd           = p_datasourcecd,
        etlupdatedatetime      = NOW()
    FROM stg.stg_bnkdef_cash_mst s
    WHERE t.company_code = s.company_code
    AND t.cash_code = s.cash_code
    AND t.serial_no = s.serial_no;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.D_bnkdefcashmst
    (
        company_code, cash_code, serial_no, timestamp, cash_desc, currency_code, status, fb_id, effective_from, effective_to, creation_ou, modification_ou, createdby, createddate, modifiedby, modifieddate, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        s.company_code, s.cash_code, s.serial_no, s.timestamp, s.cash_desc, s.currency_code, s.status, s.fb_id, s.effective_from, s.effective_to, s.creation_ou, s.modification_ou, s.createdby, s.createddate, s.modifiedby, s.modifieddate, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_bnkdef_cash_mst s
    LEFT JOIN dwh.D_bnkdefcashmst t
    ON s.company_code = t.company_code
    AND s.cash_code = t.cash_code
    AND s.serial_no = t.serial_no
    WHERE t.company_code IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_bnkdef_cash_mst
    (
        company_code, cash_code, serial_no, timestamp, cash_desc, currency_code, status, fb_id, effective_from, effective_to, creation_ou, modification_ou, createdby, createddate, modifiedby, modifieddate, etlcreateddatetime
    )
    SELECT
        company_code, cash_code, serial_no, timestamp, cash_desc, currency_code, status, fb_id, effective_from, effective_to, creation_ou, modification_ou, createdby, createddate, modifiedby, modifieddate, etlcreateddatetime
    FROM stg.stg_bnkdef_cash_mst;
    
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
ALTER PROCEDURE dwh.usp_d_bnkdefcashmst(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
