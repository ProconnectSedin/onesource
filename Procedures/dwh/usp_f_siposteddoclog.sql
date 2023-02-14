-- PROCEDURE: dwh.usp_f_siposteddoclog(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_siposteddoclog(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_siposteddoclog(
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
    FROM stg.stg_si_posted_doc_log;

    UPDATE dwh.F_siposteddocLog t
    SET
		si_posted_doc_log_curr_key		 =	COALESCE(cu.curr_key,-1),
		si_posted_doc_log_opcoa_key	 =	COALESCE(ac.opcoa_key,-1),
		si_posted_doc_log_vendor_key	 =	COALESCE(v.vendor_key,-1),
		si_posted_doc_log_date_key		 =	COALESCE(d.datekey,-1),
        tran_ou                      = s.tran_ou,
        tran_type                    = s.tran_type,
        tran_no                      = s.tran_no,
        term_no                      = s.term_no,
        amt_type                     = s.amt_type,
        dr_doc_ou                    = s.dr_doc_ou,
        dr_doc_type                  = s.dr_doc_type,
        dr_doc_no                    = s.dr_doc_no,
        cr_doc_ou                    = s.cr_doc_ou,
        cr_doc_type                  = s.cr_doc_type,
        cr_doc_no                    = s.cr_doc_no,
        cr_doc_term                  = s.cr_doc_term,
        dr_doc_term                  = s.dr_doc_term,
        lo_id                        = s.lo_id,
        tran_date                    = s.tran_date,
        supplier_code                = s.supplier_code,
        tran_currency                = s.tran_currency,
        tran_amount                  = s.tran_amount,
        basecur_erate                = s.basecur_erate,
        par_exchange_rate            = s.par_exchange_rate,
        par_base_amount              = s.par_base_amount,
        posting_status               = s.posting_status,
        posting_date                 = s.posting_date,
        batch_id                     = s.batch_id,
        cross_curr_erate             = s.cross_curr_erate,
        base_amount                  = s.base_amount,
        account_code                 = s.account_code,
        account_type                 = s.account_type,
        fb_id                        = s.fb_id,
        pay_mode                     = s.pay_mode,
        paid_amt                     = s.paid_amt,
        requested_amt                = s.requested_amt,
        discount_amt                 = s.discount_amt,
        penalty_amount               = s.penalty_amount,
        adjusted_amount              = s.adjusted_amount,
        disc_availed                 = s.disc_availed,
        check_no                     = s.check_no,
        base_adjusted_amount         = s.base_adjusted_amount,
        pbase_adjusted_amount        = s.pbase_adjusted_amount,
        log_pdc_flag                 = s.log_pdc_flag,
        pdc_void_flag                = s.pdc_void_flag,
        etlactiveind                 = 1,
        etljobname                   = p_etljobname,
        envsourcecd                  = p_envsourcecd,
        datasourcecd                 = p_datasourcecd,
        etlupdatedatetime            = NOW()
    FROM stg.stg_si_posted_doc_log s
	left join dwh.d_currency cu
	ON 	 s.tran_currency		 = cu.iso_curr_code
	left join dwh.d_date d
	ON s.posting_date::date = d.dateactual
	left join dwh.d_operationalaccountDetail ac
	ON s.account_code   	 = ac.account_code
	left join dwh.d_vendor v
	ON  s.supplier_code 	  	 = v.vendor_id
	AND s.tran_ou			 = v.vendor_ou
    WHERE t.tran_ou = s.tran_ou
    AND t.tran_type = s.tran_type
    AND t.tran_no = s.tran_no
    AND t.term_no = s.term_no
    AND t.amt_type = s.amt_type
    AND t.dr_doc_ou = s.dr_doc_ou
    AND t.dr_doc_type = s.dr_doc_type
    AND t.dr_doc_no = s.dr_doc_no
    AND t.cr_doc_ou = s.cr_doc_ou
    AND t.cr_doc_type = s.cr_doc_type
    AND t.cr_doc_no = s.cr_doc_no
    AND t.cr_doc_term = s.cr_doc_term
    AND t.dr_doc_term = s.dr_doc_term
    AND t.account_type = s.account_type;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_siposteddocLog
    (
       si_posted_doc_log_curr_key, si_posted_doc_log_opcoa_key, si_posted_doc_log_vendor_key, si_posted_doc_log_date_key, tran_ou, tran_type, tran_no, term_no, amt_type, dr_doc_ou, dr_doc_type, dr_doc_no, cr_doc_ou, cr_doc_type, cr_doc_no, cr_doc_term, dr_doc_term, lo_id, tran_date, supplier_code, tran_currency, tran_amount, basecur_erate, par_exchange_rate, par_base_amount, posting_status, posting_date, batch_id, cross_curr_erate, base_amount, account_code, account_type, fb_id, pay_mode, paid_amt, requested_amt, discount_amt, penalty_amount, adjusted_amount, disc_availed, check_no, base_adjusted_amount, pbase_adjusted_amount, log_pdc_flag, pdc_void_flag, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
      COALESCE(cu.curr_key,-1),COALESCE(ac.opcoa_key,-1), COALESCE(v.vendor_key,-1),COALESCE(d.datekey,-1), s.tran_ou, s.tran_type, s.tran_no, s.term_no, s.amt_type, s.dr_doc_ou, s.dr_doc_type, s.dr_doc_no, s.cr_doc_ou, s.cr_doc_type, s.cr_doc_no, s.cr_doc_term, s.dr_doc_term, s.lo_id, s.tran_date, s.supplier_code, s.tran_currency, s.tran_amount, s.basecur_erate, s.par_exchange_rate, s.par_base_amount, s.posting_status, s.posting_date, s.batch_id, s.cross_curr_erate, s.base_amount, s.account_code, s.account_type, s.fb_id, s.pay_mode, s.paid_amt, s.requested_amt, s.discount_amt, s.penalty_amount, s.adjusted_amount, s.disc_availed, s.check_no, s.base_adjusted_amount, s.pbase_adjusted_amount, s.log_pdc_flag, s.pdc_void_flag, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_si_posted_doc_log s
	left join dwh.d_currency cu
	ON 	 s.tran_currency		 = cu.iso_curr_code
	left join dwh.d_date d
	ON s.posting_date::date = d.dateactual
	left join dwh.d_operationalaccountDetail ac
	ON s.account_code   	 = ac.account_code
	left join dwh.d_vendor v
	ON  s.supplier_code 	  	 = v.vendor_id
	AND s.tran_ou			 = v.vendor_ou
    LEFT JOIN dwh.F_siposteddocLog t
    ON s.tran_ou = t.tran_ou
    AND s.tran_type = t.tran_type
    AND s.tran_no = t.tran_no
    AND s.term_no = t.term_no
    AND s.amt_type = t.amt_type
    AND s.dr_doc_ou = t.dr_doc_ou
    AND s.dr_doc_type = t.dr_doc_type
    AND s.dr_doc_no = t.dr_doc_no
    AND s.cr_doc_ou = t.cr_doc_ou
    AND s.cr_doc_type = t.cr_doc_type
    AND s.cr_doc_no = t.cr_doc_no
    AND s.cr_doc_term = t.cr_doc_term
    AND s.dr_doc_term = t.dr_doc_term
    AND s.account_type = t.account_type
    WHERE t.tran_ou IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_si_posted_doc_log
    (
        tran_ou, tran_type, tran_no, term_no, amt_type, dr_doc_ou, dr_doc_type, dr_doc_no, cr_doc_ou, cr_doc_type, cr_doc_no, cr_doc_term, dr_doc_term, lo_id, tran_date, supplier_code, tran_currency, tran_amount, exchange_rate, basecur_erate, par_exchange_rate, par_base_amount, posting_status, posting_date, batch_id, cross_curr_erate, base_amount, createdby, createddate, modifiedby, modifieddate, account_code, account_type, fb_id, pay_mode, paid_amt, requested_amt, discount_amt, penalty_amount, adjusted_amount, disc_availed, check_no, base_adjusted_amount, pbase_adjusted_amount, log_pdc_flag, pdc_void_flag, etlcreatedatetime
    )
    SELECT
        tran_ou, tran_type, tran_no, term_no, amt_type, dr_doc_ou, dr_doc_type, dr_doc_no, cr_doc_ou, cr_doc_type, cr_doc_no, cr_doc_term, dr_doc_term, lo_id, tran_date, supplier_code, tran_currency, tran_amount, exchange_rate, basecur_erate, par_exchange_rate, par_base_amount, posting_status, posting_date, batch_id, cross_curr_erate, base_amount, createdby, createddate, modifiedby, modifieddate, account_code, account_type, fb_id, pay_mode, paid_amt, requested_amt, discount_amt, penalty_amount, adjusted_amount, disc_availed, check_no, base_adjusted_amount, pbase_adjusted_amount, log_pdc_flag, pdc_void_flag, etlcreatedatetime
    FROM stg.stg_si_posted_doc_log;
    
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
ALTER PROCEDURE dwh.usp_f_siposteddoclog(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
