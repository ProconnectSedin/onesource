-- PROCEDURE: dwh.usp_f_stnacctinfodtl(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_stnacctinfodtl(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_stnacctinfodtl(
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
    FROM stg.stg_stn_acct_info_dtl;

    UPDATE dwh.F_stnacctinfodtl t
    SET
	
		account_code_key		= COALESCE(acc.opcoa_key, -1),
		comp_code_key			= COALESCE(co.company_key,-1),
		currency_key			= COALESCE(cr.curr_key, -1),
		date_key				= COALESCE(d.datekey,-1),
		supp_key				= COALESCE(v.vendor_key,-1),
        ou_id                  = s.ou_id,
        company_code           = s.company_code,
        tran_no                = s.tran_no,
        tran_type              = s.tran_type,
        account_code           = s.account_code,
        drcr_flag              = s.drcr_flag,
        account_type           = s.account_type,
        tran_date              = s.tran_date,
        fin_post_date          = s.fin_post_date,
        currency_code          = s.currency_code,
        tran_amount            = s.tran_amount,
        fb_id                  = s.fb_id,
        basecur_erate          = s.basecur_erate,
        base_amount            = s.base_amount,
        pbcur_erate            = s.pbcur_erate,
        par_base_amt           = s.par_base_amt,
        fin_post_status        = s.fin_post_status,
        guid                   = s.guid,
        transfer_docno         = s.transfer_docno,
        bu_id                  = s.bu_id,
        supplier_code          = s.supplier_code,
        hdrremarks             = s.hdrremarks,
        etlactiveind           = 1,
        etljobname             = p_etljobname,
        envsourcecd            = p_envsourcecd,
        datasourcecd           = p_datasourcecd,
        etlupdatedatetime      = NOW()
    FROM stg.stg_stn_acct_info_dtl s
	
		LEFT JOIN dwh.d_operationalaccountdetail acc
        ON acc.account_code             = s.account_code
		LEFT JOIN dwh.d_company co     
    	ON  s.company_code                   = co.company_code 
 		LEFT JOIN dwh.d_currency cr
        ON cr.iso_curr_code             = s.currency_code
		LEFT JOIN dwh.d_date d     
   		ON  s.tran_date::date     = d.dateactual
	
		LEFT JOIN dwh.d_vendor V                
        ON s.supplier_code  = V.vendor_id 
        AND s.ou_id::integer        = V.vendor_ou

    WHERE t.ou_id = s.ou_id
    AND t.company_code = s.company_code
    AND t.tran_no = s.tran_no
    AND t.tran_type = s.tran_type
    AND t.account_code = s.account_code
    AND t.drcr_flag = s.drcr_flag
    AND t.account_type = s.account_type;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_stnacctinfodtl
    (
      	account_code_key,comp_code_key,currency_key,date_key,supp_key,ou_id, company_code, tran_no, tran_type, account_code, drcr_flag, account_type, tran_date, fin_post_date, currency_code, tran_amount, fb_id, basecur_erate, base_amount, pbcur_erate, par_base_amt, fin_post_status, guid, transfer_docno, bu_id, supplier_code, hdrremarks, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        COALESCE(acc.opcoa_key, -1),COALESCE(co.company_key,-1),COALESCE(cr.curr_key, -1),COALESCE(d.datekey,-1),COALESCE(v.vendor_key,-1),   s.ou_id, s.company_code, s.tran_no, s.tran_type, s.account_code, s.drcr_flag, s.account_type, s.tran_date, s.fin_post_date, s.currency_code, s.tran_amount, s.fb_id, s.basecur_erate, s.base_amount, s.pbcur_erate, s.par_base_amt, s.fin_post_status, s.guid, s.transfer_docno, s.bu_id, s.supplier_code, s.hdrremarks, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_stn_acct_info_dtl s
		LEFT JOIN dwh.d_operationalaccountdetail acc
        ON acc.account_code             = s.account_code
		LEFT JOIN dwh.d_company co     
    	ON  s.company_code                   = co.company_code 
 		LEFT JOIN dwh.d_currency cr
        ON cr.iso_curr_code             = s.currency_code
		LEFT JOIN dwh.d_date d     
   		ON  s.tran_date::date     = d.dateactual
	
		LEFT JOIN dwh.d_vendor V                
        ON s.supplier_code  = V.vendor_id 
        AND s.ou_id::integer        = V.vendor_ou
    LEFT JOIN dwh.F_stnacctinfodtl t
    ON s.ou_id = t.ou_id
    AND s.company_code = t.company_code
    AND s.tran_no = t.tran_no
    AND s.tran_type = t.tran_type
    AND s.account_code = t.account_code
    AND s.drcr_flag = t.drcr_flag
    AND s.account_type = t.account_type
    WHERE t.ou_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_stn_acct_info_dtl
    (
        ou_id, company_code, tran_no, tran_type, account_code, drcr_flag, account_type, tran_date, fin_post_date, currency_code, cost_center, tran_amount, fb_id, analysis_code, subanalysis_code, basecur_erate, base_amount, pbcur_erate, par_base_amt, fin_post_status, guid, transfer_docno, acct_line_no, bu_id, supplier_code, hdrremarks, project_ou, Project_code, etlcreateddatetime
    )
    SELECT
        ou_id, company_code, tran_no, tran_type, account_code, drcr_flag, account_type, tran_date, fin_post_date, currency_code, cost_center, tran_amount, fb_id, analysis_code, subanalysis_code, basecur_erate, base_amount, pbcur_erate, par_base_amt, fin_post_status, guid, transfer_docno, acct_line_no, bu_id, supplier_code, hdrremarks, project_ou, Project_code, etlcreateddatetime
    FROM stg.stg_stn_acct_info_dtl;
    
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
ALTER PROCEDURE dwh.usp_f_stnacctinfodtl(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
