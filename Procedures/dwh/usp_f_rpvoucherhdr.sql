-- PROCEDURE: dwh.usp_f_rpvoucherhdr(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_rpvoucherhdr(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_rpvoucherhdr(
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
    FROM stg.stg_rp_voucher_hdr;

    UPDATE dwh.F_rpvoucherhdr t
    SET
-- 	select * from dwh.d_company;
		companycode_key		= COALESCE(cu.company_key, -1),
		bankcode_key		= COALESCE(bk.bank_acc_mst_key, -1)	,
        ou_id               = s.ou_id,
        serial_no           = s.serial_no,
        doc_type            = s.doc_type,
        timestamp           = s.timestamp,
        createdby           = s.createdby,
        createddate         = s.createddate,
        company_code        = s.company_code,
        bank_acc_no         = s.bank_acc_no,
        etlactiveind        = 1,
        etljobname          = p_etljobname,
        envsourcecd         = p_envsourcecd,
        datasourcecd        = p_datasourcecd,
        etlupdatedatetime   = NOW()
    FROM stg.stg_rp_voucher_hdr s
	LEFT JOIN dwh.d_bankaccountmaster bk
	ON bk.bank_acc_no	= s.bank_acc_no
	AND bk.company_code = s.company_code
	LEFT JOIN dwh.d_company cu
	ON cu.company_code 	= s.company_code
    WHERE t.ou_id	= s.ou_id
    AND t.serial_no	= s.serial_no
    AND t.doc_type	= s.doc_type;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_rpvoucherhdr
    (
		companycode_key	, bankcode_key	,
        ou_id			, serial_no		, doc_type		, timestamp		, createdby, 
		createddate		, company_code	, bank_acc_no	, 
		etlactiveind	, etljobname	, envsourcecd	, datasourcecd	, etlcreatedatetime
    )

    SELECT
		COALESCE(cu.company_key, -1)	,COALESCE(bk.bank_acc_mst_key, -1)	,
        s.ou_id			, s.serial_no	, s.doc_type	, s.timestamp	, s.createdby,
		s.createddate	, s.company_code, s.bank_acc_no	,
				1		, p_etljobname	, p_envsourcecd	, p_datasourcecd, NOW()
    FROM stg.stg_rp_voucher_hdr s
	LEFT JOIN dwh.d_bankaccountmaster bk
	ON bk.bank_acc_no	= s.bank_acc_no
	AND bk.company_code = s.company_code
	LEFT JOIN dwh.d_company cu
	ON cu.company_code 	= s.company_code
    LEFT JOIN dwh.F_rpvoucherhdr t
    ON s.ou_id = t.ou_id
    AND s.serial_no = t.serial_no
    AND s.doc_type = t.doc_type
    WHERE t.ou_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_rp_voucher_hdr
    (
        ou_id, serial_no, doc_type, timestamp, createdby, createddate, modifiedby, modifieddate, company_code, bank_acc_no, etlcreateddatetime
    )
    SELECT
        ou_id, serial_no, doc_type, timestamp, createdby, createddate, modifiedby, modifieddate, company_code, bank_acc_no, etlcreateddatetime
    FROM stg.stg_rp_voucher_hdr;
    
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
ALTER PROCEDURE dwh.usp_f_rpvoucherhdr(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
