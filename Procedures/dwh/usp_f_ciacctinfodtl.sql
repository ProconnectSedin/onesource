-- PROCEDURE: dwh.usp_f_ciacctinfodtl(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_ciacctinfodtl(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_ciacctinfodtl(
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
    FROM stg.stg_ci_acct_info_dtl;

    UPDATE dwh.F_ciacctinfodtl t
    SET
		ciacctinfodtl_company_key  = COALESCE(co.company_key,-1),
		ciacctinfodtl_opcoa_key    = COALESCE(ac.opcoa_key,-1),
		ciacctinfodtl_date_key     = COALESCE(d.datekey,-1),
		ciacctinfodtl_itm_hdr_key  = COALESCE(i.itm_hdr_key,-1),
		ciacctinfodtl_curr_key     = COALESCE(c.curr_key,-1),
		batch_id                   = s.batch_id,
        lo_id                      = s.lo_id,
        txnou_id                   = s.txnou_id,
        bu_id                      = s.bu_id,
        tran_date                  = s.tran_date,
        tran_amount_acc_cur        = s.tran_amount_acc_cur,
        ctrl_acct_type             = s.ctrl_acct_type,
        auto_post_acct_type        = s.auto_post_acct_type,
        analysis_code              = s.analysis_code,
        subanalysis_code           = s.subanalysis_code,
        cost_center                = s.cost_center,
        item_code                  = s.item_code,
        item_variant               = s.item_variant,
        uom                        = s.uom,
        supcust_code               = s.supcust_code,
        acct_currency              = s.acct_currency,
        basecur_erate              = s.basecur_erate,
        base_amount                = s.base_amount,
        par_exchange_rate          = s.par_exchange_rate,
        par_base_amount            = s.par_base_amount,
        auth_date                  = s.auth_date,
        ref_doc_no                 = s.ref_doc_no,
        createdby                  = s.createdby,
        createddate                = s.createddate,
        posting_date               = s.posting_date,
        base_currency              = s.base_currency,
        modifiedby                 = s.modifiedby,
        modifieddate               = s.modifieddate,
        vat_posting_flag           = s.vat_posting_flag,
        account_type               = s.account_type,
        ref_doc_lineno             = s.ref_doc_lineno,
        ibe_flag                   = s.ibe_flag,
        fbp_post_flag              = s.fbp_post_flag,
        fin_year                   = s.fin_year,
        fin_period                 = s.fin_period,
        hdrremarks                 = s.hdrremarks,
        mlremarks                  = s.mlremarks,
        instr_no                   = s.instr_no,
        etlactiveind               = 1,
        etljobname                 = p_etljobname,
        envsourcecd                = p_envsourcecd,
        datasourcecd               = p_datasourcecd,
        etlupdatedatetime          = NOW()
    FROM stg.stg_ci_acct_info_dtl s
	LEFT JOIN dwh.d_company co     
    ON 	  s.company_code  		   = co.company_code 
	LEFT JOIN dwh.d_operationalaccountdetail ac     
    ON 	  s.account_code  		   = ac.account_code
	LEFT JOIN dwh.d_date d     
    ON 	  s.posting_date::date 	   = d.dateactual
	LEFT JOIN dwh.d_itemheader i     
    ON 	  s.tran_ou  		   	   = i.itm_ou
	AND   s.item_code			   = i.itm_code
	LEFT JOIN dwh.d_currency c     
    ON 	  s.acct_currency  		   = c.iso_curr_code	
    WHERE t.tran_ou 			   = s.tran_ou
    AND   t.tran_type 			   = s.tran_type
    AND   t.tran_no 			   = s.tran_no
    AND   t.component_id 		   = s.component_id
    AND   t.company_code 		   = s.company_code
    AND   t.fb_id 				   = s.fb_id
    AND   t.account_code 		   = s.account_code
    AND   t.drcr_flag              = s.drcr_flag
    AND   t.line_no 			   = s.line_no;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_ciacctinfodtl
    (
		ciacctinfodtl_company_key,	ciacctinfodtl_opcoa_key,	ciacctinfodtl_date_key,	ciacctinfodtl_itm_hdr_key,	ciacctinfodtl_curr_key,
        tran_ou, 					tran_type, 					tran_no, 				component_id, 				company_code, 
		fb_id, 						account_code, 				drcr_flag, 				line_no, 					batch_id, 
		lo_id, 						txnou_id, 					bu_id, 					tran_date, 					tran_amount_acc_cur, 
		ctrl_acct_type, 			auto_post_acct_type, 		analysis_code, 			subanalysis_code, 			cost_center, 
		item_code, 					item_variant, 				uom, 					supcust_code, 				acct_currency, 
		basecur_erate, 				base_amount, 				par_exchange_rate, 		par_base_amount, 			auth_date, 
		ref_doc_no, 				createdby, 					createddate, 			posting_date, 				base_currency, 
		modifiedby, 				modifieddate, 				vat_posting_flag, 		account_type, 				ref_doc_lineno, 
		ibe_flag, 					fbp_post_flag, 				fin_year, 				fin_period, 				hdrremarks, 
		mlremarks, 					instr_no, 					etlactiveind, 			etljobname, 				envsourcecd, 
		datasourcecd, 				etlcreatedatetime
    )

    SELECT
		COALESCE(co.company_key,-1),	COALESCE(ac.opcoa_key,-1),		COALESCE(d.datekey,-1),		COALESCE(i.itm_hdr_key,-1),		COALESCE(c.curr_key,-1),
        s.tran_ou, 						s.tran_type, 					s.tran_no, 					s.component_id, 				s.company_code, 
		s.fb_id, 						s.account_code, 				s.drcr_flag, 				s.line_no, 						s.batch_id, 
		s.lo_id, 						s.txnou_id, 					s.bu_id, 					s.tran_date, 					s.tran_amount_acc_cur, 
		s.ctrl_acct_type, 				s.auto_post_acct_type, 			s.analysis_code, 			s.subanalysis_code, 			s.cost_center, 
		s.item_code, 					s.item_variant, 				s.uom, 						s.supcust_code, 				s.acct_currency, 
		s.basecur_erate, 				s.base_amount, 					s.par_exchange_rate, 		s.par_base_amount, 				s.auth_date, 
		s.ref_doc_no, 					s.createdby, 					s.createddate, 				s.posting_date, 				s.base_currency, 
		s.modifiedby, 					s.modifieddate, 				s.vat_posting_flag, 		s.account_type, 				s.ref_doc_lineno, 
		s.ibe_flag, 					s.fbp_post_flag, 				s.fin_year, 				s.fin_period, 					s.hdrremarks, 
		s.mlremarks, 					s.instr_no, 					1, 							p_etljobname, 					p_envsourcecd, 
		p_datasourcecd, 				NOW()
    FROM stg.stg_ci_acct_info_dtl s
	LEFT JOIN dwh.d_company co     
    ON 	  s.company_code  		   = co.company_code 
	LEFT JOIN dwh.d_operationalaccountdetail ac     
    ON 	  s.account_code  		   = ac.account_code
	LEFT JOIN dwh.d_date d     
    ON 	  s.posting_date::date 	   = d.dateactual
	LEFT JOIN dwh.d_itemheader i     
    ON 	  s.tran_ou  		   	   = i.itm_ou
	AND   s.item_code			   = i.itm_code
	LEFT JOIN dwh.d_currency c     
    ON 	  s.acct_currency  		   = c.iso_curr_code
    LEFT JOIN dwh.F_ciacctinfodtl t
    ON    s.tran_ou 			   = t.tran_ou
    AND   s.tran_type 			   = t.tran_type
    AND   s.tran_no 			   = t.tran_no
    AND   s.component_id 		   = t.component_id
    AND   s.company_code 		   = t.company_code
    AND   s.fb_id 				   = t.fb_id
    AND   s.account_code 		   = t.account_code
    AND   s.drcr_flag 			   = t.drcr_flag
    AND   s.line_no 			   = t.line_no
    WHERE t.tran_ou IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_ci_acct_info_dtl
    (
        tran_ou, 			tran_type, 				tran_no, 			component_id, 			company_code, 
		fb_id, 				account_code, 			drcr_flag, 			line_no, 				timestamp, 
		batch_id, 			lo_id, 					txnou_id, 			bu_id, 					tran_date, 
		tran_qty, 			tran_amount_acc_cur, 	ctrl_acct_type, 	auto_post_acct_type, 	analysis_code, 
		subanalysis_code, 	cost_center, 			bank_code, 			item_code, 				item_variant, 
		uom, 				supcust_code, 			acct_currency, 		basecur_erate, 			base_amount, 
		par_exchange_rate, 	par_base_amount, 		narration, 			auth_date, 				ref_doc_ou, 
		ref_doc_fb_id, 		ref_doc_type, 			ref_doc_no, 		vat_decl_year, 			vat_decl_period, 
		vat_usage_flag, 	vat_category, 			vat_class, 			vat_code, 				vat_rate, 
		createdby, 			createddate, 			posting_date, 		posting_status, 		base_currency, 
		par_base_currency, 	modifiedby, 			modifieddate, 		vat_posting_flag, 		vat_posting_date, 
		account_type, 		vat_line_no, 			vatusage, 			ref_doc_lineno, 		ibe_flag, 
		fbp_post_flag, 		fin_year, 				fin_period, 		hdrremarks, 			mlremarks, 
		oldguid_regen, 		oldcomp_regen, 			pdc_status, 		instr_no, 				defermentamount, 
		address_id, 		etlcreateddatetime
    )
    SELECT
        tran_ou, 			tran_type, 				tran_no, 			component_id, 			company_code, 
		fb_id, 				account_code, 			drcr_flag, 			line_no, 				timestamp, 
		batch_id, 			lo_id, 					txnou_id, 			bu_id, 					tran_date, 
		tran_qty, 			tran_amount_acc_cur, 	ctrl_acct_type, 	auto_post_acct_type, 	analysis_code, 
		subanalysis_code, 	cost_center, 			bank_code, 			item_code, 				item_variant, 
		uom, 				supcust_code, 			acct_currency, 		basecur_erate, 			base_amount, 
		par_exchange_rate, 	par_base_amount, 		narration, 			auth_date, 				ref_doc_ou, 
		ref_doc_fb_id, 		ref_doc_type, 			ref_doc_no, 		vat_decl_year, 			vat_decl_period, 
		vat_usage_flag, 	vat_category, 			vat_class, 			vat_code, 				vat_rate, 
		createdby, 			createddate, 			posting_date, 		posting_status, 		base_currency, 
		par_base_currency, 	modifiedby, 			modifieddate, 		vat_posting_flag, 		vat_posting_date, 
		account_type, 		vat_line_no, 			vatusage, 			ref_doc_lineno, 		ibe_flag, 
		fbp_post_flag, 		fin_year, 				fin_period, 		hdrremarks, 			mlremarks, 
		oldguid_regen, 		oldcomp_regen, 			pdc_status, 		instr_no, 				defermentamount, 
		address_id, 		etlcreateddatetime
    FROM stg.stg_ci_acct_info_dtl;
    
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
ALTER PROCEDURE dwh.usp_f_ciacctinfodtl(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
