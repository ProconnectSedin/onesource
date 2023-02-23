-- PROCEDURE: dwh.usp_d_asfinperioddtl(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_d_asfinperioddtl(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_d_asfinperioddtl(
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
    FROM stg.stg_as_finperiod_dtl;

    UPDATE dwh.D_asfinperioddtl t
    SET
        finyr_code            = s.finyr_code,
        finprd_code           = s.finprd_code,
        fin_timestamp         = s.timestamp,
        finprd_desc           = s.finprd_desc,
        finprd_startdt        = s.finprd_startdt,
        finprd_enddt          = s.finprd_enddt,
        finprd_status         = s.finprd_status,
        sequence_no           = s.sequence_no,
        legacy_date           = s.legacy_date,
        active_from           = s.active_from,
        active_to             = s.active_to,
        createdby             = s.createdby,
        createddate           = s.createddate,
        modifiedby            = s.modifiedby,
        modifieddate          = s.modifieddate,
        finprd_grp            = s.finprd_grp,
        etlactiveind          = 1,
        etljobname            = p_etljobname,
        envsourcecd           = p_envsourcecd,
        datasourcecd          = p_datasourcecd,
        etlupdatedatetime     = NOW()
    FROM stg.stg_as_finperiod_dtl s
    WHERE t.finyr_code = s.finyr_code
    AND t.finprd_code = s.finprd_code;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.d_asfinperioddtl
    (
        finyr_code		, finprd_code	, fin_timestamp	, finprd_desc	, finprd_startdt, 
		finprd_enddt	, finprd_status	, sequence_no	, legacy_date	, active_from, 
		active_to		, createdby		, createddate	, modifiedby	, modifieddate, 
		finprd_grp		, 
		etlactiveind	, etljobname	, envsourcecd	, datasourcecd	, etlcreatedatetime
    )

    SELECT
        s.finyr_code	, s.finprd_code		, s.timestamp	, s.finprd_desc		, s.finprd_startdt, 
		s.finprd_enddt	, s.finprd_status	, s.sequence_no	, s.legacy_date		, s.active_from, 
		s.active_to		, s.createdby		, s.createddate	, s.modifiedby		, s.modifieddate, 
		s.finprd_grp	,
			1			, p_etljobname		, p_envsourcecd	, p_datasourcecd	, NOW()
    FROM stg.stg_as_finperiod_dtl s
    LEFT JOIN dwh.D_asfinperioddtl t
    ON s.finyr_code = t.finyr_code
    AND s.finprd_code = t.finprd_code
    WHERE t.finyr_code IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_as_finperiod_dtl
    (
        finyr_code, finprd_code, timestamp, finprd_desc, finprd_startdt, finprd_enddt, finprd_status, sequence_no, legacy_date, active_from, active_to, createdby, createddate, modifiedby, modifieddate, finprd_grp, etlcreateddatetime
    )
    SELECT
        finyr_code, finprd_code, timestamp, finprd_desc, finprd_startdt, finprd_enddt, finprd_status, sequence_no, legacy_date, active_from, active_to, createdby, createddate, modifiedby, modifieddate, finprd_grp, etlcreateddatetime
    FROM stg.stg_as_finperiod_dtl;
    
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
ALTER PROCEDURE dwh.usp_d_asfinperioddtl(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
