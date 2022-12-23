CREATE PROCEDURE dwh.usp_d_tarifftype(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
    FROM stg.stg_wms_tariff_type_master;

    UPDATE dwh.D_TariffType t
    SET
        tar_applicability          = s.wms_tar_applicability,
        tar_scr_code               = s.wms_tar_scr_code,
        tar_type_code              = s.wms_tar_type_code,
        tar_tf_type                = s.wms_tar_tf_type,
        tar_display_tf_type        = s.wms_tar_display_tf_type,
        tar_created_by             = s.wms_tar_created_by,
        tar_created_date           = s.wms_tar_created_date,
        tar_modified_by            = s.wms_tar_modified_by,
        tar_modified_date          = s.wms_tar_modified_date,
        tar_timestamp              = s.wms_tar_timestamp,
        tar_revenue_split          = s.wms_tar_revenue_split,
        etlactiveind               = 1,
        etljobname                 = p_etljobname,
        envsourcecd                = p_envsourcecd,
        datasourcecd               = p_datasourcecd,
        etlupdatedatetime          = NOW()
    FROM stg.stg_wms_tariff_type_master s
    WHERE t.tar_lineno = s.wms_tar_lineno
    AND t.tar_ou = s.wms_tar_ou;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.D_TariffType
    (
        tar_lineno				, tar_ou					, tar_applicability			, tar_scr_code			, tar_type_code		, 
		tar_tf_type				, tar_display_tf_type		, tar_created_by			, tar_created_date		, tar_modified_by	, 
		tar_modified_date		, tar_timestamp				, tar_revenue_split			, 
		etlactiveind			, etljobname				, envsourcecd				, datasourcecd			, etlcreatedatetime
    )

    SELECT
        s.wms_tar_lineno		, s.wms_tar_ou				, s.wms_tar_applicability	, s.wms_tar_scr_code	, s.wms_tar_type_code	,
		s.wms_tar_tf_type		, s.wms_tar_display_tf_type	, s.wms_tar_created_by		, s.wms_tar_created_date, s.wms_tar_modified_by	, 
		s.wms_tar_modified_date	, s.wms_tar_timestamp		, s.wms_tar_revenue_split	, 
					1			, p_etljobname				, p_envsourcecd				, p_datasourcecd		, NOW()
    FROM stg.stg_wms_tariff_type_master s
    LEFT JOIN dwh.D_TariffType t
    ON s.wms_tar_lineno = t.tar_lineno
    AND s.wms_tar_ou = t.tar_ou
    WHERE t.tar_lineno IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
	IF p_rawstorageflag = 1
	THEN


    INSERT INTO raw.raw_wms_tariff_type_master
    (
        wms_tar_lineno			, wms_tar_ou				, wms_tar_applicability	, wms_tar_scr_code		, wms_tar_type_code		, 
		wms_tar_tf_type			, wms_tar_display_tf_type	, wms_tar_created_by	, wms_tar_created_date	, wms_tar_modified_by	, 
		wms_tar_modified_date	, wms_tar_timestamp			, wms_tar_revenue_split	, etlcreateddatetime
    )
    SELECT
        wms_tar_lineno			, wms_tar_ou				, wms_tar_applicability	, wms_tar_scr_code		, wms_tar_type_code		, 
		wms_tar_tf_type			, wms_tar_display_tf_type	, wms_tar_created_by	, wms_tar_created_date	, wms_tar_modified_by	, 
		wms_tar_modified_date	, wms_tar_timestamp			, wms_tar_revenue_split	, etlcreateddatetime
	FROM stg.stg_wms_tariff_type_master;
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