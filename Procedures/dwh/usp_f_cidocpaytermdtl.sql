-- PROCEDURE: dwh.usp_f_cidocpaytermdtl(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_cidocpaytermdtl(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_cidocpaytermdtl(
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
    FROM stg.stg_ci_doc_payterm_dtl;

    UPDATE dwh.f_cidocpaytermdtl t
    SET
		cidocpaytermdtl_company_key = COALESCE(c.company_key,-1),
        timestamp               = s.timestamp,
        lo_id                   = s.lo_id,
        batch_id                = s.batch_id,
        component_id            = s.component_id,
        company_code            = s.company_code,
        due_date                = s.due_date,
        due_amount_type         = s.due_amount_type,
        due_percent             = s.due_percent,
        due_amount              = s.due_amount,
        disc_comp_amount        = s.disc_comp_amount,
        disc_amount_type        = s.disc_amount_type,
        disc_date               = s.disc_date,
        disc_percent            = s.disc_percent,
        disc_amount             = s.disc_amount,
        penalty_percent         = s.penalty_percent,
        esr_ref_no              = s.esr_ref_no,
        base_due_amount         = s.base_due_amount,
        base_disc_amount        = s.base_disc_amount,
        createdby               = s.createdby,
        createddate             = s.createddate,
        modifiedby              = s.modifiedby,
        modifieddate            = s.modifieddate,
        rev_flag                = s.rev_flag,
        etlactiveind            = 1,
        etljobname              = p_etljobname,
        envsourcecd             = p_envsourcecd,
        datasourcecd            = p_datasourcecd,
        etlupdatedatetime       = NOW()
    FROM stg.stg_ci_doc_payterm_dtl s
	LEFT JOIN dwh.d_company c     
    ON 	  s.company_code        = c.company_code
    WHERE t.tran_type 			= s.tran_type
    AND   t.tran_ou 			= s.tran_ou
    AND   t.tran_no 			= s.tran_no
    AND   t.pay_term 			= s.pay_term
    AND   t.term_no 			= s.term_no;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.f_cidocpaytermdtl
    (
		cidocpaytermdtl_company_key,
        tran_type, 			tran_ou, 			tran_no, 			pay_term, 		term_no, 
		timestamp, 			lo_id, 				batch_id, 			component_id, 	company_code, 
		due_date, 			due_amount_type, 	due_percent, 		due_amount, 	disc_comp_amount, 
		disc_amount_type, 	disc_date, 			disc_percent, 		disc_amount, 	penalty_percent, 
		esr_ref_no, 		base_due_amount, 	base_disc_amount, 	createdby, 		createddate, 
		modifiedby, 		modifieddate, 		rev_flag, 			etlactiveind, 	etljobname, 
		envsourcecd, 		datasourcecd, 		etlcreatedatetime
    )

    SELECT
		COALESCE(c.company_key,-1),
        s.tran_type, 		s.tran_ou, 			s.tran_no, 			s.pay_term, 		s.term_no, 
		s.timestamp, 		s.lo_id, 			s.batch_id, 		s.component_id, 	s.company_code, 
		s.due_date, 		s.due_amount_type, 	s.due_percent, 		s.due_amount, 		s.disc_comp_amount, 
		s.disc_amount_type, s.disc_date, 		s.disc_percent, 	s.disc_amount, 		s.penalty_percent, 
		s.esr_ref_no, 		s.base_due_amount, 	s.base_disc_amount, s.createdby, 		s.createddate, 
		s.modifiedby, 		s.modifieddate, 	s.rev_flag, 		1, 					p_etljobname, 
		p_envsourcecd, 		p_datasourcecd, 	NOW()
    FROM stg.stg_ci_doc_payterm_dtl s
	LEFT JOIN dwh.d_company c     
    ON 	  s.company_code     = c.company_code
    LEFT JOIN dwh.f_cidocpaytermdtl t
    ON 	  s.tran_type 		 = t.tran_type
    AND   s.tran_ou  		 = t.tran_ou
    AND   s.tran_no 		 = t.tran_no
    AND   s.pay_term 		 = t.pay_term
    AND   s.term_no 		 = t.term_no
    WHERE t.tran_type IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_ci_doc_payterm_dtl
    (
        tran_type, 			tran_ou, 			tran_no, 			pay_term, 			term_no, 
		timestamp, 			lo_id, 				batch_id, 			component_id, 		company_code, 
		due_date, 			due_amount_type, 	due_percent, 		due_amount, 		disc_comp_amount, 
		disc_amount_type, 	disc_date, 			disc_percent, 		disc_amount, 		penalty_percent, 
		esr_ref_no, 		esr_coding_line, 	base_due_amount, 	base_disc_amount, 	createdby, 
		createddate, 		modifiedby, 		modifieddate, 		payterm_version, 	rev_due_date, 
		rev_dis_date, 		rev_flag, 			etlcreateddatetime
    )
    SELECT
        tran_type, 			tran_ou, 			tran_no, 			pay_term, 			term_no, 
		timestamp, 			lo_id, 				batch_id, 			component_id, 		company_code, 
		due_date, 			due_amount_type, 	due_percent, 		due_amount, 		disc_comp_amount, 
		disc_amount_type, 	disc_date, 			disc_percent, 		disc_amount, 		penalty_percent, 
		esr_ref_no, 		esr_coding_line, 	base_due_amount, 	base_disc_amount, 	createdby, 
		createddate, 		modifiedby, 		modifieddate, 		payterm_version, 	rev_due_date, 
		rev_dis_date, 		rev_flag, 			etlcreateddatetime
    FROM stg.stg_ci_doc_payterm_dtl;
    
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
ALTER PROCEDURE dwh.usp_f_cidocpaytermdtl(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
