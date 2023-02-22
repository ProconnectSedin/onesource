-- PROCEDURE: dwh.usp_d_rcdcodesmst(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_d_rcdcodesmst(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_d_rcdcodesmst(
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
    FROM stg.stg_rcd_codes_mst;

    UPDATE dwh.D_rcdcodesmst t
    SET
        component_id            = s.component_id,
        tran_type               = s.tran_type,
        event_name              = s.event_name,
        reason_code             = s.reason_code,
        timestamp               = s.timestamp,
        reason_descr            = s.reason_descr,
        status                  = s.status,
        default_flag            = s.default_flag,
        createdby               = s.createdby,
        createddate             = s.createddate,
        modifiedby              = s.modifiedby,
        modifieddate            = s.modifieddate,
        created_lang_id         = s.created_lang_id,
        event_code              = s.event_code,
        nature_of_reason        = s.nature_of_reason,
        etlactiveind            = 1,
        etljobname              = p_etljobname,
        envsourcecd             = p_envsourcecd,
        datasourcecd            = p_datasourcecd,
        etlupdatedatetime       = NOW()
    FROM stg.stg_rcd_codes_mst s
    WHERE t.component_id = s.component_id
    AND t.tran_type = s.tran_type
    AND t.event_name = s.event_name
    AND t.reason_code = s.reason_code;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.D_rcdcodesmst
    (
        component_id, tran_type, event_name, reason_code, timestamp, reason_descr, status, default_flag, createdby, createddate, modifiedby, modifieddate, created_lang_id, event_code, nature_of_reason, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        s.component_id, s.tran_type, s.event_name, s.reason_code, s.timestamp, s.reason_descr, s.status, s.default_flag, s.createdby, s.createddate, s.modifiedby, s.modifieddate, s.created_lang_id, s.event_code, s.nature_of_reason, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_rcd_codes_mst s
    LEFT JOIN dwh.D_rcdcodesmst t
    ON s.component_id = t.component_id
    AND s.tran_type = t.tran_type
    AND s.event_name = t.event_name
    AND s.reason_code = t.reason_code
    WHERE t.component_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_rcd_codes_mst
    (
        component_id, tran_type, event_name, reason_code, timestamp, reason_descr, status, default_flag, createdby, createddate, modifiedby, modifieddate, created_lang_id, event_code, nature_of_reason, etlcreateddatetime
    )
    SELECT
        component_id, tran_type, event_name, reason_code, timestamp, reason_descr, status, default_flag, createdby, createddate, modifiedby, modifieddate, created_lang_id, event_code, nature_of_reason, etlcreateddatetime
    FROM stg.stg_rcd_codes_mst;
    
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
ALTER PROCEDURE dwh.usp_d_rcdcodesmst(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
