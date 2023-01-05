-- PROCEDURE: dwh.usp_f_snpvoucherhdr(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_snpvoucherhdr(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_snpvoucherhdr(
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
    FROM stg.stg_snp_voucher_hdr;

    UPDATE dwh.F_snpvoucherhdr t
    SET
		curr_key					= COALESCE(cr.curr_key,-1),
        fb_id                       = s.fb_id,
        notype_no                   = s.notype_no,
        request_date                = s.request_date,
        payee_name                  = s.payee_name,
        pay_date                    = s.pay_date,
        elec_payment                = s.elec_payment,
        pay_currency                = s.pay_currency,
        exchange_rate               = s.exchange_rate,
        pay_amount_bef_roff         = s.pay_amount_bef_roff,
        pay_amount                  = s.pay_amount,
        roundoff_amount             = s.roundoff_amount,
        pay_method                  = s.pay_method,
        payment_route               = s.payment_route,
        pay_mode                    = s.pay_mode,
        bank_cash_code              = s.bank_cash_code,
        relpay_ou                   = s.relpay_ou,
        instr_charge                = s.instr_charge,
        priority                    = s.priority,
        remarks                     = s.remarks,
        hr_reason_code              = s.hr_reason_code,
        reversal_reason_code        = s.reversal_reason_code,
        reversal_date               = s.reversal_date,
        reversal_remarks            = s.reversal_remarks,
        address1                    = s.address1,
        city                        = s.city,
        state                       = s.state,
        country                     = s.country,
        zip_code                    = s.zip_code,
        batch_id                    = s.batch_id,
        voucher_status              = s.voucher_status,
        refdoc_no                   = s.refdoc_no,
        createdby                   = s.createdby,
        createddate                 = s.createddate,
        modifiedby                  = s.modifiedby,
        modifieddate                = s.modifieddate,
        tcal_status                 = s.tcal_status,
        total_tcal_amount           = s.total_tcal_amount,
        tcal_exclusive_amt          = s.tcal_exclusive_amt,
        receipt_route               = s.receipt_route,
        auto_gen_flag               = s.auto_gen_flag,
        receipt_ou                  = s.receipt_ou,
        workflow_status             = s.workflow_status,
        recon_reqflg                = s.recon_reqflg,
		vtimestamp 					= s.vtimestamp,
    	ifb_flag 					= s.ifb_flag,		
        etlactiveind                = 1,
        etljobname                  = p_etljobname,
        envsourcecd                 = p_envsourcecd,
        datasourcecd                = p_datasourcecd,
        etlupdatedatetime           = NOW()
    FROM stg.stg_snp_voucher_hdr s
	LEFT JOIN dwh.d_currency cr
		ON  s.pay_currency			= cr.iso_curr_code	
    WHERE t.ou_id = s.ou_id
    AND t.voucher_no = s.voucher_no
    AND t.voucher_type = s.voucher_type
    AND t.tran_type = s.tran_type;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_snpvoucherhdr
    (
        curr_key,ou_id, voucher_no, voucher_type, tran_type, vtimestamp, fb_id, notype_no, request_date, payee_name, pay_date, elec_payment, pay_currency, exchange_rate, pay_amount_bef_roff, pay_amount, roundoff_amount, pay_method, payment_route, pay_mode, bank_cash_code, relpay_ou, instr_charge, priority, remarks, hr_reason_code, reversal_reason_code, reversal_date, reversal_remarks, address1, city, state, country, zip_code, batch_id, voucher_status, refdoc_no, createdby, createddate, modifiedby, modifieddate, tcal_status, total_tcal_amount, tcal_exclusive_amt, receipt_route, auto_gen_flag, receipt_ou, workflow_status, recon_reqflg, ifb_flag, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        COALESCE(cr.curr_key,-1),s.ou_id, s.voucher_no, s.voucher_type, s.tran_type, s.vtimestamp, s.fb_id, s.notype_no, s.request_date, s.payee_name, s.pay_date, s.elec_payment, s.pay_currency, s.exchange_rate, s.pay_amount_bef_roff, s.pay_amount, s.roundoff_amount, s.pay_method, s.payment_route, s.pay_mode, s.bank_cash_code, s.relpay_ou, s.instr_charge, s.priority, s.remarks, s.hr_reason_code, s.reversal_reason_code, s.reversal_date, s.reversal_remarks, s.address1, s.city, s.state, s.country, s.zip_code, s.batch_id, s.voucher_status, s.refdoc_no, s.createdby, s.createddate, s.modifiedby, s.modifieddate, s.tcal_status, s.total_tcal_amount, s.tcal_exclusive_amt, s.receipt_route, s.auto_gen_flag, s.receipt_ou, s.workflow_status, s.recon_reqflg, s.ifb_flag, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_snp_voucher_hdr s
	LEFT JOIN dwh.d_currency cr
		ON  s.pay_currency		= cr.iso_curr_code	
    LEFT JOIN dwh.F_snpvoucherhdr t
    ON s.ou_id = t.ou_id
    AND s.voucher_no = t.voucher_no
    AND s.voucher_type = t.voucher_type
    AND s.tran_type = t.tran_type
    WHERE t.ou_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_snp_voucher_hdr
    (
        ou_id, voucher_no, voucher_type, tran_type, vtimestamp, fb_id, notype_no, request_date, payee_name, pay_date, elec_payment, pay_currency, exchange_rate, pay_amount_bef_roff, pay_amount, roundoff_amount, pay_method, payment_route, pay_mode, bank_cash_code, relpay_ou, instr_charge, priority, remarks, hr_reason_code, hr_remarks, reversal_reason_code, reversal_date, reversal_remarks, address1, address2, address3, city, state, country, zip_code, contact, url, mail_stop, pager_no, email_id, telex, phone_no, mobile_no, fax_no, lsv_id, lsv_reference, bank_code, partid_digits, esr_id, refno_digits, esr_reference, esr_amount, esr_code_line, payee_accountin, payee_bankrefno, payee_accountcode, comp_accountin, comp_bankref, comp_accountcode, template_no, cap_charge, batch_id, voucher_status, refdoc_no, refdoc_type, pbcexchrate, createdby, createddate, modifiedby, modifieddate, doc_status, contract_ref, elec_applied, iban_no, tcal_status, total_tcal_amount, tcal_exclusive_amt, receipt_route, auto_gen_flag, consistency_stamp, receipt_ou, workflow_status, recon_reqflg, afe_number, job_number, project_ou, Project_code, costcenter_hdr, workflow_error, ifb_flag, etlcreateddatetime
    )
    SELECT
        ou_id, voucher_no, voucher_type, tran_type, vtimestamp, fb_id, notype_no, request_date, payee_name, pay_date, elec_payment, pay_currency, exchange_rate, pay_amount_bef_roff, pay_amount, roundoff_amount, pay_method, payment_route, pay_mode, bank_cash_code, relpay_ou, instr_charge, priority, remarks, hr_reason_code, hr_remarks, reversal_reason_code, reversal_date, reversal_remarks, address1, address2, address3, city, state, country, zip_code, contact, url, mail_stop, pager_no, email_id, telex, phone_no, mobile_no, fax_no, lsv_id, lsv_reference, bank_code, partid_digits, esr_id, refno_digits, esr_reference, esr_amount, esr_code_line, payee_accountin, payee_bankrefno, payee_accountcode, comp_accountin, comp_bankref, comp_accountcode, template_no, cap_charge, batch_id, voucher_status, refdoc_no, refdoc_type, pbcexchrate, createdby, createddate, modifiedby, modifieddate, doc_status, contract_ref, elec_applied, iban_no, tcal_status, total_tcal_amount, tcal_exclusive_amt, receipt_route, auto_gen_flag, consistency_stamp, receipt_ou, workflow_status, recon_reqflg, afe_number, job_number, project_ou, Project_code, costcenter_hdr, workflow_error, ifb_flag, etlcreateddatetime
    FROM stg.stg_snp_voucher_hdr;
    
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
ALTER PROCEDURE dwh.usp_f_snpvoucherhdr(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
