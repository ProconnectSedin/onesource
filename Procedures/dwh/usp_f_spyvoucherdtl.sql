-- PROCEDURE: dwh.usp_f_spyvoucherdtl(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_spyvoucherdtl(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_spyvoucherdtl(
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
    FROM stg.stg_spy_voucher_dtl;

    UPDATE dwh.F_spyvoucherdtl t
    SET
        ou_id                 = s.ou_id,
        paybatch_no           = s.paybatch_no,
        voucher_no            = s.voucher_no,
        cr_doc_ou             = s.cr_doc_ou,
        cr_doc_no             = s.cr_doc_no,
        term_no               = s.term_no,
        tran_type             = s.tran_type,
        timestamp             = s.vtimestamp,
        cr_doc_amount         = s.cr_doc_amount,
        cr_doc_type           = s.cr_doc_type,
        pay_amount            = s.pay_amount,
        discount              = s.discount,
        penalty               = s.penalty,
        batch_id              = s.batch_id,
        createdby             = s.createdby,
        createddate           = s.createddate,
        cr_doc_line_no        = s.cr_doc_line_no,
        etlactiveind          = 1,
        etljobname            = p_etljobname,
        envsourcecd           = p_envsourcecd,
        datasourcecd          = p_datasourcecd,
        etlupdatedatetime     = NOW()
    FROM stg.stg_spy_voucher_dtl s
    WHERE t.ou_id = s.ou_id
    AND t.paybatch_no = s.paybatch_no
    AND t.voucher_no = s.voucher_no
    AND t.cr_doc_ou = s.cr_doc_ou
    AND t.cr_doc_no = s.cr_doc_no
    AND t.term_no = s.term_no
    AND t.tran_type = s.tran_type
    AND t.timestamp = s.vtimestamp
    AND t.cr_doc_type = s.cr_doc_type;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_spyvoucherdtl
    (
        ou_id, paybatch_no, voucher_no, cr_doc_ou, cr_doc_no, term_no, tran_type, timestamp, cr_doc_amount, cr_doc_type, pay_amount, discount, penalty, batch_id, createdby, createddate, cr_doc_line_no, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        s.ou_id, s.paybatch_no, s.voucher_no, s.cr_doc_ou, s.cr_doc_no, s.term_no, s.tran_type, s.vtimestamp, s.cr_doc_amount, s.cr_doc_type, s.pay_amount, s.discount, s.penalty, s.batch_id, s.createdby, s.createddate, s.cr_doc_line_no, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_spy_voucher_dtl s
    LEFT JOIN dwh.F_spyvoucherdtl t
    ON s.ou_id = t.ou_id
    AND s.paybatch_no = t.paybatch_no
    AND s.voucher_no = t.voucher_no
    AND s.cr_doc_ou = t.cr_doc_ou
    AND s.cr_doc_no = t.cr_doc_no
    AND s.term_no = t.term_no
    AND s.tran_type = t.tran_type
    AND s.vtimestamp = t.timestamp
    AND s.cr_doc_type = t.cr_doc_type
    WHERE t.ou_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_spy_voucher_dtl
    (
        ou_id, paybatch_no, voucher_no, cr_doc_ou, cr_doc_no, term_no, tran_type, timestamp, cr_doc_amount, cr_doc_type, pay_amount, discount, penalty, batch_id, createdby, createddate, modifiedby, modifieddate, variance_amount, tcal_exclusive_amt, total_tcal_amount, tcal_status, cr_doc_line_no, project_ou, Project_code, afe_number, job_number, refcostcenter_hdr, tax_adj_jvno, prop_wht_amt, app_wht_amt, own_tax_region, party_tax_region, decl_tax_region, etlcreateddatetime
    )
    SELECT
        ou_id, paybatch_no, voucher_no, cr_doc_ou, cr_doc_no, term_no, tran_type, vtimestamp, cr_doc_amount, cr_doc_type, pay_amount, discount, penalty, batch_id, createdby, createddate, modifiedby, modifieddate, variance_amount, tcal_exclusive_amt, total_tcal_amount, tcal_status, cr_doc_line_no, project_ou, Project_code, afe_number, job_number, refcostcenter_hdr, tax_adj_jvno, prop_wht_amt, app_wht_amt, own_tax_region, party_tax_region, decl_tax_region, etlcreateddatetime
    FROM stg.stg_spy_voucher_dtl;
    
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
ALTER PROCEDURE dwh.usp_f_spyvoucherdtl(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
