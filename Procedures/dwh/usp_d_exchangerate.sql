CREATE OR REPLACE PROCEDURE dwh.usp_d_exchangerate(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
	p_rawstorageflag integer;


BEGIN
    SELECT d.jobname, h.envsourcecode, h.datasourcecode, d.latestbatchid, d.targetprocedurename,h.rawstorageflag

    INTO p_etljobname, p_envsourcecd, p_datasourcecd, p_batchid, p_taskname,p_rawstorageflag

    FROM ods.controldetail d
    INNER JOIN ods.controlheader h
    ON d.sourceid = h.sourceid
    WHERE d.sourceid = p_sourceId
    AND d.dataflowflag = p_dataflowflag
    AND d.targetobject = p_targetobject;

    SELECT COUNT(1) INTO srccnt
    FROM stg.stg_erate_exrate_mst;

    UPDATE dwh.D_ExchangeRate t
    SET
        timestamp              = s.timestamp,
        end_date               = s.end_date,
        exchange_rate          = s.exchange_rate,
        tolerance_flag         = s.tolerance_flag,
        tolerance_limit        = s.tolerance_limit,
        createdby              = s.createdby,
        createddate            = s.createddate,
        modifiedby             = s.modifiedby,
        modifieddate           = s.modifieddate,
        etlactiveind           = 1,
        etljobname             = p_etljobname,
        envsourcecd            = p_envsourcecd,
        datasourcecd           = p_datasourcecd,
        etlupdatedatetime      = NOW()
    FROM stg.stg_erate_exrate_mst s
    WHERE t.ou_id = s.ou_id
    AND t.exchrate_type = s.exchrate_type
    AND t.from_currency = s.from_currency
    AND t.to_currency = s.to_currency
    AND t.inverse_typeno = s.inverse_typeno
    AND t.start_date = s.start_date;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.D_ExchangeRate
    (
        ou_id			, exchrate_type		, from_currency	, 
		to_currency		, inverse_typeno	, start_date	, 
		timestamp		, end_date			, exchange_rate	, 
		tolerance_flag	, tolerance_limit	, createdby		, 
		createddate		, modifiedby		, modifieddate	, 
		etlactiveind	, etljobname		, envsourcecd	, 
		datasourcecd	, etlcreatedatetime
    )

    SELECT
        s.ou_id			, s.exchrate_type	, s.from_currency	,
		s.to_currency	, s.inverse_typeno	, s.start_date		, 
		s.timestamp		, s.end_date		, s.exchange_rate	, 
		s.tolerance_flag, s.tolerance_limit	, s.createdby		, 
		s.createddate	, s.modifiedby		, s.modifieddate	, 
				1		, p_etljobname		, p_envsourcecd		, 
		p_datasourcecd	, NOW()
    FROM stg.stg_erate_exrate_mst s
    LEFT JOIN dwh.D_ExchangeRate t
    ON s.ou_id = t.ou_id
    AND s.exchrate_type = t.exchrate_type
    AND s.from_currency = t.from_currency
    AND s.to_currency = t.to_currency
    AND s.inverse_typeno = t.inverse_typeno
    AND s.start_date = t.start_date
    WHERE t.ou_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
	IF p_rawstorageflag = 1
	THEN


    INSERT INTO raw.raw_erate_exrate_mst
    (
        ou_id			, exchrate_type		, from_currency		, 
		to_currency		, inverse_typeno	, start_date		, 
		timestamp		, serial_no			, end_date			, 
		exchange_rate	, tolerance_flag	, tolerance_limit	, 
		createdby		, createddate		, modifiedby		, 
		modifieddate	, etlcreateddatetime
    )
    SELECT
        ou_id			, exchrate_type		, from_currency		, 
		to_currency		, inverse_typeno	, start_date		, 
		timestamp		, serial_no			, end_date			, 
		exchange_rate	, tolerance_flag	, tolerance_limit	, 
		createdby		, createddate		, modifiedby		, 
		modifieddate	, etlcreateddatetime
    FROM stg.stg_erate_exrate_mst;
	END IF;

    EXCEPTION WHEN others THEN
        get stacked diagnostics
            p_errorid   = returned_sqlstate,
            p_errordesc = message_text;
    CALL ods.usp_etlerrorinsert(p_sourceid, p_targetobject, p_dataflowflag, p_batchid,p_taskname, 'sp_ExceptionHandling', p_errorid, p_errordesc, null);
       select 0 into inscnt;
       select 0 into updcnt;		
END;
$$;