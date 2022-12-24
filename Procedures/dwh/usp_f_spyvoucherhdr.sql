CREATE OR REPLACE PROCEDURE dwh.usp_f_spyvoucherhdr(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
    FROM stg.stg_spy_voucher_hdr;

    UPDATE dwh.F_spyvoucherhdr t
    SET
      
      
        voucher_amount            = s.voucher_amount,
        vouch_amt_bef             = s.vouch_amt_bef,
        roundoff_amt              = s.roundoff_amt,
        pay_currency              = s.pay_currency,
        payee                     = s.payee,
        pay_mode                  = s.pay_mode,
        bank_cash_code            = s.bank_cash_code,
        priority                  = s.priority,
        dd_charges                = s.dd_charges,
        status                    = s.status,
        reason_code               = s.reason_code,
        rev_remarks               = s.rev_remarks,
        rev_date                  = s.rev_date,
        batch_id                  = s.batch_id,
        supp_acct_in              = s.supp_acct_in,
        supp_bank_ref             = s.supp_bank_ref,
        supp_acc_no               = s.supp_acc_no,
        lsv_id                    = s.lsv_id,
        esr_line                  = s.esr_line,
        createdby                 = s.createdby,
        createddate               = s.createddate,
        modifiedby                = s.modifiedby,
        modifieddate              = s.modifieddate,
        tcal_status               = s.tcal_status,
        tcal_exclusive_amt        = s.tcal_exclusive_amt,
        request_date              = s.request_date,
        supplier_code             = s.supplier_code,
        recon_reqflg              = s.recon_reqflg,
        MAIL_SENT                 = s.MAIL_SENT,
        Loan_FA                   = s.Loan_FA,
        etlactiveind              = 1,
        etljobname                = p_etljobname,
        envsourcecd               = p_envsourcecd,
        datasourcecd              = p_datasourcecd,
        etlupdatedatetime         = NOW()
    FROM stg.stg_spy_voucher_hdr s
    WHERE t.ou_id = s.ou_id
    AND t.paybatch_no = s.paybatch_no
    AND t.voucher_no = s.voucher_no
    AND t.timestamp = s.vtimestamp
    AND t.line_no = s.line_no
    AND t.ict_flag = s.ict_flag;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_spyvoucherhdr
    (
        ou_id, paybatch_no, voucher_no, timestamp, voucher_amount, vouch_amt_bef, roundoff_amt, pay_currency, payee, pay_mode, bank_cash_code, priority, dd_charges, status, reason_code, rev_remarks, rev_date, batch_id, supp_acct_in, supp_bank_ref, supp_acc_no, lsv_id, esr_line, createdby, createddate, modifiedby, modifieddate, line_no, tcal_status, tcal_exclusive_amt, request_date, supplier_code, recon_reqflg, ict_flag, MAIL_SENT, Loan_FA, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    
)SELECT 
       s.ou_id, s.paybatch_no, s.voucher_no, s.vtimestamp, s.voucher_amount, s.vouch_amt_bef, s.roundoff_amt, s.pay_currency, s.payee, s.pay_mode, s.bank_cash_code, s.priority, s.dd_charges, s.status, s.reason_code, s.rev_remarks, s.rev_date, s.batch_id, s.supp_acct_in, s.supp_bank_ref, s.supp_acc_no, s.lsv_id, s.esr_line, s.createdby, s.createddate, s.modifiedby, s.modifieddate, s.line_no, s.tcal_status, s.tcal_exclusive_amt, s.request_date, s.supplier_code, s.recon_reqflg, s.ict_flag, s.MAIL_SENT, s.Loan_FA, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_spy_voucher_hdr s
    LEFT JOIN dwh.F_spyvoucherhdr t
    ON s.ou_id = t.ou_id
    AND s.paybatch_no = t.paybatch_no
    AND s.voucher_no = t.voucher_no
    AND s.vtimestamp = t.timestamp
    AND s.line_no = t.line_no
    AND s.ict_flag = t.ict_flag
    WHERE t.ou_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_spy_voucher_hdr
    (
        ou_id, paybatch_no, voucher_no, vtimestamp, voucher_amount, vouch_amt_bef, roundoff_amt, exchange_rate, par_exchange_rate, pay_currency, payee, pay_mode, bank_cash_code, priority, dd_charges, status, supp_receipt_no, receipt_date, reason_code, hld_reason_code, hld_remarks, rev_remarks, rev_date, batch_id, supp_acct_in, supp_bank_ref, supp_acc_no, lsv_id, esr_line, doc_status, createdby, createddate, modifiedby, modifieddate, line_no, tcal_status, tcal_exclusive_amt, total_tcal_amount, request_date, supplier_code, lcnumber, refid, tr_flag, tr_percent, tr_amount, tr_tenure, tr_duedate, receipt_no, tr_totalamount, recon_reqflg, ict_flag, be_amount, be_amount_base, be_totalamount, be_percent, be_currency, be_duedate, be_boeno, be_flag, be_issuedat, be_coveredamt, be_redemptionamt, be_status, Lt_loanno, Lt_loanamount, Lt_loantype, Lt_loanp, Lt_currency, Lt_anchordate, Lt_flag, Lt_loannumtype, Lt_surnumtype, Lt_loancat, Lt_loanpurp, Lt_maturitydate, Lt_Interestacc, Lt_Loanaccount, Lt_lenderid, Lt_interestid, Lt_noofinstall, Lt_costcenter, Lt_analysiscode, Lt_subanalysiscode, Lt_loandesc, Lt_loanptype, Lt_projou, Lt_projcode, MAIL_SENT, Loan_FA, gen_from, etlcreateddatetime
    )
    SELECT
        ou_id, paybatch_no, voucher_no, vtimestamp, voucher_amount, vouch_amt_bef, roundoff_amt, exchange_rate, par_exchange_rate, pay_currency, payee, pay_mode, bank_cash_code, priority, dd_charges, status, supp_receipt_no, receipt_date, reason_code, hld_reason_code, hld_remarks, rev_remarks, rev_date, batch_id, supp_acct_in, supp_bank_ref, supp_acc_no, lsv_id, esr_line, doc_status, createdby, createddate, modifiedby, modifieddate, line_no, tcal_status, tcal_exclusive_amt, total_tcal_amount, request_date, supplier_code, lcnumber, refid, tr_flag, tr_percent, tr_amount, tr_tenure, tr_duedate, receipt_no, tr_totalamount, recon_reqflg, ict_flag, be_amount, be_amount_base, be_totalamount, be_percent, be_currency, be_duedate, be_boeno, be_flag, be_issuedat, be_coveredamt, be_redemptionamt, be_status, Lt_loanno, Lt_loanamount, Lt_loantype, Lt_loanp, Lt_currency, Lt_anchordate, Lt_flag, Lt_loannumtype, Lt_surnumtype, Lt_loancat, Lt_loanpurp, Lt_maturitydate, Lt_Interestacc, Lt_Loanaccount, Lt_lenderid, Lt_interestid, Lt_noofinstall, Lt_costcenter, Lt_analysiscode, Lt_subanalysiscode, Lt_loandesc, Lt_loanptype, Lt_projou, Lt_projcode, MAIL_SENT, Loan_FA, gen_from, etlcreateddatetime
    FROM stg.stg_spy_voucher_hdr;
    
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