-- PROCEDURE: dwh.usp_d_aspostingruledtl(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_d_aspostingruledtl(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_d_aspostingruledtl(
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
    FROM stg.stg_as_postingrule_dtl;

    UPDATE dwh.D_aspostingruledtl t
    SET
        company_code            = s.company_code,
        jv_type                 = s.jv_type,
        effective_from          = s.effective_from,
        autopost_acctype        = s.autopost_acctype,
        ctrl_acctype            = s.ctrl_acctype,
        account_class           = s.account_class,
        account_group           = s.account_group,
        sequence_no             = s.sequence_no,
        timestamp               = s.timestamp,
        account_code            = s.account_code,
        status                  = s.status,
        effective_to            = s.effective_to,
        createdby               = s.createdby,
        createddate             = s.createddate,
        modifiedby              = s.modifiedby,
        modifieddate            = s.modifieddate,
        etlactiveind            = 1,
        etljobname              = p_etljobname,
        envsourcecd             = p_envsourcecd,
        datasourcecd            = p_datasourcecd,
        etlupdatedatetime       = NOW()
    FROM stg.stg_as_postingrule_dtl s
    WHERE t.company_code = s.company_code
    AND t.jv_type = s.jv_type
    AND t.effective_from = s.effective_from
    AND t.autopost_acctype = s.autopost_acctype
    AND t.ctrl_acctype = s.ctrl_acctype
    AND t.account_class = s.account_class
    AND t.account_group = s.account_group
    AND t.sequence_no = s.sequence_no;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.D_aspostingruledtl
    (
        company_code, jv_type, effective_from, autopost_acctype, ctrl_acctype, account_class, account_group, sequence_no, timestamp, account_code, status, effective_to, createdby, createddate, modifiedby, modifieddate, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        s.company_code, s.jv_type, s.effective_from, s.autopost_acctype, s.ctrl_acctype, s.account_class, s.account_group, s.sequence_no, s.timestamp, s.account_code, s.status, s.effective_to, s.createdby, s.createddate, s.modifiedby, s.modifieddate, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_as_postingrule_dtl s
    LEFT JOIN dwh.D_aspostingruledtl t
    ON s.company_code = t.company_code
    AND s.jv_type = t.jv_type
    AND s.effective_from = t.effective_from
    AND s.autopost_acctype = t.autopost_acctype
    AND s.ctrl_acctype = t.ctrl_acctype
    AND s.account_class = t.account_class
    AND s.account_group = t.account_group
    AND s.sequence_no = t.sequence_no
    WHERE t.company_code IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_as_postingrule_dtl
    (
        company_code, jv_type, effective_from, autopost_acctype, ctrl_acctype, account_class, account_group, sequence_no, timestamp, account_code, status, effective_to, createdby, createddate, modifiedby, modifieddate, etlcreateddatetime
    )
    SELECT
        company_code, jv_type, effective_from, autopost_acctype, ctrl_acctype, account_class, account_group, sequence_no, timestamp, account_code, status, effective_to, createdby, createddate, modifiedby, modifieddate, etlcreateddatetime
    FROM stg.stg_as_postingrule_dtl;
    
    END IF;
--     EXCEPTION WHEN others THEN
--         get stacked diagnostics
--             p_errorid   = returned_sqlstate,
--             p_errordesc = message_text;
--     CALL ods.usp_etlerrorinsert(p_sourceid, p_targetobject, p_dataflowflag, p_batchid,p_taskname, 'sp_ExceptionHandling', p_errorid, p_errordesc, null);
--        select 0 into inscnt;
--        select 0 into updcnt;
END;
$BODY$;
ALTER PROCEDURE dwh.usp_d_aspostingruledtl(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
