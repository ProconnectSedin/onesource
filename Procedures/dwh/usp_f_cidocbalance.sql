-- PROCEDURE: dwh.usp_f_cidocbalance(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_cidocbalance(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_cidocbalance(
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
    FROM stg.stg_ci_doc_balance;

    UPDATE dwh.f_cidocbalance t
    SET
		cidocbalance_curr_key		 = COALESCE(cu.curr_key,-1), 
		cidocbalance_customer_key	 = COALESCE(c.customer_key,-1),
		cidocbalance_opcoa_key		 = COALESCE(ac.opcoa_key,-1),
        timestamp                    = s.timestamp,
        batch_id                     = s.batch_id,
        lo_id                        = s.lo_id,
        tran_currency                = s.tran_currency,
        basecur_erate                = s.basecur_erate,
        base_amount                  = s.base_amount,
        tran_amount                  = s.tran_amount,
        par_exchange_rate            = s.par_exchange_rate,
        par_base_amount              = s.par_base_amount,
        doc_status                   = s.doc_status,
        adjustment_status            = s.adjustment_status,
        unadjusted_amt               = s.unadjusted_amt,
        paid_amt                     = s.paid_amt,
        disc_availed                 = s.disc_availed,
        written_off_amt              = s.written_off_amt,
        provision_amt_cm             = s.provision_amt_cm,
        createdby                    = s.createdby,
        createddate                  = s.createddate,
        modifiedby                   = s.modifiedby,
        modifieddate                 = s.modifieddate,
        discount_amount              = s.discount_amount,
        adjusted_amount              = s.adjusted_amount,
        received_amount              = s.received_amount,
        penalty_amount               = s.penalty_amount,
        write_back_amount            = s.write_back_amount,
        vat_amount                   = s.vat_amount,
        outstanding_amount           = s.outstanding_amount,
        pay_term                     = s.pay_term,
        recpt_consumed               = s.recpt_consumed,
        rv_amount                    = s.rv_amount,
        cpi_cr_unadj_amount          = s.cpi_cr_unadj_amount,
        cust_code                    = s.cust_code,
        tran_date                    = s.tran_date,
		account_code                 = s.account_code,
        fb_id                        = s.fb_id,
        posting_date                 = s.posting_date,
        base_outstanding_amt         = s.base_outstanding_amt,
        pbase_outstanding_amt        = s.pbase_outstanding_amt,
        base_adjusted_amount         = s.base_adjusted_amount,
        pbase_adjusted_amount        = s.pbase_adjusted_amount,
        base_recpt_consumed          = s.base_recpt_consumed,
        pbase_recpt_consumed         = s.pbase_recpt_consumed,
        base_received_amount         = s.base_received_amount,
        pbase_received_amount        = s.pbase_received_amount,
        base_written_off_amt         = s.base_written_off_amt,
        pbase_written_off_amt        = s.pbase_written_off_amt,
        due_date                     = s.due_date,
        discount_date                = s.discount_date,
        etlactiveind                 = 1,
        etljobname                   = p_etljobname,
        envsourcecd                  = p_envsourcecd,
        datasourcecd                 = p_datasourcecd,
        etlupdatedatetime            = NOW()
    FROM stg.stg_ci_doc_balance s
	LEFT JOIN dwh.d_operationalaccountdetail ac     
    ON 	  s.account_code  			= ac.account_code
	LEFT JOIN dwh.d_customer c     
    ON 	  s.tran_ou  		   		= c.customer_ou
	AND   s.cust_code				= c.customer_id
	LEFT JOIN dwh.d_currency cu     
    ON 	  s.tran_currency  			= cu.iso_curr_code
    WHERE t.tran_ou 				= s.tran_ou
    AND   t.tran_type 				= s.tran_type
    AND   t.tran_no 				= s.tran_no
    AND   t.term_no 				= s.term_no
    AND   t.account_type 			= s.account_type;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.f_cidocbalance
    (
		cidocbalance_curr_key,		cidocbalance_customer_key,		cidocbalance_opcoa_key,
        tran_ou, 				tran_type, 				tran_no, 				term_no, 			timestamp, 
		batch_id, 				lo_id, 					tran_currency, 			basecur_erate, 			base_amount, 
		tran_amount, 			par_exchange_rate, 		par_base_amount, 		doc_status, 			adjustment_status, 
		unadjusted_amt, 		paid_amt, 				disc_availed, 			written_off_amt, 		provision_amt_cm, 
		createdby, 				createddate, 			modifiedby, 			modifieddate, 			discount_amount, 
		adjusted_amount, 		received_amount, 		penalty_amount, 		write_back_amount, 		vat_amount, 
		outstanding_amount, 	pay_term, 				recpt_consumed, 		rv_amount, 				cpi_cr_unadj_amount, 
		cust_code, 				tran_date, 				account_code, 			account_type, 			fb_id, 
		posting_date, 			base_outstanding_amt, 	pbase_outstanding_amt, 	base_adjusted_amount, 
		pbase_adjusted_amount, 	base_recpt_consumed, 	pbase_recpt_consumed, 	base_received_amount, 	pbase_received_amount, 
		base_written_off_amt, 	pbase_written_off_amt, 	due_date, 				discount_date, 			etlactiveind, 
		etljobname, 			envsourcecd, 			datasourcecd, 			etlcreatedatetime
    )

    SELECT
		COALESCE(cu.curr_key,-1),	COALESCE(c.customer_key,-1), COALESCE(ac.opcoa_key,-1),	
        s.tran_ou, 					s.tran_type, 				s.tran_no, 					s.term_no, 					s.timestamp, 
		s.batch_id, 				s.lo_id, 					s.tran_currency, 			s.basecur_erate, 			s.base_amount, 
		s.tran_amount, 				s.par_exchange_rate, 		s.par_base_amount, 			s.doc_status, 				s.adjustment_status, 
		s.unadjusted_amt, 			s.paid_amt, 				s.disc_availed, 			s.written_off_amt, 			s.provision_amt_cm, 
		s.createdby, 				s.createddate, 				s.modifiedby, 				s.modifieddate, 			s.discount_amount, 
		s.adjusted_amount, 			s.received_amount, 			s.penalty_amount, 			s.write_back_amount, 		s.vat_amount, 
		s.outstanding_amount, 		s.pay_term, 				s.recpt_consumed, 			s.rv_amount, 				s.cpi_cr_unadj_amount, 
		s.cust_code, 				s.tran_date, 				s.account_code, 			s.account_type, 			s.fb_id, 
		s.posting_date, 			s.base_outstanding_amt, 	s.pbase_outstanding_amt, 	s.base_adjusted_amount, 
		s.pbase_adjusted_amount, 	s.base_recpt_consumed, 		s.pbase_recpt_consumed, 	s.base_received_amount, 	s.pbase_received_amount, 
		s.base_written_off_amt, 	s.pbase_written_off_amt, 	s.due_date, 				s.discount_date, 			1, 
		p_etljobname, 				p_envsourcecd, 				p_datasourcecd, 			NOW()
    FROM stg.stg_ci_doc_balance s
	LEFT JOIN dwh.d_operationalaccountdetail ac     
    ON 	  s.account_code  			= ac.account_code
	LEFT JOIN dwh.d_customer c     
    ON 	  s.tran_ou  		   		= c.customer_ou
	AND   s.cust_code				= c.customer_id
	LEFT JOIN dwh.d_currency cu     
    ON 	  s.tran_currency  			= cu.iso_curr_code
    LEFT JOIN dwh.f_cidocbalance t
    ON 	  t.tran_ou 			    = s.tran_ou
    AND   t.tran_type 				= s.tran_type
    AND   t.tran_no 				= s.tran_no
    AND   t.term_no 				= s.term_no
    AND   t.account_type 			= s.account_type
    WHERE t.tran_ou IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_ci_doc_balance
    (
        tran_ou, 				tran_type, 				tran_no, 				term_no, 				timestamp, 
		batch_id, 				lo_id, 					tran_currency, 			basecur_erate, 			base_amount, 
		tran_amount, 			par_exchange_rate, 		par_base_amount, 		doc_status, 			adjustment_status, 
		unadjusted_amt, 		paid_amt, 				disc_availed, 			written_off_amt, 		provision_amt_cm, 
		createdby, 				createddate, 			modifiedby, 			modifieddate, 			due_no_cm, 
		discount_amount, 		adjusted_amount, 		received_amount, 		penalty_amount, 		write_back_amount, 
		vat_amount, 			outstanding_amount, 	pay_term, 				recpt_consumed, 		rv_amount, 
		cpi_cr_unadj_amount, 	payterm_version, 		charges_amount, 		cr_adj_amount, 			cust_code, 
		tran_date, 				account_code,			account_type, 			fb_id, 					posting_date, 
		base_outstanding_amt, 	pbase_outstanding_amt, 	base_adjusted_amount, 	pbase_adjusted_amount, 	base_recpt_consumed, 
		pbase_recpt_consumed, 	base_received_amount, 	pbase_received_amount, 	base_written_off_amt, 	pbase_written_off_amt, 
		base_cr_adj_amount, 	pbase_cr_adj_amount, 	due_date, 				discount_date, 			BookingNo, 
		MasterBillOfLadingNo, 	BillOfLadingNo, 		pdc_status, 			instr_no, 				rev_due_date, 
		rev_discount_date, 		pdc_flag, 				etlcreateddatetime
    )
    SELECT
        tran_ou, 				tran_type, 				tran_no, 				term_no, 				timestamp, 
		batch_id, 				lo_id, 					tran_currency, 			basecur_erate, 			base_amount, 
		tran_amount, 			par_exchange_rate, 		par_base_amount, 		doc_status, 			adjustment_status, 
		unadjusted_amt, 		paid_amt, 				disc_availed, 			written_off_amt, 		provision_amt_cm, 
		createdby, 				createddate, 			modifiedby, 			modifieddate, 			due_no_cm, 
		discount_amount, 		adjusted_amount, 		received_amount, 		penalty_amount, 		write_back_amount, 
		vat_amount, 			outstanding_amount, 	pay_term, 				recpt_consumed, 		rv_amount, 
		cpi_cr_unadj_amount, 	payterm_version, 		charges_amount, 		cr_adj_amount, 			cust_code, 
		tran_date, 				account_code,			account_type, 			fb_id, 					posting_date, 
		base_outstanding_amt, 	pbase_outstanding_amt, 	base_adjusted_amount, 	pbase_adjusted_amount, 	base_recpt_consumed, 
		pbase_recpt_consumed, 	base_received_amount, 	pbase_received_amount, 	base_written_off_amt, 	pbase_written_off_amt, 
		base_cr_adj_amount, 	pbase_cr_adj_amount, 	due_date, 				discount_date, 			BookingNo, 
		MasterBillOfLadingNo, 	BillOfLadingNo, 		pdc_status, 			instr_no, 				rev_due_date, 
		rev_discount_date, 		pdc_flag, 				etlcreateddatetime
    FROM stg.stg_ci_doc_balance;
    
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
ALTER PROCEDURE dwh.usp_f_cidocbalance(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
