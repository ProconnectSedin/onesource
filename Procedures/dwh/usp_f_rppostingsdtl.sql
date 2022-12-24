-- PROCEDURE: dwh.usp_f_rppostingsdtl(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_rppostingsdtl(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_rppostingsdtl(
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
    FROM stg.stg_rp_postings_dtl;

    UPDATE dwh.f_rppostingsdtl t
    SET
        rppostingsdtl_curr_key	 = COALESCE(cu.curr_key,-1),
		rppostingsdtl_company_key= COALESCE(co.company_key,-1),
        rppostingsdtl_datekey    = COALESCE(d.datekey,-1),
        rppostingsdtl_opcoa_key  = COALESCE(o.opcoa_key,-1),
        rtimestamp               = s.rtimestamp,
        fb_id                    = s.fb_id,
        bu_id                    = s.bu_id,
        tran_date                = s.tran_date,
        posting_date             = s.posting_date,
        account_currcode         = s.account_currcode,
        drcr_flag                = s.drcr_flag,
        currency_code            = s.currency_code,
        tran_amount              = s.tran_amount,
        base_amount              = s.base_amount,
        exchange_rate            = s.exchange_rate,
        par_base_amount          = s.par_base_amount,
        par_exchange_rate        = s.par_exchange_rate,
        analysis_code            = s.analysis_code,
        subanalysis_code         = s.subanalysis_code,
        cost_center              = s.cost_center,
        auth_date                = s.auth_date,
        narration                = s.narration,
        bank_code                = s.bank_code,
        mac_post_flag            = s.mac_post_flag,
        reftran_fbid             = s.reftran_fbid,
        reftran_no               = s.reftran_no,
        supcust_code             = s.supcust_code,
        reftran_ou               = s.reftran_ou,
        ref_tran_type            = s.ref_tran_type,
        createdby                = s.createdby,
        createddate              = s.createddate,
        ctrlacctype              = s.ctrlacctype,
        company_code             = s.company_code,
        batch_id                 = s.batch_id,
        component_name           = s.component_name,
        hdrremarks               = s.hdrremarks,
        mlremarks                = s.mlremarks,
        pdc_void_flag            = s.pdc_void_flag,
        check_no                 = s.check_no,
        line_no                  = s.line_no,
        etlactiveind             = 1,
        etljobname               = p_etljobname,
        envsourcecd              = p_envsourcecd,
        datasourcecd             = p_datasourcecd,
        etlupdatedatetime        = NOW()
    FROM stg.stg_rp_postings_dtl s
	LEFT JOIN dwh.d_currency cu 
		ON  s.currency_code				= cu.iso_curr_code
	LEFT JOIN dwh.d_company co 		
		ON  s.company_code 				= co.company_code 
    LEFT JOIN dwh.d_date d 		
		ON  s.posting_date::date 	    = d.dateactual
    LEFT JOIN dwh.d_operationalaccountdetail o 
		ON  s.account_code				= o.account_code
    WHERE t.ou_id 			= s.ou_id
    AND   t.serial_no 		= s.serial_no
    AND   t.unique_no 		= s.unique_no
    AND   t.doc_type 		= s.doc_type
    AND   t.tran_ou 		= s.tran_ou
    AND   t.document_no 	= s.document_no
    AND   t.account_code 	= s.account_code
    AND   t.tran_type 		= s.tran_type;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.f_rppostingsdtl
    (
        rppostingsdtl_curr_key, rppostingsdtl_company_key,  rppostingsdtl_datekey,  rppostingsdtl_opcoa_key,
        ou_id, 				serial_no, 			unique_no, 			doc_type, 			tran_ou, 
		document_no, 		account_code, 		tran_type, 			rtimestamp, 		fb_id, 
		bu_id, 				tran_date, 			posting_date, 		account_currcode, 	drcr_flag, 
		currency_code, 		tran_amount, 		base_amount, 		exchange_rate, 		par_base_amount, 
		par_exchange_rate, 	analysis_code, 		subanalysis_code, 	cost_center, 		auth_date, 
		narration, 			bank_code, 			mac_post_flag, 		reftran_fbid, 		reftran_no, 
		supcust_code, 		reftran_ou, 		ref_tran_type, 		createdby, 			createddate, 
		ctrlacctype, 		company_code, 		batch_id, 			component_name, 	hdrremarks, 
		mlremarks, 			pdc_void_flag, 		check_no, 			line_no, 			etlactiveind, 
		etljobname, 		envsourcecd, 		datasourcecd, 		etlcreatedatetime
    )

    SELECT
        COALESCE(cu.curr_key,-1),   COALESCE(co.company_key,-1),    COALESCE(d.datekey,-1), COALESCE(o.opcoa_key,-1),
        s.ou_id, 				s.serial_no, 			s.unique_no, 			s.doc_type, 			s.tran_ou, 
		s.document_no, 			s.account_code, 		s.tran_type, 			s.rtimestamp, 			s.fb_id, 
		s.bu_id, 				s.tran_date, 			s.posting_date, 		s.account_currcode, 	s.drcr_flag, 
		s.currency_code, 		s.tran_amount, 			s.base_amount, 			s.exchange_rate, 		s.par_base_amount, 
		s.par_exchange_rate, 	s.analysis_code, 		s.subanalysis_code, 	s.cost_center, 			s.auth_date, 
		s.narration, 			s.bank_code, 			s.mac_post_flag, 		s.reftran_fbid, 		s.reftran_no, 
		s.supcust_code, 		s.reftran_ou, 			s.ref_tran_type, 		s.createdby, 			s.createddate, 
		s.ctrlacctype, 			s.company_code, 		s.batch_id, 			s.component_name, 		s.hdrremarks, 
		s.mlremarks, 			s.pdc_void_flag, 		s.check_no, 			s.line_no, 				1, 
		p_etljobname, 			p_envsourcecd, 			p_datasourcecd, 		NOW()
    FROM stg.stg_rp_postings_dtl s
	LEFT JOIN dwh.d_currency cu 
		ON  s.currency_code				= cu.iso_curr_code
	LEFT JOIN dwh.d_company co 		
		ON  s.company_code 				= co.company_code 
    LEFT JOIN dwh.d_date d 		
		ON  s.posting_date::date 	    = d.dateactual
    LEFT JOIN dwh.d_operationalaccountdetail o 
		ON  s.account_code				= o.account_code
    LEFT JOIN dwh.f_rppostingsdtl t
    ON 	s.ou_id 		= t.ou_id
    AND s.serial_no 	= t.serial_no
    AND s.unique_no 	= t.unique_no
    AND s.doc_type 		= t.doc_type
    AND s.tran_ou 		= t.tran_ou
    AND s.document_no 	= t.document_no
    AND s.account_code 	= t.account_code
    AND s.tran_type 	= t.tran_type
    WHERE t.ou_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_rp_postings_dtl
    (
        ou_id, 				serial_no, 			unique_no, 			doc_type, 			tran_ou, 
		document_no, 		account_code, 		tran_type, 			rtimestamp, 		fb_id, 
		bu_id, 				tran_date, 			posting_date, 		account_currcode, 	drcr_flag, 
		currency_code, 		tran_amount, 		base_amount, 		exchange_rate, 		par_base_amount, 
		par_exchange_rate, 	analysis_code, 		subanalysis_code, 	cost_center, 		entry_date, 
		auth_date, 			narration, 			bank_code, 			item_code, 			item_varinat, 
		quantity, 			mac_post_flag, 		reftran_fbid, 		reftran_no, 		supcust_code, 
		reftran_ou, 		ref_tran_type, 		uom, 				createdby, 			createddate, 
		modifiedby, 		modifieddate, 		ctrlacctype, 		company_code, 		batch_id, 
		component_name, 	hdrremarks, 		mlremarks, 			pdc_void_flag, 		project_ou, 
		Project_code, 		afe_number, 		job_number, 		refcostcenter_hdr, 	check_no, 
		line_no, 			etlcreateddatetime
    )
    SELECT
        ou_id, 				serial_no, 			unique_no, 			doc_type, 			tran_ou, 
		document_no, 		account_code, 		tran_type, 			rtimestamp, 		fb_id, 
		bu_id, 				tran_date, 			posting_date, 		account_currcode, 	drcr_flag, 
		currency_code, 		tran_amount, 		base_amount, 		exchange_rate, 		par_base_amount, 
		par_exchange_rate, 	analysis_code, 		subanalysis_code, 	cost_center, 		entry_date, 
		auth_date, 			narration, 			bank_code, 			item_code, 			item_varinat, 
		quantity, 			mac_post_flag, 		reftran_fbid, 		reftran_no, 		supcust_code, 
		reftran_ou, 		ref_tran_type, 		uom, 				createdby, 			createddate, 
		modifiedby, 		modifieddate, 		ctrlacctype, 		company_code, 		batch_id, 
		component_name, 	hdrremarks, 		mlremarks, 			pdc_void_flag, 		project_ou, 
		Project_code, 		afe_number, 		job_number, 		refcostcenter_hdr, 	check_no, 
		line_no, 			etlcreateddatetime
    FROM stg.stg_rp_postings_dtl;
    
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
ALTER PROCEDURE dwh.usp_f_rppostingsdtl(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
