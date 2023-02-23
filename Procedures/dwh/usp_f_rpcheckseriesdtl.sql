-- PROCEDURE: dwh.usp_f_rpcheckseriesdtl(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_rpcheckseriesdtl(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_rpcheckseriesdtl(
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
    FROM stg.stg_rp_checkseries_dtl;
	
--	select * from dwh.d_company

    UPDATE dwh.F_rpcheckseriesdtl t
    SET
		bankaccount_key		 = COALESCE(bk.bank_acc_mst_key, -1),
		companycode_key		 = COALESCE(co.company_key, -1),
        ou_id                 = s.ou_id,
        bank_code             = s.bank_code,
        checkseries_no        = s.checkseries_no,
        check_no              = s.check_no,
        timestamp             = s.timestamp,
        sequence_no           = s.sequence_no,
        check_date            = s.check_date,
        check_amount          = s.check_amount,
        reason_code           = s.reason_code,
        remarks               = s.remarks,
        pay_charges           = s.pay_charges,
        checkno_status        = s.checkno_status,
        createdby             = s.createdby,
        createddate           = s.createddate,
        modifiedby            = s.modifiedby,
        modifieddate          = s.modifieddate,
        bank_acc_no           = s.bank_acc_no,
        company_code          = s.company_code,
        etlactiveind          = 1,
        etljobname            = p_etljobname,
        envsourcecd           = p_envsourcecd,
        datasourcecd          = p_datasourcecd,
        etlupdatedatetime     = NOW()
    FROM stg.stg_rp_checkseries_dtl s
	LEFT JOIN dwh.d_bankaccountmaster bk
	ON bk.bank_acc_no	= s.bank_acc_no
	AND bk.company_code = s.company_code
	LEFT JOIN  dwh.d_company co
	ON co.company_code = s.company_code
    WHERE t.ou_id = s.ou_id
    AND t.bank_code = s.bank_code
    AND t.checkseries_no = s.checkseries_no
    AND t.check_no = s.check_no;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_rpcheckseriesdtl
    (
		bankaccount_key	, companycode_key,
        ou_id			, bank_code			, checkseries_no	, check_no		, timestamp, 
		sequence_no		, check_date		, check_amount		, reason_code	, remarks,
		pay_charges		, checkno_status	, createdby			, createddate	, modifiedby, 
		modifieddate	, bank_acc_no		, company_code		, 
		etlactiveind	, etljobname		, envsourcecd		, datasourcecd	, etlcreatedatetime
    )

    SELECT
		COALESCE(bk.bank_acc_mst_key, -1), COALESCE(co.company_key, -1),
        s.ou_id			, s.bank_code		, s.checkseries_no	, s.check_no		, s.timestamp,
		s.sequence_no	, s.check_date		, s.check_amount	, s.reason_code		, s.remarks,
		s.pay_charges	, s.checkno_status	, s.createdby		, s.createddate		, s.modifiedby,
		s.modifieddate	, s.bank_acc_no		, s.company_code	,
				1		, p_etljobname		, p_envsourcecd		, p_datasourcecd	, NOW()
    FROM stg.stg_rp_checkseries_dtl s
	LEFT JOIN dwh.d_bankaccountmaster bk
	ON bk.bank_acc_no	= s.bank_acc_no
	AND bk.company_code = s.company_code
	LEFT JOIN  dwh.d_company co
	ON co.company_code = s.company_code
    LEFT JOIN dwh.F_rpcheckseriesdtl t
    ON s.ou_id = t.ou_id
    AND s.bank_code = t.bank_code
    AND s.checkseries_no = t.checkseries_no
    AND s.check_no = t.check_no
    WHERE t.ou_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_rp_checkseries_dtl
    (
        ou_id, bank_code, checkseries_no, check_no, timestamp, sequence_no, check_date, check_amount, reason_code, remarks, pay_charges, instr_no, instr_date, checkno_status, createdby, createddate, modifiedby, modifieddate, bank_acc_no, company_code, etlcreateddatetime
    )
    SELECT
        ou_id, bank_code, checkseries_no, check_no, timestamp, sequence_no, check_date, check_amount, reason_code, remarks, pay_charges, instr_no, instr_date, checkno_status, createdby, createddate, modifiedby, modifieddate, bank_acc_no, company_code, etlcreateddatetime
    FROM stg.stg_rp_checkseries_dtl;
    
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
ALTER PROCEDURE dwh.usp_f_rpcheckseriesdtl(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
