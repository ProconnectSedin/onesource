CREATE PROCEDURE dwh.usp_f_silinedtl(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
	p_depsource VARCHAR(100);

BEGIN
    SELECT d.jobname, h.envsourcecode, h.datasourcecode, d.latestbatchid, d.targetprocedurename,h.rawstorageflag,h.depsource
    INTO p_etljobname, p_envsourcecd, p_datasourcecd, p_batchid, p_taskname, p_rawstorageflag,p_depsource
    FROM ods.controldetail d
    INNER JOIN ods.controlheader h
        ON d.sourceid = h.sourceid
    WHERE d.sourceid = p_sourceId
        AND d.dataflowflag = p_dataflowflag
        AND d.targetobject = p_targetobject;
	

    SELECT COUNT(1) INTO srccnt
    FROM stg.stg_si_line_dtl;

    UPDATE dwh.f_silinedtl t
    SET
        lo_id                     = s.lo_id,
        ref_doc_type              = s.ref_doc_type,
        ref_doc_ou                = s.ref_doc_ou,
        ref_doc_term_no           = s.ref_doc_term_no,
        item_tcd_code             = s.item_tcd_code,
        item_tcd_var              = s.item_tcd_var,
        uom                       = s.uom,
        item_qty                  = s.item_qty,
        unit_price                = s.unit_price,
        rate_per                  = s.rate_per,
        item_amount               = s.item_amount,
        tax_amount                = s.tax_amount,
        disc_amount               = s.disc_amount,
        line_amount               = s.line_amount,
        capitalized_amount        = s.capitalized_amount,
        proposal_no               = s.proposal_no,
        cap_doc_flag              = s.cap_doc_flag,
        batch_id                  = s.batch_id,
        usage_id                  = s.usage_id,
        pending_cap_amount        = s.pending_cap_amount,
        account_code              = s.account_code,
        milestone_code            = s.milestone_code,
        report_flag               = s.report_flag,
        etlactiveind              = 1,
        etljobname                = p_etljobname,
        envsourcecd               = p_envsourcecd,
        datasourcecd              = p_datasourcecd,
        etlupdatedatetime         = NOW()
    FROM stg.stg_si_line_dtl s
    WHERE t.tran_type =		s.tran_type
    AND t.tran_ou	  =		s.tran_ou
    AND t.tran_no	  =		s.tran_no
    AND t.line_no	  =		s.line_no
    AND t.row_type	  =		s.row_type;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.f_silinedtl
    (
       tran_type, tran_ou, tran_no, line_no, row_type, lo_id, ref_doc_type, ref_doc_ou, ref_doc_no, ref_doc_term_no, 
		item_tcd_code, item_tcd_var, uom, item_qty, unit_price, rate_per, item_amount, tax_amount, disc_amount, line_amount, 
		capitalized_amount, proposal_no, cap_doc_flag, batch_id, usage_id, pending_cap_amount, account_code, milestone_code, 
		report_flag, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
    s.tran_type, s.tran_ou, s.tran_no, s.line_no, s.row_type, s.lo_id, s.ref_doc_type, s.ref_doc_ou, s.ref_doc_no, s.ref_doc_term_no, 
		s.item_tcd_code, s.item_tcd_var, s.uom, s.item_qty, s.unit_price, s.rate_per, s.item_amount, s.tax_amount, s.disc_amount, s.line_amount, 
		s.capitalized_amount, s.proposal_no, s.cap_doc_flag, s.batch_id, s.usage_id, s.pending_cap_amount, s.account_code, s.milestone_code, 
		s.report_flag, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_si_line_dtl s
    LEFT JOIN dwh.f_silinedtl t
    ON s.tran_type	  =		t.tran_type
    AND s.tran_ou     =		t.tran_ou
    AND s.tran_no     =     t.tran_no
    AND s.line_no     =		t.line_no
    AND s.row_type	  =		t.row_type
	AND s.ref_doc_no =      t.ref_doc_no
    WHERE t.tran_type IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_si_line_dtl
    (
        tran_type, tran_ou, tran_no, line_no, row_type, lo_id, ref_doc_type, ref_doc_ou, ref_doc_no, ref_doc_term_no, item_tcd_code, item_tcd_var, uom, item_qty, unit_price, rate_per, item_amount, tax_amount, disc_amount, line_amount, capitalized_amount, proposal_no, cap_doc_flag, batch_id, usage_id, createdby, createddate, modifiedby, modifieddate, pending_cap_amount, account_code, milestone_code, report_flag, writeoff_amt, writeoff_remarks, writeoff_JVno, etlcreateddatetime
    )
    SELECT
        tran_type, tran_ou, tran_no, line_no, row_type, lo_id, ref_doc_type, ref_doc_ou, ref_doc_no, ref_doc_term_no, item_tcd_code, item_tcd_var, uom, item_qty, unit_price, rate_per, item_amount, tax_amount, disc_amount, line_amount, capitalized_amount, proposal_no, cap_doc_flag, batch_id, usage_id, createdby, createddate, modifiedby, modifieddate, pending_cap_amount, account_code, milestone_code, report_flag, writeoff_amt, writeoff_remarks, writeoff_JVno, etlcreateddatetime
    FROM stg.stg_si_line_dtl;
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