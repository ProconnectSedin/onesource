-- PROCEDURE: dwh.usp_F_acapassetdoclinedtl(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_F_acapassetdoclinedtl(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_F_acapassetdoclinedtl(
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
    FROM stg.Stg_acap_asset_doc_line_dtl;

    UPDATE dwh.F_acapassetdoclinedtl t
    SET
        ou_id                  = s.ou_id,
        cap_number             = s.cap_number,
        asset_number           = s.asset_number,
        doc_type               = s.doc_type,
        doc_number             = s.doc_number,
        line_no                = s.line_no,
        proposal_number        = s.proposal_number,
        doc_amount             = s.doc_amount,
        pending_cap_amt        = s.pending_cap_amt,
        cap_amount             = s.cap_amount,
        tag_group              = s.tag_group,
        doc_date               = s.doc_date,
        createdby              = s.createdby,
        createddate            = s.createddate,
        modifiedby             = s.modifiedby,
        modifieddate           = s.modifieddate,
        etlactiveind           = 1,
        etljobname             = p_etljobname,
        envsourcecd            = p_envsourcecd,
        datasourcecd           = p_datasourcecd,
        etlupdatedatetime      = NOW()
    FROM stg.Stg_acap_asset_doc_line_dtl s
    WHERE t.ou_id = s.ou_id
    AND t.cap_number = s.cap_number
    AND t.asset_number = s.asset_number
    AND t.doc_type = s.doc_type
    AND t.doc_number = s.doc_number
    AND t.line_no = s.line_no;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_acapassetdoclinedtl
    (
        ou_id, cap_number, asset_number, doc_type, doc_number, line_no, proposal_number, doc_amount, pending_cap_amt, cap_amount, tag_group, doc_date, createdby, createddate, modifiedby, modifieddate, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        s.ou_id, s.cap_number, s.asset_number, s.doc_type, s.doc_number, s.line_no, s.proposal_number, s.doc_amount, s.pending_cap_amt, s.cap_amount, s.tag_group, s.doc_date, s.createdby, s.createddate, s.modifiedby, s.modifieddate, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.Stg_acap_asset_doc_line_dtl s
    LEFT JOIN dwh.F_acapassetdoclinedtl t
    ON s.ou_id = t.ou_id
    AND s.cap_number = t.cap_number
    AND s.asset_number = t.asset_number
    AND s.doc_type = t.doc_type
    AND s.doc_number = t.doc_number
    AND s.line_no = t.line_no
    WHERE t.ou_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_acap_asset_doc_line_dtl
    (
        ou_id, cap_number, asset_number, doc_type, doc_number, line_no, timestamp, proposal_number, doc_amount, pending_cap_amt, cap_amount, tag_group, doc_date, createdby, createddate, modifiedby, modifieddate, etlcreateddatetime
    )
    SELECT
        ou_id, cap_number, asset_number, doc_type, doc_number, line_no, timestamp, proposal_number, doc_amount, pending_cap_amt, cap_amount, tag_group, doc_date, createdby, createddate, modifiedby, modifieddate, etlcreateddatetime
    FROM stg.Stg_acap_asset_doc_line_dtl;
    
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

ALTER PROCEDURE dwh.usp_F_acapassetdoclinedtl(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
