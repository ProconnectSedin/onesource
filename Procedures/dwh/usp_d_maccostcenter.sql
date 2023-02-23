-- PROCEDURE: dwh.usp_d_maccostcenter(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_d_maccostcenter(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_d_maccostcenter(
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
    FROM stg.stg_mac_cost_center;

    UPDATE dwh.D_maccostcenter t
    SET
        ou_id                     = s.ou_id,
        company_code              = s.company_code,
        ma_center_no              = s.ma_center_no,
        ma_center_leaf            = s.ma_center_leaf,
        ma_center_sdesc           = s.ma_center_sdesc,
        ma_center_ldesc           = s.ma_center_ldesc,
        ma_effective_date         = s.ma_effective_date,
        ma_expiry_date            = s.ma_expiry_date,
        ma_center_resp            = s.ma_center_resp,
        ma_ctrl_acc               = s.ma_ctrl_acc,
        ma_center_flag            = s.ma_center_flag,
        ma_center_type            = s.ma_center_type,
        ma_par_cmpy_center        = s.ma_par_cmpy_center,
        ma_user_id                = s.ma_user_id,
        ma_datetime               = s.ma_datetime,
        ma_createdby              = s.ma_createdby,
        ma_timestamp              = s.ma_timestamp,
        ma_createdate             = s.ma_createdate,
        ma_modifiedby             = s.ma_modifiedby,
        ma_modifydate             = s.ma_modifydate,
        ma_status                 = s.ma_status,
        ma_org_unit               = s.ma_org_unit,
        bu_id                     = s.bu_id,
        lo_id                     = s.lo_id,
        ma_WF_status              = s.ma_WF_status,
        wf_flag                   = s.wf_flag,
        ma_guid                   = s.ma_guid,
        workflow_error            = s.workflow_error,
        etlactiveind              = 1,
        etljobname                = p_etljobname,
        envsourcecd               = p_envsourcecd,
        datasourcecd              = p_datasourcecd,
        etlupdatedatetime         = NOW()
    FROM stg.stg_mac_cost_center s
    WHERE t.ou_id = s.ou_id
    AND t.company_code = s.company_code
    AND t.ma_center_no = s.ma_center_no
    AND t.ma_center_leaf = s.ma_center_leaf
    AND t.ma_center_sdesc = s.ma_center_sdesc
    AND t.ma_effective_date = s.ma_effective_date;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.D_maccostcenter
    (
        ou_id, company_code, ma_center_no, ma_center_leaf, ma_center_sdesc, ma_center_ldesc, ma_effective_date, ma_expiry_date, ma_center_resp, ma_ctrl_acc, ma_center_flag, ma_center_type, ma_par_cmpy_center, ma_user_id, ma_datetime, ma_createdby, ma_timestamp, ma_createdate, ma_modifiedby, ma_modifydate, ma_status, ma_org_unit, bu_id, lo_id, ma_WF_status, wf_flag, ma_guid, workflow_error, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        s.ou_id, s.company_code, s.ma_center_no, s.ma_center_leaf, s.ma_center_sdesc, s.ma_center_ldesc, s.ma_effective_date, s.ma_expiry_date, s.ma_center_resp, s.ma_ctrl_acc, s.ma_center_flag, s.ma_center_type, s.ma_par_cmpy_center, s.ma_user_id, s.ma_datetime, s.ma_createdby, s.ma_timestamp, s.ma_createdate, s.ma_modifiedby, s.ma_modifydate, s.ma_status, s.ma_org_unit, s.bu_id, s.lo_id, s.ma_WF_status, s.wf_flag, s.ma_guid, s.workflow_error, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_mac_cost_center s
    LEFT JOIN dwh.D_maccostcenter t
    ON s.ou_id = t.ou_id
    AND s.company_code = t.company_code
    AND s.ma_center_no = t.ma_center_no
    AND s.ma_center_leaf = t.ma_center_leaf
    AND s.ma_center_sdesc = t.ma_center_sdesc
    AND s.ma_effective_date = t.ma_effective_date
    WHERE t.ou_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_mac_cost_center
    (
        ou_id, company_code, ma_center_no, ma_center_leaf, ma_center_sdesc, ma_center_ldesc, ma_effective_date, ma_expiry_date, ma_center_resp, ma_ctrl_acc, ma_center_flag, ma_center_type, ma_par_cmpy_center, ma_user_id, ma_datetime, ma_createdby, ma_timestamp, ma_createdate, ma_modifiedby, ma_modifydate, ma_status, ma_org_unit, bu_id, lo_id, ma_WF_status, wf_flag, ma_guid, workflow_error, etlcreateddatetime
    )
    SELECT
        ou_id, company_code, ma_center_no, ma_center_leaf, ma_center_sdesc, ma_center_ldesc, ma_effective_date, ma_expiry_date, ma_center_resp, ma_ctrl_acc, ma_center_flag, ma_center_type, ma_par_cmpy_center, ma_user_id, ma_datetime, ma_createdby, ma_timestamp, ma_createdate, ma_modifiedby, ma_modifydate, ma_status, ma_org_unit, bu_id, lo_id, ma_WF_status, wf_flag, ma_guid, workflow_error, etlcreateddatetime
    FROM stg.stg_mac_cost_center;
    
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
ALTER PROCEDURE dwh.usp_d_maccostcenter(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
