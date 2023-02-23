-- PROCEDURE: dwh.usp_f_cdcnpaymentdtl(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_cdcnpaymentdtl(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_cdcnpaymentdtl(
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
    FROM stg.stg_cdcn_payment_dtl;

    UPDATE dwh.F_cdcnpaymentdtl t
    SET
        tran_type               = s.tran_type,
        tran_ou                 = s.tran_ou,
        tran_no                 = s.tran_no,
        term_no                 = s.term_no,
        timestamp               = s.timestamp,
        posting_status          = s.posting_status,
        posting_date            = s.posting_date,
        due_date                = s.due_date,
        due_amount_type         = s.due_amount_type,
        due_percent             = s.due_percent,
        due_amount              = s.due_amount,
        disc_comp_amount        = s.disc_comp_amount,
        disc_amount_type        = s.disc_amount_type,
        disc_date               = s.disc_date,
        disc_percent            = s.disc_percent,
        disc_amount             = s.disc_amount,
        penalty_percent         = s.penalty_percent,
        esr_ref_no              = s.esr_ref_no,
        esr_coding_line         = s.esr_coding_line,
        base_due_amount         = s.base_due_amount,
        base_disc_amount        = s.base_disc_amount,
        guid                    = s.guid,
        createdby               = s.createdby,
        createddate             = s.createddate,
        modifiedby              = s.modifiedby,
        modifieddate            = s.modifieddate,
        etlactiveind            = 1,
        etljobname              = p_etljobname,
        envsourcecd             = p_envsourcecd,
        datasourcecd            = p_datasourcecd,
        etlupdatedatetime       = NOW()
    FROM stg.stg_cdcn_payment_dtl s
    WHERE t.tran_ou = s.tran_ou
    AND t.tran_no = s.tran_no
    AND t.term_no = s.term_no
    AND t.tran_type = s.tran_type;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_cdcnpaymentdtl
    (
        tran_type, tran_ou, tran_no, term_no, timestamp, posting_status, posting_date, due_date, due_amount_type, due_percent, due_amount, disc_comp_amount, disc_amount_type, disc_date, disc_percent, disc_amount, penalty_percent, esr_ref_no, esr_coding_line, base_due_amount, base_disc_amount, guid, createdby, createddate, modifiedby, modifieddate, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        s.tran_type, s.tran_ou, s.tran_no, s.term_no, s.timestamp, s.posting_status, s.posting_date, s.due_date, s.due_amount_type, s.due_percent, s.due_amount, s.disc_comp_amount, s.disc_amount_type, s.disc_date, s.disc_percent, s.disc_amount, s.penalty_percent, s.esr_ref_no, s.esr_coding_line, s.base_due_amount, s.base_disc_amount, s.guid, s.createdby, s.createddate, s.modifiedby, s.modifieddate, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_cdcn_payment_dtl s
    LEFT JOIN dwh.F_cdcnpaymentdtl t
    ON t.tran_ou = s.tran_ou
    AND t.tran_no = s.tran_no
    AND t.term_no = s.term_no
    AND t.tran_type = s.tran_type
    WHERE t.tran_type IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_cdcn_payment_dtl
    (
        tran_type, tran_ou, tran_no, term_no, timestamp, posting_status, posting_date, due_date, due_amount_type, due_percent, due_amount, disc_comp_amount, disc_amount_type, disc_date, disc_percent, disc_amount, penalty_percent, esr_ref_no, esr_coding_line, base_due_amount, base_disc_amount, guid, createdby, createddate, modifiedby, modifieddate, etlcreateddatetime
    )
    SELECT
        tran_type, tran_ou, tran_no, term_no, timestamp, posting_status, posting_date, due_date, due_amount_type, due_percent, due_amount, disc_comp_amount, disc_amount_type, disc_date, disc_percent, disc_amount, penalty_percent, esr_ref_no, esr_coding_line, base_due_amount, base_disc_amount, guid, createdby, createddate, modifiedby, modifieddate, etlcreateddatetime
    FROM stg.stg_cdcn_payment_dtl;
    
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
ALTER PROCEDURE dwh.usp_f_cdcnpaymentdtl(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
