-- PROCEDURE: dwh.usp_F_acapassetdocdtl(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_F_acapassetdocdtl(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_F_acapassetdocdtl(
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
    FROM stg.Stg_acap_asset_doc_dtl;

    UPDATE dwh.F_acapassetdocdtl t
    SET
	    currency_key      		=COALESCE(cr.curr_key, -1),
        ou_id                  = s.ou_id,
        cap_number             = s.cap_number,
        asset_number           = s.asset_number,
        doc_type               = s.doc_type,
        doc_number             = s.doc_number,
        supplier_name          = s.supplier_name,
        doc_date               = s.doc_date,
        doc_amount             = s.doc_amount,
        pending_cap_amt        = s.pending_cap_amt,
        proposal_number        = s.proposal_number,
        currency               = s.currency,
        exchange_rate          = s.exchange_rate,
        cap_amount             = s.cap_amount,
        finance_bookid         = s.finance_bookid,
        doc_status             = s.doc_status,
        createdby              = s.createdby,
        createddate            = s.createddate,
        modifiedby             = s.modifiedby,
        modifieddate           = s.modifieddate,
        tran_ou                = s.tran_ou,
        tran_type              = s.tran_type,
        cap_flag               = s.cap_flag,
        etlactiveind           = 1,
        etljobname             = p_etljobname,
        envsourcecd            = p_envsourcecd,
        datasourcecd           = p_datasourcecd,
        etlupdatedatetime      = NOW()
    FROM stg.Stg_acap_asset_doc_dtl s
	 LEFT JOIN dwh.d_currency cr
        ON cr.iso_curr_code             = s.currency
    WHERE t.ou_id = s.ou_id
    AND t.cap_number = s.cap_number
    AND t.asset_number = s.asset_number
    AND t.doc_type = s.doc_type
    AND t.doc_number = s.doc_number;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_acapassetdocdtl
    (
        currency_key , ou_id, cap_number, asset_number, doc_type, doc_number, supplier_name, doc_date, doc_amount, pending_cap_amt, proposal_number, currency, exchange_rate, cap_amount, finance_bookid, doc_status, createdby, createddate, modifiedby, modifieddate, tran_ou, tran_type, cap_flag, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
      COALESCE(cr.curr_key, -1), s.ou_id, s.cap_number, s.asset_number, s.doc_type, s.doc_number, s.supplier_name, s.doc_date, s.doc_amount, s.pending_cap_amt, s.proposal_number, s.currency, s.exchange_rate, s.cap_amount, s.finance_bookid, s.doc_status, s.createdby, s.createddate, s.modifiedby, s.modifieddate, s.tran_ou, s.tran_type, s.cap_flag, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.Stg_acap_asset_doc_dtl s
	 LEFT JOIN dwh.d_currency cr
        ON cr.iso_curr_code             = s.currency
    LEFT JOIN dwh.F_acapassetdocdtl t
    ON s.ou_id = t.ou_id
    AND s.cap_number = t.cap_number
    AND s.asset_number = t.asset_number
    AND s.doc_type = t.doc_type
    AND s.doc_number = t.doc_number
    WHERE t.ou_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_acap_asset_doc_dtl
    (
        ou_id, cap_number, asset_number, doc_type, doc_number, supplier_name, timestamp, doc_date, doc_amount, pending_cap_amt, proposal_number, gr_date, currency, exchange_rate, cap_amount, finance_bookid, doc_status, createdby, createddate, modifiedby, modifieddate, tran_ou, tran_type, cap_flag, etlcreateddatetime
    )
    SELECT
        ou_id, cap_number, asset_number, doc_type, doc_number, supplier_name, timestamp, doc_date, doc_amount, pending_cap_amt, proposal_number, gr_date, currency, exchange_rate, cap_amount, finance_bookid, doc_status, createdby, createddate, modifiedby, modifieddate, tran_ou, tran_type, cap_flag, etlcreateddatetime
    FROM stg.Stg_acap_asset_doc_dtl;
    
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

ALTER PROCEDURE dwh.usp_F_acapassetdocdtl(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
