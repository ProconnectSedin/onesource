-- PROCEDURE: dwh.usp_f_sidocbalance(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_sidocbalance(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_sidocbalance(
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
    FROM stg.stg_si_doc_balance;

    UPDATE dwh.f_sidocbalance t
    SET
		si_doc_balance_curr_key		 =	COALESCE(cu.curr_key,-1),
		si_doc_balance_opcoa_key	 =	COALESCE(ac.opcoa_key,-1),
		si_doc_balance_vendor_key	 =	COALESCE(v.vendor_key,-1),
		si_doc_balance_date_key		 =	COALESCE(d.datekey,-1),
        tran_ou                      = s.tran_ou,
        tran_type                    = s.tran_type,
        tran_no                      = s.tran_no,
        term_no                      = s.term_no,
        lo_id                        = s.lo_id,
        tran_currency                = s.tran_currency,
        tran_amount                  = s.tran_amount,
        exchange_rate                = s.exchange_rate,
        base_amount                  = s.base_amount,
        par_exchange_rate            = s.par_exchange_rate,
        par_base_amount              = s.par_base_amount,
        doc_status                   = s.doc_status,
        adjustment_status            = s.adjustment_status,
        discount_amount              = s.discount_amount,
        disc_availed                 = s.disc_availed,
        penalty_amount               = s.penalty_amount,
        paid_amt                     = s.paid_amt,
        requested_amount             = s.requested_amount,
        adjusted_amount              = s.adjusted_amount,
        batch_id                     = s.batch_id,
        due_date                     = s.due_date,
        discount_date                = s.discount_date,
        account_code                 = s.account_code,
        account_type                 = s.account_type,
        supp_code                    = s.supp_code,
        fb_id                        = s.fb_id,
        tran_date                    = s.tran_date,
        outstanding_amt              = s.outstanding_amt,
        posting_date                 = s.posting_date,
        base_outstanding_amt         = s.base_outstanding_amt,
        pbase_outstanding_amt        = s.pbase_outstanding_amt,
        base_adjusted_amount         = s.base_adjusted_amount,
        pbase_adjusted_amount        = s.pbase_adjusted_amount,
        base_paid_amt                = s.base_paid_amt,
        pbase_paid_amt               = s.pbase_paid_amt,
        disc_amount_type             = s.disc_amount_type,
        disc_percent                 = s.disc_percent,
        penalty_percent              = s.penalty_percent,
        pdc_flag                     = s.pdc_flag,
        pdc_void_flag                = s.pdc_void_flag,
        instr_no                     = s.instr_no,
        etlactiveind                 = 1,
        etljobname                   = p_etljobname,
        envsourcecd                  = p_envsourcecd,
        datasourcecd                 = p_datasourcecd,
        etlupdatedatetime            = NOW()
    FROM stg.stg_si_doc_balance s
	LEFT JOIN dwh.d_operationalaccountDetail ac
	ON  	s.account_code   	 = ac.account_code
	LEFT JOIN dwh.d_currency cu 
		ON  s.tran_currency		 = cu.iso_curr_code
    LEFT JOIN dwh.d_date d 		
		ON  s.posting_date::date = d.dateactual
	LEFT JOIN dwh.d_vendor v 		
		ON  s.supp_code 	  	 = v.vendor_id
		AND s.tran_ou			 = v.vendor_ou 
    WHERE t.tran_ou 			 = s.tran_ou
    AND   t.tran_type 			 = s.tran_type
    AND   t.tran_no 			 = s.tran_no
    AND   t.term_no 			 = s.term_no
    AND   t.account_type         = s.account_type;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.f_sidocbalance
    (
		si_doc_balance_curr_key,	si_doc_balance_opcoa_key,	si_doc_balance_vendor_key,	si_doc_balance_date_key,
        tran_ou, 				tran_type, 				tran_no, 				term_no, 				lo_id, 
		tran_currency, 			tran_amount, 			exchange_rate, 			base_amount, 			par_exchange_rate, 
		par_base_amount, 		doc_status, 			adjustment_status, 		discount_amount, 		disc_availed, 
		penalty_amount, 		paid_amt, 				requested_amount, 		adjusted_amount, 		batch_id, 
		due_date, 				discount_date, 			account_code, 			account_type, 			supp_code, 
		fb_id, tran_date, 		outstanding_amt, 		posting_date, 			base_outstanding_amt, 
		pbase_outstanding_amt, 	base_adjusted_amount, 	pbase_adjusted_amount, 	base_paid_amt, 			pbase_paid_amt, 
		disc_amount_type, 		disc_percent, 			penalty_percent, 		pdc_flag, 				pdc_void_flag, 
		instr_no, 				etlactiveind, 			etljobname, 			envsourcecd, 			datasourcecd, 
		etlcreatedatetime
    )

    SELECT
		COALESCE(cu.curr_key,-1),  COALESCE(ac.opcoa_key,-1),	COALESCE(v.vendor_key,-1),	COALESCE(d.datekey,-1),
        s.tran_ou, 					s.tran_type, 				s.tran_no, 					s.term_no, 				s.lo_id, 
		s.tran_currency, 			s.tran_amount, 			    s.exchange_rate, 			s.base_amount, 			s.par_exchange_rate, 
		s.par_base_amount, 			s.doc_status, 			    s.adjustment_status, 		s.discount_amount, 		s.disc_availed, 
		s.penalty_amount, 			s.paid_amt, 				s.requested_amount, 		s.adjusted_amount, 		s.batch_id, 
		s.due_date, 				s.discount_date, 			s.account_code, 			s.account_type, 		s.supp_code, 
		s.fb_id,                    s.tran_date, 		        s.outstanding_amt, 			s.posting_date, 		s.base_outstanding_amt, 
		s.pbase_outstanding_amt, 	s.base_adjusted_amount, 	s.pbase_adjusted_amount, 	s.base_paid_amt, 		s.pbase_paid_amt, 
		s.disc_amount_type, 		s.disc_percent, 			s.penalty_percent, 			s.pdc_flag, 			s.pdc_void_flag, 
		s.instr_no, 				1, 							p_etljobname, 				p_envsourcecd, 			p_datasourcecd, 
		NOW()
    FROM stg.stg_si_doc_balance s
	LEFT JOIN dwh.d_operationalaccountDetail ac
	ON  	s.account_code   	 = ac.account_code
	LEFT JOIN dwh.d_currency cu 
		ON  s.tran_currency		 = cu.iso_curr_code
    LEFT JOIN dwh.d_date d 		
		ON  s.posting_date::date = d.dateactual
	LEFT JOIN dwh.d_vendor v 		
		ON  s.supp_code 	  	 = v.vendor_id
		AND s.tran_ou			 = v.vendor_ou
    LEFT JOIN dwh.f_sidocbalance t
    ON 		s.tran_ou 			 = t.tran_ou
    AND 	s.tran_type 		 = t.tran_type
    AND 	s.tran_no 			 = t.tran_no
    AND 	s.term_no 			 = t.term_no
    AND 	s.account_type 		 = t.account_type
    WHERE t.tran_ou IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN
	
	truncate table raw.raw_si_doc_balance restart identity;

    INSERT INTO raw.raw_si_doc_balance
    (
        tran_ou, tran_type, tran_no, term_no, lo_id, 
		tran_currency, tran_amount, exchange_rate, base_amount, par_exchange_rate, 
		par_base_amount, doc_status, adjustment_status, discount_amount, disc_availed, 
		penalty_amount, paid_amt, requested_amount, adjusted_amount, batch_id, 
		createdby, createddate, modifiedby, modifieddate, due_date, 
		discount_date, account_code, account_type, cr_paid_amount, supp_code, 
		fb_id, tran_date, outstanding_amt, posting_date, base_outstanding_amt, 
		pbase_outstanding_amt, base_adjusted_amount, pbase_adjusted_amount, base_paid_amt, pbase_paid_amt, 
		disc_amount_type, disc_percent, penalty_percent, pdc_flag, pdc_void_flag, 
		instr_no, rev_due_date, rev_discount_date, etlcreateddatetime
    )
    SELECT
        tran_ou, tran_type, tran_no, term_no, lo_id, 
		tran_currency, tran_amount, exchange_rate, base_amount, par_exchange_rate, 
		par_base_amount, doc_status, adjustment_status, discount_amount, disc_availed, 
		penalty_amount, paid_amt, requested_amount, adjusted_amount, batch_id, 
		createdby, createddate, modifiedby, modifieddate, due_date, 
		discount_date, account_code, account_type, cr_paid_amount, supp_code, 
		fb_id, tran_date, outstanding_amt, posting_date, base_outstanding_amt, 
		pbase_outstanding_amt, base_adjusted_amount, pbase_adjusted_amount, base_paid_amt, pbase_paid_amt, 
		disc_amount_type, disc_percent, penalty_percent, pdc_flag, pdc_void_flag, 
		instr_no, rev_due_date, rev_discount_date, etlcreateddatetime
    FROM stg.stg_si_doc_balance;
    
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
ALTER PROCEDURE dwh.usp_f_sidocbalance(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
