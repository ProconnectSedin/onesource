-- PROCEDURE: dwh.usp_f_sinappostingsdtl(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_sinappostingsdtl(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_sinappostingsdtl(
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
	p_depsource VARCHAR(100);

BEGIN
    SELECT d.jobname, h.envsourcecode, h.datasourcecode, d.latestbatchid, d.targetprocedurename, h.rawstorageflag,h.depsource
    INTO p_etljobname, p_envsourcecd, p_datasourcecd, p_batchid, p_taskname, p_rawstorageflag,p_depsource
    FROM ods.controldetail d
    INNER JOIN ods.controlheader h
        ON d.sourceid = h.sourceid
    WHERE d.sourceid = p_sourceId
        AND d.dataflowflag = p_dataflowflag
        AND d.targetobject = p_targetobject;

    SELECT COUNT(1) INTO srccnt
    FROM stg.stg_sin_ap_postings_dtl;

    UPDATE dwh.f_sinappostingsdtl t
    SET
        line_no                  = s.line_no,
        company_code             = s.company_code,
        posting_status           = s.posting_status,
        posting_date             = s.posting_date,
        fb_id                    = s.fb_id,
        tran_date                = s.tran_date,
        account_type             = s.account_type,
        account_code             = s.account_code,
        drcr_id                  = s.drcr_id,
        tran_currency            = s.tran_currency,
        tran_amount              = s.tran_amount,
        exchange_rate            = s.exchange_rate,
        base_amount              = s.base_amount,
        par_exchange_rate        = s.par_exchange_rate,
        par_base_amount          = s.par_base_amount,
        cost_center              = s.cost_center,
        analysis_code            = s.analysis_code,
        subanalysis_code         = s.subanalysis_code,
        guid                     = s.guid,
        item_code                = s.item_code,
        item_variant             = s.item_variant,
        quantity                 = s.quantity,
        reftran_fbid             = s.reftran_fbid,
        reftran_no               = s.reftran_no,
        reftran_ou               = s.reftran_ou,
        ref_tran_type            = s.ref_tran_type,
        supp_code                = s.supp_code,
        uom                      = s.uom,
        source_comp              = s.source_comp,
        hdrremarks               = s.hdrremarks,
        mlremarks                = s.mlremarks,
        roundoff_flag            = s.roundoff_flag,
        item_tcd_type            = s.item_tcd_type,
    	a_timestamp	  			 = s.timestamp,
        etlactiveind             = 1,
        etljobname               = p_etljobname,
        envsourcecd              = p_envsourcecd,
        datasourcecd             = p_datasourcecd,
        etlupdatedatetime        = NOW()
    FROM stg.stg_sin_ap_postings_dtl s
    WHERE t.tran_type =		s.tran_type
    AND t.tran_ou	  =		s.tran_ou
    AND t.tran_no	  =		s.tran_no
    AND t.posting_line_no = s.posting_line_no;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.f_sinappostingsdtl
    (
        tran_type, tran_ou, tran_no, posting_line_no, a_timestamp, line_no, company_code, posting_status, posting_date, 
		fb_id, tran_date, account_type, account_code, drcr_id, tran_currency, tran_amount, exchange_rate, base_amount, par_exchange_rate, 
		par_base_amount, cost_center, analysis_code, subanalysis_code, guid, item_code, item_variant, quantity, reftran_fbid, reftran_no, 
		reftran_ou, ref_tran_type, supp_code, uom, source_comp, hdrremarks, mlremarks, roundoff_flag, item_tcd_type, 
		etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        s.tran_type, s.tran_ou, s.tran_no, s.posting_line_no, s.timestamp, s.line_no, s.company_code, s.posting_status, s.posting_date, 
		s.fb_id, s.tran_date, s.account_type, s.account_code, s.drcr_id, s.tran_currency, s.tran_amount, s.exchange_rate, 
		s.base_amount, s.par_exchange_rate, s.par_base_amount, s.cost_center, s.analysis_code, s.subanalysis_code, s.guid, s.item_code, s.item_variant, s.quantity, s.reftran_fbid, s.reftran_no, 
		s.reftran_ou, s.ref_tran_type, s.supp_code, s.uom, s.source_comp, s.hdrremarks, s.mlremarks, s.roundoff_flag, s.item_tcd_type, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_sin_ap_postings_dtl s
    LEFT JOIN dwh.f_sinappostingsdtl t
    ON s.tran_type = t.tran_type
    AND s.tran_ou = t.tran_ou
    AND s.tran_no = t.tran_no
    AND s.posting_line_no = t.posting_line_no
    WHERE t.tran_type IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_sin_ap_postings_dtl
    (
        tran_type, tran_ou, tran_no, posting_line_no, timestamp, line_no, company_code, posting_status, posting_date, fb_id, tran_date, account_type, account_code, drcr_id, tran_currency, tran_amount, exchange_rate, base_amount, par_exchange_rate, par_base_amount, cost_center, analysis_code, subanalysis_code, guid, entry_date, auth_date, item_code, item_variant, quantity, reftran_fbid, reftran_no, reftran_ou, ref_tran_type, supp_code, uom, org_vat_base_amt, createdby, createddate, modifiedby, modifieddate, vat_line_no, vatusageid, source_comp, hdrremarks, mlremarks, roundoff_flag, item_tcd_type, rowtype, etlcreateddatetime
    )
    SELECT
        tran_type, tran_ou, tran_no, posting_line_no, timestamp, line_no, company_code, posting_status, posting_date, fb_id, tran_date, account_type, account_code, drcr_id, tran_currency, tran_amount, exchange_rate, base_amount, par_exchange_rate, par_base_amount, cost_center, analysis_code, subanalysis_code, guid, entry_date, auth_date, item_code, item_variant, quantity, reftran_fbid, reftran_no, reftran_ou, ref_tran_type, supp_code, uom, org_vat_base_amt, createdby, createddate, modifiedby, modifieddate, vat_line_no, vatusageid, source_comp, hdrremarks, mlremarks, roundoff_flag, item_tcd_type, rowtype, etlcreateddatetime
    FROM stg.stg_sin_ap_postings_dtl;
    
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
ALTER PROCEDURE dwh.usp_f_sinappostingsdtl(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
