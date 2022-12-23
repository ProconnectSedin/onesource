CREATE PROCEDURE dwh.usp_d_astaxyearhdr(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
    LANGUAGE plpgsql
    AS $$

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

BEGIN
    SELECT d.jobname, h.envsourcecode, h.datasourcecode, d.latestbatchid, d.targetprocedurename
    INTO p_etljobname, p_envsourcecd, p_datasourcecd, p_batchid, p_taskname
    FROM ods.controldetail d
    INNER JOIN ods.controlheader h
        ON d.sourceid = h.sourceid
    WHERE d.sourceid = p_sourceId
        AND d.dataflowflag = p_dataflowflag
        AND d.targetobject = p_targetobject;

    SELECT COUNT(1) INTO srccnt
    FROM stg.stg_as_taxyear_hdr;

    UPDATE dwh.D_astaxyearhdr t
    SET
        a_timestamp            = s.timestamp,
        taxyr_desc           = s.taxyr_desc,
        taxyr_startdt        = s.taxyr_startdt,
        taxyr_enddt          = s.taxyr_enddt,
        frequency            = s.frequency,
        taxyr_status         = s.taxyr_status,
        resou_id             = s.resou_id,
        rescomp_code         = s.rescomp_code,
        createdby            = s.createdby,
        createddate          = s.createddate,
        modifiedby           = s.modifiedby,
        modifieddate         = s.modifieddate,
        etlactiveind         = 1,
        etljobname           = p_etljobname,
        envsourcecd          = p_envsourcecd,
        datasourcecd         = p_datasourcecd,
        etlupdatedatetime    = NOW()
    FROM stg.stg_as_taxyear_hdr s
    WHERE t.taxyr_code = s.taxyr_code;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.D_astaxyearhdr
    (
        taxyr_code	, a_timestamp		, taxyr_desc	, taxyr_startdt	, taxyr_enddt, 
		frequency	, taxyr_status	, resou_id		, rescomp_code	, createdby, 
		createddate	, modifiedby	, modifieddate	, 
		etlactiveind, etljobname	, envsourcecd	, datasourcecd	, etlcreatedatetime
    )

    SELECT
        s.taxyr_code	, s.timestamp	, s.taxyr_desc	, s.taxyr_startdt	, s.taxyr_enddt, 
		s.frequency		, s.taxyr_status, s.resou_id	, s.rescomp_code	, s.createdby, 
		s.createddate	, s.modifiedby	, s.modifieddate,
				1		, p_etljobname	, p_envsourcecd	, p_datasourcecd	, NOW()
    FROM stg.stg_as_taxyear_hdr s
    LEFT JOIN dwh.D_astaxyearhdr t
    ON s.taxyr_code = t.taxyr_code
    WHERE t.taxyr_code IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    INSERT INTO raw.raw_as_taxyear_hdr
    (
        taxyr_code	, timestamp		, taxyr_desc	, taxyr_startdt		, taxyr_enddt, 
		frequency	, taxyr_status	, resou_id		, rescomp_code		, createdby, 
		createddate	, modifiedby	, modifieddate	, etlcreateddatetime
    )
    SELECT
        taxyr_code	, timestamp		, taxyr_desc	, taxyr_startdt		, taxyr_enddt, 
		frequency	, taxyr_status	, resou_id		, rescomp_code		, createdby, 
		createddate	, modifiedby	, modifieddate	, etlcreateddatetime
	FROM stg.stg_as_taxyear_hdr;

    EXCEPTION WHEN others THEN
        get stacked diagnostics
            p_errorid   = returned_sqlstate,
            p_errordesc = message_text;
    CALL ods.usp_etlerrorinsert(p_sourceid	, p_targetobject, p_dataflowflag, 
								p_batchid	, p_taskname	, 'sp_ExceptionHandling', 
								p_errorid	, p_errordesc	, null);
       select 0 into inscnt;
       select 0 into updcnt;
	   
END;
$$;