-- PROCEDURE: dwh.usp_d_bnkdefcodemst(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_d_bnkdefcodemst(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_d_bnkdefcodemst(
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
    FROM stg.stg_bnkdef_code_mst;

    UPDATE dwh.D_bnkdefcodemst t
    SET
        company_code            = s.company_code,
        bank_ref_no             = s.bank_ref_no,
        bank_acc_no             = s.bank_acc_no,
        bank_code               = s.bank_code,
        serial_no               = s.serial_no,
        timestamp               = s.timestamp,
        flag                    = s.flag,
        bank_desc               = s.bank_desc,
        fb_id                   = s.fb_id,
        credit_limit            = s.credit_limit,
        draw_limit              = s.draw_limit,
        od_amount               = s.od_amount,
        intrate_eff_date        = s.intrate_eff_date,
        status                  = s.status,
        effective_from          = s.effective_from,
        creation_ou             = s.creation_ou,
        createdby               = s.createdby,
        createddate             = s.createddate,
        workflow_status         = s.workflow_status,
        Wfguid                  = s.Wfguid,
        Statusml                = s.Statusml,
        Wfflag                  = s.Wfflag,
        etlactiveind            = 1,
        etljobname              = p_etljobname,
        envsourcecd             = p_envsourcecd,
        datasourcecd            = p_datasourcecd,
        etlupdatedatetime       = NOW()
    FROM stg.stg_bnkdef_code_mst s
    WHERE t.company_code = s.company_code
    AND t.bank_ref_no = s.bank_ref_no
    AND t.bank_acc_no = s.bank_acc_no
    AND t.bank_code = s.bank_code
    AND t.serial_no = s.serial_no;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.D_bnkdefcodemst
    (
        company_code, bank_ref_no, bank_acc_no, bank_code, serial_no, timestamp, flag, bank_desc, fb_id, credit_limit, draw_limit, od_amount, intrate_eff_date, status, effective_from, creation_ou, createdby, createddate, workflow_status, Wfguid, Statusml, Wfflag, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        s.company_code, s.bank_ref_no, s.bank_acc_no, s.bank_code, s.serial_no, s.timestamp, s.flag, s.bank_desc, s.fb_id, s.credit_limit, s.draw_limit, s.od_amount, s.intrate_eff_date, s.status, s.effective_from, s.creation_ou, s.createdby, s.createddate, s.workflow_status, s.Wfguid, s.Statusml, s.Wfflag, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_bnkdef_code_mst s
    LEFT JOIN dwh.D_bnkdefcodemst t
    ON s.company_code = t.company_code
    AND s.bank_ref_no = t.bank_ref_no
    AND s.bank_acc_no = t.bank_acc_no
    AND s.bank_code = t.bank_code
    AND s.serial_no = t.serial_no
    WHERE t.company_code IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_bnkdef_code_mst
    (
        company_code, bank_ref_no, bank_acc_no, bank_code, serial_no, timestamp, flag, bank_desc, fb_id, credit_limit, draw_limit, od_amount, intrate_eff_date, intrate_od_bal, intrate_cr_bal, intrate_dr_bal, status, effective_from, effective_to, creation_ou, modification_ou, createdby, createddate, modifiedby, modifieddate, min_balance, min_targeted_bal, workflow_status, workflow_error, Wfguid, Statusml, Wfflag, etlcreateddatetime
    )
    SELECT
        company_code, bank_ref_no, bank_acc_no, bank_code, serial_no, timestamp, flag, bank_desc, fb_id, credit_limit, draw_limit, od_amount, intrate_eff_date, intrate_od_bal, intrate_cr_bal, intrate_dr_bal, status, effective_from, effective_to, creation_ou, modification_ou, createdby, createddate, modifiedby, modifieddate, min_balance, min_targeted_bal, workflow_status, workflow_error, Wfguid, Statusml, Wfflag, etlcreateddatetime
    FROM stg.stg_bnkdef_code_mst;
    
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
ALTER PROCEDURE dwh.usp_d_bnkdefcodemst(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
