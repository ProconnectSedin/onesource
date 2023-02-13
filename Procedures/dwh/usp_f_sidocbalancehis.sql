-- PROCEDURE: dwh.usp_f_sidocbalancehis(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_sidocbalancehis(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_sidocbalancehis(
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
    FROM stg.stg_si_doc_balance_his;

    UPDATE dwh.f_sidocbalancehis t
    SET
		si_doc_balance_his_curr_key  =	COALESCE(cu.curr_key,-1),
        tran_ou                      = s.tran_ou,
        tran_type                    = s.tran_type,
        tran_no                      = s.tran_no,
        term_no                      = s.term_no,
        tran_currency                = s.tran_currency,
        tran_date                    = s.tran_date,
        doc_status                   = s.doc_status,
        adjusted_amount              = s.adjusted_amount,
        disc_availed                 = s.disc_availed,
        penalty_amount               = s.penalty_amount,
        supp_code                    = s.supp_code,
        fb_id                        = s.fb_id,
        account_type                 = s.account_type,
        batch_id                     = s.batch_id,
        base_adjusted_amount         = s.base_adjusted_amount,
        pbase_adjusted_amount        = s.pbase_adjusted_amount,
        adj_payment_no               = s.adj_payment_no,
        etlactiveind                 = 1,
        etljobname                   = p_etljobname,
        envsourcecd                  = p_envsourcecd,
        datasourcecd                 = p_datasourcecd,
        etlupdatedatetime            = NOW()
	 FROM stg.stg_si_doc_balance_his s
	left JOIN dwh.d_currency cu 
	ON  s.tran_currency		     = cu.iso_curr_code
    WHERE t.tran_ou 			 = s.tran_ou
    AND   t.tran_type 			 = s.tran_type
    AND   t.tran_no 			 = s.tran_no
    AND   t.term_no 			 = s.term_no
    AND   t.account_type         = s.account_type
	AND   t.batch_id			 = s.batch_id 
	AND   t.adj_payment_no	     =s.adj_payment_no;
	

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.f_sidocbalancehis
    (
       si_doc_balance_his_curr_key, tran_ou, tran_type, tran_no, term_no, tran_currency, tran_date, doc_status, adjusted_amount, disc_availed, penalty_amount, supp_code, fb_id, account_type, batch_id, base_adjusted_amount, pbase_adjusted_amount, adj_payment_no, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
      COALESCE(cu.curr_key,-1),  s.tran_ou, s.tran_type, s.tran_no, s.term_no, s.tran_currency, s.tran_date, s.doc_status, s.adjusted_amount, s.disc_availed, s.penalty_amount, s.supp_code, s.fb_id, s.account_type, s.batch_id, s.base_adjusted_amount, s.pbase_adjusted_amount, s.adj_payment_no, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_si_doc_balance_his s
	left JOIN dwh.d_currency cu 
	ON  s.tran_currency		     = cu.iso_curr_code
    LEFT JOIN dwh.f_sidocbalancehis t
    ON 		s.tran_ou 			 = t.tran_ou
    AND 	s.tran_type 		 = t.tran_type
    AND 	s.tran_no 			 = t.tran_no
    AND 	s.term_no 			 = t.term_no
    AND 	s.account_type 		 = t.account_type 
	AND   	s.batch_id			 = t.batch_id
	AND 	s.adj_payment_no	 =t.adj_payment_no
    WHERE t.tran_ou IS NULL;
    GET DIAGNOSTICS inscnt = ROW_COUNT;
	

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_si_doc_balance_his
    (
        tran_ou, tran_type, tran_no, term_no, tran_currency, tran_date, doc_status, adjusted_amount, disc_availed, penalty_amount, supp_code, fb_id, account_type, batch_id, createdby, createddate, modifiedby, modifieddate, base_adjusted_amount, pbase_adjusted_amount, base_paid_amt, pbase_paid_amt, his_pdc_flag, adj_payment_no, etlcreatedatetime
    )
    SELECT
        tran_ou, tran_type, tran_no, term_no, tran_currency, tran_date, doc_status, adjusted_amount, disc_availed, penalty_amount, supp_code, fb_id, account_type, batch_id, createdby, createddate, modifiedby, modifieddate, base_adjusted_amount, pbase_adjusted_amount, base_paid_amt, pbase_paid_amt, his_pdc_flag, adj_payment_no, etlcreatedatetime
    FROM stg.stg_si_doc_balance_his;
    
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
ALTER PROCEDURE dwh.usp_f_sidocbalancehis(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
