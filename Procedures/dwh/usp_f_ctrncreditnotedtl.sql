-- PROCEDURE: dwh.usp_f_ctrncreditnotedtl(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_ctrncreditnotedtl(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_ctrncreditnotedtl(
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
    FROM stg.stg_ctrn_credit_note_dtl;

    UPDATE dwh.F_ctrncreditnotedtl t
    SET
		account_code_key               =COALESCE(acc.opcoa_key, -1),
		ctrncreditnotedtl_customer_key  =COALESCE(cu.customer_key, -1),
		ctrncreditnotedtl_currency_key  =COALESCE(cr.curr_key, -1),
        timestamp                = s.timestamp,
        transfer_doc_no          = s.transfer_doc_no,
        tran_date                = s.tran_date,
        customer_code            = s.customer_code,
        currency_code            = s.currency_code,
        account_code             = s.account_code,
        bu_id                    = s.bu_id,
        tran_amount              = s.tran_amount,
        exchange_rate            = s.exchange_rate,
        par_exchange_rate        = s.par_exchange_rate,
        transferee_amt           = s.transferee_amt,
        reason_code              = s.reason_code,
        comments                 = s.comments,
        ref_doc_no               = s.ref_doc_no,
        status                   = s.status,
        batch_id                 = s.batch_id,
        tran_type                = s.tran_type,
        createdby                = s.createdby,
        createddate              = s.createddate,
        modifiedby               = s.modifiedby,
        modifieddate             = s.modifieddate,
        account_type             = s.account_type,
        rev_doc_ou               = s.rev_doc_ou,
        rev_doc_no               = s.rev_doc_no,
        rev_doc_date             = s.rev_doc_date,
        rev_reasoncode           = s.rev_reasoncode,
        rev_doc_trantype         = s.rev_doc_trantype,
        etlactiveind             = 1,
        etljobname               = p_etljobname,
        envsourcecd              = p_envsourcecd,
        datasourcecd             = p_datasourcecd,
        etlupdatedatetime        = NOW()
    FROM stg.stg_ctrn_credit_note_dtl s
	LEFT JOIN dwh.d_operationalaccountdetail acc
        ON acc.account_code             = s.account_code
LEFT JOIN dwh.d_customer cu
        ON      cu.customer_id          = s.customer_code
        AND cu.customer_ou              = s.ou_id
 LEFT JOIN dwh.d_currency cr
        ON cr.iso_curr_code             = s.currency_code
    WHERE t.ou_id = s.ou_id
    AND t.tcn_no = s.tcn_no;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_ctrncreditnotedtl
    (
        account_code_key,ctrncreditnotedtl_customer_key,ctrncreditnotedtl_currency_key ,ou_id, tcn_no, timestamp, transfer_doc_no, tran_date, customer_code, currency_code, account_code, bu_id, tran_amount, exchange_rate, par_exchange_rate, transferee_amt, reason_code, comments, ref_doc_no, status, batch_id, tran_type, createdby, createddate, modifiedby, modifieddate, account_type, rev_doc_ou, rev_doc_no, rev_doc_date, rev_reasoncode, rev_doc_trantype, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
       COALESCE(acc.opcoa_key, -1),COALESCE(cu.customer_key, -1),COALESCE(cr.curr_key, -1), s.ou_id, s.tcn_no, s.timestamp, s.transfer_doc_no, s.tran_date, s.customer_code, s.currency_code, s.account_code, s.bu_id, s.tran_amount, s.exchange_rate, s.par_exchange_rate, s.transferee_amt, s.reason_code, s.comments, s.ref_doc_no, s.status, s.batch_id, s.tran_type, s.createdby, s.createddate, s.modifiedby, s.modifieddate, s.account_type, s.rev_doc_ou, s.rev_doc_no, s.rev_doc_date, s.rev_reasoncode, s.rev_doc_trantype, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_ctrn_credit_note_dtl s
	
		LEFT JOIN dwh.d_operationalaccountdetail acc
        ON acc.account_code             = s.account_code
LEFT JOIN dwh.d_customer cu
        ON      cu.customer_id          = s.customer_code
        AND cu.customer_ou              = s.ou_id
 LEFT JOIN dwh.d_currency cr
        ON cr.iso_curr_code             = s.currency_code
    LEFT JOIN dwh.F_ctrncreditnotedtl t
    ON s.ou_id = t.ou_id
    AND s.tcn_no = t.tcn_no
    WHERE t.ou_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_ctrn_credit_note_dtl
    (
        ou_id, tcn_no, timestamp, transfer_doc_no, tran_date, customer_code, currency_code, account_code, bu_id, tran_amount, cost_center, analysis_code, subanalysis_code, exchange_rate, par_exchange_rate, transferee_amt, reason_code, comments, ref_doc_no, status, batch_id, tran_type, createdby, createddate, modifiedby, modifieddate, account_type, reference_code, scheme_code, purpose, project_ou, Project_code, rev_doc_ou, rev_doc_no, rev_doc_date, rev_reasoncode, rev_remarks, rev_doc_trantype, address_id, etlcreateddatetime
    )
    SELECT
        ou_id, tcn_no, timestamp, transfer_doc_no, tran_date, customer_code, currency_code, account_code, bu_id, tran_amount, cost_center, analysis_code, subanalysis_code, exchange_rate, par_exchange_rate, transferee_amt, reason_code, comments, ref_doc_no, status, batch_id, tran_type, createdby, createddate, modifiedby, modifieddate, account_type, reference_code, scheme_code, purpose, project_ou, Project_code, rev_doc_ou, rev_doc_no, rev_doc_date, rev_reasoncode, rev_remarks, rev_doc_trantype, address_id, etlcreateddatetime
    FROM stg.stg_ctrn_credit_note_dtl;
    
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
ALTER PROCEDURE dwh.usp_f_ctrncreditnotedtl(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
