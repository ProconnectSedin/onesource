CREATE PROCEDURE dwh.usp_f_stockrejecteddetail(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
        ON  d.sourceid 			= h.sourceid
    WHERE   d.sourceid 			= p_sourceId
        AND d.dataflowflag 		= p_dataflowflag
        AND d.targetobject 		= p_targetobject;

    SELECT COUNT(1) INTO srccnt FROM stg.stg_wms_stock_rejected_dtl;

    UPDATE dwh.f_stockrejecteddetail t
    SET
        rejstk_dtl_loc_key			= COALESCE(l.loc_key,-1),
		rejstk_dtl_itm_hdr_key		= COALESCE(i.itm_hdr_key,-1),
		rejstk_dtl_thu_key			= COALESCE(th.thu_key,-1),
		rejstk_loc_code             = s.wms_rejstk_loc_code,
        rejstk_ou                   = s.wms_rejstk_ou,
        rejstk_gr_no                = s.wms_rejstk_gr_no,
        rejstk_item_code            = s.wms_rejstk_item_code,
        rejstk_gr_line_no           = s.wms_rejstk_gr_line_no,
        rejstk_rejected_qty         = s.wms_rejstk_rejected_qty,
        rejstk_created_by           = s.wms_rejstk_created_by,
        rejstk_created_date         = s.wms_rejstk_created_date,
        rejstk_modified_by          = s.wms_rejstk_modified_by,
        rejstk_modified_date        = s.wms_rejstk_modified_date,
        rejstk_staging_id           = s.wms_rejstk_staging_id,
        rejstk_line_no              = s.wms_rejstk_line_no,
        rejstk_lot_no               = s.wms_rejstk_lot_no,
        rejstk_gr_exec_no           = s.wms_rejstk_gr_exec_no,
        rejstk_thuid                = s.wms_rejstk_thuid,
        rejstk_thu_ser_no           = s.wms_rejstk_thu_ser_no,
        etlactiveind                = 1,
        etljobname                  = p_etljobname,
        envsourcecd                 = p_envsourcecd,
        datasourcecd                = p_datasourcecd,
        etlupdatedatetime           = NOW()
    FROM stg.stg_wms_stock_rejected_dtl s
	LEFT JOIN dwh.d_location l
		ON  s.wms_rejstk_loc_code	= l.loc_code
		AND s.wms_rejstk_ou			= l.loc_ou
	LEFT JOIN dwh.d_itemheader i
		ON  s.wms_rejstk_item_code	= i.itm_code
		AND s.wms_rejstk_ou			= i.itm_ou
	LEFT JOIN dwh.d_thu th
		ON  s.wms_rejstk_thuid		= th.thu_id
		AND s.wms_rejstk_ou			= th.thu_ou		
    WHERE   t.rejstk_line_no		= s.wms_rejstk_line_no;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.f_stockrejecteddetail
    (
        rejstk_dtl_loc_key			, rejstk_dtl_itm_hdr_key		, rejstk_dtl_thu_key		, rejstk_loc_code, 
		rejstk_ou					, rejstk_gr_no					, rejstk_item_code			, rejstk_gr_line_no, 
		rejstk_rejected_qty			, rejstk_created_by				, rejstk_created_date		, rejstk_modified_by, 
		rejstk_modified_date		, rejstk_staging_id				, rejstk_line_no			, rejstk_lot_no, 
		rejstk_gr_exec_no			, rejstk_thuid					, rejstk_thu_ser_no			, etlactiveind, 
		etljobname					, envsourcecd					, datasourcecd				, etlcreatedatetime
    )

    SELECT
        COALESCE(l.loc_key,-1)		, COALESCE(i.itm_hdr_key,-1)	, COALESCE(th.thu_key,-1)	, s.wms_rejstk_loc_code, 
		s.wms_rejstk_ou				, s.wms_rejstk_gr_no			, s.wms_rejstk_item_code	, s.wms_rejstk_gr_line_no, 
		s.wms_rejstk_rejected_qty	, s.wms_rejstk_created_by		, s.wms_rejstk_created_date	, s.wms_rejstk_modified_by, 
		s.wms_rejstk_modified_date	, s.wms_rejstk_staging_id		, s.wms_rejstk_line_no		, s.wms_rejstk_lot_no, 
		s.wms_rejstk_gr_exec_no		, s.wms_rejstk_thuid			, s.wms_rejstk_thu_ser_no	, 1, 
		p_etljobname, p_envsourcecd	, p_datasourcecd				, NOW()
    FROM stg.stg_wms_stock_rejected_dtl s
	LEFT JOIN dwh.d_location l
		ON  s.wms_rejstk_loc_code	= l.loc_code
		AND s.wms_rejstk_ou			= l.loc_ou
	LEFT JOIN dwh.d_itemheader i
		ON  s.wms_rejstk_item_code	= i.itm_code
		AND s.wms_rejstk_ou			= i.itm_ou
	LEFT JOIN dwh.d_thu th
		ON  s.wms_rejstk_thuid		= th.thu_id
		AND s.wms_rejstk_ou			= th.thu_ou
    LEFT JOIN dwh.f_stockrejecteddetail t
		ON  s.wms_rejstk_line_no	= t.rejstk_line_no
    WHERE   t.rejstk_loc_code IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_wms_stock_rejected_dtl
    (
        wms_rejstk_loc_code		, wms_rejstk_ou				, wms_rejstk_gr_no			, wms_rejstk_item_code, 
		wms_rejstk_gr_line_no	, wms_rejstk_rejected_qty	, wms_rejstk_created_by		, wms_rejstk_created_date, 
		wms_rejstk_modified_by	, wms_rejstk_modified_date	, wms_rejstk_staging_id		, wms_rejstk_line_no, 
		wms_rejstk_lot_no		, wms_stk_sts				, wms_rejstk_gr_exec_no		, wms_rejstk_thuid, 
		wms_rejstk_thu_ser_no	, wms_rejstk_thuid_2		, wms_rejstk_thu_ser_no_2	, wms_rejstk_su1_conv_flg, 
		wms_rejstk_su2_conv_flg	, etlcreateddatetime
    )
    SELECT
        wms_rejstk_loc_code		, wms_rejstk_ou				, wms_rejstk_gr_no			, wms_rejstk_item_code, 
		wms_rejstk_gr_line_no	, wms_rejstk_rejected_qty	, wms_rejstk_created_by		, wms_rejstk_created_date, 
		wms_rejstk_modified_by	, wms_rejstk_modified_date	, wms_rejstk_staging_id		, wms_rejstk_line_no, 
		wms_rejstk_lot_no		, wms_stk_sts				, wms_rejstk_gr_exec_no		, wms_rejstk_thuid, 
		wms_rejstk_thu_ser_no	, wms_rejstk_thuid_2		, wms_rejstk_thu_ser_no_2	, wms_rejstk_su1_conv_flg, 
		wms_rejstk_su2_conv_flg	, etlcreateddatetime
	FROM stg.stg_wms_stock_rejected_dtl;
    END IF;

    EXCEPTION WHEN others THEN
	GET stacked DIAGNOSTICS p_errorid   = returned_sqlstate, p_errordesc = message_text;
    CALL ods.usp_etlerrorinsert(p_sourceid, p_targetobject, p_dataflowflag, p_batchid,p_taskname, 'sp_ExceptionHandling', p_errorid, p_errordesc, null);
    SELECT 0 INTO inscnt;
    SELECT 0 INTO updcnt;
END;
$$;