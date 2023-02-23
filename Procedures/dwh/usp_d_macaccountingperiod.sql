-- PROCEDURE: dwh.usp_d_macaccountingperiod(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_d_macaccountingperiod(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_d_macaccountingperiod(
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
    FROM stg.stg_mac_accounting_period;

    UPDATE dwh.D_macaccountingperiod t
    SET
        ou_id                  = s.ou_id,
        company_code           = s.company_code,
        ma_acc_yr_no           = s.ma_acc_yr_no,
        ma_acc_prd_no          = s.ma_acc_prd_no,
        ma_acc_prd_desc        = s.ma_acc_prd_desc,
        ma_start_date          = s.ma_start_date,
        ma_end_date            = s.ma_end_date,
        ma_status              = s.ma_status,
        ma_user_id             = s.ma_user_id,
        ma_datetime            = s.ma_datetime,
        ma_timestamp           = s.ma_timestamp,
        ma_createdby           = s.ma_createdby,
        ma_createdate          = s.ma_createdate,
        ma_modifedby           = s.ma_modifedby,
        ma_modifydate          = s.ma_modifydate,
        bu_id                  = s.bu_id,
        lo_id                  = s.lo_id,
        etlactiveind           = 1,
        etljobname             = p_etljobname,
        envsourcecd            = p_envsourcecd,
        datasourcecd           = p_datasourcecd,
        etlupdatedatetime      = NOW()
    FROM stg.stg_mac_accounting_period s
    WHERE s.ou_id			= t.ou_id
	AND s.company_code		= t.company_code
	AND s.ma_acc_yr_no		= t.ma_acc_yr_no
	AND s.ma_acc_prd_no 	= t.ma_acc_prd_no;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.D_macaccountingperiod
    (
        ou_id, company_code, ma_acc_yr_no, ma_acc_prd_no, ma_acc_prd_desc, ma_start_date, ma_end_date, ma_status, ma_user_id, ma_datetime, ma_timestamp, ma_createdby, ma_createdate, ma_modifedby, ma_modifydate, bu_id, lo_id, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        s.ou_id, s.company_code, s.ma_acc_yr_no, s.ma_acc_prd_no, s.ma_acc_prd_desc, s.ma_start_date, s.ma_end_date, s.ma_status, s.ma_user_id, s.ma_datetime, s.ma_timestamp, s.ma_createdby, s.ma_createdate, s.ma_modifedby, s.ma_modifydate, s.bu_id, s.lo_id, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_mac_accounting_period s
    LEFT JOIN dwh.D_macaccountingperiod t
    ON s.ou_id				= t.ou_id
	AND s.company_code		= t.company_code
	AND s.ma_acc_yr_no		= t.ma_acc_yr_no
	AND s.ma_acc_prd_no 	= t.ma_acc_prd_no
    WHERE t.ou_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_mac_accounting_period
    (
        ou_id, company_code, ma_acc_yr_no, ma_acc_prd_no, ma_acc_prd_desc, ma_start_date, ma_end_date, ma_status, ma_user_id, ma_datetime, ma_timestamp, ma_createdby, ma_createdate, ma_modifedby, ma_modifydate, bu_id, lo_id, etlcreateddatetime
    )
    SELECT
        ou_id, company_code, ma_acc_yr_no, ma_acc_prd_no, ma_acc_prd_desc, ma_start_date, ma_end_date, ma_status, ma_user_id, ma_datetime, ma_timestamp, ma_createdby, ma_createdate, ma_modifedby, ma_modifydate, bu_id, lo_id, etlcreateddatetime
    FROM stg.stg_mac_accounting_period;
    
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
ALTER PROCEDURE dwh.usp_d_macaccountingperiod(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
