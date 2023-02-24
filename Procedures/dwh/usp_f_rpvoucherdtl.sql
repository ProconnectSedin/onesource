-- PROCEDURE: dwh.usp_f_rpvoucherdtl(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_rpvoucherdtl(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_rpvoucherdtl(
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
    FROM stg.stg_rp_voucher_dtl;

    UPDATE dwh.F_rpvoucherdtl t
    SET
		bankcash_key			= COALESCE(cm.d_bank_mst_key, -1),
		currency_key			= COALESCE(cu.curr_key, -1),
		bankcode_key			= COALESCE(bk.bank_acc_mst_key, -1),
		companycode_key			= COALESCE(co.company_key, -1),
		ou_id                    = s.ou_id,
        serial_no                = s.serial_no,
        doc_type                 = s.doc_type,
        tran_ou                  = s.tran_ou,
        voucher_no               = s.voucher_no,
        payment_category         = s.payment_category,
        timestamp                = s.timestamp,
        checkseries_no           = s.checkseries_no,
        check_no                 = s.check_no,
        comp_reference           = s.comp_reference,
        currency                 = s.currency,
        payee_name               = s.payee_name,
        voucher_date             = s.voucher_date,
        voucher_amount           = s.voucher_amount,
        fb_id                    = s.fb_id,
        bank_code                = s.bank_code,
        flag                     = s.flag,
        pay_date                 = s.pay_date,
        priority                 = s.priority,
        pay_mode                 = s.pay_mode,
        voucher_status           = s.voucher_status,
        void_tran_no             = s.void_tran_no,
        nolinesinstub            = s.nolinesinstub,
        stubpropt                = s.stubpropt,
        void_date                = s.void_date,
        createdby                = s.createdby,
        createddate              = s.createddate,
        modifiedby               = s.modifiedby,
        modifieddate             = s.modifieddate,
        pay_charges              = s.pay_charges,
        company_code             = s.company_code,
        bank_acc_no              = s.bank_acc_no,
        pdc_void_flag            = s.pdc_void_flag,
        remarks                  = s.remarks,
        paycharges_bnkcur        = s.paycharges_bnkcur,
        etlactiveind             = 1,
        etljobname               = p_etljobname,
        envsourcecd              = p_envsourcecd,
        datasourcecd             = p_datasourcecd,
        etlupdatedatetime        = NOW()
    FROM stg.stg_rp_voucher_dtl s
	LEFT JOIN dwh.d_bankcashaccountmaster cm
	ON cm.company_code	= s.company_code
	AND cm.fb_id	= s.fb_id
	AND cm.bank_ptt_code	= s.bank_code
	AND cm.timestamp	= s.timestamp
	LEFT JOIN dwh.d_currency cu
	ON cu.iso_curr_code	= s.currency
	LEFT JOIN dwh.d_bankaccountmaster bk
	ON bk.bank_acc_no	= s.bank_acc_no
	AND bk.company_code = s.company_code
	LEFT JOIN  dwh.d_company co
	ON co.company_code = s.company_code
    WHERE t.ou_id = s.ou_id
    AND t.serial_no = s.serial_no
    AND t.doc_type = s.doc_type
    AND t.tran_ou = s.tran_ou
    AND t.voucher_no = s.voucher_no
    AND t.payment_category = s.payment_category;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_rpvoucherdtl
    (
		bankcash_key		, currency_key		, 
		bankcode_key		, companycode_key	,
        ou_id				, serial_no		, doc_type			, tran_ou		, voucher_no, 
		payment_category	, timestamp		, checkseries_no	, check_no		, comp_reference, 
		currency			, payee_name	, voucher_date		, voucher_amount, fb_id,
		bank_code			, flag			, pay_date			, priority		, pay_mode, 
		voucher_status		, void_tran_no	, nolinesinstub		, stubpropt		, void_date, 
		createdby			, createddate	, modifiedby		, modifieddate	, pay_charges, 
		company_code		, bank_acc_no	, pdc_void_flag		, remarks		, paycharges_bnkcur, 
		etlactiveind		, etljobname	, envsourcecd		, datasourcecd	, etlcreatedatetime
    )

    SELECT
		COALESCE(cm.d_bank_mst_key, -1)		, COALESCE(cu.curr_key, -1),
		COALESCE(bk.bank_acc_mst_key, -1)	, COALESCE(co.company_key, -1),
        s.ou_id				, s.serial_no	, s.doc_type		, s.tran_ou			, s.voucher_no,
		s.payment_category	, s.timestamp	, s.checkseries_no	, s.check_no		, s.comp_reference, 
		s.currency			, s.payee_name	, s.voucher_date	, s.voucher_amount	, s.fb_id, 
		s.bank_code			, s.flag		, s.pay_date		, s.priority		, s.pay_mode,
		s.voucher_status	, s.void_tran_no, s.nolinesinstub	, s.stubpropt		, s.void_date,
		s.createdby			, s.createddate	, s.modifiedby		, s.modifieddate	, s.pay_charges, 
		s.company_code		, s.bank_acc_no	, s.pdc_void_flag	, s.remarks			, s.paycharges_bnkcur, 
				1			, p_etljobname	, p_envsourcecd		, p_datasourcecd	, NOW()
    FROM stg.stg_rp_voucher_dtl s
	LEFT JOIN dwh.d_bankcashaccountmaster cm
	ON cm.company_code	= s.company_code
	AND cm.fb_id	= s.fb_id
	AND cm.bank_ptt_code	= s.bank_code
	AND cm.timestamp	= s.timestamp
	LEFT JOIN dwh.d_currency cu
	ON cu.iso_curr_code	= s.currency
	LEFT JOIN dwh.d_bankaccountmaster bk
	ON bk.bank_acc_no	= s.bank_acc_no
	AND bk.company_code = s.company_code
	LEFT JOIN  dwh.d_company co
	ON co.company_code = s.company_code
    LEFT JOIN dwh.F_rpvoucherdtl t
    ON s.ou_id = t.ou_id
    AND s.serial_no = t.serial_no
    AND s.doc_type = t.doc_type
    AND s.tran_ou = t.tran_ou
    AND s.voucher_no = t.voucher_no
    AND s.payment_category = t.payment_category
    WHERE t.ou_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_rp_voucher_dtl
    (
        ou_id, serial_no, doc_type, tran_ou, voucher_no, payment_category, timestamp, checkseries_no, check_no, comp_reference, currency, payee_name, voucher_date, voucher_amount, fb_id, bank_code, flag, pay_date, priority, address, pay_mode, voucher_status, void_tran_no, nolinesinstub, stubpropt, void_date, eft_no, eft_type, doc_status, createdby, createddate, modifiedby, modifieddate, filepath, Paybatch_no, pay_charges, consistency_stamp, company_code, bank_acc_no, pdc_flag, pdc_void_flag, remarks, paycharges_bnkcur, ifsccode, party_AccNo, party_ifsccode, party_Asspaymd, etlcreateddatetime
    )
    SELECT
        ou_id, serial_no, doc_type, tran_ou, voucher_no, payment_category, timestamp, checkseries_no, check_no, comp_reference, currency, payee_name, voucher_date, voucher_amount, fb_id, bank_code, flag, pay_date, priority, address, pay_mode, voucher_status, void_tran_no, nolinesinstub, stubpropt, void_date, eft_no, eft_type, doc_status, createdby, createddate, modifiedby, modifieddate, filepath, Paybatch_no, pay_charges, consistency_stamp, company_code, bank_acc_no, pdc_flag, pdc_void_flag, remarks, paycharges_bnkcur, ifsccode, party_AccNo, party_ifsccode, party_Asspaymd, etlcreateddatetime
    FROM stg.stg_rp_voucher_dtl;
    
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
ALTER PROCEDURE dwh.usp_f_rpvoucherdtl(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
