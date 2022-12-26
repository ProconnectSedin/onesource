CREATE OR REPLACE PROCEDURE dwh.usp_f_spypaybatchhdr(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
    FROM stg.stg_spy_paybatch_hdr;

    UPDATE dwh.F_spypaybatchhdr t
    SET
        curr_key                  = COALESCE(cr.curr_key,-1),
        paybatch_notype           = s.paybatch_notype,
        voucher_notype            = s.voucher_notype,
        request_date              = s.request_date,
        pay_date                  = s.pay_date,
        payment_route             = s.payment_route,
        elect_payment             = s.elect_payment,
        pay_mode                  = s.pay_mode,
        relpay_ou                 = s.relpay_ou,
        pay_chargeby              = s.pay_chargeby,
        priority                  = s.priority,
        fb_id                     = s.fb_id,
        status                    = s.status,
        pay_currency              = s.pay_currency,
        basecur_erate             = s.basecur_erate,
        tran_type                 = s.tran_type,
        remarks                   = s.remarks,
        batch_id                  = s.batch_id,
        createdby                 = s.createdby,
        createddate               = s.createddate,
        modifiedby                = s.modifiedby,
        modifieddate              = s.modifieddate,
        unadjppchk_flag           = s.unadjppchk_flag,
        crosscur_erate            = s.crosscur_erate,
        unadjdebitchk_flag        = s.unadjdebitchk_flag,
        etlactiveind              = 1,
        etljobname                = p_etljobname,
        envsourcecd               = p_envsourcecd,
        datasourcecd              = p_datasourcecd,
        etlupdatedatetime         = NOW()
    FROM stg.stg_spy_paybatch_hdr s
	LEFT JOIN dwh.d_currency cr
		ON  s.pay_currency		= cr.iso_curr_code	
    WHERE t.ou_id = s.ou_id
    AND t.paybatch_no = s.paybatch_no
    AND t.ptimestamp = s.ptimestamp
    AND t.ict_flag = s.ict_flag;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_spypaybatchhdr
    (
        curr_key, ou_id, paybatch_no, ptimestamp, paybatch_notype, voucher_notype, request_date, pay_date, payment_route, elect_payment, pay_mode, relpay_ou, pay_chargeby, priority, fb_id, status, pay_currency, basecur_erate, tran_type, remarks, batch_id, createdby, createddate, modifiedby, modifieddate, unadjppchk_flag, crosscur_erate, unadjdebitchk_flag, ict_flag, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        COALESCE(cr.curr_key,-1), s.ou_id, s.paybatch_no, s.ptimestamp, s.paybatch_notype, s.voucher_notype, s.request_date, s.pay_date, s.payment_route, s.elect_payment, s.pay_mode, s.relpay_ou, s.pay_chargeby, s.priority, s.fb_id, s.status, s.pay_currency, s.basecur_erate, s.tran_type, s.remarks, s.batch_id, s.createdby, s.createddate, s.modifiedby, s.modifieddate, s.unadjppchk_flag, s.crosscur_erate, s.unadjdebitchk_flag, s.ict_flag, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_spy_paybatch_hdr s
	LEFT JOIN dwh.d_currency cr
		ON  s.pay_currency		= cr.iso_curr_code	
    LEFT JOIN dwh.F_spypaybatchhdr t
    ON s.ou_id = t.ou_id
    AND s.paybatch_no = t.paybatch_no
    AND s.ptimestamp = t.ptimestamp
    AND s.ict_flag = t.ict_flag
    WHERE t.ou_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

		INSERT INTO raw.raw_spy_paybatch_hdr
		(
			ou_id, paybatch_no, ptimestamp, paybatch_notype, voucher_notype, request_date, pay_date, payment_route, elect_payment, pay_mode, paygroup_no, relpay_ou, pay_chargeby, priority, fb_id, status, pay_currency, basecur_erate, tran_type, remarks, batch_id, doc_status, createdby, createddate, modifiedby, modifieddate, unadjppchk_flag, consistency_stamp, workflow_status, BankCurrency, crosscur_erate, bank_amount, bank_base_amount, unadjdebitchk_flag, ict_flag, supplier_group, etlcreateddatetime
		)
		SELECT
			ou_id, paybatch_no, ptimestamp, paybatch_notype, voucher_notype, request_date, pay_date, payment_route, elect_payment, pay_mode, paygroup_no, relpay_ou, pay_chargeby, priority, fb_id, status, pay_currency, basecur_erate, tran_type, remarks, batch_id, doc_status, createdby, createddate, modifiedby, modifieddate, unadjppchk_flag, consistency_stamp, workflow_status, BankCurrency, crosscur_erate, bank_amount, bank_base_amount, unadjdebitchk_flag, ict_flag, supplier_group, etlcreateddatetime
		FROM stg.stg_spy_paybatch_hdr;
    
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