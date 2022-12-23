CREATE PROCEDURE click.usp_d_operationalaccountdetail()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_operationalaccountdetail t
    SET
        opcoa_key = s.opcoa_key,
        opcoa_id = s.opcoa_id,
        account_code = s.account_code,
        timestamp = s.timestamp,
        account_desc = s.account_desc,
        currency_code = s.currency_code,
        account_group = s.account_group,
        account_class = s.account_class,
        ctrl_acctype = s.ctrl_acctype,
        autopost_acctype = s.autopost_acctype,
        effective_from = s.effective_from,
        layout_code = s.layout_code,
        account_status = s.account_status,
        active_to = s.active_to,
        createdby = s.createdby,
        createddate = s.createddate,
        modifiedby = s.modifiedby,
        modifieddate = s.modifieddate,
        createdlangid = s.createdlangid,
        schedule_code = s.schedule_code,
        status = s.status,
        revised_schedule_code = s.revised_schedule_code,
        revised_layout_code = s.revised_layout_code,
        revised_neg_layout_code = s.revised_neg_layout_code,
        workflow_status = s.workflow_status,
        wf_flag = s.wf_flag,
        revised_asindas_layout_code = s.revised_asindas_layout_code,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_operationalaccountdetail s
    WHERE t.opcoa_id = s.opcoa_id
    AND t.account_code = s.account_code;

    INSERT INTO click.d_operationalaccountdetail(opcoa_key, opcoa_id, account_code, timestamp, account_desc, currency_code, account_group, account_class, ctrl_acctype, autopost_acctype, effective_from, layout_code, account_status, active_to, createdby, createddate, modifiedby, modifieddate, createdlangid, schedule_code, status, revised_schedule_code, revised_layout_code, revised_neg_layout_code, workflow_status, wf_flag, revised_asindas_layout_code, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.opcoa_key, s.opcoa_id, s.account_code, s.timestamp, s.account_desc, s.currency_code, s.account_group, s.account_class, s.ctrl_acctype, s.autopost_acctype, s.effective_from, s.layout_code, s.account_status, s.active_to, s.createdby, s.createddate, s.modifiedby, s.modifieddate, s.createdlangid, s.schedule_code, s.status, s.revised_schedule_code, s.revised_layout_code, s.revised_neg_layout_code, s.workflow_status, s.wf_flag, s.revised_asindas_layout_code, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_operationalaccountdetail s
    LEFT JOIN click.d_operationalaccountdetail t
    ON t.opcoa_id = s.opcoa_id
    AND t.account_code = s.account_code
    WHERE t.opcoa_id IS NULL;
END;
$$;