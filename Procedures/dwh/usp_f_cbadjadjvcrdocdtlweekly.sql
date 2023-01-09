-- PROCEDURE: dwh.usp_f_cbadjadjvcrdocdtlweekly(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_cbadjadjvcrdocdtlweekly(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_cbadjadjvcrdocdtlweekly(
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
        FROM stg.stg_cbadj_adjv_crdoc_dtl;

        UPDATE dwh.F_cbadjadjvcrdocdtl t
        SET

        ou_id                      = s.ou_id,
        adj_voucher_no             = s.adj_voucher_no,
        cr_doc_ou                  = s.cr_doc_ou,
        cr_doc_type                = s.cr_doc_type,
        cr_doc_no                  = s.cr_doc_no,
        term_no                    = s.term_no,
        voucher_tran_type          = s.voucher_tran_type,
        cr_doc_adj_amt             = s.cr_doc_adj_amt,
        au_cr_doc_unadj_amt        = s.au_cr_doc_unadj_amt,
        au_cr_doc_date             = s.au_cr_doc_date,
        au_cr_doc_cur              = s.au_cr_doc_cur,
        au_fb_id                   = s.au_fb_id,
        au_receipt_type            = s.au_receipt_type,
        au_billing_point           = s.au_billing_point,
        parent_key                 = s.parent_key,
        current_key                = s.current_key,
        tran_type                  = s.tran_type,
        batch_id                   = s.batch_id,
        au_base_exrate             = s.au_base_exrate,
        au_par_base_exrate         = s.au_par_base_exrate,
        writeoff_amount            = s.writeoff_amount,
        res_writeoff_perc          = s.res_writeoff_perc,
        etlactiveind               = 1,
        etljobname                 = p_etljobname,
        envsourcecd                = p_envsourcecd,
        datasourcecd               = p_datasourcecd,
        etlupdatedatetime          = NOW()
        FROM stg.stg_cbadj_adjv_crdoc_dtl s
        WHERE t.ou_id = s.ou_id
    AND t.adj_voucher_no = s.adj_voucher_no
    AND t.cr_doc_ou = s.cr_doc_ou
    AND t.cr_doc_type = s.cr_doc_type
    AND t.cr_doc_no = s.cr_doc_no
    AND t.term_no = s.term_no
    AND t.voucher_tran_type = s.voucher_tran_type;

        GET DIAGNOSTICS updcnt = ROW_COUNT;

        INSERT INTO dwh.F_cbadjadjvcrdocdtl
        (
            ou_id, adj_voucher_no, cr_doc_ou, cr_doc_type, cr_doc_no, term_no, voucher_tran_type, cr_doc_adj_amt, au_cr_doc_unadj_amt, au_cr_doc_date, au_cr_doc_cur, au_fb_id, au_receipt_type, au_billing_point, parent_key, current_key, tran_type, batch_id, au_base_exrate, au_par_base_exrate, writeoff_amount, res_writeoff_perc, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
        )

        SELECT
            s.ou_id, s.adj_voucher_no, s.cr_doc_ou, s.cr_doc_type, s.cr_doc_no, s.term_no, s.voucher_tran_type, s.cr_doc_adj_amt, s.au_cr_doc_unadj_amt, s.au_cr_doc_date, s.au_cr_doc_cur, s.au_fb_id, s.au_receipt_type, s.au_billing_point, s.parent_key, s.current_key, s.tran_type, s.batch_id, s.au_base_exrate, s.au_par_base_exrate, s.writeoff_amount, s.res_writeoff_perc, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
        FROM stg.stg_cbadj_adjv_crdoc_dtl s
        LEFT JOIN dwh.F_cbadjadjvcrdocdtl t
        ON s.ou_id = t.ou_id
    AND s.adj_voucher_no = t.adj_voucher_no
    AND s.cr_doc_ou = t.cr_doc_ou
    AND s.cr_doc_type = t.cr_doc_type
    AND s.cr_doc_no = t.cr_doc_no
    AND s.term_no = t.term_no
    AND s.voucher_tran_type = t.voucher_tran_type
        WHERE t.ou_id IS NULL;
		
		 GET DIAGNOSTICS inscnt = ROW_COUNT;

--Updating etlactiveind for Deleted source data;

		UPDATE	dwh.F_cbadjadjvcrdocdtl t1
		SET 	etlactiveind =  0,
				etlupdatedatetime = Now()::timestamp
		FROM 	dwh.F_cbadjadjvcrdocdtl t
		LEFT join stg.stg_cbadj_adjv_crdoc_dtl s
		ON		s.ou_id 		= t.ou_id
		AND		s.adj_voucher_no = t.adj_voucher_no
		AND		s.cr_doc_ou 	= t.cr_doc_ou
		AND		s.cr_doc_type 	= t.cr_doc_type
		AND		s.cr_doc_no 	= t.cr_doc_no
		AND		s.term_no 		= t.term_no
		AND		s.voucher_tran_type = t.voucher_tran_type
		WHERE	t.adj_docdtl_key = t1.adj_docdtl_key
		AND	  	COALESCE(t.etlupdatedatetime,t.etlcreatedatetime)::date >= NOW()::DATE
		AND		 s.ou_id is null;

--Updating etlactiveind for Deleted source data ends;

    IF p_rawstorageflag = 1
    THEN

        INSERT INTO raw.raw_cbadj_adjv_crdoc_dtl
        (
            ou_id, adj_voucher_no, cr_doc_ou, cr_doc_type, cr_doc_no, term_no, voucher_tran_type, cr_doc_adj_amt, au_cr_doc_unadj_amt, au_cr_doc_date, au_cr_doc_cur, au_fb_id, au_receipt_type, au_billing_point, parent_key, current_key, tran_type, batch_id, au_base_exrate, au_par_base_exrate, BookingNo, MasterBillOfLadingNo, BillOfLadingNo, writeoff_amount, project_ou, Project_code, afe_number, job_number, refcostcenter_hdr, res_writeoff_perc, au_crosscur_erate, etlcreateddatetime
        )
        SELECT
            ou_id, adj_voucher_no, cr_doc_ou, cr_doc_type, cr_doc_no, term_no, voucher_tran_type, cr_doc_adj_amt, au_cr_doc_unadj_amt, au_cr_doc_date, au_cr_doc_cur, au_fb_id, au_receipt_type, au_billing_point, parent_key, current_key, tran_type, batch_id, au_base_exrate, au_par_base_exrate, BookingNo, MasterBillOfLadingNo, BillOfLadingNo, writeoff_amount, project_ou, Project_code, afe_number, job_number, refcostcenter_hdr, res_writeoff_perc, au_crosscur_erate, etlcreateddatetime
        FROM stg.stg_cbadj_adjv_crdoc_dtl;
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
ALTER PROCEDURE dwh.usp_f_cbadjadjvcrdocdtlweekly(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
