-- PROCEDURE: dwh.usp_f_rptreceipthdr(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_rptreceipthdr(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_rptreceipthdr(
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
    FROM stg.stg_rpt_receipt_hdr;

    UPDATE dwh.F_rptreceipthdr t
    SET
        ou_id                     = s.ou_id,
        receipt_no                = s.receipt_no,
        timestamp                 = s.timestamp,
        receipt_date              = s.receipt_date,
        receipt_category          = s.receipt_category,
        receipt_status            = s.receipt_status,
        fb_id                     = s.fb_id,
        notype_no                 = s.notype_no,
        cust_area                 = s.cust_area,
        cust_code                 = s.cust_code,
        receipt_route             = s.receipt_route,
        receipt_mode              = s.receipt_mode,
        adjustment_type           = s.adjustment_type,
        currency                  = s.currency,
        exchange_rate             = s.exchange_rate,
        receipt_amount            = s.receipt_amount,
        bank_cash_code            = s.bank_cash_code,
        collector                 = s.collector,
        remitter                  = s.remitter,
        comments                  = s.comments,
        instr_no                  = s.instr_no,
        micr_no                   = s.micr_no,
        instr_amount              = s.instr_amount,
        instr_date                = s.instr_date,
        remitting_bank            = s.remitting_bank,
        charges                   = s.charges,
        cost_center               = s.cost_center,
        unapplied_amount          = s.unapplied_amount,
        reason_code               = s.reason_code,
        reversal_date             = s.reversal_date,
        remarks                   = s.remarks,
        createdby                 = s.createdby,
        createddate               = s.createddate,
        modifiedby                = s.modifiedby,
        modifieddate              = s.modifieddate,
        flag                      = s.flag,
        tran_type                 = s.tran_type,
        ref_doc_no                = s.ref_doc_no,
        batch_id                  = s.batch_id,
        tcal_status               = s.tcal_status,
        tcal_exclusive_amt        = s.tcal_exclusive_amt,
        insamt_btcal              = s.insamt_btcal,
        cust_account_code         = s.cust_account_code,
        ibe_flag                  = s.ibe_flag,
        LC_Number                 = s.LC_Number,
        chargesdeducted           = s.chargesdeducted,
        tdsamount                 = s.tdsamount,
        instr_type                = s.instr_type,
        stamp_duty                = s.stamp_duty,
        ict_flag                  = s.ict_flag,
        comp_reference            = s.comp_reference,
        creditcardchrgs           = s.creditcardchrgs,
        report_flag               = s.report_flag,
        Realization_Date          = s.Realization_Date,
        instr_status              = s.instr_status,
        lgt_invoice_flag          = s.lgt_invoice_flag,
        etlactiveind              = 1,
        etljobname                = p_etljobname,
        envsourcecd               = p_envsourcecd,
        datasourcecd              = p_datasourcecd,
        etlupdatedatetime         = NOW()
    FROM stg.stg_rpt_receipt_hdr s
    WHERE t.ou_id = s.ou_id
    AND t.receipt_no = s.receipt_no;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_rptreceipthdr
    (
        ou_id, receipt_no, timestamp, receipt_date, receipt_category, receipt_status, fb_id, notype_no, cust_area, cust_code, receipt_route, receipt_mode, adjustment_type, currency, exchange_rate, receipt_amount, bank_cash_code, collector, remitter, comments, instr_no, micr_no, instr_amount, instr_date, remitting_bank, charges, cost_center, unapplied_amount, reason_code, reversal_date, remarks, createdby, createddate, modifiedby, modifieddate, flag, tran_type, ref_doc_no, batch_id, tcal_status, tcal_exclusive_amt, insamt_btcal, cust_account_code, ibe_flag, LC_Number, chargesdeducted, tdsamount, instr_type, stamp_duty, ict_flag, comp_reference, creditcardchrgs, report_flag, Realization_Date, instr_status, lgt_invoice_flag, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        s.ou_id, s.receipt_no, s.timestamp, s.receipt_date, s.receipt_category, s.receipt_status, s.fb_id, s.notype_no, s.cust_area, s.cust_code, s.receipt_route, s.receipt_mode, s.adjustment_type, s.currency, s.exchange_rate, s.receipt_amount, s.bank_cash_code, s.collector, s.remitter, s.comments, s.instr_no, s.micr_no, s.instr_amount, s.instr_date, s.remitting_bank, s.charges, s.cost_center, s.unapplied_amount, s.reason_code, s.reversal_date, s.remarks, s.createdby, s.createddate, s.modifiedby, s.modifieddate, s.flag, s.tran_type, s.ref_doc_no, s.batch_id, s.tcal_status, s.tcal_exclusive_amt, s.insamt_btcal, s.cust_account_code, s.ibe_flag, s.LC_Number, s.chargesdeducted, s.tdsamount, s.instr_type, s.stamp_duty, s.ict_flag, s.comp_reference, s.creditcardchrgs, s.report_flag, s.Realization_Date, s.instr_status, s.lgt_invoice_flag, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_rpt_receipt_hdr s
    LEFT JOIN dwh.F_rptreceipthdr t
    ON s.ou_id = t.ou_id
    AND s.receipt_no = t.receipt_no
    WHERE t.ou_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_rpt_receipt_hdr
    (
        ou_id, receipt_no, timestamp, receipt_date, receipt_category, receipt_status, fb_id, notype_no, cust_area, cust_code, receipt_route, receipt_mode, adjustment_type, currency, exchange_rate, receipt_amount, bank_cash_code, collector, remitter, comments, instr_no, micr_no, instr_amount, instr_date, remitting_bank, charges, cost_center, analysis_code, subanalysis_code, card_no, card_auth_no, issuer, card_val_month, card_val_year, unapplied_amount, reason_code, reversal_date, remarks, doc_status, createdby, createddate, modifiedby, modifieddate, flag, par_base_amount, par_exchange_rate, tran_type, ref_doc_no, batch_id, tcal_status, total_tcal_status, tcal_exclusive_amt, total_tcal_amount, insamt_btcal, cust_account_code, ibe_flag, consistency_stamp, pdr_status, LC_Number, refid, chargesdeducted, tdsamount, pdr_rev_flag, instr_type, BookingNo, MasterBillOfLadingNo, BillOfLadingNo, workflow_status, bld_flag, ims_flag, scheme_code, clearing_type, stax_app_flag, sertax_amount, project_ou, Project_code, workflow_error, stamp_duty, ict_flag, mrpt_flag, comp_reference, tax_receipt_type, creditcardchrgs, report_flag, autogen_flag, Realization_Date, instr_status, Receipt_CusAddID, gen_from, undercoll_flag, trnsfr_inv_no, trnsfr_inv_date, trnsfr_inv_ou, lgt_invoice_flag, etlcreateddatetime
    )
    SELECT
        ou_id, receipt_no, timestamp, receipt_date, receipt_category, receipt_status, fb_id, notype_no, cust_area, cust_code, receipt_route, receipt_mode, adjustment_type, currency, exchange_rate, receipt_amount, bank_cash_code, collector, remitter, comments, instr_no, micr_no, instr_amount, instr_date, remitting_bank, charges, cost_center, analysis_code, subanalysis_code, card_no, card_auth_no, issuer, card_val_month, card_val_year, unapplied_amount, reason_code, reversal_date, remarks, doc_status, createdby, createddate, modifiedby, modifieddate, flag, par_base_amount, par_exchange_rate, tran_type, ref_doc_no, batch_id, tcal_status, total_tcal_status, tcal_exclusive_amt, total_tcal_amount, insamt_btcal, cust_account_code, ibe_flag, consistency_stamp, pdr_status, LC_Number, refid, chargesdeducted, tdsamount, pdr_rev_flag, instr_type, BookingNo, MasterBillOfLadingNo, BillOfLadingNo, workflow_status, bld_flag, ims_flag, scheme_code, clearing_type, stax_app_flag, sertax_amount, project_ou, Project_code, workflow_error, stamp_duty, ict_flag, mrpt_flag, comp_reference, tax_receipt_type, creditcardchrgs, report_flag, autogen_flag, Realization_Date, instr_status, Receipt_CusAddID, gen_from, undercoll_flag, trnsfr_inv_no, trnsfr_inv_date, trnsfr_inv_ou, lgt_invoice_flag, etlcreateddatetime
    FROM stg.stg_rpt_receipt_hdr;
    
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
ALTER PROCEDURE dwh.usp_f_rptreceipthdr(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
