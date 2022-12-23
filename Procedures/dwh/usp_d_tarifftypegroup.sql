CREATE PROCEDURE dwh.usp_d_tarifftypegroup(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
    FROM stg.stg_wms_tariff_type_met;

    UPDATE dwh.D_TariffTypeGroup t
    SET
        tf_type_desc                  = s.wms_tf_type_desc,
        tf_formula                    = s.wms_tf_formula,
        tf_created_by                 = s.wms_tf_created_by,
        tf_created_date               = s.wms_tf_created_date,
        tf_langid                     = s.wms_tf_langid,
        tf_acc_flag                   = s.wms_tf_acc_flag,
        tariff_Code                   = s.wms_tariff_Code,
        description                   = s.wms_description,
        formula                       = s.formula,
        TF_TARIFF_CODE_VERSION        = s.WMS_TF_TARIFF_CODE_VERSION,
        tf_br_remit_flag              = s.wms_tf_br_remit_flag,
        tf_revenue_split              = s.wms_tf_revenue_split,
        tf_basicsforop                = s.wms_tf_basicsforop,
        etlactiveind                  = 1,
        etljobname                    = p_etljobname,
        envsourcecd                   = p_envsourcecd,
        datasourcecd                  = p_datasourcecd,
        etlupdatedatetime             = NOW()
    FROM stg.stg_wms_tariff_type_met s
    WHERE	t.tf_grp_code	= s.wms_tf_grp_code
    AND		t.tf_type_code	= s.wms_tf_type_code;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.D_TariffTypeGroup
    (
        tf_grp_code			, tf_type_code				, tf_type_desc		, tf_formula		, tf_created_by	, 
		tf_created_date		, tf_langid					, tf_acc_flag		, tariff_Code		, description	, 
		formula				, TF_TARIFF_CODE_VERSION	, tf_br_remit_flag	, tf_revenue_split	, tf_basicsforop, 
		etlactiveind		, etljobname				, envsourcecd		, datasourcecd		, etlcreatedatetime
    )

    SELECT
        s.wms_tf_grp_code	, s.wms_tf_type_code			, s.wms_tf_type_desc	, s.wms_tf_formula		, s.wms_tf_created_by	, 
		s.wms_tf_created_date, s.wms_tf_langid				, s.wms_tf_acc_flag		, s.wms_tariff_Code		, s.wms_description		, 
		s.formula			, s.WMS_TF_TARIFF_CODE_VERSION	, s.wms_tf_br_remit_flag, s.wms_tf_revenue_split, s.wms_tf_basicsforop	, 
				1			, p_etljobname					, p_envsourcecd			, p_datasourcecd		, NOW()
    FROM stg.stg_wms_tariff_type_met s
    LEFT JOIN dwh.D_TariffTypeGroup t
    ON	s.wms_tf_grp_code	= t.tf_grp_code
    AND	s.wms_tf_type_code	= t.tf_type_code
    WHERE	t.tf_grp_code IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
	IF p_rawstorageflag = 1
	THEN


    INSERT INTO raw.raw_wms_tariff_type_met
    (
        wms_tf_grp_code		, wms_tf_type_code			, wms_tf_type_desc		, wms_tf_formula		, wms_tf_created_by	, 
		wms_tf_created_date	, wms_tf_langid				, wms_tf_acc_flag		, wms_tariff_Code		, wms_description	, 
		formula				, WMS_TF_TARIFF_CODE_VERSION, wms_tf_br_remit_flag	, wms_tf_revenue_split	, wms_tf_basicsforop, 
		etlcreateddatetime
    )
    SELECT
        wms_tf_grp_code		, wms_tf_type_code			, wms_tf_type_desc		, wms_tf_formula		, wms_tf_created_by	, 
		wms_tf_created_date	, wms_tf_langid				, wms_tf_acc_flag		, wms_tariff_Code		, wms_description	, 
		formula				, WMS_TF_TARIFF_CODE_VERSION, wms_tf_br_remit_flag	, wms_tf_revenue_split	, wms_tf_basicsforop, 
		etlcreateddatetime
    FROM stg.stg_wms_tariff_type_met;
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