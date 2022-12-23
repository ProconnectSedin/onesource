CREATE PROCEDURE dwh.usp_f_cidochdr(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
    FROM stg.stg_ci_doc_hdr;

    UPDATE dwh.F_cidochdr t
    SET
        company_key					= COALESCE(c.company_key,-1),
        curr_key					= COALESCE(cr.curr_key,-1),
        customer_key				= COALESCE(cs.customer_key,-1),
        fb_key						= -1,
        lo_id                      	= s.lo_id,
        batch_id                   	= s.batch_id,
        fb_id                      	= s.fb_id,
        cust_code                  	= s.cust_code,
        tran_currency              	= s.tran_currency,
        tran_amount                	= s.tran_amount,
        basecur_erate              	= s.basecur_erate,
        par_exchange_rate          	= s.par_exchange_rate,
        doc_status                 	= s.doc_status,
        instr_no                   	= s.instr_no,
        instr_date                 	= s.instr_date,
        instr_status               	= s.instr_status,
        createdby                  	= s.createdby,
        createddate                	= s.createddate,
        modifiedby                 	= s.modifiedby,
        modifieddate               	= s.modifieddate,
        pay_term                   	= s.pay_term,
        due_amount                 	= s.due_amount,
        received_amount            	= s.received_amount,
        adjusted_amount            	= s.adjusted_amount,
        discount_amount            	= s.discount_amount,
        discount_availed           	= s.discount_availed,
        penalty_amount             	= s.penalty_amount,
        write_off_amount           	= s.write_off_amount,
        write_back_amount          	= s.write_back_amount,
        paid_amount                	= s.paid_amount,
        reversed_docno             	= s.reversed_docno,
        reversal_date              	= s.reversal_date,
        adjustment_status          	= s.adjustment_status,
        provision_amount_cm        	= s.provision_amount_cm,
        tran_date                  	= s.tran_date,
        company_code               	= s.company_code,
        ibe_flag                   	= s.ibe_flag,
        base_amount                	= s.base_amount,
        par_base_amount            	= s.par_base_amount,
        report_flag                	= s.report_flag,
        Realization_Date           	= s.Realization_Date,
        otc_flag                   	= s.otc_flag,
        etlactiveind               	= 1,
        etljobname                 	= p_etljobname,
        envsourcecd                	= p_envsourcecd,
        datasourcecd               	= p_datasourcecd,
        etlupdatedatetime          	= NOW()
    FROM stg.stg_ci_doc_hdr s
	LEFT JOIN dwh.d_company c
		ON  s.company_code			= c.company_code
	LEFT JOIN dwh.d_currency cr
		ON  s.tran_currency			= cr.iso_curr_code
	LEFT JOIN dwh.d_customer cs
		ON  s.cust_code				= cs.customer_id	
		AND s.tran_ou				= cs.customer_ou	
-- 	LEFT JOIN dwh.d_financebook f
-- 		ON  s.fb_id					= f.fb_id 
   WHERE t.tran_ou 					= s.tran_ou
    AND t.tran_type 				= s.tran_type
    AND t.tran_no 					= s.tran_no
    AND t.ctimestamp 				= s.ctimestamp;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_cidochdr
    (
        company_key, curr_key, customer_key, fb_key,tran_ou, tran_type, tran_no, ctimestamp, lo_id, batch_id, fb_id, cust_code, tran_currency, tran_amount, basecur_erate, par_exchange_rate, doc_status, instr_no, instr_date, instr_status, createdby, createddate, modifiedby, modifieddate, pay_term, due_amount, received_amount, adjusted_amount, discount_amount, discount_availed, penalty_amount, write_off_amount, write_back_amount, paid_amount, reversed_docno, reversal_date, adjustment_status, provision_amount_cm, tran_date, company_code, ibe_flag, base_amount, par_base_amount, report_flag, Realization_Date, otc_flag, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        COALESCE(c.company_key,-1),COALESCE(cr.curr_key,-1),COALESCE(cs.customer_key,-1),-1,s.tran_ou, s.tran_type, s.tran_no, s.ctimestamp, s.lo_id, s.batch_id, s.fb_id, s.cust_code, s.tran_currency, s.tran_amount, s.basecur_erate, s.par_exchange_rate, s.doc_status, s.instr_no, s.instr_date, s.instr_status, s.createdby, s.createddate, s.modifiedby, s.modifieddate, s.pay_term, s.due_amount, s.received_amount, s.adjusted_amount, s.discount_amount, s.discount_availed, s.penalty_amount, s.write_off_amount, s.write_back_amount, s.paid_amount, s.reversed_docno, s.reversal_date, s.adjustment_status, s.provision_amount_cm, s.tran_date, s.company_code, s.ibe_flag, s.base_amount, s.par_base_amount, s.report_flag, s.Realization_Date, s.otc_flag, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_ci_doc_hdr s
	LEFT JOIN dwh.d_company c
		ON  s.company_code			= c.company_code
	LEFT JOIN dwh.d_currency cr
		ON  s.tran_currency			= cr.iso_curr_code
	LEFT JOIN dwh.d_customer cs
		ON  s.cust_code				= cs.customer_id	
		AND s.tran_ou				= cs.customer_ou	
-- 	LEFT JOIN dwh.d_financebook f
-- 		ON  s.fb_id					= f.fb_id	
    LEFT JOIN dwh.F_cidochdr t
    ON s.tran_ou = t.tran_ou
    AND s.tran_type = t.tran_type
    AND s.tran_no = t.tran_no
    AND s.ctimestamp = t.ctimestamp
    WHERE t.tran_ou IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_ci_doc_hdr
    (
        tran_ou, tran_type, tran_no, ctimestamp, lo_id, batch_id, fb_id, cust_code, tran_currency, tran_amount, basecur_erate, par_exchange_rate, doc_status, instr_no, instr_date, instr_status, reason_code, ps_gen_flag, createdby, createddate, modifiedby, modifieddate, pay_term, due_amount, received_amount, adjusted_amount, discount_amount, discount_availed, penalty_amount, write_off_amount, write_back_amount, paid_amount, reversed_docno, reversal_date, adjustment_status, provision_amount_cm, tran_date, company_code, bank_code, payterm_version, transfer_status, vat_incorporate_flag, intbanktran_status, cust_companycode, cust_bank_ref, cust_bank_acct, ibe_flag, base_amount, par_base_amount, lcnumber, refid, lc_applicable, BookingNo, MasterBillOfLadingNo, BillOfLadingNo, pdc_status, ims_flag, scheme_code, project_ou, Project_code, pdc_flag, report_flag, Realization_Date, address_id, otc_flag, etlcreateddatetime
    )
    SELECT
        tran_ou, tran_type, tran_no, ctimestamp, lo_id, batch_id, fb_id, cust_code, tran_currency, tran_amount, basecur_erate, par_exchange_rate, doc_status, instr_no, instr_date, instr_status, reason_code, ps_gen_flag, createdby, createddate, modifiedby, modifieddate, pay_term, due_amount, received_amount, adjusted_amount, discount_amount, discount_availed, penalty_amount, write_off_amount, write_back_amount, paid_amount, reversed_docno, reversal_date, adjustment_status, provision_amount_cm, tran_date, company_code, bank_code, payterm_version, transfer_status, vat_incorporate_flag, intbanktran_status, cust_companycode, cust_bank_ref, cust_bank_acct, ibe_flag, base_amount, par_base_amount, lcnumber, refid, lc_applicable, BookingNo, MasterBillOfLadingNo, BillOfLadingNo, pdc_status, ims_flag, scheme_code, project_ou, Project_code, pdc_flag, report_flag, Realization_Date, address_id, otc_flag, etlcreateddatetime
    FROM stg.stg_ci_doc_hdr;
    
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