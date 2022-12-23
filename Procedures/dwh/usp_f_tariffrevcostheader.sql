CREATE PROCEDURE dwh.usp_f_tariffrevcostheader(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
	p_depsource VARCHAR(100);

    p_rawstorageflag integer;

BEGIN
    SELECT d.jobname, h.envsourcecode, h.datasourcecode, d.latestbatchid, d.targetprocedurename, h.rawstorageflag,h.depsource
    INTO p_etljobname, p_envsourcecd, p_datasourcecd, p_batchid, p_taskname, p_rawstorageflag,p_depsource
    FROM ods.controldetail d
    INNER JOIN ods.controlheader h
        ON d.sourceid = h.sourceid
    WHERE d.sourceid = p_sourceId
        AND d.dataflowflag = p_dataflowflag
        AND d.targetobject = p_targetobject;

	
    SELECT COUNT(1) INTO srccnt
    FROM stg.stg_tms_tarch_tariff_rev_cost_hdr;

    UPDATE dwh.f_tariffrevcostheader t
    SET
	    tarch_trip_hdr_key               = COALESCE(fh.plpth_hdr_key,-1),
        tarch_rate                       = s.tarch_rate,
        tarch_trip_plan_hdr_sk           = s.tarch_trip_plan_hdr_sk,
        tarch_created_by                 = s.tarch_created_by,
        tarch_created_date               = s.tarch_created_date,
        tarch_modified_by                = s.tarch_modified_by,
        tarch_modified_date              = s.tarch_modified_date,
        etlactiveind                     = 1,
        etljobname                       = p_etljobname,
        envsourcecd                      = p_envsourcecd,
        datasourcecd                     = p_datasourcecd,
        etlupdatedatetime                = NOW()
    FROM stg.stg_tms_tarch_tariff_rev_cost_hdr s
	LEFT JOIN dwh.f_tripplanningheader fh
	ON		tarch_ouinstance		=	fh.plpth_ouinstance
	AND		tarch_trip_plan_id		=	fh.plpth_trip_plan_id
    WHERE	t.tarch_ouinstance		=	s.tarch_ouinstance
    AND		t.tarch_trip_plan_id	=	s.tarch_trip_plan_id
    AND		t.tarch_unique_id		=	s.tarch_unique_id
    AND     t.tarch_stage_of_derivation = s.tarch_stage_of_derivation
	AND		t.tarch_buy_sell_type	=	s.tarch_buy_sell_type;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.f_tariffrevcostheader
    (
        tarch_trip_hdr_key,tarch_ouinstance, tarch_trip_plan_id, tarch_unique_id, tarch_stage_of_derivation, tarch_buy_sell_type, 
		tarch_rate, tarch_trip_plan_hdr_sk, tarch_created_by, tarch_created_date, tarch_modified_by, tarch_modified_date, 
		etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        COALESCE(fh.plpth_hdr_key,-1),s.tarch_ouinstance, s.tarch_trip_plan_id, s.tarch_unique_id, s.tarch_stage_of_derivation, s.tarch_buy_sell_type, 
		s.tarch_rate, s.tarch_trip_plan_hdr_sk, s.tarch_created_by, s.tarch_created_date, s.tarch_modified_by, s.tarch_modified_date, 
		1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM  stg.stg_tms_tarch_tariff_rev_cost_hdr s
	LEFT JOIN dwh.f_tripplanningheader fh
	ON		tarch_ouinstance		=	fh.plpth_ouinstance
	AND		tarch_trip_plan_id		=	fh.plpth_trip_plan_id
    LEFT JOIN dwh.f_tariffrevcostheader t
    ON		s.tarch_ouinstance		=	t.tarch_ouinstance
    AND		s.tarch_trip_plan_id	=	t.tarch_trip_plan_id
    AND		s.tarch_unique_id		=	t.tarch_unique_id
	AND		s.tarch_buy_sell_type	=	t.tarch_buy_sell_type
	AND		s.tarch_stage_of_derivation = t.tarch_stage_of_derivation
    WHERE	t.tarch_ouinstance IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_tms_tarch_tariff_rev_cost_hdr
    (
        tarch_ouinstance, tarch_trip_plan_id, tarch_unique_id, tarch_stage_of_derivation, tarch_buy_sell_type, tarch_rate, 
		tarch_trip_plan_hdr_sk, tarch_created_by, tarch_created_date, tarch_modified_by, tarch_modified_date, tarch_time_stamp, 
		etlcreateddatetime
    )
    SELECT
        tarch_ouinstance, tarch_trip_plan_id, tarch_unique_id, tarch_stage_of_derivation, tarch_buy_sell_type, tarch_rate, 
		tarch_trip_plan_hdr_sk, tarch_created_by, tarch_created_date, tarch_modified_by, tarch_modified_date, tarch_time_stamp, 
		etlcreateddatetime
    FROM stg.stg_tms_tarch_tariff_rev_cost_hdr;
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