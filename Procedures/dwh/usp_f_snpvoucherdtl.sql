CREATE PROCEDURE dwh.usp_f_snpvoucherdtl(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
    SELECT d.jobname, h.envsourcecode, h.datasourcecode, d.latestbatchid, d.targetprocedurename, h.rawstorageflag, h.depsource
    INTO p_etljobname, p_envsourcecd, p_datasourcecd, p_batchid, p_taskname, p_rawstorageflag, p_depsource
    FROM ods.controldetail d
    INNER JOIN ods.controlheader h
        ON d.sourceid = h.sourceid
    WHERE d.sourceid = p_sourceId
        AND d.dataflowflag = p_dataflowflag
        AND d.targetobject = p_targetobject;
	

		SELECT COUNT(1) INTO srccnt
		FROM stg.stg_snp_voucher_dtl;

		UPDATE dwh.F_snpvoucherdtl t
		SET
			curr_key                    	= COALESCE(cr.curr_key,-1),
			usage_id                    	= s.usage_id,
			account_code                	= s.account_code,
			currency                    	= s.currency,
			amount                      	= s.amount,
			drcr_flag                   	= s.drcr_flag,
			base_amount                 	= s.base_amount,
			remarks                     	= s.remarks,
			cost_center                 	= s.cost_center,
			batch_id                    	= s.batch_id,
			createdby                   	= s.createdby,
			createddate                 	= s.createddate,
			receive_bank_cash_code      	= s.receive_bank_cash_code,
			sur_receipt_no              	= s.sur_receipt_no,
			Dest_comp                   	= s.Dest_comp,
			destination_accode          	= s.destination_accode,
			destination_ou              	= s.destination_ou,
			destination_fb              	= s.destination_fb,
			destination_costcenter      	= s.destination_costcenter,
			destination_interfbjvno     	= s.destination_interfbjvno,
			accountcode_interfb         	= s.accountcode_interfb,
			destaccount_currency        	= s.destaccount_currency,
			SUR_OU                      	= s.SUR_OU,
			etlactiveind                	= 1,
			etljobname                  	= p_etljobname,
			envsourcecd                 	= p_envsourcecd,
			datasourcecd                	= p_datasourcecd,
			etlupdatedatetime           	= NOW()
		FROM stg.stg_snp_voucher_dtl s
		LEFT JOIN dwh.d_currency cr
			ON  s.currency					= cr.iso_curr_code
		WHERE  t.ou_id 						= s.ou_id
			AND t.voucher_no 				= s.voucher_no
			AND t.voucher_type 				= s.voucher_type
			AND t.account_lineno 			= s.account_lineno
			AND t.tran_type 				= s.tran_type
			AND t.vtimestamp 				= s.vtimestamp;

		GET DIAGNOSTICS updcnt = ROW_COUNT;

		INSERT INTO dwh.F_snpvoucherdtl
		(
			curr_key,ou_id, voucher_no, voucher_type, account_lineno, tran_type, vtimestamp, usage_id, account_code, currency, amount, drcr_flag, base_amount, remarks, cost_center, batch_id, createdby, createddate, receive_bank_cash_code, sur_receipt_no, Dest_comp, destination_accode, destination_ou, destination_fb, destination_costcenter, destination_interfbjvno, accountcode_interfb, destaccount_currency, SUR_OU, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
		)

		SELECT
			COALESCE(cr.curr_key,-1),s.ou_id, s.voucher_no, s.voucher_type, s.account_lineno, s.tran_type, s.vtimestamp, s.usage_id, s.account_code, s.currency, s.amount, s.drcr_flag, s.base_amount, s.remarks, s.cost_center, s.batch_id, s.createdby, s.createddate, s.receive_bank_cash_code, s.sur_receipt_no, s.Dest_comp, s.destination_accode, s.destination_ou, s.destination_fb, s.destination_costcenter, s.destination_interfbjvno, s.accountcode_interfb, s.destaccount_currency, s.SUR_OU, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
		FROM stg.stg_snp_voucher_dtl s
		LEFT JOIN dwh.d_currency cr
			ON  s.currency					= cr.iso_curr_code	
		LEFT JOIN dwh.F_snpvoucherdtl t
		ON s.ou_id = t.ou_id
		AND s.voucher_no = t.voucher_no
		AND s.voucher_type = t.voucher_type
		AND s.account_lineno = t.account_lineno
		AND s.tran_type = t.tran_type
		AND s.vtimestamp = t.vtimestamp
		WHERE t.ou_id IS NULL;

		GET DIAGNOSTICS inscnt = ROW_COUNT;

		IF p_rawstorageflag = 1
		THEN

			INSERT INTO raw.raw_snp_voucher_dtl
			(
				ou_id, voucher_no, voucher_type, account_lineno, tran_type, vtimestamp, usage_id, account_code, currency, amount, drcr_flag, base_amount, proposal_no, remarks, cost_center, analysis_code, subanalysis_code, batch_id, acct_type, createdby, createddate, modifiedby, modifieddate, receive_bank_cash_code, sur_receipt_no, Dest_comp, cfs_refdoc_ou, cfs_refdoc_no, cfs_refdoc_type, destination_accode, destination_ou, destination_fb, destination_costcenter, destination_analysiscode, destination_subanalysiscode, destination_interfbjvno, accountcode_interfb, costcenter_interfb, analysis_code_interfb, sub_analysis_code_interfb, destaccount_currency, Reciving_Comp, SUR_OU, ifb_recon_jvno, own_tax_region, party_tax_region, decl_tax_region, etlcreateddatetime
			)
			SELECT
				ou_id, voucher_no, voucher_type, account_lineno, tran_type, vtimestamp, usage_id, account_code, currency, amount, drcr_flag, base_amount, proposal_no, remarks, cost_center, analysis_code, subanalysis_code, batch_id, acct_type, createdby, createddate, modifiedby, modifieddate, receive_bank_cash_code, sur_receipt_no, Dest_comp, cfs_refdoc_ou, cfs_refdoc_no, cfs_refdoc_type, destination_accode, destination_ou, destination_fb, destination_costcenter, destination_analysiscode, destination_subanalysiscode, destination_interfbjvno, accountcode_interfb, costcenter_interfb, analysis_code_interfb, sub_analysis_code_interfb, destaccount_currency, Reciving_Comp, SUR_OU, ifb_recon_jvno, own_tax_region, party_tax_region, decl_tax_region, etlcreateddatetime
			FROM stg.stg_snp_voucher_dtl;
		
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