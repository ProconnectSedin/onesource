CREATE OR REPLACE PROCEDURE dwh.usp_f_sadadjvoucherhdr(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
    FROM stg.stg_sad_adjvoucher_hdr;

    UPDATE dwh.F_sadadjvoucherhdr t
    SET
        sadadjvoucherhdr_curr_key	= COALESCE(cu.curr_key,-1),
		sadadjvoucherhdr_vendor_key= COALESCE(v.vendor_key,-1),
        voucher_date              = s.voucher_date,
        fb_id                     = s.fb_id,
        voucher_amount            = s.voucher_amount,
        status                    = s.status,
        supp_code                 = s.supp_code,
        adjust_seq                = s.adjust_seq,
        currency_code             = s.currency_code,
        voucher_type              = s.voucher_type,
        rev_voucher_no            = s.rev_voucher_no,
        reversal_date             = s.reversal_date,
        notype_no                 = s.notype_no,
        currentkey                = s.currentkey,
        voucher_tran_type         = s.voucher_tran_type,
        batch_id                  = s.batch_id,
        createdby                 = s.createdby,
        createddate               = s.createddate,
        modifiedby                = s.modifiedby,
        modifieddate              = s.modifieddate,
        tcal_exclusive_amt        = s.tcal_exclusive_amt,
        tcal_status               = s.tcal_status,
        comments                  = s.comments,
        autogen_flag              = s.autogen_flag,
        voucher_remarks           = s.voucher_remarks,
        etlactiveind              = 1,
        etljobname                = p_etljobname,
        envsourcecd               = p_envsourcecd,
        datasourcecd              = p_datasourcecd,
        etlupdatedatetime         = NOW()
    FROM stg.stg_sad_adjvoucher_hdr s
	LEFT JOIN dwh.d_currency cu 
		ON  s.currency				= cu.iso_curr_code
	LEFT JOIN dwh.d_vendor v 		
		ON  s.supp_code 			= v.vendor_id
		AND s.ou_id					= v.vendor_ou
    WHERE 	t.ou_id 			= s.ou_id
    AND 	t.adj_voucher_no 	= s.adj_voucher_no
    AND 	t.stimestamp 		= s.stimestamp;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_sadadjvoucherhdr
    (
		sadadjvoucherhdr_curr_key,	sadadjvoucherhdr_vendor_key,
        ou_id, 				adj_voucher_no, 	stimestamp, 	voucher_date, 		fb_id, 
		voucher_amount, 	status, 			supp_code, 		adjust_seq, 		currency_code, 
		voucher_type, 		rev_voucher_no, 	reversal_date, 	notype_no, 			currentkey, 
		voucher_tran_type, 	batch_id, 			createdby, 		createddate, 		modifiedby, 
		modifieddate, 		tcal_exclusive_amt, tcal_status, 	comments, 			autogen_flag, 
		voucher_remarks, 	etlactiveind, 		etljobname, 	envsourcecd, 		datasourcecd, 
		etlcreatedatetime
    )

    SELECT
		COALESCE(cu.curr_key,-1),	 COALESCE(v.vendor_key,-1),
        s.ou_id, 				s.adj_voucher_no, 		s.stimestamp, 		s.voucher_date, 		s.fb_id, 
		s.voucher_amount, 		s.status, 				s.supp_code, 		s.adjust_seq, 			s.currency_code, 
		s.voucher_type, 		s.rev_voucher_no, 		s.reversal_date, 	s.notype_no, 			s.currentkey, 
		s.voucher_tran_type, 	s.batch_id, 			s.createdby, 		s.createddate, 			s.modifiedby, 
		s.modifieddate, 		s.tcal_exclusive_amt, 	s.tcal_status, 		s.comments, 			s.autogen_flag, 
		s.voucher_remarks, 		1, 						p_etljobname, 		p_envsourcecd, 			p_datasourcecd, 
		NOW()
    FROM stg.stg_sad_adjvoucher_hdr s
	LEFT JOIN dwh.d_currency cu 
		ON  s.currency				= cu.iso_curr_code
	LEFT JOIN dwh.d_vendor v 		
		ON  s.supp_code 			= v.vendor_id
		AND s.ou_id					= v.vendor_ou
    LEFT JOIN dwh.F_sadadjvoucherhdr t
    ON 		s.ou_id 			= t.ou_id
    AND 	s.adj_voucher_no 	= t.adj_voucher_no
    AND 	s.stimestamp 		= t.stimestamp
    WHERE t.ou_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_sad_adjvoucher_hdr
    (
        ou_id, 				adj_voucher_no, 	stimestamp, 		voucher_date, 		fb_id, 
		voucher_amount, 	status, 			supp_code, 			adjust_seq, 		currency_code, 
		voucher_type, 		rev_voucher_no, 	reversal_date, 		notype_no, 			reason_code, 
		remarks, 			currentkey, 		voucher_tran_type, 	batch_id, 			createdby, 
		createddate, 		modifiedby, 		modifieddate, 		doc_status, 		tcal_exclusive_amt, 
		total_tcal_amount, 	tcal_status, 		consistency_stamp, 	CrNoteNo, 			DrNoteNo, 
		CrNoteOU, 			DrNoteOU, 			CrNoteFB, 			DrNoteFB, 			CrVoucNo, 
		DrVoucNo, 			SrDocType, 			DestiBU, 			RevCrNoteNo, 		RevDrNoteNo, 
		RevCrVoucNo, 		RevDrVoucNo, 		workflow_status, 	comments, 			autogen_flag, 
		voucher_remarks, 	etlcreateddatetime
    )
    SELECT
        ou_id, 				adj_voucher_no, 	stimestamp, 		voucher_date, 		fb_id, 
		voucher_amount, 	status, 			supp_code, 			adjust_seq, 		currency_code, 
		voucher_type, 		rev_voucher_no, 	reversal_date, 		notype_no, 			reason_code, 
		remarks, 			currentkey, 		voucher_tran_type, 	batch_id, 			createdby, 
		createddate, 		modifiedby, 		modifieddate, 		doc_status, 		tcal_exclusive_amt, 
		total_tcal_amount, 	tcal_status, 		consistency_stamp, 	CrNoteNo, 			DrNoteNo, 
		CrNoteOU, 			DrNoteOU, 			CrNoteFB, 			DrNoteFB, 			CrVoucNo, 
		DrVoucNo, 			SrDocType, 			DestiBU, 			RevCrNoteNo, 		RevDrNoteNo, 
		RevCrVoucNo, 		RevDrVoucNo, 		workflow_status, 	comments, 			autogen_flag, 
		voucher_remarks, 	etlcreateddatetime
    FROM stg.stg_sad_adjvoucher_hdr;
    
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