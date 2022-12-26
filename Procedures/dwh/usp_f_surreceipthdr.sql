-- PROCEDURE: dwh.usp_f_surreceipthdr(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_surreceipthdr(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_surreceipthdr(
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
    FROM stg.stg_sur_receipt_hdr;
	
    UPDATE dwh.F_surreceipthdr t
    SET
		surreceipthdr_curr_key	  = COALESCE(cu.curr_key,-1),
		surreceipthdr_datekey	  = COALESCE(d.datekey,-1),
        receipt_date              = s.receipt_date,
        receipt_category          = s.receipt_category,
        fb_id                     = s.fb_id,
        notype_no                 = s.notype_no,
        remitter_name             = s.remitter_name,
        receipt_method            = s.receipt_method,
        receipt_mode              = s.receipt_mode,
        receipt_route             = s.receipt_route,
        bank_cash_code            = s.bank_cash_code,
        currency_code             = s.currency_code,
        exchange_rate             = s.exchange_rate,
        receipt_amount            = s.receipt_amount,
        origin_no                 = s.origin_no,
        reason_code               = s.reason_code,
        remarks                   = s.remarks,
        instr_no                  = s.instr_no,
        micr_no                   = s.micr_no,
        instr_amount              = s.instr_amount,
        instr_date                = s.instr_date,
        instr_status              = s.instr_status,
        bank_code                 = s.bank_code,
        receipt_status            = s.receipt_status,
        batch_id                  = s.batch_id,
        refdoc_no                 = s.refdoc_no,
        refdoc_type               = s.refdoc_type,
        createdby                 = s.createdby,
        createddate               = s.createddate,
        modifiedby                = s.modifiedby,
        modifieddate              = s.modifieddate,
        tcal_exclusive_amt        = s.tcal_exclusive_amt,
        total_tcal_amount         = s.total_tcal_amount,
        tcal_status               = s.tcal_status,
        acct_type                 = s.acct_type,
        insamt_btcal              = s.insamt_btcal,
        refdoc_ou                 = s.refdoc_ou,
        instr_type                = s.instr_type,
        auto_gen_flag             = s.auto_gen_flag,
        afe_number                = s.afe_number,
        job_number                = s.job_number,
        report_flag               = s.report_flag,
        etlactiveind              = 1,
        etljobname                = p_etljobname,
        envsourcecd               = p_envsourcecd,
        datasourcecd              = p_datasourcecd,
        etlupdatedatetime         = NOW()
    FROM stg.stg_sur_receipt_hdr s
	LEFT JOIN dwh.d_currency cu 
		ON  s.currency_code				= cu.iso_curr_code
	LEFT JOIN dwh.d_date d 		
		ON  s.receipt_date::date 	= d.dateactual
    WHERE 	t.ou_id 		= s.ou_id
    AND 	t.receipt_no 	= s.receipt_no
    AND 	t.receipt_type 	= s.receipt_type
    AND 	t.tran_type 	= s.tran_type
    AND 	t.stimestamp 	= s.stimestamp
    AND 	t.ifb_flag 		= s.ifb_flag;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_surreceipthdr
    (
		surreceipthdr_curr_key,	surreceipthdr_datekey,
        ou_id, 				receipt_no, 		receipt_type, 		tran_type, 			stimestamp, 
		receipt_date, 		receipt_category, 	fb_id, 				notype_no, 			remitter_name, 
		receipt_method, 	receipt_mode, 		receipt_route, 		bank_cash_code, 	currency_code, 
		exchange_rate, 		receipt_amount, 	origin_no, 			reason_code, 		remarks, 
		instr_no, 			micr_no, 			instr_amount, 		instr_date, 		instr_status, 
		bank_code, 			receipt_status, 	batch_id, 			refdoc_no, 			refdoc_type, 
		createdby, 			createddate, 		modifiedby, 		modifieddate, 		tcal_exclusive_amt, 
		total_tcal_amount, 	tcal_status, 		acct_type, 			insamt_btcal, 		refdoc_ou, 
		instr_type, 		auto_gen_flag, 		afe_number, 		job_number, 		report_flag, 
		ifb_flag, 			etlactiveind, 		etljobname, 		envsourcecd, 		datasourcecd, 
		etlcreatedatetime
    )

    SELECT
		COALESCE(cu.curr_key,-1),	COALESCE(d.datekey,-1),	
        s.ou_id, 				s.receipt_no, 			s.receipt_type, 		s.tran_type, 			s.stimestamp, 
		s.receipt_date, 		s.receipt_category, 	s.fb_id, 				s.notype_no, 			s.remitter_name, 
		s.receipt_method, 		s.receipt_mode, 		s.receipt_route, 		s.bank_cash_code, 		s.currency_code, 
		s.exchange_rate, 		s.receipt_amount, 		s.origin_no, 			s.reason_code, 			s.remarks, 
		s.instr_no, 			s.micr_no, 				s.instr_amount, 		s.instr_date, 			s.instr_status, 
		s.bank_code, 			s.receipt_status, 		s.batch_id, 			s.refdoc_no, 			s.refdoc_type, 
		s.createdby, 			s.createddate, 			s.modifiedby, 			s.modifieddate, 		s.tcal_exclusive_amt, 
		s.total_tcal_amount, 	s.tcal_status, 			s.acct_type, 			s.insamt_btcal, 		s.refdoc_ou, 
		s.instr_type, 			s.auto_gen_flag, 		s.afe_number, 			s.job_number, 			s.report_flag, 
		s.ifb_flag,				1, 						p_etljobname, 			p_envsourcecd, 			p_datasourcecd, 
		NOW()
    FROM stg.stg_sur_receipt_hdr s
	LEFT JOIN dwh.d_currency cu 
		ON  s.currency_code				= cu.iso_curr_code
	LEFT JOIN dwh.d_date d 		
		ON  s.receipt_date::date 	= d.dateactual
    LEFT JOIN dwh.F_surreceipthdr t
    ON 		s.ou_id 		= t.ou_id
    AND 	s.receipt_no 	= t.receipt_no
    AND 	s.receipt_type 	= t.receipt_type
    AND 	s.tran_type		= t.tran_type
    AND 	s.stimestamp 	= t.stimestamp
    AND 	s.ifb_flag 		= t.ifb_flag
    WHERE t.ou_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_sur_receipt_hdr
    (
        ou_id, 				receipt_no, 		receipt_type, 		tran_type, 			stimestamp, 
		receipt_date, 		receipt_category, 	fb_id, 				notype_no, 			remitter_name, 
		receipt_method, 	receipt_mode, 		receipt_route, 		bank_cash_code, 	currency_code, 
		exchange_rate, 		receipt_amount, 	origin_no, 			reason_code, 		remarks, 
		instr_no, 			micr_no, 			instr_amount, 		instr_date, 		instr_status, 
		bank_code, 			card_no, 			card_auth_no, 		issuer, 			valid_till_month, 
		valid_till_year, 	address1, 			address2, 			address3, 			city, 
		state, 				country, 			zip_code, 			contact, 			url, 
		mail_stop, 			pager_no, 			telex, 				email_id, 			phone_no, 
		mobile_no, 			fax_no, 			receipt_status, 	rr_flag, 			batch_id, 
		refdoc_no, 			refdoc_type, 		parbaseexrate, 		createdby, 			createddate, 
		modifiedby, 		modifieddate, 		doc_status, 		tcal_exclusive_amt, total_tcal_amount, 
		tcal_status, 		source_comp, 		acct_type, 			insamt_btcal, 		consistency_stamp, 
		refdoc_ou, 			instr_type, 		pdr_status, 		pdr_rev_flag, 		workflow_status, 
		auto_gen_flag, 		project_ou, 		Project_code, 		afe_number, 		job_number, 
		costcenter_hdr, 	bc_coveredamt, 		bc_no, 				bc_redemptionamt, 	report_flag, 
		ifb_flag, 			etlcreateddatetime
    )
    SELECT
        ou_id, 				receipt_no, 		receipt_type, 		tran_type, 			stimestamp, 
		receipt_date, 		receipt_category, 	fb_id, 				notype_no, 			remitter_name, 
		receipt_method, 	receipt_mode, 		receipt_route, 		bank_cash_code, 	currency_code, 
		exchange_rate, 		receipt_amount, 	origin_no, 			reason_code, 		remarks, 
		instr_no, 			micr_no, 			instr_amount, 		instr_date, 		instr_status, 
		bank_code, 			card_no, 			card_auth_no, 		issuer, 			valid_till_month, 
		valid_till_year, 	address1, 			address2, 			address3, 			city, 
		state, 				country, 			zip_code, 			contact, 			url, 
		mail_stop, 			pager_no, 			telex, 				email_id, 			phone_no, 
		mobile_no, 			fax_no, 			receipt_status, 	rr_flag, 			batch_id, 
		refdoc_no, 			refdoc_type, 		parbaseexrate, 		createdby, 			createddate, 
		modifiedby, 		modifieddate, 		doc_status, 		tcal_exclusive_amt, total_tcal_amount, 
		tcal_status, 		source_comp, 		acct_type, 			insamt_btcal, 		consistency_stamp, 
		refdoc_ou, 			instr_type, 		pdr_status, 		pdr_rev_flag, 		workflow_status, 
		auto_gen_flag, 		project_ou, 		Project_code, 		afe_number, 		job_number, 
		costcenter_hdr, 	bc_coveredamt, 		bc_no, 				bc_redemptionamt, 	report_flag, 
		ifb_flag, 			etlcreateddatetime
    FROM stg.stg_sur_receipt_hdr;
    
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
ALTER PROCEDURE dwh.usp_f_surreceipthdr(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
