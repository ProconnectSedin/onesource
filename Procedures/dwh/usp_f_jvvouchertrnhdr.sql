CREATE PROCEDURE dwh.usp_f_jvvouchertrnhdr(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
    FROM stg.stg_jv_voucher_trn_hdr;

    UPDATE dwh.F_jvvouchertrnhdr t
    SET
     
        timestamp                 = s.timestamp,
        voucher_type              = s.voucher_type,
        voucher_date              = s.voucher_date,
        numbering_type            = s.numbering_type,
        fb_id                     = s.fb_id,
        ref_voucher_no            = s.ref_voucher_no,
        ref_voucher_type          = s.ref_voucher_type,
        rev_year                  = s.rev_year,
        rev_period                = s.rev_period,
        control_total             = s.control_total,
        remarks                   = s.remarks,
        voucher_status            = s.voucher_status,
        authorised_by             = s.authorised_by,
        authorised_date           = s.authorised_date,
        base_amount               = s.base_amount,
        component_id              = s.component_id,
        createdby                 = s.createdby,
        createddate               = s.createddate,
        modifiedby                = s.modifiedby,
        modifieddate              = s.modifieddate,
        tcal_exclusive_amt        = s.tcal_exclusive_amt,
        total_tcal_amount         = s.total_tcal_amount,
        tcal_status               = s.tcal_status,
        auto_gen_flag             = s.auto_gen_flag,
        source_fbid               = s.source_fbid,
        source_tran_no            = s.source_tran_no,
        source_tran_ou            = s.source_tran_ou,
        source_tran_type          = s.source_tran_type,
        source_tran_date          = s.source_tran_date,
        costcenter_hdr            = s.costcenter_hdr,
        Revsal_date               = s.Revsal_date,
        rev_remarks               = s.rev_remarks,
        ifb_usage                 = s.ifb_usage,
        etlactiveind              = 1,
        etljobname                = p_etljobname,
        envsourcecd               = p_envsourcecd,
        datasourcecd              = p_datasourcecd,
        etlupdatedatetime         = NOW()
    FROM stg.stg_jv_voucher_trn_hdr s
    WHERE t.ou_id = s.ou_id
    AND t.voucher_no = s.voucher_no;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_jvvouchertrnhdr
    (
        ou_id, voucher_no, timestamp, voucher_type, voucher_date, numbering_type, fb_id, ref_voucher_no, ref_voucher_type, rev_year, rev_period, control_total, remarks, voucher_status, authorised_by, authorised_date, base_amount, component_id, createdby, createddate, modifiedby, modifieddate, tcal_exclusive_amt, total_tcal_amount, tcal_status, auto_gen_flag, source_fbid, source_tran_no, source_tran_ou, source_tran_type, source_tran_date, costcenter_hdr, Revsal_date, rev_remarks, ifb_usage, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        s.ou_id, s.voucher_no, s.timestamp, s.voucher_type, s.voucher_date, s.numbering_type, s.fb_id, s.ref_voucher_no, s.ref_voucher_type, s.rev_year, s.rev_period, s.control_total, s.remarks, s.voucher_status, s.authorised_by, s.authorised_date, s.base_amount, s.component_id, s.createdby, s.createddate, s.modifiedby, s.modifieddate, s.tcal_exclusive_amt, s.total_tcal_amount, s.tcal_status, s.auto_gen_flag, s.source_fbid, s.source_tran_no, s.source_tran_ou, s.source_tran_type, s.source_tran_date, s.costcenter_hdr, s.Revsal_date, s.rev_remarks, s.ifb_usage, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_jv_voucher_trn_hdr s
    LEFT JOIN dwh.F_jvvouchertrnhdr t
    ON s.ou_id = t.ou_id
    AND s.voucher_no = t.voucher_no
    WHERE t.ou_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_jv_voucher_trn_hdr
    (
        ou_id, voucher_no, timestamp, voucher_type, voucher_date, numbering_type, fb_id, ref_voucher_no, ref_voucher_type, rev_year, rev_period, control_total, remarks, recvchrtemp_no, voucher_status, converted_flag, authorised_by, authorised_date, base_amount, component_id, doc_status, createdby, createddate, modifiedby, modifieddate, tcal_exclusive_amt, total_tcal_amount, tcal_status, auto_gen_flag, source_fbid, source_tran_no, source_tran_ou, source_tran_type, source_tran_date, workflow_status, project_ou, Project_code, afe_number, job_number, costcenter_hdr, Revsal_date, voucher_sub_type, rev_remarks, proposal_number, ifb_usage, ifb_remarks, action_typ, ifb_tran_no, ifb_tran_ou, ifb_tran_type, writeoff_flag, etlcreateddatetime
    )
    SELECT
        ou_id, voucher_no, timestamp, voucher_type, voucher_date, numbering_type, fb_id, ref_voucher_no, ref_voucher_type, rev_year, rev_period, control_total, remarks, recvchrtemp_no, voucher_status, converted_flag, authorised_by, authorised_date, base_amount, component_id, doc_status, createdby, createddate, modifiedby, modifieddate, tcal_exclusive_amt, total_tcal_amount, tcal_status, auto_gen_flag, source_fbid, source_tran_no, source_tran_ou, source_tran_type, source_tran_date, workflow_status, project_ou, Project_code, afe_number, job_number, costcenter_hdr, Revsal_date, voucher_sub_type, rev_remarks, proposal_number, ifb_usage, ifb_remarks, action_typ, ifb_tran_no, ifb_tran_ou, ifb_tran_type, writeoff_flag, etlcreateddatetime
    FROM stg.stg_jv_voucher_trn_hdr;
    
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