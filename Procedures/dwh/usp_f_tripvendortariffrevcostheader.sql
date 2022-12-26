CREATE OR REPLACE PROCEDURE dwh.usp_f_tripvendortariffrevcostheader(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
    SELECT d.jobname, h.envsourcecode, h.datasourcecode, d.latestbatchid, d.targetprocedurename, h.rawstorageflag
    INTO p_etljobname, p_envsourcecd, p_datasourcecd, p_batchid, p_taskname, p_rawstorageflag
    FROM ods.controldetail d
    INNER JOIN ods.controlheader h
        ON d.sourceid = h.sourceid
    WHERE d.sourceid = p_sourceId
        AND d.dataflowflag = p_dataflowflag
        AND d.targetobject = p_targetobject;

    SELECT COUNT(1) INTO srccnt
    FROM stg.stg_tms_tvtrch_trip_vendor_tariff_rev_cost_hdr;

    UPDATE dwh.F_TripVendorTariffRevCostHeader t
    SET
		tvtrch_trip_plan_hrd_key			= hdr.plpth_hdr_key,
        tvtrch_buy_sell_type              = s.tvtrch_buy_sell_type,
        tvtrch_rate                       = s.tvtrch_rate,
        tvtrch_trip_plan_hdr_sk           = s.tvtrch_trip_plan_hdr_sk,
        tvtrch_created_by                 = s.tvtrch_created_by,
        tvtrch_created_date               = s.tvtrch_created_date,
        tvtrch_modified_by                = s.tvtrch_modified_by,
        tvtrch_modified_date              = s.tvtrch_modified_date,
        tvtrch_time_stamp                 = s.tvtrch_time_stamp,
        etlactiveind                      = 1,
        etljobname                        = p_etljobname,
        envsourcecd                       = p_envsourcecd,
        datasourcecd                      = p_datasourcecd,
        etlupdatedatetime                 = NOW()
    FROM stg.stg_tms_tvtrch_trip_vendor_tariff_rev_cost_hdr s
	INNER JOIN dwh.f_tripPlanningHeader	hdr
	ON hdr.plpth_trip_plan_id	= s.tvtrch_trip_plan_id
	AND	hdr.plpth_ouinstance	= s.tvtrch_ouinstance
    WHERE t.tvtrch_ouinstance = s.tvtrch_ouinstance
    AND t.tvtrch_trip_plan_id = s.tvtrch_trip_plan_id
    AND t.tvtrch_unique_id = s.tvtrch_unique_id
    AND t.tvtrch_stage_of_derivation = s.tvtrch_stage_of_derivation;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_TripVendorTariffRevCostHeader
    (
		tvtrch_trip_plan_hrd_key,
        tvtrch_ouinstance		, tvtrch_trip_plan_id	, tvtrch_unique_id			, tvtrch_stage_of_derivation, 
		tvtrch_buy_sell_type	, tvtrch_rate			, tvtrch_trip_plan_hdr_sk	, tvtrch_created_by, 
		tvtrch_created_date		, tvtrch_modified_by	, tvtrch_modified_date		, tvtrch_time_stamp, 
		etlactiveind			, etljobname			, envsourcecd				, datasourcecd		, 
		etlcreatedatetime
    )

    SELECT
		hdr.plpth_hdr_key		,
        s.tvtrch_ouinstance		, s.tvtrch_trip_plan_id	, s.tvtrch_unique_id		, s.tvtrch_stage_of_derivation, 
		s.tvtrch_buy_sell_type	, s.tvtrch_rate			, s.tvtrch_trip_plan_hdr_sk	, s.tvtrch_created_by, 
		s.tvtrch_created_date	, s.tvtrch_modified_by	, s.tvtrch_modified_date	, s.tvtrch_time_stamp, 
				1				, p_etljobname			, p_envsourcecd				, p_datasourcecd,
		NOW()
    FROM stg.stg_tms_tvtrch_trip_vendor_tariff_rev_cost_hdr s
	INNER JOIN dwh.f_tripPlanningHeader	hdr
	ON	hdr.plpth_trip_plan_id			= s.tvtrch_trip_plan_id
	AND	hdr.plpth_ouinstance			= s.tvtrch_ouinstance
    LEFT JOIN dwh.F_TripVendorTariffRevCostHeader t
    ON	s.tvtrch_ouinstance				= t.tvtrch_ouinstance
    AND	s.tvtrch_trip_plan_id			= t.tvtrch_trip_plan_id
    AND	s.tvtrch_unique_id				= t.tvtrch_unique_id
    AND	s.tvtrch_stage_of_derivation	= t.tvtrch_stage_of_derivation
    WHERE	t.tvtrch_ouinstance IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_tms_tvtrch_trip_vendor_tariff_rev_cost_hdr
    (
        tvtrch_ouinstance	, tvtrch_trip_plan_id	, tvtrch_unique_id			, tvtrch_stage_of_derivation, 
		tvtrch_buy_sell_type, tvtrch_rate			, tvtrch_trip_plan_hdr_sk	, tvtrch_created_by, 
		tvtrch_created_date	, tvtrch_modified_by	, tvtrch_modified_date		, tvtrch_time_stamp, 
		etlcreateddatetime
    )
    SELECT
        tvtrch_ouinstance	, tvtrch_trip_plan_id	, tvtrch_unique_id			, tvtrch_stage_of_derivation, 
		tvtrch_buy_sell_type, tvtrch_rate			, tvtrch_trip_plan_hdr_sk	, tvtrch_created_by, 
		tvtrch_created_date	, tvtrch_modified_by	, tvtrch_modified_date		, tvtrch_time_stamp, 
		etlcreateddatetime
	FROM stg.stg_tms_tvtrch_trip_vendor_tariff_rev_cost_hdr;
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