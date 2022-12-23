CREATE PROCEDURE dwh.usp_f_cdcnaccdtl(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
        FROM stg.stg_cdcn_acc_dtl;

        UPDATE dwh.F_cdcnaccdtl t
        SET
        timestamp               = s.ctimestamp,
        account_code            = s.account_code,
        drcr_id                 = s.drcr_id,
        ref_doc_type            = s.ref_doc_type,
        ref_doc_no              = s.ref_doc_no,
        ref_doc_date            = s.ref_doc_date,
        ref_doc_amount          = s.ref_doc_amount,
        ordering_ou             = s.ordering_ou,
        tran_amount             = s.tran_amount,
        remarks                 = s.remarks,
        cost_center             = s.cost_center,
        base_amount             = s.base_amount,
        par_base_amount         = s.par_base_amount,
        createddate             = s.createddate,
        modifieddate            = s.modifieddate,
        usageid                 = s.usageid,
        MAIL_SENT               = s.MAIL_SENT,
        Desti_ACCDescrip        = s.Desti_ACCDescrip,
        own_tax_region          = s.own_tax_region,
        decl_tax_region         = s.decl_tax_region,
        party_tax_region        = s.party_tax_region,
        etlactiveind            = 1,
        etljobname              = p_etljobname,
        envsourcecd             = p_envsourcecd,
        datasourcecd            = p_datasourcecd,
        etlupdatedatetime       = NOW()
        FROM stg.stg_cdcn_acc_dtl s
        WHERE t.tran_type = s.tran_type
    AND t.tran_ou = s.tran_ou
    AND t.tran_no = s.tran_no
    AND t.line_no = s.line_no;

        GET DIAGNOSTICS updcnt = ROW_COUNT;

        INSERT INTO dwh.F_cdcnaccdtl
        (
            tran_type, tran_ou, tran_no, line_no, timestamp, account_code, drcr_id, ref_doc_type, ref_doc_no, ref_doc_date, ref_doc_amount, ordering_ou, tran_amount, remarks, cost_center, base_amount, par_base_amount, createddate, modifieddate ,usageid, MAIL_SENT, Desti_ACCDescrip, own_tax_region, decl_tax_region, party_tax_region, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
        )

        SELECT
            s.tran_type, s.tran_ou, s.tran_no, s.line_no, s.ctimestamp, s.account_code, s.drcr_id, s.ref_doc_type, s.ref_doc_no, s.ref_doc_date, s.ref_doc_amount, s.ordering_ou, s.tran_amount, s.remarks, s.cost_center, s.base_amount, s.par_base_amount, s.createddate,s.modifieddate, s.usageid, s.MAIL_SENT, s.Desti_ACCDescrip, s.own_tax_region, s.decl_tax_region, s.party_tax_region, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
        FROM stg.stg_cdcn_acc_dtl s
        LEFT JOIN dwh.F_cdcnaccdtl t
        ON s.tran_type = t.tran_type
    AND s.tran_ou = t.tran_ou
    AND s.tran_no = t.tran_no
    AND s.line_no = t.line_no
        WHERE t.tran_type IS NULL;

        GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

        INSERT INTO raw.raw_cdcn_acc_dtl
        (
            tran_type, tran_ou, tran_no, line_no, account_code, drcr_id, ref_doc_type, ref_doc_no, ref_doc_date, ref_doc_amount, ordering_ou, tran_amount, remarks, cost_center, analysis_code, subanalysis_code, base_amount, par_base_amount, createdby, createddate, modifiedby, modifieddate, BookingNo, BillOfLadingNo, MasterBillOfLadingNo, cfs_refdoc_ou, cfs_refdoc_no, cfs_refdoc_type, dest_usageid, incomeexpense, dest_subanalysis_code, dest_analysis_code, dest_cost_center, dest_remarks, dest_tran_amount, dest_drcr_id, dest_account_code, usageid, ccdesc, MAIL_SENT, draf_bill_no, draf_bill_line_no, Desti_OU, Desti_SAC, InterFBJVNO, Desti_AC, Desti_ACCCode, Desti_ACCDescrip, Desti_CC, Desti_Comp, Desti_FB, account_code_int, ifb_recon_jvno, own_tax_region, decl_tax_region, party_tax_region, etlcreateddatetime
        )
        SELECT
            tran_type, tran_ou, tran_no, line_no, account_code, drcr_id, ref_doc_type, ref_doc_no, ref_doc_date, ref_doc_amount, ordering_ou, tran_amount, remarks, cost_center, analysis_code, subanalysis_code, base_amount, par_base_amount, createdby, createddate, modifiedby, modifieddate, BookingNo, BillOfLadingNo, MasterBillOfLadingNo, cfs_refdoc_ou, cfs_refdoc_no, cfs_refdoc_type, dest_usageid, incomeexpense, dest_subanalysis_code, dest_analysis_code, dest_cost_center, dest_remarks, dest_tran_amount, dest_drcr_id, dest_account_code, usageid, ccdesc, MAIL_SENT, draf_bill_no, draf_bill_line_no, Desti_OU, Desti_SAC, InterFBJVNO, Desti_AC, Desti_ACCCode, Desti_ACCDescrip, Desti_CC, Desti_Comp, Desti_FB, account_code_int, ifb_recon_jvno, own_tax_region, decl_tax_region, party_tax_region, etlcreateddatetime
        FROM stg.stg_cdcn_acc_dtl;
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