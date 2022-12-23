CREATE PROCEDURE dwh.usp_f_jvvouchertrndtl(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
    SELECT d.jobname, h.envsourcecode, h.datasourcecode, d.latestbatchid, d.targetprocedurename, h.rawstorageflag
    INTO p_etljobname, p_envsourcecd, p_datasourcecd, p_batchid, p_taskname, p_rawstorageflag
    FROM ods.controldetail d
    INNER JOIN ods.controlheader h
        ON d.sourceid = h.sourceid
    WHERE d.sourceid = p_sourceId
        AND d.dataflowflag = p_dataflowflag
        AND d.targetobject = p_targetobject;

    SELECT COUNT(1) INTO srccnt
    FROM stg.stg_jv_voucher_trn_dtl;

    UPDATE dwh.F_jvvouchertrndtl t
    SET
        ou_id                      = s.ou_id,
        voucher_no                 = s.voucher_no,
        voucher_serial_no          = s.voucher_serial_no,
        timestamp                  = s.timestamp,
        account_code               = s.account_code,
        drcr_flag                  = s.drcr_flag,
        tran_currency              = s.tran_currency,
        tran_amount                = s.tran_amount,
        exchange_rate              = s.exchange_rate,
        par_exchange_rate          = s.par_exchange_rate,
        base_amount                = s.base_amount,
        par_base_amount            = s.par_base_amount,
        remarks                    = s.remarks,
        costcenter_code            = s.costcenter_code,
        analysis_code              = s.analysis_code,
        subanal_code               = s.subanal_code,
        createdby                  = s.createdby,
        createddate                = s.createddate,
        modifiedby                 = s.modifiedby,
        modifieddate               = s.modifieddate,
        DestFBID                   = s.DestFBID,
        DestAccountCode            = s.DestAccountCode,
        InterCompJV                = s.InterCompJV,
        dest_cost_center           = s.dest_cost_center,
        account_currency           = s.account_currency,
        base_erate_inacccur        = s.base_erate_inacccur,
        des_ouid                   = s.des_ouid,
        RevInterCompJV             = s.RevInterCompJV,
        usage_id                   = s.usage_id,
        guid1                      = s.guid1,
        etlactiveind               = 1,
        etljobname                 = p_etljobname,
        envsourcecd                = p_envsourcecd,
        datasourcecd               = p_datasourcecd,
        etlupdatedatetime          = NOW()
    FROM stg.stg_jv_voucher_trn_dtl s
    WHERE t.ou_id = s.ou_id
    AND t.voucher_no = s.voucher_no
    AND t.voucher_serial_no = s.voucher_serial_no;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_jvvouchertrndtl
    (
        ou_id, voucher_no, voucher_serial_no, timestamp, account_code, drcr_flag, tran_currency, tran_amount, exchange_rate, par_exchange_rate, base_amount, par_base_amount, remarks, costcenter_code, analysis_code, subanal_code, createdby, createddate, modifiedby, modifieddate, DestFBID, DestAccountCode, InterCompJV, dest_cost_center, account_currency, base_erate_inacccur, des_ouid, RevInterCompJV, usage_id, guid1, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        s.ou_id, s.voucher_no, s.voucher_serial_no, s.timestamp, s.account_code, s.drcr_flag, s.tran_currency, s.tran_amount, s.exchange_rate, s.par_exchange_rate, s.base_amount, s.par_base_amount, s.remarks, s.costcenter_code, s.analysis_code, s.subanal_code, s.createdby, s.createddate, s.modifiedby, s.modifieddate, s.DestFBID, s.DestAccountCode, s.InterCompJV, s.dest_cost_center, s.account_currency, s.base_erate_inacccur, s.des_ouid, s.RevInterCompJV, s.usage_id, s.guid1, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_jv_voucher_trn_dtl s
    LEFT JOIN dwh.F_jvvouchertrndtl t
    ON s.ou_id = t.ou_id
    AND s.voucher_no = t.voucher_no
    AND s.voucher_serial_no = t.voucher_serial_no
    WHERE t.ou_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_jv_voucher_trn_dtl
    (
        ou_id, voucher_no, voucher_serial_no, timestamp, account_code, drcr_flag, tran_currency, tran_amount, exchange_rate, par_exchange_rate, base_amount, par_base_amount, remarks, costcenter_code, analysis_code, subanal_code, createdby, createddate, modifiedby, modifieddate, DestFBID, DestAccountCode, InterCompJV, dest_cost_center, dest_analysis_code, dest_subanalysis_code, account_currency, base_erate_inacccur, pbase_erate_inacccur, des_ouid, cfs_refdoc_ou, cfs_refdoc_no, cfs_refdoc_type, dest_company, RevInterCompJV, proposal_number, pending_cap_amount, capitalized_amount, usage_id, ifb_recon_jvno, cap_flag, writeoff_amt, writeoff_remarks, writeoff_JVno, writeoff_doc_ou, writeoff_doc_no, writeoff_doc_type, guid1, writeoff_doc_lineno, etlcreateddatetime
    )
    SELECT
        ou_id, voucher_no, voucher_serial_no, timestamp, account_code, drcr_flag, tran_currency, tran_amount, exchange_rate, par_exchange_rate, base_amount, par_base_amount, remarks, costcenter_code, analysis_code, subanal_code, createdby, createddate, modifiedby, modifieddate, DestFBID, DestAccountCode, InterCompJV, dest_cost_center, dest_analysis_code, dest_subanalysis_code, account_currency, base_erate_inacccur, pbase_erate_inacccur, des_ouid, cfs_refdoc_ou, cfs_refdoc_no, cfs_refdoc_type, dest_company, RevInterCompJV, proposal_number, pending_cap_amount, capitalized_amount, usage_id, ifb_recon_jvno, cap_flag, writeoff_amt, writeoff_remarks, writeoff_JVno, writeoff_doc_ou, writeoff_doc_no, writeoff_doc_type, guid1, writeoff_doc_lineno, etlcreateddatetime
    FROM stg.stg_jv_voucher_trn_dtl;
    
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