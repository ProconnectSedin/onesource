-- PROCEDURE: dwh.usp_f_stnpaymenthdr(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_stnpaymenthdr(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_stnpaymenthdr(
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
    FROM stg.stg_stn_payment_hdr;

    UPDATE dwh.F_stnpaymenthdr t
    SET
        ou_id                   = s.ou_id,
        trns_credit_note        = s.trns_credit_note,
        pay_term                = s.pay_term,
        tran_type               = s.tran_type,
        status                  = s.status,
        disc_computation        = s.disc_computation,
        elec_payment            = s.elec_payment,
        payment_method          = s.payment_method,
        payment_route           = s.payment_route,
        pay_mode                = s.pay_mode,
        esr_part_id             = s.esr_part_id,
        partid_digits           = s.partid_digits,
        esr_ref_no              = s.esr_ref_no,
        lsv_bank_code           = s.lsv_bank_code,
        lsv_contract_id         = s.lsv_contract_id,
        lsv_contract_ref        = s.lsv_contract_ref,
        comp_acct_in            = s.comp_acct_in,
        comp_bnkptt_acct        = s.comp_bnkptt_acct,
        comp_bnkptt_ref         = s.comp_bnkptt_ref,
        supp_acct_in            = s.supp_acct_in,
        supp_bnkptt_acct        = s.supp_bnkptt_acct,
        supp_bnkptt_ref         = s.supp_bnkptt_ref,
        ps_pi_flag              = s.ps_pi_flag,
        etlactiveind            = 1,
        etljobname              = p_etljobname,
        envsourcecd             = p_envsourcecd,
        datasourcecd            = p_datasourcecd,
        etlupdatedatetime       = NOW()
    FROM stg.stg_stn_payment_hdr s
    WHERE t.ou_id = s.ou_id
    AND t.trns_credit_note = s.trns_credit_note
    AND t.pay_term = s.pay_term
    AND t.tran_type = s.tran_type;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_stnpaymenthdr
    (
        ou_id, trns_credit_note, pay_term, 
		tran_type, status, disc_computation, 
		elec_payment, payment_method, payment_route, 
		pay_mode, esr_part_id, partid_digits, 
		esr_ref_no, lsv_bank_code, lsv_contract_id, 
		lsv_contract_ref, comp_acct_in, comp_bnkptt_acct, 
		comp_bnkptt_ref, supp_acct_in, supp_bnkptt_acct, 
		supp_bnkptt_ref, ps_pi_flag, etlactiveind, 
		etljobname, envsourcecd, datasourcecd, 
		etlcreatedatetime
    )

    SELECT
        s.ou_id, s.trns_credit_note, s.pay_term, 
		s.tran_type, s.status, s.disc_computation, 
		s.elec_payment, s.payment_method, s.payment_route, 
		s.pay_mode, s.esr_part_id, s.partid_digits, 
		s.esr_ref_no, s.lsv_bank_code, s.lsv_contract_id, 
		s.lsv_contract_ref, s.comp_acct_in, s.comp_bnkptt_acct, 
		s.comp_bnkptt_ref, s.supp_acct_in, s.supp_bnkptt_acct, 
		s.supp_bnkptt_ref, s.ps_pi_flag, 1, 
		p_etljobname, p_envsourcecd, p_datasourcecd, 
		NOW()
		
    FROM stg.stg_stn_payment_hdr s
    LEFT JOIN dwh.F_stnpaymenthdr t
    ON s.ou_id = t.ou_id
    AND s.trns_credit_note = t.trns_credit_note
    AND s.pay_term = t.pay_term
    AND s.tran_type = t.tran_type
    WHERE t.ou_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_stn_payment_hdr
    (
        ou_id, trns_credit_note, pay_term, tran_type, status, disc_computation, elec_payment, payment_method, payment_route, pay_mode, esr_part_id, partid_digits, esr_ref_no, lsv_bank_code, lsv_contract_id, lsv_contract_ref, comp_acct_in, comp_bnkptt_acct, comp_bnkptt_ref, supp_acct_in, supp_bnkptt_acct, supp_bnkptt_ref, ps_pi_flag, etlcreateddatetime
    )
    SELECT
        ou_id, trns_credit_note, pay_term, tran_type, status, disc_computation, elec_payment, payment_method, payment_route, pay_mode, esr_part_id, partid_digits, esr_ref_no, lsv_bank_code, lsv_contract_id, lsv_contract_ref, comp_acct_in, comp_bnkptt_acct, comp_bnkptt_ref, supp_acct_in, supp_bnkptt_acct, supp_bnkptt_ref, ps_pi_flag, etlcreateddatetime
    FROM stg.stg_stn_payment_hdr;
    
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
ALTER PROCEDURE dwh.usp_f_stnpaymenthdr(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
