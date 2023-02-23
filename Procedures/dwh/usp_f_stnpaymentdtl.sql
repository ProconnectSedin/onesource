-- PROCEDURE: dwh.usp_f_stnpaymentdtl(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_stnpaymentdtl(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_stnpaymentdtl(
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
    FROM stg.stg_stn_payment_dtl;

    UPDATE dwh.F_stnpaymentdtl t
    SET
		stnpaymenthdr_key		= coalesce(h.stnpaymenthdr_key,-1),
		stnpaymentdtl_datekey   = coalesce(d.datekey,-1),
        tran_type               = s.tran_type,
        ou_id                   = s.ou_id,
        trns_credit_note        = s.trns_credit_note,
        pay_term                = s.pay_term,
        term_no                 = s.term_no,
        due_date                = s.due_date,
        due_amt_type            = s.due_amt_type,
        due_percent             = s.due_percent,
        due_amount              = s.due_amount,
        disc_amount_type        = s.disc_amount_type,
        dis_comp_amt            = s.dis_comp_amt,
        discount_date           = s.discount_date,
        disc_percent            = s.disc_percent,
        discount                = s.discount,
        penalty_percent         = s.penalty_percent,
        esr_ref_no              = s.esr_ref_no,
        esr_amount              = s.esr_amount,
        esr_code_line           = s.esr_code_line,
        etlactiveind            = 1,
        etljobname              = p_etljobname,
        envsourcecd             = p_envsourcecd,
        datasourcecd            = p_datasourcecd,  
        etlupdatedatetime       = NOW()
    FROM stg.stg_stn_payment_dtl s
	left join dwh.f_stnpaymenthdr h
	on h.ou_id=s.ou_id
	and h.trns_credit_note=s.trns_credit_note
	and h.pay_term	= s.pay_term
	and h.tran_type =s.tran_type
	left join dwh.d_date d
	ON d.dateactual=s.discount_date::date
    WHERE t.tran_type = s.tran_type
    AND t.ou_id = s.ou_id
    AND t.trns_credit_note = s.trns_credit_note
    AND t.pay_term = s.pay_term
    AND t.term_no = s.term_no;
    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_stnpaymentdtl
    (
     stnpaymenthdr_key, stnpaymentdtl_datekey,  tran_type, ou_id, trns_credit_note, pay_term, term_no, due_date, due_amt_type, due_percent, due_amount, disc_amount_type, dis_comp_amt, discount_date, disc_percent, discount, penalty_percent, esr_ref_no, esr_amount, esr_code_line, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
    coalesce(h.stnpaymenthdr_key,-1),  coalesce(d.datekey,-1),  s.tran_type, s.ou_id, s.trns_credit_note, s.pay_term, s.term_no, s.due_date, s.due_amt_type, s.due_percent, s.due_amount, s.disc_amount_type, s.dis_comp_amt, s.discount_date, s.disc_percent, s.discount, s.penalty_percent, s.esr_ref_no, s.esr_amount, s.esr_code_line, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_stn_payment_dtl s
	left join dwh.f_stnpaymenthdr h
	on h.ou_id=s.ou_id
	and h.trns_credit_note=s.trns_credit_note
	and h.pay_term	= s.pay_term
	and h.tran_type =s.tran_type
	left join dwh.d_date d
	ON d.dateactual=s.discount_date::date	
    LEFT JOIN dwh.F_stnpaymentdtl t
    ON s.tran_type = t.tran_type
    AND s.ou_id = t.ou_id
    AND s.trns_credit_note = t.trns_credit_note
    AND s.pay_term = t.pay_term
    AND s.term_no = t.term_no
    WHERE t.tran_type IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_stn_payment_dtl
    (
        tran_type, ou_id, trns_credit_note, pay_term, term_no, due_date, due_amt_type, due_percent, due_amount, disc_amount_type, dis_comp_amt, discount_date, disc_percent, discount, penalty_percent, esr_ref_no, esr_amount, esr_code_line, etlcreateddatetime
    )
    SELECT
        tran_type, ou_id, trns_credit_note, pay_term, term_no, due_date, due_amt_type, due_percent, due_amount, disc_amount_type, dis_comp_amt, discount_date, disc_percent, discount, penalty_percent, esr_ref_no, esr_amount, esr_code_line, etlcreateddatetime
    FROM stg.stg_stn_payment_dtl;
    
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
ALTER PROCEDURE dwh.usp_f_stnpaymentdtl(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
