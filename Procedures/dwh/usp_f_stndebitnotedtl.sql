-- PROCEDURE: dwh.usp_f_stndebitnotedtl(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_stndebitnotedtl(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_stndebitnotedtl(
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
    FROM stg.stg_stn_debit_note_dtl;

    UPDATE dwh.f_stndebitnotedtl t
    SET
		stndebitnotedtl_curr_key	 = COALESCE(cu.curr_key,-1), 
		stndebitnotedtl_vendor_key	 = COALESCE(v.vendor_key,-1),
		stndebitnotedtl_opcoa_key	 = COALESCE(ac.opcoa_key,-1),
        timestamp               = s.timestamp,
        notype_no               = s.notype_no,
        transfer_docno          = s.transfer_docno,
        tran_date               = s.tran_date,
        supplier_code           = s.supplier_code,
        currency_code           = s.currency_code,
        account_code            = s.account_code,
        fb_id                   = s.fb_id,
        tran_amount             = s.tran_amount,
        exchange_rate           = s.exchange_rate,
        pbcur_erate             = s.pbcur_erate,
        transferred_amt         = s.transferred_amt,
        reason_code             = s.reason_code,
        comments                = s.comments,
        ref_doc_no              = s.ref_doc_no,
        status                  = s.status,
        createdby               = s.createdby,
        createddate             = s.createddate,
        modifiedby              = s.modifiedby,
        modifieddate            = s.modifieddate,
        batch_id                = s.batch_id,
        rev_doc_ou              = s.rev_doc_ou,
        rev_doc_no              = s.rev_doc_no,
        rev_doc_date            = s.rev_doc_date,
        rev_reasoncode          = s.rev_reasoncode,
        rev_remarks             = s.rev_remarks,
        rev_doc_trantype        = s.rev_doc_trantype,
        etlactiveind            = 1,
        etljobname              = p_etljobname,
        envsourcecd             = p_envsourcecd,
        datasourcecd            = p_datasourcecd,
        etlupdatedatetime       = NOW()
    FROM stg.stg_stn_debit_note_dtl s
	LEFT JOIN dwh.d_operationalaccountdetail ac     
    ON 	  s.account_code  		= ac.account_code
	LEFT JOIN dwh.d_vendor v     
    ON 	  s.ou_id  		   		= v.vendor_ou
	AND   s.supplier_code		= v.vendor_id
	LEFT JOIN dwh.d_currency cu     
    ON 	  s.currency_code  		= cu.iso_curr_code
    WHERE t.ou_id 				= s.ou_id
    AND   t.trns_debit_note 	= s.trns_debit_note
    AND   t.tran_type 			= s.tran_type;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.f_stndebitnotedtl
    (
		stndebitnotedtl_curr_key,	stndebitnotedtl_vendor_key,	stndebitnotedtl_opcoa_key,
        ou_id, 			trns_debit_note, tran_type, 		timestamp, 		notype_no, 
		transfer_docno, tran_date, 		 supplier_code, 	currency_code, 	account_code, 
		fb_id, 			tran_amount, 	 exchange_rate, 	pbcur_erate, 	transferred_amt, 
		reason_code, 	comments, 		 ref_doc_no, 		status, 		createdby, 
		createddate, 	modifiedby, 	 modifieddate, 		batch_id, 		rev_doc_ou, 
		rev_doc_no, 	rev_doc_date, 	 rev_reasoncode, 	rev_remarks, 	rev_doc_trantype, 
		etlactiveind, 	etljobname, 	 envsourcecd, 		datasourcecd, 	etlcreatedatetime
    )

    SELECT
		COALESCE(cu.curr_key,-1),	COALESCE(v.vendor_key,-1),	COALESCE(ac.opcoa_key,-1),
        s.ou_id, 			s.trns_debit_note, 	s.tran_type, 		s.timestamp, 		s.notype_no, 
		s.transfer_docno, 	s.tran_date, 		s.supplier_code, 	s.currency_code, 	s.account_code, 
		s.fb_id, 			s.tran_amount, 		s.exchange_rate, 	s.pbcur_erate, 		s.transferred_amt, 
		s.reason_code, 		s.comments, 		s.ref_doc_no, 		s.status, 			s.createdby, 
		s.createddate, 		s.modifiedby, 		s.modifieddate, 	s.batch_id, 		s.rev_doc_ou, 
		s.rev_doc_no, 		s.rev_doc_date, 	s.rev_reasoncode, 	s.rev_remarks, 		s.rev_doc_trantype, 
		1, 					p_etljobname, 		p_envsourcecd, 		p_datasourcecd, 	NOW()
    FROM stg.stg_stn_debit_note_dtl s
	LEFT JOIN dwh.d_operationalaccountdetail ac     
    ON 	  s.account_code  		= ac.account_code
	LEFT JOIN dwh.d_vendor v     
    ON 	  s.ou_id  		   		= v.vendor_ou
	AND   s.supplier_code		= v.vendor_id
	LEFT JOIN dwh.d_currency cu     
    ON 	  s.currency_code  		= cu.iso_curr_code
    LEFT JOIN dwh.f_stndebitnotedtl t
    ON 	  s.ou_id 				= t.ou_id
    AND   s.trns_debit_note 	= t.trns_debit_note
    AND   s.tran_type 			= t.tran_type
    WHERE t.ou_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_stn_debit_note_dtl
    (
        ou_id, 			trns_debit_note, 	tran_type, 			timestamp, 			notype_no, 
		transfer_docno, tran_date, 			supplier_code, 		currency_code, 		account_code, 
		fb_id, 			tran_amount, 		cost_center, 		analysis_code, 		subanalysis_code, 
		exchange_rate, 	pbcur_erate, 		transferred_amt, 	reason_code, 		comments, 
		ref_doc_no, 	status, 			crosscur_erate, 	base_amount, 		par_base_amt, 
		createdby, 		createddate, 		modifiedby, 		modifieddate, 		batch_id, 
		project_ou, 	Project_code, 		rev_doc_ou, 		rev_doc_no, 		rev_doc_date, 
		rev_reasoncode, rev_remarks, 		rev_doc_trantype, 	etlcreateddatetime
    )
    SELECT
        ou_id, 			trns_debit_note, 	tran_type, 			timestamp, 			notype_no, 
		transfer_docno, tran_date, 			supplier_code, 		currency_code, 		account_code, 
		fb_id, 			tran_amount, 		cost_center, 		analysis_code, 		subanalysis_code, 
		exchange_rate, 	pbcur_erate, 		transferred_amt, 	reason_code, 		comments, 
		ref_doc_no, 	status, 			crosscur_erate, 	base_amount, 		par_base_amt, 
		createdby, 		createddate, 		modifiedby, 		modifieddate, 		batch_id, 
		project_ou, 	Project_code, 		rev_doc_ou, 		rev_doc_no, 		rev_doc_date, 
		rev_reasoncode, rev_remarks, 		rev_doc_trantype, 	etlcreateddatetime
    FROM stg.stg_stn_debit_note_dtl;
    
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
ALTER PROCEDURE dwh.usp_f_stndebitnotedtl(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
