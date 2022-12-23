CREATE PROCEDURE dwh.usp_f_fbppostedtrndtl(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
    LANGUAGE plpgsql
    AS $$

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
    FROM stg.stg_fbp_posted_trn_dtl;

    
    INSERT INTO dwh.F_fbppostedtrndtl
    (
       fbp_trn_curr_key,fbp_trn_company_key ,timestamp, batch_id, company_code, component_name, bu_id, fb_id, tran_ou, fb_voucher_no, fb_voucher_date, recon_flag, document_no, tran_type, tran_date, entry_date, auth_date, posting_date, ou_id, account_code, drcr_flag, currency_code, tran_amount, base_amount, par_base_amount, exchange_rate, par_exchange_rate, narration, bank_code, analysis_code, subanalysis_code, cost_center, item_code, item_variant, quantity, tax_post_flag, mac_post_flag, reftran_fbid, reftran_no, reftran_ou, ref_tran_type, supcust_code, uom, mac_inc_flag, createdby, createddate, modifiedby, modifieddate, fin_year_code, fin_period_code, updated_flag, recon_date, hdrremarks, mlremarks, isRepupdated, afe_number, line_no, item_tcd_type, source_comp, defermentamount, ari_upd_flag, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        COALESCE(c.curr_key,-1),COALESCE(g.company_key,-1),s.timestamp, s.batch_id, s.company_code, s.component_name, s.bu_id, s.fb_id, s.tran_ou, s.fb_voucher_no, s.fb_voucher_date, s.recon_flag, s.document_no, s.tran_type, s.tran_date, s.entry_date, s.auth_date, s.posting_date, s.ou_id, s.account_code, s.drcr_flag, s.currency_code, s.tran_amount, s.base_amount, s.par_base_amount, s.exchange_rate, s.par_exchange_rate, s.narration, s.bank_code, s.analysis_code, s.subanalysis_code, s.cost_center, s.item_code, s.item_variant, s.quantity, s.tax_post_flag, s.mac_post_flag, s.reftran_fbid, s.reftran_no, s.reftran_ou, s.ref_tran_type, s.supcust_code, s.uom, s.mac_inc_flag, s.createdby, s.createddate, s.modifiedby, s.modifieddate, s.fin_year_code, s.fin_period_code, s.updated_flag, s.recon_date, s.hdrremarks, s.mlremarks, s.isRepupdated, s.afe_number, s.line_no, s.item_tcd_type, s.source_comp, s.defermentamount, s.ari_upd_flag, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_fbp_posted_trn_dtl s

      LEFT JOIN dwh.d_currency c      
    ON  s.currency_code          = c.iso_curr_code  
	
	 LEFT JOIN dwh.d_company g      
    ON  s.company_code          = g.company_code;  

    GET DIAGNOSTICS inscnt = ROW_COUNT;
	
	select 0 into updcnt;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_fbp_posted_trn_dtl
    (
        timestamp, batch_id, company_code, component_name, bu_id, fb_id, tran_ou, fb_voucher_no, fb_voucher_date, recon_flag, con_ref_voucherno, document_no, tran_type, tran_date, entry_date, auth_date, posting_date, ou_id, account_code, drcr_flag, currency_code, tran_amount, base_amount, par_base_amount, exchange_rate, par_exchange_rate, narration, bank_code, analysis_code, subanalysis_code, cost_center, item_code, item_variant, quantity, tax_post_flag, mac_post_flag, reftran_fbid, reftran_no, reftran_ou, ref_tran_type, supcust_code, uom, mac_inc_flag, createdby, createddate, modifiedby, modifieddate, fin_year_code, fin_period_code, updated_flag, recon_date, hdrremarks, mlremarks, isRepupdated, project_ou, Project_code, afe_number, job_number, Old_batch_id, line_no, item_tcd_type, consolidated, source_comp, defermentamount, ari_upd_flag, rowtype, etlcreateddatetime
    )
    SELECT
        timestamp, batch_id, company_code, component_name, bu_id, fb_id, tran_ou, fb_voucher_no, fb_voucher_date, recon_flag, con_ref_voucherno, document_no, tran_type, tran_date, entry_date, auth_date, posting_date, ou_id, account_code, drcr_flag, currency_code, tran_amount, base_amount, par_base_amount, exchange_rate, par_exchange_rate, narration, bank_code, analysis_code, subanalysis_code, cost_center, item_code, item_variant, quantity, tax_post_flag, mac_post_flag, reftran_fbid, reftran_no, reftran_ou, ref_tran_type, supcust_code, uom, mac_inc_flag, createdby, createddate, modifiedby, modifieddate, fin_year_code, fin_period_code, updated_flag, recon_date, hdrremarks, mlremarks, isRepupdated, project_ou, Project_code, afe_number, job_number, Old_batch_id, line_no, item_tcd_type, consolidated, source_comp, defermentamount, ari_upd_flag, rowtype, etlcreateddatetime
    FROM stg.stg_fbp_posted_trn_dtl;
    
    END IF;
   EXCEPTION WHEN others THEN
        get stacked diagnostics
            p_errorid   = returned_sqlstate,
            p_errordesc = message_text;
    CALL ods.usp_etlerrorinsert(p_sourceid, p_targetobject, p_dataflowflag, p_batchid,p_taskname, 'sp_ExceptionHandling', p_errorid, p_errordesc, null);
       select 0 into inscnt;
       select 0 into updcnt;
END;
$$;