-- PROCEDURE: dwh.usp_f_fbpbankrequesttrndtl(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_fbpbankrequesttrndtl(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_fbpbankrequesttrndtl(
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
    FROM stg.stg_fbp_bank_request_trn_dtl;

-- 	select * from dwh.d_currency

	UPDATE dwh.F_fbpbankrequesttrndtl t
    SET
		currency_key		 = coalesce (cur.curr_key, -1),
		bankcash_key		 = coalesce (b.d_bank_mst_key, -1),
        ou_id                = s.ou_id,
        document_no          = s.document_no,
        fb_id                = s.fb_id,
        tran_type            = s.tran_type,
        bankcash_code        = s.bankcash_code,
        pay_type             = s.pay_type,
        amount_type          = s.amount_type,
        timestamp            = s.timestamp,
        doc_date             = s.doc_date,
        req_amount           = s.req_amount,
        currency_code        = s.currency_code,
        doc_user_id          = s.doc_user_id,
        component_id         = s.component_id,
        createdby            = s.createdby,
        createddate          = s.createddate,
        modifiedby           = s.modifiedby,
        modifieddate         = s.modifieddate,
        etlactiveind         = 1,
        etljobname           = p_etljobname,
        envsourcecd          = p_envsourcecd,
        datasourcecd         = p_datasourcecd,
        etlupdatedatetime    = NOW()
    FROM stg.stg_fbp_bank_request_trn_dtl s
	LEFT JOIN dwh.d_currency cur
	ON cur.iso_curr_code	= s.currency_code
	LEFT JOIN dwh.d_bankcashaccountmaster b
	ON b.bank_ptt_code		= s.bankcash_code
	AND b.fb_id 			= s.fb_id
	and b.timestamp			= s.timestamp
    WHERE t.ou_id 			= s.ou_id
    AND t.document_no 		= s.document_no
    AND t.fb_id		 		= s.fb_id
    AND t.tran_type	 		= s.tran_type
    AND t.bankcash_code 	= s.bankcash_code
    AND t.pay_type	 		= s.pay_type
    AND t.amount_type 		= s.amount_type;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_fbpbankrequesttrndtl
    (
		currency_key	, bankcash_key,
		ou_id			, document_no	, fb_id			, tran_type		, bankcash_code,
		pay_type		, amount_type	, timestamp		, doc_date		, req_amount,
		currency_code	, doc_user_id	, component_id	, createdby		, createddate, 
		modifiedby		, modifieddate	, 
		etlactiveind	, etljobname	, envsourcecd	, datasourcecd	, etlcreatedatetime
    )

    SELECT
		coalesce(cur.curr_key, -1)	, coalesce(b.d_bank_mst_key, -1),
		s.ou_id			, s.document_no	, s.fb_id		, s.tran_type	, s.bankcash_code,
		s.pay_type		, s.amount_type	, s.timestamp	, s.doc_date	, s.req_amount,
		s.currency_code	, s.doc_user_id	, s.component_id, s.createdby	, s.createddate,
		s.modifiedby	, s.modifieddate,
				1		, p_etljobname	, p_envsourcecd, p_datasourcecd	, NOW()
    FROM stg.stg_fbp_bank_request_trn_dtl s
	LEFT JOIN dwh.d_currency cur
	ON cur.iso_curr_code = s.currency_code
	LEFT JOIN dwh.d_bankcashaccountmaster b
	ON b.bank_ptt_code	= s.bankcash_code
	AND b.fb_id 		= s.fb_id
	and b.timestamp		= s.timestamp
    LEFT JOIN dwh.F_fbpbankrequesttrndtl t
    ON s.ou_id			= t.ou_id
    AND s.document_no	= t.document_no
    AND s.fb_id			= t.fb_id
    AND s.tran_type		= t.tran_type
    AND s.bankcash_code	= t.bankcash_code
    AND s.pay_type		= t.pay_type
    AND s.amount_type	= t.amount_type
    WHERE t.ou_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_fbp_bank_request_trn_dtl
    (
        ou_id, document_no, fb_id, tran_type, bankcash_code, pay_type, amount_type, timestamp, doc_date, req_amount, currency_code, doc_user_id, component_id, createdby, createddate, modifiedby, modifieddate, etlcreateddatetime
    )
    SELECT
        ou_id, document_no, fb_id, tran_type, bankcash_code, pay_type, amount_type, timestamp, doc_date, req_amount, currency_code, doc_user_id, component_id, createdby, createddate, modifiedby, modifieddate, etlcreateddatetime
    FROM stg.stg_fbp_bank_request_trn_dtl;
    
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
ALTER PROCEDURE dwh.usp_f_fbpbankrequesttrndtl(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
