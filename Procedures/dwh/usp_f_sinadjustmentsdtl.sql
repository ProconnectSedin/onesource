-- PROCEDURE: dwh.usp_f_sinadjustmentsdtl(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_sinadjustmentsdtl(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_sinadjustmentsdtl(
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
    FROM stg.stg_sinadjustmentsdtl;

    UPDATE dwh.f_sinadjustmentsdtl t
    SET
        tran_type                 = s.tran_type,
        tran_ou                   = s.tran_ou,
        tran_no                   = s.tran_no,
        ref_doc_type              = s.ref_doc_type,
        ref_doc_no                = s.ref_doc_no,
        timestamp                 = s.timestamp,
        ref_doc_date              = s.ref_doc_date,
        ref_doc_fb_id             = s.ref_doc_fb_id,
        ref_doc_amount            = s.ref_doc_amount,
        ref_doc_current_os        = s.ref_doc_current_os,
        guid                      = s.guid,
        REF_DOC_ADJAMT            = s.REF_DOC_ADJAMT,
        supp_doc_no               = s.supp_doc_no,
        remarks                   = s.remarks,
        etlactiveind              = 1,
        etljobname                = p_etljobname,
        envsourcecd               = p_envsourcecd,
        datasourcecd              = p_datasourcecd,
        etlupdatedatetime         = NOW()
    FROM stg.stg_sinadjustmentsdtl s
    WHERE t.tran_type = s.tran_type
    AND t.tran_ou = s.tran_ou
    AND t.tran_no = s.tran_no
    AND t.ref_doc_type = s.ref_doc_type
    AND t.ref_doc_no = s.ref_doc_no;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.f_sinadjustmentsdtl
    (
        tran_type, tran_ou, tran_no, ref_doc_type, ref_doc_no, timestamp, ref_doc_date, ref_doc_fb_id, ref_doc_amount, ref_doc_current_os, guid, REF_DOC_ADJAMT, supp_doc_no, remarks, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        s.tran_type, s.tran_ou, s.tran_no, s.ref_doc_type, s.ref_doc_no, s.timestamp, s.ref_doc_date, s.ref_doc_fb_id, s.ref_doc_amount, s.ref_doc_current_os, s.guid, s.REF_DOC_ADJAMT, s.supp_doc_no, s.remarks, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_sinadjustmentsdtl s
    LEFT JOIN dwh.f_sinadjustmentsdtl t
    ON s.tran_type = t.tran_type
    AND s.tran_ou = t.tran_ou
    AND s.tran_no = t.tran_no
    AND s.ref_doc_type = t.ref_doc_type
    AND s.ref_doc_no = t.ref_doc_no
    WHERE t.tran_type IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_sinadjustmentsdtl
    (
        tran_type, tran_ou, tran_no, ref_doc_type, ref_doc_no, timestamp, ref_doc_date, ref_doc_fb_id, ref_doc_amount, ref_doc_current_os, ref_doc_supp_ou, guid, createdby, createddate, modifiedby, modifieddate, mode_flag, REF_DOC_ADJAMT, Project_code, supp_doc_no, remarks, etlcreatedatetime
    )
    SELECT
        tran_type, tran_ou, tran_no, ref_doc_type, ref_doc_no, timestamp, ref_doc_date, ref_doc_fb_id, ref_doc_amount, ref_doc_current_os, ref_doc_supp_ou, guid, createdby, createddate, modifiedby, modifieddate, mode_flag, REF_DOC_ADJAMT, Project_code, supp_doc_no, remarks, etlcreatedatetime
    FROM stg.stg_sinadjustmentsdtl;
    
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
ALTER PROCEDURE dwh.usp_f_sinadjustmentsdtl(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
