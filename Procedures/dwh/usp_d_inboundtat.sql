CREATE PROCEDURE dwh.usp_d_inboundtat(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
    FROM stg.stg_dim_Inbound_Tat;

    UPDATE dwh.D_InboundTAT t
    SET
		Location_key		= COALESCE(l.loc_key,-1),
        Cutofftime          = s.Cutofftime,
        ProcessTAT          = s.ProcessTAT,
        GRTAT               = s.GRTAT,
        PutawayTAT          = s.PutawayTAT,
        openingTime         = s.openingTime,
        ClosingTime         = s.ClosingTime,
        etlactiveind        = 1,
        etljobname          = p_etljobname,
        envsourcecd         = p_envsourcecd,
        datasourcecd        = p_datasourcecd,
        etlupdatedatetime   = NOW()
    FROM stg.stg_dim_Inbound_Tat s
	LEFT JOIN dwh.d_location l
	ON	l.loc_code	= s.Locationcode
	AND	l.loc_ou	= s.ou
    WHERE t.id		= s.id
    AND	t.ou		= s.ou
    AND t.Locationcode	= s.Locationcode
    AND t.OrderType		= s.OrderType
    AND t.ServiceType	= s.ServiceType;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.D_InboundTAT
    (
		Location_key	,
        id				, ou			, Locationcode	, OrderType	, 
		ServiceType		, Cutofftime	, ProcessTAT	, GRTAT	, 
		PutawayTAT		, openingTime	, ClosingTime	, 
		etlactiveind	, etljobname	, envsourcecd	, datasourcecd	, 
		etlcreatedatetime
    )

    SELECT
		COALESCE(l.loc_key,-1)	,
        s.id					, s.ou			, s.Locationcode, s.OrderType	, 
		s.ServiceType			, s.Cutofftime	, s.ProcessTAT	, s.GRTAT	, 
		s.PutawayTAT			, s.openingTime	, s.ClosingTime	, 
				1				, p_etljobname	, p_envsourcecd	, p_datasourcecd	, 
		NOW()
    FROM stg.stg_dim_Inbound_Tat s
	LEFT JOIN dwh.d_location l
	ON	l.loc_code	= s.Locationcode
	AND	l.loc_ou	= s.ou
    LEFT JOIN dwh.D_InboundTAT t
    ON	s.id	= t.id
    AND	s.ou	= t.ou
    AND	s.Locationcode	= t.Locationcode
    AND	s.OrderType		= t.OrderType
    AND	s.ServiceType	= t.ServiceType
    WHERE t.id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    INSERT INTO raw.raw_dim_Inbound_Tat
    (
        ou			, Locationcode		, OrderType		, ServiceType, 
		Cutofftime	, ProcessTAT		, GRTAT			, PutawayTAT, openingTime, 
		ClosingTime	, etlcreateddatetime
    )
    SELECT
        ou			, Locationcode		, OrderType		, ServiceType, 
		Cutofftime	, ProcessTAT		, GRTAT			, PutawayTAT, openingTime, 
		ClosingTime	, etlcreateddatetime
    FROM stg.stg_dim_Inbound_Tat;

    EXCEPTION WHEN others THEN
        GET STACKED DIAGNOSTICS
            p_errorid   = returned_sqlstate,
            p_errordesc = message_text;
    CALL ods.usp_etlerrorinsert(p_sourceid, p_targetobject, p_dataflowflag, 
								p_batchid,p_taskname, 'sp_ExceptionHandling', 
								p_errorid, p_errordesc, null);
       select 0 into inscnt;
       select 0 into updcnt;
	   
END;
$$;