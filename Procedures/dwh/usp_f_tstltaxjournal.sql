-- PROCEDURE: dwh.usp_f_tstltaxjournal(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_tstltaxjournal(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_tstltaxjournal(
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
    FROM stg.stg_tstl_tax_journal;

    UPDATE dwh.f_tstltaxjournal t
    SET
        tstltaxjournal_company_key	= COALESCE(c.company_key,-1),
		tstltaxjournal_curr_key	 	= COALESCE(cu.curr_key,-1),
        Tax_Jv_no                = s.Tax_Jv_no,
        num_type                 = s.num_type,
        tax_type                 = s.tax_type,
        tax_community            = s.tax_community,
        tax_region               = s.tax_region,
        tran_date                = s.tran_date,
        cur_code                 = s.cur_code,
        pay_rec_fbid             = s.pay_rec_fbid,
        bank_code                = s.bank_code,
        pay_vouc_Num_type        = s.pay_vouc_Num_type,
        decl_year                = s.decl_year,
        decl_period              = s.decl_period,
        fbid                     = s.fbid,
        Amount                   = s.Amount,
        status                   = s.status,
        created_by               = s.created_by,
        created_date             = s.created_date,
        modified_by              = s.modified_by,
        modified_date            = s.modified_date,
        tran_status              = s.tran_status,
        tran_type                = s.tran_type,
        payment_no               = s.payment_no,
        guid                     = s.guid,
        cgstamount               = s.cgstamount,
        sgstamount               = s.sgstamount,
        igstamount               = s.igstamount,
        utgst_amount             = s.utgst_amount,
        cess1                    = s.cess1,
        cess2                    = s.cess2,
        cess3                    = s.cess3,
        cess4                    = s.cess4,
        cess5                    = s.cess5,
        cess6                    = s.cess6,
        etlactiveind             = 1,
        etljobname               = p_etljobname,
        envsourcecd              = p_envsourcecd,
        datasourcecd             = p_datasourcecd,
        etlupdatedatetime        = NOW()
    FROM stg.stg_tstl_tax_journal s
	LEFT JOIN dwh.d_company c     
    ON 	  s.company_code         = c.company_code
	LEFT JOIN dwh.d_currency cu     
    ON 	  s.cur_code  			 = cu.iso_curr_code
    WHERE t.company_code 		 = s.company_code
    AND   t.Tax_Jv_no 			 = s.Tax_Jv_no;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.f_tstltaxjournal
    (
		tstltaxjournal_company_key,	tstltaxjournal_curr_key,
        company_code, 	tran_ou, 			Tax_Jv_no, 		num_type, 		tax_type, 
		tax_community, 	tax_region, 		tran_date, 		cur_code, 		pay_rec_fbid, 
		bank_code, 		pay_vouc_Num_type, 	decl_year, 		decl_period, 	fbid, 
		Amount, 		status, 			created_by, 	created_date, 	modified_by, 
		modified_date, 	tran_status, 		tran_type, 		payment_no, 	guid, 
		cgstamount, 	sgstamount, 		igstamount, 	utgst_amount, 	cess1, 
		cess2, 			cess3, 				cess4, 			cess5, 			cess6, 
		etlactiveind, 	etljobname, 		envsourcecd, 	datasourcecd, 	etlcreatedatetime
    )

    SELECT
		COALESCE(c.company_key,-1),	COALESCE(cu.curr_key,-1),
        s.company_code, 	s.tran_ou, 				s.Tax_Jv_no, 	s.num_type, 	s.tax_type, 
		s.tax_community, 	s.tax_region, 			s.tran_date, 	s.cur_code, 	s.pay_rec_fbid, 
		s.bank_code, 		s.pay_vouc_Num_type, 	s.decl_year, 	s.decl_period, 	s.fbid, 
		s.Amount, 			s.status, 				s.created_by, 	s.created_date, s.modified_by, 
		s.modified_date, 	s.tran_status, 			s.tran_type, 	s.payment_no, 	s.guid, 
		s.cgstamount, 		s.sgstamount, 			s.igstamount, 	s.utgst_amount, s.cess1, 
		s.cess2, 			s.cess3, 				s.cess4, 		s.cess5, 		s.cess6, 
		1, 					p_etljobname, 			p_envsourcecd, 	p_datasourcecd, NOW()
    FROM stg.stg_tstl_tax_journal s
	LEFT JOIN dwh.d_company c     
    ON 	  s.company_code         = c.company_code
	LEFT JOIN dwh.d_currency cu     
    ON 	  s.cur_code  			 = cu.iso_curr_code
    LEFT JOIN dwh.f_tstltaxjournal t
    ON 	  s.company_code 		 = t.company_code
    AND   s.Tax_Jv_no 			 = t.Tax_Jv_no
    WHERE t.company_code IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_tstl_tax_journal
    (
        company_code, 	tran_ou, 				Tax_Jv_no, 		num_type, 		tax_type, 
		tax_community, 	tax_region, 			tran_date, 		cur_code, 		Comment, 
		pay_recp_flag, 	pay_recp_voucher_no, 	pay_rec_fbid, 	bank_code, 		pay_vouc_Num_type, 
		decl_year, 		decl_period, 			fbid, 			Amount, 		status, 
		Rev_vouch_No, 	Rev_date, 				created_by, 	created_date, 	modified_by, 
		modified_date, 	tran_status, 			tran_type, 		pay_recp_ou, 	pay_recp_trantype, 
		payment_no, 	guid, 					cgstamount, 	sgstamount, 	igstamount, 
		utgst_amount, 	cess1, 					cess2, 			cess3, 			cess4, 
		cess5, 			cess6, 					etlcreateddatetime
    )
    SELECT
		company_code, 	tran_ou, 				Tax_Jv_no, 		num_type, 		tax_type, 
		tax_community, 	tax_region, 			tran_date, 		cur_code, 		Comment, 
		pay_recp_flag, 	pay_recp_voucher_no, 	pay_rec_fbid, 	bank_code, 		pay_vouc_Num_type, 
		decl_year, 		decl_period, 			fbid, 			Amount, 		status, 
		Rev_vouch_No, 	Rev_date, 				created_by, 	created_date, 	modified_by, 
		modified_date, 	tran_status, 			tran_type, 		pay_recp_ou, 	pay_recp_trantype, 
		payment_no, 	guid, 					cgstamount, 	sgstamount, 	igstamount, 
		utgst_amount, 	cess1, 					cess2, 			cess3, 			cess4, 
		cess5, 			cess6, 					etlcreateddatetime
    FROM stg.stg_tstl_tax_journal;
    
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
ALTER PROCEDURE dwh.usp_f_tstltaxjournal(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
