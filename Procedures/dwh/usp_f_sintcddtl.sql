-- PROCEDURE: dwh.usp_f_sintcddtl(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_sintcddtl(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_sintcddtl(
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
    FROM stg.stg_sin_tcd_dtl;

    UPDATE dwh.f_sintcddtl t
    SET
        tran_type             = s.tran_type,
        tran_ou               = s.tran_ou,
        tran_no               = s.tran_no,
        line_no               = s.line_no,
        item_tcd_code         = s.item_tcd_code,
        tcd_version           = s.tcd_version,
        item_tcd_var          = s.item_tcd_var,
        timestamp             = s.timestamp,
        item_type             = s.item_type,
        tcd_level             = s.tcd_level,
        tcd_rate              = s.tcd_rate,
        taxable_amount        = s.taxable_amount,
        tcd_amount            = s.tcd_amount,
        tcd_currency          = s.tcd_currency,
        base_amount           = s.base_amount,
        cost_center           = s.cost_center,
        tms_flag              = s.tms_flag,
        etlactiveind          = 1,
        etljobname            = p_etljobname,
        envsourcecd           = p_envsourcecd,
        datasourcecd          = p_datasourcecd,
        etlupdatedatetime     = NOW()
    FROM stg.stg_sin_tcd_dtl s
    WHERE t.tran_type = s.tran_type
    AND t.tran_ou = s.tran_ou
    AND t.tran_no = s.tran_no
    AND t.line_no = s.line_no
    AND t.item_tcd_code = s.item_tcd_code
    AND t.tcd_version = s.tcd_version
    AND t.item_tcd_var = s.item_tcd_var;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.f_sintcddtl
    (
        tran_type, tran_ou, tran_no, line_no, item_tcd_code, tcd_version, item_tcd_var, timestamp, item_type, tcd_level, tcd_rate, taxable_amount, tcd_amount, tcd_currency, base_amount, cost_center, tms_flag, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        s.tran_type, s.tran_ou, s.tran_no, s.line_no, s.item_tcd_code, s.tcd_version, s.item_tcd_var, s.timestamp, s.item_type, s.tcd_level, s.tcd_rate, s.taxable_amount, s.tcd_amount, s.tcd_currency, s.base_amount, s.cost_center, s.tms_flag, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_sin_tcd_dtl s
    LEFT JOIN dwh.f_sintcddtl t
    ON s.tran_type = t.tran_type
    AND s.tran_ou = t.tran_ou
    AND s.tran_no = t.tran_no
    AND s.line_no = t.line_no
    AND s.item_tcd_code = t.item_tcd_code
    AND s.tcd_version = t.tcd_version
    AND s.item_tcd_var = t.item_tcd_var
    WHERE t.tran_type IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_sin_tcd_dtl
    (
        tran_type, tran_ou, tran_no, line_no, item_tcd_code, tcd_version, item_tcd_var, timestamp, item_type, tcd_level, tcd_rate, taxable_amount, tcd_amount, tcd_currency, base_amount, par_base_amount, cost_center, analysis_code, subanalysis_code, remarks, proposed_amount, original_proposed_amt, createdby, createddate, modifiedby, modifieddate, tms_flag, etlcreateddatetime
    )
    SELECT
        tran_type, tran_ou, tran_no, line_no, item_tcd_code, tcd_version, item_tcd_var, timestamp, item_type, tcd_level, tcd_rate, taxable_amount, tcd_amount, tcd_currency, base_amount, par_base_amount, cost_center, analysis_code, subanalysis_code, remarks, proposed_amount, original_proposed_amt, createdby, createddate, modifiedby, modifieddate, tms_flag, etlcreateddatetime
    FROM stg.stg_sin_tcd_dtl;
    
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
ALTER PROCEDURE dwh.usp_f_sintcddtl(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
