-- PROCEDURE: dwh.usp_f_pickplandetails(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_pickplandetails(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_pickplandetails(
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
    p_etljobname	VARCHAR(100);
    p_envsourcecd	VARCHAR(50);
    p_datasourcecd	VARCHAR(50);
    p_batchid		integer;
    p_taskname		VARCHAR(100);
    p_packagename 	VARCHAR(100);
    p_errorid		integer;
    p_errordesc		character varying;
    p_errorline		integer;
	p_depsource		VARCHAR(100);

    p_rawstorageflag integer;

BEGIN
    SELECT d.jobname, h.envsourcecode, h.datasourcecode, d.latestbatchid, d.targetprocedurename, h.rawstorageflag, h.depsource
    INTO p_etljobname, p_envsourcecd, p_datasourcecd, p_batchid, p_taskname, p_rawstorageflag,p_depsource
    FROM ods.controldetail d
    INNER JOIN ods.controlheader h
        ON d.sourceid = h.sourceid
    WHERE d.sourceid = p_sourceId
        AND d.dataflowflag = p_dataflowflag
        AND d.targetobject = p_targetobject;
		
	IF EXISTS(SELECT 1 FROM ods.controlheader WHERE sourceid = p_depsource AND status = 'Completed' 
					AND CAST(COALESCE(lastupdateddate,createddate) AS DATE) >= NOW()::DATE)
	THEN

    SELECT COUNT(1) INTO srccnt
    FROM stg.stg_wms_pick_plan_dtl;

    UPDATE dwh.F_PickPlanDetails t
    SET
		pick_pln_hdr_key				= hdr.pick_pln_hdr_key,
		pick_pln_loc_key				= COALESCE(l.loc_key,-1),
		pick_pln_item_key				= COALESCE(i.itm_hdr_key,-1),
		pick_pln_thu_key				= COALESCE(h.thu_key,-1),
        pick_wave_no                     = s.wms_pick_wave_no,
        pick_so_no                       = s.wms_pick_so_no,
        pick_so_line_no                  = s.wms_pick_so_line_no,
        pick_sch_lineno                  = s.wms_pick_sch_lineno,
        pick_item_code                   = s.wms_pick_item_code,
        pick_so_qty                      = s.wms_pick_so_qty,
        pick_item_batch_no               = s.wms_pick_item_batch_no,
        pick_item_sr_no                  = s.wms_pick_item_sr_no,
        pick_uid_sr_no                   = s.wms_pick_uid_sr_no,
        pick_qty                         = s.wms_pick_qty,
        pick_zone                        = s.wms_pick_zone,
        pick_bin                         = s.wms_pick_bin,
        pick_bin_qty                     = s.wms_pick_bin_qty,
        pick_su                          = s.wms_pick_su,
        pick_su_serial_no                = s.wms_pick_su_serial_no,
        pick_lot_no                      = s.wms_pick_lot_no,
        pick_allc_line_no                = s.wms_pick_allc_line_no,
        pick_su_type                     = s.wms_pick_su_type,
        pick_thu_id                      = s.wms_pick_thu_id,
        pick_rqs_confirm                 = s.wms_pick_rqs_confirm,
        pick_allocated_qty               = s.wms_pick_allocated_qty,
        pick_thu_serial_no               = s.wms_pick_thu_serial_no,
        pick_pln_urgent                  = s.wms_pick_pln_urgent,
        pick_length                      = s.wms_pick_length,
        pick_breadth                     = s.wms_pick_breadth,
        pick_height                      = s.wms_pick_height,
        pick_uom                         = s.wms_pick_uom,
        pick_volumeuom                   = s.wms_pick_volumeuom,
        pick_volume                      = s.wms_pick_volume,
        pick_weightuom                   = s.wms_pick_weightuom,
        pick_thuweight                   = s.wms_pick_thuweight,
        pick_customerserialno            = s.wms_pick_customerserialno,
        pick_warrantyserialno            = s.wms_pick_warrantyserialno,
        pick_staging_id                  = s.wms_pick_staging_id,
        pick_source_thu_id               = s.wms_pick_source_thu_id,
        pick_source_thu_serial_no        = s.wms_pick_source_thu_serial_no,
        pick_cross_dk_staging_id         = s.wms_pick_cross_dk_staging_id,
        pick_stock_status                = s.wms_pick_stock_status,
        pick_outbound_no                 = s.wms_pick_outbound_no,
        pick_customer_code               = s.wms_pick_customer_code,
        pick_customer_item_code          = s.wms_pick_customer_item_code,
        warranty_serial_no               = s.wms_warranty_serial_no,
        gift_card_serial_no              = s.wms_gift_card_serial_no,
        pick_conso_pln_no                = s.wms_pick_conso_pln_no,
        pick_line_complete_flag          = s.wms_pick_line_complete_flag,
        pick_item_attribute1             = s.wms_pick_item_attribute1,
        pick_item_attribute3             = s.wms_pick_item_attribute3,
        pick_item_attribute7             = s.wms_pick_item_attribute7,
        pick_line_status                 = s.wms_pick_line_status,
        etlactiveind                     = 1,
        etljobname                       = p_etljobname,
        envsourcecd                      = p_envsourcecd,
        datasourcecd                     = p_datasourcecd,
        etlupdatedatetime                = NOW()
    FROM stg.stg_wms_pick_plan_dtl s
	INNER JOIN dwh.f_pickPlanHeader hdr
	ON 		hdr.pick_loc_code		= s.wms_pick_loc_code
	AND 	hdr.pick_pln_no			= s.wms_pick_pln_no
	AND 	hdr.pick_pln_ou			= s.wms_pick_pln_ou
	LEFT JOIN  dwh.d_location l
	ON		s.wms_pick_loc_code		= l.loc_code
	AND		s.wms_pick_pln_ou		= l.loc_ou
	left join dwh.d_itemheader i 
	ON		s.wms_pick_item_code	= i.itm_code
	AND		s.wms_pick_pln_ou		= i.itm_ou
	left join dwh.d_thu h
	ON		s.wms_pick_thu_id		= h.thu_id
	AND		s.wms_pick_pln_ou		= h.thu_ou
    WHERE 	t.pick_loc_code			= s.wms_pick_loc_code
    AND		t.pick_pln_no			= s.wms_pick_pln_no
    AND		t.pick_pln_ou			= s.wms_pick_pln_ou
    AND		t.pick_lineno			= s.wms_pick_lineno;
	

	GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_PickPlanDetails
    (
	pick_pln_hdr_key	,
	pick_pln_loc_key 	, pick_pln_item_key 	, pick_pln_thu_key			, pick_loc_code	,
	pick_pln_no			, pick_pln_ou			, pick_lineno				, pick_wave_no	,
	pick_so_no			, pick_so_line_no		, pick_sch_lineno			, pick_item_code,
	pick_so_qty			, pick_item_batch_no	, pick_item_sr_no			, pick_uid_sr_no,
	pick_qty			, pick_zone				, pick_bin					, pick_bin_qty	,
	pick_su				, pick_su_serial_no		, pick_lot_no				, pick_allc_line_no	,
	pick_su_type		, pick_thu_id			, pick_rqs_confirm			, pick_allocated_qty,
	pick_thu_serial_no	, pick_pln_urgent		, pick_length				, pick_breadth	,
	pick_height			, pick_uom				, pick_volumeuom			, pick_volume	,
	pick_weightuom		, pick_thuweight		, pick_customerserialno		, pick_warrantyserialno		,
	pick_staging_id		, pick_source_thu_id	, pick_source_thu_serial_no	, pick_cross_dk_staging_id	,
	pick_stock_status	, pick_outbound_no		, pick_customer_code		, pick_customer_item_code	,
	warranty_serial_no	, gift_card_serial_no	, pick_conso_pln_no			, pick_line_complete_flag	,
	pick_item_attribute1, pick_item_attribute3	, pick_item_attribute7		, pick_line_status	,
	etlactiveind		, etljobname			, envsourcecd				, datasourcecd		,
	etlcreatedatetime
    )

    SELECT
	hdr.pick_pln_hdr_key,
    COALESCE(l.loc_key,-1)		, COALESCE(i.itm_hdr_key,-1), COALESCE(h.thu_key,-1)			,s.wms_pick_loc_code		, 
	s.wms_pick_pln_no			, s.wms_pick_pln_ou			, s.wms_pick_lineno					, s.wms_pick_wave_no		, 
	s.wms_pick_so_no			, s.wms_pick_so_line_no		, s.wms_pick_sch_lineno				, s.wms_pick_item_code		, 
	s.wms_pick_so_qty			, s.wms_pick_item_batch_no	, s.wms_pick_item_sr_no				, s.wms_pick_uid_sr_no		, 
	s.wms_pick_qty				, s.wms_pick_zone			, s.wms_pick_bin					, s.wms_pick_bin_qty		, 
	s.wms_pick_su				, s.wms_pick_su_serial_no	, s.wms_pick_lot_no					, s.wms_pick_allc_line_no	,
	s.wms_pick_su_type			, s.wms_pick_thu_id			, s.wms_pick_rqs_confirm			, s.wms_pick_allocated_qty	, 
	s.wms_pick_thu_serial_no	, s.wms_pick_pln_urgent		, s.wms_pick_length					, s.wms_pick_breadth		, 
	s.wms_pick_height			, s.wms_pick_uom			, s.wms_pick_volumeuom				, s.wms_pick_volume			,
	s.wms_pick_weightuom		, s.wms_pick_thuweight		, s.wms_pick_customerserialno		, s.wms_pick_warrantyserialno	,
	s.wms_pick_staging_id		, s.wms_pick_source_thu_id	, s.wms_pick_source_thu_serial_no	, s.wms_pick_cross_dk_staging_id,
	s.wms_pick_stock_status		, s.wms_pick_outbound_no	, s.wms_pick_customer_code			, s.wms_pick_customer_item_code	,
	s.wms_warranty_serial_no	, s.wms_gift_card_serial_no	, s.wms_pick_conso_pln_no			, s.wms_pick_line_complete_flag	,
	s.wms_pick_item_attribute1	, s.wms_pick_item_attribute3, s.wms_pick_item_attribute7		, s.wms_pick_line_status	,
				1				, p_etljobname				, p_envsourcecd						, p_datasourcecd			,
			NOW()
    FROM stg.stg_wms_pick_plan_dtl s
	INNER JOIN dwh.f_pickPlanHeader hdr
	ON 		hdr.pick_loc_code		= s.wms_pick_loc_code
	AND 	hdr.pick_pln_no			= s.wms_pick_pln_no
	AND 	hdr.pick_pln_ou			= s.wms_pick_pln_ou
	LEFT JOIN  dwh.d_location l
	ON 		s.wms_pick_loc_code		= l.loc_code
	AND 	s.wms_pick_pln_ou		= l.loc_ou
	left join dwh.d_itemheader i 
	ON 		s.wms_pick_item_code	= i.itm_code
	AND 	s.wms_pick_pln_ou		= i.itm_ou
	left join dwh.d_thu h
	ON 		s.wms_pick_thu_id		= h.thu_id
	AND 	s.wms_pick_pln_ou		= h.thu_ou
    LEFT JOIN dwh.F_PickPlanDetails t
    ON		s.wms_pick_loc_code		= t.pick_loc_code
    AND		s.wms_pick_pln_no		= t.pick_pln_no
    AND		s.wms_pick_pln_ou		= t.pick_pln_ou
    AND		s.wms_pick_lineno		= t.pick_lineno
    WHERE 	t.pick_loc_code IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_wms_pick_plan_dtl
    (
        wms_pick_loc_code				, wms_pick_pln_no				, wms_pick_pln_ou			, wms_pick_lineno			, 
		wms_pick_wave_no				, wms_pick_so_no				, wms_pick_so_line_no		, wms_pick_sch_lineno		, 
		wms_pick_item_code				, wms_pick_so_qty				, wms_pick_item_batch_no	, wms_pick_item_sr_no		, 
		wms_pick_uid_sr_no				, wms_pick_qty					, wms_pick_zone				, wms_pick_bin				, 
		wms_pick_bin_qty				, wms_pick_su					, wms_pick_su_serial_no		, wms_pick_lot_no			, 
		wms_pick_allc_line_no			, wms_pick_su_type				, wms_pick_thu_id			, wms_pick_rqs_confirm		,
		wms_pick_allocated_qty			, wms_pick_thu_serial_no		, wms_pick_tolerance_qty	, wms_pick_cons				, 
		wms_pick_pln_urgent				, wms_pick_thuspace				, wms_pick_length			, wms_pick_breadth			, 
		wms_pick_height					, wms_pick_uom					, wms_pick_volumeuom		, wms_pick_volume			,
		wms_pick_weightuom				, wms_pick_thuweight			, wms_pick_customerserialno, wms_pick_warrantyserialno	, 
		wms_pick_shelflife				, wms_pick_counted_blnceqty		, wms_pick_staging_id		, wms_pick_source_thu_id	, 
		wms_pick_source_thu_serial_no	, wms_pick_cross_dk_staging_id	, wms_pick_stock_status		, wms_pick_box_thu_id		, 
		wms_pick_box_no					, wms_pick_outbound_no			, wms_pick_customer_code	, wms_pick_customer_item_code, 
		wms_warranty_serial_no			, wms_gift_card_serial_no		, wms_pick_uom1				, wms_pick_su2				, 
		wms_pick_su_serial_no2			, wms_pp_chporcn_sell_bil_status, wms_pick_conso_pln_no		, wms_pick_line_complete_flag,
		wms_pick_multisu_reflineno		, wms_pick_orderuom				, wms_pick_masteruomqty		, wms_pick_orderqty			,
		wms_pick_item_attribute1		, wms_pick_item_attribute2		, wms_pick_item_attribute3	, wms_pick_item_attribute4	, 
		wms_pick_item_attribute5		, wms_pick_item_attribute6		, wms_pick_item_attribute7	, wms_pick_item_attribute8	,
		wms_pick_item_attribute9		, wms_pick_item_attribute10		, wms_pick_zone_su			, wms_pick_shrt_flag		, 
		wms_pick_line_status			, etlcreateddatetime
    )
    SELECT
        wms_pick_loc_code				, wms_pick_pln_no				, wms_pick_pln_ou			, wms_pick_lineno			, 
		wms_pick_wave_no				, wms_pick_so_no				, wms_pick_so_line_no		, wms_pick_sch_lineno		, 
		wms_pick_item_code				, wms_pick_so_qty				, wms_pick_item_batch_no	, wms_pick_item_sr_no		, 
		wms_pick_uid_sr_no				, wms_pick_qty					, wms_pick_zone				, wms_pick_bin				, 
		wms_pick_bin_qty				, wms_pick_su					, wms_pick_su_serial_no		, wms_pick_lot_no			, 
		wms_pick_allc_line_no			, wms_pick_su_type				, wms_pick_thu_id			, wms_pick_rqs_confirm		,
		wms_pick_allocated_qty			, wms_pick_thu_serial_no		, wms_pick_tolerance_qty	, wms_pick_cons				, 
		wms_pick_pln_urgent				, wms_pick_thuspace				, wms_pick_length			, wms_pick_breadth			, 
		wms_pick_height					, wms_pick_uom					, wms_pick_volumeuom		, wms_pick_volume			,
		wms_pick_weightuom				, wms_pick_thuweight			, wms_pick_customerserialno, wms_pick_warrantyserialno	, 
		wms_pick_shelflife				, wms_pick_counted_blnceqty		, wms_pick_staging_id		, wms_pick_source_thu_id	, 
		wms_pick_source_thu_serial_no	, wms_pick_cross_dk_staging_id	, wms_pick_stock_status		, wms_pick_box_thu_id		, 
		wms_pick_box_no					, wms_pick_outbound_no			, wms_pick_customer_code	, wms_pick_customer_item_code, 
		wms_warranty_serial_no			, wms_gift_card_serial_no		, wms_pick_uom1				, wms_pick_su2				, 
		wms_pick_su_serial_no2			, wms_pp_chporcn_sell_bil_status, wms_pick_conso_pln_no		, wms_pick_line_complete_flag,
		wms_pick_multisu_reflineno		, wms_pick_orderuom				, wms_pick_masteruomqty		, wms_pick_orderqty			,
		wms_pick_item_attribute1		, wms_pick_item_attribute2		, wms_pick_item_attribute3	, wms_pick_item_attribute4	, 
		wms_pick_item_attribute5		, wms_pick_item_attribute6		, wms_pick_item_attribute7	, wms_pick_item_attribute8	,
		wms_pick_item_attribute9		, wms_pick_item_attribute10		, wms_pick_zone_su			, wms_pick_shrt_flag		, 
		wms_pick_line_status			, etlcreateddatetime
	FROM stg.stg_wms_pick_plan_dtl;
    END IF;
	
	ELSE	
		 p_errorid   := 0;
		 select 0 into inscnt;
       	 select 0 into updcnt;
		 select 0 into srccnt;	
		 
		 IF p_depsource IS NULL
		 THEN 
		 p_errordesc := 'The Dependent source cannot be NULL.';
		 ELSE
		 p_errordesc := 'The Dependent source '|| p_depsource || ' is not successfully executed. Please execute the source '|| p_depsource || ' then re-run the source '|| p_sourceid||'.';
		 END IF;
		 CALL ods.usp_etlerrorinsert(p_sourceid,p_targetobject,p_dataflowflag,p_batchid,p_taskname,'sp_ExceptionHandling',p_errorid,p_errordesc,NULL);
	END IF;

  
    EXCEPTION WHEN others THEN
        get stacked diagnostics
            p_errorid   = returned_sqlstate,
            p_errordesc = message_text;
    CALL ods.usp_etlerrorinsert(p_sourceid, p_targetobject, p_dataflowflag, p_batchid,p_taskname, 'sp_ExceptionHandling', p_errorid, p_errordesc, null);
       SELECT 0 INTO inscnt;
       SELECT 0 INTO updcnt;	
END;
$BODY$;
ALTER PROCEDURE dwh.usp_f_pickplandetails(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
