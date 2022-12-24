CREATE OR REPLACE PROCEDURE dwh.usp_f_sadadjvcrdocdtl(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
    FROM stg.stg_sad_adjv_crdoc_dtl;

    UPDATE dwh.F_sadadjvcrdocdtl t
    SET
        sadadjvcrdocdtl_curr_key	= COALESCE(cu.curr_key,-1),
        tran_type                  = s.tran_type,
        cr_doc_adj_amt             = s.cr_doc_adj_amt,
        discount                   = s.discount,
        proposed_discount          = s.proposed_discount,
        cost_center                = s.cost_center,
        analysis_code              = s.analysis_code,
        subanalysis_code           = s.subanalysis_code,
        au_cr_doc_unadj_amt        = s.au_cr_doc_unadj_amt,
        au_cr_doc_cur              = s.au_cr_doc_cur,
        au_crosscur_erate          = s.au_crosscur_erate,
        au_discount_date           = s.au_discount_date,
        au_cr_doc_date             = s.au_cr_doc_date,
        au_fb_id                   = s.au_fb_id,
        parent_key                 = s.parent_key,
        current_key                = s.current_key,
        au_disc_available          = s.au_disc_available,
        au_due_date                = s.au_due_date,
        au_billing_point           = s.au_billing_point,
        voucher_tran_type          = s.voucher_tran_type,
        batch_id                   = s.batch_id,
        etlactiveind               = 1,
        etljobname                 = p_etljobname,
        envsourcecd                = p_envsourcecd,
        datasourcecd               = p_datasourcecd,
        etlupdatedatetime          = NOW()
    FROM stg.stg_sad_adjv_crdoc_dtl s
	LEFT JOIN dwh.d_currency cu 
		ON  s.au_cr_doc_cur				= cu.iso_curr_code
    WHERE t.ou_id = s.ou_id
    AND t.adj_voucher_no = s.adj_voucher_no
    AND t.cr_doc_ou = s.cr_doc_ou
    AND t.cr_doc_no = s.cr_doc_no
    AND t.term_no = s.term_no
    AND t.cr_doc_type = s.cr_doc_type;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_sadadjvcrdocdtl
    (
		sadadjvcrdocdtl_curr_key,
        ou_id, 				adj_voucher_no, 	cr_doc_ou, 			cr_doc_no, 				term_no, 
		cr_doc_type, 		tran_type, 			cr_doc_adj_amt, 	discount, 				proposed_discount, 
		cost_center, 		analysis_code, 		subanalysis_code, 	au_cr_doc_unadj_amt, 	au_cr_doc_cur, 
		au_crosscur_erate, 	au_discount_date, 	au_cr_doc_date, 	au_fb_id, 				parent_key, 
		current_key, 		au_disc_available,  au_due_date, 		au_billing_point, 		voucher_tran_type, 
		batch_id, 			etlactiveind, 		etljobname, 		envsourcecd, 			datasourcecd, 
		etlcreatedatetime
    )

    SELECT
		COALESCE(cu.curr_key,-1),
        s.ou_id, 				s.adj_voucher_no, 		s.cr_doc_ou, 			s.cr_doc_no, 				s.term_no, 
		s.cr_doc_type, 			s.tran_type, 			s.cr_doc_adj_amt, 		s.discount, 				s.proposed_discount, 
		s.cost_center, 			s.analysis_code, 		s.subanalysis_code, 	s.au_cr_doc_unadj_amt, 		s.au_cr_doc_cur, 
		s.au_crosscur_erate, 	s.au_discount_date, 	s.au_cr_doc_date, 		s.au_fb_id, 				s.parent_key, 
		s.current_key, 			s.au_disc_available,  	s.au_due_date, 			s.au_billing_point, 		s.voucher_tran_type, 
		s.batch_id, 
		1, 						p_etljobname, 			p_envsourcecd, 			p_datasourcecd, NOW()
    FROM stg.stg_sad_adjv_crdoc_dtl s
	LEFT JOIN dwh.d_currency cu 
		ON  s.au_cr_doc_cur				= cu.iso_curr_code
    LEFT JOIN dwh.F_sadadjvcrdocdtl t
    ON s.ou_id = t.ou_id
    AND s.adj_voucher_no = t.adj_voucher_no
    AND s.cr_doc_ou = t.cr_doc_ou
    AND s.cr_doc_no = t.cr_doc_no
    AND s.term_no = t.term_no
    AND s.cr_doc_type = t.cr_doc_type
    WHERE t.ou_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_sad_adjv_crdoc_dtl
    (
        ou_id, 					adj_voucher_no, 		cr_doc_ou, 			cr_doc_no, 			term_no, 
		cr_doc_type, 			tran_type, 				au_sale_ord_ref, 	cr_doc_adj_amt, 	discount, 
		proposed_discount, 		cost_center, 			analysis_code, 		subanalysis_code, 	au_pur_ord_ref, 
		au_cr_doc_unadj_amt, 	au_cr_doc_cur, 			au_crosscur_erate, 	au_discount_date, 	au_cr_doc_date, 
		au_fb_id, 				parent_key, 			current_key, 		au_disc_available, 	au_due_date, 
		au_billing_point, 		vat_amount, 			vat_rate, 			voucher_tran_type, 	batch_id, 
		au_base_exrate, 		au_par_base_exrate, 	project_ou, 		Project_code, 		afe_number, 
		job_number, 			tax_adj_jvno, 			prop_wht_amt, 		app_wht_amt, 		BillOfLadingNo, 
		BookingNo, 				MasterBillOfLadingNo, 	etlcreateddatetime
    )
    SELECT
        ou_id, 					adj_voucher_no, 		cr_doc_ou, 			cr_doc_no, 			term_no, 
		cr_doc_type, 			tran_type, 				au_sale_ord_ref, 	cr_doc_adj_amt, 	discount, 
		proposed_discount, 		cost_center, 			analysis_code, 		subanalysis_code, 	au_pur_ord_ref, 
		au_cr_doc_unadj_amt, 	au_cr_doc_cur, 			au_crosscur_erate, 	au_discount_date, 	au_cr_doc_date, 
		au_fb_id, 				parent_key, 			current_key, 		au_disc_available, 	au_due_date, 
		au_billing_point, 		vat_amount, 			vat_rate, 			voucher_tran_type, 	batch_id, 
		au_base_exrate, 		au_par_base_exrate, 	project_ou, 		Project_code, 		afe_number, 
		job_number, 			tax_adj_jvno, 			prop_wht_amt, 		app_wht_amt, 		BillOfLadingNo, 
		BookingNo, 				MasterBillOfLadingNo, 	etlcreateddatetime
    FROM stg.stg_sad_adjv_crdoc_dtl;
    
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