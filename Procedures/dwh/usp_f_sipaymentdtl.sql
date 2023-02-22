-- PROCEDURE: dwh.usp_f_sipaymentdtl(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_sipaymentdtl(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_sipaymentdtl(
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
    FROM stg.stg_si_payment_dtl;

--     UPDATE dwh.F_sipaymentdtl t
--     SET
--         tran_type               = s.tran_type,
--         tran_no                 = s.tran_no,
--         term_no                 = s.term_no,
--         tran_ou                 = s.tran_ou,
--         due_percent             = s.due_percent,
--         disc_percent            = s.disc_percent,
--         penalty_percent         = s.penalty_percent,
--         due_date                = s.due_date,
--         due_amount_type         = s.due_amount_type,
--         due_amount              = s.due_amount,
--         disc_comp_amount        = s.disc_comp_amount,
--         disc_amount_type        = s.disc_amount_type,
--         disc_date               = s.disc_date,
--         disc_amount             = s.disc_amount,
--         esr_coding_line         = s.esr_coding_line,
--         base_due_amount         = s.base_due_amount,
--         base_disc_amount        = s.base_disc_amount,
--         lo_id                   = s.lo_id,
--         batch_id                = s.batch_id,
--         timestamp               = s.timestamp,
--         rev_flag                = s.rev_flag,
--         etlactiveind            = 1,
--         etljobname              = p_etljobname,
--         envsourcecd             = p_envsourcecd,
--         datasourcecd            = p_datasourcecd,
--         etlupdatedatetime       = NOW()
--     FROM stg.stg_si_payment_dtl s
--     WHERE t.tran_type = s.tran_type
--     AND t.tran_no = s.tran_no
--     AND t.term_no = s.term_no
--     AND t.tran_ou = s.tran_ou;

--     GET DIAGNOSTICS updcnt = ROW_COUNT;
	

     SELECT 0 INTO updcnt ;

    Delete from dwh.F_sipaymentdtl t
	USING stg.stg_si_payment_dtl s
    WHERE t.tran_type = s.tran_type
    AND t.tran_no = s.tran_no
    AND t.term_no = s.term_no
    AND t.tran_ou = s.tran_ou
	AND (t.due_date)::DATE >= (CURRENT_DATE - INTERVAL '365 days')::DATE;
  	

    INSERT INTO dwh.F_sipaymentdtl
    (
        tran_type, tran_no, term_no, tran_ou, due_percent, disc_percent, penalty_percent, due_date, due_amount_type, due_amount, disc_comp_amount, disc_amount_type, disc_date, disc_amount, esr_coding_line, base_due_amount, base_disc_amount, lo_id, batch_id, timestamp, rev_flag, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        s.tran_type, s.tran_no, s.term_no, s.tran_ou, s.due_percent, s.disc_percent, s.penalty_percent, s.due_date, s.due_amount_type, s.due_amount, s.disc_comp_amount, s.disc_amount_type, s.disc_date, s.disc_amount, s.esr_coding_line, s.base_due_amount, s.base_disc_amount, s.lo_id, s.batch_id, s.timestamp, s.rev_flag, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_si_payment_dtl s
    LEFT JOIN dwh.F_sipaymentdtl t
    ON s.tran_type = t.tran_type
    AND s.tran_no = t.tran_no
    AND s.term_no = t.term_no
    AND s.tran_ou = t.tran_ou
    WHERE t.tran_type IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_si_payment_dtl
    (
        tran_type, tran_no, term_no, tran_ou, due_percent, disc_percent, penalty_percent, due_date, due_amount_type, due_precent, due_amount, disc_comp_amount, disc_amount_type, disc_date, disc_precent, disc_amount, penalty_precent, esr_ref_no, esr_coding_line, base_due_amount, base_disc_amount, lo_id, batch_id, createdby, createddate, modifiedby, modifieddate, timestamp, rev_due_date, rev_dis_date, rev_flag, etlcreateddatetime
    )
    SELECT
        tran_type, tran_no, term_no, tran_ou, due_percent, disc_percent, penalty_percent, due_date, due_amount_type, due_precent, due_amount, disc_comp_amount, disc_amount_type, disc_date, disc_precent, disc_amount, penalty_precent, esr_ref_no, esr_coding_line, base_due_amount, base_disc_amount, lo_id, batch_id, createdby, createddate, modifiedby, modifieddate, timestamp, rev_due_date, rev_dis_date, rev_flag, etlcreateddatetime
    FROM stg.stg_si_payment_dtl;
    
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
ALTER PROCEDURE dwh.usp_f_sipaymentdtl(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
