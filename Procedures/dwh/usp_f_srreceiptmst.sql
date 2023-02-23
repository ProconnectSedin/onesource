-- PROCEDURE: dwh.usp_f_srreceiptmst(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_srreceiptmst(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_srreceiptmst(
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
    FROM stg.stg_sr_receipt_mst;

    UPDATE dwh.F_srreceiptmst t
    SET
		srreceiptmst_datekey		   = coalesce(d.datekey,-1),
		srreceiptmst_bankkey		   = coalesce(bc.d_bank_mst_key,-1),	
		srrreceiptmst_suppkey		   = coalesce(v.vendor_key,-1),
		srrreceiptmst_currkey		   = coalesce(c.curr_key,-1),
		srrreceiptmst_acckey		   = COALESCE(oc.opcoa_key,-1),
        ou_id                          = s.ou_id,
        receipt_no                     = s.receipt_no,
        receipt_type                   = s.receipt_type,
        tran_type                      = s.tran_type,
        timestamp                      = s.timestamp,
        batch_id                       = s.batch_id,
        origin_no                      = s.origin_no,
        receipt_date                   = s.receipt_date,
        fb_id                          = s.fb_id,
        notype_no                      = s.notype_no,
        receipt_status                 = s.receipt_status,
        supplier_code                  = s.supplier_code,
        receipt_route                  = s.receipt_route,
        receipt_method                 = s.receipt_method,
        receipt_mode                   = s.receipt_mode,
        bank_cash_code                 = s.bank_cash_code,
        currency_code                  = s.currency_code,
        exchange_rate                  = s.exchange_rate,
        receipt_amount_bef_roff        = s.receipt_amount_bef_roff,
        receipt_amount                 = s.receipt_amount,
        apply                          = s.apply,
        remarks                        = s.remarks,
        instr_no                       = s.instr_no,
        micr_no                        = s.micr_no,
        instr_amount                   = s.instr_amount,
        instr_date                     = s.instr_date,
        instr_status                   = s.instr_status,
        bank_code                      = s.bank_code,
        charges                        = s.charges,
        ref_no                         = s.ref_no,
        cost_center                    = s.cost_center,
        analysis_code                  = s.analysis_code,
        sub_analysis_code              = s.sub_analysis_code,
        reason_code                    = s.reason_code,
        rr_flag                        = s.rr_flag,
        pbcexchrate                    = s.pbcexchrate,
        createdby                      = s.createdby,
        createddate                    = s.createddate,
        modifiedby                     = s.modifiedby,
        modifieddate                   = s.modifieddate,
        doc_status                     = s.doc_status,
        account_code                   = s.account_code,
        ibe_flag                       = s.ibe_flag,
        consistency_stamp              = s.consistency_stamp,
        instr_type                     = s.instr_type,
        pdr_status                     = s.pdr_status,
        pdr_rev_flag                   = s.pdr_rev_flag,
        bld_flag                       = s.bld_flag,
        project_ou                     = s.project_ou,
        Project_code                   = s.Project_code,
        exratebanktoreceive            = s.exratebanktoreceive,
        bankamount                     = s.bankamount,
        bankamountbase                 = s.bankamountbase,
        workflow_status                = s.workflow_status,
        ict_flag                       = s.ict_flag,
        report_flag                    = s.report_flag,
        autogen_flag                   = s.autogen_flag,
        Realization_Date               = s.Realization_Date,
        gen_from                       = s.gen_from,
        auto_adjust                    = s.auto_adjust,
        etlactiveind                   = 1,
        etljobname                     = p_etljobname,
        envsourcecd                    = p_envsourcecd,
        datasourcecd                   = p_datasourcecd,
        etlupdatedatetime              = NOW()
    FROM stg.stg_sr_receipt_mst s
	left join dwh.d_date d
	ON d.dateactual=s.receipt_date::date
	left join dwh.d_bankcashaccountmaster bc
	ON bc.bank_ptt_code=s.bank_code
	left join dwh.d_vendor v
	on v.vendor_id=s.supplier_code
	and v.vendor_ou=s.ou_id
	left join dwh.d_currency c
	ON c.iso_curr_code= s.currency_code
	left join dwh.d_operationalaccountdetail oc
	on oc.account_code= s.account_code
    WHERE t.ou_id = s.ou_id
    AND t.receipt_no = s.receipt_no
    AND t.receipt_type = s.receipt_type
    AND t.tran_type = s.tran_type;
    GET DIAGNOSTICS updcnt = ROW_COUNT;
	
    INSERT INTO dwh.F_srreceiptmst
    (
     srreceiptmst_datekey, srreceiptmst_bankkey, srrreceiptmst_suppkey, srrreceiptmst_currkey, srrreceiptmst_acckey, ou_id, receipt_no, receipt_type, tran_type, timestamp, batch_id, origin_no, receipt_date, fb_id, notype_no, receipt_status, supplier_code, receipt_route, receipt_method, receipt_mode, bank_cash_code, currency_code, exchange_rate, receipt_amount_bef_roff, receipt_amount, apply, remarks, instr_no, micr_no, instr_amount, instr_date, instr_status, bank_code, charges, ref_no, cost_center, analysis_code, sub_analysis_code, reason_code, rr_flag, pbcexchrate, createdby, createddate, modifiedby, modifieddate, doc_status, account_code, ibe_flag, consistency_stamp, instr_type, pdr_status, pdr_rev_flag, bld_flag, project_ou, Project_code, exratebanktoreceive, bankamount, bankamountbase, workflow_status, ict_flag, report_flag, autogen_flag, Realization_Date, gen_from, auto_adjust, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
     coalesce(d.datekey,-1), coalesce(bc.d_bank_mst_key,-1), coalesce(v.vendor_key,-1), coalesce(c.curr_key,-1), COALESCE(oc.opcoa_key,-1),s.ou_id, s.receipt_no, s.receipt_type, s.tran_type, s.timestamp, s.batch_id, s.origin_no, s.receipt_date, s.fb_id, s.notype_no, s.receipt_status, s.supplier_code, s.receipt_route, s.receipt_method, s.receipt_mode, s.bank_cash_code, s.currency_code, s.exchange_rate, s.receipt_amount_bef_roff, s.receipt_amount, s.apply, s.remarks, s.instr_no, s.micr_no, s.instr_amount, s.instr_date, s.instr_status, s.bank_code, s.charges, s.ref_no, s.cost_center, s.analysis_code, s.sub_analysis_code, s.reason_code, s.rr_flag, s.pbcexchrate, s.createdby, s.createddate, s.modifiedby, s.modifieddate, s.doc_status, s.account_code, s.ibe_flag, s.consistency_stamp, s.instr_type, s.pdr_status, s.pdr_rev_flag, s.bld_flag, s.project_ou, s.Project_code, s.exratebanktoreceive, s.bankamount, s.bankamountbase, s.workflow_status, s.ict_flag, s.report_flag, s.autogen_flag, s.Realization_Date, s.gen_from, s.auto_adjust, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
     FROM stg.stg_sr_receipt_mst s
	left join dwh.d_date d
	ON d.dateactual=s.receipt_date::date
	left join dwh.d_bankcashaccountmaster bc
	ON bc.bank_ptt_code=s.bank_code
	left join dwh.d_vendor v
	on v.vendor_id=s.supplier_code
	and v.vendor_ou=s.ou_id
	left join dwh.d_currency c
	ON c.iso_curr_code= s.currency_code
	left join dwh.d_operationalaccountdetail oc
	on oc.account_code= s.account_code	
    LEFT JOIN dwh.F_srreceiptmst t
    ON s.ou_id = t.ou_id
    AND s.receipt_no = t.receipt_no
    AND s.receipt_type = t.receipt_type
    AND s.tran_type = t.tran_type
    WHERE t.ou_id IS NULL;
	

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_sr_receipt_mst
    (
        ou_id, receipt_no, receipt_type, tran_type, timestamp, batch_id, origin_no, receipt_date, fb_id, notype_no, receipt_status, supplier_code, receipt_route, receipt_method, receipt_mode, bank_cash_code, currency_code, exchange_rate, receipt_amount_bef_roff, receipt_amount, apply, remarks, instr_no, micr_no, instr_amount, instr_date, instr_status, bank_code, charges, ref_no, cost_center, analysis_code, sub_analysis_code, reason_code, rr_flag, pbcexchrate, createdby, createddate, modifiedby, modifieddate, doc_status, account_code, ibe_flag, consistency_stamp, instr_type, pdr_status, pdr_rev_flag, bld_flag, project_ou, Project_code, exratebanktoreceive, bankamount, bankamountbase, workflow_status, ict_flag, report_flag, autogen_flag, Realization_Date, gen_from, auto_adjust, etlcreateddatetime
    )
    SELECT
        ou_id, receipt_no, receipt_type, tran_type, timestamp, batch_id, origin_no, receipt_date, fb_id, notype_no, receipt_status, supplier_code, receipt_route, receipt_method, receipt_mode, bank_cash_code, currency_code, exchange_rate, receipt_amount_bef_roff, receipt_amount, apply, remarks, instr_no, micr_no, instr_amount, instr_date, instr_status, bank_code, charges, ref_no, cost_center, analysis_code, sub_analysis_code, reason_code, rr_flag, pbcexchrate, createdby, createddate, modifiedby, modifieddate, doc_status, account_code, ibe_flag, consistency_stamp, instr_type, pdr_status, pdr_rev_flag, bld_flag, project_ou, Project_code, exratebanktoreceive, bankamount, bankamountbase, workflow_status, ict_flag, report_flag, autogen_flag, Realization_Date, gen_from, auto_adjust, etlcreateddatetime
    FROM stg.stg_sr_receipt_mst;
    
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
ALTER PROCEDURE dwh.usp_f_srreceiptmst(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
