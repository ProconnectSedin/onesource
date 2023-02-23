-- PROCEDURE: dwh.usp_f_stntransferbalhdr(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_stntransferbalhdr(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_stntransferbalhdr(
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
    FROM stg.stg_stn_transfer_bal_hdr;

    UPDATE dwh.F_stntransferbalhdr t
    SET
        ou_id                     = s.ou_id,
		acc_key                   = coalesce(acc.opcoa_key,-1),
		datekey                   = coalesce(d.datekey,-1),
        transfer_docno            = s.transfer_docno,
        transfer_date             = s.transfer_date,
        batch_id                  = s.batch_id,
        transfer_bal_in           = s.transfer_bal_in,
        transferor                = s.transferor,
        auto_adjust               = s.auto_adjust,
        transferee                = s.transferee,
        transferor_docno          = s.transferor_docno,
        transferor_doctype        = s.transferor_doctype,
        transferee_docno          = s.transferee_docno,
        transferee_doctype        = s.transferee_doctype,
        au_account_balance        = s.au_account_balance,
        status                    = s.status,
        au_tran_amount            = s.au_tran_amount,
        au_account_code           = s.au_account_code,
        transfer_bal_to           = s.transfer_bal_to,
        trasferor_acc_code        = s.trasferor_acc_code,
        trasferee_acc_code        = s.trasferee_acc_code,
        createdby                 = s.createdby,
        modifiedby                = s.modifiedby,
        createddate               = s.createddate,
        modifieddate              = s.modifieddate,
        transferor_fb             = s.transferor_fb,
        transferor_curr           = s.transferor_curr,
        transferee_fb             = s.transferee_fb,
        transferee_curr           = s.transferee_curr,
        trans_type                = s.trans_type,
        consistency_stamp         = s.consistency_stamp,
        workflow_status           = s.workflow_status,
        destou                    = s.destou,
        etlactiveind              = 1,
        etljobname                = p_etljobname,
        envsourcecd               = p_envsourcecd,
        datasourcecd              = p_datasourcecd,
        etlupdatedatetime         = NOW()
    FROM stg.stg_stn_transfer_bal_hdr s
	LEFT JOIN dwh.d_operationalaccountdetail acc
	on    s.trasferor_acc_code = acc.account_code
	LEFT JOIN dwh.d_date d
	on    s.transfer_date::date = d.dateactual
    WHERE t.ou_id = s.ou_id
    AND   t.transfer_docno = s.transfer_docno;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_stntransferbalhdr
    (
        ou_id, acc_key,datekey,transfer_docno, transfer_date, batch_id, transfer_bal_in, transferor, auto_adjust, transferee, transferor_docno, transferor_doctype, transferee_docno, transferee_doctype, au_account_balance, status, au_tran_amount, au_account_code, transfer_bal_to, trasferor_acc_code, trasferee_acc_code, createdby, modifiedby, createddate, modifieddate, transferor_fb, transferor_curr, transferee_fb, transferee_curr, trans_type, consistency_stamp, workflow_status, destou, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        s.ou_id,coalesce(acc.opcoa_key,-1),coalesce(d.datekey,-1), s.transfer_docno, s.transfer_date, s.batch_id, s.transfer_bal_in, s.transferor, s.auto_adjust, s.transferee, s.transferor_docno, s.transferor_doctype, s.transferee_docno, s.transferee_doctype, s.au_account_balance, s.status, s.au_tran_amount, s.au_account_code, s.transfer_bal_to, s.trasferor_acc_code, s.trasferee_acc_code, s.createdby, s.modifiedby, s.createddate, s.modifieddate, s.transferor_fb, s.transferor_curr, s.transferee_fb, s.transferee_curr, s.trans_type, s.consistency_stamp, s.workflow_status, s.destou, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_stn_transfer_bal_hdr s
    LEFT JOIN dwh.F_stntransferbalhdr t
    ON s.ou_id = t.ou_id
    AND s.transfer_docno = t.transfer_docno
	LEFT JOIN dwh.d_operationalaccountdetail acc
	on    s.trasferor_acc_code = acc.account_code
	LEFT JOIN dwh.d_date d
	on    s.transfer_date::date = d.dateactual
    WHERE t.ou_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_stn_transfer_bal_hdr
    (
        ou_id, transfer_docno, transfer_date, batch_id, transfer_bal_in, transferor, auto_adjust, transferee, transferor_docno, transferor_doctype, transferee_docno, transferee_doctype, au_account_balance, status, au_tran_amount, au_account_code, transfer_bal_to, trasferor_acc_code, trasferee_acc_code, createdby, modifiedby, createddate, modifieddate, transferor_fb, transferor_curr, transferee_fb, transferee_curr, trans_type, consistency_stamp, workflow_status, destou, etlcreateddatetime
    )
    SELECT
        ou_id, transfer_docno, transfer_date, batch_id, transfer_bal_in, transferor, auto_adjust, transferee, transferor_docno, transferor_doctype, transferee_docno, transferee_doctype, au_account_balance, status, au_tran_amount, au_account_code, transfer_bal_to, trasferor_acc_code, trasferee_acc_code, createdby, modifiedby, createddate, modifieddate, transferor_fb, transferor_curr, transferee_fb, transferee_curr, trans_type, consistency_stamp, workflow_status, destou, etlcreateddatetime
    FROM stg.stg_stn_transfer_bal_hdr;
    
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
ALTER PROCEDURE dwh.usp_f_stntransferbalhdr(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
