CREATE PROCEDURE dwh.usp_f_spyprepayvchhdr(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
    FROM stg.stg_spy_prepay_vch_hdr;

    UPDATE dwh.F_spyprepayvchhdr t
    SET
		vendor_key                = COALESCE(v.vendor_key,-1),
		curr_key                  = COALESCE(cr.curr_key,-1),
        voucher_type              = s.voucher_type,
        request_date              = s.request_date,
        fb_id                     = s.fb_id,
        supp_code                 = s.supp_code,
        payment_route             = s.payment_route,
        pay_mode                  = s.pay_mode,
        priority                  = s.priority,
        pay_currency              = s.pay_currency,
        exchange_rate             = s.exchange_rate,
        dd_charges                = s.dd_charges,
        pay_amount                = s.pay_amount,
        pay_amt_bef_round         = s.pay_amt_bef_round,
        roundoff_amt              = s.roundoff_amt,
        pay_date                  = s.pay_date,
        bank_cash_code            = s.bank_cash_code,
        relpay_ou                 = s.relpay_ou,
        reason_code               = s.reason_code,
        remarks                   = s.remarks,
        rev_remarks               = s.rev_remarks,
        rev_date                  = s.rev_date,
        notype_no                 = s.notype_no,
        supp_area                 = s.supp_area,
        supp_doc_no               = s.supp_doc_no,
        supp_doc_date             = s.supp_doc_date,
        supp_doc_amt              = s.supp_doc_amt,
        supp_prepay_acct          = s.supp_prepay_acct,
        bank_cash_acct            = s.bank_cash_acct,
        status                    = s.status,
        batch_id                  = s.batch_id,
        createdby                 = s.createdby,
        createddate               = s.createddate,
        modifiedby                = s.modifiedby,
        modifieddate              = s.modifieddate,
        tcal_exclusive_amt        = s.tcal_exclusive_amt,
        tcal_status               = s.tcal_status,
        voucher_amount            = s.voucher_amount,
        ibe_flag                  = s.ibe_flag,
        workflow_status           = s.workflow_status,
        tr_flag                   = s.tr_flag,
        surnotype_no              = s.surnotype_no,
        bank_amount               = s.bank_amount,
        etlactiveind              = 1,
        etljobname                = p_etljobname,
        envsourcecd               = p_envsourcecd,
        datasourcecd              = p_datasourcecd,
        etlupdatedatetime         = NOW()
    FROM stg.stg_spy_prepay_vch_hdr s
	LEFT JOIN dwh.d_currency cr
		ON  s.pay_currency		  = cr.iso_curr_code
	LEFT JOIN dwh.d_vendor v
		ON  s.supp_code 	  	  = v.vendor_id
		AND s.ou_id			  	  = v.vendor_ou	
    WHERE t.ou_id = s.ou_id
    AND t.voucher_no = s.voucher_no
    AND t.tran_type = s.tran_type
    AND t.ptimestamp = s.ptimestamp
    AND t.lgt_invoice_flag = s.lgt_invoice_flag;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_spyprepayvchhdr
    (
        curr_key, vendor_key, ou_id, voucher_no, tran_type, ptimestamp, voucher_type, request_date, fb_id, supp_code, payment_route, pay_mode, priority, pay_currency, exchange_rate, dd_charges, pay_amount, pay_amt_bef_round, roundoff_amt, pay_date, bank_cash_code, relpay_ou, reason_code, remarks, rev_remarks, rev_date, notype_no, supp_area, supp_doc_no, supp_doc_date, supp_doc_amt, supp_prepay_acct, bank_cash_acct, status, batch_id, createdby, createddate, modifiedby, modifieddate, tcal_exclusive_amt, tcal_status, voucher_amount, ibe_flag, workflow_status, tr_flag, surnotype_no, bank_amount, lgt_invoice_flag, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        COALESCE(cr.curr_key,-1), COALESCE(v.vendor_key,-1),s.ou_id, s.voucher_no, s.tran_type, s.ptimestamp, s.voucher_type, s.request_date, s.fb_id, s.supp_code, s.payment_route, s.pay_mode, s.priority, s.pay_currency, s.exchange_rate, s.dd_charges, s.pay_amount, s.pay_amt_bef_round, s.roundoff_amt, s.pay_date, s.bank_cash_code, s.relpay_ou, s.reason_code, s.remarks, s.rev_remarks, s.rev_date, s.notype_no, s.supp_area, s.supp_doc_no, s.supp_doc_date, s.supp_doc_amt, s.supp_prepay_acct, s.bank_cash_acct, s.status, s.batch_id, s.createdby, s.createddate, s.modifiedby, s.modifieddate, s.tcal_exclusive_amt, s.tcal_status, s.voucher_amount, s.ibe_flag, s.workflow_status, s.tr_flag, s.surnotype_no, s.bank_amount, s.lgt_invoice_flag, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_spy_prepay_vch_hdr s
	LEFT JOIN dwh.d_currency cr
		ON  s.pay_currency		  = cr.iso_curr_code
	LEFT JOIN dwh.d_vendor v
		ON  s.supp_code 	  	  = v.vendor_id
		AND s.ou_id			  	  = v.vendor_ou		
    LEFT JOIN dwh.F_spyprepayvchhdr t
    ON s.ou_id = t.ou_id
    AND s.voucher_no = t.voucher_no
    AND s.tran_type = t.tran_type
    AND s.ptimestamp = t.ptimestamp
    AND s.lgt_invoice_flag = t.lgt_invoice_flag
    WHERE t.ou_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

		INSERT INTO raw.raw_spy_prepay_vch_hdr
		(
			ou_id, voucher_no, tran_type, ptimestamp, voucher_type, request_date, fb_id, supp_code, payment_route, pay_mode, priority, pay_currency, exchange_rate, dd_charges, pay_amount, pay_amt_bef_round, roundoff_amt, par_exchange_rate, pay_date, bank_cash_code, relpay_ou, reason_code, hld_reason_code, remarks, hld_remarks, rev_remarks, rev_date, notype_no, supp_area, supp_doc_no, supp_doc_date, supp_doc_amt, supp_prepay_acct, bank_cash_acct, supp_receipt_no, receipt_date, status, batch_id, createdby, createddate, modifiedby, modifieddate, tcal_exclusive_amt, total_tcal_amount, tcal_status, voucher_amount, ibe_flag, consistency_stamp, lcnumber, refid, workflow_status, tr_flag, tr_percent, tr_amount, tr_tenure, tr_duedate, receipt_no, surnotype_no, BankCurrency, crosscur_erate, bank_amount, bank_base_amount, project_ou, Project_code, afe_number, job_number, auto_gen_flag, trnsfr_inv_no, trnsfr_inv_date, trnsfr_inv_ou, lgt_invoice_flag, lgt_rev_guid, etlcreateddatetime
		)
		SELECT
			ou_id, voucher_no, tran_type, ptimestamp, voucher_type, request_date, fb_id, supp_code, payment_route, pay_mode, priority, pay_currency, exchange_rate, dd_charges, pay_amount, pay_amt_bef_round, roundoff_amt, par_exchange_rate, pay_date, bank_cash_code, relpay_ou, reason_code, hld_reason_code, remarks, hld_remarks, rev_remarks, rev_date, notype_no, supp_area, supp_doc_no, supp_doc_date, supp_doc_amt, supp_prepay_acct, bank_cash_acct, supp_receipt_no, receipt_date, status, batch_id, createdby, createddate, modifiedby, modifieddate, tcal_exclusive_amt, total_tcal_amount, tcal_status, voucher_amount, ibe_flag, consistency_stamp, lcnumber, refid, workflow_status, tr_flag, tr_percent, tr_amount, tr_tenure, tr_duedate, receipt_no, surnotype_no, BankCurrency, crosscur_erate, bank_amount, bank_base_amount, project_ou, Project_code, afe_number, job_number, auto_gen_flag, trnsfr_inv_no, trnsfr_inv_date, trnsfr_inv_ou, lgt_invoice_flag, lgt_rev_guid, etlcreateddatetime
		FROM stg.stg_spy_prepay_vch_hdr;
    
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