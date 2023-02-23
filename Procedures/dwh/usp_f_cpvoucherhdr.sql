-- PROCEDURE: dwh.usp_f_cpvoucherhdr(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_cpvoucherhdr(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_cpvoucherhdr(
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
    FROM stg.stg_cp_voucher_hdr;

    UPDATE dwh.F_cpvoucherhdr t
    SET
		cpvoucherhdr_customer_key   =  COALESCE(cu.customer_key, -1),
		account_code_key    =      COALESCE(acc.opcoa_key, -1),
        ou_id                     = s.ou_id,
        voucher_no                = s.voucher_no,
        tran_type                 = s.tran_type,
        timestamp                 = s.timestamp,
        pay_cat                   = s.pay_cat,
        req_date                  = s.req_date,
        business_unit             = s.business_unit,
        num_type                  = s.num_type,
        cus_reg_at                = s.cus_reg_at,
        cus_code                  = s.cus_code,
        pay_date                  = s.pay_date,
        pay_method                = s.pay_method,
        pay_mode                  = s.pay_mode,
        pay_route                 = s.pay_route,
        pay_cur                   = s.pay_cur,
        exch_rate                 = s.exch_rate,
        pay_amount                = s.pay_amount,
        bank_cash_code            = s.bank_cash_code,
        doc_ref                   = s.doc_ref,
        priority                  = s.priority,
        billing_pt                = s.billing_pt,
        relpay_pt                 = s.relpay_pt,
        el_pay                    = s.el_pay,
        elec_pay_applied          = s.elec_pay_applied,
        remarks                   = s.remarks,
        revreason_code            = s.revreason_code,
        rev_date                  = s.rev_date,
        status                    = s.status,
        batch_id                  = s.batch_id,
        pay_amt_bef_round         = s.pay_amt_bef_round,
        roundoff_amt              = s.roundoff_amt,
        hldrev_remarks            = s.hldrev_remarks,
        createdby                 = s.createdby,
        createddate               = s.createddate,
        modifiedby                = s.modifiedby,
        modifieddate              = s.modifieddate,
        tcal_status               = s.tcal_status,
        tcal_exclusive_amt        = s.tcal_exclusive_amt,
        acc_type                  = s.acc_type,
        cust_account_code         = s.cust_account_code,
        adjustment                = s.adjustment,
        final_settlement          = s.final_settlement,
        etlactiveind              = 1,
        etljobname                = p_etljobname,
        envsourcecd               = p_envsourcecd,
        datasourcecd              = p_datasourcecd,
        etlupdatedatetime         = NOW()
    FROM stg.stg_cp_voucher_hdr s
	LEFT JOIN dwh.d_customer cu
        ON      cu.customer_id          = s.cus_code
        AND cu.customer_ou              = s.ou_id
		LEFT JOIN dwh.d_operationalaccountdetail acc
        ON acc.account_code             = s.cust_account_code
    WHERE t.ou_id = s.ou_id
    AND t.voucher_no = s.voucher_no
    AND t.tran_type = s.tran_type;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_cpvoucherhdr
    (
        cpvoucherhdr_customer_key ,account_code_key,ou_id, voucher_no, tran_type, timestamp, pay_cat, req_date, business_unit, num_type, cus_reg_at, cus_code, pay_date, pay_method, pay_mode, pay_route, pay_cur, exch_rate, pay_amount, bank_cash_code, doc_ref, priority, billing_pt, relpay_pt, el_pay, elec_pay_applied, remarks, revreason_code, rev_date, status, batch_id, pay_amt_bef_round, roundoff_amt, hldrev_remarks, createdby, createddate, modifiedby, modifieddate, tcal_status, tcal_exclusive_amt, acc_type, cust_account_code, adjustment, final_settlement, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
         COALESCE(cu.customer_key, -1),COALESCE(acc.opcoa_key, -1),s.ou_id, s.voucher_no, s.tran_type, s.timestamp, s.pay_cat, s.req_date, s.business_unit, s.num_type, s.cus_reg_at, s.cus_code, s.pay_date, s.pay_method, s.pay_mode, s.pay_route, s.pay_cur, s.exch_rate, s.pay_amount, s.bank_cash_code, s.doc_ref, s.priority, s.billing_pt, s.relpay_pt, s.el_pay, s.elec_pay_applied, s.remarks, s.revreason_code, s.rev_date, s.status, s.batch_id, s.pay_amt_bef_round, s.roundoff_amt, s.hldrev_remarks, s.createdby, s.createddate, s.modifiedby, s.modifieddate, s.tcal_status, s.tcal_exclusive_amt, s.acc_type, s.cust_account_code, s.adjustment, s.final_settlement, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_cp_voucher_hdr s
	
	LEFT JOIN dwh.d_customer cu
        ON      cu.customer_id          = s.cus_code
        AND cu.customer_ou              = s.ou_id
		LEFT JOIN dwh.d_operationalaccountdetail acc
        ON acc.account_code             = s.cust_account_code
    LEFT JOIN dwh.F_cpvoucherhdr t
    ON s.ou_id = t.ou_id
    AND s.voucher_no = t.voucher_no
    AND s.tran_type = t.tran_type
    WHERE t.ou_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_cp_voucher_hdr
    (
        ou_id, voucher_no, tran_type, timestamp, pay_cat, req_date, business_unit, num_type, cus_reg_at, cus_code, pay_date, pay_method, pay_mode, pay_route, pay_cur, exch_rate, pay_amount, bank_cash_code, bank_charges, doc_ref, priority, billing_pt, relpay_pt, reason_code, el_pay, elec_pay_applied, remarks, hldreason_code, revreason_code, rev_date, esr_partid, esr_ref, esr_codingline, lsv_contid, lsv_ref, cust_acct_in, cust_account, el_bank_pttcode, el_bank_id, cust_bank_acct, status, batch_id, pay_amt_bef_round, roundoff_amt, par_exchange_rate, hldrev_remarks, createdby, createddate, modifiedby, modifieddate, doc_status, tcal_status, total_tcal_amount, tcal_exclusive_amt, dig_ref_no, elecslip_ref_no, acc_type, cust_account_code, rebate_voucher, ibe_flag, consistency_stamp, pdc_status, payee_name, ims_flag, scheme_code, workflow_status, adjustment, ict_flag, final_settlement, gen_from, etlcreateddatetime
    )
    SELECT
        ou_id, voucher_no, tran_type, timestamp, pay_cat, req_date, business_unit, num_type, cus_reg_at, cus_code, pay_date, pay_method, pay_mode, pay_route, pay_cur, exch_rate, pay_amount, bank_cash_code, bank_charges, doc_ref, priority, billing_pt, relpay_pt, reason_code, el_pay, elec_pay_applied, remarks, hldreason_code, revreason_code, rev_date, esr_partid, esr_ref, esr_codingline, lsv_contid, lsv_ref, cust_acct_in, cust_account, el_bank_pttcode, el_bank_id, cust_bank_acct, status, batch_id, pay_amt_bef_round, roundoff_amt, par_exchange_rate, hldrev_remarks, createdby, createddate, modifiedby, modifieddate, doc_status, tcal_status, total_tcal_amount, tcal_exclusive_amt, dig_ref_no, elecslip_ref_no, acc_type, cust_account_code, rebate_voucher, ibe_flag, consistency_stamp, pdc_status, payee_name, ims_flag, scheme_code, workflow_status, adjustment, ict_flag, final_settlement, gen_from, etlcreateddatetime
    FROM stg.stg_cp_voucher_hdr;
    
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
ALTER PROCEDURE dwh.usp_f_cpvoucherhdr(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
