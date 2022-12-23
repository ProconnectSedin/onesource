CREATE PROCEDURE dwh.usp_f_sidochdr(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
    FROM stg.stg_si_doc_hdr;

    UPDATE dwh.F_sidochdr t
    SET
		sidochdr_vendor_key			 = COALESCE(v.vendor_key,-1),
		sidochdr_currency_key		 = COALESCE(cu.curr_key,-1),
        transfer_status              = s.transfer_status,
        bankcashcode                 = s.bankcashcode,
        batch_id                     = s.batch_id,
        vat_incorporate_flag         = s.vat_incorporate_flag,
        tran_date                    = s.tran_date,
        lo_id                        = s.lo_id,
        fb_id                        = s.fb_id,
        tran_currency                = s.tran_currency,
        supplier_code                = s.supplier_code,
        pay_term                     = s.pay_term,
        payterm_version              = s.payterm_version,
        tran_amount                  = s.tran_amount,
        exchange_rate                = s.exchange_rate,
        base_amount                  = s.base_amount,
        par_exchange_rate            = s.par_exchange_rate,
        par_base_amount              = s.par_base_amount,
        doc_status                   = s.doc_status,
        reversed_docno               = s.reversed_docno,
        reversal_date                = s.reversal_date,
        checkseries_no               = s.checkseries_no,
        check_no                     = s.check_no,
        bank_code                    = s.bank_code,
        paid_status                  = s.paid_status,
        vat_applicable               = s.vat_applicable,
        average_vat_rate             = s.average_vat_rate,
        discount_proportional        = s.discount_proportional,
        discount_amount              = s.discount_amount,
        discount_availed             = s.discount_availed,
        penalty_amount               = s.penalty_amount,
        paid_amount                  = s.paid_amount,
        requested_amount             = s.requested_amount,
        adjusted_amount              = s.adjusted_amount,
        supp_ou                      = s.supp_ou,
        reversed_docou               = s.reversed_docou,
        supp_name                    = s.supp_name,
        supp_inv_no                  = s.supp_inv_no,
        remarks                      = s.remarks,
        createdby                    = s.createdby,
        createddate                  = s.createddate,
        modifiedby                   = s.modifiedby,
        modifieddate                 = s.modifieddate,
        cap_amount                   = s.cap_amount,
        supp_invoice_date            = s.supp_invoice_date,
        component_id                 = s.component_id,
        ibe_flag                     = s.ibe_flag,
        pay_to_supp                  = s.pay_to_supp,
        pay_mode                     = s.pay_mode,
        pay_priority                 = s.pay_priority,
        apply_sr                     = s.apply_sr,
        pay_method                   = s.pay_method,
        pdcflag                      = s.pdcflag,
        report_flag                  = s.report_flag,
        etlactiveind                 = 1,
        etljobname                   = p_etljobname,
        envsourcecd                  = p_envsourcecd,
        datasourcecd                 = p_datasourcecd,
        etlupdatedatetime            = NOW()
    FROM stg.stg_si_doc_hdr s
	LEFT JOIN dwh.d_vendor v
	ON v.vendor_id = s.supplier_code
	and v.vendor_ou = s.tran_ou
	LEFT JOIN dwh.d_currency cu
	ON cu.iso_curr_code = s.tran_currency
	WHERE t.tran_ou = s.tran_ou
    AND t.tran_type = s.tran_type
    AND t.tran_no = s.tran_no
    AND t.s_timestamp = s.timestamp;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_sidochdr
    (	sidochdr_vendor_key, sidochdr_currency_key,
        tran_ou, tran_type, tran_no, s_timestamp, transfer_status, 
		bankcashcode, batch_id, vat_incorporate_flag, tran_date, lo_id, 
		fb_id, tran_currency, supplier_code, pay_term, payterm_version, 
		tran_amount, exchange_rate, base_amount, par_exchange_rate, par_base_amount, 
		doc_status, reversed_docno, reversal_date, checkseries_no, check_no, 
		bank_code, paid_status, vat_applicable, average_vat_rate, discount_proportional, 
		discount_amount, discount_availed, penalty_amount, paid_amount, requested_amount, 
		adjusted_amount, supp_ou, reversed_docou, supp_name, supp_inv_no, 
		remarks, createdby, createddate, modifiedby, modifieddate, 
		cap_amount, supp_invoice_date, component_id, ibe_flag, pay_to_supp, 
		pay_mode, pay_priority, apply_sr, pay_method, pdcflag, 
		report_flag, 
		etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
		COALESCE(v.vendor_key,-1), COALESCE(cu.curr_key,-1),
        s.tran_ou, s.tran_type, s.tran_no, s.timestamp, s.transfer_status, 
		s.bankcashcode, s.batch_id, s.vat_incorporate_flag, s.tran_date, s.lo_id, 
		s.fb_id, s.tran_currency, s.supplier_code, s.pay_term, s.payterm_version, 
		s.tran_amount, s.exchange_rate, s.base_amount, s.par_exchange_rate, s.par_base_amount,
		s.doc_status, s.reversed_docno, s.reversal_date, s.checkseries_no, s.check_no, 
		s.bank_code, s.paid_status, s.vat_applicable, s.average_vat_rate, s.discount_proportional, 
		s.discount_amount, s.discount_availed, s.penalty_amount, s.paid_amount, s.requested_amount, 
		s.adjusted_amount, s.supp_ou, s.reversed_docou, s.supp_name, s.supp_inv_no, 
		s.remarks, s.createdby, s.createddate, s.modifiedby, s.modifieddate, 
		s.cap_amount, s.supp_invoice_date, s.component_id, s.ibe_flag, s.pay_to_supp, 
		s.pay_mode, s.pay_priority, s.apply_sr, s.pay_method, s.pdcflag, 
		s.report_flag, 
		1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_si_doc_hdr s
	LEFT JOIN dwh.d_vendor v
	ON v.vendor_id = s.supplier_code
	and v.vendor_ou = s.tran_ou
	LEFT JOIN dwh.d_currency cu
	ON cu.iso_curr_code = s.tran_currency
    LEFT JOIN dwh.F_sidochdr t
    ON s.tran_ou = t.tran_ou
    AND s.tran_type = t.tran_type
    AND s.tran_no = t.tran_no
    AND s.timestamp = t.s_timestamp
    WHERE t.tran_ou IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_si_doc_hdr
    (
        tran_ou, tran_type, tran_no, timestamp, transfer_status, bankcashcode, batch_id, vat_incorporate_flag, tran_date, lo_id, fb_id, tran_currency, supplier_code, pay_term, payterm_version, tran_amount, exchange_rate, base_amount, par_exchange_rate, par_base_amount, doc_status, reversed_docno, reversal_date, checkseries_no, check_no, bank_code, paid_status, vat_applicable, average_vat_rate, discount_proportional, discount_amount, discount_availed, penalty_amount, paid_amount, requested_amount, adjusted_amount, supp_ou, reversed_docou, supp_name, supp_inv_no, remarks, intbanktran_status, createdby, createddate, modifiedby, modifieddate, cap_amount, supp_invoice_date, component_id, ibe_flag, pay_to_supp, pay_mode, pay_priority, apply_sr, pay_method, lcnumber, refid, pdcflag, tr_amount, tr_redeemed_amt, tr_duedate, project_ou, Project_code, recon_flag, report_flag, etlcreateddatetime
    )
    SELECT
        tran_ou, tran_type, tran_no, timestamp, transfer_status, bankcashcode, batch_id, vat_incorporate_flag, tran_date, lo_id, fb_id, tran_currency, supplier_code, pay_term, payterm_version, tran_amount, exchange_rate, base_amount, par_exchange_rate, par_base_amount, doc_status, reversed_docno, reversal_date, checkseries_no, check_no, bank_code, paid_status, vat_applicable, average_vat_rate, discount_proportional, discount_amount, discount_availed, penalty_amount, paid_amount, requested_amount, adjusted_amount, supp_ou, reversed_docou, supp_name, supp_inv_no, remarks, intbanktran_status, createdby, createddate, modifiedby, modifieddate, cap_amount, supp_invoice_date, component_id, ibe_flag, pay_to_supp, pay_mode, pay_priority, apply_sr, pay_method, lcnumber, refid, pdcflag, tr_amount, tr_redeemed_amt, tr_duedate, project_ou, Project_code, recon_flag, report_flag, etlcreateddatetime
    FROM stg.stg_si_doc_hdr;
    
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