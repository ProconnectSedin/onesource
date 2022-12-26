CREATE OR REPLACE PROCEDURE dwh.usp_d_operationalaccountdetail(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
    LANGUAGE plpgsql
    AS $$

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
    SELECT d.jobname, h.envsourcecode, h.datasourcecode, d.latestbatchid, d.targetprocedurename,h.rawstorageflag

    INTO p_etljobname, p_envsourcecd, p_datasourcecd, p_batchid, p_taskname,p_rawstorageflag

    FROM ods.controldetail d
    INNER JOIN ods.controlheader h
        ON d.sourceid = h.sourceid
    WHERE d.sourceid = p_sourceId
        AND d.dataflowflag = p_dataflowflag
        AND d.targetobject = p_targetobject;

    SELECT COUNT(1) INTO srccnt
    FROM stg.stg_as_opaccount_dtl;

    UPDATE dwh.d_operationalAccountDetail t
    SET
        timestamp                          = s.timestamp,
        account_desc                       = s.account_desc,
        currency_code                      = s.currency_code,
        account_group                      = s.account_group,
        account_class                      = s.account_class,
        ctrl_acctype                       = s.ctrl_acctype,
        autopost_acctype                   = s.autopost_acctype,
        effective_from                     = s.effective_from,
        layout_code                        = s.layout_code,
        account_status                     = s.account_status,
        active_to                          = s.active_to,
        createdby                          = s.createdby,
        createddate                        = s.createddate,
        modifiedby                         = s.modifiedby,
        modifieddate                       = s.modifieddate,
        createdlangid                      = s.createdlangid,
        schedule_code                      = s.schedule_code,
        status                             = s.status,
        revised_schedule_code              = s.revised_schedule_code,
        revised_layout_code                = s.revised_layout_code,
        revised_neg_layout_code            = s.revised_neg_layout_code,
        workflow_status                    = s.workflow_status,
        wf_flag                            = s.wf_flag,
        revised_asindas_layout_code        = s.revised_asindas_layout_code,
        etlactiveind                       = 1,
        etljobname                         = p_etljobname,
        envsourcecd                        = p_envsourcecd,
        datasourcecd                       = p_datasourcecd,
        etlupdatedatetime                  = NOW()
    FROM stg.stg_as_opaccount_dtl s
    WHERE t.opcoa_id = s.opcoa_id
    AND t.account_code = s.account_code;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.d_operationalAccountDetail
    (
        opcoa_id, account_code, timestamp, account_desc, currency_code, account_group, account_class, ctrl_acctype, autopost_acctype, effective_from, layout_code, account_status, active_to, createdby, createddate, modifiedby, modifieddate, createdlangid, schedule_code, status, revised_schedule_code, revised_layout_code, revised_neg_layout_code, workflow_status, wf_flag, revised_asindas_layout_code, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        s.opcoa_id, s.account_code, s.timestamp, s.account_desc, s.currency_code, s.account_group, s.account_class, s.ctrl_acctype, s.autopost_acctype, s.effective_from, s.layout_code, s.account_status, s.active_to, s.createdby, s.createddate, s.modifiedby, s.modifieddate, s.createdlangid, s.schedule_code, s.status, s.revised_schedule_code, s.revised_layout_code, s.revised_neg_layout_code, s.workflow_status, s.wf_flag, s.revised_asindas_layout_code, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_as_opaccount_dtl s
    LEFT JOIN dwh.d_operationalAccountDetail t
    ON s.opcoa_id = t.opcoa_id
    AND s.account_code = t.account_code
    WHERE t.opcoa_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
	IF p_rawstorageflag = 1
	THEN


    INSERT INTO raw.raw_as_opaccount_dtl
    (
        opcoa_id, account_code, timestamp, account_desc, currency_code, account_group, account_class, ctrl_acctype, autopost_acctype, effective_from, effective_to, consol_account, layout_code, account_status, active_from, active_to, createdby, createddate, modifiedby, modifieddate, createdlangid, schedule_code, status, revised_schedule_code, revised_layout_code, revised_neg_schedule_code, revised_neg_layout_code, workflow_status, workflow_error, wf_flag, revised_asindas_layout_code, etlcreateddatetime
    )
    SELECT
        opcoa_id, account_code, timestamp, account_desc, currency_code, account_group, account_class, ctrl_acctype, autopost_acctype, effective_from, effective_to, consol_account, layout_code, account_status, active_from, active_to, createdby, createddate, modifiedby, modifieddate, createdlangid, schedule_code, status, revised_schedule_code, revised_layout_code, revised_neg_schedule_code, revised_neg_layout_code, workflow_status, workflow_error, wf_flag, revised_asindas_layout_code, etlcreateddatetime
    FROM stg.stg_as_opaccount_dtl;
     END IF;
    EXCEPTION WHEN others THEN
        get stacked diagnostics
            p_errorid   = returned_sqlstate,
            p_errordesc = message_text;
    CALL ods.usp_etlerrorinsert(p_sourceid, p_targetobject, p_dataflowflag, p_batchid,p_taskname, 'sp_ExceptionHandling', p_errorid, p_errordesc, null);
       select 0 into inscnt;
       select 0 into updcnt;
END;
$$;