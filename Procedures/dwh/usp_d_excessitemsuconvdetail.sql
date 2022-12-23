CREATE PROCEDURE dwh.usp_d_excessitemsuconvdetail(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
    FROM stg.stg_wms_ex_itm_su_conversion_dtl;

    UPDATE dwh.D_EXcessItemSUConvDetail t
    SET
		ex_itm_hdr_key				= COALESCE(i.itm_hdr_key,-1),
		ex_excessitem_key			= EX.ex_itm_key,
		ex_location_key				= L.loc_key,
        ex_itm_ou                   = s.wms_ex_itm_ou,
        ex_itm_code                 = s.wms_ex_itm_code,
        ex_itm_loc_code             = s.wms_ex_itm_loc_code,
        ex_itm_line_no              = s.wms_ex_itm_line_no,
        ex_itm_storage_unit         = s.wms_ex_itm_storage_unit,
        ex_itm_operator             = s.wms_ex_itm_operator,
        ex_itm_quantity             = s.wms_ex_itm_quantity,
        ex_itm_master_uom           = s.wms_ex_itm_master_uom,
        ex_itm_stack_ability        = s.wms_ex_itm_stack_ability,
        ex_itm_stack_count          = s.wms_ex_itm_stack_count,
        ex_itm_stack_height         = s.wms_ex_itm_stack_height,
        ex_itm_stack_weight         = s.wms_ex_itm_stack_weight,
        ex_itm_su_volume            = s.wms_ex_itm_su_volume,
        ex_itm_volume_uom           = s.wms_ex_itm_volume_uom,
        ex_itm_factory_pack         = s.wms_ex_itm_factory_pack,
        ex_itm_default              = s.wms_ex_itm_default,
        etlactiveind                = 1,
        etljobname                  = p_etljobname,
        envsourcecd                 = p_envsourcecd,
        datasourcecd                = p_datasourcecd,
        etlupdatedatetime           = NOW()
    FROM stg.stg_wms_ex_itm_su_conversion_dtl s
	LEFT JOIN dwh.d_excessitem EX
	ON EX.ex_itm_code 		= s.wms_ex_itm_code
	and EX.ex_itm_loc_code	= s.wms_ex_itm_loc_code
	and EX.ex_itm_ou		= s.wms_ex_itm_ou
	LEFT JOIN dwh.d_itemheader i
	ON	i.itm_code			= s.wms_ex_itm_code
	AND	i.itm_ou			= s.wms_ex_itm_ou
	LEFT JOIN dwh.d_location L
	on	L.loc_code	= s.wms_ex_itm_loc_code
	and	L.loc_ou	= s.wms_ex_itm_ou
    WHERE t.ex_itm_ou = s.wms_ex_itm_ou
    AND t.ex_itm_code = s.wms_ex_itm_code
    AND t.ex_itm_loc_code = s.wms_ex_itm_loc_code
    AND t.ex_itm_line_no = s.wms_ex_itm_line_no;
	
    GET DIAGNOSTICS updcnt = ROW_COUNT;
	

    INSERT INTO dwh.D_EXcessItemSUConvDetail
    (	
		ex_itm_hdr_key		,
		ex_excessitem_key	, ex_location_key		,
        ex_itm_ou			, ex_itm_code			, ex_itm_loc_code	, ex_itm_line_no		, ex_itm_storage_unit	, 
		ex_itm_operator		, ex_itm_quantity		, ex_itm_master_uom	, ex_itm_stack_ability	, ex_itm_stack_count	, 
		ex_itm_stack_height	, ex_itm_stack_weight	, ex_itm_su_volume	, ex_itm_volume_uom		, ex_itm_factory_pack	, 
		ex_itm_default		, 
		etlactiveind		, etljobname			, envsourcecd,		 datasourcecd			, etlcreatedatetime
    )

    SELECT 
		COALESCE(i.itm_hdr_key,-1)	,
		EX.ex_itm_key				, L.loc_key					,
        s.wms_ex_itm_ou				, s.wms_ex_itm_code			, s.wms_ex_itm_loc_code		, s.wms_ex_itm_line_no			, s.wms_ex_itm_storage_unit	, 
		s.wms_ex_itm_operator		, s.wms_ex_itm_quantity		, s.wms_ex_itm_master_uom	, s.wms_ex_itm_stack_ability	, s.wms_ex_itm_stack_count	, 
		s.wms_ex_itm_stack_height	, s.wms_ex_itm_stack_weight	, s.wms_ex_itm_su_volume	, s.wms_ex_itm_volume_uom		, s.wms_ex_itm_factory_pack	, 
		s.wms_ex_itm_default		, 
				1					, p_etljobname				, p_envsourcecd				, p_datasourcecd				, NOW()
	FROM  stg.stg_wms_ex_itm_su_conversion_dtl s
	LEFT JOIN dwh.d_excessitem EX
		ON EX.ex_itm_code 		= s.wms_ex_itm_code
		and EX.ex_itm_loc_code	= s.wms_ex_itm_loc_code
		and EX.ex_itm_ou		= s.wms_ex_itm_ou
	LEFT JOIN dwh.d_itemheader i
		ON	i.itm_code			= s.wms_ex_itm_code
		AND	i.itm_ou			= s.wms_ex_itm_ou
	LEFT JOIN dwh.d_location L
		on	L.loc_code	= s.wms_ex_itm_loc_code
		and	L.loc_ou	= s.wms_ex_itm_ou
    LEFT JOIN dwh.D_EXcessItemSUConvDetail t
    	ON s.wms_ex_itm_ou = t.ex_itm_ou
    	AND s.wms_ex_itm_code = t.ex_itm_code
    	AND s.wms_ex_itm_loc_code = t.ex_itm_loc_code
    	AND s.wms_ex_itm_line_no = t.ex_itm_line_no
    WHERE t.ex_itm_ou IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_wms_ex_itm_su_conversion_dtl
    (
        wms_ex_itm_ou, wms_ex_itm_code, wms_ex_itm_loc_code, wms_ex_itm_line_no, wms_ex_itm_storage_unit, wms_ex_itm_operator, wms_ex_itm_quantity, wms_ex_itm_master_uom, wms_ex_itm_consignee_code, wms_ex_itm_vendor_code, wms_ex_itm_sideload_count, wms_ex_itm_stack_ability, wms_ex_itm_stack_count, wms_ex_itm_stack_height, wms_ex_itm_stack_weight, wms_ex_itm_su_volume, wms_ex_itm_volume_uom, wms_ex_itm_factory_pack, wms_ex_itm_default, etlcreateddatetime
    )
    SELECT
        wms_ex_itm_ou, wms_ex_itm_code, wms_ex_itm_loc_code, wms_ex_itm_line_no, wms_ex_itm_storage_unit, wms_ex_itm_operator, wms_ex_itm_quantity, wms_ex_itm_master_uom, wms_ex_itm_consignee_code, wms_ex_itm_vendor_code, wms_ex_itm_sideload_count, wms_ex_itm_stack_ability, wms_ex_itm_stack_count, wms_ex_itm_stack_height, wms_ex_itm_stack_weight, wms_ex_itm_su_volume, wms_ex_itm_volume_uom, wms_ex_itm_factory_pack, wms_ex_itm_default, etlcreateddatetime
    FROM stg.stg_wms_ex_itm_su_conversion_dtl;
    
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