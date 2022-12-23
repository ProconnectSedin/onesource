CREATE PROCEDURE dwh.usp_f_aplanacqproposalhdr(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
    FROM stg.stg_aplan_acq_proposal_hdr;

    UPDATE dwh.F_aplanacqproposalhdr t
    SET
        pln_pro_curr_key              = COALESCE(c.curr_key,-1),
        ou_id                         = s.ou_id,
        fb_id                         = s.fb_id,
        timestamp                     = s.timestamp,
        proposal_date                 = s.proposal_date,
        numbering_typeno              = s.numbering_typeno,
        proposal_desc                 = s.proposal_desc,
        budget_number                 = s.budget_number,
        board_ref                     = s.board_ref,
        board_ref_date                = s.board_ref_date,
        expiry_date                   = s.expiry_date,
        exchange_rate                 = s.exchange_rate,
        total_proposed_cost_bc        = s.total_proposed_cost_bc,
        proposed_cost_variance        = s.proposed_cost_variance,
        proposal_status               = s.proposal_status,
        amendment_number              = s.amendment_number,
        proposed_cost                 = s.proposed_cost,
        commited_amount               = s.commited_amount,
        liability_amount              = s.liability_amount,
        createdby                     = s.createdby,
        createddate                   = s.createddate,
        modifiedby                    = s.modifiedby,
        modifieddate                  = s.modifieddate,
        etlactiveind                  = 1,
        etljobname                    = p_etljobname,
        envsourcecd                   = p_envsourcecd,
        datasourcecd                  = p_datasourcecd,
        etlupdatedatetime             = NOW()
    FROM stg.stg_aplan_acq_proposal_hdr s

    LEFT JOIN dwh.d_currency c      
        ON  s.currency_code          = c.iso_curr_code 

    WHERE t.ou_id = s.ou_id
    AND t.fb_id = s.fb_id
    AND t.financial_year = s.financial_year
    AND t.asset_class_code = s.asset_class_code
    AND t.currency_code = s.currency_code
    AND t.proposal_number = s.proposal_number
    AND t.addnl_entity = s.addnl_entity;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_aplanacqproposalhdr
    (
       pln_pro_curr_key, ou_id, fb_id, financial_year, asset_class_code, currency_code, proposal_number, timestamp, proposal_date, numbering_typeno, proposal_desc, budget_number, board_ref, board_ref_date, expiry_date, exchange_rate, total_proposed_cost_bc, proposed_cost_variance, proposal_status, amendment_number, proposed_cost, commited_amount, liability_amount, createdby, createddate, modifiedby, modifieddate, addnl_entity, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
       COALESCE(c.curr_key,-1), s.ou_id, s.fb_id, s.financial_year, s.asset_class_code, s.currency_code, s.proposal_number, s.timestamp, s.proposal_date, s.numbering_typeno, s.proposal_desc, s.budget_number, s.board_ref, s.board_ref_date, s.expiry_date, s.exchange_rate, s.total_proposed_cost_bc, s.proposed_cost_variance, s.proposal_status, s.amendment_number, s.proposed_cost, s.commited_amount, s.liability_amount, s.createdby, s.createddate, s.modifiedby, s.modifieddate, s.addnl_entity, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_aplan_acq_proposal_hdr s


    LEFT JOIN dwh.d_currency c      
    ON  s.currency_code          = c.iso_curr_code  


    LEFT JOIN dwh.F_aplanacqproposalhdr t
    ON s.ou_id = t.ou_id
    AND s.fb_id = t.fb_id
    AND s.financial_year = t.financial_year
    AND s.asset_class_code = t.asset_class_code
    AND s.currency_code = t.currency_code
    AND s.proposal_number = t.proposal_number
    AND s.addnl_entity = t.addnl_entity
    WHERE t.ou_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_aplan_acq_proposal_hdr
    (
        ou_id, fb_id, financial_year, asset_class_code, currency_code, proposal_number, timestamp, proposal_date, numbering_typeno, proposal_desc, budget_number, board_ref, board_ref_date, expiry_date, exchange_rate, exchange_rate_var_per, cost_var_per, total_proposed_cost_bc, proposed_cost_variance, proposal_status, amendment_number, proposed_cost, commited_amount, liability_amount, createdby, createddate, modifiedby, modifieddate, workflow_status, workflow_error, addnl_entity, project_ou, project_code, cost_center, etlcreateddatetime
    )
    SELECT
        ou_id, fb_id, financial_year, asset_class_code, currency_code, proposal_number, timestamp, proposal_date, numbering_typeno, proposal_desc, budget_number, board_ref, board_ref_date, expiry_date, exchange_rate, exchange_rate_var_per, cost_var_per, total_proposed_cost_bc, proposed_cost_variance, proposal_status, amendment_number, proposed_cost, commited_amount, liability_amount, createdby, createddate, modifiedby, modifieddate, workflow_status, workflow_error, addnl_entity, project_ou, project_code, cost_center, etlcreateddatetime
    FROM stg.stg_aplan_acq_proposal_hdr;
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