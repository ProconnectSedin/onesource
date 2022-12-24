CREATE OR REPLACE PROCEDURE dwh.usp_f_ainqcwipaccountinginfo(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
    FROM stg.stg_ainq_cwip_accounting_info;

    UPDATE dwh.F_ainqcwipaccountinginfo t
    SET
        asset_class         = s.asset_class,
        fb_id               = s.fb_id,
        asset_number        = s.asset_number,
        tran_type           = s.tran_type,
        account_code        = s.account_code,
        account_type        = s.account_type,
        drcr_flag           = s.drcr_flag,
        currency            = s.currency,
        tran_amount         = s.tran_amount,
        tran_date           = s.tran_date,
        posting_date        = s.posting_date,
        depr_book           = s.depr_book,
        bc_erate            = s.bc_erate,
        base_amount         = s.base_amount,
        pbc_erate           = s.pbc_erate,
        pbase_amount        = s.pbase_amount,
        batch_id            = s.batch_id,
        createdby           = s.createdby,
        createddate         = s.createddate,
        rpt_flag            = s.rpt_flag,
        rpt_amount          = s.rpt_amount,
        etlactiveind        = 1,
        etljobname          = p_etljobname,
        envsourcecd         = p_envsourcecd,
        datasourcecd        = p_datasourcecd,
        etlupdatedatetime   = NOW()
    FROM stg.stg_ainq_cwip_accounting_info s 
	WHERE t.component_id = s.component_id
    AND t.company_code = s.company_code
    AND t.tran_number = s.tran_number
    AND t.proposal_no = s.proposal_no
    AND t.tran_ou = s.tran_ou;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_ainqcwipaccountinginfo
    (
        tran_ou		, component_id	, company_code	, asset_class	, fb_id, 
		tran_number	, asset_number	, tran_type		, proposal_no	, account_code, 
		account_type, drcr_flag		, currency		, tran_amount	, tran_date, 
		posting_date, depr_book		, bc_erate		, base_amount	, pbc_erate, 
		pbase_amount, batch_id		, createdby		, createddate	, rpt_flag, 
		rpt_amount	, 
		etlactiveind, etljobname	, envsourcecd	, datasourcecd	, etlcreatedatetime
    )

    SELECT
        s.tran_ou		, s.component_id, s.company_code, s.asset_class	, s.fb_id, 
		s.tran_number	, s.asset_number, s.tran_type	, s.proposal_no	, s.account_code, 
		s.account_type	, s.drcr_flag	, s.currency	, s.tran_amount	, s.tran_date, 
		s.posting_date	, s.depr_book	, s.bc_erate	, s.base_amount	, s.pbc_erate, 
		s.pbase_amount	, s.batch_id	, s.createdby	, s.createddate	, s.rpt_flag, 
		s.rpt_amount	, 
				1		, p_etljobname	, p_envsourcecd	, p_datasourcecd, NOW()
    FROM stg.stg_ainq_cwip_accounting_info s
    LEFT JOIN dwh.F_ainqcwipaccountinginfo t 
	ON t.component_id = s.component_id
    AND t.company_code = s.company_code
    AND t.tran_number = s.tran_number
    AND t.proposal_no = s.proposal_no
    AND t.tran_ou = s.tran_ou
    WHERE t.tran_ou IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_ainq_cwip_accounting_info
    (
        tran_ou, component_id, company_code, asset_class, fb_id, tran_number, asset_number, tran_type, proposal_no, account_code, account_type, drcr_flag, currency, tran_amount, tran_date, posting_date, depr_book, bc_erate, base_amount, pbc_erate, pbase_amount, batch_id, createdby, createddate, rpt_flag, rpt_amount, etlcreateddatetime
    )
    SELECT
        tran_ou, component_id, company_code, asset_class, fb_id, tran_number, asset_number, tran_type, proposal_no, account_code, account_type, drcr_flag, currency, tran_amount, tran_date, posting_date, depr_book, bc_erate, base_amount, pbc_erate, pbase_amount, batch_id, createdby, createddate, rpt_flag, rpt_amount, etlcreateddatetime
    FROM stg.stg_ainq_cwip_accounting_info;
    
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