-- PROCEDURE: dwh.usp_d_tset_calendar_dtl(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_d_tset_calendar_dtl(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_d_tset_calendar_dtl(
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
    FROM stg.stg_TSET_CALENDAR_DTL;
/*
    UPDATE dwh.d_tset_calendar_dtl t
    SET
        PAY_DUE_DATE                   = s.PAY_DUE_DATE,
        DECLARATION_PERIOD_DESC        = s.DECLARATION_PERIOD_DESC,
        START_DATE                     = s.START_DATE,
        STATUS                         = s.STATUS,
        END_DATE                       = s.END_DATE,
        CREATED_AT                     = s.CREATED_AT,
        CREATED_BY                     = s.CREATED_BY,
        CREATED_DATE                   = s.CREATED_DATE,
        MODIFIED_BY                    = s.MODIFIED_BY,
        MODIFIED_DATE                  = s.MODIFIED_DATE,
        etlactiveind                   = 1,
        etljobname                     = p_etljobname,
        envsourcecd                    = p_envsourcecd,
        datasourcecd                   = p_datasourcecd,
        etlupdatedatetime              = NOW()
    FROM stg.stg_TSET_CALENDAR_DTL s
    WHERE t.COMPANY_CODE = s.COMPANY_CODE
    AND t.DECLARATION_YEAR = s.DECLARATION_YEAR
    AND t.DECLARATION_PERIOD = s.DECLARATION_PERIOD;

    GET DIAGNOSTICS updcnt = ROW_COUNT;
*/
	 select 0 into updcnt;
	 
	TRUNCATE TABLE dwh.D_TsetCalendarDtl
	RESTART IDENTITY;

	INSERT INTO dwh.d_tsetcalendardtl
    (
        company_code			, declaration_year	, declaration_period	, pay_due_date,
		declaration_period_desc	, start_date		, status				, end_date,
		created_at				, created_by		, created_date			, modified_by,
		modified_date			,
		etlactiveind			, etljobname		, envsourcecd			, datasourcecd,
		etlcreatedatetime
    )

    SELECT
        s.company_code				, s.declaration_year	, s.declaration_period	, s.pay_due_date,
		s.declaration_period_desc	, s.start_date			, s.status				, s.end_date,
		s.created_at				, s.created_by			, s.created_date		, s.modified_by,
		s.modified_date				,
				1					, p_etljobname			, p_envsourcecd			, p_datasourcecd,
				now()
    FROM stg.stg_tset_calendar_dtl s;
--     LEFT JOIN dwh.d_tsetcalendardtl t
--     ON s.company_code = t.company_code
--     AND s.declaration_year = t.declaration_year
--     AND s.declaration_period = t.declaration_period
--     WHERE t.company_code is null;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_tset_calendar_dtl
    (
        company_code, declaration_year, declaration_period, pay_due_date, declaration_period_desc, start_date, status, end_date, created_at, created_by, created_date, modified_by, modified_date, etlcreatedatetime
    )
    SELECT
        company_code, declaration_year, declaration_period, pay_due_date, declaration_period_desc, start_date, status, end_date, created_at, created_by, created_date, modified_by, modified_date, etlcreatedatetime
    FROM stg.stg_tset_calendar_dtl;
    
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
ALTER PROCEDURE dwh.usp_d_tset_calendar_dtl(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
