CREATE PROCEDURE dwh.usp_f_cbadjadjvoucherhdr(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
        FROM stg.stg_cbadj_adjvoucher_hdr;

        UPDATE dwh.F_cbadjadjvoucherhdr t
        SET
            ou_id                     = s.ou_id,
        adj_voucher_no            = s.adj_voucher_no,
        voucher_tran_type         = s.voucher_tran_type,
        timestamp                 = s.timestamp,
        voucher_date              = s.voucher_date,
        fb_id                     = s.fb_id,
        voucher_amount            = s.voucher_amount,
        status                    = s.status,
        cust_code                 = s.cust_code,
        cust_hierarchy            = s.cust_hierarchy,
        adjust_seq                = s.adjust_seq,
        currency_code             = s.currency_code,
        voucher_type              = s.voucher_type,
        rev_voucher_no            = s.rev_voucher_no,
        reversal_date             = s.reversal_date,
        notype_no                 = s.notype_no,
        currentkey                = s.currentkey,
        batch_id                  = s.batch_id,
        createdby                 = s.createdby,
        createddate               = s.createddate,
        modifiedby                = s.modifiedby,
        modifieddate              = s.modifieddate,
        tcal_status               = s.tcal_status,
        tcal_exclusive_amt        = s.tcal_exclusive_amt,
            etlactiveind              = 1,
        etljobname                = p_etljobname,
        envsourcecd               = p_envsourcecd,
        datasourcecd              = p_datasourcecd,
        etlupdatedatetime         = NOW()
        FROM stg.stg_cbadj_adjvoucher_hdr s
        WHERE t.ou_id = s.ou_id
    AND t.adj_voucher_no = s.adj_voucher_no
    AND t.voucher_tran_type = s.voucher_tran_type;

        GET DIAGNOSTICS updcnt = ROW_COUNT;

        INSERT INTO dwh.F_cbadjadjvoucherhdr
        (
            ou_id, adj_voucher_no, voucher_tran_type, timestamp, voucher_date, fb_id, voucher_amount, status, cust_code, cust_hierarchy, adjust_seq, currency_code, voucher_type, rev_voucher_no, reversal_date, notype_no, currentkey, batch_id, createdby, createddate, modifiedby, modifieddate, tcal_status, tcal_exclusive_amt, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
        )

        SELECT
            s.ou_id, s.adj_voucher_no, s.voucher_tran_type, s.timestamp, s.voucher_date, s.fb_id, s.voucher_amount, s.status, s.cust_code, s.cust_hierarchy, s.adjust_seq, s.currency_code, s.voucher_type, s.rev_voucher_no, s.reversal_date, s.notype_no, s.currentkey, s.batch_id, s.createdby, s.createddate, s.modifiedby, s.modifieddate, s.tcal_status, s.tcal_exclusive_amt, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
        FROM stg.stg_cbadj_adjvoucher_hdr s
        LEFT JOIN dwh.F_cbadjadjvoucherhdr t
        ON s.ou_id = t.ou_id
    AND s.adj_voucher_no = t.adj_voucher_no
    AND s.voucher_tran_type = t.voucher_tran_type
        WHERE t.ou_id IS NULL;

        GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

        INSERT INTO raw.raw_cbadj_adjvoucher_hdr
        (
            ou_id, adj_voucher_no, voucher_tran_type, timestamp, voucher_date, fb_id, voucher_amount, status, cust_code, cust_hierarchy, adjust_seq, currency_code, voucher_type, rev_voucher_no, reversal_date, notype_no, reason_code, remarks, currentkey, batch_id, createdby, createddate, modifiedby, modifieddate, tcal_status, tcal_exclusive_amt, total_tcal_amount, consistency_stamp, voucher_amount_OvrAdj, ims_flag, scheme_code, CrNoteNo, DrNoteNo, CrNoteOU, DrNoteOU, CrNoteFB, DrNoteFB, CrVoucNo, DrVoucNo, SrDocType, DestiBU, RevCrNoteNo, RevDrNoteNo, RevCrVoucNo, RevDrVoucNo, workflow_status, pdc_flag, etlcreateddatetime
        )
        SELECT
            ou_id, adj_voucher_no, voucher_tran_type, timestamp, voucher_date, fb_id, voucher_amount, status, cust_code, cust_hierarchy, adjust_seq, currency_code, voucher_type, rev_voucher_no, reversal_date, notype_no, reason_code, remarks, currentkey, batch_id, createdby, createddate, modifiedby, modifieddate, tcal_status, tcal_exclusive_amt, total_tcal_amount, consistency_stamp, voucher_amount_OvrAdj, ims_flag, scheme_code, CrNoteNo, DrNoteNo, CrNoteOU, DrNoteOU, CrNoteFB, DrNoteFB, CrVoucNo, DrVoucNo, SrDocType, DestiBU, RevCrNoteNo, RevDrNoteNo, RevCrVoucNo, RevDrVoucNo, workflow_status, pdc_flag, etlcreateddatetime
        FROM stg.stg_cbadj_adjvoucher_hdr;
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