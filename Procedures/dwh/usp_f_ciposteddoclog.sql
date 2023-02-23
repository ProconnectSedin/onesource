-- PROCEDURE: dwh.usp_f_ciposteddoclog(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_ciposteddoclog(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_ciposteddoclog(
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
    FROM stg.stg_ci_posted_doc_log;

    UPDATE dwh.F_ciposteddoclog t
    SET
		cipostdoc_cust_key          =  COALESCE(c.customer_key,-1),
		account_code_key 			=  COALESCE(acc.opcoa_key, -1),
        tran_ou                      = s.tran_ou,
        tran_type                    = s.tran_type,
        tran_no                      = s.tran_no,
        term_no                      = s.term_no,
        amt_type                     = s.amt_type,
        ref_doc_ou                   = s.ref_doc_ou,
        ref_doc_type                 = s.ref_doc_type,
        ref_doc_no                   = s.ref_doc_no,
        ref_doc_term                 = s.ref_doc_term,
        adjd_doc_ou                  = s.adjd_doc_ou,
        adjd_doc_type                = s.adjd_doc_type,
        adjd_doc_no                  = s.adjd_doc_no,
        adjd_doc_term                = s.adjd_doc_term,
        createddate                  = s.createddate,
        timestamp                    = s.timestamp,
        lo_id                        = s.lo_id,
        batch_id                     = s.batch_id,
        tran_date                    = s.tran_date,
        cust_code                    = s.cust_code,
        tran_currency                = s.tran_currency,
        tran_amount                  = s.tran_amount,
        basecur_erate                = s.basecur_erate,
        base_amount                  = s.base_amount,
        par_exchange_rate            = s.par_exchange_rate,
        par_base_amount              = s.par_base_amount,
        ref_doc_date                 = s.ref_doc_date,
        ref_doc_cur                  = s.ref_doc_cur,
        createdby                    = s.createdby,
        posting_status               = s.posting_status,
        posting_date                 = s.posting_date,
        adjust_amount_inv_cur        = s.adjust_amount_inv_cur,
        modifiedby                   = s.modifiedby,
        modifieddate                 = s.modifieddate,
        account_code                 = s.account_code,
        account_type                 = s.account_type,
        fb_id                        = s.fb_id,
        discount_amount              = s.discount_amount,
        penalty_amount               = s.penalty_amount,
        writeoff_amount              = s.writeoff_amount,
        received_amount              = s.received_amount,
        doc_status                   = s.doc_status,
        receipt_type                 = s.receipt_type,
        base_adjust_amt              = s.base_adjust_amt,
        pbase_adjust_amt             = s.pbase_adjust_amt,
        base_received_amount         = s.base_received_amount,
        pbase_received_amount        = s.pbase_received_amount,
        base_writeoff_amount         = s.base_writeoff_amount,
        pbase_writeoff_amount        = s.pbase_writeoff_amount,
        etlactiveind                 = 1,
        etljobname                   = p_etljobname,
        envsourcecd                  = p_envsourcecd,
        datasourcecd                 = p_datasourcecd,
        etlupdatedatetime            = NOW()
    FROM stg.stg_ci_posted_doc_log s
	
	LEFT JOIN dwh.d_customer C 		
		ON s.cust_code  = C.customer_id 
        AND s.tran_ou        = C.customer_ou
		
	LEFT JOIN dwh.d_operationalaccountdetail acc
	ON acc.account_code		= s.account_code
	
    WHERE t.tran_ou = s.tran_ou
    AND t.tran_type = s.tran_type
    AND t.tran_no = s.tran_no
    AND t.term_no = s.term_no
    AND t.amt_type = s.amt_type
    AND t.ref_doc_ou = s.ref_doc_ou
    AND t.ref_doc_type = s.ref_doc_type
    AND t.ref_doc_no = s.ref_doc_no
    AND t.ref_doc_term = s.ref_doc_term
    AND t.adjd_doc_ou = s.adjd_doc_ou
    AND t.adjd_doc_type = s.adjd_doc_type
    AND t.adjd_doc_no = s.adjd_doc_no
    AND t.adjd_doc_term = s.adjd_doc_term
    AND t.createddate = s.createddate
    AND t.account_type = s.account_type;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_ciposteddoclog
    (
       cipostdoc_cust_key, account_code_key, tran_ou, tran_type, tran_no, term_no, amt_type, ref_doc_ou, ref_doc_type, ref_doc_no, ref_doc_term, adjd_doc_ou, adjd_doc_type, adjd_doc_no, adjd_doc_term, createddate, timestamp, lo_id, batch_id, tran_date, cust_code, tran_currency, tran_amount, basecur_erate, base_amount, par_exchange_rate, par_base_amount, ref_doc_date, ref_doc_cur, createdby, posting_status, posting_date, adjust_amount_inv_cur, modifiedby, modifieddate, account_code, account_type, fb_id, discount_amount, penalty_amount, writeoff_amount, received_amount, doc_status, receipt_type, base_adjust_amt, pbase_adjust_amt, base_received_amount, pbase_received_amount, base_writeoff_amount, pbase_writeoff_amount, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
         COALESCE(c.customer_key,-1), COALESCE(acc.opcoa_key, -1),s.tran_ou, s.tran_type, s.tran_no, s.term_no, s.amt_type, s.ref_doc_ou, s.ref_doc_type, s.ref_doc_no, s.ref_doc_term, s.adjd_doc_ou, s.adjd_doc_type, s.adjd_doc_no, s.adjd_doc_term, s.createddate, s.timestamp, s.lo_id, s.batch_id, s.tran_date, s.cust_code, s.tran_currency, s.tran_amount, s.basecur_erate, s.base_amount, s.par_exchange_rate, s.par_base_amount, s.ref_doc_date, s.ref_doc_cur, s.createdby, s.posting_status, s.posting_date, s.adjust_amount_inv_cur, s.modifiedby, s.modifieddate, s.account_code, s.account_type, s.fb_id, s.discount_amount, s.penalty_amount, s.writeoff_amount, s.received_amount, s.doc_status, s.receipt_type, s.base_adjust_amt, s.pbase_adjust_amt, s.base_received_amount, s.pbase_received_amount, s.base_writeoff_amount, s.pbase_writeoff_amount, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_ci_posted_doc_log s
		LEFT JOIN dwh.d_customer C 		
		ON s.cust_code  = C.customer_id 
        AND s.tran_ou        = C.customer_ou
			LEFT JOIN dwh.d_operationalaccountdetail acc
	ON acc.account_code		= s.account_code
	
	
    LEFT JOIN dwh.F_ciposteddoclog t
    ON s.tran_ou = t.tran_ou
    AND s.tran_type = t.tran_type
    AND s.tran_no = t.tran_no
    AND s.term_no = t.term_no
    AND s.amt_type = t.amt_type
    AND s.ref_doc_ou = t.ref_doc_ou
    AND s.ref_doc_type = t.ref_doc_type
    AND s.ref_doc_no = t.ref_doc_no
    AND s.ref_doc_term = t.ref_doc_term
    AND s.adjd_doc_ou = t.adjd_doc_ou
    AND s.adjd_doc_type = t.adjd_doc_type
    AND s.adjd_doc_no = t.adjd_doc_no
    AND s.adjd_doc_term = t.adjd_doc_term
    AND s.createddate = t.createddate
    AND s.account_type = t.account_type
    WHERE t.tran_ou IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_ci_posted_doc_log
    (
        tran_ou, tran_type, tran_no, term_no, amt_type, ref_doc_ou, ref_doc_type, ref_doc_no, ref_doc_term, adjd_doc_ou, adjd_doc_type, adjd_doc_no, adjd_doc_term, createddate, timestamp, lo_id, batch_id, tran_date, cust_code, tran_currency, tran_amount, basecur_erate, base_amount, par_exchange_rate, par_base_amount, ref_doc_date, ref_doc_cur, createdby, posting_status, posting_date, crosscur_erate, adjust_amount_inv_cur, modifiedby, modifieddate, account_code, account_type, fb_id, discount_amount, penalty_amount, writeoff_amount, received_amount, doc_status, receipt_type, tds_amount, base_adjust_amt, pbase_adjust_amt, base_received_amount, pbase_received_amount, base_writeoff_amount, pbase_writeoff_amount, provision_amt, BookingNo, MasterBillOfLadingNo, BillOfLadingNo, log_pdc_status, etlcreateddatetime
    )
    SELECT
        tran_ou, tran_type, tran_no, term_no, amt_type, ref_doc_ou, ref_doc_type, ref_doc_no, ref_doc_term, adjd_doc_ou, adjd_doc_type, adjd_doc_no, adjd_doc_term, createddate, timestamp, lo_id, batch_id, tran_date, cust_code, tran_currency, tran_amount, basecur_erate, base_amount, par_exchange_rate, par_base_amount, ref_doc_date, ref_doc_cur, createdby, posting_status, posting_date, crosscur_erate, adjust_amount_inv_cur, modifiedby, modifieddate, account_code, account_type, fb_id, discount_amount, penalty_amount, writeoff_amount, received_amount, doc_status, receipt_type, tds_amount, base_adjust_amt, pbase_adjust_amt, base_received_amount, pbase_received_amount, base_writeoff_amount, pbase_writeoff_amount, provision_amt, BookingNo, MasterBillOfLadingNo, BillOfLadingNo, log_pdc_status, etlcreateddatetime
    FROM stg.stg_ci_posted_doc_log;
    
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
ALTER PROCEDURE dwh.usp_f_ciposteddoclog(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
