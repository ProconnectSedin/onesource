CREATE OR REPLACE PROCEDURE dwh.usp_f_surreceiptdtl(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
    FROM stg.stg_sur_receipt_dtl;

    UPDATE dwh.F_surreceiptdtl t
    SET
        surreceiptdtl_curr_key	= COALESCE(cu.curr_key,-1),
        surreceiptdtl_opcoa_key = COALESCE(o.opcoa_key,-1),
        usage                   = s.usage,
        account_code            = s.account_code,
        currency_code           = s.currency_code,
        account_amount          = s.account_amount,
        drcr_flag               = s.drcr_flag,
        base_amount             = s.base_amount,
        remarks                 = s.remarks,
        cost_center             = s.cost_center,
        analysis_code           = s.analysis_code,
        subanalysis_code        = s.subanalysis_code,
        batch_id                = s.batch_id,
        acct_type               = s.acct_type,
        createdby               = s.createdby,
        createddate             = s.createddate,
        modifiedby              = s.modifiedby,
        modifieddate            = s.modifieddate,
        item_desc               = s.item_desc,
        etlactiveind            = 1,
        etljobname              = p_etljobname,
        envsourcecd             = p_envsourcecd,
        datasourcecd            = p_datasourcecd,
        etlupdatedatetime       = NOW()
    FROM stg.stg_sur_receipt_dtl s
	LEFT JOIN dwh.d_currency cu 
		ON  s.currency_code				= cu.iso_curr_code
    LEFT JOIN dwh.d_operationalaccountdetail o 
		ON  s.account_code				= o.account_code
    WHERE 	t.ou_id 			= s.ou_id
    AND 	t.receipt_type 		= s.receipt_type
    AND 	t.receipt_no 		= s.receipt_no
    AND 	t.refdoc_lineno 	= s.refdoc_lineno
    AND 	t.tran_type 		= s.tran_type
    AND 	t.stimestamp 		= s.stimestamp;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_surreceiptdtl
    (
		surreceiptdtl_curr_key, surreceiptdtl_opcoa_key,
        ou_id, 				receipt_type, 		receipt_no, 		refdoc_lineno, 		tran_type, 
		stimestamp, 		usage, 				account_code, 		currency_code, 		account_amount, 
		drcr_flag, 			base_amount, 		remarks, 			cost_center, 		analysis_code, 
		subanalysis_code, 	batch_id, 			acct_type, 			createdby, 			createddate, 
		modifiedby, 		modifieddate, 		item_desc, 			etlactiveind, 		etljobname, 
		envsourcecd, 		datasourcecd, 		etlcreatedatetime
    )

    SELECT
		COALESCE(cu.curr_key,-1),   COALESCE(o.opcoa_key,-1),
        s.ou_id, 				s.receipt_type, 		s.receipt_no, 		s.refdoc_lineno, 		s.tran_type, 
		s.stimestamp, 			s.usage, 				s.account_code, 	s.currency_code, 		s.account_amount, 
		s.drcr_flag, 			s.base_amount, 			s.remarks, 			s.cost_center, 			s.analysis_code, 
		s.subanalysis_code, 	s.batch_id, 			s.acct_type, 		s.createdby, 			s.createddate, 
		s.modifiedby, 			s.modifieddate, 		s.item_desc, 		1,						p_etljobname, 
		p_envsourcecd, 			p_datasourcecd, 		NOW()
    FROM stg.stg_sur_receipt_dtl s
	LEFT JOIN dwh.d_currency cu 
		ON  s.currency_code				= cu.iso_curr_code
    LEFT JOIN dwh.d_operationalaccountdetail o 
		ON  s.account_code				= o.account_code
    LEFT JOIN dwh.F_surreceiptdtl t
    ON 			s.ou_id 			= t.ou_id
    AND 		s.receipt_type 		= t.receipt_type
    AND 		s.receipt_no 		= t.receipt_no
    AND 		s.refdoc_lineno 	= t.refdoc_lineno
    AND 		s.tran_type 		= t.tran_type
    AND 		s.stimestamp 		= t.stimestamp
    WHERE t.ou_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_sur_receipt_dtl
    (
        ou_id, 				receipt_type, 		receipt_no, 		refdoc_lineno, 		tran_type, 
		stimestamp, 		usage, 				account_code, 		currency_code, 		account_amount, 
		drcr_flag, 			base_amount, 		remarks, 			cost_center, 		analysis_code, 
		subanalysis_code, 	batch_id, 			acct_type, 			createdby, 			createddate, 
		modifiedby, 		modifieddate, 		item_code, 			item_desc, 			Dest_comp, 
		cfs_refdoc_ou, 		cfs_refdoc_no, 		cfs_refdoc_type, 	Desti_OU, 			Desti_SAC, 
		InterFBJVNO, 		Desti_AC, 			Desti_ACCCode, 		Desti_ACCDescrip, 	Desti_CC, 
		Desti_FB, 			account_code_int, 	ifb_recon_jvno, 	etlcreateddatetime
    )
    SELECT
        ou_id, 				receipt_type, 		receipt_no, 		refdoc_lineno, 		tran_type, 
		stimestamp, 		usage, 				account_code, 		currency_code, 		account_amount, 
		drcr_flag, 			base_amount, 		remarks, 			cost_center, 		analysis_code, 
		subanalysis_code, 	batch_id, 			acct_type, 			createdby, 			createddate, 
		modifiedby, 		modifieddate, 		item_code, 			item_desc, 			Dest_comp, 
		cfs_refdoc_ou, 		cfs_refdoc_no, 		cfs_refdoc_type, 	Desti_OU, 			Desti_SAC, 
		InterFBJVNO, 		Desti_AC, 			Desti_ACCCode, 		Desti_ACCDescrip, 	Desti_CC, 
		Desti_FB, 			account_code_int, 	ifb_recon_jvno, 	etlcreateddatetime
    FROM stg.stg_sur_receipt_dtl;
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