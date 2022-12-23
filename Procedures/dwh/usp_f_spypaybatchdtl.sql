CREATE PROCEDURE dwh.usp_f_spypaybatchdtl(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
	p_depsource VARCHAR(100);
    p_rawstorageflag integer;

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
		FROM stg.stg_spy_paybatch_dtl;

		UPDATE dwh.F_spypaybatchdtl t
		SET
			curr_key                 = COALESCE(cr.curr_key,-1),
			vendor_key               = COALESCE(v.vendor_key,-1),
			cr_doc_type              = s.cr_doc_type,
			pay_currency             = s.pay_currency,
			parbasecur_erate         = s.parbasecur_erate,
			tran_amount              = s.tran_amount,
			discount                 = s.discount,
			penalty                  = s.penalty,
			pay_mode                 = s.pay_mode,
			proposed_penalty         = s.proposed_penalty,
			proposed_discount        = s.proposed_discount,
			basecur_erate            = s.basecur_erate,
			crosscur_erate           = s.crosscur_erate,
			supp_ctrl_acct           = s.supp_ctrl_acct,
			batch_id                 = s.batch_id,
			supplier_code            = s.supplier_code,
			cr_doc_cur               = s.cr_doc_cur,
			cr_doc_amount            = s.cr_doc_amount,
			cr_doc_fb_id             = s.cr_doc_fb_id,
			tran_net_amount          = s.tran_net_amount,
			pay_amount               = s.pay_amount,
			pay_to_supp              = s.pay_to_supp,
			pay_cur_erate            = s.pay_cur_erate,
			ctrl_acct_type           = s.ctrl_acct_type,
			etlactiveind             = 1,
			etljobname               = p_etljobname,
			envsourcecd              = p_envsourcecd,
			datasourcecd             = p_datasourcecd,
			etlupdatedatetime        = NOW()
		FROM stg.stg_spy_paybatch_dtl s
		LEFT JOIN dwh.d_currency cr
			ON  s.pay_currency		 = cr.iso_curr_code
		LEFT JOIN dwh.d_vendor v
			ON  s.supplier_code		 = v.vendor_id
			AND s.ou_id				 = v.vendor_ou		
		WHERE t.ou_id 				 = s.ou_id
		AND t.paybatch_no 			 = s.paybatch_no
		AND t.cr_doc_ou 			 = s.cr_doc_ou
		AND t.cr_doc_no 			 = s.cr_doc_no
		AND t.term_no 				 = s.term_no
		AND t.tran_type 			 = s.tran_type
		AND t.ptimestamp 			 = s.ptimestamp;

		GET DIAGNOSTICS updcnt = ROW_COUNT;

		INSERT INTO dwh.F_spypaybatchdtl
		(
			 curr_key, vendor_key, ou_id, paybatch_no, cr_doc_ou, cr_doc_no, term_no, tran_type, ptimestamp, cr_doc_type, pay_currency, parbasecur_erate, tran_amount, discount, penalty, pay_mode, proposed_penalty, proposed_discount, basecur_erate, crosscur_erate, supp_ctrl_acct, batch_id, supplier_code, cr_doc_cur, cr_doc_amount, cr_doc_fb_id, tran_net_amount, pay_amount, pay_to_supp, pay_cur_erate, ctrl_acct_type, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
		)

		SELECT
		COALESCE(cr.curr_key,-1), COALESCE(v.vendor_key,-1), s.ou_id, s.paybatch_no, s.cr_doc_ou, s.cr_doc_no, s.term_no, s.tran_type, s.ptimestamp, s.cr_doc_type, s.pay_currency, s.parbasecur_erate, s.tran_amount, s.discount, s.penalty, s.pay_mode, s.proposed_penalty, s.proposed_discount, s.basecur_erate, s.crosscur_erate, s.supp_ctrl_acct, s.batch_id, s.supplier_code, s.cr_doc_cur, s.cr_doc_amount, s.cr_doc_fb_id, s.tran_net_amount, s.pay_amount, s.pay_to_supp, s.pay_cur_erate, s.ctrl_acct_type, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
		FROM stg.stg_spy_paybatch_dtl s
		LEFT JOIN dwh.d_currency cr
			ON  s.pay_currency		= cr.iso_curr_code
		LEFT JOIN dwh.d_vendor v
			ON  s.supplier_code		= v.vendor_id
			AND s.ou_id				= v.vendor_ou	
		LEFT JOIN dwh.F_spypaybatchdtl t
		ON s.ou_id 					= t.ou_id
		AND s.paybatch_no 			= t.paybatch_no
		AND s.cr_doc_ou 			= t.cr_doc_ou
		AND s.cr_doc_no 			= t.cr_doc_no
		AND s.term_no 				= t.term_no
		AND s.tran_type 			= t.tran_type
		AND s.ptimestamp 			= t.ptimestamp
		WHERE t.ou_id IS NULL;

		GET DIAGNOSTICS inscnt = ROW_COUNT;

		IF p_rawstorageflag = 1
		THEN

			INSERT INTO raw.raw_spy_paybatch_dtl
			(
				ou_id, paybatch_no, cr_doc_ou, cr_doc_no, term_no, tran_type, ptimestamp, cr_doc_type, pay_currency, parbasecur_erate, tran_amount, discount, penalty, pay_mode, proposed_penalty, proposed_discount, basecur_erate, crosscur_erate, supp_ctrl_acct, batch_id, lsv_id, esr_line, createdby, createddate, modifiedby, modifieddate, supplier_code, cr_doc_cur, cr_doc_amount, cr_doc_fb_id, tran_net_amount, pay_amount, pay_to_supp, pay_cur_erate, ctrl_acct_type, BankCurrency, project_ou, Project_code, prop_wht_amt, app_wht_amt, etlcreateddatetime
			)
			SELECT
				ou_id, paybatch_no, cr_doc_ou, cr_doc_no, term_no, tran_type, ptimestamp, cr_doc_type, pay_currency, parbasecur_erate, tran_amount, discount, penalty, pay_mode, proposed_penalty, proposed_discount, basecur_erate, crosscur_erate, supp_ctrl_acct, batch_id, lsv_id, esr_line, createdby, createddate, modifiedby, modifieddate, supplier_code, cr_doc_cur, cr_doc_amount, cr_doc_fb_id, tran_net_amount, pay_amount, pay_to_supp, pay_cur_erate, ctrl_acct_type, BankCurrency, project_ou, Project_code, prop_wht_amt, app_wht_amt, etlcreateddatetime
			FROM stg.stg_spy_paybatch_dtl;
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