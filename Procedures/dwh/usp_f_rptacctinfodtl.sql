-- PROCEDURE: dwh.usp_f_rptacctinfodtl(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_rptacctinfodtl(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_rptacctinfodtl(
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
    FROM stg.stg_rpt_acct_info_dtl;

    UPDATE dwh.F_rptacctinfodtl t
    SET
        rptacctinfodtl_curr_key	 = COALESCE(cu.curr_key,-1),
		rptacctinfodtl_company_key= COALESCE(co.company_key,-1),
        rptacctinfodtl_datekey    = COALESCE(d.datekey,-1),
        rptacctinfodtl_opcoa_key  = COALESCE(o.opcoa_key,-1),
        fin_post_date           = s.fin_post_date,
        currency                = s.currency,
        cost_center             = s.cost_center,
        tran_amount             = s.tran_amount,
        analysis_code           = s.analysis_code,
        subanalysis_code        = s.subanalysis_code,
        basecur_erate           = s.basecur_erate,
        base_amount             = s.base_amount,
        par_base_amt            = s.par_base_amt,
        batch_id                = s.batch_id,
        account_type            = s.account_type,
        company_id              = s.company_id,
        component_id            = s.component_id,
        bu_id                   = s.bu_id,
        tran_date               = s.tran_date,
        createdby               = s.createdby,
        createddate             = s.createddate,
        modifiedby              = s.modifiedby,
        source_comp             = s.source_comp,
        etlactiveind            = 1,
        etljobname              = p_etljobname,
        envsourcecd             = p_envsourcecd,
        datasourcecd            = p_datasourcecd,
        etlupdatedatetime       = NOW()
    FROM stg.stg_rpt_acct_info_dtl s
	LEFT JOIN dwh.d_currency cu 
		ON  s.currency				= cu.iso_curr_code
	LEFT JOIN dwh.d_company co 		
		ON  s.company_id 			= co.company_code
    LEFT JOIN dwh.d_date d 		
		ON  s.tran_date::date 	    = d.dateactual
    LEFT JOIN dwh.d_operationalaccountdetail o 
		ON  s.account_code				= o.account_code
    WHERE t.ou_id = s.ou_id
    AND t.tran_no = s.tran_no
    AND t.fb_id = s.fb_id
    AND t.account_code = s.account_code
    AND t.tran_type = s.tran_type
    AND t.drcr_flag = s.drcr_flag
    AND t.posting_line_no = s.posting_line_no;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_rptacctinfodtl
    (
		rptacctinfodtl_curr_key,			rptacctinfodtl_company_key, rptacctinfodtl_datekey, rptacctinfodtl_opcoa_key,
        ou_id,			 tran_no, 			fb_id, 				account_code, 		tran_type, 
		drcr_flag, 		 posting_line_no, 	fin_post_date, 		currency, 			cost_center, 
		tran_amount, 	 analysis_code, 	subanalysis_code, 	basecur_erate, 		base_amount, 
		par_base_amt, 	 batch_id, 			account_type, 		company_id, 		component_id, 
		bu_id, 			 tran_date, 		createdby, 			createddate, 		modifiedby, 
		source_comp, 	 etlactiveind, 		etljobname, 		envsourcecd, 		datasourcecd, 
		etlcreatedatetime
    )

    SELECT
		COALESCE(cu.curr_key,-1),			COALESCE(co.company_key,-1),    COALESCE(d.datekey,-1), COALESCE(o.opcoa_key,-1),
        s.ou_id,			 s.tran_no, 			s.fb_id, 				s.account_code, 		s.tran_type, 
		s.drcr_flag, 		 s.posting_line_no, 	s.fin_post_date, 		s.currency, 			s.cost_center, 
		s.tran_amount, 	 	 s.analysis_code, 		s.subanalysis_code, 	s.basecur_erate, 		s.base_amount, 
		s.par_base_amt, 	 s.batch_id, 			s.account_type, 		s.company_id, 		    s.component_id, 
		s.bu_id, 			 s.tran_date, 			s.createdby, 			s.createddate, 		    s.modifiedby, 
		s.source_comp, 
        1, 				 	 p_etljobname, 			p_envsourcecd, 			p_datasourcecd, 		NOW()
    FROM stg.stg_rpt_acct_info_dtl s
	LEFT JOIN dwh.d_currency cu 
		ON  s.currency				= cu.iso_curr_code
	LEFT JOIN dwh.d_company co 		
		ON  s.company_id 			= co.company_code
    LEFT JOIN dwh.d_date d 		
		ON  s.tran_date::date 	    = d.dateactual
    LEFT JOIN dwh.d_operationalaccountdetail o 
		ON  s.account_code				= o.account_code
    LEFT JOIN dwh.F_rptacctinfodtl t
    ON s.ou_id = t.ou_id
    AND s.tran_no = t.tran_no
    AND s.fb_id = t.fb_id
    AND s.account_code = t.account_code
    AND s.tran_type = t.tran_type
    AND s.drcr_flag = t.drcr_flag
    AND s.posting_line_no = t.posting_line_no
    WHERE t.ou_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_rpt_acct_info_dtl
    (
        ou_id, 			tran_no, 			fb_id, 				account_code, 		tran_type, 
		drcr_flag, 		posting_line_no, 	fin_post_date, 		currency, 			cost_center, 
		tran_amount, 	analysis_code, 		subanalysis_code, 	basecur_erate, 		base_amount, 
		pbcur_erate, 	par_base_amt, 		fin_post_status, 	batch_id, 			account_type, 
		flag, 			company_id, 		component_id, 		bu_id, 				tran_date, 
		createdby, 		createddate, 		modifiedby, 		modifieddate, 		source_comp, 
		project_ou, 	Project_code, 		etlcreateddatetime
    )
    SELECT
        ou_id, 			tran_no, 			fb_id, 				account_code, 		tran_type, 
		drcr_flag, 		posting_line_no, 	fin_post_date, 		currency, 			cost_center, 
		tran_amount, 	analysis_code, 		subanalysis_code, 	basecur_erate, 		base_amount, 
		pbcur_erate, 	par_base_amt, 		fin_post_status, 	batch_id, 			account_type, 
		flag, 			company_id, 		component_id, 		bu_id, 				tran_date, 
		createdby, 		createddate, 		modifiedby, 		modifieddate, 		source_comp, 
		project_ou, 	Project_code, 		etlcreateddatetime
    FROM stg.stg_rpt_acct_info_dtl;
    
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
ALTER PROCEDURE dwh.usp_f_rptacctinfodtl(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
