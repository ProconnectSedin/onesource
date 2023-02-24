-- PROCEDURE: dwh.usp_f_stndocdtl(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_stndocdtl(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_stndocdtl(
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
    FROM stg.stg_stn_doc_dtl;

    UPDATE dwh.F_stndocdtl t
    SET
		stndocdtl_datekey		   = coalesce(d.datekey,-1)	,
        ou_id                      = s.ou_id,
        trns_debit_note            = s.trns_debit_note,
        tran_type                  = s.tran_type,
        dr_doc_no                  = s.dr_doc_no,
        ref_tran_type              = s.ref_tran_type,
        dr_doc_ou                  = s.dr_doc_ou,
        dr_doc_type                = s.dr_doc_type,
        au_doc_date                = s.au_doc_date,
        au_supp_area               = s.au_supp_area,
        au_document_amount         = s.au_document_amount,
        transfer_status            = s.transfer_status,
        exchange_rate              = s.exchange_rate,
        batch_id                   = s.batch_id,
        drcr_flag                  = s.drcr_flag,
        transfer_type              = s.transfer_type,
        docamt                     = s.docamt,
        docamt_parallelbase        = s.docamt_parallelbase,
        etlactiveind               = 1,
        etljobname                 = p_etljobname,
        envsourcecd                = p_envsourcecd,
        datasourcecd               = p_datasourcecd,
        etlupdatedatetime          = NOW()
    FROM stg.stg_stn_doc_dtl s
	left join dwh.d_date d
	on d.dateactual =s.au_doc_date::date
    WHERE t.ou_id = s.ou_id
    AND t.trns_debit_note = s.trns_debit_note
    AND t.dr_doc_no = s.dr_doc_no
    AND t.ref_tran_type = s.ref_tran_type
    AND t.dr_doc_ou = s.dr_doc_ou;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_stndocdtl
    (
     stndocdtl_datekey,   ou_id, trns_debit_note, tran_type, dr_doc_no, ref_tran_type, dr_doc_ou, dr_doc_type, au_doc_date, au_supp_area, au_document_amount, transfer_status, exchange_rate, batch_id, drcr_flag, transfer_type, docamt, docamt_parallelbase, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
      coalesce(d.datekey,-1),  s.ou_id, s.trns_debit_note, s.tran_type, s.dr_doc_no, s.ref_tran_type, s.dr_doc_ou, s.dr_doc_type, s.au_doc_date, s.au_supp_area, s.au_document_amount, s.transfer_status, s.exchange_rate, s.batch_id, s.drcr_flag, s.transfer_type, s.docamt, s.docamt_parallelbase, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_stn_doc_dtl s
	left join dwh.d_date d
	on d.dateactual =s.au_doc_date::date	
    LEFT JOIN dwh.F_stndocdtl t
    ON s.ou_id = t.ou_id
    AND s.trns_debit_note = t.trns_debit_note
    AND s.dr_doc_no = t.dr_doc_no
    AND s.ref_tran_type = t.ref_tran_type
    AND s.dr_doc_ou = t.dr_doc_ou
    WHERE t.ou_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_stn_doc_dtl
    (
        ou_id, trns_debit_note, tran_type, dr_doc_no, ref_tran_type, dr_doc_ou, dr_doc_type, au_doc_date, au_supp_area, au_document_amount, transfer_status, exchange_rate, batch_id, drcr_flag, transfer_type, docamt, docamt_parallelbase, etlcreateddatetime
    )
    SELECT
        ou_id, trns_debit_note, tran_type, dr_doc_no, ref_tran_type, dr_doc_ou, dr_doc_type, au_doc_date, au_supp_area, au_document_amount, transfer_status, exchange_rate, batch_id, drcr_flag, transfer_type, docamt, docamt_parallelbase, etlcreateddatetime
    FROM stg.stg_stn_doc_dtl;
    
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
ALTER PROCEDURE dwh.usp_f_stndocdtl(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
